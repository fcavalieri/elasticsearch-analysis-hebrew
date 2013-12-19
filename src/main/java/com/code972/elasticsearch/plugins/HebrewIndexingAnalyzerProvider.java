package com.code972.elasticsearch.plugins;

import com.code972.elasticsearch.analysis.HebrewAnalyzer;
import org.elasticsearch.common.inject.Inject;
import org.elasticsearch.common.inject.assistedinject.Assisted;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.env.Environment;
import org.elasticsearch.index.Index;
import org.elasticsearch.index.analysis.AbstractIndexAnalyzerProvider;
import org.elasticsearch.index.settings.IndexSettings;

import java.io.IOException;

public class HebrewIndexingAnalyzerProvider extends AbstractIndexAnalyzerProvider<HebrewAnalyzer.HebrewIndexingAnalyzer> {
    private final HebrewAnalyzer.HebrewIndexingAnalyzer analyzer;

    @Inject
    public HebrewIndexingAnalyzerProvider(Index index, @IndexSettings Settings indexSettings, Environment env, @Assisted String name, @Assisted Settings settings) throws IOException {
        super(index, indexSettings, name, settings);
        analyzer = new HebrewAnalyzer.HebrewIndexingAnalyzer();
    }

    @Override
    public HebrewAnalyzer.HebrewIndexingAnalyzer get() {
        return analyzer;
    }
}
Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC217A6805
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 17:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjISP1T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjISP1T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 11:27:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F7F93;
        Tue, 19 Sep 2023 08:27:09 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ABFB066030BF;
        Tue, 19 Sep 2023 16:27:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695137228;
        bh=2jEbRBdj0yQgcAERAHc0+iGw8y5hMp6viTr59c8MhQ8=;
        h=From:To:Cc:Subject:Date:From;
        b=AMO7Efh87cuQ63p4ytCwVimcppjonpe8HZJxNoLe/GLFeVmcxE26Em2Er5xbNteBm
         MqN1Lt+kzhW9ZWx/xO/uG0KaFmlm1IAlLmaZ09dze3Ebm9jyU9/pFusZH5/mW/gHus
         /6uA/cv8PC/ShZa7wfmnJSIgxPPQWgH0P839PcaiusOQlNyNbK0cU0+Y+Ej0YAztmA
         FcvHkQv9VNZw9FFo66nYX2+XpSkVDdH4kj/F3nQZxMzaw6AtIE9nwvRRW0QqpbuFaR
         pPjSon57N4touuWBrzijaShWBJAQWWydRJ5J55OKs0xjJbWVf3gssY7mp4kJnnIAmi
         MrRWUpZgrajzw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] kselftest/alsa: pcm-test: Report cards declared in config but missing
Date:   Tue, 19 Sep 2023 11:26:21 -0400
Message-ID: <20230919152702.100617-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When parsing the configs, keep track of card configurations that match
the current system but haven't matched any card, and report those as
test failures as they represent that a card which was expected to be
present on the system is missing. This allows the configuration files to
not only be used to detect missing PCM devices (which is currently
possible) but also that the soundcard hasn't been registered at all.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 tools/testing/selftests/alsa/alsa-local.h |  10 +++
 tools/testing/selftests/alsa/conf.c       | 100 ++++++++++++----------
 tools/testing/selftests/alsa/pcm-test.c   |  10 +++
 3 files changed, 73 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/alsa/alsa-local.h b/tools/testing/selftests/alsa/alsa-local.h
index de030dc23bd1..29143ef52101 100644
--- a/tools/testing/selftests/alsa/alsa-local.h
+++ b/tools/testing/selftests/alsa/alsa-local.h
@@ -24,4 +24,14 @@ int conf_get_bool(snd_config_t *root, const char *key1, const char *key2, int de
 void conf_get_string_array(snd_config_t *root, const char *key1, const char *key2,
 			   const char **array, int array_size, const char *def);
 
+struct card_cfg_data {
+	int card;
+	snd_config_t *config;
+	const char *filename;
+	const char *config_id;
+	struct card_cfg_data *next;
+};
+
+extern struct card_cfg_data *conf_cards;
+
 #endif /* __ALSA_LOCAL_H */
diff --git a/tools/testing/selftests/alsa/conf.c b/tools/testing/selftests/alsa/conf.c
index 2f1685a3eae1..00925eb8d9f4 100644
--- a/tools/testing/selftests/alsa/conf.c
+++ b/tools/testing/selftests/alsa/conf.c
@@ -19,14 +19,7 @@
 
 #define SYSFS_ROOT "/sys"
 
-struct card_data {
-	int card;
-	snd_config_t *config;
-	const char *filename;
-	struct card_data *next;
-};
-
-static struct card_data *conf_cards;
+struct card_cfg_data *conf_cards;
 
 static const char *alsa_config =
 "ctl.hw {\n"
@@ -97,9 +90,9 @@ snd_config_t *get_alsalib_config(void)
 	return config;
 }
 
-static struct card_data *conf_data_by_card(int card, bool msg)
+static struct card_cfg_data *conf_data_by_card(int card, bool msg)
 {
-	struct card_data *conf;
+	struct card_cfg_data *conf;
 
 	for (conf = conf_cards; conf; conf = conf->next) {
 		if (conf->card == card) {
@@ -229,55 +222,31 @@ static bool sysfs_match(const char *sysfs_root, snd_config_t *config)
 	return iter > 0;
 }
 
-static bool test_filename1(int card, const char *filename, const char *sysfs_card_root)
+static void assign_card_config(int card, const char *sysfs_card_root)
 {
-	struct card_data *data, *data2;
-	snd_config_t *config, *sysfs_config, *card_config, *sysfs_card_config, *node;
-	snd_config_iterator_t i, next;
+	struct card_cfg_data *data;
+	snd_config_t *sysfs_card_config;
 
-	config = conf_load_from_file(filename);
-	if (snd_config_search(config, "sysfs", &sysfs_config) ||
-	    snd_config_get_type(sysfs_config) != SND_CONFIG_TYPE_COMPOUND)
-		ksft_exit_fail_msg("Missing global sysfs block in filename %s\n", filename);
-	if (snd_config_search(config, "card", &card_config) ||
-	    snd_config_get_type(card_config) != SND_CONFIG_TYPE_COMPOUND)
-		ksft_exit_fail_msg("Missing global card block in filename %s\n", filename);
-	if (!sysfs_match(SYSFS_ROOT, sysfs_config))
-		return false;
-	snd_config_for_each(i, next, card_config) {
-		node = snd_config_iterator_entry(i);
-		if (snd_config_search(node, "sysfs", &sysfs_card_config) ||
-		    snd_config_get_type(sysfs_card_config) != SND_CONFIG_TYPE_COMPOUND)
-			ksft_exit_fail_msg("Missing card sysfs block in filename %s\n", filename);
+	for (data = conf_cards; data; data = data->next) {
+		snd_config_search(data->config, "sysfs", &sysfs_card_config);
 		if (!sysfs_match(sysfs_card_root, sysfs_card_config))
 			continue;
-		data = malloc(sizeof(*data));
-		if (!data)
-			ksft_exit_fail_msg("Out of memory\n");
-		data2 = conf_data_by_card(card, false);
-		if (data2)
-			ksft_exit_fail_msg("Duplicate card '%s' <-> '%s'\n", filename, data2->filename);
+
 		data->card = card;
-		data->filename = filename;
-		data->config = node;
-		data->next = conf_cards;
-		conf_cards = data;
-		return true;
+		break;
 	}
-	return false;
 }
 
-static bool test_filename(const char *filename)
+static void assign_card_configs(void)
 {
 	char fn[128];
 	int card;
 
 	for (card = 0; card < 32; card++) {
 		snprintf(fn, sizeof(fn), "%s/class/sound/card%d", SYSFS_ROOT, card);
-		if (access(fn, R_OK) == 0 && test_filename1(card, filename, fn))
-			return true;
+		if (access(fn, R_OK) == 0)
+			assign_card_config(card, fn);
 	}
-	return false;
 }
 
 static int filename_filter(const struct dirent *dirent)
@@ -296,6 +265,41 @@ static int filename_filter(const struct dirent *dirent)
 	return 0;
 }
 
+static bool match_config(const char *filename)
+{
+	struct card_cfg_data *data;
+	snd_config_t *config, *sysfs_config, *card_config, *sysfs_card_config, *node;
+	snd_config_iterator_t i, next;
+
+	config = conf_load_from_file(filename);
+	if (snd_config_search(config, "sysfs", &sysfs_config) ||
+	    snd_config_get_type(sysfs_config) != SND_CONFIG_TYPE_COMPOUND)
+		ksft_exit_fail_msg("Missing global sysfs block in filename %s\n", filename);
+	if (snd_config_search(config, "card", &card_config) ||
+	    snd_config_get_type(card_config) != SND_CONFIG_TYPE_COMPOUND)
+		ksft_exit_fail_msg("Missing global card block in filename %s\n", filename);
+	if (!sysfs_match(SYSFS_ROOT, sysfs_config))
+		return false;
+	snd_config_for_each(i, next, card_config) {
+		node = snd_config_iterator_entry(i);
+		if (snd_config_search(node, "sysfs", &sysfs_card_config) ||
+		    snd_config_get_type(sysfs_card_config) != SND_CONFIG_TYPE_COMPOUND)
+			ksft_exit_fail_msg("Missing card sysfs block in filename %s\n", filename);
+
+		data = malloc(sizeof(*data));
+		if (!data)
+			ksft_exit_fail_msg("Out of memory\n");
+		data->filename = filename;
+		data->config = node;
+		data->card = -1;
+		if (snd_config_get_id(node, &data->config_id))
+			ksft_exit_fail_msg("snd_config_get_id failed for card\n");
+		data->next = conf_cards;
+		conf_cards = data;
+	}
+	return true;
+}
+
 void conf_load(void)
 {
 	const char *fn = "conf.d";
@@ -311,17 +315,19 @@ void conf_load(void)
 		if (filename == NULL)
 			ksft_exit_fail_msg("Out of memory\n");
 		sprintf(filename, "%s/%s", fn, namelist[j]->d_name);
-		if (test_filename(filename))
+		if (match_config(filename))
 			filename = NULL;
 		free(filename);
 		free(namelist[j]);
 	}
 	free(namelist);
+
+	assign_card_configs();
 }
 
 void conf_free(void)
 {
-	struct card_data *conf;
+	struct card_cfg_data *conf;
 
 	while (conf_cards) {
 		conf = conf_cards;
@@ -332,7 +338,7 @@ void conf_free(void)
 
 snd_config_t *conf_by_card(int card)
 {
-	struct card_data *conf;
+	struct card_cfg_data *conf;
 
 	conf = conf_data_by_card(card, true);
 	if (conf)
diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index c0a39818c5a4..de664dedb541 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -566,6 +566,7 @@ void *card_thread(void *data)
 int main(void)
 {
 	struct card_data *card;
+	struct card_cfg_data *conf;
 	struct pcm_data *pcm;
 	snd_config_t *global_config, *cfg;
 	int num_pcm_tests = 0, num_tests, num_std_pcm_tests;
@@ -583,6 +584,10 @@ int main(void)
 
 	find_pcms();
 
+	for (conf = conf_cards; conf; conf = conf->next)
+		if (conf->card < 0)
+			num_missing++;
+
 	num_std_pcm_tests = conf_get_count(default_pcm_config, "test", NULL);
 
 	for (pcm = pcm_list; pcm != NULL; pcm = pcm->next) {
@@ -598,6 +603,11 @@ int main(void)
 
 	ksft_set_plan(num_missing + num_pcm_tests);
 
+	for (conf = conf_cards; conf; conf = conf->next)
+		if (conf->card < 0)
+			ksft_test_result_fail("test.missing.%s.%s\n",
+					      conf->filename, conf->config_id);
+
 	for (pcm = pcm_missing; pcm != NULL; pcm = pcm->next) {
 		ksft_test_result(false, "test.missing.%d.%d.%d.%s\n",
 				 pcm->card, pcm->device, pcm->subdevice,
-- 
2.42.0


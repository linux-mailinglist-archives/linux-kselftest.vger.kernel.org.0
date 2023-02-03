Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332FE68A349
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 20:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjBCTxJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 14:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjBCTxI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 14:53:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E061AEF83;
        Fri,  3 Feb 2023 11:53:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AD2A61FE0;
        Fri,  3 Feb 2023 19:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AFDC433D2;
        Fri,  3 Feb 2023 19:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675453982;
        bh=BSLmn0A9P22soM3M6s7md+Zt2gKYzVNeldJ1mHhjQzU=;
        h=From:Date:Subject:To:Cc:From;
        b=Kc5oX7u6hyVZCQxFzQdg+1tZmfaiR8dPbKw4JBh7gdrnbk6BLeEmiexrsjjknV0ib
         bMPKLN/5o4ool7PZIXA5XkjToRDpWAe2OYFpEF+MdmndH3W9troBmOyk3YZHjb8Ir9
         R4v2ucVCITGoxPxiaOaSHxxR4CmTQAHw0gF4zC4SQVe9OPqJ+p2jqhWcTAm7CRf2iu
         y7E4Jp47hJz2EX6jebQqT25oJwHug6MrWmInuwlJwVCmn1bH/dEvsPKALRYlr95fDS
         +x8IiU2qtywcaLZw+lr8tpXNV3gPC/tlTVspmbNVQfP1wWXcFRdVK72ctgVnqXZSi6
         JAAJoXO/gkxpA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 03 Feb 2023 19:52:47 +0000
Subject: [PATCH] kselftest/alsa: Run PCM tests for multiple cards in
 parallel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-alsa-pcm-test-card-thread-v1-1-59941640ebba@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA5m3WMC/x2NywoCMQxFf2XI2kAfC9FfERdpGm1RO0NSVBjm3
 +24PBfOPSuYaBWD87SCyrtandsAf5iAC7W7YM2DIbgQXXAR6WmEC7+wi3Vk0oy9qFBGf0zRMUd
 3Yg/DT2SCSalx2R8+sz72eVG51e8/eblu2w+widr7ggAAAA==
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7329; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BSLmn0A9P22soM3M6s7md+Zt2gKYzVNeldJ1mHhjQzU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj3WYcqt5edjvNlnC9f3qNct3mPKEQXftw/dV6E1lr
 efCZ2gqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY91mHAAKCRAk1otyXVSH0NZPB/
 44vJ7O1kUdaox2DxzGaH+yc04UxF9sqPJNSZYIc2kILW8+t+XOJhVLIeggQBJRxgZwLi6ibQVgXCZz
 z+r5wgznXafENBOiyqTNJTwE1iIVARFeY9hesNCfxn56Q+fRDk/5yL0s0mkqYJA1l4FPwW+LAg2mxs
 9YKieYqD23bvr++Gw6Su2yGsrIlvLXXM9u5jVAQ9uuM9l6SGZYwTVQqGgJ+pCHVUrLlFRj4bzb2xEi
 Jat+ZTCiaG6q4ZdNouKA1EUcvdex9K5UlrA1eRYWZ1gvxSKc2afPwkGn4xWmrCulaCxj4OtjH7mZC4
 Hx7Ia4AS+x6o+08rskKWefnczl2ZB6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With each test taking 4 seconds the runtime of pcm-test can add up. Since
generally each card in the system is physically independent and will be
unaffected by what's going on with other cards we can mitigate this by
testing each card in parallel. Make a list of cards as we enumerate the
system and then start a thread for each, then join the threads to ensure
they have all finished. The threads each run the same tests we currently
run for each PCM on the card before exiting.

The list of PCMs is kept global since it helps with global operations
like working out our planned number of tests and identifying missing PCMs
and it seemed neater to check for PCMs on the right card in the card
thread than make every PCM loop iterate over cards as well.

We don't run per-PCM tests in parallel since in embedded systems it can
be the case that resources are shared between the PCMs and operations on
one PCM on a card may constrain what can be done on another PCM on the same
card leading to potentially unstable results.

We use a mutex to ensure that the reporting of results is serialised and we
don't have issues with anything like the current test number, we could do
this in the kselftest framework but it seems like this might cause problems
for other tests that are doing lower level testing and building in
constrained environments such as nolibc so this seems more sensible.

Note that the ordering of the tests can't be guaranteed as things stand,
this does not seem like a major problem since the numbering of tests often
changes as test programs are changed so results parsers are expected to
rely on the test name rather than the test numbers. We also now prefix the
machine generated test name when printing the description of the test since
this is logged before streaming starts.

On my two card desktop system this reduces the overall runtime by a
third.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/Makefile   |  2 +
 tools/testing/selftests/alsa/pcm-test.c | 80 +++++++++++++++++++++++++++++----
 2 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index 77fba3e498cc..901949db80ad 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -8,6 +8,8 @@ LDLIBS += -lasound
 endif
 CFLAGS += -L$(OUTPUT) -Wl,-rpath=./
 
+LDLIBS+=-lpthread
+
 OVERRIDE_TARGETS = 1
 
 TEST_GEN_PROGS := mixer-test pcm-test
diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 57d3f6dcb46b..58b525a4a32c 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -15,12 +15,21 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <assert.h>
+#include <pthread.h>
 
 #include "../kselftest.h"
 #include "alsa-local.h"
 
 typedef struct timespec timestamp_t;
 
+struct card_data {
+	int card;
+	pthread_t thread;
+	struct card_data *next;
+};
+
+struct card_data *card_list = NULL;
+
 struct pcm_data {
 	snd_pcm_t *handle;
 	int card;
@@ -36,6 +45,11 @@ struct pcm_data *pcm_list = NULL;
 int num_missing = 0;
 struct pcm_data *pcm_missing = NULL;
 
+snd_config_t *default_pcm_config;
+
+/* Lock while reporting results since kselftest doesn't */
+pthread_mutex_t results_lock = PTHREAD_MUTEX_INITIALIZER;
+
 enum test_class {
 	TEST_CLASS_DEFAULT,
 	TEST_CLASS_SYSTEM,
@@ -141,6 +155,7 @@ static void find_pcms(void)
 	snd_ctl_t *handle;
 	snd_pcm_info_t *pcm_info;
 	snd_config_t *config, *card_config, *pcm_config;
+	struct card_data *card_data;
 
 	snd_pcm_info_alloca(&pcm_info);
 
@@ -162,6 +177,13 @@ static void find_pcms(void)
 
 		card_config = conf_by_card(card);
 
+		card_data = calloc(1, sizeof(*card_data));
+		if (!card_data)
+			ksft_exit_fail_msg("Out of memory\n");
+		card_data->card = card;
+		card_data->next = card_list;
+		card_list = card_data;
+
 		dev = -1;
 		while (1) {
 			if (snd_ctl_pcm_next_device(handle, &dev) < 0)
@@ -246,10 +268,6 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 	bool skip = true;
 	const char *desc;
 
-	desc = conf_get_string(pcm_cfg, "description", NULL, NULL);
-	if (desc)
-		ksft_print_msg("%s\n", desc);
-
 	switch (class) {
 	case TEST_CLASS_DEFAULT:
 		test_class_name = "default";
@@ -262,6 +280,15 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 		break;
 	}
 
+	desc = conf_get_string(pcm_cfg, "description", NULL, NULL);
+	if (desc)
+		ksft_print_msg("%s.%s.%d.%d.%d.%s - %s\n",
+			       test_class_name, test_name,
+			       data->card, data->device, data->subdevice,
+			       snd_pcm_stream_name(data->stream),
+			       desc);
+
+
 	snd_pcm_hw_params_alloca(&hw_params);
 	snd_pcm_sw_params_alloca(&sw_params);
 
@@ -443,6 +470,8 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 	msg[0] = '\0';
 	pass = true;
 __close:
+	pthread_mutex_lock(&results_lock);
+
 	switch (class) {
 	case TEST_CLASS_SYSTEM:
 		test_class_name = "system";
@@ -471,6 +500,9 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 				 data->card, data->device, data->subdevice,
 				 snd_pcm_stream_name(data->stream),
 				 msg[0] ? " " : "", msg);
+
+	pthread_mutex_unlock(&results_lock);
+
 	free(samples);
 	if (handle)
 		snd_pcm_close(handle);
@@ -502,11 +534,30 @@ void run_time_tests(struct pcm_data *pcm, enum test_class class,
 	}
 }
 
+void *card_thread(void *data)
+{
+	struct card_data *card = data;
+	struct pcm_data *pcm;
+
+	for (pcm = pcm_list; pcm != NULL; pcm = pcm->next) {
+		if (pcm->card != card->card)
+			continue;
+
+		run_time_tests(pcm, TEST_CLASS_DEFAULT, default_pcm_config);
+		run_time_tests(pcm, TEST_CLASS_SYSTEM, pcm->pcm_config);
+	}
+
+	return 0;
+}
+
 int main(void)
 {
+	struct card_data *card;
 	struct pcm_data *pcm;
-	snd_config_t *global_config, *default_pcm_config, *cfg, *pcm_cfg;
+	snd_config_t *global_config, *cfg, *pcm_cfg;
 	int num_pcm_tests = 0, num_tests, num_std_pcm_tests;
+	int ret;
+	void *thread_ret;
 
 	ksft_print_header();
 
@@ -540,9 +591,22 @@ int main(void)
 				 snd_pcm_stream_name(pcm->stream));
 	}
 
-	for (pcm = pcm_list; pcm != NULL; pcm = pcm->next) {
-		run_time_tests(pcm, TEST_CLASS_DEFAULT, default_pcm_config);
-		run_time_tests(pcm, TEST_CLASS_SYSTEM, pcm->pcm_config);
+	for (card = card_list; card != NULL; card = card->next) {
+		ret = pthread_create(&card->thread, NULL, card_thread, card);
+		if (ret != 0) {
+			ksft_exit_fail_msg("Failed to create card %d thread: %d (%s)\n",
+					   card->card, ret,
+					   strerror(errno));
+		}
+	}
+
+	for (card = card_list; card != NULL; card = card->next) {
+		ret = pthread_join(card->thread, &thread_ret);
+		if (ret != 0) {
+			ksft_exit_fail_msg("Failed to join card %d thread: %d (%s)\n",
+					   card->card, ret,
+					   strerror(errno));
+		}
 	}
 
 	snd_config_delete(global_config);

---
base-commit: 372a0d7856be29671fc03e2f28ac27114e8c6805
change-id: 20230203-alsa-pcm-test-card-thread-17b30cc309c1

Best regards,
-- 
Mark Brown <broonie@kernel.org>


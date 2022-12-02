Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8A663FD03
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 01:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiLBA1P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 19:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiLBA02 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 19:26:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B566317D7
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 16:21:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D85BA621D2
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 00:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6FEC433D7;
        Fri,  2 Dec 2022 00:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669940488;
        bh=xM72S9RCtumzTMDAzQRoqiJbjv0iOLzdTFKbCIv6+tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eRTMZNslFYjgxOiyn43bu9kUJhAoELNHqlW/5G5t9mZZj+Oe209QnvG9nSG4jkpE2
         A/41Y8aSlLichCadxL5MkGcnOHXAJ8hpG6QHK4pBnKNJJn4uXU3Nqp7ErBsIcmFF2a
         SHN0E7PlLuCLVRGg+kBH5b63rvFABYdjz17/24V+qkP+XZDa4YlVia03rN3B1H/khQ
         fQvMvc9APNBvSL8FoYoXWSkuGhpoJ8V5+68u9JxGONCqMZLRKpnR8W8Sa1sHQzeHDF
         Qhk6rr3g4Jhe9HLdxm1kzeEP0dAAcc2UtMgi4xOgTmabNftX4lQ0HH490b7xQRzpaZ
         HFWrOYylzOgbQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 4/7] kselftest/alsa: pcm - skip tests when we fail to set params
Date:   Fri,  2 Dec 2022 00:17:46 +0000
Message-Id: <20221202001749.3321187-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202001749.3321187-1-broonie@kernel.org>
References: <20221202001749.3321187-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3156; i=broonie@kernel.org; h=from:subject; bh=xM72S9RCtumzTMDAzQRoqiJbjv0iOLzdTFKbCIv6+tk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiUQpMTnE2tYxkvT9IJiGFReql/viP2++U9qyvEl4 jkU4p+6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4lEKQAKCRAk1otyXVSH0BhmB/ 9p4SNkOb8QReTY9iSBl6XFTYCXxvoEK+g7u/IA7Xz2BpG77L9CEKb3rVjvUOksXFDn1okj83bEq3bD KjN3/HkV2hnvysUdPhrp8DWsaTzA+zcQ50iwNCafJQcCENBe5qIVG0Cq5AJE0Rg+FFq+P3oFsZGLkA ZkS8XkSipyq6VwU6hxEPy+KhfeudZMde+yAaNfJWUoEeDvRAWLXONyaRKyrN03wyDcUJZxrFtz+MDt zSqT8A3PkUchBtMkXPr89gjxan3FFn8Dm8gqwg5b/SrkOlNi+uWx8WdleE0YoWWttwX7N3tueoWwxw xM2wGjJZ0ae03mSLVZbZOce8WY9B1x
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since we don't know what the capabilities of an unknown card is any of our
standard tests may fail due to not being supported by the system. Set a
flag once we've configured the stream, just before we start data, to say
that the system accepted our stream configuration.

Since there shouldn't be a use case for tests that are specified for the
individual system failing for those tests we also add a new test which
fails if we are unable to configure the settings specified in the system
specific configuration file.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 39 +++++++++++++++++++++----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index afc616ddc820..5fbb3ff517aa 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -243,6 +243,7 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 	snd_pcm_hw_params_t *hw_params;
 	snd_pcm_sw_params_t *sw_params;
 	const char *test_class_name;
+	bool skip = true;
 
 	switch (class) {
 	case TEST_CLASS_DEFAULT:
@@ -395,6 +396,9 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 			 (long)rperiod_size, (long)rbuffer_size,
 			 (long)start_threshold);
 
+	/* Set all the params, actually run the test */
+	skip = false;
+
 	timestamp_now(&tstamp);
 	for (i = 0; i < 4; i++) {
 		if (data->stream == SND_PCM_STREAM_PLAYBACK) {
@@ -434,12 +438,34 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 	msg[0] = '\0';
 	pass = true;
 __close:
+	switch (class) {
+	case TEST_CLASS_SYSTEM:
+		test_class_name = "system";
+		/*
+		 * Anything specified as specific to this system
+		 * should always be supported.
+		 */
+		ksft_test_result(!skip, "%s.%s.%d.%d.%d.%s.params\n",
+				 test_class_name, test_name,
+				 data->card, data->device, data->subdevice,
+				 snd_pcm_stream_name(data->stream));
+		break;
+	default:
+		break;
+	}
 
-	ksft_test_result(pass, "%s.%s.%d.%d.%d.%s%s%s\n",
-			 test_class_name, test_name,
-			 data->card, data->device, data->subdevice,
-			 snd_pcm_stream_name(data->stream),
-			 msg[0] ? " " : "", msg);
+	if (!skip)
+		ksft_test_result(pass, "%s.%s.%d.%d.%d.%s%s%s\n",
+				 test_class_name, test_name,
+				 data->card, data->device, data->subdevice,
+				 snd_pcm_stream_name(data->stream),
+				 msg[0] ? " " : "", msg);
+	else
+		ksft_test_result_skip("%s.%s.%d.%d.%d.%s%s%s\n",
+				 test_class_name, test_name,
+				 data->card, data->device, data->subdevice,
+				 snd_pcm_stream_name(data->stream),
+				 msg[0] ? " " : "", msg);
 	free(samples);
 	if (handle)
 		snd_pcm_close(handle);
@@ -495,7 +521,8 @@ int main(void)
 		cfg = pcm->pcm_config;
 		if (cfg == NULL)
 			continue;
-		num_tests = conf_get_count(cfg, "test", NULL);
+		/* Setting params is reported as a separate test */
+		num_tests = conf_get_count(cfg, "test", NULL) * 2;
 		if (num_tests > 0)
 			num_pcm_tests += num_tests;
 	}
-- 
2.30.2


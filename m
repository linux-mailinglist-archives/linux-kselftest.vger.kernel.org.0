Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2035A656D3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiL0RHi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 12:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiL0RH3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 12:07:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548E9B483;
        Tue, 27 Dec 2022 09:07:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB594611BC;
        Tue, 27 Dec 2022 17:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4671C43392;
        Tue, 27 Dec 2022 17:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672160847;
        bh=rLgMnEoCh4Po4vgPePrdSWrV7l9PvGVlzfYwGi2W6N8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=MdAqPm+d4i9GvZ9jYcEtnjrKfHQT+SHwkbVsSo6/txIZUZU+/koqXShl2czBWcwLY
         1Gma+zgv7yUgHy9U1C0NZ2gSu5IujjVjJXMuieb9HkRORm1sM4GwSOKleqB2rxlgPs
         G/hvt9BNT3/Yux3WYU5dxysHIHyl52G5C+h1Nx81puVCtB12+d0XeiW/prs1LiskKN
         aF2tmv4ZZpD+s+26dpTfy1Hq4gpZkKaPtJSy8JUMkTbo0cRs0p6kKTNuZ2wokLRgAa
         RQRl93tM7RIhYj4vFgsWWybi1HaDNDr+zgSlLApyFdVHvezhue5P7MnyM24HTlHSBC
         alLQZcbVvkOQw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 17:06:49 +0000
Subject: [PATCH v4 4/7] kselftest/alsa: pcm - skip tests when we fail to set params
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-alsa-pcm-test-hacks-v4-4-5a152e65b1e1@kernel.org>
References: <20221208-alsa-pcm-test-hacks-v4-0-5a152e65b1e1@kernel.org>
In-Reply-To: <20221208-alsa-pcm-test-hacks-v4-0-5a152e65b1e1@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=3296; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rLgMnEoCh4Po4vgPePrdSWrV7l9PvGVlzfYwGi2W6N8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqyZCA6KmbKb+V4cZOVDCWU4CaQ4v0Yda63HYpsl5
 FKmUTRCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6smQgAKCRAk1otyXVSH0BuaB/
 4tG5bK7jC3pNwSraJ8nHV7MboM/RcCC/WeIZNx3KG9H/LXvtTetSimPXggI0IAOaHxZ+JF0QgTSTpK
 zyzJDCFNpTs/Wo669/1U601o5lZE1glydpXhZAY5nP6Q2yDFlzHxtPT1JkthCLk2YvESnf0q3xBeFu
 Tmov+5DIEmbOqtJ7iNvABnYlO/su4ghpI/jFoP1L7CDdn8Wp2PAHOfT/ov2uH9HhE4yJ2P6w3tA9qm
 wC6r+TmFs6Ff6niDCa73j9r7lMgHbg1RHEJFL1GGyg6umrkiOX5u7NVxc0i1BXS64x8PhAPULU2GjX
 m/G7+VOw9Ya4fckJx0WfZvws68N/n1
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

Since we don't know what the capabilities of an unknown card is any of our
standard tests may fail due to not being supported by the system. Set a
flag once we've configured the stream, just before we start data, to say
that the system accepted our stream configuration.

Since there shouldn't be a use case for tests that are specified for the
individual system failing for those tests we also add a new test which
fails if we are unable to configure the settings specified in the system
specific configuration file.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 39 ++++++++++++++++++++++++++++--
---
 tools/testing/selftests/alsa/pcm-test.c | 39 ++++++++++++++++++++++++++++-----
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

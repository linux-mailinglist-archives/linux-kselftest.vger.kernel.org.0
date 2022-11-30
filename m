Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA69663CC2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 01:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiK3AHO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 19:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiK3AHA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 19:07:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E898D7044E
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 16:06:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81EF1617EB
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 00:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891E8C43470;
        Wed, 30 Nov 2022 00:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669766818;
        bh=QUtBBASg/fKretMAe1LPjLOjq07MO6kbUGOnoUTWAv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmGpS2fX5Ikyv51CFBimH2R7P0/hdDUyl+rzWBTEzw6B8l4eTdDB04bGKEHQhtnHM
         jf3Y1xOSqf8YdPYkRjJ9N2h3nozmZUwSGZHyvmMRZpKAx6gE7bwcCg1n3h7pKrgDC2
         yKjNHTj70nNsbvJJKak0Z1LJN6TiNcrgJUntMMFk4CFADgAjpI0iSng2z2LYl7OT2t
         5OzVKhlgkd5tskibxmx5FXOPm0QSS9dnV6o0wjJGacNlHNEUlI26gqU1IUC4Kt9UTV
         JA2TUtcTyA57EDnCz5FKQKtiGDmHgVcnbYW0GGvjL0QVlIu+9Yi91hHsQgZY+VEa4C
         DQhkpq1QRGOeQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/6] kselftest/alsa: Report failures to set the requested channels as skips
Date:   Wed, 30 Nov 2022 00:06:05 +0000
Message-Id: <20221130000608.519574-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130000608.519574-1-broonie@kernel.org>
References: <20221130000608.519574-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=broonie@kernel.org; h=from:subject; bh=QUtBBASg/fKretMAe1LPjLOjq07MO6kbUGOnoUTWAv8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhp5ttNhH9uQpLtwxgl96s5h1BSi/oaLbUpM4fPV+ akujv3eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4aebQAKCRAk1otyXVSH0AJoB/ 4p3oUv164HbGjiICneo1d/wFxHYM0WQ0qEO1zPcQ+vVQvEKY8a0roAUSWM0bVt/G/fgozvKoyHF/0c JiWDu/AGqh4dy0xZOEPxXlSO6DibPMiu4rjBg5ZhGNmflkmWnPqF+BpQrLHSTq4exme9F5s6DL6ynN GvM/WAzK9+u5+DoAPbkenLgt8N6QES+S2t7fsTchzMHAXwAB+CjVxcywBxSXR78xn/RpbtQkJw1W7t o283rPIzMGDfHKZpWCq7RMM9dKalrRiJgOrMBfvfX+kJ4mdjkHQvG3owTOuMG+qRrkb0B2Pz/nJTdb DMOlBEI46/hWzg0Dls5aKrzU34HaSE
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

If constraint selection gives us a number of channels other than the one
that we asked for that isn't a failure, that is the device implementing
constraints and advertising that it can't support whatever we asked
for. Report such cases as a test skip rather than failure so we don't have
false positives.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 6a9e4af828ee..bc0cb3c481f2 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -311,6 +311,7 @@ static void test_pcm_time1(struct pcm_data *data,
 	snd_pcm_sframes_t frames;
 	long long ms;
 	long rate, channels, period_size, buffer_size;
+	unsigned int rchannels;
 	unsigned int rrate;
 	snd_pcm_uframes_t rperiod_size, rbuffer_size, start_threshold;
 	timestamp_t tstamp;
@@ -380,11 +381,17 @@ static void test_pcm_time1(struct pcm_data *data,
 					   snd_pcm_format_name(format), snd_strerror(err));
 		goto __close;
 	}
-	err = snd_pcm_hw_params_set_channels(handle, hw_params, channels);
+	rchannels = channels;
+	err = snd_pcm_hw_params_set_channels_near(handle, hw_params, &rchannels);
 	if (err < 0) {
 		snprintf(msg, sizeof(msg), "snd_pcm_hw_params_set_channels %ld: %s", channels, snd_strerror(err));
 		goto __close;
 	}
+	if (rchannels != channels) {
+		snprintf(msg, sizeof(msg), "channels unsupported %ld != %ld", channels, rchannels);
+		skip = true;
+		goto __close;
+	}
 	rrate = rate;
 	err = snd_pcm_hw_params_set_rate_near(handle, hw_params, &rrate, 0);
 	if (err < 0) {
-- 
2.30.2


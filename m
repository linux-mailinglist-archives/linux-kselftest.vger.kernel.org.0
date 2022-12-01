Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A023E63F5F8
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 18:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLARLD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 12:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLARLC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 12:11:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C238A897B
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 09:11:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 249FC62095
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 17:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284BBC43470;
        Thu,  1 Dec 2022 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669914660;
        bh=Ea1T10TIvTWq1qGzKDGwlwL7b3yoxRpm/4uRvtv+CWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WuHnmiUCo8afADDANn9QgPs8GQ7RgKXk3JWzyqJgkXzRW80BMnfJEL8QGFApZlUZX
         G6Mtsue/khwntl0RreET6tboa7twAFk7tY57wyHnJ4KdwiDByjFs2xew/Ywlu0i0D3
         8Bjx2+rroobbTv6y2p7pdvDLLJdBL6oJmgVpfuxJt0VqS82/SnTb6tfvfIT4wfTrvb
         s5WVnm7znQoqVGAFkmtg9cWgCJRPP1HPBZVpYqaTqcXxEBX1iEqVqx094+I6ns6dnc
         rgZw8I2bRIiueukYlKO5B2EOw8Uu+TcPtMiEdu/6/fKmeNdNWZch9WLBzWaD7uE1gO
         QXZ4mPwNZKvaA==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/6] kselftest/alsa: Report failures to set the requested channels as skips
Date:   Thu,  1 Dec 2022 17:07:42 +0000
Message-Id: <20221201170745.1111236-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201170745.1111236-1-broonie@kernel.org>
References: <20221201170745.1111236-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=broonie@kernel.org; h=from:subject; bh=Ea1T10TIvTWq1qGzKDGwlwL7b3yoxRpm/4uRvtv+CWo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiN9eR7uP9EzG5VK5o5gRFLzZsY2kfcSSreuW3Kux n6kDJHSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4jfXgAKCRAk1otyXVSH0Fa+B/ 0VJdL2Vj+N0HWUPKMqKb9QvaC/cIsB254npMyUlxVqfzBdfLS0TCgDo1traEiYk8bcVSgYcUgcw7wD /smZpJa/v6xrSZOTATC7u2Cxk/rVv4/Co16BmC5HoPuM4dyW1W5XVcCMXDsobhe6KSw7KdzSYP/ING ETTjuBZydaNvgK+3hQ1Q0J/2J+tltCVGN3no7lTGg7slXd3WD6G7TpRNGL+BwDCLIoskPoanvrFk1M HA79t9MnREVaHgSbmLNqULIWNIfXbzFKE/cR8fRk/lrbfncz66mIy2uPITBYb6ADQhl8gG7l/Nz9Bv pHZSsQH7bc3RbCwCeIyOXp07C49koY
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
index edb820fe2ee6..c701cf507a95 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -241,6 +241,7 @@ static void test_pcm_time1(struct pcm_data *data,
 	snd_pcm_sframes_t frames;
 	long long ms;
 	long rate, channels, period_size, buffer_size;
+	unsigned int rchannels;
 	unsigned int rrate;
 	snd_pcm_uframes_t rperiod_size, rbuffer_size, start_threshold;
 	timestamp_t tstamp;
@@ -310,11 +311,17 @@ static void test_pcm_time1(struct pcm_data *data,
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


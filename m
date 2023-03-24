Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC316C822B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 17:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCXQM4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 12:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXQMz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 12:12:55 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 09:12:53 PDT
Received: from qs51p00im-qukt01071702.me.com (qs51p00im-qukt01071702.me.com [17.57.155.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC38919699
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alexanderheinrich.de; s=sig1; t=1679673771;
        bh=WA7S6ZvTYQ6luSPw10U7xe5lrYgnhlkjN4sbsAQmXk8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Is+U/HvsFkPjrZ5Pfx/zKMG3sarbhHGJPSbuMDON9sU6Kk8NrBa9bmTB1BRcHaw04
         ORTgOOW3GVKdGIDwE3NjfrdHWnrq81i0IN5uWvBnaOQ/hZ4VT8ivisknlltF4+MhRt
         3Y8Caui8Owl6FeLP2JMTSOtg6ofKX6AjMKeTFWZo/3OQiumVZCYO84Ybr3x7Q9Z5SS
         P7XvCTYZXQpY5/o+9W/uV20lDViqt+ZouFxzet3zqK/6z7K57FEJSlyl5GBJPl0Ptt
         aYJqSK7B+zAd0Ik2EikUgVER14yeBU6OjQsJ2EOUcDI3X6JGHRpRCZsc7/HvhV7kSp
         7do/P6nMa1RVQ==
Received: from pop-os.fritz.box (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01071702.me.com (Postfix) with ESMTPSA id C144635018B9;
        Fri, 24 Mar 2023 16:02:48 +0000 (UTC)
From:   Alexander Heinrich <hallo@alexanderheinrich.de>
To:     tiwai@suse.de
Cc:     Alexander Heinrich <hallo@alexanderheinrich.de>,
        broonie@kernel.org, perex@perex.cz, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] kselftest/alsa: Fix -Wformat compiler warnings
Date:   Fri, 24 Mar 2023 17:01:58 +0100
Message-Id: <20230324160158.4076-1-hallo@alexanderheinrich.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gmt5rTcaZmiePQ-5PdAefwWpp_I_jnzC
X-Proofpoint-ORIG-GUID: gmt5rTcaZmiePQ-5PdAefwWpp_I_jnzC
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1030 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2303240127
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix compiler warnings caused by mixing long and unsigned int values:
Change type of variables rate, channels, period_size and buffer_size to
unsigned int (as used by rrate).

Signed-off-by: Alexander Heinrich <hallo@alexanderheinrich.de>
---
Hi Takashi,
Thank you for your feedback on my first version of the patch!
I have changed the variables to unsigned int, removed the casts and
changed the relevant format specifiers to %d.

This produced a new warnings in two places, where the 'rate' and 'channels' 
variables were being multiplied with 'snd_pcm_format_physical_width()', because
this function returns an int (and can return a negative value on failure).
I added a check for negative values, so that the return value can safely
be cast to unsigned int.

For the string to int conversion functions, the return values for the test cases
in pcm-test.conf are non-negative and in the range of unsigned int, so I just
cast them to unsigned int.

Please let me know if I can further improve on my patch (it is my first)!
Thanks and greetings,
Alex

 tools/testing/selftests/alsa/pcm-test.c | 41 ++++++++++++++-----------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 3e390fe67eb9..d4420789837c 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -259,7 +259,7 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 {
 	char name[64], key[128], msg[256];
 	const char *cs;
-	int i, err;
+	int i, err, phys_width;
 	snd_pcm_t *handle = NULL;
 	snd_pcm_access_t access = SND_PCM_ACCESS_RW_INTERLEAVED;
 	snd_pcm_format_t format, old_format;
@@ -267,8 +267,7 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 	unsigned char *samples = NULL;
 	snd_pcm_sframes_t frames;
 	long long ms;
-	long rate, channels, period_size, buffer_size;
-	unsigned int rrate;
+	unsigned int rate, channels, period_size, buffer_size, rrate;
 	snd_pcm_uframes_t rperiod_size, rbuffer_size, start_threshold;
 	timestamp_t tstamp;
 	bool pass = false;
@@ -308,12 +307,15 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 		ksft_exit_fail_msg("Wrong format '%s'\n", cs);
 	conf_get_string_array(pcm_cfg, "alt_formats", NULL,
 				alt_formats, ARRAY_SIZE(alt_formats), NULL);
-	rate = conf_get_long(pcm_cfg, "rate", NULL, 48000);
-	channels = conf_get_long(pcm_cfg, "channels", NULL, 2);
-	period_size = conf_get_long(pcm_cfg, "period_size", NULL, 4096);
-	buffer_size = conf_get_long(pcm_cfg, "buffer_size", NULL, 16384);
-
-	samples = malloc((rate * channels * snd_pcm_format_physical_width(format)) / 8);
+	rate = (unsigned int)conf_get_long(pcm_cfg, "rate", NULL, 48000);
+	channels = (unsigned int)conf_get_long(pcm_cfg, "channels", NULL, 2);
+	period_size = (unsigned int)conf_get_long(pcm_cfg, "period_size", NULL, 4096);
+	buffer_size = (unsigned int)conf_get_long(pcm_cfg, "buffer_size", NULL, 16384);
+
+	phys_width = snd_pcm_format_physical_width(format);
+	if (phys_width < 0)
+		ksft_exit_fail_msg("Unknown PCM format\n");
+	samples = malloc((rate * channels * (unsigned int)phys_width) / 8);
 	if (!samples)
 		ksft_exit_fail_msg("Out of memory\n");
 	snd_pcm_format_set_silence(format, samples, rate * channels);
@@ -357,8 +359,11 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 						 snd_pcm_access_name(access),
 						 snd_pcm_format_name(old_format),
 						 snd_pcm_format_name(format));
+				phys_width = snd_pcm_format_physical_width(format);
+				if (phys_width < 0)
+					ksft_exit_fail_msg("Unknown PCM format\n");
 				samples = realloc(samples, (rate * channels *
-							    snd_pcm_format_physical_width(format)) / 8);
+								  (unsigned int)phys_width) / 8);
 				if (!samples)
 					ksft_exit_fail_msg("Out of memory\n");
 				snd_pcm_format_set_silence(format, samples, rate * channels);
@@ -371,29 +376,29 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 	}
 	err = snd_pcm_hw_params_set_channels(handle, hw_params, channels);
 	if (err < 0) {
-		snprintf(msg, sizeof(msg), "snd_pcm_hw_params_set_channels %ld: %s", channels, snd_strerror(err));
+		snprintf(msg, sizeof(msg), "snd_pcm_hw_params_set_channels %d: %s", channels, snd_strerror(err));
 		goto __close;
 	}
 	rrate = rate;
 	err = snd_pcm_hw_params_set_rate_near(handle, hw_params, &rrate, 0);
 	if (err < 0) {
-		snprintf(msg, sizeof(msg), "snd_pcm_hw_params_set_rate %ld: %s", rate, snd_strerror(err));
+		snprintf(msg, sizeof(msg), "snd_pcm_hw_params_set_rate %d: %s", rate, snd_strerror(err));
 		goto __close;
 	}
 	if (rrate != rate) {
-		snprintf(msg, sizeof(msg), "rate mismatch %ld != %ld", rate, rrate);
+		snprintf(msg, sizeof(msg), "rate mismatch %d != %d", rate, rrate);
 		goto __close;
 	}
 	rperiod_size = period_size;
 	err = snd_pcm_hw_params_set_period_size_near(handle, hw_params, &rperiod_size, 0);
 	if (err < 0) {
-		snprintf(msg, sizeof(msg), "snd_pcm_hw_params_set_period_size %ld: %s", period_size, snd_strerror(err));
+		snprintf(msg, sizeof(msg), "snd_pcm_hw_params_set_period_size %d: %s", period_size, snd_strerror(err));
 		goto __close;
 	}
 	rbuffer_size = buffer_size;
 	err = snd_pcm_hw_params_set_buffer_size_near(handle, hw_params, &rbuffer_size);
 	if (err < 0) {
-		snprintf(msg, sizeof(msg), "snd_pcm_hw_params_set_buffer_size %ld: %s", buffer_size, snd_strerror(err));
+		snprintf(msg, sizeof(msg), "snd_pcm_hw_params_set_buffer_size %d: %s", buffer_size, snd_strerror(err));
 		goto __close;
 	}
 	err = snd_pcm_hw_params(handle, hw_params);
@@ -428,14 +433,14 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 		goto __close;
 	}
 
-	ksft_print_msg("%s.%s.%d.%d.%d.%s hw_params.%s.%s.%ld.%ld.%ld.%ld sw_params.%ld\n",
+	ksft_print_msg("%s.%s.%d.%d.%d.%s hw_params.%s.%s.%d.%d.%d.%d sw_params.%ld\n",
 		         test_class_name, test_name,
 			 data->card, data->device, data->subdevice,
 			 snd_pcm_stream_name(data->stream),
 			 snd_pcm_access_name(access),
 			 snd_pcm_format_name(format),
-			 (long)rate, (long)channels,
-			 (long)rperiod_size, (long)rbuffer_size,
+			 rate, channels,
+			 rperiod_size, rbuffer_size,
 			 (long)start_threshold);
 
 	/* Set all the params, actually run the test */
-- 
2.34.1


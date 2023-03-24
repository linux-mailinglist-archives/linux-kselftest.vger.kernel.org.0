Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3D86C7BA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 10:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjCXJiv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 05:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjCXJi1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 05:38:27 -0400
X-Greylist: delayed 565 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 02:37:46 PDT
Received: from mr85p00im-hyfv06021301.me.com (mr85p00im-hyfv06021301.me.com [17.58.23.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBA424BC5
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 02:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alexanderheinrich.de; s=sig1; t=1679650100;
        bh=dSIP2LzeNErC/REZ3YYpHWBfpceHVAG0VrcUXi0c7wY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=GtP+R4U+2NT6YZdtXGqJulgPkAHBuNGn3Nb8kzJNC8DXNJVLJyWEzivdAPX0xobkB
         27w3dyp+ms2VNX00yvYIqDu9fW4UJh1lRyRAfBApfXYim3KhSrnAwCtq7gcMWXOG5y
         ZSSF1LtdlQGM7W3c4VwViisRLBcVFlC7PVGXX2uek+1euao5KUfOn8I0cgtv2yG/6p
         I1G1yP8nGUAtZH9gim/ScJQl6FaSX5XvqGPM6eRWNhnBF1MfZlP2NvF902Lt5WvbT4
         cJeQIi7rfy5lUM4ctaSHQzkD2GjxtEGKJh9/6UGCN/U9cZf9BzrojTIV4EYq6TQB2K
         sOIdYYS+ifTSg==
Received: from pop-os.fritz.box (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-hyfv06021301.me.com (Postfix) with ESMTPSA id BC7EE2153DBB;
        Fri, 24 Mar 2023 09:28:17 +0000 (UTC)
From:   Alexander Heinrich <hallo@alexanderheinrich.de>
To:     broonie@kernel.org
Cc:     Alexander Heinrich <hallo@alexanderheinrich.de>, perex@perex.cz,
        tiwai@suse.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] kselftest/alsa: Fix -Wformat compiler warnings
Date:   Fri, 24 Mar 2023 10:28:06 +0100
Message-Id: <20230324092806.363253-1-hallo@alexanderheinrich.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: E8rPtdu249mJUmVqZ_fGbtucqjEIp1pk
X-Proofpoint-ORIG-GUID: E8rPtdu249mJUmVqZ_fGbtucqjEIp1pk
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=472 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1030 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2303240078
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I noticed some -Wformat compiler warnings in pcm-test.c while building
kselftest, fix them by using the same types for format specifier and arguments.

Signed-off-by: Alexander Heinrich <hallo@alexanderheinrich.de>
---
 tools/testing/selftests/alsa/pcm-test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 58b525a4a32c..44fc5f826ab5 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -371,7 +371,7 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 		goto __close;
 	}
 	if (rrate != rate) {
-		snprintf(msg, sizeof(msg), "rate mismatch %ld != %ld", rate, rrate);
+		snprintf(msg, sizeof(msg), "rate mismatch %ld != %d", rate, rrate);
 		goto __close;
 	}
 	rperiod_size = period_size;
@@ -437,24 +437,24 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 			frames = snd_pcm_writei(handle, samples, rate);
 			if (frames < 0) {
 				snprintf(msg, sizeof(msg),
-					 "Write failed: expected %d, wrote %li", rate, frames);
+					 "Write failed: expected %ld, wrote %li", rate, frames);
 				goto __close;
 			}
 			if (frames < rate) {
 				snprintf(msg, sizeof(msg),
-					 "expected %d, wrote %li", rate, frames);
+					 "expected %ld, wrote %li", rate, frames);
 				goto __close;
 			}
 		} else {
 			frames = snd_pcm_readi(handle, samples, rate);
 			if (frames < 0) {
 				snprintf(msg, sizeof(msg),
-					 "expected %d, wrote %li", rate, frames);
+					 "expected %ld, wrote %li", rate, frames);
 				goto __close;
 			}
 			if (frames < rate) {
 				snprintf(msg, sizeof(msg),
-					 "expected %d, wrote %li", rate, frames);
+					 "expected %ld, wrote %li", rate, frames);
 				goto __close;
 			}
 		}
-- 
2.34.1


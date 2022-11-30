Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C408363CC2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 01:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiK3AHP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 19:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiK3AHG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 19:07:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7283E7044E
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 16:07:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F40C61981
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 00:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1194FC4347C;
        Wed, 30 Nov 2022 00:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669766824;
        bh=SZHDVz1meOtVOiMtc7gqDxDlymHtQ6CtxKd4qfqfgaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPhFm/Rzn35CIuHoM6Kgsoh5DKPiQHfbzJx5SwxcOGOneYc9CYHFA7bk0L3nxELuA
         T6YLnzy0TSak9OyZFGt/JuT2uwToUhZ58/6dRIEQV4RFbk87XPdnq2fsMpDHzv7wqj
         lxK4zuuLgnuj8DHu9F+PDEEBEes+riNjojaZahmnJ+7FDQeD8Tvl0nkFS5liwmj9q5
         +1pO42XnWJmjnvO+Daa1Ja+kyQdyfqK10cKpT9n9j6gimEQkzAUQMfktuHYu2eSzhr
         /L8+yxHYjNUHOVd25N9aK96NZVP2JpmI9HHvTCqXvP58TyXrIPNrFGnGV55AR84wz8
         kGkbXf2pqHx4g==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 6/6] kselftest/alsa: Add more coverage of sample rates and channel counts
Date:   Wed, 30 Nov 2022 00:06:08 +0000
Message-Id: <20221130000608.519574-7-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130000608.519574-1-broonie@kernel.org>
References: <20221130000608.519574-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=broonie@kernel.org; h=from:subject; bh=SZHDVz1meOtVOiMtc7gqDxDlymHtQ6CtxKd4qfqfgaI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhp5w0bk3EujAlnTerYvqQ9S/R8ox+IZVeJcICXIK wwlnRFWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4aecAAKCRAk1otyXVSH0CllB/ sGS7q4vmYVJutEyNKuqLI/KUoHy9Q6FnDhS5uiUkaQsAaHDzOWu5oJ4cV0eoMbV2AIysL6J1+y2Rj8 Pmn93CcKhqva/XJCgoIDYiQ0aiR9tkzRMo8tuiGhtUYD+UQ9dkzLDXB2kiYZRzUxpATphPmburf24u e7uvG+ciBZQGml/WT+Taz+LFOjvVC/vG71NeZCEbJAzjeAhhc+5mYD+5RbKxMAJwSPNb04tnNBHn98 zziqRYeBHd0U/x/kMUbOD3GAsOQb19bhEcV8ZKYLT+gyDmdct3NPcDnUUOPo4WzI2hjiyBx54Pzpy6 35DLesB6oimXgjzPA4gbkIIFS/bJe7
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

Now that we can skip unsupported configurations add some more test cases
using that, cover 8kHz, 44.1kHz and 96kHz plus 8kHz mono and 48kHz 6
channel.

44.1kHz is a different clock base to the existing 48kHz tests and may
therefore show problems with the clock configuration if only 8kHz based
rates are really available (or help diagnose if bad clocking is due to
only 44.1kHz based rates being supported). 8kHz mono and 48Hz 6 channel
are real world formats and should show if clocking does not account for
channel count properly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 614ccc52cece..d76a6f15ce25 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -517,8 +517,13 @@ static void test_pcm_time1(struct pcm_data *data,
 
 static const struct time_test_def time_tests[] = {
 	/* name              format     rate   chan  period  buffer */
-	{ "S16.48k.2.small", "S16_LE",  48000, 2,      512,    4096 },
-	{ "S16.48k.2.big",   "S16_LE",  48000, 2,    24000,  192000 },
+	{ "8k.1.big",    "S16_LE",   8000, 2,     2000,   16000 },
+	{ "8k.2.big",    "S16_LE",   8000, 2,     4000,   32000 },
+	{ "44k1.2.big",  "S16_LE",  44100, 2,    22050,  192000 },
+	{ "48k.2.small", "S16_LE",  48000, 2,      512,    4096 },
+	{ "48k.2.big",   "S16_LE",  48000, 2,    24000,  192000 },
+	{ "48k.6.big",   "S16_LE",  48000, 6,    48000,  576000 },
+	{ "96k.2.big",   "S16_LE",  96000, 2,    48000,  384000 },
 };
 
 int main(void)
-- 
2.30.2


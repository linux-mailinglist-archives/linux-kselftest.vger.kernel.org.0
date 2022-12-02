Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B0463FD08
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 01:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiLBA1X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 19:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiLBA0e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 19:26:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FACDFB48
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 16:21:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41650B82042
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 00:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A315C433C1;
        Fri,  2 Dec 2022 00:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669940491;
        bh=dBD1V0ORWBj1gViOrTy7ZqLawnuQQJYymah38QyRU4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEEjVcEoCdDe2vydJgo6Fds44sBe4nGYVFs5kwlOOgY83hP0iaUWBGDlCA1+kjnRR
         2WDdmVsnGlz8Mo7C6Zv4CaB51etgn7ku9gHIlMI/PsxqrrlCFKZ1M/yvmuOjkZdFop
         20Sd6tfdBLXMjF9vhVNCxPiRC+ANdTVR8J9/as7ZI8UQGtMNGkRiFxVTCeyyCMXfD3
         PslMnWKxud72BUGBaM2esWXY/MKGAEp2bf053D3cOf17KmKAQ0NYhIjLpa4fbcQwRN
         dP4vihSqKnl/NdbIxxCuqyADDrDw870puxZ9SbzDaCETpzP9iHuc7V/f9bv6yXMd0a
         n2YH6/YV5qTWw==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 6/7] kselftest/alsa: pcm - Provide descriptions for the default tests
Date:   Fri,  2 Dec 2022 00:17:48 +0000
Message-Id: <20221202001749.3321187-7-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202001749.3321187-1-broonie@kernel.org>
References: <20221202001749.3321187-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=broonie@kernel.org; h=from:subject; bh=dBD1V0ORWBj1gViOrTy7ZqLawnuQQJYymah38QyRU4M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiUQrsTUC11H3brnOPFclzE/I346UGT29tb6iInrE QC+kHEGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4lEKwAKCRAk1otyXVSH0IyhB/ 9hUsUOCb9wqCoPiH7AgPo3TXcnBHp9zypli7WnEc/yqw2ZtuO96CZbFDFz72DqFIqDqiHZDzjYeKn+ SRKMGmc+ttgXbm8dMJlkSDfMr+35fzOH7AKVV7hzQsHIYAbvpr/8oxWucxvONDuDJTim+Ol3xCrOxs CTWI1zv05zYvqq5PCRvjaeo2GxinTGCfXQ94J/sb6o24SOVjqZNtQ7b0XJUeDwJHgrJmv4piKNLy73 saRRuYwjX65h6IE+ECKM4lZiajYbxLu+bk1i2loBoFG1BYVVvn0FTGZqknw6OK63PkQfTt6Cr48DKr w+oYe/TAjIHrD+4dHxi5WWhbrwBx5Z
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

Help people understand what the standard tests are trying to cover by
providing descriptions which both serve as comments in the file and log
messages in the program's output.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/alsa/pcm-test.conf b/tools/testing/selftests/alsa/pcm-test.conf
index 473a19251b49..1662a8c7073e 100644
--- a/tools/testing/selftests/alsa/pcm-test.conf
+++ b/tools/testing/selftests/alsa/pcm-test.conf
@@ -1,4 +1,5 @@
 pcm.test.time1 {
+	description "48kHz stereo small periods"
 	format S16_LE
 	alt_formats [ S32_LE ]
 	rate 48000
@@ -7,6 +8,7 @@ pcm.test.time1 {
 	buffer_size 4096
 }
 pcm.test.time2 {
+	description "48kHz stereo large periods"
 	format S16_LE
 	alt_formats [ S32_LE ]
 	rate 48000
-- 
2.30.2


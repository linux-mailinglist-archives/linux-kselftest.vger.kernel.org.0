Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94081470979
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245661AbhLJS6C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245670AbhLJS6B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:58:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1D5C0617A1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 10:54:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66EA8B8298E
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E3AC341C7;
        Fri, 10 Dec 2021 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639162463;
        bh=rohsPdVVVR9EdevsE/V/GrFKcu2ngPnD5UWW/wpylE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzIxwZk+DITCW30wfmUKbqOGJX4HTafUAe3dHGKFLZJAvt6O4ZStY0P7gyk1yoWhA
         0CvcLzLfd7biSWv27oOLKUeOUbbCjAsG0wXcQtjk1viMjoHPu/rbQ7GS5nkvD8HOyw
         IKtX80G5oz34e87DN3PGn52lhN5FsY3BnFkwlRmv89+/gHsHSWXZmy1HQvAcfpKuA2
         pqMY19Q9Xu2yIpMOsiPEMHYGN1t3PGzivDq+IjQEmdPXe4xXR/KEc3KvsGCTiEfz+C
         cl1v4CAiqUuMDN8Z8moeC7MTZEl+Y7uVIDh0D+BCKD95TUFZveMXVKzhlDelg3aH9v
         CZ11besCOGCvg==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 2/3] kselftest: alsa: optimization for SNDRV_CTL_ELEM_ACCESS_VOLATILE
Date:   Fri, 10 Dec 2021 18:54:09 +0000
Message-Id: <20211210185410.740009-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210185410.740009-1-broonie@kernel.org>
References: <20211210185410.740009-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955; i=broonie@kernel.org; h=from:subject; bh=KiZKlxbVF1zb5VsBrhgN0JQrdG+LGi2hP5TTfQ4nqY8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs6JP/y/vzqH2TrApPXd/uop9W8pDfPqPgrnVZMps G136DteJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOiTwAKCRAk1otyXVSH0CYCB/ 9BPfCV7GbUpSfjWK21CuxoL+a5B8lj5rwFHdSO9HVoorkax3/yAbvQSWkmnAiNIIBUZFmDGkwPlMpv TulNRwQl1PxTOz1GFLLItnSMvbih9Pbsj7cmeRuNPpaOiIs+o0eMr9L5qMY5IwdE+uZDlE1CgPkuYO 1rVvWvUUAt3t0AY1QDJAQgbhZNuCy2Sw1dk5OU42qWmPrwaoXguIV2IbU1D/WCyuTH9fKRSHFxSmio J4rMgd2ajrzTYK+SS9NoVhTrq/N6upBw+TKIAYjKOaA13gDHBDMoO8RxcYcFFTyZkD/0qsuOvxdGbo 7Jtm117Znt+RkZwUBqwotvJJ7ML5V0
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

The volatile attribute of control element means that the hardware can
voluntarily change the state of control element independent of any
operation by software. ALSA control core necessarily sends notification
to userspace subscribers for any change from userspace application, while
it doesn't for the hardware's voluntary change.

This commit adds optimization for the attribute. Even if read value is
different from written value, the test reports success as long as the
target control element has the attribute. On the other hand, the
difference is itself reported for developers' convenience.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/Ya7TAHdMe9i41bsC@workstation
[Fix comment style as suggested by Shuah -- broonie]
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index ab51cf7b9e03..f65a9046e708 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -307,9 +307,15 @@ bool show_mismatch(struct ctl_data *ctl, int index,
 	}
 
 	if (expected_int != read_int) {
-		ksft_print_msg("%s.%d expected %lld but read %lld\n",
-			       ctl->name, index, expected_int, read_int);
-		return true;
+		/*
+		 * NOTE: The volatile attribute means that the hardware
+		 * can voluntarily change the state of control element
+		 * independent of any operation by software.  
+		 */
+		bool is_volatile = snd_ctl_elem_info_is_volatile(ctl->info);
+		ksft_print_msg("%s.%d expected %lld but read %lld, is_volatile %d\n",
+			       ctl->name, index, expected_int, read_int, is_volatile);
+		return !is_volatile;
 	} else {
 		return false;
 	}
-- 
2.30.2


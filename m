Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC9346DD7E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 22:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhLHVVb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 16:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhLHVVa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 16:21:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82886C061746
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 13:17:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45148B822DB
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 21:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32679C341CA;
        Wed,  8 Dec 2021 21:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638998276;
        bh=ZpZe4S9g6+9K/niZOHt6MFgbYLGRbm9ZPNUG1vDHhUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=av5FyYFhxbkE5uyrlJbWdGps3XUQeE4j6C/FdRChirF8XmQM72OrtcA7BP5GrE0gR
         JKECUbw5LzTTTl4VVzDozJlmTYqicI9XMgSbdlSa9GhHXgVoXniK/OpSzREwBIyx7Z
         tGpXb/pUjXvvNZpDslHqbO3b/pL5d76ujvBVXCWGHqjxGu584ku8/sOYGNSavpyBfU
         c3m0G1MvtxoPMfl3vnP1gysUUHSO/NJgqnAweC8HqpMAK3Em/kbDBRdeW8OG5Yn3C0
         MPBVgURitPJTW/It8APiwxzoCjpZAHkfUc6rwOMCizNE8lHzf67v222OE1eyt4ttwE
         58Q0q4eLTURHQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 2/3] kselftest: alsa: optimization for SNDRV_CTL_ELEM_ACCESS_VOLATILE
Date:   Wed,  8 Dec 2021 21:17:44 +0000
Message-Id: <20211208211745.533603-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211208211745.533603-1-broonie@kernel.org>
References: <20211208211745.533603-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=broonie@kernel.org; h=from:subject; bh=PNhi0HaclmY3tvqaRA3cxAHo56f/6hUNXvdxt2Zcq+Q=; b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBhsSD3eu8xGXcFy0nhWMHOgf1rSAnPvDqKKgBbFmd0 M9gsyT6JATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbEg9wAKCRAk1otyXVSH0HODB/ d6q/FH7FGeD899VRbb9BLh6S+4V4h33apyDiW8/ImgDm2LHrMNXMWIJEfxYNwTcJjeWFmvuVXK7qZd F0wvXKahbhrqmtNAS7yanjrak0cARns61eyQqASwYhbBGCabv0ttXqOMjftSVC8D2eg7rqHAqtJcdS rBpG6nFwkpwkhTCJ4aWI0wBWuk8jFrlGIxuZxj+mNEUzFt4ozKpNmk7XYnBtTmtxbSvPq41bYVUIzJ ODEakiwcX4bKa/rgKlXT06tBhJ9fNtfpOsTOjZETYfON6sdyFiYHyux2MHMjOGLuMoRCJ7Tdcu0gVQ 09H5ejGEqB/Su+GI51nTDaJth+70g=
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index ab51cf7b9e03..171d33692c7b 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -307,9 +307,13 @@ bool show_mismatch(struct ctl_data *ctl, int index,
 	}
 
 	if (expected_int != read_int) {
-		ksft_print_msg("%s.%d expected %lld but read %lld\n",
-			       ctl->name, index, expected_int, read_int);
-		return true;
+		// NOTE: The volatile attribute means that the hardware can voluntarily change the
+		// state of control element independent of any operation by software.
+		bool is_volatile = snd_ctl_elem_info_is_volatile(ctl->info);
+
+		ksft_print_msg("%s.%d expected %lld but read %lld, is_volatile %d\n",
+			       ctl->name, index, expected_int, read_int, is_volatile);
+		return !is_volatile;
 	} else {
 		return false;
 	}
-- 
2.30.2


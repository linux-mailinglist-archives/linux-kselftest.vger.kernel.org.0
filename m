Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16985B0339
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 13:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIGLiC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 07:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiIGLht (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 07:37:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6814B51A35
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Sep 2022 04:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47AD8B81C52
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Sep 2022 11:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4D9C433D7;
        Wed,  7 Sep 2022 11:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662550656;
        bh=92TznMs1b1N7IrPNprkC3QV0Z+jMCxj4t/CSSmyPXAs=;
        h=From:To:Cc:Subject:Date:From;
        b=rag4eeR4fv09r+kIaoky5k6cFV67ql2hcYb0tNibLErCzAUIyaNWy3QAePPUtAIN0
         x9pYvgYY1NASfq+6GrWw8ADWkCz+kJl3auC90REj62ZV7P2wCWit+RqE5tJ5aHnPOU
         uGJuqcOtZZFFAh/JB+24kYk4Pk+Lx7GYTknJB+dKnFxnX3zOYr/wedEgO3jtjePBNx
         fSwtYGY6UPlRj+hbpQf9o3+0RsU7TTtoUEFukDNPNsGvVmj/9oT6pfWzvBwiKdBu4O
         RyPh7Ly1CJRbUIJRZRJ/RrJ2mx1uWYgRMEQCbmeb+b7JdTKND4bE8SjqidQCoYKa9J
         +WPA9Km1i9mXg==
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Fix typo in hwcap check
Date:   Wed,  7 Sep 2022 12:33:59 +0100
Message-Id: <20220907113400.12982-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=broonie@kernel.org; h=from:subject; bh=92TznMs1b1N7IrPNprkC3QV0Z+jMCxj4t/CSSmyPXAs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjGIGnTTKMjflqkle+MChppAotucrrcPgxqfpg+R9m UCY092SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYxiBpwAKCRAk1otyXVSH0EhwB/ 0YyOb6dZ3s2aR5ojFNJLqaCEnkQ2Kr80/IiS6o+/hPcC9j5AgQry2EBxspkDwpgDRQF05BRH9S9N42 g4CJ4tmQ+uoF0nj/xJ9PI8J4HLt9yrDjZvzmEwk53WBbCbUQHEz86IkbeCx84I8OYnz6DvYepu/kmr xazlmslRVb1DIvjjFODTadhPTNNDCU9K/fBDaaiBe79UucttGxEhprTOHF99MnRefABDhNPu6/6KB/ RotisDcq+3vRLwGmfSSOX6kuBKPbGFEBvkM9wgTfQYXPfrBeOYKU09nodVEG/Gqr7/hsX4dUyFdMjD rVesc1l/ASNvb2yelQ3CQ5lMHG3zfK
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We use a local variable hwcap to refer to the element of the hwcaps array
which we are currently checking. When checking for the relevant hwcap bit
being set in testing we were dereferencing hwcaps rather than hwcap in
fetching the AT_HWCAP to use, which is perfectly valid C but means we were
always checking the bit was set in the hwcap for whichever feature is first
in the array. Remove the stray s.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 322d9b92bbe3..75eb470eb432 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -307,7 +307,7 @@ int main(void)
 	for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
 		hwcap = &hwcaps[i];
 
-		have_hwcap = getauxval(hwcaps->at_hwcap) & hwcap->hwcap_bit;
+		have_hwcap = getauxval(hwcap->at_hwcap) & hwcap->hwcap_bit;
 		have_cpuinfo = cpuinfo_present(hwcap->cpuinfo);
 
 		if (have_hwcap)
-- 
2.30.2


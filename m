Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00843F1F21
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhHSRaO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 13:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232637AbhHSRaL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 13:30:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B50D6108B;
        Thu, 19 Aug 2021 17:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629394172;
        bh=1VTmMtiJqxxUDQUYNzlVIKHziaBcRHCtZ+FU+oyByjo=;
        h=From:To:Cc:Subject:Date:From;
        b=KICuGiab3o8Vj4SPn0jMSrprcHHD3+X0pSLm0c9+wMPUU2mCh2h1nuCL+tyzx8id+
         XLWEc+FPHniEZ0dpbvjh7c9xifkg6VJs3LVp7YIEG5zaYdaA3mwdmZoi586oFMFB7B
         x2sApHWg+SZxLdmN9CmO+Q3aTJ6JA5AM9M0/PORIXFVsaMS6gS1p6vljpZ8KQ9hnkR
         avJgGHLo6KzrFHq3VSoEcv6WgJ7aYN5ADAEstRR9Ru7iO87HRkfVFz557YPnHt5d0T
         WGz0tugH7dOQ3cA9QMaqE6ZeXBBwxU6Ls4aKM2VJr4kAh4+nH8XE2C5ku0+dIQzhxz
         S3VF1xQOXV2tA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: mte: Fix misleading output when skipping tests
Date:   Thu, 19 Aug 2021 18:29:02 +0100
Message-Id: <20210819172902.56211-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; h=from:subject; bh=1VTmMtiJqxxUDQUYNzlVIKHziaBcRHCtZ+FU+oyByjo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhHpO/v553CvLtcOF8hTu4ElTSYgxi/7wtUE2J3eAr jj2w+CSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYR6TvwAKCRAk1otyXVSH0In0B/ 9xXN7RG4ylE2BvkM4a+eepPMCj90hTWi5A92DJRlfJl/sQBf3WZSZW4Y9EU575WLVuNyb6iPQ46/nt 65lCxDEFnmiv09NEvKj5QO4HqypTMccHQL9NIOm6uHk5vQYFCg+aXIFgHvQLvwDaV7u7KXNSAkn2Jp f//09w2YGoHsn/gRnRNRUs0zGMgqLHi5AhfWTtOmMzpEpGvyhoVcCvSOfZD0umFbhPFHFHR0jMqQdv pXsa/pK3Syi2uApI4i8BwEmohutFheUsFgh8tHgZFMHOIIQVnm7sUfDn6rJ5mhCI8kV6c29ef8T0D6 ozlAfopn0rBWiq1efYFgyL/B43cedN
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When skipping the tests due to a lack of system support for MTE we
currently print a message saying FAIL which makes it look like the test
failed even though the test did actually report KSFT_SKIP, creating some
confusion. Change the error message to say SKIP instead so things are
clearer.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/mte/mte_common_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index f50ac31920d1..0328a1e08f65 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -298,7 +298,7 @@ int mte_default_setup(void)
 	int ret;
 
 	if (!(hwcaps2 & HWCAP2_MTE)) {
-		ksft_print_msg("FAIL: MTE features unavailable\n");
+		ksft_print_msg("SKIP: MTE features unavailable\n");
 		return KSFT_SKIP;
 	}
 	/* Get current mte mode */
-- 
2.20.1


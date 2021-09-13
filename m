Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF2408CB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 15:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbhIMNVN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 09:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239327AbhIMNUa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 09:20:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2CFF610CC;
        Mon, 13 Sep 2021 13:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631539132;
        bh=O2J0CBowzd5LAgXHGk3QgAQrfXWhXtRsRLXZBHHOUxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jcpf+X+DQ05dkYlvsf9xDTDTJKQfMhMUPT7R51F12qphK5QYSxoozQMpfwlWmePY8
         lrXhA/au9lDdVRr24UP/5MC8RLAE48YIv3yo4GWJQX993X19CkxXALAn33SIUihuXO
         qP0dPoDDfrNwFK5nOgqax0MwpAm5sWkWowxqnHMeSeUMagYwQnTCVv6HDteCh0C4t8
         pLRg1zvxn2M5yMtlTMz9uNByWfjf0xXmpLPH/r1mcRcpiinxvId9/Ft0NH53/1ddmp
         Lf1z9JbUFudhf0CxmkmCGi54V6l1imOLa13Osm7Y9KWd9asu/gDEF2uzPv9LUwI6FH
         GK5Vd1NdA1Cvg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/8] selftests: arm64: Don't log child creation as a test in SVE ptrace test
Date:   Mon, 13 Sep 2021 13:54:59 +0100
Message-Id: <20210913125505.52619-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913125505.52619-1-broonie@kernel.org>
References: <20210913125505.52619-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; h=from:subject; bh=O2J0CBowzd5LAgXHGk3QgAQrfXWhXtRsRLXZBHHOUxY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhP0okCN56MnhjjHYb3UJB6Gi5I0LAgBkIBd0x0AlX aFHNGAOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9KJAAKCRAk1otyXVSH0Jq5B/ 96f6jDSG7jhRQYXKuzJqRV4RuZUm2rKBItpZuGghAg5HX/Dxtb1I6bkFDWysd3vVjZzu4DiHTZELZP CcyX+OWrJmcq4fqUHtRzu7knZEnXiQwm9o7Yu5pTSGbEafZcqcQXQxxvJGjAbAlETTiG26xVAZn7Pq 9NMCHCwpFIaQO+WOSImtc6usdZ5z89FhmASXytYkt2LWAZVRIGW8duLfCy86+tYWNhR++/zVv8nfK5 9AWxtiHos2FPkucpxeuanH5QjmSbQ9Ryg4ipBjzYJmAl1RNrr1eOaVd+S3C+PQTxc1FPD9WibwhWAw R3+Mmi6zgu3gG0+tJ5MR24lKoBHtxO
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently we log the creation of the child process as a test but it's not
really relevant to what we're trying to test and can make the output a
little confusing so don't do that.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 7f7ed1c96867..7035f01423b3 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -19,7 +19,7 @@
 
 #include "../../kselftest.h"
 
-#define EXPECTED_TESTS 20
+#define EXPECTED_TESTS 19
 
 /* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
 #ifndef NT_ARM_SVE
@@ -169,8 +169,6 @@ static int do_parent(pid_t child)
 		if (WIFEXITED(status) || WIFSIGNALED(status))
 			ksft_exit_fail_msg("Child died unexpectedly\n");
 
-		ksft_test_result(WIFSTOPPED(status), "WIFSTOPPED(%d)\n",
-				 status);
 		if (!WIFSTOPPED(status))
 			goto error;
 
-- 
2.20.1


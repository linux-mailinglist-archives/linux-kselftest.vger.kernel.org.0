Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7524F408CB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbhIMNVO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 09:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240369AbhIMNU2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 09:20:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E538D610A2;
        Mon, 13 Sep 2021 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631539129;
        bh=vQDQ+/qG/LA/nRQzQGstev6NVULTlIXk2hGztV2UteM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqOdA1+3zhc6YwC/f8v6Amy9aEhhOFTMIr3xfErrZDRTS8XE88MrOp6VyZTkFgYii
         6tclXKfWUoPr2hmelkztZIhSahfNbi8+8TkklOTHjnwONgn7J7RlLagFRjpJfCBZUf
         NBtM6gX8srWLGpJUAT9UdsmwamCj1vEnMp2M55SmjifVh16ub7RNGF7RbOwAwnBBSR
         EGo7BfHKlXMbyD8E+ALCxJ3ixLYzAYVhxdVTM2qRnkpzggTAl9IxlF369AxL9hcRRe
         LaheRlTiBHYuiRdVuXKDCj1pq/7YKOu5SrCggiLs39AevkCzDxqGQTNDAFAbPPsVTQ
         1MgYx0LfS6aMg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/8] selftests: arm64: Use a define for the number of SVE ptrace tests to be run
Date:   Mon, 13 Sep 2021 13:54:58 +0100
Message-Id: <20210913125505.52619-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913125505.52619-1-broonie@kernel.org>
References: <20210913125505.52619-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; h=from:subject; bh=vQDQ+/qG/LA/nRQzQGstev6NVULTlIXk2hGztV2UteM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhP0ojs9Vk+/o+GTD2AjKNaqbcwhx75hQGZxNVU3s1 cj6R8YCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9KIwAKCRAk1otyXVSH0Kt+B/ 40BTs6y8xK7oAExeJcW0SR1vhjKsEMhxINqcMwOExxzdr++OzfeElYqJLepwCTivrUUZR0o0qygzVJ XDRTh5a71tFYA83/iv/csS9P2/HxWrTopfAcD2HS9CJLXnaUxVkiXbN/Jq3+UDPkNe5eeCC2QRvzuG c9QGzQ7l6nxMI3Ino/rOUP7SD4zrZpVkVMU1ZtTVXcmkJXaXG5Zr7ieStWjiO+us+FBZUCzKvR+acr ieGUAEoArgL3Aw4LkjM32JemJ77rEwYIwqlbH41MSx2uPaIMZr2eH/u/sjuyik6aSBNvsN6xDcFPWN t03gx/sQIInHu5JdW/uxfZQrHkPi8o
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Partly in preparation for future refactoring move from hard coding the
number of tests in main() to putting #define at the top of the source
instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 612d3899614a..7f7ed1c96867 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -19,6 +19,8 @@
 
 #include "../../kselftest.h"
 
+#define EXPECTED_TESTS 20
+
 /* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
 #ifndef NT_ARM_SVE
 #define NT_ARM_SVE 0x405
@@ -313,7 +315,7 @@ int main(void)
 	pid_t child;
 
 	ksft_print_header();
-	ksft_set_plan(20);
+	ksft_set_plan(EXPECTED_TESTS);
 
 	if (!(getauxval(AT_HWCAP) & HWCAP_SVE))
 		ksft_exit_skip("SVE not available\n");
-- 
2.20.1


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2485E3D9347
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhG1QeS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 12:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhG1QeO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 12:34:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5BFA60F9B;
        Wed, 28 Jul 2021 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627490052;
        bh=R0X/PIkba67SuYhiFH1mZDCaVfSVQGrDfuGGj27KXBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I49G2+ItDNCkfyRqD9DYs5pZuruYq/Nc2HJq+U9Y2ZHE+zESWn2j8Ys14OWKb9mw6
         wXCvBeYKZzS0hClvI5UuFCzNoKdlo6IxXxkTxf1RGQbvl4+EE79+Bhaha83Mk1eDMq
         kq9kJIOy8cEb7bcEtWyFP4kwPoVIFIxn84I+zZn0V7EjXNJCsh/ldS49mZGy+lc4T6
         C9rNbgmVrvIaERMVglWklxAtRaDLLUQDlwuFwfe9d90NP1Tyfji/KQzKTkZVeoDKSS
         b2a0HQL56Xlcp75/oTp9CTmWJHDOpl7u+MzqFpLir5ofkixkstt2PA6mc1hTX1K58J
         f0nWWxTgyGjOQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/4] kselftest/arm64: Validate vector lengths are set in sve-probe-vls
Date:   Wed, 28 Jul 2021 17:33:16 +0100
Message-Id: <20210728163318.51492-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728163318.51492-1-broonie@kernel.org>
References: <20210728163318.51492-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; h=from:subject; bh=R0X/PIkba67SuYhiFH1mZDCaVfSVQGrDfuGGj27KXBk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhAYbJ1000oTPFcE2/jiud0uwYD+HZwSrRozpN9ybC UULtZ56JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQGGyQAKCRAk1otyXVSH0HABB/ 4wRecWQSAHkkRzw8y9ZX5HROcXHxWySc4zYjLUN9sZ3LlxLyZDOAiDvP/pUNd+zg+5PqYKv46q77nv 9nKir3jA0mvpmWs5bG0ZRc9TMkRcnsS/gvM8Zwhq0EgzAioC23dcxADGIWcAglanjp0wRIXz3V0r2f gYxjGeAlNbcDGzMWjaO1Xxg5einaZcjIy13HfanGKMwveDos0tE7eGwiEsUT9u8ULSsl5+FoDToncc Wb0iGnMs3TGGrTHKHOe9JbOW/3rk0fIXW3PK69f1dvzrZ6eFh6l8YtAtBFNA9MgukxCsNYhlOruHK4 Bova0U1lCgLvux6DiYRFGaFqnG8B/v
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently sve-probe-vls does not verify that the vector lengths reported
by the prctl() interface are actually what is reported by the architecture,
use the rdvl_sve() helper to validate this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile        | 2 +-
 tools/testing/selftests/arm64/fp/sve-probe-vls.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index ed62e7003b96..fa3a0167db2d 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -13,7 +13,7 @@ fpsimd-test: fpsimd-test.o
 	$(CC) -nostdlib $^ -o $@
 rdvl-sve: rdvl-sve.o rdvl.o
 sve-ptrace: sve-ptrace.o sve-ptrace-asm.o
-sve-probe-vls: sve-probe-vls.o
+sve-probe-vls: sve-probe-vls.o rdvl.o
 sve-test: sve-test.o
 	$(CC) -nostdlib $^ -o $@
 vlset: vlset.o
diff --git a/tools/testing/selftests/arm64/fp/sve-probe-vls.c b/tools/testing/selftests/arm64/fp/sve-probe-vls.c
index 76e138525d55..a24eca7a4ecb 100644
--- a/tools/testing/selftests/arm64/fp/sve-probe-vls.c
+++ b/tools/testing/selftests/arm64/fp/sve-probe-vls.c
@@ -13,6 +13,7 @@
 #include <asm/sigcontext.h>
 
 #include "../../kselftest.h"
+#include "rdvl.h"
 
 int main(int argc, char **argv)
 {
@@ -38,6 +39,10 @@ int main(int argc, char **argv)
 
 		vl &= PR_SVE_VL_LEN_MASK;
 
+		if (rdvl_sve() != vl)
+			ksft_exit_fail_msg("PR_SVE_SET_VL reports %d, RDVL %d\n",
+					   vl, rdvl_sve());
+
 		if (!sve_vl_valid(vl))
 			ksft_exit_fail_msg("VL %d invalid\n", vl);
 		vq = sve_vq_from_vl(vl);
-- 
2.20.1


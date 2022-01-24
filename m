Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C39A49864B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbiAXRSL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:18:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54908 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244297AbiAXRSK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:18:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45E73612F0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 17:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A17C340E5;
        Mon, 24 Jan 2022 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643044689;
        bh=cINPFgKL2Ut8k3Oy2wD5fkInRC1CnwPrnusLBuDdThE=;
        h=From:To:Cc:Subject:Date:From;
        b=pvRRoOxBMA0Ame5jMPDrC9Qh4EoIXvtSTIxXy7rfxIOwvEh7C4//7TFcCemLkmcLM
         +xesDIbCt8uSCIlHfwBwijCMVPy8sMf6zwbMeNmN7oJ59tvQuYDc03gD1bIdqOUU8e
         zORJY3whI/89AR1l+uJv3Mqq1XybQuA2FesTUz2OBnON3G4FPsbRVA384dTt0gQ+uS
         8SolE8UWUNCcFykQYt004/bwUHPYpFeESXmc4amSPpHPBP8qfmcxysvQIuCmNU8+PB
         qaVYGfQ5Sxmg9mZlKLluspfMzpl2pcGVyMXk+9Z+XLrlfzinw8VnvpcCQc9t48KbQF
         z/G+xLrO4SHFg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Remove local ARRAY_SIZE() definitions
Date:   Mon, 24 Jan 2022 17:17:48 +0000
Message-Id: <20220124171748.2195875-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; h=from:subject; bh=cINPFgKL2Ut8k3Oy2wD5fkInRC1CnwPrnusLBuDdThE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh7t7WgEzITa3c+LpcX6BANIKS7MW2GTUq48+G78Hk TYKq/JWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe7e1gAKCRAk1otyXVSH0IHuCA CA6Vuy1vCu980lNhdJe7ZzbvxnoGcNhlW28hjsZ4A2XJZowETvZHs+vHeaUFgr0RLuQxQ8uJ5Cehi2 eSQpkgLw9ym4vvs28G3qGQubTX5nNMXZNTrrvAr+4EibqlA75DDL5xdrq7290/ZqVusTJPrlDyX0bZ Av3YX+V5zu+kvzaoDIcufSifT4YstW6rJUg2nje/A2ajM0au2qrEMZEWxANH7SfBY3OCWQzAIybifZ VP3H/49SZ8NWYeNWJcK7cjUipobNGpPx+bEYoWT67CgcN1GyC9xIG0+ogJJT81BwxOVtj03rJtV8dy s3poQYMovfig2rBeCwxQeKEc4OsGQE
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

An ARRAY_SIZE() has been added to kselftest.h so remove the local versions
in some of the arm64 selftests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/syscall-abi.c | 1 -
 tools/testing/selftests/arm64/fp/sve-ptrace.c   | 2 --
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index d8eeeafb50dc..1e13b7523918 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -18,7 +18,6 @@
 
 #include "../../kselftest.h"
 
-#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
 #define NUM_VL ((SVE_VQ_MAX - SVE_VQ_MIN) + 1)
 
 extern void do_syscall(int sve_vl);
diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index af798b9d232c..90ba1d6a6781 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -21,8 +21,6 @@
 
 #include "../../kselftest.h"
 
-#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
-
 /* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
 #ifndef NT_ARM_SVE
 #define NT_ARM_SVE 0x405
-- 
2.30.2


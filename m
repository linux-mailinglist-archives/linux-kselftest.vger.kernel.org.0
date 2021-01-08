Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46CC2EF76B
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jan 2021 19:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbhAHSeH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jan 2021 13:34:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbhAHSeH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jan 2021 13:34:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3763223A7E;
        Fri,  8 Jan 2021 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610130806;
        bh=cBEYeoXOCah3eqsH5V8OS8pzYL4S3DiOJqzhZARYVOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=m4+EACqxZSV5XKUGawUYzrbe2NYKxADxX10qcL1PY7XlQWU1ex4Msl7xiwx3UHCix
         uASIZwJoN8woLTed7dL1eoUZ8FN7/PfYFbcSHAq3u2g4FxcoaCAiIrO3PrcPsPEdfq
         1zYJv2mWR63IXdf2mjRu6onTr2bRkV9rQ360xrtDd9kmHeM3bvICnYI0i5+41j9dci
         wUdtN+5o8kgXCmxhy9KVtpxIAljZnYT7hZOMEg5JukwBBEZVMBOJN4tzUhQsX2kifx
         NLWUrT1GaYGKx7FIzE+cEDlb62RkDq2fieUzXCgbS7+9OWJlvxjawy1Ikxxbf3KiKv
         o22J9XeujCwRg==
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] arm64: selftests: Fix spelling of 'Mismatch'
Date:   Fri,  8 Jan 2021 18:31:44 +0000
Message-Id: <20210108183144.673-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The SVE and FPSIMD stress tests have a spelling mistake in the output, fix
it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fpsimd-test.S | 2 +-
 tools/testing/selftests/arm64/fp/sve-test.S    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fpsimd-test.S b/tools/testing/selftests/arm64/fp/fpsimd-test.S
index 1c5556bdd11d..0dbd594c2747 100644
--- a/tools/testing/selftests/arm64/fp/fpsimd-test.S
+++ b/tools/testing/selftests/arm64/fp/fpsimd-test.S
@@ -457,7 +457,7 @@ function barf
 	mov	x11, x1	// actual data
 	mov	x12, x2	// data size
 
-	puts	"Mistatch: PID="
+	puts	"Mismatch: PID="
 	mov	x0, x20
 	bl	putdec
 	puts	", iteration="
diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index f95074c9b48b..9210691aa998 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -625,7 +625,7 @@ function barf
 	mov	x11, x1	// actual data
 	mov	x12, x2	// data size
 
-	puts	"Mistatch: PID="
+	puts	"Mismatch: PID="
 	mov	x0, x20
 	bl	putdec
 	puts	", iteration="
-- 
2.20.1


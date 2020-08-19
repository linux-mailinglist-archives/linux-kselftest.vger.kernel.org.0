Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665DC249D93
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 14:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHSMON (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 08:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgHSMOL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 08:14:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF5AE206DA;
        Wed, 19 Aug 2020 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597839251;
        bh=Qm1D4s+M/mO7mwIKm4XuWbPwM6fNbujUhQSw8qCmPVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTpFukSQmJyyrAXX0yhMBRTggEOGVM7aeRXckhVLbgCQi3LgF58ukbdELkTN/v+/s
         UVIuUi9W3MAQZNMAuX/8iUqNsw1gyXwY0oqY3sCBfFFU5axWh8MshuvTA5yPuckMPp
         n3yXaa3UY9WcZFA8Szu0ifRmeBHC8Fmv0cRQU/Mg=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 5/5] selftests: vdso: Support arm64 in getcpu() test
Date:   Wed, 19 Aug 2020 13:13:18 +0100
Message-Id: <20200819121318.52158-6-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200819121318.52158-1-broonie@kernel.org>
References: <20200819121318.52158-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

arm64 exports the vDSO ABI with a version of LINUX_2.6.39 and symbols
prefixed with __kernel rather than __vdso. Update the getcpu() test to
handle this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/vDSO/vdso_test_getcpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
index fc25ede131b8..4aeb65012b81 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -14,8 +14,18 @@
 #include "../kselftest.h"
 #include "parse_vdso.h"
 
+/*
+ * ARM64's vDSO exports its getcpu() implementation with a different
+ * name and version from other architectures, so we need to handle it
+ * as a special case.
+ */
+#if defined(__aarch64__)
+const char *version = "LINUX_2.6.39";
+const char *name = "__kernel_getcpu";
+#else
 const char *version = "LINUX_2.6";
 const char *name = "__vdso_getcpu";
+#endif
 
 struct getcpu_cache;
 typedef long (*getcpu_t)(unsigned int *, unsigned int *,
-- 
2.20.1


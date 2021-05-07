Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E543768C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 May 2021 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbhEGQ26 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 12:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238165AbhEGQ25 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 12:28:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 431046144F;
        Fri,  7 May 2021 16:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620404877;
        bh=REJqg1qmerOA6xM2S/Usce+IfSnkSoFTT7GLQSzUHDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=h/8xdMJU55n9fB+GVn0WNMV/YsFg30CITx+PGvQ7ET+Aaqz5CPi3bh1dq/Q/1Idrj
         TzjwmMoHgWIvSJo4vdaAZDEIO35F0hv7pD4DnitJ4Tro9dQml66D9XMHiF9ORIa7V6
         q65EGimaaakr1lSRXhzYgBo7O9kgvEAkSw02dxuLAoWXSrsqWAUsZA4MVGB9CCyon4
         amml+T0jw0kRAOGbK+sQjE2CjzEht8B68kDNCkegYZUF09BYjov718wklF4MEPXS8c
         yyxSe/AuDgeOixs+OmOnKQ/KK507j3xaWg8oH8cm9/MytEPEDtlozgMS3HOSfmA6iw
         idqC3E9V//yQQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Add missing stddef.h include to BTI tests
Date:   Fri,  7 May 2021 17:25:42 +0100
Message-Id: <20210507162542.23149-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=tNwPEhIm1HRME5IVKyaCqC9DfDsvT/iTsijMJWpIfic=; m=W4vhnkryA0sQApJwzE3QMdBuNUFTrQKaqaGjQU1Q8x8=; p=mvWMt0niUw+nSHbTu29m+7/mDB4yF+ZBiZ0BdcqDy30=; g=e596d82f6e5648149eb861dd5656a07f45f1ecc0
X-Patch-Sig: m=pgp; i=broonie@kernel.org; s=0xC3F436CA30F5D8EB; b=iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCVadcACgkQJNaLcl1Uh9D58wf/Wvz F/9k2Ifls3Y5BjJXhHBbXceXaQ/xXyVSrV5w3gGgFNmntXmOaXe3YQqwjPdEbChpv9FoTAFJVaHkx dDzwcKFwZz5KmsdboyKUtpj5tD4zmYSpreESd6Bx4y/U//nC+cMJh2Y5dmflp3gDD6Lxrrp65C0SY xZFg/QP/yn7DqvBybvTE6lYQrdSmFUvv19zcpewuXLYhUFNC9wBzLdx9XJfLRGe1qtxg8RCEUEhSf AzAeZl3cTRc5wVmAj3pQacRzMYOCQxX0ByaOSuQ4sDqEYFMit8ZgCwQA7OD6IWaehBtR/Ah7DMmYh BTya9rbAOa33jCQyktAa9LBpqHDAuFw==
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Explicitly include stddef.h when building the BTI tests so that we have
a definition of NULL, with at least some toolchains this is not done
implicitly by anything else:

test.c: In function ‘start’:
test.c:214:25: error: ‘NULL’ undeclared (first use in this function)
  214 |  sigaction(SIGILL, &sa, NULL);
      |                         ^~~~
test.c:20:1: note: ‘NULL’ is defined in header ‘<stddef.h>’; did you forget to ‘#include <stddef.h>’?

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/bti/test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/arm64/bti/test.c b/tools/testing/selftests/arm64/bti/test.c
index 656b04976ccc..67b77ab83c20 100644
--- a/tools/testing/selftests/arm64/bti/test.c
+++ b/tools/testing/selftests/arm64/bti/test.c
@@ -6,6 +6,7 @@
 
 #include "system.h"
 
+#include <stddef.h>
 #include <linux/errno.h>
 #include <linux/auxvec.h>
 #include <linux/signal.h>
-- 
2.20.1


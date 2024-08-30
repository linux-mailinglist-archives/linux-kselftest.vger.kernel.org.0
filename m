Return-Path: <linux-kselftest+bounces-16817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC7F966633
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD931F257A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5677A1B81B3;
	Fri, 30 Aug 2024 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KP06SRYp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4011B81A7;
	Fri, 30 Aug 2024 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033321; cv=none; b=Xe2bzlH4qYUotFzQiyo7ZO8u/SYwVwQ82jnnoE5Q3NOdd8nf6u6SAZhL5dEuq6lydkP1qBCzuI2djd70TW1rBrf12/qBf6btkZxSippBwSb9YVrjuOMr1q+cHOajjAojSrobowvTei41Atcj4e0iL9nO5c//IVRgF2sYXKvAoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033321; c=relaxed/simple;
	bh=Ck6noLRVux54nCOdg2o5naLnHS6SnnWMtuEu+100PFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6lTuOc9fceZBOmNysjJ4txRPQHxSvsNZtoXOSh+i8MClLAMPMpLYoFQ7wJXuhDJSvFyYijBJ6Qjw+s4VKQ1vkUIMCKKJlzyVWhWdtD+hyV/4aYs6xkfXQ9VN1GQR5veSf8zAW4o8oXwXdz5i/Swn2OBKUeVFQFHspk7djUJG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=KP06SRYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230F0C4CEC2;
	Fri, 30 Aug 2024 15:55:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KP06SRYp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725033318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IlVS0E6igPOLQqCo4YoSnHQENqvVfPFsir+QHAoHcCA=;
	b=KP06SRYpyIlzOSc1mRAOQ7EMTJNeKpy5dr27CqLsQkiiYXYBgEEVwMZROQfRbwlFvpUqsq
	iXmZNQbWLW/N7LiC97SmxJvq7aKwK35vhrEgQQT95Xr7uKN/g0PBYfukLli6MfwguxH7pE
	tc6KInHCFeQH7afLluKVMYirawCgdfg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a0f4f698 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 15:55:18 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: broonie@kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] selftests: vDSO: fix cross build for getrandom and chacha tests
Date: Fri, 30 Aug 2024 17:54:35 +0200
Message-ID: <20240830155513.493854-1-Jason@zx2c4.com>
In-Reply-To: <dd1d8f71-28ab-44db-819e-90aff2f9b9be@sirena.org.uk>
References: <dd1d8f71-28ab-44db-819e-90aff2f9b9be@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

Unlike the check for the standalone x86 test, the check for building the
vDSO getrandom and chacaha tests looks at the architecture for the host
rather than the architecture for the target when deciding if they should
be built. Since the chacha test includes some assembler code this means
that cross building with x86 as either the target or host is broken. Use
a check for ARCH instead.

This also handles s a small complication in conditionalizing on x86_64
but not x86, which requires defining the standard SRCARCH variable and
being careful about which uname-m substitutions are done.

Fixes: 4920a2590e91 ("selftests/vDSO: add tests for vgetrandom")
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Mark - is this okay with you? I fixed the issue I mentioned.

 tools/testing/selftests/vDSO/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index e21e78aae24d..5ead6b1f0478 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-uname_M := $(shell uname -m 2>/dev/null || echo not)
-ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+ARCH ?= $(shell uname -m | sed -e s/i.86/x86/)
+SRCARCH := $(subst x86_64,x86,$(ARCH))
 
 TEST_GEN_PROGS := vdso_test_gettimeofday
 TEST_GEN_PROGS += vdso_test_getcpu
@@ -10,7 +10,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += vdso_test_correctness
-ifeq ($(uname_M),x86_64)
+ifeq ($(ARCH),$(filter $(ARCH),x86_64))
 TEST_GEN_PROGS += vdso_test_getrandom
 TEST_GEN_PROGS += vdso_test_chacha
 endif
@@ -38,8 +38,8 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
                                          $(KHDR_INCLUDES) \
                                          -isystem $(top_srcdir)/include/uapi
 
-$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(ARCH)/vdso/vgetrandom-chacha.S
+$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
-                                      -idirafter $(top_srcdir)/arch/$(ARCH)/include \
+                                      -idirafter $(top_srcdir)/arch/$(SRCARCH)/include \
                                       -idirafter $(top_srcdir)/include \
                                       -D__ASSEMBLY__ -Wa,--noexecstack
-- 
2.46.0



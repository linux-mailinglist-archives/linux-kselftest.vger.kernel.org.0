Return-Path: <linux-kselftest+bounces-16906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46C9967692
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 15:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DB0281E7A
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14D316F265;
	Sun,  1 Sep 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VQ5I9I7H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6620142E70;
	Sun,  1 Sep 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725196975; cv=none; b=S2Y01Sh24QxmSI92uX7QfC7cQyDVvfAgjl3Co+IUfr5fTL5/N0pgVnYf85lyJ6yJwoJrqYUSh6w0V3C5JQSZ0Gr2ZZuxV/QBL1iTeS69v+eoOrUgbn2eScOr2YOuwgm7IqW+hiytNZhBbPZk/arthJG/n6W31AuRhAbZJkmMK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725196975; c=relaxed/simple;
	bh=P66z1AKz07BZpb9PPY6FDagQy0tDy/sPP0zrIgaimkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOnNuK/WLLI06QLXfHBeFBJdv5HBdxZLu5K9hhuNV/wr2zQTndyg/4WbGnIwPdq3IP5c2fHV1YrKVaGLBMdE8IJH060FJI62+4FwQ7a5PeBVIC/h/fRYshuh3rB/dAGbjFhCVNH3bhk9QeHvEOvGzCxjUPdzn+wJvJ7GuRjWYJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=VQ5I9I7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57933C4CEC3;
	Sun,  1 Sep 2024 13:22:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VQ5I9I7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725196972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VqKtcG/RJHcMiIL0KDs+hlkRdgwkVujibwSSpwSa+yg=;
	b=VQ5I9I7HIzUdnuQu4Ma+VDY5odRoSHVyACebhPldB473cJrewRJvEdsa1XxWR32SOgX9fq
	5Y/EH2RZxFq4ZzsGICZ/Ca0YvdwQkm3fWGpuFWh7pc3VW5AxfnInKDNj5QP/zcgeMtrlj3
	quwuDWMSVvH4mcG0FVyI+//XKMIoX3I=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d75b9e0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 1 Sep 2024 13:22:50 +0000 (UTC)
Date: Sun, 1 Sep 2024 15:22:47 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>, broonie@kernel.org
Subject: Re: [PATCH] selftests: vDSO: Do not rely on $ARCH for
 vdso_test_getrandom && vdso_test_chacha
Message-ID: <ZtRqp-uZe5C07qOF@zx2c4.com>
References: <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>

Hi Christophe,

Hmm, I'm not so sure I like this very much. I think it's important for
these tests to fail when an arch tries to hook up the function to the
vDSO, but it's still not exported for some reason. This also regresses
the ARCH=x86_64 vs ARCH=x86 thing, which SRCARCH fixes.

What about, instead, something like below, replacing the other commit?

Jason

From ccc53425c98f4f5c2a1edaf775089efb56bd106e Mon Sep 17 00:00:00 2001
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 1 Sep 2024 15:05:01 +0200
Subject: [PATCH] selftests: vDSO: fix cross build for getrandom and chacha
 tests

Unlike the check for the standalone x86 test, the check for building the
vDSO getrandom and chacaha tests looks at the architecture for the host
rather than the architecture for the target when deciding if they should
be built. Since the chacha test includes some assembler code this means
that cross building with x86 as either the target or host is broken.

There's also some additional complications, where ARCH can legitimately
be either x86_64 or x86, but the source code we need to compile lives in
a directory path containing arch/x86. The standard SRCARCH variable
handles that. And actually, all these variables and proper substitutions
are already described in tools/scripts/Makefile.arch, so just include
that to handle it.

Similarly, ARCH=x86 can actually describe ARCH=x86_64,
just with CONFIG_64BIT, so we can't rely on ARCH for selecting
non-32-bit tests. For that, check against $(ARCH)$(CONFIG_X86_32). This
won't help for people manually running this inside the vDSO selftest
directory (which isn't really supported anyway and has problems on
various archs), but it should work for builds of the kselftests, where
the CONFIG_* variables are defined. On x86_64 machines,
$(ARCH)$(CONFIG_X86_32) will evaluate to x86. On arm64 machines, it will
evaluate to arm64. On 32-bit x86 machines, it will evaluate to x86y,
which won't match the filter list.

Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/vDSO/Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index e21e78aae24d..01a5805062b3 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-uname_M := $(shell uname -m 2>/dev/null || echo not)
-ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+include ../../../scripts/Makefile.arch

 TEST_GEN_PROGS := vdso_test_gettimeofday
 TEST_GEN_PROGS += vdso_test_getcpu
@@ -10,7 +9,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += vdso_test_correctness
-ifeq ($(uname_M),x86_64)
+ifeq ($(ARCH)$(CONFIG_X86_32),$(filter $(ARCH)$(CONFIG_X86_32),x86))
 TEST_GEN_PROGS += vdso_test_getrandom
 TEST_GEN_PROGS += vdso_test_chacha
 endif
@@ -38,8 +37,8 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
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




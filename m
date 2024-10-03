Return-Path: <linux-kselftest+bounces-18946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3032F98E8B9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 05:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2912880DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 03:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6801DFED;
	Thu,  3 Oct 2024 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SCi3HuLF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47611DDF5
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 03:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727925206; cv=none; b=uUupP8FMOwa/H1gcsY2B0dhBNgJlf1lOIf0Nt378DcYJXAyPWrnGcIAheNNAEZRu/iV3CorQzoKmP8qTAW4r7EIWbXjy8Ho/5GWYPWUL2oemKTq4GczG2ZVzShdgDzbyrJA0AW8+GVKz7dt/KkYf4JWoHgRmL98akTNDbO9bRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727925206; c=relaxed/simple;
	bh=9ciqSTDFFbsnNGYuV+KOYbYwXZ7Vf9VIflWDj1ru7Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ei+U8tuGkiytBrK/G1YC89yTPMCadZqAHSUJp3A/2c6q3lo2SqlEGPwePUfJrdPGv2CfpwkGQN98U8EmxaMgdGbWErZahJgUeCHbLn3A3c/FFh+OzI38Faec6l4U1ZMIB1nm8zQWksj30B5cTO6OcaESY+6egCSEyowNv3hkl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=SCi3HuLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC4FC4CEC5;
	Thu,  3 Oct 2024 03:13:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SCi3HuLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727925204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Amu8Mu5MnevyZJQXbOFfVz0Bg6ZHEPdUgIGLkb0hhOk=;
	b=SCi3HuLFQb2PYoOvzZWDYFmYmzaRDlS13apYIos84yvyUAD70FYtM/lLu0CXhnfM+bOoJq
	YqQ8efk/Qq+POGXHFtUSyw5Qv6W+PGQwDnS+h0HsmWpIaTm4SG78AftnKMrYf1C5jqa2Em
	VGbnodA2bY2pvUNcmdetcl/ho+/J9ug=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f21ef1bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Oct 2024 03:13:24 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: skhan@linuxfoundation.org,
	greg@kroah.com,
	linux-kselftest@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH kselftest 1/3] selftests: vDSO: condition chacha build on chacha implementation
Date: Thu,  3 Oct 2024 05:13:05 +0200
Message-ID: <20241003031307.2236454-2-Jason@zx2c4.com>
In-Reply-To: <20241003031307.2236454-1-Jason@zx2c4.com>
References: <Zv20olVBlnxL9UnS@zx2c4.com>
 <20241003031307.2236454-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chacha test can build anywhere that the vgetrandom-chacha.S file is
available, so condition it on the existence of that file, rather than a
specific arch.

There is one wrinkle, which is that x86 and x86_64 are the same ARCH,
but the code is only functional for x86_64. So filter out the test for
CONFIG_X86_32 in the same block that the other 32-bit special case
lives.

We have to define top_srcdir ourselves, because even though lib.mk
defines it later, that has to be included after TEST_GEN_PROGS is
populated. Fortunately the definition is fairly trivial.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/vDSO/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index af9cedbf5357..2c38c9c6d056 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../../../scripts/Makefile.arch
+top_srcdir = $(realpath ../../../..)
 
 TEST_GEN_PROGS := vdso_test_gettimeofday
 TEST_GEN_PROGS += vdso_test_getcpu
@@ -11,6 +12,8 @@ endif
 TEST_GEN_PROGS += vdso_test_correctness
 ifeq ($(ARCH)$(CONFIG_X86_32),$(filter $(ARCH)$(CONFIG_X86_32),x86 x86_64 loongarch arm64 powerpc s390))
 TEST_GEN_PROGS += vdso_test_getrandom
+endif
+ifneq ($(wildcard $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S),)
 TEST_GEN_PROGS += vdso_test_chacha
 endif
 
@@ -18,6 +21,7 @@ CFLAGS := -std=gnu99 -O2
 
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
+TEST_GEN_PROGS := $(filter-out vdso_test_chacha,$(TEST_GEN_PROGS))
 endif
 
 include ../lib.mk
-- 
2.46.0



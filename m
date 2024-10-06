Return-Path: <linux-kselftest+bounces-19122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FE3991C94
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 06:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895781C20F1A
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 04:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B1374EA;
	Sun,  6 Oct 2024 04:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EbX9lxR2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66467F6
	for <linux-kselftest@vger.kernel.org>; Sun,  6 Oct 2024 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728189657; cv=none; b=EILX9Xuyrr6gV0KecMFq467NjVZidu2YHDhoFA1yJYK+ZW4EbFSK1OF64ihLl3xPF0EannkBGv9nglgNzQ12Eq+XJpwVLtM0o6pO2uPXzpPfMyUBYrDnb5mVfxB5YRcvUVNA9t6YbWhEU27s6PsO8HGDSnLqCFhBSF8QQ5YdJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728189657; c=relaxed/simple;
	bh=9ciqSTDFFbsnNGYuV+KOYbYwXZ7Vf9VIflWDj1ru7Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQeqej8/cDpsS585k3Xf8sbvt3APaH13E0xxmi9MNSGwYz9JTSHGvDMZwohia6p7olANd2Tl+RkWyzVktfacW+hp4z7qDZPuo4wvJbQlMfv7R/f+Vt9E3qIHWNP5voXbBKfr8TdciiRKggf2uIj4L4qo3+KQNmGaQs2fYbEnqOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=EbX9lxR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD00FC4CED0;
	Sun,  6 Oct 2024 04:40:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EbX9lxR2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1728189654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Amu8Mu5MnevyZJQXbOFfVz0Bg6ZHEPdUgIGLkb0hhOk=;
	b=EbX9lxR2M3K/ZZxgM/TmWDeojeUiSVa0KtiV51z+0Qjfi+f/A5+iXeoTy8RlI3aMFlsxJe
	y/5GtX1UkiYDWN1vdZbrU8QzfdYSNxCvHXcimqGE5k4R1qOwDcYJylF1BHuoMmoLSPuW3B
	hTbrp9HFz2LsoVeOW0Lw6Jcavqf0n/Y=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 67f9ba37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 6 Oct 2024 04:40:54 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kselftest@vger.kernel.org,
	greg@kroah.com,
	skhan@linuxfoundation.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH kselftest v2 1/4] selftests: vDSO: condition chacha build on chacha implementation
Date: Sun,  6 Oct 2024 06:40:14 +0200
Message-ID: <20241006044017.2417623-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9qEp8Emg88wWR_oOT39hSaooLDd2L5YPetFrH3O-CgkBQ@mail.gmail.com>
References: <CAHmME9qEp8Emg88wWR_oOT39hSaooLDd2L5YPetFrH3O-CgkBQ@mail.gmail.com>
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



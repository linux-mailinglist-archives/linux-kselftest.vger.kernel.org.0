Return-Path: <linux-kselftest+bounces-19184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE5A993984
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 23:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41EA8B20F30
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7EE189B9C;
	Mon,  7 Oct 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BA+q3BEq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B817C9E8
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Oct 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337568; cv=none; b=T/UU3DRx/KvMREf9CAsaGmU3lDRvCGj1/1oZRvGGMs8QLMTW2gY/Gw8WnWVIT76Adwk5p8yG91IfyJnWNXjpjC0pzuKjAaMtNlmaYaaNEJsNDCo0P6Ppuw9Gp0uvCecfXZLtGUwzbKVQTYr939BIcSxMCMxc8J9c+GKiAsOjbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337568; c=relaxed/simple;
	bh=R2NtL/BfyojjWovcggvc+bURQ/P/TZ1d/u9vB5/Tukk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uxbt+fshaaMoKdhSPchdqjG1uz2FwxHzwvEmaGokosRI3D1Um3v+91H5h69+SYHG5SWJ7z1cXgpiYKKeYjglpWHlkc/qSqI/IL2mFYKxrS14YHGvAhwyV7ZDh3Pn9ma7qCKdQcuATmov0WAjEPOCxQcHRIio5hEMMl2twsde7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=BA+q3BEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A454BC4CEC6;
	Mon,  7 Oct 2024 21:46:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BA+q3BEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1728337566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5g3R0Fta2aE3zdreyusy7y3QAe1R073EkoGwZ6QFIfo=;
	b=BA+q3BEqfuX8ti4WzkO1P2nKoVXR7iboce/WJDYkA4FtPSWbPSuD6WpPi74Pq0uJWuFZVb
	TPS2HHCrn9mdh6Uqh1+743/RgSgn6PzkIVBcSoRa7JMDO5+/WuCNxSwkrzbQohawN2oMGK
	iE44zsqKVitJpzwTYs4lzc4t1Y2n8P4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e0ee8b41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 21:46:06 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kselftest@vger.kernel.org,
	greg@kroah.com,
	skhan@linuxfoundation.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH kselftest v3 2/3] selftests: vDSO: unconditionally build getrandom test
Date: Mon,  7 Oct 2024 23:45:57 +0200
Message-ID: <20241007214558.2590492-2-Jason@zx2c4.com>
In-Reply-To: <20241007214558.2590492-1-Jason@zx2c4.com>
References: <6d8c0894-f3c4-42ff-9794-03d675142a7c@linuxfoundation.org>
 <20241007214558.2590492-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than building on supported archs, build on all archs, and then
use the presence of the symbol in the vDSO to either skip the test or
move forward with it.

Note that this means that this test no longer checks whether the symbol
was correctly added to the kernel. But hopefully this will be clear
enough to developers and we'll cross our fingers that symbols aren't
removed by accident and not caught after this change.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/vDSO/Makefile              | 2 --
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 45641386c662..1cf14a8da438 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -9,9 +9,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += vdso_test_correctness
-ifeq ($(ARCH)$(CONFIG_X86_32),$(filter $(ARCH)$(CONFIG_X86_32),x86 x86_64 loongarch arm64 powerpc s390))
 TEST_GEN_PROGS += vdso_test_getrandom
-endif
 TEST_GEN_PROGS += vdso_test_chacha
 
 CFLAGS := -std=gnu99 -O2
diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 72a1d9b43a84..5489a2f07434 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -119,7 +119,7 @@ static void vgetrandom_init(void)
 	vgrnd.fn = (__typeof__(vgrnd.fn))vdso_sym(version, name);
 	if (!vgrnd.fn) {
 		printf("%s is missing!\n", name);
-		exit(KSFT_FAIL);
+		exit(KSFT_SKIP);
 	}
 	ret = VDSO_CALL(vgrnd.fn, 5, NULL, 0, 0, &vgrnd.params, ~0UL);
 	if (ret == -ENOSYS) {
-- 
2.46.0



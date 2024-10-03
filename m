Return-Path: <linux-kselftest+bounces-18947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C989998E8BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 05:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3DC1F26BA5
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 03:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA481DDF5;
	Thu,  3 Oct 2024 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QualZz+r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED01BDE6
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 03:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727925209; cv=none; b=Sm9Ooj+gwaRvscBk4Q/yNnx712XDIVHpNcX8IyLts+3/Qj1FVCHYnJZPHle6OL6zkBStS/mw7pJK+s01MTrGhFRm9YiYPCcmhmUziP7QCsNEW7F/3JNxddYsUrww4eHRiQA2P5s0jAMIpfqCXqqR2utMRLhw5AokGYYmlEBEQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727925209; c=relaxed/simple;
	bh=r72oGdqo4giJmBRUUj3u/SUFCOLrNAfvjqvoLa9Lb38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZXHHvFEIb18Zc4gSZ5YFLwnksZBYZWlgr9Fa4KJvtKV+aCwGeNk1TITfDaOXvG+T8HXhRSBorzwYPhQgwb679t4wuvCUPKK/gr5rWkDAWUGN0+We0XaW2L0ar/LYrAI2ToFvs1qzXFIt5SfVSVwcejrVwIOvVitpidV0TWeK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QualZz+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A04C4CEC2;
	Thu,  3 Oct 2024 03:13:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QualZz+r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727925206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBOj5y8a+VljKFFcC6IW3SoaUwS8EzfmJCO0yCVTdX0=;
	b=QualZz+r5DFS9NNouS9KNy5vEn74ZSWDHTvkjJ5+ipunSzb/ZFXTzx6Xcw9B/A4POrRQYe
	MH8pY9R6ZLDFuzK0iXvNAjtqtmZDchaESzbGwlCjImbhxZ23gDZSrafByS2hUcqI2Givqb
	2h3jBZ6b+skp/Ljt6GZdP+lqqS/G+H0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1b9742f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Oct 2024 03:13:26 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: skhan@linuxfoundation.org,
	greg@kroah.com,
	linux-kselftest@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH kselftest 2/3] selftests: vDSO: unconditionally build getrandom test
Date: Thu,  3 Oct 2024 05:13:06 +0200
Message-ID: <20241003031307.2236454-3-Jason@zx2c4.com>
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
index 2c38c9c6d056..96b4f2a766e2 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -10,9 +10,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += vdso_test_correctness
-ifeq ($(ARCH)$(CONFIG_X86_32),$(filter $(ARCH)$(CONFIG_X86_32),x86 x86_64 loongarch arm64 powerpc s390))
 TEST_GEN_PROGS += vdso_test_getrandom
-endif
 ifneq ($(wildcard $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S),)
 TEST_GEN_PROGS += vdso_test_chacha
 endif
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



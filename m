Return-Path: <linux-kselftest+bounces-19123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6EB991C95
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 06:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75351F22025
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 04:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D508F156991;
	Sun,  6 Oct 2024 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OhPRGCOY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA6A7F6
	for <linux-kselftest@vger.kernel.org>; Sun,  6 Oct 2024 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728189660; cv=none; b=pUwsmK++9GYGGy0L6vN/bI2GyOvQnbbYlhQ5jUA5D49oFQA2viuk+raamSJo586LSD5oAYgfSy5bVJf3GFdPM0J6mWogGFMBXHwTPKqqFaOdZDjwpI+UPLO9J5YIER2UGEaUsVyMDOo0gL9nEtd3Y5oV2vWF/9YNWDRWSX0DrY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728189660; c=relaxed/simple;
	bh=r72oGdqo4giJmBRUUj3u/SUFCOLrNAfvjqvoLa9Lb38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YADPiAFsRGz15BqU1pNIUgByUEwhywVu9yEse8CzmOA52rTfI9glBCauQU16B2hbhRxJLbqvSvVt4dMVkS/WLeb5GYlCVBHyrSxsJerw8pi3zMDquEStUdeK57TwBK5Av4FlldCllf33yZ+lFo9Uh/4I/AygAN19aOUlPPlFBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=OhPRGCOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1786C4CED8;
	Sun,  6 Oct 2024 04:40:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OhPRGCOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1728189658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBOj5y8a+VljKFFcC6IW3SoaUwS8EzfmJCO0yCVTdX0=;
	b=OhPRGCOYJypyWuPk1SOsPezGcTwBbUMcCPOiZtgBQDxZq785Wy6+dx1nbAzkdtW3aSURnV
	m9UIayiG7Sonx2WgcbdBDLVlXHRblR8iTMc7Tvd51p0Pk6CQeU5emJNg6SqcBPgkALGvXu
	X7hdOw1vnNqCKR0Kj9XOlbySOKbZwU0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0cd072be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 6 Oct 2024 04:40:58 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kselftest@vger.kernel.org,
	greg@kroah.com,
	skhan@linuxfoundation.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH kselftest v2 2/4] selftests: vDSO: unconditionally build getrandom test
Date: Sun,  6 Oct 2024 06:40:15 +0200
Message-ID: <20241006044017.2417623-2-Jason@zx2c4.com>
In-Reply-To: <20241006044017.2417623-1-Jason@zx2c4.com>
References: <CAHmME9qEp8Emg88wWR_oOT39hSaooLDd2L5YPetFrH3O-CgkBQ@mail.gmail.com>
 <20241006044017.2417623-1-Jason@zx2c4.com>
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



Return-Path: <linux-kselftest+bounces-9198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886568B89FE
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98D91C2104A
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D2A8565B;
	Wed,  1 May 2024 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I5vY7/Rg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FC824A3;
	Wed,  1 May 2024 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566561; cv=none; b=TXn8LG4PAREWLEUKWdfof/IHlq/WPKCr+ZiVSTGVDQDsTwW1m0sEhgRwP39CIQqNXu5NQIP+5VUBknJF+VXk/SwhZdZCb3hZfXWa77VqJyA6ITQnnlIQfqP6xLUe/NSj1Kzwc/nSnnFqtsvZ0Z+E5bJtgeIp47WC81GksSTdTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566561; c=relaxed/simple;
	bh=BDVV3j0LA+Ja8NiNd1uE5LhUyS05s3IQNjzH8ZJ04yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mGHQas3fjXNw1pMobn9qoX1yc4zzzRnIveD6CDN5rcaGuxU3XzoBRv+BT7QSFYQGG5UxlRuMlfER7Ki8bSNviLLWlCCO+uF5oEyn115QG48zlmpFN1S/EiO22CTDzO6V4M+EZ1Dg/J4Rn1gKfbX7smd4UrLvhDiMNuQsbEOAFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I5vY7/Rg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714566558;
	bh=BDVV3j0LA+Ja8NiNd1uE5LhUyS05s3IQNjzH8ZJ04yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5vY7/RgxjAEu9tC/qOGjymCqWxP0LFB4g8BhBTsNSxxiXF7fAN9/+J4L0wXjFQQm
	 pJVf+CNs3lsZqLDF5SBpSY31VF5srWR4UiIVLTNZusYOXS5LC0zwApNU9LqkBs05vI
	 jsXqiGPdzIeX3hoFldJWZvZCjIUn519VInUF3JyfGaj6SSWsP+lnvCzFkHooW06VA3
	 X2mPf7mIdaRYWP2resNQdQ1c+hvXmmZII8+vxUG0xazaAqVD+aHtDVBI9Lgg4vOyZ5
	 QSsIkwR4dh5USNiqhuUJOslKy/SPjQJCsUXQmYAInhM/VPVe/IeLk88uxws2IsPawc
	 0bsfyjRTy+NDQ==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 382F8378206E;
	Wed,  1 May 2024 12:29:11 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: kernel@collabora.com
Subject: [PATCH 1/8] selftests: x86: Remove dependence of headers file
Date: Wed,  1 May 2024 17:29:11 +0500
Message-Id: <20240501122918.3831734-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501122918.3831734-1-usama.anjum@collabora.com>
References: <20240501122918.3831734-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove header file dependence to remove the following error caught by
clang.

clang: error: cannot specify -o when generating multiple output files

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/x86/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0b872c0a42d20..671b1819694ff 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -72,10 +72,10 @@ all_64: $(BINARIES_64)
 
 EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
 
-$(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
+$(BINARIES_32): $(OUTPUT)/%_32: %.c
 	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
 
-$(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
+$(BINARIES_64): $(OUTPUT)/%_64: %.c
 	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
 
 # x86_64 users should be encouraged to install 32-bit libraries
-- 
2.39.2



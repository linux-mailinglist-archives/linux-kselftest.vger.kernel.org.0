Return-Path: <linux-kselftest+bounces-9204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E985B8B8A0A
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FC51F2318C
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9CF12D746;
	Wed,  1 May 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IHGSJK5c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0C512D77C;
	Wed,  1 May 2024 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566607; cv=none; b=QhqZUPnLJYHQL0GDUC2zbL49saocYyrMRGDSDXth3fRQ84lJvJx/Ti9kABPTc6QSqeOiCcd3/RNeMr7KmCSyB4Y6z/G1L5ssYkmL0s9o+AAFO+7Dn/bhfO4ZqUQJSPOuKVjiqWH5M1S4KO2IS6Vyyl1lv2syU9No5LcdUKI3HW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566607; c=relaxed/simple;
	bh=ICc8TWkikh7hnbQHCvyG5ZPw/I4G6lKTAIxkSz7bHIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBU7ecHrLjh+OQG0TnlLMsU1vScnEGcMFaMDvhCCxv8ygqKMV8HqRCuLFuQ+kgnQ6fdTPAWY6eDKCK2TmUZFEQ+IjILt38mazkg7S1KFDRz+TGI5qC6LN42CyxopEbG/H8v1vKZGir5NA4gkeBQ8IB7Qy4AxZb+646m24xDPVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IHGSJK5c; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714566605;
	bh=ICc8TWkikh7hnbQHCvyG5ZPw/I4G6lKTAIxkSz7bHIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHGSJK5cY+n+Sl0GWGDHbsWePEXls2zJPDWTmX+R1UFWwLIMGBz27qJdTfp0VvdFG
	 Omia/1d95qKGRcwHlIUUAXb/ArR2iPxxOvZ78HsagroM5iu7D2c4ePRieIPi9IL0Gf
	 RexWapuUeXaT3UK+LM/otabKliQr7G7r32dHGgsQv0H7SGGQFKeq9Y3ccoveD7QGek
	 8xVyyiTGd72XFeZV+gfGpUM68j0MapAJO1ZyNbZzLs+yCAxJkfhImTvTlU50FyHwvr
	 OE4LLFCMVs0rcpkaCsvgDCZKsXy1L26BnGn50aYjXO4KbYTkPQjfNo0siILNm8kwJ1
	 8ru3j50rV5S/w==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C55EC3781FE9;
	Wed,  1 May 2024 12:29:58 +0000 (UTC)
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
Subject: [PATCH 7/8] selftests: x86: fsgsbase: Remove unused function and variable
Date: Wed,  1 May 2024 17:29:17 +0500
Message-Id: <20240501122918.3831734-8-usama.anjum@collabora.com>
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

Remove unused code.

fsgsbase.c:112:20: warning: unused function 'wrfsbase' [-Wunused-function]
  112 | static inline void wrfsbase(unsigned long fsbase)
      |                    ^~~~~~~~
fsgsbase.c:215:22: warning: unused variable 'remote_hard_zero' [-Wunused-variable]
  215 | static volatile bool remote_hard_zero;
      |                      ^~~~~~~~~~~~~~~~

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/x86/fsgsbase.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 8c780cce941da..50cf32de63139 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -109,11 +109,6 @@ static inline void wrgsbase(unsigned long gsbase)
 	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
 }
 
-static inline void wrfsbase(unsigned long fsbase)
-{
-	asm volatile("wrfsbase %0" :: "r" (fsbase) : "memory");
-}
-
 enum which_base { FS, GS };
 
 static unsigned long read_base(enum which_base which)
@@ -212,7 +207,6 @@ static void mov_0_gs(unsigned long initial_base, bool schedule)
 }
 
 static volatile unsigned long remote_base;
-static volatile bool remote_hard_zero;
 static volatile unsigned int ftx;
 
 /*
-- 
2.39.2



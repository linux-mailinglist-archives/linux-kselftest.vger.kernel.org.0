Return-Path: <linux-kselftest+bounces-9205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB908B8A0C
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D141F22A7C
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7007F53E3C;
	Wed,  1 May 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3V3y3Ubp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B51D54FA1;
	Wed,  1 May 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566615; cv=none; b=q0q2YSzhcBRpAJgXw7H2jYpfBuMVx+91CyE4vEq24wBYyFQ1qXWzIRbd66gYt8K+hGbZHNQYpj4UFnftyMW5OIXRlaQyo6S3F/COEJpRKnEuxEjgXLaDRexCgg6niGnfhkGNAJzEkZm/PK3f6DqwAr1FDjS7F6muevBbjuDUQz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566615; c=relaxed/simple;
	bh=mgHPm9EUU+dtIRu1nbBHCvXwznK9GnXXhda7E8pjDlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2SfaE/wIWGqroDoPKYtp3xAd3EfsKxZ5CBpU71tu7U7UxKRG9kfyoLf65IJyRv/BgR2c2KvaqaIO2xDENQiMe6O8mZmd9hnWK3J3pRvsOlO73LcQJkw0pdXDjVY75HSjm++5jXCD+XlZQEed6CAMbGAVM9u8G1FkuYkltoO5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3V3y3Ubp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714566612;
	bh=mgHPm9EUU+dtIRu1nbBHCvXwznK9GnXXhda7E8pjDlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=3V3y3Ubp/4aZYxD6j2zXZiIE1Jw6POYUIzI/Xx4nkvdM4HxUu8stqhdLUzry5HwT1
	 7RoInTTbSgOLHJgQWRi0pTFfRhNtA3cdzhiCtc8tnvU7nQQWuXNvQjVQeY8vdEYXv2
	 siUulCFYspDhbeONErgDSheKZpODrRP0M/h1/awK5wbGid9pCwNuFG3KptQdJvXXjN
	 o4JnFkrHkSt5Obcvl7Cam8kZ9PrYZtPSenedX5rwe0WDJOg5SwoGeIAjNVVo7jmx0r
	 Hn1pEe+XRc4y76N4IQF0bm6CMgqK5n2dk7ZfYyYYi6oBSwsUMDOKjZTcdySM4FK/K2
	 y8c9Lo6g4HstQ==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D22CF378206E;
	Wed,  1 May 2024 12:30:05 +0000 (UTC)
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
Subject: [PATCH 8/8] selftests: x86: amx: Remove unused functions
Date: Wed,  1 May 2024 17:29:18 +0500
Message-Id: <20240501122918.3831734-9-usama.anjum@collabora.com>
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

amx.c:42:24: warning: unused function 'xgetbv' [-Wunused-function]
   42 | static inline uint64_t xgetbv(uint32_t index)
      |                        ^~~~~~
amx.c:167:24: warning: unused function 'get_xstatebv' [-Wunused-function]
  167 | static inline uint64_t get_xstatebv(struct xsave_buffer *buffer)
      |                        ^~~~~~~~~~~~

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/x86/amx.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 95aad6d8849be..1fdf35a4d7f63 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -39,16 +39,6 @@ struct xsave_buffer {
 	};
 };
 
-static inline uint64_t xgetbv(uint32_t index)
-{
-	uint32_t eax, edx;
-
-	asm volatile("xgetbv;"
-		     : "=a" (eax), "=d" (edx)
-		     : "c" (index));
-	return eax + ((uint64_t)edx << 32);
-}
-
 static inline void xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
 {
 	uint32_t rfbm_lo = rfbm;
@@ -164,12 +154,6 @@ static inline void clear_xstate_header(struct xsave_buffer *buffer)
 	memset(&buffer->header, 0, sizeof(buffer->header));
 }
 
-static inline uint64_t get_xstatebv(struct xsave_buffer *buffer)
-{
-	/* XSTATE_BV is at the beginning of the header: */
-	return *(uint64_t *)&buffer->header;
-}
-
 static inline void set_xstatebv(struct xsave_buffer *buffer, uint64_t bv)
 {
 	/* XSTATE_BV is at the beginning of the header: */
-- 
2.39.2



Return-Path: <linux-kselftest+bounces-9203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2B8B8A08
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABAF6B21CFA
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB0012A170;
	Wed,  1 May 2024 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n+pu80e4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5849685948;
	Wed,  1 May 2024 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566601; cv=none; b=IcIrE5g5kwtae1kV4XsHgFkDDAPPreCo2Q/x2t44pCVzrZfcaUQ35ypUQuiVQWCGypbLmBGw+nokMH4Et1wA5FtRoEbxxipnw6APOF9a6ijgLcan1MHmhgZNyPWW9jc3tTiDQEkCNsKI/Tm2ZcqNLWBWV28XK3jWAPhw8/tg8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566601; c=relaxed/simple;
	bh=4UmOKDDwYiVFvITkVWtXuu/Yu5UI+nINe1Tzra+7IWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NHa4srUbv2iqxk/CmYJdGILfJHxj6rDFoJz7sIYPp92OmXkxdJ0fjoOKpYPtDDeH3BfjczuhB4kfxTAEREpO4161OdTWehPIX7YevRcPRsU3qvrCbIh4FSBkfJAsag9g6PSSrM++tCCR3DkZ13FdniHAsYYB4SUKgdWKZM5a6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n+pu80e4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714566598;
	bh=4UmOKDDwYiVFvITkVWtXuu/Yu5UI+nINe1Tzra+7IWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+pu80e4gzO/Mj1WtE/IT4JMPu+55WwZRjc0uAF4ab59BK8ISfDfzyTk4vRzoDLXW
	 ymO/Q0TJDg8D4ZJPMqz7RrsD6lThsV/3NicMhmG8Ca7HrJqzBU5pqytDHpwy/4ekm/
	 CXsY3XKZKx+awPvLc3wIGplqcOdHnaItqouESfZeT1yy38l0JaT5PMiUMSqi0uPAUI
	 1NXtvrlXSPr44s70nY+xFqTGxpkYRh7HB6lsE/CwO/wc75MxkB2rYPV6yXiltKxga/
	 wwCZ9/IxSTRFs7t3vWXwINiael6O8lnL8u9jr6vMTdtZCOmgPAKmHjLN//O7S6+aF7
	 S4ZwZqBnXexcA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BEE0E378206E;
	Wed,  1 May 2024 12:29:49 +0000 (UTC)
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
Subject: [PATCH 6/8] selftests: x86: test_FISTTP: use fisttps instead of ambigous fisttp
Date: Wed,  1 May 2024 17:29:16 +0500
Message-Id: <20240501122918.3831734-7-usama.anjum@collabora.com>
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

Use fisttps instead of fisttp to specify correctly that the output
variable is of size short.

test_FISTTP.c:28:3: error: ambiguous instructions require an explicit suffix (could be 'fisttps', or 'fisttpl')
   28 |         "       fisttp  res16""\n"
      |          ^
<inline asm>:3:2: note: instantiated into assembly here
    3 |         fisttp  res16
      |         ^
test_FISTTP.c:48:3: error: ambiguous instructions require an explicit suffix (could be 'fisttps', or 'fisttpl')
   48 |         "       fisttp  res16""\n"
      |          ^
<inline asm>:3:2: note: instantiated into assembly here
    3 |         fisttp  res16
      |         ^
test_FISTTP.c:69:3: error: ambiguous instructions require an explicit suffix (could be 'fisttps', or 'fisttpl')
   69 |         "       fisttp  res16""\n"
      |          ^
<inline asm>:4:2: note: instantiated into assembly here
    4 |         fisttp  res16
      |         ^
test_FISTTP.c:91:3: error: ambiguous instructions require an explicit suffix (could be 'fisttps', or 'fisttpl')
   91 |         "       fisttp  res16""\n"
      |          ^
<inline asm>:3:2: note: instantiated into assembly here
    3 |         fisttp  res16
      |         ^

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/x86/test_FISTTP.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/x86/test_FISTTP.c b/tools/testing/selftests/x86/test_FISTTP.c
index 09789c0ce3e9c..b9ae9d8cebcb3 100644
--- a/tools/testing/selftests/x86/test_FISTTP.c
+++ b/tools/testing/selftests/x86/test_FISTTP.c
@@ -25,7 +25,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fld1""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fld1""\n"
 	"	fisttpl	res32""\n"
 	"	fld1""\n"
@@ -45,7 +45,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fldpi""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldpi""\n"
 	"	fisttpl	res32""\n"
 	"	fldpi""\n"
@@ -66,7 +66,7 @@ int test(void)
 	asm volatile ("\n"
 	"	fldpi""\n"
 	"	fchs""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldpi""\n"
 	"	fchs""\n"
 	"	fisttpl	res32""\n"
@@ -88,7 +88,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fldln2""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldln2""\n"
 	"	fisttpl	res32""\n"
 	"	fldln2""\n"
-- 
2.39.2



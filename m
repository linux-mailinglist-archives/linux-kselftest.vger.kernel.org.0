Return-Path: <linux-kselftest+bounces-9201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E020B8B8A04
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95CDE1F224A4
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231398565D;
	Wed,  1 May 2024 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IGjlV3tr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B4127B45;
	Wed,  1 May 2024 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566583; cv=none; b=aT1k8CfT9saLTCIVpXJnI4FqV4o7lnSZL3EyVlqCHALEhtdFvoM0ARF0Z9tsRwZ5FmrQyvGUJEA3wYXD+xHpzyRkHvYjEUjX9ACamII1yvsJN1W8cvqKfF5trJr/hZnma5UEcUE9gMDVDR+DczrbaY8bN84prdxqPfYa7V8PCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566583; c=relaxed/simple;
	bh=bEOHjflfaYDMIxFojYVFk6wjf9BpBSYjC7XqEh2ogf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BB5PO7ietJxRKWFuBf/6u4meuqaXBp2gBKuNzzH/RPfWeSdPkIlz5kOj5Jy99qxrhR2gKVLc6Ozk5K8THIReJjNo46zkbdPlxnXeR0tWLEcA6d0Oh5npjZ3Oxn/ZEwgLUqkC8uayyjm3yuBoeQoBHJV/4QuA4fyA92cze+6/SWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IGjlV3tr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714566580;
	bh=bEOHjflfaYDMIxFojYVFk6wjf9BpBSYjC7XqEh2ogf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IGjlV3tr+chnRnHPU7n4Ev3APh3flAo1DGDbZUNwf+K33t3ZBSlvsU5KSP6oUQ9+Z
	 eoWzoiSzefwwKU+LingcQmYXCqT4drU1t1BzityPy+tZEDFVVOPVKyy+KnSP6/FSdM
	 fC/TcfMCelq8/eSMIomsrJ83LKYQ33WjA7hmlb+CrPeD3INCBFZlCyP8CzHr89yM4v
	 lIdlwrtxCtZSfw4eDkxiQUzxNvKbjE0ZGcFZ+leC+wxc5H+ylwQyGQN1syOajLTBb6
	 7OXB5NKkEz15vNg3cylN27B6MU8P1sp/08cVLcqsj+/ryv9uWu+Ss0KGqf2/42Gau3
	 i5SsbaEH1RL6w==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 61ECA3781FE9;
	Wed,  1 May 2024 12:29:32 +0000 (UTC)
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
Subject: [PATCH 4/8] selftests: x86: fsgsbase_restore: fix asm directive from =rm to =r
Date: Wed,  1 May 2024 17:29:14 +0500
Message-Id: <20240501122918.3831734-5-usama.anjum@collabora.com>
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

The clang gives unknown use of instruction mnemonic error. Fix it by
specifying =r only. The operand would be placed in register only.

fsgsbase_restore.c:45:16: error: unknown use of instruction mnemonic without a size suffix
   45 |         asm volatile ("mov %" SEG ":(0), %0" : "=rm" (ret));
      |                       ^
<inline asm>:1:2: note: instantiated into assembly here
    1 |         mov %fs:(0), 20(%esp)
      |         ^
fsgsbase_restore.c:45:16: error: unknown use of instruction mnemonic without a size suffix
   45 |         asm volatile ("mov %" SEG ":(0), %0" : "=rm" (ret));
      |                       ^
<inline asm>:1:2: note: instantiated into assembly here
    1 |         mov %fs:(0), 20(%esp)
      |         ^

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/x86/fsgsbase_restore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/fsgsbase_restore.c b/tools/testing/selftests/x86/fsgsbase_restore.c
index 6fffadc515791..12871b482185b 100644
--- a/tools/testing/selftests/x86/fsgsbase_restore.c
+++ b/tools/testing/selftests/x86/fsgsbase_restore.c
@@ -42,7 +42,7 @@
 static unsigned int dereference_seg_base(void)
 {
 	int ret;
-	asm volatile ("mov %" SEG ":(0), %0" : "=rm" (ret));
+	asm volatile ("mov %" SEG ":(0), %0" : "=r" (ret));
 	return ret;
 }
 
-- 
2.39.2



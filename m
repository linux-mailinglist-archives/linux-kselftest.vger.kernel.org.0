Return-Path: <linux-kselftest+bounces-9202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014428B8A06
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962261F22A7A
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C10512A14B;
	Wed,  1 May 2024 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QQzgQINv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945F1272B2;
	Wed,  1 May 2024 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566591; cv=none; b=o++LocUnpM7BMgwSoT1bkwPHrT56xpGvZsgXu7mME6PjXNbUMSTuYJNtMCswrTOHxmuHmA/YufBeHzCjZ7m0Yd/cyvVILTorbOLE3XCCmIKT9PBt8ol/XNc9VyK2zXUEznpdyAcPg7z2rnnkh1kdDwOYvFKOT7sYviCU4t3VT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566591; c=relaxed/simple;
	bh=02kkD98xtXpmWytoRbt/8oBsWUQRxIDZxvczwotNSNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=suAiKUaU1AbALz0VOXmuGiFKtEaE5lCZ7rivGJIGBw0xP4F5yNr8nj9B7aROm5SwrW001rwDywxYcD3090zg3dDBIvqH+SSM6wi4ygenVG/fK2TSIq5jmr+gjhZM3WSoSVYKBZWPe35F+IgojOV4DXlevpPKuiuboUXbVHmuYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QQzgQINv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714566588;
	bh=02kkD98xtXpmWytoRbt/8oBsWUQRxIDZxvczwotNSNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQzgQINvCL2aW6mGrdXsvXYhDAwpKhaabSivdUJp/R5ctkbSEp6B153BdLRmmoRPa
	 tb08f1q/zhS87GbZaQIn2HnegCia5fm1LH3P6ACwTbTr7MzoHE1akywlmuyLi8AgrV
	 r+i7FPZG865tazojqVkK0EKtbguOY90Qo+NIM3kMivaF+tl49spHBWz49Kd6qgiqX0
	 jbzp0VbFVrKTE1m1OsAFchGqFmL4gl344LxkNHvHNXJ1tTXWOM2brgtW6cVEIus2EN
	 6gtZVwhdPqpKb2Nhz07P12/WUY3LzN5cVafwAiwhJM95XTt20SxUPpz9gr4uYGyyQL
	 HofW6llVsrYDg==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DE68237820A4;
	Wed,  1 May 2024 12:29:40 +0000 (UTC)
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
Subject: [PATCH 5/8] selftests: x86: syscall_arg_fault_32: remove unused variable
Date: Wed,  1 May 2024 17:29:15 +0500
Message-Id: <20240501122918.3831734-6-usama.anjum@collabora.com>
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

Remove unused global variable.

syscall_arg_fault.c:32:30: warning: unused variable 'sig_traps' [-Wunused-variable]
   32 | static volatile sig_atomic_t sig_traps;

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/x86/syscall_arg_fault.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index 461fa41a4d02a..48ab065a76f9b 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -29,7 +29,6 @@ static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		err(1, "sigaction");
 }
 
-static volatile sig_atomic_t sig_traps;
 static sigjmp_buf jmpbuf;
 
 static volatile sig_atomic_t n_errs;
-- 
2.39.2



Return-Path: <linux-kselftest+bounces-48680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF17D0F234
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 15:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 932343005486
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20FD342169;
	Sun, 11 Jan 2026 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpaGKMwu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBFA33D6C7
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142442; cv=none; b=OjS/nkRPvzGhGsUx9oRIDx/gk+sHA1g97IloacO1Yj5yB6MH9+EspPONVM4DUKhdnH1OGVU4JH+TBdEREkSkQRVY78to1u/fZi5hLbrtViuzkOsqf6a1HveM4sJVo4xcAePTaQGyjq15YTcoiBc0mQcMioAVU9DMHxZODJ31SvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142442; c=relaxed/simple;
	bh=wt5uXJ3hBrDjctx9GEBWgfNymhu9EBhsJLGB2dnimeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2ghsdtmJi1xyhAW3XvH6n77+wD1tTlvpG16bFE60UDffMPQAav3a4fUXBe56EnXoHzLORITw9kid9j/8wQqHnWekNg0634pE+fs51sfqiY0rkvfVNefr2qmNz7Y+juvWpd8czC3rqH6DBFCFn018S3GlRUBqyiQvR+KvihNshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpaGKMwu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0ac29fca1so38136915ad.2
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 06:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768142441; x=1768747241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A2jFKetwWtHYbVKM1rPg5F1zCmboTCH4edp2HZEtn+8=;
        b=QpaGKMwu4vmUypi8+bkfMC9V6TEZ5yt7uN0DauHVGazCQvUWljo135Az46J3LxBs7N
         xkeDG0vBxcFMLQuDbgVrodkdLDOlXadEtRuI5nVzsA739NHsL+fr4A6+Xfydsi76sC/9
         o0od0GjwUsQTyvxP7GRbKiUTyoQQoUF1gqGSoO5nUaCK6lAuWpcNun5hXg30dulyhKhP
         lH7WYiLloYc6VQ6DyEcPeAwwGO7euMZNt78+dQ/+WUcrI8lrfN+lQ2Zu9IHDEGKb/nnt
         4IGRYHZpPb+WeCQ/ruiqjZ7FV76LpkzGd81gdwW/GLQvplHe+yiIR9qjP7d9B/FUzgsO
         F5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142441; x=1768747241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2jFKetwWtHYbVKM1rPg5F1zCmboTCH4edp2HZEtn+8=;
        b=BfMeZ3NFlSTFvufBrGkCKRf7ndKL1Zl3dKQjsdOHr1W5wJq0gf5F7fcCUilOKr3WtL
         PJOEcch7enI8IeHgF/OQBo22SMU9LnWI8IuI0YMSb9wqn41eXm53ybmuo8XqGIbXtDXe
         xjfxyUpYHpm4NZEckI9lLzRwe3/WJIykQbkX/iCGbjdZ3T26X+/CvGVcSrvVzjDDbBbh
         2JssI6VOWyRCr/AuJ5FQ0IxfBu9qxiflzV3H+n5X6NHNMlOivXNHS20LTJAF800VvsMp
         vOiu/ErFB11te6qFmXZmzirfR4Xrl0WkKgPdj0RQfG4Xg4gj/awKNdzwQVfDnI8P2c4J
         rwDw==
X-Gm-Message-State: AOJu0YxVa6YKMIQWxNa9QZmuc1owIn048iCEZuU4ngqExZ19CP+lnP5N
	8NPQb6eAQZ5zI/2HDX3zcPbGuOEQ9lUvYAdyRSi0CH6UFgR3bFPvYZ0ESQ/WqhNG
X-Gm-Gg: AY/fxX50TbR+P+Br1yj9Oo0iWtsZwgM5WSJlcUwZvI/o2pcvmxc7GEpKPe+SJXwo2+q
	uUSyTzJa6fHz7dBVZU+skv0DkX1PmhZTxUJTSJeM2+8zXO+9JY+DzPHLaGRvuA6DTxSOsHxUvrg
	Egi3CW1wvrjU6SHoQpF95jAdNRI/5Wt2/BF4KDmxzg9Vc3fScBEucOSDudUikwiN7PStMg/uhYG
	RnlSbM3+XOzvAsa6mhCe0S1fynUMTxBL18SBiqOgcHNB9R+coVqjcpSmOk6dN3xoKbzs7wsLIp4
	YloYWIZ0ryChyI62AtcFOpiD2TTNDC5RltWkFNBItk/48zVsT8hbb5hWDoxvvtIR2pPkg+S5OnK
	JndStQDoaY+FcE5prZGEZmIi0OeSdnrHxhDu9IJoewIwc3LkKVfcO6b1MhFeCPZmOoDURKDbX9X
	CjnuINuxk9EAL/aGij7aYKcsfvJrJxYI/kfIh2T10eXo+FmLeXHv0m6BIALg==
X-Google-Smtp-Source: AGHT+IF/fsvi+m6x+c1HdBAbwfbdxmjcz5RlnjeCB2QNHCjQxK7Kl5XKdSD86n9BNsu1UbPisvAtNA==
X-Received: by 2002:a17:903:247:b0:295:3584:1bbd with SMTP id d9443c01a7336-2a3ee4bff1cmr136444235ad.41.1768142440910;
        Sun, 11 Jan 2026 06:40:40 -0800 (PST)
Received: from neogulmanpassingby-IdeaPad-1-15AMN7.. ([121.148.108.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2c04sm153980615ad.53.2026.01.11.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 06:40:40 -0800 (PST)
From: neogulmanpassingby <jouyeol8739@gmail.com>
To: x86@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	neogulmanpassingby <jouyeol8739@gmail.com>
Subject: [PATCH] selftests/x86: clean up sysret_rip coding style
Date: Sun, 11 Jan 2026 23:39:56 +0900
Message-ID: <20260111143956.70422-1-jouyeol8739@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tidy up sysret_rip style (cast spacing, main(void), const placement).
No functional change intended.

Signed-off-by: neogulmanpassingby <jouyeol8739@gmail.com>
---
 tools/testing/selftests/x86/sysret_rip.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 5fb531e3ad7c..2e423a335e1c 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -31,7 +31,7 @@
 void test_syscall_ins(void);
 extern const char test_page[];
 
-static void const *current_test_page_addr = test_page;
+static const void *current_test_page_addr = test_page;
 
 /* State used by our signal handlers. */
 static gregset_t initial_regs;
@@ -40,7 +40,7 @@ static volatile unsigned long rip;
 
 static void sigsegv_for_sigreturn_test(int sig, siginfo_t *info, void *ctx_void)
 {
-	ucontext_t *ctx = (ucontext_t*)ctx_void;
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
 
 	if (rip != ctx->uc_mcontext.gregs[REG_RIP]) {
 		printf("[FAIL]\tRequested RIP=0x%lx but got RIP=0x%lx\n",
@@ -56,7 +56,7 @@ static void sigsegv_for_sigreturn_test(int sig, siginfo_t *info, void *ctx_void)
 
 static void sigusr1(int sig, siginfo_t *info, void *ctx_void)
 {
-	ucontext_t *ctx = (ucontext_t*)ctx_void;
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
 
 	memcpy(&initial_regs, &ctx->uc_mcontext.gregs, sizeof(gregset_t));
 
@@ -69,8 +69,6 @@ static void sigusr1(int sig, siginfo_t *info, void *ctx_void)
 	       ctx->uc_mcontext.gregs[REG_R11]);
 
 	sethandler(SIGSEGV, sigsegv_for_sigreturn_test, SA_RESETHAND);
-
-	return;
 }
 
 static void test_sigreturn_to(unsigned long ip)
@@ -84,7 +82,7 @@ static jmp_buf jmpbuf;
 
 static void sigsegv_for_fallthrough(int sig, siginfo_t *info, void *ctx_void)
 {
-	ucontext_t *ctx = (ucontext_t*)ctx_void;
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
 
 	if (rip != ctx->uc_mcontext.gregs[REG_RIP]) {
 		printf("[FAIL]\tExpected SIGSEGV at 0x%lx but got RIP=0x%lx\n",
@@ -130,7 +128,7 @@ static void test_syscall_fallthrough_to(unsigned long ip)
 	printf("[OK]\tWe survived\n");
 }
 
-int main()
+int main(void)
 {
 	/*
 	 * When the kernel returns from a slow-path syscall, it will
-- 
2.43.0



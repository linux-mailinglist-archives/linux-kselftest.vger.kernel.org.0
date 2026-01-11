Return-Path: <linux-kselftest+bounces-48693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ED1D0FDFB
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 22:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7A630456B6
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248F317B505;
	Sun, 11 Jan 2026 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3SBW3YI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489122836C
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768165301; cv=none; b=UemnCqKD83DTmZFrH3eclFo1UfY56Bvf0Ml9b/i6++5gAVLR9kpvuxO3yepGp/wGVxWsQjUv9vgQTUBC0h+ZvYpqRFc1RTVICYW48ao8EIPrUTO1nn0vbIa8p/jjcEK8bwqclikY8Bu5gr/Yy9TRkE1TOj7MX4VEbL+qkR3AmGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768165301; c=relaxed/simple;
	bh=6qFY22b8wvd/fXgXqKI9d4C5kX/IWIOe0133W5ImOsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WT/Nl79uaOWtFKOIERMrn4I+T5sYtQsShv8ZBCuelM5YJ3C9QeFRxEilDz6HOH/9ijY2FPNZhVvkg9iIi3uj3rl0PfszzMQZUuPaP7zKnuqxyBGmQBDQG2cTEqbopn4sbTV7WqmfpOQm5RzrxoIoDqc4+t6qN0tEtk3r49WhRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3SBW3YI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c565c3673so2251308a91.0
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 13:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768165299; x=1768770099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRvZMTzGCt2GTIRIoyLg6BepRg6W16l3+xTG2g/n4QA=;
        b=O3SBW3YIEsLtOco7PtbUIpozzSxi1BoLT/NobuCYXpMpzJhfHvERKhJwiv+Bju8srM
         FPdpE/d0svWaIO0WgthehAUFWg8iL9gNMS7BKz0UFjTnPYhcVLvArMpZQMr2uQu7kNld
         HbCbmdRnKb9T2gv0gz0pz2hrA5Joaje/mZms8vqQHiFbF/6z+hkaEZAT+idxULVv2wA3
         HcCCMX+21iW2oVfFpTlJcd+QOhF0GzJ+2f3IzutdbSspvxdK2PSrTqG3xwEvwLASmo0y
         aNW2ygrJvqhFLi4Rh3+NTHd9GLRHtsOqAdycOuaaB9h3OS3nAku/GzT2SKx2s7J1EgWa
         mRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768165299; x=1768770099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRvZMTzGCt2GTIRIoyLg6BepRg6W16l3+xTG2g/n4QA=;
        b=P/yxRDPBltdxZqJ9Vcd3kQlIdW0wqVb7XdNHtKfrMl7k7b/XjYbEQeALKMhovoxPPQ
         v2muOW3OO0dD7KlBpYMCZl9t1q6c43hWaRe0m2f93Bn/7sh1im9SVKc1geqQkuFR0rft
         16sPXO4+rGSsjWIdKNby25sO3xZb/Kp3QOfVDnuWExa7AAczbZFrNTCftVK4OZGJ6Wex
         KNsEcIVsbwzKWEyxvbFPvQKGJCzOsO73ro2PwYuunXPtFo16WZD9yIaLgs2wQ6RcvMpd
         ybQfqKpmNLpyo86VqP6XigSv6xHlm1/6c4rTFZ3JGfxcaI//KtkGmfvj3BRG8OQMIF8V
         9McQ==
X-Gm-Message-State: AOJu0YwkzaeuB5iEvnaYpDV2XbdrJXuBhyySUu8sEzmByZ3BcX8L5eyF
	JUe+MH+s35oiL9xaiDQ0K13xyOyoKov9q766P9JQShq0u1Sx0IpsQeWR
X-Gm-Gg: AY/fxX4smcrxIp8LI961QFpIWEnJqDvBE66OpybhWtJIsEolww0PgWOzMnhoUIuuDwg
	m5SZbm/U9Tvj8zAA7RZcC6uz1zErASr2YVhHMwe6xAIF0sV9oMYGeKJxK5K/BUT0k01l40o4stl
	j1+jKLzaC9OJ5z2QQIsNWSNqwzN8blkjoUGs2YbmRtufRjHKjuejRnHco6bEyi5OSBjT9PhEG5T
	0y+jqcc4xNm/l5L7JRBAB4cJ/yMdXQTOdu+K74FZVgYNy2IBT6ZOaDB8bRoJHoD/AgO6BdoPBbB
	ATd9CXdfTm3yI+qrYQpNLhhKObFVkWaCiFRR5miadqloxhhGIT6GgnnSXYpNmoXW5Blu7ZuS2Rj
	qovAy6RL2YRBcDVjPTo2qm461T6MawqyQMvb+EwYKnB/IJZjZ6XkAPK31XDSxK1g/9OQHBjB4Oq
	D27cUUKDoBiiSTaYdHeAmJ+iFPnzBLmW6kQRHWIdpI9cqKSKbXuYhy55rB7A==
X-Google-Smtp-Source: AGHT+IG38rHBjvWA1hsOUf8/WhsXB2Bn2dOSDUZktYRHPtC8bdb38cHYDaPo1+Dthxs2Bi3nWRPK/Q==
X-Received: by 2002:a17:90b:2dca:b0:34c:2f01:2262 with SMTP id 98e67ed59e1d1-34f5f831c80mr17064982a91.3.1768165298793;
        Sun, 11 Jan 2026 13:01:38 -0800 (PST)
Received: from neogulmanpassingby-IdeaPad-1-15AMN7.. ([121.148.108.47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb64d68sm3346327a91.12.2026.01.11.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 13:01:38 -0800 (PST)
From: UYeol Jo <jouyeol8739@gmail.com>
To: x86@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	UYeol Jo <jouyeol8739@gmail.com>
Subject: [PATCH v2] selftests/x86: clean up sysret_rip coding style
Date: Mon, 12 Jan 2026 06:01:26 +0900
Message-ID: <20260111210126.74752-1-jouyeol8739@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111143956.70422-1-jouyeol8739@gmail.com>
References: <20260111143956.70422-1-jouyeol8739@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tidy up sysret_rip style (cast spacing, main(void), const placement).
No functional change intended.

Signed-off-by: UYeol Jo <jouyeol8739@gmail.com>
---
v2:
- Use real name in Signed-off-by (per feedback). No code changes.

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



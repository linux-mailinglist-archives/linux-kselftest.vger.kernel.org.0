Return-Path: <linux-kselftest+bounces-45696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9EC60C63
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 23:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2DE3AE9DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 22:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FC1267386;
	Sat, 15 Nov 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RMdq3qO2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830AF191F84
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763247413; cv=none; b=YMCbvlHyrovccm+S6IlTkDmVn3kBD3DoZjAzQa4fpSBL+xQPimPCqiu3fTlyWIrNu3x9uxu9oRrfjmnULWheRtDZQPKwSQolSAwb78jACEvjJTZHiX6DD/ObaEznTeyYqY+osg1kpAZfLRsGW0XbtBXJGacJYXZseDc0AfTe5JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763247413; c=relaxed/simple;
	bh=Isqdw0RhAzylXu4IdiwZU689kLt/pJObP5hCd/DHxbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsoN7uNdIdunpGXQzonC6E5CUmn/71KRXKPZl0137RHX40Tz6+eU9FLtXa5WRFGh2Mr9ff1IwuA7LM3R3vGKSswj6WVdxxFuPZ7AtqdXIBdBfbizpre14XHPUAaqgm51fCSb+O6OqegL5hBe0D9ykerpvmH7b7rQfTxyix/IO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RMdq3qO2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso20832105e9.2
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 14:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763247408; x=1763852208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hax3l6ZHFp82yvZa1z7cG8hX78sJJl+3NtBXaKxMPD8=;
        b=RMdq3qO2e67+fzvYUpA22MDxQcGojoSDGqGXVqIrBYpf9X5yrBfggvNKVWz6w01T2c
         tph9ykq0TYcXe0QOwEFtByB6zrzuc/fQYJnEv+HKwBP9L5Ov4JatAT8ZXAie4D+k9Jja
         18ob2KlL+aZn1w8N9uBRlaVIwPlwzF9RZHM48GmDczgZH9aMu+8wlpamy2MymTP5DfQ5
         2M8Wg6Exj3e97TReaqitftzBT5RCx3aLfz9pwrUPAx/FVJVC2DIklHMduUASsWQVI9R3
         +uQV2OipcVUS6dNWqv6WrKKc9sGV1SQCpvLh7U1nCepbudGt25VEvD1QQjy0KP+MzCkr
         CSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763247408; x=1763852208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hax3l6ZHFp82yvZa1z7cG8hX78sJJl+3NtBXaKxMPD8=;
        b=QwqDK723xTogTS/5CneclXgcJp2kHn3yaarp2AGFXMaONCyAiip5DKtqjkZbFFqusx
         HKzVNpMZFe6yax67S+jSSKCnSl3fteKwx6OiiF6JbPsjbEEiumKPO1RbZZiNZy4tUUhn
         nyx7Kjz8MkJQgjYPxSxEPjN7/4Xru2ZLyS/OIDQvEtAYlbNrS6fc2V9gGH5fXRBHr/Rd
         x/Sv8EBRe4K8zlVcItZ4EniE9bAWOMAVD7iWcpSVvJJBDyT+SuuOE0+gPF6/epehDN8Y
         SfkkGctjeN8KmhQLZ5/BbtkgRvJZ0Fmf3quRNoARjl2duyoc1/ZoA7UfowlfoccvqpKZ
         YbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSyBIpkA2toQyI8Ek9o6dYGTzVl0xK+YkldEhVPMKcoSddJTiybItiWgOptCBC0NurEqEWGxGMGxQoMHau2DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQucGYVPu/B3U8AN+MTaDVSoZRYBTYgIiye4HXvRccqio8ygJ
	1ZZB26xJgCIm3ZWK1jfKb1REZPdECkPfqWgzHEibOscPaVhBd33hh/4CoMZelfGitso=
X-Gm-Gg: ASbGncu2Rdq6EXTq5yUW6Go7QBq9OLMST9r8tEZnTh5+XnHwFs9EDOnLItU5oTT4V/j
	ClpRu2Z2cSiq99SrWbgBzg4WcCFfFayM7PRQPDv1xKB/hO0DKuS1DWh0YoxuFKwA7V8+GDK5bkP
	6kDUIAbFHmJoQa2F+4n54enqN0qRmevcTQbgXdSB2EZoccYsU7ez7bYUf5U+XAGTH4vo9DN3z42
	6gswgW4tzhuBx0jZrrAV+hBNfr60Pj8Xhb8h1jeptGG4EjdXKFdE1KtGpQyW0awicXZYDhkj3xF
	UvyEw93NVOAiIqWeO3wMOsaAHs6XS5+vwfbkr8iF7voEBS8eOX9g12QFGfTZvDx4w2AabGe7zob
	Iuv/d/YSUC5gL4+xxmDCB0DOUelSoHhQPZPIdIHLY6p9ONeoRugLTI0IfQhYVq2CsdNAsc+zagV
	Vkj/qzVXBJvK4juE2wEdE1Uwle1MnFDoAE7QyGvkrul7OemmuiVQ==
X-Google-Smtp-Source: AGHT+IEvBVqyOu4uOb4WG4c5ywhNFvW1pjUp9ZjPOqqgZTKbrw3cQLaFupO8D/BR8AI9EmrelD5QmQ==
X-Received: by 2002:a05:600c:6287:b0:477:7f4a:44b4 with SMTP id 5b1f17b1804b1-4778fe60641mr68379945e9.1.1763247408577;
        Sat, 15 Nov 2025 14:56:48 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba1462c605sm6641971b3a.21.2025.11.15.14.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 14:56:46 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [bpf-next v1 4/5] selftests/bpf: replace TCP CC string comparisons with bpf_strncmp
Date: Sun, 16 Nov 2025 07:55:39 +0900
Message-ID: <20251115225550.1086693-5-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115225550.1086693-1-hoyeon.lee@suse.com>
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The connect4_prog and bpf_iter_setsockopt tests duplicate the same
open-coded TCP congestion control string comparison logic. Since
bpf_strncmp() provides the same functionality, use it instead to
avoid repeated open-coded loops.

This change applies only to functional BPF tests and does not affect
the verifier performance benchmarks (veristat.cfg). No functional
changes intended.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 .../selftests/bpf/progs/bpf_iter_setsockopt.c | 17 ++-------------
 .../selftests/bpf/progs/connect4_prog.c       | 21 +++++++------------
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
index 774d4dbe8189..a8aa5a71d846 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
@@ -18,23 +18,10 @@
 
 unsigned short reuse_listen_hport = 0;
 unsigned short listen_hport = 0;
-char cubic_cc[TCP_CA_NAME_MAX] = "bpf_cubic";
+const char cubic_cc[] = "bpf_cubic";
 char dctcp_cc[TCP_CA_NAME_MAX] = "bpf_dctcp";
 bool random_retry = false;
 
-static bool tcp_cc_eq(const char *a, const char *b)
-{
-	int i;
-
-	for (i = 0; i < TCP_CA_NAME_MAX; i++) {
-		if (a[i] != b[i])
-			return false;
-		if (!a[i])
-			break;
-	}
-
-	return true;
-}
 
 SEC("iter/tcp")
 int change_tcp_cc(struct bpf_iter__tcp *ctx)
@@ -58,7 +45,7 @@ int change_tcp_cc(struct bpf_iter__tcp *ctx)
 			   cur_cc, sizeof(cur_cc)))
 		return 0;
 
-	if (!tcp_cc_eq(cur_cc, cubic_cc))
+	if (bpf_strncmp(cur_cc, TCP_CA_NAME_MAX, cubic_cc))
 		return 0;
 
 	if (random_retry && bpf_get_prandom_u32() % 4 == 1)
diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index 9e9ebf27b878..9d158cfad981 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -34,6 +34,9 @@
 #define SOL_TCP 6
 #endif
 
+const char reno[] = "reno";
+const char cubic[] = "cubic";
+
 __attribute__ ((noinline)) __weak
 int do_bind(struct bpf_sock_addr *ctx)
 {
@@ -50,35 +53,27 @@ int do_bind(struct bpf_sock_addr *ctx)
 }
 
 static __inline int verify_cc(struct bpf_sock_addr *ctx,
-			      char expected[TCP_CA_NAME_MAX])
+			      const char expected[])
 {
 	char buf[TCP_CA_NAME_MAX];
-	int i;
 
 	if (bpf_getsockopt(ctx, SOL_TCP, TCP_CONGESTION, &buf, sizeof(buf)))
 		return 1;
 
-	for (i = 0; i < TCP_CA_NAME_MAX; i++) {
-		if (buf[i] != expected[i])
-			return 1;
-		if (buf[i] == 0)
-			break;
-	}
+	if (bpf_strncmp(buf, TCP_CA_NAME_MAX, expected))
+		return 1;
 
 	return 0;
 }
 
 static __inline int set_cc(struct bpf_sock_addr *ctx)
 {
-	char reno[TCP_CA_NAME_MAX] = "reno";
-	char cubic[TCP_CA_NAME_MAX] = "cubic";
-
-	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &reno, sizeof(reno)))
+	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, (void *)reno, sizeof(reno)))
 		return 1;
 	if (verify_cc(ctx, reno))
 		return 1;
 
-	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &cubic, sizeof(cubic)))
+	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, (void *)cubic, sizeof(cubic)))
 		return 1;
 	if (verify_cc(ctx, cubic))
 		return 1;
-- 
2.51.1



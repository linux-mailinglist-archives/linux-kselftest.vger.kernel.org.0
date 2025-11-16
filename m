Return-Path: <linux-kselftest+bounces-45698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ED8C60EA3
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 02:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A488B3AA9F6
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 01:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A81F7575;
	Sun, 16 Nov 2025 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4U8zbLZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68C199FAC
	for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763257373; cv=none; b=eN5rtTwGxYSknoXdwcXNNh4ZGG5k/H8D7I7oxLZGbT9oBccwc/qPuzmN6ZL+jYNuXjlcmIqJNc/Rlbzi0D1w9XAUl2XznqZ2/f8En1n5A0sJA9mEO1sTr0fTgLB+XML0+uWUIcUpYWRXQ1/WMUNY4MYFFtWjVuY6Il7Tw3AH0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763257373; c=relaxed/simple;
	bh=qYNdzOMrVfyqOsFIUuLtig4HQ4c3gJxVv6JUEuRa8uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meuW/CTQHTrj5kkRv5nDFqDd/rK0qd7addbaRDp6dfKZbrD9tGadIXbTshMamVIxRcmwizMRDs8R8AMUQp5VZPxuJtebdGhY8+PF9tWK+73oR6eT0STHpW/laD5SMbmpOxmuSO5QxCiFG2dfaRm8XIJ3ebm5QbW3LJ9I9jbMd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4U8zbLZ; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so4088918a91.1
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 17:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763257371; x=1763862171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAy9YPVCu7bLfM4qk+fenh6vAk3C+JyPIshXGIHtStU=;
        b=g4U8zbLZsOmhccacd4609clPw5cpQtgJRp1jR58mkCMPXJh5DCw6MNawZhv8s20fBl
         ELbqErx/O8J1VC/hFOv0lvLN3xH8CHdcAya80HwP9Id5zqziXYUfWS4GDVD6/YoELprK
         TQGiZowMk91CigMdXrhWqQ0H3rdCF6CDcBVrsC1JDN5RN2Nz98kRz/9j2wdT4HRTF9Wl
         khrGnGJD7FkG8HfHzAYIUptsZBgfuvf7womsSjr03ucn0YSLtHKYgiDTEFvLFC0E8GME
         mXWk4VV16lFgh6b10puD3Lq+Y6Z2wFienLvXNsc5DkL/8U6roIaksuHIRuVnZXf4VpCw
         G6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763257371; x=1763862171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAy9YPVCu7bLfM4qk+fenh6vAk3C+JyPIshXGIHtStU=;
        b=LfUjM5+or8+8xn3lLJ1Voh5tmw9JZy61DiznVr9i9t8KLTqTt6ZQ2EIQy/xa1mGt+t
         7iWtpzRvOxdU3xQFddkxhY6IgxwumE8Gn5JPrJEyilHIyEWnXDrZl7gyW1ru8HgWwAQ1
         cK0/e3naQXToP5ovIgPe5e/8nls78dG81Sc32NllQZDXdlRRo0qe+5pMdfnDyB7QGo1k
         vBmD3xYAbHko+beracXIR/bGjZz1JK4314OpKA7LwPZ+wFlvySkmKraOUBaC+BiUg2gT
         2yKakqmH5B15QtAvnmw+R0/oyJaZNxNibKerBTqgz//xNodgHLZbigqDnp1x9H1Mrjbz
         44hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhoJbfmQV/CMMzNccBx4rNnWBaTKd7x0iL+Z8/ancFE16Bc2KfKso1zRr5kC2YdsmOMGdLjlqMv/INzjtFh0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3HTDX/SFZnVi8qA+wOPYdVdw6rXo7fC4T+iE0Re8dsOmODjiA
	thPH5Eis7tXqsipAD4ZJT3tRhwnXH1aJwRLpBAV8Z0ec8pS9LdVDPnBk
X-Gm-Gg: ASbGncu3xlzjjohSHvT8ylm4iEtNH97MFFflvAdEc3Z6mECVwllH7f9xE7m+ASAGGIU
	wzX1q1ncPrTxGllyFyzI/BNl5eYCtnPqTXVb1TPMHkSycY67f2yjFAWNQqoWAV3w8MP/6BqHFP2
	pt4SFNYOfHeQ1W4lg0FbtHBnk/kyzPliEQxM/xYhcT3jc3uYkzrS6o2cSLps8i+8BpSxzGLFY2Q
	Z/JHnP98DwbtMUZDZlA5mESJ8NaTYMF1JKsJJEYJyfmFv16czS/nAlXeufOaDIrtvov91jeICfR
	2CZgAdFLSfi7Cj5thudFkFdFbNpnJqEVIOZJz5lE2zIfftiW02pSnXcYAhiO0lLFCjOjZT3KWVv
	bTCeO6eqgkTcgGyE3RX9YQFjTXGGNXawydiN0Vv6s6BqxdDr9+m0AI4rvJfI5ePcsOOJOscf2PO
	Qp
X-Google-Smtp-Source: AGHT+IHwMTm+3w4Hi6aGuV3EFYma9rpYV2hO6neS7/j59k0gNdUR5jovUBVjsn0Kg939TBxdL+1jaQ==
X-Received: by 2002:a17:90b:2f08:b0:33b:dec9:d9aa with SMTP id 98e67ed59e1d1-343fa7493admr8502869a91.25.1763257371056;
        Sat, 15 Nov 2025 17:42:51 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36f61bea9sm8243757a12.14.2025.11.15.17.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 17:42:50 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mingo@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: call bpf_get_numa_node_id() in trigger_count()
Date: Sun, 16 Nov 2025 09:42:42 +0800
Message-ID: <20251116014242.151110-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bench test "trig-kernel-count" can be used as a baseline comparison
for fentry and other benchmarks, and the calling to bpf_get_numa_node_id()
should be considered as composition of the baseline. So, let's call it in
trigger_count(). Meanwhile, rename trigger_count() to
trigger_kernel_count() to make it easier understand.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/bpf/benchs/bench_trigger.c | 4 ++--
 tools/testing/selftests/bpf/progs/trigger_bench.c  | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 1e2aff007c2a..34018fc3927f 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -180,10 +180,10 @@ static void trigger_kernel_count_setup(void)
 {
 	setup_ctx();
 	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, false);
-	bpf_program__set_autoload(ctx.skel->progs.trigger_count, true);
+	bpf_program__set_autoload(ctx.skel->progs.trigger_kernel_count, true);
 	load_ctx();
 	/* override driver program */
-	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_count);
+	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_kernel_count);
 }
 
 static void trigger_kprobe_setup(void)
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 3d5f30c29ae3..2898b3749d07 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -42,12 +42,14 @@ int bench_trigger_uprobe_multi(void *ctx)
 const volatile int batch_iters = 0;
 
 SEC("?raw_tp")
-int trigger_count(void *ctx)
+int trigger_kernel_count(void *ctx)
 {
 	int i;
 
-	for (i = 0; i < batch_iters; i++)
+	for (i = 0; i < batch_iters; i++) {
 		inc_counter();
+		bpf_get_numa_node_id();
+	}
 
 	return 0;
 }
-- 
2.51.2



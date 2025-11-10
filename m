Return-Path: <linux-kselftest+bounces-45227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E76C4702F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 14:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 618BF4EBDAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECF02EB875;
	Mon, 10 Nov 2025 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR29Dl4K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461322D780
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782549; cv=none; b=Sq9Wnlx0eBIZekEXYwlOCpu6oJKwJiO+Mfu+QlWnc3sPKyRHE6jaUyv2eFmEOsLByhd9Fa8CODPi9qj92FLDkyredRWR5mRvp99qCjZ9T8FcDPoyYR0ctNOQp295HuwjdlKUugSwLu5yo8IyR1cCYS1xgMSNwIYRuyXp6lgiyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782549; c=relaxed/simple;
	bh=TQ7h6Mz2s/JbJILiZ/3bEy00deZQ+pPh63bYADHti9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8QK7cGNCTrRktB7c3y3LbUwAmXON4BiklglpVwx8/yLVRbW1mVXuZujT0SV3DFKNaaI8OLmivydNlcfdOYChEzKX1W940sP08ticidbMcUNpkY5crnx0EjfwSzveZLgKNBuOxOlhaxCULD49IVQNVDxZ+oTgGVOTnazevVapBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZR29Dl4K; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7aad4823079so2679126b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 05:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762782547; x=1763387347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/QXwQnS4eai1OeNWeo93T9s/bj/XOu9GVduo6Pa63U=;
        b=ZR29Dl4KN1Zo58bbUU+Ac+1Q2bFeTsgjFrXYOD5LbL4xxNITq8aq24ahp49uM2fZxs
         /+2Kko/5gsbrtw+oEcjz+feHL5dtKEzTo5c4yjM2ezHFKpO5oDthn8AXoAIvfoRsGQE4
         dnas0Ar1lNsFT00QPcBGPPvDiLWWFTgfbuUfeOUv0VTmSIM5lYazX73gY7XYMtjWtFcC
         9J3qho6jmbnhW/yrtS9yxwvpPK+pijgUWmhtO9nYYVprrGl29hN0jDUjcwhUSKtF/gPY
         yacupPyZOz7vOG6oG6VuOeLtNquK6YOBkDsm8ayJ7Db7Jy4JTDm6Qwvsozp66UmkY85G
         u1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762782547; x=1763387347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/QXwQnS4eai1OeNWeo93T9s/bj/XOu9GVduo6Pa63U=;
        b=Wnywg+PtCp8EXraI27+agC9pB75dFr0GF08Dn4glq+i7nPV64A3KkdiqnMedZ0oTte
         AAh83bu1YWdeVcgdvMOaC7RGkycbmTf3f2xYsQ/GywrlGqBFY7ExCf39QYBRW0DU1NFm
         4FvdYBGHhZ0sX9l/E2CwF9Ef4So7+pw5YaeCSb1ejsf7H2a1tLUw7+WDCxY08z5tHM9y
         KpHG2gHicCirz/UUkfSmzhBWsp+ZhkJHa3fvQ3b3DtsvQMp9f/Aj4olNL782+Uqmw5jm
         LpasPTC1pXx5zYOk4myY6qXY4BTtPg+mSK1ncfJlw1809L0u9CqzjN/lZOombg7ubse1
         0QuA==
X-Forwarded-Encrypted: i=1; AJvYcCVO6xAN3fsaWsE6XQ+7DPTDQOORhbxC49LIoUoYzvIQDJEJ7spAO4Poxx588x0l2yO0yc8AzSBRGMGM56NZ3T8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuch8un8kY0co22Sk0ZWAisjoMxbuM2xffvRGuTqmwPluoydYc
	7YhgVAMUfVKBJLAUMnx45xAuYeamaSD79qWNnPlKOiH/YPwrbUGPuYwEXAFAJM2h7Gg=
X-Gm-Gg: ASbGncv6pNxcrI1LaUzLsI3H/octTAllyZj+4NY/vxDl3R7K1Y4KIkZsVUPzFVVLBWM
	698cGqTvefWsGFDLatT+xdhtMdxzPYio8Uzd/56OXX+9epjRLiuFtC5VPZvT/FBBQ+926JX3Yl2
	Lp32L1FyPYIOwjI4PkR03i26GUwRUsR9+gJ0pA8VpupJw5E+6tYx8iY/wbRFC9LHJiUj/z4Mbeb
	uhX/yGV/DBVOs5E/2TJJ3EjJ+r72D9Nmn1Nprocb34r+ZHMN0yJrXJEsBbUzaN65q+WIEB0o6Xw
	oT0v0+B8b+90uxwCN8E/S6AE2sgDUXshsP2t+oc4Do22NmJK/Tw7GRS21GM4yhgruZCVQJxo0k7
	6nROtn4Gf0uZHXs3xe0C4aiQuF9kIIDojoUIZCvDfY1iHD5MG//sOm/6WMOBa0kj5hVTw+M4oR9
	cINLRw6jJIgAk=
X-Google-Smtp-Source: AGHT+IEoH96+sjPLREqC+n2bvCIzOJwtJGtj0Xw/w+23Qs6yfYObqzh3NEEEQcrylABhRl8Rgvzm6g==
X-Received: by 2002:a17:902:fc8f:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-297e5413468mr105009555ad.7.1762782547210;
        Mon, 10 Nov 2025 05:49:07 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccca64sm146648475ad.105.2025.11.10.05.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:49:06 -0800 (PST)
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
Subject: [PATCH bpf-next] selftests/bpf: simplify the kernel_count bench trigger
Date: Mon, 10 Nov 2025 21:48:58 +0800
Message-ID: <20251110134858.1664471-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the "trigger_count" in trigger_bench.c and reuse trigger_driver()
instead for trigger_kernel_count_setup().

With the calling to bpf_get_numa_node_id(), the result for "kernel_count"
will become a little more accurate.

It will also easier if we want to test the performance of livepatch, just
hook the bpf_get_numa_node_id() and run the "kernel_count" bench trigger.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/benchs/bench_trigger.c        |  5 +----
 .../testing/selftests/bpf/progs/trigger_bench.c | 17 +++++------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 1e2aff007c2a..34fd8fa3b803 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -179,11 +179,8 @@ static void trigger_syscall_count_setup(void)
 static void trigger_kernel_count_setup(void)
 {
 	setup_ctx();
-	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, false);
-	bpf_program__set_autoload(ctx.skel->progs.trigger_count, true);
+	ctx.skel->rodata->kernel_count = 1;
 	load_ctx();
-	/* override driver program */
-	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_count);
 }
 
 static void trigger_kprobe_setup(void)
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 3d5f30c29ae3..6564d1909c7b 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -39,26 +39,19 @@ int bench_trigger_uprobe_multi(void *ctx)
 	return 0;
 }
 
+const volatile int kernel_count = 0;
 const volatile int batch_iters = 0;
 
-SEC("?raw_tp")
-int trigger_count(void *ctx)
-{
-	int i;
-
-	for (i = 0; i < batch_iters; i++)
-		inc_counter();
-
-	return 0;
-}
-
 SEC("?raw_tp")
 int trigger_driver(void *ctx)
 {
 	int i;
 
-	for (i = 0; i < batch_iters; i++)
+	for (i = 0; i < batch_iters; i++) {
 		(void)bpf_get_numa_node_id(); /* attach point for benchmarking */
+		if (kernel_count)
+			inc_counter();
+	}
 
 	return 0;
 }
-- 
2.51.2



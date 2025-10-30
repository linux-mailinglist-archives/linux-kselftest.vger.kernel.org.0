Return-Path: <linux-kselftest+bounces-44376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A56DC1E2CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 04:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132753BFFDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 03:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C25327215;
	Thu, 30 Oct 2025 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USznZQGP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85272327208
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793226; cv=none; b=SXGLcyNkA7+SLNFxU/7WBnYzKLsdU5bsKCT75b/dIAYHN72aR8Vy5m+rxiOmqDFE+/RsKs/YXaEJtT0kX75TpU0x+ALaSPEkApK8ISzrXJVwGFJVT4qVuTCyx/1si3rjB/8e9djtXR5dWhVL8DZUXAzASQuyXTgHbc2eDWqzruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793226; c=relaxed/simple;
	bh=Te3Qqg21skMEY+Zf/FTGymqKZ4lZb1VgtJ6XqIeV5k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1tM05NUVmhBrodKG/olu7Gc213iH4TKqLG0sON/DUacphfpuSS7BK/VFx+Uqi6mIHL1RAY/E06Ym6X+HIJtlWMARDb6MVBNetV84f+TW/6euXq7Vxu0x23JMBlbb+/jh2/T1hRKcrwerk0ALLw30rF7rq8nfvMM9j/UYebtDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USznZQGP; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7a2852819a8so563547b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 20:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761793224; x=1762398024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWsS8RYrVXuBfcLuM550i2bpPzwaIAKfxKso1SEksyw=;
        b=USznZQGP63zMIQ7dbdF4WharpCbXo2btG77+YItvlkXsganwRYWbtyOfvoQk0MuLKd
         9T39y7ov95/HkoT+PWBXitOYnnsyxHwUUFBXw8ONJJ6ZggdRa49rCGy/LxcR6T4fn5cO
         kMA/huPA4O/zq//oGaGODN2OLlcMecurCpdUj5fT1MaL65SJJljnJiRHcNWvhRjWn1QK
         H/24fHd5mJ9osPjWdyX1veLExCCetOXXtIAcC/b5DFcRG5dP7T/sYnQVnsYU9Ejb5mL/
         vMlwWL6LWppku2GUy2FJgR2b9bm760DNmInf9u0HzqmrHP23moqLp98Tw4BETrv9rC4+
         1czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761793224; x=1762398024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWsS8RYrVXuBfcLuM550i2bpPzwaIAKfxKso1SEksyw=;
        b=RsMFKW/jd7k6p13JBv2zmmEESspTE6DE9sUsJYvVr9Aa4gLGQE5MisKZ21LET39pSX
         vHM6FSg8uB9H9N6G5hPNQ/JBw+IjERnKWXQj1tFz762yIzrEkXweN+5aK1HE+GlzUwxI
         wuuon6eoVjjZQCFQ76Fv+S4GY1xzmPGH7T7XSbKtsX4DDdcQOVHYrRlZ3VKNZS4vP8i8
         wc0fC15VHJkas529bDtfGtBZPUG7qcfM7BqIo05FXBzoCQym23ilpIUmjWwl1Sy5jSYE
         8zh79JKQ0PQ2ZhN0zanMxGYPTVP5HBX6lp4lFD2LkYzBuFiX3I47Z9VaZmHYkXHVuokd
         OIdw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1L+LanEraLLmW6bVSNngbKTSqxkDpJMkEALutu+acqrBDMos2yosAPZ6urkq92Jmmv+GiihJOSk/c4MKzUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7J6u4/Qvx6SU3/BurwqKNXVUEcGuaP/lQjIG9aWgnKmvjtpWO
	t40b16NUVaZY/om6O9aHepTwPU27mLkzAMRc2N+RNcF6yKuxx0MH/QGW
X-Gm-Gg: ASbGnctihUsjhSjfd8YckuU13IwBwUgHm8vgzeq4RaA1dSC4CZOQ4Wvo6Wjbgy2ilwf
	QnEdgyLx5a5WcI/6+AMsNT80MRre2/G5GThXXOSjJXPqycNRF1fmSXYoWs1t8D9aevh1HFU8oJq
	mn6oW7WmnxI5pkhLqT7m9tJLsDNCpbDb7qgSWfU+0yG2fiq0l9X/SuaZ0/UcRpDfvXwX/q1x1Rt
	gGGi0l0a24Ti7fjAWGnyWvAIVyr1oH7H3hlfUoIwDPqGR93zU+GnJszW0WPJ9f71fj9Li4HF3fz
	GH5/XXAN0wVgJq0bUGE5Mol3og4o190OQ8PGsF5K9UlFeUXVnVShA7+maI8aHbffEHFsZnIWeGf
	j+OCJQLgRZR12aoe4HVRjoD+JGh6YtLdy8m217YPbGGBhK1U+nShsfLmrk0g28LPTn+dGluNJQf
	TF
X-Google-Smtp-Source: AGHT+IHIOxODJc6x3Ql8tbDxUwO+ru4mm4BxkhquziJBp3ejW2ZSGQ7R/i+QqTRyisGmInBi9dXrGg==
X-Received: by 2002:a05:6a00:3c86:b0:781:1f6c:1c69 with SMTP id d2e1a72fcca58-7a4e4725df4mr4746711b3a.20.1761793223438;
        Wed, 29 Oct 2025 20:00:23 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012b19sm16663311b3a.12.2025.10.29.20.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:00:22 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: martin.lau@linux.dev,
	leon.hwang@linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: use rqspinlock for lru map
Date: Thu, 30 Oct 2025 11:00:09 +0800
Message-ID: <20251030030010.95352-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251030030010.95352-1-dongml2@chinatelecom.cn>
References: <20251030030010.95352-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, raw_spinlock is used during adding, deleting and updating in the
bpf lru map, which can lead to deadlock if it is done in the NMI context,
as described in [1].

Fix this by convert the raw_spinlock_t in bpf_lru_list and
bpf_lru_locallist to rqspinlock_t.

Link: https://lore.kernel.org/bpf/CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com/
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/bpf_lru_list.c | 47 +++++++++++++++++++++++----------------
 kernel/bpf/bpf_lru_list.h |  5 +++--
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index e7a2fc60523f..38fddcb1e28c 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -307,9 +307,10 @@ static void bpf_lru_list_push_free(struct bpf_lru_list *l,
 	if (WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(node->type)))
 		return;
 
-	raw_spin_lock_irqsave(&l->lock, flags);
+	if (raw_res_spin_lock_irqsave(&l->lock, flags))
+		return;
 	__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_FREE);
-	raw_spin_unlock_irqrestore(&l->lock, flags);
+	raw_res_spin_unlock_irqrestore(&l->lock, flags);
 }
 
 static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
@@ -319,7 +320,8 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 	struct bpf_lru_node *node, *tmp_node;
 	unsigned int nfree = 0;
 
-	raw_spin_lock(&l->lock);
+	if (raw_res_spin_lock(&l->lock))
+		return;
 
 	__local_list_flush(l, loc_l);
 
@@ -338,7 +340,7 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 				      local_free_list(loc_l),
 				      BPF_LRU_LOCAL_LIST_T_FREE);
 
-	raw_spin_unlock(&l->lock);
+	raw_res_spin_unlock(&l->lock);
 }
 
 static void __local_list_add_pending(struct bpf_lru *lru,
@@ -404,7 +406,8 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 
 	l = per_cpu_ptr(lru->percpu_lru, cpu);
 
-	raw_spin_lock_irqsave(&l->lock, flags);
+	if (raw_res_spin_lock_irqsave(&l->lock, flags))
+		return NULL;
 
 	__bpf_lru_list_rotate(lru, l);
 
@@ -420,7 +423,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
 
-	raw_spin_unlock_irqrestore(&l->lock, flags);
+	raw_res_spin_unlock_irqrestore(&l->lock, flags);
 
 	return node;
 }
@@ -437,7 +440,8 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 
 	loc_l = per_cpu_ptr(clru->local_list, cpu);
 
-	raw_spin_lock_irqsave(&loc_l->lock, flags);
+	if (raw_res_spin_lock_irqsave(&loc_l->lock, flags))
+		return NULL;
 
 	node = __local_list_pop_free(loc_l);
 	if (!node) {
@@ -448,7 +452,7 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 	if (node)
 		__local_list_add_pending(lru, loc_l, cpu, node, hash);
 
-	raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+	raw_res_spin_unlock_irqrestore(&loc_l->lock, flags);
 
 	if (node)
 		return node;
@@ -466,23 +470,26 @@ static struct bpf_lru_node *bpf_common_lru_pop_free(struct bpf_lru *lru,
 	do {
 		steal_loc_l = per_cpu_ptr(clru->local_list, steal);
 
-		raw_spin_lock_irqsave(&steal_loc_l->lock, flags);
+		if (raw_res_spin_lock_irqsave(&steal_loc_l->lock, flags))
+			goto out_next;
 
 		node = __local_list_pop_free(steal_loc_l);
 		if (!node)
 			node = __local_list_pop_pending(lru, steal_loc_l);
 
-		raw_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
+		raw_res_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
 
+out_next:
 		steal = cpumask_next_wrap(steal, cpu_possible_mask);
 	} while (!node && steal != first_steal);
 
 	loc_l->next_steal = steal;
 
 	if (node) {
-		raw_spin_lock_irqsave(&loc_l->lock, flags);
+		if (raw_res_spin_lock_irqsave(&loc_l->lock, flags))
+			return NULL;
 		__local_list_add_pending(lru, loc_l, cpu, node, hash);
-		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+		raw_res_spin_unlock_irqrestore(&loc_l->lock, flags);
 	}
 
 	return node;
@@ -511,10 +518,11 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 
 		loc_l = per_cpu_ptr(lru->common_lru.local_list, node->cpu);
 
-		raw_spin_lock_irqsave(&loc_l->lock, flags);
+		if (raw_res_spin_lock_irqsave(&loc_l->lock, flags))
+			return;
 
 		if (unlikely(node->type != BPF_LRU_LOCAL_LIST_T_PENDING)) {
-			raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+			raw_res_spin_unlock_irqrestore(&loc_l->lock, flags);
 			goto check_lru_list;
 		}
 
@@ -522,7 +530,7 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 		bpf_lru_node_clear_ref(node);
 		list_move(&node->list, local_free_list(loc_l));
 
-		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
+		raw_res_spin_unlock_irqrestore(&loc_l->lock, flags);
 		return;
 	}
 
@@ -538,11 +546,12 @@ static void bpf_percpu_lru_push_free(struct bpf_lru *lru,
 
 	l = per_cpu_ptr(lru->percpu_lru, node->cpu);
 
-	raw_spin_lock_irqsave(&l->lock, flags);
+	if (raw_res_spin_lock_irqsave(&l->lock, flags))
+		return;
 
 	__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_FREE);
 
-	raw_spin_unlock_irqrestore(&l->lock, flags);
+	raw_res_spin_unlock_irqrestore(&l->lock, flags);
 }
 
 void bpf_lru_push_free(struct bpf_lru *lru, struct bpf_lru_node *node)
@@ -625,7 +634,7 @@ static void bpf_lru_locallist_init(struct bpf_lru_locallist *loc_l, int cpu)
 
 	loc_l->next_steal = cpu;
 
-	raw_spin_lock_init(&loc_l->lock);
+	raw_res_spin_lock_init(&loc_l->lock);
 }
 
 static void bpf_lru_list_init(struct bpf_lru_list *l)
@@ -640,7 +649,7 @@ static void bpf_lru_list_init(struct bpf_lru_list *l)
 
 	l->next_inactive_rotation = &l->lists[BPF_LRU_LIST_T_INACTIVE];
 
-	raw_spin_lock_init(&l->lock);
+	raw_res_spin_lock_init(&l->lock);
 }
 
 int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index fe2661a58ea9..61fc7d7f9de1 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -7,6 +7,7 @@
 #include <linux/cache.h>
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
+#include <asm-generic/rqspinlock.h>
 
 #define NR_BPF_LRU_LIST_T	(3)
 #define NR_BPF_LRU_LIST_COUNT	(2)
@@ -34,13 +35,13 @@ struct bpf_lru_list {
 	/* The next inactive list rotation starts from here */
 	struct list_head *next_inactive_rotation;
 
-	raw_spinlock_t lock ____cacheline_aligned_in_smp;
+	rqspinlock_t lock ____cacheline_aligned_in_smp;
 };
 
 struct bpf_lru_locallist {
 	struct list_head lists[NR_BPF_LRU_LOCAL_LIST_T];
 	u16 next_steal;
-	raw_spinlock_t lock;
+	rqspinlock_t lock;
 };
 
 struct bpf_common_lru {
-- 
2.51.2



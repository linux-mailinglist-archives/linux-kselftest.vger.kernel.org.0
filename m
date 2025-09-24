Return-Path: <linux-kselftest+bounces-42235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3CBB9B931
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 20:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5546D421E65
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 18:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700FE319843;
	Wed, 24 Sep 2025 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1gLLP0p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA667302CC0
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740270; cv=none; b=QPyrcNUq38TlRQY0Y1XniZVd4O6SPJ+QJniaZHxwxr2BPXgy8kgKx7jdQQ/AXMu0c/7nSTIsH/Nji8I+BnmseXn0GcS4I5UAozK7/I9DSFIDTQjcMBgnDg6oNN/DdN/JJGzisIZMhs7wzau74JojBLnbTmaWy16WFqUFN1+pFDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740270; c=relaxed/simple;
	bh=jpLnBWZZe2F6s/vLpAdmj3DMAln1pp2GrsR2pnQ+Rp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUxEO+6tC+dTYA5ySw5pa4LpKQBWtUIeu2tuO2DclV7Dc5mziGuXQt4iY1pp1qwR3fbIqpRnKVwGRYeHyBLY16nnnzDBcnBCcvpdiBRhumnfcn9af3I+7weTbc/RqQeYIWI1q9B4vCwDve0pVtnXfy8J2gFFMdRIlLc/HNjhgn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1gLLP0p; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b2b7d5ff690so2765366b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 11:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758740265; x=1759345065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iulbwacfRVlRTzpkKA4MCu7Q/APAfZNBrN5ZQOOCoqQ=;
        b=N1gLLP0p4bq0rQjtqu3GEQSk3YhZYbFvXC4a15pDzOxylhQiAGrGabqe8DbQKrNBYr
         qq/aN7knzLmbdPoMDzowyiH/TCyoGcMOyYoec91tv0gwj6G/chmtRvB87BX/ad1fVIlR
         IqATapkSUboeS+7SR6BfXu11MESNPnsxa/xyC/JKUNg5VA2xav+0PH1KLQU8T3TzJtcQ
         1JQ9GooE4vaSNI8LliLRNDyRBRpFyEf8qLDqJtFiS5CQmaWfEXbitoYRwgXvaoT0l/yi
         1UmESXBvwdHdgBly6+f/HZmSMgFL/pULo5VeBzzrOuod5QiMjvf+/DhfjJ6+AvxpzbYO
         xv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758740265; x=1759345065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iulbwacfRVlRTzpkKA4MCu7Q/APAfZNBrN5ZQOOCoqQ=;
        b=cmChtGCwO3/zd3GlsL8fpQ7y2MUBAg6FBlcPWkXdX1uiMB3G0+5KSpfVTCwPHSKjuj
         I+xCAghcxNoUjJjCHb7UraczAbgj1kbwPTuZhY3NmkIyYSAj7Z3CZ0bjUW0TzPlB0fv1
         Sfm5XLa65oaR/vOBZX19cp6WEjbKErZcsClsO/t085p0f5fjME3t4w38ChJ/kpyStuM+
         CVM+qQAFBo32d0c6rpML757Kt3gul3BqrHr2rDjORGc9DbBJ0Ni46Z08eQCx+OVQMyBo
         c2ZBHENUCaDIOj5GljBQ2tlV9OLhywJN4iOS0Cb1PjMzq7wMMBrvEJ/QvnDpxiEx8Zdn
         2pwA==
X-Forwarded-Encrypted: i=1; AJvYcCUox17x7gxgqzapnpOg3TMWjzetHTDvhNkutsnH51hJJhnrctnsJWdrqMGQypCDSaAXWKPe5+HWIrsDKspgFW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZwZtx+LGPvmC23Har/WW95BVysQqdiJvm+SmdMb7SC4gc/fW
	BvDZWjHk8phGrGmaTYAhDk79wrMr2BY9gkOqXkTeMRgdztVJd/N723kY
X-Gm-Gg: ASbGnctYIcwRGdJ8mbzAohEh0PmFqyuVhVYJQsyRlGEIDIFDpufX2jIY0U8+kxWhV+v
	KIATjPYzD8zGVu1fzv4jLhGUvy6740njSw5JTFZrX9qEFaBVN2V5SBIHHFM5WDANJQp/QSMY3eB
	fKWj3wVu2MWZwxIhPLTDXVM9pjIHSxAjwK7itA5xGja2/1JsWUD9rBnbGUYQTte2hd25XtyAH6x
	oU+7sZ6ukO8DuiG9U3lu7HBRgqTC1N5vPTKoDUtfN1W3biIjF7QgXRUyf4RuFCmpkjALR10L5Di
	uRypKvJZuWe6CpRhBRiYDgkVlOLN06uCZEQ7p1pBcOlpoAudGGzjOUL/R4AigIM7BkuEk+SB/UY
	ChamgiqeYyNVnBwTmrPsh+TAWxw8KoB7YDwY=
X-Google-Smtp-Source: AGHT+IHaluzl7O1ZDyaeqnhSPBLk1zGOIdk0/RXfQ5IZR00PV3jzsOX4Pwg1WFlzJANoJ+ST751Yyw==
X-Received: by 2002:a17:907:3c8c:b0:b04:669f:e70f with SMTP id a640c23a62f3a-b34b72093b3mr45042266b.2.1758740264438;
        Wed, 24 Sep 2025 11:57:44 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2a88413acbsm886059766b.24.2025.09.24.11.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:57:44 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	linux@jordanrome.com,
	ameryhung@gmail.com,
	toke@redhat.com,
	houtao1@huawei.com,
	emil@etsalapatis.com,
	yatsenko@meta.com,
	isolodrai@meta.com,
	a.s.protopopov@gmail.com,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	vmalik@redhat.com,
	bigeasy@linutronix.de,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	mrpre@163.com,
	jakub@cloudflare.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Add -Wsign-compare C compilation flag
Date: Wed, 24 Sep 2025 20:57:11 +0100
Message-ID: <20250924195731.6374-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-Change all the source files and the corresponding headers 
to having matching sign comparisons.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Changelog:

Changes since v1:
- Fix CI failed builds where it failed due to do missing .c and
.h files in my patch for working in mainline.
https://lore.kernel.org/bpf/20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com/T/#u
---
 tools/lib/bpf/usdt.bpf.h                         |  4 ++--
 tools/testing/selftests/bpf/Makefile             |  4 ++--
 tools/testing/selftests/bpf/bpf_arena_htab.h     |  2 +-
 tools/testing/selftests/bpf/progs/arena_list.c   |  2 +-
 .../bpf/progs/bench_local_storage_create.c       |  2 +-
 tools/testing/selftests/bpf/progs/bind_perm.c    |  2 +-
 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c |  2 +-
 tools/testing/selftests/bpf/progs/bpf_cubic.c    |  8 ++++----
 .../bpf/progs/bpf_iter_bpf_percpu_array_map.c    |  2 +-
 .../selftests/bpf/progs/bpf_iter_task_stack.c    |  2 +-
 .../testing/selftests/bpf/progs/bpf_iter_tasks.c |  3 ++-
 .../selftests/bpf/progs/bpf_iter_vma_offset.c    |  4 ++--
 .../testing/selftests/bpf/progs/bpf_qdisc_fifo.c |  2 +-
 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c |  4 ++--
 .../bpf/progs/cgroup_getset_retval_getsockopt.c  |  6 +++---
 .../selftests/bpf/progs/connect4_dropper.c       |  2 +-
 .../selftests/bpf/progs/cpumask_success.c        |  4 ++--
 .../testing/selftests/bpf/progs/dynptr_success.c |  8 ++++----
 tools/testing/selftests/bpf/progs/iters.c        | 16 ++++++++--------
 .../selftests/bpf/progs/kfunc_call_test.c        |  2 +-
 tools/testing/selftests/bpf/progs/linked_list.c  | 10 +++++-----
 tools/testing/selftests/bpf/progs/lsm.c          |  2 +-
 .../testing/selftests/bpf/progs/map_in_map_btf.c |  2 +-
 tools/testing/selftests/bpf/progs/map_ptr_kern.c |  2 +-
 .../selftests/bpf/progs/mmap_inner_array.c       |  2 +-
 .../testing/selftests/bpf/progs/mptcp_subflow.c  |  2 +-
 .../selftests/bpf/progs/netif_receive_skb.c      |  4 ++--
 tools/testing/selftests/bpf/progs/profiler.inc.h |  6 +++---
 .../testing/selftests/bpf/progs/rcu_read_lock.c  |  4 ++--
 .../bpf/progs/sk_storage_omem_uncharge.c         |  6 +++---
 .../selftests/bpf/progs/sockopt_inherit.c        |  4 ++--
 tools/testing/selftests/bpf/progs/sockopt_sk.c   |  4 ++--
 tools/testing/selftests/bpf/progs/strobemeta.h   |  2 +-
 .../selftests/bpf/progs/task_local_data.bpf.h    |  6 +++---
 .../selftests/bpf/progs/test_bpf_cookie.c        |  2 +-
 .../testing/selftests/bpf/progs/test_check_mtu.c |  4 ++--
 .../selftests/bpf/progs/test_core_extern.c       |  2 +-
 .../testing/selftests/bpf/progs/test_get_xattr.c |  4 ++--
 .../selftests/bpf/progs/test_global_func11.c     |  2 +-
 .../selftests/bpf/progs/test_global_func12.c     |  2 +-
 .../selftests/bpf/progs/test_global_func13.c     |  2 +-
 .../selftests/bpf/progs/test_global_func14.c     |  2 +-
 .../selftests/bpf/progs/test_global_func9.c      |  2 +-
 .../selftests/bpf/progs/test_lwt_seg6local.c     |  4 ++--
 .../testing/selftests/bpf/progs/test_map_init.c  |  2 +-
 .../selftests/bpf/progs/test_parse_tcp_hdr_opt.c |  2 +-
 .../bpf/progs/test_parse_tcp_hdr_opt_dynptr.c    |  2 +-
 .../selftests/bpf/progs/test_pkt_access.c        |  6 +++---
 .../testing/selftests/bpf/progs/test_seg6_loop.c |  4 ++--
 tools/testing/selftests/bpf/progs/test_skb_ctx.c |  2 +-
 .../testing/selftests/bpf/progs/test_snprintf.c  |  2 +-
 .../selftests/bpf/progs/test_sockmap_kern.h      |  2 +-
 .../selftests/bpf/progs/test_sockmap_strp.c      |  2 +-
 .../testing/selftests/bpf/progs/test_tc_tunnel.c |  2 +-
 tools/testing/selftests/bpf/progs/test_xdp.c     |  2 +-
 .../selftests/bpf/progs/test_xdp_dynptr.c        |  2 +-
 .../testing/selftests/bpf/progs/test_xdp_loop.c  |  2 +-
 .../selftests/bpf/progs/test_xdp_noinline.c      |  4 ++--
 tools/testing/selftests/bpf/progs/udp_limit.c    |  2 +-
 tools/testing/selftests/bpf/progs/uprobe_multi.c |  4 ++--
 .../bpf/progs/uprobe_multi_session_recursive.c   |  5 +++--
 .../selftests/bpf/progs/verifier_arena_large.c   |  4 ++--
 .../bpf/progs/verifier_iterating_callbacks.c     |  2 +-
 63 files changed, 109 insertions(+), 107 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 43deb05a5197..59095c7f5b65 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -148,7 +148,7 @@ int bpf_usdt_arg_size(struct pt_regs *ctx, __u64 arg_num)
 	if (arg_num >= BPF_USDT_MAX_ARG_CNT)
 		return -ENOENT;
 	barrier_var(arg_num);
-	if (arg_num >= spec->arg_cnt)
+	if (arg_num >= (__u64)spec->arg_cnt)
 		return -ENOENT;
 
 	arg_spec = &spec->args[arg_num];
@@ -184,7 +184,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 	if (arg_num >= BPF_USDT_MAX_ARG_CNT)
 		return -ENOENT;
 	barrier_var(arg_num);
-	if (arg_num >= spec->arg_cnt)
+	if (arg_num >= (__u64)spec->arg_cnt)
 		return -ENOENT;
 
 	arg_spec = &spec->args[arg_num];
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0b6ee902bce5..1b3c0c9388cc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -453,8 +453,8 @@ BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 	     -I$(abspath $(OUTPUT)/../usr/include)			\
 	     -std=gnu11		 					\
 	     -fno-strict-aliasing 					\
-	     -Wno-compare-distinct-pointer-types
-# TODO: enable me -Wsign-compare
+	     -Wno-compare-distinct-pointer-types			\
+	     -Wsign-compare
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
 
diff --git a/tools/testing/selftests/bpf/bpf_arena_htab.h b/tools/testing/selftests/bpf/bpf_arena_htab.h
index acc01a876668..ad77514c3cb1 100644
--- a/tools/testing/selftests/bpf/bpf_arena_htab.h
+++ b/tools/testing/selftests/bpf/bpf_arena_htab.h
@@ -42,7 +42,7 @@ static hashtab_elem_t *lookup_elem_raw(arena_list_head_t *head, __u32 hash, int
 	hashtab_elem_t *l;
 
 	list_for_each_entry(l, head, hash_node)
-		if (l->hash == hash && l->key == key)
+		if ((__u32)l->hash == hash && l->key == key)
 			return l;
 
 	return NULL;
diff --git a/tools/testing/selftests/bpf/progs/arena_list.c b/tools/testing/selftests/bpf/progs/arena_list.c
index 3a2ddcacbea6..02676f77a4cf 100644
--- a/tools/testing/selftests/bpf/progs/arena_list.c
+++ b/tools/testing/selftests/bpf/progs/arena_list.c
@@ -50,7 +50,7 @@ int arena_list_add(void *ctx)
 
 	list_head = &global_head;
 
-	for (i = zero; i < cnt && can_loop; i++) {
+	for (i = zero; i < (__u64)cnt && can_loop; i++) {
 		struct elem __arena *n = bpf_alloc(sizeof(*n));
 
 		test_val++;
diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
index c8ec0d0368e4..2b23e59bc04a 100644
--- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
@@ -44,7 +44,7 @@ int BPF_PROG(sched_process_fork, struct task_struct *parent, struct task_struct
 {
 	struct storage *stg;
 
-	if (parent->tgid != bench_pid)
+	if ((__u32)parent->tgid != bench_pid)
 		return 0;
 
 	stg = bpf_task_storage_get(&task_storage_map, child, NULL,
diff --git a/tools/testing/selftests/bpf/progs/bind_perm.c b/tools/testing/selftests/bpf/progs/bind_perm.c
index 7bd2a027025d..e629909c97b6 100644
--- a/tools/testing/selftests/bpf/progs/bind_perm.c
+++ b/tools/testing/selftests/bpf/progs/bind_perm.c
@@ -7,7 +7,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
-static __always_inline int bind_prog(struct bpf_sock_addr *ctx, int family)
+static __always_inline int bind_prog(struct bpf_sock_addr *ctx, __u32 family)
 {
 	struct bpf_sock *sk;
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
index 4e51785e7606..76b4184713e2 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
@@ -91,7 +91,7 @@ static void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked,
 			(__u64)tp->snd_ssthresh * prr_delivered + tp->prior_cwnd - 1;
 		sndcnt = (__u32)div64_u64(dividend, (__u64)tp->prior_cwnd) - tp->prr_out;
 	} else {
-		sndcnt = max(prr_delivered - tp->prr_out, newly_acked_sacked);
+		sndcnt = max(prr_delivered - tp->prr_out, (__u32)newly_acked_sacked);
 		if (flag & FLAG_SND_UNA_ADVANCED && !newly_lost)
 			sndcnt++;
 		sndcnt = min(delta, sndcnt);
diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cubic.c
index f089faa97ae6..100937488d2d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic.c
@@ -277,7 +277,7 @@ static void bictcp_update(struct bpf_bictcp *ca, __u32 cwnd, __u32 acked)
 	ca->ack_cnt += acked;	/* count the number of ACKed packets */
 
 	if (ca->last_cwnd == cwnd &&
-	    (__s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
+	    (__s32)(tcp_jiffies32 - ca->last_time) <= (__s32)HZ / 32)
 		return;
 
 	/* The CUBIC function can update ca->cnt at most once per jiffy.
@@ -474,7 +474,7 @@ static void hystart_update(struct sock *sk, __u32 delay)
 			if (sk->sk_pacing_status == SK_PACING_NONE)
 				threshold >>= 1;
 
-			if ((__s32)(now - ca->round_start) > threshold) {
+			if ((__s32)(now - ca->round_start) > (__s32)threshold) {
 				ca->found = 1;
 				tp->snd_ssthresh = tp->snd_cwnd;
 			}
@@ -512,7 +512,7 @@ void BPF_PROG(bpf_cubic_acked, struct sock *sk, const struct ack_sample *sample)
 		return;
 
 	/* Discard delay samples right after fast recovery */
-	if (ca->epoch_start && (__s32)(tcp_jiffies32 - ca->epoch_start) < HZ)
+	if (ca->epoch_start && (__s32)(tcp_jiffies32 - ca->epoch_start) < (__s32)HZ)
 		return;
 
 	delay = sample->rtt_us;
@@ -525,7 +525,7 @@ void BPF_PROG(bpf_cubic_acked, struct sock *sk, const struct ack_sample *sample)
 
 	/* hystart triggers when cwnd is larger than some threshold */
 	if (!ca->found && tcp_in_slow_start(tp) && hystart &&
-	    tp->snd_cwnd >= hystart_low_window)
+	    tp->snd_cwnd >= (__u32)hystart_low_window)
 		hystart_update(sk, delay);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
index 9fdea8cd4c6f..0baf00463f35 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
@@ -24,7 +24,7 @@ int dump_bpf_percpu_array_map(struct bpf_iter__bpf_map_elem *ctx)
 	__u32 *key = ctx->key;
 	void *pptr = ctx->value;
 	__u32 step;
-	int i;
+	__u32 i;
 
 	if (key == (void *)0 || pptr == (void *)0)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
index f5a309455490..647ec1aa0326 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
@@ -27,7 +27,7 @@ int dump_task_stack(struct bpf_iter__task *ctx)
 	BPF_SEQ_PRINTF(seq, "pid: %8u num_entries: %8u\n", task->pid,
 		       retlen / SIZE_OF_ULONG);
 	for (i = 0; i < MAX_STACK_TRACE_DEPTH; i++) {
-		if (retlen > i * SIZE_OF_ULONG)
+		if ((__u32)retlen > i * SIZE_OF_ULONG)
 			BPF_SEQ_PRINTF(seq, "[<0>] %pB\n", (void *)entries[i]);
 	}
 	BPF_SEQ_PRINTF(seq, "\n");
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
index 966ee5a7b066..704db7589565 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
@@ -115,7 +115,8 @@ int dump_task_sleepable(struct bpf_iter__task *ctx)
 	/* Same length as the string */
 	ret = bpf_copy_from_user_task_str((char *)task_str2, 10, user_ptr, task, 0);
 	/* only need to do the task pid check once */
-	if (bpf_strncmp(task_str2, 10, "test_data\0") != 0 || ret != 10 || task->tgid != pid) {
+	if (bpf_strncmp(task_str2, 10, "test_data\0") != 0 || ret != 10 ||
+			(__u32)task->tgid != pid) {
 		BPF_SEQ_PRINTF(seq, "%s\n", info);
 		return 0;
 	}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c b/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
index 174298e122d3..d9088851babf 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
@@ -22,11 +22,11 @@ int get_vma_offset(struct bpf_iter__task_vma *ctx)
 	if (task == NULL || vma == NULL)
 		return 0;
 
-	if (last_tgid != task->tgid)
+	if (last_tgid != (__u32)task->tgid)
 		unique_tgid_cnt++;
 	last_tgid = task->tgid;
 
-	if (task->tgid != pid)
+	if ((__u32)task->tgid != pid)
 		return 0;
 
 	if (vma->vm_start <= address && vma->vm_end > address) {
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
index 1de2be3e370b..7a639dcb23a9 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
@@ -88,7 +88,7 @@ void BPF_PROG(bpf_fifo_reset, struct Qdisc *sch)
 {
 	struct bpf_list_node *node;
 	struct skb_node *skbn;
-	int i;
+	__u32 i;
 
 	bpf_for(i, 0, sch->q.qlen) {
 		struct sk_buff *skb = NULL;
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
index 1a3233a275c7..4f80164b5491 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
@@ -351,7 +351,7 @@ int BPF_PROG(bpf_fq_enqueue, struct sk_buff *skb, struct Qdisc *sch,
 
 			jiffies = bpf_jiffies64();
 			if ((s64)(jiffies - (flow_copy->age + q.flow_refill_delay)) > 0) {
-				if (flow_copy->credit < q.quantum)
+				if ((__u32)flow_copy->credit < q.quantum)
 					flow_copy->credit = q.quantum;
 			}
 			flow_copy->age = 0;
@@ -590,7 +590,7 @@ struct sk_buff *BPF_PROG(bpf_fq_dequeue, struct Qdisc *sch)
 {
 	struct dequeue_nonprio_ctx cb_ctx = {};
 	struct sk_buff *skb = NULL;
-	int i;
+	__u32 i;
 
 	if (!sch->q.qlen)
 		goto out;
diff --git a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
index 932b8ecd4ae3..854dae839f7f 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
@@ -22,7 +22,7 @@ int get_retval(struct bpf_sockopt *ctx)
 	__sync_fetch_and_add(&invocations, 1);
 
 	/* optval larger than PAGE_SIZE use kernel's buffer. */
-	if (ctx->optlen > page_size)
+	if ((__u32)ctx->optlen > page_size)
 		ctx->optlen = 0;
 
 	return 1;
@@ -37,7 +37,7 @@ int set_eisconn(struct bpf_sockopt *ctx)
 		assertion_error = 1;
 
 	/* optval larger than PAGE_SIZE use kernel's buffer. */
-	if (ctx->optlen > page_size)
+	if ((__u32)ctx->optlen > page_size)
 		ctx->optlen = 0;
 
 	return 1;
@@ -51,7 +51,7 @@ int clear_retval(struct bpf_sockopt *ctx)
 	ctx->retval = 0;
 
 	/* optval larger than PAGE_SIZE use kernel's buffer. */
-	if (ctx->optlen > page_size)
+	if ((__u32)ctx->optlen > page_size)
 		ctx->optlen = 0;
 
 	return 1;
diff --git a/tools/testing/selftests/bpf/progs/connect4_dropper.c b/tools/testing/selftests/bpf/progs/connect4_dropper.c
index a3819a5d09c8..0014f8de9d1c 100644
--- a/tools/testing/selftests/bpf/progs/connect4_dropper.c
+++ b/tools/testing/selftests/bpf/progs/connect4_dropper.c
@@ -20,7 +20,7 @@ int connect_v4_dropper(struct bpf_sock_addr *ctx)
 {
 	if (ctx->type != SOCK_STREAM)
 		return VERDICT_PROCEED;
-	if (ctx->user_port == bpf_htons(port))
+	if (ctx->user_port == (__u32)bpf_htons(port))
 		return VERDICT_REJECT;
 	return VERDICT_PROCEED;
 }
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 0e04c31b91c0..c09e290fbdac 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -221,7 +221,7 @@ int BPF_PROG(test_first_firstzero_cpu, struct task_struct *task, u64 clone_flags
 	if (!cpumask)
 		return 0;
 
-	if (bpf_cpumask_first(cast(cpumask)) < nr_cpus) {
+	if (bpf_cpumask_first(cast(cpumask)) < (__u32)nr_cpus) {
 		err = 3;
 		goto release_exit;
 	}
@@ -866,7 +866,7 @@ int BPF_PROG(test_populate, struct task_struct *task, u64 clone_flags)
 	 * access NR_CPUS, the upper bound for nr_cpus, so we infer
 	 * it from the size of cpumask_t.
 	 */
-	if (nr_cpus < 0 || nr_cpus >= CPUMASK_TEST_MASKLEN * 8) {
+	if (nr_cpus < 0 || (__u32)nr_cpus >= CPUMASK_TEST_MASKLEN * 8) {
 		err = 3;
 		goto out;
 	}
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index 127dea342e5a..149b9308105e 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -40,7 +40,7 @@ int test_read_write(void *ctx)
 	char write_data[64] = "hello there, world!!";
 	char read_data[64] = {};
 	struct bpf_dynptr ptr;
-	int i;
+	__u32 i;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 0;
@@ -114,7 +114,7 @@ int test_dynptr_data(void *ctx)
 	if (err)
 		return 0;
 
-	if (val != *(int *)data)
+	if ((int)val != *(int *)data)
 		err = 5;
 
 	return 0;
@@ -626,7 +626,7 @@ int BPF_PROG(test_dynptr_skb_tp_btf, void *skb, void *location)
 
 static inline int bpf_memcmp(const char *a, const char *b, u32 size)
 {
-	int i;
+	__u32 i;
 
 	bpf_for(i, 0, size) {
 		if (a[i] != b[i])
@@ -937,7 +937,7 @@ static __always_inline void test_dynptr_probe(void *ptr, bpf_read_dynptr_fn_t bp
 {
 	char buf[sizeof(expected_str)];
 	struct bpf_dynptr ptr_buf;
-	int i;
+	__u32 i;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return;
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 7dd92a303bf6..bb896fd7b364 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -369,7 +369,7 @@ SEC("raw_tp")
 __success
 int iter_array_fill(const void *ctx)
 {
-	int sum, i;
+	__u32 sum, i;
 
 	MY_PID_GUARD();
 
@@ -395,7 +395,7 @@ SEC("raw_tp")
 __success
 int iter_nested_iters(const void *ctx)
 {
-	int sum, row, col;
+	__u64 sum, row, col;
 
 	MY_PID_GUARD();
 
@@ -463,7 +463,7 @@ int iter_nested_deeply_iters(const void *ctx)
 
 static __noinline void fill_inner_dimension(int row)
 {
-	int col;
+	__u64 col;
 
 	bpf_for(col, 0, ARRAY_SIZE(arr2d[0])) {
 		arr2d[row][col] = row * col;
@@ -472,7 +472,7 @@ static __noinline void fill_inner_dimension(int row)
 
 static __noinline int sum_inner_dimension(int row)
 {
-	int sum = 0, col;
+	__u64 sum = 0, col;
 
 	bpf_for(col, 0, ARRAY_SIZE(arr2d[0])) {
 		sum += arr2d[row][col];
@@ -487,7 +487,7 @@ SEC("raw_tp")
 __success
 int iter_subprog_iters(const void *ctx)
 {
-	int sum, row, col;
+	__u64 sum, row, col;
 
 	MY_PID_GUARD();
 
@@ -626,7 +626,7 @@ __success
 int iter_stack_array_loop(const void *ctx)
 {
 	long arr1[16], arr2[16], sum = 0;
-	int i;
+	__u32 i;
 
 	MY_PID_GUARD();
 
@@ -663,7 +663,7 @@ static __noinline void fill(struct bpf_iter_num *it, int *arr, __u32 n, int mul)
 
 	while ((t = bpf_iter_num_next(it))) {
 		i = *t;
-		if (i >= n)
+		if ((__u32)i >= n)
 			break;
 		arr[i] =  i * mul;
 	}
@@ -1537,7 +1537,7 @@ int iter_arr_with_actual_elem_count(const void *ctx)
 {
 	int i, n = loop_data.n, sum = 0;
 
-	if (n > ARRAY_SIZE(loop_data.data))
+	if ((__u64)n > ARRAY_SIZE(loop_data.data))
 		return 0;
 
 	bpf_for(i, 0, n) {
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index 8b86113a0126..c4e570662b54 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -108,7 +108,7 @@ int kfunc_syscall_test(struct syscall_test_args *args)
 {
 	const long size = args->size;
 
-	if (size > sizeof(args->data))
+	if ((__u64)size > sizeof(args->data))
 		return -7; /* -E2BIG */
 
 	bpf_kfunc_call_test_mem_len_pass1(&args->data, sizeof(args->data));
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 421f40835acd..d817c8a483f3 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -110,7 +110,7 @@ int list_push_pop_multiple(struct bpf_spin_lock *lock, struct bpf_list_head *hea
 {
 	struct bpf_list_node *n;
 	struct foo *f[200], *pf;
-	int i;
+	__u64 i;
 
 	/* Loop following this check adds nodes 2-at-a-time in order to
 	 * validate multiple release_on_unlock release logic
@@ -144,7 +144,7 @@ int list_push_pop_multiple(struct bpf_spin_lock *lock, struct bpf_list_head *hea
 		if (!n)
 			return 3;
 		pf = container_of(n, struct foo, node2);
-		if (pf->data != (ARRAY_SIZE(f) - i - 1)) {
+		if ((__u64)pf->data != (ARRAY_SIZE(f) - i - 1)) {
 			bpf_obj_drop(pf);
 			return 4;
 		}
@@ -163,7 +163,7 @@ int list_push_pop_multiple(struct bpf_spin_lock *lock, struct bpf_list_head *hea
 		if (!n)
 			return 5;
 		pf = container_of(n, struct foo, node2);
-		if (pf->data != i) {
+		if ((__u64)pf->data != i) {
 			bpf_obj_drop(pf);
 			return 6;
 		}
@@ -193,7 +193,7 @@ int list_in_list(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool le
 	struct bpf_list_node *n;
 	struct bar *ba[8], *b;
 	struct foo *f;
-	int i;
+	__u64 i;
 
 	f = bpf_obj_new(typeof(*f));
 	if (!f)
@@ -238,7 +238,7 @@ int list_in_list(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool le
 			return 6;
 		}
 		b = container_of(n, struct bar, node);
-		if (b->data != i) {
+		if ((__u64)b->data != i) {
 			bpf_obj_drop(f);
 			bpf_obj_drop(b);
 			return 7;
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index 0c13b7409947..bb6a4bb6e364 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -115,7 +115,7 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 	__u32 key = 0;
 	__u64 *value;
 
-	if (monitored_pid == pid)
+	if ((__u32)monitored_pid == pid)
 		bprm_count++;
 
 	bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_start);
diff --git a/tools/testing/selftests/bpf/progs/map_in_map_btf.c b/tools/testing/selftests/bpf/progs/map_in_map_btf.c
index 7a1336d7b16a..719368217fe8 100644
--- a/tools/testing/selftests/bpf/progs/map_in_map_btf.c
+++ b/tools/testing/selftests/bpf/progs/map_in_map_btf.c
@@ -49,7 +49,7 @@ int add_to_list_in_inner_array(void *ctx)
 	struct bpf_map *map;
 	int zero = 0;
 
-	if (done || (u32)bpf_get_current_pid_tgid() != pid)
+	if (done || (__u32)bpf_get_current_pid_tgid() != (__u32)pid)
 		return 0;
 
 	map = bpf_map_lookup_elem(&outer_array, &zero);
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index efaf622c28dd..310526d06233 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -148,7 +148,7 @@ static inline int check_array(void)
 {
 	struct bpf_array *array = (struct bpf_array *)&m_array;
 	struct bpf_map *map = (struct bpf_map *)&m_array;
-	int i, n_lookups = 0, n_keys = 0;
+	__u32 i, n_lookups = 0, n_keys = 0;
 
 	VERIFY(check_default(&array->map, map));
 
diff --git a/tools/testing/selftests/bpf/progs/mmap_inner_array.c b/tools/testing/selftests/bpf/progs/mmap_inner_array.c
index 90aacbc2938a..90e31cf3a4d3 100644
--- a/tools/testing/selftests/bpf/progs/mmap_inner_array.c
+++ b/tools/testing/selftests/bpf/progs/mmap_inner_array.c
@@ -38,7 +38,7 @@ int add_to_list_in_inner_array(void *ctx)
 	__u64 *value;
 
 	curr_pid = (u32)bpf_get_current_pid_tgid();
-	if (done || curr_pid != pid)
+	if (done || curr_pid != (__u32)pid)
 		return 0;
 
 	pid_match = true;
diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index 70302477e326..8af5c2dfc08c 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -63,7 +63,7 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
 {
 	struct mptcp_subflow_context *subflow;
-	int i = 0;
+	__u32 i = 0;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk;
diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
index 9e067dcbf607..920b884eef01 100644
--- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
+++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
@@ -35,7 +35,7 @@ static int __strncmp(const void *m1, const void *m2, size_t len)
 {
 	const unsigned char *s1 = m1;
 	const unsigned char *s2 = m2;
-	int i, delta = 0;
+	size_t i, delta = 0;
 
 	for (i = 0; i < len; i++) {
 		delta = s1[i] - s2[i];
@@ -107,7 +107,7 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
 	/* Ensure we can write skb string representation */
 	p.type_id = bpf_core_type_id_kernel(struct sk_buff);
 	p.ptr = skb;
-	for (i = 0; i < ARRAY_SIZE(flags); i++) {
+	for (i = 0; (size_t)i < ARRAY_SIZE(flags); i++) {
 		++num_subtests;
 		ret = bpf_snprintf_btf(str, STRSIZE, &p, sizeof(p), 0);
 		if (ret < 0)
diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index 813143b4985d..f664f5915169 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -169,7 +169,7 @@ static INLINE int get_var_spid_index(struct var_kill_data_arr_t* arr_struct,
 #ifdef UNROLL
 	__pragma_loop_unroll
 #endif
-	for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++)
+	for (size_t i = 0; i < ARRAY_SIZE(arr_struct->array); i++)
 		if (arr_struct->array[i].meta.pid == spid)
 			return i;
 	return -1;
@@ -402,7 +402,7 @@ static INLINE int trace_var_sys_kill(void* ctx, int tpid, int sig)
 #ifdef UNROLL
 			__pragma_loop_unroll
 #endif
-			for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++)
+			for (size_t i = 0; i < ARRAY_SIZE(arr_struct->array); i++)
 				if (arr_struct->array[i].meta.pid == 0) {
 					bpf_probe_read_kernel(&arr_struct->array[i],
 							      sizeof(arr_struct->array[i]),
@@ -629,7 +629,7 @@ int raw_tracepoint__sched_process_exit(void* ctx)
 #ifdef UNROLL
 	__pragma_loop_unroll
 #endif
-	for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(arr_struct->array); i++) {
 		struct var_kill_data_t* past_kill_data = &arr_struct->array[i];
 
 		if (past_kill_data != NULL && past_kill_data->kill_target_pid == (pid_t)tpid) {
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index 3a868a199349..38fa039f586b 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -34,7 +34,7 @@ int get_cgroup_id(void *ctx)
 	struct css_set *cgroups;
 
 	task = bpf_get_current_task_btf();
-	if (task->pid != target_pid)
+	if ((__u32)task->pid != target_pid)
 		return 0;
 
 	/* simulate bpf_get_current_cgroup_id() helper */
@@ -56,7 +56,7 @@ int task_succ(void *ctx)
 	long *ptr;
 
 	task = bpf_get_current_task_btf();
-	if (task->pid != target_pid)
+	if ((__u32)task->pid != target_pid)
 		return 0;
 
 	bpf_rcu_read_lock();
diff --git a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
index 46d6eb2a3b17..2df842c7e9ed 100644
--- a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
+++ b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
@@ -28,7 +28,7 @@ int BPF_PROG(bpf_local_storage_destroy, struct bpf_local_storage *local_storage)
 		return 0;
 
 	sk = bpf_core_cast(sk_ptr, struct sock);
-	if (sk->sk_cookie.counter != cookie)
+	if ((__u64)sk->sk_cookie.counter != cookie)
 		return 0;
 
 	cookie_found++;
@@ -43,11 +43,11 @@ int BPF_PROG(inet6_sock_destruct, struct sock *sk)
 {
 	int *value;
 
-	if (!cookie || sk->sk_cookie.counter != cookie)
+	if (!cookie || (__u64)sk->sk_cookie.counter != cookie)
 		return 0;
 
 	value = bpf_sk_storage_get(&sk_storage, sk, 0, 0);
-	if (value && *value == 0xdeadbeef) {
+	if (value && (__u32)*value == 0xdeadbeef) {
 		cookie_found++;
 		sk_ptr = sk;
 		local_storage_ptr = sk->sk_bpf_storage;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_inherit.c b/tools/testing/selftests/bpf/progs/sockopt_inherit.c
index a3434b840928..9f15752af34b 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_inherit.c
@@ -56,7 +56,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	struct sockopt_inherit *storage;
 	__u8 *optval = ctx->optval;
 
-	if (ctx->level != SOL_CUSTOM)
+	if (ctx->level != (__s32)SOL_CUSTOM)
 		goto out; /* only interested in SOL_CUSTOM */
 
 	if (optval + 1 > optval_end)
@@ -87,7 +87,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	struct sockopt_inherit *storage;
 	__u8 *optval = ctx->optval;
 
-	if (ctx->level != SOL_CUSTOM)
+	if (ctx->level != (__s32)SOL_CUSTOM)
 		goto out; /* only interested in SOL_CUSTOM */
 
 	if (optval + 1 > optval_end)
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index cb990a7d3d45..f08529dfb2cb 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -107,7 +107,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		return 1;
 	}
 
-	if (ctx->level != SOL_CUSTOM)
+	if (ctx->level != (__s32)SOL_CUSTOM)
 		return 0; /* deny everything except custom level */
 
 	if (optval + 1 > optval_end)
@@ -212,7 +212,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		return 1;
 	}
 
-	if (ctx->level != SOL_CUSTOM)
+	if (ctx->level != (__s32)SOL_CUSTOM)
 		return 0; /* deny everything except custom level */
 
 	if (optval + 1 > optval_end)
diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index a5c74d31a244..36b4e82abae2 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -409,7 +409,7 @@ static __always_inline uint64_t read_map_var(struct strobemeta_cfg *cfg,
 
 	descr->id = map.id;
 	descr->cnt = map.cnt;
-	if (cfg->req_meta_idx == idx) {
+	if (cfg->req_meta_idx == (__s64)idx) {
 		data->req_id = map.id;
 		data->req_meta_valid = 1;
 	}
diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
index 432fff2af844..51a958d04aa7 100644
--- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
+++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
@@ -181,7 +181,7 @@ static int __tld_fetch_key(struct tld_object *tld_obj, const char *name, int i_s
 	metadata = tld_obj->data_map->meta->metadata;
 
 	bpf_for(i, 0, cnt) {
-		if (i >= TLD_MAX_DATA_CNT)
+		if ((__u32)i >= TLD_MAX_DATA_CNT)
 			break;
 
 		if (i >= i_start && !bpf_strncmp(metadata[i].name, TLD_NAME_LEN, name))
@@ -214,7 +214,7 @@ static int __tld_fetch_key(struct tld_object *tld_obj, const char *name, int i_s
 		if (likely(_data)) {							\
 			if (likely(off > 0)) {						\
 				barrier_var(off);					\
-				if (likely(off < __PAGE_SIZE - size))			\
+				if (likely((size_t)off < __PAGE_SIZE - size))			\
 					data = _data + off;				\
 			} else {							\
 				cnt = -(off);						\
@@ -223,7 +223,7 @@ static int __tld_fetch_key(struct tld_object *tld_obj, const char *name, int i_s
 					off = __tld_fetch_key(tld_obj, name, cnt);	\
 					(tld_obj)->key_map->key.off = off;		\
 											\
-					if (likely(off < __PAGE_SIZE - size)) {		\
+					if (likely((size_t)off < __PAGE_SIZE - size)) {		\
 						barrier_var(off);			\
 						if (off > 0)				\
 							data = _data + off;		\
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
index c83142b55f47..47e80864b6b8 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
@@ -6,7 +6,7 @@
 #include <bpf/bpf_tracing.h>
 #include <errno.h>
 
-int my_tid;
+__u32 my_tid;
 
 __u64 kprobe_res;
 __u64 kprobe_multi_res;
diff --git a/tools/testing/selftests/bpf/progs/test_check_mtu.c b/tools/testing/selftests/bpf/progs/test_check_mtu.c
index 2ec1de11a3ae..246caea8124f 100644
--- a/tools/testing/selftests/bpf/progs/test_check_mtu.c
+++ b/tools/testing/selftests/bpf/progs/test_check_mtu.c
@@ -47,7 +47,7 @@ int xdp_use_helper(struct xdp_md *ctx)
 		goto out;
 	}
 
-	if (mtu_len != GLOBAL_USER_MTU)
+	if (mtu_len != (__u32)GLOBAL_USER_MTU)
 		retval = XDP_DROP;
 
 out:
@@ -165,7 +165,7 @@ int tc_use_helper(struct __sk_buff *ctx)
 		goto out;
 	}
 
-	if (mtu_len != GLOBAL_USER_MTU)
+	if (mtu_len != (__u32)GLOBAL_USER_MTU)
 		retval = BPF_REDIRECT;
 out:
 	global_bpf_mtu_tc = mtu_len;
diff --git a/tools/testing/selftests/bpf/progs/test_core_extern.c b/tools/testing/selftests/bpf/progs/test_core_extern.c
index a3c7c1042f35..4eae1eb885f1 100644
--- a/tools/testing/selftests/bpf/progs/test_core_extern.c
+++ b/tools/testing/selftests/bpf/progs/test_core_extern.c
@@ -37,7 +37,7 @@ uint64_t missing_val = -1;
 SEC("raw_tp/sys_enter")
 int handle_sys_enter(struct pt_regs *ctx)
 {
-	int i;
+	__u32 i;
 
 	kern_ver = LINUX_KERNEL_VERSION;
 	unkn_virt_val = LINUX_UNKNOWN_VIRTUAL_EXTERN;
diff --git a/tools/testing/selftests/bpf/progs/test_get_xattr.c b/tools/testing/selftests/bpf/progs/test_get_xattr.c
index 54305f4c9f2d..3cda9379a62a 100644
--- a/tools/testing/selftests/bpf/progs/test_get_xattr.c
+++ b/tools/testing/selftests/bpf/progs/test_get_xattr.c
@@ -42,7 +42,7 @@ int BPF_PROG(test_file_open, struct file *f)
 
 	bpf_dynptr_from_mem(value1, sizeof(value1), 0, &value_ptr);
 
-	for (i = 0; i < ARRAY_SIZE(xattr_names); i++) {
+	for (i = 0; (__u32)i < ARRAY_SIZE(xattr_names); i++) {
 		ret = bpf_get_file_xattr(f, xattr_names[i], &value_ptr);
 		if (ret == sizeof(expected_value))
 			break;
@@ -68,7 +68,7 @@ int BPF_PROG(test_inode_getxattr, struct dentry *dentry, char *name)
 
 	bpf_dynptr_from_mem(value2, sizeof(value2), 0, &value_ptr);
 
-	for (i = 0; i < ARRAY_SIZE(xattr_names); i++) {
+	for (i = 0; (__u32)i < ARRAY_SIZE(xattr_names); i++) {
 		ret = bpf_get_dentry_xattr(dentry, xattr_names[i], &value_ptr);
 		if (ret == sizeof(expected_value))
 			break;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func11.c b/tools/testing/selftests/bpf/progs/test_global_func11.c
index 283e036dc401..2ad72bf0e07b 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func11.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func11.c
@@ -5,7 +5,7 @@
 #include "bpf_misc.h"
 
 struct S {
-	int x;
+	__u32 x;
 };
 
 __noinline int foo(const struct S *s)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func12.c b/tools/testing/selftests/bpf/progs/test_global_func12.c
index 6e03d42519a6..53eab8ec6772 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func12.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func12.c
@@ -5,7 +5,7 @@
 #include "bpf_misc.h"
 
 struct S {
-	int x;
+	__u32 x;
 };
 
 __noinline int foo(const struct S *s)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func13.c b/tools/testing/selftests/bpf/progs/test_global_func13.c
index 02ea80da75b5..c4afdfc9d92e 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func13.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func13.c
@@ -5,7 +5,7 @@
 #include "bpf_misc.h"
 
 struct S {
-	int x;
+	__u32 x;
 };
 
 __noinline int foo(const struct S *s)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func14.c b/tools/testing/selftests/bpf/progs/test_global_func14.c
index 33b7d5efd7b2..9c494fb39e2f 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func14.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func14.c
@@ -9,7 +9,7 @@ struct S;
 __noinline int foo(const struct S *s)
 {
 	if (s)
-		return bpf_get_prandom_u32() < *(const int *) s;
+		return bpf_get_prandom_u32() < *(const __u32 *) s;
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func9.c b/tools/testing/selftests/bpf/progs/test_global_func9.c
index 1f2cb0159b8d..9138d9bd08fc 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func9.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func9.c
@@ -5,7 +5,7 @@
 #include "bpf_misc.h"
 
 struct S {
-	int x;
+	__u32 x;
 };
 
 struct C {
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c b/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
index fed66f36adb6..976af2d3cdda 100644
--- a/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
+++ b/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
@@ -167,7 +167,7 @@ int is_valid_tlv_boundary(struct __sk_buff *skb, struct ip6_srh_t *srh,
 	if (*pad_off == 0)
 		*pad_off = cur_off;
 
-	if (*tlv_off == -1)
+	if (*tlv_off == (__u32)-1)
 		*tlv_off = cur_off;
 	else if (!offset_valid)
 		return -EINVAL;
@@ -186,7 +186,7 @@ int add_tlv(struct __sk_buff *skb, struct ip6_srh_t *srh, uint32_t tlv_off,
 	uint32_t partial_srh_len;
 	int err;
 
-	if (tlv_off != -1)
+	if (tlv_off != (__u32)-1)
 		tlv_off += srh_off;
 
 	if (itlv->type == SR6_TLV_PADDING || itlv->type == SR6_TLV_HMAC)
diff --git a/tools/testing/selftests/bpf/progs/test_map_init.c b/tools/testing/selftests/bpf/progs/test_map_init.c
index c89d28ead673..311e6ac64588 100644
--- a/tools/testing/selftests/bpf/progs/test_map_init.c
+++ b/tools/testing/selftests/bpf/progs/test_map_init.c
@@ -22,7 +22,7 @@ int sysenter_getpgid(const void *ctx)
 	/* Just do it for once, when called from our own test prog. This
 	 * ensures the map value is only updated for a single CPU.
 	 */
-	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+	__u32 cur_pid = bpf_get_current_pid_tgid() >> 32;
 
 	if (cur_pid == inPid)
 		bpf_map_update_elem(&hashmap1, &inKey, &inValue, BPF_NOEXIST);
diff --git a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c
index d9b2ba7ac340..4b8ab8716246 100644
--- a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c
+++ b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c
@@ -102,7 +102,7 @@ int xdp_ingress_v6(struct xdp_md *xdp)
 	opt_state.byte_offset = sizeof(struct tcphdr) + tcp_offset;
 
 	/* max number of bytes of options in tcp header is 40 bytes */
-	for (int i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
+	for (__u32 i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
 		err = parse_hdr_opt(xdp, &opt_state);
 
 		if (err || !opt_state.hdr_bytes_remaining)
diff --git a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c
index dc6e43bc6a62..bf3ac5c2938c 100644
--- a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c
@@ -100,7 +100,7 @@ int xdp_ingress_v6(struct xdp_md *xdp)
 	off += sizeof(struct tcphdr);
 
 	/* max number of bytes of options in tcp header is 40 bytes */
-	for (int i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
+	for (__u32 i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
 		err = parse_hdr_opt(&ptr, &off, &hdr_bytes_remaining, &server_id);
 
 		if (err || !hdr_bytes_remaining)
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index bce7173152c6..39b5a5ba9033 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -130,11 +130,11 @@ int test_pkt_access(struct __sk_buff *skb)
 		tcp = (struct tcphdr *)((void *)(ip6h) + ihl_len);
 	}
 
-	if (test_pkt_access_subprog1(skb) != skb->len * 2)
+	if ((__u32)test_pkt_access_subprog1(skb) != skb->len * 2)
 		return TC_ACT_SHOT;
-	if (test_pkt_access_subprog2(2, skb) != skb->len * 2)
+	if ((__u32)test_pkt_access_subprog2(2, skb) != skb->len * 2)
 		return TC_ACT_SHOT;
-	if (test_pkt_access_subprog3(3, skb) != skb->len * 3 * skb->ifindex)
+	if ((__u32)test_pkt_access_subprog3(3, skb) != skb->len * 3 * skb->ifindex)
 		return TC_ACT_SHOT;
 	if (tcp) {
 		if (test_pkt_write_access_subprog(skb, (void *)tcp - data))
diff --git a/tools/testing/selftests/bpf/progs/test_seg6_loop.c b/tools/testing/selftests/bpf/progs/test_seg6_loop.c
index 5059050f74f6..fccb21d23fe2 100644
--- a/tools/testing/selftests/bpf/progs/test_seg6_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_seg6_loop.c
@@ -170,7 +170,7 @@ static __always_inline int is_valid_tlv_boundary(struct __sk_buff *skb,
 	if (*pad_off == 0)
 		*pad_off = cur_off;
 
-	if (*tlv_off == -1)
+	if (*tlv_off == (__u32)-1)
 		*tlv_off = cur_off;
 	else if (!offset_valid)
 		return -EINVAL;
@@ -189,7 +189,7 @@ static __always_inline int add_tlv(struct __sk_buff *skb,
 	uint32_t partial_srh_len;
 	int err;
 
-	if (tlv_off != -1)
+	if (tlv_off != (__u32)-1)
 		tlv_off += srh_off;
 
 	if (itlv->type == SR6_TLV_PADDING || itlv->type == SR6_TLV_HMAC)
diff --git a/tools/testing/selftests/bpf/progs/test_skb_ctx.c b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
index a724a70c6700..7939a2edc414 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_ctx.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
@@ -11,7 +11,7 @@ SEC("tc")
 int process(struct __sk_buff *skb)
 {
 	__pragma_loop_unroll_full
-	for (int i = 0; i < 5; i++) {
+	for (__u32 i = 0; i < 5; i++) {
 		if (skb->cb[i] != i + 1)
 			return 1;
 		skb->cb[i]++;
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
index 8fda07544023..1aa4835da71a 100644
--- a/tools/testing/selftests/bpf/progs/test_snprintf.c
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -4,7 +4,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-__u32 pid = 0;
+int pid = 0;
 
 char num_out[64] = {};
 long num_ret = 0;
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
index f48f85f1bd70..2297c83433b7 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
@@ -336,7 +336,7 @@ int bpf_prog9(struct sk_msg_md *msg)
 
 	bytes = bpf_map_lookup_elem(&sock_cork_bytes, &zero);
 	if (bytes) {
-		if (((__u64)data_end - (__u64)data) >= *bytes)
+		if (((__u64)data_end - (__u64)data) >= (__u64)*bytes)
 			return SK_PASS;
 		ret = bpf_msg_cork_bytes(msg, *bytes);
 		if (ret)
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
index dde3d5bec515..e9675c45d8ef 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
@@ -2,7 +2,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-int verdict_max_size = 10000;
+__u32 verdict_max_size = 10000;
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
 	__uint(max_entries, 20);
diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 404124a93892..c7e2d4571a2b 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -80,7 +80,7 @@ static __always_inline void set_ipv4_csum(struct iphdr *iph)
 {
 	__u16 *iph16 = (__u16 *)iph;
 	__u32 csum;
-	int i;
+	size_t i;
 
 	iph->check = 0;
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp.c b/tools/testing/selftests/bpf/progs/test_xdp.c
index 8caf58be5818..ce2a9ae26088 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp.c
@@ -89,7 +89,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
 	struct vip vip = {};
 	int dport;
 	__u32 csum = 0;
-	int i;
+	size_t i;
 
 	if (iph + 1 > data_end)
 		return XDP_DROP;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
index 67a77944ef29..12ad0ec91021 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
@@ -89,7 +89,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp, struct bpf_dynptr *xd
 	struct vip vip = {};
 	int dport;
 	__u32 csum = 0;
-	int i;
+	size_t i;
 
 	__builtin_memset(eth_buffer, 0, sizeof(eth_buffer));
 	__builtin_memset(iph_buffer_tcp, 0, sizeof(iph_buffer_tcp));
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
index 93267a68825b..e9b7bbff5c23 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
@@ -85,7 +85,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
 	struct vip vip = {};
 	int dport;
 	__u32 csum = 0;
-	int i;
+	size_t i;
 
 	if (iph + 1 > data_end)
 		return XDP_DROP;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
index fad94e41cef9..85ef3c0a3e20 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
@@ -372,7 +372,7 @@ bool encap_v4(struct xdp_md *xdp, struct ctl_value *cval,
 
 	next_iph_u16 = (__u16 *) iph;
 	__pragma_loop_unroll_full
-	for (int i = 0; i < sizeof(struct iphdr) >> 1; i++)
+	for (size_t i = 0; i < sizeof(struct iphdr) >> 1; i++)
 		csum += *next_iph_u16++;
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
 	if (bpf_xdp_adjust_head(xdp, (int)sizeof(struct iphdr)))
@@ -423,7 +423,7 @@ int send_icmp_reply(void *data, void *data_end)
 	iph->check = 0;
 	next_iph_u16 = (__u16 *) iph;
 	__pragma_loop_unroll_full
-	for (int i = 0; i < sizeof(struct iphdr) >> 1; i++)
+	for (size_t i = 0; i < sizeof(struct iphdr) >> 1; i++)
 		csum += *next_iph_u16++;
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
 	return swap_mac_and_send(data, data_end);
diff --git a/tools/testing/selftests/bpf/progs/udp_limit.c b/tools/testing/selftests/bpf/progs/udp_limit.c
index 4767451b59ac..af1b3195ea8a 100644
--- a/tools/testing/selftests/bpf/progs/udp_limit.c
+++ b/tools/testing/selftests/bpf/progs/udp_limit.c
@@ -50,7 +50,7 @@ int sock_release(struct bpf_sock *ctx)
 		return 1;
 
 	sk_storage = bpf_sk_storage_get(&sk_map, ctx, 0, 0);
-	if (!sk_storage || *sk_storage != 0xdeadbeef)
+	if (!sk_storage || *sk_storage != (int)0xdeadbeef)
 		return 0;
 
 	__sync_fetch_and_add(&invocations, 1);
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
index 44190efcdba2..f99957773c3a 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -20,13 +20,13 @@ __u64 uretprobe_multi_func_3_result = 0;
 
 __u64 uprobe_multi_sleep_result = 0;
 
-int pid = 0;
+__u32 pid = 0;
 int child_pid = 0;
 int child_tid = 0;
 int child_pid_usdt = 0;
 int child_tid_usdt = 0;
 
-int expect_pid = 0;
+__u32 expect_pid = 0;
 bool bad_pid_seen = false;
 bool bad_pid_seen_usdt = false;
 
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
index 8fbcd69fae22..017f1859ebe8 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
@@ -3,6 +3,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
+#include <stddef.h>
 #include "bpf_kfuncs.h"
 #include "bpf_misc.h"
 
@@ -10,8 +11,8 @@ char _license[] SEC("license") = "GPL";
 
 int pid = 0;
 
-int idx_entry = 0;
-int idx_return = 0;
+size_t idx_entry = 0;
+size_t idx_return = 0;
 
 __u64 test_uprobe_cookie_entry[6];
 __u64 test_uprobe_cookie_return[3];
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index f19e15400b3e..cb6cc9c4643a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -86,10 +86,10 @@ int access_reserved(void *ctx)
 		return 1;
 
 	/* Try to dirty reserved memory. */
-	for (i = 0; i < len && can_loop; i++)
+	for (i = 0; (size_t)i < len && can_loop; i++)
 		*page = 0x5a;
 
-	for (i = 0; i < len && can_loop; i++) {
+	for (i = 0; (size_t)i < len && can_loop; i++) {
 		page = (volatile char __arena *)(base + i * PAGE_SIZE);
 
 		/*
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 75dd922e4e9f..72f9f8c23c93 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -593,7 +593,7 @@ int loop_inside_iter_volatile_limit(const void *ctx)
 {
 	struct bpf_iter_num it;
 	int *v, sum = 0;
-	__u64 i = 0;
+	__s32 i = 0;
 
 	bpf_iter_num_new(&it, 0, ARR2_SZ);
 	while ((v = bpf_iter_num_next(&it))) {
-- 
2.51.0



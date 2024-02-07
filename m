Return-Path: <linux-kselftest+bounces-4231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1BB84CAB1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 13:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD541C24AC2
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021165A0F9;
	Wed,  7 Feb 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryt2BNNu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2A59B75
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308817; cv=none; b=Rw5iHMUs0gHd/E4tK+rpYALMw2JxkQlkJoEJ1pa+xmK64vzI2gFsi3nMkSqEQolbd7NxkgvSm29l2pKsbLbkK/aP1Yu0npSiDawFk0EBT9wQ1iCLlSKenYDsrjRB3BfHB2QxOZKJyZoRxSv3MaqlCVI8tyfpGuIHML8BoRRJPEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308817; c=relaxed/simple;
	bh=bAbtE/R1VLRuc1zvzV781Cxaz1OXnHszxJ7DxypjlkI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PjJR+JWyjXHmCERFix8OCP8w3Jgq2uDhvs52o/bHPikv2iwbthuuMJA+IfSVYgfuJ2ZuYt/UWykDonCX25QeKZ3eLG8/3/VxXZ0RFdUmCEYsQgBlL3S6RU+1A6GcQFYoGO9DMzY0Rfo686nMiItzxNLwkZlHeVJ0YeaShXr2Lxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryt2BNNu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047a047f4cso14756707b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 04:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707308813; x=1707913613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7lhwFwydnCtzXEmfnA4HgrH5hizOgbSGo5FgHQmbVgo=;
        b=ryt2BNNur3PBGqaXTNcH/4RQ2vIdqwzEV+3QZzAQx4wrfTwoTvpIiCtsjzuhw74iwT
         ktlcuN7davhJ1w1vcOUQJoiK2O6ElC2jjLJM9VcLxbbeUdsjXlddQIfq1+Y9nMUSiv4q
         8le/6BYU1OpI8nS+JjOJO3UF3VaKClIgACrmAExelppp9BeHkxEpvaEGr/8beXLe+Qid
         jR8zX3QovB8Ty9069INv8Bam++qR9ToSC02+FgfpgMdYAcRrxEgOXMP8fX2r1VeDWVC1
         7HH9zfA48TjecxuaGkV/UsV9BxjqR6eHC04PCGo4JaoO3UU8sCCpdq8H4uAmdi8vsy7I
         gD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707308813; x=1707913613;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lhwFwydnCtzXEmfnA4HgrH5hizOgbSGo5FgHQmbVgo=;
        b=ThAjdw6Z9yAFIRh7z5NCpVkAubTmRA/70uXy3M+AexxkaJJdJXoVVIah9UioGfVXtn
         WakUpFECIQ4dXH8bkeZQzITSIvbT+tatAXj82lISePiM5GAp9bof9j3ing3S09175YwX
         AN8WfiFkcKG6TCNXV7YmdL5D2Z0WPsoEou28DiOj93Dg1Ehqru00b0my3km+IJH6tts/
         sCAwkbDiMxO4xg+uO8p7Ox6AnM1M6rxV1kmLZVpmqGovpt+hN0e7jOKd8FLmrk7uWMq/
         85k9buNnC4m99l90ovRBu0yP/UPUA4rVEcLt4ThsXZWc30HH6iYWEcINS51KEMr+TTip
         fRqQ==
X-Gm-Message-State: AOJu0YyyckJYx6bHkeDkEHeND8vHTfokK4LzIN3fEjRQqvpmX9nZWwgc
	1ChWS+uxxxnyNtSR7lKD/pYS3ZRmvyvWa7f06c5B3J1+bG8b79QQ7oQcGpLxd2yoT65YxeL2lw=
	=
X-Google-Smtp-Source: AGHT+IHYKEP4X4+yuJYKdL4J46pnhcfe+S/Csz0Hfde+EHgGhcIwHsJ0HbHcebolsrVACp3K9ZB0o5TYQg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:4d69:c225:7956:ca4])
 (user=elver job=sendgmr) by 2002:a05:6902:2505:b0:dc6:c7ed:e72d with SMTP id
 dt5-20020a056902250500b00dc6c7ede72dmr1165892ybb.4.1707308813413; Wed, 07 Feb
 2024 04:26:53 -0800 (PST)
Date: Wed,  7 Feb 2024 13:26:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207122626.3508658-1-elver@google.com>
Subject: [PATCH bpf-next v2] bpf: Allow compiler to inline most of bpf_local_storage_lookup()
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Yafang Shao <laoar.shao@gmail.com>, Tejun Heo <tj@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In various performance profiles of kernels with BPF programs attached,
bpf_local_storage_lookup() appears as a significant portion of CPU
cycles spent. To enable the compiler generate more optimal code, turn
bpf_local_storage_lookup() into a static inline function, where only the
cache insertion code path is outlined

Notably, outlining cache insertion helps avoid bloating callers by
duplicating setting up calls to raw_spin_{lock,unlock}_irqsave() (on
architectures which do not inline spin_lock/unlock, such as x86), which
would cause the compiler produce worse code by deciding to outline
otherwise inlinable functions. The call overhead is neutral, because we
make 2 calls either way: either calling raw_spin_lock_irqsave() and
raw_spin_unlock_irqsave(); or call __bpf_local_storage_insert_cache(),
which calls raw_spin_lock_irqsave(), followed by a tail-call to
raw_spin_unlock_irqsave() where the compiler can perform TCO and (in
optimized uninstrumented builds) turns it into a plain jump. The call to
__bpf_local_storage_insert_cache() can be elided entirely if
cacheit_lockit is a false constant expression.

Based on results from './benchs/run_bench_local_storage.sh' (21 trials,
reboot between each trial; x86 defconfig + BPF, clang 16) this produces
improvements in throughput and latency in the majority of cases, with an
average (geomean) improvement of 8%:

+---- Hashmap Control --------------------
|
| + num keys: 10
| :                                         <before>             | <after>
| +-+ hashmap (control) sequential get    +----------------------+----------------------
|   +- hits throughput                    | 14.789 M ops/s       | 14.745 M ops/s (  ~  )
|   +- hits latency                       | 67.679 ns/op         | 67.879 ns/op   (  ~  )
|   +- important_hits throughput          | 14.789 M ops/s       | 14.745 M ops/s (  ~  )
|
| + num keys: 1000
| :                                         <before>             | <after>
| +-+ hashmap (control) sequential get    +----------------------+----------------------
|   +- hits throughput                    | 12.233 M ops/s       | 12.170 M ops/s (  ~  )
|   +- hits latency                       | 81.754 ns/op         | 82.185 ns/op   (  ~  )
|   +- important_hits throughput          | 12.233 M ops/s       | 12.170 M ops/s (  ~  )
|
| + num keys: 10000
| :                                         <before>             | <after>
| +-+ hashmap (control) sequential get    +----------------------+----------------------
|   +- hits throughput                    | 7.220 M ops/s        | 7.204 M ops/s  (  ~  )
|   +- hits latency                       | 138.522 ns/op        | 138.842 ns/op  (  ~  )
|   +- important_hits throughput          | 7.220 M ops/s        | 7.204 M ops/s  (  ~  )
|
| + num keys: 100000
| :                                         <before>             | <after>
| +-+ hashmap (control) sequential get    +----------------------+----------------------
|   +- hits throughput                    | 5.061 M ops/s        | 5.165 M ops/s  (+2.1%)
|   +- hits latency                       | 198.483 ns/op        | 194.270 ns/op  (-2.1%)
|   +- important_hits throughput          | 5.061 M ops/s        | 5.165 M ops/s  (+2.1%)
|
| + num keys: 4194304
| :                                         <before>             | <after>
| +-+ hashmap (control) sequential get    +----------------------+----------------------
|   +- hits throughput                    | 2.864 M ops/s        | 2.882 M ops/s  (  ~  )
|   +- hits latency                       | 365.220 ns/op        | 361.418 ns/op  (-1.0%)
|   +- important_hits throughput          | 2.864 M ops/s        | 2.882 M ops/s  (  ~  )
|
+---- Local Storage ----------------------
|
| + num_maps: 1
| :                                         <before>             | <after>
| +-+ local_storage cache sequential get  +----------------------+----------------------
|   +- hits throughput                    | 33.005 M ops/s       | 39.068 M ops/s (+18.4%)
|   +- hits latency                       | 30.300 ns/op         | 25.598 ns/op   (-15.5%)
|   +- important_hits throughput          | 33.005 M ops/s       | 39.068 M ops/s (+18.4%)
| :
| :                                         <before>             | <after>
| +-+ local_storage cache interleaved get +----------------------+----------------------
|   +- hits throughput                    | 37.151 M ops/s       | 44.926 M ops/s (+20.9%)
|   +- hits latency                       | 26.919 ns/op         | 22.259 ns/op   (-17.3%)
|   +- important_hits throughput          | 37.151 M ops/s       | 44.926 M ops/s (+20.9%)
|
| + num_maps: 10
| :                                         <before>             | <after>
| +-+ local_storage cache sequential get  +----------------------+----------------------
|   +- hits throughput                    | 32.288 M ops/s       | 38.099 M ops/s (+18.0%)
|   +- hits latency                       | 30.972 ns/op         | 26.248 ns/op   (-15.3%)
|   +- important_hits throughput          | 3.229 M ops/s        | 3.810 M ops/s  (+18.0%)
| :
| :                                         <before>             | <after>
| +-+ local_storage cache interleaved get +----------------------+----------------------
|   +- hits throughput                    | 34.473 M ops/s       | 41.145 M ops/s (+19.4%)
|   +- hits latency                       | 29.010 ns/op         | 24.307 ns/op   (-16.2%)
|   +- important_hits throughput          | 12.312 M ops/s       | 14.695 M ops/s (+19.4%)
|
| + num_maps: 16
| :                                         <before>             | <after>
| +-+ local_storage cache sequential get  +----------------------+----------------------
|   +- hits throughput                    | 32.524 M ops/s       | 38.341 M ops/s (+17.9%)
|   +- hits latency                       | 30.748 ns/op         | 26.083 ns/op   (-15.2%)
|   +- important_hits throughput          | 2.033 M ops/s        | 2.396 M ops/s  (+17.9%)
| :
| :                                         <before>             | <after>
| +-+ local_storage cache interleaved get +----------------------+----------------------
|   +- hits throughput                    | 34.575 M ops/s       | 41.338 M ops/s (+19.6%)
|   +- hits latency                       | 28.925 ns/op         | 24.193 ns/op   (-16.4%)
|   +- important_hits throughput          | 11.001 M ops/s       | 13.153 M ops/s (+19.6%)
|
| + num_maps: 17
| :                                         <before>             | <after>
| +-+ local_storage cache sequential get  +----------------------+----------------------
|   +- hits throughput                    | 28.861 M ops/s       | 32.756 M ops/s (+13.5%)
|   +- hits latency                       | 34.649 ns/op         | 30.530 ns/op   (-11.9%)
|   +- important_hits throughput          | 1.700 M ops/s        | 1.929 M ops/s  (+13.5%)
| :
| :                                         <before>             | <after>
| +-+ local_storage cache interleaved get +----------------------+----------------------
|   +- hits throughput                    | 31.529 M ops/s       | 36.110 M ops/s (+14.5%)
|   +- hits latency                       | 31.719 ns/op         | 27.697 ns/op   (-12.7%)
|   +- important_hits throughput          | 9.598 M ops/s        | 10.993 M ops/s (+14.5%)
|
| + num_maps: 24
| :                                         <before>             | <after>
| +-+ local_storage cache sequential get  +----------------------+----------------------
|   +- hits throughput                    | 18.602 M ops/s       | 19.937 M ops/s (+7.2%)
|   +- hits latency                       | 53.767 ns/op         | 50.166 ns/op   (-6.7%)
|   +- important_hits throughput          | 0.776 M ops/s        | 0.831 M ops/s  (+7.2%)
| :
| :                                         <before>             | <after>
| +-+ local_storage cache interleaved get +----------------------+----------------------
|   +- hits throughput                    | 21.718 M ops/s       | 23.332 M ops/s (+7.4%)
|   +- hits latency                       | 46.047 ns/op         | 42.865 ns/op   (-6.9%)
|   +- important_hits throughput          | 6.110 M ops/s        | 6.564 M ops/s  (+7.4%)
|
| + num_maps: 32
| :                                         <before>             | <after>
| +-+ local_storage cache sequential get  +----------------------+----------------------
|   +- hits throughput                    | 14.118 M ops/s       | 14.626 M ops/s (+3.6%)
|   +- hits latency                       | 70.856 ns/op         | 68.381 ns/op   (-3.5%)
|   +- important_hits throughput          | 0.442 M ops/s        | 0.458 M ops/s  (+3.6%)
| :
| :                                         <before>             | <after>
| +-+ local_storage cache interleaved get +----------------------+----------------------
|   +- hits throughput                    | 17.111 M ops/s       | 17.906 M ops/s (+4.6%)
|   +- hits latency                       | 58.451 ns/op         | 55.865 ns/op   (-4.4%)
|   +- important_hits throughput          | 4.776 M ops/s        | 4.998 M ops/s  (+4.6%)
|
| + num_maps: 100
| :                                         <before>             | <after>
| +-+ local_storage cache sequential get  +----------------------+----------------------
|   +- hits throughput                    | 5.281 M ops/s        | 5.528 M ops/s  (+4.7%)
|   +- hits latency                       | 192.398 ns/op        | 183.059 ns/op  (-4.9%)
|   +- important_hits throughput          | 0.053 M ops/s        | 0.055 M ops/s  (+4.9%)
| :
| :                                         <before>             | <after>
| +-+ local_storage cache interleaved get +----------------------+----------------------
|   +- hits throughput                    | 6.265 M ops/s        | 6.498 M ops/s  (+3.7%)
|   +- hits latency                       | 161.436 ns/op        | 152.877 ns/op  (-5.3%)
|   +- important_hits throughput          | 1.636 M ops/s        | 1.697 M ops/s  (+3.7%)
|
| + num_maps: 1000
| :                                         <before>             | <after>
| +-+ local_storage cache sequential get  +----------------------+----------------------
|   +- hits throughput                    | 0.355 M ops/s        | 0.354 M ops/s  (  ~  )
|   +- hits latency                       | 2826.538 ns/op       | 2827.139 ns/op (  ~  )
|   +- important_hits throughput          | 0.000 M ops/s        | 0.000 M ops/s  (  ~  )
| :
| :                                         <before>             | <after>
| +-+ local_storage cache interleaved get +----------------------+----------------------
|   +- hits throughput                    | 0.404 M ops/s        | 0.403 M ops/s  (  ~  )
|   +- hits latency                       | 2481.190 ns/op       | 2487.555 ns/op (  ~  )
|   +- important_hits throughput          | 0.102 M ops/s        | 0.101 M ops/s  (  ~  )

Signed-off-by: Marco Elver <elver@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
---
v2:
* Inline most of bpf_local_storage_lookup(), which produces greater
  speedup and avoids regressing the cases with large map arrays.
* Drop "likely()" hint, it didn't produce much benefit.
* Re-run benchmark and collect 21 trials of results.
* Remove the on_lookup tests, which no longer work because
  e.g. bpf_task_storage_delete() no longer does calls to
  bpf_local_storage_*() helpers.
---
 include/linux/bpf_local_storage.h             | 30 ++++++++++-
 kernel/bpf/bpf_local_storage.c                | 52 +++++--------------
 .../bpf/prog_tests/task_local_storage.c       |  6 ---
 .../selftests/bpf/progs/cgrp_ls_recursion.c   | 26 ----------
 .../selftests/bpf/progs/task_ls_recursion.c   | 17 ------
 5 files changed, 41 insertions(+), 90 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 173ec7f43ed1..dcddb0aef7d8 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -129,10 +129,36 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 			    struct bpf_local_storage_cache *cache,
 			    bool bpf_ma);
 
-struct bpf_local_storage_data *
+void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
+				      struct bpf_local_storage_map *smap,
+				      struct bpf_local_storage_elem *selem);
+/* If cacheit_lockit is false, this lookup function is lockless */
+static inline struct bpf_local_storage_data *
 bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 			 struct bpf_local_storage_map *smap,
-			 bool cacheit_lockit);
+			 bool cacheit_lockit)
+{
+	struct bpf_local_storage_data *sdata;
+	struct bpf_local_storage_elem *selem;
+
+	/* Fast path (cache hit) */
+	sdata = rcu_dereference_check(local_storage->cache[smap->cache_idx],
+				      bpf_rcu_lock_held());
+	if (sdata && rcu_access_pointer(sdata->smap) == smap)
+		return sdata;
+
+	/* Slow path (cache miss) */
+	hlist_for_each_entry_rcu(selem, &local_storage->list, snode,
+				  rcu_read_lock_trace_held())
+		if (rcu_access_pointer(SDATA(selem)->smap) == smap)
+			break;
+
+	if (!selem)
+		return NULL;
+	if (cacheit_lockit)
+		__bpf_local_storage_insert_cache(local_storage, smap, selem);
+	return SDATA(selem);
+}
 
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 146824cc9689..bdea1a459153 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -414,47 +414,21 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 	bpf_selem_unlink_storage(selem, reuse_now);
 }
 
-/* If cacheit_lockit is false, this lookup function is lockless */
-struct bpf_local_storage_data *
-bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
-			 struct bpf_local_storage_map *smap,
-			 bool cacheit_lockit)
+void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
+				      struct bpf_local_storage_map *smap,
+				      struct bpf_local_storage_elem *selem)
 {
-	struct bpf_local_storage_data *sdata;
-	struct bpf_local_storage_elem *selem;
-
-	/* Fast path (cache hit) */
-	sdata = rcu_dereference_check(local_storage->cache[smap->cache_idx],
-				      bpf_rcu_lock_held());
-	if (sdata && rcu_access_pointer(sdata->smap) == smap)
-		return sdata;
-
-	/* Slow path (cache miss) */
-	hlist_for_each_entry_rcu(selem, &local_storage->list, snode,
-				  rcu_read_lock_trace_held())
-		if (rcu_access_pointer(SDATA(selem)->smap) == smap)
-			break;
-
-	if (!selem)
-		return NULL;
-
-	sdata = SDATA(selem);
-	if (cacheit_lockit) {
-		unsigned long flags;
-
-		/* spinlock is needed to avoid racing with the
-		 * parallel delete.  Otherwise, publishing an already
-		 * deleted sdata to the cache will become a use-after-free
-		 * problem in the next bpf_local_storage_lookup().
-		 */
-		raw_spin_lock_irqsave(&local_storage->lock, flags);
-		if (selem_linked_to_storage(selem))
-			rcu_assign_pointer(local_storage->cache[smap->cache_idx],
-					   sdata);
-		raw_spin_unlock_irqrestore(&local_storage->lock, flags);
-	}
+	unsigned long flags;
 
-	return sdata;
+	/* spinlock is needed to avoid racing with the
+	 * parallel delete.  Otherwise, publishing an already
+	 * deleted sdata to the cache will become a use-after-free
+	 * problem in the next bpf_local_storage_lookup().
+	 */
+	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	if (selem_linked_to_storage(selem))
+		rcu_assign_pointer(local_storage->cache[smap->cache_idx], SDATA(selem));
+	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 }
 
 static int check_flags(const struct bpf_local_storage_data *old_sdata,
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index ea8537c54413..c33c05161a9e 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -117,12 +117,6 @@ static void test_recursion(void)
 	ASSERT_OK(err, "lookup map_b");
 	ASSERT_EQ(value, 100, "map_b value");
 
-	prog_fd = bpf_program__fd(skel->progs.on_lookup);
-	memset(&info, 0, sizeof(info));
-	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
-	ASSERT_OK(err, "get prog info");
-	ASSERT_GT(info.recursion_misses, 0, "on_lookup prog recursion");
-
 	prog_fd = bpf_program__fd(skel->progs.on_update);
 	memset(&info, 0, sizeof(info));
 	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
index 610c2427fd93..3500e4b69ebe 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
@@ -27,32 +27,6 @@ bool is_cgroup1 = 0;
 struct cgroup *bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id) __ksym;
 void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
 
-static void __on_lookup(struct cgroup *cgrp)
-{
-	bpf_cgrp_storage_delete(&map_a, cgrp);
-	bpf_cgrp_storage_delete(&map_b, cgrp);
-}
-
-SEC("fentry/bpf_local_storage_lookup")
-int BPF_PROG(on_lookup)
-{
-	struct task_struct *task = bpf_get_current_task_btf();
-	struct cgroup *cgrp;
-
-	if (is_cgroup1) {
-		cgrp = bpf_task_get_cgroup1(task, target_hid);
-		if (!cgrp)
-			return 0;
-
-		__on_lookup(cgrp);
-		bpf_cgroup_release(cgrp);
-		return 0;
-	}
-
-	__on_lookup(task->cgroups->dfl_cgrp);
-	return 0;
-}
-
 static void __on_update(struct cgroup *cgrp)
 {
 	long *ptr;
diff --git a/tools/testing/selftests/bpf/progs/task_ls_recursion.c b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
index 4542dc683b44..f1853c38aada 100644
--- a/tools/testing/selftests/bpf/progs/task_ls_recursion.c
+++ b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
@@ -27,23 +27,6 @@ struct {
 	__type(value, long);
 } map_b SEC(".maps");
 
-SEC("fentry/bpf_local_storage_lookup")
-int BPF_PROG(on_lookup)
-{
-	struct task_struct *task = bpf_get_current_task_btf();
-
-	if (!test_pid || task->pid != test_pid)
-		return 0;
-
-	/* The bpf_task_storage_delete will call
-	 * bpf_local_storage_lookup.  The prog->active will
-	 * stop the recursion.
-	 */
-	bpf_task_storage_delete(&map_a, task);
-	bpf_task_storage_delete(&map_b, task);
-	return 0;
-}
-
 SEC("fentry/bpf_local_storage_update")
 int BPF_PROG(on_update)
 {
-- 
2.43.0.594.gd9cf4e227d-goog



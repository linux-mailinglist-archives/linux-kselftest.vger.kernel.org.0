Return-Path: <linux-kselftest+bounces-3851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D82C8441AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A127B21B3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CC782866;
	Wed, 31 Jan 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5mJQCFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9C69D00
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710759; cv=none; b=X0cUhrlOzggk1NR2gL2ZVIG/AdIxWlhk9SZlqn6FGXYdmqjX84u1pER1qNnE6R+nFOXqFTPpyYSxJgOZBcwWixJQQVlvhDJMECVm8BQ2Pdm3F2ZepXXhDKNp07E7wIJA2AccKy27W40mQuLC/+PIutB/IYmqAizLHjqORkx7ZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710759; c=relaxed/simple;
	bh=YvsXE9OR+IUltygOycGvea6KYYgI+LiZAiXelBwbSdw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AhT5xLsrEw+yQce4MfmTPmK2mmFAosCnplBd+4A51wdBfzjJsm3xI7LtKq6fZYO4MQ9DB2BKYg2LjvQ5OSMS18d6zv4CHYBsE50guq+NSKo2dKrX58iZFuKeAIGX1fY+3iCWaG9gFnVNOJi0UQsHyzHUbRbwN2lDKK2Ri4JsMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5mJQCFU; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-55f12bced3bso1818682a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 06:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706710754; x=1707315554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IaMeGJ0rWB78uo9A8Je3r+q2sT9bnmMm16vK1tzleA8=;
        b=a5mJQCFUZ+lU3jx08r2hDwm5++dAbuUrLC2LtD1xYZJXj3lrT1/L+L27zWBxdw2RCX
         Bwtr95WvVu0zIeK5K4iABYM2SxXmmGx9y6LYZOKKTBu5bIsmkp/J+j7o9FRM3dc8tpir
         MKd2t1OuABcbcxFrXbk0YCdNcXqaly0Zsa9cc075rL9sFn2AMvU5qAewT+d4+sKKpy6Y
         F2RO9dK2Ctp0VOpEhksqHSUE14AF6Y+snbrdNRsJN47l8Cqs4rOF9reQ8a3LD6pW2RT8
         6RysvzfjIoT3+82XV3yQgamNqak1DdDdswuR8f58/2EomOp96uB1V4Rywq3J7v5m8sI6
         SmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706710754; x=1707315554;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaMeGJ0rWB78uo9A8Je3r+q2sT9bnmMm16vK1tzleA8=;
        b=iGpzpeWrFXp7+7bAMCr7ulzmdd1gmuktKbm5CqDl0JKR7fe8JBkI/dodQRR9ithvjy
         fH7et+ngw7LhK/04kevhPX0k/o994IHHGUoGmC9b1HxV8pHs3nKk/q4UmL/K4inDQFx7
         TE4QCRnJh65t9YP0OTsC7w9nVneKQlw7Rgqkz1XJ0ozwsi5DOnH98sii0gs4XHK8QdVR
         v403AdZcIBOjwSIM289QxVvaBqPM1mkyJWzqBI8WBltGLyDTlyrWgwwLdvZS1BOyuhQz
         /VjdkxB0RqlRH8f6Z//umeQsR3ggsAu/i8iSXntuupZh1HXmmW/YV4w7Nrva7iarA6FS
         WXhw==
X-Gm-Message-State: AOJu0YwSffpEL7apXkoLBzwDTNRDXEGMXuRIErhJebQQpYyFu3fzzJ0k
	smWE8FVQ+90ueugCB7Zkp1AVualcdfZlgOj45H2xp1BVvWn2W745O0b72NkZxwqe4or4lE0UBA=
	=
X-Google-Smtp-Source: AGHT+IH1fksSvzeQMmagfUyODYTJ4E+QON8T+tLm4xKVfBz5TBUVM3L+OZBAqEMtOoqN7+rXMWq6gbQOIA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:5727:e5f5:9cb8:3c6e])
 (user=elver job=sendgmr) by 2002:a05:6402:b87:b0:55e:f9f8:9025 with SMTP id
 cf7-20020a0564020b8700b0055ef9f89025mr3587edb.3.1706710753556; Wed, 31 Jan
 2024 06:19:13 -0800 (PST)
Date: Wed, 31 Jan 2024 15:18:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240131141858.1149719-1-elver@google.com>
Subject: [PATCH] bpf: Separate bpf_local_storage_lookup() fast and slow paths
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To allow the compiler to inline the bpf_local_storage_lookup() fast-
path, factor it out by making bpf_local_storage_lookup() a static inline
function and move the slow-path to bpf_local_storage_lookup_slowpath().

Base on results from './benchs/run_bench_local_storage.sh' this produces
improvements in throughput and latency in the majority of cases:

| Hashmap Control
| =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| num keys: 10
|  hashmap (control) sequential get:
|                              <before>                | <after>
|   hits throughput:           13.895 =C2=B1 0.024 M ops/s  | 14.022 =C2=B1=
 0.095 M ops/s	(+0.9%)
|   hits latency:              71.968 ns/op            | 71.318 ns/op		(-0.=
9%)
|   important_hits throughput: 13.895 =C2=B1 0.024 M ops/s  | 14.022 =C2=B1=
 0.095 M ops/s	(+0.9%)
|
| num keys: 1000
|  hashmap (control) sequential get:
|                              <before>                | <after>
|   hits throughput:           11.793 =C2=B1 0.018 M ops/s  | 11.645 =C2=B1=
 0.370 M ops/s	(-1.3%)
|   hits latency:              84.794 ns/op            | 85.874 ns/op		(+1.=
3%)
|   important_hits throughput: 11.793 =C2=B1 0.018 M ops/s  | 11.645 =C2=B1=
 0.370 M ops/s	(-1.3%)
|
| num keys: 10000
|  hashmap (control) sequential get:
|                              <before>                | <after>
|   hits throughput:           7.113 =C2=B1 0.012 M ops/s   | 7.037 =C2=B1 =
0.051 M ops/s	(-1.1%)
|   hits latency:              140.581 ns/op           | 142.113 ns/op		(+1=
.1%)
|   important_hits throughput: 7.113 =C2=B1 0.012 M ops/s   | 7.037 =C2=B1 =
0.051 M ops/s	(-1.1%)
|
| num keys: 100000
|  hashmap (control) sequential get:
|                              <before>                | <after>
|   hits throughput:           4.793 =C2=B1 0.034 M ops/s   | 4.990 =C2=B1 =
0.025 M ops/s	(+4.1%)
|   hits latency:              208.623 ns/op           | 200.401 ns/op		(-3=
.9%)
|   important_hits throughput: 4.793 =C2=B1 0.034 M ops/s   | 4.990 =C2=B1 =
0.025 M ops/s	(+4.1%)
|
| num keys: 4194304
|  hashmap (control) sequential get:
|                              <before>                | <after>
|   hits throughput:           2.088 =C2=B1 0.008 M ops/s   | 2.962 =C2=B1 =
0.004 M ops/s	(+41.9%)
|   hits latency:              478.851 ns/op           | 337.648 ns/op		(-2=
9.5%)
|   important_hits throughput: 2.088 =C2=B1 0.008 M ops/s   | 2.962 =C2=B1 =
0.004 M ops/s	(+41.9%)
|
| Local Storage
| =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| num_maps: 1
|  local_storage cache sequential  get:
|                              <before>                | <after>
|   hits throughput:           32.598 =C2=B1 0.008 M ops/s  | 38.480 =C2=B1=
 0.054 M ops/s	(+18.0%)
|   hits latency:              30.676 ns/op            | 25.988 ns/op		(-15=
.3%)
|   important_hits throughput: 32.598 =C2=B1 0.008 M ops/s  | 38.480 =C2=B1=
 0.054 M ops/s	(+18.0%)
|  local_storage cache interleaved get:
|                              <before>                | <after>
|   hits throughput:           36.963 =C2=B1 0.045 M ops/s  | 43.847 =C2=B1=
 0.037 M ops/s	(+18.6%)
|   hits latency:              27.054 ns/op            | 22.807 ns/op		(-15=
.7%)
|   important_hits throughput: 36.963 =C2=B1 0.045 M ops/s  | 43.847 =C2=B1=
 0.037 M ops/s	(+18.6%)
|
| num_maps: 10
|  local_storage cache sequential  get:
|                              <before>                | <after>
|   hits throughput:           32.078 =C2=B1 0.004 M ops/s  | 37.813 =C2=B1=
 0.020 M ops/s	(+17.9%)
|   hits latency:              31.174 ns/op            | 26.446 ns/op		(-15=
.2%)
|   important_hits throughput: 3.208 =C2=B1 0.000 M ops/s   | 3.781 =C2=B1 =
0.002 M ops/s	(+17.9%)
|  local_storage cache interleaved get:
|                              <before>                | <after>
|   hits throughput:           34.564 =C2=B1 0.011 M ops/s  | 40.082 =C2=B1=
 0.037 M ops/s	(+16.0%)
|   hits latency:              28.932 ns/op            | 24.949 ns/op		(-13=
.8%)
|   important_hits throughput: 12.344 =C2=B1 0.004 M ops/s  | 14.315 =C2=B1=
 0.013 M ops/s	(+16.0%)
|
| num_maps: 16
|  local_storage cache sequential  get:
|                              <before>                | <after>
|   hits throughput:           32.493 =C2=B1 0.023 M ops/s  | 38.147 =C2=B1=
 0.029 M ops/s	(+17.4%)
|   hits latency:              30.776 ns/op            | 26.215 ns/op		(-14=
.8%)
|   important_hits throughput: 2.031 =C2=B1 0.001 M ops/s   | 2.384 =C2=B1 =
0.002 M ops/s	(+17.4%)
|  local_storage cache interleaved get:
|                              <before>                | <after>
|   hits throughput:           34.380 =C2=B1 0.521 M ops/s  | 41.605 =C2=B1=
 0.095 M ops/s	(+21.0%)
|   hits latency:              29.087 ns/op            | 24.035 ns/op		(-17=
.4%)
|   important_hits throughput: 10.939 =C2=B1 0.166 M ops/s  | 13.238 =C2=B1=
 0.030 M ops/s	(+21.0%)
|
| num_maps: 17
|  local_storage cache sequential  get:
|                              <before>                | <after>
|   hits throughput:           28.748 =C2=B1 0.028 M ops/s  | 32.248 =C2=B1=
 0.080 M ops/s	(+12.2%)
|   hits latency:              34.785 ns/op            | 31.009 ns/op		(-10=
.9%)
|   important_hits throughput: 1.693 =C2=B1 0.002 M ops/s   | 1.899 =C2=B1 =
0.005 M ops/s	(+12.2%)
|  local_storage cache interleaved get:
|                              <before>                | <after>
|   hits throughput:           31.313 =C2=B1 0.030 M ops/s  | 35.911 =C2=B1=
 0.020 M ops/s	(+14.7%)
|   hits latency:              31.936 ns/op            | 27.847 ns/op		(-12=
.8%)
|   important_hits throughput: 9.533 =C2=B1 0.009 M ops/s   | 10.933 =C2=B1=
 0.006 M ops/s	(+14.7%)
|
| num_maps: 24
|  local_storage cache sequential  get:
|                              <before>                | <after>
|   hits throughput:           18.475 =C2=B1 0.027 M ops/s  | 19.000 =C2=B1=
 0.006 M ops/s	(+2.8%)
|   hits latency:              54.127 ns/op            | 52.632 ns/op		(-2.=
8%)
|   important_hits throughput: 0.770 =C2=B1 0.001 M ops/s   | 0.792 =C2=B1 =
0.000 M ops/s	(+2.9%)
|  local_storage cache interleaved get:
|                              <before>                | <after>
|   hits throughput:           21.361 =C2=B1 0.028 M ops/s  | 22.388 =C2=B1=
 0.099 M ops/s	(+4.8%)
|   hits latency:              46.814 ns/op            | 44.667 ns/op		(-4.=
6%)
|   important_hits throughput: 6.009 =C2=B1 0.008 M ops/s   | 6.298 =C2=B1 =
0.028 M ops/s	(+4.8%)
|
| num_maps: 32
|  local_storage cache sequential  get:
|                              <before>                | <after>
|   hits throughput:           14.220 =C2=B1 0.006 M ops/s  | 14.168 =C2=B1=
 0.020 M ops/s	(-0.4%)
|   hits latency:              70.323 ns/op            | 70.580 ns/op		(+0.=
4%)
|   important_hits throughput: 0.445 =C2=B1 0.000 M ops/s   | 0.443 =C2=B1 =
0.001 M ops/s	(-0.4%)
|  local_storage cache interleaved get:
|                              <before>                | <after>
|   hits throughput:           17.250 =C2=B1 0.011 M ops/s  | 16.650 =C2=B1=
 0.021 M ops/s	(-3.5%)
|   hits latency:              57.971 ns/op            | 60.061 ns/op		(+3.=
6%)
|   important_hits throughput: 4.815 =C2=B1 0.003 M ops/s   | 4.647 =C2=B1 =
0.006 M ops/s	(-3.5%)
|
| num_maps: 100
|  local_storage cache sequential  get:
|                              <before>                | <after>
|   hits throughput:           5.212 =C2=B1 0.012 M ops/s   | 5.878 =C2=B1 =
0.004 M ops/s	(+12.8%)
|   hits latency:              191.877 ns/op           | 170.116 ns/op		(-1=
1.3%)
|   important_hits throughput: 0.052 =C2=B1 0.000 M ops/s   | 0.059 =C2=B1 =
0.000 M ops/s	(+13.5%)
|  local_storage cache interleaved get:
|                              <before>                | <after>
|   hits throughput:           6.521 =C2=B1 0.053 M ops/s   | 7.086 =C2=B1 =
0.010 M ops/s	(+8.7%)
|   hits latency:              153.343 ns/op           | 141.116 ns/op		(-8=
.0%)
|   important_hits throughput: 1.703 =C2=B1 0.014 M ops/s   | 1.851 =C2=B1 =
0.003 M ops/s	(+8.7%)
|
| num_maps: 1000
|  local_storage cache sequential  get:
|                              <before>                | <after>
|   hits throughput:           0.357 =C2=B1 0.005 M ops/s   | 0.325 =C2=B1 =
0.005 M ops/s	(-9.0%)
|   hits latency:              2803.738 ns/op          | 3076.923 ns/op		(+=
9.7%)
|   important_hits throughput: 0.000 =C2=B1 0.000 M ops/s   | 0.000 =C2=B1 =
0.000 M ops/s
|  local_storage cache interleaved get:
|                              <before>                | <after>
|   hits throughput:           0.434 =C2=B1 0.007 M ops/s   | 0.447 =C2=B1 =
0.007 M ops/s	(+3.0%)
|   hits latency:              2306.539 ns/op          | 2237.687 ns/op		(-=
3.0%)
|   important_hits throughput: 0.109 =C2=B1 0.002 M ops/s   | 0.112 =C2=B1 =
0.002 M ops/s	(+2.8%)

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/bpf_local_storage.h               | 17 ++++++++++++++++-
 kernel/bpf/bpf_local_storage.c                  | 14 ++++----------
 .../selftests/bpf/progs/cgrp_ls_recursion.c     |  2 +-
 .../selftests/bpf/progs/task_ls_recursion.c     |  2 +-
 4 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_st=
orage.h
index 173ec7f43ed1..c8cecf7fff87 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -130,9 +130,24 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 			    bool bpf_ma);
=20
 struct bpf_local_storage_data *
+bpf_local_storage_lookup_slowpath(struct bpf_local_storage *local_storage,
+				  struct bpf_local_storage_map *smap,
+				  bool cacheit_lockit);
+static inline struct bpf_local_storage_data *
 bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 			 struct bpf_local_storage_map *smap,
-			 bool cacheit_lockit);
+			 bool cacheit_lockit)
+{
+	struct bpf_local_storage_data *sdata;
+
+	/* Fast path (cache hit) */
+	sdata =3D rcu_dereference_check(local_storage->cache[smap->cache_idx],
+				      bpf_rcu_lock_held());
+	if (likely(sdata && rcu_access_pointer(sdata->smap) =3D=3D smap))
+		return sdata;
+
+	return bpf_local_storage_lookup_slowpath(local_storage, smap, cacheit_loc=
kit);
+}
=20
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
=20
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.=
c
index 146824cc9689..2ef782a1bd6f 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -415,20 +415,14 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *=
selem, bool reuse_now)
 }
=20
 /* If cacheit_lockit is false, this lookup function is lockless */
-struct bpf_local_storage_data *
-bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
-			 struct bpf_local_storage_map *smap,
-			 bool cacheit_lockit)
+noinline struct bpf_local_storage_data *
+bpf_local_storage_lookup_slowpath(struct bpf_local_storage *local_storage,
+				  struct bpf_local_storage_map *smap,
+				  bool cacheit_lockit)
 {
 	struct bpf_local_storage_data *sdata;
 	struct bpf_local_storage_elem *selem;
=20
-	/* Fast path (cache hit) */
-	sdata =3D rcu_dereference_check(local_storage->cache[smap->cache_idx],
-				      bpf_rcu_lock_held());
-	if (sdata && rcu_access_pointer(sdata->smap) =3D=3D smap)
-		return sdata;
-
 	/* Slow path (cache miss) */
 	hlist_for_each_entry_rcu(selem, &local_storage->list, snode,
 				  rcu_read_lock_trace_held())
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c b/tools/=
testing/selftests/bpf/progs/cgrp_ls_recursion.c
index a043d8fefdac..9895087a9235 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
@@ -21,7 +21,7 @@ struct {
 	__type(value, long);
 } map_b SEC(".maps");
=20
-SEC("fentry/bpf_local_storage_lookup")
+SEC("fentry/bpf_local_storage_lookup_slowpath")
 int BPF_PROG(on_lookup)
 {
 	struct task_struct *task =3D bpf_get_current_task_btf();
diff --git a/tools/testing/selftests/bpf/progs/task_ls_recursion.c b/tools/=
testing/selftests/bpf/progs/task_ls_recursion.c
index 4542dc683b44..d73b33a4c153 100644
--- a/tools/testing/selftests/bpf/progs/task_ls_recursion.c
+++ b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
@@ -27,7 +27,7 @@ struct {
 	__type(value, long);
 } map_b SEC(".maps");
=20
-SEC("fentry/bpf_local_storage_lookup")
+SEC("fentry/bpf_local_storage_lookup_slowpath")
 int BPF_PROG(on_lookup)
 {
 	struct task_struct *task =3D bpf_get_current_task_btf();
--=20
2.43.0.429.g432eaa2c6b-goog



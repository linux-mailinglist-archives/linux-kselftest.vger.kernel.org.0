Return-Path: <linux-kselftest+bounces-48366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F560CFBB92
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 03:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 428AD308A41B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 02:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E7123B638;
	Wed,  7 Jan 2026 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m9IT6FoS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE63FBA7
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752738; cv=none; b=fKLYyLNqnd+yKO5sf0Fs7AV2YWXG0apD96neL9iaAleLg4XTKAacr6bzhTXvLUkCd8DPFr16EUufcLIElJbnWZxlgQgHGIo7y6S+pdRX5MFmaxHEbyHVTYUcy42voMy9wgo74ICLgBFDbl02gbbzx1XlkmggCy/K08GCNlc0iKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752738; c=relaxed/simple;
	bh=0vRCcbQzuhyzsY5zP8fzr5uT5iBniJFP6H3iqCEQIX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJlcjI/zTM8xoq+n94UprvTrpG5ug8hdB3J31eGFu+7L1F+MkzG2mjBivMbLqOKwdy+EqBECgkLiFz1RF7ATt9LwOSx2W9pvjfw7mD8sJB0udAX6kBRmAdEW00rjWps7EoWRFCldrpGem02qCLcvU7hSHQflEBunjHVFYgTomx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m9IT6FoS; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767752724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GdA5AnhU0z9b+4/S5p1h7+/+hz1N8XlHfnP9/gYMZVQ=;
	b=m9IT6FoShhzX5yet6jfvUW9WLCjHx6BpjtRShOIq715eI24RHXkuJdb3soBX+zZSHKS1oD
	DQCEdN4hqgXhw4s9qj1p7OHBy+5lEIkco+vLHumYu+WQQ+GDL7n3Kgozh+11ECIr8PIy8T
	s3IGn9xMR1gMSTpTMupTREpabi5AzgU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Tao Chen <chen.dylane@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Tobias Klauser <tklauser@distanz.ch>,
	Rong Tao <rongtao@cestc.cn>,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v13 0/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps
Date: Wed,  7 Jan 2026 10:20:15 +0800
Message-ID: <20260107022022.12843-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch set introduces the BPF_F_CPU and BPF_F_ALL_CPUS flags for
percpu maps, as the requirement of BPF_F_ALL_CPUS flag for percpu_array
maps was discussed in the thread of
"[PATCH bpf-next v3 0/4] bpf: Introduce global percpu data"[1].

The goal of BPF_F_ALL_CPUS flag is to reduce data caching overhead in light
skeletons by allowing a single value to be reused to update values across all
CPUs. This avoids the M:N problem where M cached values are used to update a
map on N CPUs kernel.

The BPF_F_CPU flag is accompanied by *flags*-embedded cpu info, which
specifies the target CPU for the operation:

* For lookup operations: the flag field alongside cpu info enable querying
  a value on the specified CPU.
* For update operations: the flag field alongside cpu info enable
  updating value for specified CPU.

Links:
[1] https://lore.kernel.org/bpf/20250526162146.24429-1-leon.hwang@linux.dev/

Changes:
v12 -> v13:
* No changes, rebased on latest tree.

v11 -> v12:
* Dropped the v11 changes.
* Stabilized the lru_percpu_hash map test by keeping an extra spare entry,
  which can be used temporarily during updates to avoid unintended LRU
  evictions.

v10 -> v11:
* Support the combination of BPF_EXIST and BPF_F_CPU/BPF_F_ALL_CPUS for
  update operations.
* Fix unstable lru_percpu_hash map test using the combination of
  BPF_EXIST and BPF_F_CPU/BPF_F_ALL_CPUS to avoid LRU eviction
  (reported by Alexei).

v9 -> v10:
* Add tests to verify array and hash maps do not support BPF_F_CPU and
  BPF_F_ALL_CPUS flags.
* Address comment from Andrii:
  * Copy map value using copy_map_value_long for percpu_cgroup_storage
    maps in a separate patch.

v8 -> v9:
* Change value type from u64 to u32 in selftests.
* Address comments from Andrii:
  * Keep value_size unaligned and update everywhere for consistency when
    cpu flags are specified.
  * Update value by getting pointer for percpu hash and percpu
    cgroup_storage maps.

v7 -> v8:
* Address comments from Andrii:
  * Check BPF_F_LOCK when update percpu_array, percpu_hash and
    lru_percpu_hash maps.
  * Refactor flags check in __htab_map_lookup_and_delete_batch().
  * Keep value_size unaligned and copy value using copy_map_value() in
    __htab_map_lookup_and_delete_batch() when BPF_F_CPU is specified.
  * Update warn message in libbpf's validate_map_op().
  * Update comment of libbpf's bpf_map__lookup_elem().

v6 -> v7:
* Get correct value size for percpu_hash and lru_percpu_hash in
  update_batch API.
* Set 'count' as 'max_entries' in test cases for lookup_batch API.
* Address comment from Alexei:
  * Move cpu flags check into bpf_map_check_op_flags().

v5 -> v6:
* Move bpf_map_check_op_flags() from 'bpf.h' to 'syscall.c'.
* Address comments from Alexei:
  * Drop the refactoring code of data copying logic for percpu maps.
  * Drop bpf_map_check_op_flags() wrappers.

v4 -> v5:
* Address comments from Andrii:
  * Refactor data copying logic for all percpu maps.
  * Drop this_cpu_ptr() micro-optimization.
  * Drop cpu check in libbpf's validate_map_op().
  * Enhance bpf_map_check_op_flags() using *allowed flags* instead of
    'extra_flags_mask'.

v3 -> v4:
* Address comments from Andrii:
  * Remove unnecessary map_type check in bpf_map_value_size().
  * Reduce code churn.
  * Remove unnecessary do_delete check in
    __htab_map_lookup_and_delete_batch().
  * Introduce bpf_percpu_copy_to_user() and bpf_percpu_copy_from_user().
  * Rename check_map_flags() to bpf_map_check_op_flags() with
    extra_flags_mask.
  * Add human-readable pr_warn() explanations in validate_map_op().
  * Use flags in bpf_map__delete_elem() and
    bpf_map__lookup_and_delete_elem().
  * Drop "for alignment reasons".
v3 link: https://lore.kernel.org/bpf/20250821160817.70285-1-leon.hwang@linux.dev/

v2 -> v3:
* Address comments from Alexei:
  * Use BPF_F_ALL_CPUS instead of BPF_ALL_CPUS magic.
  * Introduce these two cpu flags for all percpu maps.
* Address comments from Jiri:
  * Reduce some unnecessary u32 cast.
  * Refactor more generic map flags check function.
  * A code style issue.
v2 link: https://lore.kernel.org/bpf/20250805163017.17015-1-leon.hwang@linux.dev/

v1 -> v2:
* Address comments from Andrii:
  * Embed cpu info as high 32 bits of *flags* totally.
  * Use ERANGE instead of E2BIG.
  * Few format issues.

Leon Hwang (7):
  bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags
  bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array
    maps
  bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash
    and lru_percpu_hash maps
  bpf: Copy map value using copy_map_value_long for
    percpu_cgroup_storage maps
  bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for
    percpu_cgroup_storage maps
  libbpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu maps
  selftests/bpf: Add cases to test BPF_F_CPU and BPF_F_ALL_CPUS flags

 include/linux/bpf-cgroup.h                    |   4 +-
 include/linux/bpf.h                           |  35 +-
 include/uapi/linux/bpf.h                      |   2 +
 kernel/bpf/arraymap.c                         |  29 +-
 kernel/bpf/hashtab.c                          |  94 +++--
 kernel/bpf/local_storage.c                    |  27 +-
 kernel/bpf/syscall.c                          |  37 +-
 tools/include/uapi/linux/bpf.h                |   2 +
 tools/lib/bpf/bpf.h                           |   8 +
 tools/lib/bpf/libbpf.c                        |  26 +-
 tools/lib/bpf/libbpf.h                        |  21 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 328 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_alloc_array.c  |  32 ++
 13 files changed, 560 insertions(+), 85 deletions(-)

--
2.52.0



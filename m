Return-Path: <linux-kselftest+bounces-48209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53CCCF45CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 16:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B84D730245BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA973314D3E;
	Mon,  5 Jan 2026 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gyzPxnce"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58A3164D4
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626347; cv=none; b=FCc2c+T0JnQpyxNv9eDxr6K1cXdiQmRfZVbxfUtuKrdQHqGLY3s0j2GKAUwNAWLosbgby/x5mc8hTlZoZtNIGN6B7pZL++fee77DV+fQpAF1ZS3e+EWFFH3T07HnZWBHWksqlt8qJFdx9uAdqxbAoqgw/echpetpTHdqFOxxQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626347; c=relaxed/simple;
	bh=JqJ2BoNtltAF4CdCixKy+9lQYGwcL8WO32rfjrQW9sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q14X0HsdUftagXB5QMPET0jwiRUfZL0gsHAS2S5U1HCH0eAz9rlpjIw0v5BGEfEs/gkjzmy5OXpNk3sKYGSgBisDEYppEu6mIcQeHD7vujDn0g6swd74FrewisHZ2lwi4SjEwgqjz5e1nipiwZ1A/rGi4s6j85Hi2Jk3vVcPF7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gyzPxnce; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767626333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UXw9mrxZiYe23hLr/K2kTlNo18tECkhAsZTVr1vBB7M=;
	b=gyzPxncefvtoeUnk8Y4d+tfn7Du0ouNQzyShvzFoow2L+z5S6BIXWsIALPQUM6iLHUjjJF
	GQgqiBhVLRW2utrwR4CaDHqeuAbOQflMjvQiyOBGSZsx45/+SjPe8NHHhVV9QHxd9wc++f
	H6D2RzT8DnR3EndltUzcz5iSWpGCJMk=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 0/5] bpf: lru: Fix unintended eviction when updating lru hash maps
Date: Mon,  5 Jan 2026 23:18:08 +0800
Message-ID: <20260105151813.6968-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This unintended LRU eviction issue was observed while developing the
selftest for
"[PATCH bpf-next v10 0/8] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps" [1].

When updating an existing element in lru_hash or lru_percpu_hash maps,
the current implementation calls prealloc_lru_pop() to get a new node
before checking if the key already exists. If the map is full, this
triggers LRU eviction and removes an existing element, even though the
update operation only needs to modify the value in-place.

In the selftest of the aforementioned patch, this was to be worked around by
reserving an extra entry to
void triggering eviction in __htab_lru_percpu_map_update_elem(). However, the
underlying issue remains problematic because:

1. Users may unexpectedly lose entries when updating existing keys in a
   full map.
2. The eviction overhead is unnecessary for existing key updates.

This patchset fixes the issue by first checking if the key exists before
allocating a new node. If the key is found, update the value using the extra
LRU node without triggering any eviction. Only proceed with node allocation
if the key does not exist.

Links:
[1] https://lore.kernel.org/bpf/20251117162033.6296-1-leon.hwang@linux.dev/

Changes:
v1 -> v2:
 * Tidy hash handling in LRU code.
 * Factor out bpf_lru_node_reset_state helper.
 * Factor out bpf_lru_move_next_inactive_rotation helper.
 * Update element using preallocated extra elements in order to avoid
   breaking the update atomicity (per Alexei).
 * Check values on other CPUs in tests (per bot).
 * v1: https://lore.kernel.org/bpf/20251202153032.10118-1-leon.hwang@linux.dev/

Leon Hwang (5):
  bpf: lru: Tidy hash handling in LRU code
  bpf: lru: Factor out bpf_lru_node_reset_state helper
  bpf: lru: Factor out bpf_lru_move_next_inactive_rotation helper
  bpf: lru: Fix unintended eviction when updating lru hash maps
  selftests/bpf: Add tests to verify no unintended eviction when
    updating lru_[percpu_,]hash maps

 kernel/bpf/bpf_lru_list.c                     | 228 ++++++++++++++----
 kernel/bpf/bpf_lru_list.h                     |  10 +-
 kernel/bpf/hashtab.c                          |  90 ++++++-
 .../selftests/bpf/prog_tests/htab_update.c    | 129 ++++++++++
 4 files changed, 402 insertions(+), 55 deletions(-)

--
2.52.0



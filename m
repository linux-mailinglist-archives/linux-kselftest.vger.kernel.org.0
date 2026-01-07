Return-Path: <linux-kselftest+bounces-48369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA71CFBBB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 03:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C998D30E46B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 02:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E940236A73;
	Wed,  7 Jan 2026 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SVfaM9w9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2273FC9
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752764; cv=none; b=NhxsHhkNDX1uRjJdPXtEPPAZaYLoMP6C3xr8CHFDUFyQZGt2/af04qdd2PDOBWgK5mwz1EGi1ib4SfjoH9f2c4ERfIbF0e9qkQuGYR85MmEiXNduvFinuK32tzFYHz5am0SDe2OK/OpJWnXE1zWDILZIsjqxPBcIYGs/8bDKB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752764; c=relaxed/simple;
	bh=6yToe/4XPVFpSULq2xyCY6GpCp4EcBzMCKcpfk2HEAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTh3hrvPyAaVdpA9UB2H8eQjbBmR5v2vU+U4AofHxdItxAtFXhk/jmHRNxSruwGwqxWO1BxUft4HoxZWjO7d3Q/GSyE4zesRwXNgB3jf8oQZFCZASnHKSR4yKT4cs/rmAvtw1U1rC76WNMr3ou1c7eL8lpiY5xX+W/B5xs08EZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SVfaM9w9; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767752760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlSBVw0uGZ4K2Sh6TYpsMWOlO6HjrG+uoe4h85OutcI=;
	b=SVfaM9w9ODskm8HLDjUrRMmbe7fYwwe1XI1r8jO5g+Eti5yxdVoXDDgFxBWk7G682jQENa
	jLTZ4zTbapUUvyodmLnRQfqbtzgxm9CuMSDVciOEXJqzWkIe1iKGdVFZmr4k9A3aP2fIsD
	+z06EyRRI7Fssc/XTB3ylAwDDLCJ/vo=
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
Subject: [PATCH bpf-next v13 4/7] bpf: Copy map value using copy_map_value_long for percpu_cgroup_storage maps
Date: Wed,  7 Jan 2026 10:20:19 +0800
Message-ID: <20260107022022.12843-5-leon.hwang@linux.dev>
In-Reply-To: <20260107022022.12843-1-leon.hwang@linux.dev>
References: <20260107022022.12843-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Copy map value using 'copy_map_value_long()'. It's to keep consistent
style with the way of other percpu maps.

No functional change intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/local_storage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index c93a756e035c..2ab4b60ffe61 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -200,8 +200,7 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
 	 */
 	size = round_up(_map->value_size, 8);
 	for_each_possible_cpu(cpu) {
-		bpf_long_memcpy(value + off,
-				per_cpu_ptr(storage->percpu_buf, cpu), size);
+		copy_map_value_long(_map, value + off, per_cpu_ptr(storage->percpu_buf, cpu));
 		off += size;
 	}
 	rcu_read_unlock();
@@ -234,8 +233,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 	 */
 	size = round_up(_map->value_size, 8);
 	for_each_possible_cpu(cpu) {
-		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
-				value + off, size);
+		copy_map_value_long(_map, per_cpu_ptr(storage->percpu_buf, cpu), value + off);
 		off += size;
 	}
 	rcu_read_unlock();
-- 
2.52.0



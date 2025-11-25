Return-Path: <linux-kselftest+bounces-46444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6FDC85A1F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFFA04ED740
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 15:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72BD326D4D;
	Tue, 25 Nov 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XZMKMvrU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF12727EB
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082829; cv=none; b=WuTyisXruXZN1m1NjZZGok0NgSAbmzhxnS05twkhvfYdvlAGQkMpLN33ZNXNgF+s0C+TweQDp2fkiqFmUY1kBYo6nuTIpZphYrNSRtCXF8qCSPXRTQMyRbIzNWmxfM07Vl+c0sl1hLl8+pcKkmm/M0wQnsuiIK6CNkkMqeFI6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082829; c=relaxed/simple;
	bh=SZ9BjoQFDYKINn07VcspgXWVdM9dxtKA1Gv6JFK8Y5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mus06XC2hPJ9Z8WPLD+4em0LMeotUzF83v3E+kTcZj7oS0o1af9sJb0ft6iYw3QkYsmesf0JCQrlln4WZKTy1hNPaRZpRUX1Zs7bVeAXqvOebPAuRxY+HdSYO9EY6ckIAvEsMZousNMXkLMRbZUaNMOC2nDtskU2QZfYX4Qefss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XZMKMvrU; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764082825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTgwqBgBsAEUNrMYXmgH0c/Rvt/LDiv6qDBO69l3Lvo=;
	b=XZMKMvrUKlbfm8spXdd6Cd0o1tS3waGseo2VrZfQDKMxr722bMCQMjcwtoi2WFNilpQJem
	gAeiaIXgSsj/nlN60YMqI6TmrOvHwV1r6DR8iUBCZgbNycTCFoMosqVfMe5ec7hWrL2KGV
	CTn4CH8nkaQ5yUoaKdwxreJEpvrEE6w=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	shuah@kernel.org,
	kerneljasonxing@gmail.com,
	chen.dylane@linux.dev,
	willemb@google.com,
	paul.chaignon@gmail.com,
	a.s.protopopov@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	tklauser@distanz.ch,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v11 5/8] bpf: Copy map value using copy_map_value_long for percpu_cgroup_storage maps
Date: Tue, 25 Nov 2025 22:58:54 +0800
Message-ID: <20251125145857.98134-6-leon.hwang@linux.dev>
In-Reply-To: <20251125145857.98134-1-leon.hwang@linux.dev>
References: <20251125145857.98134-1-leon.hwang@linux.dev>
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
2.51.2



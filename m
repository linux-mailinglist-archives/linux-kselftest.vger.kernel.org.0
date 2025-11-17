Return-Path: <linux-kselftest+bounces-45765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03AC65237
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 17:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D285368043
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 16:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23E32D47FE;
	Mon, 17 Nov 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XQSoRlRI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79892D3EE5
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396510; cv=none; b=NWtFxGW9tkf1AepKSUJDN7KkBN5mlJoRLiBRNGSwYGuxZnY5ZPfOdJeBYuEKl91x9znSQNwXrMGP0wdv77IWGUFjVJs8umAudSH4zOQSO+n4gFBMaLL8QH/pFmHYiBLco/scSvq9JBNVbL+KkE1GsM4C7x+lNlb3sgylG9H7jpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396510; c=relaxed/simple;
	bh=q+SS09vPl9RVqEDMec7z3rfKuBIlv1TiECjWVh29Xtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezs91GRoaaA11Bs2Pzi0QSwL+TzWWmhDZ1gKPLnRxd5T5dwxGNX3TbqlJB892Z+8CvVrynvIsqwkUTaTHcLUyyhpCf0L6tYGK+xSZZpya8tcyTpiLSppTqfn0EOzXwV6dMOvICRvULwOrk6kB1qNJ6r6Nj7at7TBOu8Em3qa9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XQSoRlRI; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763396506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlFP1LkuoidfQEZRw88sVLRc8cr0hCYNFbVaNj3uzRk=;
	b=XQSoRlRI0bRU1xDf4iThPmt8e+gcf8dT6Fie5AMJJhFvKAy/I3kZpTJnrIcuS0RA3NUhOn
	EMztkM8SC3SWgea0Yh8vwXmpYuckRnfB40SPbIvdQut1jcz4pRU6eI14t0UQ5nT90EQyB1
	4GEqyPJztZNFTO58rIO8IuE/qzvU8kU=
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
Subject: [PATCH bpf-next v10 5/8] bpf: Copy map value using copy_map_value_long for percpu_cgroup_storage maps
Date: Tue, 18 Nov 2025 00:20:30 +0800
Message-ID: <20251117162033.6296-6-leon.hwang@linux.dev>
In-Reply-To: <20251117162033.6296-1-leon.hwang@linux.dev>
References: <20251117162033.6296-1-leon.hwang@linux.dev>
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
index c93a756e035c0..2ab4b60ffe61f 100644
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



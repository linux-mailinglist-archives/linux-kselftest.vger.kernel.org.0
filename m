Return-Path: <linux-kselftest+bounces-46509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D96CCC8A772
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1336234982D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0EE30EF63;
	Wed, 26 Nov 2025 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GIU7cTF6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F2304BCA
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168734; cv=none; b=MXYQ6BKqu9i5YnHXRl+2lgzR5BB8Fps4KjuYE6Dtsp8cxpEvyMiDiY/lhGtTZY3M+MyGYTa+1oYqtDg8OHh1TzHbulH6kMYoblKWbgPTHXH9pw7ZSuAkGr6PoWo56bFOtt1g4rBYbXcR75L+lgaAGGGwBvIFu35H1rVeRre3l7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168734; c=relaxed/simple;
	bh=SZ9BjoQFDYKINn07VcspgXWVdM9dxtKA1Gv6JFK8Y5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8FoBB3rJR16PkLhcGR41rOjoUtdVkJR3StUjotkNDhWHsOiKJuyChRifdnnYEJzUeeSs8BG13+eDHfHhKFdOa7uwH0X+l6gqAHjh73UIFmamQs/T30FgK4OH/YypE06/4W8ouuoThCKxqyVrAoQmsi3WkJKdUyFjJjcVKD4jAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GIU7cTF6; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764168729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTgwqBgBsAEUNrMYXmgH0c/Rvt/LDiv6qDBO69l3Lvo=;
	b=GIU7cTF6BEIB19xr9G2VgzlrID2kRyYTLeLpshQ+NZDITLBgss5B66VA2iiU8zJ9KFlJxh
	KfrS766zVMHCxvb8AmtA8O0neNT7Us0BrCuGfUsfogJ/xjzrAhtHMPYIJ9u/wwvG5MJOrs
	YXJv9E6gfFOGiqhqsZbVmYl3LnchbaQ=
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
Subject: [PATCH bpf-next v12 4/7] bpf: Copy map value using copy_map_value_long for percpu_cgroup_storage maps
Date: Wed, 26 Nov 2025 22:50:36 +0800
Message-ID: <20251126145039.15715-5-leon.hwang@linux.dev>
In-Reply-To: <20251126145039.15715-1-leon.hwang@linux.dev>
References: <20251126145039.15715-1-leon.hwang@linux.dev>
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



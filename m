Return-Path: <linux-kselftest+bounces-9126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA9A8B7024
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 12:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7896B21B5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 10:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386AA12D1F4;
	Tue, 30 Apr 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azz8RW30"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED712C55D;
	Tue, 30 Apr 2024 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473821; cv=none; b=GJ8bqmknY/UJ4l3q1D14EE71VveiXuWKX39XnZ8HLsZvKjPhC/ufJUMZ7XPlltzsA1dazA6aXDbjuzWikBt1vFZ1Fwcdk9TZURoeAgRQXhX4C7SQNgt3A8w605Lt+TLP/IRBkVfArz0OjKLRVS1Sa84mwYwbnOy+tMCS+yUd3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473821; c=relaxed/simple;
	bh=scdYD6Pl04lfvb+n/4ZxgZp2ul4X56LAd6/2RPvnbKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k7T/9za3pjnJKbvJ9MJ4xukgiTkhfR+KEZ5PxT4TWOuVH8TzCGfqt3aZusAOu624+amu/UICvXW+B0HldUWEyes9RTMxo0OXfsVOoUcIhwZDIR/2ho8Nfy9TsVn6wGcJavFzWqD9j0HgduIOd1hxKZOE9vpAQvQXuQShyIdbGiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azz8RW30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B11C4AF4D;
	Tue, 30 Apr 2024 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714473820;
	bh=scdYD6Pl04lfvb+n/4ZxgZp2ul4X56LAd6/2RPvnbKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Azz8RW30b5RWa3U2ynB4523004XmMEyDSEzgd+zgLwJr2HbmgqfSwQUwBPg1XdL0o
	 6A8JtOO1jbz0AP5pXB38y63bX7Lakr1X/yj3k6KD5uFBy+rbcGfAtBNh+5DvliZ3Xi
	 BMLtPjmj1Sqg+Xt5VXDy/jUMzQXjHRUYSKLf8ommbs+fnMGUfR08D3io1RqfCNsrSv
	 cxrhj0T8C7XKlLPLKR2p41RcZEE32d1ot/eSdy0EOYsMwmHM662fp6TZ/vG81sGSbG
	 sEXZ+YjnjXsMgyRppkGhJq797bOrJPYBhMFDwVzPUlV7Zo9XGO+iA5Fg9TKDtXaQ53
	 7Feph65qAWl4g==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 30 Apr 2024 12:43:25 +0200
Subject: [PATCH bpf-next v3 2/3] bpf: do not walk twice the hash map on
 free
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-bpf-next-v3-2-27afe7f3b17c@kernel.org>
References: <20240430-bpf-next-v3-0-27afe7f3b17c@kernel.org>
In-Reply-To: <20240430-bpf-next-v3-0-27afe7f3b17c@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714473809; l=4038;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=scdYD6Pl04lfvb+n/4ZxgZp2ul4X56LAd6/2RPvnbKw=;
 b=EZ24aspZONQX1VcEEk8ik4tH9E5dhc0Fa79o6LjWzDOVfZiVlcvCNZb9tfgjqeJf3I2/HOyWD
 y9vk62TupKiBFG72Hnhwt6C74ro4kR3Reo2PKBvtCg9IDvZ3RKAivbU
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

If someone stores both a timer and a workqueue in a hash map, on free, we
would walk it twice.
Add a check in htab_free_malloced_timers_or_wq and free the timers
and workqueues if they are present.

Fixes: 246331e3f1ea ("bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v3:
- fix unloading of bpf_wq, again

changes in v2:
- fix wq being not freed (and static call not used)
---
 kernel/bpf/hashtab.c | 49 +++++++++++++------------------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 0179183c543a..06115f8728e8 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -221,13 +221,11 @@ static bool htab_has_extra_elems(struct bpf_htab *htab)
 	return !htab_is_percpu(htab) && !htab_is_lru(htab);
 }
 
-static void htab_free_prealloced_timers(struct bpf_htab *htab)
+static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
 {
 	u32 num_entries = htab->map.max_entries;
 	int i;
 
-	if (!btf_record_has_field(htab->map.record, BPF_TIMER))
-		return;
 	if (htab_has_extra_elems(htab))
 		num_entries += num_possible_cpus();
 
@@ -235,27 +233,12 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
 		struct htab_elem *elem;
 
 		elem = get_htab_elem(htab, i);
-		bpf_obj_free_timer(htab->map.record, elem->key + round_up(htab->map.key_size, 8));
-		cond_resched();
-	}
-}
-
-static void htab_free_prealloced_wq(struct bpf_htab *htab)
-{
-	u32 num_entries = htab->map.max_entries;
-	int i;
-
-	if (!btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
-		return;
-	if (htab_has_extra_elems(htab))
-		num_entries += num_possible_cpus();
-
-	for (i = 0; i < num_entries; i++) {
-		struct htab_elem *elem;
-
-		elem = get_htab_elem(htab, i);
-		bpf_obj_free_workqueue(htab->map.record,
-				       elem->key + round_up(htab->map.key_size, 8));
+		if (btf_record_has_field(htab->map.record, BPF_TIMER))
+			bpf_obj_free_timer(htab->map.record,
+					   elem->key + round_up(htab->map.key_size, 8));
+		if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
+			bpf_obj_free_workqueue(htab->map.record,
+					       elem->key + round_up(htab->map.key_size, 8));
 		cond_resched();
 	}
 }
@@ -1515,7 +1498,7 @@ static void delete_all_elements(struct bpf_htab *htab)
 	migrate_enable();
 }
 
-static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab, bool is_timer)
+static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
 {
 	int i;
 
@@ -1527,10 +1510,10 @@ static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab, bool is_timer
 
 		hlist_nulls_for_each_entry(l, n, head, hash_node) {
 			/* We only free timer on uref dropping to zero */
-			if (is_timer)
+			if (btf_record_has_field(htab->map.record, BPF_TIMER))
 				bpf_obj_free_timer(htab->map.record,
 						   l->key + round_up(htab->map.key_size, 8));
-			else
+			if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
 				bpf_obj_free_workqueue(htab->map.record,
 						       l->key + round_up(htab->map.key_size, 8));
 		}
@@ -1544,17 +1527,11 @@ static void htab_map_free_timers_and_wq(struct bpf_map *map)
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
 	/* We only free timer and workqueue on uref dropping to zero */
-	if (btf_record_has_field(htab->map.record, BPF_TIMER)) {
-		if (!htab_is_prealloc(htab))
-			htab_free_malloced_timers_or_wq(htab, true);
-		else
-			htab_free_prealloced_timers(htab);
-	}
-	if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE)) {
+	if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQUEUE)) {
 		if (!htab_is_prealloc(htab))
-			htab_free_malloced_timers_or_wq(htab, false);
+			htab_free_malloced_timers_and_wq(htab);
 		else
-			htab_free_prealloced_wq(htab);
+			htab_free_prealloced_timers_and_wq(htab);
 	}
 }
 

-- 
2.44.0



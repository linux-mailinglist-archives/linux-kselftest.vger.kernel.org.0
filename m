Return-Path: <linux-kselftest+bounces-9121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D6A8B6E95
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 11:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708EF2846A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBF91A0AE7;
	Tue, 30 Apr 2024 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFoabQAu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2613D262;
	Tue, 30 Apr 2024 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469789; cv=none; b=rZDB1Vm7bxPZUpbh6E5T1pME3yiAXutR098KxBBAmqchzKf5PjcYw6t4c4INLvIZtGxPt38UGlOYTNlUFgV46/Huldob3FbulYQKecWmQAO24bi2ERrSlBv37iVXAv/ZbbLTQ7ymeq5QCBYUIJ9gljwU6nN+8dY+ra0UUiN7GDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469789; c=relaxed/simple;
	bh=mCuLxTaxKyTT1kzYlei9LV+3e2KuRqWDO+D7edZIeC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=coIEVKk5maXzo27qNBwXHC8YrvU0CGWYYOpaw6zNfT29HsUoF+z/VUnketQ5KfRXcjgaSjMbQalH7a7x9oM19+qvi4R0DuXnsbs53xPMGtJ8+v4M+OvEdQ3xXBAzto1uAWv1Q2uaGEzL17BISDrf4YlRpz3kefMvljtgEXRnlKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFoabQAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7118C4AF14;
	Tue, 30 Apr 2024 09:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714469789;
	bh=mCuLxTaxKyTT1kzYlei9LV+3e2KuRqWDO+D7edZIeC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kFoabQAuidhgovowuzf7LI+qbTdQ9BjBbAqUG1yis+ukojsV+egPiZyAUQloPbirW
	 dedXaDgz9amT+Nj1aoH3ptZ0jMxDeRFvaTJqPTzae/qGSElevoShA70qZ3reGMVFeq
	 SI3fW4BsfMfq3tA2ZPBXmuowJWSZWl4vdxOyA9dr4VgTplbACY8NjqK6VI3Ga/4/jC
	 VnLlU0q7Xmmjo8sIrUl2tZn2U1I4r72rShiRjKP+YyQixxhbff+SaQL9SN5kejXYWM
	 FvQVXWH01y2np1hsloFj3hfE4tUN4cjZB6oFw7ERROmLD1/koJU881brZHWn23zApN
	 WmfLs8wC3ZFhw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 30 Apr 2024 11:36:11 +0200
Subject: [PATCH v2 2/3] bpf: do not walk twice the hash map on free
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-bpf-next-v2-2-140aa50f0f19@kernel.org>
References: <20240430-bpf-next-v2-0-140aa50f0f19@kernel.org>
In-Reply-To: <20240430-bpf-next-v2-0-140aa50f0f19@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714469778; l=3927;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=mCuLxTaxKyTT1kzYlei9LV+3e2KuRqWDO+D7edZIeC0=;
 b=wm6bD7epmm+7HTNl9qu5AyuDg//HjDeOrs9ejYRHe57Z85wdJUHowA/HoykRqsx4iI1dZMtJs
 fN5UYhFyz5JCJHX5dl4z5IEeUbBOcrt+SDbQprnNbc26Ot/+GP6rteI
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

If someone stores both a timer and a workqueue in a hash map, on free, we
would walk it twice.
Add a check in htab_free_malloced_timers_or_wq and free the timers
and workqueues if they are present.

Fixes: 246331e3f1ea ("bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- fix wq being not freed (and static call not used)
---
 kernel/bpf/hashtab.c | 49 +++++++++++++------------------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 0179183c543a..5eefadfc8ea9 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -221,32 +221,11 @@ static bool htab_has_extra_elems(struct bpf_htab *htab)
 	return !htab_is_percpu(htab) && !htab_is_lru(htab);
 }
 
-static void htab_free_prealloced_timers(struct bpf_htab *htab)
+static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
 {
 	u32 num_entries = htab->map.max_entries;
 	int i;
 
-	if (!btf_record_has_field(htab->map.record, BPF_TIMER))
-		return;
-	if (htab_has_extra_elems(htab))
-		num_entries += num_possible_cpus();
-
-	for (i = 0; i < num_entries; i++) {
-		struct htab_elem *elem;
-
-		elem = get_htab_elem(htab, i);
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
 	if (htab_has_extra_elems(htab))
 		num_entries += num_possible_cpus();
 
@@ -254,8 +233,12 @@ static void htab_free_prealloced_wq(struct bpf_htab *htab)
 		struct htab_elem *elem;
 
 		elem = get_htab_elem(htab, i);
-		bpf_obj_free_workqueue(htab->map.record,
-				       elem->key + round_up(htab->map.key_size, 8));
+		if (btf_record_has_field(htab->map.record, BPF_TIMER))
+			bpf_obj_free_timer(htab->map.record,
+					   elem->key + round_up(htab->map.key_size, 8));
+		else
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



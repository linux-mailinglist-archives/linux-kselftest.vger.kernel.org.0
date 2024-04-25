Return-Path: <linux-kselftest+bounces-8858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392428B2353
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 16:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53DA2B214FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 14:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182D14A0BC;
	Thu, 25 Apr 2024 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNE5RsAg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646C14A0AD;
	Thu, 25 Apr 2024 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053570; cv=none; b=UHWUskXIeeeT/s/e2WMUotcYORq+qKq9WNlhCPEuUn1HLKRIJyc3OmRcsAS5ktpQL9I/KLCT7gnYDxIg8MFggtH1if1bfnFgzVCbx8gMerDWxwU6BUCcVPJ/yia8illxVvIEpk7PCpIRtksudADbDh+1ehOKUIF/EFcqKizfk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053570; c=relaxed/simple;
	bh=/jfDurkkyTX1CjxTQWI9/U9pueeszadMVJLu6GiEwj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CQBYUo6bJbXE6eQuMEX2jmxrofo7u9ogMPgii1CReUGbo6xVdA5o4Puh1sVehMqOmmeXImimULRehvh6sMbhMHlJJN0ao5ixs6A9bLywAAhcATTp47bAVSNYHfOuXFUOBVN2c9peBTHbUIBsGBqeBWQeCwEG0Lml7e4TGQHRU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNE5RsAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA319C3277B;
	Thu, 25 Apr 2024 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053570;
	bh=/jfDurkkyTX1CjxTQWI9/U9pueeszadMVJLu6GiEwj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HNE5RsAgTaZoxrIvlG1EZ6FNVeBiolN9FzELHstT8/YZC48DrHK8K1+Z2hi5wlfjB
	 IM8VM/RB4xTlPAfw0BetGUQ3zZewCaIPD2SZcNtgBC2fCnHIlc7GOxaiK7oua15rJb
	 vp2k7f4kWXcVWMLkVNIFnc6ilydDxJxicpUbd/9nyL/mu9TIDV6MB0u/BeKB6jR3Jz
	 FxO6qS2LBhun3RpAuDHASQfDrEbEendMRGjHw6kHuruOeMZ46rlfp3IxtXKnVXP/CJ
	 JW/9GtEK/3SylZATP/21S1nSKenKfpo+1F8HvzCMxnl67Nwu213DntyRBu7WbReUpM
	 mgGaNCNQRF0Ww==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 25 Apr 2024 15:59:13 +0200
Subject: [PATCH 2/3] bpf: do not walk twice the hash map on free
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-bpf-next-v1-2-1d8330e6c643@kernel.org>
References: <20240425-bpf-next-v1-0-1d8330e6c643@kernel.org>
In-Reply-To: <20240425-bpf-next-v1-0-1d8330e6c643@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714053558; l=2311;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=/jfDurkkyTX1CjxTQWI9/U9pueeszadMVJLu6GiEwj0=;
 b=Mz0bcCjh5PHLLrFEt0aDcjPvdnjN285NxBvdb63Pfw6n7lah+bC7DmxGNCp7JMh4WAhpXyb1x
 UrYXaq5DWWZB4TGvBQtqBxpb+smpQMVI3NtB3RmAWaay6gpNWQu/nmE
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

If someone stores both a timer and a workqueue in a hash map, on free, we
would walk it twice.
Add a check in htab_free_malloced_timers_or_wq and free the timers
and workqueues if they are present.

Fixes: 246331e3f1ea ("bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 kernel/bpf/hashtab.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 0179183c543a..20162ae741e9 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1515,7 +1515,7 @@ static void delete_all_elements(struct bpf_htab *htab)
 	migrate_enable();
 }
 
-static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab, bool is_timer)
+static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab)
 {
 	int i;
 
@@ -1527,10 +1527,10 @@ static void htab_free_malloced_timers_or_wq(struct bpf_htab *htab, bool is_timer
 
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
@@ -1544,18 +1544,12 @@ static void htab_map_free_timers_and_wq(struct bpf_map *map)
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
 	/* We only free timer and workqueue on uref dropping to zero */
-	if (btf_record_has_field(htab->map.record, BPF_TIMER)) {
+	if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQUEUE)) {
 		if (!htab_is_prealloc(htab))
-			htab_free_malloced_timers_or_wq(htab, true);
+			htab_free_malloced_timers_or_wq(htab);
 		else
 			htab_free_prealloced_timers(htab);
 	}
-	if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE)) {
-		if (!htab_is_prealloc(htab))
-			htab_free_malloced_timers_or_wq(htab, false);
-		else
-			htab_free_prealloced_wq(htab);
-	}
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */

-- 
2.44.0



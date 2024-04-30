Return-Path: <linux-kselftest+bounces-9120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014AE8B6E92
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 11:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2971F250B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C989919DF57;
	Tue, 30 Apr 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRIdCHTK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79C28DDF;
	Tue, 30 Apr 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469785; cv=none; b=pG+VEanqL3FNPefOr+BD/kOWjLLE+Fi7RtWmjW9D+VvaReWkfHUhq4YHYlHCe8y8XDXWNkxSA+dj4leb/ONvbsrvINe7qRFV0Aenwi46oTOnAxRoWvMdsJXKdeET5pXFZF+P9ydSY8ngBIVwdmiwclt9PWsXheNqdTz6RYO6cTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469785; c=relaxed/simple;
	bh=O9q/3BVp7ykhUDY0RgKC9pwWwJupmmRs4n4Uim9KjQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7H9W/utSHU0e4YX2CF2JFgmz50gn/DMca0M+UXVIVLpsuv8ebsb0lVmn9rOomXKaDErGNTCtTnNN7WYxSI2PS6pndDXhWqi206MI6gCwx4+s8998sjqn6PPKySZCI2ykDvwmisk/7quQdGt6mTowW8t4wode1f89okJQDHffa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRIdCHTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BA5C4AF4D;
	Tue, 30 Apr 2024 09:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714469785;
	bh=O9q/3BVp7ykhUDY0RgKC9pwWwJupmmRs4n4Uim9KjQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GRIdCHTKlzYxlFIDQZxwLusiDbaaSNK+vyOYCFIS+Eeuwtkc25B5EhSFk7B6hm0AW
	 Bn5v0vU5AsaO/VGeI6QQ8agnAOVJTHihuOnlWVAXnqXKX1pZ7JUWUFmd3jaJu3s61J
	 WFprkS/cLzBy0TjxYJjquM/cO6Jn8njMH0dxF2O6VsqzAjrabmM8o8/0gGbUEXqjPi
	 7aTXAi0xiIpmURazQOz0DiN7AFp5edaHC6wpTRqx1Bp81bIvozJjpKh3XXk/VQfuDc
	 8FoyKVb5mNg5nOA4FSaloJe92drJHJ92jjNzZP15GfWsed+PLVFpgLOYtHja2a/rqx
	 iZvaUjo9XT7pQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 30 Apr 2024 11:36:10 +0200
Subject: [PATCH v2 1/3] bpf: do not walk twice the map on free
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-bpf-next-v2-1-140aa50f0f19@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714469778; l=1659;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=O9q/3BVp7ykhUDY0RgKC9pwWwJupmmRs4n4Uim9KjQo=;
 b=0RyqTthwuyYXXJCv8I7WMlwiJL8U8W7Ho72KCoMyZwbQmNDJeUVyrN160lRYUE53SKRsmLoQX
 TWvL8F4mT2lBbE2+hmP8fKXA1iaDX0Ap0FI62ZgR0QPYq11FKrMzilo
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

If someone stores both a timer and a workqueue in a map, on free we
would walk it twice.
Add a check in array_map_free_timers_wq and free the timers
and workqueues if they are present.

Fixes: 246331e3f1ea ("bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 kernel/bpf/arraymap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 580d07b15471..feabc0193852 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -436,13 +436,14 @@ static void array_map_free_timers_wq(struct bpf_map *map)
 	/* We don't reset or free fields other than timer and workqueue
 	 * on uref dropping to zero.
 	 */
-	if (btf_record_has_field(map->record, BPF_TIMER))
-		for (i = 0; i < array->map.max_entries; i++)
-			bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
-
-	if (btf_record_has_field(map->record, BPF_WORKQUEUE))
-		for (i = 0; i < array->map.max_entries; i++)
-			bpf_obj_free_workqueue(map->record, array_map_elem_ptr(array, i));
+	if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE)) {
+		for (i = 0; i < array->map.max_entries; i++) {
+			if (btf_record_has_field(map->record, BPF_TIMER))
+				bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
+			if (btf_record_has_field(map->record, BPF_WORKQUEUE))
+				bpf_obj_free_workqueue(map->record, array_map_elem_ptr(array, i));
+		}
+	}
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */

-- 
2.44.0



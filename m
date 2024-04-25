Return-Path: <linux-kselftest+bounces-8857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F28B234F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 15:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CDB1C214E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE2514A085;
	Thu, 25 Apr 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjQcqWbv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD6149E1A;
	Thu, 25 Apr 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053567; cv=none; b=ZNusgrClbFZFP2/TEsY20+y0DLzyiCBVjBam142hGF84gAtnsHLQfY4MxzU4M+Wxg4m33nW8z2pX+gajy5luPZvGSU/yGZQvj2GGGDORWLkQbl9PEUlEl6bEJ5jJ4/E9Y7jSTGWsgpdXh+4hjjdoAYEsp1blZ1KpHuBjpQjtFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053567; c=relaxed/simple;
	bh=0UjWtmDw4NdWdiV9RiGFH2oVaGYWk2wAWC/NqY/by9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ei1rgL8me9c+C3ekFzDbLUIqIl/c3XVvSfjsz09DCHQdaTFBKwRaKuKjasJkJa5i045TkwKmPdgSvis6VUI2b551X6vekRP1y/j7PvFSsu0qBjeVENzYjavJxElcCF3RzZUVDqsCC+LbvPjD4KGJ30zzpaDNsMLr88UrqCvW/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjQcqWbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB899C32783;
	Thu, 25 Apr 2024 13:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053566;
	bh=0UjWtmDw4NdWdiV9RiGFH2oVaGYWk2wAWC/NqY/by9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gjQcqWbveWT4Z3rfSXEl8UidlmtW2NjT9zckTQTkeo5WUxvUK14hRzMfntdGZJZw6
	 3chcFyQXhhSkQ0KP6pnigxqxM2jVH9GVgkc3vg/u4ynDVh56TkgMBDUXh/0KIzzOgY
	 VvfVH+sAHiReO19p+7Qkx84eOekFWVB7KDYQrnDllSVI6ip/W1aIIw80KyQmQrtxZp
	 oBCFGFBxqP6pcZL21v3fbVXLW5eC8LMjlWA79+d9xwQ8aTVmzPgEMnJbloE+uH+CI3
	 YrWX6iCoBW+CG25wfuqjgs36c8VihCyav2vn9ZjolqoEdKFgdIV3oSZ/7WKopJVrTP
	 oP/xkv85jvq7w==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 25 Apr 2024 15:59:12 +0200
Subject: [PATCH 1/3] bpf: do not walk twice the map on free
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-bpf-next-v1-1-1d8330e6c643@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714053558; l=1632;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=0UjWtmDw4NdWdiV9RiGFH2oVaGYWk2wAWC/NqY/by9Y=;
 b=RKtnAsLvD2iqjvzpo5k2I1Q4VyNf7Rj1fx5HEQ/MKI+iKzaLwwaZr/XnRQswXFymVJeBFXfYW
 gqBO+/jQGrtA7khINJp9kK4fFri609NjGRLuTokCwimqhrKmAoER7J8
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

If someone stores both a timer and a workqueue in a map, on free we
would walk it twice.
Add a check in array_map_free_timers_wq and free the timers
and workqueues if they are present.

Fixes: 246331e3f1ea ("bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
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



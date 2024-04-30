Return-Path: <linux-kselftest+bounces-9125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF3F8B7020
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 12:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9F0285C11
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C66612CD8C;
	Tue, 30 Apr 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwemDBum"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5412CD88;
	Tue, 30 Apr 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473817; cv=none; b=iW1hVUETOju28OBy+19P8RTpnqzj89DH9oM5+p1mS8bvOphdp0zi4gfELOL/O8rEz47aNDuspZKTDaBQn2Ba6ErqZmU/3iIBxSCgsw556Goh0QG8kWaziEMrOjJvIFN9dL3IYfbAQVG2xmIJiMoJ0vuK7X2mQBh2YsYkB5QAo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473817; c=relaxed/simple;
	bh=2DbLgfRPOuQjtWgbOdxT93yoQ/Xxj7Etz/Li4OEnMe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pg8M96a9FwcRd1QZ+jQfLyuxBPVfRnRRrtt7YwP7OoTxJrZJnoAylFEt8ryK+n3SMDHpRYpyKoiT5WugNBzyZY820naNy4GmrztrGmh9IeWw3IRuHCHKLIAWOlFd8WQTIbH+LtEPe0GhL7ID55iA3rFE2PjHi+53RAJB/NLkdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwemDBum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EA2C2BBFC;
	Tue, 30 Apr 2024 10:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714473817;
	bh=2DbLgfRPOuQjtWgbOdxT93yoQ/Xxj7Etz/Li4OEnMe4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CwemDBumFWOv3RQoJS6ME8j80MgE/M38tYI5FqsAhMypHiM24SHGc4DG/J2qb1/BR
	 LiiV/dTeClQeZuI+eG1KKrSgQO2yq+Pe7OxFvnZtBHxijTCorqFTmkKQ22/4ZPsG8f
	 +3pZlKn3PEq24wMp57rV6E7Iaeq82xm6KseJIihChz5Y6h8mWQ+eAw4v9p5314pDaE
	 Pm77Js3/u3Halh4f3OLYkw0LGHENEswuAANzQo1sd/cV/Y5OKHYFxZuPr8cA8FToY4
	 SA26efYxmNZvTEF0eYiL/BTqMvsiG9vvuYIe8h/N+YAJjgD7bPoq5WUNPAeTgen6nC
	 0EmwNpehbPvKQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 30 Apr 2024 12:43:24 +0200
Subject: [PATCH bpf-next v3 1/3] bpf: do not walk twice the map on free
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-bpf-next-v3-1-27afe7f3b17c@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714473809; l=1679;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=2DbLgfRPOuQjtWgbOdxT93yoQ/Xxj7Etz/Li4OEnMe4=;
 b=bLOyRikr37Rv6TtAU8CNK9bpzfelszIO81xHpwQbLkZkchDjeXzOcB+veuA9vAGW059bXuqOL
 wbBE8+z3610B3GRskiP899gGK2d5KhojbMCwAdX7gpT17EbB8eTddDP
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

If someone stores both a timer and a workqueue in a map, on free we
would walk it twice.
Add a check in array_map_free_timers_wq and free the timers
and workqueues if they are present.

Fixes: 246331e3f1ea ("bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

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



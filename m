Return-Path: <linux-kselftest+bounces-31786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E932A9F4D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 17:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816EA1884E9E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3527A119;
	Mon, 28 Apr 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSgZ6nxw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C414A62B;
	Mon, 28 Apr 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855067; cv=none; b=ZLERi+9xL9zxAp/67+1ZLB7TO3T9De3M7Hc5iZVJEcr7JOi9LUd8edKIALc+g6GyJLqo2fiKJS9BSPizEbKOJFnJxj11sxldg33By8zjONkyoX2mbLOCOEddngsoXCIYduNWlYM2+X9Qcx9nZOtrnS38dHMvFWLwmvXX5nbGJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855067; c=relaxed/simple;
	bh=G9IMNi4r7tAcEA5vcW/ZsLapU/zdX0f8qIdyiG9Xuwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RrykGxZCd2E7Xp2qCp+orul91hGFdxIe0QWlOVPvnlLPbbRX+8Cq0IDLqHNVAJvV7zEYRNZinkP9BGjVi9UmKFsLvMa+jFMKSll4frzqh6u7VSsxJOErwwFI9M76M0PzQN8ij7uqz1VFrHQjp8ybDIQW2GmFgD1L+QlEfd0AV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSgZ6nxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DA4C4CEE4;
	Mon, 28 Apr 2025 15:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745855067;
	bh=G9IMNi4r7tAcEA5vcW/ZsLapU/zdX0f8qIdyiG9Xuwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KSgZ6nxwVFS7KM5LG9iLlTfNBSrrJ8q87JhUW7ExyMmOluFUYbZJOq7sBuFmbMJjg
	 ei9TnsBfZjyZLfqkfSH6PaSuGWIOVb7SRuDSjO8D+S9Vu1sBPMrpKue10KqCQ14yfj
	 hYPrboYII8WRfOV3sJ9sp1yJ6uEJncj2fFVXocg9SL5bVOJr13GBd6aCVLPHmgYf5m
	 FIvXEvP0bPGMiUAMuZ9VwhWDKP1bSfjoo+KUnV1OJfaSF8X/XVm2kwQhh0/0WCTVcB
	 /oQM0dk8IBjExNS0CtKrwLKpQ2g5O80mdbEfl6t5ZRtxLC2nmhzHukK0VhbRBfYraz
	 2kPlFqJt+7Tzg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 28 Apr 2025 17:44:02 +0200
Subject: [PATCH bpf-next v3 1/2] bpf: Allow XDP dev-bound programs to
 perform XDP_REDIRECT into maps
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-xdp-prog-bound-fix-v3-1-c9e9ba3300c7@kernel.org>
References: <20250428-xdp-prog-bound-fix-v3-0-c9e9ba3300c7@kernel.org>
In-Reply-To: <20250428-xdp-prog-bound-fix-v3-0-c9e9ba3300c7@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In the current implementation if the program is dev-bound to a specific
device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
or CPUMAP even if the program is running in the driver NAPI context and
it is not attached to any map entry. This seems in contrast with the
explanation available in bpf_prog_map_compatible routine.
Fix the issue introducing __bpf_prog_map_compatible utility routine in
order to avoid bpf_prog_is_dev_bound() check running bpf_check_tail_call()
at program load time (bpf_prog_select_runtime()).
Continue forbidding to attach a dev-bound program to XDP maps
(BPF_MAP_TYPE_PROG_ARRAY, BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_CPUMAP).

Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 kernel/bpf/core.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ba6b6118cf504041278d05417c4212d57be6fca0..a3e571688421196c3ceaed62b3b59b62a0258a8c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2358,8 +2358,8 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 	return 0;
 }
 
-bool bpf_prog_map_compatible(struct bpf_map *map,
-			     const struct bpf_prog *fp)
+static bool __bpf_prog_map_compatible(struct bpf_map *map,
+				      const struct bpf_prog *fp)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	bool ret;
@@ -2368,14 +2368,6 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 	if (fp->kprobe_override)
 		return false;
 
-	/* XDP programs inserted into maps are not guaranteed to run on
-	 * a particular netdev (and can run outside driver context entirely
-	 * in the case of devmap and cpumap). Until device checks
-	 * are implemented, prohibit adding dev-bound programs to program maps.
-	 */
-	if (bpf_prog_is_dev_bound(aux))
-		return false;
-
 	spin_lock(&map->owner.lock);
 	if (!map->owner.type) {
 		/* There's no owner yet where we could check for
@@ -2409,6 +2401,19 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 	return ret;
 }
 
+bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp)
+{
+	/* XDP programs inserted into maps are not guaranteed to run on
+	 * a particular netdev (and can run outside driver context entirely
+	 * in the case of devmap and cpumap). Until device checks
+	 * are implemented, prohibit adding dev-bound programs to program maps.
+	 */
+	if (bpf_prog_is_dev_bound(fp->aux))
+		return false;
+
+	return __bpf_prog_map_compatible(map, fp);
+}
+
 static int bpf_check_tail_call(const struct bpf_prog *fp)
 {
 	struct bpf_prog_aux *aux = fp->aux;
@@ -2421,7 +2426,7 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
 		if (!map_type_contains_progs(map))
 			continue;
 
-		if (!bpf_prog_map_compatible(map, fp)) {
+		if (!__bpf_prog_map_compatible(map, fp)) {
 			ret = -EINVAL;
 			goto out;
 		}

-- 
2.49.0



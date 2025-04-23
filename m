Return-Path: <linux-kselftest+bounces-31437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E419CA996F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 19:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC7D1B86A0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B328CF65;
	Wed, 23 Apr 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDumM00l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA40628C5DC;
	Wed, 23 Apr 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430291; cv=none; b=RMtYPtNVftXpO+U+Kd+6QUoBjLbiuKupE6LGoIFZgXxAVsQHfD4k3dd330OBPVBChqIKFbqOTmWT7JH+H5ojUNqoqhlZRPz6MdG4SBc02V9LHeldt6GtC+BHwu6Mz+qlVpPhJ6zwGQalgttPI3suo+SXnTYRgQS2lKgpDANRfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430291; c=relaxed/simple;
	bh=j5g+IJdeTi7oaYBHai96B2vtfM0fZCVe05C2H8BF/fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WEP4AEZSMaDXmCH6dyCwG4AmZ1dEgwJFtVVaHD+ijDI6UpLHUqRc6kQjY4u0AQYFDPwWAZ+3LaGdnKGbq/KAA8aEoqtIMvSl+B0ElPyriZTkTNhQb23qP4GzKF3M4EqlENJacC5UxDv5F5NOQqCI4ipCnQTYs+I9GmTv2ztcWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDumM00l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4FFC4CEE2;
	Wed, 23 Apr 2025 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745430291;
	bh=j5g+IJdeTi7oaYBHai96B2vtfM0fZCVe05C2H8BF/fg=;
	h=From:Date:Subject:To:Cc:From;
	b=FDumM00lx6hE0D1ZEoR579wKaSTyFaerBEWavQIW+6EC0orA+bMwQEWLa5lTVkvyF
	 cBwmyfKcnchiXgLV9+qxQBw/zwuAThrn1lpy3uuoCUoPyTDs/YhsEfkZR3AJzbIvbS
	 oR3FQmOLv6+8Yb5soh/j/bqDws/p2Lok66R314N8z3ZAB75MI/5ZBmDOZ2cSTSVtE+
	 3g15mR58HxPuQApZQnrIEJ82QOGYGU02qwBDMbdOJPYcrzQd5SK17KuIpnuwPze34R
	 OyLjOOo8KpeZ6qZx+ak/UCLdESi/f43VetEl1WXllPuiuxft7GUsZp2beG1CsOJMbT
	 thhmgRT91QXww==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 23 Apr 2025 19:44:21 +0200
Subject: [PATCH bpf-next v2] bpf: Allow XDP dev-bound programs to perform
 XDP_REDIRECT into maps
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPQmCWgC/32NQQ7CIBBFr9LM2jFAW1NdeQ/TBbUDJRogg5Kah
 ruLPYDL95L//gaJ2FGCS7MBU3bJBV9BHRq4L9pbQjdXBiVULzqlcJ0jRg4Wp/D2Mxq34tm0wrQ
 k205rqMPIVPUevY2VF5degT/7R5Y/+zeXJUoUUz9Io+VwMnR9EHt6HgNbGEspXzOx6fW1AAAA
X-Change-ID: 20250422-xdp-prog-bound-fix-9f30f3e134aa
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
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Introduce __bpf_prog_map_compatible() utility routine in order to skip
  bpf_prog_is_dev_bound check in bpf_check_tail_call()
- Extend xdp_metadata selftest
- Link to v1: https://lore.kernel.org/r/20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org
---
 kernel/bpf/core.c                                  | 27 +++++++++++++---------
 .../selftests/bpf/prog_tests/xdp_metadata.c        | 22 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/xdp_metadata.c   | 13 +++++++++++
 3 files changed, 50 insertions(+), 12 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 3d47878ef6bfb55c236dc9df2c100fcc449f8de3..19f92affc2daa23fdd869554e7a0475b86350a4f 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -351,9 +351,10 @@ void test_xdp_metadata(void)
 	struct xdp_metadata2 *bpf_obj2 = NULL;
 	struct xdp_metadata *bpf_obj = NULL;
 	struct bpf_program *new_prog, *prog;
+	struct bpf_devmap_val devmap_e = {};
+	struct bpf_map *prog_arr, *devmap;
 	struct nstoken *tok = NULL;
 	__u32 queue_id = QUEUE_ID;
-	struct bpf_map *prog_arr;
 	struct xsk tx_xsk = {};
 	struct xsk rx_xsk = {};
 	__u32 val, key = 0;
@@ -409,6 +410,13 @@ void test_xdp_metadata(void)
 	bpf_program__set_ifindex(prog, rx_ifindex);
 	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
 
+	/* Make sure we can load a dev-bound program that performs
+	 * XDP_REDIRECT into a devmap.
+	 */
+	new_prog = bpf_object__find_program_by_name(bpf_obj->obj, "redirect");
+	bpf_program__set_ifindex(new_prog, rx_ifindex);
+	bpf_program__set_flags(new_prog, BPF_F_XDP_DEV_BOUND_ONLY);
+
 	if (!ASSERT_OK(xdp_metadata__load(bpf_obj), "load skeleton"))
 		goto out;
 
@@ -423,6 +431,18 @@ void test_xdp_metadata(void)
 			"update prog_arr"))
 		goto out;
 
+	/* Make sure we can't add dev-bound programs to devmaps. */
+	devmap = bpf_object__find_map_by_name(bpf_obj->obj, "dev_map");
+	if (!ASSERT_OK_PTR(devmap, "no dev_map found"))
+		goto out;
+
+	devmap_e.bpf_prog.fd = val;
+	if (!ASSERT_ERR(bpf_map__update_elem(devmap, &key, sizeof(key),
+					     &devmap_e, sizeof(devmap_e),
+					     BPF_ANY),
+			"update dev_map"))
+		goto out;
+
 	/* Attach BPF program to RX interface. */
 
 	ret = bpf_xdp_attach(rx_ifindex,
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 31ca229bb3c0f182483334a4ab0bd204acae20f3..09bb8a038d528cf26c5b314cc927915ac2796bf0 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -19,6 +19,13 @@ struct {
 	__type(value, __u32);
 } prog_arr SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_devmap_val));
+	__uint(max_entries, 1);
+} dev_map SEC(".maps");
+
 extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
 					 __u64 *timestamp) __ksym;
 extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
@@ -95,4 +102,10 @@ int rx(struct xdp_md *ctx)
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
 
+SEC("xdp")
+int redirect(struct xdp_md *ctx)
+{
+	return bpf_redirect_map(&dev_map, ctx->rx_queue_index, XDP_PASS);
+}
+
 char _license[] SEC("license") = "GPL";

---
base-commit: 5cffad0a5c8f0cc53ce9fe7cff7bc67c3a97c406
change-id: 20250422-xdp-prog-bound-fix-9f30f3e134aa

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



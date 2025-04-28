Return-Path: <linux-kselftest+bounces-31787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCE0A9F4D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 17:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E5517DEA7
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC7827A136;
	Mon, 28 Apr 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7lHAFJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FACC14A62B;
	Mon, 28 Apr 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855070; cv=none; b=T+SDAi0NNWOD/02FK45niWuoVz/xz7o70QR4cR6ecPEspaN9o08DN64F169LI5O4ogywNs4loCWl8uIzRluNgB6iUOnxK/zwkGrRhmeqiXlbpz1WZFRvuZQCLRypg+nlig+ARCD3KYBi2gsQ3XkaV5GiZzdzbW1KZINUIvq7L4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855070; c=relaxed/simple;
	bh=kQV9pCkeqJoWytEeFKMkDgD4tbL2ML85RN8n8JEdptg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AuL8Yup1kBBUBjxcaq9ExZzrxkbbzC5cf1B0lNoQwq48VDr/qckao2Gl77KujkFg4mUe/sXmVCBF0T/ikJPku7n1K6gS4jd6dCAAl3SmXoTQL8Ep/qqzJjziYUAlyMtlnvHI0BWy0CUE+t2rjYIGuUA7RzFsMYdZV5rqwwAN5iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7lHAFJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70363C4CEE4;
	Mon, 28 Apr 2025 15:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745855070;
	bh=kQV9pCkeqJoWytEeFKMkDgD4tbL2ML85RN8n8JEdptg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U7lHAFJCgCOpS3U4G0ebvWKla0FHOElBUtwXA0oTMYKVsWfxAPKGPh474TIZQKiGK
	 taL6E7vrzLLP8yD8xMDTRenW9yZk4lvkKg/kxYYHFZUd36JIn+uuoEzkj5tmlTCDJX
	 UT2WZhRuuZ9vtfhxjdz0e554B1DTgcVTbvMtJxyMo0GIohLz4xZcsOQydoQidJHIYP
	 NoqjLPhxNofesbdg1OpqWWVpto5PMQO8FEwgp7oK89GQo/WR2kvF8oTpnPX6rW7Ohv
	 DAK0VQwibOzY1s4x+2NiVtmgkt9FHwKhHriZvfGKlRayiMx3j81kFrEcGKPt+pK9X6
	 6uTZpJtqgd3uw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 28 Apr 2025 17:44:03 +0200
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: xdp_metadata: check
 XDP_REDIRCT support for dev-bound progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-xdp-prog-bound-fix-v3-2-c9e9ba3300c7@kernel.org>
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

Improve xdp_metadata bpf selftest in order to check it is possible for a
XDP dev-bound program to perform XDP_REDIRECT into a DEVMAP but it is still
not allowed to attach a XDP dev-bound program to a DEVMAP entry.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c        | 22 +++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/xdp_metadata.c   | 13 +++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

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

-- 
2.49.0



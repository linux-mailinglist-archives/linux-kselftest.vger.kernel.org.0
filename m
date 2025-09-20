Return-Path: <linux-kselftest+bounces-41997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82A1B8C80A
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 14:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E7A16FBD8
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292D303A04;
	Sat, 20 Sep 2025 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbuL1oEo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA244303A01;
	Sat, 20 Sep 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370890; cv=none; b=qdg7HmyXGLAU/xHpRcQjYH7nExaeFuxaC8kb5nzwXtFuBrWhz6hbIbSWTUKrWSVEySi0iCq6YeZDCIFyLwxbFLB0eeY8qhMjBC0B9iRtJoYp4BffSVzvLUoeKrFtiHMhD9qsQIRzeQGbcIKlTaLd+ntuY4jbCa4Crb+0W3E/gdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370890; c=relaxed/simple;
	bh=CMgxYi+GSs67pYTVXIfXO6OSEXKJBkmharSS8EGYHbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f7+aUM0yOb4j3wUnoU2R3rnESPdFagJ0flU9Pha3pO90IVrg75HazCNS2+yMV3mjReZyHqMxMUpEIOpkAORBPs0H8Cx6g5pPC8ERVd/x54t7idCXp4wCAhtC/MK58fblgUh9j6D31G83BA+wLZO8Omyqhd2zVfjWYcgDjq1LMvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbuL1oEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DA1C4CEF7;
	Sat, 20 Sep 2025 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758370889;
	bh=CMgxYi+GSs67pYTVXIfXO6OSEXKJBkmharSS8EGYHbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DbuL1oEoS0VF4Q2K7MdRyr5RtromO1PcwESX9QbysuJzXDAQNievByyNfM4d8+LOG
	 A/kv4tD/HJGQPPqQth7FTIDs87kyygS1iuLV6Hil40pocCR9vqN/niUS8ePU8XO+T9
	 yq0fYftyII7vmcnUBXMdJK20LO7ToswgkmeLjqkMvAG6fiviRMBnITQTPUyf59zMtm
	 RhfaA2OMeciam/3/lZr3i3NI0RnuxJTgrZbqwcM8poXUmH94T12J61MaUeWOx8rXGa
	 nqBepUMQ1+e0NMNrw09IsGjs9kX4DDVBMCJUQCjhwBNWax0nQeDcrWo8+of9eeAszP
	 FoZ3kPEogCp1A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 20 Sep 2025 14:20:31 +0200
Subject: [PATCH RFC bpf-next 5/6] selftests/bpf: Add selftest support for
 bpf_xdp_metadata_rx_checksum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-xdp-meta-rxcksum-v1-5-35e76a8a84e7@kernel.org>
References: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
In-Reply-To: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce support to xdp_metadata selftest for bpf_xdp_metadata_rx_checksum
kfunc.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 7 +++++++
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 1 +
 tools/testing/selftests/bpf/xdp_metadata.h            | 9 +++++++++
 3 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 19f92affc2daa23fdd869554e7a0475b86350a4f..650f87c2bac03841606ceef25eec718b5dcf766f 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -258,6 +258,7 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
 
 static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 {
+	__u8 ip_summed = sent_from_af_xdp ? CHECKSUM_NONE : CHECKSUM_PARTIAL;
 	const struct xdp_desc *rx_desc;
 	struct pollfd fds = {};
 	struct xdp_meta *meta;
@@ -310,6 +311,12 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
 		return -1;
 
+	if (!ASSERT_EQ(meta->ip_summed, ip_summed, "rx_ip_summed"))
+		return -1;
+
+	if (!ASSERT_EQ(meta->cksum_meta, 0, "rx_cksum_meta"))
+		return -1;
+
 	if (!sent_from_af_xdp) {
 		if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
 			return -1;
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 09bb8a038d528cf26c5b314cc927915ac2796bf0..ef6a5584a1876a3c47440f21dca927ec783469dc 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -98,6 +98,7 @@ int rx(struct xdp_md *ctx)
 	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
 	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
 				     &meta->rx_vlan_tci);
+	bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed, &meta->cksum_meta);
 
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 87318ad1117a1d677af121f11778178532e2a562..f0ef17b328866206b1e63f7d751abeaa78e90932 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -30,6 +30,11 @@ enum xdp_meta_field {
 	XDP_META_FIELD_VLAN_TAG	= BIT(2),
 };
 
+#define CHECKSUM_NONE		0
+#define CHECKSUM_UNNECESSARY	1
+#define CHECKSUM_COMPLETE	2
+#define CHECKSUM_PARTIAL	3
+
 struct xdp_meta {
 	union {
 		__u64 rx_timestamp;
@@ -48,5 +53,9 @@ struct xdp_meta {
 		};
 		__s32 rx_vlan_tag_err;
 	};
+	struct {
+		__u8 ip_summed;
+		__u32 cksum_meta;
+	};
 	enum xdp_meta_field hint_valid;
 };

-- 
2.51.0



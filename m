Return-Path: <linux-kselftest+bounces-41998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CC6B8C80D
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 14:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5B8586EED
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 12:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68C3303A2A;
	Sat, 20 Sep 2025 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG+h6s1R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3C3016FA;
	Sat, 20 Sep 2025 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370892; cv=none; b=l15leEMf+QYH5+/ccOFJJ606keKf+U4ZAFxc4CxqgY7uMMSpIRPAIkoz1t8z1Sq6lcL3tiwYJI0JcJN74hFhwdBX6o9rWT5RvxMMB71bQ0Od5eX2z2s+qwJ2wmMO7Vpj0vdH9+dYsJNon6xpAcMcsK4nAe22IPiCweTkh0Vjyc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370892; c=relaxed/simple;
	bh=/3PcZtglAS6v94LhLUzpf56x/49epFwaN6NzshGiP3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QBMzJKU772tYTgSb2piafA6fKjbUI7+0f2mstmhWZJWmASFBN+WpcZA0GbbzLlSHWKuA74h/SmlXOsbSoVLTkyCz4AT4k5CTzNiswRqdhNLmsLCtTRYrjjKB73IPggkh9fIRMAA21wuKEWiDA3zTalpytvLjKsD0fkBfISaM+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG+h6s1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2CCC4CEEB;
	Sat, 20 Sep 2025 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758370892;
	bh=/3PcZtglAS6v94LhLUzpf56x/49epFwaN6NzshGiP3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LG+h6s1RMLe9Z2PLjFs9JrlGsLSc2PglV0gA+YuH2zbbTGKRUtIEiBB9J3I6+EiXr
	 h6x/Cg8HvCRZ08VYSPCaTvkV7U4UjhpBVqWnX6jBieLcgipJEqgkVTM3woTgrZalUv
	 wN0RFMhQ/ryRjsQLnI/k7j4EDt4Azx34rI8WJTQw4R6n9HbWfpwR8XiCQfnrCoxWmx
	 vV7H8AU13/RCtcdNbwVGK9saivT3eO/0o9w85dLZsjQtiSsQuYy0Wc8c8QBFeuBbfM
	 0jNt0TAsXrI8TBAEKK2KWLq7G9tUA+eUGJScflbC/jH0yb3F5bTKn16xbos5oO1+ip
	 7mHVOqN3D1D+A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 20 Sep 2025 14:20:32 +0200
Subject: [PATCH RFC bpf-next 6/6] selftests/bpf: Add
 bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-xdp-meta-rxcksum-v1-6-35e76a8a84e7@kernel.org>
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

Introduce the capability to dump HW rx checksum in xdp_hw_metadat
program via bpf_xdp_metadata_rx_checksum() kfunc.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |  7 ++++++
 tools/testing/selftests/bpf/xdp_hw_metadata.c      | 27 ++++++++++++++++++++++
 tools/testing/selftests/bpf/xdp_metadata.h         | 10 +++++---
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index 330ece2eabdb454da2bb2cbd297d2b2dd6efddc0..dc62d572e3ac6e2ef173b330da515757ea543415 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -110,6 +110,13 @@ int rx(struct xdp_md *ctx)
 	else
 		meta->hint_valid |= XDP_META_FIELD_VLAN_TAG;
 
+	err = bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed,
+					   &meta->cksum_meta);
+	if (err)
+		meta->rx_cksum_err = err;
+	else
+		meta->hint_valid |= XDP_META_FIELD_CHECKSUM;
+
 	__sync_add_and_fetch(&pkts_redir, 1);
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 3d8de0d4c96a7afdf5f60b2fdff73c22b876ce54..5e38aa1b565735c2e55fcf2f7b9e672db1348233 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -219,6 +219,28 @@ static void print_vlan_tci(__u16 tag)
 	printf("PCP=%u, DEI=%d, VID=0x%X\n", pcp, dei, vlan_id);
 }
 
+static void print_rx_cksum(__u8 ip_summed, __u32 cksum_meta)
+{
+	const char *cksum = "CHECKSUM_NONE";
+
+	switch (ip_summed) {
+	case CHECKSUM_UNNECESSARY:
+		cksum = "CHECKSUM_UNNECESSARY";
+		break;
+	case CHECKSUM_COMPLETE:
+		cksum = "CHECKSUM_COMPLETE";
+		break;
+	case CHECKSUM_PARTIAL:
+		cksum = "CHECKSUM_PARTIAL";
+		break;
+	case CHECKSUM_NONE:
+	default:
+		break;
+	}
+
+	printf("rx-cksum: %s, csum_meta=0x%x\n", cksum, cksum_meta);
+}
+
 static void verify_xdp_metadata(void *data, clockid_t clock_id)
 {
 	struct xdp_meta *meta;
@@ -254,6 +276,11 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
 		printf("No rx_vlan_tci or rx_vlan_proto, err=%d\n",
 		       meta->rx_vlan_tag_err);
 	}
+
+	if (meta->hint_valid & XDP_META_FIELD_CHECKSUM)
+		print_rx_cksum(meta->ip_summed, meta->cksum_meta);
+	else
+		printf("No rx_chsum, err=%d\n", meta->rx_cksum_err);
 }
 
 static void verify_skb_metadata(int fd)
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index f0ef17b328866206b1e63f7d751abeaa78e90932..0fd5e7172fe891275b3b1eb69c51a93a60ae353e 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -28,6 +28,7 @@ enum xdp_meta_field {
 	XDP_META_FIELD_TS	= BIT(0),
 	XDP_META_FIELD_RSS	= BIT(1),
 	XDP_META_FIELD_VLAN_TAG	= BIT(2),
+	XDP_META_FIELD_CHECKSUM = BIT(3),
 };
 
 #define CHECKSUM_NONE		0
@@ -53,9 +54,12 @@ struct xdp_meta {
 		};
 		__s32 rx_vlan_tag_err;
 	};
-	struct {
-		__u8 ip_summed;
-		__u32 cksum_meta;
+	union {
+		struct {
+			__u8 ip_summed;
+			__u32 cksum_meta;
+		};
+		__s32 rx_cksum_err;
 	};
 	enum xdp_meta_field hint_valid;
 };

-- 
2.51.0



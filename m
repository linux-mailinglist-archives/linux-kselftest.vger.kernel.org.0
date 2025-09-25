Return-Path: <linux-kselftest+bounces-42284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB51B9E64C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 11:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0225B3A7534
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9970F2F658D;
	Thu, 25 Sep 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3kyCq8W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0842F28F5;
	Thu, 25 Sep 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792662; cv=none; b=QNevxldnUeoF8/rCRZZZTyofN58QvqrvAvBvSe+hkSPWJ2g6tynFuftXpr5Bsfdf+KssYcNvc4TNlFLxfcmTQBH08QeBfUeYKM0hcR7/ZSjXZ3QOsUSM7Nc5rVhjgPAY4I/sKEAWRhgDJ+fsQZV1znvUCxo5gCVg/lCmk6OeL84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792662; c=relaxed/simple;
	bh=A/kw6ABjlORAJ4bHqHYqQaWGu/ghxT9gXYNn89u1s3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YY1Md8UHRnX2VL/4ESlZRtXS5PuDUBrmj3qTPwezs0dnPNxprh7ULnOysgmsCeCOjb1fiOfvpO5k0HttLMTwD5at+IiUT8HMmJVko03SA7kmDVt5E8+qm4+sDvwZu93NakwNLAc4c907SEl4Bida1yeA074GAcMyma1JIuTycBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3kyCq8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AF1C113D0;
	Thu, 25 Sep 2025 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758792662;
	bh=A/kw6ABjlORAJ4bHqHYqQaWGu/ghxT9gXYNn89u1s3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S3kyCq8WWF6rc43eSZrUktddD358zsDnqLp9sbZz4t5UN0utI3AOyhQovZtaekKHa
	 BxIVJJTeuIwY/RtEunatUlYdpVRL6ZeCcpEbVOA26zlVXbu5rJ9bSK8+3l5QQoMWL7
	 JHr+M+5YiEGs+c1A8OiZwHwJDKcpHr196YJRxS489J3mSxI0U8p0l+0qn0bDNRevVb
	 6vp3oBczFH3GJMo+1okXeKKFKglqyNt68xo+TVZ5ztqrrqQoqvEyA3cX6ZQsc7TMlJ
	 /DMd4JObfpPwabqpbQBKW7Z4xAZTiWvqYlNqHvfqU+SlPGhb8CQtiYbWn+mGDIgFuw
	 hBIcbDPZ0G1JQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 25 Sep 2025 11:30:37 +0200
Subject: [PATCH RFC bpf-next v2 5/5] selftests/bpf: Add
 bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-bpf-xdp-meta-rxcksum-v2-5-6b3fe987ce91@kernel.org>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
In-Reply-To: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
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
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
index 3d8de0d4c96a7afdf5f60b2fdff73c22b876ce54..c8c25ef383b1fe5613540b09a52bcdc264e316b4 100644
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
+	case XDP_CHECKSUM_UNNECESSARY:
+		cksum = "CHECKSUM_UNNECESSARY";
+		break;
+	case XDP_CHECKSUM_COMPLETE:
+		cksum = "CHECKSUM_COMPLETE";
+		break;
+	case XDP_CHECKSUM_PARTIAL:
+		cksum = "CHECKSUM_PARTIAL";
+		break;
+	case XDP_CHECKSUM_NONE:
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
index a16f71488a34e6df23fec6dd7dde7b7989774618..b7ab112da8032405ec0e3d699499f4a9c5cb91dc 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -28,6 +28,7 @@ enum xdp_meta_field {
 	XDP_META_FIELD_TS	= BIT(0),
 	XDP_META_FIELD_RSS	= BIT(1),
 	XDP_META_FIELD_VLAN_TAG	= BIT(2),
+	XDP_META_FIELD_CHECKSUM = BIT(3),
 };
 
 #define XDP_CHECKSUM_NONE		0
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



Return-Path: <linux-kselftest+bounces-41994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D860B8C7E3
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 14:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEE91BC52E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3A3019C6;
	Sat, 20 Sep 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaroodIS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EB9301466;
	Sat, 20 Sep 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370883; cv=none; b=WdDLCMBCsfx8TZstOuSLQmjsVy0mCiYUZ3jGEoGMCXO5iiRPD+c4MB3WYHTmjC+3kli1oP0+BVIuhZjp7coaMMwdnCRHmMhdN9ybHm7GCupPyLl44dScRQSrAKtCxLDLWwKQLfBMCKhOXISWBcvDgquwKaOkP4r3mv90WRnpqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370883; c=relaxed/simple;
	bh=cKLYVjE3ueLX0rrhQcUCi36nhRNT2ORE5yStyWdO9CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SFnwCdGiVoQfNVGYgL7ve74bl0xSIDu/QAKog05NLFwGNCEFFokRA9+L9nRYqrl8/t2iqHq1O9/5XmwJmmJkHJqm1NoJo8ZxHafnEfrBbQafubbgf2QOJLylmYyTx4bm1g30drnYCBtmRaQGIcTUDFZoy7AvnJ4+pqNJF1hZKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaroodIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A4FC4CEF7;
	Sat, 20 Sep 2025 12:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758370881;
	bh=cKLYVjE3ueLX0rrhQcUCi36nhRNT2ORE5yStyWdO9CA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OaroodISuKKmGtIcZTNuptjPgwW14oyz1rvxbp+oahttBedI3IrJWBxRZ1oKAX3hf
	 dvxScvylrmqTh0n68amjh7xuy4uH6nAUcGwVTa3oqLgX73Lkyt5gYHPGONH2QQ5oBB
	 KpRzGaCjoA5vH5j8pIF3zWTrNvvdG6oFp0fI1Rt4WC6fbG+0vcq+MnAbZ1tayPqCuy
	 ilAVtqNayrvB2cEoFVZrVo9a8o7qrVC6JhumgxJ1shJKsvgqBHlB8MdlG7s/X2WlcF
	 KYhV+R3zbXajs5a4xxup4UkSQqMgCaGWmMxh9GqET/czfGK0ou8Mi0qyoV/4qBpB6i
	 0a6vxSMn4VXKw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 20 Sep 2025 14:20:28 +0200
Subject: [PATCH RFC bpf-next 2/6] net: xdp: Add xmo_rx_checksum callback
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-xdp-meta-rxcksum-v1-2-35e76a8a84e7@kernel.org>
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

Introduce xmo_rx_checksum netdev callback in order allow the eBPF
program bounded to the device to retrieve the RX checksum result computed
by the hw NIC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/xdp.h |  6 ++++++
 net/core/xdp.c    | 29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 6fd294fa6841d59c3d7dc4475e09e731996566b0..481b39976ac8c8d4db2de39055c72ba8d0d511c3 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -581,6 +581,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
 			   bpf_xdp_metadata_rx_vlan_tag, \
 			   xmo_rx_vlan_tag) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
+			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
+			   bpf_xdp_metadata_rx_checksum, \
+			   xmo_rx_checksum)
 
 enum xdp_rx_metadata {
 #define XDP_METADATA_KFUNC(name, _, __, ___) name,
@@ -644,6 +648,8 @@ struct xdp_metadata_ops {
 			       enum xdp_rss_hash_type *rss_type);
 	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
 				   u16 *vlan_tci);
+	int	(*xmo_rx_checksum)(const struct xdp_md *ctx, u8 *ip_summed,
+				   u32 *cksum_meta);
 };
 
 #ifdef CONFIG_NET
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9100e160113a9a1e2cb88e7602e85c5f36a9f3b9..3edab2d5e5c7c2013b1ef98c949a83655eb94349 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -961,6 +961,35 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
+ * @ctx: XDP context pointer.
+ * @ip_summed: Return value pointer indicating checksum result.
+ * @cksum_meta: Return value pointer indicating checksum result metadata.
+ *
+ * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
+ * values are:
+ * ``CHECKSUM_NONE``
+ * ``CHECKSUM_UNNECESSARY``
+ * ``CHECKSUM_COMPLETE``
+ * ``CHECKSUM_PARTIAL``
+ *
+ * In case of success, ``cksum_meta`` contains the hw computed checksum value
+ * for ``CHECKSUM_COMPLETE`` or the ``csum_level`` for
+ * ``CHECKSUM_UNNECESSARY``. It is set to 0 for ``CHECKSUM_NONE`` and
+ * ``CHECKSUM_PARTIAL``.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
+ * * ``-ENODATA``    : means no RX-timestamp available for this frame
+ */
+__bpf_kfunc int bpf_xdp_metadata_rx_checksum(const struct xdp_md *ctx,
+					     u8 *ip_summed, u32 *cksum_meta)
+{
+	return -EOPNOTSUPP;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_metadata_kfunc_ids)

-- 
2.51.0



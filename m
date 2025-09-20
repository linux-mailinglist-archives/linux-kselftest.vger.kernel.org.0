Return-Path: <linux-kselftest+bounces-41995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC290B8C7FB
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 14:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E26583420
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 12:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B24A302161;
	Sat, 20 Sep 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+oW7lzK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D405F301466;
	Sat, 20 Sep 2025 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370884; cv=none; b=eE+dSvNGNW7lVDNvGHj9ILx4PBCt8tWfr7ATxC8fGk8QZaqDpsNHIONLNpgSj1bxLEX101B7R/he4jq3xRcgvrL8tdLEqnply9NLQIJWATVvkIckoW1gKK2NpFpPOSqiM6sXPCM7iA3GzUex+aKIIujVqX5FC2kbqR1dII5c6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370884; c=relaxed/simple;
	bh=3CR7RjVcRyDsVXnHpze6aotTbagI9yFdEz/x13ifMtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4x7hDhYvcujpnTIwdFuFxN8+UitK1DCzjCq354uSM5UJqgDtXMPx9fdpTqKbo1wI4UwLSQ+OTZy68SuJ+w5U5QXJ/Uywzf/rPa6Ex3oX65VMkVnxBkwm+VI0HRG1PLyQYiUYsapHOpzjnxJZOK3SR5V0KpY3iSYZtBrqTx1MMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+oW7lzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95E5C4CEF9;
	Sat, 20 Sep 2025 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758370884;
	bh=3CR7RjVcRyDsVXnHpze6aotTbagI9yFdEz/x13ifMtw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L+oW7lzKy4BoamfewGWcvpKBmh/wVXSG6wbZEg56hLK7kitrSnVW2dNdSGk8HQ8/j
	 S1XdCpDDJOQxxTZork+03eR7rFPd63zZPbhjypOBUZlrPq1ZS6Vwz2IL9571imPRiu
	 uITfK8sXqJftbRPBkv+T5Dnu0Vj7d6AYFPt02I+dRWBc7rTdrkRR2S1efReNCcPWKb
	 jOt7jup9Et16XSReCjnA3bkQICffFtWUEvXo5rZ0ZO+fPKH57ZGGohQO+noiFOT5jM
	 KeYHb5UQ5DOl+xO4DJmO4btEnS8RBeG7uugw+bndkzOjZD4DE7tRoeJ/tFd70uopob
	 YcxzmVssEA5gg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 20 Sep 2025 14:20:29 +0200
Subject: [PATCH RFC bpf-next 3/6] veth: Add xmo_rx_checksum callback to
 veth driver
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-xdp-meta-rxcksum-v1-3-35e76a8a84e7@kernel.org>
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

Implement xmo_rx_checksum callback in veth driver to report RX checksum
result to the eBPF program bounded to the NIC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/veth.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3046142cb8e2658a30041129f8d298e5e0a5822..2a762cb132fd9fd90376965c65c4fedcc28a26c8 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1692,6 +1692,24 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return err;
 }
 
+static int veth_xdp_rx_checksum(const struct xdp_md *ctx, u8 *ip_summed,
+				u32 *cksum_meta)
+{
+	const struct veth_xdp_buff *_ctx = (void *)ctx;
+	const struct sk_buff *skb = _ctx->skb;
+
+	if (!skb)
+		return -ENODATA;
+
+	/* For locally generated packets ip_summed is set to
+	 * CHECKSUM_PARTIAL.
+	 */
+	*ip_summed = skb->ip_summed;
+	*cksum_meta = 0;
+
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1717,6 +1735,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_checksum		= veth_xdp_rx_checksum,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \

-- 
2.51.0



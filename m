Return-Path: <linux-kselftest+bounces-46153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25987C76C08
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D944C4E57FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B2E24BBEE;
	Fri, 21 Nov 2025 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NFN2YNTk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC92264A3
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684465; cv=none; b=Y2DI82QIrC2UFLicFnBqMoMy4I2/23inOozpWqF3hnlJVVjLLd/7WJizQuJRAI4YjEFvhOs+AGG39mnjKHQFDPpqiN5ZwzxSM/oR8FjsYR0CNksyp4Ye59dr0LYjuDhyPbxOFX3RY1Vxf1aLcR/vORF1Eerx8NTpsBE1MZN7hIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684465; c=relaxed/simple;
	bh=msjk5sVRfJJVEv7jp4vPwvIBV7Jve7JsQKiAFthUmz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdfuAPHE8ich1SVrcqkbxRwznhM+b4IV5h9A7R/2MtGC3hN93nSe5cjderQZHBss+m5u92jOn51ZTQNOHcHc+Az9Kk04HmWl9PmY2G5xidUghyk+Xd9LIsSuEMLiFAp3bOv/m8OGu49dyB4T9FJKtAyOtNUtWbUU+ZNQviAKUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NFN2YNTk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so13123555e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684461; x=1764289261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DxzAV5XFMeTXilqnle38GH5G1yr0HP3sCB5qb7nS/4=;
        b=NFN2YNTk2MqUxnTS10VS6RwIwNnnDCj6M3M0AnZFlv+ubwHR6fWeJ2R1K1KSiWdrED
         JTqRHnn+SzhbRsxxt0Zz+Z6qagTmqfBE5Ja86vXBS7G/TWeoEsXt9VF+jZzJgGWckeWw
         RiSz0lDefEwnQSIUBx5WXE2G+AdRhCaxRDhrpoz6IOqeX333fM1hMQrs0zSML6suACv7
         /uRgvmIv+0g5GUbk29gD5NV5b6ZN71q8Q2kge/7ZlAigwvQjdvQ5h5maiQBQXIDSXBcF
         a+htzWageuAnr7g3jEA8LLEdFCmJoR68Xj9V5lKTW/1ANjsmKTeU1ND7UqnJ49IEdK0s
         w8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684461; x=1764289261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/DxzAV5XFMeTXilqnle38GH5G1yr0HP3sCB5qb7nS/4=;
        b=Whs62Xhbb8UR2tOVm5L4OpSecchg7nqavS/qR6vrm/iCOznDqnlP4VRHdZaYw9Q7rz
         XgcMM8o1q6+VEgv8EDWPqlJdUwbkEtCM+8xZYZwYLLY2tGEPFgMhbgDBA5NkLn7uL/L2
         4jRLzg1nlaAb+DKpCJwJv2BpMXuWadOq0eTrTVHjbVwKFEYv2GciO/VCJXohLyjiTpAY
         6zMw7c9bKyA2ukeYhAavulDBJioe2xO5ofzMAijHRaBScMulmAH+5JA5p84FetHSZExa
         cMsS1RtcKVfOh2NKxzkWJiOWxsOCYYImT1MynA1aG63Rbx9AB9EvNNk60jie4d7fvLgw
         lnFg==
X-Forwarded-Encrypted: i=1; AJvYcCW9BH0XpA0t731JbG6RoIRIgzpJ5W2tvdP0Z3YPyUcKP1QCfOidDs4u18QNmfvCNiSxS6bRz65Kp03Cb3A/W4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjR/pPdmq2A2iOol3eFZ0B+AiAWQwLjvOLS7qmRFi8lwYwyv0i
	5rb2nMKZYg4ndaPQJXEPyyfdjqgfNMi6PiU1EvqWTcdIhmEeUAmNdjubVrraSly3E0/Ysg9rPHX
	Lt+qu7i1jYtfiY8oHj6HnuYq6Tc58ue09uDLfeCoU1tnI9+Da43Zpx9kcQNv7rpE=
X-Gm-Gg: ASbGncuLzRcg2APttSsoEwSF9U818x2d4r0RHdifPBO/6kKCce+xjVXhR8+PHwRYSSU
	QdWS44fVf8ZKWVEswcWwlgis1Kw2DuFLsarHQb4JqF8q/9PourAp/jUUxv0/D05nvBL4ERqaZ3G
	C1cW1s1zS1IYfjlAdUdEVRxT5j0Ml8ciu+Xde7uqJqVHdPlK04gxmzdWx7qTZxl/PdAPG7y2CtZ
	a/L0Q4WGs+YZVFE4kgupNT8KuroSaZpOrhy7LtNmwgKF+foghe1JlnotJJ5mv3J/35DFMPw1BWR
	PlepX0vdoMsuYdssT4T1F85AR80dxvObubUIPoWCMgFSrQSd/1og6aORHpyAD+pqzWmb3a3xWei
	xUfZjse7o4dOMmNs2Gb42R5iLHSpznqLYAI32dPfp4Tj1XfaqXfhWcNaGU18GtFhsfKkV1tmvy4
	ej3bjMYdggMWhtCZrmFZqnsbG9
X-Google-Smtp-Source: AGHT+IHhHYiTnRp718+7i2R8PsfGHmLTVCnVBzx5KdfJvbRc3AcDnCrKJOVta7NVbSawVZer6NorNg==
X-Received: by 2002:a05:600c:4f15:b0:477:9fcf:3fe3 with SMTP id 5b1f17b1804b1-477c00eae92mr6555855e9.0.1763684460839;
        Thu, 20 Nov 2025 16:21:00 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:21:00 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 06/13] ovpn: add support for asymmetric peer IDs
Date: Fri, 21 Nov 2025 01:20:37 +0100
Message-ID: <20251121002044.16071-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

In order to support the multipeer architecture, upon connection setup
each side of a tunnel advertises a unique ID that the other side must
include in packets sent to them. Therefore when transmitting a packet, a
peer inserts the recipient's advertised ID for that specific tunnel into
the peer ID field. When receiving a packet, a peer expects to find its
own unique receive ID for that specific tunnel in the peer ID field.

Add support for the TX peer ID and embed it into transmitting packets.
If no TX peer ID is specified, fallback to using the same peer ID both
for RX and TX in order to be compatible with the non-multipeer compliant
peers.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/ovpn.yaml | 17 ++++++++++++++++-
 drivers/net/ovpn/crypto_aead.c        |  2 +-
 drivers/net/ovpn/netlink-gen.c        | 13 ++++++++++---
 drivers/net/ovpn/netlink-gen.h        |  6 +++---
 drivers/net/ovpn/netlink.c            | 14 ++++++++++++--
 drivers/net/ovpn/peer.c               |  4 ++++
 drivers/net/ovpn/peer.h               |  4 +++-
 include/uapi/linux/ovpn.h             |  1 +
 8 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index 0d0c028bf96f..b0c782e59a32 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -43,7 +43,8 @@ attribute-sets:
         type: u32
         doc: >-
           The unique ID of the peer in the device context. To be used to
-          identify peers during operations for a specific device
+          identify peers during operations for a specific device.
+          Also used to match packets received from this peer.
         checks:
           max: 0xFFFFFF
       -
@@ -160,6 +161,16 @@ attribute-sets:
         name: link-tx-packets
         type: uint
         doc: Number of packets transmitted at the transport level
+      -
+        name: tx-id
+        type: u32
+        doc: >-
+          The ID value used when transmitting packets to this peer. This
+          way outgoing packets can have a different ID than incoming ones.
+          Useful in multipeer-to-multipeer connections, where each peer
+          will advertise the tx-id to be used on the link.
+        checks:
+          max: 0xFFFFFF
   -
     name: peer-new-input
     subset-of: peer
@@ -188,6 +199,8 @@ attribute-sets:
         name: keepalive-interval
       -
         name: keepalive-timeout
+      -
+        name: tx-id
   -
     name: peer-set-input
     subset-of: peer
@@ -214,6 +227,8 @@ attribute-sets:
         name: keepalive-interval
       -
         name: keepalive-timeout
+      -
+        name: tx-id
   -
     name: peer-del-input
     subset-of: peer
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 2cca759feffa..cb6cdf8ec317 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -122,7 +122,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	memcpy(skb->data, iv, OVPN_NONCE_WIRE_SIZE);
 
 	/* add packet op as head of additional data */
-	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->id);
+	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->tx_id);
 	__skb_push(skb, OVPN_OPCODE_SIZE);
 	BUILD_BUG_ON(sizeof(op) != OVPN_OPCODE_SIZE);
 	*((__force __be32 *)skb->data) = htonl(op);
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index 14298188c5f1..81b2dd946f33 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -15,6 +15,10 @@ static const struct netlink_range_validation ovpn_a_peer_id_range = {
 	.max	= 16777215ULL,
 };
 
+static const struct netlink_range_validation ovpn_a_peer_tx_id_range = {
+	.max	= 16777215ULL,
+};
+
 static const struct netlink_range_validation ovpn_a_keyconf_peer_id_range = {
 	.max	= 16777215ULL,
 };
@@ -50,7 +54,7 @@ const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1] = {
 	[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(OVPN_NONCE_TAIL_SIZE),
 };
 
-const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1] = {
+const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
@@ -74,13 +78,14 @@ const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1] = {
 	[OVPN_A_PEER_LINK_TX_BYTES] = { .type = NLA_UINT, },
 	[OVPN_A_PEER_LINK_RX_PACKETS] = { .type = NLA_UINT, },
 	[OVPN_A_PEER_LINK_TX_PACKETS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
 };
 
 const struct nla_policy ovpn_peer_del_input_nl_policy[OVPN_A_PEER_ID + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 };
 
-const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIMEOUT + 1] = {
+const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
@@ -93,9 +98,10 @@ const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIME
 	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
 	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
 	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
 };
 
-const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIMEOUT + 1] = {
+const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
 	[OVPN_A_PEER_REMOTE_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_REMOTE_IPV6] = NLA_POLICY_EXACT_LEN(16),
@@ -107,6 +113,7 @@ const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIME
 	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
 	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
 	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
 };
 
 /* OVPN_CMD_PEER_NEW - do */
diff --git a/drivers/net/ovpn/netlink-gen.h b/drivers/net/ovpn/netlink-gen.h
index 220b5b2fdd4f..a66cc1268a43 100644
--- a/drivers/net/ovpn/netlink-gen.h
+++ b/drivers/net/ovpn/netlink-gen.h
@@ -17,10 +17,10 @@ extern const struct nla_policy ovpn_keyconf_del_input_nl_policy[OVPN_A_KEYCONF_S
 extern const struct nla_policy ovpn_keyconf_get_nl_policy[OVPN_A_KEYCONF_CIPHER_ALG + 1];
 extern const struct nla_policy ovpn_keyconf_swap_input_nl_policy[OVPN_A_KEYCONF_PEER_ID + 1];
 extern const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1];
-extern const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1];
+extern const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1];
 extern const struct nla_policy ovpn_peer_del_input_nl_policy[OVPN_A_PEER_ID + 1];
-extern const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIMEOUT + 1];
-extern const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_KEEPALIVE_TIMEOUT + 1];
+extern const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_TX_ID + 1];
+extern const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1];
 
 int ovpn_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info);
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 3db056f4cd0a..2a7a276850f8 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -305,6 +305,12 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 		dst_cache_reset(&peer->dst_cache);
 	}
 
+	/* In a multipeer-to-multipeer setup we may have asymmetric peer IDs,
+	 * that is peer->id might be different from peer->tx_id.
+	 */
+	if (attrs[OVPN_A_PEER_TX_ID])
+		peer->tx_id = nla_get_u32(attrs[OVPN_A_PEER_TX_ID]);
+
 	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
 		rehash = true;
 		peer->vpn_addrs.ipv4.s_addr =
@@ -326,8 +332,8 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 	}
 
 	netdev_dbg(peer->ovpn->dev,
-		   "modify peer id=%u endpoint=%pIScp VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
-		   peer->id, &ss,
+		   "modify peer id=%u tx_id=%u endpoint=%pIScp VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
+		   peer->id, peer->tx_id, &ss,
 		   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
 
 	spin_unlock_bh(&peer->lock);
@@ -373,6 +379,7 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+
 	peer = ovpn_peer_new(ovpn, peer_id);
 	if (IS_ERR(peer)) {
 		NL_SET_ERR_MSG_FMT_MOD(info->extack,
@@ -572,6 +579,9 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 	if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
 		goto err;
 
+	if (nla_put_u32(skb, OVPN_A_PEER_TX_ID, peer->tx_id))
+		goto err;
+
 	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY))
 		if (nla_put_in_addr(skb, OVPN_A_PEER_VPN_IPV4,
 				    peer->vpn_addrs.ipv4.s_addr))
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 9ad50f1ac2c3..f775ab768937 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -99,7 +99,11 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	if (!peer)
 		return ERR_PTR(-ENOMEM);
 
+	/* in the default case TX and RX IDs are the same.
+	 * the user may set a different TX ID via netlink
+	 */
 	peer->id = id;
+	peer->tx_id = id;
 	peer->ovpn = ovpn;
 
 	peer->vpn_addrs.ipv4.s_addr = htonl(INADDR_ANY);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index a1423f2b09e0..328401570cba 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -21,7 +21,8 @@
  * struct ovpn_peer - the main remote peer object
  * @ovpn: main openvpn instance this peer belongs to
  * @dev_tracker: reference tracker for associated dev
- * @id: unique identifier
+ * @id: unique identifier, used to match incoming packets
+ * @tx_id: identifier to be used in TX packets
  * @vpn_addrs: IP addresses assigned over the tunnel
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
@@ -64,6 +65,7 @@ struct ovpn_peer {
 	struct ovpn_priv *ovpn;
 	netdevice_tracker dev_tracker;
 	u32 id;
+	u32 tx_id;
 	struct {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
index b3c9ff0a6849..28cf97a86a18 100644
--- a/include/uapi/linux/ovpn.h
+++ b/include/uapi/linux/ovpn.h
@@ -54,6 +54,7 @@ enum {
 	OVPN_A_PEER_LINK_TX_BYTES,
 	OVPN_A_PEER_LINK_RX_PACKETS,
 	OVPN_A_PEER_LINK_TX_PACKETS,
+	OVPN_A_PEER_TX_ID,
 
 	__OVPN_A_PEER_MAX,
 	OVPN_A_PEER_MAX = (__OVPN_A_PEER_MAX - 1)
-- 
2.51.2



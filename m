Return-Path: <linux-kselftest+bounces-43154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8BABDC0FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 03:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783F842277C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 01:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699BA30BBB6;
	Wed, 15 Oct 2025 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAz1p/lU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157223090EF
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493203; cv=none; b=gx+Hz4EzppW2Aw9JiPS1JN0aSkzd/NtA37VcvR44gye/cGAIjTo4T1lTvSpb+0M4zNAYdPRMHIolxMS0j0LmdSL/rh6tTgGmaPHydGkV1qUeA6QLSzcSw3s+APyaCnAsoDzHZevEa46vpX6P3W6/uq8n9598e03JupzRghR8cws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493203; c=relaxed/simple;
	bh=0hy+oJrv/mQUZob3CzQtNjKXe+vVz0bQ1yHJdbwhbJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TvBaC5dybhv5ughuU2aWfu9ZhsY3j7LJoB4Ueh9N7usoIQuJNLv6wCdGcLCw4aqx6AhWHlhRwYADxS6d6HwP/Jz9Xmq5AzDHnzpBCfHbmVUC6AT3kbW7Xa/zaz+2eipkObXQ7TdDFAcb/cfFbvtyOI/pze6JTdBGgjnEjul9a68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAz1p/lU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-791c287c10dso5073109b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 18:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760493191; x=1761097991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fSNovR8GCQhp646i3Esw04KgILDfFypv9+ma98ObAU=;
        b=BAz1p/lU3gayLFTmYwf2n1kvW/jemUuRooVvx5HTXtSvEWPnh7j53+yfVvZNdIvfEA
         tlqHu6FZEs5y3LjFFk+5u2D2BGDalp0b1FdCNurUo1HRLAFAqZ0UPkUBlw79yun8f07Y
         4hZWA22Rv8zN8qpbQo2m9HfYl5sjTpjwSETi73DKLKLRoA+dL9NHD9gOBOe/9g9RNttf
         FS8jufN9Yw4sDMI4JJ03S8J9KYopNpiaw/tKDh1Cjbj4jB3Bt+vQU0J6+Os3OXKzLJwW
         U0tiZovVhiTfJqNkb8c1OjrAO60EgOmUuHI2TutyLWzPUSe8AB2hBQRWFsMxj/JPUJR4
         Xulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493191; x=1761097991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fSNovR8GCQhp646i3Esw04KgILDfFypv9+ma98ObAU=;
        b=UAIl5f+/My9g+5cYGVXDNjEAK7KOXb17LarVFxZ62a9CaLZ0FHBZcNRS6p1JV00NFe
         SkkB2mo7FqgK0QXvBTojhFrCtPJz8d8KeV1tGrlhsryF4rz0bEANilBjB/PP0S/hiCrw
         M97nx7i1OTHbY1//MrKJ4bIUifn203Xa8Y5G7X2ZrwAPf/D/R8UZK1thNMfYfQlp62E4
         cX70HEsXS6otlnBJUgs4lui7OWX8BVTgQuI8mO9wr4QrnZ2s9urvEbxtZfXR4XPv4eAs
         Qk0rEz5lzfLuMCrbt+2XIS+b62wcSiVds6m66aPUy6c73PjIW5gA9EPLnF3tG+iQ1Hae
         v10w==
X-Forwarded-Encrypted: i=1; AJvYcCWFVA63mzlG33sfZr7Kf9j5/SCEtY+196e8x8nNsb38iJlUbteQHR/InCzrf+wEGT37I1TMRAmoQwVFUyKuw10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7EQLKquqQIAHKlrF6tsPKw1OM4+RdtBJixuXP2eWHO6nkKmpF
	UAk17027tQ85JFfGnw77GslQhalzC+OcwqNxWGzkx6R090vNG39cL7Qs
X-Gm-Gg: ASbGncsNfunL3FJtEjhRvdWmZ9Bzah7iAM4xOUHNgcewynHhoxmvk2ut+A9mZ5l4Uym
	6vrzlL2Spyl1p4/jhoAvsQJ/EmRkEciW1XTs5sNUA2Q001qQCOx0euGqNj/z+0rChP7ST0SvGMw
	4+iCBt/UzQry15l0eOSLCC0HPSjk9iXwBjgK6CXADRMDN7ub37I45WDAk+NgtZZ44vKj7aH+2Xm
	sypeLD7w8sTW/kRv1q/4N69Uh5tOt9H4u+t7lGKsrLV2dDiHQWwuFabwvbQX+0PbtJUZEONhXio
	yzKfbHDIqifRZ/LXPTaGssbq+PFa/9PCPEperJ3epzSaW535CovCNZh/2rVYLczslg3EdYxY1dK
	CXdxnr9eK0iaUo6qZhXlDQLGOirMJQfptLdRd9u94Dqi2AkdQB3feM8gs
X-Google-Smtp-Source: AGHT+IHBHNsg3laOg4wrn3EMfMJNLLH9CA6cG2zOPseNfTboaCct+HIkokNs/SxWCNjjoow63NRVIQ==
X-Received: by 2002:a17:902:f690:b0:267:95ad:8cb8 with SMTP id d9443c01a7336-290272e1913mr350710035ad.44.1760493191070;
        Tue, 14 Oct 2025 18:53:11 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29055badc54sm111789325ad.37.2025.10.14.18.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:53:10 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	syzbot@syzkaller.appspotmail.com
Subject: [PATCH net-next v6 1/2] net/tls: support setting the maximum payload size
Date: Wed, 15 Oct 2025 11:52:43 +1000
Message-ID: <20251015015243.72259-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

During a handshake, an endpoint may specify a maximum record size limit.
Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for the
maximum record size. Meaning that, the outgoing records from the kernel
can exceed a lower size negotiated during the handshake. In such a case,
the TLS endpoint must send a fatal "record_overflow" alert [1], and
thus the record is discarded.

Upcoming Western Digital NVMe-TCP hardware controllers implement TLS
support. For these devices, supporting TLS record size negotiation is
necessary because the maximum TLS record size supported by the controller
is less than the default 16KB currently used by the kernel.

Currently, there is no way to inform the kernel of such a limit. This patch
adds support to a new setsockopt() option `TLS_TX_MAX_PAYLOAD_LEN` that
allows for setting the maximum plaintext fragment size. Once set, outgoing
records are no larger than the size specified. This option can be used to
specify the record size limit.

[1] https://www.rfc-editor.org/rfc/rfc8449

Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
Changes V5 -> V6:
	- Add NULL check for sw_ctx. Reported by syzbot.

V5: https://lore.kernel.org/netdev/20251014051825.1084403-2-wilfred.opensource@gmail.com/ 
---
 Documentation/networking/tls.rst | 11 ++++++
 include/net/tls.h                |  3 ++
 include/uapi/linux/tls.h         |  2 ++
 net/tls/tls_device.c             |  2 +-
 net/tls/tls_main.c               | 62 ++++++++++++++++++++++++++++++++
 net/tls/tls_sw.c                 |  2 +-
 6 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 36cc7afc2527..dabab17ab84a 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -280,6 +280,17 @@ If the record decrypted turns out to had been padded or is not a data
 record it will be decrypted again into a kernel buffer without zero copy.
 Such events are counted in the ``TlsDecryptRetry`` statistic.
 
+TLS_TX_MAX_PAYLOAD_LEN
+~~~~~~~~~~~~~~~~~~~~~~
+
+Sets the maximum size for the plaintext of a protected record.
+
+When this option is set, the kernel enforces this limit on all transmitted TLS
+records, ensuring no plaintext fragment exceeds the specified size. This can be
+used to specify the TLS Record Size Limit [1].
+
+[1] https://datatracker.ietf.org/doc/html/rfc8449
+
 Statistics
 ==========
 
diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..f2af113728aa 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -53,6 +53,8 @@ struct tls_rec;
 
 /* Maximum data size carried in a TLS record */
 #define TLS_MAX_PAYLOAD_SIZE		((size_t)1 << 14)
+/* Minimum record size limit as per RFC8449 */
+#define TLS_MIN_RECORD_SIZE_LIM		((size_t)1 << 6)
 
 #define TLS_HEADER_SIZE			5
 #define TLS_NONCE_OFFSET		TLS_HEADER_SIZE
@@ -226,6 +228,7 @@ struct tls_context {
 	u8 rx_conf:3;
 	u8 zerocopy_sendfile:1;
 	u8 rx_no_pad:1;
+	u16 tx_max_payload_len;
 
 	int (*push_pending_record)(struct sock *sk, int flags);
 	void (*sk_write_space)(struct sock *sk);
diff --git a/include/uapi/linux/tls.h b/include/uapi/linux/tls.h
index b66a800389cc..b8b9c42f848c 100644
--- a/include/uapi/linux/tls.h
+++ b/include/uapi/linux/tls.h
@@ -41,6 +41,7 @@
 #define TLS_RX			2	/* Set receive parameters */
 #define TLS_TX_ZEROCOPY_RO	3	/* TX zerocopy (only sendfile now) */
 #define TLS_RX_EXPECT_NO_PAD	4	/* Attempt opportunistic zero-copy */
+#define TLS_TX_MAX_PAYLOAD_LEN	5	/* Maximum plaintext size */
 
 /* Supported versions */
 #define TLS_VERSION_MINOR(ver)	((ver) & 0xFF)
@@ -194,6 +195,7 @@ enum {
 	TLS_INFO_RXCONF,
 	TLS_INFO_ZC_RO_TX,
 	TLS_INFO_RX_NO_PAD,
+	TLS_INFO_TX_MAX_PAYLOAD_LEN,
 	__TLS_INFO_MAX,
 };
 #define TLS_INFO_MAX (__TLS_INFO_MAX - 1)
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a64ae15b1a60..c6289c73cffc 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -461,7 +461,7 @@ static int tls_push_data(struct sock *sk,
 	/* TLS_HEADER_SIZE is not counted as part of the TLS record, and
 	 * we need to leave room for an authentication tag.
 	 */
-	max_open_record_len = TLS_MAX_PAYLOAD_SIZE +
+	max_open_record_len = tls_ctx->tx_max_payload_len +
 			      prot->prepend_size;
 	do {
 		rc = tls_do_allocation(sk, ctx, pfrag, prot->prepend_size);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index a3ccb3135e51..b96c825b90e9 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -544,6 +544,28 @@ static int do_tls_getsockopt_no_pad(struct sock *sk, char __user *optval,
 	return 0;
 }
 
+static int do_tls_getsockopt_tx_payload_len(struct sock *sk, char __user *optval,
+					    int __user *optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	u16 payload_len = ctx->tx_max_payload_len;
+	int len;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < sizeof(payload_len))
+		return -EINVAL;
+
+	if (put_user(sizeof(payload_len), optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, &payload_len, sizeof(payload_len)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int do_tls_getsockopt(struct sock *sk, int optname,
 			     char __user *optval, int __user *optlen)
 {
@@ -563,6 +585,9 @@ static int do_tls_getsockopt(struct sock *sk, int optname,
 	case TLS_RX_EXPECT_NO_PAD:
 		rc = do_tls_getsockopt_no_pad(sk, optval, optlen);
 		break;
+	case TLS_TX_MAX_PAYLOAD_LEN:
+		rc = do_tls_getsockopt_tx_payload_len(sk, optval, optlen);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -812,6 +837,30 @@ static int do_tls_setsockopt_no_pad(struct sock *sk, sockptr_t optval,
 	return rc;
 }
 
+static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
+					    unsigned int optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
+	u16 value;
+
+	if (sw_ctx && sw_ctx->open_rec)
+		return -EBUSY;
+
+	if (sockptr_is_null(optval) || optlen != sizeof(value))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&value, optval, sizeof(value)))
+		return -EFAULT;
+
+	if (value < TLS_MIN_RECORD_SIZE_LIM || value > TLS_MAX_PAYLOAD_SIZE)
+		return -EINVAL;
+
+	ctx->tx_max_payload_len = value;
+
+	return 0;
+}
+
 static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			     unsigned int optlen)
 {
@@ -833,6 +882,11 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	case TLS_RX_EXPECT_NO_PAD:
 		rc = do_tls_setsockopt_no_pad(sk, optval, optlen);
 		break;
+	case TLS_TX_MAX_PAYLOAD_LEN:
+		lock_sock(sk);
+		rc = do_tls_setsockopt_tx_payload_len(sk, optval, optlen);
+		release_sock(sk);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -1022,6 +1076,7 @@ static int tls_init(struct sock *sk)
 
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
+	ctx->tx_max_payload_len = TLS_MAX_PAYLOAD_SIZE;
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -1111,6 +1166,12 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 			goto nla_failure;
 	}
 
+	err = nla_put_u16(skb, TLS_INFO_TX_MAX_PAYLOAD_LEN,
+			  ctx->tx_max_payload_len);
+
+	if (err)
+		goto nla_failure;
+
 	rcu_read_unlock();
 	nla_nest_end(skb, start);
 	return 0;
@@ -1132,6 +1193,7 @@ static size_t tls_get_info_size(const struct sock *sk, bool net_admin)
 		nla_total_size(sizeof(u16)) +	/* TLS_INFO_TXCONF */
 		nla_total_size(0) +		/* TLS_INFO_ZC_RO_TX */
 		nla_total_size(0) +		/* TLS_INFO_RX_NO_PAD */
+		nla_total_size(sizeof(u16)) +   /* TLS_INFO_TX_MAX_PAYLOAD_LEN */
 		0;
 
 	return size;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index daac9fd4be7e..e76ea38b712a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1079,7 +1079,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		orig_size = msg_pl->sg.size;
 		full_record = false;
 		try_to_copy = msg_data_left(msg);
-		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
+		record_room = tls_ctx->tx_max_payload_len - msg_pl->sg.size;
 		if (try_to_copy >= record_room) {
 			try_to_copy = record_room;
 			full_record = true;
-- 
2.51.0



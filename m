Return-Path: <linux-kselftest+bounces-43648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A35BF5821
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 11:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6076C4FEE07
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB33632AAD2;
	Tue, 21 Oct 2025 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPnSOIbL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16652329C4A
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038982; cv=none; b=jzL+SghenhtXos1wJfT5dYklJ9lwC7dFxqRnHUsa0wKhlEBNCuEtdIqtN9SoZ46UiWiujUrlqYBrlMvw5/Jxjsj05Bmsc+Uh48corJStC066ejBUYkhfk7XPKWRD+aXQ8ZMxbB8Xqarr5oWRAQ1ICUOkt77vzoojhF8RR/Ifm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038982; c=relaxed/simple;
	bh=ydjNulEtIQL/VUFY0ZG7RKocVMK4HEHcsSkV0RedUKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5UUbbFMDHpujURsJAFQP6G7DKT3bLr28pKldhNyLXLcP9FhG41PLAP1ux76JfDx3oD0xHcUcdA3uH92Y9q486eQUMso17uQe9WIuhS/AM4aIH4PEjw/BrLvue4rVgAAp0+FqwMtNtrP/GmgBsuK0vc0jovPXKBXgfX6agj7vY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPnSOIbL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso3906038a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761038980; x=1761643780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyRIWau3piKW51ygIAahcBt+sXvlHI6glcvn3yu2iag=;
        b=WPnSOIbL6WFXFDcxn2eEcNmaJ7nAGuAR6r+oJy6o04lxoSjo7XQZ8XaS/IrGnidv2H
         zd8KlOe7yAR23jhTJMIihRmulhWKcI3gsKu8vVgoUg0YnP9ekjUQvsj91q73YByZ1Lpr
         o0lc7fX0f2FfezHgRtbxMHjkeBNo4YnP94OTEli6u3im+HI93tqqaGU7xbBm8xHf6eEg
         dYyJ5NUZAYPd1yP/F8NhEd7Y02X4PUJuMEWcgz4cdKhezW5ZmEbLx3faMSPYTOzgeh5s
         YLyxauUGXgZRzpLc8Kq3/iJhQHkkTjDXavcqit2zTwcit+gGFVfhuoRPUrf0uYJ0s/70
         HH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038980; x=1761643780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyRIWau3piKW51ygIAahcBt+sXvlHI6glcvn3yu2iag=;
        b=BJhRRo3gSGGnh9c55l4+eXFkeqMUDhHapIIs63uxtAuHlPdg7b+EmqMVDOwatYVXHt
         NJyBbaEvZcgJexXETKLBLa1TClAu8IEbWbPsvhHQ+iOqnZfPrLp8CEvn3UXMpbdh65wq
         4FKBk4KsAJQlaE+X07tH+uzDqn7UMHNRCG1Be+GrFE/HSfb/I2uJ1dqAotnI1k06wRqG
         +tpz45o9uwUc6UINyPGy4PLDR190nXRdxGV/oYGzehlbAM6WWgitf4fCv/yjgp0NN0nN
         sBPtLbZopXe9bwxDmfxECxZEvgOQfFHweGXu8NkpTceHzW30905D+CY9Bjsp8NYZ6gRW
         n7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCV3/fhaz2+UcxRt7oRi/ONJvj/ZxIM4l0+jAuCaruCMhBRbuldN2TV3iAuHVCtmPuIrSK6S/PPYEt1ScOlrQ5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcjzOr1bQGMg/H9e3HXBXD1keg8Q/IYPCk8j0YiFvEAlEMw8aQ
	7iiYbLUX72MWvy6w3MxV5OU9oJS2MQKF0HwfHT3amYVYaFMopwtxgVCT
X-Gm-Gg: ASbGncvhqhhIQ9xwz/p4eZbYgbLvSnF7LiXFunOwb+3XP2g4n4LeAlAcm05PRyBUhZ+
	1gyEX6X+pG5i/jxl2/qOf1cg7pE5WTxwRANB9JMij2JzpRGq4ij0I+NacSgGqEotCV8GU1dTDYt
	qzcr5AETqKN410ik7R+i0FDSYWcgmncqNGJ6APB+SxjOE9B3azRWaRI65KttX59A1m/N3Gn2x45
	BkxRR/Yjo/Zn7MuiT1xx2cp1BIcooXlEFW92TxRE39lQEFFPXOgQPAjc1QORW5QIvye+3KM2udQ
	vXlTQwsyx25kwEG1SDGpAr5xqmR7vqULfzjmPNpKi4u1rK5L/OqktFf5NZpIqKtHV9p3ZcKFT2B
	3SkpAREXPb7Qs91mEyTNUvP1KshUbBKxq7YSZDGqTb7W7+MGd/9ODFjqmBHlqoXiouCRlB7jBAy
	8wH1T7rz/TvpjLwn4=
X-Google-Smtp-Source: AGHT+IEJYOxTUq6g5cMID2h9haxbzYTCF6o6B9VftSTQfCXLvzoMK8wkk7HT6AEAPC6X5HED33+s3Q==
X-Received: by 2002:a17:903:138a:b0:28e:c9f6:867b with SMTP id d9443c01a7336-290c9cd4adbmr188938385ad.23.1761038980324;
        Tue, 21 Oct 2025 02:29:40 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc83esm104497195ad.38.2025.10.21.02.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:29:39 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH net-next v7 1/2] net/tls: support setting the maximum payload size
Date: Tue, 21 Oct 2025 19:29:17 +1000
Message-ID: <20251021092917.386645-2-wilfred.opensource@gmail.com>
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

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
V6 -> V7:
 - Added more information to the description regarding record_size_limit
 - For TLS 1.3, setsockopt() now allows a 63 byte minimum to account for the
   ContentType
 - getsockopt() returns the total plaintext length, for TLS 1.3, this will
   1 byte higher than what is set using setsockopt().
---
 Documentation/networking/tls.rst | 22 +++++++++++
 include/net/tls.h                |  3 ++
 include/uapi/linux/tls.h         |  2 +
 net/tls/tls_device.c             |  2 +-
 net/tls/tls_main.c               | 68 ++++++++++++++++++++++++++++++++
 net/tls/tls_sw.c                 |  2 +-
 6 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 36cc7afc2527..ecaa7631ec46 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -280,6 +280,28 @@ If the record decrypted turns out to had been padded or is not a data
 record it will be decrypted again into a kernel buffer without zero copy.
 Such events are counted in the ``TlsDecryptRetry`` statistic.
 
+TLS_TX_MAX_PAYLOAD_LEN
+~~~~~~~~~~~~~~~~~~~~~~
+
+Specifies the maximum size of the plaintext payload for transmitted TLS records.
+
+When this option is set, the kernel enforces the specified limit on all outgoing
+TLS records. No plaintext fragment will exceed this size. This option can be used
+to implement the TLS Record Size Limit extension [1].
+	- For TLS 1.2, the value corresponds directly to the record size limit.
+	- For TLS 1.3, the value should be set to record_size_limit - 1, since
+	  the record size limit includes one additional byte for the ContentType
+	  field.
+
+The valid range for this option is 64 to 16384 bytes for TLS 1.2, and 63 to
+16384 bytes for TLS 1.3. The lower minimum for TLS 1.3 accounts for the
+extra byte used by the ContentType field.
+
+For TLS 1.3, getsockopt() will return the total plaintext fragment length,
+inclusive of the ContentType field.
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
index caa2b5d24622..4d29b390aed9 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -462,7 +462,7 @@ static int tls_push_data(struct sock *sk,
 	/* TLS_HEADER_SIZE is not counted as part of the TLS record, and
 	 * we need to leave room for an authentication tag.
 	 */
-	max_open_record_len = TLS_MAX_PAYLOAD_SIZE +
+	max_open_record_len = tls_ctx->tx_max_payload_len +
 			      prot->prepend_size;
 	do {
 		rc = tls_do_allocation(sk, ctx, pfrag, prot->prepend_size);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 39a2ab47fe72..b234d44bd789 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -541,6 +541,32 @@ static int do_tls_getsockopt_no_pad(struct sock *sk, char __user *optval,
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
+	/* For TLS 1.3 payload length includes ContentType */
+	if (ctx->prot_info.version == TLS_1_3_VERSION)
+		payload_len++;
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
@@ -560,6 +586,9 @@ static int do_tls_getsockopt(struct sock *sk, int optname,
 	case TLS_RX_EXPECT_NO_PAD:
 		rc = do_tls_getsockopt_no_pad(sk, optval, optlen);
 		break;
+	case TLS_TX_MAX_PAYLOAD_LEN:
+		rc = do_tls_getsockopt_tx_payload_len(sk, optval, optlen);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -809,6 +838,32 @@ static int do_tls_setsockopt_no_pad(struct sock *sk, sockptr_t optval,
 	return rc;
 }
 
+static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
+					    unsigned int optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
+	u16 value;
+	bool tls_13 = ctx->prot_info.version == TLS_1_3_VERSION;
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
+	if (value < TLS_MIN_RECORD_SIZE_LIM - (tls_13 ? 1 : 0) ||
+	    value > TLS_MAX_PAYLOAD_SIZE)
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
@@ -830,6 +885,11 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
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
@@ -1019,6 +1079,7 @@ static int tls_init(struct sock *sk)
 
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
+	ctx->tx_max_payload_len = TLS_MAX_PAYLOAD_SIZE;
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -1108,6 +1169,12 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
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
@@ -1129,6 +1196,7 @@ static size_t tls_get_info_size(const struct sock *sk, bool net_admin)
 		nla_total_size(sizeof(u16)) +	/* TLS_INFO_TXCONF */
 		nla_total_size(0) +		/* TLS_INFO_ZC_RO_TX */
 		nla_total_size(0) +		/* TLS_INFO_RX_NO_PAD */
+		nla_total_size(sizeof(u16)) +   /* TLS_INFO_TX_MAX_PAYLOAD_LEN */
 		0;
 
 	return size;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d17135369980..9937d4c810f2 100644
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



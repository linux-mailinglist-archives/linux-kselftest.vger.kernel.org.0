Return-Path: <linux-kselftest+bounces-42127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 357E9B946BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EEC1900784
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A14830E0D8;
	Tue, 23 Sep 2025 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVGWkvjC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76230C637
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 05:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758605548; cv=none; b=cD220R4nEzrtz8XvdBFKONEtJQvx6e2NnNIKrj7ZyqwnPi40WXu0aBtuSvThI5oRhvsH0E85Gpk45W96EwIIO/j8lCaX3ieYqeExuMVPaaIErxIdBdsXmwynSDULvQm8Os5lP12OXlzSEz7LtolyJmBBcHi0HNFlzr+5oVwoPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758605548; c=relaxed/simple;
	bh=mnKcp7QXxh6FnhPzW++fPEZKuAGmKS+/1ruQEK19RmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mJ0ocyh1WzjjMXCiygCX+cvnyWfZm0asYlbyB6/bAB+cz6uZbo9t921f3jSDy1JtSzaPbRPL56JzvNgXI1U5MvV/4pLz17uSUhmNCLX9EDzBYh/JCAjz4QDxsFFbRSfEClVG1t27nlC2AWb0rbwkbM763F0+cqjMqJrPxPB/SHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVGWkvjC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f32d99a97so1701773b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 22:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758605545; x=1759210345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oTklLBIdudKNwwxYF9mQAs76GUakpHn9P9mG7j3zuzg=;
        b=RVGWkvjCxVdCtCafKt9oVcyW45tNSHSRePOvkSZqbHIoAqE2CxpDjb4Cl67ccmg8e3
         ga+uKKMM3LcOKD/CmIJoFsAGaSTZ9OtQ54R80G2Sf5o3PvxqakKZRl4GEe8a38ooHdWk
         O9XA+iLhPr0klyt6gF6FbcoFQN5GdtZUIMpC+CWYcS8+GGJC8Po69tzzqRfPyfYV9S+U
         s+aEhhGNzabMG92LtPqQmt0AgCf/qdkJfPUMmKIivWLaxfGNyVgnYPQDmfVyY8YbBGSV
         pA4w9KFNoTUuTgcFqyu2LimKANnf0miWr8C7/dCtVoHkIB1f2XYnQ9EWwDCcy2JnvFlz
         AVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758605545; x=1759210345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTklLBIdudKNwwxYF9mQAs76GUakpHn9P9mG7j3zuzg=;
        b=MhB0FN3jasvgdpG5Ac16hrD8wbhhxHOtJZ79cEE5hWN7HrU/2yqVsjrJk2jfAAiqBQ
         0QBx98MbqEw47UtYViv6ZbzUmkdh3H0vh/Uhs26OqJFRlgR1n39X1IlDbOWNfOjticmy
         AEL4XQi1nt8tj72pj47VcQqelf/JhWELvriDx/Rax55uBxTxF2vbur1poT1dhictIt5M
         ZXzBxChuG/08s3O+0hPggosCBhyr0V7ne+lsEbk21RlbX6AHNRBKaVW5mcb/lVSJ0nmg
         EeM59GL1+EyrSqcQpO6HRP78uuxm3P0h87wMYcs0VYZuHSgmdloRdqKTMaNV5ijwSe8G
         8b1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXrnm3WFjI78TOCc1kGnCX2AS3ilcZ68dlxubF7KLJnp5B9xtA+d4L0sR42jQnkeXpS8WdFc/TetDbFmMXXWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk5G9+elclOMJtILt4olw2nlvA7ow1nUueDhdyAM/B90DlVze9
	u1g+jaBVQNxWq6RDXqjhKAkb5qXA1mUI/9pORzqpgPUt9AuwbMazQEt9
X-Gm-Gg: ASbGnctwwuu2ZAFaTPfD/T3Dc1O1N1dSfG7vqCfake/yd5DIXGheKEbyUniJvl0Y2xs
	TKLynH9q8t4wvEHy1dKpDc8OZZS9j+gsfsDJLZ/CaTC7RaznH3hhQwbGsPlqnUa/h3JhSvkQurB
	BtK5HnD+9ntG6936q7524mDoq8pOJHEtkfIr8iqhxesHAzjmrX/uSa8kReBO9J/TKSAGHukga3z
	uJdYTcLw64Xo6TwQ/nkGcjI1Nfok/WeX4tN23F2tyfCRjiaD1oSrc7KPGNscQn0nEOhMCQdJQ7o
	66H1fXzTS2Gz5BzsYCXfTuNAOfB+0mwjgvndEhx4ObRQSwYUZGsaK2jL6jhIOPfhzAHQq9xFPPR
	1veunDK56hAi5BI0+4iESn+4PzGY=
X-Google-Smtp-Source: AGHT+IFKfTeQjGIZYPJam1yQHsQYLdr0b0NGYWFWmj2DgS7W8LankDE7NUzKW6ZHDusY1dexOnf3Lg==
X-Received: by 2002:a05:6a00:3d08:b0:77f:2d4e:674e with SMTP id d2e1a72fcca58-77f53b07ec4mr1309126b3a.30.1758605545295;
        Mon, 22 Sep 2025 22:32:25 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1550f70asm9639446b3a.13.2025.09.22.22.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 22:32:24 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	shuah@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v4 1/2] net/tls: support maximum record size limit
Date: Tue, 23 Sep 2025 15:32:06 +1000
Message-ID: <20250923053207.113938-1-wilfred.opensource@gmail.com>
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

This patch adds support for retrieving the negotiated record size limit
during a handshake, and enforcing it at the TLS layer such that outgoing
records are no larger than the size negotiated. This patch depends on
the respective userspace support in tlshd and GnuTLS [2].

[1] https://www.rfc-editor.org/rfc/rfc8449
[2] https://gitlab.com/gnutls/gnutls/-/merge_requests/2005

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
Changes V3 -> V4:
    * Added record_size_limit RFC reference to documentation
    * Always export the record size limit in tls_get_info()
    * Disallow user space to change the record_size_limit from under us
      if an open record is pending.
    * Added record_size_limit minimum size check as per RFC
    * Allow space for the ContentType byte for TLS 1.3. The expected
      behaviour is that userspace directly uses the negotiated
      record_size_limit, kernel will limit the plaintext buffer size
      appropirately.
    * New patch to add self-tests.
---
 Documentation/networking/tls.rst | 12 +++++
 include/net/tls.h                |  5 +++
 include/uapi/linux/tls.h         |  2 +
 net/tls/tls_device.c             |  2 +-
 net/tls/tls_main.c               | 75 ++++++++++++++++++++++++++++++++
 net/tls/tls_sw.c                 |  2 +-
 6 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 36cc7afc2527..d24bf8911bb8 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -280,6 +280,18 @@ If the record decrypted turns out to had been padded or is not a data
 record it will be decrypted again into a kernel buffer without zero copy.
 Such events are counted in the ``TlsDecryptRetry`` statistic.
 
+TLS_TX_RECORD_SIZE_LIM
+~~~~~~~~~~~~~~~~~~~~~~
+
+Sets the maximum size for the plaintext of a protected record.
+
+The provided value should correspond to the limit negotiated during the TLS
+handshake via the `record_size_limit` extension (RFC 8449)[1]. When this
+option is set, the kernel enforces this limit on all transmitted TLS records,
+ensuring no plaintext fragment exceeds the specified size.
+
+[1] https://datatracker.ietf.org/doc/html/rfc8449
+
 Statistics
 ==========
 
diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..32f053770ec4 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -53,6 +53,8 @@ struct tls_rec;
 
 /* Maximum data size carried in a TLS record */
 #define TLS_MAX_PAYLOAD_SIZE		((size_t)1 << 14)
+/* Minimum record size limit as per RFC8449 */
+#define TLS_MIN_RECORD_SIZE_LIM		((size_t)1 << 6)
 
 #define TLS_HEADER_SIZE			5
 #define TLS_NONCE_OFFSET		TLS_HEADER_SIZE
@@ -226,6 +228,9 @@ struct tls_context {
 	u8 rx_conf:3;
 	u8 zerocopy_sendfile:1;
 	u8 rx_no_pad:1;
+	u16 tx_record_size_limit; /* Max plaintext fragment size. For TLS 1.3,
+				   * this excludes the ContentType.
+				   */
 
 	int (*push_pending_record)(struct sock *sk, int flags);
 	void (*sk_write_space)(struct sock *sk);
diff --git a/include/uapi/linux/tls.h b/include/uapi/linux/tls.h
index b66a800389cc..3add266d5916 100644
--- a/include/uapi/linux/tls.h
+++ b/include/uapi/linux/tls.h
@@ -41,6 +41,7 @@
 #define TLS_RX			2	/* Set receive parameters */
 #define TLS_TX_ZEROCOPY_RO	3	/* TX zerocopy (only sendfile now) */
 #define TLS_RX_EXPECT_NO_PAD	4	/* Attempt opportunistic zero-copy */
+#define TLS_TX_RECORD_SIZE_LIM	5	/* Maximum record size */
 
 /* Supported versions */
 #define TLS_VERSION_MINOR(ver)	((ver) & 0xFF)
@@ -194,6 +195,7 @@ enum {
 	TLS_INFO_RXCONF,
 	TLS_INFO_ZC_RO_TX,
 	TLS_INFO_RX_NO_PAD,
+	TLS_INFO_TX_RECORD_SIZE_LIM,
 	__TLS_INFO_MAX,
 };
 #define TLS_INFO_MAX (__TLS_INFO_MAX - 1)
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f672a62a9a52..bf16ceb41dde 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -459,7 +459,7 @@ static int tls_push_data(struct sock *sk,
 	/* TLS_HEADER_SIZE is not counted as part of the TLS record, and
 	 * we need to leave room for an authentication tag.
 	 */
-	max_open_record_len = TLS_MAX_PAYLOAD_SIZE +
+	max_open_record_len = tls_ctx->tx_record_size_limit +
 			      prot->prepend_size;
 	do {
 		rc = tls_do_allocation(sk, ctx, pfrag, prot->prepend_size);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index a3ccb3135e51..09883d9c6c96 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -544,6 +544,31 @@ static int do_tls_getsockopt_no_pad(struct sock *sk, char __user *optval,
 	return 0;
 }
 
+static int do_tls_getsockopt_tx_record_size(struct sock *sk, char __user *optval,
+					    int __user *optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	int len;
+	/* TLS 1.3: Record length contains ContentType */
+	u16 record_size_limit = ctx->prot_info.version == TLS_1_3_VERSION ?
+				ctx->tx_record_size_limit + 1 :
+				ctx->tx_record_size_limit;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < sizeof(record_size_limit))
+		return -EINVAL;
+
+	if (put_user(sizeof(record_size_limit), optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, &record_size_limit, sizeof(record_size_limit)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int do_tls_getsockopt(struct sock *sk, int optname,
 			     char __user *optval, int __user *optlen)
 {
@@ -563,6 +588,9 @@ static int do_tls_getsockopt(struct sock *sk, int optname,
 	case TLS_RX_EXPECT_NO_PAD:
 		rc = do_tls_getsockopt_no_pad(sk, optval, optlen);
 		break;
+	case TLS_TX_RECORD_SIZE_LIM:
+		rc = do_tls_getsockopt_tx_record_size(sk, optval, optlen);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -812,6 +840,43 @@ static int do_tls_setsockopt_no_pad(struct sock *sk, sockptr_t optval,
 	return rc;
 }
 
+static int do_tls_setsockopt_tx_record_size(struct sock *sk, sockptr_t optval,
+					    unsigned int optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
+	u16 value;
+
+	if (sw_ctx->open_rec)
+		return -EBUSY;
+
+	if (sockptr_is_null(optval) || optlen != sizeof(value))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&value, optval, sizeof(value)))
+		return -EFAULT;
+
+	if (value < TLS_MIN_RECORD_SIZE_LIM)
+		return -EINVAL;
+
+	if (ctx->prot_info.version == TLS_1_2_VERSION &&
+	    value > TLS_MAX_PAYLOAD_SIZE)
+		return -EINVAL;
+
+	if (ctx->prot_info.version == TLS_1_3_VERSION &&
+	    value - 1 > TLS_MAX_PAYLOAD_SIZE)
+		return -EINVAL;
+
+	/*
+	 * For TLS 1.3: 'value' includes one byte for the appended ContentType.
+	 * Adjust the kernel's internal plaintext limit accordingly.
+	 */
+	ctx->tx_record_size_limit = ctx->prot_info.version == TLS_1_3_VERSION ?
+				    value - 1 : value;
+
+	return 0;
+}
+
 static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			     unsigned int optlen)
 {
@@ -833,6 +898,9 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	case TLS_RX_EXPECT_NO_PAD:
 		rc = do_tls_setsockopt_no_pad(sk, optval, optlen);
 		break;
+	case TLS_TX_RECORD_SIZE_LIM:
+		rc = do_tls_setsockopt_tx_record_size(sk, optval, optlen);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -1022,6 +1090,7 @@ static int tls_init(struct sock *sk)
 
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
+	ctx->tx_record_size_limit = TLS_MAX_PAYLOAD_SIZE;
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -1111,6 +1180,11 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 			goto nla_failure;
 	}
 
+	err = nla_put_u16(skb, TLS_INFO_TX_RECORD_SIZE_LIM,
+			  ctx->tx_record_size_limit);
+	if (err)
+		goto nla_failure;
+
 	rcu_read_unlock();
 	nla_nest_end(skb, start);
 	return 0;
@@ -1132,6 +1206,7 @@ static size_t tls_get_info_size(const struct sock *sk, bool net_admin)
 		nla_total_size(sizeof(u16)) +	/* TLS_INFO_TXCONF */
 		nla_total_size(0) +		/* TLS_INFO_ZC_RO_TX */
 		nla_total_size(0) +		/* TLS_INFO_RX_NO_PAD */
+		nla_total_size(sizeof(u16)) +   /* TLS_INFO_TX_RECORD_SIZE_LIM */
 		0;
 
 	return size;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index bac65d0d4e3e..28fb796573d1 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1079,7 +1079,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		orig_size = msg_pl->sg.size;
 		full_record = false;
 		try_to_copy = msg_data_left(msg);
-		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
+		record_room = tls_ctx->tx_record_size_limit - msg_pl->sg.size;
 		if (try_to_copy >= record_room) {
 			try_to_copy = record_room;
 			full_record = true;
-- 
2.51.0



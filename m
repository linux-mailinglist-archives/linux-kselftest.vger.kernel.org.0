Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82ED147E5B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Dec 2021 16:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349235AbhLWPlV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Dec 2021 10:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349085AbhLWPk5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Dec 2021 10:40:57 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85930C06179C;
        Thu, 23 Dec 2021 07:40:52 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j21so22920348edt.9;
        Thu, 23 Dec 2021 07:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRGwolcJOYidDxYss3ob3FNIDs8LTy/+3TFunohiWFs=;
        b=Y2JmeY7TS++YgnizYaWK3qTpCY8gkFES+d60o/ZzRBBImp+wBcS3EMZJO8qMdbij4o
         E/QdoVZHKZjLkvlm7mi+2kttKO2T88/ZgMDpO7hLqBWECOzI+GF61+xZTl35N9dW4szl
         OLkltoFXzGTDOJ4FtrW6ZgjqhzrbEHeR3wnPY6V90RRPgIZN+dRNSRNTMls1c6etq04a
         dqZ0uxNCatJpHGjwnXrTGxtHMT4mr0dA5jCIQTuu/1MUOZeMXofmoPscMvyj4dhBawlL
         WLcGjBKyR5Ek8LnMFOiYXxkpmeczv4ukvSIrS2CRjmSqdZP85RXWpn06JBEz3HPVEppx
         0KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRGwolcJOYidDxYss3ob3FNIDs8LTy/+3TFunohiWFs=;
        b=pNmBFJPEEezK7olTrhK+QfJWwQq7jy6BUkzFYKCGsJb9c46lwbV0oxTYThlasIw82E
         Mu8iQx91676LUdZblQonoh/+EexwUfs/0y+LtrSlbwea3U+xTTTU9TDc6QQsgoddAtqL
         BD9YOF6bcOiZ8QhE8lvHHJk46K8vmV56iSlddRo7HtdO7h+UV/7BBGIBsBlRxYkKf/jY
         1WK2v3rYh2P8DlngDkzj/DLd3NY0UloO4FWJWqJIaeSPatTghuOtVFZOBq5JP81tVpVD
         LlecwHzcYkx7gAlnlvLpg/wVBF4B/y3XpZbNekmu1114jEgdb4UDka3YYTiLihy5+bPt
         1dHA==
X-Gm-Message-State: AOAM530tzV0ixXKWEPrSsDYVa8uDwx+5OOxhL/nH3CT4g12DThBH6qUB
        u9AfyYD6ZYGqExptkjbfK0k=
X-Google-Smtp-Source: ABdhPJwlUMR47WGCCYDL6ptOccVfj+9SE+TW+d+N684SAfTCoFfjYqWlAIF7zbUlWzmZal8PKLQB1A==
X-Received: by 2002:a17:907:72c5:: with SMTP id du5mr2379890ejc.43.1640274050918;
        Thu, 23 Dec 2021 07:40:50 -0800 (PST)
Received: from ponky.lan ([2a04:241e:501:3870:7c02:dfc6:b554:ab10])
        by smtp.gmail.com with ESMTPSA id bx6sm2088617edb.78.2021.12.23.07.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 07:40:50 -0800 (PST)
From:   Leonard Crestez <cdleonard@gmail.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Philip Paeps <philip@trouble.is>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Ivan Delalande <colona@arista.com>,
        Priyaranjan Jha <priyarjha@google.com>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/19] tcp: authopt: Implement Sequence Number Extension
Date:   Thu, 23 Dec 2021 17:40:03 +0200
Message-Id: <1297bfa0297d28d7b62ae6e9117f0c62dee09561.1640273966.git.cdleonard@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1640273966.git.cdleonard@gmail.com>
References: <cover.1640273966.git.cdleonard@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a compute_sne function which finds the value of SNE for a certain
SEQ given an already known "recent" SNE/SEQ. This is implemented using
the standard tcp before/after macro and will work for SEQ values that
are without 2^31 of the SEQ for which we know the SNE.

For updating we advance the value for rcv_sne at the same time as
rcv_nxt and for snd_sne at the same time as snd_nxt. We could track
other values (for example snd_una) but this is good enough and works
very easily for timewait socket.

This implementation is different from RFC suggestions and doesn't
require additional flags. It does pass tests from this draft:
    https://datatracker.ietf.org/doc/draft-touch-sne/

Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
---
 include/net/tcp_authopt.h | 34 ++++++++++++++
 net/ipv4/tcp_authopt.c    | 98 ++++++++++++++++++++++++++++++++++++++-
 net/ipv4/tcp_input.c      |  1 +
 net/ipv4/tcp_output.c     |  1 +
 4 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp_authopt.h b/include/net/tcp_authopt.h
index 4c9ec1f39932..6e9b5ca22f62 100644
--- a/include/net/tcp_authopt.h
+++ b/include/net/tcp_authopt.h
@@ -66,10 +66,14 @@ struct tcp_authopt_info {
 	u32 flags;
 	/** @src_isn: Local Initial Sequence Number */
 	u32 src_isn;
 	/** @dst_isn: Remote Initial Sequence Number */
 	u32 dst_isn;
+	/** @rcv_sne: Recv-side Sequence Number Extension tracking tcp_sock.rcv_nxt */
+	u32 rcv_sne;
+	/** @snd_sne: Send-side Sequence Number Extension tracking tcp_sock.snd_nxt */
+	u32 snd_sne;
 };
 
 /* TCP authopt as found in header */
 struct tcphdr_authopt {
 	u8 num;
@@ -185,10 +189,34 @@ static inline int tcp_authopt_inbound_check_req(struct request_sock *req, struct
 		if (info)
 			return __tcp_authopt_inbound_check((struct sock *)req, skb, info, opt);
 	}
 	return 0;
 }
+void __tcp_authopt_update_rcv_sne(struct tcp_sock *tp, struct tcp_authopt_info *info, u32 seq);
+static inline void tcp_authopt_update_rcv_sne(struct tcp_sock *tp, u32 seq)
+{
+	struct tcp_authopt_info *info;
+
+	if (tcp_authopt_needed) {
+		info = rcu_dereference_protected(tp->authopt_info,
+						 lockdep_sock_is_held((struct sock *)tp));
+		if (info)
+			__tcp_authopt_update_rcv_sne(tp, info, seq);
+	}
+}
+void __tcp_authopt_update_snd_sne(struct tcp_sock *tp, struct tcp_authopt_info *info, u32 seq);
+static inline void tcp_authopt_update_snd_sne(struct tcp_sock *tp, u32 seq)
+{
+	struct tcp_authopt_info *info;
+
+	if (tcp_authopt_needed) {
+		info = rcu_dereference_protected(tp->authopt_info,
+						 lockdep_sock_is_held((struct sock *)tp));
+		if (info)
+			__tcp_authopt_update_snd_sne(tp, info, seq);
+	}
+}
 #else
 static inline int tcp_set_authopt(struct sock *sk, sockptr_t optval, unsigned int optlen)
 {
 	return -ENOPROTOOPT;
 }
@@ -235,8 +263,14 @@ static inline int tcp_authopt_inbound_check(struct sock *sk, struct sk_buff *skb
 static inline int tcp_authopt_inbound_check_req(struct request_sock *sk, struct sk_buff *skb,
 						const u8 *opt)
 {
 	return 0;
 }
+static inline void tcp_authopt_update_rcv_sne(struct tcp_sock *tp, u32 seq)
+{
+}
+static inline void tcp_authopt_update_snd_sne(struct tcp_sock *tp, u32 seq)
+{
+}
 #endif
 
 #endif /* _LINUX_TCP_AUTHOPT_H */
diff --git a/net/ipv4/tcp_authopt.c b/net/ipv4/tcp_authopt.c
index 6be5dbcd530e..4a624a3a572d 100644
--- a/net/ipv4/tcp_authopt.c
+++ b/net/ipv4/tcp_authopt.c
@@ -644,10 +644,97 @@ static int tcp_authopt_get_isn(struct sock *sk,
 		*disn = htonl(info->dst_isn);
 	}
 	return 0;
 }
 
+/* compute_sne - Calculate Sequence Number Extension
+ *
+ * Give old upper/lower 32bit values and a new lower 32bit value determine the
+ * new value of the upper 32 bit. The new sequence number can be 2^31 before or
+ * after prev_seq but TCP window scaling should limit this further.
+ *
+ * For correct accounting the stored SNE value should be only updated together
+ * with the SEQ.
+ */
+static u32 compute_sne(u32 sne, u32 prev_seq, u32 seq)
+{
+	if (before(seq, prev_seq)) {
+		if (seq > prev_seq)
+			--sne;
+	} else {
+		if (seq < prev_seq)
+			++sne;
+	}
+
+	return sne;
+}
+
+/* Update rcv_sne, must be called immediately before rcv_nxt update */
+void __tcp_authopt_update_rcv_sne(struct tcp_sock *tp,
+				  struct tcp_authopt_info *info, u32 seq)
+{
+	info->rcv_sne = compute_sne(info->rcv_sne, tp->rcv_nxt, seq);
+}
+
+/* Update snd_sne, must be called immediately before snd_nxt update */
+void __tcp_authopt_update_snd_sne(struct tcp_sock *tp,
+				  struct tcp_authopt_info *info, u32 seq)
+{
+	info->snd_sne = compute_sne(info->snd_sne, tp->snd_nxt, seq);
+}
+
+/* Compute SNE for a specific packet (by seq). */
+static int compute_packet_sne(struct sock *sk, struct tcp_authopt_info *info,
+			      u32 seq, bool input, __be32 *sne)
+{
+	u32 rcv_nxt, snd_nxt;
+
+	// For TCP_NEW_SYN_RECV we have no tcp_authopt_info but tcp_request_sock holds ISN.
+	if (sk->sk_state == TCP_NEW_SYN_RECV) {
+		struct tcp_request_sock *rsk = tcp_rsk((struct request_sock *)sk);
+
+		if (input)
+			*sne = htonl(compute_sne(0, rsk->rcv_isn, seq));
+		else
+			*sne = htonl(compute_sne(0, rsk->snt_isn, seq));
+		return 0;
+	}
+
+	/* TCP_LISTEN only receives SYN */
+	if (sk->sk_state == TCP_LISTEN && input)
+		return 0;
+
+	/* TCP_SYN_SENT only sends SYN and receives SYN/ACK
+	 * For the input case rcv_nxt is initialized after the packet is
+	 * validated so tcp_sk(sk)->rcv_nxt is not initialized.
+	 */
+	if (sk->sk_state == TCP_SYN_SENT)
+		return 0;
+
+	if (sk->sk_state == TCP_TIME_WAIT) {
+		rcv_nxt = tcp_twsk(sk)->tw_rcv_nxt;
+		snd_nxt = tcp_twsk(sk)->tw_snd_nxt;
+	} else {
+		if (WARN_ONCE(!sk_fullsock(sk),
+			      "unexpected minisock sk=%p state=%d", sk,
+			      sk->sk_state))
+			return -EINVAL;
+		rcv_nxt = tcp_sk(sk)->rcv_nxt;
+		snd_nxt = tcp_sk(sk)->snd_nxt;
+	}
+
+	if (WARN_ONCE(!info, "unexpected missing info for sk=%p sk_state=%d", sk, sk->sk_state))
+		return -EINVAL;
+
+	if (input)
+		*sne = htonl(compute_sne(info->rcv_sne, rcv_nxt, seq));
+	else
+		*sne = htonl(compute_sne(info->snd_sne, snd_nxt, seq));
+
+	return 0;
+}
+
 /* Feed one buffer into ahash
  * The buffer is assumed to be DMA-able
  */
 static int crypto_ahash_buf(struct ahash_request *req, u8 *buf, uint len)
 {
@@ -679,10 +766,13 @@ int __tcp_authopt_openreq(struct sock *newsk, const struct sock *oldsk, struct r
 	if (!new_info)
 		return -ENOMEM;
 
 	new_info->src_isn = tcp_rsk(req)->snt_isn;
 	new_info->dst_isn = tcp_rsk(req)->rcv_isn;
+	/* Caller is tcp_create_openreq_child and already initializes snd_nxt/rcv_nxt */
+	new_info->snd_sne = compute_sne(0, new_info->src_isn, tcp_sk(newsk)->snd_nxt);
+	new_info->rcv_sne = compute_sne(0, new_info->dst_isn, tcp_sk(newsk)->rcv_nxt);
 	sk_gso_disable(newsk);
 	rcu_assign_pointer(tcp_sk(newsk)->authopt_info, new_info);
 
 	return 0;
 }
@@ -690,10 +780,12 @@ int __tcp_authopt_openreq(struct sock *newsk, const struct sock *oldsk, struct r
 void __tcp_authopt_finish_connect(struct sock *sk, struct sk_buff *skb,
 				  struct tcp_authopt_info *info)
 {
 	info->src_isn = ntohl(tcp_hdr(skb)->ack_seq) - 1;
 	info->dst_isn = ntohl(tcp_hdr(skb)->seq);
+	info->snd_sne = compute_sne(0, info->src_isn, tcp_sk(sk)->snd_nxt);
+	info->rcv_sne = compute_sne(0, info->dst_isn, tcp_sk(sk)->rcv_nxt);
 }
 
 /* feed traffic key into ahash */
 static int tcp_authopt_ahash_traffic_key(struct tcp_authopt_alg_pool *pool,
 					 struct sock *sk,
@@ -939,14 +1031,16 @@ static int tcp_authopt_hash_packet(struct tcp_authopt_alg_pool *pool,
 				   bool ipv6,
 				   bool include_options,
 				   u8 *macbuf)
 {
 	struct tcphdr *th = tcp_hdr(skb);
+	__be32 sne = 0;
 	int err;
 
-	/* NOTE: SNE unimplemented */
-	__be32 sne = 0;
+	err = compute_packet_sne(sk, info, ntohl(th->seq), input, &sne);
+	if (err)
+		return err;
 
 	err = crypto_ahash_init(pool->req);
 	if (err)
 		return err;
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4c9e403971fb..bc0a90c72391 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3517,10 +3517,11 @@ static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
 static void tcp_rcv_nxt_update(struct tcp_sock *tp, u32 seq)
 {
 	u32 delta = seq - tp->rcv_nxt;
 
 	sock_owned_by_me((struct sock *)tp);
+	tcp_authopt_update_rcv_sne(tp, seq);
 	tp->bytes_received += delta;
 	WRITE_ONCE(tp->rcv_nxt, seq);
 }
 
 /* Update our send window.
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b959e8b949b6..6a6024a0b9e9 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -67,10 +67,11 @@ static void tcp_event_new_data_sent(struct sock *sk, struct sk_buff *skb)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int prior_packets = tp->packets_out;
 
+	tcp_authopt_update_snd_sne(tp, TCP_SKB_CB(skb)->end_seq);
 	WRITE_ONCE(tp->snd_nxt, TCP_SKB_CB(skb)->end_seq);
 
 	__skb_unlink(skb, &sk->sk_write_queue);
 	tcp_rbtree_insert(&sk->tcp_rtx_queue, skb);
 
-- 
2.25.1


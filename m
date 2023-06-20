Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF3F73718B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 18:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjFTQak (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 12:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjFTQaf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 12:30:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B92B172E
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 09:30:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31110aea814so5040837f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278631; x=1689870631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJz7gc9qda31VHXjDefMsfEDaiQ4htT8RdWcVphxCr4=;
        b=ODYzJL4gVUO1EpHWCSWimvWMopKKyuUlSDRM5rPLsobNH4XVlut8xZPed/Q2XB+1kN
         DiTnIu+y/JHoy6f1ect3tID33me5wAK530s60PkMNMRD1ZT29cvragk24fxIQeijHMPm
         mOKSTUxoCDrxCl87wMwT86SC5p6+gAOyRQg8NzT8itV6M0ADSamiI5ymRC2nkIL14kSD
         ESJIv70qLPPEnYQDhhnVuFIDehuw1D8Swaq6vWsMs6SMOKJVGtJMtBIC+1w3qcdRfoQS
         iwDK1H8pEyxIti1rUcvjGzdMMi47utOEz2l78KcPNoOmZTvw8Vbe04i47duhCbIyQ0sI
         bHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278631; x=1689870631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJz7gc9qda31VHXjDefMsfEDaiQ4htT8RdWcVphxCr4=;
        b=kInodXueMKbtNhc8AdNFUmE2pJ8sqEylm0KVhJdQpn9aTrLQHglvByUP7itKbHPItG
         fKPthVLaiZpZ4OH64lzPJQQmXkcY9eb1oq12e/U5ACgZkSAApGLlG/5AGL4EwaLdGShj
         Cu/7QkMCFb7UomygF4FBHKeQ9dmh6bTP6CLjZoJHwsB3LqbGKfACfhF1ARcvXjJNLAHl
         uk3io0ZdEt0qzRcVBYedOTGtQCbeyaSlET7amgfTGZx7QdJ5I0qw76bE9V0X79tVhC5r
         J5aclRKPOtmAd8QYRclQ5sXtFSCFdMKY5Fj7dKZoQ0/XCiQaT2+maFeGNVV1zQWGuFJ9
         6YUA==
X-Gm-Message-State: AC+VfDxMvpWIAvtIB2hN8u3Eu9pjBplUlUh5DjwjYAwN7BtTSct1KnEO
        JQPF/cBvrp/53s7ceLTA0d9cWQ==
X-Google-Smtp-Source: ACHHUZ5yoZsEkL45M+7jpy33ffWLx7QJLrWf/genInYhZVVuHelYVR5t0KaQFQ8RaHcSZosYB1YHXQ==
X-Received: by 2002:adf:fb46:0:b0:30f:ce4f:5675 with SMTP id c6-20020adffb46000000b0030fce4f5675mr10459362wrs.59.1687278631410;
        Tue, 20 Jun 2023 09:30:31 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003f8fbe3bf7asm12064342wmq.32.2023.06.20.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:31 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 20 Jun 2023 18:30:15 +0200
Subject: [PATCH net-next 2/9] mptcp: track some aggregate data counters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-2-62b9444bfd48@tessares.net>
References: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
In-Reply-To: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7362;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=upisP8a+EDNWOLxXxnQUGW2DGQfmLWpgv+/AMNVeHqE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdQkH/1p+gLAtiVZp9VjseP1QF8bWYv0VmWkW
 cabfETQsXSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHUJAAKCRD2t4JPQmmg
 c2peEADTY6hCVD8xKcI/5YaG/DgVrXB1rs0esDuLgahOtKEtAwgxWdptY5SyKSSv4jZcFqKp5QN
 m5z1HDwZaDKWli+zFoPquF77pFcqOG1G3uB0je6uESsDRXS50UCIM5XrP2qmjIFagOYxt//4yMm
 1oIZiGcsCLCoHaMltOeCyDal4/T4SzA6oLgH01GSr1qLZ/uaAjCsJyNRjdqo4dZ2rwNQX7uU5m3
 adfXMMBW+jJJL6WWyB7EZHnFhWYxjifsk3gbdrSikTvye0H+PhuhX/1Nl/K66C79Zqvqor2l1gG
 j7EQBdVlH1NqVcYN9+h2uNod/N8gxU+ulfWDInr7yq3vLunQPlq53IVnknA78dPb4gDvSaXwTFv
 URxO7eVw4iA1LykdweJ2fP5pvKPTzy/QxzCSzQpaaIZq23GA/it1yptAWHqnficbXMhfyMGuK3m
 TAJeBNjJpVv6KALjiVQ4zyjjfMgZP+CXgPiI4tDwLrEB908DkfHtYFdFgSNyCsLxbINdNVodmPk
 pOO8vlyhSI1gI7M9P2jWXfqCu8mEmxgWY3Pz50A3ZcA6lZjnH5h6gSOaV8vRg1hSFvEHsjXy9s1
 W+Q3lsMw//nI8eBfgfOAHNz0bh2/Rdm4FXmfRzyLZJtMFnRRvIVC2KeDhY/lQLf8RX3DE41EJzS
 QC7V3z4QLuQEbMw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

Currently there are no data transfer counters accounting for all
the subflows used by a given MPTCP socket. The user-space can compute
such figures aggregating the subflow info, but that is inaccurate
if any subflow is closed before the MPTCP socket itself.

Add the new counters in the MPTCP socket itself and expose them
via the existing diag and sockopt. While touching mptcp_diag_fill_info(),
acquire the relevant locks before fetching the msk data, to ensure
better data consistency

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/385
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/uapi/linux/mptcp.h |  5 +++++
 net/mptcp/options.c        | 10 ++++++++--
 net/mptcp/protocol.c       | 11 ++++++++++-
 net/mptcp/protocol.h       |  4 ++++
 net/mptcp/sockopt.c        | 25 ++++++++++++++++++++-----
 5 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 32af2d278cb4..a124be6ebbba 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -123,6 +123,11 @@ struct mptcp_info {
 	__u8	mptcpi_local_addr_used;
 	__u8	mptcpi_local_addr_max;
 	__u8	mptcpi_csum_enabled;
+	__u32	mptcpi_retransmits;
+	__u64	mptcpi_bytes_retrans;
+	__u64	mptcpi_bytes_sent;
+	__u64	mptcpi_bytes_received;
+	__u64	mptcpi_bytes_acked;
 };
 
 /*
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4bdcd2b326bd..c254accb14de 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1026,6 +1026,12 @@ u64 __mptcp_expand_seq(u64 old_seq, u64 cur_seq)
 	return cur_seq;
 }
 
+static void __mptcp_snd_una_update(struct mptcp_sock *msk, u64 new_snd_una)
+{
+	msk->bytes_acked += new_snd_una - msk->snd_una;
+	msk->snd_una = new_snd_una;
+}
+
 static void ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
 			   struct mptcp_options_received *mp_opt)
@@ -1057,7 +1063,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		__mptcp_check_push(sk, ssk);
 
 	if (after64(new_snd_una, old_snd_una)) {
-		msk->snd_una = new_snd_una;
+		__mptcp_snd_una_update(msk, new_snd_una);
 		__mptcp_data_acked(sk);
 	}
 	mptcp_data_unlock(sk);
@@ -1123,7 +1129,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		/* on fallback we just need to ignore the msk-level snd_una, as
 		 * this is really plain TCP
 		 */
-		msk->snd_una = READ_ONCE(msk->snd_nxt);
+		__mptcp_snd_una_update(msk, READ_ONCE(msk->snd_nxt));
 
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9c756d675d4d..d5b8e488bce1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -377,6 +377,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
+		msk->bytes_received += copy_len;
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (tail && mptcp_try_coalesce(sk, tail, skb))
@@ -760,6 +761,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 			MPTCP_SKB_CB(skb)->map_seq += delta;
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
+		msk->bytes_received += end_seq - msk->ack_seq;
 		msk->ack_seq = end_seq;
 		moved = true;
 	}
@@ -1531,8 +1533,10 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 	 * that has been handed to the subflow for transmission
 	 * and skip update in case it was old dfrag.
 	 */
-	if (likely(after64(snd_nxt_new, msk->snd_nxt)))
+	if (likely(after64(snd_nxt_new, msk->snd_nxt))) {
+		msk->bytes_sent += snd_nxt_new - msk->snd_nxt;
 		msk->snd_nxt = snd_nxt_new;
+	}
 }
 
 void mptcp_check_and_set_pending(struct sock *sk)
@@ -2590,6 +2594,7 @@ static void __mptcp_retrans(struct sock *sk)
 	}
 	if (copied) {
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
+		msk->bytes_retrans += copied;
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
 		WRITE_ONCE(msk->allow_infinite_fallback, false);
@@ -3102,6 +3107,10 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
+	msk->bytes_acked = 0;
+	msk->bytes_received = 0;
+	msk->bytes_sent = 0;
+	msk->bytes_retrans = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 47b46602870e..27adfcc5aaa2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -262,10 +262,13 @@ struct mptcp_sock {
 	u64		local_key;
 	u64		remote_key;
 	u64		write_seq;
+	u64		bytes_sent;
 	u64		snd_nxt;
+	u64		bytes_received;
 	u64		ack_seq;
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
+	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
 	struct sock	*last_snd;
 	int		snd_burst;
@@ -274,6 +277,7 @@ struct mptcp_sock {
 						 * recovery related fields are under data_lock
 						 * protection
 						 */
+	u64		bytes_acked;
 	u64		snd_una;
 	u64		wnd_end;
 	unsigned long	timer_ival;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index e172a5848b0d..fa5055d5b029 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -889,7 +889,9 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
+	struct sock *sk = (struct sock *)msk;
 	u32 flags = 0;
+	bool slow;
 
 	memset(info, 0, sizeof(*info));
 
@@ -898,6 +900,9 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_add_addr_accepted = READ_ONCE(msk->pm.add_addr_accepted);
 	info->mptcpi_local_addr_used = READ_ONCE(msk->pm.local_addr_used);
 
+	if (inet_sk_state_load(sk) == TCP_LISTEN)
+		return;
+
 	/* The following limits only make sense for the in-kernel PM */
 	if (mptcp_pm_is_kernel(msk)) {
 		info->mptcpi_subflows_max =
@@ -915,11 +920,21 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	if (READ_ONCE(msk->can_ack))
 		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
 	info->mptcpi_flags = flags;
-	info->mptcpi_token = READ_ONCE(msk->token);
-	info->mptcpi_write_seq = READ_ONCE(msk->write_seq);
-	info->mptcpi_snd_una = READ_ONCE(msk->snd_una);
-	info->mptcpi_rcv_nxt = READ_ONCE(msk->ack_seq);
-	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
+	mptcp_data_lock(sk);
+	info->mptcpi_snd_una = msk->snd_una;
+	info->mptcpi_rcv_nxt = msk->ack_seq;
+	info->mptcpi_bytes_acked = msk->bytes_acked;
+	mptcp_data_unlock(sk);
+
+	slow = lock_sock_fast(sk);
+	info->mptcpi_csum_enabled = msk->csum_enabled;
+	info->mptcpi_token = msk->token;
+	info->mptcpi_write_seq = msk->write_seq;
+	info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
+	info->mptcpi_bytes_sent = msk->bytes_sent;
+	info->mptcpi_bytes_received = msk->bytes_received;
+	info->mptcpi_bytes_retrans = msk->bytes_retrans;
+	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
 

-- 
2.40.1


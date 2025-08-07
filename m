Return-Path: <linux-kselftest+bounces-38531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E780B1DFCB
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 01:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491CB72308C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 23:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99C5242D6E;
	Thu,  7 Aug 2025 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwR1KqbM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0D1946AA;
	Thu,  7 Aug 2025 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754609354; cv=none; b=lUq6YJ7QiayseShd5Kbr14wfIE5N988Uf00hdWkQ7OUsaOEdbuAjBsI0M16DT7kTolpWcfUD0G8reRm9cNm0dNVEIIMvruJk86shCrZ7TVn5n/kWsWJWBImIy/z09SDqgQFRJX51cuahKC6qpv4Y7W4Pim+MJiSLGgoKjV234hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754609354; c=relaxed/simple;
	bh=PhDpiyL0MBpJa7eaWVLsZ/q8aJ7n9LWGGzQBtX3leTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jDEfIghr+BQDQ9w74E93VzcQCfHrgHv/nZV6IdGl6bhvLBVJwCKpsAh0LdUBG46f8+yEcynHN+8edRO00OM+9e+2DSMb2LwvZK6Qg3jxmdWqt5hHLUrfeSTX895KHZP7rV+ukk+b9LVryiayyAU0ftzVVUS5w9zWqFhhCR8NqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwR1KqbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36744C4CEEB;
	Thu,  7 Aug 2025 23:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754609353;
	bh=PhDpiyL0MBpJa7eaWVLsZ/q8aJ7n9LWGGzQBtX3leTI=;
	h=From:To:Cc:Subject:Date:From;
	b=dwR1KqbMjdUu8aMe/X5dL7K0vv+K32lbbX/yc08LxPTNwlGtkVUzsfWqvwMdXaKLV
	 elDgNZXtyS/xd2sAp4vTKxxkOOHicD/CsUwmO7lK3FblWJJxftiRbCHj0mgyoPF2k+
	 QdFFfawd5Gt24mDOuD0zmzK4kIGDlZ7PbRiQa8NxNI7KBY1gfHN8LhVzlJGIDragc3
	 jU7qlXNrqgnsqbtz64ut3YGuGXCcF9ghP1eNV2UNg/XYR58CEETQMbvyfnsniQVzXP
	 1jmPtd48YmZcpblTcNqj7MJ+s8it2S/1i4cXnJ/SAE9uaiOq0ftdy1TzNPzhQC7bOE
	 +K4GTT6gKleKw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	sd@queasysnail.net,
	will@willsroot.io,
	savy@syst3mfailure.io,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 1/2] tls: handle data disappearing from under the TLS ULP
Date: Thu,  7 Aug 2025 16:29:06 -0700
Message-ID: <20250807232907.600366-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TLS expects that it owns the receive queue of the TCP socket.
This cannot be guaranteed in case the reader of the TCP socket
entered before the TLS ULP was installed, or uses some non-standard
read API (eg. zerocopy ones). Replace the WARN_ON() and a buggy
early exit (which leaves anchor pointing to a freed skb) with real
error handling. Wipe the parsing state and tell the reader to retry.

We already reload the anchor every time we (re)acquire the socket lock,
so the only condition we need to avoid is an out of bounds read
(not having enough bytes in the socket for previously parsed record len).

If some data was read from under TLS but there's enough in the queue
we'll reload and decrypt what is most likely not a valid TLS record.
Leading to some undefined behavior from TLS perspective (corrupting
a stream? missing an alert? missing an attack?) but no kernel crash
should take place.

Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Link: https://lore.kernel.org/tFjq_kf7sWIG3A7CrCg_egb8CVsT_gsmHAK0_wxDPJXfIzxFAMxqmLwp3MlU5EHiet0AwwJldaaFdgyHpeIUCS-3m3llsmRzp9xIOBR4lAI=@syst3mfailure.io
Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix the reporter tags
 - drop the copied_seq nonsense, just correct the error handling
v1: https://lore.kernel.org/20250806180510.3656677-1-kuba@kernel.org
---
 net/tls/tls.h      |  2 +-
 net/tls/tls_strp.c | 11 ++++++++---
 net/tls/tls_sw.c   |  3 ++-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 774859b63f0d..4e077068e6d9 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -196,7 +196,7 @@ void tls_strp_msg_done(struct tls_strparser *strp);
 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb);
 void tls_rx_msg_ready(struct tls_strparser *strp);
 
-void tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh);
+bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh);
 int tls_strp_msg_cow(struct tls_sw_context_rx *ctx);
 struct sk_buff *tls_strp_msg_detach(struct tls_sw_context_rx *ctx);
 int tls_strp_msg_hold(struct tls_strparser *strp, struct sk_buff_head *dst);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 095cf31bae0b..d71643b494a1 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -475,7 +475,7 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 	strp->stm.offset = offset;
 }
 
-void tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
+bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 {
 	struct strp_msg *rxm;
 	struct tls_msg *tlm;
@@ -484,8 +484,11 @@ void tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	DEBUG_NET_WARN_ON_ONCE(!strp->stm.full_len);
 
 	if (!strp->copy_mode && force_refresh) {
-		if (WARN_ON(tcp_inq(strp->sk) < strp->stm.full_len))
-			return;
+		if (unlikely(tcp_inq(strp->sk) < strp->stm.full_len)) {
+			WRITE_ONCE(strp->msg_ready, 0);
+			memset(&strp->stm, 0, sizeof(strp->stm));
+			return false;
+		}
 
 		tls_strp_load_anchor_with_queue(strp, strp->stm.full_len);
 	}
@@ -495,6 +498,8 @@ void tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	rxm->offset	= strp->stm.offset;
 	tlm = tls_msg(strp->anchor);
 	tlm->control	= strp->mark;
+
+	return true;
 }
 
 /* Called with lock held on lower socket */
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 549d1ea01a72..51c98a007dda 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1384,7 +1384,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 			return sock_intr_errno(timeo);
 	}
 
-	tls_strp_msg_load(&ctx->strp, released);
+	if (unlikely(!tls_strp_msg_load(&ctx->strp, released)))
+		return tls_rx_rec_wait(sk, psock, nonblock, false);
 
 	return 1;
 }
-- 
2.50.1



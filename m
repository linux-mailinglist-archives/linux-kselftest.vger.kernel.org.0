Return-Path: <linux-kselftest+bounces-38404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E21B1CB9E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 20:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EC5627D01
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 18:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E128F527;
	Wed,  6 Aug 2025 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frUhvRzo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A4A1F0E26;
	Wed,  6 Aug 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503522; cv=none; b=BMAJdB8z/m1deBSt267eVxr3JLi0S6ra4lctSyWVGs0V5NeqJI+lAER6t1OOCJE5lS7qpzIV5ui299+mb69QcgzjpsQ3rzFEAXxX5+6ac3OI3BEHnguVqh563lzDVH9QVgMLVkkc1U4OpE5eZtwigJ+yzyHZHerDd8lyIld6G9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503522; c=relaxed/simple;
	bh=4IfnMOyTeOfVPPAE9IFm78vwRCPtzhBc0cuIDUEVNeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCrWP1KlFuqZNYfaYm1iwCN9xkYEUbUdBvhXw46feO7cvM8UnHgiGze4U+OPXYJVYkpOKCF4KSATI++++hTwhp3cjAgxaTPYNmbgVLWIKC+GoogImaNNi+3Pae44EDNwFq9wtU6XNAYlm71bWhcCGcwGddSZmRcLKQqwd1U+6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frUhvRzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064E8C4CEE7;
	Wed,  6 Aug 2025 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754503521;
	bh=4IfnMOyTeOfVPPAE9IFm78vwRCPtzhBc0cuIDUEVNeo=;
	h=From:To:Cc:Subject:Date:From;
	b=frUhvRzotcVwIu2NCDKRHt8tE3eN5sUV2qZI7YDZ0HQCTI4/WL2RqAWTBHXieoWY8
	 lSUNl5/+HH1UKLmjLpbS9nXeZvgGLIukQnWeumDcvj8nCLiX9qw4b2jM+prVRpzZ7I
	 u24tUOwP5cj1HR6znL9Q5ZNWRw54b4D/5TTomM7iyRSxDSN7nZzK1B4NedCcEsehki
	 V1eWEPA2PmrvJUhbrTSJidfP1h3Tpt8k5v0F6st3Y+hbKjmNn3Rx4bR81Qq5rEbcyx
	 K+P6RECOx4PUsfz0tETL3ev41vWrBDEd3XUoLi0gMXgUJ4A1pu+Hfib9rTvlTJaLzn
	 MtXMMVAevkQoQ==
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
Subject: [PATCH net 1/2] tls: handle data disappearing from under the TLS ULP
Date: Wed,  6 Aug 2025 11:05:09 -0700
Message-ID: <20250806180510.3656677-1-kuba@kernel.org>
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
read API (eg. zerocopy ones). Make sure that the TCP sequence
numbers match between ->data_ready and ->recvmsg, otherwise
don't trust the work that ->data_ready has done.

Signed-off-by: William Liu <will@willsroot.io>
Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
Link: https://lore.kernel.org/tFjq_kf7sWIG3A7CrCg_egb8CVsT_gsmHAK0_wxDPJXfIzxFAMxqmLwp3MlU5EHiet0AwwJldaaFdgyHpeIUCS-3m3llsmRzp9xIOBR4lAI=@syst3mfailure.io
Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/tls.h  |  1 +
 net/tls/tls.h      |  2 +-
 net/tls/tls_strp.c | 17 ++++++++++++++---
 net/tls/tls_sw.c   |  3 ++-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..37344a39e4c9 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -117,6 +117,7 @@ struct tls_strparser {
 	bool msg_ready;
 
 	struct strp_msg stm;
+	u32 copied_seq;
 
 	struct sk_buff *anchor;
 	struct work_struct work;
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
index 095cf31bae0b..4bac58174cc3 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -473,9 +473,11 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 	strp->anchor->destructor = NULL;
 
 	strp->stm.offset = offset;
+
+	strp->copied_seq = tp->copied_seq;
 }
 
-void tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
+bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 {
 	struct strp_msg *rxm;
 	struct tls_msg *tlm;
@@ -484,8 +486,15 @@ void tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	DEBUG_NET_WARN_ON_ONCE(!strp->stm.full_len);
 
 	if (!strp->copy_mode && force_refresh) {
-		if (WARN_ON(tcp_inq(strp->sk) < strp->stm.full_len))
-			return;
+		struct tcp_sock *tp = tcp_sk(strp->sk);
+
+		if (unlikely(strp->copied_seq != tp->copied_seq ||
+			     WARN_ON(tcp_inq(strp->sk) < strp->stm.full_len))) {
+
+			WRITE_ONCE(strp->msg_ready, 0);
+			memset(&strp->stm, 0, sizeof(strp->stm));
+			return false;
+		}
 
 		tls_strp_load_anchor_with_queue(strp, strp->stm.full_len);
 	}
@@ -495,6 +504,8 @@ void tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
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



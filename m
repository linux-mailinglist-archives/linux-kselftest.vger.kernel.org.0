Return-Path: <linux-kselftest+bounces-42538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584FABA5CD7
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE47B01AE
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608ED2DAFC7;
	Sat, 27 Sep 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOgZ8njG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348A2DAFBB;
	Sat, 27 Sep 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966077; cv=none; b=bMHw+Ms7sTPsNZoh1qjzzRutHHmFOPKlTy8Rg8O3Ru0gIWqo9kcrXhXVgAU22VGx1x7e0DzVNfU2olwhBcydbteC+LsHBwyM3UXoHXeLyUqR0ImxxEY5WwSmAcS8wZZH5tAQUhZnO8iF8jJP9jh8cUTDqawAUTGAJsC9PVxk8Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966077; c=relaxed/simple;
	bh=9mt8KfJKIMQ13MUY35/9cKBcT7o986AsKAS51TAODCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C53gdxvO4hC6twn46C6u2VxiwBcP8+XelJUenzkOj/f3JJJBl9dqwS3yxG/clIHzcS5W+YQa556lW1yQ4XCUHv3hbZiqdIJ2J0bdlDMqkf+lXncTpnsDnkPOIwvKMvVicM5FTStDHC/ycQ8X+f5IsYgrWtIBhpwwsEhDNTDCNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOgZ8njG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08BCC113CF;
	Sat, 27 Sep 2025 09:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758966076;
	bh=9mt8KfJKIMQ13MUY35/9cKBcT7o986AsKAS51TAODCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UOgZ8njGt+hhafvOEcWt54w3x50UEczYm5DKsIhSWOxm5y1RQkzcY6BCzxd8OWQ8w
	 n5YG5q0PuhkB9WuFe68WpCdGVzU4Ok2K4lj0OdWV/uZ8WDD0XAtKUIcn4geYGJ23Wq
	 DpteTwLEqR8kDWCci6cEZEunENJUgqUXgDBFY5rDFQOm3w7BWp/u+bUQQBh3yzlZwe
	 bLIdzaTBSA3SqJ6obfESEnYtKpe7veuZu/GVGBoOYl4Aar1/GpyR2MYQcKS6EzXKdo
	 e0m/x2MhG40GyrQ/fhSKsOt6NzICrXqeLb1f5DORgwZiW4KcE8zQ3BlLmBSZI2dTQ1
	 Kh6cCrkkUYwKQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Sep 2025 11:40:42 +0200
Subject: [PATCH net-next 6/8] mptcp: factor out a basic skb coalesce helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-net-next-mptcp-rcv-path-imp-v1-6-5da266aa9c1a@kernel.org>
References: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
In-Reply-To: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FfUYIQjt+din4REyT+qPpnRa3kuyz2Y3/Dt+IRN2mzA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKub1Q+q3yszmnfY90OqXZ15+3TG92bJOcJtVxRbTJTe
 r58hdznjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImUBzIyvFQ8JlXxf+f0dZWn
 L35karXcFC1mc9v86vmFXr3zvlnFxDH8s+LtuPKRb4lwlf1Mdiuu2g1MRkbVDy+dTLr4X93/ttI
 KBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The upcoming patch will introduced backlog processing for MPTCP
socket, and we want to leverage coalescing in such data path.

Factor out the relevant bits not touching memory accounting to
deal with such use-case.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 26fbd9f6a3f7802c428e79c7f4e1da45aa9533e5..da21f1807729acdb7d9427a399af66286ed125e2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -142,22 +142,33 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 }
 
-static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
-			       struct sk_buff *from)
+static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
+				 struct sk_buff *from, bool *fragstolen,
+				 int *delta)
 {
-	bool fragstolen;
-	int delta;
+	int limit = READ_ONCE(sk->sk_rcvbuf);
 
 	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
 	    MPTCP_SKB_CB(from)->offset ||
-	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
-	    !skb_try_coalesce(to, from, &fragstolen, &delta))
+	    ((to->len + from->len) > (limit >> 3)) ||
+	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
 
 	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
+	return true;
+}
+
+static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
+			       struct sk_buff *from)
+{
+	bool fragstolen;
+	int delta;
+
+	if (!__mptcp_try_coalesce(sk, to, from, &fragstolen, &delta))
+		return false;
 
 	/* note the fwd memory can reach a negative value after accounting
 	 * for the delta, but the later skb free will restore a non

-- 
2.51.0



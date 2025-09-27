Return-Path: <linux-kselftest+bounces-42533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34279BA5CAD
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35436189E215
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 09:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E41F2D7DCC;
	Sat, 27 Sep 2025 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMGWv525"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C0224B09;
	Sat, 27 Sep 2025 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966061; cv=none; b=JPHqv/LNWg13SJ+mmJA0FKncJWbTfzl7pIaBk8bukUMLeJO5jGyNG+WvpewuPHvHhamNMiC7cyk4Op61t8FVDOcXcwk+MA5+oLIvs8TqAjBXJvLli7FhOZSwcEgpG9V5xOGVFAGwcwRUagMypUU4Be1HBmI8Ak2qZEcgJOsD/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966061; c=relaxed/simple;
	bh=Qvnazvu8KZikS34bBexFFn3chd1rnQLQENq0ho6H0Lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TDXD2lcigdsTuLBo97e+gLcmZaQbu2Af9v3Lf3lrER37ILPOOnvpKKa/z6g8kPp/y1yTPER38Nopn3Il8zft5QybOPKehLkUbOYujieHrH9/akbJHeYlU+7c0Sg3DoCqJrGXdz+STPbi7Y8iBwR160q0XyAT5pqr7wsTSURV6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMGWv525; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D67C4CEE7;
	Sat, 27 Sep 2025 09:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758966060;
	bh=Qvnazvu8KZikS34bBexFFn3chd1rnQLQENq0ho6H0Lg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PMGWv525G1cBT/PWPGBD1SSVr23udDZGi8tJpKnmbOkP6QJt7rje+khJJb2/k656u
	 yhdfvK2gtUdeJQnGkxG3tD9ViKOmal89QcTHCMAMtVSSdtYq+hRoBqC4Y60orlEu/o
	 mEVTAV2LcWzQA47ruq7zCe+CX9xyngYD8LnMggXVingtTBQTMV0Oznk5xuhlWEQ8Ji
	 OMeTWxAa6PP8bQJ//uRgN9g/PgwiESF7wTxrpbVukJX3e/UM+/XgkWBSgeprhYo7sO
	 DTgTlngBzjXxrHoM231JCZr/W3TxQzQfHQTz3/7PcGXMJ0TQOmy39Sbgeg3bucJBfz
	 hgnoMTBqdqFIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Sep 2025 11:40:37 +0200
Subject: [PATCH net-next 1/8] mptcp: leverage skb deferral free
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-net-next-mptcp-rcv-path-imp-v1-1-5da266aa9c1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2Aa8iooFY/lXVq8j36OdaPl/LXwvC0m91FKw8nQsJZ4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKub5S5o1RqLfDH+nON7+4n23Y+OvF5xT9/R4fne1Z55
 f+U1jxu3lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRDX6MDG2FRycdednQGqzx
 Pc5OfmrhTL0gq18nRaXkaooDTT/0dTAyrMx4NM3v3sazjVrpTd8e+0ptdE6Wb74cUeiga38gJWg
 vDwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Usage of the skb deferral API is straight-forward; with multiple
subflows actives this allow moving part of the received application
load into multiple CPUs.

Also fix a typo in the related comment.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 735a209d40725f077de1056de5e1c64ffec77f55..62cdd2bcff9da12783b97fd40813ede85b5c83d9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1943,12 +1943,13 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		}
 
 		if (!(flags & MSG_PEEK)) {
-			/* avoid the indirect call, we know the destructor is sock_wfree */
+			/* avoid the indirect call, we know the destructor is sock_rfree */
 			skb->destructor = NULL;
+			skb->sk = NULL;
 			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 			sk_mem_uncharge(sk, skb->truesize);
 			__skb_unlink(skb, &sk->sk_receive_queue);
-			__kfree_skb(skb);
+			skb_attempt_defer_free(skb);
 			msk->bytes_consumed += count;
 		}
 

-- 
2.51.0



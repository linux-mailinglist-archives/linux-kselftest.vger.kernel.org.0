Return-Path: <linux-kselftest+bounces-29884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9678A74CA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 15:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCBB3A44B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED7421764B;
	Fri, 28 Mar 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTFnvJ1N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC51C4609;
	Fri, 28 Mar 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172090; cv=none; b=TTjjOmaPIo9UTHHYERxJfjQhqy7W2SkZZRbUsydLJU0yzC17relSKncRiSZddKupYAtCzoUJMpMR4oNuGTAEu7eCYIDCUWBOKP9nDtAWkjtTkOIac+NxH/GjIXhAjqMBUkloFY8PbUJgG0LdDuy0YQUM6OQwjf1CLlrFq3Qrebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172090; c=relaxed/simple;
	bh=awEuvFGtpL0MNDNIG1y3EbcEixXwlA0kAeb844a7YbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YrxanjPBCTMx6ppCzDp189H9UEhePQRojcbzVy/daz+KOxqKdWJKZMwuXDj4bUCiAxmGzCrSijpVIfP0vXOwKrsOk64dDYJxMV1JxFhftSMi/I1Z+ghQ2sHj0fEQLM2BGp8PYvceOzrqEFsCQ3UWZRuljPPFZSJ/cm486X4ZGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTFnvJ1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C708AC4CEED;
	Fri, 28 Mar 2025 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743172089;
	bh=awEuvFGtpL0MNDNIG1y3EbcEixXwlA0kAeb844a7YbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YTFnvJ1N0/b1vAO66PXbpqwCWYd66vqwf8s0Mt/SvS+Vqebc9zeBjcI+mSs5uFXto
	 uUid1PpRifdHp403pB2SmWFVTeSySKXXACRDVctj5slzeRje6MfH5SfhWGbWEKjL7L
	 J6Qjt5AtbNr0DeyD2RM0b+dbsI72SlZbj6XsMBmE+YzJGZHl6sHFG7/hg+ga1DfA06
	 0niXuXppnAoOBxU/uRBto9yF4Au5Mw6sGmjiOti49SUpKqBuu8fTtSTbtB+M4L7eLM
	 iU4EV+dEJBiKEfGtyobhVJ/2gEiqKOcA+fOXznZMkX25xTmpVBh4fnwcb/5WiYui0W
	 suYJ0Gq2w6CXg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Mar 2025 15:27:16 +0100
Subject: [PATCH net 1/4] mptcp: fix NULL pointer in can_accept_new_subflow
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-net-mptcp-misc-fixes-6-15-v1-1-34161a482a7f@kernel.org>
References: <20250328-net-mptcp-misc-fixes-6-15-v1-0-34161a482a7f@kernel.org>
In-Reply-To: <20250328-net-mptcp-misc-fixes-6-15-v1-0-34161a482a7f@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, Shuah Khan <shuah@kernel.org>, 
 Dmytro Shytyi <dmytro@shytyi.net>, Gang Yan <yangang@kylinos.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3226; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vzugoolZfElAHOE2QlY156jFm2862QpuAvKqHC67q0k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn5rHs0x3onJRwijrAj23vtbDAMHIUqriAsYEgS
 047nkrOm2yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ+ax7AAKCRD2t4JPQmmg
 cxXZD/9XVTwvr6jRlUHzXWoJXNFpjEmFoAmYtzGVtbJ/teyt5CkFX2DforBfX0FrLHRqqVGc6OO
 CqNKRSfHryPlAB+yHLlHp9rySZNpP7w5cxUdrTADFMc13pScKaDxXsEijArr8KtHZ6r0h6f4Cze
 TqEWXuHx7TbEj19yn/p51N2dL35akIBpay+ivcUe/C8qpLGYdedJvQKMHl2Mv3/IMaxAlsr38Kh
 AY/aLIr9HskeG0JMrdYRX2nhqATa+IjeLn4924XtQ1TZ0VnoP1E6ZJQiaNK8aLcouafchJ6ZpvC
 SMbMEO5nFR2fOFNTWoT5WLMC7+Oe/sUa6H8Og1nqcHg3QyUwMn/oNKb0BqEka5rowQ4bK31AH07
 YDF++JUatOPc0Rlde9Uh2WGUTtYey/Oht6CMpUZeBa8p08qZ8Dr9iQFQU2NS4+8hvp2B2BZ5ar5
 ghw5A65UaUWfK/7V6nB4a8Pk+CzUm48yQKPhIdEEAFG8UxmAAerOoApQzuBJow9v+1IqgeyIV/2
 sX8bhfTY3Dw5a1OFSPAEK8tuECV6BMFmSoxDZYD3g0o9F9BXRd5ypHobX1Ru4fkGJ5/ZsRe7zH0
 6tuWlRBfntB2u7uxxwNPNjfbHM6spiEZcb4eEpRyC+SQLfW35rTyspN8Hs7V2vIf1RMxsuRMRPo
 ORLlN7MWf6aFboA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

When testing valkey benchmark tool with MPTCP, the kernel panics in
'mptcp_can_accept_new_subflow' because subflow_req->msk is NULL.

Call trace:

  mptcp_can_accept_new_subflow (./net/mptcp/subflow.c:63 (discriminator 4)) (P)
  subflow_syn_recv_sock (./net/mptcp/subflow.c:854)
  tcp_check_req (./net/ipv4/tcp_minisocks.c:863)
  tcp_v4_rcv (./net/ipv4/tcp_ipv4.c:2268)
  ip_protocol_deliver_rcu (./net/ipv4/ip_input.c:207)
  ip_local_deliver_finish (./net/ipv4/ip_input.c:234)
  ip_local_deliver (./net/ipv4/ip_input.c:254)
  ip_rcv_finish (./net/ipv4/ip_input.c:449)
  ...

According to the debug log, the same req received two SYN-ACK in a very
short time, very likely because the client retransmits the syn ack due
to multiple reasons.

Even if the packets are transmitted with a relevant time interval, they
can be processed by the server on different CPUs concurrently). The
'subflow_req->msk' ownership is transferred to the subflow the first,
and there will be a risk of a null pointer dereference here.

This patch fixes this issue by moving the 'subflow_req->msk' under the
`own_req == true` conditional.

Note that the !msk check in subflow_hmac_valid() can be dropped, because
the same check already exists under the own_req mpj branch where the
code has been moved to.

Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index efe8d86496dbd06a3c4cae6ffc6462e43e42c959..409bd415ef1d190d5599658d01323ad8c8a9be93 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -754,8 +754,6 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 
 	subflow_req = mptcp_subflow_rsk(req);
 	msk = subflow_req->msk;
-	if (!msk)
-		return false;
 
 	subflow_generate_hmac(READ_ONCE(msk->remote_key),
 			      READ_ONCE(msk->local_key),
@@ -850,12 +848,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK) ||
-		    !subflow_hmac_valid(req, &mp_opt) ||
-		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
-			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK))
 			fallback = true;
-		}
 	}
 
 create_child:
@@ -905,6 +899,13 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
+			if (!subflow_hmac_valid(req, &mp_opt) ||
+			    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				goto dispose_child;
+			}
+
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
 			ctx->conn = (struct sock *)owner;

-- 
2.48.1



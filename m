Return-Path: <linux-kselftest+bounces-30275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A32A7EBEE
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610DE42205C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 18:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A74D25C700;
	Mon,  7 Apr 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZBJ9NM3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726625C6F9;
	Mon,  7 Apr 2025 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050407; cv=none; b=lz+BCaiNxkPhv1mQ6/258apA71ma3ybvslr84UvpzxxZu3XKgQBR1r8Bb4U/AUgTaEH33tJqFQ7UQL/0yu9/TciCpm4QamvF5c9geujV7r5WjLIISclc/GodOD3wwtAvmcqcbN8MGh3YgZO0kKQO9Cv11G/ycKxcycUHshsxIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050407; c=relaxed/simple;
	bh=my44JkBQUrZFCTqjr+cn/V5Xo1O37kTeQkRztUijvZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+YbanH3pOQwB70spVP26AcaOIQjr5/T6W6smZJlCTqN/bsrGrM4PRrukDYbmvd14/1b/Inf6A2YHCwRYCvwktQPPnI396uVGhUbX0NwwO+67J/mOd6dJWXLtnt4+G1RIdGvSikB4QiwevArq2UvJGB2gJd7qlPQG/Cg40i47Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZBJ9NM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9C3C4CEEA;
	Mon,  7 Apr 2025 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744050406;
	bh=my44JkBQUrZFCTqjr+cn/V5Xo1O37kTeQkRztUijvZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IZBJ9NM3+yHRfbOcig2Bb5DSBUFYbwZXse4YBfqcc2BdVQ8WnCM467h4SyJ1d++Ql
	 SeNDGGJqwq+/VedyUJU0xiUQch7JXll/62HHV2kboWVC7g08qmVP9+N46EE4eLv1lO
	 L+dKHUoDNNTd3n7ifb8Y3CfqzmhuUZRehg9dVqN98T5B0/cY3o4hLG8MA05U7P7sEK
	 4pWDawxgnWcOGnuI15fhTvHNbHZshfUMHFPAEA1TtrolB5MZcFwQnep8/VZ+r5MOWQ
	 79nkBvLdKGhmhsQeC/rAnH5tO3AtjAIJ20xHkhvuS/UgJjQYxT/8dSd3yNC0CUMEdN
	 50PHObjqsQH7w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 07 Apr 2025 20:26:32 +0200
Subject: [PATCH net 1/2] mptcp: only inc MPJoinAckHMacFailure for HMAC
 failures
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-net-mptcp-hmac-failure-mib-v1-1-3c9ecd0a3a50@kernel.org>
References: <20250407-net-mptcp-hmac-failure-mib-v1-0-3c9ecd0a3a50@kernel.org>
In-Reply-To: <20250407-net-mptcp-hmac-failure-mib-v1-0-3c9ecd0a3a50@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=my44JkBQUrZFCTqjr+cn/V5Xo1O37kTeQkRztUijvZA=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn9BjfdcPcR8ejqJ0eKPI+vh+6AFLlsn9/FSiUa
 ASA1amNz5CJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/QY3wAKCRD2t4JPQmmg
 c03oEACpvkhJfy6cY1IFPv9T1sWTPa6PzEBbw7S3qcYXNCd2Qj5LDGS9NYtnKFYG4R+eNL3+Knf
 PM4g+MSMZnbODOpBInOKrX3vqObkx6/MScQLPWR2YUYO2fDnTtbdH/eInnt1fDq73L73aK0P645
 xTf79EU4V/owSHXHKmYLkiMptGnI4GrzhqLXhnMcxQAAIE5IBMBP10RhUR9D+BCeDnLNFWvE9AZ
 KdviL4J2tyxyHlpU/ViEQnTdevZPazSng9xgQWZcUHBnrgajYKAmRpLjMHK8Xuqw0Ce4tLGvBkQ
 TNzYqlkAOrjw1x0QTo6ZDRNeP+iTZgEUzkpn5DWEYNyzt1Ks74yCBJGIwPP6qUO3fLILBi8oOjb
 AieFjL1CrQr2yWrKiH+soRWTxmzuKSWi7OmtzMHBwtvHeaL1pfYJ9W81PuPfd1AMu+hjsZQIEqQ
 7IRudhnM72Tf8ZhytD6f08LAS59J+nTuAP3C0TxdZ1f9ssax6SuFsjg8CvIYkaPXWzYjAmK6Mqj
 c/TsERvcyCrJl8HRLLJdPRNuv9Odt3DWDY6fn2E40JJ7ZB4HE+uOC74c4M3yUdU5fsvhftSRHEA
 Gj0GwiOHeEfv2MRM0OHIK9+6qiImKms17d/6wdY2K0ty24ud2D5XBGzZ0WEmlE0UyIBF+S0n2eC
 /1TcVgJG8ejRAzQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, during a debugging session using local MPTCP connections, I
noticed MPJoinAckHMacFailure was not zero on the server side. The
counter was in fact incremented when the PM rejected new subflows,
because the 'subflow' limit was reached.

The fix is easy, simply dissociating the two cases: only the HMAC
validation check should increase MPTCP_MIB_JOINACKMAC counter.

Fixes: 4cf8b7e48a09 ("subflow: introduce and use mptcp_can_accept_new_subflow()")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 409bd415ef1d190d5599658d01323ad8c8a9be93..24c2de1891bdf31dfe04ef2077113563aad0e666 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -899,13 +899,17 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
-			if (!subflow_hmac_valid(req, &mp_opt) ||
-			    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
+			if (!subflow_hmac_valid(req, &mp_opt)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				goto dispose_child;
 			}
 
+			if (!mptcp_can_accept_new_subflow(owner)) {
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				goto dispose_child;
+			}
+
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
 			ctx->conn = (struct sock *)owner;

-- 
2.48.1



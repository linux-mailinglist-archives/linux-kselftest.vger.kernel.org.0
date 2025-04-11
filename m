Return-Path: <linux-kselftest+bounces-30577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5C7A85B3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61479C287C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACE929B204;
	Fri, 11 Apr 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZohHZxi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8629AB1F;
	Fri, 11 Apr 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369523; cv=none; b=GWfaAuX/zTGCcM6wJvgK6ydDW/+LFBtbrQOI4f4nogSBrTbwsjSFj6/GFqV8SEh3sCyw1g2LGxW39Rf+uDvvrZueoG6QlC5rFW8SgyeW0FY2MPB78M0xWS8NrPLZZDDWqaG7tpukYXPuqcq90M9tkh4CuhZQ3DIRdAB2Gd1u06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369523; c=relaxed/simple;
	bh=Imic4Np5tJY+bphTiQqz1yPd67V0pf5uLabqu+4kVRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gONyfpvBa1lpC7rBCLIbtwNNXn/sVvaO5RL3HfI9D2GeK21L2pD+p0roY47cxQXjfu7ugQZSy7FVcmAEdXaD/+DukqBURnIp/muyugxO2SDfCaYanAJ6UI7Cnrd0b/vvUA2IKp5iRwMINLwFhpbQ2nuIqva2subBlSs981pCK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZohHZxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2005FC4CEED;
	Fri, 11 Apr 2025 11:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744369523;
	bh=Imic4Np5tJY+bphTiQqz1yPd67V0pf5uLabqu+4kVRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mZohHZxixioLJU0H2wvADL//PWI9G2yuJWQAyb7p6QuzRgujZgrQl5Aoh6s4f1Ari
	 ru/6gOE00vOuq0dScb3ytQbfXbEvb35wR1GMBBKuWc1AILx22oNQdbRYOgxsoJveSY
	 Vtlz0sS2LPseIq1vNt4B64XmOUOco/aHYDrIfSHP/h0rn3R2lGs0VmRSzb1tGtSl+b
	 0xoq/uvgnj1VUGoc8OE2/ifAo/eyOFG7IhtwTIhvNhUhssQUqL+5KiB92fowXAhrsp
	 /bM6mSyX4gpiNv3die4/pqKXIqKBpmb3zNLDQYdTJait8GIuFwUjyYlvIqbyGVXFNR
	 JmBJPOYKdwI/g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 11 Apr 2025 13:04:50 +0200
Subject: [PATCH net-next 4/8] mptcp: pass right struct to
 subflow_hmac_valid
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-4-85ac8c6654c3@kernel.org>
References: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
In-Reply-To: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Imic4Np5tJY+bphTiQqz1yPd67V0pf5uLabqu+4kVRM=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+Pdg/Zp6NBxvGY1I9MWRbCdFzE25Y7yhp1/Tu
 RZdjS1c6ZGJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/j3YAAKCRD2t4JPQmmg
 c6bhEADFSpNaznYUw/HC2ac74l+JFVUmIhtkujtyEo6Ki3MVSV2qQ415RXxSdBgbKnIqRhuN387
 /vsYY1VhiFEkHDi5gKvsh09GR49BqVMEzWMegPS01BDhoz00cZtefv4lr1Nr9a9WKe4pZ9XXH8a
 iJhqaOOU4SKxq21Nb8ngLAmzfIAGgYk32HEtgqPLMNDXtzC52AbsVKM7PbfCEa0sXxHwkOLEV7E
 gzUasQH3Rm4dvpX8Otme5M1Q2bpPtxb30gWR1t2T4kEbzjEPTPzcGgtnVimkEJrugyVbu5x+4iD
 7D+3N1NUJjOgW9RDBkBxM2WFhzKLxLsb+1ukFsh3iGLNNdbxhmtbZs0hdIIRNiaAMhqehzmJ7gK
 t/rAhhTKZsGQBhmZKqMCk1lPkOmBlEeOtp4JRfk97qtemeXpXjTg6zNw3ma152EeQpruqeY81rD
 qNNF6xAj5qXSOMZ07Ci68TGgZxFUCUXpEMiikqEIuoN7yuVRGm/kSNai141zk4QIgPnXclNj5Pe
 xG3JELQ1pYLuzeWs16aEwmo0G+1rvDuT2v9TUX4XmTHAZWPVxlOUvz/zX6/Yb73SHdWMQba3BjM
 /p6EdLLtzO+qZlPRcYGzrjIsBGUIEXl/hLa7oRYKjQDMbTuntiw1GMWYs9gm2+tkjRbIKd6fXQi
 LuDoanvRFPoA2Lw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

subflow_hmac_valid() needs to access the MPTCP socket and the subflow
request, but not the request sock that is passed in argument.

Instead, the subflow request can be directly passed to avoid getting it
via an additional cast.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 24c2de1891bdf31dfe04ef2077113563aad0e666..e7951786a97c91190c7341d2c586a1f4acc05ed5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -745,15 +745,11 @@ struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *op
 EXPORT_SYMBOL(mptcp_subflow_reqsk_alloc);
 
 /* validate hmac received in third ACK */
-static bool subflow_hmac_valid(const struct request_sock *req,
+static bool subflow_hmac_valid(const struct mptcp_subflow_request_sock *subflow_req,
 			       const struct mptcp_options_received *mp_opt)
 {
-	const struct mptcp_subflow_request_sock *subflow_req;
+	struct mptcp_sock *msk = subflow_req->msk;
 	u8 hmac[SHA256_DIGEST_SIZE];
-	struct mptcp_sock *msk;
-
-	subflow_req = mptcp_subflow_rsk(req);
-	msk = subflow_req->msk;
 
 	subflow_generate_hmac(READ_ONCE(msk->remote_key),
 			      READ_ONCE(msk->local_key),
@@ -899,7 +895,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
-			if (!subflow_hmac_valid(req, &mp_opt)) {
+			if (!subflow_hmac_valid(subflow_req, &mp_opt)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				goto dispose_child;

-- 
2.48.1



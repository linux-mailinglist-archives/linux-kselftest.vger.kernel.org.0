Return-Path: <linux-kselftest+bounces-41379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74E7B54E7A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1923B3E08
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C033093DB;
	Fri, 12 Sep 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYj3Ztfz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9692DC77B;
	Fri, 12 Sep 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681586; cv=none; b=Dirhg5um9sk3nB6xXVaqEzO6YRKjCNHNtmV4xxy0dKPu6uB/r3ZLhMIQO0YraHCrH14JHtvdfl8SkKUNB9Gz9789h38iFXHr3zNmWLik3t7pl7T8TGHlrZwd8vhDD/wWvI/VsY9E9UAvX0NoygkcEOLiILmFBsRrDJLzDdl2zpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681586; c=relaxed/simple;
	bh=O2z45ZEVtTEuSoxtLydb6a4AKStyGDHYl0hsAlKSGCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ufz3MQX7Llu9Zbi/7ikTFc9yulyYVmRmEQMgSO/v1WnQjgtNTrdRxARBEk5W/o0e8itzCfWZv+UlaIAjl3BWSkbZLvZa4xtXw9IaOctj0n/hqSLhPNWpJYQaGYqyzpgja4OAUHgS2oTZX44QKz6MD+4JObkUhCCEMQeIpnCgQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYj3Ztfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB78C4CEFB;
	Fri, 12 Sep 2025 12:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757681585;
	bh=O2z45ZEVtTEuSoxtLydb6a4AKStyGDHYl0hsAlKSGCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FYj3ZtfzRypQNAoMM3zAGa0TQ8MCzpQX2kftMKSO83Qa9vU+23fCBsLgf0f1nrSRQ
	 TrD1QFQ05a1VCSCMw2kxptEms+SywCqrMwyCwVs5ovsERuA5ogMdLO52KbnFNlQ9lF
	 PeBm2UWr7b5xrfcKhtl4Q8SRtK4iMoln3z8PY/F+xxEh+316vlWPacRSJxe6WH5f8D
	 Vpv1JcmzK7h3E6QNMFTRzzKiv3Eb6GLycESWYaA9PMPUS4PrPujDJ3O5dcO9NikT1n
	 XI5OPekA81nAftiPXPC1KO3X6nmEdzI16WmAdivrO6tXGcKcCqK6WQIjUS+1/n+2UT
	 15oyor+MVhqEA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 14:52:20 +0200
Subject: [PATCH net 1/5] mptcp: set remote_deny_join_id0 on SYN recv
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-1-40171884ade8@kernel.org>
References: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
In-Reply-To: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Kishen Maloor <kishen.maloor@intel.com>, 
 Shuah Khan <shuah@kernel.org>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O2z45ZEVtTEuSoxtLydb6a4AKStyGDHYl0hsAlKSGCM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOiC89v0T9ckjg5MSSh9Ivrr51PlfzPH/T/uAVBgmii
 /LdnHkNOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbyO4iR4VoNk2NqWUmRBZsm
 H/ubf+Weynd2GyZIvJg7V7X+j1cnJ8M/7UBJ/2UnTzz3+u9ef/RMxf0ll8psfy/nZ6r9fkpg9tk
 nfAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a SYN containing the 'C' flag (deny join id0) was received, this
piece of information was not propagated to the path-manager.

Even if this flag is mainly set on the server side, a client can also
tell the server it cannot try to establish new subflows to the client's
initial IP address and port. The server's PM should then record such
info when received, and before sending events about the new connection.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3f1b62a9fe889ab1ac07f2a210b9de050436b37e..f31a3a79531a2e160598111d3b0765eee2e599fb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -883,6 +883,10 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 			ctx->subflow_id = 1;
 			owner = mptcp_sk(ctx->conn);
+
+			if (mp_opt.deny_join_id0)
+				WRITE_ONCE(owner->pm.remote_deny_join_id0, true);
+
 			mptcp_pm_new_connection(owner, child, 1);
 
 			/* with OoO packets we can reach here without ingress

-- 
2.51.0



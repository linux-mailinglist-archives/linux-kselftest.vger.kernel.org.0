Return-Path: <linux-kselftest+bounces-43601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69B5BF38CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45BB3A7229
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 20:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B23346BA;
	Mon, 20 Oct 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbzBe1i7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6A33468F;
	Mon, 20 Oct 2025 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993632; cv=none; b=CLv+it9Px/PVW7kz66Y/2zML3zQk+IENK0q6slNOmV0zyIVFaGGhI7k6SXAb2KvYAhwHXG9L64MLBJPEfqeOPDI8PA7Lfmz27RiisvIi0xlNQ1v53c2s/BSHQjG4uY85F1Vly28YqX3BO91ISuwsMdwfb1cWRlDYjwP9JU+D1+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993632; c=relaxed/simple;
	bh=lbxVN5XeAG7DYcSl4ZfWs3aOTME+7P56iQKAJu77YPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6fHMqWgsyMPcpWn7SJw3kwWd7hxiNTyNi/h0KFw5Yn18v4HJXHYv9UbwPvUNd4dwTNPAOuuCIRlD3T/yUfNgMhYfkkoM3BLScGAT30ckefY5z5nsf8pnQz4VRNOvkXYKOfzO2uPgfbqB8pKMnFRmHgzQjjQOFPck9tAwKQtteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbzBe1i7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE809C2BCC6;
	Mon, 20 Oct 2025 20:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760993631;
	bh=lbxVN5XeAG7DYcSl4ZfWs3aOTME+7P56iQKAJu77YPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JbzBe1i7wbRJaeWZQCCNs7FWlLLbIgzNVO0s9N14rUe5yLIxmjRUAf0Q1LPXRAvqt
	 txsvg9FsQwl+iI7PAgt+pksYWrMJE8B3GbOHh4q+ca8b2pGIEwoTkmA94LNc4mz+Nj
	 LxW3I15TChZKq717MvsQB4lCipmYyv2tZ1ofqz1R8aMc7s/dCqKF+i9zPzwELj9WOm
	 pfaqkFL2tRq3IXA7pcv42/qwHk54BBycfSz88+zxp7rd/qdnrlvYwWjClvnlS6m/O5
	 mjqM3J0zsQK9onl4NzKgSVMBv4H6snElXEYkkJhps+Lw0qL/TExHPdBuDq8PETERe5
	 G59xTTJDDbumw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 Oct 2025 22:53:26 +0200
Subject: [PATCH net 1/5] mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-net-mptcp-c-flag-late-add-addr-v1-1-8207030cb0e8@kernel.org>
References: <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
In-Reply-To: <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lbxVN5XeAG7DYcSl4ZfWs3aOTME+7P56iQKAJu77YPo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK+LQxeYxW/P2Pp1EbNyVfEDQW+ez9Lj3fU3Hr1oeUbI
 cOuhOdeHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO5qMLI8OyI/8x/nFcZmxS8
 z6il2v10L22ecGN11b2Hj81852+4mcTIsOnL08Jqk31zn3/Nc4if88mGLfnRLZe07PbZy1buXho
 XyA8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The special C-flag case expects the ADD_ADDR to be received when
switching to 'fully-established'. But for various reasons, the ADD_ADDR
could be sent after the "4th ACK", and the special case doesn't work.

On NIPA, the new test validating this special case for the C-flag failed
a few times, e.g.

  102 default limits, server deny join id 0
        syn rx                 [FAIL] got 0 JOIN[s] syn rx expected 2

  Server ns stats
  (...)
  MPTcpExtAddAddrTx  1
  MPTcpExtEchoAdd    1

  Client ns stats
  (...)
  MPTcpExtAddAddr    1
  MPTcpExtEchoAddTx  1

        synack rx              [FAIL] got 0 JOIN[s] synack rx expected 2
        ack rx                 [FAIL] got 0 JOIN[s] ack rx expected 2
        join Rx                [FAIL] see above
        syn tx                 [FAIL] got 0 JOIN[s] syn tx expected 2
        join Tx                [FAIL] see above

I had a suspicion about what the issue could be: the ADD_ADDR might have
been received after the switch to the 'fully-established' state. The
issue was not easy to reproduce. The packet capture shown that the
ADD_ADDR can indeed be sent with a delay, and the client would not try
to establish subflows to it as expected.

A simple fix is not to mark the endpoints as 'used' in the C-flag case,
when looking at creating subflows to the remote initial IP address and
port. In this case, there is no need to try.

Note: newly added fullmesh endpoints will still continue to be used as
expected, thanks to the conditions behind mptcp_pm_add_addr_c_flag_case.

Fixes: 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side with C-flag")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index e0f44dc232aa..2ae95476dba3 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -370,6 +370,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	}
 
 subflow:
+	/* No need to try establishing subflows to remote id0 if not allowed */
+	if (mptcp_pm_add_addr_c_flag_case(msk))
+		goto exit;
+
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < endp_subflow_max &&
 	       msk->pm.extra_subflows < limit_extra_subflows) {
@@ -401,6 +405,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			__mptcp_subflow_connect(sk, &local, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
+
+exit:
 	mptcp_pm_nl_check_work_pending(msk);
 }
 

-- 
2.51.0



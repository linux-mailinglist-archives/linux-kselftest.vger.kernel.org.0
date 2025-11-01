Return-Path: <linux-kselftest+bounces-44583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FCFC2845E
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 18:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8D61A21129
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 17:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7771B2FC009;
	Sat,  1 Nov 2025 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtXrg/Ph"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ACA2FBE1B;
	Sat,  1 Nov 2025 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762019835; cv=none; b=QLlItASY2BbOmQRw+bg6m2ojz3WGgX/GlWknK2rENV0dEhGDYO0fd0J4rT+WV9DRgov9xqI6vmry2nPf4Ol0qe9q3tDhtrgDA/DraSRSTbIQpz566yPFer5WSQr9lLAvdCxsvUGsNe60FwNNgwZWRFsmYpEouXoWEdaYWiJeJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762019835; c=relaxed/simple;
	bh=FJL2HPrgfIL22xuRMCxFhchP9t64Srg/5u4D4oykfAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fh9KNPof6+pWrK8oSPLiVENgRHIbk6lFRocKsKnnbT2HzKwJbVvC3kcxwl9bzllcvpsYK0eRfr4TM5QvD5mlme1fJKhULimp6YdM5X89pWjWqPza076FcFp7pJnsHwUxSlFLHZr5ao4ms7Tskneux9HkAk3hTXnbO+4rO0TKVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtXrg/Ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D50AC4CEFB;
	Sat,  1 Nov 2025 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762019834;
	bh=FJL2HPrgfIL22xuRMCxFhchP9t64Srg/5u4D4oykfAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LtXrg/PhUmaPeudO0vhduZUnOlrzA2CwiIVKaHDUGtqjjWrQSySEQ4GjnMtrA/34p
	 GVXk13HCeMBaJbJDWpv7h8PRiNRFuxX0HeyxGsoR1GgDVNp7j1LtZt7mqP1t6cXRsi
	 alL0YuyFjt3tD5117BYJ7fGcdqhW9G+W2Lk5v3ObvsSPo4+Zwo5wapiPVCortrKPxq
	 MdDyltMM7bW1Q+5/B92/NP/sVLswl24M9p9JorKZSAcOhxYIGsMQkK5nqLsPyM/jAt
	 j6CnECOVktAC7JCRtb/nBToeFdMLlFubGxk3UrB7LMqry5jXRxtJVp8djwLOgVJM6F
	 abaeLOToM8xMQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 01 Nov 2025 18:56:52 +0100
Subject: [PATCH net-next 2/4] mptcp: pm: in kernel: only use fullmesh endp
 if any
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-2-b4166772d6bb@kernel.org>
References: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-0-b4166772d6bb@kernel.org>
In-Reply-To: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-0-b4166772d6bb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2545; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FJL2HPrgfIL22xuRMCxFhchP9t64Srg/5u4D4oykfAA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLZPN+tr1RjfnUv9W2XrU+3RrXz4g8GuyaXXQtetKFo9
 c2ijSZCHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPxYWT4H/pozr69FufWxFTL
 vZY69v/1tlyW81Y+bE7+r7OCXqeXujMynMr82nqA5zyLwvzF+9YF/WwQZeyL1s8MPPrnzMYoKde
 NrAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Our documentation is saying that the in-kernel PM is only using fullmesh
endpoints to establish subflows to announced addresses when at least one
endpoint has a fullmesh flag. But this was not totally correct: only
fullmesh endpoints were used if at least one endpoint *from the same
address family as the received ADD_ADDR* has the fullmesh flag.

This is confusing, and it seems clearer not to have differences
depending on the address family.

So, now, when at least one MPTCP endpoint has a fullmesh flag, the local
addresses are picked from all fullmesh endpoints, which might be 0 if
there are no endpoints for the correct address family.

One selftest needs to be adapted for this behaviour change.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c                           | 10 +++-------
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  6 +++++-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index e2918c68ff02..e50721c670d0 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -609,15 +609,11 @@ fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 			 struct mptcp_pm_local *locals)
 {
 	bool c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
-	int i;
 
 	/* If there is at least one MPTCP endpoint with a fullmesh flag */
-	if (mptcp_pm_get_endp_fullmesh_max(msk)) {
-		i = fill_local_addresses_vec_fullmesh(msk, remote, locals,
-						      c_flag_case);
-		if (i)
-			return i;
-	}
+	if (mptcp_pm_get_endp_fullmesh_max(msk))
+		return fill_local_addresses_vec_fullmesh(msk, remote, locals,
+							 c_flag_case);
 
 	/* If there is at least one MPTCP endpoint with a laminar flag */
 	if (mptcp_pm_get_endp_laminar_max(msk))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 78a1aa4ecff2..e7a498dd5a46 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2952,7 +2952,11 @@ mixed_tests()
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
 		speed=slow \
 			run_tests $ns1 $ns2 dead:beef:2::1
-		chk_join_nr 1 1 1
+		if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_fullmesh_max$"; then
+			chk_join_nr 0 0 0
+		else
+			chk_join_nr 1 1 1
+		fi
 	fi
 
 	# fullmesh still tries to create all the possibly subflows with

-- 
2.51.0



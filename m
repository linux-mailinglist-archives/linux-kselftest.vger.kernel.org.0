Return-Path: <linux-kselftest+bounces-15703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DD79574B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7670E1C23FBA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BA41DF676;
	Mon, 19 Aug 2024 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfPdD7Ab"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF01DF672;
	Mon, 19 Aug 2024 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096733; cv=none; b=lluiYb0R7bzDpBXU+uN8EKU4CDEx2Gk627xamp3WbE2bBH82kpvMo2mIkDiNCEFPksLQHLUS4khjjWcuRG0cikTvLOx5BEMaHap8j1KKtx5O9X7I5mDTJ31QG8nI26mLh57enZ9sBdCgtP5LVgv7pJFQWQNDwaa59v9Bgo9W3AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096733; c=relaxed/simple;
	bh=NtVlQLPFijop5CpDR1dcSpINA0/PkFREiPlPhJDJkCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEaqUCChbJId7woI9k82VlThFKurTXJNIEx6g0pO92nY8MWnH5vbkrIR6w2Dn2mZL0pCGf5lY36maLABv52QNZ3dUggtauRAIcMdMTYsi6o0jkYKj1jWKd8RTuS5hFqhTuH6O21A3unPZ8uCKyD6s+xb+lzzGF/skPLE7IKdEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfPdD7Ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C80C32782;
	Mon, 19 Aug 2024 19:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096732;
	bh=NtVlQLPFijop5CpDR1dcSpINA0/PkFREiPlPhJDJkCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rfPdD7AbOdTIOk6LxlwjJC1n4e/jfQcR/q3nslx1FYRq3cJrm3hBv2nGPkXCTLK7M
	 IRKC3m6TOG+SjmRLWvkwa8CJ3SRTGBnMT1e1M+AIcnFOmlUHu8EcUOteXN7Tz1J7oF
	 CDcbMZUsqa8k0Auy0qux9kNUsEjYGTQZOdweAuOrve83I/99SWnHp/Ik/LK0mSTEvq
	 V0QTNUgDzCQgHYcsyC0NqssSpRa+dAUxesRE4d6hDKoksV/0OOihq7jN5SjfZeCzbu
	 dzYK2Lbeid/SBBjochFtTKyVwgQdmxufwTbiHjBea7gV/fSpR4nt3HXAoUeu/A8Sft
	 aTiB/mW3lPLaA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:20 +0200
Subject: [PATCH net 02/14] selftests: mptcp: join: check re-using ID of
 unused ADD_ADDR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-2-38035d40de5b@kernel.org>
References: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
In-Reply-To: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NtVlQLPFijop5CpDR1dcSpINA0/PkFREiPlPhJDJkCc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DSCbkW+VOhlV9gbjNgUsWpTcPkSZ3rP65LD
 FRWTteQlAyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0gAKCRD2t4JPQmmg
 cyBmD/9rcB5iwtdVpspO+LWc6zuyg0lQ9cMOAreIOUGFgqTKAE8YrHd5wQj9mwDrNyguN2NeeiZ
 fx2D6JF2AfIa1mpeHjCTM0U7J/TPzKfYH3w/yOX00D4vUYRYSSD6MTJr7V1whgCUfLMhepp7YHk
 dpitgNGlQB2YYMT7lE9FWqBvGU7LkbfWBM26iapSk+majttQys7DOosZLr6vIhClISO81Qasb2S
 tGUByP37JV/dHIcyzOFsm2cJW3rSG8OE1njgBl5tGcrSE/rMWjBNxX02R4BqlhbynG6CBOHBZrX
 wO1cMvCUrWrUzvn9U77LUSd/B1liHf4DHTrrW57ZsBJ4no15e0WOEUcNDZM6qovg3MFbAOYgjPg
 iQah4qQ0w/brrv1sqVpQRQwnxR+c0iMUcupjWEgankxhXVcwHchMJwBDBG8H4okK91HkRw5s9wo
 7q7N3iC8ykuU/dRJQ+CFcEnwXkkCj5Q/1MBbwrMvKsNLzrn6H4TI3iedBbxxtCuFXfwSZYcsnBr
 OBtTC9e0HsjB/jmzuVT+3/yAz8GsNcj1zDd3DsRnBo9K9+KgKV3nEuFOGktAs4AlT22ySszhEHS
 9ahg0gfqQEEIFc+jLvIen/RU1sKntCcpzbjVlhOlX5F3XYxOq0S33X4GgC90mPKXGDF6dWdLo30
 QTy8o6VpNY513pQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete re-add signal" to validate the previous
commit. An extra address is announced by the server, but this address
cannot be used by the client. The result is that no subflow will be
established to this address.

Later, the server will delete this extra endpoint, and set a new one,
with a valid address, but re-using the same ID. Before the previous
commit, the server would not have been able to announce this new
address.

While at it, extra checks have been added to validate the expected
numbers of MPJ, ADD_ADDR and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9ea6d698e9d3..25077ccf31d2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3601,9 +3601,11 @@ endpoint_tests()
 	# remove and re-add
 	if reset "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
@@ -3615,15 +3617,21 @@ endpoint_tests()
 		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		pm_nl_del_endpoint $ns1 2 224.0.0.1
 		sleep 0.5
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
 
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 2
-		chk_mptcp_info subflows 1 subflows 1
+		chk_subflow_nr "after re-add" 3
+		chk_mptcp_info subflows 2 subflows 2
 		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 3 3 3
+		chk_add_nr 4 4
+		chk_rm_nr 2 1 invert
 	fi
 
 }

-- 
2.45.2



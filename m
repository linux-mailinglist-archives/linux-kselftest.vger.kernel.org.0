Return-Path: <linux-kselftest+bounces-16301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E65395F5D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C702FB22219
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5991990C8;
	Mon, 26 Aug 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7LaEGB6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73D194A6C;
	Mon, 26 Aug 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687988; cv=none; b=UAXyUp2SWKecnN5nkglK3UBgCmtbrXN5J4o8lSzNqFraqXY+NrOdhD0LpHxetOPFNd4iamv+qjEBek6++0sVMr6QN33Va/R6Db0XnPnv8rH3sZN1NYdaRY0QL4qudo5m1P4rd+nD6kF9iRRGaqnWEIRgW1z5emGBN+6l1xulMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687988; c=relaxed/simple;
	bh=QjBJldRjzg2+T6Npi88LVkgmkn1gjQoFLBqrAhWQ8Kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EvjJ/J/SKwWkNJfPHIn8FdW3D9sERBV04SK2Gkl/BB4DeSQFCJQ7YjRNdAIMoRjvZ9NlftaxGzILiOwVqSIcaRwzScxLK7Wxkghij6yjnB+Po8atx/CzTI+rpZo8J2I3Atjv5+/z8sCmhs8m8aRTV82eLs5ReCL+a0hSpNiQgE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7LaEGB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A7CC52FF0;
	Mon, 26 Aug 2024 15:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687987;
	bh=QjBJldRjzg2+T6Npi88LVkgmkn1gjQoFLBqrAhWQ8Kg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P7LaEGB6zu/K7aMM79bCMQFGg/88qIrUf193QurHKZZt451zT4qM67HY92zNuZJP1
	 oYKY+ZcJOm7jJuR3uOmLcCYrk49z8Q6s1gxIVPl3O5TlHQpc2EPjYn0k+OXThDH3TX
	 cMoydydC1jSekZK7h/TsnzIrHCPkSU3KZqNsKuSMGsANOEUFklDyIVM4+CHB6z8peV
	 h97VpXxPxBfcr1HiMKKCpa/z27wi/npFHE6+4SE0hQNMqREZXW+PiCxsFLkeUnxJcO
	 8JSk70xsxdtzXbNoPcs7qCwYkIktrdiY6FC4zWzFd7xeWWlSU1lUIUelndZ0Jd6z2A
	 PNv84oqsCjg/g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:06 +0200
Subject: [PATCH net 07/15] selftests: mptcp: join: check re-adding init
 endp with != id
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-7-8cd6c87d1d6d@kernel.org>
References: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
In-Reply-To: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QjBJldRjzg2+T6Npi88LVkgmkn1gjQoFLBqrAhWQ8Kg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZWbCKTVemIPt+kSL5tK0bfNPdNsDsMkB5LJ
 coSfDBm8d2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 c4HyD/4gu8mx2MYMqmgjKNUNUfg3rYKLwPemKZT9q8b4jC0hRP53zXWvWUNv8iMIZwuPGfpRvmL
 hjBxes6LraB7m3ya1iWwJgu1vjfnMwcba0HPDqalyWpQpoLzm8htdypeapgiQJpEnrbl1tCBFZv
 w71F3mtEEU24gaU8sxUccCkqD28kWyw1oNLEv7sMTW1C5Mfu4OuBe90UpVyiJs2JEXM20NhH+ob
 tWny39jeEzyoNOBEfz4HZ8rHH59faOB2m9mXE92Q5IZvXwvyORK7YCOo0B3rYV2AKrxh9coYkeA
 tiIO8awUL2ivsJ2hcZBe+C29FmG65h0WTb7+wTxe964M1rQq9CPSf9rpkQQ28+OTuA7nluTQeBr
 oParUzkSmZJA0fafOgf5iMTQU769orO++IM/DvgIU9wdgskgY1riBXE5fmqKRev47XUb2ebIB9h
 MpXBMIeI/rxIlpM74RPtFwSNDSB/9UIqQy7yb2UzzvTLZMCP6d7kpj/p//49bDIob7fIQXcZxqP
 b283XlUcgm8dPw8HVy4PlFyEZ5+ELJaLGGTsgF9ZSx1xU7XXKjKtt6dN0tttjOFod1vNEwWzgpH
 n7qIUnm/V92187N75ggY3NYcdkqdy+7YDrxFoLsw4mjBk3SM3u4/a2Zs5B2h7GtAT/V/4tGj82j
 36KQN86Es8TMXnA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial subflow has a special local ID: 0. It is specific per
connection.

When a global endpoint is deleted and re-added later, it can have a
different ID, but the kernel should still use the ID 0 if it corresponds
to the initial address.

This test validates this behaviour: the endpoint linked to the initial
subflow is removed, and re-added with a different ID.

Note that removing the initial subflow will not decrement the 'subflows'
counters, which corresponds to the *additional* subflows. On the other
hand, when the same endpoint is re-added, it will increment this
counter, as it will be seen as an additional subflow this time.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d2dd48a539c5..0fd4bd609565 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3630,11 +3630,12 @@ endpoint_tests()
 	# remove and re-add
 	if reset "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 2 2
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 3 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
@@ -3656,11 +3657,21 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 3
 		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_del_endpoint $ns1 42 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "after delete ID 0" 2
+		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-add" 3
+		chk_mptcp_info subflows 3 subflows 3
 		mptcp_lib_kill_wait $tests_pid
 
-		chk_join_nr 3 3 3
-		chk_add_nr 4 4
-		chk_rm_nr 2 1 invert
+		chk_join_nr 4 4 4
+		chk_add_nr 5 5
+		chk_rm_nr 3 2 invert
 	fi
 
 	# flush and re-add

-- 
2.45.2



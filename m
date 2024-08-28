Return-Path: <linux-kselftest+bounces-16508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEDF961F61
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D66288175
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BDF156C78;
	Wed, 28 Aug 2024 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9HTfTWW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D915B96E;
	Wed, 28 Aug 2024 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825699; cv=none; b=WEhh2FDIq9SzgR3iipa3LgathmMO0t5BqObxYBJ5LOlr6MBcE3H7mcDDp7uE4+QALqRX26OtqOiVwOPKdGgdICTB0ObokW8NEnthYZ/5EAZulXiAW90A95DK+IAANCoi8ZCB3O7dbO4BM+vNJRGiL1g+RC4dP0mYcc05RxJr6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825699; c=relaxed/simple;
	bh=vMJXgtNzCq1MQ/P3LZ4AgVWlu+IqbJo1RQWHkx6fSdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HoJJjn9vSGxazMoyhc637UaMHaU9wS1uugbCkNFKXOfeM1dfuO3uga43AxkkVk4CZ0N9hNfqy0syDZ2X52e4z4XF9KV8DUieEMTRlwETdabCHJh06QPuqU6DfpBGbnv7nzOHa+c9Y/ClhQrSZaZM6IBlHbkVe+tRVWgCkX50d1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9HTfTWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7DCC4AF5F;
	Wed, 28 Aug 2024 06:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825699;
	bh=vMJXgtNzCq1MQ/P3LZ4AgVWlu+IqbJo1RQWHkx6fSdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K9HTfTWWpCR4yH7bXBB1gZoQ2ZoaAk4ccmOyWRsIySpswhghfNbGTSBJ8k6UiOApH
	 uJoYKsU51czjmAUtA7zEDAztdcuJNoaDbUZezDkiLLsVJ6axLtmJWQHY6pQiQRwp0q
	 ixWQ79xsNC0N+7RP4HakX7tmbF/xMaw8kK6YpH8FTP0PfitBNOIiVapPQMxCjMqIzy
	 bcqU+7IACF/ifHJR19F7uVm3xoY0wOHHjTLiylORG0Ghwf2Jqs06yWj8QtgceMAoz8
	 VRndJfbZ1C6feGxBHujWLGPuQHlzLRfrwiT8UnP9Iod0rS0FusnLBT7kuY0GslORDR
	 qpOOIVqm1Giow==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:30 +0200
Subject: [PATCH net v2 07/15] selftests: mptcp: join: check re-adding init
 endp with != id
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-7-7f11b283fff7@kernel.org>
References: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
In-Reply-To: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
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
 h=from:subject:message-id; bh=vMJXgtNzCq1MQ/P3LZ4AgVWlu+IqbJo1RQWHkx6fSdc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBHrq0KXsPkE93oNUQbn11HLPdxjvWwctViQ
 QsZH3k3DISJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ARwAKCRD2t4JPQmmg
 c7AJEADWJId7u+4+A3rKcgQtvJXqw47+9yxkIu1zNXntEKBXqYXoWVM+66F9DvNyZo2PyDFdjr3
 JfIuqtPP1LFJs21GHgIYcq/R2M86C8CPQ6S2GJYaTJlZVpFc8xkQiQEOks7jctNvHH8SqYGgaRd
 XccGFQL8U5EiWxYTB1KnH169ONLsYAzb3mz9J4yUTG2udQd+bWEKDpSaKrFOm/dYvM4N/8RURn5
 NjxLvAP/HNRu39tC9aBjQ8oSrSkwpcAPE66Ib5a0KI7tQUQ4nwbdXRXQ+HPPE0HIiUEH+4ADfkD
 xgtuRfzKthHJ1WCrFB4Tp2vn3RQ+KbEWljHUyZIux3eqH/A+T5QMu/893u47orY1a8yDfDiDp4I
 iS9uzw/Kgv9PSTcpqlZs/1bMiYN5CmCmQpz5gc6g7S2a+dFJLuXIPXeRGyUvpwTDYM2/ELQFJFS
 5G51vswLUR1jfY/wbwQ/AfUE8LqnkSTg2mWQRBgECwoLd5MEvxl2da/2kx//0PPtfYAtTOpBZCO
 RaUAhg/xWEZ1rvbPiW608TlhxmpZLkU90V3oBZ+5T1hSvy30CFApEcVWgfY5xu01DAHsAAFwcn9
 rqTm5eQUjwTvjtfocM2caD+3QWFXElmsWO6Yd6qejwBR2nXU7QGBfg/m8aqPmh4M7Ncvd6LyMiE
 s2vWxeJpNdW42jQ==
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
index 8b4529ff15e5..75458ade32c7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3627,11 +3627,12 @@ endpoint_tests()
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
@@ -3653,11 +3654,21 @@ endpoint_tests()
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



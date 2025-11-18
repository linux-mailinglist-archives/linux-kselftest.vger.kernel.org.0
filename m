Return-Path: <linux-kselftest+bounces-45841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8091CC67EB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 575B128F5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333BC30C633;
	Tue, 18 Nov 2025 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps5wSGRM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1562309DAB;
	Tue, 18 Nov 2025 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450487; cv=none; b=ny3DhtmWB0CAuqdjfF2Wfs7EvU8CILXmfVs3N1QwfS7IuSJeyhU93xX/IA1gGMyKOvWTBgiMeAgPsv6+dUAgNn8iYWU8WKFoYcn4ciuXVQ0aNChykrGFtY/OHMDC/AUMkGViF9xKXuMiz9y4qWEr6TqX1yU4BhyatZ5jQBlJzNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450487; c=relaxed/simple;
	bh=nORs0JZ35aLWRX1d/FPjUMCwhC0Fvx+aMRP1iDhjNj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0lrpmhCrG1zDNwGSd0knngmNCrc1KftmdUmZe2yZ2lP4qyTBcTd2ijDUGejgj8PVzk3PfOTcKevSo1REVPdbT3H59yTeZYokTlJQEPl7xLUgXJGlYZGZCddMmj7M6VJexK13N4ijIHLXA+lq4atN0jrE47D5bF9LB7B/NbeIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps5wSGRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4DCC4CEFB;
	Tue, 18 Nov 2025 07:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450486;
	bh=nORs0JZ35aLWRX1d/FPjUMCwhC0Fvx+aMRP1iDhjNj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ps5wSGRMEXrLsDNs1niiHg6h+SDOxdPsfk8aGsxfS5XuMCepem54qr4vsKApfh2Jj
	 hrKkBm4pAaxCNrD7eLJvkuFkRHO5y2t+Dk7jF8LIy9AP8rZ1/eYcmNppS8qLYJGfrn
	 QCE16+7CYXAZCSGNYbCODqTMalHEl7zGZxMeo0gfMPl5tarTdk7bRZsjNFMlkVtgCC
	 VlXpfPeVK0O5dtnDBPcJz9w5e8jAcIqWPK0rVWxRSgq0pGQ9hj24zqajs0ypWF2Xg4
	 DoKyfE4h/2eNpmgkwv5O9cRB6WEQPk+gJVVDaadW+pcl2oGMmuaZYY6yk8IgghAlqV
	 7oAJ5Emwe3c0A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Nov 2025 08:20:29 +0100
Subject: [PATCH net 11/11] selftests: mptcp: add a check for
 'add_addr_accepted'
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-11-806d3781c95f@kernel.org>
References: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
In-Reply-To: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2574; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8Tipnr3on2+y5jazX/inS26vGb24rWiHvlpOIxEdOB4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJl5IL63RrPiJgoqTbEbBAQsJyrefPict2N4f8c29ZU3
 3oxS/pYRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwET6LBkZPmww6L+g+fZ7Z/CF
 ztsMosJWk2ZkzpvBurLs4ubGzWZ5Cxj+u/wP+dcTpJfGYCAT6H7Wp8hgR+E+/yybtCvtfFuvG67
 nBAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

The previous patch fixed an issue with the 'add_addr_accepted' counter.
This was not spot by the test suite.

Check this counter and 'add_addr_signal' in MPTCP Join 'delete re-add
signal' test. This should help spotting similar regressions later on.
These counters are crucial for ensuring the MPTCP path manager correctly
handles the subflow creation via 'ADD_ADDR'.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 74632beae2c6..43f31f8d587f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4055,38 +4055,45 @@ endpoint_tests()
 			$ns1 10.0.2.1 id 1 flags signal
 		chk_subflow_nr "before delete" 2
 		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 1
 
 		pm_nl_del_endpoint $ns1 1 10.0.2.1
 		pm_nl_del_endpoint $ns1 2 224.0.0.1
 		sleep 0.5
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
+		chk_mptcp_info add_addr_signal 0 add_addr_accepted 0
 
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 3
 		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
+		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
 
 		pm_nl_del_endpoint $ns1 99 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after re-delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
+		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
 		mptcp_lib_kill_group_wait $tests_pid
 
 		kill_events_pids

-- 
2.51.0



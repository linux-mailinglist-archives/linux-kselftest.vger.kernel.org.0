Return-Path: <linux-kselftest+bounces-16309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE5195F5F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057741F21FDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0B819B5AA;
	Mon, 26 Aug 2024 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAarQ/kK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE499195809;
	Mon, 26 Aug 2024 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688016; cv=none; b=DZFvzd7znF5Rz1vLI4wjRdwUNsASWMElUAcIaBhV2p3Ds+xLoyz2Sn14mMNPpnksJ9SQPzGEJyfSyz1J9nTqvjggcyQIh35J+EO37DPNpxWPdDKVSSS6wB0BDAzXRVuyAW80FIWaz8SvdkNkYxL7DaQCe1kJ+gaLmaQxr0mEM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688016; c=relaxed/simple;
	bh=bHzBRNjE/jIpOyHCtWJBqk8TBdXr/eJElLpmCO41czc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSJXLU5B/VfSMLVQPRebbKu1dxkzNHptFdxaL8Mt0GO8pRQVNpGVG1o7tUuMZR/NBVisq25B0d0hajYRMLcGbu6Wsb9sEB7y08NJTgGzrSJNHCflYbkmdkkY9HJLSxa368g8yvsSIopKc0D7YsYahSOactorOqwThUnHfBiijS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAarQ/kK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFD1C4DDE5;
	Mon, 26 Aug 2024 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688016;
	bh=bHzBRNjE/jIpOyHCtWJBqk8TBdXr/eJElLpmCO41czc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jAarQ/kK2nRoPLEndXOeMKwmWI5Taoj3piriwxpL2CO53/kkaFZdYYfxgceL+biy/
	 DWxbYC+e52eCXTRiCLRO9k8BK6FVySkoJc8K83wlxChq32jiIYAezEl/x82Qj9ySsg
	 35b/7DWwfZN+mq8hLZPVZaWNZZDJfoqMXrXVbC+niO7pME3tZzEdN3PT3lTakghTNp
	 y/072SprndZdJ0TMqZaMtI32mHSHhuflVUqPeZc25NH36f8PRhcSXYYcuu22ib6qK0
	 9KbywxF/oQF7OofsjND2U9DABCooyDMW2PEWqGWWB8b4yDaOBwbtkQ7wJer0XhhjUo
	 9FggQUhmlsphA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:14 +0200
Subject: [PATCH net 15/15] selftests: mptcp: join: check re-re-adding ID 0
 signal
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-15-8cd6c87d1d6d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2842; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bHzBRNjE/jIpOyHCtWJBqk8TBdXr/eJElLpmCO41czc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZXWMyY/fkS5DCKZoeLUWw6g0fYZ4wI0QcAv
 A8jMi1SZu+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVwAKCRD2t4JPQmmg
 cx1tEADvDwVA9GsZcOLjwIw0BvEcxMpbeYFe+NxW8WXaCqNR5JOWGmjyboD7cajfW3pGCw9j5HA
 F5biWAN7x0w0PWym6oqgR0uzZEDXKe4hHN2PUUA7wFEDuvASErxkhFZtBbFmKKVeYC5FYJmxL+m
 96uywOU0EOzT8Gbf11AIT5nm1gXKrq7DRpJnIT/zBarDHIIfh8/Kalxk/G5BNH7HARHlpiyG5gI
 bceRQHtAgymIN+DiHqQztIuC4D/eO67yq+oMu8iQ7YrUbO7GE0uFZ26kVjrIPhy4EWkr8Hhnq5p
 tagWd4vmOtlQjxe6v3iGYNroWgmRSo+aaaYs16JAcwxkUeDGtTpm+3IkSaK1fzLfjVTKF+IwB4H
 DBDDDHM30Zmo5pWAt81Rzq2JUkJqhlcGJPnqwrtsyXiltbr8yQMntsVgPm5Mqq3Rnqa0GgmwNX8
 kOiLwUGW8oHpJjAwcI2p2e06NL9AuXvV9Iu5+bz32D/voRfB8JQLP66pZsoRl7p2XBKbIIP447Q
 COXaGu8bzH82DFGOQLLHxHow5ni9OzFXLydec2awfBljNDbow6UxJJ/PKb5d6qilR0DBz7a0sbT
 fclXmEnM/EWRkTNt0VVe01GsxYd/uurmyB5l6LAWZ1YNKJtL356REJu2lcuhlCgE+FMePxNjxmg
 M9dWoTOPgr31GNg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete re-add signal" to validate the previous
commit: when the 'signal' endpoint linked to the initial subflow (ID 0)
is re-added multiple times, it will re-send the ADD_ADDR with id 0. The
client should still be able to re-create this subflow, even if the
add_addr_accepted limit has been reached as this special address is not
considered as a new address.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 597bf928e8f9..47c89a16b6e1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3720,7 +3720,17 @@ endpoint_tests()
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 3
+		chk_subflow_nr "after re-add ID 0" 3
+		chk_mptcp_info subflows 3 subflows 3
+
+		pm_nl_del_endpoint $ns1 99 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "after re-delete ID 0" 2
+		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 		mptcp_lib_kill_wait $tests_pid
 
@@ -3730,19 +3740,19 @@ endpoint_tests()
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 0
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 5
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 3
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 6
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 4
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
-		chk_join_nr 4 4 4
-		chk_add_nr 5 5
-		chk_rm_nr 3 2 invert
+		chk_join_nr 5 5 5
+		chk_add_nr 6 6
+		chk_rm_nr 4 3 invert
 	fi
 
 	# flush and re-add

-- 
2.45.2



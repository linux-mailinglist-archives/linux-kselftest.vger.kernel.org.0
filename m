Return-Path: <linux-kselftest+bounces-16946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD2796852F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D578F283B56
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851B31D61AF;
	Mon,  2 Sep 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/zYvoTF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E31D619D;
	Mon,  2 Sep 2024 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273997; cv=none; b=saZ6ix2mTDouZOZMX8oVMdrvZliEFYoWhkhxBwItSlTDv4+wNiWGstgdWIQgaiW+48NKXQ+Oke7QrXgAdTSlxVBjMbKP+RMow/TwbSktunGy575E8pBMithnFPP7fS7uu6a+4ZwYQqE6p3CtiEO4PZL2nyM6Lt0l1/rIewvDA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273997; c=relaxed/simple;
	bh=1M/d580d6jhPLMlOZ9LU8u4cShDLWvFtCfSzu3UhKfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GptF/3pjT+uclxpJPg3gL/6k+eSj1iSUwfSkRMePQNK36+yP+s2oheVqKiNA2rk3wBFD9Zq8dJIUGGqwUNNhVWWZ9JrwzuLLkhnhIuetYOi0eWe96CdyxQ95t6sBVlURf3gpIBILE7nNMYQYwhrr6fy0E4dgpNXfRzZM3RqVprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/zYvoTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4795EC4CECC;
	Mon,  2 Sep 2024 10:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725273996;
	bh=1M/d580d6jhPLMlOZ9LU8u4cShDLWvFtCfSzu3UhKfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i/zYvoTFLRkuAgunli5MGRzUpXqZfKktdee7tsjY09hg71vAggaDnZ6lZi4kmfhlr
	 RmaheqqDjRpAi9Mu9BKpWrfXIpPwu7U4bYrTknSLzm8SMnOWAmXGfiiyLPjQQ/oKtu
	 mzt+G231N+FCtwAdf2m6eddAbKJEg8341Wv27GwxMwtE1dl21924k19NwSVOsHGRr3
	 Z8oCi8Q9x1zvMCkLL45JvBv5IwTPx8kPdm3vBAxQfaWxxir9dhNHt0uQfdJ3HqTzRl
	 UtkfuKH3w2Y+Fd6U65XkVAMVjzFVnjB3onpbJYDsHdc4XJj7ygJRaRZrhcLPmbvVgX
	 i5H4zXIWdbirw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 12:46:00 +0200
Subject: [PATCH net-next 09/11] selftests: mptcp: join: mute errors when
 ran in the background
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-9-d3e0f3773b90@kernel.org>
References: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4205; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1M/d580d6jhPLMlOZ9LU8u4cShDLWvFtCfSzu3UhKfk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1ZdtAnV9XjRCligORVcWsIdvxPleRbAqSkNod
 KyqPxbzh6CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWXbQAKCRD2t4JPQmmg
 cwBxEACIt5XoczhoFYKaN/ldAB+9QjhtXK2ilnjN/CytcxbfferzL+KQiL7eFb8J1FNUYV0EYTG
 LOtwd+uZQu3OCVarBHa3cfZkniEn/boY8iw5O7QW5P7B4SbkHDLpTJf8htlW8oLxNJl3d/8JxIE
 ev99Eukn2VdDERRDHiZlkszl0S0zlS/GjfFf5zBDQYe/WKsIyx4DbZMK5KgAqbr7+gPA/hB5qgg
 pMIgKiX4S8DXZ+r21aM3ONKU/WqV+YYmXBKEVTBZ/ccR2xzRB2iaphw6wK9YtjPcDLoPcPcuvZI
 BqlnnviraXFwJu2JdnQrCPKbTPHhPBFxNZmFjvkAj70WG6Y8H8yrK5iI+qwRhVXZdtyTQzAapGe
 mqGuVgoDhKqLIXZLFA0vAjUrDyfZqagqXOc2pprRoPJNgFs5uo+diMBoJn3apv76hFkGqwAes45
 mkIMw3bIejPzsBoFwjYSq+fZL1cQhbNk7TBHl1J02b9y8m29bgoK/g3ka5P1HI1tBa6y9E+fs+c
 jyCeqHc+4llKtEUiVgw/PZPwAAOU5ogTm4ao3l6idMjAm1JKt2U8gIQH/uB3dU4fKIyTpcKgifI
 Tm9tWs5eDr/VrnT3sPAS88OJC77KFhIQaFGVZwpI7FdAVLUXBNpDF4CfS+KF7B17FZY4liQXtFZ
 wcZrKGbuo5gtrXQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The test is supposed to be killed before the end, which will likely
cause "Connection reset by peer" errors. It is confusing, especially
because in case of real transfer errors, the test will not be marked as
failed. But that's OK, there are many other tests checking that.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 36 ++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 321197d8977e..5d164abc18e5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3542,8 +3542,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 2 2
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
@@ -3575,8 +3575,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
@@ -3603,8 +3603,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
 		chk_mptcp_info subflows 0 subflows 0
@@ -3624,8 +3624,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
@@ -3648,8 +3648,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
@@ -3679,8 +3679,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		speed=slow \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
 		wait_mpj $ns1
@@ -3706,8 +3706,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		test_linkfail=4 speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ test_linkfail=4 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
 		wait_mpj $ns2
@@ -3783,8 +3783,8 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		test_linkfail=4 speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ test_linkfail=4 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
 		wait_mpj $ns2
@@ -3856,8 +3856,8 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
 		wait_attempt_fail $ns2

-- 
2.45.2



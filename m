Return-Path: <linux-kselftest+bounces-6130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14416876CE8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370571C21942
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA4E64AB6;
	Fri,  8 Mar 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpCtWGOE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE7651A4;
	Fri,  8 Mar 2024 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935869; cv=none; b=c1c5Yqbm5uhtF34Ux4TvEN4fK8WdBOLf2TewE16lhn9B+JObgIfHqvyJReoQbnrmiLtlvdG6O0mldO6tUE0zRIdyATYWiQUiOuHimBnt321HKzCZcJo2oDXX0dsxitIHDAESdji1BwCW1Ya0soAAfkyH/MuR954lyCh1VA0a2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935869; c=relaxed/simple;
	bh=gI7gAxG7/7enPUG2m1/wk/2tQuTd6pa5cKzSuAGaaZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gD5rEng5s0ttTNumtbKerKZl1lvK7eIuikRxLiTPqCqrrlmclu92Q1i3rNq1mpFGgCSmeDAk9FZgnlgFNUdIcVOrgfHsitNU7KKHwlPniAuWD7HHR1tamkP3o67sRFov2q3ix7IvsTRbDYObVwbNXWS/n/Sk6wqeowaJ9q2fID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpCtWGOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D7AC43394;
	Fri,  8 Mar 2024 22:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935868;
	bh=gI7gAxG7/7enPUG2m1/wk/2tQuTd6pa5cKzSuAGaaZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hpCtWGOEX+iXWfErxAPPeQO3r8fzsK71uNugJ99jFLMCiy9IT72HCfTpPxq8JdHkC
	 K+O81QHv8Vkz9BihnpFTKU9/33gB9EFNqWdsil1kYXWJvlapHuhD8qe/sY3KEj3xRA
	 wdgauIBQ2cKpb+aERvIcUavVUzWECmaClCxgL2PEwPSad2ZrE0Qo7qMAjvDWz0AI7o
	 nM5EdBRaw+Rln+MS8vyGLPJnaTwmIxBfjVZi8emEs7VSvyvCpVWHrnBJgE80R3/iCa
	 kNnFeQsQbYOYOR3HOAWRo7fooXks+Gq6yWKK2pKhp5kmZOWLpVT9Be+NMU58wpjlWK
	 tAK3c7yXK44GA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:20 +0100
Subject: [PATCH net-next 13/15] selftests: mptcp: add
 mptcp_lib_verify_listener_events
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-13-4f42c347b653@kernel.org>
References: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
In-Reply-To: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4275; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pARL3ytgyARb+QzDKu12q0Cw4Y2pvqigZlKc4xpTC+8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJ7kzUaDOHz8NVkhyIbvdx3NmFlSXMhO7GF
 uZKiTuBxNmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 cwSPEACZoaAg5fwmfNaFNwjUo6mzoRqE7sI6Hr2fml9t52zDSp3VsP9I3TduJwROs05U8j/DDZn
 El4a80D+yyaMEsv9/PZpvCH9H8Bn7bhcopWvMSVfmmHnQY5oOFSy3x8d+4eC5mhW1S0IPTKpYM1
 ciApsfwz7VKORpm/ubOdmVKhBQg7Bm+LFqsLhootFwZYneRO+Goe6jVu48gYlVSnucrkvsA8Rvg
 m/LFprUpnfdrhkNU/tj3JaXxfxC+E4wx5XVHe66u0+eYcVezX3g7OAwOHkTYC1AYSXBcckMePla
 XSsdewrfD1rp6ijv7xcoBxqQl+YAoDSqa9AKpaHZDpOIAY0eC2XVH2rNHFmYrhbXj3p1GxLidKt
 ZVaR40QrZRO+qOvsP3BuoBKgXZR4LNdAU7Gc6XJaiG1WrADG4gBW1upm6ZKtTnBJkfObIN9fdhe
 NOemXnJvRKulu1wOzmcWbXO4tn2t1/NFEdiTFwx9yOQt/VL3QobVwI4x5rrDkUldr7xsCZpEhJO
 R8B2Un5QA/hh6wuXHzLWjCnYRRSoHYWLg8Pql+YhbJs53rBRHB5d0TpTfNk6ixe7vFGPbC9Ac2g
 lWvW1p1+1DJlJycMzpsprLFaznc+gKuS+mcWeXYyig0DB7JgCOVrYzqdxd6eJ4nDed2Y7sQdsJr
 xW3d9tXzoqDNr/Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

To avoid duplicated code in different MPTCP selftests, we can add and use
helpers defined in mptcp_lib.sh.

The helper verify_listener_events() is defined both in mptcp_join.sh and
userspace_pm.sh, export it into mptcp_lib.sh and rename it with mptcp_lib_
prefix. Use this new helper in both scripts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 21 +-----------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 26 +++++++++++++++++++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 21 +++---------------
 3 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 041175ec1304..9b538a7071e7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2794,15 +2794,9 @@ AF_INET6=10
 
 verify_listener_events()
 {
-	local evt=$1
 	local e_type=$2
-	local e_family=$3
 	local e_saddr=$4
 	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
 	local name
 
 	if [ $e_type = $LISTENER_CREATED ]; then
@@ -2820,23 +2814,10 @@ verify_listener_events()
 		return
 	fi
 
-	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
-	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
-	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
-	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
-	fi
-
-	if [ $type ] && [ $type = $e_type ] &&
-	   [ $family ] && [ $family = $e_family ] &&
-	   [ $saddr ] && [ $saddr = $e_saddr ] &&
-	   [ $sport ] && [ $sport = $e_sport ]; then
+	if mptcp_lib_verify_listener_events "${@}"; then
 		print_ok
 		return 0
 	fi
-	print_fail "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
 	fail_test
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 44491f18ed17..a977a722fb3d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -468,3 +468,29 @@ mptcp_lib_check_expected() {
 
 	return "${rc}"
 }
+
+# shellcheck disable=SC2034 # Some variables are used below but indirectly
+mptcp_lib_verify_listener_events() {
+	local evt=${1}
+	local e_type=${2}
+	local e_family=${3}
+	local e_saddr=${4}
+	local e_sport=${5}
+	local type
+	local family
+	local saddr
+	local sport
+	local rc=0
+
+	type=$(mptcp_lib_evts_get_info type "${evt}" "${e_type}")
+	family=$(mptcp_lib_evts_get_info family "${evt}" "${e_type}")
+	if [ "${family}" ] && [ "${family}" = "${AF_INET6}" ]; then
+		saddr=$(mptcp_lib_evts_get_info saddr6 "${evt}" "${e_type}")
+	else
+		saddr=$(mptcp_lib_evts_get_info saddr4 "${evt}" "${e_type}")
+	fi
+	sport=$(mptcp_lib_evts_get_info sport "${evt}" "${e_type}")
+
+	mptcp_lib_check_expected "type" "family" "saddr" "sport" || rc="${?}"
+	return "${rc}"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index e9aea44edee5..1e0b39e5525c 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -835,26 +835,11 @@ test_prio()
 
 verify_listener_events()
 {
-	local evt=$1
-	local e_type=$2
-	local e_family=$3
-	local e_saddr=$4
-	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
-
-	type=$(mptcp_lib_evts_get_info type $evt $e_type)
-	family=$(mptcp_lib_evts_get_info family $evt $e_type)
-	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
+	if mptcp_lib_verify_listener_events "${@}"; then
+		test_pass
 	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
+		test_fail
 	fi
-
-	check_expected "type" "family" "saddr" "sport"
 }
 
 test_listener()

-- 
2.43.0



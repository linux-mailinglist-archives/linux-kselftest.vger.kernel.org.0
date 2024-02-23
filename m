Return-Path: <linux-kselftest+bounces-5377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDF861D6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2034E1F24DE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4E414CAB3;
	Fri, 23 Feb 2024 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN2ojuFv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE18146E67;
	Fri, 23 Feb 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719564; cv=none; b=CrqbmlSdPbrBq7HGHmKLqLInO78gPPOvtgFGyuXhTGuBgrlnHT1/GLUR9DXgkMUskOohLKZnUFOIa9j1uH40oTBKOWIzwjOW79OTbRv8Bo5HjEkp3t519NevdvOFv0KmsBqech4AZvVsGcq34PUVcKyrZeKIaVQYUxU46L97qik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719564; c=relaxed/simple;
	bh=ukSJGjxu+ue1SOHBDHfmlxv7527kiTH7F4ql4XDr00c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auzYV+HKVcINDGAKZX4jUu0mOl1m60pK+irSBjX1lnTEWGFfOgUsIaPE03L3d9D21J6oNsBhLinGDp+idc4gsNXYhb6sH4pMmTeq6m3NSS2zAI0zMkE5G6FBVBYJlkMTMF2mbV8r9LesCpIOW+19krKpmh9JPkan9xjtDWJa/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN2ojuFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8286C43399;
	Fri, 23 Feb 2024 20:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708719563;
	bh=ukSJGjxu+ue1SOHBDHfmlxv7527kiTH7F4ql4XDr00c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rN2ojuFv0oyQzoZrLloiVhjjVW7mrKYyGs20DBvUKJpmHEi3lRvah7wxoLCyPrX2X
	 jP78+SB1aQ9GuY0U5ltgL9GEfb13F6mBu2Aibwb6DOoZnYcQwepfDOcGW+FaK9OkSM
	 knP43mIIDYsHeJdh/Ax53hQaRkbipXNAMqUhMqocr4YlF5bxN1PXmuPYVl72Cequuh
	 PzOhYdEghtt265IhbT50lUGW8K661aS9NUYAEd1pqLHgQ/PO4Rc1Y8SUTxpCVXJgRg
	 mOxc+V/86snBfZvzhuH3uEX16KZjzWU5zB6rKHIcRbiG6XLYLTnMiCXuoCcTRwrmlz
	 tHPLHPtKSteMw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 21:17:59 +0100
Subject: [PATCH net-next 7/8] selftests: mptcp: join: change
 capture/checksum as bool
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-next-20240223-misc-improvements-v1-7-b6c8a10396bd@kernel.org>
References: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
In-Reply-To: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2685; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QAwNFzDN+MJTxQHIwpBmAUpR/yt5FrvMyfSOP6mUHgI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2P2qKA6ebgNQ99j+L4S74IFVKs1uktyoR1Cj6
 XeSLiF4xD+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdj9qgAKCRD2t4JPQmmg
 c7wvEACeZtD25TbQuGVn8mbHzk+UtSKtpAeKEACWF60jZNCOipC/EBQ0W4njcHMiaBg7XMx8RmQ
 LqxtGTnUJsEVBZWTi0BrCT3xgcnhpvG49eSpJtjcpWWVlebZLuRCDU+GZwq+4HN1j39WWe/4p/d
 tsoHbwQ0bcFQHdgPVjUEZQ2w8ZnPAQkJXbEL54f+RAe0CmNbNAh1KwK9PT7v47SuhJYBoXpvib/
 3F6r2vh/EWYU3g7BZk+jgLrLhpt9Z54JZ34f/HRlL0WCH51+7+70dAgWwsKb3x09tG0WVX7Y/fa
 eXCWtmha7mpdKLWDBW0pRTUqLWqX1QzgEdTHJ71sD+FPfK7kXPHl4EhPE/Ded2wXKdgoqBLrFst
 WH2vmO+AjTf0WOBs7DPnAS6eFufGekpWuzGeffdTFoYtd10afM3dCPN57aDyPk7/O3TXwFRZ3WL
 I1iqcCu53jSW1z7WHxmPhg/ROY0MhuAnsveTRFEHV7Tt6uAevFum8pKF1nbR4bz1kvilSlIFGfv
 bwLC8IsWqgzyCUkGkawPGvKcgaODbNc3D1/mLnxvRMFB9VKPrCGmz6tN5oHs14hMRQnlfR26Ljb
 97qzKAxFKDmPcgMwli18qUr8zKgnPYGzufWIQWRvC8kfnacsHKZZVUwU3S3yGVtC1gIdprs1xiT
 0boa+s0q0rx34XA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

To maintain consistency with other scripts, this patch changes vars
'capture' and 'checksum' as bool vars in mptcp_join.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c07386e21e0a..3f198743cb03 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -29,11 +29,11 @@ iptables="iptables"
 ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-capture=0
-checksum=0
+capture=false
+checksum=false
 ip_mptcp=0
 check_invert=0
-validate_checksum=0
+validate_checksum=false
 init=0
 evts_ns1=""
 evts_ns2=""
@@ -100,7 +100,7 @@ init_partial()
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
-		if [ $checksum -eq 1 ]; then
+		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
 	done
@@ -380,7 +380,7 @@ reset_with_checksum()
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
 
-	validate_checksum=1
+	validate_checksum=true
 }
 
 reset_with_allow_join_id0()
@@ -413,7 +413,7 @@ reset_with_allow_join_id0()
 setup_fail_rules()
 {
 	check_invert=1
-	validate_checksum=1
+	validate_checksum=true
 	local i="$1"
 	local ip="${2:-4}"
 	local tables
@@ -1017,7 +1017,7 @@ do_transfer()
 	:> "$sout"
 	:> "$capout"
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 		local capuser
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
@@ -1119,7 +1119,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 	    sleep 1
 	    kill $cappid
 	fi
@@ -1507,7 +1507,7 @@ chk_join_nr()
 	else
 		print_ok
 	fi
-	if [ $validate_checksum -eq 1 ]; then
+	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -3664,10 +3664,10 @@ while getopts "${all_tests_args}cCih" opt; do
 			tests+=("${all_tests[${opt}]}")
 			;;
 		c)
-			capture=1
+			capture=true
 			;;
 		C)
-			checksum=1
+			checksum=true
 			;;
 		i)
 			ip_mptcp=1

-- 
2.43.0



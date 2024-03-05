Return-Path: <linux-kselftest+bounces-5911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55B7871C22
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA98285649
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DF35D8FB;
	Tue,  5 Mar 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp5B0KJm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447385D8F5;
	Tue,  5 Mar 2024 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635385; cv=none; b=Z1euVMT7Rx8CCE3dsY39oKhGwWflZxS60efCFh3wnR1v7g2/Sygsyy/mLkxKRuKsIeaMSqlcryHRApiAeVNq82nhS+aE/5tHIJKVsMV6QQg6CN0BVTCn4NvJXcG+GldvsT97xApYQ7nnncuMDJG41/ZO+HfNdGgp12MH+4uqUl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635385; c=relaxed/simple;
	bh=mQN6XlPwVxQ5NRezeDFYuyVoqaHwuvLxF4rT4+vnbxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scuTAxQJHh0d7MaGxfw11YgnBzUGEAjqHzDqgK0L6mgY35JX1hIFJoqKODB9mNVSgU/gjaE6i9NE6zx8FzabWScLz9ecdNgqn2rJx3Vk1MYBsLv5pZSrpjxYqhLslL8oUtko3nEjQbdtXZ0Qcs5LiHF2n3um1S6cSDXCaiJjMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp5B0KJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C02CC433B2;
	Tue,  5 Mar 2024 10:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635384;
	bh=mQN6XlPwVxQ5NRezeDFYuyVoqaHwuvLxF4rT4+vnbxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gp5B0KJmNw4IKIkcOFW7zpXBrXcXyGQnIlrbi2qV4y30CoWJPZ2+kTrX3V6lbGqae
	 NGJPeC8pkSl1EDj85ezP89WMBAtCT6KukZHlezEB0HGoWyg6TGWlY/zCmVO4VF5w0u
	 MQuT88etMnrbdRVEJJHLrRTpIluZFe+OoSDaI1yMQ/PJj6waiwSUCGOvszUWprD1mk
	 ZGH1H7MwudUilCXZKiPT1BLsWTmkRE3l6AnxHvLDXcApNwYgWJvVjcnBQcbLee1ECu
	 O2vcpDFToX66enG8fHuUjbXTN62IltPazxqgKrzldRLs7JjWnOmOCUyMbZN3tLMJWR
	 gHA20JvQcSrRw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:36 +0100
Subject: [PATCH net-next 06/13] selftests: mptcp: more operations in
 ns_init/exit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-6-66618ea5504e@kernel.org>
References: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5583; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JRlHi1Rxu31mh34RN165okAY3Ztwk7nlrHRPOjoBqLc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vccDf+kGzO7UzgxLAKP0a126AV/sKkNdY+ov
 15uzP+/7xuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HAAKCRD2t4JPQmmg
 cy+bEADvx78vO+j1Ox0a3/BHNmkbUkJD0qUicBb1tnmRsQq1nozcJhDJ5uIEqRdOOPH1KgXBR9B
 k1IYrASKSvHeyNpYVvLZ1dnrI5jUjr7aAbHl9pK7MhiPY0Gt8n6dh1YUUTnhY4+yIVF+Q8kqeiV
 JSupfaburleM4Shm4J/zjH9Igdl0+gFAa86/58v4+oLBj4QgKgTgvcJBk4QBgYplpcwj3RdKLbP
 0utCdFxUlSBc/jJQzTU6al8Ehw8LXWNmS6AWuOBDSDytj5QP+G7JCm+zueT31MQPPdVt2BHBreX
 dFaHVrS0QeUzmEWycuN9anHRPSZSy1T7xKoZkyHpfkZGm1vTUWXnzmYEbJA9E5P7YC8WGVNTvIZ
 wueI/RTF5gkgwJrET1S5krJg+xVEGmuI9Esd7OdBbGRbjeU/avjL12M/3enr/mlUV9ZYeu3KgvM
 qoicOINVIzGe3tUTJZkxnCSLWOgawPjLTDKlea5xQhTphOqZwqqIrc1l+FS9xg9vf0f/r3/zPh5
 0lk/V6fAiN5qZUzcz23Gg18RRBJRYMcqZHMBEHGC7aKyDPEh3+qE8cDp39lBDTLRPHlBmBCVqSf
 /OsKrYN0gX/8ih4es3lPR6dpraJ5rQttklnedn5Id8u0NqQjtgI3uOyp1Ed46GBw18SMn4R017M
 cSlMTnubmHgueVg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Set more the default sysctl values in mptcp_lib_ns_init(). It is fine to
do that everywhere, because they could be overridden latter if needed.

mptcp_lib_ns_exit() now also try to remove temp netns files used for the
stats even for selftests not using them. That's fine to do that because
these files have a unique name.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 4 ----
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 7 -------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 7 -------
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 1 -
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 4 ----
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 -
 7 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 92f6260ba9f3..b53ae64ec08c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -136,10 +136,6 @@ cleanup()
 	rm -f "$sin" "$sout"
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3" "$ns4";do
-		rm -f /tmp/$netns.{nstat,out}
-	done
 	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}" "${ns4}"
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 612470244c58..2d9cf6f3bbf3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -90,10 +90,7 @@ init_partial()
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
-		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
-		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
@@ -138,10 +135,6 @@ cleanup_partial()
 {
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2"; do
-		rm -f /tmp/$netns.{nstat,out}
-	done
 	mptcp_lib_ns_exit "${ns1}" "${ns2}"
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 2fcf31277e28..f98cde130869 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -409,6 +409,9 @@ mptcp_lib_ns_init() {
 
 		ip netns add "${!netns}" || exit ${KSFT_SKIP}
 		ip -net "${!netns}" link set lo up
+		ip netns exec "${!netns}" sysctl -q net.mptcp.enabled=1
+		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.all.rp_filter=0
+		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
 }
 
@@ -416,5 +419,6 @@ mptcp_lib_ns_exit() {
 	local netns
 	for netns in "${@}"; do
 		ip netns del "${netns}"
+		rm -f /tmp/"${netns}".{nstat,out}
 	done
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 5fa5fa8cab71..7dd0e5467d35 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -40,13 +40,6 @@ init()
 {
 	mptcp_lib_ns_init ns1 ns2 ns_sbox
 
-	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox";do
-		ip netns exec $netns sysctl -q net.mptcp.enabled=1
-		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
-	done
-
 	local i
 	for i in `seq 1 4`; do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 30ec0ec3d68f..c7c46152f6fd 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -39,7 +39,6 @@ mptcp_lib_check_tools ip
 trap cleanup EXIT
 
 mptcp_lib_ns_init ns1
-ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 2aeebb80da07..5a4b83cdaaa9 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -61,10 +61,6 @@ setup()
 	trap cleanup EXIT
 
 	mptcp_lib_ns_init ns1 ns2 ns3
-	for i in "$ns1" "$ns2" "$ns3";do
-		ip netns exec $i sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $i sysctl -q net.ipv4.conf.default.rp_filter=0
-	done
 
 	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
 	ip link add ns1eth2 netns "$ns1" type veth peer name ns2eth2 netns "$ns2"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index e3092696d2de..6d71bf36a1b9 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -128,7 +128,6 @@ trap cleanup EXIT
 # Create and configure network namespaces for testing
 mptcp_lib_ns_init ns1 ns2
 for i in "$ns1" "$ns2" ;do
-	ip netns exec "$i" sysctl -q net.mptcp.enabled=1
 	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
 done
 

-- 
2.43.0



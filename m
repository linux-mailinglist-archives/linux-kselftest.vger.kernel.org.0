Return-Path: <linux-kselftest+bounces-5983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ED18732DD
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B791F2481A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB55FDC8;
	Wed,  6 Mar 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us/4Pfmi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC25FDB4;
	Wed,  6 Mar 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718201; cv=none; b=G9C1yRKTbrUk0hLIQ8j83+PuWgIK1HevmU62bEEUlElzVFjv6Ql9E2kw8tAHZU7Sn0ZRKFnc2xW9Gh5aWbzAgZHOMEESS4bnuYA08kiAshf5JTv+azhTrTIiuWZr/c0dXL13CeVviWPh8BKARABzhG6ICNSE1dPUFKjPN/0QDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718201; c=relaxed/simple;
	bh=JorbahOsaa8JW5Lwy/+UPijO6D7EOFES6MkisJdeH/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Isr8fGrQ4b9URjEmS7Un/lCCpsVASHAY1JtY6y/wJXA2vaqz4tLZug3yXL/kmvPJOMO/kPF7jRnPkIyzjcU+SBVZiRrokZ9VqqHWt5GqAknp4mZDoVIZdGN/sUPCy9bHzxekLiAiOr1IPEmo/iIklLm2oQkNd2MCaOnbzb6UPqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us/4Pfmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CEBC43399;
	Wed,  6 Mar 2024 09:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718201;
	bh=JorbahOsaa8JW5Lwy/+UPijO6D7EOFES6MkisJdeH/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=us/4PfmiCCUITscNL5cb+sZnRb9/EOlnDq834p7YF/GZbuphov3ThkC4HDPnVwWTy
	 KoYWdKQQarMYEn66wstfWSsnTwiBN+GIYm0r+AWdwitf+eJ3RlM6vIghD8tFzhtW6q
	 Bl4eh8wC6bqkODJGLjj7NjXvZBTX1eyVIDy0wRi2UmJPcw3+63DVBJy/mWTAYwgNgI
	 nKScAUEA8dfVjK4x6Z7HPVRO861WhvtClxHlYOC+W9eBll1L5vpXhquAmY/KogWGVf
	 rzkw8CvvEwIMVxlSTvbADhM5C/rk8ooRPTjmWbHFUlVg5jlM08zM5Q8KeYF8P7X/QY
	 iKtCyNNc1JV2Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Mar 2024 10:42:54 +0100
Subject: [PATCH net-next v2 05/12] selftests: mptcp: more operations in
 ns_init/exit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-5-bc79e6e5e6a0@kernel.org>
References: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
In-Reply-To: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5583; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BIpx368yVSA/ElMPX5Hkp8Gga8Va6vy58sSKzHmCLes=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl6Dqm/pBhtyeS2jLyTdVVYAzH29orCdAukf1op
 VZcmE+NLM2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeg6pgAKCRD2t4JPQmmg
 c5w2D/9tNjegUU46U1JqzeMWP82HkkjNNHihKJhp4m4+B1eYe5hX+aemcs+5la8+vmiCZNex0aX
 AM1NJ1s19P2ilxxL+KzgrjMtIRanwFA2eVXvM3FFZQU79klzHZvsckd7soBYDbW8aNMv9fWgyJF
 Jr84ul3p6sFddk02YkHg15SI2w551pMjgAOYkmV/jyNXYVkNZ0WAgWLpQXVtu/HQv6T5CSY+k/m
 UHDFOZiQcnIJLmT0lp8gsTZKzJkMbgD//33lUP/S4sX7GNroAziVzYVJmpviXwsTR7ySNPoROKF
 Zr5eCfEw02g/5+ZOi7jsuG+ILiArO30YBOb0vf21bugE5gjlNLDL3AzYGyqyF5iM8be2yK/s1IV
 se/3qAJ6fPKbEa0YBriMsYejCOzFvNW0Qeu6wPL1tc9lou9m8fRyr7A314vDnM7NE0iUWztoTrJ
 reoozgyaY6KZYULEyGnlrgsWE8wmU76cQrlXA8Ahdfytjc6+nvpiJdmlNFgfs7o8TzfQy91hX19
 qmLUnjR5vZ+/x01LaTUghbbfnuAPjiB+7B/vnKK4XRE6h3dARw0aWc0sJXvSiVXsdu+koRhaV26
 XAjnQWxNdkFI30Ln2XsrwARg1miO2fFbPLGjEZxaA9J2L7y4NjMbqNcnwNmDjEeJ/u6C6TjHm+R
 fcAY9JjBFr38H4w==
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
index 17d609368603..5f44a4ebd185 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -385,6 +385,9 @@ mptcp_lib_ns_init() {
 
 		ip netns add "${!netns}" || exit ${KSFT_SKIP}
 		ip -net "${!netns}" link set lo up
+		ip netns exec "${!netns}" sysctl -q net.mptcp.enabled=1
+		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.all.rp_filter=0
+		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
 }
 
@@ -392,5 +395,6 @@ mptcp_lib_ns_exit() {
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



Return-Path: <linux-kselftest+bounces-10322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E23E8C7F5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 03:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F09A282BCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 01:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F724633;
	Fri, 17 May 2024 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb21Krmx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61356622;
	Fri, 17 May 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715907828; cv=none; b=eDmUNeZBKFFk7Czi7gzMp7qjiwi5arfnfOOSbneY7O+CQyJkkjKzmj3m7YnpHHHJVj2jYBH8lOPiA7xxmgh//7nNsj3NW+/fN0CxutehvqrL1cR4gjyC9J+dZvL4H8EDp6TO43GHloZNlf2S6UFGldlS5g3GouQJGl/Lu8QqZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715907828; c=relaxed/simple;
	bh=YL+cun76H43cdokkBmGLzF78RWhIsxoVq3jTMlQy9rI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCWNkyawA6s9lNRFM/iKctGdfLZoaR3SPxpTldGbRBcEtqq3FZ0QOWlaU1VAc0D04bYYCF8pOQ4E6+9VH7R9YSuIR7CsEFA6Cgbp3rs4dg+k+eMO+iRpQsoUSTxDO/2r0LIqpjADnYTUhLG/kJXOGu8QNjsEZGZ7x/sFiTeuyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mb21Krmx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b12b52fbe0so615484a91.0;
        Thu, 16 May 2024 18:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715907824; x=1716512624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AL+paX7CcQrBoFNNm0DaCG4n9OvI6O2TWGvRwoOA9+M=;
        b=mb21KrmxNVbGlY/jeMMscXS6kDzk/ePd+qUY+ma7VTcqYQDLi33K4RScrSHdF4GaO2
         pjHos2y9MHRRCB3gmo6Xiz7Xuc/wgPOL0f1Nb4ZxuTgQ517vvR8wvxHcd++8o7QzCj4l
         Wy7qYKssHyYSdRmpNxrR+IBibFNOyuZFe83/PjrjYy7WS1FEz62Hd0KDnnMxUZF+5hXb
         qou7XyjJoOnUeHDaW328hgmq6dp7wNfvUfCtOXttJk1PVdo8JgK13OFDKTDtDdT3OjUa
         XGfUtnNzjG1mqseoIBgoOciIoK1WVAU1jqLWFtT2lXWDjqtADg+iAM39EV6Up6kekSfw
         Vnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715907824; x=1716512624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AL+paX7CcQrBoFNNm0DaCG4n9OvI6O2TWGvRwoOA9+M=;
        b=HSSYgIg9lHKR/OseJXSMZZKmypsNyF8+dxm0si7p636Fkok5PaN13qTBZNf76iiEki
         8a1HKyPGBFilGGuE0xfgCvQDl+RH3KQrDGcGCmdwZMYaiIlBtdfOy6fsovUC34sNrdSS
         D7h5TCaw/ScKSs5SVXM+5PLLHeeXj/5pNtlgKyTTb71MVI9iv394Lze3w8WURXxbwjKz
         dmkYFhnU0+vQnwyrZwNfwBisiDcKIkBznOloGq+JWaLzlaRl9G1QtoCKWBDRbVbUV2KH
         KwvPWe8DqkSXErLZXTyGrQ9Epkzpaa8N8LgFx0098yyf/kopn5oXc89mFxZXvFWbbrgf
         lTxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt1N3LndH8/MYO8cNpipw9aLM0eMp8JoYzQ2TEPx9rdy0gtEh6iR/8sG2j0//Rm5YUWSofRvUEMfk0qfzd0SyeWUbV5/MUqe1P46AZgobj
X-Gm-Message-State: AOJu0Yz1bYZix7KGKd1ZPVt3nGDQaVTDmOkLpbyWnHg+37AyHYl5FzSS
	HkyTYkSXegwL8S7uZxnjHAxSUxQLBtszRJCpzByEk+DDGmgd7mjbj0Zm2PTl6vFE/w==
X-Google-Smtp-Source: AGHT+IG3OVcWFrFyWBR2r+Fp9uMyLJlm9teOa3sy3wLAchFZoaxP9DL2KXvIZFI2RnAMFaNjP6j8pg==
X-Received: by 2002:a17:90a:4c84:b0:2b6:3034:4ae6 with SMTP id 98e67ed59e1d1-2b6ccd93d4dmr22935553a91.33.1715907824190;
        Thu, 16 May 2024 18:03:44 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b627cacac4sm16411431a91.0.2024.05.16.18.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 18:03:43 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCHv2 net] selftests/net: use tc rule to filter the na packet
Date: Fri, 17 May 2024 09:03:27 +0800
Message-ID: <20240517010327.2631319-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test arp_ndisc_untracked_subnets use tcpdump to filter the unsolicited
and untracked na messages. It set -e before calling tcpdump. But if
tcpdump filters 0 packet, it will return none zero, and cause the script
to exit.

Instead of using slow tcpdump to capture packets, let's using tc rule
to filter out the na message.

At the same time, fix function setup_v6 which only needs one parameter.
Move all the related helpers from forwarding lib.sh to net lib.sh.

Fixes: 0ea7b0a454ca ("selftests: net: arp_ndisc_untracked_subnets: test for arp_accept and accept_untracked_na")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v2: rebase to latest net main code. no update,
v1: https://lore.kernel.org/netdev/20240514071130.2121042-1-liuhangbin@gmail.com

---
 .../net/arp_ndisc_untracked_subnets.sh        | 53 ++++++-----------
 tools/testing/selftests/net/forwarding/lib.sh | 58 -------------------
 tools/testing/selftests/net/lib.sh            | 58 +++++++++++++++++++
 3 files changed, 75 insertions(+), 94 deletions(-)

diff --git a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
index a40c0e9bd023..eef5cbf6eecc 100755
--- a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
+++ b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
@@ -73,25 +73,19 @@ setup_v6() {
 	# namespaces. veth0 is veth-router, veth1 is veth-host.
 	# first, set up the inteface's link to the namespace
 	# then, set the interface "up"
-	ip -6 -netns ${ROUTER_NS_V6} link add name ${ROUTER_INTF} \
-		type veth peer name ${HOST_INTF}
-
-	ip -6 -netns ${ROUTER_NS_V6} link set dev ${ROUTER_INTF} up
-	ip -6 -netns ${ROUTER_NS_V6} link set dev ${HOST_INTF} netns \
-		${HOST_NS_V6}
+	ip -n ${ROUTER_NS_V6} link add name ${ROUTER_INTF} \
+		type veth peer name ${HOST_INTF} netns ${HOST_NS_V6}
 
-	ip -6 -netns ${HOST_NS_V6} link set dev ${HOST_INTF} up
-	ip -6 -netns ${ROUTER_NS_V6} addr add \
-		${ROUTER_ADDR_V6}/${PREFIX_WIDTH_V6} dev ${ROUTER_INTF} nodad
+	# Add tc rule to filter out host na message
+	tc -n ${ROUTER_NS_V6} qdisc add dev ${ROUTER_INTF} clsact
+	tc -n ${ROUTER_NS_V6} filter add dev ${ROUTER_INTF} \
+		ingress protocol ipv6 pref 1 handle 101 \
+		flower src_ip ${HOST_ADDR_V6} ip_proto icmpv6 type 136 skip_hw action pass
 
 	HOST_CONF=net.ipv6.conf.${HOST_INTF}
 	ip netns exec ${HOST_NS_V6} sysctl -qw ${HOST_CONF}.ndisc_notify=1
 	ip netns exec ${HOST_NS_V6} sysctl -qw ${HOST_CONF}.disable_ipv6=0
-	ip -6 -netns ${HOST_NS_V6} addr add ${HOST_ADDR_V6}/${PREFIX_WIDTH_V6} \
-		dev ${HOST_INTF}
-
 	ROUTER_CONF=net.ipv6.conf.${ROUTER_INTF}
-
 	ip netns exec ${ROUTER_NS_V6} sysctl -w \
 		${ROUTER_CONF}.forwarding=1 >/dev/null 2>&1
 	ip netns exec ${ROUTER_NS_V6} sysctl -w \
@@ -99,6 +93,13 @@ setup_v6() {
 	ip netns exec ${ROUTER_NS_V6} sysctl -w \
 		${ROUTER_CONF}.accept_untracked_na=${accept_untracked_na} \
 		>/dev/null 2>&1
+
+	ip -n ${ROUTER_NS_V6} link set dev ${ROUTER_INTF} up
+	ip -n ${HOST_NS_V6} link set dev ${HOST_INTF} up
+	ip -n ${ROUTER_NS_V6} addr add ${ROUTER_ADDR_V6}/${PREFIX_WIDTH_V6} \
+		dev ${ROUTER_INTF} nodad
+	ip -n ${HOST_NS_V6} addr add ${HOST_ADDR_V6}/${PREFIX_WIDTH_V6} \
+		dev ${HOST_INTF}
 	set +e
 }
 
@@ -162,26 +163,6 @@ arp_test_gratuitous_combinations() {
 	arp_test_gratuitous 2 1
 }
 
-cleanup_tcpdump() {
-	set -e
-	[[ ! -z  ${tcpdump_stdout} ]] && rm -f ${tcpdump_stdout}
-	[[ ! -z  ${tcpdump_stderr} ]] && rm -f ${tcpdump_stderr}
-	tcpdump_stdout=
-	tcpdump_stderr=
-	set +e
-}
-
-start_tcpdump() {
-	set -e
-	tcpdump_stdout=`mktemp`
-	tcpdump_stderr=`mktemp`
-	ip netns exec ${ROUTER_NS_V6} timeout 15s \
-		tcpdump --immediate-mode -tpni ${ROUTER_INTF} -c 1 \
-		"icmp6 && icmp6[0] == 136 && src ${HOST_ADDR_V6}" \
-		> ${tcpdump_stdout} 2> /dev/null
-	set +e
-}
-
 verify_ndisc() {
 	local accept_untracked_na=$1
 	local same_subnet=$2
@@ -222,8 +203,9 @@ ndisc_test_untracked_advertisements() {
 			HOST_ADDR_V6=2001:db8:abcd:0012::3
 		fi
 	fi
-	setup_v6 $1 $2
-	start_tcpdump
+	setup_v6 $1
+	slowwait_for_counter 15 1 \
+		tc_rule_handle_stats_get "dev ${ROUTER_INTF} ingress" 101 ".packets" "-n ${ROUTER_NS_V6}"
 
 	if verify_ndisc $1 $2; then
 		printf "    TEST: %-60s  [ OK ]\n" "${test_msg[*]}"
@@ -231,7 +213,6 @@ ndisc_test_untracked_advertisements() {
 		printf "    TEST: %-60s  [FAIL]\n" "${test_msg[*]}"
 	fi
 
-	cleanup_tcpdump
 	cleanup_v6
 	set +e
 }
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 112c85c35092..eabbdf00d8ca 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -129,14 +129,6 @@ fi
 
 source "$net_forwarding_dir/../lib.sh"
 
-# timeout in seconds
-slowwait()
-{
-	local timeout_sec=$1; shift
-
-	loopy_wait "sleep 0.1" "$((timeout_sec * 1000))" "$@"
-}
-
 ##############################################################################
 # Sanity checks
 
@@ -678,33 +670,6 @@ wait_for_trap()
 	"$@" | grep -q trap
 }
 
-until_counter_is()
-{
-	local expr=$1; shift
-	local current=$("$@")
-
-	echo $((current))
-	((current $expr))
-}
-
-busywait_for_counter()
-{
-	local timeout=$1; shift
-	local delta=$1; shift
-
-	local base=$("$@")
-	busywait "$timeout" until_counter_is ">= $((base + delta))" "$@"
-}
-
-slowwait_for_counter()
-{
-	local timeout=$1; shift
-	local delta=$1; shift
-
-	local base=$("$@")
-	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
-}
-
 setup_wait_dev()
 {
 	local dev=$1; shift
@@ -1023,29 +988,6 @@ link_stats_rx_errors_get()
 	link_stats_get $1 rx errors
 }
 
-tc_rule_stats_get()
-{
-	local dev=$1; shift
-	local pref=$1; shift
-	local dir=$1; shift
-	local selector=${1:-.packets}; shift
-
-	tc -j -s filter show dev $dev ${dir:-ingress} pref $pref \
-	    | jq ".[1].options.actions[].stats$selector"
-}
-
-tc_rule_handle_stats_get()
-{
-	local id=$1; shift
-	local handle=$1; shift
-	local selector=${1:-.packets}; shift
-	local netns=${1:-""}; shift
-
-	tc $netns -j -s filter show $id \
-	    | jq ".[] | select(.options.handle == $handle) | \
-		  .options.actions[0].stats$selector"
-}
-
 ethtool_stats_get()
 {
 	local dev=$1; shift
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 72b191e4e064..edc030e81a46 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -91,6 +91,41 @@ busywait()
 	loopy_wait : "$timeout_ms" "$@"
 }
 
+# timeout in seconds
+slowwait()
+{
+	local timeout_sec=$1; shift
+
+	loopy_wait "sleep 0.1" "$((timeout_sec * 1000))" "$@"
+}
+
+until_counter_is()
+{
+	local expr=$1; shift
+	local current=$("$@")
+
+	echo $((current))
+	((current $expr))
+}
+
+busywait_for_counter()
+{
+	local timeout=$1; shift
+	local delta=$1; shift
+
+	local base=$("$@")
+	busywait "$timeout" until_counter_is ">= $((base + delta))" "$@"
+}
+
+slowwait_for_counter()
+{
+	local timeout=$1; shift
+	local delta=$1; shift
+
+	local base=$("$@")
+	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
+}
+
 cleanup_ns()
 {
 	local ns=""
@@ -150,3 +185,26 @@ setup_ns()
 	done
 	NS_LIST="$NS_LIST $ns_list"
 }
+
+tc_rule_stats_get()
+{
+	local dev=$1; shift
+	local pref=$1; shift
+	local dir=$1; shift
+	local selector=${1:-.packets}; shift
+
+	tc -j -s filter show dev $dev ${dir:-ingress} pref $pref \
+	    | jq ".[1].options.actions[].stats$selector"
+}
+
+tc_rule_handle_stats_get()
+{
+	local id=$1; shift
+	local handle=$1; shift
+	local selector=${1:-.packets}; shift
+	local netns=${1:-""}; shift
+
+	tc $netns -j -s filter show $id \
+	    | jq ".[] | select(.options.handle == $handle) | \
+		  .options.actions[0].stats$selector"
+}
-- 
2.43.0



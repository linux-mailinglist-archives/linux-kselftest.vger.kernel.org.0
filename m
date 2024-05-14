Return-Path: <linux-kselftest+bounces-10167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22C98C4CA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 09:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78BB28241D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 07:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18510949;
	Tue, 14 May 2024 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyU9oONh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BD101E2;
	Tue, 14 May 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715670705; cv=none; b=k0QueD8ckQ5VgsETuP/WLpLJIREwZR9YdQMaANB+W6q3DOWIhi/u4SZxES4x/ofzXxE2SA7jcND/4RjkXFZG26Ka53nOwGJb6rcZD5o4VDAB/vX/ahdjXPPQjGLa1FUgyzqJgX4Yi1znUyOtkb6hd9IP4yGCETY4RFpOiQ3aag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715670705; c=relaxed/simple;
	bh=05S1BYhkHRCm8WshREegwOuRt9RiBy6OK6mbuM4jcHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyaXmsMs6JpPGcJNpWZ/5j97pwIQAUuc4N1kP/tcHReWb+BuT6GKo5Zd2FjEDyYwgK75/Nwkl+jhpzpQmn6HFkQlUkpPaSwSzqjcQkvkKlbIdubNKG/VnWOAnPte8ZFyRQq0hsyPnEBPPCr7yWeYAOUfya7MbxSHX5wfcjFHq+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyU9oONh; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so4158872a12.0;
        Tue, 14 May 2024 00:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715670703; x=1716275503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uGwo9KZOvlqfrmQTldxlGodAf0IQjw1D6L5n8T9y3v0=;
        b=kyU9oONhbSWTImpB6001SHV1TKZ4L2zskUVeEGaggfSsvHVuYpQ+pgvgh7T8cJJJCy
         eaRtz48GnPmJC4GDAyOZ2SQqtp7J5SpVdHccIlX5dpAP9JMkRL7GBZaXaaLqvLmcJJU8
         ooWOUBcG4TtLDvSuUMkriqRf2Ix5H1/HSb9Fscxrc4PSf4Q9DWHnKOGfPq8XljxHOCvC
         0ti5UpV+tZeTqkSKaShbAlwTtVEWvjlkL0PFpfWZrvjWt89N+jJkh8VW6CLurOdX570a
         HK/Dpl7dKsNaLtp8Jp56bJzyAWC/nP0iIam6aJycBCmyq7q+csNLmJxx6PuDs9xBRGQ5
         s1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715670703; x=1716275503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGwo9KZOvlqfrmQTldxlGodAf0IQjw1D6L5n8T9y3v0=;
        b=A2aU6lVADTWRqCPr2WpQFbZKGmLexibE7Ed+CYEj6xXEZi8hx7PV6u2gxyvkO5SEZc
         VrS/t6El7od7+ImzRU/ADUsDje0pgo7rCdAune5n43kcGZQMib2+p+rKj0uD+SHBtwDa
         qH2NdK8lLnnd/ImKaIEMJYySl3G1htR+t9IzaHDwiATz9mkifuyiTMSm5rKGt73ntfKp
         2Pr0f2Hr4M5JTp9dw8IibhMHIX5j/i81dilZ37dfW4MiRD8m2fxOkwyq/BWspFBSneCL
         S1U76UFKJvBfrUV/MY1wROoH3Mlebd7awDYJww+L3FJoQd/cHciMhQ3F6TA9W9AlQ6cd
         LhYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI0YO8ja9OO9wTGUkalr1ymXjG5SXJ4D9vrOu6Kvh2cfE7g8d1fkxV8lWi6zRBa6Q/SX+E+qIKX51V1qDF5m+sLzIWYKKo50odaW37wJEB
X-Gm-Message-State: AOJu0YwyQvuhHu143xVVO6IBKFieql6doT4x8AibvKKNHljGrIrHri8B
	4mDM0r8WxZqbWnAkv8m46oU+m0g9hqZ+00O4AFpjWid0apEUA6hjoXjome492k0=
X-Google-Smtp-Source: AGHT+IGXNZzh3vzbRb0Uk5wAoP7ZrkOPLSNtZqCX4Zciq7QARFx79sS3PbrVOB9yb1wIIWW5fQdS4A==
X-Received: by 2002:a17:90b:3808:b0:2a2:399f:60e7 with SMTP id 98e67ed59e1d1-2b853c55c38mr8562125a91.23.1715670702919;
        Tue, 14 May 2024 00:11:42 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca5279sm10917333a91.41.2024.05.14.00.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 00:11:42 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests/net: use tc rule to filter the na packet
Date: Tue, 14 May 2024 15:11:30 +0800
Message-ID: <20240514071130.2121042-1-liuhangbin@gmail.com>
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

Hi Jakub, would you please help check if this fix the
arp_ndisc_untracked_subnets flake issue on debug kernel?

---
 .../net/arp_ndisc_untracked_subnets.sh        | 53 +++++--------
 tools/testing/selftests/net/forwarding/lib.sh | 76 -------------------
 tools/testing/selftests/net/lib.sh            | 76 +++++++++++++++++++
 3 files changed, 93 insertions(+), 112 deletions(-)

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
index e579c2e0c462..746161400a7c 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -38,32 +38,6 @@ fi
 
 source "$net_forwarding_dir/../lib.sh"
 
-# timeout in seconds
-slowwait()
-{
-	local timeout=$1; shift
-
-	local start_time="$(date -u +%s)"
-	while true
-	do
-		local out
-		out=$("$@")
-		local ret=$?
-		if ((!ret)); then
-			echo -n "$out"
-			return 0
-		fi
-
-		local current_time="$(date -u +%s)"
-		if ((current_time - start_time > timeout)); then
-			echo -n "$out"
-			return 1
-		fi
-
-		sleep 0.1
-	done
-}
-
 ##############################################################################
 # Sanity checks
 
@@ -487,33 +461,6 @@ wait_for_trap()
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
@@ -819,29 +766,6 @@ link_stats_rx_errors_get()
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
index f9fe182dfbd4..90410b8f3d32 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -37,6 +37,59 @@ busywait()
 	done
 }
 
+# timeout in seconds
+slowwait()
+{
+	local timeout=$1; shift
+
+	local start_time="$(date -u +%s)"
+	while true
+	do
+		local out
+		out=$("$@")
+		local ret=$?
+		if ((!ret)); then
+			echo -n "$out"
+			return 0
+		fi
+
+		local current_time="$(date -u +%s)"
+		if ((current_time - start_time > timeout)); then
+			echo -n "$out"
+			return 1
+		fi
+
+		sleep 0.1
+	done
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
@@ -94,3 +147,26 @@ setup_ns()
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



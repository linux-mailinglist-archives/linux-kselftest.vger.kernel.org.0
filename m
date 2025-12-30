Return-Path: <linux-kselftest+bounces-48015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AD9CE9DB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 15:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 127B23004609
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62A4268C42;
	Tue, 30 Dec 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brz8kQZi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D181254B03
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Dec 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103435; cv=none; b=rVnUu5MT+1cv/Sa5WxbnQuyIlLb6lc2jthPusuSxRxl4m9/QHvS5COEv+2sjF/n0wD2QzcjjiDn0xIemg+XFwiAePWAMDrKQ2w6+zOwgPkQ6kiLrUheTu6s6SxpA9cjZSc8Ag54Dl7B3hW8G0DMSmxLYx22B7ZNeRdkncEuyNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103435; c=relaxed/simple;
	bh=WPoufRWayld6ss/SYhD51ed6m8RXUHzxW8w8g4Chx8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLag0Qcx0pu3GHxc3xG4+02l0fJBxk1YZ+LR8nwSQ8pr2jdat3Ujn3goc3gdhlPYX7PQao1TG7PQszygv8UhV1YHg1kDoTYqefhupA+fNmBPip1yoKpYDf0uLpFTbOpgmGI7SP8UoqdN6XcFlyc43JwYdFpAyqoRW4c5+Mys71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Brz8kQZi; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59431f57bf6so9838595e87.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Dec 2025 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767103431; x=1767708231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/nwLbYNKtnshQbwvUaLIUG2J6xqJ7063t3j/p1UPp4=;
        b=Brz8kQZiI/c8dBKj8cKDDstNmj21EgueJhgxz2dAur6pml5SKZ5fi3CKhTDJd3MVH4
         Ih6GjVCals7j/Ud7W0FJ3PoyMXqOj9DZRcddmK830I1+qYQUNTrOzZlcVhm+8JE89686
         /dV4kN03yDCVKh2IDLqDXz9lIln1CN9bvpiVdVOuc7J7YBCyP1yW0EyNvsR4LoYIC22y
         GugjrHIfOLeL0b9vTeT/Ux0HBmwZD46ZmTYVMHjSKEc8wM+uGnSWfYEQSzN/s8BJQ6Zc
         I+jmLpjXHSD60919hKcU22jlTgAOglowp8EEM0VyCilExXk+ChLe4n3kttfkmkFvjXP/
         M+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767103431; x=1767708231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/nwLbYNKtnshQbwvUaLIUG2J6xqJ7063t3j/p1UPp4=;
        b=BZgwpWJ/v1gZtDmZcTYLLUl4aAqxhwgxyxVD7HBFT0kxPSnUiMTJZ5RTBd1QM96P83
         HjDq12Vgkye7XC7ENynt/aLpqFmd0kJApb2ddw8Z1t3+qSBUUbk5go6rJsWqs/AK1tGS
         NKhSS7AheFJy99RqXBg1YpFz9zABqnF1QXxbpPdBThgh8SILusDBXky9WzEBUghhz+xw
         9jcJnyqB1lBIcj5h+uUZu/3O0xYbLD+mnNlE4ldNCbcT2r0Y4fwEd4I8S8z6psTn5DgO
         damuvVucDiCQgQEAO90Bq31+HQcBqubMh42vl37pNrgZgnc3f5VSCM2SxY0CxhyTMbYV
         db4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4C/Deazwt3801bAdw6Y7AB8OGivER6wkIJOoOkNDLCO/9Um15MiWkUEgN8NES2KhDQXsvuiK7osLthrQtFf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vJqx9Rqgksg/QfkdtYDFtZ8jnMdvAGTB3dWmdPF+xydCULZk
	RUYjnIpFWW3W3aGVtV3yPg/vzO73s3Gxs3TzCg/D2igRKtXVblCGBO9H
X-Gm-Gg: AY/fxX5QFnxjzjYT5ym1qSD6uELWf+jn/3K4G7JFW0pc/nucwMkrKcFLbwHnHm1L8yx
	HtCoY3ClvOJMwErEI2urmWPJTJDS3Nms2J5wyO0WS3JLtk4EmwIeBpDcZ3sy8J9LUF0jcjtzys6
	MlPoUxe8xD+RbImsHgsJdND9vZXnl8IaEu5LEgC2kIVZ3iTxV/JWjCgMuOD4Nt5a6FaRpL7wimw
	lpZArXb/pN0Fm+FYveKfCJnWLpZ00VwFAyz/Tfk/kMQLYUiG84fdFB1s2pIizotsfvQ3QmRA0r0
	IfwCpgk8rfHwW4dTulGeRuVZaLXTzBfaSMkvfIeV55KXxivpOWxIllQHijYh2hQqXRUCWc/3I0X
	QIMTXF/e3IhzJKW8YIumZ8h9TPmIPS34bXZoWgL/3zqHMCg+y/P1dxQ0KF9DNY9c00qMk2bRxMX
	Ubz+KQkAtRmLh+8UNtz28pnDuc80mOlC4/qq1Q/VYYXv1zdhH6/gQ8ll44ws6inYKDS8n3IaOZy
	eMH3JgC8SYghwB2
X-Google-Smtp-Source: AGHT+IFdefQF8ch2Z7s2KRkzdfYwQxrJGSRsMw+io52P+KbO/I4NVxkcOMeP815s5wDbCRJAPN8PGw==
X-Received: by 2002:a05:6512:32c5:b0:594:2b58:ab83 with SMTP id 2adb3069b0e04-59a17d581fbmr11615422e87.40.1767103431063;
        Tue, 30 Dec 2025 06:03:51 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861f7f5sm10191272e87.72.2025.12.30.06.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 06:03:50 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v4 net 2/2] selftests: net: simple selftest for ipvtap
Date: Tue, 30 Dec 2025 17:03:24 +0300
Message-ID: <20251230140333.2088391-3-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230140333.2088391-1-skorodumov.dmitry@huawei.com>
References: <20251230140333.2088391-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a simple ipvtap test to test handling
IP-address add/remove on ipvlan interface.

It creates a veth-interface and then creates several
network-namespace with ipvlan0 interface in it linked to veth.

Then it starts to add/remove addresses on ipvlan0 interfaces
in several threads.

At finish, it checks that there is no duplicated addresses.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
v4:
  - Removed unneeded modprobe
  - Number of threads is 8, if KSFT_MACHINE_SLOW==yes.
    It is needed, since on debug-build test may take more than 15 minutes.
  - Now veth is created in own namespace
  - Added comment about why test adds/removes random ip

 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   2 +
 tools/testing/selftests/net/ipvtap_test.sh | 166 +++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100755 tools/testing/selftests/net/ipvtap_test.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b66ba04f19d9..45c4ea381bc3 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -48,6 +48,7 @@ TEST_PROGS := \
 	ipv6_flowlabel.sh \
 	ipv6_force_forwarding.sh \
 	ipv6_route_update_soft_lockup.sh \
+	ipvtap_test.sh \
 	l2_tos_ttl_inherit.sh \
 	l2tp.sh \
 	link_netns.py \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 1e1f253118f5..5702ab8fa5ad 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -48,6 +48,7 @@ CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPV6_SIT=y
 CONFIG_IPV6_VTI=y
 CONFIG_IPVLAN=m
+CONFIG_IPVTAP=m
 CONFIG_KALLSYMS=y
 CONFIG_L2TP=m
 CONFIG_L2TP_ETH=m
@@ -122,6 +123,7 @@ CONFIG_TEST_BPF=m
 CONFIG_TLS=m
 CONFIG_TRACEPOINTS=y
 CONFIG_TUN=y
+CONFIG_TAP=m
 CONFIG_USER_NS=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=y
diff --git a/tools/testing/selftests/net/ipvtap_test.sh b/tools/testing/selftests/net/ipvtap_test.sh
new file mode 100755
index 000000000000..b4e18fc7ada0
--- /dev/null
+++ b/tools/testing/selftests/net/ipvtap_test.sh
@@ -0,0 +1,167 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Simple tests for ipvtap
+
+
+#
+# The testing environment looks this way:
+#
+# |------HNS-------|     |------PHY-------|
+# |      veth<----------------->veth      |
+# |------|--|------|     |----------------|
+#        |  |
+#        |  |            |-----TST0-------|
+#        |  |------------|----ipvlan      |
+#        |               |----------------|
+#        |
+#        |               |-----TST1-------|
+#        |---------------|----ipvlan      |
+#                        |----------------|
+#
+
+ALL_TESTS="
+	test_ip_set
+"
+
+source lib.sh
+
+DEBUG=0
+
+VETH_HOST=vethtst.h
+VETH_PHY=vethtst.p
+
+NS_COUNT=32
+IP_ITERATIONS=1024
+[ "$KSFT_MACHINE_SLOW" = "yes" ] && NS_COUNT=8
+
+ns_run() {
+	ns=$1
+	shift
+	if [[ "$ns" == "global" ]]; then
+		"$@" >/dev/null
+	else
+		ip netns exec "$ns" "$@" >/dev/null
+	fi
+}
+
+test_ip_setup_env() {
+	setup_ns NS_PHY
+	setup_ns HST_NS
+
+	# setup simulated other-host (phy) and host itself
+	ns_run "$HST_NS" ip link add $VETH_HOST type veth peer name $VETH_PHY \
+		netns "$NS_PHY" >/dev/null
+	ns_run "$HST_NS" ip link set $VETH_HOST up
+	ns_run "$NS_PHY" ip link set $VETH_PHY up
+
+	for ((i=0; i<NS_COUNT; i++)); do
+		setup_ns ipvlan_ns_$i
+		ns="ipvlan_ns_$i"
+		if [ "$DEBUG" = "1" ]; then
+			echo "created NS ${!ns}"
+		fi
+		if ! ns_run "$HST_NS" ip link add netns ${!ns} ipvlan0 \
+		    link $VETH_HOST \
+		    type ipvtap mode l2 bridge; then
+			exit_error "FAIL: Failed to configure ipvlan link."
+		fi
+	done
+}
+
+test_ip_cleanup_env() {
+	ns_run "$HST_NS" ip link del $VETH_HOST
+	cleanup_all_ns
+}
+
+exit_error() {
+	echo "$1"
+	exit $ksft_fail
+}
+
+rnd() {
+	echo $(( RANDOM % 32 + 16 ))
+}
+
+test_ip_set_thread() {
+	# Here we are trying to create some IP conflicts between namespaces.
+	# If just add/remove IP, nothing interesting will happen.
+	# But if add random IP and then remove random IP,
+	# eventually conflicts start to apear.
+	ip link set ipvlan0 up
+	for ((i=0; i<IP_ITERATIONS; i++)); do
+		v=$(rnd)
+		ip a a "172.25.0.$v/24" dev ipvlan0 2>/dev/null
+		ip a a "fc00::$v/64" dev ipvlan0 2>/dev/null
+		v=$(rnd)
+		ip a d "172.25.0.$v/24" dev ipvlan0 2>/dev/null
+		ip a d "fc00::$v/64" dev ipvlan0 2>/dev/null
+	done
+}
+
+test_ip_set() {
+	RET=0
+
+	trap test_ip_cleanup_env EXIT
+
+	test_ip_setup_env
+
+	declare -A ns_pids
+	for ((i=0; i<NS_COUNT; i++)); do
+		ns="ipvlan_ns_$i"
+		ns_run ${!ns} bash -c "$0 test_ip_set_thread"&
+		ns_pids[$i]=$!
+	done
+
+	for ((i=0; i<NS_COUNT; i++)); do
+		wait "${ns_pids[$i]}"
+	done
+
+	declare -A all_ips
+	for ((i=0; i<NS_COUNT; i++)); do
+		ns="ipvlan_ns_$i"
+		ip_output=$(ip netns exec ${!ns} ip a l dev ipvlan0 | grep inet)
+		while IFS= read -r nsip_out; do
+			if [[ -z $nsip_out ]]; then
+				continue;
+			fi
+			nsip=$(awk '{print $2}' <<< "$nsip_out")
+			if [[ -v all_ips[$nsip] ]]; then
+				RET=$ksft_fail
+				log_test "conflict for $nsip"
+				return "$RET"
+			else
+				all_ips[$nsip]=$i
+			fi
+		done <<< "$ip_output"
+	done
+
+	if [ "$DEBUG" = "1" ]; then
+		for key in "${!all_ips[@]}"; do
+			echo "$key: ${all_ips[$key]}"
+		done
+	fi
+
+	trap - EXIT
+	test_ip_cleanup_env
+
+	log_test "test multithreaded ip set"
+}
+
+if [[ "$1" == "-d" ]]; then
+	DEBUG=1
+	shift
+fi
+
+if [[ "$1" == "-t" ]]; then
+	shift
+	TESTS="$*"
+fi
+
+if [[ "$1" == "test_ip_set_thread" ]]; then
+	test_ip_set_thread
+else
+	require_command ip
+
+	tests_run
+fi
-- 
2.43.0



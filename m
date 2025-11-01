Return-Path: <linux-kselftest+bounces-44585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 068ECC28476
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 18:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7026B4E5614
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 17:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C462FD69B;
	Sat,  1 Nov 2025 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX09LgCR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054512FD691;
	Sat,  1 Nov 2025 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762019840; cv=none; b=rnzuWhcEJlTXcwO3obxoZLVJ7X7ze4gE0++eVVRih33c5K2GEd0LfElYuE2/zJ022mKPT/xgFgDPUwbFvhgAG7Ag5kum84t/0mXAaa2lsjwGkl5BdqqNMQe89wilWax/5NqFWEVVdj9ALu83kBM/xVKZqJOHXjExwCGtiAOJL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762019840; c=relaxed/simple;
	bh=in42XnovMXeVQqZbDa2ZCxwTuNrF6sz8oX+pUPjugkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ls3FFqH7Ff9dDEwYrQD4MEsefQtMrVraj0j0jpmwndJ0DcEOnzaXMScacWsV0xdU4lj6OniGwGe5HRM0qqGJNRHXL1tPWHg32SKK8NyvLKgrGAmSEmc4i3SlIUFXZYqOVm0ekHfhDFubwsnF4dBoErOgAFoIR7wlZkqNsyIaTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX09LgCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97E0C4CEFB;
	Sat,  1 Nov 2025 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762019839;
	bh=in42XnovMXeVQqZbDa2ZCxwTuNrF6sz8oX+pUPjugkw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TX09LgCRjL//NZFSuJbnsLprNO+I4shNwhohXNpiHNEgaz1ziN1C4Dp4EQw4Uripk
	 +Nt5hppo/IGz3pADXkxV1WHKbIv+P4t9w3Zvevcc/lb/JNMEeyIoY0PGpHxBjZRVMw
	 hghF1l2PD3i5CGxMfI2orTgogWLoTInXQD4JJOLIYw92KsFHmbm71fUKswtRoWpk0m
	 NXcPc+27K4FMDV/LClP2ojNvD66FNN2CqrDisISQwnWSWZIPQnWk+dfoXjLUHLE6JC
	 WFFL2nPt6nPEKD13Mzr9YRkeIzmApceKfeFqbTMyUKAChEAOtRQqp8LvVxcSzEuvNp
	 RpMXYypMZ8tTg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 01 Nov 2025 18:56:54 +0100
Subject: [PATCH net-next 4/4] selftests: mptcp: join: validate extra bind
 cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-4-b4166772d6bb@kernel.org>
References: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-0-b4166772d6bb@kernel.org>
In-Reply-To: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-0-b4166772d6bb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8916; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=in42XnovMXeVQqZbDa2ZCxwTuNrF6sz8oX+pUPjugkw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLZPD9NL2n4+3/P2bTGmSW2iSsdF577tuioynFHs4/SX
 1l8rP8Wd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEfjLDf1++rFVNsjH6SxdK
 7574ff/VnCVPnp3nrHsSlTsjIKz51TWGf/pcIietnnzaL1sU/8bMfv31mHt3/wqx8m8Lsrh9SHn
 3UQ4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

By design, an MPTCP connection will not accept extra subflows where no
MPTCP listening sockets can accept such requests.

In other words, it means that if the 'server' listens on a specific
address / device, it cannot accept MP_JOIN sent to a different address /
device. Except if there is another MPTCP listening socket accepting
them.

This is what the new tests are validating:

 - Forcing a bind on the main v4/v6 address, and checking that MP_JOIN
   to announced addresses are not accepted.

 - Also forcing a bind on the main v4/v6 address, but before, another
   listening socket is created to accept additional subflows. Note that
   'mptcpize run nc -l' -- or something else only doing: socket(MPTCP),
   bind(<IP>), listen(0) -- would be enough, but here mptcp_connect is
   reused not to depend on another tool just for that.

 - Same as the previous one, but using v6 link-local addresses: this is
   a bit particular because it is required to specify the outgoing
   network interface when connecting to a link-local address announced
   by the other peer. When using the routing rules, this doesn't work
   (the outgoing interface is not known) ; but it does work with a
   'laminar' endpoint having a specified interface.

Note that extra small modifications are needed for these tests to work:

 - mptcp_connect's check_getpeername_connect() check should strip the
   specified interface when comparing addresses.

 - With IPv6 link-local addresses, it is required to wait for them to
   be ready (no longer in 'tentative' mode) before using them, otherwise
   the bind() will not be allowed.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/591
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  10 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 153 +++++++++++++++++++++-
 2 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index b148cadb96d0..c030b08a7195 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1064,6 +1064,8 @@ static void check_getpeername_connect(int fd)
 	socklen_t salen = sizeof(ss);
 	char a[INET6_ADDRSTRLEN];
 	char b[INET6_ADDRSTRLEN];
+	const char *iface;
+	size_t len;
 
 	if (getpeername(fd, (struct sockaddr *)&ss, &salen) < 0) {
 		perror("getpeername");
@@ -1073,7 +1075,13 @@ static void check_getpeername_connect(int fd)
 	xgetnameinfo((struct sockaddr *)&ss, salen,
 		     a, sizeof(a), b, sizeof(b));
 
-	if (strcmp(cfg_host, a) || strcmp(cfg_port, b))
+	iface = strchr(cfg_host, '%');
+	if (iface)
+		len = iface - cfg_host;
+	else
+		len = strlen(cfg_host) + 1;
+
+	if (strncmp(cfg_host, a, len) || strcmp(cfg_port, b))
 		fprintf(stderr, "%s: %s vs %s, %s vs %s\n", __func__,
 			cfg_host, a, cfg_port, b);
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4c9ee094381e..4faf58fecc94 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -62,6 +62,7 @@ unset sflags
 unset fastclose
 unset fullmesh
 unset speed
+unset bind_addr
 unset join_syn_rej
 unset join_csum_ns1
 unset join_csum_ns2
@@ -645,6 +646,27 @@ wait_mpj()
 	done
 }
 
+wait_ll_ready()
+{
+	local ns="${1}"
+
+	local i
+	for i in $(seq 50); do
+		ip -n "${ns}" -6 addr show scope link | grep "inet6 fe80" |
+			grep -qw "tentative" || break
+		sleep 0.1
+	done
+}
+
+get_ll_addr()
+{
+	local ns="${1}"
+	local iface="${2}"
+
+	ip -n "${ns}" -6 addr show dev "${iface}" scope link |
+		grep "inet6 fe80" | sed 's#.*\(fe80::.*\)/.*#\1#'
+}
+
 kill_events_pids()
 {
 	mptcp_lib_kill_wait $evts_ns1_pid
@@ -951,6 +973,7 @@ do_transfer()
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
+	local bind_addr=${bind_addr:-"::"}
 	local listener_in="${sin}"
 	local connector_in="${cin}"
 	port=$(get_port)
@@ -1006,7 +1029,7 @@ do_transfer()
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
 			./mptcp_connect -t ${timeout_poll} -l -p ${port} -s ${srv_proto} \
-				${extra_srv_args} "::" < "${listener_in}" > "${sout}" &
+				${extra_srv_args} "${bind_addr}" < "${listener_in}" > "${sout}" &
 	local spid=$!
 
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
@@ -3229,6 +3252,133 @@ add_addr_ports_tests()
 	fi
 }
 
+bind_tests()
+{
+	# bind to one address should not allow extra subflows to other addresses
+	if reset "bind main address v4, no join v4"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		bind_addr="10.0.1.1" \
+			run_tests $ns1 $ns2 10.0.1.1
+		join_syn_tx=1 \
+			chk_join_nr 0 0 0
+		chk_add_nr 1 1
+	fi
+
+	# bind to one address should not allow extra subflows to other addresses
+	if reset "bind main address v6, no join v6"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
+		bind_addr="dead:beef:1::1" \
+			run_tests $ns1 $ns2 dead:beef:1::1
+		join_syn_tx=1 \
+			chk_join_nr 0 0 0
+		chk_add_nr 1 1
+	fi
+
+	# multiple binds to allow extra subflows to other addresses
+	if reset "multiple bind to allow joins v4"; then
+		local extra_bind
+
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+
+		# Launching another app listening on a different address
+		# Note: it could be a totally different app, e.g. nc, socat, ...
+		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p "$(get_port)" \
+			-s MPTCP 10.0.2.1 &
+		extra_bind=$!
+
+		bind_addr="10.0.1.1" \
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+
+		kill ${extra_bind}
+	fi
+
+	# multiple binds to allow extra subflows to other addresses
+	if reset "multiple bind to allow joins v6"; then
+		local extra_bind
+
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
+
+		# Launching another app listening on a different address
+		# Note: it could be a totally different app, e.g. nc, socat, ...
+		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p "$(get_port)" \
+			-s MPTCP dead:beef:2::1 &
+		extra_bind=$!
+
+		bind_addr="dead:beef:1::1" \
+			run_tests $ns1 $ns2 dead:beef:1::1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+
+		kill ${extra_bind}
+	fi
+
+	# multiple binds to allow extra subflows to other addresses: v6 LL case
+	if reset "multiple bind to allow joins v6 link-local routing"; then
+		local extra_bind ns1ll1 ns1ll2
+
+		ns1ll1="$(get_ll_addr $ns1 ns1eth1)"
+		ns1ll2="$(get_ll_addr $ns1 ns1eth2)"
+
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 "${ns1ll2}" flags signal
+
+		wait_ll_ready $ns1 # to be able to bind
+		wait_ll_ready $ns2 # also needed to bind on the client side
+		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p "$(get_port)" \
+			-s MPTCP "${ns1ll2}%ns1eth2" &
+		extra_bind=$!
+
+		bind_addr="${ns1ll1}%ns1eth1" \
+			run_tests $ns1 $ns2 "${ns1ll1}%ns2eth1"
+		# it is not possible to connect to the announced LL addr without
+		# specifying the outgoing interface.
+		join_connect_err=1 \
+			chk_join_nr 0 0 0
+		chk_add_nr 1 1
+
+		kill ${extra_bind}
+	fi
+
+	# multiple binds to allow extra subflows to v6 LL addresses: laminar
+	if reset "multiple bind to allow joins v6 link-local laminar" &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+		local extra_bind ns1ll1 ns1ll2 ns2ll2
+
+		ns1ll1="$(get_ll_addr $ns1 ns1eth1)"
+		ns1ll2="$(get_ll_addr $ns1 ns1eth2)"
+		ns2ll2="$(get_ll_addr $ns2 ns2eth2)"
+
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 "${ns1ll2}" flags signal
+		pm_nl_add_endpoint $ns2 "${ns2ll2}" flags laminar dev ns2eth2
+
+		wait_ll_ready $ns1 # to be able to bind
+		wait_ll_ready $ns2 # also needed to bind on the client side
+		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p "$(get_port)" \
+			-s MPTCP "${ns1ll2}%ns1eth2" &
+		extra_bind=$!
+
+		bind_addr="${ns1ll1}%ns1eth1" \
+			run_tests $ns1 $ns2 "${ns1ll1}%ns2eth1"
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+
+		kill ${extra_bind}
+	fi
+}
+
 syncookies_tests()
 {
 	# single subflow, syncookies
@@ -4183,6 +4333,7 @@ all_tests_sorted=(
 	M@mixed_tests
 	b@backup_tests
 	p@add_addr_ports_tests
+	B@bind_tests
 	k@syncookies_tests
 	S@checksum_tests
 	d@deny_join_id0_tests

-- 
2.51.0



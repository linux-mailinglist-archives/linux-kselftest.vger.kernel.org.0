Return-Path: <linux-kselftest+bounces-3364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689428373DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 21:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A65BB244B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 20:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A13A8F0;
	Mon, 22 Jan 2024 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpYYAbXj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327A47A40;
	Mon, 22 Jan 2024 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955740; cv=none; b=dxQ4k59uSkZGpGV0iKy+GBaRM56N0PV0RfV+arpFG7UIDZjrvZtUYEW8R2WekWoNxpUm6p7Yxi7n8Xr5a3n0ZZ9H7HzQX5NUxtRHkob1d48vkkhnkr6dX+DyCszGxCRR0KXcjgfzw+in5f1VTeOwMlzJUyr+4ev4gY2LM7DepNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955740; c=relaxed/simple;
	bh=JkGc8IyQPIqwjSecvxXezPEjnK8PibvJovCtGictt3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InVBJeI0jVjzQmLrN7kN3pi5jmj/tLHbITg+MFxoQ6NRpIZC+AOv18yv6ws/e7q5t4xC+p+61EP7Q/eWWSBgzUFZVxukGOn7/Y278zYKyfOWN12+NGjfhmUaZbQITGSwVdI9lUzQycATatneoN3+Sz/oNmcbghF73dz3cPSF9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpYYAbXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2951C433C7;
	Mon, 22 Jan 2024 20:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955740;
	bh=JkGc8IyQPIqwjSecvxXezPEjnK8PibvJovCtGictt3w=;
	h=From:To:Cc:Subject:Date:From;
	b=GpYYAbXjsExEqt7ukw+bKZAr1WGMsX1EZBoCPwZo+Wpn4zskQec0zl+zUis0QP+hA
	 vVV6IObyD0iRPThSE7idDwaiq+drb5bRy9wnacPq5nnKT/x1ZYKFPfjJ5Fvnz/8BIv
	 oDSgILcD5G3Q7SoeDwf7XSXC6pOS9qQSu+5owAwRjsJ081JkKoJbUH0xVf8IXGab3J
	 jTO3hFGXQAQuC/esFtzfcijBZ+mVn62/tAGxeSdzxseasiMS/VvkcK/tLOMkHkXxT0
	 SzAZCrWeX9i7MPx0qtH9DdfNVqUwqL5qieBCEyPLKLctbnojme5/ZvWL8k2eyhZxVK
	 iu4l3l9rL6gOA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	kuniyu@amazon.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: fill in some missing configs for net
Date: Mon, 22 Jan 2024 12:35:28 -0800
Message-ID: <20240122203528.672004-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are missing a lot of config options from net selftests,
it seems:

tun/tap:     CONFIG_TUN, CONFIG_MACVLAN, CONFIG_MACVTAP
fib_tests:   CONFIG_NET_SCH_FQ_CODEL
l2tp:        CONFIG_L2TP, CONFIG_L2TP_V3, CONFIG_L2TP_IP, CONFIG_L2TP_ETH
sctp-vrf:    CONFIG_INET_DIAG
txtimestamp: CONFIG_NET_CLS_U32
vxlan_mdb:   CONFIG_BRIDGE_VLAN_FILTERING
gre_gso:     CONFIG_NET_IPGRE_DEMUX, CONFIG_IP_GRE, CONFIG_IPV6_GRE
srv6_end_dt*_l3vpn:   CONFIG_IPV6_SEG6_LWTUNNEL
ip_local_port_range:  CONFIG_MPTCP
fib_test:    CONFIG_NET_CLS_BASIC
rtnetlink:   CONFIG_MACSEC, CONFIG_NET_SCH_HTB, CONFIG_XFRM_INTERFACE
             CONFIG_NET_IPGRE, CONFIG_BONDING
fib_nexthops: CONFIG_MPLS, CONFIG_MPLS_ROUTING
vxlan_mdb:   CONFIG_NET_ACT_GACT
tls:         CONFIG_TLS, CONFIG_CRYPTO_CHACHA20POLY1305
psample:     CONFIG_PSAMPLE
fcnal:       CONFIG_TCP_MD5SIG

Try to add them in a semi-alphabetical order.

Fixes: 62199e3f1658 ("selftests: net: Add VXLAN MDB test")
Fixes: c12e0d5f267d ("self-tests: introduce self-tests for RPS default mask")
Fixes: ae5439658cce ("selftests/net: Cover the IP_LOCAL_PORT_RANGE socket option")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
These are not all the options we're missing. Since the merge window
is over I may not have the time to dig into it myself :(

Adding Fixes tag for 3 semi-random commits which I think missed things.
The full list would be very long.

CC: shuah@kernel.org
CC: razor@blackwall.org
CC: idosch@nvidia.com
CC: horms@kernel.org
CC: jakub@cloudflare.com
CC: kuniyu@amazon.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/config | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 8da562a9ae87..19ff75051660 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -1,5 +1,6 @@
 CONFIG_USER_NS=y
 CONFIG_NET_NS=y
+CONFIG_BONDING=m
 CONFIG_BPF_SYSCALL=y
 CONFIG_TEST_BPF=m
 CONFIG_NUMA=y
@@ -14,9 +15,13 @@ CONFIG_VETH=y
 CONFIG_NET_IPVTI=y
 CONFIG_IPV6_VTI=y
 CONFIG_DUMMY=y
+CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_BRIDGE=y
+CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_VLAN_8021Q=y
 CONFIG_IFB=y
+CONFIG_INET_DIAG=y
+CONFIG_IP_GRE=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NF_CONNTRACK=m
@@ -25,15 +30,36 @@ CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP6_NF_NAT=m
 CONFIG_IP_NF_NAT=m
+CONFIG_IPV6_GRE=m
+CONFIG_IPV6_SEG6_LWTUNNEL=y
+CONFIG_L2TP_ETH=m
+CONFIG_L2TP_IP=m
+CONFIG_L2TP=m
+CONFIG_L2TP_V3=y
+CONFIG_MACSEC=m
+CONFIG_MACVLAN=y
+CONFIG_MACVTAP=y
+CONFIG_MPLS=y
+CONFIG_MPTCP=y
 CONFIG_NF_TABLES=m
 CONFIG_NF_TABLES_IPV6=y
 CONFIG_NF_TABLES_IPV4=y
 CONFIG_NFT_NAT=m
+CONFIG_NET_ACT_GACT=m
+CONFIG_NET_CLS_BASIC=m
+CONFIG_NET_CLS_U32=m
+CONFIG_NET_IPGRE_DEMUX=m
+CONFIG_NET_IPGRE=m
+CONFIG_NET_SCH_FQ_CODEL=m
+CONFIG_NET_SCH_HTB=m
 CONFIG_NET_SCH_FQ=m
 CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_NETEM=y
+CONFIG_PSAMPLE=m
+CONFIG_TCP_MD5SIG=y
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_KALLSYMS=y
+CONFIG_TLS=m
 CONFIG_TRACEPOINTS=y
 CONFIG_NET_DROP_MONITOR=m
 CONFIG_NETDEVSIM=m
@@ -48,7 +74,9 @@ CONFIG_BAREUDP=m
 CONFIG_IPV6_IOAM6_LWTUNNEL=y
 CONFIG_CRYPTO_SM4_GENERIC=y
 CONFIG_AMT=m
+CONFIG_TUN=y
 CONFIG_VXLAN=m
 CONFIG_IP_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
 CONFIG_CRYPTO_ARIA=y
+CONFIG_XFRM_INTERFACE=m
-- 
2.43.0



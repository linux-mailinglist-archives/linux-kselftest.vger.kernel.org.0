Return-Path: <linux-kselftest+bounces-42741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB39BB827A
	for <lists+linux-kselftest@lfdr.de>; Fri, 03 Oct 2025 22:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 667B44E8429
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797272561B6;
	Fri,  3 Oct 2025 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPTEV3rc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E2221264;
	Fri,  3 Oct 2025 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525061; cv=none; b=oNaO2wl4n1+rEeXU9sEzAycSxWw86TT2HFXUoFqe8HrTnBNzFXraH461+dxVlV4mNmofyaIKFgMk9REkq8WnXRfBwjzEVP/K3gfaycCCswQz39eLp1Lv0ZCbNRlDE/zdWaZesAjGhcnrXxzc2ukbGIPgCbG+PukcMKlfNKoRgco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525061; c=relaxed/simple;
	bh=repfiGxh0uBEbAwntWKMavT38FNb7ANrRUXZEfcL8Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRq97Zd8JuFEzg1+Orasxxc8bGPuD+tZZZti9dHBkMv+M/WhoR+Lvty3cmhA5gS9wEfFUSCLrkWhZeEBzge24oAikSzDVv2gYCFiEthK85uTa5i4Sjs3LWSHKmbTnehCAePQl3pqmYY0XRxReIxCUz7UqyQhbYmBco5BQenM9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPTEV3rc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1045C4CEF5;
	Fri,  3 Oct 2025 20:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759525060;
	bh=repfiGxh0uBEbAwntWKMavT38FNb7ANrRUXZEfcL8Vg=;
	h=From:To:Cc:Subject:Date:From;
	b=oPTEV3rc3CyRV47kxXJ3FhFyP2qwnAXzQOPeIMfftjx3wQhn6luN7tA8pkLESjx/O
	 Pkmk5kG/hwJ4XAp+gQW8JT8ILnStP/u91ow31UulmV/wnSNuhOVcSSlTpJOtZfdLVd
	 jBRqfErPkSFVhgHlHRsy6dEvPgacckruI1yUFv29dKZvAkX96rZr97XBhL1GlEhJ2k
	 NA3bPxTOUX+oTLQIBWA4yiZlA1pA2H4cm66m+sm9qgo9sKUfVuCD4ekaV3qIIrtzJG
	 8COXWE/KsNjwTVieOnbI2swjieV4PTRLmgu1A+T0y1SBN+pVhHflcDxQxLZVjetOzL
	 /Kl2BI3uV6wlQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Phil Sutter <phil@nwl.cc>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Antonio Quartulli <antonio@openvpn.net>,
	jv@jvosburgh.net,
	shuah@kernel.org,
	kuniyu@google.com,
	martineau@kernel.org,
	geliang@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	sd@queasysnail.net,
	razor@blackwall.org,
	idosch@nvidia.com,
	yongwang@nvidia.com,
	jiri@resnulli.us,
	danishanwar@ti.com,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH net repost] selftests: net: sort configs
Date: Fri,  3 Oct 2025 13:57:36 -0700
Message-ID: <20251003205736.1019673-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort config files for networking selftests. This should help us
avoid merge conflicts between net and net-next. patchwork check
will be added to prevent new issues.

Acked-by: Phil Sutter <phil@nwl.cc>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Acked-by: Florian Westphal <fw@strlen.de>
Acked-by: Antonio Quartulli <antonio@openvpn.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
repost after the PR made the tree designation correct
v1: https://lore.kernel.org/20251002015245.3209033-1-kuba@kernel.org

CC: jv@jvosburgh.net
CC: shuah@kernel.org
CC: kuniyu@google.com
CC: martineau@kernel.org
CC: geliang@kernel.org
CC: pablo@netfilter.org
CC: kadlec@netfilter.org
CC: sd@queasysnail.net
CC: razor@blackwall.org
CC: idosch@nvidia.com
CC: yongwang@nvidia.com
CC: jiri@resnulli.us
CC: danishanwar@ti.com
CC: linux-kselftest@vger.kernel.org
CC: mptcp@lists.linux.dev
CC: netfilter-devel@vger.kernel.org
CC: coreteam@netfilter.org
---
 .../selftests/drivers/net/bonding/config      |   8 +-
 tools/testing/selftests/drivers/net/config    |   2 +-
 tools/testing/selftests/net/af_unix/config    |   2 +-
 tools/testing/selftests/net/config            | 140 +++++++++---------
 tools/testing/selftests/net/forwarding/config |  34 ++---
 tools/testing/selftests/net/hsr/config        |   4 +-
 tools/testing/selftests/net/mptcp/config      |  48 +++---
 tools/testing/selftests/net/netfilter/config  |  58 ++++----
 tools/testing/selftests/net/ovpn/config       |  12 +-
 .../testing/selftests/net/packetdrill/config  |   4 +-
 tools/testing/selftests/net/tcp_ao/config     |   2 +-
 11 files changed, 157 insertions(+), 157 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index e5b7a8db4dfa..6bb290abd48b 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -1,17 +1,17 @@
 CONFIG_BONDING=y
 CONFIG_BRIDGE=y
 CONFIG_DUMMY=y
+CONFIG_INET_ESP=y
+CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_IPV6=y
-CONFIG_MACVLAN=y
 CONFIG_IPVLAN=y
+CONFIG_MACVLAN=y
 CONFIG_NET_ACT_GACT=y
 CONFIG_NET_CLS_FLOWER=y
 CONFIG_NET_CLS_MATCHALL=m
+CONFIG_NETDEVSIM=m
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=m
-CONFIG_INET_ESP=y
-CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_XFRM_USER=m
-CONFIG_NETDEVSIM=m
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 601431248d5b..77ccf83d87e0 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -3,8 +3,8 @@ CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_BTF_MODULES=n
 CONFIG_INET_PSP=y
 CONFIG_IPV6=y
-CONFIG_NETDEVSIM=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
+CONFIG_NETDEVSIM=m
 CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/net/af_unix/config b/tools/testing/selftests/net/af_unix/config
index 37368567768c..b5429c15a53c 100644
--- a/tools/testing/selftests/net/af_unix/config
+++ b/tools/testing/selftests/net/af_unix/config
@@ -1,3 +1,3 @@
-CONFIG_UNIX=y
 CONFIG_AF_UNIX_OOB=y
+CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d548611e2698..1e1f253118f5 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -1,130 +1,130 @@
-CONFIG_USER_NS=y
-CONFIG_NET_NS=y
+CONFIG_AMT=m
+CONFIG_BAREUDP=m
 CONFIG_BONDING=m
 CONFIG_BPF_SYSCALL=y
-CONFIG_TEST_BPF=m
-CONFIG_NUMA=y
-CONFIG_RPS=y
-CONFIG_SYSFS=y
-CONFIG_PROC_SYSCTL=y
-CONFIG_NET_VRF=y
-CONFIG_NET_L3_MASTER_DEV=y
-CONFIG_IPV6=y
-CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_VETH=y
-CONFIG_NET_IPVTI=y
-CONFIG_IPV6_VTI=y
-CONFIG_DUMMY=y
-CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_BRIDGE=y
+CONFIG_BRIDGE_VLAN_FILTERING=y
+CONFIG_CAN=m
+CONFIG_CAN_DEV=m
+CONFIG_CAN_VXCAN=m
+CONFIG_CRYPTO_ARIA=y
 CONFIG_CRYPTO_CHACHA20POLY1305=m
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SM4_GENERIC=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_BTF_MODULES=n
-CONFIG_VLAN_8021Q=y
+CONFIG_DUMMY=y
 CONFIG_GENEVE=m
 CONFIG_IFB=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_ESP=y
 CONFIG_INET_ESP_OFFLOAD=y
-CONFIG_CRYPTO_SHA1=y
-CONFIG_NET_FOU=y
-CONFIG_NET_FOU_IP_TUNNELS=y
-CONFIG_NETFILTER=y
-CONFIG_NETFILTER_ADVANCED=y
-CONFIG_NETFILTER_XTABLES_LEGACY=y
-CONFIG_NF_CONNTRACK=m
-CONFIG_IPV6_MROUTE=y
-CONFIG_IPV6_SIT=y
-CONFIG_NF_NAT=m
+CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_IPTABLES_LEGACY=m
-CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_IPTABLES_LEGACY=m
 CONFIG_IP6_NF_MANGLE=m
-CONFIG_IP6_NF_FILTER=m
+CONFIG_IP6_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_NAT=m
 CONFIG_IP6_NF_RAW=m
-CONFIG_IP_NF_MANGLE=m
+CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_IPTABLES_LEGACY=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_IP_NF_MATCH_RPFILTER=m
 CONFIG_IP_NF_NAT=m
 CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP_NF_TARGET_TTL=m
+CONFIG_IP_SCTP=m
+CONFIG_IPV6=y
 CONFIG_IPV6_GRE=m
+CONFIG_IPV6_ILA=m
+CONFIG_IPV6_IOAM6_LWTUNNEL=y
+CONFIG_IPV6_MROUTE=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_RPL_LWTUNNEL=y
 CONFIG_IPV6_SEG6_LWTUNNEL=y
+CONFIG_IPV6_SIT=y
+CONFIG_IPV6_VTI=y
+CONFIG_IPVLAN=m
+CONFIG_KALLSYMS=y
+CONFIG_L2TP=m
 CONFIG_L2TP_ETH=m
 CONFIG_L2TP_IP=m
-CONFIG_L2TP=m
 CONFIG_L2TP_V3=y
 CONFIG_MACSEC=m
 CONFIG_MACVLAN=y
 CONFIG_MACVTAP=y
 CONFIG_MPLS=y
+CONFIG_MPLS_IPTUNNEL=m
+CONFIG_MPLS_ROUTING=m
 CONFIG_MPTCP=y
-CONFIG_NF_TABLES=m
-CONFIG_NF_TABLES_IPV6=y
-CONFIG_NF_TABLES_IPV4=y
-CONFIG_NFT_NAT=m
-CONFIG_NETFILTER_XT_MATCH_LENGTH=m
-CONFIG_NETFILTER_XT_TARGET_HL=m
-CONFIG_NETFILTER_XT_NAT=m
 CONFIG_NET_ACT_CSUM=m
 CONFIG_NET_ACT_CT=m
 CONFIG_NET_ACT_GACT=m
+CONFIG_NET_ACT_MIRRED=m
 CONFIG_NET_ACT_PEDIT=m
+CONFIG_NET_ACT_TUNNEL_KEY=m
 CONFIG_NET_CLS_BASIC=m
 CONFIG_NET_CLS_BPF=m
+CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NET_CLS_U32=m
-CONFIG_NET_IPGRE_DEMUX=m
+CONFIG_NETDEVSIM=m
+CONFIG_NET_DROP_MONITOR=m
+CONFIG_NETFILTER=y
+CONFIG_NETFILTER_ADVANCED=y
+CONFIG_NETFILTER_XTABLES_LEGACY=y
+CONFIG_NETFILTER_XT_MATCH_LENGTH=m
+CONFIG_NETFILTER_XT_MATCH_POLICY=m
+CONFIG_NETFILTER_XT_NAT=m
+CONFIG_NETFILTER_XT_TARGET_HL=m
+CONFIG_NET_FOU=y
+CONFIG_NET_FOU_IP_TUNNELS=y
 CONFIG_NET_IPGRE=m
+CONFIG_NET_IPGRE_DEMUX=m
 CONFIG_NET_IPIP=y
+CONFIG_NET_IPVTI=y
+CONFIG_NETKIT=y
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_NET_NS=y
+CONFIG_NET_PKTGEN=m
+CONFIG_NET_SCH_ETF=m
+CONFIG_NET_SCH_FQ=m
 CONFIG_NET_SCH_FQ_CODEL=m
 CONFIG_NET_SCH_HTB=m
-CONFIG_NET_SCH_FQ=m
-CONFIG_NET_SCH_ETF=m
+CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_SCH_NETEM=y
 CONFIG_NET_SCH_PRIO=m
-CONFIG_NFT_COMPAT=m
+CONFIG_NET_VRF=y
+CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_OVS=y
 CONFIG_NF_FLOW_TABLE=m
+CONFIG_NF_NAT=m
+CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_IPV4=y
+CONFIG_NF_TABLES_IPV6=y
+CONFIG_NFT_COMPAT=m
+CONFIG_NFT_NAT=m
+CONFIG_NUMA=y
 CONFIG_OPENVSWITCH=m
 CONFIG_OPENVSWITCH_GENEVE=m
 CONFIG_OPENVSWITCH_GRE=m
 CONFIG_OPENVSWITCH_VXLAN=m
+CONFIG_PROC_SYSCTL=y
 CONFIG_PSAMPLE=m
+CONFIG_RPS=y
+CONFIG_SYSFS=y
 CONFIG_TCP_MD5SIG=y
 CONFIG_TEST_BLACKHOLE_DEV=m
-CONFIG_KALLSYMS=y
+CONFIG_TEST_BPF=m
 CONFIG_TLS=m
 CONFIG_TRACEPOINTS=y
-CONFIG_NET_DROP_MONITOR=m
-CONFIG_NETDEVSIM=m
-CONFIG_MPLS_ROUTING=m
-CONFIG_MPLS_IPTUNNEL=m
-CONFIG_NET_SCH_INGRESS=m
-CONFIG_NET_CLS_FLOWER=m
-CONFIG_NET_ACT_TUNNEL_KEY=m
-CONFIG_NET_ACT_MIRRED=m
-CONFIG_BAREUDP=m
-CONFIG_IPV6_IOAM6_LWTUNNEL=y
-CONFIG_CRYPTO_SM4_GENERIC=y
-CONFIG_AMT=m
 CONFIG_TUN=y
+CONFIG_USER_NS=y
+CONFIG_VETH=y
+CONFIG_VLAN_8021Q=y
 CONFIG_VXLAN=m
-CONFIG_IP_SCTP=m
-CONFIG_NETFILTER_XT_MATCH_POLICY=m
-CONFIG_CRYPTO_ARIA=y
 CONFIG_XFRM_INTERFACE=m
 CONFIG_XFRM_USER=m
-CONFIG_IP_NF_MATCH_RPFILTER=m
-CONFIG_IP6_NF_MATCH_RPFILTER=m
-CONFIG_IPVLAN=m
-CONFIG_CAN=m
-CONFIG_CAN_DEV=m
-CONFIG_CAN_VXCAN=m
-CONFIG_NETKIT=y
-CONFIG_NET_PKTGEN=m
-CONFIG_IPV6_ILA=m
-CONFIG_IPV6_RPL_LWTUNNEL=y
diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index 18fd69d8d937..ce64518aaa11 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -1,24 +1,23 @@
-CONFIG_BRIDGE=m
-CONFIG_VLAN_8021Q=m
-CONFIG_BRIDGE_VLAN_FILTERING=y
-CONFIG_BRIDGE_IGMP_SNOOPING=y
-CONFIG_NET_L3_MASTER_DEV=y
-CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_NET_VRF=m
 CONFIG_BPF_SYSCALL=y
+CONFIG_BRIDGE=m
+CONFIG_BRIDGE_IGMP_SNOOPING=y
+CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_CGROUP_BPF=y
 CONFIG_DUMMY=m
-CONFIG_IPV6=y
-CONFIG_IPV6_GRE=m
-CONFIG_IPV6_MROUTE=y
-CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
-CONFIG_IPV6_PIMSM_V2=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
+CONFIG_IPV6=y
+CONFIG_IPV6_GRE=m
+CONFIG_IPV6_MROUTE=y
+CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_PIMSM_V2=y
 CONFIG_MACVLAN=m
+CONFIG_NAMESPACES=y
 CONFIG_NET_ACT_CT=m
+CONFIG_NET_ACT_GACT=m
 CONFIG_NET_ACT_MIRRED=m
 CONFIG_NET_ACT_MPLS=m
 CONFIG_NET_ACT_PEDIT=m
@@ -27,29 +26,30 @@ CONFIG_NET_ACT_SAMPLE=m
 CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_NET_ACT_TUNNEL_KEY=m
 CONFIG_NET_ACT_VLAN=m
+CONFIG_NET_CLS_BASIC=m
 CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_CLS_MATCHALL=m
-CONFIG_NET_CLS_BASIC=m
 CONFIG_NET_EMATCH=y
 CONFIG_NET_EMATCH_META=m
+CONFIG_NETFILTER=y
 CONFIG_NET_IPGRE=m
 CONFIG_NET_IPGRE_DEMUX=m
 CONFIG_NET_IPIP=m
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_NET_NS=y
 CONFIG_NET_SCH_ETS=m
 CONFIG_NET_SCH_INGRESS=m
-CONFIG_NET_ACT_GACT=m
 CONFIG_NET_SCH_PRIO=m
 CONFIG_NET_SCH_RED=m
 CONFIG_NET_SCH_TBF=m
 CONFIG_NET_TC_SKB_EXT=y
 CONFIG_NET_TEAM=y
 CONFIG_NET_TEAM_MODE_LOADBALANCE=y
-CONFIG_NETFILTER=y
+CONFIG_NET_VRF=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NF_TABLES=m
 CONFIG_VETH=m
-CONFIG_NAMESPACES=y
-CONFIG_NET_NS=y
+CONFIG_VLAN_8021Q=m
 CONFIG_VXLAN=m
 CONFIG_XFRM_USER=m
diff --git a/tools/testing/selftests/net/hsr/config b/tools/testing/selftests/net/hsr/config
index 555a868743f0..205cc4d3d64b 100644
--- a/tools/testing/selftests/net/hsr/config
+++ b/tools/testing/selftests/net/hsr/config
@@ -1,6 +1,6 @@
+CONFIG_BRIDGE=y
+CONFIG_HSR=y
 CONFIG_IPV6=y
 CONFIG_NET_SCH_NETEM=m
-CONFIG_HSR=y
 CONFIG_VETH=y
-CONFIG_BRIDGE=y
 CONFIG_VLAN_8021Q=m
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 968d440c03fe..59051ee2a986 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,36 +1,36 @@
-CONFIG_KALLSYMS=y
-CONFIG_MPTCP=y
-CONFIG_IPV6=y
-CONFIG_MPTCP_IPV6=y
 CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
-CONFIG_VETH=y
-CONFIG_NET_SCH_NETEM=m
-CONFIG_SYN_COOKIES=y
+CONFIG_IP6_NF_FILTER=m
+CONFIG_IP6_NF_TARGET_REJECT=m
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IPV6=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_KALLSYMS=y
+CONFIG_MPTCP=y
+CONFIG_MPTCP_IPV6=y
+CONFIG_NET_ACT_CSUM=m
+CONFIG_NET_ACT_PEDIT=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_CLS_FW=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_NETLINK=m
-CONFIG_NF_TABLES=m
-CONFIG_NFT_COMPAT=m
 CONFIG_NETFILTER_XTABLES=m
 CONFIG_NETFILTER_XTABLES_LEGACY=y
 CONFIG_NETFILTER_XT_MATCH_BPF=m
 CONFIG_NETFILTER_XT_MATCH_LENGTH=m
 CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
-CONFIG_NF_TABLES_INET=y
-CONFIG_NFT_TPROXY=m
-CONFIG_NFT_SOCKET=m
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_NF_FILTER=m
-CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP6_NF_TARGET_REJECT=m
-CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_IP6_NF_FILTER=m
-CONFIG_NET_ACT_CSUM=m
-CONFIG_NET_ACT_PEDIT=m
-CONFIG_NET_CLS_ACT=y
-CONFIG_NET_CLS_FW=m
 CONFIG_NET_SCH_INGRESS=m
+CONFIG_NET_SCH_NETEM=m
+CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_INET=y
+CONFIG_NFT_COMPAT=m
+CONFIG_NFT_SOCKET=m
+CONFIG_NFT_TPROXY=m
+CONFIG_SYN_COOKIES=y
+CONFIG_VETH=y
diff --git a/tools/testing/selftests/net/netfilter/config b/tools/testing/selftests/net/netfilter/config
index 305e46b819cb..12ce61fa15a8 100644
--- a/tools/testing/selftests/net/netfilter/config
+++ b/tools/testing/selftests/net/netfilter/config
@@ -1,77 +1,80 @@
 CONFIG_AUDIT=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_BRIDGE=m
-CONFIG_NETFILTER_XTABLES_LEGACY=y
-CONFIG_BRIDGE_NF_EBTABLES_LEGACY=m
 CONFIG_BRIDGE_EBT_BROUTE=m
 CONFIG_BRIDGE_EBT_IP=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_T_FILTER=m
 CONFIG_BRIDGE_NETFILTER=m
 CONFIG_BRIDGE_NF_EBTABLES=m
+CONFIG_BRIDGE_NF_EBTABLES_LEGACY=m
 CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_CGROUP_BPF=y
-CONFIG_DUMMY=m
-CONFIG_INET_ESP=m
 CONFIG_CRYPTO_SHA1=m
-CONFIG_IP_NF_MATCH_RPFILTER=m
-CONFIG_IP6_NF_MATCH_RPFILTER=m
-CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_IPTABLES_LEGACY=m
+CONFIG_DUMMY=m
+CONFIG_INET_DIAG=m
+CONFIG_INET_ESP=m
+CONFIG_INET_SCTP_DIAG=m
+CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_IPTABLES_LEGACY=m
-CONFIG_IP_NF_NAT=m
-CONFIG_IP_NF_FILTER=m
-CONFIG_IP6_NF_FILTER=m
-CONFIG_IP_NF_RAW=m
+CONFIG_IP6_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_RAW=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_IPTABLES_LEGACY=m
+CONFIG_IP_NF_MATCH_RPFILTER=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_RAW=m
 CONFIG_IP_SCTP=m
+CONFIG_IPV6=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IP_VS=m
 CONFIG_IP_VS_PROTO_TCP=y
 CONFIG_IP_VS_RR=m
-CONFIG_IPV6=y
-CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_MACVLAN=m
 CONFIG_NAMESPACES=y
 CONFIG_NET_CLS_U32=m
-CONFIG_NET_L3_MASTER_DEV=y
-CONFIG_NET_NS=y
-CONFIG_NET_SCH_NETEM=m
-CONFIG_NET_SCH_HTB=m
-CONFIG_NET_IPIP=m
-CONFIG_NET_VRF=y
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_NETLINK=m
 CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NETFILTER_SYNPROXY=m
 CONFIG_NETFILTER_XTABLES=m
-CONFIG_NETFILTER_XT_NAT=m
+CONFIG_NETFILTER_XTABLES_LEGACY=y
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
+CONFIG_NETFILTER_XT_NAT=m
 CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
+CONFIG_NET_IPIP=m
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_NET_NS=y
+CONFIG_NET_PKTGEN=m
+CONFIG_NET_SCH_HTB=m
+CONFIG_NET_SCH_NETEM=m
+CONFIG_NET_VRF=y
 CONFIG_NF_CONNTRACK=m
-CONFIG_NF_CONNTRACK_PROCFS=y
 CONFIG_NF_CONNTRACK_EVENTS=y
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NF_CONNTRACK_PROCFS=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CT_NETLINK=m
 CONFIG_NF_CT_PROTO_SCTP=y
 CONFIG_NF_FLOW_TABLE=m
+CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NF_LOG_IPV4=m
 CONFIG_NF_LOG_IPV6=m
 CONFIG_NF_NAT=m
-CONFIG_NF_NAT_REDIRECT=y
 CONFIG_NF_NAT_MASQUERADE=y
+CONFIG_NF_NAT_REDIRECT=y
 CONFIG_NF_TABLES=m
 CONFIG_NF_TABLES_BRIDGE=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_IPV4=y
 CONFIG_NF_TABLES_IPV6=y
 CONFIG_NF_TABLES_NETDEV=y
-CONFIG_NF_FLOW_TABLE_INET=m
 CONFIG_NFT_BRIDGE_META=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NFT_CT=m
@@ -90,12 +93,9 @@ CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_SYNPROXY=m
 CONFIG_NFT_TPROXY=m
+CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_VLAN_8021Q=m
 CONFIG_VXLAN=m
-CONFIG_XFRM_USER=m
 CONFIG_XFRM_STATISTICS=y
-CONFIG_NET_PKTGEN=m
-CONFIG_TUN=m
-CONFIG_INET_DIAG=m
-CONFIG_INET_SCTP_DIAG=m
+CONFIG_XFRM_USER=m
diff --git a/tools/testing/selftests/net/ovpn/config b/tools/testing/selftests/net/ovpn/config
index 71946ba9fa17..42699740936d 100644
--- a/tools/testing/selftests/net/ovpn/config
+++ b/tools/testing/selftests/net/ovpn/config
@@ -1,10 +1,10 @@
-CONFIG_NET=y
-CONFIG_INET=y
-CONFIG_STREAM_PARSER=y
-CONFIG_NET_UDP_TUNNEL=y
-CONFIG_DST_CACHE=y
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_AES=y
-CONFIG_CRYPTO_GCM=y
 CONFIG_CRYPTO_CHACHA20POLY1305=y
+CONFIG_CRYPTO_GCM=y
+CONFIG_DST_CACHE=y
+CONFIG_INET=y
+CONFIG_NET=y
+CONFIG_NET_UDP_TUNNEL=y
 CONFIG_OVPN=m
+CONFIG_STREAM_PARSER=y
diff --git a/tools/testing/selftests/net/packetdrill/config b/tools/testing/selftests/net/packetdrill/config
index 0237ed98f3c0..c4a19a785521 100644
--- a/tools/testing/selftests/net/packetdrill/config
+++ b/tools/testing/selftests/net/packetdrill/config
@@ -1,6 +1,6 @@
-CONFIG_IPV6=y
-CONFIG_HZ_1000=y
 CONFIG_HZ=1000
+CONFIG_HZ_1000=y
+CONFIG_IPV6=y
 CONFIG_NET_NS=y
 CONFIG_NET_SCH_FIFO=y
 CONFIG_NET_SCH_FQ=y
diff --git a/tools/testing/selftests/net/tcp_ao/config b/tools/testing/selftests/net/tcp_ao/config
index 3605e38711cb..971cb6fa2d63 100644
--- a/tools/testing/selftests/net/tcp_ao/config
+++ b/tools/testing/selftests/net/tcp_ao/config
@@ -1,8 +1,8 @@
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_RMD160=y
 CONFIG_CRYPTO_SHA1=y
-CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_NET_L3_MASTER_DEV=y
 CONFIG_NET_VRF=y
 CONFIG_TCP_AO=y
-- 
2.51.0



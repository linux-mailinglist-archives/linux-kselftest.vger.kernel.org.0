Return-Path: <linux-kselftest+bounces-42742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65DBB8295
	for <lists+linux-kselftest@lfdr.de>; Fri, 03 Oct 2025 23:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AD73C8254
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 21:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195DF246760;
	Fri,  3 Oct 2025 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAVA3Snn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926BDF72;
	Fri,  3 Oct 2025 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525293; cv=none; b=RkhBajOTEl6EMrFZIJ2L7BimXy+3I7+bFGPA9ZefmC63a4OKJ4AT9o7R4xRFHUF1oiiZGIi97EjbI+pUh7ut+MU/iLGHM51fzrRhHaWIPit2c3XsMGVFlsfNblbNSr7jJ5yYEvFSrKDKP/G2dnSqP79MUsjM+klC4pvjWADDLWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525293; c=relaxed/simple;
	bh=0X+Lqy1RJgUzDNXn54LfPpKNnDLjSH3aWfQlXuyVIX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmoUoIB7ZiIJrfzheDDu+IsKZ5+X1yewe1xGSPXli1TgSUI4f+6Q4QNyzeu/wYUyAI6eKVPQ0lHnhcqH43d7hmc1WS5gp/yOLRrp957bjv8KxXOZlPP8E/rdnM531DuSRUuRqcpU8E8JRL4uHT8Ru1R55RlGJKdsxPi7C7pr/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAVA3Snn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026EDC4CEF5;
	Fri,  3 Oct 2025 21:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759525292;
	bh=0X+Lqy1RJgUzDNXn54LfPpKNnDLjSH3aWfQlXuyVIX8=;
	h=From:To:Cc:Subject:Date:From;
	b=IAVA3SnnPWqJOdhhkyiyrneH9wbZfTOFiT7fWVIMU0c6N6Oobw1lQMsrEIzh+tk9Z
	 sae2F85ZC5/aJZhRguocvsr5GksRWiyRUDBNjJcnT3o9gKaY5yec65bUX3qor1YFBQ
	 IGahgr3ojOonzBraRLgBHiRJ+lH03utzjetkzM40evY/G7PFBYhrG5O33tSpeyucr7
	 2g/LgHGSmQK8wgKs8yXzkabu06/1zwpEIz8Q4UvTq+M1vEgQ4g2I6OeBVCh22nD4hl
	 fOnJrn0zVW+JWI/HUWnNMzgFXN3+JSuH7mIPXn28eykZw3j6sR+XStVRUDlnMdVtfB
	 xGFN4Y0fQai3g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	shuah@kernel.org,
	jv@jvosburgh.net,
	olteanv@gmail.com,
	jiri@resnulli.us,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	kuniyu@google.com,
	martineau@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	petrm@nvidia.com,
	razor@blackwall.org,
	idosch@nvidia.com,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH net v2] selftests: net: unify the Makefile formats
Date: Fri,  3 Oct 2025 14:01:27 -0700
Message-ID: <20251003210127.1021918-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We get a significant number of conflicts between net and net-next
because of selftests Makefile changes. People tend to append new
test cases at the end of the Makefile when there's no clear sort
order. Sort all networking selftests Makefiles, use the following
format:

 VAR_NAME := \
	 entry1 \
	 entry2 \
	 entry3 \
 # end of VAR_NAME

Some Makefiles are already pretty close to this.

Acked-by: Antonio Quartulli <antonio@openvpn.net>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Acked-by: Allison Henderson <allison.henderson@oracle.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix the mptcp config, not sure what happened there
v1: https://lore.kernel.org/20251002013034.3176961-1-kuba@kernel.org

I think we need to apply this during the merge window, otherwise
the conflicts will be crazy.

CC: shuah@kernel.org
CC: jv@jvosburgh.net
CC: olteanv@gmail.com
CC: jiri@resnulli.us
CC: mst@redhat.com
CC: jasowang@redhat.com
CC: xuanzhuo@linux.alibaba.com
CC: eperezma@redhat.com
CC: kuniyu@google.com
CC: martineau@kernel.org
CC: pablo@netfilter.org
CC: kadlec@netfilter.org
CC: fw@strlen.de
CC: petrm@nvidia.com
CC: razor@blackwall.org
CC: idosch@nvidia.com
CC: linux-kselftest@vger.kernel.org
CC: mptcp@lists.linux.dev
CC: netfilter-devel@vger.kernel.org
CC: coreteam@netfilter.org
---
 tools/testing/selftests/drivers/net/Makefile  |   4 +-
 .../selftests/drivers/net/bonding/Makefile    |  21 +-
 .../selftests/drivers/net/dsa/Makefile        |   9 +-
 .../testing/selftests/drivers/net/hw/Makefile |   8 +-
 .../selftests/drivers/net/netdevsim/Makefile  |   4 +-
 .../selftests/drivers/net/team/Makefile       |  11 +-
 .../selftests/drivers/net/virtio_net/Makefile |  13 +-
 tools/testing/selftests/net/Makefile          | 313 +++++++++++-------
 tools/testing/selftests/net/af_unix/Makefile  |  10 +-
 .../testing/selftests/net/forwarding/Makefile |  58 ++--
 tools/testing/selftests/net/hsr/Makefile      |   6 +-
 tools/testing/selftests/net/lib/Makefile      |  14 +-
 tools/testing/selftests/net/mptcp/Makefile    |  28 +-
 .../testing/selftests/net/netfilter/Makefile  |  89 ++---
 tools/testing/selftests/net/ovpn/Makefile     |  12 +-
 .../selftests/net/packetdrill/Makefile        |  10 +-
 tools/testing/selftests/net/rds/Makefile      |  10 +-
 17 files changed, 380 insertions(+), 240 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index bd3af9a34e2f..6e41635bd55a 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -10,6 +10,7 @@ TEST_GEN_FILES := \
 # end of TEST_GEN_FILES
 
 TEST_PROGS := \
+	hds.py \
 	napi_id.py \
 	napi_threaded.py \
 	netcons_basic.sh \
@@ -21,9 +22,8 @@ TEST_PROGS := \
 	ping.py \
 	psp.py \
 	queues.py \
-	stats.py \
 	shaper.py \
-	hds.py \
+	stats.py \
 	xdp.py \
 # end of TEST_PROGS
 
diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 2f095cf67d9a..402d4ee84f2e 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -4,24 +4,27 @@
 TEST_PROGS := \
 	bond-arp-interval-causes-panic.sh \
 	bond-break-lacpdu-tx.sh \
+	bond-eth-type-change.sh \
 	bond-lladdr-target.sh \
+	bond_ipsec_offload.sh \
+	bond_lacp_prio.sh \
+	bond_macvlan_ipvlan.sh \
+	bond_options.sh \
+	bond_passive_lacp.sh \
 	dev_addr_lists.sh \
 	mode-1-recovery-updelay.sh \
 	mode-2-recovery-updelay.sh \
-	bond_options.sh \
-	bond-eth-type-change.sh \
-	bond_macvlan_ipvlan.sh \
-	bond_passive_lacp.sh \
-	bond_lacp_prio.sh
-	bond_ipsec_offload.sh
+# end of TEST_PROGS
 
 TEST_FILES := \
-	lag_lib.sh \
 	bond_topo_2d1c.sh \
-	bond_topo_3d1c.sh
+	bond_topo_3d1c.sh \
+	lag_lib.sh \
+# end of TEST_FILES
 
 TEST_INCLUDES := \
+	../../../net/lib.sh \
 	../../../net/forwarding/lib.sh \
-	../../../net/lib.sh
+# end of TEST_INCLUDES
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/dsa/Makefile b/tools/testing/selftests/drivers/net/dsa/Makefile
index cd6817fe5be6..699e3565d735 100644
--- a/tools/testing/selftests/drivers/net/dsa/Makefile
+++ b/tools/testing/selftests/drivers/net/dsa/Makefile
@@ -9,11 +9,13 @@ TEST_PROGS = bridge_locked_port.sh \
 	local_termination.sh \
 	no_forwarding.sh \
 	tc_actions.sh \
-	test_bridge_fdb_stress.sh
+	test_bridge_fdb_stress.sh \
+# end of TEST_PROGS
 
 TEST_FILES := \
+	forwarding.config \
 	run_net_forwarding_test.sh \
-	forwarding.config
+# end of TEST_FILES
 
 TEST_INCLUDES := \
 	../../../net/forwarding/bridge_locked_port.sh \
@@ -27,6 +29,7 @@ TEST_INCLUDES := \
 	../../../net/forwarding/no_forwarding.sh \
 	../../../net/forwarding/tc_actions.sh \
 	../../../net/forwarding/tc_common.sh \
-	../../../net/lib.sh
+	../../../net/lib.sh \
+# end of TEST_INCLUDES
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index ee09a40d532c..8133d1a0051c 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -32,8 +32,8 @@ TEST_FILES := \
 TEST_INCLUDES := \
 	$(wildcard lib/py/*.py ../lib/py/*.py) \
 	../../../net/lib.sh \
-	../../../net/forwarding/lib.sh \
 	../../../net/forwarding/ipip_lib.sh \
+	../../../net/forwarding/lib.sh \
 	../../../net/forwarding/tc_common.sh \
 	#
 
@@ -45,7 +45,11 @@ TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
 include ../../../lib.mk
 
 # YNL build
-YNL_GENS := ethtool netdev
+YNL_GENS := \
+	ethtool \
+	netdev \
+# end of YNL_GENS
+
 include ../../../net/ynl.mk
 
 include ../../../net/bpf.mk
diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
index 07b7c46d3311..daf51113c827 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
-TEST_PROGS = devlink.sh \
+TEST_PROGS := \
+	devlink.sh \
 	devlink_in_netns.sh \
 	devlink_trap.sh \
 	ethtool-coalesce.sh \
@@ -17,5 +18,6 @@ TEST_PROGS = devlink.sh \
 	psample.sh \
 	tc-mq-visibility.sh \
 	udp_tunnel_nic.sh \
+# end of TEST_PROGS
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 89d854c7e674..1340b3df9c31 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -1,13 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for net selftests
 
-TEST_PROGS := dev_addr_lists.sh propagation.sh options.sh
+TEST_PROGS := \
+	dev_addr_lists.sh \
+	options.sh \
+	propagation.sh \
+# end of TEST_PROGS
 
 TEST_INCLUDES := \
 	../bonding/lag_lib.sh \
 	../../../net/forwarding/lib.sh \
-	../../../net/lib.sh \
 	../../../net/in_netns.sh \
-	../../../net/lib/sh/defer.sh
+	../../../net/lib.sh \
+	../../../net/lib/sh/defer.sh \
+# end of TEST_INCLUDES
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/virtio_net/Makefile b/tools/testing/selftests/drivers/net/virtio_net/Makefile
index 7ec7cd3ab2cc..868ece3fea1f 100644
--- a/tools/testing/selftests/drivers/net/virtio_net/Makefile
+++ b/tools/testing/selftests/drivers/net/virtio_net/Makefile
@@ -1,15 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
-TEST_PROGS = basic_features.sh \
-        #
+TEST_PROGS = basic_features.sh
 
-TEST_FILES = \
-        virtio_net_common.sh \
-        #
+TEST_FILES = virtio_net_common.sh
 
 TEST_INCLUDES = \
-        ../../../net/forwarding/lib.sh \
-        ../../../net/lib.sh \
-        #
+	../../../net/forwarding/lib.sh \
+	../../../net/lib.sh \
+# end of TEST_INCLUDES
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5d9d96515c4a..b5127e968108 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -1,128 +1,201 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for net selftests
 
-CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g
+CFLAGS += -Wall -Wl,--no-as-needed -O2 -g
 CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
 # Additional include paths needed by kselftest.h
 CFLAGS += -I../
 
-TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
-	      rtnetlink.sh xfrm_policy.sh
-TEST_PROGS += fcnal-ipv4.sh fcnal-ipv6.sh fcnal-other.sh
-TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh udpgso.sh ip_defrag.sh
-TEST_PROGS += udpgso_bench.sh fib_rule_tests.sh msg_zerocopy.sh psock_snd.sh
-TEST_PROGS += udpgro_bench.sh udpgro.sh test_vxlan_under_vrf.sh reuseport_addr_any.sh
-TEST_PROGS += test_vxlan_fdb_changelink.sh so_txtime.sh ipv6_flowlabel.sh
-TEST_PROGS += tcp_fastopen_backup_key.sh l2tp.sh traceroute.sh
-TEST_PROGS += fin_ack_lat.sh fib_nexthop_multiprefix.sh fib_nexthops.sh fib_nexthop_nongw.sh
-TEST_PROGS += altnames.sh icmp.sh icmp_redirect.sh ip6_gre_headroom.sh
-TEST_PROGS += route_localnet.sh
-TEST_PROGS += reuseaddr_ports_exhausted.sh
-TEST_PROGS += txtimestamp.sh
-TEST_PROGS += vrf-xfrm-tests.sh
-TEST_PROGS += rxtimestamp.sh
-TEST_PROGS += drop_monitor_tests.sh
-TEST_PROGS += vrf_route_leaking.sh
-TEST_PROGS += bareudp.sh
-TEST_PROGS += amt.sh
-TEST_PROGS += unicast_extensions.sh
-TEST_PROGS += udpgro_fwd.sh
-TEST_PROGS += udpgro_frglist.sh
-TEST_PROGS += nat6to4.sh
-TEST_PROGS += veth.sh
-TEST_PROGS += ioam6.sh
-TEST_PROGS += gro.sh
-TEST_PROGS += gre_gso.sh
-TEST_PROGS += gre_ipv6_lladdr.sh
-TEST_PROGS += cmsg_so_mark.sh
-TEST_PROGS += cmsg_so_priority.sh
-TEST_PROGS += test_so_rcv.sh
-TEST_PROGS += cmsg_time.sh cmsg_ip.sh
-TEST_PROGS += netns-name.sh
-TEST_PROGS += link_netns.py
-TEST_PROGS += nl_netdev.py
-TEST_PROGS += rtnetlink.py
-TEST_PROGS += rtnetlink_notification.sh
-TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
-TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
-TEST_PROGS += srv6_end_dt6_l3vpn_test.sh
-TEST_PROGS += srv6_hencap_red_l3vpn_test.sh
-TEST_PROGS += srv6_hl2encap_red_l2vpn_test.sh
-TEST_PROGS += srv6_end_next_csid_l3vpn_test.sh
-TEST_PROGS += srv6_end_x_next_csid_l3vpn_test.sh
-TEST_PROGS += srv6_end_flavors_test.sh
-TEST_PROGS += srv6_end_dx4_netfilter_test.sh
-TEST_PROGS += srv6_end_dx6_netfilter_test.sh
-TEST_PROGS += vrf_strict_mode_test.sh
-TEST_PROGS += arp_ndisc_evict_nocarrier.sh
-TEST_PROGS += ndisc_unsolicited_na_test.sh
-TEST_PROGS += arp_ndisc_untracked_subnets.sh
-TEST_PROGS += stress_reuseport_listen.sh
-TEST_PROGS += l2_tos_ttl_inherit.sh
-TEST_PROGS += bind_bhash.sh
-TEST_PROGS += ip_local_port_range.sh
-TEST_PROGS += rps_default_mask.sh
-TEST_PROGS += big_tcp.sh
-TEST_PROGS += netns-sysctl.sh
-TEST_PROGS += netdev-l2addr.sh
-TEST_PROGS_EXTENDED := toeplitz_client.sh toeplitz.sh xfrm_policy_add_speed.sh
-TEST_GEN_FILES =  socket nettest
-TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
-TEST_GEN_FILES += tcp_mmap tcp_inq psock_snd txring_overwrite
-TEST_GEN_FILES += udpgso udpgso_bench_tx udpgso_bench_rx ip_defrag
-TEST_GEN_FILES += so_txtime ipv6_flowlabel ipv6_flowlabel_mgr so_netns_cookie
-TEST_GEN_FILES += tcp_fastopen_backup_key
-TEST_GEN_FILES += fin_ack_lat
-TEST_GEN_FILES += reuseaddr_ports_exhausted
-TEST_GEN_FILES += hwtstamp_config rxtimestamp timestamping txtimestamp
-TEST_GEN_FILES += ipsec
-TEST_GEN_FILES += ioam6_parser
-TEST_GEN_FILES += gro
-TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
-TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls tun tap epoll_busy_poll
-TEST_GEN_FILES += toeplitz
-TEST_GEN_FILES += cmsg_sender
-TEST_GEN_FILES += stress_reuseport_listen
-TEST_GEN_FILES += so_rcv_listener
-TEST_PROGS += test_vxlan_vnifiltering.sh
-TEST_GEN_FILES += io_uring_zerocopy_tx
-TEST_PROGS += io_uring_zerocopy_tx.sh
-TEST_GEN_FILES += bind_bhash
-TEST_GEN_PROGS += sk_bind_sendto_listen
-TEST_GEN_PROGS += sk_connect_zero_addr
-TEST_GEN_PROGS += sk_so_peek_off
-TEST_PROGS += test_ingress_egress_chaining.sh
-TEST_GEN_PROGS += so_incoming_cpu
-TEST_PROGS += sctp_vrf.sh
-TEST_GEN_FILES += sctp_hello
-TEST_GEN_FILES += ip_local_port_range
-TEST_GEN_PROGS += bind_wildcard
-TEST_GEN_PROGS += bind_timewait
-TEST_PROGS += test_vxlan_mdb.sh
-TEST_PROGS += test_bridge_neigh_suppress.sh
-TEST_PROGS += test_vxlan_nh.sh
-TEST_PROGS += test_vxlan_nolocalbypass.sh
-TEST_PROGS += test_bridge_backup_port.sh
-TEST_PROGS += test_neigh.sh
-TEST_PROGS += fdb_flush.sh fdb_notify.sh
-TEST_PROGS += fq_band_pktlimit.sh
-TEST_PROGS += vlan_hw_filter.sh
-TEST_PROGS += vlan_bridge_binding.sh
-TEST_PROGS += bpf_offload.py
-TEST_PROGS += ipv6_route_update_soft_lockup.sh
-TEST_PROGS += busy_poll_test.sh
-TEST_GEN_PROGS += proc_net_pktgen
-TEST_PROGS += lwt_dst_cache_ref_loop.sh
-TEST_PROGS += skf_net_off.sh
-TEST_GEN_FILES += skf_net_off
-TEST_GEN_FILES += tfo
-TEST_PROGS += tfo_passive.sh
-TEST_PROGS += broadcast_ether_dst.sh
-TEST_PROGS += broadcast_pmtu.sh
-TEST_PROGS += ipv6_force_forwarding.sh
-TEST_GEN_PROGS += ipv6_fragmentation
-TEST_PROGS += route_hint.sh
-TEST_GEN_PROGS += tcp_port_share
+TEST_PROGS := \
+	altnames.sh \
+	amt.sh \
+	arp_ndisc_evict_nocarrier.sh \
+	arp_ndisc_untracked_subnets.sh \
+	bareudp.sh \
+	big_tcp.sh \
+	bind_bhash.sh \
+	bpf_offload.py \
+	broadcast_ether_dst.sh \
+	broadcast_pmtu.sh \
+	busy_poll_test.sh \
+	cmsg_ip.sh \
+	cmsg_so_mark.sh \
+	cmsg_so_priority.sh \
+	cmsg_time.sh \
+	drop_monitor_tests.sh \
+	fcnal-ipv4.sh \
+	fcnal-ipv6.sh \
+	fcnal-other.sh \
+	fdb_flush.sh \
+	fdb_notify.sh \
+	fib-onlink-tests.sh \
+	fib_nexthop_multiprefix.sh \
+	fib_nexthop_nongw.sh \
+	fib_nexthops.sh \
+	fib_rule_tests.sh \
+	fib_tests.sh \
+	fin_ack_lat.sh \
+	fq_band_pktlimit.sh \
+	gre_gso.sh \
+	gre_ipv6_lladdr.sh \
+	gro.sh \
+	icmp.sh \
+	icmp_redirect.sh \
+	io_uring_zerocopy_tx.sh \
+	ioam6.sh \
+	ip6_gre_headroom.sh \
+	ip_defrag.sh \
+	ip_local_port_range.sh \
+	ipv6_flowlabel.sh \
+	ipv6_force_forwarding.sh \
+	ipv6_route_update_soft_lockup.sh \
+	l2_tos_ttl_inherit.sh \
+	l2tp.sh \
+	link_netns.py \
+	lwt_dst_cache_ref_loop.sh \
+	msg_zerocopy.sh \
+	nat6to4.sh \
+	ndisc_unsolicited_na_test.sh \
+	netdev-l2addr.sh \
+	netdevice.sh \
+	netns-name.sh \
+	netns-sysctl.sh \
+	nl_netdev.py \
+	pmtu.sh \
+	psock_snd.sh \
+	reuseaddr_ports_exhausted.sh \
+	reuseport_addr_any.sh \
+	route_hint.sh \
+	route_localnet.sh \
+	rps_default_mask.sh \
+	rtnetlink.py \
+	rtnetlink.sh \
+	rtnetlink_notification.sh \
+	run_afpackettests \
+	run_netsocktests \
+	rxtimestamp.sh \
+	sctp_vrf.sh \
+	skf_net_off.sh \
+	so_txtime.sh \
+	srv6_end_dt46_l3vpn_test.sh \
+	srv6_end_dt4_l3vpn_test.sh \
+	srv6_end_dt6_l3vpn_test.sh \
+	srv6_end_dx4_netfilter_test.sh \
+	srv6_end_dx6_netfilter_test.sh \
+	srv6_end_flavors_test.sh \
+	srv6_end_next_csid_l3vpn_test.sh \
+	srv6_end_x_next_csid_l3vpn_test.sh \
+	srv6_hencap_red_l3vpn_test.sh \
+	srv6_hl2encap_red_l2vpn_test.sh \
+	stress_reuseport_listen.sh \
+	tcp_fastopen_backup_key.sh \
+	test_bpf.sh \
+	test_bridge_backup_port.sh \
+	test_bridge_neigh_suppress.sh \
+	test_ingress_egress_chaining.sh \
+	test_neigh.sh \
+	test_so_rcv.sh \
+	test_vxlan_fdb_changelink.sh \
+	test_vxlan_mdb.sh \
+	test_vxlan_nh.sh \
+	test_vxlan_nolocalbypass.sh \
+	test_vxlan_under_vrf.sh \
+	test_vxlan_vnifiltering.sh \
+	tfo_passive.sh \
+	traceroute.sh \
+	txtimestamp.sh \
+	udpgro.sh \
+	udpgro_bench.sh \
+	udpgro_frglist.sh \
+	udpgro_fwd.sh \
+	udpgso.sh \
+	udpgso_bench.sh \
+	unicast_extensions.sh \
+	veth.sh \
+	vlan_bridge_binding.sh \
+	vlan_hw_filter.sh \
+	vrf-xfrm-tests.sh \
+	vrf_route_leaking.sh \
+	vrf_strict_mode_test.sh \
+	xfrm_policy.sh \
+# end of TEST_PROGS
+
+TEST_PROGS_EXTENDED := \
+	toeplitz.sh \
+	toeplitz_client.sh \
+	xfrm_policy_add_speed.sh \
+# end of TEST_PROGS_EXTENDED
+
+TEST_GEN_FILES := \
+	bind_bhash \
+	cmsg_sender \
+	fin_ack_lat \
+	gro \
+	hwtstamp_config \
+	io_uring_zerocopy_tx \
+	ioam6_parser \
+	ip_defrag \
+	ip_local_port_range \
+	ipsec \
+	ipv6_flowlabel \
+	ipv6_flowlabel_mgr \
+	msg_zerocopy \
+	nettest \
+	psock_fanout \
+	psock_snd \
+	psock_tpacket \
+	reuseaddr_ports_exhausted \
+	reuseport_addr_any \
+	rxtimestamp \
+	sctp_hello \
+	skf_net_off \
+	so_netns_cookie \
+	so_rcv_listener \
+	so_txtime \
+	socket \
+	stress_reuseport_listen \
+	tcp_fastopen_backup_key \
+	tcp_inq \
+	tcp_mmap \
+	tfo \
+	timestamping \
+	toeplitz \
+	txring_overwrite \
+	txtimestamp \
+	udpgso \
+	udpgso_bench_rx \
+	udpgso_bench_tx \
+# end of TEST_GEN_FILES
+
+TEST_GEN_PROGS := \
+	bind_timewait \
+	bind_wildcard \
+	epoll_busy_poll \
+	ipv6_fragmentation \
+	proc_net_pktgen \
+	reuseaddr_conflict \
+	reuseport_bpf \
+	reuseport_bpf_cpu \
+	reuseport_bpf_numa \
+	reuseport_dualstack \
+	sk_bind_sendto_listen \
+	sk_connect_zero_addr \
+	sk_so_peek_off \
+	so_incoming_cpu \
+	tap \
+	tcp_port_share \
+	tls \
+	tun \
+# end of TEST_GEN_PROGS
+
+TEST_FILES := \
+	fcnal-test.sh \
+	in_netns.sh \
+	lib.sh \
+	settings \
+	setup_loopback.sh \
+	setup_veth.sh \
+# end of TEST_FILES
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller
@@ -130,10 +203,6 @@ YNL_GEN_PROGS := netlink-dumps
 TEST_GEN_FILES += $(YNL_GEN_FILES)
 TEST_GEN_PROGS += $(YNL_GEN_PROGS)
 
-TEST_FILES := settings
-TEST_FILES += fcnal-test.sh
-TEST_FILES += in_netns.sh lib.sh setup_loopback.sh setup_veth.sh
-
 TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
 
 TEST_INCLUDES := forwarding/lib.sh
diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 0a20c98bbcfd..de805cbbdf69 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,4 +1,12 @@
 CFLAGS += $(KHDR_INCLUDES) -Wall -Wflex-array-member-not-at-end
-TEST_GEN_PROGS := diag_uid msg_oob scm_inq scm_pidfd scm_rights unix_connect
+
+TEST_GEN_PROGS := \
+	diag_uid \
+	msg_oob \
+	scm_inq \
+	scm_pidfd \
+	scm_rights \
+	unix_connect \
+# end of TEST_GEN_PROGS
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index e6f482a600da..ff4a00d91a26 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
-TEST_PROGS = \
+TEST_PROGS := \
 	bridge_activity_notify.sh \
 	bridge_fdb_learning_limit.sh \
+	bridge_fdb_local_vlan_0.sh \
 	bridge_igmp.sh \
 	bridge_locked_port.sh \
-	bridge_fdb_local_vlan_0.sh \
 	bridge_mdb.sh \
 	bridge_mdb_host.sh \
 	bridge_mdb_max.sh \
@@ -21,64 +21,64 @@ TEST_PROGS = \
 	gre_custom_multipath_hash.sh \
 	gre_inner_v4_multipath.sh \
 	gre_inner_v6_multipath.sh \
-	gre_multipath_nh_res.sh \
-	gre_multipath_nh.sh \
 	gre_multipath.sh \
+	gre_multipath_nh.sh \
+	gre_multipath_nh_res.sh \
 	ip6_forward_instats_vrf.sh \
 	ip6gre_custom_multipath_hash.sh \
+	ip6gre_flat.sh \
 	ip6gre_flat_key.sh \
 	ip6gre_flat_keys.sh \
-	ip6gre_flat.sh \
+	ip6gre_hier.sh \
 	ip6gre_hier_key.sh \
 	ip6gre_hier_keys.sh \
-	ip6gre_hier.sh \
 	ip6gre_inner_v4_multipath.sh \
 	ip6gre_inner_v6_multipath.sh \
+	ipip_flat_gre.sh \
 	ipip_flat_gre_key.sh \
 	ipip_flat_gre_keys.sh \
-	ipip_flat_gre.sh \
+	ipip_hier_gre.sh \
 	ipip_hier_gre_key.sh \
 	ipip_hier_gre_keys.sh \
-	ipip_hier_gre.sh \
 	lib_sh_test.sh \
 	local_termination.sh \
 	min_max_mtu.sh \
+	mirror_gre.sh \
 	mirror_gre_bound.sh \
 	mirror_gre_bridge_1d.sh \
 	mirror_gre_bridge_1d_vlan.sh \
-	mirror_gre_bridge_1q_lag.sh \
 	mirror_gre_bridge_1q.sh \
+	mirror_gre_bridge_1q_lag.sh \
 	mirror_gre_changes.sh \
 	mirror_gre_flower.sh \
 	mirror_gre_lag_lacp.sh \
 	mirror_gre_neigh.sh \
 	mirror_gre_nh.sh \
-	mirror_gre.sh \
-	mirror_gre_vlan_bridge_1q.sh \
 	mirror_gre_vlan.sh \
+	mirror_gre_vlan_bridge_1q.sh \
 	mirror_vlan.sh \
 	no_forwarding.sh \
 	pedit_dsfield.sh \
 	pedit_ip.sh \
 	pedit_l4port.sh \
-	q_in_vni_ipv6.sh \
 	q_in_vni.sh \
+	q_in_vni_ipv6.sh \
+	router.sh \
 	router_bridge.sh \
 	router_bridge_1d.sh \
 	router_bridge_1d_lag.sh \
 	router_bridge_lag.sh \
+	router_bridge_pvid_vlan_upper.sh \
 	router_bridge_vlan.sh \
 	router_bridge_vlan_upper.sh \
-	router_bridge_pvid_vlan_upper.sh \
 	router_bridge_vlan_upper_pvid.sh \
 	router_broadcast.sh \
-	router_mpath_nh_res.sh \
 	router_mpath_nh.sh \
+	router_mpath_nh_res.sh \
 	router_mpath_seed.sh \
 	router_multicast.sh \
 	router_multipath.sh \
 	router_nh.sh \
-	router.sh \
 	router_vid_1.sh \
 	sch_ets.sh \
 	sch_red.sh \
@@ -88,32 +88,34 @@ TEST_PROGS = \
 	skbedit_priority.sh \
 	tc_actions.sh \
 	tc_chains.sh \
-	tc_flower_router.sh \
 	tc_flower.sh \
-	tc_flower_l2_miss.sh \
 	tc_flower_cfm.sh \
+	tc_flower_l2_miss.sh \
 	tc_flower_port_range.sh \
+	tc_flower_router.sh \
 	tc_mpls_l2vpn.sh \
 	tc_police.sh \
 	tc_shblocks.sh \
 	tc_tunnel_key.sh \
 	tc_vlan_modify.sh \
-	vxlan_asymmetric_ipv6.sh \
 	vxlan_asymmetric.sh \
-	vxlan_bridge_1d_ipv6.sh \
-	vxlan_bridge_1d_port_8472_ipv6.sh \
-	vxlan_bridge_1d_port_8472.sh \
+	vxlan_asymmetric_ipv6.sh \
 	vxlan_bridge_1d.sh \
+	vxlan_bridge_1d_ipv6.sh \
+	vxlan_bridge_1d_port_8472.sh \
+	vxlan_bridge_1d_port_8472_ipv6.sh \
+	vxlan_bridge_1q.sh \
 	vxlan_bridge_1q_ipv6.sh \
 	vxlan_bridge_1q_mc_ul.sh \
-	vxlan_bridge_1q_port_8472_ipv6.sh \
 	vxlan_bridge_1q_port_8472.sh \
-	vxlan_bridge_1q.sh \
+	vxlan_bridge_1q_port_8472_ipv6.sh \
 	vxlan_reserved.sh \
+	vxlan_symmetric.sh \
 	vxlan_symmetric_ipv6.sh \
-	vxlan_symmetric.sh
+# end of TEST_PROGS
 
-TEST_FILES := devlink_lib.sh \
+TEST_FILES := \
+	devlink_lib.sh \
 	fib_offload_lib.sh \
 	forwarding.config.sample \
 	ip6gre_lib.sh \
@@ -128,10 +130,12 @@ TEST_FILES := devlink_lib.sh \
 	sch_ets_tests.sh \
 	sch_tbf_core.sh \
 	sch_tbf_etsprio.sh \
-	tc_common.sh
+	tc_common.sh \
+# end of TEST_FILES
 
 TEST_INCLUDES := \
+	$(wildcard ../lib/sh/*.sh) \
 	../lib.sh \
-	$(wildcard ../lib/sh/*.sh)
+# end of TEST_INCLUDES
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selftests/net/hsr/Makefile
index 884cd2cc0681..4b6afc0fe9f8 100644
--- a/tools/testing/selftests/net/hsr/Makefile
+++ b/tools/testing/selftests/net/hsr/Makefile
@@ -2,7 +2,11 @@
 
 top_srcdir = ../../../../..
 
-TEST_PROGS := hsr_ping.sh hsr_redbox.sh
+TEST_PROGS := \
+	hsr_ping.sh \
+	hsr_redbox.sh \
+# end of TEST_PROGS
+
 TEST_FILES += hsr_common.sh
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index 88c4bc461459..ce795bc0a1af 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -5,12 +5,16 @@ CFLAGS += -I../../../../../usr/include/ $(KHDR_INCLUDES)
 # Additional include paths needed by kselftest.h
 CFLAGS += -I../../
 
-TEST_FILES := ../../../../../Documentation/netlink/specs
-TEST_FILES += ../../../../net/ynl
+TEST_FILES := \
+	../../../../net/ynl \
+	../../../../../Documentation/netlink/specs \
+# end of TEST_FILES
 
-TEST_GEN_FILES += csum
-TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
-TEST_GEN_FILES += xdp_helper
+TEST_GEN_FILES := \
+	$(patsubst %.c,%.o,$(wildcard *.bpf.c)) \
+	csum \
+	xdp_helper \
+# end of TEST_GEN_FILES
 
 TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
 
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 4c7e51336ab2..15d144a25d82 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -4,13 +4,31 @@ top_srcdir = ../../../../..
 
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
-TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
-	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
-	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
+TEST_PROGS := \
+	diag.sh \
+	mptcp_connect.sh \
+	mptcp_connect_checksum.sh \
+	mptcp_connect_mmap.sh \
+	mptcp_connect_sendfile.sh \
+	mptcp_join.sh \
+	mptcp_sockopt.sh \
+	pm_netlink.sh \
+	simult_flows.sh \
+	userspace_pm.sh \
+# end of TEST_PROGS
 
-TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
+TEST_GEN_FILES := \
+	mptcp_connect \
+	mptcp_diag \
+	mptcp_inq \
+	mptcp_sockopt \
+	pm_nl_ctl \
+# end of TEST_GEN_FILES
 
-TEST_FILES := mptcp_lib.sh settings
+TEST_FILES := \
+	mptcp_lib.sh \
+	settings \
+# end of TEST_FILES
 
 TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
 
diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
index a98ed892f55f..ee2d1a5254f8 100644
--- a/tools/testing/selftests/net/netfilter/Makefile
+++ b/tools/testing/selftests/net/netfilter/Makefile
@@ -6,46 +6,52 @@ HOSTPKG_CONFIG := pkg-config
 MNL_CFLAGS := $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
 MNL_LDLIBS := $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
 
-TEST_PROGS := br_netfilter.sh bridge_brouter.sh
-TEST_PROGS += br_netfilter_queue.sh
-TEST_PROGS += conntrack_dump_flush.sh
-TEST_PROGS += conntrack_icmp_related.sh
-TEST_PROGS += conntrack_ipip_mtu.sh
-TEST_PROGS += conntrack_tcp_unreplied.sh
-TEST_PROGS += conntrack_resize.sh
-TEST_PROGS += conntrack_sctp_collision.sh
-TEST_PROGS += conntrack_vrf.sh
-TEST_PROGS += conntrack_clash.sh
-TEST_PROGS += conntrack_reverse_clash.sh
-TEST_PROGS += ipvs.sh
-TEST_PROGS += nf_conntrack_packetdrill.sh
-TEST_PROGS += nf_nat_edemux.sh
-TEST_PROGS += nft_audit.sh
-TEST_PROGS += nft_concat_range.sh
-TEST_PROGS += nft_conntrack_helper.sh
-TEST_PROGS += nft_fib.sh
-TEST_PROGS += nft_flowtable.sh
-TEST_PROGS += nft_interface_stress.sh
-TEST_PROGS += nft_meta.sh
-TEST_PROGS += nft_nat.sh
-TEST_PROGS += nft_nat_zones.sh
-TEST_PROGS += nft_queue.sh
-TEST_PROGS += nft_synproxy.sh
-TEST_PROGS += nft_tproxy_tcp.sh
-TEST_PROGS += nft_tproxy_udp.sh
-TEST_PROGS += nft_zones_many.sh
-TEST_PROGS += rpath.sh
-TEST_PROGS += vxlan_mtu_frag.sh
-TEST_PROGS += xt_string.sh
+TEST_PROGS := \
+	br_netfilter.sh \
+	br_netfilter_queue.sh \
+	bridge_brouter.sh \
+	conntrack_clash.sh \
+	conntrack_dump_flush.sh \
+	conntrack_icmp_related.sh \
+	conntrack_ipip_mtu.sh \
+	conntrack_resize.sh \
+	conntrack_reverse_clash.sh \
+	conntrack_sctp_collision.sh \
+	conntrack_tcp_unreplied.sh \
+	conntrack_vrf.sh \
+	ipvs.sh \
+	nf_conntrack_packetdrill.sh \
+	nf_nat_edemux.sh \
+	nft_audit.sh \
+	nft_concat_range.sh \
+	nft_conntrack_helper.sh \
+	nft_fib.sh \
+	nft_flowtable.sh \
+	nft_interface_stress.sh \
+	nft_meta.sh \
+	nft_nat.sh \
+	nft_nat_zones.sh \
+	nft_queue.sh \
+	nft_synproxy.sh \
+	nft_tproxy_tcp.sh \
+	nft_tproxy_udp.sh \
+	nft_zones_many.sh \
+	rpath.sh \
+	vxlan_mtu_frag.sh \
+	xt_string.sh \
+# end of TEST_PROGS
 
 TEST_PROGS_EXTENDED = nft_concat_range_perf.sh
 
-TEST_GEN_FILES = audit_logread
-TEST_GEN_FILES += connect_close nf_queue
-TEST_GEN_FILES += conntrack_dump_flush
-TEST_GEN_FILES += conntrack_reverse_clash
-TEST_GEN_FILES += sctp_collision
-TEST_GEN_FILES += udpclash
+TEST_GEN_FILES = \
+	audit_logread \
+	connect_close \
+	conntrack_dump_flush \
+	conntrack_reverse_clash \
+	nf_queue \
+	sctp_collision \
+	udpclash \
+# end of TEST_GEN_FILES
 
 include ../../lib.mk
 
@@ -56,9 +62,12 @@ $(OUTPUT)/conntrack_dump_flush: CFLAGS += $(MNL_CFLAGS)
 $(OUTPUT)/conntrack_dump_flush: LDLIBS += $(MNL_LDLIBS)
 $(OUTPUT)/udpclash: LDLIBS += -lpthread
 
-TEST_FILES := lib.sh
-TEST_FILES += packetdrill
+TEST_FILES := \
+	lib.sh \
+	packetdrill \
+# end of TEST_FILES
 
 TEST_INCLUDES := \
+	$(wildcard ../lib/sh/*.sh) \
 	../lib.sh \
-	$(wildcard ../lib/sh/*.sh)
+# end of TEST_INCLUDES
diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index e0926d76b4c8..dbe0388c8512 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -19,13 +19,15 @@ LDLIBS += $(VAR_LDLIBS)
 
 TEST_FILES = common.sh
 
-TEST_PROGS = test.sh \
-	test-large-mtu.sh \
+TEST_PROGS := \
 	test-chachapoly.sh \
-	test-tcp.sh \
-	test-float.sh \
+	test-close-socket-tcp.sh \
 	test-close-socket.sh \
-	test-close-socket-tcp.sh
+	test-float.sh \
+	test-large-mtu.sh \
+	test-tcp.sh \
+	test.sh \
+# end of TEST_PROGS
 
 TEST_GEN_FILES := ovpn-cli
 
diff --git a/tools/testing/selftests/net/packetdrill/Makefile b/tools/testing/selftests/net/packetdrill/Makefile
index 31cfb666ba8b..ff54641493e9 100644
--- a/tools/testing/selftests/net/packetdrill/Makefile
+++ b/tools/testing/selftests/net/packetdrill/Makefile
@@ -1,9 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_INCLUDES := ksft_runner.sh \
-		 defaults.sh \
-		 set_sysctls.py \
-		 ../../kselftest/ktap_helpers.sh
+TEST_INCLUDES := \
+	defaults.sh \
+	ksft_runner.sh \
+	set_sysctls.py \
+	../../kselftest/ktap_helpers.sh \
+# end of TEST_INCLUDES
 
 TEST_PROGS := $(wildcard *.pkt)
 
diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index 612a7219990e..762845cc973c 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -5,8 +5,14 @@
 
 TEST_PROGS := run.sh
 
-TEST_FILES := include.sh test.py
+TEST_FILES := \
+	include.sh \
+	test.py \
+# end of TEST_FILES
 
-EXTRA_CLEAN := /tmp/rds_logs include.sh
+EXTRA_CLEAN := \
+	include.sh \
+	/tmp/rds_logs \
+# end of EXTRA_CLEAN
 
 include ../../lib.mk
-- 
2.51.0



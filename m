Return-Path: <linux-kselftest+bounces-37802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14412B0D451
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAF117E22B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DB02C326E;
	Tue, 22 Jul 2025 08:19:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4DC28934D;
	Tue, 22 Jul 2025 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172341; cv=none; b=o7Yi5b0BU7gOL9bqruA1VXxg+FO31b+2QMvvGHSSyEjw5O4AbGXICInDSX5S6GdxodMIhF2hoVV2dyAWM6Is3JTfW079Cewiw7FjebQ3s6BwgygHCgI63hSeSwx+6GWNlqg3pVMniN7Wnti5KY/XWwXNHm2DsKfJ1a1I2trmbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172341; c=relaxed/simple;
	bh=McLe6nmhkQY+1qYnu+7RbB4gvfy2THISszzD7sqpJPY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DjJP/0hWvjtkRub52kM7xomjJspvXF/4NBnCGJuWGQklasNDNP547togx+DwP5tMFWhLsZXlMbQFrTMF3LHuDTNVtfRL9kwBlBOVc0suG5UFJDn+KzW2PLxdJMD5jdhMZT4VpGoAPCgckFwko+hNQZh+lPyQVwfeT7MVXffIwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A378F42DAB;
	Tue, 22 Jul 2025 10:18:55 +0200 (CEST)
From: Gabriel Goller <g.goller@proxmox.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v7] ipv6: add `force_forwarding` sysctl to enable per-interface forwarding
Date: Tue, 22 Jul 2025 10:18:45 +0200
Message-Id: <20250722081847.132632-1-g.goller@proxmox.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1753172325136

It is currently impossible to enable ipv6 forwarding on a per-interface
basis like in ipv4. To enable forwarding on an ipv6 interface we need to
enable it on all interfaces and disable it on the other interfaces using
a netfilter rule. This is especially cumbersome if you have lots of
interfaces and only want to enable forwarding on a few. According to the
sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
for all interfaces, while the interface-specific
`net.ipv6.conf.<interface>.forwarding` configures the interface
Host/Router configuration.

Introduce a new sysctl flag `force_forwarding`, which can be set on every
interface. The ip6_forwarding function will then check if the global
forwarding flag OR the force_forwarding flag is active and forward the
packet.

To preserve backwards-compatibility reset the flag (on all interfaces)
to 0 if the net.ipv6.conf.all.forwarding flag is set to 0.

Add a short selftest that checks if a packet gets forwarded with and
without `force_forwarding`.

[0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---

v7: 
    * rebase
    * fix typos in commit message
v6: https://lore.kernel.org/netdev/20250711124243.526735-1-g.goller@proxmox.com/
    * rebase
    * remove brackets around single line
    * add 'nodad' to addresses in selftest to avoid sporadic failures
v5: https://lore.kernel.org/netdev/20250707094307.223975-1-g.goller@proxmox.com/
    * update conf/all/forwarding docs
    * simplified backwards-compat comment
    * remove ASSERT_RTNL as it's guaranteed by __in6_dev_get_rtnl_net()
      already
    * cange ip6_forward logic so that it doesn't depend on the idev
      existing
    * move WRITE_ONCE inside device lock
v4: https://lore.kernel.org/netdev/20250703160154.560239-1-g.goller@proxmox.com/
    * actually write the sysctl value to the table
    * use ASSERT_RTNL() when forwarding the sysctl change
    * remove useless comments in function body
    * simplify forwarding and force_forwarding check in ip6_output.c
    * fix code backticks in Documentation (double instead of single)
    * add selftests
v3: https://lore.kernel.org/netdev/20250702074619.139031-1-g.goller@proxmox.com/
    * remove forwarding=0 setting force_forwarding=0 globally.
    * add min and max (0 and 1) value to sysctl.
v2: https://lore.kernel.org/netdev/20250701140423.487411-1-g.goller@proxmox.com/
    * rename from `do_forwarding` to `force_forwarding`.
    * add global `force_forwarding` flag which will enable
      `force_forwarding` on every interface like the
      `ipv4.all.forwarding` flag.
    * `forwarding`=0 will disable global and per-interface
      `force_forwarding`.
    * export option as NETCONFA_FORCE_FORWARDING.
v1: https://lore.kernel.org/netdev/20250702074619.139031-1-g.goller@proxmox.com/

 Documentation/networking/ip-sysctl.rst        |   8 +-
 include/linux/ipv6.h                          |   1 +
 include/uapi/linux/ipv6.h                     |   1 +
 include/uapi/linux/netconf.h                  |   1 +
 include/uapi/linux/sysctl.h                   |   1 +
 net/ipv6/addrconf.c                           |  82 ++++++++++++++
 net/ipv6/ip6_output.c                         |   3 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/ipv6_force_forwarding.sh    | 105 ++++++++++++++++++
 9 files changed, 200 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/ipv6_force_forwarding.sh

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 14700ea77e75..bb620f554598 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2543,8 +2543,8 @@ conf/all/disable_ipv6 - BOOLEAN
 conf/all/forwarding - BOOLEAN
 	Enable global IPv6 forwarding between all interfaces.
 
-	IPv4 and IPv6 work differently here; e.g. netfilter must be used
-	to control which interfaces may forward packets and which not.
+	IPv4 and IPv6 work differently here; the ``force_forwarding`` flag must
+	be used to control which interfaces may forward packets.
 
 	This also sets all interfaces' Host/Router setting
 	'forwarding' to the specified value.  See below for details.
@@ -2561,6 +2561,10 @@ proxy_ndp - BOOLEAN
 
 	Default: 0 (disabled)
 
+force_forwarding - BOOLEAN
+	Enable forwarding on this interface only -- regardless of the setting on
+	``conf/all/forwarding``. When setting ``conf.all.forwarding`` to 0,
+	the ``force_forwarding`` flag will be reset on all interfaces.
 
 fwmark_reflect - BOOLEAN
 	Controls the fwmark of kernel-generated IPv6 reply packets that are not
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index db0eb0d86b64..bc6ec2959173 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -17,6 +17,7 @@ struct ipv6_devconf {
 	__s32		hop_limit;
 	__s32		mtu6;
 	__s32		forwarding;
+	__s32		force_forwarding;
 	__s32		disable_policy;
 	__s32		proxy_ndp;
 	__cacheline_group_end(ipv6_devconf_read_txrx);
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index cf592d7b630f..d4d3ae774b26 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -199,6 +199,7 @@ enum {
 	DEVCONF_NDISC_EVICT_NOCARRIER,
 	DEVCONF_ACCEPT_UNTRACKED_NA,
 	DEVCONF_ACCEPT_RA_MIN_LFT,
+	DEVCONF_FORCE_FORWARDING,
 	DEVCONF_MAX
 };
 
diff --git a/include/uapi/linux/netconf.h b/include/uapi/linux/netconf.h
index fac4edd55379..1c8c84d65ae3 100644
--- a/include/uapi/linux/netconf.h
+++ b/include/uapi/linux/netconf.h
@@ -19,6 +19,7 @@ enum {
 	NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
 	NETCONFA_INPUT,
 	NETCONFA_BC_FORWARDING,
+	NETCONFA_FORCE_FORWARDING,
 	__NETCONFA_MAX
 };
 #define NETCONFA_MAX	(__NETCONFA_MAX - 1)
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 8981f00204db..63d1464cb71c 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -573,6 +573,7 @@ enum {
 	NET_IPV6_ACCEPT_RA_FROM_LOCAL=26,
 	NET_IPV6_ACCEPT_RA_RT_INFO_MIN_PLEN=27,
 	NET_IPV6_RA_DEFRTR_METRIC=28,
+	NET_IPV6_FORCE_FORWARDING=29,
 	__NET_IPV6_MAX
 };
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 4f1d7d110302..81a067a2e526 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -239,6 +239,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly = {
 	.ndisc_evict_nocarrier	= 1,
 	.ra_honor_pio_life	= 0,
 	.ra_honor_pio_pflag	= 0,
+	.force_forwarding	= 0,
 };
 
 static struct ipv6_devconf ipv6_devconf_dflt __read_mostly = {
@@ -303,6 +304,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mostly = {
 	.ndisc_evict_nocarrier	= 1,
 	.ra_honor_pio_life	= 0,
 	.ra_honor_pio_pflag	= 0,
+	.force_forwarding	= 0,
 };
 
 /* Check if link is ready: is it up and is a valid qdisc available */
@@ -857,6 +859,9 @@ static void addrconf_forward_change(struct net *net, __s32 newf)
 		idev = __in6_dev_get_rtnl_net(dev);
 		if (idev) {
 			int changed = (!idev->cnf.forwarding) ^ (!newf);
+			/* Disabling all.forwarding sets 0 to force_forwarding for all interfaces */
+			if (newf == 0)
+				WRITE_ONCE(idev->cnf.force_forwarding, 0);
 
 			WRITE_ONCE(idev->cnf.forwarding, newf);
 			if (changed)
@@ -5710,6 +5715,7 @@ static void ipv6_store_devconf(const struct ipv6_devconf *cnf,
 	array[DEVCONF_ACCEPT_UNTRACKED_NA] =
 		READ_ONCE(cnf->accept_untracked_na);
 	array[DEVCONF_ACCEPT_RA_MIN_LFT] = READ_ONCE(cnf->accept_ra_min_lft);
+	array[DEVCONF_FORCE_FORWARDING] = READ_ONCE(cnf->force_forwarding);
 }
 
 static inline size_t inet6_ifla6_size(void)
@@ -6738,6 +6744,75 @@ static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write
 	return ret;
 }
 
+static void addrconf_force_forward_change(struct net *net, __s32 newf)
+{
+	struct net_device *dev;
+	struct inet6_dev *idev;
+
+	for_each_netdev(net, dev) {
+		idev = __in6_dev_get_rtnl_net(dev);
+		if (idev) {
+			int changed = (!idev->cnf.force_forwarding) ^ (!newf);
+
+			WRITE_ONCE(idev->cnf.force_forwarding, newf);
+			if (changed)
+				inet6_netconf_notify_devconf(dev_net(dev), RTM_NEWNETCONF,
+							     NETCONFA_FORCE_FORWARDING,
+							     dev->ifindex, &idev->cnf);
+		}
+	}
+}
+
+static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int write,
+					    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct inet6_dev *idev = ctl->extra1;
+	struct ctl_table tmp_ctl = *ctl;
+	struct net *net = ctl->extra2;
+	int *valp = ctl->data;
+	int new_val = *valp;
+	int old_val = *valp;
+	loff_t pos = *ppos;
+	int ret;
+
+	tmp_ctl.extra1 = SYSCTL_ZERO;
+	tmp_ctl.extra2 = SYSCTL_ONE;
+	tmp_ctl.data = &new_val;
+
+	ret = proc_douintvec_minmax(&tmp_ctl, write, buffer, lenp, ppos);
+
+	if (write && old_val != new_val) {
+		if (!rtnl_net_trylock(net))
+			return restart_syscall();
+
+		WRITE_ONCE(*valp, new_val);
+
+		if (valp == &net->ipv6.devconf_dflt->force_forwarding) {
+			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
+						     NETCONFA_FORCE_FORWARDING,
+						     NETCONFA_IFINDEX_DEFAULT,
+						     net->ipv6.devconf_dflt);
+		} else if (valp == &net->ipv6.devconf_all->force_forwarding) {
+			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
+						     NETCONFA_FORCE_FORWARDING,
+						     NETCONFA_IFINDEX_ALL,
+						     net->ipv6.devconf_all);
+
+			addrconf_force_forward_change(net, new_val);
+		} else {
+			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
+						     NETCONFA_FORCE_FORWARDING,
+						     idev->dev->ifindex,
+						     &idev->cnf);
+		}
+		rtnl_net_unlock(net);
+	}
+
+	if (ret)
+		*ppos = pos;
+	return ret;
+}
+
 static int minus_one = -1;
 static const int two_five_five = 255;
 static u32 ioam6_if_id_max = U16_MAX;
@@ -7208,6 +7283,13 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "force_forwarding",
+		.data		= &ipv6_devconf.force_forwarding,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= addrconf_sysctl_force_forwarding,
+	},
 };
 
 static int __addrconf_sysctl_register(struct net *net, char *dev_name,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 0412f8544695..1e1410237b6e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -511,7 +511,8 @@ int ip6_forward(struct sk_buff *skb)
 	u32 mtu;
 
 	idev = __in6_dev_get_safely(dev_get_by_index_rcu(net, IP6CB(skb)->iif));
-	if (READ_ONCE(net->ipv6.devconf_all->forwarding) == 0)
+	if (!READ_ONCE(net->ipv6.devconf_all->forwarding) &&
+	    (!idev || !READ_ONCE(idev->cnf.force_forwarding)))
 		goto error;
 
 	if (skb->pkt_type != PACKET_HOST)
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 13e2678d418b..b31a71f2b372 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -116,6 +116,7 @@ TEST_GEN_FILES += skf_net_off
 TEST_GEN_FILES += tfo
 TEST_PROGS += tfo_passive.sh
 TEST_PROGS += broadcast_pmtu.sh
+TEST_PROGS += ipv6_force_forwarding.sh
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/ipv6_force_forwarding.sh b/tools/testing/selftests/net/ipv6_force_forwarding.sh
new file mode 100755
index 000000000000..bf0243366caa
--- /dev/null
+++ b/tools/testing/selftests/net/ipv6_force_forwarding.sh
@@ -0,0 +1,105 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test IPv6 force_forwarding interface property
+#
+# This test verifies that the force_forwarding property works correctly:
+# - When global forwarding is disabled, packets are not forwarded normally
+# - When force_forwarding is enabled on an interface, packets are forwarded
+#   regardless of the global forwarding setting
+
+source lib.sh
+
+cleanup() {
+    cleanup_ns $ns1 $ns2 $ns3
+}
+
+trap cleanup EXIT
+
+setup_test() {
+    # Create three namespaces: sender, router, receiver
+    setup_ns ns1 ns2 ns3
+
+    # Create veth pairs: ns1 <-> ns2 <-> ns3
+    ip link add name veth12 type veth peer name veth21
+    ip link add name veth23 type veth peer name veth32
+
+    # Move interfaces to namespaces
+    ip link set veth12 netns $ns1
+    ip link set veth21 netns $ns2
+    ip link set veth23 netns $ns2
+    ip link set veth32 netns $ns3
+
+    # Configure interfaces
+    ip -n $ns1 addr add 2001:db8:1::1/64 dev veth12 nodad
+    ip -n $ns2 addr add 2001:db8:1::2/64 dev veth21 nodad
+    ip -n $ns2 addr add 2001:db8:2::1/64 dev veth23 nodad
+    ip -n $ns3 addr add 2001:db8:2::2/64 dev veth32 nodad
+
+    # Bring up interfaces
+    ip -n $ns1 link set veth12 up
+    ip -n $ns2 link set veth21 up
+    ip -n $ns2 link set veth23 up
+    ip -n $ns3 link set veth32 up
+
+    # Add routes
+    ip -n $ns1 route add 2001:db8:2::/64 via 2001:db8:1::2
+    ip -n $ns3 route add 2001:db8:1::/64 via 2001:db8:2::1
+
+    # Disable global forwarding
+    ip netns exec $ns2 sysctl -qw net.ipv6.conf.all.forwarding=0
+}
+
+test_force_forwarding() {
+    local ret=0
+
+    echo "TEST: force_forwarding functionality"
+
+    # Check if force_forwarding sysctl exists
+    if ! ip netns exec $ns2 test -f /proc/sys/net/ipv6/conf/veth21/force_forwarding; then
+        echo "SKIP: force_forwarding not available"
+        return $ksft_skip
+    fi
+
+    # Test 1: Without force_forwarding, ping should fail
+    ip netns exec $ns2 sysctl -qw net.ipv6.conf.veth21.force_forwarding=0
+    ip netns exec $ns2 sysctl -qw net.ipv6.conf.veth23.force_forwarding=0
+
+    if ip netns exec $ns1 ping -6 -c 1 -W 2 2001:db8:2::2 &>/dev/null; then
+        echo "FAIL: ping succeeded when forwarding disabled"
+        ret=1
+    else
+        echo "PASS: forwarding disabled correctly"
+    fi
+
+    # Test 2: With force_forwarding enabled, ping should succeed
+    ip netns exec $ns2 sysctl -qw net.ipv6.conf.veth21.force_forwarding=1
+    ip netns exec $ns2 sysctl -qw net.ipv6.conf.veth23.force_forwarding=1
+
+    if ip netns exec $ns1 ping -6 -c 1 -W 2 2001:db8:2::2 &>/dev/null; then
+        echo "PASS: force_forwarding enabled forwarding"
+    else
+        echo "FAIL: ping failed with force_forwarding enabled"
+        ret=1
+    fi
+
+    return $ret
+}
+
+echo "IPv6 force_forwarding test"
+echo "=========================="
+
+setup_test
+test_force_forwarding
+ret=$?
+
+if [ $ret -eq 0 ]; then
+    echo "OK"
+    exit 0
+elif [ $ret -eq $ksft_skip ]; then
+    echo "SKIP"
+    exit $ksft_skip
+else
+    echo "FAIL"
+    exit 1
+fi
-- 
2.39.5




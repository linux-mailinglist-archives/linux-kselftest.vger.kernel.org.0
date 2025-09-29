Return-Path: <linux-kselftest+bounces-42582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800ACBA9B24
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 16:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AF03A8849
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 14:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED30030AAC2;
	Mon, 29 Sep 2025 14:50:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD6308F3C
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157426; cv=none; b=TNeLHBqftEX/0GsP7b1pj2fZ4QAT3zfLhKl0L05OQZOqi1DDOkq7CO+N6Z6LCE9LyqFyGn0HLMeptm+BG242bdEOcu6+K2wCuGfO+40Za42JojZwPVZuGng77dCZxQE/nFHHCGtJLIqnG3K9aYJNYjrfv28ggZr2pDskEe/6O98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157426; c=relaxed/simple;
	bh=XCB2XmLC4/2BQdcAWWt4J2WxHHmdFsXmnl6/dE5j3g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6o7poPnupw257RCdJZJpxmS4uBy5I8j6P5oGDRhfm6NiqMVNuyhjl6jh7k9Hk2B2rM3ljWlHLExykE9UlQn1g6lsJFBIiTTvawcUz/qUqb3yZzpVkNDuVgT8SGSbFeZJFX1izr5Ga9ywCVP/mOYx4r9Ry2gA62lMsoNyW5oJxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b2e173b8364so723567666b.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 07:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759157422; x=1759762222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niFM3TVx2gIUuBBt7NvLVVPG8oQUe9iQUhgGSeDfRlQ=;
        b=o2SH7OLGyWg7B/bHCTEIBkVmSgyg0u7YpYWWSLnFezfM3ZCKtKha+FP+ZtHZU+Xti+
         oYuHR1WBUePe2ybXGxAyo0x5mAp82x5hqVau3MSN2XyfNNCl0sCohx7b74xOpsvqtMQt
         9mCwWjiCCLHCNWzEE49fMYTdaJzexFw3J8Prg/DPaVPhAk6Ia+/HuhfM3hSO2aF79Pby
         BgpdxgnRhC7jT4Tu0V3k1EIgT333XgaXEGIHINqo0RNZO5pjhMxonn7x2rhNfKJ3KsNk
         JIX77vNEWeATTAGYp2bCrTwN9USf0FzYjM4szXO0A1MxNo/RrVZqxV/3HoGck9Obg9Gt
         KY5g==
X-Forwarded-Encrypted: i=1; AJvYcCWrixx0bVt32Y4PVVDIIB7QnXf8miNUMSZ7x1wVqzN020QE2gYlu/J10sFqO3wv82SXXjmMsnxCzR0m6nLfVTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoaw9Aa1tzz0QjJao1tS3PsfaNB9DQcBsLpDE0V2q7wjnIwjwr
	BV4xn0ardnx7zJVzUch1mdlOqTwSvVsQHA1R3jCbCC6WxlEK4Pzvq7KN
X-Gm-Gg: ASbGnctyCSwDJH0vl85DT7OVOqFmN/oS9YmmAyu++Xfmg2Dnm+ksRVxKorEWfW/JysQ
	4ZAqXlRzzHMiZCh5Knie4KGbiTvRcg50ko6QDg1k8xQoEcKIEnFKeAPyrbzipjNzfeSbu9WTucI
	dhAUZ5oXCnRCCANeArbIvLuEKH4orjwwtz54qbhzmSZ7kjJByosDjA0xXtnxA1dZp896XA3ISQz
	/SKycliQF92J//LXF7e+LSsfgIny/QpTomncdui+xM+evNKNIGqz7CW7noq3Vobgz0qeWEA1KU+
	4bBsQYoPhVpNmbIrGVM5P8WLmz+fOP8mWJnjgGZIB3HHLzsQKO/A0yY2kkqpg6MHzx213o4F60u
	8suugq/MNfbZl
X-Google-Smtp-Source: AGHT+IFYI6xUECW0h16v588jiT0ovVbbJE4kSbJTscgJo+aFrVYWizgGciaISIi4lMUUQtfLHTILew==
X-Received: by 2002:a17:907:3d4c:b0:b04:61aa:6adc with SMTP id a640c23a62f3a-b34b9f5b4b9mr1693831466b.7.1759157421667;
        Mon, 29 Sep 2025 07:50:21 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3629878sm7983344a12.5.2025.09.29.07.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:50:20 -0700 (PDT)
Date: Mon, 29 Sep 2025 07:50:17 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v5 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <3drbbpiyfpqfzule75q5qi7jm6xkpbvwukzfh6gf4vdibqsef4@v3o7u4rgsq2n>
References: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
 <20250918-netconsole_torture-v5-4-77e25e0a4eb6@debian.org>
 <20250919174901.1a6062d7@kernel.org>
 <w33kl7gd5b4yrakxkg5cnkwgvvzdz6jgwzmwmxyrrf3nxvyspn@3354jtfl26vu>
 <20250926113208.07fa0b2f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926113208.07fa0b2f@kernel.org>

On Fri, Sep 26, 2025 at 11:32:08AM -0700, Jakub Kicinski wrote:
> On Fri, 26 Sep 2025 07:06:50 -0700 Breno Leitao wrote:
> > +# Test #3
> > +# Detach the interface from a bonding interface and attach netpoll again
> > +delete_bond_and_reenable_target
> > +echo "test #3: Able to attach to an unbound interface. Test passed." >&2
> 
> Do we need a fouth case? Enable netpoll on an interface and then try to
> enslave it while netpoll is active, then try to enable netpoll on the
> bond?

Sure, but this is boring, since the interface needs to go down before
enslaving it, which will turn off netconsole/netpoll.

I've added an additional test, where I set netconsole to a
sub-interface, get it down and then enslave it. Then, enable netconsole
on the bond interface.

> And possibly a couple of cases where we set up netpoll on the bond
> first, then we add to bond (success and fail case).

Not sure if I understand this case correctly, but I've added a test
where I create a bonding interface (let's call it bond0) with one
device, then I enable netconsole in bond0. Later, I've added a second
interface to bond0, and make sure netconsole is enabled in bond0.

Is this what you meant?

Here is the current selftest with the additional tests above (and
fixes):

Author: Breno Leitao <leitao@debian.org>
Date:   Wed Sep 17 01:46:26 2025 -0700

    selftest: netcons: add test for netconsole over bonded interfaces
    
    This patch adds a selftest that verifies netconsole functionality
    over bonded network interfaces using netdevsim. It sets up two bonded
    interfaces acting as transmit (TX) and receive (RX) ends, placed in
    separate network namespaces. The test sends kernel log messages and
    verifies that they are properly received on the bonded RX interfaces
    with both IPv4 and IPv6, and using basic and extended netconsole
    formats.
    
    This patchset aims to test a long-standing netpoll are where netpoll has
    multiple users. (in this case netconsole and bonding). A similar
    selftest has been discussed in [1] and [2].
    
    This test also tries to enable bonding and netpoll in different order,
    just to guarantee that all the possibilites are exercised.
    
    Link: https://lore.kernel.org/all/20250905-netconsole_torture-v3-0-875c7febd316@debian.org/ [1]
    Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [2]
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 3462783ed3aca..790e6f086da49 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS := \
 	dev_addr_lists.sh \
 	mode-1-recovery-updelay.sh \
 	mode-2-recovery-updelay.sh \
+	netcons_over_bonding.sh \
 	bond_options.sh \
 	bond-eth-type-change.sh \
 	bond_macvlan_ipvlan.sh \
@@ -20,6 +21,7 @@ TEST_FILES := \
 	bond_topo_3d1c.sh
 
 TEST_INCLUDES := \
+	../lib/sh/lib_netcons.sh \
 	../../../net/forwarding/lib.sh \
 	../../../net/lib.sh
 
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index 832fa1caeb662..f4dd615dd33f1 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -1,5 +1,6 @@
 CONFIG_BONDING=y
 CONFIG_BRIDGE=y
+CONFIG_CONFIGFS_FS=y
 CONFIG_DUMMY=y
 CONFIG_IPV6=y
 CONFIG_MACVLAN=y
@@ -8,6 +9,10 @@ CONFIG_NET_ACT_GACT=y
 CONFIG_NET_CLS_FLOWER=y
 CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NET_SCH_INGRESS=y
+CONFIG_NETCONSOLE=m
+CONFIG_NETCONSOLE_DYNAMIC=y
+CONFIG_NETCONSOLE_EXTENDED_LOG=y
+CONFIG_NETDEVSIM=m
 CONFIG_NLMON=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=m
diff --git a/tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh b/tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh
new file mode 100755
index 0000000000000..8dde9c29151e9
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh
@@ -0,0 +1,203 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# This test verifies netconsole functionality over a bonded network setup.
+#
+# Four interfaces are created using netdevsim; two of them are bonded to serve
+# as the netconsole's transmit interface. The remaining two interfaces are
+# similarly bonded and assigned to a separate network namespace, which acts as
+# the receive interface, where socat monitors for incoming messages.
+#
+# A netconsole message is then sent to ensure it is properly received across
+# this configuration.
+#
+# Later, try to enable netconsole on an interface that is part of a bonding
+# interface, which should fail. Also do some other basic small tests.
+#
+# The test's objective is to exercise netpoll usage when managed simultaneously
+# by multiple subsystems (netconsole and bonding).
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/../lib/sh/lib_netcons.sh
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+modprobe bonding 2> /dev/null || true
+
+# The content of kmsg will be save to the following file
+OUTPUT_FILE="/tmp/${TARGET}"
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup_bond EXIT
+
+FORMAT="extended"
+IP_VERSION="ipv6"
+
+function create_all_ifaces() {
+	# setup_ns function is coming from lib.sh
+	setup_ns NAMESPACE
+
+	# Create two interfaces for RX and two for TX
+	create_ifaces_bond
+	# Link netlink ifaces
+	link_ifaces_bond
+}
+
+# configure DSTIF and SRCIF IPs
+function configure_ifaces_ips() {
+	local IP_VERSION=${1:-"ipv4"}
+	select_ipv4_or_ipv6 "${IP_VERSION}"
+	configure_ip
+}
+
+function enable_netpoll_on_enslaved_iface() {
+	echo 0 > "${NETCONS_PATH}"/enabled
+
+	# At this stage, BOND_TX1_IF is enslaved to BONDTX_IF, and linked to
+	# BOND_RX1_IF inside the namespace.
+	echo "${BOND_TX1_IF}" > "${NETCONS_PATH}"/dev_name
+
+	# This should fail with the following message in dmesg:
+	# netpoll: netconsole: ethX is a slave device, aborting
+	set +e
+	echo 1 > "${NETCONS_PATH}"/enabled
+	set -e
+
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 1 ]]
+	then
+		echo "test failed: Bonding and netpoll cannot co-exists." >&2
+		exit "${ksft_fail}"
+	fi
+}
+
+function delete_bond_and_reenable_target() {
+	ip link delete "${BONDTX_IF}" type bond
+
+	# BOND_TX1_IF is not attached to a bond interface anymore
+	# netpoll can be plugged in there
+	echo "${BOND_TX1_IF}" > "${NETCONS_PATH}"/dev_name
+
+	# this should work, since the interface is not enslaved
+	echo 1 > "${NETCONS_PATH}"/enabled
+
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 0 ]]
+	then
+		echo "test failed: Unable to start netpoll on an unbond iface." >&2
+		exit "${ksft_fail}"
+	fi
+}
+
+# Send a netconsole message to the netconsole target
+function send_netcons_msg_through_bond_iface() {
+	# Listed for netconsole port inside the namespace and
+	# destination interface
+	listen_port_and_save_to "${OUTPUT_FILE}" "${IP_VERSION}" &
+	# Wait for socat to start and listen to the port.
+	wait_for_port "${NAMESPACE}" "${PORT}" "${IP_VERSION}"
+	# Send the message
+	echo "${MSG}: ${TARGET}" > /dev/kmsg
+	# Wait until socat saves the file to disk
+	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+	# Make sure the message was received in the dst part
+	# and exit
+	validate_result "${OUTPUT_FILE}" "${FORMAT}"
+	# kill socat in case it is still running
+	pkill_socat
+}
+
+# BOND_TX1_IF has netconsole enabled on it, bind it to
+# BONDTX_IF.
+# Given BONDTX_IF was deleted, recreate it first
+function enslave_netcons_enabled_iface {
+	# recreate the bonding iface, that got deleted in the previous
+	# test
+	ip link add "${BONDTX_IF}" type bond mode balance-rr
+	# sub-interface need to be down before attaching to bonding
+	ip link set "${BOND_TX1_IF}" down
+	ip link set "${BOND_TX1_IF}" master "${BONDTX_IF}"
+	ip link set "${BONDTX_IF}" up
+	# netconsole got disabled while the interface was down
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 1 ]]
+	then
+		echo "test failed: Device is part of a bond iface, cannot have netcons enabled" >&2
+		exit "${ksft_fail}"
+	fi
+}
+
+# Get netconsole enabled on a bonding interface and attach a second
+# sub-interface.
+function enslave_iface_to_bond {
+	# BONDTX_IF has only BOND_TX1_IF right now
+	echo "${BONDTX_IF}" > "${NETCONS_PATH}"/dev_name
+	echo 1 > "${NETCONS_PATH}"/enabled
+
+	# netcons is attached to bond0 and BOND_TX1_IF is
+	# part of BONDTX_IF. Attach BOND_TX2_IF to BONDTX_IF.
+	ip link set "${BOND_TX2_IF}" master "${BONDTX_IF}"
+	if [[ $(cat "${NETCONS_PATH}"/enabled) -eq 0 ]]
+	then
+		echo "test failed: Netconsole should be enabled on bonding interface. Failed" >&2
+		exit "${ksft_fail}"
+	fi
+}
+
+# Tests start here #
+####################
+
+# Create one namespace and two interfaces
+create_all_ifaces
+
+# then bind the interfaces with netpoll attached
+setup_bonding_ifaces
+
+# First test send a msg through bonding
+export DSTIF="${BONDRX_IF}"
+export SRCIF="${BONDTX_IF}"
+
+# Configure the ips as BOND_RX1_IF and BOND_TX1_IF
+configure_ifaces_ips "${IP_VERSION}"
+create_dynamic_target "${FORMAT}"
+set_user_data
+
+# Test #1 : Create an bonding interface and attach netpoll into
+# the bonding interface. Netconsole/netpoll should work on
+# the bonding interface.
+send_netcons_msg_through_bond_iface
+echo "test #1: netpoll on bonding interface worked. Test passed" >&2
+
+# Test #2: Attach netpoll to an enslaved interface
+# Try to attach netpoll to an enslaved interface (while still being part of a
+# bonding interface), which shouldn't be allowed
+enable_netpoll_on_enslaved_iface
+echo "test #2: netpoll correctly rejected enslaved interface (expected behavior). Test passed." >&2
+
+# Test #3: Unplug the interface from bond and enable netconsole
+# Detach the interface from a bonding interface and attach netpoll again
+delete_bond_and_reenable_target
+echo "test #3: Able to attach to an unbound interface. Test passed." >&2
+
+# Test #4: Enslave an interface that had netpoll enabled
+# Try to enslave the interface that has netpoll enabled.
+# Previous test has netconsole enabled in BOND_TX1_IF, try to enslave it
+enslave_netcons_enabled_iface
+echo "test #4: Enslaving an interface with netpoll attached. Test passed." >&2
+
+# Test #5: Enslave an interface to a bonding interface with netconsole
+# Enslave an interface to a bond interface that has netpoll attached
+# At this stage, BONDTX_IF is created and BOND_TX1_IF is part of it.
+# Netconsole is disabled
+enslave_iface_to_bond
+echo "test #5: Enslaving an interface to bond+netpoll. Test passed." >&2
+
+cleanup_bond
+trap - EXIT
+exit "${EXIT_STATUS}"
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 9b5ef8074440c..4862d025b7c74 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -28,17 +28,24 @@ NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
 # NAMESPACE will be populated by setup_ns with a random value
 NAMESPACE=""
 
-# IDs for netdevsim
+# IDs for netdevsim. We either use NSIM_DEV_{1,2}_ID for standard test
+# or NSIM_BOND_{T,R}X_{1,2} for the bonding tests. Not both at the
+# same time.
 NSIM_DEV_1_ID=$((256 + RANDOM % 256))
 NSIM_DEV_2_ID=$((512 + RANDOM % 256))
+NSIM_BOND_TX_1=$((768 + RANDOM % 256))
+NSIM_BOND_TX_2=$((1024 + RANDOM % 256))
+NSIM_BOND_RX_1=$((1280 + RANDOM % 256))
+NSIM_BOND_RX_2=$((1536 + RANDOM % 256))
 NSIM_DEV_SYS_NEW="/sys/bus/netdevsim/new_device"
+NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
+NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
 
 # Used to create and delete namespaces
 source "${LIBDIR}"/../../../../net/lib.sh
 
 # Create netdevsim interfaces
 create_ifaces() {
-
 	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
 	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
 	udevadm settle 2> /dev/null || true
@@ -54,7 +61,6 @@ create_ifaces() {
 }
 
 link_ifaces() {
-	local NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
 	local SRCIF_IFIDX=$(cat /sys/class/net/"$SRCIF"/ifindex)
 	local DSTIF_IFIDX=$(cat /sys/class/net/"$DSTIF"/ifindex)
 
@@ -96,6 +102,33 @@ function select_ipv4_or_ipv6()
 	fi
 }
 
+# Create 4 netdevsim interfaces. Two of them will be bound to TX bonding iface
+# and the other two will be bond to the RX interface (on the other namespace)
+function create_ifaces_bond() {
+	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_NEW"
+	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_NEW"
+	udevadm settle 2> /dev/null || true
+
+	local BOND_TX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_1"
+	local BOND_TX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_2"
+	local BOND_RX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_1"
+	local BOND_RX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_2"
+
+	# TX
+	BOND_TX1_IF=$(find "$BOND_TX1"/net -maxdepth 1 -type d ! \
+		-path "$BOND_TX1"/net -exec basename {} \; | grep -v net)
+	BOND_TX2_IF=$(find "$BOND_TX2"/net -maxdepth 1 -type d ! \
+		-path "$BOND_TX2"/net -exec basename {} \; | grep -v net)
+
+	# RX
+	BOND_RX1_IF=$(find "$BOND_RX1"/net -maxdepth 1 -type d ! \
+		-path "$BOND_RX1"/net -exec basename {} \; | grep -v net)
+	BOND_RX2_IF=$(find "$BOND_RX2"/net -maxdepth 1 -type d ! \
+		-path "$BOND_RX2"/net -exec basename {} \; | grep -v net)
+}
+
 function set_network() {
 	local IP_VERSION=${1:-"ipv4"}
 
@@ -180,8 +213,6 @@ function disable_release_append() {
 }
 
 function do_cleanup() {
-	local NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
-
 	# Delete netdevsim devices
 	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_DEL"
 	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_DEL"
@@ -193,14 +224,26 @@ function do_cleanup() {
 	echo "${DEFAULT_PRINTK_VALUES}" > /proc/sys/kernel/printk
 }
 
-function cleanup() {
+function cleanup_netcons() {
 	# delete netconsole dynamic reconfiguration
-	echo 0 > "${NETCONS_PATH}"/enabled
+	# do not fail if the target is already disabled
+	if [[ ! -d "${NETCONS_PATH}" ]]
+	then
+		# in some cases this is called before netcons path is created
+		return
+	fi
+	if [[ $(cat "${NETCONS_PATH}"/enabled) != 0 ]]
+	then
+		echo 0 > "${NETCONS_PATH}"/enabled || true
+	fi
 	# Remove all the keys that got created during the selftest
 	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
 	# Remove the configfs entry
 	rmdir "${NETCONS_PATH}"
+}
 
+function cleanup() {
+	cleanup_netcons
 	do_cleanup
 }
 
@@ -377,3 +420,105 @@ function wait_for_port() {
 	# more frequently on IPv6
 	sleep 1
 }
+
+# netdevsim link BOND_TX to BOND_RX interfaces
+function link_ifaces_bond() {
+	local BOND_TX1_IFIDX
+	local BOND_TX2_IFIDX
+	local BOND_RX1_IFIDX
+	local BOND_RX2_IFIDX
+
+	BOND_TX1_IFIDX=$(cat /sys/class/net/"$BOND_TX1_IF"/ifindex)
+	BOND_TX2_IFIDX=$(cat /sys/class/net/"$BOND_TX2_IF"/ifindex)
+	BOND_RX1_IFIDX=$(cat /sys/class/net/"$BOND_RX1_IF"/ifindex)
+	BOND_RX2_IFIDX=$(cat /sys/class/net/"$BOND_RX2_IF"/ifindex)
+
+	exec {NAMESPACE_FD}</var/run/netns/"${NAMESPACE}"
+	exec {INITNS_FD}</proc/self/ns/net
+
+	# Bind the dst interfaces to namespace
+	ip link set "${BOND_RX1_IF}" netns "${NAMESPACE}"
+	ip link set "${BOND_RX2_IF}" netns "${NAMESPACE}"
+
+	# Linking TX ifaces to the RX ones (on the other namespace}
+	echo "${INITNS_FD}:$BOND_TX1_IFIDX $NAMESPACE_FD:$BOND_RX1_IFIDX"  \
+		> "$NSIM_DEV_SYS_LINK"
+	echo "${INITNS_FD}:$BOND_TX2_IFIDX $NAMESPACE_FD:$BOND_RX2_IFIDX"  \
+		> "$NSIM_DEV_SYS_LINK"
+}
+
+# Create "bond_tx_XX" and "bond_rx_XX" interfaces, and set DSTIF and SRCIF with
+# the bonding interfaces
+function setup_bonding_ifaces() {
+	local RAND=$(( RANDOM % 100 ))
+	BONDTX_IF="bond_tx_$RAND"
+	BONDRX_IF="bond_rx_$RAND"
+
+	if ! ip link add "${BONDTX_IF}" type bond mode balance-rr
+	then
+		echo "Failed to create bond TX interface. Is CONFIG_BONDING set?" >&2
+		# only clean nsim ifaces and namespace. Nothing else has been
+		# initialized
+		cleanup_bond_nsim
+		trap - EXIT
+		exit "${ksft_skip}"
+	fi
+	ip link set "${BOND_TX1_IF}" down
+	ip link set "${BOND_TX2_IF}" down
+
+	ip link set "${BOND_TX1_IF}" master "${BONDTX_IF}"
+	ip link set "${BOND_TX2_IF}" master "${BONDTX_IF}"
+	ip link set "${BONDTX_IF}" up
+
+	# now create the RX bonding iface
+	ip netns exec "${NAMESPACE}" \
+		ip link add "${BONDRX_IF}" type bond mode balance-rr
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX1_IF}" down
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX2_IF}" down
+
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX1_IF}" master "${BONDRX_IF}"
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX2_IF}" master "${BONDRX_IF}"
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BONDRX_IF}" up
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX1_IF}" up
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX2_IF}" up
+
+}
+
+# Clean up netdevsim ifaces created for bonding test
+function cleanup_bond_nsim() {
+	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_DEL"
+	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_DEL"
+	cleanup_all_ns
+}
+
+# cleanup tests that use bonding interfaces
+function cleanup_bond() {
+	cleanup_netcons
+
+	# Delete TX ifaces
+	ip link set "${BONDTX_IF}" down  2> /dev/null|| true
+	ip link set "${BOND_TX1_IF}" down || true
+	ip link set "${BOND_TX2_IF}" down || true
+	ip link delete "${BONDTX_IF}" type bond  2> /dev/null || true
+
+	# Delete RX ifaces
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BONDRX_IF}" down || true
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX1_IF}" down || true
+	ip netns exec "${NAMESPACE}" \
+		ip link set "${BOND_RX2_IF}" down || true
+	ip netns exec "${NAMESPACE}" \
+		ip link delete "${BONDRX_IF}" type bond  || true
+
+	cleanup_bond_nsim
+}


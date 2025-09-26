Return-Path: <linux-kselftest+bounces-42484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECDBBA4098
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 16:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC51C16F60A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 14:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398502F3605;
	Fri, 26 Sep 2025 14:06:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F419D8A7
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895618; cv=none; b=pzgV+1Sq35Rb7HLYsX7YAlK85wYg2RXQ7A/Yiex0G9XY940Rw0GUVXmCbwZwZlHesNH+Bq+X79cLfXQ0saTjU4ebkf1rSPhb3PP7ldbC8UEO2xjE65qgWs2SRdOaDjF1tj+/sU49v8ajK8lcSWabFFgJoeQA3Ak0z5N+D5ucUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895618; c=relaxed/simple;
	bh=mcWp1ZJyq/OHv3rBsWb5eEkiJNpE1v6uQVhn0O/IzEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daFf6dUgrZIUH763EMULSLEnczq8OgUo/d+obId5Sr4+pE3ogNKYf/wLx+KDMzrIvkUmSD0BSe9vlQgL7LrxJy/vvjOC1XXFbLND/onteIorfyYs7Gz97rD5CHN94s3urHLEATqXeaE78AxRvD/HOUFsrgYiUgT0QdGGq/m0r8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62faeed4371so3080781a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 07:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758895614; x=1759500414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+lA82tzu55369RBX1B6jx731vSOg1fkk1UCnzkC/Z4=;
        b=BTNXZ65jxlIyluVWtV0yAjqxu2jpu2TjxqoOvfl6JSUVdYdI/o+Q74xQ5v/ONiTOYK
         paSBir5QbZlLHZZ3gGcD/WElFtfZzZv+SOyfBd+6D0hkeGVp3P3PL/SjwpOlg9OZPxo2
         ONJuWoVySueRUdBxKveB6kGxIYV14zHyX1Mp9+ZVrTLZ3DI9msPB5LhGbEs3agD6q6WD
         Cg/wn0QZjrxIJp3wuWpoX9LC+8OQwUMqbh9YB8mU617oiJJK1NBw5PUP45Gfmd5m9oZE
         QE14i89hv00Gnu0Qc4Z0hUr/abJS639P/NEzAls8nijRqUjcrdoZ4JCyphYnc/tGYEUr
         yfWg==
X-Forwarded-Encrypted: i=1; AJvYcCXUGMi0LuwHwb9cWbvF+tle/WGJ9rLbkv59vlbrft6aO/kvT3UAsjo1S31zN0XXtF/XJ0Q94ityZ8+fu/AEWmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzts6XbEd2KWJuXb51GSKzu6deTBzgYSGuErtpJM7Dkn2bIZNbz
	Pj/Z6x74dClxXMBToqq8TbpwR2dCouIjBgbi8jv4ujB8NzVAqr/ICK8A
X-Gm-Gg: ASbGncuiMYbssyqSd6okSA/Lu7RP8TBH9T7GhWJF61gwXcwOIYQjURwDoiKQFZFgEtP
	t/PdQ45ynbzupL3XlQ0/b7mh1earJXkX+7/v/N2HXOvR5kdyR9kziyTsu8jO6U6YGzfGhkte3W/
	KNvCneFCnJ45vs0pTntU+eTO1ae9UcX0doMAA4122JYV6DAGq1uzPuWaZtLKZCLHWqIBV8iSCcG
	CYYqibBdSKu6iZiy3KvR+HK3SsIjvtMRXkPMp1kgd4GF8qmvRzZ9dzIZdHbz4Kf/d8/qevsxiOj
	rtfzYq3uaK4LcCPGhyDMb2NcGI+j/pM2XKMzbnhkRP4Ow5itcZS/UZZ7LTTiE5blwf/bOWupcvs
	3xC8UW7HD/F9Nq+RJAK65
X-Google-Smtp-Source: AGHT+IH3OdZzKoohuBy+imC73AMo70Gm5S4v1kYaL31mOU7KRzhtAcpwxcCCs6FXVeDEtAEL+4oPJg==
X-Received: by 2002:a17:907:1c8c:b0:afe:e9ee:4ae0 with SMTP id a640c23a62f3a-b34beba9703mr844280166b.59.1758895613944;
        Fri, 26 Sep 2025 07:06:53 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a96977sm370730966b.93.2025.09.26.07.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:06:53 -0700 (PDT)
Date: Fri, 26 Sep 2025 07:06:50 -0700
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
Message-ID: <w33kl7gd5b4yrakxkg5cnkwgvvzdz6jgwzmwmxyrrf3nxvyspn@3354jtfl26vu>
References: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
 <20250918-netconsole_torture-v5-4-77e25e0a4eb6@debian.org>
 <20250919174901.1a6062d7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919174901.1a6062d7@kernel.org>

Hello Jakub,

On Fri, Sep 19, 2025 at 05:49:01PM -0700, Jakub Kicinski wrote:
> On Thu, 18 Sep 2025 03:42:08 -0700 Breno Leitao wrote:
> > This patch adds a selftest that verifies netconsole functionality
> > over bonded network interfaces using netdevsim. It sets up two bonded
> > interfaces acting as transmit (TX) and receive (RX) ends, placed in
> > separate network namespaces. The test sends kernel log messages and
> > verifies that they are properly received on the bonded RX interfaces
> > with both IPv4 and IPv6, and using basic and extended netconsole
> > formats.
> 
> I'm not great at reading bash but I don't think this tests what we care
> about. We want to test bonding's special ability to propagate a netpoll
> instances onto its sub-interfaces. So you should be trying to test
> different orders of setting and disabling netpoll on the bond and its
> sub-interfaces (while the other is setup path is also active).

Ack. I am extending the test, to try to enable netpoll/netconsole on a
sub-interface, which should fail. It should not be possible to have
netconsole in an sub-interface

Prohibiting a sub-interface from having netpoll was added a while ago by
0c1ad04aecb975 ("netpoll: prevent netpoll setup on slave devices")

So, my suggestion is:

1) test netpoll/netconsole on a bonding interface
2) Try to setup netconsole on a sub-interface (and it should fail)
3) remove the sub-interface from the bonding interface, and netconsole/netpoll setup
should succeed.

> Since the bonding tests can't run on real HW it can't live directly in
> tools/testing/selftests/drivers/net/ we need to move it to either the
> netdevsim group or the bonding group.

Are you talking abouttools/testing/selftests/drivers/net/bonding as the
bonding group?

With the changed above, this is how the selftest looks like now:

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
    
    This test also try to enable bonding and netpoll at the same time, and
    make sure that it fails.
    
    Link: https://lore.kernel.org/all/20250905-netconsole_torture-v3-0-875c7febd316@debian.org/ [1]
    Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [2]
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 3462783ed3aca..d7fb239c02814 100644
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
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index 4d16a69ffc650..c9e609ff5b5dd 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -10,3 +10,8 @@ CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
+CONFIG_NETDEVSIM=m
+CONFIG_CONFIGFS_FS=y
+CONFIG_NETCONSOLE=m
+CONFIG_NETCONSOLE_DYNAMIC=y
+CONFIG_NETCONSOLE_EXTENDED_LOG=y
diff --git a/tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh b/tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh
new file mode 100755
index 0000000000000..f80e29152a35b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh
@@ -0,0 +1,156 @@
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
+# interface, which should fail.
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
+	if [ "$(cat "${NETCONS_PATH}/enabled")" -eq 1 ]
+	then
+		echo "netpoll: Bonding and netpoll cannot co-exists. Test failed." >&2
+		exit "${ksft_fail}"
+
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
+	if [ "$(cat "${NETCONS_PATH}/enabled")" -eq 0 ]
+	then
+		echo "netpoll: Unable to start netpoll on an unbond iface. Test failed." >&2
+		exit "${ksft_fail}"
+
+	fi
+}
+
+function send_netcons_msg_through_bond_iface() {
+
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
+# Tests start here
+
+# Create one namespace and two interfaces
+create_all_ifaces
+
+# then bind the interfaces with netpoll attached
+setup_bonding_ifaces
+
+# First test send a msg through bonding
+DSTIF="${BONDRX_IF}"
+SRCIF="${BONDTX_IF}"
+
+# Configure the ips as BOND_RX1_IF and BOND_TX1_IF
+configure_ifaces_ips "${IP_VERSION}"
+create_dynamic_target "${FORMAT}"
+set_user_data
+
+# Test #1
+# Create an bonding interface and attach netpoll into
+# the bonding interface. Netconsole/netpoll should work on
+# the bonding interface.
+send_netcons_msg_through_bond_iface
+echo "test #1: netpoll on bonding interface worked. Test passed" >&2
+
+# Test #2.
+# Try to attach netpoll to an enslaved interface (while still being part of a
+# bonding interface), which shouldn't be allowed
+enable_netpoll_on_enslaved_iface
+echo "test #2: netpoll correctly rejected enslaved interface (expected behavior). Test passed." >&2
+
+# Test #3
+# Detach the interface from a bonding interface and attach netpoll again
+delete_bond_and_reenable_target
+echo "test #3: Able to attach to an unbound interface. Test passed." >&2
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



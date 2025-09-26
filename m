Return-Path: <linux-kselftest+bounces-42499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46CCBA4E5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 20:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B36A628623
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70862F83C2;
	Fri, 26 Sep 2025 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leemcH/d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB11E49F;
	Fri, 26 Sep 2025 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911530; cv=none; b=u6JmHqzU9c9GfZr5mWuGEY67HWTIUDYB0hRLCXUc2pg+sz4FNYiwYOQHiFy68NardT+tiiEUgKouawtvSqG52hzNqs2aTv/avkz1UofhxaKNAs79ScXuzAhKUqROeUkaz8rLC1PF3Sq1qQDWJ+9IgA6bgKhx36GoEpF3XoZhfs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911530; c=relaxed/simple;
	bh=HHb3PYPRZqcGwa2oDar0OGgY5SRFk/y52NOpVGOEYFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/+YlALlOyyjDRkGYO4pFikzRv5VGseUuG8Z7Kfxiq04vZLYjSbDkYQeTD2i87sgITGrUwt7helg4YWy5yuG8hdz2nCthcoUKNo/mAK/X+Lzr6oCA0es5qHAvwT7HLxBO3Tdgi9ryEdrNC8bn2RY6iaOzUkQ59WrbMDwZyu5pp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leemcH/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D55C4CEF4;
	Fri, 26 Sep 2025 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758911530;
	bh=HHb3PYPRZqcGwa2oDar0OGgY5SRFk/y52NOpVGOEYFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=leemcH/dDtJt1EuPjMDmoh5lEkceYUgozl1tpO3F027UvvbZDuIohOZGvQDBMz/C7
	 0nO8VraVePP71Id9JgW93RvZwLK8A2cOb5fIjn4ITfdi7QdDV1HG53UeRlIW1mXqO6
	 Lt7IsoQgiRY9j1vVRy+aNJJJb01miIxcy/Fx4Nj1wROj8ccR2Z4B96t94DFxBBR0wR
	 /B5sGws9ExOM0grqQQrM6Ytl6PWC4owd3M8ezZFutrfQHW3Cc9OWWQGNRsferI0O4Z
	 sRaDuc4J7zCC4qUgVyAs+cKYOdcNMNRtBpLwQMOEFXeQ55jiWyVKR4Rohc8JXZ+M56
	 FxKFpCRq5+OJA==
Date: Fri, 26 Sep 2025 11:32:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, david decotigny <decot@googlers.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 calvin@wbinvd.org, kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v5 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <20250926113208.07fa0b2f@kernel.org>
In-Reply-To: <w33kl7gd5b4yrakxkg5cnkwgvvzdz6jgwzmwmxyrrf3nxvyspn@3354jtfl26vu>
References: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
	<20250918-netconsole_torture-v5-4-77e25e0a4eb6@debian.org>
	<20250919174901.1a6062d7@kernel.org>
	<w33kl7gd5b4yrakxkg5cnkwgvvzdz6jgwzmwmxyrrf3nxvyspn@3354jtfl26vu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 07:06:50 -0700 Breno Leitao wrote:
> > Since the bonding tests can't run on real HW it can't live directly in
> > tools/testing/selftests/drivers/net/ we need to move it to either the
> > netdevsim group or the bonding group.  
> 
> Are you talking abouttools/testing/selftests/drivers/net/bonding as the
> bonding group?
> 
> With the changed above, this is how the selftest looks like now:
> 
> Author: Breno Leitao <leitao@debian.org>
> Date:   Wed Sep 17 01:46:26 2025 -0700
> 
>     selftest: netcons: add test for netconsole over bonded interfaces
>     
>     This patch adds a selftest that verifies netconsole functionality
>     over bonded network interfaces using netdevsim. It sets up two bonded
>     interfaces acting as transmit (TX) and receive (RX) ends, placed in
>     separate network namespaces. The test sends kernel log messages and
>     verifies that they are properly received on the bonded RX interfaces
>     with both IPv4 and IPv6, and using basic and extended netconsole
>     formats.
>     
>     This patchset aims to test a long-standing netpoll are where netpoll has
>     multiple users. (in this case netconsole and bonding). A similar
>     selftest has been discussed in [1] and [2].
>     
>     This test also try to enable bonding and netpoll at the same time, and
>     make sure that it fails.
>     
>     Link: https://lore.kernel.org/all/20250905-netconsole_torture-v3-0-875c7febd316@debian.org/ [1]
>     Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [2]
>     Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
> index 3462783ed3aca..d7fb239c02814 100644
> --- a/tools/testing/selftests/drivers/net/bonding/Makefile
> +++ b/tools/testing/selftests/drivers/net/bonding/Makefile
> @@ -8,6 +8,7 @@ TEST_PROGS := \
>  	dev_addr_lists.sh \
>  	mode-1-recovery-updelay.sh \
>  	mode-2-recovery-updelay.sh \
> +	netcons_over_bonding.sh \
>  	bond_options.sh \
>  	bond-eth-type-change.sh \
>  	bond_macvlan_ipvlan.sh \

Do we need to add the netcons lib to TEST_INCLUDES  ?

> diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
> index 4d16a69ffc650..c9e609ff5b5dd 100644
> --- a/tools/testing/selftests/drivers/net/bonding/config
> +++ b/tools/testing/selftests/drivers/net/bonding/config
> @@ -10,3 +10,8 @@ CONFIG_NET_CLS_MATCHALL=m
>  CONFIG_NET_SCH_INGRESS=y
>  CONFIG_NLMON=y
>  CONFIG_VETH=y
> +CONFIG_NETDEVSIM=m
> +CONFIG_CONFIGFS_FS=y
> +CONFIG_NETCONSOLE=m
> +CONFIG_NETCONSOLE_DYNAMIC=y
> +CONFIG_NETCONSOLE_EXTENDED_LOG=y

For the config options some approximation of alphabetical sort is good.
Adding at the end increases the risk of cherry-pick / merge conflicts
dramatically.

> +function enable_netpoll_on_enslaved_iface() {
> +	echo 0 > "${NETCONS_PATH}"/enabled
> +
> +	# At this stage, BOND_TX1_IF is enslaved to BONDTX_IF, and linked to
> +	# BOND_RX1_IF inside the namespace.
> +	echo "${BOND_TX1_IF}" > "${NETCONS_PATH}"/dev_name
> +
> +	# This should fail with the following message in dmesg:
> +	# netpoll: netconsole: ethX is a slave device, aborting
> +	set +e
> +	echo 1 > "${NETCONS_PATH}"/enabled
> +	set -e
> +
> +	if [ "$(cat "${NETCONS_PATH}/enabled")" -eq 1 ]
> +	then
> +		echo "netpoll: Bonding and netpoll cannot co-exists. Test failed." >&2
> +		exit "${ksft_fail}"
> +

nit: extra nl

> +	fi
> +}

> +# Test #3
> +# Detach the interface from a bonding interface and attach netpoll again
> +delete_bond_and_reenable_target
> +echo "test #3: Able to attach to an unbound interface. Test passed." >&2

Do we need a fouth case? Enable netpoll on an interface and then try to
enslave it while netpoll is active, then try to enable netpoll on the
bond?

And possibly a couple of cases where we set up netpoll on the bond
first, then we add to bond (success and fail case).

> +cleanup_bond
> +trap - EXIT
> +exit "${EXIT_STATUS}"
> diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> index 9b5ef8074440c..4862d025b7c74 100644
> --- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> +++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> @@ -28,17 +28,24 @@ NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
>  # NAMESPACE will be populated by setup_ns with a random value
>  NAMESPACE=""
>  
> -# IDs for netdevsim
> +# IDs for netdevsim. We either use NSIM_DEV_{1,2}_ID for standard test
> +# or NSIM_BOND_{T,R}X_{1,2} for the bonding tests. Not both at the
> +# same time.
>  NSIM_DEV_1_ID=$((256 + RANDOM % 256))
>  NSIM_DEV_2_ID=$((512 + RANDOM % 256))
> +NSIM_BOND_TX_1=$((768 + RANDOM % 256))
> +NSIM_BOND_TX_2=$((1024 + RANDOM % 256))
> +NSIM_BOND_RX_1=$((1280 + RANDOM % 256))
> +NSIM_BOND_RX_2=$((1536 + RANDOM % 256))
>  NSIM_DEV_SYS_NEW="/sys/bus/netdevsim/new_device"
> +NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
> +NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
>  
>  # Used to create and delete namespaces
>  source "${LIBDIR}"/../../../../net/lib.sh
>  
>  # Create netdevsim interfaces
>  create_ifaces() {
> -
>  	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
>  	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
>  	udevadm settle 2> /dev/null || true
> @@ -54,7 +61,6 @@ create_ifaces() {
>  }
>  
>  link_ifaces() {
> -	local NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
>  	local SRCIF_IFIDX=$(cat /sys/class/net/"$SRCIF"/ifindex)
>  	local DSTIF_IFIDX=$(cat /sys/class/net/"$DSTIF"/ifindex)
>  
> @@ -96,6 +102,33 @@ function select_ipv4_or_ipv6()
>  	fi
>  }
>  
> +# Create 4 netdevsim interfaces. Two of them will be bound to TX bonding iface
> +# and the other two will be bond to the RX interface (on the other namespace)
> +function create_ifaces_bond() {
> +	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_NEW"
> +	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_NEW"
> +	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_NEW"
> +	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_NEW"
> +	udevadm settle 2> /dev/null || true
> +
> +	local BOND_TX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_1"
> +	local BOND_TX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_2"
> +	local BOND_RX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_1"
> +	local BOND_RX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_2"
> +
> +	# TX
> +	BOND_TX1_IF=$(find "$BOND_TX1"/net -maxdepth 1 -type d ! \
> +		-path "$BOND_TX1"/net -exec basename {} \; | grep -v net)
> +	BOND_TX2_IF=$(find "$BOND_TX2"/net -maxdepth 1 -type d ! \
> +		-path "$BOND_TX2"/net -exec basename {} \; | grep -v net)
> +
> +	# RX
> +	BOND_RX1_IF=$(find "$BOND_RX1"/net -maxdepth 1 -type d ! \
> +		-path "$BOND_RX1"/net -exec basename {} \; | grep -v net)
> +	BOND_RX2_IF=$(find "$BOND_RX2"/net -maxdepth 1 -type d ! \
> +		-path "$BOND_RX2"/net -exec basename {} \; | grep -v net)
> +}
> +
>  function set_network() {
>  	local IP_VERSION=${1:-"ipv4"}
>  
> @@ -180,8 +213,6 @@ function disable_release_append() {
>  }
>  
>  function do_cleanup() {
> -	local NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
> -
>  	# Delete netdevsim devices
>  	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_DEL"
>  	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_DEL"
> @@ -193,14 +224,26 @@ function do_cleanup() {
>  	echo "${DEFAULT_PRINTK_VALUES}" > /proc/sys/kernel/printk
>  }
>  
> -function cleanup() {
> +function cleanup_netcons() {
>  	# delete netconsole dynamic reconfiguration
> -	echo 0 > "${NETCONS_PATH}"/enabled
> +	# do not fail if the target is already disabled
> +	if [[ ! -d "${NETCONS_PATH}" ]]
> +	then
> +		# in some cases this is called before netcons path is created
> +		return
> +	fi
> +	if [[ $(cat "${NETCONS_PATH}"/enabled) != 0 ]]
> +	then
> +		echo 0 > "${NETCONS_PATH}"/enabled || true
> +	fi
>  	# Remove all the keys that got created during the selftest
>  	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
>  	# Remove the configfs entry
>  	rmdir "${NETCONS_PATH}"
> +}
>  
> +function cleanup() {
> +	cleanup_netcons
>  	do_cleanup
>  }
>  
> @@ -377,3 +420,105 @@ function wait_for_port() {
>  	# more frequently on IPv6
>  	sleep 1
>  }
> +
> +# netdevsim link BOND_TX to BOND_RX interfaces
> +function link_ifaces_bond() {
> +	local BOND_TX1_IFIDX
> +	local BOND_TX2_IFIDX
> +	local BOND_RX1_IFIDX
> +	local BOND_RX2_IFIDX
> +
> +	BOND_TX1_IFIDX=$(cat /sys/class/net/"$BOND_TX1_IF"/ifindex)
> +	BOND_TX2_IFIDX=$(cat /sys/class/net/"$BOND_TX2_IF"/ifindex)
> +	BOND_RX1_IFIDX=$(cat /sys/class/net/"$BOND_RX1_IF"/ifindex)
> +	BOND_RX2_IFIDX=$(cat /sys/class/net/"$BOND_RX2_IF"/ifindex)
> +
> +	exec {NAMESPACE_FD}</var/run/netns/"${NAMESPACE}"
> +	exec {INITNS_FD}</proc/self/ns/net
> +
> +	# Bind the dst interfaces to namespace
> +	ip link set "${BOND_RX1_IF}" netns "${NAMESPACE}"
> +	ip link set "${BOND_RX2_IF}" netns "${NAMESPACE}"
> +
> +	# Linking TX ifaces to the RX ones (on the other namespace}
> +	echo "${INITNS_FD}:$BOND_TX1_IFIDX $NAMESPACE_FD:$BOND_RX1_IFIDX"  \
> +		> "$NSIM_DEV_SYS_LINK"
> +	echo "${INITNS_FD}:$BOND_TX2_IFIDX $NAMESPACE_FD:$BOND_RX2_IFIDX"  \
> +		> "$NSIM_DEV_SYS_LINK"
> +}
> +
> +# Create "bond_tx_XX" and "bond_rx_XX" interfaces, and set DSTIF and SRCIF with
> +# the bonding interfaces
> +function setup_bonding_ifaces() {
> +	local RAND=$(( RANDOM % 100 ))
> +	BONDTX_IF="bond_tx_$RAND"
> +	BONDRX_IF="bond_rx_$RAND"
> +
> +	if ! ip link add "${BONDTX_IF}" type bond mode balance-rr
> +	then
> +		echo "Failed to create bond TX interface. Is CONFIG_BONDING set?" >&2
> +		# only clean nsim ifaces and namespace. Nothing else has been
> +		# initialized
> +		cleanup_bond_nsim
> +		trap - EXIT
> +		exit "${ksft_skip}"
> +	fi
> +	ip link set "${BOND_TX1_IF}" down
> +	ip link set "${BOND_TX2_IF}" down
> +
> +	ip link set "${BOND_TX1_IF}" master "${BONDTX_IF}"
> +	ip link set "${BOND_TX2_IF}" master "${BONDTX_IF}"
> +	ip link set "${BONDTX_IF}" up
> +
> +	# now create the RX bonding iface
> +	ip netns exec "${NAMESPACE}" \
> +		ip link add "${BONDRX_IF}" type bond mode balance-rr
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX1_IF}" down
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX2_IF}" down
> +
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX1_IF}" master "${BONDRX_IF}"
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX2_IF}" master "${BONDRX_IF}"
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BONDRX_IF}" up
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX1_IF}" up
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX2_IF}" up
> +
> +}
> +
> +# Clean up netdevsim ifaces created for bonding test
> +function cleanup_bond_nsim() {
> +	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_DEL"
> +	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_DEL"
> +	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_DEL"
> +	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_DEL"
> +	cleanup_all_ns
> +}
> +
> +# cleanup tests that use bonding interfaces
> +function cleanup_bond() {
> +	cleanup_netcons
> +
> +	# Delete TX ifaces
> +	ip link set "${BONDTX_IF}" down  2> /dev/null|| true
> +	ip link set "${BOND_TX1_IF}" down || true
> +	ip link set "${BOND_TX2_IF}" down || true
> +	ip link delete "${BONDTX_IF}" type bond  2> /dev/null || true
> +
> +	# Delete RX ifaces
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BONDRX_IF}" down || true
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX1_IF}" down || true
> +	ip netns exec "${NAMESPACE}" \
> +		ip link set "${BOND_RX2_IF}" down || true
> +	ip netns exec "${NAMESPACE}" \
> +		ip link delete "${BONDRX_IF}" type bond  || true
> +
> +	cleanup_bond_nsim
> +}
> 
> 



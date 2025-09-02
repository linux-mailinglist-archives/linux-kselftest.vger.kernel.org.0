Return-Path: <linux-kselftest+bounces-40519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C8FB3F6AB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA421A87709
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 07:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140682E7160;
	Tue,  2 Sep 2025 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCKOo7PY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2F2E6CB3;
	Tue,  2 Sep 2025 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798022; cv=none; b=geay9yCwHban7fZs8tzeco3jeE4iZ+9mpPx0//+l3gldKjB+rMrSatNb35RJXH1/LEEUEDLIXb3c+46X6p+2xS0FhrdoZvrTko88qtF63Rj9wGqDKGegZBQCmXMIYYhmSr+Z8FxFYB3BbtzZ6nkKy2LFopVxko9YIqNydBLJOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798022; c=relaxed/simple;
	bh=C0+A7LB0c+Kg1/5x9L5CjpFdJGitY1fMjfm3yvYnIgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V684MWSOaix7iTGZpKXaESCjqlV0CuBWSLKEe93/ukhYFdtyRFAv5h26QsTxn+CmtAwNj6YFYtM6XCmM9iqe88sXwoqXibRW9YV5G6wVjUFswBLKxx81NAfqm2Yw0gcCl4inRzsMzE3CwWIrQFGttJUngMSp4wEK6k5Da6lvPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCKOo7PY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323266cdf64so4095964a91.0;
        Tue, 02 Sep 2025 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756798019; x=1757402819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g74np6MvU0aLFhCl/WRP7lVvXWDBNDZlydNszztjOfA=;
        b=lCKOo7PYmko39edOkAJhjxyS8sL8IcTHt6U9mk8Rd1zx1JLMeOPC8gXhsH+WP8DE6O
         FYjQ1op3pt+g4ujuiCa0XuZwLOfqCdM+JWi6Oa2bqrp5ngphDk2kOBsgshwkGl+wuV2j
         TdmlwsQ0Jqi5cr7/DxAdWNkYEqWex+GTt/2Y+KqfAgqJkLinBK6QOM/Yuv1NXNTrQ5vT
         Ii7msWLtglMIPtmK8mhp1+RxVEgpRoLATQaxwPHWDJD3qtw4GaxaaGgAfh4iG1O4/G0/
         esIRpiaF7CN1pxywsIgmwKVKVCYD+6dWgNZVW45lwtpek3DquK+PK+I29peBFc8HWsrV
         fRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756798019; x=1757402819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g74np6MvU0aLFhCl/WRP7lVvXWDBNDZlydNszztjOfA=;
        b=v34FJ4CZKISgnC2Q+qlpF43P8Aht/Dr+klc58fVAB/qV1SNu6AD+EMYdWZzrELdAyF
         NTeKaNHmZt9ZAP7mefsr8lxozq1bi4SCgdGEpocc+ZTmIyrBsYz5pfa8Uzb6d3hkS7sV
         vYWL2LPYJQyx5pQ+GPpjs5yQsyl9srOhSfeMRLs//SyvrmNJgEKvhYpCcuIWyO/99Dpr
         qO7bUexTjOQg0RlNdHakydZnrIiDfBWq2KtkSN/bhdX+vxayNY7Q6dJLm8R4ptK29eG9
         pE6AApkiP/xsotmD6dY9Gxvw2sadcP+JrZXK/evCL+jv7doGwPfFq3WLZ9++Tp4o25uz
         p/lw==
X-Forwarded-Encrypted: i=1; AJvYcCWtXjlE8KgZ+Jj1o9y3fjbb4+Nfk8G0vWsLdMfYxtaT06wlQmgxaQqljBw3jiKY5KGBGJubSinP5nBbxjW0ie8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw71yF4wVNLkPRFFpQ5aqI/os9rLBscMPKiJgveeEwFMxw8ffk4
	11gPB8SlY2As59BfG5cuZoM3XSmIzmDXLww9X4LDefTfj0jSrFGNTrdw44Ftaa30HQs=
X-Gm-Gg: ASbGncvHZNcG5d+zWQqW5YhDdahlmO8moCTZcGjYcaFCb86CKjZzl1hjU787ZHvgxu0
	wmzQTVGK+VbDHh5Q60xJmD7ezjJVMOzilKTVnBiCJqN60B77VUJdA27n+DIkAtjbL3B1kpwRpgl
	SxO8+B4+Keld2CLFKxm9rNhmzk3NudKbVuXI0BCVYrCFR3K8wmzn3uDDlqHC+5vmHCTafO5/RmG
	oe+VCrhH/ZqBJe7aN5YCobnRf2rf48BmKeTwGhA2saXu53XZIFb7gSZUFOubz9WS4ie8C7Pf7GD
	7/foOJ9m2YAsAJG2HhhqRpCT2m8Up57xPqZB2IXOHTggU4w7qSHXmjKNAyvNMnpOY5xPsCk1jNS
	3thno/g9bcQbIk4J7dmRrrBO1sX9GwVghePgMI29Bvg==
X-Google-Smtp-Source: AGHT+IHQKbDjFwvBo0SZu3O86anZ+Hcx1gB6tGsQeRxuBBvbP4rxzoQL0eTxwyNJGlWNz8SL1uNWLA==
X-Received: by 2002:a17:90b:1848:b0:327:531b:b85c with SMTP id 98e67ed59e1d1-328156e38b4mr16195525a91.35.1756798019151;
        Tue, 02 Sep 2025 00:26:59 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d9347189sm13416648a91.9.2025.09.02.00.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:26:58 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 5/5] selftests/net: add offload checking test for virtual interface
Date: Tue,  2 Sep 2025 07:26:02 +0000
Message-ID: <20250902072602.361122-6-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902072602.361122-1-liuhangbin@gmail.com>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make sure the virtual interface offload setting is correct after
changing lower devices.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/Makefile        |   1 +
 tools/testing/selftests/net/config          |   2 +
 tools/testing/selftests/net/vdev_offload.sh | 176 ++++++++++++++++++++
 3 files changed, 179 insertions(+)
 create mode 100755 tools/testing/selftests/net/vdev_offload.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index eef0b8f8a7b0..e195ab4038a0 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -118,6 +118,7 @@ TEST_PROGS += tfo_passive.sh
 TEST_PROGS += broadcast_pmtu.sh
 TEST_PROGS += ipv6_force_forwarding.sh
 TEST_PROGS += route_hint.sh
+TEST_PROGS += vdev_offload.sh
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d548611e2698..0f3a64a86474 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -117,6 +117,7 @@ CONFIG_IP_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
 CONFIG_CRYPTO_ARIA=y
 CONFIG_XFRM_INTERFACE=m
+CONFIG_XFRM_OFFLOAD=y
 CONFIG_XFRM_USER=m
 CONFIG_IP_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_MATCH_RPFILTER=m
@@ -128,3 +129,4 @@ CONFIG_NETKIT=y
 CONFIG_NET_PKTGEN=m
 CONFIG_IPV6_ILA=m
 CONFIG_IPV6_RPL_LWTUNNEL=y
+CONFIG_NET_TEAM=m
diff --git a/tools/testing/selftests/net/vdev_offload.sh b/tools/testing/selftests/net/vdev_offload.sh
new file mode 100755
index 000000000000..78fc212efd4a
--- /dev/null
+++ b/tools/testing/selftests/net/vdev_offload.sh
@@ -0,0 +1,176 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# shellcheck disable=SC1091
+source lib.sh
+
+# Set related offload on lower deivces and check if upper devices re-compute
+# Some features are fixed on veth interface. Just list here in case we have a
+# better way to test in future.
+set_offload()
+{
+	local dev="$1"
+	local state="$2"
+
+	# VLAN features
+	# NETIF_F_FRAGLIST: tx-scatter-gather-fraglist
+	# shellcheck disable=SC2154
+	ip netns exec "$ns" ethtool -K "$dev" tx-scatter-gather-fraglist "$state"
+
+	# ENC features
+	# NETIF_F_RXCSUM: rx-checksum (bond/team/bridge fixed)
+
+	# XFRM features (veth fixed, netdevsim supports)
+	# NETIF_F_HW_ESP: esp-hw-offload
+	# NETIF_F_GSO_ESP: tx-esp-segmentation
+
+	# GSO partial features
+	# NETIF_F_GSO_PARTIAL: tx-gso-partial (veth/bond fixed)
+
+	# Common features
+	# NETIF_F_SG: tx-scatter-gather
+	ip netns exec "$ns" ethtool -K "$dev" tx-scatter-gather "$state" &> /dev/null
+	# NETIF_F_GSO_SOFTWARE: NETIF_F_GSO_ACCECN: tx-tcp-accecn-segmentation
+	ip netns exec "$ns" ethtool -K "$dev" tx-tcp-accecn-segmentation "$state"
+	# NETIF_F_GSO_SOFTWARE: NETIF_F_GSO_SCTP: tx-sctp-segmentation
+	ip netns exec "$ns" ethtool -K "$dev" tx-sctp-segmentation "$state"
+	# NETIF_F_GSO_SOFTWARE: NETIF_F_GSO_FRAGLIST: tx-gso-list
+	ip netns exec "$ns" ethtool -K "$dev" tx-gso-list "$state"
+}
+
+__check_offload()
+{
+	local dev=$1
+	local opt=$2
+	local expect=$3
+
+	ip netns exec "$ns" ethtool --json -k "$dev" | \
+		jq -r -e ".[].\"$opt\".active == ${expect}" >/dev/null
+}
+
+check_offload()
+{
+	local dev=$1
+	local state=$2
+
+	__check_offload "$dev" "tx-scatter-gather-fraglist" "$state" || RET=1
+	__check_offload "$dev" "tx-scatter-gather" "$state" || RET=1
+	__check_offload "$dev" "tx-tcp-accecn-segmentation" "$state" || RET=1
+	__check_offload "$dev" "tx-sctp-segmentation" "$state" || RET=1
+	__check_offload "$dev" "tx-gso-list" "$state" || RET=1
+}
+
+setup_veth()
+{
+	# Set up test netns
+	setup_ns ns switch
+
+	# shellcheck disable=SC2154
+	ip -n "$ns" link add veth0 type veth peer name veth0 netns "$switch"
+	ip -n "$ns" link add veth1 type veth peer name veth1 netns "$switch"
+	ip -n "$switch" link set veth0 up
+	ip -n "$switch" link set veth1 up
+
+	link_0=veth0
+	link_1=veth1
+}
+
+setup_netdevsim()
+{
+	setup_ns ns
+	# The create_netdevsim() function will set the interface up. Later,
+	# when it is added to bonded, we need to set it down first. And when
+	# set down, it will have no carrier. So we need to add netdevsim ourselves.
+	modprobe netdevsim
+	udevadm settle
+	echo "0 2" | ip netns exec "$ns" tee /sys/bus/netdevsim/new_device >/dev/null
+	link_0=$(ip netns exec "$ns" ls /sys/bus/netdevsim/devices/netdevsim0/net | head -n 1)
+	link_1=$(ip netns exec "$ns" ls /sys/bus/netdevsim/devices/netdevsim0/net | tail -n 1)
+}
+
+cleanup()
+{
+	cleanup_netdevsim 0
+	cleanup_all_ns
+}
+
+setup_bond()
+{
+	ip -n "$ns" link set "$link_0" nomaster
+	ip -n "$ns" link set "$link_1" nomaster
+	ip -n "$ns" link add bond0 type bond mode active-backup miimon 100
+	ip -n "$ns" link set "$link_0" master bond0
+	ip -n "$ns" link set "$link_1" master bond0
+	ip -n "$ns" link set bond0 up
+}
+
+setup_team()
+{
+	ip -n "$ns" link set "$link_0" nomaster
+	ip -n "$ns" link set "$link_1" nomaster
+	ip -n "$ns" link add team0 type team
+	ip -n "$ns" link set "$link_0" master team0
+	ip -n "$ns" link set "$link_1" master team0
+	ip -n "$ns" link set team0 up
+}
+
+setup_bridge()
+{
+	ip -n "$ns" link set "$link_0" nomaster
+	ip -n "$ns" link set "$link_1" nomaster
+	ip -n "$ns" link add br0 type bridge
+	ip -n "$ns" link set "$link_0" master br0
+	ip -n "$ns" link set "$link_1" master br0
+	ip -n "$ns" link set br0 up
+}
+
+check_xfrm()
+{
+	local dev=$1
+	local src=192.0.2.1
+	local dst=192.0.2.2
+	local key="0x3132333435363738393031323334353664636261"
+
+	RET=0
+
+	ip -n "$ns" xfrm state flush
+	ip -n "$ns" xfrm state add proto esp src "$src" dst "$dst" spi 9 \
+		mode transport reqid 42 aead "rfc4106(gcm(aes))" "$key" 128 \
+		sel src "$src"/24 dst "$dst"/24 offload dev "$dev" dir out
+
+	# shellcheck disable=SC2034
+	ip -n "$ns" xfrm state list | grep -q "crypto offload parameters: dev $dev dir" || RET=1
+	log_test "$dev" "xfrm offload"
+}
+
+do_test()
+{
+	local dev=$1
+
+	RET=0
+	set_offload veth0 "on"
+	set_offload veth1 "on"
+	check_offload "$dev" "true"
+	log_test "$dev" "enable offload"
+
+	RET=0
+	set_offload veth0 "off"
+	set_offload veth1 "off"
+	check_offload "$dev" "false"
+	log_test "$dev" "disable offload"
+}
+
+trap cleanup EXIT
+setup_veth
+setup_bond
+do_test bond0
+setup_team
+do_test team0
+setup_bridge
+do_test br0
+
+# Check NETIF_F_HW_ESP
+# Only test bond as team and bridge haven't implemented xfrm offload
+setup_netdevsim
+setup_bond
+check_xfrm bond0
-- 
2.50.1



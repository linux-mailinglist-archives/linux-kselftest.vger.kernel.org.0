Return-Path: <linux-kselftest+bounces-40261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA6FB3B7D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 11:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011083645F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2CA3054F6;
	Fri, 29 Aug 2025 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU2bV3qy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4022F14C;
	Fri, 29 Aug 2025 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461321; cv=none; b=Sj1Y80qGOyNhLM7QptmPYZuMWoIMfvijfLChm8g2H/DwGtlR98bwrLFi8HkIhSTAKYzcT0YbLwFKNsNNrIr0jxh7HIpTraEqczIyYyQk2uKiNIzhVBWPY4Y1Eek994Lk2cmTkpJbyIty4o5eiHh8S0NDCJc0/FSASCOQR3sUToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461321; c=relaxed/simple;
	bh=LiVImEpioxdBOP+MyMS2h1ZlaeZCUIfiDXqjrFdT9As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skATq1eh3omEuNOOErop6WNSg+dehgGudRq12WSwKcJe2FA4SgSqHitc3JSM0Zz8Q/mF4wuPtXd0EHp+A1c05qIErDUGaIIZuP+wcP1Ym47SGdmeuY5lhFySgQbuoK9qn12jf/+SFcDiEeXQ/Sj39q5jU2fbN7+hPiI/jmo2Ghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU2bV3qy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-771e987b4e6so1512094b3a.2;
        Fri, 29 Aug 2025 02:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461318; x=1757066118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8STPzJQjMixAmB2XXIlQI79JTr2hM8zL3iYx8fSGol4=;
        b=HU2bV3qy5W3vvWmQ03JnkKrfh5Lx+oCPJnSs+IvP21O8gVCMXRqzd5Tv6NTLJYiCfH
         Hc78r+guG1lWDeNw9DrZzbYB7+cBc2yobigaSQ3yCqB4tPHBaI/ZteZoJSVCkQQMCYjD
         xWXzqoa4IYMVuMI3rEdB2rWntYXDgwbT11AL4T/WGL4q45PYGiA71DPyS7J+LKNGyoe+
         i8u1wGJcBueLMZEdsyKW+yhfTOxWof2liaix++6SeE2QH7eazGS0BdJYCAOOaroq4aWy
         nx/e5W+MmvIGWrgItgN5hXr4rHHXLSVgmb/vTm4wS+yVVufAC9A/GNW/ske+C9U0ztMv
         kCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461318; x=1757066118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8STPzJQjMixAmB2XXIlQI79JTr2hM8zL3iYx8fSGol4=;
        b=jGCn9zjViIJA/iNHji8F1gtiuGhYLDXgKUpKjiZmpbWMUIgUDkQok9i2GOZmSukqiC
         LmSU1Jif/MnkArGJaJM7krRhdawNeNR/ur4JPG3xbQF4cEB4iQjwFOAD9Ex4IwhYWHVQ
         kjfLN9G/31f+de+XEck+Qw8d8R55ZQUHBxW1gKE4ajg7ZjOIXSn4fElucDd5UbPG1dSG
         4KSkeDyj3xdpMJYgrVi1ydhWluEcFH1YrZhmvsrjmxS8/P9P3mVVbcSEz29fIUwD2cPH
         ExuC7Fvni3D2zJ+L1gEKsMhGzxeFpoSbzBlyxOXIaJVlASY7W0MY4TznGXDFWMihJ0fU
         TSVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVJBhHuzimRPMsRWut0SqW1CxkIsQCk0l+H4Mz6mqZHtWQFUFyk1OcsEn1HYWM8QJxCIOVUBwayjY1ru7ARZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYX7bFoYjG3HRE5yeekelku9JTXOUfD7Ixae+TI8okxCJGhai/
	1p8bdJoH2R+Pdw03tkc6MHvuyyODRBDDXZ0fp3+t9FiUuBNH6rzHkfGh/yTYL44bnAQ=
X-Gm-Gg: ASbGncueN9CaXGDwAQS0yUMXt49BIjmXeUTzVdnCwK0JObVuRCs3sb3Q8XXdmyjYjgZ
	D7ksX+pNNKFBnh0gE94vcb/Gk1wyVTwlmkPEwaGXWoXOqmMr5O3kCMZZHDF1HrUI1Y2uHbxdxdx
	cZiTXELKQC9Ys1bP5qkujJb/WbK3x/izpCBdsQLh3tXpzYm3/u1iDMrlllYk2PH5Kuj1IaDEMzR
	8/2iHJNGfQGYFFSDZ0dzgkj9UNUroqWNa0Mgc6VNwXFfC69IiQPJY+RMfWdWb5wC6kAAwvWbSDp
	CIOzYNOGycICV8L3OE24kc6YfkDZwPnLa2oUsN+jdPk+LDmoqU1eGLfPU25Uftvs5skm6hvmpO5
	rUUXcwHKcm6CzJhRB8JCt2rp7H34C/tafEJjpDFzPnvRImLJ9t7ig
X-Google-Smtp-Source: AGHT+IFNGbZv0dQtzZb4zPMaDyhTkHdTuimS5iq4evW7KFiZQS+mSzCJskXqDa9/OvWftLmGF5R9Wg==
X-Received: by 2002:a05:6a20:4320:b0:240:11b3:bf25 with SMTP id adf61e73a8af0-24340b7ab93mr39909075637.3.1756461317925;
        Fri, 29 Aug 2025 02:55:17 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd347db1fsm1751528a12.47.2025.08.29.02.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:55:17 -0700 (PDT)
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
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 5/5] selftests/net: add offload checking test for virtual interface
Date: Fri, 29 Aug 2025 09:54:30 +0000
Message-ID: <20250829095430.443891-6-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829095430.443891-1-liuhangbin@gmail.com>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
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
 tools/testing/selftests/net/config          |   2 +
 tools/testing/selftests/net/vdev_offload.sh | 174 ++++++++++++++++++++
 2 files changed, 176 insertions(+)
 create mode 100755 tools/testing/selftests/net/vdev_offload.sh

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
index 000000000000..4926774aef19
--- /dev/null
+++ b/tools/testing/selftests/net/vdev_offload.sh
@@ -0,0 +1,174 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# shellcheck disable=SC1091
+source lib.sh
+
+# Set related offload on lower deivces and check if upper devices re-compute
+# Some fatures are fixed on veth interface. Just list here in case we have a
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
+	RET=0
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
+	set_offload veth0 "on"
+	set_offload veth1 "on"
+	check_offload "$dev" "true"
+	log_test "$dev" "enable offload"
+
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



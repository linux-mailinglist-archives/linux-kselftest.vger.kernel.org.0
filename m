Return-Path: <linux-kselftest+bounces-38958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C33B2631F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970878813E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 10:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C72F6595;
	Thu, 14 Aug 2025 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDnSOUDK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269A2F39A0;
	Thu, 14 Aug 2025 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168220; cv=none; b=aPN/lxYd6LMzLJIGcpvxuZPGeHG9RtMcNduAiVE6YALc72SEpsLYuzzDCwXDaE+dA78YMXWc5C42kRV9xUSIIdaVB+sWrLeQiDn1AyVYP52SF11FoJCCj6jq7i3mSLfW0G4YOJ/VVJYNbYLwtZfPHXnwwhVL5fLXU7kJTfWhsbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168220; c=relaxed/simple;
	bh=5wFtptAzb0QxOTSr7WB/B4kE3J0ku58yDKa0ruwcdM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlKC/1w7ddyKM1SMesCEgxp/VgQmq7ySHMMrXkejc1JBMxTY96u1F2nny3UGEHa2v8kwRmRLmUBXcjmxbHB4T4qUBj7L3V9MD6GVxZegCgvypciiCrka6reeJEfx/6YYn1TOarMlaPkB3d0CEhGf/UVVlJX4nQx5VQA1n0WNthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDnSOUDK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445811e19dso6350445ad.1;
        Thu, 14 Aug 2025 03:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755168217; x=1755773017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B25ldxllVHCgSRa4FLisx2TxieDXK0+WNFRO1OHWtXE=;
        b=bDnSOUDKcd3W57DkyscpH0OoAoi3fK13L39wQbbubGKGz2ueoVVHAnlGH6N0qWEriJ
         0xNIlnDLLEkBHI1htM3z9JHAOWBeR1vOTHyQKHPCHs0vcLhO1K9ifmaKdbUGW7gFWx3M
         LQEXVdFyfTgsPQk6w1EYlw7Jq07JuIsjhdaCVF4LBkopSvTiBFh9za7sYv1HnUSWYkpd
         96obd4a1gtlySU5KFMaK6qfamepi7LG+inoQDIrG6c4fVbTlJNBDrULcduTiiV8x8K7a
         VcZGjrqV4Gba96qSp0GtjKfOOqQKw7EnB68tgglP6nbCDO0ITTrcFimA7DFOpBszHVb8
         aR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168217; x=1755773017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B25ldxllVHCgSRa4FLisx2TxieDXK0+WNFRO1OHWtXE=;
        b=Q9UTxZmJpcU8H8z6QdvXMfTo5zxuv1ZzgxcwgV788JTdVGF0pWUhmJ7yVDckfi7sj6
         xKjWtPTriHrzVTFN1DIXP75B4sbav1C5aFeVuiw8DoJAHH1kkhH+/Cl47Xn4j/haW8HB
         X9Rb/d4I8OZD7FCo2ClUKT0OxThhytfQR7OxnLiKVfVGJ+vLTZ9UW6nqbTmgtn96/8yJ
         B91XadOSCmWMy8yxB1MtICv6y+k/d9S8XRtLcx5iAlbL3iRLe1Uu0jetZBhkGfC3d3zO
         cBzyvc/l7IYiWomgQUlRjvQRxpyC2CjtwGzyUIjLaw5L2cshsyitNUbQDz1PO97J2iom
         r7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWlAz64Vn2yfnTUFAYCMILqr+6LEwnYfJNnjWZISYm1Fqi5RdC1njipHOAFjhLd3zFUBvLoeF81HSk=@vger.kernel.org, AJvYcCXyoiLyXdiJ3aOM0tJn8IQDxtABjm9ymQ95ytZ32+7PkQ8NwTGuBm8aJ7urLEcBbNnt13+ra9IGpEBVM+W0K4ct@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvILWOWomvv6loFiiK1OAcuj6XXOAAyRptXEAogqN9Vcyz3Mo
	c+20xF6cE1491hmahQyYZAJIyqoHfzAJc24xbpLbE4Z51s1meTjWnH6SEePc7vmS
X-Gm-Gg: ASbGnctrLPtf+hf0lZsTNfoKKe5nWeWSImsGPoo+ENwCOvsv1OMrQG/u93XboJE7/su
	53Dy+QQRNkqVzpzWuCE3c60SNhkgfe8YFcgkh//LNFAT28dNi+uUPeN5WOkf1yu9i0xGgDb31r/
	iRG49y9Vsvg5OZP1bvkc9zuSZQWs2KH/NX24HLBR1KDWfXj6297uuDS+qPi+w0sJE/jN0IyknSq
	V/Zj1Z4Kh/MERR0X9RUa+WeGNI7UH5V7Vi6oVoP6nmS1JRwjzhrdxbaYr7aWbN140aJZs3yI84L
	m0ysXFnCAhO1ORQv/0nw06UmwqKaC9aIjl2v1hLSQhJoSBlgDWfbhgF68H88vp8a/2HGBmB9hg1
	0C0LtOPZQBS+bFkGt7dOF/mjSaq586MW/di9g0Qv7XQ==
X-Google-Smtp-Source: AGHT+IGtSGVU9WsGH5Xy5tHLACafyED8VP5hN2gGKW8jWQVBXRD7idDre7i5Yzu5OY/4YVmicmPyRQ==
X-Received: by 2002:a17:903:1aac:b0:240:3e40:43b8 with SMTP id d9443c01a7336-244586ecf3emr34547575ad.53.1755168217112;
        Thu, 14 Aug 2025 03:43:37 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a1csm351796225ad.78.2025.08.14.03.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:43:36 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 3/3] selftests: bonding: add test for LACP actor port priority
Date: Thu, 14 Aug 2025 10:42:56 +0000
Message-ID: <20250814104256.18372-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814104256.18372-1-liuhangbin@gmail.com>
References: <20250814104256.18372-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comprehensive selftest to verify:
- Per-port actor priority setting via ad_actor_port_prio
- Aggregator selection behavior with port_priority ad_select policy

Also move cmd_jq helper from forwarding/lib.sh to net/lib.sh for
broader reusability across network selftests.

Here is the result output
  # ./bond_lacp_prio.sh
  TEST: bond 802.3ad (ad_actor_port_prio setting)                     [ OK ]
  TEST: bond 802.3ad (ad_actor_port_prio select)                      [ OK ]
  TEST: bond 802.3ad (ad_actor_port_prio switch)                      [ OK ]

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/drivers/net/bonding/Makefile    |  3 +-
 .../drivers/net/bonding/bond_lacp_prio.sh     | 93 +++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh | 24 -----
 tools/testing/selftests/net/lib.sh            | 24 +++++
 4 files changed, 119 insertions(+), 25 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 2b10854e4b1e..32617a834a6b 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -10,7 +10,8 @@ TEST_PROGS := \
 	mode-2-recovery-updelay.sh \
 	bond_options.sh \
 	bond-eth-type-change.sh \
-	bond_macvlan_ipvlan.sh
+	bond_macvlan_ipvlan.sh \
+	bond_lacp_prio.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
new file mode 100755
index 000000000000..c278e5ec76e0
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
@@ -0,0 +1,93 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Testing if bond lacp per port priority works
+#
+#          Switch (s_ns)          Backup Switch (b_ns)
+#  +-------------------------+ +-------------------------+
+#  |          bond0          | |          bond0          |
+#  |            +            | |            +            |
+#  |      eth0  |  eth1      | |      eth0  |  eth1      |
+#  |        +---+---+        | |        +---+---+        |
+#  |        |       |        | |        |       |        |
+#  +-------------------------+ +-------------------------+
+#           |       |                   |       |
+#  +-----------------------------------------------------+
+#  |        |       |                   |       |        |
+#  |        +-------+---------+---------+-------+        |
+#  |      eth0     eth1       |       eth2     eth3      |
+#  |                          +                          |
+#  |                        bond0                        |
+#  +-----------------------------------------------------+
+#                        Client (c_ns)
+
+lib_dir=$(dirname "$0")
+# shellcheck disable=SC1091
+source "$lib_dir"/../../../net/lib.sh
+RET=0
+
+trap cleanup_all_ns EXIT
+# create client, switch, backup switch netns
+setup_ns c_ns s_ns b_ns
+
+# setup links
+# shellcheck disable=SC2154
+ip -n "${c_ns}" link add eth0 type veth peer name eth0 netns "${s_ns}"
+ip -n "${c_ns}" link add eth1 type veth peer name eth1 netns "${s_ns}"
+# shellcheck disable=SC2154
+ip -n "${c_ns}" link add eth2 type veth peer name eth0 netns "${b_ns}"
+ip -n "${c_ns}" link add eth3 type veth peer name eth1 netns "${b_ns}"
+
+ip -n "${c_ns}" link add bond0 type bond mode 802.3ad miimon 100 lacp_rate fast ad_select prio
+ip -n "${s_ns}" link add bond0 type bond mode 802.3ad miimon 100 lacp_rate fast
+ip -n "${b_ns}" link add bond0 type bond mode 802.3ad miimon 100 lacp_rate fast
+
+ip -n "${c_ns}" link set eth0 master bond0
+ip -n "${c_ns}" link set eth1 master bond0
+ip -n "${c_ns}" link set eth2 master bond0
+ip -n "${c_ns}" link set eth3 master bond0
+ip -n "${s_ns}" link set eth0 master bond0
+ip -n "${s_ns}" link set eth1 master bond0
+ip -n "${b_ns}" link set eth0 master bond0
+ip -n "${b_ns}" link set eth1 master bond0
+
+ip -n "${c_ns}" link set bond0 up
+ip -n "${s_ns}" link set bond0 up
+ip -n "${b_ns}" link set bond0 up
+
+# set ad actor port priority, default 255
+ip -n "${c_ns}" link set eth0 type bond_slave ad_actor_port_prio 1000
+prio=$(cmd_jq "ip -n ${c_ns} -d -j link show eth0" ".[].linkinfo.info_slave_data.ad_actor_port_prio")
+[ "$prio" -ne 1000 ] && RET=1
+ip -n "${c_ns}" link set eth2 type bond_slave ad_actor_port_prio 10
+prio=$(cmd_jq "ip -n ${c_ns} -d -j link show eth2" ".[].linkinfo.info_slave_data.ad_actor_port_prio")
+[ "$prio" -ne 10 ] && RET=1
+log_test "bond 802.3ad" "ad_actor_port_prio setting"
+
+# Trigger link state change to reselect the aggregator
+ip -n "${c_ns}" link set eth1 down
+sleep 1
+ip -n "${c_ns}" link set eth1 up
+# the active agg should be connect to switch
+bond_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show bond0" ".[].linkinfo.info_data.ad_info.aggregator")
+eth0_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show eth0" ".[].linkinfo.info_slave_data.ad_aggregator_id")
+[ "${bond_agg_id}" -ne "${eth0_agg_id}" ] && RET=1
+log_test "bond 802.3ad" "ad_actor_port_prio select"
+
+# Change the actor port prio and re-test
+ip -n "${c_ns}" link set eth0 type bond_slave ad_actor_port_prio 10
+ip -n "${c_ns}" link set eth2 type bond_slave ad_actor_port_prio 1000
+# Trigger link state change to reselect the aggregator
+ip -n "${c_ns}" link set eth1 down
+sleep 1
+ip -n "${c_ns}" link set eth1 up
+# now the active agg should be connect to backup switch
+bond_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show bond0" ".[].linkinfo.info_data.ad_info.aggregator")
+eth2_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show eth2" ".[].linkinfo.info_slave_data.ad_aggregator_id")
+# shellcheck disable=SC2034
+if [ "${bond_agg_id}" -ne "${eth2_agg_id}" ]; then
+	RET=1
+fi
+log_test "bond 802.3ad" "ad_actor_port_prio switch"
+
+exit "${EXIT_STATUS}"
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 890b3374dacd..08121cb9dc26 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -571,30 +571,6 @@ wait_for_dev()
         fi
 }
 
-cmd_jq()
-{
-	local cmd=$1
-	local jq_exp=$2
-	local jq_opts=$3
-	local ret
-	local output
-
-	output="$($cmd)"
-	# it the command fails, return error right away
-	ret=$?
-	if [[ $ret -ne 0 ]]; then
-		return $ret
-	fi
-	output=$(echo $output | jq -r $jq_opts "$jq_exp")
-	ret=$?
-	if [[ $ret -ne 0 ]]; then
-		return $ret
-	fi
-	echo $output
-	# return success only in case of non-empty output
-	[ ! -z "$output" ]
-}
-
 pre_cleanup()
 {
 	if [ "${PAUSE_ON_CLEANUP}" = "yes" ]; then
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index c7add0dc4c60..4dca6893aa8a 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -645,3 +645,27 @@ wait_local_port_listen()
 		sleep 0.1
 	done
 }
+
+cmd_jq()
+{
+	local cmd=$1
+	local jq_exp=$2
+	local jq_opts=$3
+	local ret
+	local output
+
+	output="$($cmd)"
+	# it the command fails, return error right away
+	ret=$?
+	if [[ $ret -ne 0 ]]; then
+		return $ret
+	fi
+	output=$(echo $output | jq -r $jq_opts "$jq_exp")
+	ret=$?
+	if [[ $ret -ne 0 ]]; then
+		return $ret
+	fi
+	echo $output
+	# return success only in case of non-empty output
+	[ ! -z "$output" ]
+}
-- 
2.50.1



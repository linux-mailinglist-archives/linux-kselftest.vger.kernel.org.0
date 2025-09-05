Return-Path: <linux-kselftest+bounces-40862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 260AEB46068
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 19:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D035C7126
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8B435207E;
	Fri,  5 Sep 2025 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTC90A0Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE129345743;
	Fri,  5 Sep 2025 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094057; cv=none; b=niWJC1pRy5ou+NAz5XMf6Bouhqm3uoHUfuwlHw2WPSKjCQMWezqTHuNOC+WZ8svIIjzW3df8QXHgii1cZDtb/EipnFi4OxSAvnyxS4/JAhSmOV82A7Jnw0gBlMM3ZjTztaQu26hUEuhST4QW33o8cS88UngapbKpxH97WoROT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094057; c=relaxed/simple;
	bh=KoUzJbRgCJmS3mHnAyHxK3ZS2Z1jVxj4NIGDQftHCW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vo8CPecNW6qXDDBm+rTzO3EPsGvP5ixsNu61P6JTnIk32o70H2oexWLthn4/gSYJa+rwbz70XQ4EgD8n9QbmmIVDYb3PhUD2rjvbA4StPhAWRNldl/MNj77IERq9C4YL7QE54+B5Oh34dBkP+SuOZf1PYLw8JrLTV9G/VTB0z6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTC90A0Y; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b520c9c291dso745215a12.1;
        Fri, 05 Sep 2025 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757094051; x=1757698851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6kLU4UMoSNun6uHrd+mJbeeTuQSeyozz8q61hEU9L0=;
        b=fTC90A0Yi3NO763xIRU7Hifc6fhRv2+EZTGuCt04zv7rZaUXqqN8+rb3qj66OEywJz
         o8pxQmBL4MQadQNVlyFnus2hXHTWRyFRe++IfJxVBzqPFsGxZWtk4QLzxWLClfcIL/oN
         w27FwZLGhjOaaktQ/Ky4jhw0c0Ybui6+etsyouCMKp7LDAm1u3sr0HVczgkxgMri+bWb
         iuZLss1z634gfKpzQ6WthILCBNr4IwESz8cWhbZtMDRYHHLKS2V2GdX3ySZ9KVb48ZAF
         7uZya5ieD6/yne+6lMIpqpaz9Mpur+/sZBlfBJYExbbTJP19UolwnJxvHbOHbRt0JeI5
         dgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757094051; x=1757698851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6kLU4UMoSNun6uHrd+mJbeeTuQSeyozz8q61hEU9L0=;
        b=rY7Bj8zE1R+CYi1Clcq+LpaOESNFyaYHbG0E2v8Gc5kWHhEm3zIUqvqnnILThRGyvq
         3lJVjw6DsEuKMrgKruw+azJAiVpErMQ9PXddOHiROrmKLAAGkhNZ1KsQuiYHyTdTLqkP
         HRS+6mHzHMcy4YZf0iQS2LrFxRgqFWgyybiYFJzKX8pEo6c87nkkvtHMyzzOAeUPG+Mh
         aJfFkV4MjWcLSMyIPA59SuU2NaL2R77BP4qTr0Gwb8Slf1VGXWZsMTIZE/PMfPqad2uE
         SbAX3O6AD6XO9P2n4tBZX3p3pFXgAT1EtQBnqRCgmcsFw0zoIFUvgxrWLVs9DV2CAPQu
         O4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5FLxqeJc3+q6LhQT6ibjl0P8bGLGcfF0BKBllNQSoTRnodAOhjdIn9OXPEHz72LEeJ38qpLjtE0iTyYEVDYLw@vger.kernel.org, AJvYcCWW2JX4JSe3AxGG9WSdU92qlAoEXsLuMnYgAuYRXI5iLMHpHQG8xh16Xwz7/kgRHpWWXE4bDSLKHxDh0ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0REYX9vtX8bDf08B6gga8mhc479mFbyd2yLGQW4e9prnB+bt
	7qD89tZRhyAoPX+kc4rH4LVrOt2i1WI2jJlZJTsjp5Z1upknykgoJzyzIQ31qv+QJVA=
X-Gm-Gg: ASbGnctv10dpoH/GisLmLyCbUSLh+gahk5SG1bzoj2W4RN+t98HnKpzX7TMmzgGxeQt
	9NvPhvwdSxuNxckevVBbquIatKcbMRYvw+9udrO3bwyD9Im/r/+iS+yYqgg4Zp69btU/SNjSRps
	C/9o8XlJnbM3y4igivoWvkLFB4oqYwotE7k+DlAnGzw/IDYKkkxTA84KUtxvzizc1G3T87LtV7h
	C6qaHNaJRwANOpA/WVolBk2Yh9gdwvyyzUy4GW1AkDn6ecNmWIAC3tgwwcSAsBwM0Ec5qhCh2m4
	k/rZ4uXbatlC0T7VjvuUzAf6MZSq4eTIoTsV/hOAbt/SpSatya3e87vEW0dSwgKq4Z3pYbFKtRE
	QaawTJIWCMXOrfF6Cyvbe+IxKG24ZkE0MbLNrXayq
X-Google-Smtp-Source: AGHT+IF204a69Hgio58Ua9VDzAAGXYfu5xxbwpP0vlJvGVbvjpZDgZOCV4/SJ2vv5/toU4hAr+kRYg==
X-Received: by 2002:a17:903:41d0:b0:23f:e869:9a25 with SMTP id d9443c01a7336-24944acf3b2mr289505045ad.44.1757094047568;
        Fri, 05 Sep 2025 10:40:47 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490370298dsm220732515ad.4.2025.09.05.10.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:40:46 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Petr Machata <petrm@nvidia.com>,
	Andy Roulin <aroulin@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	Li Shuang <shuali@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] selftests: forwarding: Reorder arguments to obey POSIX getopt
Date: Sat,  6 Sep 2025 01:39:41 +0800
Message-ID: <20250905173947.3164807-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Quoted from musl wiki:

  GNU getopt permutes argv to pull options to the front, ahead of
  non-option arguments. musl and the POSIX standard getopt stop
  processing options at the first non-option argument with no
  permutation.

Thus these scripts stop working on musl since non-option arguments do
not always come last. Fix it by reordering arguments.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../selftests/net/forwarding/bridge_igmp.sh   |  26 ++---
 .../net/forwarding/bridge_locked_port.sh      |  10 +-
 .../selftests/net/forwarding/bridge_mdb.sh    |  54 ++++-----
 .../net/forwarding/bridge_mdb_max.sh          |  16 +--
 .../selftests/net/forwarding/bridge_mld.sh    |  26 ++---
 .../net/forwarding/bridge_sticky_fdb.sh       |   2 +-
 .../net/forwarding/bridge_vlan_aware.sh       |   8 +-
 .../net/forwarding/custom_multipath_hash.sh   |  34 +++---
 .../forwarding/gre_custom_multipath_hash.sh   |  34 +++---
 .../net/forwarding/gre_inner_v4_multipath.sh  |   4 +-
 .../net/forwarding/gre_inner_v6_multipath.sh  |   4 +-
 .../selftests/net/forwarding/gre_multipath.sh |   4 +-
 .../net/forwarding/gre_multipath_nh.sh        |   8 +-
 .../net/forwarding/gre_multipath_nh_res.sh    |   8 +-
 .../net/forwarding/ip6_forward_instats_vrf.sh |   6 +-
 .../ip6gre_custom_multipath_hash.sh           |  26 ++---
 .../forwarding/ip6gre_inner_v4_multipath.sh   |   4 +-
 .../forwarding/ip6gre_inner_v6_multipath.sh   |   4 +-
 .../selftests/net/forwarding/ip6gre_lib.sh    |   8 +-
 tools/testing/selftests/net/forwarding/lib.sh |  24 ++--
 .../forwarding/mirror_gre_bridge_1q_lag.sh    |   2 +-
 .../forwarding/mirror_gre_vlan_bridge_1q.sh   |   4 +-
 .../selftests/net/forwarding/mirror_lib.sh    |   4 +-
 .../selftests/net/forwarding/pedit_dsfield.sh |   4 +-
 .../selftests/net/forwarding/pedit_ip.sh      |   2 +-
 .../selftests/net/forwarding/pedit_l4port.sh  |   4 +-
 .../selftests/net/forwarding/router.sh        |  18 +--
 .../net/forwarding/router_broadcast.sh        |   2 +-
 .../net/forwarding/router_mpath_nh.sh         |   8 +-
 .../net/forwarding/router_mpath_nh_lib.sh     |   4 +-
 .../net/forwarding/router_mpath_nh_res.sh     |   8 +-
 .../net/forwarding/router_mpath_seed.sh       |  16 +--
 .../net/forwarding/router_multicast.sh        |  48 ++++----
 .../net/forwarding/router_multipath.sh        |   8 +-
 .../selftests/net/forwarding/sch_red.sh       |  22 ++--
 .../net/forwarding/skbedit_priority.sh        |   4 +-
 .../selftests/net/forwarding/tc_actions.sh    |  40 +++----
 .../selftests/net/forwarding/tc_chains.sh     |   8 +-
 .../selftests/net/forwarding/tc_flower.sh     | 108 +++++++++---------
 .../selftests/net/forwarding/tc_flower_cfm.sh |  22 ++--
 .../net/forwarding/tc_flower_l2_miss.sh       |  16 +--
 .../net/forwarding/tc_flower_port_range.sh    |  52 ++++-----
 .../net/forwarding/tc_flower_router.sh        |   8 +-
 .../selftests/net/forwarding/tc_shblocks.sh   |  16 +--
 .../selftests/net/forwarding/tc_tunnel_key.sh |   6 +-
 .../net/forwarding/vxlan_bridge_1d.sh         |  24 ++--
 .../net/forwarding/vxlan_bridge_1d_ipv6.sh    |   6 +-
 .../net/forwarding/vxlan_bridge_1q.sh         |  18 +--
 .../net/forwarding/vxlan_bridge_1q_ipv6.sh    |   2 +-
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh   |   8 +-
 .../net/forwarding/vxlan_reserved.sh          |   4 +-
 51 files changed, 403 insertions(+), 403 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index d4e7dd659354..605d8f6a7468 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -158,7 +158,7 @@ v3include_prepare()
 	ip link set dev br0 type bridge mcast_igmp_version 3
 	check_err $? "Could not change bridge IGMP version to 3"
 
-	$MZ $host1_if -b $mac -c 1 -B $group -t ip "proto=2,p=$MZPKT_IS_INC" -q
+	$MZ -b $mac -c 1 -B $group -t ip "proto=2,p=$MZPKT_IS_INC" -q $host1_if
 	sleep 1
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
@@ -183,7 +183,7 @@ v3exclude_prepare()
 
 	v3include_prepare $host1_if $mac $group
 
-	$MZ $host1_if -c 1 -b $mac -B $group -t ip "proto=2,p=$MZPKT_IS_EXC" -q
+	$MZ -c 1 -b $mac -B $group -t ip "proto=2,p=$MZPKT_IS_EXC" -q $host1_if
 	sleep 1
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
@@ -237,7 +237,7 @@ v3inc_allow_test()
 
 	v3include_prepare $h1 $ALL_MAC $ALL_GROUP
 
-	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW" -q
+	$MZ -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW" -q $h1
 	sleep 1
 	brmcast_check_sg_entries "allow" "${X[@]}"
 
@@ -258,7 +258,7 @@ v3inc_is_include_test()
 
 	v3include_prepare $h1 $ALL_MAC $ALL_GROUP
 
-	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_IS_INC2" -q
+	$MZ -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_IS_INC2" -q $h1
 	sleep 1
 	brmcast_check_sg_entries "is_include" "${X[@]}"
 
@@ -297,7 +297,7 @@ v3inc_to_exclude_test()
 	ip link set dev br0 type bridge mcast_last_member_interval 500
 	check_err $? "Could not change mcast_last_member_interval to 5s"
 
-	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_TO_EXC" -q
+	$MZ -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_TO_EXC" -q $h1
 	sleep 1
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
@@ -341,7 +341,7 @@ v3exc_allow_test()
 
 	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
 
-	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
+	$MZ -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q $h1
 	sleep 1
 	brmcast_check_sg_entries "allow" "${X[@]}" "${Y[@]}"
 
@@ -364,7 +364,7 @@ v3exc_is_include_test()
 
 	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
 
-	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_IS_INC3" -q
+	$MZ -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_IS_INC3" -q $h1
 	sleep 1
 	brmcast_check_sg_entries "is_include" "${X[@]}" "${Y[@]}"
 
@@ -387,7 +387,7 @@ v3exc_is_exclude_test()
 
 	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
 
-	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_IS_EXC2" -q
+	$MZ -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_IS_EXC2" -q $h1
 	sleep 1
 	brmcast_check_sg_entries "is_exclude" "${X[@]}" "${Y[@]}"
 
@@ -413,7 +413,7 @@ v3exc_to_exclude_test()
 	ip link set dev br0 type bridge mcast_last_member_interval 500
 	check_err $? "Could not change mcast_last_member_interval to 5s"
 
-	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_TO_EXC" -q
+	$MZ -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_TO_EXC" -q $h1
 	sleep 1
 	brmcast_check_sg_entries "to_exclude" "${X[@]}" "${Y[@]}"
 
@@ -437,7 +437,7 @@ v3inc_block_test()
 
 	v3include_prepare $h1 $ALL_MAC $ALL_GROUP
 
-	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_BLOCK" -q
+	$MZ -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_BLOCK" -q $h1
 	# make sure the lowered timers have expired (by default 2 seconds)
 	sleep 3
 	brmcast_check_sg_entries "block" "${X[@]}"
@@ -470,7 +470,7 @@ v3exc_block_test()
 	ip link set dev br0 type bridge mcast_last_member_interval 500
 	check_err $? "Could not change mcast_last_member_interval to 5s"
 
-	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_BLOCK" -q
+	$MZ -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_BLOCK" -q $h1
 	sleep 1
 	brmcast_check_sg_entries "block" "${X[@]}" "${Y[@]}"
 
@@ -502,7 +502,7 @@ v3exc_timeout_test()
 					mcast_query_response_interval 500 \
 					mcast_membership_interval 1500
 
-	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
+	$MZ -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q $h1
 	sleep 5
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
@@ -545,7 +545,7 @@ v3star_ex_auto_add_test()
 
 	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
 
-	$MZ $h2 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_IS_INC" -q
+	$MZ -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_IS_INC" -q $h2
 	sleep 1
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
index c62331b2e006..93d2261be6e3 100755
--- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
@@ -225,18 +225,18 @@ locked_port_mab_roam()
 
 	bridge link set dev $swp1 learning on locked on mab on
 
-	$MZ $h1 -q -c 5 -d 100msec -t udp -a $mac -b rand
+	$MZ -q -c 5 -d 100msec -t udp -a $mac -b rand $h1
 	bridge fdb get $mac br br0 vlan 1 | grep "dev $swp1" | grep -q "locked"
 	check_err $? "No locked entry on first injection"
 
-	$MZ $h2 -q -c 5 -d 100msec -t udp -a $mac -b rand
+	$MZ -q -c 5 -d 100msec -t udp -a $mac -b rand $h2
 	bridge fdb get $mac br br0 vlan 1 | grep -q "dev $swp2"
 	check_err $? "Entry did not roam to an unlocked port"
 
 	bridge fdb get $mac br br0 vlan 1 | grep -q "locked"
 	check_fail $? "Entry roamed with locked flag on"
 
-	$MZ $h1 -q -c 5 -d 100msec -t udp -a $mac -b rand
+	$MZ -q -c 5 -d 100msec -t udp -a $mac -b rand $h1
 	bridge fdb get $mac br br0 vlan 1 | grep -q "dev $swp1"
 	check_fail $? "Entry roamed back to locked port"
 
@@ -285,12 +285,12 @@ locked_port_mab_flush()
 	bridge fdb add $unlocked_mac1 dev $swp1 vlan 1 master static
 	bridge fdb add $unlocked_mac2 dev $swp2 vlan 1 master static
 
-	$MZ $h1 -q -c 5 -d 100msec -t udp -a $locked_mac1 -b rand
+	$MZ -q -c 5 -d 100msec -t udp -a $locked_mac1 -b rand $h1
 	bridge fdb get $locked_mac1 br br0 vlan 1 | grep "dev $swp1" | \
 		grep -q "locked"
 	check_err $? "Failed to create locked FDB entry on first port"
 
-	$MZ $h2 -q -c 5 -d 100msec -t udp -a $locked_mac2 -b rand
+	$MZ -q -c 5 -d 100msec -t udp -a $locked_mac2 -b rand $h2
 	bridge fdb get $locked_mac2 br br0 vlan 1 | grep "dev $swp2" | \
 		grep -q "locked"
 	check_err $? "Failed to create locked FDB entry on second port"
diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 8c1597ebc2d3..6ddb64ac90d0 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -1023,27 +1023,27 @@ __fwd_test_host_ip()
 	# Packet should only be flooded to multicast router ports when there is
 	# no matching MDB entry. The bridge is not configured as a multicast
 	# router port.
-	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q $h1.10
 	tc_check_packets "dev br0 ingress" 1 0
 	check_err $? "Packet locally received after flood"
 
 	# Install a regular port group entry and expect the packet to not be
 	# locally received.
 	bridge mdb add dev br0 port $swp2 grp $grp temp vid 10
-	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q $h1.10
 	tc_check_packets "dev br0 ingress" 1 0
 	check_err $? "Packet locally received after installing a regular entry"
 
 	# Add a host entry and expect the packet to be locally received.
 	bridge mdb add dev br0 port br0 grp $grp temp vid 10
-	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q $h1.10
 	tc_check_packets "dev br0 ingress" 1 1
 	check_err $? "Packet not locally received after adding a host entry"
 
 	# Remove the host entry and expect the packet to not be locally
 	# received.
 	bridge mdb del dev br0 port br0 grp $grp vid 10
-	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q $h1.10
 	tc_check_packets "dev br0 ingress" 1 1
 	check_err $? "Packet locally received after removing a host entry"
 
@@ -1071,27 +1071,27 @@ fwd_test_host_l2()
 
 	# Packet should be flooded and locally received when there is no
 	# matching MDB entry.
-	$MZ $h1.10 -c 1 -p 128 -a own -b $dmac -q
+	$MZ -c 1 -p 128 -a own -b $dmac -q $h1.10
 	tc_check_packets "dev br0 ingress" 1 1
 	check_err $? "Packet not locally received after flood"
 
 	# Install a regular port group entry and expect the packet to not be
 	# locally received.
 	bridge mdb add dev br0 port $swp2 grp $dmac permanent vid 10
-	$MZ $h1.10 -c 1 -p 128 -a own -b $dmac -q
+	$MZ -c 1 -p 128 -a own -b $dmac -q $h1.10
 	tc_check_packets "dev br0 ingress" 1 1
 	check_err $? "Packet locally received after installing a regular entry"
 
 	# Add a host entry and expect the packet to be locally received.
 	bridge mdb add dev br0 port br0 grp $dmac permanent vid 10
-	$MZ $h1.10 -c 1 -p 128 -a own -b $dmac -q
+	$MZ -c 1 -p 128 -a own -b $dmac -q $h1.10
 	tc_check_packets "dev br0 ingress" 1 2
 	check_err $? "Packet not locally received after adding a host entry"
 
 	# Remove the host entry and expect the packet to not be locally
 	# received.
 	bridge mdb del dev br0 port br0 grp $dmac permanent vid 10
-	$MZ $h1.10 -c 1 -p 128 -a own -b $dmac -q
+	$MZ -c 1 -p 128 -a own -b $dmac -q $h1.10
 	tc_check_packets "dev br0 ingress" 1 2
 	check_err $? "Packet locally received after removing a host entry"
 
@@ -1151,43 +1151,43 @@ __fwd_test_port_ip()
 		vlan_ethtype $eth_type vlan_id 10 dst_ip $grp \
 		src_ip $invalid_src action drop
 
-	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q $h1.10
 	tc_check_packets "dev $h2 ingress" 1 0
 	check_err $? "Packet from valid source received on H2 before adding entry"
 
-	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q $h1.10
 	tc_check_packets "dev $h2 ingress" 2 0
 	check_err $? "Packet from invalid source received on H2 before adding entry"
 
 	bridge mdb add dev br0 port $swp2 grp $grp vid 10 \
 		filter_mode $filter_mode source_list $src_list
 
-	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q $h1.10
 	tc_check_packets "dev $h2 ingress" 1 1
 	check_err $? "Packet from valid source not received on H2 after adding entry"
 
-	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q $h1.10
 	tc_check_packets "dev $h2 ingress" 2 0
 	check_err $? "Packet from invalid source received on H2 after adding entry"
 
 	bridge mdb replace dev br0 port $swp2 grp $grp vid 10 \
 		filter_mode exclude
 
-	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q $h1.10
 	tc_check_packets "dev $h2 ingress" 1 2
 	check_err $? "Packet from valid source not received on H2 after allowing all sources"
 
-	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q $h1.10
 	tc_check_packets "dev $h2 ingress" 2 1
 	check_err $? "Packet from invalid source not received on H2 after allowing all sources"
 
 	bridge mdb del dev br0 port $swp2 grp $grp vid 10
 
-	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q $h1.10
 	tc_check_packets "dev $h2 ingress" 1 2
 	check_err $? "Packet from valid source received on H2 after deleting entry"
 
-	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q $h1.10
 	tc_check_packets "dev $h2 ingress" 2 1
 	check_err $? "Packet from invalid source received on H2 after deleting entry"
 
@@ -1216,17 +1216,17 @@ fwd_test_port_l2()
 	tc filter add dev $h2 ingress protocol all pref 1 handle 1 flower \
 		dst_mac $dmac action drop
 
-	$MZ $h1.10 -c 1 -p 128 -a own -b $dmac -q
+	$MZ -c 1 -p 128 -a own -b $dmac -q $h1.10
 	tc_check_packets "dev $h2 ingress" 1 0
 	check_err $? "Packet received on H2 before adding entry"
 
 	bridge mdb add dev br0 port $swp2 grp $dmac permanent vid 10
-	$MZ $h1.10 -c 1 -p 128 -a own -b $dmac -q
+	$MZ -c 1 -p 128 -a own -b $dmac -q $h1.10
 	tc_check_packets "dev $h2 ingress" 1 1
 	check_err $? "Packet not received on H2 after adding entry"
 
 	bridge mdb del dev br0 port $swp2 grp $dmac permanent vid 10
-	$MZ $h1.10 -c 1 -p 128 -a own -b $dmac -q
+	$MZ -c 1 -p 128 -a own -b $dmac -q $h1.10
 	tc_check_packets "dev $h2 ingress" 1 1
 	check_err $? "Packet received on H2 after deleting entry"
 
@@ -1283,8 +1283,8 @@ ctrl_igmpv3_is_in_test()
 		filter_mode include source_list 192.0.2.1
 
 	# IS_IN ( 192.0.2.2 )
-	$MZ $h1.10 -c 1 -a own -b 01:00:5e:01:01:01 -A 192.0.2.1 -B 239.1.1.1 \
-		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q
+	$MZ -c 1 -a own -b 01:00:5e:01:01:01 -A 192.0.2.1 -B 239.1.1.1 \
+		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q $h1.10
 
 	bridge mdb get dev br0 grp 239.1.1.1 src 192.0.2.2 vid 10 &> /dev/null
 	check_fail $? "Permanent entry affected by IGMP packet"
@@ -1296,8 +1296,8 @@ ctrl_igmpv3_is_in_test()
 		filter_mode include source_list 192.0.2.1
 
 	# IS_IN ( 192.0.2.2 )
-	$MZ $h1.10 -a own -b 01:00:5e:01:01:01 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
-		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q
+	$MZ -a own -b 01:00:5e:01:01:01 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
+		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q $h1.10
 
 	bridge -d mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q 192.0.2.2
 	check_err $? "Source not add to source list"
@@ -1321,8 +1321,8 @@ ctrl_mldv2_is_in_test()
 
 	# IS_IN ( 2001:db8:1::2 )
 	local p=$(mldv2_is_in_get fe80::1 ff0e::1 2001:db8:1::2)
-	$MZ -6 $h1.10 -a own -b 33:33:00:00:00:01 -c 1 -A fe80::1 -B ff0e::1 \
-		-t ip hop=1,next=0,p="$p" -q
+	$MZ -6 -a own -b 33:33:00:00:00:01 -c 1 -A fe80::1 -B ff0e::1 \
+		-t ip hop=1,next=0,p="$p" -q $h1.10
 
 	bridge mdb get dev br0 grp ff0e::1 src 2001:db8:1::2 vid 10 &> /dev/null
 	check_fail $? "Permanent entry affected by MLD packet"
@@ -1334,8 +1334,8 @@ ctrl_mldv2_is_in_test()
 		filter_mode include source_list 2001:db8:1::1
 
 	# IS_IN ( 2001:db8:1::2 )
-	$MZ -6 $h1.10 -a own -b 33:33:00:00:00:01 -c 1 -A fe80::1 -B ff0e::1 \
-		-t ip hop=1,next=0,p="$p" -q
+	$MZ -6 -a own -b 33:33:00:00:00:01 -c 1 -A fe80::1 -B ff0e::1 \
+		-t ip hop=1,next=0,p="$p" -q $h1.10
 
 	bridge -d mdb get dev br0 grp ff0e::1 vid 10 | grep -q 2001:db8:1::2
 	check_err $? "Source not add to source list"
diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
index 3da9d93ab36f..1ebce13930c3 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
@@ -253,8 +253,8 @@ ctl4_entries_add()
 	local peer=$(locus_dev_peer $locus)
 	local GRP=239.1.1.${grp}
 	local dmac=01:00:5e:01:01:$(printf "%02x" $grp)
-	$MZ $peer -a own -b $dmac -c 1 -A 192.0.2.1 -B $GRP \
-		-t ip proto=2,p=$(igmpv3_is_in_get $GRP $IPs) -q
+	$MZ -a own -b $dmac -c 1 -A 192.0.2.1 -B $GRP \
+		-t ip proto=2,p=$(igmpv3_is_in_get $GRP $IPs) -q $peer
 	sleep 1
 
 	local nn=$(bridge mdb show dev br0 | grep $GRP | wc -l)
@@ -274,8 +274,8 @@ ctl4_entries_del()
 	local peer=$(locus_dev_peer $locus)
 	local GRP=239.1.1.${grp}
 	local dmac=01:00:5e:00:00:02
-	$MZ $peer -a own -b $dmac -c 1 -A 192.0.2.1 -B 224.0.0.2 \
-		-t ip proto=2,p=$(igmpv2_leave_get $GRP) -q
+	$MZ -a own -b $dmac -c 1 -A 192.0.2.1 -B 224.0.0.2 \
+		-t ip proto=2,p=$(igmpv2_leave_get $GRP) -q $peer
 	sleep 1
 	! bridge mdb show dev br0 | grep -q $GRP
 }
@@ -293,8 +293,8 @@ ctl6_entries_add()
 	local GRP=ff0e::${grp}
 	local dmac=33:33:00:00:00:$(printf "%02x" $grp)
 	local p=$(mldv2_is_in_get $SIP $GRP $IPs)
-	$MZ -6 $peer -a own -b $dmac -c 1 -A $SIP -B $GRP \
-		-t ip hop=1,next=0,p="$p" -q
+	$MZ -6 -a own -b $dmac -c 1 -A $SIP -B $GRP \
+		-t ip hop=1,next=0,p="$p" -q $peer
 	sleep 1
 
 	local nn=$(bridge mdb show dev br0 | grep $GRP | wc -l)
@@ -316,8 +316,8 @@ ctl6_entries_del()
 	local GRP=ff0e::${grp}
 	local dmac=33:33:00:00:00:$(printf "%02x" $grp)
 	local p=$(mldv1_done_get $SIP $GRP)
-	$MZ -6 $peer -a own -b $dmac -c 1 -A $SIP -B $GRP \
-		-t ip hop=1,next=0,p="$p" -q
+	$MZ -6 -a own -b $dmac -c 1 -A $SIP -B $GRP \
+		-t ip hop=1,next=0,p="$p" -q $peer
 	sleep 1
 	! bridge mdb show dev br0 | grep -q $GRP
 }
diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
index 4cacef5a813a..b4f6a81e8bf0 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
@@ -158,7 +158,7 @@ mldv2include_prepare()
 	ip link set dev br0 type bridge mcast_mld_version 2
 	check_err $? "Could not change bridge MLD version to 2"
 
-	$MZ $host1_if $MZPKT_IS_INC -q
+	$MZ -q $host1_if $MZPKT_IS_INC
 	sleep 1
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
@@ -183,7 +183,7 @@ mldv2exclude_prepare()
 
 	mldv2include_prepare $h1
 
-	$MZ $host1_if -c 1 $MZPKT_IS_EXC -q
+	$MZ -c 1 -q $host1_if $MZPKT_IS_EXC
 	sleep 1
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
@@ -236,7 +236,7 @@ mldv2inc_allow_test()
 
 	mldv2include_prepare $h1
 
-	$MZ $h1 -c 1 $MZPKT_ALLOW -q
+	$MZ -c 1 -q $h1 $MZPKT_ALLOW
 	sleep 1
 	brmcast_check_sg_entries "allow" "${X[@]}"
 
@@ -257,7 +257,7 @@ mldv2inc_is_include_test()
 
 	mldv2include_prepare $h1
 
-	$MZ $h1 -c 1 $MZPKT_IS_INC2 -q
+	$MZ -c 1 -q $h1 $MZPKT_IS_INC2
 	sleep 1
 	brmcast_check_sg_entries "is_include" "${X[@]}"
 
@@ -296,7 +296,7 @@ mldv2inc_to_exclude_test()
 	ip link set dev br0 type bridge mcast_last_member_interval 500
 	check_err $? "Could not change mcast_last_member_interval to 5s"
 
-	$MZ $h1 -c 1 $MZPKT_TO_EXC -q
+	$MZ -c 1 -q $h1 $MZPKT_TO_EXC
 	sleep 1
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
@@ -340,7 +340,7 @@ mldv2exc_allow_test()
 
 	mldv2exclude_prepare $h1
 
-	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
+	$MZ -c 1 -q $h1 $MZPKT_ALLOW2
 	sleep 1
 	brmcast_check_sg_entries "allow" "${X[@]}" "${Y[@]}"
 
@@ -363,7 +363,7 @@ mldv2exc_is_include_test()
 
 	mldv2exclude_prepare $h1
 
-	$MZ $h1 -c 1 $MZPKT_IS_INC3 -q
+	$MZ -c 1 -q $h1 $MZPKT_IS_INC3
 	sleep 1
 	brmcast_check_sg_entries "is_include" "${X[@]}" "${Y[@]}"
 
@@ -386,7 +386,7 @@ mldv2exc_is_exclude_test()
 
 	mldv2exclude_prepare $h1
 
-	$MZ $h1 -c 1 $MZPKT_IS_EXC2 -q
+	$MZ -c 1 -q $h1 $MZPKT_IS_EXC2
 	sleep 1
 	brmcast_check_sg_entries "is_exclude" "${X[@]}" "${Y[@]}"
 
@@ -412,7 +412,7 @@ mldv2exc_to_exclude_test()
 	ip link set dev br0 type bridge mcast_last_member_interval 500
 	check_err $? "Could not change mcast_last_member_interval to 5s"
 
-	$MZ $h1 -c 1 $MZPKT_TO_EXC -q
+	$MZ -c 1 -q $h1 $MZPKT_TO_EXC
 	sleep 1
 	brmcast_check_sg_entries "to_exclude" "${X[@]}" "${Y[@]}"
 
@@ -436,7 +436,7 @@ mldv2inc_block_test()
 
 	mldv2include_prepare $h1
 
-	$MZ $h1 -c 1 $MZPKT_BLOCK -q
+	$MZ -c 1 -q $h1 $MZPKT_BLOCK
 	# make sure the lowered timers have expired (by default 2 seconds)
 	sleep 3
 	brmcast_check_sg_entries "block" "${X[@]}"
@@ -469,7 +469,7 @@ mldv2exc_block_test()
 	ip link set dev br0 type bridge mcast_last_member_interval 500
 	check_err $? "Could not change mcast_last_member_interval to 5s"
 
-	$MZ $h1 -c 1 $MZPKT_BLOCK -q
+	$MZ -c 1 -q $h1 $MZPKT_BLOCK
 	sleep 1
 	brmcast_check_sg_entries "block" "${X[@]}" "${Y[@]}"
 
@@ -501,7 +501,7 @@ mldv2exc_timeout_test()
 					mcast_query_response_interval 500 \
 					mcast_membership_interval 1500
 
-	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
+	$MZ -c 1 -q $h1 $MZPKT_ALLOW2
 	sleep 5
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
@@ -544,7 +544,7 @@ mldv2star_ex_auto_add_test()
 
 	mldv2exclude_prepare $h1
 
-	$MZ $h2 -c 1 $MZPKT_IS_INC -q
+	$MZ -c 1 -q $h2 $MZPKT_IS_INC
 	sleep 1
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
diff --git a/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh b/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh
index 1f8ef0eff862..cbc9a9f3c6de 100755
--- a/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh
@@ -51,7 +51,7 @@ sticky()
 	bridge fdb add $TEST_MAC dev $swp1 master static sticky
 	check_err $? "Could not add fdb entry"
 	bridge fdb del $TEST_MAC dev $swp1 vlan 1 master static sticky
-	$MZ $h2 -c 1 -a $TEST_MAC -t arp "request" -q
+	$MZ -c 1 -a $TEST_MAC -t arp -q $h2 "request"
 	bridge -j fdb show br br0 brport $swp1\
 		| jq -e ".[] | select(.mac == \"$TEST_MAC\")" &> /dev/null
 	check_err $? "Did not find FDB record when should"
diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
index e59fba366a0a..88525294e410 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
@@ -131,7 +131,7 @@ extern_learn()
 	bridge fdb show brport $swp1 | grep -q de:ad:be:ef:13:37
 	check_err $? "FDB entry was aged out when should not"
 
-	$MZ $h2 -c 1 -p 64 -a $mac -t ip -q
+	$MZ -c 1 -p 64 -a $mac -t ip -q $h2
 
 	bridge fdb show brport $swp2 | grep -q de:ad:be:ef:13:37
 	check_err $? "FDB entry did not roam when should"
@@ -158,7 +158,7 @@ other_tpid()
 	ip link set $h2 promisc on
 	ethtool -K $h2 rx-vlan-filter off rx-vlan-stag-filter off
 
-	$MZ -q $h1 -c 1 -b $mac -a own "88:a8 00:03 81:00 00:05 08:00 aa-aa-aa-aa-aa-aa-aa-aa-aa"
+	$MZ -q -c 1 -b $mac -a own $h1 "88:a8 00:03 81:00 00:05 08:00 aa-aa-aa-aa-aa-aa-aa-aa-aa"
 	sleep 1
 
 	# Match on 'self' addresses as well, for those drivers which
@@ -179,7 +179,7 @@ other_tpid()
 
 	bridge vlan del dev $swp1 vid 1
 
-	$MZ -q $h1 -c 1 -b $mac -a own "88:a8 00:03 81:00 00:05 08:00 aa-aa-aa-aa-aa-aa-aa-aa-aa"
+	$MZ -q -c 1 -b $mac -a own $h1 "88:a8 00:03 81:00 00:05 08:00 aa-aa-aa-aa-aa-aa-aa-aa-aa"
 	sleep 1
 
 	RET=0
@@ -202,7 +202,7 @@ other_tpid()
 	tc filter add dev $h2 ingress protocol all pref 1 handle 101 \
 		flower dst_mac $mac action drop
 
-	$MZ -q $h1 -c 1 -b $mac -a own "81:00 00:00 08:00 aa-aa-aa-aa-aa-aa-aa-aa-aa"
+	$MZ -q -c 1 -b $mac -a own $h1 "81:00 00:00 08:00 aa-aa-aa-aa-aa-aa-aa-aa-aa"
 	sleep 1
 
 	tc -j -s filter show dev $h2 ingress \
diff --git a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
index 7d531f7091e6..de9086f4c724 100755
--- a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
@@ -181,44 +181,44 @@ ping_ipv6()
 
 send_src_ipv4()
 {
-	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -q -p 64 \
 		-A "198.51.100.2-198.51.100.253" -B 203.0.113.2 \
-		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp $h1 "sp=20000,dp=30000"
 }
 
 send_dst_ipv4()
 {
-	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -q -p 64 \
 		-A 198.51.100.2 -B "203.0.113.2-203.0.113.253" \
-		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp $h1 "sp=20000,dp=30000"
 }
 
 send_src_udp4()
 {
-	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -q -p 64 \
 		-A 198.51.100.2 -B 203.0.113.2 \
-		-d $MZ_DELAY -t udp "sp=0-32768,dp=30000"
+		-d $MZ_DELAY -t udp $h1 "sp=0-32768,dp=30000"
 }
 
 send_dst_udp4()
 {
-	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -q -p 64 \
 		-A 198.51.100.2 -B 203.0.113.2 \
-		-d $MZ_DELAY -t udp "sp=20000,dp=0-32768"
+		-d $MZ_DELAY -t udp $h1 "sp=20000,dp=0-32768"
 }
 
 send_src_ipv6()
 {
-	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -6 -q -p 64 \
 		-A "2001:db8:1::2-2001:db8:1::fd" -B 2001:db8:4::2 \
-		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp $h1 "sp=20000,dp=30000"
 }
 
 send_dst_ipv6()
 {
-	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -6 -q -p 64 \
 		-A 2001:db8:1::2 -B "2001:db8:4::2-2001:db8:4::fd" \
-		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp $h1 "sp=20000,dp=30000"
 }
 
 send_flowlabel()
@@ -226,22 +226,22 @@ send_flowlabel()
 	# Generate 16384 echo requests, each with a random flow label.
 	ip vrf exec v$h1 sh -c \
 		"for _ in {1..16384}; do \
-			$PING6 2001:db8:4::2 -F 0 -c 1 -q >/dev/null 2>&1; \
+			$PING6 -F 0 -c 1 -q 2001:db8:4::2 >/dev/null 2>&1; \
 		done"
 }
 
 send_src_udp6()
 {
-	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -6 -q -p 64 \
 		-A 2001:db8:1::2 -B 2001:db8:4::2 \
-		-d $MZ_DELAY -t udp "sp=0-32768,dp=30000"
+		-d $MZ_DELAY -t udp $h1 "sp=0-32768,dp=30000"
 }
 
 send_dst_udp6()
 {
-	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -6 -q -p 64 \
 		-A 2001:db8:1::2 -B 2001:db8:4::2 \
-		-d $MZ_DELAY -t udp "sp=20000,dp=0-32768"
+		-d $MZ_DELAY -t udp $h1 "sp=20000,dp=0-32768"
 }
 
 custom_hash_test()
diff --git a/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
index dda11a4a9450..24e74fa35392 100755
--- a/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
@@ -276,44 +276,44 @@ ping_ipv6()
 
 send_src_ipv4()
 {
-	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -q -p 64 \
 		-A "198.51.100.2-198.51.100.253" -B 203.0.113.2 \
-		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp $h1 "sp=20000,dp=30000"
 }
 
 send_dst_ipv4()
 {
-	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -q -p 64 \
 		-A 198.51.100.2 -B "203.0.113.2-203.0.113.253" \
-		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp $h1 "sp=20000,dp=30000"
 }
 
 send_src_udp4()
 {
-	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -q -p 64 \
 		-A 198.51.100.2 -B 203.0.113.2 \
-		-d $MZ_DELAY -t udp "sp=0-32768,dp=30000"
+		-d $MZ_DELAY -t udp $h1 "sp=0-32768,dp=30000"
 }
 
 send_dst_udp4()
 {
-	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -q -p 64 \
 		-A 198.51.100.2 -B 203.0.113.2 \
-		-d $MZ_DELAY -t udp "sp=20000,dp=0-32768"
+		-d $MZ_DELAY -t udp $h1 "sp=20000,dp=0-32768"
 }
 
 send_src_ipv6()
 {
-	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -6 -q -p 64 \
 		-A "2001:db8:1::2-2001:db8:1::fd" -B 2001:db8:2::2 \
-		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp $h1 "sp=20000,dp=30000"
 }
 
 send_dst_ipv6()
 {
-	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -6 -q -p 64 \
 		-A 2001:db8:1::2 -B "2001:db8:2::2-2001:db8:2::fd" \
-		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp $h1 "sp=20000,dp=30000"
 }
 
 send_flowlabel()
@@ -321,22 +321,22 @@ send_flowlabel()
 	# Generate 16384 echo requests, each with a random flow label.
 	ip vrf exec v$h1 sh -c \
 		"for _ in {1..16384}; do \
-			$PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1; \
+			$PING6 -F 0 -c 1 -q 2001:db8:2::2 >/dev/null 2>&1; \
 		done"
 }
 
 send_src_udp6()
 {
-	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -6 -q -p 64 \
 		-A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d $MZ_DELAY -t udp "sp=0-32768,dp=30000"
+		-d $MZ_DELAY -t udp $h1 "sp=0-32768,dp=30000"
 }
 
 send_dst_udp6()
 {
-	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -6 -q -p 64 \
 		-A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d $MZ_DELAY -t udp "sp=20000,dp=0-32768"
+		-d $MZ_DELAY -t udp $h1 "sp=20000,dp=0-32768"
 }
 
 custom_hash_test()
diff --git a/tools/testing/selftests/net/forwarding/gre_inner_v4_multipath.sh b/tools/testing/selftests/net/forwarding/gre_inner_v4_multipath.sh
index efca6114a3ce..3e1694c9773b 100755
--- a/tools/testing/selftests/net/forwarding/gre_inner_v4_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_inner_v4_multipath.sh
@@ -266,8 +266,8 @@ multipath4_test()
 	local t0_222=$(tc_rule_stats_get $ul32 222 ingress)
 
 	ip vrf exec v$h1 \
-	   $MZ $h1 -q -p 64 -A "192.0.3.2-192.0.3.62" -B "192.0.4.2-192.0.4.62" \
-	       -d $MZ_DELAY -c 50 -t udp "sp=1024,dp=1024"
+	   $MZ -q -p 64 -A "192.0.3.2-192.0.3.62" -B "192.0.4.2-192.0.4.62" \
+	       -d $MZ_DELAY -c 50 -t udp $h1 "sp=1024,dp=1024"
 	sleep 1
 
 	local t1_111=$(tc_rule_stats_get $ul32 111 ingress)
diff --git a/tools/testing/selftests/net/forwarding/gre_inner_v6_multipath.sh b/tools/testing/selftests/net/forwarding/gre_inner_v6_multipath.sh
index a71ad39fc0c3..fb2707a97f59 100755
--- a/tools/testing/selftests/net/forwarding/gre_inner_v6_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_inner_v6_multipath.sh
@@ -266,9 +266,9 @@ multipath6_test()
 	local t0_222=$(tc_rule_stats_get $ul32 222 ingress)
 
 	ip vrf exec v$h1 \
-	   $MZ $h1 -6 -q -p 64 -A "2001:db8:1::2-2001:db8:1::3e" \
+	   $MZ -6 -q -p 64 -A "2001:db8:1::2-2001:db8:1::3e" \
 	       -B "2001:db8:2::2-2001:db8:2::3e" \
-	       -d $MZ_DELAY -c 50 -t udp "sp=1024,dp=1024"
+	       -d $MZ_DELAY -c 50 -t udp $h1 "sp=1024,dp=1024"
 	sleep 1
 
 	local t1_111=$(tc_rule_stats_get $ul32 111 ingress)
diff --git a/tools/testing/selftests/net/forwarding/gre_multipath.sh b/tools/testing/selftests/net/forwarding/gre_multipath.sh
index 57531c1d884d..6ed8b8f1ac22 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath.sh
@@ -219,8 +219,8 @@ multipath4_test()
 	local t0_222=$(tc_rule_stats_get $ul2 222 ingress)
 
 	ip vrf exec v$h1 \
-	   $MZ $h1 -q -p 64 -A 192.0.2.1 -B 192.0.2.18 \
-	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+	   $MZ -q -p 64 -A 192.0.2.1 -B 192.0.2.18 \
+	       -d $MZ_DELAY -t udp $h1 "sp=1024,dp=0-32768"
 
 	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
 	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
index 7d5b2b9cc133..d207b5518843 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
@@ -243,8 +243,8 @@ multipath4_test()
 	local t0_222=$(tc_rule_stats_get $ul2 222 ingress)
 
 	ip vrf exec v$h1 \
-	   $MZ $h1 -q -p 64 -A 192.0.2.1 -B 192.0.2.18 \
-	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+	   $MZ -q -p 64 -A 192.0.2.1 -B 192.0.2.18 \
+	       -d $MZ_DELAY -t udp $h1 "sp=1024,dp=0-32768"
 
 	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
 	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
@@ -270,8 +270,8 @@ multipath6_test()
 	local t0_222=$(tc_rule_stats_get $ul2 222 ingress)
 
 	ip vrf exec v$h1 \
-		$MZ $h1 -6 -q -p 64 -A 2001:db8:1::1 -B 2001:db8:2::2 \
-		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+		$MZ -6 -q -p 64 -A 2001:db8:1::1 -B 2001:db8:2::2 \
+		-d $MZ_DELAY -t udp $h1 "sp=1024,dp=0-32768"
 
 	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
 	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
index 370f9925302d..f1d8a6b17d6f 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
@@ -246,8 +246,8 @@ multipath4_test()
 	local t0_222=$(tc_rule_stats_get $ul2 222 ingress)
 
 	ip vrf exec v$h1 \
-	   $MZ $h1 -q -p 64 -A 192.0.2.1 -B 192.0.2.18 \
-	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+	   $MZ -q -p 64 -A 192.0.2.1 -B 192.0.2.18 \
+	       -d $MZ_DELAY -t udp $h1 "sp=1024,dp=0-32768"
 
 	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
 	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
@@ -274,8 +274,8 @@ multipath6_test()
 	local t0_222=$(tc_rule_stats_get $ul2 222 ingress)
 
 	ip vrf exec v$h1 \
-		$MZ $h1 -6 -q -p 64 -A 2001:db8:1::1 -B 2001:db8:2::2 \
-		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+		$MZ -6 -q -p 64 -A 2001:db8:1::1 -B 2001:db8:2::2 \
+		-d $MZ_DELAY -t udp $h1 "sp=1024,dp=0-32768"
 
 	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
 	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
diff --git a/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh b/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
index 49fa94b53a1c..25036e38043c 100755
--- a/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
+++ b/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
@@ -95,7 +95,7 @@ ipv6_in_too_big_err()
 
 	# Send too big packets
 	ip vrf exec $vrf_name \
-		$PING6 -s 1300 2001:1:2::2 -c 1 -w $PING_TIMEOUT &> /dev/null
+		$PING6 -s 1300 -c 1 -w $PING_TIMEOUT 2001:1:2::2 &> /dev/null
 
 	local t1=$(ipv6_stats_get $rtr1 Ip6InTooBigErrors)
 	test "$((t1 - t0))" -ne 0
@@ -131,7 +131,7 @@ ipv6_in_addr_err()
 	# Disable forwarding temporary while sending the packet
 	sysctl -qw net.ipv6.conf.all.forwarding=0
 	ip vrf exec $vrf_name \
-		$PING6 2001:1:2::2 -c 1 -w $PING_TIMEOUT &> /dev/null
+		$PING6 -c 1 -w $PING_TIMEOUT 2001:1:2::2 &> /dev/null
 	sysctl -qw net.ipv6.conf.all.forwarding=1
 
 	local t1=$(ipv6_stats_get $rtr1 Ip6InAddrErrors)
@@ -150,7 +150,7 @@ ipv6_in_discard()
 	# Add a policy to discard
 	ip xfrm policy add dst 2001:1:2::2/128 dir fwd action block
 	ip vrf exec $vrf_name \
-		$PING6 2001:1:2::2 -c 1 -w $PING_TIMEOUT &> /dev/null
+		$PING6 -c 1 -w $PING_TIMEOUT 2001:1:2::2 &> /dev/null
 	ip xfrm policy del dst 2001:1:2::2/128 dir fwd
 
 	local t1=$(ipv6_stats_get $rtr1 Ip6InDiscards)
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
index e28b4a079e52..bcfa88fd0845 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
@@ -278,44 +278,44 @@ ping_ipv6()
 
 send_src_ipv4()
 {
-	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -q -p 64 \
 		-A "198.51.100.2-198.51.100.253" -B 203.0.113.2 \
-		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp $h1"sp=20000,dp=30000"
 }
 
 send_dst_ipv4()
 {
-	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -q -p 64 \
 		-A 198.51.100.2 -B "203.0.113.2-203.0.113.253" \
-		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp $h1"sp=20000,dp=30000"
 }
 
 send_src_udp4()
 {
-	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -q -p 64 \
 		-A 198.51.100.2 -B 203.0.113.2 \
-		-d $MZ_DELAY -t udp "sp=0-32768,dp=30000"
+		-d $MZ_DELAY -t udp $h1"sp=0-32768,dp=30000"
 }
 
 send_dst_udp4()
 {
-	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -q -p 64 \
 		-A 198.51.100.2 -B 203.0.113.2 \
-		-d $MZ_DELAY -t udp "sp=20000,dp=0-32768"
+		-d $MZ_DELAY -t udp $h1"sp=20000,dp=0-32768"
 }
 
 send_src_ipv6()
 {
-	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -6 -q -p 64 \
 		-A "2001:db8:1::2-2001:db8:1::fd" -B 2001:db8:2::2 \
-		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp $h1"sp=20000,dp=30000"
 }
 
 send_dst_ipv6()
 {
-	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
+	ip vrf exec v$h1 $MZ -6 -q -p 64 \
 		-A 2001:db8:1::2 -B "2001:db8:2::2-2001:db8:2::fd" \
-		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp $h1"sp=20000,dp=30000"
 }
 
 send_flowlabel()
@@ -323,7 +323,7 @@ send_flowlabel()
 	# Generate 16384 echo requests, each with a random flow label.
 	ip vrf exec v$h1 sh -c \
 		"for _ in {1..16384}; do \
-			$PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1; \
+			$PING6 -F 0 -c 1 -q 2001:db8:2::2 >/dev/null 2>&1; \
 		done"
 }
 
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_inner_v4_multipath.sh b/tools/testing/selftests/net/forwarding/ip6gre_inner_v4_multipath.sh
index 32d1461f37b7..21a2deb577ef 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_inner_v4_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_inner_v4_multipath.sh
@@ -265,8 +265,8 @@ multipath4_test()
 	local t0_222=$(tc_rule_stats_get $ul32 222 ingress)
 
 	ip vrf exec v$h1 \
-	   $MZ $h1 -q -p 64 -A "192.0.3.2-192.0.3.62" -B "192.0.4.2-192.0.4.62" \
-	       -d $MZ_DELAY -c 50 -t udp "sp=1024,dp=1024"
+	   $MZ -q -p 64 -A "192.0.3.2-192.0.3.62" -B "192.0.4.2-192.0.4.62" \
+	       -d $MZ_DELAY -c 50 -t udp $h1 "sp=1024,dp=1024"
 	sleep 1
 
 	local t1_111=$(tc_rule_stats_get $ul32 111 ingress)
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_inner_v6_multipath.sh b/tools/testing/selftests/net/forwarding/ip6gre_inner_v6_multipath.sh
index e1a4b50505f5..f2fd82017f21 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_inner_v6_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_inner_v6_multipath.sh
@@ -265,9 +265,9 @@ multipath6_test()
 	local t0_222=$(tc_rule_stats_get $ul32 222 ingress)
 
 	ip vrf exec v$h1 \
-	   $MZ $h1 -6 -q -p 64 -A "2001:db8:1::2-2001:db8:1::3e" \
+	   $MZ -6 -q -p 64 -A "2001:db8:1::2-2001:db8:1::3e" \
 	       -B "2001:db8:2::2-2001:db8:2::3e" \
-	       -d $MZ_DELAY -c 50 -t udp "sp=1024,dp=1024"
+	       -d $MZ_DELAY -c 50 -t udp $h1 "sp=1024,dp=1024"
 	sleep 1
 
 	local t1_111=$(tc_rule_stats_get $ul32 111 ingress)
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_lib.sh b/tools/testing/selftests/net/forwarding/ip6gre_lib.sh
index 2d91281dc5b7..4ebb8a1c758a 100644
--- a/tools/testing/selftests/net/forwarding/ip6gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_lib.sh
@@ -355,8 +355,8 @@ test_traffic_ip4ip6()
 	tc filter add dev $ol2 egress protocol ipv4 pref 1 handle 101 \
 		flower $TC_FLAG dst_ip 203.0.113.1 action pass
 
-	$MZ $h1 -c 1000 -p 64 -a $h1mac -b $ol1mac -A 198.51.100.1 \
-		-B 203.0.113.1 -t ip -q -d $MZ_DELAY
+	$MZ -c 1000 -p 64 -a $h1mac -b $ol1mac -A 198.51.100.1 \
+		-B 203.0.113.1 -t ip -q -d $MZ_DELAY $h1
 
 	# Check ports after encap and after decap.
 	tc_check_at_least_x_packets "dev $ul1 egress" 101 1000
@@ -388,8 +388,8 @@ test_traffic_ip6ip6()
 	tc filter add dev $ol2 egress protocol ipv6 pref 1 handle 101 \
 		flower $TC_FLAG dst_ip 2001:db8:2::1 action pass
 
-	$MZ -6 $h1 -c 1000 -p 64 -a $h1mac -b $ol1mac -A 2001:db8:1::1 \
-		-B 2001:db8:2::1 -t ip -q -d $MZ_DELAY
+	$MZ -6 -c 1000 -p 64 -a $h1mac -b $ol1mac -A 2001:db8:1::1 \
+		-B 2001:db8:2::1 -t ip -q -d $MZ_DELAY $h1
 
 	# Check ports after encap and after decap.
 	tc_check_at_least_x_packets "dev $ul1 egress" 101 1000
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 890b3374dacd..d1a06dbfe2ae 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1291,8 +1291,8 @@ ping_do()
 
 	vrf_name=$(master_name_get $if_name)
 	ip vrf exec $vrf_name \
-		$PING $args $dip -c $PING_COUNT -i 0.1 \
-		-w $PING_TIMEOUT &> /dev/null
+		$PING $args -c $PING_COUNT -i 0.1 \
+		-w $PING_TIMEOUT $dip &> /dev/null
 }
 
 ping_test()
@@ -1322,8 +1322,8 @@ ping6_do()
 
 	vrf_name=$(master_name_get $if_name)
 	ip vrf exec $vrf_name \
-		$PING6 $args $dip -c $PING_COUNT -i 0.1 \
-		-w $PING_TIMEOUT &> /dev/null
+		$PING6 $args -c $PING_COUNT -i 0.1 \
+		-w $PING_TIMEOUT $dip &> /dev/null
 }
 
 ping6_test()
@@ -1369,7 +1369,7 @@ learning_test()
 	tc filter add dev $host1_if ingress protocol ip pref 1 handle 101 \
 		flower dst_mac $mac action drop
 
-	$MZ $host2_if -c 1 -p 64 -b $mac -t ip -q
+	$MZ -c 1 -p 64 -b $mac -t ip -q $host2_if
 	sleep 1
 
 	tc -j -s filter show dev $host1_if ingress \
@@ -1377,14 +1377,14 @@ learning_test()
 		| select(.options.actions[0].stats.packets == 1)" &> /dev/null
 	check_fail $? "Packet reached first host when should not"
 
-	$MZ $host1_if -c 1 -p 64 -a $mac -t ip -q
+	$MZ -c 1 -p 64 -a $mac -t ip -q $host1_if
 	sleep 1
 
 	bridge -j fdb show br $bridge brport $br_port1 \
 		| jq -e ".[] | select(.mac == \"$mac\")" &> /dev/null
 	check_err $? "Did not find FDB record when should"
 
-	$MZ $host2_if -c 1 -p 64 -b $mac -t ip -q
+	$MZ -c 1 -p 64 -b $mac -t ip -q $host2_if
 	sleep 1
 
 	tc -j -s filter show dev $host1_if ingress \
@@ -1403,7 +1403,7 @@ learning_test()
 
 	bridge link set dev $br_port1 learning off
 
-	$MZ $host1_if -c 1 -p 64 -a $mac -t ip -q
+	$MZ -c 1 -p 64 -a $mac -t ip -q $host1_if
 	sleep 1
 
 	bridge -j fdb show br $bridge brport $br_port1 \
@@ -1437,7 +1437,7 @@ flood_test_do()
 	tc filter add dev $host2_if ingress protocol ip pref 1 handle 101 \
 		flower dst_mac $mac action drop
 
-	$MZ $host1_if -c 1 -p 64 -b $mac -B $ip -t ip -q
+	$MZ -c 1 -p 64 -b $mac -B $ip -t ip -q $host1_if
 	sleep 1
 
 	tc -j -s filter show dev $host2_if ingress \
@@ -1522,8 +1522,8 @@ __start_traffic()
 	local dmac=$1; shift
 	local -a mz_args=("$@")
 
-	$MZ $h_in -p $pktsize -A $sip -B $dip -c 0 \
-		-a own -b $dmac -t "$proto" -q "${mz_args[@]}" &
+	$MZ -p $pktsize -A $sip -B $dip -c 0 \
+		-a own -b $dmac -t "$proto" -q $h_in "${mz_args[@]}" &
 	sleep 1
 }
 
@@ -1663,7 +1663,7 @@ mcast_packet_test()
 	tc filter add dev $host2_if ingress protocol $tc_proto pref 1 handle 101 \
 		flower ip_proto udp dst_mac $mac action drop
 
-	$MZ $host1_if $mz_v6arg -c 1 -p 64 -b $mac -A $src_ip -B $ip -t udp "dp=4096,sp=2048" -q
+	$MZ $mz_v6arg -c 1 -p 64 -b $mac -A $src_ip -B $ip -t udp -q $host1_if "dp=4096,sp=2048"
 	sleep 1
 
 	tc -j -s filter show dev $host2_if ingress \
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
index a20d22d1df36..8d4ae6c952a1 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
@@ -238,7 +238,7 @@ test_lag_slave()
 	ip neigh flush dev br1
 	setup_wait_dev $up_dev
 	setup_wait_dev $host_dev
-	$ARPING -I br1 192.0.2.130 -qfc 1
+	$ARPING -I br1 -qfc 1 192.0.2.130
 	sleep 2
 	mirror_test vrf-h1 192.0.2.1 192.0.2.18 $host_dev 1 ">= 10"
 
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh b/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
index 1b902cc579f6..a21c771908b3 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
@@ -196,7 +196,7 @@ test_span_gre_forbidden_egress()
 
 	bridge vlan add dev $swp3 vid 555
 	# Re-prime FDB
-	$ARPING -I br1.555 192.0.2.130 -fqc 1
+	$ARPING -I br1.555 -fqc 1 192.0.2.130
 	sleep 1
 	quick_test_span_gre_dir $tundev
 
@@ -290,7 +290,7 @@ test_span_gre_fdb_roaming()
 
 	bridge fdb del dev $swp2 $h3mac vlan 555 master 2>/dev/null
 	# Re-prime FDB
-	$ARPING -I br1.555 192.0.2.130 -fqc 1
+	$ARPING -I br1.555 -fqc 1 192.0.2.130
 	sleep 1
 	quick_test_span_gre_dir $tundev
 
diff --git a/tools/testing/selftests/net/forwarding/mirror_lib.sh b/tools/testing/selftests/net/forwarding/mirror_lib.sh
index 6bf9d5ae933c..401b1cdf0758 100644
--- a/tools/testing/selftests/net/forwarding/mirror_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_lib.sh
@@ -49,8 +49,8 @@ mirror_test()
 	fi
 
 	local t0=$(tc_rule_stats_get $dev $pref)
-	$MZ $proto $vrf_name ${sip:+-A $sip} -B $dip -a own -b bc -q \
-	    -c 10 -d 100msec -t $type
+	$MZ $proto ${sip:+-A $sip} -B $dip -a own -b bc -q \
+	    -c 10 -d 100msec -t $type $vrf_name
 	sleep 0.5
 	local t1=$(tc_rule_stats_get $dev $pref)
 	local delta=$((t1 - t0))
diff --git a/tools/testing/selftests/net/forwarding/pedit_dsfield.sh b/tools/testing/selftests/net/forwarding/pedit_dsfield.sh
index af008fbf2725..3e8804ccb721 100755
--- a/tools/testing/selftests/net/forwarding/pedit_dsfield.sh
+++ b/tools/testing/selftests/net/forwarding/pedit_dsfield.sh
@@ -130,8 +130,8 @@ do_test_pedit_dsfield_common()
 
 	# TOS 125: DSCP 31, ECN 1. Used for testing that the relevant part is
 	# overwritten when zero is selected.
-	$MZ $mz_flags $h1 -c 10 -d 20msec -p 100 \
-	    -a own -b $h2mac -q -t tcp tos=0x7d,sp=54321,dp=12345
+	$MZ $mz_flags -c 10 -d 20msec -p 100 \
+	    -a own -b $h2mac -q -t tcp $h1 tos=0x7d,sp=54321,dp=12345
 
 	local pkts
 	pkts=$(busywait "$TC_HIT_TIMEOUT" until_counter_is ">= 10" \
diff --git a/tools/testing/selftests/net/forwarding/pedit_ip.sh b/tools/testing/selftests/net/forwarding/pedit_ip.sh
index d14efb2d23b2..48aab7f4cc49 100755
--- a/tools/testing/selftests/net/forwarding/pedit_ip.sh
+++ b/tools/testing/selftests/net/forwarding/pedit_ip.sh
@@ -128,7 +128,7 @@ do_test_pedit_ip()
 
 	RET=0
 
-	$MZ $mz_flags $h1 -c 10 -d 20msec -p 100 -a own -b $h2mac -q -t ip
+	$MZ $mz_flags -c 10 -d 20msec -p 100 -a own -b $h2mac -q -t ip $h1
 
 	local pkts
 	pkts=$(busywait "$TC_HIT_TIMEOUT" until_counter_is ">= 10" \
diff --git a/tools/testing/selftests/net/forwarding/pedit_l4port.sh b/tools/testing/selftests/net/forwarding/pedit_l4port.sh
index 10e594c55117..d9846703d6cc 100755
--- a/tools/testing/selftests/net/forwarding/pedit_l4port.sh
+++ b/tools/testing/selftests/net/forwarding/pedit_l4port.sh
@@ -132,8 +132,8 @@ do_test_pedit_l4port_one()
 
 	RET=0
 
-	$MZ $mz_flags $h1 -c 10 -d 20msec -p 100 \
-	    -a own -b $h2mac -q -t $pedit_prot sp=54321,dp=12345
+	$MZ $mz_flags -c 10 -d 20msec -p 100 \
+	    -a own -b $h2mac -q -t $pedit_prot $h1 sp=54321,dp=12345
 
 	local pkts
 	pkts=$(busywait "$TC_HIT_TIMEOUT" until_counter_is ">= 10" \
diff --git a/tools/testing/selftests/net/forwarding/router.sh b/tools/testing/selftests/net/forwarding/router.sh
index b98ea9449b8b..2560ad760a66 100755
--- a/tools/testing/selftests/net/forwarding/router.sh
+++ b/tools/testing/selftests/net/forwarding/router.sh
@@ -197,8 +197,8 @@ sip_in_class_e()
 	tc filter add dev $rp2 egress protocol ip pref 1 handle 101 \
 		flower src_ip 240.0.0.1 ip_proto udp action pass
 
-	$MZ $h1 -t udp "sp=54321,dp=12345" -c 5 -d 1msec \
-		-A 240.0.0.1 -b $rp1mac -B 198.51.100.2 -q
+	$MZ -t udp -c 5 -d 1msec \
+		-A 240.0.0.1 -b $rp1mac -B 198.51.100.2 -q $h1 "sp=54321,dp=12345"
 
 	tc_check_packets "dev $rp2 egress" 101 5
 	check_err $? "Packets were dropped"
@@ -246,8 +246,8 @@ __mc_mac_mismatch()
 
 	create_mcast_sg $rp1 $sip $dip $rp2
 
-	$MZ $flags $h1 -t udp "sp=54321,dp=12345" -c 5 -d 1msec -b $dmac \
-		-B $dip -q
+	$MZ $flags -t udp -c 5 -d 1msec -b $dmac \
+		-B $dip -q $h1 "sp=54321,dp=12345"
 
 	tc_check_packets "dev $rp2 egress" 101 5
 	check_err $? "Packets were dropped"
@@ -275,8 +275,8 @@ ipv4_sip_equal_dip()
 	tc filter add dev $rp2 egress protocol ip pref 1 handle 101 \
 		flower src_ip 198.51.100.2  action pass
 
-	$MZ $h1 -t udp "sp=54321,dp=12345" -c 5 -d 1msec \
-		-A 198.51.100.2 -b $rp1mac -B 198.51.100.2 -q
+	$MZ -t udp -c 5 -d 1msec \
+		-A 198.51.100.2 -b $rp1mac -B 198.51.100.2 -q $h1 "sp=54321,dp=12345"
 
 	tc_check_packets "dev $rp2 egress" 101 5
 	check_err $? "Packets were dropped"
@@ -295,8 +295,8 @@ ipv6_sip_equal_dip()
 	tc filter add dev $rp2 egress protocol ipv6 pref 1 handle 101 \
 		flower src_ip 2001:db8:2::2 action pass
 
-	$MZ -6 $h1 -t udp "sp=54321,dp=12345" -c 5 -d 1msec \
-		-A 2001:db8:2::2 -b $rp1mac -B 2001:db8:2::2 -q
+	$MZ -6 -t udp -c 5 -d 1msec \
+		-A 2001:db8:2::2 -b $rp1mac -B 2001:db8:2::2 -q $h1 "sp=54321,dp=12345"
 
 	tc_check_packets "dev $rp2 egress" 101 5
 	check_err $? "Packets were dropped"
@@ -318,7 +318,7 @@ ipv4_dip_link_local()
 	ip neigh add 169.254.1.1 lladdr 00:11:22:33:44:55 dev $rp2
 	ip route add 169.254.1.0/24 dev $rp2
 
-	$MZ $h1 -t udp "sp=54321,dp=12345" -c 5 -d 1msec -b $rp1mac -B $dip -q
+	$MZ -t udp -c 5 -d 1msec -b $rp1mac -B $dip -q $h1 "sp=54321,dp=12345"
 
 	tc_check_packets "dev $rp2 egress" 101 5
 	check_err $? "Packets were dropped"
diff --git a/tools/testing/selftests/net/forwarding/router_broadcast.sh b/tools/testing/selftests/net/forwarding/router_broadcast.sh
index 4eac0a06f451..e13569d96cd7 100755
--- a/tools/testing/selftests/net/forwarding/router_broadcast.sh
+++ b/tools/testing/selftests/net/forwarding/router_broadcast.sh
@@ -173,7 +173,7 @@ ping_test_from()
 
 	log_info "ping $dip, expected reply from $from"
 	ip vrf exec $(master_name_get $oif) \
-		$PING -I $oif $dip -c 10 -i 0.1 -w $PING_TIMEOUT -b 2>&1 \
+		$PING -I $oif -c 10 -i 0.1 -w $PING_TIMEOUT -b $dip 2>&1 \
 		| grep "bytes from $from" > /dev/null
 	check_err_fail $fail $?
 }
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
index a7d8399c8d4f..f0cded6b7bcf 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
@@ -244,8 +244,8 @@ multipath4_test()
 	t0_rp12=$(link_stats_tx_packets_get $rp12)
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
-	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
-		-d $MZ_DELAY -t udp "$ports"
+	ip vrf exec vrf-h1 $MZ -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
+		-d $MZ_DELAY -t udp $h1 "$ports"
 	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
@@ -280,8 +280,8 @@ multipath6_test()
 	t0_rp12=$(link_stats_tx_packets_get $rp12)
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
-	$MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d $MZ_DELAY -t udp "$ports"
+	$MZ -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
+		-d $MZ_DELAY -t udp $h1 "$ports"
 	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
index 507b2852dabe..d8ba304ec9ff 100644
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
@@ -104,7 +104,7 @@ __nh_stats_test_v4()
 
 	sysctl_set net.ipv4.fib_multipath_hash_policy 1
 	nh_stats_test_dispatch $nhgtype "IPv4" 101 102 103 \
-			       $MZ $h1 -A 192.0.2.2 -B 198.51.100.2
+			       $MZ -A 192.0.2.2 -B 198.51.100.2 $h1
 	sysctl_restore net.ipv4.fib_multipath_hash_policy
 }
 
@@ -114,7 +114,7 @@ __nh_stats_test_v6()
 
 	sysctl_set net.ipv6.fib_multipath_hash_policy 1
 	nh_stats_test_dispatch $nhgtype "IPv6" 104 105 106 \
-			       $MZ -6 $h1 -A 2001:db8:1::2 -B 2001:db8:2::2
+			       $MZ -6 -A 2001:db8:1::2 -B 2001:db8:2::2 $h1
 	sysctl_restore net.ipv6.fib_multipath_hash_policy
 }
 
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
index 88ddae05b39d..1db64b8beab2 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
@@ -245,8 +245,8 @@ multipath4_test()
 	t0_rp12=$(link_stats_tx_packets_get $rp12)
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
-	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
-		-d $MZ_DELAY -t udp "$ports"
+	ip vrf exec vrf-h1 $MZ -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
+		-d $MZ_DELAY -t udp $h1 "$ports"
 	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
@@ -278,8 +278,8 @@ multipath6_l4_test()
 	t0_rp12=$(link_stats_tx_packets_get $rp12)
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
-	$MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d $MZ_DELAY -t udp "$ports"
+	$MZ -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
+		-d $MZ_DELAY -t udp $h1 "$ports"
 	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_seed.sh b/tools/testing/selftests/net/forwarding/router_mpath_seed.sh
index 314cb906c1eb..d6a2a24da423 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_seed.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_seed.sh
@@ -255,15 +255,15 @@ test_mpath_seed()
 test_mpath_seed_ipv4()
 {
 	test_mpath_seed 1000 IPv4 \
-		$MZ $h1 -A 192.0.2.1 -B 192.0.2.34 -q \
-			-p 64 -d 0 -c 10 -t udp
+		$MZ -A 192.0.2.1 -B 192.0.2.34 -q \
+			-p 64 -d 0 -c 10 -t udp $h1
 }
 
 test_mpath_seed_ipv6()
 {
 	test_mpath_seed 2000 IPv6 \
-		$MZ -6 $h1 -A 2001:db8:1::1 -B 2001:db8:3::2 -q \
-			-p 64 -d 0 -c 10 -t udp
+		$MZ -6 -A 2001:db8:1::1 -B 2001:db8:3::2 -q \
+			-p 64 -d 0 -c 10 -t udp $h1
 }
 
 check_mpath_seed_stability()
@@ -311,15 +311,15 @@ test_mpath_seed_stability()
 test_mpath_seed_stability_ipv4()
 {
 	test_mpath_seed_stability 1000 IPv4 \
-		$MZ $h1 -A 192.0.2.1 -B 192.0.2.34 -q \
-			-p 64 -d 0 -c 10 -t udp
+		$MZ -A 192.0.2.1 -B 192.0.2.34 -q \
+			-p 64 -d 0 -c 10 -t udp $h1
 }
 
 test_mpath_seed_stability_ipv6()
 {
 	test_mpath_seed_stability 2000 IPv6 \
-		$MZ -6 $h1 -A 2001:db8:1::1 -B 2001:db8:3::2 -q \
-			-p 64 -d 0 -c 10 -t udp
+		$MZ -6 -A 2001:db8:1::1 -B 2001:db8:3::2 -q \
+			-p 64 -d 0 -c 10 -t udp $h1
 }
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/net/forwarding/router_multicast.sh b/tools/testing/selftests/net/forwarding/router_multicast.sh
index 83e52abdbc2e..b22846b09b45 100755
--- a/tools/testing/selftests/net/forwarding/router_multicast.sh
+++ b/tools/testing/selftests/net/forwarding/router_multicast.sh
@@ -222,8 +222,8 @@ mcast_v4()
 	create_mcast_sg $rp1 198.51.100.2 225.1.2.3 $rp2 $rp3
 
 	# Send frames with the corresponding L2 destination address.
-	$MZ $h1 -c 5 -p 128 -t udp -a 00:11:22:33:44:55 -b 01:00:5e:01:02:03 \
-		-A 198.51.100.2 -B 225.1.2.3 -q
+	$MZ -c 5 -p 128 -t udp -a 00:11:22:33:44:55 -b 01:00:5e:01:02:03 \
+		-A 198.51.100.2 -B 225.1.2.3 -q $h1
 
 	tc_check_packets "dev $h2 ingress" 122 5
 	check_err $? "Multicast not received on first host"
@@ -232,8 +232,8 @@ mcast_v4()
 
 	delete_mcast_sg $rp1 198.51.100.2 225.1.2.3 $rp2 $rp3
 
-	$MZ $h1 -c 5 -p 128 -t udp -a 00:11:22:33:44:55 -b 01:00:5e:01:02:03 \
-		-A 198.51.100.2 -B 225.1.2.3 -q
+	$MZ -c 5 -p 128 -t udp -a 00:11:22:33:44:55 -b 01:00:5e:01:02:03 \
+		-A 198.51.100.2 -B 225.1.2.3 -q $h1
 
 	tc_check_packets "dev $h2 ingress" 122 5
 	check_err $? "Multicast received on host although deleted"
@@ -262,8 +262,8 @@ mcast_v6()
 	create_mcast_sg $rp1 2001:db8:1::2 ff0e::3 $rp2 $rp3
 
 	# Send frames with the corresponding L2 destination address.
-	$MZ $h1 -6 -c 5 -p 128 -t udp -a 00:11:22:33:44:55 \
-		-b 33:33:00:00:00:03 -A 2001:db8:1::2 -B ff0e::3 -q
+	$MZ -6 -c 5 -p 128 -t udp -a 00:11:22:33:44:55 \
+		-b 33:33:00:00:00:03 -A 2001:db8:1::2 -B ff0e::3 -q $h1
 
 	tc_check_packets "dev $h2 ingress" 122 5
 	check_err $? "Multicast not received on first host"
@@ -272,8 +272,8 @@ mcast_v6()
 
 	delete_mcast_sg $rp1 2001:db8:1::2 ff0e::3 $rp2 $rp3
 
-	$MZ $h1 -6 -c 5 -p 128 -t udp -a 00:11:22:33:44:55 \
-		-b 33:33:00:00:00:03 -A 2001:db8:1::2 -B ff0e::3 -q
+	$MZ -6 -c 5 -p 128 -t udp -a 00:11:22:33:44:55 \
+		-b 33:33:00:00:00:03 -A 2001:db8:1::2 -B ff0e::3 -q $h1
 
 	tc_check_packets "dev $h2 ingress" 122 5
 	check_err $? "Multicast received on first host although deleted"
@@ -308,18 +308,18 @@ rpf_v4()
 
 	create_mcast_sg $rp1 198.51.100.2 225.1.2.3 $rp2 $rp3
 
-	$MZ $h1 -c 5 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
+	$MZ -c 5 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
 		-a 00:11:22:33:44:55 -b 01:00:5e:01:02:03 \
-		-A 198.51.100.2 -B 225.1.2.3 -q
+		-A 198.51.100.2 -B 225.1.2.3 -q $h1
 
 	tc_check_packets "dev $h2 ingress" 1 5
 	check_err $? "Multicast not received on first host"
 	tc_check_packets "dev $h3 ingress" 1 5
 	check_err $? "Multicast not received on second host"
 
-	$MZ $h3 -c 5 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
+	$MZ -c 5 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
 		-a 00:11:22:33:44:55 -b 01:00:5e:01:02:03 \
-		-A 198.51.100.2 -B 225.1.2.3 -q
+		-A 198.51.100.2 -B 225.1.2.3 -q $h3
 
 	tc_check_packets "dev $h1 ingress" 1 0
 	check_err $? "Multicast received on first host when should not"
@@ -353,18 +353,18 @@ rpf_v6()
 
 	create_mcast_sg $rp1 2001:db8:1::2 ff0e::3 $rp2 $rp3
 
-	$MZ $h1 -6 -c 5 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
+	$MZ -6 -c 5 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
 		-a 00:11:22:33:44:55 -b 33:33:00:00:00:03 \
-		-A 2001:db8:1::2 -B ff0e::3 -q
+		-A 2001:db8:1::2 -B ff0e::3 -q $h1
 
 	tc_check_packets "dev $h2 ingress" 1 5
 	check_err $? "Multicast not received on first host"
 	tc_check_packets "dev $h3 ingress" 1 5
 	check_err $? "Multicast not received on second host"
 
-	$MZ $h3 -6 -c 5 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
+	$MZ -6 -c 5 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
 		-a 00:11:22:33:44:55 -b 33:33:00:00:00:03 \
-		-A 2001:db8:1::2 -B ff0e::3 -q
+		-A 2001:db8:1::2 -B ff0e::3 -q $h3
 
 	tc_check_packets "dev $h1 ingress" 1 0
 	check_err $? "Multicast received on first host when should not"
@@ -399,9 +399,9 @@ unres_v4()
 		dst_ip 225.1.2.3 ip_proto udp dst_port 12345 action drop
 
 	# Forwarding should fail before installing a matching (*, G).
-	$MZ $h1 -c 1 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
+	$MZ -c 1 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
 		-a 00:11:22:33:44:55 -b 01:00:5e:01:02:03 \
-		-A 198.51.100.2 -B 225.1.2.3 -q
+		-A 198.51.100.2 -B 225.1.2.3 -q $h1
 
 	tc_check_packets "dev $h2 ingress" 1 0
 	check_err $? "Multicast received on first host when should not"
@@ -411,9 +411,9 @@ unres_v4()
 	# Create (*, G). Will not be installed in the kernel.
 	create_mcast_sg $rp1 0.0.0.0 225.1.2.3 $rp2 $rp3
 
-	$MZ $h1 -c 1 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
+	$MZ -c 1 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
 		-a 00:11:22:33:44:55 -b 01:00:5e:01:02:03 \
-		-A 198.51.100.2 -B 225.1.2.3 -q
+		-A 198.51.100.2 -B 225.1.2.3 -q $h1
 
 	tc_check_packets "dev $h2 ingress" 1 1
 	check_err $? "Multicast not received on first host"
@@ -444,9 +444,9 @@ unres_v6()
 		dst_ip ff0e::3 ip_proto udp dst_port 12345 action drop
 
 	# Forwarding should fail before installing a matching (*, G).
-	$MZ $h1 -6 -c 1 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
+	$MZ -6 -c 1 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
 		-a 00:11:22:33:44:55 -b 33:33:00:00:00:03 \
-		-A 2001:db8:1::2 -B ff0e::3 -q
+		-A 2001:db8:1::2 -B ff0e::3 -q $h1
 
 	tc_check_packets "dev $h2 ingress" 1 0
 	check_err $? "Multicast received on first host when should not"
@@ -456,9 +456,9 @@ unres_v6()
 	# Create (*, G). Will not be installed in the kernel.
 	create_mcast_sg $rp1 :: ff0e::3 $rp2 $rp3
 
-	$MZ $h1 -6 -c 1 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
+	$MZ -6 -c 1 -p 128 -t udp "ttl=10,sp=54321,dp=12345" \
 		-a 00:11:22:33:44:55 -b 33:33:00:00:00:03 \
-		-A 2001:db8:1::2 -B ff0e::3 -q
+		-A 2001:db8:1::2 -B ff0e::3 -q $h1
 
 	tc_check_packets "dev $h2 ingress" 1 1
 	check_err $? "Multicast not received on first host"
diff --git a/tools/testing/selftests/net/forwarding/router_multipath.sh b/tools/testing/selftests/net/forwarding/router_multipath.sh
index 46f365b557b7..d21da56f168d 100755
--- a/tools/testing/selftests/net/forwarding/router_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/router_multipath.sh
@@ -178,8 +178,8 @@ multipath4_test()
        t0_rp12=$(link_stats_tx_packets_get $rp12)
        t0_rp13=$(link_stats_tx_packets_get $rp13)
 
-       ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
-	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+       ip vrf exec vrf-h1 $MZ -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
+	       -d $MZ_DELAY -t udp  $h1"sp=1024,dp=0-32768"
        sleep 1
 
        t1_rp12=$(link_stats_tx_packets_get $rp12)
@@ -216,8 +216,8 @@ multipath6_test()
        t0_rp12=$(link_stats_tx_packets_get $rp12)
        t0_rp13=$(link_stats_tx_packets_get $rp13)
 
-       $MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
-	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+       $MZ -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
+	       -d $MZ_DELAY -t udp $h1 "sp=1024,dp=0-32768"
        sleep 1
 
        t1_rp12=$(link_stats_tx_packets_get $rp12)
diff --git a/tools/testing/selftests/net/forwarding/sch_red.sh b/tools/testing/selftests/net/forwarding/sch_red.sh
index af166662b78a..5d49ca59008c 100755
--- a/tools/testing/selftests/net/forwarding/sch_red.sh
+++ b/tools/testing/selftests/net/forwarding/sch_red.sh
@@ -165,7 +165,7 @@ send_packets()
 	local proto=$1; shift
 	local pkts=$1; shift
 
-	$MZ $h2 -p $PKTSZ -a own -b $h3_mac -A 192.0.2.2 -B 192.0.2.3 -t $proto -q -c $pkts "$@"
+	$MZ -p $PKTSZ -a own -b $h3_mac -A 192.0.2.2 -B 192.0.2.3 -t $proto -q -c $pkts $h2 "$@"
 }
 
 # This sends traffic in an attempt to build a backlog of $size. Returns 0 on
@@ -266,8 +266,8 @@ do_ecn_test()
 	local limit=$1; shift
 	local name=ECN
 
-	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
-		-a own -b $h3_mac -t tcp -q tos=0x01 &
+	$MZ -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
+		-a own -b $h3_mac -t tcp -q $h1 tos=0x01 &
 	defer stop_traffic $!
 	sleep 1
 
@@ -287,8 +287,8 @@ do_ecn_nodrop_test()
 	local limit=$1; shift
 	local name="ECN nodrop"
 
-	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
-		-a own -b $h3_mac -t tcp -q tos=0x01 &
+	$MZ -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
+		-a own -b $h3_mac -t tcp -q $h1 tos=0x01 &
 	defer stop_traffic $!
 	sleep 1
 
@@ -311,8 +311,8 @@ do_red_test()
 
 	# Use ECN-capable TCP to verify there's no marking even though the queue
 	# is above limit.
-	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
-		-a own -b $h3_mac -t tcp -q tos=0x01 &
+	$MZ -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
+		-a own -b $h3_mac -t tcp -q $h1 tos=0x01 &
 	defer stop_traffic $!
 
 	# Pushing below the queue limit should work.
@@ -342,8 +342,8 @@ do_red_qevent_test()
 
 	RET=0
 
-	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
-		-a own -b $h3_mac -t udp -q &
+	$MZ -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
+		-a own -b $h3_mac -t udp -q $h1 &
 	defer stop_traffic $!
 	sleep 1
 
@@ -381,8 +381,8 @@ do_ecn_qevent_test()
 
 	RET=0
 
-	$MZ $h1 -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
-		-a own -b $h3_mac -t tcp -q tos=0x01 &
+	$MZ -p $PKTSZ -A 192.0.2.1 -B 192.0.2.3 -c 0 \
+		-a own -b $h3_mac -t tcp -q tos=0x01 $h1 &
 	defer stop_traffic $!
 	sleep 1
 
diff --git a/tools/testing/selftests/net/forwarding/skbedit_priority.sh b/tools/testing/selftests/net/forwarding/skbedit_priority.sh
index 3dd5fcbd3eaa..06e8b9e21b94 100755
--- a/tools/testing/selftests/net/forwarding/skbedit_priority.sh
+++ b/tools/testing/selftests/net/forwarding/skbedit_priority.sh
@@ -125,8 +125,8 @@ test_skbedit_priority_one()
 
 	local pkt0=$(qdisc_parent_stats_get $swp2 $classid .packets)
 	local pkt2=$(tc_rule_handle_stats_get "$locus" 101)
-	$MZ $h1 -t udp "sp=54321,dp=12345" -c 10 -d 20msec -p 100 \
-	    -a own -b $h2mac -A 192.0.2.1 -B 192.0.2.2 -q
+	$MZ -t udp -c 10 -d 20msec -p 100 \
+	    -a own -b $h2mac -A 192.0.2.1 -B 192.0.2.2 -q $h1 "sp=54321,dp=12345"
 
 	local pkt1
 	pkt1=$(busywait "$HIT_TIMEOUT" until_counter_is ">= $((pkt0 + 10))" \
diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index ea89e558672d..580aaa42ed31 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -66,8 +66,8 @@ mirred_egress_test()
 	tc filter add dev $h2 ingress protocol ip pref 1 handle 101 flower \
 		dst_ip 192.0.2.2 action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched without redirect rule inserted"
@@ -76,8 +76,8 @@ mirred_egress_test()
 		$classifier $tcflags $classifier_args \
 		action mirred egress $action dev $swp2
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_err $? "Did not match incoming $action packet"
@@ -96,8 +96,8 @@ gact_drop_and_ok_test()
 	tc filter add dev $swp1 ingress protocol ip pref 2 handle 102 flower \
 		$tcflags dst_ip 192.0.2.2 action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $swp1 ingress" 102 1
 	check_err $? "Packet was not dropped"
@@ -105,8 +105,8 @@ gact_drop_and_ok_test()
 	tc filter add dev $swp1 ingress protocol ip pref 1 handle 101 flower \
 		$tcflags dst_ip 192.0.2.2 action ok
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $swp1 ingress" 101 1
 	check_err $? "Did not see passed packet"
@@ -134,8 +134,8 @@ gact_trap_test()
 		$tcflags dst_ip 192.0.2.2 action mirred egress redirect \
 		dev $swp2
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $swp1 ingress" 101 1
 	check_fail $? "Saw packet without trap rule inserted"
@@ -143,8 +143,8 @@ gact_trap_test()
 	tc filter add dev $swp1 ingress protocol ip pref 2 handle 102 flower \
 		$tcflags dst_ip 192.0.2.2 action trap
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $swp1 ingress" 102 1
 	check_err $? "Packet was not trapped"
@@ -175,8 +175,8 @@ mirred_egress_to_ingress_test()
 	tc filter add dev $swp1 protocol ip pref 12 handle 112 ingress flower \
 		ip_proto icmp src_ip 192.0.2.1 dst_ip 192.0.2.2 type 0 action pass
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t icmp "ping,id=42,seq=10" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t icmp -q $h1 "ping,id=42,seq=10"
 
 	tc_check_packets "dev $h1 egress" 100 1
 	check_err $? "didn't mirror first packet"
@@ -230,8 +230,8 @@ mirred_egress_to_ingress_tcp_test()
 	cmp -s $mirred_e2i_tf1 $mirred_e2i_tf2
 	check_err $? "server output check failed"
 
-	$MZ $h1 -c 10 -p 64 -a $h1mac -b $h1mac -A 192.0.2.1 -B 192.0.2.1 \
-		-t icmp "ping,id=42,seq=5" -q
+	$MZ -c 10 -p 64 -a $h1mac -b $h1mac -A 192.0.2.1 -B 192.0.2.1 \
+		-t icmp -q $h1 "ping,id=42,seq=5"
 	tc_check_packets "dev $h1 egress" 101 10
 	check_err $? "didn't mirred redirect ICMP"
 	tc_check_packets "dev $h1 ingress" 102 10
@@ -254,8 +254,8 @@ ingress_2nd_vlan_push()
 		$tcflags num_of_vlans 2 \
 		cvlan_ethtype 0x800 action pass
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -Q 10 -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -Q 10 -q $h1
 
 	tc_check_packets "dev $swp1 ingress" 30 1
 	check_err $? "No double-vlan packets received"
@@ -276,8 +276,8 @@ egress_2nd_vlan_push()
 		$tcflags num_of_vlans 2 \
 		cvlan_ethtype 0x800 action pass
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $h1 egress" 30 1
 	check_err $? "No double-vlan packets received"
diff --git a/tools/testing/selftests/net/forwarding/tc_chains.sh b/tools/testing/selftests/net/forwarding/tc_chains.sh
index b95de0463ebd..95b194b5e092 100755
--- a/tools/testing/selftests/net/forwarding/tc_chains.sh
+++ b/tools/testing/selftests/net/forwarding/tc_chains.sh
@@ -38,8 +38,8 @@ unreachable_chain_test()
 	tc filter add dev $h2 ingress chain 1 protocol ip pref 1 handle 1101 \
 		flower $tcflags dst_mac $h2mac action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 1101 1
 	check_fail $? "matched on filter in unreachable chain"
@@ -61,8 +61,8 @@ gact_goto_chain_test()
 	tc filter add dev $h2 ingress protocol ip pref 1 handle 101 flower \
 		$tcflags dst_mac $h2mac action goto chain 1
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 102 1
 	check_fail $? "Matched on a wrong filter"
diff --git a/tools/testing/selftests/net/forwarding/tc_flower.sh b/tools/testing/selftests/net/forwarding/tc_flower.sh
index b58909a93112..899d452b9915 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower.sh
@@ -46,8 +46,8 @@ match_dst_mac_test()
 	tc filter add dev $h2 ingress protocol ip pref 2 handle 102 flower \
 		$tcflags dst_mac $h2mac action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
@@ -72,8 +72,8 @@ match_src_mac_test()
 	tc filter add dev $h2 ingress protocol ip pref 2 handle 102 flower \
 		$tcflags src_mac $h1mac action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
@@ -98,8 +98,8 @@ match_dst_ip_test()
 	tc filter add dev $h2 ingress protocol ip pref 3 handle 103 flower \
 		$tcflags dst_ip 192.0.2.0/24 action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
@@ -109,8 +109,8 @@ match_dst_ip_test()
 
 	tc filter del dev $h2 ingress protocol ip pref 2 handle 102 flower
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 103 1
 	check_err $? "Did not match on correct filter with mask"
@@ -132,8 +132,8 @@ match_src_ip_test()
 	tc filter add dev $h2 ingress protocol ip pref 3 handle 103 flower \
 		$tcflags src_ip 192.0.2.0/24 action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
@@ -143,8 +143,8 @@ match_src_ip_test()
 
 	tc filter del dev $h2 ingress protocol ip pref 2 handle 102 flower
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 103 1
 	check_err $? "Did not match on correct filter with mask"
@@ -168,8 +168,8 @@ match_ip_flags_test()
 	tc filter add dev $h2 ingress protocol ip pref 4 handle 104 flower \
 		$tcflags ip_flags nofrag action drop
 
-	$MZ $h1 -c 1 -p 1000 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip "frag=0" -q
+	$MZ -c 1 -p 1000 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1 "frag=0"
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on wrong frag filter (nofrag)"
@@ -183,8 +183,8 @@ match_ip_flags_test()
 	tc_check_packets "dev $h2 ingress" 104 1
 	check_err $? "Did not match on nofrag filter (nofrag)"
 
-	$MZ $h1 -c 1 -p 1000 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip "frag=0,mf" -q
+	$MZ -c 1 -p 1000 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip  -q $h1"frag=0,mf"
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_err $? "Did not match on frag filter (1stfrag)"
@@ -198,10 +198,10 @@ match_ip_flags_test()
 	tc_check_packets "dev $h2 ingress" 104 1
 	check_err $? "Match on wrong nofrag filter (1stfrag)"
 
-	$MZ $h1 -c 1 -p 1000 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip "frag=256,mf" -q
-	$MZ $h1 -c 1 -p 1000 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip "frag=256" -q
+	$MZ -c 1 -p 1000 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1 "frag=256,mf"
+	$MZ -c 1 -p 1000 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1 "frag=256"
 
 	tc_check_packets "dev $h2 ingress" 101 3
 	check_err $? "Did not match on frag filter (no1stfrag)"
@@ -234,8 +234,8 @@ match_pcp_test()
 	tc filter add dev $h2 ingress protocol 802.1q pref 2 handle 102 \
 		flower vlan_prio 7 $tcflags dst_mac $h2mac action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -B 192.0.2.11 -Q 7:85 -t ip -q
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -B 192.0.2.11 -Q 0:85 -t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -B 192.0.2.11 -Q 7:85 -t ip -q $h1
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -B 192.0.2.11 -Q 0:85 -t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 101 0
 	check_err $? "Matched on specified PCP when should not"
@@ -263,7 +263,7 @@ match_vlan_test()
 	tc filter add dev $h2 ingress protocol 802.1q pref 2 handle 102 \
 		flower vlan_id 85 $tcflags action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -B 192.0.2.11 -Q 0:85 -t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -B 192.0.2.11 -Q 0:85 -t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 101 0
 	check_err $? "Matched on specified VLAN when should not"
@@ -289,8 +289,8 @@ match_ip_tos_test()
 	tc filter add dev $h2 ingress protocol ip pref 2 handle 102 flower \
 		$tcflags dst_ip 192.0.2.2 ip_tos 0x18 action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip tos=18 -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1 tos=18
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter (0x18)"
@@ -298,8 +298,8 @@ match_ip_tos_test()
 	tc_check_packets "dev $h2 ingress" 102 1
 	check_err $? "Did not match on correct filter (0x18)"
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip tos=20 -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1 tos=20
 
 	tc_check_packets "dev $h2 ingress" 102 2
 	check_fail $? "Matched on a wrong filter (0x20)"
@@ -322,11 +322,11 @@ match_ip_ttl_test()
 	tc filter add dev $h2 ingress protocol ip pref 2 handle 102 flower \
 		$tcflags dst_ip 192.0.2.2 action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip "ttl=63" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1 "ttl=63"
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip "ttl=63,mf,frag=256" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1 "ttl=63,mf,frag=256"
 
 	tc_check_packets "dev $h2 ingress" 102 1
 	check_fail $? "Matched on the wrong filter (no check on ttl)"
@@ -334,8 +334,8 @@ match_ip_ttl_test()
 	tc_check_packets "dev $h2 ingress" 101 2
 	check_err $? "Did not match on correct filter (ttl=63)"
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip "ttl=255" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1 "ttl=255"
 
 	tc_check_packets "dev $h2 ingress" 101 3
 	check_fail $? "Matched on a wrong filter (ttl=63)"
@@ -358,8 +358,8 @@ match_indev_test()
 	tc filter add dev $h2 ingress protocol ip pref 2 handle 102 flower \
 		$tcflags indev $h2 dst_mac $h2mac action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
@@ -404,7 +404,7 @@ match_mpls_label_test()
 		flower $tcflags mpls_label 1048575 action drop
 
 	pkt="$ethtype $(mpls_lse 1048575 0 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter (1048575)"
@@ -413,7 +413,7 @@ match_mpls_label_test()
 	check_err $? "Did not match on correct filter (1048575)"
 
 	pkt="$ethtype $(mpls_lse 0 0 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 102 2
 	check_fail $? "Matched on a wrong filter (0)"
@@ -442,7 +442,7 @@ match_mpls_tc_test()
 		flower $tcflags mpls_tc 7 action drop
 
 	pkt="$ethtype $(mpls_lse 0 7 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter (7)"
@@ -451,7 +451,7 @@ match_mpls_tc_test()
 	check_err $? "Did not match on correct filter (7)"
 
 	pkt="$ethtype $(mpls_lse 0 0 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 102 2
 	check_fail $? "Matched on a wrong filter (0)"
@@ -480,7 +480,7 @@ match_mpls_bos_test()
 		flower $tcflags mpls_bos 1 action drop
 
 	pkt="$ethtype $(mpls_lse 0 0 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter (1)"
@@ -490,7 +490,7 @@ match_mpls_bos_test()
 
 	# Need to add a second label to properly mark the Bottom of Stack
 	pkt="$ethtype $(mpls_lse 0 0 0 255) $(mpls_lse 0 0 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 102 2
 	check_fail $? "Matched on a wrong filter (0)"
@@ -519,7 +519,7 @@ match_mpls_ttl_test()
 		flower $tcflags mpls_ttl 255 action drop
 
 	pkt="$ethtype $(mpls_lse 0 0 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter (255)"
@@ -528,7 +528,7 @@ match_mpls_ttl_test()
 	check_err $? "Did not match on correct filter (255)"
 
 	pkt="$ethtype $(mpls_lse 0 0 1 0)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 102 2
 	check_fail $? "Matched on a wrong filter (0)"
@@ -581,45 +581,45 @@ match_mpls_lse_test()
 
 	# Base packet, matched by all filters (except for stack depth 3)
 	pkt="$ethtype $(mpls_lse 0 0 0 0) $(mpls_lse 1048575 7 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	# Make a variant of the above packet, with a non-matching value
 	# for each LSE field
 
 	# Wrong label at depth 1
 	pkt="$ethtype $(mpls_lse 1 0 0 0) $(mpls_lse 1048575 7 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	# Wrong TC at depth 1
 	pkt="$ethtype $(mpls_lse 0 1 0 0) $(mpls_lse 1048575 7 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	# Wrong BOS at depth 1 (not adding a second LSE here since BOS is set
 	# in the first label, so anything that'd follow wouldn't be considered)
 	pkt="$ethtype $(mpls_lse 0 0 1 0)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	# Wrong TTL at depth 1
 	pkt="$ethtype $(mpls_lse 0 0 0 1) $(mpls_lse 1048575 7 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	# Wrong label at depth 2
 	pkt="$ethtype $(mpls_lse 0 0 0 0) $(mpls_lse 1048574 7 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	# Wrong TC at depth 2
 	pkt="$ethtype $(mpls_lse 0 0 0 0) $(mpls_lse 1048575 6 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	# Wrong BOS at depth 2 (adding a third LSE here since BOS isn't set in
 	# the second label)
 	pkt="$ethtype $(mpls_lse 0 0 0 0) $(mpls_lse 1048575 7 0 255)"
 	pkt="$pkt $(mpls_lse 0 0 1 255)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	# Wrong TTL at depth 2
 	pkt="$ethtype $(mpls_lse 0 0 0 0) $(mpls_lse 1048575 7 1 254)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	# Filters working at depth 1 should match all packets but one
 
@@ -707,12 +707,12 @@ match_erspan_opts_test()
 		enc_key_id 1002 erspan_opts 2:0:1:63 action drop
 
 	ep1mac=$(mac_get erspan1)
-	$MZ erspan1 -c 1 -p 64 -a $ep1mac -b $h2mac -t ip -q
+	$MZ -c 1 -p 64 -a $ep1mac -b $h2mac -t ip -q erspan1
 	tc_check_packets "dev ep-ex ingress" 101 1
 	check_err $? "ERSPAN Type II"
 
 	ep2mac=$(mac_get erspan2)
-	$MZ erspan2 -c 1 -p 64 -a $ep1mac -b $h2mac -t ip -q
+	$MZ -c 1 -p 64 -a $ep1mac -b $h2mac -t ip -q erspan2
 	tc_check_packets "dev ep-ex ingress" 102 1
 	check_err $? "ERSPAN Type III"
 
diff --git a/tools/testing/selftests/net/forwarding/tc_flower_cfm.sh b/tools/testing/selftests/net/forwarding/tc_flower_cfm.sh
index 3ca20df952eb..e2988d3b855f 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower_cfm.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower_cfm.sh
@@ -63,9 +63,9 @@ match_cfm_opcode()
 	   flower cfm op 43 action drop
 
 	pkt="$ethtype $(generate_cfm_hdr 7 47 0 32)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 	pkt="$ethtype $(generate_cfm_hdr 6 5 0 4)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_err $? "Did not match on correct opcode"
@@ -74,7 +74,7 @@ match_cfm_opcode()
 	check_err $? "Matched on the wrong opcode"
 
 	pkt="$ethtype $(generate_cfm_hdr 0 43 0 12)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_err $? "Matched on the wrong opcode"
@@ -101,11 +101,11 @@ match_cfm_level()
 	   flower cfm mdl 0 action drop
 
 	pkt="$ethtype $(generate_cfm_hdr 5 42 0 12)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 	pkt="$ethtype $(generate_cfm_hdr 6 1 0 70)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 	pkt="$ethtype $(generate_cfm_hdr 0 1 0 70)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_err $? "Did not match on correct level"
@@ -117,7 +117,7 @@ match_cfm_level()
 	check_err $? "Did not match on correct level"
 
 	pkt="$ethtype $(generate_cfm_hdr 3 0 0 4)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_err $? "Matched on the wrong level"
@@ -146,11 +146,11 @@ match_cfm_level_and_opcode()
 	   flower cfm mdl 7 op 42 action drop
 
 	pkt="$ethtype $(generate_cfm_hdr 5 41 0 4)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 	pkt="$ethtype $(generate_cfm_hdr 7 3 0 4)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 	pkt="$ethtype $(generate_cfm_hdr 3 42 0 12)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_err $? "Did not match on correct level and opcode"
@@ -159,7 +159,7 @@ match_cfm_level_and_opcode()
 	check_err $? "Matched on the wrong level and opcode"
 
 	pkt="$ethtype $(generate_cfm_hdr 7 42 0 12)"
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac "$pkt" -q
+	$MZ -c 1 -p 64 -a $h1mac -b $h2mac -q $h1 "$pkt"
 
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_err $? "Matched on the wrong level and opcode"
diff --git a/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh b/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
index c2420bb72c12..73ceb27a4d5a 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
@@ -86,7 +86,7 @@ test_l2_miss_unicast()
 	   dst_ip $dip action pass
 
 	# Before adding FDB entry.
-	$MZ $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
+	$MZ -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q $h1
 
 	tc_check_packets "dev $swp2 egress" 101 1
 	check_err $? "Unknown unicast filter was not hit before adding FDB entry"
@@ -97,7 +97,7 @@ test_l2_miss_unicast()
 	# Adding FDB entry.
 	bridge fdb replace $dmac dev $swp2 master static
 
-	$MZ $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
+	$MZ -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q $h1
 
 	tc_check_packets "dev $swp2 egress" 101 1
 	check_err $? "Unknown unicast filter was hit after adding FDB entry"
@@ -108,7 +108,7 @@ test_l2_miss_unicast()
 	# Deleting FDB entry.
 	bridge fdb del $dmac dev $swp2 master static
 
-	$MZ $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
+	$MZ -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q $h1
 
 	tc_check_packets "dev $swp2 egress" 101 2
 	check_err $? "Unknown unicast filter was not hit after deleting FDB entry"
@@ -143,7 +143,7 @@ test_l2_miss_multicast_common()
 	   action pass
 
 	# Before adding MDB entry.
-	$MZ $mode $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
+	$MZ $mode -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q $h1
 
 	tc_check_packets "dev $swp2 egress" 101 1
 	check_err $? "Unregistered multicast filter was not hit before adding MDB entry"
@@ -154,7 +154,7 @@ test_l2_miss_multicast_common()
 	# Adding MDB entry.
 	bridge mdb replace dev br1 port $swp2 grp $dip permanent
 
-	$MZ $mode $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
+	$MZ $mode -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q $h1
 
 	tc_check_packets "dev $swp2 egress" 101 1
 	check_err $? "Unregistered multicast filter was hit after adding MDB entry"
@@ -165,7 +165,7 @@ test_l2_miss_multicast_common()
 	# Deleting MDB entry.
 	bridge mdb del dev br1 port $swp2 grp $dip
 
-	$MZ $mode $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
+	$MZ $mode -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q $h1
 
 	tc_check_packets "dev $swp2 egress" 101 2
 	check_err $? "Unregistered multicast filter was not hit after deleting MDB entry"
@@ -255,7 +255,7 @@ test_l2_miss_ll_multicast_common()
 	   flower indev $swp1 l2_miss 1 dst_mac $dmac src_ip $sip \
 	   dst_ip $dip action pass
 
-	$MZ $mode $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
+	$MZ $mode -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q $h1
 
 	tc_check_packets "dev $swp2 egress" 101 1
 	check_err $? "Filter was not hit"
@@ -309,7 +309,7 @@ test_l2_miss_broadcast()
 	   flower l2_miss 0 dst_mac $dmac src_mac $smac \
 	   action pass
 
-	$MZ $h1 -a $smac -b $dmac -c 1 -p 100 -q
+	$MZ -a $smac -b $dmac -c 1 -p 100 -q $h1
 
 	tc_check_packets "dev $swp2 egress" 101 0
 	check_err $? "L2 miss filter was hit when should not"
diff --git a/tools/testing/selftests/net/forwarding/tc_flower_port_range.sh b/tools/testing/selftests/net/forwarding/tc_flower_port_range.sh
index baed5e380dae..6323567ca2fb 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower_port_range.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower_port_range.sh
@@ -103,22 +103,22 @@ __test_port_range()
 		dst_port $dport_min-$dport_max \
 		action drop
 
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$sport_min,dp=$dport_min"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$sport_min,dp=$dport_min"
 	tc_check_packets "dev $swp1 ingress" 101 1
 	check_err $? "Ingress filter not hit with minimum ports"
 	tc_check_packets "dev $swp2 egress" 101 1
 	check_err $? "Egress filter not hit with minimum ports"
 
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$sport_mid,dp=$dport_mid"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$sport_mid,dp=$dport_mid"
 	tc_check_packets "dev $swp1 ingress" 101 2
 	check_err $? "Ingress filter not hit with middle ports"
 	tc_check_packets "dev $swp2 egress" 101 2
 	check_err $? "Egress filter not hit with middle ports"
 
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$sport_max,dp=$dport_max"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$sport_max,dp=$dport_max"
 	tc_check_packets "dev $swp1 ingress" 101 3
 	check_err $? "Ingress filter not hit with maximum ports"
 	tc_check_packets "dev $swp2 egress" 101 3
@@ -126,16 +126,16 @@ __test_port_range()
 
 	# Send traffic when both ports are out of range and when only one port
 	# is out of range.
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$((sport_min - 1)),dp=$dport_min"
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$((sport_max + 1)),dp=$dport_min"
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$sport_min,dp=$((dport_min - 1))"
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$sport_min,dp=$((dport_max + 1))"
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$((sport_max + 1)),dp=$((dport_max + 1))"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$((sport_min - 1)),dp=$dport_min"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$((sport_max + 1)),dp=$dport_min"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$sport_min,dp=$((dport_min - 1))"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$sport_min,dp=$((dport_max + 1))"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$((sport_max + 1)),dp=$((dport_max + 1))"
 	tc_check_packets "dev $swp1 ingress" 101 3
 	check_err $? "Ingress filter was hit when should not"
 	tc_check_packets "dev $swp2 egress" 101 3
@@ -219,18 +219,18 @@ test_port_range_ipv4_udp_drop()
 		action drop
 
 	# Test ports outside range - should pass
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$((sport_min - 1)),dp=$dport"
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$((sport_max + 1)),dp=$dport"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$((sport_min - 1)),dp=$dport"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$((sport_max + 1)),dp=$dport"
 
 	# Test ports inside range - should be dropped
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$sport_min,dp=$dport"
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$sport_mid,dp=$dport"
-	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
-		-t $ip_proto "sp=$sport_max,dp=$dport"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$sport_min,dp=$dport"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$sport_mid,dp=$dport"
+	$MZ $mode -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto $h1 "sp=$sport_max,dp=$dport"
 
 	tc_check_packets "dev $swp1 ingress" 101 3
 	check_err $? "Filter did not drop the expected number of packets"
diff --git a/tools/testing/selftests/net/forwarding/tc_flower_router.sh b/tools/testing/selftests/net/forwarding/tc_flower_router.sh
index 4aee9c9e69f6..e0af18844581 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower_router.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower_router.sh
@@ -90,8 +90,8 @@ match_indev_egress_test()
 	tc filter add dev $rp3 egress protocol ip pref 2 handle 102 flower \
 		$tcflags indev $rp2 dst_ip 192.0.3.1 action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $rp1mac -A 192.0.1.1 -B 192.0.3.1 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $rp1mac -A 192.0.1.1 -B 192.0.3.1 \
+		-t ip -q $h1
 
 	tc_check_packets "dev $rp3 egress" 102 1
 	check_fail $? "Matched on a wrong filter"
@@ -99,8 +99,8 @@ match_indev_egress_test()
 	tc_check_packets "dev $rp3 egress" 101 1
 	check_err $? "Did not match on correct filter"
 
-	$MZ $h2 -c 1 -p 64 -a $h2mac -b $rp2mac -A 192.0.2.1 -B 192.0.3.1 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h2mac -b $rp2mac -A 192.0.2.1 -B 192.0.3.1 \
+		-t ip -q $h2
 
 	tc_check_packets "dev $rp3 egress" 101 2
 	check_fail $? "Matched on a wrong filter"
diff --git a/tools/testing/selftests/net/forwarding/tc_shblocks.sh b/tools/testing/selftests/net/forwarding/tc_shblocks.sh
index 772e00ac3230..37517e4b5df6 100755
--- a/tools/testing/selftests/net/forwarding/tc_shblocks.sh
+++ b/tools/testing/selftests/net/forwarding/tc_shblocks.sh
@@ -53,14 +53,14 @@ shared_block_test()
 	tc filter add block 22 protocol ip pref 1 handle 101 flower \
 		$tcflags dst_ip 192.0.2.2 action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $swmac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $swmac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "block 22" 101 1
 	check_err $? "Did not match first incoming packet on a block"
 
-	$MZ $h2 -c 1 -p 64 -a $h2mac -b $swmac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h2mac -b $swmac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h2
 
 	tc_check_packets "block 22" 101 2
 	check_err $? "Did not match second incoming packet on a block"
@@ -79,14 +79,14 @@ match_indev_test()
 	tc filter add block 22 protocol ip pref 2 handle 102 flower \
 		$tcflags indev $swp2 dst_mac $swmac action drop
 
-	$MZ $h1 -c 1 -p 64 -a $h1mac -b $swmac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h1mac -b $swmac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h1
 
 	tc_check_packets "block 22" 101 1
 	check_err $? "Did not match first incoming packet on a block"
 
-	$MZ $h2 -c 1 -p 64 -a $h2mac -b $swmac -A 192.0.2.1 -B 192.0.2.2 \
-		-t ip -q
+	$MZ -c 1 -p 64 -a $h2mac -b $swmac -A 192.0.2.1 -B 192.0.2.2 \
+		-t ip -q $h2
 
 	tc_check_packets "block 22" 102 1
 	check_err $? "Did not match second incoming packet on a block"
diff --git a/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh b/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
index 79775b10b99f..8c5205502827 100755
--- a/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
+++ b/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
@@ -114,11 +114,11 @@ tunnel_key_nofrag_test()
 	# test 'nofrag' set
 	tc filter add dev h1-et egress protocol all pref 1 handle 1 matchall $tcflags \
 		action tunnel_key set src_ip 192.0.2.1 dst_ip 192.0.2.2 id 42 nofrag index 10
-	$MZ h1-et -c 1 -p 930 -a 00:aa:bb:cc:dd:ee -b 00:ee:dd:cc:bb:aa -t ip -q
+	$MZ -c 1 -p 930 -a 00:aa:bb:cc:dd:ee -b 00:ee:dd:cc:bb:aa -t ip -q h1-et
 	tc_check_packets "dev $swp1 ingress" 100 1
 	check_err $? "packet smaller than MTU was not tunneled"
 
-	$MZ h1-et -c 1 -p 931 -a 00:aa:bb:cc:dd:ee -b 00:ee:dd:cc:bb:aa -t ip -q
+	$MZ -c 1 -p 931 -a 00:aa:bb:cc:dd:ee -b 00:ee:dd:cc:bb:aa -t ip -q h1-et
 	tc_check_packets "dev $swp1 ingress" 100 1
 	check_err $? "packet bigger than MTU matched nofrag (nofrag was set)"
 	tc_check_packets "dev $swp1 ingress" 101 0
@@ -128,7 +128,7 @@ tunnel_key_nofrag_test()
 
 	# test 'nofrag' cleared
 	tc actions change action tunnel_key set src_ip 192.0.2.1 dst_ip 192.0.2.2 id 42 index 10
-	$MZ h1-et -c 1 -p 931 -a 00:aa:bb:cc:dd:ee -b 00:ee:dd:cc:bb:aa -t ip -q
+	$MZ -c 1 -p 931 -a 00:aa:bb:cc:dd:ee -b 00:ee:dd:cc:bb:aa -t ip -q h1-et
 	tc_check_packets "dev $swp1  ingress" 100 1
 	check_err $? "packet bigger than MTU matched nofrag (nofrag was unset)"
 	tc_check_packets "dev $swp1  ingress" 101 1
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
index b43816dd998c..6913c0185262 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
@@ -395,7 +395,7 @@ vxlan_flood_test()
 	done
 
 	local -a t0s=($(flood_fetch_stats "${counters[@]}"))
-	$MZ $h1 -c 10 -d 100msec -p 64 -b $mac -B $dst -t icmp -q
+	$MZ -c 10 -d 100msec -p 64 -b $mac -B $dst -t icmp -q $h1
 	sleep 1
 	local -a t1s=($(flood_fetch_stats "${counters[@]}"))
 
@@ -567,9 +567,9 @@ vxlan_encapped_ping_do()
 	local inner_tos=$1; shift
 	local outer_tos=$1; shift
 
-	$MZ $dev -c $count -d 100msec -q \
+	$MZ -c $count -d 100msec -q \
 		-b $next_hop_mac -B $dest_ip \
-		-t udp tos=$outer_tos,sp=23456,dp=$VXPORT,p=$(:
+		-t udp $dev tos=$outer_tos,sp=23456,dp=$VXPORT,p=$(:
 		    )"08:"$(                      : VXLAN flags
 		    )"00:00:00:"$(                : VXLAN reserved
 		    )"00:03:e8:"$(                : VXLAN VNI
@@ -705,8 +705,8 @@ test_learning()
 	# a corresponding entry is created in VxLAN device vx1
 	RET=0
 
-	in_ns ns1 $MZ w2 -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff -B $dst \
-		-t icmp -q
+	in_ns ns1 $MZ -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff -B $dst \
+		-t icmp -q w2
 	sleep 1
 
 	bridge fdb show brport vx1 | grep $mac | grep -q self
@@ -737,8 +737,8 @@ test_learning()
 	# Re-learn the first FDB entry and check that it is correctly aged-out
 	RET=0
 
-	in_ns ns1 $MZ w2 -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff -B $dst \
-		-t icmp -q
+	in_ns ns1 $MZ -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff -B $dst \
+		-t icmp -q w2
 	sleep 1
 
 	bridge fdb show brport vx1 | grep $mac | grep -q self
@@ -749,7 +749,7 @@ test_learning()
 	vxlan_flood_test $mac $dst 0 10 0
 
 	# The entry should age out when it only forwards traffic
-	$MZ $h1 -c 50 -d 1sec -p 64 -b $mac -B $dst -t icmp -q &
+	$MZ -c 50 -d 1sec -p 64 -b $mac -B $dst -t icmp -q $h1 &
 	sleep 60
 
 	bridge fdb show brport vx1 | grep $mac | grep -q self
@@ -767,8 +767,8 @@ test_learning()
 
 	ip link set dev vx1 type bridge_slave learning off
 
-	in_ns ns1 $MZ w2 -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff -B $dst \
-		-t icmp -q
+	in_ns ns1 $MZ -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff -B $dst \
+		-t icmp -q w2
 	sleep 1
 
 	bridge fdb show brport vx1 | grep $mac | grep -q -v self
@@ -776,8 +776,8 @@ test_learning()
 
 	ip link set dev vx1 type bridge_slave learning on
 
-	in_ns ns1 $MZ w2 -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff -B $dst \
-		-t icmp -q
+	in_ns ns1 $MZ -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff -B $dst \
+		-t icmp -q w2
 	sleep 1
 
 	bridge fdb show brport vx1 | grep $mac | grep -q -v self
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
index a603f7b0a08f..988b13fe0355 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
@@ -516,7 +516,7 @@ vxlan_flood_test()
 	done
 
 	local -a t0s=($(flood_fetch_stats "${counters[@]}"))
-	$MZ -6 $h1 -c 10 -d 100msec -p 64 -b $mac -B $dst -t icmp6 type=128 -q
+	$MZ -6 -c 10 -d 100msec -p 64 -b $mac -B $dst -t icmp6 -q $h1 type=128
 	sleep 1
 	local -a t1s=($(flood_fetch_stats "${counters[@]}"))
 
@@ -682,9 +682,9 @@ vxlan_encapped_ping_do()
 	local saddr="20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:03"
 	local daddr="20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:01"
 
-	$MZ -6 $dev -c $count -d 100msec -q \
+	$MZ -6 -c $count -d 100msec -q \
 		-b $next_hop_mac -B $dest_ip \
-		-t udp tos=$outer_tos,sp=23456,dp=$VXPORT,p=$(:
+		-t udp $dev tos=$outer_tos,sp=23456,dp=$VXPORT,p=$(:
 		    )"08:"$(                      : VXLAN flags
 		    )"00:00:00:"$(                : VXLAN reserved
 		    )"00:03:e8:"$(                : VXLAN VNI
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh
index afc65647f673..17333e5ad94a 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh
@@ -500,7 +500,7 @@ vxlan_flood_test()
 	done
 
 	local -a t0s=($(flood_fetch_stats "${counters[@]}"))
-	$MZ $h1 -Q $vid -c 10 -d 100msec -p 64 -b $mac -B $dst -t icmp -q
+	$MZ -Q $vid -c 10 -d 100msec -p 64 -b $mac -B $dst -t icmp -q $h1
 	sleep 1
 	local -a t1s=($(flood_fetch_stats "${counters[@]}"))
 
@@ -717,8 +717,8 @@ __test_learning()
 	# a corresponding entry is created in the VxLAN device
 	RET=0
 
-	in_ns ns1 $MZ w2 -Q $vid -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff \
-		-B $dst -t icmp -q
+	in_ns ns1 $MZ -Q $vid -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff \
+		-B $dst -t icmp -q w2
 	sleep 1
 
 	bridge fdb show brport $vx | grep $mac | grep -q self
@@ -752,8 +752,8 @@ __test_learning()
 	# Re-learn the first FDB entry and check that it is correctly aged-out
 	RET=0
 
-	in_ns ns1 $MZ w2 -Q $vid -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff \
-		-B $dst -t icmp -q
+	in_ns ns1 $MZ -Q $vid -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff \
+		-B $dst -t icmp -q w2
 	sleep 1
 
 	bridge fdb show brport $vx | grep $mac | grep -q self
@@ -784,8 +784,8 @@ __test_learning()
 
 	ip link set dev $vx type bridge_slave learning off
 
-	in_ns ns1 $MZ w2 -Q $vid -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff \
-		-B $dst -t icmp -q
+	in_ns ns1 $MZ -Q $vid -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff \
+		-B $dst -t icmp -q w2
 	sleep 1
 
 	bridge fdb show brport $vx | grep $mac | grep "vlan $vid" \
@@ -794,8 +794,8 @@ __test_learning()
 
 	ip link set dev $vx type bridge_slave learning on
 
-	in_ns ns1 $MZ w2 -Q $vid -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff \
-		-B $dst -t icmp -q
+	in_ns ns1 $MZ -Q $vid -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff \
+		-B $dst -t icmp -q w2
 	sleep 1
 
 	bridge fdb show brport $vx | grep $mac | grep "vlan $vid" \
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh
index e83fde79f40d..5af514884e2c 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh
@@ -642,7 +642,7 @@ vxlan_flood_test()
 	done
 
 	local -a t0s=($(flood_fetch_stats "${counters[@]}"))
-	$MZ -6 $h1 -Q $vid -c 10 -d 100msec -p 64 -b $mac -B $dst -t icmp6 type=128 -q
+	$MZ -6 -Q $vid -c 10 -d 100msec -p 64 -b $mac -B $dst -t icmp6 -q $h1 type=128
 	sleep 1
 	local -a t1s=($(flood_fetch_stats "${counters[@]}"))
 
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index 462db0b603e7..5cc2a7f090e3 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -471,8 +471,8 @@ do_packets_v4()
 	local mac
 
 	mac=$(mac_get "$h2")
-	"$MZ" "$h1" -Q 10 -c 10 -d 100msec -p 64 -a own -b "$mac" \
-	    -A 192.0.2.1 -B 192.0.2.2 -t udp sp=1234,dp=2345 -q
+	"$MZ" -Q 10 -c 10 -d 100msec -p 64 -a own -b "$mac" \
+	    -A 192.0.2.1 -B 192.0.2.2 -t udp -q "$h1" sp=1234,dp=2345
 }
 
 do_packets_v6()
@@ -480,8 +480,8 @@ do_packets_v6()
 	local mac
 
 	mac=$(mac_get "$h2")
-	"$MZ" -6 "$h1" -Q 20 -c 10 -d 100msec -p 64 -a own -b "$mac" \
-	    -A 2001:db8:1::1 -B 2001:db8:1::2 -t udp sp=1234,dp=2345 -q
+	"$MZ" -6 -Q 20 -c 10 -d 100msec -p 64 -a own -b "$mac" \
+	    -A 2001:db8:1::1 -B 2001:db8:1::2 -t udp -q "$h1" sp=1234,dp=2345
 }
 
 do_test()
diff --git a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
index 46c31794b91b..6713468bc170 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
@@ -167,9 +167,9 @@ vxlan_ping_do()
 
 	local vxlan_header=$(vxlan_header_bytes $vni $reserved_bits)
 
-	$MZ $dev -c $count -d 100msec -q \
+	$MZ -c $count -d 100msec -q \
 		-b $next_hop_mac -B $dest_ip \
-		-t udp sp=23456,dp=$VXPORT,p=$(:
+		-t udp $dev sp=23456,dp=$VXPORT,p=$(:
 		    )"$vxlan_header:"$(              : VXLAN
 		    )"$dest_mac:"$(                  : ETH daddr
 		    )"00:11:22:33:44:55:"$(          : ETH saddr
-- 
2.50.1



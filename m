Return-Path: <linux-kselftest+bounces-39363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F834B2D7E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 11:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788233A8644
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EC02E0B48;
	Wed, 20 Aug 2025 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx07cx4r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BD2E0929;
	Wed, 20 Aug 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681033; cv=none; b=Ndp3KbigG5rf2pHZd2FJuDNLPX07SV4buRYg2QBla95pqSjrGNhgGCt25G35lgnM31PcysMv0PmGxSPhEoKTL9rbGvf94q4t5GVCIfye/jAUn/SOQqW3wyEkDtsVaVhEvyMl1IUf+v+aRh4VS0grPunpCwlLrcT7LH80QQS2JdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681033; c=relaxed/simple;
	bh=/thcb+3mDW4iewUO2/TOpZJ9EeJ+IS4UTOXS81L2ycc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWKODTE/qF3MfZa05se5y+2XexRi5HmDPvyVSNYMC4M5hsEvW8H7HNcJqpZqP5osSj9IwlRtWg/96nZ9rxrj+n8l1qulPG5QFxO+pWcYSSNfkah77ByV5hhIgdp7trQNw1pSOZzvjzTzZM3GXa2O7fVjFVLoDmru+MozSrYbGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx07cx4r; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b47174c3817so4527790a12.2;
        Wed, 20 Aug 2025 02:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681030; x=1756285830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQxXSeNIAFTRnTqLd66s7on602VUGsmmUF705W9TdgA=;
        b=mx07cx4rV/s+SSsMp+UIHMd/YONqaCvIlXfNvslDxC7HdCVDkzsf4upjU/F1qJ2+gR
         cxgl9pqcjb8uxk41WIxleQua8JlXUXq9or0BNQ4WVdw9QKbtGzYzOsuRjyIxuJfpfS18
         w/M3fe8DIr9V1osa5XdFKpSVmb8rN1GKRSsJ5LQiTIW3b2FNXWyKWjwYYBm4CzrgH4Ox
         ncTXgq64dRbZbTCWeKbWsfKsJRkGrZeJwRNd4P5A5vvNMtxbCKn55/t/xdIN7tzZwaFQ
         40lY4dpaim15Dybx/xaNachvKZCMLkA1WgCJ4RN4WtPx3zi4f664UXwniiecI9rHJCDn
         bk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681030; x=1756285830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQxXSeNIAFTRnTqLd66s7on602VUGsmmUF705W9TdgA=;
        b=l6nY6mmsRqXHqDdpaAwnYgsiVYsA2HJ4ECtssQf25AeiTXuFxk+TRlHkz2PeY7p+3E
         /PgeLBa+1skT5uY43oPuyLqFKJhVhRN1+l60Rp5rnUsCaHvjHDyolAQbfI2Xu5/JPIgc
         kQBk6wojR0ed86Mi+hl1vNx9+Kv5W/qqAjmFiBgQ9FeMpMJQl8EDHNDMuXrhXaS4U3JE
         JMmtWrfp1rdCqkggPf5SozT6fy/Wn0ywqHeLxk8xLvUzoG8xNDoYd0vIsPNYcrPLPM8d
         0sZVuUoy6qvb+3Zl96+5Hp6mJkhR1Bdt+xgNaot3N0jRjrjOoP1eilQftvb1tDCimshu
         rJqg==
X-Forwarded-Encrypted: i=1; AJvYcCUo3huD+g8yqSzbLgYnAz6bVn4gh/xiAHTPy9Xzylbj8HtOVfa8TTcWMtf8yLZFA32xELeQHXJUiAcGB0EAo/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0lTpLmXy71YI7DHmZtPsu1goWViexq8158s+LlOAheQ9LGnB
	PN6uAXDitKhR2B+bh05RV+V9YMmszTDETbVOgBK+r61kZx9Lvi5zm5ddoaA054Cv
X-Gm-Gg: ASbGncu3YmQqOTLBTCXM7IF8NoK3jmM/uvvgQbSr3kwZ83UZRwWxqugXPTn1k07E2Oq
	JsL611uCcAYOjtj9rw/kBNd+6iYLhjgbSp0eNQdh6Nm2QVthz19stSydBqY6INHQ2NVZ6hvykY3
	Hvf9biaazyljZ3GoG7BylufV15nt9FhXCwefKImdSkL8NwyNs/Rz8Hm+lBym3YTlgyMQbVnr1dy
	pUQcqzxosvaRqCFcgBH+gl1gwk/LHoILRqzN/a4GJS2n+kYQiHV+J+HwrhsJDpsneFyIMkBPbj+
	lg8Nx0de1PQG8KUrGXtKJe+jlJEMSh7j8+Ae972e+6laUdos/CXHP/KvJSZm08cxRCxaMD82//A
	La82MMvJ7pt1s6Ksk4pGO3hgnoNN+MmiUtqoHdWzOYg==
X-Google-Smtp-Source: AGHT+IE6i3gLGjJlSC7BNqEKpAz1LzHuAoUwR6zaioxnVxkbJcMOVZ4T6nSXI8ubktdUxJggfnkqgA==
X-Received: by 2002:a17:902:d4d1:b0:243:485:269d with SMTP id d9443c01a7336-245ef2270f7mr30115615ad.31.1755681030336;
        Wed, 20 Aug 2025 02:10:30 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed339fb3sm20765765ad.13.2025.08.20.02.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:10:29 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 2/2] selftests: bonding: add fail_over_mac testing
Date: Wed, 20 Aug 2025 09:10:09 +0000
Message-ID: <20250820091009.393785-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820091009.393785-1-liuhangbin@gmail.com>
References: <20250820091009.393785-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to check each value of bond fail_over_mac option.

Also fix a minor garp_test print issue.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../drivers/net/bonding/bond_options.sh       | 139 +++++++++++++++++-
 .../drivers/net/bonding/bond_topo_2d1c.sh     |   3 +
 .../drivers/net/bonding/bond_topo_3d1c.sh     |   2 +
 3 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index 7bc148889ca7..e3f3cc803b56 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -7,6 +7,7 @@ ALL_TESTS="
 	prio
 	arp_validate
 	num_grat_arp
+	fail_over_mac
 "
 
 lib_dir=$(dirname "$0")
@@ -352,8 +353,8 @@ garp_test()
 
 	exp_num=$(echo "${param}" | cut -f6 -d ' ')
 	active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
-	slowwait_for_counter $((exp_num + 5)) $exp_num \
-		tc_rule_handle_stats_get "dev s${active_slave#eth} ingress" 101 ".packets" "-n ${g_ns}"
+	slowwait_for_counter $((exp_num + 5)) $exp_num tc_rule_handle_stats_get \
+		"dev s${active_slave#eth} ingress" 101 ".packets" "-n ${g_ns}" &> /dev/null
 
 	# check result
 	real_num=$(tc_rule_handle_stats_get "dev s${active_slave#eth} ingress" 101 ".packets" "-n ${g_ns}")
@@ -376,6 +377,140 @@ num_grat_arp()
 	done
 }
 
+check_all_mac_same()
+{
+	RET=0
+	# all slaves should have same mac address (with the first port's mac)
+	local bond_mac=$(ip -n "$s_ns" -j link show bond0 | jq -r '.[]["address"]')
+	local eth0_mac=$(ip -n "$s_ns" -j link show eth0 | jq -r '.[]["address"]')
+	local eth1_mac=$(ip -n "$s_ns" -j link show eth1 | jq -r '.[]["address"]')
+	local eth2_mac=$(ip -n "$s_ns" -j link show eth2 | jq -r '.[]["address"]')
+	if [ "$bond_mac" != "${mac[0]}" ] || [ "$eth0_mac" != "$bond_mac" ] || \
+		[ "$eth1_mac" != "$bond_mac" ] || [ "$eth2_mac" != "$bond_mac" ]; then
+		RET=1
+	fi
+}
+
+check_bond_mac_same_with_first()
+{
+	RET=0
+	# bond mac address should be same with the first added slave
+	local bond_mac=$(ip -n "$s_ns" -j link show bond0 | jq -r '.[]["address"]')
+	if [ "$bond_mac" != "${mac[0]}" ]; then
+		RET=1
+	fi
+}
+
+check_bond_mac_same_with_active()
+{
+	RET=0
+	# bond mac address should be same with active slave
+	local bond_mac=$(ip -n "$s_ns" -j link show bond0 | jq -r '.[]["address"]')
+	local active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
+	local active_slave_mac=$(ip -n "$s_ns" -j link show "$active_slave" | jq -r '.[]["address"]')
+	if [ "$bond_mac" != "$active_slave_mac" ]; then
+		RET=1
+	fi
+}
+
+check_backup_slave_mac_not_change()
+{
+	RET=0
+	# backup slave's mac address is not changed
+	if ip -n "$s_ns" -d -j link show type bond_slave | jq -e '.[]
+		| select(.linkinfo.info_slave_data.state=="BACKUP")
+		| select(.address != .linkinfo.info_slave_data.perm_hwaddr)' &> /dev/null; then
+		RET=1
+	fi
+}
+
+check_backup_slave_mac_inherit()
+{
+	local backup_mac
+	RET=0
+
+	# backup slaves should use mac[1] or mac[2]
+	local backup_macs=$(ip -n "$s_ns" -d -j link show type bond_slave | \
+		jq -r '.[] | select(.linkinfo.info_slave_data.state=="BACKUP") | .address')
+	for backup_mac in $backup_macs; do
+		if [ "$backup_mac" != "${mac[1]}" ] && [ "$backup_mac" != "${mac[2]}" ]; then
+			RET=1
+		fi
+	done
+}
+
+check_first_slave_random_mac()
+{
+	RET=0
+	# remove the first added slave and added it back
+	ip -n "$s_ns" link set eth0 nomaster
+	ip -n "$s_ns" link set eth0 master bond0
+
+	# the first slave should use random mac address
+	eth0_mac=$(ip -n "$s_ns" -j link show eth0 | jq -r '.[]["address"]')
+	[ "$eth0_mac" = "${mac[0]}" ] && RET=1
+	log_test "bond fail_over_mac follow" "random first slave mac"
+
+	# remove the first slave, the permanent MAC address should be restored back
+	ip -n "$s_ns" link set eth0 nomaster
+	eth0_mac=$(ip -n "$s_ns" -j link show eth0 | jq -r '.[]["address"]')
+	[ "$eth0_mac" != "${mac[0]}" ] && RET=1
+}
+
+do_active_backup_failover()
+{
+	local active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
+	ip -n ${s_ns} link set ${active_slave} down
+	slowwait 2 active_slave_changed $active_slave
+	ip -n ${s_ns} link set ${active_slave} up
+}
+
+fail_over_mac()
+{
+	# Bring down the first interface on the switch to force the bond to
+	# select another active interface instead of the first one that joined.
+	ip -n "$g_ns" link set s0 down
+
+	# fail_over_mac none
+	bond_reset "mode active-backup miimon 100 fail_over_mac 0"
+	check_all_mac_same
+	log_test "fail_over_mac 0" "all slaves have same mac"
+	do_active_backup_failover
+	check_all_mac_same
+	log_test "fail_over_mac 0" "failover: all slaves have same mac"
+
+	# fail_over_mac active
+	bond_reset "mode active-backup miimon 100 fail_over_mac 1"
+	check_bond_mac_same_with_active
+	log_test "fail_over_mac 1" "bond mac is same with active slave mac"
+	check_backup_slave_mac_not_change
+	log_test "fail_over_mac 1" "backup slave mac is not changed"
+	do_active_backup_failover
+	check_bond_mac_same_with_active
+	log_test "fail_over_mac 1" "failover: bond mac is same with active slave mac"
+	check_backup_slave_mac_not_change
+	log_test "fail_over_mac 1" "failover: backup slave mac is not changed"
+
+	# fail_over_mac follow
+	bond_reset "mode active-backup miimon 100 fail_over_mac 2"
+	check_bond_mac_same_with_first
+	log_test "fail_over_mac 2" "bond mac is same with first slave mac"
+	check_bond_mac_same_with_active
+	log_test "fail_over_mac 2" "bond mac is same with active slave mac"
+	check_backup_slave_mac_inherit
+	log_test "fail_over_mac 2" "backup slave mac inherit"
+	do_active_backup_failover
+	check_bond_mac_same_with_first
+	log_test "fail_over_mac 2" "failover: bond mac is same with first slave mac"
+	check_bond_mac_same_with_active
+	log_test "fail_over_mac 2" "failover: bond mac is same with active slave mac"
+	check_backup_slave_mac_inherit
+	log_test "fail_over_mac 2" "failover: backup slave mac inherit"
+	check_first_slave_random_mac
+	log_test "fail_over_mac 2" "first slave mac random"
+
+}
+
 trap cleanup EXIT
 
 setup_prepare
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
index 195ef83cfbf1..167aa4a4a12a 100644
--- a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
@@ -39,6 +39,8 @@ g_ip4="192.0.2.254"
 s_ip6="2001:db8::1"
 c_ip6="2001:db8::10"
 g_ip6="2001:db8::254"
+mac[0]="00:0a:0b:0c:0d:01"
+mac[1]="00:0a:0b:0c:0d:02"
 
 gateway_create()
 {
@@ -62,6 +64,7 @@ server_create()
 
 	for i in $(seq 0 1); do
 		ip -n ${s_ns} link add eth${i} type veth peer name s${i} netns ${g_ns}
+		ip -n "${s_ns}" link set "eth${i}" addr "${mac[$i]}"
 
 		ip -n ${g_ns} link set s${i} up
 		ip -n ${g_ns} link set s${i} master br0
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_3d1c.sh b/tools/testing/selftests/drivers/net/bonding/bond_topo_3d1c.sh
index 3a1333d9a85b..23a2932301cc 100644
--- a/tools/testing/selftests/drivers/net/bonding/bond_topo_3d1c.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_topo_3d1c.sh
@@ -26,6 +26,7 @@
 #  +-------------------------------------+
 
 source bond_topo_2d1c.sh
+mac[2]="00:0a:0b:0c:0d:03"
 
 setup_prepare()
 {
@@ -36,6 +37,7 @@ setup_prepare()
 	# Add the extra device as we use 3 down links for bond0
 	local i=2
 	ip -n ${s_ns} link add eth${i} type veth peer name s${i} netns ${g_ns}
+	ip -n "${s_ns}" link set "eth${i}" addr "${mac[$i]}"
 	ip -n ${g_ns} link set s${i} up
 	ip -n ${g_ns} link set s${i} master br0
 	ip -n ${s_ns} link set eth${i} master bond0
-- 
2.50.1



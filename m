Return-Path: <linux-kselftest+bounces-41095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 908F7B50BAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 04:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423591C63EA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2629E0EE;
	Wed, 10 Sep 2025 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCeZ1o6J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945F29BD9E;
	Wed, 10 Sep 2025 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472263; cv=none; b=XdeaMsFWeXvLuHtayEmEPkZgXlI5FG4ImvAqIXgu5Mdn2Ec9D8v9YktTAVremZdkm6UfA5uO7rXjWRlvDKbB+kguz5W4gMijCkOmtoezeo03WgiTs4Ua1hmp3ebqls6jCqB6NLHW31keogxfF/4sDRbQ4y0Wc6sI5ukN7jSNhus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472263; c=relaxed/simple;
	bh=/thcb+3mDW4iewUO2/TOpZJ9EeJ+IS4UTOXS81L2ycc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXbCd3IAQBLehTcc8q3FKXhdGZ3FWDzjXUGgntfPvV3NPz3iYFG/vt1XOyuZ+W7Q7fhGiFSufqGLox5tfodvEv7JFO3WCmJ0bA558J9yktLeKn9Ia5D5x1FKdrC2VH4VSX8vxtUiabZ3yLvgLiVaVUBvMZDXdvNmD9chx9JOhjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCeZ1o6J; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32d3e17d927so4159130a91.2;
        Tue, 09 Sep 2025 19:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472261; x=1758077061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQxXSeNIAFTRnTqLd66s7on602VUGsmmUF705W9TdgA=;
        b=VCeZ1o6Jk0mOvL1hZ/YOMSsrW+MT+YXFw3KYkyiGT6i7HZb0r1cd5niLvs/WmX1ve7
         r2X730gyJYd+cheYrs+FIzNaaNW/uUk8NaExetp9YsCyN5suuWoXKTNBct1LhUNtVGAd
         p3+VRCGzvZP10mlx1KvAW2s+z07YRBMtPaYapHtZsC7HnZBNOY4ak7tX0aNOL3zNkIlC
         aMQejC8GGEUBGpDz/uod+aef1Ia7avDIlSI9jHONOlHg4/Vh1Zm6b7Ef4F+bJboywQq8
         tF476ndaRxpw0cU2CgvZXfrceBxBzt5FuaLgFKZSdUR83yJ+iPKp+TIdVY0qoEGoKp8m
         UVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472261; x=1758077061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQxXSeNIAFTRnTqLd66s7on602VUGsmmUF705W9TdgA=;
        b=hYLgjKUd8hI65dBvMpR2NaLw/uAvYdWbzGzMpA0peXAdlNPIqGdztrn48JUSxakvLt
         qRtysgCWxwMCkud5OUiXNLL3zYX/Yi+wHmQtEmyxdPNtJoagp6VjOPP+diDkffp/DBsh
         iwJwVeJdk5SujYF6TtOYuWewicFbvHeibi9QpairNywHNNvDAr6cXtnBhxCj2RU9xFpH
         miwKBM+04p2Y5+xn2R0oSRxMIaHc/t2Fr72DUg5ikto/4NI4zFBPdH1bbbl71cId2O26
         p3C6jQbGDURnypucQ0bd93qoDZOiuJq6oJ+WqCwUUXbaTD8dHtxQzmpp/hBMdixEQ6FY
         DfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkbADa+ifVuJZzrGZnej1uVlCVllQWM/0WPCkiZVwEYsLBt1/Bsr414NdRdojls0JJIoy+CFojFDfQweDHQXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpx1gsGfBc0uIgkN/JLSjJiWKOLWQHFd7oaWB1NhqeNiL5Icf6
	s+79d4pGfWBoqcKkJvsOpRBJUrx3vT+JjjyyQNHWwyTZ1bd7B7yjzgjLNK3g7BRZ
X-Gm-Gg: ASbGnct6h+aXir628oh6rrmiqoL4Cv3gpatjUHthrtA1kJsUyztTqCqdldnIZVGw1qR
	Dm6QSwyJcN1fAG9Ysfgv6fSm0j18kCBxxDr9h056FJBz/UmVDYSO6WVU94D/hBeW3lrVjEmDcbl
	TslocU+n9vqBTD3ldxzXmVELx4k7tNSc8Oa1MOwjxz+qBvJG3xtrKi7QCI7rg020Hm+V7PVHR2W
	Rq64n19Sq1WlXcG8hfTnxb57JJUX5FlS3NrZN9hRuHYrWGo/zjDUpFRFS6LKBCY2jvgAdey3wWV
	Zyx7XmuZ4kKDHwE+7HJJbGf8Xu2OTQo2V9ZGjVDcveiH/nyLeAa4ZItfXxD+StTwXrIAEYZGRAh
	6dQy0ovgTHagnfU+gv5T1lLrE+sIJa08pFaLC+5IDug==
X-Google-Smtp-Source: AGHT+IEPQU+1Tgg9LK8UbuwhgUqRHPM8S8GDWaJZOZaXwItMfU5OmDC+azsspDneCYTT0ATKLUQeag==
X-Received: by 2002:a17:90b:1d4f:b0:32b:dbf1:319e with SMTP id 98e67ed59e1d1-32d43f8fa03mr19915113a91.23.1757472261028;
        Tue, 09 Sep 2025 19:44:21 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a3f3facsm1065784a12.7.2025.09.09.19.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:44:20 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 2/2] selftests: bonding: add fail_over_mac testing
Date: Wed, 10 Sep 2025 02:43:35 +0000
Message-ID: <20250910024336.400253-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250910024336.400253-1-liuhangbin@gmail.com>
References: <20250910024336.400253-1-liuhangbin@gmail.com>
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



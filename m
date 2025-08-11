Return-Path: <linux-kselftest+bounces-38679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72254B20B5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 16:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632D37B8710
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BC7213E66;
	Mon, 11 Aug 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0WT43Fo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F56217F31;
	Mon, 11 Aug 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921053; cv=none; b=XG9nchY2fvwWnHs5MFZGrhd1GXj+ioAe6FdD63g1Y0w1oOwLLXkvIV6yp9sjjffZMXaPNNL8CKu3ViaxEstNoabmQvH8ro4XIr7fuopy74NH+gGu4AnFGu3j5yc4ARplb+oOs9I4hEe6Hi0V5hINLfvddBrTfOStgvZjmj/Lrg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921053; c=relaxed/simple;
	bh=mXwKUoupJ3wcYimchFtZm4XvN6flNnsEmm9x3gjjKUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sefsdlRSpM9JeJGNh018ROvtOsUtuj5s83gzrOUIsx7ETh3HCZmbVX2xojnrKelamRCgQaptUhaEqr/7+nE7CkhgTojtBIcQuPtkIcmtJ2Vj7KgPOy4lmfNZKvsqRABpi3o98l145vM2csNwqwyUb6F4Gif9598kUMly+Uj2THI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0WT43Fo; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso3767483b3a.1;
        Mon, 11 Aug 2025 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754921050; x=1755525850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XFbP9as/6/WzUolljTsSYlDm/m7iC8iIjpoQqE89mJk=;
        b=X0WT43FoFiBbnzwLnW1XAemz3YaYtcNsZwpGgmT/sIUDLcd+/E8yRdUd9T50+2bA1G
         a1IWeV6qeZM3VC1OUErmYvExLhuliLKvufTFxNLbZcC61DITwP0L28QG2esla3wbd3fJ
         azKuPGR2NfiQ0Oeiofmlj0VyAfrCTmlIDIO2ydL8/6rZ10Qu6uDtyXs8zFSLcjdufBsg
         R7KCjZjBrkcXS7V/6B/Y+mpQxwBGdYu+ZUiCrTEv5wJ2gdjEL6+l/RMDWTrw/O62Pl2L
         hpcuifw6wbI1dGtHqIVSdbsL9JvIizPPd37LJrob8f9FyDhLdNX9DaVHVCt30jJvB2g6
         Oq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921050; x=1755525850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFbP9as/6/WzUolljTsSYlDm/m7iC8iIjpoQqE89mJk=;
        b=ZWJM+h2xjOH7t8cGX+MLuW0rx+SyyLnaR7VujZ7TGqtxMCaQD9eze+b/WQWs152eFF
         X2n8u+XHYHDhXDuoZ9x6gCIYLzAElaZOHOEaMjonmzdOgvXDM4INogyC+vvaAaYzWNCL
         pZqOD0twAyas2bEre3JEe/QekqskiqS9NHZi3VgrbrXJRoNO4Z+YdBn/7xPwvD0Z2Wk6
         ZcEQxcYtI3ACPhvP1VJQOawyQrT7Yu+nw884fE6a8P5Dt+yk3XJHV9my6st/UiTbbR6h
         Bzj7ZPHiyYvQjzJAs7V5x8vrGTJg/PpybDX3nUiiC56WucWU9YB97Nz+JKD/26a3Yrt3
         gFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrjlkybcZrPZpXP9NlRRmF2fdvW9KDstcbLAkbRHyArV+2r+fbpZqXOmt7VcaIr7TO3uw31JMyntvD3hs=@vger.kernel.org, AJvYcCWw3K8aeOOiA8IkYKW52mG4lwNermJqC/BnSvX0+1HHG31aZFwgvaIXFuuoZK06EzQ0nphjKi9H1gEtDSUer2MR@vger.kernel.org
X-Gm-Message-State: AOJu0YxlhGESv1AcYahFlqrUvKNFE+Peds9mUHQQzuTH0P2+J6SdzjmW
	LyesYV79GYmNM0V3KyR6Or0ZZ1n7V851WpGtewsIghFfqUlLiuPp8VU6GiliFuOx0lo=
X-Gm-Gg: ASbGncvvi6+XKZW21VrScPF0z+FYywIikGO2Azxfce2poZDz3TjLn3WjtaoHW+7+ujV
	s/L1ZMCdbG4QGhEZOpAZAJQJ9pqhORlmL6svs6cf3bpCu6xNWO5hcIKAIFGtvJUGmh0aOHpiL25
	JoFUfwEfC+fo5rrp9bOdPmzvbX2ao36Gu3w64ySCudHXJhD+D51dKoT412m92suAfFtglVLf5b0
	mKX94FfTB+gEoRsTk7EugEpBYgGz7RPFP/uHYg4XnaGiAfwwwKiGgixqIRqB+8zPGky/wVTJUR/
	QP6kq9xJ2+6MMgOjM4+8ibgNlrU1s4i+95echz+LKM883I/D6dxUPQ7ZqU5u0vkQ/P+VKq3PcVJ
	pWvBHOm6403dF4PrABi04UHesmvN+l/3wGG5aTZnFgQ==
X-Google-Smtp-Source: AGHT+IHtuFLzK5O8ChsHoCofDqSnIDV4TUPr4lHwVLG7WrJcAaZGk76UBFLEIm9ccmQ0+A2/XN7Oqg==
X-Received: by 2002:a17:903:b45:b0:23f:8d03:c4ac with SMTP id d9443c01a7336-242c1ff44a7mr177794905ad.2.1754921049908;
        Mon, 11 Aug 2025 07:04:09 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a8cdsm274795675ad.121.2025.08.11.07.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:04:09 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	David Wilder <wilder@us.ibm.com>
Subject: [PATCH net] bonding: don't set oif to bond dev when getting NS target destination
Date: Mon, 11 Aug 2025 14:03:58 +0000
Message-ID: <20250811140358.2024-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike IPv4, IPv6 routing strictly requires the source address to be valid
on the outgoing interface. If the NS target is set to a remote VLAN interface,
and the source address is also configured on a VLAN over a bond interface,
setting the oif to the bond device will fail to retrieve the correct
destination route.

Fix this by not setting the oif to the bond device when retrieving the NS
target destination. This allows the correct destination device (the VLAN
interface) to be determined, so that bond_verify_device_path can return the
proper VLAN tags for sending NS messages.

Reported-by: David Wilder <wilder@us.ibm.com>
Closes: https://lore.kernel.org/netdev/aGOKggdfjv0cApTO@fedora/
Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c               |  1 -
 .../drivers/net/bonding/bond_options.sh       | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 257333c88710..30cf97f4e814 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3355,7 +3355,6 @@ static void bond_ns_send_all(struct bonding *bond, struct slave *slave)
 		/* Find out through which dev should the packet go */
 		memset(&fl6, 0, sizeof(struct flowi6));
 		fl6.daddr = targets[i];
-		fl6.flowi6_oif = bond->dev->ifindex;
 
 		dst = ip6_route_output(dev_net(bond->dev), NULL, &fl6);
 		if (dst->error) {
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index 7bc148889ca7..b3eb8a919c71 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -7,6 +7,7 @@ ALL_TESTS="
 	prio
 	arp_validate
 	num_grat_arp
+	vlan_over_bond
 "
 
 lib_dir=$(dirname "$0")
@@ -376,6 +377,64 @@ num_grat_arp()
 	done
 }
 
+vlan_over_bond_arp()
+{
+	local mode="$1"
+	RET=0
+
+	bond_reset "mode $mode arp_interval 100 arp_ip_target 192.0.3.10"
+	ip -n "${s_ns}" link add bond0.3 link bond0 type vlan id 3
+	ip -n "${s_ns}" link set bond0.3 up
+	ip -n "${s_ns}" addr add 192.0.3.1/24 dev bond0.3
+	ip -n "${s_ns}" addr add 2001:db8::3:1/64 dev bond0.3
+
+	slowwait_for_counter 5 5 tc_rule_handle_stats_get \
+		"dev eth0.3 ingress" 101 ".packets" "-n ${c_ns}" || RET=1
+	log_test "vlan over bond arp" "$mode"
+}
+
+vlan_over_bond_ns()
+{
+	local mode="$1"
+	RET=0
+
+	if skip_ns; then
+		log_test_skip "vlan_over_bond ns" "$mode"
+		return 0
+	fi
+
+	bond_reset "mode $mode arp_interval 100 ns_ip6_target 2001:db8::3:10"
+	ip -n "${s_ns}" link add bond0.3 link bond0 type vlan id 3
+	ip -n "${s_ns}" link set bond0.3 up
+	ip -n "${s_ns}" addr add 192.0.3.1/24 dev bond0.3
+	ip -n "${s_ns}" addr add 2001:db8::3:1/64 dev bond0.3
+
+	slowwait_for_counter 5 5 tc_rule_handle_stats_get \
+		"dev eth0.3 ingress" 102 ".packets" "-n ${c_ns}" || RET=1
+	log_test "vlan over bond ns" "$mode"
+}
+
+vlan_over_bond()
+{
+	# add vlan 3 for client
+	ip -n "${c_ns}" link add eth0.3 link eth0 type vlan id 3
+	ip -n "${c_ns}" link set eth0.3 up
+	ip -n "${c_ns}" addr add 192.0.3.10/24 dev eth0.3
+	ip -n "${c_ns}" addr add 2001:db8::3:10/64 dev eth0.3
+
+	# Add tc rule to check the vlan pkts
+	tc -n "${c_ns}" qdisc add dev eth0.3 clsact
+	tc -n "${c_ns}" filter add dev eth0.3 ingress protocol arp \
+		handle 101 flower skip_hw arp_op request \
+		arp_sip 192.0.3.1 arp_tip 192.0.3.10 action pass
+	tc -n "${c_ns}" filter add dev eth0.3 ingress protocol ipv6 \
+		handle 102 flower skip_hw ip_proto icmpv6 \
+		type 135 src_ip 2001:db8::3:1 action pass
+
+	vlan_over_bond_arp "active-backup"
+	vlan_over_bond_ns "active-backup"
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.50.1



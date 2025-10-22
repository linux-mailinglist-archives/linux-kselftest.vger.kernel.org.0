Return-Path: <linux-kselftest+bounces-43791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BDBBFDDAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BF31A0646C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AFB34C9B0;
	Wed, 22 Oct 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MsBxJEBM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014E34CFDB;
	Wed, 22 Oct 2025 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157691; cv=none; b=Im4zz3/fJvt+h5N6yYQvRC5Wdrdef0xznxBx1+rqd9mdr5DMW27BllFNZP5ptE+BbI8e/AzSopjo+Jzcuha70fqr7oiQiSfNHId09EU37ZFlvLzcYwmmIYIaOhplog1QoRxuweXRnNX7ORozvzIJ2NjftW26FH/yOa3Dq8HmWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157691; c=relaxed/simple;
	bh=9+WeqbUMUpY6ROiRaae5knohxpc6q4u+xKCz4B6a3L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bV+MMd+KH2q5422t5VvEAB+9pS/P7TyQlUlwc+h+cDFa/ldJBVLO4/OVlOWCkbTNO3NH+0UQ23r3Anmvo+QqW7aAsSCsxOULQmcINNWjwaAFXRfr5/iDSL4JWhG4tI981IeED4j6IiFNqp/fCR62zQOr59CRLQrpf424g+tkKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MsBxJEBM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAOXHA003946;
	Wed, 22 Oct 2025 18:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=meFZWl7a64A8cL8YC
	fMpTCg5cNlveAeMzgceTrc7Ukw=; b=MsBxJEBMBtZ3uq1zV2EItNUQKql6pBnlU
	prSV/UceL1ATpRRIEk5T+Vee3Bv0IbhXAqeZR7Sskxfx/ziPSoadJTfYZ2637/eN
	oy6fAJ24M4n5ctA8QYstrpS0AMlufASGk+JbgqGPHiQmDAK6A9nxookfpEvPluRP
	o8yDPtYZFGnSKaWNOkAIzOXuH7RAiYTF2H5FrwrL3lOiWrB6//wdFEN6IZA3kYry
	moa/TFr1hGF7v8iL0gu0g9l7L2h5BkVjq+/0GsjexuDLl2+POJGI6tHojL9mjQFd
	zHfBo6OhJUaeY/s3VIRMPc+B/wfxjT474EO0k5QycopC952QKDbNg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hmwa5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MIRXlV012650;
	Wed, 22 Oct 2025 18:27:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hmw9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MHwNrL002381;
	Wed, 22 Oct 2025 18:27:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejhpu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:27:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MIRpTx10224282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 18:27:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0BD85805D;
	Wed, 22 Oct 2025 18:27:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DEF058052;
	Wed, 22 Oct 2025 18:27:51 +0000 (GMT)
Received: from localhost (unknown [9.61.190.208])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 18:27:51 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, horms@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com,
        razor@blackwall.org, shuah@kernel.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH net-next v14 7/7] bonding: Selftest and documentation for the arp_ip_target parameter.
Date: Wed, 22 Oct 2025 11:25:34 -0700
Message-ID: <20251022182721.2567561-8-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022182721.2567561-1-wilder@us.ibm.com>
References: <20251022182721.2567561-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXx5qb89SK/H7d
 9e+Z9z+IgYqn0Y26XcIUooDbTGATQwjtd7oCCST74YMlITqBhJbIxG1vTZOOqVEAhUMYS+LAQ4t
 XFB9hb+e82BChkhTUAyUdXnga7UcTmXEiBy8DZ2J/McjedvaJSCK8TkX+5vxgXz1tZtbTZbu5XX
 MceQ0VQbiZl9u6heQ7amB9QIXZ5hcqrfNB0dNTvs1l+6mKFSchOa3lXrUkyPCHiNUHcY8CnHq8/
 IcxAUsveeggFvRDrtSv2e08bUKnE9q/tXDUj8Oug9b3dYFar8u57e8i3o1uu+40VzVWYc0X0yS6
 wO/6wA1AGpqfb4RuWrqPw0nFtrJdRx1tsJnnAZK0YKD796PSbPOQ11mngWL6mY0bsN8UL6tGxn/
 uB1EnLTJQXwgq5n3JnfPDrXvpPoUKg==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f9222a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=5H582h-KRMRMVc_AKwkA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 7q-XxNz2Jgori3RZuQ_6FV8_KPpsZWrr
X-Proofpoint-ORIG-GUID: s03uzgX91kX3MM8eWScNnXCbitmuCq9D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Selftest provided as a functional test for the arp_ip_target parameter
both with and without user supplied vlan tags. Bonding documentation
has been updated for the arp_ip_target option.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 Documentation/networking/bonding.rst          |  11 +
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond-arp-ip-target.sh | 204 ++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index e700bf1d095c..08a3191a0322 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -330,6 +330,17 @@ arp_ip_target
 	maximum number of targets that can be specified is 16.  The
 	default value is no IP addresses.
 
+        When an arp_ip_target is configured the bonding driver will
+        attempt to automatically determine what vlans the arp probe will
+        pass through. This process of gathering vlan tags is required
+        for the arp probe to be sent. However, in some configurations
+        this process may fail. In these cases you may manually
+        supply a list of vlan tags. To specify a list of vlan tags
+        append the ipv4 address with [tag1/tag2...]. For example:
+        arp_ip_target=10.0.0.1[10]. If you simply need to disable the
+        vlan discovery process you may provide an empty list, for example:
+        arp_ip_target=10.0.0.1[].
+
 ns_ip6_target
 
 	Specifies the IPv6 addresses to use as IPv6 monitoring peers when
diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 402d4ee84f2e..b9594790e6df 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -3,6 +3,7 @@
 
 TEST_PROGS := \
 	bond-arp-interval-causes-panic.sh \
+	bond-arp-ip-target.sh \
 	bond-break-lacpdu-tx.sh \
 	bond-eth-type-change.sh \
 	bond-lladdr-target.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
new file mode 100755
index 000000000000..9e3ecd8c2ced
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
@@ -0,0 +1,204 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test bonding arp_ip_target.
+# Topology for Bond mode 1,5,6 testing
+#
+#  +-------------------------+
+#  |                         | Server
+#  |        bond0.10.20      | 192.20.2.1/24
+#  |            |            |
+#  |         bond0.10        | 192.10.2.1/24
+#  |            |            |
+#  |          bond0          | 192.0.2.1/24
+#  |            |            |
+#  |            +            |
+#  |      eth0  |  eth1      |
+#  |        +---+---+        |
+#  |        |       |        |
+#  +-------------------------+
+#           |       |
+#  +-------------------------+
+#  |        |       |        |
+#  |    +---+-------+---+    |  Gateway
+#  |    |      br0      |    |
+#  |    +-------+-------+    |
+#  |            |            |
+#  +-------------------------+
+#               |
+#  +-------------------------+
+#  |            |            |  Client
+#  |          eth0           | 192.0.0.2/24
+#  |            |            |
+#  |         eth0.10         | 192.10.10.2/24
+#  |            |            |
+#  |        eth0.10.20       | 192.20.20.2/24
+#  +-------------------------+
+
+# shellcheck disable=SC2317
+
+lib_dir=$(dirname "$0")
+
+# shellcheck source=/dev/null # Ignore source warning.
+source "${lib_dir}"/bond_topo_2d1c.sh
+
+# shellcheck disable=SC2154 # Ignore unassigned referenced warning.
+echo "${c_ns}" "${s_ns}" > /dev/null
+
+DEBUG=${DEBUG:-0}
+test "${DEBUG}" -ne 0 && set -x
+
+# vlan subnets
+c_ip4="192.0.2.10"
+c_ip4v10="192.10.2.10"
+c_ip4v20="192.20.2.10"
+
+export ALL_TESTS="
+	no_vlan_hints
+	with_vlan_hints
+"
+
+# Build stacked vlans on top of an interface.
+stack_vlans()
+{
+	RET=0
+	local interface="$1"
+	local ns=$2
+	local last="$interface"
+	local tags="10 20"
+
+	if ! ip -n "${ns}" link show "${interface}" > /dev/null; then
+		RET=1
+		msg="Failed to create ${interface}"
+		return 1
+	fi
+
+	if [ "$ns" == "${s_ns}" ]; then host=1; else host=10;fi
+
+	for tag in $tags; do
+		ip -n "${ns}" link add link "$last" name "$last"."$tag" type vlan id "$tag"
+		ip -n "${ns}" address add 192."$tag".2."$host"/24 dev "$last"."$tag"
+		ip -n "${ns}" link set up dev "$last"."$tag"
+		last=$last.$tag
+	done
+}
+
+wait_for_arp_request()
+{
+	local target=$1
+	local ip
+	local interface
+
+	ip=$(echo "${target}" | awk -F "[" '{print $1}')
+	interface="$(ip -n "${c_ns}" -br addr show | grep "${ip}" | awk -F @ '{print $1}')"
+
+	tc -n "${c_ns}" qdisc add dev "${interface}" clsact
+	tc -n "${c_ns}" filter add dev "${interface}" ingress protocol arp \
+	handle 101 flower skip_hw arp_op request arp_tip "${ip}" action pass
+
+	slowwait_for_counter 5 5 tc_rule_handle_stats_get \
+		"dev ${interface} ingress" 101 ".packets" "-n ${c_ns}" &> /dev/null || RET=1
+
+	tc -n "${c_ns}" filter del dev "${interface}" ingress
+	tc -n "${c_ns}" qdisc del dev "${interface}" clsact
+
+	if [ "$RET" -ne 0 ]; then
+		msg="Arp probe not received by ${interface}"
+		return 1
+	fi
+}
+
+# Check for link flapping.
+# First verify the arp requests are being received
+# by the target.  Then verify that the Link Failure
+# Counts are not increasing over time.
+# Arp probes are sent every 100ms, two probes must
+# be missed to trigger a slave failure. A one second
+# wait should be sufficient.
+check_failure_count()
+{
+	local bond=$1
+	local target=$2
+	local proc_file=/proc/net/bonding/${bond}
+
+	wait_for_arp_request "${target}" || return 1
+
+	LinkFailureCount1=$(ip netns exec "${s_ns}" grep -F "Link Failure Count" "${proc_file}" \
+	| awk -F: '{ sum += $2 } END { print sum }')
+	sleep 1
+	LinkFailureCount2=$(ip netns exec "${s_ns}" grep -F "Link Failure Count" "${proc_file}" \
+	| awk -F: '{ sum += $2 } END { print sum }')
+
+	[ "$LinkFailureCount1" != "$LinkFailureCount2" ] && RET=1
+}
+
+setup_bond_topo()
+{
+	setup_prepare
+	setup_wait
+	stack_vlans bond0 "${s_ns}"
+	stack_vlans eth0 "${c_ns}"
+}
+
+skip_with_vlan_hints()
+{
+	# check if iproute supports arp_ip_target with vlans option.
+	if ! ip -n "${s_ns}" link add bond2 type bond arp_ip_target 10.0.0.1[10]; then
+		ip -n "${s_ns}" link del bond2 2> /dev/null
+		return 0
+	fi
+	return 1
+}
+
+no_vlan_hints()
+{
+	RET=0
+	local targets="${c_ip4} ${c_ip4v10} ${c_ip4v20}"
+	local target
+	msg=""
+
+	for target in $targets; do
+		bond_reset "mode $mode arp_interval 100 arp_ip_target ${target}"
+		stack_vlans bond0 "${s_ns}"
+		if [ "$RET" -ne 0 ]; then
+			log_test "no_vlan_hints" "${msg}"
+			return
+		fi
+		check_failure_count bond0 "${target}"
+		log_test "arp_ip_target=${target} ${msg}"
+	done
+}
+
+with_vlan_hints()
+{
+	RET=0
+	local targets="${c_ip4}[] ${c_ip4v10}[10] ${c_ip4v20}[10/20]"
+	local target
+	msg=""
+
+	if skip_with_vlan_hints; then
+		log_test_skip "skip_with_vlan_hints" \
+		"Installed iproute doesn't support extended arp_ip_target options."
+		return 0
+	fi
+
+	for target in $targets; do
+		bond_reset "mode $mode arp_interval 100 arp_ip_target ${target}"
+		stack_vlans bond0 "${s_ns}"
+		if [ "$RET" -ne 0 ]; then
+			log_test "no_vlan_hints" "${msg}"
+			return
+		fi
+		check_failure_count bond0 "${target}"
+		log_test "arp_ip_target=${target} ${msg}"
+	done
+}
+
+trap cleanup EXIT
+
+mode=active-backup
+
+setup_bond_topo
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.50.1



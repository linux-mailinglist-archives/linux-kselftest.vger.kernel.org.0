Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851897BD81D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346061AbjJIKHt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346010AbjJIKHr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:07:47 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597D89C;
        Mon,  9 Oct 2023 03:07:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFaxjpYAR1Dpq3q06mhlTY9UxYryQEeCY6puBDlNpLGwIisx+YwvxtCzcOTzJUi3A1z+T/1XCPuZjF0uKZSqxg4DIWn/0a/8cXRdu8bmmyq2imdvRVV++x+hM+LKEyLAjWKtwf4h1VR2nnTntnl/kiCXf94s2J+KVIpbo82oKxVIzWBYMcfDLGkujan35DpK1R/hhhf1AIE6bcVsUf6whyjVgoP6Q3TlTaehdMnw2thgiaQ9yKg8Dv2QNKs7J56VlKn/qF6Rr/cKGpSz4pVe4KoYp96xqWBJ5H16xb1K7PIfMeXMBWvaogE20GqTu2rGVNaMrl+WumYlbs/1hBY0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSxA7B+eOenRQaj+zdsxv53r0JigXq/AChjmQjLfw34=;
 b=R0fOePLs9yeauMbuHuZelU8X0SkQpq6bpeAQNlNiyaanBlD6k9p49r5dH/fcjLZjOk1oS75ovRPgcBCys8C9XONx+98ucaNkwI9pEGuQYKxWBhRZ5GSUigPamXGa4cmApnbd2gkT7ltoBNcNgiTzE1hfYxe2D+Ur6LEIwHTkzlvedub2PnU7UkJbEX5z2K2hL9MA0C8jnwdk3gJXtZuhBoAdo5Rr6ogYcNupJ6Rw+Evp0Mf5EVGShDK0/WkqVcVe6yEz5hptjcZs38mprEvz8ymIKlrUAAmsKLLqcvKpTr+DYHC1Qo1DT1/1unFp9JZcFxA1EjLQ5EcpXOZhLE6SLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSxA7B+eOenRQaj+zdsxv53r0JigXq/AChjmQjLfw34=;
 b=CEiUBeq+lmmSuJ2h+wfIDYnXy5mRDcY1lW/u2KD2YJ/6olLPFYeLr1x7TTEVpUTQWpJqDljNjyT3d+n2wnv/qZXbb01x0cEofkin79unAiQUGJDQVHgCFQ7fwQxCQPgD+G1aIUrLVCtpCr9tuIkN52pI3NjaLIAtuHB3SN/AKLLUpbGSBty2XMnloCmMznVzmzvlx/ZLP+8P7JhI5lCW3BnTIthvMXucyMpYRJ1eN9ZqAJgn4wCrgZbSLLkvn4W9wE+XRvpMgdyltvYwvvx7nFYJT1jmN5Z40oQJgAl0+fqmUKQtWt5afLYJnjxIfNY1bC46CMEAJ1RPco7Imu+EGQ==
Received: from MW3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:303:2b::16)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 10:07:41 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::f2) by MW3PR05CA0011.outlook.office365.com
 (2603:10b6:303:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Mon, 9 Oct 2023 10:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 10:07:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 03:07:30 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 9 Oct 2023 03:07:26 -0700
From:   Amit Cohen <amcohen@nvidia.com>
To:     <netdev@vger.kernel.org>
CC:     <mlxsw@nvidia.com>, <idosch@nvidia.com>, <kuba@kernel.org>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <roopa@nvidia.com>,
        <razor@blackwall.org>, <shuah@kernel.org>, <pabeni@redhat.com>,
        <bridge@lists.linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Amit Cohen" <amcohen@nvidia.com>
Subject: [PATCH net-next 10/11] selftests: Add test cases for FDB flush with VXLAN device
Date:   Mon, 9 Oct 2023 13:06:17 +0300
Message-ID: <20231009100618.2911374-11-amcohen@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
References: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: c5efc549-c335-4f02-b67c-08dbc8af92f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCDuUw44E+urw2XSCF4aPHo4K7r4slmkC63uQQ53+f/faEVcwiFsHK+m7mm4uxfBDNA8MkwaMlFHOtJdPBXqAdRsuj71XC9mdKkg3AGbdRDgdDVtwJkJ8XWNpxepMQOnMYV4uZPe0WpkGLV3tdIHkzBobdvKD7rhzgiEB+qSYYicvz/IBe11NKK6me75d0g7Fz4kqXQZMvMFxVEyharXE/yDIwv/Exxpiem7L+mpRt3PcSe60zHcSyuiAwnFwggzCj40kEhcIcGqgVt8KwJhU7uSP21fMCO0EkzYYZ1uQNDIdCWsQpdC2Wafd1nfxq54/KvFAOUCJabv2xxth0zEIvtKHJ96sSVlt0R+AZNclIIsxf/E3ds66oPctQTugMJi5Jizp66ysABT61GfGocRWPHrZ2bCgLd1JbWw8XapjRzBiIarmmG9IWyNDm4cXargb2fgdX0kgNWsK6LO54btnDhOf/JGqBXg8vWDYoPAD65gWX8zx3dJ5Sv1bg3mq2HbpUNtBUv5D2hJFuOAErQkgVdwr41GdJ1HRsu5KMSObGxriDfdkXc4fsI5EoLRoHouRD3UmyCPcicGSzZL2kn1XraGMBsb6P6Zp3Z/te/k/lK94Ek2vZnKNLQEbkqXVgV2HQVaiKTf3VUKA0EdkSjc+MeqpgJ0nmbkIGoxBjD0Un3pLGso1XjZOnRG6J7lRsMdUqJXjN06aYWR1soUjkvmz4ApnVqXW6H0Zpiz7eeN0BoPHQdullB/BbB1v/x/yLHm
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(1076003)(2616005)(426003)(26005)(336012)(16526019)(40460700003)(36756003)(40480700001)(82740400003)(86362001)(356005)(7636003)(83380400001)(107886003)(30864003)(4326008)(2906002)(478600001)(6666004)(8676002)(47076005)(36860700001)(66574015)(8936002)(41300700001)(6916009)(316002)(5660300002)(70206006)(54906003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:07:41.2634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5efc549-c335-4f02-b67c-08dbc8af92f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test all the supported arguments for FDB flush. The test checks
configuration, not traffic. Note that the flag 'offloaded' is not checked
as it is not relevant when there is no hardware.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 tools/testing/selftests/net/Makefile     |   1 +
 tools/testing/selftests/net/fdb_flush.sh | 716 +++++++++++++++++++++++
 2 files changed, 717 insertions(+)
 create mode 100755 tools/testing/selftests/net/fdb_flush.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8b017070960d..61939a695f95 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -89,6 +89,7 @@ TEST_PROGS += test_vxlan_mdb.sh
 TEST_PROGS += test_bridge_neigh_suppress.sh
 TEST_PROGS += test_vxlan_nolocalbypass.sh
 TEST_PROGS += test_bridge_backup_port.sh
+TEST_PROGS += fdb_flush.sh
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/net/fdb_flush.sh b/tools/testing/selftests/net/fdb_flush.sh
new file mode 100755
index 000000000000..3050b031f46d
--- /dev/null
+++ b/tools/testing/selftests/net/fdb_flush.sh
@@ -0,0 +1,716 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# This test is for checking functionality of flushing FDB entries.
+# Check that flush works as expected with all the supported arguments and verify
+# some combinations of arguments.
+
+FLUSH_BY_STATE_TESTS="
+	vxlan_test_flush_by_permanent
+	vxlan_test_flush_by_nopermanent
+	vxlan_test_flush_by_static
+	vxlan_test_flush_by_nostatic
+	vxlan_test_flush_by_dynamic
+	vxlan_test_flush_by_nodynamic
+"
+
+FLUSH_BY_FLAG_TESTS="
+	vxlan_test_flush_by_extern_learn
+	vxlan_test_flush_by_noextern_learn
+	vxlan_test_flush_by_router
+	vxlan_test_flush_by_norouter
+"
+
+TESTS="
+	vxlan_test_flush_by_dev
+	vxlan_test_flush_by_vni
+	vxlan_test_flush_by_src_vni
+	vxlan_test_flush_by_port
+	vxlan_test_flush_by_dst_ip
+	vxlan_test_flush_by_nhid
+	$FLUSH_BY_STATE_TESTS
+	$FLUSH_BY_FLAG_TESTS
+	vxlan_test_flush_by_several_args
+	vxlan_test_flush_by_remote_attributes
+"
+
+: ${VERBOSE:=0}
+: ${PAUSE_ON_FAIL:=no}
+: ${PAUSE:=no}
+: ${VXPORT:=4789}
+
+run_cmd()
+{
+	local cmd="$1"
+	local out
+	local rc
+	local stderr="2>/dev/null"
+
+	if [ "$VERBOSE" = "1" ]; then
+		printf "COMMAND: $cmd\n"
+		stderr=
+	fi
+
+	out=$(eval $cmd $stderr)
+	rc=$?
+	if [ "$VERBOSE" = "1" -a -n "$out" ]; then
+		echo "    $out"
+	fi
+
+	return $rc
+}
+
+log_test()
+{
+	local rc=$1
+	local expected=$2
+	local msg="$3"
+	local nsuccess
+	local nfail
+	local ret
+
+	if [ ${rc} -eq ${expected} ]; then
+		printf "TEST: %-60s  [ OK ]\n" "${msg}"
+		nsuccess=$((nsuccess+1))
+	else
+		ret=1
+		nfail=$((nfail+1))
+		printf "TEST: %-60s  [FAIL]\n" "${msg}"
+		if [ "$VERBOSE" = "1" ]; then
+			echo "    rc=$rc, expected $expected"
+		fi
+
+		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
+		echo
+			echo "hit enter to continue, 'q' to quit"
+			read a
+			[ "$a" = "q" ] && exit 1
+		fi
+	fi
+
+	if [ "${PAUSE}" = "yes" ]; then
+		echo
+		echo "hit enter to continue, 'q' to quit"
+		read a
+		[ "$a" = "q" ] && exit 1
+	fi
+
+	[ "$VERBOSE" = "1" ] && echo
+}
+
+MAC_POOL_1="
+	de:ad:be:ef:13:10
+	de:ad:be:ef:13:11
+	de:ad:be:ef:13:12
+	de:ad:be:ef:13:13
+	de:ad:be:ef:13:14
+"
+mac_pool_1_len=$(echo "$MAC_POOL_1" | grep -c .)
+
+MAC_POOL_2="
+	ca:fe:be:ef:13:10
+	ca:fe:be:ef:13:11
+	ca:fe:be:ef:13:12
+	ca:fe:be:ef:13:13
+	ca:fe:be:ef:13:14
+"
+mac_pool_2_len=$(echo "$MAC_POOL_2" | grep -c .)
+
+fdb_add_mac_pool_1()
+{
+	local dev=$1; shift
+	local args="$@"
+
+	for mac in $MAC_POOL_1
+	do
+		$BRIDGE fdb add $mac dev $dev $args
+	done
+}
+
+fdb_add_mac_pool_2()
+{
+	local dev=$1; shift
+	local args="$@"
+
+	for mac in $MAC_POOL_2
+	do
+		$BRIDGE fdb add $mac dev $dev $args
+	done
+}
+
+fdb_check_n_entries_by_dev_filter()
+{
+	local dev=$1; shift
+	local exp_entries=$1; shift
+	local filter="$@"
+
+	local entries=$($BRIDGE fdb show dev $dev | grep "$filter" | wc -l)
+
+	[[ $entries -eq $exp_entries ]]
+	rc=$?
+
+	log_test $rc 0 "$dev: Expected $exp_entries FDB entries, got $entries"
+	return $rc
+}
+
+vxlan_test_flush_by_dev()
+{
+	local vni=3000
+	local dst_ip=192.0.2.1
+
+	fdb_add_mac_pool_1 vx10 vni $vni dst $dst_ip
+	fdb_add_mac_pool_2 vx20 vni $vni dst $dst_ip
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len
+	fdb_check_n_entries_by_dev_filter vx20 $mac_pool_2_len
+
+	run_cmd "$BRIDGE fdb flush dev vx10"
+	log_test $? 0 "Flush FDB by dev vx10"
+
+	fdb_check_n_entries_by_dev_filter vx10 0
+	log_test $? 0 "Flush FDB by dev vx10 - test vx10 entries"
+
+	fdb_check_n_entries_by_dev_filter vx20 $mac_pool_2_len
+	log_test $? 0 "Flush FDB by dev vx10 - test vx20 entries"
+}
+
+vxlan_test_flush_by_vni()
+{
+	local vni_1=3000
+	local vni_2=4000
+	local dst_ip=192.0.2.1
+
+	fdb_add_mac_pool_1 vx10 vni $vni_1 dst $dst_ip
+	fdb_add_mac_pool_2 vx10 vni $vni_2 dst $dst_ip
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len vni $vni_1
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_2_len vni $vni_2
+
+	run_cmd "$BRIDGE fdb flush dev vx10 vni $vni_2"
+	log_test $? 0 "Flush FDB by dev vx10 and vni $vni_2"
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len vni $vni_1
+	log_test $? 0 "Test entries with vni $vni_1"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 vni $vni_2
+	log_test $? 0 "Test entries with vni $vni_2"
+}
+
+vxlan_test_flush_by_src_vni()
+{
+	# Set some entries with {vni=x,src_vni=y} and some with the opposite -
+	# {vni=y,src_vni=x}, to verify that when we flush by src_vni=x, entries
+	# with vni=x are not flused.
+	local vni_1=3000
+	local vni_2=4000
+	local src_vni_1=4000
+	local src_vni_2=3000
+	local dst_ip=192.0.2.1
+
+	# Reconfigure vx10 with 'external' to get 'src_vni' details in
+	# 'bridge fdb' output
+	$IP link del dev vx10
+	$IP link add name vx10 type vxlan dstport "$VXPORT" external
+
+	fdb_add_mac_pool_1 vx10 vni $vni_1 src_vni $src_vni_1 dst $dst_ip
+	fdb_add_mac_pool_2 vx10 vni $vni_2 src_vni $src_vni_2 dst $dst_ip
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len \
+		src_vni $src_vni_1
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_2_len \
+		src_vni $src_vni_2
+
+	run_cmd "$BRIDGE fdb flush dev vx10 src_vni $src_vni_2"
+	log_test $? 0 "Flush FDB by dev vx10 and src_vni $src_vni_2"
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len \
+		src_vni $src_vni_1
+	log_test $? 0 "Test entries with src_vni $src_vni_1"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 src_vni $src_vni_2
+	log_test $? 0 "Test entries with src_vni $src_vni_2"
+}
+
+vxlan_test_flush_by_port()
+{
+	local port_1=1234
+	local port_2=4321
+	local dst_ip=192.0.2.1
+
+	fdb_add_mac_pool_1 vx10 port $port_1 dst $dst_ip
+	fdb_add_mac_pool_2 vx10 port $port_2 dst $dst_ip
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len port $port_1
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_2_len port $port_2
+
+	run_cmd "$BRIDGE fdb flush dev vx10 port $port_2"
+	log_test $? 0 "Flush FDB by dev vx10 and port $port_2"
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len port $port_1
+	log_test $? 0 "Test entries with port $port_1"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 port $port_2
+	log_test $? 0 "Test entries with port $port_2"
+}
+
+vxlan_test_flush_by_dst_ip()
+{
+	local dst_ip_1=192.0.2.1
+	local dst_ip_2=192.0.2.2
+
+	fdb_add_mac_pool_1 vx10 dst $dst_ip_1
+	fdb_add_mac_pool_2 vx10 dst $dst_ip_2
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len dst $dst_ip_1
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_2_len dst $dst_ip_2
+
+	run_cmd "$BRIDGE fdb flush dev vx10 dst $dst_ip_2"
+	log_test $? 0 "Flush FDB by dev vx10 and dst $dst_ip_2"
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len dst $dst_ip_1
+	log_test $? 0 "Test entries with dst $dst_ip_1"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 dst $dst_ip_2
+	log_test $? 0 "Test entries with dst $dst_ip_2"
+}
+
+nexthops_add()
+{
+	local nhid_1=$1; shift
+	local nhid_2=$1; shift
+
+	$IP nexthop add id 10 via 192.0.2.1 fdb
+	$IP nexthop add id $nhid_1 group 10 fdb
+
+	$IP nexthop add id 20 via 192.0.2.2 fdb
+	$IP nexthop add id $nhid_2 group 20 fdb
+}
+
+vxlan_test_flush_by_nhid()
+{
+	local nhid_1=100
+	local nhid_2=200
+
+	nexthops_add $nhid_1 $nhid_2
+
+	fdb_add_mac_pool_1 vx10 nhid $nhid_1
+	fdb_add_mac_pool_2 vx10 nhid $nhid_2
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len nhid $nhid_1
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_2_len nhid $nhid_2
+
+	run_cmd "$BRIDGE fdb flush dev vx10 nhid $nhid_2"
+	log_test $? 0 "Flush FDB by dev vx10 and nhid $nhid_2"
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len nhid $nhid_1
+	log_test $? 0 "Test entries with nhid $nhid_1"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 nhid $nhid_2
+	log_test $? 0 "Test entries with nhid $nhid_2"
+
+	# Flush also entries with $nhid_1, and then verify that flushing by
+	# 'nhid' does not return an error when there are no entries with
+	# nexthops.
+	run_cmd "$BRIDGE fdb flush dev vx10 nhid $nhid_1"
+	log_test $? 0 "Flush FDB by dev vx10 and nhid $nhid_1"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 nhid
+	log_test $? 0 "Test entries with 'nhid' keyword"
+
+	run_cmd "$BRIDGE fdb flush dev vx10 nhid $nhid_1"
+	log_test $? 0 "Flush FDB by nhid when there are no entries with nexthop"
+}
+
+vxlan_test_flush_by_state()
+{
+	local flush_by_state=$1; shift
+	local state_1=$1; shift
+	local exp_state_1=$1; shift
+	local state_2=$1; shift
+	local exp_state_2=$1; shift
+
+	local dst_ip_1=192.0.2.1
+	local dst_ip_2=192.0.2.2
+
+	fdb_add_mac_pool_1 vx10 dst $dst_ip_1 $state_1
+	fdb_add_mac_pool_2 vx10 dst $dst_ip_2 $state_2
+
+	# Check the entries by dst_ip as not all states appear in 'bridge fdb'
+	# output.
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len dst $dst_ip_1
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_2_len dst $dst_ip_2
+
+	run_cmd "$BRIDGE fdb flush dev vx10 $flush_by_state"
+	log_test $? 0 "Flush FDB by dev vx10 and state $flush_by_state"
+
+	fdb_check_n_entries_by_dev_filter vx10 $exp_state_1 dst $dst_ip_1
+	log_test $? 0 "Test entries with state $state_1"
+
+	fdb_check_n_entries_by_dev_filter vx10 $exp_state_2 dst $dst_ip_2
+	log_test $? 0 "Test entries with state $state_2"
+}
+
+vxlan_test_flush_by_permanent()
+{
+	# Entries that are added without state get 'permanent' state by
+	# default, add some entries with flag 'extern_learn' instead of state,
+	# so they will be added with 'permanent' and should be flushed also.
+	local flush_by_state="permanent"
+	local state_1="permanent"
+	local exp_state_1=0
+	local state_2="extern_learn"
+	local exp_state_2=0
+
+	vxlan_test_flush_by_state $flush_by_state $state_1 $exp_state_1 \
+		$state_2 $exp_state_2
+}
+
+vxlan_test_flush_by_nopermanent()
+{
+	local flush_by_state="nopermanent"
+	local state_1="permanent"
+	local exp_state_1=$mac_pool_1_len
+	local state_2="static"
+	local exp_state_2=0
+
+	vxlan_test_flush_by_state $flush_by_state $state_1 $exp_state_1 \
+		$state_2 $exp_state_2
+}
+
+vxlan_test_flush_by_static()
+{
+	local flush_by_state="static"
+	local state_1="static"
+	local exp_state_1=0
+	local state_2="dynamic"
+	local exp_state_2=$mac_pool_2_len
+
+	vxlan_test_flush_by_state $flush_by_state $state_1 $exp_state_1 \
+		$state_2 $exp_state_2
+}
+
+vxlan_test_flush_by_nostatic()
+{
+	local flush_by_state="nostatic"
+	local state_1="permanent"
+	local exp_state_1=$mac_pool_1_len
+	local state_2="dynamic"
+	local exp_state_2=0
+
+	vxlan_test_flush_by_state $flush_by_state $state_1 $exp_state_1 \
+		$state_2 $exp_state_2
+}
+
+vxlan_test_flush_by_dynamic()
+{
+	local flush_by_state="dynamic"
+	local state_1="dynamic"
+	local exp_state_1=0
+	local state_2="static"
+	local exp_state_2=$mac_pool_2_len
+
+	vxlan_test_flush_by_state $flush_by_state $state_1 $exp_state_1 \
+		$state_2 $exp_state_2
+}
+
+vxlan_test_flush_by_nodynamic()
+{
+	local flush_by_state="nodynamic"
+	local state_1="permanent"
+	local exp_state_1=0
+	local state_2="dynamic"
+	local exp_state_2=$mac_pool_2_len
+
+	vxlan_test_flush_by_state $flush_by_state $state_1 $exp_state_1 \
+		$state_2 $exp_state_2
+}
+
+vxlan_test_flush_by_flag()
+{
+	local flush_by_flag=$1; shift
+	local flag_1=$1; shift
+	local exp_flag_1=$1; shift
+	local flag_2=$1; shift
+	local exp_flag_2=$1; shift
+
+	local dst_ip_1=192.0.2.1
+	local dst_ip_2=192.0.2.2
+
+	fdb_add_mac_pool_1 vx10 dst $dst_ip_1 $flag_1
+	fdb_add_mac_pool_2 vx10 dst $dst_ip_2 $flag_2
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len $flag_1
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_2_len $flag_2
+
+	run_cmd "$BRIDGE fdb flush dev vx10 $flush_by_flag"
+	log_test $? 0 "Flush FDB by dev vx10 and flag $flush_by_flag"
+
+	fdb_check_n_entries_by_dev_filter vx10 $exp_flag_1 dst $dst_ip_1
+	log_test $? 0 "Test entries with flag $flag_1"
+
+	fdb_check_n_entries_by_dev_filter vx10 $exp_flag_2 dst $dst_ip_2
+	log_test $? 0 "Test entries with flag $flag_2"
+}
+
+vxlan_test_flush_by_extern_learn()
+{
+	local flush_by_flag="extern_learn"
+	local flag_1="extern_learn"
+	local exp_flag_1=0
+	local flag_2="router"
+	local exp_flag_2=$mac_pool_2_len
+
+	vxlan_test_flush_by_flag $flush_by_flag $flag_1 $exp_flag_1 \
+		$flag_2 $exp_flag_2
+}
+
+vxlan_test_flush_by_noextern_learn()
+{
+	local flush_by_flag="noextern_learn"
+	local flag_1="extern_learn"
+	local exp_flag_1=$mac_pool_1_len
+	local flag_2="router"
+	local exp_flag_2=0
+
+	vxlan_test_flush_by_flag $flush_by_flag $flag_1 $exp_flag_1 \
+		$flag_2 $exp_flag_2
+}
+
+vxlan_test_flush_by_router()
+{
+	local flush_by_flag="router"
+	local flag_1="router"
+	local exp_flag_1=0
+	local flag_2="extern_learn"
+	local exp_flag_2=$mac_pool_2_len
+
+	vxlan_test_flush_by_flag $flush_by_flag $flag_1 $exp_flag_1 \
+		$flag_2 $exp_flag_2
+}
+
+vxlan_test_flush_by_norouter()
+{
+
+	local flush_by_flag="norouter"
+	local flag_1="router"
+	local exp_flag_1=$mac_pool_1_len
+	local flag_2="extern_learn"
+	local exp_flag_2=0
+
+	vxlan_test_flush_by_flag $flush_by_flag $flag_1 $exp_flag_1 \
+		$flag_2 $exp_flag_2
+}
+
+vxlan_test_flush_by_several_args()
+{
+	local dst_ip_1=192.0.2.1
+	local dst_ip_2=192.0.2.2
+	local state_1=permanent
+	local state_2=static
+	local vni=3000
+	local port=1234
+	local nhid=100
+	local flag=router
+	local flush_args
+
+	################### Flush by 2 args - nhid and flag ####################
+	$IP nexthop add id 10 via 192.0.2.1 fdb
+	$IP nexthop add id $nhid group 10 fdb
+
+	fdb_add_mac_pool_1 vx10 nhid $nhid $flag $state_1
+	fdb_add_mac_pool_2 vx10 nhid $nhid $flag $state_2
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len $state_1
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_2_len $state_2
+
+	run_cmd "$BRIDGE fdb flush dev vx10 nhid $nhid $flag"
+	log_test $? 0 "Flush FDB by dev vx10 nhid $nhid $flag"
+
+	# All entries should be flushed as 'state' is not an argument for flush
+	# filtering.
+	fdb_check_n_entries_by_dev_filter vx10 0 $state_1
+	log_test $? 0 "Test entries with state $state_1"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 $state_2
+	log_test $? 0 "Test entries with state $state_2"
+
+	################ Flush by 3 args - VNI, port and dst_ip ################
+	fdb_add_mac_pool_1 vx10 vni $vni port $port dst $dst_ip_1
+	fdb_add_mac_pool_2 vx10 vni $vni port $port dst $dst_ip_2
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len dst $dst_ip_1
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_2_len dst $dst_ip_2
+
+	flush_args="vni $vni port $port dst $dst_ip_2"
+	run_cmd "$BRIDGE fdb flush dev vx10 $flush_args"
+	log_test $? 0 "Flush FDB by dev vx10 $flush_args"
+
+	# Only entries with $dst_ip_2 should be flushed, even the rest arguments
+	# match the filter, the flush should be AND of all the arguments.
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len dst $dst_ip_1
+	log_test $? 0 "Test entries with dst $dst_ip_1"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 dst $dst_ip_2
+	log_test $? 0 "Test entries with dst $dst_ip_2"
+}
+
+multicast_fdb_entries_add()
+{
+	mac=00:00:00:00:00:00
+	vnis=(2000 3000)
+
+	for vni in "${vnis[@]}"; do
+		$BRIDGE fdb append $mac dev vx10 dst 192.0.2.1 vni $vni \
+			src_vni 5000
+		$BRIDGE fdb append $mac dev vx10 dst 192.0.2.1 vni $vni \
+			port 1111
+		$BRIDGE fdb append $mac dev vx10 dst 192.0.2.2 vni $vni \
+			port 2222
+	done
+}
+
+vxlan_test_flush_by_remote_attributes()
+{
+	local flush_args
+
+	# Reconfigure vx10 with 'external' to get 'src_vni' details in
+	# 'bridge fdb' output
+	$IP link del dev vx10
+	$IP link add name vx10 type vxlan dstport "$VXPORT" external
+
+	# For multicat FDB entries, the VXLAN driver stores a linked list of
+	# remotes for a given key. Verify that only the expected remotes are
+	# flushed.
+	multicast_fdb_entries_add
+
+	## Flush by 3 remote's attributes - destination IP, port and VNI ##
+	flush_args="dst 192.0.2.1 port 1111 vni 2000"
+	fdb_check_n_entries_by_dev_filter vx10 1 $flush_args
+
+	t0_n_entries=$($BRIDGE fdb show dev vx10 | wc -l)
+	run_cmd "$BRIDGE fdb flush dev vx10 $flush_args"
+	log_test $? 0 "Flush FDB by dev vx10 $flush_args"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 $flush_args
+
+	exp_n_entries=$((t0_n_entries - 1))
+	t1_n_entries=$($BRIDGE fdb show dev vx10 | wc -l)
+	[[ $t1_n_entries -eq $exp_n_entries ]]
+	log_test $? 0 "Check how many entries were flushed"
+
+	## Flush by 2 remote's attributes - destination IP and port ##
+	flush_args="dst 192.0.2.2 port 2222"
+
+	fdb_check_n_entries_by_dev_filter vx10 2 $flush_args
+
+	t0_n_entries=$($BRIDGE fdb show dev vx10 | wc -l)
+	run_cmd "$BRIDGE fdb flush dev vx10 $flush_args"
+	log_test $? 0 "Flush FDB by dev vx10 $flush_args"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 $flush_args
+
+	exp_n_entries=$((t0_n_entries - 2))
+	t1_n_entries=$($BRIDGE fdb show dev vx10 | wc -l)
+	[[ $t1_n_entries -eq $exp_n_entries ]]
+	log_test $? 0 "Check how many entries were flushed"
+
+	## Flush by source VNI, which is not remote's attribute and VNI ##
+	flush_args="vni 3000 src_vni 5000"
+
+	fdb_check_n_entries_by_dev_filter vx10 1 $flush_args
+
+	t0_n_entries=$($BRIDGE fdb show dev vx10 | wc -l)
+	run_cmd "$BRIDGE fdb flush dev vx10 $flush_args"
+	log_test $? 0 "Flush FDB by dev vx10 $flush_args"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 $flush_args
+
+	exp_n_entries=$((t0_n_entries -1))
+	t1_n_entries=$($BRIDGE fdb show dev vx10 | wc -l)
+	[[ $t1_n_entries -eq $exp_n_entries ]]
+	log_test $? 0 "Check how many entries were flushed"
+
+	# Flush by 1 remote's attribute - destination IP ##
+	flush_args="dst 192.0.2.1"
+
+	fdb_check_n_entries_by_dev_filter vx10 2 $flush_args
+
+	t0_n_entries=$($BRIDGE fdb show dev vx10 | wc -l)
+	run_cmd "$BRIDGE fdb flush dev vx10 $flush_args"
+	log_test $? 0 "Flush FDB by dev vx10 $flush_args"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 $flush_args
+
+	exp_n_entries=$((t0_n_entries -2))
+	t1_n_entries=$($BRIDGE fdb show dev vx10 | wc -l)
+	[[ $t1_n_entries -eq $exp_n_entries ]]
+	log_test $? 0 "Check how many entries were flushed"
+}
+
+setup()
+{
+	IP="ip -netns ns1"
+	BRIDGE="bridge -netns ns1"
+
+	ip netns add ns1
+
+	$IP link add name vx10 type vxlan id 1000 dstport "$VXPORT"
+	$IP link add name vx20 type vxlan id 2000 dstport "$VXPORT"
+}
+
+cleanup()
+{
+	$IP link del dev vx20
+	$IP link del dev vx10
+
+	ip netns del ns1
+}
+
+################################################################################
+# main
+
+while getopts :t:pPhvw: o
+do
+	case $o in
+		t) TESTS=$OPTARG;;
+		p) PAUSE_ON_FAIL=yes;;
+		P) PAUSE=yes;;
+		v) VERBOSE=$(($VERBOSE + 1));;
+		w) PING_TIMEOUT=$OPTARG;;
+		h) usage; exit 0;;
+		*) usage; exit 1;;
+	esac
+done
+
+# make sure we don't pause twice
+[ "${PAUSE}" = "yes" ] && PAUSE_ON_FAIL=no
+
+if [ "$(id -u)" -ne 0 ];then
+	echo "SKIP: Need root privileges"
+	exit $ksft_skip;
+fi
+
+if [ ! -x "$(command -v ip)" ]; then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+
+# Check a flag that is added to flush command as part of VXLAN flush support
+bridge fdb help 2>&1 | grep -q "\[no\]router"
+if [ $? -ne 0 ]; then
+	echo "SKIP: iproute2 too old, missing flush command for VXLAN"
+	exit $ksft_skip
+fi
+
+ip link add dev vx10 type vxlan id 1000 2> /dev/null
+out=$(bridge fdb flush dev vx10 2>&1 | grep -q "Operation not supported")
+if [ $? -eq 0 ]; then
+	echo "SKIP: kernel lacks vxlan flush support"
+	exit $ksft_skip
+fi
+ip link del dev vx10
+
+for t in $TESTS
+do
+	setup; $t; cleanup;
+done
-- 
2.40.1


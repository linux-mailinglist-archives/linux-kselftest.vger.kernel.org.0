Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6667C78830F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 11:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbjHYJJQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 05:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244125AbjHYJIw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 05:08:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2103.outbound.protection.outlook.com [40.107.6.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F3819BF;
        Fri, 25 Aug 2023 02:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dosl79buXOpnWKjxssmFSEYFVnmACnYwTd8eEf6iIGiioeQiVMpZW9XQ+jlP1Q855EDllcLuH7KVhL03oNqCI0hKGaSxDjVxMRX0OmlnPfb8B7BVttsIe59xQZs9ZduJeKoupB7b4UPb+8V9VbIJfQwoWRyPNZsnbnF/clcsK3I6XPUbqudIYYBY9FX0461jHgVKWgl1nRDZ0McYceiTP3mpApIAyWGTs95KrTFjThtyA6fJaqVAx7ya0va2ztizss6+/opBW1JuXBSlYNBraRCbpEbeIkjbc6K0yyFFFFWtWp/8hU4mH4P0/EF8Os0FVGLT2tWcD8rlsPy8kcg9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K35+jhyNPgWDC7nOAfWdThB6lwVCLHE8sCCpfpt08f4=;
 b=EXKDb8eIwjjbRCeVVZOY5GaLjuaOYXTxCGHl+WmtczLHBeyU9qhsZH29bUsxby+mg5k6kIl1yMZ4hZk5ghoTa7JwBYEYegwUS9gXK9n5m2sNErbZRpA5CJ0C9+uFBf0ZjggEZwhM4MFrrliBb1wZRnmo0gEFXSyTOw2/N3Jgn3+poiTbUgDOt0GiLOg2cCquU+XGccpeplBPHIuLutdu4LNzyn1jHw8f1StDYFLcdSqAtQ2BE0OqEKaUNMnqwZAKlg84IN7Y9RmiKbthK+3cYX/UTVJEgQ+mBB1ONKg75N4wv0w1BHImpnZZIqBYKL4q/DDw+fBkf9Xn/nd0kf2Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K35+jhyNPgWDC7nOAfWdThB6lwVCLHE8sCCpfpt08f4=;
 b=SIG49+Mo8kIoayxwmHbT9GKewwrUpscpWPuTemvYiG5EL/M1+jlcQ/xgyxqyQVLaZdKiQ6HguIs7Y55NDNRjDj9Ib2hSlTQvouOwiaNKkpBPYK+/oiQdh+/qcUVzmcY9xLP9wAVGv2qQ2Ydl5CcjS1O9f9BtVxfIYHHl6NWF3kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by DB9P189MB1499.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 09:08:39 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 09:08:39 +0000
From:   Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH net v2 3/3] selftests: forwarding: Add test for load-balancing between multiple servers
Date:   Fri, 25 Aug 2023 11:08:30 +0200
Message-Id: <20230825090830.18635-4-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825090830.18635-1-sriram.yagnaraman@est.tech>
References: <20230825090830.18635-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::31) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|DB9P189MB1499:EE_
X-MS-Office365-Filtering-Correlation-Id: 7880fef7-dcdd-40a4-e7ba-08dba54adf46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cBpdeQXJ9FswsUgMQDAE2F9Gd54s9bjzv0MLrarxfXWI58z590BZMbiyKs1ollJc0mupZ5k5NC1ApidjzNVnmLY76S/LW+CoeU5X347bY8xcHAzL5896iE2B0omT5lrk+eAGrjfKPIXVVhlbPQn6CkpMWRNnSOD1FFYHr27lH26tO3z4w4gMxJYSu1kGicz3TCrMONLPd3sc65XhBf1RCcLHN4W1AKX6CjgX3W31K/AmPJ3MWaEvrPGAs8TZs0ewSBXa7rik2F/GkrduuYAaoUrwlpQeST2uyFeqmcggAtZAbJe3Ll5DvPJFE7pt8JCY+79jiiHjbRDI7TEZ+FECYaUtG5StSG+HTwvqb4wuu7DrCf+06sP5fZMkYVIM1S+mEurWllUGu6r51DU3tw9iHguywviq5G0xoPJjqZ8vK8yifKo3BWE1LiqNjYVBpw0fV8O3Xgo2+9x3KihJAVW0DJamWHKFoiKmfK8URPinILHbSu56avNEYVJrIeMjjJQv/SkXtjv58s86ValnbENlZ+OraT8ioodG6yrJfHsRXNeRyeg6caXimz+nwAAiU1SB6Es4Xf0ped5A0uGD94CL5Ktyb5elFfLICHy5D+HV1W1O8RejdrCOgc9t9eybEVRiAH+MA3mzYfx67hQT8ZMmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39840400004)(186009)(1800799009)(109986022)(451199024)(66476007)(54906003)(66556008)(70586007)(66946007)(316002)(478600001)(26005)(38100700002)(6666004)(41300700001)(6506007)(86362001)(6486002)(6512007)(2906002)(4326008)(8676002)(66574015)(8936002)(83380400001)(2616005)(5660300002)(7416002)(44832011)(1076003)(36756003)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wFN5mEzmUpcr9A6A5YXff5rvFAy8LJfriVaihoyOedehWwvNDaI4rKIHxmoY?=
 =?us-ascii?Q?JWUQourZFS4+bosUrkMhb9uWIRaGpjnvmOSbiYW65twH5sohV4CerKbE70ML?=
 =?us-ascii?Q?1CYtn5Ys4HIJ/bWh4B8AFnUlT6gAWWb2BbLDBV2y94udYCkekcGJXmHaWuND?=
 =?us-ascii?Q?Ge5N1brp7VE9sEtL6rt9UDf8EaZ6lK8GgcEMw5DoL/VuJ/TW9JbVe8Lu0UsI?=
 =?us-ascii?Q?mSBD8CCpSNMTLKrPBpP02zdFhAHiBRQuS/m/nFL12AY8ptzpH5vWO06wnxUx?=
 =?us-ascii?Q?+04F4aLDjXTmTU5reIyWchgeBVtYLMK/x68XEHlq4zXoHi+Cx33qGR64S6gK?=
 =?us-ascii?Q?vEql4U4ejmO1Rdsv7033fOXd0wTbP0mrvw+19B5j3129JblRRO2b78r3ATlt?=
 =?us-ascii?Q?lE3ABfULDdXH+4ZTiycmKDiAXs5FdRYNEO6/teBVLcUytaqpBOmZ1sHoUBVE?=
 =?us-ascii?Q?/QQ0cYu1flGfY6tHzEnAUNFTpk+n1mhtDoe4KpYzbyjtPHhu2GBKTLeRIrHz?=
 =?us-ascii?Q?WDEPOUsvFYX2wXWtLQKvHEoUzYs2E2tEdqzVlzAC7M6r+Kudhj7nhUUVbcz4?=
 =?us-ascii?Q?A601NL1tleIPTHcGOLlkbqHxoDBy8uTEtt0vIawNjFJxAzSn0dkkh5FxWEz9?=
 =?us-ascii?Q?bp5A5akRQkLKzvidUcgh1WUwPdxjisg+mK4M5RJYLusCzdCWdFIUlLXGJ2QU?=
 =?us-ascii?Q?kDMV1DWL+xRPamInFIMi9N6h3hzsaXby5SkY7FX7DdRdNw86WeSeo5g4swWI?=
 =?us-ascii?Q?rKwI8bZTFcWJl3k/p1hhrNNgbk/M4pUgruVEqr4vIW3otI42pbSrFh+dTKG0?=
 =?us-ascii?Q?eCvNOT0yo6ocAF0orJayZBBDAekyrI/ElMscFlwAzqbibZECPVbp7VuZAZLx?=
 =?us-ascii?Q?1pJ4zParNJnenEiNNVxYADfGNXuFt4qrgsuZbHNQvPZDlmnphPCW4zIkxIIW?=
 =?us-ascii?Q?TG0hHIarFWLgnvA3JSCj58xIasEXFhd1G+N7QcPNIjNGI8kJMObDtJDe7Qs9?=
 =?us-ascii?Q?6byc2CKeulL96kvkqD93ADXQO1SQsbg/7kGWIA5lhiMV+t6Bv1MoaTICQRx5?=
 =?us-ascii?Q?2LOI5p8p05mEbcRgwgGXakQNwlqSF7+YSbDrPMw/kMWur5jqkcqAiN1sn+Qm?=
 =?us-ascii?Q?m1tondTBh5E10eYZTyYnNnHa1MeeXF86EqSjJJ/UJtddTomtIMT7PGtRJFTz?=
 =?us-ascii?Q?DOoA9YoHDPQf+v2vmVHX46chMvfqnQ3yZVzxDUrhEJGJJuriATpmsKMRMD9B?=
 =?us-ascii?Q?C6avgfaDdw9IfhrsSIjWzz+j+J2LTtqTzQ73y2goTJgRVvK1HkdUoGDHrX7H?=
 =?us-ascii?Q?BdJjJnM9HCilQt2WF/v/U4abo7vCwCJi/PTNpKLpI2CC0Sg86QT/GvE36HTs?=
 =?us-ascii?Q?q4jkK1ZxBxMV+7ubsIjLg3WXrzTA8ab9o152kegnZRj9oj6MphHk1lzmU28+?=
 =?us-ascii?Q?xIEp09KJfrhIhb18v51NmSWoriGDJvJoFgWbVlpnLuezeHI45THNN82nlqyl?=
 =?us-ascii?Q?K9k44JQXfMJQM5Je8//OR5l6PiOvuRrPEgFpqk5bJYsfjteuN5nhgJckrR4R?=
 =?us-ascii?Q?3tbtmuSkRSKfJRVmwIOlMsRYmBJvMrDtn8xOnfj4vvFvVMo+mjAfjDBB8t68?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 7880fef7-dcdd-40a4-e7ba-08dba54adf46
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 09:08:39.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHk49icLnOjKycjasicdfTl+JX2Qy0oFc4c09m3Cpd4M5hoTlf6pWJfFKzGHJ/lSu1Vii8il1/yu8xFHVzWJgrRanPBer44L8lzL+M7pgBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB1499
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create a topology with a host, and a router. The host (veth0) is in the
default namespace, and a network namespace is created for the router,
the peer veth1 is moved to the router netns. A dummy interface is added
inside the router netns, to simulate a network that has two neighbors.
An ECMP route to a virtual IP (vip) with the two neighbors as the next
hop is added.

The test uses perf stat to count the number of fib:fib_table_lookup
tracepoint hits for IPv4 and the number of fib6:fib6_table_lookup for
IPv6. The measured count is checked to be within 15% for the number of
packets received on veth1 in the router.

See diagram in the test for more information.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 tools/testing/selftests/net/forwarding/lib.sh |   5 +
 .../net/forwarding/router_multipath_vip.sh    | 255 ++++++++++++++++++
 3 files changed, 261 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/router_multipath_vip.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 770efbe24f0d..bf4e5745fd5c 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -70,6 +70,7 @@ TEST_PROGS = bridge_igmp.sh \
 	router_mpath_nh.sh \
 	router_multicast.sh \
 	router_multipath.sh \
+	router_multipath_vip.sh \
 	router_nh.sh \
 	router.sh \
 	router_vid_1.sh \
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index f69015bf2dea..75a7b138c399 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -787,6 +787,11 @@ link_stats_tx_packets_get()
 	link_stats_get $1 tx packets
 }
 
+link_stats_rx_packets_get()
+{
+	link_stats_get $1 rx packets
+}
+
 link_stats_rx_errors_get()
 {
 	link_stats_get $1 rx errors
diff --git a/tools/testing/selftests/net/forwarding/router_multipath_vip.sh b/tools/testing/selftests/net/forwarding/router_multipath_vip.sh
new file mode 100755
index 000000000000..9aefebd8085c
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/router_multipath_vip.sh
@@ -0,0 +1,255 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +--------------------+
+# | H1                 |
+# |                    |
+# |              $h1 + |
+# |     192.0.2.2/28 | |
+# | 2001:db8:1::2/64 | |
+# |                  | |
+# +------------------|-+
+#                    |
+# +------------------|-----------------------+  +----------------------+
+# | SW               |                       |  |                      |
+# | (netns ns-r1)    |                       |  | + $neigh1            |
+# |             $rp1 +                       |  |   192.0.2.18/28      |
+# |     192.0.2.1/28                         |  |   2001:db8:2::2/64   |
+# | 2001:db8:1::1/64     + vip               |  |                      |
+# |                        198.51.100.0/24   |  +----------------------+
+# |                        2001:db8:3::/64   |  |                      |
+# |                                          |  | + $neigh2            |
+# |                                          |  |   192.0.2.19/28      |
+# |                                          |  |   2001:db8:2::3/64   |
+# |                                          |  |                      |
+# +------------------------------------------+  +----------------------+
+
+ALL_TESTS="multipath_test"
+NUM_NETIFS=2
+source lib.sh
+
+ns_create()
+{
+	local ns="$1"
+
+	ip netns add $ns
+
+	in_ns $ns ip link set dev lo up
+	in_ns $ns forwarding_enable
+}
+
+ns_destroy()
+{
+	local ns="$1"
+
+	ip netns del $ns &> /dev/null
+}
+
+h1_create()
+{
+	ip link set dev $h1 up
+	ip address add 192.0.2.2/28 dev $h1
+	ip address add 2001:db8:1::2/64 dev $h1
+
+	ethtool -K $h1 tcp-segmentation-offload off
+}
+
+h1_destroy()
+{
+	ethtool -K $h1 tcp-segmentation-offload on
+
+	ip address del 2001:db8:1::2/64 dev $h1
+	ip address del 192.0.2.2/28 dev $h1
+	ip link set dev $h1 down
+}
+
+router_create()
+{
+	ns="ns-r1"
+	dummy="dum1"
+
+	echo 20000 > /sys/class/net/$rp1/gro_flush_timeout
+	echo 1 > /sys/class/net/$rp1/napi_defer_hard_irqs
+	ethtool -K $rp1 generic-receive-offload on
+
+	ns_create $ns
+	ip link set dev $rp1 netns $ns
+
+	ip -n $ns link set dev $rp1 up
+	ip -n $ns address add dev $rp1 192.0.2.1/28
+
+	ip -n $ns link add name $dummy up type dummy
+	ip -n $ns address add 192.0.2.17/28 dev $dummy
+	ip -n $ns address add 2001:db8:2::1/64 dev $dummy
+
+	ip -n $ns neigh add 192.0.2.18 lladdr 00:11:22:33:44:55 nud perm dev $dummy
+	ip -n $ns neigh add 192.0.2.19 lladdr 00:aa:bb:cc:dd:ee nud perm dev $dummy
+	ip -n $ns neigh add 2001:db8:2::2 lladdr 00:11:22:33:44:55 nud perm dev $dummy
+	ip -n $ns neigh add 2001:db8:2::3 lladdr 00:aa:bb:cc:dd:ee nud perm dev $dummy
+
+	ip -n $ns route add 198.51.100.0/24 \
+		nexthop via 192.0.2.18 \
+		nexthop via 192.0.2.19
+
+	ip -n $ns route add 2001:db8:3::/64 \
+		nexthop via 2001:db8:2::2 \
+		nexthop via 2001:db8:2::3
+}
+
+router_destroy()
+{
+	ns="ns-r1"
+	dummy="dum1"
+
+	ip -n $ns link del dev $dummy
+
+	ip -n $ns address del dev $rp1 192.0.2.1/28
+	ip -n $ns link set dev $rp1 down
+	ip -n $ns link set dev $rp1 netns 1
+
+	ns_destroy $ns
+
+	echo 0 > /sys/class/net/$rp1/gro_flush_timeout
+	echo 0 > /sys/class/net/$rp1/napi_defer_hard_irqs
+	ethtool -K $rp1 generic-receive-offload off
+}
+
+perf_stat()
+{
+	local tracepoint="$1"
+	local cmd="$2"
+	local out="$3"
+
+	perf stat -o $out -j $tracepoint -a &
+	perf_stat_pid=$!
+
+	$cmd
+
+	kill -SIGINT $perf_stat_pid && wait $perf_stat_pid
+}
+
+perf_evaluate()
+{
+	local desc="$1"
+	local expected=$2
+	local perf_output="$3"
+
+	RET=0
+	measured=$(tail -n 1 $perf_output | jq '.["counter-value"] | tonumber | floor')
+
+	diff=$(echo $expected - $measured | bc -l)
+	diff=${diff#-}
+
+	test "$(echo "$diff / $expected > 0.15" | bc -l)" -eq 0
+	check_err $? "Too large discrepancy between expected and measured fib lookup counts"
+	log_test "$desc"
+	log_info "Expected count $expected Measured count $measured"
+}
+
+run_test_and_check_tpv4()
+{
+	local src_ip="$1"
+	local dst_ip="$2"
+	local t0_rp1 t1_rp1
+	local expected
+
+	# Transmit multiple flows from h1 to vip and check that fib lookup
+	# tracepoint is hit for each packet.
+	in_ns ns-r1 sysctl_set net.ipv4.fib_multipath_hash_policy 1
+
+	t0_rp1=$(in_ns ns-r1 link_stats_rx_packets_get $rp1)
+
+	smac=$(mac_get $h1)
+	dmac=$(in_ns ns-r1 mac_get $rp1)
+	cmd="$MZ $h1 -q -p 64 -a $smac -b $dmac -A $src_ip -B $dst_ip
+		-t udp 'sp=1024,dp=1024-65535'"
+
+	perf_output=$(mktemp)
+	perf_stat "-e fib:fib_table_lookup" "$cmd" "$perf_output"
+
+	t1_rp1=$(in_ns ns-r1 link_stats_rx_packets_get $rp1)
+	expected="$(echo "$t1_rp1 - $t0_rp1" | bc -l)"
+
+	perf_evaluate "IPv4 multipath: fib_table_lookup" $expected "$perf_output"
+	rm $perf_output
+
+	in_ns ns-r1 sysctl_restore net.ipv4.fib_multipath_hash_policy
+}
+
+run_test_and_check_tpv6()
+{
+	local src_ip="$1"
+	local dst_ip="$2"
+	local t0_rp1 t1_rp1
+	local expected
+
+	# Transmit multiple flows from h1 to vip and check that fib lookup
+	# tracepoint is hit for each packet.
+	in_ns ns-r1 sysctl_set net.ipv4.fib_multipath_hash_policy 1
+
+	t0_rp1=$(in_ns ns-r1 link_stats_rx_packets_get $rp1)
+
+	smac=$(mac_get $h1)
+	dmac=$(in_ns ns-r1 mac_get $rp1)
+	cmd="$MZ $h1 -6 -q -p 64 -a $smac -b $dmac -A $src_ip -B $dst_ip
+		-t udp 'sp=1024,dp=1024-65535'"
+
+	perf_output=$(mktemp)
+	perf_stat "-e fib6:fib6_table_lookup" "$cmd" "$perf_output"
+
+	# fib6_table_lookup is called twice for each packet, for
+	# RT6_TABLE_LOCAL and RT6_TABLE_MAIN
+	t1_rp1=$(in_ns ns-r1 link_stats_rx_packets_get $rp1)
+	expected="$(echo "2*($t1_rp1 - $t0_rp1)" | bc -l)"
+
+	perf_evaluate "IPv6 multipath: fib6_table_lookup" $expected "$perf_output"
+	rm $perf_output
+
+	in_ns ns-r1 sysctl_restore net.ipv4.fib_multipath_hash_policy
+}
+
+multipath_test()
+{
+	log_info "Running multipath tests"
+	run_test_and_check_tpv4 "192.0.2.2" "198.51.100.1"
+	run_test_and_check_tpv6 "2001:db8:1::2" "2001:db8:3::1"
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	rp1=${NETIFS[p2]}
+
+
+	h1_create
+	router_create
+}
+
+setup_wait()
+{
+	h1=${NETIFS[p1]}
+	rp1=${NETIFS[p2]}
+
+	setup_wait_dev $h1
+	in_ns ns-r1 setup_wait_dev $rp1
+
+	# Make sure links are ready.
+	sleep $WAIT_TIME
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	router_destroy
+	h1_destroy
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.34.1


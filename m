Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95878B03A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 14:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjH1M3T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 08:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjH1M3C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 08:29:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2104.outbound.protection.outlook.com [40.107.20.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E29AE3;
        Mon, 28 Aug 2023 05:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTi21TR5jQAYr57SJA/itAx0I0NN6jb+vsytGwV+F51IrNg3vRhyLDMUOTY3z3xZggJhqv6DYiPz8mJX2V+H9kktwgL17m38M3Tm6FUXCSL2YJBRq2HPWyt/G8ShoRqDi3d6QIWTNaR5jVvDV8p4cSQXutOiY5Mo4ThrkBaSbpTHSgFI36++zYSyEjdfdArl96YK5EFl+3KIexH7MMQokBmXJgOayAJG8/6J8JYYTHjfP19GE8ST+L0D7LE7bYTweh1gIa8BpZY7c7+nDwIz0mFXGJVJcRz04YQnWUO5Om0pUzLs/tUVPsM7bg5NhjEoo3GRPy6VUtLHLpMj3f0J7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDdXtPY2jD0AbYZtlEe4gTzE1rwYZ3Er0OcdaOhpk4I=;
 b=gk3TMqj2cGx9ylwxO3xFC0SVczUDDvsciYGkeob7ncXhXAMlDKB9PVs3cRX6KVA/Rea3bGlSIfmTiYLKYgu0xXY8ZDy4k2zAeYdVXjczFtApiHVr7Zs2Rjpu6aEOpiuiLVXT6PnKvtjkDXPuGqsDMMASNz9CXobsxggycY2XhP8jsNrxaWkX6kn7XkGgRcTr2m9nqCCwmj/xY/Iitmb5LHkhux0nw4VAzfCz0GKGncWOHKBCuQmwab4/taZATpV0EsInnkoFDAvVUa0L2wucWq5jO6P83oGNvyzS7ejnbZ+WQ+lVEMugrD/LK1k8yUBrFyvRpbZmS/RC19QdfRg93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDdXtPY2jD0AbYZtlEe4gTzE1rwYZ3Er0OcdaOhpk4I=;
 b=MV6Gzvym7B+hftELlo/v7dLGfa6zPybiYX0E7wigpNovKLUNThV6TtS1SoC+a/ZmgtmoKhLTUW6g9SsWtUJph+WGmijEiNlvktHBOVF/Q9z22HtLp/OOsqGDN7A4HGC7Qk6fYzpcBHoE2831h4o1wvgN1oDxE2BVye5ciEFMSaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AM0P189MB0817.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:195::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Mon, 28 Aug
 2023 12:28:32 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:28:32 +0000
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
Subject: [PATCH net v3 3/3] selftests: fib_tests: Add multipath list receive tests
Date:   Mon, 28 Aug 2023 13:32:21 +0200
Message-Id: <20230828113221.20123-4-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::8)
 To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AM0P189MB0817:EE_
X-MS-Office365-Filtering-Correlation-Id: b612b7a6-c6fb-4a1e-aec3-08dba7c24ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vP+r5FQCc5itI8xIe3KNUgFVX4ZFvOoR3lfL4b3zYcAonJi59AlpYRq121KbYJqrdLyLUZRGZZPAoi/G8jHqEI/V0y9vUIXlfFpnNSq4+ylmHTE23mDfD1eWf7Sw3vU0OrkVNptDoIxbdsblMcihSXPHwwY2/rEs0I94gv3MWbA0NayP0ELUX+BVfXeDaZNOJ2VkNdsT4QJxT6d8Hk4tvDeSBmN694aFLRDpOx2XAqOZDN8iD4GIrg3tzFB25lAuPfzYaUNCaShCnzDiYwXYkH33jOPxXN1RrAS0Qsxv8ZGSDE3YpgtIo81emtTbByTfKH+KB9FnnvvsDlaujWr1UVH+e+bdAv7HaoENvxTn8wbU4lqGDvzisNfc8kA0GIvSX3U1XdeL8tFB5KfYWWrGltlDYqodZn6iyzJtPGQx/7VnvCJp5nP3/TqErrMKyUJOS06DBHPSmJmk/k9kNmNJSBRmLm5GJsZgXSyuD3l+EJnkhj6Kbs1fAfzGx8B0TcHuBb75wLRgEXM6DnbqUiaFPSfLISonbGdiuUYmUZbhjma7n6eFfs6Ky9JON6whir/RnFvheT9U3KcI5MSKZhjIYFxtlRQfXcLMc6kgdPoLS5yXPp0H7VxnpUEAf5DH78ckoQKzHH31oIR3XYVSLRfpuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39830400003)(376002)(136003)(1800799009)(451199024)(186009)(109986022)(1076003)(44832011)(83380400001)(6512007)(478600001)(26005)(7416002)(2616005)(5660300002)(2906002)(8676002)(8936002)(4326008)(70586007)(6486002)(38100700002)(66946007)(66476007)(86362001)(66556008)(54906003)(41300700001)(36756003)(316002)(6666004)(6506007)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WL8j1eMB0YSlaJKzo07sh1XxAoSWDVySq5WFuundpY64JCJ3e9J+ZxI19qe9?=
 =?us-ascii?Q?IASMqMlXUz93oTy7dRLrdRDXCyPVZyFrtFbbhNJ7grMcJ9XvyJjxFqJYpIqY?=
 =?us-ascii?Q?CgsaPpHtZqo0anz9zaBG/tRJGhvByrjjgy9jRvKWcLMWOalaC6lcb2L0IPno?=
 =?us-ascii?Q?UXqNfYq/g66UxtjrZt4VcH4brq8oTQUGYQKTTgKi2TTT/aq3lJlRhz062CCA?=
 =?us-ascii?Q?VfSruIJnLgbmn/Cn5IpEwZpu/tVTk+uCGipMGPKamrFO0p9ff97hVT+CvdAq?=
 =?us-ascii?Q?pCm3dg5V2GXetEYiIizW6otItdiq9BPT1VOT6iP5Gkj4InvhcevYwwjb6DvN?=
 =?us-ascii?Q?fSO1MbnAR+xKbJchdLv6t/2g2hRUH/BUgqKKOg5QEoToe94hgqWFklzlmqZQ?=
 =?us-ascii?Q?9nKCtrmDoOg3Voh1IVS8NpvdPh3Btt8XkX4RiQhWuaOSiVgjkLBzTTX6qdb9?=
 =?us-ascii?Q?jRscbIqtSE13jOfHwrxoKElitYHm46oB14xSUEAvbV6ioO2Jg0b/ohdMHSsr?=
 =?us-ascii?Q?5ZByyLSFP/g5jU2kqfj7Qe5Q4pqzoSDsFPzDnmG+Sq7cvAbtUJ11j4VJqj+h?=
 =?us-ascii?Q?X3oo4uKO89nm1yksdjv4+NobMfZXfPnId9TIiX1fEyoPI+iU/7KvKQfSb2/e?=
 =?us-ascii?Q?qX5/91JyYuCpMksUix2KUpZ20PRVS3EC9IX6EdxJsIHXoOcY0XnPAP8t4mlI?=
 =?us-ascii?Q?ZR4eXrayl3Sa8G2T1rkimttzuzvGcmHLBqeUHQa4aw/WPPlxH9hRxgcJD8Wk?=
 =?us-ascii?Q?gROYxEKpyjZCyDcmkGq32OM/7n57yUF4F0y8ccp10+1l1rymczgdOZl97ViB?=
 =?us-ascii?Q?QgM/eb8Vl8IQxiCcZ1zl/25hb5mqZ6rHqfVBpBnh9bK5oCmgJ5CcLrESEejr?=
 =?us-ascii?Q?ly1YkxV+IXuZx8KFcgzgiqlP+7E4wLcaktUv7EbQv/+uK0t8+YEGvi6xd0bT?=
 =?us-ascii?Q?gt2gsy49gJXswqIqF5G36oQMoqdCWbQaBCl2fghB8kokjdxBO2FTUeNuozVD?=
 =?us-ascii?Q?8s81MG3tzG/VxMTqaqiTph5rUQQ5u5LsObvmxCQqX2wSxGcGHS0ZlvEoABY9?=
 =?us-ascii?Q?esCKWU+zBVzH7N9YT56zYcIL81hOr/kk0+MMJxMiphHV+Gds2XsXfW8uoCMB?=
 =?us-ascii?Q?EeSJIs2MYM3fQVREOn2Igj6XFq1KCKIq3j/8a6Ha01kAqf+IK2y36elNPPaX?=
 =?us-ascii?Q?tDWVtMe8M6A6fKie+XcSUgztq9HTAO1Bw/4N9MLOFFN4Y2DKw04QkXkBg4kw?=
 =?us-ascii?Q?Uv6rABDbi879rfX2OkQMYN9FQFo3L7XbpjECjYDAoY8XRqsGKA7a2BTLW6Mh?=
 =?us-ascii?Q?ycQZKvBoHGqQOEMhnMYlmzO+qBQzTmCCk2GbfnxDPYPcXSumMTqDW4Z+6kUr?=
 =?us-ascii?Q?WzLcj8ob8td9MO7mIHAZqjX9sfeezy9yRO2KBarsTz4NP03eoUojBGns+Mcx?=
 =?us-ascii?Q?zLMbNudZJ+NU8HDZ1lHMNCfW2CH2C9+/I13r78m7217S1bkuORXxiVNv/rVh?=
 =?us-ascii?Q?vmVNy3Y401Wi8aE1fNIgotKgQNV/FGhOwQGx5x06ZCX9tnzKQwuPT05e+yzm?=
 =?us-ascii?Q?YcMhLbdC3HpU3T7Q3llXVkGDzyqRkTIzcLRRrwTgDuGBu7VHMb8soAjIKVik?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: b612b7a6-c6fb-4a1e-aec3-08dba7c24ab7
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 12:28:32.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4nrR2PLQCUUd+Gyx+Jk/0om7y2JT1HcMRzqXl10jwNkJeDYyw2ZwkcGzxOATQ3V+pNTM8iXiTOjOJQxNuP1gwjSb1kBkRG5v724A9nWaqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0817
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test uses perf stat to count the number of fib:fib_table_lookup
tracepoint hits for IPv4 and the number of fib6:fib6_table_lookup for
IPv6. The measured count is checked to be within 5% of the total number
of packets sent via veth1.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 tools/testing/selftests/net/fib_tests.sh | 150 ++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 35d89dfa6f11..1cf78cf4d346 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -9,7 +9,7 @@ ret=0
 ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
-TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
+TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh ipv4_mpath_list ipv6_mpath_list"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -2138,6 +2138,152 @@ ipv4_bcast_neigh_test()
 	cleanup
 }
 
+mpath_dep_check()
+{
+	if [ ! -x "$(command -v mausezahn)" ]; then
+		echo "mausezahn command not found. Skipping test"
+		return 1
+	fi
+
+	if [ ! -x "$(command -v jq)" ]; then
+		echo "jq command not found. Skipping test"
+		return 1
+	fi
+
+	if [ ! -x "$(command -v bc)" ]; then
+		echo "bc command not found. Skipping test"
+		return 1
+	fi
+
+	if [ ! -x "$(command -v perf)" ]; then
+		echo "perf command not found. Skipping test"
+		return 1
+	fi
+
+	perf list fib:* | grep -q fib_table_lookup
+	if [ $? -ne 0 ]; then
+		echo "IPv4 FIB tracepoint not found. Skipping test"
+		return 1
+	fi
+
+	perf list fib6:* | grep -q fib6_table_lookup
+	if [ $? -ne 0 ]; then
+		echo "IPv6 FIB tracepoint not found. Skipping test"
+		return 1
+	fi
+
+	return 0
+}
+
+list_rcv_eval()
+{
+	local name=$1; shift
+	local file=$1; shift
+	local expected=$1; shift
+	local exp=$1; shift
+
+
+	local count=$(tail -n 1 $file | jq '.["counter-value"] | tonumber | floor')
+	local ratio=$(echo "scale=2; $count / $expected" | bc -l)
+	local res=$(echo "$ratio $exp" | bc)
+	[[ $res -eq 1 ]]
+	log_test $? 0 "$name route hit ratio ($ratio)"
+}
+
+ipv4_mpath_list_test()
+{
+	echo
+	echo "IPv4 multipath list receive tests"
+
+	mpath_dep_check || return 1
+
+	route_setup
+
+	set -e
+	run_cmd "ip netns exec ns1 ethtool -K veth1 tcp-segmentation-offload off"
+
+	run_cmd "ip netns exec ns2 bash -c \"echo 20000 > /sys/class/net/veth2/gro_flush_timeout\""
+	run_cmd "ip netns exec ns2 bash -c \"echo 1 > /sys/class/net/veth2/napi_defer_hard_irqs\""
+	run_cmd "ip netns exec ns2 ethtool -K veth2 generic-receive-offload on"
+	run_cmd "ip -n ns2 link add name nh1 up type dummy"
+	run_cmd "ip -n ns2 link add name nh2 up type dummy"
+	run_cmd "ip -n ns2 address add 172.16.201.1/24 dev nh1"
+	run_cmd "ip -n ns2 address add 172.16.202.1/24 dev nh2"
+	run_cmd "ip -n ns2 neigh add 172.16.201.2 lladdr 00:11:22:33:44:55 nud perm dev nh1"
+	run_cmd "ip -n ns2 neigh add 172.16.202.2 lladdr 00:aa:bb:cc:dd:ee nud perm dev nh2"
+	run_cmd "ip -n ns2 route add 203.0.113.0/24
+		nexthop via 172.16.201.2 nexthop via 172.16.202.2"
+	run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.fib_multipath_hash_policy=1"
+	set +e
+
+	local dmac=$(ip -n ns2 -j link show dev veth2 | jq -r '.[]["address"]')
+	local tmp_file=$(mktemp)
+	local cmd="ip netns exec ns1 mausezahn veth1 -a own -b $dmac
+		-A 172.16.101.1 -B 203.0.113.1 -t udp 'sp=12345,dp=0-65535' -q"
+
+	# Packets forwarded in a list using a multipath route must not reuse a
+	# cached result so that a flow always hits the same nexthop. In other
+	# words, the FIB lookup tracepoint needs to be triggered for every
+	# packet.
+	run_cmd "perf stat -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
+	list_rcv_eval "Multipath" $tmp_file 65536 ">= 0.95"
+
+	# The same is not true for a single path route.
+	run_cmd "ip -n ns2 route replace 203.0.113.0/24 nexthop via 172.16.201.2"
+	run_cmd "perf stat -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
+	list_rcv_eval "Single path" $tmp_file 65536 "< 0.95"
+
+	rm $tmp_file
+	route_cleanup
+}
+
+ipv6_mpath_list_test()
+{
+	echo
+	echo "IPv6 multipath list receive tests"
+
+	mpath_dep_check || return 1
+
+	route_setup
+
+	set -e
+	run_cmd "ip netns exec ns1 ethtool -K veth1 tcp-segmentation-offload off"
+
+	run_cmd "ip netns exec ns2 bash -c \"echo 20000 > /sys/class/net/veth2/gro_flush_timeout\""
+	run_cmd "ip netns exec ns2 bash -c \"echo 1 > /sys/class/net/veth2/napi_defer_hard_irqs\""
+	run_cmd "ip netns exec ns2 ethtool -K veth2 generic-receive-offload on"
+	run_cmd "ip -n ns2 link add name nh1 up type dummy"
+	run_cmd "ip -n ns2 link add name nh2 up type dummy"
+	run_cmd "ip -n ns2 -6 address add 2001:db8:201::1/64 dev nh1"
+	run_cmd "ip -n ns2 -6 address add 2001:db8:202::1/64 dev nh2"
+	run_cmd "ip -n ns2 -6 neigh add 2001:db8:201::2 lladdr 00:11:22:33:44:55 nud perm dev nh1"
+	run_cmd "ip -n ns2 -6 neigh add 2001:db8:202::2 lladdr 00:aa:bb:cc:dd:ee nud perm dev nh2"
+	run_cmd "ip -n ns2 -6 route add 2001:db8:301::/64
+		nexthop via 2001:db8:201::2 nexthop via 2001:db8:202::2"
+	run_cmd "ip netns exec ns2 sysctl -qw net.ipv6.fib_multipath_hash_policy=1"
+	set +e
+
+	local dmac=$(ip -n ns2 -j link show dev veth2 | jq -r '.[]["address"]')
+	local tmp_file=$(mktemp)
+	local cmd="ip netns exec ns1 mausezahn -6 veth1 -a own -b $dmac
+		-A 2001:db8:101::1 -B 2001:db8:301::1 -t udp 'sp=12345,dp=0-65535' -q"
+
+	# Packets forwarded in a list using a multipath route must not reuse a
+	# cached result so that a flow always hits the same nexthop. In other
+	# words, the FIB lookup tracepoint needs to be triggered for every
+	# packet.
+	run_cmd "perf stat -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
+	list_rcv_eval "Multipath" $tmp_file 65536 ">= 0.95"
+
+	# The same is not true for a single path route.
+	run_cmd "ip -n ns2 route replace 2001:db8:301::/64 nexthop via 2001:db8:201::2"
+	run_cmd "perf stat -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
+	list_rcv_eval "Single path" $tmp_file 65536 "< 0.95"
+
+	rm $tmp_file
+	route_cleanup
+}
+
 ################################################################################
 # usage
 
@@ -2217,6 +2363,8 @@ do
 	ipv4_mangle)			ipv4_mangle_test;;
 	ipv6_mangle)			ipv6_mangle_test;;
 	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
+	ipv4_mpath_list)		ipv4_mpath_list_test;;
+	ipv6_mpath_list)		ipv6_mpath_list_test;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.34.1


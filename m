Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E920C78DAC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjH3ShH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbjH3JOG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 05:14:06 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2107.outbound.protection.outlook.com [40.107.241.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969ECD2;
        Wed, 30 Aug 2023 02:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQXJNilCplBaS//hBH4uVJhCiQsEiRJn8GaSOQdxQ27roueezjcuPX9axY8ohxK3XqJf0C6vEjkyp+McZz3GcUYpSLHQNINDdZhy0EvBwmOXYlXrCZeofzZEx9A7cofOrsoc+W6uVOXZ0RXHKa2GtRCe/YYNBGioIKqA5Ap6N3q04BWZPc2B3IDbFLHC3z/T9zoVO1vXHyltpA/Q0e0voAtHyb0BskkNiP3C6RaS/O7umi8ObLvguQLCrT6pU0Anh2EAbeZ+hLjGaGGVsHiNlfE1twGlsqRECI30Aek+VhXDXfW0j/DHhYCfFI2TztBDS5kL9w/ggcXyhlbGXXT9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aITOkYZxw+sCNlDp0ho1SDATgMLbyhuStRLDxu5hvpA=;
 b=h3cjbRWKSuq0oQpWKEyNDCZuQagzbfSH3ZfkT8EMNU8zDxRWrFDbcBWF25sUYaQbYsJ1AoIcu6C2fhVxAUt1XV6w6cLO+lmSsXOvueOuT+ARkReAoqk4cAiCOjGlHaaBovK6a4Gb2URnlRjZ4rJO7D5PkbmqCvsy8AMnIyipy/hEq4gWC40F6xf4X4WlORb5DZvMmMHYpy48jTMskgFSLhJc/KMiYDFKY1eUyxS2tOnZ4UzlwUKfarZupc12Q6KsqELrfdr5YboR+YAY5jgma7pYLfosf5kviXleQoW+5qjmj1AZiz1MdSgJaEDES+VGspikfxjt5qn8+FCc5gNBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aITOkYZxw+sCNlDp0ho1SDATgMLbyhuStRLDxu5hvpA=;
 b=BwA1CPCewUih2SFCHW++nxWnlSVHsrBn22pGYpysJbhJicw5oQrzjB/9WjKfLAaPo2aVOXGTGnJ3LYbEJ4N04EdAu6+oCJKJvG9Bb8huyv9aLNcUPvr0bY053edQkamADwpAUbvTsDYfSIgHaWAp9DfxjzhIKBpk0S8cbKNanEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS8P189MB2096.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:52d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Wed, 30 Aug
 2023 09:13:59 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 09:13:58 +0000
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
Subject: [PATCH net v4 3/3] selftests: fib_tests: Add multipath list receive tests
Date:   Wed, 30 Aug 2023 11:13:41 +0200
Message-Id: <20230830091341.17273-4-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830091341.17273-1-sriram.yagnaraman@est.tech>
References: <20230830091341.17273-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF000013D5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1::d) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS8P189MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: 5704ad02-81db-490d-d1ff-08dba93971a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umLQdF1gVOTSO4+hO2XKDNnoFNfRoNJ5CZ30CTpttib9JkqrAqQO79O0DUYJCUrdyuKcUDRFueIwVZdkD8C+SNTaEbzSjpZu1j/anphiF58rP+hEuBknGQmoEy8PDYLpjWKG7cXNdlx9ArhyliLI1oUUf0P8hy9CJrcqNOvBRV02t2CaXsyblT2q2fdlFRJzjsOzvROpRP0u/N3CFFVliG0PzuT1hbL47ppxnv8N02fjCWIDAWWx5OsSklMLutvemdPe5eTybrrk73XALCZhMPlsAGPcnU/h7V78m8SEF3eFcYuUYjqN+nJIKgN09ndHGaq1lUHMadiBG3Xg31yNvQHFWJ5rFkKPBB0PoPIQw9DvtqT+x7qWoB/JtDJIJNsNss0+c965q3JdIS0mI++5GOTCNhyEWJwvE6Y7o3rV0aHPCoFipMzPGLPcOJTnt/+k++SANj0X6Z/OBXlvH10igomcDMrJbx1d4sZ1ze/FjwEJhD0Dn+wyaUZ/50mkb+i21nj/VkTJcOQhaaiZUp9vQKw249XAY8JcDlESjF7414vJNO37z964kIhRj2P8Wf1rOXs7HILgn9sxSUtUFs32EUMXjhjdoQuFwhvdq3aj71DO7gU4mSysSpdy/iV1BbRm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39840400004)(1800799009)(109986022)(186009)(451199024)(8936002)(6666004)(478600001)(70586007)(66556008)(6506007)(66946007)(66476007)(54906003)(6486002)(316002)(38100700002)(41300700001)(6512007)(26005)(44832011)(5660300002)(8676002)(36756003)(1076003)(83380400001)(2906002)(2616005)(86362001)(7416002)(4326008)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHzldkeKa+2YWc/Xo5OGRieKE7HBR75EIySZn5k9C+1CGIvogHIZi1TwMNvm?=
 =?us-ascii?Q?ZgZi6lApip6y/HHTwrwGGaw3BOoyj/PJMU0cfDr6Lh8d65opPnGDMk7rqSHq?=
 =?us-ascii?Q?wi1SumC34TB1UbRGYWijUB2Fi6eouYEUkN0I7JUT+Yporn/usKXesdR1IKza?=
 =?us-ascii?Q?AnrRg5MDK4CbmueHII6ZmgEGBUi/w0ypZhS8S1d2awbnrin/E6qMp+IMTNJp?=
 =?us-ascii?Q?5ypb7pL17KSfP4EJWOONY/ubDVhpR5Mac9qGJGtfh9fkqsa1LpRE4fdsnYNK?=
 =?us-ascii?Q?P0yasOZkcb9M3EHT8XkuOf6zOytcMgoqBN8BKEOqlcGZj+/dZloI/oRQ4zeT?=
 =?us-ascii?Q?bdSmZeYmNENzNsxEJr4V5qF9Hc2yjkyIaYqNSfqHB2N6GgWayErw3yRyOSO9?=
 =?us-ascii?Q?j5etXrxu4JRBCiOluJaEJRRVLSGyJWqc2th2fUUKfEEhZwO7bJM0vlLnz10d?=
 =?us-ascii?Q?sQCcfLcthcgqrDzChr+QUKthlvYH1kNtGgP2ZhBpq02LN9RrGRRNCYVL3SU/?=
 =?us-ascii?Q?oz079EXA9rnfdZ1jWhnP9hY+TW0ibf+wCF0uMnQmFg4nFUe3yi5isxd3eSeq?=
 =?us-ascii?Q?8e3vVlCLxSQLvIh/Od0qK1eBtUTuvIsbajllO8wvb/InC7f5nrimdF7uVC31?=
 =?us-ascii?Q?RfAhzk0g42ODeQ8PTNZlglDZtifdaI/oI5lJXj5+6LOyfyvNGt0rselUQrzz?=
 =?us-ascii?Q?XFF2hC/eBQa7aXj/LEpQ227NFucIC++vU38wcBYIEgtxhLXYWQvcb5zzX7kf?=
 =?us-ascii?Q?RPiTRrV5MaYdml4sDjaatZ/tH5p3mVUHjf6yMtOGqt6n5VkY8B8b2djLi8m1?=
 =?us-ascii?Q?26ygYRbAFjlyb9Xr97gVk00F7TostlmtrTBhOxLwqgUOsBVOdffWxlWYL6yN?=
 =?us-ascii?Q?PN828tyZZ3NYZkEp6pOoPIvOKPxWkPE3agFQrLKlpTtUdOzjilSWZJkkSWap?=
 =?us-ascii?Q?bIZ5v3RuRi3+fjLHUptTRY0LUglEEWc2cdziGZpq58BzTRti2/EWfALKbcBE?=
 =?us-ascii?Q?zAQEhjJF5Uz/TonCcOuTx6zFIFBpgUwvHfkPR49auX7IjF1Uh9hr5J+orgQR?=
 =?us-ascii?Q?m3PPNx/l4njn2KsH7oqyih3tZoqAg3oPTa1BZCzbCkKGoXL219kCbeBhIzwT?=
 =?us-ascii?Q?a8qYjWfImBIY8k91un3wLGDyZSauQiio6T/SnA7ICSGFMIDUktT+EpEagmKy?=
 =?us-ascii?Q?naHjtvK6lOusuLS/addSQUKfW1oN3ApG+RGOGQk1Ugzkn6RYhWjTM/wgzo6J?=
 =?us-ascii?Q?81BLXGOCZvngWRKza7XApcAT5Dmu/eYHdKCc44x0WIBV1XzoD9x4fvFjTblP?=
 =?us-ascii?Q?IQoeJoBe3cJyvcaAAsTBEJ7fWdeQ6C5+MKsAlVK7Yscldp9TAlTA0fWXog2z?=
 =?us-ascii?Q?bNkZtYkP+kGsV1RVZn11gBi0SJL/TMBQbCMyOYjPyZfuBIt02FgYyQmJqCsk?=
 =?us-ascii?Q?13G15QcUsDfqnaOtd+0JQ5BISiZn5r8O10JHPCL1b6Heigdd7QQPkMoUayTq?=
 =?us-ascii?Q?spJGUYbiBD5Fb7v9V17XU71oRoi1cyjuoOUbYIDsOPLMlJtc2IwQtO3X0tf2?=
 =?us-ascii?Q?/rbX8OHjAtxTVg5g1ThB9mdMXXJZkh4qeyhqf9OCIuWhvE5lEydgI+/IazJP?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 5704ad02-81db-490d-d1ff-08dba93971a2
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 09:13:58.8884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHJb+hdTd5LQw1vDYWvS3Fb67wib/td04zQSnpo9Kj9fZvcfOVQeeAmxBuACM0uX8DLQjDZyTzalnWAe2ilzL+gKonDIH76feSj7MuCOd6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2096
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 tools/testing/selftests/net/fib_tests.sh | 158 ++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index d328af4a149c..42f49fa48c26 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -12,7 +12,8 @@ ksft_skip=4
 TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
        ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics \
        ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
-       ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test"
+       ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test \
+       ipv4_mpath_list ipv6_mpath_list"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -2352,6 +2353,159 @@ ipv4_bcast_neigh_test()
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
+link_stats_get()
+{
+	local ns=$1; shift
+        local dev=$1; shift
+        local dir=$1; shift
+        local stat=$1; shift
+
+        ip -n $ns -j -s link show dev $dev \
+                | jq '.[]["stats64"]["'$dir'"]["'$stat'"]'
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
+	local t0_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
+	run_cmd "perf stat -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
+	local t1_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
+	local diff=$(echo $t1_rx_pkts - $t0_rx_pkts | bc -l)
+	list_rcv_eval "Multipath" $tmp_file $diff ">= 0.95"
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
+	local t0_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
+	run_cmd "perf stat -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
+	local t1_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
+	local diff=$(echo $t1_rx_pkts - $t0_rx_pkts | bc -l)
+	list_rcv_eval "Multipath" $tmp_file $diff ">= 0.95"
+
+	rm $tmp_file
+	route_cleanup
+}
+
 ################################################################################
 # usage
 
@@ -2433,6 +2587,8 @@ do
 	ipv6_mangle)			ipv6_mangle_test;;
 	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
 	fib6_gc_test|ipv6_gc)		fib6_gc_test;;
+	ipv4_mpath_list)		ipv4_mpath_list_test;;
+	ipv6_mpath_list)		ipv6_mpath_list_test;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.34.1


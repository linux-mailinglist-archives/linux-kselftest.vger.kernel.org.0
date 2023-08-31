Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9584F78E789
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 10:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbjHaIEE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 04:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241403AbjHaIEC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 04:04:02 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2133.outbound.protection.outlook.com [40.107.22.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C261DCE7;
        Thu, 31 Aug 2023 01:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONB4iq87OqRt9iQ1sMjdVRuxWRzN3aMq74J4kiRrR9qri71TFOSXBdavk4TdxBbjFeKuviW3h4vjtYu2nM5sMaR/BAEYfy/g5qngvCr+b6RgNKZs68V+wPOY04UEHyItrXFZnPdJyV9LpdSDjl9bDlpPvFafjHvSUft4vJphhONV8u39xAItkc4XF3azpB/C9AJ0aMifParbxjACtj0k8psU97Tg456z9WqhOHj3cgzE9PDamhZgMK9XPh22iArwBsghacfJ1m6FtniOs9ovVAC5wgqiQkxFHBSUGVeozOM9l4o6w3zYeNs1tC1guNutp2+femYqS0yoQJtLwadmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8v+GHjlDzHL/t070+Y37pKXuwkSJB9ccc/xn7nJFlqQ=;
 b=FpT8FpRps5Wkt+hQWbzkGVDYoUolMR2GttsGVR9CMyiL2+9KKlJ4UGv2KqoOKUEUXl0fbsUUrKfQqew51/L0vhGYTFym/+Gh0WwJICdoBsD7N90Teund2SiEo1dftxWnev5xVwVmcBkNzbrvQ4JwNS/F5TqlXG81DUUxP9SIniwjn8aVimXKRl0U7NR3dL3PmxMTjhdfs4J5XjiJYYeSSxGx6kYzpHcUGhse1YIwK+cJMZgLxFH55Oc2zM+b8hzTAv7NkckSwOcr2VP3wgyOzsGLoCBZWZ8LU1BroAv4/NsR+UXAH6slG4tDO7eWWj+3D85FAf7LEnnhT2rU3FQu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v+GHjlDzHL/t070+Y37pKXuwkSJB9ccc/xn7nJFlqQ=;
 b=gnQtefOmBA7srmTU05vf/8OrbvDR8t/Qn29uj+ObNS0Au485mzraNouwSeBur7FtsmyUAr/imtaeKKf4hxPIKAArFnJt3O0OYiL1ua/URUUz5ocSjTB3HuD5iVJhIPj0ze4DG0Vz1H0nRc14TVaLvKMbOE0/ppEECCuqgYBqqmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by DB9P189MB1929.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:33a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 08:03:43 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 08:03:43 +0000
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
Subject: [PATCH net v5 3/3] selftests: fib_tests: Add multipath list receive tests
Date:   Thu, 31 Aug 2023 10:03:32 +0200
Message-Id: <20230831080332.2495-4-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831080332.2495-1-sriram.yagnaraman@est.tech>
References: <20230831080332.2495-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0054.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::24) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|DB9P189MB1929:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a673d5-e7d0-40c2-d6d5-08dba9f8cb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUuKI2X22EinKdKH3vzkZLnUUP9AvSvW8PRFSUeRuqFRkt6RriYzm5XHGKmN9d+bbWyyBYexBrs1Fz/Ya712OYw6vzCgAFG5HTmjiQlM57YdRUdwqvRWIkOV3xwSbmtUZ29wyh1eakQpIT0CkNhMrr9EWp3sCNVQVpv8jCb8dyvNhcCKUUhoKtg/SGrC4lsVfInXdAmEbGl7MwVTi+y3QoegHbD9p+r11ks5F6bv8r1HAh98/olgis11NGH94i5kWbMStxleTgbMclj38LTBEqsbVCcmq7HVlHOGpv6D8UrLq/J3aLJXk1SMXBvm4tS+f3oYhwfBOciqU+JAwsUeUUiMpzeGJ+/lKfRwkCRC3iNlw250SIJhOZ5NyvR+8EdfZrEHyRHBZGpNRjlnbh1yDdQb3O0LvbamTy1TrJY2NdBtoMN4usZPFp6jH7ZqdtDu4/OON6S9cLdaWt3tnsZhuDStGWrTWaF/0U9TBHlpe1koPCR2sWARmPXfx0Ex6s+EQxb97dHTxg0iQjfpphqfgtCyy6SvVpGaw0huH9r9LZicH/UvbVgJiUuLDCcXJxRu4Yb43hV1y1e2UPVcDVQW5WRqa960emLqAqnbR/JGkrulZmIXref9vvkd30eBC8rA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39840400004)(376002)(396003)(109986022)(1800799009)(451199024)(186009)(36756003)(7416002)(83380400001)(8676002)(86362001)(44832011)(41300700001)(8936002)(4326008)(5660300002)(6666004)(1076003)(26005)(2616005)(6486002)(6506007)(6512007)(478600001)(2906002)(38100700002)(54906003)(66556008)(66476007)(70586007)(66946007)(316002)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cHcpPthBcDF8vrFNhL72ki/jlJoXX74HujKAvvhzVDmQT0mC6aakCtKWbaCu?=
 =?us-ascii?Q?rtcAeGxtuMkdBfApGtoq7ZQBWb2NJAl2q3J7/iXVTJlaPD8YGPsMyav3n40w?=
 =?us-ascii?Q?rdK67tVUl7Z6AZWek4o+l6w5zzgkJYo4U85H8Pr50Zfltkl6cmZRmP32BG2M?=
 =?us-ascii?Q?V9jkaeueI3tBEhXEtuV8gzQyETUYJqRtdNlnv8XiXkF/VgUSkiRCUNV4HXsD?=
 =?us-ascii?Q?xTrtc3qCxwvutF23Yf3hKxg8dI2E7S2dnVXFL4V5rdvnvsksTjMr/P4KOF1a?=
 =?us-ascii?Q?Ny1DDU07McGdJI2DGu9PKzjYcYt77W3KuGU72sNhgHGXTW+Nr1BJHH571Zqs?=
 =?us-ascii?Q?FZ39wlr0ngfc11q+YexVK7TwphymYUTxE/A2RTWa2P8yjKDTYiYuei5eFu7n?=
 =?us-ascii?Q?1CABvgte/sWxqfS22PyEWcYTiELRf7ZSr2hTCy22d2U8K6k0w86BuH2Mfkex?=
 =?us-ascii?Q?KHq3KhEAw4dVy2pd1SiE07sPabD8ze4K3FAwlCgBdXiTa50RU4FQKm4YO8QO?=
 =?us-ascii?Q?2gLZaiFLb63ccydjlzqC8bXekWiJ2TV/7FzaNBCADMKQDeGk6KCzWWmnl0YP?=
 =?us-ascii?Q?FmCysra3QRCk+ay8dDhsjwxBELnC+Xa+M9v2jJcb0kLEtJoUjHOGWn0aIrQW?=
 =?us-ascii?Q?FZIPO+RcqovSOzUTOLzkH1QSnCEaJA+da9SJ74yUHql+AlcebTGBfo1Wlc0E?=
 =?us-ascii?Q?MNcW1dYT3dV3PerfnQAaAIw3BPgjveDCatTQGE3DO09eK9iKebgRNNxQRodi?=
 =?us-ascii?Q?L5KQf6AgNOX83fPTjYOGneTggBl5q3jnChsrkI489Y1vHdwmxSv0S6Lkp1v8?=
 =?us-ascii?Q?ZE4gmggR3arqmgCjkQcgh7dv/N/ynY2NK+qJs8oajpwSAxY78Vqu61bYLQhU?=
 =?us-ascii?Q?DEttn/tEby/rG5PgIzhKo8hfvPxM26dE1FQBFZUSrWkga+uTybQNvukiLC45?=
 =?us-ascii?Q?BKJmQmyvUina1wpJCNwrRazHFCiiXGZUoKcnedzzsCvfnoPkt4g2H/HhiO5v?=
 =?us-ascii?Q?L+8Dyd+A0dGeYlp7Ka1gv67hLnB0wTYKlzU3CEqj7rtGTjewonYhpCgLE4Rq?=
 =?us-ascii?Q?7qXSEYUozljH6yzfPwPAnKgPrs1NE3btibiB3e1cUyC8Rzty1jvhX4na1JMM?=
 =?us-ascii?Q?0VuPN075aImae0qzN9cSvLDU7faTmJOSoKffccf4OrFVtT2tgyU5mqg55+yB?=
 =?us-ascii?Q?u2G3CuqBAshyDmeaP83LLLJlL5+BXBYRXdZFSayhrmRg5MsayJ+olOGDSxO0?=
 =?us-ascii?Q?nPIFborDf3qcMz89S12A9XWzTbesylUs+kLl06AtYlto81CzAX0xP2JzB0iE?=
 =?us-ascii?Q?L8e4pAB+qa+Wkceff+NIEvc+TQgN26+MbdYnLsq+0+vf8+b3TjyqyMM0LN+g?=
 =?us-ascii?Q?EX7b6t6X74kKRcsDMH9pu8e6/QrTOIW2KEHYyl7F7AcDkC+5BLIsF4gpsB/I?=
 =?us-ascii?Q?FLdjiotKfwiEeEeNqe6JH43guo1zTZ7/q2EFiKoCMr9U5TFLaqYiIcFKKH5k?=
 =?us-ascii?Q?NMs1ISPvcquoVCvrbAB9VsXyh9TuH9tnZ1cP/ZAOkYy4CgK0O82PShJ7EKHJ?=
 =?us-ascii?Q?7M+0OWyyh9vWs9fV8w2wb29IdaM9ygcmVYz95ae+IdPB/2QH0+QWH3oDie5x?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a673d5-e7d0-40c2-d6d5-08dba9f8cb4e
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 08:03:43.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxsBFf7FKA9BhOqV2XzR7hd4NBq1yww0i5/CbT+pWlrOusYyXNGIgi3STNLHSEkPqh/g53+xdvNBww/P1EQIFACD5cV8Shu0+oL997uE3g4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB1929
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
 tools/testing/selftests/net/fib_tests.sh | 155 ++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index d328af4a149c..e7d2a530618a 100755
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
@@ -2352,6 +2353,156 @@ ipv4_bcast_neigh_test()
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
+	local dev=$1; shift
+	local dir=$1; shift
+	local stat=$1; shift
+
+	ip -n $ns -j -s link show dev $dev \
+		| jq '.[]["stats64"]["'$dir'"]["'$stat'"]'
+}
+
+list_rcv_eval()
+{
+	local file=$1; shift
+	local expected=$1; shift
+
+	local count=$(tail -n 1 $file | jq '.["counter-value"] | tonumber | floor')
+	local ratio=$(echo "scale=2; $count / $expected" | bc -l)
+	local res=$(echo "$ratio >= 0.95" | bc)
+	[[ $res -eq 1 ]]
+	log_test $? 0 "Multipath route hit ratio ($ratio)"
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
+	list_rcv_eval $tmp_file $diff
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
+	list_rcv_eval $tmp_file $diff
+
+	rm $tmp_file
+	route_cleanup
+}
+
 ################################################################################
 # usage
 
@@ -2433,6 +2584,8 @@ do
 	ipv6_mangle)			ipv6_mangle_test;;
 	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
 	fib6_gc_test|ipv6_gc)		fib6_gc_test;;
+	ipv4_mpath_list)		ipv4_mpath_list_test;;
+	ipv6_mpath_list)		ipv6_mpath_list_test;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.34.1


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE1F781959
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Aug 2023 13:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjHSLvA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Aug 2023 07:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHSLvA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Aug 2023 07:51:00 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2138.outbound.protection.outlook.com [40.107.14.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC60FE5C;
        Sat, 19 Aug 2023 04:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfTpQ7lfofi2wGq8My/M1jRgRpN6bKR0VVeBwxgKmvMounljC6ISfmg5tFXJHAvrH4uuZO3tHTkNW/403+dqSALSmG6Gs5wLESugLnp3U9H96FOw/NnUx/3hsj9sdtrDRJ65Y5lONi2W8aYXijvSbpop8swoZZIOIp2Nra5S/fa1vpEd7GzkQ7itMipQEiNnKGaqTmK0Aece29msFvOLC6YVGUde9vN7Op6kzaPb9+A0oYi4gQWu7hFdoBCYNGCfPQaYLWDl1EB8iKvFflpi03Nm6eYL+hjR92CXiUpoZjBSQOGpC82xp0EGV/ZgWu3a+HF5Q5eLnkZxtLFymXT48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkbX+ZI0nGHKx2vEMEZEgT7eMDVlwWbv/3LWOR9s4LI=;
 b=QIn2i4YivWqoizQuwGHvwWFWyfU7JTlim8zdMkNHaab2FbtfK4r4u9zGPvRbRWuQ9H3DabShIpzPND9/tRNRseeBrF1uMdGX2tNlgpEo41jcCUkCbe+SaiWbrHLF8w25jQDVUxxgNWzb5tWqbv9dyzFTxmovbIUUjrEPMLnAuJrERj7TEEovEgBxZFwRqwyM7eAIP3anSerSEuRRGm0nUiVfKBktoegCyZojawSp3jgorkjHTnefyQGAwVKn6DybqZghRnAZipifHzTCRvZ4LF2cd1DxDMWBwF/qTYL6SJVyiXxaQIvsKsGk3NELCpYtRruZmIduNXqlmNlUGPXXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkbX+ZI0nGHKx2vEMEZEgT7eMDVlwWbv/3LWOR9s4LI=;
 b=agn8FnT6r8YuLoq3r+V+l/pMUnZXb0GNhk9K60DqjrHEEWmvsL5L5JLZ5EF4VbUGaZBkPNEogMZzY6jEPjJJ2m5dcG6gkh+Rafii1Y3WwXfApEcgblD7tL4C/vaUwtYeBjt7TKE2EBrJmP6+Yye/eQHUhaEJVBWQeiL02XD+Z08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by VE1P189MB1133.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 11:48:33 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 11:48:33 +0000
From:   Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH 3/3] selftests: forwarding: Add test for load-balancing between multiple servers
Date:   Sat, 19 Aug 2023 13:48:25 +0200
Message-Id: <20230819114825.30867-4-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819114825.30867-1-sriram.yagnaraman@est.tech>
References: <20230819114825.30867-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::32) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|VE1P189MB1133:EE_
X-MS-Office365-Filtering-Correlation-Id: 66803608-4af4-4da4-d90e-08dba0aa3719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U77Jkv3UJ0vSS+8eilwhpgdPpvhcZkAeVEi36cakejXAcS+qcWCCANxf85oNfXnG3/XIMdun58jdljjjZojPG+qQuHWtD2W1fWSHnWF+2l+VNfFjZbDH37uIA1FhpIFyhldmlNybEo5DAG+ga3vusBIKMyfaVWOL2A6wU4spXO9iTpRoFk1tZMInXuhP7RrITxigspvneQzGUBZuxdP3ON8lS3yqbt2xc2nQQ6+BsEuy7uf9l2T3A3eFuhT9k9iPgkdOaBWeeahoC0euS1WCSBp8FM74QpxOEfRz1T/+onP4Y2D38TC6+WmsTxIQ9PoQZAOLAW7+kGtKYY886c2k0nabc+blf2YOMO4Lppo4VspGFZ79epz1Qtq+57ts+t5i2lIlUTCepIEcAAWHnlovVbybDJJ61Lnyz7sz7hLh2D19dRQD399xEfeyDbg9tqSPAtnp4gcEMF+ekEnZ4YQZH+rZHixgdTYXMzYitcB4yY00BodDQ8Lr54T40YTnrEb0RMiV/obVfK6/qlpdyrXZcJQ048VxYZ0eHNN4+/TUl5K0/UsNtbTd7v2dQC+LpgJsToVez9pXBIznISeWvZZb04tYydQ5i5KkqRkDEGr27T8ugdSXmIyzVrGvd7YbBaV6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39830400003)(136003)(346002)(451199024)(1800799009)(109986022)(186009)(30864003)(66556008)(66946007)(54906003)(66476007)(2906002)(4326008)(8676002)(8936002)(41300700001)(316002)(70586007)(6666004)(6486002)(5660300002)(44832011)(6506007)(478600001)(6512007)(2616005)(1076003)(26005)(83380400001)(38100700002)(66574015)(86362001)(36756003)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jjnTfGtidzbo/TuYdx433/se71DZq7rRCWnf4TDydzqNfgMBREXIiN6GmOVb?=
 =?us-ascii?Q?43uwcVLvKf2Q6G6L5QeFFVHbcycM0zPrEncSuXLoVZBd0iBQGZVqImRLllw8?=
 =?us-ascii?Q?1fM4RthrPQNxLLAeoqpy7SvxCvwR99Y62I+GE0nZHUWBqblizQiruglDZWnS?=
 =?us-ascii?Q?dpKHwIIk/WMPlJ4ncJSd3RpOU6E9DLptw2xmXveYF5Rq/K2OO4wh66+RoC7j?=
 =?us-ascii?Q?6EPIcQWWrSOQy+Atf0OpN6MJefUsTJtj2X05yFSwCPeaBFHs2GUospNVcd/G?=
 =?us-ascii?Q?LKWmVaeHrtlWi8UfApkY0Pka8es5Db67frBejukapMidVHR0tFxyTw+PfMh1?=
 =?us-ascii?Q?lbAn5neVXRbRjgYpd2kNqGnIR+xkXpJqrmI8p8sbkgc7XykU9ni224HzxMWc?=
 =?us-ascii?Q?IveBJEzsyLh5a6WPyFHDXLeEWmvErvDWJLvddsGVx4zS7p8JXcvSs12cQOKd?=
 =?us-ascii?Q?xQIfBfEXoGm5XkuukIXgGDIfslutS65gMlgcFIC3Bp+jJsydeLd+XZrqGTAr?=
 =?us-ascii?Q?uPKhTVdLAEzn7K34W3l1MYmQtZwP9w5kYh3igZOQgz+Ugdvt+45I6+1LBkpn?=
 =?us-ascii?Q?xe5FQz0G/WvnWS9xnH5x+lvL5Fv7jOOnkNoe7nLhuN3unai1O6cdn1EW++g7?=
 =?us-ascii?Q?2sMj9OCOR/5uxPzHKzfUMV5aBYDVMT2umK68MXKl1cgpjVqMHNqT1WC1YKKy?=
 =?us-ascii?Q?ozEU/n/aS4GaX5gLFOekivYGItSF5O2pzHmuvhKx1xHAAa1lciqoPh030UlS?=
 =?us-ascii?Q?ycSrcZMRS8pZW6jrZAQyIm6R7GF7OD9q0bElVjjPsTufT5jYE8Fd+cVPQ5QY?=
 =?us-ascii?Q?62/oknVLUegaqpJQ85yQMPT64dwUPZ8VHYuy/qGye2NsuqeebwsoZ1kogIhl?=
 =?us-ascii?Q?2FVg68KsghyG6WX2rBgVfnPdnz8yM4Q3f3iIdbsKeG70p4CUkZDVo6MFapKF?=
 =?us-ascii?Q?Dl0k7QmPZIwHJ3gqTKxegMrQ8OybYfjEYKTWh+3QSmw3XYT2lQe8tt2220BA?=
 =?us-ascii?Q?tLqR8liYNecsZejsmTYLYyKlrriMGLuUYg/YWXPHYQBxWL7X7tVCS/vFaHDZ?=
 =?us-ascii?Q?ISj9B77EN4qiB+33w2pW05lPEMYXt3RID2k7Ynvhz7pcm0K929sfcowcTpFY?=
 =?us-ascii?Q?3VGwIYv1QeB4l5WlyEaXHz49DbIxoJNSZ6mgXg30XsKW76sqHrFg1xhRmsqX?=
 =?us-ascii?Q?xe3ma/YlJURYd1zixxVplV5zAUOrVXzZWZhpUMtaw8S98RthPcUvFmY0i+r/?=
 =?us-ascii?Q?ea39yNHZeVGFuUfPzljo0DgdRf5hGMA/EOUQ8jJKkA4kF260DofsepJbFP8K?=
 =?us-ascii?Q?MHpkaLCdrvh6Zdyah/CaMlUonyQwYHyP2hrczVGkkkaanfdlxEM9CBxCyLJY?=
 =?us-ascii?Q?B8EWdYDd29oYtvkIMfkUpWSVTJWnDX3TARvXqVjRBA6nQAFgm1qQBFbRQxNF?=
 =?us-ascii?Q?wyLGiwwiM+WDM9I8ZUgIdFliR1exonZ+f289LmiYnM6/qWKuiQBK8B+KZQ9p?=
 =?us-ascii?Q?sChdQe/K9FvtXZo4ykWRFGSW0GsEZC15vACx23dFiorjwpdG4Ej19txm/4p6?=
 =?us-ascii?Q?Bl2jdeSvlSVJroGcZFvoWx9X3pJ+DgMKFh9C+Yjxx11oxo/x2aajGV4q/Tvk?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 66803608-4af4-4da4-d90e-08dba0aa3719
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 11:48:33.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJBYwOH7fPjPSM0vllCy6rNAcwI4OVoManKj1y+a+lzyl9wCLz77jVzrG84JumnT82zqgJ/5teu3fjmDaw1S2WFGIo/hfM1q0mbh/Yv9+J8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P189MB1133
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create a topology with 3 hosts, a router each in it's own network
namespace. Test IPv4 and IPv6 multipath routing from h1 to h2/h3 via
router r1 where a multipath route is setup to load-balance between h2
and h3.

See diagram in the test for more information.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/router_multipath_vip.sh    | 403 ++++++++++++++++++
 2 files changed, 404 insertions(+)
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
diff --git a/tools/testing/selftests/net/forwarding/router_multipath_vip.sh b/tools/testing/selftests/net/forwarding/router_multipath_vip.sh
new file mode 100755
index 000000000000..15c7598d42df
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/router_multipath_vip.sh
@@ -0,0 +1,403 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +--------------------+                     +----------------------+
+# | H1                 |                     |                   H2 |
+# |                    |                     |                      |
+# |              $h1 + |                     | + $h2                |
+# |     192.0.2.2/24 | |                     | | 198.51.100.2/24    |
+# | 2001:db8:1::2/64 | |                     | | 2001:db8:2::2/64   |
+# |                  | |                     | |                    |
+# +------------------|-+                     +-|--------------------+
+#                    |                         |
+# +------------------|-------------------------|--------------------+
+# | SW               |                         |                    |
+# |                  |                         |                    |
+# |             $rp1 +                         + $rp2               |
+# |     192.0.2.1/24                             198.51.100.1/24    |
+# | 2001:db8:1::1/64     + vip                   2001:db8:2::1/64   |
+# |                        198.18.0.0/24                            |
+# |                        2001:db8:18::/64    + $rp3               |
+# |                                            | 203.0.113.1/24     |
+# |                                            | 2001:db8:3::1/64   |
+# |                                            |                    |
+# |                                            |                    |
+# +--------------------------------------------|--------------------+
+#                                              |
+#                                            +-|--------------------+
+#                                            | |                 H3 |
+#                                            | |                    |
+#                                            | | 203.0.113.2/24     |
+#                                            | | 2001:db8:3::2/64   |
+#                                            | + $h3                |
+#                                            |                      |
+#                                            +----------------------+
+
+ALL_TESTS="ping_ipv4 ping_ipv6 multipath_test"
+NUM_NETIFS=6
+source lib.sh
+
+ns_create()
+{
+	ns=$1
+
+	ip netns add $ns
+	in_ns $ns ip link set dev lo up
+	in_ns $ns sysctl -q -w net.ipv4.ip_forward=1
+	in_ns $ns sysctl -q -w net.ipv6.conf.all.forwarding=1
+}
+
+ns_destroy()
+{
+	ip netns del $1
+}
+
+h1_create()
+{
+	local ns="ns-h1"
+
+	ns_create $ns
+	ip link set dev $h1 netns $ns
+
+	in_ns $ns ip link set dev $h1 up
+
+	in_ns $ns ip address add 192.0.2.2/24 dev $h1
+	in_ns $ns ip address add 2001:db8:1::2/64 dev $h1
+
+	in_ns $ns ip route add default via 192.0.2.1
+	in_ns $ns ip route add default via 2001:db8:1::1
+}
+
+h1_destroy()
+{
+	local ns="ns-h1"
+
+	in_ns $ns ip route del default via 2001:db8:1::1
+	in_ns $ns ip route del default via 192.0.2.1
+
+	in_ns $ns ip address del 2001:db8:1::2/64 dev $h1
+	in_ns $ns ip address del 192.0.2.2/24 dev $h1
+
+	in_ns $ns ip link set dev $h1 down
+	in_ns $ns ip link set dev $h1 netns 1
+	ns_destroy $ns
+}
+
+h2_create()
+{
+	local ns="ns-h2"
+
+	ns_create $ns
+	ip link set dev $h2 netns $ns
+
+	in_ns $ns ip link set dev $h2 up
+
+	in_ns $ns ip address add 198.51.100.2/24 dev $h2
+	in_ns $ns ip address add 2001:db8:2::2/64 dev $h2
+
+	in_ns $ns ip address add 198.18.0.0/24 dev lo
+	in_ns $ns ip address add 2001:db8:18::/64 dev lo
+
+	in_ns $ns ip route add 192.0.2.0/24 via 198.51.100.1
+	in_ns $ns ip route add 2001:db8:1::/64 nexthop via 2001:db8:2::1
+}
+
+h2_destroy()
+{
+	local ns="ns-h2"
+
+	in_ns $ns ip route del 2001:db8:1::/64 nexthop via 2001:db8:2::1
+	in_ns $ns ip route del 192.0.2.0/24 via 198.51.100.1
+
+	in_ns $ns ip address del 2001:db8:18::/64 dev lo
+	in_ns $ns ip address del 198.18.0.0/24 dev lo
+
+	in_ns $ns ip address del 2001:db8:2::2/64 dev $h2
+	in_ns $ns ip address del 198.51.100.2/24 dev $h2
+
+	in_ns $ns ip link set dev $h2 down
+	in_ns $ns ip link set dev $h2 netns 1
+	ns_destroy $ns
+}
+
+h3_create()
+{
+	local ns="ns-h3"
+
+	ns_create $ns
+	ip link set dev $h3 netns $ns
+
+	in_ns $ns ip link set dev $h3 up
+
+	in_ns $ns ip address add 203.0.113.2/24 dev $h3
+	in_ns $ns ip address add 2001:db8:3::2/64 dev $h3
+
+	in_ns $ns ip address add 198.18.0.0/24 dev lo
+	in_ns $ns ip address add 2001:db8:18::/64 dev lo
+
+	in_ns $ns ip route add 192.0.2.0/24 via 203.0.113.1
+	in_ns $ns ip route add 2001:db8:1::/64 nexthop via 2001:db8:3::1
+}
+
+h3_destroy()
+{
+	local ns="ns-h3"
+
+	in_ns $ns ip route del 2001:db8:1::/64 nexthop via 2001:db8:3::1
+	in_ns $ns ip route del 192.0.2.0/24 via 203.0.113.1
+
+	in_ns $ns ip address del 198.18.0.0/24 dev lo
+	in_ns $ns ip address del 2001:db8:18::/64 dev lo
+
+	in_ns $ns ip address del 2001:db8:3::2/64 dev $h3
+	in_ns $ns ip address del 203.0.113.2/24 dev $h3
+
+	in_ns $ns ip link set dev $h3 down
+	in_ns $ns ip link set dev $h3 netns 1
+	ns_destroy $ns
+}
+
+router1_create()
+{
+	local ns="ns-r1"
+
+	ns_create $ns
+	ip link set dev $rp1 netns $ns
+	ip link set dev $rp2 netns $ns
+	ip link set dev $rp3 netns $ns
+
+	in_ns $ns ip link set dev $rp1 up
+	in_ns $ns ip link set dev $rp2 up
+	in_ns $ns ip link set dev $rp3 up
+
+	in_ns $ns ip address add 192.0.2.1/24 dev $rp1
+	in_ns $ns ip address add 2001:db8:1::1/64 dev $rp1
+
+	in_ns $ns ip address add 198.51.100.1/24 dev $rp2
+	in_ns $ns ip address add 2001:db8:2::1/64 dev $rp2
+
+	in_ns $ns ip address add 203.0.113.1/24 dev $rp3
+	in_ns $ns ip address add 2001:db8:3::1/64 dev $rp3
+
+	in_ns $ns ip route add 198.18.0.0/24 \
+		nexthop via 198.51.100.2 \
+		nexthop via 203.0.113.2
+	in_ns $ns ip route add 2001:db8:18::/64 \
+		nexthop via 2001:db8:2::2 \
+		nexthop via 2001:db8:3::2
+}
+
+router1_destroy()
+{
+	local ns="ns-r1"
+
+	in_ns $ns ip route del 2001:db8:18::/64
+	in_ns $ns ip route del 198.18.0.0/24
+
+	in_ns $ns ip address del 2001:db8:3::1/64 dev $rp3
+	in_ns $ns ip address del 203.0.113.1/24 dev $rp3
+
+	in_ns $ns ip address del 2001:db8:2::1/64 dev $rp2
+	in_ns $ns ip address del 198.51.100.1/24 dev $rp2
+
+	in_ns $ns ip address del 2001:db8:1::1/64 dev $rp1
+	in_ns $ns ip address del 192.0.2.1/24 dev $rp1
+
+	in_ns $ns ip link set dev $rp3 down
+	in_ns $ns ip link set dev $rp2 down
+	in_ns $ns ip link set dev $rp1 down
+
+	in_ns $ns ip link set dev $rp3 netns 1
+	in_ns $ns ip link set dev $rp2 netns 1
+	in_ns $ns ip link set dev $rp1 netns 1
+	ns_destroy $ns
+}
+
+multipath4_test()
+{
+	local desc="$1"
+	local weight_rp2=$2
+	local weight_rp3=$3
+	local t0_rp2 t0_rp3 t1_rp2 t1_rp3
+	local packets_rp2 packets_rp3
+
+	# Transmit multiple flows from h1 to h2 and make sure they are
+	# distributed between both multipath links (rp2 and rp3)
+	# according to the configured weights.
+	in_ns ns-r1 sysctl_set net.ipv4.fib_multipath_hash_policy 1
+	in_ns ns-r1 ip route replace 198.18.0.0/24 \
+		nexthop via 198.51.100.2 weight $weight_rp2 \
+		nexthop via 203.0.113.2 weight $weight_rp3
+
+	t0_rp2=$(in_ns ns-r1 link_stats_tx_packets_get $rp2)
+	t0_rp3=$(in_ns ns-r1 link_stats_tx_packets_get $rp3)
+
+	in_ns ns-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.18.0.0 \
+		-d 1msec -t udp "sp=1024,dp=0-32768"
+
+	t1_rp2=$(in_ns ns-r1 link_stats_tx_packets_get $rp2)
+	t1_rp3=$(in_ns ns-r1 link_stats_tx_packets_get $rp3)
+
+	let "packets_rp2 = $t1_rp2 - $t0_rp2"
+	let "packets_rp3 = $t1_rp3 - $t0_rp3"
+	in_ns ns-r1 multipath_eval "$desc" $weight_rp2 $weight_rp3 $packets_rp2 $packets_rp3
+
+	in_ns ns-r1 ip route replace 198.18.0.0/24 \
+		nexthop via 198.51.100.2 \
+		nexthop via 203.0.113.2
+
+	in_ns ns-r1 sysctl_restore net.ipv4.fib_multipath_hash_policy
+}
+
+multipath6_l4_test()
+{
+	local desc="$1"
+	local weight_rp2=$2
+	local weight_rp3=$3
+	local t0_rp2 t0_rp3 t1_rp2 t1_rp3
+	local packets_rp2 packets_rp3
+
+	# Transmit multiple flows from h1 to h2 and make sure they are
+	# distributed between both multipath links (rp2 and rp3)
+	# according to the configured weights.
+	in_ns ns-r1 sysctl_set net.ipv6.fib_multipath_hash_policy 1
+	in_ns ns-r1 ip route replace 2001:db8:18::/64 \
+		nexthop via 2001:db8:2::2 weight $weight_rp2 \
+		nexthop via 2001:db8:3::2 weight $weight_rp3
+
+	t0_rp2=$(in_ns ns-r1 link_stats_tx_packets_get $rp2)
+	t0_rp3=$(in_ns ns-r1 link_stats_tx_packets_get $rp3)
+
+	in_ns ns-h1 $MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:18::0 \
+		-d 1msec -t udp "sp=1024,dp=0-32768"
+
+	t1_rp2=$(in_ns ns-r1 link_stats_tx_packets_get $rp2)
+	t1_rp3=$(in_ns ns-r1 link_stats_tx_packets_get $rp3)
+
+	let "packets_rp2 = $t1_rp2 - $t0_rp2"
+	let "packets_rp3 = $t1_rp3 - $t0_rp3"
+	in_ns ns-r1 multipath_eval "$desc" $weight_rp2 $weight_rp3 $packets_rp2 $packets_rp3
+
+	in_ns ns-r1 ip route replace 2001:db8:18::/64 \
+		nexthop via 2001:db8:2::2 \
+		nexthop via 2001:db8:3::2
+
+	in_ns ns-r1 sysctl_restore net.ipv6.fib_multipath_hash_policy
+}
+
+multipath_test()
+{
+	log_info "Running IPv4 multipath tests"
+	multipath4_test "ECMP" 1 1
+	multipath4_test "Weighted MP 2:1" 2 1
+	multipath4_test "Weighted MP 11:45" 11 45
+
+	log_info "Running IPv6 L4 hash multipath tests"
+	multipath6_l4_test "ECMP" 1 1
+	multipath6_l4_test "Weighted MP 2:1" 2 1
+	multipath6_l4_test "Weighted MP 11:45" 11 45
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	rp1=${NETIFS[p2]}
+
+	rp2=${NETIFS[p3]}
+	h2=${NETIFS[p4]}
+
+	rp3=${NETIFS[p5]}
+	h3=${NETIFS[p6]}
+
+	h1_create
+	h2_create
+	h3_create
+
+	router1_create
+
+	forwarding_enable
+}
+
+setup_wait()
+{
+	h1=${NETIFS[p1]}
+	rp1=${NETIFS[p2]}
+
+	rp2=${NETIFS[p3]}
+	h2=${NETIFS[p4]}
+
+	rp3=${NETIFS[p5]}
+	h3=${NETIFS[p6]}
+
+	in_ns ns-h1 setup_wait_dev $h1
+	in_ns ns-h2 setup_wait_dev $h2
+	in_ns ns-h3 setup_wait_dev $h3
+	in_ns ns-r1 setup_wait_dev $rp1
+	in_ns ns-r1 setup_wait_dev $rp2
+	in_ns ns-r1 setup_wait_dev $rp3
+
+	# Make sure links are ready.
+	sleep $WAIT_TIME
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	forwarding_restore
+
+	router1_destroy
+
+	h3_destroy
+	h2_destroy
+	h1_destroy
+}
+
+ping_test()
+{
+	RET=0
+
+	local ns=$1
+	local dip=$2
+	local args=$3
+
+	in_ns $ns $PING $args $dip -c $PING_COUNT -i 0.1 \
+		-w $PING_TIMEOUT &> /dev/null
+	check_err $?
+	log_test "ping$args"
+}
+
+ping6_test()
+{
+	RET=0
+
+	local ns=$1
+	local dip=$2
+	local args=$3
+
+	in_ns $ns $PING6 $args $dip -c $PING_COUNT -i 0.1 \
+		-w $PING_TIMEOUT &> /dev/null
+	check_err $?
+	log_test "ping6$args"
+}
+
+ping_ipv4()
+{
+	ping_test ns-h1 198.51.100.2
+	ping_test ns-h1 203.0.113.2
+}
+
+ping_ipv6()
+{
+	ping6_test ns-h1 2001:db8:2::2
+	ping6_test ns-h1 2001:db8:3::2
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


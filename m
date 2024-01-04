Return-Path: <linux-kselftest+bounces-2635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EB582435C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 15:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EC61C21201
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A4B224C0;
	Thu,  4 Jan 2024 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GIjkJh03"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE82232A;
	Thu,  4 Jan 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/ij+/CcWALEUoDQ2vIvMjprnK9VYAAV/187ptcbl6Ya0iSO83ME2c+nnRGtrJOASZ2sAcJ2rirPszyaahVGeBvUUfxVqGIbONLTjv0yU48sAoJBZksv2TnD9WiUCvCWBY9or0nx0CqXbqxJEuc31rxEm+fYE7qLjLZiKIuttKGPB7fCG8DJ7Y0RTbJFzJxfBbHOuziVeFbBifgkp1VKhUjk+2bH/aZ84Nk+uOIzSYDKXY8Vn+YttlCIFf3g8DbCoiooySBsaE63zer7lDFHeD2RDSEgqEF37lNYKn79cMfT91yrmxUxNCoEM9IhAjy80Y9GFw0sRY0x+lrYhPZzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/0gZYXKZeRlMiF3/ngynndfHX8DKTk8ge8fGB+p/Rg=;
 b=X/d3HcYNzq1M3ZfYZGCyh9jsOuvxDkPK0zTKg0jZLHH9n5wWsHybyckbG+l7kqWU02j59d9yM5SQHky487TUtZIItKbVstPTNrFAl7UiPgeBnTWTkvgR1ETvC8JwGVt2zIK+TywJAJeuDMhAi/xK3YFci7KyPfTXaDgdFyGNp4bUfztZqjKtzZClt+VAyh6VObO/LwX4FLU2enB8fyAXweNLwbshE1Iq5rNBjE4flQ4ui67PGsXLiRtPRSRqJKWcD6MJJ6MRc4uDJqdpVlg2fLfvInSia3pFTMFGklg46WMfFlslehSMvEaGvSSuEY4Q/syEbUJjLO7pKTbtE+Wvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/0gZYXKZeRlMiF3/ngynndfHX8DKTk8ge8fGB+p/Rg=;
 b=GIjkJh03CDk6T+V3aN36+7Ks4vhMVSqXap4oUDH8yOgqZZFxJjc3zfboZVvm0DmAt6qDpVsyaEFAsN+ABP6Tvsu0rL+D5wkunBTo6kkzoCZLzNxqbGd7g1RQRJYrHMR1JRDaZJGmoNSxaAawM0OrXhm+xW5K/4bNjRBPus+mBdymqHxFKyVIZrASSY2ObikL0+vQ9cToJSfmCq0Ya/YKsgiVat92E/l9g2hvSOUuO4SaRD9LtWTuf0+cQISM07tLCOy5HPJViPpkRIqHtKEC+9iHCJUBRwFW0UQ5gS07/4nDWKw+pnVYTELi6tL+ZGN2/9qGs9v/nhFAZJgEL7p3LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 14:11:57 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:11:57 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: forwarding: Avoid failures to source net/lib.sh
Date: Thu,  4 Jan 2024 09:11:09 -0500
Message-ID: <20240104141109.100672-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::24) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: e665e391-9849-4240-2ad6-08dc0d2f1c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sDrhuZB4GYiNycQsGqifwVdt9A7qLLES8c7Eq+dvnZiiPpJL0cQZ8zd9P/01r/OLlso5GRBAPppmhUMFngAmFB8heauf569hLdOFDW3tPk4bECV1ML21LKnyEsPm7sJ/jEwVifEysavseALjjKFTc/AORFM9F1AAD4p8E5ttDmIqgo+pbTXtdhPckL+R9kUS12ahdRg78Y0KonqvCssQiReJxm8xK2oRZlX0D89/TFfKyvovc8n/PA1lCHHuorE5ldboSwqo5fna+JVt5RRTyLz9i/WKFly9dAHXfuJr5bdz8SdEqfyQCkqBvAlM0sxFtGKeePgcnyPaXKym5yR9R9LaiK4NTjxkMavK7xsf7/ThRWjviaPJttkIyVUmuAZLl0Bmcvxtz6nBZiSspDoATJ6WbHw67ZgQBqmExIEsoUqNyUF5coANOdKd4XRg6rDHtgoM7a3u1FFy2woeNPeNCIurBROC06T3me+mclbP5WoGHD4gDC6AXRtuAHy9iZu1gVdiuOq0HvcaG7q8NIXrCvXdrCcz2s5H6SBFWup2NRUv6jsVMJ9wzazfrTsNTjjnC0dLufjWA46z1qsIpE/39nlOr2NTPzP9UWhPnkd0kQY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(6486002)(66556008)(2616005)(316002)(4326008)(8936002)(6916009)(54906003)(1076003)(26005)(8676002)(966005)(83380400001)(478600001)(6666004)(41300700001)(2906002)(5660300002)(7416002)(6512007)(36756003)(38100700002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0lHKsHaS07r5Mv9kaSaLJ5zCTMoivBPebiiRBd0D0qs1FNXKmGlZnTxo5yzH?=
 =?us-ascii?Q?AI2pHXME432kBzDcp3J4kPAVpXdXoq3u107ma7UDRcWDIL659e1h9NqY4cMl?=
 =?us-ascii?Q?v90rYAnNg9/TndKHXzfL1qCiGZ6hDEYK01+c7jhOmS78lv/K20isFHbak8f2?=
 =?us-ascii?Q?Y1n1ZY5U6rjl7pmVxvWXfrYwkYThc4OXSTFuWDkDlKHxqO/CrtiGk98ZjoFd?=
 =?us-ascii?Q?jK1lIIS7dKgQohU0b6X9pIfCvVpK3Va/oRYF/dtooKSMypwKdz/C3R7m/G3a?=
 =?us-ascii?Q?hkboCkLS/gUd4jFdOYvj5GlocN95vLo3nYj1CZgeT4HZ/gmDTG+LeKNWvFYC?=
 =?us-ascii?Q?j4Ass8Zd3/Z5JPtn/9LGJIGzYWRVStQQNozk7WtKBx3IyBqndswb6b5yCteI?=
 =?us-ascii?Q?2scKUusoXZP3zUJfOYBHVTWEUfWPZznTCKnZbQ1ts7IAOYTcEkYEDz8i5/Xl?=
 =?us-ascii?Q?FGVsLNAg8WfI0ao3/IYUMJL/24TZFFY2WQSNuFjSGzeCbW/C/Egjjm1afHvr?=
 =?us-ascii?Q?+j5aLpjA61VJZK4I5R8jE0QlwkEp7Y+NkW2zC38Bl3+HRnRUa+8Vm11h9fkV?=
 =?us-ascii?Q?wj+uW7J1NwmdNRxx/JRhD0OD44vFaQvENbNSZt5WpKu0Drw7eOvE4iapMXQG?=
 =?us-ascii?Q?KGoEvXVNJ0G4elAdBrq2MCpVo4PRFGNIlw1HI7AZgxVh0277ZjY2+M+NKl0/?=
 =?us-ascii?Q?rpRnlh3I6pqr3Ay49DtE3okBwl895QxfsHmnG6CxoJ5x13nNhKW16RikdZFE?=
 =?us-ascii?Q?KSosu0ZeozZOyjYMIycRwHMinHltrtxKF4U9wcAuVWyLHmS+C+uirN422cg3?=
 =?us-ascii?Q?SXwW7XXMMr4O18fmUkwtBWTpWeZxJ+2j7Pe+LBq4cOF71mjXNC2h298p57p1?=
 =?us-ascii?Q?nPJG0Kyy8cmLDXy19AhbM3TdhlfHISvryKo+poGh8/PxzsC1zTYt9mXQbA5w?=
 =?us-ascii?Q?TTBsOAoiTKM3r2iVtcRmS8uqMGrUUpvXSRsjzdufvZRmf82PPX6uEKjRYP44?=
 =?us-ascii?Q?BkG5J7uSu7eJE/oHg70ZURYLMzU1MxHV8wFytjmclgzkaYMJI2l/Hp9KO2T6?=
 =?us-ascii?Q?9i6YO+Voi506L7CXJ1/Ql2u0s9je+2352gX5ZAciSH3C3Yi6zEntljpkvSWZ?=
 =?us-ascii?Q?1/RkMe6qbXaZFiGbTE+3IIzimYPFwuuacmLcG/FXb+6HUxzvKyASZQAlERbb?=
 =?us-ascii?Q?EEmptb6Of8Dr3R72hw9QeeLzRR2Dseb8bCu9qUlLUszjjAXTPntjsaYToNt5?=
 =?us-ascii?Q?vpB3k4TlfcPrbIOyrov+9InF8ScvyOWd1hE7X8kTBVPhD6P3Kg7I9+YB+IQk?=
 =?us-ascii?Q?Bq+oIRRZzjyDcuuqILDPvihXSSUrTEF7/RQv8iuqSO7DxYOFVhWSEK+IN1Vn?=
 =?us-ascii?Q?oUahMZk8xde7ncyNYxEE3B1iPwEPxkOxEb0hlqYTDRqW6Ds5UySl9Qb6IoUU?=
 =?us-ascii?Q?M+K/VFrCEN+XlQMe5ycTs6OJer/ofQoqEj6VslY4PlcPNCmj6bzbYqEBKqY0?=
 =?us-ascii?Q?UhXVs2tzUGr6GXYiz/04n4G5cV8BwnT5erHsefcHr1QL3HoThIq0b3lj4+GE?=
 =?us-ascii?Q?llF0ihybeWWqAy2vLZ/GQVkhMGZtjIu580OLlJpp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e665e391-9849-4240-2ad6-08dc0d2f1c85
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:11:57.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2wMD062b5nneQ/QNJ+2TjeDLLd/fx4L+ZzJ6cywjfPqJAggpPFYJ2Oz6FlJSEl9cO0iZphEboXLil5wTXX2nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203

The expression "source ../lib.sh" added to net/forwarding/lib.sh in commit
25ae948b4478 ("selftests/net: add lib.sh") does not work for tests outside
net/forwarding which source net/forwarding/lib.sh (1). It also does not
work in some cases where only a subset of tests are exported (2).

Avoid the problems mentioned above by replacing the faulty expression with
a copy of the content from net/lib.sh which is used by files under
net/forwarding.

A more thorough solution which avoids duplicating content between
net/lib.sh and net/forwarding/lib.sh has been posted here:
https://lore.kernel.org/netdev/20231222135836.992841-1-bpoirier@nvidia.com/

The approach in the current patch is a stopgap solution to avoid submitting
large changes at the eleventh hour of this development cycle.

Example of problem 1)

tools/testing/selftests/drivers/net/bonding$ ./dev_addr_lists.sh
./net_forwarding_lib.sh: line 41: ../lib.sh: No such file or directory
TEST: bonding cleanup mode active-backup                            [ OK ]
TEST: bonding cleanup mode 802.3ad                                  [ OK ]
TEST: bonding LACPDU multicast address to slave (from bond down)    [ OK ]
TEST: bonding LACPDU multicast address to slave (from bond up)      [ OK ]

An error message is printed but since the test does not use functions from
net/lib.sh, the test results are not affected.

Example of problem 2)

tools/testing/selftests$ make install TARGETS="net/forwarding"
tools/testing/selftests$ cd kselftest_install/net/forwarding/
tools/testing/selftests/kselftest_install/net/forwarding$ ./pedit_ip.sh veth{0..3}
lib.sh: line 41: ../lib.sh: No such file or directory
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth1 ingress pedit ip src set 198.51.100.1               [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth2 egress pedit ip src set 198.51.100.1                [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth1 ingress pedit ip dst set 198.51.100.1               [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth2 egress pedit ip dst set 198.51.100.1                [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth1 ingress pedit ip6 src set 2001:db8:2::1             [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth2 egress pedit ip6 src set 2001:db8:2::1              [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth1 ingress pedit ip6 dst set 2001:db8:2::1             [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth2 egress pedit ip6 dst set 2001:db8:2::1              [FAIL]
        Expected to get 10 packets, but got .

In this case, the test results are affected.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Suggested-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 69ef2a40df21..8a61464ab6eb 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -38,7 +38,32 @@ if [[ -f $relative_path/forwarding.config ]]; then
 	source "$relative_path/forwarding.config"
 fi
 
-source ../lib.sh
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+busywait()
+{
+	local timeout=$1; shift
+
+	local start_time="$(date -u +%s%3N)"
+	while true
+	do
+		local out
+		out=$("$@")
+		local ret=$?
+		if ((!ret)); then
+			echo -n "$out"
+			return 0
+		fi
+
+		local current_time="$(date -u +%s%3N)"
+		if ((current_time - start_time > timeout)); then
+			echo -n "$out"
+			return 1
+		fi
+	done
+}
+
 ##############################################################################
 # Sanity checks
 
-- 
2.43.0



Return-Path: <linux-kselftest+bounces-3459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9068683AF0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403F22874C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 17:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4667E597;
	Wed, 24 Jan 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F1hg11Nm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09E7E76D;
	Wed, 24 Jan 2024 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115778; cv=fail; b=G+CdMxn6RxYKp5RScpBOmuctorTAWm+4PAImT53yR9SGs/yYzP4Td8fn3JrNL2nddvUhTMZ3iunJ537FDyEjrcM3dPThhsXqCzbUn8QPUK3QSFN55k4THiTs/DHrWQ5REqlkZ31UvakyF42uQsbSKP2r5gQNIUEvIa0MLXxvaAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115778; c=relaxed/simple;
	bh=OOnpurWc4QXknd7lAbnPIBAR9h4mxM/nUa+2/8mIbNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D11Hb9VIhVkfdmYBqYCCeXlWjagSuJuGgFGVsI0/8WuljRteFWTv5lUbsJXdqBWWIKQKhIvIaMEIh+GG80CEJA/kM1eYO+waQLI42B7r4qJGKZqZDznSfQQXd1qRttbEKvtZB6aFWBoJCThRwafdhV+Xg27TGWVN38xZE+S0HlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F1hg11Nm; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9rX+uDs7OhVMPXR9cMgoABS0Huv/i/JNzzO3GGvP2uRnSv3MMc2dBWO1BS2/RTHnCwyN6WPJ5tGiYCUe0XWOTJSWpZch1ksPSJswANZBKCxi1/UAkkj7pTq508wBjte7RSAjsgZPJuUcjK4DK2xENz/zYwAfQDAzN1CsWH3qrEGxISYwmPVUhcxrE6KJtI/0O0z3ZpAJYF1ORYpHq1HbwKfGHiMXdyCWQh/snvgY6qmw4tXRTTpaLFBDvBBsq43h2CmhYbHp2b6oRgIxLLw1NBOVnpWZSlhxjJvZV0ni+cWGB8Sm+REqpL2U2vtcEKF3yIX4hLXWVKHLqNgwLyFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo3c5SZ5FPDTHi+SjWCepqIVuNSWTrm4yypFFqsLFTY=;
 b=bm0Ys+0IAU/1bW+bJ7GzvN6+qucxtEAfEJAvOXDSb3XRH+bv1kcYxzcPriZcYNXWJpBVa+wv7m/2iZKx85lL0SrkijBtv5fUsWuoKVlhVT897CcHvXrPUzWi0RDHdQLYjtBq24h6MuZPUkDNNpcKG8QQIy34ow023Vil4nPzb3hnEaW39Fr6rAkS/y99lRUAu5iodU/yMI2z53xD/QofZPwiTpQZjCloJDIDgMgZcSU04q04IEfCryRynCWqpToU0FS9kiyAEJMQHuuS6ZjY09Q/4bgOUGV1axTNCDgcsHcThcoLFgvw0GYWdY+Dq4kW4Fd3SlsCVBPdNtIfPJoIXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo3c5SZ5FPDTHi+SjWCepqIVuNSWTrm4yypFFqsLFTY=;
 b=F1hg11NmGinLJR88KRX5x0ckC89RnSTPiu/7SSxY6ernWNcngi7vJus67uVZjSeX9mINWyRUf1S7fPp2vwm3BJysTZcBPYrr28TKF8Qm/QZNgOK6tAhBJDiduVVhOlIkQVTG997f1gKXB32nkUIlPccXqhN/lBRMHt70+bHG8HbO8rC0v7KEcLiwPUX07diXS3+CjcYHEZXR5u67zgFKA9EMYJdFdH3gIOQ84OI24OzS5wy0e4zgzNznNPYUVhJiqnM4QeLkyvsEJRNTomJ+TGOLwXkpSU7an6ZYsqXpy5h0AkIArQy7I9hewWxq2IG5HTDQo0oAUP0NFZBDWtoW3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 17:02:52 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 17:02:52 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Zahari Doychev <zdoychev@maxlinear.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next 6/6] selftests: forwarding: Remove duplicated lib.sh content
Date: Wed, 24 Jan 2024 12:02:22 -0500
Message-ID: <20240124170222.261664-7-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124170222.261664-1-bpoirier@nvidia.com>
References: <20240124170222.261664-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::38) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 393446f4-d624-4bd5-06b6-08dc1cfe4d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4s+lmfUK0jP6EjDdJSEQpyGdj12/kALjxu0TBj4TcpcDWxjK9o3Rbi5Y2wixBH7qRo/av+v307pGoQD6Dv/waDmqJ2r+ApNUDCsoXLDs0F/0ihOA41AcsCH3PlwiYXQ3Zfe3fDl0HrKpO9kUgcl8y2um7pU+CA+PFW6QJI6vllURMzTTn//VzXM+S/DLLjLm80Q2U4rARGOeWZMcEANFBTLG6VTCHsSdQ8JICAVV5BLqcsXfSaqtxbn4cy0VENAFru8A0ynmLs4wA8Ll3WI5TmvHYEAL0ziqBFzvCUHm41dwYm8FxoYiDLjZKUANgPAs1RIsvXZv5yA//gT7AKZEUV3pZBz3hFgUtXykdWj4Dq/0sOW6ShpeNTHKuCRWLban0fKAKiFWOKkbdGMKJskI1eTU3e6Q5FanVRw7ywJQKRs24hnWTtT225tBAaV7mMT6KqvwQhxncEH87e34E2f9ERBuX8cVF2/g8xGOGlIHvsOMfFrlPV0/4kWSIyiNafVO6t3LAejXXq5ayfYhaisDki5ac9Oi8ONA1ZnkYE0AA04RfLCOBvn+Vh/HrXWrVxHs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(1076003)(2616005)(2906002)(6512007)(26005)(38100700002)(4326008)(7416002)(8676002)(8936002)(5660300002)(478600001)(6506007)(54906003)(6486002)(6916009)(66476007)(6666004)(66946007)(66556008)(316002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AE9Xg8Yis4Y9mpyUOjnDkoF9Wb2qopENfhLb5CBGtEVbWp7pFPg04M26Hk+Z?=
 =?us-ascii?Q?XGIn1EqZGO7RAGOZqjup8PKUSE09RMpjqjwp0bXaJ1+eoRDgHxy/vw2F+CEH?=
 =?us-ascii?Q?957GB8AoIc3Q2Dim0iJWjp/DYmqThBcEx6WFiecDab+dwJoJUKReKKfvyFNa?=
 =?us-ascii?Q?SE2gIbUt+pz8e+6R3So6tyjOiDT0JFNZLpZTU6VAqViOKODhOx9G5Xj78HPw?=
 =?us-ascii?Q?E37GqGnW20cwzbM4eFru2NIvyjGZhGBOEyMf78OetrfRLOYK6X0FYBoUu14N?=
 =?us-ascii?Q?26Ly1a3HCvuVpUnCoBInqryXXMnWX0aaLad75Zg2eU02apJHXPoIZyK9ZrMH?=
 =?us-ascii?Q?PPF1ieXDMW/UUssPbnv1j8LR0hboeA6/WwXvQsvOgqCo0U3MpO8jMJMpSnql?=
 =?us-ascii?Q?Qt5WSoO08TXGzfoDrNutRuNbEtz7jJv7K6DdzRzM3bu8PFwrTcKtqOsbvN+b?=
 =?us-ascii?Q?IbcUeqv4lfjgJIZqSpYAuL6kGYfM0Dd+hPm+f+X6BQQ4r54tkps97OIGYzGk?=
 =?us-ascii?Q?TbhUYdhqtmW70CziLgWmNd6V4hTPeaozPafSiMfqhTJkItOjiB0k4E/d5HNm?=
 =?us-ascii?Q?yfPLAaCcGLQkzUxWTpkvpN/Xpr70BgVUncnnE+JF7Gs+/+RhMn3PPRt3rlTV?=
 =?us-ascii?Q?yzbSQDOJTXMJqJ5Ng0UmLf5WS2NW8Dryxf3IgoEkWzf14OcbH1VBkqtSCE5O?=
 =?us-ascii?Q?NeuiOy3dn0OCChHtPksbcSR89bSi+HSOGKJzOwrG4fwPPP3oTj8ZVDiXp0Gm?=
 =?us-ascii?Q?Jq57uAYUP243Ln0VpLDFEUANSSO7BKwij66VjtxhJEIVDdwCDXy5nNCU6Qs0?=
 =?us-ascii?Q?G8maroKc1CQB21Z2PS8BaEuh86LiHk9RzVeaoJdKz6xmb2R7OthO6SwrWj1f?=
 =?us-ascii?Q?5B9EtqXD7pWXuspg726w9PJe6/vWosZZRufdOgLT3BF9ERIJs7z2o5CpUmSI?=
 =?us-ascii?Q?7vblW/5u/OExuuZPfXUo9UlOTZcgB+Ziwr9iF9yCvK9+dBZ6WY5x3IqFcWVU?=
 =?us-ascii?Q?pE3f/2cwiLBHa868GWKiN/iDvrrCauEZcs1fGJ9/gDnOmQcdRGumQXtlyVBq?=
 =?us-ascii?Q?KOHzHbfS9gmu/Yxsym4/OVeJ+tvyTa6voqV/tiUPAmDCp8wzDeH8sgwzxfUi?=
 =?us-ascii?Q?gUvctgzjQprkGBOBRw7U9o+e5eSA6jSA0NzqxltX3IEZms1gulc1rxPwWNqK?=
 =?us-ascii?Q?G1AhnJlik7CxHX163feTlVlPFwKlfHVRTw3Xc85h19DlkAkM6ll70wljn47f?=
 =?us-ascii?Q?rqRKZ09Jhsrgqns5rRO7hKs30AldP+IRHG4BH6JH3cPOJcmLGt+8In5Pgg0E?=
 =?us-ascii?Q?on4PqbzyukAurNNoFevpauJL1s3k0V3f9azFL5oIGU/2XeiWd2PrPhvXadNh?=
 =?us-ascii?Q?M1gzpV4a5hT+YFF6N4mgxwrAbT53+5YSUolW9oLHL0WvEZhdlWm1vjsAAVXL?=
 =?us-ascii?Q?suS8go9MlnaGeLxEZUA3mhU6Yfm02PJcbfZghum/AYqWPARhapla9MtdYvhY?=
 =?us-ascii?Q?0ZQccJfnvRt3tz2NxajmYqoDib1Ghf5a2is9qUvQSlLDTt84rbNT7oMb3HMD?=
 =?us-ascii?Q?hhHzTQfnpMJHUXeXf4rM/azwXzWQwQyLInqTYMSe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393446f4-d624-4bd5-06b6-08dc1cfe4d7c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:02:52.8390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UH02L5oyy/6W8bChe/hygXTpY+NUAuV4WtwBVN0IPFefBDYyfogGhQTmwyb7frLosbQu5mlGrk6/kCxDdzzJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901

From: Petr Machata <petrm@nvidia.com>

commit 25ae948b4478 ("selftests/net: add lib.sh") added net/lib.sh to
contain code shared by tests under net/ and net/forwarding/. However, this
caused issues with selftests from directories other than net/forwarding/,
in particular those under drivers/net/. Those issues were avoided in a
simple way by duplicating some content in commit 2114e83381d3 ("selftests:
forwarding: Avoid failures to source net/lib.sh").

In order to remove the duplicated content, restore the inclusion of
net/lib.sh from net/forwarding/lib.sh but with the following changes:

* net/lib.sh is imported through the net_forwarding_dir path
The original expression "source ../lib.sh" would look for lib.sh in the
directory above the script file's one, which did not work for tests under
drivers/net/.

* net/lib.sh is added to TEST_INCLUDES
Since net/forwarding/lib.sh now sources net/lib.sh, both of those files
must be exported along with tests which source net/forwarding/lib.sh.

Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 .../selftests/drivers/net/bonding/Makefile    |  3 ++-
 .../selftests/drivers/net/dsa/Makefile        |  3 ++-
 .../selftests/drivers/net/team/Makefile       |  3 ++-
 .../testing/selftests/net/forwarding/Makefile |  3 +++
 tools/testing/selftests/net/forwarding/lib.sh | 26 +------------------
 5 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 1e10a1f06faf..03a089165d3f 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -18,6 +18,7 @@ TEST_FILES := \
 	bond_topo_3d1c.sh
 
 TEST_INCLUDES := \
-	../../../net/forwarding/lib.sh
+	../../../net/forwarding/lib.sh \
+	../../../net/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/dsa/Makefile b/tools/testing/selftests/drivers/net/dsa/Makefile
index 83da1d721017..cd6817fe5be6 100644
--- a/tools/testing/selftests/drivers/net/dsa/Makefile
+++ b/tools/testing/selftests/drivers/net/dsa/Makefile
@@ -26,6 +26,7 @@ TEST_INCLUDES := \
 	../../../net/forwarding/local_termination.sh \
 	../../../net/forwarding/no_forwarding.sh \
 	../../../net/forwarding/tc_actions.sh \
-	../../../net/forwarding/tc_common.sh
+	../../../net/forwarding/tc_common.sh \
+	../../../net/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 708bdfce37f5..2d5a76d99181 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -5,6 +5,7 @@ TEST_PROGS := dev_addr_lists.sh
 
 TEST_INCLUDES := \
 	../bonding/lag_lib.sh \
-	../../../net/forwarding/lib.sh
+	../../../net/forwarding/lib.sh \
+	../../../net/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 452693514be4..1fba2717738d 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -129,4 +129,7 @@ TEST_PROGS_EXTENDED := devlink_lib.sh \
 	sch_tbf_etsprio.sh \
 	tc_common.sh
 
+TEST_INCLUDES := \
+	../lib.sh
+
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index cf0ba4bfe50d..a7ecfc8cae98 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -35,31 +35,7 @@ if [[ -f $net_forwarding_dir/forwarding.config ]]; then
 	source "$net_forwarding_dir/forwarding.config"
 fi
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-busywait()
-{
-	local timeout=$1; shift
-
-	local start_time="$(date -u +%s%3N)"
-	while true
-	do
-		local out
-		out=$("$@")
-		local ret=$?
-		if ((!ret)); then
-			echo -n "$out"
-			return 0
-		fi
-
-		local current_time="$(date -u +%s%3N)"
-		if ((current_time - start_time > timeout)); then
-			echo -n "$out"
-			return 1
-		fi
-	done
-}
+source "$net_forwarding_dir/../lib.sh"
 
 ##############################################################################
 # Sanity checks
-- 
2.43.0



Return-Path: <linux-kselftest+bounces-3848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE81844177
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48160B2A63C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B7F80C17;
	Wed, 31 Jan 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S4y6ijIt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52398287F;
	Wed, 31 Jan 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710210; cv=fail; b=u0b3We7EEAzvZOxrAmX1DcugXdKPu09C9m75KdYvk+9PSSPMSeyZWny6X/5kmnCmcVLYpFTmUmN344rT1CIIjU3JwffGo6B/2/BvXEPHv0J2ZGCERmL/703VUA5afovs9+f5V7jNnI7bgfEdvsPMk6FMEbYtcVN+gjr6C7WfRg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710210; c=relaxed/simple;
	bh=yjJQdUlojn+nPEHnTQlkyevXaLoA1xtRZxZu0rSRCnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TF/Sgwl/P9sk1UG07Vg3Z2vXh2lQTF9c5tqgwNnmKu91ER+vuozc6AyUJPhrrzIf25xOuQJLVWJ0DKSeG9NyU70uTY5N6542oYTelgYgpDH1WhZCb8Ip08N735NbktvS0aCx+gd3/RFqs1zlRoqnA9bxzFxHRWPFqUBufCoSrNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S4y6ijIt; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eh2rrEz4eJnUUJERLv2LHZcJbH9FbMOK2LZlW9Us5gS1jD6758EoOA9GFvTqtENAwy2X/Bc83gLR0x6UMFeTUaBHOuNgiBRkujD7vo9qVa8ExhniEmmvtRS3wDxbAosKMKdORK5sk6hqsuBzGmpf1LAUM6mHP5+BlS8yahRiqJwRoi2a6qbRtpkjsqQp9xRNJ8RVK2PNi8BpqVgFkClHt+1i03L6qj7JEir2xYQxxhQfzSB6j9EHfcjJsuQFE0B1MXLzGrxRfJD5HQg30TI4Gr9DlGBci/WOffrWEwE45wvGTRdYxtQXb5WIuvvFOKUiA0XgbEneClpT7snNcHt6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uQVzFIlpi/XHeG7ZcEFM6zJnWow89qkExnfCADWNyc=;
 b=eXTzVLydBCHWheZUU1OgHcDGRERq/JZKmeFe30LmeojBpaF+osdHtYnNUw4oiKyzeDn5wmJ29TmsILHHcJ+I5WGzE2YjY1bxiXjM7h4G5wDjwmapZB5GawvFeuy5XFh4nWVZPBDKNiUrYvh6sGERoi5zd3MVZx7TSSyNPghGH7+1A4d64jLCv1ZHL0pD4/1DnoJC65y1n33YyDWUbLuVUQPqyMo0V26SJh5iG8sjKqIkoWnVLWhVap6kl62OzOkZXPKFLyVMlErSv8oW0Ygn7zlhJTNSPmcjwOPQt5UilPdG0MTx7b61DA8dTzSHLHksbrPQNiIIAOuMRU1J6mUyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uQVzFIlpi/XHeG7ZcEFM6zJnWow89qkExnfCADWNyc=;
 b=S4y6ijIt/jcqLqSddYwzDQmjzEymzVXNDh53vx4PZxMgKEFX9LsTd/K+EOAz5XtlfpMOElbUbOajiZjgylNQN9ag/l8G5Caykq8dReeu9l637Iv73O0eDwLctytEr42tyTWCQYB/4bM4wKTxZyhfOH4LdipZIsSoJVty/GQNVOcy21Zcl8s2op5B6Nop6TquqlY652Sv5ebD60ivH6UgU1KWoIv759+O1fjUDphYH6Bf/WAoEY1G3oIvn09bIc9PCyG6CSZ4Kwo0AXxPaucr/PZSHPiu7H9KSy4gpMNgK/zVBnz545eXDGeFjgZMyh79t/rA9GdSZ8a9qI3J9uipcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Wed, 31 Jan
 2024 14:09:59 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::8a95:4c4b:5bd1:3a2c]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::8a95:4c4b:5bd1:3a2c%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 14:09:58 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Coco Li <lixiaoyan@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 2/5] selftests: bonding: Check initial state
Date: Wed, 31 Jan 2024 09:08:45 -0500
Message-ID: <20240131140848.360618-3-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131140848.360618-1-bpoirier@nvidia.com>
References: <20240131140848.360618-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::16) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c04cfb-e6ed-4966-91af-08dc22664ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y++f348URloxSjypJ4Ckcg+uC67CL32leCsYJph1OeBDLCJO1y08MU+ndz2BeYmUSKwIbC48rZL8WShJ4+bzK1ucpa5hIG9Xi6HJyGpDSbVMUdKok00LwpzPf/pNP1QuDlWWEzHVUnCKGmIreBuhj0WGCtWzqls1RfN+YjZeCE+qLjZ7WhMh8WhxTvn0JBk9ShPt1alWdt7Yu1SUn6nsyQnZEcwLjiClTzL4UM0dZKcA8TXmzyViVZTV/7O14LyU9SDKSdI0ZBOiXWB7iF7H+OCz2K1M5SBPVlhuRjOVUFDjjoUIWp0kcVraoX/gUfCvxbweOTUYYbtX6IPCcyWNTJC5JgG5a9+ejYHVkfvDojDECYzXO1OS3I8HZRZOK7GwBUug/UOdaWsHxsdi7Nw1h/krySf7MGw6vDj5ZGHG374+g1Dfq/gROXau2Fmxuvv3iE24vQWzYPaUAretptEsPRHEB6hJDqdFfiaVJNudldmmphKzSi2U83xb0DtOciHWUB1bfMvnY5E85o6YCmR1Gd+GDSsp50QWcDH4boz9IaO1nvk3BbA1nKT5YIIx5PpN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66556008)(66476007)(2906002)(7416002)(5660300002)(316002)(8936002)(66946007)(6916009)(54906003)(8676002)(4326008)(36756003)(478600001)(38100700002)(86362001)(6486002)(26005)(6512007)(6666004)(41300700001)(2616005)(1076003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fddUmj7TZ/m3B8HZLjhLRoX3eaNOwwZaS8JW77z1UkUOVmVkCZpZH2nmHS2m?=
 =?us-ascii?Q?3oOTXabNo/niQBwod8hmZNe5hblw3Wdq2iVUAVZUAAcaj31mKnlQwvnBE1Ks?=
 =?us-ascii?Q?lmeeNt/TjR6bRE/Cg47U3pEpmko+ggBVcVJxtmOHQVdWRReKBc9VVVcNiRh3?=
 =?us-ascii?Q?+0+0xBnhjbbvpQi7Bb5I+AHc627zGX+XOYv9nHpiGc2oSdtfl3v1WNiRF8gs?=
 =?us-ascii?Q?CRYOqNZf9VjciH/NVDOHpMSEMoF/eZHUhoOBkkVO1FVHzzhkKFxN9SqIE+xI?=
 =?us-ascii?Q?buiB5aUuydp2G8XA+CnJc/GMhxQjchLsTEbo89rx2bogo6f1RW6FbNlavCsp?=
 =?us-ascii?Q?9XcDT06LKWFbnUum7S0kPfVigTCH/KkIETVg9zcOfRLMv/f94EZa/Y8752pk?=
 =?us-ascii?Q?lwc4rsjX2f0LU20NlvYUlTNN4gjQRBxQNlVK0Pe/iyFlzSNSDJzAvYQK5ZCc?=
 =?us-ascii?Q?g6jpZ96HrRTqLNZv23xeCwIBW+ckOPbed6MBUVaofJC9bLdN9uWsmaHMs2xS?=
 =?us-ascii?Q?B+w/gFQaS8Bxmp1fFsOtc/VfiEClPcLnJFiAm8kTpX6vD2QkfT8ux7oPMhGz?=
 =?us-ascii?Q?A3dh6QRiD37aR/b00auTBx2FqdxDHodog0tS0yGFTPCSdgkOQqe3+gLqV2IR?=
 =?us-ascii?Q?5Be/unT5GnUI8CYoqDzEYkL5OSZUZ59eJWrDciDWHfIfoDeveNGoCZBmRxG3?=
 =?us-ascii?Q?63yoLnCNrySw7tEkpJwo1NJRSga24xXzKEXKq0wUhdVDx7D1uto6npXXxTK2?=
 =?us-ascii?Q?7nCoed0pCcWUxCQsAXmQaD4VB2pEim5KChzMleNf75rXqk3rrAM0EAbaF9d8?=
 =?us-ascii?Q?sWT31tR5deZ7AsjCTr8woGCmTpOW+BB7h3xrlMdKFwMKb92ah4+WKcJrMoMf?=
 =?us-ascii?Q?PhcYJGoB6I/zHFQrxJYMysfZNDp6PzFHBXvktgWfTrJVJelJcy5NsAMed5K9?=
 =?us-ascii?Q?aBOHjUoN1rZO4pYYqbdlyxMrF9fpKgh9Zy14OBQI3suRYHExtYOpbSzvAviX?=
 =?us-ascii?Q?53hvO1IdaGhokt9u9JloWxPTywlOG4kQk/xtGxWb44hVuGSYAWLqdBZzdxv2?=
 =?us-ascii?Q?jvuc2FSP+bId1jZptNzNnlhLtAIjWXOsQFfA842S1kRACXoT2d4xXOGtB28p?=
 =?us-ascii?Q?rH3Lh2vCRfscbYDBAPncFJRn/ihUVj2Kn6NDCXx4J8EuK8KaZOie0H5H2msp?=
 =?us-ascii?Q?/gBzEPrvIJPD86uPet3MkhhjWD5v6UB4+P1xER06+5I8EbaaxuQHuiPtVqvp?=
 =?us-ascii?Q?8cbPWtkry6sGoeB9AOqYfSy4pcRHSTD68PIJjPWexrFtllo7pqYUpaj9/y1M?=
 =?us-ascii?Q?X5usiS1oTz+xSLrK5pRS+yV2Cn3O7sYccL5zNtf7Ej5cj7XKSq6cHC4Pk4nl?=
 =?us-ascii?Q?TMHEte+KDs0xCfAaI3qPWHOCypT/+rcXLvdRQKNlUzo7F1G2TraB7AXtrnOr?=
 =?us-ascii?Q?f5lNnTBpGoMMRLIH3fG+HVP43YT9wUIrRYnaxU+fuP5SwG162j4CPC3vuHwZ?=
 =?us-ascii?Q?HvMr657s247Ox205cTuAkBTlIqOB4cGz3R3zwScvOK+rHWcrdPXpPda+L3Gd?=
 =?us-ascii?Q?QNZzcygHGoMcwarWjckHyF1umod4eGAEx2WQGvII?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c04cfb-e6ed-4966-91af-08dc22664ee9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:09:58.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWyxLqbd1nfIU3zkGCWgEIiNPg2avDZAmJc50V6OcD7ExrskAdbA22KU0+24/6LQKAyqxy9WNLyXqKQExzTw0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

The purpose of the test_LAG_cleanup() function is to check that some
hardware addresses are removed from underlying devices after they have been
unenslaved. The test function simply checks that those addresses are not
present at the end. However, if the addresses were never added to begin
with due to some error in device setup, the test function currently passes.
This is a false positive since in that situation the test did not actually
exercise the intended functionality.

Add a check that the expected addresses are indeed present after device
setup. This makes the test function more robust.

I noticed this problem when running the team/dev_addr_lists.sh test on a
system without support for dummy and ipv6:

tools/testing/selftests/drivers/net/team# ./dev_addr_lists.sh
Error: Unknown device type.
Error: Unknown device type.
This program is not intended to be run as root.
RTNETLINK answers: Operation not supported
TEST: team cleanup mode lacp                                        [ OK ]

Fixes: bbb774d921e2 ("net: Add tests for bonding and team address list management")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 .../testing/selftests/drivers/net/bonding/lag_lib.sh  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
index 2a268b17b61f..dbdd736a41d3 100644
--- a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
+++ b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
@@ -48,6 +48,17 @@ test_LAG_cleanup()
 	ip link add mv0 link "$name" up address "$ucaddr" type macvlan
 	# Used to test dev->mc handling
 	ip address add "$addr6" dev "$name"
+
+	# Check that addresses were added as expected
+	(grep_bridge_fdb "$ucaddr" bridge fdb show dev dummy1 ||
+		grep_bridge_fdb "$ucaddr" bridge fdb show dev dummy2) >/dev/null
+	check_err $? "macvlan unicast address not found on a slave"
+
+	# mcaddr is added asynchronously by addrconf_dad_work(), use busywait
+	(busywait 10000 grep_bridge_fdb "$mcaddr" bridge fdb show dev dummy1 ||
+		grep_bridge_fdb "$mcaddr" bridge fdb show dev dummy2) >/dev/null
+	check_err $? "IPv6 solicited-node multicast mac address not found on a slave"
+
 	ip link set dev "$name" down
 	ip link del "$name"
 
-- 
2.43.0



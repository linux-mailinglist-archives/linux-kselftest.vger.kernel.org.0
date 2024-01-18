Return-Path: <linux-kselftest+bounces-3176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12BD831062
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 01:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E631F2259F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 00:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F39199;
	Thu, 18 Jan 2024 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NqyFVm0/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9019C1844;
	Thu, 18 Jan 2024 00:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536783; cv=fail; b=qfouMiZoDb2CEd6eOgQyLJYSX8tTB4Qbml2h3ouoSJ2RUG0JijbUPEOxc+vNhFFbceFKOpPjQsoUGgsPF1HMnusuWFX87YU4UJoOiWSuGc4Eetnbr1xQmRVNPrdCXH6OpqpRsoDLADab/vr5HOsQdtZfqFZamBCTe2kwPXJhZGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536783; c=relaxed/simple;
	bh=qFhxHom6xPSXEjiJit0nniXB+nsst2YrzWSQRitp/VY=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=JQEd5Q7q8o7tIgwpuTG3e7QiMQznsI3bp6eiQ1WhhpCODfBJEPzBCYQyGgPiZNaSSNC14IhiakslCveNCjiXsaMnbOzNQJS2gyrrcXJGIp5AZc+pJ2Yzp4CRrN13TL4hfLrdgcBaj1D7Zc7AcnSRnbDgsQG8w14nACqoVP0DNu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NqyFVm0/; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmVA1kPaJKOCempvP9kqNTogtue8AhMcJvT0RjwVK00Nqyuy6hfxic3A9kiSm1M2PTmOO2qEaz2PCgba3OCOKFApCXw7Ji32HiRBzJEcf6pmLc/4XfKPnIDyPUDSHJ0MUrBDK67N+/fZsoYurDCwsai9uLDIUB3dT0gsDOTLUkKvz19Ro3by0ijJqOEkNlRH8oFNlLiMRvifL5cJRXAzSVQ5qq1HZXEQBSg7Q2RUkBjPkJDcuuMiVe/tu9PcYV+cTk23DYADi6D4N86sEdecTGKJtT/lnK8J96PT/EZ4SjJmWu+ULMlNDIhc/KR4/aQyw0ZdVvHAe3QCy1qOx+lGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGMDKXIRITBV/ai73VtEnswFYJG/xVXK8zxLd3qASsM=;
 b=EagpIyrgTUW9bTAh/3eZDqxzYXKOhB8MFQxRkAa5GasrGCFUeobx+fRkRsjGROEuVYqq0SmxPES8us1rOfWk3ZPODCiwLJVrTOsxOgQ0J/bjRnMXBFhpFlb2UMyZHxFVoGPuaIPPzLC5SjNMJzl57UdN5GhoJ7q64yB0ZJhgjn20dsPxKxTdQSKOZAH0F5NLiVxs+X3SjPEBi2d8Im6gIrQyq7hz0dWNb+TWy2BNTZ/cZS27IPJvctutO046yePLPcVdvlLE70MczeAh544FznBseUcCn9iBSbaLPtBi0PutbLjU+HXySoGtb+m4cCIztgptS8TV4wixvTfo7gcZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGMDKXIRITBV/ai73VtEnswFYJG/xVXK8zxLd3qASsM=;
 b=NqyFVm0/U+PFrwkVXixIvWM3lh5VfYGGEKllntCBW4BuKLmXPuBbSDrpwlHRiKX//9WKiqeUzeyzXbfJeMVjKWO4jUtcGcEoboW4Te3WZ2iZ7rGIsGNRJqmlI2Ym/zFI5MQ+QzkAJJUjAf7W5MCOpovHP9Ok3n/3DNz5/5DvrJnR5kRqD41aij6g3eGFC3RKD7Z5Uqx3uqjhcezDKGqlfmN4G6y7uUon9gRiurleUHco4heurJ7cF7GTEO6vJ6TQjW+72MEM8g4uJIAJOTE5+dwM9zxdFETLFmDCS/qA7Rd69DKDTw+l7FFTxkomcfbTXA4l1gQySu0WF+sJxqxjTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Thu, 18 Jan
 2024 00:12:58 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 00:12:58 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Shuah Khan <shuah@kernel.org>,
	Liang Li <liali@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: bonding: Increase timeout to 1200s
Date: Wed, 17 Jan 2024 19:12:32 -0500
Message-ID: <20240118001233.304759-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::24) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b31f9df-3f2a-4794-bdbb-08dc17ba39bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lo76EipKiJiIYN9RVwyn2LmyKLLO26UODvWweiOprwMeaC92GvvxuOAm/G87sI6jdQ0YSr1fScfx3x5L0rZ5L3Rj7xU0xIdmZ4yysT9YswZL9sx1+DjJt0bcFzhHgL7REKdw17DoDbNYMh5KJKYAb/KxUZlJpJ68c0CTX5i5JK6YX5s/EhtRA3zASJMkKXW3gm5GIVCIS5Wb/YEw6awQmpQ3AzAEhCxpKzr3xIWNbTc2haJkzZUDLMOBX3UJArA9UTg6Kics1Bu+JH9cVSNuZlf8FMPwonSiYZ2eU6+6I5DYWMdHNnNxuerkp4p1y86twrnTN4q9CJw+hInk5jCh7gSeaofq1WxoKz6yrFBAxtSN9yP1ibWVjv6aoQ+FN2bOFqJ8TiiFwA6Y+Pv0QToeS9668w/XhXUITTvIYpRSWKXwlfXb+EtrpJr1fZ5llF3g2D82Rvv4m2RBFqgyiZ/OdlB/JpPGAxbM5hEGdz0GftX2ZXNhqU5PdTHr4bufvn/wmemJ7SgHNJ79Ds2Q2BKYXbdwg735z5w19or6zuhHt4mLvgVJW2wlb/4VdGKuF9gBNuC2veEGhpHOQvuKN1K6IYHaonmt6OKEb//UeT/GCjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(966005)(478600001)(6486002)(6666004)(6506007)(2616005)(4326008)(6916009)(86362001)(54906003)(316002)(66476007)(66556008)(66946007)(8676002)(8936002)(36756003)(41300700001)(38100700002)(6512007)(1076003)(26005)(2906002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8x8cvgto0dcCX5vcLQRWADB1CVaNxzjNcu5nZbrz6SBMlZ09nFU6cU1scicJ?=
 =?us-ascii?Q?amnlQl0+iFWF05jB+VBnBxNcKiH7O/0iuwgESBNBvAdHJmj3qMC55WVdWH4F?=
 =?us-ascii?Q?7Wj38L2O9iBPTY54BD5OeINKwMERgb6G00BxGb+ik7huN42Lb2/a/GHURMBl?=
 =?us-ascii?Q?PbEUAIhJ6Chsq7S+eatZwrWzlT7OFQj95raJpVR8GLUBQjOAijRC/oEGT7Yg?=
 =?us-ascii?Q?zVFIetK6P9hI9iT5WThVnD33C3arlYJlLMJjmm9zF1Yat5G46ORwgWsRWwTo?=
 =?us-ascii?Q?Qx8FAJH3sMeNDetca4ckzxz+ZZR8KEJUk4K9iCchS42oZ9XXesKeSax9/qui?=
 =?us-ascii?Q?fZxCatckMucXTANqVcx2bSeG2Cy5teTfrTl7n0+DaC5wWgSrawlwlQ3U57N/?=
 =?us-ascii?Q?qxdoAgJCrLNIeMvkOw/vvohpYLmfvQe/A8n8lsfVJRgMcQ1qLrnPrkGzznrh?=
 =?us-ascii?Q?di4+sdV+ke6jxDx3sjX8+FRHoRvgG8fPzg1zwdao0Nnm3PWK53Z5hMs4gkRF?=
 =?us-ascii?Q?MpmVQkoO3RppYls3i7uhOO0cdgDZ/lHolF1zaL7HH0immkBvSeQJrbD+ca6T?=
 =?us-ascii?Q?RUXeLQKP0WrIc9VuQaHvBrMlrLtWFMX/ky9a/p1HGokR2AEeLCOqK/P9fd5H?=
 =?us-ascii?Q?xLw6nI4n5IuI3ACGAup+UvhJp4lQ4kLhHWWxMCMfQkP70x2aJmsA8Dfqsz9u?=
 =?us-ascii?Q?7cumXeCDkNlvZjATvfIDXdFTYSXZSxTJ7QS1Ft9FscO5rtkncOZpmne08C1c?=
 =?us-ascii?Q?08OjXJpsBfS92Ue2OS6yWAqeACD+PxBM0XP+qdThKdMQqYllJttHTlFoS+2I?=
 =?us-ascii?Q?7oll1YcWNxH4ypyINqGtA1D7yKQPQj9cacMd2PogOujX4laGufXCPRpeWujt?=
 =?us-ascii?Q?+Mkq3MAN3HWIE6WNsI9luMcqz+qybiqWuOzSlSOifXRGLCkKsPqBzQyAoKHC?=
 =?us-ascii?Q?H/CQIhjKUCHnc09pVaVcFLq1rMk6gCUFrzwMeBg2HrRQgt0D9S+Ww7IGyc/g?=
 =?us-ascii?Q?VTJr53FrWZKuYB4uQJBEUBnGgILmnJfKOrl9gsoscZF0rEe+p9dKQMppo4An?=
 =?us-ascii?Q?1QOVyqS3Foyb6EfrTMNLx2vuOD11/ZhRb9AX9NxcbCb2ivTCSFKc/pNnCRsj?=
 =?us-ascii?Q?nm16U1ys0Amkw0sWmVtESKCz0q17rl5QYYMsYsJG68i+u29wsuHE7lU16lO1?=
 =?us-ascii?Q?jJ4WFdYvNpK6H8YPh3Pe2tLzt5OPxRvMhbmERF4zr5ngwBwPHPXALyHZHQOw?=
 =?us-ascii?Q?CwoYKwRARZaECzoKoFiKRDUMQRFtg3e7CdEjCrlILlVpK7+zxQOe5lrgx+vq?=
 =?us-ascii?Q?xrt5ipFCf4vpKTqZ70O5YednObElRKwt+k8tfKlExEv94EXoBjfUED7IBWPt?=
 =?us-ascii?Q?NgVfsP0mhHiJeCvuPebYI/UdKKRKly/ABpRawTk1JrR4qfQgPqJsxri5Dx3O?=
 =?us-ascii?Q?byqMcOHOqF0XlyZnTTWtG8qHRf4p5Zp3sZGzWwCOcDIyQuv1ylZgqEUTShF2?=
 =?us-ascii?Q?8hCIUvDpRuQ2WzzcRvSnWp+L5VVAiihqSqNXRzxlPPuFTAVn+DqqFw0c+Crp?=
 =?us-ascii?Q?4UWSWLUufFgw0V8nmLdI4UGiURimIOhyuGsfH1d1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b31f9df-3f2a-4794-bdbb-08dc17ba39bd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 00:12:58.1740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+t1uvKDqplOh1UozbUHBVUgBNpsrc8LSk5JISF8zmlSFaDJbNCvXWFx5Y+nDpjPK4Bp3zFgM6fqqnizAV2xqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216

When tests are run by runner.sh, bond_options.sh gets killed before
it can complete:

make -C tools/testing/selftests run_tests TARGETS="drivers/net/bonding"
	[...]
	# timeout set to 120
	# selftests: drivers/net/bonding: bond_options.sh
	# TEST: prio (active-backup miimon primary_reselect 0)                [ OK ]
	# TEST: prio (active-backup miimon primary_reselect 1)                [ OK ]
	# TEST: prio (active-backup miimon primary_reselect 2)                [ OK ]
	# TEST: prio (active-backup arp_ip_target primary_reselect 0)         [ OK ]
	# TEST: prio (active-backup arp_ip_target primary_reselect 1)         [ OK ]
	# TEST: prio (active-backup arp_ip_target primary_reselect 2)         [ OK ]
	#
	not ok 7 selftests: drivers/net/bonding: bond_options.sh # TIMEOUT 120 seconds

This test includes many sleep statements, at least some of which are
related to timers in the operation of the bonding driver itself. Increase
the test timeout to allow the test to complete.

I ran the test in slightly different VMs (including one without HW
virtualization support) and got runtimes of 13m39.760s, 13m31.238s, and
13m2.956s. Use a ~1.5x "safety factor" and set the timeout to 1200s.

Fixes: 42a8d4aaea84 ("selftests: bonding: add bonding prio option test")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20240116104402.1203850a@kernel.org/#t
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/drivers/net/bonding/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/settings b/tools/testing/selftests/drivers/net/bonding/settings
index 6091b45d226b..79b65bdf05db 100644
--- a/tools/testing/selftests/drivers/net/bonding/settings
+++ b/tools/testing/selftests/drivers/net/bonding/settings
@@ -1 +1 @@
-timeout=120
+timeout=1200
-- 
2.43.0



Return-Path: <linux-kselftest+bounces-35038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4E2ADA74F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 07:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBECD7A64AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 05:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CE31CEADB;
	Mon, 16 Jun 2025 05:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZSmtww8V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198EE1CF5C6;
	Mon, 16 Jun 2025 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050167; cv=fail; b=pImULTUwCxn7LaJp5mTQbsZcj1WqhcDKnYr+Il1WKPXNf7CuBaVgGKToXRMJ6wWn1xejqBWe9KyEDicXUfvqeH5eFGMupFfgmeR6IFLIrjIGrJGfkGGoT32PQcRe0jbbmjCzO2gLgLEbqECJlf4kvx+bQeuyFm7YGuEob1W8zU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050167; c=relaxed/simple;
	bh=0huhedTTPwZYoyY+3f6UOfa7QeCghUHtoHyVJrvfbHM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bLLl8DXajst5ZmQfvvbRp+8Db5fnbo8877gYNlUOZmANyFmfDCVA0+xXAaG+IMuLYhIjOS9i20YwmwH5JxcNOdM4XrgR8edN7HeggX94MVSdpn5lJ9SUkRVrFdqe9syeUY9JBjMH+8FcJKusx711DmJ7EkGc+zRmZgMVaPSevPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZSmtww8V; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7MY4nJsZIQxNs6laYeNbT3uAHlYPSNdMYHhqUAB3kRYJC9nI9HA0jIMQvDdxd69itmgW1OgE7TZpyel4JBvm/7m6BW65QNojtSZ/WJtAlXDOSFyRQJTYMDX08RXwkPqzsbmzGGXDIOT04WcWf1Rv+lUF74MwLsZzgLLG+GQOUaDCP7NI9tGlYhoGxrxJiKwsPKaK/jvLZz9+5gBDuDTYmy689X3UHp1ay3qBm5gs0rRsfiSQdRUsOn/v8GJIi9atcwPpL3ug4BIMpOa4zz/n1rV8Z7nYEhNWO90gPMrQydGuEr/oXaAp7cnB+sZLUZFWSHp6ZZCAU197P+OCkL6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZ9wwYTXNj46Xp3OrZXF8EApMuRcGIpomAmFrcws/UU=;
 b=VJAYJ6YmBBgIUSnb313dsTDCB/xdbw6TAL72s23qN7vEHJ94J5rr5Ngi5pfLmfQ0/EOiMEokxURFkGknDOFSIsFkKgzwxm3ELxQIkCR7ILklTgZ3U7yNHzbuMCDBQ7io6ZULEHxg7xTxQd1PYLFG5C7SydORm8zMF9CWXS2CrMMWIKqxJjlpr9mVWRxdlyHlUij9gMf8ug5tvEjg6MqJgTh1c6apxNETohy0QlJ+bE+BFnYulcCXENaY5d7sAwFwNR+ZSVx6ZCsVafoVVkWXYukbnMLFFrMrK3Wk+OJiiFqJSDnnfLMK0dM0WhYkQeVjunVUw0ethdDXnCBa0AD/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ9wwYTXNj46Xp3OrZXF8EApMuRcGIpomAmFrcws/UU=;
 b=ZSmtww8VDjsRE9WViZSiARElE+wOl3iUyJMvyH+NLIv2nfYqz51+tnMHlYeFAcDH1nr0wcfQ4HYeMZXaGWim35xKRsHOePGjqgsqBcNGKpHz57eUsWQ+D28RP0H6zCaeFP4pzW5c8C4EJZOBcIePGg7EZ1btmYo3fZws5gNJyf5kVdp4pKSW8PhWJU5Jt2BRo1HnVoaSsC9afhxyi4F0tJsd9VTg7hhx8IifxP9FC2PVsSZml9RHThcaQivK+URfYXMZV9run4vT/zvFYuZobudGDk/ZDGDlXiq7oc4sz+GS2kjckDsUaINkCQX4WWibNh7v84P7nxqkM3n2ZrpvnA==
Received: from YQZPR01CA0101.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:83::20)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 05:02:41 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:c01:83:cafe::4c) by YQZPR01CA0101.outlook.office365.com
 (2603:10b6:c01:83::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 05:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 05:02:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Jun
 2025 22:02:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 15 Jun 2025 22:02:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 15 Jun 2025 22:02:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: [PATCH rc 0/4] Fix iommufd selftest FAIL and warnings with v6.16
Date: Sun, 15 Jun 2025 22:02:02 -0700
Message-ID: <cover.1750049883.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f287a9-84f0-401d-7927-08ddac93054a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlRmdU85bkxMVlFMazlLVW9DYzFoU0padE1mcWk1ZytSS0o5SHI5K1cvS21U?=
 =?utf-8?B?WmwwTm5mQTVHdnNqbzlvL3ZqRHpSanBNaHB1b0YySXdOWTZta1Q3Y1NKL1Bi?=
 =?utf-8?B?MTBDenFKN2RoV0ptMGRhanNseDQzRlA0bU1raUJRa0t4YStrTENNMXRXUHhT?=
 =?utf-8?B?RElTWTRxSktSeDlleTVIZkY4TC9ZWGhjZlVHS09EazVaRlQ3UlpvNFlHU2NX?=
 =?utf-8?B?Snh4WWxKWGY2Sm9kMEcxbWZ3M3RnTVRBNXMyNVZrQzVHYXN0bW5GQkllRDdO?=
 =?utf-8?B?NEt4Rit1dU91ZzJVUWZ4eU1QNitMU1o5M1B6UUQvcVFtNkhzd3VEaldGeE83?=
 =?utf-8?B?WE9qVkJpYkR6SmdMQkd1eXlvUWtIdlRka2pIRGFzd2lreXhuVnE1L0VtZ0l3?=
 =?utf-8?B?bFpSS3F6RkF5SStHSndRL2l3WmlMeEkrdzF6djQ3YVlOUk4zSEJ6QnRyUjV3?=
 =?utf-8?B?V1VSd0lyZ1BLQy93VTZxUm5YRHhDVEh6MGgrb3owalE1aE01MDRpMkxYMTRJ?=
 =?utf-8?B?N3kzdzBPS1RRbnJjMklKMGpmVkZhVDhBWHB1RThKSExyWFNCem9jWTZMOHlG?=
 =?utf-8?B?TlZQYmNLcDlFcWxRYXBscVpFVnhrclRrM1kzRTRkZzhHeEJxdEc0V1dSNjRx?=
 =?utf-8?B?a3NJNFVFdTJLMEYxTVl0VFBOQndiYlpGa2xyRHZuQjRRUmpGcFlBMmZ4eFYx?=
 =?utf-8?B?c3daejZvY203MmExNFFkUU0vYWl4Yk1DaFFqSnM0RzBwN0txU2oya0w4VzFM?=
 =?utf-8?B?YUhOcTZaYVphWmcyU1NxeURFc3BmTGVsQlZuZzlUY0dPZExlZ2dCNEZodEZG?=
 =?utf-8?B?MmtFdTIwWTlCV2xHQ2EwL0ZVakZpWjd2a2xTMFhWRXFrOE8xU3hlU2MzMGV0?=
 =?utf-8?B?SVU0Wk1vQ1FWb2piUG5nUmEwbGo5dHBOWXZJcGxweGNlS1hTMlpvSzB0MUxV?=
 =?utf-8?B?QXRMZWdnN0lhNVJwTFl3V281c3hDRHNSNFFjVFFFMS9EMXljaHpkdDFLdklE?=
 =?utf-8?B?VnFMODZ4bDNLWTFoRlY2MHIwMmF4WmxmdXMrWFV4MlVKVDBoaE9iY0tMM0xZ?=
 =?utf-8?B?Z2lhQXJZdzJhejg4TEN3UlR6OUNncHk1ekMyaW5oRkpGWmNiZmEwWXlOeU1K?=
 =?utf-8?B?SEZWajY0UUsrWXFWVUtZN2dyVTJiQVFyN3FrVVZqd0RqR3huKzFTYzg3NFF4?=
 =?utf-8?B?Y1NLZ256YWVXREpCREorM2lHUFJsNWtnSjJHZHVpeFJnbUJ0UDExaUpVNWxv?=
 =?utf-8?B?RmkyMEsvUkJuc004aXZVWUw2YWd5MGJpUWtwVzJMbU1mWldGVE5lS2d0bmda?=
 =?utf-8?B?aGJkOEN2UkVtTk9la25BSmVJU2NaM3hDYlhQNGh6NEdRTldzeW9VRkJ6R2sv?=
 =?utf-8?B?WjJjWldhbDkyUzh6bUlqcFlxSTRlNHdzZG0yOEJjdVZwZEhwVXpMSTg5WUl5?=
 =?utf-8?B?eUZwdzlvbW9JcEhsbHlrQkxvY3BkblpGcGo2MWYwQzJvLzBtRnBSNHNJYUZG?=
 =?utf-8?B?dVBCVllBWjRsUlYyOGhFQTVlejlFWVBVb1dhR29PUkFuNG03VjJKcG1EdERU?=
 =?utf-8?B?UHIrY3kyZkNRNXdnc3RGUW9nODY1aisydEJKWDM4Um9EUGZvakdZSkZkRlhk?=
 =?utf-8?B?NjR5L3JlajBEaFlJT2s2ejJyNFFNQThvMHhGbVNGVkQzQUVTZVA2eE1QeXU2?=
 =?utf-8?B?aHhUT2R3Vjg5Wk8wRElaeDZ1VkptRVVPVHpTWFhTR2ZTejh4eTduV3hwSk56?=
 =?utf-8?B?KzdIckY3WmVXYWR1c2dRWWt1SlhaK3RGV1Z1NnFPT3FrNWFZaFdDbmVxVHha?=
 =?utf-8?B?QjFUaSs0MGVLYlB5eCswTE1WUzRtU2pVVVpOS3pPSk9DUnJSU1VVZVlaTnhZ?=
 =?utf-8?B?eTZDcWIvMWVQQzk3VW5ianlrL3dhZjRSNkxaVVRPN09zUFYzWmtzWHhsWDJq?=
 =?utf-8?B?STVaZkZDRHp0dW9kZHZHNFNpUEJ6ZXpQc096S1pVSktuS1luSVp0R1FOcURp?=
 =?utf-8?B?SVpPZnFlRWFqWnpxZ0dyMi8zUzdUei9mZktxM0grcjRETzZoWWxMdWpPSzhM?=
 =?utf-8?B?dE5MSmlZcjNEWE1iQU9rR1dXc3FkM2hJK0IxUT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 05:02:40.4059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f287a9-84f0-401d-7927-08ddac93054a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540

A few selftest harness changes being merged to v6.16, which exposed some
bugs and vulnerabilities in the iommufd selftest code. Fix them properly.

Note that the patch fixing the build warnings at mfd is not ideal, as it
has possibly hit some corner case in the gcc:
https://lore.kernel.org/all/aEi8DV+ReF3v3Rlf@nvidia.com/

This is on github:
https://github.com/nicolinc/iommufd/commits/iommufd_selftest_fixes-v6.16

Thanks
Nicolin

Nicolin Chen (4):
  iommufd/selftest: Fix iommufd_dirty_tracking with large hugepage sizes
  iommufd/selftest: Add missing close(mfd) in memfd_mmap()
  iommufd/selftest: Add asserts testing global mfd
  iommufd/selftest: Fix build warnings due to uninitialized mfd

 tools/testing/selftests/iommu/iommufd_utils.h |  9 ++++-
 tools/testing/selftests/iommu/iommufd.c       | 38 +++++++++++++++----
 2 files changed, 38 insertions(+), 9 deletions(-)

-- 
2.43.0



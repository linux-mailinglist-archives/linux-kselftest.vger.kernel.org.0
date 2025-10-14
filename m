Return-Path: <linux-kselftest+bounces-43144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FC9BDB758
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 23:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB4942235A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 21:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCD62E5427;
	Tue, 14 Oct 2025 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mpTFkBez"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD93257AD3;
	Tue, 14 Oct 2025 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478552; cv=fail; b=pNXz/clLNKPha/s6xwDBhWwzcgEUxoNi6q64OBDuXwcOB2KwOd6dXsqLdjRr+i6sPG+t3KFx/HMdwNlpfo0xaUD9rnn3IMloGzwg6Yro0hpA734qevBY1VumXrP+3FRHlCCFX+B90HDonO53oYcLUmY0E14lFf6I2WJiqkpKtaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478552; c=relaxed/simple;
	bh=4wAU+xCn+Jc5eFrb8HJlJOKggdTA2wlmOXMEW/Wgn5w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N3GYH+Gixt2e5UYLvFgsfmL8IOcRsKNgEz9ANMli4oqsByeuabMu1UrkQdqeL9KkPf0VhBQZ8yFjG5g2gBhQKJS+Hj0gYN2wf5plOM5HZaT8YUqkFUxD+FiNvvi1p5KVJDPxPorQ6VMpoz5Tc6VgX27QPsJz7cWYvbBeJdgHFPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mpTFkBez; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRlTDg7kfLPFeROY02YGJjR6R0optBGQX/G5INJRRHWOhFHALHtsOwG+ZTOv7IhwwyYewcoD9mcSUaxig42u/ez4mWGWloTL4SvLeLZTlsIgh/q5zIWewxWt3ZsG5TlrDqR1Y+e9Ic3WtMkPJlrBKQKqCdRG4bB37yeJM1FXT5s8F7pteR+hMDvDyAAYEN6xRtYuyZLxvUCWq4X4/gODP4FMBNv1zoDAPIehNga2V9Z8T8vx8AleVwVl9qDTctJ/oTaQwdSahGC9od7yKc92QxOt9VUQX7ucwV2GtmatcwDZdEPU7Ia7qVp/d6tz6bn4JSzrmLy2Rosw+TAF4SNblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8xq3Hb7LtIz6P1CF0eKvwTABDkKqzWdOgqZBgg2W0M=;
 b=ah70ind63fmhno1MV3kjPMpB7hWyYSHiZjTQRNgd9PDrcVYS7ZRIr+x9p1h04PBmK+vGEeIDKxrNZ7+SwG0QnRtiiIpOBcn7uhcKEXm+wVzbRd+XMFdeD9aaWYAZ5WFlMfvsf3TsMLOfxeBEEn6E86wriysXo5Da+VdTNjqFc9Z9FRWiO7BDMhOt7Q5jUcuLacfBFikOsmmzRxuKWTEbEV+ZJuvafPd5XhMYBQGO4LNMGWV2ZwZhBOe/WN+tBxD9I5Al3pro5oKtlfprWxGK8b3+0nSRSl5cZ9TyhAXV/Erk6bTlJnTFl3lxBlIDSPYJ5+d3b9k4sUb4IOH5KiMWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8xq3Hb7LtIz6P1CF0eKvwTABDkKqzWdOgqZBgg2W0M=;
 b=mpTFkBezyC6+bS4+0m572Y58aDjdYksx7ONkjBC7ihx0hSpzIMahhX6WfkbbW7/B1VJe9Zl8uytEKMnDz1lYoDBlRBWl5XYfnL9whwTuvgdHs7eQmDxlsWWyxjS2EMjcAHhCsG99zIrl4RhnoN145tbgXNfXTYQRk/+NGFbaAmIbI5YW1rJ9SeNTc6+jlC+IJ+rMF0IuV+48FLYz9C0rq4idtYHzXqrMut9a6okBWU2KDn1oy70/i90PvauXCXu0Vu88BzfV+PV0KosvtDBJ7RC3gTZrM0xNFhnXE14ydhQDrdDjzxYBF2AyhxCeCYwxN29GcNVpPQu7sFnQi9mrCQ==
Received: from SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 21:49:03 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:338:cafe::c8) by SJ0PR03CA0160.outlook.office365.com
 (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 14 Oct 2025 21:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Tue, 14 Oct 2025 21:49:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 14 Oct
 2025 14:48:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Oct 2025 14:48:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 14:48:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <shuah@kernel.org>, <alessandro.zanni87@gmail.com>,
	<iommu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH rc] iommufd/selftest: Fix ioctl return value in _test_cmd_trigger_vevents()
Date: Tue, 14 Oct 2025 14:48:46 -0700
Message-ID: <20251014214847.1113759-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: 327ee119-6000-4ffd-15f0-08de0b6b7de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XzywI7YFs+Wsn3ThyOrVxpnKQ6juBnQvnJY9/NZcnR4UOT+hFRu7GTuZ1Bsw?=
 =?us-ascii?Q?dBuRAMkObjI3wkwOQzP0V/8iIwnX0gOx4M2ieb99nx5lajXoduJbPaf34ovE?=
 =?us-ascii?Q?atVFmDx5D3UQsHH7ANnVoKeExaT7/CU7Ms9UgCNGyRJ3O8RqUglE2qo3Nyzu?=
 =?us-ascii?Q?WLGVox9Vuq3yczv42ZdaE9vyvG1sKQ1zCg9za+P1Gs9s9DZkIJs0xB8+Xhq5?=
 =?us-ascii?Q?HeSJaAZ2dJYEAcpKve+YTIeGOpWLFZViS0aRYEVLN0GmUvHa5lmy/eqVdj+K?=
 =?us-ascii?Q?1Y94xTVuCBkRLGh/QJL4R9Mtme5z5N0Xnat5WzaVD24UMV3B9OlSAQ4tw7Sk?=
 =?us-ascii?Q?puULYSZL1zmzB4zWG6qUM97l7QHXQUrELaErNSDkmOB2TU+Hra4tH21noc+l?=
 =?us-ascii?Q?XfSut6t4p8V20W0C4r9bafP+p95Yqy1IiBPNDJK9dLz4kzXjA6IoSXHFMD9s?=
 =?us-ascii?Q?o+JrcnthjMzNic2bsPrdyUB3SNBPURj7qGj+R1uLzvIXOLfdZGiWsM0rAboL?=
 =?us-ascii?Q?CajPzMi0w+kfEWXjZWteVqHSjtBHHhnzY0TjvMj4zxMzI+MCBaHPCdVxMPly?=
 =?us-ascii?Q?pu+VGmLf7mpPzo/ahwFsDRB76i00/TfxMnHhe2pGPf3VPZGVNHiTtPFa2IFI?=
 =?us-ascii?Q?4KZv2D09kwapp++Snp+xY+Amz29KCvstCbEuI+4atpSlyV7KbhOqYqlN5doR?=
 =?us-ascii?Q?jpjYGw2xMroUkBaciFg0euZM1xf4rFscf3WDgg+9Kr7r8GQWHtHpZ2Jz4PuJ?=
 =?us-ascii?Q?hELNgw0rbBi8FNyRLR20oCFl49EIodNa/YZYBdGSmc0wJ7VNrrRtneX9i4jY?=
 =?us-ascii?Q?ERxtRcuB87s+sgL+8FJTECFQyJvtpKXrjmeUganPtOeFmuXXkoOw+icHdNP0?=
 =?us-ascii?Q?YfCn93ljj1nAD1v5GT7+TnDHsR8xrytbIGPGJ8HnHXZmwxHAkp0mRqQogzbd?=
 =?us-ascii?Q?aPJW+0+xd+l/27sMrPY7YU02zPVJzAZFHqi/0Tl+YDhumlOj29E/H0nh42hy?=
 =?us-ascii?Q?1pLUStdSf7uup3at5swm2XIKRmGVdZ8C3krAh9fidxKaqSIud492scSH5mTY?=
 =?us-ascii?Q?5wZi7uIs9RevcNx5+eIyQpoHpO0q0DQL43rzgdgRMJ47Vb3THDAFHtMZ4ovG?=
 =?us-ascii?Q?H0tSr08KMffwnkixrWSDvtCJmt3UaHPuyawU9J2LKuG11PTcI85B8kbT3dVb?=
 =?us-ascii?Q?+tJrNBro4jWxGbHdBBzOd0s6pPEzPwMIIWKdkVlZTIds5z/Ztf99drFDKTCt?=
 =?us-ascii?Q?Pc/V8GBaJ23QnXdRnLWyZOQZZ2pWw8j5uMpKKOeEgyzPbPZM9O7bj9Yv/9l8?=
 =?us-ascii?Q?GjXnOoF+S6d2MiZlM9n4ri26Lwye9Y4SN3KzYUFipNfjHOC874wF7HXQQlwO?=
 =?us-ascii?Q?2PDpjo+u7f+CubGMHf73fLo7F8CYqZOYWkQRzzi9kqHXHjTj13z/jbeaPOQ8?=
 =?us-ascii?Q?vAV9mIOVGXz6MZxBXgfbUM+kAFZLB+V4flwqjsOWkNfB/bzaN9DLNoztJhAp?=
 =?us-ascii?Q?KJsFbD3/YK3vuq9yJgJv0jiy4gr2YT/DcApWMlH3rCVkyKtrBa9+66rpAJM9?=
 =?us-ascii?Q?wzbNO6u+m8KDAm9JMdY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 21:49:03.4660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327ee119-6000-4ffd-15f0-08de0b6b7de6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631

The ioctl returns 0 upon success, so !0 returning -1 breaks the selftest.

Drop the '!' to fix it.

Fixes: 1d235d849425 ("iommu/selftest: prevent use of uninitialized variable")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 772ca1db6e597..9f472c20c1905 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -1044,8 +1044,8 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
 	};
 
 	while (nvevents--) {
-		if (!ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
-			    &trigger_vevent_cmd))
+		if (ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
+			  &trigger_vevent_cmd))
 			return -1;
 	}
 	return 0;
-- 
2.43.0



Return-Path: <linux-kselftest+bounces-37515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EDAB094AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 21:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6CE587223
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47842FC3D9;
	Thu, 17 Jul 2025 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ngTTnWWF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0A21D3D6;
	Thu, 17 Jul 2025 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779720; cv=fail; b=tDWY3UHavLlnlp8kQcF0QkfcNJO19TePYSBKqQqrMP1WkE0raMUiYuSBsgeSWR0k0JkyghWfaA+T6h1K4JaJ2VqhxB/gIh7yeDJw/lmjeZbvUhV1ydgsc+u0a9E39DnsUrO23TDO6U9xHl2dbrmpJ20VFy7XgGLmCjRBausRrus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779720; c=relaxed/simple;
	bh=fXvxspjza5XBAFz0dhf2wSdn//pH14vNfQVyFNvMb9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zu/FW6fFE1fSflRbenrjMcY+XkNASiBlnaV6UfsmntKV0UyR5Am3vS7bOBB9gY+Ifw/q1bDzk0YejGuqgkqr9dniNYCOt9vcTdaasRd05rP17TeNiMscEEe2oLOxT2JvbvM17PjmI+6BbHZrtcxJieksd3HIOcQ4sTr+tJl99cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ngTTnWWF; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8YQ0/O50735iaUTXIerD6H/V/FfVrGxMdVHYatlVRcc6edWRJIddrN4SsV7YBS30GRTZlki2G3ph52GgJbgvtiMDt1JEbC7CmsFMU0MtVyklNkfu8A5L1f/4lw874e2JDs6YkaLiZFySQC12vtzK0fzeoomu2ugIwvgvaRi/TnPWJEBvRUoHW3QGHaPnAZPnVQCYD8rDF98/WBBEaFi+RVEi1kUoh6LEWRTgH6zFLchpENRyUVYwfHaXcHmtXngvAF6DiChUu39Jicg5cmLf9A67/Cy6si1MLSaap/CLT90DdIBXJczJ5KtwQcMpQJ7NabXM0X8bWIReQhtUQSp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35g7ulnwitjADq73yZkFNyGvM7BWljLp1BciuDSAwxY=;
 b=MJpfIbL1eq8dJkMuooBd5G6ix4AJ4xduFGC2rNn5ppodW6HVzjHLb6EELTT3GLNKC8vPoR8Ia/+wos3+oaXLwM0WfYjGM5J/btzsAC7PxbKwF20yAFG/EOXIt2J3emGFhk8AzhV2/nKkulgyUzNtL27DLS5PHkArzZnWNqJAoBTAcM6ejLb0JEcV4Ll8XBAuLpqvYyELB/fZOo2YP2gSFE+oTBb5Xbstkz5aQocemlY2JTTPgTsrUl2DFhnrHF48cr76dnRr+IK4120ZU1GLHh3WXcolLZjaTU6ppDywGfhLeln7qbQnKwfToV5Jl4DGhzbNBucGEwbxNB55p4y0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35g7ulnwitjADq73yZkFNyGvM7BWljLp1BciuDSAwxY=;
 b=ngTTnWWFHGR83wrS7huJjtvpQ1BVhq8IzKrS/8D/I2xJsXChuyMWeJLUj2/5vjtroINzKBx7vdVNrIExqd8gtVFkY4mCi4HQV5HttkXORVN4OedOTZv8wKWSbrZzVdPw4rqh/x3asqu7uiXlu9L1FurepPbLvO8KLpbDrWR+tvlu2jrVFc0snao72N3WmNTvF+AXvv8tUI3lVtromTYiBQbtz/TmN2FmTdFM9upBShxegCmy0TP/YBWB1WwNVfMCrAIDTqBdo/IhU/RHccFBUcldq7eJtsdVnuL5bTnHVIyH4qf4enf8wwieVOwZIDvj6u1Z2CSoNozvKVpOlTbnow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 19:15:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 19:15:12 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 2/2] iommufd/selftest: Test reserved regions near ULONG_MAX
Date: Thu, 17 Jul 2025 16:15:09 -0300
Message-ID: <2-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
In-Reply-To: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:23a::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: d46d4882-766f-4e8d-bbbd-08ddc5664018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ku8BCw1TWOwIxfhF3QwXRqEl4uU4GD0uWTEzL5boYfbGyvxDgiusbspXQYAV?=
 =?us-ascii?Q?fDd2plMt8SSdSh5roL+ef6hzsFVQ/E1p3KKvqrL032aPMexIr8MyMhMvxXX7?=
 =?us-ascii?Q?Qlg5RbvfEOEuecgIR5bNROwSKIJM9gzp4+R2Yc+lykneX/gM6xNbRJkq4+4G?=
 =?us-ascii?Q?AlNP1eqs2Q9tbKfvZCuMEND75n/01YCedn7rPMTMh9hKBJJHs95mZTSqwugs?=
 =?us-ascii?Q?ta9nupzwMSpV1qrGi+H/3ZL/kVEEvZ/6/BzYyUoT807naBvIzV318PC7AS86?=
 =?us-ascii?Q?QlEZEqMC+6tJKLZ/PpqiP18XHZBX9fGnrKnlpR+QwFHsejEn6bbtGR96O222?=
 =?us-ascii?Q?KFKJlqxcZaOWyjkZUc/4R4G1uMaPshIPqzyTDbV/fn1B/yGhm+lxh0R6xu/z?=
 =?us-ascii?Q?ZW19ODDZNde16w0B7E7jrzyPh2Era5vlGeJ45Jmj2p0+Vv8o5eh2MOqRelKT?=
 =?us-ascii?Q?vdb/203gqMzBILnRn7i/BUBayzfI3vRWCq7lJ7NvTQnUyKh+9YMd292cMlxn?=
 =?us-ascii?Q?HMgXlJgt7hRetaYBQnk3fOKOjF8ZzlBcaD2jFC9y1Ul7MbOCzD/ox8BQ51TO?=
 =?us-ascii?Q?KxtyWeQ28GHWWvBH+RM8ofGmoxej7OXUE6ectrkdHtOtMOeBYP4SuR7dmfJD?=
 =?us-ascii?Q?GoHabXPz04RKowNpMQCNjsN/rQ3SwmGMf97fjzvxpFMlVb1xWmkqL26VFhrl?=
 =?us-ascii?Q?ETX8bSH3t8NjpMsKqPQwBBmEyNOwG424RyMgtLr6lJKWx3KVBx3oXtU9CAls?=
 =?us-ascii?Q?lOoiOtDr+2SfXw1wwrTS5+NSXjRZglDYPxWkBnkrP1uQJHFEla/zGXyNTaDm?=
 =?us-ascii?Q?41DcrYrdAklMxqYLM9vHsIbhqcU3IORdEDa7Ca1Jw5AwM8aFBmAM3W9bXl+V?=
 =?us-ascii?Q?qASOK0gf14Cf9+RD2jGpTl4ZJ+znB0a1jdZP2kaRyQS3A6JsE712vF3NC8U/?=
 =?us-ascii?Q?x8XcgHvVcTVNDaqAZvREY/NPdai4tIT1JyyEao3UeVljbsyQsl+20EyAHpaV?=
 =?us-ascii?Q?TN90CsSMxC9kvpYtx+f5lu6/M9QLbH1+0vlGVTNOt455QifzXtMgSgvUlDct?=
 =?us-ascii?Q?EW70mrD/kz92TgecBkcLnQz8iJaKt9yfLzRuWZGt+KL+RFeq3gwjcA3WfUva?=
 =?us-ascii?Q?iHuFW6LMZdm4DXKQAhdsiV9CyDvcBGPlKwXKH/d43Jsj5jWJcVVCvY4hH1Wk?=
 =?us-ascii?Q?BtGvbX5nKDauLy5FaLOhIrOsejlMyComHpswfKgkonRwykK9ITRNRKCQIiaH?=
 =?us-ascii?Q?uknX0JZEE/gZkhBiwKGxdyTaetj7KEuPhsDn97f2lWazWLulT+TVpE4OUMjD?=
 =?us-ascii?Q?sl0FVCpt3mrooN3HOh3ijEcNFEvl167O9vjZpKnUjD9wqOQcWKMOUay3mtnU?=
 =?us-ascii?Q?jzjvV5zLIOwSGXeCLl31dG+EhelVfGFMmpHY3edMtj8e69Hrpbhj7Wl0zgtg?=
 =?us-ascii?Q?cLeA0JjFLYY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q1UzcMMjX8GXr1S4E+7V3v3cljtkSi+QJFUJpZydd85vKHGPt5Epiy6NQ9kj?=
 =?us-ascii?Q?G7pFlvqce0I3Zx11qL7yWAP/0ZGnHLBDO8DUZnKJ1MEhUli7H4L48b+zB0tp?=
 =?us-ascii?Q?rPpkClvN9rppUXXRYralaZdg5atOZf/75Kq5fcfx5iM6CRZYF8DBkBAahEnu?=
 =?us-ascii?Q?Wtj9ES/ZnVaYkek01ZZglJ++9GJ7K0cDr9lxNdmSVQaXc3O0jQifz03Vq+Hw?=
 =?us-ascii?Q?GJCNUsb8NbiyVvVx2t1xk3NiqZTEC8le7YC5BRmjeYqH074yWRWKdvlajTEP?=
 =?us-ascii?Q?rRzr7LrgBOK7x/Z7uCqRNLm0Xusyjuztrvm9HgqLIFerUXq9rf9TmPqcwXtE?=
 =?us-ascii?Q?WGWg7YPtZ2iqTGmb2cGAn0gAsPWh09YN06AlksnuzY6z06B1DLClC0MtEfsU?=
 =?us-ascii?Q?BiL8IcmPV4GxbcNbqdswIbECdPn8DeNM/8yyRBw9WjDnr/GLIYoG2Ip7mivh?=
 =?us-ascii?Q?Di6LRXGcfbasXXyZzpcfyuBA7AXofllDXRK3bVhymX+yjfi+jCY3tssR1y0A?=
 =?us-ascii?Q?qQSuk5jrgvTyIGAX9U3LhyHPcK6YBEKXKkQyvUR1UjbZJZZzQHyApZvFvpdr?=
 =?us-ascii?Q?8FxJ7IvrmmKnCQIFSvSZlj/l9im/JA7DkKHLXtaEG3vFYmNVGF0OQiIq0fFM?=
 =?us-ascii?Q?qAEHWxiDaCZViMZGARLg0K9AxzjEDH+g80FWa/wn3NnVMsYwQ9d1yu23+XTx?=
 =?us-ascii?Q?zoj7YxPXfz2cFJM8OTN+G9SV7rcxcA+TFAvGbgrSTmPiPPbxn3iOgT1T7+NU?=
 =?us-ascii?Q?vi4NmT+R3fpzMqnz3TJXPbedniVU5GPoneXnZkD+pKzH1j6xRAg78RebEYBx?=
 =?us-ascii?Q?i1St23AghnQkaojirJ0VFn+Q5sAXNVWOc6MoYRDM1295L163u+q/cTbHUVms?=
 =?us-ascii?Q?vmCuvoFAi0+DwRJTwCBSs7pwgfI/L6loirwdRMh8wBOn80Rf5S6o2RedT/O5?=
 =?us-ascii?Q?L7zav0O5wMFK9rzWfyRdfzg9N21wSmK0P0CcZH9O/hjL4rGAMSAdp36nl8gP?=
 =?us-ascii?Q?q0Nr3UNdxdz7ttVMve/pHvEiaub36L2lmkJgd2/eDBScxt7PU2UHwT9n5GXN?=
 =?us-ascii?Q?r8l0KP3dYcKQudOjIoxU3SVSi5P3gKxAFaxsKY7RhTVeRjRrAgrDcAD1F331?=
 =?us-ascii?Q?GPonHI8NGzTXxmMgHdYFDACx3Rj4ur41oEhpus7+SH8QkeHlGYgRih+uWUnb?=
 =?us-ascii?Q?A+aIpW0zJzv2RukLQvl9e42/PZ3ojZ82OMquaV9it6ffgn6fuEUiJVzjZaJo?=
 =?us-ascii?Q?iXmlrb8A0ETklQChRRPkV3UUS1+kAlnb5ZL6Rxcw8hR85bjXoqYSe6xm5iPL?=
 =?us-ascii?Q?WYvHwSHSYnwQhrJrBhhWlLlAW3YKXQPrI1nzniwKBYnjHho8VLRfqNdA1tGN?=
 =?us-ascii?Q?8B0Ic+G14BWddUfaFLgnBuuTe7a2EC8P8cHJTrtH7vP6OBSk/NcMaRwnoQ59?=
 =?us-ascii?Q?oKZIA6QOJNaeEYaGd26tAsZSQouM/qk2kbHRgoFXSUxoT0l+yDAbJUSgUr5d?=
 =?us-ascii?Q?ukLtmqp6zfO3+zGIcgUr20nTXxYG033tcWHTRP6tud9Vk407rw4H3IwbKHvx?=
 =?us-ascii?Q?Hl6gDtxzgW9WKe1et4vEDRY6ijyHUF4u7k2k3EDb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46d4882-766f-4e8d-bbbd-08ddc5664018
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:15:11.3528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kvd+tcmYbIOGF94DbxEsYyq7aBIjbw/DlJFRWLtGQsqxOas81NIJCDvThVj9s6vC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

This has triggered an overflow inside the ioas iova auto allocation logic,
test it directly. Use the same stimulus syzkaller found.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index d59d48022a24af..d9df92e27264b1 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -968,6 +968,24 @@ TEST_F(iommufd_ioas, area_auto_iova)
 		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE * (i + 1));
 }
 
+/*  https://lore.kernel.org/r/685af644.a00a0220.2e5631.0094.GAE@google.com */
+TEST_F(iommufd_ioas, reserved_overflow)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_ADD_RESERVED,
+		.id = self->ioas_id,
+		.add_reserved = { .start = 6,
+				  .length = 0xffffffffffff8001 },
+	};
+	__u64 iova;
+
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			&test_cmd));
+	test_err_ioctl_ioas_map(ENOSPC, buffer, 0x5000, &iova);
+}
+
 TEST_F(iommufd_ioas, area_allowed)
 {
 	struct iommu_test_cmd test_cmd = {
-- 
2.43.0



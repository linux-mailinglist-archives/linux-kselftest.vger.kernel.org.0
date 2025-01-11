Return-Path: <linux-kselftest+bounces-24291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C731EA0A094
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34453AB46D
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C29192B8F;
	Sat, 11 Jan 2025 03:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n0F1+WCI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12215666D;
	Sat, 11 Jan 2025 03:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566413; cv=fail; b=ktmhxBikEUhx1Gy1IxCnpA/+ZyXOiV0Zer9D9Q/PekvWQ/JCmDf8QfyTo9uEzNQGsTGrHmNzb2fTN/w9KAyaMp0B19Eb7/+z6tpfXqxe0TBtSMhRl9tA5p5bqkEyDAowYZPhohPIkBiOi6NHyIe2cFB6pw2fKvMUeteeNu6NReY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566413; c=relaxed/simple;
	bh=54KgyQD/E0XwRHaChIL65MKk154H8bbll3U6CkStR04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1uX0qWNmc225KilbW2BDPMMwMfILF5vXI/U2QNwp5evOGR+OL+vHpW3TLICbspPyS3mCzOuLt5PC5Dpkp7ItIfKU64Lco22yLxL9m5iWGwvEAYusSwrMaDeuB26U5V6SFhBwJ3gzYTbTWK6hzPFS2CBJm7gPQ+/eDcG9sRr1to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n0F1+WCI; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPkiRjQJE2XIXTWfXwt2wUjmnL5JDX7BkhKCHUF6I8mvDKXbjzDiyymezOJN+r3srd8n9YPNKt0ZvxRlxCd5SRtKXrduPG0bf61m/22AVzw8scMsjJJda1vqJ6EzIOAElrnOndbCauRLY100KJXDuLeOUNVrqSfBpWHszhEeQn8x6Gfb/lWmbPB7HGmnu5F/ia6LGN0cYeSAffJ3I3azHqXvhA5hSZLRtAPM3WmADBml51T5enem99LkmY3S19RUvFVja0Lk8YKZ9Y27Hr4r31WfmqG2AwnZTo6/rBc7rCp1lbW/km9N3ZyAWulg1Z/CkI94meuubprxA+ZGQscY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eakZW5IlVQV+N3R1waxHRudWYFD83Gi+LhTTX6ovfT0=;
 b=tFhrvCvipiXaLafwvkEFZwFtOlCJiWpAZSP7pW98xVRprIB2vNNeAm9Osla1y7HVcPCQjE16eYRl37lzRWqvAN7cfGq2/8MD1JUMiGdcrPZBNCnhls87xVbwPLnI6VZgEi/dPknMaxjbGsfXy8It4Ne5wxHJm03IRcnzocuyQixFv4YfGhggb/Nffg2k5o8dilzzPH7x2854p5AyP0OnE9N8DmpykePzhNh2m8BGRRx+XzlyAuq6gMGMWVR9+7WxinV2lScmpoJthnRLqqrLlsQqnlT28+kzs7M1dMQ3FwlyCx9ndbiC7bNokYPTm8vzz82YVfXd9m2k/FSqCSFwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eakZW5IlVQV+N3R1waxHRudWYFD83Gi+LhTTX6ovfT0=;
 b=n0F1+WCIClMZks+JEWtjrTmxHoScevfooyyj8xllp93DC6ebuUmQ3N4wnSSPtEkpjRahzrsHKX+XZBxbS/cNhyOpEKqb4veZGzpy7xSe/Sk8gjR//x8f2KUoO/PK68S3XqJEqggT2UVW57m/Ubl+K5y1tMJYPqORUkH1goA4/nME0DMUwsMbSgdsnAT7aHlUUJ6+7GkHcHmX4zS3MpVHGwiuFdmxQAtkLvqujZ/kGJJPan/PLxcx6n7CwFzwiOpA3+qf7PY5+Q/n0ZytzTQ1Mvh656c0IRr7YxhfxsfUT7KpxtsLqo/51c6zAsZ0pwnw411WceH+VzMl1aAbypzKrA==
Received: from CH5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:610:1f1::24)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Sat, 11 Jan
 2025 03:33:22 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::59) by CH5PR03CA0005.outlook.office365.com
 (2603:10b6:610:1f1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Sat,
 11 Jan 2025 03:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:33:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:33:12 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:33:11 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:33:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <shuah@kernel.org>, <reinette.chatre@intel.com>,
	<eric.auger@redhat.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
Subject: [PATCH RFCv2 10/13] iommufd/selftes: Add coverage for IOMMU_OPTION_SW_MSI_START/SIZE
Date: Fri, 10 Jan 2025 19:32:26 -0800
Message-ID: <90324186761da811c0e999b6fe63271e852efe03.1736550979.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736550979.git.nicolinc@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 7857c171-6cb8-4d01-9c5b-08dd31f0b302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VRfWYwSWKpw9HPYCPD8sga7DkKaWuDMwBWRUDBImVztGAI0C4oPjC7tono1X?=
 =?us-ascii?Q?wroGuEtdY3/bZdJoQQzcPswa5ILoIisfsDjyLzc/LdQ7tsVQVIdYtBwKePF5?=
 =?us-ascii?Q?Ev0lEAMX1rmgIFvxq3VF4u6C8ccFEc1qioQZZgJAAIvwpF4wt/FPDKm8SbD3?=
 =?us-ascii?Q?TbHFQ73iHdLYbb3nQN+fYKWLMWZDeLIdTxl9CK5EqoMFimf27H17RGbT+76p?=
 =?us-ascii?Q?L3alJIcglMqpoOY7yCdB/5LgeQ68as8gE69o/9BkYG3DVkpg35SlQdYmJzst?=
 =?us-ascii?Q?bhHG5PyrQKI4vGMLJjfxg5JMGFIRvz9qGGzFqMRuevlaKjpEbSQ0RIjx4Bra?=
 =?us-ascii?Q?6ax1SCDJ5l0u6Y3xafhes/6F6lxDG2AHQzTX/8hn5E9Yq81GywGPWLeuiM8/?=
 =?us-ascii?Q?3ao9LvTqwsBT76KhcIhBK3BMAWT6BWsflwLGHF7y3cGsTA3rwuTWCdMmBqOk?=
 =?us-ascii?Q?tR1A0Cowe+Ld9ijZFUWvUP3Ya8xheIjmpVXuflI0Al4GcS2lg879ELnnKR5K?=
 =?us-ascii?Q?I6/V+RJApXnbwsR17HgGAXbQeGOkq3ISLYOrLXjULjllUrxCjUDxod/znlIM?=
 =?us-ascii?Q?fRH8kHrig0lKjt5RGBIpjF/6NHrUwGjo5TBb/9Q28gdQhLrI7wCqJBQ5pCK4?=
 =?us-ascii?Q?vwM4bmxKqP07KBe1Pq61qP4TDnt1TEu243m1rIdjbRQdxy76ZGjAZIlmKw3S?=
 =?us-ascii?Q?QbvR3DHLma2cZNLsPStk2xDBj1LcVHEfEu5iPOTODnXw/fcpZ/fcLv4f/m3R?=
 =?us-ascii?Q?MBr/qnV//9rkvT+/eliY+PrjZk83rli7oktNPNSJwL49Bf7y+sP57FBP2+Tt?=
 =?us-ascii?Q?TKa55v9vL12C+2HuOlZRFNfHRGaNmZfL8c4sh9jH3joqGHTGck4w8V41d3Wf?=
 =?us-ascii?Q?4Opbnk3l0WzJj+cLDiRECFsmVGhSAE5fQ11F3ODmrBi87Y6wdrEWwBAB3bcF?=
 =?us-ascii?Q?vFypFDNi9MxJlnJAhEFD59ZNtXGMyq26jekMWgd4vIzc+G1bG5Fq/tcgqtxW?=
 =?us-ascii?Q?JCi8WvlA7/DNF3CoIP1p5NSe9o0XvjlP0AyuPuBCJHzPWQuagPVyiqWVFhM7?=
 =?us-ascii?Q?QYI8eFESBpy5p2/JjbnIFHhiLCvQItI0nF7SD1ojWHnGUeCvC220eyUsDBna?=
 =?us-ascii?Q?x/b1+wl2fGFBjkA7yETDm58L8OMJjasogHsvrUE1g44MICwspaIf6xuXOF/d?=
 =?us-ascii?Q?icjdB+8MeeNQK/G717V6+1H9QXrP6+upMDeVuhAS42xdav/t3DXDGQR9VEP0?=
 =?us-ascii?Q?5G+ftRIX9FWN+KSK/73dh/UDh9+yvNjPUKNv5OZ4u9l0PI7YsV9NfGpp3O4j?=
 =?us-ascii?Q?C5+cLDDLZWdqz8CwrLrLt4YZHc4QKADysCEInkw0C1ZLOJ/OXwu2mZCGQyCv?=
 =?us-ascii?Q?YHPm6HvTFHZSwgQ98McfmplBjSklSsKQgQ1gg9KZLbes4HsMMHEBwpW69R5i?=
 =?us-ascii?Q?erpMZFyyncPl0z3AL0FSO2ONWCjz5N0Z8HVm2EKJIKXRTXRcTc5gqzqX9X1Q?=
 =?us-ascii?Q?eVbyxbjqszPbmLI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:33:22.0433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7857c171-6cb8-4d01-9c5b-08dd31f0b302
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238

Also add fail_nth coverage too.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 53 +++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        | 14 +++++
 2 files changed, 67 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a1b2b657999d..87b5b5ac927a 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -334,6 +334,59 @@ TEST_F(change_process, basic)
 	ASSERT_EQ(child, waitpid(child, NULL, 0));
 }
 
+FIXTURE(iommufd_sw_msi)
+{
+	int fd;
+	uint32_t ioas_id;
+};
+
+FIXTURE_SETUP(iommufd_sw_msi)
+{
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+
+	test_ioctl_ioas_alloc(&self->ioas_id);
+}
+
+FIXTURE_TEARDOWN(iommufd_sw_msi)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+TEST_F(iommufd_sw_msi, basic)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_OPTION_OP_SET,
+	};
+	/* Negative case: assign an object_id to this global option */
+	cmd.object_id = self->ioas_id;
+	cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+	cmd.val64 = 0xffffffff;
+	EXPECT_ERRNO(EOPNOTSUPP, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+	cmd.val64 = 2;
+	EXPECT_ERRNO(EOPNOTSUPP, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.object_id = 0;
+	cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+	cmd.val64 = 0xffffffff;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+	cmd.val64 = 2;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	/* Read them back to verify */
+	cmd.op = IOMMU_OPTION_OP_GET;
+	cmd.object_id = 0;
+	cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(cmd.val64, 0xffffffff);
+	cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(cmd.val64, 2);
+}
+
 FIXTURE(iommufd_ioas)
 {
 	int fd;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 64b1f8e1b0cf..6d7b1417ce45 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -615,6 +615,10 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 /* device.c */
 TEST_FAIL_NTH(basic_fail_nth, device)
 {
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_OPTION_OP_SET,
+	};
 	struct iommu_hwpt_selftest data = {
 		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
 	};
@@ -634,6 +638,16 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	if (self->fd == -1)
 		return -1;
 
+	cmd.option_id = IOMMU_OPTION_SW_MSI_START;
+	cmd.val64 = 0x8000000;
+	if (ioctl(self->fd, IOMMU_OPTION, &cmd))
+		return -1;
+
+	cmd.option_id = IOMMU_OPTION_SW_MSI_SIZE;
+	cmd.val64 = 2;
+	if (ioctl(self->fd, IOMMU_OPTION, &cmd))
+		return -1;
+
 	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
 		return -1;
 
-- 
2.43.0



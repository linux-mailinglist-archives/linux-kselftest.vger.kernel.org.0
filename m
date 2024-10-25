Return-Path: <linux-kselftest+bounces-20744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1159B1396
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFFA1F22D64
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FBB21E731;
	Fri, 25 Oct 2024 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z+PmJxHi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE6321E60C;
	Fri, 25 Oct 2024 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900277; cv=fail; b=H7N56qCe7TK4iTrFDib6APHQn29UufDwcRaEtZjsPiLvr4p4RqTggYbtz6LqmIpfR7bq/KGH/ucU6Qrwon3hu++5mZRuGn35iHgOw7jNuq8N8zlyaXfWS4hIrKJmwD8T0+LW3rveOhFgu2RsxSXE/fUgOxddNlnoC1izR8NUNW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900277; c=relaxed/simple;
	bh=u6GzZ00+wb1AF3kZwqJmIZq0wpmLr6dnV8r+jXcEgrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+suWbSreYomENDDPYS9MjUGzeNvi6kWc8B7HNvi/zCDmnIl+E6YQPEUZpcZn5KVREaccKLp4WRaMd5I74UL2fRn7FDDrfT576l1jwuQV06qAGa+V7yE3XA3kKRsIe/dL7DeA+Wb0KUYgf1skOzoOMphWnyovCfx1/lDmLPrpno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z+PmJxHi; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFxNBWEw30hOicWe5LKHmqFjy9IfPrLxcSwLIlETZE201j1zuNdTnVnDFPAbuhrMxwK7WniOVxAjtORDQv4HEsLsnqF/sRAj6Mjcuk5M19FCIJO41HhFbnft5aTVTsSapaivi2N+jM/4kbfY4ReQ5ukNPYhffBhuH/SMU/YHeO/Up6KAfyRmID3oAMjcSuNhPTnUUsNiE+qVlX949oU234XAKKneCIX2zw1sOdRPF6AXfvz2CtDvqd+mDb7qf+TiLOIWjiTpHxQzht8vyhhJj7NUlNAUnaEkS3yzMG7aDmx+IfBPyHKzJ+AUTkopPU/4FEzBgF35MYej/jqFNDNUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6dG17MunVwVcYiNUHxHYS/ZiQYCsjJGFDI3pRFAE9s=;
 b=TTApuXO/s5a4vq4Sr8BAZGxeiYYUGpQRmR9zPr8ODGRzdjMddvj1t06cKGspREJ7D/ozE0qDXIWEjkz77lMEkC+ujJs3LYYZ8MRVPHGwbCVulrSIb/wL+5mVmWfxYPWTTMYnRObr9c1dRdh0boyZzKgDfY89OIw7AnoHkiavu9CZKm3T+cbcB6c1xYXvI3PNYV9EoVJ6u4wv3pLeq8OWzjNPTimsqyPceGqRdjftWytixm2EZchyiKn/Yx+6X2OjisOh5fi6okOseq1UJ+3Thn9Vxfi7//VDK6QIG5u6gs5EtWgkRp1oD0pBPbH43gnV5WhwixN3ygFyjWzSLZBWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6dG17MunVwVcYiNUHxHYS/ZiQYCsjJGFDI3pRFAE9s=;
 b=Z+PmJxHi9/J+ponkQWwW/VB45hmpxDEWwnKDd4pyD6mbVR6LbSUDk1bMmUHYulDLJLxh30uljiVqs31bNT9SQre7XGMVQRy52chG4o+y4MRF7+jwIzEkFaAI3qYSt/Ge6mXURfrOutjxrdLbCIUCcv+B35sZg6waz3Po40vtFVNsjkwSl0KkOxaKY2s5bTaJ8JGPjhtk5BjpintL3NXKc9QdBvkSSVE0GIIheh2fsCNzC1z7xFSV2FPtl0QS0qc9bEPieJe2ZIVNGwiyxuqa2mYS5ZZwFoMeNt376BsMD8ZaPYYyLIDB70TFAN801Pc1dN9Vp67N6trooHhGEzapkA==
Received: from BYAPR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:e0::46)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 23:51:09 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::a5) by BYAPR05CA0105.outlook.office365.com
 (2603:10b6:a03:e0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Fri, 25 Oct 2024 23:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:51:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:51:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:51:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:51:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v5 10/13] iommufd/selftest: Add vIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
Date: Fri, 25 Oct 2024 16:50:39 -0700
Message-ID: <35452ef0c1bcc9e0ed5217c89c9a72c1f7a17360.1729897278.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 7becad32-3c21-454a-ce6b-08dcf54fe5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QuNa/mGfQChsSk9MusmIdVCOR4Wpr+hFlb9tNw6eO+5uuQj6oxwwjq+jo4kk?=
 =?us-ascii?Q?KysXCRuuS4Z9ulg+lI+rU2jD9kQC9xs6KMWHzWqKQYCuzJBrVpVe7/JWQHWp?=
 =?us-ascii?Q?j9olIgibFzJJlrgqGyTRK3cNlUHN1prk+RHgTkQZ5wJKP+81eSMq0ezAYH8w?=
 =?us-ascii?Q?fmI3rRJ5lodKtOZXZb7/yE2IqVUIzbKiJceR1noO9LO/p2fvpX1otsLgofOn?=
 =?us-ascii?Q?Chry3WVKSTGO9rFTxZbMY3iqpUFL6VQ8972oKkFVC+ffixWOQk4bH/Hm/U5I?=
 =?us-ascii?Q?I3oxeqRomk69Y4/ipU08krLfdSD/1atKBbjLXV5ZaTcgcDmaobaCinUpRZwN?=
 =?us-ascii?Q?srN8AWOoha07NJZoSkXaTs5X5m1yXYdXiMuYRjW5un04RbV90PYGEVJW/9fH?=
 =?us-ascii?Q?dRTDwV6WSvjHmGzLKliJTmZziIKjYXBULHqEv73LGwm9nV3TPyWxvuIwvKjf?=
 =?us-ascii?Q?lBpMpMf4PRJuIs91U+6oecGld6PSP72AJudzYmfDNxAJQbjLd3goOz7i1G4V?=
 =?us-ascii?Q?Fen1DoLxA8zdZxEgQog5mj9ioycLuwmnJMz4gl20IE1XkTG9x3W/azjMy9M1?=
 =?us-ascii?Q?QBvj65Yw/76YrabCTOkynbFXbjeNh1lQlvtYtmUmETaSnc3PVU/H0rq00+zq?=
 =?us-ascii?Q?tLgOXlmINjmmObqROsLtM47u42gxJztvKLlYNOs21OqdiX/hiY2975mb7LrX?=
 =?us-ascii?Q?wNR33N/JXDT0maCzQ0p9BFs2WlZuwg5ceFrx7jspb2b7bpwp0WfHQAaZ51Ri?=
 =?us-ascii?Q?yyJSsSLMQCrvzWsLeyJIA3YHTL0ZtIEqJSTs0SvyGRpP219AngYHyOB9J/uY?=
 =?us-ascii?Q?qhMkjvMKhtkGfMYl/NeOeOcumWT2cLa2guSThvHJWSYTDCFFOHpqi9tI8wH9?=
 =?us-ascii?Q?NBM9rdYbNv9RzAf5QkKXpGZloxFB0OQoow4N61SadgRaFowz6jotSL+9IeDE?=
 =?us-ascii?Q?Bo0SgyzWEbEuiW1wH06Cer7XGic+v1rZAiwdRsmaUYDDtMc24gyUqNgguMaz?=
 =?us-ascii?Q?Z6MwU3xzQzxrdVmVBwYpXfh+1inlxcAC64VscvcJsimKRMQKj7fyKDnvg7lG?=
 =?us-ascii?Q?N0wUD7c6Wj7TJ+P6xluLj48lUu9RO08w1Qn0h4JJ8070u8JsG4st8b4TOnW2?=
 =?us-ascii?Q?RtFlqrwD1KTJGVImFyKLDYQJgeyNvIiss5RaWWDb3MAzbB7I6R9PyC/z1g0O?=
 =?us-ascii?Q?ArKsC0kA3GeoLmOzeDTHI/P93XDojCAxuNdcWWHABoQbsbJHZ4+utXYOAo+z?=
 =?us-ascii?Q?H6dYareLbY7CsldiaCS9CfKDKUjrIKEBFzaim63i0i8WXmSXTGszdCnTF6CK?=
 =?us-ascii?Q?YuObHj1U5D74mp3hl/2LECLQ79gt7QQcKDd56fnfZwp7X5cyJN8SD7lRpSg1?=
 =?us-ascii?Q?w09PojrZlOjWDsqbLb076D891l9rGqyK5s82+3CqExohxJeS9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:51:08.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7becad32-3c21-454a-ce6b-08dcf54fe5fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276

Add a viommu_cache test function to cover vIOMMU invalidations using the
updated IOMMU_HWPT_INVALIDATE ioctl, which now allows passing in a vIOMMU
via its hwpt_id field.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h |  32 ++++
 tools/testing/selftests/iommu/iommufd.c       | 173 ++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 3ae6cb5eed7d..aa458c80ad30 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -289,6 +289,38 @@ static int _test_cmd_hwpt_invalidate(int fd, __u32 hwpt_id, void *reqs,
 					     data_type, lreq, nreqs));   \
 	})
 
+static int _test_cmd_viommu_invalidate(int fd, __u32 viommu_id, void *reqs,
+				       uint32_t data_type, uint32_t lreq,
+				       uint32_t *nreqs)
+{
+	struct iommu_hwpt_invalidate cmd = {
+		.size = sizeof(cmd),
+		.hwpt_id = viommu_id,
+		.data_type = data_type,
+		.data_uptr = (uint64_t)reqs,
+		.entry_len = lreq,
+		.entry_num = *nreqs,
+	};
+	int rc = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cmd);
+	*nreqs = cmd.entry_num;
+	return rc;
+}
+
+#define test_cmd_viommu_invalidate(viommu, reqs, lreq, nreqs)                  \
+	({                                                                     \
+		ASSERT_EQ(0,                                                   \
+			  _test_cmd_viommu_invalidate(self->fd, viommu, reqs,  \
+					IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST, \
+					lreq, nreqs));                         \
+	})
+#define test_err_viommu_invalidate(_errno, viommu_id, reqs, data_type, lreq,   \
+				 nreqs)                                        \
+	({                                                                     \
+		EXPECT_ERRNO(_errno, _test_cmd_viommu_invalidate(              \
+					     self->fd, viommu_id, reqs,        \
+					     data_type, lreq, nreqs));         \
+	})
+
 static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
 					 unsigned int ioas_id)
 {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index ff0181e5db48..9a7d4b9c44f6 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2498,4 +2498,177 @@ TEST_F(iommufd_viommu, vdevice_alloc)
 	}
 }
 
+TEST_F(iommufd_viommu, vdevice_cache)
+{
+	struct iommu_viommu_invalidate_selftest inv_reqs[2] = {};
+	uint32_t viommu_id = self->viommu_id;
+	uint32_t dev_id = self->device_id;
+	uint32_t vdev_id = 0;
+	uint32_t num_inv;
+
+	if (dev_id) {
+		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+
+		test_cmd_dev_check_cache_all(dev_id,
+					     IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+		/* Check data_type by passing zero-length array */
+		num_inv = 0;
+		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: Invalid data_type */
+		num_inv = 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: structure size sanity */
+		num_inv = 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs) + 1, &num_inv);
+		assert(!num_inv);
+
+		num_inv = 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   1, &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid flag is passed */
+		num_inv = 1;
+		inv_reqs[0].flags = 0xffffffff;
+		inv_reqs[0].vdev_id = 0x99;
+		test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid data_uptr when array is not empty */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		test_err_viommu_invalidate(EINVAL, viommu_id, NULL,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid entry_len when array is not empty */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   0, &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid cache_id */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid vdev_id */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x9;
+		inv_reqs[0].cache_id = 0;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/*
+		 * Invalidate the 1st cache entry but fail the 2nd request
+		 * due to invalid flags configuration in the 2nd request.
+		 */
+		num_inv = 2;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = 0;
+		inv_reqs[1].flags = 0xffffffff;
+		inv_reqs[1].vdev_id = 0x99;
+		inv_reqs[1].cache_id = 1;
+		test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_dev_check_cache(dev_id, 0, 0);
+		test_cmd_dev_check_cache(dev_id, 1,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 2,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 3,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+		/*
+		 * Invalidate the 1st cache entry but fail the 2nd request
+		 * due to invalid cache_id configuration in the 2nd request.
+		 */
+		num_inv = 2;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = 0;
+		inv_reqs[1].flags = 0;
+		inv_reqs[1].vdev_id = 0x99;
+		inv_reqs[1].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
+		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_dev_check_cache(dev_id, 0, 0);
+		test_cmd_dev_check_cache(dev_id, 1,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 2,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 3,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+		/* Invalidate the 2nd cache entry and verify */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = 1;
+		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_dev_check_cache(dev_id, 0, 0);
+		test_cmd_dev_check_cache(dev_id, 1, 0);
+		test_cmd_dev_check_cache(dev_id, 2,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+		test_cmd_dev_check_cache(dev_id, 3,
+					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+		/* Invalidate the 3rd and 4th cache entries and verify */
+		num_inv = 2;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].cache_id = 2;
+		inv_reqs[1].flags = 0;
+		inv_reqs[1].vdev_id = 0x99;
+		inv_reqs[1].cache_id = 3;
+		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 2);
+		test_cmd_dev_check_cache_all(dev_id, 0);
+
+		/* Invalidate all cache entries for nested_dev_id[1] and verify */
+		num_inv = 1;
+		inv_reqs[0].vdev_id = 0x99;
+		inv_reqs[0].flags = IOMMU_TEST_INVALIDATE_FLAG_ALL;
+		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+					   sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_dev_check_cache_all(dev_id, 0);
+		test_ioctl_destroy(vdev_id);
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0



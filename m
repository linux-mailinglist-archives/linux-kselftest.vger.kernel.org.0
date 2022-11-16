Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9B262CC1A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiKPVDP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239274AbiKPVCO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:14 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2BDDC8;
        Wed, 16 Nov 2022 13:01:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZia5QAks8r0FOdOUuNSS6ne/jgFvSrMCN7AuhZJea+0Rd+orRVGHu0CcoaB/kc/MYWxbyQpMLOu7cfobCaI7PQN9bMyyNwN9o1Xfwo9gU6La/8zZrwOAIIpPMiAxGJDmWwTSgnU3jCO0Q6QR/f3VfdEhjXx56OsL0rFAgvmtJOgoOOC75CYRbvdArc8RVaYhgADa0lNPUFiKAcm2GN4gRo/c9YRqNKt8RhFI8K5KZyvEIP7edmHTHyUCnP5ZWJRNnS7B3Ap2ZkKyk0vudt6sZUb4d/uIPiM3kE5iOoOWLmJKKeAXHSgL7E9zWMsmTg+O9wshiRDuU8q3FfTnT4ypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhc9Uuy9Jiof83W1ovp40DEfYTWAgMd/2d1Nc3u+gRY=;
 b=T+9UWQzAjaQymKNtYAFFdwxy6sBgeaNup6M1SpQBm37MG8nEHnZBPMcUqcjd0Zo5UD8GIqyonl9f4CT6VE9qR4iw3oOwgykT5GTW7YsIEmgGSD/g5SsezvKptPKYUMMF/+WtidDpvl2NOl8MmkkwbwTkmA7rcMTzLU6+Xrdje7Q35MbXaxsf3NpUmUqMFVW/dbSg2bGB3YQI7moZCtkDMzdxnAVqr0m+brpT5H1kMhocvv0SEleXwUTvhsx2Oslfgx36cuIEcYC9TZf9781jKGQYX2JG3x7N+Ij2mixqvxCh2LLlirq55ghG/J2IPGrVFW/zNLCMGtluSp1jATDF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhc9Uuy9Jiof83W1ovp40DEfYTWAgMd/2d1Nc3u+gRY=;
 b=Pz+ZuZqo76n9Or/kf+vtu5cbbVXH/jYzYFmSzI7pVc6v4knKxp4hsfDmtPgW4Y7I5Z0JQai7Sqcw2F4+YXTg0V40oYFsP/HqNV+6Jd0de1GR1czdOJ0Xk12Lv0eAFzVezcgoREcLsuDYueTsfdazroGFzbw3r+vHhDYj/nyohBLV2rZdld7vpt0mzO0JLAf0j6rsU1M6dl+OYv17EzoKJ3W3ZPCHDMtvjKgwME1AX9txfkE4/XPD43u36OyFD/hjT3nFvKR5C+X18SZgjtR9UENGzi5EccMTKilYwRMDv8zoSsyU4V+br+o9z80kJKH/YJgIyqi8syLHI3bUbOyupw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:01:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:01:05 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v5 16/19] iommufd: Add kernel support for testing iommufd
Date:   Wed, 16 Nov 2022 17:00:52 -0400
Message-Id: <16-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0018.namprd19.prod.outlook.com
 (2603:10b6:208:178::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 91450d5f-67a7-470c-fe2a-08dac815aa1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGhJ0D8Z5T6k+IkaTIgOR0s1PHPfNKtSQUrPJtb6n5AC9aAGw1qUuJat6Y4EYJS2IuiQdLDU6gJ7DKNSgR7YKOXd6YwHmM+xfPKd37ZXpQvvmvd8sygPcdksq0+rR1873RgXMCXRQbMmNPP0eF0378Mfc5/ElzOVSoO+BMkdPGNxbjVvxw7wxE8D3OCXNBptHrp3nQWV/XlO3sStxKULYDar9NdsSnxqw49EvxWhU44j/yUyFGfyj0oBwkbxJP0sjQ6hJBmoHP4+TxCwIiZQAum0bv6zroyN3ODEYfPNN7xGSXh+l6QvEvq7sd+ySH51/MFgOzVaYnsVqgEoZ6tI9yNI1sDWPaGlJYZTZfxOeq+14IrXkgz7r6wHFMtARSYyUU4EiCcfKE4qKhylcOTrTLYyRPjyzUFcX8ch35pcPTOY2X6y26U/E0JvP4lhGn3ujdjyJnQEm9DL8v8zasMm7W1hvBUBsNbAU0fkLbCLJ6DagAXz67o/Zx/Q3jl0iw8GeeKNET0Y/PoMCsaUm+h5T2K97J+G9PYgpS6wMr4V0forhwxqDrMrVmlywTWTLsimeEGiNKrnbJgUHAptZzPL6jXCdv8aSQzALmmLIrJ4t42WDWWerwBrmkOLjyYd+kEJoXC1uW36Ly102JLFM6jxyy6YXqz6yjSw0gOttOSOBmt9Ri9yFjvgo7mbeKtrSKTNpZR/6rUsX0mYAgD+lhl7N8g9FVKw3R4AWAfoZqBzI88EaQToxWsS3LzM6E7TV8o7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(36756003)(41300700001)(4326008)(8676002)(66556008)(6486002)(186003)(66476007)(86362001)(66946007)(2616005)(478600001)(26005)(316002)(6666004)(110136005)(54906003)(6506007)(921005)(6512007)(83380400001)(2906002)(30864003)(7406005)(7416002)(8936002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8caGY+rtbczEKbMhqJ4aRTrfRnAsZg8WRqfjP/yEOit785fcUnBv1T0raWSX?=
 =?us-ascii?Q?lgQz/bPYvJ6RKzFdbgEkD3YJvVXEIZ+YavKrUO9QDI8TmDXMY5M6e79JPXZC?=
 =?us-ascii?Q?+SjOHJx4UOY7b4L5+I0lzxWQURlSw7YHilL6Vp12Ff/vec7XKvwODSd4n6nO?=
 =?us-ascii?Q?RlYWKBpNxe84b4goih3ytjHXW9Gj3pmqhVezV6W4a7Y4nO62Xc8qHTNF/gqs?=
 =?us-ascii?Q?ywhha1TgxaLGqvy5fvOmVc9ZS1+gfU34nGxaQBX0BHiJYGZQtx64mRbA191Q?=
 =?us-ascii?Q?fz6hq5Ay+Rve3RBS44k40fiUnDAd9GkB5WTRACI7ei52u8gxvPFewZa7cE0y?=
 =?us-ascii?Q?7m+5OvDfV2U6Oxrnbso6UNZeyV3Ur8AprBV7C9h0OZS7PsrxeuVsLC07oFfL?=
 =?us-ascii?Q?nA6inGZv0inNUMadJuOel+EWtl/2mQdPgDhR43lIuUwnki1js5zIlUwm/kxC?=
 =?us-ascii?Q?cZwbxF/l23CDS8tLdVJ0S7O5IEy/1S+all9TIibRspL1JGnapOTgbsXW825U?=
 =?us-ascii?Q?nVtuTBB4Rw/gU6qzEwyJqg8unWU6RcWtiWCnyApQZMgKIvJqcUaFRG6ncOyp?=
 =?us-ascii?Q?MG2YI3Xzz2vVa/4PcozfQXQdwp3a/Qm6c1UMrWYfl8fcWPNo1vK33CEufl2F?=
 =?us-ascii?Q?ZWPZf1jXC02YZP2c/jW28cMrAKg9VA0ZYK7l9qlzozY8u7LIU1hmtGNa3PhQ?=
 =?us-ascii?Q?BOu6Kc8LgbHKmrREXlVw1ePGz+PvC0L8O430oN3ATjc0mZ/gakPMecFKwsma?=
 =?us-ascii?Q?v9Oumv4OLJU7egGDOxzgmuyZcm712/Vr4fvUonOqelYqw/mLKYwhqhssiTiS?=
 =?us-ascii?Q?DrcHeBZN8h2O8i2YPNyOAgqB0ugR6GFoeBetoePd4pDXC9LzPagDNmHg9D94?=
 =?us-ascii?Q?spWOXrLVwMWZP0Cy2uBVReW2sL6Em2+OXJOZzzxribrUcQO8BCMJ7/j91SRH?=
 =?us-ascii?Q?h5o6CwKm4MZ38ls5whmM165LAYe3FjRfBPHD/gm68IuILq2rqEdafHrlGUAt?=
 =?us-ascii?Q?179hLfriFmV2HD53jZhAAP9v+AhEHg3XgNu8/bDfeCXMrzDN4qTXwNIvkmzm?=
 =?us-ascii?Q?uYcWNcaJGCWedcYCkpLcjPuiIWH771Cm/9i9OKh/4Gg8SIygBcnV4hdvPtSJ?=
 =?us-ascii?Q?DfG0nQh3fW/B9IBUHS5w10yxkZgvsRiUVun+6R69um+5E23KzRRzbkJ2qNZw?=
 =?us-ascii?Q?KUUoAwKvKgjF9EnNNQr3unhvkpMyzJtsBLODHDvhc0f3ZZrs1R9KkLJqZFVX?=
 =?us-ascii?Q?Z1e3h2JIw7Wf2zGMDoH4dlzh5Pi8JEye3Y/3sy/t8taDt3B/KubMa5FVAjyy?=
 =?us-ascii?Q?R3oaAUF8HgpmVR0767j6iUBjZdnzWLI4XER/g2PWFzRUGaas2j5JG4uaNa87?=
 =?us-ascii?Q?3TEEQ2fgWka5+RvkEfAYbXvNrZJAp0/XgrrZlBDuINNNhK64IdkMIczqV8kx?=
 =?us-ascii?Q?YjnVn1d0yNHqBVoIlLOIpYMgOuSidAWhJsqOU0frE48N3pLgwcU+u+yi8Se7?=
 =?us-ascii?Q?10IO4p3IazdIBO1dzar1D6tZjmqTunJsQ/bO3J4M24pR7qOeJOfiA2e2sVwB?=
 =?us-ascii?Q?6OUn9FuFb54dFcJ81xA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91450d5f-67a7-470c-fe2a-08dac815aa1f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:01:00.4209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCg+hurxEEEx6EEuAFPYAG3oKg30iZtAlAecFofPHrA2DDy2vQqkPKY2kjou+m3A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Provide a mock kernel module for the iommu_domain that allows it to run
without any HW and the mocking provides a way to directly validate that
the PFNs loaded into the iommu_domain are correct. This exposes the access
kAPI toward userspace to allow userspace to explore the functionality of
pages.c and io_pagetable.c

The mock also simulates the rare case of PAGE_SIZE > iommu page size as
the mock will operate at a 2K iommu page size. This allows exercising all
of the calculations to support this mismatch.

This is also intended to support syzkaller exploring the same space.

However, it is an unusually invasive config option to enable all of
this. The config option should not be enabled in a production kernel.

Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/Kconfig           |  11 +
 drivers/iommu/iommufd/Makefile          |   2 +
 drivers/iommu/iommufd/device.c          |  38 ++
 drivers/iommu/iommufd/ioas.c            |   3 +
 drivers/iommu/iommufd/iommufd_private.h |  35 +
 drivers/iommu/iommufd/iommufd_test.h    |  93 +++
 drivers/iommu/iommufd/main.c            |  14 +
 drivers/iommu/iommufd/pages.c           |   8 +
 drivers/iommu/iommufd/selftest.c        | 853 ++++++++++++++++++++++++
 include/linux/iommufd.h                 |   3 +
 10 files changed, 1060 insertions(+)
 create mode 100644 drivers/iommu/iommufd/iommufd_test.h
 create mode 100644 drivers/iommu/iommufd/selftest.c

diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 6d65d0f06f169f..399a2edeaef6de 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -10,3 +10,14 @@ config IOMMUFD
 	  it relates to managing IO page tables that point at user space memory.
 
 	  If you don't know what to do here, say N.
+
+if IOMMUFD
+config IOMMUFD_TEST
+	bool "IOMMU Userspace API Test support"
+	depends on RUNTIME_TESTING_MENU
+	depends on FAULT_INJECTION
+	default n
+	help
+	  This is dangerous, do not enable unless running
+	  tools/testing/selftests/iommu
+endif
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 2fdff04000b326..8aeba81800c512 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -8,4 +8,6 @@ iommufd-y := \
 	pages.o \
 	vfio_compat.o
 
+iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
+
 obj-$(CONFIG_IOMMUFD) += iommufd.o
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 522469ae7b5770..a9105237ec4131 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -729,3 +729,41 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, IOMMUFD);
+
+#ifdef CONFIG_IOMMUFD_TEST
+/*
+ * Creating a real iommufd_device is too hard, bypass creating a iommufd_device
+ * and go directly to attaching a domain.
+ */
+struct iommufd_hw_pagetable *
+iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
+			       struct iommufd_ioas *ioas,
+			       struct device *mock_dev)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	int rc;
+
+	hwpt = iommufd_hw_pagetable_alloc(ictx, ioas, mock_dev);
+	if (IS_ERR(hwpt))
+		return hwpt;
+
+	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
+	if (rc)
+		goto out_hwpt;
+
+	refcount_inc(&hwpt->obj.users);
+	iommufd_object_finalize(ictx, &hwpt->obj);
+	return hwpt;
+
+out_hwpt:
+	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
+	return ERR_PTR(rc);
+}
+
+void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
+				    struct iommufd_hw_pagetable *hwpt)
+{
+	iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
+	refcount_dec(&hwpt->obj.users);
+}
+#endif
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 64e6d0f73e39aa..9e5b8c16bc9c45 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -237,6 +237,9 @@ int iommufd_ioas_copy(struct iommufd_ucmd *ucmd)
 	unsigned long iova;
 	int rc;
 
+	iommufd_test_syz_conv_iova_id(ucmd, cmd->src_ioas_id, &cmd->src_iova,
+				      &cmd->flags);
+
 	if ((cmd->flags &
 	     ~(IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_WRITEABLE |
 	       IOMMU_IOAS_MAP_READABLE)))
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index f1d462f40ac7b7..84029a0703fa01 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -113,6 +113,9 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_HW_PAGETABLE,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
+#ifdef CONFIG_IOMMUFD_TEST
+	IOMMUFD_OBJ_SELFTEST,
+#endif
 };
 
 /* Base struct for all objects with a userspace ID handle. */
@@ -269,4 +272,36 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			struct iommufd_access *access);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+#ifdef CONFIG_IOMMUFD_TEST
+struct iommufd_hw_pagetable *
+iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
+			       struct iommufd_ioas *ioas,
+			       struct device *mock_dev);
+void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
+				    struct iommufd_hw_pagetable *hwpt);
+int iommufd_test(struct iommufd_ucmd *ucmd);
+void iommufd_selftest_destroy(struct iommufd_object *obj);
+extern size_t iommufd_test_memory_limit;
+void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
+				   unsigned int ioas_id, u64 *iova, u32 *flags);
+bool iommufd_should_fail(void);
+void __init iommufd_test_init(void);
+void iommufd_test_exit(void);
+#else
+static inline void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
+						 unsigned int ioas_id,
+						 u64 *iova, u32 *flags)
+{
+}
+static inline bool iommufd_should_fail(void)
+{
+	return false;
+}
+static inline void __init iommufd_test_init(void)
+{
+}
+static inline void iommufd_test_exit(void)
+{
+}
+#endif
 #endif
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
new file mode 100644
index 00000000000000..1d96a8f466fd29
--- /dev/null
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES.
+ */
+#ifndef _UAPI_IOMMUFD_TEST_H
+#define _UAPI_IOMMUFD_TEST_H
+
+#include <linux/types.h>
+#include <linux/iommufd.h>
+
+enum {
+	IOMMU_TEST_OP_ADD_RESERVED = 1,
+	IOMMU_TEST_OP_MOCK_DOMAIN,
+	IOMMU_TEST_OP_MD_CHECK_MAP,
+	IOMMU_TEST_OP_MD_CHECK_REFS,
+	IOMMU_TEST_OP_CREATE_ACCESS,
+	IOMMU_TEST_OP_DESTROY_ACCESS_PAGES,
+	IOMMU_TEST_OP_ACCESS_PAGES,
+	IOMMU_TEST_OP_ACCESS_RW,
+	IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
+};
+
+enum {
+	MOCK_APERTURE_START = 1UL << 24,
+	MOCK_APERTURE_LAST = (1UL << 31) - 1,
+};
+
+enum {
+	MOCK_FLAGS_ACCESS_WRITE = 1 << 0,
+	MOCK_FLAGS_ACCESS_SYZ = 1 << 16,
+};
+
+enum {
+	MOCK_ACCESS_RW_WRITE = 1 << 0,
+	MOCK_ACCESS_RW_SLOW_PATH = 1 << 2,
+};
+
+enum {
+	MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES = 1 << 0,
+};
+
+struct iommu_test_cmd {
+	__u32 size;
+	__u32 op;
+	__u32 id;
+	__u32 __reserved;
+	union {
+		struct {
+			__aligned_u64 start;
+			__aligned_u64 length;
+		} add_reserved;
+		struct {
+			__u32 out_device_id;
+			__u32 out_hwpt_id;
+		} mock_domain;
+		struct {
+			__aligned_u64 iova;
+			__aligned_u64 length;
+			__aligned_u64 uptr;
+		} check_map;
+		struct {
+			__aligned_u64 length;
+			__aligned_u64 uptr;
+			__u32 refs;
+		} check_refs;
+		struct {
+			__u32 out_access_fd;
+			__u32 flags;
+		} create_access;
+		struct {
+			__u32 access_pages_id;
+		} destroy_access_pages;
+		struct {
+			__u32 flags;
+			__u32 out_access_pages_id;
+			__aligned_u64 iova;
+			__aligned_u64 length;
+			__aligned_u64 uptr;
+		} access_pages;
+		struct {
+			__aligned_u64 iova;
+			__aligned_u64 length;
+			__aligned_u64 uptr;
+			__u32 flags;
+		} access_rw;
+		struct {
+			__u32 limit;
+		} memory_limit;
+	};
+	__u32 last;
+};
+#define IOMMU_TEST_CMD _IO(IOMMUFD_TYPE, IOMMUFD_CMD_BASE + 32)
+
+#endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index f76b2c8dcde8e5..7de0f95f2ee68a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -19,6 +19,7 @@
 #include <linux/iommufd.h>
 
 #include "iommufd_private.h"
+#include "iommufd_test.h"
 
 struct iommufd_object_ops {
 	void (*destroy)(struct iommufd_object *obj);
@@ -234,6 +235,9 @@ union ucmd_buffer {
 	struct iommu_ioas_iova_ranges iova_ranges;
 	struct iommu_ioas_map map;
 	struct iommu_ioas_unmap unmap;
+#ifdef CONFIG_IOMMUFD_TEST
+	struct iommu_test_cmd test;
+#endif
 };
 
 struct iommufd_ioctl_op {
@@ -270,6 +274,9 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+#ifdef CONFIG_IOMMUFD_TEST
+	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
+#endif
 };
 
 static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
@@ -370,6 +377,11 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_HW_PAGETABLE] = {
 		.destroy = iommufd_hw_pagetable_destroy,
 	},
+#ifdef CONFIG_IOMMUFD_TEST
+	[IOMMUFD_OBJ_SELFTEST] = {
+		.destroy = iommufd_selftest_destroy,
+	},
+#endif
 };
 
 static struct miscdevice iommu_misc_dev = {
@@ -387,11 +399,13 @@ static int __init iommufd_init(void)
 	ret = misc_register(&iommu_misc_dev);
 	if (ret)
 		return ret;
+	iommufd_test_init();
 	return 0;
 }
 
 static void __exit iommufd_exit(void)
 {
+	iommufd_test_exit();
 	misc_deregister(&iommu_misc_dev);
 }
 
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index bafeee9d73e8ae..640331b8a07919 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -56,7 +56,11 @@
 #include "io_pagetable.h"
 #include "double_span.h"
 
+#ifndef CONFIG_IOMMUFD_TEST
 #define TEMP_MEMORY_LIMIT 65536
+#else
+#define TEMP_MEMORY_LIMIT iommufd_test_memory_limit
+#endif
 #define BATCH_BACKUP_SIZE 32
 
 /*
@@ -1756,6 +1760,10 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 	bool change_mm = current->mm != pages->source_mm;
 	int rc = 0;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    (flags & __IOMMUFD_ACCESS_RW_SLOW_PATH))
+		change_mm = true;
+
 	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
 		return -EPERM;
 
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
new file mode 100644
index 00000000000000..cfb5fe9a5e0ee8
--- /dev/null
+++ b/drivers/iommu/iommufd/selftest.c
@@ -0,0 +1,853 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ * Kernel side components to support tools/testing/selftests/iommu
+ */
+#include <linux/slab.h>
+#include <linux/iommu.h>
+#include <linux/xarray.h>
+#include <linux/file.h>
+#include <linux/anon_inodes.h>
+#include <linux/fault-inject.h>
+#include <uapi/linux/iommufd.h>
+
+#include "io_pagetable.h"
+#include "iommufd_private.h"
+#include "iommufd_test.h"
+
+static DECLARE_FAULT_ATTR(fail_iommufd);
+static struct dentry *dbgfs_root;
+
+size_t iommufd_test_memory_limit = 65536;
+
+enum {
+	MOCK_IO_PAGE_SIZE = PAGE_SIZE / 2,
+
+	/*
+	 * Like a real page table alignment requires the low bits of the address
+	 * to be zero. xarray also requires the high bit to be zero, so we store
+	 * the pfns shifted. The upper bits are used for metadata.
+	 */
+	MOCK_PFN_MASK = ULONG_MAX / MOCK_IO_PAGE_SIZE,
+
+	_MOCK_PFN_START = MOCK_PFN_MASK + 1,
+	MOCK_PFN_START_IOVA = _MOCK_PFN_START,
+	MOCK_PFN_LAST_IOVA = _MOCK_PFN_START,
+};
+
+/*
+ * Syzkaller has trouble randomizing the correct iova to use since it is linked
+ * to the map ioctl's output, and it has no ide about that. So, simplify things.
+ * In syzkaller mode the 64 bit IOVA is converted into an nth area and offset
+ * value. This has a much smaller randomization space and syzkaller can hit it.
+ */
+static unsigned long iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
+						u64 *iova)
+{
+	struct syz_layout {
+		__u32 nth_area;
+		__u32 offset;
+	};
+	struct syz_layout *syz = (void *)iova;
+	unsigned int nth = syz->nth_area;
+	struct iopt_area *area;
+
+	down_read(&iopt->iova_rwsem);
+	for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
+	     area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
+		if (nth == 0) {
+			up_read(&iopt->iova_rwsem);
+			return iopt_area_iova(area) + syz->offset;
+		}
+		nth--;
+	}
+	up_read(&iopt->iova_rwsem);
+
+	return 0;
+}
+
+void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
+				   unsigned int ioas_id, u64 *iova, u32 *flags)
+{
+	struct iommufd_ioas *ioas;
+
+	if (!(*flags & MOCK_FLAGS_ACCESS_SYZ))
+		return;
+	*flags &= ~(u32)MOCK_FLAGS_ACCESS_SYZ;
+
+	ioas = iommufd_get_ioas(ucmd, ioas_id);
+	if (IS_ERR(ioas))
+		return;
+	*iova = iommufd_test_syz_conv_iova(&ioas->iopt, iova);
+	iommufd_put_object(&ioas->obj);
+}
+
+struct mock_iommu_domain {
+	struct iommu_domain domain;
+	struct xarray pfns;
+};
+
+enum selftest_obj_type {
+	TYPE_IDEV,
+};
+
+struct selftest_obj {
+	struct iommufd_object obj;
+	enum selftest_obj_type type;
+
+	union {
+		struct {
+			struct iommufd_hw_pagetable *hwpt;
+			struct iommufd_ctx *ictx;
+			struct device mock_dev;
+		} idev;
+	};
+};
+
+static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
+{
+	struct mock_iommu_domain *mock;
+
+	if (WARN_ON(iommu_domain_type != IOMMU_DOMAIN_UNMANAGED))
+		return NULL;
+
+	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
+	if (!mock)
+		return NULL;
+	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
+	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
+	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
+	xa_init(&mock->pfns);
+	return &mock->domain;
+}
+
+static void mock_domain_free(struct iommu_domain *domain)
+{
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+
+	WARN_ON(!xa_empty(&mock->pfns));
+	kfree(mock);
+}
+
+static int mock_domain_map_pages(struct iommu_domain *domain,
+				 unsigned long iova, phys_addr_t paddr,
+				 size_t pgsize, size_t pgcount, int prot,
+				 gfp_t gfp, size_t *mapped)
+{
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+	unsigned long flags = MOCK_PFN_START_IOVA;
+	unsigned long start_iova = iova;
+
+	/*
+	 * xarray does not reliably work with fault injection because it does a
+	 * retry allocation, so put our own failure point.
+	 */
+	if (iommufd_should_fail())
+		return -ENOENT;
+
+	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
+	WARN_ON(pgsize % MOCK_IO_PAGE_SIZE);
+	for (; pgcount; pgcount--) {
+		size_t cur;
+
+		for (cur = 0; cur != pgsize; cur += MOCK_IO_PAGE_SIZE) {
+			void *old;
+
+			if (pgcount == 1 && cur + MOCK_IO_PAGE_SIZE == pgsize)
+				flags = MOCK_PFN_LAST_IOVA;
+			old = xa_store(&mock->pfns, iova / MOCK_IO_PAGE_SIZE,
+				       xa_mk_value((paddr / MOCK_IO_PAGE_SIZE) |
+						   flags),
+				       gfp);
+			if (xa_is_err(old)) {
+				for (; start_iova != iova;
+				     start_iova += MOCK_IO_PAGE_SIZE)
+					xa_erase(&mock->pfns,
+						 start_iova /
+							 MOCK_IO_PAGE_SIZE);
+				return xa_err(old);
+			}
+			WARN_ON(old);
+			iova += MOCK_IO_PAGE_SIZE;
+			paddr += MOCK_IO_PAGE_SIZE;
+			*mapped += MOCK_IO_PAGE_SIZE;
+			flags = 0;
+		}
+	}
+	return 0;
+}
+
+static size_t mock_domain_unmap_pages(struct iommu_domain *domain,
+				      unsigned long iova, size_t pgsize,
+				      size_t pgcount,
+				      struct iommu_iotlb_gather *iotlb_gather)
+{
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+	bool first = true;
+	size_t ret = 0;
+	void *ent;
+
+	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
+	WARN_ON(pgsize % MOCK_IO_PAGE_SIZE);
+
+	for (; pgcount; pgcount--) {
+		size_t cur;
+
+		for (cur = 0; cur != pgsize; cur += MOCK_IO_PAGE_SIZE) {
+			ent = xa_erase(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
+			WARN_ON(!ent);
+			/*
+			 * iommufd generates unmaps that must be a strict
+			 * superset of the map's performend So every starting
+			 * IOVA should have been an iova passed to map, and the
+			 *
+			 * First IOVA must be present and have been a first IOVA
+			 * passed to map_pages
+			 */
+			if (first) {
+				WARN_ON(!(xa_to_value(ent) &
+					  MOCK_PFN_START_IOVA));
+				first = false;
+			}
+			if (pgcount == 1 && cur + MOCK_IO_PAGE_SIZE == pgsize)
+				WARN_ON(!(xa_to_value(ent) &
+					  MOCK_PFN_LAST_IOVA));
+
+			iova += MOCK_IO_PAGE_SIZE;
+			ret += MOCK_IO_PAGE_SIZE;
+		}
+	}
+	return ret;
+}
+
+static phys_addr_t mock_domain_iova_to_phys(struct iommu_domain *domain,
+					    dma_addr_t iova)
+{
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+	void *ent;
+
+	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
+	ent = xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
+	WARN_ON(!ent);
+	return (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZE;
+}
+
+static const struct iommu_ops mock_ops = {
+	.owner = THIS_MODULE,
+	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
+	.domain_alloc = mock_domain_alloc,
+	.default_domain_ops =
+		&(struct iommu_domain_ops){
+			.free = mock_domain_free,
+			.map_pages = mock_domain_map_pages,
+			.unmap_pages = mock_domain_unmap_pages,
+			.iova_to_phys = mock_domain_iova_to_phys,
+		},
+};
+
+static inline struct iommufd_hw_pagetable *
+get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
+		 struct mock_iommu_domain **mock)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_object *obj;
+
+	obj = iommufd_get_object(ucmd->ictx, mockpt_id,
+				 IOMMUFD_OBJ_HW_PAGETABLE);
+	if (IS_ERR(obj))
+		return ERR_CAST(obj);
+	hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
+	if (hwpt->domain->ops != mock_ops.default_domain_ops) {
+		iommufd_put_object(&hwpt->obj);
+		return ERR_PTR(-EINVAL);
+	}
+	*mock = container_of(hwpt->domain, struct mock_iommu_domain, domain);
+	return hwpt;
+}
+
+/* Create an hw_pagetable with the mock domain so we can test the domain ops */
+static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
+				    struct iommu_test_cmd *cmd)
+{
+	static struct bus_type mock_bus = { .iommu_ops = &mock_ops };
+	struct iommufd_hw_pagetable *hwpt;
+	struct selftest_obj *sobj;
+	struct iommufd_ioas *ioas;
+	int rc;
+
+	ioas = iommufd_get_ioas(ucmd, cmd->id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	sobj = iommufd_object_alloc(ucmd->ictx, sobj, IOMMUFD_OBJ_SELFTEST);
+	if (IS_ERR(sobj)) {
+		rc = PTR_ERR(sobj);
+		goto out_ioas;
+	}
+	sobj->idev.ictx = ucmd->ictx;
+	sobj->type = TYPE_IDEV;
+	sobj->idev.mock_dev.bus = &mock_bus;
+
+	hwpt = iommufd_device_selftest_attach(ucmd->ictx, ioas,
+					      &sobj->idev.mock_dev);
+	if (IS_ERR(hwpt)) {
+		rc = PTR_ERR(hwpt);
+		goto out_sobj;
+	}
+	sobj->idev.hwpt = hwpt;
+
+	/* Userspace must destroy both of these IDs to destroy the object */
+	cmd->mock_domain.out_hwpt_id = hwpt->obj.id;
+	cmd->mock_domain.out_device_id = sobj->obj.id;
+	iommufd_object_finalize(ucmd->ictx, &sobj->obj);
+	iommufd_put_object(&ioas->obj);
+	return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_sobj:
+	iommufd_object_abort(ucmd->ictx, &sobj->obj);
+out_ioas:
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+/* Add an additional reserved IOVA to the IOAS */
+static int iommufd_test_add_reserved(struct iommufd_ucmd *ucmd,
+				     unsigned int mockpt_id,
+				     unsigned long start, size_t length)
+{
+	struct iommufd_ioas *ioas;
+	int rc;
+
+	ioas = iommufd_get_ioas(ucmd, mockpt_id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+	down_write(&ioas->iopt.iova_rwsem);
+	rc = iopt_reserve_iova(&ioas->iopt, start, start + length - 1, NULL);
+	up_write(&ioas->iopt.iova_rwsem);
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+/* Check that every pfn under each iova matches the pfn under a user VA */
+static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
+				    unsigned int mockpt_id, unsigned long iova,
+				    size_t length, void __user *uptr)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct mock_iommu_domain *mock;
+	int rc;
+
+	if (iova % MOCK_IO_PAGE_SIZE || length % MOCK_IO_PAGE_SIZE ||
+	    (uintptr_t)uptr % MOCK_IO_PAGE_SIZE)
+		return -EINVAL;
+
+	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	for (; length; length -= MOCK_IO_PAGE_SIZE) {
+		struct page *pages[1];
+		unsigned long pfn;
+		long npages;
+		void *ent;
+
+		npages = get_user_pages_fast((uintptr_t)uptr & PAGE_MASK, 1, 0,
+					     pages);
+		if (npages < 0) {
+			rc = npages;
+			goto out_put;
+		}
+		if (WARN_ON(npages != 1)) {
+			rc = -EFAULT;
+			goto out_put;
+		}
+		pfn = page_to_pfn(pages[0]);
+		put_page(pages[0]);
+
+		ent = xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
+		if (!ent ||
+		    (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZE !=
+			    pfn * PAGE_SIZE + ((uintptr_t)uptr % PAGE_SIZE)) {
+			rc = -EINVAL;
+			goto out_put;
+		}
+		iova += MOCK_IO_PAGE_SIZE;
+		uptr += MOCK_IO_PAGE_SIZE;
+	}
+	rc = 0;
+
+out_put:
+	iommufd_put_object(&hwpt->obj);
+	return rc;
+}
+
+/* Check that the page ref count matches, to look for missing pin/unpins */
+static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
+				      void __user *uptr, size_t length,
+				      unsigned int refs)
+{
+	if (length % PAGE_SIZE || (uintptr_t)uptr % PAGE_SIZE)
+		return -EINVAL;
+
+	for (; length; length -= PAGE_SIZE) {
+		struct page *pages[1];
+		long npages;
+
+		npages = get_user_pages_fast((uintptr_t)uptr, 1, 0, pages);
+		if (npages < 0)
+			return npages;
+		if (WARN_ON(npages != 1))
+			return -EFAULT;
+		if (!PageCompound(pages[0])) {
+			unsigned int count;
+
+			count = page_ref_count(pages[0]);
+			if (count / GUP_PIN_COUNTING_BIAS != refs) {
+				put_page(pages[0]);
+				return -EIO;
+			}
+		}
+		put_page(pages[0]);
+		uptr += PAGE_SIZE;
+	}
+	return 0;
+}
+
+struct selftest_access {
+	struct iommufd_access *access;
+	struct file *file;
+	struct mutex lock;
+	struct list_head items;
+	unsigned int next_id;
+	bool destroying;
+};
+
+struct selftest_access_item {
+	struct list_head items_elm;
+	unsigned long iova;
+	size_t length;
+	unsigned int id;
+};
+
+static const struct file_operations iommfd_test_staccess_fops;
+
+static struct selftest_access *iommufd_access_get(int fd)
+{
+	struct file *file;
+
+	file = fget(fd);
+	if (!file)
+		return ERR_PTR(-EBADFD);
+
+	if (file->f_op != &iommfd_test_staccess_fops) {
+		fput(file);
+		return ERR_PTR(-EBADFD);
+	}
+	return file->private_data;
+}
+
+static void iommufd_test_access_unmap(void *data, unsigned long iova,
+				      unsigned long length)
+{
+	unsigned long iova_last = iova + length - 1;
+	struct selftest_access *staccess = data;
+	struct selftest_access_item *item;
+	struct selftest_access_item *tmp;
+
+	mutex_lock(&staccess->lock);
+	list_for_each_entry_safe(item, tmp, &staccess->items, items_elm) {
+		if (iova > item->iova + item->length - 1 ||
+		    iova_last < item->iova)
+			continue;
+		list_del(&item->items_elm);
+		iommufd_access_unpin_pages(staccess->access, item->iova,
+					   item->length);
+		kfree(item);
+	}
+	mutex_unlock(&staccess->lock);
+}
+
+static int iommufd_test_access_item_destroy(struct iommufd_ucmd *ucmd,
+					    unsigned int access_id,
+					    unsigned int item_id)
+{
+	struct selftest_access_item *item;
+	struct selftest_access *staccess;
+
+	staccess = iommufd_access_get(access_id);
+	if (IS_ERR(staccess))
+		return PTR_ERR(staccess);
+
+	mutex_lock(&staccess->lock);
+	list_for_each_entry(item, &staccess->items, items_elm) {
+		if (item->id == item_id) {
+			list_del(&item->items_elm);
+			iommufd_access_unpin_pages(staccess->access, item->iova,
+						   item->length);
+			mutex_unlock(&staccess->lock);
+			kfree(item);
+			fput(staccess->file);
+			return 0;
+		}
+	}
+	mutex_unlock(&staccess->lock);
+	fput(staccess->file);
+	return -ENOENT;
+}
+
+static int iommufd_test_staccess_release(struct inode *inode,
+					 struct file *filep)
+{
+	struct selftest_access *staccess = filep->private_data;
+
+	if (staccess->access) {
+		iommufd_test_access_unmap(staccess, 0, ULONG_MAX);
+		iommufd_access_destroy(staccess->access);
+	}
+	mutex_destroy(&staccess->lock);
+	kfree(staccess);
+	return 0;
+}
+
+static const struct iommufd_access_ops selftest_access_ops_pin = {
+	.needs_pin_pages = 1,
+	.unmap = iommufd_test_access_unmap,
+};
+
+static const struct iommufd_access_ops selftest_access_ops = {
+	.unmap = iommufd_test_access_unmap,
+};
+
+static const struct file_operations iommfd_test_staccess_fops = {
+	.release = iommufd_test_staccess_release,
+};
+
+static struct selftest_access *iommufd_test_alloc_access(void)
+{
+	struct selftest_access *staccess;
+	struct file *filep;
+
+	staccess = kzalloc(sizeof(*staccess), GFP_KERNEL_ACCOUNT);
+	if (!staccess)
+		return ERR_PTR(-ENOMEM);
+	INIT_LIST_HEAD(&staccess->items);
+	mutex_init(&staccess->lock);
+
+	filep = anon_inode_getfile("[iommufd_test_staccess]",
+				   &iommfd_test_staccess_fops, staccess,
+				   O_RDWR);
+	if (IS_ERR(filep)) {
+		kfree(staccess);
+		return ERR_CAST(filep);
+	}
+	staccess->file = filep;
+	return staccess;
+}
+
+static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
+				      unsigned int ioas_id, unsigned int flags)
+{
+	struct iommu_test_cmd *cmd = ucmd->cmd;
+	struct selftest_access *staccess;
+	struct iommufd_access *access;
+	int fdno;
+	int rc;
+
+	if (flags & ~MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES)
+		return -EOPNOTSUPP;
+
+	staccess = iommufd_test_alloc_access();
+	if (IS_ERR(staccess))
+		return PTR_ERR(staccess);
+
+	fdno = get_unused_fd_flags(O_CLOEXEC);
+	if (fdno < 0) {
+		rc = -ENOMEM;
+		goto out_free_staccess;
+	}
+
+	access = iommufd_access_create(
+		ucmd->ictx, ioas_id,
+		(flags & MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES) ?
+			&selftest_access_ops_pin :
+			&selftest_access_ops,
+		staccess);
+	if (IS_ERR(access)) {
+		rc = PTR_ERR(access);
+		goto out_put_fdno;
+	}
+	cmd->create_access.out_access_fd = fdno;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_destroy;
+
+	staccess->access = access;
+	fd_install(fdno, staccess->file);
+	return 0;
+
+out_destroy:
+	iommufd_access_destroy(access);
+out_put_fdno:
+	put_unused_fd(fdno);
+out_free_staccess:
+	fput(staccess->file);
+	return rc;
+}
+
+/* Check that the pages in a page array match the pages in the user VA */
+static int iommufd_test_check_pages(void __user *uptr, struct page **pages,
+				    size_t npages)
+{
+	for (; npages; npages--) {
+		struct page *tmp_pages[1];
+		long rc;
+
+		rc = get_user_pages_fast((uintptr_t)uptr, 1, 0, tmp_pages);
+		if (rc < 0)
+			return rc;
+		if (WARN_ON(rc != 1))
+			return -EFAULT;
+		put_page(tmp_pages[0]);
+		if (tmp_pages[0] != *pages)
+			return -EBADE;
+		pages++;
+		uptr += PAGE_SIZE;
+	}
+	return 0;
+}
+
+static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
+				     unsigned int access_id, unsigned long iova,
+				     size_t length, void __user *uptr,
+				     u32 flags)
+{
+	struct iommu_test_cmd *cmd = ucmd->cmd;
+	struct selftest_access_item *item;
+	struct selftest_access *staccess;
+	struct page **pages;
+	size_t npages;
+	int rc;
+
+	/* Prevent syzkaller from triggering a WARN_ON in kvzalloc() */
+	if (length > 16*1024*1024)
+		return -ENOMEM;
+
+	if (flags & ~(MOCK_FLAGS_ACCESS_WRITE | MOCK_FLAGS_ACCESS_SYZ))
+		return -EOPNOTSUPP;
+
+	staccess = iommufd_access_get(access_id);
+	if (IS_ERR(staccess))
+		return PTR_ERR(staccess);
+
+	if (staccess->access->ops != &selftest_access_ops_pin) {
+		rc = -EOPNOTSUPP;
+		goto out_put;
+	}
+
+	if (flags & MOCK_FLAGS_ACCESS_SYZ)
+		iova = iommufd_test_syz_conv_iova(&staccess->access->ioas->iopt,
+					&cmd->access_pages.iova);
+
+	npages = (ALIGN(iova + length, PAGE_SIZE) -
+		  ALIGN_DOWN(iova, PAGE_SIZE)) /
+		 PAGE_SIZE;
+	pages = kvcalloc(npages, sizeof(*pages), GFP_KERNEL_ACCOUNT);
+	if (!pages) {
+		rc = -ENOMEM;
+		goto out_put;
+	}
+
+	/*
+	 * Drivers will need to think very carefully about this locking. The
+	 * core code can do multiple unmaps instantaneously after
+	 * iommufd_access_pin_pages() and *all* the unmaps must not return until
+	 * the range is unpinned. This simple implementation puts a global lock
+	 * around the pin, which may not suit drivers that want this to be a
+	 * performance path. drivers that get this wrong will trigger WARN_ON
+	 * races and cause EDEADLOCK failures to userspace.
+	 */
+	mutex_lock(&staccess->lock);
+	rc = iommufd_access_pin_pages(staccess->access, iova, length, pages,
+				      flags & MOCK_FLAGS_ACCESS_WRITE);
+	if (rc)
+		goto out_unlock;
+
+	/* For syzkaller allow uptr to be NULL to skip this check */
+	if (uptr) {
+		rc = iommufd_test_check_pages(
+			uptr - (iova - ALIGN_DOWN(iova, PAGE_SIZE)), pages,
+			npages);
+		if (rc)
+			goto out_unaccess;
+	}
+
+	item = kzalloc(sizeof(*item), GFP_KERNEL_ACCOUNT);
+	if (!item) {
+		rc = -ENOMEM;
+		goto out_unaccess;
+	}
+
+	item->iova = iova;
+	item->length = length;
+	item->id = staccess->next_id++;
+	list_add_tail(&item->items_elm, &staccess->items);
+
+	cmd->access_pages.out_access_pages_id = item->id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_free_item;
+	goto out_unlock;
+
+out_free_item:
+	list_del(&item->items_elm);
+	kfree(item);
+out_unaccess:
+	iommufd_access_unpin_pages(staccess->access, iova, length);
+out_unlock:
+	mutex_unlock(&staccess->lock);
+	kvfree(pages);
+out_put:
+	fput(staccess->file);
+	return rc;
+}
+
+static int iommufd_test_access_rw(struct iommufd_ucmd *ucmd,
+				  unsigned int access_id, unsigned long iova,
+				  size_t length, void __user *ubuf,
+				  unsigned int flags)
+{
+	struct iommu_test_cmd *cmd = ucmd->cmd;
+	struct selftest_access *staccess;
+	void *tmp;
+	int rc;
+
+	/* Prevent syzkaller from triggering a WARN_ON in kvzalloc() */
+	if (length > 16*1024*1024)
+		return -ENOMEM;
+
+	if (flags & ~(MOCK_ACCESS_RW_WRITE | MOCK_ACCESS_RW_SLOW_PATH |
+		      MOCK_FLAGS_ACCESS_SYZ))
+		return -EOPNOTSUPP;
+
+	staccess = iommufd_access_get(access_id);
+	if (IS_ERR(staccess))
+		return PTR_ERR(staccess);
+
+	tmp = kvzalloc(length, GFP_KERNEL_ACCOUNT);
+	if (!tmp) {
+		rc = -ENOMEM;
+		goto out_put;
+	}
+
+	if (flags & MOCK_ACCESS_RW_WRITE) {
+		if (copy_from_user(tmp, ubuf, length)) {
+			rc = -EFAULT;
+			goto out_free;
+		}
+	}
+
+	if (flags & MOCK_FLAGS_ACCESS_SYZ)
+		iova = iommufd_test_syz_conv_iova(&staccess->access->ioas->iopt,
+					&cmd->access_rw.iova);
+
+	rc = iommufd_access_rw(staccess->access, iova, tmp, length, flags);
+	if (rc)
+		goto out_free;
+	if (!(flags & MOCK_ACCESS_RW_WRITE)) {
+		if (copy_to_user(ubuf, tmp, length)) {
+			rc = -EFAULT;
+			goto out_free;
+		}
+	}
+
+out_free:
+	kvfree(tmp);
+out_put:
+	fput(staccess->file);
+	return rc;
+}
+static_assert((unsigned int)MOCK_ACCESS_RW_WRITE == IOMMUFD_ACCESS_RW_WRITE);
+static_assert((unsigned int)MOCK_ACCESS_RW_SLOW_PATH ==
+	      __IOMMUFD_ACCESS_RW_SLOW_PATH);
+
+void iommufd_selftest_destroy(struct iommufd_object *obj)
+{
+	struct selftest_obj *sobj = container_of(obj, struct selftest_obj, obj);
+
+	switch (sobj->type) {
+	case TYPE_IDEV:
+		iommufd_device_selftest_detach(sobj->idev.ictx,
+					       sobj->idev.hwpt);
+		break;
+	}
+}
+
+int iommufd_test(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_test_cmd *cmd = ucmd->cmd;
+
+	switch (cmd->op) {
+	case IOMMU_TEST_OP_ADD_RESERVED:
+		return iommufd_test_add_reserved(ucmd, cmd->id,
+						 cmd->add_reserved.start,
+						 cmd->add_reserved.length);
+	case IOMMU_TEST_OP_MOCK_DOMAIN:
+		return iommufd_test_mock_domain(ucmd, cmd);
+	case IOMMU_TEST_OP_MD_CHECK_MAP:
+		return iommufd_test_md_check_pa(
+			ucmd, cmd->id, cmd->check_map.iova,
+			cmd->check_map.length,
+			u64_to_user_ptr(cmd->check_map.uptr));
+	case IOMMU_TEST_OP_MD_CHECK_REFS:
+		return iommufd_test_md_check_refs(
+			ucmd, u64_to_user_ptr(cmd->check_refs.uptr),
+			cmd->check_refs.length, cmd->check_refs.refs);
+	case IOMMU_TEST_OP_CREATE_ACCESS:
+		return iommufd_test_create_access(ucmd, cmd->id,
+						  cmd->create_access.flags);
+	case IOMMU_TEST_OP_ACCESS_PAGES:
+		return iommufd_test_access_pages(
+			ucmd, cmd->id, cmd->access_pages.iova,
+			cmd->access_pages.length,
+			u64_to_user_ptr(cmd->access_pages.uptr),
+			cmd->access_pages.flags);
+	case IOMMU_TEST_OP_ACCESS_RW:
+		return iommufd_test_access_rw(
+			ucmd, cmd->id, cmd->access_rw.iova,
+			cmd->access_rw.length,
+			u64_to_user_ptr(cmd->access_rw.uptr),
+			cmd->access_rw.flags);
+	case IOMMU_TEST_OP_DESTROY_ACCESS_PAGES:
+		return iommufd_test_access_item_destroy(
+			ucmd, cmd->id, cmd->destroy_access_pages.access_pages_id);
+	case IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT:
+		/* Protect _batch_init(), can not be less than elmsz */
+		if (cmd->memory_limit.limit <
+		    sizeof(unsigned long) + sizeof(u32))
+			return -EINVAL;
+		iommufd_test_memory_limit = cmd->memory_limit.limit;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+bool iommufd_should_fail(void)
+{
+	return should_fail(&fail_iommufd, 1);
+}
+
+void __init iommufd_test_init(void)
+{
+	dbgfs_root =
+		fault_create_debugfs_attr("fail_iommufd", NULL, &fail_iommufd);
+}
+
+void iommufd_test_exit(void)
+{
+	debugfs_remove_recursive(dbgfs_root);
+}
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index d57b044acca4cb..7a5d64a1dae482 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -38,6 +38,9 @@ enum {
 	IOMMUFD_ACCESS_RW_WRITE = 1 << 0,
 	/* Set if the caller is in a kthread then rw will use kthread_use_mm() */
 	IOMMUFD_ACCESS_RW_KTHREAD = 1 << 1,
+
+	/* Only for use by selftest */
+	__IOMMUFD_ACCESS_RW_SLOW_PATH = 1 << 2,
 };
 
 struct iommufd_access *
-- 
2.38.1


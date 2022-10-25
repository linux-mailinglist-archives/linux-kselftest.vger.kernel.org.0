Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FB660D33A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiJYSMt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiJYSMp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F565B5FC7;
        Tue, 25 Oct 2022 11:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRnyGdoHUCRXxLt6IMbjeuPJb3v96N2kpYbI2pdMucclB74UcagLGZKF9US/j3t1Yiokz77uvx/6kDHIU5n/W/eBd6HggdAFwY3EUitOXEIptm7xPbO3sDIPVti8+IaMbz7RL5mejx0RC0NIF3hGTUN8s3e1ejcxn/U3Qil4B3PSXp/vzmiQMqMxWRuUfx0wyczDlsRDvwi9rRRdqk9wLFV08wXz/lHy+/6QA3fkCRZpmCXVkZFCp2bHeApiqrx60jyWi8Tv06JgKeqMHnr26eNZKBGZ9eH+bvmiwkIFGs4YVQapV3/4Zwolvre6DlJeyyGez+k4TNLYwmXV8lr3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Su5cbJ/DK8VvyTAZ51P/u6lgPFKfWP7XIaoqaqyzQo=;
 b=fSiZ7bJx7x1/6+CUpmQPcr/oZVBI05ZY6VNhowcULRSWUVWhHr+yOZYnqM4sQpiH1RCqn82QQ1kizqqtO7u9vmVFOzmUDewVfCIwg01AcfbhlHuX9xkoK2xlj2OxWBBfwsDHmIQFxZqOHDO0ufeTzeSPRhzczlTt5n/SKAUC1tIE5c/BFU7R7AtrjlHDXjo8uRQJRnzyjbGiODJRxqaVJQNzRB8r7IHHZLDIox7W+Q9OBsTCQfQx52umCxh42YSG3YNO2RHFO3TJRrUnU4LDrOOL4uJhmM/JJP3dZvN2qr32ISEzn8iynLhEvSSZakjRC92rXn3+k9EuV2YWdW5B3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Su5cbJ/DK8VvyTAZ51P/u6lgPFKfWP7XIaoqaqyzQo=;
 b=N96+zZWIWlgiqQLuztB+gf6dIgChgz+Y6c1ZDLKAmk63X9RRvNk1nsaALApAxZt18uyKzuHbuzyl5Io1SyVZzkCVWL0DSihbN1bRmTHOBP3yTe9EjjK3cWYv5+5mdzmFElCTrSOj5T/wcGkxgP0+b/UnQ6kpmArf/DpxMXfcAW6XZs+GjhzQGEBuvvGV3QkSWRun2kfzwRKaVUXsh9Zv2CcgjSRGTDVLbLWzDZcn2ynUG5fQFJK7hXcvUntitZqviq+F3M/XM14HF6dA7254fAsLpPt+XFYa5e0bHG4a8X2M4Ichu5MpVHHipCOqSLmpoxNA/3ZSla8YmdOOCJ9FTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 18:12:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:30 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v3 15/15] iommufd: Add a selftest
Date:   Tue, 25 Oct 2022 15:12:24 -0300
Message-Id: <15-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8e862a-62b8-4845-2589-08dab6b47882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OOBdIiT6KXEdN0iomvLVVMuiZ+86j0itWvYAlHzCsNMgQncF0sOW3gRVXCvVNS6yWtmxrRKPXdBLurTLdf4g13ydPhZvT5y6kTrf+gK0z5LIAgzABZWX3OFPo8hdomPHkzPOwmKf+ub0h7G7NE9QQssb++X72VKFd0cQQhz8wjAQs/GP+igD9Uke8Do/jM2q8NMMgghF90q4xMDOJedJHME3PHmJtBFdUTWEXsjsBRZ7ZPjK4bj4ep403llV/Zx7LE90ueaG8VgReg0wE7eo3pmm1rys1zUPPE7lm0Vej9uKQsJIOJr5KG58TK733YSGFx8mzbiW+JLGH9CMZzmbPIX0SFn5QR800zcMea/wyVyPSpXIJASBwTLbW/PVEJf6szPTOR97ezMiyKXJgBiDSqkpGuzpwlyBEQVmR5Wf7NqQ9sZfPrZrecfRNSIZQp6ER6dZF4CRQweITFv4dlG1y66PFDrAICQqfwU4lkOS7+1k2XXfZjeMbL0ufC2J/EA+7B/AK+sZqzV8aBoh/wbwUiSL+mVPWgbUWUPkhaSGVTOSnd+0Ybciq4tBhNqXLWumg+NpvkS5gtmp1GO6f47itDjUqltVhbhJ9OFUA7LVVJUmXzXAk3Cnb2KLM4sWVVkgH5LiD0TQEc/d57fqgnfYlz+dOp7dnFqQV2v+cTa3HKyxk3ir8BZ65gLhU0Dm3ISt7dSHXiloul5RQ0AZTwWxbJS/TyQxS2GfKXs31Q7VXewZG1FnxhdgcXfYGcSoMP6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(6666004)(316002)(41300700001)(110136005)(36756003)(2616005)(6506007)(54906003)(7406005)(30864003)(7416002)(8936002)(66476007)(83380400001)(5660300002)(26005)(2906002)(4326008)(186003)(66946007)(8676002)(66556008)(6512007)(921005)(6486002)(38100700002)(86362001)(478600001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4jAhF06xYEVY4493XZZgrFDFF1//1vJDiji1foVGAVvxVSFp0nDlCnYePD2n?=
 =?us-ascii?Q?tyusSkK6/oADONZ8za1Hyo+7U7VCv1veSW4NFD/uQbrrT3cnE2PQmWrDTVwe?=
 =?us-ascii?Q?X1Vcagtb9URAIQhSc8tzPlZqwkREn/TgZP2vVG4advJZz1oao/feae/RlHwB?=
 =?us-ascii?Q?CJI4n7houlEyk6YIUSuvOMho7W/W2Kz1pOqVrGRoOWrMPN8h6a9NEFNUIAk5?=
 =?us-ascii?Q?tQAsi/ShEY2vzeAArggYBl2tRcQRqXsrqDpVVm/7I21/9Qkrdh7IUjL+PpCp?=
 =?us-ascii?Q?5ffgD+x2pIoxbKZWWBw+x7rJrWvpqFYfIzg7PgsufYGbWxsiOmhuyVCHzx0h?=
 =?us-ascii?Q?zqncgLN866eqMqDIrWk4IZVj0PNM2VD05K8jIz5YnGgpau2s6IHIdVvS+fzH?=
 =?us-ascii?Q?q+8Y72S5EikuxsG4hDFkTcQsrL/jopXKb32uaO7kOnQzhB14zgkIfEXCsqjo?=
 =?us-ascii?Q?9kxBoC13d6MoJNLG1oTARCCqAE/T7XjWMVRySyqqkkGPNMm4gr9hSNwO6LHd?=
 =?us-ascii?Q?OC//ksR5QWGemkI0S+utVLwyyzMf5S+lYyrxYjJQDVCKO6KnQPCGKER8tnMk?=
 =?us-ascii?Q?zZWmsDzWOzpk1sS5Z5ZX2P8DaEkbGFRVtl9eRio6A/ZxTpSJMSi7GkDIqMPB?=
 =?us-ascii?Q?K8p//d9PKiYf0YwuZ6jMK0iXP4RGtM7p03VkPYVdg+nUinhp9AdEzfL5AjQG?=
 =?us-ascii?Q?Ha5Vn9rVU8CcO1L2aQidG5FcA2/ixcEO+ScBS/auAyfw2I1MEOlCvz6ntMnd?=
 =?us-ascii?Q?J8kQVD9Pt6DJwkjB9odl7y+OeMbVBUw2hWh2zGZDyphT7ERhqXQJDGcfbWEL?=
 =?us-ascii?Q?lCVzvGXNK39JmpxRriB8qL5sNrdiu0c/M14qePwKp/6DW+aX/Pzi0My8ffp9?=
 =?us-ascii?Q?ZF2/+2yE1ghd0WMDkUi20Ng+gqQrp9CnTgcedbTL1/2XAouD6wpfmR/3hiM9?=
 =?us-ascii?Q?2VtCsp0uH6eDK9QouP62SjuE4QyiYTfLPTKhKoqhXorsROVGHwlbcaAs7wE3?=
 =?us-ascii?Q?ZiM2qO2C/ipxQoat0PEIFHkrzpBi1ChRb04d9ZwFvgbztKDIxXO6HxiQtliP?=
 =?us-ascii?Q?sAKZxpjB2Vk4tzxQEy2cls1q/yUy/6yS+1SwmBbjPN2NRXglZ7ZwZLGdAb4Y?=
 =?us-ascii?Q?x2RzPA4faPGvo6izf8Wq5KbdP1sjtysPwhOuWT7u2oiLMiz93cihaBs7dJbT?=
 =?us-ascii?Q?sqDISZ6ivOX/d1GbWUIeIV84YioL/Qo/QLxAU10aNEWf9rlLL0aFlIIErikQ?=
 =?us-ascii?Q?12efMGV3Ut9ERcOmY1lOuEh8tHn7Pbl7+/iP8GBPvBj4NRfirnQ8IBLbMQFJ?=
 =?us-ascii?Q?t5s4nr0TWOvEKb/Oqa2v5A7/hvVQI/5tQwrj1nxlAyJs4fYlLtoe/EjNRjXA?=
 =?us-ascii?Q?ue+Stx2rWUwLX5+OdIXvU4LA/wSdvpqgF1dPRBYhvexMQKRHhbW9vcgxsJYH?=
 =?us-ascii?Q?jhZ92J+igzqNHFV5hJJ0BBvzPZWUAAkd19YL3S61OZj9LRu3ldBukuGjl5Vq?=
 =?us-ascii?Q?CITR6x5yHiKdnbCau/+EbNIqYLf3kiffHYT3pBy4LgJksLkclTtwcG7dUVAE?=
 =?us-ascii?Q?TRgnuBB8O3nmY+4Cj5o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8e862a-62b8-4845-2589-08dab6b47882
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:26.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6txo4LeEuCSQqSfnwaUmi9aeSEf4o5WFmPhYssm57yg0XvDb9tt2QSsCcz5CqSLQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cover the essential functionality of the iommufd with a directed
test. This aims to achieve reasonable functional coverage using the
in-kernel self test framework.

It provides a mock kernel module for the iommu_domain that allows it to
run without any HW and the mocking provides a way to directly validate
that the PFNs loaded into the iommu_domain are correct.

The mock also simulates the rare case of PAGE_SIZE > iommu page size as
the mock will operate at a 2K iommu page size. This allows exercising all
of the calculations to support this mismatch.

This allows achieving high coverage of the corner cases in the iopt_pages.

However, it is an unusually invasive config option to enable all of
this. The config option should not be enabled in a production kernel.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/Kconfig            |   10 +
 drivers/iommu/iommufd/Makefile           |    2 +
 drivers/iommu/iommufd/device.c           |   38 +
 drivers/iommu/iommufd/io_pagetable.c     |   10 +
 drivers/iommu/iommufd/iommufd_private.h  |   15 +
 drivers/iommu/iommufd/iommufd_test.h     |   85 ++
 drivers/iommu/iommufd/main.c             |   12 +
 drivers/iommu/iommufd/pages.c            |   12 +
 drivers/iommu/iommufd/selftest.c         |  711 +++++++++
 include/linux/iommufd.h                  |    3 +
 tools/testing/selftests/Makefile         |    1 +
 tools/testing/selftests/iommu/.gitignore |    2 +
 tools/testing/selftests/iommu/Makefile   |   11 +
 tools/testing/selftests/iommu/config     |    2 +
 tools/testing/selftests/iommu/iommufd.c  | 1715 ++++++++++++++++++++++
 15 files changed, 2629 insertions(+)
 create mode 100644 drivers/iommu/iommufd/iommufd_test.h
 create mode 100644 drivers/iommu/iommufd/selftest.c
 create mode 100644 tools/testing/selftests/iommu/.gitignore
 create mode 100644 tools/testing/selftests/iommu/Makefile
 create mode 100644 tools/testing/selftests/iommu/config
 create mode 100644 tools/testing/selftests/iommu/iommufd.c

diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 020614dc5eaf7e..f0a2012234fa09 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -12,3 +12,13 @@ config IOMMUFD
 	  This would commonly be used in combination with VFIO.
 
 	  If you don't know what to do here, say N.
+
+if IOMMUFD
+config IOMMUFD_TEST
+	bool "IOMMU Userspace API Test support"
+	depends on RUNTIME_TESTING_MENU
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
index b4a799b2b41ae3..d1af0389dfab83 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -704,3 +704,41 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
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
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index bc24227100fe22..d42f89becab96e 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -257,6 +257,11 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 			(uintptr_t)elm->pages->uptr + elm->start_byte, length);
 		if (rc)
 			goto out_unlock;
+		if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+		    WARN_ON(iopt_check_iova(iopt, *dst_iova, length))) {
+			rc = -EINVAL;
+			goto out_unlock;
+		}
 	} else {
 		rc = iopt_check_iova(iopt, *dst_iova, length);
 		if (rc)
@@ -283,6 +288,8 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 
 static void iopt_abort_area(struct iopt_area *area)
 {
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(area->pages);
 	if (area->iopt) {
 		down_write(&area->iopt->iova_rwsem);
 		interval_tree_remove(&area->node, &area->iopt->area_itree);
@@ -641,6 +648,9 @@ void iopt_destroy_table(struct io_pagetable *iopt)
 {
 	struct interval_tree_node *node;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		iopt_remove_reserved_iova(iopt, NULL);
+
 	while ((node = interval_tree_iter_first(&iopt->allowed_itree, 0,
 						ULONG_MAX))) {
 		interval_tree_remove(node, &iopt->allowed_itree);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 87fd127ca5843a..47d18388dc24fa 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -112,6 +112,9 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_HW_PAGETABLE,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
+#ifdef CONFIG_IOMMUFD_TEST
+	IOMMUFD_OBJ_SELFTEST,
+#endif
 };
 
 /* Base struct for all objects with a userspace ID handle. */
@@ -255,4 +258,16 @@ void iommufd_device_destroy(struct iommufd_object *obj);
 
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+#ifdef CONFIG_IOMMUFD_TEST
+struct iommufd_access;
+struct iommufd_hw_pagetable *
+iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
+			       struct iommufd_ioas *ioas,
+			       struct device *mock_dev);
+void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
+				    struct iommufd_hw_pagetable *hwpt);
+int iommufd_test(struct iommufd_ucmd *ucmd);
+void iommufd_selftest_destroy(struct iommufd_object *obj);
+extern size_t iommufd_test_memory_limit;
+#endif
 #endif
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
new file mode 100644
index 00000000000000..4e52e37e4b66df
--- /dev/null
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -0,0 +1,85 @@
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
+	IOMMU_TEST_OP_ADD_RESERVED,
+	IOMMU_TEST_OP_MOCK_DOMAIN,
+	IOMMU_TEST_OP_MD_CHECK_MAP,
+	IOMMU_TEST_OP_MD_CHECK_REFS,
+	IOMMU_TEST_OP_CREATE_ACCESS,
+	IOMMU_TEST_OP_DESTROY_ACCESS_ITEM,
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
+};
+
+enum {
+	MOCK_ACCESS_RW_WRITE = 1 << 0,
+	MOCK_ACCESS_RW_SLOW_PATH = 1 << 2,
+};
+
+struct iommu_test_cmd {
+	__u32 size;
+	__u32 op;
+	__u32 id;
+	union {
+		struct {
+			__u32 device_id;
+		} mock_domain;
+		struct {
+			__aligned_u64 start;
+			__aligned_u64 length;
+		} add_reserved;
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
+		} create_access;
+		struct {
+			__u32 flags;
+			__u32 out_access_item_id;
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
+			__u32 access_item_id;
+		} destroy_access_item;
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
index dc19723d5832a5..8a31c1a14cdd53 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -25,6 +25,7 @@
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
@@ -270,6 +274,9 @@ static struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+#ifdef CONFIG_IOMMUFD_TEST
+	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
+#endif
 };
 
 static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
@@ -370,6 +377,11 @@ static struct iommufd_object_ops iommufd_object_ops[] = {
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
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index a09e197524be3b..1885efaea6502a 100644
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
@@ -370,6 +374,10 @@ static int batch_iommu_map_small(struct iommu_domain *domain,
 	unsigned long start_iova = iova;
 	int rc;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(paddr % PAGE_SIZE || iova % PAGE_SIZE ||
+			size % PAGE_SIZE);
+
 	while (size) {
 		rc = iommu_map(domain, iova, paddr, PAGE_SIZE, prot);
 		if (rc)
@@ -1648,6 +1656,10 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
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
index 00000000000000..4902669619c92a
--- /dev/null
+++ b/drivers/iommu/iommufd/selftest.c
@@ -0,0 +1,711 @@
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
+
+#include "iommufd_private.h"
+#include "iommufd_test.h"
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
+				       GFP_KERNEL);
+			if (xa_is_err(old))
+				return xa_err(old);
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
+		return ERR_PTR(-EINVAL);
+		iommufd_put_object(&hwpt->obj);
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
+	cmd->id = hwpt->obj.id;
+	cmd->mock_domain.device_id = sobj->obj.id;
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
+	spinlock_t lock;
+	struct list_head items;
+	unsigned int next_id;
+	bool destroying;
+};
+
+struct selftest_access_item {
+	struct list_head items_elm;
+	unsigned long iova;
+	unsigned long iova_end;
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
+	spin_lock(&staccess->lock);
+	list_for_each_entry_safe(item, tmp, &staccess->items, items_elm) {
+		if (iova > item->iova_end || iova_last < item->iova)
+			continue;
+		list_del(&item->items_elm);
+		spin_unlock(&staccess->lock);
+		iommufd_access_unpin_pages(staccess->access, item->iova,
+					   item->length);
+		kfree(item);
+		spin_lock(&staccess->lock);
+	}
+	spin_unlock(&staccess->lock);
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
+	spin_lock(&staccess->lock);
+	list_for_each_entry(item, &staccess->items, items_elm) {
+		if (item->id == item_id) {
+			list_del(&item->items_elm);
+			spin_unlock(&staccess->lock);
+			iommufd_access_unpin_pages(staccess->access, item->iova,
+						   item->length);
+			kfree(item);
+			fput(staccess->file);
+			return 0;
+		}
+	}
+	spin_unlock(&staccess->lock);
+	fput(staccess->file);
+	return -ENOENT;
+}
+
+static int iommufd_test_staccess_release(struct inode *inode,
+					 struct file *filep)
+{
+	struct selftest_access *staccess = filep->private_data;
+
+	iommufd_test_access_unmap(staccess, 0, ULONG_MAX);
+	iommufd_access_destroy(staccess->access);
+	kfree(staccess);
+	return 0;
+}
+
+static struct iommufd_access_ops selftest_access_ops = {
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
+	spin_lock_init(&staccess->lock);
+
+	staccess->file = anon_inode_getfile("[iommufd_test_staccess]",
+					    &iommfd_test_staccess_fops,
+					    staccess, O_RDWR);
+	if (IS_ERR(staccess->file)) {
+		kfree(staccess);
+		return ERR_CAST(filep);
+	}
+	return staccess;
+}
+
+static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
+				      unsigned int ioas_id)
+{
+	struct iommu_test_cmd *cmd = ucmd->cmd;
+	struct selftest_access *staccess;
+	int fdno;
+	int rc;
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
+	staccess->access = iommufd_access_create(
+		ucmd->ictx, ioas_id, &selftest_access_ops, staccess);
+	if (IS_ERR(staccess->access)) {
+		rc = PTR_ERR(staccess->access);
+		goto out_put_fdno;
+	}
+	cmd->create_access.out_access_fd = fdno;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_destroy;
+
+	fd_install(fdno, staccess->file);
+	return 0;
+
+out_destroy:
+	iommufd_access_destroy(staccess->access);
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
+	if (flags & ~MOCK_FLAGS_ACCESS_WRITE)
+		return -EOPNOTSUPP;
+
+	staccess = iommufd_access_get(access_id);
+	if (IS_ERR(staccess))
+		return PTR_ERR(staccess);
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
+	rc = iommufd_access_pin_pages(staccess->access, iova, length, pages,
+				      flags & MOCK_FLAGS_ACCESS_WRITE);
+	if (rc)
+		goto out_free_pages;
+
+	rc = iommufd_test_check_pages(
+		uptr - (iova - ALIGN_DOWN(iova, PAGE_SIZE)), pages, npages);
+	if (rc)
+		goto out_unaccess;
+
+	item = kzalloc(sizeof(*item), GFP_KERNEL_ACCOUNT);
+	if (!item) {
+		rc = -ENOMEM;
+		goto out_unaccess;
+	}
+
+	item->iova = iova;
+	item->length = length;
+	spin_lock(&staccess->lock);
+	item->id = staccess->next_id++;
+	list_add_tail(&item->items_elm, &staccess->items);
+	spin_unlock(&staccess->lock);
+
+	cmd->access_pages.out_access_item_id = item->id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_free_item;
+	goto out_free_pages;
+
+out_free_item:
+	spin_lock(&staccess->lock);
+	list_del(&item->items_elm);
+	spin_unlock(&staccess->lock);
+	kfree(item);
+out_unaccess:
+	iommufd_access_unpin_pages(staccess->access, iova, length);
+out_free_pages:
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
+	struct selftest_access *staccess;
+	void *tmp;
+	int rc;
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
+		return iommufd_test_create_access(ucmd, cmd->id);
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
+	case IOMMU_TEST_OP_DESTROY_ACCESS_ITEM:
+		return iommufd_test_access_item_destroy(
+			ucmd, cmd->id, cmd->destroy_access_item.access_item_id);
+	case IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT:
+		iommufd_test_memory_limit = cmd->memory_limit.limit;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 3598292df937d5..fc253a4d2f8e77 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -37,6 +37,9 @@ enum {
 	IOMMUFD_ACCESS_RW_WRITE = 1 << 0,
 	/* Set if the caller is in a kthread then rw will use kthread_use_mm() */
 	IOMMUFD_ACCESS_RW_KTHREAD = 1 << 1,
+
+	/* Only for use by selftest */
+	__IOMMUFD_ACCESS_RW_SLOW_PATH = 1 << 2,
 };
 
 struct iommufd_access *
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 0464b2c6c1e4b2..eedd772b36fe9c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -27,6 +27,7 @@ TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
 TARGETS += intel_pstate
+TARGETS += iommu
 TARGETS += ipc
 TARGETS += ir
 TARGETS += kcmp
diff --git a/tools/testing/selftests/iommu/.gitignore b/tools/testing/selftests/iommu/.gitignore
new file mode 100644
index 00000000000000..c6bd07e7ff59b3
--- /dev/null
+++ b/tools/testing/selftests/iommu/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/iommufd
diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
new file mode 100644
index 00000000000000..7bc38b3beaeb20
--- /dev/null
+++ b/tools/testing/selftests/iommu/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -Wall -O2 -Wno-unused-function
+CFLAGS += -I../../../../include/uapi/
+CFLAGS += -I../../../../include/
+
+CFLAGS += -D_GNU_SOURCE
+
+TEST_GEN_PROGS :=
+TEST_GEN_PROGS += iommufd
+
+include ../lib.mk
diff --git a/tools/testing/selftests/iommu/config b/tools/testing/selftests/iommu/config
new file mode 100644
index 00000000000000..6c4f901d6fed3c
--- /dev/null
+++ b/tools/testing/selftests/iommu/config
@@ -0,0 +1,2 @@
+CONFIG_IOMMUFD
+CONFIG_IOMMUFD_TEST
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
new file mode 100644
index 00000000000000..8de1ff8a8c9257
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -0,0 +1,1715 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES */
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/fcntl.h>
+#include <sys/ioctl.h>
+#include <assert.h>
+#include <stddef.h>
+#include <sys/eventfd.h>
+
+#include "../kselftest_harness.h"
+
+#define __EXPORTED_HEADERS__
+#include <linux/iommufd.h>
+#include <linux/vfio.h>
+#include "../../../../drivers/iommu/iommufd/iommufd_test.h"
+
+static void *buffer;
+
+static unsigned long PAGE_SIZE;
+static unsigned long HUGEPAGE_SIZE;
+static unsigned long BUFFER_SIZE;
+
+#define MOCK_PAGE_SIZE (PAGE_SIZE / 2)
+
+static unsigned long get_huge_page_size(void)
+{
+	char buf[80];
+	int ret;
+	int fd;
+
+	fd = open("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size",
+		  O_RDONLY);
+	if (fd < 0)
+		return 2 * 1024 * 1024;
+
+	ret = read(fd, buf, sizeof(buf));
+	close(fd);
+	if (ret <= 0 || ret == sizeof(buf))
+		return 2 * 1024 * 1024;
+	buf[ret] = 0;
+	return strtoul(buf, NULL, 10);
+}
+
+static __attribute__((constructor)) void setup_sizes(void)
+{
+	void *vrc;
+	int rc;
+
+	PAGE_SIZE = sysconf(_SC_PAGE_SIZE);
+	HUGEPAGE_SIZE = get_huge_page_size();
+
+	BUFFER_SIZE = PAGE_SIZE * 16;
+	rc = posix_memalign(&buffer, HUGEPAGE_SIZE, BUFFER_SIZE);
+	assert(!rc);
+	assert(buffer);
+	assert((uintptr_t)buffer % HUGEPAGE_SIZE == 0);
+	vrc = mmap(buffer, BUFFER_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	assert(vrc == buffer);
+}
+
+/* Hack to make assertions more readable */
+#define _IOMMU_TEST_CMD(x) IOMMU_TEST_CMD
+
+/*
+ * Have the kernel check the refcount on pages. I don't know why a freshly
+ * mmap'd anon non-compound page starts out with a ref of 3
+ */
+#define check_refs(_ptr, _length, _refs)                                      \
+	({                                                                    \
+		struct iommu_test_cmd test_cmd = {                            \
+			.size = sizeof(test_cmd),                             \
+			.op = IOMMU_TEST_OP_MD_CHECK_REFS,                    \
+			.check_refs = { .length = _length,                    \
+					.uptr = (uintptr_t)(_ptr),            \
+					.refs = _refs },                      \
+		};                                                            \
+		ASSERT_EQ(0,                                                  \
+			  ioctl(self->fd,                                     \
+				_IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_REFS), \
+				&test_cmd));                                  \
+	})
+
+static int _test_cmd_create_access(int fd, unsigned int ioas_id,
+				   __u32 *access_id)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_CREATE_ACCESS,
+		.id = ioas_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (ret)
+		return ret;
+	*access_id = cmd.create_access.out_access_fd;
+	return 0;
+}
+#define test_cmd_create_access(ioas_id, access_id) \
+	ASSERT_EQ(0, _test_cmd_create_access(self->fd, ioas_id, access_id))
+
+static int _test_cmd_destroy_access(int fd, unsigned int access_id)
+{
+	return close(access_id);
+}
+#define test_cmd_destroy_access(access_id) \
+	ASSERT_EQ(0, _test_cmd_destroy_access(self->fd, access_id))
+
+static int _test_cmd_destroy_access_item(int fd, unsigned int access_id,
+					 unsigned int access_item_id)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_DESTROY_ACCESS_ITEM,
+		.id = access_id,
+		.destroy_access_item = { .access_item_id = access_item_id },
+	};
+	return ioctl(fd, IOMMU_TEST_CMD, &cmd);
+}
+#define test_cmd_destroy_access_item(access_id, access_item_id)         \
+	ASSERT_EQ(0, _test_cmd_destroy_access_item(self->fd, access_id, \
+						   access_item_id))
+
+static int _test_ioctl_destroy(int fd, unsigned int id)
+{
+	struct iommu_destroy cmd = {
+		.size = sizeof(cmd),
+		.id = id,
+	};
+	return ioctl(fd, IOMMU_DESTROY, &cmd);
+}
+#define test_ioctl_destroy(id) ASSERT_EQ(0, _test_ioctl_destroy(self->fd, id))
+
+static int _test_ioctl_ioas_alloc(int fd, __u32 *id)
+{
+	struct iommu_ioas_alloc cmd = {
+		.size = sizeof(cmd),
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_IOAS_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	*id = cmd.out_ioas_id;
+	return 0;
+}
+#define test_ioctl_ioas_alloc(id)                                   \
+	({                                                          \
+		ASSERT_EQ(0, _test_ioctl_ioas_alloc(self->fd, id)); \
+		ASSERT_NE(0, *(id));                                \
+	})
+
+static int _test_ioctl_ioas_map(int fd, unsigned int ioas_id, void *buffer,
+				size_t length, __u64 *iova, unsigned int flags)
+{
+	struct iommu_ioas_map cmd = {
+		.size = sizeof(cmd),
+		.flags = flags,
+		.ioas_id = ioas_id,
+		.user_va = (uintptr_t)buffer,
+		.length = length,
+	};
+	int ret;
+
+	if (flags & IOMMU_IOAS_MAP_FIXED_IOVA)
+		cmd.iova = *iova;
+
+	ret = ioctl(fd, IOMMU_IOAS_MAP, &cmd);
+	*iova = cmd.iova;
+	return ret;
+}
+#define test_ioctl_ioas_map(buffer, length, iova_p)                        \
+	ASSERT_EQ(0, _test_ioctl_ioas_map(self->fd, self->ioas_id, buffer, \
+					  length, iova_p,                  \
+					  IOMMU_IOAS_MAP_WRITEABLE |       \
+						  IOMMU_IOAS_MAP_READABLE))
+
+#define test_efault_ioctl_ioas_map(buffer, length, iova_p)                 \
+	EXPECT_ERRNO(EFAULT,                                               \
+		     _test_ioctl_ioas_map(self->fd, self->ioas_id, buffer, \
+					  length, iova_p,                  \
+					  IOMMU_IOAS_MAP_WRITEABLE |       \
+						  IOMMU_IOAS_MAP_READABLE))
+
+#define test_ioctl_ioas_map_id(ioas_id, buffer, length, iova_p)              \
+	ASSERT_EQ(0, _test_ioctl_ioas_map(self->fd, ioas_id, buffer, length, \
+					  iova_p,                            \
+					  IOMMU_IOAS_MAP_WRITEABLE |         \
+						  IOMMU_IOAS_MAP_READABLE))
+
+#define test_ioctl_ioas_map_fixed(buffer, length, iova)                       \
+	({                                                                    \
+		__u64 __iova = iova;                                          \
+		ASSERT_EQ(0, _test_ioctl_ioas_map(                            \
+				     self->fd, self->ioas_id, buffer, length, \
+				     &__iova,                                 \
+				     IOMMU_IOAS_MAP_FIXED_IOVA |              \
+					     IOMMU_IOAS_MAP_WRITEABLE |       \
+					     IOMMU_IOAS_MAP_READABLE));       \
+	})
+
+#define test_eaddrinuse_ioctl_ioas_map_fixed(buffer, length, iova)            \
+	({                                                                    \
+		__u64 __iova = iova;                                          \
+		EXPECT_ERRNO(EADDRINUSE,                                      \
+			     _test_ioctl_ioas_map(                            \
+				     self->fd, self->ioas_id, buffer, length, \
+				     &__iova,                                 \
+				     IOMMU_IOAS_MAP_FIXED_IOVA |              \
+					     IOMMU_IOAS_MAP_WRITEABLE |       \
+					     IOMMU_IOAS_MAP_READABLE));       \
+	})
+
+static int _test_ioctl_ioas_unmap(int fd, unsigned int ioas_id, uint64_t iova,
+				  size_t length, uint64_t *out_len)
+{
+	struct iommu_ioas_unmap cmd = {
+		.size = sizeof(cmd),
+		.ioas_id = ioas_id,
+		.iova = iova,
+		.length = length,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_IOAS_UNMAP, &cmd);
+	if (out_len)
+		*out_len = cmd.length;
+	return ret;
+}
+#define test_ioctl_ioas_unmap(iova, length)                                \
+	ASSERT_EQ(0, _test_ioctl_ioas_unmap(self->fd, self->ioas_id, iova, \
+					    length, NULL))
+
+#define test_enoent_ioctl_ioas_unmap(iova, length)                           \
+	EXPECT_ERRNO(ENOENT, _test_ioctl_ioas_unmap(self->fd, self->ioas_id, \
+						    iova, length, NULL))
+
+static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_MD_CHECK_REFS,
+		.check_refs = { .length = BUFFER_SIZE,
+				.uptr = (uintptr_t)buffer },
+	};
+
+	EXPECT_EQ(0, close(fd));
+
+	fd = open("/dev/iommu", O_RDWR);
+	EXPECT_NE(-1, fd);
+	EXPECT_EQ(0, ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_REFS),
+			   &test_cmd));
+	EXPECT_EQ(0, close(fd));
+}
+
+#define EXPECT_ERRNO(expected_errno, cmd)         \
+	({                                        \
+		ASSERT_EQ(-1, cmd);               \
+		EXPECT_EQ(expected_errno, errno); \
+	})
+
+FIXTURE(iommufd)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(iommufd)
+{
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+}
+
+FIXTURE_TEARDOWN(iommufd)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+TEST_F(iommufd, simple_close)
+{
+}
+
+TEST_F(iommufd, cmd_fail)
+{
+	struct iommu_destroy cmd = { .size = sizeof(cmd), .id = 0 };
+
+	/* object id is invalid */
+	EXPECT_ERRNO(ENOENT, _test_ioctl_destroy(self->fd, 0));
+	/* Bad pointer */
+	EXPECT_ERRNO(EFAULT, ioctl(self->fd, IOMMU_DESTROY, NULL));
+	/* Unknown ioctl */
+	EXPECT_ERRNO(ENOTTY,
+		     ioctl(self->fd, _IO(IOMMUFD_TYPE, IOMMUFD_CMD_BASE - 1),
+			   &cmd));
+}
+
+TEST_F(iommufd, cmd_ex_fail)
+{
+	struct {
+		struct iommu_destroy cmd;
+		__u64 future;
+	} cmd = { .cmd = { .size = sizeof(cmd), .id = 0 } };
+
+	/* object id is invalid and command is longer */
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_DESTROY, &cmd));
+	/* future area is non-zero */
+	cmd.future = 1;
+	EXPECT_ERRNO(E2BIG, ioctl(self->fd, IOMMU_DESTROY, &cmd));
+	/* Original command "works" */
+	cmd.cmd.size = sizeof(cmd.cmd);
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_DESTROY, &cmd));
+	/* Short command fails */
+	cmd.cmd.size = sizeof(cmd.cmd) - 1;
+	EXPECT_ERRNO(EOPNOTSUPP, ioctl(self->fd, IOMMU_DESTROY, &cmd));
+}
+
+TEST_F(iommufd, global_options)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_RLIMIT_MODE,
+		.op = IOMMU_OPTION_OP_GET,
+		.val64 = 1,
+	};
+
+	cmd.option_id = IOMMU_OPTION_RLIMIT_MODE;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(0, cmd.val64);
+
+	/* This requires root */
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 1;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	cmd.val64 = 2;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.op = IOMMU_OPTION_OP_GET;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(1, cmd.val64);
+
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 0;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.op = IOMMU_OPTION_OP_GET;
+	cmd.option_id = IOMMU_OPTION_HUGE_PAGES;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	cmd.op = IOMMU_OPTION_OP_SET;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_OPTION, &cmd));
+}
+
+FIXTURE(iommufd_ioas)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t domain_id;
+	uint64_t base_iova;
+};
+
+FIXTURE_VARIANT(iommufd_ioas)
+{
+	unsigned int mock_domains;
+	unsigned int memory_limit;
+};
+
+FIXTURE_SETUP(iommufd_ioas)
+{
+	struct iommu_test_cmd memlimit_cmd = {
+		.size = sizeof(memlimit_cmd),
+		.op = IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
+		.memory_limit = { .limit = variant->memory_limit },
+	};
+	unsigned int i;
+
+	if (!variant->memory_limit)
+		memlimit_cmd.memory_limit.limit = 65536;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+	test_ioctl_ioas_alloc(&self->ioas_id);
+
+	ASSERT_EQ(0, ioctl(self->fd,
+			   _IOMMU_TEST_CMD(IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT),
+			   &memlimit_cmd));
+
+	for (i = 0; i != variant->mock_domains; i++) {
+		struct iommu_test_cmd test_cmd = {
+			.size = sizeof(test_cmd),
+			.op = IOMMU_TEST_OP_MOCK_DOMAIN,
+			.id = self->ioas_id,
+		};
+
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MOCK_DOMAIN),
+				   &test_cmd));
+		EXPECT_NE(0, test_cmd.id);
+		self->domain_id = test_cmd.id;
+		self->base_iova = MOCK_APERTURE_START;
+	}
+}
+
+FIXTURE_TEARDOWN(iommufd_ioas)
+{
+	struct iommu_test_cmd memlimit_cmd = {
+		.size = sizeof(memlimit_cmd),
+		.op = IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
+		.memory_limit = { .limit = 65536 },
+	};
+
+	EXPECT_EQ(0, ioctl(self->fd,
+			   _IOMMU_TEST_CMD(IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT),
+			   &memlimit_cmd));
+	teardown_iommufd(self->fd, _metadata);
+}
+
+FIXTURE_VARIANT_ADD(iommufd_ioas, no_domain)
+{
+};
+
+FIXTURE_VARIANT_ADD(iommufd_ioas, mock_domain)
+{
+	.mock_domains = 1,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_ioas, two_mock_domain)
+{
+	.mock_domains = 2,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_ioas, mock_domain_limit)
+{
+	.mock_domains = 1,
+	.memory_limit = 16,
+};
+
+TEST_F(iommufd_ioas, ioas_auto_destroy)
+{
+}
+
+TEST_F(iommufd_ioas, ioas_destroy)
+{
+	if (self->domain_id) {
+		/* IOAS cannot be freed while a domain is on it */
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->ioas_id));
+	} else {
+		/* Can allocate and manually free an IOAS table */
+		test_ioctl_destroy(self->ioas_id);
+	}
+}
+
+TEST_F(iommufd_ioas, ioas_area_destroy)
+{
+	/* Adding an area does not change ability to destroy */
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, self->base_iova);
+	if (self->domain_id)
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->ioas_id));
+	else
+		test_ioctl_destroy(self->ioas_id);
+}
+
+TEST_F(iommufd_ioas, ioas_area_auto_destroy)
+{
+	int i;
+
+	/* Can allocate and automatically free an IOAS table with many areas */
+	for (i = 0; i != 10; i++) {
+		test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE,
+					  self->base_iova + i * PAGE_SIZE);
+	}
+}
+
+TEST_F(iommufd_ioas, area)
+{
+	int i;
+
+	/* Unmap fails if nothing is mapped */
+	for (i = 0; i != 10; i++)
+		test_enoent_ioctl_ioas_unmap(i * PAGE_SIZE, PAGE_SIZE);
+
+	/* Unmap works */
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE,
+					  self->base_iova + i * PAGE_SIZE);
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(self->base_iova + i * PAGE_SIZE,
+				      PAGE_SIZE);
+
+	/* Split fails */
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE * 2,
+				  self->base_iova + 16 * PAGE_SIZE);
+	test_enoent_ioctl_ioas_unmap(self->base_iova + 16 * PAGE_SIZE,
+				     PAGE_SIZE);
+	test_enoent_ioctl_ioas_unmap(self->base_iova + 17 * PAGE_SIZE,
+				     PAGE_SIZE);
+
+	/* Over map fails */
+	test_eaddrinuse_ioctl_ioas_map_fixed(buffer, PAGE_SIZE * 2,
+					     self->base_iova + 16 * PAGE_SIZE);
+	test_eaddrinuse_ioctl_ioas_map_fixed(buffer, PAGE_SIZE,
+					     self->base_iova + 16 * PAGE_SIZE);
+	test_eaddrinuse_ioctl_ioas_map_fixed(buffer, PAGE_SIZE,
+					     self->base_iova + 17 * PAGE_SIZE);
+	test_eaddrinuse_ioctl_ioas_map_fixed(buffer, PAGE_SIZE * 2,
+					     self->base_iova + 15 * PAGE_SIZE);
+	test_eaddrinuse_ioctl_ioas_map_fixed(buffer, PAGE_SIZE * 3,
+					     self->base_iova + 15 * PAGE_SIZE);
+
+	/* unmap all works */
+	test_ioctl_ioas_unmap(0, UINT64_MAX);
+}
+
+TEST_F(iommufd_ioas, unmap_fully_contained_areas)
+{
+	uint64_t unmap_len;
+	int i;
+
+	/* Give no_domain some space to rewind base_iova */
+	self->base_iova += 4 * PAGE_SIZE;
+
+	for (i = 0; i != 4; i++)
+		test_ioctl_ioas_map_fixed(buffer, 8 * PAGE_SIZE,
+					  self->base_iova + i * 16 * PAGE_SIZE);
+
+	/* Unmap not fully contained area doesn't work */
+	test_enoent_ioctl_ioas_unmap(self->base_iova - 4 * PAGE_SIZE,
+				     8 * PAGE_SIZE);
+	test_enoent_ioctl_ioas_unmap(self->base_iova + 3 * 16 * PAGE_SIZE +
+					     8 * PAGE_SIZE - 4 * PAGE_SIZE,
+				     8 * PAGE_SIZE);
+
+	/* Unmap fully contained areas works */
+	ASSERT_EQ(0, _test_ioctl_ioas_unmap(self->fd, self->ioas_id,
+					    self->base_iova - 4 * PAGE_SIZE,
+					    3 * 16 * PAGE_SIZE + 8 * PAGE_SIZE +
+						    4 * PAGE_SIZE,
+					    &unmap_len));
+	ASSERT_EQ(32 * PAGE_SIZE, unmap_len);
+}
+
+TEST_F(iommufd_ioas, area_auto_iova)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_ADD_RESERVED,
+		.id = self->ioas_id,
+		.add_reserved = { .start = PAGE_SIZE * 4,
+				  .length = PAGE_SIZE * 100 },
+	};
+	struct iommu_iova_range ranges[1] = {};
+	struct iommu_ioas_allow_iovas allow_cmd = {
+		.size = sizeof(allow_cmd),
+		.ioas_id = self->ioas_id,
+		.num_iovas = 1,
+		.allowed_iovas = (uintptr_t)ranges,
+	};
+	__u64 iovas[10];
+	int i;
+
+	/* Simple 4k pages */
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_map(buffer, PAGE_SIZE, &iovas[i]);
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE);
+
+	/* Kernel automatically aligns IOVAs properly */
+	for (i = 0; i != 10; i++) {
+		size_t length = PAGE_SIZE * (i + 1);
+
+		if (self->domain_id) {
+			test_ioctl_ioas_map(buffer, length, &iovas[i]);
+		} else {
+			test_ioctl_ioas_map((void *)(1UL << 31), length,
+					    &iovas[i]);
+		}
+		EXPECT_EQ(0, iovas[i] % (1UL << (ffs(length) - 1)));
+	}
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE * (i + 1));
+
+	/* Avoids a reserved region */
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			&test_cmd));
+	for (i = 0; i != 10; i++) {
+		size_t length = PAGE_SIZE * (i + 1);
+
+		test_ioctl_ioas_map(buffer, length, &iovas[i]);
+		EXPECT_EQ(0, iovas[i] % (1UL << (ffs(length) - 1)));
+		EXPECT_EQ(false,
+			  iovas[i] > test_cmd.add_reserved.start &&
+				  iovas[i] <
+					  test_cmd.add_reserved.start +
+						  test_cmd.add_reserved.length);
+	}
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE * (i + 1));
+
+	/* Allowed region intersects with a reserved region */
+	ranges[0].start = PAGE_SIZE;
+	ranges[0].last = PAGE_SIZE * 600;
+	EXPECT_ERRNO(EADDRINUSE,
+		     ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+
+	/* Allocate from an allowed region */
+	if (self->domain_id) {
+		ranges[0].start = MOCK_APERTURE_START + PAGE_SIZE;
+		ranges[0].last = MOCK_APERTURE_START + PAGE_SIZE * 600 - 1;
+	} else {
+		ranges[0].start = PAGE_SIZE * 200;
+		ranges[0].last = PAGE_SIZE * 600 - 1;
+	}
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+	for (i = 0; i != 10; i++) {
+		size_t length = PAGE_SIZE * (i + 1);
+
+		test_ioctl_ioas_map(buffer, length, &iovas[i]);
+		EXPECT_EQ(0, iovas[i] % (1UL << (ffs(length) - 1)));
+		EXPECT_EQ(true, iovas[i] >= ranges[0].start);
+		EXPECT_EQ(true, iovas[i] <= ranges[0].last);
+		EXPECT_EQ(true, iovas[i] + length > ranges[0].start);
+		EXPECT_EQ(true, iovas[i] + length <= ranges[0].last + 1);
+	}
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE * (i + 1));
+}
+
+TEST_F(iommufd_ioas, area_allowed)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_ADD_RESERVED,
+		.id = self->ioas_id,
+		.add_reserved = { .start = PAGE_SIZE * 4,
+				  .length = PAGE_SIZE * 100 },
+	};
+	struct iommu_iova_range ranges[1] = {};
+	struct iommu_ioas_allow_iovas allow_cmd = {
+		.size = sizeof(allow_cmd),
+		.ioas_id = self->ioas_id,
+		.num_iovas = 1,
+		.allowed_iovas = (uintptr_t)ranges,
+	};
+
+	/* Reserved intersects an allowed */
+	allow_cmd.num_iovas = 1;
+	ranges[0].start = self->base_iova;
+	ranges[0].last = ranges[0].start + PAGE_SIZE * 600;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+	test_cmd.add_reserved.start = ranges[0].start + PAGE_SIZE;
+	test_cmd.add_reserved.length = PAGE_SIZE;
+	EXPECT_ERRNO(EADDRINUSE,
+		     ioctl(self->fd,
+			   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			   &test_cmd));
+	allow_cmd.num_iovas = 0;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+
+	/* Allowed intersects a reserved */
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			&test_cmd));
+	allow_cmd.num_iovas = 1;
+	ranges[0].start = self->base_iova;
+	ranges[0].last = ranges[0].start + PAGE_SIZE * 600;
+	EXPECT_ERRNO(EADDRINUSE,
+		     ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+}
+
+TEST_F(iommufd_ioas, copy_area)
+{
+	struct iommu_ioas_copy copy_cmd = {
+		.size = sizeof(copy_cmd),
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA,
+		.dst_ioas_id = self->ioas_id,
+		.src_ioas_id = self->ioas_id,
+		.length = PAGE_SIZE,
+	};
+
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, self->base_iova);
+
+	/* Copy inside a single IOAS */
+	copy_cmd.src_iova = self->base_iova;
+	copy_cmd.dst_iova = self->base_iova + PAGE_SIZE;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+
+	/* Copy between IOAS's */
+	copy_cmd.src_iova = self->base_iova;
+	copy_cmd.dst_iova = 0;
+	test_ioctl_ioas_alloc(&copy_cmd.dst_ioas_id);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+}
+
+TEST_F(iommufd_ioas, iova_ranges)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_ADD_RESERVED,
+		.id = self->ioas_id,
+		.add_reserved = { .start = PAGE_SIZE, .length = PAGE_SIZE },
+	};
+	struct iommu_iova_range *ranges = buffer;
+	struct iommu_ioas_iova_ranges ranges_cmd = {
+		.size = sizeof(ranges_cmd),
+		.ioas_id = self->ioas_id,
+		.num_iovas = BUFFER_SIZE / sizeof(*ranges),
+		.allowed_iovas = (uint64_t)ranges,
+	};
+
+	/* Range can be read */
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
+	EXPECT_EQ(1, ranges_cmd.num_iovas);
+	if (!self->domain_id) {
+		EXPECT_EQ(0, ranges[0].start);
+		EXPECT_EQ(SIZE_MAX, ranges[0].last);
+		EXPECT_EQ(1, ranges_cmd.out_iova_alignment);
+	} else {
+		EXPECT_EQ(MOCK_APERTURE_START, ranges[0].start);
+		EXPECT_EQ(MOCK_APERTURE_LAST, ranges[0].last);
+		EXPECT_EQ(MOCK_PAGE_SIZE, ranges_cmd.out_iova_alignment);
+	}
+
+	/* Buffer too small */
+	memset(ranges, 0, BUFFER_SIZE);
+	ranges_cmd.num_iovas = 0;
+	EXPECT_ERRNO(EMSGSIZE,
+		     ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
+	EXPECT_EQ(1, ranges_cmd.num_iovas);
+	EXPECT_EQ(0, ranges[0].start);
+	EXPECT_EQ(0, ranges[0].last);
+
+	/* 2 ranges */
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			&test_cmd));
+	ranges_cmd.num_iovas = BUFFER_SIZE / sizeof(*ranges);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
+	if (!self->domain_id) {
+		EXPECT_EQ(2, ranges_cmd.num_iovas);
+		EXPECT_EQ(0, ranges[0].start);
+		EXPECT_EQ(PAGE_SIZE - 1, ranges[0].last);
+		EXPECT_EQ(PAGE_SIZE * 2, ranges[1].start);
+		EXPECT_EQ(SIZE_MAX, ranges[1].last);
+	} else {
+		EXPECT_EQ(1, ranges_cmd.num_iovas);
+		EXPECT_EQ(MOCK_APERTURE_START, ranges[0].start);
+		EXPECT_EQ(MOCK_APERTURE_LAST, ranges[0].last);
+	}
+
+	/* Buffer too small */
+	memset(ranges, 0, BUFFER_SIZE);
+	ranges_cmd.num_iovas = 1;
+	if (!self->domain_id) {
+		EXPECT_ERRNO(EMSGSIZE, ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES,
+					     &ranges_cmd));
+		EXPECT_EQ(2, ranges_cmd.num_iovas);
+		EXPECT_EQ(0, ranges[0].start);
+		EXPECT_EQ(PAGE_SIZE - 1, ranges[0].last);
+	} else {
+		ASSERT_EQ(0,
+			  ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
+		EXPECT_EQ(1, ranges_cmd.num_iovas);
+		EXPECT_EQ(MOCK_APERTURE_START, ranges[0].start);
+		EXPECT_EQ(MOCK_APERTURE_LAST, ranges[0].last);
+	}
+	EXPECT_EQ(0, ranges[1].start);
+	EXPECT_EQ(0, ranges[1].last);
+}
+
+TEST_F(iommufd_ioas, access)
+{
+	struct iommu_test_cmd access_cmd = {
+		.size = sizeof(access_cmd),
+		.op = IOMMU_TEST_OP_ACCESS_PAGES,
+		.access_pages = { .iova = MOCK_APERTURE_START,
+				  .length = BUFFER_SIZE,
+				  .uptr = (uintptr_t)buffer },
+	};
+	struct iommu_test_cmd mock_cmd = {
+		.size = sizeof(mock_cmd),
+		.op = IOMMU_TEST_OP_MOCK_DOMAIN,
+		.id = self->ioas_id,
+	};
+	struct iommu_test_cmd check_map_cmd = {
+		.size = sizeof(check_map_cmd),
+		.op = IOMMU_TEST_OP_MD_CHECK_MAP,
+		.check_map = { .iova = MOCK_APERTURE_START,
+			       .length = BUFFER_SIZE,
+			       .uptr = (uintptr_t)buffer },
+	};
+	uint32_t access_item_id;
+
+	test_cmd_create_access(self->ioas_id, &access_cmd.id);
+
+	/* Single map/unmap */
+	test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE, MOCK_APERTURE_START);
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+			&access_cmd));
+	test_cmd_destroy_access_item(
+		access_cmd.id, access_cmd.access_pages.out_access_item_id);
+
+	/* Double user */
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+			&access_cmd));
+	access_item_id = access_cmd.access_pages.out_access_item_id;
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+			&access_cmd));
+	test_cmd_destroy_access_item(
+		access_cmd.id, access_cmd.access_pages.out_access_item_id);
+	test_cmd_destroy_access_item(access_cmd.id, access_item_id);
+
+	/* Add/remove a domain with a user */
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+			&access_cmd));
+	ASSERT_EQ(0, ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_MOCK_DOMAIN),
+			   &mock_cmd));
+	check_map_cmd.id = mock_cmd.id;
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP),
+			&check_map_cmd));
+
+	test_ioctl_destroy(mock_cmd.mock_domain.device_id);
+	test_ioctl_destroy(mock_cmd.id);
+	test_cmd_destroy_access_item(
+		access_cmd.id, access_cmd.access_pages.out_access_item_id);
+	test_cmd_destroy_access(access_cmd.id);
+}
+
+static void check_access_rw(struct __test_metadata *_metadata, int fd,
+			    unsigned int access_id, uint64_t iova,
+			    unsigned int def_flags)
+{
+	uint16_t tmp[32];
+	struct iommu_test_cmd access_cmd = {
+		.size = sizeof(access_cmd),
+		.op = IOMMU_TEST_OP_ACCESS_RW,
+		.id = access_id,
+		.access_rw = { .uptr = (uintptr_t)tmp },
+	};
+	uint16_t *buffer16 = buffer;
+	unsigned int i;
+	void *tmp2;
+
+	for (i = 0; i != BUFFER_SIZE / sizeof(*buffer16); i++)
+		buffer16[i] = rand();
+
+	for (access_cmd.access_rw.iova = iova + PAGE_SIZE - 50;
+	     access_cmd.access_rw.iova < iova + PAGE_SIZE + 50;
+	     access_cmd.access_rw.iova++) {
+		for (access_cmd.access_rw.length = 1;
+		     access_cmd.access_rw.length < sizeof(tmp);
+		     access_cmd.access_rw.length++) {
+			access_cmd.access_rw.flags = def_flags;
+			ASSERT_EQ(0, ioctl(fd,
+					   _IOMMU_TEST_CMD(
+						   IOMMU_TEST_OP_ACCESS_RW),
+					   &access_cmd));
+			ASSERT_EQ(0,
+				  memcmp(buffer + (access_cmd.access_rw.iova -
+						   iova),
+					 tmp, access_cmd.access_rw.length));
+
+			for (i = 0; i != ARRAY_SIZE(tmp); i++)
+				tmp[i] = rand();
+			access_cmd.access_rw.flags = def_flags |
+						     MOCK_ACCESS_RW_WRITE;
+			ASSERT_EQ(0, ioctl(fd,
+					   _IOMMU_TEST_CMD(
+						   IOMMU_TEST_OP_ACCESS_RW),
+					   &access_cmd));
+			ASSERT_EQ(0,
+				  memcmp(buffer + (access_cmd.access_rw.iova -
+						   iova),
+					 tmp, access_cmd.access_rw.length));
+		}
+	}
+
+	/* Multi-page test */
+	tmp2 = malloc(BUFFER_SIZE);
+	ASSERT_NE(NULL, tmp2);
+	access_cmd.access_rw.iova = iova;
+	access_cmd.access_rw.length = BUFFER_SIZE;
+	access_cmd.access_rw.flags = def_flags;
+	access_cmd.access_rw.uptr = (uintptr_t)tmp2;
+	ASSERT_EQ(0, ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			   &access_cmd));
+	ASSERT_EQ(0, memcmp(buffer, tmp2, access_cmd.access_rw.length));
+	free(tmp2);
+}
+
+TEST_F(iommufd_ioas, access_rw)
+{
+	__u32 access_id;
+	__u64 iova;
+
+	test_cmd_create_access(self->ioas_id, &access_id);
+	test_ioctl_ioas_map(buffer, BUFFER_SIZE, &iova);
+	check_access_rw(_metadata, self->fd, access_id, iova, 0);
+	check_access_rw(_metadata, self->fd, access_id, iova,
+			MOCK_ACCESS_RW_SLOW_PATH);
+	test_ioctl_ioas_unmap(iova, BUFFER_SIZE);
+	test_cmd_destroy_access(access_id);
+}
+
+TEST_F(iommufd_ioas, access_rw_unaligned)
+{
+	__u32 access_id;
+	__u64 iova;
+
+	test_cmd_create_access(self->ioas_id, &access_id);
+
+	/* Unaligned pages */
+	iova = self->base_iova + MOCK_PAGE_SIZE;
+	test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE, iova);
+	check_access_rw(_metadata, self->fd, access_id, iova, 0);
+	test_ioctl_ioas_unmap(iova, BUFFER_SIZE);
+	test_cmd_destroy_access(access_id);
+}
+
+TEST_F(iommufd_ioas, fork_gone)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_MOCK_DOMAIN,
+		.id = self->ioas_id,
+	};
+	__u32 access_id;
+	pid_t child;
+
+	test_cmd_create_access(self->ioas_id, &access_id);
+
+	/* Create a mapping with a different mm */
+	child = fork();
+	if (!child) {
+		test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE,
+					  MOCK_APERTURE_START);
+		exit(0);
+	}
+	ASSERT_NE(-1, child);
+	ASSERT_EQ(child, waitpid(child, NULL, 0));
+
+	if (self->domain_id) {
+		/*
+		 * If a domain already existed then everything was pinned within
+		 * the fork, so this copies from one domain to another.
+		 */
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MOCK_DOMAIN),
+				   &test_cmd));
+		check_access_rw(_metadata, self->fd, access_id,
+				MOCK_APERTURE_START, 0);
+
+	} else {
+		/*
+		 * Otherwise we need to actually pin pages which can't happen
+		 * since the fork is gone.
+		 */
+		EXPECT_ERRNO(EFAULT,
+			     ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MOCK_DOMAIN),
+				   &test_cmd));
+	}
+
+	test_cmd_destroy_access(access_id);
+}
+
+TEST_F(iommufd_ioas, fork_present)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_MOCK_DOMAIN,
+		.id = self->ioas_id,
+	};
+	__u32 access_id;
+	int pipefds[2];
+	uint64_t tmp;
+	pid_t child;
+	int efd;
+
+	test_cmd_create_access(self->ioas_id, &access_id);
+
+	ASSERT_EQ(0, pipe2(pipefds, O_CLOEXEC));
+	efd = eventfd(0, EFD_CLOEXEC);
+	ASSERT_NE(-1, efd);
+
+	/* Create a mapping with a different mm */
+	child = fork();
+	if (!child) {
+		__u64 iova;
+		uint64_t one = 1;
+
+		close(pipefds[1]);
+		test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE,
+					  MOCK_APERTURE_START);
+		if (write(efd, &one, sizeof(one)) != sizeof(one))
+			exit(100);
+		if (read(pipefds[0], &iova, 1) != 1)
+			exit(100);
+		exit(0);
+	}
+	close(pipefds[0]);
+	ASSERT_NE(-1, child);
+	ASSERT_EQ(8, read(efd, &tmp, sizeof(tmp)));
+
+	/* Read pages from the remote process */
+	ASSERT_EQ(0, ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_MOCK_DOMAIN),
+			   &test_cmd));
+	check_access_rw(_metadata, self->fd, access_id, MOCK_APERTURE_START, 0);
+
+	ASSERT_EQ(0, close(pipefds[1]));
+	ASSERT_EQ(child, waitpid(child, NULL, 0));
+
+	test_cmd_destroy_access(access_id);
+}
+
+TEST_F(iommufd_ioas, ioas_option_huge_pages)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_HUGE_PAGES,
+		.op = IOMMU_OPTION_OP_GET,
+		.val64 = 3,
+		.object_id = self->ioas_id,
+	};
+
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(1, cmd.val64);
+
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 0;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.op = IOMMU_OPTION_OP_GET;
+	cmd.val64 = 3;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(0, cmd.val64);
+
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 2;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 1;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+}
+
+FIXTURE(iommufd_mock_domain)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t domain_id;
+	uint32_t domain_ids[2];
+	int mmap_flags;
+	size_t mmap_buf_size;
+};
+
+FIXTURE_VARIANT(iommufd_mock_domain)
+{
+	unsigned int mock_domains;
+	bool hugepages;
+};
+
+FIXTURE_SETUP(iommufd_mock_domain)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_MOCK_DOMAIN,
+	};
+	unsigned int i;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+	test_ioctl_ioas_alloc(&self->ioas_id);
+
+	ASSERT_GE(ARRAY_SIZE(self->domain_ids), variant->mock_domains);
+
+	for (i = 0; i != variant->mock_domains; i++) {
+		test_cmd.id = self->ioas_id;
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MOCK_DOMAIN),
+				   &test_cmd));
+		EXPECT_NE(0, test_cmd.id);
+		self->domain_ids[i] = test_cmd.id;
+	}
+	self->domain_id = self->domain_ids[0];
+
+	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
+	self->mmap_buf_size = PAGE_SIZE * 8;
+	if (variant->hugepages) {
+		/*
+		 * MAP_POPULATE will cause the kernel to fail mmap if THPs are
+		 * not available.
+		 */
+		self->mmap_flags |= MAP_HUGETLB | MAP_POPULATE;
+		self->mmap_buf_size = HUGEPAGE_SIZE * 2;
+	}
+}
+
+FIXTURE_TEARDOWN(iommufd_mock_domain)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain)
+{
+	.mock_domains = 1,
+	.hugepages = false,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains)
+{
+	.mock_domains = 2,
+	.hugepages = false,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_hugepage)
+{
+	.mock_domains = 1,
+	.hugepages = true,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains_hugepage)
+{
+	.mock_domains = 2,
+	.hugepages = true,
+};
+
+/* Have the kernel check that the user pages made it to the iommu_domain */
+#define check_mock_iova(_ptr, _iova, _length)                                \
+	({                                                                   \
+		struct iommu_test_cmd check_map_cmd = {                      \
+			.size = sizeof(check_map_cmd),                       \
+			.op = IOMMU_TEST_OP_MD_CHECK_MAP,                    \
+			.id = self->domain_id,                               \
+			.check_map = { .iova = _iova,                        \
+				       .length = _length,                    \
+				       .uptr = (uintptr_t)(_ptr) },          \
+		};                                                           \
+		ASSERT_EQ(0,                                                 \
+			  ioctl(self->fd,                                    \
+				_IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP), \
+				&check_map_cmd));                            \
+		if (self->domain_ids[1]) {                                   \
+			check_map_cmd.id = self->domain_ids[1];              \
+			ASSERT_EQ(0,                                         \
+				  ioctl(self->fd,                            \
+					_IOMMU_TEST_CMD(                     \
+						IOMMU_TEST_OP_MD_CHECK_MAP), \
+					&check_map_cmd));                    \
+		}                                                            \
+	})
+
+TEST_F(iommufd_mock_domain, basic)
+{
+	size_t buf_size = self->mmap_buf_size;
+	uint8_t *buf;
+	__u64 iova;
+
+	/* Simple one page map */
+	test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
+	check_mock_iova(buffer, iova, PAGE_SIZE);
+
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+
+	/* EFAULT half way through mapping */
+	ASSERT_EQ(0, munmap(buf + buf_size / 2, buf_size / 2));
+	test_efault_ioctl_ioas_map(buf, buf_size, &iova);
+
+	/* EFAULT on first page */
+	ASSERT_EQ(0, munmap(buf, buf_size / 2));
+	test_efault_ioctl_ioas_map(buf, buf_size, &iova);
+}
+
+TEST_F(iommufd_mock_domain, all_aligns)
+{
+	size_t test_step = variant->hugepages ? (self->mmap_buf_size / 16) :
+						MOCK_PAGE_SIZE;
+	size_t buf_size = self->mmap_buf_size;
+	unsigned int start;
+	unsigned int end;
+	uint8_t *buf;
+
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+	check_refs(buf, buf_size, 0);
+
+	/*
+	 * Map every combination of page size and alignment within a big region,
+	 * less for hugepage case as it takes so long to finish.
+	 */
+	for (start = 0; start < buf_size; start += test_step) {
+		if (variant->hugepages)
+			end = buf_size;
+		else
+			end = start + MOCK_PAGE_SIZE;
+		for (; end < buf_size; end += MOCK_PAGE_SIZE) {
+			size_t length = end - start;
+			__u64 iova;
+
+			test_ioctl_ioas_map(buf + start, length, &iova);
+			check_mock_iova(buf + start, iova, length);
+			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
+				   end / PAGE_SIZE * PAGE_SIZE -
+					   start / PAGE_SIZE * PAGE_SIZE,
+				   1);
+
+			test_ioctl_ioas_unmap(iova, length);
+		}
+	}
+	check_refs(buf, buf_size, 0);
+	ASSERT_EQ(0, munmap(buf, buf_size));
+}
+
+TEST_F(iommufd_mock_domain, all_aligns_copy)
+{
+	struct iommu_test_cmd add_mock_pt = {
+		.size = sizeof(add_mock_pt),
+		.op = IOMMU_TEST_OP_MOCK_DOMAIN,
+	};
+	size_t test_step = variant->hugepages ? self->mmap_buf_size / 16 :
+						MOCK_PAGE_SIZE;
+	size_t buf_size = self->mmap_buf_size;
+	unsigned int start;
+	unsigned int end;
+	uint8_t *buf;
+
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+	check_refs(buf, buf_size, 0);
+
+	/*
+	 * Map every combination of page size and alignment within a big region,
+	 * less for hugepage case as it takes so long to finish.
+	 */
+	for (start = 0; start < buf_size; start += test_step) {
+		if (variant->hugepages)
+			end = buf_size;
+		else
+			end = start + MOCK_PAGE_SIZE;
+		for (; end < buf_size; end += MOCK_PAGE_SIZE) {
+			size_t length = end - start;
+			unsigned int old_id;
+			__u64 iova;
+
+			test_ioctl_ioas_map(buf + start, length, &iova);
+
+			/* Add and destroy a domain while the area exists */
+			add_mock_pt.id = self->ioas_id;
+			ASSERT_EQ(0, ioctl(self->fd,
+					   _IOMMU_TEST_CMD(
+						   IOMMU_TEST_OP_MOCK_DOMAIN),
+					   &add_mock_pt));
+			old_id = self->domain_ids[1];
+			self->domain_ids[1] = add_mock_pt.id;
+
+			check_mock_iova(buf + start, iova, length);
+			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
+				   end / PAGE_SIZE * PAGE_SIZE -
+					   start / PAGE_SIZE * PAGE_SIZE,
+				   1);
+
+			test_ioctl_destroy(add_mock_pt.mock_domain.device_id);
+			test_ioctl_destroy(add_mock_pt.id)
+				self->domain_ids[1] = old_id;
+
+			test_ioctl_ioas_unmap(iova, length);
+		}
+	}
+	check_refs(buf, buf_size, 0);
+	ASSERT_EQ(0, munmap(buf, buf_size));
+}
+
+TEST_F(iommufd_mock_domain, user_copy)
+{
+	struct iommu_test_cmd access_cmd = {
+		.size = sizeof(access_cmd),
+		.op = IOMMU_TEST_OP_ACCESS_PAGES,
+		.access_pages = { .length = BUFFER_SIZE,
+				  .uptr = (uintptr_t)buffer },
+	};
+	struct iommu_ioas_copy copy_cmd = {
+		.size = sizeof(copy_cmd),
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA,
+		.dst_ioas_id = self->ioas_id,
+		.dst_iova = MOCK_APERTURE_START,
+		.length = BUFFER_SIZE,
+	};
+	unsigned int ioas_id;
+
+	/* Pin the pages in an IOAS with no domains then copy to an IOAS with domains */
+	test_ioctl_ioas_alloc(&ioas_id);
+	test_ioctl_ioas_map_id(ioas_id, buffer, BUFFER_SIZE,
+			       &copy_cmd.src_iova);
+
+	test_cmd_create_access(ioas_id, &access_cmd.id);
+
+	access_cmd.access_pages.iova = copy_cmd.src_iova;
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+			&access_cmd));
+	copy_cmd.src_ioas_id = ioas_id;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
+
+	test_cmd_destroy_access_item(
+		access_cmd.id, access_cmd.access_pages.out_access_item_id);
+	test_cmd_destroy_access(access_cmd.id) test_ioctl_destroy(ioas_id);
+}
+
+/* VFIO compatibility IOCTLs */
+
+TEST_F(iommufd, simple_ioctls)
+{
+	ASSERT_EQ(VFIO_API_VERSION, ioctl(self->fd, VFIO_GET_API_VERSION));
+	ASSERT_EQ(1, ioctl(self->fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU));
+}
+
+TEST_F(iommufd, unmap_cmd)
+{
+	struct vfio_iommu_type1_dma_unmap unmap_cmd = {
+		.iova = MOCK_APERTURE_START,
+		.size = PAGE_SIZE,
+	};
+
+	unmap_cmd.argsz = 1;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+
+	unmap_cmd.argsz = sizeof(unmap_cmd);
+	unmap_cmd.flags = 1 << 31;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+
+	unmap_cmd.flags = 0;
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+}
+
+TEST_F(iommufd, map_cmd)
+{
+	struct vfio_iommu_type1_dma_map map_cmd = {
+		.iova = MOCK_APERTURE_START,
+		.size = PAGE_SIZE,
+		.vaddr = (__u64)buffer,
+	};
+
+	map_cmd.argsz = 1;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+
+	map_cmd.argsz = sizeof(map_cmd);
+	map_cmd.flags = 1 << 31;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+
+	/* Requires a domain to be attached */
+	map_cmd.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+}
+
+TEST_F(iommufd, info_cmd)
+{
+	struct vfio_iommu_type1_info info_cmd = {};
+
+	/* Invalid argsz */
+	info_cmd.argsz = 1;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_GET_INFO, &info_cmd));
+
+	info_cmd.argsz = sizeof(info_cmd);
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, VFIO_IOMMU_GET_INFO, &info_cmd));
+}
+
+TEST_F(iommufd, set_iommu_cmd)
+{
+	/* Requires a domain to be attached */
+	EXPECT_ERRNO(ENODEV,
+		     ioctl(self->fd, VFIO_SET_IOMMU, VFIO_TYPE1v2_IOMMU));
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU));
+}
+
+TEST_F(iommufd, vfio_ioas)
+{
+	struct iommu_vfio_ioas vfio_ioas_cmd = {
+		.size = sizeof(vfio_ioas_cmd),
+		.op = IOMMU_VFIO_IOAS_GET,
+	};
+	__u32 ioas_id;
+
+	/* ENODEV if there is no compat ioas */
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+
+	/* Invalid id for set */
+	vfio_ioas_cmd.op = IOMMU_VFIO_IOAS_SET;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+
+	/* Valid id for set*/
+	test_ioctl_ioas_alloc(&ioas_id);
+	vfio_ioas_cmd.ioas_id = ioas_id;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+
+	/* Same id comes back from get */
+	vfio_ioas_cmd.op = IOMMU_VFIO_IOAS_GET;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+	ASSERT_EQ(ioas_id, vfio_ioas_cmd.ioas_id);
+
+	/* Clear works */
+	vfio_ioas_cmd.op = IOMMU_VFIO_IOAS_CLEAR;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+	vfio_ioas_cmd.op = IOMMU_VFIO_IOAS_GET;
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+}
+
+FIXTURE(vfio_compat_mock_domain)
+{
+	int fd;
+	uint32_t ioas_id;
+};
+
+FIXTURE_VARIANT(vfio_compat_mock_domain)
+{
+	unsigned int version;
+};
+
+FIXTURE_SETUP(vfio_compat_mock_domain)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_MOCK_DOMAIN,
+	};
+	struct iommu_vfio_ioas vfio_ioas_cmd = {
+		.size = sizeof(vfio_ioas_cmd),
+		.op = IOMMU_VFIO_IOAS_SET,
+	};
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+
+	/* Create what VFIO would consider a group */
+	test_ioctl_ioas_alloc(&self->ioas_id);
+	test_cmd.id = self->ioas_id;
+	ASSERT_EQ(0, ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_MOCK_DOMAIN),
+			   &test_cmd));
+	EXPECT_NE(0, test_cmd.id);
+
+	/* Attach it to the vfio compat */
+	vfio_ioas_cmd.ioas_id = self->ioas_id;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_SET_IOMMU, variant->version));
+}
+
+FIXTURE_TEARDOWN(vfio_compat_mock_domain)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+FIXTURE_VARIANT_ADD(vfio_compat_mock_domain, Ver1v2)
+{
+	.version = VFIO_TYPE1v2_IOMMU,
+};
+
+FIXTURE_VARIANT_ADD(vfio_compat_mock_domain, Ver1v0)
+{
+	.version = VFIO_TYPE1_IOMMU,
+};
+
+TEST_F(vfio_compat_mock_domain, simple_close)
+{
+}
+
+TEST_F(vfio_compat_mock_domain, option_huge_pages)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_HUGE_PAGES,
+		.op = IOMMU_OPTION_OP_GET,
+		.val64 = 3,
+		.object_id = self->ioas_id,
+	};
+
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	if (variant->version == VFIO_TYPE1_IOMMU) {
+		ASSERT_EQ(0, cmd.val64);
+	} else {
+		ASSERT_EQ(1, cmd.val64);
+	}
+}
+
+/*
+ * Execute an ioctl command stored in buffer and check that the result does not
+ * overflow memory.
+ */
+static bool is_filled(const void *buf, uint8_t c, size_t len)
+{
+	const uint8_t *cbuf = buf;
+
+	for (; len; cbuf++, len--)
+		if (*cbuf != c)
+			return false;
+	return true;
+}
+
+#define ioctl_check_buf(fd, cmd)                                         \
+	({                                                               \
+		size_t _cmd_len = *(__u32 *)buffer;                      \
+									 \
+		memset(buffer + _cmd_len, 0xAA, BUFFER_SIZE - _cmd_len); \
+		ASSERT_EQ(0, ioctl(fd, cmd, buffer));                    \
+		ASSERT_EQ(true, is_filled(buffer + _cmd_len, 0xAA,       \
+					  BUFFER_SIZE - _cmd_len));      \
+	})
+
+static void check_vfio_info_cap_chain(struct __test_metadata *_metadata,
+				      struct vfio_iommu_type1_info *info_cmd)
+{
+	const struct vfio_info_cap_header *cap;
+
+	ASSERT_GE(info_cmd->argsz, info_cmd->cap_offset + sizeof(*cap));
+	cap = buffer + info_cmd->cap_offset;
+	while (true) {
+		size_t cap_size;
+
+		if (cap->next)
+			cap_size = (buffer + cap->next) - (void *)cap;
+		else
+			cap_size = (buffer + info_cmd->argsz) - (void *)cap;
+
+		switch (cap->id) {
+		case VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE: {
+			struct vfio_iommu_type1_info_cap_iova_range *data =
+				(void *)cap;
+
+			ASSERT_EQ(1, data->header.version);
+			ASSERT_EQ(1, data->nr_iovas);
+			EXPECT_EQ(MOCK_APERTURE_START,
+				  data->iova_ranges[0].start);
+			EXPECT_EQ(MOCK_APERTURE_LAST, data->iova_ranges[0].end);
+			break;
+		}
+		case VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL: {
+			struct vfio_iommu_type1_info_dma_avail *data =
+				(void *)cap;
+
+			ASSERT_EQ(1, data->header.version);
+			ASSERT_EQ(sizeof(*data), cap_size);
+			break;
+		}
+		default:
+			ASSERT_EQ(false, true);
+			break;
+		}
+		if (!cap->next)
+			break;
+
+		ASSERT_GE(info_cmd->argsz, cap->next + sizeof(*cap));
+		ASSERT_GE(buffer + cap->next, (void *)cap);
+		cap = buffer + cap->next;
+	}
+}
+
+TEST_F(vfio_compat_mock_domain, get_info)
+{
+	struct vfio_iommu_type1_info *info_cmd = buffer;
+	unsigned int i;
+	size_t caplen;
+
+	/* Pre-cap ABI */
+	*info_cmd = (struct vfio_iommu_type1_info){
+		.argsz = offsetof(struct vfio_iommu_type1_info, cap_offset),
+	};
+	ioctl_check_buf(self->fd, VFIO_IOMMU_GET_INFO);
+	ASSERT_NE(0, info_cmd->iova_pgsizes);
+	ASSERT_EQ(VFIO_IOMMU_INFO_PGSIZES | VFIO_IOMMU_INFO_CAPS,
+		  info_cmd->flags);
+
+	/* Read the cap chain size */
+	*info_cmd = (struct vfio_iommu_type1_info){
+		.argsz = sizeof(*info_cmd),
+	};
+	ioctl_check_buf(self->fd, VFIO_IOMMU_GET_INFO);
+	ASSERT_NE(0, info_cmd->iova_pgsizes);
+	ASSERT_EQ(VFIO_IOMMU_INFO_PGSIZES | VFIO_IOMMU_INFO_CAPS,
+		  info_cmd->flags);
+	ASSERT_EQ(0, info_cmd->cap_offset);
+	ASSERT_LT(sizeof(*info_cmd), info_cmd->argsz);
+
+	/* Read the caps, kernel should never create a corrupted caps */
+	caplen = info_cmd->argsz;
+	for (i = sizeof(*info_cmd); i < caplen; i++) {
+		*info_cmd = (struct vfio_iommu_type1_info){
+			.argsz = i,
+		};
+		ioctl_check_buf(self->fd, VFIO_IOMMU_GET_INFO);
+		ASSERT_EQ(VFIO_IOMMU_INFO_PGSIZES | VFIO_IOMMU_INFO_CAPS,
+			  info_cmd->flags);
+		if (!info_cmd->cap_offset)
+			continue;
+		check_vfio_info_cap_chain(_metadata, info_cmd);
+	}
+}
+
+static void shuffle_array(unsigned long *array, size_t nelms)
+{
+	unsigned int i;
+
+	/* Shuffle */
+	for (i = 0; i != nelms; i++) {
+		unsigned long tmp = array[i];
+		unsigned int other = rand() % (nelms - i);
+
+		array[i] = array[other];
+		array[other] = tmp;
+	}
+}
+
+TEST_F(vfio_compat_mock_domain, map)
+{
+	struct vfio_iommu_type1_dma_map map_cmd = {
+		.argsz = sizeof(map_cmd),
+		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
+		.vaddr = (uintptr_t)buffer,
+		.size = BUFFER_SIZE,
+		.iova = MOCK_APERTURE_START,
+	};
+	struct vfio_iommu_type1_dma_unmap unmap_cmd = {
+		.argsz = sizeof(unmap_cmd),
+		.size = BUFFER_SIZE,
+		.iova = MOCK_APERTURE_START,
+	};
+	unsigned long pages_iova[BUFFER_SIZE / PAGE_SIZE];
+	unsigned int i;
+
+	/* Simple map/unmap */
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+	ASSERT_EQ(BUFFER_SIZE, unmap_cmd.size);
+
+	/* UNMAP_FLAG_ALL requres 0 iova/size */
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+	unmap_cmd.flags = VFIO_DMA_UNMAP_FLAG_ALL;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+
+	unmap_cmd.iova = 0;
+	unmap_cmd.size = 0;
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+	ASSERT_EQ(BUFFER_SIZE, unmap_cmd.size);
+
+	/* Small pages */
+	for (i = 0; i != ARRAY_SIZE(pages_iova); i++) {
+		map_cmd.iova = pages_iova[i] =
+			MOCK_APERTURE_START + i * PAGE_SIZE;
+		map_cmd.vaddr = (uintptr_t)buffer + i * PAGE_SIZE;
+		map_cmd.size = PAGE_SIZE;
+		ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+	}
+	shuffle_array(pages_iova, ARRAY_SIZE(pages_iova));
+
+	unmap_cmd.flags = 0;
+	unmap_cmd.size = PAGE_SIZE;
+	for (i = 0; i != ARRAY_SIZE(pages_iova); i++) {
+		unmap_cmd.iova = pages_iova[i];
+		ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+	}
+}
+
+TEST_F(vfio_compat_mock_domain, huge_map)
+{
+	size_t buf_size = HUGEPAGE_SIZE * 2;
+	struct vfio_iommu_type1_dma_map map_cmd = {
+		.argsz = sizeof(map_cmd),
+		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
+		.size = buf_size,
+		.iova = MOCK_APERTURE_START,
+	};
+	struct vfio_iommu_type1_dma_unmap unmap_cmd = {
+		.argsz = sizeof(unmap_cmd),
+	};
+	unsigned long pages_iova[16];
+	unsigned int i;
+	void *buf;
+
+	/* Test huge pages and splitting */
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB | MAP_POPULATE, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+	map_cmd.vaddr = (uintptr_t)buf;
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+
+	unmap_cmd.size = buf_size / ARRAY_SIZE(pages_iova);
+	for (i = 0; i != ARRAY_SIZE(pages_iova); i++)
+		pages_iova[i] = MOCK_APERTURE_START + (i * unmap_cmd.size);
+	shuffle_array(pages_iova, ARRAY_SIZE(pages_iova));
+
+	/* type1 mode can cut up larger mappings, type1v2 always fails */
+	for (i = 0; i != ARRAY_SIZE(pages_iova); i++) {
+		unmap_cmd.iova = pages_iova[i];
+		unmap_cmd.size = buf_size / ARRAY_SIZE(pages_iova);
+		if (variant->version == VFIO_TYPE1_IOMMU) {
+			ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA,
+					   &unmap_cmd));
+		} else {
+			EXPECT_ERRNO(ENOENT,
+				     ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA,
+					   &unmap_cmd));
+		}
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.38.0


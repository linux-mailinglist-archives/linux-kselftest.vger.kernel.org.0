Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4033062CC13
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbiKPVDK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiKPVCH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:07 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC6A6AED7;
        Wed, 16 Nov 2022 13:01:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4GWUMJLcO8oGbWCK6rvrh5/Agp5Gzm/0ulKCqZOToXZchLXQwxuxAgNLon6epRpfJjpia0chWCWtTS15CmGe4CI1kqRds00QCketG+exUveqPaYCmXvbmKnhU50jO4LJbxx6F4i5gAG/S2og3aiFW0KqC2/+pEUmdaRy9mnWuXbubSceqYQt9Ad/dFbpE+AAT9km7y8IBMPyiNccPDt0ACOUELuVSC0JIQdhC5kgavTMiXS1JQ5P9pb0ef9bikav+N0uGgLVdOdLF2Npuvy7hRE5GJka4+nCOYJgj87OwHaCiic1W+v0kPY5VBzNXxxWD1BPRHFmYnecGxxcceTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmmsmea8Zyev5TPHahprQ5Twc7knH3ZdY/xIgAygGCA=;
 b=HNQc8ffI+s543bYyBuNa4Z7a377aQO4VIJcG1n88kP2gcnR+VZaJ1AIKJ929SZo6AVTbKWh/VZWo2dA/AVsR7sdfcXeclfinuECaTWmIHhyvGZIvM7/my3+IiiXDDwoYV1wu9X4JBGAnzCkVQ30J6bb5B2XbygHvvC+mTMYr5Zxau+ejdU2jjxfLCY5ggSXWK8RZlNncskWnXKz9IZ2qW6rYl+6syaNfyGhjrOGd8N/anNlu1Vm739bANjnUgSJ+1STlJMUgmgwiFxKteDPjBeTUhI7p0w1Z4orV3TyXVjtELfBi2vXUOXhJ5erirv24DaVnu/Pbst6QrWJ66YOWcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmmsmea8Zyev5TPHahprQ5Twc7knH3ZdY/xIgAygGCA=;
 b=BbedqgCU6ngYgKcMonIVP+sVu9x2CoKKd1Rcu16G0gqA9WusBHU6W/SH7Sa5Ey2fwjW04cHLngUoN2WIWBouA4k3mW6w4ofsgZ2QwzIB6gHQewZS+mctCiZfO6KN6D6jmMl8I16AM5tPsNWaLPH9ykPKNRn59PbNhHtZ5o3q5WkxKgRMxzVp0XLGzFJ3h+XCItssRuSysPsvJHZaHLdk67oTMpW+AIfqj0f4DjUKMyScqpksIzx5w7bgLdcREJj/ISe0E2LJZ0+X9eOzMsM1pz4kAUPIHNv/glmgym+fWGwVxkd0/UtFU2lw2vOWYrzXW2tMJgB4Vr8TtHVO11pGjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:01:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:01:04 +0000
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
Subject: [PATCH v5 01/19] iommu: Add IOMMU_CAP_ENFORCE_CACHE_COHERENCY
Date:   Wed, 16 Nov 2022 17:00:37 -0400
Message-Id: <1-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f072615-b834-46e2-dd58-08dac815a9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJ5pfMikALZwYO/Ba+2qxrfQCrpPpgfTi81j/x9rRabjLMks2YOcaK6mNSiVIPCIaazsTcNZ8lNaO6mVqsRk7DINLtt7uu57IXTX6RZX4aYJoqSRe4opCEERA2e3fNfMZiHtiJNojLD3aYqkjt7tTuyuWp4W2/FXniKm2cyCeZN4s412R2WzCDCHM1f+Mr2pvOBvldca2+13FLmiCYtqPqnlCQx0TOLTqaGBl5kg9uIcjE6ogmJ6uUHOiLiMxkLivLhw1EQyXFzwWbWg2eiG8aRBJjDCJ+LYhZUAHxm4MeX5z9FvcVb3c7FkkyPXX7kJELkn9xY+q+qvpgyQMuzQ9mxLXAMb8XEbAc3PiHyBQ20DhDlJId4U01lfGFvxCY7YrMY3gg2ZnCWYXEMgxepE/o0kWZIqteY9RZNYWYHy+Ksi/EWOG0fevMHgdaSxfo+otJ7ZqpIzDmgvw+4+vaB5drr95UxJGohIkK4iCkb6oMBBPPkFcuKm4q/QU2hGcEyFnoHrdntKPZyKKzDT9TxfrhUfCvhMPY4RQ1rNoVLL01XIU/ncTWtprYnY/SufNw0mypeaQsuAO5cE8LMSoFzZoae9oXlt1Qvquzr6rHulylqJSyFyilZrHN1cNQMNY/K4hEU9+VPP33O6tapa5nZhpuuaRZOgR/r1uBhZcyjundFi1zRcBQnNN/CTq+Yux9TONNbKmwgHQjfWb6iHBqAsCHqdSaGmjPJFUUa+w8R5Vp5vK337jenwV9aI5mj1CLClH2CMLsSLnMQRaXM8v/kwlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(36756003)(41300700001)(4326008)(8676002)(66556008)(6486002)(186003)(66476007)(86362001)(66946007)(2616005)(478600001)(26005)(316002)(6666004)(110136005)(54906003)(6506007)(921005)(6512007)(83380400001)(2906002)(7406005)(7416002)(8936002)(5660300002)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4lhDlAi+aZ/Q3Avj0eiYxz9Br5gCo0KJGNl+Ny4DZ+jyCxYW09GNSAb6yfkw?=
 =?us-ascii?Q?YrgGKRoJBMNZAOJfmXZ/39cxr1LI7kvJEr4uBgJ1ZCqSdTPZ6o6RPvrUxlT9?=
 =?us-ascii?Q?ePKeq/k3a4XVh6158R7XVEhIcfvTcmnJNuU0hOJr8JsEM4l45VdsKpi9620e?=
 =?us-ascii?Q?5Ec64apRNoPczX/Cax56xmD4OBEXb0cCqEokzun+C3fVRrdgKZhi0em2SAbB?=
 =?us-ascii?Q?5Bnzk/yehD5hKmmnvReg+n3+V2It2DTUhOmXHLAct+MNMNpk0IX58TUfz9G9?=
 =?us-ascii?Q?ezqEAGB7f6Z6ZRVnaV1VXP/21ElaVYR3yVmYmMj7+7+WTYWbSp5GA3GFirpQ?=
 =?us-ascii?Q?LQdKdgEe+H5r7d4IpMz3zjLaiEDAxTQTGmYOzgn+wfFHGgd8PPaoJUd7B+qg?=
 =?us-ascii?Q?xGUHNUzyQX3n3mAdhGXXTCp89xUZ1I4rLMsgnK9UKclDXonKdyMY3+3ZOSww?=
 =?us-ascii?Q?BZTQyBPReSKNl7E8eCbqH7Ynfl9Q+eR+wq4TvGX3pNmZHewTef+ie+Fe1mtT?=
 =?us-ascii?Q?gRhOOYY8WtzI/JBiop+jK04sBs1mMwaDUej/X3OuDmmxLqoynH3CdO5vUHvf?=
 =?us-ascii?Q?XsjYiuoI8rSsjl4sfHe9vVQMBpcUX4l3vnEUnpEb7mIwdTDk3rW21YmwO664?=
 =?us-ascii?Q?s3DSASRlOloXPAMSxdKRBJtGVQxWCMgCL4N+Osj2amOv3fAZisj9S+uc+xe/?=
 =?us-ascii?Q?ndyLLMKrTNpbz0+RNHiB2+eaNq0cPO4UdheWCsvZeSklkLFetEyIzKRFCNYx?=
 =?us-ascii?Q?hfUHbHSLc1l2i41yyKvY0cTlx8hKVknqjt0OgpiaYwI4ZNvU//RJm61gKRLU?=
 =?us-ascii?Q?7Y2t1q4szYu5P1J6DtZHM8YpFivFhQUDYR7UAtG/uIz6hXI7VIUN16q9i5oM?=
 =?us-ascii?Q?cE3yxN3U3O7qD1tuewAtSEGnVB1RUswiqtcUmnLF1O4RfHeGVjFVXoffWKnB?=
 =?us-ascii?Q?SLgLjxroefphMCJ1TLMBXTkpDjDkT6dPKxv5EE0rIE2M/Lj5me8IyZtEK9XI?=
 =?us-ascii?Q?CDNp94TtOdKTjTuzES3cHIGgS/XEaMAhNxKvj+kMhC4m77uu14Gy5XG9eu9+?=
 =?us-ascii?Q?Wtjpce7OYUaNOeVpb7GsIfcxjlS06zTZjZieZ2uis69yTNZfwXM5CKjFDzTk?=
 =?us-ascii?Q?gkVU/MLL/BPvZXIfiIyYs54BaoKvDuVQMhfhXrz3bSyD7nsW9OrCD3LitLsN?=
 =?us-ascii?Q?RaxreIQnmwYKMaOPDJt9KpGNzz2OX7GQBEE3Ju5X4YvZSSqeVF8Pg5bk0XHc?=
 =?us-ascii?Q?VTSyp9LQ/PhxhFbH+BN4P4xUCphM2tyLbtPoiFmfTQE5MixCxuQ3Int05cHG?=
 =?us-ascii?Q?H9BBqaAFTomGgeJ8DSuDGqFC1BVnouDnOMrJ51KL5ZO01qkMzl+4j6yaxZz0?=
 =?us-ascii?Q?vtxNGOR9DMIsL7ePbWwyQLspjwkeKBO1uSR467B8FWF5JL68CnHkBElKicMa?=
 =?us-ascii?Q?uRl+CYHFG86lFRdrZOK2x0c1UYrEv048z9eVEc6bCAB/0UWfUFYyZ4UnNIPC?=
 =?us-ascii?Q?eedLCTeXhfXe542Q9BT2hxfwWA27I2VePLMQlh5rYVx0zFmsPgn+Zjh8DIgF?=
 =?us-ascii?Q?E9UQ4wCfdZqRUsfd/dY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f072615-b834-46e2-dd58-08dac815a9da
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:59.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcnOxbvzt3HOrZWyBDfqvH6vdeBnjwZDGJ+W3ckvA4TnmIoz9ye9n04hdm8jjhSb
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

This queries if a domain linked to a device should expect to support
enforce_cache_coherency() so iommufd can negotiate the rules for when a
domain should be shared or not.

For iommufd a device that declares IOMMU_CAP_ENFORCE_CACHE_COHERENCY will
not be attached to a domain that does not support it.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Lixiao Yang <lixiao.yang@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c   |  2 ++
 drivers/iommu/intel/iommu.c | 16 +++++++++++-----
 include/linux/iommu.h       |  5 +++++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 45299eb7e8e306..240c535e317cc7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2278,6 +2278,8 @@ static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 		return false;
 	case IOMMU_CAP_PRE_BOOT_PROTECTION:
 		return amdr_ivrs_remap_support;
+	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
+		return true;
 	default:
 		break;
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f298e51d5aa67a..157c9727411076 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4450,14 +4450,20 @@ static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 
 static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
-	if (cap == IOMMU_CAP_CACHE_COHERENCY)
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
 		return true;
-	if (cap == IOMMU_CAP_INTR_REMAP)
+	case IOMMU_CAP_INTR_REMAP:
 		return irq_remapping_enabled == 1;
-	if (cap == IOMMU_CAP_PRE_BOOT_PROTECTION)
+	case IOMMU_CAP_PRE_BOOT_PROTECTION:
 		return dmar_platform_optin();
-
-	return false;
+	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
+		return ecap_sc_support(info->iommu->ecap);
+	default:
+		return false;
+	}
 }
 
 static struct iommu_device *intel_iommu_probe_device(struct device *dev)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 68d7d304cdb761..a09fd32d8cc273 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -124,6 +124,11 @@ enum iommu_cap {
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
 	IOMMU_CAP_PRE_BOOT_PROTECTION,	/* Firmware says it used the IOMMU for
 					   DMA protection and we should too */
+	/*
+	 * Per-device flag indicating if enforce_cache_coherency() will work on
+	 * this device.
+	 */
+	IOMMU_CAP_ENFORCE_CACHE_COHERENCY,
 };
 
 /* These are the possible reserved region types */
-- 
2.38.1


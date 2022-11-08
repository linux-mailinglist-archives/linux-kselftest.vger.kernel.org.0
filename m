Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAED36204E3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiKHAtP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiKHAtN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:13 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB241F2C4;
        Mon,  7 Nov 2022 16:49:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvcgy9yYJyvKU1CmPh7BuhZXtWlD+0114f4k4iz+hMoIgFeY1VJJeIsNNlEb9xNzjfYEDoGadEeWdOKuHIV5y0KHixfFYMkgUtXqQMNMu4bUm2m9G0p7Aj6E90nC3MkAQXsrIrxrO7c+liOMrKE+XWLVWX3fml/0/HHQvc/XcsPjaSYadKf4XXyo4ms0SUiCJWVBF0nJSupJk9usYaCKbOmcvczWCLKKZxQlclTNl5yPj/hVHNKBFjA4B5DqiM8vpnz5ieZevWr3ZOiNXMCC4l02es6c1pXO/kbU9elRlxtYolM0wyc/KipS4iN5Zg6GBvWuOgXzxUeGBW42yTjxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W89ELSrT2sbv+QarvfmuTntLl8jGIhpFjsXbcqb1eyc=;
 b=FlCY+O0gV7n5EH3reAGeMtG9svcaJL+Vxpl2qsPHY7Xb0BSSyClXs2YMB4hAsQ2aPe3o0/bh8ZU2/GXHuElpPpGNdXL/w3yKZe4OIBA6zgKi7kVbBlvacB1+ylM9goM8/bmylGyiZIr9vYAOYvEqYTNEBiISGECY6YITTcBvML7PzhSHXq84+w1HOGboKe6jtA+mmXjRq9dqzjx/Rbd++G4yB0ut5ODNYLxEksCQGV8fjcmE37dF5Dz9FUdTMiTQqtK0Qu/aKe28j8GGVpca3PPjiR0DrqhNONNCM/zsX3vHWz3rJ+1sdCuToMoRRkT7u7AdImdN23+U+A0u4KUTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W89ELSrT2sbv+QarvfmuTntLl8jGIhpFjsXbcqb1eyc=;
 b=sfBjIP+U2ApgklZKyfJRst2zjcVWoVfmRkzMMYNiUcTKnLAnDXWQoE2XWCBY1WTBgJDaDhVYkN7e2kUwjZTbsNm7yPSb+yG1ygcnB2uHEBCkTCxxeKGrnMsnGcjgHdxy3S1jawH/OPvQf37TmoDjn7kBgt6RYWsoexSScXRXQuJg+gziYGxQivlsdCIesUikGGlKUjP49elp2aYE1QgHhciEv6g69+fagjmG7tCDEnjXoDSCFgdGfevfVbH5o3u+dcgwi+/YG2s0tJGTsmmpMSd2OEnJn8b8rQpPkr9lrJXP0dVXci7ToylcxAhMfrMAkil2wNwxmotLTiQKdabySA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:11 +0000
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
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
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
Subject: [PATCH v4 01/17] iommu: Add IOMMU_CAP_ENFORCE_CACHE_COHERENCY
Date:   Mon,  7 Nov 2022 20:48:54 -0400
Message-Id: <1-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0438.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 9220ab46-6123-4676-b1b6-08dac1230cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKjIQnGMPRKtOkHsjW6aBRi88oQRYcLBX8Jv5Pl6MYpoiwH+WR5xEwh7UsZC5ck8SEkNGTZaaRlQhKK1VIKK31UaJc9pPwlSsRJTSHsnSQZQ6l9A+bJeho0yQzFbu75fsvHRn2NDJKCz5xhov4z225VAYM6Wz/aSdgpxXgXn8cURnopPvZSBNFI77ARghah3N/W/lHKuW/V/QwawvyaPVUuAuBJLCHMpxh3kNxvRcOoE3QOB9fXx0WcVmf3tJ05DRWz4lwPyOZcNLsQ8U3jeBWR0LXnC5wGT08Qv5ZBgFa74Eqga7mAenBucDLl9K/rZP5614Ua35r/P1RizPNL/TUrMhyqYSQUdVbGu2mR1X+CaBIjZLGZtqQLH4GT+gd2RrC3GdfgIA1ud4f3TkBUYmAygol45oJQcGQpWKi/v7iUzFpsfRKgNvV//S9VwR7HX4227XZUrzXkIK6somcYR4pFTa24JhJ9BongsCUOvGvPpvsVk3pgB3egzhG9R+OszJwKHbbGUJdg0X5jtlKlXeUScQWQ3pi123dH3gR/ce1wfakooB2PlOReQfxcse758Jiq9t1D1AQ4ESirfQij+FrKt3LAdCLbtcW+tdhvQ77HOH4JIa6lUSSB1kjF6ziPaS43GdDI2ocNTKof9w06wCbJAnbeau7NCqTLXievm7FEN1PoqTr1GouG4Uk4vwA1EPvH3Z8b0eNsBMUkzgH371cjM0MSxSoFnCYr0huf1hfmTCq+mM9oodS2lksTk/bbXNzEI+vbsp850UmUREmA7HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(83380400001)(36756003)(86362001)(478600001)(2906002)(6486002)(38100700002)(921005)(26005)(186003)(6512007)(2616005)(54906003)(316002)(4326008)(66476007)(6666004)(6506007)(110136005)(41300700001)(8676002)(8936002)(7416002)(7406005)(66946007)(66556008)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uxamuUdY7ZMjMRqD7E/gr+S5zvHUeeuRabxEvwHHUuWa7X9oyPopm3Qg71wy?=
 =?us-ascii?Q?E68fYjVZwghXQYRBgHQxCTP7NctKJ/EfgxfYNdDNo092u/eCvuEas9hpzJEd?=
 =?us-ascii?Q?aEcFUBEUKnkkay1ovQNjbGvAICDeyKKx6WOC9cWVPWx/Kib3aW5YwHm1nMyv?=
 =?us-ascii?Q?hNQIUqJm0xWkSW8ZhhsrE2Oca/zD4YhqSLHydezEJKtj2SbPorOySPih4VjR?=
 =?us-ascii?Q?ZhjHjKLEAn77sxWpVRmw26fSaLC6LJAUpxKk3oFZJOFbluwzDF5gxZ3wOuqK?=
 =?us-ascii?Q?vTaMbxGtjwDtNV8NpF4Zl0CCI+grCYp4y8A2163+MY4b0yJgAq7vRrFUnMvz?=
 =?us-ascii?Q?j9Kd89L6YhFanawbTA+jSRw0PdYkvuodt/86vXj/7IlnLpFY7qLBlEND7ynh?=
 =?us-ascii?Q?cIPqiXrWPyg5+HCNudQGfxxKM9mzWwSvUCfhuApzPJfer6BvssAsW+sAnG28?=
 =?us-ascii?Q?v2+MtkdPb4gP2420wlF9nJ/JPGRHTpgBLTqm/npXw48HXTGdFtpyki+kzXLK?=
 =?us-ascii?Q?8vePwVg7bVlZjMxK/ipdzTl+w7WWRonOUqnqzl4Y+CHoCygnkua0p5rU7uBG?=
 =?us-ascii?Q?aRAm1+TnIul/oGHrIwDi/jCu/ZiZSBiVqN6NkZqQAqOKiyWW/h8wuysDb/MO?=
 =?us-ascii?Q?nQaOiSGETsxLUwW2xNsHmU3lxaLMVyx5t27pecp7ed4hHlsi9TfhorPWQ+0s?=
 =?us-ascii?Q?4yKy9rq4o+9gAgUPv89SllYXe2eANj3gWK3uee/eWTMfZw2qteI5ODWopKfG?=
 =?us-ascii?Q?aGb2eVZzWDX2X20fEI7q9uMTqYF298BlQzt+2rWFOrzU9L1ISmHT1J2kMhiq?=
 =?us-ascii?Q?xaOIl9QM2j+z+P5XVTUKByCh8LAYF7CMhciouDVG8Giyx7tSDLU04V4lX1fO?=
 =?us-ascii?Q?uvQ56tLyI3X1R+prxYHaRnCRKq1rA4jD5NMF2jikvXu7B9+Wq80m1yAW/WOj?=
 =?us-ascii?Q?TRFgjT0vIjhCIBeaO4Uh8lU0MagLopcHSNE+uOUj6F+ZLKwuLejFKFy/1OeH?=
 =?us-ascii?Q?nihbNp4EwKmfV7NgA5pLDwRcRtDa1gPeKClErDeurdmP4zEQ89kyD+eDZCps?=
 =?us-ascii?Q?hshumg/9QMypN5yJ2ceWSx4qimoKB8xrOyOw2/85upMDNvqYF3PbitjA/f6o?=
 =?us-ascii?Q?6k3SdlMtM/YpiUzIUaGNI+pRRu5c4Qx9q5C6+VAlITItuSYYjm9iOIUw38lY?=
 =?us-ascii?Q?B03idg3q8vJMX3waB+YutBtImCT6S8+jVazdHC6ajQ3893hV0pKDfYqGlKzy?=
 =?us-ascii?Q?y/5N0OkRtT1vsYSfAd/E1jv29cnayA3Sf85gK+U+iyuruzLxu6dv9Pn16lKY?=
 =?us-ascii?Q?lwUpKsPVrt2xFRKakQTZps9S5GakCXLDzqUBQflbESww2SC0pwGkjaGe2BgY?=
 =?us-ascii?Q?aVqVyUamfOCo7ihmMgngGxWq3/eVbInISJeKqE4Hl+fC/u+mstzmWlllL3JL?=
 =?us-ascii?Q?SbujQufcJJQQqQXWEfFjyXqRty6jCkAYBVXYATYQKtui2aN9Dgqbd5G7XZkm?=
 =?us-ascii?Q?vkUeywOhU7TGegru4Srys69y75I0lKkZCVvLvr3dJBYpr9N8n0wc8pOBFMRa?=
 =?us-ascii?Q?tI990naqnBixD7B8uJs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9220ab46-6123-4676-b1b6-08dac1230cac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:10.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnhGyQ8zMhg5IDP9+8K/SoG0O0So/whH8HxEkZ5N/NEPcAC+kkH19O35X2QvSREd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
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


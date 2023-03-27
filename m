Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699E36CAD33
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjC0Siy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjC0Siv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:38:51 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFB44498;
        Mon, 27 Mar 2023 11:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+JNord05zj27bWL8KStWy+HfRVrERUHGIpg3RX9X7ghFNtstJFzFCcuD/vHsPXhulpl+tu3j88Xc880tcvCkQ59y2Qqw5K9M3KHHQjuyYmY4TOyhaV60NYVFhVVyc9I4m3yHKrcHVb10CMmG3zhKQaHPCobu/PJW3yFHstVxNWWmVVh7Hqb2lPQRd203q9dOiHVDViqrNnuKjsEssMu1N00M+tMM2PRwXHqMd48w+6+bcOUwnCNCtAd0741dmdVHfZcOV+JVMcPzA0KOgHNx+pEPYtGT5McIA4HMQj5u857PeUUDJLKtziv3MvrZmfeDuD/Anxu6byDZ3xlQ42W4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph60WDgI8p43IHe41JBnY0V+WVnJzd2+J7jnaoas5yc=;
 b=AXz50o8Gt+fb9yxi+fGbMJxRy7KWtBT4LzDj1cI44oZwnl80nNR5yPviwmmMsb7ujfLeqxEKMpA8tWm396SaVrfKLUBOqojgD8tNd5ku5zEqiyCZhrBvXJAvX0ckpn9sSOsPCNyXChxTBNTLm7gA1mAnN+hSZUfaCY4vlfdN9xFZlB6Z5lNESPDb81BbXzDhGFc+BLbQxYUGrJLWnTn3mN896lQZrSQeu/+TRpT0YqeVPDaDhj11hrjVPTFYVAnDbWe1W7ZuAmqIWSSHAEOcOQkvEWAHWarvPyasZyry70/ebHSF8lRjibjwFZUvg2ccUr0Qd9YJFDwcPf8N12rcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph60WDgI8p43IHe41JBnY0V+WVnJzd2+J7jnaoas5yc=;
 b=P6zdopBHTcszNc+MMqbFf+b8hyVgxvlPrFnXZ4MwZdmCsYgYcLjVjfre3rBNywLM2gR0YFBOadoAeXkZXuIn4WlEa6yllu5HdU27CUpqbg6qtMq0FqBa2UgJsl7UPSXM0na0euVGbFeKxVWLu2xSfFH8Vynwj/wnDPX6IIJ0IkDEXqm8GOL8lAfHRe7otydGPOH5MojqWRX3QS/YOB1s4XrRQGhjExk2A+l5ZXbi218xUkEzxY0QRj1fHzyesiSBpd+i0y7I23LCNxd40ujZv+JJSNtvEb/6fkG6TJnF5PuxPxaOZSqX0vvBOyApDhRC7P/vWbRer5n4IgcdFIzULg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:25 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 09/17] iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
Date:   Mon, 27 Mar 2023 15:38:03 -0300
Message-Id: <9-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0473.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e928ef-9438-472a-9186-08db2ef26d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRjXDdzOVKsfUkfJogcCWE4KWmHcuN2rJiyEQcmWSoxRgt7WsOCPlOR1+JBJX0gQTNm8QNk7/l3cjWhJRRp/xc60c0/Bf+BnENYKgSNmk5DGV46rfcpprQcWp0FuElRooBCP3qhu7u+kOztD1VdEJhStDTMrwaDQteTnUfPrED13bYZRobnWxpfNpmAu8b2Fhu56b/cNxLk43BNpvD3Q3vTXtf8HXYn5c7liOGWvWAxUv0AwuyQifObgqh0ccaiIT2aLBHi3xQETsj1i3/lW1MuoZZNR/JWB7LsQmZbB3eEdKUrc8k5keibQHHJc9MfbYby8Se+u7kMh6Os2oWQu+0wnoph2mbx5Uv0heJmC7F6CaME8Pb0CcaIs4ar7LeY4qIeKxYERh1g7oiVHe3/lmIdP/XSsqgscKl8fAUtYcmyHTPlmmMjasEdLmVEcHLKhvKXoa/uGNRk4BdHumqOsthZ4y6JmeBF1rs9umLPVAz/OODuxR80GKB1ir5rN9SjNt+61Bo00MXK7Pz7QGUHo4I+iJQo4+3ZaZTK6BC5hEtA9gIgREuh95gl8Xr3LRu6lJoQvevfPgdUCNDuZ+VtFb8bIgSMhPUyB0TVY1uEoAiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(86362001)(26005)(6506007)(186003)(2616005)(83380400001)(6512007)(8936002)(5660300002)(6666004)(6486002)(41300700001)(4326008)(54906003)(2906002)(38100700002)(316002)(66556008)(66946007)(8676002)(66476007)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m3+QK3tkM7cFT7A1TlmAVbITdeP3VIkm1mdWcwpFeeKYE/JhUoJhirQKPUhA?=
 =?us-ascii?Q?auuc/hkwFSjZ70CZ0F8aq5pGeBXVpEZXqOYsqapCQciyqT2eovlv8WpjUxKv?=
 =?us-ascii?Q?XTaI7fI1C+ch/pPbOblzWTnVAXIlsyyA+M/Ym6pb1aXFGpLTniYv1888hOzx?=
 =?us-ascii?Q?Uj2wKGpwfnQCOeClE4lx4FVp8vKTd8cErsRwH/nJuDvy469A20JgELwnFUmv?=
 =?us-ascii?Q?Ar0Opm+vlfWxf3rrG9UnuFKR8twWUcbtEDtL/HlkHXxLJ9gRiK2EhNS8tlah?=
 =?us-ascii?Q?ZeV5L7EHs9jTeu6gq4Gj/UrRL+fBc5lQu237LZ5Zab5ZPejNbg8N6fv+Gx0k?=
 =?us-ascii?Q?CU0i2OY4I7IIKBOui3vubcEUxfMDMuftc/RKSMykqh12FsQxJHMHJLLO4mJd?=
 =?us-ascii?Q?nN/b/HJM76gTA2qGW+ZypmfOfYTriqnpx/VWaIWWewRuPe5zMyA3Ah+/HS+u?=
 =?us-ascii?Q?b+ONcbkvm/CEVwYKoXJ/6hhhoTfhIsEv824zL6RI9EtaKMNma0Hb7aQd7H6U?=
 =?us-ascii?Q?H+JsOTCz5A+LWH2gB4XxggC/TUl0qm69kvC8tpfbkoacNmFGOBbWJCMGaBYX?=
 =?us-ascii?Q?ejy4ol/a6UVYKiwoADdwuwpG+remuWxRpjaXSDPdnRcW7XT8M2X/X13jXzYh?=
 =?us-ascii?Q?lPrm9qqKzu9XRe2Y1J3h+bVxybgqgz/OltXz4eFNXP3ZZRvgbnPEIZPX9cuC?=
 =?us-ascii?Q?wUoGR1RmcP+16KDe8cEQes7J57cXOx7aKWg8skTfECULgoqgh6gaJcx3G18n?=
 =?us-ascii?Q?sH6lbQET8iSDwrxfZpwaD4BPC+Eiw6ij5AgnYVC8Sqgaj5NENT/iwkxzPJi5?=
 =?us-ascii?Q?3C4PRrtttWDKOStfA5pl4ub2Dgl+AqwPkEIo/iPlEbhLByvoXXQFuODXDgzQ?=
 =?us-ascii?Q?cDXIrs9nqXdtQgsA/sy6yNcjJVkmHYg8OK3uE0mJ6eGeg5G7eG3Aq7BoErF6?=
 =?us-ascii?Q?Je4uxfaDeUG3jQzMbIMZ5NRNII2L1baPHSQoBVYUhZY9CnwaUsjLPcVKdd6T?=
 =?us-ascii?Q?AuGDHwLPXF25lO/+KahET2fx/ILdWo4mUy9T/5cnCHcwPg05RLQQLmZWwbxA?=
 =?us-ascii?Q?SmDhY/hsVMkbJYLK7u+IohcQsInULgTFwWRQjkRxYwYkCpT4g06pe6SJg3Uf?=
 =?us-ascii?Q?gSsASgAvWf214duvamc306N7fkh7tTC8qS5lzI7OFQKDZ/QSDOW7H8vXQIy9?=
 =?us-ascii?Q?SPm0ZgKWLS8RG6JLdFoO0kd8Al8slM6sEnysa0eJrCuFzLCcQ0lD+GwpmZ+L?=
 =?us-ascii?Q?UJb8GA/ilzDYr7mJwMLCbGzi9mgAgJxkHP5asln0dPTijcJHP7x6M7whRlO/?=
 =?us-ascii?Q?bfcE1NsQR1JdT9cGOGIJguUvnVIpTuvO6bks5Sc3V5o7NM6XcmuK+2yC9pdd?=
 =?us-ascii?Q?4+/9V7Xw2Vh2VkT7ncVnrFs6EcOfDzQlvJtCKsJT5lUK2ghYnfduZ7e+EMVm?=
 =?us-ascii?Q?xladYlJWSuQmFvSdnaqjzYkU7mj/3+1UQSsipXrhvL9GDKaGOVgfm5iWib/X?=
 =?us-ascii?Q?YEyL90xscQQq1mhTUBGH6PZZGnW/1vnTRhZswJgY4OQq3NeckFUnOdKE/Lh0?=
 =?us-ascii?Q?muFsXSe2lWg9t1R/pOLITUcAP28PdvrtEb5Ew6wy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e928ef-9438-472a-9186-08db2ef26d4d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:15.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJqHL6SWwlb0/4/rNnt8sXzT5oEZq97HOd1Y6ojvmBTKcMzmojXxJHQdDFL6j8V7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Logically the HWPT should have the coherency set properly for the device
that it is being created for when it is created.

This was happening implicitly if the immediate_attach was set because
iommufd_hw_pagetable_attach() does it as the first thing.

Do it unconditionally so !immediate_attach works properly.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 19 ++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    | 27 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a77acaf8309167..7008cea5158166 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -295,22 +295,11 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
-	/*
-	 * Try to upgrade the domain we have, it is an iommu driver bug to
-	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
-	 * enforce_cache_coherency when there are no devices attached to the
-	 * domain.
-	 */
-	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
-		if (hwpt->domain->ops->enforce_cache_coherency)
-			hwpt->enforce_cache_coherency =
-				hwpt->domain->ops->enforce_cache_coherency(
-					hwpt->domain);
-		if (!hwpt->enforce_cache_coherency) {
-			WARN_ON(list_empty(&idev->igroup->device_list));
-			rc = -EINVAL;
+	/* Try to upgrade the domain we have */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (rc)
 			goto err_unlock;
-		}
 	}
 
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index a538ceb13a6f22..c5c0ef9912a13e 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -25,6 +25,20 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
+int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
+{
+	if (hwpt->enforce_cache_coherency)
+		return 0;
+
+	if (hwpt->domain->ops->enforce_cache_coherency)
+		hwpt->enforce_cache_coherency =
+			hwpt->domain->ops->enforce_cache_coherency(
+				hwpt->domain);
+	if (!hwpt->enforce_cache_coherency)
+		return -EINVAL;
+	return 0;
+}
+
 /**
  * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
  * @ictx: iommufd context
@@ -60,6 +74,19 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
+	/*
+	 * Set the coherency mode before we do iopt_table_add_domain() as some
+	 * iommus have a per-PTE bit that controls it and need to decide before
+	 * doing any maps. It is an iommu driver bug to report
+	 * IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail enforce_cache_coherency on
+	 * a new domain.
+	 */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (WARN_ON(rc))
+			goto out_abort;
+	}
+
 	/*
 	 * immediate_attach exists only to accommodate iommu drivers that cannot
 	 * directly allocate a domain. These drivers do not finish creating the
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8bf053f4d4a9ce..471a3fdff1e0b6 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -254,6 +254,7 @@ struct iommufd_hw_pagetable {
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, bool immediate_attach);
+int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
 struct iommufd_hw_pagetable *
-- 
2.40.0


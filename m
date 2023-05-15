Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD986702F0E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbjEOOAx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbjEOOAu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C782C1BF6;
        Mon, 15 May 2023 07:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpKaO+zPYikQaO7miWnJBbDH5UnRMC9t9UOpxLl06FpsPT0Yc4/RodOBApmbwBj15Pr9VZs9Cacrvfi1bWifIbZjQvA4WrUOY88pAp9dNQ3DAaZdG7ygE0SCfQq+TOHJqbHM3ZVCa3F3DJFGGigOIF3UCJyPtraDdvbZ93LaLhRHvGkXmyShZkAON3Fr7teM2JEW8Nzlq75HxzkQJiC5dye8MZBBF3JNWP/sPl5KmxaGnJMYEGVXZwzq4ir3Agmy9M3e2+2GRD5uYxEkyfGnu8hSQ6Xwl5hHoU33lRfXW7oRJ4z9jTmMTYLghOGKpi5CZXhJJyospgHx0BQMu/kyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZZjLtmtagMA6MOk+ex18PqjUiuiken2+gdaCzGO12I=;
 b=Mp7wgA80iyvHs1JQcUVjhbF7T1IP2ROpdjawHj2NdwTaL7GxwvN4fAD2ZkF7uQbSNol+Q3u7xMri72br5wioGA7HuPU2ZLjVNtjqx+YHpzOjIXYIyH2hbI6ERT+EaFx842KV1gRy6mw61tKESdvlID/vNWZh9t3NOhYknjjCYDIJPeNuplWbrrk65G5C66RR+sbts+FgMixcKgXpYoB7CfVY7IIKK+q+l4Q+9lXsphlvCQVwdSeN93oUQ9OEw6V0a+jcuvVcJsTttqoC0dz6YBsJiW8XwJsiHSCn0p7d86yQmAK7yhNAIWBT/T77tv5ZTNFy0ZHcIjN96uMHxzAfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZZjLtmtagMA6MOk+ex18PqjUiuiken2+gdaCzGO12I=;
 b=d92r1Y429ErX42NXxYzI6gl+vIS8iWSv0YEd9eIi6ayeh7Ag36bvmdN1diuOP/hzMvqRmwjjZUizgnsIkybLarVZm96pEoDizFWVW4rMk5vBiPlIvYd0kZALbTvQ59GZe1GxqCzmhiXxsfeXu6h4RGvnyqnHkKp7iFY7rVqQ0MTFSegICcm1VeYSd/EJTqmSxn7LGx39CtgIh/c9nH43qyGylLxnZ6LgXYHhp0rVax7e37Ew99PUnij5ByS3moRwi0rGtjXxETyE36hidUVwjhhU8FHSC7Jf7ycCZu8PcT4pli6zjHUsaM9Nnc0RMRdS7WJLsgC63VPdPPSkn4vgvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:42 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 12/19] iommufd: Reorganize iommufd_device_attach into iommufd_device_change_pt
Date:   Mon, 15 May 2023 11:00:27 -0300
Message-Id: <12-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0031.namprd17.prod.outlook.com
 (2603:10b6:208:15e::44) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec8ef9f-b31e-4425-8684-08db554cc1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/y5boc1CymNorNwRBR2fb0uFnFcI+GH4qgrR4KFgj8js8Rq5UHdNuVh8nSTdZz6gCw6w08jze30bQwmaF/EBMlwnPyQJ40E3KYJuAre2l5xuUPs9kVaBMtTq5gENRVX3xi50eIdEBGrZrb3hJsG1FE4kod8jWQD3N94FYR/fVs9mPw923zmADehiZdOjEu87s/5ZvJ0hEd27n2eJVzXN4JBTWvG/Yu12/fxeTbuIDlHfW4rwz43//b2rU5/BRbyUyDDF8ZgCa5ZcIEplT1CXtd2shQuW9o61az2IBEKyvSpD82rRguhPAruu6SvdshJGnZF3JfAVlZPyn8PRQYG57zu89pcX3ndRltrb/Xja/9ne/2C3vDlB1mng8ngoEj4NVYlhxMUaSCK0s74Gya11LG2sb87qZXvJZei+yGQ9b/NrNt4GeFlsJZeRsB3GUe5TzCUalLAyMZWghwSXuAVUBZQID8UpUxC6XfVU/pY01H3Emevi3LuXngk4ul2mZ3ztF5w8kqqoDm6OXFCEiv7i96G+Gc0vu5lHlGFz5iRBXUjibp186DHyWoCp0fW5SzR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZOAKnGZ982udyOf1VFhHaRaP5FhpHkbLyt4SEHXmFAwHyJloBGDZ3x1424Uj?=
 =?us-ascii?Q?2fVEW8dedD2Qks0ldkkZWOsEA4Rf7As9TUpto8JFi8SD2VM521Ld6EBzOAbt?=
 =?us-ascii?Q?tsitzvMCWB1tlb1jC1HzK4yYI5u4iSCK6ymqyVND8EDLySkU6buOnAriei1U?=
 =?us-ascii?Q?88471rnuMCK6Y+RO8neRKbIgKib3IYhyuObitc/0lL9cpJ5iyr95aPhZtMVx?=
 =?us-ascii?Q?2WxdKVXuVPCIvhwiRT5OdxcqfcGzA/j3EHzhxumHIwlemeiAbUiIu96oEY+m?=
 =?us-ascii?Q?Gv6Kz+MEFfbgzYWMcFvwY95uf6Cmh2H581mxPmDuczWkVX1PVgPSnn7UnQKt?=
 =?us-ascii?Q?TU4WJzRsQ5V9eslYLcP+4EG19p33QDeoNMXoyMYSb52eGNUKTHvueNwoPAV0?=
 =?us-ascii?Q?BbEuZuNHECKKc00A/qoChAEh4hhbKzYzopxo4n9z0oKg37teLoWkpMjMaOHt?=
 =?us-ascii?Q?SY5Ctgx6n+D/W3i2eekLFKi4WqlAGnUhMtGIn85LMLP+4zolPYF3x32GDHtM?=
 =?us-ascii?Q?4ltjBo83Bej+6/qLYtiUzLnT8t6slSmAp6HB5XSc6+6/sAGwGa/U7RQu0QRp?=
 =?us-ascii?Q?Z7uRgbboMz3ebomoJOnXCxYILJhEm4LSAGS2+dQIzWQGxtQU3lgwlYKxswMA?=
 =?us-ascii?Q?pk2F84TyyibHm1Wc0nHcnkvBWPS4fd45jfEL6SPucWIiEqtv7wThobBekL0d?=
 =?us-ascii?Q?KjYebfZnNDgMhMQ5jRfMOfPW4qpPxoVQWAdzVDB/qkKmh6eSM5e/ThSlXaEf?=
 =?us-ascii?Q?VP7rQS8wJNhfdUMHtHZqQWjva1eTHFvhoJlxQLNuYORpokWaVT7y8cvLm5Wc?=
 =?us-ascii?Q?ws1Il1JEp9trvXAohtR4yDx/5eKip0C2X1U/eEOgBinOntLLw2TdG3QhuAWa?=
 =?us-ascii?Q?3G8S+xjxxUKgUcyaeLzPwsumfk9o2v3mJzLDN3manlaoLWoQEK2TZxkwlVjm?=
 =?us-ascii?Q?OgPHZYOHkBhMqJrRm6cLQ5vhBqOo6XznuwlOvJImZeT9t1KBxtsU5vDLuc1o?=
 =?us-ascii?Q?vKSOL+hHElBCAOsdjbnpFeeWr6RxvRKuerKADxbpfySJGULq8YMiZzSIVSLR?=
 =?us-ascii?Q?bSkzVijspk97kaHWkaSPPMgO+RvpUKzB3uZXkIM6Ca2KxtLjhfT//URCW5ac?=
 =?us-ascii?Q?a7W8rlA4KAqGFYiTNKgWls+gTJBLQncQciLBQt65BCqqVOhxoFyZs7N1m2Ay?=
 =?us-ascii?Q?EGdr3+INR4UT3oXHVFqdXoCN8AA5hTqHUtLK8KohGKoMterFFBEyZqftUOqq?=
 =?us-ascii?Q?dVwcoCwObgB1MX58A7QKlPWRALWJSUH/YiwVYwrbBkPp/96cIs1ZotBYTf8Q?=
 =?us-ascii?Q?tSSuDelphF6SrYqb7jTcq1DV0Wwfp2CHMqhYMfu3SJc8bhUn/WQlf5U+jBEL?=
 =?us-ascii?Q?MwcMUo0ifAxYO1fCcdeb8+cvcaFMkGWBwDY0nuNnVl3FIB55wcbWncLYz9da?=
 =?us-ascii?Q?s2sWK5ttkIJ30ZZbN79eidWk24dTmTFc6DadO9kCvbqzMq6P2Kj41rHqndJX?=
 =?us-ascii?Q?vZxCZHNZEF+kQPhBIGOIeAF+zfA+EVG8rwYqwoEIP5rhB/CkHqxvIEtoj5ds?=
 =?us-ascii?Q?GYEQz9XFx6p1xpc5kHCQr9OUdWyCjIxGyRkJJk6x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec8ef9f-b31e-4425-8684-08db554cc1d7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:36.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tb0QDWoAKVv7ek5Y/ErfKlXNK1RIvHFAzVNGnse9wjMPhOi9k9aW9pidIE+D3IMD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The code flow for first time attaching a PT and replacing a PT is very
similar except for the lowest do_attach step.

Reorganize this so that the do_attach step is a function pointer.

Replace requires destroying the old HWPT once it is replaced. This
destruction cannot be done under all the locks that are held in the
function pointer, so the signature allows returning a HWPT which will be
destroyed by the caller after everything is unlocked.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 165 +++++++++++++++++++++++----------
 1 file changed, 114 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index dc437409e70ffe..b7868c877d1c1c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -353,16 +353,41 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	return hwpt;
 }
 
+static struct iommufd_hw_pagetable *
+iommufd_device_do_attach(struct iommufd_device *idev,
+			 struct iommufd_hw_pagetable *hwpt)
+{
+	int rc;
+
+	rc = iommufd_hw_pagetable_attach(hwpt, idev);
+	if (rc)
+		return ERR_PTR(rc);
+	return NULL;
+}
+
+typedef struct iommufd_hw_pagetable *(*attach_fn)(
+	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
+
 /*
  * When automatically managing the domains we search for a compatible domain in
  * the iopt and if one is found use it, otherwise create a new domain.
  * Automatic domain selection will never pick a manually created domain.
  */
-static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
-					  struct iommufd_ioas *ioas, u32 *pt_id)
+static struct iommufd_hw_pagetable *
+iommufd_device_auto_get_domain(struct iommufd_device *idev,
+			       struct iommufd_ioas *ioas, u32 *pt_id,
+			       attach_fn do_attach)
 {
+	/*
+	 * iommufd_hw_pagetable_attach() is called by
+	 * iommufd_hw_pagetable_alloc() in immediate attachment mode, same as
+	 * iommufd_device_do_attach(). So if we are in this mode then we prefer
+	 * to use the immediate_attach path as it supports drivers that can't
+	 * directly allocate a domain.
+	 */
+	bool immediate_attach = do_attach == iommufd_device_do_attach;
+	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_hw_pagetable *hwpt;
-	int rc;
 
 	/*
 	 * There is no differentiation when domains are allocated, so any domain
@@ -376,38 +401,101 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		rc = iommufd_hw_pagetable_attach(hwpt, idev);
-		iommufd_put_object(&hwpt->obj);
-
-		/*
-		 * -EINVAL means the domain is incompatible with the device.
-		 * Other error codes should propagate to userspace as failure.
-		 * Success means the domain is attached.
-		 */
-		if (rc == -EINVAL)
-			continue;
+		destroy_hwpt = (*do_attach)(idev, hwpt);
+		if (IS_ERR(destroy_hwpt)) {
+			iommufd_put_object(&hwpt->obj);
+			/*
+			 * -EINVAL means the domain is incompatible with the
+			 * device. Other error codes should propagate to
+			 * userspace as failure. Success means the domain is
+			 * attached.
+			 */
+			if (PTR_ERR(destroy_hwpt) == -EINVAL)
+				continue;
+			goto out_unlock;
+		}
 		*pt_id = hwpt->obj.id;
+		iommufd_put_object(&hwpt->obj);
 		goto out_unlock;
 	}
 
-	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev, true);
+	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
+					  immediate_attach);
 	if (IS_ERR(hwpt)) {
-		rc = PTR_ERR(hwpt);
+		destroy_hwpt = ERR_CAST(hwpt);
 		goto out_unlock;
 	}
+
+	if (!immediate_attach) {
+		destroy_hwpt = (*do_attach)(idev, hwpt);
+		if (IS_ERR(destroy_hwpt))
+			goto out_abort;
+	} else {
+		destroy_hwpt = NULL;
+	}
+
 	hwpt->auto_domain = true;
 	*pt_id = hwpt->obj.id;
 
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
 	mutex_unlock(&ioas->mutex);
-	return 0;
+	return destroy_hwpt;
+
+out_abort:
+	iommufd_object_abort_and_destroy(idev->ictx, &hwpt->obj);
 out_unlock:
 	mutex_unlock(&ioas->mutex);
-	return rc;
+	return destroy_hwpt;
+}
+
+static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
+				    attach_fn do_attach)
+{
+	struct iommufd_hw_pagetable *destroy_hwpt;
+	struct iommufd_object *pt_obj;
+
+	pt_obj = iommufd_get_object(idev->ictx, *pt_id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj))
+		return PTR_ERR(pt_obj);
+
+	switch (pt_obj->type) {
+	case IOMMUFD_OBJ_HW_PAGETABLE: {
+		struct iommufd_hw_pagetable *hwpt =
+			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
+
+		destroy_hwpt = (*do_attach)(idev, hwpt);
+		if (IS_ERR(destroy_hwpt))
+			goto out_put_pt_obj;
+		break;
+	}
+	case IOMMUFD_OBJ_IOAS: {
+		struct iommufd_ioas *ioas =
+			container_of(pt_obj, struct iommufd_ioas, obj);
+
+		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
+							      do_attach);
+		if (IS_ERR(destroy_hwpt))
+			goto out_put_pt_obj;
+		break;
+	}
+	default:
+		destroy_hwpt = ERR_PTR(-EINVAL);
+		goto out_put_pt_obj;
+	}
+	iommufd_put_object(pt_obj);
+
+	/* This destruction has to be after we unlock everything */
+	if (destroy_hwpt)
+		iommufd_hw_pagetable_put(idev->ictx, destroy_hwpt);
+	return 0;
+
+out_put_pt_obj:
+	iommufd_put_object(pt_obj);
+	return PTR_ERR(destroy_hwpt);
 }
 
 /**
- * iommufd_device_attach - Connect a device from an iommu_domain
+ * iommufd_device_attach - Connect a device to an iommu_domain
  * @idev: device to attach
  * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
  *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
@@ -420,43 +508,18 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
  */
 int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 {
-	struct iommufd_object *pt_obj;
 	int rc;
 
-	pt_obj = iommufd_get_object(idev->ictx, *pt_id, IOMMUFD_OBJ_ANY);
-	if (IS_ERR(pt_obj))
-		return PTR_ERR(pt_obj);
-
-	switch (pt_obj->type) {
-	case IOMMUFD_OBJ_HW_PAGETABLE: {
-		struct iommufd_hw_pagetable *hwpt =
-			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
-
-		rc = iommufd_hw_pagetable_attach(hwpt, idev);
-		if (rc)
-			goto out_put_pt_obj;
-		break;
-	}
-	case IOMMUFD_OBJ_IOAS: {
-		struct iommufd_ioas *ioas =
-			container_of(pt_obj, struct iommufd_ioas, obj);
-
-		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
-		if (rc)
-			goto out_put_pt_obj;
-		break;
-	}
-	default:
-		rc = -EINVAL;
-		goto out_put_pt_obj;
-	}
+	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
+	if (rc)
+		return rc;
 
+	/*
+	 * Pairs with iommufd_device_detach() - catches caller bugs attempting
+	 * to destroy a device with an attachment.
+	 */
 	refcount_inc(&idev->obj.users);
-	rc = 0;
-
-out_put_pt_obj:
-	iommufd_put_object(pt_obj);
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
 
-- 
2.40.1


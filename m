Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A28C6CAD42
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjC0Sjd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjC0Sja (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:39:30 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E84126BF;
        Mon, 27 Mar 2023 11:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G34DzS2+gHayw/kZiJNmwg/GaAVtxI1sI6MRqn5cdBPWW/ccpjVMS8CeQQpd36wjhCUOcIzOaTeq+7req0T+40uK65925c7PSngvKRtz8G0C5rLZv7auPqYwr3ywm1FHZQoh3EYquMX08884gaIhyfjevLnHX8kTnV+T5jjNuxTjz2oTVN9bvZoKqdKUbfid5qFKyvHTm6CbEx2a2QFZ7YuIDabLCeisUj7QBVeyCj2QOfIn7q2XQ+CoNPC7G4L22/TUTtdxKQa5fzHu//jvsCn/ZswWt3VQnX+QWjObOxgbi5aU0cPfqFniiSLqS/ij6RXLig+W32WGMQcQULdydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6ratW58MvYNk3140JJSanR+MNsF2UIbkMWOecVyehA=;
 b=LNWPLo5/dbT2HkdZUYel4kHFOhaN4FtBBelQpwwlJvM8qPWNSQTdaRvRiJLEXKeh4kJg+P+GjgjZbeHtaPVAUFmDLAXPOyhafAAUD5tU7Ov69OmACd5z0CXi6dFCufbVU/JA9WYfoWb5/SzfdThfGnDpeWthyxUdRhQdESb0t4X2HB2VbCZPBMJI4Pd6LoLfFvBR1wf8/An2x8OPucJFXJKOwjzqWqURwDyj9EG/3MqThHPgyt6VOHjtxdUpTzHsyWFAkdT2zpYFPh5nZ9njRww6tGVoWltdesiMrZ7igZ1EgnkZsfM1ZrLBGHDDyJi9o/T7WMBDpV/vlHJIt/XtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6ratW58MvYNk3140JJSanR+MNsF2UIbkMWOecVyehA=;
 b=QFzgskumyzn9zlPJRVPX9PqCfq/MmMjBEwrY7aseVk1gAER2i5JzS9pR5LXih/FOqdhEb9uRI6Jst+GyjVAI4T0k4F344MRt6Eww3IwJHWL+nv3Yza63NOOQWrm9avaYvDgFasxBHYVVDerV4pdKn1tmGFrxTbek88u0RQJA2I5J16PP2yBy/AG3BmvH1V7fZSDibYo/h9RqjB6SpD2Yu5pCBZj+RTr0wQrwesdlDfMTpMToKxXlAn8ecbSa9zeK2lwbFM+coRcll93Pi9DlI0uQhvt+L/POaLGHgjfNUzy/xZeJpwmaVxhp2stx7OBdoSuW8ZHXX5u3mfSQ0gTq1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:19 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 10/17] iommufd: Reorganize iommufd_device_attach into iommufd_device_change_pt
Date:   Mon, 27 Mar 2023 15:38:04 -0300
Message-Id: <10-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0470.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: eac66da5-eaa5-4724-cd78-08db2ef26c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VniXnPUGlYJo0jRy9Mz4CBwEbSM32ayZojOixohmrSXpSiX/B+/8SOwB3il2VMpyNpUbUnrD+jEVu84PszRl67mmOtEFaj9KMwEXtxu4mHdDGgONMhQi05tvIhXn6Mji/miGTN74r9gr94P9p0rr4KW+PpUfxPiKzIAL3OlDqIXhC7Y3UOvKkXlV1yDnOS77AdxNxWA/74TTo4ehWgtH4/5DYkPCzUU6mIFsPFraglHAJOlD0kyF9KUjjxnKaSc005iqPMXWL+ZsdIzs0fzRk2M7jKWtczSQIkpSKuSw+8KSEyX0mSFjz28IBCV06axxB93jJMz5U4qVuB5YlolUU3kQFksRt7CrcI+36ctXzdryD3v8ybvj5f6ieHN4G7a0Bn5zxCjkF+oMImCoA2ft/1gOnfL9tLGcr/kgPeS8b0GUxPInKMB6pCy9GA9HbvQjmGsZgtTM3+KBqiXvjlvTROZgaSxmZD6Tv/j2RVXoVezGS+D9zuiyVvE6eaXqPvlrHO3oxzv2Dt9veCFV5m28kGucm46VrjkpItgMQy5I56GSCddTLIaU1PRFg3CU8gl5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5z1ExAPjLPhEovcwG/1LEBnSRBWPurc82HyUOU0n9AqWADTv8IIrd0khN0YD?=
 =?us-ascii?Q?WW/rX8CKct3nQfP77EXGZMTEEURFKPcZaPrkam5ryA0gfPi/89/KRuQYAk4i?=
 =?us-ascii?Q?keT9kzGXLga3QDW+DgIGgZKfkMRsJz6pKKLEZrRqaNPUtpTSb0eLwo98+7Jr?=
 =?us-ascii?Q?aQGmG7U4blS+c0NiLkrIbn7v7Tp+AWCJ/1H4HUR1fx+lfgjylSxfi54Eb2zJ?=
 =?us-ascii?Q?1aFPdyouADFa/vSrQWpMfeUpTpb5ioFjXQwwwfQHdzuR/65Lqxhhx8BbiRvC?=
 =?us-ascii?Q?uI0NqsZVxNmizHpbKwXAwTC4STvLcSnVve6tTsdNzQqsA9A5QcJb+CrO6yJL?=
 =?us-ascii?Q?/W7WFM8KBz4aydpq2UwJ/f1Ca149Nli5foiWaPkBUEbmgs8rQIEnurudjkyN?=
 =?us-ascii?Q?+xoRl2h3iShfnNX61sAn8jjTpL0yO2ofmuhOsVfWM3OUqh8Ef/QSXTQfWf8b?=
 =?us-ascii?Q?UF6R0QNUES1IZxe0R55LcOddtbwnPVO9REgJA8MGEK0iO40a5pUK8gNONjMd?=
 =?us-ascii?Q?74glAwfVKpDQWWID8m9WzzbXOSai8uCPNqlCBdXXz6MVaw+MD+LmuxEbnTOf?=
 =?us-ascii?Q?wc5LSj8BETwBt4Lp7M4aFtIMH2DMkUkpbwylRKVHqxERoe3q16jNZJhkGJg0?=
 =?us-ascii?Q?9LpILlA4rPySq6ngz6n3/2kDB5myBmr5/6bZ++qDs5QP5k68JujV/hfV8SKh?=
 =?us-ascii?Q?rWqN4ORFUegQ49W6X3pMggtVQeOETpthr8buoZQDKKUW8psTFEtDDtm9Eoo0?=
 =?us-ascii?Q?JFtfwtX2XotOfTNANM1Noj+63LKfEqj8UDyegsxQEE/gGS6Pm/7hdl4GWCA0?=
 =?us-ascii?Q?ryo/NV6ucz1/XUjHd7k7+ptP9n919jeEdKfzIIkOET5gtfAQzzZVIDkoNZUc?=
 =?us-ascii?Q?bilCWzGjkYqSD6fazdG2k/SDU9FruMwFN/dj8xBR28KGzAiQ9VoPvpg7jOII?=
 =?us-ascii?Q?41FWLWfLm/pQX6ZGlUioe7ZrYS9kP4DqmT8LRR0eyQ+4Nnr4MY3Dm7H33XFd?=
 =?us-ascii?Q?QamiTYlJ19p1QjguE21AvSqS/d7OnsTicP89aNM7uZO3STjF0wnEtMy/fTIh?=
 =?us-ascii?Q?Fcia+ocnlNUzHOykCHuKcogEcg40QJe4UPtNytqpJhba08Vmu6XqBGZmB6ex?=
 =?us-ascii?Q?hs/7SabaYoqdVWVUEHcNtVCFmwImzt9po+/9UfxbwE++uvGkdmm9kQHfAHnz?=
 =?us-ascii?Q?7uIQmclr3zftDhUutQF0z10mx9Z5IwJh6E0SlG1iFEeMdhWdkTSdcxVAEyCw?=
 =?us-ascii?Q?z70GZGbeseWwRyF3yyjskM+o/uQQT6rqIPbjy2gXUg0yzCNGCG3BkwHDUczG?=
 =?us-ascii?Q?zhICzSQxDVub6YS9WENdoFrknZ6YR+OAWFbkitlWfNCT/XuwhqJWprZIUQ1R?=
 =?us-ascii?Q?NuahB/p6UDPxzCHhGA2FxW8WCaijqlMAC8ZSkDlev6UEi+QBuOUP2wDyxetl?=
 =?us-ascii?Q?8RUxVGZAloAdUGReirwfvw/o0UXKCBjeNLp0OcSvGnVFlWUqJM5+QbbbmeJA?=
 =?us-ascii?Q?87M9RyFcnr+fG2IH85qhWgMQOBYw1TP8UqjXjRpyyN0USIpE46Va3Uwsq+5C?=
 =?us-ascii?Q?QnPlQxOM+b3ZCvHcIvl8FShMPNrwjySAPasq6i/h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac66da5-eaa5-4724-cd78-08db2ef26c57
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:14.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9OFR8JZAj8nVHnHSnYC744YDNgjBTd1KlJsC/C9uhijvLAMCfjJKHUlW5DcOima
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/iommu/iommufd/device.c | 141 ++++++++++++++++++++++++---------
 1 file changed, 102 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7008cea5158166..f931d3b95d6d0d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -352,16 +352,41 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
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
@@ -375,52 +400,58 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 
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
 
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
-	return 0;
+	return destroy_hwpt;
+
+out_abort:
+	iommufd_object_abort_and_destroy(idev->ictx, &hwpt->obj);
 out_unlock:
 	mutex_unlock(&ioas->mutex);
-	return rc;
+	return destroy_hwpt;
 }
 
-/**
- * iommufd_device_attach - Connect a device from an iommu_domain
- * @idev: device to attach
- * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
- *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
- *
- * This connects the device to an iommu_domain, either automatically or manually
- * selected. Once this completes the device could do DMA.
- *
- * The caller should return the resulting pt_id back to userspace.
- * This function is undone by calling iommufd_device_detach().
- */
-int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
+static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
+				    attach_fn do_attach)
 {
+	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_object *pt_obj;
-	int rc;
 
 	pt_obj = iommufd_get_object(idev->ictx, *pt_id, IOMMUFD_OBJ_ANY);
 	if (IS_ERR(pt_obj))
@@ -431,8 +462,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		rc = iommufd_hw_pagetable_attach(hwpt, idev);
-		if (rc)
+		destroy_hwpt = (*do_attach)(idev, hwpt);
+		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
 	}
@@ -440,22 +471,54 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
-		if (rc)
+		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
+							      do_attach);
+		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
 	}
 	default:
-		rc = -EINVAL;
+		destroy_hwpt = ERR_PTR(-EINVAL);
 		goto out_put_pt_obj;
 	}
+	iommufd_put_object(pt_obj);
 
-	refcount_inc(&idev->obj.users);
-	rc = 0;
+	/* This destruction has to be after we unlock everything */
+	if (destroy_hwpt)
+		iommufd_hw_pagetable_put(idev->ictx, destroy_hwpt);
+	return 0;
 
 out_put_pt_obj:
 	iommufd_put_object(pt_obj);
-	return rc;
+	return PTR_ERR(destroy_hwpt);
+}
+
+/**
+ * iommufd_device_attach - Connect a device to an iommu_domain
+ * @idev: device to attach
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
+ *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ *
+ * This connects the device to an iommu_domain, either automatically or manually
+ * selected. Once this completes the device could do DMA.
+ *
+ * The caller should return the resulting pt_id back to userspace.
+ * This function is undone by calling iommufd_device_detach().
+ */
+int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
+{
+	int rc;
+
+	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
+	if (rc)
+		return rc;
+
+	/*
+	 * Pairs with iommufd_device_detach() - catches caller bugs attempting
+	 * to destroy a device with an attachment.
+	 */
+	refcount_inc(&idev->obj.users);
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
 
-- 
2.40.0


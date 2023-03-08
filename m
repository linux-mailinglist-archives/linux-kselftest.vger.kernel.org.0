Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A966AFB3D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCHAgT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCHAgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:09 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E326DA02AA;
        Tue,  7 Mar 2023 16:36:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlUvTyQDKO/SemSldAsPtlZqD932LgrMQXWCz0kqpy196YpVvJrxbtNJQ3jtyv/8FrC2AjE0UxQkUwyC4LHbMtOcE1dYY3hYZ9lG6HET7b0b92SyZCh0iV6WXtYcBD0lGswxC56VqruahM+uZMLsaxV+89oQyvwFg6zVyb+ulvFJ+eiB7ugUP8CsJCfrCDmmVYCfsYXIpiVcqnCmoxjLbbhAAxrsuVGbJiLync44OTFcJ+WlLnfzmeDrz4Iq0aHrY99Mz/9T/K7UvrZ6tT/ffW/DJWEeeUboskqzQBSeYV69/42bZ+MHu63vsFkVySmGfKj4+MyOxIMSPX6gDk8dZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU+KKTz895e9K0iZGakjDj6U186H1wZKr+EMEj6AxeQ=;
 b=DYlbJwFCLIxHJMI3evcYSrLsYJjJg7MyAiS9JAjYXd2VnTrY5F1LAOjmCZyysxIOQmUnlAo17LUQ6iia1vNipLtv6NG7CX9V5p79Dzqh24e65xYzgOuLNSdtHDfhfzsUwItTXyJ5muXVZzx6IbITKnTK/8rma8lbuggarSsLzQyBPDET1jg4Q12+6oap6WvAg2z4Q9zC7QiBblPkYNkkPBLaoTDW9w1vxaCFRan6t9I6BZwkVVX9/hQ7N2vacbg+yfPAfi78Fpt+5CmaH+t/ybKcxxZ01hHLdKhrwP9xdqLgj1+3rWL+d8F/m9xUiRPK6SqLI4HwDn/ossbHh+QV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU+KKTz895e9K0iZGakjDj6U186H1wZKr+EMEj6AxeQ=;
 b=CsK+aEltDgBK9GS85TCZTJ0ZkKz6hUCFZCy7Dkku5KXi+uDHCJ9pLFeFwhIrWPTxa0DKnuBgb5Pk9v+Cmrk+SsJ6vXeRWqCir8gGBbG76ahM3gCjesbaW5jX0qNb7LSkZzmH7qTS+hl+10yn9ACyzshRNDPzGtWDcNDTYpCOSBHDA989w+o5mg2fiofBYP7avsd0QTLnG00VhbjPT0iEIA0IoP/eT8jLdmBa625j9RtOJqwsOMrKLIN4WwZLkCeuLlilqQgyXRNh+3xdkKeI7WFcf2gj1cNNYmt79JXTRhqEDGhuC6n9b+LtuSmZgdgmqsPuwcE8GHaCBeT8aoYiqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:36:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:36:00 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 03/17] iommufd: Replace the hwpt->devices list with iommufd_group
Date:   Tue,  7 Mar 2023 20:35:42 -0400
Message-Id: <3-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0034.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::47)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: d2114e55-333f-4cfa-9b3c-08db1f6d15d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dX3G+/An2Izy8/yRjVv/XCSv+moKGEr5HvzlVZApxJZlViBzVfCVf9rJDvKVbCWssyIe1OLzMxMi2SCykwxVpVSLXS/t8ayOuD5tztVNc+yyDIbM7q5pFhLKQ+xv+J/Rb/prx2TddnBReNRtiZU6A0Svu72avNp9ok/c71L2nKErRFdKiinU3hI4iMeSq1faj9096EnsiLp8ydR0lRUgdpigC7hQJj+6XP+awES6a1FI+S+UGcfIYj64rBTxdMfr/qKsaflOjUi2BTBkFMW0eOv/qMgHjSNxAQzzNpbDjPnq4GybksijHJoe21Uoktk9X9qZFFVE4moUjSQ2YkvMxgrVd7A9of3+OKD2hqKIn6I75Uvp8VQXNZvsCfg0yEJACG0Q361Ox+Bs2lnwI8EHaFHHi/EwMrtDFWaltb6uGoUFe/qnT1Zt+MC/fCArjOCu1t2QdnXv3JythqPVDe7gL7gIVjkQ+90Z9tEZsgZ98uZT9zIWGC14Te7qMuU0lQJzcXjn+0bw8tSGdPEoPpdWoeN91ysZlsAs/s6qlTw1cNFUA6G2jKxWDgM9UhlCS4/ys9Jf0pCDebq759orjl2U2U+fWmY6MiMa90zbVc5OU+/y3/fp9tB+HbqZdxhctA4NmTMyyPE87SS5NlQr7tjK16liCmydoQt1AGx85UYXa5YujJNs7zY3PTV+6d7mkOPu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(30864003)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oBsfMAz0pxUnaLb4ywgelJ4x1XKtOUd4m1AAdNxDqKkQFfAzX6lUouFqCBYW?=
 =?us-ascii?Q?b838NoYUczk6NtImv9ggdoUIB2wsVKBYylr6uoOncLJmbOfZiRFlOU2bhd1W?=
 =?us-ascii?Q?bV/o0/J9el8u3Z2A7IWekRdvTBggX3Mz3yZnwBR/qaxsCIWmm9LZ9ZNYI06c?=
 =?us-ascii?Q?VdoUigaDAk82kP/ZA7uMhFx2HrNP1CG3tKqdchdfWqKStF34NTT8J5isJlmW?=
 =?us-ascii?Q?fS5/0HiO5yW7wqtMgBKN+kIGvrWK9QK4DkOeEbQaxGdaqXPbX1LvxnfNmThX?=
 =?us-ascii?Q?tcbW4L3qqnAQQwom5DTA9pQoReMGoGk82RYZB68/iA3DqC7aTMeHWbNOXPft?=
 =?us-ascii?Q?d51+T2+r6+s8Gw3UoqYyt/bPpPj4wJTj8JWr670f4AVEPTUCmT0PLl1N9aIO?=
 =?us-ascii?Q?+NruWvAGoCI9dscbikEd4M/DNsrkT/44kaWNLB7/vcGdSzaN2nmEVlYFqcqY?=
 =?us-ascii?Q?dKZLw/2db/Jn8RsjDipzin+jZWEWuDlMScDhCRQ5b34ZS6fU7/ZOasPBOzou?=
 =?us-ascii?Q?lfDlQhDY7aM60Mk81XSCAQAm2JArWp66eNpfRU/o/oRveEhnnjtrvC4t5nl/?=
 =?us-ascii?Q?YzFMP1iaIdXnamFLtsdrEd8HTVHTixbUXdf2naN9053PnH5f7irIn7JWNcVH?=
 =?us-ascii?Q?N0Fq/x7KOOa0AX+ptzngDAeXuLoe3b/juqRioDfSE96DxSoWCVSTj3OVIISe?=
 =?us-ascii?Q?zQ1IYLfIgttvDZsWS2baipCXcw7a49iuZxx5RlFScQ5GGw5LaVCZvJJJ6wun?=
 =?us-ascii?Q?u68IOcoAjHKbej9J375uuJm6ehL5S7ee9zzz544CnKisorxCQEThKSRZhmc7?=
 =?us-ascii?Q?ZL3AzRQ/hIPsR5nG/n3+20T6Dy/ALpbgtAA7DFAPHi8VdTmfvLx/g8zq4ANs?=
 =?us-ascii?Q?R+f/vuTBkR3BePypaG9Coy3GqYcA9bg56LEZoWRNP6XiQFEKto1nbJWDuTL7?=
 =?us-ascii?Q?k/0QSzJ35SdFSNQgDjLTjNn0TS34zPLOhT+AHb4ANWKQ8npKo+GW4yfUjwXw?=
 =?us-ascii?Q?37Qczw+/tNql1WLc0wn4DvJH7xHu2ap9Kq9zPmI+PPfUjQjy8IUbTs2oBOMj?=
 =?us-ascii?Q?CleEuPH28ZF/rlGUZIXkRZG7qjkf34GFznlXFx1+m11lUt52wtpaNW6U7m3b?=
 =?us-ascii?Q?cdN8UcOIcbRR7Y9GFXG8pO+DA1xR7jbtyeHphGig+Qc1ghPxoWiAEYn/ZH8J?=
 =?us-ascii?Q?Zdidvxl34ug3P3SfPz2btAgbdRcoyAF7wNBQM5yCbJPq0G9JpU3P3Q0pYjBW?=
 =?us-ascii?Q?wQ2QUFX2A98Hc3ZV5u5nw7QffJTnm1Wgi4O8rRjnXnSSETH+c4g+lzJd2gVC?=
 =?us-ascii?Q?JieTIRKfUuF5s8QYspQju5s7B6LFYEFxiVVeLy3rXLmgyZ+nQfntBPYbtaTX?=
 =?us-ascii?Q?CWl+VCanpkAhuSO5airXuO1pfLp3/cm0+bnxNlQJIHUqu2Cn44/nc7S/vSBQ?=
 =?us-ascii?Q?/d75tGnyreeoyg94Sx+IjQY389wd/q+4I2Mb/ke0iX5zdpvkEwHlLuFGe71L?=
 =?us-ascii?Q?tO7tnvqTuCDkFHuJneMkPFZyyD8KEO56tuuYUBGOxQNqz2A/Ywz3MD3vUDNC?=
 =?us-ascii?Q?mbzc9NO30AMKdlDDABKCwyVeuUiIg4xxtvTHROrv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2114e55-333f-4cfa-9b3c-08db1f6d15d2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:58.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPO4n/5BmnuRe5OQkTTJFHvu6P5ZTKMmSTdjKYvX5at1CrmxmKLaGa7zySID2g+9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The devices list was used as a simple way to avoid having per-group
information. Now that this seems to be unavoidable, just commit to
per-group information fully and remove the devices list from the HWPT.

The iommufd_group stores the currently assigned HWPT for the entire group
and we can manage the per-device attach/detach with a list in the
iommufd_group.

For destruction the flow is organized to make the following patches
easier, the actual call to iommufd_object_destroy_user() is done at the
top of the call chain without holding any locks. The HWPT to be destroyed
is returned out from the locked region to make this possible. Later
patches create locking that requires this.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 77 ++++++++++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    | 23 +++-----
 drivers/iommu/iommufd/iommufd_private.h | 13 ++---
 3 files changed, 50 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 71dd9c7bed48f4..a4bf4c5826ded2 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -20,9 +20,12 @@ static void iommufd_group_release(struct kref *kref)
 	struct iommufd_group *igroup =
 		container_of(kref, struct iommufd_group, ref);
 
+	WARN_ON(igroup->hwpt || !list_empty(&igroup->device_list));
+
 	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
 		   NULL, GFP_KERNEL);
 	iommu_group_put(igroup->group);
+	mutex_destroy(&igroup->lock);
 	kfree(igroup);
 }
 
@@ -83,6 +86,8 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	}
 
 	kref_init(&new_igroup->ref);
+	mutex_init(&new_igroup->lock);
+	INIT_LIST_HEAD(&new_igroup->device_list);
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -277,28 +282,15 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 	return 0;
 }
 
-static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
-					   struct iommufd_group *igroup)
-{
-	struct iommufd_device *cur_dev;
-
-	lockdep_assert_held(&hwpt->devices_lock);
-
-	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
-		if (cur_dev->igroup->group == igroup->group)
-			return true;
-	return false;
-}
-
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
 	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
-	lockdep_assert_held(&hwpt->devices_lock);
+	lockdep_assert_held(&idev->igroup->lock);
 
-	if (WARN_ON(idev->hwpt))
+	if (idev->igroup->hwpt != NULL && idev->igroup->hwpt != hwpt)
 		return -EINVAL;
 
 	/*
@@ -313,7 +305,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				hwpt->domain->ops->enforce_cache_coherency(
 					hwpt->domain);
 		if (!hwpt->enforce_cache_coherency) {
-			WARN_ON(list_empty(&hwpt->devices));
+			WARN_ON(list_empty(&idev->igroup->device_list));
 			return -EINVAL;
 		}
 	}
@@ -329,26 +321,39 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unresv;
 
 	/*
-	 * FIXME: Hack around missing a device-centric iommu api, only attach to
-	 * the group once for the first device that is in the group.
+	 * Only attach to the group once for the first device that is in the
+	 * group. All the other devices will follow this attachment.
+	 * The user can attach every device individually as well.
 	 */
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup)) {
+	if (list_empty(&idev->igroup->device_list)) {
 		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
+		idev->igroup->hwpt = hwpt;
 	}
+	refcount_inc(&hwpt->obj.users);
+	list_add_tail(&idev->group_item, &idev->igroup->device_list);
 	return 0;
 err_unresv:
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 	return rc;
 }
 
-void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
-				 struct iommufd_device *idev)
+struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 {
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
+	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
+
+	lockdep_assert_held(&idev->igroup->lock);
+
+	list_del(&idev->group_item);
+	if (list_empty(&idev->igroup->device_list)) {
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
+		idev->igroup->hwpt = NULL;
+	}
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	/* Caller must destroy hwpt */
+	return hwpt;
 }
 
 static int iommufd_device_do_attach(struct iommufd_device *idev,
@@ -356,16 +361,9 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 {
 	int rc;
 
-	mutex_lock(&hwpt->devices_lock);
+	mutex_lock(&idev->igroup->lock);
 	rc = iommufd_hw_pagetable_attach(hwpt, idev);
-	if (rc)
-		goto out_unlock;
-
-	idev->hwpt = hwpt;
-	refcount_inc(&hwpt->obj.users);
-	list_add(&idev->devices_item, &hwpt->devices);
-out_unlock:
-	mutex_unlock(&hwpt->devices_lock);
+	mutex_unlock(&idev->igroup->lock);
 	return rc;
 }
 
@@ -375,7 +373,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
  * Automatic domain selection will never pick a manually created domain.
  */
 static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
-					  struct iommufd_ioas *ioas)
+					  struct iommufd_ioas *ioas, u32 *pt_id)
 {
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
@@ -402,6 +400,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		 */
 		if (rc == -EINVAL)
 			continue;
+		*pt_id = hwpt->obj.id;
 		goto out_unlock;
 	}
 
@@ -411,6 +410,7 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 	hwpt->auto_domain = true;
+	*pt_id = hwpt->obj.id;
 
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
@@ -455,7 +455,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		rc = iommufd_device_auto_get_domain(idev, ioas);
+		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
 		if (rc)
 			goto out_put_pt_obj;
 		break;
@@ -466,7 +466,6 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 	}
 
 	refcount_inc(&idev->obj.users);
-	*pt_id = idev->hwpt->obj.id;
 	rc = 0;
 
 out_put_pt_obj:
@@ -484,13 +483,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
  */
 void iommufd_device_detach(struct iommufd_device *idev)
 {
-	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
+	struct iommufd_hw_pagetable *hwpt;
 
-	mutex_lock(&hwpt->devices_lock);
-	list_del(&idev->devices_item);
-	idev->hwpt = NULL;
-	iommufd_hw_pagetable_detach(hwpt, idev);
-	mutex_unlock(&hwpt->devices_lock);
+	mutex_lock(&idev->igroup->lock);
+	hwpt = iommufd_hw_pagetable_detach(idev);
+	mutex_unlock(&idev->igroup->lock);
 
 	if (hwpt->auto_domain)
 		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 6cdb6749d359f3..566eba0cd9b917 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -11,8 +11,6 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	struct iommufd_hw_pagetable *hwpt =
 		container_of(obj, struct iommufd_hw_pagetable, obj);
 
-	WARN_ON(!list_empty(&hwpt->devices));
-
 	if (!list_empty(&hwpt->hwpt_item)) {
 		mutex_lock(&hwpt->ioas->mutex);
 		list_del(&hwpt->hwpt_item);
@@ -25,7 +23,6 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 		iommu_domain_free(hwpt->domain);
 
 	refcount_dec(&hwpt->ioas->obj.users);
-	mutex_destroy(&hwpt->devices_lock);
 }
 
 /**
@@ -52,9 +49,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (IS_ERR(hwpt))
 		return hwpt;
 
-	INIT_LIST_HEAD(&hwpt->devices);
 	INIT_LIST_HEAD(&hwpt->hwpt_item);
-	mutex_init(&hwpt->devices_lock);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
@@ -65,13 +60,16 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
-	mutex_lock(&hwpt->devices_lock);
+	mutex_lock(&idev->igroup->lock);
 
 	/*
 	 * immediate_attach exists only to accommodate iommu drivers that cannot
 	 * directly allocate a domain. These drivers do not finish creating the
 	 * domain until attach is completed. Thus we must have this call
 	 * sequence. Once those drivers are fixed this should be removed.
+	 *
+	 * Note we hold the igroup->lock here which prevents any other thread
+	 * from observing igroup->hwpt until we finish setting it up.
 	 */
 	if (immediate_attach) {
 		rc = iommufd_hw_pagetable_attach(hwpt, idev);
@@ -84,21 +82,14 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_detach;
 	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
 
-	if (immediate_attach) {
-		/* See iommufd_device_do_attach() */
-		refcount_inc(&hwpt->obj.users);
-		idev->hwpt = hwpt;
-		list_add(&idev->devices_item, &hwpt->devices);
-	}
-
-	mutex_unlock(&hwpt->devices_lock);
+	mutex_unlock(&idev->igroup->lock);
 	return hwpt;
 
 out_detach:
 	if (immediate_attach)
-		iommufd_hw_pagetable_detach(hwpt, idev);
+		iommufd_hw_pagetable_detach(idev);
 out_unlock:
-	mutex_unlock(&hwpt->devices_lock);
+	mutex_unlock(&idev->igroup->lock);
 out_abort:
 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2544f10dae9aef..2ff192777f27d3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -250,8 +250,6 @@ struct iommufd_hw_pagetable {
 	bool msi_cookie : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
-	struct mutex devices_lock;
-	struct list_head devices;
 };
 
 struct iommufd_hw_pagetable *
@@ -259,14 +257,17 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, bool immediate_attach);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
-void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
-				 struct iommufd_device *idev);
+struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
 struct iommufd_group {
 	struct kref ref;
+	struct mutex lock;
 	struct iommufd_ctx *ictx;
 	struct iommu_group *group;
+	struct iommufd_hw_pagetable *hwpt;
+	struct list_head device_list;
 };
 
 /*
@@ -278,9 +279,7 @@ struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_group *igroup;
-	struct iommufd_hw_pagetable *hwpt;
-	/* Head at iommufd_hw_pagetable::devices */
-	struct list_head devices_item;
+	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
-- 
2.39.2


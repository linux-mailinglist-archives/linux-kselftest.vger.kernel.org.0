Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558656A258A
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBYA2O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBYA2M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:12 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7428F19F2E;
        Fri, 24 Feb 2023 16:28:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtqbfHuh1IR2N5OHdG7Sm1mb166ok6skIyf2PuzjH2kooM4y5HxrgFAFB54/QwkCMbQA7yPnJz0RS2W7M+4GKuWWQ1EwOk4RuiIQB/ADll55ICldVCpbrhZaRX9KAjyPAKtCFtbK9TcZw3cQ8q058NrtuHol9zDxezD5MeH/H5MdVEGnh4FWb6418faAmNrP+IhMAqG3MKK2jCLfg/i9+EZr14GRglLHxsrDg5JAIncljSngWlX3Y4as8Ciobzlbs5Cz3rbvOmxSAl5Cur4WJM71Rl6j7o9wkK7b1WXoTObRChqhMuLBFp5VTeBf7lqZvM0hhk4Xf3ZNu6UEh5pCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4jsDnIPKUURm30JQFwPrF0/DaKdFDSyLOO5CGcC9r0=;
 b=OSPxACVPdMEWy7QPXoLwcVw3T5PB0zthxzhnwNR2lRWt1aSu2nvAm+uflfwPU08VOIvKL4ApH018kw5yc7JTR7jMTAW3awapMNxUyEZRtZPi9MaubOWmY5FAwYQT2maGGsBTQGQw3eQEKw0AvCzEe7k+qMBsykBUZUluotWoaTuA2NwlY+vmOdqX00qtiDvrhcWAZ/fjvjIAuCs/7XclXOX7UEL/GfjGuLOgVWofjJ0Ahu/fsuQa9/rpJKyGyiZ55c7msgDgwPb4AHuynKwkJzSoHRx2lk7nZt0O8hDaz/MujPFV41Twydf04jpGWRLpBLm76ppk3s9zpox6eErXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4jsDnIPKUURm30JQFwPrF0/DaKdFDSyLOO5CGcC9r0=;
 b=kT/qbJPvwo32Sxi70O+AdBM57lFHcSz/j5EFc39aCIB4FjlsCx1SNsrXRMquRNA4okvbfvxFh0JFn/88iSm7BNlAifgywz+YPLoVU6nsYLKs4LQSFq3RA7RXpS+icrPKUFIiZs/swr+tk8sANkwBF3+Zv/428GQ3xoMjlsnx8qidpMQlKaDsif3x5vwaSACSzZvyABO2E7pcVUdt+6X6yZpSg5H6c7Bf/eawInp7eM0Xy1nMFuDIOgtugmGdTBal/BYtIkO+gc9R7B80UXVuTXSaeymF1lAOCjtbID9z6u82KSVm5EK8cOF1oNdpzMyooKJGXlTgTzWn/l2QQuJSsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Sat, 25 Feb 2023 00:28:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:04 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Date:   Fri, 24 Feb 2023 20:27:54 -0400
Message-Id: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8340a5-8d5b-4458-dacd-08db16c7271a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L3CwmQnOFM6ZE82zg2eN3z81fdxGtXyIyQseRkfJRXzpBj2SVMtssk2E8w2mWInOYwh6DCiuPT67Irh92kWw/FXMdHm+MgVLRVg+XlWx8set5qxkN9uH7H2VhbdgANmy25xTHsIZAjJchROCuo00/Fi49PBqC2mdpHKmbY9RN3BVPH2OtJYsRrSlh88yY2Um+V2mur5/41pHGc4q4yQWDTcOOAM2o01P9cLqXd8CI1pqrIoaF3mpJZ7B54VfdscVN3aiJRsVBVqIo+hkejpClejM2bzo8RV/Q3eHYD9X/6OJ3PT5F+xBGzbAKp4/+1epp9P1CEiiALILHoQtAVIvnq9NMcvT4JHwsJHAc7Tupwa4/BHAGPnSTyimiiLhSD4Q7dTaYJIkOp/wZMeMYblDuJSEC032iMoUuPJQ7QfJ63wV+cMe5SZexYrpsa9RZ4ST5Se3SBA9g1VT+3j0UFG73kB5IjxfpkGMsLE6cRGTQxRYMSaBZyAboL7QDIVksatDu9A0SDZx8tPXQWLA2CHUVQRvGMN1upUp7NI06b7sBVlco7Ff9TsvNo8Q5vlHUfIVTxipCKlYKS0vyM/ys1q2I1ZQLSfDSDOEX3AdEbct25VpAFdLPBm9sHroyiqfZq5XRLP1IibX9TZWL+CTILe1tFWvNsWSwBpAyocPXF8pMstAxUo7NKcpwXTlVw8de+og
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199018)(2616005)(41300700001)(83380400001)(5660300002)(54906003)(478600001)(8936002)(4326008)(38100700002)(26005)(186003)(86362001)(8676002)(66946007)(6506007)(6512007)(66556008)(316002)(66476007)(36756003)(6486002)(2906002)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?geFc9BWn2scDXzHm4hwdWYPyZrl23o5cuRaF9kqZ/1DKzI6pWqrcRNHGe7dF?=
 =?us-ascii?Q?lgiebSTO9psoB01cxWB05oRZ8yA0Hh2Wl74oW31fjmsMXD9Ykro1ytR1Br7K?=
 =?us-ascii?Q?ybs3e6vh62xfKyFr65Aa+5AhG6xUUhb7HUkVktw+0RFKZJL44Dc3bh8GwFfW?=
 =?us-ascii?Q?OvFywNF7iQxxThTDbGIk+LXBMxzadRDBmQN0b3AxC4L/hs5KRf3vniqzD8/n?=
 =?us-ascii?Q?03D5ch/j0I69kRKszmAXMZB/JnNuPYK5meFozYBlWz1NEM7rN6iMBuspqQ4M?=
 =?us-ascii?Q?co5ogWm8v0xWBCJPl/jK04RO+7toP14OdjtSoMgGql9FjRw3AOKfnBj1XRaS?=
 =?us-ascii?Q?X4Hki4R/EE9wyX/ZTBTUljQHCaEYS75gxBK3XYEUJzuxd0MEuuNUr/JJQ8mQ?=
 =?us-ascii?Q?uzf8sLt/NMPXOGAjgMIkP/5sHL9LXlxFJ6UXpiZNs1UxDvLilF0+kfSMxKh7?=
 =?us-ascii?Q?tw9yNQZj+JfqMfzrUvC3/P22CZ2KE4fS10/g09FYyABNvwgybfP1O3eG4qYB?=
 =?us-ascii?Q?aRRsHCFSUgCx5D6b8Vlw2c54uIC+XNfs5fKSLy+dQ+QqLMvfEDYrHrQQeV2T?=
 =?us-ascii?Q?lGp6W8eN0Z8pMUNxxhWQirYFpii9Nai8j7WikPwIlhW66RDnatrJpqqdbFW7?=
 =?us-ascii?Q?CpdfCPLxPYwnLSuqlfKzIeKv1w/aR9TzlBhxUzptlvSZtWqNxuGKsmeX979q?=
 =?us-ascii?Q?NZ/MPXkFNPLer+eNSgZmjqjuF2BBg/OGMiX92WJJlW3WSdtl63HfP0RDGOsS?=
 =?us-ascii?Q?niaJor+cOotJ4gzI3mNjQmnWpV3aARJxiR5C8cI31mR6QJZ36V/aypA43VzT?=
 =?us-ascii?Q?NnnfzhpKNbss2PITLPcE7e4jXAgsQzz5IEDIA4S14I4nfJXX5QvojWHVEmQN?=
 =?us-ascii?Q?t5Qjtxjsfq1fm27dJqN56QVmNTo06ncS43siqsYPaY3OyClok7R+7K3ebGQV?=
 =?us-ascii?Q?OT8i7SABpepz7p/Z1xNhegJ26bYxwoB2Nkg01/VDGk6WGsvxx01ehDIj/j9R?=
 =?us-ascii?Q?LcLS5S3yxEV06eVm8FDYAqZnHmePOFMPwfr9QZQLzfxAy1HPfM6y8mQkbwHT?=
 =?us-ascii?Q?VoitbA82eRti8y5SKPdNkRVA46i98j0l+LsHjDa96qJCCPpZOrQtO6iPAVnD?=
 =?us-ascii?Q?4hEeJTdgdIbJzEXqqjtWCbaXdIKUS8laxBoB10KbbA73cQOufOSxob0BKXE9?=
 =?us-ascii?Q?IpHC9VuCFvqjXy1Al5X/jeRtmlUCDMUCRa8zsbHnmlrhqQwR11CSzm/i8Iyz?=
 =?us-ascii?Q?8w/RaVhgO924C777eH6MVzWNmcCrPU24hSJOGszhfHzQLZrEvt9FVRhf8ePs?=
 =?us-ascii?Q?dZy1VPJNPZjSTWq1q6l1cjY9gQw4oXHohlzZDWrKyxblIBD9RyrTJDcYhJ4e?=
 =?us-ascii?Q?WzuqQTJjpGVz4JUSELchQHMM8gVGvDnlmFXtrq0fGMu+vC8TmAdS3Qr/oQCL?=
 =?us-ascii?Q?pOzo1Ddz3a5ytUL+ortAsEXUxd2bLz1Hf8pyLQj+wGwQqdnIsCytuVE+Zp2I?=
 =?us-ascii?Q?Wu2bnvU1MiAVA1Auis40IJoBmyBrZyGu5LOtVP6X6i1uQ1WgCtOvGNnryNIa?=
 =?us-ascii?Q?royhci7ogBvpnCtzslltXN4GlylE7IBVwKpGW+Vb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8340a5-8d5b-4458-dacd-08db16c7271a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:01.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXP+DOXfXTWpc2kq5KWzoPBY8DOMkVXc9YyJKkPsJaB3uvSu4kLogOsRFYhJxyEf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace allows all the devices in a group to move in one step to a new
HWPT. Further, the HWPT move is done without going through a blocking
domain so that the IOMMU driver can implement some level of
non-distruption to ongoing DMA if that has meaning for it (eg for future
special driver domains)

Replace uses a lot of the same logic as normal attach, except the actual
domain change over has different restrictions, and we are careful to
sequence things so that failure is going to leave everything the way it
was, and not get trapped in a blocking domain or something if there is
ENOMEM.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 216 ++++++++++++++++++++++++++-------
 drivers/iommu/iommufd/main.c   |   1 +
 2 files changed, 175 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7f95876d142d7f..913de911361115 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -4,6 +4,7 @@
 #include <linux/iommufd.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include "../iommu-priv.h"
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -338,27 +339,101 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	return hwpt;
 }
 
-static int iommufd_device_do_attach(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt)
+static struct iommufd_hw_pagetable *
+iommufd_device_do_attach(struct iommufd_device *idev,
+			 struct iommufd_hw_pagetable *hwpt)
 {
 	int rc;
 
 	mutex_lock(&idev->igroup->lock);
 	rc = iommufd_hw_pagetable_attach(hwpt, idev);
 	mutex_unlock(&idev->igroup->lock);
-	return rc;
+	if (rc)
+		return ERR_PTR(rc);
+	return NULL;
+}
+
+static struct iommufd_hw_pagetable *
+iommufd_device_do_replace_locked(struct iommufd_device *idev,
+				 struct iommufd_hw_pagetable *hwpt)
+{
+	struct iommufd_hw_pagetable *old_hwpt;
+	int rc;
+
+	lockdep_assert_held(&idev->igroup->lock);
+
+	/* Try to upgrade the domain we have */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (rc)
+			return ERR_PTR(-EINVAL);
+	}
+
+	rc = iommufd_device_setup_msi(idev, hwpt);
+	if (rc)
+		return ERR_PTR(rc);
+
+	old_hwpt = idev->igroup->hwpt;
+	if (hwpt->ioas != old_hwpt->ioas) {
+		rc = iopt_table_enforce_group_resv_regions(
+			&hwpt->ioas->iopt, idev->igroup->group, NULL);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
+	rc = iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
+	if (rc)
+		goto err_unresv;
+
+	if (hwpt->ioas != old_hwpt->ioas)
+		iopt_remove_reserved_iova(&old_hwpt->ioas->iopt,
+					  idev->igroup->group);
+
+	idev->igroup->hwpt = hwpt;
+	refcount_inc(&hwpt->obj.users);
+	return old_hwpt;
+err_unresv:
+	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->igroup->group);
+	return ERR_PTR(rc);
+}
+
+static struct iommufd_hw_pagetable *
+iommufd_device_do_replace(struct iommufd_device *idev,
+			  struct iommufd_hw_pagetable *hwpt)
+{
+	struct iommufd_hw_pagetable *destroy_hwpt = NULL;
+	int rc;
+
+	mutex_lock(&idev->igroup->lock);
+	destroy_hwpt = iommufd_device_do_replace_locked(idev, hwpt);
+	if (IS_ERR(destroy_hwpt)) {
+		rc = PTR_ERR(destroy_hwpt);
+		goto out_unlock;
+	}
+	mutex_unlock(&idev->igroup->lock);
+	return destroy_hwpt;
+
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+	return ERR_PTR(rc);
 }
 
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
+	bool immediate_attach = do_attach == iommufd_device_do_attach;
+	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_hw_pagetable *hwpt;
-	int rc;
 
 	/*
 	 * There is no differentiation when domains are allocated, so any domain
@@ -372,52 +447,57 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		rc = iommufd_device_do_attach(idev, hwpt);
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
 		*pt_id = hwpt->obj.id;
+		iommufd_put_object(&hwpt->obj);
+		if (IS_ERR(destroy_hwpt)) {
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
@@ -428,8 +508,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		rc = iommufd_device_do_attach(idev, hwpt);
-		if (rc)
+		destroy_hwpt = (*do_attach)(idev, hwpt);
+		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
 	}
@@ -437,25 +517,77 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
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
 
+/**
+ * iommufd_device_replace - Change the device's iommu_domain
+ * @idev: device to change
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
+ *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ *
+ * This is the same as:
+ *   iommufd_device_detach();
+ *   iommufd_device_attach()
+ * If it fails then no change is made to the attachment. The iommu driver may
+ * implement this so there is no disruption in translation. This can only be
+ * called if iommufd_device_attach() has already succeeded.
+ */
+int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
+{
+	return iommufd_device_change_pt(idev, pt_id,
+					&iommufd_device_do_replace);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, IOMMUFD);
+
 /**
  * iommufd_device_detach - Disconnect a device to an iommu_domain
  * @idev: device to detach
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index e5ed5dfa91a0b5..8597f2fb88da3a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -461,5 +461,6 @@ module_exit(iommufd_exit);
 MODULE_ALIAS_MISCDEV(VFIO_MINOR);
 MODULE_ALIAS("devname:vfio/vfio");
 #endif
+MODULE_IMPORT_NS(IOMMUFD_INTERNAL);
 MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
 MODULE_LICENSE("GPL");
-- 
2.39.1


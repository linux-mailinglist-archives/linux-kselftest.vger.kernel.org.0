Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A292C6E9C0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjDTSw0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjDTSv6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CED4C3B;
        Thu, 20 Apr 2023 11:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8Re/Ee9eraFXJ+SGyb7TUevHWGyINvr2ylvKOgRs8jMnUzvPKqC+2bkuPUCiWwAhHGTMCctSxsM/t1KNbQRX0D3mpO73QcM+JgYLk/O034GW5wZhn6AQrSmUsxYfy53K/9DAjKMPOv0mGQ2M9+czaDBXKMXMeqyT6vQyFepp53qYRv+1WNd4LDdUXg6FKzmyMfZkpU/ZMNphfCVOZXj6GiYnlkKPJWu2auBvWCjZftnVYurmuys1ECEya64A/YARzuVOuF2VTPpO5BCrlmt8eNNrG0daw83uR/a2jn8OiDKNheHZcMkrQjsaTkz01+wsqEk8KkpcWG2i5xOBzm3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRiHOtK8PoL6hmAlORhWrDp+upeVUzBH3TwjysZamx4=;
 b=McSCcqeT5xPajxc5S9s49rllgHGQKXwSYLdznCVutHnoZLzrGK3x1lmR1WdToZjIfBIA1X2kFfMLoswn7GH0zASYDD8tz3CgHn8YxfJo5FEfsFy9hIEAgwkIOt5Z6jslRpoUVUjhQj8GwUIDG4YGl4UdWSTmLF80jqxJNVW8llN+Ejs33rQYdxVKODnWJIxLAJwcEaeVyK0Dj4VhTTFq1H4edplugoKFgXhak85FJ34Di05PKl2eL27kl+vTF+NJK+eA86wg5k0nYi8eUNMmpeW6gsL87MeS+rRvpvK6UUI7HsFjc+5kxqnGy3uF/9AoLoI9S46S4F+RkIDcGFy6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRiHOtK8PoL6hmAlORhWrDp+upeVUzBH3TwjysZamx4=;
 b=GDDaHtFOgKJhUKlYCZeyXkiLDj2V6SKT5Jp6au2tMcHsYAXrKp3Yo1d8Nnr9qC2xAyejjbePK4rG44sy+KU846VEJb5GyxTqViaZGkrabT7fTC2JW1EVaC0RRSH2JB/Gz58n69HeTgm3JN5G8omBNO60SesK0aBWDF2mDHMovBLC7fabuKh1NHjX+dPu29llp7f7P/rSlfzO09eDuuj5fGqxsF5sQjO6x2OY2BFkYSQmT547mmoznEdWxkpY1DCczyRYcXxgTIcdbPkKCbqiXWiZDgC2Fd7RJvOo7cKhZ0Dhi/BPCEjoBVK618xEEO0fyF6spBOEW7hRPy1WoqgwtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:47 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 07/19] iommufd: Make sw_msi_start a group global
Date:   Thu, 20 Apr 2023 15:51:22 -0300
Message-Id: <7-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0024.namprd14.prod.outlook.com
 (2603:10b6:208:23e::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: b58111b6-52d8-43f7-3d14-08db41d045ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8l9hBqeb11ycpYSSxYm/Y+42WVrw3N1/bhkr9TaFR4t1bm7Qf6XugSY/caBg1cKIX/PIQO2emUo926PI7FJed0jxymjV4NPHaykBYXMTOMcSVvlv7RB6W4aqhmsIxXFLiz+2eoDa44sXVIluF/RR9KM708aYgw+nEYESS76YHueilFVYV9KlR1tFsRrDXsugmG5jyb7fwomHblVzw+t2gvDKWk8L2ac+3LSwJ6nWh5UvDL9BVqJs++RjkPNkdS6XrrEriTWyFO0vMaGLVr14RIGU5AmiTvdwxod8djvkIrgOt/YepiPET9WXL8MemKtulAb+vYB/ziVyQBE4pceluvXZz4J3YstQAXfljo6UGSLf/it7dluM4d1yV/z6yathgQvw5OHnHgWckLi9jYkLhkpYdrNDuZpf5wSAPHkOCTuyJ92rwlo01yNeNGwhCgCJHtaM/PqhPAaRmiya1XGbb1rzhjthwF5dIgui/SID2N8G2bnopBs+7+QZDcHrjPDS+BEaxB5BNKhUbafpYfPwrgO/pbm7pkA2aQ3MZBHIlw7U2neLBPb1/Z1YESy3v8ZN06USiBSmNaNWKdA8ZJzJ40/AwG4NIv2rS+aiCymQHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m3dOOztnYagI08GAp9FieiHUzAmxxdWzm5Uv0U/C890JXWKqnbBEJ/6w8Z/b?=
 =?us-ascii?Q?htycLdcAvNw9taTddqMpIVnCuEH0JSOjTFSiWH5/xIkKO7Wxa3l090g/BorL?=
 =?us-ascii?Q?bhtHty4edrcwIqlCafRIHw7hZxOgZtVc6QWI0AcyVSqnJabi0dcjgYuz6hQf?=
 =?us-ascii?Q?b649//LYYJ3XkTaAY8Ng1is65y4jhTDBIaNeCJAehtRLSnOm2x8jhSigVCK1?=
 =?us-ascii?Q?jKOaf8y0yMS4zPX3UWb4UkFRsm/MLpz1h7kKJsxtYYXCaTMjjPsYSlV5YrXT?=
 =?us-ascii?Q?JcxigjgnPPDGLQQ3MclITm0sRk/PQlyNm6c4p5AELlnaz4STAS5Qo8SqbZ6l?=
 =?us-ascii?Q?PkxL+Ixhx/0hRnXCWc1rzfVqWToBLRk0HCMduU7Lddfm+QhwkTPK4oohKGDo?=
 =?us-ascii?Q?WNr6mIDlHmOVOWqBiTsiOlK7uodQGshs1iib+h8GhZJSuTA/YcbupHQqY4ev?=
 =?us-ascii?Q?GZBQLjmmpwrOVC84WKdP8zCa3xoy9ISE9Mt3KXzqUbDE/z0uFtCufySp+Xhf?=
 =?us-ascii?Q?VLxs1oTyoRqH0vwWpjOywdTYu7uX7cmeXn9kQrNVVLIKQIMMXTiQ9vhe8wJC?=
 =?us-ascii?Q?yy476PC+b3TYWGiDKQr9ylX8SxiWVeeVgxApPlFqnW45vpzrzbFWZUWETIhD?=
 =?us-ascii?Q?3tDAdnlYV22iBKAb+1FKlB0DBtDlr2tIYPRklbPDJqugPedsLtzat7Qr53SC?=
 =?us-ascii?Q?wiWdL1/8ABOfoOGKQ5ZE1ka8/uzYetQLOoCvd6R/0DHul+OqmcTJPG8XmBLX?=
 =?us-ascii?Q?rBNUvgtiF3eFQQ40gxmr+OCYrlsfLNio0/Ym23DAC3xKlaFbRG3wN3RY5Za6?=
 =?us-ascii?Q?QIMzNWST2F/a1fyXwkUm5ZQcpvfk8cJ/xxqPm3tz4gLQ36sPuU64S2OWD7gf?=
 =?us-ascii?Q?P01szfSf7DO8CIjMX9sXnn5yQvWJ5htPEZQdTeMtgx6j2dYrGQPHIpuSJ+Ca?=
 =?us-ascii?Q?YZx0FEkpTipyQazlWFvIGJm45b3FYxgtJpwrnabRwKXYX6K/MCwahKUuzmWx?=
 =?us-ascii?Q?hHfu50kV+9lG8mwW0piAwph5Rt9SoDEJMcmhAJqVcsM0pT2mBfEc3NTyfFVV?=
 =?us-ascii?Q?NuMx2er5etUHF/nepdae1S57AVZjUyACWCgQLs+a6iuHAYoZISu+dUXCL/ir?=
 =?us-ascii?Q?v4iwv5gqCMcrJHM6sH7VbYleq26qP3UhtQJBfwwru8JQK0q9OSkXRTe42iaS?=
 =?us-ascii?Q?piYZf8ovXAjaOLjoLsDzSZZHReBkU/2FAnR928Y6b1K4Ce9PdWBNKv6H1wvl?=
 =?us-ascii?Q?JcDoLPfsc9Z16sMxbOfu7N82rCBgQTawMTTpuzFNoWR4+ORHvbmee2R5xfHP?=
 =?us-ascii?Q?xlDJHkiQfjvOpwc7aNBhwyfkigkGPBFWVulNjRDvb+/0iW8mFMrE1u9ECI6H?=
 =?us-ascii?Q?QBvprqa4gHGmY9KZdiCBbc6Xy2jqSouudyKz9pMdFSsn76NM6CiLWispmZv2?=
 =?us-ascii?Q?I9EqreWVrPaOpabXsFYs/60NGZOOfFYio4q9EaXHC7ZuZQh2Bi8TivmQYyqn?=
 =?us-ascii?Q?l8hYnzoMfdh0kLqTvIKdfXkcTZgtz15qdBaK6CrPOoe+oOQwEH0wzhLgkF6e?=
 =?us-ascii?Q?0bhTe1+T0sjEe3/PlC8R6TC0Tqwf+1ivncw91WVP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58111b6-52d8-43f7-3d14-08db41d045ce
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:38.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjvybQCEGZaMAhjIoIW/W2iSzJm4ImvCWrzMPI1k2Ify+PzOsX55X7dcroB7i2n8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sw_msi_start is only set by the ARM drivers and it is always constant.
Due to the way vfio/iommufd allow domains to be re-used between
devices we have a built in assumption that there is only one value
for sw_msi_start and it is global to the system.

To make replace simpler where we may not reparse the
iommu_get_resv_regions() move the sw_msi_start to the iommufd_group so it
is always available once any HWPT has been attached.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 14 +++++++-------
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index c0bea7c1760e67..59fca93bbd0c47 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -88,6 +88,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
 	INIT_LIST_HEAD(&new_igroup->device_list);
+	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -249,10 +250,10 @@ void iommufd_device_unbind(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
 
-static int iommufd_device_setup_msi(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt,
-				    phys_addr_t sw_msi_start)
+static int iommufd_group_setup_msi(struct iommufd_group *igroup,
+				   struct iommufd_hw_pagetable *hwpt)
 {
+	phys_addr_t sw_msi_start = igroup->sw_msi_start;
 	int rc;
 
 	/*
@@ -285,7 +286,6 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
-	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
 	mutex_lock(&idev->igroup->lock);
@@ -313,8 +313,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		}
 	}
 
-	rc = iopt_table_enforce_dev_resv_regions(
-		&hwpt->ioas->iopt, idev->dev, &sw_msi_start);
+	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
+						 &idev->igroup->sw_msi_start);
 	if (rc)
 		goto err_unlock;
 
@@ -326,7 +326,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+		rc = iommufd_group_setup_msi(idev->igroup, hwpt);
 		if (rc)
 			goto err_unresv;
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 22863759c3bfb0..7f4936cf537be4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -267,6 +267,7 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct iommufd_hw_pagetable *hwpt;
 	struct list_head device_list;
+	phys_addr_t sw_msi_start;
 };
 
 /*
-- 
2.40.0


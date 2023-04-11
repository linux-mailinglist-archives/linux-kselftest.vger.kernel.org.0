Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2066DE131
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjDKQn1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDKQn0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B83526A;
        Tue, 11 Apr 2023 09:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9Lj8uCruHkD9CgSkeCQXtCw4bCgszVillP95YFkwV0VX60KuYlqJ57g1vfrAy4giKfvtQGlx3fBNAznGrY4KDgkVIz/m/qujf924untYbvxwpO84LJ36KWps9ZGms7tWq3BUx35Qg2D+cSDMks38PAfB5tpBej6Q9YvabbPoHaQEvyO4mkkkL/rc4eYwl0ll58HB4YpRNxu5O3Rt4amrZvTQEf6G5Fz+F6Yicfmt/MBOS8uUJG1bxs15LbnuiJlucl8W/tt09tLab1Qzkb0+NC+bGDGOO86/gm5L/iE4pNQ318bZpY5MaNRFRfkuSVruxUhjkBpwp2Ju4JkhrHWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKjugjFWk+NnRMEu//zOrspSb5+B3eyWSMVIVoXMZug=;
 b=CvJy/ErX8UWE55wpKf8YBvhrV3w4aCPm1Q+4W1mKX8EuYQH3spP9hKtI3oyE2S1S5zZtoXB0TQMORaHMsZh2Q7Nx/QTKZmpRtVsePc1Z234etgnf6QwZF+ekdUkCgeMLURg7j6NIS1sR3MPB5pAnxGw2tGSo4qrzXFmutjU/7g75dpRxG1vE6PD7vjtzjh4VTc8Xhr98Ab6pmvFDw3CWIlUmrBbqvVMPE2bdqA5N/M+mtF/ucPuzwyw9CbNSFlNuVCSbnfUSCwVo2o/r+/xNrKQX/1BQzBHgKzXM6CwP5C3+31exuBouWKpQJ9LSlSHtjh9M2E75E/L1Nn6motmcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKjugjFWk+NnRMEu//zOrspSb5+B3eyWSMVIVoXMZug=;
 b=pgUczT0YoNOQJOqzNT+2BasVsS7evDLPDOGcHqBbTK5LhPojHfytYBIanun2u8usOzRLnRA8o+hww/wkDMKM9rizHbS+JntC/g2sMsDuTsQfEaXl3pWjfzvh5EO81QEymMnWUr7mTlStRAZHBUEwyZsnmwKa05Tw325tx/K1Z4gwxPSaVZ/wa3HDnK4tIdDnC/DdW63mDyA9z6ixmh7VZ0GrJzlAhIz2KrPB+sRPsjhUBa9OF+qBpu2QlyHVJvSyzv29RtIRylKp+5FKqzYtU1CHDjMkgCw7rNcK/SC+liReeBI0Vvvq+3AYeh2YPGDs47jedpHflY79R8F32JXxhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:22 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 06/17] iommufd: Use the iommufd_group to avoid duplicate MSI setup
Date:   Tue, 11 Apr 2023 13:43:07 -0300
Message-Id: <6-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 40dca913-a6fb-4fa9-71b7-08db3aabdc5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgojiSt2K5/y7ourEWtwLQpqPMTM2ztljIAFXNY0qDD6sVhQr1beWA3LOV+CsMBa+6hdjfq7qnOtd5mvH4oK7MJ0PgjsqG22xsljfP+iAGkVlA91X7l097gekZhw83bq5+UwIZhp/DZDAM4X/tLgSecrDCcwLAke6ZTBQ5sU4T8O4qzltfOIY1VzGnGcYHz5BL9CWDl5wX9GBpiJDw5TSt/YnU0ZHJYDVsPxDP6wLfGGBFoRjKzhJqcEIEY5HDc96yZ5/4numzWRm+jnyTQhk0s9WgwGXyutJKk4b8DNjtkYl75lo06Uf/K6GKmI0/235eTVCkVCxg7chOBREqcGIMr8uNN8zBHt276c6iF42YxAo+TvX6SLR1jw2o9EAKJcN0P84n8qGezXguC4uZHrQpfYjRoXlKeZlXFRxwpX5Sm2FWNHdy4ytEl12nGWovZDGuF960w3+jUcUgN7vHQrP8fpshmhNjGHkXyJ9zenKgwLPHmbEB4/TFInpsDYvlRT+qa2w2nA6GVF5MqiAQfi9lr1e6MZAc5u4qO1FV618jpPCRtime3cgHZdYdC6RlnLAELIglzk1lToIspA3CZD2B8LdfQE0PSGlLoaVmApYrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7MD/m+yJ13jjrraXZbGoDeARikLWgJ3OFUlQva2B2wD1WeCnGPgfmOTyIsFS?=
 =?us-ascii?Q?x7J/vSuryb/DkeEztpbONtGLgB1Y+Cv2bookCyu4caXafScXSJ2UEB8Np2Pq?=
 =?us-ascii?Q?qgeD++8LrgMGMMEm6zocmGi8lhXahHKcc9rbG7NWUiZAREfF4yTtX4qRJ3wW?=
 =?us-ascii?Q?/X4N3HibPtAuDKk4Ne0lGE2Z6AjrTNKUOq6sJJ//ykLXSwNgBeubiZJPt74q?=
 =?us-ascii?Q?0EHS9OaJEQ1OiuwOKW53SceQgmVEexBgwGGZJQAImKpFugHvjToCD6WbSyzg?=
 =?us-ascii?Q?aPpmIGksIrFwqScsZVrIEPqmuro+YWoiXJGT4Mxyilq47EM8UUf727Pp9RMx?=
 =?us-ascii?Q?7Y4CmpRAAPq5cKmBjFf1lcZrwyDVRPClY3qlL1lTc+rU+/6vQWK2B0MifSBX?=
 =?us-ascii?Q?1k6sFCS3SW0U4Vhz+mX/onvcnjelPKQhY78D0XoDRKuiDeq1aX7DpEvt9Z6k?=
 =?us-ascii?Q?jwF3usfCbk5GgDeytxvTOPmUmOWePLF3z+UXVcggp8taO14H79oVKsW/RjxE?=
 =?us-ascii?Q?D9UYOko5CXCry6CkNzcbmPHzsOlhx6e/Dw2w/RoFiV9TgceMRBbTuufxR6k2?=
 =?us-ascii?Q?JkO/WrkDmhDvBLKTxdYcqYA5ZQV6ZMpD6xv2UQsIMOebEac+5VKSkaAOUizh?=
 =?us-ascii?Q?wPylsTFev5sSXvlScImh0ZX05jMwsX6VPIyGGv7bC2HRjG3AZIOq3yAk6ghx?=
 =?us-ascii?Q?J3WVABuCgpg5bFlXoM3tqgzMyxhv6Sf0M6Imw+3hx4is3oe550cDMdwPRfdA?=
 =?us-ascii?Q?fQ9hE7khIbwBGQ49HyqA9q7gGXrs+8qjV9vmLJwFMGk/b813N19zYyM/RKCm?=
 =?us-ascii?Q?kXS9zimTWwIF98jNq53Sjoezl3P0gtr7tmfiRXbRE9ZmrcPvlakUdp50N1em?=
 =?us-ascii?Q?wZNUCCp+dUMexCkrYwabqOQi3f/mT7aemEulfcixARGUcV5egfQTn1B7IwpC?=
 =?us-ascii?Q?7IDMt+IZ9TZRi7OcQmvLRWljWv2NHSgEWzUwpFmV8E723G2W5Rj3Ua9tPRWH?=
 =?us-ascii?Q?gZx67TK5As6YZbzQ9jmi2cf3myMiF1v2dqstUzH0e2pHkF4xfVIVviRWHO68?=
 =?us-ascii?Q?MxkhRGDN6VCjewpuzUbjCF7A+5/RV6leo8rcGebZ+w1h2w/v9Bgg3FnUoPwR?=
 =?us-ascii?Q?OAtATVaOzGzSTgVLaRHvLblLXNtouascFXcfhVEG5RakGBT715SbaLoTeN7B?=
 =?us-ascii?Q?MPjsawyrg5RVbmQmtFm6dUBn4S3KVYjpf61Rzwtf1I52Yt3PfKjtRgvXXf+U?=
 =?us-ascii?Q?2l5K0J6tW+PmEMiKYNPsBnpkTidXu/06jhEPdP1HHyXf5Z8sUo0/qsk+b6G6?=
 =?us-ascii?Q?FZ8+QpLJgHf5AVkWEKdTfO6dH7wcgPRGWc+WzIYjPSoK7sFft9uxId20mT2p?=
 =?us-ascii?Q?WigFoBwxXc1XHw+6YLJuuCpuGvTZaxep8z3nz4loiLDy93b1hbtT58k+ZAtT?=
 =?us-ascii?Q?Z4czsJy6/qRdPq5XoYs7DsMmNc14MUxz4SLZvIOtV/Edw87NsZmKKFxVjNZp?=
 =?us-ascii?Q?6MCdDp2+Cj2KaNLy07JoaTg7KUcgHHE6dcieo0omNtkKfZ2+zO4XHHO95Aia?=
 =?us-ascii?Q?ZOGt96fnOpm+yHIOMKSx6oLzQx52KWW/X4juiiWu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dca913-a6fb-4fa9-71b7-08db3aabdc5b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:21.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGd2tqN5yO+E7de7tAlnyK1HHpRwOKDxogctmUeTdUuwWOPphpIFOnNZVGxjH4fj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This only needs to be done once per group, not once per device. The once
per device was a way to make the device list work. Since we are abandoning
this we can optimize things a bit.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d2bcea7d9da815..b02f98dc02c284 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -315,10 +315,6 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (rc)
 		return rc;
 
-	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
-	if (rc)
-		goto err_unresv;
-
 	/*
 	 * Only attach to the group once for the first device that is in the
 	 * group. All the other devices will follow this attachment. The user
@@ -327,6 +323,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
+		rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+		if (rc)
+			goto err_unresv;
+
 		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
-- 
2.40.0


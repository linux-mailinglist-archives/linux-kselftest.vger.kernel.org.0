Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35FD6C3A13
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCUTPM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCUTPJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:15:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085D4AD11;
        Tue, 21 Mar 2023 12:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiltC9Yq8uWMSpA1gNacjKX5kNZ0CvacY0p4EqiXoIpx/gsii/PDgUUg9C+0y1ZWTy6+Cgke6KCgjOJVmcJl0xu5AHXuTdUuohsx4+somZtfUfwk6trqKwlyLjkw0PapAaMo/WRJBGE4Qdf6GbxiYvpPNpXp/WMACuQ1aR6C4H1pXg4BDbtZtcfWY15FBbEUVwLY7HrnyZqht2aB4ukDxTmYqXPNBdQB2sPYyx9b//oTfsOe/1W1s8fQaWk2XqD9C9+BWFTfxLGXK0gP9TpaP5lKMiO8g/HX0XxYwEczhyaadVqWpgxOkHEC8yjL4WsA23zWFy/ednIcwRoOrtpzwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfvhZui57nmqhoohYoRzvsiDaJdNrn5U2mmVXiFjE/M=;
 b=MpLsT781eCtr9fLwUCTmbI34YnHWPMjxWybtHTg4lpZcttzghOEsmOHVtfibT/1mn9w6HhXwp3KDUB0kshnvORD54wpogRGpn8Ze/Wb2l5nVaHTzdrhr10D/1dV0xHN8rWHQTPyW3i4oNDcz0i1P1EdHc4DhX+S7020/YoHhRDgcRpU17GWMT6uG873UMvestWhwNddygCqQ29/GgFAXEJTWWvQ/6na9D1YZT0GUStAUteEi/S0Zm6qMdxqMsv0x4QbGu67YT6mjzud33fojvNR6Mvi2VzL2zWagN1a1Ca203KAkMcf5KSV0+W4PSBZ86c1zwULaLb5ZuMzi3Yt0fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfvhZui57nmqhoohYoRzvsiDaJdNrn5U2mmVXiFjE/M=;
 b=GHmMBFm0Jb2hwMMMdJcjiIV68ytnO3c2nc9sbhb+QUfpu/rl9Uc1kBrxtpsa49FwJr7R56AAgKS5p8HZFaSnS13VcQ9lQLkfLCik5c/bvwW493ieRH6EsHAlS3VNIJJ3uFIcAQHBqkBX784rM/4803/+7FjGQtbamTQ+Vq4ME2sxhn1UoCHUvYX5U9hB5odd6U0Iw6SvXDqKlzlnwwiysa7HQfmFd4tsOIUvV43NfqjUz4ENCyWOL/onvw+vDPw9XRtlCYFQS8D9uHIOvPVO+Z5MkX03/rF0PqSEQagnIG6xpNDhTAAqc9LDU05a6UsHYc3cnHuBXOpGoGgZEP5RMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:55 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 06/17] iommufd: Use the iommufd_group to avoid duplicate MSI setup
Date:   Tue, 21 Mar 2023 16:14:40 -0300
Message-Id: <6-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0025.namprd22.prod.outlook.com
 (2603:10b6:208:238::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fba391a-d49c-427d-3d3a-08db2a408d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBQYTZKJHrNnq1/bJVUVb1pK9ekXLTBmKEFrrNG+4SFf3ulLfDtUyQOhLHOjhzDwpjfpGkh/akk/dXqbqVYQ2F80xL9Be496hkuw23UQ2nVZvNxmI5I9yttiCCyq91tFPM/hUO7mL+MIjT8Oqdbzuwiwbj8ggt5KEgtyZnBVjStyPOtYTSXX2530aFvbZSv4iYFBd6gh9aS4wkDyowc82+5UfdE3xAWxyvoUBw4HxDSyEGXsNNffG+sMD6FHbpmw9tBPEJB/Rgp05sxur9hBD3cJI8U1yoM/X1yfVJFlr9qEPCLPprlspxqWoQsRVvszR7ka/EwMjuIWGLXX2K+BCahVWcOSnEErHfYr+cbo5FUAkWDfdaLqjyGtb90QO4dLU6Wp7ZKlQxNcyPCCZwI1PKRcmCaSfhTlR/ATTpizxp0pEzrBohj6YXs3tfoK6FhNng4AnxhOBlL8xxLd6pQsva7SJ9bvikYEgQiC7oB10BvuZEQaBBp4R1Kf8r74VBTmwfP2dW6x5JGyS+KM3I4ov9trLGJ56r+xRy4HYMcX31GEQTPA0NDUr3MWMzI8aJlPL5vvrqVoJwjYxRQWMQHIbv0iIOXt1w9WW3w8dPppXI6szl0uvhi0Hc03okBvNTtxNojNI5/nsgEdMOQZBIbBmaOxgH6+auv4rLhoai2QhTUq46CEpe5h2QiqhhNV0e1N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(38100700002)(36756003)(86362001)(83380400001)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(6486002)(8676002)(66476007)(66946007)(4326008)(66556008)(478600001)(316002)(54906003)(5660300002)(8936002)(2906002)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MF2Ka/c9Ecnk3JiNPKGBnmhN/Gex/cufT9Bdrw/0JlxmHmVeA4p48hF5vO5i?=
 =?us-ascii?Q?D+kBuJfyUIwRk28u+XVhDXvk6Z1RZelLPY+IMIA3YQ7B/DUxGWPpPrQ1mW5/?=
 =?us-ascii?Q?o0cY9Z/YUJedEFqsLyvehggEaRIdmEXZrI5ak28R00hvZo5YWIe9To3XyFS/?=
 =?us-ascii?Q?EiF7GwUKIlMoqlDTBa0su1XN5+v8pxuIq1VajPAXZz8njGJU7GnQx/GxaC9C?=
 =?us-ascii?Q?+oKZa6KB1gOAaKBznW6MD5x1R8aRTRbijjDbw/7c7DQNx4OOnCl/slFdN9k9?=
 =?us-ascii?Q?/YuHGOP/bvA9laOzkpzRlosSx1XXaLisVe4305Ch3ErDssrPS1cTyCu25Nkf?=
 =?us-ascii?Q?5p+2aot1u+Pw4fT51+PYWS2w6p7/5BPGZMrPmhKMGia//GBZE0HBQdoaOFSF?=
 =?us-ascii?Q?AzKPEM31H/cQyuPvYUhyUlTjK8qecz6DJJLoWyoaLVjTJBbhUwjgI68IRHIG?=
 =?us-ascii?Q?Luxaf/vaOSDm5rS1MHIyTrUcjldWIY4FiSk3URUAhr1jsJqFkOgjPns3bXAA?=
 =?us-ascii?Q?k/sR1LiumGFsbApT//4Fa8ZACFqTiP4S7QtsVGQl0uKgq73FRvVYM77SiRG1?=
 =?us-ascii?Q?BcaENAdMzu/D0Rmh8m5Iy4gmcNME86UIU2LphKM5Ecksp837o34fle0MdIeb?=
 =?us-ascii?Q?rfsQPDY/3whX1F7E9sSdub3mq5B2xVWm/2/WOiGFWfiVRc2fgNQwzPb3kBSG?=
 =?us-ascii?Q?do0HuEmqE/tZoO8gRuZKrpzIJ/9xz2nH3Aehxe57Q5KifkACHVl+vx+S3tkd?=
 =?us-ascii?Q?U4WPd2S8K0Iu5mWBCL5IzgtKKezdblgzkPg+zN6EJYVMWB+XDDmwIFvVpuHb?=
 =?us-ascii?Q?UyzFN5aG8/qoI8jTqi0CwGGPZ+wResH/fm+8P8b89lN1bzjmhX9a0F3+Jc0O?=
 =?us-ascii?Q?lsPZUHxiIAbQBiEi1wGI+2Z8baSYZFVPq4L/hIXP0v4V2X22m52OiiqWTYfU?=
 =?us-ascii?Q?RDcMczXLzMZjLItVG9pfQ1i0yuyd+iqyUz6e75RobBUahCTKoVi+xBy7Wgue?=
 =?us-ascii?Q?OXfcvt8lycD5Ns1lhRMgMf6mm48as4PeL6XOIuZMUOJwih9+ypOs5VPd6qWY?=
 =?us-ascii?Q?c5rxH9FAmRIl+310sav4rBaeqHFVxfRS2TL3evTMCp8Zl/1y+icCNnQzAxz+?=
 =?us-ascii?Q?bQQ7ipH5fD3GTdm4srLJWUditfBqWcZyCkxYdrbnRIE4+rUPE/gaBX4KxfKL?=
 =?us-ascii?Q?1JQCIeCZ12VIbGaDUIDoGqZxBLh+EPwEmHMwdHKAel05Q2MDqlmxbfFK26B3?=
 =?us-ascii?Q?amaC4NiVNzv+YFPXgwso0GNl3Ut0fBJbpAqyJ4xRI4DMGwYF/yqXv67+Kk2v?=
 =?us-ascii?Q?+IXxpARnykFLQHvi7Xe55IXfvYqUxLpmpgwUCnOMx3di40BgQElDj6OMA8Fs?=
 =?us-ascii?Q?XhHyrCn7wdrgM5o5VLk9QmbU1ZtJxRoKhsrM4dZ9tj75ItpiF7QIlBbRG1sI?=
 =?us-ascii?Q?tleRLotxjl9IJJJdQgAq0SgFETLC/Qb9/T1VoziITE9O/cj/iNoYny2Lw1lV?=
 =?us-ascii?Q?dHPyjjG2/qWuH3YwLuk64FogS/i3RXFH6iTmklTHu+kZLBPWmjTr439mRT9g?=
 =?us-ascii?Q?wV979jprJTiZ0pDNv1+bvKPRdfAUqtmAaO0A6OLz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fba391a-d49c-427d-3d3a-08db2a408d39
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:54.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaadGP32ev6HJjtVFSRpWsBQRvUMNkjePhlZ2Fv7Ba7HEp8iCxE/RU6cT2O6ccvT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 4566833494e076..7f063b679a24be 100644
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
@@ -326,6 +322,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * regions are only updated during individual device attachment.
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


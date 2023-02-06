Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2668C630
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 19:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBFSzC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 13:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBFSzB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 13:55:01 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EA72129A;
        Mon,  6 Feb 2023 10:54:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt1lBQi8XR9TMYuJxUjIWWY5yr9Jwyx9d1gtWhsNqi3gUUZ/I3Zq5d925R5nOSZ1JgK2YWrgKGfOdY4z/cq5ZxRDQdKCbslrtTgDyTBMwdKccPquc4hg9NZT4My+UkFBe0FsS89E7V4A1+VQSx9OkL0C9f7OJyZ48rCvuKgW1wqhIN/LF0FCajQGwVIonwnQQJdntngwzTSiwJ2eMV9yR12CV3cyL37eb5mFXOWjFcc8p9y25tUg27j4dUCmhBD7wASi73VmQMYBCeUjARNDki/hRHwedIIl//NidFOAE7+Yr45wpRGSVaKfCuIAujKa7hSdVgZtRgSBPInSu6sasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkO1woDYPm44X7pLPjZ/77UZ6tDWTYrKe7BOoZJBisw=;
 b=es/oBoqzOi4fsEaBp/U89LXIS3UND/z0tQ+6lKXrBDpOlez2l9EDfSf3KPne3dQzhzBdXo/jVU1zdhwBsRfyMpagmaHrl0LtRmwtqw5ZDtKCrXYRHMRJ1gH7DZXs+na8qVv5BmrBWev3wvYbWq8RmLK3A5YHH01gga1LZoAP/WcC5VW1tcK+fVFbm8RIz1EljG6yH/TdQornCCGiSwaQZ536hCGRZ+3OiwWwGWsY6Ard+R8jR6ER/L/tIOG2ZS1Nh763Gi2lhGfkPGTwJaNt+jm822ed+HxI6lfMBdngXm1lwfZK0/Dae8XA9roPznL83JZYOjet5A9VKcJ6uN0AVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkO1woDYPm44X7pLPjZ/77UZ6tDWTYrKe7BOoZJBisw=;
 b=SmMPJWKu/hudDuYHyYY3vBnA/vVzmUO7XvtYcOQqnJLWMhL02NDGTUcuUBtVHrqn6socBCdyCVCAk7ulVAfwJAQaKjUtZYniG+J865uYRnS12ZHq+F7gYaC49ZOeer+lQt7XpbdTutzzgNHqip+/jBXtih2j0sGgeGygutDeC0y35XmeuebpXKzfxj8mbrURHqVYtK2tOYub1nVjtUhCPBcl9EQSUeASR+0iR0mLoeLi0m7iy+88ELqWIa5C+3Mepi+2a17l0xKrI8pnnc9kuga0BQICdXEBrmCikUw7MZeiehiMCnSe2iLMBNhf0Xjr+eWE3K8Fx07dsWduYm5KvQ==
Received: from DM6PR08CA0053.namprd08.prod.outlook.com (2603:10b6:5:1e0::27)
 by BL0PR12MB4884.namprd12.prod.outlook.com (2603:10b6:208:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Mon, 6 Feb
 2023 18:54:56 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::34) by DM6PR08CA0053.outlook.office365.com
 (2603:10b6:5:1e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Mon, 6 Feb 2023 18:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Mon, 6 Feb 2023 18:54:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 10:54:53 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 6 Feb 2023 10:54:52 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 6 Feb 2023 10:54:52 -0800
Date:   Mon, 6 Feb 2023 10:54:50 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 8/8] vfio-iommufd: Support IO page table replacement
Message-ID: <Y+FM+qRHLU6RSJ16@Asurada-Nvidia>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a85ebe54c2fff9ca134a33cdf8744a7c1d66feef.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB527655AB356F73CA193300398CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527655AB356F73CA193300398CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|BL0PR12MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8dd3c1-fa12-4a0f-84a8-08db0873a3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yxM3zqbh+OSMgypQPcBLJOLOe/ufqHcfGgCVUTXvtsyyDrRxFUEnUa9S2sTDH7+xr19a7VEgfUB57ZGJFnNeCQ+WoOujKBmg2E42mZ6uwa6gHdnQIxHrX4x+AUJ0+RK9Q+vazslt2biMTJQy8w5j++1uzP1OI8y/fhHPLRaUOmWX3AWn3iR4tPjz3udlZs9rp6w3hn41zX/9JgHO0vFvXMOn+mnb94y5BrII+akYxDHS57KNRv/B4oFJHmnmon7tBGo0r/OEcC4yBc1wAASiAftihNoRieRQZsGqsv80Q01EwuFaBBNU9fd+zkf8q6wKIPH26JXLGfo5Z5ERcHevQ/1qvDJOFVHNqw6ZMRRUDIAltQ8aKl3v1sFwezTQqIBYfHvQDqcFIG9fiz3zrJQaRPS19ZsdYCTEhYuqFPMqanzfcQdd3etUCRjaKAwFQPFWhJhJnTKcDyBQrOWkI1rX8CBfQiiK0vyRggl8tx1N8pXPsT2OPlkyFN10yAjK6yFHSxhyFjpSvszoEG5ndgYus9ru2o/r8omnXqmERSwni0KsS1aVQS32T+S3kp6VyZf9BmlKrSJMeAE+EKWH9MgYDPfn5dkqtwVTpt+Cx/PqGcwxa5Ms4wePcVXSbgIzora/zXcw6s3hnkhW4WANbfld+3PxRzLLHXrn6aOAk/pcY4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(46966006)(36840700001)(33716001)(82310400005)(356005)(36860700001)(82740400003)(7636003)(2906002)(26005)(478600001)(40480700001)(55016003)(86362001)(41300700001)(9686003)(186003)(5660300002)(83380400001)(336012)(426003)(47076005)(316002)(8936002)(7416002)(8676002)(6916009)(4326008)(70586007)(54906003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 18:54:56.4394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8dd3c1-fa12-4a0f-84a8-08db0873a3d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4884
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 06, 2023 at 08:49:16AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, February 2, 2023 3:05 PM
> >
> > Remove the vdev->iommufd_attached check, since the kernel can internally
> > handle a replacement of the IO page table now.
> >
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/vfio/iommufd.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> > index 7e09defbcffe..f9e89b3eef69 100644
> > --- a/drivers/vfio/iommufd.c
> > +++ b/drivers/vfio/iommufd.c
> > @@ -111,9 +111,6 @@ int vfio_iommufd_physical_attach_ioas(struct
> > vfio_device *vdev, u32 *pt_id)
> >               return 0;
> >       }
> >
> > -     if (vdev->iommufd_attached)
> > -             return -EBUSY;
> > -
> >       rc = iommufd_device_attach(vdev->iommufd_device, pt_id);
> >       if (rc)
> >               return rc;
> 
> also update vfio uapi description to explain the replace semantics.

Will add that. Thanks!

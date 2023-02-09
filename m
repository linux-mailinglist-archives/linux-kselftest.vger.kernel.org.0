Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EEC6911A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 20:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBITyW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 14:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBITyV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 14:54:21 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF34512F19;
        Thu,  9 Feb 2023 11:54:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RajTDqa3n1CSzZ9l8i/21Vkb05srnfTlg5QU15gjQVAttmFP1xMzEQY5N0RQmaEKqsVWXjhvDVIXe+wTeFzQB6lKLs6Dhw6J9WvpED5uclG3uicgXEskAAEEQNUGJzAJzfB5olSmmsGW+Md18kFf7Z7HsIvrXOKE16AksEq9H2TN/Lpbe9n5qRbQ45TGOTngO0Li9zB3r0YR8q9cSGfuE0vHGcfeLovtFdBLPwFs2bDjVomYLu1ACtvyggZ97G76S0UqlkxUXy7I10fTISQeOpKG63uTUH1IN1RB6Pa4CVzXttO8ZJ0yaA/SaghGcVpG27FoFJn2gSAHVYMSazoL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCDYzWlFYAdtaVyuQgtMhybo0OMzEbL4PAHTuusIAr8=;
 b=oIUJxJ+Hgh7VDveZxqyLBcETH20IwIPWNSMIzRNDWzKhTsBVEiQfqd2Z6P2AYfC6L1N3KDfBTlg5v5rYlEI/2PNGpeEUBihlu6kJ0doSWkmf3IwyskC8kCsQIf69GSx3uziQrp674qj4rLjbG4fczQ1hNgnmQ1pD/xiRZ+3yOCqKH9jiXDUd/AKNmuGrMw4qQoQ+l+RMeg9b9n1YJLSP89W9gqskRCaWcPBFlBnlLx0FYME5ep/tJ0XZT67yNxL6SU+DIcDhXvyCZFGAtzA7VAWAf0kBLBUm2dgtx4nMdBPKs8z4UQhtju27es+2wD36WiwRYU++sI8mSFpLWV5NBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCDYzWlFYAdtaVyuQgtMhybo0OMzEbL4PAHTuusIAr8=;
 b=uG4X+X7pEADe8Aj/A5Qov6EuN0yUNbTKuK3EmVqyGNCuGU5RvscJ91qROlinta0NiEdTR5tAqzAdt6R3pYdYiFnC33e9Nnnn4PNqd2jPRHUbL68SLh5Jlre9PgZrl8Oku/ShYxLOv+M78weo41HUN9lF0lmF5jqpEiZNHr9W/Jc4RkReJ4Gne5uRy+lqwQ+ZgBmazKsYBzh0R9oGztd2iAr1oYddFuTHTgp9yVFrCOhkypcuxzVMHBisfPoHi2GGgyPHlI2cV/R5Ovc4EMRHmhTrjAYnz3z4VmqLGyxUdwWG4iOvUYkt2w1NbqWrRhkdzJqaxUorSn9FCS+VHQ/w5A==
Received: from DM6PR08CA0031.namprd08.prod.outlook.com (2603:10b6:5:80::44) by
 MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19; Thu, 9 Feb 2023 19:54:18 +0000
Received: from DS1PEPF0000E63D.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::a5) by DM6PR08CA0031.outlook.office365.com
 (2603:10b6:5:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 19:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0000E63D.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Thu, 9 Feb 2023 19:54:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 11:54:09 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 9 Feb 2023 11:54:09 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 11:54:08 -0800
Date:   Thu, 9 Feb 2023 11:54:07 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Eric Farman <farman@linux.ibm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>,
        <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v2 03/10] iommufd: Create access in
 vfio_iommufd_emulated_bind()
Message-ID: <Y+VPXwjMhgWe/c0m@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <6083ba9a3c1d92baf1f324d4748333d80d3de830.1675802050.git.nicolinc@nvidia.com>
 <c5f5b03420367dc4280cc54c36dbe03fb34fffa0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c5f5b03420367dc4280cc54c36dbe03fb34fffa0.camel@linux.ibm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63D:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: eb61232b-18a6-4535-07b3-08db0ad76dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPDmptlfANVd+gL3ow58knIrfsYqNUTT9Ppgbfs7PWlX8jO4MRCGxoAXqGwmdduaKZcivyih8dEcp57BxjNtufcyPGqrb80jJIyNWZ/a1AESNZixYhFToK8y3G2shwoYnAd2poSrkaJC4O0fOUJcX6a/WBJ0BYL4xpUR+TSzKhjmOjuWwxsbsMnGumB1uASahVpQnIQg7CBkG2xgQNmeGjebIJDF7fOhlfHqY8ZS5WUepzY4VKnfOPsQm71zopfDI050QYvSjdh2jWLBlo5Rb8Hegmw1slLh64/HL7liUFnmX99RLgAWlPg4v/MC78744P8etMuAllCogfFRje+uTePV/RNuKhPfg9FiA0aOjGT1ygXTxf6nDT98A9xvZs4JaGBfzw+0+uARzabi/ig/o2p1ROgpLPTZsRe17w+tgDQUlHNyn2YgqEcUEWBCARR6m6ol/bG0PEZbS8R9ifZ/nHzhHOwzxV6TaXqgWzloXbgfQGtKTZnmgIDcSxYRPfnzKvj+BYqsAGGHLAZM0/0eEZg6yTi+TQ3DBdERXvQDmHjjAR4hjcdCVaBzRDNGAR+bkoALz/aY+yQx9sfCy8PSp1XWlW3oMqsIPVy9f4T2H8fO4VPA41u1XUHiPBMeO52U2R3okArAIczKry8ZunfRJxpsp38rjiMl5jkaY9BeIhXY8rMRE/LBjprfaN+/yMkG6cXtcb0rd9PeTwoUe2tYFg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(82740400003)(36860700001)(40460700003)(7636003)(5660300002)(8936002)(41300700001)(7416002)(6916009)(70586007)(4326008)(70206006)(8676002)(86362001)(47076005)(336012)(426003)(2906002)(316002)(478600001)(54906003)(186003)(26005)(9686003)(55016003)(356005)(82310400005)(40480700001)(83380400001)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 19:54:17.7778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb61232b-18a6-4535-07b3-08db0ad76dd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 01:58:47PM -0500, Eric Farman wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, 2023-02-07 at 13:17 -0800, Nicolin Chen wrote:
> ...snip...
> > diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> > index 026f81a87dd7..dc9feab73db7 100644
> > --- a/drivers/vfio/iommufd.c
> > +++ b/drivers/vfio/iommufd.c
> > @@ -141,10 +141,19 @@ static const struct iommufd_access_ops
> > vfio_user_ops = {
> >  int vfio_iommufd_emulated_bind(struct vfio_device *vdev,
> >                                struct iommufd_ctx *ictx, u32
> > *out_device_id)
> >  {
> > +       struct iommufd_access *user;
> > +
> >         lockdep_assert_held(&vdev->dev_set->lock);
> >
> > -       vdev->iommufd_ictx = ictx;
> >         iommufd_ctx_get(ictx);
> > +       user = iommufd_access_create(vdev->iommufd_ictx,
> > &vfio_user_ops, vdev);
> > +       if (IS_ERR(user)) {
> > +               iommufd_ctx_put(vdev->iommufd_ictx);
> 
> Matthew noticed a vfio-ccw and -ap regression that blames this patch.
> 
> Probably both the iommufd_access_create() and iommufd_ctx_put() calls
> want the ictx variable itself, instead of the (uninitialized) pointer
> in the vfio_device. (At least that gets -ccw and -ap working again.)

Oops. Yes, it should be:

	iommufd_ctx_get(ictx);
	user = iommufd_access_create(ictx, &vfio_user_ops, vdev);
	if (IS_ERR(user)) {
		iommufd_ctx_put(ictx);

Will fix in v3.

Thanks!
Nic

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA94691308
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 23:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBIWS3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 17:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBIWS2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 17:18:28 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697D828D11;
        Thu,  9 Feb 2023 14:18:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmSKJuuroRFZFT9/ZrhsSUy1QddUB/N/1Q4C0of0FcT/+ToUaqC73Xk9KT8Ep1/xLAV60TkAq/N2jt0TrPo3c4h1Xtlxrz8vUZK6eWilYo7EqdWsjmR5DPCPtFNOb4C57hyPigGkRRzg81a81dbyVq8oNDz09hXuRh5oQi2qD+9iStD393FU9gvUoVh4rWYImvtMqQo8fw0DR8/gvgPgxrMRO+Kytu6R3O7waL/JuhhQhopWb+4m4wQxrj/byEYye9TfhO0O3ILgLlHvmu4xO0wMPybYl/zHGZlvpB2V0THFl7Yx4qusj/F6117Q0sRVRMUTS35QdNhIUUWN8Dfh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0jR2WG+yOYcoMuwgPCG+BBqkrOZ7mxSUMXBWP9j5Mg=;
 b=AqOFxzBNDGEjwzoT2Q4Ziw61aqhT4dkbm7xAoyPp15LqQF+WII4+/FIzXLbej9Kxso0oQ83ulpWzPgEM/CvaoJ2HKbcaUOVHDRKy7l1kR0f5/trxgptelTAImQnq/I/gOz7F93cnHiqEtRdQ13IxlQ1UNN5Zg1k9ZX7v/Cw7iF4hKN4TXkeAdE83Z86qh8P7+hG0msMCrB0/sDiBMQPijClO67cxmU76kw390NDzqzb4rmyH8ebmywzJ/kaeaf7SteqlXpuS/Ld/bD4B3B0pSOGjgRYxs7xrBnXo266sp6iIzDZR1E5tGkMijHdr2RbU1ViTWInm/FsxqZGvRlIcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0jR2WG+yOYcoMuwgPCG+BBqkrOZ7mxSUMXBWP9j5Mg=;
 b=XyxEZ412odjkyoiXiBEpaQBLOJjM2ZLvmjftqhpivq8Cxn/w2lUxTk0/GSTyqU2ivXz1m5YFJlr5pQp5Uh55smYmIwNzKN9VPYlsUBi7gjNTDBHGJsUVAVwYbHDm84EhNx9SsfwUbVgu8tBNa9W8RfScE5eQ69W4zHFHM2tfA8o4QSN+uKuoe5EbXG1gx4dnRkBGzbe7Td7p9TAb5xufeDu2JlqKO/UpyEr8cOly/h6gmfUo2FpGexShD2XLGiq9Gnejt5VdqApM171yB9XgwW/Ux7wAnFxVthrjSu7YNyahti20ubADabd8Ic1nI4OA10t1SJI8kp9ZFnQxW490SA==
Received: from DM6PR13CA0011.namprd13.prod.outlook.com (2603:10b6:5:bc::24) by
 DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17; Thu, 9 Feb 2023 22:18:25 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::39) by DM6PR13CA0011.outlook.office365.com
 (2603:10b6:5:bc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 22:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Thu, 9 Feb 2023 22:18:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 14:18:09 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 14:18:09 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 14:18:08 -0800
Date:   Thu, 9 Feb 2023 14:18:07 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v2 05/10] iommufd: Add replace support in
 iommufd_access_set_ioas()
Message-ID: <Y+VxH1upHzyR8gV/@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <931be169ff4a1f4d4f1ed060d722c2dc17ce6667.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276AE27E37866B82A6E03608CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+VXfQbXakNSHSLw@Asurada-Nvidia>
 <Y+Vcc6x2JVPwkl5+@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+Vcc6x2JVPwkl5+@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc6ad97-a294-47a4-d25f-08db0aeb8fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxO6CxRhjGX+dYLn2Q/sA+VFp4sNe1dv6sNeUwTULkVDROr9Jt98a+CR6GwvAfggnJpJ08HJwTpcsetd6SXgfCSr/WpI0OWAT281+k6rWkquote3YZM+DVIRwlMWJpmek03RBtEXG9qoJRgiJ8ozh6Z+0ame75orDJmxGHy2q511vYlzDGvJjbAnUz9ZYqzAE0+KQpKhwzVyTbhsPqVm6rdJSnNKrfds6con2ZNkroyeLzGTHjnXuMNceLKeoM0czMVPSm8Zb6O8OsDQJEPDyg+rB4EmecZEcAJRJX5dBHYSkWpnEcxGRMUwp1HDqBOvZh97oEWDN86H17CXPXAegKkUZ7Wn98oLvQQIlv+O9to2F7AUdf0oEay7bpO5Q9OKO8rW6Q7PMurvvB3t+MAT3T74ofXqcjEyyHyUAeTeEOBu/g5+MUfy70sVGc+W3VRz2xDFbt2Ug/EVXMR+oPPbcRejmyy4IKmSI6IkJthWSfgWfuzLdsveqS51eNU03xjQqpcGlOgCmUmaM68foFyu1UfSDiQYXtwPcgCszLzYsLVKPyIrnDHICuteliXkyfAalnWBJJzE1wJQI5QDYW7Xu+8vlfc8GGic6KxarUep8VCJp0TwUUtUpJPeThtkFC9MvEJtpd3wzLc2bXYroGq4YbNbQF8DdYwoRyweRk/D/UVkHOodwRHA+NcLm37fucrZADLdBMeK/d2vek3ACIP+LA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(86362001)(6862004)(7416002)(186003)(26005)(5660300002)(9686003)(8936002)(7636003)(82740400003)(2906002)(82310400005)(70586007)(70206006)(4326008)(356005)(8676002)(41300700001)(36860700001)(316002)(55016003)(40480700001)(40460700003)(426003)(33716001)(478600001)(47076005)(54906003)(6636002)(83380400001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 22:18:24.8670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc6ad97-a294-47a4-d25f-08db0aeb8fd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 04:49:55PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 09, 2023 at 12:28:45PM -0800, Nicolin Chen wrote:
> > On Thu, Feb 09, 2023 at 03:13:08AM +0000, Tian, Kevin wrote:
> >  
> > > > --- a/drivers/iommu/iommufd/device.c
> > > > +++ b/drivers/iommu/iommufd/device.c
> > > > @@ -509,11 +509,23 @@ int iommufd_access_set_ioas(struct
> > > > iommufd_access *access, u32 ioas_id)
> > > >               iommufd_ref_to_users(obj);
> > > >       }
> > > >
> > > > +     /*
> > > > +      * Set ioas to NULL to block any further iommufd_access_pin_pages().
> > > > +      * iommufd_access_unpin_pages() can continue using access-
> > > > >ioas_unpin.
> > > > +      */
> > > > +     access->ioas = NULL;
> > > > +
> > > >       if (cur_ioas) {
> > > > +             if (new_ioas) {
> > > > +                     mutex_unlock(&access->ioas_lock);
> > > > +                     access->ops->unmap(access->data, 0, ULONG_MAX);
> > > > +                     mutex_lock(&access->ioas_lock);
> > > > +             }
> > > 
> > > why does above only apply to a valid new_ioas? this is the cleanup on
> > > cur_ioas then required even when new_ioas=NULL.
> >   
> > Though it'd make sense to put it in the common path, our current
> > detach routine doesn't call this unmap. If we do so, it'd become
> > something new to the normal detach routine. Or does this mean the
> > detach routine has been missing an unmap call so far?
> 
> By the time vfio_iommufd_emulated_unbind() is called the driver's
> close_device() has already returned
> 
> At this point the driver should have removed all active pins.
> 
> We should not call back into the driver with unmap after its
> close_device() returns.

I see. Just found that vfio_device_last_close().

> However, this function is not on the close_device path so it should
> always flush all existing mappings before attempting to change the
> ioas to anything.

OK. That means I also need to fix my change here:

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 8a9834fc129a..ba3fd35b7540 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -465,7 +465,10 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
        struct iommufd_access *access =
                container_of(obj, struct iommufd_access, obj);

-       iommufd_access_set_ioas(access, 0);
+       if (access->ioas) {
+               iopt_remove_access(&access->ioas->iopt, access);
+               refcount_dec(&access->ioas->obj.users);
+       }
        iommufd_ctx_put(access->ictx);
        mutex_destroy(&access->ioas_lock);
 }

Otherwise, the close_device path would invoke this function via
the unbind() call.

Thanks
Nic

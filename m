Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064C46B36D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 07:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCJGvF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 01:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCJGvA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 01:51:00 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52882F28A9;
        Thu,  9 Mar 2023 22:50:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwoelK3vbqrNqMCVc8qlZjlCM2v9o9Ck5qrwTBYFXSedIW+98LUjtb7Yh4cgAMyKgswGrofoOyiX/jL818A47gVdKieRR5kyYX7DJtyGz3o+e/OLihQa4y5hoURiezHXadqbB0PyPed9p+/ugOTNhE8QYxQJufBbtys1SZif9z665ZhW/T8tFZEtBdJxG9AS39rxsdQkeAa3qr4A2fTC0GRPiA50BL4Efc5UI3srP+UJEPsXonlxEItlj90HK9GLLoA9UZ6tTSXgPbFQ4TUdDk7TVKh0ClfbSWSKVPu2golzAUosEFqHU99CE4AUCgFZzfFAhVifCARlPoLRhjjEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sZp6T4++VP1G1A72tmMjQk2PNZ4Swuf/wJ1WhlG2tM=;
 b=ituBgsRhr/iTwcGz6rYoDvZV5gB94TdnZTReUZAlREfGJZ5pQ3SNOBHHX37n7mIooj1WY87QdOu7J8GfS1bjX1n/MomV1UFM7V9NKDZ9yz8EMNUoLsZykj928tByFpM2m0dGeLMWo5WK3DBGpvLUp8kFbibSeX4VygxhwVVdslTJwgavZ1Xb6H9LC71Bx6TdWvfew6m4w+0DETPlV3wDrXcGWS9Ic3b3ID39lU+E0vYjiywI0qjPE5seq8FylKqGTvkXnYSDaSEHaFfmrxnxzL+JH7ZcW3bF2X+tp+sUbCZPmi6lcxyv8Y4p7QofNtTPHIuMczLly4Lv9LfDEdvylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sZp6T4++VP1G1A72tmMjQk2PNZ4Swuf/wJ1WhlG2tM=;
 b=soPiclwvuszwyXWFiuJv7cZcq1rfGPjwgROhJb0rY2Jn1tkcliTzu1m3D+7vEV42tXCF7aFAKhvNRJ5nGWuG1lg2MCGa0ZBabXj93SsM+R/+cO4Z/HQAa6mWY5X9UpQ4FdMzzuN5cjj7pjJiCaQENK4EVVBVycAEkz62ceXZpG3qpMjiqMtV/WuHY45wa/VaKW+BiXI3bYAObYhAy9JRO9PLJxX7+vhf94tO+bp711dktqxLWdjI/3+salXEcIEK+Rej2j+WcFKw/FHTNligIJ3GHj2I9+dSjsX3RKOgo1lEb8M7szeunsHCn4fEMM7QUntkgdaZy0J8zcLcdzGfrQ==
Received: from BLAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:32b::17)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 06:50:55 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::a7) by BLAPR03CA0012.outlook.office365.com
 (2603:10b6:208:32b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 06:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Fri, 10 Mar 2023 06:50:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 22:50:35 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 22:50:34 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 22:50:33 -0800
Date:   Thu, 9 Mar 2023 22:50:31 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 05/12] iommufd/hw_pagetable: Do not populate user-managed
 hw_pagetables
Message-ID: <ZArTN9tIDKuvmuje@Asurada-Nvidia>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-6-yi.l.liu@intel.com>
 <b0ea86fd-8350-f694-a93a-a8ccecd0c8e7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b0ea86fd-8350-f694-a93a-a8ccecd0c8e7@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 17794035-d47d-4db6-15b6-08db2133cbea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H41lj46YdFGYA49KUCz9qeu5jd/WfhWSfn75rurtJ0gmZ9Lr8Z1e9NxC7hyokNQQie7F8nzOrH7vsYxm3UHY0u02kgFeF65TbP/RCmgflkFMVzr49esDRlTxG8dECw4RYlyFg3iKQgPEBo41htK5NVHvUt5W8Ty7eFNsLik3A3myLgwD9BLlGfBV7G5B3wd7SzSXA7C5Mo1lYM/H53ygfoY8cu+OnZje/ISIuueDfx3UlVxD8/30PbfAeELParNQDGvdPAaqpdjsBXca5OQTrYevV1wHGY1SHdZO7IOqYy6+NXW4USmpsMREjyi0hZ/xaQZwClpIBfXMuT9ugFR4sCdDbt0aUBUIanXVNZGSSdz/w7JWUzRbxU9aRgoXW/4QhRk9JvlGwIs4DcsITvheR1pL7TL8efYacqYGn7S5gDeWmLM2+u0UQRsw40OrpA3/TJ/xDgjUBqdBPoSYrrbIelf17TXM0JKzcDAHz5mmSTIIWnx05VYUeeAoFl3t4QhoVHIpEZ5NF165Frc+6/sSwNkadOMcP0IDtEdT+8WWhu+25J3OFrMLVJxebH0MWSSuI349JdY5JLn2wg6mMjVdN97VNo6LjA1gYJDkrGrk0riyfnfSQI6dlOxVhEWxEbUN3sQw11hYZZCAGv+xLG/iQ7SGPuRYYWcm2PLX5Ce+MiFYt48LtaqeHko42jhZ+wX0qD9KnBo+V8N75uPGSZOvesYLtAAXqBdiGCHrXXmsLQta3Fx+RxBlySUwVUZNhjBZ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(83380400001)(47076005)(426003)(82740400003)(36860700001)(26005)(53546011)(9686003)(186003)(8936002)(336012)(40460700003)(41300700001)(5660300002)(70586007)(8676002)(70206006)(86362001)(4326008)(2906002)(7416002)(356005)(316002)(7636003)(40480700001)(55016003)(478600001)(54906003)(110136005)(33716001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 06:50:54.9189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17794035-d47d-4db6-15b6-08db2133cbea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 10:25:10AM +0800, Baolu Lu wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 3/9/23 4:09 PM, Yi Liu wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > A user-managed hw_pagetable does not need to get populated, since it is
> > managed by a guest OS. Move the iopt_table_add_domain and list_add_tail
> > calls into a helper, where the hwpt pointer will be redirected to its
> > hwpt->parent if it's available.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> >   drivers/iommu/iommufd/hw_pagetable.c | 20 ++++++++++++++++++--
> >   1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> > index 16e92a1c150b..6e45ec0a66fa 100644
> > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > @@ -43,6 +43,23 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
> >       return 0;
> >   }
> > 
> > +static int iommufd_hw_pagetable_link_ioas(struct iommufd_hw_pagetable *hwpt)
> > +{
> > +     int rc;
> > +
> > +     if (hwpt->parent)
> > +             hwpt = hwpt->parent;
> > +
> > +     if (!list_empty(&hwpt->hwpt_item))
> > +             return 0;
> 
> What is above check for? Is it "the hwpt has already been inserted into
> the hwpt list of its ioas in another place"?
> 
> If so, is it possible that hwpt will be deleted from the list even when
> this user hwpt is still linked to the ioas?

It means that the hwpt is already linked to the ioas. And the
hwpt_item can be only empty after a destroy().

With that being said, after I think it through, perhaps Yi's
previous change removing it might be better. So, it could be:

-------------------------------------------------------------------------------
+	/*
+	 * Only a parent hwpt needs to be linked to the IOAS. And a hwpt->parent
+	 * must be linked to the IOAS already, when it's being allocated.
+	 */
 	if (hwpt->parent)
-		hwpt = hwpt->parent;
-
-	if (!list_empty(&hwpt->hwpt_item))
 		return 0;
 
-------------------------------------------------------------------------------

I was concerned about the case where a device gets attached to
the nested hwpt without staging at the parent hwpt first. But,
the link between the parent hwpt and the IOAS happened inside
the allocation function now, not attach() any more.

Thanks
Nic

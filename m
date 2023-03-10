Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252506B55A5
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 00:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCJXcJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 18:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCJXcG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 18:32:06 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C4113B974;
        Fri, 10 Mar 2023 15:32:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPIyCttCYdiE9zENEkXtWXl6KLSIp8Lc+I5x94TcUNF7m6GGgEnBmWT0Sj86DbdwuNhqLa3FLBxMfN8OcB4lhiApf/MPuqPLs+4oefJCaK35D5/Ld3Y54DBAcH8Ad7LjlkuSzL3JV9HNuX3daFN5yXoNIFeGzPKAQ2/SfSKbJzZB8E/v39TFvDjwe2b5uBE8Ew0rSE2imX3sICgJ06NHj1wat/qQbVpWmZ3wSvAQrYH0a8pQZTZfnS0DbP7WJhuUlQYE09inFw2D2BC5Xa0PHEnK/NvMpzuMQuNJEHS9nbrkREr81jxQrSLi8A7EjWMSTYF/eWWwc8EtTJ9yQIQIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze65Qvscn1qoKbFtWyDwfgI901QDZEwf8egpz6sTk3g=;
 b=JEUdt243DL8aasWguhIwnhrUt4lPBdguT7ospnqYxe5+qWND9sTzALv1nVtn7M1PnjM9jPFyJIHgh2Pu1XQqV63XTyQSeP/3yi+2OmLTQCRAvHXUqD94WYnaUqYKqx8vOWyxQWwU4UmSDN00Vg3qw2yW0avJS+imv3ZIlZpwrmGN3Bvp/kXPbbFr5R6+nxC/fSVlNwFRaucYph0MHZQVJAqrfYC1oB7kz5SF+7gaNngFOo5UYwEYVUO7yGH62+rS6FA6/WyvICU8bFJavClodA3hbhjOZmCnxSC36AvsyOwLdQDn82mlQ0gUkNJzJOjCDDk6RqNKFZ0OD2y3axcZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze65Qvscn1qoKbFtWyDwfgI901QDZEwf8egpz6sTk3g=;
 b=ZOOYkaQe7dRqEhIeIGxdcoOYbaYqWtWSnQdk7khfYcoPwH8Sq7wEIACvzwud7YX66ItCcjzqGhLLVav08qt57hMHD7eTSYBfibPo6bnzDn2bIr374C7EsdU4QLeQN+tJzYmzolJ7IgGJepCzYlRobiP6FJ/SAWEkn7wvqG4UA1iNxAvv9PeeWS5Sh3Mm6FHCf3VP9635bPC2eeMf5/aytHI1HHkOGhxyFtjOsNWbzXIKhmnhxci5DpYdx/xSi2yyHXQbRAZMkJV1ob9s8d1aTIWtFG6Z8IA43U3HdWVezNdEK9rxF3oUYZkgY3vamSSlI25qBgWgerdvWmrzcupxFg==
Received: from MW2PR16CA0059.namprd16.prod.outlook.com (2603:10b6:907:1::36)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 23:32:02 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::88) by MW2PR16CA0059.outlook.office365.com
 (2603:10b6:907:1::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 23:32:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 23:32:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 15:31:47 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 10 Mar 2023 15:31:46 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 15:31:45 -0800
Date:   Fri, 10 Mar 2023 15:31:44 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
        <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 05/12] iommufd/hw_pagetable: Do not populate user-managed
 hw_pagetables
Message-ID: <ZAu94B2sEw45qPHC@Asurada-Nvidia>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-6-yi.l.liu@intel.com>
 <ZAtMyrAOyWV1mDlx@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAtMyrAOyWV1mDlx@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: ed195440-7f18-42e6-4ca9-08db21bfa69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+F1GMzWEnU6cuZ3TPiuNP5Je0bnFBC8ND6YURhaJKQ8sz2Fbtd1+I3+nAfujXYf0+mVpQjHYes5ksuvm8ginceSe7O/EbYrN1mRAfYoTFMnphcd21TyFs029x8OTH9TrYi2HPxeMy6oacLruMdZAvVtwINTxLszJxGeZzZKaPHatDHIdK0y8mf5gCYTW+pFQDq198MotHqOpWoLam5SiCytSnmz9twdKX0Cn8/Mg4mLGVXxCCFgi/i7Q1jbynJgNWCAT7b1Pjciu6IUI8Q9fNkUuK35RL3zSi+T8lyMIPRYPbF5sxo833gjKQdb5ppjFjE1C/gt3rV7tfyN3K/wa2FRDMmwx71oqvU4Hb9AZnY8Xk7MBZ8hwx3AdIVqVqLR1t8Ykgx32QwKGuN5V+fGeyZhx1Xz0/QeT1fAc4Oyc35MWj+OQRrSG+Jqo/f36mI4iUw1qEk6q1a2P9G8QjPoO/f7x6FaUsJZ48NIG0ELTov+ChnLNYUWit8sCBUwIWyxKzjMlJOyhfd6YkXqXDxnVENg62JzTqUuS4WGyK1pTFmtpDJXNflWNgB4o1aLycMEMkL+KjTL8I2gWJLwqt3wwH+s9YbLpg34vpqB2jjJjlf2DK6akv3Vx3nlIiQ1RkToPv4RKBSvmGT8R8phZt4bV2SrV5ZWZMKyZ7lVM8wi5XjWM9D/uEICsK5Ci0FH4O3pBQEUaCl+6JaTbmTdJuKqarmcDu5EGk1tG2FRjkGV3NF7pptfKQDAzvinCTwENHYX
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(55016003)(356005)(6636002)(54906003)(478600001)(5660300002)(7416002)(316002)(6862004)(8936002)(2906002)(70206006)(8676002)(70586007)(4326008)(41300700001)(7636003)(82740400003)(36860700001)(9686003)(40480700001)(86362001)(186003)(33716001)(26005)(82310400005)(83380400001)(426003)(47076005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 23:32:02.0203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed195440-7f18-42e6-4ca9-08db21bfa69f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 11:29:14AM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 09, 2023 at 12:09:03AM -0800, Yi Liu wrote:
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
> >  drivers/iommu/iommufd/hw_pagetable.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> > index 16e92a1c150b..6e45ec0a66fa 100644
> > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > @@ -43,6 +43,23 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
> >  	return 0;
> >  }
> >  
> > +static int iommufd_hw_pagetable_link_ioas(struct iommufd_hw_pagetable *hwpt)
> > +{
> > +	int rc;
> > +
> > +	if (hwpt->parent)
> 
> This should be:
> 
>    hwpt->domain->type != IOMMU_DOMAIN_UNMANAGED
> 
> Ie if we asked the driver to alloc a domain and it allocated an
> UNMANAGED domain then it means IOMMUFD manages the mappings and it
> should be populated from the IOAS.

OK. That looks better to me.

> Arguably drivers should EOPNOTSUPP if presented with a parent in this
> situation, but still this code should be clear about the purpose.
> 
> > +		hwpt = hwpt->parent;
> 
> And we definately shouldn't touch the parent. That is already setup
> and owned by someone else. Just return and don't do anything.

Yes.

Nic

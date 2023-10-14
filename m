Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4506B7C91B0
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Oct 2023 02:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjJNAJC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 20:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNAJB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 20:09:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF48AD;
        Fri, 13 Oct 2023 17:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Upuo3sgEBBKEvTShxQU7t8Rux7WuxpCvm4wYLO5YgbnmV6W1zZ+0O0VzG3hZjHKm9Tio8d0drd/B7ZN2Zg8J2AkFmEBUUgC09mkSsxCcPfHZN1Y6RO76symgX/w6sw3lWJPF1zjlNynGtMZkBjhZ+epCdPrmFSGb5OiocFM7mAbX/up5fhl6EzrZQPWW2sOk/oodCzdddF7k3XOljvi3KxgEWt4VQAeG7TTvVeOVAWbxFYAVmlFG874PkyYFaaOjB5l7l66eHXE3lMKQOnNq33734N1MWxaXXZMvTnOSLm5jQFqGkxIrbagu44JrXZtzOI1rMXWV795JxtcRNZ7awQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS1gU8N3mT8z2W6J8adqfgi+rXoyD6tL6W4PVc8RqR8=;
 b=cXF1JC3w1Z0F6fHdrZ2pFweXclx2qfzQA3SWMrlvAPnUUl7568PCn1BJwNNZ9eUnfZBzpU9ofk89IWLQi1WHy31viaQxhgnVPJSr+BBnkrX4MdsEdXgxy6kVsFy9u2nu0kJSKSXSo2CxQpFh63PIlLJLfUz61snZIVjK5w7s0eA05ztVBFRfos06gOzYve7HDEKLN4ooPzpHnqKPUr5FKbE9THv4HFN44krpmFAUujmvLR+lvh4jphvMmJmhbh4olhIDAjsufSNj1607AglCtli5LFNDigNGXA7LEZsAWTh9+cyTsFDiiLV9bJuOij67gJ24X6CVbi3aOj7D4gD3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS1gU8N3mT8z2W6J8adqfgi+rXoyD6tL6W4PVc8RqR8=;
 b=ZUCNr3GYGnzf9e58+I7Y4dV880MbF1eA46yPME0yWCt/uASkF7gcQeHkPJMaEDs3JJPnli+t4Krx8ySuRbssyDjLe3NSXuTCPZQy4kYQ80Qo4NT4oEjalC6gu1/BSJWwmD0l2b3ii8lAy/P/IyalCA/2/d3Jfh7BjDRM03gByEE2yOLvkVOpAiicNm8BF3+RSctt55Bu2f8obLjb7VQkgkD/3lfzTlysuNe+Bdc4USC32r1VqHH6ejjbQlNJ6ii2SKOD+Zv6irUiUoxOTR0mSlGo77kq+wpZsXhd0qUtPQ3YXdKShzovIGFVJBVzxFjcRZ1ncUso6k4hfCgWJyVgrg==
Received: from MN2PR20CA0020.namprd20.prod.outlook.com (2603:10b6:208:e8::33)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Sat, 14 Oct
 2023 00:08:57 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::30) by MN2PR20CA0020.outlook.office365.com
 (2603:10b6:208:e8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Sat, 14 Oct 2023 00:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sat, 14 Oct 2023 00:08:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 17:08:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 13 Oct 2023 17:08:49 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 13 Oct 2023 17:08:48 -0700
Date:   Fri, 13 Oct 2023 17:08:46 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 07/17] iommufd: Add user-managed hw_pagetable support
Message-ID: <ZSncDu7enQs5e7Pi@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-8-yi.l.liu@intel.com>
 <BN9PR11MB52765F6D764B0C621A2D3FEC8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765F6D764B0C621A2D3FEC8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 21286eeb-9f4e-4170-2136-08dbcc49c26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BU3+N6t3Vytl5QmYHz18jg8atwSttduAhuv8fmkNBR9+vjPzjh51H0dM1lYI9h/9j3sF/yHCbtD7EaQAGcfR60MW/RA8CzNronxSSFApitbSVxi0ORdjDr2GPSFjLvUxMm9c0qSSTEMFobj7BUBzzB9MMaMiVk/PnrSjRqcLdA68KNyYYLjn439qqo4Eh/n1Imbefc+jQXuxlknYQMqPelJAINWgBaLECe/OHsbw6k3O8dueRHKOOVPb5HDvfPvQQOAK4v6N3ab9dqInWjLybz5hnj5wxbxFJhZPfyUYIUtyWDAKPe8Nju9cJScJ3PO2aYzU+QrIGQ67269Vg58CDp/p1PEVfAb9H6aBDJYx6Ig1Z1+dahGh5SvJ5+riE0UZiZhZKFWSfvq1+N5PjV8mGlWX+XVAwrw0X1/q+nMTEWi9vHUmI6YfVz67O/lghGRYa9moFG+DkupKr4/h8kVvIR+W4/ugWT1pD++SxmKEb9v5noX8Ptml+0FAWM5bnL+pVrH/DyaTmF1lfq5eDU2eHqhkYwXUZDQ4atX0GliR73rLlDXA3qmFHTZtEWpA+UtfFf1lwM6nwSnmayW3Fq4amBTyzfAGynX+l2zludm/lPyLiHFhZatQHLY/p2v69OgB8oKAJBJgz/p0NUBJPVA4HvmPYmUWXCJi2O8pVodra4+bh5r2b7FjUptnkQLVzzPAoDe5hO24MwOAs7jBe48WB8V6yF99G3UHn+fGNododHTTnu7iGsNVwWrBt9VQQP2d
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(82310400011)(40470700004)(46966006)(36840700001)(55016003)(2906002)(7416002)(82740400003)(7636003)(356005)(8676002)(5660300002)(4326008)(8936002)(40460700003)(86362001)(33716001)(40480700001)(478600001)(36860700001)(41300700001)(83380400001)(26005)(47076005)(9686003)(426003)(54906003)(336012)(316002)(6916009)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 00:08:56.7595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21286eeb-9f4e-4170-2136-08dbcc49c26a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 26, 2023 at 01:14:47AM -0700, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, September 21, 2023 3:51 PM
> >
> > +static void iommufd_user_managed_hwpt_abort(struct iommufd_object
> > *obj)
> > +{
> > +     struct iommufd_hw_pagetable *hwpt =
> > +             container_of(obj, struct iommufd_hw_pagetable, obj);
> > +
> > +     /* The parent->mutex must be held until finalize is called. */
> > +     lockdep_assert_held(&hwpt->parent->mutex);
> > +
> > +     iommufd_hw_pagetable_destroy(obj);
> > +}
> 
> Can you elaborate what exactly is protected by parent->mutex?
> 
> My gut-feeling that the child just grabs a refcnt on the parent
> object. It doesn't change any other data of the parent.

Ah, you are right. It's added here just for symmetry so we wouldn't
end up with something like:
	if (!hwpt->user_managed)
		mutex_lock(&hwpt->mutex);
	alloc_fn();
	if (!hwpt->user_managed)
		mutex_unlock(&hwpt->mutex);

Perhaps I should move the pair of mutex calls to the kernel-managed
hwpt allocator.

> > +/**
> > + * iommufd_user_managed_hwpt_alloc() - Get a user-managed
> > hw_pagetable
> > + * @ictx: iommufd context
> > + * @pt_obj: Parent object to an HWPT to associate the domain with
> > + * @idev: Device to get an iommu_domain for
> > + * @flags: Flags from userspace
> > + * @hwpt_type: Requested type of hw_pagetable
> > + * @user_data: user_data pointer
> > + * @dummy: never used
> > + *
> > + * Allocate a new iommu_domain (must be IOMMU_DOMAIN_NESTED) and
> > return it as
> > + * a user-managed hw_pagetable.
> 
> Add some text to highlight the requirement being a parent, e.g. not
> an auto domain, must be capable of being a parent, etc.

OK.

> > +     case IOMMUFD_OBJ_HW_PAGETABLE:
> > +             parent = container_of(pt_obj, struct iommufd_hw_pagetable,
> > obj);
> > +             /* No user-managed HWPT on top of an user-managed one
> > */
> > +             if (parent->user_managed) {
> > +                     rc = -EINVAL;
> > +                     goto out_put_pt;
> > +             }
> 
> move to alloc_fn().

Though being a bit covert, this is actually to avoid a data buffer
allocation in the common pathway before calling alloc_fn(), which
is added in the following patch. And the reason why it's in the
common function is because we previously support a kernel-managed
hwpt allocation with data too.

But now, I think we can just move this sanity and data allocation
together into the user-managed hwpt allocator.

Thanks
Nicolin

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B94A7C7AE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 02:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjJMAfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 20:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344236AbjJMAfP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 20:35:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DA3C9;
        Thu, 12 Oct 2023 17:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV8xqwOfBTwssmHYrspq6B1iPyq+HTt2mg0VLAGUtY+rf+MxdQpnOUjIHkKTR9t/7iC8qlwTJJaD51IWBSVJU5c1ghEGvxh9e5Oer5LCdwCV+wL7qv750WCzhYTL1NHj5qifcsrzb8HQ+GwMCZsIk/lv0aFf82Uy1j624TE+OivU+j4KA3/mA6b6SQMh0KspQsxu/XUbDjjsyK/Cj9+3gggbRO+MTHanoqYejNuMzaHsLhWjrNDyE/GG9VGsy3fhdwKle3oGGvVlKV5QX6rqJe5xxwsZt/smo9gwlCQbehUxTYLWDlb7jEjWLLD5AXc2aTE2TfipiC2hAOxCHQCHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNEXYbjLytbPYGfQyrLnhrdf2Lqf8MoWSFGSCBGkAtQ=;
 b=Tb8uRxC6xnASuTzRhjCNhHvYcteY0UFjbuWVXn1Rk9W6PWO77xatf6TAeoRD3oYr2aQykFgGddShTay/w91C8eRmKeH3DQeFwUUk+D6Z1aqGAlPla7xlY1nr4YTdwccO7tc2IWsQPpZkeF5uOHjyYkMEO7h/OPXX6bs8+prCD0+scQ9TjbpTOUCDZdeGKRJwwAW/YTwUoQcmifc7Be677DKSlCtKUmOvuZy0ai9YIYDOiNuAB2G8iDxpglaV5wJtjkWMsgX39ZnPNBNYVFv59Iyp8bBrL1SDSlx6uaaduiHlM27lBAZt9M4iyqrGuLOb7/X+3x7p1SoP4dbd7ivBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNEXYbjLytbPYGfQyrLnhrdf2Lqf8MoWSFGSCBGkAtQ=;
 b=ACnJGjQojWv3Gds4C2Q0Mdw2q+vj74mUTiqig+KcdHmz8uHoFDgrNnLHx0wk2C7TEaxcBRP0ECxbDmF/j9B64vFIIbu6JBnrIRQVgH9AheJabnte3py6Z5iNvs/U1EgYbcEc/L0t8MSMukmI6Z237BWMM55TQzctC/wrO7GOz+5DiGOGWQzIbrEqdru8dgRtTjANyk6bTf2097BzcEJHsyKdDiliB8q5t20G4HVt1BSLD0Uhrkll7RPEHrTW/SpbWPMjKfPn5SMFue03NZitGLGZDyJfaaslNSknU/1Wt+J3FxRyrnIRLmnR257yd1Y4M9/eHT9ilXgCVBBzR+yhww==
Received: from MW4PR03CA0232.namprd03.prod.outlook.com (2603:10b6:303:b9::27)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 00:35:12 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::f0) by MW4PR03CA0232.outlook.office365.com
 (2603:10b6:303:b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Fri, 13 Oct 2023 00:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 00:35:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 12 Oct
 2023 17:35:01 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 12 Oct 2023 17:35:01 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 12 Oct 2023 17:35:00 -0700
Date:   Thu, 12 Oct 2023 17:34:58 -0700
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
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <ZSiPH4WlGrbKpdfp@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231010165844.GQ3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 065b1a56-fadf-4029-3284-08dbcb8442f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXgt8JghJe32Q9eoKh6pKhRX3xMXmh3gT0rP3j3rIWl8iIN0kSqWvUeIegxqkZV59pGT6qr3XOoABzoiYtZT4cyE1/qrI593bf9FH0Tz6QeBW5A45z9VJjvm1H4b3Vcdojka2uV1vQAwE6OQS9Gt0GnkXANU7sbN7aDvnPDuWqJpb1t8sXNXsA3XcubXfFezT/iKfteGMCNb+AkGn1ehjb7BPdg8XPV3HA0wJeSrduVFuCSbe2xwj/WvUxvNSEumKi0sf5xFSKVo2g25jLRKZMBDuoSkzxYEYGZl89akDgZgzf+EmXFO2ur308O8YpY9KRwhl2wmU6Bc8qhQ6oghDR8zdajA1lxpySQvLe2pL1Ap0hg0dgeLv/7sSQ+MXAtNllFpSIc94nxt2L2hELKUz05Fhi5G+Dq2Y0cTZQV1EjDxUdwvuOoi03hTBxJ/7wkoy2zmKw4p9sTZTchH52yqx1Lo64gwlupGErO8HCaZsSCAkP6InbwHmPEm0SvaVPWVNeTz5t0NGLI0foUDVth9JS73su5d8WUz7yoh3iNWjypIfxoYdRm88evUUEmTH8X6Vywfj6rSAK7EJ2Oih5VlSca2ei8igrVw944yayvDmqUyJD0Ji8ullf7AgliAAPzdeWUsPHinB0t4kC2JSufA01nIWhml4RrEqeBEYD39B5AXykd6AOCKd5L46A5kJ/d2IQ4wmGUxTg4o5fFUZ6gZWYbaPQJEny/xN5rKQAYiBY8+AmyttLGYoelSqfmCDA5H
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(9686003)(336012)(7636003)(26005)(426003)(356005)(40460700003)(86362001)(55016003)(82740400003)(4326008)(8676002)(7416002)(478600001)(6862004)(36860700001)(2906002)(83380400001)(5660300002)(47076005)(8936002)(41300700001)(316002)(40480700001)(6636002)(70586007)(70206006)(33716001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 00:35:12.1828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 065b1a56-fadf-4029-3284-08dbcb8442f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 10, 2023 at 01:58:44PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 12:51:22AM -0700, Yi Liu wrote:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 660dc1931dc9..12e12e5563e6 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/err.h>
> >  #include <linux/of.h>
> >  #include <uapi/linux/iommu.h>
> > +#include <uapi/linux/iommufd.h>
> 
> Oh we should definately avoid doing that!
>   
> Maybe this is a good moment to start a new header file exclusively for
> iommu drivers and core subsystem to include?
> 
>  include/linux/iommu-driver.h
> 
> ?
> 
> Put iommu_copy_user_data() and  struct iommu_user_data in there
> 
> Avoid this include in this file.

By looking closer, it seems that we included the uapi header for:
+	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags,
+						  enum iommu_hwpt_data_type data_type,
+						  struct iommu_domain *parent,
+						  const struct iommu_user_data *user_data);

So we could drop the include, and instead add this next to structs:
+enum iommu_hwpt_data_type;

Then it's not that necessary to have a new header? We could mark a
section of "driver exclusively functions" in iommu.h, I think.

> >  #define IOMMU_READ	(1 << 0)
> >  #define IOMMU_WRITE	(1 << 1)
> > @@ -227,6 +228,41 @@ struct iommu_iotlb_gather {
> >  	bool			queued;
> >  };
> >  
> > +/**
> > + * struct iommu_user_data - iommu driver specific user space data info
> > + * @uptr: Pointer to the user buffer for copy_from_user()
> > + * @len: The length of the user buffer in bytes
> > + *
> > + * A user space data is an uAPI that is defined in include/uapi/linux/iommufd.h
> > + * Both @uptr and @len should be just copied from an iommufd core uAPI structure
> > + */
> > +struct iommu_user_data {
> > +	void __user *uptr;
> > +	size_t len;
> > +};
> 
> Put the "hwpt_type" in here and just call it type

Ah, then domain_alloc_user can omit the enum iommu_hwpt_data_type.

Thanks!
Nic

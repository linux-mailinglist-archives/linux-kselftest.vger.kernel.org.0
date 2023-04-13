Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5031C6E0348
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 02:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDMAoZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 20:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDMAoX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 20:44:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2A53C31;
        Wed, 12 Apr 2023 17:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDoGSgRVR/j/Zsh6xQ3JTieL/rQMfhSHDqIiLV3Nn0sBDrIioLRhnUGjJ4spjnZcishjYFybhPC7qOE6eVia6BzR7x1Q/JrcJxhBFRdGf4v092AtEkOTJM5BQ+GqJiwkBspsaZC9BNepJPzltstCAQY/bdX2xJxGRMd7arXPHhyegf6SYXVTqNQBAKWsaaItT0WJRScCy0f4W2Qx7g/EkU/0PsEaMkyUviGDfY0doAMc9il/BM67+lIvT48EnLZiOgWQUxBr8e6slK/tqAshhKSRgWaFr2pKlcWkIqlE4BVuUOlZvYGsLg/YEPJyFSV7Ydy2k4dLJNAVbapLbvUuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5+QbFpL11Xn2I62XMHg/vTuszL/RtJp1LIcbkB13EQ=;
 b=K0gUIelAv5X0FFpNzFuBS05Nsn+/gKeFQeF0l/5Ey8qIYtliqbwmUPzwF4L1XrtiJOhu4YWNkApSLeNaRuCBlMjJum021JmdQGgdiubMCn/kczVB2MD04h11wBPGTi4a4JH5Uera6W6+bJ0mwsHlmZZ7mXC7Gw8oevRaDoBputkkDLsq+wA45cUd+rh3NYL7P7jxHk1HuzyBIFqoGGDL+Evbca5ETIqyFlZXvB0sPFloabklclWVsaPOSZrVR4qV9/3kP7ssL5Q73N4KG9FrIvVKhPTGTdCKS73uw3cV1Mh+QKk9fjSlzJaL6AX5sNt6LrnVFpCg2km+OcJu+1EItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5+QbFpL11Xn2I62XMHg/vTuszL/RtJp1LIcbkB13EQ=;
 b=Vkmh9PDcLLj5+q1NVUwwraJqU1mgrrXViFgreJHLkOs3Ii8vQFldpOeSbaHqllTxL9vCd8Egx6vU7cEqto0k0GheLtt/2pJzuIcO+/n1Zc1K/Ckw4FwjN/kakRERBnKiUFIvf3eIvKl919hrLJmqMSQSXlzhXLRp2HlQS2hD78oZ76iRuzPs4/Rp2Hfd3fBBjI222GtP++kjeJpRBS1zFeSU+l0qadKnpMiWVhD5QuK3sJqSCXZvdrhq6rdYcqduNTKkQwrM7O4pl5C2u2RniGys3wY/Flz/7PnVWPdpVjThBEtIif8nDp0SbWmQqmDKNbdyeaSusTwIJ+WFVK3XrQ==
Received: from DS7PR05CA0030.namprd05.prod.outlook.com (2603:10b6:5:3b9::35)
 by MW6PR12MB8949.namprd12.prod.outlook.com (2603:10b6:303:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Thu, 13 Apr
 2023 00:44:19 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::2e) by DS7PR05CA0030.outlook.office365.com
 (2603:10b6:5:3b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Thu, 13 Apr 2023 00:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.31 via Frontend Transport; Thu, 13 Apr 2023 00:44:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Apr 2023
 17:44:06 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 12 Apr
 2023 17:44:06 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 12 Apr 2023 17:44:05 -0700
Date:   Wed, 12 Apr 2023 17:44:04 -0700
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
Subject: Re: [PATCH 01/12] iommu: Add new iommu op to create domains owned by
 userspace
Message-ID: <ZDdQVEksXbeilBoo@Asurada-Nvidia>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-2-yi.l.liu@intel.com>
 <ZAqAJgoQ3f0L2Gfo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAqAJgoQ3f0L2Gfo@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|MW6PR12MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ba65ba-8f36-4a8d-0ac6-08db3bb83776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +h//9CmEUZ+hlGs+SqnjWzSY6PMvgK7mPX/0qmbkbIPp+DWnsP08xKWVqdBZ3q7nQw4+wNYLvKTMmw18+KorkkyHLLqHLKYYasFrFUUc82bd2V/zaW8V4n7YmRuXz5kJsVQzntCSn5O8p/yMXtfwqo/kAYPaYXuApcSBqlsqCdhhZ0swJDRQpCSjjkfaGzOI3NrLZLCLNbdKbvLp891iDnTOzRw2JTXQDWIJZDF4ByjfdzsN0o74InflSJlrKOv92i4j07BvdydPyddjr74MOr/KjTwPEW7VGBSR00JN/bNH+/8iCqER/IvjgkSJW7IH4YZ/3GrOChxXHhtkDxfnsJs8KFvc/HpCwzz+z9aXhE0AwhMDGjCl72V6dP9IqHUiF38fk+UOgJ7kdLP9Et7l18MBLmIbvZ0K0uqAMMiN+go32MGQqDYrz62NsclhKiQnx/thmIMgkYnRr2lKgAAbzTDgEs+yQ8XeQ4ILeOE4iCXPkf2xeEoJerjQdcSPUVFq6OKVGVhbdUCL06D/NyUQGSAkUNB2R8W87OAxYcXiiX3eGmMVlYv/lCFLviZaGOKQtJTd/+neCBowCKsyEdb009JX1r1gcAN7cd424B8w6Ehf4ZoDdSqYxfOq75c1PgpHl8v8dxH3GDlB1a6troGlmfiGeG6MuZ9BK+ZgXx8tLtXJY1yx9a1czpjIosAMOJVlDG7mYiiziKBsrWRVr84Z1ZrQb94lKfvzAyuomJCxxKDn9vLS2KzeBZmPtSZ2kUnEALKcDL27AMzipkWZAmHCbHkU6xlK7hjxHwuHaXD5x3c=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(316002)(41300700001)(6636002)(54906003)(70206006)(4326008)(70586007)(478600001)(8676002)(5660300002)(40480700001)(8936002)(6862004)(82310400005)(36860700001)(33716001)(55016003)(2906002)(7636003)(7416002)(34020700004)(82740400003)(356005)(186003)(83380400001)(9686003)(26005)(336012)(426003)(47076005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 00:44:19.2311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ba65ba-8f36-4a8d-0ac6-08db3bb83776
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8949
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jason,

On Thu, Mar 09, 2023 at 08:56:06PM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 09, 2023 at 12:08:59AM -0800, Yi Liu wrote:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 3ef84ee359d2..a269bc62a31c 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -229,6 +229,7 @@ struct iommu_iotlb_gather {
> >   *           after use. Return the data buffer if success, or ERR_PTR on
> >   *           failure.
> >   * @domain_alloc: allocate iommu domain
> > + * @domain_alloc_user: allocate user iommu domain
> >   * @probe_device: Add device to iommu driver handling
> >   * @release_device: Remove device from iommu driver handling
> >   * @probe_finalize: Do final setup work after the device is added to an IOMMU
> > @@ -266,6 +267,9 @@ struct iommu_ops {
> >  
> >  	/* Domain allocation and freeing by the iommu driver */
> >  	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
> > +	struct iommu_domain *(*domain_alloc_user)(struct device *dev,
> > +						  struct iommu_domain *parent,
> > +						  const void *user_data);
> 
> Since the kernel does the copy from user and manages the zero fill
> compat maybe this user_data have a union like Robin suggested.
> 
> But yes, this is the idea.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

We pass in a read-only data to this ->domain_alloc_user() while
it also returns NULL on failure, matching ->domain_alloc(). So,
there seems to be no error feedback pathway from the driver to
user space.

Robin remarked in the SMMU series that an STE configuration can
fail. So, a proper error feedback is required for this callback
too.

To return a driver/HW specific error, I think we could define a
"u8 out_error" in the user_data structure. So, we probably need
a non-const pass-in here. What do you think?

Thanks
Nic

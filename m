Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AF976DE54
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 04:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjHCCiP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 22:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjHCCiB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 22:38:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A2422F;
        Wed,  2 Aug 2023 19:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzY68beoFWWL1OY+M0T+RTSe+nFnPFcxa+DJqxf0n+NEL0JpJkTuHX8pBDX1jfNxZYAsDa+YGzYw6HblZT+2PwOLT0DGKvQtnJm+gkpyVJMkD35HbJTFQttKHo7QLgEqQZOLIPwfyTKfaNhCLUBdQwUyQJaS6SimFTzBgtz3Pyf3su0b//1a+cu+bPiETl8Rcm828Y5/Oz6Co0ZyKLSgckPxp0j4etJxEes3nSFqIvTsbs1//yoToiw/PIpmmj7tTZacE0CvtKUbHDSWF6x73PxR+QKLSVOayrTZ+WUq0SeNtf5wmzAPlWWANB2SWcsf1xwaqoM3qMdJsA+1JWTZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmTzovB6fu6e9e3jxd/NYTLqUdxXKgZnNsZMaP945zs=;
 b=PLZHNX2nCJAlsgpnmiksZzUskkoktJDQHv7usZMqwhDDhH20XGQp/PmH89IHekO4HLBR3pG51DyvtQahIEZEHjQ8u4uOu/N0m4y6bpgTqVLgnrRyMpq3PSIjOGgHkIw/kPdDZzqNSGe3+JdKye2X9JIjp/n2sUPYHmltqyJi/ee+QEL0zsJLFmLLj4CbrWeKfpBX7JG2puS+45QL1j4eerdRy4VPTjPoGOEy9DdDnR5kwlMxTcMMkPIVDrq4IiWZbePS0vsHLC66oSWIhtCJQPFSuBHFrKdR0aK6uHjWFfNQYrLYhs9apIu9XafoKnFUWADChSau2/mMG2rvakPJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmTzovB6fu6e9e3jxd/NYTLqUdxXKgZnNsZMaP945zs=;
 b=QGIWGbQ6eI6NOboPtEuti4dK/dw7RHgVJlutt6dZ9OWpnVzTRHqPZCENmXDDi9Atpk99Si0o4HEo8Z9JkTqzH/xnP7qy6300oyvJIixNzHlxH5dDntYoRuPNlH00PNBkbzge3tm2kB5wuL29qfwn+bp4TL1wpPT9JtStLx22x6FEH3kW9mqfSQrjjQUU+OBvB6POMtU7vbYqbeE1Zv28HPpCzx++4MbT+OQNb2zQ9MTXIYyHUpO51MwJN6goIcWAIOA2LyKtkwC/TLvdlZms0RErUSZS013XnIIke+Oy2zKW9kQo5Q6eFzEBJmjrhVfAdWMElmfg6hiXTj2jGQVW9w==
Received: from CY5PR19CA0084.namprd19.prod.outlook.com (2603:10b6:930:69::20)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 3 Aug
 2023 02:36:55 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::b5) by CY5PR19CA0084.outlook.office365.com
 (2603:10b6:930:69::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Thu, 3 Aug 2023 02:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 02:36:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 19:36:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 19:36:46 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 2 Aug 2023 19:36:45 -0700
Date:   Wed, 2 Aug 2023 19:36:44 -0700
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
        <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 02/17] iommu: Add nested domain support
Message-ID: <ZMsSvM/gC9016CS4@Asurada-Nvidia>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-3-yi.l.liu@intel.com>
 <ZMPz8MIevHBd6zsI@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMPz8MIevHBd6zsI@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4045cc-40ab-4181-a472-08db93ca8097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xd1BLIEN8PUc5Ee1asBHyZRdSvcY/+3MRI+ozMOCJGC3W/5ysbVGl5K/386AriaO8zZYqCggihhHedlUV4rVuSb4qswu/QIv0iT0vPM8rkbbshOrK9NTNkygGIQCzjHjPQy6WhHeO9gUTd9OgVVM6veBuP5NiN6MEiKTMnmnSVufRT+1BTpnFGDMrn1YU7GYskwpaoaXPfuiVjO3rx5pDeclXX+Xu/mAR9owqwh/y7gJn1tN0Gq0nvZytOjvufx9bJUfA6hennOWxwm/+PR8NN3N36uJZ/1Ma/1qFK3w9kwtGVrzQA3Q4IjoBt9Vo2LZZStqU9JlMY9ytYOMTgfQhgl56QjUPjNsladF7HbPUYLfnYyiDpangwBQb7wihEuexI8k0QpxpTT4rSMRzjQOnQt67qaeCYv3OoNOtREFWEi/fDpFIlMXgU7dBj7hNU1EHic6NywuD3XzRGK+RMc97QxlppdCiwJhwnulxncHhuMwuTl91Kosn3MhvcaCVFB/ZsbA/Z4OBbpNjcT+REPMsrMsC+ko0EIzRnanLMVBSUU61LCd64MeTFPjvQi26padXBE3RomhHj9cFiTcBESpj5qY8qmLfJK9JBOYFLtpmopy2wgTfQn22g+uAi3LIn+h/4xQTWhnB31F9z6E6LFcUml8R5esQ82EzqWcwBbwhdCgIoSaR/eQ7d3VbQA2M1SZ6UpQ/oHEic/rviva8BOelgEfFsFADVka16S4ykVLmFogGU1VrH2yvHqvguVGHzuo
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(9686003)(6636002)(70206006)(70586007)(4326008)(7636003)(40480700001)(82740400003)(478600001)(33716001)(316002)(55016003)(356005)(5660300002)(54906003)(6862004)(41300700001)(40460700003)(8676002)(8936002)(26005)(86362001)(186003)(336012)(7416002)(47076005)(426003)(83380400001)(36860700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:36:55.2218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4045cc-40ab-4181-a472-08db93ca8097
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 01:59:28PM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 24, 2023 at 04:03:51AM -0700, Yi Liu wrote:
> 
> > @@ -350,6 +354,10 @@ struct iommu_ops {
> >   * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
> >   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
> >   *            queue
> > + * @cache_invalidate_user: Flush hardware TLBs caching user space IO mappings
> > + * @cache_invalidate_user_data_len: Defined length of input user data for the
> > + *                                  cache_invalidate_user op, being sizeof the
> > + *                                  structure in include/uapi/linux/iommufd.h
> >   * @iova_to_phys: translate iova to physical address
> >   * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
> >   *                           including no-snoop TLPs on PCIe or other platform
> > @@ -379,6 +387,9 @@ struct iommu_domain_ops {
> >  			       size_t size);
> >  	void (*iotlb_sync)(struct iommu_domain *domain,
> >  			   struct iommu_iotlb_gather *iotlb_gather);
> > +	int (*cache_invalidate_user)(struct iommu_domain *domain,
> > +				     void *user_data);
> 
> If we are doing const unions, then this void * should also be a const
> union.

Unlike iommu_domain_user_data is a union on its own, all invalidate
user data structures are added to union ucmd_buffer. It feels a bit
weird to cross reference "union ucmd_buffer" and to pass the naming
"ucmd_buffer" in this cache_invalidate_user.

Any suggestion?

Thanks
Nic

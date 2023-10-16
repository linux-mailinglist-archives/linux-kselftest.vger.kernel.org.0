Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D7D7CB226
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 20:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjJPSSM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 14:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPSSL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 14:18:11 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80A7A2;
        Mon, 16 Oct 2023 11:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeagGcMtE7xsOSIGrvHUN5lDud2JJkHRbdQRjMWq6sHHH/9RnYOKJcLd9BzXuFcOcSNlAJyfredUxgVjWL/zQGB4qTxZCV862/jCBWHulgUGTpepanHqN10h2uVSgddmwWKU+kMlU3DT/MHO/d5V9VWTU4jib4+uREba53HzStstbJSy/IkRlFvqRSJYa3SbF4FWkoKpUMSFJnu+T89H1ZttMBcLfa7opnLbli+yvC/6X8peIZw7fnppWivOE1nMSc8LdaUAyxrjTjjipxhFqUEaOWdEbUo/MlalaKcTf6CwC0l5tFxlJWX2mXFHBonvCVIArZBPMLBx1c9DJ/nd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7SKTR3nutZsE0CXKuhKRYXvYzz7RndxJoz+Q8nkk/g=;
 b=Yul2do5cWQZWKLWq3mHiIJRSUAnN5GRcR19/Psx/Bn29Oo1G0NgVGcPwWB8t4Si57z3f4TIIO+szsbkh898MfFWcMNFhCsqrgcBHdctt4/+PonXmr9zhAHftGIWzQojIQb+SsQsI0bpQQQ0s2QcJ5oiGrDEyhGmTOm6j8mfZHKD4IuSOjPGlyyBRAGMcOTGoUPqbPwD+gYP2rj9esAKS+efbBP7FeHtlPz0VsbsDMWSKbLBKeQu5zkzByePN8foquH3875idSlIZLb9dfoXQ3WsdtZKEX5hxSSNlcSzXup8nALZ07wCR+oNyKkMC9Fxif+qtU42GL52cPjTRDs1bNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7SKTR3nutZsE0CXKuhKRYXvYzz7RndxJoz+Q8nkk/g=;
 b=Z3nSznkS3efD28Xh3S5HR9n5myZvMUtPDhQVIxiCa9kZMqQEirvRZRwQVuR4SPObXs23C8wtxIvw5CL0hBcfs+RpIa0bhbOO9v+WwyzrCUpyD5EEWefN28O53TEaatZ29p6koYkfow/3hog8ZPGC3/a8ruIKP1IQPu/ysfqJZGK44h+5qWHK26Q+VyysfbxhJHJpWYU1KhkycmIBORXDjJjn9vaOQOEm4Lt4jXQl1JXnjTqj5KiXr9eRYTUSeohxk1kLnsISy0uzaFXf12hablC0Fr6hNNwzMzjJAPUMculcmPxh9NTzzltHIGg30vVTatPaiJAJTf7QKpt+PhGjKQ==
Received: from CH2PR15CA0005.namprd15.prod.outlook.com (2603:10b6:610:51::15)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 16 Oct
 2023 18:18:07 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:610:51:cafe::53) by CH2PR15CA0005.outlook.office365.com
 (2603:10b6:610:51::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 18:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 18:18:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 11:17:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 16 Oct 2023 11:17:58 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 11:17:57 -0700
Date:   Mon, 16 Oct 2023 11:17:56 -0700
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
Message-ID: <ZS1+VMEo+0bCecui@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
 <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
 <20231012133917.GL3952@nvidia.com>
 <3659d9a7-d9e9-bb73-daf5-41c765e99c8c@intel.com>
 <20231013140456.GR3952@nvidia.com>
 <ZSmE6unIukqJ3GKu@Asurada-Nvidia>
 <79f0cab5-39ad-3d98-3896-6e1ba7b8db21@intel.com>
 <20231016115407.GO3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231016115407.GO3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 27815492-55dd-4543-102c-08dbce743f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZAGzzkT5u81fYHI11HvtSLjjUwi7GTXgxfHuGh1e8EK0l0pmTBf2VcFRXLbg4Yt/Pv6HeT7fcjg5bYCy7JjS+B3IbYyZaU+FHsETfDEn8edgcangdfXTCROyPjmtrJ9Yk/meSOMUTrM6WtP/e6js5IW6AyICLOgejpWDQZMVSjuMcx9OJgF2eugsCrk3MdWOh/THaYT8/nV2O2+QNeCHb10O85EvOCcLxAQasHI0bPoebdHoqabR3JHIxk7kGF3UezJlRWtR2HAU13+RG5/FiPorkHescQRxiflgDAf2fB9Ixxv8xEcVQ6oX+NS+qHCyvWcefb+V0LoyW4RYI41NMMaIYaZV9dSBS6OOXknDfCvhmaO29XkuY5+csfeQZSLyxBscfII9I1khszUpjZbOr8vBY3Zpx7Cc+lKj1N0pSKPa9Klg8xdFFMci2zLO+ycBXqc1QsG4cLrELLgaZ45xllZn6gl8te7UaslATgjvaloFXyprMa6tx2kMW5okRVnUmapICx5Gj3DDrhsXePZDPD8QEz2URqVvmnsQnql3EmjBrUYjjXq7GE8krfRQGN0vRGq6Rrw8g0Hxf4C5nch1giq+i/pT5GiLXzewWglbuO5xgXjr5tCvFQoG5bf7Km81nQe5c2Qpqouvad+7cS9i2BXp5V5SQV2b2Q8N3ski+zrJ8yDNiqwcmqEY8tuTrH4+/6o+pJTR0NMvT/0G9xI1U5QCNxfTevyc07ERC7LPMJqp8FPlB71QoQ25WIvQu8V
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(40460700003)(7416002)(36860700001)(2906002)(47076005)(55016003)(356005)(86362001)(82740400003)(7636003)(54906003)(33716001)(70586007)(316002)(70206006)(40480700001)(53546011)(9686003)(6636002)(478600001)(26005)(426003)(5660300002)(6862004)(41300700001)(83380400001)(8936002)(8676002)(4326008)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 18:18:07.2123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27815492-55dd-4543-102c-08dbce743f17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 08:54:07AM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 16, 2023 at 11:28:15AM +0800, Yi Liu wrote:
> > On 2023/10/14 01:56, Nicolin Chen wrote:
> > > On Fri, Oct 13, 2023 at 11:04:56AM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Oct 13, 2023 at 12:33:13PM +0800, Yi Liu wrote:
> > > > 
> > > > > not really. Below the users of the struct iommu_user_data in my current
> > > > > iommufd_nesting branch. Only the domain_alloc_user op has type as there
> > > > > can be multiple vendor specific alloc data types. Basically, I'm ok to
> > > > > make the change you suggested, just not sure if it is good to add type
> > > > > as it is only needed by one path.
> > > > 
> > > > I don't think we should ever have an opaque data blob without a type
> > > > tag..
> > > 
> > > I can add those "missing" data types, and then a driver will be
> > > responsible for sanitizing the type along with the data_len.
> > > 
> > > I notice that the enum iommu_hwpt_data_type in the posted patch
> > > is confined to the alloc_user uAPI. Perhaps we should share it
> > > with invalidate too:
> > 
> > invalidation path does not need a type field today as the data
> > type is vendor specific, vendor driver should know the data type
> > when calls in.
> 
> I'm not keen on that, what if a driver needs another type in the
> future?  You'd want to make the invalidation data format part of the
> domain allocation?

The invalidation data has hwpt_id so it's tied to a hwpt and its 
hwpt->domain. Would it be reasonable to have a different type of
invalidation data for the same type of hwpt?

With this being asked, I added it for our next version. At this
moment, it only does a sanity job:

// API
__iommu_copy_struct_from_user(void *dst_data,
			      const struct iommu_user_data *src_data,
			      unsigned int data_type, size_t data_len,
			      size_t min_len)
{
	if (src_data->type != data_type)
		return -EINVAL;

// Caller
	rc = iommu_copy_struct_from_user(&user_cfg, user_data,
					 IOMMU_HWPT_DATA_SELFTEST, iotlb);
	if (rc)
		return ERR_PTR(rc);

Thanks
Nic

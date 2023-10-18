Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FCE7CE32D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjJRQvl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 12:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJRQvg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 12:51:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806B9FA;
        Wed, 18 Oct 2023 09:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPX00iddpuuEKI3YVAe8VNqzxZNjnchJTFQy5P675/DqXzczvyRF/NhCJTRGzcdjdSMEo0jSccJcGpYkGPhoMg8A4obZpDfpAC7EydW5GKea6p94ovmsBnuKnl9LWi9YTXf+W0LxeymDWUZu9ZhjLpGaxatl7vBp9U8CyUpKN12GhP3a3mAaNxb8+cXjcsezfCbqnJY6SQTVtaZfaz6q2nzhA4HSxUbaE4nXQ6GQ3vq4YLWm4hkXlzMiWYk47toOuxnugOCR1F0M1VW9rKGIutOpZM5s+tZ9ih03GomEtfGwMc9PGP8RpdMBk2Xw+wcp2TbPsixGnUtr+JaCmB4V8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ELe5SxajCQurFfSRcaoIdt3BFspdxxBIm8oKFn59tE=;
 b=MP2sjFRkER5e7/FyWcDfS0Dl85upyHROosmARa2V7ji03ocA7XQfG7omiTOYZU2svdwoEqAACYAtmp81JBfoJAVPTipEtz3CtCibuZnFWUGdyG/iVWZIN62H+MRqAUeh/u+J+LzCElvyqF064KYHXwXTFlZCpqTyAgo0bstmLQX1RkxnpEH0jKtOvKvFb5Zf6mqOpJ7uWEmWjmeYa6s0SW+WeZnlmJcMLjMvdB/seNtLMICOG8Bzy0WsLTVDu66L/g4K3tKyGxzAqC7GnDnaAHkFPRUkFHbb8hPyHN5uhFgivlfrdzYEvl5yw2b4viC+nj6N103E2PkXj6GZQ218pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ELe5SxajCQurFfSRcaoIdt3BFspdxxBIm8oKFn59tE=;
 b=lhmqV1WH76d6Y0l318jadklAUJhrJ9zzmwUtisDUPu/TR3eNp6s/0UAqnv9gB6ovnS++RtBGO9+sKVPuFAwDHPJa19S+StxzdTyPcecFQ+m0osfChOZTiTSIWJbOqFafrUHzww6RNaLxMON75lQH8o3VNucve8c9OZQz4sKWArkuNm9rYRdS53ab10NPh72rnGPyjckFzRXY7ZYItcmukQLM6xNGzpYZ6/1nu+tLXiZZJcnRzHuFUfGwxrOzHdXNsTUucQwmtDGWzsMxKP//YV8PTPCI4wxUt6CQYIUoWh+QN3ywbDk84vB3CuTmSnf1j7l/0UFBQM2whdowCoR8zg==
Received: from BYAPR01CA0032.prod.exchangelabs.com (2603:10b6:a02:80::45) by
 CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Wed, 18 Oct 2023 16:51:30 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::2e) by BYAPR01CA0032.outlook.office365.com
 (2603:10b6:a02:80::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 16:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.22 via Frontend Transport; Wed, 18 Oct 2023 16:51:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 09:51:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 09:51:12 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 18 Oct 2023 09:51:11 -0700
Date:   Wed, 18 Oct 2023 09:51:09 -0700
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
Message-ID: <ZTAM/V2VyiOQhmWi@Asurada-Nvidia>
References: <20231010165844.GQ3952@nvidia.com>
 <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
 <20231012133917.GL3952@nvidia.com>
 <3659d9a7-d9e9-bb73-daf5-41c765e99c8c@intel.com>
 <20231013140456.GR3952@nvidia.com>
 <ZSmE6unIukqJ3GKu@Asurada-Nvidia>
 <79f0cab5-39ad-3d98-3896-6e1ba7b8db21@intel.com>
 <20231016115407.GO3952@nvidia.com>
 <ZS1+VMEo+0bCecui@Asurada-Nvidia>
 <20231018163720.GA3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018163720.GA3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea96c50-2bb9-45ad-e208-08dbcffa7a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mNgYxtknPyF4x5aWsAwRbuXPi0U9AgTzyCgvQASPoFWMAfqEXxDPmiHveDFVdsybin1UvbkUqczbQcycuNRNymJwA6sSp3EH79pSVO3bxpcPEwA/pN5y3KzMEC3yumFxoXrf2x+Ibib+Ku7J1oqITziMUm5wQb9znR6p6n9KkCH4/9usxgDnwhBcVsBxusavUbYrYVCaFVR6JS2F2HWpNUmD7FVe4GhnOk5j5JUWNdcJ3ng7zPi5vTxM0Kh0wdIuH1zK7uFSlsmFtj98oXQHkljrxjk8t+Jv7MGmseS29Zn9A+jzpoKcGjfbwAsnC0n58qnumSzy9/oypZzRmgPwDL5DDqWYADLXnDBtr1q4V2BAVpDxrlfw2ZltwWFDvVThmGb1qtTG+LWvxmBaZt3MBWTG3XJicjmFkcErh1H9Gk5yFfv6VR7rSqD2oEKabdaeGSriEuwUIYQaFgrAIsBd+4un4BpRckR4uUZrlPzoYN3t4VkurnW9n4Y82hABGbZmJIrqoSj0XvcQ5VlKWyNVpRIlq8leGHc0jMfrbXcnpDjt2u9PF7KRjpnZ8prOvNY98QZAyJtIZ8jVlmqeZ307dItWBk7S7f7hBT3/FYhMr/gWPIj+meBtXn3JREr5mHczvMBAItN6liwdaL0B9abu2YtnGKcnIn6bYgzNK7qq3f1EztMQQzfaprZi2OIa37EWIF+7H4yon8ndzU2SN8z84MCt6eqMAuxc0dgJhRL/NY=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(478600001)(53546011)(47076005)(83380400001)(36860700001)(82740400003)(26005)(7636003)(356005)(9686003)(426003)(336012)(41300700001)(5660300002)(40460700003)(55016003)(6862004)(4326008)(8676002)(8936002)(316002)(6636002)(54906003)(40480700001)(70586007)(70206006)(2906002)(86362001)(7416002)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 16:51:30.1668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea96c50-2bb9-45ad-e208-08dbcffa7a45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 18, 2023 at 01:37:20PM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 16, 2023 at 11:17:56AM -0700, Nicolin Chen wrote:
> > On Mon, Oct 16, 2023 at 08:54:07AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Oct 16, 2023 at 11:28:15AM +0800, Yi Liu wrote:
> > > > On 2023/10/14 01:56, Nicolin Chen wrote:
> > > > > On Fri, Oct 13, 2023 at 11:04:56AM -0300, Jason Gunthorpe wrote:
> > > > > > On Fri, Oct 13, 2023 at 12:33:13PM +0800, Yi Liu wrote:
> > > > > > 
> > > > > > > not really. Below the users of the struct iommu_user_data in my current
> > > > > > > iommufd_nesting branch. Only the domain_alloc_user op has type as there
> > > > > > > can be multiple vendor specific alloc data types. Basically, I'm ok to
> > > > > > > make the change you suggested, just not sure if it is good to add type
> > > > > > > as it is only needed by one path.
> > > > > > 
> > > > > > I don't think we should ever have an opaque data blob without a type
> > > > > > tag..
> > > > > 
> > > > > I can add those "missing" data types, and then a driver will be
> > > > > responsible for sanitizing the type along with the data_len.
> > > > > 
> > > > > I notice that the enum iommu_hwpt_data_type in the posted patch
> > > > > is confined to the alloc_user uAPI. Perhaps we should share it
> > > > > with invalidate too:
> > > > 
> > > > invalidation path does not need a type field today as the data
> > > > type is vendor specific, vendor driver should know the data type
> > > > when calls in.
> > > 
> > > I'm not keen on that, what if a driver needs another type in the
> > > future?  You'd want to make the invalidation data format part of the
> > > domain allocation?
> > 
> > The invalidation data has hwpt_id so it's tied to a hwpt and its 
> > hwpt->domain. Would it be reasonable to have a different type of
> > invalidation data for the same type of hwpt?
> 
> Yeah, maybe? Go down the road 10 years and we might have SMMUv3
> invalidation format v1 and v2 or something?
> 
> Like we don't know what the HW side will do, they might extend the
> command queue to have bigger commands and negotiate with the driver if
> the bigger/smaller format is used. We've done that in our HW a couple
> of times now.

I see. We'll have the type. Thanks!

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A358B73D344
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 21:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjFYTVw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 15:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFYTVv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 15:21:51 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3ECB7;
        Sun, 25 Jun 2023 12:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1ga6bagAhoh3cqiwFOFil5w5xAjP2LgYw6cNP1gJ7hWgoziPg5dhQmlMh03LBw0CxxuApVVsNemqZEFtEV+kfkq+J0hYtO7/ppeB/e3ib0M1lSUumeo7ziFgvCBHG6FU9aS8dnwZEZ0bLC34oRpN8jj5zNTgo04nxxi25t3Ikn9bkc0b/KF2HaBQeIaQ0lAmW51WuHQ46mZcJqsc+9u25t0DghmNASRCjRmuh6zjZWYJOPBQWG6/MBb+A5XzgFF94N/nIzO3VGKkBo1KlbafqEThWH6ixXoLe5U9QKAeFbzAWZtVth8WIVL4ZtXCq1PeW+cS4JgTVXFrtJNIgexVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPe9yRQn4FoXtwWXXcgVRnetT20BsSGGzfpZZXWvVto=;
 b=MV9YDZRqg4Ir23ALdFIId2QrPQw0rallnTM1cRsmWKAMttL6Ih9QzD0q3fK9yL+srzOwH/hEBB0JKbRP99l6xGzmVyekkuvMkzNLow5IBqdiZ7NxxumBDPmw6mCjLljE3bLYbqcNDNLFMNroNGPh8nIpXTsDlkhDKCQP6MmoresXmVQejvLqysckjKqjqqvqDwIO+iWNbqQDdUTe13cwO/MzdEetHCczkG/XM/X53awjCcD7jS8flslWqQfAMDoe7pHcjyA7AiG6DAjB7Q/NIbvo0yV8Kx4A58qo4Oi7aw1hH7tn9pgAcGFrs7zAcZGEPlxBOZ2NDnGRrlexCSNYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPe9yRQn4FoXtwWXXcgVRnetT20BsSGGzfpZZXWvVto=;
 b=fGD9SsNOu7vPCDvaCMwKeOKBzUKzYnG22ecYnOyI+deSrqWE7ZvOleJzPTzOelBz4wZYvY+s9c6WCsroloJCIjrX1iqkzIb6cIp1IfkxwfCY3XUl/eWqDG4UW1l7efXUqEPwJgG0CcGPIk2xg447NehQiiizFZ7hW1K/zFgOb9OPFFcwLa/LBqqN1YW9E1B61yyJOGeahDbO8AziITyutajb/t5SfW54rXl4kk0JzQ4TNSVEcQ6oxFFv2ru0f8o+kxCKfsx55DgQsJAXLVMAiTzXBKLZEqq/lfdUpxw4tLSvfC+wqMMWypr9qfb7ccaCMyfBK54N4ShQBQcRejIp0g==
Received: from SJ0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:33a::24)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Sun, 25 Jun
 2023 19:21:47 +0000
Received: from DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::85) by SJ0PR03CA0019.outlook.office365.com
 (2603:10b6:a03:33a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Sun, 25 Jun 2023 19:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT075.mail.protection.outlook.com (10.13.173.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Sun, 25 Jun 2023 19:21:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 25 Jun 2023
 12:21:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sun, 25 Jun 2023 12:21:30 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Sun, 25 Jun 2023 12:21:29 -0700
Date:   Sun, 25 Jun 2023 12:21:28 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        "Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Yi Liu" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        <iommu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZJiTuO/9Bs4hMAiC@Asurada-Nvidia>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
 <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT075:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 548f13b0-b0d9-43e0-5685-08db75b16b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlKfuBDRqKrBUrUGi3SxsVxChwfEoI/DllhuRiSzJU/Qcpd2WUdXZZA75H22BBNAgtEp77E4Q8zHgTSly1w2aCvsFYBYMlZmoMwW5/JzoHFvVoCKmA6IP57NfVEiRFceRRJDzqMf8cvKbLofpcAAkWr/p+Imt5bLB+PZgIEkcRr55e3LfG2oMi3HvZuv3xdOAezQSnDUxlUJ4BH6yGi9e93RL7DvQMU7XeCIb9xAELXdsMN6ByoiCgdxZrGL73MtpF+ndr++awZLDF9H82sXugO5eV4e+OSiMmDCww6boODUd+p30H7C1PWI4Nm/wGn2N1oJNxC7aibsmK+899U8WqZY/RpSmkkCB7Ba8YdnZ3KJFaTbre4DRW2xSX6P+1egxFsVIOWu8pYiVg+pUTi3bGSixm/7cKUWRMHjDfrv28wxmtjUODCiTn+3d86OiJM6Eh5t0/vXcC11jrNZaM2I362vrH3HZ/MA61+RMgpuSKNYlYBt9n21P3YTDVvqQ0Az3M/A+8rq/0JaQNibGq3H6f6oUMAMr3CKBJCNAC1hve9nBURXdz0wydp12V3xAT892Sb9/SGB/DByrAz3GL3u7cVJjrnUS24ERqbOOCQGr1FEdIB6/73CUKcK1Vaj6CquHQ3mR9m5tgyAe83kskOUMklfs1pq5r6syu9noQBsDZ08lnuQB3wzxW/ys7NifC8Xxszxo8ekkloz1lfWGVwsCGfm/TAbxrjeOOH2twOwZQbcEWJtNOC/VX3NIbEaTacX
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(7416002)(70586007)(70206006)(316002)(6916009)(4326008)(478600001)(8936002)(8676002)(40460700003)(55016003)(36860700001)(40480700001)(86362001)(54906003)(41300700001)(82310400005)(2906002)(33716001)(82740400003)(9686003)(53546011)(186003)(336012)(426003)(26005)(47076005)(356005)(83380400001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 19:21:46.8462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 548f13b0-b0d9-43e0-5685-08db75b16b1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 25, 2023 at 02:30:46PM +0800, Baolu Lu wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2023/5/31 2:50, Nicolin Chen wrote:
> > Hi Baolu,
> > 
> > On Tue, May 30, 2023 at 01:37:07PM +0800, Lu Baolu wrote:
> > 
> > > This series implements the functionality of delivering IO page faults to
> > > user space through the IOMMUFD framework. The use case is nested
> > > translation, where modern IOMMU hardware supports two-stage translation
> > > tables. The second-stage translation table is managed by the host VMM
> > > while the first-stage translation table is owned by the user space.
> > > Hence, any IO page fault that occurs on the first-stage page table
> > > should be delivered to the user space and handled there. The user space
> > > should respond the page fault handling result to the device top-down
> > > through the IOMMUFD response uAPI.
> > > 
> > > User space indicates its capablity of handling IO page faults by setting
> > > a user HWPT allocation flag IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE. IOMMUFD
> > > will then setup its infrastructure for page fault delivery. Together
> > > with the iopf-capable flag, user space should also provide an eventfd
> > > where it will listen on any down-top page fault messages.
> > > 
> > > On a successful return of the allocation of iopf-capable HWPT, a fault
> > > fd will be returned. User space can open and read fault messages from it
> > > once the eventfd is signaled.
> > 
> > I think that, whether the guest has an IOPF capability or not,
> > the host should always forward any stage-1 fault/error back to
> > the guest. Yet, the implementation of this series builds with
> > the IOPF framework that doesn't report IOMMU_FAULT_DMA_UNRECOV.
> > 
> > And I have my doubt at the using the IOPF framework with that
> > IOMMU_PAGE_RESP_ASYNC flag: using the IOPF framework is for
> > its bottom half workqueue, because a page response could take
> > a long cycle. But adding that flag feels like we don't really
> > need the bottom half workqueue, i.e. losing the point of using
> > the IOPF framework, IMHO.
> > 
> > Combining the two facts above, I wonder if we really need to
> > go through the IOPF framework; can't we just register a user
> > fault handler in the iommufd directly upon a valid event_fd?
> 
> Agreed. We should avoid workqueue in sva iopf framework. Perhaps we
> could go ahead with below code? It will be registered to device with
> iommu_register_device_fault_handler() in IOMMU_DEV_FEAT_IOPF enabling
> path. Un-registering in the disable path of cause.

Well, for a virtualization use case, I still think it's should
be registered in iommufd. Having a device without an IOPF/PRI
capability, a guest OS should receive some faults too, if that
device causes a translation failure.

And for a vSVA use case, the IOMMU_DEV_FEAT_IOPF feature only
gets enabled in the guest VM right? How could the host enable
the IOMMU_DEV_FEAT_IOPF to trigger this handler?

Thanks
Nic

> static int io_pgfault_handler(struct iommu_fault *fault, void *cookie)
> {
>         ioasid_t pasid = fault->prm.pasid;
>         struct device *dev = cookie;
>         struct iommu_domain *domain;
> 
>         if (fault->type != IOMMU_FAULT_PAGE_REQ)
>                 return -EOPNOTSUPP;
> 
>         if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
>                 domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>         else
>                 domain = iommu_get_domain_for_dev(dev);
> 
>         if (!domain || !domain->iopf_handler)
>                 return -ENODEV;
> 
>         if (domain->type == IOMMU_DOMAIN_SVA)
>                 return iommu_queue_iopf(fault, cookie);
> 
>         return domain->iopf_handler(fault, dev, domain->fault_data);
> }
> 
> Best regards,
> baolu

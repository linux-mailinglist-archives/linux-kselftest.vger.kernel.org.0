Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE2B716CCD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 20:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjE3SvN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 14:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjE3SvM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 14:51:12 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6A7FC;
        Tue, 30 May 2023 11:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maiOjg6GGdmq4GC6cT7zW2Byb0xJLXr5Le5ID0YUVufpb7wdXA3YTvG51z6zHZ/ASldMiN7ceRQKBshoXjjeRX7jgYI22bA51hV9j66m+XIB6Fk9jaKrOEKP9A99c+dzCzvyv2hKiX60BBfWNW18Ee5tHD3jnjo4NrQbceGAJ20rEdAMBY2g4DATBOQYTIg9UHISMrdtqLuMvjdlmcOsV/Yjg7Sw5l5wBHUl1PTPsUDs6C+8IVExgYwKK49Vw6SpYIr8jDM646XURH+eQDvpjaLFoleMN5VuK7nqADmYIb9OMtJFoop8iLYEullKejg0YlmD8L5mSN3nnmiQGKxaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvrQ5BApli78CCB/7h9L9d57YfagyrI1fmNGz0xRgOA=;
 b=GoYq/u5C3MLL5hFaG+wTzlHVkFfRtd40Z+PEAC/CfKUf1/EUV4TQaR1Gl6tKY+6ix+Dd/cL6vaSFpBsVaWbJxbOk7D3B4/m8D/lG3e22c017nG7DGcQKdtpeQmYN2b0OlsN0gGyM14ZoonPRv3pQ4fwXgCsFQgYYGPjNIe0hp+fgbamukHWD54aSKUpQvD5HBlNCqFYUmXPUXDu58rOxjNHFX4TtJvtlO7TTlYHmWJJbPiGQZijzPBkraLncUBS/EV1VF9JCw+0+jcsk/MSQ2XSa2rMCQE9Rdi/uOPjfuSVpINoVtj6llx+KjP7m0Zo/oFzRMRxK5JkhtmDTbgqnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvrQ5BApli78CCB/7h9L9d57YfagyrI1fmNGz0xRgOA=;
 b=VOAbqTUaeFBtbNJ0X4z5Aqu0RTD5V+WBapF0sMD4Hzzy5TRHxOKTHjLia3XwSBMLRzdrVmdckQFB/Dw7f97B3yjroCInklpQRGD726USTtrHQU9xKUARgD7z85TFolqyytlLEyoASe6Fj6go7Z351eBHRxJtQ/bNL/4yi16HYmlLIYPy0ByF4Wq9/qzq8UijFU4FpnalMsKckLV1z5er5crfwHnaO95IiDs+NbWV9sLtduRN7e/WT1+XvFVj4xqLm+O/LK4Ydd+1ROMyg6Esryu2OlXoUXB9mFRwZNha3E5AE7W1S2ParsUJkDYzyNOdPKmTBSx8QKof/n2IzZtqcg==
Received: from MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::15)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 18:51:06 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::22) by MW4P220CA0010.outlook.office365.com
 (2603:10b6:303:115::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 18:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 18:51:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 11:50:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 30 May 2023 11:50:53 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 30 May 2023 11:50:53 -0700
Date:   Tue, 30 May 2023 11:50:51 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
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
Message-ID: <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 2303cef6-6275-4c58-e5f4-08db613ed334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RCpAf1Sbns43noYxbbL7PVampW2i51Y5kAqWmzBu/DQiRHbnZxjuXbTi66R1YHAmxRjY3qHkPp/yAB4ErUB/v4sHnyV9gnQLsy3BgSLALpLGeOi9QidDovJPgzCVvJi+1EbpX4Kh8Hge0PVq6MoCkKelOazuWXpojPrMwovmkZrj8qlfW7oMzKE4Micp9aPeR76q/soJoTTREqttRjMWC43yozA1Is6GD6Z7Lmyo9zxiPKaOppIp36RjaNKkuxpuAYGgJuLehYznJqwmdSEWpRWSe4Eztjhg5Xm+UiVQaKDLVlyJ3pyPlfoilFxbA1M0qmqvbHpu4yceTNFD5gGc0Vo86IQ0sN4uNKDqH/SREwmNUIiO3nKQHe3NGIgc3KdXfYKzQDAdbiXUz8kFaY3R+jL+BC9j9LdIzSe2OOrvm+Dpv09kL1RZhs4YZuFTwLTblnNnNDZLvpDr1J7f3POOO+bnZTgjw/FuW4Mt8Kj/6KUJIDXINbu66IkBkc19bXaHgKtIGvn1PWx5rstaeBmu5BQlHDwJacR3rKt787i7ROdwhqTx3jzWqUp2eQ1nWA5mT/SVI4g1vdU4MxjmVTH9NpW5qgYWSjEAjF1njXmmT4+QoPYSAwNmqvS30v4oVgIpHbUQkvzLVW+5VGs1mszVP7ruWFEIqxeQBe9spd1FiCFHv7gfBN5jJdY66ogYFS9p7hKoYeZv6bxUt6raLK4IQ62Ovs2KwMokQnZmaTAZkIKJW6X0WkW9vxlL9Y7FlvT
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(26005)(36860700001)(41300700001)(186003)(47076005)(83380400001)(336012)(426003)(9686003)(478600001)(54906003)(40460700003)(6916009)(70206006)(82740400003)(82310400005)(356005)(7636003)(70586007)(4326008)(40480700001)(55016003)(316002)(5660300002)(8676002)(8936002)(7416002)(2906002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 18:51:06.1445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2303cef6-6275-4c58-e5f4-08db613ed334
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Baolu,

On Tue, May 30, 2023 at 01:37:07PM +0800, Lu Baolu wrote:
 
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework. The use case is nested
> translation, where modern IOMMU hardware supports two-stage translation
> tables. The second-stage translation table is managed by the host VMM
> while the first-stage translation table is owned by the user space.
> Hence, any IO page fault that occurs on the first-stage page table
> should be delivered to the user space and handled there. The user space
> should respond the page fault handling result to the device top-down
> through the IOMMUFD response uAPI.
> 
> User space indicates its capablity of handling IO page faults by setting
> a user HWPT allocation flag IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE. IOMMUFD
> will then setup its infrastructure for page fault delivery. Together
> with the iopf-capable flag, user space should also provide an eventfd
> where it will listen on any down-top page fault messages.
> 
> On a successful return of the allocation of iopf-capable HWPT, a fault
> fd will be returned. User space can open and read fault messages from it
> once the eventfd is signaled.

I think that, whether the guest has an IOPF capability or not,
the host should always forward any stage-1 fault/error back to
the guest. Yet, the implementation of this series builds with
the IOPF framework that doesn't report IOMMU_FAULT_DMA_UNRECOV.

And I have my doubt at the using the IOPF framework with that
IOMMU_PAGE_RESP_ASYNC flag: using the IOPF framework is for
its bottom half workqueue, because a page response could take
a long cycle. But adding that flag feels like we don't really
need the bottom half workqueue, i.e. losing the point of using
the IOPF framework, IMHO.

Combining the two facts above, I wonder if we really need to
go through the IOPF framework; can't we just register a user
fault handler in the iommufd directly upon a valid event_fd?

Thanks
Nicolin

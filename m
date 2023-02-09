Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98368691337
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 23:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBIWWu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 17:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBIWWt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 17:22:49 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B328D25;
        Thu,  9 Feb 2023 14:22:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jivxbUw2iD2DqMcx7VMGWyhsSMfhM4UJW+FWmFaehYvtYElVdJuWUvLOQZcHREgwjbpCZDl6sXj/PkrRk/5aJ2g5IIXUBNqof2p9LxKqFWxUwTmRM2aP4Mv2VXsU/rmHpSg+0wW1VSDTUxhv+4tyBO+EaX8CJ/dspEFCvcDCIWuUR0JqkqKuW4nziIYIttlbaqPeLa+OrDH96jyZP9/7hx0TvicU45CXGmZKJ0po+I1ws5sRmobbWEPmKfUvc1BMlXWpEQuZbRR/k8pkXvxCUlpZGE33VXfAqssCvsJ332UySAgweIJPqma734eP6DtIqiZPp1LG2WcHslA6hLMWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpJci/MOr84CuHUgaFR2rBlsD3yrFbu/2oWjvO58eXk=;
 b=AaV/5HEVdIKtWa3ZRbLiNtAIRVMPYa11xzTukQeRmpdARQMRSX7qkgSAWePe0CeVGaiqTjyxm7LsvKl5BFqb8gCqyETsNt9LHFcCKwZoTImZsKRPXvA744tM8c+OeGT+HHYhjLcH2ZoJMHLRsBUzLtIDcu/lHYgEMnFYbRa/8X/V5cOMy5n+3IpPulCjSjrSzjRDGfA54Aqut8EfpG1wEemA5hNmJUTs1TwJmo66q8MKpWoWLWC2xRR1snAZgnBbq9OUNYmOqy4zJaL6DzO0YdlWaSOHiobiQfRrn1B16y7c0oufE2kLLHDfhHJPN5NsUSQa6x8N1ZlSUUKUYyLO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpJci/MOr84CuHUgaFR2rBlsD3yrFbu/2oWjvO58eXk=;
 b=BN6p0MokKUxmM28UGB+Ia9IfN4ni2jcDMGd316zkUb21+Yol0JzqHg2o39jTdLK+phaFRC5FucxIcTUsxsEmafDuurTbQSMfqKtK6G0h2z84bxEroNvPX6PVtG5hYGnZlsO6l/8QIrrVNaqZyyNwlCWfSm53Dqt9JMQ071Dz1Lr/WAFw+c4uGoSxCaepAZaKk/PKO/RZZ0DiHNqeYKJZaxBTzRmuiiRnomITtohpAmXgxTCrba/Vu0POa3e+JhugYUoop98d12Zx+iiTZSqznfM9eyGWwMmtQC6Q9FYTSWjyA6HPigg3RhTq5n5L1RGO2J5dISojmsuUw7BAAi9ibg==
Received: from MW4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:303:6a::21)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 9 Feb
 2023 22:22:43 +0000
Received: from CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::3b) by MW4PR04CA0046.outlook.office365.com
 (2603:10b6:303:6a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18 via Frontend
 Transport; Thu, 9 Feb 2023 22:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT076.mail.protection.outlook.com (10.13.174.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 22:22:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 14:22:29 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 14:22:29 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 14:22:27 -0800
Date:   Thu, 9 Feb 2023 14:22:26 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
        <robin.murphy@arm.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 06/17] iommufd/hw_pagetable: Use domain_alloc_user op for
 domain allocation
Message-ID: <Y+VyIvKYmCdMG5i7@Asurada-Nvidia>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-7-yi.l.liu@intel.com>
 <25102c92-1831-be52-677d-60bbf2e11772@linux.ibm.com>
 <Y+U9QX4p5YX3/B3k@nvidia.com>
 <Y+VOw6dTnGapMm9L@Asurada-Nvidia>
 <Y+VaCV7DRR1+mLYY@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+VaCV7DRR1+mLYY@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT076:EE_|BN9PR12MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: 2453d8aa-4a27-401d-6310-08db0aec29a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GGUQhypGbKyR4kXqSZ1pETn50TuONJRP9ixZ4i/A563h2wFrDVcaPUzEx02l822+/qQ4nY9ORqBcNC6YTLylaEKFvaD8NaZea7RMgaKjCPknIlwDz9luNJaoIMrkLVsxcAXJUwLEnGr7ZrtMU17StVOs97UF/9lADBEtqddefGeOAYEFVXznOrf35X8RFF54brJWr2cX5cdnG8JClW+lYQWC15zqNJWuIOzXVF1ls6IN2RKqrhYgRszAvRQPHcZK/ijBdSxgErDEDDvsRR0wTRWZrOsSHT5pd3LzpahtceNOM2IHrlIl6qZma36J5bEWOcOiQyosggXucEpQLcYJqgJAqUM4SmMj+bPf59BKxc14LPefqNzKl9MNmBw1RBrq1jzAaNfSnU4dD18SJubj2Elb8jKkbFbFEazjjpFpMwzba7Z9rY5PBU39g3a46gMYxicRmMT9QMY5zpmymuksFxZJz5YlmfBD94T8oVie4aAsmpWMGxNSPUmQUCbTJFYIrapUshvPT5sEEolD9k2shx73PRp5c8ma+rzgLNzsrGQZGKf1x0tjS63lEjNzFF5UM3jkfqFDtZkA7KzYJnoctuHlfgX9Zd8bRGIMX/n37WE2cCBnsQjKJCig/S2GG0pIITgqSSlaTCtVPobVOAcIbzF95x0E5/kfVVA9o65JsZlgQhxo3vpEGcbosjIXhBoaHdoklnZoxkONPFjCQJylQS0PBnQatNLouYKl+IFpnw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(9686003)(186003)(2906002)(26005)(7416002)(5660300002)(478600001)(356005)(8936002)(82310400005)(55016003)(41300700001)(40480700001)(6862004)(47076005)(82740400003)(8676002)(336012)(36860700001)(70586007)(4326008)(70206006)(33716001)(83380400001)(6636002)(426003)(86362001)(54906003)(40460700003)(316002)(7636003)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 22:22:42.9383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2453d8aa-4a27-401d-6310-08db0aec29a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 04:39:37PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 09, 2023 at 11:51:31AM -0800, Nicolin Chen wrote:
> > On Thu, Feb 09, 2023 at 02:36:49PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Feb 09, 2023 at 12:59:58PM -0500, Matthew Rosato wrote:
> > > > really should highlight that).  Otherwise, conditionally calling
> > > > iommu_domain_alloc(dev->bus) when !ops->domain_alloc_user (instead
> > > > of returning -EOPNOTSUPP) seems to restore the prior functionality
> > > > for me.
> > > 
> > > Yes, that is right if the input user data is 0 length or full of 0s
> > > then we should call the normal driver function
> > 
> > Maybe I am wrong, yet I recall that doing ops->domain_alloc_user
> > without a fallback was intentional to rule out drivers that don't
> > support IOMMUFD?
> 
> I think we moved away from that to the idea of using the dma_domain
> patch I suggested..
> 
> > To be backward-compatible and concern about SMMU, we can opt in
> > ops->domain_alloc_user upon availability and then add a fallback:
> > 
> > 	if ((!ops || !ops->domain_alloc_user) && user_data) {
> > 		rc = -EOPNOTSUPP;
> > 		goto out_abort;
> > 	}
> > 
> > 	if (ops->domain_alloc_user)
> > 		hwpt->domain = ops->domain_alloc_user(dev, NULL, NULL);
> > 	else
> > 		hwpt->domain = iommu_domain_alloc(dev->bus);
> > 	if (!hwpt->domain) {
> > 		rc = -ENOMEM;
> > 		goto out_abort;
> > 	}
> > 
> > Yet, even by doing so, this series having the PATCH 07/17 that
> > moves iopt_table_add_domain() would temporally break IOMMUFD on
> > ARM platforms, until we add the ops->domain_alloc_user to SMMU
> > drivers.
> 
> Drop patch 7 and 8
> 
> Change patch 12 so it has a unique flow to allocate and IOAS map a
> HWPT that does not try to share so much code with the existing flow.
> 
> The HWPT flow should always just call allocate and then map with no
> effort to attach first. This will fail on ARM SMMU at this point, and
> that is fine.
> 
> All the existing code should work exactly as it is now and not have
> any need to be changed.
> 
> Where things when wrong was trying to share
> "__iommufd_hw_pagetable_alloc", I think.
> 
> Don't try to consolidate at this point. Once all the drivers are
> updated then we could try to consolidate things.

Yea, I think that's the only way out for now. Though I am not
sure about other drivers yet, hopefully the SMMU driver(s) is
the last one that we need to update...

Thanks
Nic

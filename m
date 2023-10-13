Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674E77C8E9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 22:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJMU7R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 16:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMU7Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 16:59:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7F5A9;
        Fri, 13 Oct 2023 13:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSW16efbNKfcqHZDom2jrALPrpCPdy/i2Bkda5GXx3U1VpJy/Nx6rHiDaAse01TtF4C6Ld9o7C9oxybWMDWj2rcyb+TUDUQRRHWxIDyyXBRo93Q/EI81i5QqgH8C7auxi5mB87H6TW30BUHzEv/9bkiu99m+IHgnKxNz2iK3CSaBfOGzXXe+SBsJFD2FD+2btA8DStlN39EVip6VJO3Ta6kq0nZttYNAwHMU1s/RPCl1BcHCpSWcsHDI/e/OejhMTiA+SkeoF9IHnul3xM8O+t3sW8rrHxj5mmC2E+UwORUnXucndDH/vbpLmllxWprs3hOkPqKLPatgOET4g98Osg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rfAL6oYREFS0Ss+aUkpKV17zcwZiI6CzUxBUOBDqkw=;
 b=ljGCzLp59STA642HnI2gPgXmXgJtWmPZHqz+pN2XlzBAvIz942M/3VCSCsVdndliC/C+gw1dokeRGWLaBNPG/K6XTQQ5DNgsXIrLTxlW4woRGcMTLMT+hYXPpBrW2PisxPbf4L1+cqcAf5nqgNO7IRscR4VsakyrIfMMqvUiQLjpFZyJpqY86YCinWtDXW/RmQ6SnF41pSPWW1QW8SYO4RhhG/YLpGsV9hLFT1BWaZ0yyydauoBNep9bJm4L4ZSm/TbJtp25th2q6kFL++fFfXZcAFTKbVfX5myMpjllWurunH+VCZGUf3vPg09It0eKeLLHFSdeqbBt1p5yXqk3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rfAL6oYREFS0Ss+aUkpKV17zcwZiI6CzUxBUOBDqkw=;
 b=cZpPGOk6L7JAPwCYBSTSU9zoC53Ye1spePOtVVm1EqFMa84s5nOJoaxGLyNRn8CAZcUMoVO560WOlHo/o8Gvdw/O3DmdNWpBVwzOE9zReKD9qgyrGmP84wfq9WdSy3Q5EJvG7llnRiqNiz766Dl60auyoxqCw/WmU0hKi85+LcdqC220UPtubiCb3CehWSYsG8hJ+4GY5xpGkaODMWwHR+PFi1c6lQcy3Eds/Tch/7LBxClyEmDx1Ko04eqEVw76QRmr84CM4pIRmqB0FbXVMlo1yttHNXoyECJLSGVM2aj0K5rb3HcKDssl7FRMFJ0nAKy14rqcabvoDKXLGSWsag==
Received: from CY5P221CA0078.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::13) by
 LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 20:59:13 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::33) by CY5P221CA0078.outlook.office365.com
 (2603:10b6:930:9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 20:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 20:59:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 13:59:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 13:59:03 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 13 Oct 2023 13:59:01 -0700
Date:   Fri, 13 Oct 2023 13:58:59 -0700
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
Subject: Re: [PATCH v4 10/17] iommufd: Support IOMMU_HWPT_ALLOC allocation
 with user data
Message-ID: <ZSmvkxuEq7M13KYE@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-11-yi.l.liu@intel.com>
 <20231013151923.GV3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231013151923.GV3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: c4df8eb2-6f30-44bc-0a84-08dbcc2f4092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lyJJwDsF783DXqEn/V/XRdE4TaN4CwX2Eq7jDLC5OWD96WfRhej1WwGsXUktXZLnv7IWlq+RX1ZQgw0aw0DiJ7WLnoDJjzTEzR/J1fIF5h/8lcRf41ojbnxHCtPBN2Do0x5dIsco62zdKtYCvVSL/YAb/aAvdmPjWILA4Y91sISO+LaWIfsE9tjvjOeXKFP9qAoyhdpgVCA8wfnLazKCuvxZvuFIxiya1XY5hnutM1wGHMcR/hFzv1/wOgWsFFva9RlNWrIL5ouSzWS+Ej5VjW8l5NUtnUbLzfRx+04KRAYuduj2yP6BauJyuIlKstdA0bz6IxEB4I04XeSOaTuBqMqygpMQ9Pu9OdM+rWERAQjUs8hsJJvGPq42ev+zqHJGaViEVh3oFoouoTDXeSKf6YEmQM9YbBGXJMOhpT/6GaVePwJKP6qCCYBCaKWyVp85W5iy28A8JXhWAOYLD3m05Sxk6yjODDw5/WCHT04fI65XEATcRs38OO3cM49LKzZ/stVG0Hm7sCBW5wH0rFQ30syEro9qFWJ3+kotyT9Yk7+134B9mLUW18sCfHxFgoFed3ElcCsF3CdT/qgKZ5eeNCRh84SMN/m+a4b+v77v6nRQ7THy6KIEBDKDMPU/BQ8hgExI1PKGJI8GPUiNGPSDMRfgL+RpsNfoq2iF217sednOWR9D7Nz1xHdNH1LAmzJuuT4VNl1uPzDOB4kYYCG9oW4iAIsVq1rghH7ppgLBkTs=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(33716001)(86362001)(55016003)(7416002)(40480700001)(9686003)(316002)(54906003)(2906002)(6636002)(5660300002)(41300700001)(70206006)(478600001)(70586007)(26005)(336012)(47076005)(7636003)(426003)(36860700001)(40460700003)(8936002)(356005)(8676002)(6862004)(4326008)(82740400003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:59:12.0649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4df8eb2-6f30-44bc-0a84-08dbcc2f4092
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 13, 2023 at 12:19:23PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 12:51:31AM -0700, Yi Liu wrote:
> > IOMMU_HWPT_ALLOC already supports iommu_domain allocation for usersapce.
> > But it can only allocate a hw_pagetable that associates to a given IOAS,
> > i.e. only a kernel-managed hw_pagetable of IOMMU_HWPT_TYPE_DEFAULT type.
> > 
> > IOMMU drivers can now support user-managed hw_pagetables, for two-stage
> > translation use cases, that require user data input from the user space.
> > 
> > Extend the IOMMU_HWPT_ALLOC ioctl to accept non-default hwpt_type with a
> > type specified user data. Also, update the @pt_id to accept hwpt_id too
> > besides an ioas_id. Then, pass them to the downstream alloc_fn().
> > 
> > Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> >  drivers/iommu/iommufd/hw_pagetable.c | 19 ++++++++++++++++++-
> >  include/uapi/linux/iommufd.h         | 23 +++++++++++++++++++++--
> >  2 files changed, 39 insertions(+), 3 deletions(-)
> 
> Can we also come with a small vt-d patch that does implement an op for
> this? Or is it too big?
> 
> It would be nice if we could wrap IOMMU_HWPT_ALLOC into one
> self-contained series and another series for invalidate.

We now only use IOMMU_HWPT_ALLOC for nested domain allocations,
which won't be supported until the cache_invalidate_user ops is
preset?

/* e.g. the following piece is in iommufd_user_managed_hwpt_alloc */

+       /* Driver is buggy by missing cache_invalidate_user in domain_ops */
+       if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user)) {
+               rc = -EINVAL;
+               goto out_abort;
+       }

Thanks
Nic

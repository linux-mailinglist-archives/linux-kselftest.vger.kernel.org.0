Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A2C7C91E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Oct 2023 02:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjJNAwD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 20:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJNAwD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 20:52:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4191;
        Fri, 13 Oct 2023 17:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMAuKrLKcwFpz1vtAZ5anbHRP6QNoYSiH+VkbMnNawxEHkS/u3LmfzkSh2Vi+KHQrpxToCKd8ZlXiT4Ww21xBBSmdJ4e4pgDeZoMgEtldNDQ1PhJRDBgakWBtEiOWR1tzm1XPKKfb6MBRsluct2GdYl3lOC7zdR5ASLFFplwbCisL8sdpPqP1RVWp2XqqALehCENDivHl8A1S6uRqQh3sprToRBoed8zBu/LfI3sJNKOBS7IQ8ZY//OSkWI+X84ZLOKlkilcOa8ptlpApxNKsYvg2UHW1gElGVZRKvybdyITxK2/qeiumPbbRBANWWdGHJy7ryx79nkiJoTRGec4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrlXc0sLktztgFwsQHErwHBeY67xc+jdIMGa8txrS8k=;
 b=AMGrVPYgwYdKZCo+F4eUyptnYXzg5ZsukZ4mir+NTCVWEFemaNXMkzA1NpeeS7E8jYnww8JIYaVeVYLTV+YfdHTWwfEDnRq91M/cLgHrq8SGJWGYQDqkgR/Q/ShJnYoHKej45RE16s0PSKkpuPuIOGFa3PkyI9clrcLOt7JQd2LA0X1CG1nIMC3vYSiwY8alRDWs/OyLRkj+wHKGSlNL+HBhxUAkY7W2Vwau4SLWXryhSF/CpU9XohrQ0d9fHs8OTxtPJEk7cirXMvPncLXC/mHeXloO1VjGcgjOzBeDPPM1Ofpwo4ewfu8Vc5wx+/44dbG0/gSgGnjxsESS8OMSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrlXc0sLktztgFwsQHErwHBeY67xc+jdIMGa8txrS8k=;
 b=V7ld/Rg2UM/y0cu0LL4FCgqw796qcb21dAlx6vy9I4rhw5+PEE/gLexOQlbuIF/slU/mWvuVLG8VdLGWOWDPWVdIppV+LGJN61nPVHp9ijJ51WvDHJFexm41QHDRCe9xnB6u7mLkbAJPdBoast+zgB7GEZoDtDDaf6pXoRMjNKd61DiOM9AYSHb8e04XBt19vwlxHTNWYYDh0XSgx0SUW8lLfMcxPjlgko/w8AXIgzUI8aUoO1KIoAhN3L1nlgcU8csAnsokDM8i1DqczekbQOs+E8IZARa418xCv0QPrROyBUl1ZE/7gBBDeGaPzDdmbBUo6aj4kf7cO8jUswg8SA==
Received: from CY5PR19CA0073.namprd19.prod.outlook.com (2603:10b6:930:69::18)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Sat, 14 Oct
 2023 00:51:59 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::44) by CY5PR19CA0073.outlook.office365.com
 (2603:10b6:930:69::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Sat, 14 Oct 2023 00:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sat, 14 Oct 2023 00:51:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 17:51:49 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 17:51:48 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 13 Oct 2023 17:51:47 -0700
Date:   Fri, 13 Oct 2023 17:51:45 -0700
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
Message-ID: <ZSnmId5g2m/UnxKY@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-11-yi.l.liu@intel.com>
 <20231013151923.GV3952@nvidia.com>
 <ZSmvkxuEq7M13KYE@Asurada-Nvidia>
 <20231014000709.GL3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231014000709.GL3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 53aaf6fe-efab-4c61-bd76-08dbcc4fc5bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPWh168OMaFDJ5QuyvKGzYX/DltRhrNIL+cX/YPiZbwNX3n+Tl6tXOIVC003xOY5irnVGe1GU8cuVz/nc6Yu11kTm9ZAPky5thl7D5bBVcuShlKMf6eYpl/LEiGsRkxkhK9U78+tiEUzWWvUOWpj9DPXVUAUTxlDSdMYeHdXcFa9F+0ufGQbJbriNyAevzP5Byy7Oz58gzGUB+pG2MH/oxJYu9khr80sh4dLS4QToOCM3tJ5tXrkkZZZcabPsxNhbuBCRN2gpl7YiyLMq8lVwRyAhmOCZjsbr701zS5YQIJIdRV9Toez2NyHf0wluXuil7le5wfiBbQJqLXo/5cHrMbt07DEsuQQshJ6Z2EbFdoPwtyxYEWZSVMSW765n0ahS51lCNRxrQ2cIH6HML5lInf6D1ZC6yp3JFZvWConQP6/sqjQyM9YHr7zUuFndK0F7hmC1YuzjX+FD2mJLW0Jq0wcgvDczcszpwzS2TqbGCc8S9+eoSGEPy3HbDB39Cz7YFcAfUQ95DqJfqRMO4WedfuYebKOXXCM9j0/rGxjToNwUn4ErxH8z/ZsHJskqiZjMXUIDm5ZaKP9Hp1tDGc//HSGeoeZolWVJ5CWxdwFJxIxPI6g90X6MtjgC3Oh6IwmU+70NZ9Mwpd8EKLPntlGQn/+tQPlXKfYq824refQcJCa5zlsEKDi85RNY47xJNlbPDBv+DUTcuDDUJzs/tU3cFepRAebMyqrCpa3v4Zvzfg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(55016003)(2906002)(82740400003)(9686003)(316002)(6636002)(426003)(478600001)(70586007)(336012)(7416002)(47076005)(33716001)(70206006)(8676002)(54906003)(26005)(6862004)(83380400001)(8936002)(4326008)(5660300002)(40460700003)(86362001)(40480700001)(7636003)(36860700001)(356005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 00:51:59.3458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53aaf6fe-efab-4c61-bd76-08dbcc4fc5bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 13, 2023 at 09:07:09PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 13, 2023 at 01:58:59PM -0700, Nicolin Chen wrote:
> > On Fri, Oct 13, 2023 at 12:19:23PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 21, 2023 at 12:51:31AM -0700, Yi Liu wrote:
> > > > IOMMU_HWPT_ALLOC already supports iommu_domain allocation for usersapce.
> > > > But it can only allocate a hw_pagetable that associates to a given IOAS,
> > > > i.e. only a kernel-managed hw_pagetable of IOMMU_HWPT_TYPE_DEFAULT type.
> > > > 
> > > > IOMMU drivers can now support user-managed hw_pagetables, for two-stage
> > > > translation use cases, that require user data input from the user space.
> > > > 
> > > > Extend the IOMMU_HWPT_ALLOC ioctl to accept non-default hwpt_type with a
> > > > type specified user data. Also, update the @pt_id to accept hwpt_id too
> > > > besides an ioas_id. Then, pass them to the downstream alloc_fn().
> > > > 
> > > > Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > > ---
> > > >  drivers/iommu/iommufd/hw_pagetable.c | 19 ++++++++++++++++++-
> > > >  include/uapi/linux/iommufd.h         | 23 +++++++++++++++++++++--
> > > >  2 files changed, 39 insertions(+), 3 deletions(-)
> > > 
> > > Can we also come with a small vt-d patch that does implement an op for
> > > this? Or is it too big?
> > > 
> > > It would be nice if we could wrap IOMMU_HWPT_ALLOC into one
> > > self-contained series and another series for invalidate.
> > 
> > We now only use IOMMU_HWPT_ALLOC for nested domain allocations,
> > which won't be supported until the cache_invalidate_user ops is
> > preset?
> > 
> > /* e.g. the following piece is in iommufd_user_managed_hwpt_alloc */
> > 
> > +       /* Driver is buggy by missing cache_invalidate_user in domain_ops */
> > +       if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user)) {
> > +               rc = -EINVAL;
> > +               goto out_abort;
> > +       }
> >
> 
> Hm. That hunk could migrate to the invalidate series. 
> 
> I'm just leeary of doing the invalidation too considering how
> complicated it is

OK. Let's see how Yi/Kevin/Baolu reply about the feasibility
with the VT-d driver. Then Yi and I can accordingly separate
the allocation part into a smaller series.

Thanks
Nic

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351B07BC66A
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343706AbjJGJ1j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJGJ1j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 05:27:39 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C068B9;
        Sat,  7 Oct 2023 02:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5ALyxMCKUcLRYUQoW/loY38pjfX/+lUi9kiJf665rHs47UaIDDQLuOUqT2EbK8wTIY02hqmuaZSJPpxQZ8rhpXfQR5C2AQBXqWCf+fK+/DYQPbjabgZspvoy7+Bg71wutRifHANlW6QScJYmv4yONAuyOCYiEdgV7vrK6V2qGLOBZE6iqa1KBu5VwRGQ1BWkLVYNzQ/CNSZnnhu3PkcugbvvqOmmZU6mozDuzlcSsmXQBVAvIgkxNWERO5dLW0GVUXFBiYTBuVvM3hfwWKPgWb8/warEBlGgXLwPCCkmKbVTFyg/x6iZSx/CGlnQaimR9DRnG+T7LuRXL3eTEq35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP9A4QIM6pRMgHKZSfkoDNATZz6BjFeCeiR3SxWoVSw=;
 b=PdCUEqt/SrD7iVsC/BywkVBIoukP6s48RMI1NvPFzhBKjwDaBPdP9lVNPq4AGg1yjfaFmF7zca8fKI2RLIaHHO9pl1/S6HOIP+Yqg+CQhNEpkbaYmTLr+Mo+FxARZNBPijo92sqBPwF8p4f1PmBY8YcUdmwWeDPZo3ng/XoTvZMR96khvyuM7GKPZ3Kj5KNSUF5IaqRehkZOHLrmvIW38H2pDCRr/UOhRox0R+GRZCN1zEoMGtKpYsVcnoQxmKZwUox15HMbdpCDCtHEmczazC/ZbZdd+vTpSBBP9vxqZoqf32A6dC96ZAtF2FI2hcM8BM0qZoQh+ej5ijrwnHe51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP9A4QIM6pRMgHKZSfkoDNATZz6BjFeCeiR3SxWoVSw=;
 b=G6KA/zMB+1D/mwiGNJY8Z8PhpUwgWhNB7N9l8mCfRkyYD3362bjr+eaTqNi+8CCo4W52VcQSEObo4tZJzjd9Qkipy9TcC0ZBAoo2KwD16xr3S9QBS2Fk3T5ExaIHaj0BksX4CZKEZiIE/mVmgUfvft1+dUtFqYRgbCYdJwfi9+++ZTmLFvnx/4Hjd13pydVS91/Gsed4XtdgCZoYiv3YcdfOk9b1bQs74+yIoXeHxqMncP7b8N4KzofqoHYcYreuuCNW0U1zMOEAh0P49uUPmx58CtDjGnmYtRMcTBlhI85Ko3SZ2csSIQjbl6ObAAu3Nwzij0deMKEhwZ6MCi8F3A==
Received: from DM6PR11CA0040.namprd11.prod.outlook.com (2603:10b6:5:14c::17)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.40; Sat, 7 Oct
 2023 09:27:33 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::a8) by DM6PR11CA0040.outlook.office365.com
 (2603:10b6:5:14c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Sat, 7 Oct 2023 09:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Sat, 7 Oct 2023 09:27:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 7 Oct 2023
 02:27:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sat, 7 Oct 2023 02:27:31 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sat, 7 Oct 2023 02:27:30 -0700
Date:   Sat, 7 Oct 2023 02:27:29 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
        <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 09/17] iommufd/device: Add helpers to enforce/remove
 device reserved regions
Message-ID: <ZSEkgSlEn5OQjzGV@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-10-yi.l.liu@intel.com>
 <ZSEGyVXXvNQstD/+@yzhao56-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZSEGyVXXvNQstD/+@yzhao56-desk.sh.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CH0PR12MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: 700082d1-e87f-44ff-eec6-08dbc717a2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQqRaFOFVdrJSRMhtZggNfw2kcPsOZ+hwA+TclRtyZxNgNTF1Dom9llGdsjoe1XwZLWn9/dXgdN21QRWJ4Mf8dRNKkgYM9VbOZ8qtNu83dvGpz4Sx9k+5Aw6Gzg2dGGH0rqo/f/83afM1LMeOOEqJk/E891w9I9q23S/8PEaCHfB4m+cQLFpk6SVhtp/2W+/dIRIFbLLzHBDyE/UlWspQwOp3+sAKoUXMOm96JBwZXjOz/FtgLvujuH/Lgn4ZZaPnCQRmgkqGdjEILQFldZSjnovHmMGae7HrA7aedG9PReKNS2LyLbuufwTZbjUOPgSBpuURZMscAYa1M/kpWzTRPMRqI9GCiQy3xJsFcYsGQrD5+6fjsRlexiWijUQ8fy1d3P2iE02UUt0OGNPUR0RNovqKEyxegwZ9ow8P+fn+x9wzsCy+w9vwjaWQwEWMDY+snQvnDMmSpcvBGAXLC2SO2jwzxuBkiw8Fl1QsXgKtNm90bmstRmn3XMjRY2ZjkS5fshzCeeUVFByH3WJQ4fuVJ8Pn9E/+HIxdPt/OSy8Db3aCO+cr1Xy9mriayOaR7wyku0OnYGRWbkcJEhaXKjfIaQMMfBDC/KX0VNu69HH86eTa3eVDD50RVHkOFi46bCfBxBP2rg+wOhDecz55ifuRZ0wMdPKOnv6VkLYe6F5MRP34J8EMC31ZAYVqqEskxGEc995ZzcKWJjkV3YJB3tRF6HN0ka7qpuE2Ng3K0SDcNg=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(82310400011)(186009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(86362001)(26005)(478600001)(9686003)(2906002)(41300700001)(316002)(33716001)(7416002)(426003)(336012)(8676002)(70206006)(8936002)(70586007)(5660300002)(4326008)(6916009)(54906003)(47076005)(36860700001)(356005)(7636003)(82740400003)(40480700001)(55016003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 09:27:33.2279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700082d1-e87f-44ff-eec6-08dbc717a2dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 07, 2023 at 03:20:41PM +0800, Yan Zhao wrote:
> > @@ -444,10 +465,9 @@ iommufd_device_do_replace(struct iommufd_device *idev,
> >       }
> >
> >       old_hwpt = igroup->hwpt;
> > -     if (hwpt->ioas != old_hwpt->ioas) {
> > +     if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
> >               list_for_each_entry(cur, &igroup->device_list, group_item) {
> > -                     rc = iopt_table_enforce_dev_resv_regions(
> > -                             &hwpt->ioas->iopt, cur->dev, NULL);
> > +                     rc = iommufd_device_enforce_rr(cur, hwpt, NULL);
> >                       if (rc)
> >                               goto err_unresv;
> >               }
> > @@ -461,12 +481,10 @@ iommufd_device_do_replace(struct iommufd_device *idev,
> >       if (rc)
> >               goto err_unresv;
> >
> > -     if (hwpt->ioas != old_hwpt->ioas) {
> > +     if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
> >               list_for_each_entry(cur, &igroup->device_list, group_item)
> > -                     iopt_remove_reserved_iova(&old_hwpt->ioas->iopt,
> > -                                               cur->dev);
> > +                     iommufd_device_remove_rr(cur, hwpt);
> Should be "iommufd_device_remove_rr(cur, old_hwpt);"

Ah, right. Should fix this.

Thanks!
Nicolin

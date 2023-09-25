Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911EB7ADE85
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 20:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjIYSSf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 14:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjIYSS2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 14:18:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C3EE58;
        Mon, 25 Sep 2023 11:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJTD/OlVsTF3+RJxAu31mjT5KsZ0yyTGWzwhfAYvuFxk+0Z9rnRZZBcBjATcvK5eEiBxTQ9Z5HRr9NEn3MJFlVJBkYZ5sIMQp7y+/liV5fp10czA0elG5EUc0N878xkvGEmOyxm9aj0nc8cQKcJH3BkAPAXJ9Eb8leZjuRV1KHJvi6x/YEqqrZiQC5u5RyhnmjGnMJ3mBeiG3gFg9CySoatRwXPwbbYQld0DEd1/+QajwTYZuBhqTsYpCPlwWl3BObPoeLu+6M5LuaVh6Dqi0y5wSF+rUfyzvSAZxLdOKerDiXKjc57Mq2avYNNQo0sNnFN16Xae8IESmxmT2IOE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NchV+bYWyhxLSi9oE1VoshpekonTOldxtuUD6Wbpvo=;
 b=MpDcJgfBr6DOsK6MR4qreyIqcIFP7n9eTiJZ2Vxq08pddnH4pSZO7UVSZw1L9UM1R4P9yL0tsUc5GETG4Z/5/rZkrz3yRKwE+eQ+8H00FD54xoTp+zP/ip5CKH6hCZjlnGLvebt5qy0Z++sB8VvpaSXaxjTjd2pGCkgZ+kQKQm11oLQKlD8QwaScdFPF7uf4k7ovCQWzJtlY77U3ay+k4ktC0dMQTR/8BVVCT42QUHVtdgnHbMwQtmwYwqCwU/QGrkK7tHbLUuY7rCNqgYF1Fh8nq9jMQpp6o+49UR7EVqn5sdzfI+Bmsldq4UsT/EbQhUKtNikc0Q4c2O5hDZo2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NchV+bYWyhxLSi9oE1VoshpekonTOldxtuUD6Wbpvo=;
 b=PJW+bc1sKvf7RFS3tTQQCY/fOHYI1IiSCTqIe/tlVi/A2k6LI3PP4xqTyg1aeMLIPEUX799jXPydpWMSaeBc/LBaFfcf3cidVP6qF2ManCELBLf75zqvhz1E43PffbTA4bTJ70WvpBW79xVi9s68bLtpnBS44DCKR1tU6e46IMdZPL2rPxU85/WHr4up5lySQxEGTndTD/fpKW+Gzp7mxPnTf8evcWrrDmdw2nUBGuX4vtB09iSnix74rssN55ET/kRcTaRqkahqpdgPWxNNcnBUPgUxpyxxEigaLZ88tvitYaQ6Bl/ZxbrAwNFy6ESdi2ZcbmA+a2xBGMGHHBcEog==
Received: from DS7PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:3b5::24)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 25 Sep
 2023 18:18:06 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::81) by DS7PR03CA0049.outlook.office365.com
 (2603:10b6:5:3b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 18:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 18:18:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Sep
 2023 11:17:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 25 Sep 2023 11:17:53 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 25 Sep 2023 11:17:52 -0700
Date:   Mon, 25 Sep 2023 11:17:51 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>,
        <joro@8bytes.org>, <alex.williamson@redhat.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
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
Message-ID: <ZRHOz+uuJ9gGE2ZF@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <4b17d331-957b-44d3-8a19-0b2ccc59150b@linux.intel.com>
 <ZQyuIQbyVk9p8C8o@Asurada-Nvidia>
 <20230925130506.GA13733@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230925130506.GA13733@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ffef03-393d-4dc6-62d1-08dbbdf3c3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0IpDxQWYHYWSeCjvhzAZzNZ6ztRjORw2ObdhBPK60Pq9tBxFSexAVRBKA1oWuxVFaRTPYyfaLiyzw0aUUEGD3gJQvGfz6q7EQT4ijuKSq9HZiM1ptegCCEgsDtOWdi3vViwOebtRwGcrOteUI+iLL3UOdLsJzvEgnhzDb21NYbQ1z0e3dSguxsZElvz+hlK925kmndTvw9nfdAC0lLHbVhKaiXjO/S4ywemeC5VPjcYSdtNW/BJ+fn4R5kPoTox5IFJyw0+6n0X94efbSn0+JHhWuVpLhi3KaaYTsNsH+i8z5pU/cueGYq8wWntyoEBEBp+j/Qbj3vdxAiqtFkLsG9bVqeS3UHRFZ6HjZMVbAj+hQmCmfX/ruPOJBS4tNi4no6fX3UWcjsVU/84u7jTvsrqfdO1SCJIJLW/Wy249dlHexwGci9TKLmcAINxkJO/RHzWWF8JXIt6KS2H9rFf6h+xac09EimHTk8oqQVGXvf3S+9Kw+PaSdKsMjONDTFHt/MkXcpXNcfW4LLTq06NNSKYCinsbYkyhqeuwn9UBTEwslo6rY+vt2w28X+b/agLXL7VfWvJv5ta41P5hv131ximplP8YmZANmlTkf+hzVRFrFgjbnXubpqXlbOleSHqZUNkeGw/8GL8oXXrPcgTRUPm8k2Kqg9SStiLG1kLO3PViJmqh3ik9QXo3fonX9LSwqpKFemQTMUhM9R8WSNFvjutPFhoni7q0x7SBhyw2i8ZodvCpVRvpTSJ/ypAk2+BlJk4YS5eghbxRnAMa9/cyA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(70586007)(54906003)(4744005)(316002)(86362001)(70206006)(2906002)(82740400003)(33716001)(7636003)(41300700001)(6636002)(356005)(36860700001)(5660300002)(7416002)(47076005)(478600001)(55016003)(8936002)(6862004)(66899024)(4326008)(83380400001)(9686003)(26005)(40480700001)(40460700003)(8676002)(426003)(336012)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 18:18:06.2288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ffef03-393d-4dc6-62d1-08dbbdf3c3db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 25, 2023 at 10:05:06AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 01:58:19PM -0700, Nicolin Chen wrote:
> 
> > Perhaps we could put all min_len defines in uAPI header, like:
> > include/uapi/linux/gfs2_ondisk.h:442:#define LH_V1_SIZE (offsetofend(struct gfs2_log_header, lh_hash))
> > In this way, drivers won't need to deal with that nor have risks
> > of breaking ABI by changing a min_len.
> 
> I don't think we need constants, just be sure that every call to 
> iommu_copy_user_data() has an offsetof() as the last parameter.
> 
> Indeed perhaps you should put it in a macro and force this to happen eg:
> 
>  #define iommu_copy_user_data(user_data, from, min_size_member) \
>   __iommu_copy_user_data(user_data, from, offsetofend(typeof(*from), min_size_member))
> 
>  iommu_copy_user_data(user_data, &data, iotlb);

OK. And always use sizeof(typeof(*from)) in the mcaro for the
current data_len, I assume?

Thanks
Nic

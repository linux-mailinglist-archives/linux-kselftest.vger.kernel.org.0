Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA7477D761
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 03:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbjHPBLn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 21:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbjHPBLI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 21:11:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195A61FFC;
        Tue, 15 Aug 2023 18:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaiL79rmsGEyaMAwiSw7BlUoYrRpOecVihAeociitZzhSaLvfJYPsTaIArXpJBp6Ngbz0XxZvZNv6EqVMx7ElkKbth6KyIiALTWiIYfKwFZtPaYa58e7SagH+FtOoOwv+e4Au0T0uODM6Q1hchGEOV2jj0R+rEoCppvU1YCKoE3r0ogY6nl8fsvWgL4vOkov7ibL11veoAb1NXLJ7i/WKvU2ci7Tr9ecXZodj7Ma5Rx+SSCodxvOGPBMcZxgyPYXYK8aT6jBLdbvoUOoItFjJau/OZpu6v8LoNbmIRaHCKtNA+/phz0uvgsXFyMfR5tX4vQEfr/fmPRrurdgjO+FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsBNKmzFTxb3rf4otJgKmzDEhq+MarQc2xuLxTuZ/ug=;
 b=R9cEy2QWlm7tda0yL4KCOLuriNUKdQDHUwK/LpqCgjd8ML2ilscl0j0tIeZVvgMlHvyISVl1YE9USqNiHMSk5vEoPSoj/xxWTXAQRwXCxXd+DrCz7gs96EEkJiKUET8aGxdTo964tVy1DrxUa/uB8SKGE+yEwNszxoyLj40Wq+DW84miwRLa3XzcJh64ieZMqtmunROUgj6VRXmcSNiYOTMlWJ+0GloRtNm2o2rFcH+E66mWzEeXkroSdhZRpigV2rMbKMiKMWWYyWPDBb2bG1oZrT5dHXsRf/jAU1GvN6l7FIuyit0cVhRNc4lurWUgVez90xzoEdurDk8fYOj2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsBNKmzFTxb3rf4otJgKmzDEhq+MarQc2xuLxTuZ/ug=;
 b=VbmmU+bSb3elt8lmYWNeOTaLe2IqoEyoFla58JLkYLsIKzSQnRbVzfV5nCmduQiD608L/KRfqBGxT/lWMZFwuqmSVt74FSYPAb92kn8XJUPJtjktTvPamb4nI3mSb9ebmttgh0+0IAzq2gPdExj4uZ4k4mFPEYDm5n5K+nalv3radmcdjJtushuE7lb/xI3Cx1qEhac7P5j2O74XL991nCJrvbc5Ea+IkBUw4dRHrgXXn4xuIMOEEUzrATRKkPhh7Ljblr9VTpAX4IvsqenOTfMqRVIXU2QICZhszhDL35MhPn8lROSxVvchvhDb5AsoGov4uAxuVdQlzVV0iSJm/w==
Received: from MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::7)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 01:11:05 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::37) by MW4P220CA0002.outlook.office365.com
 (2603:10b6:303:115::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 01:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.3 via Frontend Transport; Wed, 16 Aug 2023 01:11:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 15 Aug 2023
 18:11:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 15 Aug 2023 18:11:00 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 15 Aug 2023 18:10:58 -0700
Date:   Tue, 15 Aug 2023 18:10:56 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
        <joro@8bytes.org>, <alex.williamson@redhat.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 11/12] iommu/vt-d: Implement hw_info for iommu
 capability query
Message-ID: <ZNwiIFM9N9ZXSnrG@Asurada-Nvidia>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-12-yi.l.liu@intel.com>
 <ZNuoWRH/HthxsLMd@nvidia.com>
 <c6c6a390-d1d1-a5f7-cbdb-2120043eceec@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c6c6a390-d1d1-a5f7-cbdb-2120043eceec@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 374b13f5-e398-4410-a644-08db9df5a9c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/MJt5CBbRLrVG5HEqo/YjyrUMQsroJwN7E6fVEmUZt1Scwkeh+m0SZ5KTrA7zCxm5jZus5S11JiiyIhr3baHP6zCfXJRmiDDQgmqrCQmPc8ftAT5GKhZizdx7IKu0Wdn3eCD/nWwlxHL132QYMKRskKhyYCS2LrZNuLzuFmMNCv2LESBFKoZUhAbJR255qh6s0hh28YboMkv+NQqGrij5/EVWVg7xZT2rvhmYosB2ufa438xya/skw2ppDeotfNPgWe7ykXw0SnxGZGdIcfsuv8gbj/QPzCpKs3W7yzuUj4RukKmF2UAQIjX7070Q44yDXXSajy+8h1NLjvklUpoTH5WYb0ffJPtqjc2igbpdkWKlX1v93Eqr2I7YPnil6FRqEb70gyNt1t731RJq05+OgZKp1zg6eea7ILLX1CzruyQvzlwIQP4rYH2wxBINQ3F8cfKSFbdoKP9vN6pEfdl122qbV0XhGbXTpnzSb77kluoU0oneKPOhsMKdtUkXp/Sd7kHfW42Ae8Ltyu+FF288aYMvs0cmgOo4nqzXWIMUL9a5T4eGzz6UQ1JUlQeJJhPQ+o4OLIJy/5l2QGocEko5JXXEvVNusBW/pRalEuXt+0tur1hDWW561lDnoq99rTRJlu1gqgApiECz21E+fvBlAVMpsGiT5PAR+cOzfLH0OiUuzNJ6Vss5gc6K8MwTqgPMO/j/QSyWOclK6o1/7GMofTyxIOFV1ky5DEUU+aWTNAb44LwF4COSPg1vB/ND1v
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(4326008)(86362001)(9686003)(316002)(6916009)(7416002)(47076005)(82740400003)(2906002)(53546011)(26005)(36860700001)(478600001)(8676002)(70586007)(40460700003)(426003)(356005)(55016003)(7636003)(40480700001)(5660300002)(54906003)(33716001)(41300700001)(8936002)(336012)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 01:11:04.2970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374b13f5-e398-4410-a644-08db9df5a9c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 16, 2023 at 08:35:00AM +0800, Baolu Lu wrote:
 
> On 2023/8/16 0:31, Jason Gunthorpe wrote:
> > On Mon, Jul 24, 2023 at 04:13:33AM -0700, Yi Liu wrote:
> > > Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
> > > 
> > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> > > Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> > > ---
> > >   drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
> > >   include/uapi/linux/iommufd.h | 23 +++++++++++++++++++++++
> > >   2 files changed, 42 insertions(+)
> > I would like to pick this patch out of this series to go with the main
> > get_info stuff so that we have drivers implementing what is merged. I
> > made the trivial fixup.
> > 
> > Lu are you OK?
> 
> Yes.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Hmm...

We have Yi in the author line and Baolu in the first signed-off
line, and now Baolu with "Reviewed-by" again...

I guess we might need a bit of fix or re-arrange? :)

Thanks
Nic

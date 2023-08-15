Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BBD77D285
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 20:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbjHOSzT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 14:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239588AbjHOSzI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 14:55:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123482135;
        Tue, 15 Aug 2023 11:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye3chM9jkWn8fsxKOTSnF3kySCfDbEuCWYs8Z2VbR8AbTdUywndhtxMflT5yb8xtbFPJ9nNnCZFGOH63tadti5NZqeSDKEP/F4/5hJL5Of79NduWtEsaskJAwXYl0uxd/bVfIH9m4n7NzpE7HpFqI1hK/ElbNPM9vzQ4bURdlOxiwv5tzyUcL9Ieiu49tOlB9djnF3Djy/z4M6eXZi0C+fNGSKgFOUg7J8yH4plFYq4Kh1UAjOEr0UA8TUVTp9PkwljaO4308s0c8jvMZ4Rh5jSsriLHIE2Bdq6qrotgHpSm3io7R8QvPrN3ac3H1ZYjcnZvcYF6SAOOKGy1r8rvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHHNQ0xTLx4eqHckN/y7niVy+yU49iQGP5L3mvJCkcs=;
 b=eInQ2qPUCPk4PIwQ15maTbjiPDO5H8N4SS8coi+/HM5ksty8aJW1r16t8v3BvhDtvRWmYAyJ4+pzUd2vytyeOUm6JLK5hDLXTJegE895XnWuA/tSz7b+1S1xlCbLtWB6daJbVftCVl/G0eTTrih5Uasg+LgiAFqQ2LyBAF8xrYnLMM6hFFdjO+pLu5AOe5DlATQkV6+z+1n2Esb4dOwVonP/eJglgT0ma33B+NN63q8DSmJRQQf/dQoQ/m1hSTsuGJvvLdlHjgZhkLEhy4Pq9hlVDt7DLxCnSFJic0vDtyck4jDheC4NnXejyWcoMvhgBD0b2SEQpfQhXk5R6zOSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHHNQ0xTLx4eqHckN/y7niVy+yU49iQGP5L3mvJCkcs=;
 b=UZRN5KhZSYMTK92RhGGaJArg682fim101XvUOMe4lgGygT6hx/UOc2OrtJFjCMcrNYi5Dq6cvPVyLMrVw0IaxKiaYkscDxnCnD3Oqv3q2NVFGZ12NSC/c5iKkq1yXsGLfIz2v5va3P/LrWh28ThTlRdGcACaiZZkIFcPj60P785/RBSxfQwObzw5JlMIjp2WcbZ4/fAX4O7r5ZvzW7gfAmS1swrweObtBVBwKHiHDFIcxLCX+poC2noaQfF+T1C/b4eHkSlAyxX2Sb+rG8kxFyfI55XKmxRK1s3eAODf1WUCQsN1YUs0MqRInXFWjXr0kcEZ964raZdKiXquCmyKyg==
Received: from SA9PR13CA0015.namprd13.prod.outlook.com (2603:10b6:806:21::20)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 18:53:38 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::c) by SA9PR13CA0015.outlook.office365.com
 (2603:10b6:806:21::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.13 via Frontend
 Transport; Tue, 15 Aug 2023 18:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 18:53:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 15 Aug 2023
 11:53:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 15 Aug 2023 11:53:28 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 15 Aug 2023 11:53:27 -0700
Date:   Tue, 15 Aug 2023 11:53:26 -0700
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
        <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v7 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZNvJph2AHKroujFe@Asurada-Nvidia>
References: <20230811071501.4126-1-yi.l.liu@intel.com>
 <20230811071501.4126-4-yi.l.liu@intel.com>
 <ZNuogZV2eEeVwNX4@nvidia.com>
 <ZNu2XWS0BERqykIA@Asurada-Nvidia>
 <ZNvEAWF8ljWHrcws@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNvEAWF8ljWHrcws@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|PH0PR12MB5433:EE_
X-MS-Office365-Filtering-Correlation-Id: b8895ed5-fdfe-485f-3928-08db9dc0ef7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UHcuo/UpostD1HI01mKpVaWIyqyQwpFyC2jXWJtykpc0uhzGgnYr64hMCTcnF4ZJaDMivXWFgGbAPbhrqMZ3/ZN1zy1b91+25UWfl7HjLMCG5P5i+WwPk45OJsu44ci5zNWQanUpFEvYxVbRe5x3U/WABk31VnZr42rMARqVXDtZm8GtKjSVIILxGppcfq8N7gWfwInhMO6uEWbfYRtAt+4EBhHRvFGewsq52RP0GUCrwFFUyz4SG1grElMKAQ5RatycvSEwUNX7ngXH42a5JzpaWqKlYTP1hJQZXCx1ZAJ/pwZHf5Zf1YO7Y4D1+DbkV6p3jOllB5B7ZD9KMy+FkOTuDNX58hIYgi3rPxS/NLdA8qZSOBWZChwbQxyTQ20/ZFvWU3CSnN2bB1LVrApg0ojfCyc51hujvAW6yEcFihibjwSo/rue+y6yEYDfqXo+n0uG/n3vpj0VSUAUYxNYyh7GE2t6teEODydv9DiM8sw7q6JrVr0rHqVFf/k9ZNXyBMb7gQCgOE+WQb3P4DKDVkmqdZNkFV7QWwSa5fM6RVKTvbXtbBHsUXbsV9bgRqZrkfUuHFHbpu2W7pd10J8b8IRTFppfXroPKQKhLriwZwT8R6A4+dEvl77vcvaK6j0Z1whLcoWIjhPKlas6wSaE0el+XViWOAxwVNRxg1Q+KHtSHgfahjbbRHF8a2GshOJDpitE/JcGqxz2uY53z7SyuSG5oDhvwFMjcm3DuZJJ9Vh3+dd0iBSqZJ/Os1aHhG4
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(316002)(6636002)(4326008)(41300700001)(47076005)(70586007)(426003)(70206006)(83380400001)(54906003)(2906002)(478600001)(5660300002)(7636003)(356005)(9686003)(86362001)(6862004)(8936002)(8676002)(26005)(4744005)(7416002)(336012)(55016003)(40480700001)(82740400003)(40460700003)(33716001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 18:53:37.9181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8895ed5-fdfe-485f-3928-08db9dc0ef7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 03:29:21PM -0300, Jason Gunthorpe wrote:

> Well the way it ought to work is that userspace can pass in 0 length
> and the kernel will return the correct length
> 
> So maybe this does need resending with this removed:
> 
> 	*length = min(*length, data_len);

That "length" is 0 (copying the value of cmd->data_len), so it
should be 0 even having this line?
 
> Also I see clear_user is called wrong, it doesn't return errno.

Oh, right.

> Please check and repost it ASAP I will update the branch. Probably
> needs some doc adjusting too.

I think your version should be good. I can update the series for
the doc part. Yi can confirm tonight and report in his time zone.
And it should be available for you to take tomorrow.

> 	ops = dev_iommu_ops(idev->dev);
> 	if (!ops->hw_info) {
> 		data = ops->hw_info(idev->dev, &data_len, &cmd->out_data_type);

It should be:
 	if (ops->hw_info) {

Thanks
Nic

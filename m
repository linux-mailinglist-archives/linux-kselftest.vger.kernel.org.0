Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6526B562D
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 01:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCKAHK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 19:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCKAHB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 19:07:01 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EDD1308F3;
        Fri, 10 Mar 2023 16:06:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aodFHnP9UnlpRPBqMum2VsKnqBmxmqlKDdYihLqnKv66QXCWOkaFOTfPdzhIs1rAJXPx0Yjnw1Lygzr9LKYSJ3hFcPZCzXr3LAs1MwoCV3OHda15eLT82vQ5mXY49wiy5G/2Orfiht6EpqxPE+ZIGggdlMCAxo0v4rXG+vPM3YKOlPLoQrr0rH3Q4CYvqUnJMLUn5uYg329DpnNmIbQ8rXxI35MuqJyI+avi7KYos1G+/9sJ9xZGi6NlV4ir7pQMD9GSaGCR783Zbm8g9MyJCYazwVs5FNWKcpf4kHfpoCteASAP114xCyo8Dm1jnnvgSdfVG8D81/rs3gpTvn7Aeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TACAGIzwONNFHW4NSRGZIylwwI0j+LO78fVcu96V8Ug=;
 b=fVufRF4O5Q/VN3TqJxggcqzwZ/7OcZV9Mq6dPtmD8O1CxhS/N5+MAeUYHNlndsuglmoNXp7ACok6XufhbQug7UxmsV9cufTR4d8lpjlTjc9GEnTByDZ146+lqxXWTmwOlbGnwuFkqvjCthS3olAS/jPaobdRc/Y5z6lMahBDvzSU/c6Tdq5qQfKa8wlle1NSIqgsx/4+ri4MCZJ2EOncUEQ87rOP6hEf3zwHUR7k6Kb82MNgSWx7WMCPKRjPHA1Hc7/gj/65Oz/EMXx7nzY0kkMC3a0/qt47pBYfE3CumBxTb1jOzlBwrLGgdxqROZKMsITIHPVGboAodcUcOtgX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TACAGIzwONNFHW4NSRGZIylwwI0j+LO78fVcu96V8Ug=;
 b=VwGm6jBxR7iP9OnycHVFW7LsywlovrWUb3KQXdV/N150zj5wC5u2WxbLAslgcxrLtiqVTW7bbyjW3MnZMuVVjiv0sFJ2rkGAFYMx+UIMPEsVhwdftYKRTtBZyp8kDeWqif2DvHpvMxV2eFNx1UpQFw8rKBd3QTnbdZQH+GAkg4k6xq81UU9WOKen8fq6eS3JBQ2GLxQu0IzPOs4TX5PXijJT6L/1g1esCNRVuaTreK/o4UP2T1FjZ1w/VhdsZRr5X45whbv+s+LqWEwu9R1EFZYlZnG9B5lFy0ntdXqi0UvVvDjX0kXQFgsEkawYtINvBWZGkszCpakHNzkRFaVcMA==
Received: from DS7PR03CA0184.namprd03.prod.outlook.com (2603:10b6:5:3b6::9) by
 DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Sat, 11 Mar 2023 00:06:56 +0000
Received: from DS1PEPF0000B07A.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::c) by DS7PR03CA0184.outlook.office365.com
 (2603:10b6:5:3b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Sat, 11 Mar 2023 00:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000B07A.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.13 via Frontend Transport; Sat, 11 Mar 2023 00:06:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 16:06:52 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 16:06:51 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 16:06:50 -0800
Date:   Fri, 10 Mar 2023 16:06:49 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <yi.l.liu@intel.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: Re: [PATCH v4 2/5] iommufd/selftest: Add
 IOMMU_TEST_OP_ACCESS_SET_IOAS coverage
Message-ID: <ZAvGGc5Jt0uSkN8M@Asurada-Nvidia>
References: <cover.1678284812.git.nicolinc@nvidia.com>
 <08a875b83daf7047c3cc67ed0da23045b6dc6fb9.1678284812.git.nicolinc@nvidia.com>
 <ZAuP5ewmDwql8Pn5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAuP5ewmDwql8Pn5@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B07A:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: c64ff67f-9fe7-4465-f26d-08db21c4873f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fO4udZWPRqELSgYZXAIeSjLiSXHvxF1xn9Mex6J+zXa2wFplx9nI0xZYxFp94VCWlP3rnrYOu9foLCR947ikUurnrhkxUhXApncoNk5X8WdB4KFG7tqwyJ7C5QSwzJbv57n055KzWTGXpp3UWh6RHpd03me1CozOc9LSXEs+zWqiN+C9kj5R3PEKr+NWiFkp/osx5VfaDWOp3ho9e6gzLUd3V8hB/d3hbN2ANgbVDPLzL/W675wIPdY/9ue+ozd/7Fju634ajwFp49en2bRvyOvSoAtT8N6UrS8bSdilXKCFKo6aNSlabh+l99I4F+bFkTy2XYR+uqud/GIDRGfYei5GlxdVHWoK4E7ivFfCRObMidwbvivTlNPz+kJ75jhb/yMxdm3WXmgnBXbssjWGuqdtf+/JYsCB553si22T6b6SUhWel/8kgdB6tfTgLWhUOenAR9eAToKZ3NZNNagCtsyp5RLrb8fzyeD7hQn2iMGglqMSDa8jssv224rO5YOtY+unGZMRQ31pslVOdqYSdTzOKIIr3Rtp2RkzOEi62+lqJydTooHqygqJhcTk5jGueY80Y0OyCqonrfd+IvnMqf1QjN66Au6JxVSLEi1yolUH9/CX4TJP/wAxOF6VHg/0J+I5vsyWSnZ6zMlOrGTA6MaKNR9a2LTSHqE/MkWXghnvWi3d64Ue6AQAgQ+U2n9YvSgbHlmWLAfl1EKThm+IYUAG1AWXQkg4sb4zTuhLJKjjd705uZ4br81LBx/WeT9U
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(40470700004)(36840700001)(46966006)(83380400001)(478600001)(316002)(54906003)(6636002)(55016003)(356005)(336012)(47076005)(36860700001)(426003)(82740400003)(40480700001)(9686003)(40460700003)(26005)(4326008)(86362001)(5660300002)(2906002)(186003)(4744005)(8676002)(41300700001)(70586007)(6862004)(70206006)(33716001)(8936002)(7636003)(82310400005)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 00:06:56.7916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c64ff67f-9fe7-4465-f26d-08db21c4873f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B07A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 04:15:33PM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 08, 2023 at 06:25:59AM -0800, Nicolin Chen wrote:
> > Add a new IOMMU_TEST_OP_ACCESS_SET_IOAS to allow setting access->ioas
> > individually, corresponding to the iommufd_access_set_ioas() helper.
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/iommufd_test.h          |  4 +++
> >  drivers/iommu/iommufd/selftest.c              | 26 +++++++++++++++----
> >  tools/testing/selftests/iommu/iommufd_utils.h | 22 ++++++++++++++--
> >  3 files changed, 45 insertions(+), 7 deletions(-)
> 
> I'd prefer we keep it so that the IOAS can be setup with an argument,
> this will greatly help syzkaller
> 
> Lets have it so a 0 ioas will avoid the setup so the second call can
> happen

I assume that you mean the iommufd_access_set_ioas() call and
the "unsigned int ioas_id" input of iommufd_test_create_access?

Thanks
Nic

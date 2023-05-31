Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30A37174F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 06:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjEaENP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 00:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjEaENO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 00:13:14 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB47CBE;
        Tue, 30 May 2023 21:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RncTv6oWDy6ibT8J5cvK7jVZRYTvwVaBMSt6S14kw1ENwMy0/G2QLZiTAuZrq6XywdO1UjutLQPw0IMKYYwUdySoGe71/QikTy/d6MttJI/O/tsytBbnF/UyK4P0n1jdBn+x4EAja52x1K6V1+7R0pDvxmhPAASFLZ3fTVabFWCKCIMVNHIiniq3qWgPJCGypX2o3PteWSw8Ck/r3Fcr7F+i7C8unYDsrPdIrwCNmMKMYd2WHMcHUV7QJu0I+IILfBC1y41qFLiWrJ5X2Dbj0cYymljIJRoG4Ah6s4y71PlZFnx8hHbAldlmioMDddvMOCOqBzpbfWE+AhV1ip/PCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aco+PFHPL2vMJiTsabcyUNTpq2gnRc7tt8AN+dm+o+A=;
 b=D7D+rENCZnwdwVGQiQK43fUr0qlrK4Oy9nTuBDRNYCLtn0aet13L8Kjfn7SblK/HYuR682oDw0otFd9fqFUXdzThOGTPjka8tJt4283VpIIOIMHt0YCln0j9huieJcVE6HS8cHDkmVFTy94HMbDfbPVsHa9lXrH9Y1AVpPfAEs/6GOvQQ1GJSK7HOswTKmrcbFoiSx/EI1Z4hhISEJkUPel3Sqne1TzNp0Ww/lAMBWOhFm2u4ajIyAatgipHXfCSoXFZUXysV+k4zlAZzf1+zZrwhGniQjomNifZvx/bqaKC7/Q212KzC6qrzwO+6b3SmAo5NRBbxsvQVSQAQH77dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aco+PFHPL2vMJiTsabcyUNTpq2gnRc7tt8AN+dm+o+A=;
 b=Rq3fIFFGx2/3uEOwccPruOJm6YvaUnbYgGlx80stnhzVmNr6rjTGR6iLbeEBDHqsFX0TGVFoRiLNy9gS+/p7UCsXu4HjHDciWVBmQpqY31kDGLfJTcVThbYFskXQWCqZddNcZihwVHAWa6kWfk1e/qHe02Wx61O8urcedlpzW6po2VDfgQAWNFojI/oFcBLt9gvW0wrLbI4zpwIfVwZ6sIN9FeLctkt4/V9C8s41lCxaikQ/ZpZ7sCix64lFlD1cKlz5G9ldP9l2/67xZZO6Jy8nFfsZ9sP6cMhZDmCxvq4j7Rb+2lthij+cLEZLAWCJlm5gFyE5/8wl4jwXzPgD3w==
Received: from MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::7) by
 BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 04:13:09 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::78) by MW4P221CA0002.outlook.office365.com
 (2603:10b6:303:8b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 04:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:13:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 21:12:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 21:12:57 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 30 May 2023 21:12:56 -0700
Date:   Tue, 30 May 2023 21:12:55 -0700
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
Message-ID: <ZHbJR2wrRarW90Jy@Asurada-Nvidia>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
 <ac924372-210c-155e-9aeb-36218d35444e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac924372-210c-155e-9aeb-36218d35444e@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|BL1PR12MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f02efe-3097-406a-ccda-08db618d578a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRJvG9iAUXbwwijb4s451lqGH+YEsw3HN9l45aple0lD2nMjQIgCFndyUsOeJ/BXvyWAztpwrg4rrB+zBPar5iUIb2m3FljwO+0iBVI0fTW2qjn7OnFHtcVY49H0DBQwX+tAp7cCNu42oSpBHdmeMl0aA7qEKTTJcBtW+W+GoE+VYMnQ8S88xzqGisuZ2k5xAgp7/qX8JJPNuLhMNENfepNGBQ+lmT+2PAMi1lAgcWb+tBfiiwPcy2Kvj5iVnItKTQd6mg1EWxgpZu4dqdaNa7HVWgIqOVlj9cX1y9osXVu4WeNRMNvA4qA2tZPQRAyiY+1z/j2I2oU3L0RZFwhHQ0ZXtDPORoT2OuGjxxMq6t0VnB6aLUJlPi1YeHptJ9gyq4rV+ClVlygnCYCQfUbB8yWmEK0OkW89CsYTepKqvtC4oQqrqTO9TYgTP/t77VDIR9V8ABZuKGl10hrZVtB+553ZNCgXs3xSDKgSanQMVW0VLxBoYOQScS0wKv5kz98Ne0okAngVAL9p6pkmduZo8M0IjPp361uaZGuq2A7A5Sda1IEyBHTNDyVKaVYw4e4T2PyQGw3q8A/31HlMmYbvo7MZEChKwF1HTN9S064BckulyctTCdyJWjkkgdR9I+c2IcbuR7p0HThir1/IixX1Xg7ZezjOQ4AaIqsm4ch/Kaf775R4JbpkY6UGC/iTBUy2eEG5LZx3RrvNSRfLrqIZ8BcnAsnBqnfXerw/LXF0gKZaJQAU1YfgnQB2rFgkHDkW
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(33716001)(66899021)(5660300002)(186003)(40460700003)(82310400005)(55016003)(40480700001)(8936002)(8676002)(6916009)(9686003)(26005)(4326008)(7636003)(356005)(316002)(70586007)(36860700001)(70206006)(2906002)(54906003)(4744005)(426003)(47076005)(336012)(478600001)(7416002)(82740400003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:13:08.9116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f02efe-3097-406a-ccda-08db618d578a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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

On Wed, May 31, 2023 at 10:10:15AM +0800, Baolu Lu wrote:

> I agree with you that the existing IOPF framework is not ideal for
> IOMMUFD. The adding ASYNC flag conflicts with the IOPF workqueue.
> This could lead to performance issues.
> 
> I can improve the IOPF framework to make it more friendly to IOMMUFD.
> One way to do this would be not use workqueue for the IOMMUFD case.
> 
> Have I covered all your concerns?

Yea. My concern was mainly at the fault report for non-PRI cases.
Though I am still on the fence about using IOPF framework, let's
see first how the improved design would look like.

Thanks
Nic

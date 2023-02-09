Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDF5690E03
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 17:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBIQMA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 11:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBIQL7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 11:11:59 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB1A5EC;
        Thu,  9 Feb 2023 08:11:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI++1HcUlTK7bA29Bvt0z3ScriFYlAEcKOEuNTt+V6KoSB91z18aB7f/G04/z4aqgig4ZAqC8ETzhmHJPAxkaJVlyS+CNoQnQjtJ1YdfyuGX0r3uzvNWLuISjPSDNoHHjU3bxp+/uM+PTBVtwNQgWLDf6Haup/Z3pYc2sdBDw4ugn/GuO2FV+A0ik/WQybRmLfaRRwX9Q76VAMQz71YCUanptkZ+P6NBEyskIs1Hq/snE71xnuqHXdnnqobIlMnhgJYe9kiDejIJGh+sk/DsKTfP7YK+0q2fp1WxvPswZcS1BVh/pUf8ujpEkQdFn4xzf9SyGAgNVv5CXzozWDzoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yADr01S5xQaAFk1ggEDMJTYviRfD8v09OnkO1KWBxlE=;
 b=a48Soxp3RDds9O12I8fbnkBjPYJFTlHolyLvgqOnydSnhcQSbAZWl5ZwSFvKHTu//1d/jdgbCLl3qxCCBIyFq9ww6HYFFuhD8vtQykhQ+w3oee1r3oZguH7/JujyYJPMx2+fMze9DWpdbRxtH2tBhNbeiQ63tlQt6/QC40wFyQlo71s6rKB22BM0rChtXLiMEXARURAbvFw7d7ltTNmEulr4CE8sV20OrsFTn9rXO0M/BRWG/T+Rbr2Voju/tbXLhY/3HgA0ODxiZ7cqPmM2Q4N4NVVO1QeHLd2y0LTMKe58OtX5QV6kA4IfJ8pMV5Ny9esTDYlflMyFOkV54jWa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yADr01S5xQaAFk1ggEDMJTYviRfD8v09OnkO1KWBxlE=;
 b=ldujfBt18Kn5xaDrwO2y2smSblwLuDEEe/yqxn8kOiJFaxHYMAjWCof+QKU1HcxsMBxkNSodb/ynyBFSKcLhlpWFJi+6pPr9ikzNTstbw0/mq1BFWAL5uJdNgG8S9HH9w8dPG2lYuZWPjSyO2PVIzPqsVo/rDn1tdN7dcdYfc1lRgeLt9PPexOjiuAhCLVZMDdGB2b8kbhwFe1xLwNvtqdVpW7U/JduIgL5pemeDY/1nOStpDprfbwlzlcCqahm7ag2SfXDRdrRig8StD7lKbhWDConNWyH7k/HaQnqY+YKROyNcYa/TdN1fSyzYVDdFzwVNYq8dhLA6fJmvXQaJaw==
Received: from BN8PR15CA0036.namprd15.prod.outlook.com (2603:10b6:408:c0::49)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 16:10:52 +0000
Received: from BN8NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::c6) by BN8PR15CA0036.outlook.office365.com
 (2603:10b6:408:c0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 16:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT070.mail.protection.outlook.com (10.13.177.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 16:10:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 08:10:39 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 08:10:39 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 08:10:38 -0800
Date:   Thu, 9 Feb 2023 08:10:36 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC:     Yi Liu <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 00/17] Add Intel VT-d nested translation
Message-ID: <Y+Ua/KKu9/YuywyN@Asurada-Nvidia>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <0bea6077f0634587b744ec2b421205e1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0bea6077f0634587b744ec2b421205e1@huawei.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT070:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 906d2e46-bd83-40d2-1427-08db0ab83790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AvUG+GlZbaaqhuWzqiG90uK1UQzY9gvC4+FgeOWjXzctJZZq0Bwu1HOfnMZrn/HmzASV8MO1Ld5VoPYMhigGoEYjrl/Ae63Ih4kJZRjOUNeCbp+4g/8k+eqKKX0HvzhTmRNI+kC6FyfJeqQfKRPqpCvuimcVwi06+U62+ZK3V1Xa4iXEqJoNLMU0H3JsHONv9Ip00/PAPcXaTgCUmE70R+39D97vIhdYZf/ya1JpB4pXhlU39n3tcKJ9BHPYDDoSk9XLyyu26RXjtrg8p+N+ZfBLtBjpYttuDorT7DvyRS114V8zjR+DD81Yh2E5Uxsg7QMrpJPTf7/YJtIDgKidUs1y7hP4ddtrtyMPQ+iP80NoL3+4Hzr+8sFncBwh2umgHj4iB8WnhMLDEi3l4VuT/sQgE5LLWRzkg7AOlyWGtdQCmaV+cNrvaZSJSWGYRbA2O6I66JlmCMJvKojiRt6zchUjbesOVQZLDlLFhNTfbRTv1FTMO4LFQEQ2BkB7npRo+qqN6tuCb/MixADAV8NBv9Bn6brHHpgsLLFM8u0KRksSnhcnVeaRCgw2WkYNF/NCDYx2/51cdh197sOFDYWPTYe67HQkkOnQm0l5OWy1qEeGuxdAFCQVaeF6+/ljRfDNEK/dZuwuyfa1AeMJS36yQbtLt17oklWPpUxo6VO9Bb5u7U4T4vfWtgI9KHRR1ZhiNQmWvm+jrq1oXw2fl7rrH199sS1XGxgW4aR4BdK9YH+jUH8QpHmrvJnkgFidHyWxS0vr8Ao3QQARpzeaZ2rTFgX4E4/8i0+F79aHKveEKQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(82740400003)(86362001)(966005)(55016003)(8676002)(41300700001)(6916009)(40480700001)(4326008)(33716001)(336012)(70206006)(47076005)(70586007)(82310400005)(426003)(478600001)(2906002)(7416002)(316002)(8936002)(40460700003)(9686003)(26005)(186003)(7636003)(54906003)(36860700001)(356005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 16:10:52.3475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906d2e46-bd83-40d2-1427-08db0ab83790
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shameer,

On Thu, Feb 09, 2023 at 10:11:42AM +0000, Shameerali Kolothum Thodi wrote:

> > This series first introduces new iommu op for allocating domains for
> > iommufd,
> > and op for syncing iotlb for first stage page table modifications, and then
> > add the implementation of the new ops in intel-iommu driver. After this
> > preparation, adds kernel-managed and user-managed hw_pagetable
> > allocation for
> > userspace. Last, add self-test for the new ioctls.
> >
> > This series is based on "[PATCH 0/6] iommufd: Add iommu capability
> > reporting"[1]
> > and Nicolin's "[PATCH v2 00/10] Add IO page table replacement support"[2].
> > Complete
> > code can be found in[3]. Draft Qemu code can be found in[4].
> >
> > Basic test done with DSA device on VT-d. Where the guest has a vIOMMU
> > built
> > with nested translation.

> Thanks for sending this out. Will go through this one. As I informed before we keep
> an internal branch based on your work and rebase few patches to get the ARM
> SMMUv3 nesting support. The recent one is based on your "iommufd-v6.2-rc4-nesting"
> branch and is here,
> 
> https://github.com/hisilicon/kernel-dev/commits/iommufd-v6.2-rc4-nesting-arm
> 
> Just wondering any chance the latest "Add SMMUv3 nesting support" series will
> be send out soon? Please let me know if you need any help with that.

I had an initial discussion with Robin/Jason regarding the SMMUv3
nesting series, and I received quite a few inputs so I'd need to
finish reworking before sending out -- hopefully we can see them
in the maillist in the following weeks.

Thanks
Nic

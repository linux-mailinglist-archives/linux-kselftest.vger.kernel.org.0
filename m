Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1426BC5BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 06:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCPFjP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 01:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCPFjO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 01:39:14 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6F15941B;
        Wed, 15 Mar 2023 22:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUw7WsFn4Fvmmk2PJUvL1A8nNjQz8G27JUl4dYBqC9DC88SwUs0pj4ImMceH5SXHc2q9Qe2KAIEkLHwtp4/kY8drJfhzqnYC5TB6YCdceG+tsLvjfyI45llugetq7fWz+lABZDFsBunTjtcagj+ZFovyuh9bEeLl8aktrAYPkLaiwlQ3TCueZG10tv72jEvl+SgvU/JHnBaN8pMBf5jvprOIakR7QpJGdoYAqhQvMdHue0+3D+pv9Lq3RYpG6M85126bZaIYaNzazjrtcB5LmrqHRmKGBPCn9WulIwuBUAUB/aJDnSvQ5sJgCjkPtpfkBOvXC4oPb1YeIYxzA1JZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPVyLdym2nbtLnalNUEeWN7wSTrF802cUPbot7Or9XI=;
 b=H5QCXJ2KX4aLQDIzkejpv3aWcaZxH6glQHM1GAHtmVbmcwZTGHOO2gJQzItN40h7pInGVUBpkvOqvLsOPltEeuHaeT64USjDG4PQjebNW35vaaNXn7GA7OLgijeR+eoGYpwPTaMbVFHr8bJIxoVY7DrkSeTupBGz2+xSaZqFYvO8vFN12V/lf7Xv6YFMnDhZXcnACg0/E5quNg5PibyxEtXKJKFruu+oTtJfBCiKZOoHblDwbGZVl4Fjspq5cJfDVKiDnrzDj4s4fu+F/h4EjFJp8l13r+MXCCfArTLSsWyO4Aoa42A4TtzLmXaAVP90xGJDNgcMQQFsZypvEH+CdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPVyLdym2nbtLnalNUEeWN7wSTrF802cUPbot7Or9XI=;
 b=EgoREAZcp99nQ8zahiGv3IUYpxTB90OD9Sblnve/e0SZtyO2tRRNAjVIHxv1KWDWnQBFQO1MJfPmieXfKIuh3mgc9Q3sE9kReVTJD4wPeDvSvX+uJ2i73ECkb2RvyVMiZZXVL5S1/xzthFgP9VtepKBeQPc8ingjeHi08ZZgsLLrWzCxgaMbbuIMM1ufIPepTkNvvTNBtCtjVvWR3ncMtXr4ojivSuhzOQTKlhKFFrToorLiRt9du1YvOQ0I96yCPhuhyd2YrJdcz3Jw43/RbvkV8qwZcYf9fGKwWjMCczJ8dTuPmmkdKlk1lLeSygxxRS+SQYZIhNumf3t6onQfGQ==
Received: from BN9PR03CA0854.namprd03.prod.outlook.com (2603:10b6:408:13d::19)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 05:39:06 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::6d) by BN9PR03CA0854.outlook.office365.com
 (2603:10b6:408:13d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Thu, 16 Mar 2023 05:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.18 via Frontend Transport; Thu, 16 Mar 2023 05:39:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 15 Mar 2023
 22:38:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 15 Mar 2023 22:38:56 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 15 Mar 2023 22:38:55 -0700
Date:   Wed, 15 Mar 2023 22:38:54 -0700
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
Message-ID: <ZBKrboUWBsmmbP6Q@Asurada-Nvidia>
References: <cover.1678284812.git.nicolinc@nvidia.com>
 <08a875b83daf7047c3cc67ed0da23045b6dc6fb9.1678284812.git.nicolinc@nvidia.com>
 <ZAuP5ewmDwql8Pn5@nvidia.com>
 <ZAvGGc5Jt0uSkN8M@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAvGGc5Jt0uSkN8M@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a03d597-316a-49c8-a930-08db25e0c21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vwiR7o3+O8ixMwkBkaksc+wB0JIwWi8eH8UWnh8v2QmdCdj7LstSl6jPvluvTb9Qz7foHwKAq1fL5gcmwh+YZeNRjwS1Wkd5KqjYR3/KuSiWOZiEXy8X1qNkaOK6tp1//+y9Du2w+8jCW1dEOU9TpyDp+8SkNA54jICJGC3AI8l6EfCeu4kCtnmLBY/Wzq0WmNi7oNprQPyNqOC57Sd6U4b/DZDR3b4CM5V1IEAr7S11ael7iv7WHPuqrBDyID5BSyYgY/+f49EIFLx0kyI6x0Cn2vcgz/DekQVGFRPSTfTwcSdWgMmtlSdn1LDWKcSJjC0MUTyMTrevf/6T78kWmqiLdf30Q3lf7MGzZxSrnjHXMTOIrlqSuHneRZ/u9OFOIu6am2HK9oggTlCe3wzBCIoptiNVls3qPm+/R60A8tMr+C9FNKiri47kc2QsAKVLlL30E/0Dky8TSq7kpcHb+t3W++OUqjzwcdUFdgaTJlfS4uhb5PqRQb462alhyqmoB90gRdB09xMIqpDOkLiz8drDzp4kVNdyZfdS36UGx7eYwOIkEq9kQNqwTG7lHQ4WQ9JW1oQzn5AtKeDerx11Y+gW28c9zV7uJ1hJ4Am0LJDt4xPjavIp0NfJ6y+yU7pww/bxN/OLnhN2gnOBeOxf51YvbYwIT8rddlGLWPtK8wC0zMelMx8oonVZuagIwwC4xTCRS/bH1KUDyM9/xJUUE18lWbGtf5J7Av7F6J9/6OS0rd5wmLqReeIFXWA8ELYl
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(40470700004)(46966006)(36840700001)(8936002)(186003)(6862004)(336012)(7416002)(5660300002)(316002)(26005)(9686003)(47076005)(426003)(40460700003)(41300700001)(83380400001)(8676002)(4326008)(33716001)(70206006)(70586007)(36860700001)(356005)(40480700001)(86362001)(7636003)(82740400003)(55016003)(82310400005)(478600001)(6636002)(54906003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 05:39:06.0364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a03d597-316a-49c8-a930-08db25e0c21b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 04:06:52PM -0800, Nicolin Chen wrote:
> On Fri, Mar 10, 2023 at 04:15:33PM -0400, Jason Gunthorpe wrote:
> > On Wed, Mar 08, 2023 at 06:25:59AM -0800, Nicolin Chen wrote:
> > > Add a new IOMMU_TEST_OP_ACCESS_SET_IOAS to allow setting access->ioas
> > > individually, corresponding to the iommufd_access_set_ioas() helper.
> > > 
> > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  drivers/iommu/iommufd/iommufd_test.h          |  4 +++
> > >  drivers/iommu/iommufd/selftest.c              | 26 +++++++++++++++----
> > >  tools/testing/selftests/iommu/iommufd_utils.h | 22 ++++++++++++++--
> > >  3 files changed, 45 insertions(+), 7 deletions(-)
> > 
> > I'd prefer we keep it so that the IOAS can be setup with an argument,
> > this will greatly help syzkaller
> > 
> > Lets have it so a 0 ioas will avoid the setup so the second call can
> > happen
> 
> I assume that you mean the iommufd_access_set_ioas() call and
> the "unsigned int ioas_id" input of iommufd_test_create_access?

I changed it to keep the id in iommufd_test_create_access().
Instead, I renamed the IOMMU_TEST_OP_ACCESS_SET_IOAS ioctl to
IOMMU_TEST_OP_ACCESS_REPLACE_IOAS. So an access can be created
by the original ioctl, and then be replaced using the new one.

Thanks
Nic

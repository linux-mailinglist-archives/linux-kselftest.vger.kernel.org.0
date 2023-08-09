Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB27A7769B1
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 22:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjHIURl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 16:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjHIURk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 16:17:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C2D10E0;
        Wed,  9 Aug 2023 13:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1oTADConSP7u0VophglkS5vI9ZIoahoKhPVgFCdJjSfl1TDOqjLecCkVOUH3s2hudku5HMjhUPAv+qCwvllCK/tLYreSRBN2M55JRmmycMxQk+A3TmXEAa6JZdbOzbd6iyAOpsoQmBna1RPeGrxVsyKXP06OwfwVOhJHsd+Y2qTDiKSg+v/uMOhbX/zGOSzhrnlJMj5Dlh5PwugGyylZ9dNqS3VmpH0T+kMYPwREZS3MwVNUHFXrMDGh1B/HfFPCfPz7+1jvQ5ojLQodMF0L0D/LTOMI3TT5J5xLa3PNs7mHU/UDFaDsqTB4jDe1z3yEbY87LWNwUZUhaksWuePFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlCYQChAvXf7fx9Nm+whY758+Mq3ScDSCudxnXKTic8=;
 b=e39tSW3zF/riJdDiAe3VL80PANpAnUzdGJ/YXlhbRALznk756DNz4APf1/G/2uDOceUz/j1w4g8vnFGkFeA0hmVkkvxK9mdhEjxzp6fAzir6YfQ43JOY8m1J4PsmpK4FjO/VZXGBIIi6Lg+ddNLWoQiIotUtAnuS8kYjdQbJ1VSCpGXFU2eUS7Cc8J0FTth4nK4fPwSkh981qvUbwzrjMqPCY2iW3uyYN3UgBdzGG9nLEuxLRPrlmPPZvh/ciwZmfi3+AuenD4kT/QDn8myPC5eq584V/+SOC5zsGQy6K4riRXaBcykqFzIJIWVBNvWqTFA22w31UeRHW7tDQq7RFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlCYQChAvXf7fx9Nm+whY758+Mq3ScDSCudxnXKTic8=;
 b=MGUdcQhU+uIX0RSqeKn+lED3BZ8RzJIrSDK/HIBVS24J9z3DXeeycsF4hLwlLC0IgOJMSojlvQNqjjuBTxS3WnlpodONRxJtQYNrdoV3TQjN7lVw0jLiuKsi95aN/IrgBN+iukpaxOZoJnEywuRZW3OAfGeqFzNe3d4w3MrcSG1iHwlb60VXT3kwhj7+u/uM5RLO7vW21fpezUKp6YOJflXv14CjybawwcXkBpDr8cIDnHkDUVVaibnXJPoobSskkjq1Q/OvAwOlsXIuHLIXU0191L+MjAgn5FyTVIwPcYgY/e7fci+ejGAu366KaalxkBk7uCzC7wTkrmrOvf6vMQ==
Received: from CH2PR19CA0016.namprd19.prod.outlook.com (2603:10b6:610:4d::26)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 20:17:35 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:610:4d:cafe::1d) by CH2PR19CA0016.outlook.office365.com
 (2603:10b6:610:4d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 20:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Wed, 9 Aug 2023 20:17:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 13:17:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 9 Aug 2023 13:17:23 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 9 Aug 2023 13:17:21 -0700
Date:   Wed, 9 Aug 2023 13:17:20 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
References: <ZNGypUee/U9d68TZ@Asurada-Nvidia>
 <ZNI2O4Upyna5AWDA@nvidia.com>
 <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
 <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNO92PIx2IQ70+DY@nvidia.com>
 <ZNPlGd4/72dahSs4@Asurada-Nvidia>
 <ZNPmpW3/zDnjqxyU@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNPmpW3/zDnjqxyU@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: b28071c9-2080-4cda-fa13-08db9915aaf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IH/RbC8a6KnsNsdCQ0JzwcNXte7QKfiv23Zb761TJtsMefYpmdn2pIP94btSv/7JEr2WKMXbirhDpqHe+O51u8ZMIc7n1gcBUWpvkwxpINbhv55TzZ6fcHWfr4X7nNet8hAdKLgKKpmneMjAzQ4tqiRoyI+wlQKB0tBCueBEfocQBBWuarR5rBHXB1+Rr4qTe0hFJDw7FFqLsimfwPo5YTdRHxFp7QvelNayJ8DuZphiyL7kekIRsnxfuFhN0ljx5yIOAmA0I+ybw3LH5ajBGMkbFNjVGxrhXem3f+gsF1YsFCH6Ccwqxs/e0+3uLqfnqr1nEKeTkQ3b4fAN5rtgNTx/u6u8Iq15rcL8ZzHtPMZQCKvBIkU+T1rXMe7tqJITIq9E9WWrW8n5QHH8TTx0jAC2mLO9S5dvQo7doykorSC4+Izro1h1iS4kvw5CRKEKHT336ms4LBNAvu2jrNOqmMlA+AqKbCKqUTAf6ZKdjnnRUT8kzyJjNxQLxpT+EyBCzG0kWa5ruJiLVXSriS7Wk7dErgjkq3k3uRqXugun3JXsTf//q5k2Qs3yjc4nMDbatZCmqzI9wai9XOzy2DDazVUd9WnY4irEV+TVUpTBhWKdC4QLXlUqF2FaGuEikMo0383ZXj6TzMNogqtT8jLKn+LjmjqkQex8oTn+HYYYtnlw0ZXnmEukQEvMxGWrsJ9K/wGsnouvAUfWeymiZk3Qe4444ZibSU1PTpMVnT8BAL0aF1cs9S6CZ0oL0eIUMONOT612iWli8zXxKEYsa3E97s+VhDbBtbxX1EHmg2kpTk=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(186006)(451199021)(82310400008)(1800799006)(36840700001)(46966006)(40470700004)(9686003)(36860700001)(966005)(40480700001)(40460700003)(83380400001)(55016003)(54906003)(7636003)(82740400003)(478600001)(110136005)(86362001)(33716001)(426003)(47076005)(7416002)(316002)(4326008)(6636002)(8676002)(26005)(336012)(5660300002)(2906002)(356005)(41300700001)(70586007)(70206006)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 20:17:34.4148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28071c9-2080-4cda-fa13-08db9915aaf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 09, 2023 at 04:19:01PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 09, 2023 at 12:12:25PM -0700, Nicolin Chen wrote:
> > On Wed, Aug 09, 2023 at 01:24:56PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 09, 2023 at 09:30:12AM +0000, Liu, Yi L wrote:
> > > 
> > > > Yeah, adding new structures to ucmd_buffer may increase the size as
> > > > well if the new one is larger. While for an array, if there is new entry,
> > > > it is for sure to increase the size. I remember there is one tricky thing
> > > > when handling the selftest type. E.g. it is defined as 0xbadbeef, if using
> > > > it to index array, it would expire. So we have some special handling on
> > > > it. If defining the things in iommu_ops, it is simpler. Selftest may be
> > > > not so critical to determining the direction though.
> > > 
> > > Maybe we are trying too hard to make it "easy" on the driver.
> > > 
> > > Can't we just have the driver invoke some:
> > > 
> > > driver_iommufd_invalidate_op(??? *opaque)
> > > {
> > > 	struct driver_base_struct args;
> > > 
> > >         rc = iommufd_get_args(opaque, &args, sizeof(args),
> > > 	     offsetof(args, last));
> > 
> > OK. So, IIUIC, the opaque should be:
> > 
> > struct iommu_user_data {
> > 	void __user *data_uptr;
> > 	size_t data_len;
> > }user_data;
> > 
> > And core does basic sanity of data_uptr != NULL and data_len !=0
> > before passing this to driver, and then do a full sanity during
> > the iommufd_get_args (or iommufd_get_user_data?) call.
> 
> Don't even need to check datA_uptr and data_len, the helper should
> check the size and null is caught by copy from user

I see. I was worried about the alloc path since its data input is
optional upon IOMMU_DOMAIN_UNMANAGED. But this helper should work
for that also.

In that case, we might not even need to define the union with all
structures, in iommu.h.

> > > Similarly for managing the array of invalidation commands.
> > 
> > You mean an embedded uptr inside a driver user data struct right?
> > Sure, that should go through the new helper too.
> 
> If we are committed that all drivers have to process an array then put
> the array in the top level struct and pass it in the same user_data
> struct and use another helper to allow the driver to iterate through
> it.

I see. Both VTD and SMMU pass uptr to the arrays of invalidation
commands/requests. The only difference is that SMMU's array is a
ring buffer other than a plain one indexing from the beginning.
But the helper could take two index inputs, which should work for
VTD case too. If another IOMMU driver only supports one request,
rather than a array of requests, we can treat that as a single-
entry array.

Then, the driver-specific data structure will be the array entry
level only.

@Yi,
This seems to be a bigger rework than the top level struct. Along
with Jason's request for fail_nth below, we'd need to bisect the
workload between us, or can just continue each other's daily work.
Let me know which one you prefer.
https://lore.kernel.org/linux-iommu/ZNPCtPTcHvITt6fk@nvidia.com/

Thanks!
Nic

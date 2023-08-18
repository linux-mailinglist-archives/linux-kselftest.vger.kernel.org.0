Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A45781270
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 19:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379214AbjHRR5O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 13:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379372AbjHRR5J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 13:57:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F91271B;
        Fri, 18 Aug 2023 10:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCygJMUNBluVlLtvfhGV78o/RqsAcUtOE/C1Q20SiBVXJssNCq+YH2V3ae3OUJuYwvvl6WWIscToAVg6QCoh9J5vhoAFlNpTM6h0KY9WYudSeVxxwRSdinKYwtoPtnLG6ZfMQjvb9K02UTfEHl9ctteL5VgkH6BWDv0DmZwoeO5FYV6X+GaTYsaUoBQno4/KtHZSfe4bMERBw9fAutPMBL/UOIqce+3bOIELZdLwn0uCN9jF82QhTctJrpqteC8krqujCOk2IDgFIXq4estdF/zA8Q4luvxnkpdoe70BMUecq0L6BRzbApw1RJPFw0APLs0oGC2GU8solekMGtBeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K/c8Erp/IMlMSdc/V2CbjzOmFyMBlggSOYhu6tscRw=;
 b=d7ACt4eM4QXhX2MCCmvLX6OykkwrYapKkVpRkgvnt+blCYnQi9AoEhF3aTwT/Tbn60pE/gouEApFJibhoEOKIFcQM7iB53CYuf8NKfuMeBuHq2CKV2TUjyDG45n2/Il/92kjavfPLfn9yfVq8RnEBDcbKZ9f0E+ndIkBgsPdJr1Q8P/0bJKAzBNuLZ2EAI7z0lqia7eyQLIQFBC3uD6knWZY68UUkb/il3PPs3gwZoNxbxFJm0O6QTN3swCRl9EsBPFXi+ZoCm18IB0H3SB4Q1EZMCqrAvZEALKbKNiU5ROUoQkHBS0JSdyvh7kLiDoxEjoA4GGF4/t3aJS8JwLbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K/c8Erp/IMlMSdc/V2CbjzOmFyMBlggSOYhu6tscRw=;
 b=tW+sJ03/L2zFLXl5h+hNc57iaJmmur4k2W8YB6nNN3QG5107wVnvpGOH3WBIJZLTKX3BBwx0cxTdICVKMbBVCzvEZ8T+Rz88BvjJPwYj8BfpbXyJdjxXQiYXHnkjsCrG9dfdSAVHgnf2XZGXo67QqenBS1hW0IF91jKFDFoam1wU/wMXZhrlvkKWaAAp7bMs4NrYOEO8rlAartyty+Wjb7KaUHs11dU6yj7F7P2uJAm12GOxjS/6DRo3hmMcv+gF0RbQSXiX5OsUHOwpgVlOTMhsQRzztMim0lpMSxjyW/Auof4+Sovl/djnjHeWYPvB1scQRVGiolSKK6DAjm9kyw==
Received: from MW4PR03CA0135.namprd03.prod.outlook.com (2603:10b6:303:8c::20)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 17:57:05 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::6f) by MW4PR03CA0135.outlook.office365.com
 (2603:10b6:303:8c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 17:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 17:57:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 10:56:48 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 18 Aug
 2023 10:56:48 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 10:56:47 -0700
Date:   Fri, 18 Aug 2023 10:56:45 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <ZN+w3fahQpM2W9Yx@Asurada-Nvidia>
References: <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
 <BN9PR11MB527683351B687B97AB84B51B8C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNUI0D7ZMvLWlBNx@nvidia.com>
 <ZNUa/VmeiIo0YA0v@Asurada-Nvidia>
 <ZNU6BnTgNEWlwNYQ@nvidia.com>
 <ZNVQcmYp27ap7h30@Asurada-Nvidia>
 <BN9PR11MB5276D0B3E0106C73C498B8018C10A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNZlnh+/Q5Vk5Kul@Asurada-Nvidia>
 <ZNsYxta9Pi7USDoR@Asurada-Nvidia>
 <ZN+i1pEoN/NsWPKS@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZN+i1pEoN/NsWPKS@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f330e1-22f8-4b0a-97fd-08dba0148867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQ6TUWS4HL0pdHQ0EmlZMc9K7nA5FOd87A1Dd2ndKxLBvO5gu6rJR7o0Nzce1C+NQ0XGLtxQ/SJqyRUK4126Ns+vt1kpIBwFiSS+fzgcMc20c2JnoGi5V8LMk0cO7WkWxlNKodtPGqoroV//rUMGIld+N888SWuk+6wuIa4XB7bSc+3ptbOhsTvN9DRwk2c+oXs40DpkUwT6d/pfChK7yycYCtrRIn4aRlBpsgKvaz2Mz/j6COg6Axxcs4jUdwH/pYkFxoZ8bZ4WC+kY+vF+jjVHiNWIwBvcuarVrvd/r/1Poy3nFNQmw+p59D6gE8+TZbz5k315VGowV5L82mJP/g72mOrgNz4e2CaZ6boDotT9cYudgJOd56xUyyjX3V4D6wWWnjuLAokFhAz+5y8mpGhJqlYeF3rmdXbThSsUEfC+RwOaU1qPmV8eBRXQWWB2nzakHik02n0sVJdCzpEI/jC+9hPfCmjDwhnSMe+0AeYe9T+pQuEwGRMnW+Y9tTBSJCBRhshqmzYu9AMdlFpW0GpTaaVUb1DWxPL/3u0qUqloQp6zFVgqQEnrAfOptPqM26BdO9IKe+0CzMBNJwCQ4r5XbYEy7nHO2k4scFUROSDmEyIheRDhhvIl7R+BxLo4IR+y2qtJtxr25tigfZ4pWji+ABGTa9baAgE0d16OswnJfYd4OqEcTY104WWtnumy7kpVX52HSU/3FgCnH/HZe9eZAeG6rOlZNFobHBXFbEdsKiChFHQGM0SBCWo/Lch8QTrq5HBEjN4hVl/Wx+oFHP+ZgdblyGLcV9vhN9jgwCO7WLJeQPQVGT0anBEpG1+/
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(9686003)(40460700003)(36860700001)(426003)(336012)(55016003)(26005)(40480700001)(83380400001)(47076005)(33716001)(7636003)(82740400003)(356005)(86362001)(2906002)(54906003)(316002)(6636002)(41300700001)(70206006)(70586007)(5660300002)(7416002)(8676002)(6862004)(4326008)(8936002)(478600001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 17:57:04.9775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f330e1-22f8-4b0a-97fd-08dba0148867
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 18, 2023 at 01:56:54PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 14, 2023 at 11:18:46PM -0700, Nicolin Chen wrote:
> > On Fri, Aug 11, 2023 at 09:45:21AM -0700, Nicolin Chen wrote:
> > 
> > > > But if stepping back a bit supporting an array-based non-native format
> > > > could simplify the uAPI design and allows code sharing for array among
> > > > vendor drivers. You can still keep the entry as native format then the
> > > > only difference with future in-kernel fast path is just on walking an array
> > > > vs. walking a ring. And VMM doesn't need to expose non-invalidate
> > > > cmds to the kernel and then be skipped.
> > > 
> > > Ah, so we might still design the uAPI to be ring based at this
> > > moment, yet don't support a case CONS > 0 to leave that to an
> > > upgrade in the future.
> > > 
> > > I will try estimating a bit how complicated to implement the
> > > ring, to see if we could just start with that. Otherwise, will
> > > just start with an array.
> > 
> > I drafted a uAPI structure for a ring-based SW queue. While I am
> > trying an implementation, I'd like to collect some comments at the
> > structure, to see if it overall makes sense.
> 
> I don't think a ring makes alot of sense at this point. The only thing
> it optimizes is a system call if the kernel needs to wrap around the
> tail of the ring. It would possibly be better to have a small gather
> list than try to describe the ring logic..
> 
> Further, the VMM already has to process it, so the vmm already knows
> what ops are going to kernel are not. The VMM can just organize them
> in a linear list in one way or another. We need to copy and read this
> stuff in the VMM anyhow to protect against a hostile VM.

OK. Then an linear array it is.

> > One thing that I couldn't add to this common structure for SMMU
> > is the hardware error code, which should be encoded in the higher
> > bits of the consumer index register, following the SMMU spec:
> >     ERR, bits [30:24] Error reason code.
> >     - When a command execution error is detected, ERR is set to a
> >       reason code and then the SMMU_GERROR.CMDQ_ERR global error
> >       becomes active.
> >     - The value in this field is UNKNOWN when the CMDQ_ERR global
> >       error is not active. This field resets to an UNKNOWN value.
> 
> The invalidate ioctl should fail in some deterministic way and report
> back the error code and the highest array index that maybe could have
> triggered it.

Yea. Having an error code in the highest bits of array_index,
"array_index != array_max" could be the deterministic way to
indicate a failure. And a kernel errno could be returned also
to the invalidate ioctl.

> The highest array index sounds generic, the error code maybe is too

We could do in its and report the error code in its raw form:
	__u32 out_array_index;
	/* number of bits used to report error code in the returned array_index */
	__u32 out_array_index_error_code_bits;
Or just:
	__u32 out_array_index;
	__u32 out_error_code;

Do we have to define a list of generic error code?

Thanks!
Nic

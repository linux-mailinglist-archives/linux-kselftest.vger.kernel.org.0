Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A337777EE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 19:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjHJROx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 13:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjHJROw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 13:14:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D1C26A9;
        Thu, 10 Aug 2023 10:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty0Cy7bwu6EDuCtwqH/w4q9aX2rPM9N6HJiflY3SKo6dOpSNYM0oasDn4uCG1sltxQE52UGjI+muxeDr3ri4tjXEVGDGwCbebf/wU9E2IUFu5hLM9Zue6ZO7QuYGgY+vGaChru+lkqhzeNtBO9lNdvKl25WqHS5XoF+TfMwyJgc+4sEjmI3d07BbELLo2NJyrUMdSgvkM0xPemNTRYBhiXj7J0g1PcurJFYBAF3egePnyHX8Nun56r1XGqKz7TWQ9Dpk0SFgbLhirgY1dbczjKfW3KxbhbSt3k2L8gZgTFGjWbNBKNGo4tCItLm3ca60xPz75FJt2cl5DWHuLNqeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vgt/Mpcs8ArLfngkU8MD9Z9frW7tGAhbmUOzS59+OLE=;
 b=Uhm+Q3TpwFfjx+hkEx5NoI2IYSiQ4ikvmzGsJORuxDWPg5CpNtnYpGucISa2byNJ7g9/EOl+Pf1QsadF8mGZQIOBnjoczSLOS+soq2NElxjSyOHRGSf+3Rq0AUW7FRLUsMpzMOqEp5llrIKxlmvoVogJqGAUao/tQyBcJJEzz0IUFWA7avQP2zq4gXSz6mH2U7bVosT1Uc9+21/cQxP07cq4lcjxDH9516+fa49vUHuaBTI4EjELTS849HdTqupjh+L9QTu0DyRBK3mKNDXDGN2k0otAxsdrpBZRW1xlpGWQSYUJJTvc4Ax+30Qj1FI/ZqlqldrF0c4hg/x36Opikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vgt/Mpcs8ArLfngkU8MD9Z9frW7tGAhbmUOzS59+OLE=;
 b=XuhngiCuv5DIMGYBQZe15KBKDk/hTKRsenGWuyCn9J9f/TPYW+o1YF/2VQeS2G5mtqGE97o0w3utWhNPmspq/c6E4vGcmPrN/RwWA1ztOrnCW3g4VIEyw4EnFdOrmzQj+JGR19f42KBG/66p4Il7zhHV9HxDJ/Nejoft9a3pA8+wFpGmT3+MiRQcs98lQmtoF75A8aw2lKNSE3uVXnTGdqdv34jHr3+akaMbph5t+/ccrJhyCYjQW4XsYhJ1A4h57EVPiWRz7CjLF1apO3eKupesCTTdMDaLZH6eCyXk2TA3gmpVIVPkRfbfcpQWzFLV+O156hGrewqemu56yJDKnw==
Received: from MW4PR03CA0048.namprd03.prod.outlook.com (2603:10b6:303:8e::23)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 17:14:49 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::1d) by MW4PR03CA0048.outlook.office365.com
 (2603:10b6:303:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 17:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.0 via Frontend Transport; Thu, 10 Aug 2023 17:14:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 10 Aug 2023
 10:14:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 10 Aug 2023 10:14:39 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 10 Aug 2023 10:14:38 -0700
Date:   Thu, 10 Aug 2023 10:14:37 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
Message-ID: <ZNUa/VmeiIo0YA0v@Asurada-Nvidia>
References: <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNO92PIx2IQ70+DY@nvidia.com>
 <ZNPlGd4/72dahSs4@Asurada-Nvidia>
 <ZNPmpW3/zDnjqxyU@nvidia.com>
 <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
 <BN9PR11MB527683351B687B97AB84B51B8C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNUI0D7ZMvLWlBNx@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNUI0D7ZMvLWlBNx@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: effefcfb-ffe2-4752-0e15-08db99c54d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GYsI/53v8xMfDc4L7h/H0CmH/qXPY0XP0kpaG4r8lUMqEIy0ljq5+pM20nmOHGmMIHXSqLbPtLCqeh0buGZ4fSif6tI4ogyF1MDYbvt2MiGr+NUVIHySAr06CtlSpl4j5L5VBJIQI/L5JAuw/5S33u/MXQAZy7Mvw6IoAnXleCoeLRRbmNXvHYIN1rw2yTKpRl3KQC0lSIzey189ViU97FfvkC4j1c02+WrRzzoC/zJC5bWJCcoYSALQN1SmSxpPswZMok0+k4hfvG3kktRApS45XuXy7YOHjoKO2eLtvpDwAnq6I8CVSlg0uYwgDuVXhnX4UmqzVSV8Hi1xHuRx7j3u8Q0XCnBexyEEVpdNcPOaVQNAkju9JcFOKgQZQ0m/FgAAdouqrCwLsEXIw7MOxFmVi1LdBjpeIEodFTM157vkZHFeSoIoiVx0H5KsQDTuGBLDJWz+xdB54aeeJGrk/co09mL72PMUcJ6D4q5g14cTGXLOJEFnS6TEOMOneIkZGXzqRcAIf2efKAin3cB/BmHWHgtgIP9v6YWCqzVOXvvCtpSObNa8Q2JxufBBIlSqFX96K42o7x+/RjfwojTJNFpQjkqkIYjjx63ycv49XUukq/sYpiltpEpjuXb9FS2otDWgEmZ5zaH8d/yP7cRgNvkpDGFNzcyWz2SboodLEDCwO2gFXoijLtlwDhtuj2hy0j4nIL4z0bcp/sT8rSAODRdcAnwFwj6mJui9wM9J+evsLnuGDUCIWaviFM+h2qe
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(186006)(1800799006)(82310400008)(36840700001)(46966006)(40470700004)(40460700003)(4326008)(6636002)(82740400003)(7416002)(356005)(7636003)(336012)(33716001)(41300700001)(70586007)(36860700001)(70206006)(40480700001)(47076005)(5660300002)(55016003)(426003)(83380400001)(316002)(54906003)(9686003)(8936002)(8676002)(6862004)(86362001)(2906002)(478600001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 17:14:49.1103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: effefcfb-ffe2-4752-0e15-08db99c54d8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 12:57:04PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 10, 2023 at 02:49:59AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Thursday, August 10, 2023 4:17 AM
> > > 
> > > On Wed, Aug 09, 2023 at 04:19:01PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Aug 09, 2023 at 12:12:25PM -0700, Nicolin Chen wrote:
> > > > > On Wed, Aug 09, 2023 at 01:24:56PM -0300, Jason Gunthorpe wrote:
> > > > > > Similarly for managing the array of invalidation commands.
> > > > >
> > > > > You mean an embedded uptr inside a driver user data struct right?
> > > > > Sure, that should go through the new helper too.
> > > >
> > > > If we are committed that all drivers have to process an array then put
> > > > the array in the top level struct and pass it in the same user_data
> > > > struct and use another helper to allow the driver to iterate through
> > > > it.
> > > 
> > > I see. Both VTD and SMMU pass uptr to the arrays of invalidation
> > > commands/requests. The only difference is that SMMU's array is a
> > > ring buffer other than a plain one indexing from the beginning.
> > > But the helper could take two index inputs, which should work for
> > > VTD case too. If another IOMMU driver only supports one request,
> > > rather than a array of requests, we can treat that as a single-
> > > entry array.
> > > 
> > 
> > I like this approach.
> 
> Do we need to worry about the ring wrap around? It is already the case
> that the VMM has to scan the ring and extract the invalidation
> commands, wouldn't it already just linearize them?

I haven't got the chance to send the latest vSMMU series but I
pass down the raw user CMDQ to the host to go through, as it'd
be easier to stall the consumer index movement when a command
in the middle fails.

> Is there a use case for invaliation only SW emulated rings, and do we
> care about optimizing for the wrap around case?

Hmm, why a SW emulated ring?

Yes for the latter question. SMMU kernel driver has something
like Q_WRP and other helpers, so it wasn't difficult to process
the user CMDQ in the same raw form. But it does complicates the
common code if we want to do it there.

Thanks
Nic

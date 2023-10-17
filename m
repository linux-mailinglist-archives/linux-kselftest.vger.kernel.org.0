Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4054D7CC84F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 18:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbjJQQFI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 12:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbjJQQFH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 12:05:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B3ED;
        Tue, 17 Oct 2023 09:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHYtw9HaEVVmSt2T4Agkg527SJtg8x4NbRuXBBvFjAkvfjA8TgQtOf0r/HSsBFFk/csv462preCAi8w3oY8xAnK8kTJ4McnEjMAkAdwVUzZJomo9v02h3qg83dw3bGznYaKADw39aAK3Aulr/I7VtDMtmb/nawrem3Xx5cQcOHaW47igrO+Cq8Ou4qJdxmq99KX5O4ypF60nrsuTX03D8/p9ujlQyD55hEWBj+x7j0s15Hm91vS7Q8ofmqTmpD04nCF4nPbm7/30fHnaqwuORX5jjcB70lFZYJ4ZsRW8Jr+LbOp0pnAfmrInCRhVvKXNMzgwsr0wgSbnktoeVmLQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+MxW805I6s+rvqMchVDFnwcNZSQ3TJML2JfQ0eeaU4=;
 b=W0R44K5JiuuM1y7iyrL+xh9vFqvONZuvStNkiwkEfXWFtYEJsjgCHy4uUA7RJi5hH7M9IEBgpGErEIn+jpIdCAVsYbRFdKxOBSQTzN3hNv6+UaeAWsnxapUcwxncPfx9b4B+bI9Zszvort7rElgrAF+U5OZTWry0h5iQxAz4DBT8USq7O+9r+U8DGhcC3sVym+UxN2pf1qz9JuiYSoEQJitGSJwjKxz4cVMX8/FLWNRxtt+kz++zPfqNtP4lF2Vh8XZvS91kD5M6EqTfpVz+LkQqgdPkhqFzHHSeYKTAxdh1zkZ3LxRjFRNWpnkiQtwq9npQdwkzs+nylydRGL5HOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+MxW805I6s+rvqMchVDFnwcNZSQ3TJML2JfQ0eeaU4=;
 b=fPgo7BpSlW1Rfq0pIvzMA58ysAAkljWFMh5qb4j8CfB8PdegalVFBNrtBSkZ1HOTjUXJDEHLgpMgfXd0ABbid2kutxXKuotOglSve8ymA7okElFGqxUPyvG0dAyFXVidX0QNhMcU6zsHwZPqi+w7r8dyBBsuNa4rarbnyrcvJLjINcrR5Soy6xa04ZWqK2XM+NP3sG1UJ4PptSkNAKwN4TgDNv8+nZUGsoXn8Oh6byBTQ1j6gqZR90FTNiHRPJgKXVde9VtRRuT+6JfTKI+QVmX24K5haUBX7JW5VoY2rPI5l0wDzT9qZLi6AIS3cIUpHxJZfLlDDWfkjjvMg3jDVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4905.namprd12.prod.outlook.com (2603:10b6:610:64::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 16:05:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 16:05:03 +0000
Date:   Tue, 17 Oct 2023 13:05:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
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
        "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 1/6] iommu: Add new iommu op to create domains owned
 by userspace
Message-ID: <20231017160502.GJ3952@nvidia.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-2-yi.l.liu@intel.com>
 <ZSuROTyaxePoVFA+@Asurada-Nvidia>
 <20231016120454.GS3952@nvidia.com>
 <ZS124n0LYj4kl/4c@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS124n0LYj4kl/4c@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:208:32d::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 260b86d6-05b3-482b-3b24-08dbcf2ad287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hw9kZOpJrLcGAgOi3053mvofq91tqzRgmWbKsjXF17yh8LJPwCCkDaLFN/7iaL66ejgaOVfgecG2SxPwoRCoNwJ0TPZGAYQqlUocUyy8y9Rkc1VVbq8cX37rG52sTFAYPrS7NjF9qs7Th2MVpsd9WlWmQxK+GR9O6aBG3BNUSfRhjdr9xzh0CZjfnpP4Ev+0V8KlqAF/zHEX1uIXn31inAw3+k94gXBPdJT5pk3b6RJmQ1Ar/s3fNnwLe0GbbwCxNRFeyllwsYcOofHjuKqXQ4aDe+h1tYg0frpp3JEOg7f0W/a3nmGDXnm2NkSGxCcR2ROz4wXGetjHcpDlAPIN4efPOqDDs99MBOgExQTQV6rIj+h3vkukqt8rImcRbNPmRbV5qSWRkBYxqiTPJfL/Ts3jRjh235tS4hQWEcR3l2U8kHKQOYGI4BQm3eMxSCAElCrkHGGr5TX0jVFdUNLF7cx1XRHW1XTScLCaUgjTmfK27qWwMd5u0QeICCaN1wJGMWDyKk3mGn7Ng3plC9uaIP8CDMvdIbmi3sZ2gpM5IVx21Sy4u+3v6tM4IULtAHuC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6486002)(478600001)(6506007)(6512007)(36756003)(33656002)(86362001)(1076003)(38100700002)(26005)(83380400001)(2616005)(316002)(5660300002)(54906003)(37006003)(66476007)(6636002)(66946007)(41300700001)(66556008)(8936002)(8676002)(6862004)(4326008)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NJEdPFrYxr8OULgTqdzjj8iO9TZte1LCtRgeVkuzQ2aPdCB3qNkL0wUk707W?=
 =?us-ascii?Q?1xD8dG8gdng0vhbqCcglCPwnh6NtwnwJ2o7RtL3Y90i6WZjxE9b6U578erIy?=
 =?us-ascii?Q?HxKSWxyOxJ++AdcuMEJwKHlETnOjAbPqA8R3rvry7j6/lz9mWNH23YehGqOo?=
 =?us-ascii?Q?qpPO0edbNTFu8p+G6xv68yjmJFWoZSRYeyI4Jl5pswiBnMRaulZQYASEvX/T?=
 =?us-ascii?Q?AP/08qUYUjci8eceX/RY6Jl9hjcQE0/e2eKBEkU0NA6sXcDLnivc0dIsrDrt?=
 =?us-ascii?Q?Zgm3kJD4rFMHRXw8DXU3do6oNFKvDBBnOKS1Cgl+VCzfe0HyvlAIFoknwEJt?=
 =?us-ascii?Q?ZvOWXKo6jQEQ9/9wpAlFnq7yvIg3spHrV9/vV2mGRyPopsYEAez8njNjAZhM?=
 =?us-ascii?Q?F9Jn3CQ7z36Qw4K7vxb8UqVdn+hdp16NwnmxFRnk61LAA/MlzGwLhZgLjXSt?=
 =?us-ascii?Q?89ZpziX/IKeAu0yxbuupc0wEdw1FR4L5PxahbiNfCGTIHOuUZ9S6MhJa2hss?=
 =?us-ascii?Q?mIPIxC4ntrT7mqkc9E2dtHFPOAK/QTRXR7uf5gqW/o9yB7rmZtGaIrBv07Ok?=
 =?us-ascii?Q?jqnS5Eldy+SsmrkLA2hcQyzdLtZXZ53KpWJA+PlQnZY/99Z+spveZ0y1zXx9?=
 =?us-ascii?Q?1W8Oxa/6Dn8epjZX6bJHe2ke6D/MZUCdxAtiBGCUTRRGM8AFj+9xUoSbm3g4?=
 =?us-ascii?Q?VPPIMMkJSA2/RCW3OsIGU7X+Kb9DjcGzMvLsFDtMDA69W5BjJlwhyCHvrLPP?=
 =?us-ascii?Q?CkloSunhp4G4iR7kXDxvKpWhS5AlPKSO+feW5xiCZSYvaIt6yZxElU0PGdS9?=
 =?us-ascii?Q?EGacM22Y9flE+4P1V0GADS8Fz77X1Eyvr81tJTVZ52cEtuNWw2aO3+J7A4Ly?=
 =?us-ascii?Q?T/cPn5JYRqfeo1myV9Z7fhrke3c99H7f9AKxo/Xmm+1ykZCSu76Zhnbqwq5U?=
 =?us-ascii?Q?t8Nd8SQ8aOuwA45nIoUiPrvxzveNxOe3hT4L6wD9KSX6M+DGXc/W46am8sfl?=
 =?us-ascii?Q?nhNipwLlgPma7+KBumNlGrI62Z2VAoBXPQnb5TQz445B4QkghLhJbFIKEMlO?=
 =?us-ascii?Q?VSggv4NyCEsBXlrxGmRrHJjmnjnWxP+qkW1xzVpKMGKwyrqeIA5Z5Wdr7Wa5?=
 =?us-ascii?Q?ffFrAnOo8KO6VGc/zVh3Q6hBOAVTT0dBN5ZfDETqOHNPiAe/025wVbcv8C6Z?=
 =?us-ascii?Q?Sk9udU8Gc1AKm8fL7YIvOHSVTsy0G3L9Zvlr0JJflEJXM4cWUf1Fzr4j6KTk?=
 =?us-ascii?Q?qO3sHEVtK+KDID2U19hYbrNaQ+FIH75ZwrCX9zxhUx8MBodai6+Sm+6u0a2/?=
 =?us-ascii?Q?N/704kOLkghVO4rwCx2wf06a057XKuP80bRulf4ByZfCwPBwCGA9QmT3I7Fu?=
 =?us-ascii?Q?C1J4IvsvHyBEpCfeHCq9t4B6zqnvbqAr/xKQzBbkqHuxYq9QKcKj5Kl/idDB?=
 =?us-ascii?Q?hvQP8vjfVp8RnapmzCs4zLQRZOiKlZm6RFwQuibOKbSr702Yvp7i1I7nMFtg?=
 =?us-ascii?Q?oIstTAhEBUccDI8YaOJPymoyVZanDeSnu+7TfH7RXudTSxatJg2Ge+vomLSQ?=
 =?us-ascii?Q?mHUHIxsqrniwQS//kSLJNkURK+P5vxPnECIHLeSY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260b86d6-05b3-482b-3b24-08dbcf2ad287
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:05:03.2298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2r+Cern1hlrbnHyIOz6RDWsNOng4VFZA8SsZaEwCYti/TyvHXGKB46IdWQvBgef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4905
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 10:46:10AM -0700, Nicolin Chen wrote:
> On Mon, Oct 16, 2023 at 09:04:54AM -0300, Jason Gunthorpe wrote:
> > On Sun, Oct 15, 2023 at 12:14:01AM -0700, Nicolin Chen wrote:
> > > On Thu, Sep 28, 2023 at 12:15:23AM -0700, Yi Liu wrote:
> > > 
> > > > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> > > > index b4ba0c0cbab6..4a7c5c8fdbb4 100644
> > > > --- a/include/uapi/linux/iommufd.h
> > > > +++ b/include/uapi/linux/iommufd.h
> > > > @@ -347,10 +347,20 @@ struct iommu_vfio_ioas {
> > > >  };
> > > >  #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
> > > > 
> > > > +/**
> > > > + * enum iommufd_hwpt_alloc_flags - Flags for HWPT allocation
> > > > + * @IOMMU_HWPT_ALLOC_NEST_PARENT: If set, allocate a domain which can serve
> > > > + *                                as the parent domain in the nesting
> > > > + *                                configuration.
> > > 
> > > I just noticed a nit here: we should probably align with other
> > > parts of this file by using "HWPT" v.s. "domain"? I.e.
> > > 
> > > + * @IOMMU_HWPT_ALLOC_NEST_PARENT: If set, allocate a HWPT which can serve
> > > + *                                as the parent HWPT in the nesting
> > > + *                                configuration.
> > 
> > Yes
> 
> Should we resend? Or would it be possible for you to update it
> in your for-next tree?

At this point send a Fixes: patch

Jason

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649457CA787
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJPMCt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 08:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPMCs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 08:02:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013048E;
        Mon, 16 Oct 2023 05:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxCA18iaRMWvNPUSxTkA4lvTVJfwBkC39cXR4HTabdGeTZIZ5JDgI9MKZ/QyyG66QkRKIJUDIX4vSoHFNYSUOxDZT5/fH63GMH7E4VI5WFJhWkopV1aezAnLzj9G+5TPOUdCuQ8sNq932qEPryvE96DwHTKkpdoQmfZookXS/H0IWZBpBVy32USccBtU7gVDAg/hGzaqA4uNvKJVfOznBUtZCl+qIssvZaV60Vxp/hZMvx+I9E2UF6yy3IAZyeu4W2x3KRDA1XnrvFMDblhUG30oebPM/wDM+smjQ+llVEG3DG0gIH335dGceiCxjADqzlFETQfpmuDXyJdSlYTAGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPlmH67rV19jUm8U2YJULc01LuZPEC3t7jDkr4CjIIg=;
 b=dTMOduqCt5L5vNahWaKLK+DsYxKv8YM3cpJNsPEJEpiqgBGY+GdBkZtfOWCV5/XYMvgnpf+h8RD5jpF6cIcYeFXa2UvhzmIHjwTPppv/Hvq9sUij5s7TPMS5yWAOIfNheqsfOkWjzCr+dIMgZUKjx7t2K7xe+EpH9QAhdBIxz372KkwgfqJt2JI+AvV4+TN8LeIXIEXr+p1LRohMm8EThQhvssj2NhuIawyC778+bdoruF7O3TUWr/T5DSshoGnrfoDjLFiYLUS9UqSUVSkQcm6QrZVV3mfhirBw5GtI+si5sI03JKAeZmegWuW4kblvkKbYTRTfuU6hiFbDbQ7WXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPlmH67rV19jUm8U2YJULc01LuZPEC3t7jDkr4CjIIg=;
 b=KvZ46uJxmqWhPYpdcFrIicVMZf+RKt/Nj1FJHJL0lUdLScjZsROrXzdIEBBPpICnmjNiy0Z8cjCPAgH/OUEbICpG636d+Qy95ZABvR6qBlEsHyWeIqxlylDUL6ce7PzsvZJgNULvBEYFvC+1bafEHzaisxL1lmN6kqRRXdj7VlQDpYvBoVJ9GoKQ6XG9Ln+/R8NLup+tjwSUolCd/RID+VVj2HtBKJaV7c1A+GtxirAZlkUR9vSIaGG5bcJX/1UitpVkGOma0htJBiZS65iNnnc4eVy3+ufuazY9eEpQI/pHN1ZfCF7QxGBHvUQ7R0mE4QBsbU7INIWhwYa28rcT+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Mon, 16 Oct
 2023 12:02:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 12:02:42 +0000
Date:   Mon, 16 Oct 2023 09:02:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 05/17] iommufd: Separate kernel-managed HWPT
 alloc/destroy/abort functions
Message-ID: <20231016120241.GR3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-6-yi.l.liu@intel.com>
 <20231010184932.GT3952@nvidia.com>
 <20231012190931.GO3952@nvidia.com>
 <BN9PR11MB5276A55B59EAE44DE058DDF58CD2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231013140538.GS3952@nvidia.com>
 <BN9PR11MB52763F73D66CBBF6BEBA9B968CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763F73D66CBBF6BEBA9B968CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:208:134::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 497b47c8-f57c-49e0-7b65-08dbce3fcd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfjlAEgs4ZuFBvIiN8X5FhdnaPIAdvYIskxydBLR1Hl8HYH0nyAgOo7314s+4NLCycDS+vBYXmwFgHk+wto9GWZW3fjzwbHfY13R0K9xzWWXzgdWcvciLv+FUD1/yEstObgeqEIvSv6EzUeLocVp2Ffsvxx9UOvBcfFcmKcTs/cAHzxFaLCgQxaXkRNjj7LqmRXQtfyiVDdsVr25pF77WXrn36YTyYPWTRUw0C15FLHNCVGwBET0yxrhLncJDcQL2a0yJyp6f32/V9BfYl41FE8TP0L9YURLnQJPaMFJI4dB4kaCEvkBcEl8eeFNgcN2Z/DcJddNq02sTOHS/ujsR00XdcWwgydmA7ZDEA3VRdeZjiturrpmIVXFVKc8vPxy9YHEplKt/P8TjNFar9i66FiJ3tise1wTfOhR3fuFCXgzVmeqFAHVTaI2jNJ6sscLBy+swiPCrXSqEeY+xL6oC4r+EYJoIX1dO6hHzrRmdPmCDvScYJWaYceEd2TI/p8K8WWse7jv9AVzDq8BegQSo58fpyVafAWBS6Y3LT+Jqda5ddtfc/5PCmfykFh7kt8b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(8936002)(4326008)(8676002)(2906002)(5660300002)(6916009)(66946007)(66476007)(66556008)(41300700001)(54906003)(316002)(7416002)(66899024)(86362001)(1076003)(2616005)(83380400001)(6512007)(6506007)(26005)(38100700002)(478600001)(33656002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RhNU93Praco8QhmHyAAzClKvQbFgK/mrzrL/m7DUd5jBTKW3PQIkiEleireB?=
 =?us-ascii?Q?+RFdGZhXhqRx26mJVxWTmLqQiFI+yDTOsAv0E5y5JA9sJjbFQvUlJPxcaJzx?=
 =?us-ascii?Q?J70C+iYYcUVoroMap3lCHdHtNM/day7q3U7UgNeZR6mvBhX/N9VP68TnkFvI?=
 =?us-ascii?Q?QBVQxhI+3gfKkfc6W7JP86KY8dSAH6MJnQBGN/6EPQO5fmQUchCNcDid+D2i?=
 =?us-ascii?Q?CgHZOXNafLc1dRq/qvMWE/5b78ePz9B94JkMy+qKuwcgLbN0ApSnCgyLo3HJ?=
 =?us-ascii?Q?0sv9AC+Nzuw9gWsMaAcgucdahgB7PPgJPMZxqyJo5kZe5z604nd4VbzpMY1w?=
 =?us-ascii?Q?AgJptzwHQRNFV7sCgj7OWq0WwT6CJJEgM3DUQSM+CGEt+J0eoqmbugx6fa74?=
 =?us-ascii?Q?MhwdJbziyb1AXlF3cs0ybcSQMr7SYf18Llo17yDzApYygiQ5lc4DvNuWqzoj?=
 =?us-ascii?Q?AJxZmNd3WYKXbkRkm26L+k3iJc135NkGlU2WIqVVxRzYEYZi1+CDIIAhUCdU?=
 =?us-ascii?Q?ScvAQKg/QznYDke2s0x8VAYVoraIJyfdyY8aTTALVMUOYQuM7Iy2v6LWmM65?=
 =?us-ascii?Q?djUo0o/SEjSEUomlKyoPT8IQDSM2WEnskQLGiUbHMRrjj08hVavXeQYRTbjx?=
 =?us-ascii?Q?hos5YOtXPGfShE5qWVnFrKN02fnLr+ZY3zNqwIJc6RFdHVrZd2YTIA+0OUyk?=
 =?us-ascii?Q?1wKHPb35ERw8Kiea4fBLf/P7blvRBmYOi7qTq2dB+NyOlCNTcKGvK+rRzSM9?=
 =?us-ascii?Q?DB8Fbh1pGWN16FOj1chhwAuJCjwl7nf95yASU+1iJT3sVUtzwpmoSfxQiikC?=
 =?us-ascii?Q?nEcbTtSfJYAlHYK07hl2AKzdUb2fTll8zH+5OTX+7TO2ZzedpSYmoIaW+tZZ?=
 =?us-ascii?Q?hx/j/q4D833HbvNeOjreEPzLFXPwUc9eTBXSK1ftl0OckyBNyWSYE/nRFLO6?=
 =?us-ascii?Q?TfUUwCe3GC00Osfr10fW1W3ttrtXlSuRFjydCLjyoV1Ou3UYhaxho1vJNllV?=
 =?us-ascii?Q?yVJcA+B1WpA9jAUd78n1x2uQSrz3H80Q704WgCFMNzJYZJR4IB8d9GQOEFY8?=
 =?us-ascii?Q?XW5AfoGJTNsqSsrGgllLCmovz0dgxhT5FFTin/mH4B2jLKYVxn4tpHuGVMxP?=
 =?us-ascii?Q?AxBIxTvMUgh4jchCPAW6FfTadh2/0yDpWL/Okhsqm98gf+/cffCwQmbGtyeR?=
 =?us-ascii?Q?MSLIr3JsTvP0UpGK900GcVgkvhfd96Vp2jZ21o5k+GTRWnmcQISzmLb7Lw+w?=
 =?us-ascii?Q?od+BKJiFWmotu6jgvkjhkiOjEBsXzkUqss0OdXYxPIkcB6BFlI6q/TkrZUrg?=
 =?us-ascii?Q?RkPBy6dOhzFrlYGsXH3TE3Bo0yWwmodZD9lTtWOUgF3xcb7pk4taSqO/xszX?=
 =?us-ascii?Q?8R3FFfY3BSOyh82PaNCyuqv7gEtnwKHn76cUp9acueKawhv4UavshnRBsCQ0?=
 =?us-ascii?Q?VzZXQjtadG3MZzTQReKNO6eRh/TPV1USO9J2R6z2YiNBVgTfTX50zZve+Byf?=
 =?us-ascii?Q?OMNieoBUZt+xW4bTWZwf3gtB9wpmCL0lizL8PFIj4AoDz30YrTdHW1jlhSX0?=
 =?us-ascii?Q?11+r8JEXV1bzzo7oCkw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497b47c8-f57c-49e0-7b65-08dbce3fcd70
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 12:02:42.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvFt/HxygWakYi2eguxKZYdsXvyujzAcWORMsEiNzsDkv3W/u/pkJPH2s7snds4k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 08:26:25AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, October 13, 2023 10:06 PM
> > 
> > On Fri, Oct 13, 2023 at 07:13:34AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Friday, October 13, 2023 3:10 AM
> > > >
> > > > Also, we probably should feed enforce_cache_coherency through the
> > > > alloc_hwpt uapi and not try to autodetect it..
> > > >
> > >
> > > In the past we had a long discussion about this with the conclusion
> > > that user opt is the ideal model but it's fine to stay with autodetect
> > > and existing vfio/kvm contract for coherency detection until we
> > > see a real demand for user opt.
> > >
> > > Is there anything new which changes your mind to have user opt now?
> > 
> > I guess, I was just looking at the complexity it brings to keep that
> > working.
> > 
> 
> vfio_file_enforced_coherent() currently just looks at device_iommu_capable()
> and can be called before attach, assuming an autodetect model. 
> 
> moving away from autodetect would need a new contract which I hesitate
> to bother with at this point.

I think that is fine, we are not enabling new behaviors where qemu can
directly control the wbinvd support. If we want to do that it can be
done more directly.

If the vmm sees a coherent device and does not turn on enforced
coherency then it will get a broken wbinvd and be sad. Since this is
all in the userspace vt-d iommu driver, it can just do the right thing
anyhow.

Jason

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AB67CA7AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 14:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjJPMFN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 08:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjJPMFL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 08:05:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7647FE3;
        Mon, 16 Oct 2023 05:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fte0x3OgPBYf4CI5jkHxr1Kc2tsVkX2LBR9iGn2Z2DXGVj8AC38xc56fdH9Dh9PFVcwh0a+GO2QI5RF1Fw7AaEgI/A8M8XO0v7AxwtG7saxV73NHmrUqS34WV0Oa+gVNmlh3Lv2EUo5ARfBk9tV/ek/UiZCEhd5YaeC9VKsO63Rt2Xd5ALFbAiLIl3P03hdwoXB0aPmGaDec9VfTXTovCYuOUQauljpnL3sGK6Hgul0j6k/UMlgk2azDmw9L7uOIog0JQjYIhR1kxM6r2UMH6WYXjOwfotomDPmkkcyBS+TX39d2CG4bz0yGPfycATV4n1ckkB5Sz9Ve6E4VQHyaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzwmAtmOmC+swrHDVaarrd/NDG/3+QSSo56Kh1bC7RI=;
 b=UCC708BTmIQtLdSUvrK3GGkTXRSf+HC/gSqHNm/vnk2SVIi+cxw43NeQ7mjN7IDJE6oOV9irO9oE0A3QHllFgmcXwxV3edBj3tcobDYTkWpAZDW1mpICbIU+ZS6Yu6jR/QJlJlT9RTR8Pb/HkZtPQCtaZBv/4ZIXfh6c/G8R6A7sa8pWKt7xhhoQ0dAnleMOaYDH3CEVIBruO6H4tx8us7P7CgSGYU9ikCBAv9miGmic9V9EG3pNXaJ8vRVPQUHVWHq5iiJeYlKnC9Dm1VL8izP3yWblBbT2FcP35RnU6LHSqZNqtSXodowM3udr+Fdz4+Xx+IvN751LYiNB/JhScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzwmAtmOmC+swrHDVaarrd/NDG/3+QSSo56Kh1bC7RI=;
 b=gfJbs+hZYijJYdd0VDhV7A00pmf5Dj7Gq/doQJTmHQN2GI5Z1OTp/K2roUzoGzWkuQaBaSBFHS9K+gu+xnxpxRExa5u4S0w4gBsQ8xJweE7Uj2IqNPt4mLJsV1XxJBK/Gm7SxvuGIfRg80ngE2O8+wD40P6z2inNTvlG0xNrzi7FjoUtulWd4E1sFPBhd+tYUjSQPh2Rp66L6iz88WvDEk1YOHj9D6+UyHutRKjL2We5tl3kWAkvs3xSsIKt+CvP2GUMFdzwOx/tBSZxvELmVJIbGwfa6BgkIF34If2c/CVj9WBMmDMlqkk4cymPjaaZ7DfTV1/eo/cAzJ4PxgoeBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 12:04:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 12:04:55 +0000
Date:   Mon, 16 Oct 2023 09:04:54 -0300
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
Message-ID: <20231016120454.GS3952@nvidia.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-2-yi.l.liu@intel.com>
 <ZSuROTyaxePoVFA+@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSuROTyaxePoVFA+@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0077.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0c1aad-f645-4a1f-3e5c-08dbce401c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRKhEpFuTaIlRdgpAKq/EIt0gNiRM7/Y0KQ1PH4B/JcrvznPQMgU1RCJqvBv9Z5d2/0/8W2P2XyO9uGy4yz8wWMl+csHJ0HAThcuzsDANrzPclHNjNiUXrQPst0gwiSKO+epkgCcl77CzV+n7tyJzkofyHLQpbZ/7hz740ax4LeuxMYnLFRc1MMb1jKCcCM5eKNaFASCOPQ+XaoC27k/3ACKeen8+/yvLlMrKive3F/Vjij2t02uJsUexPWfy7MyAHGfqwJx51wHv5qepRJ4EYLMXUdli9R2dI2X6G2EExlIXv+nmZohuCaC2SCyfm1peAUZJOiPLoTV/uIGBcWROSVFxjH1D3k+0ABQhmNDyn8SAIhjYGZ/6tN90OkGO9bKiT16PpG6JVMEz2Q0yT/3DgkIZQ36SAHH7NlIfeyyOPLhMrskytGW/g7Di3u9yxblCc3gO69Hlp1XjsEXlxIKdE7VHiv4102PUKcc/PyI4J2ubB3WZZSTZIdVs8OTqBNhKkDsqKTi+fyHnHCHSuNtO89zrUns81QbUyq0bOMKpQU43opC70QwLQxULQbrG95H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(478600001)(66946007)(6636002)(66556008)(66476007)(54906003)(37006003)(6486002)(41300700001)(83380400001)(86362001)(38100700002)(316002)(6512007)(2616005)(26005)(1076003)(107886003)(6506007)(5660300002)(36756003)(33656002)(6862004)(7416002)(8936002)(8676002)(4326008)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OsPIdv6fOvrB/wWly+wS22jA1YtkIc00UTSNIEDZQzGkshX0+XmuqaXREvZY?=
 =?us-ascii?Q?cqBo5R+bI06EKEkOHba3ZGp7d3mmacWxIpiFS5L/buTMeZpJUVUHSnrUKu8O?=
 =?us-ascii?Q?BSgr5atAp6nh77T4xnk5SjzXmTXDk8C9F+S1hSdm2gSPk1rRqvnaDFfmowKy?=
 =?us-ascii?Q?L45dcGsG9+I0TdiZ+ll1O/iOW8KREcFWzbFaqJJm3WUREDEJRMh3WD1yEZUD?=
 =?us-ascii?Q?lRZzl6KUILdOKVf04UmG4qq8CsKdapPx2jp9cM1Obrj2Vfo4EO+J5hk05+BV?=
 =?us-ascii?Q?Vf2plxqnxiCXUxHPyAS6yWZko9LNP9chyoi0jPARH163BLQNiKWl0SHxn4JP?=
 =?us-ascii?Q?n0MfBszEfIbWZ3dpWzV52Pp1JK9ABhmK7VpSmNYSASa8NAK2K/Q7Z3mpO45C?=
 =?us-ascii?Q?PLFu9R/MONFZAgcW7OpGSNtoZ2SN57a9J+w4+tXfst9tCvYI9mlA29ydg31a?=
 =?us-ascii?Q?uBZCG7QeDcQs4ANcWPdot/GSw4plKkvEQ4iLNNoyvrTb9GqHvwFHv+e2ftDN?=
 =?us-ascii?Q?cF2lTgY2Aee8I0sY0gXKhOGLCZcHgJFjJUaR7Ww+2rMaSrvIQAsf4r8sZMor?=
 =?us-ascii?Q?CznMYvg2TO7mBsgTVky19LSiP6PShZhWTURm6xXxyF56WDJWCARhKza07JXI?=
 =?us-ascii?Q?TqdR2d21cLAhj8j7crLtRPMy2vXggktqup/SuNhxH8m/iR1z12O5WlY3oC4P?=
 =?us-ascii?Q?cKpmx2lTD5nSyiP3B0aEs2JAbT4OuuoiTlIWKstKtXhYQmgO8DCVu+Hi51pb?=
 =?us-ascii?Q?+dUlUxj9NnVVwvp3Y5eTCbpKEGSLOXH0AbCDNBMrUrPhzNNjyjFiYluut5l/?=
 =?us-ascii?Q?ZWH01x916OVF1Yc/09dl9JK485diZQTwpO7oNW88hSYs6gDy8HVnGMnHsnP/?=
 =?us-ascii?Q?JzzT/QokmuN5YYmePIVwDEGnQTnRR3T+pdGz52M6CeyD0uQSLj/o9QofvRqe?=
 =?us-ascii?Q?9JJqohVV7B+YAaoKzcSDlfj9qG+KgV1zJznIAzcDr7zdrxWV46an92tBGRAq?=
 =?us-ascii?Q?gribG/wlevIHq79bcigQZHyycgzyoVHBBPK7+NA5s0ANidTL5aEKJotpOtQZ?=
 =?us-ascii?Q?KGVhUhHtFyztFMqmj5yesq5b2+SdoUO4/1Uw23OIgqOZnoH+J67T59eEuzNY?=
 =?us-ascii?Q?+aW3Nf03E8cwl0Euj3E+4Mi6Hc/6k/w8J1A81B8YnP+ulUi9RqQnuZmmb5m6?=
 =?us-ascii?Q?s3ueSkaHoFdUhiCsztDuIhjPbHBGvaYF3XIdfxSySxiYcZiVKSf1fm+y3Brv?=
 =?us-ascii?Q?SmTlfcROpKd28NMeDjPx51LTbdTWt/e8X/auH97Ye9V9J9EfY5YzIyj9iE6O?=
 =?us-ascii?Q?dRnWSTvT67pQLAzCH1S2DJaL9o9bg1tSDKDnpF1DAwJDkZADSJNIZBoD7His?=
 =?us-ascii?Q?2D0Xs68pdNE4qtrHlCwambXyrA9RYnySZe69qEx+nF1cMtQPBj/tmYZZ590o?=
 =?us-ascii?Q?9QMDE/gID3T9Fgbqjm8UgzcBuK4ydLq6uQpXjGHTN6K1PfjTjPOBcBUKj8G+?=
 =?us-ascii?Q?TdQfrfxSqHuc7Naa36TtpMYOuHdlfu7S+QhMiSlxywGr1r1GAbv9QibJMy4G?=
 =?us-ascii?Q?PHSwNLEtxzdF8MUl+gK9ReLItb0mWeCYELI037rY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0c1aad-f645-4a1f-3e5c-08dbce401c3d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 12:04:55.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYGWNAHbF+DdybVHlSmusXav3GDgz5FCW3+TUwihkHWbzmS0a9MN2FGpj2wPuZOi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 15, 2023 at 12:14:01AM -0700, Nicolin Chen wrote:
> On Thu, Sep 28, 2023 at 12:15:23AM -0700, Yi Liu wrote:
> 
> > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> > index b4ba0c0cbab6..4a7c5c8fdbb4 100644
> > --- a/include/uapi/linux/iommufd.h
> > +++ b/include/uapi/linux/iommufd.h
> > @@ -347,10 +347,20 @@ struct iommu_vfio_ioas {
> >  };
> >  #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
> > 
> > +/**
> > + * enum iommufd_hwpt_alloc_flags - Flags for HWPT allocation
> > + * @IOMMU_HWPT_ALLOC_NEST_PARENT: If set, allocate a domain which can serve
> > + *                                as the parent domain in the nesting
> > + *                                configuration.
> 
> I just noticed a nit here: we should probably align with other
> parts of this file by using "HWPT" v.s. "domain"? I.e.
> 
> + * @IOMMU_HWPT_ALLOC_NEST_PARENT: If set, allocate a HWPT which can serve
> + *                                as the parent HWPT in the nesting
> + *                                configuration.

Yes

Jason

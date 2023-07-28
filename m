Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D83A7672D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjG1RHE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 13:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjG1RHD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 13:07:03 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A71B5;
        Fri, 28 Jul 2023 10:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm3NAoL89b+W+mT4weDeUZw3tRDe6MQ2HVd91lWfsj/As0+Juo5pC8HGYnz9Igtb6876OwncGrARKq/Y5Qzxv0LdlcEHkSpnkbEAXJXKfN6P/GhYgNzUh4jE4XoCK+fvI6QwPfj6fdd+Tkrf+3acwYddWe+dEkWL7P+sHoRwmGpgDXDLwgrfQCrhQdDs3oU6N1pr5nQmM76zu6Vdus0WK3lbFL4ixGnIPOPJwa3FAiPHk4Y/282q6rlate5p3SYN84gR9D3BaW8Uy8VvLO0/6a4WFm18yMDuJNSz3FlC3gtlCdual5S0hReQKVE2ZFHDit8ze6lOP8FSihUDK93NbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVQo9Q5HyZVh+cxNg24WVhXewQAeg3lyRQCqeffaQeQ=;
 b=igd8XtsFqzQYs8QgR9cD0OxYqsafF7+SpKllep76eNJA8pjJ5uCfEIX0iqYny1LhZIiUN9gBMrwevl7VGOgh1zGh8wK87DPDPItYytrqfAlkEp4aL/f0o8u1T8g8mxv3wQ207ifof2TLcvR/fmn2tk/0MI+4nQqNsq9YpNkoSJIftZaVE1cgc6hw+f6DWCqEaj6FtsvYekn3vlDclMBHvuxDlAGxG9xKl6yg2bsp5zCRNFoiUC+7k6Qqm+FlShs+B75f+CkazghRdNetbIjfTYqUU34JrftjdjiKeGKhA/bG6FmxD5hLG5ZDAMZLiJDukfi/xSXxrGvE4aEngHYg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVQo9Q5HyZVh+cxNg24WVhXewQAeg3lyRQCqeffaQeQ=;
 b=MrmP8kLew3Z0NkkGdQRJDngFd+H0djJxEc3A4k1fxn8qvrhkkiC4kSWjuJUD7IDyDsAb3e6Fdp568N/AE5YH1edbCM0sxTEyOU4BYDjAtTjF/xJYu3975flpcfN9YUWVGd8PnWEvJIapsCX5haR/zKmvwAR0KOL2fxzv1zGM3XPb9PGpAenSCy4FT/qFiNGJkgsQyNoRgbCWT3khMN3FfjwUl0BO39TQ3igSrQApoSQzeR9cdx9H+BMcmq8Ou4+C0uuVJZxia6G+D0EnmN4iJFON9hMKJufjE4/fAkf36HftX+p4cJGjODtPbpWxL9o3eFwNDDQJO7+C71Wiooc4Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:06:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 17:06:59 +0000
Date:   Fri, 28 Jul 2023 14:06:56 -0300
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 06/17] iommufd: Only enforce IOMMU_RESV_SW_MSI when
 attaching user-managed HWPT
Message-ID: <ZMP1sGvDmqVF4YRm@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-7-yi.l.liu@intel.com>
 <BN9PR11MB52762EE191ADD610542EB06D8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52762EE191ADD610542EB06D8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 892dbbcf-b7df-4f4f-5be7-08db8f8d0dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqN+9SvK+i18MftnfmTBe7nSneIcA96CcB21ITogVLaEyT2viIexu7aDm7SD3R4EnqgnSDti60ivjRGO1G0EHjeROLavMjynqi2OfVgcQJMHuKpkYVmW8BQmV0PY02iyO/O8V2qpxtLeArteZklRqGIuZlXUYeiY7kid9ba2eVpeuUiRWETv1m8k2rfkevGQ/5CNAyv5DcW2rxQlsB+I+AjtVsRyYsNwlMB4FoE/6GMPb+VqsbFWVvULJPFcWbVvI99VRID2lcLXKjrSbNC/piyEAcbByDkOZYcNAzD4tIu/D+1vgvmxJzQ95EtgZAzyJW/sig22hYHguyRjsXaYsN+DAdmRN9HtwJuMlZQ5bIHmhmGyxQoeQRhuGouqHA2tVGZzw+dh/QUxvGCFxJ7/9o2L+i1nIDsQcaubzVnsmJhfmcKNe7J9BVl9wqKxDaD0Jt3j/yRoxVa/JgojADxfRVqwfKISrYzLXupQBzroS+x0v7bKCiPZ6d5HovRdIjyetxGz0yqLWVugCqVcAQQDKY7AT1ThvkkVzZwc03/+kloMCm8yegeM5zWwJ/Alm+Pg473V2xOSSic1ALK7jP7RuMSPNy7W6aQkDbZSDFBs10A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(83380400001)(36756003)(2906002)(86362001)(4744005)(2616005)(38100700002)(41300700001)(316002)(6916009)(6512007)(4326008)(26005)(8936002)(8676002)(54906003)(6486002)(66946007)(66556008)(66476007)(478600001)(6666004)(7416002)(186003)(5660300002)(6506007)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KNUY9MboZXQKGyBgtT1C8Y1N8ZEOaBAaXPf4F0FrrMGcsmNKJsDVdqbJd2fX?=
 =?us-ascii?Q?1+Xvj38CBxeDMC0RYOS5/d9rqmx5pq9CvxFZlzOsvHNmuXh0idR19y4JPCWA?=
 =?us-ascii?Q?yVSo3KYhXNH6tWspYLR4Dx2LsAd/sjU0CspE58h/QPx/W620+RhyXIQu6g/q?=
 =?us-ascii?Q?3zN/oitaynp0y1HHkwIvVHwkEFGqWn6oFiAyaATQIxbURE7kZ9/ILbE45Ked?=
 =?us-ascii?Q?l/NJ955MJmPCc9Au/uxiRGSSiEzKgJhFTa1JLzJiJvSeVj5QXV8YNesjn+ly?=
 =?us-ascii?Q?8fYrQRrOexQMGDQjnPyxAdC6pdn1EDlu0pfXtL5G9kzIVQ64rbWtl7S6IOJE?=
 =?us-ascii?Q?5nNGjEeIH2vhq0+nB6iSVp5jTHhHjlFbP0LC0qGr94wYPsuqt3jLUIziestp?=
 =?us-ascii?Q?GlV7qdH2N2VfBR0mtCQOLi2QL6TXoJTsuxIU3yn/x+7JJiXxMY3dY+PiXpfw?=
 =?us-ascii?Q?Z6SRpJvISk9lULchKPT9t3oSXO3XKRv4nu1+tf/GhaVQ2RZ47mEN8LRFMb2U?=
 =?us-ascii?Q?jZ7QFllnBQUcaQ8Igj/7lWGPlMp8ovGSCDiT3+h6fceunwX4l+gG0k9YoLx3?=
 =?us-ascii?Q?e2qQkLdXody+G6fj4E21x0Cf6UMV7XbbhKvWeL2j4qbvLolKyYqDTTVy/Bb7?=
 =?us-ascii?Q?jjPHhIb1c3FY34aZqxDLcDzq0PeA8VgpN1WPMvNblfsvdYpQtLsyIpqSMOsj?=
 =?us-ascii?Q?nIkbKRoObNbv5uoMXW1TXAIrUxbqeMoqv3ZGKBpYrOdWDM2x4WkuARxE+uzr?=
 =?us-ascii?Q?109p2spjp8tSHm6DcJlw5OEdfFi5g6dFZXbM6uVg2MPA779D8295nSYLlOIM?=
 =?us-ascii?Q?rh1GHFvXePXmjWVCrYgvZKUF09JU+MKy8U/bP1fmqhbsK282aH3VLPb08+PJ?=
 =?us-ascii?Q?cDhE7zRt4UMdBAbAgVh4/rrc6QLSgddaAe61gAMhX69u3h/sqjPWNkwuRW6a?=
 =?us-ascii?Q?DXAcbeYIpTMXcvEfqhLlSW+OMGs6Qk0mCGgj+caG/3rv4p1VnEEYTztjR8aM?=
 =?us-ascii?Q?ZbBE09HDXeUI9MlbjtU7d8gQvGrFxUJ7tZ6a3MYhXssJEKKl1IDvFui/7A4h?=
 =?us-ascii?Q?dLm0KVLXZzQ793QJSaCuSkLp36k+KzjueQf0kzt7Nvsa1ujI0n8VGUQ+eQrO?=
 =?us-ascii?Q?0vZIC4JdMEZW6OAHEaNHAI1mvCDOR79ejobZ8xyNdaJsLUBZPNQSr1TNwXLQ?=
 =?us-ascii?Q?kNGBkapFA7vkBxCWPwQvoBK+9bncLJKmQKNCrE0ZuQaiS8okxkvnY2Muzbin?=
 =?us-ascii?Q?EeBxUBijYaGdKiKR5ZFnDy42UhOMRUCtzIWq3lovTXENvtz4FN5GBceM8w9a?=
 =?us-ascii?Q?HigOndZGUf9wi9RKgqtx1/ztr7dcpYeCU0ud2c/aITGCrvh/rQKU0ZX6qB4N?=
 =?us-ascii?Q?tb9QJS7XVUFHkjVdrc6p8rBDhAjegx3RPIFu3vX/g4S3obqBCqxkzTZE+Wm8?=
 =?us-ascii?Q?WpcmZ18rzuqMBNSEPbkZON6mBQdVrlQUlzIUiuZHcMdJK0kCK1kZ5iSWNrmv?=
 =?us-ascii?Q?AGxbgCRvMpJF09pKnbunRO+RutMHTZkad3dnvsBKoYACvAgsUukTgylb8+vs?=
 =?us-ascii?Q?wxuIXGLNYHFpugs4H41F7OTqM0jDBYuOdXB7oDOM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892dbbcf-b7df-4f4f-5be7-08db8f8d0dca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:06:59.0310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOX43gsxIEtJSFB0CKeLX+yU0d2qtGUurDKfXxWLXtKddCW2rvEgc0EPxxUI2zxE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 10:02:36AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, July 24, 2023 7:04 PM
> >  	}
> > 
> >  	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev-
> > >dev,
> > -						 &idev->igroup-
> > >sw_msi_start);
> > +						 &idev->igroup-
> > >sw_msi_start,
> > +						 !!hwpt->parent);
> >  	if (rc)
> >  		goto err_unlock;
> 
> I prefer to not setting parent ioas to hwpt in iommufd_hw_pagetable_alloc().

Yes, the prior patch didn't add it to the iopt, so it shouldn't have
an ioas set. The NESTED domains don't have an IOAS almost by
definition.

> then here ioas can be retrieved from hwpt->parent and then it'd be pretty
> clear that in nested case the sw_msi reservation happens in the parent
> instead of pretending the stage-1 hwpt has an ioas too.

Yeah, I'm confused by this patch as well.  Since there should be no
IOAS for the NESTED why are we messing with resv_regions?

Jason

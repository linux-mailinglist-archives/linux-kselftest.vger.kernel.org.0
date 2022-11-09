Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E6622C1A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 14:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKINFa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 08:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKINF3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 08:05:29 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799A4278;
        Wed,  9 Nov 2022 05:05:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhcnIZlKBgQkOGl+TyjmSOT5mwKR0b+zao5Wpsk6hxyTUnpoYV9jObjuA1JvVKb5xSVr7uvSFsB7UxcRXCtI1xG2gzs/Geom0sOaslU6buEiksTSn8Aw7RnFgivcjAEhGrvl9ZL5slPsPOFI15KeUfAJL4sYU5puvepIObdMMA1NoQCJ9bZ/EK0GAMOiBilFWbD5aGNWz+zAHnYwX+fJ7lZ7cOEW5WHd4lAaXMlb5LtMjFfRDnK8FiKLQmjrx1AcohRi+x6Ah9anjoboiaXUjwj3ynVfo5HgY3t1TuX2RkHMcC09FAjpLy3i4r+tAZY9ZmPjAa4IX0CMPyvzZX0DMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=za1nBEgAbzThlyMfklpADYMUTsWbM4JSSz2CfbrI6pQ=;
 b=dDOSKBETl9ufy1HOWSKkdkW2TQcUcckN2S4uRSigIvwScxSUV7qvoGxROUgTJcO36rJRYyYfQkUs1gacC64QwWhq1zpbewtzRhqUTwtx+5w9eQWtkyLbElIms6E5DFYHjfg6BihxfQ8IQSHBHDTzg96yZ7JUG3nTe387EgX/7jZbMIcOEzbjbqSycWBKgdU4lJxNQMXy2dz7Ly+SkCqFoQrlL8PKpsfoLUrK4tmjXsJfzgPodaA6I/qBotUylcDL9AtnFahrMcuHQduhzLZP5yetNimO7u4oPFruItOQAZoMC7AXPyOqL9RlH/ptONkkW1wEbWk/AKdkWjwB4NBjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za1nBEgAbzThlyMfklpADYMUTsWbM4JSSz2CfbrI6pQ=;
 b=YO0u5N5077n/SGQV5N14tABN2lO+ZPK5XjBpx2xSfjor6FFYecjCScLomG+q7m+2E3n2lNesjP170JztMTbrYcQ8yQlcReqCXXhoO+3xq4egFCc6m+AMgFnoLYLB4nZcayekYK8rCEXD6Ce+eqWy+5KuP0dv2dABYCpS7bHVAOBuge65eqXcnXwYXzrH/c8e1Co/5Tm7/9Ym8izMHLKL36CYhGCSc1xXNEroppzCPnQDzMPjN8FnsH0xLNXCvOVnAQG+yNqhSpGIS0FTgbklcWEUFN18zdYu8p4HHt6kxNnVTCv83VbeSoezZatvz1L2K1+d0oHhDBgg6A+POWrBuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 13:05:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:05:25 +0000
Date:   Wed, 9 Nov 2022 09:05:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 10/15] iommufd: IOCTLs for the io_pagetable
Message-ID: <Y2ullBdcxIhJKFeH@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB52765289F880B8A7297077318C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2kd/Ptt0iR6SGsh@nvidia.com>
 <BN9PR11MB5276706B744018EC6E36E1128C3F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2qSEVu91SOfvVmO@nvidia.com>
 <BN9PR11MB5276DAAAB20671B6DCC135728C3E9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DAAAB20671B6DCC135728C3E9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: 3013618c-ccff-4e51-bb99-08dac253111a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaJ2NE50QpsokFb+30Ru5btUqgWkwOLqUy6gwEg8l4+j+yW45BjDIE1/XQGWWfiig/0GEHqQoyLS33gnBWsa/SsnMLb197x/jPJpIpGtTRX/8MVZqeNjNntLQrdWH/7Git18F7l1L6nQ/42ubovyEQ/U3kEQHZL3kbYlu3NYTbPbx5yyffXrmXxS2F2ar/5L5Pc1UPYpSncXwVzlXWDhuQXY1hNrdX+2rekaUVHdacDQWumWd/GRBhzomFPNJ/uvCby1HyHzLDMPGFvJM6EBGr1oJoMBeo+m4c2IAMUv7AO+9+OV5NcZJJsFL+AJIvktiENsiDZAzRQ60IkTUYG1dkBIeVKuK3nfakcEPv87gAvZKr76f9OEr8rcozB//uKJEY5jAssCKW2RH/ri8Tk0TYsOVLI/+Gq70z0QMyI9HE9Wwx8S9i3UPUacIHTDFX7bBk+AdCbyPRY9GFNKxCxaErzz3/CrAMfZPIiI1rXrspRznn12rziTz3ykPkTXhRaRMhiI/Pn4I12T8i+h2G+ZOD7iPFeXn6TYrl/XRykirQkt0DQyMbYeRs1nGLVx+xeAsnaMskFrPTsZQcoThrkmq4Tg7tYVY4Ilvhtdp7gu0VawEXEyupIxTGjZdZDhIvHF1/kMJR7oxOEPY22TcVEvHPkv+oFItxEqZbeRgF22qk2j8Z5RrswE3VCXkiUKVMXtmFrp6FijdZnHu5uT8zSfaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199015)(2906002)(5660300002)(7406005)(7416002)(66946007)(38100700002)(66476007)(66556008)(4326008)(6512007)(6506007)(26005)(8676002)(36756003)(316002)(8936002)(41300700001)(54906003)(478600001)(6486002)(83380400001)(6916009)(86362001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9HMaxZZDvNPi0M2Y5keEmjIV5H8JHyasQAmICa8GAZdighYH+6ETUVncMYqB?=
 =?us-ascii?Q?0Mq5es44ZaoeFfN6eqEJKRARrPuoQOtpCioWj7E5fYY2SMiNcfBISs0uVYcp?=
 =?us-ascii?Q?kL9utEBE3KMvE2e+5BPJHeoiJwSkfxP6CYtFlmGESZ5yKWgHYEllsLU2TGwj?=
 =?us-ascii?Q?Xa57SLm+DINe8uQ2wc5afZrGWjCunvz0wu6wPYG9GA/ktZ+vFFkSN+WpVlL2?=
 =?us-ascii?Q?RmvS6bqxzJDmD8E9Eo18Gq5B1m47GW/FmM2Lt1u33/dda3bF5x4z3E70AHWw?=
 =?us-ascii?Q?wWci7P+KYNbsPQJZlj7Phc/Nv839clQs/s4iSX2siYzdbIjdKMSe3aSC4Pgf?=
 =?us-ascii?Q?AehJzpv2DT7L5HpGczl5ShgVBrVPIPJ6fktFSX0m+8IeLDRllT6wsut3F83m?=
 =?us-ascii?Q?j7WwFBeZTOF4q7SrVG0GO0+9Fvjovecae+EH/kCEFaWH+AeFLN7JAN6XsGdZ?=
 =?us-ascii?Q?nqDd3Txpxx824lcFFKzS69DlIP58MD62zTcPzNFVTZOFd0Hsjpti58A8it2T?=
 =?us-ascii?Q?AcayAi96H/OaxA7VekJKR4hMCNgTd0Nxn/Mp1OgpMjHYsCyMLM9XD0j6D7Mm?=
 =?us-ascii?Q?QpofhnsgXISMVGfXgUlkynx2Cy8LwgGijhdGdkZjL0aaAqU8KgCV/l9MagSa?=
 =?us-ascii?Q?YO6xaWhDJTSzXF3+ZOS5EPKr8t7a7KFQ/IICKvr1kUnW4geRHMK6lkR53Hso?=
 =?us-ascii?Q?glzl5dbfdItih93X2wQJ291+JgWS4+GjmBTcWf72OhqoZxm3v746j/e8oQD5?=
 =?us-ascii?Q?EqsxaiUm+Nn0KIe9HmzTm03z2H6eK/fRrrUsxbE1hH99ZYs2fG+N1D30/Lq2?=
 =?us-ascii?Q?1K4eJ7Wdh5mVAJIg4SNMLErJ7cfcAi1CwT8MxFL4a+G5KnSPNAwYPpI49Bps?=
 =?us-ascii?Q?ekVFQTip34qhqqE4v+6gNtjYsr+Hc58NpU9AnWnV/aVPL3tnaSiOWx6iwIgv?=
 =?us-ascii?Q?8oa7rSoWSIO+roJ4+j3mdKlz0szWSkLwJ0mDUAG/lTtI3uLzsRJB6QMlV2ic?=
 =?us-ascii?Q?fts40lX8Zy4YiEov73uQOEn8EKy+LdpJzH9fhpG3ZWBZGGSejKyQ25yX4E3A?=
 =?us-ascii?Q?uLp9oSQSn4ixvJIkM9RK/2qTH2TSx3Q7Zc60B3JoS0VTNQMW8qZpv2NyybyL?=
 =?us-ascii?Q?qE4x4mKRQPg5L/VHJhnedy/Ql/F8IP0mp7iBU7Zf5fSHoFl9ASW/9pQs3Nxe?=
 =?us-ascii?Q?UZ69meKRoxkJvnk/oooU5UUnZGjtAneAJSf7zeqbNPn6z+/fSweCotqZKsWe?=
 =?us-ascii?Q?HPAa0iY/dQQ8DrWr4hTqaaML2mYfyE80+FHx4r63nfw7mQlTrX4JbmumsvLc?=
 =?us-ascii?Q?u/m1ByzXxR/y46QFy6POai8nLhF41aDJtHC0anPH5eQniEYdKDqNKYz1zkFJ?=
 =?us-ascii?Q?ZFh6UWGm23kTUhrAjIIeQjMuoTEUWlvkTnB6ILXX7irRP479Js4o/dTxkInN?=
 =?us-ascii?Q?PDMxIBezMhFQJ/SYrKFpkrBMPX9Pzlfvoqcr53lOQv2iG0QXUfHB/t/JxMx5?=
 =?us-ascii?Q?9vel7P0ShrbTNKyz4IgX5AAke4On//b1fe2A8TMyBSTP5QO7/iOEW7uHuy9/?=
 =?us-ascii?Q?WLd1w1/pAA2A19lz/vo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3013618c-ccff-4e51-bb99-08dac253111a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:05:25.3728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvjeAR5MKz/JG3aCoXEF9ERXvZ4SU2pSAjge5MoiMo+NI4Kl21zSOgDCrzWaBTWA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 09, 2022 at 02:50:34AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, November 9, 2022 1:30 AM
> > 
> > On Tue, Nov 08, 2022 at 02:05:20AM +0000, Tian, Kevin wrote:
> > > > The concept was the allow list only really impacts domain
> > > > attachment. When a user uses FIXED they have to know what they are
> > >
> > > it also impacts automatic IOVA
> > >
> > > > doing. There is not a good reason to deny the user to use any IOVA
> > > > that is not restricted by the reserved list.
> > >
> > > I just didn't get why different restrictions are applied to automatics vs.
> > > fixed allocation.
> > 
> > Because it isn't a restriction on allocation, it is a restriction on
> > domain attachment. (and this is a bit confusing and subtle, but it is
> > what it was built for)
> > 
> > The purpose is to allow the IOMMU driver to allocate a domain with
> > knowledge of what the user would like to do. For instance a small
> > allowed range may allow the driver to allocate fewer hops in the IO
> > page table, and a create a domain with a smaller aperture.
> 
> if a domain can be created with a smaller aperture according to
> allowed ranges then the impact is not just on future domain
> attachment. a fixed IOVA outside of the allowed ranges will
> find error on current domain too.
>
> Should a driver which does this update the reserved ranges too?

Not reserved ranges, the domain should have a smaller aperture, and
the checks during domain attachment will refuse if IOVA is to be
mapped out side the domain's aperture.

So if someone mis-uses fixed mode and gets a domain with an aperture
that doesn't cover stuff they mapped then domain attachment will fail.

It is no different from mapping something before domain attachment.

> > "automatic" is supposed to find a good IOVA that is the best IOVA for
> > that mapping. We have defined the best IOVA as one that doesn't reach
> > into areas that future domains are allowed to mark as reserved.
> 
> 'good' or 'best' just implies that the allocation prefers to permitted
> ranges over reserved ranges. then when permitted ranges are used
> up the allocator can then go to find less-favorable holes outside of
> the permitted ranges if not reserved. same as what FIXED IOVA allows.
> 
> But the behavior in this uAPI is that automatic IOVAs can be only
> in permitted ranges. This is a restriction on allocation instead of
> preference.

Again, it is not a restriction. It is just how the automatic allocater
works.

> IMHO I'd like this uAPI clearly defined as either of below:
> 
> 1) only related to domain attach then automatic IOVA can be allocated
>    outside of permitted ranges after the latter are used up;

This makes automatic allocation functionally useless when composed
with allowed ranges. There is no reason to do this.

> 2) applied to both domain attach and IOVA allocation which then applied
>    to both automatic IOVA and fixed IOVA;

And this is more complicated and slow, without any real purpose.

Jason

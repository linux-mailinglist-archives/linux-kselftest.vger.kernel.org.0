Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F09976DCC1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 02:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjHCAjA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 20:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHCAi7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 20:38:59 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C711211F;
        Wed,  2 Aug 2023 17:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691023138; x=1722559138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x9Ji+dCSv97hVWyMFbRibi0i/HZ8IXYSTgCjG/JZCa0=;
  b=kKcA6stV2Bj06CDihttsJQj/6/3IfiQvxblMxYRgdyVGgR2x01clttNR
   C6oLFyovDYEcA+0BBf/kedw1GVpR+h+L8TF51zOrBiOBsyf4e3SeDhIkR
   kqH6aK99W4YYOg6WAL+p8arSoP2FKyZSsDjr+6Jlpz8yLlWpWzIDtZJK9
   7+UyeADW3YrAhUOVrOXdH4Qqj2EHhak5LzHgh+I3qjlJB/1YhJxMeI7QO
   YXzy5iSGcZo/C2uE9hlmlfb5wXNNpV1oEJiTkgls/ykLHT8dWZo1A6Plr
   XCPt1JZIYrVzojtTc6H/umXjeQa03Rc8L1amqYOA8yRXJ6UfnPzvait00
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="359776702"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="359776702"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="799323200"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="799323200"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 02 Aug 2023 17:38:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 17:38:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 17:38:55 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 17:38:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ily8bq/cXD/BRw64LtPepsWQaMRHKC1BGfF43ghGViHzAyAjbG/KgD6gyiN1BWI43NdlZ6NOB0ckK+UcJocij7/BnxHGaZRARuVH+w5KPBMxZg3ZLRs0wJojoAjZNG+gSI3ChHwZnNYw1wVpKe7uRA51rUNDigeQjs7xFlAurItvz97c1bh8mWowjHllSKFyR1iFBQL4peVm6yq0UfuZqV4fpsnlvPZ1+51IxwrWp3q4YUB/VPsi124rJNXnc9pCA7DJrG48lbIgT2KfZfCcjSNMRom7UA4Jeliu13oHHmIPfgOGPpCoepRdrbyinLiRtV/aTbXyWy4SjALhfEVLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYypAQ3lfcV+OKrZMH8Ufl+7sAlCk7JBJZTIBiqzn2E=;
 b=hGKXO6FD9MdOrDe3/4LT7zJWS4m4f5AhneYXTZfgXqpXKefsFRpt1GGDWQ7l6/hLXjWzTb0IoZ3dtqTer+mrwD9eaGF0v20QKY/CF0ZhXGIK+mYCK359Ytube8BpoCLqVlLoL6uMPQ/DjjwjaqoW4fGIF2wFILEZPjxbmHwIM6spojSFF+CFIgQVUgOBtY1VLR6TJFFGTHz2NPnnsm8j17BqCXBMgLFcwzxfb1cgcndQTA4wHR6zgZVJIb7qNyH0hwjp2QXv32COmgm+MGw0eRZTOFNN7al4hAcTMBQSxFaUacm7QBA1g7FuC8ZDUL/6yC6cKqHdIqJmSCRxsUFCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 00:38:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 00:38:53 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
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
Subject: RE: [PATCH v4 07/12] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Topic: [PATCH v4 07/12] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Index: AQHZvh/vvq7opaI5PkGCKntULu5FEK/WqARwgABrnICAALSPMA==
Date:   Thu, 3 Aug 2023 00:38:53 +0000
Message-ID: <BN9PR11MB5276035683CE2AFB7B0F36D28C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-8-yi.l.liu@intel.com>
 <BN9PR11MB52763681308D7950A51E18438C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMpei2/CffaW97iU@nvidia.com>
In-Reply-To: <ZMpei2/CffaW97iU@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6819:EE_
x-ms-office365-filtering-correlation-id: a9ade4b9-4b10-465c-41ee-08db93ba03bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cK7JF1QkD75i89XfObkkrvLM57GGANmNxKVTBJu9pHY0SmWX5I2YTEURmD/bEdbvhyuD+swq/qm9uO/LHJVnb7CpLnujXvKg7pYV72Dl+KO0IhhxlZ0ltoqFYwcEQEQen9yZiqNGKdVi8KpZwKIDrCyUzwdwQZGN6+XiTDDUm9lfgIDArzsXUskyVD+yHzwLvtOboIP44USS2t+wUg9Ls3yyoyt/UZsteC1coPbNOFGoWoseiHIMmSIrRwEAp4ti2S4lB8OHBtrNcBpI9zNzhjhKMBJH+LWAC1YHmNms1rHZs+Q+5eQfSyWmrNqYc53C7tNqfA+pdDDGEohzl+qx2dWZ3bhhjqAtLkiu8ilciQ15uDL7moB+npcuv6hhXmgo6wFW7T0+2Ezvne4dvABNm/V6kpIdYhtgkkv4lnilp9wmVJnGEcQScL766+eyykg6qNwndn0Osb4MmNp8wuu/8bOl/oCHfECVeNXdckHcXjQv1Ufec1x1LodQZxCgXDiN3OuT3sEwwR5kAO8APfKdQeVmLdbHVjqSOiSM+wmBXRTmR0DtPHE+6ANj2/xzhsaQKnOAFvdqHs8pKNkpSuCDAxy0EflK0coqa6y90GXo/3r1zXj54pV5DmkUJOsXLQjt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(38070700005)(33656002)(86362001)(66899021)(54906003)(478600001)(38100700002)(82960400001)(122000001)(55016003)(186003)(26005)(83380400001)(6506007)(41300700001)(8676002)(8936002)(52536014)(7416002)(9686003)(71200400001)(7696005)(316002)(6916009)(64756008)(66446008)(66476007)(66556008)(5660300002)(4326008)(76116006)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MM7CdgXEzX/yWJ+xBDGmjQpa7d3jRJlJ10DzCsUpdEtwcv9hq2TV7O6yBwtT?=
 =?us-ascii?Q?LWz1GLL0HbGmp/9M2BayhNYWih2phxQHQ5JJ19kPVlyMI8KVD0Kbz1hgyHTo?=
 =?us-ascii?Q?r6q5M/t6Cmosgw+J/L/kgYQK678uo9fUdUju26pqeZfQL9EfM0EW9AnsYEUx?=
 =?us-ascii?Q?L85159jvy9EoiGnXt6KPZGAeSyss1RQjj0oy/bGmNMJPxMXydUWQFZjGgYWX?=
 =?us-ascii?Q?4CjGqIYd9NfHIZMhigUpb+GgbVxaXg10YtqST2zoMsUIxH9OzkYKHvxXSj0d?=
 =?us-ascii?Q?9zzfL7QlKukmLf97Z7xupl8cR/cM4ndflxey36ubn9dTafTOKCETJbDRjT6O?=
 =?us-ascii?Q?3Th0vo6IxguqLp198uAOP+NC7+q2BjzpgGHy074fpi5s9FD/9x5k7cw31bG/?=
 =?us-ascii?Q?F6M9BuhIqynUtgTwSNcP8Doznk8EwGGLOXj4ytGkDlHg1DJVwtm3RjBjCsnw?=
 =?us-ascii?Q?9zWNc3ipuI37JiptAv3x/w5k/swRTEvBPeaDYRzLmhQh+vERIHL08wr+D4Gv?=
 =?us-ascii?Q?U6P8s1gnZ6zi5TyL1y4uc9W0o7R/LtWL/JUeOuTUcB73U3RdoK2Xl094RBKK?=
 =?us-ascii?Q?k4DZJnbJNBGECHXCo1rzDnIxZFqv98nemr8TWZ8sPA6/bQ6sIQaYuwt1Cufj?=
 =?us-ascii?Q?sAkH2Q+SnNDO480V49pwn1OY2CdGnPU6Qj/Q+b6zxR8paquQL3tWzYtxk6q+?=
 =?us-ascii?Q?onl5Uvdxbm32/kBEQqcRkDeEGd/RfDy8r/b1VIjx3E5zXo1imXp4Qdn1aKfS?=
 =?us-ascii?Q?KiSL9gCajV5EfprS0RqWn1NRJrK0tocsY7MpRSjeMJMKOyNn8Uv/B4ZlPQei?=
 =?us-ascii?Q?hYSfTXBzl/RA7MA1Mj2xN5jbGgIRG9H2jUj5twZsoEsOAtug1QyedWAKNPoE?=
 =?us-ascii?Q?14lWBsGX7THrGiVwPc9NSRFAHoVxL2xSkKPKDCX3Un/gBKpEZVVXIHK89lU5?=
 =?us-ascii?Q?FQSng5t3bXvmBNgd1VshKyLyb/PoKByXxl7Gd8sxNWqndEk02jsLTYCa7l+7?=
 =?us-ascii?Q?ZFyYlX6oc82kt6sbn6M0M3NaCPwsmNKtAWNYjlqQmwRz5uTXKtIAk5Yx3clW?=
 =?us-ascii?Q?35jLGVLnPgY9c9CcCFMyse96JzjowO4UqI5k+6FtpLFXL3d1aURIbye5fV4x?=
 =?us-ascii?Q?L6aRF7zj4LwR0fcH5tCda28fESZYH+ZLuUIaJMgdvWm+HXK9TqotRMy9o7vO?=
 =?us-ascii?Q?YQBbIHfkooBfGrvGPO2T/L8g+Jog7EpJxyMfrOAfIE6mMPboNQWgnj8sEC/9?=
 =?us-ascii?Q?oubQ6qThPPIvBBoKskl/bKsq90wuPyKR6TNPkT7JD0ZxQTyGLrTMdj0F9hW4?=
 =?us-ascii?Q?phWh6jzop2b0M7QCiuLfh0RSaKFFEt/QuRyE4SDdg/PBIw53CdSzy6l9MtB6?=
 =?us-ascii?Q?iWHsbCDvBHs5b1oHjhllI8Bbm4fky4iXBtUMkQoPDJ7RKbdah4dlGp6cYhO2?=
 =?us-ascii?Q?matS1q+aXiiNL0/OIYsVtcOocmK6J0MyAK2Om0OkGa9NGwRLK54ILw4sHUCx?=
 =?us-ascii?Q?GYztJ4OBeHy3gK9nwbFHSt1vRgtwNso/2tmpWY12sZKkVplZ363mhF6Ags1o?=
 =?us-ascii?Q?uwXz67DyUDu8WtYHsph07jORQXp7SyqKNOHSuKiy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ade4b9-4b10-465c-41ee-08db93ba03bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 00:38:53.8437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfH5YkoKc9yo8oAMiWM30Q2abKHBAirMBgcm9reqJNU6Aa+9Q2Bm15IrvI0H6qq0sDJplGByIve/I7q7MkpoPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, August 2, 2023 9:48 PM
>=20
> On Wed, Aug 02, 2023 at 07:41:05AM +0000, Tian, Kevin wrote:
> > > +/**
> > > + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidati=
on
> > > + *                                       (IOMMU_HWPT_TYPE_VTD_S1)
> > > + * @flags: Must be 0
> > > + * @entry_size: Size in bytes of each cache invalidation request
> > > + * @entry_nr_uptr: User pointer to the number of invalidation reques=
ts.
> > > + *                 Kernel reads it to get the number of requests and
> > > + *                 updates the buffer with the number of requests th=
at
> > > + *                 have been processed successfully. This pointer mu=
st
> > > + *                 point to a __u32 type of memory location.
> > > + * @inv_data_uptr: Pointer to the cache invalidation requests
> > > + *
> > > + * The Intel VT-d specific invalidation data for a set of cache inva=
lidation
> > > + * requests. Kernel loops the requests one-by-one and stops when
> failure
> > > + * is encountered. The number of handled requests is reported to use=
r
> by
> > > + * writing the buffer pointed by @entry_nr_uptr.
> > > + */
> > > +struct iommu_hwpt_vtd_s1_invalidate {
> > > +	__u32 flags;
> > > +	__u32 entry_size;
> > > +	__aligned_u64 entry_nr_uptr;
> > > +	__aligned_u64 inv_data_uptr;
> > > +};
> > > +
> >
> > I wonder whether this array can be defined directly in the common
> > struct iommu_hwpt_invalidate so there is no need for underlying
> > iommu driver to further deal with user buffers, including various
> > minsz/backward compat. check.
>=20
> You want to have an array and another chunk of data?
>=20
> What is the array for? To do batching?

yes, it's for batching

>=20
> It means we have to allocate memory on this path, that doesn't seem
> like the right direction for a performance improvement..

It reuses the ucmd_buffer to avoid memory allocation:

@@ -485,6 +485,12 @@ union ucmd_buffer {
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
+	/*
+	 * hwpt_type specific structure used in the cache invalidation
+	 * path.
+	 */
+	struct iommu_hwpt_vtd_s1_invalidate vtd;
+	struct iommu_hwpt_vtd_s1_invalidate_desc req_vtd;
 };

I don't quite like this way.

>=20
> Having the driver copy in a loop might be better
>=20

Can you elaborate?

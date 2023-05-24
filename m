Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E1770EEE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 09:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbjEXHDx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 03:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbjEXHDK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 03:03:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A6DE71;
        Wed, 24 May 2023 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684911779; x=1716447779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8YR1AaJI+CbhBZnMT+CVlXcINWu/h4KHdOyQ6N4/Fxk=;
  b=Hb+zOYO9CaJqwnX6nMThd8zMgpXl5CGkZI4gl1MhYdToLJb9xt+KTp3S
   R6eEegdtElaTKShRT+PW9ko6pVsW4VfWkWIvbS5VESzlQ+YtWjm3NDvdE
   gks2/Yr88vTNXhCS49PWjmqcD3pR+sqmGbUMEq+ChJFBTk42kVxyZVR2V
   +274eBf731SY6ZlDmO2WaPIf3u1z05r9gPd0OGVJMxFNxe4SsYM2/1FJn
   rZIgHm4/c0elX4elKrpGmjMbOmvXkecte6tGVt8H2y1qV7lUtXVS8yZbs
   vlu7xyoQyEJ1gqkFYH37U2kIqcSv8t4+cZacfG7kdzd1JxMi8ZbI0UwtI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="416941340"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="416941340"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 00:02:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="704223169"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="704223169"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2023 00:02:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 00:02:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 00:02:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 00:02:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 00:02:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/LdUTZeOl4dyzpbNFSv5ro0315MQzRYze/99yA8mMJbLyZOEJHc4FofDoFPZNct8rzyhf+S6++0YJdhji1PlTOAOZudA3s8bAYqgen60laRo3AyzeTGIb6xfo/ZoAD/fQ9PX3F7GKEU/H860eLak3ZwVwfmXT5DlN/QF9O2Byp4NO1+WMlOV0rqpYJfZlIAnx62QZiBwomNleGcGh3lmcOgyGl89Ew9Ewk7rslPQtuYNUN38+0xN/Xv4IFcQIWLJtry9zlvbIuElPgI2XPhw958r4JGi22nV4fQuAgH4XE3WbJObaSgnjgDw50QMcMAEao2CTHiaSa1cD6LyznTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Db7WtfVJ1FdA/yv18bA+rdzPa28gjFJatC/XFEBa13s=;
 b=Uzy8WMcR9O63oZUwOrHi3r2/83U6SyQ7l06a48Y3kSq+BsURVB4+WOIWXNUEYjEE6Ra1u8dvpQ0fQL/AvvvGKaWt7F6UVjtfpv7UvwJCIiQiLaK/BY+qb/XaRWIz9P9ZmZN2SYRzi0VpyECiu8eQ23oihAe9P5V7FN+esb5hGoucegRtayW0lQkGCKGS16tlZG5xpdEjYssSNV1+/x0rz+NW1IKr+K2CqGaqcTj3q+ZWAf6vPAK9Ce2UidVB7wFiy7V1qPoMCCFWIEvmgtk7mLaXwjZ+qJKZwhNAxc8qT7z8a9XC6xO8CofXNVJZgHdSzGylOgYzrx273b7UrK3w/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB6046.namprd11.prod.outlook.com (2603:10b6:408:17a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 07:02:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 07:02:49 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
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
Subject: RE: [PATCH v3 02/10] iommu/vt-d: Extend dmar_domain to support nested
 domain
Thread-Topic: [PATCH v3 02/10] iommu/vt-d: Extend dmar_domain to support
 nested domain
Thread-Index: AQHZhBgRaW0ev1K/f0ecMKxl7/WhJa9pEs+g
Date:   Wed, 24 May 2023 07:02:49 +0000
Message-ID: <BN9PR11MB5276AC0968EE3A5DBAD0E5018C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-3-yi.l.liu@intel.com>
In-Reply-To: <20230511145110.27707-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB6046:EE_
x-ms-office365-filtering-correlation-id: 9233bee3-b858-4bdc-1887-08db5c24e290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GlMaWLs5r6n99LMqSt4mUO1rIOMojavNGZDzLDz1rUn2DNjhVgRjCeEEpPvbl2l8GGZdy6xrdqgi4n/O+Xd4ieHKoPtVyzPHB/Wj/5YphMaT0gtsZhLZ0cBMwg7NEw+dq4Tk6KYKGxkoAGEpPyFcYpH85BiXy7DnOmCYaphFXEY69KcxdEYkz4pSRZA03DY9bcSS1pjkxWbHYN0lalANNme/miSOvzjR9hpnEhcOmw1xyNX3xc1bvVIjKS+JkBE8ksF6KKuLyBzL9/J1uovR8zg0ndxikV+ZbDD4/qbjBektdlmAceo699za5BzI1VtS5PvXT9mZgRscKCHkgtnZXE8d2+W4VSOVfsvmAPk5bu6z+3ySyuYJPyClPGLqyyzHP+42y/ZxaEj1G/FefqCAaOzbVXf1B7aT+o83n02zL9I2hwKluINM/4EGLAPENEnuBLHZhpbLe7baa0x5EemvO6fHmBlH1SVO3PGyz6jgmf5yN27uSUGVokVBOo/Mp4Z7QAZLkd0GRYbhNtHHjbdKIOf32I/D3GCF8vv3zvcbZSm4dPgSHwqAMw94kkwMzsZknd0pkkh/Q3x/SbdfjJLQcuMRlmY+I/iGT00LThAv9+R1rqCPSS/w7365ZPvY499Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(8676002)(186003)(83380400001)(2906002)(7696005)(478600001)(4326008)(66446008)(64756008)(66946007)(66556008)(316002)(41300700001)(76116006)(54906003)(71200400001)(66476007)(110136005)(7416002)(26005)(6506007)(5660300002)(9686003)(52536014)(8936002)(55016003)(38070700005)(38100700002)(82960400001)(122000001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nY8NGBwdP+vGci+QvsEtBUAUbt5brPUnzYtZ/KXp7K174jxkGR/yd1IMWZjJ?=
 =?us-ascii?Q?neWM4R+eEehj3f2y2zIB/nkzLGPHgC9dVK5U7ne++zcJ6OU7dEw6ZqMHQwBK?=
 =?us-ascii?Q?aLg6TJkmIErDxir29sMkxGuvO7P45VRLk1GXUPao2kh+qztoS0pA6I3hrG4Q?=
 =?us-ascii?Q?BKePNclltJFPHJGDeM83CQwS/XJIvjw2c/RUCLDrXf2B+doyh5ECEn2ZExyc?=
 =?us-ascii?Q?60b0i20R4cAz9syW+czjYOpCmH3wrppFf6FmB3oDBLmei72jTPu8WmQEchOZ?=
 =?us-ascii?Q?BRQM+lP4dJXuWfknGXV1fgzhWHJL6XpeGpaSPDxiQ6P9tP9pYMFg+uCtKRXs?=
 =?us-ascii?Q?VRcerka+53D9GePJZ3/RcSF7Hne/iI+zTBsU1xXw8VSBrjJUDX1Ta0gsWkbq?=
 =?us-ascii?Q?+84N2k37KGFAcnBySnAzXALSJE+yoaHLBz5DX2bl86luGEbuf5Jylu8GSj7s?=
 =?us-ascii?Q?TsgTKQrLvQkbHWFFasGnOsXFSiWsdVa5CI8TWWPJ14zH3VB+AqbnZblGb1QT?=
 =?us-ascii?Q?TApCFYlcO7MTtv2yGExnS9SvT9YhyY+8C05f/H/A43hj2bLATPjNdTsOBnAH?=
 =?us-ascii?Q?ig0f42BBR82HRDuIxa0r9zIkUb2zXTM6Kfm3UF6GvxnOCZJqBHa8UUjIul5r?=
 =?us-ascii?Q?gzUdfTCwCjljR2oD43BaM8MpXxOloyJt+D6IwJBHHIlYQmMnR6jZBRHXHFkw?=
 =?us-ascii?Q?YJjzF2soYE7ultyifEHjO99ymVP+3ZwkojbO+MwdTKKfECcX7rpszUUTUMPV?=
 =?us-ascii?Q?RK8WS+PBBI0x0hGUrHEnpQMZ28p9hiAm/3wQEYEew3a4ERMWr605CDYhUOTW?=
 =?us-ascii?Q?uvecc55m2KbuNodw+GprnForCG+tqb6pv4XdVqgAOh6svJQ7IKtBR0jopG9v?=
 =?us-ascii?Q?zRskw/vrdDdAH3StsYUt6+bfLyBCGqagEcfuYz36QUXEEGhhPoY0u0zYSvCj?=
 =?us-ascii?Q?a1XKzVP3e8Cv3gVk8lB+eucg5byFRyv7RPzOs1oZfMjaPUP7eHSXM9e3nEbL?=
 =?us-ascii?Q?bVre6Dnj7MfTw2UutLUoyffNsYCMd1GDwiKZ8fqoATsuADjSk2XTzrLTs9NZ?=
 =?us-ascii?Q?nv04WqQzCOLSM1J56YWoKcyrYjervEYGBTzLlm6YLGBADqxHBU1FFwgHcUg3?=
 =?us-ascii?Q?4zTY9OqW86K56RM2tyEdSQbfkLH/S6RYJfd2V7w4WmY17h+Q8hwz9C3ZQldh?=
 =?us-ascii?Q?ejTOAESGRC3tv/1CBfnEn1XT0N1lNWzVcGwKKLK4RNfoLmhKXFYjpMAX/CBA?=
 =?us-ascii?Q?qYwJeA/P0ZEWvMP3AQ1yaIhwtp9snXI7k7q4NrZ5unvZ+4RJXhl2LIfJm0Vz?=
 =?us-ascii?Q?uEDgYR/QUiViU27d29r3JMHRqn3ZhhpnI52G42Ub6sr3NyqdecdlI6xhrWSv?=
 =?us-ascii?Q?7mcuF+4MH3Jo+D9W3SDycGtDdCkc1EOrwEouk9B5Rf68e5RN410V4HHG+OCp?=
 =?us-ascii?Q?0WMjQQ72nrp0J/OxW6PbbqkDp99bxBimfjoiZvy1YJ5OZEzbp5ezIlIxCoZt?=
 =?us-ascii?Q?kwe/B+AzIKwAXaWnfXNlaKOERXdKTdCT67xrSudx34/ABjRpq6ecmYkM/9DP?=
 =?us-ascii?Q?ZsNYjjGAjwvL062ivM3oYo89B7GlbANCSpw2/xzS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9233bee3-b858-4bdc-1887-08db5c24e290
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 07:02:49.2558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qklKaVlLk3M57dkky6gxExZdcBQCeTcvHh4lfepXmITAh9gfuuMbIgycNelX5GjC0xIG9qXcLCF/Phphbo3TNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6046
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, May 11, 2023 10:51 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> The nested domain fields are exclusive to those that used for a DMA
> remapping domain. Use union to avoid memory waste.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel/iommu.h | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 1c5e1d88862b..e818520f4068 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -596,15 +596,38 @@ struct dmar_domain {
>  	spinlock_t lock;		/* Protect device tracking lists */
>  	struct list_head devices;	/* all devices' list */
>=20
> -	struct dma_pte	*pgd;		/* virtual address */
> -	int		gaw;		/* max guest address width */
> -
> -	/* adjusted guest address width, 0 is level 2 30-bit */
> -	int		agaw;
>  	int		iommu_superpage;/* Level of superpages supported:
>  					   0 =3D=3D 4KiB (no superpages), 1 =3D=3D
> 2MiB,
>  					   2 =3D=3D 1GiB, 3 =3D=3D 512GiB, 4 =3D=3D 1TiB */
> -	u64		max_addr;	/* maximum mapped address */
> +	union {
> +		/* DMA remapping domain */
> +		struct {
> +			/* virtual address */
> +			struct dma_pte	*pgd;
> +			/* max guest address width */
> +			int		gaw;
> +			/*
> +			 * adjusted guest address width:
> +			 *   0: level 2 30-bit
> +			 *   1: level 3 39-bit
> +			 *   2: level 4 48-bit
> +			 *   3: level 5 57-bit
> +			 */
> +			int		agaw;
> +			/* maximum mapped address */
> +			u64		max_addr;
> +		};

what about 'nid'?

> +
> +		/* Nested user domain */
> +		struct {
> +			/* 2-level page table the user domain nested */

/* parent page table which the user domain is nested on */

> +			struct dmar_domain *s2_domain;
> +			/* user page table pointer (in GPA) */
> +			unsigned long s1_pgtbl;
> +			/* page table attributes */
> +			struct iommu_hwpt_intel_vtd s1_cfg;
> +		};
> +	};
>=20
>  	struct iommu_domain domain;	/* generic domain data structure for
>  					   iommu core */
> --
> 2.34.1


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F156568E98D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 09:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBHIIv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 03:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjBHIIt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 03:08:49 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B90EE055;
        Wed,  8 Feb 2023 00:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675843728; x=1707379728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rrqMlWQs85vqeDja4+jUqsk03J4y0d15CymSpZ7Fpyk=;
  b=B89KXK1a1OljMFTy/9VEcEDbQW470xgNcmkDlW9C+VHcxq9CJLLwYzZy
   lr7fNUnb8UlApolHm4dJH1UnewHjau2rDky3Y2wXxNEAIIA9shB0l88Hc
   wV13ACGcwZE4LDCq3AgUnM4TVBgHJ86pOribHzhVBcoTS1aWTuZIY+O4R
   4ZVk0lrvRyc8MwixhYUP47YR5oDCC68UICXz03CmGlS0qLJqV0PZMZ7sy
   7Ku7o4itAIQGmVS7u3uLFyqZsMr9Td/0mZWlfeDzG1i6/YZe0wg3BQdbZ
   mcg+PoS3H8X7XrUCivKh3Ta9rAlabwY7JVhgb1g1HZOgnMyIJacOj6sLi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415960154"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="415960154"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 00:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="791110234"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="791110234"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 08 Feb 2023 00:08:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 00:08:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 00:08:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 00:08:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 00:08:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nx1OanCq5gPDQMgRadG3ukWYENxEN8nWk6Sn306INbZGqW8k0yQ9PIixRQSwlfFo3gWa8CYV63+JpvZYNQh9eRkiZegA5Su0nWjiXDtYXSNAnMW6PiVVhFU74hENmhjicTLCeK4APhxWKYotJKSrf+aUDpXyvvoBTUFE13+Hztdv87mIpBrZZKKIzdopmPiWvKN+wgwq3jgBn3utoHeJ05c0A+KiOjFAD4hA87v1VFKcX7jPKk62TcWyOaDcXdKN9aKtE2opNNeQNpG/HygLmIkwwWRAZAWaqO2b5yVnhBaIjBOYNe0lW3fhWMlAlS03CgiZEgEhgULH1eET0tVBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJyUR5n5lgKeAtiQrcDQgz7Fc7iYR1kI5KR9eY3b5O4=;
 b=TqOiuMPwPgc9Y+M/x8M2mIze6jlNE8U4ij1NAR8pAbv16whg96tyQiD0+NiWNPu3+gGvCtUC32SxdouI4a/K2nE83f8Nvpc7pUjNk7z02hHk1qrf1cItCG7a50zPMUjSEJsN/MtHymBXapWRndShzyWpUKbhHUXo8iNet1Xq+YiNDmwRl83wRKAgdgGdIrEJHVe9M7v2T9kiU/O9ZY/fv6X40Kny3fed3khv9j1EfW+12b0SyuLsxs/GiJhGSjjLddlRgvhZutAfGkBhJakLgkh3x0qiSxiX3F0SuiFQnu1uIEPupv62SKZXDQB0YRzzoJlkG81BXaFN+10UQJo3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB7486.namprd11.prod.outlook.com (2603:10b6:806:314::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 08:08:43 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3%3]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 08:08:43 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Thread-Topic: [PATCH v2 08/10] iommufd/device: Use
 iommu_group_replace_domain()
Thread-Index: AQHZOzoWMUUVTAZYTEmJ999vMYX83q7Epfqw
Date:   Wed, 8 Feb 2023 08:08:42 +0000
Message-ID: <DS0PR11MB75293887741EEB8953BCB0A9C3D89@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
In-Reply-To: <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|SA3PR11MB7486:EE_
x-ms-office365-filtering-correlation-id: 10277c2d-4777-4352-c322-08db09abb1be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8lThTs3JKhidGIdTWBFShBqKObDkAn1tnil6acsKWTXaRH7QK/bCcjcNqlVjwxPHcS4ruL7pHiRXoazCGZxvedzHiimkFh1aW8IK9YpG6r06hkPGWVvuO4S+2PEtp/ksXzpTSgDSPtTrH54lgfCu7xHtEcUbDiShcb9+HH3YVCLesTSiS27V+++l81E7ziKBwRH8RKwPXGT5j8kGOVkBjyVqWG7VNvwqVyWUMq+w5Dq7bvG/zkF4DeQmAHsfdnW6Ex/X78XFXsovQeCdP6t9H8k+/j+kVvjaLM9h64tPUcpKyk+Xc6nNbPUzkjcQXqJ6tBvRw80uEyH7Lgo0Z80M4ax7iueXepRAuaKlIQw8DegqenHx1zTw+g4fnWkdGJ71oWhncfLs6yzAfeCEZlgUHh7FcYacwH1SZv1jXWOObFckSc9hFJS6FVFOxnymr5LNt8yQ/RuabSRhccylZsAtRa0lNUmH3seDYcgx9w4HpNkbafC11rtyEGrsW1Ydd1HG0Z6QMoQfCU7e6ZSo7rtoOw5M61cAzQv8ZIwg+ajTFgyBGHN3LDybMgh0spPNu45e7Ul+eIvt8sw0JhCYNG0Mn7Rg/iZ2YLFY0V5JmnCwxd/ySAbqFLHjPgGUK++YH6VUdoFm+Vdbr/GLyHu/SpVJWDXXaLFGfpH5+PbzDIABN0I5For4bRUnt44Izbrc7Vi7MYBR9Ol/1nkmFmWmTbbZvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199018)(6506007)(8936002)(52536014)(316002)(9686003)(186003)(26005)(38070700005)(55016003)(33656002)(71200400001)(2906002)(83380400001)(54906003)(5660300002)(7696005)(110136005)(7416002)(478600001)(86362001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(41300700001)(4326008)(8676002)(38100700002)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YYhwUxixkdIMELqTTUTlvqQCWYeDdgIrLJHQn0oxgK/jUY033HkANy8erAz8?=
 =?us-ascii?Q?HX4S9aLh7wtg7qel1inkqYKHkZhCcy8uQtzfj/ja564EAQp4pEzKCw9XkaLt?=
 =?us-ascii?Q?PufMnRy1CVlu5Njq0FBvUZ89XvPgKXOya2d3NOmtD8+tGJFBfvdCZ6APQRxH?=
 =?us-ascii?Q?Msd116euBfgnfVEzjZ2W/569wW+u//C4m8yDA+oZSa2LUlJ6/dwuYjxrJ0qp?=
 =?us-ascii?Q?NPD+noUqhQ53Sdz1g/ATfETJ94h+hBOKO7pfnGoeVZRqLz8xfhDu0RH8OHXs?=
 =?us-ascii?Q?o9NVp16jevn1XVqkZVf4Y0hWUVE09ntfnBfUTuRqlJE55xL+SoJ7gWdAxHRn?=
 =?us-ascii?Q?o6eSZbstqFlCVhvAgF2UmbvLXMaishb4hWPAXhWeAzeOuBNfvF5FHehBYZ6W?=
 =?us-ascii?Q?ZT5LS77GAiNxFKN/Qw0zWJafZcda1hXGPSPuqPgckxv84QoSrVqZ6otuSfZf?=
 =?us-ascii?Q?k2RGaXmzu+kzoqN9QqA7+G/h8YEQjFJvJ4F/xG90dqJsypHiFFpNkc2vBION?=
 =?us-ascii?Q?HNGZL6vM4dZTbLd8F/zSg5vxsN7BkD+TOCuiIOYbJ+eV/hKViJUxdx51bLQu?=
 =?us-ascii?Q?fuWnd+VkSerKXbCG9sm+j9wvRZQK81P7jWznxMVrqnFxzTaBxmryy10nv5CG?=
 =?us-ascii?Q?gd+ahJgDFQD39cyhq87OsaKjsFg9hu4UCo29QKM1EkYr3MXt+wNWYT7kN4WH?=
 =?us-ascii?Q?3XjcZ5vk1kml5CPolANWwc7EQ5rBrYEb0jD+gpC2FmIWA4MR6VQwMpWcuAbc?=
 =?us-ascii?Q?0rcj2R6+FEekWmorxdApeq5YXQSqr2PoNngr9X+IxF80sTjplHpjsiKsaeMw?=
 =?us-ascii?Q?pdSN9ztyThOUHwTHOKv4CEQ660EP6MY9PwDj+F9jAZ0/Xc3PhI9HaypRjwQZ?=
 =?us-ascii?Q?osMUcd4OJDUSiuDBhPsnBO2/8yR0duxbaQWm6wmuuwhitldNeFABdaC6leiq?=
 =?us-ascii?Q?6rkPg6xdYfuwDDd86wk4+tktCKVuX/o3Y5jytOoJ/hsoz/9GzdpRSH3K46SF?=
 =?us-ascii?Q?NP4Y8bGTBiLT7DU1j2Xq12z5UTMEEode/grnox3QyP7ir/nWwx016lN9+oc5?=
 =?us-ascii?Q?Yo7geEaxKNr4ENRVzJTCPQmNQB6GabE1ZadcSx3hd9moD/irVWsMgUrSudFs?=
 =?us-ascii?Q?mHBh+ftOMtk9S2q2b9XjyCAFZlhkqmUczrCEoVomnBsg5sRDOu3jzhUHKR8m?=
 =?us-ascii?Q?khXzoe9gLLliUkg62yiYWt7ckWaWoMleSnvgMZ8spzQ4cXAFmfek6l15r8B1?=
 =?us-ascii?Q?5TUX71wo9794tAoJa8dz9y952WzaodGyr0HmVX8iYlJOnYPLic4MfdYuOVOJ?=
 =?us-ascii?Q?VeYzz/YK/BxYM3zyvbGm70xOxttq9sqZS2hZc7ieGyXVYTWoREOM8j5djRla?=
 =?us-ascii?Q?FSgGNOVRIy7WINxgVGHa1WVQtfnj4pBC6ZIFtnN00KxMkQ1PSXJac6N334vg?=
 =?us-ascii?Q?vHwH2rLUowG6hZOgUdCe0HqQJHO0npAiJ1L27RtG2f1jviGGUkXAELov/Rtc?=
 =?us-ascii?Q?YiX5uPVrC1KoTKTN7K1E/T7k6T2hupo0jsq0OJ0lEnoy1TfN3IsejBo8TcUa?=
 =?us-ascii?Q?a0Btu4njclm4jEE0WL9L24LB1X3vO9yaHyCxr6Qs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10277c2d-4777-4352-c322-08db09abb1be
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 08:08:42.8715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFcFOYluYwfONfMfyA5QG6NOXAt29hQhiJhAUkeFWJyTE0hQghs0adIncR5XWw5q/95Wy3mhdGrC99YzqTWIwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7486
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Nic,

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, February 8, 2023 5:18 AM
>=20
> iommu_group_replace_domain() is introduced to support use cases where
> an
> iommu_group can be attached to a new domain without getting detached
> from
> the old one. This replacement feature will be useful, for cases such as:
> 1) vPASID mode, when a guest wants to replace a single pasid (PASID=3D0)
>    table with a larger table (PASID=3DN)
> 2) Nesting mode, when switching the attaching device from an S2 domain
>    to an S1 domain, or when switching between relevant S1 domains.
> as it allows these cases to switch seamlessly without a DMA disruption.
>=20
> So, call iommu_group_replace_domain() in the
> iommufd_device_do_attach().
> And add a __iommmufd_device_detach helper to allow the replace routine
> to
> do a partial detach on the current hwpt that's being replaced. Though the
> updated locking logic is overcomplicated, it will be eased, once those
> iopt_table_add/remove_ioas and list_add/del calls are moved to hwpt's
> allocation/destroy() functions in the coming nesting series, as that'll
> depend on a new ->domain_alloc_user op in the iommu core.
>=20
> Also, block replace operations that are from/to auto_domains, i.e. only
> user-allocated hw_pagetables can be replaced or replaced with.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c          | 101 +++++++++++++++++-------
>  drivers/iommu/iommufd/iommufd_private.h |   2 +
>  2 files changed, 76 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/iommu/iommufd/device.c
> b/drivers/iommu/iommufd/device.c
> index b8c3e3baccb5..8a9834fc129a 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -9,6 +9,8 @@
>  #include "io_pagetable.h"
>  #include "iommufd_private.h"
>=20
> +MODULE_IMPORT_NS(IOMMUFD_INTERNAL);
> +
>  static bool allow_unsafe_interrupts;
>  module_param(allow_unsafe_interrupts, bool, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(
> @@ -194,9 +196,61 @@ static bool
> iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
>  	return false;
>  }
>=20
> +/**
> + * __iommmufd_device_detach - Detach a device from idev->hwpt to
> new_hwpt

This function doesn't do anything to make this device attached to new_hwpt.
It is done in the iommufd_device_attach_ioas(). New_hwpt here indicates if
this detach requires to do some extra thing. E.g. remove reserved iova from
the idev->hwpt->ioas. So may just say " Detach a device from idev->hwpt",
and explain the usage of new_hwpt in the below.

> + * @idev: device to detach
> + * @new_hwpt: new hw_pagetable to attach (pass in NULL for a simple
> detach)

The new hw_pagetable to be attached.

> + * @detach_group: flag to call iommu_detach_group
> + *
> + * This is a cleanup helper shared by the replace and detach routines.
> Comparing
> + * to a detach routine, a replace routine only needs a partial detach
> procedure:
> + * it does not need the iommu_detach_group(); it will attach the device =
to
> a new
> + * hw_pagetable after a partial detach from the currently attached
> hw_pagetable,
> + * so certain steps can be skipped if two hw_pagetables have the same
> IOAS.
> + */
> +static void __iommmufd_device_detach(struct iommufd_device *idev,
> +				     struct iommufd_hw_pagetable
> *new_hwpt,
> +				     bool detach_group)
> +{
> +	struct iommufd_hw_pagetable *hwpt =3D idev->hwpt;
> +	struct iommufd_ioas *new_ioas =3D NULL;
> +
> +	if (new_hwpt)
> +		new_ioas =3D new_hwpt->ioas;
> +
> +	mutex_lock(&hwpt->devices_lock);
> +	list_del(&idev->devices_item);
> +	if (hwpt->ioas !=3D new_ioas)
> +		mutex_lock(&hwpt->ioas->mutex);

The lock order is mostly hwpt->ioas->mutex and then hwpt->devices_lock.
See the iommufd_device_auto_get_domain(). If possible, may switch the
order sequence here. Also, rename hwpt to be cur_hwpt, this may help
reviewers to distinguish it from the hwpt in the caller of this function. I=
t
looks to be a deadlock at first look, but not after closer reading.

> +	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> +		if (list_empty(&hwpt->devices)) {
> +			iopt_table_remove_domain(&hwpt->ioas->iopt,
> +						 hwpt->domain);
> +			list_del(&hwpt->hwpt_item);
> +		}
> +		if (detach_group)
> +			iommu_detach_group(hwpt->domain, idev->group);
> +	}
> +	if (hwpt->ioas !=3D new_ioas) {
> +		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev-
> >dev);
> +		mutex_unlock(&hwpt->ioas->mutex);
> +	}
> +	mutex_unlock(&hwpt->devices_lock);
> +
> +	if (hwpt->auto_domain)
> +		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
> +	else
> +		refcount_dec(&hwpt->obj.users);
> +
> +	idev->hwpt =3D NULL;
> +
> +	refcount_dec(&idev->obj.users);
> +}
> +
>  static int iommufd_device_do_attach(struct iommufd_device *idev,
>  				    struct iommufd_hw_pagetable *hwpt)
>  {
> +	struct iommufd_hw_pagetable *cur_hwpt =3D idev->hwpt;
>  	phys_addr_t sw_msi_start =3D PHYS_ADDR_MAX;
>  	int rc;
>=20
> @@ -236,7 +290,7 @@ static int iommufd_device_do_attach(struct
> iommufd_device *idev,
>  	 * the group once for the first device that is in the group.
>  	 */
>  	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> -		rc =3D iommu_attach_group(hwpt->domain, idev->group);
> +		rc =3D iommu_group_replace_domain(idev->group, hwpt-
> >domain);
>  		if (rc)
>  			goto out_iova;
>=20
> @@ -249,6 +303,10 @@ static int iommufd_device_do_attach(struct
> iommufd_device *idev,
>  		}
>  	}
>=20
> +	/* Replace the cur_hwpt without iommu_detach_group() */
> +	if (cur_hwpt)
> +		__iommmufd_device_detach(idev, hwpt, false);
> +
>  	idev->hwpt =3D hwpt;
>  	refcount_inc(&hwpt->obj.users);
>  	list_add(&idev->devices_item, &hwpt->devices);
> @@ -256,7 +314,10 @@ static int iommufd_device_do_attach(struct
> iommufd_device *idev,
>  	return 0;
>=20
>  out_detach:
> -	iommu_detach_group(hwpt->domain, idev->group);
> +	if (cur_hwpt)
> +		iommu_group_replace_domain(idev->group, cur_hwpt-
> >domain);
> +	else
> +		iommu_detach_group(hwpt->domain, idev->group);
>  out_iova:
>  	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
>  out_unlock:
> @@ -345,6 +406,13 @@ int iommufd_device_attach(struct iommufd_device
> *idev, u32 *pt_id)
>  		struct iommufd_hw_pagetable *hwpt =3D
>  			container_of(pt_obj, struct
> iommufd_hw_pagetable, obj);
>=20
> +		if (idev->hwpt =3D=3D hwpt)
> +			goto out_done;
> +		if (idev->hwpt && idev->hwpt->auto_domain) {
> +			rc =3D -EBUSY;

This means if device was attached to an auto_created hwpt, then we
cannot replace it with a user allocated hwpt? If yes, this means the
replace is not available until user hwpt support, which is part of nesting.

> +			goto out_put_pt_obj;
> +		}
> +
>  		mutex_lock(&hwpt->ioas->mutex);
>  		rc =3D iommufd_device_do_attach(idev, hwpt);
>  		mutex_unlock(&hwpt->ioas->mutex);
> @@ -356,6 +424,8 @@ int iommufd_device_attach(struct iommufd_device
> *idev, u32 *pt_id)
>  		struct iommufd_ioas *ioas =3D
>  			container_of(pt_obj, struct iommufd_ioas, obj);
>=20
> +		if (idev->hwpt)
> +			return -EBUSY;

So we don't allow ioas replacement for physical devices. Is it?
Looks like emulated devices allows it.

>  		rc =3D iommufd_device_auto_get_domain(idev, ioas);
>  		if (rc)
>  			goto out_put_pt_obj;
> @@ -367,6 +437,7 @@ int iommufd_device_attach(struct iommufd_device
> *idev, u32 *pt_id)
>  	}
>=20
>  	refcount_inc(&idev->obj.users);
> +out_done:
>  	*pt_id =3D idev->hwpt->obj.id;
>  	rc =3D 0;
>=20
> @@ -385,31 +456,7 @@
> EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
>   */
>  void iommufd_device_detach(struct iommufd_device *idev)
>  {
> -	struct iommufd_hw_pagetable *hwpt =3D idev->hwpt;
> -
> -	mutex_lock(&hwpt->ioas->mutex);
> -	mutex_lock(&hwpt->devices_lock);
> -	list_del(&idev->devices_item);
> -	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> -		if (list_empty(&hwpt->devices)) {
> -			iopt_table_remove_domain(&hwpt->ioas->iopt,
> -						 hwpt->domain);
> -			list_del(&hwpt->hwpt_item);
> -		}
> -		iommu_detach_group(hwpt->domain, idev->group);
> -	}
> -	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
> -	mutex_unlock(&hwpt->devices_lock);
> -	mutex_unlock(&hwpt->ioas->mutex);
> -
> -	if (hwpt->auto_domain)
> -		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
> -	else
> -		refcount_dec(&hwpt->obj.users);
> -
> -	idev->hwpt =3D NULL;
> -
> -	refcount_dec(&idev->obj.users);
> +	__iommmufd_device_detach(idev, NULL, true);
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
>=20
> diff --git a/drivers/iommu/iommufd/iommufd_private.h
> b/drivers/iommu/iommufd/iommufd_private.h
> index 593138bb37b8..200c783800ad 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -9,6 +9,8 @@
>  #include <linux/refcount.h>
>  #include <linux/uaccess.h>
>=20
> +#include "../iommu-priv.h"
> +
>  struct iommu_domain;
>  struct iommu_group;
>  struct iommu_option;
> --
> 2.39.1

Regards,
Yi Liu

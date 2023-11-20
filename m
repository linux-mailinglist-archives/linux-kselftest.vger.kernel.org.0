Return-Path: <linux-kselftest+bounces-281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C840E7F0D0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 08:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7450D2818E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 07:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375DA79EF;
	Mon, 20 Nov 2023 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5qY8F3N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D774B5;
	Sun, 19 Nov 2023 23:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700466856; x=1732002856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gXbl6yaNmYAygXQGhXABOZh3YttEfI2MJdn0fyfezOY=;
  b=T5qY8F3Ny6ls9leWEdHsqNrIuBBBOTKxXZBeyiDK/3ndSJ86pQTDXk0x
   Wu8vJ0PmJ/ADpXvPIEQqRCMJsULbUuMDKdWfRcwqK/LZ+NP79Yy3N7ns5
   ew8sUlLN9EXrN7pjx5NSIV6xFqpcVVDbIsXn3t1kiL31Eqx4wKz20t86T
   AKJ1FqF3TiabdDF0lQ6V1VriGQxS/oqphKhDFbB7b0kPJv1ZANv8+8MHV
   X3TwfCAHfCAPu7g3lWIdbPnTcTc58oHOKpSop1Iztr5nqG3LOW3iITUtG
   DsJ+a9hBWuE+H7vgEhjDhNzDeJVauFmbSchfxhZSaOZCFFmpmyG6yzDxd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="455892689"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="455892689"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 23:54:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="836660276"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="836660276"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2023 23:54:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 23:54:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 23:54:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 23:54:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 23:54:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYenpfr3qD3AgANwraQMQwLyydQ3OzD6YH+/4u0KgNiVRCRs4lMI/IAivf7x6hmmhv/DeiTfGmRJ/uj9xQEU8TC4Jlq/KaMdyf/Oe2AdA0GMOM3+JwjHQ+CT/Br5r3qXinJgWaEgBoU4fi1vs2ZVpG/WmoySqwibvyvWMS9sNKSpLfwxP5bmE2zpuCZNHemrKg/6k12O9oJK3AEesmx0Q45NB9xCU0Wtokb80x7HcBHJ9vpGceVV8Qi6AGvGQhnby+MRmB2P/0qqfW2n+pKD/s+gGxOANZ/otsjAIqHCcKLnU+hQGS2XcKJZxoGFvAdTJkGz6DEwMnwiGvcxJUZW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXbl6yaNmYAygXQGhXABOZh3YttEfI2MJdn0fyfezOY=;
 b=I66GSZ6XkHAH6VHq1aZGsf4U7sTMEjZHCgiehLwz+CosKvf1u6jhEevHiGiZZlpKjMeuCrIsR5x5JoadjVFd/tqQMSuWlZZBm9FnloGNPG52CxSRCUFA/2+iT6eGIuqFYlHA0mL7fb+VI7b0P5MLDKHC2KAOkrxjmFOvs9ePyNIpkumFa3N6TFZpYGYJfTi4t7I4wIbU9Cat4z3W8q9vZ4Sgk/TVmNuIVkGv4p0zDaZlufEKYWXffG3eCFILamTlQ/oFN9FT+Cdhu6+PCM2Ff64k0a8GKMtNXy8dWaPukqYyYrHBaCJ1yNGUVXSO2APBGP5qKAUBiMRL20gB7CJ6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB6742.namprd11.prod.outlook.com (2603:10b6:a03:47b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 07:53:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 07:53:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH v6 1/6] iommu: Add cache_invalidate_user op
Thread-Topic: [PATCH v6 1/6] iommu: Add cache_invalidate_user op
Thread-Index: AQHaGVcNayoxbcmcj0OdszlR/Hf6VbCC1vgA
Date: Mon, 20 Nov 2023 07:53:53 +0000
Message-ID: <BN9PR11MB5276E28A12D9CE3477E669A98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-2-yi.l.liu@intel.com>
In-Reply-To: <20231117130717.19875-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB6742:EE_
x-ms-office365-filtering-correlation-id: c073decd-2696-4c80-969f-08dbe99dd758
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C5wzHQsfRgQHQj4NAHkalmRGX8/Cqo2a1dxKXt3g4zrmmazbMDSOBEGqhLXNCgcT51bO4KVB4ZInox8atlhGCkrHPP/zqoLCLYLcKu4YpG9zKy9XrICe2PWFBIWUBRN3FgGsz0g1TH6Dk30f8kNIqXYzzqL/TJCwy6dmDhfnsGuYe4GgKPaKCANk3v0H+ptOa6ZsP7s+EB/BQJiqInhQcYh621yQ6LawvoyxTvQ6/chKPr8o3DpUwUrV+DaZwiofumHBdovosLpTyO6R5eKxWgFkyvkqP0EdZVaK9g7me6kpxgrSq1zdZiJAY6wKAic7v+EhrKUX6XkDITAnLiXWuVIAQic1YLnsGkwVcoLxylff1VGT3KeoBkuaanKELxgtFVcWcjHQxoo9TNVhrZ9x5bBl5vcBQd4lOvciX9g/lNXB2smEXQINs8pIcLsztyVmnbpVUG9UY6YxFJe76Di3L1QYaXkMGTndqHZk2Kd05tNZxz4v8z+q+31EycqbqWty1YdxoGhZ6H6tjptWKkGRwVf0CmR3BF+xtzJ7UZvlRmAFI8Sz06RWaVp0xMUPA30jTeU6ISkJxo/zCVhZ/ivel0VSTe9G58agGydcMzp246bPC/jwRRuhMrjC3WDbIL/J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(55016003)(38070700009)(82960400001)(86362001)(71200400001)(110136005)(7696005)(6506007)(76116006)(66446008)(64756008)(66476007)(66556008)(316002)(54906003)(66946007)(33656002)(122000001)(9686003)(26005)(7416002)(4744005)(2906002)(41300700001)(478600001)(5660300002)(38100700002)(8936002)(52536014)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2aLHawlDcmHWGsw4FfqwPRVeYVgngOJHemuzNhy8Bk9dGDKg2IpWW+l+HIh6?=
 =?us-ascii?Q?lNayRCpfqcxenKwjnkoPLFGMeXoKxZDx1N5pSQFsARNKYKFz7FoFogi9XI8q?=
 =?us-ascii?Q?V3wdWC+HjAUq7rp5+mb+waLTIl1UckWQ1mhNUC96mvt0TE8pv0k47Gc/rEgP?=
 =?us-ascii?Q?tpQHmt5F6/nH7GGw+Wbj42wMNviwTPHEbTfFAgfAT4CQJDBjj0huMJjAYQVO?=
 =?us-ascii?Q?CUi+Lz7MWVCStHJ8q/9RqPuqdIspgO4n8raYdpQSd1FP8awK5EZ2Ezd9QHol?=
 =?us-ascii?Q?dH4PS5ZYrOL6vsOCcfU7CTuQHkV/xjMCu9OH3DIevIzLOXvGca6UlF6OLp7l?=
 =?us-ascii?Q?9Zki9o4ZxxFZfCN8e7ZAm5sGFE9HfUjQ1Sm/mKiRwKeQuK1EsE0Cvam8RzU3?=
 =?us-ascii?Q?LWfrBOTL3rrW/02MXWrmOwKYTgHf4wgY7Fn8s1RphdcqkjoUbRXvyeOzkPbo?=
 =?us-ascii?Q?SqKreh8C7HtH4nDARrBs3CJu40+H1YvE+jYTc6J+9kPKlA1DR/b4muA6zgM8?=
 =?us-ascii?Q?BzGJzhAGz9CswCx65bUdPOgjLQhFrXRbWSy7pevVuX7Gczyr/xyvgKfoMxu3?=
 =?us-ascii?Q?XD+inp3UudtNJuq11Y47VB1WUud1kbt2bD+hSidBIffqk+z7/lvmg3ZI+c6O?=
 =?us-ascii?Q?eMmlbHqr759TXFUNhIc8rxiZwpKIRTb6WH8wIM0Dh982UOjNf2ejoi0pLfxg?=
 =?us-ascii?Q?mCPVNlEoXPnESZPkv0CKEi9Bbyps6yeJUJvY4ioVcTcpRzyeEFGQTsvxQtO3?=
 =?us-ascii?Q?j0bPImsPnrxXCdB8NoKXaP+Cuf8WxcCqLz9NaYPYNzNNYlCzyqT+C4603sFZ?=
 =?us-ascii?Q?OE4P2+FuGSvbUDRIkviBH/JYN6aKjiU6SdBcLB2wdZ9aF42e1ARokykPRx6f?=
 =?us-ascii?Q?SRWai/CHjBqCbDg8knGLtsEl7i2+u/gxLaGmIh6Bm2jwNSXMcwYfr5UHXPUu?=
 =?us-ascii?Q?N7rf3L0LpQeY+80DcBGiH2iYnKspPDwegUsRcbL/vo+FZOUUu59mup2Qf7uD?=
 =?us-ascii?Q?H39vC2Gr/upBg9bS7PGS/uP6iL7gEqlhsKTqBVUXAke/Xba7z0rkmvzDmjCB?=
 =?us-ascii?Q?NT0Jf/EUudeBrCdF4TVzCk8G8brfc2GeYYGW0BrrYP5/gqSYw9tcjFOSXdOW?=
 =?us-ascii?Q?FkULJfWWXmegJtHHUohjGTPkk8GHTE6bmlHd227Ix5uCFSSfEpVLpBpiMOXd?=
 =?us-ascii?Q?c8W2inHfNdND2mcRFp1TmG09Z1zQ7Iuw4QTUGecV/FH2O5L8mMpkgjIkVYVp?=
 =?us-ascii?Q?cBBJkerQzNoRm8GR6Z1ReFwFqY4d+KzyM0ysRhLxFWyeeH/S1GIjxF+m4jnA?=
 =?us-ascii?Q?15SBrrhVnLTAkahiK8kyP+7x2qkSfMiDGc9RJXnPZ9zlfOTL3oZzHibZUTnc?=
 =?us-ascii?Q?bMYPxDFCjaBBOqEyZHMVhFrW3kNoY6ex9YM+U+lFyz35meO2qpOOaYpR0W8s?=
 =?us-ascii?Q?iln7xDFO1sHqhC5PMaVTVpwqH2WYlChM3386IxE6HBQVM20nOCGBtpzXo6GD?=
 =?us-ascii?Q?Z9d1OYVz3XQwvEqMbp62QLkwP3ZTPK1+qZBQlvR3vDD7a5sggH/k8In/zFxK?=
 =?us-ascii?Q?8Wv7Q2C7UKV5iGIS3IdooOJTxXiRYJ0h5fGKzIPW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c073decd-2696-4c80-969f-08dbe99dd758
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 07:53:53.5007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFkmYpEJYHANYSTgrmxuiHKwQJuRJcadIJBERz3QzIEPWLoVcQcFd4d5mOZNGnRiBdIn76kCKsqnCkylEYGPIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6742
X-OriginatorOrg: intel.com

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Friday, November 17, 2023 9:07 PM
>=20
> +/**
> + * struct iommu_user_data_array - iommu driver specific user space data
> array
> + * @type: The data type of all the entries in the user buffer array
> + * @uptr: Pointer to the user buffer array for copy_from_user()

remove "for copy_from_user()"

> + * @entry_len: The fixed-width length of a entry in the array, in bytes

s/a/an/

> + * @entry_num: The number of total entries in the array
> + *
> + * A array having a @entry_num number of @entry_len sized entries, each
> entry is
> + * user space data, an uAPI defined in include/uapi/linux/iommufd.h wher=
e
> @type
> + * is also defined as enum iommu_xyz_data_type.

* The user buffer array has @entry_num entries, each with a fixed size
 * @entry_len. The entry format and related type are defined in
 * include/uapi/linux/iommufd.h


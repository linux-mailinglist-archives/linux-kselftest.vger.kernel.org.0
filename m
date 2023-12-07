Return-Path: <linux-kselftest+bounces-1341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EDA808383
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 09:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1E01C21D22
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 08:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA615AF4;
	Thu,  7 Dec 2023 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2ZyegCH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73481AD;
	Thu,  7 Dec 2023 00:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701938874; x=1733474874;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1pr2zfkKerHkUH+Vl2CLINiwZFidQXBObvE8IenvOuE=;
  b=j2ZyegCHGZsRhgW2D4ARZ08mMQp+vLBnQSFEOdIWgO7nylk/pYbyupOv
   /aKgF8tsfyxdbk/ScZHiR7sX4+Qw0ft5hiVAgzKBMBeE0DFDgoraJ16Ep
   JZTyJBhY8PZO/cVorRAx7AIn1mX7e58Vu3SPa362Y0hUuN5dyOGvamYjG
   xrNQkqvhcLR9hLqNi5oBCWYFCM7kOMEhNoucC1wuT4SEAm3kzPynVae0y
   miD0jWcuAZrKib71VnQ48sRk+wggqkaNQ//wt+CXsi5P2SskJXwa1HnRp
   vYOjcod84WruGfvogK1avs4yaloUqbpzcYZZFnzEUYz+gn/O/E9NbuNVE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="7560286"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="7560286"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 00:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="765039813"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="765039813"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 00:47:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 00:47:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 00:47:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 00:47:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 00:47:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHExOEnw/FiK/psi6MgIJ+ZFJ3VQiRLRzXbhOjiuQqk4Oc0KOSeHsk6RYWVkXio98n4uzzCqp41Q8c9XiwTfMfl5ArAYo8oYT3iu6/e97OmbkHM7oQWonsmksA4wZi1+lTDTBXc2DdVaS3qtU/fikW6Q0JbPyVgOLlcwGNcItByIYIsrbl5bYs88nm2/bXtnS1hfBP3qCjFcKnO9E87mux1P91W0+LXkrEWxUJ2682vfAtRCkC3brzqmwOO5teKuEw0CZkdf91edAHZjWF6Rl76BQhC5Fv/veMaGpm6ss8qNiynKPXERvO1MRSg0vyGSaFn2oUgiLGMAuJZhHzn2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHgwq9dxJhwBOnAXHW8vWd8n/g1qiRhSLue/NJpVZg0=;
 b=a0msYlW70L/9k60GuQnUUh9YTM1Iq1dRPRHW1JpEhL+onc6NVXlkOQhDbJzhuH89zqcjLU4m0DH5WvJ6dtGRCh/jW2dQq2N0KfYHm0sZi02uk1qAHn3Q/flOgxCKHoQVfc5yzvpN//12/pEwWdUMim4B+OhprEWe8jp52f2L968baL3UNJ7ZJhnKMVfJglrgsSRFtnxkqP1L0vRxouWJrb5LhozmIkBQx3BtDVTuCtZSBCV/sZVGlx60IfsQtFlsnPfRkTQf1n/ZXDTSeY8Z8U9nKLNRWFUPP8Q/oBxllPQYNNqkq9MIWfbW376mdXDCNU+P9NVbYktgf6+TuFS/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB7657.namprd11.prod.outlook.com (2603:10b6:510:26c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 08:47:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 08:47:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Thread-Topic: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Thread-Index: AQHaIPx2EKyfzMrBBEWzcc+IDcJP4bCdkKlg
Date: Thu, 7 Dec 2023 08:47:48 +0000
Message-ID: <BN9PR11MB527639DBE4C433542F351F6D8C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
In-Reply-To: <20231127063909.129153-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB7657:EE_
x-ms-office365-filtering-correlation-id: 1666a16d-51ea-401f-dc4f-08dbf70130be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6BGLgeJWfJ0WN8oOrPNOKhUVo2rweIR50pvK3M5PfzQp7H9eVy3ziatxthf1xi2zxaopAFnYLbmnN4Q/3fvxZXlW3XyhSXG2E4Tcwjzuft+G4SNx/rZEdm7EobPWa3wiwwEX68T9UAuJVDtHblQpLdrehzKfLqY4DQ0kRYWfjUdeXdR2ol+/n4uAfUomOIYhUkXFHQ1MPtp+ZRbRvpeFnqcNGZvRoJ+3hJdnNHSI6XTO2u9agnlis+4zvSFkl1mB0Qp2lf22TvN1OwuLY0ufsXqNDevtDc88k5JG9BIGaQ9Y35lnVc53TDfpZsYFvq9+TfG4omhMrit1XnN/DlrzdF9JA5zcTGEtk2IfEUqoqhT5fjbjmqsoZP+wskQgWS475JjlBRHv93jxwg/NmNlgWH3mfa9SxzjAErBlL+oaJqqhN/cBOfjrxZ7JopI+IHT5EM7LyjQuu5GaeW3vaF+IOvBGlXBs6jwlhENiPhqxeGRFfHgGxcAUvcZ5ikcuvuXUnF3+S0Ija1uAd7Zq8VWNIsAvUOCvRwOBVvlSd1/uOKfqtTHIUMvfL0p9pfGXa6oGjEPnZ0rpVHacKCcIco4K/qvAswdN4r8JGsceZJO+vJzE7GGT+kWss1PPwoingtCU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(122000001)(38070700009)(2906002)(38100700002)(26005)(55016003)(86362001)(82960400001)(33656002)(7416002)(7696005)(5660300002)(6506007)(71200400001)(8676002)(52536014)(8936002)(4326008)(9686003)(66446008)(41300700001)(54906003)(110136005)(316002)(76116006)(66476007)(66946007)(478600001)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QAwABuCHEeMDFMXTIvqoTrLVcnRRptopvTJFHT8UjN/fRTfABtlmPU/3Fobl?=
 =?us-ascii?Q?MarnlatWSf4scFRSmRagvX7+MbCaaaDdyBOUsvDArNyKdlJb3nOF1Icx8x8q?=
 =?us-ascii?Q?BCw2jiqQlWvt3A7cYcn6bsP7RavantMcz7UcbW5Z81e1iwga/1iufJcCibz5?=
 =?us-ascii?Q?YH7GEYjRGKWDCgxlkmUyIWySRlacFgyRX3Rlft5N3v4mStxXGr0lXQ/VZXi3?=
 =?us-ascii?Q?ArGV9mBJXWw3a8yO4m6TKoa6Ut01Uvtt2oIjOHiDOCWKbIw3tqwRRIM3lM/H?=
 =?us-ascii?Q?bQi7K8zWQL0SfC3ZzRoHkSITRqwOJ+EEABxX4M2VdST6iu8lF5diAJXczPd6?=
 =?us-ascii?Q?pE34DGwltAxsgIkPf7/PB24rd3cUrqH0Rtxz1M27lLywqZI9rXwhQy3oCtkj?=
 =?us-ascii?Q?21E5wHGdCATZqezFsuYcnyWPrYEMmSUPCSF+ZmoqbiZPx1WC3s8qsNipVibJ?=
 =?us-ascii?Q?bBHJxOYmnEFng4ffY9I55ad/Oi1R/zg3k2/7g4xNQtGXFvGgV1F3oYLbpZMk?=
 =?us-ascii?Q?u6zvURvzClgalbqu/oWxwVqgwb90wckQbNf4c0IQ+XFuEXvx8BPhqMnZD3bu?=
 =?us-ascii?Q?g7togFUqvd4oG2fG9ccL39GVnPJlGePNDDmbMzGL8GE4KguABXeajmsJjK8O?=
 =?us-ascii?Q?RA2J6cfdNysCzSTrNG5lsmRyKefWR7gYUh8azaCrCNM1Eqv/cLqFEXR+HLWl?=
 =?us-ascii?Q?bYzGI1NSxHmMcJdwYafxbSdAfXPHEoDNPenpwE1eSo+lIQVdZMvkfRpn9KTp?=
 =?us-ascii?Q?OJ7BtmQKBrrLvu8Pvc6FxILsgj+2qjXy8vn+IdR8lyipjMH7gx+iEuQCuc3m?=
 =?us-ascii?Q?NTUkeoM8cwXV2Q4x9Cn3OwBg+V4bJLeennGXA1h78gAoeGm/PHJ+/vMMX1fp?=
 =?us-ascii?Q?jsxbO0HQHJUMf6kPQ0VDDFb//SaftC/tnZFs6RSV0AtLxUyWEe6tAug7j1Ho?=
 =?us-ascii?Q?ora2OKUfB117la94sDXvEqM+o9WOXaw+rIj/z6IZ5LOWnsi/Ity6t7gHagVD?=
 =?us-ascii?Q?e0D4bi0x6DUA7cXmXsaFh9i0+3airr+Ev9Qoq5KdrniMtntrt8gyRo/aNoVw?=
 =?us-ascii?Q?2T+Tuy817poVYfr8DNVCfj/7Jg3SD9tOp8Nc1OqjX/PaQDNsHCLCdctbarkh?=
 =?us-ascii?Q?7Bj/LqrncKr3aa6UsajfZcigAC2Gf60eQAQPZ4xaKzItEI9vx/1IhSDD3Hip?=
 =?us-ascii?Q?Rbhmw2TRAKBvmiGyXbMohjpYkBP2PRsNCScjiGnc1aPSkjSBcz/s6kiYLw3E?=
 =?us-ascii?Q?AsOMiBNfMe58ehcH/41U4rybfJhuy3ACOb7LIZdiA16bw1m4S9QCd1K54+m3?=
 =?us-ascii?Q?Y4zszyx5p6jE5EAxbKwH7u2CyRsGAm7OMmkj78s0/OXQyOgWl4g4YXKw0e/4?=
 =?us-ascii?Q?SnxuzUoYzWpesOXWgdBY9RYX6qyWLXQvt7u+rmisajoGIP0E6OddRWYV/O0/?=
 =?us-ascii?Q?7hhG9z6AXwGSYQdA3EL35rNSpC+jP2PUATm2i+SnAYlN/Bj1jLi+PRzV3Rhr?=
 =?us-ascii?Q?RKJdCgMfPLQx7NXbd16SXhUeE/UGqbj1U6qaoYROqHI97WkjQYT5E0FiRnno?=
 =?us-ascii?Q?WThgZAJE7xKP6Rs7wxAD0MIVh4h5ElnnT3gYWkVf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1666a16d-51ea-401f-dc4f-08dbf70130be
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 08:47:48.7523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2z55pNP2JUWEHlFquI9Y8ZZKmoDsfSFNJ5nV/CtHWR0j7+3TBrGwbqnRXJKLahU/vKRh0aPhsZuiuK2XHW/U/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7657
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, November 27, 2023 2:39 PM
>=20
> +static int vfio_pci_core_feature_pasid(struct vfio_device *device, u32 f=
lags,
> +				       struct vfio_device_feature_pasid __user
> *arg,
> +				       size_t argsz)
> +{
> +	struct vfio_pci_core_device *vdev =3D
> +		container_of(device, struct vfio_pci_core_device, vdev);
> +	struct vfio_device_feature_pasid pasid =3D { 0 };
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	u32 capabilities =3D 0;
> +	int ret;
> +
> +	/* We do not support SET of the PASID capability */

this line alone is meaningless. Please explain the reason e.g. due to
no PASID capability per VF...

> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(pasid));
> +	if (ret !=3D 1)
> +		return ret;
> +
> +	/*
> +	 * Needs go to PF if the device is VF as VF shares its PF's
> +	 * PASID Capability.
> +	 */

/* VF shares the PASID capability of its PF */

> +	if (pdev->is_virtfn)
> +		pdev =3D pci_physfn(pdev);
> +
> +	if (!pdev->pasid_enabled)
> +		goto out;
> +
> +#ifdef CONFIG_PCI_PASID
> +	pci_read_config_dword(pdev, pdev->pasid_cap + PCI_PASID_CAP,
> +			      &capabilities);
> +#endif

#ifdef is unnecessary. If CONFIG_PCI_PASID is false pdev->pasid_enabled
won't be set anyway.

and it should read from PCI_PASID_CTRL which indicates whether a
capability is actually enabled.

> +/**
> + * Upon VFIO_DEVICE_FEATURE_GET, return the PASID capability for the
> device.
> + * Zero width means no support for PASID.

also mention the encoding of this field according to PCIe spec.

or turn it to a plain number field.

> + */
> +struct vfio_device_feature_pasid {
> +	__u16 capabilities;
> +#define VFIO_DEVICE_PASID_CAP_EXEC	(1 << 0)
> +#define VFIO_DEVICE_PASID_CAP_PRIV	(1 << 1)
> +	__u8 width;
> +	__u8 __reserved;
> +};
> +#define VFIO_DEVICE_FEATURE_PASID 11
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>=20
>  /**
> --
> 2.34.1



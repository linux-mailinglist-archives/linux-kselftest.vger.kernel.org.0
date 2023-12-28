Return-Path: <linux-kselftest+bounces-2487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D1281F4EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 07:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C98F1F22532
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 06:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F83523CC;
	Thu, 28 Dec 2023 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnXIcaws"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854C23A2;
	Thu, 28 Dec 2023 06:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703744084; x=1735280084;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k4bQ/lGNSlPaulaSofit6w3zGVDxWCkijCbqMbzQa+o=;
  b=nnXIcaws3cuO2jSiZDPyjaS1FXat7Gh9c5QW4nwZDEJH+Rsg9Vv5/LhH
   6Z8/r4RFXqRSHYfsCjBQzOStmyJv6FYfkJC14rZUptzU911Ivtn2aRiBR
   kr/p1+w14FWIu4JOPRG4+kXHalPgCLKrfznS8XtgGiW7qrN8r+Vhr6Ny3
   UkmYdyETqW4gJeXldv4FgYzLr37C38tS0bbt5iFAQfg7GF0UNva8W1kLG
   BZQZnhOHJ2PcLto8EHf3w4p0exzEzD+Wjrsn9ahXdJLxCiPJ8X67Rvw8u
   JhcpYehHLJNvQSi2izKOBxF/u/07PE0LF5thGb5VpP1FsWByJx2TrjUCc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3354453"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="3354453"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 22:14:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="922018919"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="922018919"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 22:14:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 22:14:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 22:14:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 22:14:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 22:14:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apdNVRnVXLjUvAYxlA+oTrqOIdCcp+zDrGAY1+wxdxbh4Z8+8PPAy6K4CwoBugexK8NCaBcwWBpVGS5pabcPMcOVq3V1KZe346u2bq2ddKQfZwuOyMVNJl3N1C8X6f1Tfr/YE7H22cqvWdxjqBhGsPJOtPZI9K5lMseUwHWx9AVy6pv+1dxGejcIDgANLNltzA4jzizpniBcWGnW7L6snM4f3UReXUi7SMhPqOqW/mw8Hhj3a8rT3A9n8mgpZtrroBm7h9fyvUYOOmoCXhqsJ6mu1tC+YLew+Ey5dnt9ZXgDlNXuUzrkw2IXiMcIIMYVLsZJjiRT182PKr7FCLiOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51gf57fjGfU2QxR+Sd+ABScOAc2uyaMHw0cnQoF9AMk=;
 b=h94OF2N6BtXRWdgZCzCYJBuCFhwfIsLB0BgMz86Ognac0NIx/tWf8vPM+pmNpw9WpQ1lYw29IiKPjj2MFvAbcNmwX3Ic1duJsM1cu/MPQeAUBId1h5JhvqxpagDe0/NiE7AST47CFOWoRj3WScONlsJR/cGbo3NF8s+Z7PYl1witxWhJlbxFxkD41pyQ5kbPFQDlv8xANsgr09EG+/V09oiiEoJfh/fP9IVBgc5c3FF+4mDiTcNWCV2mLNYBNyd3TSYTI4TiSD9t+l9ZcNkKkFbbjgGwCA5pOlzIPIYvEEIG2crXiVPWjb1gciSROx4njOlXsW02l9ZTqjrk+zXHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 06:14:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 06:14:35 +0000
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
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
Subject: RE: [PATCH v8 06/10] iommufd/selftest: Add coverage for
 IOMMU_HWPT_INVALIDATE ioctl
Thread-Topic: [PATCH v8 06/10] iommufd/selftest: Add coverage for
 IOMMU_HWPT_INVALIDATE ioctl
Thread-Index: AQHaON/DMEua3daO0USOPGF1UKMImrC+N36Q
Date: Thu, 28 Dec 2023 06:14:35 +0000
Message-ID: <BN9PR11MB5276DEF13D2F64D244A932C68C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
 <20231227161354.67701-7-yi.l.liu@intel.com>
In-Reply-To: <20231227161354.67701-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4822:EE_
x-ms-office365-filtering-correlation-id: 6af8faea-e45b-447d-79d9-08dc076c43a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b0iCxmqSGDu54GcUx4x0XaKqyFnM2HExhRVmPILvzb6xPbjDndoKuCBs6ntv0t1h7bzoiCBvjsINQEcYVhzpuN5mIz6cKiPufUv4rk/X4oCAIGGQRLqjDGaBajp0haFJjftdQs9sK0dGnOJ+G6QOM3Ac+yEVqc99NZx0r12RVgHDVUDeUKSQQOWLV7g6T9KGYGZPyNnWq6g0tOfvFHHA/CHCMgeFm5+Zr0x9QyIdpp85oFPUfPGvaj+Xg2Tj4BSqDE9ytix2OwSWTxBlrfFCoH4BL3VzEFU44VKhBl6d2wYhXfScQi/bbNnYaz4QBTncssh4XIMLHxdUDRG5H1aYM6fBGyazjrbwGhUYVQHnSxyHtah8SMdjxGY1ch2ICwr3hDfLc5Hc/+59u1hz417G/ZiUKi072vMFwCV8PAJ3FmwdJfOtyAYshanKMsacVzfPKJJbaWs2h20cMsf4cakpRWJu++kOSmJ/NYs4pp+E9U8dVDCEmDj1UE+qmD/ANOiDia9W6gWgaFlGHNMnAj1gsuTe+8T6J/pl0IcmYtAcm7+K/EFVWRxcGK5KSCjLtik8lJidm2VlH0mqXbjI/OsHE1RQwOdEL5mcSUMIL46if4qgV9jSPqQgXALHJ9D2tq3y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(9686003)(7696005)(83380400001)(6506007)(478600001)(71200400001)(110136005)(38100700002)(82960400001)(55016003)(122000001)(52536014)(76116006)(66946007)(66476007)(316002)(54906003)(66446008)(66556008)(64756008)(86362001)(8936002)(8676002)(26005)(4326008)(7416002)(4744005)(2906002)(5660300002)(33656002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kv0Cq54iqiyaxjkEHtn1H6/GPV7SvwxOxrT/eulX60uapQPfG0uPoQ8WT3gj?=
 =?us-ascii?Q?ZP8sSXa6T3EJwnCiphMhPgXXfTe+xXsW5MCgRMa1BzdD+hdNHto2GnNLeL14?=
 =?us-ascii?Q?qeqJkRtneWh0vEX337OQp2vu7cvJGzLVFCm1PmTL7DinVCQZAoBSLnoz2A14?=
 =?us-ascii?Q?Xwa7DQ6EVmVT4lUsda9x68wtSENhwS7+9i2cwMzqc3C2aRe1xil6KtvYFqjZ?=
 =?us-ascii?Q?QVqjOEtHsxWByLWSbsIQbBmlwI0kFFgA1k/XFosRmK8C6ruRGSjR5gscH0PV?=
 =?us-ascii?Q?azuMIWhPC02xmfzzW0i04aHAUdFDYtW2hNYYaEFRJ4r5a6gqz86V5PO97Dn8?=
 =?us-ascii?Q?JJYocWA6zPuk7H5GBxL0Us8Y+1WtpYCdmSZ9EB4434HpwPkiwjfoNByU5OPL?=
 =?us-ascii?Q?TLSw3TKlOLJZs/dOJj5Qc+lQ4nmvz9vOZdW0x5xOgZp2fROO5nCuTAXvF4OB?=
 =?us-ascii?Q?Gy7OGvC5pSCUwdc9baEs8IbF/rxM4FifhYYEdWgl+rz4z2slvAg5DL6rHVVu?=
 =?us-ascii?Q?8oGxlylKJM2UlmVmTvmQ6fVM9Fz6ZpvYis8s56HGUyaebXmxUNrPq/rpnZLG?=
 =?us-ascii?Q?IS/sSUTw8ZxCR5gyycvwovhZ5fm4Gnk5odxVUxP+PMzRILAzNZDYTpS9bos/?=
 =?us-ascii?Q?T98/0w5AoO0uvw+rw/uyjqdSSu2rreE6DrjT+UFJ6HYwf4k4+8PWSxlfPb4T?=
 =?us-ascii?Q?pJi7zpc6TOjNQplbn8tH99DBvlXMX5yGfuyaI7mA9I2OlFGzKMkiT1cCSR8V?=
 =?us-ascii?Q?ARMErdJlen+FXarr3UGvGjGC3JZ0nz+6+7KG9DNJQZanSis3ET3USUiAnQAf?=
 =?us-ascii?Q?vkOT6QYY2OnWoaT6UOkonVDZSjYcDvj8cccx/AAtp7pIIxA83EMy3q6cumEt?=
 =?us-ascii?Q?1ZfgWTWVUv4tBb8jeYRWfq/w6ubshWzIIWhWHGNMpyx48YDe+rh2PYxmSKuB?=
 =?us-ascii?Q?3FSekEikS9gOzB21v/V8xAlWrsdPYn1IL/Io16o2EwQdweJZuxjf4nDEzd8t?=
 =?us-ascii?Q?1wKciogVYSfLeb8h02tAVcDznpjJuWNzha993RkBOm17Vyfx7Btlyw1ac42M?=
 =?us-ascii?Q?zGdABROhsIbACWxoeUfLWk0QeUnQP2X6wenLlOq7ooRbirUtuBLe8LyjvCut?=
 =?us-ascii?Q?Gvy+Dy+7Mv9f5u7uOZO/RZzDnfFIKTWdAzdCLJYgmzNtslu9tqV3rpkQ2om7?=
 =?us-ascii?Q?tiqDdmWjH/DtKLJG2BKzLQFiCZZnwyBRrZNP7oRb1zTqYGpdGv2kz7xbYHXu?=
 =?us-ascii?Q?3iimShX4nS7aZFrSlfPrLv/yDT4tCCd1THuNxMHqIc0OIXmFnhMgmEbotHik?=
 =?us-ascii?Q?H4hqkDKDdPpgIePqkkPCVdkWdsyGGnTGpTx00eQ0vj6NmX5TBiZybhlRh2hd?=
 =?us-ascii?Q?h/HTBSL8b9f1NGB+AkLlJu3JVvhdVm1dtVRS9wc3lstkDdZOSk3iaDTb9Jw2?=
 =?us-ascii?Q?uD53DffKE1GAkTyYicqFlTV7aJXEZQj/CF9x7LvFEWZRr8ne7mFRLTdOHfGZ?=
 =?us-ascii?Q?ScuVEfAOPpbQjwXyRbZmJFkLPzdS76woE+OIsxlBzeDmqEqxMdLUvrUvXZZV?=
 =?us-ascii?Q?iWLSKFulAKQoWnBy8Yvpvcn5ImWVO78A9XigLJuT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af8faea-e45b-447d-79d9-08dc076c43a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:14:35.2469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vvrmoLi1Uzsf8vRdgKKOawqXsfkSYO+Al1M+WQO6cVoflvem3Hm5gKI3ulgfWDtfFB5BJGpv5oIXJJPHJ8Q0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 28, 2023 12:14 AM
>=20
> +		/* Negative test: trigger error */
> +		num_inv =3D 1;
> +		inv_reqs[0].flags =3D
> IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR;
> +		inv_reqs[0].iotlb_id =3D 0;
> +		test_cmd_hwpt_invalidate(nested_hwpt_id[0], inv_reqs,
> +
> IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
> +					 sizeof(*inv_reqs), &num_inv);
> +		assert(num_inv =3D=3D 1);
> +		assert(inv_reqs[0].hw_error =3D=3D
> IOMMU_TEST_INVALIDATE_FAKE_ERROR);
> +

instead of removing TRIGGER_ERROR|ALL err check, it makes more
sense to keep it but making it a similar case as above.


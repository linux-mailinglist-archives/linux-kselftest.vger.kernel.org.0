Return-Path: <linux-kselftest+bounces-2345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE8181C3B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 05:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823991C249A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 04:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A11184C;
	Fri, 22 Dec 2023 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhEh/o1Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE301C06;
	Fri, 22 Dec 2023 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703217677; x=1734753677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W21nASzHkuIJi49PaY9fPOtCTldMHNjasMQbFvij0h0=;
  b=WhEh/o1Yjdgm9pzKh/cXMgBi39E+P56XKtpY/xQBTSeJ8YCJG9lekoWP
   cnBdQZ+ZQtosfDLy0f6d4bocu0mJaGViUiKfljJ6TV44CpkwAuJjgkY8B
   OVcrnxti2FcU0nk9SBsM2t21AYdn1e08QfrD58x6TgMTpocqfKczgZvJF
   meTj3KVyvq0R3VEX39UUPzUCbgtid2jFB1sxvwkwB+L7DUbEtSTiQFAOK
   jgca+fEakRyGQEuMAfqRCVHwfpeDz0jMV77UbVqVplvft7WtMDGT0PcjG
   Wrz890RJ1a+sRlUjMBa64iLu8ZBnzDlwRVPPRLa4NUJnNbnmkTU9IjFxd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2901734"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="2901734"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 20:01:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="776936220"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="776936220"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 20:01:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 20:01:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 20:01:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 20:01:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4Id9R3gDcbUxh+sXZAmdkNImQh6Ph0QRWq9biaKe1AJ74hi7OFe2JfG5bQiZR6bR6d5aB3Ey5Ab3nakQZfaUJj8VHSfBQmzV5phHZ8b9tRJAJtPTRJSlLmWC53EkQbKYB4rMxkoP8ZapMmf6D+laup6I76jmB6TKZpO2CazeGF6mAbsKXtNKHjtaTmTFourxkp76e/cBbYjHYYF0AxwF7Vpe0BQ/YNysJ2DSqV6ZkIsKF4BYmV5mKg4rHKEH67O8d7vhMpajCfOmsG+0AaBb5xfvH7/+dwN/8Ly+AxOgXYQ3KhoyiAyKFjDLIy//w/n1hmaSwdLHffLuk9PWFxsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W21nASzHkuIJi49PaY9fPOtCTldMHNjasMQbFvij0h0=;
 b=DpP2P9Ug3R2SlIBjEBiqY9YuvbLxkPkxf3ka2D0VQ8QsIBGF6zuNWTTAgQOXvKHUbriRAnCoUyat6iUMeH5ILTRFFJUl+CnoJ+LMxQ6cTvga9nl+kW1rw2cZ14Ovbw/7dLQjK3qrppCCgJyIAXwmnla6/cPNC5ODdV/m/cAZcNyi+/4J5zhzda+mEWByzwxc4wLWiZ3o5qdgKmD3iMKGJf8IR/pwt75G3jh7Y+RjM64muqhCiZEYo7Zwq5XRgmDDWuBP2yUwDp+WWRHeLuhf2wOnAzrtFV4eBITg9WTRLUQXJxBRMpiPnZwkLGb4oUSGKXo9JT7/3UP2n2QqJEW2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7033.namprd11.prod.outlook.com (2603:10b6:930:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 04:01:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 04:01:04 +0000
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
Subject: RE: [PATCH v7 5/9] iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB
 test op
Thread-Topic: [PATCH v7 5/9] iommufd/selftest: Add
 IOMMU_TEST_OP_MD_CHECK_IOTLB test op
Thread-Index: AQHaNCP23+yfcIqskkqictRpTp8zgbC0rn4g
Date: Fri, 22 Dec 2023 04:01:04 +0000
Message-ID: <BN9PR11MB527634C7B59E01C4C0FED0378C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-6-yi.l.liu@intel.com>
In-Reply-To: <20231221153948.119007-6-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7033:EE_
x-ms-office365-filtering-correlation-id: 97f083b7-55e5-4e1f-dfaf-08dc02a29e53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Uctjlc2nkNZX/iwBG9LwCPycjPqKMsbKnGJFcB9K3G8pJJoO9t5clFBnqzwbnPDsjxgx0RIJZ3wOepZOkIJ61JQrW4ETarLYr/CYNqCY+L18tXrTtDlfOJ2gsbjLjdaTtLanWyaBtdEEW3CGQ2MNOYKKmmNwXXt5VJNP+8pdlI45Kvp55V+4qTFVfGO8ZIykU0WHhzzChCAdGBGsbPMqrw3tFqGYLSYLgVwVb467HD4GBmMZExyFHu85eyTrohodrX+aHMj5izyMX+FBu/NpffGM0C81Z5eAEBTSZMF3HmS5CyWqH/Q7YXoTIlJ3HVrM/ix1bkdKXrMiSG6bk9Pyi17c2maLRp2P+2uANzaHy7iECThv2uOeIeHY/ap0QCzJ1Zb56dagTXpC54M5t9pZ9S+RGU67ekztHKpKs/spKBMuHSTxrAOxO5QV24hrpHd7/ytYaF0TH1tkQcRnjuhnB0ormcMeDJusAxbWn0wLt2eLe6rc3uIc/qzzUCXetgEk08w5hTJKCyu80PfoWuQTXdegek54fLnA1nRxSv+KMZgLQovoJoRi+Ey9+MvYyX8kYZOFXxxmJH7jtl784n32fIknQYUyT5pcxt90l0G8A3CshF8beF3LP1xuu3LWoB2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(82960400001)(558084003)(33656002)(86362001)(41300700001)(122000001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(110136005)(52536014)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(9686003)(26005)(478600001)(7416002)(6506007)(7696005)(71200400001)(2906002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vhn3ukAiQNRQ3Yq6fWMpZkvlZSg/hp6hPitZbwwNXW9autYGD7RDbwxcvSYF?=
 =?us-ascii?Q?qW+J2iRFI8mu/epaEpS8H91lYDdga1wDyt4y/StYUorbfr7yrplZsvL9wdDA?=
 =?us-ascii?Q?FlsPidQ60KBnNJTBverueBhXy0NqF9QpWnD8ZgKGct/QtN98P6sAtyFUgq42?=
 =?us-ascii?Q?aihnhkZaAdAlQyG2DZRflmIUqd5qC7GrI0EXlXeM5nyKUndHIybL8/8rB+YD?=
 =?us-ascii?Q?00TNR9sbhJ1QPG+TtPG56l4FdhM52ah9C3T/VyJhR4UVhkgNnUfsmtotpoXR?=
 =?us-ascii?Q?BVIo+oRxVgsXlwMWjVJn0dtShE4dwRlkAqXI7VqwrXA+spC5SvCrM+6AubuI?=
 =?us-ascii?Q?zbJs7MO9qXAkWdpJm1msLI0OLvTtA0mUJ6FN3lR6KqLVRKhTuiL+pvSZ5pU7?=
 =?us-ascii?Q?UIKK8hMWjI35QcpzhPzAiQfOYajSbEEvO2t27qnrbkg2iVi9Cvmo0jkhDAui?=
 =?us-ascii?Q?eIK8Ktluv9uehMWZenDNi06Uu+XX/gWQH39eV/O2x2xPCCQLB5ojyfOST9F9?=
 =?us-ascii?Q?+UtedI9SDGtOa43lLz9+aFyoPEY1PgUtKPkX1wS1QzY4PQ8YpCDsOreQBt/b?=
 =?us-ascii?Q?nFi0nXp4rD60Vx8EhOL5R/5CpIP0VLayVecgHW+aeBuBu1KvEqs00FhnWNTp?=
 =?us-ascii?Q?yRQhHleDAfbBPpTKCj3sVDYPtFki6YM14qw+v2Dq7ykXg7CwKzCewvC4FWr6?=
 =?us-ascii?Q?xmjVSX9NrtDeX6LpwUt0LblVl1usXVj1DhHNfh4ojJWqUJXxt985tsOcviyN?=
 =?us-ascii?Q?1pzIhhAvuOaBFJwiYKmLxVlm2eleAOc/djExFxrOvmAxoCIeZsfqvNXoU7EA?=
 =?us-ascii?Q?wajnXeL9Z3q8iOQhM7o7Q9WC3GK8N1q9AzyxfM+QODzUwvQ+DX0nAVadZtWA?=
 =?us-ascii?Q?3nOrJdqOP+pXJkR74X+w+3LLLjPLBeeN62/iiKRhGMCpuOOjZsIFDsKcA7Gh?=
 =?us-ascii?Q?zRUJaVJ0GW5AwDCMYvAsF0sDgKH/HsXWCrf2u92/BPWVJxTPNBo0ItToLc5t?=
 =?us-ascii?Q?Pd9BbG/VtPwFflBpiYPnDRYyE2YjVU+FO099nyVaX/upkQxusE9gIOhphlGZ?=
 =?us-ascii?Q?q5VMOx6xDs99SeXOWF/1yjCeh4kmToEqb3MkDI/mGaYWeEhQOuETD2SR92g9?=
 =?us-ascii?Q?PqUxT7Y5UWz0tcfVBGd1d/Bj2JOjjkQVDI8YkcyTCyPDcGYhwlIuGivzKw1/?=
 =?us-ascii?Q?fZqNPYdLh4tpOipAQGVj5nL9S1Bwpi1WJcA/fKt8ehz2FfdegyaCx8ENYUq8?=
 =?us-ascii?Q?1ezjFpXKnRvFj7A4F0KCgUpovtpQbDyqFPpd5jLi2VtfG41nv229BXlGF3m0?=
 =?us-ascii?Q?NJJ/Yur7KQbr8mzcr7HaLUtKOkwO891PzmRh//Fj3b2J0X6YU+aeX8Q3enG4?=
 =?us-ascii?Q?wTjEI5nKQQut2Fgi0TgIhRHTtCHRHb/ROTesMHU+j4B9Z8VRA+0uSob5uBAn?=
 =?us-ascii?Q?ldJVz+DaUzmHHwu8i/SVFC3TDmVUDXKtL8XdG3T6s5xq4+7ZDx0FbEUKByf8?=
 =?us-ascii?Q?87vpxHu08JTYepqvsHpGkHEqieefl7Bu5EaqUheI5HqO4z0lG48jZwYba15b?=
 =?us-ascii?Q?r41vi27EXkCXf5bwk8EIrxK1LgiJBaYdiSlTLkFF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f083b7-55e5-4e1f-dfaf-08dc02a29e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 04:01:04.4005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxE+s77sxU1dCD1KxrjoXyKCS3icCjr3+IneX2a9J+kAHq8EdAeyKYZKpUnXOUDN8nC6yFSYeu6eOuJq5twl1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7033
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 21, 2023 11:40 PM
>=20
> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> Allow to test whether IOTLB has been invalidated or not.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>



Return-Path: <linux-kselftest+bounces-4334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7285784DC18
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B934B23E65
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AE36DCE5;
	Thu,  8 Feb 2024 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBrQEYkt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D86D1AC;
	Thu,  8 Feb 2024 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382426; cv=fail; b=X8lAFk3G6VfewlKXAF4PyCAvFXTBCEpvJSrOvQ9+e+zN9Dr1ArK7u3lVR+kU4P0g2PNW99IiHDE8NzFeb1ra5xQ7U/5CE3IcAQJmy6py/8UCXYNTLFz5M9j2vZCHZCoy0WxOu6V+luO/i2hN9T2Ljcn0DvKh5Lxn3yK54W5LbjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382426; c=relaxed/simple;
	bh=YI99Z4IZ7kMXs+7dCxlYGMvamMyLQmLCOWsj9B1n/C8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VQJx1Q3EW0nOwznpxTM3tVGoN9nwt7KjvEx+GQFv/IFaGX+JYrXMazhnNjDahOgn33clic0eq2WoSMkRkQ05YI1Kz+ihVXXHGg45SjLXLJYtxnqueBxMtAa/XdGniifJ9OHxVxzYQd1M9uD0I7aDHUZUJYcnNXUPeArpSaYAGuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBrQEYkt; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707382422; x=1738918422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YI99Z4IZ7kMXs+7dCxlYGMvamMyLQmLCOWsj9B1n/C8=;
  b=HBrQEYkthjM6pYIziuSoXyW4UjeNjj7in+j/LAKmEBtNPM9XwAZFwdkF
   ZCpzUG+DtVMfrpxNOnXmjzxm+nHA+o6S6cX70AkdaNGyXWcSyWFNHAdPM
   qWjKuS5JFbMWpOA/eYQzKcIGYm827H0gV+s2/wLdIZ3NN7EQU27v4CPJw
   GBOXrRLbxjJ52fG8wRMcfW5+jy8Y+aOr3IT9zyrGHFYiGGz+GrVqqRsWn
   PX2bwaoG+QTtA3oobsz16lvwg7sbV2iT8AsJno71YIBEmg+BwwoQmcCnV
   LYiiz2k7AeGhzxgmJaqFrpDanfLStSra0GMuMih/FTi2aAHmm/UZ/qn1Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1329189"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1329189"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:53:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1589471"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 00:53:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:53:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:53:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 00:53:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 00:53:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4S0oUcOMC6jDILIcqjwV9OM2Jg4/LfcY2KXiJEHaX+pYjRrpMtUx/Uj3LkFOtF7OdxBLPWGLJJBvaKBrUgAwU0XkRfUlDnjkstWZqDDFDXLcnkZBN4ZLLp+wPpUQ4bnGkGV88Bpj0XWcs1IcbYMcHYi/1wixZ4V71kJ/PA+jx6kGWa+Mkq+Vd+R4CdLDowmRWHkLdd6wahL2iqahuIdyDCN1o3BzwMS6fOvIDRTfy3kspl3rv/T/Lrg+speFpBLNgCqLt2axXOtyHSTWB/75CzXW87waPOULnBE//7a3bR4qlHqD4G5MsIulIF9CdtXXNLjGF5IHd3I+I35Y2BMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvfzeYVXwz3yFatbKpn54a7V9GhbP44u8G+Mo3i6F5Y=;
 b=J3JkA+09xU0bk3vRTsV8+cj+2pgWgv5u3NkYujixGkYLvYAvdsK/fMC+5Xu0/vLGSfHS9To93xc11uHTHFwJ8qqqFJQLzijQ0VYmwb7jLMw/sATzzk5xYbODjDpjp0bd57cyFZRFR8EzThHuF56lKVrgdPfeiM6Gu331meBs8BbVH2tTpeSy+wcbh5wLSPsEC9bjRLGXTLSjXOF+ZDIh+9EYDVpM++VWUmcxb/DG6oCgdHBCTqTXbolS2DXWuoDhare58bIh/nE+ctrx0qwzAcj6MFv7t5Z3Z7sNKfoFoHjxn+4X713PBiAThggc8meq0D1uh3hsc0EDf/rh/sHP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5513.namprd11.prod.outlook.com (2603:10b6:408:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 08:53:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 08:53:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>
Subject: RE: [PATCH rc 8/8] iommu/vt-d: Add missing dirty tracking set for
 parent domain
Thread-Topic: [PATCH rc 8/8] iommu/vt-d: Add missing dirty tracking set for
 parent domain
Thread-Index: AQHaWmgW6gj3lexfjk67ec6V2xTDRLEAIuLw
Date: Thu, 8 Feb 2024 08:53:31 +0000
Message-ID: <BN9PR11MB52761895C4DB8861C32A4B698C442@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-9-yi.l.liu@intel.com>
In-Reply-To: <20240208082307.15759-9-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5513:EE_
x-ms-office365-filtering-correlation-id: c8d14cc9-e772-4033-f95f-08dc28836d18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfrT1UYKqLLydY8/gcGaON1a1jg7cTFtTokWF9YCoj3tv+CFRdl/japCW+gLA7muFCZkmxFVG9r5rKX58dQJ9YPe0AzrSzHfE/xlzA2DgdrUpvKDxQWxjmr6SDAVH+hVN4T+jdLVwDBdt/AXtq1uolpXfVyCb+l8Ic1Cmd0gMhjpsHGd5AaZTtIE/NgdOsT0rX94gbFZKRfmclKsLY/reFipxl6Y4M+JzChQ163v7uiLmt98p2r3EZjqflfP+irhG+wooHeUVm77rY7mm9kkTyxF4ItYfFCziCIgDsJx6SuzOGbOFjBzPsUc5iYPprlsI0ivYhAxrAXbZy4w4WcPsOXUwX1IguHIQp+6G/ZpTQ8GxNK/7o2YXDXW1IOvdAHuzAf91YcpRYMtSiV7E3z/YpnK/dAkwh57XJaufTtAL4hlBTPr8lSXEyosNwoW/BrYPt+OynmE4YD35F5qrcorMLv+OmESwH0lpNxXpb3uTD0MXo0qVlpIRzsvnEv972Yrp9Llt2gAc1BdPiZIgrGyC8hRq3p0TnZWIbwBDmWqXaQJ/poEHp75lfhqudQ2GH9hUrANh+VejwEcb0RuXu+N80VMpiF5mUjzZzAQDDiTc3fRMOfEbi6y/EnE0gAwWJ+9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(71200400001)(7696005)(55016003)(2906002)(7416002)(110136005)(54906003)(52536014)(5660300002)(4744005)(316002)(41300700001)(66446008)(64756008)(66476007)(66556008)(66946007)(6506007)(9686003)(478600001)(76116006)(8936002)(8676002)(4326008)(38070700009)(86362001)(38100700002)(82960400001)(26005)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t90KOK2St9FMEhvwAl69D0Zumn+xj4qkiYbmpwB00AnY0ZA9cpOOk9rXR+Jq?=
 =?us-ascii?Q?xn/8ci0x9iQaySV97nHU9Gy40jBhD9/PiQwepR5mGwdaPMHAbwfgfsEuGZ4+?=
 =?us-ascii?Q?vI0zMTp7Ok4WMMoKqZW78PykYUFv6Tz8pECqFzhLqfcBgDbIfc4mRWMJRMf+?=
 =?us-ascii?Q?jE89Q9snafZjwvrU6p5jf7z1uZDKfsQWc2xQIKYT82xMHEnbNvfQBsNT7o3M?=
 =?us-ascii?Q?uiMYa4Pu5nOKQU8CnRPPsACYo9b/H/A6XsQuLtekLyA8FnllJ1K2LCqOdftC?=
 =?us-ascii?Q?Ush5TeemRP5LOIKCb/hZDomxhuvLRAnGeF1XculqbSZFNRVBdMNPBfQoMf2d?=
 =?us-ascii?Q?XOiKIzHJtkxsTpfA9OMA0B92h8pqdDKnbqb8eZgHn/vMJpq6/ZiiVIxoS5m+?=
 =?us-ascii?Q?eEQlk3qyCs8lR9RGwz8sxDrfuOlEz3sfxC24xHfS4QMthha2AlmzNRaWTFZJ?=
 =?us-ascii?Q?FRGKJu5GoUm6vEFSLjOZ0uqWgA+oiqRKKQ+FOpvfZxR1zsn4Wd+/AZ7NB3/a?=
 =?us-ascii?Q?cvsLR6gWPxjA/jTL1gmc+pjGBkaW9jQPkZ34kPF101x3iow+aSszw/9PgZ3o?=
 =?us-ascii?Q?HX4cvJFcDb9ZtFR615AK66XRT+FFq2PncOAyewhmlZPXbugYgwwo7BQgC0FV?=
 =?us-ascii?Q?EbrxUkF7onL3jII++VidGtZBUsX0yR11V93/W53Y7ikHHF+f7Eki3tydXbBf?=
 =?us-ascii?Q?Y6MrpFG6fTC4m9F55MAakYko54GJa1UlDwZlgyjEEkx9oT7V4pRBIG0lCUtx?=
 =?us-ascii?Q?LhCu8dWCvtZWVg/lRdm0HeXaN2gCV8xjbxH0yWp5WxPxI+NmazfPub/Ycwzg?=
 =?us-ascii?Q?JBp94pqYNmZZjdQqYM/ms1rNxkAU+vEZE7ahU2By9FrVASqa3ovLUghK5mqt?=
 =?us-ascii?Q?F+64lCfnY1xcOaHh9yup4/Thr9p2WELXIq1wQ/RDEE0touTf8GOBPCVeKmzN?=
 =?us-ascii?Q?XeqT9R9M0H65NWc963AgXjD+nz0qWCC3rVcVINDtgi9JK35KPg6NTzmAqMag?=
 =?us-ascii?Q?AgOrp/jz3RjPwd2Ylo9sMuYf4I9LSNpSiHHP7UCWSQ4fusqQUBwroEPOf5Ae?=
 =?us-ascii?Q?VAxaPSPKrvVoWK4Ue3pPIs/ad8GD/4tar6hHPTUGEPAu+PLkQHKbPiu4u3c9?=
 =?us-ascii?Q?SfKQ4SsRuR8SkFx5AYRgb31EeocQ/gJ6gMZinBEgi1BTIzTddOX0l1QagE5a?=
 =?us-ascii?Q?jhVndI6wWx8DxrqzFqXsd3uklqFWbnCLt07q+2/GMD3txgmmVEaIIpVMbM4x?=
 =?us-ascii?Q?jel7tyaCmvpsE+no75RKUyZLrn8o9FYrQfLgTfvHaYw4t84Ftzf1+tZkpyPx?=
 =?us-ascii?Q?siuaA+Hw2OyL1vYZvBMxjclEtrf+P44ebnmrYXclH3sSQ6IJkto5TEtixJJq?=
 =?us-ascii?Q?0/WUa4k2hWpgrgDm4lJa+09K3M1x7F8TGulnbLXXZUURm5xyZOwJL5/Oeuck?=
 =?us-ascii?Q?1ST3ZLFIA4fziLCcjqkadFpLmnSYHkK4mhmeRe3ivfTR/Mqn6QXo9EOQhFNS?=
 =?us-ascii?Q?yXCYc1sBg2Jv0hAiws8+V0kmoLZAIrBgWukLPyDTz22SnvgvjyUx1Jj5vSEX?=
 =?us-ascii?Q?NVzx92VoGef2lVoTmpKH7bIzjd1ugb4oyE+CgIYI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d14cc9-e772-4033-f95f-08dc28836d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:53:31.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhTTWyc5t1M8i8Wd2lD83qpLrBzhPVwEVSNON390TpZtX0zfmPKj8jFZQjA/agEmHCapjbgsY40a27tZRaXzlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5513
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, February 8, 2024 4:23 PM
>=20
> @@ -4760,6 +4790,12 @@ static int intel_iommu_set_dirty_tracking(struct
> iommu_domain *domain,
>  	if (ret)
>  		goto err_unwind;
>=20
> +	if (dmar_domain->nested_parent) {
> +		ret =3D parent_domain_set_dirty_tracking(dmar_domain,
> enable);
> +		if (ret)
> +			goto err_unwind;
> +	}
> +

there also lack of setting dirty tracking when a device is attached to the
nested domain while the parent already has dirty-tracking enabled.

but looks even w/o nesting this is missed in the attach path.

could be fixed separately. so for this one:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>


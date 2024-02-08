Return-Path: <linux-kselftest+bounces-4328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC96684DB94
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCFF1F242B8
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325216A8C1;
	Thu,  8 Feb 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dupE3k0W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9456778;
	Thu,  8 Feb 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381524; cv=fail; b=nqjQjxNzd4yl7y7B1NQkNzLcyXLBTfxBnVVjiKjnqCKqKkazCwh/0VD5YLs9X4PNx1JIgVF41aMZlceMegPMzum2uEZWia1vi0ZrJXJ3QQrUHY/8lhh9uLYa4fU0bIrd2Rs0nN2YNtnIVMmKTsn95p6VEbwJPwas7SQW4Jiir8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381524; c=relaxed/simple;
	bh=rywNTQGQRinYzdViFdIS2nZnF8qmo5+bcflJjR38gc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AWM2qIkvJj+NPcJQQf2SEUFIOKiFAwCa7InBc1WI1P0tHdsGEpbuSpyMTHJGedPXyYFXvWydHZ38l1fnF6FKBzAS1W+dsiKKz+akjv1oGkH2m6Oug4zHNK1OvYgu2wZxVC8L6lY0LupJ09qGLy00iPMzPoKgAPDWdlvOHDl2mro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dupE3k0W; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707381523; x=1738917523;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rywNTQGQRinYzdViFdIS2nZnF8qmo5+bcflJjR38gc8=;
  b=dupE3k0WCeXf8kB/MSTQEvLXBZANLjdqYn+x7eEar86XZ1N+IyhWW5dd
   1jv7XMFDycVa/lhsgqmuqPuIgO3fArcdxA5USIi6Mj4e++oMzGPfij2z7
   ZnPuPk/MK8y2VnxR/8zGHgBLO9AHl81JCTj4kO4Cz0RadbZmKTIom1iZv
   kHVwMFSnrLy5uys8jo3G3AC0XP85WOS3ZAXHUCXDzglHrVOFLNMYsHH9p
   d6tdajLnzKn3tfU2B7DgEBhhtAe5ZzrgK0tbaXIkahuheJxb5lZtvamAj
   Gz6+pDViCps+I6XxSzJ/N78B8924rrul7bFgqWVXsWWrecNEJYutEVa8/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1310682"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1310682"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:38:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1586933"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 00:38:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:38:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 00:38:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 00:38:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 00:38:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSSXZ1PheieI17T/VhzdBHwFC1Dxfvg8KGm3vavSJdAnaHnfV9ONo4e5oiyXgvCbKrxr+ZzPPKqbN+/10fVHoh0o/WzSUTkjxXJLaaq6/4Ycz2loMYmfWQuGnbhol8oFPpKRHMP5DEDreRuTrr5s/Y75BdBEU4f/nM0+hX4Lo/nT8N+Zp56rl/33CesggtX3Z5VTPGhimyVysQZZklileTTM6skzx7AyjqPRYpLs3uDC8wun0jOTiGvLKhC6UzmprBfCJaa+daZqsZN2gYptVzwKcv3VOAgWckc0fs6fKNCFh2ilH4m+JNu/kRzRtTEzXvAKUD/m+Xglh/p4l3mcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr6e1pXPrzkcInAxanOzf0YNHWpFu6sn+8nSxL4ELzc=;
 b=VPC+gOOKcS1rAnz/6Di8RHnwo2GX+VUgeq5CI9lczkrsbLFW+Avi0Rzwk/y2FwJS3GvweEa8d0j86/pM0H1+iypRVUTmO+nYS5HY+mlb4OVcEuztW84NEOZ1MTUASoveHdAIUEZzCkPW7jZpKrYeF8qfCf5TnvtdznDv9xgwmIhlfKCtURzagWnJuz9F8UhCJ590/H3tpN7iYoSeRnTCD6byyJ9g0csJwyfaR5wOPv7/IUPnWfRfg+sXi50PbUYehGx2tKOQ+Wz2os5RbYcl/pP9ARtwP0l5aJXvKlPGD8FaH0nuRJiryj+73bOlLxIp6gKoJxo+TscnW8NPoTE0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 08:38:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 08:38:37 +0000
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
Subject: RE: [PATCH rc 3/8] iommu/vt-d: Add missing iotlb flush for parent
 domain
Thread-Topic: [PATCH rc 3/8] iommu/vt-d: Add missing iotlb flush for parent
 domain
Thread-Index: AQHaWmgS9s4nHWTbYEOW0w2ULF5GvbEAHvWg
Date: Thu, 8 Feb 2024 08:38:37 +0000
Message-ID: <BN9PR11MB5276446E0F03C1F3EC6B2E298C442@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-4-yi.l.liu@intel.com>
In-Reply-To: <20240208082307.15759-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7393:EE_
x-ms-office365-filtering-correlation-id: 119f37c2-818e-4964-5bf3-08dc288157e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WKcZhddsvupGNOAFjpbQ1OCOBM/G6EnarbmqM2+28YyjHOhIKH3gpXs54kYECod9bCSzrWoef898AJO2se3thnX7UIgKckTiSY9jjHY/n52WUR2Gxf1UWxMra4iSKYYRK0rizNPiCLb1vvMcrHVgp+u0usfBT34zdaAppNyw9yGSTwaKhlYoqpy8dBc7aZkxUZk/0U9twQVcP3mRw5TXRIMXfdzjjiBm/ChFTf4Gjevb1sI54VdbvfLzIwPysNnKvI9svgoEBkMiCKd1becGyJ2jN/vsCShH7DkWtpsmwh9Mrncft2XMf2p11nIp6Q5BVLoFNM1nYFYEhS+S22qTN4Qo6YjVUcXxe7So3s2tU5AIFj40chDE794gyHNPIbO/IUu0HVKYazlCE3ZQ6LCEMRBZfUqtr3XCqo34jTc7anVrrgrt7HirtaKlMgP0/USmIH9rwqDOv2YTpNgis++u5x9kyKGiQWoq0icyUGF1oyEdFQ7b0KL9MgOfTypAagmOOEXCrJLfEKKSwI/1pEzXjG8G67hSHFIKAp5xaT/5TGQBsiiD+Bw/wAYOVP2ZorOBMBtDBcaYds1MRzDIt9fImq9xsgIdDfOTk42Bc2dg3u9W9ygaJQhlfGr4GnZgD7Y9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(86362001)(55016003)(41300700001)(33656002)(82960400001)(122000001)(7416002)(2906002)(4744005)(83380400001)(38100700002)(38070700009)(9686003)(26005)(5660300002)(66476007)(7696005)(6506007)(478600001)(71200400001)(76116006)(110136005)(54906003)(66556008)(66446008)(316002)(66946007)(64756008)(4326008)(8676002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?unhNa5l0nM15EqtRdnT3raRzlfHg4Gcq3PZgzGgH4HU9S/T5EWJJLMg0WtdY?=
 =?us-ascii?Q?TnYG27kFmwgSNheDd6TZ+Ewit9B4jMCkvATzezDdewy/FYYmnj33OQ5zDGBn?=
 =?us-ascii?Q?Xe6qbwAQaDApO6aVHTsKXBwSbjG26XynWacmiQ9VdXAhR+AST+fQKHixvnAn?=
 =?us-ascii?Q?IDKkgVtIU5avnwGk8Hnm47zDcCNfQtFw4Z0UiDFnSZ9o+SNtMcOcaAQRltPx?=
 =?us-ascii?Q?fvRqPzOPjrX6fgB1dh9oqNmHODeCDoNukr24Cb9UaWRLYIx59Hu+cryhdpBJ?=
 =?us-ascii?Q?Uph+7DcoReh3AnZBhUCBTzQxYvGGnU6aKupCH3C59Eb1HhuPe7ySNks5rMk6?=
 =?us-ascii?Q?v6IdvzzIkEJe7ZuldOT+QnJNKqVlqBexcEysg7lXvnffx0eWkpMCOQ8dHqYV?=
 =?us-ascii?Q?luxU49ekK0KBqxUBufwqlzy3BV/I9qWT1cNYAGjR97jbyyrIflrBevq0sQXO?=
 =?us-ascii?Q?iWGCj93pePmeI9v+YXOiHoxs9lsK353KJiDJA0LPHgRBC0JuMyOq/oX9uBlP?=
 =?us-ascii?Q?45AcufepluxDbQfnsTzW9VUMRe9qAtZ+T9CP0jmU/R6L+45J1tkCmWralVIN?=
 =?us-ascii?Q?JcLaHtT4AL8BjJKf9tXV3uU8tyCqFYGEjhh1yyhyykGvtCBfTs9Fh610fA8l?=
 =?us-ascii?Q?jPu3LKyAvqE5cVnbUGooB5c3KkzqFPZ1MLrQLBoq4YUmWMlV/TSuZymRaxcS?=
 =?us-ascii?Q?OM2TdEJIdcaEWUj8XkLv3ZteQGlkBin6LotpEjRkajMn6C6tn5hh/gmEniT0?=
 =?us-ascii?Q?BiB1SrP2OsgBwOUUqKaeXTrZFfdQDsz72rlbGxfKMQc8FKFxgmAxazbk49U0?=
 =?us-ascii?Q?ZjB4m05rCzGdfIO3tF4mVGqMNE2bKRUlBRvr9S813vZlGGgI5CcO0209NS9I?=
 =?us-ascii?Q?NjI/ffAJZl35lKt8IfskTYihafHd6USjOOcajClZNy4IJjuRQZko2FMyTKKi?=
 =?us-ascii?Q?vzNep32RzT4owp1pdIykhPklS1JmnHnpbSlJ9zRnKwnTEKZmUJ4dGxK9DBxw?=
 =?us-ascii?Q?+V2DKGwT/W5nXMnIutIuMRY+HcIN++sEsSC18M9vsdoQqhkvA4esDttJ6UHu?=
 =?us-ascii?Q?t5I7ugypA2sy9/TTY+tLr/XYwJwBosgjalvV1nlMHANoNtc1a9WHtrmY055i?=
 =?us-ascii?Q?Ojrxt/vxAI5A2yfUy1H3RS34cQlmoswVVSSbj6WWotxazBPgwYegfFvIHQmZ?=
 =?us-ascii?Q?3H4nR5kRhRbTk2EiFxS911Am6pa7Q8APT8EkVMfpRgBL5eWK2ARXP4O9QeSL?=
 =?us-ascii?Q?1AhpTbmFUcZYMjbUo+Oy4YUq2voZFky3PddMNmIS/AqtQ00XlnFIBF7ksvA2?=
 =?us-ascii?Q?O4Bom3dbnYVmz9lrJ79p1g1VqXBQ52bMVTlOs8aU1WdQodSgiS2tTX52KB6B?=
 =?us-ascii?Q?k44wvMq9q5QqdHwsc++cvY52Pk+MzsuHeZOWkJgQxur5TqYMBP5aXepRVfjR?=
 =?us-ascii?Q?b2AZkXuwKGDicWuNX7nz4knsCgpwJ0auba1ZZjqOk2VzMYHRgGrDuP0yXLlB?=
 =?us-ascii?Q?BIr+laOnlaJ7OEWjGG7S+L03IZU5dckDJEh0W+OwhO17KPS5muLoIfDgNX1o?=
 =?us-ascii?Q?ZChaowtfmgnWhFtIHU4dPaNnU7CJq9fQfpRQocL+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 119f37c2-818e-4964-5bf3-08dc288157e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:38:37.0542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcVyTq5+THNg/4uRWDH7b5XBzd3dfpPRIb/RgSq/S2yrut/bQPm0ZixMmcFE8x+NQOXPeKXQUk9qikniCm/4jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, February 8, 2024 4:23 PM
>=20
> +/*
> + * Flush the relevant caches in nested translation if the domain
> + * also serves as a parent
> + */
> +static void parent_domain_flush(struct dmar_domain *domain,
> +				unsigned long pfn,
> +				unsigned long pages, int ih)
> +{
> +	struct dmar_domain *s1_domain;
> +
> +	spin_lock(&domain->s1_lock);
> +	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
> +		struct iommu_domain_info *info;
> +		unsigned long i;
> +
> +		xa_for_each(&s1_domain->iommu_array, i, info)
> +			__iommu_flush_iotlb_psi(info->iommu, info->did,
> +						pfn, pages, ih);
> +	}

As Jason suggested before this xarray lacks of proper locking.

but given it's rc fix I'm fine with it. @Baolu we do need fix it soon so
this problem won't further expand like here.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>


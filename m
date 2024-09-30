Return-Path: <linux-kselftest+bounces-18578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F26989BAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22398283BEA
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5F15C15E;
	Mon, 30 Sep 2024 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWwD4bSR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83715C140
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681905; cv=fail; b=taz/lHajU0dGC4Ae5NECUBFZRahr4K2KnhZW+QDeaFBGHjAbD9zaaeKZcdVaJ4CEbOLcOmEQI+DXnllzXfi5oJHuMYWXkLj+8X75z7xfadH5WgwTk2T77YJAM5EAiNJGCxMfcEilPAUWUz4dj59XZaOCazV0LXRsnRPuTZCtp2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681905; c=relaxed/simple;
	bh=0gsBztD2huNJKPdbyKSbYGLMDoc9VD1xUXMaSvRs86A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kjT1KXrGNe+16sUBxDCGmN9uP0/GG7hU8qZXHhJJosKvSnCnbckdAUZJHDoUIfTIXb9RXQyg15OW0WWQySeSfenT1L1ZLx8PrMRSYvldP6XvCo3ZTZs734mv7W/1W5ZkgskOVo5QruOqs62/E/7T990MXg+U0jX/3KzsKt0hocY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWwD4bSR; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727681904; x=1759217904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0gsBztD2huNJKPdbyKSbYGLMDoc9VD1xUXMaSvRs86A=;
  b=BWwD4bSRJcy4jQGTyTsYihePCEzIVjttm5vZt+p2AmWbg1n6yCwLs1gS
   sdFtqRAmqJdIxnXhwKuN5i+qE4Hu5LpIc8vkr7lV07ZKQozEdwmcQf2mA
   axIFrOSQEsCVmOVfMCzAPD4u74jDFJVqS+JEPin5YPKJvWhR0rYZIX1pG
   e1J9l8Up7iZEP+TTGx4suM0xqhFjzZM4TxygWxH2LpcEMJsPGk3u53cDv
   ZPm090ZYd3SZtqVDqWDdJXZCAwGzmnzjR+cdmSqb3ZOQalHKQnblvpcnt
   mEZpULvf1iHrFMqra0XCN5gS93s2oakGKWHk1K5kinzDNkOXJV5KoDcSF
   A==;
X-CSE-ConnectionGUID: w0oyEVdeTiqQ1u0qXAXmeQ==
X-CSE-MsgGUID: 5pVTxWklRX6It6K1P8jO9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26633016"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26633016"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:38:14 -0700
X-CSE-ConnectionGUID: EVj0ujiWQLmJIVuotC7rHA==
X-CSE-MsgGUID: u8RZNWvTS+OxTwoYzzchaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="77289000"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:38:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:38:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:38:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:38:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LszuyJKWdymgyky0xlU6wX7pUbyEeRVHyTVxQ3EvfEfjuKDqmo7CYrKwMUEP02uj3Di4Kias4H0aoPBdqnFjuy0isFGdqk4Q9bc+HPUoDP03Eo2p7+WH35TEqMLnr+deklRi0SdSt3MNSezhNFoDzaYzqXzBGJphg/VgPYrsAoD9rcLB8pZWsvQajZTmJox4b8uXOOcAMrd8Z4nkl67a/nbjR/VTD4PynyoeQ4uilZ/Qifo+IVPRXiDfF4u6rlLyt4ud3mpFt3wbpkH8/PtlONlMMmOvtgOpJqiXi8mxg8MgGbpqqDNxQrD937gcsq2KCbN5rNNgQNDkWjs0nsZcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2WEQO/06/YIgP7GOpFcUIS7PgFAQAvFg8Do0K8bp0c=;
 b=Ih9bK4zCvBt7vhumexHhkZkvOgSFNC8gJotmtQHotGLsEqKLMJ8pMBDwZgjIBDbmtktGBfnkIw7r2pw6Nn4vMf4cw60LBCl8vnqt2tjHgZUKs8G55KEi8tO4Ccx76pmhhFbU6AB3CT/46GC+EeAFWUKaLEA9n0XXUmm9z0ak4aMpW/xPILTL0DBMJeG+ryg4eJUPERTkb5JQ0j9lDKS47nW7zdD9QurEdMsji7wa//WcB94clVnUF9GMOgxilTibJ8+dUcqnsVO23OE4Kd5ZOBFmNQT1Z8DxKlV9e7jBitJ00//D2Tte3ZvXFU5Pq8mCt2rl6OQP/bccma+5c2Kjig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4549.namprd11.prod.outlook.com (2603:10b6:208:26d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 07:38:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:38:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: RE: [PATCH v4 01/10] iommu: Introduce a replace API for device pasid
Thread-Topic: [PATCH v4 01/10] iommu: Introduce a replace API for device pasid
Thread-Index: AQHbBRWIjkn03FPkpUGJWPZrIFoSdLJwC28g
Date: Mon, 30 Sep 2024 07:38:05 +0000
Message-ID: <BN9PR11MB5276B0F09778D03BDBD7FC768C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912131255.13305-1-yi.l.liu@intel.com>
 <20240912131255.13305-2-yi.l.liu@intel.com>
In-Reply-To: <20240912131255.13305-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4549:EE_
x-ms-office365-filtering-correlation-id: 2657930b-f052-4853-0c8e-08dce122d245
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HEs1dzzWayhyxnjf+1TA1oOHpFRNu8h+Ei8Vdj0XBd+TM9mOojkrE0fXfDO7?=
 =?us-ascii?Q?aVV38of64pI8mHafBXi/fboksvd8dHFY4iBLQRHm1KPduMR9OO75WJ4tOQIl?=
 =?us-ascii?Q?eIJ5uj9bEXBItOP8k5+u4FQ/GKTO8jLPWZeF0+jT/EOpLR2RJfwzEZkSqE/m?=
 =?us-ascii?Q?VkGDFSPySJxvSX75NrsdGcj0LTP6FGGZZcf4N+0HHMR2clEwanCuSMOQ/Olx?=
 =?us-ascii?Q?HgPvb1DjVgKKN6tPWxNIkxKIdokjmkZ/KvUNbXTtdYc2iMtX6pwfUFMHzmcr?=
 =?us-ascii?Q?UEXOzht+RuZzLgoUSosaIW4k5qyDX/txAB0tBuKXr9XTiSoKD1R3G+bXkWI8?=
 =?us-ascii?Q?zAh0PiYx6btHePo2jJ87dC6PAr2jRDO87Sg2SLjWCHJkRiNSluy6T7fQrYym?=
 =?us-ascii?Q?ktkDxFI7Nx3xkWWZl9E06N05lKuoeOhh0QRCk7Aos7Hcgit7Ni6JYdgqdaDU?=
 =?us-ascii?Q?2bAvxS8G/SmgA4BtnhJg/PnTwO7ERuq+G51/uN8x4QQuCn2gkeAQtrzmQrr1?=
 =?us-ascii?Q?Bz1vGyN14gveqS8kK02MaX1R0vqTNfXbJlYmK1guVNKnereQH3fFPntfZbWf?=
 =?us-ascii?Q?y0n07LW9qkMDcWwvQkb0Jmt8z5CnAVfTfQfl8j+s3aelWvlhtGzYOzUwYNxo?=
 =?us-ascii?Q?H4LnQSS3j0H4bBYPCP/g/aynY7pQS9aV2V0HXMCxSKo+VW27rIZ/BeNeTuxS?=
 =?us-ascii?Q?kOlYWxonU0EgRdswwsx2L2Lo2tTbdI3m5gh1HXin0Q1uN8Sd6hMhgRMVVQJB?=
 =?us-ascii?Q?LZJmd+jvOpNogj4U9z6HoYoYUgE3LH/4Z8VnV2maUPiyTN0yhUmVfm5eiXu3?=
 =?us-ascii?Q?Wu1zo2eZkEwvJXPjjkHQxiEeeSwIxv65SoaRyjNnR/2cM/oODAXck+pOj/L2?=
 =?us-ascii?Q?NSx3cd2zcX4xpFo5sxgPRB3LZttHwTdz/Tgv8cO3WHvBsSDvKTjSTRq3QJNq?=
 =?us-ascii?Q?lpLOZZVe9xlYIzTO/84PbcU6j3+H62jsqXhrG6F2Cmojd4i43pCY3zKkF8g7?=
 =?us-ascii?Q?oi8arUmT+LFbypYgM8FcvSfWNH+NnD6DZA1F8fds9JpgXspKSv1mDhs8GKcr?=
 =?us-ascii?Q?e+BNXq4SxJ4/jshhnhVfDh3bHyP/It+YdBlVcjT+XuJV5Tx/VDU9AmbClsV+?=
 =?us-ascii?Q?YcX+vkjgOCauXi5IINt9ci+plociWx0WcHeb3a5f+FTb9IO41PPbcrgDoSuh?=
 =?us-ascii?Q?Nqm4VseCgdNgsfQkeoNs3Q3k2/wl9N+AIgznVjzcjcraG0w9iKJIDRsIZDJF?=
 =?us-ascii?Q?9ULFv71o1swhNqw5a5CEbOjIV8B/wOsZeud94XJX8A9J7iwOaOJrNZymkDob?=
 =?us-ascii?Q?GhTP6ID+7ruCrpmAkLg05Qb8hPKwWzJZl0ouPBuEgelzE5I+OGffAe/AV8RR?=
 =?us-ascii?Q?zUddcFr/vTUMSgV/LWNkwJcIzBBH1ooa9pGSvg5mmV6Tr39CvQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3H1YKTOwcWtW+/gVklCQQfn1k+OHxkXbzxZlscJNeLzRhJjJjJjW97Cqn+HI?=
 =?us-ascii?Q?n6XAcfePjelq6D6MQr6Y+yvsbpzX7XNWtb63XGvgYPV1nh9N1t7e/6xygqie?=
 =?us-ascii?Q?hRqncEZiRNl9uJEHY6mpx8it71FXJROestlR3bCyRh7kZBBhz+OAYHY6eW9z?=
 =?us-ascii?Q?Wln4mi3xlpeOr0BAS9L97DqAppeDKLqM1VrB8TT8kg0e7d7UXpWnGMhQbFL8?=
 =?us-ascii?Q?+xMi41ugE858EhJYu2sQWZKuo6bfgWv2GFqEFudbeNPWe495K6TNwr2dMfB2?=
 =?us-ascii?Q?5NhJolD5AWWxVUtd1HPWbvWptA5Or0UMgY3+H7iMGW0r1Zj/dZhK3k5LyFnt?=
 =?us-ascii?Q?GWuhPRH/RjBEyPvuuAEsv0/pN0w+no3T2KbN4DtXY9n1fBtoDGCOcLQXvdIq?=
 =?us-ascii?Q?noYMYAabXTMWb6cv1zZKb61yLdD4HadSquhrmC3hDIH7ET6cD87Lm/PRbHqr?=
 =?us-ascii?Q?AWUF2Mm1kUjzoo4wnkEak+rzAUozGRT1nIhDBlil8i0tQ1uVowGkSsnHDbvW?=
 =?us-ascii?Q?yhMPkYLtyx0ZmWk+jSzX7WPtxZgYfTQ94IBGdMFfe21lYpLd+TF3pHBjXe90?=
 =?us-ascii?Q?TNITe7Ih6zSKwpKWZDc1Eoh3cKr8gsquPsiAHS4TeSGYUzdi/dOnAlmWRKW7?=
 =?us-ascii?Q?ruBOQpUMyToSatrtyh29W2Nw7Jl/Vs61fHGDlyRtASiiKMymN0UamkqhCwxa?=
 =?us-ascii?Q?XNu4aR+ZAvIUq35bY3LaOPTWa4n2rrMANQY2kHO90xOMTnilPfHX5e7mpSG7?=
 =?us-ascii?Q?vtLAvY0kjrKN/+Xri2UImgCD8BK9t8AVeUQgTPcOtSaWU1NFSxXpZWv92oLG?=
 =?us-ascii?Q?P9c/yyWzxkxdpGe3nAuh5EXvJF8eCEIzLv8HlDpYLVmb5saaiWehAX431UZO?=
 =?us-ascii?Q?Pdm6f14soNdPHmse0s7U/nMMATlcm40dTR7fmrOVBa/sqqycXW1Io0p44yJE?=
 =?us-ascii?Q?aVdgWiGOybFfgQ1GWtHlNJqU6mnqRNCsWAtq/2MHEqCAB1E4rar8o1tZMoXV?=
 =?us-ascii?Q?gWdNHZ57FvFlG24erxd4CW6UOy4Bx0juh4N5bOnVGKFnMIp03Oy98bGXwQd0?=
 =?us-ascii?Q?bHxArjzPGmovmHMZHZgr6wtze7A2BRdFctXqvgrl0mwkve2Vdt+kjLuDZnYF?=
 =?us-ascii?Q?g7ee/TCu7B/Hoxj6uKYjzJqOC7kJ7PdaxUw3eByi+4H3fUbleb1mXem7esuc?=
 =?us-ascii?Q?p1+GHxWiN1uxqD6fDFiQvD7FoB6z5Bf5zip2zyiE5C4QDWi9ZuGawuJlU0co?=
 =?us-ascii?Q?EoA8s7dGio+8Ol3tVxqzEaHVGiJCC8tCWZCV7xHOrJlaj4iXub9/+VDMdnys?=
 =?us-ascii?Q?Hcd2SvQhWb8ipVlK+3U5mIsDo9/3/DLQ6f64Zz/O/ludWoNazYnYu6Kbibi8?=
 =?us-ascii?Q?BUhnCWgetysg1iLkZDnxsogcxTN0r+RUQlgz1Mnon0hB0ewbCfhyo0Yq7qoD?=
 =?us-ascii?Q?J1WXcweyP+yksPEtGquDf7mYwxYSsIXnkHauAh3gd5DXYr72IlpnhpKN4/Tc?=
 =?us-ascii?Q?ROV1zvNq70JJL2QwYldLJUh3I6qzJa/6ZV1atX16j04eeWKjh30WGIb02st8?=
 =?us-ascii?Q?BV+xwUcBslzcNyseAmX4kZAFIOqYfOuAft8Bkwfg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2657930b-f052-4853-0c8e-08dce122d245
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:38:05.2394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KND21r6qKz1koMTNI523eRBb6LvAoRKbyKXVCFV6uwzqIMa8zp1k7WSnXYhzOnCaGYDqfOmUsvTdMybjvhP+5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4549
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:13 PM
>=20
> +/**
> + * iommu_replace_device_pasid - Replace the domain that a pasid is
> attached to
> + * @domain: the new iommu domain
> + * @dev: the attached device.
> + * @pasid: the pasid of the device.
> + * @handle: the attach handle.
> + *
> + * This API allows the pasid to switch domains. Return 0 on success, or =
an
> + * error. The pasid will keep the old configuration if replacement faile=
d.
> + * This is supposed to be used by iommufd, and iommufd can guarantee
> that
> + * both iommu_attach_device_pasid() and iommu_replace_device_pasid()
> would
> + * pass in a valid @handle.

this function assumes handle is always valid. So above comment
makes it clear that iommufd is the only user and it will always
pass in a valid handle.

but the code in iommu_attach_device_pasid() allows handle to
be NULL. Then that comment is meaningless for it.

Also following patches are built on iommufd always passing in
a valid handle as it's required by pasid operations but there is
no detail explanation why it's mandatory or any alternative=20
option exists. More explanation is welcomed.

> + */
> +int iommu_replace_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid,
> +			       struct iommu_attach_handle *handle)
> +{
> +	/* Caller must be a probed driver on dev */
> +	struct iommu_group *group =3D dev->iommu_group;
> +	struct iommu_attach_handle *curr;
> +	int ret;
> +
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	if (!group)
> +		return -ENODEV;
> +
> +	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) !=3D domain-
> >owner ||
> +	    pasid =3D=3D IOMMU_NO_PASID || !handle)
> +		return -EINVAL;
> +
> +	handle->domain =3D domain;
> +
> +	mutex_lock(&group->mutex);
> +	/*
> +	 * The iommu_attach_handle of the pasid becomes inconsistent with
> the
> +	 * actual handle per the below operation. The concurrent PRI path
> will
> +	 * deliver the PRQs per the new handle, this does not have a function
> +	 * impact. The PRI path would eventually become consistent when

s/function/functional/

> the
> +	 * replacement is done.
> +	 */
> +	curr =3D (struct iommu_attach_handle *)xa_store(&group->pasid_array,
> +						      pasid, handle,
> +						      GFP_KERNEL);

Could you elaborate why the PRI path will eventually becomes
consistent with this path?


Return-Path: <linux-kselftest+bounces-18435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85100987D01
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 04:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AD31F248D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 02:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1115316BE0B;
	Fri, 27 Sep 2024 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DT/it9Qk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5004A16726E;
	Fri, 27 Sep 2024 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727403804; cv=fail; b=Dx/F9ddl6fzCxVhBWnJLp5RE5e56phyqT/q2BPmyhBH1Opi9ciQ1KlUDGEmffcBHmpliwp2yRTrKNWIOcgBi7fWfrcCjJY9b/RXmyWnJYYewNtS5VhBNk2yKmDy9F5+9GbgjL7lesXJkAqbU1rgYyvdJ5s4DX0IUMOhZBZucxBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727403804; c=relaxed/simple;
	bh=TBEyDjmIVg2fPocw7LQXsIPAqn661BqpQ+M2Nq/b90U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hob3Ou+T0PzORfCs3T4oIKPn6WEcGruOk3bWIWhGMYzYXFi1q2elpd6TeicGDp1pp5FKjaz2wsbCoCmYeOMjma21KRYEvLM6iFUJPYNAau5vBsWsj+tNJQA3FwWNPhiZnGlyEEjXylDjFhi/Hhh5MOI9neOrRUZEtCOJYr3ORBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DT/it9Qk; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727403803; x=1758939803;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TBEyDjmIVg2fPocw7LQXsIPAqn661BqpQ+M2Nq/b90U=;
  b=DT/it9Qkhv+lgbT4HHAO74f4sYYb19XBjT1bpVup/wKEmiLfC0+0VSNW
   8NSL2irq8J2BswugaiGRGZ9CEn9DZvYBkv1kL+aIcfSAXYq1z1TCw3OAr
   s9Xao23b0vdV2wD1+yCbXuZS3vrwKz+5TCWAC9AzAX9sXxChLpQ8UwZ1c
   Llde5C2YDMvCQtJeLEVCdP2QzgZSv8AJ6Tcp7/UKlZXorLTlsPQLksbZp
   fp/yR7hnz0/XXgE1WYE/DSFNNH0J8l7kRnWVaX6NGEKHVcJeH2Z55apmU
   FdrsdlKhz4IxMast9vUctrfqUBBIofbWhr1egUEyCoCv3c+nIZlw/QQTP
   Q==;
X-CSE-ConnectionGUID: nuK1g+yrSC6K1AfGrnQUtQ==
X-CSE-MsgGUID: eudahqNgSCCQberbLlDvDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="49066158"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="49066158"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 19:23:22 -0700
X-CSE-ConnectionGUID: MtcK0BhCSNWeUVG8X3mg9Q==
X-CSE-MsgGUID: uM52nNp+QBmm8hJMPNcxKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72796818"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 19:23:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 19:23:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 19:23:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 19:23:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 19:23:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpgoWonUmlexYM9vwkIV3qUaJ7sOazgATtOv8GzDDU88UHgv39nLEH1sLBlDk8bhZNzLf75OUNsbcNjhqVkkRNWvlBuIzxd6HPsSgj7EwWlvZuN6YeilxUJcz5ZRxCbEW4dkVEzToFG1cmr48p2DCDbTgsRfskk2HqkVEiK5mOMdrW7/GQ9ZoIN6qhtuS98NSmRSNLkeubBY4x9cvs7Bs4bSWL9/bpJonG5c/ZVCtIM+rk/Q8XhZjhHQdeFcaWtjKFvi2uyiQpqvm6390o5SzwOgiRiBUmLNatOvYFlk/7kKfsqm+draTx4Dt+y5YxyT9LnjGMWlMKovoU7wB229Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBEyDjmIVg2fPocw7LQXsIPAqn661BqpQ+M2Nq/b90U=;
 b=LyWSvp2zH9hwlCNNhnm1FiVqCsA9Uwo+yw5E9Y1ycTgTa0wwZNQr/fEoYu6JQqRXVxPT3d+nofwV001ab7J4f+Egs27ZY656UwtNjl/F5rYVVYORxmSfBQwdyi5RTSb+vgmtMy8ptG5cfvDmZAXIck6J0RADPR/C1+TkbwXKuisw8m9w2bOg1wO5VdPXLNP2d3pQQ7v8m6I3/vUIsqFVJL6xoWTmCpte6vzmUaiam6hb1MV+2j05w40bT2VsvwzW2aQx8UtpmsDro6TTDjXZvvotFgqz0hyL2EhvC/QngViAAD5+mABmjmrtsgJh/47KjCn6bXCc2iD1gNfYGQJITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6315.namprd11.prod.outlook.com (2603:10b6:208:3b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Fri, 27 Sep
 2024 02:23:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 02:23:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>
Subject: RE: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Thread-Topic: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Thread-Index: AQHa+KL+WnU1UabCs0ODhwaBTMTv+rJp8RQAgAC984CAAEt2UIAADJSAgAAPXgA=
Date: Fri, 27 Sep 2024 02:23:16 +0000
Message-ID: <BN9PR11MB52761E58692F05D741DAF2758C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
 <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
 <ZvW/vS5/vulxw3co@Asurada-Nvidia>
 <BN9PR11MB52763F8856FE20ACACDDCCE68C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZvYJl1AQWXWX0BQL@Asurada-Nvidia>
In-Reply-To: <ZvYJl1AQWXWX0BQL@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6315:EE_
x-ms-office365-filtering-correlation-id: 712075f6-6494-4bf4-c8a3-08dcde9b5886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZTdyU09kTnd5UE91SEhZajIza2JVTm4yVEJPaFA0U2wvY3Q4L29aVGtRaWxu?=
 =?utf-8?B?RE5xblAyc0V2QmhOWDd0NWpPOG1kNzlVOVlnQy9uTGRUM0xVSDQ4UStIbVVF?=
 =?utf-8?B?VWZpM1hrZmNMRkpWSDViMVZLYVdtQnB2RTNjRGp4U0tnTWU2clloL2hwMjIx?=
 =?utf-8?B?VHk1YVUrSUFraXhGNnN0dWEyZUtSNkVYSW96aEcrU01VWjkzdWsyMVg4bkEy?=
 =?utf-8?B?MzZkb2xib3FrNUFudU5yR1hCQWRWWVFyOFUwTGZrWENLbzdRUTN6cld4VVFP?=
 =?utf-8?B?aDlHcDRlbWxMTlRPTmFJS0J5bjBXTHNMQ09lVnRhUG5xNG1kT2Qzaklob3dR?=
 =?utf-8?B?Q2tBU0krdlVEeVZuenhrb3RhWjY4Z0JJZkkvRmx0YzBqdHEydUtjN0I0RVVW?=
 =?utf-8?B?MXlzUUdLSU1oYmwxaFJlbjhWM2R6b3pjMHZpRE81UUpSSCt4ZE0yWS8xbzU3?=
 =?utf-8?B?TkRsYUJXTnZTQ1lnNXFTTWZyaVVnSlNmMWZaWmE1RUFXUEJmSnRWQ3BXMVd2?=
 =?utf-8?B?aStoemlWWTlKWTBYblZoTmpGR2pQNHNHWmpMaUZ1dEt1WWRPWFkwM1VWT1RI?=
 =?utf-8?B?OVVtYnRkakhaSTZPWG5reEg0Z3pjbVRQK1pWeFlWUzdvM1ZDQ1V1dDJ2ZXVY?=
 =?utf-8?B?bDI0ekQ0Ry9YUzBkU1NIa0Q1czlQelZmOW9yL20rd3ZORnJxQ1pWZ2RNTHZ4?=
 =?utf-8?B?ZzhiZ0FBdHAxUzQ0WE42azVJaVdTNFdDV1J4ejl2WDRlT2wzUGk0ZFloZFJT?=
 =?utf-8?B?YjBXVWIvc2lybE9QUHNRQ0pubmtSMGFndWJrUUlLZmJoZ0ZqN0xZT21nNkNQ?=
 =?utf-8?B?b3k5ZjBIQmxaRkZFVWpkTUw5V1dPcm5la1lMTXNCamJ4QlBSWXF5WmlSUUJB?=
 =?utf-8?B?UHU0aTNmUFhDQzBXTUlZK2ZrUG9xVjJoczd6OU1HcWM3QlFrQ2xCWVBuak5Y?=
 =?utf-8?B?c2ZKK2cxLytDMlNPYnArdTVBbmNVV1dabzlWNUpvNVN0T2NxNk54ZEhHK0hp?=
 =?utf-8?B?Z0dwdWx5Q3hTRW01c3FpdzlUbEJSV21hNGlOQmZPT0tybkUvdFUzVXR4ZmhR?=
 =?utf-8?B?NTZLUTRzdVN5dW42UDhQem9QOEVSa1M5ZW45RmdrQzE4eHQ3YlRIRC9SRXFK?=
 =?utf-8?B?LzZnKzlxR09MdVBmYmxScGxET1J5NVovemdvdlR4bGxhbVNEdW9Ya252THFm?=
 =?utf-8?B?R1d5dm1vSXV1YUNSZUFOYjUvZ25ZbVAzb1FaVGt0cmI4U1NyTUxhRHNrZld3?=
 =?utf-8?B?aGpPeXBKQUdGd3NYRGtMeHNnN0tPWUlYMVd3K2R2amVmOUcrQ21PWStvdDlL?=
 =?utf-8?B?TFJ4MTVZQ2Mva1ZZWWZwcXpSZzJMZDBDL3NlWUJmZ0J4WUZvUlp1bFNicTBM?=
 =?utf-8?B?Sk03azlTWkt6emxYUnNPdnEzd0ZFeU43QjZZaGF4THFhSG9rR1pvOVZDT1Ri?=
 =?utf-8?B?Q1ZoOGpGSndzV2FQM0xkNlpmckZMait5T0ppbjhzakVFdkdYV25wY1ZZVjQ4?=
 =?utf-8?B?QTFFdFZZR1grYStWUVFzY1dMRlNPQ0xLSGJidGs0Vm5kd1AzMWFCSjZmMEdn?=
 =?utf-8?B?YUd3cEZYUFlKcFNZTFVPMUxRSWxySHRYQkZGeldnRzVONmRsVGhQMzhENWFj?=
 =?utf-8?B?Y21zRDRlVGtlZGY0b0svZEtkWWRMYU1EcXlnNzZLNERNS0FLTy85ME9yM0Fz?=
 =?utf-8?B?WUtJYXUwYU1JMm02T0I5cEc2YnJpTGNPVnlaWVhEOS9KMGFnK0M1OURvc3Jr?=
 =?utf-8?B?TmpTaGhTOGF0R0xwb2RMdldpSXU2UXFSdWRDYlNtTUY1bXhIejREZ3ZwVEFv?=
 =?utf-8?B?UjVtbTl5KzZndlZnTmM0YXRJL3FMTDJ1MWY5TlNQWDVWc085dU9QK09VYVJM?=
 =?utf-8?B?YkJUU1JsWHRkT2ZxVGxrRTFGNTdEalpVOFpYZGVGdjhUWHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVJYOHJJT1NKMFdSVGxLZ3NNQ0cyRmhlRlprWXdUZGgrWU9VY0hXWGJmQkl6?=
 =?utf-8?B?dlR6and3ckFyQW9HYXlDQTRQTGkrUi9sN01ObXVBZUJ0VUxKTGRHNzdDNDRa?=
 =?utf-8?B?NkdCSktIdWx2NllodWJBbmN4Q0ZXUHliMmw5anFmRjJjRE5VSnZnWDdrcGJ1?=
 =?utf-8?B?UmtNTjl1SEoxekJXVXdzTlYxY1lBOWxRaVR5Q1YxOW0xb1M2SEdGb3VPK1hn?=
 =?utf-8?B?RloxOVV1QzU1MGwyeDBtZXBsZnBQUXBFa3dmVVlZSmhJYUxBWGloQVV0a2VU?=
 =?utf-8?B?NlpqejdURlF1VjE4Qy9abFIwWVZRZmg0ei91VHpNck9pSFNTUm9BdUsycVZI?=
 =?utf-8?B?NDNzSTNzZWZYUWN2ZG9tN042ZEFKVWpvTTkwbnZNaHRobmpaZ0tVbEJqcnhB?=
 =?utf-8?B?NUNpQ3VsUTlzdTVmK09SNzVKeTBBRVBiRXp5N0laTWNPTXRxWVdvclZPRW1H?=
 =?utf-8?B?VzEzdHNya25nb0xxdjIvWDhZZGdEUDBLaDlUOTNLVzI0cUtWM3NmVlNORVRp?=
 =?utf-8?B?K0dhZXVPeDFXajZCUldVQThDcDl0dEc5MmNFUGVHc21wVnA5cjZsWjhHK2xk?=
 =?utf-8?B?Y1lNWmFUZlo0eDFXbWZOeGRNZFhOdHZoRFo4RmlWNXJZMDNlMWlSdmRRTUQ3?=
 =?utf-8?B?cFZlM0M4R3ZRZmU1cUJYenhCWTJFY2hnbnBkdy9SSGRtOFh5ckxybmVsRFll?=
 =?utf-8?B?Ris1dmxZZWhUVmVRUW9LNWFCdkYrWU5FSGJCakdpcE01SnMveDJTWWtOcjRE?=
 =?utf-8?B?a0ZyT0RIU29WY3NleWxHd3RRYUt6V0ZXVktSS09UeUJYZ0xRL0I1WUY2cU9Q?=
 =?utf-8?B?NE81TjQ5bFRrb3BoY1d2V0FpakVkT01oT3VheStwUzJjZ3lTTXQ3WmNpdFdr?=
 =?utf-8?B?aUxrS0dTcnlIajJBN2tXNk5sdnkzTnBFdkdKUW9YSGtiTTBjVENRWlFUZGJJ?=
 =?utf-8?B?MmZkSHRNdTNzQnRLc0JYbGRzMUg5dWszVXA1NXl5THIwcDR3OTZ6cEFCbExi?=
 =?utf-8?B?K256NHc4dUcxNGNNUEw4RzNxK01Bd0hiWmNPSGNzWGV2dEY1UHF2b3FJREpv?=
 =?utf-8?B?SGNlRVhHczJwQ2VLTGhvdFlOVlFnelUxZlUxZjhEcGJHcWdKRDZESkdmUmxi?=
 =?utf-8?B?L3JwMTRwTmVSc2Y4WE9FR29lUVZEdUdFQkNYenRiMmUwZW5Pcm9oTFpSbTJt?=
 =?utf-8?B?bFpyN3pXRXpFQURqRE1rcTFIUzVMalZIenpibVNsS25iM2R4VVF1eGlncGMv?=
 =?utf-8?B?WnZtdzZpQ2JGem1DbXVuSVFUK05lZUtuVDZ0U3VCUXFabjVobTkvaFZ6bktn?=
 =?utf-8?B?cnNNUS9yejZodEZYWlZlNk5CZmpud25VRW93eCtNMTIxUlZHRGhzWFlNRVlX?=
 =?utf-8?B?a0dYVEYyY0JUL2RzWFpsVXptZGVkMjZsMzl5TlRQbnVqQ25tcTRYc2tOcnJQ?=
 =?utf-8?B?Z1hvWjFPdE95b0pUc0ozaGVrUm5Dakd3MCtrelhLTHVpbklEME5RRmJkMlM1?=
 =?utf-8?B?VnZlTVNjR2hzK0VrRG9LeTRUazFEZ1ZidGpjVFhkVVR2akVDbWV0WE1MbTNl?=
 =?utf-8?B?MjhqUEdaVlg5dXprblV4SzFWbkp3VDk0ajdob3Zya3lrRURtbStXdFRNcDZY?=
 =?utf-8?B?Zk9OOEJMZlA1d0JJTFpzQnZtTWJLL2s1ajJmYUw0c1RicldCQVI4UWNNZ3Iz?=
 =?utf-8?B?cUczdEphczVvU3hCRnZQazEzNStQNm10RGliYXNBUXZRYnh1VDN6TnVYSHZS?=
 =?utf-8?B?STlxWmJUeWM2TmhtN0J0RHV2QVZ1MlNkWUJZRzJVZmR0YXlxcWsrSE0yY1FK?=
 =?utf-8?B?cXEvYngxaDBzTFVMZjA0UmhoOEduM2xWNjNMKzdhek4zYlhjMmViQ2pBT09I?=
 =?utf-8?B?a2RudXNJZlhYd0xIZGkzcWdXV1NrV205TGFhdGVwL1BSa3pWZFBLUWZWQ1dT?=
 =?utf-8?B?MTE2d2F4ckg5KzFiOEJKS1VjdkZvR3BML0NackNFRE1vVjJWL1haaUJxTzVm?=
 =?utf-8?B?Y2I1RnBNYkRZRk8yRS80eWk4UTNlQnpTaWRNUDZ0NVk1OEdYSFFzb0I5M2ZZ?=
 =?utf-8?B?YWZKVTMxdVFWR2VQOHVxVzI1dVc0Y2hzSHpGdmx1Yis5b1FvUnA4Rm5udi9z?=
 =?utf-8?Q?jZdJBwt+Z9MweJ94QXOv4Mapk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712075f6-6494-4bf4-c8a3-08dcde9b5886
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 02:23:16.6133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ENLW6fJnQtYCfOg5JzB/N7IRwe5bSDCWtFU3m8iHILdd24ODmwLbRZU1nji2NZXLaXnforkJvMt2Rb0S6tipQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6315
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgU2VwdGVtYmVyIDI3LCAyMDI0IDk6MjYgQU0NCj4gDQo+IE9uIEZyaSwgU2VwIDI3LCAyMDI0
IGF0IDEyOjQzOjE2QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gRnJvbTogTmlj
b2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5LCBTZXB0
ZW1iZXIgMjcsIDIwMjQgNDoxMSBBTQ0KPiA+ID4NCj4gPiA+IE9uIFRodSwgU2VwIDI2LCAyMDI0
IGF0IDA0OjUwOjQ2UE0gKzA4MDAsIFlpIExpdSB3cm90ZToNCj4gPiA+ID4gT24gMjAyNC84LzI4
IDAwOjU5LCBOaWNvbGluIENoZW4gd3JvdGU6DQo+ID4gPiA+ID4gTm93IGEgVklPTU1VIGNhbiB3
cmFwIGEgc2hhcmVhYmxlIG5lc3RlZCBwYXJlbnQgSFdQVC4gU28sIGl0IGNhbg0KPiBhY3QNCj4g
PiA+IGxpa2UNCj4gPiA+ID4gPiBhIG5lc3RlZCBwYXJlbnQgSFdQVCB0byBhbGxvY2F0ZSBhIG5l
c3RlZCBIV1BULg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU3VwcG9ydCB0aGF0IGluIHRoZSBJT01N
VV9IV1BUX0FMTE9DIGlvY3RsIGhhbmRsZXIsIGFuZCB1cGRhdGUNCj4gaXRzDQo+ID4gPiBrZG9j
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQWxzbywgYXNzb2NpYXRlIGEgdmlvbW11IHRvIGFuIGFs
bG9jYXRpbmcgbmVzdGVkIEhXUFQuDQo+ID4gPiA+DQo+ID4gPiA+IGl0IHN0aWxsIG5vdCBxdWl0
ZSBjbGVhciB0byBtZSB3aGF0IHZJT01NVSBvYmogc3RhbmRzIGZvci4gSGVyZSwgaXQgaXMgYQ0K
PiA+ID4gPiB3cmFwcGVyIG9mIHMyIGhwd3QgSUlVQy4gQnV0IGluIHRoZSBjb3ZlciBsZXR0ZXIs
IHZJT01NVSBvYmogY2FuDQo+IGluc3RhbmNlZA0KPiA+ID4gPiBwZXIgdGhlIHZJT01NVSB1bml0
cyBpbiBWTS4NCj4gPiA+DQo+ID4gPiBZZWEsIHRoZSBpbXBsZW1lbnRhdGlvbiBpbiB0aGlzIHZl
cnNpb24gaXMgbWVyZWx5IGEgd3JhcHBlci4gSQ0KPiA+ID4gaGFkIGEgZ2VuZXJhbCBpbnRyb2R1
Y3Rpb24gb2YgdklPTU1VIGluIHRoZSBvdGhlciByZXBseS4gQW5kIEkNCj4gPiA+IHdpbGwgcHV0
IHNvbWV0aGluZyBzaW1pbGFyIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHNlcmllcywNCj4g
PiA+IHNvIHRoZSBpZGVhIHdvdWxkIGJlIGJpZ2dlciB0aGFuIGEgd3JhcHBlci4NCj4gPiA+DQo+
ID4gPiA+IERvZXMgaXQgbWVhbiBlYWNoIHZJT01NVSBvZiBWTSBjYW4gb25seSBoYXZlDQo+ID4g
PiA+IG9uZSBzMiBIV1BUPw0KPiA+ID4NCj4gPiA+IEdpdmluZyBzb21lIGV4YW1wbGVzIGhlcmU6
DQo+ID4gPiAgLSBJZiBhIFZNIGhhcyAxIHZJT01NVSwgdGhlcmUgd2lsbCBiZSAxIHZJT01NVSBv
YmplY3QgaW4gdGhlDQo+ID4gPiAgICBrZXJuZWwgaG9sZGluZyBvbmUgUzIgSFdQVC4NCj4gPiA+
ICAtIElmIGEgVk0gaGFzIDIgdklPTU1VcywgdGhlcmUgd2lsbCBiZSAyIHZJT01NVSBvYmplY3Rz
IGluIHRoZQ0KPiA+ID4gICAga2VybmVsIHRoYXQgY2FuIGhvbGQgdHdvIGRpZmZlcmVudCBTMiBI
V1BUcywgb3Igc2hhcmUgb25lIFMyDQo+ID4gPiAgICBIV1BUIChzYXZpbmcgbWVtb3J5KS4NCj4g
PiA+DQo+ID4NCj4gPiB0aGlzIGlzIG5vdCBjb25zaXN0ZW50IHdpdGggcHJldmlvdXMgZGlzY3Vz
c2lvbi4NCj4gPg0KPiA+IGV2ZW4gZm9yIDEgdklPTU1VIHBlciBWTSB0aGVyZSBjb3VsZCBiZSBt
dWx0aXBsZSB2SU9NTVUgb2JqZWN0cw0KPiA+IGNyZWF0ZWQgaW4gdGhlIGtlcm5lbCBpbiBjYXNl
IHRoZSBkZXZpY2VzIGNvbm5lY3RlZCB0byB0aGUgVk0tdmlzaWJsZQ0KPiA+IHZJT01NVSBsb2Nh
dGUgYmVoaW5kIGRpZmZlcmVudCBwaHlzaWNhbCBTTU1Vcy4NCj4gPg0KPiA+IHdlIGRvbid0IGV4
cGVjdCBvbmUgdklPTU1VIG9iamVjdCB0byBzcGFuIG11bHRpcGxlIHBoeXNpY2FsIG9uZXMuDQo+
IA0KPiBJIHRoaW5rIGl0J3MgY29uc2lzdGVudCwgeWV0IHdlIGhhZCBkaWZmZXJlbnQgcGVyc3Bl
Y3RpdmVzIGZvciBhDQo+IHZpcnR1YWwgSU9NTVUgaW5zdGFuY2UgaW4gdGhlIFZNOiBKYXNvbidz
IHN1Z2dlc3RlZCBkZXNpZ24gZm9yIGENCj4gVk0gaXMgdG8gaGF2ZSAxLXRvLTEgbWFwcGluZyBi
ZXR3ZWVuIHZpcnR1YWwgSU9NTVUgaW5zdGFuY2VzIGFuZA0KPiBwaHlzaWNhbCBJT01NVSBpbnN0
YW5jZXMuIFNvLCBvbmUgdklPTU1VIGlzIGJhY2tlZCBieSBvbmUgcElPTU1VDQo+IG9ubHksIGku
ZS4gb25lIHZJT01NVSBvYmplY3QgaW4gdGhlIGtlcm5lbC4NCj4gDQo+IFlvdXIgY2FzZSBzZWVt
cyB0byBiZSB0aGUgbW9kZWwgd2hlcmUgYSBWTSBoYXMgb25lIGdpYW50IHZpcnR1YWwNCj4gSU9N
TVUgaW5zdGFuY2UgYmFja2VkIGJ5IG11bHRpcGxlIHBoeXNpY2FsIElPTU1VcywgaW4gd2hpY2gg
Y2FzZQ0KPiBhbGwgdGhlIHBhc3N0aHJvdWdoIGRldmljZXMsIHJlZ2FyZGxlc3MgdGhlaXIgYXNz
b2NpYXRlZCBwSU9NTVVzLA0KPiBhcmUgY29ubmVjdGVkIHRvIHRoaXMgc2hhcmVkIHZpcnR1YWwg
SU9NTVUuIEFuZCB5ZXMsIHRoaXMgc2hhcmVkDQo+IHZpcnR1YWwgSU9NTVUgY2FuIGhhdmUgbXVs
dGlwbGUgdklPTU1VIG9iamVjdHMuDQoNCnllcy4NCg0Kc29ycnkgdGhhdCBJIHNob3VsZCBub3Qg
dXNlICJpbmNvbnNpc3RlbnQiIGluIHRoZSBsYXN0IHJlcGx5LiBJdCdzIG1vcmUNCmFib3V0IGNv
bXBsZXRlbmVzcyBmb3Igd2hhdCB0aGUgZGVzaWduIGFsbG93cy4g8J+Yig0KDQo+IA0KPiBSZWdh
cmRpbmcgdGhlc2UgdHdvIG1vZGVscywgSSBoYWQgbGlzdGVkIHRoZWlyIHByb3MvY29ucyBhdCAo
Mik6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtDQo+IGRldmVsL2NvdmVyLjE3MTkz
NjExNzQuZ2l0Lm5pY29saW5jQG52aWRpYS5jb20vDQo+IA0KPiAoTm90IDEwMCUgc3VyZSkgVlQt
ZCBtaWdodCBub3QgaGF2ZSBzb21ldGhpbmcgbGlrZSB2Q01EUSwgc28gaXQNCj4gY2FuIHN0YXkg
aW4gdGhlIHNoYXJlZCBtb2RlbCB0byBzaW1wbGlmeSBjZXJ0YWluIHRoaW5ncywgdGhvdWdoDQo+
IEkgZmVlbCBpdCBtYXkgZmFjZSBzb21lIHNpbWlsYXIgc2l0dWF0aW9uIGxpa2UgbWFwcGluZyBt
dWx0aXBsZQ0KPiBwaHlzaWNhbCBNTUlPIHJlZ2lvbnMgdG8gYSBzaW5nbGUgdmlydHVhbCByZWdp
b24gKHVuZG9hYmxlISkgaWYNCj4gc29tZSBkYXkgaW50ZWwgaGFzIHNvbWUgc2ltaWxhciBIVy1h
Y2NlbGVyYXRlZCBmZWF0dXJlPw0KPiANCg0KeWVzIGlmIFZULWQgaGFzIGh3IGFjY2VsZXJhdGlv
biB0aGVuIGl0J2QgYmUgc2ltaWxhciB0byBTTU1VLg0K


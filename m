Return-Path: <linux-kselftest+bounces-14823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FF49486BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 02:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B701F23D92
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560698BEE;
	Tue,  6 Aug 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwwtJSAT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2926FBF;
	Tue,  6 Aug 2024 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722905418; cv=fail; b=NzjwHgTveh2r72RX5WWL1uhBy7eAiy+sHUefBx+Q//lyX3ga87VbF+9qtClaChesZy4iQhNxF1XVd4loEm/etCiUsu3dbIMwTrR/VFlAJvFYQPq/MeTwGwxIQKieE8zPBvVdSh2k9NpqeMN5MsKG1ir/MWcTIB/cRL661tB8SBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722905418; c=relaxed/simple;
	bh=naCCUc7S3pKYEyLOtiL7qCAeGx+AftJUX+rcmsM0UhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4M+916030LKr2hi+mNWfAerPmdDx4y4GMhfmi6TJmyfxR1YqSdyjtQOwT6BCJ15gyJy3qlvsp9CjfZD4prLN4fzaBoE8Ao5nQaBQwRCXvPD2LGcvxq6LCWOKZ9pVMU6M8Rxls6z63Kzca/1UT33D4cIVXAYFGoMELlaMSnFWLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwwtJSAT; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722905417; x=1754441417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=naCCUc7S3pKYEyLOtiL7qCAeGx+AftJUX+rcmsM0UhY=;
  b=AwwtJSATuPhbQyqiPycmyJPGHBfIMXjHCVquRu5pw+M/UhIWCM/a0Kel
   qwAK5pzFHjaF9NT7g43MmS4GHiecfZHI8rwex/ng8DSZoRVsEPw/313Og
   LVMBImi6qmMcNmJ/AEeoQbQvqCbJwr6rc6EcvdFuOxlzW98WrIrCPXNhr
   DUOXbxXRIrLqI0rNXsF+UHRXQ3a7Keii0AOtmZ+8xD7VzuahW5qNh2Kek
   KJdEk5+KNFafPjZnqDePtmXPfMcZgohCGI+YZTWO6ydU41RT0jT30hbXc
   fvJ6jx7DbUivV/YPQTa921nc2+ego9Ot0LL0L5E8zTVOwtLqVu9W5j3+O
   g==;
X-CSE-ConnectionGUID: yO9B2sgFTza8e9+0kU4MeQ==
X-CSE-MsgGUID: 9Zgq9hm2TNWGTLe0Dq+V7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21041940"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="21041940"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 17:50:16 -0700
X-CSE-ConnectionGUID: iyvkKE1xQLe+T+xSwTyvEg==
X-CSE-MsgGUID: 5zx+Kq1XSymW16ppDY11Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56545751"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 17:50:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 17:50:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 17:50:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 17:50:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 17:50:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMYrkhUgu/0yP2iukVPsEOUZUoZLxGWpuvZp37TGH7URgMLhkRugNIC+hXgFYMG8emfRn0CJcc9udD+5dybYruCYmB7+tqEAoF6u+iIzGn3imxooOwQPYaU5jHru++9J2ChTtkguN76g0eSRsapuFF1AH7EF/rFhZKMl487I1LolYdlEkJU+SOVJgYlyrsYWTBmc2hhQuls4KBVIdFRUnPomE0oWFbrvfvDfitJv0/+sJxlNwi4pmUq7K4qh8+MmVEgb2dKcpITpWUSeFQI7PeHuBmpBVJpZNMTbKaynjQh2CFMJVDEv/kBVnk4AlNOiY+ezEwy8c5n2toHx1Bp99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naCCUc7S3pKYEyLOtiL7qCAeGx+AftJUX+rcmsM0UhY=;
 b=MT+qg+Ad2bk8NS6wd2YOQFd2Cwv9J/dJ3OmI5BUabphBxwW+cwoTr1KObqQBHp9s3VKgqqrSfqwItyNu/JeKUZI2CXgu0HvwcCkt1ADX0PUoVMF3ZbFrAelMea3UWaVYR4oxFT4fQ61HXbDsrabzgKYIvm5xa57r9EZryosPRc675b/QGul7Zcyxj8qJKWkHkNENTtVJCjA1gRC2RngMTIpP6Irm/dwPsHc0Rxn4tfEg+ZvkbZLskSyAK7hShJzKBj9NALuIFnDLFBaBEj8gsEzgoKaesHlwI2nlMMzv/JsxqWuARrFqiL9c863ivT/RfZtEfIOpeyrG37NN/RNNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 00:50:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 00:50:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: David Hildenbrand <david@redhat.com>, Mostafa Saleh <smostafa@google.com>,
	John Hubbard <jhubbard@nvidia.com>, Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, "maz@kernel.org" <maz@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Fuad Tabba <tabba@google.com>,
	"Xu, Yilun" <yilun.xu@intel.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
Subject: RE: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Thread-Topic: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Thread-Index: AQHawdyTbbj3CTyCxU2oU4wQ5oQq6rHOYY8AgABR7QCAAe6NAIAAEoqAgAAFggCAQyU6EIAAOWCAgAQfayCAAWDuAIAAEVrA
Date: Tue, 6 Aug 2024 00:50:07 +0000
Message-ID: <BN9PR11MB52768B4BFE518BC369DA3D848CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <ZnQpslcah7dcSS8z@google.com>
 <1ab73f42-9397-4fc7-8e62-2627b945f729@redhat.com>
 <20240620143406.GJ2494510@nvidia.com>
 <BN9PR11MB5276D7FAC258CFC02F75D0648CB32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240802112205.GA478300@nvidia.com>
 <BN9PR11MB52763711D023C0A50171C2EB8CBE2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240805232246.GH478300@nvidia.com>
In-Reply-To: <20240805232246.GH478300@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7313:EE_
x-ms-office365-filtering-correlation-id: 02623a8c-1dcc-4416-9899-08dcb5b1b7e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?clhhdFpFQXFQcldWc3EwRWo3cFZvUWpPWmRxWC9XY0dqdlVPMS9pNXNLTUcr?=
 =?utf-8?B?aEhIcWNrblpyS0VzckwzMkZHbHVOUW1QeFF3OTVSYXJXc0d4bU5oamljL2NM?=
 =?utf-8?B?bVo4Wm1LL0g5TzAvc081aWw2ekpmZmhCNVRWWmhKOEc4MVRTaGFUakFrUnpF?=
 =?utf-8?B?OUlSZStlc3pnRjdGc0U2YXlnc3g0M3NSbnB0QlA4OWxIRzIzNVpBY1M2RlJt?=
 =?utf-8?B?UUlNZkcxYUl5MXN3NFhrMS9HM0EzSzZ5UExHa3hockhkcVFUZHpVVkJOdlRp?=
 =?utf-8?B?S2tqQVZWY2xqeW12L0ZGYW1WRU5qeVpOL084TEhFNUVON3BGazcxTjh5YnlF?=
 =?utf-8?B?TTFuTG5uc2xZVVptaXZpRzU3YTdWdWtVeHg2UkdJMkFwY3B2MWNVTUgya3hK?=
 =?utf-8?B?TWpBdjJUN2RoYzhHa3dvWXZ0M3phUkhwemduRlFqTENONEFOT2JTenpHOGRl?=
 =?utf-8?B?cS9PVERPaVJZaktKTFBobWJuUEVHTWgvUlpqbS92NE9RellrcFNLLytGK0lq?=
 =?utf-8?B?V1QzbjdtQ1loNFUwaTFkWjhSakU5YUVrSisvcFArR1BncGJ0R0VQeVR3STR6?=
 =?utf-8?B?UzlvZTJXZkZoTERLeEdVZ21xanZwNndGbHVXcGo5Wm5McXR0K25mWmJsbHRo?=
 =?utf-8?B?K3VYT3FDMTBIcHFhV0wyUzVjYW8yTGkwVEx0bnNqSWs4MzBPdVRtZ2cvbjhv?=
 =?utf-8?B?WHlIMFhrdVBZSWNOMEdOOUM4SXlNZTJpc2FxeHd3RjBIVUZIQUpUb21Zenc3?=
 =?utf-8?B?L0dyQkpNdjdFbDR6SVowbHpCZDlWbVh0djNaakw4ODQyV2xEcEdaN1dnRG1p?=
 =?utf-8?B?S0J6aG1nRFg2NUp4WTByZTZFaWMyTUZmUTlpUHU5UTlSbWpjL3p5QWRVazFq?=
 =?utf-8?B?SlVJS1hNbUNsSERtTG1mYkU0eS9jUmQwWTNGZmFlT3dNTGI3VGhlL2NaWFNy?=
 =?utf-8?B?VU9Ic0ZZcVNKRHBTVHpURndaay9MTFJFNGxEQkc4cUpVb3ZaNi8ycy96Lzk1?=
 =?utf-8?B?UUd6UmxGSytyOU1tOGcvcXd0eVF1eXJnRk5ma1d6NWllclllNUlncTZkV0sx?=
 =?utf-8?B?RGl1UURJWnNMOUJUTU9TQm9tLzJNWmpiOHQvN3pNMDNCbDhFZGRaUjhJVktF?=
 =?utf-8?B?TzNZdjZTcElCdVphY3NqZFFrR20xamNyZHYzeHdsd3djSFladFJ2K0l6enlw?=
 =?utf-8?B?d2pXcHFRaXJVM0tMMk85L2lOOHovUWdocVVkTzhYbEVLVGMwbDhtWC9iVU5V?=
 =?utf-8?B?Ny8zRzNOcVZBOEF1bUozbENUU1pIU01YZm1mVjZERDg0VEtRQ25HT2ZOUG9C?=
 =?utf-8?B?OUlpZlMxRWcrVW9xQW43c3N3Yi9LeVE3QmFMdUNqNXpIdWJzODZQV3l2ckph?=
 =?utf-8?B?UGIyMXNaRml5QXY2OWdXZ0Z1MUMrM29QY1N0Vjdza1BnTXNodmY5WFYrQ0VY?=
 =?utf-8?B?UWl0QzRVa3Jzb1pkRFVSTlJnY3NCZ2dMaHkxTW0wcG5VZ1drbjlDOGFUYzVD?=
 =?utf-8?B?KzBMcXkydU9YQ3FGN1FxSjczYklBUjI1VlRhN1NrK2tMRHlLdmYzV2hVQS8w?=
 =?utf-8?B?b2xIRm5hNzNaQlFMYlgvamVYQXo2dHFXU1QzU282UkJrR1R0OXI3M3VPSy9Z?=
 =?utf-8?B?WVJkWlc3dTBqMUk5SldTWEdsR1ZUN3ZzL0VNM2pINGVsQUZySWtIMTF2YVk3?=
 =?utf-8?B?L3FIUDNYRUJZaG53UEE3c3FRUWhYVmpUSmFrTERTaUVpQzZidHpVVzQ0RG5B?=
 =?utf-8?B?V2NsWE9qRHA1cUpUTkxFZW51bmpQKzI5Z3AzWUpSMlR2SkJjYlRQbWJVWm1u?=
 =?utf-8?B?M2JaQ3ExR3VhQkx5dURlck0xL0drdit5RkIzd1NlQ0tqOGFsY1JEcjh6QVRt?=
 =?utf-8?B?c0NNdkdIMUp3SUs3cUd0V0pXNWk0cVY4VklJb2UyRk5pSGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUNNVXNDSGlUbkE0MSt3L1VYYWRWQnFpaUs4SVdiS05RWUpjMEY0cHhoTkk0?=
 =?utf-8?B?TjZyU2hLcG9nTVpJT05YYmxhWEZFUXhTdGt3RjlqdDNNc3VldGVHVm1RcGVw?=
 =?utf-8?B?UGVPZ2pDYldzQjlhWTVnNXBKUWk5UGI0dGVySi9JcDNJUi9aZEc0Ukhqd29P?=
 =?utf-8?B?MVpHUU9mT2tEMlB4akFmdEdockIyZmhic3IrZnU3dk5qd0dOVXNMdHVKODlR?=
 =?utf-8?B?SHlHT3Zsa0kzUFgzYjg4TTBiUytQRDd3RmswQXA3QkJIUTIwTEJ1RVFSaXVI?=
 =?utf-8?B?VkVkalJNTEJpR2tnZjdBTnBLUklxWDZHQlJmTzc4clJvTDEvZkVLblhzUW9l?=
 =?utf-8?B?UytaY24vcG9XK3dSNGFkWEV3bHBLNnZEbDFJeW9hQWhoaE5KTEo3S3FhOEly?=
 =?utf-8?B?SzQzRW82U05ScmwzVUZwMkZIcXIwVUE4OGh2WlJqUEQ0L2UxbWFweE5HOVhF?=
 =?utf-8?B?TXNIUm1yb3RocGZaRDVBT3ZRbndMbUduamVWRXl3cGxjL2c1WkR5anNQWmpK?=
 =?utf-8?B?WTkveVhRbnBmeEZIV1N6THRTUzZiSFBrbU5SbWJxejV0eWhnb0lhWkprWC9B?=
 =?utf-8?B?UExNdHpSN01nNDJyUWNKQ1BOVGtFMGY0OWlzZWlyOFVYb2tmVnBLL3NOa2I4?=
 =?utf-8?B?c21LUDNtY21aYjJQUWZTaVQzOFhiWGFEZ1REdFNoUmlGY0FuZWU4MHd0UDhG?=
 =?utf-8?B?aVZRcFFnUW8yRUlsZjZXdWljaWV6a0FFSU9BNkphQ3kxV0RPcG1YbjVCeFVT?=
 =?utf-8?B?U2tjTFpZWGFvSjNLVUh1Sk41TXBmTlpXZTBCTWMvVytxWWtQUFJacnI2UkNW?=
 =?utf-8?B?dXN6RDFEU3ZLQkJ1cnd5RU1sb1FOOUltWUJYUjV1cDFmZkR1RFNwc0ZSQ0JM?=
 =?utf-8?B?VXhocnBIbWJ0TkxNTGF6bE01dmVpeHlYWitsREFqSVFCL2RWWDFIK0kwRXpp?=
 =?utf-8?B?S00xTEhrTTZiMnBQVEF5Znp6eXVFS0UxNWdyWEp6bVgzcDFQbHI4R1g0di9R?=
 =?utf-8?B?OGR3MEwyNlZVYUkyUzVZQVFBN1V2RDMvOWx1S0JObmExanNISEVENHVyYkdr?=
 =?utf-8?B?K0ZIUmRyNnlKV294TW1CUkFIaDVZMWZxc3lWWXV3MGpsSmVYT2JPaVBYV09B?=
 =?utf-8?B?OWtjL1p2M0xkQVJGWUJFQVJib0IrZk1zbEpoMkViYnJxalRISEQzbG9lUGxL?=
 =?utf-8?B?WGh5cVhueUtxY3gvMG1UV0doaU9GNXNDUXAzcEpWVVdPeFhBMjE0NXF5ZlVF?=
 =?utf-8?B?c2Z0VmxSVmVubmpiazZHcXVZWkk2RUxKQllTak9oRDhZMGV2aUNGSS8wWWJk?=
 =?utf-8?B?MXFRNDRiYnZURXhRWkpvWVJQZlFJdWVwWkVKOHF2U0ljOGJXZnN4dnJWTGZi?=
 =?utf-8?B?L09zdTE3UjM3ZnkyK2NPTUpPaU94V29SWE1YUlM3QXlVRW8zM3YxL0NvY2lV?=
 =?utf-8?B?UXM1UThURkc2VldSM3plUGwxb2ZIbnJWUXVqSCtycTRmSU1vcG5odTdjUGQ2?=
 =?utf-8?B?SjViamljbVI4aFNORDd3MDZJQzBSblpkZ3RCYmF6YXRNd2ZLNlpLUjdHSmlm?=
 =?utf-8?B?WG9URktpMll2VWVQM3ZJYlRMV1h1QnNHS3FqN2tMVlZTemhXcnpiY0t1TUxC?=
 =?utf-8?B?QjgwZWF3WktSczJKRk5KRUM1Ri9tNEtOQTlUU3BTdDl6WDluWUlTSlBlMWVL?=
 =?utf-8?B?bndvUnp3enZYSks5R1B0eThnRVhVbElTTm4ya1VSOVAvVWU4T3JxdUtiVkVE?=
 =?utf-8?B?UTVjZ1BzT0I5eDNZd0ZZZ1RndU02TmZaZ2xhdmFhNnVNR1pQOFo2NGl2SFZI?=
 =?utf-8?B?MFNqN3EvdEVKbXkwYkh5NitROTNMMmNGZk9nV2VPRXdhWUFtNjN5YTI0WWtw?=
 =?utf-8?B?U1BEaUwrMnl5eUszbjhBYkkxREI2VmZkbDFzV3NBZHBmRTBrbUU3MnU2WHhx?=
 =?utf-8?B?K0ttT0YvK3RvZ1dicjk2Vkp4OG4xN2UrZGtaeTJMOUdIYlJqanNPazQxUTdl?=
 =?utf-8?B?WHBPT2gzK0FDUFJkSTg2MUZoYzRia2xIVzAyNitpVjRtQjZuTWFJRGtxMTNI?=
 =?utf-8?B?MUR5RFR6cTlxYXNZNVU4cE5HZ25LbDdCM1I0Ym1JMFY3OW8rM0J3SnlwOUsx?=
 =?utf-8?Q?eyIJCmTW8pqJXZCJGaW9dj4Uv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 02623a8c-1dcc-4416-9899-08dcb5b1b7e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 00:50:07.8638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTe2Th7SczStaJEROiOgEP+aQYwbWZYZbgG/Ot55jfE6SJYPxlPK86xIpoclX1iL9/6DP6EQ1H7FNHC5jNlWdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBBdWd1c3QgNiwgMjAyNCA3OjIzIEFNDQo+IA0KPiBPbiBNb24sIEF1ZyAwNSwgMjAyNCBhdCAw
MjoyNDo0MkFNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPg0KPiA+IEFjY29yZGluZyB0
byBbM10sDQo+ID4NCj4gPiAiDQo+ID4gICBXaXRoIFNOUCwgd2hlbiBwYWdlcyBhcmUgbWFya2Vk
IGFzIGd1ZXN0LW93bmVkIGluIHRoZSBSTVAgdGFibGUsDQo+ID4gICB0aGV5IGFyZSBhc3NpZ25l
ZCB0byBhIHNwZWNpZmljIGd1ZXN0L0FTSUQsIGFzIHdlbGwgYXMgYSBzcGVjaWZpYyBHRk4NCj4g
PiAgIHdpdGggaW4gdGhlIGd1ZXN0LiBBbnkgYXR0ZW1wdHMgdG8gbWFwIGl0IGluIHRoZSBSTVAg
dGFibGUgdG8gYSBkaWZmZXJlbnQNCj4gPiAgIGd1ZXN0L0FTSUQsIG9yIGEgZGlmZmVyZW50IEdG
TiB3aXRoaW4gYSBndWVzdC9BU0lELCB3aWxsIHJlc3VsdCBpbiBhbiBSTVANCj4gPiAgIG5lc3Rl
ZCBwYWdlIGZhdWx0Lg0KPiA+ICINCj4gPg0KPiA+IFdpdGggdGhhdCBtZWFzdXJlIGluIHBsYWNl
IG15IGltcHJlc3Npb24gaXMgdGhhdCBldmVuIHRoZSBDUFUncyBHUEENCj4gPiB0cmFuc2xhdGlv
biBjYW4gYmUgY29udHJvbGxlZCBieSB0aGUgdW5zZWN1cmUgd29ybGQgaW4gU0VWLVNOUC4NCj4g
DQo+IFN1cmUsIGJ1dCB0aGUgR1BBIGlzIHRoZSBLVk0gUzIsIG5vdCB0aGUgSU9NTVUuIElmIHRo
ZXJlIGlzIHNvbWUNCj4gY29tcGxpY2F0ZWQgd2F5IHRvIGxvY2sgZG93biB0aGUgS1ZNIFMyIHRo
ZW4gaXQgZG9lc24ndCBuZWNlc3NhcmlseQ0KPiBhcHBseSB0byBldmVyeSBJT1ZBIHRvIEdQQSB0
cmFuc2xhdGlvbiBhcyB3ZWxsLg0KPiANCj4gVGhlIGd1ZXN0L2h5cGVydmlzb3IgY291bGQgaGF2
ZSBhIGh1Z2UgbnVtYmVyIG9mIGlvbW11IGRvbWFpbnMsIHdoZXJlDQo+IHdvdWxkIHlvdSBldmVu
IHN0b3JlIHN1Y2ggZ3JhbnVsYXIgZGF0YT8NCj4gDQo+IEFib3V0IHRoZSBvbmx5IHRoaW5nIHRo
YXQgY291bGQgcG9zc2libHkgZG8gaXMgc2V0dXAgYSBTMiBJT01NVQ0KPiBpZGVudGl0eSB0cmFu
c2xhdGlvbiByZWxpYWJseSBhbmQgaGF2ZSBubyBzdXBwb3J0IGZvciB2SU9NTVUgLSB3aGljaA0K
PiBkb2Vzbid0IHNvdW5kIGxpa2UgYSBzYW5lIGFyY2hpdGVjdHVyZSB0byBtZS4NCj4gDQoNCkFj
Y29yZGluZyB0byB0aGUgU0VWLVRJTyBzcGVjIHRoZXJlIHdpbGwgYmUgYSBuZXcgc3RydWN0dXJl
IGNhbGxlZA0KU2VjdXJlIERldmljZSBUYWJsZSB0byB0cmFjayBzZWN1cml0eSBhdHRyaWJ1dGVz
IG9mIGEgVERJIGFuZCBhbHNvDQpsb2NhdGlvbiBvZiBndWVzdCBwYWdlIHRhYmxlcy4gSXQgYWxz
byBwdXRzIGhhcmR3YXJlIGFzc2lzdGVkDQp2SU9NTVUgaW4gdGhlIFRDQiB0aGVuIHdpdGggbmVz
dGVkIHRyYW5zbGF0aW9uIHRoZSBJT01NVSBTMg0Kd2lsbCBhbHdheXMgYmUgR1BBLg0KDQo+IEl0
IGlzIG5vdCBpbnN1cm1vdW50YWJsZSwgYnV0IGl0IGlzIGdvaW5nIHRvIGJlIGFubm95aW5nIGlm
IHNvbWVvbmUNCj4gbmVlZHMgYWNjZXNzIHRvIHRoZSBwcml2YXRlIHBhZ2VzIHBoeXNpY2FsIGFk
ZHJlc3MgaW4gdGhlIGlvbW11ZmQNCj4gc2lkZS4NCj4gDQoNCkRvbid0IGtub3cgbXVjaCBhYm91
dCBTRVYgYnV0IGJhc2VkIG9uIG15IHJlYWRpbmcgaXQgYXBwZWFycw0KdGhhdCBpdCBpcyBkZXNp
Z25lZCB3aXRoIHRoZSBhc3N1bXB0aW9uIHRoYXQgR1BBIHBhZ2UgdGFibGVzIChib3RoDQpDUFUv
SU9NTVUgUzIsIGluIG5lc3RlZCB0cmFuc2xhdGlvbikgYXJlIG1hbmFnZWQgYnkgdW50cnVzdGVk
DQpob3N0LCBmb3IgYm90aCBzaGFyZWQgYW5kIHByaXZhdGUgcGFnZXMuDQoNClByb2JhYmx5IEFN
RCBmb2xrcyBjYW4gY2hpbWUgaW4gdG8gaGVscCBjb25maXJtLiDwn5iKDQo=


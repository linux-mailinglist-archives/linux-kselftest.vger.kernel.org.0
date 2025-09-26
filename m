Return-Path: <linux-kselftest+bounces-42501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6470FBA4F34
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 21:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACF41C2025E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BC0202976;
	Fri, 26 Sep 2025 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/0kuFcE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E982AE8D;
	Fri, 26 Sep 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758914243; cv=fail; b=IhCG8CU8qY+U8vWF7pTKScKoOmU71G5ezMtcYADmxvUK0orEW5Vr72fEDqwSrnxTI6L3JxZMbVU7NVpUNfybzMUYeodxGUTe/vrxeXVxlZb60+/7YnPDAyYhtNgm2tGviMfsT9Fp9uGUvbcRFk44AsjajYHov8lfXCD3EFyOmGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758914243; c=relaxed/simple;
	bh=LqMOJfFD6nzBVle49v3Qfgx7nIxtEdcYnQhZZiLTOsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HUjwnAtXWHpZaIttCCHEBC5PeBVFmAx0mdBslrewy180M3dC9xMAIF5Z/webiRWthNaYxsXemGmFwrRPtQpTaXgw2JHUTpRKn/UZ6tKJcJNiCVNdk67oeH1Pvi2sBl6HGz6LB8Qho+CI+objxDzLqPI/NVLRMMJCFnAbTDfn5mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/0kuFcE; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758914241; x=1790450241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LqMOJfFD6nzBVle49v3Qfgx7nIxtEdcYnQhZZiLTOsQ=;
  b=F/0kuFcES7zEL8mZt/kYBPnC9AEzwuzLPJBSn2/8j19zu2WVYvBW4aAx
   z9W2SLcGqNd4DpCRE8nT2KfRe1fZjVFfmK2b2DZYBtDAqt0Ih9thqljOy
   l8HrbPWiRYSej1qtzh9i6j5gRH6XHei0qtXs35GF+W4MPFltg4dsYFK/4
   W7D4BnoDK/Dd4GJkQKp8KFXiH57C0N5Iu5bLpvLprBw4QKa6uCxUCQegg
   obAhtAoPCds4OgEL95RfJefcqpSCxkMfrTFJV+G8B8fA346otuWCHq6Cg
   RdSqIOiLd0Kyfpy0rz9n86gamLG/vE9P9Bt5/bNY4X7/dHhame61jEHZA
   w==;
X-CSE-ConnectionGUID: /NY6MkA3Tvq3G0pG/KLQAw==
X-CSE-MsgGUID: d+c3OmZPSgS/o78f3Vn83w==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="48814050"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="48814050"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 12:17:20 -0700
X-CSE-ConnectionGUID: fDa5A9qsSZiw45vyEWybIw==
X-CSE-MsgGUID: qBWItoOeQxWJGCNAA70LRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="177744957"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 12:17:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 12:17:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 12:17:19 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 12:17:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkndO7D1LBfWOCImSNh1WRXipxcT2x41XZ9bMB7nWNmDkxK52pTwInURFz+veYuk/OUqj1J4HiaBNa/P21wNI7QcKppy2ZN7k/pgbQlIeNZ1fMoT8SMKFoX0/zX//Vz+6duvdhJ9YxCGYjpTL6cxba0Mqoou2y1B9jz+xdFwQ1+IssGtsfRsr2xOLUj+s6vJn6koNZSZnq+JgDcLPpeb1oTPOebY0hMITBjSSqdqhehh2vKWGKNvsPqhTUkcrZC7f4WCmqRV6vzumNM6ZLLujSkD5QZZnB3umJ/gsGyC7la2q12uvox5lJiWjwf5IPNsTTyaezGxk+ljs1L1+aQEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqMOJfFD6nzBVle49v3Qfgx7nIxtEdcYnQhZZiLTOsQ=;
 b=EZjVFjfw+CIKfR8QDd8Zu0zAJFQfvo2St/rpOd64Xb61bILLOuypckNwr9CYdXeRK18Y0z6geMflc28IJIcSX8uoAbilYJ+2A7gnktlTrf9D3vIwL3JE1pgKYBsFoPqhPCA6+5Ae1FZFuPB36u7HbUVe0CzzkLe5TJ7yJHwYRD54vIoQlYmwFGzJtsAGSOF99MzA17CxSdLYdnYqgQT98mNUQ+/VyyIdZxXn8JHLhCsq+vRr2WgSOsjt+Lf6xZhHDAehK1gfVq2VINh1IbrBK9qHHeG/syIyWpqhjXF3PSTqmB/OWWr0T/9ScyJ4ea+zb1ORlIL4IIPgw8jReHuNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 19:17:16 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 19:17:16 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
	"nsz@port70.net" <nsz@port70.net>, "brauner@kernel.org" <brauner@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dalias@libc.org"
	<dalias@libc.org>, "jeffxu@google.com" <jeffxu@google.com>, "will@kernel.org"
	<will@kernel.org>, "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "codonell@redhat.com"
	<codonell@redhat.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "libc-alpha@sourceware.org"
	<libc-alpha@sourceware.org>
Subject: Re: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Thread-Topic: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Thread-Index: AQHcKvs2dWZnb030BEKK+EDimBzvQrSkY2wAgAE1TQCAAAjPAIAABsSAgAA1/wA=
Date: Fri, 26 Sep 2025 19:17:16 +0000
Message-ID: <80f8389c5c136ce21d922be10e4978d1ae5f1139.camel@intel.com>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
	 <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
	 <aNasTpkYm8n1AHZ7@arm.com>
	 <04dc6271e11b453204255779fcd3c29573c9c296.camel@intel.com>
	 <5c616340-2767-48f0-8727-326deebf718f@sirena.org.uk>
In-Reply-To: <5c616340-2767-48f0-8727-326deebf718f@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB5984:EE_
x-ms-office365-filtering-correlation-id: fe2311d3-ae64-48b0-5784-08ddfd314e18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?akxXSEV3a051QnNJY1hCblhlUGdFMEtuYi9hbEZsMjc2WXhsSzliL2NvTkdJ?=
 =?utf-8?B?MTZJNVZrWG95TGlyN0paQ3R2d1ZrL1BQOEEwTUwxeDRiMHRJSnRzNWhvN2hF?=
 =?utf-8?B?UE42RThMR2NVbk9FYjJaQzdGRnhxbjI3c0ZvalJiZjBIRENlWGxXTnljY2I2?=
 =?utf-8?B?MlRIRGhQQlpWQzhhOGtadlBMUGE1eHdEVGpSMVlJa2hjT0xWYWZJOFgrYmI2?=
 =?utf-8?B?Rkt1Nmc3Y2pKR1phMnJMUnBSdW93cW1PQ3RuMHB2d2xYK1JPWVVNK1d2emdF?=
 =?utf-8?B?WVloK0xROExwL3hWclhpV1RCb2duK3lEZkZockpORk1QY2Y3eXF5Z3JxZDlR?=
 =?utf-8?B?MWdYWmdlNE04VDhBdzlkdGsxSlJoMllqNWNocDVuUDMrNmwrZG96dUdOV3Rn?=
 =?utf-8?B?QU53UVNiL0Q4ZGJSQVNlTjMzV3crR1RFK1JraktubVhwWGVoblRETms5elRQ?=
 =?utf-8?B?VDAybjdqb3NSckhybVpKOXJCTHU2TTRMNFh3NjFqRElWWDhxTHg4MlA0V25D?=
 =?utf-8?B?ZXlnRlh6cWdaZ0EyYmd3RjN2Z2dWZzhOUnVKZGlENnFTdHN1cVAwSktGOGg4?=
 =?utf-8?B?N2pLQ05lZlF0N1g2RkhXRHo5QnpwMkk0TU0wOXdFRDhNTzQ1SXduazVCY0VZ?=
 =?utf-8?B?WmREUkRWZTV3TUs3UHVkN2tvRzdFdjIzUDEzVWtZSGdmZmpSdlllVllrRnBq?=
 =?utf-8?B?bTQycVVqS29YcXFyZm1JSEVCS0RON0hGeFRkNGxUVnhwU2hOd3ZTaHpvTHFZ?=
 =?utf-8?B?WXVYK25hSjQvMWR2THRiMEtzU2JrZXhweWRPcEFnM2lwdytQM1ZWODNBUXFt?=
 =?utf-8?B?aEIvaTZ1TmdKTDFBQW5VL2RmTDAxVEtxZXhSMXo4ZStXSkcvU0NNeGV6TTNS?=
 =?utf-8?B?d2NvTG1rU0FUdWoxZzB4MVFna0c4clJBN3paaG0wNmI1bXVGaXJTWlRETlMz?=
 =?utf-8?B?ZnVQS1Q5VUVwbHp0R3NUMnQyL3NBYXl1cWNnUUVveEFwY2lIWCt2ZFY0NkMz?=
 =?utf-8?B?Y3RzNVphQ1dUbnZmdXY0YzJOdGVsLzlwUk9UMjdxOWZhdllScEJEYkhGckpC?=
 =?utf-8?B?MWdqY0hReXJHWExRYzRHTGlUeFdzWEMrakxIOWJMUGNLUXpvUXFFaFBaODlo?=
 =?utf-8?B?RmM5WkZ5YlZTalVJSkNzaDVYOG92eldpQzVLTld0bTJTTElLY3hqM1VCbk56?=
 =?utf-8?B?cVphZ09OSm53UTdwMVJmN3dlbGtjQW1HMmhoQVFWZmFaRWFua2ZLUTF2UVB1?=
 =?utf-8?B?RytHK29SM2lQVnF2dnkxZnBETTBkaEpzd3c3ZE43Ni9xUThmZTNLbE1keTlv?=
 =?utf-8?B?UE4raUlSWk0zN2R3ZzdGTy9hSkRFSnpHV0k2Yk85aUIyK2VnZHYyRnd6ZldB?=
 =?utf-8?B?WkM3bDlRNCtjL1BVbGI4NUR3NUc3anJzY2hJbEVVNW1RdUh5azhleUVPNE5E?=
 =?utf-8?B?WGwwSGpGMi9YZGI4dHlIUTZ1d20rTmgrU1E0bC8rdUU5UVhXMEVYeDlRbk44?=
 =?utf-8?B?VVRPdTgvMi8yaW85ekpkZzg1RFQ1VndJMHdTL0xTL3pDNnltcXJjMmRQZk5P?=
 =?utf-8?B?M3R1UnpWV2Jkbk5Dc3VvNndhclVxQ21EK0RUUUFKL21HdGpMemZSYVRwbW94?=
 =?utf-8?B?cWZRak1aQW1UaWVwVHMySGptVlptOGQxcjJCVlU5OCtaazZraSt5N2Y0UnUw?=
 =?utf-8?B?cWZVc3BhMHBuMkRsV0g1KzV0cmdSK3BlVmdGK3FIcnU3NkJhUDk5cHVmNFNo?=
 =?utf-8?B?bDg0aWZpYWxVZWZKekpEcW40MENXNTMvK2NlQ0pEYnRTMjhiSzBuM2FQSDJR?=
 =?utf-8?B?N1loUmVYaExZQXA1aVJQeHFOdjFtUUlOdkNiUk5ObVgzTGRBelZwdHF1NVBL?=
 =?utf-8?B?ZkJ0akt1QU9WMkxhaVNNUW9JaEZhaDJVcW5hejZMWVFVMWZlR3VGakE1WkU3?=
 =?utf-8?Q?Jatx7W4LQ5wAU0qPWvrhGEd//vp2Ifi3?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG01TlFBeXBiWEpncnNGVEtVK3kwRGJYNUxqOEdoZHpxY21QNXpzeXlvTkZZ?=
 =?utf-8?B?SHgyRVZObmVWNGsyQ091T0FXUTBqL1hmaWZoUkVLSkNGOXFrKzVqejhTMjFT?=
 =?utf-8?B?UUNOZDlUSzZweENSUGxsOCtsdUVieWgwTjlGd2xSZ1FYUzh0Tmt0d0g2UDNF?=
 =?utf-8?B?TW5QVHl2cVgvRjQ3T2loL1libS9aZnIzQzJFZDdWR3VLdlhHcXNhYjk5MkFO?=
 =?utf-8?B?bVQ3M2hURm0xV2VpWU1LR05kblV3YlJLUlE3Tm9lMjBuMWZZekRzWjJOaEE0?=
 =?utf-8?B?WTRMdHZuZmJJZEcxYTJackhYVW40VUo1bUNGSUtNZWhrSE44b2NMR25oWVEz?=
 =?utf-8?B?cFVQbmlRVkNXeXVkZEdwaTJ3TkJ3NUMvUGh1UVpYYTlHRWtPS1c0Y09ZNGlx?=
 =?utf-8?B?TUp5eEM1N3d2N3JiN0dGUlA4MWhPeGVXVC9va1o0c1dMNHVpM1BpYzRCcmt4?=
 =?utf-8?B?M1loaXoyemhmUjJqSG5JaGdWTExMZ211NVVFaWtkbjF5NnNNUjMwOGNreU1H?=
 =?utf-8?B?UUFNa25kVHNWekd0S3k5R2JBbHlpYVp1VlJ4Mm9oNVlIM3Rib0w3WFhDUDFI?=
 =?utf-8?B?Tll3UCsvUkZBQkhCaEtjRHVOQjhJWnhpMXdYWkZMcU1ONDVjb3hiaE5IY3lJ?=
 =?utf-8?B?bFdTYUk2VythU3JhV0ZlTEU1anBGcUg3Vml2TFNBaWNoblJaa3JqMUJnekN4?=
 =?utf-8?B?L2trVDVtazIyR3JMa2E2WW5tMGxCZVlleUtjOG43UXFwdWtFR0puVkFsVzVw?=
 =?utf-8?B?MkdYK2NyS3h1T0QzWTRnRG5FdDZoSmZjejRMU0R5MFFWcVdVbzRhcGRuSUlJ?=
 =?utf-8?B?cDBaRGJSWDlWTnd3ZmxWcktTMVVvTCtrUTUySGhZRG1BR0R6aUkzTjlVWmlo?=
 =?utf-8?B?My93TlFYbURLSFB1Mkw0UTNSKzRjR0cya3ZkUXFqRE83MUFjUXlORGVtM0Nq?=
 =?utf-8?B?NjRHNE1aZ0pFUE1vKzhqR0xMdUxqcERsaXBXN083aEJycEhqTlZqeDF1bGhS?=
 =?utf-8?B?WEFuTEx2Tjh0RHpZdlNLZTh5OU8vaEdSRU1MWW1YZUtIdDBWUzRmZEJaS1ZQ?=
 =?utf-8?B?Q2kzald2TXZwZWVHcmtESTRJWGZrSEhVYjRxbDNjVXhWQWF0R1dnNUd5eEZJ?=
 =?utf-8?B?dkkvVEhoNjVmSDBmRVBaNTRkSkdZQVJWZnNqSnBPMG1Ub2h1YURRbVZYNndG?=
 =?utf-8?B?ZkdlS1V0QUpVMm5oVXVYQUpOMzJld2ZtSTZCaEdmTGo0OURsS0N1NTliNkda?=
 =?utf-8?B?NjFGcW5aaTMzT29ucWZhSUdWMi9xQ1AvZEVBcDB6WE1jOW9sSmVOcy9lOVZV?=
 =?utf-8?B?VnBYMnpwV2lNZkkrZURLL3Rpamk3dzNqeTlvdVh3UkFnWmFwVmV5OTRrUS9B?=
 =?utf-8?B?VDUzcTV6UTNxbncwakhsR1Y5RnpRQVlFOE1pRFJqeng1ZWlZSG5hQzVJdWw0?=
 =?utf-8?B?MC9KT29VZkpDOVZSWWxOWnpSWCtiRFI5MW1RcTZMbklDUXk5MXF1KzVScWND?=
 =?utf-8?B?ZUY0RzluYmJlSFNOcW1IRSthcFlib0s1NEsraWc3VlJjRTRwZE1oWWhxVndy?=
 =?utf-8?B?alBSU21vUEN3a2VxdnZOWHU3ZXREQjIwRVE1TXdQNnpNeEw3MUdrR3RaajJ6?=
 =?utf-8?B?cTUwdTR3Z2lORHRQWjdOcEF4Y1pOS3VmYjRVc05LajJUU1NmZkFPRmJCM080?=
 =?utf-8?B?c1F5KzZOUWVMMXZSQkxXM0tGb3NraVBQcUwyVExQMCt5OWVZeVNiS1NxbWxY?=
 =?utf-8?B?bXVHK2t5T0lBNWZGTGpMYm1XZlRmaTBvYkV1RnhsZmRnR0NVS2wyUkNIaXp2?=
 =?utf-8?B?a0NibEdYRCtCaVg3QjM2YkZXcWt6RTk5cTZvNEtQajM3T1BOR3JPbGJKd3kr?=
 =?utf-8?B?MmpFSUM4VS84VllIbWNpOWxrRzBKSkZwNHNYcFpiTzRsOThzUjRSeG0vdkhD?=
 =?utf-8?B?VTFWb2MvbWdTS1pDZnM0b2h6cE1QbFRuSUtTdXNDZkJwNWdaMVV5dmZCTUFX?=
 =?utf-8?B?NGdUOXlKSkE0cFloL00zV21mTzBVaEFiaW9IbmNJVmFYTEZ0bHVvLzVBZVFE?=
 =?utf-8?B?dzBLWGtMTFRiWHFiMkdYclJtZ3JqdFB2aVhFc2tCcHg0d3hJcVg2TWFoYTRq?=
 =?utf-8?B?VS9kZ25ZY204Yi9KQnlFY2NtSlZLYjduZzRyVlhQUFdjN2tvQ3RJZ2QrMlZa?=
 =?utf-8?Q?XvrkXAfzdGlbhK34D5HcRyk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3549A45ED4B90479882ABB1AC09BB42@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2311d3-ae64-48b0-5784-08ddfd314e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 19:17:16.1317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sm8yKtr9aPkmCC6hIdSCIV+doflEQ6rtN5vblAevKpuEc+/mXXtcSTYhD4eBq4JpRysP0PEz4Y/9Vc0m6FYjR8QgVzTQs3kDfV+AUAuH0Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5984
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA5LTI2IGF0IDE3OjAzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBGcmksIFNlcCAyNiwgMjAyNSBhdCAwMzozOTo0NlBNICswMDAwLCBFZGdlY29tYmUsIFJpY2sg
UCB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjUtMDktMjYgYXQgMTY6MDcgKzAxMDAsIFl1cnkgS2hy
dXN0YWxldiB3cm90ZToNCj4gDQo+ID4gPiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICJhIGZ1bGxlciBz
b2x1dGlvbiBmcm9tIHRoZSBnbGliYyBzaWRlIj8gQQ0KPiA+ID4gc29sdXRpb24NCj4gPiA+IGZv
ciByZS11c2luZyBzaGFkb3cgc3RhY2tzP8KgDQo+IA0KPiA+IEkgbWVhbiBzb21lIGNvZGUgb3Ig
YSBmdWxsZXIgZXhwbGFpbmVkIHNvbHV0aW9uIHRoYXQgdXNlcyB0aGlzIG5ldw0KPiA+IGtlcm5l
bCBmdW5jdGlvbmFsaXR5LiBJIHRoaW5rIHRoZSBzY2hlbWUgdGhhdCBGbG9yaWFuIHN1Z2dlc3Rl
ZCBpbg0KPiA+IHRoZQ0KPiA+IHRocmVhZCBsaW5rZWQgYWJvdmUgKGxvbmdqbXAoKSB0byB0aGUg
c3RhcnQgb2YgdGhlIHN0YWNrKSB3aWxsIGhhdmUNCj4gPiB0cm91YmxlIGlmIHRoZSB0aHJlYWQg
cGl2b3RzIHRvIGEgbmV3IHNoYWRvdyBzdGFjayBiZWZvcmUgZXhpdGluZw0KPiA+IChlLmcuDQo+
ID4gdWNvbnRleHQpLg0KPiANCj4gSXMgdGhhdCBzdXBwb3J0ZWQgZXZlbiB3aXRob3V0IHVzZXIg
bWFuYWdlZCBzdGFja3M/DQoNCklJVUMgbG9uZ2ptcCgpIGlzIHNvbWV0aW1lcyB1c2VkIHRvIGlt
cGxlbWVudCB1c2VyIGxldmVsIHRocmVhZA0Kc3dpdGNoaW5nLiBTbyBmb3Igbm9uLXNoYWRvdyBz
dGFjayBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgbG9uZ2ptcCgpDQpiZXR3ZWVuIHVzZXIgbGV2
ZWwgdGhyZWFkcyBpcyBzdXBwb3J0ZWQuDQoNCkZvciBzaGFkb3cgc3RhY2ssIEkgdGhpbmsgdXNl
ciBsZXZlbCB0aHJlYWRzIGFyZSBpbnRlbmRlZCB0byBiZQ0Kc3VwcG9ydGVkLiBTbyBJIGRvbid0
IHNlZSB3aHkgYSB0aHJlYWQgY291bGQgbmV2ZXIgZXhpdCBmcm9tIGFub3RoZXINCnNoYWRvdyBz
dGFjaz8gSXMgdGhhdCB3aGF0IHlvdSBhcmUgYXNraW5nPyBNYXliZSB3ZSBuZWVkIHRvIGRpc2N1
c3MNCnRoaXMgd2l0aCB0aGUgZ2xpYmMgZm9sa3MuDQoNCldoYXQgSSByZWFkIGluIHRoYXQgdGhy
ZWFkIHlvdSBsaW5rZWQgd2FzIHRoYXQgRmxvcmlhbiB3YXMgY29uc2lkZXJpbmcNCnVzaW5nIGxv
bmdqbXAoKSBhcyBhIHdheSB0byBpbmhlcml0IHRoZSBzb2x1dGlvbiB0byB0aGVzZSB1bndpbmRp
bmcNCnByb2JsZW1zOg0KICAgTm90IHN1cmUgaWYgaXQgaGVscHMsIGJ1dCBnbGliYyBhbHdheXMg
Y2FsbHMgdGhlIGV4aXQgc3lzdGVtIGNhbGwgZnJvbQ0KICAgdGhlIHN0YXJ0IHJvdXRpbmUsIGFm
dGVyIHVud2luZGluZyB0aGUgc3RhY2sgKHdpdGggbG9uZ2ptcCBpZg0KICAgbmVjZXNzYXJ5KS4N
Cmh0dHBzOi8vbWFyYy5pbmZvLz9sPWdsaWJjLWFscGhhJm09MTc1NzMzMjY2OTEzNDgzJnc9Mg0K
DQpSZWFkaW5nIGludG8gdGhlICIuLi5pZiBuZWNlc3NhcnkiIGEgYml0IG9uIG15IHBhcnQuIEJ1
dCBpZiBsb25nam1wKCkNCmRvZXNuJ3Qgd29yayB0byB1bndpbmQgZnJvbSBhIG5vbi10aHJlYWQg
c2hhZG93IHN0YWNrLCB0aGVuIG15IHF1ZXN0aW9uDQp3b3VsZCBiZSBob3cgd2lsbCBnbGliYyBk
ZWFsIHdpdGggaWYgYW4gYXBwIGV4aXRzIHdoaWxlIG9uIGFub3RoZXINCnNoYWRvdyBzdGFjaz8g
SnVzdCBkZWNsYXJlIHNoYWRvdyBzdGFjayByZS11c2UgaXMgbm90IHN1cHBvcnRlZCB3aXRoDQph
bnkgdXNlciBzaGFkb3cgc3RhY2sgcGl2b3Rpbmc/IERvZXMgaXQgbmVlZCBhIG5ldyBlbGYgaGVh
ZGVyIGJpdCB0aGVuPw0KDQpBZ2FpbiwgSSdtIGp1c3QgdGhpbmtpbmcgdGhhdCB3ZSBzaG91bGQg
dmV0IHRoZSBzb2x1dGlvbiBhIGJpdCBtb3JlDQpiZWZvcmUgYWN0dWFsbHkgYWRkaW5nIHRoaXMg
dG8gdGhlIGtlcm5lbC4gSWYgdGhlIGNvbWJpbmVkIHNoYWRvdyBzdGFjaw0KZWZmb3J0IGV2ZW50
dWFsbHkgdGhyb3dzIGl0cyBoYW5kcyB1cCBpbiBmcnVzdHJhdGlvbiBhbmQgZ29lcyB3aXRoDQpX
UlNTL0dDU1NUUiBmb3IgYXBwcyB0aGF0IHdhbnQgdG8gZG8gbW9yZSBhZHZhbmNlZCB0aHJlYWRp
bmcgcGF0dGVybnMsDQp0aGVuIHdlIGFyZSBhbHJlYWR5IGRvbmUgb24gdGhlIGtlcm5lbCBzaWRl
Lg0K


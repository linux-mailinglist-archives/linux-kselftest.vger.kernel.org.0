Return-Path: <linux-kselftest+bounces-38218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3552B18DF3
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 12:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A7817FE00
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D96F1FE444;
	Sat,  2 Aug 2025 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGypQ3D9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22961F78E6
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Aug 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754130419; cv=fail; b=Hzps/RGz+ezqqFUj3FUtqv/wM+3JjVumah5PYHsR6uLw3BTUas5Jz5XNgm8niSOtdo3Cgr4Z6PBvkua/gzivK55fwVDIBE7dEKV5vJ1wWNLe73M8Eo28yOT1Z0uX/JOzs0VpEXtcka2uYYYOLEv6ZxBPukUH4KqkCqJedK+6Tmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754130419; c=relaxed/simple;
	bh=JqFWo9zXEAR9YWmXVJs7El+3aYCjhTtR4ewK9XuL1z8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XVPt18mqb16S+6yeVbdkqZV0Wy9+9wn8UKVdudqfNRe2CkkgLiycl85TCE24LwU0Qz4P2EB/8YoPpM8BwNDi7LNMQjI76rAZF5aYfUFN77n4B6rBEvGYggISDQogQaP1OCdAJ1DuUvLcEZXN3SOAXkJYHLKm1OfNUTFGMskjuh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGypQ3D9; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754130417; x=1785666417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=JqFWo9zXEAR9YWmXVJs7El+3aYCjhTtR4ewK9XuL1z8=;
  b=XGypQ3D9212vDIhgVRygtrewiH5uFzPK0yyou/oHm7/3x2B9aDK3PRrv
   HDooc7bfftJNa3/iGm0tFrN11FIWhniyqNHqvE5TfzF6kgVcLmN6uNJwp
   UtmL/mCwBy3pwOxcwZCtacONAX7tljDX6U+4Yiq/3VfMTX5x3XyUkdqMT
   87DzLfcIOes4s2/Q9e/7FbZbe+yXyDmpWpd1LEEmJ7/fHRoE71Y0N96rx
   TG2sVCy2cju6EF0UnJTpamNI1L7cDZNUGOEeXWM8en3VY89S2zsxo+S1p
   WO3UjHjfH4ZJeShknTj25IgHaR+TilP186wKpsyyKezR4tMN7ZKOiNcfr
   A==;
X-CSE-ConnectionGUID: UJT+lTqkTe6R/fkJONxLAw==
X-CSE-MsgGUID: VlqYUswKSEW29b2YT/utwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="79014615"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="79014615"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 03:26:57 -0700
X-CSE-ConnectionGUID: M9zm2PybSDKN2vK6B0ZWyQ==
X-CSE-MsgGUID: f+JSLmvvQaOgaZpegS98Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="167951628"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 03:26:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 2 Aug 2025 03:26:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sat, 2 Aug 2025 03:26:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 2 Aug 2025 03:26:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3+kPwajFJP7gz8TxHqV/01gQ3kVsJisysdbaSkcTNw6NT2XBGhnEfAhuZjIwFtbgedjdQR2Rqp9wxgXmHRnND1j2KeHXIt25aBVajSo+0FD5Ul9U0FRBEEeou93Ae92J3Wu5VjLZmfado9Y6wlJHOjLrZJpN4dzyRC/U6BWF0NYniN4nzITWWxikN9Vh+Qofgme5hs78Y91/kVozhUE+IpGqeJt6NFM51rdI4WQ0Sd06LJ1P7INQNNJEvu1cGO5t2hFbGCEftNp9xpZ/CWkucnYkGhRg1Ja38nNUK3mYp9bmvaq317FNOb9beeE1g1u0adfTDsM7dVes3TKKmd44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNrcZnpiMMSOXzhHBbujN2shUHHnbX/K/Z+3k+dT1tA=;
 b=SxF6FJ9JtoIVdHys8n51xDCrMH0qhC2tMz9Ud93yjZkHbOwKnw/8ug7/Mq+6Bv77rj3eYmHP3JdFoXIvyEHd0bDIHrH4A/7KRuX9Pwg6ofHABVvOetebx8O5hTUYiUrWNJV/teU8G8VqTcOkgysq0cf6x10+g8i+lYPUfIZ2wSocBLHksySxhydmiZYUSPOkjWghv/Znz8s3ffNoHjLKecxRnZtXbW9mSZqqBBcjokbIby4U4ONcul5wAdiQGi4hUw6gTNFqe7KIv151g5uEWVkegq8ZdKv10UEIgHRbWAqD7Pm/ymS4SmQNYn3tuETOS1URh+/wJwiyiXdZ/ipiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.13; Sat, 2 Aug 2025 10:26:34 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%7]) with mapi id 15.20.8989.015; Sat, 2 Aug 2025
 10:26:34 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "linux@weissschuh.net" <linux@weissschuh.net>
CC: "w@1wt.eu" <w@1wt.eu>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] tools/nolibc: add signal support
Thread-Topic: [PATCH v3 4/4] tools/nolibc: add signal support
Thread-Index: AQHcAlebACylJcYnlEK6eTyMPMAidrRN59CAgAFDVoA=
Date: Sat, 2 Aug 2025 10:26:34 +0000
Message-ID: <bae0c68a9cb24aa5d16f0df74959207ea4385c66.camel@intel.com>
References: <20250731201225.323254-1-benjamin@sipsolutions.net>
	 <20250731201225.323254-5-benjamin@sipsolutions.net>
	 <fbd9add3-dd99-4deb-979d-79ecfdae2f6c@t-8ch.de>
In-Reply-To: <fbd9add3-dd99-4deb-979d-79ecfdae2f6c@t-8ch.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|DM4PR11MB6552:EE_
x-ms-office365-filtering-correlation-id: dfec5d29-bece-490f-90b8-08ddd1af0e64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NE1tdURRc01ENmNnZ0ROOHdmQ0R4U0ZwWEMrSE82STlGZHljQXkvRy9SbjRn?=
 =?utf-8?B?azY5NVk4VHJubW9JWkJoTDdab2pZKzFFd0NVZFNPS1BIYkhjMzFRUlBBckE0?=
 =?utf-8?B?eE41T0o3N2xzdUJCK1N1TjZvVXFnSkg4bFZoSXlpZnQrVkVra0VXZEV1UDBr?=
 =?utf-8?B?OXo4ZnlzQUlsY0ZodWFhazJtRFJvSkdGOHhKZTA2YWhwdEY5aXlES2J4aGRN?=
 =?utf-8?B?SndzRW9LVWFodnVnUU83Q1NGaC9LaVc0WDdFVWp6NW1MT1hTWVcvRHBkbzVL?=
 =?utf-8?B?WTliTng4TkJ1U1ZvdmpXdnFFSUdYK0lpME8rZXlYOXA2VWprOGpkaTRVM1hR?=
 =?utf-8?B?THR2UDlsNlREb3hZU0t6RnM0aEtoUUdHMkcxNmo0dUl1RGtkcFBJakc2d0lT?=
 =?utf-8?B?bWpiM1Q3Yzg3SlhzM1FVVjNZVW5WMlNINlA2SVo5K2w4UU9MZmFlZm1hVmtr?=
 =?utf-8?B?MFFWUjVsUmsyUkxGNkV5SzVJYk5oc1BETytXOTlSUFgvUlBQRU9rZGtLbDY0?=
 =?utf-8?B?RGMzZDR4ZmNDa1JGMHFWTGRzVDh6eHRxNkNsRXN0RXMzSDlQaGIxekFQK0NH?=
 =?utf-8?B?L0NRVTdBc2pCSUs1eEZxN28ySStkZFBGS0JBK2p1Q3BxOE5xMEc5Znc4OUlS?=
 =?utf-8?B?dFd4N1NNY21oV3h1SnhJcDBRZFpkTDVQT1ZLQlpHTXRnNE8zdGZaWkJlUnh3?=
 =?utf-8?B?NmNDWE5NbDFpaE9tbURKNCtVLzFjMUhTN2o4cnVQMWlxSVJDWTlLZjVuWUxu?=
 =?utf-8?B?N2RRTFlaN0svejNYeGZXN0FBZkRNdys2aXdnNlN0bUc4M2gwUW00Qm9rNTA1?=
 =?utf-8?B?UFF6K3VicnRFK2ZTM1RDbFkxalBodEZjN2I2aEJ4TDIyN1BvZitXZitLeWE1?=
 =?utf-8?B?eDNOc2NHYTZJbUtXYUZPZXB1NDJnZW1jSXdJTytOZlR5V1JEeENXMExpWkI2?=
 =?utf-8?B?WGtwZElkQlo2S1VBYWNWcXZvWVBJSG56Z2xkOENxZzk0U1Q5UHZlKzkzSGQ2?=
 =?utf-8?B?c2FPZDRvVkNWNTkwNVQ1NXdXcHV3YWVvQWhNWERQNU5iMXpOWlJoQ25pcUVZ?=
 =?utf-8?B?SVA2U1dheXc0YmMzdEFXU09USzQwYjlwemRiZkphenBUSnllM2oreHk2cTRS?=
 =?utf-8?B?aHF2ZzAzSlpHZDZJMnYvRGVZbHFVZWQrbC9MUWVzQ21CL2pGaUV1TkRlZHlz?=
 =?utf-8?B?SFZtdzZ3bHhXT2RZVm84ODVQRFA4VmNFbll5bHNEcDdwQWszLzFQak9UeG9z?=
 =?utf-8?B?OVlWakF3WHlZUjJCRk5xUks1T2FZZEZmTndjQjRlek5YT2J1QlZGZUNtTWZm?=
 =?utf-8?B?aWZ2cm9RQWMxRHNmRjMvOWIyeCs3OGpQelZXWFJHMForbU03QlNEOW9PNVFi?=
 =?utf-8?B?aWxjNFQ0YkFIazNtTFpwRzY1U3NrMS9ZMGZKYUlQY01sNXFkNVc5eTEvV1JM?=
 =?utf-8?B?NG9yZ0ptT3BackovdExDd1ZrTkNBdXB1U3l0UTRlZkhLZzN1anFEb3dxKzFT?=
 =?utf-8?B?ZXAveWFycGZMMUR4T3pIQldFdDJiNjYvU1BJRnVPTkJkMEEwWFFseWpvNWEv?=
 =?utf-8?B?NktXK2tHUUlTQ0Y5YUdLV2xIODV1RHF1eVByRnd6c3p1TnhHWGFDMVNtaHZB?=
 =?utf-8?B?L3JIbnpMbVJHWWFPTGsxU0YwTm5lb3VXbitJclhzN3dkTy9DektwK3E1MWhz?=
 =?utf-8?B?cjVkZlMydHc2aGd4dk9rbFBRWGhrWDRWZFM1djdqNk5EbDdNQmpUbmxWNGlJ?=
 =?utf-8?B?b3NHajhMR3V5eUZBbEpLMTIwckZYU040dy92UlE2cC9GdXRvaFAvRWI3YkRo?=
 =?utf-8?B?SDVlVDI3bzBOdVYxckJXUzdjY21xT0pva2tpNCs0QmgzU0VscS9ING5jZUFD?=
 =?utf-8?B?cFJXNGlxUDlURWpCd2pkZzVPZzI5M1NnMnFiejV3K0F2c2pnc0lqZHFXeVI0?=
 =?utf-8?B?aTV1NEdRSTJFbFd5dldtU2RIR1R3YytCUDVJeGh2RHlNbFBoZlFPK2xaQzYw?=
 =?utf-8?B?ZE5xRGF1NXNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um0yZ1BXRGU4REdrWHEwQ3FPNUJyS0Zjd0VUcGVtWFRRSjR5MHRmeUdGVHFs?=
 =?utf-8?B?R1VETGlOTXJzVStFV09pbWpaeU04NkhYVTRmYW80aG5hbDQ5cHZzcjVwT2o1?=
 =?utf-8?B?OVJRVFZvQmdpb2E1Njh2cjdCeFUvRVpjQnhwWk9aS3pkeG56WXVKS1J2R2Fi?=
 =?utf-8?B?TFplbVNMUDNteU11aXhscytGRmFsRmhSNlV4dldlTHR3T1h5UGN1SFdCVWEx?=
 =?utf-8?B?NWFaMEYwUytSL0F5cFNvZXZUNEo1NTJzNGtOOGZGTE4vMDFXbEt4L2RYMmJx?=
 =?utf-8?B?UTdOMTkvSFNRVFVCOEZsbjVyLytwdXFwQmh6bFlOaVhyeUVOVGJqNTNtdXBQ?=
 =?utf-8?B?ZVduVUVjeTVpVlBjMHFqZzJweE9wSllRK2k3Mk1Ka2o4S25STTJIVEdQWStT?=
 =?utf-8?B?eTVjOVluZVNwQVNSMjRIdnBNNXRXUTNVRlpwMFpBSDd3R3dHL1B2VDg3SUtW?=
 =?utf-8?B?T3hweTFuSXpNOHA1UTlYREVQeG9vZUtoZkFhSXNVNUhpT3RzMXJwdFh6N0Yy?=
 =?utf-8?B?eHhtektCTUJZOGhZNWYyZ2FXNkhNUmdLKzV0VS9Ldzh6dC81LzMySG9OYVVF?=
 =?utf-8?B?TGxxZnVjd1FWWkNBK1JSVUxEMTRXc21NZFVsMnVSZ0o3dGhOTGUyK29pb2Fz?=
 =?utf-8?B?dFJ0RVJNdldhU3JOZVM2SFhwOUVXSEltd3dsYllUT2tERVExT1JTR1hTTkdn?=
 =?utf-8?B?VktTdjRCS0lCYk5DS3k1Tm4zR1YrU2ZMVTZGOTJlRTF0dWw2MjNLREF5L0JJ?=
 =?utf-8?B?OVlYb0dkcVYramlqc1VFRFBBNU1vbkNweHhVSGpjTzl0UVF3a0hIWWVwaFo5?=
 =?utf-8?B?WDJSUTc2aVlrTW5ZaHhBbk9Sc3I2SUZ1eS9EYmlmQnhZS1R2b1A0cFo2Q3E0?=
 =?utf-8?B?ZHF6Q3ZoWklPOWw0UExFTFFRZHFTYSt1eTRQVHh3WTUrNCtBZER2MGhJZlFj?=
 =?utf-8?B?RjRNNk9VUkJwaW5TTHNFT0llalhyanh5S0F3TmZLWFgxdVo1QVB5WUdtRjFY?=
 =?utf-8?B?WUhSalExK0JaYmlmR3hEY0NlU1I4ZENaOUJodWZqVzZ1Z1NzYXZ2MFc2UXpa?=
 =?utf-8?B?d1JUaklZTGhhb2kwUzNLVHRPRzM4N2V3RFd1S2NiWG4rMVc3L2pDb1cxRTBY?=
 =?utf-8?B?MHN4UnMzWEZmNW9IUUU5MUhxb243a1FIVzFMbitqM1psZGgwemp0SXljYWlQ?=
 =?utf-8?B?TGg4cE8yWGtKNm14a2NwRyt4VlVaWXlEckFSNXZFdjJxeGdXZVFkNVFxSEl3?=
 =?utf-8?B?Q2k5M1I3bTd6KzhiOXRlenVlSHNzSGFDOU5YdUhSNFI2RmdweVoyZ1c5OGZs?=
 =?utf-8?B?amVwMUxkMm1RMU44NzRkZ2ltaDRFYXl6WlA2L2Y0SXdoWjVYbUY5aWFVZ0Qx?=
 =?utf-8?B?VTNmWjlkM3NEZTUrdnR1clFqWmVqWFRzMHhOK0FNc3BTUDh2YTl1QzAzNTR2?=
 =?utf-8?B?MytnQ0VxR01mRnUvZytZZDYxTVB5VVU1OFNuRGVGS1R3UTdnek9PUGY0RXhM?=
 =?utf-8?B?YSt3S1FlbHZXQUZiT2xhWFc5dXEzbXBlNlR5SnIwa1BUQlRZb0E2TlhGQ2Zi?=
 =?utf-8?B?aXVUWFNLeWR6M3V6UGx1QzZ5MnRSSmh4M0g1SHJFTURna3RNN0FLd3huakpw?=
 =?utf-8?B?dUNvQnJ0eFh0Z25HZU85N2YvY29uWlVQUDlBODU4Z2pvOERyN09RdE8yOUpk?=
 =?utf-8?B?UWIzUmF3UGdtRkM4VUhXL2NLUTh0aEZpTXZqYkhXN3NJY1dBVGhTY1ZTcS95?=
 =?utf-8?B?Vmd3TmYycmlkNEgyRldQbTYwR1QzVnFtMlBlVkhVZzZCSGwzNlhodEszTnEv?=
 =?utf-8?B?ekVnRENJSTQ1eDdaeEFtVjJZWmllNVRUUFlVemZHRS9rbmxZL0hvTHRjWnVU?=
 =?utf-8?B?aHF5MENMeTVOdXR5RjQyVS9lbmo5RE9pUk40eDRISWFnZHdZMjd4WWRPM0xh?=
 =?utf-8?B?Q2VBNCsyQ3NqS3pzUTVLRDdSVkExWm1Bb2laWlZJMi81amQ5S3l5cnY4Rzdn?=
 =?utf-8?B?ajNGWW0walNjSE8vaHFMSll2VXJaKzYrdEUzdURjRVZnU3JORm0xZEFDSHEw?=
 =?utf-8?B?dU9VaUlUNVRkZlloaHkvZ1cweW1sZTkvbWIzYW00VEZVUG1PMVR1QTQ3UWFF?=
 =?utf-8?B?RmVqVkoxcU1QRStsQTRoY1ZFTHo4QjZVZ3FOT0U3SWJlVDJMTS9yTlR4UlhC?=
 =?utf-8?B?ZFg5UDREWWZMT3UrQzVuZDdLYmZoRlcrRGpYWXlyWmxkOWs2SFFkcE9Xd1Vt?=
 =?utf-8?B?K0N5V2FYTGxIUjVSRzlTUXJ1WHZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11F88A40F0E4CA4FB983489F977562F8@namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfec5d29-bece-490f-90b8-08ddd1af0e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2025 10:26:34.7137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3tJISvegcRy1570RNSgkkuQyDEHsvMEAbj5v/Q7p/lFvQ6B/ihoT2mD9/l8O5A7/dvem4bxN2dNTsNHXto8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

SGkgVGhvbWFzLA0KDQpPbiBGcmksIDIwMjUtMDgtMDEgYXQgMTc6MDkgKzAyMDAsIFRob21hcyBX
ZWnDn3NjaHVoIHdyb3RlOg0KPiBPbiAyMDI1LTA3LTMxIDIyOjEyOjI1KzAyMDAsIEJlbmphbWlu
IEJlcmcgd3JvdGU6DQo+ID4gRnJvbTogQmVuamFtaW4gQmVyZyA8YmVuamFtaW4uYmVyZ0BpbnRl
bC5jb20+DQo+ID4gDQo+ID4gQWRkIHN1cHBvcnQgZm9yIHNpZ2FjdGlvbigpIHVzaW5nIHRoZSBy
dF9zaWdhY3Rpb24gc3lzY2FsbCBhbmQgaW1wbGVtZW50DQo+ID4gdGhlIG5vcm1hbCBzYV9tYXNr
IGhlbHBlcnMuDQo+ID4gDQo+ID4gRm9yIHRoZSB1YXBpIGRlZmluaXRpb25zLCBldmVyeXRoaW5n
IGlzIGNvcGllZCBpbnRvIG5vbGliYy4gVGhpcyBhdm9pZHMNCj4gPiBpc3N1ZXMgd2l0aCBrZXJu
ZWwgYXJjaGl0ZWN0dXJlIGhlYWRlcnMgdGhhdCBhcmUgbm90IHVzYWJsZSB3aXRoIHRoZQ0KPiA+
IHJ0X3NpZ2FjdGlvbiBzeXNjYWxsLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWlu
IEJlcmcgPGJlbmphbWluLmJlcmdAaW50ZWwuY29tPg0KPiA+IA0KPiA+IC0tLQ0KPiA+IA0KPiA+
IHYzOg0KPiA+IC0gcHV0IGV2ZXJ5dGhpbmcgaW50byBzaWduYWwuaCBhbmQgdGhlIG5ldyBhc20t
c2lnbmFsLmgNCj4gDQo+IEhtLCBkaWQgd2UgZGVjaWRlIG9uIHRoYXQ/IFdlIGRvbid0IHdhbnQg
dGhlIHBlci1hcmNoaXRlY3R1cmUgaW5jbHVkZQ0KPiBkYW5jZSwgYnV0IHN0YXRpYyBvdmVycmlk
ZXMgc2hvdWxkIHN0aWxsIGJlIGZpbmUgSSB0aGluay4NCj4gS2VlcGluZyB0aGUgYXJjaGl0ZWN0
dXJlIGlmZGVmZmVyeSBpbnNpZGUgdGhlIHJlc3BlY3RpdmUgYXJjaCBoZWFkZXIuDQo+IEFuZCBh
bGwgdGhlIGdlbmVyaWMgc3R1ZmYgaW4gYSBzaGFyZWQgaGVhZGVyLg0KDQpJIHByb2JhYmx5IGp1
c3QgZGlkbid0IHJlYWxseSB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW50IDotKQ0KDQpZb3UgYXJl
IHJpZ2h0LCB3ZSBjYW4gaGF2ZSB0aGUgY29tbW9uIGRlZmluaXRpb25zIGluIHNpZ25hbC5oIGFu
ZCBqdXN0DQpza2lwIHRoZW0gaWYgdGhlIGFyY2hpdGVjdHVyZSBoZWFkZXIgZGlkIGFscmVhZHkg
ZGVmaW5lIHRoZW0uDQoNCkkgdGhpbmsgSSdsbCBhbHNvIGRyb3AgYXNtLXNpZ25hbC5oIGFnYWlu
LCBzZWUgYmVsb3cuDQoNCj4gPiAtIHNwbGl0IG91dCBzaWdzZXRfdCB0ZXN0cw0KPiA+IC0gYWN0
dWFsbHkgbWFyayBzaWduYWxfY2hlY2sgc3RhdGljDQo+ID4gLSByZW1vdmUgdW51c2VkIHN0cmlu
Zy5oIGluY2x1ZGUNCj4gPiAtIGZpeCBTSUdVU1IyIHJlc2V0DQo+ID4gLSBVc2UgaW50ZWdlciBm
b3Igc2lnbmFsX2NoZWNrIGFzIHRoZSBzaWduYWxzIGFyZSBlbWl0dGVkIGZyb20gdGhlDQo+ID4g
wqAgc3lzY2FsbCBjb250ZXh0Lg0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIHRoaXMgcG9pbnQs
IGlzbid0IGl0IGEgc2lnbmFsIGhhbmRsZXI/DQoNCk15IHJlYXNvbmluZyBpcywgdGhhdCB0aGUg
c2lnbmFsIGVtaXNzaW9uIGJ5IHRoZSBrZXJuZWwgaGFwcGVucyBmcm9tDQp0aGUga2lsbCBzeXNj
YWxsIG9yIGZ1bmN0aW9uIHJldHVybi4gQm90aCBjYXNlcyBpbXBsaWNpdGx5IGFjdCBhcyBhDQpt
ZW1vcnkgYmFycmllci4gU28gaW4gdGhpcyBzcGVjaWZpYyBjYXNlIHdlIGRvIG5vdCBhY3R1YWxs
eSBuZWVkIGFuDQphdG9taWMgdmFyaWFibGUuDQoNCj4gPiB2MjoNCj4gPiAtIFVzZSBuZXdseSBh
ZGRlZCBtYWNyb3MgdG8gY2hlY2sgc2lnbmFsIGVtaXNzaW9uIG9yZGVyDQo+ID4gLSBBZGQgdGVz
dHMgZm9yIHNpZ3NldCBoYW5kbGluZw0KPiA+IC0gUmVzdG9yZSB0aGUgZGVmYXVsdCBoYW5kbGVy
IGFmdGVyIHNpZ25hbCB0ZXN0DQo+ID4gLSBtYWtlIHNpZ25hbF9jaGVjayB2YXJpYWJsZSBzdGF0
aWMNCj4gPiANCj4gPiB2MToNCj4gPiAtIFVwZGF0ZSBhcmNoaXRlY3R1cmUgc3VwcG9ydCAoYWRk
aW5nIHNoKQ0KPiA+IC0gTW92ZSBzcGFyYyBzeXNfcnRfc2lnYWN0aW9uIGxvZ2ljIGludG8gaXRz
IGhlYWRlcg0KPiA+IC0gQWRkIHNpZ19hdG9taWNfdA0KPiA+IC0gVXNlIG5ldyBCSVRTRVRfKiBt
YWNyb3MNCj4gPiAtIE1vdmUgdGVzdCBpbnRvIHN5c2NhbGwgc3VpdGUNCj4gPiAtIFZhcmlvdXMg
b3RoZXIgc21hbGwgY2hhbmdlcw0KPiA+IC0tLQ0KPiA+IMKgdG9vbHMvaW5jbHVkZS9ub2xpYmMv
TWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+ID4gwqB0
b29scy9pbmNsdWRlL25vbGliYy9hcmNoLXMzOTAuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCA0ICstDQo+ID4gwqB0b29scy9pbmNsdWRlL25vbGliYy9hc20tc2lnbmFsLmjCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMjM3ICsrKysrKysrKysrKysrKysrKysNCj4gPiDCoHRvb2xzL2lu
Y2x1ZGUvbm9saWJjL3NpZ25hbC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTc5
ICsrKysrKysrKysrKysrDQo+ID4gwqB0b29scy9pbmNsdWRlL25vbGliYy9zeXMuaMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstDQo+ID4gwqB0b29scy9pbmNs
dWRlL25vbGliYy9zeXMvd2FpdC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSAr
DQo+ID4gwqB0b29scy9pbmNsdWRlL25vbGliYy90aW1lLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgIDIgKy0NCj4gPiDCoHRvb2xzL2luY2x1ZGUvbm9saWJjL3R5cGVz
LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA5ICsNCj4gPiDCoHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL25vbGliYy9ub2xpYmMtdGVzdC5jIHwgMTM0ICsrKysrKysrKysr
DQo+ID4gwqA5IGZpbGVzIGNoYW5nZWQsIDU2NiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL2luY2x1ZGUvbm9saWJjL2FzbS1zaWdu
YWwuaA0KPiANCj4gKC4uLikNCj4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2luY2x1ZGUvbm9s
aWJjL3N5cy5oIGIvdG9vbHMvaW5jbHVkZS9ub2xpYmMvc3lzLmgNCj4gPiBpbmRleCAyOTVlNzFk
MzRhYmEuLmE3OTBlODE2NTY1YiAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9pbmNsdWRlL25vbGli
Yy9zeXMuaA0KPiA+ICsrKyBiL3Rvb2xzL2luY2x1ZGUvbm9saWJjL3N5cy5oDQo+ID4gQEAgLTE0
LDcgKzE0LDYgQEANCj4gPiDCoA0KPiA+IMKgLyogc3lzdGVtIGluY2x1ZGVzICovDQo+ID4gwqAj
aW5jbHVkZSA8bGludXgvdW5pc3RkLmg+DQo+ID4gLSNpbmNsdWRlIDxsaW51eC9zaWduYWwuaD7C
oCAvKiBmb3IgU0lHQ0hMRCAqLw0KPiA+IMKgI2luY2x1ZGUgPGxpbnV4L3Rlcm1pb3MuaD4NCj4g
PiDCoCNpbmNsdWRlIDxsaW51eC9tbWFuLmg+DQo+ID4gwqAjaW5jbHVkZSA8bGludXgvZnMuaD4N
Cj4gPiBAQCAtMjgsNiArMjcsNyBAQA0KPiA+IMKgI2luY2x1ZGUgImVycm5vLmgiDQo+ID4gwqAj
aW5jbHVkZSAic3RkYXJnLmgiDQo+ID4gwqAjaW5jbHVkZSAidHlwZXMuaCINCj4gPiArI2luY2x1
ZGUgImFzbS1zaWduYWwuaCIgLyogZm9yIFNJR0NITEQgKi8NCj4gDQo+ICNpbmNsdWRlICJzaWdu
YWwuaCINCg0KUmlnaHQsIHRoaXMgYW5kIGFzbS1zaWduYWwuaCBoYXBwZW5lZCBiZWNhdXNlIHNp
Z25hbC5oIHVzZXMgc3lzX2tpbGwoKQ0KZm9yIHJhaXNlKCksIHJlc3VsdGluZyBpbiBhIGNpcmN1
bGFyIGRlcGVuZGVuY3kuDQoNClRoZSBzaW1wbGVzdCBzb2x1dGlvbiBpcyBwcm9iYWJseSB0byBh
dm9pZCB0aGUgY2lyY3VsYXIgaW5jbHVkZSBieQ0KaW1wbGVtZW50aW5nIHJhaXNlKCkgYXM6DQoN
CmludCByYWlzZShpbnQgc2lnbmFsKTsNCl9fYXR0cmlidXRlX18oKHdlYWssdW51c2VkLHNlY3Rp
b24oIi50ZXh0Lm5vbGliY19yYWlzZSIpKSkNCmludCByYWlzZShpbnQgc2lnbmFsKQ0Kew0KCXJl
dHVybiBteV9zeXNjYWxsMihfX05SX2tpbGwsIG15X3N5c2NhbGwwKF9fTlJfZ2V0cGlkKSwgc2ln
bmFsKTsNCn0NCg0KPiA+IMKgLyogU3lzY2FsbCByZXR1cm4gaGVscGVyOiB0YWtlcyB0aGUgc3lz
Y2FsbCB2YWx1ZSBpbiBhcmd1bWVudCBhbmQgY2hlY2tzIGZvciBhbg0KPiA+IGRpZmYgLS1naXQg
YS90b29scy9pbmNsdWRlL25vbGliYy9zeXMvd2FpdC5oIGIvdG9vbHMvaW5jbHVkZS9ub2xpYmMv
c3lzL3dhaXQuaA0KPiA+IGluZGV4IDU2ZGRiODA2ZGE3Zi4uZTJhYTkwY2MzY2YzIDEwMDY0NA0K
PiA+IC0tLSBhL3Rvb2xzL2luY2x1ZGUvbm9saWJjL3N5cy93YWl0LmgNCj4gPiArKysgYi90b29s
cy9pbmNsdWRlL25vbGliYy9zeXMvd2FpdC5oDQo+ID4gQEAgLTEwLDYgKzEwLDcgQEANCj4gPiDC
oCNpZm5kZWYgX05PTElCQ19TWVNfV0FJVF9IDQo+ID4gwqAjZGVmaW5lIF9OT0xJQkNfU1lTX1dB
SVRfSA0KPiA+IMKgDQo+ID4gKyNpbmNsdWRlIDxhc20vc2lnaW5mby5oPg0KPiANCj4gI2luY2x1
ZGUgInNpZ25hbC5oIg0KPiANCj4gVGhlIGFzbS8gdXNhZ2Ugc2hvdWxkIGJlIGhpZGRlbi4NCj4g
DQo+ID4gwqAjaW5jbHVkZSAiLi4vYXJjaC5oIg0KPiA+IMKgI2luY2x1ZGUgIi4uL3N0ZC5oIg0K
PiA+IMKgI2luY2x1ZGUgIi4uL3R5cGVzLmgiDQo+IA0KPiAoLi4uKQ0KPiANCj4gPiBkaWZmIC0t
Z2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbm9saWJjL25vbGliYy10ZXN0LmMgYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9ub2xpYmMvbm9saWJjLXRlc3QuYw0KPiA+IGluZGV4IDE4MGYw
NDM2MTI3YS4uNzViOTZlYWE0YzY1IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL25vbGliYy9ub2xpYmMtdGVzdC5jDQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbm9saWJjL25vbGliYy10ZXN0LmMNCj4gPiBAQCAtMTI2OSw2ICsxMjY5LDEzOCBAQCBp
bnQgdGVzdF9uYW1lc3BhY2Uodm9pZCkNCj4gPiDCoAlyZXR1cm4gcmV0Ow0KPiA+IMKgfQ0KPiA+
IMKgDQo+ID4gK2ludCB0ZXN0X3NpZ3NldF90KGludCB0ZXN0X2lkeCkNCj4gPiArew0KPiA+ICsJ
aW50IGxsZW47DQo+ID4gKwlpbnQgcmV0ID0gMDsNCj4gPiArDQo+ID4gKyNpZmRlZiBOT0xJQkMN
Cj4gPiArCWlmIChpc19ub2xpYmMpIHsNCj4gDQo+IFRoaXMgbG9va3MgdW5uZWNlc3NhcnkuIFRo
ZSAjaWZkZWYgc2hvdWxkIGJlIHN1ZmZpY2llbnQuDQo+IA0KPiA+ICsJCXNpZ3NldF90IHNpZ3Nl
dDsNCj4gPiArDQo+IA0KPiAoLi4uKQ0KPiANCj4gDQo+IExvb2tzIG5pY2UsIHRoYW5rcyENCg0K
R3JlYXQsIHRoYW5rcyBmb3IgdGhlIHJldmlld3MhDQoNCkJlbmphbWluDQpJbnRlbCBEZXV0c2No
bGFuZCBHbWJIDQpSZWdpc3RlcmVkIEFkZHJlc3M6IEFtIENhbXBlb24gMTAsIDg1NTc5IE5ldWJp
YmVyZywgR2VybWFueQ0KVGVsOiArNDkgODkgOTkgODg1My0wLCB3d3cuaW50ZWwuZGUNCk1hbmFn
aW5nIERpcmVjdG9yczogU2VhbiBGZW5uZWxseSwgSmVmZnJleSBTY2huZWlkZXJtYW4sIFRpZmZh
bnkgRG9vbiBTaWx2YQ0KQ2hhaXJwZXJzb24gb2YgdGhlIFN1cGVydmlzb3J5IEJvYXJkOiBOaWNv
bGUgTGF1DQpSZWdpc3RlcmVkIE9mZmljZTogTXVuaWNoDQpDb21tZXJjaWFsIFJlZ2lzdGVyOiBB
bXRzZ2VyaWNodCBNdWVuY2hlbiBIUkIgMTg2OTI4Cg==



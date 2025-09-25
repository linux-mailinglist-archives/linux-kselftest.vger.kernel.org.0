Return-Path: <linux-kselftest+bounces-42416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03547BA1639
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 22:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B01A7B8B25
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 20:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF2631A56B;
	Thu, 25 Sep 2025 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYCgBxFh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95AA2D027F;
	Thu, 25 Sep 2025 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832870; cv=fail; b=abK5tQf4lzxYMuDZfDhjIeR+eyd2pZjs2hcgdnKZKpHp05J12sZK98248BFMGR1LVmFEGO51D62GoiMuHHiAph3iRioJ9ODPXaQYYW9ZyF1MhIIRy/NwI/3VeDzikKiRey3Kgw5hLX9c08lwj40SkIxHbhyl9wA9xlf5tZUG3Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832870; c=relaxed/simple;
	bh=UpW/Ty/Vq6W0IhBVB/fNicxvvqHjTkaCAxvyriQpviI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oATRmYx4aetlIDR+AqYo9xh6NRowZNQMtP2+KiN2XW0vH3W1L6XJhW6aD274hU6xvCcejkncxfvoFjmBF7MENdi5YhOgVid2zRjPp/R02FNk726nC//t42HcvpfoMrnDRp8FW5SBDphbKo0nc/dgTf+ugcUjOPKsZRXMOAPzpH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYCgBxFh; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758832868; x=1790368868;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UpW/Ty/Vq6W0IhBVB/fNicxvvqHjTkaCAxvyriQpviI=;
  b=jYCgBxFhdC15S76jzUK5QhHKI3AC8G4R6U9TVoKPIXkoR1zSgVkIZGn1
   FIoltkHBO8xwdL0YV/OxgnU5ruWYsLkXQSYGNYJXnf15dT2JvgT6E1gmm
   6dd3gmCydfNSchhTZg6R3woYiQK8UUPPkaz9fpAHB4vh+mpFaxqnF/y8p
   1TMtKTL3RyLHRpsUWYf6LX6/HqrrAxAgDtuk4z4qNscq7wOYTTzspsVlt
   7g23Fn6DRhy4lUGpWaTbmhxnXXa3l7Cy5kftdxrWA3v9qibfJjn/BcTTm
   LeU3DaEtXvXqEg227cYnhHJfz1NY0LV7mlYhfReJFuNsX5MHrsDOAJzkJ
   g==;
X-CSE-ConnectionGUID: 6tPh3NVmTkaZmLdNL8LWFA==
X-CSE-MsgGUID: nMRZQeJbTQ+/vbY/5Q6pgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="72594195"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="72594195"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:41:08 -0700
X-CSE-ConnectionGUID: mdUSQrzmQg2vCQhbdULdFA==
X-CSE-MsgGUID: 2fn+jHDAS+K4yZ9rhE5umg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177368065"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:41:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 13:41:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 13:41:05 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 13:41:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IF6+JjUy8YlLXEB0+vPxbl7clTlR0CKVhVJZDKqr/O0BUPDEu2/npKc9fsJ0AH+yJZXJtz8QEcRatKx9W62W9NVwVv9Yta9gyq7VvAK6K1NB9Mjt4TnMiMNadZhal7OcmDyF2N4gexMt+xTIfhbSmmNUHR3UFaHTWHZVsDBm62zmrv0J6MH/CzIxtVzmWh8ykQlfMJsDVziOMJVVUJSS8OJYeOYsAhjHZ4QTAEoN71ro+WWkv/9Ac2d/eMHW78qdr49n2uY5q+pbnMIdLovFBZ1auSzc8Ku2GUOkPTuRc0y+l470iiWZpRd2E+/xjzX+PVBjoa8OR4105hIKMlhFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpW/Ty/Vq6W0IhBVB/fNicxvvqHjTkaCAxvyriQpviI=;
 b=DnwuQfL2vIuE3lFa2KdJ9dRhKp94mQNbZMl9gST4A8CZpkhY4fH/iOJC4JNHpt9w+RR+QzHB4ergjlbgT4NfTUqSQPEWSFjasivVifI/tPwFFD0/kPhRWzwW5HET9wf2BpZOWS257r0awy36NYJcpV+vbP24/52n/kj2axLG4w2czqS9srGyvYVB+Puj6VddL1Ei7eiOTAsdqsrPXOZYEkYZPoYjhqsXXZRL/3/DmZLnf5RPTb38z79dGfgLPcbNeuUtIlhGhAqX0RR2rjVU0WY/FeCHPS4Ii4WpTxk5mj8bSK08HD2fhHoPDdoFuTERcFS1rP6F2womZYpgb+JYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB6601.namprd11.prod.outlook.com (2603:10b6:806:273::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 20:40:57 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 20:40:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "shuah@kernel.org" <shuah@kernel.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"will@kernel.org" <will@kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "adhemerval.zanella@linaro.org"
	<adhemerval.zanella@linaro.org>
CC: "nsz@port70.net" <nsz@port70.net>, "dalias@libc.org" <dalias@libc.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "fweimer@redhat.com"
	<fweimer@redhat.com>, "libc-alpha@sourceware.org"
	<libc-alpha@sourceware.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "wilco.dijkstra@arm.com"
	<wilco.dijkstra@arm.com>, "jeffxu@google.com" <jeffxu@google.com>,
	"codonell@redhat.com" <codonell@redhat.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Thread-Topic: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Thread-Index: AQHcKvs2dWZnb030BEKK+EDimBzvQrSkY2wA
Date: Thu, 25 Sep 2025 20:40:56 +0000
Message-ID: <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
In-Reply-To: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB6601:EE_
x-ms-office365-filtering-correlation-id: 10d11975-b5c8-41f3-5fef-08ddfc73d44a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U202cDdjTUYySDhNNUtRQVBlUVJ3eHdmTGZPWlBVck9CQmFLeUYvZTJ0c3dP?=
 =?utf-8?B?NWhUdFM3bUhITDRqMis3WXl4WmNzbDdPWDIwbGNDODdtN0o3NDNWRzRHSm9Z?=
 =?utf-8?B?U25qRi9VdTJ2UmxuZUlxM254Yk1jK04zRS82MExwK2YweWV6d0lRNkFqVUxs?=
 =?utf-8?B?TXZEMDQ0bVFaOCtlK1p1NVNLUWdvK2RxQjR1TFBQRHVLRDdoU2lkbytSOUpp?=
 =?utf-8?B?bDdIRTZuM2dIS3k1SXRxRmV4V1JFSWoxRllUK1ErMXpISmlDbDd5S0N6dG91?=
 =?utf-8?B?bnZtaGhLRG5hamd6SHpqeEZZS3duS1kyaEtxT0Z6emZjMDUwd3pXSWNlRDlQ?=
 =?utf-8?B?aG1hWGZsdG1jVStYMW1wcHNhT3dadm5IWlJ0V2xOMk1qbmVjOVJhOVlUOUM4?=
 =?utf-8?B?R1FicE15LzZGbEdRcENUSFFRdEQ4emZIOVY4OGJPSGVQeGVtZTRoK3JhdE1Q?=
 =?utf-8?B?TnlWVWM2L1Bub0tBWldpcWtSTUxmLzliMk51b1kySnFBZElvdnByaXV5RnJa?=
 =?utf-8?B?LzBTTURpVm12VXFRUFhjZkdUZGhML3VpcFFtQWVwMEkrTnc0cElQZk1GaVJs?=
 =?utf-8?B?TnkwZzA3a21DWlNQTVd1V0gzekw2dHpQQk84Q1F1QjlBdGRNZVhZVWhLSFJm?=
 =?utf-8?B?d2lkV1krb3RBa2JPeHBmajRaZlh2dlBKMFZTZElOR1pPa3dZV0hJMTVMMWor?=
 =?utf-8?B?S2tyNm5zejExcnRUUUg2ZVlDMGV5UXR6Y1NScWNhVGRIRmk4MjlmTkoxM0Fw?=
 =?utf-8?B?ZTEyVXc2ODRxUnZiK25Gc3BPeXpyL2theVJ4RDhaTDM1WWRpNXord1JZRmRZ?=
 =?utf-8?B?RGcyWGJGa1BWdzlhUnZPaS9uT0VaUlhKY3ZNdHhOa0FYU3hLb1RNWVlIR3Fn?=
 =?utf-8?B?TjB4WHJMZTNEN1pEQkxvZmxkR3BUaDZnQWtvNjIxcThHdFpiWTQzL0V4RTEy?=
 =?utf-8?B?QjNHQjlYNmliK1ArTTA5THhlSXI3SlRIeEFIeHJZd2tpUy92eWlsZDRoZHZG?=
 =?utf-8?B?aDZjdE9ZbCtnRUhNdWg0M1hIUmk1NGs1ZXJKekZoUjhXbkNWb3VYL1BtSXM3?=
 =?utf-8?B?R2s0a2VwYlFOVlMrOS9iNkJaeklVL21iTmhFc0tTYStEaGRQakQxcyt3UHQr?=
 =?utf-8?B?L3FneW82N1RwR1pIb2JsOFV0bkZMMGttSW55MW4vU201Si9qOUIrYm12VHV1?=
 =?utf-8?B?QmtmY0tzR29xSHZLSURmalV3TU8xeFdBemt1RlN5bWl3UVluOFhQaDhLaG5V?=
 =?utf-8?B?dGlvRFdSRWIzemZubjA2Z1dXTndPR3hPNSs3OTgwOXlDaVVFVnk4MFB6MlRl?=
 =?utf-8?B?MFk1NTc0Uk9CVTN3M2k5c0E2UXFlcWs1dGthL3RDVkhQOVJodnpTNGIwTDVL?=
 =?utf-8?B?aEVscmxDR1lKRnkyWnBHZkRZdnF1VlZKeEdnWEk0KzlDS1gvNUNmTFNEMTV5?=
 =?utf-8?B?N2hMTlFrK0dkRGZBUDdHVXNyNURCVXdwalhtNktxcVBxMWdmbE54SVYrRHpC?=
 =?utf-8?B?YUVBdXJ2YlhhRk41d2l2UHF2cENOdHYxRTdjOTNWbVVJREtWUWlBOElzUmFH?=
 =?utf-8?B?QXEyNTdnSEk1czY2bWVXU0hueE5YVzlqR1diTVNRQW5aZ1BzVUlPVTY4dUZ3?=
 =?utf-8?B?dkdBVFNNSVRIazMxS3UxaksyTlNPbGdWN0hzeXFkVmVZLzQyWDhldUNhTEJu?=
 =?utf-8?B?Y1ZqY0p6NGM3RmhaK2MzTjZlYVVIZUpHQXBodW8xM3kvOEdoRkp1V3ByWEla?=
 =?utf-8?B?amp3cG9Lait6NHA3QTNPMXRCTjNNTEZJL254VnNMSjV2aDNNTWU5RWZpZ1pw?=
 =?utf-8?B?dWlYbUQ0a0x4TEg0a0N2cWRoYzB5ZHIrR0xvMzdZbDlDTzlyNFZvOEV0ak9k?=
 =?utf-8?B?VmZhemZZQ2N0UUlTMUx5aEpFM2h2RVZPNXdYS3RVSzMzRzJ0NmlZMlU0cUl6?=
 =?utf-8?B?ZlpwbTh2b0RQRDFSeUtua1VaUXI3T0RZKzVIV00wNHQ3SU1vc1JoWGIrWHlE?=
 =?utf-8?B?QldqQ2dTUFZWcS85cUdjblJwQUtyYXQxeU5rVGdjZ3lRaTVhY3Qvek5NQWJu?=
 =?utf-8?Q?Uephlu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGpQc1dvV3piTFhVL241dVRoOVpMbUs3R2hmcHJsZzlUY3M0T2h5TXZJcnV2?=
 =?utf-8?B?NDVPK1Jwd09xSkRsU29OZ1JINjNJVFU4eENFeFJhcDZqL1JMN3RGdGNBS2hH?=
 =?utf-8?B?OUpmQXlrRGIwc3pWT05QL3ZVQmRyUFp2c1JIVnByQkY3NWhoVkNvM3dTM0tu?=
 =?utf-8?B?bUVJSUMyS1NWakRuVnJRdE1YdnJ3ZEZHalNpck1yUjV4VTdzTytwM0hhT1po?=
 =?utf-8?B?N21sU05PTlZYTnBIM2l1QlF3eDc5VW5oRHZraVYxbEUxMHNTdHdKeDVXSkVo?=
 =?utf-8?B?R3lBL2hQdCtpbXM4RnprYk5ncEcyYWYwZzlWZ0xjSmZabFBWWExTbnhldEd5?=
 =?utf-8?B?cjBqMG9URUlJY2ZyekdodGlobDNXbmVUdEdJdlZRRzF5N2hJNjdVL1pueXNU?=
 =?utf-8?B?azVEMm81dUkrVWE1Q25XbDRXZlVaMEgvcTRMd2JwY2I4TDFKa3oyOHJSbUxt?=
 =?utf-8?B?aHR3NW8zVEkzMjV3Zk15VGlZK2FYbzFEclpDckhOQTJXcHNvL0x4aU1pWW5D?=
 =?utf-8?B?akY3RmY5Mjd6c2xSM0RXdkRrcTV3WnJkOVpNYzcwekhCaFBhZU82YXJRd00v?=
 =?utf-8?B?TGdkbTVUSndLOGpEVVVzN3VKdEVHMkNvampZaU1sWWVOelhkL0NHMUl1QU93?=
 =?utf-8?B?NHluS1J5ME9IdzllS3J4ZVVNVm9wUVVqTmtiSUxscWdxMVRIVGpDQ25vU2Jv?=
 =?utf-8?B?cEVSOEs5VG5mK1d1bERxSWxoY0tjRlVKWnN3cC9lM3dmWlltUko3YVlkbWd2?=
 =?utf-8?B?cHpvaWZBc1NXT1dQVXBPYmdkNjBZOFgrMnpwa0w5QjZpQXNlbG1paG05YjZ3?=
 =?utf-8?B?NlZRZFIyZzR2NHBPZHNrcHpWbzVQYlEwS2ZjNWMrdjlxZzdKMmI3R3F4U1lW?=
 =?utf-8?B?U0hrRUQ1L0ZiSDRReUlONS9uNktFazkxNlJoeFhBeU9uYjZ3S1VZYlVWOTls?=
 =?utf-8?B?L3FnU1hNQkN5elNSTmpEWmk5aXAxTEJsT0Y1SHZlTmZSQTMwM0hRSnQzUlcz?=
 =?utf-8?B?dlFCMlRJaU1ZcXhCWll5UmJJeXNNY2s0YW9UcjFOUGFlRlZIb1V6RmFqY3dD?=
 =?utf-8?B?VEJ2MzVQVHZFZXYyaVVtS3cyRDVoTGZqWTJpYjFHYnVZeGJiT0VBTHhrZTJv?=
 =?utf-8?B?VUZPbUdhcVJUUEpiY05XQ2xDWWl1T1M5OUU0d2JySUNWbWZRbHhIc3FVVDNF?=
 =?utf-8?B?aEE3Z0Y5d0poK255KzlMVm9GRCtzNU93ODR2cm5wRmdqRjBqQUdicG8ra29v?=
 =?utf-8?B?OFA5QmtKajFRRWhMVU9LSUV2WEkzZU9xdXpXTkdCRWRPVUxDWDJSR21JUmZC?=
 =?utf-8?B?RlRpY3JKS3JaSlVmWnZnbm45MWhHWU9JTGdTQklzYkhVWUNkelNuYm5SdUQx?=
 =?utf-8?B?SzBnUUR5RllQZU94SzNOYUh1cjN4K1ViYWc5aTh1SjkwTTh0V3FHWk03NTlw?=
 =?utf-8?B?RXBVS2FjWTU3enZ6R2V3T2NkQk83WjZQYzd6R0xpSzc4SnJFN296a1ZkMzVZ?=
 =?utf-8?B?MCtWcmFSNkJ3RTV2LzdWdWlXaE1CZGY2SkdaeHNSMG5jbnhINHZTVHd6NjBx?=
 =?utf-8?B?MkE3V3ZCZkVNbTJ1Zld4b3FrNjI0OHZpenV0ZHdMajF1aHNNYUF2U1RwM0kx?=
 =?utf-8?B?ZlJibk84QkpCMSswbWNYcGpUQXhUdXl0dG53UVFmeGhXTzZMK2JWbHd5cGE4?=
 =?utf-8?B?M0FvWitGYkpQclk4UWFVSkJ0dkU4RDJGY0VkTjFtakQ3Vnc3MTBSM2VwZHlR?=
 =?utf-8?B?eXdGQ3VuU1lwMDhkOXBQNzVDWFEwakRIbHRCMkc2bnI5NXBtaU5vQkNpQ1l2?=
 =?utf-8?B?Q3c4bW1lSTRLQ2xoREIyNG5MdEtORGozWTFDdFBuR05Mb1NNQUVjcGVkcXF4?=
 =?utf-8?B?VTVYQk1Uay9tMis5M1g5UzRCVEU4QjgzZDJpakJ4OWZhdktPVXFkZDFCMVE5?=
 =?utf-8?B?dmdtUDJCWGFYQ1locGpNWTM0ejdab1IwZVFUdHRpVjBJNU9uMzR1eUFvaGk3?=
 =?utf-8?B?dW15aUVIdGxpOUh0S2hKeEZjSkdMTDhPS0x0N2EvWHhoQ0E1Q1lkN3NEZ3A4?=
 =?utf-8?B?d284RldKS29BajRPcFk0eEtvT0Nva2NSU1Y3UnhNSVlBa2VSOEdHUS9iWktt?=
 =?utf-8?B?akd6Y0JBNzNHWVVudGtUNkMyTy9KZWhCclMzTmZNaEh5cGtIZWJ5WXg2RDJJ?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4479601C7A2DD418551A1191324F6C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d11975-b5c8-41f3-5fef-08ddfc73d44a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 20:40:56.9439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8U6Gj8RuXblOJHXOaiQO8eo2q3ELFJPuvI0WbYKLVn0Dl0nD7eM4A1F5l/esBVR7ortfT3hJ7huIisPEAYkqbKkk95YMu+ofhkSzcHru3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6601
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI1LTA5LTIxIGF0IDE0OjIxICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBE
dXJpbmcgdGhlIGRpc2N1c3Npb24gb2YgdGhlIGNsb25lMygpIHN1cHBvcnQgZm9yIHNoYWRvdyBz
dGFja3MgY29uY2VybnMNCj4gd2VyZSByYWlzZWQgZnJvbSB0aGUgZ2xpYmMgc2lkZSB0aGF0IHNp
bmNlIGl0IGlzIG5vdCBwb3NzaWJsZSB0byByZXVzZQ0KPiB0aGUgYWxsb2NhdGVkIHNoYWRvdyBz
dGFja1sxXS4gVGhpcyBtZWFucyB0aGF0IHRoZSBiZW5lZml0IG9mIGJlaW5nIGFibGUNCj4gdG8g
bWFuYWdlIGFsbG9jYXRpb25zIGlzIGdyZWF0bHkgcmVkdWNlZCwgZm9yIGV4YW1wbGUgaXQgaXMg
bm90IHBvc3NpYmxlDQo+IHRvIGludGVncmF0ZSB0aGUgc2hhZG93IHN0YWNrcyBpbnRvIHRoZSBn
bGliYyB0aHJlYWQgc3RhY2sgY2FjaGUuIFRoZQ0KPiBzdGFjayBjYW4gYmUgaW5zcGVjdGVkIGJ1
dCBvdGhlcndpc2UgaXQgd291bGQgaGF2ZSB0byBiZSB1bm1hcHBlZCBhbmQNCj4gcmVtYXBwZWQg
YmVmb3JlIGl0IGNvdWxkIGJlIHVzZWQgYWdhaW4sIGl0J3Mgbm90IGNsZWFyIHRoYXQgdGhpcyBp
cw0KPiBiZXR0ZXIgdGhhbiBtYW5hZ2luZyB0aGluZ3MgaW4gdGhlIGtlcm5lbC4NCj4gDQo+IElu
IHRoYXQgZGlzY3Vzc2lvbiBJIHN1Z2dlc3RlZCB0aGF0IHdlIGNvdWxkIGVuYWJsZSByZXVzZSBi
eSB3cml0aW5nIGENCj4gdG9rZW4gdG8gdGhlIHNoYWRvdyBzdGFjayBvZiBleGl0aW5nIHRocmVh
ZHMsIG1pcnJvcmluZyBob3cgdGhlDQo+IHVzZXJzcGFjZSBzdGFjayBwaXZvdCBpbnN0cnVjdGlv
bnMgd3JpdGUgYSB0b2tlbiB0byB0aGUgb3V0Z29pbmcgc3RhY2suDQo+IEFzIG1lbnRpb25lZCBi
eSBGbG9yaWFuWzJdIGdsaWJjIGFscmVhZHkgdW53aW5kcyB0aGUgc3RhY2sgYW5kIGV4aXRzIHRo
ZQ0KPiB0aHJlYWQgZnJvbSB0aGUgc3RhcnQgcm91dGluZSB3aGljaCB3b3VsZCBpbnRlZ3JhdGUg
bmljZWx5IHdpdGggdGhpcywNCj4gdGhlIHNoYWRvdyBzdGFjayBwb2ludGVyIHdpbGwgYmUgYXQg
dGhlIHNhbWUgcGxhY2UgYXMgaXQgd2FzIHdoZW4gdGhlDQo+IHRocmVhZCBzdGFydGVkLg0KPiAN
Cj4gVGhpcyB3b3VsZCBub3Qgd3JpdGUgYSB0b2tlbiBpZiB0aGUgdGhyZWFkIGRvZXNuJ3QgZXhp
dCBjbGVhbmx5LCB0aGF0DQo+IHNlZW1zIHZpYWJsZSB0byBtZSAtIHVzZXJzIHNob3VsZCBwcm9i
YWJseSBoYW5kbGUgdGhpcyBieSBkb3VibGUNCj4gY2hlY2tpbmcgdGhhdCBhIHRva2VuIGlzIHBy
ZXNlbnQgYWZ0ZXIgd2FpdGluZyBmb3IgdGhlIHRocmVhZC4NCj4gDQo+IFRoaXMgaXMgdGFnZ2Vk
IGFzIGEgUkZDIHNpbmNlIEkgcHV0IGl0IHRvZ2V0aGVyIGZhaXJseSBxdWlja2x5IHRvDQo+IGRl
bW9uc3RyYXRlIHRoZSBwcm9wb3NhbCBhbmQgdGhlIHN1Z2dlc3Rpb24gaGFzbid0IGhhZCBtdWNo
IHJlc3BvbnNlDQo+IGVpdGhlciB3YXkgZnJvbSB0aGUgZ2xpYmMgZGV2ZWxvcGVycy7CoCBBdCB0
aGUgdmVyeSBsZWFzdCB3ZSBkb24ndA0KPiBjdXJyZW50bHkgaGFuZGxlIHNjaGVkdWxpbmcgZHVy
aW5nIGV4aXQoKSwgb3IgZGlzdGluZ3Vpc2ggd2h5IHRoZSB0aHJlYWQNCj4gaXMgZXhpdGluZy7C
oCBJJ3ZlIGFsc28gbm90IGRvbmUgYW55dGhpbmcgYWJvdXQgeDg2Lg0KDQpTZWN1cml0eS13aXNl
LCBpdCBzZWVtcyByZWFzb25hYmxlIHRoYXQgaWYgeW91IGFyZSBsZWF2aW5nIGEgc2hhZG93IHN0
YWNrLCB0aGF0DQp5b3UgY291bGQgbGVhdmUgYSB0b2tlbiBiZWhpbmQuIEJ1dCBmb3IgdGhlIHVz
ZXJzcGFjZSBzY2hlbWUgdG8gYmFjayB1cCB0aGUgU1NQDQpieSBkb2luZyBhIGxvbmdqbXAoKSBv
ciBzaW1pbGFyIEkgaGF2ZSBzb21lIGRvdWJ0cy4gSUlSQyB0aGVyZSB3ZXJlIHNvbWUgY3Jvc3MN
CnN0YWNrIGVkZ2UgY2FzZXMgdGhhdCB3ZSBuZXZlciBmaWd1cmVkIG91dCBob3cgdG8gaGFuZGxl
Lg0KDQpBcyBmYXIgYXMgcmUtdXNpbmcgYWxsb2NhdGVkIHNoYWRvdyBzdGFja3MsIHRoZXJlIGlz
IGFsd2F5cyB0aGUgb3B0aW9uIHRvIGVuYWJsZQ0KV1JTUyAob3Igc2ltaWxhcikgdG8gd3JpdGUg
dGhlIHNoYWRvdyBzdGFjayBhcyB3ZWxsIGFzIGxvbmdqbXAgYXQgd2lsbC4NCg0KSSB0aGluayB3
ZSBzaG91bGQgc2VlIGEgZnVsbGVyIHNvbHV0aW9uIGZyb20gdGhlIGdsaWJjIHNpZGUgYmVmb3Jl
IGFkZGluZyBuZXcNCmtlcm5lbCBmZWF0dXJlcyBsaWtlIHRoaXMuIChhcG9sb2dpZXMgaWYgSSBt
aXNzZWQgaXQpLiBJIHdvbmRlciBpZiB3ZSBhcmUNCmJ1aWxkaW5nIHNvbWV0aGluZyB0aGF0IHdp
bGwgaGF2ZSBhbiBleHRyZW1lbHkgY29tcGxpY2F0ZWQgc2V0IG9mIHJ1bGVzIGZvciB3aGF0DQp0
eXBlcyBvZiBzdGFjayBvcGVyYXRpb25zIHNob3VsZCBiZSBleHBlY3RlZCB0byB3b3JrLg0KDQpT
b3J0IG9mIHJlbGF0ZWQsIEkgdGhpbmsgd2UgbWlnaHQgdGhpbmsgYWJvdXQgbXNlYWxpbmcgc2hh
ZG93IHN0YWNrcywgd2hpY2ggd2lsbA0KaGF2ZSB0cm91YmxlIHdpdGggYSBsb3Qgb2YgdGhlc2Ug
dXNlciBtYW5hZ2VkIHNoYWRvdyBzdGFjayBzY2hlbWVzLiBUaGUgcmVhc29uDQppcyB0aGF0IGFz
IGxvbmcgYXMgc2hhZG93IHN0YWNrcyBjYW4gYmUgdW5tYXBwZWQgd2hpbGUgYSB0aHJlYWQgaXMg
b24gdGhlbSAoc2F5DQphIHNsZWVwaW5nIHRocmVhZCksIGEgbmV3IHNoYWRvdyBzdGFjayBjYW4g
YmUgYWxsb2NhdGVkIGluIHRoZSBzYW1lIHBsYWNlIHdpdGggYQ0KdG9rZW4uIFRoZW4gYSBzZWNv
bmQgdGhyZWFkIGNhbiBjb25zdW1lIHRoZSB0b2tlbiBhbmQgcG9zc2libHkgY29ycnVwdCB0aGUN
CnNoYWRvdyBzdGFjayBmb3IgdGhlIG90aGVyIHRocmVhZCB3aXRoIGl0J3Mgb3duIGNhbGxzLiBJ
IGRvbid0IGtub3cgaG93DQpyZWFsaXN0aWMgaXQgaXMgaW4gcHJhY3RpY2UsIGJ1dCBpdCdzIHNv
bWV0aGluZyB0aGF0IGd1YXJkIGdhcHMgY2FuJ3QgdG90YWxseQ0KcHJldmVudC4NCg0KQnV0IGZv
ciBhdXRvbWF0aWMgdGhyZWFkIGNyZWF0ZWQgc2hhZG93IHN0YWNrcywgdGhlcmUgaXMgbm8gbmVl
ZCB0byBhbGxvdw0KdXNlcnNwYWNlIHRvIHVubWFwIGEgc2hhZG93IHN0YWNrLCBzbyB0aGUgYXV0
b21hdGljYWxseSBjcmVhdGVkIHN0YWNrcyBjb3VsZA0Kc2ltcGx5IGJlIG1zZWFsZWQgb24gY3Jl
YXRpb24gYW5kIHVubWFwcGVkIGZyb20gdGhlIGtlcm5lbC4gRm9yIGEgbG90IG9mIGFwcHMNCiht
b3N0PykgdGhpcyB3b3VsZCB3b3JrIHBlcmZlY3RseSBmaW5lLg0KDQpJIHRoaW5rIHdlIGRvbid0
IHdhbnQgMTAwIG1vZGVzIG9mIHNoYWRvdyBzdGFjay4gSWYgd2UgaGF2ZSB0d28sIEknZCB0aGlu
azoNCjEuIE1zZWFsZWQsIHNpbXBsZSBtb3JlIGxvY2tlZCBkb3duIGtlcm5lbCBhbGxvY2F0ZWQg
c2hhZG93IHN0YWNrLiBMaW1pdGVkIG9yDQpub25lIHVzZXIgc3BhY2UgbWFuYWdlZCBzaGFkb3cg
c3RhY2tzLg0KMi4gV1JTUyBlbmFibGVkLCBjbG9uZTMtcHJlZmVycmVkIG1heCBjb21wYXRpYmls
aXR5IHNoYWRvdyBzdGFjay4gTG9uZ2ptcCB2aWENCnRva2VuIHdyaXRlcyBhbmQgZG9uJ3QgZXZl
biBoYXZlIHRvIHRoaW5rIGFib3V0IHRha2luZyBzaWduYWxzIHdoaWxlIHVud2luZGluZw0KYWNy
b3NzIHN0YWNrcywgb3Igd2hhdGV2ZXIgb3RoZXIgZWRnZSBjYXNlLg0KDQpUaGlzIFJGQyBzZWVt
cyB0byBiZSBnb2luZyBkb3duIHRoZSBwYXRoIG9mIGFkZHJlc3Npbmcgb25lIGVkZ2UgY2FzZSBh
dCBhIHRpbWUuDQpBbG9uZSBpdCdzIGZpbmUsIGJ1dCBJJ2QgcmF0aGVyIHB1bnQgdGhlc2UgdHlw
ZXMgb2YgdXNhZ2VzIHRvICgyKSBieSBkZWZhdWx0LiANCg0KVGhvdWdodHM/DQo=


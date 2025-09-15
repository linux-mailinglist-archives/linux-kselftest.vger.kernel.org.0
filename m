Return-Path: <linux-kselftest+bounces-41479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29003B577AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 13:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D8D189DDF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B862ED15C;
	Mon, 15 Sep 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDQ1UX1V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522F1B4F09;
	Mon, 15 Sep 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934585; cv=fail; b=VY1Ob1DupvW+ezAc1xV8IIUttZ0a1yxIDq9SwmwbfKVISKYHMq5sBcp+k7fD0LI8HXtj1yKKVbX+GIVwF/vrtObSLrzmuA0iz0MOy/dVkppF2Pu/lV/FuBA8ri+purEao/+lvZ5aJK/5a2vNAzGWDvSadDiFP5ldi52fBhY6IiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934585; c=relaxed/simple;
	bh=YRXCkSCeV8mOqK++Zl9rQwzH7Zn9RtSdWL5j6dR9vf0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IQ4HC+dATHlR1TMgjRWoFaX8LdGUpxRbKQtkCwjGnf1Y/bHuw1Vh9Upsrf2x45Z9e1jihnxih5w+Y/cuZ9e840rBs5G7Wpa5nmykHG9bzANN4HZXkQs08l5kf/JNKIBCDxbmKj/ivZITyFQCNBoio0f/1AgHBXUAkiYeHHGIwUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDQ1UX1V; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757934584; x=1789470584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=YRXCkSCeV8mOqK++Zl9rQwzH7Zn9RtSdWL5j6dR9vf0=;
  b=kDQ1UX1VMC9yDS389ZpSqDBkcoDPnY2khLP+Wu42japPLA2rpI51xWEJ
   ncIm/XHa6fUA5JW6a4MSjjA6U+CVKkdVtL8oCn+hGEAi+Yg/ruKj+8b4m
   JZCw2m5Loogfo6gqipZKjToWKE8sc1/q5S4LgXHgG4nfg6Yoc51eNsEws
   4bBuEDPiQ5BzdfzzcwqjCC7cOd5HDJT1nxP6be4HIHHs2XUeGRDTIStYs
   CMEJ2T1d2mFctxnZuqn6GkFArijAvCGgxHmVH627bWutl1dRwr7KfvHuD
   Ca9UQF0yEO1bQgs7nQmQJnXowmLpx6iGtRG+ExZy4Lhs3KFhJnDhJa+pX
   A==;
X-CSE-ConnectionGUID: ZIF2tWxNQcCO4OCNwejOWw==
X-CSE-MsgGUID: 8LSGIpqURoiemfXOn2FFrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="64002237"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="64002237"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 04:09:43 -0700
X-CSE-ConnectionGUID: 6tLcd4jjRGWr2BtCFZFZqg==
X-CSE-MsgGUID: /JSueOfBQ0ewcvsWEcNjqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="205376112"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 04:09:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 04:09:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 15 Sep 2025 04:09:42 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 04:09:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEmq4uIDLhz1KVXCkIVlolE7Cfr5zMBIzYLucjy5FryJ/520GONf9U0sE1THDuXLV84LMwtFqvqYax3mH9nG5uuBKNXhA1D5/Ba1xY9kiKw6Jk/mZFojsQoCJ+XFMXeNigaj2L1Ap6sQT6UlIasmj+PgFMjehysgKtu39MwvEbu2qTZOFJ60RUb36OefCh0UqlSTmwS9Qi7sb8bE0s0xqSqw/MTx0Y4ifvUeYXM/NFRbP9BglLSJcS74MxD1tIk1INeZUvZUBuM/IVbvcPZ1re9Bi0/WQMSBignbJgveUCzSWEZEX2lg0qaMFK04Yc7r5XClP5QkgjKC9kdcTtryCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vsChVTYya0/pcLO+zBYFf5pwQuO5flexT+5gEfQwMI=;
 b=hOExMEv+71+OS/Ya4q15cP311sV1V2vkcfqA40FdYV6+SkkBczQ6ADRs0Qr3JIEaRIU4LTcEI3cF0/OiHe9OwCKQL0GUKM40hS3JHjKIuskL9SbNkM3z/hE7gB4R6ru+L4wpbZ7TO7WcmnmVxxYQWtRFO5qaSbepzfvUcNRfW7GDvSe0OgffwnxJSMSpsmKqrYiKH9raJZtd4l/0saHm3YFkzFmRnMs0/2t0llQCBRXfRB8a/nmhFVL344wWDAPV+5AeVDeeV28XN9AASzTsYWN3iJ8YeIHGfWUwM+3oNyfRyCkkxEqHR3+m7rCrq3qb7x1L9nDOm5zw/e4N+UcQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 11:09:40 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%7]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 11:09:40 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "linux@weissschuh.net" <linux@weissschuh.net>
CC: "w@1wt.eu" <w@1wt.eu>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "tiwei.btw@antgroup.com"
	<tiwei.btw@antgroup.com>, "acme@redhat.com" <acme@redhat.com>
Subject: Re: [PATCH 9/9] um: switch ptrace FP register access to nolibc
Thread-Topic: [PATCH 9/9] um: switch ptrace FP register access to nolibc
Thread-Index: AQHcJhF+2qcITPgNM0C5ojPMUHmgS7ST9EqAgAAiB4A=
Date: Mon, 15 Sep 2025 11:09:40 +0000
Message-ID: <8d6ee835fae809aa2703c51b8443878446245cfb.camel@intel.com>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
	 <20250915071115.1429196-10-benjamin@sipsolutions.net>
	 <5502ceaf-0b40-4961-b9ba-0c5e63498778@t-8ch.de>
In-Reply-To: <5502ceaf-0b40-4961-b9ba-0c5e63498778@t-8ch.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|PH7PR11MB7569:EE_
x-ms-office365-filtering-correlation-id: 2e43f79c-7413-47e2-1ea0-08ddf4485dbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VVYzN3JaOTJDbVZVemRabVduRk9iWTUreUkwRGMwVUs0cVIvQ1NabUFYZ2h6?=
 =?utf-8?B?V29aNWpJVllRaFd3UDZKUFptdUpSTk4wQkJ0cnhPMzBUczBxakJIVUJucHlC?=
 =?utf-8?B?MnQzMUdxNXowUS91TktTM20vazJ0RXo3WEhzVXNMTGw3cVQrVUlPa3l4N1Rs?=
 =?utf-8?B?a1V6NFpwbEwxYXMrNG13NHYzMjdmNE9sa2pLeGFRZWhvc01lcHJUN09RTkNX?=
 =?utf-8?B?bGhxMGdIWit1VFpTQzduQ0hHRTZkU0lqQTExUXgyWmU1Qzk4QkRTdktsamZh?=
 =?utf-8?B?K1JXaklkZi9JRFNTb2h3d0hTMkUrRXdiWGcwM1NieGlFQncyUm9wbWh4R21z?=
 =?utf-8?B?UUdOT1dGUW4xN2VRcGtJcDYya1Y0SmZjTkZZa2pWNytlTEdiQnp3YThvWXA0?=
 =?utf-8?B?eVpLL0RPTVBDb1pWMzhSYzFZOUlUUjRXZi90dWRHL05HUjkzOXZBNUVvNHJL?=
 =?utf-8?B?cm1qZWRWYmhjaXV6ZEJzdUErM1poNHpIU25uUzV5RUVoV1czaHNtTkZLcVh6?=
 =?utf-8?B?TGFpVnlMNVprUGFacGh6TERoQ3YySlNqUlVYRmhIM2NhK3Z3RlQvRzhoeWxp?=
 =?utf-8?B?MXl0S1VlQlo3Mkw0bXBZbVFpWWR6N1VsTkd2UTc4dHF0dENXRjVNdzk2UDg5?=
 =?utf-8?B?cWZQdUJlV2dSTW9OS0pjYk5PSVAwTituWS9uUWNieFZLU2JCYXd4TXRmM2lp?=
 =?utf-8?B?a3ErUFJ5SWFyYzUwSm9LTjF2cHVGZnhYUktxbUs1OVMyZUFOaDRtcURuL2hF?=
 =?utf-8?B?VXg4NTArZmFncTk1bWpxeWdaNXJ6cW1wMkFMdkxuZzlBUWdJRW1XYXNVTkxl?=
 =?utf-8?B?V2R5RkVsOXVER3BOTkF6RExlcDM5MjlHdDRFalBNMFAweE0wblN3aXNlSmJa?=
 =?utf-8?B?UEM2WmtjU2hLZm1UYzhlem5lMXdYK1RDY3B6VU5OdG1td1ZDQy9MaXBXWkxO?=
 =?utf-8?B?a0lWTnNBMi9KRWhkM2tlaEpwckI0aDJNL1Jwc0wvZ1h4SE02S3picjlDTDJi?=
 =?utf-8?B?ZkRKeWsya01kc2NYc1pKM3NReE1UNUZ1L0hHODZnNVZjdGp5R1JSQlR4TVZD?=
 =?utf-8?B?Vk1uTW9SY3dMd3JPQVRWMHdjSk8wTTBZTHdOemJxV0pkTkk1VUdNZFdrYll2?=
 =?utf-8?B?U213WDROekRmOG9UV0dPQ3Rocy9VVzkzRU9jVDFqMkxMdG5XdWVZNlh5M0l0?=
 =?utf-8?B?d3pLZUMzMldqWEtTWkV4UDhSYzBmQm9SM2luQnR3cWZaUElmb1ZXZ3ZURlhn?=
 =?utf-8?B?dEhqNmJDeW9sRDNPZ2QrWFRnT3VPNlVWTE9iUWJrQnYyVHBDcEFsWmRyNjFK?=
 =?utf-8?B?TFFFK2tjUnNQYk51TnhqbUczbUJJem9zY0FkME1FRlVHQ3B2ZlJHbFg0aEo2?=
 =?utf-8?B?ZVVQanBrenJBYW1xOCtFMCtIRDhMWUFucm5abVNoTVhYMzZ5QkRGenFwVWtI?=
 =?utf-8?B?dVBKeFRNSXV1ZUZWV2VyVm9pZGpYb0xCNFJhVThqa1llK1F5QjF2UDFhUDhW?=
 =?utf-8?B?WWlQMFNuSlhwSXVYUHo2TXV2RDl1RE1KMWMvSUpRcU1RMHlsK3FTN3NPWUpP?=
 =?utf-8?B?VC84K2taa3dteC8yRjhTTS9MdjV5aWdmM0dQSVlDcWJ4K2RtdUtCeUJYMjds?=
 =?utf-8?B?SkJuUisxczhNeWl2b2lwYTJZVDFGT21CQ1lMdklicmN5Y0J6TEZTVW1oTFE4?=
 =?utf-8?B?UXp5Y2NMWmkwN0VqandHQTVlOUdWUkJJTjFiamQvc2hyZHF3VHBDekR6bHQ4?=
 =?utf-8?B?RSsxWXp5TGxmTXFBUE5ZS2hhRE1PcFFDK1k5alU5RktZaDBUOE9NY0UrTDI0?=
 =?utf-8?B?U2N2QVNlZlNKNHZ5cDFXVnBNaWc2RUhEY2VaZVY3Z3FoNG8zTHg1Zm11VFdM?=
 =?utf-8?B?cFNsc0ZWYVhmbEdVb24wL05JWVRjMG01dHdYemVpMWpHK0pNSFNDUkIvcUt1?=
 =?utf-8?B?L2FFS0VQWFZ1cGVDQjRLdnlZQzBrSnFDWExZSXROY2xNSitqeDNTSkF4OFV1?=
 =?utf-8?B?SWRGSlJIRS9nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkMyVENOdzZIYzNhYkNHZzhmcW5zRGgrRHFCaTFsd0NYZHpiSEh6TVdhbG05?=
 =?utf-8?B?M1lmb0NNdWhVRzNGYjBGTWNqR29aMjk2aEIxV3BJaVhERFRKZHhHb0drZnFO?=
 =?utf-8?B?VHBXZ0toMGV3R1JPVkZ5bmFDejFuSHJnQ1A1OEhxMG1MdCtncEo4S0EzMEV6?=
 =?utf-8?B?b0VRR1d4dld3Wk56TDJzbTc2aVNQcG1wc1YwRGlMUG1Sc1JCUUJJNUh2QjF1?=
 =?utf-8?B?Q1ZGT0t1YTAzL0s4T0JuRnhNR2dWbjZNY3d4UUY3b2xiRnVPVWIzRXd0ZGZX?=
 =?utf-8?B?UHZFcVlwb0M2aHpTRnd2NHBUV0ljL0lIWjlhajgzeklmazRkK1dpamsvalo0?=
 =?utf-8?B?QVFJQ1drRXRiNmg1eS9yTFhjbm5HcTNkdUtDSHNKUGRoS2hKR2FUN0pWSjlo?=
 =?utf-8?B?cTlIVkJmbmo5Y3NHdkl0SEVLL01JNTZrZ05mMVVYRk05c0szLzZQV2d3MUJT?=
 =?utf-8?B?SUM1L0xaaVZIczhkTzNzeGNUZFZ3Z0xXWFcvUGlNVEhKendDc0g3SUp3U3Bj?=
 =?utf-8?B?dy84RlhQMnFPZ1QwOFVKRko3c0pCZkFvSEtGVU5xL09WdzlIZW9NNng5YVhP?=
 =?utf-8?B?ei9kTUVsemRBc1c3empEYTBqYVN0RDJGQUpla0ZRcUxwU2NqMmUvVlZySnlC?=
 =?utf-8?B?QldUVkdNdEpvTzBRK2JEUWRDbGF4WGJqUHY3OGlBbWFheGpackUyR3hIaEx1?=
 =?utf-8?B?bUNraUVWV2ZkankyR0xzbXptVy8xcmRndlNLbFZVTGxSK1NITlpFall5aXJk?=
 =?utf-8?B?TXE0Q084QjBxNDYrdi9sUG9CVS9kZUExVFYzMTFqc1BVa0xOZm0vbzB4U1ZN?=
 =?utf-8?B?V3VBK1RnU2lQckw5MzhHSEdVTzltd2pBQjBIQ3cydEZ2SzE0YVh0c2JSMktB?=
 =?utf-8?B?QzFZdzFKN2hseEg1UHZRekNKYVJQZCs5SDg5M3o1WE9HRWRFU1FvVGFSdS93?=
 =?utf-8?B?eVNYQkRpa0dnNUNmdCtWY1dBYjJtcUZkRzhhc3BOdlZpaTdSQ0VjTjY1U2NQ?=
 =?utf-8?B?ZlRGdnV2WG4rWnhIZ3htWXBqZVE1K3VrTHk3dDNraGFEQjRZY3RlWHVnamJt?=
 =?utf-8?B?bHZqYzY5dENkaklYQXd6djBYOWtXNDdxc0J4UDc0SnFOU0dTLzZFRXFDeGs3?=
 =?utf-8?B?RlEva1VNU0Z0R2QzMVZaTVpaVm1pOGwzcE9JTXBWaG5Fb0xKZ1dINlFWaWV2?=
 =?utf-8?B?c0ZKZFFwREkwbVBlTDFCWGFjSXhRY1ZTaXh2VGJrWTNLUkpWYldlUmhRVVZJ?=
 =?utf-8?B?RjRJSDhQN1czUDRRaEx3THZkUkFBS1ZYRFJNMzVRM0QrM1pZYmdFM1prTUQ2?=
 =?utf-8?B?ZEdwTjVYcjh0ZlhtZ1JCWUZBV3RQVXRLVDkwNG9RZUREL1FiNTJOZHRFVjdF?=
 =?utf-8?B?THIyYk5KMkRMU1pkdnE0VVNyMmZuQ1hXaisyRnFTaFVpRFRlMzJ1ZGpoVGtv?=
 =?utf-8?B?d3RKNTRybm1xSEZFT1Vya1dTTEJ4aE9JQnF5MjJRaHBkVW13M3lRU0N0WVE4?=
 =?utf-8?B?aTRSL0RqWTkzb04yVW1LZDVjY3kzM21ncFpQYVM1Q0ZUdStpVkY4TGVPM0NI?=
 =?utf-8?B?ZkhKcG5GOUhsVmp3RHArWEZlT0kvNE92ZXpDdEFDdEV4RytHWEg4dFBMMDVs?=
 =?utf-8?B?bFMrMkhndnFwNzRUdms5bUNpYmVNdFZIZGVHZGdUTnNaZW9jNmUxQlUvSW5Y?=
 =?utf-8?B?dmRnR1ZtY3NNNmhoV3M0WnpnOHo2cWx3dE92MU9mYzc2Z3ppbnFmWVN6QjZq?=
 =?utf-8?B?aVRVc1RGcG1GMTErcVhBMzBxS1pYK2tjVit3aHZGNVJKWVJXemVoQklmZWcz?=
 =?utf-8?B?emlhMlBxZjA2amlUOFZmdEk3Y3BoN0VIc201M0lMdGlZdjE4ZWlFVkYwWmly?=
 =?utf-8?B?SW8xSFpWNTcrdHhaZnV6em9QODkyTHJBWVR4azd5RnF4NmF4T1RQUUVxTzdn?=
 =?utf-8?B?Mk1vc3NPcnIxemJ0SkNvYXgyUFE3aWNsNjFqb0RNN1JXR0RxNUZ3aUJlNklK?=
 =?utf-8?B?MkNwWGgwOEJScHllOUZ0YStlbytRMVNxVkJWSFdYak1oc3h1RlNDUUxHZmtY?=
 =?utf-8?B?YmJQeDNHbXdxMjNNaUpublZBQlBZVWJoSWpVTGNXM2VyRFhiV1BtcUhXN2dR?=
 =?utf-8?B?MXNRSmtBWDVSRGpLa2FQTURQbHIyUG5Nc3FBZXg2YmVMQ3FVSlJwVWQrbGNi?=
 =?utf-8?B?cW83WkdYMG9KNTZiYkFHWUphRlVaMjBhS1pjM01SMlpnZEx2V0laOUpKUUJS?=
 =?utf-8?B?NS9sQ0h1bDFkcFBTbVowRC8wcHVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23AD166F1B26214C8494E0C6FAE016A2@namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e43f79c-7413-47e2-1ea0-08ddf4485dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 11:09:40.3799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjwmqcDaDSEbc+K49O7Cp9BDU/f3v69W2uwXmP0Pn9nC86c4HnHYG3fGjU8MX7uI9GN3E2lbgHpNs0+8NHdMgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

SGksDQoNCk9uIE1vbiwgMjAyNS0wOS0xNSBhdCAxMTowNyArMDIwMCwgVGhvbWFzIFdlacOfc2No
dWggd3JvdGU6DQo+IE9uIDIwMjUtMDktMTUgMDk6MTE6MTUrMDIwMCwgQmVuamFtaW4gQmVyZyB3
cm90ZToNCj4gPiBGcm9tOiBCZW5qYW1pbiBCZXJnIDxiZW5qYW1pbi5iZXJnQGludGVsLmNvbT4N
Cj4gPiANCj4gPiBUaGUgcmVnaXN0ZXJzLmMgZmlsZSBvbmx5IGNvbnRhaW4gdGhlIHJvdXRpbmVz
IGZvciBmbG9hdGluZyBwb2ludA0KPiA+IHJlZ2lzdGVyIGFjY2VzcyBpbiBwdHJhY2UgbW9kZSBh
bmQgaW5pdGlhbCBzaXplIGRldGVjdGlvbi4gVGhlIGZpbGUgY2FuDQo+ID4gYmUgbW92ZWQgb3Zl
ciB0byBub2xpYmMgYnkgcmVwbGFjaW5nIHRoZSBwdHJhY2UgbGliYyBjYWxsIHdpdGggYSBzaW1w
bGUNCj4gPiB3cmFwcGVyIHRoYXQgZG9lcyBhIGRpcmVjdCBzeXNjYWxsLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IEJlbmphbWluIEJlcmcgPGJlbmphbWluLmJlcmdAaW50ZWwuY29tPg0KPiA+
IC0tLQ0KPiA+IMKgYXJjaC94ODYvdW0vb3MtTGludXgvTWFrZWZpbGXCoMKgwqAgfMKgIDUgKysr
Ky0NCj4gPiDCoGFyY2gveDg2L3VtL29zLUxpbnV4L3JlZ2lzdGVycy5jIHwgMjIgKysrKysrKyst
LS0tLS0tLS0tLS0tLQ0KPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAx
NSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdW0vb3MtTGlu
dXgvTWFrZWZpbGUgYi9hcmNoL3g4Ni91bS9vcy1MaW51eC9NYWtlZmlsZQ0KPiA+IGluZGV4IDc3
YTMwOGFhYTVlYy4uZDM3MzIwNDMwODIyIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L3VtL29z
LUxpbnV4L01ha2VmaWxlDQo+ID4gKysrIGIvYXJjaC94ODYvdW0vb3MtTGludXgvTWFrZWZpbGUN
Cj4gPiBAQCAtMywxMCArMywxMyBAQA0KPiA+IMKgIyBMaWNlbnNlZCB1bmRlciB0aGUgR1BMDQo+
ID4gwqAjDQo+ID4gwqANCj4gPiAtb2JqLXkgPSByZWdpc3RlcnMubyBtY29udGV4dC5vDQo+ID4g
K29iai15ID0gbWNvbnRleHQubw0KPiA+IMKgDQo+ID4gwqBvYmotJChDT05GSUdfWDg2XzMyKSAr
PSB0bHMubw0KPiA+IMKgDQo+ID4gwqBVU0VSX09CSlMgOj0gJChvYmoteSkNCj4gPiDCoA0KPiA+
ICtvYmoteSArPSByZWdpc3RlcnMubw0KPiA+ICtOT0xJQkNfT0JKUyA6PSByZWdpc3RlcnMubw0K
PiA+ICsNCj4gPiDCoGluY2x1ZGUgJChzcmN0cmVlKS9hcmNoL3VtL3NjcmlwdHMvTWFrZWZpbGUu
cnVsZXMNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdW0vb3MtTGludXgvcmVnaXN0ZXJzLmMg
Yi9hcmNoL3g4Ni91bS9vcy1MaW51eC9yZWdpc3RlcnMuYw0KPiA+IGluZGV4IGViMWNkYWRjOGE2
MS4uNTViY2UwZDNmNWQyIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L3VtL29zLUxpbnV4L3Jl
Z2lzdGVycy5jDQo+ID4gKysrIGIvYXJjaC94ODYvdW0vb3MtTGludXgvcmVnaXN0ZXJzLmMNCj4g
PiBAQCAtNiwxOCArNiwyMCBAQA0KPiA+IMKgDQo+ID4gwqAjaW5jbHVkZSA8ZXJybm8uaD4NCj4g
DQo+IEdpdmVuIHRoYXQgeW91IGFyZSBleHBsaWNpdGx5IGRpc2FibGluZyBlcnJubyBzdXBwb3J0
IGZvciBub2xpYmMsIGlzDQo+IHRoaXMgaW5jbHVkZSBuZWNlc3Nhcnk/DQoNCkkgdGhpbmsgaXQg
aXMgdGVjaG5pY2FsbHkgY29ycmVjdCBhcyB3ZSBkbyBuZWVkIEVOT0RFViBhbmQgRU5PTUVNIHRv
IGJlDQpkZWZpbmVkLiBOb3QgdGhhdCB3ZSBhY3R1YWxseSBuZWVkIHRoZSBpbmNsdWRlIGlmIHdl
IHB1bGwgaW4gbm9saWJjLmguDQoNCkNvbnNpZGVyaW5nIHdlIHdvdWxkIG5ldmVyIGJ1aWxkIGFn
YWluc3QgbGliYywgc2hvdWxkIHdlIG1heWJlIGp1c3QgZG8NCmFuIGV4cGxpY2l0IG5vbGliYy5o
IGluY2x1ZGUgYW5kIHJlbHkgb24gaXQgcHVsbGluZyBpbiB0aGUgcmVzdA0KYXV0b21hdGljYWxs
eT8gVGhhdCBzZWVtcyBhIGJpdCB3ZWlyZCB0byBtZSwgYnV0IGFzLWlzIHdlIHdpbGwgbmV2ZXIN
Cm5vdGljZSB3aGVuIHdlIGZvcmdldCBhbiBpbmNsdWRlLg0KDQo+ID4gwqAjaW5jbHVkZSA8c3Rk
bGliLmg+DQo+ID4gLSNpbmNsdWRlIDxzeXMvcHRyYWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9wdHJhY2UuaD4NCj4gPiDCoCNpZmRlZiBfX2kzODZfXw0KPiA+IMKgI2luY2x1ZGUgPHN5cy91
c2VyLmg+DQo+ID4gwqAjZW5kaWYNCj4gPiDCoCNpbmNsdWRlIDxsb25nam1wLmg+DQo+ID4gwqAj
aW5jbHVkZSA8c3lzZGVwL3B0cmFjZV91c2VyLmg+DQo+ID4gLSNpbmNsdWRlIDxzeXMvdWlvLmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC91aW8uaD4NCj4gDQo+IEl0IGxvb2tzIGZhaXJseSB0cml2
aWFsIHRvIGFkZCBzeXMvdWlvLmggdG8gbm9saWJjLg0KPiBPbmx5ICdzdHJ1Y3QgaW92ZWMnIChh
bHJlYWR5IHByb3ZpZGVkIGJ5IHRoZSBVQVBJKSBhbmQgcmVhZHYoKS93cml0ZXYoKQ0KPiBhcmUg
bmVjZXNzYXJ5Lg0KPiANCj4gPiDCoCNpbmNsdWRlIDxhc20vc2lnY29udGV4dC5oPg0KPiA+IMKg
I2luY2x1ZGUgPGxpbnV4L2VsZi5oPg0KPiA+IMKgI2luY2x1ZGUgPHJlZ2lzdGVycy5oPg0KPiA+
IMKgI2luY2x1ZGUgPHN5cy9tbWFuLmg+DQo+ID4gwqANCj4gPiArI2RlZmluZSBteV9wdHJhY2Uo
Li4uKSBteV9zeXNjYWxsNChfX05SX3B0cmFjZSwgX19WQV9BUkdTX18pDQo+IA0KPiBXaHkgbm90
IGFkZCBzeXMvcHRyYWNlLmggdG8gbm9saWJjIGFuZCB0aGVuIHVzZSBzeXNfcHRyYWNlKCk/DQoN
CkhvbmVzdGx5LCBJIGp1c3QgZ290IGEgYml0IGxhenkgYXQgdGhhdCBwb2ludCBhbmQgdGhpcyB3
YXMgYSByZWFzb25hYmxlDQpwcm9vZiB0aGF0IG1peGluZyBub2xpYmMgd2l0aCBsaWJjIHdvcmtz
IGZpbmUuIFlvdSBhcmUgYWJzb2x1dGVseSByaWdodA0KdGhhdCBpdCB3b3VsZCBiZSBiZXR0ZXIg
dG8gYWRkIHRoaXMgdG8gbm9saWJjLg0KDQo+IEluIGdlbmVyYWwgSSdtIG5vdCBhIGZhbiBvZiB0
aGUgbXlfc3lzY2FsbCgpIG5hbWluZyBzY2hlbWUgYW5kIHdvdWxkDQo+IGxpa2UgdG8gY2hhbmdl
IHRoaXMgaW4gbm9saWJjIGl0c2VsZiwgc28gaGF2aW5nIGZld2VyIGV4dGVybmFsIHVzZXJzDQo+
IHdvdWxkIGJlIG5pY2UuDQoNCkhvdyBhYm91dCBhZGRpbmcgYSBzeXNfc3lzY2FsbCBtYWNybz8g
VGhhdCB3b3VsZCBtYXRjaCB0aGUgbmFtaW5nDQpzY2hlbWUgb2YgdGhlIG90aGVyIGZ1bmN0aW9u
cy4gVGhlbiwgb25jZSBhbGwgdXNlcnMgYXJlIHBvcnRlZCwgb25lIGNhbg0Kc2ltcGx5IGNoYW5n
ZSB0aGUgbXlfIHByZWZpeCB0byBfX25vbGliY18uDQoNCkJlbmphbWluDQoNCj4gDQo+ID4gKw0K
PiA+IMKgc3RhdGljIHVuc2lnbmVkIGxvbmcgcHRyYWNlX3JlZ3NldDsNCj4gPiDCoHVuc2lnbmVk
IGxvbmcgaG9zdF9mcF9zaXplOw0KPiANCj4gKC4uLikNCkludGVsIERldXRzY2hsYW5kIEdtYkgN
ClJlZ2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMCwgODU1NzkgTmV1YmliZXJnLCBHZXJt
YW55DQpUZWw6ICs0OSA4OSA5OSA4ODUzLTAsIHd3dy5pbnRlbC5kZQ0KTWFuYWdpbmcgRGlyZWN0
b3JzOiBTZWFuIEZlbm5lbGx5LCBKZWZmcmV5IFNjaG5laWRlcm1hbiwgVGlmZmFueSBEb29uIFNp
bHZhDQpDaGFpcnBlcnNvbiBvZiB0aGUgU3VwZXJ2aXNvcnkgQm9hcmQ6IE5pY29sZSBMYXUNClJl
Z2lzdGVyZWQgT2ZmaWNlOiBNdW5pY2gNCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0
IE11ZW5jaGVuIEhSQiAxODY5MjgK



Return-Path: <linux-kselftest+bounces-40072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310DCB38929
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 20:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF51368231F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C72D73A7;
	Wed, 27 Aug 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qw6k+OJB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B42773FE;
	Wed, 27 Aug 2025 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317529; cv=fail; b=SHKnMTihEdO4kv56+xmXpGVFJH0Us0oiDZq2+wZAN6Rvj9LU+9l79mSvZgrPONn0TVZJW4Hk6kAHwqAhKZdaYF63L0fgnbASeU+NoG5weRMkDEs5PYMAYvz0FgyHRt3dj8q2GaBklt5YWqQwor5HJHfNHb8/kzqhrblgji1WQCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317529; c=relaxed/simple;
	bh=S86XKX/hY2aClUcIAFJGo2tAVmrh0na9ZO3Pxm2K49Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OrXXeA1CsU5evl+xQAmnwyGv4o+mRfHh/ZgSvhYuSIBeOMS74O1ingyIOdyCO00IcZfJHqf1voA+L0tnoUSnwncRf+aVPkLBmVnAbOIKMxk+OY8McYzX+GDLR7gmpQN/+EJNaN1DNCCBpPBdFFCTi69OgfI6NU2hVM9PQilkUH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qw6k+OJB; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756317528; x=1787853528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S86XKX/hY2aClUcIAFJGo2tAVmrh0na9ZO3Pxm2K49Y=;
  b=Qw6k+OJBw1/x4+JixgtoWEbcKO9NloBbi0gG92JtnCBAQHrRXpKMvWqh
   f200xkb5Yzp/iBXIjjwzz8JBaS7sf4QBw1em8DtvgGwbdjMlIhQNaFUxS
   QwXvjViAQaV0UjDoIpr+G31vb5L/qmq7srRSosxzne75Bpwqc62qIDKnm
   T4wI4OzBGUwZRFKsgsa6DMZsl2IAJrVukMJ3O8VIVxO9C0HbSSNcyIuQu
   VNfOcbZeIUGbPaH1ar3VvWtbmUIlgSkbIXdF54DtiYLPCowCk0XY1sPV0
   jBZQ9C8mk5jfK6rz8FwyP7XEBzKMUmhzP8ScG9ecLUFSsmB1s1IMxZ7EY
   w==;
X-CSE-ConnectionGUID: z4qUrwNzRwy2H6hXIriveQ==
X-CSE-MsgGUID: gbdw+1bYRFKfrcRyqOxXCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="62395077"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="62395077"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 10:58:47 -0700
X-CSE-ConnectionGUID: xpHExuNQRfihT/i/YeJYaQ==
X-CSE-MsgGUID: 2VHutHDjS0eGoY3tN1BO5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169154225"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 10:58:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 10:58:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 10:58:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 10:58:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzB8KjWVT1upcs6pDFSTuyZWTuYyif9NZxjkZQhjlyNZK7Xl9eoxib26XulX1SVHmXOzh58flFjkxYMySYmzVdIeTAwY7rcxucZ8Vz6s9MvyLBgSxatakCezoolC0Q9oEzlGLfJyQ6QR4VOWFGBr6pTMUVOH68l/Kt446OkpHGL82ahQyCENA3XXWHvd+3WZIaQwu8Hy0ZCmY/Pknh4E6jKIZCsq9DxhwFmXg+PbRScIgs281OLbdMdgI++Fd6Nb4F0naeej5Ar9e/V1h/kVH82Sia90/AtH4pbrs0PtR8VI8X96pRNiE6MKcS5/f960UWXZ458c01hGHuugBls91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S86XKX/hY2aClUcIAFJGo2tAVmrh0na9ZO3Pxm2K49Y=;
 b=LEF/9ieYyQs6cXqSSINsx2QqcqU33XkGCiVjYaD/JWqkUwaWem56H4Zf451MNBCo/hYnbErUNH5icd0D4EGZCAzz4blaj7jLIuWQ7Jp6TLyUDTrJvHhDPGUhoP8xsWtcLDSEZVet+DOCIkr2l7svZUPkcpuNxH9bidMTXzMd2UmV51cIuCtb9WqvqP1OVkGZSsyclB5nkVMQf6brXJfXuPF1ZvwBVZ4kfqUskloh0UM2mvLhRDrTBP3KZCzIYwlxOYuOmtBAuYcuC1fUbddRcSmg53WZDU93jIIJ0X9sYq3uqQNln45meGOBmuNIJrl9+PQCoku6EaYs9hRkMRmoCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Wed, 27 Aug
 2025 17:58:43 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9052.014; Wed, 27 Aug 2025
 17:58:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "jannh@google.com"
	<jannh@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>, "kees@kernel.org"
	<kees@kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v19 4/8] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH v19 4/8] fork: Add shadow stack support to clone3()
Thread-Index: AQHcESY3yiJFFhjSakuSpgsGdqvyR7R21iYA
Date: Wed, 27 Aug 2025 17:58:43 +0000
Message-ID: <8768a6fbb4023fe1d0b98c83dffcc5d471a454bb.camel@intel.com>
References: <20250819-clone3-shadow-stack-v19-0-bc957075479b@kernel.org>
	 <20250819-clone3-shadow-stack-v19-4-bc957075479b@kernel.org>
In-Reply-To: <20250819-clone3-shadow-stack-v19-4-bc957075479b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB6941:EE_
x-ms-office365-filtering-correlation-id: 316100ac-5bba-4c57-84f3-08dde5935cb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?di9DdXh4NGxkcGpMN0RuVHREWDM1akVKUzZKQlJWUTAxUjFBbWtyZFcvYThK?=
 =?utf-8?B?bUhLL1JERDNyUndUcmU0WHR3aXRxQ3I3YlpQUUNkRXdpNFJaNDcxdElxU25r?=
 =?utf-8?B?czdOK1BYbVpzS0F3eXNlNklRd2xNQU85eXR3blFSK1V1dnBEWjF1NUd3UDVl?=
 =?utf-8?B?TDZSTEVDTlNpQnNnM01HMWV6ejBidXhlR3dlYjVWSnM4bEg0dVd1NzFIcTNW?=
 =?utf-8?B?YWdBVnY2NGlYeUkvb0Jqb1pBVFlsRUNaUDd2UmtBTlRCc04zeDJQNVRDUE1I?=
 =?utf-8?B?QnJvcllyUWFGcjNTM1VlZG9Hd0ptdExZZlpxbHl3MW5jWU00UCtIWEROUWhk?=
 =?utf-8?B?Zm9CMEhKUTB5TUxNdlQ5YWFXNVZYTTNWRSt2V2Rqc0ZFUERXOXdQMmdNcTdV?=
 =?utf-8?B?TWVlblJHbWdVOU5jZW9rSFNLNjdTbU9rNU9saG9saUltdlhkNmpsVnppWmNV?=
 =?utf-8?B?aERSUDZDQ0RQY3gvN0dBMTRLcDRMTzl2WnlMeDlXeUw3THU3bG82K3NaZFJE?=
 =?utf-8?B?SmRxWDMvdFRwWGdFaWFxQ0E3em5aaUtBSmJIUHVLMnpaSWlQdzhiaVIrSmVO?=
 =?utf-8?B?b253OWZFWjA3dXk5MDFtbkV4aVlCU0MzWG15eXdsNUYveWRuQ0d6UGhKY3A0?=
 =?utf-8?B?M2x2NDVUMHlWSzVqbXZ2SmYwMm11eHNEdHJrVEQ0ZmZpWlZSZ0FWdzJLUnVp?=
 =?utf-8?B?WEZWbUxDWjhpeGVDWjI0WHBDR0JFQ1JMb3FYSWY2UWJMT3NBUHNHZ3VSUmpr?=
 =?utf-8?B?T3lsNW9GSHorUHVuLzNsNVE4S1J4VXU5ZDN4U1NvakJOYVo1LzhWMXRYenUr?=
 =?utf-8?B?OXovTTVVL3BPdXF6cU1PYW8vWFY0YlpTaktvM2U4SWNxcHZaTWVjd0tRbXFU?=
 =?utf-8?B?SjFSY3hlei8ra0lLRnVYRVU3VWw2K3dtbFNodTNycENURndwOFhobmFySU82?=
 =?utf-8?B?MEhzTE1uT3djcDk1Y3RjNDYyenZlVHREM3JMRnVhcER0VklJaVNQQUVDTks1?=
 =?utf-8?B?RTZlZW4vWHNnTEVkNGU5eGtzcEQ5cVRwMi9sajF2T3haOWd5RjFoejJOdk51?=
 =?utf-8?B?d29MQXcvQ3NHMG9NSEtLMEd2MzdMcGFTcjNQZ3NzTU1QeFVzTlFCUWhwUk9q?=
 =?utf-8?B?ZlFvR1hVQkcvVDdSMU9RRWVUNnhXd1dWcE0yRXNaMU0rYVlVS0RqdzllNERQ?=
 =?utf-8?B?SkFRbkk4d0JmK0xxRmRjTnpuWkhVYWZYSG5uVGFBK25YY2ZtK2R1M3dldnhO?=
 =?utf-8?B?K2VUUWFIanBzT0t2RWkvUURsbHRlTVFXNjJqcm1QT0lWd2NSZUt4TDZUSTNt?=
 =?utf-8?B?eHhGdEZNaERGSXZHMDBKalQ1VXdKdXBQN3VlTlRMSGZDdmQwSkNSb2N2Misv?=
 =?utf-8?B?SGgvQklMdFBTR3hBTk80VHBXMTVlVEdlclRMOVpZM0FIRCs4MnYwLzVzTnVZ?=
 =?utf-8?B?OXdIV3MweVVMSEYzZ1RSN1BCenVJaHByUVJ5RTF3Z3Z3bDI0amxrSi9FRFR6?=
 =?utf-8?B?djVLcGR5WGJ2cVoyZ0ZGUzc4VXR4OC9aRHFYZFFhc2RDcUpBOFNocWduRXVH?=
 =?utf-8?B?eWdyRFlicFc3NElIN1lwTTRkTWtkZU80amxXenNQaFhpYWFiZ1prem9wb0Q0?=
 =?utf-8?B?M1dZdW0rOHhwSXVKM0QvV20yc2ZueHpldDVJUE1jUGRUMUt5RlphZk1sTkcv?=
 =?utf-8?B?YnJGTHVVc0N5cnNGclRUaitwK1lEM2tZMmRXRFhDa1hIdGxuc3FJd1N1N0kv?=
 =?utf-8?B?MTlDVXR0UmMySWwxQ25XQ08vM2o5SG5SRHFvMVNzNm1ld1VIc25IQ3hvMUMz?=
 =?utf-8?B?Y211V2FZWUtrYWxrbHJTd3gzYXhKMXNUVmtPbktoOSt3aGFiUmViVXI2SVNL?=
 =?utf-8?B?R0tIblBpMjFWZUJwL051bSt1OFdmS2RCWVRxM3V4eGEwNjZQc0paNk9kY212?=
 =?utf-8?B?MjFCR3BsQTFVK1hJS2tLcTNrdnF6MVhEWWhPRER3d1hwUnA5cTJCK0REd1JJ?=
 =?utf-8?Q?SAzufqfVK294YrYFsGm/VzymwvJ5Tg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?em9nNE1YaDdPU0R0RVpFcmZaYm8yTVd3T0hNcytmS2F6VThIV0x0aHlWUVBM?=
 =?utf-8?B?Q2ZQaU50RjBnTzFpODZrVzFUck52cTQ0Znd5VEhYVWZta1ZBTnJrTXRQM0xZ?=
 =?utf-8?B?OGhYcEVyWkNQNExOVTZGQmJBQ2g0UHdyenFNTE0zWnRMMUhVUDhtOUFHckpL?=
 =?utf-8?B?RHVYVG9YTlRYTlYwNEYxa0NKRzhnRkYxdEdMQXZtVEc1WGpIUW0yWW5wMW8x?=
 =?utf-8?B?MDFmZUZWeFpLanJzNU1KZlJCOVZYTmoycUMrOTVFdzNCWlcwNzRwMjRPbHhM?=
 =?utf-8?B?b1RsVlM2Q0lERitTNGNPb2hrSDlFZ3ZUYXYyS3luNlVRR1RLcEtlRnZ6WEY1?=
 =?utf-8?B?LzNuOWQ1dWc1MmJ1a3BKTllTcGlZZUhZQndQczVCU3I5dVdzcjh6dFFHM08w?=
 =?utf-8?B?blNYZk9IQkRJV0E2NTdaTGtmaFpzRjBUYzF6RWdlTWtCTFgycVdhTHorc3RE?=
 =?utf-8?B?NVkrOVIzYVJGQmJXZ0h5MCtNQ01WYzJ6bGZ6aE96Wkp5QS9wUGlEWDRMRWVK?=
 =?utf-8?B?cnEwaHZtRjBRTGx1UEJsS2tMTWt4bWdCa0F5eGovT1E5WUY1TkNuQ3hIZjFK?=
 =?utf-8?B?Z21LTE9ENVdkVzRFL2ZveXFkSTVZOGlyWlNoYUd1bmtqdHJndVZLTW5UTndy?=
 =?utf-8?B?OE13OERERU9YVzByZXh6NW1YaW9uWGRBN204T0JNZFRTR0k1TTRDMVZFb1pS?=
 =?utf-8?B?VHhDVVY3VHloR2RYS2Q5SlE0MlZuZEFMVUFWWjd3d1ZwNEg1L0VDQmUzdkdv?=
 =?utf-8?B?TmI0Z1hQdnRqbCtqcE8yMFB4KzQzSm0rZlJaUjRBQS9adTdrQmxlOURoVTRM?=
 =?utf-8?B?T1NTQTFOUGdveFZrLzdTeStTS0p3c3ZsRkJ6aDlWTVplY0NaTWdUYXk0V0NQ?=
 =?utf-8?B?aG9VdEFRazdjckpkWFIxKzB3QXlDb2hhSzBuZXNhR0Q0Yi9pSTFRMVJYOHgw?=
 =?utf-8?B?eTRaK3VaVzdVdExqNDJaYlhuTU9sYzJYOVM2b2NYbDJ5UDZEV1dCM0wySUVJ?=
 =?utf-8?B?ZUhaZzFQR2FTZWJ5S3FQU3JFQlpwZDJmem03TUZMeVpmckxsV1JtQXBPRnlr?=
 =?utf-8?B?MmZ1UldZNTZiSXlyNzFpUkYwZkNjTlduYktnTzA5eEt4V3U3T0hxbXcrNHdT?=
 =?utf-8?B?VDNHeDJiTWpkMG5CdlNER1F2SzNucW5hbUVZVERHZ05UcVdyYlh1VFdka1Y2?=
 =?utf-8?B?N2hFTHZ2bmd2NHVsTHBoS05KMmNWTStFb1cwdEdDRFJHVlZKWmtvSjYybEdz?=
 =?utf-8?B?NytiSktYbEJuVzFrSVhCcEsxRnJwUVVuRHE1SDFJRU1wS2JaUmt1TzkxamVH?=
 =?utf-8?B?M0tvNXRyeTJYWFd3REZVZGIwai9yTi9Zcm5SMmhiRFpNUk1Zc2pnU0phc29B?=
 =?utf-8?B?TU4ycXhrcU9LQkZ2NXBXUmVtNFRTRnVadTg5L2EyVG1Bay9SSUZVdkJ2RWpy?=
 =?utf-8?B?S1NaTzhmTm10by9IWlJhaWRzdUdEc0J0V0Z2VWZsbFRNOHdqcTV0NXc3bVdS?=
 =?utf-8?B?bERXMktvc05HcWd4aWRrdjFUV2s1OWt2dzJ4ZW5JRkVwcHZHbFBqcEhkeXNE?=
 =?utf-8?B?WTlwYXA1dEp1dmhzWXJEZVU0ZFE2WVI5RmEyN2V1UkhXR3dTNGxBNDdocFd4?=
 =?utf-8?B?OUpGVFlaMDVtblE5d1I1V252bnBLc3hxRkc0cllJZkVURDQraWJ6N2RzM2Er?=
 =?utf-8?B?QVpkYmIxMXlRTEFtRjRqbE43TmI0RnNYT0xZcTBTOXpWWFkwZHdENUJNTVVZ?=
 =?utf-8?B?aTVDYUNoZXBGd0N2OFJnN01yeVI5MHBVMnptZ3A5aURvaUh4SE1PQzR3Z3pK?=
 =?utf-8?B?dkJjcmtFUXQ3eFluK3E4WDk3QXZZWXNBYUFjRm11RUF1ZkxlaDhTSW1Sc01V?=
 =?utf-8?B?bmZDM1JWdW42aDREeG5ESEdKa2lvM2JTTnJsaEpsT3lyZVdRc1hJUzdNS3lu?=
 =?utf-8?B?Y3lUc00vNGVBTFAzNkIwdXQrOE16bDdkbTNhRmNzMmF4SUNERUp6RU5SOWYw?=
 =?utf-8?B?M3RpR2RDYWtrSDZsZHllRXF0MExGSmZHUTlxZ2tMWG5INXdvOThObnF5ajF1?=
 =?utf-8?B?WE9TMzNpZGZuT1ZnU0ZlT3J4NzczZVlkYjFQRGphamRCejUra0FKL3BQb05E?=
 =?utf-8?B?MDlSNlhqdWxnbTkvTUlWTFc1SjFCdjRYNjVxRFZEOHZoN3FFMGlCVUdkSFd5?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE7B3B488719714B831FCF9E23649B32@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316100ac-5bba-4c57-84f3-08dde5935cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 17:58:43.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0DM6blU6fcYgc/8N+yCkQ1AGwJaUBQyfXZG8SG7LQam4465m37cvEbnF3+c5c0RtdV0NJRuJTYMBxB9SJT4Xhq0cGyX8U2Q4OoxUPd1BC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA4LTE5IGF0IDE3OjIxICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiAr
aW50IGFyY2hfc2hzdGtfdmFsaWRhdGVfY2xvbmUoc3RydWN0IHRhc2tfc3RydWN0ICp0LA0KPiAr
CQkJwqDCoMKgwqDCoCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gKwkJCcKgwqDCoMKg
wqAgc3RydWN0IHBhZ2UgKnBhZ2UsDQo+ICsJCQnCoMKgwqDCoMKgIHN0cnVjdCBrZXJuZWxfY2xv
bmVfYXJncyAqYXJncykNCj4gK3sNCj4gKwkvKg0KPiArCSAqIFNTUCBpcyBhbGlnbmVkLCBzbyBy
ZXNlcnZlZCBiaXRzIGFuZCBtb2RlIGJpdCBhcmUgYSB6ZXJvLCBqdXN0IG1hcmsNCj4gKwkgKiB0
aGUgdG9rZW4gNjQtYml0Lg0KPiArCSAqLw0KDQpXaGF0IGlzIHRoaXMgY29tbWVudCBkb2luZyBo
ZXJlPyBJdCBkb2Vzbid0IG1ha2Ugc2Vuc2UuIEl0IGxvb2tzIGNvcGllZCBmcm9tDQpjcmVhdGVf
cnN0b3JfdG9rZW4oKT8NCg0KPiArCXZvaWQgKm1hZGRyID0gcGFnZV9hZGRyZXNzKHBhZ2UpOw0K
PiArCXVuc2lnbmVkIGxvbmcgdG9rZW47DQo+ICsJaW50IG9mZnNldDsNCj4gKwl1NjQgZXhwZWN0
ZWQ7DQo+ICsNCj4gKwl0b2tlbiA9IGFyZ3MtPnNoYWRvd19zdGFja190b2tlbjsNCj4gKwlleHBl
Y3RlZCA9ICh0b2tlbiArIFNTX0ZSQU1FX1NJWkUpIHwgQklUKDApOw0KDQpJbnN0ZWFkIG9mIHRo
ZSBhYm92ZSBjb21tZW50LCBJIHRoaW5rIHRoZSBpbXBvcnRhbnQgdGhpbmcgdG8gc2F5IGlzIHRo
YXQgYXJncy0NCj5zaGFkb3dfc3RhY2tfdG9rZW4gaXMgOCBieXRlIGFsaWduZWQsIHNvIG9mZnNl
dCBjYW4ndCBvdmVyZmxvdyBvdXQgb2YgdGhlIHBhZ2UuDQoNCk1heWJlPw0KDQovKiBrZXJuZWxf
Y2xvbmVfYXJncyB2ZXJpZmljYXRpb24gYXNzdXJlcyB0b2tlbiBhZGRyZXNzIGlzIDggYnl0ZSBh
bGlnbmVkICovDQoNCj4gKwlvZmZzZXQgPSBvZmZzZXRfaW5fcGFnZSh0b2tlbik7DQo+ICsNCj4g
KwlpZiAoIWNtcHhjaGdfdG9fdXNlcl9wYWdlKHZtYSwgcGFnZSwgdG9rZW4sICh1bnNpZ25lZCBs
b25nICopKG1hZGRyICsgb2Zmc2V0KSwNCj4gKwkJCQnCoCBleHBlY3RlZCwgMCkpDQo+ICsJCXJl
dHVybiAtRUlOVkFMOw0KPiArCXNldF9wYWdlX2RpcnR5X2xvY2socGFnZSk7DQo+ICsNCj4gKwly
ZXR1cm4gMDsNCj4gK30NCj4gKw0KDQpXaXRoIHRob3NlIGNoYW5nZXMsIGZvciB0aGUgc2VyaWVz
Og0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwu
Y29tPg0K


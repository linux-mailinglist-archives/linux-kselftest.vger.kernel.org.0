Return-Path: <linux-kselftest+bounces-38690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED516B213DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76D41906DAC
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835462D6E67;
	Mon, 11 Aug 2025 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeRyoPUF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FE202C3A;
	Mon, 11 Aug 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935921; cv=fail; b=sgPIUJOGIJVWWMURqdbwLKbQ3yC2MmuqxOhvtxzjp6B1KMo0KnKK+SbTTSP7vLVSkd8waFeDl4C/L5i0GSXlyScnSBBlqbxXFwX7mZS0sWUzHOpt08hWGkxf94TBMVU6OBQkz5w48TvtZz+rf5KpYNWG31iwSzdCd+HqOaGTvjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935921; c=relaxed/simple;
	bh=YtRkPl5HIt2sBn6qOn6TCvNnhvtNjEZio8r2+svlFhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l41AqrJW3+GkbPx+G5MNZEKZ9xeKYJC9tTDCFiu+VTgSUPBYTutDRbPjdogMesHaCUYWSFCl4HtbVjbH92Ddqtmeadse94V9zDRYDan6S1tJZDW/167YJZUXi1i0xpMxVhDJwUbvMNknhB75TqDXm0Fu4uXoPJ4hwqWwQ+MH5QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeRyoPUF; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754935920; x=1786471920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YtRkPl5HIt2sBn6qOn6TCvNnhvtNjEZio8r2+svlFhw=;
  b=IeRyoPUF0pIdQc09WpD5AHjnsyhC8CKl0DfYwcNhQQLLkLVOuCkP6PJF
   igc7oVOiYSD6jO33wHSU8xEPvMeSKJE+wv1aRUGqHBnAOARDT4NVz8Hjf
   Z7fUyTcgAMDMEUekWG3HGJo2HjT/EfAwbYdRlAvkPYvKHUXFTeqdVxUiX
   m94LM+xtNi5R33tsZ8AXmmsCUGM726LDfTsegyXqmI8rPenGhNyQv0E6n
   HdioJhMkOKXvAgArHKNdF98gfQODCbpDq9fGbArCdlcVAgaPmUl2gPhNj
   IFMAPr/jctNuZCVQKX8wyfLEPFHqKfaqDSejaFtrAxKTVxrQ7qBxYViYI
   w==;
X-CSE-ConnectionGUID: dzVKBhcQROexl2+D33uW8g==
X-CSE-MsgGUID: KEdWGCbMR2q4hrrtCMyMcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67798329"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="67798329"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:11:59 -0700
X-CSE-ConnectionGUID: 3tbwGKC6RKOZD0C5U7Rlfw==
X-CSE-MsgGUID: y8L6YN6VSMKdOmqdoye//w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166334448"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:11:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 11:11:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 11:11:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 11:11:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgUbpKPPvIEIPM5BcrtG8bcG1lTTpqpgztWfImIkhv95mIxSIDXJcC3nZu6JCEHpIvJCek2obg0WoinbW+HRsEorqFtYPkAjrLNYzBxSB6nPJA/ojs02fwmpa9KrbzS/OuNftBXph8luUmduOM/VnNR7TvAktWOmYlKPJ559xUzkiKfWqqKSWNuzA5EXskv7ywpgw2EU1wZa/JEItKyn6UKJcHSTR+I1gwXXCoxKkPNnhHMgZjvMOg+57iyApn8i91ZYKlOwI4GtnkFGAQhObht4CPiwc8VMjVHHYmV92wwpJfoj2so9idPYUyKlb9LjstIlwIkrm80y2i4HZ5mFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtRkPl5HIt2sBn6qOn6TCvNnhvtNjEZio8r2+svlFhw=;
 b=VuQSJFiw2pUJD2MEAqUFSILMp4AohBKAke7dyEEjI2s+4kKj4i2AObNiNy2SxFALnsxSi9U+o6kYJvHqx2fGZwIteAvBUgA8j3VI6F4Z4PZTShA3VU+l/qY47SBboP5K05xW7NlKGfZpBK79wjCQAPuk603tdX/rBCwvYTn0KxXSm2VBAFxxAkwyZr8B7UAwP0KiDM1ldmxFFdc+uk0iDhcnIn+uSUGZi0VI/Ha8bZQkz4FsjPA327A2J0+VlNmRqRFeEM9H9HbHoW7QwFTM8Sy9KORKJAa7hvYehrDzdawgrXFTglcTHBsIMEEleeDcBZNyBfHvLXzc0WSmm7xqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by BL1PR11MB6027.namprd11.prod.outlook.com (2603:10b6:208:392::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 18:11:55 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 18:11:55 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sagis@google.com" <sagis@google.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Aktas, Erdem" <erdemaktas@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, "Afranji, Ryan"
	<afranji@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "pratikrajesh.sampat@amd.com"
	<pratikrajesh.sampat@amd.com>, "Weiny, Ira" <ira.weiny@intel.com>, "Wang,
 Roger" <runanwang@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>
Subject: Re: [PATCH v8 00/30] TDX KVM selftests
Thread-Topic: [PATCH v8 00/30] TDX KVM selftests
Thread-Index: AQHcB9g45dcdcEjSfEm8IM8d0alUb7RdveaAgAAJPwA=
Date: Mon, 11 Aug 2025 18:11:55 +0000
Message-ID: <0976e0d50b1620c0118b8a5020b90f3959d47b4a.camel@intel.com>
References: <20250807201628.1185915-1-sagis@google.com>
	 <aJoqqTM9zdcSx1Fi@google.com>
In-Reply-To: <aJoqqTM9zdcSx1Fi@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|BL1PR11MB6027:EE_
x-ms-office365-filtering-correlation-id: 208b80b9-9d86-4900-7992-08ddd9028e00
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MkgvdnlJbXJQYmFYS0lmWWxwZGxQdVlpbU13ODVJa1MzMlMxcXRFV244Tk9G?=
 =?utf-8?B?WTZNTGwwWUwrL3JJejVydzJSRzlVQVF0Ujg1aklHb0J3MTJuQ3ZIalNmb201?=
 =?utf-8?B?UWZiWnZVaGVMTHZzVEQ2N0xoNU43ek1LUjlYT1R5bHdGOXVRcGk2eTY0dlNi?=
 =?utf-8?B?QVVQcCthQVRYa3VHQmh6dDg5dGFIWFN6Z1VmUW9EV3dVd0QvYXRZbmloVk9J?=
 =?utf-8?B?ZWlhbmNjU0lwSHQ4SEJ3TEtaaHUySG9MREVZdmpHcitWcmRmNGpsNm1tZ2kw?=
 =?utf-8?B?cFkrZXRKVnRJMHV5ejF1YkhPbXdaKzRFak9LQVdBRTRhaVVUVnIvSVdrZjha?=
 =?utf-8?B?YWdzM0JzNG1NM3NlWnVPanhXWHdkdmhMRjJZOUNVZ3pIL0p2bElYNE5MSllv?=
 =?utf-8?B?bTRzRXAweWYvWU92ZW5NU3h3V1QvOVhoRW5VaTFIUldjaEZ6M1ZYdmQzSlpo?=
 =?utf-8?B?SUdNR1k0NU9FMU5HNkhobkkrRC9yV1FYLzAwY3d2N3pvQTA3cXlpdEpYMWZG?=
 =?utf-8?B?VmlxTVIwQ1cxRndEOTN0RytoMmgweDZiVmJjMmFmV2g2WngySGV0Z0N1ZWZl?=
 =?utf-8?B?dUU1MStzaU1KVWRiYTV2L0xSUzRWZEVTMXJrRFQxdUZkSDZTbzhPak56SUlh?=
 =?utf-8?B?WUJNUXE0emRMUnBXZHZCWnBhcmRrK3dTSnZoTU95SVlCVk9takxEOGMyZldn?=
 =?utf-8?B?MVllS2VtUmc0MWt4bFdZRTFiakd6bGVtNHBQNzdwRUdLQ1JxK2lveXpPSFRX?=
 =?utf-8?B?eXFXWHpkbUoyTW1vV0Y5Rm8wSEZJNHBrNDdsN2pXellBSCtjUXd4MlFEdUdj?=
 =?utf-8?B?bGRDODVGNXg1bDFleHNlOUYwZmFrcVY4U3Z6TUhyQjkraGo2amZoSXdvOU5v?=
 =?utf-8?B?LzVLQjJ2bXgwMDFXbU5wVE1kK0V6bXBINDNQMGkrQ3Z4cklRcVBhWmd1ZVg4?=
 =?utf-8?B?eGg2Q3c1R3Q2SGNXWmh4WktCby9QcGF1UG0rSXNva2VKQnluNWsrdU1UT1la?=
 =?utf-8?B?YUh3c1RPMFBadytldXlNdUdCNmxmN3N2eGlGOGY4M2xoVkNsdzlIWVdoWUtR?=
 =?utf-8?B?VUxOZFduYXB2UUZ5UVdaU0ZxMzI3QUl1bHhUNFVMZUlPWHZGcWg5NVkvS0tR?=
 =?utf-8?B?QXNCU1dudXZmUFpzSXVxdHg2SFJ3SHJZV01KRGZGdVpXTEZIeDNRaElobk5B?=
 =?utf-8?B?SWljd1QxMGkwTE05aVFaVlBxRm0vWVJPQWQwbCtkVE1wTnJsTzlRVkhDNXAz?=
 =?utf-8?B?WTZIS3BzTDNRSFJYQk5pTnBHeDV5RlQ1NnJuRmxrMkt3eWFSa2wvb25YYngw?=
 =?utf-8?B?RUtJd3JtNGl6aHl0Wk5obUwvVVVHcFU4ajFndnhxSTlzK0o4UXBJV0k3VkhR?=
 =?utf-8?B?K1o1ajJuY3c5bG05bitra3VtekV6ZFF4NlRGYmZLT2YxdkF5Skswdzh3eHdw?=
 =?utf-8?B?d0huNDk2cFBMNXUwMzRMQW9hYlJ4L1l5S1FmRVdnM3RnQmpKMlhoYmRnZkpF?=
 =?utf-8?B?R2M2MGt5TGZFbDRHYVJZV3NwSmRuZDI4QzA5VHRYR1lMUEZiaG5uRCswMnh1?=
 =?utf-8?B?dkNpMUc2Wlp6Lys3RTU0Zk0wYWdOWEQ3WTdESnkrdytiYnlIa1NacFV1Nmxs?=
 =?utf-8?B?N1lOTEp1ak44VVFacHczMkdkalFrOFNRZ09QQUdsa0xxdDJlS0xERG93ZURl?=
 =?utf-8?B?aVlLb2RabGNIcmZ3ekFLT2t0UG1TR3dXNUcrWUs4YjZ2THA5Y3M2WitRN1N6?=
 =?utf-8?B?NnZuVzlQNE5NV09qZGllYWY1MWtUMWN0MnpmaGxsS3VsSk4xQ0RGL2hwOGlz?=
 =?utf-8?B?WEFiUko2emFxSXVvUEhWR0ttSk81MEJBbXFHbjBWOFBZSExDMXMzeFMwZU5O?=
 =?utf-8?B?NDdBOC9XcStYaE01RHh3bC9XYUN2WFlYOEVDYTQ4d2gzVjA3cHN4c28zTUVF?=
 =?utf-8?B?cGh1VmpITDYzYUQ0N09lb0s0VjVEV2xseGZiSHRDYTVwWlRibHBQZE1leXNX?=
 =?utf-8?B?SklpZnF4SkV3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnE3T0JMbU5LemZDVzl6Q0FYT281SmQ2ZDdja0JoRXprZjRXc1c4QWVBa09a?=
 =?utf-8?B?NlJoOUR4YTZydVoxdkJVNkZLVGpCbXRVN2hoRFdHRHYvTVMxWExOV3VheFB2?=
 =?utf-8?B?bXg4d3VuV056NU9IVU04Q3BzOGJFcWZBazNab0NFZHp6Snl6cSt3dkhXYk1I?=
 =?utf-8?B?UGgwaHdiRkpONytROHd6Rjc5L3hKcnhoZ1BvRmRTUjUwTEVoZURCZUJMSGM4?=
 =?utf-8?B?ckllTDV5cVZsSUwreXpZd0c1anA4MDkxU1dPTlJiOHdoVDV1dUpINkd1VG1q?=
 =?utf-8?B?R280Ti94NUl3QTUzcHJBdFhCWldBS0k1UVJHSStkUzkxdEJWVEp0TWxDQUJX?=
 =?utf-8?B?TWo3SnR1L1JmUmxNVzI3YzF2OXdQRzRWQ1FnL1lRc1AxRXNpQ0d4MTZFaSt6?=
 =?utf-8?B?SndRVzJnRXNDL0l3S1NITDhSZUhrZjhpYXlJNkxoR25jdVNBc1czM2ltOXFi?=
 =?utf-8?B?T3pqZDRKVGU2OHdiT2Q1NG5NYzNGRCtDRlpSR0hma2hNUlpCRExDZTRPczQ4?=
 =?utf-8?B?Z2dhNnlCTGVGd0RjQlJGRitGdi9PMU1qb3VoZ3JmbTRhdU1xMjRjUlRucGUv?=
 =?utf-8?B?dmljdGlJa1dxSWovNjNjbUtROEZDVSt4bVJDSGtjMERWWnBQekY1Q1ovS0Y3?=
 =?utf-8?B?WlA4ckl2SnVXUXBjTFRCNkZVSGN5SkZwa0dBbU9nYnV3YmE5TUdZM2hUODNI?=
 =?utf-8?B?azVXd0wxaVB2dXdaQWpFQzBIUVlOT1ppWEJLU0NFTi9YTm5XYzNSQnVQWDhB?=
 =?utf-8?B?dGlUNWhRS3VSUXZ1RURoQys2eG5XZFljVFkvSWJoZ0FML3lLZWdOa1U3OFpB?=
 =?utf-8?B?RWh5REtxSlRybElmVU1wR1VYRTZ3bS9GQ0dtUVNXRi83Tnd3Y2szbDB2SjEx?=
 =?utf-8?B?QjBZMTN1ZUxPd3lVcWhYby9NSG9sZVBBTlAyQTgyZmdaazdKd3YxT2doZ2hX?=
 =?utf-8?B?NDRjaXBPeHJQUE5iM2wwMXdjeURaeHd6SEFseElDcGc1WjJYbmw3dHZHMUli?=
 =?utf-8?B?RGtOQmY5RTdURjVKUzduUy95eTlBc29xRytIdEpiRlJKT3VaL295bi92aWs0?=
 =?utf-8?B?MWxqOXd0cW83aUJrOTZkWTc3cDFsandLaUJwbkU0cVBCNEtBSDg0T29NQmNu?=
 =?utf-8?B?akhxT3JiaUVxOGFGektITVF2ZjR6OWVjc1FManJucjIyeGFVOHBOWW9UQUVB?=
 =?utf-8?B?akhhcG1iOVk2R1NwdytUaFB3ZEVKT2xiK0dIMFpoeW5Nd0NpY25oNHRMSkZG?=
 =?utf-8?B?T2RvUjZuS3hNYlBQS01uczhZRVpVWm9odFFRN1lXMXgwdGNjbHA1TXd4ZE5t?=
 =?utf-8?B?NmFxOHppMzZqKzFQdExzcnJ3SWlaNjU4RUdLRTJ5Zzg5RDNtYlRqQ2ZXcFVx?=
 =?utf-8?B?NElBam5uTDNzK3k0Z3ZlN01WbzYwQzArMkJPZUg2V2gxcDhOMTA0YkNod2JR?=
 =?utf-8?B?NkNGK29KVWJ3RUxDamRDK0RPK1cvUStMNmhDU2VnTlNNMWQxdllhZXllZEZI?=
 =?utf-8?B?RE9UYjUzK3BSZkdKcGQ3S3BoSFRtVFdkWUJRT3loZCtLbHM5Q1lSenI2TENP?=
 =?utf-8?B?SkZUVytBS0U0cS9LMlNnKzY3blJOM1JJYzdHY2RKTXExTlZ4UVNXWXQ4MEdi?=
 =?utf-8?B?NVFNTDdRZW8rUW1UT0hPZ0g1OG9XTG9rOVNDSm9ybnlxU2tETzJaN0dEM1Y0?=
 =?utf-8?B?eGRmQjJHVVh6QUxGckkwYmhCQWsvZ3QwUE1uQ3JFUDFCV0wrdGpUeHNTVCtN?=
 =?utf-8?B?ZmF6VFhTcFdaTnVJMjBNUW5sVzI3MngwN3dGSTBQcTdDK0xWeTJYZDY2V0JS?=
 =?utf-8?B?TUtRUENHMURkSFhVODQ0TlZXdEY3dVJ4eUJweW5iMFYzMk5aamwwT004TmVZ?=
 =?utf-8?B?cGdhZFpGeVhLb0JRNkI4YVI1MmRkQUUzLzF2YW5DTXR0RThaZ2JpaC8wMEUx?=
 =?utf-8?B?TFBaNEpBZFhpWnB5cUhSS1lWclhxVTFoaHdLcWdPQ3BxQTZMZ0NiOWw1VGNG?=
 =?utf-8?B?SWJkMjR4dGlZK0Ztd0xMWnBiTEorWWhMZ2hNaklKWDBTU0NPa09jSGJQU09w?=
 =?utf-8?B?cU03U0lpMGRXQ3FRalJOQ0g2WUdzalZ2alJhOW9kUTNOb1RUV1c2dUN5TkM1?=
 =?utf-8?B?V3gvbDdnQ3k1cklxeXVPTWc4UFpQZngvdDJMeTIrT2VCMGVjUHdGbnZtRFNX?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A841E6423D473D479611A4D704ED396C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208b80b9-9d86-4900-7992-08ddd9028e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 18:11:55.1630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mhXT5u8PWvnyXQSQmH05r1PkpTms9DVlr00wyy4SuPXSULUgm998IWDuID77VNO4fisMXvgaZSJxhAU2G3sb7kxaQAREGzbMsPeYnimuF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6027
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTA4LTExIGF0IDEwOjM4IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBQbGVhc2UgbWFrZSBjbGVhbmluZyB1cCB0aGlzIG1lc3MgdGhlIGhpZ2hlc3QgcHJp
b3JpdHkgZm9yIFREWCB1cHN0cmVhbWluZy7CoCBJDQo+IGFtIF90aHJpbGxlZF8gKGhvbmVzdGx5
KSBhdCB0aGUgYW1vdW50IHRlc3QgY292ZXJhZ2UgdGhhdCBoYXMgYmVlbiBkZXZlbG9wZWQgZm9y
DQo+IFREWC7CoCBCdXQgSSBhbSBlcXVhbGx5IGFuZ3J5IHRoYXQgc28gbXVjaCBlZmZvcnQgaXMg
YmVpbmcgcHV0IGludG8gbmV3ZmFuZ2xlZA0KPiBURFggZmVhdHVyZXMsIGFuZCB0aGF0IHNvIGxp
dHRsZSBlZmZvcnQgaXMgYmVpbmcgcHV0IGludG8gaGVscGluZyByZXZpZXcgYW5kDQo+IHBvbGlz
aCB0aGlzIHNlcmllcy7CoCBJIHJlZnVzZSB0byBiZWxpZXZlIHRoYXQgSSBhbSB0aGUgb25seSBw
ZXJzb24gdGhhdCBjb3VsZA0KPiBsb29rIGF0IHRoZSBhYm92ZSBjb2RlIGFuZCBjb21lIHRvIHRo
ZSBjb25jbHVzaW9uIHRoYXQgaXQncyBzaW1wbHkgdW5uYWNjZXB0YWJsZS4NCg0KV2Ugd2VyZSB0
YWxraW5nIGFib3V0IHRoaXMgaW50ZXJuYWxseS4gQmVoaW5kIHRoZSBzY2VuZXMgUmVpbmV0dGUg
aGFkIGFjdHVhbGx5DQpzcGVudCBhIHByZXR0eSBsYXJnZSBhbW91bnQgb2YgdGltZSAodGhlIG1h
am9yaXR5PykgY2xlYW5pbmcgdGhpcyBzZXJpZXMgdXANCmFjdHVhbGx5LCB0byBldmVuIHRoaXMg
bGV2ZWwuIFRoaXMgd2FzIHNvbWUgY29kZSBjbGVhbnVwLCBidXQgYWxzbyBmdW5jdGlvbmFsDQpz
dHVmZiBsaWtlIHJvb3Rpbmcgb3V0IGJ1Z3Mgd2hlcmUgdGVzdHMgd291bGQgZ2l2ZSBmYWxzZSBw
b3NpdGl2ZSBwYXNzZXMuIEJ1dA0KdGhlIHBsYW4gb2YgYWN0aW9uIHdhcyB0byBoYXZlIHNvbWUg
b3RoZXIgVERYIGRldmVsb3BlcnMgc3RhcnQgcmV2aWV3aW5nIGl0IG9uDQp0aGUgSW50ZWwgc2lk
ZS4gSSB3YXMgYWxzbyB3b25kZXJpbmcgaG93IG11Y2ggdGltZSBTYWdpIGhhcyB0byBzcGVuZCBv
biBpdCBmb3INCmZvbGxvdyBvbiB2ZXJzaW9ucz8gV2UgbWlnaHQgd2FudCB0byB0aGluayBhYm91
dCBhIG1vcmUgZGlyZWN0IHByb2Nlc3MgZm9yDQpjaGFuZ2VzLT5wb3N0aW5nIGRlcGVuZGluZyBv
biBpZiBTYWdpIGlzIGFibGUgdG8gc3BlbmQgbW9yZSB0aW1lLg0KDQpCdXQgU2VhbiwgaWYgeW91
IHdhbnQgdG8gc2F2ZSBzb21lIHRpbWUgSSB0aGluayB3ZSBjYW4ganVzdCBhY2NlbGVyYXRlIHRo
aXMNCm90aGVyIHJldmlld2luZy4gQXMgZmFyIGFzIG5ldy1mYW5nbGVkIGZlYXR1cmVzLCBoYXZp
bmcgdGhpcyB1cHN0cmVhbSBpcw0KaW1wb3J0YW50IGV2ZW4gZm9yIHRoYXQsIGJlY2F1c2Ugd2Ug
YXJlIGN1cnJlbnRseSBoYXZpbmcgdG8ga2VlcCB0aGVzZSB0ZXN0cw0KcGx1cyBmb2xsb3cgb24g
dGVzdHMgaW4gc3luYyBhY3Jvc3MgdmFyaW91cyBkZXZlbG9wbWVudCBicmFuY2hlcy4gU28geWVh
LCBpdCdzDQp0aW1lIHRvIGdldCB0aGlzIG92ZXIgdGhlIGxpbmUuDQo=


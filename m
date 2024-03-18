Return-Path: <linux-kselftest+bounces-6395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B4887F077
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 20:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440BB1C21C09
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 19:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EF756774;
	Mon, 18 Mar 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnV8jESQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60257892;
	Mon, 18 Mar 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710790474; cv=fail; b=bymmZk7jrtQqh64KKmbUcc1BuO1IiJhMyxjjL5E1zypg2UfH750TDWpXmVKaIN3F4pbyfIYW6UBqv0FLdPiR+nlDTfheSBpePBMhutVZb+dGBrNow1J8IydC2KHhFvxWCRDSp1aD6b41rvkd/+lXls1pCBUJuAt3hqtGB32hh1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710790474; c=relaxed/simple;
	bh=lWKXY/htPMJxlsJlvJ8AVueqFaEsR3rBubEBLQX03LU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S5a7McZTiuRdO2p/Te23bDXR0DwgRo23CKBLW79zfRm0PMul0QNcMueJxwoyp0UmgN0rNO24fJXddSM1aKHTD9S8d4uGkx2Tg+7RfDCat6RmmXHjZAMJbyVTRgeglWMPRuymfMu32ptq3y6oe955qGn5HEtYt7r4l5VRpHAfoxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnV8jESQ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710790473; x=1742326473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lWKXY/htPMJxlsJlvJ8AVueqFaEsR3rBubEBLQX03LU=;
  b=JnV8jESQHf5qLUi5nqTwBG3vTDsulmiRE2A2OsLJOr515VrDjCVBFH3Y
   Mk3q9hryMXRaAbvXrQ5LFQw9XUB2CNeqqY+rHqZ1NWp/GrcFnaSlMbCRX
   gqkUF/PO11DjnlExRD4yOnna6x8hm7azNWkp5IISxUt8ZncB8FkfcN1Tl
   fEmAslwxlMLJCJHPyUykuKTsgmIjpBQepJUn4wgmijbRUQzOVOX7J+BVe
   7lV7F8WFh3p6/kAebu5PLpOe33E2emCkA9IT3xORTrMU4Z3E4AIebDx0X
   nMr50wCysXk2W6L4DUNuNpua/uii67Pjz21pgOWD2pl5n66FB5QxHdW5r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="16267031"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="16267031"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 12:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13460584"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 12:34:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 12:34:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 12:34:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 12:34:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYto3x0DvwRnmygWC6ABzcJtQFeYmE3LMz7u1clWgex0mucG5xX6igxItFm6IVI7mYUL5DyqOFcKkCa4vj64jSPjLfuV5xjhZQOw6Q1RPjkiead5XWtBzMW00qlimXuAzUgzcl78KJ1xJPDX6r+O0RPC220x+D4MUq6NjkpYdL62/T6jcBOeR6jPdZi04n6OBJyXX2PqVBNLNfyM954u/dDwTrw+Lu6vQg7UBycap9C1xrU52QFX2UCwghyX+/PBnKyzlwaJ3ALYoQlmSmo9ZgZIwrvzezwKept9CMpG1VFwuDasEYHxdzRXrhW/PjHyit8cUJgRlFJTgI8UralXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWKXY/htPMJxlsJlvJ8AVueqFaEsR3rBubEBLQX03LU=;
 b=ZkvttEISMtI1VHHqAnUFQLaaslYZ8BNqiQwdDo+J6V5Yslx/ujNZ/nwq0IiWBoQ1pdyNoyy5lmXPKKb5AiUz9xjidXFCRCHRkKL0ycPWtY9/an1/azJSX1FqTDoEcYsJjRi08CSgk4kcaEIq7MzYvomqG0t6lE65SY4Zq5Blg0InNcPUUgy0ohA7ITgoBUs6lbbg6TrtXu9ZH5huJv4xTbw/d2UlK96KROeJIK3EdBS0edXAGUrcXanF3iqj4AyDb2IYb9yc0c9AyA2IEB1GmjTiZnXeFcuMA/zOrnuLdLYOVHLnqCjHhTJeNXqwFExaAynTbits35O1h/DZkO4KHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB6681.namprd11.prod.outlook.com (2603:10b6:510:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Mon, 18 Mar
 2024 19:34:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 19:34:28 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, James Morse
	<james.morse@arm.com>
CC: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Topic: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Index: AQHab7KwshA04b3b7kGAda4tCZ9C1LErPGXQgADHEoCAAIKhUIAAB+aAgAABPhCAACNlgIAAEarAgAAc2ACAAUZZboAK/v/LgATLiICAAAEvkA==
Date: Mon, 18 Mar 2024 19:34:28 +0000
Message-ID: <SJ1PR11MB60832422CBDCCDA580010769FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
 <ZepK4mtoV_J8-UbE@agluck-desk3>
 <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com>
 <ZetcM9GO2PH6SC0j@agluck-desk3>
 <88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com>
 <47c28b3d-3b90-4b33-ba71-1e359d43238e@intel.com>
In-Reply-To: <47c28b3d-3b90-4b33-ba71-1e359d43238e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB6681:EE_
x-ms-office365-filtering-correlation-id: 5f7e3ce6-e931-4244-20ea-08dc47826d42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LrvcMxic6VxbkwlZYneuEllLMkc9YchAw0caMtrCIXs2sxbabfdHR3JblaFAs2AEW0c2qOSWU8sRCz896zbBhUJYpMguhJ7iREXLOISLunsUiom9iFAOTJWJ9ibPl1M4c1FKky9xPCKWftInUK8bpSz1W7HvS8jrOYc3g8O4FtwaiSdMlQmDdLDwn/pvLQpnN81r9/SzRzXTpjADV91ZOLm+BwYacTUq718+KIA57Ti810Wof7MNuCJ5XqG37USzVUZNn/gTpI1JT0Q6qi16hPT+d+ZdnZAJjqlAD9BqTgeRpf4MVezyl9u71w3n7/zcoaczh26DNn9U81AapJmklvMhAKgYjJyCdjNTGbjJjrQS9fN/niN2CMpO09R20nA7ZjvVR+r/7OiO0oO0Hqq17zBkIMCgX/i6NIgNSYoGC72W7G2gEdoABgzL93x4yDNgs0atv4LIODlRnjZiTlaflKxqsYY5gNwfjJsENYApPp6lkTFYdjN6sGjfuGpFIUGMk81nLw7FuKTI44wbEozFq8dn2nXwboiRXhABnAAqLdZ/+CpYEAP8kVuWn1nByI66V2kwGClJyXuIOr5uJw2sibUsEo2vNSs0pOrN57zIp2OFU+vV4SgD4SF8fynqhrZL5VUXsRt6GAEyJnUe3p9+w/yHQE7aHC7sG0jic36Rao6g7e38fzCgx6qWBkKciVhiN39wJXbxaPLVA9/PzRPnHVbkkom7G8zjhic6AIRyxnc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zi82M3FhRWVXNGNtd2hnK1ZiWGdnVmpRci9TYU1NK2ZsMFQ0TzB3NkpTKzU1?=
 =?utf-8?B?anlvUERWbkp0NEpVRGZ3MGVBcCtBT1BRMDRzaFJ6K0s0cW9NV3JZSlRydHAz?=
 =?utf-8?B?Y25aOFdZcDg5R1FHRStWRHR6NUxBdXBMZnVqTGxzem5OWGVrUWlGYjYxMzE5?=
 =?utf-8?B?MFJ6UWM0bDQ1WjQ4Y3BMOXd5NitrZkdPdWozSTZEeW1MUVY5ckloZ0ZPbitE?=
 =?utf-8?B?ZlQyUW1LSkt6OHRYSWIvc0dxQ3hYeWFDbFR2dXNjYnNnZEVGaWEzVVpOaDFP?=
 =?utf-8?B?YkNLOTAyWXh3anozMWRSb3dSMmZWTTQ2YmRPTXBkcnVLUjFrM05YT0JkWktN?=
 =?utf-8?B?cko2L0IySExHT01HQXNXdXlhZUZvd2V5QXU1eU9mbVlXcWdLOXZ0dUttSzY5?=
 =?utf-8?B?WTdoMFZLQlBvdDRKYU1tYWVGRFZKNVl5YkhkK0YwdDJUUU1RNGpSVnhMcHpB?=
 =?utf-8?B?ejJ5UUtqTVAzQmlOaWxma0p2SGt6Q3BGTWN6NHJBZlJyTTQwR1JvcjkzL2g0?=
 =?utf-8?B?dUx5cnBYNWt3QlBwMXRzN0I3SzFheHFaM2E0YTBEa0lFUDYyNEk0ZTZiWUFs?=
 =?utf-8?B?VjZ0bCtYdHF6enJaZEdaUGlxdXRCV29BWDJCN3Qxa1VXdXNmKzNqb25BOFJK?=
 =?utf-8?B?SktiQkhXMkFlV3RvSnl2UzF4WVh3Vi96MzdCNzFLUWRVbml6MDNGY2RvQU8y?=
 =?utf-8?B?NllOU1FXTnQ3RVNNaVByT2dZODhid1pWUHpTWnRvMC91SElhRE9DWXNHejN1?=
 =?utf-8?B?K2NTMEtTSGJDaXVqaWlkblBnS3oyNWZlZCt1Q1JnTWo1SVhnZFZJNTg0Tk1v?=
 =?utf-8?B?NmRzVHEzNmptVllpeUZaTmN5Nkhxbm5lWU8rbm85OVFGdWNmWXVKZ1ZxT0pK?=
 =?utf-8?B?MzZFcnFNbTlqN1k0VWpDWXdkRzF5bUJiaW1GM2tUeVBLRGhYd0dIZmE4ejJE?=
 =?utf-8?B?eW5DUnlybUprZmpOVkhTQ2JNSkZRZjBMY3RnbmRUQThPZStaQ1lTRFNDSllt?=
 =?utf-8?B?TDQvb05rSWhUZ1k4K3lUUGRMMVJkRmkzOHBJS01FZS9uMk1Kc3A2cXV5WjEx?=
 =?utf-8?B?TkxOenNWSnZTdzdjcnA3dTE1czRGdFM1a3JyRlUzL2VaVk9RaThNM2NmMk5u?=
 =?utf-8?B?aWxVa1F4Y2ZKK0gzcVNkSUx1UzZmTTdDREJENTFmUjloeE9YQjRIWjVuNXlG?=
 =?utf-8?B?SXpKQ1pGTWNFOTB6Uko0TlpqcktoZnNjbW5mNFYvODYyZ3BSdlo1aDR2blVQ?=
 =?utf-8?B?RWlpbldiOEt5c1ppNXpqWVg3M2svNkp3NmVLSnRQRGoyOWFMSWFzSU1jbG9k?=
 =?utf-8?B?ME1oQmV3MlVqNkxlRXU1QnNVRm9EN2hrc3BBTXV6TUVkWWhWWktLS2E4SHpq?=
 =?utf-8?B?RVg0YjNFSmlDN0JSdWFxSkNuZkIwWVkxenptYmEzMW5MQnk0TmQxODZIdmI0?=
 =?utf-8?B?SmgzdEc3clByL2hGeDFiL09LWFJWWms4eFRjRmY3TG5ZUWJ5VzRWVUFLV1ZW?=
 =?utf-8?B?NGVwZ2NpTkl1MGpieWNNQjNaMXdtUWkyV01tSFd0aHFjbXhkakJ0Q0dtT1ha?=
 =?utf-8?B?TGxGWmZVUzRISDM4Y29DNEE0RlJ6djRpUzRnQWZTZFdJNWhlbWNnbWgwc2ZS?=
 =?utf-8?B?UkNDbVJvT1pLaE01ZGM1dTJxZ2lUTmNBNC9yUGhCTURZRmpEaW56d2t2L2pj?=
 =?utf-8?B?K1YyRDNRbmJESVRFMlRBSG9ka1h1QUtaMVVCSkZKMUsrRnFrL0VtZ1cyeStv?=
 =?utf-8?B?b3U2eGVWMmkwOWcweGdlSmR1NVN6RHhtMmpMUXpjR24rTjRuRURUWUhRaXA0?=
 =?utf-8?B?UWgxZ3VrLzAxQ3JjRXUwNUlDUkJDcU5BekFSM1ZqUlUxd0xIRzJnQ1lmMUdW?=
 =?utf-8?B?S2xMVXd1bjNFNzBPMDg4TWpCN3YvMVZ0Y25pY1NWRlFrNTFrVjVrVHRsMmpH?=
 =?utf-8?B?bjVFRXdZTDVJV3JtTXFtUWpUR1VtWlF4TVcyNkt2ODNXWkZtYmVaRGQrV094?=
 =?utf-8?B?NEdiQ1JmbXdpRVFldUZWUURRRnFNWlBrMk93azRjemUrZkw4eGg2SndjZjcv?=
 =?utf-8?B?WmpGMDBzZGp2Q3JnSE1VcytTYUhIdWJwczhvci8xVVN1L0R1N2R3eGN6d3E1?=
 =?utf-8?Q?v/FM4TWKn+DLuSzJINUw00/0K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7e3ce6-e931-4244-20ea-08dc47826d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 19:34:28.3802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1J7MKWnUZaCjE9EIbD9I6xWg8XlwVnwUXMJ3F6RqePhX3CPr0sSaJ5QuHyvkjakjx44RR7832JAb3gYlnl5d6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6681
X-OriginatorOrg: intel.com

PiA+PiBXaGlsZSB0aGF0IGlzIGluIHNvbWUgd2F5cyBhIG1vcmUgYWNjdXJhdGUgdmlldywgaXQg
YnJlYWtzIGEgbG90IG9mDQo+ID4+IGxlZ2FjeSBtb25pdG9yaW5nIGFwcGxpY2F0aW9ucyB0aGF0
IGV4cGVjdCB0aGUgIkwzIiBuYW1lcy4NCj4gPg0KPiA+IFRydWUgLSBidXQgdGhlIGJlaGF2aW91
ciBpcyBkaWZmZXJlbnQgZnJvbSBhIG5vbiBTTkMgc3lzdGVtLCBpZiB0aGlzIHNvZnR3YXJlIGNh
biByZWFkIHRoZQ0KPiA+IGZpbGUgLSBidXQgZ29lcyB3cm9uZyBiZWNhdXNlIHRoZSBjb250ZW50
cyBvZiB0aGUgZmlsZSByZXByZXNlbnQgc29tZXRoaW5nIGRpZmZlcmVudCwgaXRzDQo+ID4gc3Rp
bGwgYnJva2VuLg0KPg0KPiBUaGlzIGlzIGEgZ29vZCBwb2ludC4gVGhlcmUgaXMgYWxzbyAvc3lz
L2ZzL3Jlc2N0cmwvaW5mby9MM19NT04gdG8gY29uc2lkZXIgYW5kIHRyeWluZyB0byB0aGluaw0K
PiB3aGF0IHRvIGRvIGFib3V0IHRoYXQgbWFrZXMgbWUgZ28gaW4gY2lyY2xlcyBhYm91dCB3aGVu
IHVzZXIgc3BhY2UgbWF5IGV4cGVjdCByZXNjdHJsIHRvIGluZGljYXRlDQo+IHRoZSByZXNvdXJj
ZSBhbmQgd2hlbiB1c2VyIHNwYWNlIG1heSBleHBlY3QgcmVzY3RybCB0byBpbmRpY2F0ZSB0aGUg
c2NvcGUuIEZvciBleGFtcGxlLA0KPiAvc3lzL2ZzL3Jlc2N0cmwvbW9uX2RhdGEvbW9uX0wzXzAw
IGNvbnRhaW5zIGZpbGVzIHdpdGggZGF0YSB0aGF0IG1vbml0b3IgdGhlDQo+ICJMMyIgX3Jlc291
cmNlXywgbm8/IElmIHdlIGNoYW5nZSB0aGF0IHRvIC9zeXMvZnMvcmVzY3RybC9tb25fZGF0YS9t
b25fTk9ERV8wMCB0aGVuIGl0DQo+IHN3aXRjaGVzIHRoZSBtZWFuaW5nIG9mIHRoZSBtaWRkbGUg
dGVybSB0byBiZSAic2NvcGUiIHdoaWxlIGl0IHN0aWxsIGNvbnRhaW5zIHRoZSBtb25pdG9yaW5n
DQo+IGRhdGEgb2YgdGhlICJMMyIgcmVzb3VyY2UuIFNvIGRvZXMgdGhhdCBtZWFuIHVzZXIgc3Bh
Y2Ugd291bGQgbmVlZCB0byByZWx5IG9uDQo+IC9zeXMvZnMvcmVzY3RybC9pbmZvL0wzX01PTiB0
byBvYnRhaW4gdGhlIGluZm9ybWF0aW9uIGFib3V0IHdoaWNoIG1vbml0b3JpbmcgZmlsZXMNCj4g
KC9zeXMvZnMvcmVzY3RybC9pbmZvL0wzX01PTi9tb25fZmVhdHVyZXMpIGFyZSByZWxhdGVkIHRv
IHRoZSBwYXJ0aWN1bGFyIHJlc291cmNlIGFuZCB0aGVuDQo+IG1hdGNoIHRob3NlIGZpbGVuYW1l
cyB3aXRoIHRoZSBmaWxlbmFtZXMgaW4gL3N5cy9mcy9yZXNjdHJsL21vbl9kYXRhL21vbl9OT0RF
XzAwIHRvIGtub3cNCj4gd2hpY2ggcmVzb3VyY2UgaXQgYXBwbGllcyB0byBhbmQgbGVhcm4gZnJv
bSB0aGUgZGlyZWN0b3J5IG5hbWUgd2hhdCBzY29wZSBtZWFzdXJlbWVudCBpcyBhdD8NCg0KUmVp
bmV0dGUsDQoNCkl0J3MgYm90aCBhIHdhdmUgYW5kIGEgcGFydGljbGUsIGRlcGVuZGluZyBvbiB0
aGUgb2JzZXJ2ZXIuDQoNCkluIFNOQyBzeXN0ZW1zIHJlc291cmNlcyBvbiBlYWNoIHNvY2tldCBh
cmUgZGl2aWRlZCBpbnRvIDIsIDMsIDQgbm9kZXMuIEJ1dCB0aGUNCmRpdmlzaW9uIGlzIGNvbXBs
aWNhdGVkLiBNZW1vcnkgYW5kIENQVSBjb3JlcyBhcmUgZWFzeS4gVGhleSBhcmUgZWFjaCBhc3Np
Z25lZA0KdG8gYW4gU05DIG5vZGUuIFRoZSBjYWNoZSBpcyBtb3JlIGNvbXBsaWNhdGVkLiBUaGUg
aGFzaCBmdW5jdGlvbiBmb3IgbWVtb3J5DQphZGRyZXNzIHRvIGNhY2hlIGluZGV4IGlzIHRoZSBw
YXJ0IHRoYXQgaXMgU05DIGF3YXJlLiBTbyBtZW1vcnkgb24gU05DIG5vZGUxDQp3aWxsIGFsbG9j
YXRlIGluIHRoZSBjYWNoZSBpbmRpY2VzIGFzc2lnbmVkIHRvIFNOQyBub2RlMS4gQnV0IHRoYXQg
ZnVuY3Rpb24gaGFzIHRvDQpiZSBpbmRlcGVuZGVudCBvZiB3aGljaCBDUFUgaXMgZG9pbmcgdGhl
IGFjY2Vzcy4gVGhhdCdzIHdoeSBJIGtlZXAgbWVudGlvbmluZw0KIndlbGwgYmVoYXZlZCBOVU1B
IGFwcGxpY2F0aW9ucyB3aGVuIHRhbGtpbmcgYWJvdXQgU05DLg0KDQpTbyB0aGUgcmVzY3RybCBt
b25pdG9yaW5nIG9wZXJhdGlvbnMgc3RpbGwgd29yayBvbiB0aGUgTDMgY2FjaGUsIGJ1dCBpbiBT
TkMgbW9kZQ0KdGhleSB3b3JrIG9uIGEgcG9ydGlvbiBvZiB0aGUgTDMgY2FjaGUuIEFzIGxvbmcg
YXMgYWxsIGFjY2Vzc2VzIGFyZSBOVU1BIGxvY2FsIHlvdQ0KY2FuIHRoaW5rIG9mIHRoZSBjYWNo
ZSBhcyBwYXJ0aXRpb25lZCBiZXR3ZWVuIHRoZSBTTkMgbm9kZXMuDQoNCkJ1dCBub3QgZXZlcnl0
aGluZyBpcyB3ZWxsIGJlaGF2ZWQgZnJvbSBhIE5VTUEgcGVyc3BlY3RpdmUuIEl0IHdvdWxkIGJl
IG1pc2xlYWRpbmcNCnRvIGRlc2NyaWJlIHRoZSBvY2N1cGFuY3kgYW5kIGJhbmR3aWR0aCBhcyBi
ZWxvbmdpbmcgdG8gYW4gU05DIG5vZGUuDQoNCkl0J3MgYWxzbyBhIGJpdCBtaXNsZWFkaW5nIHRv
IGRlc2NyaWJlIGluIHRlcm1zIG9mIGFuIEwzIGNhY2hlIGluc3RhbmNlLiBCdXQgZG9pbmcNCnNv
IGRvZXNuJ3QgcmVxdWlyZSBhcHBsaWNhdGlvbiBjaGFuZ2VzLg0KDQotVG9ueQ0K


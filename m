Return-Path: <linux-kselftest+bounces-23094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A902F9E9FC1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365DA281A5A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7FC19343B;
	Mon,  9 Dec 2024 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBKdHg+c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB0B13B584;
	Mon,  9 Dec 2024 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773059; cv=fail; b=KC4/6RHA1wy9cRJcgkVgDr9zm0AF14dK+2h0IqDMhqxfb0tQu0h3xCrENMriFn1GaOs6ZcAw09CwEUGVaUyX+oyK6iMinGA82EU/p8NPqb8ilV7GYVjBhSHpMJwD3Hqh/2rMLUsBApo4lnMCzDJI46fq0E3W0I5QPVYPwax0ShI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773059; c=relaxed/simple;
	bh=iS+G8g9QMWIVsx/ZBmnX/7FYLLU9EomzRiBDKzCj0MI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ljsVqEf8ocMfKWgwCmj9nDExPJ0qJjKNG+9bhlNY06e9k1mE5zOO5syJsQePEig+u6pe0j3BNZ4otJle5f6NCV4Oe9EmvlSSP+5Hfy37uHsr/+q+MK0/r9fTxwiH45ktLoRrILDiSuqoIIkJkQXxmHDNBpt9u8J94ZC/zttSwlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBKdHg+c; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733773057; x=1765309057;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iS+G8g9QMWIVsx/ZBmnX/7FYLLU9EomzRiBDKzCj0MI=;
  b=dBKdHg+cMl/tXegmLTppBSWPS26GMb3pvhJJ1ZpCVOEf7v4NTAfGaSsi
   jOcFjkDnCqDDi5NX90YKxWEZSEphJ31Lz54c4aem4T1ePqiAX7Ddo139y
   Jp0zH31T3vLn7drffve7Ha/Ye/SI2vJAX3sVvuRGR0MGDLptzNM55eg05
   oz1S0FGuXifBUT4QncyA+LhN7ThxvzYXhyiF6SaJvddAlERSlVu40G/Ic
   5EkHOYJNRYJGPOktIH9UEHvvzEfOUejL7WEO0ZJJTg391TRTDNXApuai9
   NdiorDeglhzaDZh+7gu8ywLLTk9D0uYf/Ln5olFkAdHlDxdZizsfWeLQL
   g==;
X-CSE-ConnectionGUID: to+QoNStS9SivfA30pP6qw==
X-CSE-MsgGUID: TJoKlJQZRmG3fXIF4na6nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33428761"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="33428761"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 11:37:37 -0800
X-CSE-ConnectionGUID: nyADs6FPRDSZMXcvud/O2A==
X-CSE-MsgGUID: ubhFnw9TSSWmucjXEwQaIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="95623839"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 11:37:38 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 11:37:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 11:37:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 11:37:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSt5kPEx5AD3ett+W7V2kShX8SyhiqX+on39+v01askwByLg0PaWTIU188v4gcJn+9y2NCfyPmja/XoUjTVUJae0dVXaq6YYwkusX7GUq3yWW52taBrg7bi1s30b7WR7MfJwzj0dRW2dZ8nkaYC4i0LqIdksZFZ+6/Xc6umPz2kJzuwF83Bx7cGV2g4BP2CYrs+qRjRqbnlgn8Tl0XZP/PBv4y/awBJJh1j/v/pnE24cuw5VqEJ412GWvaw3hHr8/WZHWd3e3YXU8Dflb7qx8B1KXHwW0157z92DjgSb8SjXUL6lvRB/Oo6Jc1QCLWCNFMDuZPImAv0T3OhJWDv+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NYMYJoGSKwySNIFfgGZCwPiudeiiGTBkU8bvOQa5LE=;
 b=PY3P3kDJpeCh70UQdmexOW6LqWqHuyAIPP6SoRAVvl2SFr/cdBY0jpaStuq2qZPdtUpZWluK7vgA0+kpJaEbccxql88tBdnA26c4RzKB5MxL3JYOuGfTfh9KKAzXzGyBYnxFlwsUrOLt7//cssDxDNMP7OnRsIxNiZkoHf+LbFHkcHF3nujuOg00Ss6qdoituyX2oZQSceRBZiNv9xp3vPmxSM3Gg3ADN68f3Z1McP1iPbZOiEbfs8Bj3xn+Bi3dMqKpD6Lxevy8f9CQeDRngb7DDI0AlfqErTtB5Q0KlONTw78ATRk0bFcgURgUC7Iu/4LWbTd5Em92Gc/b7DT30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW6PR11MB8337.namprd11.prod.outlook.com (2603:10b6:303:248::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 19:37:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 19:37:34 +0000
Message-ID: <7d97cc57-d9a1-4818-88b8-34122fd5b79a@intel.com>
Date: Mon, 9 Dec 2024 11:37:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] selftests/resctrl: Discover SNC kernel support and
 adjust messages
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1733741950.git.maciej.wieczor-retman@intel.com>
 <ffd4f0609a9edca8e6876c4086331d3d82e3ec3d.1733741950.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ffd4f0609a9edca8e6876c4086331d3d82e3ec3d.1733741950.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0362.namprd04.prod.outlook.com
 (2603:10b6:303:81::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW6PR11MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b0a1f9-8e87-4cc1-3e6d-08dd1888edab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVVuWDk1d0lMdTFBWDQ1TzEzdFRBTWJUcVoxQnNOeFJBSmpqcStuWXdIdFR6?=
 =?utf-8?B?NHQzcER5aklsY3ZteEQrdmV0RXBqNi9hWXo1SVVwRGc4dmE0RnpqUExhdktB?=
 =?utf-8?B?OVkvakFuWVZaOE15bkpxR1BpdG5MOGZrSnl6MHRDc0NpYVhWQmZkV1lqQmtZ?=
 =?utf-8?B?Sm1sZEcrYTBVdFFQLzRuMTJ1OVdmSFdlT3NtcEExMTlnNEVNZWczWnVvZ1M4?=
 =?utf-8?B?L1FZV0k1SXV2ZzZxNjZ3QkdIeCtMbFVyTTFraGJiY2l5TGY0eENsUWxkU3Nl?=
 =?utf-8?B?QTN4TmhhSzAvTFNTVFJpY2YwU291NVFxSEtna2NNSEJKZzFyelNiVWh6MGlL?=
 =?utf-8?B?bEVxYmNpWndWdHhSNjRqMlpTWUhTWTRFTUJOa3oxTkNHazlKZlFNMnptNzFv?=
 =?utf-8?B?OS8wZFAyTzlzREhZeXdoQ2dQMHRROVgybWVGS0hoSU1mUmVWSVFidHNISGc4?=
 =?utf-8?B?MjNFZkZCUXA1c1lEYXhSYXMvbUNBZExMbU1TOVlKcDdHVmo4c2ZTOG1sSzM2?=
 =?utf-8?B?a09wYVZqaGFNSUppOHl6azVjK3VuSDF1RmxvNHpBRVZOQnVlTEU1eXpoRitQ?=
 =?utf-8?B?aU5HMy82a21nUW9IWlRQdFhJa3Z1cGVKbDNxSmdSekdHTmVKYVNBRk1BSzQz?=
 =?utf-8?B?d2hGSkp3ZStJaURCb21VNVNYaGN2TitRakVwakhrR2MvcTJmeGp4Rkt5VEhB?=
 =?utf-8?B?anZkUFBPdzJxOElUU0s0UFphcGpBVkpLSVVkZWE5Y3BTNU91bytvMk1OWU9k?=
 =?utf-8?B?R25EdWdNN2RVTXRoMmUwdXg5bFpHdHdlTlhMTVhocWg5dGVqVGpFNFIwdlND?=
 =?utf-8?B?QTMybUlidEtzTUhWTExRSTcwWDFRR3E1TGdXWkE5dXlqcHNQeWdSU29TWWl6?=
 =?utf-8?B?ZzNBbnlkRjlVMncvc2VxbXU3OUFvenBSTm5VcHF0b3pOeEtUU0tLeFh0WDVo?=
 =?utf-8?B?S3hzUU41dFNTVUdIVkw0V2w2SE5UWHQzbUtmMUJTc0RFTmRKVzhnUFJUSnlm?=
 =?utf-8?B?eWIxQUVXaFl4ajVxRit2dXc0YTBFZTF0NjdWMnpzTk9ZUStnM0E4Rzlzb2Va?=
 =?utf-8?B?NWJjY2tneE1VNjJ1WDl1c2I2Z0pabHRGTzAyWlNLaTR2dEtqYTB0UkdlMHZz?=
 =?utf-8?B?Z1dEcEZIdExHYW9FOVR6U3JIMms2dFhPTWhYdE1GUisxYjNjekVXOXRJakJ4?=
 =?utf-8?B?bXNqclcxQkY2Rzh5QzBQR21GVElZZHJTWSszZzlqY1hpbk5MT21VTjc2UHI4?=
 =?utf-8?B?ajRVanVPYnkwRXF2dTBaN083dDV6VVNjTkt2Y2lzVElsTHJmV2RQRFNmMkpq?=
 =?utf-8?B?OGo3b1FHWTF0MnpVYUVlS25VdmZvWjZEUThBY3lXajdhQkJxTWdWNWN3aFY4?=
 =?utf-8?B?eUg5cGpCekRNRnRkZG1WS3lzV1RTTzhXTGJMT0RSK1NpL3VGQzBJS3EwN204?=
 =?utf-8?B?d0hxK2IzQTNlVDlFREV0d2QxV2ZMcngxSTk3UDA3V0puOHJuREJzMldySWlU?=
 =?utf-8?B?UG1JTmtNaGpjZUtjbExUNGdrOHp6NWVMTkJhYkowZVZ3SVpzSEhrcWRFeEVP?=
 =?utf-8?B?UzllRG1aaFdhcUdBSjZaTXRSdWdFVytaQ1ZqdHJ4NC9wUHRPSUtYUGhkNTdv?=
 =?utf-8?B?YzRZK0lQM1FmbUdtbTVUL0NraTdzT1Z5cHd5SjRhK21ibFNEc2NoRHBtd2U4?=
 =?utf-8?B?VEVoT09MYmJWQ3FOMmJibjFpSFhQb3FPTnIwc0pSVms2UnpSd2huSkFoTmJo?=
 =?utf-8?B?VE5FNnFMM0pMTloycS9JanJTTnlLMHBNbG04b0JTZzgzdlJrOUJvZ0ZuSGNT?=
 =?utf-8?B?Zkx2L082ZlRIMWdkbDNNQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akNjYVNpT2Jid0h6Z0lvRXBVQ3R2Y0laWUF0R1J5RCtCWkkzVTJrTGZvZ2la?=
 =?utf-8?B?cU5RMmFaRmxDWDRPL1U1SjAzNHlQRk5xRElkUWdXa3djVmVOZTkvdW1LRzdw?=
 =?utf-8?B?ZW5iNmhrbUtEUGdvNGEvZUpqUFJMaWVlVGpYVnpHUFVNZ3hZY2crdTZCZmNG?=
 =?utf-8?B?WXpHZlFlVitpaEpJdlN3RTQ5RHlFVDBBcVFKVlc1TytJSVJMQjhHZ2NNYkFm?=
 =?utf-8?B?SmhKSEpsWUY2UFJWSzQ4M3JOc1hudVRuV21yaCtTY0RBR0lsUDhYaVZJS2V1?=
 =?utf-8?B?WGpzd285cGlKMitlRlFhQUhVWWpLNUtValhycHF4UUVwNFAyNytLVFdrc1ZQ?=
 =?utf-8?B?dTArcVUwcVl3QUdad1Z0T3hCSVBPN1poRmgyQlRKL0VwVzVUeElPQUhMdlRE?=
 =?utf-8?B?Y2EwRmpjUmN2cW9iR2tuYnpFY3Bpa3JncHRPYmZ2MGhMZnJUcEhlcWJrRGtw?=
 =?utf-8?B?aXdsN3lHaVF4Z3MzTSs5cjZPempVNjNabmVweHg1Y09ocE1ZcTFWUmFUWmFz?=
 =?utf-8?B?N0Z1Y2xaSHcyanFqVE5Va2pRSHJCRHYxSVJ6ZEZEejN4NUJRdWdzbC81TjhV?=
 =?utf-8?B?RWhlTDN5NGpSZGlOT2I0Mk93bW9zL3lTQk8xZUhJVmJLYmVmU29lOWFySFI5?=
 =?utf-8?B?bmxJbXRuMGZ2T1RNTmthZTlTOVVXNEV5VUlzYURyZU1uOGFabzlOMHlpTVhj?=
 =?utf-8?B?MmFGdUdjRjhSYkRBWDB3UGVkSGgySytwRzdZNEpwYU5MVTA0RkN6UjMzMGFV?=
 =?utf-8?B?SVlBdWc4NjVYMVMrb2JTeWxCUS9VbFFUSTVWaUJrMHQzRG05K1lUNFBTc1Ju?=
 =?utf-8?B?V1Z2V202OXZzNGt6anVkbTNCTXgvR1hiaFlnZEhTZlZTRWxneUtoQVhDU1hW?=
 =?utf-8?B?M2l5U1lBUHZlSWszU0k3R0JOQ3JKR3ZpeHd3Z1VFMFBUQlNLNWZBcTE2UW9r?=
 =?utf-8?B?YjdBUjJHZkVCTjlRZmM0VElPZ2ljL1hHNGhoczhkVUZoM3RZZURybXJ4bnl3?=
 =?utf-8?B?bGpYUDNKTmdueXRYZS9rdFEzUm5ESzQxa2NUMmtMQ3RGQjRLY29FbG5Nd1dV?=
 =?utf-8?B?WDlvOVBYQXgwKzZ5ZGRPQ3B5OGNEdDVQUmJ0TWlDYVVrV2hZM1F6cUdqdWFD?=
 =?utf-8?B?dXcrT1NBS1hiM0kvb3BVS3RQbm5kYWVKazl0emZ2VjRLY3ViUGdvOG4rM1V4?=
 =?utf-8?B?Z0RkVFNkSVI1anVrLzFFVk9YYkYyQ2JibWIxd0hlb0tydThGN2VDNUIzc1pt?=
 =?utf-8?B?a1gyUEhmV1phbWlaWEJ1N3M2WFAxQndtRGFPM0tVN2NXMVgzcWw3T3lhdWhm?=
 =?utf-8?B?ZFF6K0JKeVlxZE1RblVJNEdIR0d4MzVMQkFoZjE5NWNrSmh4RUV1T1BDemhG?=
 =?utf-8?B?S2xOSGJISVlHUjNjY0JZU0FJQUxScnZPQW1jWGR6NWpQeWw5UVN0TDRLOHUx?=
 =?utf-8?B?OGdrakkyeHR4N2JuV21VMXNsa1JPN05mZG1YMlNSV2VUSmpLSmNnMUlzTUY4?=
 =?utf-8?B?MDJDNXp4NkdKbjB3MzJUblFwWGtzbVpTQWNTNkozOUxnZ3M3QVNlenNHa3hj?=
 =?utf-8?B?N1VUTzRYU2VWRDdBVGE1NC9PR0hDK2EvbGxJblp6Y0p0QWJENU4xSlQ3UXUv?=
 =?utf-8?B?WGZmTVc3a0l3MkZzaFB5MlRsRlUvSnlxa3lyTElwaHV6eW9xdTJHWkZIWm9u?=
 =?utf-8?B?VUZkZk9jUzZvNDZEWmVadDlVWVcwRlIxaUN0bjl0SGsreVFDQm9adUg4Tk9X?=
 =?utf-8?B?amRvMGUydHU0TnM3OE9vK1RUeURGRGdIaGRPZW11dGQ3a0lvVDRVQ2FpMk1Z?=
 =?utf-8?B?YnFwZDA3S0Y4Y2VRbXUwYWxSNnpMMlNJNWV4dnJJeEFoS3JBK3laT3JrbzVT?=
 =?utf-8?B?WlhGNTNMeTQvMzgvZHhCbDN1WSs1ZHZVYzVjaWhLQUVROGNtUHdidnZIajZl?=
 =?utf-8?B?Zm1PUkVYSzg4MWN3eU9wWmFyNjNlUG5SbkdZQS9oVXBBRGFvcmFlc0F2MHYw?=
 =?utf-8?B?QnNwV3NyRXZBNlZabEFaM2cyRjhxNXFZR1FIdHo1Q01HMFBXeE0veXprblRv?=
 =?utf-8?B?ejA1YlhtaDhGWjd0cTYxN2Z3bVFNVUhOTjdZTkFMeGQ5SDNYODJkbkVuTGRv?=
 =?utf-8?B?STN0NmZIUVVicy9zSVVaTlRoQlR0YWkzTmVSQ0hLNERiUThXdENSbCtTeVEz?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b0a1f9-8e87-4cc1-3e6d-08dd1888edab
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:37:33.9688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjeBWAcs+7svZ60zyWp52Lkjo4+1iCcHhO/7MCqHAhnwGajxZoSs/aBQ+292Zw+EwS9z3jTaROTtxMWdc6Saxr/VROTf4ruwZAgan3HsD8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8337
X-OriginatorOrg: intel.com

Hi Maciej,

On 12/9/24 3:09 AM, Maciej Wieczor-Retman wrote:
> Resctrl selftest prints a message on test failure that Sub-Numa
> Clustering (SNC) could be enabled and points the user to check their BIOS
> settings. No actual check is performed before printing that message so
> it is not very accurate in pinpointing a problem.
> 
> When there is SNC support for kernel's resctrl subsystem and SNC is
> enabled then sub node files are created for each node in the resctrlfs.
> The sub node files exist in each regular node's L3 monitoring directory.
> The reliable path to check for existence of sub node files is
> /sys/fs/resctrl/mon_data/mon_L3_00/mon_sub_L3_00.
> 
> Add helper that checks for mon_sub_L3_00 existence.
> 
> Correct old messages to account for kernel support of SNC in
> resctrl.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


Return-Path: <linux-kselftest+bounces-6401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE82187F217
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 22:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA8C1F21A14
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 21:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D085915E;
	Mon, 18 Mar 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZbGT5K1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6040558ABE;
	Mon, 18 Mar 2024 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797194; cv=fail; b=rSV1ULqqXY+dSDGfKdeCM/llTx6vpVgY7sk+l9FkVXdGJ0B8bX97KYD9CqAI1anmFzwi3pVznjTHY6s+bi/Hohae6TzIXe+HnAZ/0pt6qdOcvYaZ+JqQeV6SneKjLNmF/cov7cGFdSX8HfJ/UZMAvTEBZbOtmbv/1bqxw6jzM+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797194; c=relaxed/simple;
	bh=SEQ/90kvg9j1BslIwmUwQr/5v4DjhOoPTm2PWfpcP8I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nHzN+tWuAGih5LrxbruWqQ7nmxT2CZt6N2jRyi9V5dqGRzfbyjteMJqH5wkSplzHuIxm4zG1BneQBs2wXXtNTHDE8oChfeWlM1bZmgv+5xwJOEE4ozks04pG8e6erVEN8MCGBz4dyvhd0tIrImVHyewMLu4/VSXEAwiYrqfTJ6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZbGT5K1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710797192; x=1742333192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SEQ/90kvg9j1BslIwmUwQr/5v4DjhOoPTm2PWfpcP8I=;
  b=jZbGT5K1Eg+NOTmvKadL7byy/kziIIYXcSajPkhW9VAaXA7XAy+IQMUd
   GzE2Zkk7XCteJz2LlS4+WeZVJmiqTVySnZRlzIeIxnRgJw+5eggCrPWR2
   EmixoWQvMmHcnG70gOfYbldfHTpw67NrS4F19SW4gM8ED+zX6BrnHsMeo
   +PH5Gzep9MqUPC+zIinfuYxPoObBZWk+r6XR1tuOqsZsNKifn0YGuQWyp
   9sTst3zbEihIf9U5/6Xon2/glz3CiaA2S5823zD4nICQODMMqXqnZlgxq
   syUej9O9m6aDZoBnObtQHIxh7Fibbbb0POKVOJpSrZrEOJKPikP6/eDWT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5499436"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5499436"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 14:26:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13484414"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 14:26:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 14:26:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 14:26:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 14:26:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJSNAvEvfeEbIVj/LG+/hOrWL8b4SQPSfxsidzWPVUflfJgbVoiFtUo5m3zO9rALInKMZp7R2PnRqQ/O2zZe4zMzfprkPUsP+Y7vxgtPccjQXy9YUdV9DIdKr0+FtcpKFgOUnhObfebexWbQjVVE5Uj7zWWLMa2SjFoU67wrpf44K+P56fcVh4E0/MgGVX5FadkC0yq6P8tBBR6K2Y+J6LKnM6KzSfX0jV8A7sBdP3tLnW4EKJXk8Jm7KQFnWFTHKCS6yZ+aN09FPzMXcMXo2nODnRumtzpeF0YYfMuMRtsCK+ZvPstu8ZMEJ4m+tR6SuwSPEDx9toOFKtechfA12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPrK+S0iCEm12Fu+fQrsAmwQyFaUAEzq9YpaUKOAIZo=;
 b=bb8WZ3yGaCvQjAkGb1CLMEbM0Hz2jnnzMp2LbYW+ohaUc5sSbDdQTs0mQMSaihf9QPFzzLZGR+9yqZmaOGl+srXpOLiJV1CyFm6NDll8b3xbdXrYOde+AduZrfSBe2Xxrg6HABNDFV8HhOgrSXL4oVAkpArdf4H0KDeD1rP9h6DGTr/+31zzIMO1Fu606sOxR2BiqKl622f8U3p5RYQz9MKCNqCxj3d82B2SGmiGhjGLegiIccl9UL0sTcT3G8wu3gZWSMkPooIxEdjXv56tYWfE9EbpkDLr8d8IF3SwieIokUyP+SikgqfQtcr+cgnJlXZZHXVyFnUSnjzSq/NU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5877.namprd11.prod.outlook.com (2603:10b6:510:141::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Mon, 18 Mar
 2024 21:26:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 21:26:27 +0000
Message-ID: <176e6031-c95f-4c75-9857-5f8fe6c4e67a@intel.com>
Date: Mon, 18 Mar 2024 14:26:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, James Morse <james.morse@arm.com>
CC: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
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
 <SJ1PR11MB60832422CBDCCDA580010769FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6948784d-6a20-435a-8781-30f324bed472@intel.com>
 <SJ1PR11MB608303C5E0BEB42CAC5B02BAFC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083FAA69AF7F712B34CA292FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083FAA69AF7F712B34CA292FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0337.namprd04.prod.outlook.com
 (2603:10b6:303:8a::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5877:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQOXpCuXwflhOxHjQkG/a+VFu+z4b/tRwjJwWKT+D100pNPK4q8MD+YIjzzDMO42bWsLI1uP5BJJYp6iB9+iALL5yBB+hJdSq9GTP/0MbixtissmOa0crnWLR6SuPFpGnPXR/7ZlVIrc0WxRYhmizsbnY+0yNiN44TQq6cn7Gtwyn8hxFaA92XUtPoOa578kNiCQ2RG3HqHtxT1+uzUX8x14ZsyIISNg1FmlfD6Vusw8CQycWJ5mOmQMCplktIzxQBmcTLaedZPWpbJVcO2WH73g1J7uBtc5u7R8Z2nNk0xW5OQ2CSX0hB04+Vip+wlc5K4wx1JXKmeFRMmTqkg+AhUQwo66by0Z1p4esXsHgPCrEOOzytR5rZ0PEjRQaovUXTcz00PavMqLgBi9j5G3ueRNxfYeLSm5G5Ub5OdCFtskKXPYJtY+MdHMe+fV4UjWf+Hd++0mmsfIbJ5qzQe9QygqPC42FXqYxb6dVvwuMFD1A6IG15cBCOzts4ETmFwI2S9NsK/Oi8k43HoYP/tXrihY/cQZcU1KRAkQhMz6RDkanf3j2UiM+bJXmEK8maZRFLhy2LG36Eujw+a4B+Zoqb5RRLqNhTa491nspH5j71lm9b8ES6s/EPqQTWkwgv+Gk2b37x4VV03brXFvoqemxvTuD6Xn1FhRnzgZhVIM9OE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1gvbmxuMFlReG9VQ2YxcEZvNjdFN2lJRmZwakhHMGtSSUd2aUpsNi9nREtS?=
 =?utf-8?B?OU9YUlRodW16c1FLZUlOWmd6MUtJSW9BUk1uaVd2Z3BlaE5XRVBsZW5GTmxC?=
 =?utf-8?B?SDF0T0srWjBkdmpNS01DekhieGc3OC96emhiVEZ6RmVkYzlwOGUrVnRoZFQ2?=
 =?utf-8?B?ODU0bUZ3UzVVMkwvaEZqaTRXYzl2SHZkbGZCY2RSTjJCdTVkbFl2cTYxZmhQ?=
 =?utf-8?B?d1ZuUUJDMkZ3ZURDOFZ2QWRnZ21qbVVIckQxczRZazlDaXpXVXRhYmhLdlBq?=
 =?utf-8?B?bnlVcDcrOXNEQTJBdm12cWl4eWZiMktiS0M2ZC83NHV6UkdIa2VjL2JyZ3lp?=
 =?utf-8?B?bTlMSFVocjVOS2M3WVpnT2h6ajBBbzVvMTlhMXlDb0pMc0pxYjFVWG9KZnYv?=
 =?utf-8?B?eFNBRDNVbXlad2RWbSthWDJxMVlIRlhkaENOR0k0dDlyVmNadVVoVHB5NFk3?=
 =?utf-8?B?bDNSdFNndXNCNEs1MHB6bHNrdHZIN1JVVXRtcXhjaUF2QWxldTM5UEpNYk4y?=
 =?utf-8?B?UGtVOUZBN0FIZFZUTE5POFlsWDFRc01Lc2dTZ3lISEtlMFhPYmtnMG9VRDNW?=
 =?utf-8?B?TnVlaHVLVkZqS1J4SGdYMWF3MEtTRG0zckRKdHdNTnZmaFhSTlZYS2tQandM?=
 =?utf-8?B?S2NKNWdXTGkxN1lkekxkTTJQZGIxbGVZTUNka2tWMDgxQS9XWTRPcjdjOVRQ?=
 =?utf-8?B?RGtxYk1XWGxXbGViZjRXWHgxSWxDY0FIRE83dE1QMGNTQ3ZiQ1BEWGhoc3Vj?=
 =?utf-8?B?OGRYeStkQzhlTHNwdE5RL1FiZThZcGNOZmxRejFjbjRWaUZYdUJaNXBkQmd1?=
 =?utf-8?B?YUtoeE9KTHVxdHJ6Q015bkZPK1QvODloY1MzaWZHRDVKczV5OUNSM3QrZUt5?=
 =?utf-8?B?bDIrc1RGYW52aXlPazZiUnBSSWJZT2VrenJsekFhUzlMUkdjTHJ5cGpzWFJL?=
 =?utf-8?B?NGpEclFxUmJ0YmN5RDBJN1FqbmcyNVdiZ2hHWDdDQyszWjVBb3N4eEhZaVZ6?=
 =?utf-8?B?cEdQNGVtcWVXcU8xV3pBUVNnRkZyNFlKUUQ5ei96Y05kOTFMT2d3YWV0UzhK?=
 =?utf-8?B?eW02aVBkajc3dVlmMzhEMTNWZEtuUHlkbjU1NlZDNnFrREFUS1FrMWVKZHJS?=
 =?utf-8?B?UjdmeFFVVGZwU2hDQzBjaWxXU0xiNjFxMUpQdi9EeUFJcEUyZ2ppdkhKTjhv?=
 =?utf-8?B?S1djem9qN3A0N2EyVmdHY0Q4YVNOcE1VNlJMVzRxaWdqbEd3cWR1SzNMLzZj?=
 =?utf-8?B?UGt3cTNPa0YraGhMeTF1cnJIN1FIL3daN3A1aENxQ05RakRLN2VsNW14MFBO?=
 =?utf-8?B?SmtPanVHeVBwaG9DSEI2QnQwQUpHaVkyK1JSZzFWTWpPR3A0eE0wcXY4QWpt?=
 =?utf-8?B?NnNIRlpXbksyZDZvVktRK0QyejU4OGdNL3JrcG9NbW9FQnhsMm5PcitYWmxI?=
 =?utf-8?B?WjRiQWpOc2FSNDBRSy83VUtnS1ZjaXpyRUlycTdrVmcweEpURk1MTzErbml5?=
 =?utf-8?B?azJGYnhxRzV3WDVLWGJOb0VXWjBQVHlzRDF1QmJZcWw4ZVo1OGVvc1d0MHlV?=
 =?utf-8?B?Mk84aTMyM2dZT1IrREF0Ykdqc2xmZmtxVFEzc3JvcGpyZVUydkVFbGZxckdw?=
 =?utf-8?B?OUgwcFN3bVVvOG1oWGo1RXZ4dnVXNjUrcVJrVE5Ia01hNDFvc2dhZ2swRzA1?=
 =?utf-8?B?aStpbTh2aVNoOG9mb3JuNXlmVjQrWXgxRjF6NjREallER2NFV0xndUVpaEFS?=
 =?utf-8?B?MGE2RDZlTkorUzhvajVSdmFqU2Fad00xMlREQk5oWWJyQWFjRHhMQ0oyWkho?=
 =?utf-8?B?Vmlvb3RvY2xzaFQzZnNaVkhFWVU1OWtuS1dGYnJDZk5lUE1GNzNaSDlOMzRu?=
 =?utf-8?B?OU9OcC81KzVKdEhPNFBmWHNsSU51WTFPZDdhMjR1K2ErYnZucEI5aXV2UzV3?=
 =?utf-8?B?ZUZ4TnpsWHVkTWVldnBXVE1TZjVyWi9KdjBCd1lycGpyK2JuOHMrRUJBYjZq?=
 =?utf-8?B?Vm90R2IzbDAwdnBYRytsSlRDYm9zY0I3UnE1cTZDdDhPVUtsNENvRHB2YkxL?=
 =?utf-8?B?Y1lwRW1TZUhpWnp6UnZKV3lWeTJRY010b3Azd1A5VXJhSlZhWThFbmJSeXFk?=
 =?utf-8?B?ZzZoV1JoN0pTeURlbTk5ZWIxVDVDQlFxSDNYb3JZNDBVZ2Y3aXNnWm9hNnFp?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ca368c-16ce-40af-670c-08dc47921200
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:26:27.4100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WaEajYCO5JKZ/UKZ3IUcDxOjRRvay2jpPL++TYk+f5ZvxMV8mzqEnit/TYRP7MoRavzdRN+9pvBHIQPsBq/IW2/HtIpUJF4L3Wykp8bBsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5877
X-OriginatorOrg: intel.com



On 3/18/2024 2:04 PM, Luck, Tony wrote:
>>> What is the use case for needing to expose the individual cluster counts? What if
>>> resctrl just summed the cluster counts and presented the data as before - per L3
>>> cache instance? I doubt that resctrl would be what applications would use to verify
>>> whether they are "well behaved" wrt NUMA.
>>
>> Reinette,
>>
>> My (perhaps naïve) belief is that in a cloud server environment there are many
>> well behaved NUMA applications. Only presenting the sum would lose the detailed
>> information from each SNC node.
> 
> Is the answer to "A" or "B" ... why not provide both:
> 
> $ ls -l /sys/fs/resctrl/mon_data
> total 0
> dr-xr-xr-x. 2 root root 0 Mar 18 14:01 mon_L3_00
> dr-xr-xr-x. 2 root root 0 Mar 18 14:01 mon_L3_01
> dr-xr-xr-x. 2 root root 0 Mar 18 14:01 mon_NODE_00
> dr-xr-xr-x. 2 root root 0 Mar 18 14:01 mon_NODE_01
> dr-xr-xr-x. 2 root root 0 Mar 18 14:01 mon_NODE_02
> dr-xr-xr-x. 2 root root 0 Mar 18 14:01 mon_NODE_03
> 
> The "L3" entries provide the sum across all SNC nodes sharing the cache. The NODE ones
> give the broken out counts.

Perhaps ... in this case it may make things easier to understand if
those "mon_NODE_*" directories are sub-directories of the appropriate
"mon_L3_*" directories. 

Reinette




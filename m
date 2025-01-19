Return-Path: <linux-kselftest+bounces-24756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371D8A1613A
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Jan 2025 11:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC26188620B
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Jan 2025 10:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C28C1A2C27;
	Sun, 19 Jan 2025 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwKG9sAB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885713C80E;
	Sun, 19 Jan 2025 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737282994; cv=fail; b=Zwm6NyqLZKsEvkW5khl/6ceAQO+7ra7M6bPmjb8tkdp4SKr8GWaDoQ34VrfE2HKcsefLMYMATJNSqWhc0trS54Wps52fTdGazD9yK1IXnrn9JO7PgrnJ2YDw6ISVKQ8Sx6j+C1cHG7Kcqm5tQ2dsW713P/sjtoz+E60Hd/6y058=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737282994; c=relaxed/simple;
	bh=ovsmfu3nhttcw6fIqp9IOLyA4QYdZZ0IU52Yx4sIKHc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LtUelkc5KFNqGePRqOrH146pCeTyCXUu5VrkGgCPjmtt900AH0nX9eBjrorVV7J7bn35CuCK2R8lsVqKrHfnsHfFf8x0i3t1SccVMA2vGyoSIt8s5EDdlpRWDIZm0NZKmhso7Uc8b0bIQA1P/NuixkqaMKAot1D51wvCkRzVgfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwKG9sAB; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737282993; x=1768818993;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ovsmfu3nhttcw6fIqp9IOLyA4QYdZZ0IU52Yx4sIKHc=;
  b=cwKG9sABEfYiSAkgeDTDqgpioAghkF80p1M/kfJUi5Ly4UP+tOM1ddZl
   cfFn89mjxNgWZqPkZezNAXnRmIjSqFLdxyObiDNdXJlN/6Iryj6gbXWR9
   yjTGPwNJFBVHbiLGQD/P2IexYsWrO2v3EWbInfJepuhWmgv0dpFoFKfQx
   Tum2qDfs6aSxLm5NhHKVa/rqsn9jjur9HdK1Uw/b3V0HaHFMmswWzIO/H
   AHiHVwXpg/ti1dFiAjSsA5TWoojBbvffZ0n8Z2aSCVuVAGERyHXtY7BmZ
   XjWHbNnSRx2Fum4qmUHoF+S9rrMqdNZBS4zzF0Qh6M5DU729MtufTosDy
   g==;
X-CSE-ConnectionGUID: B0uiv41oQIKzNkRdDP9hbQ==
X-CSE-MsgGUID: ILQhGzo6RFG0Qcf//K7HSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11319"; a="48656964"
X-IronPort-AV: E=Sophos;i="6.13,217,1732608000"; 
   d="scan'208";a="48656964"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 02:36:32 -0800
X-CSE-ConnectionGUID: AT8jfshBSbWIMOu5az/siQ==
X-CSE-MsgGUID: wyfoSVfjRWeL5KnXFoRXRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107105474"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2025 02:36:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 19 Jan 2025 02:36:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 19 Jan 2025 02:36:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 19 Jan 2025 02:36:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPSbTgpZzImvwjzjCT+ZUt/3AgcDSAJyG/4aGzVcIFH9P/00fiNApL4wGg5WhZjuKO9NDQwp1VzBzoVUYlQo8lABSVVRzUuKzZGHOtbRFhrPXzfwnLdGz6CZkW9iIYgUOG9mO0p1cDWzkXHJryepKZXV0JATOwNor6e63KswXWOfLp3OD1WRPFsusdiNvkRaDtmpoKNzfJGqRKcQh2Y+8SNMvbAulQR/ET8bcvRd6OcsBeBZYlkwsIv2Hqzh1165iWZFnxn9K81TbmRUOMuRMvjJ5GLMot4sAOyMhaJwe3CZCleB5A9DUAbxCHXeBeGWUXpb1WNa0D6oVsl7O8BREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHUAcWkuQyVwVUDj+ZDNrcLToRO2Lo4KPtywv4L2oZs=;
 b=UU7lBtZYaKn4xhf/P3c2xD3g0tuqbMCSGVZXGL9clxmy3HhQ7takE0YHvMfCoKOVXFuRTN8eMrZxFQ4JRaBA9FWqQX2AcpwC+LXy7ZKwZ9F8CvVT8WkXobvdEZ4G7CQe4CpMMV5cnCqXCP4bTOnKaLV9AD8x65ukonIQaH1uhAswSDhUzo0lpfZlrlJ7sHLrDJcK6DDNMkoHLUlHdA6S6+o54u9rPzioEbCguN4KC5+6pHeM4ce8ruAbA6FejlF37uSphSx49AIzQ4y8UGHplzBGuVVpNZxw+LLKfVIIyGSqwKOs16uxSDHNiFllYFEwYAQuXXqaf8j3TYKZDMLZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7405.namprd11.prod.outlook.com (2603:10b6:8:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Sun, 19 Jan
 2025 10:35:47 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8356.010; Sun, 19 Jan 2025
 10:35:46 +0000
Message-ID: <2b6c52f6-037f-43d9-8384-7b48764a3e81@intel.com>
Date: Sun, 19 Jan 2025 18:40:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 06/13] iommufd: Make attach_handle generic
To: Nicolin Chen <nicolinc@nvidia.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<tglx@linutronix.de>, <maz@kernel.org>, <alex.williamson@redhat.com>,
	<joro@8bytes.org>, <shuah@kernel.org>, <reinette.chatre@intel.com>,
	<eric.auger@redhat.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <c708aedc678c63e2466b43ab9d4f8ac876e49aa1.1736550979.git.nicolinc@nvidia.com>
 <62ccc75d-3f30-4167-b9e1-21dd95a6631d@intel.com>
 <Z4wP8ad/4Q5wMryd@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z4wP8ad/4Q5wMryd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: ce57831d-b6db-468e-2a1b-08dd387508de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1hock5nSEVna2F2V2M1djdJTDlPSmFXUXdXaHh2YXhiemoxZU9URWlkc2lI?=
 =?utf-8?B?TTUzY0g4K3ROak11UDFLUFBrMnNvWThBRGJNUnVVb1ZFNEprS3VXNy9DM1ZV?=
 =?utf-8?B?ajJuSzBWeHZNVHVwT0xteW9Cd3hqeWxUK0dINmZnek0vNkdqaXIwVzlleXd1?=
 =?utf-8?B?ZVNpaVoxRkd2SEt2TU9KT0ljazloY09XV3hYMGNlQ2owS2lNdmdYV0ZnWnI2?=
 =?utf-8?B?Tk45ajJrajl5V0V6RndKTWhHMXYxdTdTdXB3UmViM1VYMmo1OXoreEpGRUVo?=
 =?utf-8?B?REdPQ3hQcmRzVFF2bjFGYWZsRDU0NGRJS3BzT3N3aG5EKzRaSEZxVFAxMEY0?=
 =?utf-8?B?SGkxeldQRnRlRWNQaUZnUUFWMWRxV3RGZUxhVWU0VGk1Y1NDUkNkeUZDSGE5?=
 =?utf-8?B?UXRGM2J0YVBhT3ZXTGVIcFhRRWs3MWdHOStZMEZSMTllbGlkb01FelZsUytX?=
 =?utf-8?B?MkliaCtNdFUrcHVLQndmbzV2MmZqQ2tJNUFPYjVBVDNpakF5QmFEMW9uUVZh?=
 =?utf-8?B?VUJnQmxZSEwyZ1BZYzk0VGhiZW11Z28vcE5NMHBRVU1taExJMjhDdjBMWk1C?=
 =?utf-8?B?VWZTWWdKTTYveFczVm9xQzBlRmRlOHRBcWxIWVB2Sm5XNkFtNkp5V29YVmpN?=
 =?utf-8?B?Q1lCT1VUQkVpVUZrTXVUYlc4Qkg0RThNck5uRWoreFJEV2ZzN0VCTm9yYzls?=
 =?utf-8?B?UXdwQlg2UW1iTVJLYUNrZStxVFFEei94ZUt6Wk1aSnkwdjlnUHNlVDNEZnQ5?=
 =?utf-8?B?eXlQRDJkSU91MTYzRWVpUTRSL2lpVjg3eG5tUGRYR0kzMUtCUWxTeUhxVDVR?=
 =?utf-8?B?SVpOTjBpeEZ6VXBnVkkvcG8rNk9WRW9sZVRKV0FEN1ZvSXhNdkc0dmhEQ1J6?=
 =?utf-8?B?bVdZaFR3b2d3bXExUkRpSEJCcUlyaDc1cUZqYlNLdGdrSVVlcktqd0tsVUtQ?=
 =?utf-8?B?NEN1THprS3ZDK0QrYW5pZmJQazVpRWZTL3doWkJoaXFXUS9LeEYvY0lWUnps?=
 =?utf-8?B?dXNwWUdGOHBHcTA0bXdHN1BUWEdsNzBtdi9GT3d1YTkyYXVuQjRqNE8zSURt?=
 =?utf-8?B?YWZhemRNaGIzQllTRXY3MngrRU94bVR2VEtJK3Z6Qk5hWFM5RTZpL2lKelAw?=
 =?utf-8?B?VzFFVUlRcXZQYkJxUkdwZVZydEZOVkp2UjU0UExiL0lWaU5pVzBCd0hUKzR4?=
 =?utf-8?B?NVh6MjJiTzZqanN6cndtYUNGS1NpZDlOSURsdTF6ZjdGZFJxYVRHQVkydUxK?=
 =?utf-8?B?Zm1VNVFFN0x4cGZSSHozaUpYdGpsSHZjOXlQVDRCOUxRdi9ydDd0Z3hVNFRC?=
 =?utf-8?B?S1NqY3grbUdySENYTzc5NDdNekRuR0o5dlVkTHllaG53WmRjMDE1YTUzZVJs?=
 =?utf-8?B?Q1ZBazFQNE0vNnVFYndOYWFpSUpuYUhKYVhUdks1YU5CSEIyOW83T3MwOTVq?=
 =?utf-8?B?WFpzT3VZRmYyOSt2WHJpSjNUR20vL2lGdEtiRURQU0YwTFk1SXdXTkljdmVl?=
 =?utf-8?B?Z0VhcU5ibkZQS0YyRnJnZEg5aHlaMktXSGxiWXI3RlZwd1V4ZDQycFluVmtM?=
 =?utf-8?B?VEdadUUrU3MzOFc5MW5rdWxmR2lJNEtkQ29EL1d2SzYxSTBod0Q5Y3k4UzRV?=
 =?utf-8?B?R2YrOVVGRzJQVHplTTlDcFpwNUJJL1c2SDRNbWxNYWRiSEVaTnNBaHdva3dB?=
 =?utf-8?B?RTVxQ2RYcXRKYnRZSHgvNlk4L1FIdWlyZVhmSFpoSmxjeVBTVTVGWk9Yb0Mz?=
 =?utf-8?B?eDQ0ZXROa0ZiMm91bmVhQ1RMRTg0Sk1vUDdrQ09neWR2cU9KYlMwUTkyTlk5?=
 =?utf-8?B?L3lwazlLTHI5WlhMQzN0RzFTVDg5d21kVmlEbW5CRUhzM1NMNWY1WWorckdL?=
 =?utf-8?Q?XT+ONTgyP/Fkm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnBIR3hpcTFrMUEyMitmRWcrVU5XUkNXTkhDclIwOGJpZytJNU9PMzJMZ1Jw?=
 =?utf-8?B?VVg3SHJGU0tzZHI3QUpuaktKRTJ6UUdEMm1JSm1JUkNPanBLUTRRZTJmQTQx?=
 =?utf-8?B?d28xb1RML0hqR0EyMmp3SDZQaTNwTVRpampYczhlT2NQeG5jN1hzNWRjaTJP?=
 =?utf-8?B?YS9aQ09DbXd3b1hOTE1GSlpZNzBTK2d5ZHFWeVBOMmpaUVczSGRrd0Y2VjRE?=
 =?utf-8?B?dkNzcE9kTFNxM2JMWUljdWdVVkkrUVliSTc3TFh3d2FHb2Y3MFVDaUlHVjd3?=
 =?utf-8?B?VDVPTDl3NTVLaERwbk53SXRlZ2d6UW8yemprMlZJTW1SVnRKMnJhTzNwOGVj?=
 =?utf-8?B?cGRFRU9wR1dWaWEzYzFjVmM3R0UyUzdjVHBIQnh2aGRPeVJyNFJEOWxsV25t?=
 =?utf-8?B?dmtScW01RWRZWndnVi9aNVlidlFYaENvU1hLZWhLZkxTN0ppbnRzUGhYZmlI?=
 =?utf-8?B?WDhrdVhUdmRIenc5YlVWLzhMWHMyd1JIRUlHd3JUcjRYU2xCb3N4S1pNVnl1?=
 =?utf-8?B?Tkc2dTN0aVFSM1UyZ09pbjk1UFF0QzFJeE1EalZSejd1aG1Ma0hwMEV2RGFi?=
 =?utf-8?B?MndLZFJ2blJFZHlBZGxVNWpwVTV5SGVaWnoyNEc0OExISmdWMWhqQ3k4SUM4?=
 =?utf-8?B?UlRQT051ZTI5SVhDSGFrSVljZFBDUk8vOGFrVm81ZGhUR2FiVG92MFZvRTVQ?=
 =?utf-8?B?UFBjRnZGRDZoNUJEcUFZektmL3ZMcDY1a1FJZGFlQ0JrOUVmbjNGUjJBTmlo?=
 =?utf-8?B?S1BWTXdJWW9FeTJFTEJpdVZ3YjlzY1F2NGR0d3owMHJXUUh6dWpEUGlVaEZr?=
 =?utf-8?B?Vm5najZRVmFKZFdIWUpIWC9JZTRpUTBIL2VhOUQwY0xJOE9MbWlPekhnZDVP?=
 =?utf-8?B?aFAydEkraWtCYkNkWldXNzRFdGVyL25ORE9NSVlpNDU1YWZ4Ymh0Sk9POVdm?=
 =?utf-8?B?aWh5SEprYVB2c0orVSsyaEdjKzFvSXRnVnRJajZ5NHp1WDlyL2ZvdXUzMlNY?=
 =?utf-8?B?UWVSV2tWaldVbFpWY092aWRrN3RrcDczUC9TTmM2bWc5aThSUjhzZW81VGxJ?=
 =?utf-8?B?ejFQSlp5eGZEbUtISXE5d2VVR3VOZDZCczdwTGVlOFJnM3dHVGM3bkNNYmFQ?=
 =?utf-8?B?N0tFNDVjWmExWkVHV3ZuMThrM0UxWU02MFZ3UncyWkRRVXk5SFN4dGxrbVpO?=
 =?utf-8?B?eUQ3N3Z5UzZkQkdVbmpBWTNLVjMvdWZTOXRkd0ZxTmhsNlg2Nm10MHNXL0wz?=
 =?utf-8?B?NjRTUFVtN0o4bEtlMGlYclpLNThnWFV0WHVmYzJBOHBxQWZ3MGFPRytySTYv?=
 =?utf-8?B?cUhDSFdGU25SYytlRVIycEM0RDNvNUtJS0VXNGZmallHTHFNaGFVcnQrNWxa?=
 =?utf-8?B?eHlVTi9TV0Zkak81Snk1aXJFVDB5UEs2MkxFSU5yZUFnWXdlbWNCZE13N2dM?=
 =?utf-8?B?V0JaZ0I5OG81YVFaR0ptNTdxbkxzSURhQXFFbVl5bGdaVmp0aVhCUWd6SVFT?=
 =?utf-8?B?T3FEL1Robzg5RXJCcVBVTWNmTGNPMkFZQXVaRDlmYmo4QmJYV0plOWhnbFAr?=
 =?utf-8?B?b3NJS3Vld1JwaHY5aWxtNDdyZTlJR3pMZnNCVTRTZ3VKM0gyRWVlQjJhVGxa?=
 =?utf-8?B?QmlHYXBpamJVbzdQMm9iaWpRelhxb3o5VzYweXFVMEcyYWszbmppWVM3Z3l4?=
 =?utf-8?B?WitvYThzdVYwRldXT2tobnJaUWpybXgzcXh6NkZ5cno3Ymh3QS9PTWRWK0pV?=
 =?utf-8?B?MGdtYVYyUFF6bDd0ZFpBakd1MlNuS2NDUkl2RGZ2cEtCTWlvNVl4V1NpMXo3?=
 =?utf-8?B?b1VlQzJhd1VJaFk4Qm0yMC94YXRvZmtNRVBpcEFFS2dEQVlyb0JLclZVTVFY?=
 =?utf-8?B?L284bFY0bFRwRnl5RFJaOSt5b2JaRzBxZ3VMcmN1bzFQZjJleis3VHZTNWF6?=
 =?utf-8?B?bmJaaUNEVlQ3cWlvdS9JK2RMTHFyV3puVVkvZW0yNnNEaXZNNUFIVXB6dFFQ?=
 =?utf-8?B?eCtrQXY4YmptM2RlNVoyRkVRanUwY29pZlJXUUdhUVM0Z2ZFbjZnMTJZSXhl?=
 =?utf-8?B?QjVmdFIrOHptaDdpaUQvbndVajFDRC9PZ1lTMmxPY2pMS2pML0JnSDl2VE9F?=
 =?utf-8?Q?tWg+PgIIizu+Pnx+559Lpk5ye?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce57831d-b6db-468e-2a1b-08dd387508de
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2025 10:35:46.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLskvIPNqIKwVyWqpM6MMLdSJzyySoXwxxtOtuG8KYku1xgPRLu0vLtN0rwAYW2U2x8szR4hW72CG4ZUrsRcJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7405
X-OriginatorOrg: intel.com

On 2025/1/19 04:32, Nicolin Chen wrote:
> On Sat, Jan 18, 2025 at 04:23:22PM +0800, Yi Liu wrote:
>> On 2025/1/11 11:32, Nicolin Chen wrote:
>>> "attach_handle" was added exclusively for the iommufd_fault_iopf_handler()
>>> used by IOPF/PRI use cases, along with the "fault_data". Now, the iommufd
>>> version of sw_msi function will resue the attach_handle and fault_data for
>>> a non-fault case.
>>>
>>> Move the attach_handle part out of the fault.c file to make it generic for
>>> all cases. Simplify the remaining fault specific routine to attach/detach.
>>
>> I guess you can send it separately since both of our series need it. :)
> 
> Jason, would you like to take this patch separately? I can send
> it prior to two big series for a quick review after rc1. It'll
> likely impact the vEVENTQ series too.
> 
>>> +static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>>> +				      struct iommufd_device *idev)
>>> +{
>>> +	struct iommufd_attach_handle *handle;
>>> +	int rc;
>>> +
>>> +	if (hwpt->fault) {
>>> +		rc = iommufd_fault_domain_attach_dev(hwpt, idev, true);
>>> +		if (rc)
>>> +			return rc;
>>> +	}
>>> +
>>> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>>> +	if (!handle) {
>>> +		rc = -ENOMEM;
>>> +		goto out_fault_detach;
>>> +	}
>>> +
>>> +	handle->idev = idev;
>>> +	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
>>> +				       &handle->handle);
>>> +	if (rc)
>>> +		goto out_free_handle;
>>> +
>>> +	return 0;
>>> +
>>> +out_free_handle:
>>> +	kfree(handle);
>>> +	handle = NULL;
>>> +out_fault_detach:
>>> +	if (hwpt->fault)
>>> +		iommufd_fault_domain_detach_dev(hwpt, idev, handle, true);
>>> +	return rc;
>>> +}
> 
> Here the revert path passes in a handle=NULL..

aha. got it. Perhaps we can allocate handle first. In the below thread, it
is possible that a failed domain may have pending PRIs, it would require
the caller to call the auto response. Although, we are likely to swap the
order, but it is nice to have for the caller to do it.

https://lore.kernel.org/linux-iommu/f685daca-081a-4ede-b1e1-559009fa9ebc@intel.com/

-- 
Regards,
Yi Liu


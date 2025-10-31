Return-Path: <linux-kselftest+bounces-44485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B3C2336B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14017189B9C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F30F284883;
	Fri, 31 Oct 2025 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKD/zKBF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17926E14C;
	Fri, 31 Oct 2025 03:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882785; cv=fail; b=jYfnTyyFsETaZLJa0OrUDspItC1cgHO+0+VZVjrx7fdBbalLq8DTVqSsM6ieCNUQxYQ9S9IraLGxcq0uJCPig0ldlmBAVCED1GNeW123CObO30bNHFqpv48l8VV+CWiOWxn1+RqLCvj7WisaMHriy7+O4OoDaNxf3UFttM3DDmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882785; c=relaxed/simple;
	bh=4dm90on7BRpCCM5BXC39NWDpfyGshBFSAVU7gC0oqik=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cG59i7RF5PNWZTQdg1PzI88S1itL5B5lVetKYtoEYmeozIDGqOz9GfyfbH2Lufzpg/JCgKI1bjW7aEdvZfOAD/GzbD6x44ucfS19Lns9OmoV747Y/tuwK8wgbUsRCzUibUTofANKVmL7/c3g8AOMud+6VdExf9pMgsVlzrBCHB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKD/zKBF; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761882784; x=1793418784;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4dm90on7BRpCCM5BXC39NWDpfyGshBFSAVU7gC0oqik=;
  b=DKD/zKBFQeUhDRGUoWbPpxFyU4Yf8Gyn7IJ0o+w+3G7n+2q9fhbzY6VN
   8bDY8ozxBaf/QDYjZHtaICpyecatKj9GnIu2LYbQhgb10GqRO+NjHo+87
   4fVxohC+4ow+1ene8bFB3Eek6+3rozOGVx4gZ6Vn9+YZBm+z5GyqbhCRp
   o0jOC7Rq4onjfQHkeeLv83mB7ozW7SFOruOLahJmLnrZGoO8FYIgEj5hi
   7jBlV8AVdv7PsxINkDMppK7HYX9fi3mqQN3jtxC/Q2o6GrbIoTcvSgiU0
   sGy8jIqIz5bMkeS8MTv6lBWwekr5EQiZL8ZKgZRVYRHG/IIe2opFswzso
   g==;
X-CSE-ConnectionGUID: 2dZpV2roTbu8eDQv7RrlZA==
X-CSE-MsgGUID: tHReHkIXS5ioE0UN194+yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74330366"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="74330366"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:52:59 -0700
X-CSE-ConnectionGUID: 30t7+c9BQoqUAO2zZcqUFg==
X-CSE-MsgGUID: 7XVGBG4NT0ylYGqHOmYtaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="191276477"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:53:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:52:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 20:52:59 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:52:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HB/g56JAmm1sWJgvZ3f5nlWDxv2Q4k33c6ds7QgU3G3RtD/j7a7x/bvX4mZlWWUrVkL+TvEH57UY/lQeL1aIiEN1eaAu7iywoSJ/hCNBhn7cloKyadXn6g0K4ZcHdoNUuF/osHQykVEcy8SRwPcAcoBG3uNuCytUhX4jF5oJ+6jrfgYLvd4i6xwaKvEKs33IaYE1gs+HlPxkIsicPkedjBMUWe7qLHbPJ7XjTZuuc2GoU+RLFOGd6g4IMDW85wbuBk7nkTX47BCrlZMlR12c4nWtd18BC69489z2qXnrpif01kf23ExXebRRnSOSkNblmYh4WlTx41YvkxkhBVMpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9gLjqkfx8FvaIIXJF2bo94U+uczi+TAgD8Q38DlIyg=;
 b=WhIe1guEbz3M1LwEWOpCsNJG4O/yHqV8g6wEkxp81dhW+RSmPI9XXK3hQ5M8adZ6TqdZ7G0JfTImfhmVfs10bGryx5oyggy/hC2ezf2h2B/6r5hAmEop9s5gFVYTzwBxw4SfLT/XOXB0vndZ5xT5fAo9G+w3McM1EICWAtEnc7VnWAJEuUEY7XaUInQe1PNZ8bhmx7QRzOIsa8sIuCCVaqelG2UGwTuRgvB2KvggcJGrosV7MlK+OQNwtKQR22/mvmgriBt5Awo4Ofcp4erQ8uBJkJ/vEK96wY5m9HE8EOZahIxWlrRYgZThXKBI1g8suEcmM8/hSHKqH7izsstl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7641.namprd11.prod.outlook.com (2603:10b6:510:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:52:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 03:52:51 +0000
Message-ID: <b0516341-bce2-41c6-ac43-0d5181bc8af2@intel.com>
Date: Thu, 30 Oct 2025 20:52:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/23] KVM: selftests: Expose function to allocate
 guest vCPU stack
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-5-sagis@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251028212052.200523-5-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:303:85::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fbbb78-d592-4412-ba00-08de1830f6c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnIxZWU4RHdKT0swdHg0Q2Zkdm5kYTRvNU1Gbm1CWHhNcWdzclJBYzN1bWVY?=
 =?utf-8?B?aWZuVXpObXhHOVRZWUU4ZXY3b1Fkb2hEZ2R1Slc3dG84QWxEcFdlR3NDeENz?=
 =?utf-8?B?S2krY1hNQk9nNGxvTWRZU0p4MUpRalE3T3NmNit5RFo4QW85eGVXRENVc3Jz?=
 =?utf-8?B?bDNLOFFaazNJU04rSXlVTFJPQ3ZEQytyRCtCSytvS1pwL2JaUE1mSW1seEpF?=
 =?utf-8?B?c2dWdDhkcHIwTzMxVmRSZk9TTzF4N0F1K08ranJreUNMd1Z5dVdOMk1aSzR6?=
 =?utf-8?B?QUdtTVY3bStBcCt3WXRFZHNnRGFTeEhXaGFQcFFabER1L1BEYXl1MmVpZXBT?=
 =?utf-8?B?OEI4VkVxVE4zMEJielB4R0dZeUhkREF3MzBmM1BPMjBnWnNVeEsySVNlUXFW?=
 =?utf-8?B?emN5bDY3LzRDTzFxYU0vaVJuK2xCRTFYUGVLRHg2Q1dQbFdCUzdVeWYyRnZk?=
 =?utf-8?B?Mi9FdFlFL2dNaHF5bVFqY3M2S1BKSEJMQ1BlbWRzcjlUM0FUUXI2bTJwanlv?=
 =?utf-8?B?NElNOXpaRTFlbzUzOGh2U09XM0FLQXhQUUdNQ1l4MWdXRmV1OHVCcmZ1VVJE?=
 =?utf-8?B?bkU2Mng5R0h0dmFEdE5mQ2VGc1ZvV01iTkFSQ0NyeWZXMDRRNys4YkwvNmtu?=
 =?utf-8?B?c0MrN0tDRGJNS09mZCs3Z3J3b0x4dDk0WWkvenZVWDNCa2dGZFBia2tuUnJs?=
 =?utf-8?B?eGZCc0Jud1lhaTFLWFI3SXdVQzNJVG80cjlSSjlteHc0L0FNZXVlM3ZubHpp?=
 =?utf-8?B?bGdOVHZIRFJXeEwybGFMQmRVWmZ4bCtsN1ZtanJzcWFmSmhRV3BCWEQ4bkli?=
 =?utf-8?B?WWJkYVFSK2djQ0MyKzBhMjYvblkwVmN3M2RuSjBhZUpPbVQ4M3hXczRzQi9v?=
 =?utf-8?B?M1gvZWVIQ3J5R1hwZitEZXRBSTNCdm9hekpRUFptSG1xeGtQY3B4MHRyNDVo?=
 =?utf-8?B?K1V4ZTNJd0MyWE9vV3NqeWVUVUxrMllWdjMwbXlSZW9zcUJmdTVDdkpvbnFP?=
 =?utf-8?B?YkNBNnUrcmRYYjNLenp2dnh5U1ZnVnlMR2VLWXg2SzROdlRDM0hkMVRtYTc1?=
 =?utf-8?B?YzFrM3p1QTE1S0dib1dpS0VFaFFNRkpuMU5iQnQ1YXY5ZzVuVll3MFkvTzRX?=
 =?utf-8?B?bUFCWGhQeVJVNUJBbTE0M1NGR3lkUEpIRHFENzA0MVdHY1dNOFl2M2s2S09O?=
 =?utf-8?B?TGtrRFN5U3J3WWRnQVp6SDhtOHVtWEhYbTJJdWI5T3BFcHJVdnNrN0NjSWJi?=
 =?utf-8?B?UlRiNzdxdFBsWTczc0xWU1hUU29QNWtqWHUwM2VidFBJSWhjTWNyZDZkRTdD?=
 =?utf-8?B?MFF1MGk1bGc2aHk2Wk9aYldZbzJRMFAvV0JzN0d2c1IvZXdTOVlhQUREZlR2?=
 =?utf-8?B?am1pUUxnQ3pGR0dLY2E2Znd0MWNTeFE3MHFjM2VXOUg3RUx2UUo5a0xINHox?=
 =?utf-8?B?OTdKY2orenBQLzRFWURnR1JjL1JxYjlLd0kzSDhaUFRnZVg1cyt6RHJMSkY5?=
 =?utf-8?B?Q3EvMWFWc1lVMUJIVk5tOGZDTlQxalc5a0hmUzF5U1BZT3MxNllSTENvVFdq?=
 =?utf-8?B?RW1yWFVZbTBBU2dWUUE4WTVNdTNaa3RBa3EwQkN4N1lGcjZTaXVBV01TaHRW?=
 =?utf-8?B?TzI1Q0Z1SVpBaENHZEtjNy83dStvakFHeFFqUm9UWi92akExRXE5aFl0V3JB?=
 =?utf-8?B?QXFqeXV5SUkwRnROcU4zS1dMdEt5aHFPaS83NFZrbi9Pak9nbFZoc1dNUmJw?=
 =?utf-8?B?OXVqeU1WSWVOV3o5Mk9JWU02R0lUejU1NlF0MXJvUHlBK1hweHhmVVJPYk1j?=
 =?utf-8?B?UkkwRGFWd2hDZFE4SjBNdzEzT0Z1Zm54Q0JNVTJldU5qOVBIamZoalJYaHJi?=
 =?utf-8?B?dnZDbDVpK213S2FoMXdQMDNpSGJZWHJYQVNrQXNlQzJBeVpqYVd5U09NM2dj?=
 =?utf-8?B?VnFhZ0dMUVlqL3hVTEJnS1VjMVExZThGNEoyVzE5UXBGQkhPMmpvWVRCZkVN?=
 =?utf-8?B?dGRHcTJXdWxmSWtqRnRCWjR2Vlh3Vm95ZVJYT0U3NEVwa2V3MXAvbmZVT3Ji?=
 =?utf-8?Q?bxKQBl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHkyU0RWUHU2TUZleTFJREw4cmdEQkwvNVhSY0o3V24yeG5TQThiTmFXNkVV?=
 =?utf-8?B?QzZXSEhnS1VjTlludmVNSDAwbkJwMDlwYTNxWjgxZWpqN1lWYmFDRnl4UFE3?=
 =?utf-8?B?WjJZNU9YdE95Z3ViRTdUYWVZQ1dydkhGZmdIbVBITTNPZFpQNDFTK2NIbzV2?=
 =?utf-8?B?a05MRXVEaHlFbWR6Y2JDOCtuYkZTS0s4VEtGcWZQaG5kSy9JNHl0NVdEWjg3?=
 =?utf-8?B?TGlLK1pRQmhEUkhUZEJnUUkzQ3NBWFRyVS9Lem1PbmhhdzlYT1pCdnhyZ1h5?=
 =?utf-8?B?U250WkVmRCtCR3lRRzdyVkdzR0laR0gwUHI4b2ZUVmFnaVhFYkVQcmE1QkxR?=
 =?utf-8?B?UTNoTjJiSTdBRnFiU3VyZ3hUaVlCKzhzSWNVVysvcEI2YXBsYlVCMWhPUHAz?=
 =?utf-8?B?ZlRpZXh0bmJxd1J3RnBseEhHZWF6dTQzdSs2eVBveDJQUUliTEMvcTQyMVJu?=
 =?utf-8?B?bnl3VGtlN2NwbHFMS3IvWjJpdnMwWVczMjB3clVzejhjUVd5WFZaRUt4THVW?=
 =?utf-8?B?VWo5VkNWb282NU9nQWRhaHc4QlkxZFZlblI2MDhUNkw3dSt0SGg2RFY5cllT?=
 =?utf-8?B?OXh1WG1vWUdRMFlKL0tCQm9Jb2NvVy9jYTM5bDFoVUtCcjJtUTRPcHJvVUZn?=
 =?utf-8?B?TzFLWmdZdXV1bUdIblJHZDRGWUFwK1ZaaHJMUUZ1dHZFdVpqeWtHbi9TUFlW?=
 =?utf-8?B?aTJ0MDF3RGRtM1RvVmk0VUZNVU50KzNJQ2hjbG51QStVQzZZR0JrazQ5akpa?=
 =?utf-8?B?Z0ZSKzNQOVg5cXhjZzFrelVlTi8yK3RQTlJKRWxCNmJVV0NGSSszV25xdmd5?=
 =?utf-8?B?WUVEdWg3emFkdTQ2RFR4UXV0cGFKclFERHpYR24wRytCc2xEQ0NsNFB5UTVN?=
 =?utf-8?B?aUdUKzcrdzJLNFBYQW5JSGphdmFOTk1WcVlNckZscHkrYUZZWDdvYWJzWU5y?=
 =?utf-8?B?aXVraFNTVmg3Sk15cGtySzk1VlhyTVRDODBlbUtGNHlhR1hYcFV6aTdLTWpi?=
 =?utf-8?B?VjVSRjBmYW5ZK1N2aGtSajhiRzZCTzA2dlVzK0JsTVV0SzFsSVRXTkhTTWR3?=
 =?utf-8?B?aFpkTUc0ZmdSSWpSTWFBcW95VVlwdkRJOWkxN01GcDVwbmw0RlhLUktnTnZQ?=
 =?utf-8?B?OG5pUGRpcVExbmdIUkJ3SGJoc2VoeFRRcGF1QklMYmRoelhsWDdST2JzcjF3?=
 =?utf-8?B?cmdwenZ4MWd1NzNGeVhCSFo4UThjbGhNeTgrQXdOb21CcEU4OHA3eGVDNkJ1?=
 =?utf-8?B?R1REYkVFU0ttNVg1QUhKbU03N0VaWnJBb2M0ZlNDcjZwQnFnUWY1OWtSaG9l?=
 =?utf-8?B?RHdlVzVGNkNHUE9HQVV3RGY1NFZ6OVNQUmtwQWVIcEZQeC9RcWl6aG1zZFla?=
 =?utf-8?B?UUU2YisvWEJQcFFqb3VtT2FhOHpaa2U4UHR4QjI1M0sweUJoMnhZYnMrSCts?=
 =?utf-8?B?WmRYS096YTh2czM1L1d2amI5ZEU4V2R5UW5IdG5OY2lMSU8wcXovWWwvOVE0?=
 =?utf-8?B?QjVTSzhQSjJBdmM2TC9lcGYzWmdRaGlvc04vM1d5OHJYc2lxVTBMaHdkNzlD?=
 =?utf-8?B?UURCTmkycFRCbEk1SXBLc3djbXM5eWxiUndpcFhjUzFoaEpOT080M2NFVjJG?=
 =?utf-8?B?QXZiUzRXcEVxRTRkTHdsbGxJR2hmT1RyZytmLzlLSlQ5SmdROVYwMHRObGE1?=
 =?utf-8?B?OVUyNVZsdkkwSGc4eWtPcmZoOGl0Z0VobHVNVzllU09CNHloaFY3SzB1VTNW?=
 =?utf-8?B?M1NSV3lPZCs1MUx1V3ZnUE1iZktLbXpmZm9sNUhkdGdUZmYxUGFrR1BmUlRD?=
 =?utf-8?B?MkxWSTRsZUxTNXlFenB6YVJ6ZWhtQXVZQ0hzUUFMK2dINzdCUEpCenRFSkhI?=
 =?utf-8?B?MXcvRjVabks2TlJxMVVzcXJyLzhlMERmRUI0eGdBSlhMYmliWGUyaDJ5MkMy?=
 =?utf-8?B?dUt5czlJOHdxQ25hZFROa3VGbmRMb2R5ZzI4Q2ttNkJMeTE0SkVyY0NTc2tj?=
 =?utf-8?B?OWpsV3JmZGVyNzBTMWxRUGx6cjlrZ1NBOXM0SExkcU4zbk1UazJXSUUyOTFn?=
 =?utf-8?B?ZGRCUmliY3NUUVExeWpJYVNHWFY0Zk0vMlkxNWJ2SWhTWVl1T2d3R3FuOTdz?=
 =?utf-8?B?bUxDa2tsZ0tucVFYbDFnLzQ1RGFsb3JRUHFRRi9wY1Exbm1Jak04aE5SeG9z?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fbbb78-d592-4412-ba00-08de1830f6c0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:52:51.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6CZjDNJL4gdveuhJqTMqic8SPUEQRSa+oAGR+8MxNQH7JcB7yrO84FSmPppULvyFix6JddgW/qodM6X7o7f9nyRtbhvSewxXdnEMNMAJnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7641
X-OriginatorOrg: intel.com

Hi Sagi,

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> TDX guests' registers cannot be initialized directly using

Previous patch used the term "TDX VMs". It will make the changelogs easier to
read if the same terms are used consistently.

> vcpu_regs_set(), hence the stack pointer needs to be initialized by
> the guest itself, running boot code beginning at the reset vector.

Sean highlighted in https://lore.kernel.org/lkml/aQN0Qg24tMQ9ckUT@google.com/
that the changelog requirements for selftests should follow
Documentation/process/maintainer-kvm-x86.rst. This means that the changelogs
should start with a short description of the change followed by the context
and problem description (if needed).

> 
> Expose the function to allocate the guest stack so that TDX
> initialization code can allocate it itself and skip the allocation in
> vm_arch_vcpu_add() in that case.

TDX still allocates the stack in vm_arch_vcpu_add() though, no?

Perhaps something like below (caveat is that KVM style is new to me
also so consider this a draft):

	Introduce kvm_allocate_vcpu_stack() to allocate a vCPU's stack
	in preparation for TDX to allocate a vCPU's stack and initialize
	its stack pointer.

	TDX VMs' registers are protected state and cannot be initialized
	using the KVM_SET_REGS ioctl() that is used for normal VMs. A TDX
	vCPU's stack address will be a property of the TDX specific boot code
	that initializes the vCPUs' stack pointers at boot. 

> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/include/x86/processor.h        |  2 ++
>  tools/testing/selftests/kvm/lib/x86/processor.c  | 16 +++++++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 9caeb3de7df6..dba2b3d558d1 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -1120,6 +1120,8 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
>  	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
>  }
>  
> +vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm);
> +
>  uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
>  int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t msr_value);
>  
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 2d1544e8af6c..2898fe4f6de4 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -693,12 +693,9 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
>  	vcpu_regs_set(vcpu, &regs);
>  }
>  
> -struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> +vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
>  {
> -	struct kvm_mp_state mp_state;
> -	struct kvm_regs regs;
>  	vm_vaddr_t stack_vaddr;
> -	struct kvm_vcpu *vcpu;
>  
>  	stack_vaddr = __vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
>  				       DEFAULT_GUEST_STACK_VADDR_MIN,
> @@ -719,6 +716,15 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>  		    "__vm_vaddr_alloc() did not provide a page-aligned address");
>  	stack_vaddr -= 8;
>  
> +	return stack_vaddr;
> +}
> +
> +struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> +{
> +	struct kvm_mp_state mp_state;
> +	struct kvm_regs regs;
> +	struct kvm_vcpu *vcpu;

Even though the original code did not do so I'd propose these declarations be in
reverse fir order.

> +
>  	vcpu = __vm_vcpu_add(vm, vcpu_id);
>  	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
>  	vcpu_init_sregs(vm, vcpu);
> @@ -727,7 +733,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>  	/* Setup guest general purpose registers */
>  	vcpu_regs_get(vcpu, &regs);
>  	regs.rflags = regs.rflags | 0x2;
> -	regs.rsp = stack_vaddr;
> +	regs.rsp = kvm_allocate_vcpu_stack(vm);
>  	vcpu_regs_set(vcpu, &regs);
>  
>  	/* Setup the MP state */

Reinette


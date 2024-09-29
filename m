Return-Path: <linux-kselftest+bounces-18543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F24989365
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 09:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD4C281D8F
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 07:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE213AD39;
	Sun, 29 Sep 2024 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpJGNPFE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF013AD29;
	Sun, 29 Sep 2024 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594125; cv=fail; b=uITxg7d9Ro8R8qLAj/+jYfZUtnkROmjMgEvaoqShRYs6pJxKUYpHY+L6Y2CLgbN/d8/pPJUyaCX0dQidOSI5tIo6vhoadbztYelse5P7h2eO8Al9pkmq7Dx6FbyXIiSq0gQHzdUjv7ftf4Y7XX1f1e6RKiu9007UNJc7iHYstbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594125; c=relaxed/simple;
	bh=xPj6k2HHBKtgaJw85H0Y9u3X+QrWeEsd8n6vCZGOjzo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QwKTOGyWQj9rYx1xUrlH47hRzhzL5ngcUKyVGIyz8kaQOJ8Hb3zcyUWeoX2MXQrkiThPA6H4nghXhyQUJAS1Xgt82pqtVQZAcnkjeRlJ2DGsznyVROv3cz7/SUYG2tkG2Q9PP+/cqSqK1yunzp17h/CGf6jcOYiGoFeixkspvtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpJGNPFE; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727594124; x=1759130124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xPj6k2HHBKtgaJw85H0Y9u3X+QrWeEsd8n6vCZGOjzo=;
  b=gpJGNPFEwvr+ddJQac/MCZzs9g+8Fs/JMh2pbXmaGNYQm+UUj8VhC6Bz
   nRtheqc5nRepq7ROAtd7xtdq3hPailLC2eN0eC/iT16lP4uq9H4HTy6bc
   g7TYt+LucyVymn5rYNAemn1P36nV2SwcaAY4cN08Ly6L0R9LRQEcBDgcP
   i2U0+ThUIgcjA+fTnNWLPHtHSZ+SFK0To6mlRqDp5L2+khMAqpPs+eD1h
   ugnIJvo47hJqCsb8uHzpWilloPGwgSqd/eKH30ZMDBN16m07Ic5X/8EDD
   AbAoknsY2uVUnP6E/mXb8a0ID6M0t/dO9EQoxru9/IED3hU3K860Qg2pu
   Q==;
X-CSE-ConnectionGUID: Kmi8EWulQny7CIKuQc4IoA==
X-CSE-MsgGUID: MgZwSemATtWF1QKN1im5RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="44215843"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="44215843"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 00:15:14 -0700
X-CSE-ConnectionGUID: +Xgx6ENMRtqMv9sJm91Teg==
X-CSE-MsgGUID: vl2d0+wHR9e36tpAyumknw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="96293958"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 00:15:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 00:15:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 00:15:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 00:15:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpAk9ExR1laiEE+DFAAaVZ78nruU4vUAlUVcex9lO8D2my0OnDq2EDnPiC6Gn+nL+NFaf0HyKkGS4BfkPmaMdAonl/fT89OMC7Ia+E04G5+WayWyPAXba6zicKFs+LEg4nkO+O4mvLFgBn4e4v45LnK5mm9c0b8rCIo/PJL1Q0zcTm2oNPoiUjaii83+/wjBVhcoHfbI0O/ZgntLQPnZov14GI/X3gNRnWfT/QYyqVZ8AP+gB5leVzU39G69BQbjN18ymAACfZ6xIK/oQMsNrPgn6B2M0Y13CjlDG889HIFAiUh4AEzBQIv0Hr15G9T5jPSjxFi1RsGYLbkA1+hBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZBTq7KJgR+5AIolEQ6Y5mXjQXlxeHS1wc7eaX49Vt4=;
 b=hNXInB5rGMvph61aYWmI1FdiD5q0FB6WxtnvoJM3C5FO+h7UjJ4cm+GPJq2hnPG6mgfL33wzDeORME36CjPN1h+WkDx1vYHBtIagOpcuv1rK/TIHTxS2FBiR8SCBh4kspdYbFygrAJF9edyUkz0bCCNK5OQ2OqYfY5U/ihCY2jeeeeeDEWqnSQ67VkFz0Z1GrPpiK+wdGAq40E+seGjhZ1+6bqE3TN2dLoC0KVZ3PRQKEFtwh0sTBD7BM+fCQfr1PTQ9pbIH1O1MC9C9uRXCTjYG4SNtofUVy2oURVmF3mVg/UNyS1O3747pLLbgPoPyDUkRKUFof6H15DojcVg5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN0PR11MB6060.namprd11.prod.outlook.com (2603:10b6:208:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 07:15:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 07:15:10 +0000
Message-ID: <d5fe4c4d-fde9-4d25-a580-0dae63c62ba9@intel.com>
Date: Sun, 29 Sep 2024 15:19:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
 <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
 <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
 <ZvZRapZlAsEGDIge@Asurada-Nvidia>
 <8440cd72-ced6-4887-b724-ce6a1650db13@intel.com>
 <20240927122051.GY9417@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240927122051.GY9417@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN0PR11MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 34392e37-728e-40c8-d97f-08dce056746f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjVqekpBd0N2M29DZjYyL25WekFacHpLZUxsbHU1Ylh2bGh0cGF6dXI3Qll3?=
 =?utf-8?B?Q3YzeUx4VlplVzRBRE4ycUNYR1hNZ1BaT0JVaktBWnZhajY0SkdNT1NUYXI0?=
 =?utf-8?B?MjV6cG92UHlOT2dGQXdKQ1NMY2ZFd3NQRmluWVl0Ujg3eFNSWjFLcXBpZ1pQ?=
 =?utf-8?B?dGVkY2VRT0xMd2YwbVJsYXYwL3dzeEZjay94cGk5WTNzNVZNZUFKZVRtbEVj?=
 =?utf-8?B?RkRaVytwMnh6amtiaTcrMkFpM1Z4a2EwRjMwdEp6MDI0V1ZFL2diaDNGSEJk?=
 =?utf-8?B?MEdWQmhyNHIrbW1YOWJRQy9Nc1ZvbHdCVnlwTWRUYVp1eWg4dlk5dmkwdmdN?=
 =?utf-8?B?eHl0R2w5RVBlaThrMVdOQ0pHb21yNUNtVDRMWVFaUkZwMVc4eVNFaVcwQ1ly?=
 =?utf-8?B?ZG1lcFZ3b0tJRUR2bUVtVWRiQ3hURG91SXliM2l1TENhZUNrb3ZFTVpLQUFJ?=
 =?utf-8?B?d3dCMUpMcVV1SmRBRWswZGcxUVFadGdVN3IrdkdnR3hrTFROOHR0ejkxeDdn?=
 =?utf-8?B?Y0lxTE1yeEJZUENESlVuVnNiZTFRNzUxV0dLS0RjUU0xcE9ZczBrU0luL0U2?=
 =?utf-8?B?OE9MSzhaYUVpa2RMSVMvQkVRS0xVTVBUOFg3NkthTmpUVmo5Rm1aMEU4bDI2?=
 =?utf-8?B?Rm8wVjdCZTN6bmYreHNjQzJhbDRjWlh6L1RKZ2pRa1I2cGRUTmQxdmRpTjVD?=
 =?utf-8?B?RlU2cWtka2dGeTh6ZGJ3ZkFsSGxqOEM5VzZlRm9hUGh4R2JxTVVjMVJ6OW5v?=
 =?utf-8?B?bHJxOTZoTjFuQTlCYWlsWUJWMks5QnN3ZzlOc1p1SUVnQm9DT3dlY2lVbVRp?=
 =?utf-8?B?T1BKc0ZMajhmT0I3aEkzWmJ0T3JHWElpZXROK050V3d2L21UZmhHVlBTZWRy?=
 =?utf-8?B?ekZoZDVCWVNyK0NhQlNBMWxUOGExeGZqMjdiTXRyRU8zc0RRN3JQb3lwdURZ?=
 =?utf-8?B?NTYwY3Bra1UrMWV1ZVV1VHpQWktzcjdFQXZ0aSs0aDBiSzI4c2lBZEl2cnQr?=
 =?utf-8?B?VzVxTHg4ZUhDdkpYdEluM1pONEpvQTFuaUV3Q1dpRnorNkZ4NVpjeUZna3pl?=
 =?utf-8?B?L1c3Rkt6Z3lQWVFjRWZLdTZHVWtMeGx4aDAwT2MwbU9QaDJjc2lYY0txUGVE?=
 =?utf-8?B?TlZlVE4wQVhWbmw3TlUrc0hYdnEyR2ZEL0VHQkV3RUxiblNrSEFxWjhPS1dt?=
 =?utf-8?B?SFJ5V210Ym9GMWVNZjVuQ1BJa0F5YmZQOGRiWE9zZmIxaDhLQ1hsUzNmM2VV?=
 =?utf-8?B?MC9POE1kRGtUNWpibks3TGRjREQvbk1vUVJkb2pXalJMaDZXTVdXMWlQbUtM?=
 =?utf-8?B?V2lNbXowVElFdTFjK25LVGNycjJOc2FTSlVQY1p6THlIOHJlYStUZGdIWCtv?=
 =?utf-8?B?RHdtTFI1cmI2QzhseEJUODZQMTY2bG95MkJTVi9ZZmNBRkRTSEd6ZkdpL25O?=
 =?utf-8?B?SmU4bXRZVFZjRWx1WHRLVFhNUGFTUkNMRjVPNVNKdzl4VXVrdTFFZ1FHcStF?=
 =?utf-8?B?MTFzWlQ5eW9lWVVTZTB0cURwaWxOWkNBSVFKcTBFbTltUDRZaDRxM2FmaDEv?=
 =?utf-8?B?dGNqRGRUbWdac3JrOExMZHExQnY4WDZ3YitNMlkreU96OGJBcDJjZkgxMXMz?=
 =?utf-8?B?NzR0ckFHUDQ3ZWQ0UklpS2xpVWxvM1Z0S2J6THp1dytLcnBlcHN4U2J3UFhM?=
 =?utf-8?B?ZWdrMjVIaVk3bXJqaG9ETmU0VjY3UEIxZ0NPQXluV3h6V0RUNGpSTEdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZmRExwSFdHWFUyWjJrMVBXRjhxMlRyMlpQT1Z4cWNkcTdiSjZCTU5FT0lI?=
 =?utf-8?B?ZjUvMlZ4dVg0anYxQXpOTmpoaGFXcjl5djF3cEtBbUZqTExKZU52bGRtT0NQ?=
 =?utf-8?B?V0w1bWxza2M1dmt3dGJnQkFINUQ0NUl1eDlNdWQ1NTV4Z1VFeFRJZ1VoTEla?=
 =?utf-8?B?TnU1Z3lpeUQ0eGh6N0JFK2NFYU8wQm1nNlo2VlZMODByNGlDbXFNbm5Id2JU?=
 =?utf-8?B?V3NHV0xHRmhIWkV5SEFETXRPMjNwOGlCZXpONko0R2ZNdEZzRjNuMlFsQmdT?=
 =?utf-8?B?OEtPRGx1dXZJY21XWUV1TE5YeWxkRG5MTlFzbGhBT1hIRllKdjJVc203d0li?=
 =?utf-8?B?NHhQT3hpVWFNdHNJcWU2SE1tZ012MTNoU2FLTHBzNVRCaExsbXYyQm90MTNI?=
 =?utf-8?B?MlZOUU10Tks5d0pNOExtMFFVdFlZd0M0VEwzd1hiamIrRHBScFdWV3dqbjJH?=
 =?utf-8?B?K3g5cEt6SVZKbDJ4YkpHUUQ1M1dHMUNRZm41MTZrSjdtUmNzWGtseFp2SmYy?=
 =?utf-8?B?Q3F5ODYzR21MYVhTM1FkRWpnSUtIdVJweHJkRTN0VnV1cWx0bkZXMENVa3B3?=
 =?utf-8?B?TkhxaFRUV2RFME1QU3VTdjg3WjB1WGF3Zzg1N01tNGRBUHI2RThnYko5NVVN?=
 =?utf-8?B?ak1qSFc1UXBMYWJ1bnRKVGRmZEZ6UjU4bGVEejg4QU5ieUczZ2J0dXlrOGpW?=
 =?utf-8?B?WS9FcG9XMENRNkcrUE5FbjQ3R2FlQXFlL1JBdmVYaE9NY0EzOVVONXBmMkRQ?=
 =?utf-8?B?UFc3bGpwY2JzbEF4WU9HeFJlK2wvQksrYVVGWjcvbkR2ekxIUmNpMkFWdExI?=
 =?utf-8?B?YXZzcC9DQVIvaTZIWXFsQWhaR2RyaDYvc1Y2VmFxM1BNU2dhb1g2Rnl4UGhJ?=
 =?utf-8?B?MWZDZTN3R1Z2SENrUmhNZVFHMTZ3Ky9CckJhUG05S0JqV3RRTkZpRnV4SU93?=
 =?utf-8?B?NnZuVGprVHVrc2hxVndQcHF2WWNGN05DYTkxSWtiajF2dzgrS1NpcnJJcGYy?=
 =?utf-8?B?WHZ2N0Ztb3liYXJnRDB3V1BmS1NrUzN1NzBWT0xIalBjSHZneTA2Z3lNS3Ji?=
 =?utf-8?B?ekRpMjNDSnJpU3p2eHN3VG9JR1VpZXBVY05QYW5wMDVjZG9SajNHeHNYb2dW?=
 =?utf-8?B?bEdnMG9kQnhLMGFXdXpqOTQydm9tbzc0clRScGs0cmhsdGpFekppSVlBZ0kw?=
 =?utf-8?B?WHFkenpYaklFWVpnOGtScHhjdGZXVXZCaGZncW9tbmdscXdEL21COUpuZ1RX?=
 =?utf-8?B?S2d3NHNjdmlRdUtVejBET2Fpc3p4NDA5SVBaK0c0WjgwVHFhS0ZGb0pXQmJG?=
 =?utf-8?B?cE9ZbXB5WVV1MEREZEcwcmVoSjRPSTJ4SHJHTlVRSHg5NjNHdGgxMHNVQnhV?=
 =?utf-8?B?UFZJc3pEcTdXMVY5MkFzMWJNeDdQZzhzZmRFeW5WNnU4R0JKKzVkRGdlMys2?=
 =?utf-8?B?VzFsOXFESmk3dm1ySzB2OXhRU2l3c0ZMbHBDL0VrUnBwRjgvMjg0di9aN2RN?=
 =?utf-8?B?NytzTkNLTktKazRxSU9TcjZqaVFPQ0RlNmJsRmZjZm1VZVVxSkYxaG5VSGNY?=
 =?utf-8?B?MGdYL0VjZmpjNUx1OXhuSEE1TGM0S2JjRFIxOWFqditQTkRyUUhWem1CMjBB?=
 =?utf-8?B?UFZKVmU5QU1UYng3azZNZkd5UXM5Z0Q4dGt1VjJIbVpVcmRnRGVEcU5vd2Qr?=
 =?utf-8?B?TGo5SUVmRmR3eGJvN1ZJenJYZUtYMGZZSkhuakJPemZUUzNiUWFZV0ZLSGxy?=
 =?utf-8?B?bGQwUmtQUDdwbHRvelFhRkFjaWpPVmZCTklTSThNclB5am4xSDZRTHg4OHdr?=
 =?utf-8?B?aS9ETjF0b2hiY0ZRT3BvWVJkU3pwYzFQR2UraTVMclFSN0VxUlpDaFV5dGpF?=
 =?utf-8?B?cHlwU0hva0xpbCtBVTRWTFZrYXp0Q2dqUUN6YW8veVNZVmU3SkoyWFVYZ09w?=
 =?utf-8?B?Nll5UTFTSW5oaG5RUXNOUWZEQ0Z0Y3hMQXVFVmlsZzhYbWtSZDEyWnVkbmdG?=
 =?utf-8?B?N2pucWJwTUZQTGM2NTIzaWtseVJuMDdpbmYwVHVRVDNGQ3BFK1Q1U1FrQWJH?=
 =?utf-8?B?QUlXQmV0ajZwaWJjQVN3c2ZxNmRoTnlZcmUvMWlmM2hOL29CUDQ4TEIxREFV?=
 =?utf-8?Q?cyODn+wLvUHZytU5fYwkCr1Tb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34392e37-728e-40c8-d97f-08dce056746f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 07:15:10.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypFJh3aLPE6RQXvfPnMsR0tSV1Dq/TH63GOyugtrm3o4HJ+XZzmppXcurXP/cVkT667T8pxlla5dgCnf+c3xiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6060
X-OriginatorOrg: intel.com

On 2024/9/27 20:20, Jason Gunthorpe wrote:
> On Fri, Sep 27, 2024 at 08:12:20PM +0800, Yi Liu wrote:
>>> Perhaps calling it a slice sounds more accurate, as I guess all
>>> the confusion comes from the name "vIOMMU" that might be thought
>>> to be a user space object/instance that likely holds all virtual
>>> stuff like stage-1 HWPT or so?
>>
>> yeah. Maybe this confusion partly comes when you start it with the
>> cache invalidation as well. I failed to get why a S2 hwpt needs to
>> be part of the vIOMMU obj at the first glance.
> 
> Both amd and arm have direct to VM queues for the iommu and these
> queues have their DMA translated by the S2.

ok, this explains why the S2 should be part of the vIOMMU obj.

> 
> So their viommu HW concepts come along with a requirement that there
> be a fixed translation for the VM, which we model by attaching a S2
> HWPT to the VIOMMU object which get's linked into the IOMMU HW as
> the translation for the queue memory.

Is the mapping of the S2 be static? or it an be unmapped per userspace?

-- 
Regards,
Yi Liu


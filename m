Return-Path: <linux-kselftest+bounces-12820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4F79187D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 18:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4D51F2423D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 16:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F05118FC8B;
	Wed, 26 Jun 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLS9CXsN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FC118F2EE;
	Wed, 26 Jun 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420370; cv=fail; b=ZrOQqignEmKSNiQ4sGmKRwMoJaGWQNcKmZPwPY5AHwI7/27E2iSsrGt0YXPSeGYhPsoIJ2QXwRK+m4wIh/6bHsjyHwru9ZmSmK1RJyGPDt3EbAZzy+jnh0mIyAkJQZdoGJyGlySCHvHlvIHN/2aAMp08YeOrFaqqQl1txXKkha4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420370; c=relaxed/simple;
	bh=/KpWss3Qken5HHyyywxW3xXGix2HItUz96bHtnaU5wE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RyKaTM5P3WzSjFfe9/3XTsP+ZAsW7eOoU+xJLHv7g6YScDGcWo0/fDbYsDW19S/jnviv1KiySltsg7TF1r7JSSjL5NUmdpvFi59X+IlGhjXYWVJoXWRDnrB3dAXPHTRdrSfv/j40jHxE+1/OouKDYHhwsNy42sfT7g2etAxEJms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLS9CXsN; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719420368; x=1750956368;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/KpWss3Qken5HHyyywxW3xXGix2HItUz96bHtnaU5wE=;
  b=BLS9CXsNn5SpVksktEdoe4DtZ5/YMMKsRubC/9ZeEndlPHjlFj2U8Q/r
   P367FsQ5rQZ4BZ0Vsud8Owgg/GjacncZ7hIf8dMpIs292aRUSF+S9Ssto
   Cemo1UiSKkXqisXn2PPA6GBZevFyCiASDVlFmvQpLVNmq1Re+YO/aOo57
   TCgIG0eKjOQIQz3+cKWxBImI6GRGMWkuZm3cq1QZUXO17YGhjYfTD0nRc
   UIYGlYxwCquy1H8k9DP87/0BA3PhR079YtIJ6Xn4vywvtW+SvfDl24rWE
   NB+IEpVdJnAbsurPG+6XrJTcv0w7S61syc7xamc+AylCoSJ+Znmu5bdue
   g==;
X-CSE-ConnectionGUID: 8FfAbRn8QIee2Sx1iTs5lA==
X-CSE-MsgGUID: /GE3UMhnTyyFqUGP05Zfnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="33961202"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="33961202"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 09:46:08 -0700
X-CSE-ConnectionGUID: VfL05s4QSrqVeBO4fQ02/g==
X-CSE-MsgGUID: +/asmKLYSyqeBVlYRbDXbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="67283956"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 09:46:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 09:46:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 09:46:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 09:46:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 09:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8htTn3TCiou+2gqBG1ePr3JUeV9ltahwNU7HBXgXpdUZd3uNu+fdhttI/d3fDWxeGE3EHV/ZX5OfreD/wgMeAGocxAlDQyIGCRaHgu5Lmvh7ExvdKDZPKkxTGPJao0adTvJG0iNLg3EOom1y1lfwlk39lMm3EwgIYn45PS16gaLTzYonA3Wr+gLskB3XmBVD/uLqUqfRD08riE3HXCaFwxVIV31jZaDSFLsXwFSfSXOZM+bKbBKaxCX6v4Ifl4hpfcbi9Huv0uwqhAc+/1lvTmAzBMS/mCQxT2FjTOMzWp45yFivjE/qyo8nDkNfzmNvawVzdnaioQLy+OP31oztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnYrBIEO6oJH1DgRzsfX+Oq2t27TPFlS7ZrcuLlY2kE=;
 b=oWnMA0LqlyMv8bUTDxmWtF4X0Z4GbZ6EP0mWtTgxu/PXKyTb7Ua78QPyS8UddeRKABgewVGri50mfXVOgkHH4jRMZwvCsNWMSd3NQVsg9EhwoZFOC2Ozz8agWKuQJ64Lax7EFr8s9KqS10jiVb+ok15p0nrT3R5587HbuDbkZpBFAjfH13t9XMRKGW5h9US6QthcldkymL0qwOMUo8gVhuyuLTXLLX6nbxPzQfeoXPbyAxsSv0Xhq+rbqt6DgbrdBP0SHJXKXez41QI3//VojkT/7A0wTf5ulldKvZXLRjtF0VOrxbxcauH1JVnEJ2AazJ7demnz5I9Db/fjLf0G7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Wed, 26 Jun
 2024 16:46:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 16:46:04 +0000
Message-ID: <5bd8e17a-5810-49a2-a07b-88c05ca21af7@intel.com>
Date: Wed, 26 Jun 2024 09:46:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
 <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
 <n2el3evhluilmjhrwgpkkb7ld2g26zhmctxvm77b3ome6u6egf@hym7rnr3h2o7>
 <9b976e89-0320-430f-9f0f-48e25612ec98@intel.com>
 <b5xggwzdvavhqmxpaeisovp3e2xzjjhvkoqcbt6hg3sv3wzh3i@a7qaatwfpbf6>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <b5xggwzdvavhqmxpaeisovp3e2xzjjhvkoqcbt6hg3sv3wzh3i@a7qaatwfpbf6>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: cc16ef0f-9415-4121-8c7d-08dc95ff77c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|1800799022|366014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjNEZ2VwNkRwVFRKbldCTnBGVzRvaExSNDVnY3RtMkhObDMwT0lLMmFMZmYz?=
 =?utf-8?B?TElWWWtmMFhJV0FSUVNhUnRTbG1TNTdMUWEydHZ0UEc0ZnlzOFBHWGErNHFk?=
 =?utf-8?B?OEh6aFhlVUozUDVuc0tmczVDVWovNU1ZVGF1bnc4NWpoNWJCcVpJaGJ5Szhk?=
 =?utf-8?B?MW1mdGhpaXR1RC9iNytxQmVRT2pVNkdzeloxdVB1Y2cwdlBJSTlUVXFrN2h0?=
 =?utf-8?B?dmE2SFhlRkFoQzA4clIvaGN1K2ovUWtmWkxXYmtaZEtGRlJ1SStIZXBKb3lu?=
 =?utf-8?B?NGNrT1FwZHBuK1cyaFFqVzRvWHcxWmF2dmg3aTQxeVVJRXFqWEgvRXpETUJ4?=
 =?utf-8?B?dUdMa3pWY2IrZXkrYkdTZGNnRUZDMjY4dE0xdERlRG1rMXJIZU56QnBkWitH?=
 =?utf-8?B?NUhSV0dkTkRGeXllb0MxOFEwcCsrdHNxdWRrdnYyeWNSWTg2UHl5Mkk3QWU3?=
 =?utf-8?B?VDJ5MmIyZjlsTHo0eXQ4M3JNa2svMmc0NzlaTTgzWWZySFZjTWg3MUsvbDdQ?=
 =?utf-8?B?cXNVM3Q1WFNDR2tlZDBYdTgrclRIbGRUZlk2M0pRcnFFOEc1RjhWRFp4VVVG?=
 =?utf-8?B?QlNaVVZieXNydGRLd1lHNnBYQkoyVDdBU3lwOWlxTERSRnhKOCtXdEIrTXZJ?=
 =?utf-8?B?Vm9PMWhnN3pTTm1GTnlZN0lGcXRpUmkzWEdKWlUwbzVqbjM5NFpKbCtqSm05?=
 =?utf-8?B?MjVZa1lrUEQ2dWFDdmlUcFUrTFFTRGJYY0hrd0hQZytVa200dnhlNW1TQ3Rt?=
 =?utf-8?B?eVpEZXhDMlZCSFl5TGxUZFc0ak1lWElteSt2WUtVbjREaThpZnIvT0NjanNF?=
 =?utf-8?B?SFFTWHZjK21zMXJ2SDUyOTdTUllEYTVrejRDV2lKQVFCaUkrOW9Yb0dscmlt?=
 =?utf-8?B?VlFWYTErTnNsNFVxVVFUajFJQUxUTjB5VUs1bUtFL1JMMUVwZXlNU2Z2SThi?=
 =?utf-8?B?bWN6YVVlVzdZRmlLZ2txMFFuZk1jVkM2eVBqVzJZUTcwUnplc1c1QVMrVTZm?=
 =?utf-8?B?aURsNFhsdmU5Nlc4L1p1eEtobk5BNS9ZSnRRYmw3d0xZYXhwQS9yRnZaUFRv?=
 =?utf-8?B?Y1JxT2s4dFVvVnhiMy8zMFRQODdtbzJyazBVZUVaUUh4a2pmYXlaZlNwSjdZ?=
 =?utf-8?B?VHc1aU5udmFFT0hPcW1oR1Iwbi9KN3ZwRjdxNnB5L0ZpT3ozSzZIdlhFUXBq?=
 =?utf-8?B?aFBLQWlFMmc5TUNpcjNwS0I3Ti90aVVaOXU1d1lnTXVCNlMvQ3JkbGR4Q2hK?=
 =?utf-8?B?ckk4N3pHZEJwdkJvUkdCdldlSXBFWDdoZDB2SXdPMGtKamZkR3R5K3AyVVRs?=
 =?utf-8?B?N09UTEw2bHBFNmhWTFRrcE9Hb0dGMyszdkw5MnM1bFZBWkJRKzh5QVVvRUpt?=
 =?utf-8?B?aHdvb3RkZVhWaERFT1d6WTJzaTl5VXU3bmFVQS9xa0xmeDh2Nm1JWXhudjV1?=
 =?utf-8?B?SllmTTRPdmw3Y252YVRmMERUUEltYnBMZGpHcDUrTWNKYnd5cW4vWlB2azFC?=
 =?utf-8?B?R0ZNdHJNK1BYam84dDlKdFc3Qjl5aWtqVS9xMXpwZGVuak9TanJvZkxUbjN3?=
 =?utf-8?B?K21yUzBBVDJhODg2T29IM1U0a1A1L1hSdHZzK0F2T0x3dDRvLzJxT2VLMGRY?=
 =?utf-8?B?KzBDc3EyeGtBN2RRRDRjSTdST05BaktqZWxITEpsZWtZaW9Ic0lPcXZBN2Yy?=
 =?utf-8?Q?KKFnuEKeZl+0eyuSYv/S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(1800799022)(366014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDc4RkdiV05VSWFSdHJHdHRhMlh0WTVvQWxvZWoyOXh6cUpPa3B4djFuY1JN?=
 =?utf-8?B?UGw0Y2QxZTZ2TFBiL3VxbWNUQzg5RVlUSWdZaGVXOHRXQkdFa2E1VjcwcHFr?=
 =?utf-8?B?emNxSVo4OFo2MVU5MkdQaEprVWlIZDM5SkdSSTh5d00yaFNMK0VoRVR6NW50?=
 =?utf-8?B?d2hFMml1UmkvRHlMTDhZbVNUUTY4aHF3NVRiM3BQYUhNeTFhckk3QWlYVDA4?=
 =?utf-8?B?REUrTkhnMklVNE4rQXhRNVFkalo3VEtIVTMvSit4amcwbk5WZXVIM2Vwcis4?=
 =?utf-8?B?Wm9FdmROZTN2c3BWQnE3a1Zkb2tTaEpXcGxNODFvYUorOWlNdlNJSFJYakpi?=
 =?utf-8?B?dWpWemVkQ0lhbXA3YlJwcEVQRVpIdmp0eDZ3Ni9yVXlFVThta3gwbi9vQkVU?=
 =?utf-8?B?RFFNclhwNzM2MHN4bFNwYkpjTU01MTNISXJONmRtbWdSWVFyTHFrdlZxZFg1?=
 =?utf-8?B?bStnZHJSajloV21UQXN0UmdkQzZOc01KRE95ajRVZDc0Q3NseWMrUWZ3VXFh?=
 =?utf-8?B?d1BJQlhDR2RpaHdZZDgxLytNU29xMjZSTXFRYkdwbm5FV3BCUUl6WTk0ci92?=
 =?utf-8?B?NUpUZm9FcEtkcVFQdVQ4d0JNSDZRRi96NG05bzcvSHNxZ0pMZVdCMUxOUS9v?=
 =?utf-8?B?dTFqaVlIbUMzakU5R2hjbDhFTlZ4cC95NWhsdzB1YTUwajQycStRMFNIY3cw?=
 =?utf-8?B?cy9VcXdqMHdtWUlTMWx6L3NtdkZFbCtrNlM1SDI1eEVFSUp3OWtOVHN1RVRi?=
 =?utf-8?B?Uy90N2crOWl3S0RJQndhV2tSY1FOb0JraXVacis4L2grakFRRGJRYTF5TmFl?=
 =?utf-8?B?OTJyeldqeklUSnBPU0FORUdXRnltaCtVZ05GZmpURFhvajJDZk9QK0ZUSWNu?=
 =?utf-8?B?OHZlUk0rV0NsR1ZTanFLOEZLaUtnOWZBdkpUcXFuRWRJaXBWclNHQytjM0tY?=
 =?utf-8?B?U3RMQVA4S01TL1lNUFVBdVZnVWFNcnUxOEQrTi81SUpqMS9MTFpKWUlLamZH?=
 =?utf-8?B?amlKcnlDU1RGU2VSdnRBaG4vYVpLL3V0dmM1dFFuZk94V0xCM1NrRkI2SllL?=
 =?utf-8?B?aUpielp1RTd0VWtUWTlqM015enRQaXRNeFJGNVYwbWVTUUF4VTMrTkUwUXBh?=
 =?utf-8?B?S2taQXFWWm9YcFN1elBlSkJlZWZOTE1abFFiWktYcUhvS3dLV2NGQlZoT1pj?=
 =?utf-8?B?Wnp2T0w0Q3FPQnh4SzhwNUZlZzFkcnhFNHlBNlBwU3BVVUphZXUzb2tTNWZX?=
 =?utf-8?B?ajBjb0NTZ1NKdzAvMXhhUWE3a2dtZjkxUHNTSXg2M1FNZTQ1R0V6LzVTT0to?=
 =?utf-8?B?VXpRd1ZSRzhEcmVyK3FQdWpNZ2czVFY0UkJDZEw1VTJ6ZDB0WkVRZi9VK0lF?=
 =?utf-8?B?c0lBWjFUWUwrZ2h3TEZnR2k2OUswTnlySVRqZ0E4M2JGMDlzd1pxUjBIOHpa?=
 =?utf-8?B?ci81SUFwQ0Z1NHJmR0UvQU1kUEJOYXZTMHNNYitLUmI1K0hEenY4TlMyVDdl?=
 =?utf-8?B?TjFCSG5pVmM1MWV2YzZ0RUJPVHNjS256ek9DMzQ3SVRPbEVUVWJMTTd5UDA3?=
 =?utf-8?B?VjZ1SGNnZnR2WldUN0g5TlZUeFBWQXB1Vk1JeHJjSkp4Y3VjRk9IWmREN3hx?=
 =?utf-8?B?SXNjalVUMzllNGlLaUdYaUFxeEtiNFhrNFFsM2Z0Lyt6TENRZFpPZ0NYRE40?=
 =?utf-8?B?S2taRmJHWEFtZi94UnlYTEZ2ZDVudE1xNzNiL3NDVFV4OHZ0NnVCRDBVTUtE?=
 =?utf-8?B?OGJOOEovdUIvVmlzYjBKV0lUTjlrUnRnVlFlTTB5NnRrR3VSZnpzRG5uKzlh?=
 =?utf-8?B?c04wT1ZFVHNNQW9SK3ZJWkZNQnBoNW5nenlsekhSUzZCc1AzUlJnSVZIZmgz?=
 =?utf-8?B?aXN0Q1F0UjBRNXZxUXJUZ0xhVGlZeWdyT2MvUVUzZTNVRG8vaVlKMkVEbFMr?=
 =?utf-8?B?SENDR1FQUngyRkxWWFg1ZHNsWnhOL2diV2cwYjBFYXdrMFNKSHJhRVBhSWlD?=
 =?utf-8?B?eStudjFJUG80b1owVllpbmgrQ2NaYllkbmEwY2wyaXNJT0F6bXJPWnIvVnlV?=
 =?utf-8?B?aXc3U09tS0ZWdlhRbjJWYW8wVXEwUm4yTkxBRUQ3c0pFRkM0WEdjemdGQ1Yr?=
 =?utf-8?B?NXV0TVVvTDgzQ2xqSUpLWE4yMlNsV0hIKzFJOGhld3JGNU00d05QTERjek1Y?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc16ef0f-9415-4121-8c7d-08dc95ff77c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 16:46:03.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X35lsgTWNEjd3eYjev7UCfS6n+2gQ1YDa6+mIPFNuZnUNJ5zMxU/uez3NwGMfQV11OgzAbMJSmyhBuBOaNupnArcjL9Pgms/deKuwYsY9f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7895
X-OriginatorOrg: intel.com

Hi Maciej,

On 6/26/24 12:09 AM, Maciej Wieczor-Retman wrote:
> Hello!,
> 
> On 2024-06-25 at 09:28:55 -0700, Reinette Chatre wrote:
>> Hi Maciej,
>>
>> On 6/25/24 4:04 AM, Maciej Wieczor-Retman wrote:
>>> Hello,
>>> sorry it took me so long to get back to this. I prepared the next version with
>>> your comments applied and Tony's replies taken into account.
>>
>> Thank you very much for sticking with this.
>>
>>>
>>> I wanted to briefly discuss this before posting:
>>>
>>> On 2024-05-30 at 16:07:29 -0700, Reinette Chatre wrote:
>>>> On 5/15/24 4:18 AM, Maciej Wieczor-Retman wrote:
>>>>> +		return 1;
>>>>> +	}
>>>>> +
>>>>> +	for (i = 1; i <= MAX_SNC ; i++) {
>>>>> +		if (i * node_cpus >= cache_cpus)
>>>>> +			return i;
>>>>> +	}
>>>>
>>>> This is not obvious to me. From the function comments this seems to address the
>>>> scenarios when CPUs from other nodes are offline. It is not clear to me how
>>>> this loop addresses this. For example, let's say there are four SNC nodes
>>>> associated with a cache and only the node0 CPUs are online. The above would
>>>> detect this as "1", not "4", if I read this right?
>>>>
>>>> I wonder if it may not be easier to just follow what the kernel does
>>>> (in the new version).
>>>> User space can learn the number of online and present CPUs from
>>>> /sys/devices/system/cpu/online and /sys/devices/system/cpu/present
>>>> respectively. A simple string compare of the contents can be used to
>>>> determine if they are identical and a warning can be printed if they are not.
>>>> With a warning when accurate detection cannot be done the simple
>>>> check will do.
>>>>
>>>> Could you please add an informational message indicating how many SNC nodes
>>>> were indeed detected?
>>>
>>> Should the information "how many SNC nodes are detected?" get printed every time
>>> (by which I mean at the end of CMT and MBM tests) or only when we get the error
>>> "SNC enabled but kernel doesn't support it" happens? Of course in the first case
>>> if there is only 1 node detected nothing would be printed to avoid noise.
>>
>> I agree that it is not needed to print something about SNC if it is disabled.
>> hmmm ... so SNC impacts every test but it is only detected by default during CAT
>> and CMT test, with MBA and MBM "detection" only triggered if the test fails?
> 
> Yes, snc_ways() ran before starting CAT and CMT to adjust cache size variable.
> And then after CAT,CMT,MBM and MBA if the return value indicated failure.
> 
>>
>> What if the "SNC detection" is moved to be within run_single_test() but instead of
>> repeating the detection from scratch every time it rather works like get_vendor()
>> where the full detection is only done on first attempt? run_single_test() can detect if
>> SNC is enabled and (if number of SNC nodes > 1) print an informational message
>> that is inherited by all tests.
>> Any test that needs to know the number of SNC nodes can continue to use the
>> same function used for detection (that only does actual detection once).
>>
>> What do you think?
> 
> I think running the detection once at the start and then reusing the results is
> a good idea. You're proposing adding a value (global or passed through all the
> tests) that would get initialized on the first run_single_test()?

I was thinking about a solution similar to get_vendor() that uses a static local
variable. A global variable could work also.

> And then the SNC status (if enabled) + a warning if the detection could be wrong
> (because of the online/present cpus ratio) would happen before the test runs?

I do not think this was part of previous tests, but yes, this is a concern where
a warning would be helpful.

> On the warning placement I think it should be moved out of being printed only on
> failure. I did some experiments using "chcpu" to enable/disable cores and then
> run selftests. They didn't have any problems succeeding even though SNC
> detection detected different mode every time (I added a printf() around the line

I am not surprised here since there has not been much tuning of the CAT test.

> that cache size is modified to show what SNC mode is detected). While I
> understand these tests shouldn't fail since they just use a different portion of
> the cache I think the user should be informed it's not really NUMA aware if the
> detection was wrong:

Seems like there are two warnings to consider:
(a) SNC detection may be wrong.
(b) If SNC is enabled and kernel does not support SNC then the tests may fail.

For (a) I think that it is possible to know when SNC detection may be wrong. A test
similar to the kernel test that compares the "online" and "present" CPUs [1] can
be used. The /sys/devices/system/cpu/online and /sys/devices/system/cpu/present
files are available for this. A simpler way may be to just print a warning if
/sys/devices/system/cpu/offline is not empty and set the number of SNC nodes
to 1. Instead, a new "snc_unreliable" global can be set that can be used
to print additional information during test failure.

I do think that it is fair to print all the SNC details during detection but
I am concerned that those messages will be out of sight during test failures
and I thus do think it is useful to have extra information during test
failure.

Reinette

[1] https://lore.kernel.org/lkml/20240621223859.43471-18-tony.luck@intel.com/


Return-Path: <linux-kselftest+bounces-3642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E283E3AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 22:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6811F25051
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 21:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFFC2421F;
	Fri, 26 Jan 2024 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbW8b0x5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD924219;
	Fri, 26 Jan 2024 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303424; cv=fail; b=iplj7CVE/imlkKAiZTne1xSE6txkIeRDiBjZR+IuBp6eUm13EkwLe+C3hsB9xfuyylhY2bmkBt0wchxS3g6HgqmqZJwih2U6+xX1ULob3KqZZwY0r6QBvxEAg6zvhCrEGk56zZ7cOby4w4y9vK6TLHZuxO92Lz7Mxqh9ie5bW9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303424; c=relaxed/simple;
	bh=Jcs1vKdMfBuyz6Zfo3Kndu6LY5uBbGTjKVDdSheWFiY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vB/F4S8SFgTeSeamvCKsoZKl1x0wFKY9jS15+IEzjMgpwUPU0x8Okoda90B0eUKkghN8nYBOo5O9Kef8cUrp3OJlEb8KeB72dnRW+HzdSnCyJ5Jh5Xbab57cxj0rfHY0g5FP8EqugXbn//hjWyzT3KO9zsu8QA47+yLKnOFT2f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbW8b0x5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706303422; x=1737839422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jcs1vKdMfBuyz6Zfo3Kndu6LY5uBbGTjKVDdSheWFiY=;
  b=QbW8b0x5Zj6DA27oJ7q9N1Ckd8fIsJkx0kxRwjM2N5K/PMHRnzfFwIUZ
   t8SNx4AGeNmztklnmhmz1PqpYYAiZTxc5Rl8qLq5ciu9XS+wB7AnimybE
   /Xhwg3n+bFqw4vdG52EpprEC8ZIuFAYDlT+RjfKDg6TgU+68Sou/GU8ig
   sSS8o8i4hguhMfcfl7mESGmlvvU8jfowj57ySYpndcVmq2JcJz4UwtCJd
   sFEHXAYEnRgBY5aDxqA8XJ60hMyFPMnZfVsiK/3qYiRYK59PC1NdD+gQ9
   aykhDoIKmUeR0bv66i4RLBKfNPAAHf6KyL+1j46ejjTEa/XWR1Rr5s7Ds
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2460148"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2460148"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 13:10:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="35543846"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 13:10:21 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 13:10:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 13:10:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 13:10:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myK+CCD5C5M896MPuaemBD5ZqtQtkVOxZumCD023GkFKn+FawP5EIc6Zhpf39/Lh02q4luLNnw9RRjtJ20CerZOvfuW6c4MHm6oGNZL1joWbThQt710UWbYLRN1sZtPYmzFElvl9t5RKURxfW2znqDIU04zeD2Cn+6So0E9+QmmzxiQabt3pouWtoEuwarVqYSoX/szY40ye46bH66vuxZKWFXEWfJoPwCwYhsmX6UIvoVYH8lKwPuWfBJMQRx2txXZtmIwGkWBK0HM83GnPnEvQy+fnQKZBsxvgXDX4ev0+K0MqKcEflrVWZOebgC9dUtCAR1vOFdB8/wB20mIirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2SSkW/AFHvWOi/7xyqEpXP1hVMfMGFySQzGjsHibg0=;
 b=ChZx04ktcO/Fg/TTx1UD1TmrVmNt+QmFNge8lbpHRzXzvJTKEOh62oITtVmdxKg5I9saKK8HUCeqCZxMYqo69n2eC1BFkVB6C5CepcW8D5ihMxgaQR1kjyi976uizSINSJ+CqgYYpNoobSihV8vhdIZkJoQ8y8ObMNK/SR2keE4STm1zpamWQpao7ZODi1T1V3uLI3zLToBsWR2PR05RFGhFLlUO5t2ER3QNzll2W4yFQi2JyTlWlEgsqCZuo++Jgfjp8YQgP2tQ5pCarbDNEs2+FOeQ8mucwZ/4M3xtSc0xnaKs2BIkTHXZ2P6tAlqk+kYtQ1si9KMqX2wYavMbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 21:10:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 21:10:18 +0000
Message-ID: <db08ba56-ae73-4c70-87fb-aae59e524238@intel.com>
Date: Fri, 26 Jan 2024 13:10:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
 <647fbfd449f8b0e0ad6cfe58bb280ff44ee162b8.1706180726.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <647fbfd449f8b0e0ad6cfe58bb280ff44ee162b8.1706180726.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:303:8e::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: 68975460-4cd7-49f8-1c9e-08dc1eb33325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QIT7IuJImh4EyMHn6Q0LIgNYQU1jMHbcsFVHdiNSBUgSFvnsGQQmdVu0yQFHzf3WUGbmd211nZV0i7wgQwwaTn876JH7N3bKbh01l0JPlRykZGFexyx7eA3gTSvGoLS7+oyBw5N+ccwtVJr+XATqr76gbUDYFnBkV6Swnn5OSNDbklAwCbrBsoewpbM8Qm9/683PS1eP+sZHhVc2XMchPcmt9MsZQtGQJWbp5Lq1PEgi3WywChIk/KmrCsdZQVt8b8a5P/Y6S0jAbq3OqBUIvSVG97/fhiCcKZSi6usaUZex59rthHDyAiFmi77+hcVi/+P++PLL0bD9kLZDAkNURxzCegBJRrftsn2xAf6pHrkoFiWjFo5DLeEe7ecVDMQurz0LuWBDz2UW15dTRPuPxcX0M/Bbax5C4W5tlSsgZq1aj3mSfu1PDWaSeb1NC+hwIVII8YZOx0Hb1bVfZ8eSGBvhMefXqtOxcolPwM6/Eb3W64b3ihKySDO54vvW0gj6o8qEENDPj0bILqHRvsAevavRZz9GaUwV3z4bwtBe0gE6SuJXju7s05PeP6n/ZlrIT237oK6DphSY2KGSOTDSm6Dkka8wHECkgqxBexJvq94dlMTog0EaexwatYDnmDWMqBUQyZP41h6Ydv++vVMaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82960400001)(86362001)(66946007)(316002)(6486002)(66476007)(31696002)(66556008)(966005)(478600001)(38100700002)(44832011)(26005)(2616005)(6506007)(4326008)(8676002)(5660300002)(53546011)(83380400001)(6512007)(8936002)(36756003)(2906002)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVRLc2FTcElwTDFBRHpxWGkydU1NR1RDY3Rudm5MVmVDS3JQWDhMRjhEaFNx?=
 =?utf-8?B?Y1U5blREbFIwYVRCZzVwSGwzOEZ1c0MwaklleEVOT3RBcjVJaGxxM0tXRU5y?=
 =?utf-8?B?Mm9JSURLRFpVaFNvRkVyOE1ERG0rMnhRaDVxdzJXZGhhSEYzUjdPSDB1S05s?=
 =?utf-8?B?UFlIcGNBY2lXUHFOeVBmdUZDbTV5bGdGTnptRTVRUGd2aWc4dkhWMUh5UExZ?=
 =?utf-8?B?STBROG1TSldrZVB1VXhhSmJwS0R4NXZrRTFsbkdTbFpvTVZVb2czc0tkQVZp?=
 =?utf-8?B?ZEJEYWpTM2ZzVGUwcFBmN0FpaG1EQ2hHdDVrbjdyek5kcDFza2o2dUp4QlEx?=
 =?utf-8?B?UTVDejhaWS8zQ1JBWUhkMk44anFQRTJVLzhwUTdGQlRuNlNNbXlMZTJOVVM1?=
 =?utf-8?B?UXg5MytvVnBFbnlVdTBoM2UxS1Q1QXNKYW9veEZ4QkRzTU5oZFRzOTE1MzR0?=
 =?utf-8?B?TnZJdlM1NlJ1c0xzVmlVVWlMVjFJVnVac3UvU1dYOXkralpVbE9kWDV1aXJ3?=
 =?utf-8?B?a0NSaTBWbEkzSlpHOUNRa3UwZ1luWllqL01aaE1PT1N6MTBpWk9ZdUtqZEJx?=
 =?utf-8?B?OWo1TnN0MDZZMFVxNyt4NnRObkduR21xTHVvQklNQmdNa3cyeVg2Y2NGWnp5?=
 =?utf-8?B?b2toaGdESkVNQ1FTS1VJdGR2OEx2RitBSWhHUVAyTHVoMzR5aWZOTnpZUVh6?=
 =?utf-8?B?UEFlSGR5WlZUOEhUMFRQYjZuT2RsL1VLTnBXYVNFR0cxRHA5bS91Q0J0QUNu?=
 =?utf-8?B?RW1Pa1hWUGpUem43Z0FYRndqREo4dWZoYmZjMllhdTl6V1RXTmo2NDdHRkJj?=
 =?utf-8?B?Q2ZKK1ZDWEVmaTlmdHJ5dkFsMkN2OFoxU1pXUU9xcVdyR2NSU2U2aGZkZGdz?=
 =?utf-8?B?dHErWWcxcVRIZlV5WllmZWtCaWRJL3JJMlUxMmVHRm5rbW9vWFp2Rk9McUNi?=
 =?utf-8?B?eTJSd2tQMzczNm9ZRWRtRStOQmpFdWg4bzRFNE9ONHpMYWZTdGM0L2Y2QXp0?=
 =?utf-8?B?MTdIUUJtQm1QTDd1REh3RVBhaitSdFk2VDZoODQrTlFkaEF1RUFTdDl2NzhC?=
 =?utf-8?B?Q0M1bmlRWW9KNjZibHp2d2ZaaEl1TUFzNEE2WFFFdndqM2xDVTlRd2JQbFhl?=
 =?utf-8?B?bkhkMTVrV09FTUZscHgwbUxWSUhjUnZnUC9WV3ZCcEovZjUyNVk5TG12VmZR?=
 =?utf-8?B?RjQwY0wwZi90Yi9hcGMrdDZVL0wzT0ZPSlZsQTZ0QmhmQTdLVGpOZjBOWGdD?=
 =?utf-8?B?QjEzUW5rMGVmYXBuS0liWUJ2bGFDWU5seEYrY1JBWDJUVi9ENndscHYrOWo2?=
 =?utf-8?B?RlRVbGc3U1dtSFpkWDB2QlNnNUVZNlBkQklTSEJKTUs4RjdxMWYwT1pLTk1L?=
 =?utf-8?B?MGFvY1Y0cmplQzZaSFU0UUQwd0g2aWNtZ2p1S1JVZTBVcldmR1kyWHNjVVFV?=
 =?utf-8?B?MitVR2F4SmhSeVhSWjR2bFQ5OEJnU3BQRVI5R3ZPeGx3cUlrcHJ2VXF6Vnlh?=
 =?utf-8?B?NXlSc241K1p4dUVhQ3NFeER3UlFJU0FOS0l0TXdMUTcvc0JBS3JBOTNZSVJ5?=
 =?utf-8?B?S0JrTkF6VlpZdFJQM1d5eHVTV1NWaGJXWnJ0aFNGOWRJeUJSRG8zOTJyRXUy?=
 =?utf-8?B?Z3hSa21LRE9NeEYzcmpsUTgxMm5RUDgzVTB5YURjVC9NUVdrd1FyUXZXaWVO?=
 =?utf-8?B?dmE4a3V5VGIzR3Z6RzdHbGhZOVJtZ2pLUVNNVFhwV1RyZFBjYWpMc1grWVpL?=
 =?utf-8?B?cWU4WVZaTXdMKzgvT0dhSytPSFByc2hFSXAzbUNWcittcjErK1dqQys5a1lQ?=
 =?utf-8?B?d0V5Y0swSjBEd3hzaTc4bjk0WWhTZTh5OVlkZUdMc2pDdDArbHI5RlNZT1BL?=
 =?utf-8?B?b09JUWR6eWpnM1lMVmVzWmN5MTcybVBTT0JqbnNhL1duRldIOXI5K05vQUdD?=
 =?utf-8?B?Ukc4VndFc2RDVnFnaVZrNG1rdUUvaHJhL2VmSlZFS0Y3RmNKZXplNGtNV2tT?=
 =?utf-8?B?dFNObnNGVXpNTDVMKy80UU95VW5DQXZ1bDFMUkNoLzFZanVYbkhDdjEvQUJl?=
 =?utf-8?B?cnpmd210WWxNOE9BZEd3R0pLYk5UNzlUUXRMUnBGVEQ2UWpaYTYrTU9pK2cy?=
 =?utf-8?B?d1ZpTFpPZ1FyUnRVc3VBK0o2RHArT2JOYVV5a2pWSUxFQUJNNVhZVzhxV0Z1?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68975460-4cd7-49f8-1c9e-08dc1eb33325
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 21:10:18.6957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKnBjGLA4iWDPAFL5SbK+KqAf5N4qYqazyfEgCPySOB0dghfCWTjZQVt7SlcBxzX2+rzkj2DTFfJ6Brb6I3zkd7vw7iQB+SEoYYG1Avw4aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

Hi Maciej,

On 1/25/2024 3:13 AM, Maciej Wieczor-Retman wrote:
> Add tests for both L2 and L3 CAT to verify the return values
> generated by writing non-contiguous CBMs don't contradict the
> reported non-contiguous support information.
> 
> Use a logical XOR to confirm return value of write_schemata() and
> non-contiguous CBMs support information match.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v3:
> - Roll back __cpuid_count part. (Reinette)
> - Update function name to read sparse_masks file.
> - Roll back get_cache_level() changes.
> - Add ksft_print_msg() to contiguous schemata write error handling
>   (Reinette).
> 
> Changelog v2:
> - Redo the patch message. (Ilpo)
> - Tidy up __cpuid_count calls. (Ilpo)
> - Remove redundant AND in noncont_mask calculations (Ilpo)
> - Fix bit_center offset.
> - Add newline before function return. (Ilpo)
> - Group non-contiguous tests with CAT tests. (Ilpo)
> - Use a helper for reading sparse_masks file. (Ilpo)
> - Make get_cache_level() available in other source files. (Ilpo)
> 
>  tools/testing/selftests/resctrl/cat_test.c    | 81 +++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +
>  .../testing/selftests/resctrl/resctrl_tests.c |  2 +
>  3 files changed, 85 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 39fc9303b8e8..9086bf359072 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -294,6 +294,71 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>  	return ret;
>  }
>  
> +static int noncont_cat_run_test(const struct resctrl_test *test,
> +				const struct user_params *uparams)
> +{
> +	unsigned long full_cache_mask, cont_mask, noncont_mask;
> +	unsigned int eax, ebx, ecx, edx, ret, sparse_masks;
> +	char schemata[64];
> +	int bit_center;
> +
> +	/* Check to compare sparse_masks content to CPUID output. */
> +	ret = resource_info_unsigned_get(test->resource, "sparse_masks", &sparse_masks);
> +	if (ret)
> +		return ret;
> +
> +	if (!strcmp(test->resource, "L3"))
> +		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> +	else if (!strcmp(test->resource, "L2"))
> +		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> +	else
> +		return -EINVAL;
> +
> +	if (sparse_masks != ((ecx >> 3) & 1)) {
> +		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
> +		return -1;

If I understand correctly this falls into the "test failure" [1] category
and should return 1? ...

> +	}
> +
> +	/* Write checks initialization. */
> +	ret = get_full_cbm(test->resource, &full_cache_mask);
> +	if (ret < 0)
> +		return ret;
> +	bit_center = count_bits(full_cache_mask) / 2;
> +	cont_mask = full_cache_mask >> bit_center;
> +
> +	/* Contiguous mask write check. */
> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
> +	if (ret) {
> +		ksft_print_msg("Write of contiguous CBM failed\n");
> +		return ret;

... although here I think the goal to distinguish between test error and test failure
falls apart since it is not possible to tell within the test if the failure is
because of error in the test or if test failed.

Reinette

[1] https://lore.kernel.org/all/33787043-5823-6de4-4e5c-a24a136ba541@linux.intel.com/



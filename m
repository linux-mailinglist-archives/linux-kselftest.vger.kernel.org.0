Return-Path: <linux-kselftest+bounces-5462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235DA868527
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 01:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7279BB21D45
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 00:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04A17F8;
	Tue, 27 Feb 2024 00:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzVhjTFj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA615CB;
	Tue, 27 Feb 2024 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994957; cv=fail; b=rIAVV6sNNs78Cre13i4iVfxevS/IYXgKRGy46k7jP6XYXWS19gCZS2R07q5H6LKwsG3edkBvQKhJQQmTk/HDh7Go267kOmJE1IGv9SfA8lOTNWU5Pb+RciY/+MaG5hJdOxnyYcG/W84p6sLyXyQcSKbLQGGGbcLBVh2ELRNqsT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994957; c=relaxed/simple;
	bh=T8H7TZBhPvh+WHsKSWp5lFovGTDaKq/z640vtosiytw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mDZPJEhV2y4L09EOJDaUTTn84A1diWTu52oPDvdMoLWOhGLcwWra+cB0Nau6xDTl2cVerX5qIxIwmbT6nwE91E96IG5WWwooUHSgbaDzlFxIUhmPOfnwQ6w+UN3LFPqlNtplS1g/1NJ25I4g5uWXRsqmkTMq5y42aap1np2VhRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzVhjTFj; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708994955; x=1740530955;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T8H7TZBhPvh+WHsKSWp5lFovGTDaKq/z640vtosiytw=;
  b=FzVhjTFjgpANSl6Sj+AQdJNpKvgj9jnkTcAWB7JDPvUAVOa6YvlFY/Xn
   O6Ara4p0QjPtEYqaj9NRcT/m4KlDrZolOsyHISeBxYucJSc7EXgs7Ssul
   rVD9qxddkFJWD2+kPk7iRyX4yo1PCyiuhKEhuN3jbs/lHaHIxcyP2Iy+1
   eeYooVtsCaWPFjCSuoDZtNbBinZSfZTZzap0CsllTVh67N/tzbQA4FrG3
   hyvsykuOF97nLU2z98TkWC63MABwRXaLb74oy9ZZoaTui+sJpZQXEItcb
   iiNOyiJTBvCITlQQWfigiG9X4ZtEgmYZl6uplhNKJ+VsGcoEId8dudONU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3475926"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3475926"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 16:49:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11633330"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 16:49:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 16:49:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 16:49:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 16:49:11 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 16:49:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+PAgGpjkz/X9LiY4C345mAApU8sTIx4pawYTZ45K8uDbrHsa09CdLHyV3p3f88NZpAm6uWxknzO+iC5gw9jOgFWaHcRxRrGFbBvjGeFTYvRKB3kuQ0mFsdNS57t3mxxT3neWXCrOYzlVhnIV5Pob0EAiOSCMPktjW4VWR2yOLz9jQKj7rzL5eQB53/Q2UW2/3/Rv6VcnQCC/sYb/BSVmjacIheIDnjIiaxfyZERkmUO1ZlJB36LtEsrsir6nUnaNN4lXRnlqLPwimdKTwec2wr5zeXSQVt/ubjkJ47mAzmzEr4epjSbOumRCOthp1aDlmeTZ9knj4SN2TG7AdKz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++3u/2IXRpRxtTZGM8lLEQiWwvRkZ8Ngd0FNJtlrz34=;
 b=TTZl24OBNT8Qv+B3MMGrLrmbl2foEBd8jOQ7gQKpf1nlMyqzrRbZk6JTEfFbpYHRCvPyI3yQaX+P1AFn6VJvwh2lb5hMg8hUyz2s2j7YioZovmDj7tpICXzZyI8TFKWGDE4vkQzXVsSCY7/Gd7hKnFfegHzuetqDyFUZt9zuIh+IV4p6bTaI7FBBlTcRYNCt0FacFMweAcDCZL+kN+o4NMs44ONApxdXQPRUOKSCdNOJj7hQHS5N15kYhJmYH+F2Ol0OQUtdtfMbAmWvLpcVDI1vtSNC5BCxJw0CM0D8Ak3wFQ5WfdWAOK21/LnIdqq5dy9h/+wCNPFhLCeIlTS2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5182.namprd11.prod.outlook.com (2603:10b6:a03:2ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Tue, 27 Feb
 2024 00:49:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 00:49:08 +0000
Message-ID: <eaf4ff10-6bf3-4181-8ed0-895fccd2bad4@intel.com>
Date: Mon, 26 Feb 2024 16:49:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] selftests/resctrl: Simplify test cleanup functions
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1708949785.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1708949785.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:303:b7::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: dcef9397-33f0-40d0-feb8-08dc372de7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLpQMv716dfbQNYn/aVTdLhcpWdfpv3MwVwLKFOlMUqc5UgwjiBnu0T0NV1s64QxCXazNqzEmalTeIqaU3/U56J4b/1vb48kGJ+r3dlY6Chl3nZ+GU9Mjjs4Uy81dRMpEQNuN+ZWSLiBn4EQY1IbEhfPKzQh/wJp9DTOt9CvDu7qQzrasU7F+BMux1AY+w+3ZjQYDH+8+FaYSH69i8pivPJULovh4ZYQG0DsLxFtBY8XdcXuJz5pa+KLeBnxaPnJ8SqzCQIgp7t4ohb+NDrPKVFXKRVwKgTypcj+bL28ZyTSEaNzlXauff9wVbhgEyd5f+KqDdE9waz7bBL1v5u2VRGO7dt+JCOE3zkcJWyqtrQSEuH5CCy7iFGbDPDhnJrLt9KDt3MpgXS3J7ctdVMiPs+N/wOsYMJ7M7mTjbIoFrOlawzgS2hqeqA/bIwJ7GxCrglNfmApRldKm0emzFIWXqqTAQ8ccDSGUj3YV1ryLryqi1QQkp71RFdsSEsHYX8GD3zLa7Sxrl3JhT9c5Yo478Eil4aV363d9KAu+MPafWZ9pJtso5CXEn/ChoMX7CawZB667MU9PpBWcXnPV0Q/lOr4t1ucSpFxKmVVGYTmd90OOKYV7nnaqV5h6WkrRygp0eBr/HrVYqWoIv0/HyDmCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nzl0K0RJbEV5MGdwU0ZOWnFoNGZKS0xQZnRFRVE4dWhSZEJZSkEyNE5MTHB3?=
 =?utf-8?B?VW4zK29pbHltY3RKM2ZyNDJySDdQVG52U0JCRnhYbEhUcWhXZ1VzOUVkNEZD?=
 =?utf-8?B?Nks3aHU1ZmFMTWtNUFdvU2FZSE1QOERaUmFuaHl2MzRCamxxNFlUakFsQlM1?=
 =?utf-8?B?ZE95ZGNTc2E3V1JLMTFjdVEyd0xYWkZRdzRoUjVERk1NU055MWRGLzQ1cHRt?=
 =?utf-8?B?TFRtR2RSb0hSbjc3eWErbWt6a1lON3N6REIzaCtiT0NFVElFZk9tMDhObjZD?=
 =?utf-8?B?eFUyYU05Q0ZoaVVoa3J2b3J5TC9EZCtlc0J1Vi9uTGg4M2I4REl5Q1lOTGU5?=
 =?utf-8?B?MDFTVXdIK2FwRFNSY0FpbVI4OThrRjdTUWdZRWdTR2ZDVlBJRmxhb0x2SGF4?=
 =?utf-8?B?UmlsakNhTVBRRjhRK0ZwZ3UyblBmb2wrYVh2UWhiU0xEanFzQWRhL3EzUUE4?=
 =?utf-8?B?bGMvb09NRTloL05LQlZJcXQxelhMN2R1WFAyTnFVWU10RC92Q3JZbEhkTVZI?=
 =?utf-8?B?QU50bElrMjJwOVp5dHV2TTJIWlNPSEVRWFl4Z2lWZ0R6Q2JCUjkwckNodTFp?=
 =?utf-8?B?MjZIRXgwa3V4TXhoWm1Da25EZWtwTmZ6ektEa0ppeUxraHAzM2MreXZpWnd0?=
 =?utf-8?B?RG9sZGNBbjhOcFFucFJxeHgzVWVGUy9zYVAyQ3J5RXloMUlKMmlDWDQwTW9B?=
 =?utf-8?B?UEE1c2N1dWRNa2x0SWFjdDhaeERSTHdmSDkrbTJ4Y2ZhUDY1Ny9zSGprVmNO?=
 =?utf-8?B?aC9ncmpNRjE4K0c4SGVMeERqVVY1RE5FWUU2MERJT2trNGJCRmVaM0p4TERn?=
 =?utf-8?B?UzZRbVBhUGxWNkVKTTBMMjFMbWJNYzg1MUI2cytScjJaVi9BWU5VZC9KMzl4?=
 =?utf-8?B?UCtMek5CNHhlaGtEL1Y2d3BvNkxyQnNQcWJDUTJxWHNzV2ZNZWYreDRWNFZh?=
 =?utf-8?B?TmdGNTNSN1ZmL2JjemUwem1vUFBNTFFVSE1SazY2U0FhdUVyNi8rQ2tLbkZx?=
 =?utf-8?B?dGltUEY0ZTBtb1lXWE1Yd2w4SWNMQW5nSldaQkxtc1hvTm52YzRsZEI2RTZT?=
 =?utf-8?B?dGF6K2xoajFuMnBuV1E3a1pnZVVScGhFdmJuTzU1bTYrRjd3OVE0bVRCaDhh?=
 =?utf-8?B?K2l1d0srWjdveVVPVDRPT0dHcnRtelhRa1NqNXlGNC91TWRrS3RRd2RKQTBD?=
 =?utf-8?B?Q1BKMDJSNWVvNUtFT3JLcXFJRHo3WGtaMGR1c0Mrem10Um4xeGxrYjNuTW1t?=
 =?utf-8?B?WlhEdzZjSEZrNk16RW1DcU8vT0Y3dEpMaGRPWEMxSTFzeGhEdDVFOVl6TWY5?=
 =?utf-8?B?RkFSRHIrQ3FuYjZsakdyU1h1Q0NtMU1OQ1RUT2J3STRqcVhUME1BcmRRK1J3?=
 =?utf-8?B?S3JjNWlGYWJiU2RQSU1zRnFjRUtTTlRQekVDNnJzbjgrQU8wT3FKNFcvVjc2?=
 =?utf-8?B?Vk1YS2FPRnZQUjRQNWU3ZSs5U1JGRUZLL1p0YXNJTXpvbEFKdUZLd3lwcXo4?=
 =?utf-8?B?anNGY2FUdk9ORjF2SGZXM3E5WVY5MTNNeXI1dHFsb2dOVnQ4TUdYNnc0cGR1?=
 =?utf-8?B?QXgvUHNyTXBtMTgya3RjbUNkN2NYUXNMMTJjNTlXZU9nOEpiOWJrUFJRSWZj?=
 =?utf-8?B?cnR1M2NaRnJKbkVicDFIQUNJY1lpMjFtQzhiOUV0eitodnFTOWJFTmJCdjdM?=
 =?utf-8?B?bk9OWXI0a1dxc2RieC9Kc21vTFkyQk9KTGE5VUVxVUR6WXYwWnJocGxPM0pX?=
 =?utf-8?B?dit3dk1KamNhNTk1VVJEZjJJb1hpLytYblFDc0pYRGVtWjNrdWJ3L29pRFpV?=
 =?utf-8?B?eTVmRUFxbHBIcUFUNldKUEl5ZXJsWllnSXNORnJTWVFLdFd3V1hwVjJlRkto?=
 =?utf-8?B?dzJuWjhZWUtvVkRxL0EwSHVRTDNHVndPTkR2WStsbnpHQzZHUmxITWY4ZFp6?=
 =?utf-8?B?VHFsdmpieEZuMUJ0cnFPY2h1c29XeUV1QUJBaTk1ZlVSc0RZTXdGbEFpWkJH?=
 =?utf-8?B?SHMrOUtYNnk5NDZTLzdWN1JsSkFFM0xnRE41dnNwVjZ1MG96Q0JjdmdHQmFS?=
 =?utf-8?B?R0pZam9jWTFpYmdQNVZnaWZLSXhIWHJIR2NQQVdyTitZamRlK1RMc1ZQMU40?=
 =?utf-8?B?anZnSUNEWlp0eVROTHJzLzdEdmhvKzhoVUVoTVlXYlBGWlRtcTBGOXpTOExQ?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcef9397-33f0-40d0-feb8-08dc372de7b3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 00:49:08.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N7nhAMJRdboVdv3QpZVsVC9gISeF/hwWsdIGCUQyaQRG7R5NP7Ccr1HMk9fFgl9HV6CM218w+6CZ4w6BpAUVwEcRvGa5iI6Gv44Nbeyr9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5182
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/26/2024 5:05 AM, Maciej Wieczor-Retman wrote:
> Cleaning up after tests is implemented separately for individual tests
> and called at the end of each test execution. Since these functions are
> very similar and a more generalized test framework was introduced a
> function pointer in the resctrl_test struct can be used to reduce the
> amount of function calls.
> 
> These functions are also all called in the ctrl-c handler because the
> handler isn't aware which test is currently running. Since the handler
> is implemented with a sigaction no function parameters can be passed
> there but information about what test is currently running can be passed
> with a global variable.
> 
> Series applies cleanly on top of kselftests/next.

Could you please rebase again? This series does not apply cleanly when
I tested with latest kselftest/next at
ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")

With this addressed, for the whole series:
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you very much.

Reinette


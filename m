Return-Path: <linux-kselftest+bounces-6775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CBA890B54
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 21:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A241C2244A
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 20:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83204139CEB;
	Thu, 28 Mar 2024 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcDlTKJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC8137751;
	Thu, 28 Mar 2024 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657744; cv=fail; b=pwdZM/ET3vS4auh5Tejbqy54Pi+DR4pIbp9Mv48DIx101p0XDOT2016fo21s3v+AzxiDoN9cRgizhKxLgpGr4nXXTYJWpiQbj1HCvdVJ4QsRy3aiNA/POqVTn3JJ+bpx3cD6CS1kaQNAAsbsD0crAhy78/EKlW7XdIp74PkjQOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657744; c=relaxed/simple;
	bh=98/AuEFA81exRTl7VnGT4byAI+8dfuyecVcWF2jQ/UA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sTh10IiET7td2fW+sE6n5lgwrvNz6O8v1W8hmwoCzFnJFX/mP1mcx29NIbWyOV7/Q3bIyIWH2RWedA8LqrHJJMB6w0nwy73Ol76/EugEWxU45Xfkps5zoXwvOhZJAmR+e25kaiPhcoBKEUsI5cJf+nOR2yPl4MMVItKkC7OrLJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcDlTKJV; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711657742; x=1743193742;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=98/AuEFA81exRTl7VnGT4byAI+8dfuyecVcWF2jQ/UA=;
  b=AcDlTKJVB3nGo2wjYi0nZiQpjUfTKyl0bNmfn0FzRg8S7mVU6zMq4T5z
   RCLsz8qVp9R6GWE/kHkbjAQr6yPyhaNCD9LFeK88iKGy5B99jL+j7rYdX
   xNQKhWtXK5COm2qNMfKDwU6WJfIMtTBg0Q3q8onIrSpTL5bhoVNmID0NL
   NQuZboMrdV2tPVAC6fQjAnVTKhcOskTYm1llw4u9LcbADxUaMgk+Gl3Uu
   E4acWF1eYZYeZmlKKFW2LW9bJmEyiyTkdxJYoOMOOoT2886oyluQNHOu8
   Bd9gTh+RudkSLx9pBlN0sZ/2RVH/R26BK823a3/+tHUV0+ciArN5rS0kp
   g==;
X-CSE-ConnectionGUID: Ya4tPoDXSdig7WZWLw49eQ==
X-CSE-MsgGUID: vIdwThULTDWui/PsXqGrZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="7056004"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="7056004"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 13:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21414338"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 13:28:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 13:28:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 13:28:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 13:28:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrC+P4GBoH75YG6PYuaS48Hg1inglSAcZHSMMEPuD9rMje9YCMtjy9B+7gU1qj2QazcCwIxni8dmixH8aIb5FL/fA7elIkPHgcUMWo5KeLbEpYu4X1Ecs7K6VXzffKahlD/V+VcTPQTbSizK891hRMe2LO0kqS2aAbagySkrrFgfAGjh9MBVrgYlNeRUtPwQyBkvOMzvBGJHKnogJe2L87UVkBAmkl/NSdtQLYKQEdwVJaf+GJNLhC2bK1PGpHz+vlZ0lQkFK3ai3duzzkt/1oiG/Pj67owsQomBirlVA8Us+/+MyQPUs2Xfo0E+QyLwFXMTeEBfgLEdSUPUQ+keHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CSDuJHkiEOTZgq9MCbnIAw3S0ay6bWwdnWHy9pFb/U=;
 b=YBPk/RYipZf2UOHqibPQPhgXkd9ZnQrSUCto4kr7zM3PGcXil7qq6ai2eoeH7maIYN4CdgvVlpmnM49SQCqawKPFLEF4fcIwh4juRtB/9VBvF4QEz07R/vO1UoNiA0x4OlY8S+uG20HMIyghBZ+7aoH2sOvjHjdBq9AUB951ta55jWPZSix3qxP7TmTSiABzp0t46YygtvcW4gckcjmH/xVB/ATmK8zjFcZ4JystngGya8XxxevbeA4j13Iff2akTU2osWJ2RUTKvsA3bcb8MbQiu6s/owXd1E/Aa0PStyvQmKakrKHGhUsM5/bcthp2xH4n8Dh2ROmfo2igRoA8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 20:28:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 20:28:44 +0000
Message-ID: <46211244-08df-4603-bff7-f618a4b1d056@intel.com>
Date: Thu, 28 Mar 2024 13:28:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] selftests/resctrl: Simplify test cleanup functions
To: Shuah Khan <skhan@linuxfoundation.org>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>
References: <cover.1709018050.git.maciej.wieczor-retman@intel.com>
 <ac887a4a-5647-468a-9696-4a3909e42561@intel.com>
 <f7a81e14-7fb9-45bc-9885-383ab7a2e708@intel.com>
 <b5ad9249-8775-40fa-b770-810afdcfb8f7@linuxfoundation.org>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b5ad9249-8775-40fa-b770-810afdcfb8f7@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6622:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qA/WJPRo6V7vSJ6maR+WfgCm5U0wKySwSoeJ26HE1IX1rjKuTuBGuPp9NZpxgVZTfY5+YKbfIdR0b5chSRDepEnL25zPraj/B0ZzgTKmA8XnQ1bpLSIfnDJ0uikCL8QQzPCgGpzwjmjtZcZyvgdOKvKPuEBgrriz+S546eQxv4H9qX28J4azkxed7D6U1gxZTu0BdV5zPbIFObdX1Nfv9MusfDp67qPR/dJFk2rXvq3FUbGTFqt/WR4HO1OEPWX68l3MVokn+98L0DDOpz6HFBno5U7JB2YSOHwTVTyJ5aEab31vkfsnKX4uq3x2kzLIDCSQuTT7YulRklmmQGwu+7jIaJr1VUvrsW38zeepW5sKRolZ0IejOF60xPveGtnpk1INS4M303qWKExuSiCadjUMqqwB9o/a/iiJcUb0jx6ItP5Hhah5KzmNA5PfuKS/888hwfZOupTiBHVbwyc/pnehiHoa0g0d2VTt/bdVOtbpZ83VauILmI8C84C3aUmNb4qJ12JJ1/AWZ+sZ8SZY1u+qX/W8OoNYfUvwt2LwizDfX9WT2mrkWaZKSwpaBe+4NBPMUiWqhKe9kvVaGxojNIhDRGRtwPPIhXDm3x1uCg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkpoV3dVYkhmSWoxNjdwMExKMlp6TEUzbldGcUVQdXRVR1QwbTN6dlQ3b0Ja?=
 =?utf-8?B?TllhVGZuZU9uTFZ6cnVnc2wrVmRWOGVyOHJDQlc3VUZWNm9tMCtYS0pZM3Nx?=
 =?utf-8?B?R3lYSUdGTDNKYnd1TE1aVzZ1L2JnOFRjRzdEbS9qQ3N2Tm1zQnlEdnozRm9B?=
 =?utf-8?B?dUhWejB5U2hMUUV1VlNwdFRDU1E2cEJzRFRlbXZyMWNqRHZtV2J5MGMxUm9E?=
 =?utf-8?B?c2NSR0hoUlMrVUNwMXVFVHVkaUhSeGFmd1ora3ZRdDZRR0gxN1ozR3U0YTlL?=
 =?utf-8?B?L05tVUJoeE9rVVhtL2Q0U1RKU283eURsYTdkWHIzNXpuRzFDRFA2VEIvTWUy?=
 =?utf-8?B?T0pDNEFCVGpCbG9XdVk0VFVjSndNdlZrOU9rZ3cxWDlJbHVUVDN1b3RjT01L?=
 =?utf-8?B?MFBOM281UGRsSER4dFNKUWFGY1UzNjZsNC91aGY5OFNFL1hGK2UySnJMSzh1?=
 =?utf-8?B?MjhNNHpLeUJZN2RydDAvcVBLZGZ1ZnBxbXJ6VmFPalZhZmlod0xOT3U2TXZG?=
 =?utf-8?B?VlJSR29EVDFJaktPZCs3L3ZwS2l2NktlRFdZbEpnc1UwdytqdlpyMXlTTEcz?=
 =?utf-8?B?MUlhQ0tCMTZaeklsdlZMQzNwQkpoS3hrUUhtSXBBNExWcXNvQW1NYzRqWEdS?=
 =?utf-8?B?VEtrRDY3c2FVOEVOMGl6dXhXWlMzNGkvNG9rMm1xWTlnc0l3eVAvS3htejBz?=
 =?utf-8?B?bmw4cTZQaytnaFIzcHR6b0ZYbTdSWkJHTDFwWUpYT3FQMnZ4ZWVpc2c0Q2Yy?=
 =?utf-8?B?UElnVkxUMm14YUo2Y1ZMRFhnLytML3BJbENQTUJQVWVnQ3JCbTRBamtjRDdp?=
 =?utf-8?B?YWdyWklyUjd2TmtzZmV0QTI5SGVMMnJ6NFNXczFSa3J3YU12aklqblp4QTIw?=
 =?utf-8?B?dDFMRFhoYVFvSU15K296QjE2ekhqYUFmM1dDcitJTEFnakQ2SWFrNGRsMXJB?=
 =?utf-8?B?VmxRYmFzNThMQXNqK0ZJS3ZRM1l2eDJpbUFhRnpINDNlOWtVNklLREZvSjRL?=
 =?utf-8?B?c0M3MGRLVHNZS284YXFFUVVaQjNzcHNCaVp2VTJkdWNZcGdwNFV5dXhVUWFK?=
 =?utf-8?B?RGJHTXVPZ2NnWG4xRTV6RnhSSmRNaGc0SUdYNEd4eEZOamEwaWg3SEtIdHZj?=
 =?utf-8?B?bmJQcm5ESEI0U3Bsb0hrK2RJOFFBNnJiTGd5ZGxaQjNqeFhrMnIxTTVyQTln?=
 =?utf-8?B?VnBCUHpEczZoNEVOenE4clVFdnhUVTQrZkpveFJYamswK2pEZkRHT2JYbHcr?=
 =?utf-8?B?RjRlb3dnSXVnVUw5ZEt3UmNsQ2VEUTFrZFBFTE50a25wbXViWWVZR1ZYb09H?=
 =?utf-8?B?YThIU2gwSmdhaTJhYzNMTVZNVFRhTFVKVk5IU3l0UWlXY09WUlhLRXEzMHlV?=
 =?utf-8?B?ZnBRUkM1bmxWOWdaMktQWnVITjRMSzFHQ2t3aUk2TnlsQ2lST0VUZzNYS0py?=
 =?utf-8?B?ckw3czFWbGQ0SzRXcGU1a2k0SDVKNmp6MnByVkM1aFdvK3dVaEkyeVQ2ajFN?=
 =?utf-8?B?THRiUXZneE9VT2djWDZ0N2NFQVRkZVZFalRFR2FzNGlVT09Vc1pRVXA3dC90?=
 =?utf-8?B?bCtTdlExYUFCMHRiOE1RNy8zb3ZHR25NTHBDYjgzbE54ME1Kc3lwenZTdllF?=
 =?utf-8?B?eGN3djdTTWcwQWVadjRTTHdZT3FqQmFKb0JWejZaMk9Kc0hJVjhVeWxiVlN4?=
 =?utf-8?B?R1ViOWNNVXBlOFl5YUR1YVlBRStSUEtZdSs2SGRxeGdXMGJISDBIOU5VbElm?=
 =?utf-8?B?eDRyZzJJMUJpclNTeHFsbE5QT3ZXVHBjL0c5TUkva3kxeS9MM29tNlIyd2NY?=
 =?utf-8?B?S2NPdjBYc20xSnNLcTZyNE1JZlFvdDFYSjdISFpMYnB4VEFicDVDWlNjZWxo?=
 =?utf-8?B?bGZFb3FjZHJQcHZ0MVlBY1orUC9FWlVpVGZ3aWRVTHNLdExla3U3YVlYa3ZL?=
 =?utf-8?B?cUJkNXBBSlZLZTVZajk2WGt4MWRkN3pzblRSc1AxR09Yeit0eUtsMnhEeE1x?=
 =?utf-8?B?MlVKVmc5cWpxTTg5aFdXQml4SG9LVUtiMFVxV1FsV3Q0eVZFL2FTU1pwUlEz?=
 =?utf-8?B?dFJSekoxN3RhcEdXSjN2Slludnd0QVFXQ3dDTUtnVGFRY1dnVmNvZDlqc1h4?=
 =?utf-8?B?V0t6YzNSMFJya3NoZHQvaWhkTWVHWnJmOTFkSEF2SkpKL3BvQjVoczlSZTNH?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 754b18b2-4b79-4fe6-fc50-08dc4f65a9d4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 20:28:44.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXsPjhagCx44BZoE957o/pretjjFtQ7THGWZoXgMUd31NbDr4GUKDDM1fn7ye3YTGnIgiFsePVT5IE6863FmFYKo7qoraHiUQTJEZz1cG+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6622
X-OriginatorOrg: intel.com

Hi Shuah,

On 3/28/2024 12:25 PM, Shuah Khan wrote:
> On 3/27/24 17:08, Reinette Chatre wrote:
>> On 2/27/2024 8:36 AM, Reinette Chatre wrote:

>>> Could you please consider this series for inclusion? I do admit that
>>> there has been a lot of resctrl selftest work recently. This should be
>>> it for a while as new work is still being worked on.
>>>
> 
> No worries about the number of patches. Thank you for the cleanups
> and fixes.
> 
> Looks like there another series in the works :)
> 
>  selftests/resctrl: resctrl_val() related cleanups & improvements

Indeed. There is also a "SNC support for resctrl selftests" [1] being
worked on, but it is waiting on the (not yet upstream) arch/x86 feature
it tests to settle.

> 
> Applied to linux-kselftest next for 6.10-rc1.
> 

Thank you very much.

Reinette


[1] https://lore.kernel.org/lkml/cover.1709721159.git.maciej.wieczor-retman@intel.com/


Return-Path: <linux-kselftest+bounces-10925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91248D4EB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 17:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6F72859C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A171317D8A0;
	Thu, 30 May 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdqAGpjO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F9186E38;
	Thu, 30 May 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081739; cv=fail; b=JxgKK78gIZ8i2TXxjPE1dB9dJ951GxLfD4gTXgJ5/wtt0fzuEOBxhckr6As0mZBJV3hIQPoxM/CN50CdLHx0+CGzeupAQs3D4sZzc/zqDWvfWmG54e4VYuTm2kg6pxN0ERzMfvPHBJuJi4tdDujjlnRd/yllXcZWfUVFg816Yp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081739; c=relaxed/simple;
	bh=KeXaBpPd35lhemUesiJyB501imrA3Q6JGV7gA1ialD4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HTY1BnYpvj9FKRAZXJ36xPkyjXHDtG2dCBJRhgBmYVfSCbLHY5u/jqjFKJmcyN3McHHu3Qxauw0pJ8Bz/Xm+acDRv+jQxjAFJEXyNBwQEmGuPxO9F43imUQYIkCY2funZNryka3tp7eyjvZe0VRPmUZUCiar/EOq/tYd+27eHBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdqAGpjO; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081738; x=1748617738;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KeXaBpPd35lhemUesiJyB501imrA3Q6JGV7gA1ialD4=;
  b=QdqAGpjOPRpnvMEqMR6YquUyh9ABLa1Nn47pqutrn7zSSti2Dn8Zt32Y
   D+pzefFTSmd6MXV83ahuZsryMY41DiHQScEfyJlI57+o2uNe/TIZvCYM5
   MeiiJ0Z+uQD8DwoJH+8gzk3hN/Toj3G9oaR0Pz5pin3UaFkOl47oaN7XD
   QcBS9wcKyBuAluOCB3s2iaW7Q9lD35A4anDDLkEArOxn+hEwtKBe8tq9O
   mzq34akRmiWCEA5JqsRstDGc7OssQRGRDiRg21wCCNap+cQQjanXN7qHA
   eDTOa6qm7PaFkY8QWwYIZWyexv++2QkS+oeuPCChoC15j0EICglOz5hrl
   A==;
X-CSE-ConnectionGUID: 0xR6hS1vTaKrWHJmW1RvGg==
X-CSE-MsgGUID: tU7FFVhuQOODDC9TrgPHZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24695036"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="24695036"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:08:57 -0700
X-CSE-ConnectionGUID: WWYM4ue0TgCZk/ifM2LnrQ==
X-CSE-MsgGUID: 1AxpRTZ1TBCCgqYuWlfO4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="35781766"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 08:08:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 08:08:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 08:08:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 08:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmAIIsLk7or17mZ8rfv6yBgvbYA4J9zvdYdgtDfIhsX5kPJli+krD+GXwI4mkTl3ZwgZmSd5OdP67qKGJ75H1u3C2xKH8cFFGZsNrCbi830XP2ezw3y9oLi4bCX31yhmCwLMGApw362fRkTxraXHUlzdC7w2Oi+U0ckVb/HjSEk4ymY4e4TB1E8vtPsmNjp2JcLse7zSZ0GiOREgoyQQBLbs1Cnj/6u3cIZdgMLq0KXxvIeSaLMNR74PenzSp1EZOaNBWH8aU7TZ8e1NqZdG806hSkEswiNIDYineunxc+QOlWEVvthEGxGbEXNUu4CJoLNFjtCfH8G258nq9Nx74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpziD36+QyB9B5WkGuTLHXpoBOnLdMzDU34ee4TxQVE=;
 b=M7bgT8j5kb0MBo1c3BW+NFXW/rYL7+NQS9FNStg3caIepq2SDF8BQJD8r3uk5kRsZpWf+0yOBw0LXiGVA0S4NlGis0SvTzmubs5vSEoeIQTv3jw5P3BWmtboo4kXpUSesmW2qJWlDd9Xd9QhbV1GD8Ryl6IXF/w5kkP89eVW52oBARwB9P2vHh2AT6IgYUNo/H25Utk+xb5cAdoHMmNUySA/KsT+0uTeP3G02wePnappJEfP8id/TVp7SyIhEGdek5uSOHDP+rFWj1ZBJLOw1g9gwJvHj7rY+NOmjcx+K3Uy2dd/j4CHp4O+T2JKHg5kuPBdiKmFZwrIc5do3/wV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 15:08:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 15:08:54 +0000
Message-ID: <3b0baf88-c9cb-49c0-a6e1-acb581403f52@intel.com>
Date: Thu, 30 May 2024 08:08:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Babu
 Moger" <babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-3-ilpo.jarvinen@linux.intel.com>
 <04d0a5d6-82fa-4cc7-bd80-ee5cbd35f0c3@intel.com>
 <ea0c86b9-ae77-c2d9-b52b-239ae42603e8@linux.intel.com>
 <d8063ee7-1744-45a2-b6b9-506e68106baf@intel.com>
 <b029db88-2e09-0b4a-f46a-84b5e535f178@linux.intel.com>
 <904aa442-9fc5-c6dd-f367-07b197085f7b@linux.intel.com>
 <700e3df4-4e10-4870-a1df-49d4616cbc45@intel.com>
 <0f294d43-e704-d1de-06ee-97bb81ebb9cb@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0f294d43-e704-d1de-06ee-97bb81ebb9cb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:303:2a::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e9ad6f-8fee-4b89-ef43-08dc80ba6bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlNaSFFKTklZZmdmdzE5a3hnWHJldmZQZW9aZE5OVTFuUG12SmtocDF5dTFM?=
 =?utf-8?B?WTRrUG94aC9PMU5sSFdVYUNEejMwQ0xVVXVJS01SWXpTTzhaL2w3L3lvcVFC?=
 =?utf-8?B?MjVmWnFCMnhTbjhkaGlYQVNORllwVGVza2cwS0xza1VvSnFEdjhJcC90WllK?=
 =?utf-8?B?SWlXZjRGYXlONjVOQnlvRUc0OGRGOGE1TTl2ODhQeTNoTHFkVDU3WGp2VXFV?=
 =?utf-8?B?dXJyOVhWVG81ZkdQOXVmS2g5YjFBSmtBMDZoSG9rMk50TnYxZlJRNFhQMXo1?=
 =?utf-8?B?NlgxcG5SVlk5N1ZPTkU1c1I4Q1RPYm1UYzlSQjhxdmM3YW9zREkyL1ZpK0RT?=
 =?utf-8?B?ZnJWQy9aNWEvd1J3UmJGUkVVYUhFR05FbFQycGlJZVBtZUVZK1VVR3lUbDJY?=
 =?utf-8?B?YnEvQnAvK2JWa3FBWW1CYlZnYmZPVHovaCtINEhpT3hRbGJyZS9EZDNsWlR6?=
 =?utf-8?B?SHBxUUdRSmZVTmZSYkhCVWY0U1FDNnF3YjJ0MHM1Yzh2WFJha0hkQTdxb0Z3?=
 =?utf-8?B?cmlSanROZlU4OXBaVmpLbGpyazk3Y3laaXd4UFc1R0QzNmlJQ204M2tIK0p6?=
 =?utf-8?B?b2xJR2R0Ym45a01vd1hTOUEyVDZXRkxLM1BYZEVvUS9ncEFLZDBJbjNpRDNZ?=
 =?utf-8?B?dWpUN1MrNEM4ZWc0UHBXRzZIVmFmNGx4c09NdktUTjVQVFlxamF4TjN5YkFV?=
 =?utf-8?B?dGo5SmhubWJ0L2RXVFBZY1pGSk9COWlqSHdzNXhqd0VlVDU1YW5wV1EzYTNB?=
 =?utf-8?B?cHJ3ck9SZUplaHBNMVh1QS9EY3RSbENzK1lNb1F5a2grZFJ3RjJ6ZXM1Z3VH?=
 =?utf-8?B?OGVYT1U4UkRPZGg5OFFLcHJ5eVBKKzdvbEt3UnZCOW02OHBKYmRaR1JaYWg4?=
 =?utf-8?B?aXAyeTVOWU1OeHZEYzNrQWZmckgyalhUcnk2aW9EMEs0ZWlOd2FkUFBjcTZi?=
 =?utf-8?B?ZDZXQVpyakVGVWY3UkZBRG1oSk14Sk9RWkx4T3RlSkhiUUxmUHMwQWY4Q1Rw?=
 =?utf-8?B?NmhzU1RBS3FkVERtdGpzS2tYeG9ZYmxyejYvbmZtTThyZFRRRTRlRllYMjU0?=
 =?utf-8?B?ZW5sMGsxOUFQeDhjNHpQd0pra3RlM1BQVXh2RHZkL1JzMjhzZ0VDVGprV3hZ?=
 =?utf-8?B?TThqakp1aTU5anp6SWtzN2NOcVVxT0kwcU4yejh4YmthNnhkekZINFRLVHEy?=
 =?utf-8?B?SWFHeFlVV1hLYnRTc0JZYW1rb05aMk5kQkR4eDhwR3hJWnVSb2g5QTk5Y21O?=
 =?utf-8?B?RGprV0s1V1NVS0xPa0hVQ2Y4Nk4vbGRoSzRTVjFicEpzME5WWFQvNngrM1E0?=
 =?utf-8?B?dHdMQ0RBME5PRE1pSTQvRDNaVUg1aFBJaVJFRkR1L2tGQ216b0ZFNGRwM3U3?=
 =?utf-8?B?VXZtUjAwRVByMk1jRU5QQm1wT0dPYllYSWVDcGdsNlRqZWxoSFlBVWMxWnMr?=
 =?utf-8?B?UWhKWkxoY3NjbU5WSWZLZFU1Q2ptc0xOcTg5RVpYRExKL3NQZDRhQlA5V3kx?=
 =?utf-8?B?ZlkvZWVWdzUwNTAxL1p1aGVlNm0xaXM5N3cyRWVubUJMZzRISzg0b3lWbmht?=
 =?utf-8?B?NjM0YjJHSDFGTEtVSnd1bGIzYWoxY2tWMEZKS0RQaTVuUEhVeVdlajJQYzJO?=
 =?utf-8?B?UnkwRFNFSytkSjFNSUtGc242em1IUE1pYklyUHdVNmlwL2FNZS9TRmRieTlD?=
 =?utf-8?B?M1M3RmRBVHk5azNDQUVzVWVxME0vRkFNWjliLzRabHFRT1pub1Z5djd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0VPRjdvdHRqd0I2aldmQkd1MjhqZHdlS1VjY1hCQURWbHN0eUFHNXFwYktJ?=
 =?utf-8?B?V3FkbVZUUytncjVEdUdtSkpENmxIZnRGV1U2anI5T2VTb0xoZXcyWGxKcWF4?=
 =?utf-8?B?NUhyMVJia0IvRXpKRFVQdGpCUEhBR1dDYzJ4QVNBd0M2WDhxcm5xMmUwNzNa?=
 =?utf-8?B?RmxhVzlYbFlZeUt3a05xdk9iTWdjTUV2b3hLNU5ZUUM1Z1I4ajNCUDN0cEE2?=
 =?utf-8?B?aXRla0dCWkM4T3VzQzd2L1JxUUZiZGpOT2tjYUdQUUFuUFRUZDR4YjZJUitT?=
 =?utf-8?B?T3VWUWNoamRzUHRBaUc3U3h0YlcyTXhGblNWazFoZHIvcnJNUllmaXJXeVdq?=
 =?utf-8?B?a1g4K0Q5cjhLMGZIc0FIbm9rbGR3bXhrcXA3aUdwY0cxU082Mk9OZi9MT1dk?=
 =?utf-8?B?aEdJR2kreWhUdStqQzA2S0NCTWszLzhXZlFoSHhyTm1PdGxaSkVmeWtuMmQ0?=
 =?utf-8?B?RmMySEkwUnNlS2VVV2tPcWRxb0RKUmhJNGNYZEtwUyt1OHV0Yk1sOHZLdEI3?=
 =?utf-8?B?QTlwQldLTWp2Qzg1ZWpZNjZheHhjQzFhSDFqSXA3Y0E0WWtoODNiTFduak9W?=
 =?utf-8?B?Vkx3azhEZEFjKzh1YU1TVWdOdXVCOU1LSWFrUUhuR2dEZjlidTNHSk1XVmYx?=
 =?utf-8?B?NEFxb2l1UG9jdGVFRm1Hcm1ldE9QcmsvS1hVQWlYWUdiYnZzcE9kaU5lZ3NP?=
 =?utf-8?B?UjFNUUcxbmZML3JBZHE5ZThnTDdQMWN2MVBkSStQaEpjc0hpc0xTNnp2RkE1?=
 =?utf-8?B?b2YyUkdjMmVyMHFtVS9Wci9QM2l5ZE9xOGFYdDhHcFhqQU4ySEc5S2kxamtB?=
 =?utf-8?B?T3RWcjc3UU5PVUZ3T1U4b0pvbUpHNzVybmo5R0N0dFZacWhJT2dRUWdWOGdH?=
 =?utf-8?B?WjNhMiszZGtycEk5SHprNXhuZXlac1BwZDFvbEhOQ2NBbmVWbE1HVWxubnN6?=
 =?utf-8?B?ZFJ3Q01TN2hKYXRmWWo2QzNIczRDb3llRTZFUXIxWkoya3dudWJ0WUFDQjB5?=
 =?utf-8?B?RkYxdGM2RHNoNndsYnh1Vk05NWVOWUw5dHRrY2lhajczcStHOURxQm41bkF6?=
 =?utf-8?B?UnNzZmhTUHBzc095WGxZZzQ4WUpWN0k2V2NXSS8xYUNUZmtLNkxwY3hRNGFO?=
 =?utf-8?B?RGsxN0hIS0NlalNGbWppbTBhZnFTeHZjakk2SHk1RHlNWlMvYkZOQXFoNGdq?=
 =?utf-8?B?MWkvZmlndG8xalhqV0JmQitXLzFqbHVuUXVjdDVselF1L0MyVzhWU25YUGVK?=
 =?utf-8?B?N1ZqK1I2WVZnSDlFQUZ6TUxTcHh5VFdoc25OSm53T1Z2NWhNSnBEbTdMcWM2?=
 =?utf-8?B?c3ZhZjF6UWNQaThYS1hZYlRPQWUzcXdHY0swZ2VIUGt4a2I0YktsUXlFL3Ix?=
 =?utf-8?B?enhOeTVHTWpDMFBHQ1RCVi9CRU1HYkQxbSs3cUdJK3V1VnJCWjIvZFVGYlU3?=
 =?utf-8?B?Q24rcFVLakw0K2F5djZVWE9RZmttdlFtM0wxbnNjYmlLVXAwa3l0MHNxRUhX?=
 =?utf-8?B?bEsxY3cxZGJTc2E0bjQ3QndRMlM4d20wTGl4Ym5oYUp2T0Fid2dhUU1PajZ3?=
 =?utf-8?B?b0VEWCtudlVDbUVQNGJNcU9JQnVGclduVUU4Zy9xUlF5aENTdVFTeU1IYUVx?=
 =?utf-8?B?RmZhMHRnRThDNm1KdzBHc2FJWkFHUXlqdnZJaEVzSkZrVnhwaTY5WVh0VE1O?=
 =?utf-8?B?VlZPM25HcDUrb0NxOEV6SjJoTWhMNEtia2UvNzBIUElsSi9qTloxK1lpTGkz?=
 =?utf-8?B?TmJjZTF4TFRQdCtrbksvSjh6enRrcVNPSnhKeVhMYmljRFg5ZDJ4dVV1Wits?=
 =?utf-8?B?bTUrU2VtcTVoU1lCSGRnQkppdWRMcUt1a1F2UVE4R2tJcHBvWWxPcVVMbjdI?=
 =?utf-8?B?ZVM1VGVtazhPUHVmZlFsK1FYMmxkVjZWS0ZHM1pvK0JjTVAzcFUzOWZmUjA4?=
 =?utf-8?B?N2ZKdlpHbHNOVm5kZUo0SFdCZ2cyZ1d1MWQwck00M3BGeGs4RHM4NnBCLzJr?=
 =?utf-8?B?cjNJUnFoU21lanVPRFQ4a1BlNFBlbWtHbkNVZUsvMVl0aE5NOVVGWjRiTFdC?=
 =?utf-8?B?YXdYa3FtODdyU1g5V1A5bVlrekI4QXRyUWw3dWo0Zk9rSGNMaDZwbGJQTHVx?=
 =?utf-8?B?cHpqUWNYTnU4cGw2TmMrYkQwWXg2bWVPVzJIYWlzb2Q0YzhCSGdSY05wbGR1?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e9ad6f-8fee-4b89-ef43-08dc80ba6bbf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 15:08:54.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O91OMZK7lrgEXfzRhM+y4fD3UEiRuja4iL8AQFSvWdrPwqvwO+FQyQHqWmmWHCxANx3uyz5iSWyYeuCBvcmXE6W5kz+A1/8tX5J4VXyq1ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/30/24 4:11 AM, Ilpo Järvinen wrote:
> On Tue, 28 May 2024, Reinette Chatre wrote:
>> On 5/28/24 3:19 AM, Ilpo Järvinen wrote:
>>> On Fri, 24 May 2024, Ilpo Järvinen wrote:
>>>> On Fri, 24 May 2024, Reinette Chatre wrote:
>>>>> On 5/24/24 12:57 AM, Ilpo Järvinen wrote:
>>>>>> On Thu, 23 May 2024, Reinette Chatre wrote:

...

>>>>> It is not necessary to open and close the file every time a value needs
>>>>> to be read from it.
>>>
>>> I'm bit unsure where to go with this. While I could change the code to
>>> match what you described, I realized with the two files approach there's
>>> no need to do even review/lseek() call during the measurement. It might
>>> not be very significant compared with the open that was there initially
>>> but it's still extra.
>>
>> We are discussing the resctrl selftests that will accompany the resctrl
>> filesystem in the kernel. When in doubt on how to interact with resctrl users
>> use the selftests as reference. Needing to open and close a resctrl file
>> every time a value needs to be read from it is not the correct guidance.
> 
> That's actually a different goal from the earlier, but I've no problem
> adjusting to it.
> 
> Initially, this open/close() refactoring was made because of another goal
> which was to avoid doing extra syscalls during the test.
> 

It is not clear what you hint at here. Reading twice from an open file
should not be a huge adjustment so it is not clear to me how this results
in a big change to this work. As I understand this does match with original goal
of reducing syscalls since the file need not be opened and closed twice.

Reinette


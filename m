Return-Path: <linux-kselftest+bounces-9417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152248BB356
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380501C22718
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B5F22339;
	Fri,  3 May 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyZfAdi2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71428E11;
	Fri,  3 May 2024 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761452; cv=fail; b=OARubRd4+5yMtaTPzSDNrI0FMZSmg0YbC3V6hKzL7421d2g+IYT3MOJ18VwNZEHdocWf2p4qFQITVWZJMQ9eA1W2T7zI5vzhoS7QLT80Hoyqy20LTiLN/rvmvp3qrf/phRimyjb3Ew4tHz+M9vErMqeMru/QuadKYAnsNU1CYos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761452; c=relaxed/simple;
	bh=T3kJZVOO+Yvn05aFbKx9zjPASPvp7t+Z0ywyTPjKPYU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FYaKmM590rG/rbznuT2kHmf2jBq6IeWssAbBLn4qRh6G+szyVDZm/iEEEzcA2BylJz/V+zHqLJ6qa8sNLX2IZMoZOnGGM7o2OIustdgP5sGVTqxLU47/gikz8JusKrJd9XIaJOt1g1FkmKnwS3BAFK3AZsJG3/dY0QhIsf0O4y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyZfAdi2; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714761450; x=1746297450;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T3kJZVOO+Yvn05aFbKx9zjPASPvp7t+Z0ywyTPjKPYU=;
  b=YyZfAdi2lWaIoKFW7x+cvjRpBfC+vAr3thaVE8ijZ6L+gDZswhQZ8zk8
   RFa1wsM9jkiFF8AUq75VUHhjYkjkeblPQ88/0d5RxKnKVwBWSd00ULwOi
   8av6iZoBRB8GQ11U6sUjQX/BKGH9aSFl+IP5eCkbCeLqQ0KZXykX6NKin
   LAwW6DR8mM4OMsPFWHQ+pxbXpR0V6yTH3Ozt9eGajE+ZvQ8HyPF6Epbtm
   oy2kV+O+wxO3bFVJJWj6XJvVS20ZxgB4SBBaOXGnTYE7QeszykaA33ezD
   NV2XJdg2vs6ZRV0JTgHpIWSyudLp22FNkAD+wIEYIGfDys1voLQVmvCxU
   g==;
X-CSE-ConnectionGUID: CkICkJKYQ5quzrmdMFYqnQ==
X-CSE-MsgGUID: 9Bt2MVhLSueSObwPpODvKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10413173"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10413173"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 11:37:10 -0700
X-CSE-ConnectionGUID: m65U76vcT9Oit1Y4m9jKyA==
X-CSE-MsgGUID: KRIjhbHIQG6aAIXcLTHi5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27633434"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 11:37:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 11:37:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 11:37:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 11:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFJfSY/L0NpmUR+bkB76+JzpbNk7IbWXnYQcWMtNlgcTmbgoADy4TqxY8tsDUP08XAIUaXuukX+4/4v3nhGSVKinRDWyyr6r+jP/sLLj4+xEaJ7ybVj0iagLB6sqwyN4ijs8IGi4IVtKwdxsYNto7r294C4tjVHaZb1spUiYLWjDQmbaY3GtuxKIdiOeeQSXF0iFEPFTMdCqsImjDxGY6Co6cDeEzOPCfwDk3YVxXYUlnvbN6gPI8fIBsX1qzNYVJxPW2BkjoDeTgTgRdgyd4UZ3Nim0B7o2OYRYuhLUT01XO3Bllf0qwWMQBhPe1uoPDW9B6bzZO6pawtsnyg0rOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ikjpaj7zxM4w/aP6gq7JF/cap7MmnSOF8f1jFG509M=;
 b=eR9Dg3D8DZRN2DtHgBomH7ytSNzLO/n3FeVtgaUX22qKef2+yQ2o4veuRy7dQwsNDpwduNuwJgu7Y8cmoaApEq4dmyvllR4tjaXZt3pQ+8lRf50UabAetpCNsdy41rhy6DZIrUCdABe4TC8N9Bk5hJoimpEATQcTTVEQmvth5wUh80ES5jBU91MXei9JLJAzy2vbQQUGLQRRH/sd3rIOOoZZ3FsNevj9h8coYa0iypxTlmDgiDEsz6/EWmGW9C3AvZSaEriYMjL2P4GVgFIUenk+mwHktGMFThX+Bqj+I/RUdxmfPTkysPsJQwu2P/Bo1IVBpAFZOW58R+XIHiOnyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 18:37:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 18:37:07 +0000
Message-ID: <26f3effc-6ea1-4670-a301-76df3a710fa9@intel.com>
Date: Fri, 3 May 2024 11:37:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: John Hubbard <jhubbard@nvidia.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	"Nick Desaulniers" <ndesaulniers@google.com>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20240503023209.80787-1-jhubbard@nvidia.com>
 <793bd068-c3b4-6330-41a4-bea597b1d820@linux.intel.com>
 <f908ba74-86c0-409c-854d-9da5f3917b05@nvidia.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f908ba74-86c0-409c-854d-9da5f3917b05@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 168e06d0-5a05-4230-9a46-08dc6ba00905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Njc3WWl2UkFFbEJPU3MzSDFOd1k4ZWlGNWFwSlc4bWdJb0dyOHRDeXpRZmlU?=
 =?utf-8?B?UWMreURENWdtNmhPWmQxbXJhc29XVGVQTjVud2wyZVludmFHZklOVEgxU2Jv?=
 =?utf-8?B?QjhpUnJLTnBnUjQyNUQybDU2WVo1Zzg4MUdmV1ZISlZ1OG1yUzZUaDlpbGFZ?=
 =?utf-8?B?SUl0SllnQzhZNFIyU3QxUHJUR0xqUDJkOW56RWd2bW9KK2dQcjlybmN2OHhu?=
 =?utf-8?B?R2pSUEtGNTlDYWNmQWZkSWtpYnZ2QmZDM2s4dDNvL3dmRDRxY1BSajE1RlNo?=
 =?utf-8?B?OFh2RW9QQ2pTQnJLdysybEVsZXdnYjBjQ2gySVpGRk9iay9CWm42OE5ybkVF?=
 =?utf-8?B?anlzMkhPWjNINFpvaHR1ZEFyUEJ3enhDNjQ5eU96UWdSbmZIaHVmRlljQXE5?=
 =?utf-8?B?eFc2emQxK0ZxdENPWGIxRTA5QkYvNytNWmxnV05uY0d6MGJWckJISW9ZK0Rv?=
 =?utf-8?B?WDFUZ3ZNU25PeFdLZVZodXN5RkZneDJYVCtlWExNL1JpMDRoTG1Ca0VXbCsz?=
 =?utf-8?B?T2dtOFJRRGwwT0x4UGNCWERPeFQzTFFkMW1LMFdWSFNtSjF4RUFvNDJxVXlB?=
 =?utf-8?B?Ti9UNllhdG5NSFNQY1c2TEFVM09jZm11R2Zla2VRK1hxZlo0aFdyaHRpOUxS?=
 =?utf-8?B?SHlPbUJ3KzRaSU9RZmk1MWgrekw2OC82cGltYmFYNUFocXRlNlNvWjlDWVpz?=
 =?utf-8?B?dUJ4czJFamxYelowTitsMEtrS3FzbnRjdmVXODZMMG9GNTBZZ2xXaWw3UTZn?=
 =?utf-8?B?aVJtWXhTTmJRRkdZSkdNaCtKcHIvbEtPQkdaVERaMUhUQ3JHaFVndzNCUnNQ?=
 =?utf-8?B?bzFyT1lUMTI1MkNsRERmWUlKMHBHSWdHVmRkaytxZVd1Q1ZySmdUT2dMZEQ2?=
 =?utf-8?B?NFFwSmg5RnFoN0FxTjBSOVp6SmR6NnQ5THFHUm5HdlRhK2c5ck9yODA0aFRW?=
 =?utf-8?B?NEFMZ0U4M0tWYlhBY3MwMGN3TGF2SU5XUzFCVE5ja2JMYnEvOWZ4b1lDSmtw?=
 =?utf-8?B?K3puVDBBcWNiSjFUWVAzMEFqMyt6ZnI5d1JFQUxzOEo0ck5NdzF5Z2lEYnhs?=
 =?utf-8?B?L09ZZFdrbTZwVVZxUjR2WUZMRFY5bXZJdnVrcHFQYURlY0FqNDlMR0MvcTJN?=
 =?utf-8?B?RUZOY0pWSHZXQ1IrL1kwVmdzZkZ0VlBHM25PZnFTand6L1FkWU9wZ24yTFJ4?=
 =?utf-8?B?MWMvUEpvNzUzUUdOWWloaXNHaEdmNndocXRXNit4QUxaMzZOdThZMXpOWGZ4?=
 =?utf-8?B?YTFYT2JKY1NJaDJiYjREZmh3QzFrcS9OWThRY0RiVHVybGhvNUY5MGJzd1Ra?=
 =?utf-8?B?VjJsSzkxWlNSdmpFUEtVVDM2VVYrUE1xVk4vOVh1a2xPZG1rRyt3L2NEV2NG?=
 =?utf-8?B?M1VaWXJYaUVTaFdLK25JL05aeUtVTkFIU25yaUJ2WkVuNjB5OHBabE1DYlFu?=
 =?utf-8?B?ZS83bmMzRElWYVRXaWVMdGRDS3gvT0l2Y3VOWVE4UkdCMTVGSHdxYm45NzFT?=
 =?utf-8?B?N2FqTFk3Vm4rZ3FuTEt1VjhiS1phZ1E0SC9LaitZcFZweUY3eEUrc29LVXQ0?=
 =?utf-8?B?cXJlUTl1VURDK1lVZlg2MzFMZXloNEl2SjRFaGU3OXlaLzd1ZlpObUNpUVZq?=
 =?utf-8?B?amZrdE9qbUJyZ1cxNm9SNm9HNlJKWG9CSWZLT1NuMkV2cFRhQnlLZWpmNjFG?=
 =?utf-8?B?UkY1OXRuV1hiaHBkY2ZudFlrZzFiYXVUbnlEVWJWb2tGZHlHbm1GNWRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1ZJK3JFbXVxNGdxaHF5Q0hpWFlCUnQ2QUdqd20vZ0hjNU5QOUV2emQ3Z2xx?=
 =?utf-8?B?cVIwS1RTamI3S2xMbEc4MWtLNFBIZ1R6d1NDSkE1eVo5REsrd29ncXNEOGJy?=
 =?utf-8?B?bFQyMUdMd2lsYVF3dnJmcUtXN3lJbHJjR2tIOEc3YkY5YnE5VDRzMGtpNDFO?=
 =?utf-8?B?ME9QNHNaVklIZ3RoZVMvN2lvVENkdTNGREpRaWRGY1o0SUY2c3BBK3hjYkpj?=
 =?utf-8?B?VWxJcm9jbGJFQ1NMNUhndWpkVmh5OSszcWx6WmpVY0RxaE5WSC9CUlFtMnNh?=
 =?utf-8?B?ZXB3cVFLYjM1eGRsaEUvck9mTkR4UmpqZFNWQWNIWHR3ZE42aHJnd0xRMTNL?=
 =?utf-8?B?OWg5RnZFWFk2TTl2bkhCbWRjQTM3Tm4rSDJiNjQ4czdjNGpLVUIvMWtxWkxq?=
 =?utf-8?B?a2t6U3RCeE9yUjQwSkZiOVQzcjRjZm5DZzZzaHFkZU9yUWxhWWhOV0Vtclow?=
 =?utf-8?B?dG90YWkwNXlKWlIvVjFiNVFMQnhTRTlBVWpBd29QNG9ML0Fyclh2Ym5uTWVT?=
 =?utf-8?B?N2xhYWVjMkljKzhyV3NVNVpqQ05iSGpmQzZVaUlOK1dlZmFLTWhFdFJpMXN1?=
 =?utf-8?B?NEtKV3hDdThRRWJYWEZxVGJUUzFMVnR4SCt4OEtsYmhGQitMd3JrT2oxaG5R?=
 =?utf-8?B?QkRZSVpQdTdpQ1Y4ZVBGblI5K2F3S01waVNyaDAxRHJVVXN0LzR1cENYR3RJ?=
 =?utf-8?B?TTdiS2FzczlsSHlWWk5wUVdzL092RnRldVBvcG9LNXo1ZTVMdDl3a2pWU2w3?=
 =?utf-8?B?VmVxdHh1cUV5RUo3bCtCSXBIdjI3YXdydFNvOWZuS0Zna3Qwdmh0aHZyeUs1?=
 =?utf-8?B?ZllJakU1M2JkSnpmdWFXSk9JZ3A4d0JFRTZRSWU1c0tqMGdGSXoxYVIrQS9k?=
 =?utf-8?B?cnhxWUdlWWlOcVVqWkdNb21Bbm5ldmJQRm1KTUY5bHZPaXNQUjBzUDBTUFdS?=
 =?utf-8?B?OU16TFhaVm5UdzVOUzBsTmZ2MDBFMmVzSkVkTFBjVmpvNWdsaGFvalEzakRy?=
 =?utf-8?B?eDFzNDlGVW9QNEZ4dDErTWNKR1N0YnJTZUZ2SnJGTTZKQTRROVhsaTBhWWdF?=
 =?utf-8?B?SCtoM3BWNCs5WHF4OUJmQ0VCY29JdFVITEFwWGNla3hjbXp2UmtQRWdRWTBO?=
 =?utf-8?B?RnUwb3liS3ZFR1o2WDlSVVl3TE5HNjZPVHVsb2dZcGxUTTd1K1owMElqYWhU?=
 =?utf-8?B?YUR6RTlDaFNQSzFHOTNuYmdjL3hyWTVqdzlUR3JLWU9qNjQ2S056M2JDT0Fn?=
 =?utf-8?B?c0JqdUdtTDZyODIvZXlJYzgwa01ZRDF6d1U2Y3g1aFRYeENKcEZWaHMyMXh4?=
 =?utf-8?B?SHlhQkZCclZFUktrVUZ5bkNEYnNuRXBkQ2I4Vkx3QzN3OHFpZEpOUjAydDlx?=
 =?utf-8?B?M09uUWl4L3krVk5GQytiei80QUpSNFBNOVB2WWU5bGRjenZHWC9NbHFhaFNj?=
 =?utf-8?B?eVNzdlhEUjdJUjRud1BQMjJxWDJhRkZ3N0F6dC9PZHdERzN5blM0bGxSUlVq?=
 =?utf-8?B?WEQyc1B5Y09DSUd5dXBrTkJCSXo4VGo4dVNZblE2RlRwQVZvbDhLZDRueHZY?=
 =?utf-8?B?YkhOcnY2c0trR0EySk5ORDgvUi9hcGFjbXJGV1YyekpSQm9nL2pDb1lGL0hX?=
 =?utf-8?B?REY5UUdTbm51K0FCeUtXTEJVdUE0NGdpUk01dVRqSTRVM0prQUtDTU1YQ0Na?=
 =?utf-8?B?NUdMNUNOZ3FqV09WcWU3YTNWcThubXgycVhqVHIwY0l5dHhvN2tiNllQSVZZ?=
 =?utf-8?B?WFZYbzdpTHlLRzhHRFh1d3AwT3ZBdVdVNHJqaTlOcEdtUk0wRkhmdnhrT3d6?=
 =?utf-8?B?TXZ0V1l3cDBtdi9HamJxL3NheUtFZUNjOURXZk9zbGxkQkJoRFFLRkVvQ0tx?=
 =?utf-8?B?dytiVk83MmpoTXJHVTdwQ213VGNSd1NCSlVWazQ2eWthL0VJMFB3eUppdkF0?=
 =?utf-8?B?K0QxNGxnWTZneFBJRE9mVEVKeHlOdW1jaitUQnZWekgzL2dtUHlRWFM4dFlI?=
 =?utf-8?B?L2hocjBkODRHdlNUcHBINmlzYUYvRUthRldCZ040QVhCL1dKRExOeFlkeFR0?=
 =?utf-8?B?bmcvbnBzaFJvN3k4OG1BY0VrMjhNcndwaVZCOTlDNDRFN01lTFo4anM0RFA0?=
 =?utf-8?B?a2JXUHVuM3ZUdlJ2ZngyUmNoZXBSTGhGQVlMeE1QdDhkZnhPRmN6eDliVzJN?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 168e06d0-5a05-4230-9a46-08dc6ba00905
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 18:37:07.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuUvSU10bEGz/WrzpErr3s5mFppqqXcYSlMxldR8KIy8f8KX33zpHcswFYFzsVzcyrWdKmz8xOvSSCcGz1aVDVHNVn4G/5qwAd0uyh1mEOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com



On 5/3/2024 9:52 AM, John Hubbard wrote:
> On 5/3/24 1:00 AM, Ilpo Järvinen wrote:
>> On Thu, 2 May 2024, John Hubbard wrote:
> ...
>>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>>> index d67ffa3ec63a..c873793d016d 100644
>>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>>> @@ -33,7 +33,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>>>         avg_bw_imc = sum_bw_imc / 4;
>>>       avg_bw_resc = sum_bw_resc / 4;
>>> -    avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>>> +    avg_diff = (float)(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>>>       avg_diff_per = (int)(avg_diff * 100);
>>>         ret = avg_diff_per > MAX_DIFF_PERCENT;
>>
>> But how are these two cases same after your change when you ended up
>> removing taking the absolute value entirely?
> 
> All of the arguments are unsigned integers, so all arithmetic results
> are interpreted as unsigned, so taking the absolute value of that is
> always a no-op.

It does not seem as though clang can see when values have been casted.
I tried to do so explicitly with a:
 	avg_diff = labs((long)avg_bw_resc - avg_bw_imc) / (float)avg_bw_imc;

But that still triggers:
warning: taking the absolute value of unsigned type 'unsigned long' has no effect [-Wabsolute-value]

Looks like we may need to be more explicit types and not rely on casting so much
to make the compiler happy.

Reinette




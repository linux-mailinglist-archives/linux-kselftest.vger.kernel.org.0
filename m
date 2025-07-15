Return-Path: <linux-kselftest+bounces-37330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007A3B0531D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 09:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1E93A8E58
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 07:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2742727E9;
	Tue, 15 Jul 2025 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIinXXow"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943621A0BD6;
	Tue, 15 Jul 2025 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564220; cv=fail; b=SrjDphmxOO29qbOBptbpYVIw3fV8dr8Zbwd7V6kNGWWJ7LrrsUL11DG2OJDEg1FD8XVBTR708M0Y4or7x3twdn7vL32v4JwyongGBLA5yQy++4furZ+zSZUawRr5u4eDurNHiIH9ozo3t1nZVhR+CziAGyy+z6wsKsUJVLMFDE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564220; c=relaxed/simple;
	bh=Ym5rJvbUh8tV8SZfZhhTrfxrxB13UycBgmP3KI922jc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y3566DAacAv16LDnt3EAVJhubrxe2MijWyqCRRrGtQK53Os2+znk9JXV9hWd+Xpy5RrGxQIs6eWvLBk35KauKeWRRRl5BJuUPebe6vm2lD9TjLF4Cy9ZMb8EBKJXB6xe3o2xJde2AijKRFEpDs0utzPR/r2BqMEuf6vE+WEWKos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIinXXow; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752564218; x=1784100218;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ym5rJvbUh8tV8SZfZhhTrfxrxB13UycBgmP3KI922jc=;
  b=eIinXXow3AfhzGM+iMITfhS5UNILF2Tkn7dZ5OX1825gFuZ1VTkehTHn
   i9nKGjBGHtq7rIsIWMBY82U2OiyHfmdsCXMvU+JiC/I/UisJdrDRXnTUK
   YIeYi0JLc7/gl41ryAmaRHG8PWJW2u+7bYJPlLhrdFZKqGPpCUfNeG9lH
   cEmfg6YeMTsJFlgouJUBg6oXaJko/myk4nux22a6WZw+JGWCA2L9Cu1aU
   7YIG86kVmp5dRhye/yDfRfyQHkJhAi/QVy/IjbopdtKa47Y/wJeTb0QTy
   Uwz4IrnOH8+aEqrf7/SKJyhcjsEeIHZ0aDsYVMfDJHAQbG+Oo3KIXOQn3
   A==;
X-CSE-ConnectionGUID: SK77IYk/Q/ClEzyxDuHJ2Q==
X-CSE-MsgGUID: 9huMKHYnRJSPnsj6MsMcJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54626619"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54626619"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:23:37 -0700
X-CSE-ConnectionGUID: HNWzMjJTSx2bDDyovYejCQ==
X-CSE-MsgGUID: z2m6RCExQ0qATcFlZ4Y/iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157252602"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:23:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 00:23:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 00:23:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.60)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 00:23:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqP2fpfGCsrsGxozEcvStPNcidiQOfI7c/EPtDYdyY4r+m1VvK9XyXTh9+/V8lkE0MCa/AtHH6Bv+B7geaXAostd7n5CsrFVo3BevjQAvHXMWMwdL4oV++6wvpBgdQSTr62YCAwH/rwmz3kMxgZ84tHtxvk+lmH/p2bbcM7OuJxhZwvo4roRYXW2T2kc3B9j+JWjgA4FuCdactz1jzOaiN44wIXbmF3w+T9FHBaFbKszP64JtlMhKLU6FALAyG5hPmNQkpAlQ+iqp2MPUzrNgRzXBXd9rKcSgR9RcB2m07QLzYtecSfK9hwEZBdK1vD1yxk4RAI0ZH+MtkMV7LynFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFbH+UQjbI63o5hxS9r6SFOJMcoYuERCBTxcVzzEvd0=;
 b=A2BoU8pPNEdZwD4YsRJAn/1kD24Loy+Yw4cT0QRTdCPQfPISthkoXyrJwDgNdIYFBUNERAxvb14anifHt6gdCpwdpitJNDQfaIPjJKeFGEAO1kAujVXLhpaBLNWi9xjRwCLe3sOioXTamXqLyvDX+XkJjn10GUwnZIGLPoIFDMPmCz5kNjilVFEEOcEMTMuxukBK+hSpvL/XcZuhCx9nBrIDLqugCUdII0FCF3jqaOSN48O2DFP5hyGF9Tm4OddULdVRA2qFeFwQrd/HblCVHwSleS19kRFOYfIpZCd7g0+HEWZg7wOluxgxPtQbKpMaap+7u4Udto4MVhjrrlojHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB7604.namprd11.prod.outlook.com (2603:10b6:806:343::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 07:23:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 07:23:34 +0000
Date: Tue, 15 Jul 2025 15:23:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<kernel-dev@igalia.com>, =?iso-8859-1?Q?Andr=E9?= Almeida
	<andrealmeid@igalia.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 01/15] selftests: kselftest: Create ksft_print_dbg_msg()
Message-ID: <202507150850.fcfc5ecc-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250704-tonyk-robust_test_cleanup-v1-1-c0ff4f24c4e1@igalia.com>
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: a7329c5a-4c25-4768-2887-08ddc37081c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q096UU5FVHA3Q2J6NTFZdFJzV1k5YlR6TXFZM0hPWEVyVTUrU2NUNXMxZUpR?=
 =?utf-8?B?OXczUFlIZFo3MktIazM0VkIxdnVoTURCOGs4aXFYVjJSQklSL3F4ZFk3THRW?=
 =?utf-8?B?M2hTLzZRUS9hOEpjK3Q0WlBxbW96cjNvVll1M1A2NEZKS1lvcXk3ajE4cVUw?=
 =?utf-8?B?U0wzRzJGZGJlVUZWZjRDYWRCT0N5Vnk0elNMSGdDL1RsOGVQRXp2ck0zY2Nn?=
 =?utf-8?B?Tm0xZ1E4RlA2Nmc4ZVBrVkIwSDVGZThzRXJyd3FUTlk4cyt3T3ZUVkFnZTdR?=
 =?utf-8?B?YjVWSW1xMHYwRHZMcVNEanBMZGdSbmo1TEduODBsOFBTdFNpMllhYmpFWkdP?=
 =?utf-8?B?ZmxOTFptTUZnU1huR0lqL2JseGx6QWwrSVFMWlVMc1hZeHRDMFBvaDRPL1hL?=
 =?utf-8?B?ZVQrbTkwZGJMckVsb0l4RUtUZXUrbmdpSFk5bHpjV21rSFFac1FnbzZqWHA3?=
 =?utf-8?B?NHVyWm0yZ1d6ek9YSGk1cTVPS0xHYXZML25sMGx3TFJEOFJKN3I3OFB5anBj?=
 =?utf-8?B?N0NQTEhpaDQvT0I0dzA0T0JOcnBYaFVpV0JmaGN0emtFOGFPUDBycXh2eGEw?=
 =?utf-8?B?dkxZc3RXOGxJQ29xRVBQTHVjNXg4dU5INVhLVkVodnJJMGhDYjh3b09kc1pL?=
 =?utf-8?B?eEhiZlhKT0ZqVUpqMitzWHpnYlROdENXVVUwVFNnUzd1L3lqMmhiWEFCNWY5?=
 =?utf-8?B?T01YdXFsREdSUDJyd0VBUmFNcHNUWWwwYVBXWDBXVUMrRFhFNXVKOVcvOVl6?=
 =?utf-8?B?RzVUem91Tml3eCtna0pRMzYvWXVuY1F5Ty9YQ3g0V3N1K2pPZFFuSnNKWmFw?=
 =?utf-8?B?eFRmcCtFeFh1RUpPazY0K0tjdXc0N244UnVQeUlybk9JdVRxdnNMYzZ2c2hS?=
 =?utf-8?B?bmhnTVRjTlM5RzJ0YUQ1UEtzaHRDZE8rc2xEUnBkcER3VjF1VG03TGliaStp?=
 =?utf-8?B?c09haUw2K05OclRaQ1JzQThZZHlIcG52aFEzdUtMVURoZlNOdENTM2s1SDJX?=
 =?utf-8?B?OXZFQXpTa2t5WmhvQlFNVmtLVExuMXVjSVlNdGIwMU1zMFdlbHRGY0Zwa3Jx?=
 =?utf-8?B?a2JoVmtyYjFBVnc2dTNkdlJmYkZ0WGNQTEQzdS90Mm1LdnRBcFVPbUQwYXEx?=
 =?utf-8?B?eHh2RE9haHVzbUpuN0d2MXVJUVM3SGZFeUhKTGNZbHhiMDl3aGlXN1JBcmlp?=
 =?utf-8?B?bWpmOVQ2a0JTNUVISzBsR2ZCNkdaaWZCSlQ5T3lNWEdtd3BtRnJIOENmZTNs?=
 =?utf-8?B?VzBYc2ptS3c3QXpGc0VoYXNDUzFYYnFMdFdHdlQ3TVl5SE9NZTJRT0JHUGZL?=
 =?utf-8?B?YTQyUlBkenVkTjgyc2lZWDc4OHNhOVFoYklteGlMVWgrSWFyS2xlSjQwSzFC?=
 =?utf-8?B?TXJFM2Y0Ukd5dTJDRkJjMmlLcS9aejNpeFV5emg3amtadFlseWtyMjFUVStr?=
 =?utf-8?B?N2NYU3NISi9XU1FuWnZYblgwaGpCdElGTXZ1ekVjY256c3gydXhuQUYrMTRE?=
 =?utf-8?B?N2JxTTJScUozcUhFSGorUjRqYUxYMXl6ZnA5bk9PbThrS0IzbXg5b1c3RzNo?=
 =?utf-8?B?UjBZdG0rZy96MFJaSHBSQ3BUQTZsZ25PaDVOa1k3cVA4eThMS01hUkFsV3JS?=
 =?utf-8?B?ZFB2UVkyRlRqRlAwQkZmVm0rTTBQYlZVc3J0REI4eG9pYnZVU1ZaY1dtVzU4?=
 =?utf-8?B?TVEyN2ZtSXhzR3JmSVBtY0ZHRjlFdU5sak1NbEdWYUhPQlhJcWRWTzJObis4?=
 =?utf-8?B?dVhUK2c2MUFja0loZUVzM0d6SnBSSENxR3FONVVPRTRaSlhhRWU0NzlDSlF1?=
 =?utf-8?B?bW00YlVtNUhocWFsT1NaejROVnplaVdzL1l3Sk10RDlsNUxlTnpnU0RtK1ht?=
 =?utf-8?Q?zVr8aSVquADGm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2U3R0RnOFZNMXJqMFlWcTlrcUc1c1c2cTZFeEZnOWJ2TVc1Zk42aTBaaVEw?=
 =?utf-8?B?ZWVLcTF3WkRjN3NFSU1Za1g5UlAxQTdQQ296Mk5oMURxNXd0S09SNEtNeDNZ?=
 =?utf-8?B?eG15YlJMWC9rZmlGRlpJNVA4SHRhTC9nakkzQ2lkNUFZVVRoNGtzNnF0NGdz?=
 =?utf-8?B?VHBTaVNKSk91RkdCYi8rZ09TbmlIVnpEZlBVR2Jvckg0N1Brd0NmazA1QkpN?=
 =?utf-8?B?bU5LWlFuSUd0L05ZS1dDazdSTWNBOCsvTXFXNXdkWEdpY21OckVSRG91dFoz?=
 =?utf-8?B?ZkVEbTh0VDV6TnpvdTNkSGhJbW1XSFhiYTRxM2x4aGo3T0RaQTFxWDFReita?=
 =?utf-8?B?T0FBV016QmNBbittajdBNXJxK2k5RjJQZVVVVTRCRWJRbERhQWJOTzFkdjA3?=
 =?utf-8?B?L0p6OHdTNXgybjFCSXJaYXE5M0N4RTIyMVpPSGNpekZzb09QTExaYUR1dzVV?=
 =?utf-8?B?TkE5aWsxamppRnNmeHpCdXpDREZjd3NkNWVhK1FXbnVPSGpzU2JSZjloaHFo?=
 =?utf-8?B?b0Y2V08yYzFpT1ZaK1I4TjkvYlI4eEMyK3d4Y25LOXg1cEJGY3RJMzRiT0Fi?=
 =?utf-8?B?Z2VJdW85Y2hvK0JHWHY3OURmNFlwY2dsTUt5SjV1QjVjVDFaamFLa09VSWNH?=
 =?utf-8?B?b0NFS3ZXT0tYdzgwM2tYNk80eG44YjR2NG0zSW1maUYxSXhXMEhVMXNqeXBD?=
 =?utf-8?B?eEFBZUZNeFYwQWZUb0phdm9NZ2pjVDFsNHZTYzZhS2tTU01zelkyTmVlQ0wx?=
 =?utf-8?B?WCtmZXVJeEdmK1IzZm9hZnRHdGFFSXdvbW5UQy9LYU5PRkpXQXB0VEVvV2Vv?=
 =?utf-8?B?VjZuQlA1TlBIWGx2Zkp5UG5lblRMU1ZtSUJEWnNSTVY1R3ZDQjhycE8xS0ky?=
 =?utf-8?B?VFZwUUpCeVdEWndZS0xBc1Y2RUtBWkxVS1QzUUNJNHNVYUVDQlozVm9FT3px?=
 =?utf-8?B?Q05uYXZEeTFlUkY4NGJzbUNPWmYrWkFGNys2cFd5bUZQcGZGbmdISmVDSU55?=
 =?utf-8?B?emQzZk9mLzFQelc5bVBiMmlkQTNQcVlWemlRbk15MUg3NTkrNDlwNHZOTjNT?=
 =?utf-8?B?WE01cW54QWtwV1Q2VkxIYnc4L3ZUTE54UDJ3c2V3eXdZVlpLa0dwWG9RTVdy?=
 =?utf-8?B?VEpDZ1drblFYTXlHUGdSRWZ6VDJEQ216blhocEIvRzl3Mzh2WkJIWUlDaitT?=
 =?utf-8?B?MENPYUJxZUM1N0J3MHZrdEZuTjd4dUxRUldpWWxLZFkvR1BoVGk2TjFhRXNs?=
 =?utf-8?B?OWw0eHJzOVhaYWVTb2s3cVdBZGxJVEYvUmRuNm00MXJQalo5WHNiTURiTjNw?=
 =?utf-8?B?L3Y5WEVVTUZwZDlvUEx4SDB2dXo4a3R6VXBwTCt3SDJKNVN1NnRnMjFjKytL?=
 =?utf-8?B?SGl2MWFtUFhRTDNZL2RNUW9zanRMRXNRbkdJL0FvaEhHbWdDM05CZ2VlNHRU?=
 =?utf-8?B?VTVXU3pKMGszazFOd2RJYTdMNlVwbWlLYTRJMVZ2azI3UnoyZHJXeDVtQmxL?=
 =?utf-8?B?dC80dFFwQ2gyYm5uT2owQWR0Z0VNTFUzZllaNkMveEJvank5MElKbGZPWndv?=
 =?utf-8?B?Q3FVN1U5NnJYME9ZV0FDMUJaWHR4ekVMVnMwcUVnR0ZSc0VFUlJ4WnRGcWVP?=
 =?utf-8?B?TTNUMTNzcHlpcm5xSnBzSk1CTkFTdlJHWEhVSlBMbkN4YStUYkg4cHpSZ09I?=
 =?utf-8?B?ck0wRnB3cmgvdk5lSThKMUFUVnl5SEJrL1VsenJFTlBIRTJZeGJndWVqVnRi?=
 =?utf-8?B?S3YzL1A0UXR5b0xnR0hUUnhrazJpckNBaTVyYnFYTmhLZUZGQ2lWWGdrTDFZ?=
 =?utf-8?B?UGsyUnRpYm4yVEJ2eExMU0JQWnZjTW52eXVhSnhsOEMrWVdjQzlTc3V3TXdY?=
 =?utf-8?B?UVRPZUNSbzZ1bmg0U1J6SmQxb2p1NWhab2I4SHgxeVdzQzY0TlJORzZybm1t?=
 =?utf-8?B?VHAyNUluSmVKY1l2UHF4RGVieWY4dTJ1WGhlMkNmT00xWG5RdGRWMlBNMHJz?=
 =?utf-8?B?VVhEOXVOYlZLSTJJNjVxRC81enhMeG51YkJkY3NHOGs4ZlpxS3V0b1JTeXR6?=
 =?utf-8?B?UUlmVGhxeU5acWp0T3JJdm9LeE5FK2VHY2FReGFtQjZqZTMvS0ZqMmVpK1J5?=
 =?utf-8?B?a280WW5LN016LzlWMnJjRU9KV2U3RXF1QW1MbEh0a0l3YUlybnhsTUJjc3Mv?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7329c5a-4c25-4768-2887-08ddc37081c3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 07:23:34.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKUd12mblyKAGgpTLrZp9O35nnpBstZ0gjOb5MLjg3J0fACnQpgvOWlyT8/xChOX+DoCxUg/1SZS8ZduBf3wjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7604
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.rseq.make.fail" on:

commit: 58bb4c1e4faa0f315b7eb3f2766052f0c3887981 ("[PATCH 01/15] selftests: kselftest: Create ksft_print_dbg_msg()")
url: https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/selftests-kselftest-Create-ksft_print_dbg_msg/20250704-231034
patch link: https://lore.kernel.org/all/20250704-tonyk-robust_test_cleanup-v1-1-c0ff4f24c4e1@igalia.com/
patch subject: [PATCH 01/15] selftests: kselftest: Create ksft_print_dbg_msg()

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
with following parameters:

	group: rseq



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507150850.fcfc5ecc-lkp@intel.com

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-9.4-kselftests-58bb4c1e4faa0f315b7eb3f2766052f0c3887981
2025-07-10 10:39:20 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2025-07-10 10:39:20 make -j36 TARGETS=rseq

....

gcc -O2 -Wall -g -I./ -isystem /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-58bb4c1e4faa0f315b7eb3f2766052f0c3887981/usr/include -L/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-58bb4c1e4faa0f315b7eb3f2766052f0c3887981/tools/testing/selftests/rseq -Wl,-rpath=./  -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-58bb4c1e4faa0f315b7eb3f2766052f0c3887981/tools/testing/selftests/../../../tools/include -D_GNU_SOURCE=  -DBUILDOPT_RSEQ_PERCPU_MM_CID -DRSEQ_COMPARE_TWICE param_test.c -lpthread -ldl -lrseq -o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-58bb4c1e4faa0f315b7eb3f2766052f0c3887981/tools/testing/selftests/rseq/param_test_mm_cid_compare_twice
gcc -O2 -Wall -g -I./ -isystem /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-58bb4c1e4faa0f315b7eb3f2766052f0c3887981/usr/include -L/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-58bb4c1e4faa0f315b7eb3f2766052f0c3887981/tools/testing/selftests/rseq -Wl,-rpath=./  -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-58bb4c1e4faa0f315b7eb3f2766052f0c3887981/tools/testing/selftests/../../../tools/include -D_GNU_SOURCE=  syscall_errors_test.c -lpthread -ldl -lrseq -o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-58bb4c1e4faa0f315b7eb3f2766052f0c3887981/tools/testing/selftests/rseq/syscall_errors_test
In file included from basic_percpu_ops_test.c:12:
../kselftest.h:107:8: error: unknown type name ‘bool’
  107 | static bool ksft_debug_enabled;
      |        ^~~~
In file included from basic_percpu_ops_test.c:12:
../kselftest.h:107:8: error: unknown type name ‘bool’
  107 | static bool ksft_debug_enabled;
      |        ^~~~
make[1]: *** [Makefile:34: /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-58bb4c1e4faa0f315b7eb3f2766052f0c3887981/tools/testing/selftests/rseq/basic_percpu_ops_test] Error 1
make[1]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:37: /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-58bb4c1e4faa0f315b7eb3f2766052f0c3887981/tools/testing/selftests/rseq/basic_percpu_ops_mm_cid_test] Error 1
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-58bb4c1e4faa0f315b7eb3f2766052f0c3887981/tools/testing/selftests/rseq'
make: *** [Makefile:207: all] Error 2



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250715/202507150850.fcfc5ecc-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



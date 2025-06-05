Return-Path: <linux-kselftest+bounces-34409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EF5ACF949
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 23:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A6C17698B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C6520B21F;
	Thu,  5 Jun 2025 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCbynPyh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD0328E17;
	Thu,  5 Jun 2025 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749160310; cv=fail; b=KJEEx86p81LjGlvGS7beuy1CTgIfJ2cxcVXKyXlKairs/3uRYgpkBFTvNi+z/Of1W6K+UzheDq39OshwKaoajjJjyIYgy+DcfrTvK6FTQZr+P3A2p3KzfvDVi0qfyT1nG782EwgoroCIALvE97gk4hOmTIXt05nd8xCyfIpnlZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749160310; c=relaxed/simple;
	bh=vWf1nzk6kRh5a4bnSA1ENayPUL43yVK8imOMvb6v8ik=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MjRhznY0m9rcrn6wqeOgjhRmf3u9pB7Rr9rZqAel0RPhxE+8Re4Y+SqW4xTFisy2zncKVP+iu0M344PzwImKTX5ZOAJwvwmRRo99XpBeWIQU1f0Dr15G9T1zb5SaXqD3fvx8z6YJGvIBYWYRyPF1IIPHTsu2EcL91HiCfgCF/zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCbynPyh; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749160309; x=1780696309;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vWf1nzk6kRh5a4bnSA1ENayPUL43yVK8imOMvb6v8ik=;
  b=kCbynPyhP/RMI9uutopvInVwQiq4dBJB+Iwx1DZy50wNsDEVzQAz51BC
   G10CJemw2JpXJ77mJO1qrh+jg0bDiarOKoPtYqR+PAO6p7t1gnk8LpmTG
   vpR3p7JcwAfUJB1mai1+J3ofoUVtWK7ClqLTgPUJy/RcSKpDmvQsejMD/
   G4D/08c6A9CNyMimri739fntrHhGIjPJLdhFBJuYbmO2Cu+ZyoWlNLz/7
   IdIWCXMwSInEDe2ScCOGmk2j3ArmNXvJPaG/c3xNblgre6fNJC8vzjhEK
   u1jZtpHZEzvtT561r9Evu6nJSboKz2UtGqhTM7B8v4Y2P8zhW9qWwsa1h
   Q==;
X-CSE-ConnectionGUID: ECzhNYW8SIy91HNoXYhaqw==
X-CSE-MsgGUID: MCIfF/VsRA6Bnc8RWscPAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51299696"
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="51299696"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 14:51:48 -0700
X-CSE-ConnectionGUID: 1ttPZ2YRRQK3C9aylNHIIQ==
X-CSE-MsgGUID: FyDQXGTaT9uH+/XOgaXCow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="176594782"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 14:51:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 14:51:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 14:51:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 14:51:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1gmnIklKjR/MwJKZAeT/7HHnRssvvT2gEIQoi5cB9ABZwWihNBnF2E7b0vO2hbeeI410pNvhDgvi4smnZ32zWL2BgrX7rj8JLc3EGKH77pWNaVc9g5o0Q+IEUMGNJWMjyMXFFT9s1uzu4jHvKmojalDLgEIKE9dmJriK3pCFzVlA5qHTYX7CR+X4tWTR3bqKtadoxwp2rB/M0X6D4qYIs2f0oObB0MKeS9oQt4724QrkDgYQwJZ8ZnS5LaUa7doSLH3o2TjtTzUX83QuDkbkU6omWbLE5Vs030/QciMa+oyJWkJoFOv6yXwBp8NPzZommr5dsCI1kUda3rpEA+uoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbltT/hGWjyNkxrM82749BjD8ElYhvF2vhT8yeX6eHE=;
 b=dM2ZF+smZbBwuZddsnLS3Pi+gdS7plOg2x21oPa3Nd/0LcKiTsn7R6vt55/wYwVlW7cJQ1lMrmw0xsY7ozxThDYKDCMVcHO5yKd/1kQgsRDPNB0VELOvbN3CVKo8UznvRz+MRV4lbsTZNAOrRN3kDuxC6Mb1ktM27wcNmC9KBhkESgcadB2xehDQvaLrgEnqQGEfcNHctZrxSnOE8WOSE73VAaf0+C2AfxfstG2dMSbsVkCbHUpkmVxNguXCv2Z50ETS6zaUq5IQ0x82SF5LLJV10PG86am7PtlESylPEEu/99pFxiQG+wYWIFa8Bx8oHZ4+j6gijok3bEKJfKft8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CO1PR11MB4772.namprd11.prod.outlook.com (2603:10b6:303:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 21:51:44 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 21:51:44 +0000
Message-ID: <06e68373-a92b-472e-8fd9-ba548119770c@intel.com>
Date: Thu, 5 Jun 2025 14:51:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] x86/fred: Prevent single-step upon ERETU
 completion
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
To: "Xin Li (Intel)" <xin@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<shuah@kernel.org>, <andrew.cooper3@citrix.com>
References: <20250605181020.590459-1-xin@zytor.com>
 <8264e653-6570-4c2a-a9a7-c4104da26f76@intel.com>
In-Reply-To: <8264e653-6570-4c2a-a9a7-c4104da26f76@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0017.prod.exchangelabs.com (2603:10b6:a02:80::30)
 To BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CO1PR11MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: 560fea99-b061-49b6-63eb-08dda47b29d9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZE9KS0ZkYUNpd2M3MWhBbXA4eU1TaHRtZ3RaeEFRU1BBdC9ybTFtbm53R2cx?=
 =?utf-8?B?UTdOaXlRc3BzclVhZStwTVM4L1ExUk4zU0QyT2VLSm1zOXdKWUlYcnA4MDNU?=
 =?utf-8?B?ZGJBaUpWSnV1bkdBT3VpckpoekpVbGphajlYcVl0YUh4aDZ6bUhONW9JYjRr?=
 =?utf-8?B?aC9YbGU2QzdLdE0yc1VaTnRwUnlISzhKQTZUOHg3WE5RWWZyRmxGOXdFaVdx?=
 =?utf-8?B?RWxicngxWmhVc0cya3VjTllGdzZmTFZtREhyeFZBZ1hhcEdsQmxPYXpIazZv?=
 =?utf-8?B?S1k0cEdFZTNVVlV1eDJaSVB2VitsMkxOb1lJMWtlb1pGbFBwOGFJTkJzYkpS?=
 =?utf-8?B?U2paOHV1VVNVZkFONkdjSEJIRnRiQXBWV2REaEplMmV2eTlXWnJjcVVmOVp0?=
 =?utf-8?B?bHRXL2JDbDlmNTNESEVRaHM5RGtud3lvY3FwSllxc28wVStKVzE4aXJPVU1i?=
 =?utf-8?B?YXBDRWNVU1FPQk1ZN1pDQW50RHlZaDJYMmJoVDJVZGJtNjJGbFpSN1lsYmoy?=
 =?utf-8?B?NEo2ZVlrMkpzRHlzWjFZQlRXSXMyZU4xdzJidVhwNnRqV2lVSFhpdWxMY29S?=
 =?utf-8?B?QlBZR0JPN0VNOEF2dEpVcU5TSjNMaEtYWGlSVXRHZDVMOS9aU1ZPRFdxUEVo?=
 =?utf-8?B?QXFLQ2ErSmtLK3MvVGhpK05pUTZ1TnkrSzYvcDBCeXE2ZzBObkIrQjhGU0Z5?=
 =?utf-8?B?aEhzVWhSOTFXVDdCZHMvT0JzMGRqbWpFSVZoMjBST29ENXM2WG5rYzl3SFNX?=
 =?utf-8?B?bXFpYmZ1Qy9KVy9RRkZmVnpaSFVDY0MwMVpJcVB1YW1ta0VYRWR4QUw3M013?=
 =?utf-8?B?c0ZhVWI0MEN6NWd5OSs3NkozUVQ0cHB3Q2JxemJkTWFyNE1sZXBDT050Qk8w?=
 =?utf-8?B?cHNUSEdHbXNOUklhd1YxNVVOd20zamxTTmhNalVWNm9UczVra0JuTDdOeXU3?=
 =?utf-8?B?OEFteTNBVnZ0S3pHZk9OWEhWUVViREIyZm9YL3FaRW5nM2RCcGJBYnNmWGpr?=
 =?utf-8?B?RGpCUjhTNXJsa0RHaEJpVy8yOHFTaFFNUm1QNHBVQ3RXdXlaeEFrV2FhMVhL?=
 =?utf-8?B?TGJqZ0hYSk8yckRML3ROemZaVHlPWUE2L0w4U3Z3NldoZm5tN0hGcDBjKzNl?=
 =?utf-8?B?R3lZeXJzSTBxaUg4T0RNQ3JnY3RIbTBsMGhTRjZ6ekVOKzRyVFpuVittRHRT?=
 =?utf-8?B?MXJDa3R4cmdLN1hxNDNLQUVyWnB6Wk1vV3hoOEIrVlBncmFwdTVsN3pmWWpM?=
 =?utf-8?B?K3NCK01hSUI4N1JVTHp6NWFWdUNLU3haVXNJeTJZTHg3RkpOK1l6aEJicDl1?=
 =?utf-8?B?MFNuckZITzRUaEdlWExjaGVYWU5LZE5kTDJTMHV2dW8xQVVnUzJEK3lFc3lC?=
 =?utf-8?B?blhYZU9INFVOeE11K29kVXlVRG13NzlQSlpZalJYUWlEQ0ZEaHdZZFBWd2hG?=
 =?utf-8?B?d0ZYUXBQQ1ZTVFVobTdkelhaSzFtdm5YbFlBOE9NYVJIaXlONzFicFIxZVoz?=
 =?utf-8?B?RTRjb0w5N0J2QmdFVG9mR1pDMmpyKzE3NjAwVkFkZkkwS3BIWmcrY3lsQ1NL?=
 =?utf-8?B?S292NW5rNjNzcjhKelUyL3JqbE5LSDdKZTRuUTZTNEluUjRRMDZ5MnJ6UUc1?=
 =?utf-8?B?V2NZNjU0SUxrQzhEMkxCUVVXV2JWVHpka2pJUWJxMWZkRVRtNjhUNU45NW01?=
 =?utf-8?B?MnpJUTFCNm1FQnoweWRrV1JYWDBKQWJuZkFhSTN4RnNqRHpZREFUTWJ2MnVa?=
 =?utf-8?B?VEpQYk9KTGpzTlR4WDZ0anJteWhKb0pTMUp6Q01aRWhETUpIMW0vQkxXczZB?=
 =?utf-8?B?RDlkNWtmbkZYckFRMGh5eVhDNHM3MmJMc0FFbTAyOVdoYis3WklJSUdmUitM?=
 =?utf-8?B?eGZ5MDBYSTQyYTI3WHZEUmxwbGtDZ0VXVENJUVJkYXNPQmgxcSt4MDVNaC9i?=
 =?utf-8?Q?zg5Cnjv6FL8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SElab2g2SkF0bURwWE9pYWZJc2tvWDdMQ0p0dFVCcnRGOUJzMzdEWU9WbHdn?=
 =?utf-8?B?Wkh2eklvZkh0MnA3TTU2aFhjNGsyajROaEZZblBrdExURUJRVVFNYVlqUDdS?=
 =?utf-8?B?MGM4blA0eDFUOEVpeEU3bEZucGFiU1NLWkZiYTlRLzVkWHVSVU8xdTAzZ1lj?=
 =?utf-8?B?c2tyeVlMQ0dXRS9KU2VUeG5jZHFrRjFrakdSVHdUUlVTQVJYb0EzOVlvUjNJ?=
 =?utf-8?B?b2pIbHk1b3dIQ3Q3dllyYldvN2piT0tqdmQ3U2N1WjY1VnNmcm0wKzBiakwz?=
 =?utf-8?B?dnBFcUhoUGM0TDVIOEJ1V1oxckJnbFhDQlpCZSt1RDJENk4rdXNMNnV6eW9R?=
 =?utf-8?B?bHRQc1EzZ0Zvb1orNDQ2RnpSMS8zU2hUcGZsU2dKTC9hVUJZdlZvUHU1U1Y5?=
 =?utf-8?B?b2FGWTJPdzdHYUJ4STB3QTRMeE9qTk5zeE02TkZBN00xWFJsQzE5K2U2Mkpm?=
 =?utf-8?B?dk9seWt3RDc5Vk1Oa1FLcDVWSVd3dVo5N2pUU3JMQjRReGNvVUpHUzVoUDI2?=
 =?utf-8?B?KzMrOTdUTSt5RVpGL1Qyci9xWC9ybFIvT3F3cFdWdXl1RzVkRTZMR3VZWnBn?=
 =?utf-8?B?OUFKaG4zQ2czbVBKQUMwWlYreDZ2RU1icmZwaGRGcTMyR0xCV2IxVmg1TDFj?=
 =?utf-8?B?VVZjQTM3VXB1UytRZ2NMaDJ5Wmg0SVk5aVpLbVY0MURxU0s2bkQrMHdEK3hO?=
 =?utf-8?B?dXNBQUVvS0Raanpsa1Q3YmJhN0ZYblZubFFsM0wzaDE0ZUs2bUJ5ZHRvTlMx?=
 =?utf-8?B?enVLNExkaXN1QU93OWZZSmExeUNEK1VyNDdzZVh3RkhkZHBxN1ZsRXFKMlg5?=
 =?utf-8?B?YWtKbjM0OWwxVEQrb1BoTWcxaGZSQnhmZkYxajhNSFVkZ0RoLzcyMkE4S1VO?=
 =?utf-8?B?TUt3bjIyNG9IY1lGNXNTcm81dVhmLzNyb1o5TW5XY3F6azVpa2JGUENCcjJt?=
 =?utf-8?B?Qmp3MytKOXROMFpab283MzRkRjBCQmpRc1R5LzR4S2dwR0NFajJraTRXVU4x?=
 =?utf-8?B?VVJoLzU3QjRVbXpKSm9sR0JoM0RpcU1PaE1tLzBEeU0wRmc2cGN6REN2YlVZ?=
 =?utf-8?B?Y3ZmTXF0MDFPOHV2dnAxSXowMXNIRmlYRSt1dkxDVExCT0UrRGNFc09oSWlJ?=
 =?utf-8?B?TjV6cVpNNU9CKzVab0xyWkRKQTZ4VzRCck5zWGIvS1dLd2RXRmlPSXRqaFh6?=
 =?utf-8?B?Ym43RE1iTSt2TUlqVVh5a0Y5WGJLVU1ienIxR3loRnY1V3RKZzE5UEpxYnMy?=
 =?utf-8?B?Q29WMUVHMk5yak01bHNxZnFVaDhiMC9jN2dTdWJiRjEvVkRzdUdlNDZnd3NG?=
 =?utf-8?B?d1NMTmRiUWdXVlNTNXFLRTRIZzU4MFNJVC8wWnBZMmhoQmk3azVFSmxMYldE?=
 =?utf-8?B?MFlQNFlsYjV6SisyNjc2QmtpTzdsTkhlZXB1MFdPSHZ2SWNtUHJkc21ScnR1?=
 =?utf-8?B?d1lLK1pheWlPUWtmSlNKTDQ0aG1zL3pUcVdqT3FnN0NiM1dkY0hmRDNBM3lx?=
 =?utf-8?B?Tk9QVi8yRFA5dy9jc2pBMHZmZ1lkRzhqTk05MnRPSmFpUytzbzlNN3lkSUZK?=
 =?utf-8?B?SThPbVRxQnc5NVdNUWZOVHJScFViT0tCMjN4a21lVDFrSEtYODRlMytKVWdT?=
 =?utf-8?B?ajQrTmp0a3BRWTFkdkNqZDBwUmpqUDZtWmprZ2gxcHg2ZjUzamJpOHRqelR4?=
 =?utf-8?B?QWpqSTVHSWx2d1BWbTMramU4MTdGRDIydzlRNldjK0k2ZW9kRTI4QzNQTUdk?=
 =?utf-8?B?VXBLZ0dlRC80R3IzWkl4eHcyaWJqQU1wc3cxelFiSFM5cVoxRmlDcWdQVlY4?=
 =?utf-8?B?WmpDWHBnbzRMS2QvMmJEWDIyVExoMXd2eDFQekZDWjRSOEtlcFpLanUzTDl6?=
 =?utf-8?B?WnBpTlBMb0NIdGdJUEdvSHYxcy9jWDgwbnF2UWMrditJNTR5RWluRnk4bGx3?=
 =?utf-8?B?eE5HeWsxSHJsNGpMTzBVT1RPNmJsSHZZWXFLbjNZdDlGMkowb3htaGptUEhr?=
 =?utf-8?B?RkJYUHZHYnRZeHlxZ1ByVWswVkhPNWt6OUVycFlrUVAxdFgxK2tVVmNtL29J?=
 =?utf-8?B?bzZSVkYzUmdQeWhwYmJ6Yk9MVFo4MUVydlhIam04UWpwYmhTWXhqdXB6bW01?=
 =?utf-8?Q?xjNKeGBa5r/5htznzwu3jZsYP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 560fea99-b061-49b6-63eb-08dda47b29d9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 21:51:44.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Vnx7+ufLQQ4lRWv/eDqXLWgkBGm6wgsndeYsY/MyTn94b6jGCuRO/HC1kR/HOPwhb4o6MC6j+1kUO1lH+UmcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4772
X-OriginatorOrg: intel.com

On 6/5/2025 12:32 PM, Sohil Mehta wrote:
> On 6/5/2025 11:10 AM, Xin Li (Intel) wrote:
> 
>>
>> Xin Li (Intel) (2):
>>   x86/fred/signal: Prevent single-step upon ERETU completion
>>   selftests/x86: Add a test to detect infinite sigtrap handler loop
>>
> 
> I tested the patches on a machine that supports FRED. The results are as
> expected:
> 

Seeing a split lock warning when running the test:
x86/split lock detection: #DB: sigtrap_loop_64/4614 took a bus_lock trap
at address: 0x4011ae

Wanted to get this out sooner for awareness. Will figure out more
details and send out an update.

> FRED on  — no Fix   => FAIL
> FRED off — no Fix   => PASS
> FRED on  — with Fix => PASS
> FRED off — with Fix => PASS
> 
> Tested-by: Sohil Mehta <sohil.mehta@intel.com>
> 
> Though, I haven't tested the 32-bit version of the selftest.
> 
>>  arch/x86/include/asm/sighandling.h         | 22 +++++
>>  arch/x86/kernel/signal_32.c                |  4 +
>>  arch/x86/kernel/signal_64.c                |  4 +
>>  tools/testing/selftests/x86/Makefile       |  2 +-
>>  tools/testing/selftests/x86/sigtrap_loop.c | 97 ++++++++++++++++++++++
>>  5 files changed, 128 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/x86/sigtrap_loop.c
>>



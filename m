Return-Path: <linux-kselftest+bounces-35999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7E8AEBED5
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 20:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299856460C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6F2E9ED5;
	Fri, 27 Jun 2025 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSsBC+jZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432762D9780;
	Fri, 27 Jun 2025 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751047477; cv=fail; b=rJUEuzPCNhFCaAxipe2txFRNrHaEhFLJmyvpiqMHEm1Ngpm03TUQWQ+Mnz+/MDVkvV9yYr6mhXdF4JZPRZNEMKoxQQ/8OXfoYQ1eOhAqU1SILBLKiu27WnJb3h/NVMwu7mDgdxfbeknBMTNOMblc+seMHXVGo9GjguUEe18LEIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751047477; c=relaxed/simple;
	bh=aNFuCryRKF53CNvjHUCNmZlWA1/SUdr0WsqlTj10Pkg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BeyjZ4M7aCKdupi22DguiSfxgQUv/QBAS76l7Cn3Uzal+RbE5J16N+eKheDbEUbQVY5TwN9r/JuzSkK5IwI7jhaABAw/jtBo/EjjQgIk5Yl09z4Nf25IcEFT8Jp547ra5tcYQ3tnDYM0TfIDoEe22HPXZmZS2bkPUvwFpIezY5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSsBC+jZ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751047476; x=1782583476;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aNFuCryRKF53CNvjHUCNmZlWA1/SUdr0WsqlTj10Pkg=;
  b=MSsBC+jZvYHZj5w025UAdt0FGcKjhVcVYVXIJYxrPihOPS7k5EbxBMmW
   1C7HgAEhqJKSjnDzgZKHfgnrtDZr+PsyIbsAl2fX/K7S5Yf/Cm3MF70XM
   6wVwCPBGwFsUYU539sTJaWS5pfTQwcbtXMQQ/ANWdxk7cbxygjeJIxi6M
   f6IM0ihP/KMjpMvUMdWQw/+WBi72P9anbqYTKkVMs6IL48Yd476sdvZHi
   iU7PXrv6CENGIXx3XtGy6bzNQJadjAu7ddEHhZPDWDSmiU6p3pEPjmQKM
   ppreUaTJirE3+HZri3Ctu4z7F8oiPij+jtlxHd4F5UwxfypTOlT/n6oSF
   A==;
X-CSE-ConnectionGUID: KowJeVYmSlqBDzBdEwXgdA==
X-CSE-MsgGUID: 4v+SLwhoTwuubiU208YPIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="64809576"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="64809576"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 11:04:35 -0700
X-CSE-ConnectionGUID: Z+aplcg6QwW15ib0pafC1Q==
X-CSE-MsgGUID: btICQBpKSYuduLqqao8iQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="153355137"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 11:04:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 11:04:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 11:04:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 11:04:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZND7TpwJImDWrj48mATnS/kOJ5txsaDrav4tDWjKtoF2SwW2sesSpu/Qqpk12zlhqioxn9ZnOLwylBs2wyDQQhLaMsUuY2fOLy2Tq7NxnjXsRubz2M4vsjEy8hu8QKYzk5nJYGIWs/+cZnPn8/ZLQ8UEhVpr3oSU6QQaxFvZcOEtCip3yATqCteMK5VEn1G4F0+bu7HjzzGhrvOR2OVvHdcqyScx2E/u69OJOtElrfQ5P3e3xMnDadKur+gpOz8/IvaBcHET4UEP9VE0vETShgfGK3Qktgv0jO4KPQZYaBChfUzX211jnVf/O4MDLTTsFpBHzfqu1jsrJw8agcT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEbai1shaoFdUvTVC1KIjmXoV8tQuYwecgyhmd0Zwe0=;
 b=yNnYcHqC54dpDrK4Y9ZStbzPbTPf1yoz8JQY3UFZY1DAnpi8EnbqFzuXBYNd28YdZyHOKr575Ykf/XMea4mcYJKVHEuTbi71hJ6Gkcip0z1iEfbIJBqGRFdkmaa0SduUFwd/j//IWugBIOoldy6XfkWnG7hKdWtiuM75pxVsu9mgW9FmH6dGY+3dQaZQjuq/KBT+o7+TtmjpjXxBLs3OKosHygabQPXuqqipr93EoliXaf7kNU7rvBpBy7q7tJFVfH5F5ER11W/3P2bqllHGW+5dB952/ekaDuqEX/R1iwdCuwWzojtLm7loiERydjzPxQ1cBnE3R1GWbWOpWJtQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 18:04:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8792.034; Fri, 27 Jun 2025
 18:04:30 +0000
Message-ID: <0e9137e0-ec21-42b9-98be-af90becc2318@intel.com>
Date: Fri, 27 Jun 2025 11:04:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] kselftest/resctrl: CAT functional tests
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>, James Morse
	<james.morse@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghuay@nvidia.com>
References: <20250616082453.3725-1-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250616082453.3725-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:303:b4::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 51dcf162-ff29-49ba-6887-08ddb5a51066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXFtTUFEbjlEWDRXTldJN09Zdzk5c1F0THJoZXBIVkNwTS9YVDE5VDhCbkVt?=
 =?utf-8?B?eWdVN2taWTRWMm4wbGVvdndyeEpKSWZHVEc4MEFjUlltV1lEaVVzQURiWDlh?=
 =?utf-8?B?elkvMVlTdFBRUjFrNkZxUi9YQTRZcXRjY1MrWE9uV0JZeElOOUdoUW1GVW8x?=
 =?utf-8?B?NkdkTUYvaUNSVzZMOTlOa3Ezak9zaTROQUFBUDl1b01DMEphQlhIaTJ1cDNH?=
 =?utf-8?B?MHQ5TG1TRDZkaWduN0IvTkF0MjN5SEI2NVRVV3l6WVFnR2lkeWt4d2xDY0lk?=
 =?utf-8?B?aHVSR2hvSTR6OE5wZy9EMjk1cFdUd3pCaEU0ZDNYK0ViNkduZGRUY08xRHN5?=
 =?utf-8?B?WklSM1plV1ZXT0FQYnVGblBVSDI2VG5LMWlnL1BBRytJWE52cHVFVVFoTFUx?=
 =?utf-8?B?WWl4cVE0ZmphYmxnWnhDcDR5eldCcU9GSU4rd09SWmMwMmhKajFxSjdzNTJo?=
 =?utf-8?B?bGZFVmJJL1gybWVSK3Z3S2U5WnVlWFdWdysrQW8xNDlMcVZYbnBXQzk4bDJ3?=
 =?utf-8?B?QlNxMzNvZ0ErQmk1aHFCQUF0OHM2SXB3MnkyOHV1cnZEekVwVGZyNlM1L2py?=
 =?utf-8?B?dVhZdTkrNmprS09Cay9mUFk4ekpGTGVYUHRPRm9QS2xqRlYvWWp1N2xkU0JM?=
 =?utf-8?B?cWxsQUpyTmgvSEFXb0NIbm5NaElEaVZtOUZZSjRwa29oZmZ3WEJaSll6SnhG?=
 =?utf-8?B?Zzl3TGpXeG5DaEtkVEdYZWg5NkU1TE9ESkFHTVc2Q0lHMGpwQ05TeEg4TFEx?=
 =?utf-8?B?bTJsbFdrQ0hsdjhxcG9UdzRsN1NQODgwSDlqNmd0UDREekFpNXE1TkUzTVk5?=
 =?utf-8?B?MVhjTHh3U0l6aGNpMXp4UTFSMEphMzJLTFNYSmtzZkdHclEzZWRPV0x1enhT?=
 =?utf-8?B?S3hlTEJ1UUx6emY4NkIrQVliQ1UrSjNxdFYvTDNDUmxRUkpVSnkxdjNISHQr?=
 =?utf-8?B?Q1ladUtrdExyUjhRUVFzamhaY05Id3FwWlRLQWJ5ZUlTR2YwcU9ZTi9uK0NB?=
 =?utf-8?B?aXNLUXJvNS8rY1NFbTNiTlpIZGR6ZVpoaUtIMjNwWjNyVWFOblN4cWtVT0RT?=
 =?utf-8?B?YmNTYmtuWHovbDVUbEhEU1VsVXpwbE5OekxRZVpxSVRHMkxNcS9xMDRYVWI3?=
 =?utf-8?B?RGZTZ3JCUCtBT2hPUE5YbHZDZStwUC9BU1FRaW5Dem9SNFBGRnJXWVhlRjJO?=
 =?utf-8?B?TzRJc2tGbkp1eGRRNUV4L0VNZHpkdlltRm9VbW9IeVdEdDZ5bEhIL1dSZUpj?=
 =?utf-8?B?TytFdGxFbE80R29JQVNVdFhraHhXQWF0TXdsVnNRWHZ0dXNjakVkK3J6c0tY?=
 =?utf-8?B?bHdhVVBCdGZ2emdpZFp1YkZZUE5vMXR2M0ltTHFrVjZFdTBZaEs0NW5BaEhF?=
 =?utf-8?B?SVl3dTkwV2xLd0hSNjBOazRLSHBjb3p5QkhyVDNORmlqTkFxcHh4TUVkQW10?=
 =?utf-8?B?T3JoaEh1M1c1NDA2Q0hFRkN3MFZQZllDSXViWlp6ekJ2aXNqQ1BBckx3dWdh?=
 =?utf-8?B?VjRKeGJxWjFUL1JsUUcvUlVnWlVFNTZZUlFLbFpvaVlDOUoweEFLSDQ3dGQ5?=
 =?utf-8?B?SUlNbVk5ZzlBajdpTzNBZkxXTnFHb3FPSkhVTEY5cUdJdkwyNi9tN0txUVpt?=
 =?utf-8?B?S0E3UEQ5cFVJQ0I4S0pNcGppNmpVQUo3aWp3NnhZUWwvU1g5RzkzK2F0MFho?=
 =?utf-8?B?Qjh6eC94anVHQTgxN0RsVWE2NFFJQUVoSEZZMHpEbnBVdXZUMzdlTVMyMWdl?=
 =?utf-8?B?bFQzcVg3cUVjeSt4R3RTZ3JZQmhaRVNUQUlMVzVGbWFRS28ybms5a2JRdUcz?=
 =?utf-8?B?aEdZN0NLU2FWMm11cFJpeDRlNDBNR2g5TFM1NGZHNVlhRkp2QmRpUndsalRl?=
 =?utf-8?B?M1NjL3l1SEtleUNVS2RabTBpcGJFR2JzdVFoQU9ERkY5TzFYMUh2N3dUSEor?=
 =?utf-8?Q?hx0n0JfMSJs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFowMTlIL1oyRm02T09jYWhhUXhOVzNPdGJrVGxkNFJFY1VvaWpRSy90amdV?=
 =?utf-8?B?dmg5UWVDeENGMUFxRUhDaTRlR3AyRmZ2Y3o3Tm5ZZDNHL3pxUUNITkVvTk15?=
 =?utf-8?B?OHRMZjFGdDdYUkVHMlNVKzVDSksvRXArdUFRWGZPdmxSMkxXYkVLN1M5T0dT?=
 =?utf-8?B?eXd5SklyZXgza3M0NHgrb1VpaHYvSml3Qm5KOGNhUSswSUNKSHEwR0t3bEF1?=
 =?utf-8?B?RlJTRlFzaytZRmVSbVNTRXNDdXdWQ0dqcmdPTER6SkdGR0FUU1NkN2lKbnNS?=
 =?utf-8?B?NG9wd01WUmNpK1NyWlI0dDdIc3JRZnJJSlgxNUMyK1NSNlNHMlFCeXgxUEE1?=
 =?utf-8?B?ejNab3FhRmlPZ0c5V2p6ekFxelVsVG9OeHRxVGNVNWQwSWdJMmp4Y3ZtZXR4?=
 =?utf-8?B?WjNESTU0Y0ZBNHIzeHVEMkNwRkpvb0U4cHRQRHk2V1d6M2JHdG9ORGtodlQz?=
 =?utf-8?B?aG5PUWFJVWVzcTk2a01USXlYdmFTS0RMdW8wcGkxSnAwT2g2U0lWRzVJYWJF?=
 =?utf-8?B?aDV4YUtHZmxia0p6TkE3RFdNWXFLZEIzWUd2akYrUjM2Z3pvMlhFOHFmOU03?=
 =?utf-8?B?TG02eXg4QVpnQUdPL1I2TmFVZGxjRlFQTmQvajNycE8zM0Z1SnAxbkhWOWpU?=
 =?utf-8?B?UDVHczUwU0tWM3N4dElsOVVFY2h0VnlRMk9RbEh0Z1FVZnNrK2NlWEo1cU90?=
 =?utf-8?B?UnVNdUR0b1cxV3Bza3pDOWRSMUtld0p6RWxWT0RiTUNyTHRLU1FJK3lZZjFC?=
 =?utf-8?B?MVdPT2ZJYUJQV05aVzJURk43TUlVTlRZUWlWeWQzOEYzc3cwWVNZc2dLdlQ1?=
 =?utf-8?B?aG5Sc2ZCRVZKdkVSRmtEZmFMM0ZyNWluZDJQSjVHaE9keGNSR090c1JiR1Nv?=
 =?utf-8?B?UFZYVU9OT0xBWXQvdnFpdDFhWHpRcFdPZXNYUm1nbnhiSHhmQ1NNcTEyVmZR?=
 =?utf-8?B?ZnNPak8wQlhOaldreUZYMDJtaTRYNE5tR2pHUERneXZPRlZwYmxzZ3FEQkJK?=
 =?utf-8?B?cUF6aXZYZUwvbEl5d1o2TjVqNkFJdjBoaGJ5RVJkWTlFbjRQQS9jZ2NzZHdx?=
 =?utf-8?B?VjZrYkJJK09lUUxTWXJsZW5MMXRTVWU4bDcwSW83U3lVcXgvS0w2OUNKeWg3?=
 =?utf-8?B?aTFQSXVyeFRpaVVNK2dCd1E1bThjZTMxZ3REc3lFT1RnTUE2MUFDRW5EdjFJ?=
 =?utf-8?B?M21FZUNPMU82V1NWUDZDUFFwRmhyL3NDV1M4c3owdTRRZEVGMTJKVUtEOC9p?=
 =?utf-8?B?VGVTaXNCUkE1MVVXSWVJdUhSM0FjdHpTM1ZDSWJSMWF2cTdCYW1iaCt3MlN6?=
 =?utf-8?B?NVRFR3hGSDZ2TURrQjc0VFZjK21uZzBSV2poYkJjT0ZYZjkxb2JLU0VWdHFl?=
 =?utf-8?B?NGhRbEhmUzhMV3R4Y2JDQXB1SEdEd2pwRmhKMmYvclo0ZTJPRG9VeW42ZFRN?=
 =?utf-8?B?SUhQS0hjS1UwaVJxNlhJZXJSVXBQVFFhNWJUcjVjam9NQ20zTVVxZUFSbC85?=
 =?utf-8?B?R2x3ZXZjNW5kVW01bHl6M0pFQk8xMmN6bWxQWWU0dEFCUW9jRVdDVVVVeWc0?=
 =?utf-8?B?eHFDLzFRY3J0QTNJRXBRR29yU1RyVDdtSU5hdmFacVNNRkRsUWVCbG96R2JG?=
 =?utf-8?B?aVlSN3NrV0pGc213bEU4cVFaZWNvaHEyWGh3QURwZ2JGcFhHRm9NbkdyaFBm?=
 =?utf-8?B?bnkrZXYvbFlwQjEwSy8zNWlTVVhpOWdHa2VxakhPbmxXcUZDU254ditKa29D?=
 =?utf-8?B?WVlMU3d5aG9tOEpaV3Jxalh6aWgrMUx1b0ZWVFlnb2ozMkoralFQTUZwVUdR?=
 =?utf-8?B?YXk2R1FVUjY2dXJQSkZQdU5KM3FFRUFadlRJS3U2VWlrZURFVmMyZnJpM3Rq?=
 =?utf-8?B?MC9nbFFIUUxvSFFXK1NBVGJDZmVoRXRwRi9hNldxUW5zWERxVWU5aU1rRXBR?=
 =?utf-8?B?c1YrbGhVWmtmZ2NmR1hTanR0OFlyY014ZEp1YlhkYkxDZmtOd3lkK3FCd1pO?=
 =?utf-8?B?a1I0ZWhpZHRGSW1yY1pyUjFNc2dnbk82aWRjME1XMDBsNitsM0tmL0tOdUc4?=
 =?utf-8?B?V2JzZDVzaTR3c01haG0xaFRVOVJiMk5XZE5TL01EQWZ0ZllRbGNCUXJoejU1?=
 =?utf-8?B?aCtEUU13RGdMOEVteHVmQ0tyTDRldDdEeHQ3U1BEUzN1UjF1cHd6TVRhZUZl?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dcf162-ff29-49ba-6887-08ddb5a51066
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 18:04:30.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDpnVTrrCKyiJkhBy5qHKMdzZ6nITKKd18vHU8MR0Iku0dliXial/JfhNsKT3MooEAshIRXqsZKJjvtt85KoA2r5RxLl6ABEroHxOG9C0zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com

Hi Ilpo,

On 6/16/25 1:24 AM, Ilpo Järvinen wrote:
> Hi all,
> 
> In the last Fall Reinette mentioned functional tests of resctrl would
> be preferred over selftests that are based on performance measurement.
> This series tries to address that shortcoming by adding some functional
> tests for resctrl FS interface and another that checks MSRs match to
> what is written through resctrl FS. The MSR test is only available for
> Intel CPUs at the moment.

Thank you very much for keeping this in mind and taking this on!

> 
> Why RFC?
> 
> The new functional selftest itself works, AFAIK. However, calling
> ksft_test_result_skip() in cat.c if MSR reading is found to be
> unavailable is problematic because of how kselftest harness is
> architected. The kselftest.h header itself defines some variables, so
> including it into different .c files results in duplicating the test
> framework related variables (duplication of ksft_count matters in this
> case).
> 
> The duplication problem could be worked around by creating a resctrl
> selftest specific wrapper for ksft_test_result_skip() into
> resctrl_tests.c so the accounting would occur in the "correct" .c file,
> but perhaps that is considered hacky and the selftest framework/build
> systems should be reworked to avoid duplicating variables?

I do not think resctrl selftest's design can demand such a change from 
kselftest. The way I understand this there is opportunity to improve
(fix?) resctrl's side.

Just for benefit of anybody following (as I am sure you are very familiar
with this), on a high level the resctrl selftests are run via a wrapper that
calls a test specific function:
	run_single_test() {
		...
		ret = test->run_test(test, uparams);
		ksft_test_result(!ret, "%s: test\n", test->name);
		...
	}

I believe that you have stumbled onto a problem with this since
the wrapper can only handle "pass" and "fail" (i.e. not "skip").

This is highlighted by patch #2 that sets cat_ctrlgrp_msr_test()
as the "test->run_test" and it does this:

	cat_ctrlgrp_msr_test() {
		...
		if (!msr_access_supported(uparams->cpu)) {
			ksft_test_result_skip("Cannot access MSRs\n");
			return 0;
		}
	}

The problem with above is that run_single_test() will then set "ret" to
0, and run_single_test()->ksft_test_result() will consider the test a "pass".

To address this I do not think the tests should call any of the
ksft_test_result_*() wrappers but instead should return the actual
kselftest exit code. For example, cat_ctrl_grp_msr_test() can be:

	cat_ctrlgrp_msr_test() {
		...
		if (!msr_access_supported(uparams->cpu))
			return KSFT_SKIP;
		...
	}

To support that run_single_test() can be:
	run_single_test() {
		...
		ret = test->run_test(test, uparams);
		ksft_test_result_report(ret, "%s: test\n", test->name);
		...
	}

I think making this explicit will make the tests also easier to read. For example,
cat_ctrlgrp_tasks_test() in patch #1 contains many instances of the below
pattern:
	ksft_print_msg("some error message");
	ret = 1;

A positive return can be interpreted many ways. Something like
below seems much clearer to me:

	ksft_print_msg("some error message");
	ret = KSFT_FAIL;

What do you think?

On a different topic, the part of this series that *does* raise a question
in my mind is the introduction of the read_msr() utility local to resctrl.
Duplicating code always concerns me and I see that there are already a few
places where user space tools and tests read MSRs by opening/closing the file
while there is also one utility (tools/power/cpupower/utils/helpers/msr.c) that looks
quite similar to what is created here.

It is not obvious to me how to address this though. Looking around I see 
tools/lib may be a possible candidate and the changelog of
commit 553873e1df63 ("tools/: Convert to new topic libraries") gave me impression
that the goal of this area is indeed to host code shared by things
living in tools/ (that includes kselftest). While digging I could not find
a clear pattern of how this is done in the kselftests though. This could
perhaps be an opportunity to pave the way for more code sharing among
selftests by creating such a pattern with this already duplicated code?

Thanks again.

Reinette


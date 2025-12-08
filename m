Return-Path: <linux-kselftest+bounces-47277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E892CADF27
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 18:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3993300E3F1
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D11253B59;
	Mon,  8 Dec 2025 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7hSEiLm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F918C2C;
	Mon,  8 Dec 2025 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765216671; cv=fail; b=N+0kwVYVu9xghJCLQchh8fkPCOrDkFVH7acZDbfufNHNAOVMxfUXPWX7CV4vkYw80Sn2tzke13TQcLcShfEw6V6oOtenFiqTSk+Ccl9INrqdmK5NDVdD/JwhCt0b/3ENSwUrIyydXK/4OduJ3Z7OsKUjjnIW1Q6jj7D5a3pymfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765216671; c=relaxed/simple;
	bh=hjeXiACf1sDQ30ekkfvZQc0y2Ydk4Yp7vfJBZmT4u2Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UrHImR+eeJ51ft9TYiXL+07oznaALRvI7PNVBr+56Q7zx6wPlI0Mmnzn6zqEOvdJol/UKnXiKMWHPFntN6TcIztUpHUsd6C6/XMpPWFZ6kCPP4JpY1MlofDJl6O01Kh1EtNgUkoU2SYD5aUkJWhqBf3J8U1m155Sk9AMiTH+4us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7hSEiLm; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765216670; x=1796752670;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hjeXiACf1sDQ30ekkfvZQc0y2Ydk4Yp7vfJBZmT4u2Q=;
  b=m7hSEiLm8Ctqn5UvHUmv56X36bjHAT3zD3owBb3+OVcGT2JJWiwONO4Q
   pUsFRxGOQY//yEISzuzUqVCp9EhUqiEN8zaqrTyZQXZepIW688KDqRTfz
   WuJrp2KT8rQpS6Qb0pYglvnIVVrXB8tvWoBGLuUKAExK+UTWNH5Z3nnUw
   MTVqL2wcYlSudPXnuonmGLMoE+Oj0RaSRt/xGDjH9eUNxVfPQMarBzZms
   Y1KZVKIdsWSCWjfpu1UB8mrv0pUkqc4PmXo+a9CVv/PXYHcK6bmPuTGip
   mrPKytfL7y1WkuUy5SEepn6TUhxzqj7V814kvP8IFMsQAdNWMiY4Jnymq
   w==;
X-CSE-ConnectionGUID: 8BK08dwQTTCxd2rbU/R8xw==
X-CSE-MsgGUID: o8dHyzWPQEuT+GP/1BIPPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67328786"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="67328786"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 09:57:49 -0800
X-CSE-ConnectionGUID: cq04IwjiT7uGRRDFG9NQ6w==
X-CSE-MsgGUID: Wn87+CH5TN2i6I3kSkxH+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="196275271"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 09:57:48 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 09:57:47 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 8 Dec 2025 09:57:47 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 09:57:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBtcjpqtah2yhAnPue4YzIzt2h0Dtb1n0Q2amTwmhwg84ezKyFf+JPxazcwSCwelh3gWXEjmq4JAmIjutdrVp45xa2b2e4VMK7VBJUeOTgekACSwc8DFcsQ6YAMtkZA4IkGttrOAhnSVtoKuSrqx69XUrjxdJW7aEh6XgtOX+sMGbAG7Ee+AFnTpoObnt0RSrpf5JrBdllaXVtOJx1aK9vRTHGUVZ3M0Tk8u61AUrPEAIRFu4neSni2RZobthJ3/8lgcejtqS8w/HsQta2We6c9xzfwLx1oGmOtfuMv/QMgHToGl6b15Uk1RkjsWuh5jVbF5wfwEpNxMZbn7JCJjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZkCpErLIkXu5iE4kSHDgpFNvLKeD2+xTtAK0tIVPMk=;
 b=T+jDrqNKNhl3xgvv5Xjfr+qIJVQ7ztdVUpke2edaeLna2fKYzeFhE0kKj1rRF1FRFAO8tNbggCx5uV6Rh+7rKmBGYIfPjIpVpeo0fQ2ddN4botZzbYj09BGKfhgtOXnEDSIbKx454NZKdgQ6lQbKtZjDXvbyaKRlPtRr6jCJc33fnYXpvCvnwu3cIbHfDnVMNu6LqR0oFsTWXs5dkC3In4rJpzJdsSNntSreIJTmOsp2UFfY2ek9UdRvK0Bzfh1ZPuDQReuDyrRvcQyh1jJV5rHCnbnUZtps7lWJsDWClRpOqaA0C/CgdfUUwbvG7CnCBog9zxHmg8ZE/NUIFSr3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB6901.namprd11.prod.outlook.com (2603:10b6:510:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 8 Dec
 2025 17:57:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 17:57:31 +0000
Message-ID: <ca161ef9-c9e3-498a-9e6a-aefcfec46dea@intel.com>
Date: Mon, 8 Dec 2025 09:57:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/resctrl: Add CPU vendor detection for
 Hygon
To: Xiaochen Shen <shenxiaochen@open-hieco.net>, Fenghua Yu
	<fenghuay@nvidia.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<shuah@kernel.org>, <skhan@linuxfoundation.org>
CC: <babu.moger@amd.com>, <james.morse@arm.com>, <Dave.Martin@arm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-2-shenxiaochen@open-hieco.net>
 <6d68f2c5-4011-4188-bdb4-27f0e6a4d13e@nvidia.com>
 <f2e30c0b-018f-4988-a1ad-9ead6af7994d@open-hieco.net>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f2e30c0b-018f-4988-a1ad-9ead6af7994d@open-hieco.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: b00bfcf0-aa83-425a-9d0a-08de36834207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlF0UHdtOWRDNE9NTnFkOS9Hbk9pbVQ1Rkp1cXJ3eFBIZkdNeTdtdCtBV3l4?=
 =?utf-8?B?bk9SN3JHbEpINURtdjdiZ25nL2V0aWVmL2M1UVE4SUl0WmFkamkrTUFuZExa?=
 =?utf-8?B?Sk9QR1FMbThySlZMY0l2bjZ4dnBwWjlJUk0zaWJ1YW8rQm81cWRYQnhQdVJk?=
 =?utf-8?B?UmtGTmQySExHU2ZCRVBLZEtQbWw5NUIvbkd6blJjTnBnZ2JjQmRRUVQ3TldP?=
 =?utf-8?B?YXRKZEtxSW9sOHljZWZOZC9FeVZuL3hxMkhORGI1c1I2TzgrdDlycVFyMGIy?=
 =?utf-8?B?aDRDTG5JWGVDaG9oLzhXVlZ4L21iNUUzQ05hM01HQUhybW04Yi95emNyWHJ4?=
 =?utf-8?B?emVTc0JPQytxdFp6VldtN21ZNlpsbUxsM2tWZ2cwbFhhVUhGMXJBUlBJbjlN?=
 =?utf-8?B?a0llZlFndGVPMFNIeGZTdnRuNHdPTXk4QUNlV3Vnc0J1SSswYzVMckhsOUJQ?=
 =?utf-8?B?U2tGakM5QThhUTgyNS9iMm1uclNYQncvVW5ibU9hQTFwbEFFZU9FOUQ5Rk5q?=
 =?utf-8?B?alJEd1hiMU0rTmNxVzVMTk8wZXR4NE1oYUdrZ3orMEZ4SzRhRGVOSFNUWGpq?=
 =?utf-8?B?QmZ4d0Y3YXJmV2h1WU5pWjE2ZTZLUVk1MDJSalhDaHBuZVRaaURnYlNZWFl3?=
 =?utf-8?B?NHBxL1RsSmFsWjJ4bjZRWnE5Rmw5UHg5cFk1QThJUlpaZHhHNEhFQ281QnVu?=
 =?utf-8?B?eHZFbUFkUFZLMThPd0VudGdMdVFsZjNqMkdHQmVqZ05WS2pVL1R0eFFUT2l4?=
 =?utf-8?B?T2NFKzV1M21rdUJnVS9TL0JoeFdrZS8wTWtqUy8yWWYvb202WlhIVTZPQXZS?=
 =?utf-8?B?cm85ZUxIbnE4YUlkMFU2TWRlN2dCNlp2SnBKWU1XNmFsSFJmWFk1dmNTdWNv?=
 =?utf-8?B?ZlIrVUJpU3RGOVV3UlRWRnlxWE5CUHFVQlJDN0EzY3oySHI0N2tzWnZualor?=
 =?utf-8?B?cElIRGlTT3p4WjhQdDFXZG1ZNXhYMW1iVDRINmdtelgrKzdiNHYyeXNtUDJE?=
 =?utf-8?B?S1NjenpDSGNYMFAraDZtTXlpaU1yaFVTcGhPdUkzUzZhaTNSTkVHVjcyRVZB?=
 =?utf-8?B?TTNJeE5PbjJIbUVPTzF2RVRib0xpYlBxWVJlUWlwMURyQmNXMFgwclVJVEln?=
 =?utf-8?B?c3hDV0ZGU3RoT2tYemdzZjNXL2tIbEczcEN3R3Bjd21acXlJa1hiTEVmd2k5?=
 =?utf-8?B?NFRZNitxeXVzYlpOcm1PR1BobHh6bjI4RmErcUpHb0JNcmxWeFppbmlRRjVp?=
 =?utf-8?B?L3h1Z0s5REdGK3ZZZkh0b3lXbllya0FWY0s1TDR1WGlUYk5CMm9kaHZKNjFq?=
 =?utf-8?B?OEtXc0RuTHRuK3R2Y1V0VUVJV1YrcTVRaXhLbndMc2tXZzRBUnN6ZE9uQlU4?=
 =?utf-8?B?RmhnMEZxWVplODBZVFd6VzVrU2R2MFBhYWhrYVFaN3lHRkV0bFBrR0FDWjYw?=
 =?utf-8?B?eXN2RXZrc1F5T3hVbFBXR0FURzNvbXdDVlFQaklpamxRTU5jWWxuOTVGbTNG?=
 =?utf-8?B?N1dHM0FqdTZrMDJkVW91akZmVTVlZ2w4QVFEWE8xa2FaSFp3eHVNa1c5NlpS?=
 =?utf-8?B?S2ZOMGZhb0Z1VUhpU0Y5R2I4K1VCc3g3OEpBdnphaGMwbEg1OWN4SDJkVGtt?=
 =?utf-8?B?L1RDQ0huK2NCMUExNmNQcDZWOEVKeDBFZDQ3b0hPdnJWSTlrMFlVNDZFcGRm?=
 =?utf-8?B?Mmh4UW5LSnNqWExXSWpjYnFvK1Brb253KzlLQXVNVmVjRkZNVUkrbzJjdnhj?=
 =?utf-8?B?RVRablowc1ZhOFRqMndXcWJtakNDbFN5Qm1SbWovKzZOMFVuS1Y3Vkl3Rlps?=
 =?utf-8?B?VTdzM01KalhLYUxRWC95TWViM2MrM0tpQk5vZ21HZ01jRWp3U2NWQ0oyS3p5?=
 =?utf-8?B?T28zWU8vQThJZXBqMXJaZTRXNk5tcmZncC9YTk1wSlA4cCsrM0NUeUJzU01P?=
 =?utf-8?Q?gkIT/MFNYArR/A9DX9c64e5zU6xEgehf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTZvQXNDMVVDWW1xT1ZaZlEwVmMzNDJHc2hhM3Fkb2xzN2dnY1dQN2RqYWQ3?=
 =?utf-8?B?bURqQVNKTHhtODNwdVh4RWRDSGVTeG5aWTNmb2xlRTRtclZNUTlWRFdMNDJW?=
 =?utf-8?B?cmxDMGFNbHVyVmcxem5SV0dzQXorMWdobk1xWXhOelgxU2RRUURkT1hmOTcw?=
 =?utf-8?B?d1ZvV0FTellIOEhLN1cva1hhd0RGYzNmOXI1UWVyRmFTcWtOZWVWZlRYR2xp?=
 =?utf-8?B?SlRuYVFRLy9FUFpQVFFoRDNyS21tMEVPeGR2b0l3RFRLNXA3akdrMG1uNkwr?=
 =?utf-8?B?dDA5SXpncFpkSmhOR0lDR21GTUN3MzlSV1RZUFErU2o0WHhxdkJrT1U2a0Y4?=
 =?utf-8?B?U2Z2eGhwRmpTazJRZnB3RktMa3k0K01ONVlRRmw2Rkd1cGtsYVJVSGpHRjNF?=
 =?utf-8?B?cTMwOGJSNU5IUm5jeEF3eEtYR0V3dmtIb3FQRjl5VlNsZE9POU1PbkFjaGR6?=
 =?utf-8?B?SDJuYUlUOTBBYmtiTDEzeTRuSXFHU054cnI3YUprTnJPZEMvbnhBU2h4V0hJ?=
 =?utf-8?B?cnZzYXVZS3lvVnR1QnBZVm5keGpabDFtaW5nQWhNZ2w5TEdYNk1YNlFPNTVk?=
 =?utf-8?B?eHFVa3RkbkxLcFZRVEI0eElJc0daQnc0MnZGZzd5UmMvN3ozUkNIOVZQQ1Vx?=
 =?utf-8?B?d0hOQ3ZrTldRbW5hWUVLaFRqVzlMN0pOdTJMMDFObUp1eER4OHdaTFVXTXZw?=
 =?utf-8?B?QXRMV3F4NGV6VEg2dXNiZ1NMTHZTa0R0bFk0QjRsamQ3NjFOMHdrTEhacHpa?=
 =?utf-8?B?TE5FNXl0SG5Qbm1ZQUFHT0JDUUF2VVBuY0ZLUkEvUnNaWDBVT2ZoNVR1blJh?=
 =?utf-8?B?Q2xHNks5WFJacENxUVJzTFlPWEkzS28zZkdMK1J3TVdqMmpMN3NZTlBxQUt5?=
 =?utf-8?B?aUZPdjVqQTBIdVRoMFBGVkcwRUZDWEovYXdheHhibm0yU3R1NHBTT0IrSTky?=
 =?utf-8?B?MHZYbzZlSFhNbnpEQ2ZrSmpiWXBHQ0hzNTM3SG5UeWowQjZVYy9wSWVJL2Np?=
 =?utf-8?B?Q1FEcjQzdFhSK1VMR0JJcUpNUCs5RXliOUZFbVlQRUxDckIxbmpsNjJIaVhQ?=
 =?utf-8?B?RWwwQk9XWXc1S1lOM0htU3dUT0NjaVVxbTJLeWE0a0hJNmtod3Zwc0tsdjBW?=
 =?utf-8?B?Zlp5SDlWU3VpTDQ2Tzg4OHpkZmpSdFJPSWk3V0R5OXdkOERkVzIyYitsaUV2?=
 =?utf-8?B?S3VLcmpFTXdMa1dHcTdlWHJzT1JkbEllb25YcCtqeGVDdjNJdGxqSlEzZks1?=
 =?utf-8?B?VmxYbTNDOUkvVFFoVXdKYTZ4bmlhSkY1REowdEJtOXZ4NDNKVmU2Nlg2WFpL?=
 =?utf-8?B?TWE5SGxiMUl4akV4WWd5NUc4Sk81MTYrMm45ZTJsMEVPb0R3eDVoOUxrT21z?=
 =?utf-8?B?K1JrZGR0c0VMSUNlUFVlV25nWEtGMWE3VVNjR3pYOU9WYUZIdkNlWW1wQzhy?=
 =?utf-8?B?S0dmUllueTBxQjM5VlJuSGFQK1d0TGlWNzFHdnYvTlJ4YTd4dnVPcEJkMFd5?=
 =?utf-8?B?K0N5N0haZzF2WGNSMFNXNXROd2xPWTI0SHMxcFRua3NTbFlxcU9vdEFRZnNH?=
 =?utf-8?B?RnlYZUt0L0FrSmdzcStKZTRCMmoyWlAxYytwMUwxYlRHWDlZOTQwSUpwUk80?=
 =?utf-8?B?emgzRnc4SU9xYmovTGU4UE9zQ1Z1TUFiQ2lMRjZlVzBDQ1AvcGd2Y0c3K2Fl?=
 =?utf-8?B?RkVYQTZHWHFNZzk5eVh5UHZacmdNa2VmNVRwQ3YwY3hjSmV1bUMwLzQ4eHQ1?=
 =?utf-8?B?M0NIWXozelRLU2hmZzBmZzFObFB0QjdMM1JOZ1UzWmtZMmY1bzNMTDVlSVRl?=
 =?utf-8?B?UTdCL0hmeXVQbU0xMEM5c0xXTXFhVmJBclE0ZjlQVUlOdFIyWmdoSlU1YkVo?=
 =?utf-8?B?eng3L2ZCN1cwQWNobnExblFBUm51ajNyVG1NNEVpa3ZUZStibXcreEozak1j?=
 =?utf-8?B?bFgrTElVUlVaZmNrd2JLd2ZBV09obVNBV3NHeWc1ZWd3WXhXS2IwdTg0d2ZE?=
 =?utf-8?B?MDQ4VmkyQnU0d0hUaEhlYmptQ2pKcnZnK3A5NGtnTkxBa0F6SzEyOFJ3ay83?=
 =?utf-8?B?VytudW1wWi9YbGNPcDdpbW15aVVkS09xZStacFZvem5sL1ZPaFRweTVyZUd1?=
 =?utf-8?B?YVRjS3FJSUsyZjEzd1pneGZOeGNEMFVsUWFXUDVXOGRFclo0RVk5ZUVWR1By?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b00bfcf0-aa83-425a-9d0a-08de36834207
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:57:31.1363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cmbTnPQwc5nrWTNgllZIvWchwIAuIhZFZpUKQXEHP8LzpJhb3gw7TFBrY1WNT6PvAPyYAaEcynPMwvFVrYAcSDOvp/EmLUQU4xE8f2mR4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6901
X-OriginatorOrg: intel.com

Hi Xiaochen,

On 12/8/25 12:01 AM, Xiaochen Shen wrote:
> Hi Fenghua,
> 
> On 12/6/2025 3:28 AM, Fenghua Yu wrote:
>>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>>> @@ -42,6 +42,8 @@ static int detect_vendor(void)
>>>           vendor_id = ARCH_INTEL;
>>>       else if (s && !strcmp(s, ": AuthenticAMD\n"))
>>>           vendor_id = ARCH_AMD;
>>> +    else if (s && !strcmp(s, ": HygonGenuine\n"))
>>> +        vendor_id = ARCH_HYGON;
>>>   
>> Since vendor_id is bitmask now and BIT() is a UL value, it's better to define it as "unsigned int" (unsigned long is a bit overkill). Otherwise, type conversion may be risky.
> 
> Thank you for the suggestion. How about using BIT_U8() instead of BIT()?
> In my opinion, 8-bits type "unsigned int" is enough for "vendor id".

BIT() is fine here. I prefer that types used by selftests are consistent, that is, not
a mix of user space and kernel types. 
There may be good motivation to switch to kernel types but then it needs to be
throughout the resctrl selftests, which is not something this work needs to take on.

> 
>>
>> Is it better to change vendor_id as "unsigned int", static unsigned int detect_vendor(), and a couple of other places?
> 
> Yes. It is better to update the return types of detect_vendor() and get_vendor() from 'int' to 'unsigned int'
> to align with their usage as bitmask values and to prevent potentially risky type conversions.
> 
> Should I split the code changes (using BIT_xx(), updates of type 'unsigned int') into a separate patch?	

I agree this would be better as a separate patch.

> 
> The patch may look like:
> -----------------------------
> commit baaabb7bd3a3e45a8093422b576383da20488aca
> Author: Xiaochen Shen <shenxiaochen@open-hieco.net>
> Date:   Mon Dec 8 14:26:45 2025 +0800
> 
>     selftests/resctrl: Improve type definitions of CPU vendor IDs

Instead of a generic "Improve" it can just be specific about what it does:
"selftests/resctrl: Define CPU vendor IDs as bits to match usage"


> 
>     In file resctrl.h:
>     -----------------
>       /*
>        * CPU vendor IDs
>        *
>        * Define as bits because they're used for vendor_specific bitmask in
>        * the struct resctrl_test.
>        */
>       #define ARCH_INTEL     1
>       #define ARCH_AMD       2
>     -----------------
> 
>     The comment before the CPU vendor IDs defines attempts to provide
>     guidance but it is clearly still quite subtle that these values are

I wrote "clearly" in response to the earlier  patch that did not follow the quoted
documentation, implying that the documentation was not sufficient. I do not
think "clearly" applies here. This can just be specific about how these values
are used ... which this paragraph duplicates from the quoted comment so either this
paragraph or the code quote could be dropped?

>     required to be unique bits. Consider for example their usage in
>     test_vendor_specific_check():
>             return get_vendor() & test->vendor_specific
> 
>     A clearer and more maintainable approach is to define these CPU vendor
>     IDs using BIT(). This ensures each vendor corresponds to a distinct bit
>     and makes it obvious when adding new vendor IDs.
> 
>     Additionally, update the return types of detect_vendor() and
>     get_vendor() from 'int' to 'unsigned int' to align with their usage as
>     bitmask values and to prevent potentially risky type conversions.
> 
>     Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>     Suggested-by: Fenghua Yu <fenghuay@nvidia.com>
>     Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index cd3adfc14969..2922dfbf9090 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -23,6 +23,7 @@
>  #include <asm/unistd.h>
>  #include <linux/perf_event.h>
>  #include <linux/compiler.h>
> +#include <linux/bits.h>
>  #include "../kselftest.h"
> 
>  #define MB                     (1024 * 1024)
> @@ -36,8 +37,8 @@
>   * Define as bits because they're used for vendor_specific bitmask in
>   * the struct resctrl_test.
>   */
> -#define ARCH_INTEL     1
> -#define ARCH_AMD       2
> +#define ARCH_INTEL     BIT_U8(0)
> +#define ARCH_AMD       BIT_U8(1)
> 
>  #define END_OF_TESTS   1
> 
> @@ -163,7 +164,7 @@ extern int snc_unreliable;
>  extern char llc_occup_path[1024];
> 
>  int snc_nodes_per_l3_cache(void);
> -int get_vendor(void);
> +unsigned int get_vendor(void);
>  bool check_resctrlfs_support(void);
>  int filter_dmesg(void);
>  int get_domain_id(const char *resource, int cpu_no, int *domain_id);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 5154ffd821c4..0fef2e4171e7 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -23,10 +23,10 @@ static struct resctrl_test *resctrl_tests[] = {
>         &l2_noncont_cat_test,
>  };
> 
> -static int detect_vendor(void)
> +static unsigned int detect_vendor(void)
>  {
>         FILE *inf = fopen("/proc/cpuinfo", "r");
> -       int vendor_id = 0;
> +       unsigned int vendor_id = 0;
>         char *s = NULL;
>         char *res;
> 
> @@ -48,12 +48,14 @@ static int detect_vendor(void)
>         return vendor_id;
>  }
> 
> -int get_vendor(void)
> +unsigned int get_vendor(void)
>  {
> -       static int vendor = -1;
> +       static unsigned int vendor;
> 
> -       if (vendor == -1)
> +       if (vendor == 0)
>                 vendor = detect_vendor();
> +
> +       /* detect_vendor() returns invalid vendor id */
>         if (vendor == 0)
>                 ksft_print_msg("Can not get vendor info...\n");

detect_vendor() returns 0 if it cannot detect the vendor. Using "0" as well as
return value of detect_vendor() to indicate that detect_vendor() should be run will
thus cause detect_vendor() to always be called on failure even though it will keep
failing.

Can vendor be kept as int and just cast it on return? This may be introducing the
risky type conversion that the changelog claims to avoid though .... 

Reinette


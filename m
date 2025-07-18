Return-Path: <linux-kselftest+bounces-37560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD61FB0A49C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE851C44DCC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147E12DAFDD;
	Fri, 18 Jul 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqyTGRPl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD22DBF6E;
	Fri, 18 Jul 2025 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843471; cv=fail; b=O1CUoMwowRaA/xEVuVrACuXpPoGKPADkLGX/Co3mTnBNBinq6XEdn9dU4UdOJQEXhsEQQov3suM+cc2opWFgPIeMyQYhOpOLYl1rCtHhlsOVblwOYNw7quYaebb0Y7XpP2fc/o+f/sqNxJEV3mMfi5C0oTe4I7ym+tgTwOSisbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843471; c=relaxed/simple;
	bh=0srKT2OsvEZPB5ktaa51yyLaOMsOphYW9osO18yFe9k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jnbp4X6llNjzmocc3tQej/fO5ipLsroAmASNU5koonQ+N9Q6V8PD415cqfmGTYdfdyyvDr8dXC65Gu+sKxi8WmkyycxLiSgO4VPsF0+BoS80eErpJZtalgh8Ta8D7JsEkWvV123b7EWKRHxOGaxBiY5YUtB5U7aULVr6udZEiY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqyTGRPl; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752843469; x=1784379469;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0srKT2OsvEZPB5ktaa51yyLaOMsOphYW9osO18yFe9k=;
  b=TqyTGRPlLFIBac8CDoYK6WcJszOeGx7EBGMiiZbDZE+vEe+gOhWEXpBG
   IzGHEBNWTQtb4V1GflZ368eCV4BBgthcCoqqIVYolx5xZDWOZbECktUq1
   QbgTNuBGCJvj9xqJSQal4jk8OT1H36znxvoaABN55FWc+bZ8rqoeDAEaz
   DJ0W7psb3S6Ef0dTwKkTebZeJnzxdRqihS2L9iNoXNWOs6b6R8nkZ+LN0
   fm5ge+X3zItbujuGfF9SbNoMNRaI4Sgf6XQUUiY0B3ZsxomfFEr+nb2R5
   uWSnI/KB02zSHf1wKgRSmAoz4cn+TlNhADncQ4MvVY+YzIxaW94VXQZP6
   Q==;
X-CSE-ConnectionGUID: JrZDxS1dSJCR2OMDrJcTcQ==
X-CSE-MsgGUID: Z796XE1xQG2BjNODdaH/8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="54992423"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="54992423"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 05:57:48 -0700
X-CSE-ConnectionGUID: TOdBXWT3QE+EAOcITBnuuQ==
X-CSE-MsgGUID: adE26l9nQi2N4sEjXXn6fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="157864388"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 05:57:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 05:57:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 05:57:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 05:57:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyBTof750Ca+QR1RUzkPK+0HIVPouOT3CNR1bKEuXNvMkRnnDRddIqmMV6bf9LlmAkoYtrPZyIHIhzi6lGum8OSi6nY6lDI/0H1bwcAOORy9AawR/+tvbIsX/8psuW+WCKkElsC0CRRTEGoKJBWGShFgk7FTFUNslz816lNVlhFly4h8Jcj5ulyk2ycu/q4FTD/X/XtXANf+gEN5sl/Frp5J0yVgQmHHJVKpjTXBtM6iz7/d+7SacmPT8Rn2rJb6WJrlvvuOQPUKW/g+PZ/aLozaZ+id34C5uRxBtkhguDDDxxdpzGthNNE9qU97rjhq1PTt36o+uervlLiHXUN1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqPTM1ubB81T+KwAMYbLXTMIIrKAhslGYAw3F/9FjqY=;
 b=AKx02Tk1B5p+DIrilhniAAI8UlQ3VrKWzKosk1vurdWku9U61+vjuWD55ur5VXbysoDlG4fpkpyIKWJkplQCw4wt0d+nr1h1iq9VL3jcD9gkOelpxP5fdAXaNIgIHkCNy6QAQXqJ44ZG8vTOb6pHpm1vZ0J9NTBZIBKIBj8aKvA9CYzCEGAlJg6Lb1ahtFZ1lVez/KSSACLon8iarcspqAStKrLJvP6G/IfHTB54TiqnyZHZgshj4jKcLk6Dwj80j5p09XIKvPjBdyl6WAtoPeKz9vrrMT/mQ+ntHVCKJJ6P+slxaQWYeyHIbZdjoiLV2ThkGdieVmQmGwjkBUvikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SA1PR11MB8858.namprd11.prod.outlook.com (2603:10b6:806:46a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 12:57:05 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.8943.024; Fri, 18 Jul 2025
 12:57:05 +0000
Message-ID: <5f7d887e-0ce7-4436-80f9-f320e7f5a1e8@intel.com>
Date: Fri, 18 Jul 2025 21:03:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommufd/selftest: Test reserved regions near
 ULONG_MAX
To: Jason Gunthorpe <jgg@nvidia.com>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	<linux-kselftest@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Shuah Khan" <shuah@kernel.org>, Will Deacon <will@kernel.org>
CC: Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	<patches@lists.linux.dev>, <stable@vger.kernel.org>,
	<syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com>
References: <2-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <2-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:4:7c::23) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SA1PR11MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: a9802c4a-b5a3-4876-5b36-08ddc5fa98c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|42112799006|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlhjTmtEaXV3ZWNObUt6ZG5PQVd6WGxUY3FqTUh2SDJmbHBkM09oa3dnSDdq?=
 =?utf-8?B?Z1JLc1VRc2FUWjRGSEkvVTN0cFh1QTJ4aWk1ZkRIdXRWcUhTMm40UnBFS0Qz?=
 =?utf-8?B?OCtIYTJSaWJVTFR1L1dmUVZ3dEpjUmViNWpKdmlCWTZBQy84bDVmL0JNcWRT?=
 =?utf-8?B?REs0N2JSbWp1NFU1RW1DNzZsV0E5WlcwT3RhZDFYN201aVRjTUxWVStxL0tk?=
 =?utf-8?B?Tmloc05jdk1XUFNReklxRGpBRmdscXRXRVVpNGhPYTJzKzNNUWUwTTR2Z3J4?=
 =?utf-8?B?QTN1eWVTUEhkZ25JYkhkUGVXaXBGTEJQcjJ3YUVLRGVldUVZd2RLSWhOOE5y?=
 =?utf-8?B?NEV3eDZzbk96Z0htdHZ4dWs0MlZ4eEpyVVZML2VXVmJpdGcrZ1pyTUpnL2FH?=
 =?utf-8?B?amxWVHpxUFFZa1Q3ckJ1RmtydzNvZ0VzVkZ5RG9CeXdvOWdlRERFeC9nMVly?=
 =?utf-8?B?N2ZYY3cyNkZmcGVXR3F4OHovV1FQcENtUDczcnRWekVkOEdDL3dCYURoWmND?=
 =?utf-8?B?dGkyZnRXbnZKSXhqM0NFK2VWZHF0cUhqWXdXVWlqWWhEWUpqUm1nU2dHMnkw?=
 =?utf-8?B?dUpKK0RiOVZTV2p5SzlpSVltOXZLbERkbks2Tk9uZU55VFJJbXRqK3ZCc0JH?=
 =?utf-8?B?c2pVYmF3L2J3V3o0MGZTZUNZQk5QbjUvZlorTVpzcFJjbDU2UDFNUmtQNy82?=
 =?utf-8?B?TUV1bkd6V0h0VzgzRHp2ZkZQSm44NnVhdEpiM0dwc0pZVnJYem5nN21IUU5D?=
 =?utf-8?B?aExleXozdkFIOTF5eW9SSHV6dmFONWlrWmxBMmVqMkgzNTR2S01wcDdybXpW?=
 =?utf-8?B?SWQ3TjlrZXhEK0RlMU9jQmxRVUdIcGRHMzFwVzlldTdwTzFSUkJ1ck5PUUpD?=
 =?utf-8?B?OVgvcVZrVUhuVmtVZ2lHRnRrQmQ4dUN1S0xsL2pqOFZ0WDl3YWs0MWZncnRL?=
 =?utf-8?B?dWRCWFZaUVdhUXViU3padHNMSGNXbjQ1ZURRS2xpeXk5UmFmQjRPeWtETWNu?=
 =?utf-8?B?dVBYQjkzdldKeFZNYWZrcDlSVHZ1Y29wSDN1eXB0bEQ2azVqUWhNYVE2dGZW?=
 =?utf-8?B?dk1aaVA5MnpJMWFQczhNeDdxY1REbnR2Wi9YN1FjTzE4RldqTlpWQ24ycTJB?=
 =?utf-8?B?N0ROdVE4cExxYzA5M0d5dk5lMW91Nk9iSjVRK29WRlVKcUxodkZtc1ptVStH?=
 =?utf-8?B?ays0L2lEcXJ5aDJoY0RRc3hITG1ZRnhqa0RCKzZwQXZwRjNVWk1XWjFRTFpI?=
 =?utf-8?B?N2Nwcm0zeE44VjJTdmYrS3l4a1ZGaWM4ZXI4ZHM0bWRjTWlZcGtCcDRtdkE5?=
 =?utf-8?B?QmVubFNiZlFjNml0azNLcjBtWTdtT2I0V29mNVVQd04wV05wcENqUVFDeDZJ?=
 =?utf-8?B?cHpZOS9wTmVMTWtUWHNXK1BXMlRTT1k4MEZDYnpNU0xPWUNqM1dpNm9BUHJW?=
 =?utf-8?B?azdISnFQNTIrUE1kd05udTlYVWxvcVFSYUpQUjlESHJkTkIrTnJIZDJmUHJr?=
 =?utf-8?B?eHkvb0M3eDl2K1NRZ2Y3ei9zSzBsME8yb0QzRzc3NGRQazlxenJPalMyNHZ6?=
 =?utf-8?B?TnZvWHpjNDB4aStxbjFuUjZ4Wnd0bUJNZC9xVnNOSi9CalJCcTRUa091eW9N?=
 =?utf-8?B?Y2VHeVFlTlpJbngwbVQzZzNXNUZ2eENPY2NQV2xNM1FxZWZsYjMwdTJwSUR4?=
 =?utf-8?B?ZTJBcGdPd3ZSakV6TGNocmpURzNOL3phRmh2bDQ1bS94b0tWNmFQQXMzSmgx?=
 =?utf-8?B?TmxYRHVzeWtONlRZblFLZ2Q3dDNTWVQ2SUs3dXM2bUVkNXdyNkVxVVJpUzcy?=
 =?utf-8?B?MnNyRnp3SCtHNkk0bDUrV2tHY0FZSkd1aWJZaVN1a1ZFRGxJQUVYdWlBdFNE?=
 =?utf-8?B?MU9pVms0dER2Y3hpdVp0RzRUK3pLdzNZdzZ2cWZWV1BBTUdCVWZCOE9VaUo0?=
 =?utf-8?Q?6kWc3Ud5XxA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3974.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(42112799006)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWZER1l5WlU4bjZrTWFUTEJRZnBUZ0ZRc2dJbFZlQnlnY3RzYkdjSzBiaW1D?=
 =?utf-8?B?Sm0wREtJT2dEWFhuVmxKUWExbURzNGUxZmowVmozTks3VTEvL1ZIQlBUV1Bl?=
 =?utf-8?B?MXZSQmhJYmo2TElRdVlGaG50Z3VaQTdJK2RnaEk4ODFtYWtiTGhVV2NBZlVr?=
 =?utf-8?B?clI3b0N4UlRnNnhnV1hYc0F5Um1wVTFycyttMEdsYWhCaUZlZUpCem9vZDdQ?=
 =?utf-8?B?UTEzOEF4K0lFeTMrSjZZV0wrMlRFTnprM1Qrb1FMRmk2UjFwUlVNUmJYbDBW?=
 =?utf-8?B?eWp0cXBUUnpVeVVFVXQ2QXFYMmZ5cS81SXZNMXdGQ2hDbFlrSE9IWU40SXpX?=
 =?utf-8?B?dTVNMDJvKzkzanhPUisxbDZQV2lSb2lBSkxkbDdGc0lXOGp3ZndmSjBQS0Rk?=
 =?utf-8?B?bE5qdThsRzUvTG5DRFk5cm16aHB0dkl5V3JYNXhWS3YwbmlRYmdkZ2Y1M2t2?=
 =?utf-8?B?N3lVay9UWUNUT1ZteWlnZ0hqVmN2SFdFeHMrVy9DNEFyNHdOUW9uTFNvWmNM?=
 =?utf-8?B?ZFhaRm9iZExlMWNaWDVvbzQ2SXk4Q2VpUjZMSXQ3STNkaGMzd2JjZ3pXUGo2?=
 =?utf-8?B?RUxwK1RGU3U0ckR1UEhkaC8yYmpwNzlSSEpRZDBUKzFMZGJSSCtzamJVVU5E?=
 =?utf-8?B?V2Exd1FwS3cxbFdnVks5QWNLbFZaaXNNbmhPbzNDNHZoRmt4ZTlJSCsxY1Vk?=
 =?utf-8?B?VTM5Sit1eGQwUGpiOGIzNm9BMnQwMHBTdE9rRzhBOFBldVF2QUc5TEJRenlI?=
 =?utf-8?B?TU8wc3dxcHR5NFg3TmhTb1dYSlh4U045R3VSZ1VaUGVlUWpFTXNNMjhKUDFX?=
 =?utf-8?B?NE5FQlNWTVJjano3NmhhRkNlbVl4ZUxrcW1tTEo1VTE0S053THNicTFIbGww?=
 =?utf-8?B?RGNvRWpiL3pad1NkYzBPUm4wMDZWRnhodTZ3aWJnVWRUeDF1Z05EeEpvRFVa?=
 =?utf-8?B?MHMvdFFoU0JRakMvRXJuaUJUQ2hseStJaHR4Z1UvaHpIaExUM1hWOVJ4VTVl?=
 =?utf-8?B?WEs2OXU0MUtuWVJzNGhmNUx5YUhLYk5MUXdYR2x0UTQ5VmZNY050RkpoV1pv?=
 =?utf-8?B?S1pTaTJQMWpXNVpDeE9QR2RDaG9vNXovdnNPY2szWE45RUNjTG5MaFlVM09w?=
 =?utf-8?B?Q0tvWjZ3UDZUREZZK0xxc1RtdW43NXI3V1lId2hUMEZxbStWVGtFOVpvUUVx?=
 =?utf-8?B?VVZ5M2d3QVdVUi84YUZYRU1uSTJVZ3hKZkNNRlEwK3N0VUJzekF6TDk5cTRB?=
 =?utf-8?B?bXE1aXZ0UkU3cy9lVW5KWk1tL0ZaRnl6TWpnQVNVcnord2tMcXpCb2IzWEtO?=
 =?utf-8?B?RGlwNHhNdG9mcmgrcExnL1B2Mk5qY0htdHF6Yzk0Y2JwN1pjRDN6NnV0WTFu?=
 =?utf-8?B?ZXIxN1lOajdTbkQyaDFuRzVnYjQxM1ZZOGp5aVorMldJNVpwMm4rckZCVlMz?=
 =?utf-8?B?YjRSMk1BUkFwRzN0Vjg4dDd0Y3N6QjdSd2ZyOGNlcldaRzVYWm4rWTkwTEdt?=
 =?utf-8?B?REJreGR2M1l4YjlsdFVBYlN4VVhqNnBTSUlIN3dnRXBiaks3bkpodDBFNnZS?=
 =?utf-8?B?bEdSaFBleFl2cUM3R0dnYXdNRFFHaklTbWRtQTlHWlMyNG5uSVBvWEo3S1Bm?=
 =?utf-8?B?NnJCdVJWcDQrWUNXMGUwZDhTcmdLNm9QanJFKzlMaEozVFV3L1lNYUN5a0F2?=
 =?utf-8?B?alppazhBa1IrTGtsdzhJSW44WWlla0Z4cjNaNUplazBNRGF4S2cyajN6WmRn?=
 =?utf-8?B?clJ1NTU1RDgrVURnelZoYjZwaFBsY05PRlU2bVdXTkYxTXJPZHVYNkZETHlh?=
 =?utf-8?B?bWFyRzRkaFBHRTVnYnB4RUhqb3lSalBIWHBBTTlWZG9sdm5zTUF4U2lvUGNx?=
 =?utf-8?B?cFk3azllWGdjMlRJU1VVSzZ0Y2hMdTMzNW5vU2hMVWtLYkpCdk5EVjE5alpm?=
 =?utf-8?B?S2lVdDNEZnJjUWJtd3BoUWhMeHJ6VWtlMHFQdUhEUEs0YVl4eDRZbE9LYy9y?=
 =?utf-8?B?enl0NU5UUldRaU03WGJSVWJMaEFBdytVOUh3S3VNR0VCdEU0b1FRYlloN0FJ?=
 =?utf-8?B?MEpMY1dkU3I5RklJSlAvTk9ScGpVbTZmeEw2Ull6QldUSSszbkprT3JqNWxx?=
 =?utf-8?Q?9RXn+JSWSWIkpAwm/GvWAJfVZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9802c4a-b5a3-4876-5b36-08ddc5fa98c7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 12:57:05.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBgi2wsktXzGEuSEU+DGxtL9e2Q3X2jwNip1HBYcoJ5gYuZ/zUg4e58bUBERA/deRDq46kaDKXZZexgpTKhnLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8858
X-OriginatorOrg: intel.com

On 2025/7/18 03:15, Jason Gunthorpe wrote:
> This has triggered an overflow inside the ioas iova auto allocation logic,
> test it directly. Use the same stimulus syzkaller found.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   tools/testing/selftests/iommu/iommufd.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

run it on intel x86. this test case failed without patch 01, and passed
with patch 01.

Tested-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index d59d48022a24af..d9df92e27264b1 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -968,6 +968,24 @@ TEST_F(iommufd_ioas, area_auto_iova)
>   		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE * (i + 1));
>   }
>   
> +/*  https://lore.kernel.org/r/685af644.a00a0220.2e5631.0094.GAE@google.com */
> +TEST_F(iommufd_ioas, reserved_overflow)
> +{
> +	struct iommu_test_cmd test_cmd = {
> +		.size = sizeof(test_cmd),
> +		.op = IOMMU_TEST_OP_ADD_RESERVED,
> +		.id = self->ioas_id,
> +		.add_reserved = { .start = 6,
> +				  .length = 0xffffffffffff8001 },
> +	};
> +	__u64 iova;
> +
> +	ASSERT_EQ(0,
> +		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
> +			&test_cmd));
> +	test_err_ioctl_ioas_map(ENOSPC, buffer, 0x5000, &iova);
> +}
> +
>   TEST_F(iommufd_ioas, area_allowed)
>   {
>   	struct iommu_test_cmd test_cmd = {

-- 
Regards,
Yi Liu


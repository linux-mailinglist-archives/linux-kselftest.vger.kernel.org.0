Return-Path: <linux-kselftest+bounces-9899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938E28C181D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 23:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CA3282AB1
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA3384D08;
	Thu,  9 May 2024 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFLrEKx/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23984E05;
	Thu,  9 May 2024 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289042; cv=fail; b=r+M7PmruQrJaPnokT3DOxyTDD5LwxZhYx9UZlCB4197Hwqw5KC2cwNR+gSVCBuD25Mp1DcMdA8ATwz7ab+/rf5ZGDXn7Zpt90CIP/VJBD6ytoflYXDVVRyrr6VcGIWmTWEWeHULX5ghjCE5DLWp6knYZ+bi4Xs1fqdRcW5qlxSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289042; c=relaxed/simple;
	bh=Gc1A/fbAEntlXu4dchHkwjWgR+nqMvbIsAtgQJljQSo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pkr/l5xW+TGHn/t3q0qJbbIkqE9T0dDZpnA1AS4fxXYitKB2PzKmFetQ2OPLWdWJKuTNLaNS76Be3PtW2YZf6bXg82jP9pkut+CR3nVn9s/gmqbCjisSh8TC3SyJ+D467IDpkA+MYjnjfIfWDxfWw+plcUhn0TnXChOC1QZxnkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFLrEKx/; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715289040; x=1746825040;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gc1A/fbAEntlXu4dchHkwjWgR+nqMvbIsAtgQJljQSo=;
  b=IFLrEKx/q47xHX0VqlHs8OnLGpj2hff7hNyQ5GFyxc8DofUm2oGPVNbI
   KM+KH/96t2Bi2smDTMsCmlkJFEhxSFD/65xqrv9RKdptTk7qjYX31IDPz
   WjUTb1sCBqA1xL0XsoukW/A/Ff/o9zBB32LY1thBjcYiXP3TsXYaek78Y
   oU7zlUvW4/44CgzKiScQZGsgKTLaeH24B/T+d1V2VHS8oDji3OyZ0vUUV
   aut1dzgPuqrDj0wEDJqDCD2InTgWahvZHnJpUxZM8v9QRcie0XiXsFuMt
   tTr3A4KJxiBSM7KUQYfn8VxIJzfm/if422PvyjnC8RpI4yRxCG/zekAMW
   A==;
X-CSE-ConnectionGUID: KLzrBDRlRZCYrf85ANcKPA==
X-CSE-MsgGUID: vB+VJ+WKSv2xA180R8IWoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28726417"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="28726417"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 14:10:39 -0700
X-CSE-ConnectionGUID: 7+fycDsOSgSxK4iKRNO1Mg==
X-CSE-MsgGUID: Zwt2Tcf2RB2isPJurDkHew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="33915414"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 14:10:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 14:10:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 14:10:37 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 14:10:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHqlRKceG45PN21uK9pGZ6ONua8BXMKrCywm+vrUbhiNSQ69ctchyjx+QzMHSmsj6+jVgsXcncaShW7+OQLHsgc6DnZaQgoL+b2HwXhwvJ7VydwF+cnlLucQLlFN1UOTHigYLFKa4fLi3JH1dMx6Sp3W/yZ34n+Fk/DDL3EyeOD5p7UJscKW4ReyzPhrvDB9z/eim5VJNz17mToi6wsQp2/2JYKZ9W3weqfRsyvjmWvGZf7dhsj0uYs8XilTDErQnnDSq8L3CMUdxoaLWSUN/sdHqOKTSeAnTwSWjgC4eqq2kYiJXLgx3tvvcIuBnjvAhXJvnDFSizZog3D1K5XfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFvr4i/EjmVdBbRJYScucO7wlrCTTxVZ6cky1jqDMTU=;
 b=cRJFSIk1t/Sryalk3sixekeTjDkxI0oedp+kUwojYf74h9699a7PDINkCTtjA7Ok14t00fzrPH7HzPHi+s3RiB6WpkXErp0jInLrm/989cYSVoWO6MzkCuy+/kgP48K2y3xB+IbJOqkor5I2TD4qFKstfFelaLOPoYs/epQabA05qlVgQ9aEHy5ncWOXsC7G+4qi+Tuh4xqC62XDxgkUyVUqoGInDghOzGuNkDzV8DJu7QKxmqjNRyQFJL+5339M49I5eco1ukcJcJWzAz3oRal6q83lu8RL8smXfwLmkctMWWuATHW9sfqtPHzN/+QikWIR+SCjpnxEX+ZEu7Fn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW5PR11MB5786.namprd11.prod.outlook.com (2603:10b6:303:191::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 21:10:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 21:10:34 +0000
Message-ID: <4545fff1-b95e-46dd-9c79-c6ae8fbb501a@intel.com>
Date: Thu, 9 May 2024 14:10:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] selftests/resctrl: Rename variable imcs and
 num_of_imcs() to generic names
To: Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1708637563.git.babu.moger@amd.com>
 <cover.1714073751.git.babu.moger@amd.com>
 <c81a31bbc9385091a2e6b9da0c935ff46687179e.1714073751.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c81a31bbc9385091a2e6b9da0c935ff46687179e.1714073751.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:303:87::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW5PR11MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eee39ff-5f97-4eee-834f-08dc706c776c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGxqeTAvMVNYSWhCaW82dHZCdStFNS8xWnduSUN5S1pEbWVmRWRRNkRuMGRR?=
 =?utf-8?B?RVNyRy9UMW9TSVBnVFFKeEVNdURKYjl4UCsraFlQeWhCUE84OENvWXk1QWEw?=
 =?utf-8?B?YUpISWxOVmVIQ1pSd09kamlveTBuU2VwK2I4MnZ1RzZpVDVuOGE5MTNxVEZi?=
 =?utf-8?B?bzZiZk5XZ3pBbTJkZ1ZWdVFkVEZoWVRHc1RVQ0NOdXpNRFp5bHBGZlVEL0Vr?=
 =?utf-8?B?b25IVTJRVkNPVXptTFc5ZDNyTklPOTdWamt5eVlKY0gzZU5VM2V2YU9uZXNZ?=
 =?utf-8?B?bHFMSEdKZnlVdFo5MHkrYWNlS04rNWRKbVl6aGZQYUk3RlBKNE12ZVRPNEFi?=
 =?utf-8?B?Z3BDRmEyQjZUbDBIaVZvSmZLKy95Zk1vaVI0bGVWempqQ2lrZE43RGZSN2F5?=
 =?utf-8?B?Ym1LdXBDaVJTenZMMFNpRTBnbzNUME1FYWxyZDdxNVVsRXlhaUhuNEpqS1dW?=
 =?utf-8?B?cW4vUEJKZGdwRTg3b2gvY0pwRlNHYjN1TThCT1BmTVgrSnlNOUZBYmVKYWVn?=
 =?utf-8?B?VWZCaFQ0MEUvUVdsR3VKRE5ZVXBTejdEdmloSm10d1dhdHNJQmU3dW41bmhZ?=
 =?utf-8?B?SE12YTFsU3F0bFpQVDBFR3pIb1V4M29nSHJsMlp3RE9NdXYxS3k1b05NNkNr?=
 =?utf-8?B?NU12dldZZUVUNVZveDZxdjFGci83bHJGUEs2RDNCMHhMRnU5WlFUUWIySXow?=
 =?utf-8?B?M1kzeU9uZWNWNzYvU0hMb1didEhmVHVzMzAzWW1PMkFXOVQ1TGdXcTBhY3Iv?=
 =?utf-8?B?VVhhRXFUS3prRVNVL3NRTHg4YWlHS2Y5RUxJL3hUZWRLZVcrVTlBWjJEcHFZ?=
 =?utf-8?B?SVRXNkFWdm5pUk9WUzNzU3ZHVWVyNmdubTBRaHZjakNmMkpZNlpjVElKN0Vm?=
 =?utf-8?B?eGRrVHRHUkc2S0xpUmdqVGowa0ZweFUycE5BaFBhTHB0MmVtVXhiVThBRCsr?=
 =?utf-8?B?SGlmUGhNbjVvb1g3d2psbm1VWGRRckRkRTU2WmNJdkdHbGVmK0ZLTE5Dc3dW?=
 =?utf-8?B?TDNkamZGTVRrdUZDcHpHNzFmY1ZlNkNCL3AwSkl6ckxzNU1jTXhFaEV3YURQ?=
 =?utf-8?B?NllFSjYxbXNwWDN0OGRvK2paSUJEM2c0OUYvS3ppSmdGTXZ6MnM4cXJFRlZB?=
 =?utf-8?B?eFphRXNwYU5wS1drZE94WXhYOVNZME1rcC92cEJZSFppNjIrdkZLanVmOVlC?=
 =?utf-8?B?V0lZOUYyZGhZK3JrRU83eWxEVWxjUEp0TXVCTCtqOUtRSHNGR1lMZGpiRzV2?=
 =?utf-8?B?OEhIM3VEYkt0S3p6eGlXNlFUeEtOdU1lZ0ZaZHUzRGhtNThjcXUzV0FlUSsy?=
 =?utf-8?B?VnZxZFJTT1hvd3k4WG1tY2J1dDF3Z2Y0WVB3R1I3MWtSQkcxU1l4UHhsQnpZ?=
 =?utf-8?B?NFRzRG1URlcyS3JHcUtaTkt2VWlvRUM0aTRLamlhd1M2akdRbVJna3dJaUo0?=
 =?utf-8?B?NFZNUjRzdzFCd1Nkd2x4ZUkvbk9Mek94QndmLzdHK3pBS0dUQU5VZ2FncG5T?=
 =?utf-8?B?ZHpKNmVReVdKSjBLWFRnY1V2RFF3SHNwZWRJMkRyaVoyL3I3MDIwNGM5ZWR1?=
 =?utf-8?B?eUJjMUZ2ZXFSbURNdkcyWkZObXVZbHMvdEozK21vMUo3VHpFZkRmbXo0SE11?=
 =?utf-8?B?emE2bUh1MlFUczU5anRVTUVyb3Q4Vnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFOVTI5cFdqem5GQ2pNK3B3M0ptZU95WEt6OWJUdmNhanB5dzM0ZmFwZUZQ?=
 =?utf-8?B?QnZ0VWlCSWxtUWUrMkVKcUE3eUMzQXptQ2trOVFNMGJSeVVpL3Y5TytwRUw2?=
 =?utf-8?B?Z2RiV3d1TU44T3M1bmtHajBjclZkYUZwTVhkNUVBQ2g3VStRUTlGUU0wTHdO?=
 =?utf-8?B?YlVqSUxURldpRjVNK2xzZUlBbjVVYndlV1pIOVNOTUI5Nmh1dnB4TCt5TFA2?=
 =?utf-8?B?VkdDTlllSVRxUnlrcjNQSDVtMmJob29tMm5aeVE0bXpETGZZUVh4Z0x2RWp2?=
 =?utf-8?B?cHNBVGwyRjF2eHJRY29kKzhtNlFKOXdjVmhKUFFZeDloSFQ1NmZTbWkrYjAv?=
 =?utf-8?B?UElaMDhYM0RuZVg2VE5JeThjTitwb1g3ZU9MZjZObEdOaVBpYnF5MXBXQ1lK?=
 =?utf-8?B?TlNNRnZuTnd2a01TZmdRRy9weVZacjZrcHVKQ2xyNEdVTTlUakI3S3BQdEdt?=
 =?utf-8?B?T1JML1NtdzFCSWk0NFBDcWhaTG9tbnBzcUlPVzN5T1A0UVY0bjNBelRHMHYw?=
 =?utf-8?B?Y3lJaDcxcTJnWHRTeC9TTGVYWXg2cVZXV1ozZWlDN2syOEZNY3c4cDRLdWZy?=
 =?utf-8?B?bmIyOTlscDdxb2p0dTBqaGhzeVlraFZUa21aZjAvSXRFWUdwWFNiem4vSEdn?=
 =?utf-8?B?eUFIZUlrRzk2T0hSTVFiTnp4dXMxQTliZnlDZzN5N2R6a1RHZFRWMHlCV0t5?=
 =?utf-8?B?Y1hyVG9heHQ2MUhHWkhCZ0hsVStVZ243cXQzekdhSUFkNWVISUNacGdic1VM?=
 =?utf-8?B?MGwvcXN2ZHY5VUxkSUlUaDdaZGc0dEpmSHJLaDY0Uk1SU3dPMnY2a2MwbjNP?=
 =?utf-8?B?OC9iSW9XaUVodlN4OHFxTHIySjJhSUw2a3ZjSnEzZlQ0SWdxdE5nQTg3V1Mv?=
 =?utf-8?B?NjQwVm52QVl4cHRYdEF0NDhSbGNJOGUrZU5lWHFNaUVYTnp4clU0dXVIdU5Z?=
 =?utf-8?B?REJGZVUrdXB1QXg2NmcrNjl5bG1Rc1g2L1JjeHI3bmNJRGtOem9yRjlvUEFL?=
 =?utf-8?B?YkUxMnR6UWgzMEEzM0hlUFFmeDc3Zkw2MjVqak40bTJwTlN6U1ZSQnVwRS8v?=
 =?utf-8?B?ckhYZmdZbHMzc3M5Q2ZCcTFmaTNMZm1wQU0yc2RSa2pSWHE3TzBPS3NqWEhy?=
 =?utf-8?B?YW9lVVNUaHlQT05iVnlhOHdCZ05RdVBvZC9CdVpDZUlKQnN0SmkwTm5TN0w3?=
 =?utf-8?B?MS9jK2ZmU001dnZ4ZjNmQlhZMHZidUxNQTAzZnd6TWpHbms5YzIyQXVrQ2Rr?=
 =?utf-8?B?bzRDeXNPRFlpMFJhdWF4SUZOdkV2djQrazdmejF5RWpYSmo1dUROdUllbndG?=
 =?utf-8?B?aUhwU01iRWp2dWNvY2NOa1BndVpzdERvemtFeFcvNkJkM29rdjdrK3ptK2ZJ?=
 =?utf-8?B?TmlXZlFDMUtkSnZTMytjUjVQa1VoaFBNSm1na1RmMHlzbEFKaHRiM2lsM0kv?=
 =?utf-8?B?RVRjSVFhcmlBTGZON1ZmZEd4YnJKUERrVWxxMGlYemswZWFBK3FGNHlJWjRx?=
 =?utf-8?B?MCtSUWE2NlVOZ1M2YTNmZ1pCREtCQ0V4QnJFN250WVBJR2t5UE05dUFtWXJw?=
 =?utf-8?B?UC95dFQ1TU83NUVvZWl2bVFNeW1PS25PT1o5ZVBkbitkLy9JUkx4RENxR2Vt?=
 =?utf-8?B?aFREeXNDcXY3d1ZTellPeDRlNEdZRmp2WC83L1U0MFRBcmhrOGVBbDRQN0ly?=
 =?utf-8?B?akZlWXE4U3BuNWVFaGg3c0d5UFM2V3lGam5SQ1lzbWRPcC9UUkFTYzFyY0RE?=
 =?utf-8?B?WmNwMXpqbFV2QjU1alY1eEJCa2pCanFFMG5adW1hVmhwM1d1RUk4Z3Y0enQz?=
 =?utf-8?B?dGhxTFFwZk1mcHlsQUhSa2QvMTk2cDNLcnVxTC9ybHFhYkZ4OTN0cWtPeHhl?=
 =?utf-8?B?YTF6T3poYUhPWjMrVm5YL0lsVldEN1lhNlluUUxwbmVlb0lYcnVCS2s4b2hB?=
 =?utf-8?B?QW1OZHdJRHVVOHorMlgvdUtnVDJ2R1o2WFQ4cFA1NGxjK1FGVzlaTG9jSnps?=
 =?utf-8?B?MnpjN0JxNHAzc2duUUV4cjR6Lzh3ckQydWhBZ1AvQmwvSDdUS0lHa3FCNnE4?=
 =?utf-8?B?NjVUVGI0Q2d6bkE4L2hzN0QvWFIyZVduckhpdXlOZFQ2ZHVLZ1JWMVZQSWN3?=
 =?utf-8?B?SjdjWW9hY3F5aloyTHVKMFU0eDhaYXZnU24wZVJQd3dnUDZic3p2dHEvbWZO?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eee39ff-5f97-4eee-834f-08dc706c776c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:10:34.3371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRnxjMfhCuncBioYjunLXgxxBmIyAPAXwHQ5kl+eKQAE95p+geLTpWunudq5JznzYK37SxHZ17CBzGySfRyeHZMjtKWDbFk0tmKzjjHPJ9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5786
X-OriginatorOrg: intel.com

Hi Babu,

On 4/25/2024 1:16 PM, Babu Moger wrote:
> In an effort to support MBM and MBA tests for AMD, renaming for variable
> and functions to generic names. For Intel, the memory controller is called
> Integrated Memory Controllers (IMC). For AMD, it is called Unified
> Memory Controller (UMC). No functional change.

This is a resonable change yet the actual changes seem inconsistent to me.
Per the changelog the goal is to switch from "IMC" specific naming to generic
"MC" naming in all the code that will be shared between AMD and Intel.
From what I can tell this patch only changes *some* of the shared variables,
functions, and data structures and it is not obvious to me why some are
changed and some are not. This makes the code inconsistent.

There are many examples of the inconsistencies in this patch alone that
I will try to highlight what I mean without considering areas untouched by
this patch.
 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 59 ++++++++++---------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 5a49f07a6c85..a30cfcff605f 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -60,7 +60,7 @@ struct imc_counter_config {
>  };
>  
>  static char mbm_total_path[1024];
> -static int imcs;
> +static int mcs;
>  static struct imc_counter_config imc_counters_config[MAX_IMCS][2];

Global "imcs" is changed to "mcs" ... but why are
global imc_counters_config[][] and its struct imc_counter_config
not changed?

>  
>  void membw_initialize_perf_event_attr(int i, int j)
> @@ -211,15 +211,16 @@ static int read_from_imc_dir(char *imc_dir, int count)
>  }
>  
>  /*
> - * A system can have 'n' number of iMC (Integrated Memory Controller)
> - * counters, get that 'n'. For each iMC counter get it's type and config.
> + * A system can have 'n' number of iMC (Integrated Memory Controller for
> + * Intel) counters, get that 'n'. In case of AMD it is called UMC (Unified
> + * Memory Controller). For each iMC/UMC counter get it's type and config.
>   * Also, each counter has two configs, one for read and the other for write.
>   * A config again has two parts, event and umask.
>   * Enumerate all these details into an array of structures.
>   *
>   * Return: >= 0 on success. < 0 on failure.
>   */
> -static int num_of_imcs(void)
> +static int num_of_mem_controllers(void)
>  {
>  	char imc_dir[512], *temp;

Similarly, what about imc_dir[]?

>  	unsigned int count = 0;
> @@ -275,25 +276,25 @@ static int num_of_imcs(void)
>  	return count;
>  }
>  
> -static int initialize_mem_bw_imc(void)
> +static int initialize_mem_bw_mc(void)
>  {
> -	int imc, j;
> +	int mc, j;
>  
> -	imcs = num_of_imcs();
> -	if (imcs <= 0)
> -		return imcs;
> +	mcs = num_of_mem_controllers();
> +	if (mcs <= 0)
> +		return mcs;
>  
>  	/* Initialize perf_event_attr structures for all iMC's */

Note comment still refers to iMC

> -	for (imc = 0; imc < imcs; imc++) {
> +	for (mc = 0; mc < mcs; mc++) {
>  		for (j = 0; j < 2; j++)
> -			membw_initialize_perf_event_attr(imc, j);
> +			membw_initialize_perf_event_attr(mc, j);
>  	}
>  
>  	return 0;
>  }
>  
>  /*
> - * get_mem_bw_imc:	Memory band width as reported by iMC counters
> + * get_mem_bw_mc:	Memory band width as reported by iMC counters

Comment still refers to iMC

>   * @cpu_no:		CPU number that the benchmark PID is binded to
>   * @bw_report:		Bandwidth report type (reads, writes)
>   *
> @@ -302,40 +303,40 @@ static int initialize_mem_bw_imc(void)
>   *
>   * Return: = 0 on success. < 0 on failure.
>   */
> -static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
> +static int get_mem_bw_mc(int cpu_no, char *bw_report, float *bw_imc)

The intent of the function is to "get" bw_mc ... so not renaming "bw_imc"
seems like a miss. Especially when considering that its caller does just this.

>  {
>  	float reads, writes, of_mul_read, of_mul_write;
> -	int imc, j, ret;
> +	int mc, j, ret;
>  
>  	/* Start all iMC counters to log values (both read and write) */

iMC?

>  	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
> -	for (imc = 0; imc < imcs; imc++) {
> +	for (mc = 0; mc < mcs; mc++) {
>  		for (j = 0; j < 2; j++) {
> -			ret = open_perf_event(imc, cpu_no, j);
> +			ret = open_perf_event(mc, cpu_no, j);
>  			if (ret)
>  				return -1;
>  		}
>  		for (j = 0; j < 2; j++)
> -			membw_ioctl_perf_event_ioc_reset_enable(imc, j);
> +			membw_ioctl_perf_event_ioc_reset_enable(mc, j);
>  	}
>  
>  	sleep(1);
>  
>  	/* Stop counters after a second to get results (both read and write) */
> -	for (imc = 0; imc < imcs; imc++) {
> +	for (mc = 0; mc < mcs; mc++) {
>  		for (j = 0; j < 2; j++)
> -			membw_ioctl_perf_event_ioc_disable(imc, j);
> +			membw_ioctl_perf_event_ioc_disable(mc, j);
>  	}
>  
>  	/*
>  	 * Get results which are stored in struct type imc_counter_config
>  	 * Take over flow into consideration before calculating total b/w
>  	 */
> -	for (imc = 0; imc < imcs; imc++) {
> +	for (mc = 0; mc < mcs; mc++) {
>  		struct imc_counter_config *r =
> -			&imc_counters_config[imc][READ];
> +			&imc_counters_config[mc][READ];
>  		struct imc_counter_config *w =
> -			&imc_counters_config[imc][WRITE];
> +			&imc_counters_config[mc][WRITE];
>  
>  		if (read(r->fd, &r->return_value,
>  			 sizeof(struct membw_read_format)) == -1) {
> @@ -368,9 +369,9 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>  		writes += w->return_value.value * of_mul_write * SCALE;
>  	}
>  
> -	for (imc = 0; imc < imcs; imc++) {
> -		close(imc_counters_config[imc][READ].fd);
> -		close(imc_counters_config[imc][WRITE].fd);
> +	for (mc = 0; mc < mcs; mc++) {
> +		close(imc_counters_config[mc][READ].fd);
> +		close(imc_counters_config[mc][WRITE].fd);
>  	}
>  
>  	if (strcmp(bw_report, "reads") == 0) {
> @@ -598,7 +599,7 @@ static int measure_vals(const struct user_params *uparams,
>  			unsigned long *bw_resc_start)
>  {
>  	unsigned long bw_resc, bw_resc_end;
> -	float bw_imc;
> +	float bw_mc;
>  	int ret;
>  
>  	/*
> @@ -608,7 +609,7 @@ static int measure_vals(const struct user_params *uparams,
>  	 * Compare the two values to validate resctrl value.
>  	 * It takes 1sec to measure the data.
>  	 */
> -	ret = get_mem_bw_imc(uparams->cpu, param->bw_report, &bw_imc);
> +	ret = get_mem_bw_mc(uparams->cpu, param->bw_report, &bw_mc);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -617,7 +618,7 @@ static int measure_vals(const struct user_params *uparams,
>  		return ret;
>  
>  	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
> -	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
> +	ret = print_results_bw(param->filename, bm_pid, bw_mc, bw_resc);
>  	if (ret)
>  		return ret;
>  
> @@ -795,7 +796,7 @@ int resctrl_val(const struct resctrl_test *test,
>  
>  	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
>  	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
> -		ret = initialize_mem_bw_imc();
> +		ret = initialize_mem_bw_mc();
>  		if (ret)
>  			goto out;
>  

Please note that this patch conflicts with other in-progress work [1].

Reinette

[1] https://lore.kernel.org/lkml/20240408163247.3224-1-ilpo.jarvinen@linux.intel.com/


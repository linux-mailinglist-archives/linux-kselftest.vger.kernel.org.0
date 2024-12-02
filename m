Return-Path: <linux-kselftest+bounces-22706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E99D9E07F9
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 17:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B491616CC2C
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8541520897A;
	Mon,  2 Dec 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GE4f0NSF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5A204F9B;
	Mon,  2 Dec 2024 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152809; cv=fail; b=KTjFidlsMn/+pOdu2ZbKrX1KlrYMIxB/eVeKdJpMCtXl55GFpcGHEAIPL1lUF+/2m0qPlIk0ZroJlHAOC/iUPzhXR9YUucE9t7Nvqgzm+injfIFjVFKRequVOIVjIEAsmcBGJunpm7nPGylTlmgnPNtm+Kzw8CU6y975a81dD84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152809; c=relaxed/simple;
	bh=8LEAmV7A6G+wnJwfWJ509vzhPI8ZgMAGrnZHS9RLjjg=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UtfmYDDEKhQfoYg7riul3oZoDPRUvtZHEFSDE8Jlr4Yc3SOceKYkFhYp5XxAQ7WXZHSHdWNiLpprdNhBxCNwE3HemOS+z6FE2NcQfJ5esTAnoKmI1HFtMUm0efu9DCDk68Peco/3Z/Kzf6dg6YjlAvnoifov2Dim2Y0SXdIpt50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GE4f0NSF; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733152806; x=1764688806;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8LEAmV7A6G+wnJwfWJ509vzhPI8ZgMAGrnZHS9RLjjg=;
  b=GE4f0NSFOdCYARTfKM9yiVb1eiCLk7udfQaZp3c9qissF6CDzXl/1P2k
   BZOXY734Ih8mREA7CypTLF8Z0l7L9AvLVqPYKj8oSyZ3HviZaqB0aX8sc
   UfiLLuhcYCjTlZ6GefoNWoT8YK7MVrhaJrM9NUX4e+cxQLi7Q+ctkYF9F
   EigmmVzEjhWXE/K38hXDSDeaOX7bmlDNtSQe7xXZBNoXYJZAYbvAhlbE1
   UgmtsNAE3MQ2oGsLrSB/bGwsRVcXTxZdzA8Qz9w66ODF2byJnB2u/Tzd7
   aSHv9QxfiYW0pGwnrWD8Jkqdxq1yOqbddAyU9Df0QktDCxq25IAuQMIT2
   w==;
X-CSE-ConnectionGUID: rMN1hQhIT7WRgLJc2mOQEQ==
X-CSE-MsgGUID: JxA21uTLQsi+jYgfRr1Yog==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33247068"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="33247068"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 07:20:06 -0800
X-CSE-ConnectionGUID: VSDa0e/OSDyK2rysoqU9ug==
X-CSE-MsgGUID: RWyecQ7ATlqpdL+54tqCtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="97905662"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 07:20:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 07:20:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 07:20:05 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 07:20:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qn+YEB6Dvq2GM59BfrexXDhAo2QvX2/RuLaVMJp71Cc2zwdGh4Uz1lP2dWC6tqrZrEDNJglG1DX9NJMmbBbbfnz55j7jrjXlyU/YartBcIqEnvkGqaQX+2i2tW9u27DHbIJCmbpsXRXFeANjak8Ptdtyqm3vclu6u1/t9VrtNOWiipYylZXJs5yz2D23qXY3Cl47ey+4GKeMLhGf7OvHqGDZc28T/S3K886wKnrIhgdrTmhq/ErVz2AKTMh6E48DeEuyMvVnXwubHBfJqfYVWyfbHHyh7YwVO0lo/SirklRy5ph60NVUZnyQllTEHQ7Mi88inXfBcNmn9zMRacMRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7UaAEin6ucpJF2eBC1SHe56nA2/KjBQcMHdeOM7dFI=;
 b=cHCo5SpofTyQ6GghtX+iPwOt3dpvkR+kSUZUDNLRwWKYxAErUvh8Q0uNWTn89LjZldiwka/LDelmIPSpPOpTiwHLL4/IiWCS6fGSoAUgQxB4QGOXxQhf1Oa2bhb2TRL/QNR219wWUpF4MQ5nj/0hmvOl2GarQDkrRKWU004uUNNzY8CEDMV/INwuQWaSr8klDLjhN8sZ6jJAIKYOfZAP4czsOlgqva0CEsgcHffG75Maa/9XPtGUVO7O2olef3HRDFq+smUeyVODriT3Sah0T+9cwt7y13FQK4Svf/SJF5Wh8hoozHV4ivRyY/iZtoFXhji/d1HHcQWREHry+5W48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by DS7PR11MB6063.namprd11.prod.outlook.com (2603:10b6:8:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 15:20:01 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%7]) with mapi id 15.20.8207.014; Mon, 2 Dec 2024
 15:20:01 +0000
Message-ID: <4139c530-d75c-4e39-974f-514b552a7082@intel.com>
Date: Mon, 2 Dec 2024 08:19:52 -0700
User-Agent: Mozilla Thunderbird
From: Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Re: [PATCH net-next 1/5] net: ethtool: only allow set_rxnfc with rss
 + ring_cookie if driver opts in
To: Edward Cree <ecree.xilinx@gmail.com>, Gal Pressman <gal@nvidia.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>
CC: <netdev@vger.kernel.org>, <habetsm.xilinx@gmail.com>,
	<linux-net-drivers@amd.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
 <cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com>
 <871a9ecf-1e14-40dd-bbd7-e90c92f89d47@nvidia.com>
 <b0f84914-c4bf-9071-b72d-cc2cc4a517f9@gmail.com>
 <d986d2ad-3ac6-4357-a8dc-e83e3622efb2@nvidia.com>
 <6ab56991-1415-4009-a630-14a0b709583d@intel.com>
 <1caf318c-db83-0335-4580-2ee21ff8940f@gmail.com>
 <44a203f1-1712-48f9-983a-dc49e40a3139@intel.com>
Content-Language: en-US
In-Reply-To: <44a203f1-1712-48f9-983a-dc49e40a3139@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:303:8f::12) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|DS7PR11MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7c8ef1-7060-4c21-8ae1-08dd12e4ca67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGUvQTZTWFFyK0NSQ0RDU285ZjRHVHBkcTJsTEVLMkVvQzI1V1ZJL2xuZytz?=
 =?utf-8?B?dlJabkxzSk8vRUpzaVN0REFRU0h5enZkUjZNeVpHUUtOQnNIcmQzY0NWdVR5?=
 =?utf-8?B?MkVlWlpwRUloMzdtQTIvdWp5TzRQS2M0RDRVSHRMcWpIZkJ1akpmOHVxTDJS?=
 =?utf-8?B?REZYZTJzWlB0c3JOZGZUWFZOSG00ejJEaGJSQU45ck5ib2xiUDVzWTR1emVy?=
 =?utf-8?B?aFNTam5MYTVEQXZRNUdnMHZxUGJTYVlOcGN3SU1rQVY1Y25reDBqUVkxN3lH?=
 =?utf-8?B?bWtJdGlFZHdMMDNUVGplNlJzT1lYR1dvR1pxZUVZVGhwaE5idlVKcjNybEdq?=
 =?utf-8?B?Z2NoMEtzY3hVTEZRU25DaGlRcEFZbWI4QW9odUNoSWxGdUFzNnRlazNHQldH?=
 =?utf-8?B?b21WeUZFMktQYlhEYjRtOFkxeHA1M0FZRzNOeHNhNDlkZ2E0aytEaUcxemh2?=
 =?utf-8?B?VGRTODhXd0xKQ0ExL1UxNHEzT0lSZk9TQzNZZEx4WnVoTVRHZ29NWUZGRDkx?=
 =?utf-8?B?NkpSYlE4SzZQZWFWaVI5MzVham8vR2JYOFY3OU02T0w2YWt0SHZpQ2N4KzRk?=
 =?utf-8?B?OUk5T3lCSDZ1d2NiRncxWnFFcVNSNW9sbXE4L0RTMWd6dFRkMlBUZzJUczg0?=
 =?utf-8?B?Y1F0MXQ1TndhVURkYVNDSWxLY0p5ZXltblhCQ1VOL241c2xHL3lVdkpXNFVB?=
 =?utf-8?B?amo0cEplSDk0bGcwcVkvK0NkQ3N6RWE3Wk1IZG8zWWZQc1dObmcvalUzQnVz?=
 =?utf-8?B?U2hsWmIxbW9QNE9mdHVpYi9CLzBwNzhETUlqdGdtNFJHYW9jMVJKQ2ltVTBh?=
 =?utf-8?B?UlNnOWszS0FwdzF4RTZFRDdjRkpJdnAwRG85S3F3Tk0zWHhlaTVuSEJqVTNH?=
 =?utf-8?B?Tk9uVFhjQXVrRndsT2xYZUFneTlxaFIveFZuYUdPWTB0VmcxbldrdER1WmFQ?=
 =?utf-8?B?MGxNdWRvS0h5VkpwcnRKVk40VDJ0QTdhZkQ5N29aa0pqKzJKWHcyYVYxZUc1?=
 =?utf-8?B?SC9rbkVFcGFOYjliQzhSQmVMWHd4REdRNGRLSUVVeFRhY3BFWXFtL0NCVTE1?=
 =?utf-8?B?YWdwM3diT0RLbHBVTTRwM3l1RmlUVGZvbGpmYkx3NkNpeEZ0RkU4SGxrYnlI?=
 =?utf-8?B?SENZa1k4SnpMWkRia0c0MmllVldieEZ4azZhb3BnRlhlM2tON25vSnFVYmtQ?=
 =?utf-8?B?ckpweS82V3RocnZtWXplbmpNdE1pRkw5OUlzMVM2djNFdjFMK0FCTVg5VkpP?=
 =?utf-8?B?UDNQZWdoVWZyWHd1MlVia1JXeG9Xb1lUVm9wUHBlazR4aUFQUm5tSmpqVUtj?=
 =?utf-8?B?VFU0OVBQbUpkNjRtc0JsaStOVUVVSnh2dmYrNUdHUCtWenFxdHVlNFdLMjBw?=
 =?utf-8?B?NVAxb3FoOEMzNjRlbzFoc3E4VzhFT2FLT2lCYUtiYWNHQWFnT0Q4VTNhcmt2?=
 =?utf-8?B?WVJvWFNWSFM3TXhaMnU5cHZaNU5Od0N5alpxZ0hESkkwTm5oR29WcGhWaTQv?=
 =?utf-8?B?Z05hODMyNE5YS2Yxb2hBc09qR3RLSS9xZ2E5V3lJQk5ScmczdzRNZHdFSWtq?=
 =?utf-8?B?d1lUQ1FqeXZqODZheGVXUFozcUpvenRjSzd0dEFLWjhLNS9pdVBSK3NDUXh1?=
 =?utf-8?B?bkRDTHUxekM2d1BLVXhKSlBaVHhlYnhFMStJMXdxOUl6U1U3MGxIbDZiNkNu?=
 =?utf-8?B?b2sxMDBEeUZjcDNHOUlMUSt4bUR6MXV3eWRkV0lRV0sxazVNaldzQmF1NnNR?=
 =?utf-8?B?TDl0Y1pWS0oydUVwS28wTit2TmZwb2FzbjVkSWhKbkQzZHZTSGlPRG8yUFEz?=
 =?utf-8?B?VGZiVFJvWDA0TWVlUW5JQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2VIUFVralBkVGFCNWJoZUJMUDBzNDYrS2Q0Y0lRNEpJMmhNM2I5Wkx5clZq?=
 =?utf-8?B?UThQZTJOV1lzS0VMQmV5c2NGSFg3bHFHczc5b3E5ZmRET0dia1lFQzNEWDY3?=
 =?utf-8?B?QmlqQ1B1Nzk1NGVFVUltQUhNV3JvbGJFUTlWSW5BSTZqV1pNZTVST1pPOVlM?=
 =?utf-8?B?a21mNjBpSjNpSHU3d3gyRUY5REdnUDVJakFJQmlqZ2o0NmdyMGdzd2VYTUtK?=
 =?utf-8?B?U1c2VzVKL2szc3M1SkphNkpIbTFLaUxRUE5LakVoSktpQVNpdGwrenRsVjVZ?=
 =?utf-8?B?OUxWdXdiWHlIa3dkbzhnUlpNSmQzRm53U2RPekNZamk0blVvWjJsZFVjdlkr?=
 =?utf-8?B?OTd3UkxqdWtvSVk0R3lJRTgza2NjTHJnTHVvazRxM21waHJzR3hxRHNVeWg4?=
 =?utf-8?B?MEJhMlhhditUbDRYanNwS0xKUzRnU1F2Unh2WDhPUWxnakdTS1Bhb0dnL2dM?=
 =?utf-8?B?YUo2ZzNwRDlnVnF4YzkyLzNzRDZhV2pQNktIeHpVSlhCUDlsRm5CUTR6SWVI?=
 =?utf-8?B?Qk5EamtrcFhaM1FIWXBaM2k5YXY3NzFMZ0Rodk5IZzNYSVNuTUJxMHhZQkJB?=
 =?utf-8?B?WDlkSWY5WElDVjEzVU4vK2ZQTVZjSnk3dmJwaWIyZ2ZNTkZDcVNvd2hxays0?=
 =?utf-8?B?R2pEYkJUVU9pSWFLOE43MFZvWFV1OGxhUmpIZnFhaFdmcFRCTFgzQWxWTnlT?=
 =?utf-8?B?dFlMOTJhSmVzMVFXZzNxQVZDaGhOL3N0Wkhma3kzMTZTSG5RaEU2QkEvblhL?=
 =?utf-8?B?UUUzTnhyY0JRZTY0dGxCbXVuRk9qUCtOSTlRN2JPbE41VlhRclpFM1BwWmhG?=
 =?utf-8?B?WDlzc2UvbkFIU3pzbGhkYTRVdUR6OWYzWlRXVEZXdVQwcjgxUUIvbCtMdHVr?=
 =?utf-8?B?YzlGaENzSGEySWJpWlpMK2Z4L2VkUitVekExOUVZWDB1d0FhR3NTYVBDaGdN?=
 =?utf-8?B?bHhpMlhZcmczUzRIbGtaT2NLQU9LdVIvajV3bGRkeWJPN2QwTUtEcGc1Vjky?=
 =?utf-8?B?Wi9YZWFISVJ6OUcrNEF3VStBYzFqVXc3NERpcGVYZVdiakxZRVQyd1JLT0Rn?=
 =?utf-8?B?ZWVVZS9VZHUzbGJlMFdUTklKVnppTDVGTElWRG5GcUVINUVZS1duUHRzNTNO?=
 =?utf-8?B?aWZPWi9uUlU2ZHJkRmpzbnB3ZVFlM3lOMzFUV1FiVXVVQllMVnk3WDhpVjdq?=
 =?utf-8?B?WklhOGFjT2pTQ09GK09rQXo5T1F2d21nd1JOUE9RMWorUkZvS3dvL282Z2gz?=
 =?utf-8?B?L3RZczJKS2dkdTFYbGRRNVhmV3dDcU1qcGF5RDFpYS9ZSU43TjBEeHJEaTNi?=
 =?utf-8?B?MGlLVndNVmtOWWx3Sk1BMHg2eG5idnMrbTVYQUl2RlBJck1MVlRnbSsxWHpU?=
 =?utf-8?B?L3ZsbmxiOWpVais4Q1RqWUJ5MTVRZEE4UjIyQVprdkVmQlJOYmtXS2g5Qjlu?=
 =?utf-8?B?KzZYdlJQTWtMTklyNlQwSWwxclZvdXlCc3NML09uZnlnaGs4ajVoQmlYOG5I?=
 =?utf-8?B?a2tvSytpL09tV3hnWEU3SjAwQUx0Qkh4bUR3dTNncnRwQXB6SklDbkx2di9J?=
 =?utf-8?B?Z0M3ZFdvSjh6dC9kYXVNVDYyN1VWNUVFR3lkakNxaW1uKzRZTEpwdFZwMnJX?=
 =?utf-8?B?VHBLZVpkR3dGWUZxL2J2MEZ5U0pqblNtZzFIL0Zoc0lvTnZJczJUY3F5NnhW?=
 =?utf-8?B?WXFzRzZIbk5rQ2lTeUZ4QnRpNjlOV3cxdXVBZ1hBMzRjaE45NnBpNnd5UFR4?=
 =?utf-8?B?Q2c4RXdhTGF0SC9XdUV0V1JXRUZsUGhtQldnSkRhMktvVldLWVpETjJuYjFZ?=
 =?utf-8?B?MDJMVEM4V2xuTVVyWjVrOFUxNDVCRElGMHB5UE5jZW16WXRiV210SkpERkJ2?=
 =?utf-8?B?MGkvWFFpd1NScnNPVjB2WUU1dTIzMVhXU1ZGNEJjSmZ2SVBNbUdxU0NBYUlt?=
 =?utf-8?B?R3NCMjhncTVUbTRqV0loOVhLSmhTb2xuSmlZY2ZvSTR1V2pnZ1FrUXEzQzd2?=
 =?utf-8?B?T2g0WlpLSndNekxwYWtCRjBHYisvUXpZMUp5SFZpOXZGbjZhbytpRkYrelg4?=
 =?utf-8?B?ckFKampHN1ZtYVdTMWdHaWlPQlNkanZXWDJYS2ZNUXJHNG5Bc0wza1psUi90?=
 =?utf-8?B?N25Ca0lTNm9ETm9YT1cyYVpDc3R4aVRPVWRSekp1SjNhOFYwcXVTN1JVbXZO?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7c8ef1-7060-4c21-8ae1-08dd12e4ca67
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 15:20:01.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fR9qk5TtBHfUmIflxwyFk2cRU3wsiYrVYzE1Q8FcHKg8m1vdHHcYa86aXSik9YcuxkPyzqvYs5jMJEEBVfDaqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6063
X-OriginatorOrg: intel.com



On 2024-11-25 12:01 p.m., Ahmed Zaki wrote:
> 
> 
> On 2024-11-25 7:42 a.m., Edward Cree wrote:
>> On 25/11/2024 14:20, Ahmed Zaki wrote:
>>> On 2024-11-25 7:10 a.m., Gal Pressman wrote:
>>>> On 25/11/2024 15:21, Edward Cree wrote:
>>>>> Also, the check below it, dealing with sym-xor, looks like it's only
>>>>>    relevant to ETHTOOL_SRXFH, since info.data is garbage for other 
>>>>> commands.
>>>>>    Ahmed, is my understanding correct there?
>>>>>
>>>>
>>>> Speaking of the below check, the sanity check depends on the order of
>>>> operations, for example:
>>>> 1. Enable symmetric xor
>>>> 2. Request hash on src only
>>>> = Error as expected, however:
>>>
>>> Correct. The check below is to make sure that no ntuple that does not 
>>> cover symmetric fields is added if symm-xor is enabled.
>> But symm-xor is about hashing, and is only relevant to traffic being
>>   directed by RSS.  The user should still be allowed to, and the NIC
>>   should be able to handle, setting an ntuple filter (SRXCLSRLINS)
>>   that is asymmetric, to override the symmetric hashing for selected
>>   traffic.
> 
> I agree, and in its first version, the sym-xor series was setting sym- 
> xor per ntuple, not per netdev. So the NIC can support different RSS 
> functions for different filters. Unfortunately, this was then changed to 
> be per-netdev during review. At that point, these checks were added in 
> nxfc path.
> 
>> symm-xor should only constrain RXFH settings.  And in fact even if
>>   you wanted to block asymm ntuple filters, the current code does not
>>   do that, since the info.data fields it looks at aren't populated for
>>   ntuple filters (whose filter fields are defined by info.fs).
>> So the xfrm check should be under `if (info.cmd == ETHTOOL_SRXFH)`.
> 
> If it is not, then it is a bug. I will try to test later this week and 
> send a fix if needed.
> 

Sorry, I misunderstood your original question. The check was actually 
intended for "rx-flow-hash":

# ethtool -X eth0 xfrm symmetric-xor
# ethtool -N eth0 rx-flow-hash udp4 sdf
Cannot change RX network flow hashing options: Invalid argument

and the NICs that support symm-xor do not use RSS on ntuple filters. So 
you are right, we should:


--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -997,7 +997,7 @@ static noinline_for_stack int 
ethtool_set_rxnfc(struct net_device *dev,
             ethtool_get_flow_spec_ring(info.fs.ring_cookie))
                 return -EINVAL;

-       if (ops->get_rxfh) {
+       if (info.cmd == ETHTOOL_SRXFH && ops->get_rxfh) {
                 struct ethtool_rxfh_param rxfh = {};

                 rc = ops->get_rxfh(dev, &rxfh);


Let me know if you want me to send this.

Thanks.






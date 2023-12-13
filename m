Return-Path: <linux-kselftest+bounces-1866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D3D8120FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D387E28270E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 21:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49997FBB4;
	Wed, 13 Dec 2023 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2YKE81F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF5410F;
	Wed, 13 Dec 2023 13:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504484; x=1734040484;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H7vtzWdXJsv6/2/0t854PBdt54eI5pPKwiKZxM1kRns=;
  b=D2YKE81F2yGjb9RgnSCGrNCTkc10eoq/4n6yXSs+nIU5i942EmuoMAnf
   /c1epoySshGwOvD6b4tYMM6O+qvASdPvKiTz1Wyd4qB4MbJb82qVoBS1n
   a/cASKHSyrhlEXIza5ez41zHU0XSMFC38wFuqQV+06g8doxDpo5TdEdCo
   VdJmJwu+l/kXyIczEFK8CQ7p8/TdK6Tywtns/p4UAeyoLPu5qEQYgXQJ/
   OiEgBs+LGQVwwa+KelT2ao6+7GaDE8le4A6odG8Cdqzy8FCIHpjPIm7S+
   1OFtBoX1+hq/ElM+QYmJJLSYv3961HkJUOvddjGQHAtS8AWhaQ7QxE6cR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1854633"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="1854633"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:54:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="767370772"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="767370772"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 13:54:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:54:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:54:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 13:54:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 13:54:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQ/cEhz/qr2njs83rd50LsavEMjv9ifHROPDZ5+smNLh0Uc4oQINc1fc3EpaxXg1W35jUgN1Bc4IJUtFCvNZ4Xs0AxolQOTto/MOCaPQEH6hwCNIxvG0AEjXqUmY1glUwyX4hVxMSsOyycmH9cGljwVLt2A3/rLgvCBOXp09hYZyGFTHyWbUnAjmVMo8fynsyODCoqaYsfCE7/XuCNjE9+wnkSKM9wtuZEsaxAawNGlss0NVRQulwybehvGBhPAZv31wShLTc0Rtq560rrkAsqXzrGm1mmd2TitU0LeQYKHEdlpEQaDtLX8O9599t+Hi4I0bxabs8fD5zNrKvxY4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHpR8rvGzkNPd/AL0wbn9xSe3dkIiXtyQrp0DTwTcLs=;
 b=bOh8NkdnEdY94bMl1FcjRhQWrHLM8KQUxjK74OOizxPmGtJTCDVkaFuVXk/UhTAy+fRACdT5z3nJfR+z29X7mDglYb+PGKbIScNi8koswX1cDM4SHx5HUbDyQ+e0hc6d0SxoEALbHdRBCRkXsVIXQDEB2jbDOK/42v6VPjUlB8aVmdQ65onQ/vtqo2hOugDjHuvW9sZgO4hILpY4nV5r/yFsPr+tyFVRNJ0bvB+o2hsGepq/bWMnNBRagLk3sP+sZ8iz0p3RsMnLb+6adpXAqBNQVINi59pXtEV9+vkKhZB/MAJPrP9GUui1zQrCHBjeJyRk5YylenlyND+0dtqh0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 21:54:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 21:54:37 +0000
Message-ID: <825e8dcd-b772-47a8-8222-e6245385c1d9@intel.com>
Date: Wed, 13 Dec 2023 13:54:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/29] selftests/resctrl: Change function comments to
 say < 0 on error
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-5-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:303:8d::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b1dcf0-9f3e-44b9-c0e3-08dbfc2619bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4ma+81PBJ1x+W3VCFCty2RyjcAtRL/k29p5Np9Y9FeB/xTAWqfTsM7spyVRdIr4u5IryDMLBr52RmqaEH1ILQgDtGn5tTBSHofKPCrQgbNaxUrzJId8YE2sdQ81vj8K8PbHarsWrjLxXCYG3XXWSTSyAr1JxwszkbmG7glJmMYUlgvwIknfbZMuYjRLYr0NByLY8PFSyASZkdRZM5h+LiHD4v+Mcwv9eDQUYGD3gVQve/g+2dCImOf3wWWmstT8P8vyKYsbkWriL5bXlZCrWDHZ6d1pWl1xQHRn9jCeBUXZCPsQIpBD+Vqp/S4cKsQXoIVzQkDKUMy0N52n5uLQ2zwJizId73SGOZUUPpd5FdeX7jIskvpu4+FDaNCa10Jza3gDlql4G8/2r6WcGNWyMpQbQpGtIhgXPwfRq9TxuqYKP3nI//cdE13II8OFvUziUdjVZvOaIb6M4LFKmnCOShUMk49zxIt381rSQQ13c6+7CwAAf6FEptGtDiHXtC7on0lsu0i+VNchEG8z8bl9W4+GAbs4OoVFyUe31qU5qVBeAHEUqoO+s9YWd3kU9T6wZ0dFM4hEX5CmuJkUc+3ky2xJEd6a8vfRVtIpUpxcQofZ7pY7tckdxBMZw1Ls2oIjxzG/o/hJqHBDQp3VbcjtAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(6506007)(53546011)(66556008)(4326008)(66574015)(8936002)(8676002)(316002)(86362001)(31696002)(5660300002)(6512007)(478600001)(6636002)(66946007)(66476007)(6486002)(110136005)(44832011)(38100700002)(83380400001)(31686004)(82960400001)(2906002)(4744005)(36756003)(41300700001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHVSOENzb1RCNFFHdkhEVGpqWGgrYUN5MEhlK1YrZkhGS2phbHl6NndicHFR?=
 =?utf-8?B?WUdQRWR6WFRCblM3Ym5QMTNjY0FzQmZhdFVWQytEYWlqOFNpbWJQL1VncmtZ?=
 =?utf-8?B?TnF2SnNtUHoyTy8yOE9XVWdoaTY3S0Q5amZ1UzVCUGJUalFhMlgzbmsvNmdx?=
 =?utf-8?B?TXBHazI1ZlhOWVJJVjczRXpESXltTEFrVW5jOUtYTXZWOTNFTlJZVE04dWp2?=
 =?utf-8?B?VTBOQVJOSjNIViticDNnbjlCWWh1VG1CWExIbk5vZFNqZ0ZxVll2b1hXdzdL?=
 =?utf-8?B?b0orbS9nSzM5ZnJ4RnRQWGVHVnJEUWd1WVZlcHBmK2c5a2NzU3EzZzc2b3oy?=
 =?utf-8?B?L2NCRGFFN3BraUNHRTdhMHBUYmd5MHR0S2RBOHIrY0Nhbm83NGlBWWdXV1hm?=
 =?utf-8?B?OVZKOFJMbzhUbGkzU2ZJd2xVM0xNNTdtQ3duc1ZURittYit5a0gwN0FJZHhs?=
 =?utf-8?B?V2JWRnlUOEFkOHNzaStSL0FuUk9SY1h0djdOZWtCcUhYa200NG91Y1lyejJk?=
 =?utf-8?B?RDdXMDZUQ1ZPQXZtT2h6bW9Cb0VBVnVabDFSdmVzVEhJNGUvQTF5Wm54QjVw?=
 =?utf-8?B?TnljdzZiRGFPZkdYQXFNTzB3eGZlTGpXRGtNT1NuZ3MxTkI0NFUrK1FkaEFJ?=
 =?utf-8?B?R0RMVkhrcEUweGR3eWlsQmpvYzc5QzZubUxJa09ZV2EvdkloZmZYdWZmRXly?=
 =?utf-8?B?UmJmKzNSMGl6bTNDMm9NbXhTY3IyMTRJMjlJUmpaZnFUVzBpalU1UjE2eUNI?=
 =?utf-8?B?Qk1OSlYycVo5OHBQRnJqd1ZTNjZRZXZ5VUFFZEVlQkZ6cWM3MTZmZVRyVmFo?=
 =?utf-8?B?N1UweGd4SVkybUY2R0Voa3MrbGVSVjVxajJPQ1k1cEdNUy9FeEZDUjJ5dnlz?=
 =?utf-8?B?U0V3YitFcUN2UE15M0ZCS0IxOFhOMWQvNm1MNlVPalFOT0c2L3hBYkxTQVJR?=
 =?utf-8?B?dGR2K0xHQ1pQS3ZsOURPbVFLR1VXU0dSQVlxNGFVVDczN1R3N3ltaDVSTUlk?=
 =?utf-8?B?UEJER3p6T3BiUWVMMmtZYXNIQklpUSt6Z3BHVU1UYVhxNXNCY3YyR1BJWkZ1?=
 =?utf-8?B?Z1doMU5BdjZvRTkyQk16SUFpb3VjWXJhSTQ3UVlrYWxhdldPLzRIUUF2VThI?=
 =?utf-8?B?TWUzdUo5bGtScm41SzRXWWk5NWFBUlI0a0xuemVyTUN5eWxOemIycFFGc3pS?=
 =?utf-8?B?M3ZQY1ZpUnJaeVJqcko2MlU1Q21CQ052ZWppSzB2b1dSSGoxUG54bDN6cEJH?=
 =?utf-8?B?bGZOa2tZL1Rod1ZkZDQzSXdINDdnT0tHU1lsbVU1Vk54R2UzMkFqRExLbHNX?=
 =?utf-8?B?Z3ByNjVjTUZvM3M1dTNYalFiUXF6VmM3TUxuVmV5VlFxMVIzUDE0Y2Y1SGtS?=
 =?utf-8?B?c254K3BqMFlxbjBESmFmcFRuSHhmSUowSjhYWEI3N09LRDY2dmk1STh3bjY1?=
 =?utf-8?B?akZXNXNpNkJkeUhLMnR6WUhabXhIRkFIcUp4MitoR0s2a2Q4T2ZydFZ3Q1Fy?=
 =?utf-8?B?Nzkrc2RHdUc0cVd6VUt1OFhsL0FNNnFBWlNHQzdWTHN2b09acnBpSnlFWW5i?=
 =?utf-8?B?b2piNURaMmZZRWk0TkZyeTNBdXpiYlVKOHo0MHZpWmVJZU1ua2NMZmpmZzRi?=
 =?utf-8?B?T1Y4b0E4bVFUMkJqcWF4RVFLRldRVlFrcXZEMFoxUEVGYkRkdWx6VkI2MWlO?=
 =?utf-8?B?dkdROHdBNHA3SjNqR0U5UWoyak1qaUlMN0gxejRieTVIWC9iSUNjUnBsMGMv?=
 =?utf-8?B?Nk93ZHN5V3VRMStUSFFGbmJBR0NmamxrcExHeW04TGM3em1CMnEybEZTTkRj?=
 =?utf-8?B?bWJZODZiVGFROGNRc2hwKy9uUjBTYzg3RjJSTWoyMkNZUHRPQ2FlcjREemhT?=
 =?utf-8?B?TS9kdmRMam5Ka1V3YUdjMFFKNlRsbWtzZXpCMEQ0aGhQRzE5aW5Vd04rT2hm?=
 =?utf-8?B?Yy9mVkdRRWhRL0dBWFc2cHZ6WW0ySk5ZVWVsQVpsUUpYNVVBQytRdytiVWxj?=
 =?utf-8?B?VWszemk5MkhhOGtRMFFFREVaVmZoUHNpams1YUhwczBwRVRRNUZZMXd3eWYy?=
 =?utf-8?B?UGpOVHFlNXNCYm1QSEx4OHhzVlo0aWxCYkhEV3RDTkhERWZURlBzbisycDZp?=
 =?utf-8?B?NkxtbmJVSmgxSHF5OTh1bnNKL2J2REFPQWJGTjcyN3FPVkpoYlhXYlNBTmor?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b1dcf0-9f3e-44b9-c0e3-08dbfc2619bf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:54:37.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nZrdDGhGhI2Egzg+eYTVJ3O7RTBQiVV5UO8SmV3LfOlkZwM/jSv8vpCrDgLiNfljAl30ASI7pkZM8Ug+rA6yU0w3Svor46U/ItIzzp+NPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> A number function comments state the function return non-zero on
> failure but in reality they can only return 0 on success and < 0 on
> error.
> 
> Update the comments to say < 0 on error to match the behavior.
> 
> While at it, improve cat_val() comment to state that 0 means the test
> was run (either pass or fail).
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


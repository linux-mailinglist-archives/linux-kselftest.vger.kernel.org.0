Return-Path: <linux-kselftest+bounces-775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00817FC953
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0ABA1C20E37
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B449F8B;
	Tue, 28 Nov 2023 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MERmNNw0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA2E1;
	Tue, 28 Nov 2023 14:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209901; x=1732745901;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ODJLY88equcc2FKR/p5mjOhtekKxZ4ge+9WE7ctsspc=;
  b=MERmNNw0gXSinFX5ikpU7ovbRF42X23jbomE5uog2a8JDco7NEE4w17G
   fjELKQ3I/Ftj99D7NJiIWFKaNF5QHI/41XyMISgus6KhcchzYFT1caRqs
   tU8seelh67/vuW9HKVM5wJE8hnTDfZy+TcQpWz5pcXZ1IHDPTEBlK0Fry
   dPfyic8nf2I9M9figSsq0H6h+NRIRESbOgM3B4t/Ar0CWkKZ2P8ccSpk3
   GsEmGePzvLyfLZeeim/tKAt7aa6ut9jApW3aZHE1RFTgm+pgNdNJ51GKg
   iIZt0/A3yWzII5k/eyett4b+70183AjQhQN0JnIq5s4WPpqHLIBCb7tZV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6249218"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6249218"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:17:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1016056615"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="1016056615"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:17:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:17:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:17:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:17:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:17:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PChfEtiwClAeG55BfOeOdGOfgugRPrQijj9GSMHUWZthNLsuB5qZYWENQLPfm8K8lrjqAGzIz4fDzAOh5H0pkGZ3kybhoNn96lxJs88zUgHaZ4mz24INP3cv2DytT8b/vJ6lRThksclNb/XAFC0pRvV0/ULSDOEE1s9h8bSIN+Z6eKr4MhVq3xf8C8/qNzRBifMWlDJDXsMl7kLY4gWx3LuWTv0mbvWk+9y4/LaMbo5H/wdZdgXVIsO51T/rakWgdKI3b8f7ot/rDdm4jeRjmUqANpVT7OzSmyS0dyi0F0jd+5lbHn6OVxU0fSnb45rYFF0hM0KcexGwBykU9+W47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCDtczEBLw8LXtRKmY/3loPScS5zCtG2vQO3fLXXplc=;
 b=jBhQaJ3Dg2IS5KoPrDkhlp2TvjvyP3Epqot+L3iBQty6WgIYcJJp+RCuPn9OeBDCmy0j3wPGJNzuWQMuAB13ZdBzdBU92tE9GeKZO38LM40HmVsvvPhCve5WOoC1SKktrXVJW4b6+NM0svD4OQLGGks4iJnSG+0PS8xw98E0Bd2/rj710Tk9kHN4cqh98puAjRwu3jmuSjTGEtNq+Ynez54GrM62PIuQZxI5+UUFXksvpscLfjrOCbV4i53kOOXszQjAxqeQ9sAjp5gny+rNv4NqzRAXvIz5/BNHUzscYdnYDn9ueBYuDO2l6LnDiKmg61yLXq4+9IRqmp+Sn3ENSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:17:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:17:55 +0000
Message-ID: <516f3152-0690-403e-a8eb-c142888a16d5@intel.com>
Date: Tue, 28 Nov 2023 14:17:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/26] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-20-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-20-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:303:86::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: db786357-72a0-4223-59b3-08dbf05fded4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGNWRnEgQsUHUy75hbukbTjqlYZlXC2Y6v5stHLTzAjkm/KLg1DMhlDCGMQ8PY5tphM7yYvoxONKkdu57qfzaLqwCvUIAPaGC5jJq7/Fi9kIa15LGk2iYaE1zUJolXMCVu/vMgvbVf2jco5qBJTlAZXYNW7IB5mXQXCOsXutr1VDY43GtsVOTb/0i+TI+Hy5qlFIEkT/vPFJbmlA3yd23VD2VPY59eqbc3WTrmxDSBy21N2s3zP0UXJ8iiz/kiik85RFqSQCJ2guzGqSJld4NkuAkTWfNO+lZnnHsJnPL0DH/MW9gIuT+ndhpi43KHICDdcuz8j0Ouf26QY8kMfgwbozkXLGts/Huq70VfyHroYhdShoUQSypR7lYaDAAMbL/LiN8JW6JVDleiRuzczvMAhOmBrjcAlqk5HBDceMhnyL7B5fyeZ5LZBM4WF9pE5zmbQJGu+zcchUqGhbMkPBReSJs4xFfQT5R0yxt/PJLOkR0fAGog7WEVlQ3OKuemTOBKonj9XyKzUQ+hXz1r9BgqcagGJSFL/1SCG3BXQW89D7ySbHrQIv6GuG5ivfDMLvyAoJ8K0Gh/TS3p9JTvcwrxJdznbYTrK2Hx929YPyS1iaBgKlaWU31dJ16Jimc4howZmSJG4/3BD5vr/NFJSSYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(2906002)(31696002)(86362001)(26005)(316002)(6636002)(66946007)(8936002)(66556008)(4326008)(8676002)(2616005)(6512007)(6486002)(66476007)(110136005)(478600001)(6506007)(66574015)(38100700002)(82960400001)(36756003)(83380400001)(53546011)(44832011)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWY4ZDR6T2dvaHlGQ1h1b3FJRnFPbHk2RmFPb3pzUWFmVk1pTHhwUzZCSDR5?=
 =?utf-8?B?Z1MxWWdYMTQ4aVlnc1VtTWtqMDZBQUxNczNYajdsbTlJQldoSWFrSlhoU0pl?=
 =?utf-8?B?UjFDMzJXMERRR1Jzemo4ZlQ2MnNlSHJBMVBNZ1hidTR0NGE1QmNwU3BhdVJv?=
 =?utf-8?B?QVNya0E3ZThrek84dSsySGF6U2FHU3dOWURnN29IMlNlWVdRZlBnYTVGZ25W?=
 =?utf-8?B?U1FXUEQ3clQ4VXV5dDNYa1BsNk0rZnE2Y2VBc3Zqb2U2S1l6VU41RWJtZmdF?=
 =?utf-8?B?SEZvNEs5SS9lbndvRnV3WDR3VVMzbEtQRENQdlhRNjZQdXVjZ1U2eldrRnh3?=
 =?utf-8?B?dkRhUnQ0MHY1Wlc0NWQvczlGaEhDVGNvdkRPdEQ4WFVXd2haQjJTeUllRXlM?=
 =?utf-8?B?MlFHaGw0a09JTUdDajh0aURBa0V0b1JhcnkvM0ZHTUhRVGV2WnU2cjV4ck9E?=
 =?utf-8?B?WmVTRFJtOUxyeUZTYm96czJ3R3BJdEs3Rm9pZDRXK3NycFU5VHFHQTJQYlFV?=
 =?utf-8?B?VUMxaFlnSERWb3ZYYW9pODdJWTJ6K1psUTh5N2w3YXJGdEJKUTRaL0dXcWYy?=
 =?utf-8?B?d05mRzJ2OFB1YWRhMmozYUFxZUczdmVlRnBGdDV5TnRyak9tUldMRDQ4ZTY4?=
 =?utf-8?B?YVQ5Z01jYjZKVC9rbmN3d3lrNkFvZUlnbmRNWEl1U0llTHVHZ3FSQnY4c0d4?=
 =?utf-8?B?MzZjeGlPUTZLWkNmOFZUN1pFelU5YUlWRjlWU1NXSlZzWGdzNmpHRjk2WVVa?=
 =?utf-8?B?MGhaQkYwczNHcjExUlZNYXFJV2EwRkFzVndMMW1acTlka3RyMmZvWTdnRlNV?=
 =?utf-8?B?WDArbEtudFVOdHpvQW1MeWF0bTJDYzQvQng5TkxQRU8wMWIvYmNEbTFCUDFF?=
 =?utf-8?B?MmJrdFo2Z2NZWGhsRzU2SVM5Z29yUElWMTVydDJGbEVzUnBVeDgxOGhtMW9I?=
 =?utf-8?B?SE9SaGR2ZThRVGF6ZWc4aHoyYUNlVGg2TklBdWlDQ3ZMQTAreVp1MFRsOVU3?=
 =?utf-8?B?Y0M3YVd0cVJ5M2hHbEszeFpucWdpNDQ4M3FtSk4zQ1BtT1hhdE0xRnMxVmxz?=
 =?utf-8?B?WjlsT2VrQWdwWGQ1YkNRU1dhZmVtQnFzU3lUc1ZoWjJSVExSaEdvcWEzRFlZ?=
 =?utf-8?B?YmltK3FJcW5mZTJPYUE3S2ZQWmFIZFcxWlVSSDV5YzVjNDkzdTUxUEZraHM0?=
 =?utf-8?B?QmZyYzh1YWo5cC9GRHhPQVR3NG1HOTVWWGg5bEVNaC9kZzR2alpQUVFHZlBN?=
 =?utf-8?B?UEJES0cxeUJVNkRjdFYxSVlQUE05ZXFEZnVNUVVOTFo1ditPZHRzVmFiUnU0?=
 =?utf-8?B?dGQybnRPZHVScERBbmdGVzVkNVN3VHI0b1RqL2VSdHVVcU9TMkVKNEhmRVJS?=
 =?utf-8?B?aDJ4QS9DRlhaS2xhTnF3WUs0YThnSXNHamdjYTRvcmY4d3I2ZXZZVlhWSE9P?=
 =?utf-8?B?ckRabTVMR05CL1FESmJuMzI5dFRldHNoSlgwaVp5bzZnbi9obzNkNEJpeVR3?=
 =?utf-8?B?V2pmcW9RSWs5Zng5WkNoaGxBWlhUYWkrWmc0ZXFLdjcxYzFmV3h2VGZha3V3?=
 =?utf-8?B?bk92bXZyYytyL0Jnd0thN0JCY1pUZjFsemM4USt5aU1rdC9qWFYwaWFXbWVH?=
 =?utf-8?B?UVhPdWIyODlaV08zL1JKY29LS0R6NEFOeVNPNGJkeWZZbzlrbzBLbUF4OUpU?=
 =?utf-8?B?cFM3MTlHczdtNzU4NXNDczZTaURjTStOYW95bzdvL2RNL0JRYjIyeXRONXhu?=
 =?utf-8?B?QllUTXJOcm5KR2IwYldBU1EraUc4WGFIUUVmcUx5NmlrRGYwcGErcmMxVlIx?=
 =?utf-8?B?OWpKT0RzOXFBVjVDZXUxRk83NGEwUDRONW92YktTKzJaZW9SZG1IVUcxb01F?=
 =?utf-8?B?SHhpQ3Z6TUhiRlAwUjcxY0ZyY0NrT2U2a2szdlFBU3RhV0FRdEl6QWowV0h2?=
 =?utf-8?B?RW45cmhxRHFRRjJ1OG9zT2FzRVh5T2N4NzYwbEdCRlZXcjRLZURUQWhQZHZ1?=
 =?utf-8?B?cVJBb2RUNUxEUzVJaG1YOW84U05BTjFzc255alp0VHlUNmJGaWJkenNzZjlY?=
 =?utf-8?B?UWdwWUx4QkcvZXMzMUtsVkZKeUtnN093ZXRiVm9KTzY1YTU0UUdpUzJCWG1B?=
 =?utf-8?B?aE9DRlJDdDEvR2J4U3hhNVdXRFhtSUFhc05aMXhBNXRUbWV6akdVMEg5eGdO?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db786357-72a0-4223-59b3-08dbf05fded4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:17:55.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poomZ1NjAPFYU5irBFqQB7W3ho89ky/GoBzBEkVKtYr2Za3PgFxnmGzyPgLaVrXCcQ8zzCNpmshTGcE0663QKgI+AMCIl5pnyT0N9b62LlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> CAT test spawns two processes into two different control groups with
> exclusive schemata. Both the processes alloc a buffer from memory
> matching their allocated LLC block size and flush the entire buffer out
> of caches. Since the processes are reading through the buffer only once
> during the measurement and initially all the buffer was flushed, the
> test isn't testing CAT.
> 
> Rewrite the CAT test to allocate a buffer sized to half of LLC. Then
> perform a sequence of tests with different LLC alloc sizes starting
> from half of the CBM bits down to 1-bit CBM. Flush the buffer before
> each test and read the buffer twice. Observe the LLC misses on the
> second read through the buffer. As the allocated LLC block gets smaller
> and smaller, the LLC misses will become larger and larger giving a
> strong signal on CAT working properly.
> 
> The new CAT test is using only a single process because it relies on
> measured effect against another run of itself rather than another
> process adding noise. The rest of the system is set to use the CBM bits
> not used by the CAT test to keep the test isolated.
> 
> Replace count_bits() with count_contiguous_bits() to get the first bit
> position in order to be able to calculate masks based on it.
> 
> This change has been tested with a number of systems from different
> generations.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c  | 282 +++++++++-----------
>  tools/testing/selftests/resctrl/fill_buf.c  |   6 +-
>  tools/testing/selftests/resctrl/resctrl.h   |   5 +-
>  tools/testing/selftests/resctrl/resctrlfs.c |  44 +--
>  4 files changed, 138 insertions(+), 199 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index cfda87667b46..4169b17b8f91 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -11,65 +11,69 @@
>  #include "resctrl.h"
>  #include <unistd.h>
>  
> -#define RESULT_FILE_NAME1	"result_cat1"
> -#define RESULT_FILE_NAME2	"result_cat2"
> +#define RESULT_FILE_NAME	"result_cat"
>  #define NUM_OF_RUNS		5
> -#define MAX_DIFF_PERCENT	4
> -#define MAX_DIFF		1000000
>  
>  /*
> - * Change schemata. Write schemata to specified
> - * con_mon grp, mon_grp in resctrl FS.
> - * Run 5 times in order to get average values.
> + * Minimum difference in LLC misses between a test with n+1 bits CBM to the
> + * test with n bits is MIN_DIFF_PERCENT_PER_BIT * (n - 1). With e.g. 5 vs 4
> + * bits in the CBM mask, the minimum difference must be at least
> + * MIN_DIFF_PERCENT_PER_BIT * (4 - 1) = 3 percent.
> + *
> + * The relationship between number of used CBM bits and difference in LLC
> + * misses is not expected to be linear. With a small number of bits, the
> + * margin is smaller than with larger number of bits. For selftest purposes,
> + * however, linear approach is enough because ultimately only pass/fail
> + * decision has to be made and distinction between strong and stronger
> + * signal is irrelevant.
>   */
> -static int cat_setup(struct resctrl_val_param *p)
> -{
> -	char schemata[64];
> -	int ret = 0;
> -
> -	/* Run NUM_OF_RUNS times */
> -	if (p->num_of_runs >= NUM_OF_RUNS)
> -		return END_OF_TESTS;
> -
> -	if (p->num_of_runs == 0) {
> -		sprintf(schemata, "%lx", p->mask);
> -		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no,
> -				     p->resctrl_val);
> -	}
> -	p->num_of_runs++;
> -
> -	return ret;
> -}
> +#define MIN_DIFF_PERCENT_PER_BIT	1
>  
>  static int show_results_info(__u64 sum_llc_val, int no_of_bits,
> -			     unsigned long cache_span, unsigned long max_diff,
> -			     unsigned long max_diff_percent, unsigned long num_of_runs,
> -			     bool platform)
> +			     unsigned long cache_span, long min_diff_percent,

With all care taken in unsigned use I wonder why min_diff_percent is just long?

> +			     unsigned long num_of_runs, bool platform,
> +			     __s64 *prev_avg_llc_val)
>  {
>  	__u64 avg_llc_val = 0;
> -	float diff_percent;
> -	int ret;
> +	float avg_diff;
> +	int ret = 0;
>  
>  	avg_llc_val = sum_llc_val / num_of_runs;
> -	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
> +	if (*prev_avg_llc_val) {
> +		float delta = (__s64)(avg_llc_val - *prev_avg_llc_val);
>  
> -	ret = platform && abs((int)diff_percent) > max_diff_percent;
> +		avg_diff = delta / *prev_avg_llc_val;
> +		ret = platform && (avg_diff * 100) < (float)min_diff_percent;
>  
> -	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
> -		       ret ? "Fail:" : "Pass:", max_diff_percent);
> +		ksft_print_msg("%s Check cache miss rate changed more than %.1f%%\n",
> +			       ret ? "Fail:" : "Pass:", (float)min_diff_percent);
>  
> -	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
> +		ksft_print_msg("Percent diff=%.1f\n", avg_diff * 100);
> +	}
> +	*prev_avg_llc_val = avg_llc_val;
>  
>  	show_cache_info(no_of_bits, avg_llc_val, cache_span, true);
>  
>  	return ret;
>  }
>  
> -static int check_results(struct resctrl_val_param *param, size_t span)
> +/* Remove one bit from the consecutive cbm mask */

The use of "consecutive" is not clear. In this usage it removes one
bit from the previous mask in order to create the consecutive mask, no?

> +static unsigned long next_mask(unsigned long current_mask)
> +{
> +	return current_mask & (current_mask >> 1);
> +}
> +

The new test looks very good to me. Thank you very much for creating it.

It looks to me as though this test impacts the affinity of main program
since it is only one process, changes its affinity, but never change it back.

Reinette



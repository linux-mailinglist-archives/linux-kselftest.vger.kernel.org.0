Return-Path: <linux-kselftest+bounces-1865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B369E8120F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60406B21175
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 21:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DCA7FBB2;
	Wed, 13 Dec 2023 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSX0iomf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C09D4A;
	Wed, 13 Dec 2023 13:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504468; x=1734040468;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s1LD6NU1JXGOT4IzUkSGUCNOyXo7oeRaG1qHMiaSqos=;
  b=nSX0iomfr+9AuZoHWp/xX6l5S9eE/OGDaMEoQ8rP0CqQXYziLRMHPe1Y
   zqVhfn3+sH/zh7scPVCeMAjkaW7vrDd4L+fD9VLhQCA/bu4M6pewBZVXK
   ZGhLAwlbuMLbaX7cD1Yid2NXVcx2+k3RkMu9qwa1bqCFYPxsaD+13C6cM
   ldTw07U5Ev/WG916O1VkAcoCuhpqEEKdS+2Uezm8wGTVGiqy/H+gH05NW
   jFGPoZMSQ8ZvnRqLJ0IabK2CjBSliSiQ1IDkAeArB4UFtTkHUTrFjyXor
   HVFLt1nj8jcw203zPSLGgPlR2IPg27tHsQ5uxFYSphum/VW34a7R9aiEY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="16582564"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="16582564"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:54:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774095613"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="774095613"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 13:54:26 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:54:26 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:54:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 13:54:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 13:54:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OssZxBFe/UDwYWO5Lox9dv9xe7tl68Nu1k5dgxIIgRJnauO/uJF8+rP8NetHR3MbmHaP13HGJ+Vi1dj5cYuxagAymw/7t9jfA2pw3pEwN/ytjc6VoogELlR5VWgLQ4p9MAHRJ/fV/cZMV406u2peqPAMXY9Jm0E5xSjTYh370mGmdxReyId3HpEkos5B54yynAfc1BritTnZ6OEjR1/Jzgb0FAxIYH2wI7Qk8/mYFCpkau7kOMXfcwl6JmQrpvqYnlDSHmUiStH3nAJF9oS4ROSGagBH+ZRdtJRVV4vA98/e4QLL6QxB9zY7UexHY454VDPUwwJRo+EaWdN5mR0J2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGKzeX3k3GcBhVoHVwIfS0Srzi3qkMQgkaaCDnSaIsY=;
 b=L+TCrB3BmJ6oMLmI7MfZqFfgbONsv6pJulaTC03gAUL2Esz2wah0HmFOjQv6s6SGdvjbyDIObvAI664WFc+MMUp4hyO5pVlSACh0Qy+O7voDw5MmSqaDHifIRIui/f+1qDBewNQofjT8xTggasS/u+khvQLUgdQDgPmOU4EznVQwvts69YTZVJKsXAJAm8De51a8+DYY1uTrpymj8TjA3BrfO/ReXiTOQ7SvfLbp8QBTjLzasCU40H6H5ayuL0w3Sybi6D0rqEYRE0wpVVlN3xZwoR67Ognoopv5b1hXV8MNTMrEzzxoaZZARjcYxj1PD6+bv//xTNeNKaQkmLUbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 21:54:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 21:54:22 +0000
Message-ID: <ab694710-ab50-46a7-bc48-1e329b165ae0@intel.com>
Date: Wed, 13 Dec 2023 13:54:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/29] selftests/resctrl: Return -1 instead of errno on
 error
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-3-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-3-ilpo.jarvinen@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 403f8c66-5e69-4268-1588-08dbfc261079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYZH1qIiAdf4VJyPtDQkFeAoBPD2VU3P+b7ddLloSIrugLlIEzmOZ0lcpp1SQtd5vg6f8VMOHfjI3Lb+Tky2yGP2WWO2KJ+uBnDz0/om6zSOwZPeYUiVVOErgnHOwXMBtymSYAvE3Lz6wfABLr5PzA6xUl6B8w8wTgjpl9EW5k7n7lIMwcM7M1yqz4A7NCeD80JH+ITAkQSrchmzTaRGP2xNqWajlHDRLE/+41tywiZHYbEG2UsoV1WA0DVtAZ2CrlK7SMCfH/oIUS0PXrKLZHR+yuYOHj94GNSzFnQx+ns2XkUWF33iIB7hyMsz6lbKeUdOII/g0F5hXZYL4p36wGdzSw03dHnNcKCUmE7D7kMk+MtZSXlo87pjGhPYaggwDJeDXVwHpBtEEQ+NtgCFXjcBRxcGMdxY1iEWLrI7HH2gXw9+bltklC7oNsuvGf4zETrEcuLHV52jzJFFt+H8gtBCOvsewHSNyTyeUY39RDVYlOvpiUM0Yny3Mkq+oGdtkJHAQfCgpJ7mg3JBKB0bUue71LnQuJl2Ii/sfUusyFlbpOo0TJvZ23662y7nygwMQLk7Te6n8s01xXw1XFwF61+oAriUHMS9eJE9OwVs3FniOxtIfUM+5oRGhmGzVZlYkebKY4Ibk0vF3RYjvHBjPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(6506007)(53546011)(66556008)(4326008)(8936002)(8676002)(316002)(86362001)(31696002)(5660300002)(6512007)(478600001)(6636002)(66946007)(66476007)(6486002)(110136005)(44832011)(38100700002)(83380400001)(31686004)(82960400001)(2906002)(4744005)(36756003)(41300700001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REVHT1dkUkxJYVVmWXJjNy80cUUxeDZPQjl5N2M3eGQ2Q21wUzZ1c1k2UFZX?=
 =?utf-8?B?SWFET0tBQlhaNlFRWnIyMlBwWU1WOXBUd0txY24zakdjQzhoN0JvM3JpTEZL?=
 =?utf-8?B?RGdWMUw5enpYZFMxamUvL0dtYnBRWml2WHhxRXl2RTdySUJBL2Jlb2wzWkY3?=
 =?utf-8?B?UmNFZFdPcGN4emd2TkljYUliaW9Wak5vTXp5YWJjOWpNVXF4cFp0SlN0Q2R0?=
 =?utf-8?B?MXpnQ20rYjg2SW93QzZVTlZmS2hrNXlaaUNMUVJiOEtvYnR1OGpiQzI5L1lo?=
 =?utf-8?B?Wi9IU2ZiZmxHU05oemhPS1N2UFV3VHZhQkppdVFBVjdiaUZjQWx1aFhrR0lL?=
 =?utf-8?B?bWs4WjlXSVFLQ09QbUtURUJTQkpqdUFka3QxWk40RDVlUU10bmx4bkkyanVx?=
 =?utf-8?B?UFIvOGxvTnkzMXZ3RmR2Sk1NTlNMa2FxV1ZlZ0M2T3FVRVQzK25sSWFuN1Js?=
 =?utf-8?B?VnUycUMvOE5RdGtoQ0pPTFlsYXl3OTE4ZnRBL0pKS0hKWkthb2ptTXY4YkxO?=
 =?utf-8?B?bys0L1BtdXdRRmxwQ3p1dVl2YUIzbUhlenRVNWljRUcrY1JEYjFYYVI0TlFB?=
 =?utf-8?B?VytaL1B5VEdvTXRFR2NBa3luRGM0ZTNDOXhPaWl1MHZDYnlQbVZubkIrY05m?=
 =?utf-8?B?Z2RsdlJxb2w4a2dybU5FcThqcXl4QitqUk16ejI3YlRvOHNaS2NCeTlZTmJF?=
 =?utf-8?B?ZmdFMEFCTDdTOXhVOU1pU2RUWmpxanRaL0Q1cFpzS281SnpGRmlacUg2ZHg3?=
 =?utf-8?B?UWI4QWI5YlRKN2JtaXBIbzJnY0RKTnFkNUY2Wlk3emttT05OZ2dyT3Y1cHFB?=
 =?utf-8?B?UnBBQzRETlVES2hKM2IwS1R6OG1nbG5nWHVtdjJ6Tk9RelV3NzZMZjU4VU5Q?=
 =?utf-8?B?WXlQbEJJRi8zVHI4UmZ0ODZ0bDNFSmlOelluNlBlVmN3VG9EdVE3ckFoaGxi?=
 =?utf-8?B?VjVmVmkyVU9raTZJMkR4N0xWUnlNR1haVWQ0Uy9nL3BaYzhSOEhzbnE3VDlJ?=
 =?utf-8?B?Yk05Mm5JZmF2MW9JN2xUVkVMVzA2MHFtMTZTNlNrY1IrL0F5WWd1Mkg3YWJV?=
 =?utf-8?B?UTZQVTJqYUxlYm5leFE1RUxrL3VJL0VlS0VycHN3WmVXMkR4NU9uNUlWeFpK?=
 =?utf-8?B?bU9OU2ZtQkFNNmpQcnE0V2ozMW9adTA2MkIxWkUzVDJuUTIxcHpiYWxXYzBS?=
 =?utf-8?B?S29FK0RFSFd3OUtUUDJBRUcvTGFQVFFxL1hBTE1nY25GbU9nUENWRm5lRExz?=
 =?utf-8?B?cHpNNlAxZVhyd3pKcitESFhXMWRXaVZvR242a1JxMHQ1MUxCeVhZanVCQlha?=
 =?utf-8?B?Z3hySmtaeEhmZmhBYlIrU1d2bmtrbncrMWRYeUpDeWFlTHJaT3VDdnVSbW5j?=
 =?utf-8?B?b3BqUTZTb3ppYXJLeTlrdHpHU3U2aTV5MGhvSXl4cXNQMGhLSjVWQmJXdU9E?=
 =?utf-8?B?d2ZlUWp2bHh2YkZHeXQ0aFRDakhmOStLWWdtSmZIL1UvM0poaFg0Q2RlNm9Y?=
 =?utf-8?B?UGczd210ZmtBTXN2SHUrck1sUXBzVzRwUCtGRSt2VjFydDhEMXF5bXNNdWJs?=
 =?utf-8?B?STVxVUJ6RFVOYm0xRDJLc1h1d2E2a3pUK3JvVGVvSEhGQ3Nqc3BUVUpMODgx?=
 =?utf-8?B?TWMxbnZIN2JkU2ZMY2NkR2dONmFHVkwyRWpoTnFoQkZwajlTSmYvQzdMeFB5?=
 =?utf-8?B?OU1ZbXArYVJPYlB3bytDUk1vOEVXOG9oOHo1ZmV5c2twNmZKWUNaTmZDRHBq?=
 =?utf-8?B?NWxIU0dOQ0ZlTTZNYjdHL1VrQUFZdUpCQkkwbDA3a3VWZFRvTHdjY2hIQ0hO?=
 =?utf-8?B?b2x0blFoMm5vMWtmMXBaNTR6bkpqSVVHSmwxN240Uy9jMTJRREY1RjRkeEpE?=
 =?utf-8?B?QWxmNjJhNEJRajJScG5hWVFvcmgwZ0E1NEJ5NGlEL2RCbThRcjQwYSsvT2ZH?=
 =?utf-8?B?NVNZUnB4czJnZVJvYWtyQjZaUFFCVU1YM3RVemNxMGF3RkQ2M1FsZjhvdS9P?=
 =?utf-8?B?SW9BcEVtY00yV0NDbksvdlNSNzR3SFhRUG5hWDNwN0ptak1xUHNZTDNMd3Vv?=
 =?utf-8?B?dnRqdmRpdDl3U1lFTmsrVHBWekw0dEpQcTQ0UXplOGNkVXIvTmE1UzhKQkFR?=
 =?utf-8?B?MmFFSUVRTzJScWRXRTc5bU13WUREbHI1ZnlBa2ErQjU3ZmNmZ292K3I4MjZa?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 403f8c66-5e69-4268-1588-08dbfc261079
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:54:21.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HO9Wr/VTBkx7HI8yeUoLCwVI1Uga7J+75Q4UUvdCZADhZljwFiH0inA5sSTsXLXn2bZgIKV8fgVzd7svorOK5JFNLpaOyDm7FWsXiHL2KIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:17 AM, Ilpo Järvinen wrote:
> A number of functions in the resctrl selftests return errno. It is
> problematic because errno is positive which is often counterintuitive.
> Also, every sites returning errno prints the error message already with

every sites -> every site

> ksft_perror() so there is not much added value in returning the precise
> error code.
> 
> Simply convert all places returning errno to return -1 that is typical
> userspace error code in case of failures.
> 
> While at it, improve resctrl_val() comment to state that 0 means the
> test was run (either pass or fail).
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


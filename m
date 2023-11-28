Return-Path: <linux-kselftest+bounces-769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA647FC942
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4FC282E72
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D34481CA;
	Tue, 28 Nov 2023 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1BHH7I6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC051BE;
	Tue, 28 Nov 2023 14:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209737; x=1732745737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/6o84Xe32PZvsbJlB8SdOApdQtORuUwq8NwqCGIMTRs=;
  b=n1BHH7I6phSyIWWIY9tvEP/YYKvMVq6x0Ww4S8SAaZOI5vqd8BuWgazs
   ZgP9wHnbY6dinNYQMogSbSnzbrN8EL7bse3mzNzpIfUHvq1GouGEf/NpI
   drrMQmG8JiKnKC1jgB6KnyDvlEPremgxfdWS6yThdeSVwYT//WtO7X5kW
   L85ykGwDUJniMvFF5ThFoFduiALNCUtLb6D4AFKnfUbCIDSrVzEjSkz2b
   D66MgQgHpjcKA8jHIY4hDygCv6nxLxtSzOvYKtz0vxBsxHi/11QrOkBtD
   eizwLD999twQTpu2939d86893sD1HzOta64DoUlKKK8nVeDm5IouewRJk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="396942061"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="396942061"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:15:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="10141445"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:15:36 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:15:35 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:15:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:15:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:15:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQg1gGa9NQYywwJ5QymXCs4V8fqpD333tYkSrUk3p7OWBeESknfaIH6q1T9lScR57zMZIv0DcDOvSdHCXfmrTYPftLaOlcWPBGnjNlfYvw/LXugGfDhMbazdqiLs+90rCP7Vh7/CiP13JNK/G6TqFFGCxHeIKnCfdtBrZfHPWNt1MV+217FKmFWJazcW3+YZLLUAB57jAUV5YRxuh+lz9jVFR7XWELK8wxFs9yIWT9Pn50APuByPs2ljRmINi6EWaTDTINgHfcDRrYFfc+rLifj7igoxyAhoXJ8LgOEafWS+woJ2GPmCCuQ3gduTJ3EWcr9/dPkydFqipUuW7V9L2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NMHJnqK2ZG0xd/sBCCdpZK6yTJH5sRnuQkzZOiS/XA=;
 b=dkiTR1QjLidNCsseejABqwEB3dso/JdtUw8xos16JSJ6a/cWWOXkWM+7OUjigdnUKzDJAsnR2bVyAA0KK1us5lyrGMLmp7zNgq0MuqcW9bqWb1lUPVj4hOKRlnsJjXN7ZZELxX+7/KXOWZjUeHjdcgfBIfjVNnk1QXBnbOaOGsbTAqbXiPFA1vYvpfpsqEMZHcfajna/dmj73yub1KRu1BYXOhKQLjwiAsS5HHEU6MeYM31B1+iGpO84mXGVc3krGvAaL10WRZsnbrZTeyAiXlBH3w3XQ31k34lQ/+IymKeKzkU0EmuvJNgLdkeXsN4k1iVJ41pn0dlqhXsJZG8OAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:15:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:15:33 +0000
Message-ID: <1990a455-9698-4d9c-bbe1-c47fa83cb71b@intel.com>
Date: Tue, 28 Nov 2023 14:15:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/26] selftests/resctrl: Improve perf init
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-14-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-14-ilpo.jarvinen@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 894c1b3e-757d-4987-386a-08dbf05f8a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCODloMNaJ+CH4MHaxHi6P+cT1CYU/XISXm7wpEH1qiaXb+u25EzF17sqGWB1yxbdzzLCT2LP9voQ7iPx8+vWycdfQyj+8VOfWRE8jFgRbO9u/8L83Ic+9cYUY0oPhrbbGxNQhMo4dFd3fzfOpQ77v26DmP3aOJHwiGWuVwXOwYOWwMxIVg4Fls7QY/5DyonN+0F1AplLpjSgBIYvww6qIi8Z57sYu6Uoeu+2QDSBlHAKbz3PW37toQ4Fudj1jZGJ3czm4IlN9mjjk+CP5UtPqugJrACsV0mm7OHDtD95wl8Naq5+B9TQG4viduT9ARAofXfbS8FF5f+Aynhk28SESIjakW2Wnsz1SIc7Fw+lD7ON3OhAGRah3Mq8Lq8StIbxiScCzqUtdRxTySOSDOO88Nz65m71C7uzQjI+dGEo/rq6JrqCqvyQiqtFKkV0AKzE/6WS+pfTNQ3rUqYjtrudWwJDfHhSmPLnPtOa7hJR1MWF9n1G9kTefJn22DoKkMyYmErLiHddGCOy9yPk8HYpr+eAoWyolM2Wql96U/FgWrHqSvPe8G0w8wHNKwA2Wkf5HbGOavfGXJX2WF8AgTxpSa77x1h4n5NYCls59xuDA+tHvmomC7O3Surl/sSKwggG4J8M5t98FAKCuGcd/0XxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(2906002)(31696002)(86362001)(4744005)(26005)(316002)(6636002)(66946007)(8936002)(66556008)(4326008)(8676002)(2616005)(6512007)(6486002)(66476007)(110136005)(478600001)(6506007)(38100700002)(82960400001)(36756003)(53546011)(44832011)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlR5NmlIa1hWNXM4SnQzbWtzbzhxT1F5dXlFV0w1cEQ4QmpjYWpNeXRaZlVQ?=
 =?utf-8?B?TUYzb0xRVy9hQTZ5MlN4cThvR1IzU2dNTVlIaFlYc1NJRmFoZGpNVmVFTG9w?=
 =?utf-8?B?V2JKN21XejhnSFhtOFl0dEdXZzRaVE5RUkFXbGJVS3RyTkZuOWR0OEpTcGNR?=
 =?utf-8?B?RVcrQTFhNlRSRVFpUWhKWjliT0JsZGhndjVnUTVxbGVKOW90RlpaTnVPMjJR?=
 =?utf-8?B?WkRsOTJJdi9PUHhpRzZ3bXJqK3ZCL3M0NXVlem9heEpVUUxtTFpzcVROVlRR?=
 =?utf-8?B?dWVBK25LV0NIQW5qSHBSZTJ6OUtBTlVPSjY4dnFHRnNSbVJrVkU0U3Nnelh6?=
 =?utf-8?B?ZzdRQ2hKM3JyNHVZdGMzdksveDBEekc1d1JoN0c5NlNHU3ZUeWNrZjdPbklQ?=
 =?utf-8?B?aFduclpZZFlFU0dKclhLOHhOTWovdDB0Y3pUR3RiKy92elptQVJ3ZUtnR2JF?=
 =?utf-8?B?Ym53WlhXcUJGRTZ1T09jaXl2OXIveHU2MjJ0dXhteWQwQ0VTbEk3ZHV1L09W?=
 =?utf-8?B?RFo5TS9xY1ZIaDB5RWxHQnJid25YWGoxaDRRT29IWnpvenVkTXorVUU2TTBn?=
 =?utf-8?B?Wmp1dU1xajV1Q2JUSGlVMzBhNVJZbWNMcS9VcjRXZG5hUWxaRkdFUnpLTXhE?=
 =?utf-8?B?ZC9sVm1ibXZqQTVNc3IrdUtMNHQrTHRxWG44T1VTaWNSeWNmamFtMitBaHZZ?=
 =?utf-8?B?SWVhcWU1MER5K1ZJZWgrcUtXMERIT3IrMEZLVU1xS1czRXhXSEtPUUFyRFov?=
 =?utf-8?B?Y05CYmtLSisvZUZrNnkvWkg1TTI2bE9SN3FkcklDZmFOQTNybTl6K2Y3ajNW?=
 =?utf-8?B?YmcvMzZyRGdqeEk1a1hzUnZNZU1NTkpPSjUxcTRaZVh5TGp0dE5QTDQweE9R?=
 =?utf-8?B?QW4wblhxQ1U3RmVISFo0Y3BYTHV3ZkdBaVdhYklCbVlQS0RoUStMVkdKNUdL?=
 =?utf-8?B?MVRiSElKR3czem43WlFjS0U2eUc5azdCY2Q2eFFMa0Y5b2JhUzQvWUovVlR0?=
 =?utf-8?B?bGZHSW44c2hRWk9Mem4wZktYQ3NsQmQwdmtqZTFzN1N3VHhObERGVlF6NEM0?=
 =?utf-8?B?cnp3Y1NTaWdvaTFSaXJmZWczMHBuZFIveHhxbVVzd2VwQ3YxaVkrSm0ySWtk?=
 =?utf-8?B?ZjJRS2dIVHFnWjU4ZjVCRFFDbVFOM3M4dFptSGJIV01iQXdVcXJQbVFDRks5?=
 =?utf-8?B?LzUvaVRSUHZEcVEvNDh3WXZXYTBXK0tsbmtZTjNDMHZNdk1lK2kwVUtVWFgy?=
 =?utf-8?B?NCtHdDVNTWN6RlRkVC9vRC92NnhOTEFhaS9DTzBLRmhHM3AvZUJFZXV0UlB1?=
 =?utf-8?B?T2FoTXhaNjNMbnNsNUk5Z09pYTAvQldaSG1lUWdpZXNHRCtHNEFFSmVoSlAr?=
 =?utf-8?B?am1MN0hyQm00UmtxLzF5ZHRUOE1KQXpMNFU2VzVBcU9DR0xkN0ZKYmQwZXNu?=
 =?utf-8?B?QzE1OUN6UGU1bDJWd1BLY244V0hCUmdpZi96VHFEbVI0U2FuemNHMy9aeGtt?=
 =?utf-8?B?TFhmTlJMZXc2Z3FMdEtWbDMyY0JTbk1VN3VZamNCeGV5dzFoT3VpeHQrd1Vy?=
 =?utf-8?B?SUVNZHYzL28vME9uMmZtNzdIU0Z6UC9PWjB2K3lUWVVzMWorbEJSUHpYMksy?=
 =?utf-8?B?RlVUNEZaY2ZRZjEyY3RjK1UvOTVWNHlFWUhTZG1Pa0NnVzZPYnlEZ0FCVXQ3?=
 =?utf-8?B?QTFKUnpsdDdhd1FKQ0tQbDNSdVdrd3AzKzBUeW5rTW5UcjRtbTNjUlRzNlNn?=
 =?utf-8?B?ZnVxSzdCTGplVm8yc21yNU5PNHlSRFlHeHdLdXlxalAyb3hMaytRMTNMQzV5?=
 =?utf-8?B?Q2g0MERBUk9Tak5NRjhhbFU0dUJPYWlYUWpmcU9KK2p6aGNMVjNCVDE1Y0NY?=
 =?utf-8?B?RU9Dc0R5QkdBTW5SbXpXWW1aRWgvVW56TllaNU5jM0prdk1IYjl2S0hIeHhy?=
 =?utf-8?B?eTZnc09CY1d4K01ubnYxelh4c28vNWpnTGRLVU5YekJIeW4rNHA5SDdLeTVq?=
 =?utf-8?B?ZjZvUlM3TEJ4blNhcm5rRUxVd3JYZnJrRkZUSWcwKzVKeTFaU1k5bmU0aUY2?=
 =?utf-8?B?ZDdvVUpnRGJ0WDlQdWtXRW56eW9PVjRuM3dLckJTdGQ0aFpSWDE2T1Zmc0F0?=
 =?utf-8?B?WVNtdHR5ajB4WiswZXRPcWpab3Q2b1d5RXErWHFiV2UyWHY4MGphTHpVTzVP?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 894c1b3e-757d-4987-386a-08dbf05f8a01
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:15:33.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3Ra1TXv+srF//V9EB+ceSyTMzC5FfqA7rgzwRHenUOueCalhKXFOCag9CgtraP7D9r20VCbryoVId57qIVYl2wVLXKIxGJHvjx5GGkQLUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> struct perf_event_attr initialization is spread into
> perf_event_initialize() and perf_event_attr_initialize() and setting
> ->config is hardcoded by the deepest level.
> 
> perf_event_attr init belongs to perf_event_attr_initialize() so move it
> entirely there. Rename the other function
> perf_event_initialized_read_format().
> 
> Call each init function directly from the test as they will take
> different parameters (especially true after the perf related global
> variables are moved to local variables).
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


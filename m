Return-Path: <linux-kselftest+bounces-758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB187FC91E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3A11C20A89
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EAF481B7;
	Tue, 28 Nov 2023 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arQoQ6iC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A2D5B;
	Tue, 28 Nov 2023 14:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209451; x=1732745451;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vMivPnCxYxf38EMtMSJ5O1kBXrA1GPU3hPZKSFeL2Xw=;
  b=arQoQ6iC7aAmQpFPNGoVWszNyNieas9klGm+w1ZWw2iHdXzlIpmmfvT+
   RFDU+edmpmYxKMEQscNNI0fR5jBRx5WLl8Jrhi9mwKahtqKTN/fg30cEw
   raudPG7AZLA3jroaMWyDz66fkMOn0Cbwh4oCsYJ4iBsHzwPLs8u3URWKQ
   ClVWqUb+HcQBvxGfb8N2xK3kO2PXDrq5c2PIhsqsePVVjobHpdV8KUOlf
   kyaOzx96OSitC8rt3jjL+qh4uC2pZV3aUwr1WsqkJf56vft3Ff9kXEtrz
   6kGGgLoUyQCu0LERVX4uxpXN8AWu7ZkAWAr+VpTfH+C3SM4szbABKPX0l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="459542717"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="459542717"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:10:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="768680146"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="768680146"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:10:37 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:10:36 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:10:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:10:36 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:10:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nktogIzbgm8vEiNf5w3tfW+Ou8Lqe2PLcruIVDOTYCywtMa3+4tHTIUnPBSzlKJmlXSbZdGHMoMYN5XDqPIbIQPx/fNQCH9XtAiqqFXVLcgxlqRpmHiESKaJmUsx1+ypzcCNcv91tyyhyZe1JEUk+JaEc+6u0LnEAe+yqs2gSe8LIA84v8KbgsU0ZZN1OI+DlKacX+BKcQnNG5KzCLST0J6DQdHNHY2VmwVZAFUlH6YCDXOTWA0O2DTUHZbsExRucmVkyh4eIddWeqKfpJEdGrjPlj6K4xj3gq986xtSljMjGriGMXPSDU+isbT4jtQd4TuGkMIoGbvFFkVVysshOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YImaUthpfoprTzSyGmx0hNvTplQiz3LMlmncPHQbMjw=;
 b=bVQIDsFSmfzv2+piySx1adWeLv3gBCsMZrPG6kQ7X3qRs6qg5IGSZMJ/4tTvxvhKHFYXxQlq/MPOkbhjksoaDClVo9W44omMQJtG5gDYl2WGOWe1HpYO/rUGmqzxFdNhVofPjHIX17ANCZk6ib5cLUewAhcR+hqYmlDZEwvV0elCvwZihOAfl5q7cH1+qICCAwNeKw/PHiDWv2dX4CEXo98yH61McuX/ylcdYvlK5ZAt3XLeIKK15PqWWWY+4/6aqPxnzavCAL1ky3gCjIDPNWSChq2EwONm/W0tJdLFApZcINyEdy1biCKFYQAvenfvvetcVnplHINMtv1R05KGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6328.namprd11.prod.outlook.com (2603:10b6:8:cc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Tue, 28 Nov 2023 22:10:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:10:34 +0000
Message-ID: <213df261-03ee-4b13-80ac-236c2dfde09a@intel.com>
Date: Tue, 28 Nov 2023 14:10:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/26] selftests/resctrl: Refactor fill_buf functions
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-4-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-4-ilpo.jarvinen@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d18ecdb-d7ed-4635-0bb2-08dbf05ed7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjO3zKbMeewqWjmmh1XZiFrr4W6v/YrQiAXdKG1uWPRofOO/ANPeFIVSZSr0JnPs6senJg4eYn1UlbezczkGfswQxkjOlNI0xAPRoN3B6TkoIRU6SXOw8zgtzpTZ3sYhRg+xGTBD7WJH23ReVqDtlJ/L6IwjPksP17V01OpiNH52HcJF/RgxpHMepnloTRz3354cQOo5DdJGtuZ5Et15BB07iwTPkd6In3vOgovnwiJVSrViscfbQ8tXFQa+gA1f/ywu1nm2yBM5OVbeXreOKIy55d2ty+6lgZrCsIph9D0M329vRUGup5CSq8ZAnw3KzTZoAJOT7wM4KjNA6r+NL1B6mt+0/8Z1706dlf0HkOQD+39BU5c/EwK3YLd57dNxLhj2Vl1cQ44l7U2l5H16va9d8DoXU6Obfr9skRE88cLQIM9kkcp9Rxm/tVklEWBKaunRmfMCTZ5kVYyw0oV9d8cPiLStDeaD52nceAy9pIQcydf21GU1UPQUjvIUa9l5zPODPBgWmR99cs7I1Zozvlsx0UeztvBsxL0u/lwj3JaFtbrtPFSpPyhgrKYmUtf3NGmKxDs6cDhzLfnkNDQgqk217IOLKfuZTA4cowQO+0I6y/3nAprSBWfpoWtA8EZX7M7aPqwO5BqnyjLrix12lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(4744005)(44832011)(41300700001)(8936002)(4326008)(8676002)(31686004)(2906002)(110136005)(6636002)(316002)(66556008)(66946007)(66476007)(2616005)(6486002)(478600001)(36756003)(53546011)(6512007)(26005)(6506007)(86362001)(38100700002)(82960400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFhQTURuNlNCcXNzZ2poY0RJL2V1RVJRWW5DK2Q1OE9QRCtrK2ZzL09kZkJv?=
 =?utf-8?B?MUhQYkh2WHh6UHVVZkNtZi8wUkJPQkRZbzNyK1p5RTNvUHhqQ3VscjFhazk1?=
 =?utf-8?B?VDZjN3B3d0FyOFdIT1JmTTBWbkg4YnFmVi9SM0dEL2t0M0N2V2UzZG5wMzZZ?=
 =?utf-8?B?MFBqVlJ6MlFCUXBZTEVna1hJaDF6akxpNm1DTFZLSUZVZDlSMzdMN25uL2pu?=
 =?utf-8?B?Nll6czM3LzVWcEh1alJwU0Y1VnZYQkc2UUtCVUNTendaVndkY1RJRGxFcm1q?=
 =?utf-8?B?QmYzZ1dtSktsTVBubmthTDA4Q2tWeWE2TjhxVmNuTWJJMHhVSmViSVBPYnFL?=
 =?utf-8?B?aUV2SVlpa2xNQmdmN0x1Y3YwTEFIMFVYYmxwWXdCQlRzcm5XTkxRcVU1cjZk?=
 =?utf-8?B?Z0xOM285SjNzMnVFM3JmNHYvend1TmVvb0tjRGYzbXNBbStTUkdwZDQzbGxy?=
 =?utf-8?B?RUtrcTl1RGxiY0VRSXN2YWIzMjF5VC9VS0h2L3h6dFFnMTE0eW5mV0RnQ2xB?=
 =?utf-8?B?QnRoTmZTdkFuc202d0dEUWJNamFsUXJiV2oyNDBGNHBuS25jZnFicTNxQVoz?=
 =?utf-8?B?Y0hmMnB4SGJWNjhwWGlOaytOZC95WjVkeWlMK1Flc2wwRkJPVjhFK1lJdzhv?=
 =?utf-8?B?TGtHbGE1dGI0Wm52SWhZT3B5VldWdlAwY1A2MVZsZkNsMFdFNG9oMGxxaHp1?=
 =?utf-8?B?N1hBajV2R1dpMnhPSXM4MnJUK2NtNG1hZ3BER3dCTlhFbk5hVVV6UFR0WnBQ?=
 =?utf-8?B?UzJ0SXdoSzVYT0RSUmpBaHp2Q2NWbCtub29JMGVHblRMa1JldjdJR2FJRldW?=
 =?utf-8?B?R1kwU3ZFd1VNY1ZGamt3cFJIaHFGOG5TSjhsZU1BVXNzK3NkaHBNbTFtSmRi?=
 =?utf-8?B?aEdXQk45aTJJU1ArTUl0aHlOeFJVcHRSbDI5Nlpjc2pFTHlnNFFnS3AxVkdn?=
 =?utf-8?B?Y1hxSW56V1FWTUlHM3Q4U0o5ZHlkVDdjU1IrREhML0tQVUVwYTBLZ09HYlAw?=
 =?utf-8?B?WHM5OHR5WFVnOUpuNTFhVUMzZXNaTVlHcENKNmpWTDk3N2hUUEtEeWEvRGIz?=
 =?utf-8?B?MWJXTUtHTFg1dnJ4MVBMd2JGYnhXYU5nN3ZHbHBSQ0RKaHdySEllblh3T2pX?=
 =?utf-8?B?OU5sZ2Z2RU5NaHpZSUxHbWh0elZWQkdVSmRSNnhTN1IxZDdPQmVyVndTQlhF?=
 =?utf-8?B?NS9jNFdDU1dNTFZMM0pLc1BxWEtVVXlFWEtxOFhRSXk1OVBkTzJqTzdYdFNZ?=
 =?utf-8?B?SCttUU1oaEhiUkU1R1orYmJ1Snc3NDdVdjNIN3ZJTmNOWGFNbGZkbHhiQlls?=
 =?utf-8?B?bzVnNEEvNkRwMUNOcWdqUi9BdENIVUloZUw2RTZHT2RLbU0vR2hDUkJKKzJx?=
 =?utf-8?B?cWc0Y1pqbFR0ZHpwRDloaUg1NXlxZWpiV2Z5L3dRQ0tuR3BZMUVYWnBvRnkz?=
 =?utf-8?B?UXo0L0NhNVFEK1ZiL2pqRVVoemZ6dUZodmxqTzlHdFJNRVZUcFRmVW5RS3lQ?=
 =?utf-8?B?V2d4ZlMzZ2V0NWtxSlZHZGZnczNXc29RaXBraEVtOXFKcjVBUXM0MitJc1Fl?=
 =?utf-8?B?YXE5M2ZEK3lVU2owSjhDVlJuL3dxVWVwc1ZqaHlmZ3RBT1ovb2hkbVAyNWh6?=
 =?utf-8?B?VzBxVnhEUUc1N042T2hxeHBhVitDdXhFNnVPaXoxbi9ZbWQxOFFJd1o3ZG4r?=
 =?utf-8?B?WmdCalczbitpNDI4R0JhR2JiV1RZTHIvTkFTeWNIUE5yeEZnQWJibzM0SXNI?=
 =?utf-8?B?WWtVOUkxUER6OFBuTEFhMDdYUG9yY3hmTTVOTjUzWklIbys5M0I1VzR5cGFB?=
 =?utf-8?B?OUdwek1wWnB5VThWeHZHUjA5bndwbXBnVHU1UXBuNVMxSHZHQ3RreGdtVlNX?=
 =?utf-8?B?UnU0ZEtnRk83YXZGbGRjSVRaNno3RXA3L2tmZEVxdFRwK1Z1WS9nN1JSV3R2?=
 =?utf-8?B?M3JsMUF2empJYzAzU1pnV3pBZ29QdjVzQTJsSVM0MzdIUUpvSC9LaUV5bWdR?=
 =?utf-8?B?c1NCbVdSMXlYYjJOQmtxRU1ONGY5bU9DNE56NWZzb01VMFpnTmNDUnhNbE1u?=
 =?utf-8?B?b2c0WjhTem1vTHNHQjZkM0ZwQWs0YkhTTWdxVXEvZ1BGWmVkVUNxNnNWbDI4?=
 =?utf-8?B?KzArMzY3Y0JYUU1rVlJVK1Bpc2hmUlRheUEvZ0dnMGp5N3p0eEk5RXl4TmJR?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d18ecdb-d7ed-4635-0bb2-08dbf05ed7e4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:10:34.3916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGsKP7KHX6SRQRzXqz5SSXcUAhZKS7BcWKoNN8qfVn5ZMfPwfQadOuY9vVIBWnxZ9cdQzrg1HlymU2jbTCbu9SPbemeHAb+zGuON501w4GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6328
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> There are unnecessary nested calls in fill_buf.c:
>   - run_fill_buf() calls fill_cache()
>   - alloc_buffer() calls malloc_and_init_memory()
> 
> Simplify the code flow and remove those unnecessary call levels by
> moving the called code inside the calling function.
> 
> Resolve the difference in run_fill_buf() and fill_cache() parameter
> name into 'buf_size' which is more descriptive than 'span'. Also, while
> moving the allocation related code, rename 'p' into 'buf' to be
> consistent in naming the variables.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F117E5B3A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 17:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjKHQby (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 11:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjKHQbx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 11:31:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE851BE5;
        Wed,  8 Nov 2023 08:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699461111; x=1730997111;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W5+W0MbpeueWgouPv4A6SSCPEnnFW1r8WRLh3ymAvzU=;
  b=gtOa1l+v8q71aNGkjpTsvNiZ9SxkstK3EnX80QxdhADMSILK2foOFcA8
   ycA5br5Wqs9ukNkChcI94YC8Isciuk4PN+GYjwmYdSSh5qKGOFP0l/hVA
   MnNrXGFkELyjhejmkBrQSffRZYWOaCldazSuq6Ojy4UZFvhvK2YJh+rvm
   LOa0o9h+kZQeBxUY9OXPOZOl5LBrE5R7mLAo9BTPgCv3pw35TSP7gLJt0
   CaBdXF+IroONd72d3vthQ/gm78SQSjtwG8Pjb0/+NC5E+dC1Y0Jlz3ARo
   xJxo8sMLoSAPt1mKXPCcmOpBZQQHByTGB2uZjs0VN8wf4TR56Ludn75Hn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="456296366"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="456296366"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 08:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="763106225"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="763106225"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 08:31:50 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 08:31:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 08:31:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 08:31:50 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 08:31:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6d/skxhIWbOJ+6/AskAeXG6lsiM6tL/2SjsOB9tOUljqrj/fpn6wPdORgJ7Pv279lutLGUVTaVfrId7uiXfqukFsqzGdRxMhUp2wDfuPacGgG2tNfbmMg0B+5txDy4giuT5r3pcbsVplcCtDsYnEbCy214iu/GrSq+Su21/K4b2jZ3iRgsr8jwr7CIJAYffr5h3X11LTAiWYDsxFoHtj7jqIfsAXvDuhGIn6GITXEi3lAIRtUa2wVZeXhFB+aia/Ldw0xSKHjGj7WlFByVZhvpjfrkAkoHY8tp4y5/cZAEqxouyMWnKYzbO5qOYEYFjAHX22iOmZSIg0dHCpTb70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIVeXPBGedI/7MrTlPO0gNmGLfhIqyvU03lBf5CW/GY=;
 b=iFq99flcV2d7sxd85aP/NUoaklh3w35E3LZuj5/8ag9aFv+1U0ca0ML89vGEab7diTDmlqW1YyA0mb1+dpq3Q0Wk3xcBB59xwhcZfSQQ2VWNwitYbrS8lmfSBsMnK3iyarcTQEulzIiABvdhbrbCAOjk+HKjZ11hzH1PLSJFaGCAFKAF23z7MgsmPLLvvMP4EVcQgMOitzUuDHC4u+tF2DJ94WpQBqBt+FwoPKvO66WQ1ziGc8nTS7MXUepvAWUYsEeURiNTLveEzmcWy1AmVmUJHY+t6ym48+2DiIfFCjqYkpw9mQuXXc6yUQVOz0Z4JRG2/7oGTBGiEcM/3nP9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8317.namprd11.prod.outlook.com (2603:10b6:806:38d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 16:31:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 16:31:48 +0000
Message-ID: <b9f7c227-7d64-453e-8ec6-6c20ad3881c7@intel.com>
Date:   Wed, 8 Nov 2023 08:31:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] selftests/resctrl: Add L2 CAT test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-24-ilpo.jarvinen@linux.intel.com>
 <8051f3ef-1126-41fb-b6cc-f48441936dd7@intel.com>
 <2514e73e-2419-7c88-3f22-469db4b2fa25@linux.intel.com>
 <48c6795b-554a-4019-bb8d-a2ca0f6fbb2b@intel.com>
 <4008929-d12b-793e-dce8-eb5ba03b4ebb@linux.intel.com>
 <755ed028-f73a-47ed-a58a-65f4f48eaee3@intel.com>
 <af68ec80-7511-4861-b4ec-0fb9c7284513@intel.com>
 <d3dc1393-f51d-1fea-2787-4063abdc7c33@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d3dc1393-f51d-1fea-2787-4063abdc7c33@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:303:8f::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc613d9-d21f-471e-6659-08dbe0783443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esDZybcndkV/M7LJCG8GkhMUaYWijqVbjocwnCcRSjFA10grviO6YMDichiRFZWLKKLZ+yaI0fszOqRlJGS/N9Jx0AU8qC9mczAL3s+0+YHIzWgR5x1isyq/BaLmy1Kz+hv/SAvRzr2kkKTeib3B6+PMPhzrDMzU2ZmeYrHvwE03Cz1rLoP64/XmMQRJ0Kv5lGldJqW8gOnEAH7NRR2BV2d8jnPeXQVFXiJoBiLBSyjxcbCcqNvIh6so8yHq4piyAzNwtE9JyyYeSu82GGHaA7G1HsucOkmjET7SpLryLYStr3pClErEFalv/aEQPNF3DwZ3VjGPdCfAZTb2gxgdWTLrWljjwNxJEpCdvURYo4aqU4AoYjDOFeaP0XqF+lPyiraqCWbunetMsANWIcz4AoDkafr1ghC/hrgK52RB/crorN937l0QkRIR3Ig5KPv9Oqs4mMB84tvgkWy/6aTB9QMh48B72yUI/Ct14VVHvoIzr6YX7umnz3oGLsAYuqkS0AfiFTrrxy6iq6yli81gUULmSOrvgYwEWb+TRh1pQLqsZTuYh9Cb9N4w3VtAiCvud1GBAufHzH7voOgiJvC4onB6TOZmJoZe5sj+6R/R537PDo14kbIDWYokwuxi5Ng0PEbQ7cf228Yd5FVo5aRmOiqYdvJYWtmiLTDGw9VF2SV0cH8MRgopORXL9NQ3Uq43
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(8936002)(41300700001)(6916009)(8676002)(4326008)(36756003)(2906002)(38100700002)(5660300002)(31696002)(6486002)(53546011)(966005)(66556008)(6512007)(316002)(31686004)(66476007)(86362001)(44832011)(66899024)(26005)(66946007)(66574015)(83380400001)(54906003)(82960400001)(2616005)(478600001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QndGNTJUKzdGUjczTHJJVHBGLzZlUG5ERzZjZEtVNXNLbWFqWHQvd0ZkdGV3?=
 =?utf-8?B?U1lFQ2V2NVRwNzBUZXBpR0lvYWw0K2t1ZFVZWVV2UHpDaGUza0t1NkNYRU1C?=
 =?utf-8?B?bzZ1VnJtc0FKb1A2M2ZGRmZLVnVjSFNwUzRad1NIK3ROZnJ6OUFTazFSTlpZ?=
 =?utf-8?B?Mm4yTUxyTHN6N3BhYnRJZ2xyRWFHM1llSUVLUm1qSXhFWWtvTlE5V1E2SUtY?=
 =?utf-8?B?c1ErZEx4Wk5jL3JWcnYvdjF5bk1WdGFmWjM4THhsZy8yTjE1REdTYXhpdkVo?=
 =?utf-8?B?QVRnMWxiY0VWTVg4cWxWQUpuN3lFM2I0RE9hWVQrT2hFck9Wb0xuU3hOVURw?=
 =?utf-8?B?K3hnQXI1eHpiQTFUV2NjTEFZWHpMTUJidXk4aU8zb1N4ejFPTnk4MVJwSzZa?=
 =?utf-8?B?MDl4MG5nSjBlY0hFREE4MWpscW0xNEtuZEZ5MVFKV1ZWckRuN01pL1Y4NmEx?=
 =?utf-8?B?Z3lNSXhFeVZXanFOSWZySXF1RWVPb0FVbEs2MkVLeGdWSldUa0dhZk9mTUFl?=
 =?utf-8?B?Mkg1WXBKZTB2c1ZMdnJKRUFQSXhoVmVhNFZhd1M0UTRnSDNJdklJby8ydEEw?=
 =?utf-8?B?dDZibXhmYXZhR1VYVkNlSTZrOTYrRm94cHdKTW1yUnRGVlROUEExbHIxdHRT?=
 =?utf-8?B?TnB3Sk9DWFR2UG5BWGZoQUo0WjViSkxRVFZacjJyekJ5TzF3UEM0emdqVDJ5?=
 =?utf-8?B?UzJ6ZHR2U2xpRmJEblJlZ0ZKRUxjMGlxMW15UUE5TWoxZktsM0dEb29YVGhk?=
 =?utf-8?B?YzFlc2REQi9XTG84em52TFlzNEZ4YVZpbE03WkFIWjJybjlEcWt0V0hlT2NP?=
 =?utf-8?B?MEk3UkdPajFGcDZFSFdiamRCWWxBRk5pSmkzOXRud2RZUXkzV2lyU3lEQ2Rp?=
 =?utf-8?B?dlJ4cU5MQXVYQTRTTDkrNnFvWEV3Skx2OWRDUVg0b2xYak53RlRhMncxTDNp?=
 =?utf-8?B?ZSt6VXJVbGhvTUJjSG5XU09QQ3ZXUUp3QXBpL2JxUTNmWU4wRFFHSWtDcWVW?=
 =?utf-8?B?bEExR2pnajVqcWVudWFpTkNGODFmYVRUV2o5K1l6NXVIcVQ2MlhwVDlzWWsx?=
 =?utf-8?B?alc5c0V2V1N6Z3ZPQTVlTnV2RXJZYTR0RXY0ZzRzRUFlc3dERDFNMW9qRW16?=
 =?utf-8?B?NVR4M0o2NTNnMCsveVgvZW0rZm5JSnlyUnhldkU1VkF2ZDN4c2o4bW1YUFdl?=
 =?utf-8?B?YlM0ZXg3SjBmNngzd1BLM3AvcGg3MHBlQmhORW1kT0ZvOHd2bmU5RElEVmF1?=
 =?utf-8?B?SVliL1lmSDhIN1Z2SEc2L0N0UnBDZUlrMEVNVjAvWXk5N3FvclpJQU1SQmpL?=
 =?utf-8?B?TmkrVzMrUUFuUnc2alJsWVZUL1hhSEROWk1ZdHBBSVFBeWJDby9MZFVnd2dm?=
 =?utf-8?B?RWVFSEtFaEU3NFRuaGVEblVFbFEzVGUvZXhGNDB2MExpc09FZThvM0dEalcw?=
 =?utf-8?B?YThZWGdjVmhiRHlQSXV5c3BmMEVDZGFMcVdtcnUzM2lieGdxUkZXQlN0ME9H?=
 =?utf-8?B?WUJUR2xOSmtNYTU1TVp2VjBrSmU3OFlDQll2S29oT0s1MUpuNkt4VnZ0Wmp0?=
 =?utf-8?B?TnZrNTNZbS9sdERHOUhHMmN1bGpNVDNGRVNiYkloSmlnWkExQ2R3U0xVRkRL?=
 =?utf-8?B?czNwdmYzNVZreFFGVE41ZVNVVE8vRUlYUG9JSktHeVFhWFNtY2FrdUhrdnB4?=
 =?utf-8?B?R2tlWitDRWU1MW1tWitTNDd4UjJHdEhDK24xemo0elU0emRzc08xdkp6K21I?=
 =?utf-8?B?eXIvQ1E0VHlySkUwV1dWcE5talNQdVhJc1VNTkhva1hTR0NGbEZ2dnVVNkFq?=
 =?utf-8?B?VkFwS3dDQ2hXQ1EzUkRidFlnN2VBdWNHWitBSk5CZ1pKNUNnWkJYSU13M1BH?=
 =?utf-8?B?WlVpeFBYR3IzMTZPb2xxMzJ5T2VuekF4Q1NIb0hXTjRrbzFQZ3RSNmhPTjlD?=
 =?utf-8?B?dGRtZjZMN2tDNy9DTTFLbVJLUmFzVkh5OVZNQURCR2VWb1p3eDEwZ2hZN3Rm?=
 =?utf-8?B?Q3pYMVVUcHd4OHBqMjJPZjltNmFMSWJBekgrRmpYaVFmZW15eUFreWlIN2pW?=
 =?utf-8?B?d1B6c0V1aVBZaHBJRHZkS0lDS3A0VkZ0VVNYc2NaVDhHYmNITFFidFZ1eWZX?=
 =?utf-8?B?UUpZbjlBN0pzdzYwMHl6YWVWeXhWRGo2SWhnU3B5dHJGZmpqcUptWUUzWkxC?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc613d9-d21f-471e-6659-08dbe0783443
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 16:31:48.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYAquYOctmAPwNtUFavNlca57RRldyq5TmhvYM1NLp9kQ0GwygGCvCRwq6rkH2q8wClOoU4zj4kY2N1Qk4CJutuNBfx0ZnZu73qI53tYGl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8317
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 11/7/2023 1:33 AM, Ilpo Järvinen wrote:
> man perf_event_open() says this:
> 
> "If type is PERF_TYPE_RAW, then a custom "raw" config  value  is  needed.
> Most  CPUs  support  events  that  are  not covered by the "generalized"
> events.  These are implementation defined; see your CPU manual (for  ex-
> ample  the  Intel Volume 3B documentation or the AMD BIOS and Kernel De-
> veloper Guide).  The libpfm4 library can be used to translate  from  the
> name in the architectural manuals to the raw hex value perf_event_open()
> expects in this field."
> 
> ...I've not come across libpfm myself either but to me it looks libpfm 
> bridges between those architecture specific tables and perf_event_open(). 
> That is, it could provide the binary value necessary in constructing the 
> perf_event_attr struct.
> 
> I think this is probably the function which maps string -> 
> perf_event_attr:
> 
> https://man7.org/linux/man-pages/man3/pfm_get_os_event_encoding.3.html
> 

This sounds promising. If this works out I think that it would be ideal if
the L2 CAT test is not blocked by absence of libpfm. That is, the resctrl
tests should not fail to build if libpfm is not present but instead
L2 CAT just turns into a simple functional test. To accomplish this it looks
like tools/build/Makefile.feature can be helpful and already has a check
for libpfm.

Reinette


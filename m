Return-Path: <linux-kselftest+bounces-4026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B74E8475EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 18:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38FE8B2242F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B3D14900F;
	Fri,  2 Feb 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JaY3YZd6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7C14D42C;
	Fri,  2 Feb 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893848; cv=fail; b=qYOyrzfb+6RI31d+3uOSJzWw9KEOFIn9c2XlTc4osW1pWxulJiKFRzMcJmnSbHk/nbMY9gw/eayXCScVsVJVymAfO8BGt11HKEH0fH4aCLG1QkZkcphREB0wZVvye6RhH88ku0V4p1TUNEVPVs+ZpL7OzokBmM266yBsLIngrh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893848; c=relaxed/simple;
	bh=o3O1JAT2++Se3skSkcvhLNMuMze0rRn+rD70dQTr5q4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kPsiszP08wHp0tvUzqVubJK0bjbYPq/ug78KN/psKuAd/LZGd51/o0d+/PaH07BHVOXXQ+uBFcf0KMoI8O1QOb8LEHZBqwLDb624xrYmIEebsvnPMllqLjnIyJq2Evs51yA1vh/2SjPHho8/IA8+xel4fmHfycF1d1Vjk4U25fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JaY3YZd6; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706893847; x=1738429847;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o3O1JAT2++Se3skSkcvhLNMuMze0rRn+rD70dQTr5q4=;
  b=JaY3YZd6u4l1kYe9UcHIiJNYvisCopF69Hu4nyYgKx0ry4+ddyuenCWs
   JpbYbE3R10oYiANp+1TeV6uMWDMdGK/7MEEwpxIzx3gG/IaazisHuYu0+
   kP44i9cTAs95HHxiWox6VvKI36FgSJQlz9q88Pxew/igMXWxIZjxaM9st
   Cljk0jXocXGSXNZDpgO++CoY4PcWAsOUj1i4trgaWu5cBSWnBoVMO016Z
   bGhuYtloccUARnyaJkDZEAz3hGRSxWXzyoe7Mx/p9jLFOwAWnOEl/NJRE
   XngRpR74UH8bge6jbAKYVkgzkazDgjgMY5H0gsc+dCLc/0fw7yG1oCW4I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="373598"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="373598"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:10:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="402430"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 09:10:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 09:10:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 09:10:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 09:10:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 09:10:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWF0VprDH5diXEjazQcNkj0ZvtRgLUD4Ve5Rv6s25f5WFfids2tgfLk0EnbfDeDFY70GsdimPaRDhDgmSwMniPJ7Ap9c/9a/n+iJBcQ3tohy+jIWdDi4ZH9YdYP5m4TSpDxQBjhZQc48sLr7Cpf8LJqL9NDt0gZtZv9kr1zEv/FOOUrVLo6dtwWkIXivtt06G+WuBvVlt/26lvE7DVhnlaNvpVWCZPNF2uN9DTv31hsrDyEJD/VXxXDkBykqVJ7FYo6jCcdPELnLNF7i+817Lpy9u5Co0aoIkqqtTADSNTCbzRtQd4UEaD1/43hjIQEgfEGGptgzsOgyVrNNbnPOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s26D+ogVQ5IqRlWwq4ZjwDi603Q3cr8MYPxGl0DQ794=;
 b=Kd+xBL5sxsYMPz0CSHZMHeH8gzdf3Ubpz0qdg9aeEQIo2ge27J7icXnOlI/QKMrUx0lu1GN27NWxdPG7YXieUF8TxGyL6XoGu86F93QJ4SkH0i2fwhLC3w9eZBYpGUDltdTnvL0kPJ/u03PVLcLYX5rpMxsunT8fSMoHopOaAiyCkd1M3knvx6qRNOoPJSDk6uasixzpZRyd5QPe8dPCZiqG6RNryvqLU91/rblfv3C4GsCbzCzJ0gMv3eBJm5DUxIX05xtB0hoS8nahLxT1gn76uXiCUsqOwQqe3DQMUHTSl/TpvogAic+H545Pf5oFIzUkhdHkLRCTJiXlGNfAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 17:10:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 17:10:27 +0000
Message-ID: <bb3ec879-074a-4b5c-bc54-5ca4398f0c0b@intel.com>
Date: Fri, 2 Feb 2024 09:10:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
 <647fbfd449f8b0e0ad6cfe58bb280ff44ee162b8.1706180726.git.maciej.wieczor-retman@intel.com>
 <db08ba56-ae73-4c70-87fb-aae59e524238@intel.com>
 <jbgkiwfkotntcdzhwf27dceit4w3j37sumkayixmyuee6zyaqg@un22a2iljgmr>
 <6a7b14a7-966d-4953-9b9b-0c847c83ddbb@intel.com>
 <icdfnbyc7kvt7llxc5qq5i7icmuev5us3i4pqapyreqfmkkztk@iqsthvhf2uem>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <icdfnbyc7kvt7llxc5qq5i7icmuev5us3i4pqapyreqfmkkztk@iqsthvhf2uem>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:303:b8::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: f446dbfe-b876-4fcd-aff6-08dc2411da28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Stq/AmkkcDbGQaKSmnyeLorL40nfmzC2iQ0Xv6pND5FmqstuxJu/FMDUlxrBgYlOaK1GJlUEWbvV0qAHrPSEVmcu2bho/VuoT7cookBaL5iaoNXP2gF0jBkE8tul/E31emmrSgmoZDY/B4/IMF7pDDWvnx89kQeT6zTOXCub2zibD4oo7EWnJTqNXnikSxeh3Bp4rviyzwZJtgWU3AAMWHiUB6FBqPRDYndqfLk9h14NVkbESEV1jjHZvtml6LFLNJOTvUCE3nqfXGak5l35HC1dMcZ9sDqec4dlmlsBzG2J3Dqxdk2gh0a33XOZrAcO9S1mb/v+Y9zu39+G8GMZAZcKnbIm3kWEpqDsn+NMITOQwgaLBaT2cqtUa/i4JthhLzn4mdOvYZp9ihqJtctIfAU+bfe5EFAqdrVsWHjBf+NoLrNMLPpc07O4Aukx+Eh6s411kwpxXNaViZjUb+BAnfD4VsSCJeMtJs9GPq0+0V0fgnDQ4wzFTiq162nkHdEea5ri2X4aaI+PRL/DqL/ZH6ktmJJVxTV0tfeEGL/VhgVTw8lvTdo+AQrp3r8jPdKFVz5QgzlHT9DU/zXuEvDot7+yX1YG5zzJJVzsQT+3njuMtbzCOqkyZWlFgqJoOZk9qCaHo3srOoZ22jOsfuh12Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(8676002)(44832011)(66946007)(37006003)(66556008)(66476007)(2906002)(4326008)(6862004)(5660300002)(8936002)(478600001)(316002)(82960400001)(83380400001)(6636002)(6506007)(53546011)(86362001)(6486002)(31696002)(36756003)(6512007)(41300700001)(2616005)(26005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXhBc0twWG92K3RrbCttUTNiL25RRlpmYXZKekJUb09pZUQ2dEVvcTJzMUVW?=
 =?utf-8?B?YWxrZTZocHpheE5QNzR1cjFMRjZ3bnRQUjQ1R3FqbkpSdG92d2dvelZINHVI?=
 =?utf-8?B?c0hpWHVwNWZJNVgzTk1IYUpQaWxxRWVEWVFSdmtIaUdya292dm5Vc2MyUUJ3?=
 =?utf-8?B?S0pmNTZXWDQ2SWs1bTJ0Qm1hMHBnMlRGTUwrVmpsMUVoY0hWZ2dTWWNFRDJv?=
 =?utf-8?B?VzVGaEN6a29kVCt5RzZnOWhxQUVxUzRnZHVxempnYldQUW9ncjQ0OHUrdDNR?=
 =?utf-8?B?K0dlbm4xYndHdnFwdFBxdzJkdFJUdHQya1ZyWWMxemRnNy9GYjhlQzgzdlgz?=
 =?utf-8?B?dkM0U094c0pzL3J4Zkc2N3JUeTU4TVFaZ3Z6Z0RGZ25FR2lZcHpJVlhwYkk0?=
 =?utf-8?B?UDZhRWlMcnBTSVd4cnpmL3gzQ3JSWHpCNHY3Tk5KY2xuZHBlVUpHRis1MkE4?=
 =?utf-8?B?YW1lVnFOWm0yMkdHMnJIUDhiV3BxL05QMXFGQzZwUFZxbXMxTklnQjVDMDU2?=
 =?utf-8?B?U3VucFd6UXlKVVlnenhSVkhGbXJTS2Vvank0c2l3TXZiZEMyZzdjbUVkUmQv?=
 =?utf-8?B?ekNKT2pEaS9GOHJ2VDBIcERPeXpsemNBTmNQS1IxZzdRek9PWG15LzR5ZmtG?=
 =?utf-8?B?ZnFMejJ0WEViUjJLYlU5K2dMam1ESWN6QzYra0FkN1JxMXZaemhPK2VDMEFQ?=
 =?utf-8?B?SEx3STVwcTB5cDR3Q21JZ3U2bDlxVktSdFVZUVFDTDR5S0pkbUZZcWVzeTRZ?=
 =?utf-8?B?eURTUjBCdFBKcFhiUmowSlhxcFd3Q1BHSWNEYmMybUh5QTl6M2VJbnlWUHZm?=
 =?utf-8?B?djArVXROSU41NzBuQW91RzJZRTFUU1ZGUW0wY3dVYWNQeFVBM1NwK2JpMVo0?=
 =?utf-8?B?L3ZJR3ZkYmh5YUhKOVhqS1RwUGNTaFlkUzdVQXRIMnFiek5wUlIrZWE4bXJ6?=
 =?utf-8?B?Mk9BZHdadTR0S2NicVp6Y3RNZ1ZaUFdOa2pKYUthUExOaGx2eEJFbzc3enlY?=
 =?utf-8?B?N0kzS0tFb01pVVBrQlFSUjJ0RmEwdC9yajEvSVhGaWlLQVR1cmM1ZWlKZnNK?=
 =?utf-8?B?WXlXVjlzOU43OGgzV0hZaVdabkZIZzZBNTExYXNidVFDTmMrNWg2T2kxUmpY?=
 =?utf-8?B?ZmZNR21XSmZTbkkwZXdkbkpSYjJqOWl0UlV4UjlCbGUrd0lCUlAwR1hzYktN?=
 =?utf-8?B?eWpkZ2ppbC82WEY5N3ZCSlJCMFcrcG5ReElKdysyb3U5R2NkemVvMXk0ZGhl?=
 =?utf-8?B?MExabFZkR084SjFPWlk1b1FvU0dNS09kM3N3M2ZkVXU0ZkdiUVc0eHhSdWVG?=
 =?utf-8?B?SC9iVG1vY29tR2JXcGg3T3NOYnVyc1IxTEtFczZUdWQzWThXd3ZPL0hZSXJC?=
 =?utf-8?B?YTVsMUJVaE9mMDdWeCtsOG9pOTdIZ2JmMHBYZXdxNEV2TGRsS1hoaE82b2ow?=
 =?utf-8?B?V3JwQzgrenhOTEE0ZEJIZzdRUUdobkRCSmdxN3NXTFArcjFsQ2tlejFFTXEy?=
 =?utf-8?B?Vys4RlIxNmV6dGtBYVNlKy93MFgvL0FZT2lsbVJMQkdKS0FHSVdwQVBVWVZz?=
 =?utf-8?B?R0xNd2pVYmVUa2VONlowc2duY1c2anZTbC80d3FuaHFqMElkaG5NOFBnZDFu?=
 =?utf-8?B?bExQNlBES0ZydjdSMFVTc1U3dVJsamdEQjZwenFWSzlsY0c3UTZFQnVuL1o4?=
 =?utf-8?B?VytjczNjRldVUVZnWlFHTnBrcU9jQmR4OVkyVXFRRXFMT282cWlVY1hOT1Z1?=
 =?utf-8?B?Nk1QejExSnRFVTEzbzBWYTJMOU1aM0dFMnBwTTcvUFpDeTZ6OGV5M1NaOUFr?=
 =?utf-8?B?MzhWRWI2Y2tXa1RXRWQ1NFRNTkZZOExUL2djclhJaGZWYVR0Z05xaDBESzZS?=
 =?utf-8?B?ZnFQdEE1Sk9uaU0razRWMEdvZE5WK09BczFlTWlWTVZyR3FVellEMm13eWYr?=
 =?utf-8?B?TnpUc0N0N05WVFV1VzZvcUw3eDltZllxSldJMWIzYTREM0huK3laS1hPREg1?=
 =?utf-8?B?OWFPNXdJaS9FUHlvcU1XU3lleTV5ZEdBVXZnc1JsVVJhNnNYazI4U2wzMldJ?=
 =?utf-8?B?OENFbktCMjdHWWE5czUzc29rSjlZM3ppbGJOWnNwZXdCb3Fjckttdk1kVjRL?=
 =?utf-8?B?TTAwcGxtSGdPdWpudUFIRmppdlJoQnNVM1NiZnMvelBoWHJqdmpiTTlEZ3l2?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f446dbfe-b876-4fcd-aff6-08dc2411da28
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 17:10:27.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5Q6jemsd+5ntzygC+As7FfYAPsPLYwN+9aN+fH2xzQc3crBupvJkiIiW2utMnWFQXZ9T98USyhWWsSly40x27Bo1Glgg2NHQE3yB5HpjO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/2/2024 2:17 AM, Maciej Wieczor-Retman wrote:
> On 2024-02-01 at 11:47:44 -0800, Reinette Chatre wrote:
>> Hi Maciej,
>>
>> On 1/31/2024 4:55 AM, Maciej Wieczor-Retman wrote:
>>> On 2024-01-26 at 13:10:18 -0800, Reinette Chatre wrote:
>>>> On 1/25/2024 3:13 AM, Maciej Wieczor-Retman wrote:
>>>>> +	if (sparse_masks != ((ecx >> 3) & 1)) {
>>>>> +		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
>>>>> +		return -1;
>>>>
>>>> If I understand correctly this falls into the "test failure" [1] category
>>>> and should return 1? ...
>>>>
>>>>> +	}
>>>>> +
>>>>> +	/* Write checks initialization. */
>>>>> +	ret = get_full_cbm(test->resource, &full_cache_mask);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>>>> +	cont_mask = full_cache_mask >> bit_center;
>>>>> +
>>>>> +	/* Contiguous mask write check. */
>>>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>>>> +	if (ret) {
>>>>> +		ksft_print_msg("Write of contiguous CBM failed\n");
>>>>> +		return ret;
>>>>
>>>> ... although here I think the goal to distinguish between test error and test failure
>>>> falls apart since it is not possible to tell within the test if the failure is
>>>> because of error in the test or if test failed.
>>>
>>> Is there even a distinction between test error and failure in resctrl selftest?
>>
>> There is such a distinction in the current tests (and from what I understand the reason
>> behind the logical XOR used in this test) . In existing tests the running of
>> the test precedes and is clearly separate from determining of the test pass/fail.
>> All the current tests have a clear "run the test" phase where data is collected to
>> a file, followed by an analysis (aka "check results") phase that looks at collected
>> data to determine if the test passes or fails.
>> Note how all the "check results" return either 0 or 1 to indicate test pass
>> or fail respectively. Specifically, you can refer to:
>> mbm_test.c->check_results()
>> mba_test.c->check_results()
>> cmt_test.c->check_results()
>> cat_test.c->check_results()
>>
>>> I've been looking at it for a while and can't find any instances where
>>> ksft_test_result_error() would be used. Everywhere I look it's either pass or
>>> fail. By grep-ing over all selftests I found only five tests that use
>>> ksft_test_result_error().
>>
>> Yes, from the user perspective there is no such distinction. This seems to
>> be entirely internal to the resctrl selftests (but I do not think that this
>> should or can be a hard requirement).
> 
> Okay, thank you, that's what I wanted to know.
> 
>>
>>>
>>> Furthermore there is this one "TODO" in kselftests.h:
>>>
>>> 	/* TODO: how does "error" differ from "fail" or "skip"? */
>>>
>>> If you meant the distintion less literally then I'd say the sparse_masks
>>> comparison to CPUID would be a failure. What I had in mind is that it tries to
>>> validate a resctrl interface relevant to non-contiguous CBMs. If it fails
>>> there is probably something wrong with the code concerning non-contiguous CBMs.
>>
>> Wrong with which code? As I understand this particular check compares the
>> resctrl view of the world to the hardware realities. If this check fails
>> then I do not think this is an issue with the test code (which would make it a test
>> error) but instead a resctrl bug and thus a test failure.
> 
> I also meant a resctrl bug. I was thinking about the kernel resctrl code that
> handles taking the CPUID information about non-contiguous CBMs and putting it in
> the sparse_masks file.
> 
> If there was a hardware problem and CPUID returned wrong information, then the
> check wouldn't fail as sparse_masks relies on CPUID too and both values would
> match. So in view of this I thought that this check could make sure that the
> resctrl kernel code handles CPUID returned information properly.
> 
> So should this check be moved from the "run the test" phase to the end of the
> function ("check results" phase) to signify that it's not an error but a
> failure?

I do not think this test matches the "run" and "check" phases of previous tests,
unless you create a new test for every scenario checked within this test.

Just returning 1 when the check (if (sparse_masks != ((ecx >> 3) & 1))) fails
should be ok, no?

>>> On the other hand writing contiguous CBMs shouldn't fail as far as the
>>> non-contiguous CBMs in CAT test is concerned. So if that fails there might be
>>> something wrong on a higher level and I'd say that can be more of an error than
>>> a failure.
>>
>> I think that the write_schemata() can fail for a variety of reasons, some may
>> indicate an issue with the test while some may indicate an issue with resctrl.
>> It is not possible for the caller of write_schemata() to distinguish.
>>
>>> But I'm just saying how I undestood it so far. If there is some clear
>>> distinction between error and failure definitions I could try to separate it
>>> more explicitly.
>>
>> I do not think it is possible to clearly distinguish between error and failure.
>> These are already lumped together as a ksft_test_result_fail() anyway so no
>> risk of confusion to folks just running the tests.
>> I think the final test result may be confusing to folks parsing the
>> resctrl selftest internals:
>>
>> 	run_single_test()
>> 	{
>> 		...
>> 		ret = test->run_test(test, uparams);
>> 		ksft_test_result(!ret, "%s: test\n", test->name);
>> 		...
>> 	}
>>
>> above means that a test returning negative or greater than zero value is
>> considered a test failure and resctrl tests may return either in the case of
>> an actual test failure ... but from user perspective there is no difference
>> so I do not think it is an issue, just lack of consistency in the resctrl
>> test internals in cases like write_schemata() failure where a possible
>> test fail is captured as a test error. 
>>
>> I do not think it is required to be strict here. Keeping "test returns
>> negative or greater than zero on test failure" seems reasonable to me.
> 
> Okay, so the approach I applied in noncont_cat_run_test() with write_schemata()
> is acceptable?

In general I'd say a write_schemata() failure's return code will be acceptable,
but you should be consistent in this test. There are two write_schemata()
calls in this test, one treats an error return as a failure and the other treats
an error return as an error. Considering this inconsistency I would thus rather
suggest that you always treat write_schemata() error return as a test failure.

Reinette



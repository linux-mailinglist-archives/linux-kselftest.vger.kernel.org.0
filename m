Return-Path: <linux-kselftest+bounces-4175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E6D84AD56
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 05:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48EBB21A1E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 04:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0235745FE;
	Tue,  6 Feb 2024 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lA/CebXQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64A74E02;
	Tue,  6 Feb 2024 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192989; cv=fail; b=p53fB3GFqsY6k6nnxULtmmYver//MeiM+ZBBK7s7Sw0FHlEkoFXH3ZV/fq6bO+X8fvYf/Z112f/A2PlrgdwE3OqrRQyDlVIr6FequN9RpSX+fjBmDC+NkVa3C69IMBPfaUKP6BGXO1jygzLdVHmSWS+mesJTK9AriBUFSAQ0pj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192989; c=relaxed/simple;
	bh=7hofTrwF8ONUD2m1z7ooQBkpdJ/o/STiBhuc8ePAxac=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JhafBffcb5Maw6xTQ2UxgyTQMNx6xvjVB/CLzsonZRl30ntHPZHkY5y9vnDkdbMiemCDBXvsO6h6aqcgNnbLoSr/Fh6iWPqWrwRclnu6oRvEb9AZB1VKYjd8jUc+l+0Vo8KEVVPwduNoty7EKFsYBMqiKMefbY742+pi2xF2Wmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lA/CebXQ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707192987; x=1738728987;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7hofTrwF8ONUD2m1z7ooQBkpdJ/o/STiBhuc8ePAxac=;
  b=lA/CebXQ1KEUv3YG4D8IlVNfX2uk0+OW/umLwcacM0F5q85mKtfvV7TC
   2iU5dxHpViOh4cpCtpSaZewL2hNbFgGXg0Fv6pGFWyUsG7EKR3x63iWIT
   lnTSTXi4LCLcDKfYwN6jqkb9AAELj+Lr6hZpuqvAXhWZAoBMg0MbtuJVE
   4WC44RX1HeS/spfgv7EQ+mYEUPbszcjfZwjZaVnuVJbnMXy0mHpUv815h
   tW/7B5qrCG07uqI2NSqHgMuiqB0HFboz3Zm1U6jJzIpg6PBcSCbbb3yOC
   5AizLQyP3TXafQxjZ+lgfbN5Ky98HuKPAgaUjUGePcY1eeSlIEJifnrHt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11308509"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="11308509"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 20:16:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="923467"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 20:16:26 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 20:16:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 20:16:25 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 20:16:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuW/fyloaF0X+pjUnoM531O6qiLQ75pzttt5B3gPfgPl/dSjz1Lf1xz8k3ekjw7k3daXkZli+/yi+iOAD3gUiyPRgtuB7v0GlTH87RCrvS/9xqBTyu3KLnkh/hHC9dMYEteUNL1xG8wAc0LOUXnUEUuJmR2xUVlupiJSFP4jorb7KqfzqDxMcD0AD78hwazXBuUmfWsrG89kZbMydd0XSj683u9kTL0VcEB02wvmMbXayM6e6E+dle6qDs/o++c+2mLLsSOaWpninyw+2zu+j14TBeAwr+IloXGWTwKuMkBa9FT5Ng241OGFiiOF0NLbBhe/u6OR0qLVPjE5zPOfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1nJkXFXOyaR39HTR6u9a8exiSBN6Kj8FtRZU5KlZxY=;
 b=GLgZPyWzVxKqiXOAx4Yqg5vHt/dpu4gXzL33yfasJKNKSGFp56ug6qv7+W8nK31s8hoLI3qygM5fehUcIjW69lXOQHbsvpzi+U+rwNOCjokfnWT+OYZHx3a3R2ioRDQAXLERVZFIMohQU9zKQ+dU3EGde3588TCoSA8FiEuF0gQlq024wV6Dnc4Tm1VgEY7edBvtrzFnpR2j4/7HbMwGsHt/kUBc3Res8qKU+pPl17ZbaNivxSEEoxvYrHRMxmn04H0ikXLQf64lClj5X7izdDA+fbJG7vOMUzLfbfYAGmFvm315GAzRhI/ErE9/iOC+9BOWhFa/lsL7Am9oZRdQYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7956.namprd11.prod.outlook.com (2603:10b6:208:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 04:16:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 04:16:23 +0000
Message-ID: <d6c1933c-b6af-4677-8f66-22d8a38d534f@intel.com>
Date: Mon, 5 Feb 2024 20:16:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] selftests/resctrl: Add helpers for the
 non-contiguous test
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
 <89b8965d563e4e61b95b20be55c26475d830b245.1707130307.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <89b8965d563e4e61b95b20be55c26475d830b245.1707130307.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:303:8f::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: efa2a7a1-0611-4dcb-ccbe-08dc26ca60f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LvNd55nLPvuZjdhj49HbSDDlr88yMvhgM/oLX4fvix+lOsmCj8mo9v/IOL6dnBeTb3eYqyfZtlF+jEupUNFJuILffBNFnjYjogkOJlFyQGKTBu9othYt7fyokn4ruOFp5su53FrKVyJZGfnOf/QbqrvoL1gO1KyahXkLTE/nHEy6M6DQmYQ6MnRUv/zRMC3cT2aSCNYFEn3/STnZXB4Be1nL27vccr0zBpQ+M4kk1yV2fneN+2ATITyG6xSrRZ4Cz88QM+M4dN6c7x6bpnH7WQTTVTk1RgnLLQ18dxoZAoYlAwYMdQF72D9LKnn+8r6KsUzbjorztODHLOxzy3taFUq6o0gaSakrnWQQ6GKJuADUUW9ObRtQEdotX9JqF+YdBco8Av8+8IRGYtF8wUk8GXCYTcX5hT/psoGLg4f1gqRt++JB6I7JwmeCrw/UG+zW1V3CpTYmbxNlXDUSnRQHGumqrnimL0K6JPRnNpqdqNef9uON22pbP/ACs4QdeeDDB0cpRSN12FnOZnN8WQnGOVCx2AdauUdK1E4O26Mw/OLiosghWtLKsdtyuyduaarLyeisreBI5sebFmIUQIqVs0TsPLOzqk2Xh1sc4+e/JYefTbumJrMFleJ3H3tcM/OaclakJYlckDEKTyQoHVPIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(53546011)(6506007)(6486002)(478600001)(26005)(83380400001)(6512007)(2616005)(5660300002)(44832011)(2906002)(66946007)(66476007)(66556008)(316002)(38100700002)(4326008)(8936002)(8676002)(82960400001)(31686004)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmhoVzRrd0FYT2E5NkRlRlc4bG9hblpNSy80N0NGdnpaVUxxaXptZmkxTWM3?=
 =?utf-8?B?bnhtdEFLczNrbHhUVEhtSlhlNitrSzZuNm1yZjdqVmpIa1c2SWpqNXNLSlVq?=
 =?utf-8?B?VE5MMmVZZk1wVXRxQU5NODFJeldzUGJ4ZFBqYkcrRnQ2ZWE0ckkwZGZYeHdS?=
 =?utf-8?B?bTEzaDgrNGJrZ0oyMlphaE9jRVU3VStKbm5UcDE4eUhoSktrQWRLUFJFbWU5?=
 =?utf-8?B?aXZqai9VUjEwV2F6TWVuaGloaGJWRlRtdElXZVJ4QUFwQWR4UGUxWDk0MzBU?=
 =?utf-8?B?NjdKakZ2NzJqellsWUNKMCtVbXY1OFVkUDVTMUJjNmswUkFlQ2tlUUZmbCs0?=
 =?utf-8?B?NXNtUS83ZEZ0d0xkSndEeDZ3ZjNacEExN0Z4d04xc29OU3Qxem43Z2NMbmJH?=
 =?utf-8?B?d0szUEdnZTc4eDBYUnpVQTVLVHBxZEJkcnBkVFhIKzBIdTZPZlZmSUwrdGVT?=
 =?utf-8?B?YVdGTVQ4dXhrc3dlNkRoZFVyZE1FZ1U1RkYvSmdpU0pxdURLdkVVcDhnYTZI?=
 =?utf-8?B?UklnS051cncxeGs3cnZ4ZkkzaUwyUk9jUXdIZkt5WGNJZkdjQnJUbWJVM2dq?=
 =?utf-8?B?MHY4Umw3Q0lrR1pBVHp4dkFYN3k5TVRWdFBYeWs3UWpxUVU4WHoycURrdG1S?=
 =?utf-8?B?RGlud2lEdkY3M2daYXpRMEc0WUxJc2Q3dCs1WkdxckcxZ1pYM1NqYzZTSldB?=
 =?utf-8?B?R2l1RWswTVR4NllZVHZFQlM3T0ptWk8veW44QkxkS1llQnhQVWx6eFZMYVQ3?=
 =?utf-8?B?cEdMZ1hpbDdiSHBQcTdqdk9oRXo4U2IwdzlQaVVUaUFxY2JBbGFCVE5DbSth?=
 =?utf-8?B?TlpWYityVEh3bTdwYk9SYXQwTnhQN1ZBd0RLTWpoaFEzVmM2ZWJYZzRkbDk4?=
 =?utf-8?B?TmtvK0JpSlZWQ3U3eDlROVNZcU1SbG9Kck52Wk5yVlF6dGs4Y3JDY2UxNHUr?=
 =?utf-8?B?NjJyVHpPUmNFMDZCSU9hWi93V2JiV0VlbzBaWitrbC9SRldsY2ROVXNMeGJt?=
 =?utf-8?B?b3lpTnorUXRzMlRlT0VPZ2hPTkUxOXo4UkRXOFcwL0VDWnVJRDVKcjFKRzRi?=
 =?utf-8?B?T0ZPT3VLdExrOHpCbkZVUFZ3R1pKaml4ZDFFVWxaUTVmK1NJME9xazVibm42?=
 =?utf-8?B?TXAwSTlQOFBMdlFGNUNPb094TFRsTG5zQkJvdC85VHNHTHNLT3NwM09JR0pT?=
 =?utf-8?B?NzA1VWRSWVBDWnUxTDBtT3RicGdlelZHZkxDQU9ubno1V1F5YUgrazRXK2pD?=
 =?utf-8?B?T3p4ZGdOQ0NXRjB2NTI2OE9tcHRMcUhkRm50N1hoSHdHZElVNStJaGM4aXBn?=
 =?utf-8?B?YWRNWmJORmR5bkpPOThiRWh5NmU3M3I3bzJ1S0lxSlora1d5dHFDUFZ5c3pD?=
 =?utf-8?B?NndkR0pXQ2ZHbkgvSVNRaDlyTU5UTytNNElpSlRrOTY5ZVVYZ29uQjRkRFgw?=
 =?utf-8?B?SGFENm5JSWFkNjAxZnBJWDNqeVRxOXV2dG1ZcmZqYlgzczU5QnB5QnJHTmc4?=
 =?utf-8?B?dHNIL00xNzF5am1XSWFYUjAvRmdXVzdNVmZId2dOTW1PL1RlaGJ2TW9tVVhk?=
 =?utf-8?B?aDU5bTEwdmxibDRwZG5UK1F5S0hhK0FpcGJtYnZhK1pmZ3RzeFFPdENCUFJH?=
 =?utf-8?B?eThuc3NkYmNYS2R3TU1abFI4a2lSVktLbVk4cWV2QU44aTAwa0R4MmxmNUhX?=
 =?utf-8?B?dmFrTU9XdGNnMlF0d2xaSzRFY1JFTUZERklCRG5BZGl3aGJXeVFUZWZkRisy?=
 =?utf-8?B?dUZtRDhjZDl5K01yUGFLYUphNnFhL3ByTngrL0FSTk11RzYvNmpEY2VHM0ZR?=
 =?utf-8?B?NmlNZnpjNGRRM1l1RWpTUHdhY1g1Wi82YWZpbmQ2N2ViY21hSEw2UjF2Skxj?=
 =?utf-8?B?R3JsbUNGNllKb2lZbGxqL2FPNXBGNDFYRHlIeXRpZ1RKbk9xNDZVODJXUFZO?=
 =?utf-8?B?MkJ5OSt0VUtzckFBaEZ3eVE3UlROZ3VsU0RTSWY3cERBL2lTenBiTUxURjdU?=
 =?utf-8?B?NG9SVjlCTitMZW9ORmtDZlNSTno4L21lM2UyakNTbmEyL0xWbVViWWkvYlda?=
 =?utf-8?B?bHNnTExFWVFobzQySEFNcFZ5OWgwR3dEVDJEck5ZdkdRMGNiWjBKQjE2b1d3?=
 =?utf-8?B?TDRtQWVnTytIbHhLOHJ0cDVhVzRKc2FnU1hqd250ZHJ2Yjg0NFlNUnl3ZFI0?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efa2a7a1-0611-4dcb-ccbe-08dc26ca60f1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 04:16:23.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViH4NzE7GHc9H8U94lc+jJpoBKX15eLMDgxFN2+UuhvxRcGRHkPfZqGB8dEK95L7P05pXrJIpF0Qd2sLID1CNQ8vmd68wDSFWBBxKoLehoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7956
X-OriginatorOrg: intel.com

Hi Maciej,

The subject mentions "helpers" (plural) that may not be accurate
anymore.

On 2/5/2024 4:08 AM, Maciej Wieczor-Retman wrote:
> The CAT non-contiguous selftests have to read the file responsible for
> reporting support of non-contiguous CBMs in kernel (resctrl). Then the
> test compares if that information matches what is reported by CPUID
> output.
> 
> Add a generic helper function to read an unsigned number from a file in
> /sys/fs/resctrl/info/<RESOURCE>/<FILE>.

The "a file in" above can be dropped or it should read "from a file in
/sys/fs/resctrl/info/<RESOURCE>".

> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v4:
> - Rewrite function comment.
> - Redo ksft_perror() as ksft_print_msg(). (Reinette)
> 
> Changelog v3:
> - Rewrite patch message.
> - Add documentation and rewrote the function. (Reinette)
> 
> Changelog v2:
> - Add this patch.
> 
>  tools/testing/selftests/resctrl/resctrl.h   |  1 +
>  tools/testing/selftests/resctrl/resctrlfs.c | 36 +++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index a1462029998e..5116ea082d03 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -162,6 +162,7 @@ unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
>  int get_full_cbm(const char *cache_type, unsigned long *mask);
>  int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
> +int resource_info_unsigned_get(const char *resource, const char *filename, unsigned int *val);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>  int signal_handler_register(void);
>  void signal_handler_unregister(void);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 5750662cce57..e0fbc46a917a 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -249,6 +249,42 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
>  	return 0;
>  }
>  
> +/**

Apologies for not being clear in my previous comment. I do not
think we want to start exposing resctrl selftest comments to the
kernel-doc tool using this change. The tests are using kernel-doc
style but this is done outside from the kernel-doc tool's view.

> + * resource_info_unsigned_get - Read an unsigned value from
> + * /sys/fs/resctrl/info/RESOURCE/FILENAME
> + * @resource:	Resource name that matches directory name in
> + *		/sys/fs/resctrl/info
> + * @filename:	File in /sys/fs/resctrl/info/@resource
> + * @val:	Contains read value on success.
> + *
> + * Return: = 0 on success, < 0 on failure. On success the read
> + * value is saved into the @val.

It can just be "saved into @val"

> + */
> +int resource_info_unsigned_get(const char *resource, const char *filename,
> +			       unsigned int *val)
> +{
> +	char file_path[PATH_MAX];
> +	FILE *fp;
> +
> +	snprintf(file_path, sizeof(file_path), "%s/%s/%s", INFO_PATH, resource,
> +		 filename);
> +
> +	fp = fopen(file_path, "r");
> +	if (!fp) {
> +		ksft_print_msg("Error in opening %s\n: %m\n", file_path);
> +		return -1;
> +	}

Apart from Ilpo's comment this can also just be "Error opening %s: ..."

> +
> +	if (fscanf(fp, "%u", val) <= 0) {
> +		ksft_print_msg("Could not get contents of %s\n: %m\n", file_path);
> +		fclose(fp);
> +		return -1;
> +	}
> +
> +	fclose(fp);
> +	return 0;
> +}
> +
>  /*
>   * create_bit_mask- Create bit mask from start, len pair
>   * @start:	LSB of the mask


Reinette


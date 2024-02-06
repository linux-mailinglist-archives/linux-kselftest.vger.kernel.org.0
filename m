Return-Path: <linux-kselftest+bounces-4177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083E184AD5F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 05:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAB81C23389
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 04:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ED8745F4;
	Tue,  6 Feb 2024 04:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFUQ89E/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC2745FA;
	Tue,  6 Feb 2024 04:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193075; cv=fail; b=n46AWrMWDtg9fvC36IauqXtKczLJ8fqaEMxs5v7qUdlIj6jbsOvcWtUWxWOchsBx4vRZsFq16eSOpW9qv5L5kOqiAjqA1TrQaiBz9zQMy3dJ1ljCAv/U7z+IY+YufkafO1Z/SKL5nzMAAEGOuBYP2mzCDOHmKoDYnqZSvFVbzwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193075; c=relaxed/simple;
	bh=BQj6P0pih2bG6o//aUqktZNfNkkf8oErVTR9wm2MAOE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KdbbKHWLcr5Bh/hNsmDTJ7+EKb677xc516c1fXWJtXTkWSszASbMbOT2xHDZkeDRmkzm0Wp2ZjMinL3GPwHY9rgHYbTB5uWOhIJTD4UNQMl4xLQxHGHyPK1odCF5QRUFUcCsw3LCRt06Qpdjn5/h2t2Tlyrp6ycw94HPQp5X/oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFUQ89E/; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707193073; x=1738729073;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BQj6P0pih2bG6o//aUqktZNfNkkf8oErVTR9wm2MAOE=;
  b=oFUQ89E/S5xbD6cgMw+QChBDQ99Q1i6VMaTxqN24RjMoKuTmH5xVXXjG
   NFZ3Jl8n3tV92FcWd76FaAiMI36fEKb33ZHJArIyyLCmBervtuaRja3IX
   9wS0OE2YONGykMJMfSe43NG6oFnOPKnRs5nmfH7ayCYI1QqmZ4oRhr4ET
   bOKZYafnYtKu2BP8nZSWQE2cAwtNHknpmMvO+/UA6RkL6+g8Jt+YmKzm+
   jRrNFvZ5pzENGAHcgkJmJPT73PUTxz3hyDg+fdqcRDdIOqkIp4VlcNu4i
   f2y3BkqSdU0x0KnPNJDGf8n67Npa4eufmaVv0LgilYVosL0x5MEXuH43W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11308802"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="11308802"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 20:17:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="923595"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 20:17:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 20:17:51 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 20:17:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 20:17:51 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 20:17:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4SXaLd6LwbubknEesIOx84UM765FMx8sF2AaGWzIKoCzjft24MkYjdYES/Qo0STF9Ijg7aTxstRxmmjx1QzFFTqhco7dKFQTmGQC+5nBLOGzJPxUtYmtPUVPyJKugm+QP57rIGTX/BVwLAyuVy/Q3chWU5x6brjunYLwFws8eXV/ynf73uP/i2Z80tYdHI4xN+zW4D4t/1QdFgA6rHWj2IWfmre7y8kK3odEH6F1ObK3ATndbwBWqsJdnMDbcibCqalnMUrzjF9TpeTm4bzf9AqNykEPXOxJ9S6foqdUbjTaHYti6hy1EqVZv5/QDVVCd/7Ll5BBUKsi3Ek94dTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2UAK+S25ICf/i/hO/dPzubKiSEMMrBt5XxLiYNgs9M=;
 b=FvNysOWUq2Z5yykQCccJ88bvwEEEKhR2yYPefzhZpJ8RbshZDNxtPAo49YfJZ/rixgIGwXrtD+Y30VpUpsZTvjAVVSqCCZzI+ryWZJzHLGn8uOfA/ylOtL+7GBw5dCNv1XNVsBN+4os1VdNyOXlHzom2uU9j+jD2NxIOhfmE6mjhx65en+QBfiKnB2Gqk7FiqdqhCp4cDxhQ1Zk6wHasoYTPyPHus9z88oDwRnCjYeMdzlwm/73+72JGATIQA1HVbbiYd3uIPURuzMYMqnXrC0HtSgAwtQO/KzTwwva9ZN/XpCmkKJrJFvRjT8uH422jrqCjzYrxJiOcEn+kFF3K/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7956.namprd11.prod.outlook.com (2603:10b6:208:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 04:17:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 04:17:49 +0000
Message-ID: <17fd1cd7-6b52-4c5a-af6d-2a2c0973cc58@intel.com>
Date: Mon, 5 Feb 2024 20:17:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] selftests/resctrl: Add resource_info_file_exists()
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
 <9c38bb317d4246182f87e376926b61adbb7e20fd.1707130307.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9c38bb317d4246182f87e376926b61adbb7e20fd.1707130307.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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
X-MS-Office365-Filtering-Correlation-Id: 9956c20f-ae5c-4616-8583-08dc26ca9422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pPl6k1f+lGHdQljckub4mreAc8dA4QaOjckSJZ+HcwjJEhVkR5kUAXbEQgcgxVhLnoQRr4JQef6pihWzRv79veirppLw6aHTq9h18LuGMcJC2OtJuamUQaVgbMrdA2CJ6axt/XesTd1oSSeb6ILL2EgJuWn82Mc935EazmZvkyAP1KN66DknDsLKmG+H6A1M0uHQWevhzSfqAg/yTIVpMlVbobVm6yU6MbgNQmh7c2l2SwZ58PJwLDVrOiBtFnWI+Yiu6zSwuV6AxbMxuwJ0w4t63TvDQOMCNxUFs2cc8WY9Hq13hqlcul3fc2lS+M4yi2mkv/BlZNFK4mbCnmWvrcs1Wsa7WdKIrHiXBH5YQ+2u83YoamrFmBb5UvzGK5gA6jb/5+pDW4flJk/lmHIORZ0fvi2TEubIXohmZ7wSgT3Pd+9mK7g5rC2VNy28wWFqAQxyTZEYqxx0Rrx+ppXnAvHx/4mWFz5AXnXRht2jqGPCpfVvVFRYf22UnqHKG3gbPm/I0MLBGuItsC3Xn6A+mo+bKH1iJDnLmedpdy4dVyOUJyRoYYxrGI6jlULDx6x2hIzwyxHDOA2GdxPoBKPenlQ1mN4NetXXpiIzoxF6KoT1adkzQ+0LoR8L5Iv59gf5FPANErlxr307I2HUtD6jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(53546011)(6506007)(6486002)(478600001)(66574015)(26005)(83380400001)(6512007)(2616005)(5660300002)(44832011)(2906002)(66946007)(66476007)(66556008)(316002)(38100700002)(4326008)(8936002)(8676002)(82960400001)(31686004)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJXWVpFcldFUmwrQ3FlODI1TFF1TGhqMElSKzRBZXdIbjJoQjhCcW50U2pk?=
 =?utf-8?B?SlNCZkc2elZ6blJPVUlyNHVnUm1vN2k3dmtIbjgzeGtNUlRXZVk4ZSs4enNX?=
 =?utf-8?B?UmRWV2l2b0pudXdUbFB4bUtYYVVkekVIcE5JSk1lWVA2eWk4ZDNhUmc3WVNC?=
 =?utf-8?B?Y0RzVFBuOCs4L0txd21uUGZnbkpRWGVNTUx4NFRZVXczZzhJaXVVTTVBSWMr?=
 =?utf-8?B?RVZwdGlXaGhSSGlCYUowTzZ3VmdnK3c3UU5maHRoa0ZpRUM1RGRiZ0FpWitL?=
 =?utf-8?B?dUZ2Vi9PZkFvSmZUTzNhWnZjbTlQZ09qTUczaWo0SXhZVCtrL3VINHNIU3J3?=
 =?utf-8?B?K0JVcEhPZ1hWRFpCZHhTL0lMVmVEOWpKa2VjVGl3aDcycy9Gckphc2paM1Vx?=
 =?utf-8?B?ZHVuNkl3anFROHl6YVIzeHovZzMxOFRwQkZQYzRtUUlkc0hDTEtNWmRoOWZ6?=
 =?utf-8?B?WnZ1dTRMTTdmeEhQcEhkd0lwcGJ2cEdmRFdYYVVmcGpESHZGaElmS3dmK3A1?=
 =?utf-8?B?TGdDYm9OUkRQWE5zK0YrVmJLUnQ2WEUxQXNrTFRPWS9CY3l6OUdHRDEzdjg4?=
 =?utf-8?B?MVVhMUVzeUhteVdtYVI4YUpxYjcwV3A5akhSUjdkZTVBL1pRSXIyWEp1MkFK?=
 =?utf-8?B?cU4xdXdYR2Zpd2k4NGE1Yk1kMGZ5c0ZEc2tyY3ljTFVHWWVjVE1pYnRNWUdv?=
 =?utf-8?B?bmViMXJJZVF4ZFZnbXZmWTQzbllrYjkyY3NJbzZzK29pMGlhTk1aUDZhTVFh?=
 =?utf-8?B?VU81SkxGa2w4YTk4OW5QeUZNWXpaRVphQkJ4SGI0bkJMRTMxS2RkRmVuL0xm?=
 =?utf-8?B?OGFsQU1hY29XNW5tcGUwQ1NRUHFySnA1SUp3b2tLMzJMUUo2S1RPZlJIVTJs?=
 =?utf-8?B?bG5lWUdiM0xHQkJUTU5GQ1NVMDFKZU9XLzdwN28rbzVKREVEOHpUYVN6VDRa?=
 =?utf-8?B?MUFkN1U1eU11SmdIQkpldmZUYTVBMnBvUHdoTjJwbngrVTB2TWlReThlT3FU?=
 =?utf-8?B?RmJVZ0l5Wm9FREp3WUY1YVZleEpQYXZFeUV6WmtDR1JQNTFjMENnVzNXT0Zq?=
 =?utf-8?B?Y0lFZjNMS25YaGwyN2gvcGp5Z3lWZnZFU1JMejNKYTI3UEJZaHFHb0lBa3Rq?=
 =?utf-8?B?WUhMaVpucmlCWm9VejZhUmo4T2hjc2p1SVhKazNHeVl2STluaGpPcTc0Yis1?=
 =?utf-8?B?QXp1MjVRejNqaUhMMXhSaDBFN0QxU2pRZ3FpUXErVHlORmJDT2p3Y2RZclBQ?=
 =?utf-8?B?TXRJSE14R1NweVlvNXp0VzI1L1c3UHgyWGdsTTJESlpBSTVRbmIxRkloSW0y?=
 =?utf-8?B?RVFuelhLWnc5MDV4V3ZDaDhhajlma21OODhoY1ozVnl5TDNUVkNIQ0szMm4r?=
 =?utf-8?B?S29nZUNIdmdiV3RrRGdKTEc4WmQxcGVKUFhTN3gzdm1lOTdaTnI3bWk2UmF2?=
 =?utf-8?B?blFtS0pPNG15MkNFSTJsMGxlRzBhLzQraDdBMTR5N3ovWG11S25JQzFBYTlM?=
 =?utf-8?B?dnNMT0NDcTcxT0pKV2Uwd2JlTnRTbGNqbC9oMDdBRHVLcEpqK3BWZ2hvQXZn?=
 =?utf-8?B?T0ovYS96bkJhQkQrUTVMN1hmRVVhYkE1eXFzM1J0OWU5RkNFZk5sVmdJQk9j?=
 =?utf-8?B?citCVGVDSlg4T2N6OG84UEFzSXVnWUtwOStPUTZrdk9BT20yb0lEVlF3WVJj?=
 =?utf-8?B?U21LOUtZNFpVL25CRzN2N1doSzhKT3I3dEg0bnZCc2h4Vk50blkyOG9PY1Bj?=
 =?utf-8?B?c25ycHl1L2JySUpyc2lQcklocHFscFpuZ0RIaVZlNVlEaFNJdmluekNtMnYv?=
 =?utf-8?B?RTRwaFRweit4WGxBbE1yZC90RlQ1TGdEaHpqbktXNnVLTStpbnkycG5QVTNN?=
 =?utf-8?B?WEJGWGZTRkhiK2NIT0hsZmFCRlNLaFBrNmltZkt2N0FxdGdoRUxDN0xHSXNM?=
 =?utf-8?B?OUNteWphM2lHejJYeW16ekhUaFFRNExFWVlxN1drUDhyTEpKejBXRnE4LzV0?=
 =?utf-8?B?dnlMbVdmZWJadW1uZm13WGdjWk40MFUvcnQrRE9ZRkdqRVBORGJ5eEsxeklS?=
 =?utf-8?B?YlRsei90NXJwekJtNitwZy9kWDZiMTFlcGpvSFZjalV5MTNURllia1R2OTMv?=
 =?utf-8?B?M0hmeUZ6RGN6U05YS2hrZjJycEhsZVlPQnRjUmx2WElPcS8xMXBjK2UyWktZ?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9956c20f-ae5c-4616-8583-08dc26ca9422
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 04:17:49.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tmx0ucI2Wvf6GqHwThii54BEPDsZuP6MCwpNgZ3dioYf6WfpeY3ShdScEjxJjPabqEAouRi0IyAhpqO1Lu20T8EkZvGUy81tOMBpQnANcLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7956
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/5/2024 4:08 AM, Maciej Wieczor-Retman wrote:
> Feature checking done by resctrl_mon_feature_exists() covers features
> represented by the feature name presence inside the 'mon_features' file
> in /sys/fs/resctrl/info/L3_MON directory. There exists a different way
> to represent feature support and that is by the presence of 0 or 1 in a
> single file in the info/resource directory. In this case the filename
> represents what feature support is being indicated.
> 
> Add a generic function to check file presence in the
> /sys/fs/resctrl/info/<RESOURCE> directory.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> Changelog v4:
> - Remove unnecessary new lines.
> - Change 'feature' -> 'file' to keep things generic. (Reinette)
> - Add Ilpo's reviewed-by tag.
> 
> Changelog v3:
> - Split off the new function into this patch. (Reinette)
> 
> Changelog v2:
> - Add this patch.
> 
>  tools/testing/selftests/resctrl/resctrl.h   |  1 +
>  tools/testing/selftests/resctrl/resctrlfs.c | 25 +++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 4603b215b97e..2b9a3d0570c7 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -138,6 +138,7 @@ int umount_resctrlfs(void);
>  int validate_bw_report_request(char *bw_report);
>  bool resctrl_resource_exists(const char *resource);
>  bool resctrl_mon_feature_exists(const char *feature);
> +bool resource_info_file_exists(const char *resource, const char *feature);

One stray "feature" usage.

>  bool test_resource_feature_check(const struct resctrl_test *test);
>  char *fgrep(FILE *inf, const char *str);
>  int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 0cfec8bb23fd..6a3082ca58b5 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -760,6 +760,31 @@ bool resctrl_mon_feature_exists(const char *feature)
>  	return !!res;
>  }
>  
> +/*
> + * resource_info_file_exists - Check if a file is present inside
> + * /sys/fs/resctrl/info/RESOURCE.
> + * @resource:	Required resource (Eg: MB, L3, L2, etc.)
> + * @file:	Required file.
> + *
> + * Return: True if the file exists, else false.

How about "True if /sys/fs/resctrl/info/@resource/@file exists, else false"?

Reinette


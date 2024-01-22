Return-Path: <linux-kselftest+bounces-3349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC61A836D78
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B41F228A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392D9745F8;
	Mon, 22 Jan 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVyGfMme"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A8D745E1;
	Mon, 22 Jan 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941167; cv=fail; b=SSLT1teeOowUqMg1av48KS68BMvPjyK63zb/Lw3QV5uTBDPD2BsllDUDRsEaiiQ4C1nb68Cbe1ojNCqXRDW+mXn/Tt096WsEtilhEBzCGvcXGeBkuRhdks3uBMzFPScvMQkRFE795rQdznU9KZatuVg5kevyHEwTp220YTF9i1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941167; c=relaxed/simple;
	bh=XSxp1U/KYUT9qgd7Yf0TfW7GI9rebpxY6bxjnA8EjXE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WyPWFUz8UV0CBd0UNZmTfPLmmuP7h4W+FvUnYL7NZpO+s+pxJBWqwpndXJDfVl6K2L5O6crTJmGazJa5ua0KcPp7p5QSwYbNgkxWjEFTBnqMuCOqCMP/hxRQeMTROFOXe48R5IF+Q5Urh6LoE2puom/O+ZxWhv6i7qRatd+Ji2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVyGfMme; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705941165; x=1737477165;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XSxp1U/KYUT9qgd7Yf0TfW7GI9rebpxY6bxjnA8EjXE=;
  b=DVyGfMmexTPjRwKmZ0UDtF+r/U7jfGyqEONWAjz5WTPVcDFFJ9Fr11sU
   b5cc3Z6JO7uM41xadZHxpkFoTTy3xzu/MrEjiH5Iezn960qNVxHaGn2MH
   loDH+yXMPWD9+KUZ6njBR/0m8pM7ubktIHtdsJi+WE119RdkApOVnPFCj
   4ReHSlqeX0Aji2eeiyH4RfjxgaubCF/hKnNfH4lhcLfB9rmgWWqTEOCSx
   5PAtWe2d6O+iv3ojcfb0wGaFd2uX4NNEMkX4zqdH2Axk1SnKMrTIGBmIl
   QCkrNMiB5TMhBx6FQ0O8TC7JRsVKp1DXGq9d/eYHMY0ldMPObGC/tVWwS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="405006464"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="405006464"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 08:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1253592"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 08:32:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 08:32:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 08:32:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 08:32:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTAjncByCqNosN4BCzguNIFfvF5u9Wemxh/XCFoL56RbMzRVTirfdUNPayalTxoN3B/R8CFm1KuYPHFJTVv7PCJVwVe8v48ACXJpD0aF4AbI42oWrmgCRiyMmaRa4/JblpEWeJrFVB2bfmi5PSvFybUDX4Ouy1umFiJ994g4w27P3nck8wGaXP/MmrtTKILx/6eBdiSQo8G8tI0iDsjYPAvG1NvQGjsb66oUUiSusCAIQRxtEdcU1lbJUqq1fDsrtSEaXIw4e+7BmYn95sgp0uBjGS6qUr6NEH2tsXig9BZZAbVa36nVfLQV8v7gp/+aMwhqSKrkGh+iLbfF8m5CUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeGQClbv1vkXDHwOCgwAW0pak7mt0d1qwJNqfOnTRpE=;
 b=VoZAc4An7gw2rhCtz3nXaFCC/sOhNgM+lCs+f2eYtvB+Ti+TB6sSnYUzHQ0S//rT0mj/+HxpDLh1C8uOESw3Z+9rs1D3rnDK0C1FFpams0kVwE/Myw6L7czZf1gLwMhi1p+exct9MUX/d5a48qvP3T6OR9J6FwJBIlDA3EUXjRAe5HcHrZNLxTB77HCZUbEj99eFbxWrM+n4lEz5h3B7uPnWDd9XWnD8hhYKT9SO36xmujovkczW+lund7+xd1G5t9pXPUL0tAYn/jXolzzwdbWubK7aGj9hZuPIk1jmfNL4cdAoii40YhqUiAHGg/HhK3D8PWZS7KPHSO4MYsXlsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7382.namprd11.prod.outlook.com (2603:10b6:8:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 16:32:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 16:32:38 +0000
Message-ID: <227e43a1-a11a-4d49-8dde-c8b65527e926@intel.com>
Date: Mon, 22 Jan 2024 08:32:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
To: =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
 <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
 <6v4hgra7bd5nwubcgtbsidmoohrgxdw7no4faa4a54g4vrxo63@c6qnujvwn5ej>
 <73cea732-3757-4aec-a39c-4f0e50f6fb70@intel.com>
 <su2d6i22icynusoykmowfnzery6hlqugovaw4xcrhb7r3ymbx2@aeimvrxsc5xw>
 <05db3bdc-9d54-44d2-8aae-07d66053892e@intel.com>
 <wvehk3j2dcf3lkuantb7shefymxj2mnzv4pgbiqbk4jkmmzeid@lurk3dam5tb6>
 <92bccaea-b73f-42e0-a386-1a73eb6f88de@intel.com>
 <m3bhu3j3jzdo67mmuezjmwu4elyqjdwmoixcxm7qthls5tueqk@h7bvwxmy3l4y>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <m3bhu3j3jzdo67mmuezjmwu4elyqjdwmoixcxm7qthls5tueqk@h7bvwxmy3l4y>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:303:b5::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae46a96-0f4c-4b43-0984-08dc1b67bf28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7aNG6CK4fTOSr0SFUaIJjmMPMulk60RFLD89d0xf5Wk6gYhNb2cvrfFvd54cNwTVMWrUAtdLtCGytrLFvpwkMKxMvvSmUMedgkq8y1GLCIKa24pJoLZr9IdjySKYwRJJsMGPBR20bbBriKGKX5eRPbMalHA4BTfIhxY97MAAhEewYvhBB0ursrPmTdf7RkpCP38IzaCx7Ntd6GdyRC+Bax8XQB9l8EELCmG+rlA/1ds8RcbARdfLxy9jcEHFb8n0IS+zs9YEFgnzn1b48HrduhfTtz34oS7Fe5FDVTxbSFRR93oZbCUMVDhCf1qe6NacTVKxSGkW9XoJtxsAzFeEEFEAzLt/pGqkBUHCmUBH4Uzzf5Z5b2f5zdLTwI2TYpXd07wTZlkh7klxglszKUh1ZdXyP/avyhBKeT0Rj2vlPHwuZJB1o+qm/VuGZd3389PGWPQV82cUzMPbPYK1OE+9NdpTCnxwy24FFioZf3TCARDgADKlizMxnMSs5ilTikcv7AtF2gTbsAxbSIWIDBr5svLofR5bwC3qexyei6ROJPVJ1CznbrEudvJuL3KJWPSra7uh+AKlh9ZdsJGyV7N/K2jeXw5GlylQZ7sJkcqgM/5CM52VG6y+CBLsQ/veAMsgYu9zls2ws6gJhRFVG9uDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(66574015)(31686004)(26005)(36756003)(6506007)(478600001)(53546011)(2616005)(83380400001)(38100700002)(6512007)(82960400001)(316002)(5660300002)(66556008)(37006003)(54906003)(66476007)(66946007)(6636002)(44832011)(86362001)(31696002)(8676002)(8936002)(6486002)(2906002)(4326008)(6862004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVdUVDBETjdqNmNUc3pjVWpJblRSZWNtZEFwUUozQ01PWG9GN2k4bnNZWXZx?=
 =?utf-8?B?cGppSHJuRzBsMTNCbWx2OGVCYnJzZHRXUTl5YzBtcVpzSWRUb2o2ZWV5bWRG?=
 =?utf-8?B?SjFtY1VEVkF3ZmlYYUJzVWNDNVhqWGFQejVJSXpZYnVpR1FIaElEWUV4T3JU?=
 =?utf-8?B?aHY4SXFuVEFrRzhrK3RURWNJT2w1cFZOejBEbkkvL2ZpdVp6NGNxc1ZZSDVn?=
 =?utf-8?B?NUkxVEpyRzNub2REcjhmNldmV2dka2VNdkNlR25YMGlNQ3NXeWhoUUNXODUy?=
 =?utf-8?B?STVPb3BZTTV2MzNPUGUzRU9ZWFArK3NlR2VCdG0vRTllZ0Q0ZWxZcFpXWDdT?=
 =?utf-8?B?dTN2M1dVSzI2NjluRFZGVlhsYnlTdHJDa2RXQWtEaktsdjNRaDBSdkllSXRa?=
 =?utf-8?B?NmU0eEVydXpocjRJdEZMcjhFOXdxdjQwSy9qV3hCVEViVFY0YVdldDFuOEpr?=
 =?utf-8?B?UEE5a3hVR1NySDZNSUlEcnB6cnozVHM3WWZjV3dzUXRzbkp1Q01ETUFYckN3?=
 =?utf-8?B?UHNjaHlrZzFia3BhZm5Ua01JR2RXb2Y4RmtoRzlvKzJPajc2blpTSHg4UnFX?=
 =?utf-8?B?ejNRQ3h3dm4zT05hT0VNVjNzYlNMYXEwQ01OazNzaDRoR2ZNYUhjaHkwaWZU?=
 =?utf-8?B?V3hKTE9tY2RCdEhNWGlWcFZhMFBBWmlpUTMxeG4rVjlmL3p5bEF5cXdrZjJk?=
 =?utf-8?B?RllwMlhnUTh3dWNHMWpqd1NxaXV6VTRLWU5rRXhIcEdYZWJtYzkzbThHMzdT?=
 =?utf-8?B?OUVlamg1SERZM3FMMHd4YTZET0tKTGZRQUE3WnJQN2loR0l2L2Z4U2NXNWJt?=
 =?utf-8?B?YWJHYzV4QUl6VjY2ZXgzRThnU2VjNm5WK1NWZ3NTM1dPdExPbVNMdXNWcEZE?=
 =?utf-8?B?R3NHM3YrMVZEOWI3N3Bxc2xpUDE4YkRTb1AwZ0pmaHFQbWY5enUzSGhzVDNJ?=
 =?utf-8?B?Z1htbHhPRGF6ak5qS0xwY0p2bitVY3dPUlcvcHZuMjBWWldOYmZtRGxQSlRE?=
 =?utf-8?B?eldmVU1qUWFEUStMM2ZHZGllN0prN2FraDF6eUdBZGVJSm1aUUUzT0hsL2xz?=
 =?utf-8?B?RHNUdUllN0JBeEI1VUZrczUxUkVLbFpWWHBMNVg3bzVQL3BET1hGeGtZRHdu?=
 =?utf-8?B?MkF6VVB0MW5uQlNBeU9PaG0wdkNkdlQ5SmdHRDFOa2p5WFBJYWFDZDFwai9j?=
 =?utf-8?B?REdkZUdId01wN0djS1hCcDBSa284NEJVbDRSUDNMb2xINXdyckN2c0hIb0dL?=
 =?utf-8?B?YUY3QUE1WjR6Z3J4OFFXNVVPRzFWaUFvcGVxNk9ieVBVcWROdkQzOW5EcDBt?=
 =?utf-8?B?WTNWaVVrUWFiYnI1SWNiUlg0NW4zd2JKeW01YmEwVXBqT1lvU3RRdG9tVXdv?=
 =?utf-8?B?VDRDT3hJZ3ZBWis5aDQ1TkxodkhpQndHQjRiYlRQeTBxYUVRek5PMFA4ZjdC?=
 =?utf-8?B?L1NHazNKTnAwcFRNQkpRa0taaTBJLys5ekMyNVpUU0MvVDc3YUtwWnVUb3ZW?=
 =?utf-8?B?RHBtZWNObXFiVUpMMEZhRDNSUVlMbVNadGtHL3VGL1p6a3c0NTdlekhSZXo4?=
 =?utf-8?B?ZFhnZDlsSUJYVnpLWWtCa1Z2OVg4V0VxaGpsSVpMVjJkbVZQVlFLQjNGK1Ey?=
 =?utf-8?B?U0R4MmpsSGhRVTd4NTQyUDhpTjdCNGZsNkQ2bXJNYWVnZ0tFOUVzL3UxQkpF?=
 =?utf-8?B?UXJhZ3EvakMxNWlFVEowS0I0T3JRUGlOUkZkUjZjSG5hbFNwbjFNQkdSSEF2?=
 =?utf-8?B?NkZ1SXBvbzlVeWxRcC9rNDBXNzhjOWpGR1FFNnFzZFBobjhxSDIzSnJCcTk2?=
 =?utf-8?B?M21sc3lyWEhOYkZtbDNkWUl1dVVhQityaEU5RGFIcjYxcmFjdWtoUG1VY2ZC?=
 =?utf-8?B?Ull4NjNPWGxlaE9qN0hYZG5GYjFUZ1BDaUNWMHJLRUNiWjZ0L0N1VjZQZzhn?=
 =?utf-8?B?VVBWTVVVeGJOTmY3cTU2dzd0Q1FWMGVZV2I4NDgxeVU5SXA1VUhKQnB0QjRZ?=
 =?utf-8?B?Sk1pcURlcC9KMm41Qk40L2FjbEVqUjV2b3B3bUFwcXUzVUZkTkttSEROVS8x?=
 =?utf-8?B?dnBRRnFHR2FCV1E0eWVYeGMxK01xZkp5OXRGWkhmSGRZWEM5MVh2Rk9YalQz?=
 =?utf-8?B?VTdOWDh4ZU93R2NSb3kzZ1JkRFhrMmFrUWZLdlB5MmZZZ3ZVTFZibS8zbTJt?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae46a96-0f4c-4b43-0984-08dc1b67bf28
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 16:32:38.4462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ln2xD4NhmoR9pj8EU2wR81T73eEk7nPZkoYeWd9mghv+CwIbOjRIBZQN7ixNdORMnLfQk/ZxHtXtFaIUuRBV00Fj2dg6KpqsxVBMvcMdS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7382
X-OriginatorOrg: intel.com

Hi Maciej,

On 1/21/2024 11:56 PM, Maciej Wieczór-Retman wrote:
> Hi!
> 
> On 2024-01-19 at 08:39:31 -0800, Reinette Chatre wrote:
>> Hi Maciej,
>>
>> On 1/18/2024 11:37 PM, Maciej Wieczór-Retman wrote:
>>> On 2024-01-18 at 09:15:46 -0800, Reinette Chatre wrote:
>>>> On 1/18/2024 4:02 AM, Maciej Wieczór-Retman wrote:
>>>>> On 2024-01-17 at 10:49:06 -0800, Reinette Chatre wrote:
>>>>>> On 1/17/2024 12:26 AM, Maciej Wieczór-Retman wrote:
>>>>>>> On 2024-01-08 at 14:42:11 -0800, Reinette Chatre wrote:
>>>>>>>> On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>>>>
>>>>>>>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>>>>>>>> +	cont_mask = full_cache_mask >> bit_center;
>>>>>>>>> +
>>>>>>>>> +	/* Contiguous mask write check. */
>>>>>>>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>>>>>>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>>>>>>>> +	if (ret)
>>>>>>>>> +		return ret;
>>>>>>>>
>>>>>>>> How will user know what failed? I am seeing this single test exercise a few scenarios
>>>>>>>> and it is not obvious to me if the issue will be clear if this test,
>>>>>>>> noncont_cat_run_test(), fails.
>>>>>>>
>>>>>>> write_schemata() either succeeds with '0' or errors out with a negative value. If
>>>>>>> the contiguous mask write fails, write_schemata should print out what was wrong
>>>>>>> and I believe that the test will report an error rather than failure.
>>>>>>
>>>>>> Right. I am trying to understand whether the user will be able to decipher what failed
>>>>>> in case there is an error. Seems like in this case the user is expected to look at the
>>>>>> source code of the test to understand what the test was trying to do at the time it
>>>>>> encountered the failure. In this case user may be "lucky" that this test only has
>>>>>> one write_schemata() call _not_ followed by a ksft_print_msg() so user can use that
>>>>>> reasoning to figure out which write_schemata() failed to further dig what test was
>>>>>> trying to do. 
>>>>>
>>>>> When a write_schemata() is executed the string that is being written gets
>>>>> printed. If there are multiple calls in a single tests and one fails I'd imagine
>>>>> it would be easy for the user to figure out which one failed.
>>>>
>>>> It would be easy for the user the figure out if (a) it is obvious to the user
>>>> what schema a particular write_schema() call attempted to write and (b) all the
>>>> write_schema() calls attempt to write different schema.
>>>
>>> Okay, your comment made me wonder if on error the schemata still is printed. I
>>> double checked in the code and whether write_schemata() fails or not it has a
>>> goto path where before returning it will print out the schema. So I believe that
>>> satisfies your (a) condition.
>>
>> Let me try with an example.
>> Scenario 1:
>> The test has the following code:
>> 	...
>> 	write_schemata(..., "0xfff", ...);
>> 	...
>> 	write_schemata(..., "0xf0f", ...);
>> 	...
>>
>> Scenario 2:
>> The test has the following code:
>> 	...
>> 	write_schemata(..., schemata, ...);
>> 	...
>> 	write_schemata(..., schemata, ...);
>> 	...
>>
>> Any failure of write_schemata() in scenario 1 will be easy to trace. As you
>> state, write_schemata() prints the schemata attempted and it will thus be
>> easy to look at the code to see which write_schemata() call failed since it
>> is obvious from the code which schemata was attempted.
>> A failure of one of the write_schemata() in scenario 2 will not be as easy
>> to trace since the user first needs to determine what the value of "schemata"
>> is at each call and that may depend on the platform, bit shifting done in test,
>> and state of system state at time of test.
> 
> Doing things similar to scenario 1 would be great from a debugging perspective
> but since the masks can have different sizes putting literals there seems
> impossible.
> 
> Maybe the code could be improved by putting an example CBM in the comment above
> a write_schemata() call? "For a 12 bit maximum CBM value, the contiguous
> schemata will look like '0x3f'" and "For a 12 bit maximum CBM value, the
> non-contiguous schemata will look like '0xf0f'"
> 
> This seems like the closest I could get to what you're
> showing in scenario 1 (which I assume would be the best).

I am not asking you to use literals. I am trying to demonstrate that the only way
it would be obvious to the user where a failure is is when the test uses literals.
I continue to try to motivate for clear indication to user/developer what failed
when this test failed ... this could just be a ksft_print_msg() when the
write_schemata() call we are talking about fails.

> 
>>> As for (b) depends on what you meant. Other tests that run more than one
>>> write_schemata() use different ones every time (CAT, MBM, MBA). Do you suggest
>>> that the non-contiguous test should attempt more schematas? For example shift
>>> the bit hole from one side to the other? I assumed one CBM with a centered bit
>>> hole would be enough to check if non-contiguous CBM feature works properly and
>>> more CBMs would be redundant.
>>
>> Let me try with an example.
>> Scenario 1:
>> The test has the following code:
>> 	...
>> 	write_schemata(..., "0xfff", ...);
>> 	...
>> 	write_schemata(..., "0xf0f", ...);
>> 	...
>>
>> Scenario 2:
>> The test has the following code:
>> 	...
>> 	write_schemata(..., "0xfff", ...);
>> 	...
>> 	write_schemata(..., "0xfff", ...);
>> 	...
>>
>> A failure of either write_schemata() in scenario 1 will be easy to trace since 
>> the schemata attempted is different in each case. The schemata printed by the
>> write_schemata() error message can thus easily be connected to the specific
>> write_schemata() call.
>> A failure of either write_schemata() in scenario 2 is not so obvious since they
>> both attempted the same schemata so the error message printed by write_schemata()
>> could belong to either. 
> 
> I believe my code follows the first scenario example (since one schemata is half
> the full CBM, and the other one is the full CBM with a hole in the middle).

I know. This thread digressed into discussion about when it would be ok to
omit error message from caller of write_schemata().

> I'm sorry to drag this thread out but I want to be sure if I'm right or are you
> suggesting something and I missed it?

Please just add a ksft_print_msg() to noncont_cat_run_test() when this
write_schemata() fails.

Reinette



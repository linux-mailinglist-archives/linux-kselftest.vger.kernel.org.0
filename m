Return-Path: <linux-kselftest+bounces-16275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75195F26C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 15:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6871F22005
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B95155314;
	Mon, 26 Aug 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYf2tnWm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899DE17ADFF;
	Mon, 26 Aug 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677778; cv=fail; b=MywaQU2N1FNDoURKSlBFdLPiPahm5hl+u4nvJn/iuDQVBSj6FISYg1Poob7jwgfM9Fo0o78nxu4wzKwX6EOqw+CulBqZH66YN8oOx1yTcZAh0c1EHI72I3wkAu2UipXQGNnugsd/sX5+hq1RIjks60WnhlV3TbTxGPneTL+CLQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677778; c=relaxed/simple;
	bh=N6+Ey91hvoF7qUcLpLhVasQiLI+BJHysEfJnMUzqIaQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=erEHQzfkrRAyr6DyT14D+f4KtonE+8DMIfMzhov5aJvlanD6+8T0xAPgDukoJ5ducI8nXIea2FBxX+Seuf8VO8tg+vfQ45AiBXV3xrhs/YNhNqfMt6iLXa+SL8zvRaFkK76UQwrQzsiLuCYefYC7WJfcEdRxnc/VD7aCishdETc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYf2tnWm; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724677777; x=1756213777;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N6+Ey91hvoF7qUcLpLhVasQiLI+BJHysEfJnMUzqIaQ=;
  b=JYf2tnWm4wdegduKfrw9H5jyImtChyLG43ERokddZ5V4R1268K+gGeSJ
   wyiN0xormTGcPfoiplU6OGwamh5ExRay0I3WIck/qhn6KCBFmzMi3wiVo
   4PYbXjscYHlSUer0Ir/ZtTiqPpkDaWlrEURmYYOCYoaMUaChVL84Pw3kF
   txT8NHvgTi8n2tm8+L2dBBbe5394B0mWoVynf8UFQrD9Q20tgmwBt6Ii/
   pLfKdENZFGrpuB5buHyTKzC6GmulOBsiwErOcQOgXHmti3PFw5fDFmBaP
   kPwiGyS3/5YiIKoNJs8sFfr5PFxSPSPI+EZXqoFO7xmIAOXsuezhJ6qlR
   w==;
X-CSE-ConnectionGUID: wJqTSVD8RZ6yo4R4kStBYg==
X-CSE-MsgGUID: Fz32YW49RAySkyjWJ7H+JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33668052"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33668052"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 06:09:36 -0700
X-CSE-ConnectionGUID: ZIX4+MmiQjGWNBrSgs26xA==
X-CSE-MsgGUID: X+lR/iWdTsms9sR/6c2DTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62659314"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 06:09:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 06:09:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 06:09:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 06:09:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdMTxmG4RK4uds9GslSQFc+OhGEEngsdMPVdg0rj89OJcJfcPlOy/gqFyOyDwxpEySX95s+Rm18g69VmdK0LbC4RReAYZzpnOihep6FImNzq3Rho5GoegJbqm88alUCBOiq9LCEsg+PH4KfKRXDAkFsD+jjnLImhVYbhgMBxhPZwnXhNvDWNbGLXDRRdA0fmWwO5Q04d9dw8YpeQlxYvybIADD04w5UOjdGmG6/K2arFSTf85qHlpu/ynM/F1PqMGbhA/Nl/rfcNE7FjSXLL+I2gvnCegvTV2px8HjC4dcdK7u7qqLYSkFLexaphdFKIY5sM0SInyHA0rmZ1cxfmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRpnxDz8ISZZaj4RTvTwIltU3KhvV6sB/DV9R3A32Mw=;
 b=rD0U9YHfXUXvDAO/9HF+zvYVAI0yPgC50ICkPuwmH2+hIMqqtHkZqN+sAp8I739E6K/qDbbB/wHmK/ca+CNFewhEmXfkMQUQYE6rlmvXGHLLcQHnGvYzioYk8cckD6B6ECwAxGp1CPhBwtru1yHYGF0Ikhd9/evgTnuoU67GpGj3NtuJDkfxiVxO7Atx+fLdbKPNf4DnNiEB/i/t+7tONjF2Yif5MdI/FWUasc0ayI56W5UXlPHFe9RhbwWT0eBCDcswyGEcj7qTg2DVKniTicEjZ4gNKQRqbkeTa1yps+MacnJfU/pemG2fsQYpNMdC13qFbwDbC0yWWm3rqXFfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA3PR11MB7434.namprd11.prod.outlook.com (2603:10b6:806:306::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 26 Aug
 2024 13:09:31 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 13:09:29 +0000
Message-ID: <05b9caf6-ecf5-48a2-ab65-509b0d5b5fb0@intel.com>
Date: Mon, 26 Aug 2024 15:09:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 1/5] selftests: forwarding: Introduce
 deferred commands
To: Petr Machata <petrm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Hangbin
 Liu" <liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<mlxsw@nvidia.com>
References: <cover.1724324945.git.petrm@nvidia.com>
 <d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::41) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA3PR11MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: bd21eeea-1cfa-4958-4644-08dcc5d051b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkUwbk1wZEEweTNGN0E1VUVlVGpqam95WU1LdmlRTWp5dENydzBjRTdJS1RM?=
 =?utf-8?B?TDluWTZoZ2lNNnk4Q1JscnNQOWozRG9jckZad3ZqRkxGMU5lVTRpMFc2WlI0?=
 =?utf-8?B?U2VqajlUU1djTDZiamgwTS84NkZ2YkR5MWVEbU1nakZ2RE9lc1RBQVppanFz?=
 =?utf-8?B?c0RqcUJEeUlkQVMxS1FSVElUWHozVjZjL25GbG1Oem5rc0FvZ01WNWVPRlF1?=
 =?utf-8?B?NXYwdXpMU0VTVDA2UWdXdVF3Q3dwdlZrUGRSUjZPOFRFV2c0RVlFWlkyelU2?=
 =?utf-8?B?dFJTb0RtR2p2U1pnK2hOcjRTaFBVTXByNmF0ckJVbEZFR2Fac1piU3d2c2RB?=
 =?utf-8?B?WFBOemNvVitXSXlFRi90NVE0ajRvb0tHbGFXRGpudFFhVjUxbjZUU3RTWlRB?=
 =?utf-8?B?ZGJadnBMSXY1ZU9mRnJKUGxSR3NxUDBLQ1kxSFVQdHZDVDVnN004d0pnT3Q0?=
 =?utf-8?B?dmp0eThQQXhENWtsWmtsWEp6NklRM0ZqR1hCYmhOdW1yMnFKUWoyRjBkNmI0?=
 =?utf-8?B?VjY5WkM4OUt0am1NZnJFb3RTZTYwR012cGNiZmRFYkd0bTd5clM0TWtjL1Ay?=
 =?utf-8?B?ZEt6VWp1MXRvMldyZlh3aXp1d0pZUUpJSEppbkdUQjJQb25HYnE0em9pNElW?=
 =?utf-8?B?U3hyMmxzVzdaaDhvUEdMTk5kb3plZUhzVDJmRFhhblRsKzhlZFNDZlZGamMr?=
 =?utf-8?B?MEVoSURaYU9xa0tIUjZCYy8vTWZpNmtram9aQUJiS3lrdDd3Q1ExT3YyUy9P?=
 =?utf-8?B?aCthRmdyNzdZVlhlazVKejJGZzJ3TG1LMkVDMHFXY2JGQTFKQnJ0aG1kcXJ0?=
 =?utf-8?B?RWg0c1VqYnliUVRRbVVXY3NCRW1KN00wT2hwK3A3Y09jdE5SYk9HZXFJc1BT?=
 =?utf-8?B?amVxN0VrUHpnSXZpbzZVS3ZyMjZwQlE4YW5sbVlSUTZObUh0ODVzRDJVNThu?=
 =?utf-8?B?M1pKRG9yMTJlNGxRbXh6NzJ4RUM1Z3VCODNwM3U5dFg0NS9aQ0RFK1ByN1ZI?=
 =?utf-8?B?UGZNdXRiRGtlK2s0VG1CbzdSa09hamJhRG1CSXVhT2NtWjdYdlFyRFBsNktQ?=
 =?utf-8?B?K29wZWczRS8wV2t4UVBvUzQ0REJCdmZ4V3BQSkZtbW5MY21zOUl0NmZidlA1?=
 =?utf-8?B?NjlEdDNJY0lXSW9PV3F5aE4wVDFpbE9zYzlua0NiODE0bGtzbjNIcVYxSU9R?=
 =?utf-8?B?ck1yT3hNcTFnLzZvbGpXdUNmVFFWM3BRRDVWbWJEUm1SL2w5R2cxQWZ1emlW?=
 =?utf-8?B?OWcrVmlnMkZSTnhvNi9kbUFWR05kMjdKdlhqZVoxT3RMRXV1S2VIdVhuTm4w?=
 =?utf-8?B?a0dNQmEvZkdGa2N4VEpBZmFCQVduNmpxVnBlTFZxYnRJSkI5YS9jdlV3eGZQ?=
 =?utf-8?B?alJrMUJYWDI3S1ZhWWxBTWJ1dmpoTXhiaVhwUVUyb3Z5RmIrMzdyd3U4NVRW?=
 =?utf-8?B?L2V2d0FNS0lubldadCtybzlPSUVjZnhjSEtTTHlYNWtiNEYxRXpUb2h3UU5l?=
 =?utf-8?B?V3lzMUtXVzNQUkVkbVpVaW5GbUNKZmxTZ3BUc2NBTmw3VWJTZmV5YmdWZXFR?=
 =?utf-8?B?THFQQWd6cUpuMWtMc1htU3AyKzJHTzNaR3lTVTFvSVc3bG5hK1dqM2VHbVE2?=
 =?utf-8?B?UWNXRStmYzBUb3hQaldGWjFJQllxWGJzb0N4RUFoUnBsV0UyRVZpekJ6NXl6?=
 =?utf-8?B?SEVqaUlnVXJyTkQyd3ZJZDJoYjJSMTVKbGp5K1B3TEgvZlFNOVpqeG5DMGt6?=
 =?utf-8?B?N3l5V01pM0FYS1FRVGxDZnpERHRwMCtSaEdub0V6enVKZTJIcnd1L1JaUVJ3?=
 =?utf-8?B?dU02aWxTa0dpbk9kZXVoQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlhHU3FyZFQ4MVRxaWtLdDFGWXBkSjczTC9aaWM2VU1ZOTF6bU1oaWJ2NThE?=
 =?utf-8?B?M0ltaEI0N3ZoYzVtUmtJNk12TWRpcndRVVo0QW9kdlBuWDQyTjJxVWluYjZh?=
 =?utf-8?B?cHJUWjdESFFCeXQ5eHpHelh4N0dwOU5wTTM2bnIvSHVPM3ZxZi9KQ2tZREx0?=
 =?utf-8?B?MWpmRVVDSjB3S210cENDRWZKZG9xdVZDKzEybVRGdzNBOGhrd3drRkhhaWk1?=
 =?utf-8?B?RG9uUkdFNkpCRDl1MDFnbHNqU0d0UnlBYjlhcEdMeDNwelVhSzVXNzF0TG0w?=
 =?utf-8?B?cCtrNWI1cm13VmljZ3NNdnVONmlTYW5xa3VpWFZsdk42MjNlYmZERzRrTUtI?=
 =?utf-8?B?WTgzdHdWL2RZOHZyaktLa3NLOWdOVmcrRUZFLzNkMk13R3FqL294WmFGTjhE?=
 =?utf-8?B?UnV1TWRBbEFQRXVxc1VqQjBzb1h3UjhBTHhJWVQrZENpeHhYVGR2YXYrYmhr?=
 =?utf-8?B?NmQ5RDBJQ0tVQndvZXRqT0xtRmt4eUxuTmMxN2xKL2dRRG1zVDduSGd5Uzhh?=
 =?utf-8?B?VjdIS2Fob2FNYkxFcmdkd2lIeVNjSjhZNk40anJ6UkZwTEYwYmhHTVZuZ2w2?=
 =?utf-8?B?czNCSXNlRXlsSlFidFdjRDNENlhQdi9mYk52TStIbUNBaHJlaUxRNjZhU3hI?=
 =?utf-8?B?ZGFNM1kxTUFRUXJpajcyYUVuWGhMVEtoVllJNkdDeGdVTWpnWnVuUmU2UUN4?=
 =?utf-8?B?dEN6QjQ2c3FOWVJjV29kbGR5WkZPemNwMnlzSHdCdUN3VzhzdjB5cGlIcVc0?=
 =?utf-8?B?SmhmSVdGL2V0L0hqaW80aFJNRlFlZ2xIRUVZcWpyZ3FxQmdFbmQ1cVA4b09N?=
 =?utf-8?B?a2lkSmJlbk5LMS94a0MxelBKblhGKzNWNlFRREI3WG1RWUtJdFlWeW5pbm9S?=
 =?utf-8?B?b0ZIeXhjOVRJNmZUa3BLdzBvakIwMzJLZEVWYjhkRkFROHBLWGtKMTFBUmNr?=
 =?utf-8?B?aDMxblhyM2JmZE1PSjFrR0pnS1Q4TDVnNXRVb2ZXRTBxUkF4UWc2c21wQklM?=
 =?utf-8?B?b3ZkVFdrTDZlZUp4NmgzT0p4dGE3dElLWVJwaDlCNDdCRTQzYkd5WHFadko4?=
 =?utf-8?B?WXJrVTNZdEo5MHFta2UrTUtHWmV2VGdQaXd0SjVWZ2xlV3YrV2xwakx6SlBj?=
 =?utf-8?B?SGllVGFJczdkcWljV1JqdHM1dUhWWlZ1Y28rUTUxM1dlb2RMSnFqNEhQSmZ3?=
 =?utf-8?B?enZiR2Z4cEVYN1BoYm5rV1I2V2hvM1pBa1RXeG1vUWRBUVlwOHRJN280bmQz?=
 =?utf-8?B?WEpWdGlrcllrQzdkMjlyV3NIc1A0S1l2ckJ5eDJEYXhHMDFhSkZBUWRWMlVR?=
 =?utf-8?B?dVZNYkd0VGovRHUxWjB6dVQyc1FpU1psdWh4QXZSblhiMGZJVTZ5bkdGZDVH?=
 =?utf-8?B?UFBWc00valRaaDVSWjNTNzBZZ25pNjRWZWUvcDJHeGQrQ2J2Yi9jdXNqTjZh?=
 =?utf-8?B?OUp2TktrYnFrcHRQeWZ3Sk1oMS85L2UvZXBtNWNWNkZYZHd2MERTN2oxTWRl?=
 =?utf-8?B?MlNVVUt1djNGeW5lNTFxZTJWaEFHd3dvL0RCYUZOTW1ob3BrbnBMVjVRcDVu?=
 =?utf-8?B?YzY1V2dnNWRQLy9RY0Y4LzltdVRmOFplMzhBVU9JRDNCWUlMUFFITUV2VjlN?=
 =?utf-8?B?MGRpMEx3a01BbzljOFBHclc0empnUGx1ZWdOeFI2NytRTlhjVzl6K21VSk8w?=
 =?utf-8?B?aUJiQWpqSVo2QW9LcnhOSUt3S0hzMkh5dStmOVVVcEFHZjVBQmZOekxOTCts?=
 =?utf-8?B?Vk1mYm5jc1MyTklEYTkxMUFqaWRKemR5QXFDanlZK1ZRaXJ4ditidmJNNExC?=
 =?utf-8?B?N0dFbmo5aHlBSWxvZmhydHRwRVlpSERSMEZIZ1ZZeWJHK0xkanNZMGxYTnBr?=
 =?utf-8?B?MzdQd0F4MHhYQ3pldjNEYkw4YS9kSHhVeWNtVVA5NmxvMHhBaUV4OWZwSjRK?=
 =?utf-8?B?c2Z1aUFUUDlSOHUyTElHVHNVcy8zanA3ZFhuaHRlaHdQQm9aUWV6U01Jd2NB?=
 =?utf-8?B?UTQ2YUV6L1VCc01XVGlyd0ZUODBoMFJJUGhjZDRnQzZyQ0QrL1hDY3IrUk9B?=
 =?utf-8?B?eUR0Wlh4bWIxeUhpeCtRYVNKeFhHNjNlZ3FpZGt5TUJrS05FeEI1RHJRZWU0?=
 =?utf-8?B?bC9iQ0RJZ09rM0Q2TUpUemh2SHkwK3c4NkhBN2xqZjk2RTNvbDR0bXRWRDhX?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd21eeea-1cfa-4958-4644-08dcc5d051b8
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 13:09:29.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz7ls8Um4HF911kZxl1sDTacWSy6kYd7UIXQQHeSKpLL8vHZNzKhvyTloPQ73Dk/QFxxAmRtzmqXFq9QQlvlEZft9cvclVBfhmvZ9nfKI/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7434
X-OriginatorOrg: intel.com

On 8/22/24 15:49, Petr Machata wrote:
> In commit 8510801a9dbd ("selftests: drv-net: add ability to schedule
> cleanup with defer()"), a defer helper was added to Python selftests.
> The idea is to keep cleanup commands close to their dirtying counterparts,
> thereby making it more transparent what is cleaning up what, making it
> harder to miss a cleanup, and make the whole cleanup business exception
> safe. All these benefits are applicable to bash as well, exception safety
> can be interpreted in terms of safety vs. a SIGINT.
> 
> This patch therefore introduces a framework of several helpers that serve
> to schedule cleanups in bash selftests:

Thank you for working on that, it would be great to have such
improvement for bash scripts in general, not limited to kselftests!

>   tools/testing/selftests/net/forwarding/lib.sh | 83 +++++++++++++++++++

Make it a new file in more generic location, add a comment section with
some examples and write down any assumptions there, perhaps defer.sh?

> - defer_scope_push(), defer_scope_pop(): Deferred statements can be batched >    together in scopes. When a scope is popped, the deferred commands
>    schoduled in that scope are executed in the order opposite to order of
>    their scheduling.

tldr of this sub-comment at the end

such API could be used in two variants:

1)
function test_executor1() {
	for t in tests; do
		defer_scope_push()
		exec_test1 $t
		defer_scope_pop()
	done
}

2)
function test_executor2() {
	for t in tests; do
		exec_test2 $t
	done
}
function exec_test2() {
	defer_scope_push()
	do_stuff "$@"
	defer_scope_pop()
}

That fractals down in the same way for "subtests", or some special stuff
like "make a zip" sub/task that will be used. And it could be misused as
a mix of the two variants.
I believe that the 1) is the better way, rationale: you write normal
code that does what needs to be done, using defer(), and caller (that
knows better) decides whether to sub-scope.
As this defer is very similar to golang's in intention, I would give
yet another analogy from golang's world. It's similar to concurrency, 
you write normal code that could be parallelized via "go" keyword,
instead of writing async code that needs to be awaited for.

Going back to the use case variants, there is no much sense to have
push() and pop() dispersed by much from each other, thus I would like
to introduce an API that just combines the two instead:

new_scope exec_test1 $t
(name discussion below)

> 
> - defer(): Schedules a defer to the most recently pushed scope (or the
>    default scope if none was pushed. >
> - defer_scopes_cleanup(): Pops any unpopped scopes, including the default
>    one. The selftests that use defer should run this in their cleanup
>    function. This is important to get cleanups of interrupted scripts.

this should be *the* trap(1)

with that said, it should be internal to the defer.sh script and it
should be obvious that developers must not introduce their own trap
(as of now we have ~330 in kselftests, ~270 of which in networking)

> 
>    Consistent use of defers however obviates the need for a separate cleanup
>    function -- everything is just taken care of in defers. So this patch
>    actually introduces a cleanup() helper in the forwarding lib.sh, which
>    calls just pre_cleanup() and defer_scopes_cleanup(). Selftests are
>    obviously still free to override the function.
> 
> - defer_scoped_fn(): Sometimes a function would like to introduce a new
>    defer scope, then run whatever it is that it wants to run, and then pop
>    the scope to run the deferred cleanups. The helper defer_scoped_fn() can
>    be used to derive from one function its wrapper that pushes a defer scope
>    before the function is called, and pops it after it returns.

It is basically a helper I would like to see as new_scope() mentioned
above, but it takes it upside down - it should really be the caller that
sub-scopes.


I think that the name of the new_scope() would be better, still concise,
but more precise as:
subscope_defer(),
trapped(), or
sub_trap().

I have no idea how to make a sub-trapped, SIGSEGV isolated scope of bash
execution that has ability to still edit outer scope variables. Perhaps
we could relax the need for edit to have easier implementation? It is
"all ok or failure/rollback" mode of operation anyway most of the time.

After the above parts will be discussed out I will look more into the
details of the code more deeply.


Return-Path: <linux-kselftest+bounces-10968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B727B8D5602
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 01:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CA61F21D24
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3D5182D3C;
	Thu, 30 May 2024 23:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibQFs6nr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874BE13B290;
	Thu, 30 May 2024 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110457; cv=fail; b=MmlNEW4vx0VexnefNlGrRHodIbLdDjRJVdJSZ8M5M0l/Dg+3aV1NbgGDjBk67tBPelbPl2RyKLZcyZgv/jKhzPhc7HlomLaESU/ovycAYVOEttp/P6GK+h45xYLK4tQnFucmida9JmdugCOFd1Kpzv1TN/xPFGbralpGQMvM3Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110457; c=relaxed/simple;
	bh=nQRXrAfmKMIFSIFUA+cFDJH/lCIOesmGiifIyCNWNLA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RkdC1hBqdyJ6l3uNqxmovm9+lSxK7pIDzGknPUjZVpOv5RJnn2mi9b0Ch6srdIlRY5tiYVTuZLROgZpzvEVo38wXwbNpng9vZHOQVBU5niNFrcugdLb62X1mixtN74A/Vx/RNi2nDubcyXPQ3ElgjErX6ZkJpxHj993C/Alr/8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibQFs6nr; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717110455; x=1748646455;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nQRXrAfmKMIFSIFUA+cFDJH/lCIOesmGiifIyCNWNLA=;
  b=ibQFs6nrxzBFIwStilvguOYo1UYEzs+gxYGnLg1vv1NQZvLEDR9WbLfh
   m3eMOc6o3UW8vQomz17HmhDWCwygnlbViagT8ac0EOTfMO1xhHyABW9hH
   Z2LVSbJ2uWMTCPYyCjBtiuFcCrQV7f9vtnqrpRNf5w9UEP49TWXoHk3Gu
   OBkB9kXy+TyHNupCqjYrLVVoY+BKmQSfYdJE4PLRCM7BGPb6yPIIzMYLB
   nwI4hUf5U+EvGwfQhTmmXCRGfrzZ9fN0OU0WD3R3c0ot6pJBi5b1+YMCg
   W6q0N7N+H0jFx4VeVfbvXRVgujXyszDZ1viqheLr4ECEVq9y2OGZFtT3o
   Q==;
X-CSE-ConnectionGUID: hO9sNQ7/QdeLXEGAjdNwRQ==
X-CSE-MsgGUID: yMw7Ufa+QGW8QwXK1ZwSkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24196316"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24196316"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 16:07:35 -0700
X-CSE-ConnectionGUID: pbNiV5TgTpmVHpRKDVlIfA==
X-CSE-MsgGUID: 7pux76rGQDeLaUL2WfPerA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36069709"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 16:07:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 16:07:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 16:07:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 16:07:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 16:07:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L02OM0Ok0hEy1GYIvyBhEhd5xgp2N5d5S2Zuz++q8BGXhjtjbLYga0rdXmh6bkCTx3fabca8Tc5WqthooSf/UaXOkJR/SVbbBD8mta4EZme1M/njQGvf9qEUX2Z8dVl8913m+S6L//nklRFd725mizotzourscBlrSn5e3ySMgf+7UtSmBZVPH9E4ZT+vNNWSd+bflJ0tWlop/P/ML+Tbnah6p/xcnVbPtW86UTB3ib5dD7mSbXfzFabjU5qpVepZtFxYNNrxqcIFTp1aZCjuJ/NmGDgOn8jTgp0NWneNTf+zYUAX9abtveR1cFyISBKU7YIzo1iZKNwicQOlO5Ecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp2cYQBHk9glLGr2F0PJMdMENY1OFdQ65ZXYysJHYL4=;
 b=M9cUbugZdxzAMxTAhgH2ZcT4+bg0Fj0q6iiiDp8epX4lkokhBkjj4eHAS9kjKohmO2PLSTGa+guY0pAJZYnrP/AQAWrnCG6zXZdWupbE+ul2YgqwJgEUcYaCly+P4C5FVJQKAWn1V/skd8YGGhmsn4vqcDGR+sSWnXdZyClcSHGs1miqhcDRNZ52ZYsFlBTJCS5zvaT2ehgoSVDmkj1n2uqJV5erxkaYMQXlKBzmiwAGDRHn/Zqj72pjcSjB7a2cYvf2peN9dUg0YUmObCoZBbjXBtb0nCux7XB4yLoGik6DP5YGbbGSjpFVJdZn7yXnn1iYnSqNkFFZEwriiqutwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB7833.namprd11.prod.outlook.com (2603:10b6:8:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 23:07:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 23:07:31 +0000
Message-ID: <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
Date: Thu, 30 May 2024 16:07:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: f84c6022-bd74-4648-9b9b-08dc80fd4873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0FjYkFha3AwUi9qZzk4S1FGSEhFK1JwdzJQeTZqOWVwa0tGTE9IZzZ2Wjd4?=
 =?utf-8?B?SkROMWxMTUVKMUtxTEo5WGpHZFdHTzBaQkhnbXBtWVFFSXhyZmVQcUNzeHhJ?=
 =?utf-8?B?L3dXZTRBMTB3NXljcTFpVlpWZ2cwdEhKNHlNQ3YvTnNacUN1azZQazdSbVBX?=
 =?utf-8?B?NDJzbzZUTzNud3l4YjRzUG5oUEY1Sks5U2wzN2ZWZ0ZQVW0xejdsc2pZMGtn?=
 =?utf-8?B?WG5Sa09XQUIrZXNwRWRxSVZ1TWhsYkxWaFRiOFdIbGdLSW5jTWE0QnVmT3Nx?=
 =?utf-8?B?RnJPZkhXMW80c0JvMCtURlZTaXJIUVpvNUNrY1kzSW1LdHpwS3hxdnRkNTNE?=
 =?utf-8?B?bVY5VU9DYmRHbkNPYWtXNXBuS21HRVBPbUl4RXZlRE54emlOMVhEVzhuRUd3?=
 =?utf-8?B?Tm1pREo1ZHJ6U1phdFFQRjZ1b2JqcEtwVW9qbExLQ3JDeUxKRUJWSVRoUEdK?=
 =?utf-8?B?MGVNVlE3VlpQZXVJaUNvTkhPOU5nS210R25HSnl3WkQ1UUI0YlVIY3NQNmor?=
 =?utf-8?B?ZzgrcktZUlZyTTZMQndaTnRTaUJKODlyaUtSYUQ1b00zekUrM0pkZTJrb2Qv?=
 =?utf-8?B?b2VUb01wdWx2N0VET3JkdFZDSGVQSGJrYVFTenBjaDF6b2RlYStvRzBNS29S?=
 =?utf-8?B?NEY4Q0tPTnJrN2d0QUI0bXV6VG5Fb2VkRXd4OTBwRkk1eHJLSkV5UU13Y0p0?=
 =?utf-8?B?V2RBaVVXWjBxeGx4VjZRZVF0QWZEZVpRUEJFMC9PRFQ1ZDh4VndSaWkwYXVD?=
 =?utf-8?B?UTVOck8rcUIzc1pUNmo2WUhPWDNtVmdxS1BXQTdGanlRQ1VNbVdSUVhMZUo5?=
 =?utf-8?B?ZHZ3a2tQNzNaSjYwTzB5T3FjeVhESGc4REtWMExMSXdsNnUrZllrc2hIR3Vr?=
 =?utf-8?B?RitpRmZVODhDVUx1aUhCSnp3c215STRpU3pkcW9kOU9zQjBOd1l6WE9udUtP?=
 =?utf-8?B?WUlJbVF3L2NMd3ZRaXFFRUJIVWU3Y090WThUVURybjhWNDl2Y1dhTEIvc2F6?=
 =?utf-8?B?OXgvUXZpdzBpOVlOSVFDMWZVWCtpdi9PTkh1VllreTQzRTQ5WUNCYkF3UHg1?=
 =?utf-8?B?MXlVZFFiaDg2QXdYOUgyWTdzZDgrc0NnbnM1aEIrWWdBZWhkL3YxK24zdEdV?=
 =?utf-8?B?bkUzcWZrc0FmOC9tN3ROb1hxa0VZM05uajV1MlpiZVpJSEtRMlQraFBMNS9Y?=
 =?utf-8?B?d3hmcG5UUW5aZzB2aTFDK25BVDdyMGpac0FpZTFQRVJGMUFiMURiMGljd1JO?=
 =?utf-8?B?QStCdml3MVhJcVlNWlVCTktwaVhSNWgwU1N4R0tiNUc3dGVlcWVPaXlSSXZD?=
 =?utf-8?B?Zjg0QVo4UERFeEpVMGhuWWlVVzBOWHg0Tno1cCtvZE1Rai8vam41TXBwbWFD?=
 =?utf-8?B?MG1hSzB1aUpWelpLc3l4bUtFcElIWmo4aWxicmx4V01YTTRxSmJOblcyZjkz?=
 =?utf-8?B?KzlmN0s4UkZQQ2pNemp5RXFxdmQ1STl1amcvbC94RkZPTHMzZ0dJckplZkxO?=
 =?utf-8?B?RGE2RWFZSzlYV3ltNlFjQXgzSWYxTG9oR0ZKT1Y5Y0Zwdk1uanlXZmgzRnB0?=
 =?utf-8?B?RmJRQ3o2RXNvTTFRMWFwZzRWMlVLSjJHMHp4WWxaU2JOdEhZQk11b0FJb2ZF?=
 =?utf-8?Q?JV0+lm94nnE/eeKqx13rbQHPlVfxg8sjKFdbNc03Z+sM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0d4bkFVRERCbFp5RURsWWVJNEdXNkE4NTJMZDJQZ1M4aENSRTJqOFJ4TmJa?=
 =?utf-8?B?VU1uWjcrZmhMejNkNmFrMTBaeU9RQ0hxelNIcTFEdXdYamg3OWJmVk1sK1o1?=
 =?utf-8?B?dVFkanY0TC9QVUpXcW1QanFDMUsxM244Q0lIRE5oeW43K1owVFcwbjNRVXhN?=
 =?utf-8?B?cmRKV1JuVGFxd2lXb2lwUzF5TGpPZGNhV1QxT3o5UExzWVpsS1YyUEZKT3VJ?=
 =?utf-8?B?YXJ1c2k4Unl3d05FSGpHcjVNNHFDUkRLNE5rczhwcGw1eGluMmxFRnJxdlJa?=
 =?utf-8?B?cWx3c3RTS1pZL2ZxeGxWS01TMVdvTXdDM3NYNDZwR2c0TWJmdnQyNFhlOXkx?=
 =?utf-8?B?Zkdzbys0MlM5WXpETUE3U1IzeEdRdGJMejlmRjZOOC9mYVhrL1dhOTVzcm5D?=
 =?utf-8?B?b1N4WC9wSHdrM0lyaFd3My9LTWJzMUJZQUUzL1B4amg3dldOSWlGcFdTU3pl?=
 =?utf-8?B?UVYwQXJiQnJwYlNteE11R0R2MW0vcDNZb2hMU29FQ2krUlBlQk1TZ0E5eXJv?=
 =?utf-8?B?ZXlDeTZ6MVpiZmRJQ2EzU0s1bVIvWmRTbzRkKzdHYVBkOS9nZFpKQ1JZNndj?=
 =?utf-8?B?NTNFVndON05DZzBiY0p0ei91SGU3QmNaMVJvZFkrS2dkWVlNRDhkbUpaOTFw?=
 =?utf-8?B?UnhrVkdWTHFMTGFGaHR5ZkZhV3J6L3BYcUdsS3dyOWxiaGtKSXlpSlNsQXZH?=
 =?utf-8?B?cXJoMUszTzZ1dm1oRUF2ZjZWNDRUeUdZR1NFaU5yWWp1Slhaajc3TG1NYkJp?=
 =?utf-8?B?MnowM042cjJCMFdLclFjZVlNWUR4VklYNlBxdzhzMVlZeVZEQXVZK1piQm8r?=
 =?utf-8?B?WVRXQjRhMVpCQmdvVzJnMFRmd0IrZlQ1S2IraHNsd003OHBwQ0I3d2pHM255?=
 =?utf-8?B?THIyK0haZEd2VEU3RHdPZUtkbVV5QnRpaUViWjRDbjJxVDBoNzBOKy9KWUU1?=
 =?utf-8?B?cm4rZXpsUlViTGF2WHFDdW1CSHhKV1VSb01yWWRWbUpDMTU2OEM3ZjBtRTZY?=
 =?utf-8?B?MXRscnYybTNkSXZGcXRmOWJXaXdqU1hPbkVKb2VxeWYrQUJ1TUlkVGpuT1Rr?=
 =?utf-8?B?UVlFTGREMWpxeDEreFRweTIrSDlMTmE1YWtQTnB6US9ZUmxUalFzdDRsams5?=
 =?utf-8?B?Z3V1YTl2SStMRDlVYnNNd1gwOWtnVHg5bHJCOTVvSnRFcU5pV3RZREI2QVhT?=
 =?utf-8?B?TkREa0dzeDhuTVBwUGl1MW1rakZJcnMzdDR4U1J6dys3bi9yOG1OY2p4KzMv?=
 =?utf-8?B?K2dnbm1nYSticWh2SDEwa3JDYnpHRlJMNkM5djc0blFlWlBycCtwL1dmOGtJ?=
 =?utf-8?B?MTBHME9RaUQzWTN2ZUNOWXVLSzhRZzhDcDBPYytYLzJQTkhBL3R2TFVYYTRR?=
 =?utf-8?B?ZkZQY0xhZndtR3pWdFdJcXRESi82Wnd5bzQrMUIrcjZVVmg4a0U5R0ZiOEFK?=
 =?utf-8?B?NWVFL3UvYlo3RG9DdEkvTTNTTlAxeWhhNHNQRXJ3Ukp6K0RCVEdzWHliaVF4?=
 =?utf-8?B?YzZ3L1NvTnhHSVFRbkhOWWJXeEZldjZiNHAzTVFZSlVydkZLaGFBdXIzd0Zx?=
 =?utf-8?B?VVQ0VVBIZGJ6U2hYc01zZWw2SldtdE84Q3VFdWJRRGxmamNsWDJvY0NmSzl2?=
 =?utf-8?B?Qm9mVnRtUUpuTFFjQ1VSRGtudHk3QWxzbTBxeUltblhETEI4QUZPelNCc0hX?=
 =?utf-8?B?QTJ4NzJuZFV3VEc3S3NiMWUwdXJWRFlZbkZzWkhhbTI4L2l0a2lVT1lCeW0v?=
 =?utf-8?B?NDgzWXFaT3RBSnllc0RFMHIzQ2pwWUw0QVk4MFlXcWNFczdqWGZYR3N0RXEw?=
 =?utf-8?B?bTNEbnB1ZmhMeXUzV2RtOFRBVkM1UU5ZM0t5cGJiaUxSbVNsdzBiaGNMd1lU?=
 =?utf-8?B?QVBVeGhlSFM5cGtQazFMV25ncW1LMnB3SERseTRTUzlpeWNFdGMydDFKVmVj?=
 =?utf-8?B?QU9QUmJQVExST2xpdWxFSFk3dGhGWE4zano2NkxXVXhvbWloSUpsVGxDdGNh?=
 =?utf-8?B?K05kL1pUQmM5RWI5amo2R3NsL3ZLejhsYmMvSmJacUF1ajVjQVFuRlhCU3RD?=
 =?utf-8?B?em9FdmREME9iOVFPem9XL25MaU9QckZEUFVvNTdneEdBblVIcmRkL2UxSmp6?=
 =?utf-8?B?T0NNN3EvUjFKaVNvSTdFRE16Z3BEbXdydk44YWRIZzJFb0RSQ3lJZnVqUVl2?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f84c6022-bd74-4648-9b9b-08dc80fd4873
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 23:07:31.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RW5vQX8CDMiKD9F2Qe4LvG+ziYrWjo1C+sxNX74SoXz1p0ugrxLP8zdk6JzkunS+D/vOHKx81JWKiGq52Xuh8D/xXbamQVPlHZ0MENuO2oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7833
X-OriginatorOrg: intel.com

Hi Maciej,

Regarding shortlog: L3 cache size should no longer be adjusted when
SNC is enabled. You mention that the tests are passing when running
with this adjustment ... I think that this may be because the test
now just runs on a smaller portion of the cache?

On 5/15/24 4:18 AM, Maciej Wieczor-Retman wrote:
> Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
> nodes. Systems may support splitting into either two or four nodes.

fyi ... from the most recent kernel submission 2, 3, or 4 nodes
are possible:
https://lore.kernel.org/lkml/20240528222006.58283-20-tony.luck@intel.com/

> 
> When SNC mode is enabled the effective amount of L3 cache available
> for allocation is divided by the number of nodes per L3.

This was a mistake in original implementation and no longer done.

> 
> Detect which SNC mode is active by comparing the number of CPUs
> that share a cache with CPU0, with the number of CPUs on node0.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Co-developed-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
>   tools/testing/selftests/resctrl/resctrl.h   |  3 ++
>   tools/testing/selftests/resctrl/resctrlfs.c | 59 +++++++++++++++++++++
>   2 files changed, 62 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 00d51fa7531c..3dd5d6779786 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -11,6 +11,7 @@
>   #include <signal.h>
>   #include <dirent.h>
>   #include <stdbool.h>
> +#include <ctype.h>
>   #include <sys/stat.h>
>   #include <sys/ioctl.h>
>   #include <sys/mount.h>
> @@ -49,6 +50,7 @@
>   		umount_resctrlfs();		\
>   		exit(EXIT_FAILURE);		\
>   	} while (0)
> +#define MAX_SNC		4
>   
>   /*
>    * user_params:		User supplied parameters
> @@ -131,6 +133,7 @@ extern pid_t bm_pid, ppid;
>   
>   extern char llc_occup_path[1024];
>   
> +int snc_ways(void);
>   int get_vendor(void);
>   bool check_resctrlfs_support(void);
>   int filter_dmesg(void);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 1cade75176eb..e4d3624a8817 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -156,6 +156,63 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id)
>   	return 0;
>   }
>   
> +/*
> + * Count number of CPUs in a /sys bit map
> + */
> +static unsigned int count_sys_bitmap_bits(char *name)
> +{
> +	FILE *fp = fopen(name, "r");
> +	int count = 0, c;
> +
> +	if (!fp)
> +		return 0;
> +
> +	while ((c = fgetc(fp)) != EOF) {
> +		if (!isxdigit(c))
> +			continue;
> +		switch (c) {
> +		case 'f':
> +			count++;
> +		case '7': case 'b': case 'd': case 'e':
> +			count++;
> +		case '3': case '5': case '6': case '9': case 'a': case 'c':
> +			count++;
> +		case '1': case '2': case '4': case '8':
> +			count++;
> +		}
> +	}
> +	fclose(fp);
> +
> +	return count;
> +}
> +
> +/*
> + * Detect SNC by comparing #CPUs in node0 with #CPUs sharing LLC with CPU0.
> + * If some CPUs are offline the numbers may not be exact multiples of each
> + * other. Any offline CPUs on node0 will be also gone from shared_cpu_map of
> + * CPU0 but offline CPUs from other nodes will only make the cache_cpus value
> + * lower. Still try to get the ratio right by preventing the second possibility.
> + */
> +int snc_ways(void)

"ways" have a specific meaning in cache terminology. Perhaps rather something
like "snc_nodes_per_cache()" or even copy the kernel's (which is still WIP though)
snc_nodes_per_l3_cache()

> +{
> +	int node_cpus, cache_cpus, i;
> +
> +	node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
> +	cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
> +
> +	if (!node_cpus || !cache_cpus) {
> +		fprintf(stderr, "Warning could not determine Sub-NUMA Cluster mode\n");

The tests just use "ksft_print_msg()" for error messages. The "Warning could ..."
is somewhat unexpected, perhaps just "Could not determine ..." or "Warning: Could not ..."?

> +		return 1;
> +	}
> +
> +	for (i = 1; i <= MAX_SNC ; i++) {
> +		if (i * node_cpus >= cache_cpus)
> +			return i;
> +	}

This is not obvious to me. From the function comments this seems to address the
scenarios when CPUs from other nodes are offline. It is not clear to me how
this loop addresses this. For example, let's say there are four SNC nodes
associated with a cache and only the node0 CPUs are online. The above would
detect this as "1", not "4", if I read this right?

I wonder if it may not be easier to just follow what the kernel does
(in the new version).
User space can learn the number of online and present CPUs from
/sys/devices/system/cpu/online and /sys/devices/system/cpu/present
respectively. A simple string compare of the contents can be used to
determine if they are identical and a warning can be printed if they are not.
With a warning when accurate detection cannot be done the simple
check will do.

Could you please add an informational message indicating how many SNC nodes
were indeed detected?

> +
> +	return 1;
> +}
> +
>   /*
>    * get_cache_size - Get cache size for a specified CPU
>    * @cpu_no:	CPU number
> @@ -211,6 +268,8 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
>   			break;
>   	}
>   
> +	if (cache_num == 3)
> +		*cache_size /= snc_ways();
>   	return 0;
>   }
>   

I think this can be dropped.

Reinette


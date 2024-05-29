Return-Path: <linux-kselftest+bounces-10852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A0B8D3DB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5D9B24540
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F89518734B;
	Wed, 29 May 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2UKGDGS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288EB18733B;
	Wed, 29 May 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004974; cv=fail; b=l6mRIyXkU0TiZCQ9KYwstm36vi5KFIrODQzsMSFWaVYpidaYtRQeS/dS2nAsHyrkat3bQ0Q3/06OoS+GnTYfzyylr74AKeu022BRIneWVuijJ+62IOt8WhxM0cQKoF/qSScVMVNgJL0LiaeE/lGQeF7LfhmL0p5JrSDXJJO6Puc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004974; c=relaxed/simple;
	bh=tf7WE108wTduM5U0mPUkFgWcUEiSXcnIy1Df70mseHc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mm8C5k4nGMd2soJiotTLsNbsKAkpXd5CoNfre89gXCzKGQoTMZsOJm5vMbFF9GaKVhyLQPILb0Z+x+hg1cgsH1v6SEDJDQfwovgyWFFSkOAMhB8pueRx4nYJjaKCoIytJYyQM/lnu36qO1xhlz9V8zKce8+I/2z6PynY2ykMEyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2UKGDGS; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004973; x=1748540973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tf7WE108wTduM5U0mPUkFgWcUEiSXcnIy1Df70mseHc=;
  b=T2UKGDGSP/Pz0bfVugv8iu9KskDGWV4iKzNLkmiaL9hYA+Jfpb2+p5kW
   /U95bZ9nl+gUdqlf2SdaZwIxZB/jkAMI/P2W+8TtJ/kLJsSkh/+41LwsL
   wa0A90ks8mX3dIrf6+MNRteJaXTawlHTpe3/x2/CmKKCT3rFgZqgWN4Lk
   9TpAcaBmBYU775Kp5yw0cUV7kDJHb6C6QmXU1tMIqeNyI7ivGsH2WcCpc
   JRwlPu3gCpINAdleRP+VD91Cxu7GvwQzb9BRB8KcY9bkv+PqFat9TnjXD
   /ylAQvkROEK2vL6/ZogqWLDWKeSReUm9XTWddtnmsBE1vXhjeYM6k0+Ag
   g==;
X-CSE-ConnectionGUID: 3i3RO/KmTJu/y35z3SB8CA==
X-CSE-MsgGUID: 4+zMrhZqQTWKGe84BBcR8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="16378656"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="16378656"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:49:33 -0700
X-CSE-ConnectionGUID: UTkOhIgVRsmIJcWeDwwgXQ==
X-CSE-MsgGUID: YNfZyQ2wTjmf7mkX8RfZvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66393983"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:49:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:49:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:49:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:49:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAY1LZ0LOqpU/R8RNTeZatGUxn/NSNpmPxGAfZcDH1qBQ3x73Jghe24AljlAgIHdhk1w5bvgrWgEOe+ggIC2pjUXjtGPYnODOe8nvls4g5CKxvIYKLkvrIlyIHh5u/bfqExhHPPVC44Is+X/3L7t8apEdsYsb+CoA49blSK1030G3A1IA9sjQGkQ6w/UyDHS0JldpiTRJn6WHSRAlgJjEdouaqQ3MvYhfkHrgvZvp6TlejPdFzlcb9hRtzJyPm/zjMSRffkySys/PnMqSfWvbFpMi0WzwPCXEaZgW15PGwwuBIoiN2AMNJK+DR0XjZLy+V/XOuZpkx3m+ecqotlMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1fxyB/k+by8vVXHR56Tn7/6U1C9b0xC9h43UwElMyc=;
 b=Tqk+fzvetPm1BG57OgJzX3x9lbiKn3SYfdsU9udyAC5q4oBoDGzzBFCsUoitzB0ZZ7mYLOkKukQP0+WkFQ4Jp4Wtmw0l1rkmRJaSycWB75okQ4lsMyWfqD7OqNF2Aa4YiIFHyoWMSE4SY32NGIYonG4RYmNRnbHDzTp2DW/B9Lq6gjM5voMcuJbRHJSsQdOw8EH5+NLXbgVk1mijWpm2GluD1Wc43e/XsKnZGsH4L0N++3heWUZ3QuXQEx3Q8QrE1p0QIYxS7jdweDCz7WFfFh0RnQ9SpQL7lyY6LvgolfwN8MyMgu2C4iCsdhDufDjsGhtoTQ6PFEF01+eF2j7H9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 17:49:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:49:30 +0000
Message-ID: <57116999-bc73-4277-90bb-4877145788cc@intel.com>
Date: Wed, 29 May 2024 10:49:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/16] selftests/resctrl: Remove mongrp from CMT test
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-16-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240520123020.18938-16-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:303:84::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8368d2-524d-48d6-7297-08dc8007b0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlUzZ0ljdUhXRTgwcWZUa0IzSkxyeE54QWJRRWxuL0xicG05WnJ2SEJ4ZGIr?=
 =?utf-8?B?UDhSOHQ3SkpzY3cxR0ROK3FwSTZSd1h6YWZaWHAxV0JOL3hTWUFUdjkyNlJk?=
 =?utf-8?B?b2pEZnF5d2sxdVlrVmxaZXROU2xCWUltL1o3TitvNVVNR3o2dE5lSjZaSjdx?=
 =?utf-8?B?eTVDT1dnYmFTdFhoZVdyUkJWYlM0cjY4bXRsQitrbFhSVkVmRFExODJwdW5F?=
 =?utf-8?B?Yko4dDVVTGU2a0hzejBzOC83cUs3clR5V3BFbDZNT0NSU3hMbTRBOGV2NE9m?=
 =?utf-8?B?eEJ2bXo2cWNQSm95M0ZSYnMvREpMM1d3Y0doZFcyRmd5eXRsQTlNbWJieXY4?=
 =?utf-8?B?RzBBc0ZhMFBCVEk4RVM4eVdBRDVYOGV4SGtjTVdONnNrSVlTc002NnFubDd4?=
 =?utf-8?B?OThMdmFQTW1jR3NncytoUVRYVno4UzU1LzVXaUZBMjF6djgraDF3WWN6UHMv?=
 =?utf-8?B?UVdJVFZqQ1NEUGN2aE9XOVlndGNyczZ1ZS9pc2xad3dqR3ZSMUlwM3k3aVUy?=
 =?utf-8?B?cTBLRjRlUVYrS2RlNHJDSVhiM3BuYU01SWJUTEtPaUtHb3hrazJzcE0yTHJo?=
 =?utf-8?B?QmxIaUVocmdjbVRCRTUwVmNTWVdibUExWEFsU2lyci9jOE5xZDZNWEpNSlY1?=
 =?utf-8?B?SFhpTGxiS1RFWTBqZzdoUzBOMWpZSWJza3RYa29ORFI0cWVxUU5saE5OV3hy?=
 =?utf-8?B?Rmwxd1UwNlFBcEwzcXlCS2NuMjk0QXVuWHlmSGtFZE1CeHk0WDUySTlXQlpT?=
 =?utf-8?B?WmpXQXdCUHpWTEs5cGdiUGd0MG1uaEdXUEtGWERkUWppdnRIdWtsRmQ0ZlpU?=
 =?utf-8?B?Z2ZvTWZOSHgwaHV4aGltVWpXV1lSOXhCd0EwVVB0YlNRQzB6TXZuNDVDbTA0?=
 =?utf-8?B?aVNaOTNMZDlBMUdSdHF1cEUxWFBxc3V3eE5lNW5sV05mdnRCSnZFcFhaWDF4?=
 =?utf-8?B?RnI5dlFLc0NiMGJwV2tHNUFrQzI1R1FZUWdEUWVYOGg5VjlmRm1SRDN1M2hy?=
 =?utf-8?B?NWIyeDVHRU9PVDhoQkRrUm9IZWlnUExCbDEzK2prb3lxZWpvR0t4amFWc3hk?=
 =?utf-8?B?d1JjKzNBT1J0ZUFtSlVYbTNYMzhDOGVsY1I5WjREVmswVkpkS3BSaytSV2lT?=
 =?utf-8?B?NHFvZ3dXdlJmbmt4MUJtQ2x4aXdsQjhldWpwYmhORjZUWHZSY1FRdForcEpN?=
 =?utf-8?B?aFFxQ01Ib2VjUEJXYUk0MnNaY1FXb2paUlJiTXY4OGk4a2I4emd0MTRrQjBt?=
 =?utf-8?B?TFU0Q25EZFVqZGlQSWg1TU1WaXlaemVvdVpRWk9vUUpqdzA4VStLZW5IZURH?=
 =?utf-8?B?TVAzVzdVWGNmWkZzMUJSOURsT296UHliUUk3UVFRaEVMdzVXOFFtVWdIZVdY?=
 =?utf-8?B?RHVrSTY2ZG52NFVsWEN3aElpVnl2MlRqbTU2R1dReG04Z0NnOHEwZmVFYTlW?=
 =?utf-8?B?bEJUTWs4bUpjVENwRUVXMi8wZ0FCNFNRRExxenFjdFZ1eEs0eEQyK0t3Ynk5?=
 =?utf-8?B?ZXBkRlBsaktURTJFNUZIZmlXcnNOSkczREV0R2NZN0xxNUdtdklFVU1aY3c3?=
 =?utf-8?B?RHUzVzBNNWlyLzJPWWZUNXhKaitWVS9uR2JiUUsvVTJ4VXd1UzZkdm1lTEtG?=
 =?utf-8?B?b2NlSDhuV0NxNnZRSUl1QVNFZUo5ZUZhcGZjYWlKN1RDU1RNZUVLMldibkRn?=
 =?utf-8?B?amxheVlLNmNiZTBVK0ZPSUtTVkFteXUwRFNUbDh5bGZBc0s3VUJrK09RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVJEZGFYeWJNdzFnQ2JHUThrLzJTVHZwa3JETVpBVTRRdGQ3eG4rMFVFY2VF?=
 =?utf-8?B?djVXQ0hsa2U4TkpGckNaWExuUXdqMCtkaVdyT0FkQkhiTitjVWxhbTFUV1Qy?=
 =?utf-8?B?ejZRbE13bXF3dEVNWTNIeTFTeVcrbWZTeTlZM3NMblpkZDZTRUNwa3ZlNFNo?=
 =?utf-8?B?KzJaajVMbnBuK2NUaThVTlFxSGpvbkdEamFlUkp2VkxkbEh6bENEOXo4RldT?=
 =?utf-8?B?NHRQMGhEblB4YnBrVGNKekZ3QXRiVG5BdmdrQ2xjT0ZzUlM4SjRqQ1BOTnJl?=
 =?utf-8?B?ZnJjdTkyOEdaeDMzLzZjY3h5TWF0Vk1oZGV0bThwMGVJNFBGWnVyT2JkYitj?=
 =?utf-8?B?d0xZSEtab3RmaWhIN3U4TjBqdmJFUGVvdlRKV215L0F3bytiZCt2cXIxWEhm?=
 =?utf-8?B?SVhLMkRCUTUvZW81ektsL0wxc0FrcUQ0YnVRS1FraTlZYWVIMWV6MTBIcDYy?=
 =?utf-8?B?UnJzNnRhdkJKUW1HUDNndERNclArYzN1T3lvMlFwakwyTWpGYjJ0MmljMHpq?=
 =?utf-8?B?cUxPWW9IYmdPbGZ5QkxzOTlDRS9pdXpvTExJd2IvR1FwdDBibVZIM3VrbDVR?=
 =?utf-8?B?dXZiV013K2x4QTJScG0xVTZjZG9xMk5SbW1XdUF1aHZpcll3Q2gvMmgzN3Bo?=
 =?utf-8?B?Z1B1b21EV0M0U2wyTjg4bjBsbjRmTjNDTHQ0RVBYNDIwOTRKMzMvdFRZeDlC?=
 =?utf-8?B?cWRHb3Y5VkNxV2VMa3YvYkRnQzVncURtdGtpQlVOclBUMEFzV0VOK1d3K0V2?=
 =?utf-8?B?NWd5QnpxcXJLWHluZCtkaE9nSzhkT2xYZnZKQS9WM3RXSS9wbEdrVFpaYmpL?=
 =?utf-8?B?MFJIZE5xWmxJN1hsYlE4aG5Zek1zT0UyZmx4b29BN2hFV1FDYzNGVGgyajdC?=
 =?utf-8?B?RXNEMlQ1cGp0KzZmNEVPdnltYTVDaEVGNE5vQVovTUFuWklCcWFWNTZDOW1K?=
 =?utf-8?B?blZXeGphbXVTaCtERDVocmZ3TlUxbkRqcExkK0VVb3JHUWN2dG1aSkN6RFZs?=
 =?utf-8?B?Z1k5L0wrWG1JWmhWWmlaOE5ES3VEUDEwVUVPaDVPS0ZmVkRmckErRjc1MGth?=
 =?utf-8?B?aUU1TWI0NzFzM2RocWsrWHBvTDRESGg0RmM1MDF5LzhydGRKYnlWZTZwZ2xU?=
 =?utf-8?B?T2xuc01tZ0gxNWJpM09vS0lSWVhxSVhEZEZZSENaYi8xdG52U0VkU2wrQVRp?=
 =?utf-8?B?YUNKUUxaN1dESGtCUTc4c1hHc3lneHE0QXFSRXpiUThvalpWOFZUdFR6VUpU?=
 =?utf-8?B?VEpYVFlSQUxvT2FWMjczOXY5a1JkSnE3dnVwVWxPaFhxMUd6TlhhbVN4dUdo?=
 =?utf-8?B?aGZyVUI0d2t6bUsrUnlVU3o2Q3dVTDB3NWY5QnRoWjRhM1VWQnM0RjkvNDZj?=
 =?utf-8?B?REMxU1JYY3lWK1lIdndTMytjQlBNcEtkWEdOemExSituQm0veXZCMFI3TGlD?=
 =?utf-8?B?TURmT2V6Y2tCZ1h5MTB6RXN0aUMwM0FTVXlJRWV5QnpxNmR4QndUZ0NQcHhO?=
 =?utf-8?B?dUVHUU0zbjFCWmdIL2dyZXdVVjdiNTlDeVEyYmYzdGFkN2NyYUIvZkRZV3F3?=
 =?utf-8?B?RVA0TGt2VUViV3BxOWZKTWN0aGRGWUdZM3hMN1FUOGRwaDN1UDEzRWlyYXV0?=
 =?utf-8?B?OE55SlhZdk5XOE43OGRWS3F1NXRNTHBHSGlQZitVbXVTRElhOGRmckVHQ05W?=
 =?utf-8?B?bGZ3Q3RTdngxZDNtM1NHZytoZDRkMzBTRityelIyR1h5ZE9oYk5WTng1TG5n?=
 =?utf-8?B?UExUSm5xT0xqYmtvWWc2MmdLTzhwSlFkNTlTNkdVYU5Na0hSRHkycW9naXlK?=
 =?utf-8?B?TS9yZURYOUhpK0t6WHpZWS9aRkF0ZWhDSjhBdVlVMjM1NCthaVlCTWRsNGFB?=
 =?utf-8?B?QnZtN3B0OEw2NXpQbk54c3RHWVF2ZTZCbko3V3BKVFRBK2tKYWpxNEJQb0xy?=
 =?utf-8?B?S2JRdE4wK0twVXFHdWpRdmpTNy9jaVo2b01DRTJvakoxb3M3SE9CbHZCMDJO?=
 =?utf-8?B?aHNIVUZOWGZ1Qm9UT0NDOWliN0pvYnlvc1BuaHljcUJ5ZnRLYVhaMEhNazBV?=
 =?utf-8?B?ZWpHQkRDbzhCUkNnbmtSMnM2cUplUHd0UnYzN3JTT0Qwc2NPenhXWGh2bEp4?=
 =?utf-8?B?eUtKdUUwc0QrT3RxWGk4N3YyMHlDMTVUU3JiRG0wMDhsVk0reWVldk1kVXpL?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8368d2-524d-48d6-7297-08dc8007b0e2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:49:30.1738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xmv4Oo4y2BEeNMSizWvMjv6AI8yqZ+neMonrrApVWM6Ok9KtteCCYRJKC0Or3Am6ZnwMocpNYif9oxSBvYm3RIUW4r1uuLRHmImcuTHiYbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7185
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> The CMT selftest instanciates a monitor group to read LLC occupancy.

instanciates -> instantiates

> Since the test also creates a control group, it is unnecessary to
> create another one for monitoring because control groups already
> provide monitoring too.
> 
> Remove the unnecessary monitor group from the CMT selftest.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> --

With typo fixed:

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


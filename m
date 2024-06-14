Return-Path: <linux-kselftest+bounces-11977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585CF90926B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 20:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8ABB28BB6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4419E7D3;
	Fri, 14 Jun 2024 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRAY458N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857EB19ADB3;
	Fri, 14 Jun 2024 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390370; cv=fail; b=UM57+bvhIA2J4ci87hFVjFZK3gwPgD/weTTIGq/RgZC/fxs4ehTdiqELsV/835pq0oy6Vwq5fqRQvRciecRw3Ozex7USpeJ+bMMpAEnGFT24B4kOgZCJFxAYfRVEHsc3IJQ4Qf2bkqWdH2Vqne3SoyXOWgmic04FXZtmZtwwnlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390370; c=relaxed/simple;
	bh=p9ytLCtX9c6YT4TnMpLMHN9OyVms/kO/emMSlzZxYaw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VDi51P79glPukN5c65i9vzE2rx/cW5r5iS5eq9VGeKpyzwa2S+XFESWab9Sxt+9DlnfuSz6JBJi8+NN4IF9qyXOZCCWHJkmZGNuTSYWWsgkM6+MW+rozdMUk1TDo6wPCtyuP7GK0+VwGpUqrtToQOtvng1JQcEktqzNrgQSnoAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRAY458N; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718390368; x=1749926368;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p9ytLCtX9c6YT4TnMpLMHN9OyVms/kO/emMSlzZxYaw=;
  b=VRAY458N65H2X3BU1LBOwPiE/VDINP85tIiY2VBYy9+lAjVq6+vndVfc
   ElrRvivbzsSV7X7aEsxaeCYMchUt8UFI0VpNtETEQWlD9MRq2N8OSNg8f
   I12zTTsmxALuPqAB/kk81kIlD8GqGSvvAaTzpVsywr4XBm0BmYupDs9tZ
   V0vBvdttCZ5fw4cMCJmnvYH7/3TC/H/BFQLVnktXeBhguXlcANd+FxjSJ
   dEt4ojuXwtnPrjX/iPe7o3VQc/CRXUBn2qhikCKGXK6316m/Fv2VOqNKv
   RC5jSCxNOnr7VnrBDXvXSrjtiQSbsOIQf9rLzYeh/PaM5M1JjHyX5jWCP
   g==;
X-CSE-ConnectionGUID: 27PiO8jkSkicd0JmjfvjOg==
X-CSE-MsgGUID: r+kMRQVuSxqnJDm8yUmFlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15261869"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="15261869"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 11:39:28 -0700
X-CSE-ConnectionGUID: oGXbY1nEQ1mfF3DTuZzI4g==
X-CSE-MsgGUID: c9MgP1aZQBCWae9dcZXVrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="45535518"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 11:39:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 11:39:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 11:39:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 11:39:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 11:39:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsX+3+/MngrOiA2yHBpTdQi15EuPdV1hy5WdeQwXpgcqVy8LvUtHFoiNee1/WNehserRZ4c6ZHp+Cdy2aLQEHWYatyESY+B8u1ice0h8UgXIa3BG6b9i3d+pZSbsbO/2ESLT3kp4FGZQ5n8qdgn744LxhlYEvHw2oGblJXMP0FosdktujNq1p/oTKDzfsaV0dJbhuqNtfEsJgAL3BobyoODAv82dwdcHSVY6zmaFLfdSoY7dkJmpqEjfpOEGw98HYHwRfqoGsNPAnIuJwPx5zCwQqOgpSOZyqGZKezEyGDe/wJU7KoNiGgm6dz7a5+mBmNTopJsk1M33a4E36WkuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMcohNld8elllUNP+h3wwMG82bXzJzZgiK/LLB8rh1E=;
 b=ipngpSCT/6koAtrnp106aTC0rqU9dlgIB9CzutAT4a0yv+rBbOdlxOLGAveZ3C/hZLHsQyOdtmXPMorUy48QZ6817PF4vdtQchK7xyv/LQaEDL2XwdJbXLXS66qQjK2nNHLXOZVHM7bXnCNIIrE3vM8qD1DtdR1bH6HR0J7jw6mme0YonxP39LrY8OXsJdJYT6BLkrkNzcw0MZGzB0PZ/CK7GWYm0HAn419lvrSYatdyrMvi5nxOCI2kZ7570H2ELBAs5V1qn0JA0/pTtZodD8nmorm9CsSSLYOkjn3HXdW1iFLYi0Dp4XHIaJZPXLNAgooFBP8Uso2wNMEdjesqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 18:39:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 18:39:24 +0000
Message-ID: <61fd7414-a36c-47a8-8633-163cb29b0e2f@intel.com>
Date: Fri, 14 Jun 2024 11:39:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] selftests/resctrl: Add support for MBM and MBA
 tests on AMD
To: Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1717626661.git.babu.moger@amd.com>
 <3c2034e3391634b35192819b69eabd7db8cffa8f.1717626661.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3c2034e3391634b35192819b69eabd7db8cffa8f.1717626661.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:303:dc::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: bebf791f-f0d2-4ad2-4791-08dc8ca1500a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU1nUVAwNkF4ZjZaWjZtOXZQWURXUXhhTEsrSzRIcUozMisrdWFYcHBETlAv?=
 =?utf-8?B?VzNWcGJIbjU4YmswcnFjcjRrbFRvMlhaOFprZnhDUE5HS3RoQkhmaWFJRmJo?=
 =?utf-8?B?b2ZBN0QzNFYxWVBzWjgxN1NHRWxsanlVYWV4SEpCY3FWMnQrWGo1bTNFaVNW?=
 =?utf-8?B?Ujc5OVR1YkJoTExDaE4wY2xyeTZMZ2ZJNjYyRC9rK0ZWWXRmY0t0Z3FURWp2?=
 =?utf-8?B?NHVQTGo4YVJOdDE4aldMRjJPZEhCUUVuOTYvYkdDYkQ1aktQem5uSFRtKzA0?=
 =?utf-8?B?RkM1RTA4MzFZbysyaHNLc016dEdFNkVXdVJCNXFwaWlFVnlPUUJ2STF6UElU?=
 =?utf-8?B?ZDFZUml0dUQ1L0tOdU5OaktLZ25uZVhVaEp0RXBGbEppOW45K0FDd3plMXlu?=
 =?utf-8?B?eFV6cUJwMnF6azlscVp3OGlFUXRZWGNlMGRzOGF5QjB6ZzUyUTZyb2txbVZ4?=
 =?utf-8?B?QS9hNk5SanBUQkllT3ZUS0tzOGhSemF6aW5ieWxFUllCMWdFMWZtVHZoR1V5?=
 =?utf-8?B?bnJGYUV4eXMybHB6WnZRMTRDaUxUNzlaS0hxcjdMSXdkSk4zNzZWbEdqRm53?=
 =?utf-8?B?eWhPL2I4QUV1OU5tMVIrdlpkSzExYnk0djRpMlJ5bVg2NjZlemNlTnZQSFAx?=
 =?utf-8?B?Q1JaNUcvVkVsSTB3MUJEUlZXdFNJeEJKQnR5N1RVL3pjOW1UMmhFSjJaMzh2?=
 =?utf-8?B?YjMxaTFOMVh6eTk1T0RmenFnc3EyZjZQdEFBVzZwd1VBVytiK0RoVUhmQUR1?=
 =?utf-8?B?SFE3L3YxM2MwUm9HbENGeHpsZU0xelJOalBNcElLa1p3VjNBSCtJNGkvNGhu?=
 =?utf-8?B?V3lxdkZLeGxqT210U1hlOXNqeGNxUFg1aHQ2L0N5U09zeWp1emlVSElnZitW?=
 =?utf-8?B?NG0zUlVTWWgyODE0SFpyUVRHZ094ektxTS9KVjYzTlpSZWZkallQR0Y4WkZ6?=
 =?utf-8?B?WWV1bzBoNll2T0hJMTMzZ2JiTnkwc2dxRFg4TUN2aEZ1clMzaGZ3b2NKYVUy?=
 =?utf-8?B?ZFhHSmtLR2dVZnBDTDRvTHVkd2dYd212NWlGcjQwYWZiY1NFY2RKOHdHRXBo?=
 =?utf-8?B?aTRvOUhCZGtoaGhzRjlkOWh5VVROL21vcjcxcFo3UHQ1dllwNlNzelBhV251?=
 =?utf-8?B?MUlEM2tOK3ZUUENERmJYMHlaUFhGUVVVdng2ZUMrL2M4QlgzclRPWTRxQ1Bt?=
 =?utf-8?B?RmExVXFaSlU2ajQ5dkwxWllmUHVQL2p4ZVpJNk1GUGk2Z0UvdC84SytscDNk?=
 =?utf-8?B?K3Q4UGhBNlpxM1RlZ2ltZG5JNndZNk9iTDdZYThjWlQwbXVBOCt5bWRIaTVk?=
 =?utf-8?B?MzREQ2NnUWl6V0lWZWhhMFRoOTRnL3pOQmpFUTFrTFFHZmtKV3QrNEkxR2li?=
 =?utf-8?B?eXR3cDBBaXhtOUxKak43SGJIRk9YMFBEc2gxRXI4bUlESThsT2ZQb0NJdlZN?=
 =?utf-8?B?NG9IdDJtbTZSMVR4WmFUQWNicEpLQW5xeXpWK1J3bktmRzVtWVp2ZmJiNENV?=
 =?utf-8?B?UWVpWHhtYVJZYUw5MTdYK1gwUE9RblNGNEoza0RQS0w5ZmRhYVU4aERxSmhK?=
 =?utf-8?B?MW9tZVVtM0N5aEtrcHNxWGdrU0lqRTZHYnVPYmRZZmU5VHAzQkRtQ2RSZVVJ?=
 =?utf-8?B?bXRPK1Z3b2ZHbnQ0Vnl2czUxUEtyYUJKcGMrY1ZwdWpaaWtBa0JCbFlTMCtv?=
 =?utf-8?B?aFNmR2xLQXdPSFp3RkxnY2d1ZHVXeEhoaFlVN2R3VDFVLzlGTDJVTFQxS2I5?=
 =?utf-8?Q?NIVom+uZ6ratPwqosp+UsDnZDpok3yIAPQ72WKq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVVqTzJLSXh4U2o4dVBBc0ZxT1FMTmExRGZ4eTNvZEM3bFJRamQxR0xGVU1x?=
 =?utf-8?B?Y3lOUDg0NTE3ZlpPKzhMTnZENDFCb3dDeWxzUGlzNDdDY1RsT1JoM29YUUxh?=
 =?utf-8?B?Q2hnbHBvUkRxb1ZQaHp3d2hRWnZSLzUyQXc1dWRwSFNWN2E3ZFhtbm5iUW9E?=
 =?utf-8?B?MzhoV0FheGFjczRVaWtUSjZEaDFJVjhyZ1luTmhPeXNyUmNpNlNrQitWSHBQ?=
 =?utf-8?B?U28rYWg5WmFpYzYxM0UyczQzUDlLOUxGZkNoRlpSZzVnSEdYdHgvQVRpRHNi?=
 =?utf-8?B?UDEvaHQ1ZmxtMmhoLy9kV0ZUK05Rc3Bma3QvZGdOdUo1MkR0T29GOXErVE83?=
 =?utf-8?B?dkxMVlpMdmh2OHhXd3N5d0tiR0YydEs3VC9qMmRlUVkzK2pUY3Raamx4aTRo?=
 =?utf-8?B?QVpkenJuMjRUWnB6OG5yWWx1bmtobzRkZHpTeUhra2pSQmtNUmJ6c0NnSWhw?=
 =?utf-8?B?eWJFcGpLbDJ2Ykc2TnpxSUk0cmUvbDdwVnJxRkFLTWdmM3J6UUlBb0ZGTGZ0?=
 =?utf-8?B?aXBneWxnZGFWdDQ5SHJueWN2bTBBeWk5dUVuRU4xL0hwUmk1TjBvS1o0N1Ru?=
 =?utf-8?B?V1FmNEVJay9NVlhBU1llRjVhQnlvazVnN2pJc1Y4UFJMd3g2cHRIekpIVTRw?=
 =?utf-8?B?RnhYczQybnhWbXl0QlowV3ZUbXdRd3hHaFJmK1pkU24xWTN2eXJYZjlXYXB4?=
 =?utf-8?B?cDBrdlJZWVYwOERrZDROS0tOWDVsamNacFRyRFFOU3I2YnJ6TFlCbXAyWGh5?=
 =?utf-8?B?bHlFNjdKdzJsamd6Q2pPdEhBWjBYSFZvK2d1UlV6dnhOeUlwWkNZWVhmUmRX?=
 =?utf-8?B?TUxWdy9DWEFQSzZSRHJQaURTSDhkYzdmSXVKU2owV0F6SGU1OUpGRmVMbndt?=
 =?utf-8?B?aEJTc2JBYVZmVGVjZG1GNCtHZG5PR2k5bUNxKzN5T21ldnVlZ3JhczdEYTVD?=
 =?utf-8?B?MDZxNDVSVlNkN2I5NmVCbm5zclJVKy9FUjc5L3cyVG5zdk9oM0w1Z0dXNVlr?=
 =?utf-8?B?QkJuRjcvK2pMejFoWnc2ZFhPdFRzU2lxVDlmRTU2NlNaUG15K0tCanhZeExF?=
 =?utf-8?B?ekxkYlRMa0R0dTlYSG0zc2hLRXl3UEhWeGExaXIxc3dZMzQ2WVltMm5kZDdB?=
 =?utf-8?B?ZEVCZE5aeS9QQ3RxR29uSSt4emtOSjFVdUlOcGFCOXFkcnNWWXhKa3pYOGk3?=
 =?utf-8?B?TDh2Mjh4TVRiak9uL2QxZXorNWpBN3dmVFJNdC9UQWJnQVNKVi9JcnZhOE1z?=
 =?utf-8?B?RXROQ3czK3lSSjljRk9kalJuamJyRk1hdVpMNkJJdWVQWGhsa2RZT0s5T25a?=
 =?utf-8?B?eTlQV3JMNDMyZWpxNEtGdk5qTXFxMmE2TEhFMGUvSklCNTRYNTBIdUJibkJK?=
 =?utf-8?B?cVlOYmNBdSt2V0ZGaWU2T0REbjNGanBUQWlqYTlWdFNnZU1BQ0FQVXhPMHBQ?=
 =?utf-8?B?REx1VTdpM2dJODlJM3YyOFEveFR5OTJUQ2lLT1dud3pRRHlQT1haRmhKYnE3?=
 =?utf-8?B?OWRrTkZsTlFadW1hZkdkeUN0ZjVUWWVhUkxZUkNLTzZvdktqMXcydjJDbiti?=
 =?utf-8?B?L0FvdlNUQ0lINWg2Nk9pb2JiMFpLQkhGZjZpdVQ4YlJmYWJHbVdTcDEvanU5?=
 =?utf-8?B?a0JRNkZqdithZ3d0eVM0ekFiZVBXQlorK0RTWDVJTmtLVDdtQkxEV1N3QnMr?=
 =?utf-8?B?MWsxV3lxK3NqVmtFYUtFbWdxNjFrSXp6eHJmQWhsOUpNYmNjYm42TTdDUG9O?=
 =?utf-8?B?ODhPbHI0V3huUEZPaEhCcEhwRlVDcFQ4KzJFVEFLY0ZaSEFuOHRmRHgxd0Nw?=
 =?utf-8?B?VGJxT1VWZk1Zd09yelVNTWZVVVhrWUt6ellDc2ZtNStuZlpFZ2s3ZHpjV3Mx?=
 =?utf-8?B?UFZnQ05ZVU9DcTdKOHU2V3BuNC9vaHZEekxpcThoaUhCTGphNmNBbXdyMXNY?=
 =?utf-8?B?d2hVdWIxSWV1Z3dabVBMZWtBcUtTWDJTQkhablNaVFpORWgrd3lHc2k0RmVm?=
 =?utf-8?B?RlRaakNKdlVURk1xVndCM2FPd0d4SmYzelBzNjFGN1h1T2lhcGNBUW5NTVlD?=
 =?utf-8?B?SGxrSzNPdTNnVGZHS0NyK2NRRjVuY3RRTkZnQ2xad1FLWnY4MUdDc2pHRDhh?=
 =?utf-8?B?MC9UNk5nZUswak40TSttVUNCOEhoTFlia3JueTdHYURpU0NZcExJa1QyRU5B?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bebf791f-f0d2-4ad2-4791-08dc8ca1500a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 18:39:24.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBDY2vlS+ybj3Wr82AE8c2Oy9LN2Q/VZvmWf/Ymf4RGqL0oTP2OYrJwJuusrZpctxyBpJuOV9TmrS1UrBvJ9K8dQcLnLMh+89PcY9LMnXlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-OriginatorOrg: intel.com

Hi Babu,

On 6/5/24 3:45 PM, Babu Moger wrote:
> Add support to read UMC (Unified Memory Controller) perf events to compare
> the numbers with QoS monitor for AMD.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v3: Made read_from_mc_dir function generic to both AMD and Intel.
>      Rest are mostly related to rebase.
> 
> v2: Replace perror with ksft_perror.
> ---
>   tools/testing/selftests/resctrl/resctrl_val.c | 80 ++++++++++++-------
>   1 file changed, 50 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 23c0e0a1d845..ffacafb535cd 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -11,6 +11,7 @@
>   #include "resctrl.h"
>   
>   #define UNCORE_IMC		"uncore_imc_"
> +#define AMD_UMC			"amd_umc_"
>   #define READ_FILE_NAME		"events/cas_count_read"
>   #define WRITE_FILE_NAME		"events/cas_count_write"
>   #define DYN_PMU_PATH		"/sys/bus/event_source/devices"
> @@ -128,7 +129,7 @@ static int open_perf_event(int i, int cpu_no, int j)
>   }
>   
>   /* Get type and config (read and write) of an MC counter */
> -static int read_from_mc_dir(char *mc_dir, int count)
> +static int read_from_mc_dir(char *mc_dir, int count, int vendor)
>   {
>   	char cas_count_cfg[1024], mc_counter_cfg[1024], mc_counter_type[1024];
>   	FILE *fp;
> @@ -152,41 +153,56 @@ static int read_from_mc_dir(char *mc_dir, int count)
>   	mc_counters_config[count][WRITE].type =
>   				mc_counters_config[count][READ].type;
>   
> -	/* Get read config */
> -	sprintf(mc_counter_cfg, "%s%s", mc_dir, READ_FILE_NAME);
> -	fp = fopen(mc_counter_cfg, "r");
> -	if (!fp) {
> -		ksft_perror("Failed to open MC config file");
> +	if (vendor == ARCH_AMD) {
> +		/*
> +		 * Setup the event and umasks for UMC events
> +		 * Number of CAS commands sent for reads:
> +		 * EventCode = 0x0a, umask = 0x1
> +		 * Number of CAS commands sent for writes:
> +		 * EventCode = 0x0a, umask = 0x2
> +		 */
> +		mc_counters_config[count][READ].event = 0xa;
> +		mc_counters_config[count][READ].umask = 0x1;
>   
> -		return -1;
> -	}
> -	if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
> -		ksft_perror("Could not get MC cas count read");
> +		mc_counters_config[count][WRITE].event = 0xa;
> +		mc_counters_config[count][WRITE].umask = 0x2;
> +	} else {
> +		/* Get read config */
> +		sprintf(mc_counter_cfg, "%s%s", mc_dir, READ_FILE_NAME);
> +		fp = fopen(mc_counter_cfg, "r");
> +		if (!fp) {
> +			ksft_perror("Failed to open MC config file");
> +
> +			return -1;
> +		}
> +		if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
> +			ksft_perror("Could not get MC cas count read");
> +			fclose(fp);
> +
> +			return -1;
> +		}
>   		fclose(fp);
>   
> -		return -1;
> -	}
> -	fclose(fp);
> +		get_event_and_umask(cas_count_cfg, count, READ);
>   
> -	get_event_and_umask(cas_count_cfg, count, READ);
> +		/* Get write config */
> +		sprintf(mc_counter_cfg, "%s%s", mc_dir, WRITE_FILE_NAME);
> +		fp = fopen(mc_counter_cfg, "r");
> +		if (!fp) {
> +			ksft_perror("Failed to open MC config file");
>   
> -	/* Get write config */
> -	sprintf(mc_counter_cfg, "%s%s", mc_dir, WRITE_FILE_NAME);
> -	fp = fopen(mc_counter_cfg, "r");
> -	if (!fp) {
> -		ksft_perror("Failed to open MC config file");
> +			return -1;
> +		}
> +		if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
> +			ksft_perror("Could not get MC cas count write");
> +			fclose(fp);
>   
> -		return -1;
> -	}
> -	if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
> -		ksft_perror("Could not get MC cas count write");
> +			return -1;
> +		}
>   		fclose(fp);
>   
> -		return -1;
> +		get_event_and_umask(cas_count_cfg, count, WRITE);
>   	}
> -	fclose(fp);
> -
> -	get_event_and_umask(cas_count_cfg, count, WRITE);
>   
>   	return 0;
>   }
> @@ -213,6 +229,8 @@ static int num_of_mem_controllers(void)
>   	vendor = get_vendor();
>   	if (vendor == ARCH_INTEL) {
>   		sysfs_name = UNCORE_IMC;
> +	} else if (vendor == ARCH_AMD) {
> +		sysfs_name = AMD_UMC;
>   	} else {
>   		ksft_perror("Unsupported vendor!\n");
>   		return -1;
> @@ -228,6 +246,7 @@ static int num_of_mem_controllers(void)
>   			/*
>   			 * imc counters are named as "uncore_imc_<n>", hence
>   			 * increment the pointer to point to <n>.
> +			 * For AMD, it will be amd_umc_<n>.
>   			 */
>   			temp = temp + strlen(sysfs_name);
>   
> @@ -239,7 +258,7 @@ static int num_of_mem_controllers(void)
>   			if (temp[0] >= '0' && temp[0] <= '9') {
>   				sprintf(mc_dir, "%s/%s/", DYN_PMU_PATH,
>   					ep->d_name);
> -				ret = read_from_mc_dir(mc_dir, count);
> +				ret = read_from_mc_dir(mc_dir, count, vendor);
>   				if (ret) {
>   					closedir(dp);
>   
> @@ -250,8 +269,9 @@ static int num_of_mem_controllers(void)
>   		}
>   		closedir(dp);
>   		if (count == 0) {
> -			ksft_print_msg("Unable to find MC counters\n");
> -
> +			ksft_print_msg("Unable to find iMC/UMC counters\n");
> +			if (vendor == ARCH_AMD)
> +				ksft_print_msg("Try loading amd_uncore module\n");
>   			return -1;
>   		}
>   	} else {

Can all the vendor checking be contained in num_of_mem_controllers() instead of
scattered through multiple layers? There can be two vendor specific functions to
initialize mc_counters_config[][]. Only the type setting code ends up
being shared so that can be split into a function that is called by both
vendor functions?

Reinette


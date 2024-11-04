Return-Path: <linux-kselftest+bounces-21411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C6D9BC0AF
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 23:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99372835F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 22:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0231B1AC88B;
	Mon,  4 Nov 2024 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLBQRA38"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA422AF12;
	Mon,  4 Nov 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758577; cv=fail; b=oOKZASFIc8sBTn+F8PtXJJgcbb3Gw8RYEp/FaFjWl1YthIKT77mjHpqMs1XqZEEJ+v3tv529qaXa9bEbJHqYd0AuHPOz8AP7Rjv71l3S8ArK3IfAgaviyl9ZHZlPs/L3Pgw9bMKxPq/0iQSBV3tESnxQmcodfl83zYVka9/nSY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758577; c=relaxed/simple;
	bh=Bh7KP32ml9I9nNdx0HitZ7u9WoLTyKbjctHyWszf9Hs=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lbbxPvgWK7SqiIVI304B4LrPSPx5Fpr5Ij8NJP73kkN8VYntwpnaPi7WGfrjtfLl21tPoIW5S7kvzZULP6xIbeJ20kS+9HAsDbJ5hrIgiTNt3VSeQSGeGhHwUZxBmGkQGYtYwJAUAS5PG0aIg4Jzwkz7LkxGLRFVLbU6/tlyzts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLBQRA38; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730758576; x=1762294576;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bh7KP32ml9I9nNdx0HitZ7u9WoLTyKbjctHyWszf9Hs=;
  b=QLBQRA38ZCjj2Y7mu2EaWtvTQwFfnNU/zciz4AOvW0rR3sOmo4zIq7TG
   2T6b4Bo6tp8eQAgbz0W9IUFv1apz4HsqzU9RYZQDsQA9K8TIMbP8WXOgS
   maLkRbrUf4gLicp8NNdERkahh93Dbgj1qBjiZZkKOyAg+CyCZcGqv1tcZ
   K+tnfVWPGmmNAhTplehehdNGTtgVL3A6NBZPZAMM8yKdFoEHV9KmZY+oX
   1DNFivwZIiIk+CnN28EI5Wvh8HUzeUXrxs8HlRdR9KkFHHjP+F/iq8qMp
   rJevV1qG/b9ICtqSr72LlI0u58DdhL08IMoDRBZlSETBGSd1X56k1mj+i
   w==;
X-CSE-ConnectionGUID: pt4tAh1KSQWe0LmBXh0WLw==
X-CSE-MsgGUID: hdMITgnOQU2wX6NQpNZ4Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29905513"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="29905513"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 14:16:15 -0800
X-CSE-ConnectionGUID: lUE/CraKRz+ZRvWl2hRGww==
X-CSE-MsgGUID: LEB1hTn/Q7mXObkD0sI2zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="114572539"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 14:16:14 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 14:16:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 14:16:14 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 14:16:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXRh7O+6bEsngojlB9h0fvmcnW+S49021Ouy/WAXlmL/7E/Pzm8Q0KEDL2qwYEkM9dbqLHQx5lw+zUKwtwwCmcpPWAw17PLPIZox0XmyeLhVzOi/LqKfsiN846QYZgi5EwGPCPnanZPKmAHSsJ61xbcKLSLlv18VRkxrRs3ydXWLGXsE5AYROgB2gEaeOSsCRtrv9iZAAhufCTYH85c6YfLn4Xzi3gK+B+qRTPlLgo8ifOBEf/FETtsQvj3eIvqafZ/aDZlLns0dFsMmyH2dY9Xs6WFgOaEDUeCAe+qrdQbBxI3gkiYEcalw05D4q+JrTduWbZa4HjcpK6BHWm+WTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez5++fuVO/XU4BKJ0WZRT9Cz0fv9nyF8lReMPUARi2A=;
 b=niXHdAVyqzHcevwaDAGtiGHdNFHXJfK7xkFf2mBRIOqo12TkZgbeyXPSieDhiVqNpjBRNw303FYd97dnWLwb12j0ijBw/GknYhG6Bl32jfOV6yrW7ENrRSSNQ5Vlqy6I5gRLi0qI6OgNIbW8T44AqXvOMxISMdDwfo0bDGEz/rF8ndmx+hAiM/w38d6/7t2CQAu5qndWC5uBFni4yLO7YtkMYcmUv3jf+pwRzLfsVzkYCIsmNINORqiLPZbupvIuT/jsPGkCZwaBhWhzRr24QcsfZEzhUHQo8BMfoZRAFeAxKRVXIBF4uZPX4eA6adZbw93XJKt1+BcabkvjIIn66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by CYXPR11MB8661.namprd11.prod.outlook.com (2603:10b6:930:e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 22:16:03 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 22:16:03 +0000
Message-ID: <5b2b54b8-77fa-4ef9-aa08-549cab91eb32@intel.com>
Date: Mon, 4 Nov 2024 14:16:00 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH V4 00/15] selftests/resctrl: Support diverse platforms
 with MBM and MBA tests
To: Shuah Khan <skhan@linuxfoundation.org>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>, <tony.luck@intel.com>, <peternewman@google.com>,
	<babu.moger@amd.com>, <ilpo.jarvinen@linux.intel.com>
CC: <maciej.wieczor-retman@intel.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1729804024.git.reinette.chatre@intel.com>
 <aa643c9b-8ce5-4cb1-98f6-645224aafdf8@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <aa643c9b-8ce5-4cb1-98f6-645224aafdf8@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:303:6a::28) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|CYXPR11MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 134af439-b296-499e-b7e1-08dcfd1e44e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFQ5c2JEUjg5anU4M0JQWE1wVjlxeG5hSUhYRGlvQ1lndGtSejQzaGowdjZ0?=
 =?utf-8?B?RXpHb1pmQkVwYnhIL08vcFUwanVRRWFoV095cXBObEx1K1FXWDhOZXNrUlpI?=
 =?utf-8?B?RnlVNzVwWk9FN0huQ3VsMHR0VFJwcWtkZzJUdC9qUzJMWUdnejZhZGw4UXdB?=
 =?utf-8?B?NTJBUW1qZ0ZvOU5sdkVOMUtBRXFwcGR0Tmx2NGVxUGRDdENuWXJGYjEwa0tp?=
 =?utf-8?B?S2NsWVVBWDR0U3phL3FiZkZKVms4TnZjSlE0eFRDM01jTG5FbjUwVFJiQmty?=
 =?utf-8?B?eHZRUkJheU5kKzZnTXF2N05ZRlBFS3BVNEU5VE8rUklhditMMitIWktjdW41?=
 =?utf-8?B?ZmU1YmR6NVpqL2ZIVFE0UGEwWmtsUGRXVnNGblZJaGh1UFB6T1dMM05mVTNu?=
 =?utf-8?B?TTFqbmg3WlRTajRsL0psRGdETDYxM3Q1V25GMGZvQkNwQkxpQ2d3RXJpSmJv?=
 =?utf-8?B?WW10MVRlMUtPQXZGbFhseEVCdjdiUUdhS0JzdmVJc1F5UU8xbWNKcmZEV3pZ?=
 =?utf-8?B?RWpXQld3NHFNdzBpWVI2bHFoU2JBR0kyOS84NGdiN2RHOExVMlJSbnBXVEdz?=
 =?utf-8?B?ZzJjaEVXRUpmK2kzeTFwMEROYzFuM0dMeEpjSUx0NS93U2t2bDFkbFZLS25z?=
 =?utf-8?B?YlBUL2hENm8wcVh2M1RZZnp3d3Z3UmlnUFZ4T3JvZG9rbldheVgwTW5RUC82?=
 =?utf-8?B?Y1pIeVMyY1lHNC91Ym9pcWFUTWlEVEJtVkFvM04wZWVxano4ay9mRCs2QW80?=
 =?utf-8?B?Qy82S3IzdnV3cVVtNUtZZFZXa2Y2Z1pnOUNEcXliR3dPVnI4ZUMrdzdEdC9X?=
 =?utf-8?B?UGVKSFdZNHB1K2RSSXJOWm9xTWx2S0ZiUXc2V2hZdFJhTTNuVEFHS3VjVzVU?=
 =?utf-8?B?MitIVVRiM0hmSnNuOFcyd0tUcEMrWm9ZSmJHblJhK1Y5WC9BWTRaNjdhS2gz?=
 =?utf-8?B?QkgwaDlSS0xsM24vRjhjV2R2YzQwd25GSlB5UXYyLzZkdThXNXpxajY3U1lV?=
 =?utf-8?B?SUYrTWtHSnJ0clJZc3ZORzNBMkUxUGtoWEFhRnJKOHRMSDROTUpiUmV3NXM2?=
 =?utf-8?B?TWxsREgrZmZOTFkvT01qWWNNa1VObXN1NmRjWUV5dVFhcjN4c3RBQXUzZUtr?=
 =?utf-8?B?MU9xZ21PMWdRZEtEdXRIQkhkamczNHAvZUQxdkJBUUR6UEUwNy9PanV3ME5V?=
 =?utf-8?B?WTk3MUNKeGtBc3JlOGNTVTNyZVdxbUZ1ZFdKVHN6dnNCMk91Z1I5Z1pmV09m?=
 =?utf-8?B?T2tSL0pUekVnblIwa083VjdSTWFaSXF3NFlkY1hkb1hsd2pwTEVSV1JBRG5Q?=
 =?utf-8?B?RHBCSFhUY1BkQThMN1NhTndRNklRa2xHRmtjeHBmeFBJMmlhOVZRemxod2lO?=
 =?utf-8?B?TkFkN3dobVgyVzZOODJvZXN4VXdFaEdoM0FkWHZNeld2MEFXQ2VPMDlHWVJq?=
 =?utf-8?B?YWg1STVIWG5NVkhPZWZ5YVpsTDlxeFN4WE04SW9nVkdYZHBvd1FRYlZWdUs2?=
 =?utf-8?B?anhpaFBpRVpITTQ2ek5OblN4N1V6RWZ0R1ZYbGV4Nm4vSzhhRDF1UWZoOUY1?=
 =?utf-8?B?ZGIyOVBmcVR0RnRRd1dqNGpuajBwWGRRNVgvcld5ck9LTUR3REFjQ3Q4YUF6?=
 =?utf-8?B?TVJDb3JFcFBLL2JTWFppOEFnazRWaFIwRHd4OUN4eU5rTit0NzJWMjVOQldF?=
 =?utf-8?B?TllYVmFGek1EdHNvSzExb1htSnlPZHVsTVk2ZTZKVWNBaGdRQWltZjF3MzFj?=
 =?utf-8?Q?8mPahv0OLp+CX82ygXl+ILXgeO4KEyjiKx9HoHC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azhad3duVWxjZ3ZZaTlCWHR6cS8xMHpLeVkyYnJseW9GSHhIK04yVUs4bldS?=
 =?utf-8?B?MDVxVGI1RTJZVGZXRkVmM0JqMWllNUhvU1FRemxNQ2I1YVhXV09pK0g5cm5X?=
 =?utf-8?B?bjBMdlUrdjNmT2ppYkVrdHYxdmc0OUxYeWlwdDFxSW40WFJQcld5aXpHREhB?=
 =?utf-8?B?TXRaK2lGcWlaalI1ZHo4NUFBR2o2dWdtVlZNSlR5V3JVNzNJaUVmMDVIYnA3?=
 =?utf-8?B?eDlzYy9CVzhicU5zaXV0THRJcmlyVitERnlLWXNzM0ZUWFo4K0krSGZtUEhu?=
 =?utf-8?B?MVYxRFFJVW44UTlRelgwUFlSYmZXcmM5WEI0L3E5Q1lsUkFUR1RSR1dXc1oz?=
 =?utf-8?B?VUVJeUpVZENSMitwU0Rtc3Z1Wk9TY0NrZVAzK2tjZVcvaDBac2xrQXA1c0Iw?=
 =?utf-8?B?c2ZyTVYxWFEzNXNjTm1ZWWIrdGlobWNRNmJpcHNWeVdndGdIQ3BZZGl0S1lz?=
 =?utf-8?B?SGRqUytzaHIwL1JSZEppcGxDTll4UW85ZDJCWkN6OFNNZTVXOWJDS1RWanMr?=
 =?utf-8?B?M2xiZGJCNjFRRjNoRElpZE41OW1ISXlJRlR6bkhBOUVwVnhJbUdxZ2VZdVRm?=
 =?utf-8?B?bXdIUEZXRlc1M0ZTMXRJT2ZlN21idll4bmQ5cU1oQmc5SlpIVlE1cWFmSTI4?=
 =?utf-8?B?RFUvWFdsVy9rTE1ydHRLMDhEQnE1U1p1aGczYVoxczNBWFIxMFNwODJydWx5?=
 =?utf-8?B?WWlZUzRPTGhzMi8zcDJCekZuN0lwNk81M0J0Tmoyb2hiWWwraTNGZWlSQ3gx?=
 =?utf-8?B?aHpDblUzRXp2dmt2K3ZsMWwxYmYvZ3pYRU1aa3hpY0Y0SnVLaEF1bVp0clZ0?=
 =?utf-8?B?L05keng1RTVvREdHY1c5QWVYdWY1SWZhaTZYU2pwSnU4NTZXZ2ZCMm0yUjlX?=
 =?utf-8?B?L0JhZ3RJREhhTHlxKzhKdWxuaXFxUDZQWnNYM1dzY3RxNmpTSWtzYzVHR1p6?=
 =?utf-8?B?RUI0R1lJTTkrazJrODB4R2ZnOHdVY0FGTkdaaXg1WEpaTDczRGdVaWFldGVo?=
 =?utf-8?B?U05xZHJhYUNoQThwNkJQcHh3NFZ5Mms4RkRCVkdHWU9kUUhiV2pHSTdmbzZl?=
 =?utf-8?B?T3UyWXAvc2J0ZU5zT0RYV0loREVUUEtoU0xCNmhweXlCM1F2MWlKTndRQ1di?=
 =?utf-8?B?V2xZOTZaeFNhZ2toK01jTlRTQndaOG82dWpqd01EcFFuM3dYMkFmZWtXcFhz?=
 =?utf-8?B?NU9OYjBvNnh2QXQ2bktScnp3MUUvN3ZybU94WnF5c2taaHQyU3RybmptTDBq?=
 =?utf-8?B?VjNRY3h3QVF1TXArcGMrZ203MG5sb0g1OW5sbGo2QytGY093VHBqclY4SzVR?=
 =?utf-8?B?R3VGMXNoZ1p1N1NqNlJGa0hBd244TXdvREU2YXRuYXVEMmVZdUJqQ0RJNmNp?=
 =?utf-8?B?RGFndi9iMlBMZ1ZhS0JoVUJmR2lTOXgxYWtEVGhoTnZpcXlJajFlQkJocGM4?=
 =?utf-8?B?b0NGWXRxdTR5UFk5RGptUEN6MmE1VWdLVENydDZobGRZdXhCQXo0ZkdmSVZM?=
 =?utf-8?B?YWpPSVcxWUtXeEZDeFVGeGJTYlZHOHV4RXRrMHowQzBaTVdscnBWUlpBTEZX?=
 =?utf-8?B?MFYrZDMzajRtMkJ0dzFLNVNxVVl6WGJaSnVaR3dlMnpWVjdVNlk3S0w4RW1a?=
 =?utf-8?B?NXB5MUhkUTAwZTBjQThDYVc2Ly9DakNFWU9NeU1JdHlSRCtSMnNjZHpRNjRJ?=
 =?utf-8?B?eGlSdXh6dEt2VXl2TXdEVVJPRmxxR1J6NzVJOW9yaHNUN0Mvb0ZNRG1qN0Ft?=
 =?utf-8?B?QXI3M3VDZTQ1eFZtMkR3Sy8rbHVrNCtNNFdPTFRuVDhyQU0wUzNQSGI3djdV?=
 =?utf-8?B?UXEzUURQTFZQdlJOaW5lVUxjRWFoUndhUzIydkplM3lPdXhpQ243UFlBSE9t?=
 =?utf-8?B?TjlldGZaQmQ2MjQ0N2NGMEJkK1ZwVm9XYUV0RVpwOTg1Vzc1eFJmc2RjQ0lK?=
 =?utf-8?B?Mkk3NEk1UnpwNTVWbVZLbjhobUplbDN1NFFXUEJ5c1IvcXNMbTZZVThKQXhi?=
 =?utf-8?B?dDdGRjhhYW5xbnN0cjd3K1dZRlg3ZWR1dmtRcGFXY3JPaXF3SlNHZmFVZTBM?=
 =?utf-8?B?ZXdEM1JqaG9yVHdWUWRpdlpDWVBPd1lnbGs0cmtUQ2R5Z1Z5VlQweHR1UGpZ?=
 =?utf-8?B?VUkxT2hQdGRaTkJJbW4xa25NM0NibFJ5dXY3Q1hVcS9tOG9YYThudjdwdjZB?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 134af439-b296-499e-b7e1-08dcfd1e44e7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 22:16:02.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ut4JWOV1LqQ8LbH8YO0zXxqK4F9a03RmpGLH7/2ctXMCL4CLAwgKpTpkU+4YYiswoiZoHad4FbYMoYbifV53CpfN94DR4H8VwpNJPMwzaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8661
X-OriginatorOrg: intel.com

Hi Shuah,

On 10/24/24 3:36 PM, Shuah Khan wrote:
> On 10/24/24 15:18, Reinette Chatre wrote:
> 
> Is this patch series ready to be applied?
> 

It is now ready after receiving anticipated tags. Could you please consider it for inclusion?

Thank you very much.

Reinette


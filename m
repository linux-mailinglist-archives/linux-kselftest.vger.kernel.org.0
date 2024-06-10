Return-Path: <linux-kselftest+bounces-11603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D71902A99
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 23:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD6E283A3A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11398149C43;
	Mon, 10 Jun 2024 21:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWEP28Zp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F274BF8;
	Mon, 10 Jun 2024 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054897; cv=fail; b=YZwcii3KXYmX6oqZYQuuPHjW5Z4PzeNVik5R8yneKyeLREgaACzM+3edgKrzIPovU6lHMa9q05cdF4rnKnw0f4242snkS9yBmd4BuDYntKkH/uocTqB8i78rEyU987nOevNGYClr8aWYZgDBkN0yONwoKPKKEX+XIsVE/6Gptdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054897; c=relaxed/simple;
	bh=j1xFeU+f5Uh4NIU3swKMyroxZJKJu5Yd9Gj1X4ydRos=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UN9f2Qg+IFvUKO57jsWwzRP+rnlvJGcoJIfd7Y3uJ9rPrAeKZ1j6usud4JmA/pQN8rkkWWYiJgUg80lBqbx9imb7FpssS2l2h7spaNzOa83oW7QDFua9QYrpAVeBUTfEAU0Les7v6qtbhFoQxjQ/95AafQ9qbkx/DcBBKyPcsLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWEP28Zp; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718054896; x=1749590896;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j1xFeU+f5Uh4NIU3swKMyroxZJKJu5Yd9Gj1X4ydRos=;
  b=FWEP28ZpxS0WfGg34w4REbWMFT2HiI9vnPOmkVesv+knSZ+DcQKh4bXy
   b1R4p/xPjs/4L05pxsPHLK66TkaHcEAremf4PDP5Dmrf77/WB3WjVoqpP
   7fF399n9k3vsAZqrA/5+rFHQRswhAMH5QIIPRsc2S7JmCW4DsVQAVhA+n
   fD7HlvHgr5Kv7eyY/CSgO/+fcC8eX+jHMlML90RaOLAWtAUW2jMHAxr2I
   D+ZgStPEL70POYjzOynYTpV9ZV9KY5CkOGZz5ezDnP0pG8NSmSwdiN85R
   zdAqRoiY/L6qVY3H6x7+VaqQA8Z+CWSZjcWD/Npo6Jtv5sQ9zOlDc79w4
   g==;
X-CSE-ConnectionGUID: bHKMO9UhQz2QeTXhKmsJYA==
X-CSE-MsgGUID: ACQ43efNTQq/fmtdInSXcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14536081"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14536081"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 14:28:16 -0700
X-CSE-ConnectionGUID: QdIjxZjHSMCUYkpUFOAG3Q==
X-CSE-MsgGUID: SP8Up+UKQ3ebNBwRjXPQ3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="62359630"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 14:28:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 14:28:15 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 14:28:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 14:28:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 14:28:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afgzx8bwmNfQsJgoj18+dxIP5F6FYBfGs8kZCAmydahag+1Yfy08DgawPkMp3+KZjTqRR84McEGE/q3DgAQfs57eWyr1YSv80juzz0eGJW6H/77MuYuu4pHS1XAeztH8Wz1E/lhGRAhy0la6UX0Fhw/neWqTCK5pgAQ5xdLNyjp54Ezj7nKaGs7jXQdyVjBt3doca19BqogBzWcFVHQVwbzB3SHwhTpLuV3jaRn5u4OQ1oROFAGsL6UIL7bBWd9mEiBrt0996tEjOjzxo6LcAt3WnZFox4V/qtmIKmPRRRBovq6rYOZbddcHyxYBPcfYp/FI+9QpjmW7xvy5DKliMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NIq7tvRBBL937FzgUXW4uBnU1f5ZI22zSkDgtJJhwg=;
 b=R1NWpr87Um0VWUJy5bJ+ZSJlrkTVDD2AZUh2lPQt8YCkKfL/78higQRFZqeeXWqk0gIo5go/MOzPEp9REmfrGUVrXleb3GeYTh5B8ucp8sDnTbVyEKu3HG/Ga8ErcA5ooGbOLE2nrnv3SaDuc4pj+9ATKK2+oAl+XhITDo4PPzXHZ7csA2FBkRiGHf3ZOSQ/0ZwaHC9MzzGypZvLAc8tiyBspOGJ9gNDFqjnbu0db6MS/WD5eXTjV/6BqNYof5Qiu9+HJvZ39WkAoqfvXTjMxVidPzD+bIUt5GAV29PMpBJXkqlKm9h9jjq8ZjnicQsHFhJc2Z0YWGh4rfuR0XdRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CYYPR11MB8307.namprd11.prod.outlook.com (2603:10b6:930:ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 21:28:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 21:28:12 +0000
Message-ID: <399b6497-2c76-4f16-8e21-27d209e214d2@intel.com>
Date: Mon, 10 Jun 2024 14:28:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/resctrl: Fix noncont_cat_run_test for AMD
To: <babu.moger@amd.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <7679d70a0ea939db13ae9dac20de56644460d6df.1718035091.git.babu.moger@amd.com>
 <91052cec-071b-7cc7-5f85-4fa29ec2aea4@linux.intel.com>
 <0e153d27-fa1d-4c47-8d4e-a2004c991ffc@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0e153d27-fa1d-4c47-8d4e-a2004c991ffc@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0198.namprd04.prod.outlook.com
 (2603:10b6:303:86::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CYYPR11MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc63526-d1d9-4cce-22aa-08dc89943b26
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkY0WnorbkN0a2pTRVY0ZUUyNnJXcWFLRGI5dElQQ1FLNzE0VzRuZXhPb1pp?=
 =?utf-8?B?SlVmY1NZZXBja1BPdGo4U3pjL2VXbHhNMEVZcTVjSlVDNm54QkhxT0N3aktM?=
 =?utf-8?B?dFRpWTJqRjk2UWhkS2ZWZUs1M1hGczBlcEpOOUlGb2dEWDJTM1lGVndnQjFT?=
 =?utf-8?B?MitUTGJKUkFOZWFjOXlYMVVKM29VL3dJWERXVzcwVEJ3clF3Unk3SHdjUi9P?=
 =?utf-8?B?eXBzcjBMNWozY21Bc0pLSUNQK2tESjgyTG0rYlhSWitSaTR2TWdCSkR6ZlVB?=
 =?utf-8?B?QjhIbHFpeVpCNjIwdVd5Z1VMcjJGQmZUWU9jdGVaOEx4Z1paY0pZbnQzeHZO?=
 =?utf-8?B?TkFwRm84SUxlRjdrMExsU1hDUWhvWStHMWNPd1B1bUxJNzJEakE1d1VTWnBR?=
 =?utf-8?B?L0pSY3hmekZmZVNmY1AxM0dWV0k3YnJ5Y3VHRWtxR3BUR2lRY1NvVXJuZUt4?=
 =?utf-8?B?WFRWZ1d3QzAzM3pna29qeldPZFh2YXBXTUtsajJNbHVGbTRpOEJhZWNsU3B5?=
 =?utf-8?B?MjBuVkV0azZGU0txYmZQYlMxdWp1RE5PdFlYY0tVTEJTcjBuMjNLR2RJZmVG?=
 =?utf-8?B?Q3g0R3RHTHljcy95d0dpUHFWMndobmlPWmpEcU9kSzVNOWI1VG1QZzVkNlU0?=
 =?utf-8?B?TEtGaTZjOTlwZDFNOWcwUG1xQVpBZ1ZydDFpd1Q5WEhaekJuaHlqU2hDdjlq?=
 =?utf-8?B?Y2xWcGhTNE1MTUJJb084UWo3d1g2Nkl0MVEwSkpraWFoWUx5Sjd5Rk9aNGEw?=
 =?utf-8?B?Rld1cHhRZ1g5Wnl5SjFKeEpYbUtpM214KzJISnptUmVtdE5ZL0dVZ3JxbUht?=
 =?utf-8?B?NzB4cjlwUURsSGp5YmprT0RFRnh1WEFrVWNIYkFmSm5qUm5reU1teUkyMk1I?=
 =?utf-8?B?N0tEMFJPL05JVlVvQkZPRVZSZWx4K3JEdWJ1SkNlSGdOL29uMTcvUHd4QVYv?=
 =?utf-8?B?d0w5djhzQ2U1WnpqdFRiN2k3V2xMMm14elROeW0wcjFjZStha0NEbXpkMDZM?=
 =?utf-8?B?dFp6S1I3bzRDOUEzL2w0MWg3Tm1mTHJCRy81Y1BsdFZ1c3BoSWhZbUZSZytn?=
 =?utf-8?B?Y2RSbGZRMHdueThyV2o5UXdvMDZERVJ0N011U0d4WTJyWHdHVFdub2todlZX?=
 =?utf-8?B?OWs4RGxhYk5qcjZnZ0FaL2dOalRZbWpodG1LelJLbzhHUVFEWExYaktDRW9x?=
 =?utf-8?B?NHlRWGp2RGcvNVNJVDdRTHpxbWJyMTNZK2d4RitpeVIzRkpGWXRkaVVJYXVE?=
 =?utf-8?B?WnBjK2pMdEV5NW9DRy9BdUcrZkJBdUU3VzdGWXBzVEVqN3B6OUZxTmdrVjhI?=
 =?utf-8?B?L21OejRmNERWazUrREhkcHlDTnI4NGhOMlBRR0NEc0hrS0pFUnBtQzFaM2k1?=
 =?utf-8?B?Sk5kRG1FTC82NUc4QXBHUHdLeWp6MGtDK0Q2ZHIvY3BmRXlnSFYvcnN1SU9r?=
 =?utf-8?B?dURrUk9RK3JvK1hrTG1UMk4xVW1zb2FOM0FPeGFxcmlETmRsLzZwSTJSUGh3?=
 =?utf-8?B?YWswSGJMRjVxSjNleFRlRm80NlcvaExxUERpYXFnNlZ4ZEwwRUx6Ykw0UzFJ?=
 =?utf-8?B?UUFsMlZKY3FjSlBsSityMXBST0E1YVZBTnA4UzBobm0vOHdEbUJ6VHBLdmF4?=
 =?utf-8?B?YTFacGRxNVZQTklYMTQvSnA3RE42cnZXWnRtU2Znb0NCZ3p2Y0YwdTByc0NM?=
 =?utf-8?B?ZmZiM1J6WmFyWlVjTituV3V2bElXK3Z6a0VjSWFOU2ZZTFo1RkMwcXdZZmxj?=
 =?utf-8?Q?6+vOCBgb17ZG9fUckGlZGZ44jrmp/AXpRIUSzTW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmZWcjBnRXRaV2pKQytVNU1BSzJMNENBMG9xV2YwN3BjdzR2bmVRd08xV2k3?=
 =?utf-8?B?ZUhqOUVxRE5rZGhRWExwTEdpUStRVGVvTGM2cmxma2Zub3lkcXpuMEkvMGxH?=
 =?utf-8?B?ZUNmM1FJcUhWcm9Fb1cxQWxOWU5oaWhRY2ZPUHpEMW5JM0IvK291SnM4MGx1?=
 =?utf-8?B?Y0hUeVBkZU9sN253aGFoM1piOE9nNkdEVVRYRDFLK1dHZVFJdEM1NGplL1M4?=
 =?utf-8?B?RVRjSWJqMmZ6bVBmSTAyUWhaWVpxQVFFN1pTWUJhVmZldjNKaEt5RE1CZWxH?=
 =?utf-8?B?OHRvRHVRNlJQTVo3ODRUellrQjhHbS9XVG1NTytxbjdnVXRrNkt6bzBJdFFO?=
 =?utf-8?B?d2crT1ozbWt0Yy8vTDl6MFRRWXNWcUZmUE1oWmwwMzZxVmJ4b1BHcUpsZlhM?=
 =?utf-8?B?UElWdjZnV01GTmk4UUdseFhXOEFVUW9SRWRyQWRtb0lHd0JlRzFxOUNFQXBJ?=
 =?utf-8?B?TWFjU3hPbXBCVENyY25ONTliaVIzcXc1N09DNENrM2lmZ3VjRkkzOHkvTGpi?=
 =?utf-8?B?MlVON2hWekhGZXBCakdBZkZWejdNeXdTdHBGeHJmaVZMaWU3NGxrV0RYcVhE?=
 =?utf-8?B?THM1NTEvbzN0RXl6a3ZDWnJGNmNBZ2FIRXA0UWhHVXpnV3lFWWRyZ2RKVzF1?=
 =?utf-8?B?K2F5UkxGbVA4L3BmS2FrdnUrN29MenZRZU83TlRQMHE4cEphUkd3ZGE0Y21x?=
 =?utf-8?B?eGd5bkJndEZzMWlmbmJ5LzNwL3dTMXR3eEowYVJZT2lodnVLRGRJN1NnS2hj?=
 =?utf-8?B?TkUycFdENGR1dXJHUnJmWVhWdHF5R3BqbmhpUGdZNHBWcTBIY2h6N2kvWngv?=
 =?utf-8?B?dmVyUGlxa0l4aGpPZldnM1pJWkdMVkZBa0YwQWM3c2pRTU5MK2pOSGtwSEFI?=
 =?utf-8?B?SkZyeEZsWUIvOFRubmtjS3phVDRXUTRHL2NJOWNIQ0NzOU5WVnNRTUZPYm4v?=
 =?utf-8?B?RjNFeU5mSGE2Q0s5TWovdDBrMlI1TDVTeFF6Q1ByQzI2OTZSSEZxVnhmS0Y5?=
 =?utf-8?B?RWFlTWNMcjZlSEtrdWpWMDVDdDlXS2JqNU91c2NJNkszUmZhcDJ6RVpmL29J?=
 =?utf-8?B?VUhOT3ZJczZ1aExicEdhSjJlRVY4ZTFRcHU3TTJrVDVDZ05IcVM2MXF5bm1C?=
 =?utf-8?B?YUpmNndvY3VVd3BlMnJxZTV4SzZBVXA0OVNzanVLa0NRSGIwTThlOGk1ZTR4?=
 =?utf-8?B?SktyYVNJOHV1d2RpN244MTd6YWJmVWg2L1JxSHJTZTZMWHlXMU1VR1hzSW1H?=
 =?utf-8?B?ejlkT3NIUjAzR2QzMUZ6UU5xL2xGc3dnZjlGYVE1em41V1BYamNBWTZQeGc5?=
 =?utf-8?B?NG1DUGF4UkIvck9oWFptMVE0VVZJUk1mSTdzcE1rSlZQSk43eVVoRlV0MkVC?=
 =?utf-8?B?aGxHWjBDNmh3N0VMbEwzMWtVUTJMZUJxc08ya20xdm1mb1RYTFRQam52eW5K?=
 =?utf-8?B?VzQ5VUZTQnIyRXhpZWRXdTZmeFVBSzhZNnBDZlYrMlJHaGJhY0JxVEdEZ0p4?=
 =?utf-8?B?dUtuNHU0TG9iWUQvZDhJQ3FtL3VmSWpvY3FZbk9CeGgvaU9tOU5GSVgvbDZO?=
 =?utf-8?B?N1dvK0NHOHNkTndzbm9YcjJXMU4rL0h0OEVNbEZ5akx2a2YzNVFWZ1VYdjR0?=
 =?utf-8?B?eXNJNW01blBtckFVUVF1QmNlNTQyZ3VxZFNndnloaERsWU83aXMrZmZZMmYy?=
 =?utf-8?B?djJTeWhKVGxTc0kzaDk4TXVSOUY2TCs1TWFHRVhFdEJjSWJHblNBT3Y5SUFs?=
 =?utf-8?B?U2RJZFlXTDdVNkFSeXIxQUVLK2svWXFwamJwbkpXa01iS0JGZjlqRnhjRzVU?=
 =?utf-8?B?a0FZaGVWT2NKdWFYRlNTeTBKcU5RVUJxUFIrVVhaWll3YUFPakNSenBzeURw?=
 =?utf-8?B?UXl6ZDZmdTRGODJaM0k1NnFzam5pRTI2UFJJRE5Mc2hVcm8wT2JqaW5yQ1Zl?=
 =?utf-8?B?aUVpUnBEY1JYWXBQR0l4elNUaXpFSUlkTUpVbnk3ZU55SWRhQ2NvWWo3VVdD?=
 =?utf-8?B?bXU4aU5tMkVQS1IyWUJtQk1mR3lPV1JqNEVKcncxOGlrUmR2SWErTEt0aXVm?=
 =?utf-8?B?MkY3dU1QdVZlWXNoQ09iYjFKU0lUVW1aVVd5VitXL0pGUmw2YWdMSnlPaFJZ?=
 =?utf-8?B?K2JLbnF3WEtrV2F0ZUIwY3Y0NjJ2U1Z0TlFOanhhNDl0NmVaRHo3OWVuV0tp?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc63526-d1d9-4cce-22aa-08dc89943b26
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 21:28:12.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFw5a219WfmLp1/3Jm+iWBbtAUAXcPdJUfdy9/p4mWW5idQ312PvuKP4kStEh8w78ICF/RtLvCEX/q+5GfIt9Rig2lsstcNmhcbxxc9ovtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8307
X-OriginatorOrg: intel.com

Hi Babu,

On 6/10/24 10:51 AM, Moger, Babu wrote:
> Hi
> 
> On 6/10/24 11:20, Ilpo Järvinen wrote:
>> On Mon, 10 Jun 2024, Babu Moger wrote:
>>
>>> The selftest noncont_cat_run_test fails on AMD with the warnings. Reason
>>
>> noncont_cat_run_test()
> 
> I want to mention the test here. not function. How about this?
> 
> "The selftest non-contiguous CBM test fails on AMD with the warnings."
> 

This does not take Ilpo's feedback regarding "the warnings" into account.
I agree with Ilpo (keeping his comment below) that "with the warnings"
sounds incomplete. Also, it is not necessary to mention both "selftest"
and "test" in "The selftest non-contiguous CBM test".

You can change it to something like:
	The non-contiguous CBM test fails on AMD with:
		/* insert error message here */

	AMD always supports non-contiguous CBM but does not report
	it via CPUID.

	Fix the non-contiguous CBM test to use CPUID to discover
	non-contiguous CBM support only on Intel.

>>
>> (In general, use () when refering to a function, same thing in the
>> shortlog).
>>
>> "the warnings" sounds like I should know about what warning it fails with
>> but there's no previous context which tells that information. I suggest
>> you either use "a warning" or quote the warning it fails with into the
>> commit message.
>>
>>> is, AMD supports non contiguous CBM masks but does not report it via CPUID.

The "M" in CBM is for "mask" so  there is no need to write "mask" after CBM.

Reinette


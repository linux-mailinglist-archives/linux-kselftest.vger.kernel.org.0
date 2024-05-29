Return-Path: <linux-kselftest+bounces-10844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE3A8D3D96
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426761C227E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7095715B57F;
	Wed, 29 May 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKVfwhZM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAC7492;
	Wed, 29 May 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004713; cv=fail; b=J6HXyQvNOLp0kTvNy4hiKh7TceeNuZmybx3XKUPMNAfeXZfBGJPqdJh7Hudt5meP2+hIgz7OsazeMMQpzujFjxBpTioDLdwSGCa9m6oVOrWggA3QhGA8zIjFuR45cRoQWNkbMCa04IYN8jjMNHdA4K65YjNTSv3tovkR5lI5P38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004713; c=relaxed/simple;
	bh=AoPSpuN2dGvmV0li3spAtd4uRBrIIIz/rUo9ppy37u4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oeHdlfbEnMOBRjPJky3hBEg61Sv7b915FJlMQUwle0fIuen6gHHs66NhTUhA28OVbaxe9gAYXrfwkpxl7AG0loZ2UH5DmRBTmAEwyXPabV1Mx4Wsj4z0IAQc/7xgsZvjaJFzs8C7cqrumwIBTpiRikWm8WtSGXDQ/8HOxeYE2WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKVfwhZM; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004712; x=1748540712;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AoPSpuN2dGvmV0li3spAtd4uRBrIIIz/rUo9ppy37u4=;
  b=kKVfwhZMdeZsGMzmn4DDKW03RBs6V5AH5sQfYgWW5Hjj2BhB2auQUbh6
   mlALJNftfcD+vDKRG/Wg54myige8f4UPH4Amj8WLhLD1nT/G39gG8+6Ku
   rpm+zT32A9RMQiaDfBDmRRyG0ZduED7OaRdKyx/1G6mi6IlJrruXg4CsJ
   Na+W3zuqrQYMKwfl3LoUeXepv5/x4ip4iO7PaA1pA3jNp6O5mDxHtR0GR
   pTl0+WrvBdaUTje/8XqNDGsZExExWvPGMk9FTEaCXA6ULdMtDBPsY/Ktv
   mfMhSlDiosOojNYHBmlX2+1SLfHAtjAHBSD1sYtkWeTqiXJe7oK4UInUX
   w==;
X-CSE-ConnectionGUID: Zv6OAqL5S/uesIUJYIrwmQ==
X-CSE-MsgGUID: hpAmq7n1QGOsPw0wMdoUtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="11755332"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="11755332"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:45:11 -0700
X-CSE-ConnectionGUID: X1LP2X4NTri1JLUPSFoA3Q==
X-CSE-MsgGUID: HhXHDkO7See6z+2MCzgHpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35583257"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:45:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:45:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:45:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:45:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKJ0KU/S4vkhpRdBKzlcTpx5JgJYcQ7XHSwnu3batiI8flpU8jsizFjDOcYfYdmhMu2Bx3Hnp0ODZYQ+ESdTDdH9DcjhRNcCmvS4zzZq5I8a5UPcIg6ljaPHevpLECwD08vfdUmYatVL193HfIF2ijY7DX5Ef3kSF3w01xFQSMAyjAe8SZdhncCNeWuJq06s5n0wjNvDVnBN9rtU4S5pzLn52+vmFjLz2Bahoc/A8h4g9sKzzKFr5NNGHTAkzrXLfxSw1VIN1/t4flt/w7S3xX9pwBchCK34wInXHS6C+fw6o2ilKK13WRmmcWcJwPI8EqxpZeSNyn3cJyO+wyMwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcVaZMLcbz0YbxGD016IMHFPxIL63kckau9SOXeF9Io=;
 b=nbYEAqGQiVsH1OngK2l0+ipFPbsVyaZxBQHfANHfcJFUPtpTPbjbZor217ZW5KF2rIGMDb+Pgu8Xhb7QfMa0xQaBGrMHyMmXSyhFBGgpylWpPYE4z5tbGI79AZJGbpzNPcyHCELvVV89/e8Z0WshI4njt/DJPJzuEBnQ2kE6wBcENjWfb8cqzlidrDReZ/vu8fk/tO1FTfawEchVxD3O58Nd8DwcQMprNmqg2WJ8WjDb6UmSa0H+9KsWSncDyOzHXGyNkJgD/7qWzNuBBR20FDctD8FkyOzrc0OfjmNBdkrSejseAQjDxOcsjWezKGhRQIY9k+x5hpLpL7k5MIhucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 17:45:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:45:01 +0000
Message-ID: <358c9ac7-4a55-4aa7-b51d-be15e377d154@intel.com>
Date: Wed, 29 May 2024 10:44:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/16] selftests/resctrl: Rename measure_vals() to
 measure_mem_bw_vals() & document
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-8-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240520123020.18938-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:303:6a::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 05de695f-5a27-4f2e-8bcb-08dc800710e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWZYdkFLNjVVNzIzQnFRV1VIWHVNc3I2RmNjWnRocEpoOUdYbzRzVCtyNTZw?=
 =?utf-8?B?S3dzY1B0VHMxVlpGWUw5QXVmZmpXZWd3Z1F4Um8yNnFGblFqckNCL0ZQK1Jq?=
 =?utf-8?B?QXZSUE45Z2FNWmtObjZ4aCszV3hWVE1QaFRMdkVlK3FwM3c3RGNlNzNnSHpy?=
 =?utf-8?B?U0ZOQUNTRW9hdytoZDhBbmRnRWNLTHVMOWpkQkVmZTZmMFV6Tys3eUFGcmRH?=
 =?utf-8?B?OXMrMjU2S0w0NnZlbENDZTVvcTliWFhtQ2lLNzlGVjZ4Wm9HMEVXZmhmQnhu?=
 =?utf-8?B?a2ZSYktqait0aDdnUjZ2VWVHYlhuTE9LYXJodGNEK3BudmlqMVlBREZLVDJm?=
 =?utf-8?B?citmejYrU2tEL1hQNEF2Y0tMZFNkanljRGZROE5oVy9oVHFEc1dpZUc2WC9Q?=
 =?utf-8?B?YjRqWVdLSC9xbTg1UWxQT3Q0WDhIdG44WWFMNzJlZm5kOFdCcUdiT0hMQjlj?=
 =?utf-8?B?QTJOa2hwSnYzZnJwWFI2TW9oN0VmcmlQaE4wV0cvL2FpaWgzcGt2V2p5d0Rq?=
 =?utf-8?B?NHVCSzFZcGRCVUJqSlYreWhDODdZdmNHeEd4R0VrTWluS1VJdndJQW1OaTk5?=
 =?utf-8?B?MGJFa3I1NDhPV2tldGlmZVZrdFhCWDlMN2FidFdadElmTzF6Q2ZUWFo5QWlz?=
 =?utf-8?B?ZGY3MXZwTmJKK1FQUHU4OTJ0QVpRTFFBcWQ3bUxDN1ZDL2M5cDI5MXNsWjJZ?=
 =?utf-8?B?bDlINTQyNDB0cTZ3UlpEWHVkd3kwT01OaHdGeTBNM3RtMHE5Y2FNNzEyUGZz?=
 =?utf-8?B?N1o4a1lvOVBiS2pFaWlaQlpFL2pKc3liRXFBNVhIdUFxZE84ZjVxN09uZVMy?=
 =?utf-8?B?Y29renY2Q2psTkp5aklVQy82MTRDWCtqWXVpRFp2dVJxeUFpWWVWRktKUFRI?=
 =?utf-8?B?VytBdFkveXgvSXlBMWFranAxd1NnNHRBazA1SmdTZHYrTjFHVVZFdDY1ZGMx?=
 =?utf-8?B?cTBLODBJVG5YRmQrQ0gyWFVQMEtxUGd5VWhwMEFUNnREOWNJd2QrUjlVLzFR?=
 =?utf-8?B?RG9vZklJekZmK3k0V3RNQkNIWGtJSnRPTU9sYmVmMkp1YUVGMk9ReXd1WFo5?=
 =?utf-8?B?djdaNDFtZnpDZG5wNVFWNC81QmV2RW9yVHdYUVFObE9UcGJianJnWTF3dmlK?=
 =?utf-8?B?b3l0Mnp1eEtLTnVZVXQ2WnhrWVRITDdLa3FIUmY5ZHpsQnI1RE10S1pMaFZR?=
 =?utf-8?B?TnNwVHozV2twZDh6eENvdHBMemNmdCt4YjNkM3BhRkdIZmdFSERVZjR2c1li?=
 =?utf-8?B?WDVXcHZ3TjMwbVF1QSt1RGFXSWpZWjdXZUIyU3dUajNnMEkvN0s3Ui80N2hs?=
 =?utf-8?B?TWNydmRZRW5PRXRTTmlkMWpQVXVSZERoZDdWRHFYY3ZvaHVOS0k1TTJwSUJV?=
 =?utf-8?B?cWNxRGlhYjF4N05YVkdIaTMya2h4ZlkvU2ZqNE81enNxdjdBbURJZ05VTUdo?=
 =?utf-8?B?Y0RKTG5KN3krakg1Tk1lTWhjeXd2amZNWDBqekMwd29kWXRqWDFzZUtrWEhH?=
 =?utf-8?B?ODcvWm91OVFTamxBTnd1eU1mMXhZME83N3FWMzdNa2VvRk1jVVBFT01MRE5N?=
 =?utf-8?B?NW1LWXlHR0ExMTVYZG1KcUtkTzVOOWdHS3ZtLzFOMnZjelVlbWI2MnQzZnN1?=
 =?utf-8?B?aW9lV2NjVDhYNTBUeWgyYW51TGx2MlBucHloQTY1ZHlzMXpyRW84TC91YjEy?=
 =?utf-8?B?bWdvNjk2ZkJSeFVsVTBmMGFWQ29vVWk0YTdRL0oyNkxuV3pQaEJiYm1BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzllQUFMbVI4OW5oazBOeUM0Ry9CUGJld2xhZ0pjNmFxZWpOT2RNL0JoQ2M4?=
 =?utf-8?B?blp6SWI5blo4dnBoYUhVOGU4djNYb0hPdm1aTmxaV2wxVGlXRFZtVEFNazJs?=
 =?utf-8?B?bG1kbnNkc21QaTQrMjR1UGRINllzZmo0K3dSQWEyVEhXSWl2dGZqSDdxdnpp?=
 =?utf-8?B?c0FOQkxQNlZhc1pBVTJuNi84WFpvZmVWSGwwMzdIenBiZkU5eEIyWjkyQzR4?=
 =?utf-8?B?cTZMZDRydzlBQktrVXlrVUpiTzZYelVoM25Bd0FncmtTL3JJUUU0YzMwcVc3?=
 =?utf-8?B?MUxaK3RzUG11Y0x3UGJPc1gxbThCR0pXbm52dlRKK3Z6K0xZM1g5MUNPZVNG?=
 =?utf-8?B?OUNsaUpta0xQd0xkWVRJWW5EUis3bHB1TnNNY0lZMWNuL2gvbUIxakgvcXRi?=
 =?utf-8?B?OGRUejNKbDYrSWNjbGlveTJHVXR4cE9pelpmQ1BxdlMzMnFOdnFxdzVuZHRa?=
 =?utf-8?B?V1dhS2lpWTVqc3VaQlpEa0MwMldqSWoxcnZkTjhORUhGeFZ4YzhVZzAyaHN5?=
 =?utf-8?B?V3FFZitocWJHM2N4TGRwM045Lzh2T1lGWWxtbXdRRGY4KytLVzZGVjBLWDE1?=
 =?utf-8?B?WTB3cUVoNWNtL0hwc3lsNktZT2tKOWw1b2hrSTNKTHJ1YjRPYmJ2d0pUZSsv?=
 =?utf-8?B?OHJEOHNkZUJGYTFERVE1dVlXV0FQVDVVRmhlRGpadjF5dHJRTi9qNlpXempK?=
 =?utf-8?B?aXhHaHRtZmw0Q1k3K0pnd2xDUDVVL1F1eFprOC9oaEhSYVhNSkFPc1RBZ1FR?=
 =?utf-8?B?ZFYzQmVRMTVhZ09zdEtxRjBrcWZ0N2p5RGovNVRvd2laNUFkWVFBajFNT0ho?=
 =?utf-8?B?WHhIRS9qQjFQYVdTdEZyeWVFSW5Xem5KcG1saUtOKzJENVFXU0xYOGJRWUo3?=
 =?utf-8?B?SFNncVNFN0I0TmNNaWpBVkJjV2c3cHh4QmUzQ2Npb0s4c2EvU1NwUWEwYTNI?=
 =?utf-8?B?RlJEcWVSdFJGZ0NYZFMzT2gyNVd2ZFdkQUxxREwzSVhuMnBqbzdxWHN3K05B?=
 =?utf-8?B?ZElFK29DSjFBUXVpZ3czenJDSVBXMGJJdUE2dW1taFVmSjVoL2MxY3g4bFVs?=
 =?utf-8?B?YXFhY1g5UGRienRybmRhVlJhSGkvWDFnQmVEaUIrSWlwNHpIOEE4a09BTDgx?=
 =?utf-8?B?OVJUdURDRktlZ081NGdpVFUyNVpkbkxhZ1RYaTVoMXF6d1B5N0F3SFFNUUJv?=
 =?utf-8?B?MU1sb09RWjNEZnI5V0NRdXpEaEJVcStqV2duT1Zjc2JORllpOENxV2xnOTFw?=
 =?utf-8?B?L0w3eXFHWHJNaG9wWVpZVnhLOWVQWHJSSlR5enVSdVk3c1VCNGVGRXdCTy9K?=
 =?utf-8?B?eFZncEpQNlRFR3Z4WlZabG5QeFNnaTJDSjJQUUZZakVxMmdFSjc2NEJjY3gw?=
 =?utf-8?B?cHZ1Smtta3UyaWNJbHVUeEFYS0FpMXRZMERtMllMdmNmaVFTYllmUEJ1T2NM?=
 =?utf-8?B?Nkg3MEpxaW1ldEJsY2NEY09QZGYwSGhsaU5jamF5WmFXMi82Vk1kZWJCQlhN?=
 =?utf-8?B?Ky9Ub1V1NklabjBRNWNtdEg2UFc1UTJhYVE4U21TMVZJbEJ2UGpCVlpXMHYx?=
 =?utf-8?B?T1FQSWtjNDlFbjhOZ1lyMFFJK1ZVUFYvRUlGSXdKTzcwMlNYVlFxaWNsQTJa?=
 =?utf-8?B?VjByRzVwNm5xVzRESFVVU09aUDdvSDVOUVdDQTRBeEIydTgzYngvZkd3cTFY?=
 =?utf-8?B?UnQ1SFVrTVRQc2tHYk1OR1AxWlVlRnBWT2VIVE1tRGo3d2FzVlg2cWMrN1NS?=
 =?utf-8?B?MUFYcUVpWVBndG9YSENpY3d4SVpFaEp0MXk2bkZRaXhTaDVRdmxvOS9UWWtH?=
 =?utf-8?B?S2t2cUtMVXd5d2ZKRGtIcEpJaFlHditnVkV0U2R3WVRSNnZSMjBXWmRPeGtt?=
 =?utf-8?B?dHJ2bW9TWGZJWXNIMXJYZjRxWGs5R1NUZ3JUcnVGenEwZ2xLTytES1JJZE9X?=
 =?utf-8?B?Y2tUeTNOTnUxWHM5L1p6THVVM01nc3NGZkhlZ1Y2SE4wQkZLWU5IelBxMzRt?=
 =?utf-8?B?UFdkZmtDajV5Rmx3OUhBQjV1cHlhV2o0MmJSRlI5YkRYMTlOUW1JUjNOUjNV?=
 =?utf-8?B?elJNZlVPM002VmRNT3ZBc0FobUZJb2dHZ1ovQXQzN1hhQnduZXBLK2tST0Zx?=
 =?utf-8?B?ZTF1bkNBb1U5Wm5Tbk9EV2UrL2dueWIrYTc0bEN0ZFdkdHllcWlwMnZ2QnFE?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05de695f-5a27-4f2e-8bcb-08dc800710e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:45:01.7396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KQZ/23UFvH1vXI09M8QR/+qSJifLPWr8Ciw2SbYXev/VLhsRGIyUhpOkfbJOUtxvNAjFq2wx/V5i7Y2yI268yPMjMDKM66aZzS711/ZfCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-OriginatorOrg: intel.com

Hi Ilpo,

Function name in shortlog does not match the patch.

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> measure_val() is awfully generic name so rename it to measure_mem_bw()

measure_val() -> measure_vals()

> to describe better what it does and document the function parameters.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   tools/testing/selftests/resctrl/resctrl_val.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 198b5133432a..6c53eb9171ea 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -637,8 +637,14 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
>   		set_cmt_path(ctrlgrp, mongrp, domain_id);
>   }
>   
> -static int measure_vals(const struct user_params *uparams,
> -			struct resctrl_val_param *param, pid_t bm_pid)
> +/*
> + * measure_mem_bw - Measures memory bandwidth numbers while benchmark runs
> + * @uparams:		User supplied parameters
> + * @param:		parameters passed to resctrl_val()

Please consistently start descriptions with upper case.

> + * @bm_pid:		PID that runs the benchmark
> + */
> +static int measure_mem_bw(const struct user_params *uparams,
> +			  struct resctrl_val_param *param, pid_t bm_pid)
>   {
>   	unsigned long bw_resc, bw_resc_start, bw_resc_end;
>   	FILE *mem_bw_fp, *mem_bw_fp2;
> @@ -912,7 +918,7 @@ int resctrl_val(const struct resctrl_test *test,
>   
>   		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
>   		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
> -			ret = measure_vals(uparams, param, bm_pid);
> +			ret = measure_mem_bw(uparams, param, bm_pid);
>   			if (ret)
>   				break;
>   		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {

With typos fixed:

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



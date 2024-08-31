Return-Path: <linux-kselftest+bounces-16891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6FA9671CD
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 15:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36AA11C2137D
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F24111A8;
	Sat, 31 Aug 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELjV249c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778E101C8;
	Sat, 31 Aug 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725110919; cv=fail; b=fV25dLsYYxpK0uBLfSWCrcPKvsOknfbBzgff6+cBxV49jvuMtIptZbRTaXJALussduTBQZWecyHFrnJopFB2CB3IunxMMRI4cBugJ833+8Ggo40x8PAurQQxkF0XxpCIaLlj1HCGpeqNED+0mAFtQEnXn+/5F50L77Q6//UuEwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725110919; c=relaxed/simple;
	bh=WXk+nO87kU29MKkI6rOO1lvcKm5edDVSpv46t72f6SQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iRiY5QFsDQdAgCtpZmsMpwwezNQq1XqiT1rsGWXkzVt4DzcVTovjuhZJ3Ps1xLRGBAHVu7rNZ2jIjQkwHwMnbgHD7Qac8KY4cw5XmgQwYT+Mu+fTFBMwKGmsOQSi4cCSwf6NyEFr5nEzwlmhVsqPzfGHrJ0vJ8v0AHskOsZyzPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELjV249c; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725110917; x=1756646917;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WXk+nO87kU29MKkI6rOO1lvcKm5edDVSpv46t72f6SQ=;
  b=ELjV249cSMR9Pm6dLYb/MEQ5HhUihLLEFX5ro27r+1LTNNMdtFH3yWlo
   suUJPKkOq1jzu/9/DgKXZygPmQOBE0HXMryct28dPmmzlEnYyYLmVJ/rs
   7A/R+SRG63nrqJ16B7jZB1p2LEaIORmT6bs+8aPlOrktodM1CSC/hFnuI
   mAoJivDYcCRLYWHhF56KpZOhqA0TALcJ6AU8/CJtvFJTqDsd/Dt50+0RN
   5L+2bIevEE3jIQrri3tuyD32/Lr3dEFSP5fuAKuJS+oSgeETHXkW0vL92
   pIOYtPPUGNwcJ56XmMQkIgIAh2/NR28pkyAPRwhTxm9KJ+3axMKdvSqZR
   w==;
X-CSE-ConnectionGUID: avyq/TLMQUSYoWWmZrvt8A==
X-CSE-MsgGUID: n0YsHAeQTOqGiK2tRFbYSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="23908530"
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="23908530"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 06:28:37 -0700
X-CSE-ConnectionGUID: j44IfLluRFqpFpPjn5AVZg==
X-CSE-MsgGUID: trhm0dTKS+akhUl04ePoTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="101637397"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2024 06:28:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 31 Aug 2024 06:28:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 31 Aug 2024 06:28:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 31 Aug 2024 06:28:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7x9wO5EoJIcKSQYm1T58JJ8KHctWMIHhoL6UOKtlENabOTvzpy9wh78UZxuz7mj0L1ctarLPevSgrzHjh2/q4sc0NjZkS7ctt7UudaNnf35aStNim4SfbHeMsEuXOMs6O8PQA3aiHXs5j1sOLZwWsv7ECqikeMgfaGjAJrjqveg08eqPic1C/+Rtmlr8Lob+V4ioVlzgKdqPfKBmca8ph5y10Y0jo9tZirOQd+tBgTD0C2HfarLLTzc6De9Xdo+DYeg0Wxzm3T1azy6OzG4Z4OBxa2HrZ4UXzDihrrQci6BeYK2rYxdGQrZgdy40h4H7PAi0SES+LUsPR2vIDgAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p6FfR5pIjw42dSJa7skhzo0/xb91EHW8gBnMx6RhF8=;
 b=E4Pmz5IcvDAiBLbkbelTOOpa4L0FpCjHwxVpu7xjksYLZkPM9jU+CIm/Zn34etsT5isj9+9LvIpzP2N3Vwk0GOIRVIUYQU92OC1d1afiISYPsJZdUabptzTXGXCYmwtG/cauMCFF2gpO2hhz/ZGOI/Xw2WucGvp3XRdOoSbhBGq1D6YVLM49M0ZRDM9SlSniT1SCH+thQGyE42ZM/+6TDgycdElg5JMPGkLQyj0l62Bg0I1JP8594vpv/dNrsPnZhDIIcKG+BPzgpRugAqJ70ad1HGwBK8TzxTeRh4jUZkvMXJOeoKVNU6yeIthC7HmuiJPWOW28JPPus1oFoM4crQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sat, 31 Aug
 2024 13:28:29 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 13:28:24 +0000
Date: Sat, 31 Aug 2024 21:28:09 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Shuah Khan <skhan@linuxfoundation.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kernel-dev@igalia.com>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH] selftests/futex: Create test for robust list
Message-ID: <ZtMaaTUA4uWIMFlg@rli9-mobl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829183509.446934-1-andrealmeid@igalia.com>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To BN9PR11MB5420.namprd11.prod.outlook.com (2603:10b6:408:101::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CY5PR11MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fdda77-d443-4386-666d-08dcc9c0c840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?v4FWz8YTYDG84RHPryrA5gjMNmLKEZmw5OppyTxIQGwjKQD1Gami2+B/Mz?=
 =?iso-8859-1?Q?Tq28WknJDAM27bcRobwbPZ5+60G+XPoA1JLK+HWHEX/9+fPlRK4uUW1ML5?=
 =?iso-8859-1?Q?FSsQHreq6ZUPA9oQWRyE/sX27KJWieg0bz4b2V/6sH5Qpq9rak2HTsbqcx?=
 =?iso-8859-1?Q?7UKZMI7Fta3A/D9A1/3N/im346oki87hv94znPpz6W1wdhpfWWVU8omKhQ?=
 =?iso-8859-1?Q?dbeBYaJx7w5fMavPmjuX1zIdxMg2tXgSCHLatfH3x5RAhCcghLRGVSXII7?=
 =?iso-8859-1?Q?OFb3cah5ewojLjOwn8DwYTC2RR4OoJ/HREWteTY8Rw2o7rNudpym2PgRk+?=
 =?iso-8859-1?Q?Jc0Jr9CzmwZh3QHuHXZCqK8m1Ne/jc8dP28LPmtsQ/SQ2VZyvf/oX0W1C6?=
 =?iso-8859-1?Q?Br+EKQqaTX1nIMFbpXPXqwtzD99UxqGUv+nxQUQBTeR1fmePRXle0nV0cr?=
 =?iso-8859-1?Q?7bpqv6BmTG9O7fJpUsU0JDSxmXaduOK6g9oOoWTFXjRL1Qedz0LQH0wGnD?=
 =?iso-8859-1?Q?k/Y3OF0EQDojojRkZb2J2OE11PVTdTYB3CeC8yQz38CI1EAXn6KDO4rWkQ?=
 =?iso-8859-1?Q?TikGZbwJ+RQVSR6+r9R5lR690TqnpUFbEJYEywyj3S/U98zXwxqP1tAPh6?=
 =?iso-8859-1?Q?woSnTbCeGgBFIb4Q4u3ZVtEitIRl4erbHnx5DwIQOIGgB2A3iexS9vnn1R?=
 =?iso-8859-1?Q?KBMs43MmlCCR46dztOQXLpwkveEB5QYudb0TPLgPMIk8OQkBE9lGcHbasN?=
 =?iso-8859-1?Q?CASpULI25bk2tEgKQj63y8jXXsZm42g0nEMEGgu1ALraGlEydFmMiGRnOf?=
 =?iso-8859-1?Q?lkHbL9eGlx6WolVM03vLA+a5tuExaBZ2JK5UY9Hm5WvTE+BFENrUHtH3UH?=
 =?iso-8859-1?Q?SyEzQ8VZ1oY+8HhL4ftd+UT1IzYk2xKx+CjYJkHTAgDWsZfTk4ISTnKwb/?=
 =?iso-8859-1?Q?KEY/46Bm6s2kLfWDLbtv9qplcUKdKJPoeg7xx4ESKEy9dXmi1TDK/KXPXB?=
 =?iso-8859-1?Q?ydOn/QWxifPwLQ44SCgtFTAZW/WiAAL+vW3LxZLYt09urDONOdrcrkya1m?=
 =?iso-8859-1?Q?n5PpJRO0uZ0WQ//G3JNZJatOWXdLMF9whhXAdcNxfYUbe0MGvQHlgFRNFe?=
 =?iso-8859-1?Q?u14KZFn+JLOpT36sjtjUxopYXM5GV0eC4DED3UPcuOEJjVMJ4k7GY+mu5a?=
 =?iso-8859-1?Q?rcrfwKCmH6Mi/mpyzDSANrxXezha73u08Bhy1mZNJ7BAiuC09l1Cdklkhj?=
 =?iso-8859-1?Q?iWWidW8Ln6MZX0MFyq7Ko7Tb9R7Yzr4qQVpREKxzfCP7qTZmt5a7qPf4uj?=
 =?iso-8859-1?Q?OzAjmtCZEpGGvk8P/FUMY14Po+YFOWnPbsNNdX/OXvFLV+M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?51UjOrhL4Uw4i43TGsbjIuxM5L8WlBiBR3cMeGLrjG0Dkb0mvFv4sRdGZo?=
 =?iso-8859-1?Q?qaxxTAJADuQ9FAwOh3kW1OFgp7bAIQyTyKhrfNwSche88H6w0O9qEGAHyR?=
 =?iso-8859-1?Q?uqPP6VMv6vo9JTvnpMI45lKVV0hjl0RRJ9w7pY1bVCY9Kk7XG3QytZF5vg?=
 =?iso-8859-1?Q?+zwc0AyNMZfbodIqLpHHZRiATElRUvND9D4bcethVMYY9uECK6E1/J9umo?=
 =?iso-8859-1?Q?TNB8kaqV4a6wUnTtG2/hoasrpxE21C80vQn9+r9PCr7ifIMnaYaXxd0bdt?=
 =?iso-8859-1?Q?XfW2xB9/QRYEoK1Yw7paJhhzv9UYfRv4c60OaC/LBEwXE/D4QpeLCsAXkv?=
 =?iso-8859-1?Q?I35BMKUzN9Fg8Di8DdKdv92ktRsZnYeid92n8P5YiAgi0xNkYDcbKhkg8Y?=
 =?iso-8859-1?Q?/nucRMbUMOohJKNrLV6Dq42cJrdzbgsAZ1Xx8TMnveJdZH1jY2Q6ml+amZ?=
 =?iso-8859-1?Q?w61g1CIE3Gvo0tnW8TGPF29W8RhKzDWEbvSiD/eA9OG+ZJMs7KHENO2efG?=
 =?iso-8859-1?Q?gCqwvaTfgAWWkgMeVY2m0BLDp0mFCYOKk2jGRSyePKBLm3Bc/DvXVA6/x+?=
 =?iso-8859-1?Q?CHYVovhnSivfF9fet6zhPs0wyBxmSC7A9QpF/rtG3qkX1Ur//VxoKyPNcd?=
 =?iso-8859-1?Q?Ecre8SQA2REpDQS/myy/72qVIyGamznpgcD9URJ1wK0k1uCnL2tKeXrvMo?=
 =?iso-8859-1?Q?shbhWgTJyXpNCzqgtROVL/33IooannAdPM0BvW7JmEO4Eio7D6dxwipQ/7?=
 =?iso-8859-1?Q?oPxhw3qnucl9VqbJ+kBhMpdt5cmZYHE67znVd5IR1wHmfMiriDOU63IPqs?=
 =?iso-8859-1?Q?7Mf1t4G1aaA+zeA8f92eshUAjnREP+iHYbt15W8tYc62TzgAaQ202zDhW5?=
 =?iso-8859-1?Q?EmzaANjZizWbW7AxdAWbqx/kVGS18lQtI2mD08vrt09plm7nQUlcv7WGbK?=
 =?iso-8859-1?Q?T+fuurpFnLmQLj+gtm/lsrcFpc0HoseuregZUGSGMhpJ6k6HFDIrhsiRez?=
 =?iso-8859-1?Q?Ze5AR8fvH6m1qpB+/ZS5PTnvdWiwM8wDGL9QJe1LwZ/Jx5uz50dL37xb8f?=
 =?iso-8859-1?Q?uq2osQeBZadnT3fgnr6Uad4FBrqngBrBHytgovZ12ISfSF1RwoJ5v/PAY8?=
 =?iso-8859-1?Q?VpnsLOtVeYfY8GxScCIz+Q8tllqna+/Lh5I1aKSu4T0xEpd67G20j/2Kuo?=
 =?iso-8859-1?Q?JOji6hjdOh1ttIJZEKiAAuIJ9RRIPVwA2Ys9/8Hw4Q9RblSVtj8K/GgBV3?=
 =?iso-8859-1?Q?4zub2TmSe+WVP7xa2DpFPaoVyeSla7ByjE3Wp/WNRPRc12c7wgGpIBxQt6?=
 =?iso-8859-1?Q?AwcV51/OMrUORgSNn1YjKq2kqAPTDNSugIFdvDRR9IT36s95VLs7ocODFY?=
 =?iso-8859-1?Q?rN4vka4+4XrBFU/t5dGI20nE84RrRznyFJiArIPzV7EgpSkzRWGCsa50Hx?=
 =?iso-8859-1?Q?wudhkUN/f7w6+ibVWPAz5yb1dqe7WeoBeAs6pQkZrVok2P0URf7xeGRGiv?=
 =?iso-8859-1?Q?4JlkHlx+hkwGQwDicJiF7Ncb0LMiNZIEkYoV27Z+NhT8VEgK6BjW0fOVfp?=
 =?iso-8859-1?Q?Z99JuCx7ZehbQef6cXLpI4c2bI2vl75FCHiqwoB/rdxTWpoJjMFaUF5Wnz?=
 =?iso-8859-1?Q?HzGMhYSq+xJWUmHEpPB6CTQ7khDTJW9/JvXzjJDhAjqtSugf+kvRCVwQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fdda77-d443-4386-666d-08dcc9c0c840
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 13:28:22.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWfWLqYW99pgpQf42yPPofu1O3zhHLoewlutE6yK1QvPicO3/qmeHkgMcJTB4L1BPs9uwMWAnRAXNExthTG/EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6462
X-OriginatorOrg: intel.com

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/selftests-futex-Create-test-for-robust-list/20240830-023631
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20240829183509.446934-1-andrealmeid%40igalia.com
patch subject: [PATCH] selftests/futex: Create test for robust list
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408311654.Me6a2xuF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202408311654.Me6a2xuF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> robust_list.c:53:17: error: use of undeclared identifier 'SYS_futex_wait'; did you mean 'futex_wait'?
      53 |         return syscall(SYS_futex_wait, futex, val, ~0U, FUTEX2_SIZE_U32, timo, CLOCK_MONOTONIC);
         |                        ^~~~~~~~~~~~~~
         |                        futex_wait
   ../include/futextest.h:78:1: note: 'futex_wait' declared here
      78 | futex_wait(futex_t *uaddr, futex_t val, struct timespec *timeout, int opflags)
         | ^
>> robust_list.c:121:6: error: address argument to atomic operation must be a pointer to _Atomic type ('int *' invalid)
     121 |         if (atomic_compare_exchange_strong(futex, &zero, tid)) {
         |             ^                              ~~~~~
   /opt/cross/clang-617a15a9ea/lib/clang/18/include/stdatomic.h:144:67: note: expanded from macro 'atomic_compare_exchange_strong'
     144 | #define atomic_compare_exchange_strong(object, expected, desired) __c11_atomic_compare_exchange_strong(object, expected, desired, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST)
         |                                                                   ^                                    ~~~~~~
   robust_list.c:147:9: error: address argument to atomic operation must be a pointer to _Atomic type ('int *' invalid)
     147 |                 tid = atomic_load(futex);
         |                       ^           ~~~~~
   /opt/cross/clang-617a15a9ea/lib/clang/18/include/stdatomic.h:138:29: note: expanded from macro 'atomic_load'
     138 | #define atomic_load(object) __c11_atomic_load(object, __ATOMIC_SEQ_CST)
         |                             ^                 ~~~~~~
   robust_list.c:150:3: error: address argument to atomic operation must be a pointer to _Atomic type ('int *' invalid)
     150 |                 atomic_store(futex, tid);
         |                 ^            ~~~~~
   /opt/cross/clang-617a15a9ea/lib/clang/18/include/stdatomic.h:135:39: note: expanded from macro 'atomic_store'
     135 | #define atomic_store(object, desired) __c11_atomic_store(object, desired, __ATOMIC_SEQ_CST)
         |                                       ^                  ~~~~~~
   4 errors generated.


vim +53 tools/testing/selftests/futex/functional/robust_list.c

3306ef10715f1b André Almeida 2024-08-29  50  
3306ef10715f1b André Almeida 2024-08-29  51  int futex2_wait(void *futex, int val, struct timespec *timo)
3306ef10715f1b André Almeida 2024-08-29  52  {
3306ef10715f1b André Almeida 2024-08-29 @53  	return syscall(SYS_futex_wait, futex, val, ~0U, FUTEX2_SIZE_U32, timo, CLOCK_MONOTONIC);
3306ef10715f1b André Almeida 2024-08-29  54  }
3306ef10715f1b André Almeida 2024-08-29  55  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



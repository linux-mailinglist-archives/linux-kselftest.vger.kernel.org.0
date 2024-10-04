Return-Path: <linux-kselftest+bounces-19074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B259D99123F
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 00:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BA1B21031
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8898C1ADFFC;
	Fri,  4 Oct 2024 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIds8Ydt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08D140E34;
	Fri,  4 Oct 2024 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080502; cv=fail; b=YNTdpzP5l88AQUpFseSPQJAumlJQQdJKEN1asmyYN+9yDryuQeff6I8MK3ErcMOARyvmLH0kpv+YueYw9o65SwrlhZaZk/h9zPheXxpdgLvvymJVBbY0rzAh1KHatblklIPDGaf+Hzzp6HEdnHmmjYf+vkhTJ58IdYfp3cuM0dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080502; c=relaxed/simple;
	bh=JUnmLB/h/Z50WbCoRkj9LpFa/hGqEfEikE5t0vG+gYg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UTNHdhMXZqFSEJ5iXv2KrYnJocicLdzm5BlCJ7IjFgbyZu6b7ry9ta0Mk40Ois6S9CRaAH/RZRIZ/RjJeI2GrHYthQyfZ7nx8aDuiCeScXTrYWdxZCa9xH+pDMLRp9jap49pDtTgH+uUsJmzSSzDjT0YiUMpt60+gfKGx/pxJ8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIds8Ydt; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728080501; x=1759616501;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JUnmLB/h/Z50WbCoRkj9LpFa/hGqEfEikE5t0vG+gYg=;
  b=SIds8Ydtybev4aGD35C5jAWLU8j+xfq5d4sF94e86xLXRcMTbtZBHck+
   9x3UxaSGZ65qS2mG63cV7zY64OoVO+LV9GTCAeop0HcaScI6nPcZ3Jujo
   ob25volI7REpu0lHaYmTNjDhHcJanGPngPx4cPgiLW+ZSpQ+nmZc7gwPY
   XJBdpIFNrMnIYSKqHd1eJTKg0it11oj7AQ/V2L9pzAkeC9CcEFTo8nG2c
   K3O9mfpwfVn8cXJNOgTkxD5G/SqgoeAAGt/WIw+lvFq6MBFv5w+X/3G/v
   e/rRd59WHcvnaM3L0WXD4e03Q9YJr+YNsqmWx9mdKbVxSPHrOWztsZb94
   A==;
X-CSE-ConnectionGUID: gIxFyfXsQJyWTUazNlsXrg==
X-CSE-MsgGUID: jeOQtOMGRHi8tyAFLvGMWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="14937513"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="14937513"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 15:21:40 -0700
X-CSE-ConnectionGUID: HoHbCt2mSpKwpFAkkaANnA==
X-CSE-MsgGUID: fpudGWr0SeKTWaabJWlTCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="74423953"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 15:21:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:21:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:21:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 15:21:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 15:21:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJewmgiS6/PadgADFVFfGrV4wOfK82I3E00vjegr0Pdfew95bTeaMUutWeDciTmQnFyFWODqTH14uJhc/k0qmTTEkfKrfOosNSwsvRoKr4Lk/ZjkTwrTU5YtstnoRooe3zVbWF/fXwXgFEQ7PwAId0VwJWRnZc2dh3yGfX+0n5d7F9BLAalS3kHz9TvMJAHiz5Otv0oZvjagPPsXHG/7oDPtygVAhxBkSIvd813AjlKa2ySZH/XIMqiH6Re2SP7TH+CapoJGTI+o5vy2hxdkxqkCWH1G3R4p+FgxeteFRCyZkMIGrFbk4NltG5uKcYvD5A3hf2K7lGtgqUeBCWVrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBvL4jXZJN+6xsgEWqyNKq0f3ITlI/N02RW8Dq0J/2k=;
 b=mED5oy44LRrGxpgaPuoursmU0movABa2zE9iez/AQljTEIZx8w+oTnVZt2Y0uwH+RKWWjti1iX4SZvddHWF2NkN7Jq9428RogWuqFTZSJsHHWyg112NOQ/wDdmKF2gUNqjY43UVpVgeUromz7K3xvf51JM1LbIMhptf+AZ4uxDntEUnhDw3P7u74ep7oyFG8vW8tBdkL1AgnBJVwaZWWuQzTFonqoUHWItSUhdgLeOACcoGlZcu8b0OJnE+G3XkxrFIwNTBSHjiTURXSHN3xEH6IpqfxzbVgkoH0jCzqJscch/ox+yBFrOcYZJvqrXSgrEA7jWrwTKm/95m47BDYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7112.namprd11.prod.outlook.com (2603:10b6:806:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Fri, 4 Oct
 2024 22:21:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 22:21:33 +0000
Message-ID: <6ae8be57-be40-4b85-a171-ce535bb5b5a4@intel.com>
Date: Fri, 4 Oct 2024 15:21:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 09/13] selftests/resctrl: Make benchmark parameter
 passing robust
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1726164080.git.reinette.chatre@intel.com>
 <d1501b608a3d5c101af9b6a8a519c8b05392a558.1726164080.git.reinette.chatre@intel.com>
 <9a70486a-5cb1-98ff-4ac6-498907886d2b@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <9a70486a-5cb1-98ff-4ac6-498907886d2b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:303:b8::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ee89eb-23b8-4355-ba55-08dce4c2e72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGNuWkxFSFVoczY4MkRMbG5ybGpYMTJjOWZLZm5OL0RvRHdVVWkvUWxER3Jq?=
 =?utf-8?B?Y2QzQS82alNhWlgxRXlHOE4wOW5kU2x4dE56alArazlKSVVnMlVrSGVXSktr?=
 =?utf-8?B?QUdmbHJBSDlrTXQzTjR1bzIzZkcxL0k1L3F0Z1FYRE1MSkZud2ZNY3IxUXJn?=
 =?utf-8?B?aWllV1JWcTAvalIzdXBBdi9sa3p2bS9NNTVlMUgyVm5YS09GZEZEYTlrNEtJ?=
 =?utf-8?B?NVY2TXNOWk1hMFZIdHJmc09RRUFQMHBHdmxQT1dFZS9uVjkrcVgyTHJzNjVG?=
 =?utf-8?B?UjV5Wkd5c21xcEFvUFVBaFlHVDNDcTY1ZUFtNytrekorTktKS0tjVitScHhL?=
 =?utf-8?B?Yi8xTk55SE9kTVdPMjhxK0tqb2FsdjRMbzhMeng2NTJWMmdYcGRJc0NCSGlJ?=
 =?utf-8?B?bFU3T2Vab1kzWWE2WUpka0t0NjNHVHdlRlJoYXE2MllFRldQOW05WlRtUzRr?=
 =?utf-8?B?M2kzaUpNSXp4ZXJYa09CWEVncXkvWWcvK0pORW9xZG02MHlzUm16R1lxWmc4?=
 =?utf-8?B?ZEdqZzB5SGdpb0llODV5SFJadlE1Ky8wNG1IUldvcyt1RDV5eU82TjBJaXhX?=
 =?utf-8?B?NjRLa0NwL25wb3M3NEQ0V2d2amZSWW5VbkZCUzYzNmVpRk1VK3FLNFRpYUpN?=
 =?utf-8?B?YWxwdENDMXpDYnA3T1JSWjR1Y3Zoa1lLY0JuSDMrVmhPT0NVQ0gzblRaNGtM?=
 =?utf-8?B?Wll3NkYxTmpkTUZUblVhZURDUWliZ0Urdk1oNTZuMW9qQytNK3loUFVnYnBu?=
 =?utf-8?B?MkZYMlVIeWVoSlR5bjRtYVdHN0w0TEJSMmRDbUdZZDNrSmJJbVRMSlVCOHBC?=
 =?utf-8?B?T0xDeGNaaTFzMWMzQVBXM2k0ZVhNd0lXSEFZWDZBeXFoL0FEY2tjYXpYeTB4?=
 =?utf-8?B?bWJjaEE1RHVaaERaRlBkRmR2aVEvRVNXUm5VK09OdUNHS0ZsNzJkVmppSTl1?=
 =?utf-8?B?NE9mVmpGbmNIMGxYeUl2dzdDQVpJWFlObnVEQnVLS0lGUEoyR0NCbXVzTjJz?=
 =?utf-8?B?eXAyRU01dWs4UE4zUmtpR1ZBdlV4NlIwaDRLaDk2MENrL2laZHZsb1JPd0lD?=
 =?utf-8?B?a1U3WEoveC9Na0F2ckxya2tXOFpjMm5xYTAyN1doajcycElGYmZ3b0Jya1Zy?=
 =?utf-8?B?alA0SG5aUFpaNlduUE10M3dXMTFiTm5YY2Rjdkl5bk9pVlArUWZ1WkNNMTlF?=
 =?utf-8?B?ek8zei9DRHdVN3oxZVJsU0k2TkRBbS9xR05FWnl4TVhBYU5Fdk1NczNzYm5l?=
 =?utf-8?B?aFRUbWNkQ3VoNE5OYVcrUStUTGJqdDRQMzlEcFpxdkdQQUJHbEVFZkNYcXJS?=
 =?utf-8?B?RjQvZ1g3MEdBOWhEWTVwY2ZETmw2Qkp0dnRkVzZtdlRLQ3djTVZaWkJ2UWty?=
 =?utf-8?B?eXc1WmVFM0xMN1lsek9Fb0xBM0dncWdINmFWSVNGYk5rY21BelUydlNicGxV?=
 =?utf-8?B?WElVbmRuMERzMHZmdU13c1RpTExXeDFvQUs0R2d2TDJhWnBsL0UvMVE3aGVY?=
 =?utf-8?B?TUVPOEFDcHV5bFRWK3FaVXdsN2FJb1lzS1hESWVWalVMV3JMak9kRmR2aGFD?=
 =?utf-8?B?Zm1PVS9rRFNEeUdqdWV5RmNzbW41dnIyLzNPYWsrRWpnRFlBbWJDL3RadFFq?=
 =?utf-8?B?RTIraFpLemc4ZHBTWlU1WFNyaGdIRHdOaVYzZHdjSU5iVGFyVU95aWx3OUN3?=
 =?utf-8?B?S3l4d0x3Z3UxMWJZRUVzZ0lWb0k5dVJvRmp6cCtOMWdiSlk5d1BvSVhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjJLNFhNL0lVdm9neTlrbmw1SFBsdHozZkZLSHhOL3J0bEhXSkhVbUhsUHpM?=
 =?utf-8?B?aEJjRDlQL3FtQzF5Vng2dVNlUUV3d0F6VFpjQVRxZCtQMlg1WVhBVXhTTUxw?=
 =?utf-8?B?RlR4Nm01UXhGS2lMNkZvNldweDhiclhVTzd3a2tpRUduQkszRXAwazdQL2JU?=
 =?utf-8?B?QWlHRjYrazRjNXhpVDBaeEwwY2xCWU1nd1hESHA3cEd6S2U4d3gyblEvcE1C?=
 =?utf-8?B?d2dZWHpLSVRJTHNubzdKNjZvVFhGN05FV2ZQamljaEZvTXFCUllqTlJXRTVr?=
 =?utf-8?B?ZElyWG1SYVN2eE42dXBsRzRZVHNuUXQxVkdmN0VGWEp0bjBtK3EzTFVxcFU1?=
 =?utf-8?B?ZFgrYks4Vml6Rk94c0RrbDBNMDVOWHY0Q3k2Z3ZqMDFQY1poejlwWWowSnp6?=
 =?utf-8?B?U0RYdkJUU0RxaUxHa2N1SXc4Tlg5Vmh2Y0hLUFpBbmV6VVpUd1poaVBhUHJV?=
 =?utf-8?B?TmdON2VYem05OGpObkNKNlRzdm9QY3ZyY1lQU0tENjl1SllJNkdlbmdhczVl?=
 =?utf-8?B?c0dDbEZnMDFUa2dHWDFJSFZCRm92OFJOdlBSMVpzQm5LdWp4dTVoTmRDays3?=
 =?utf-8?B?dDQwYVRjSlNWWStxMGFzcE8zOFlFMk1JR2pzZ2o4Um9mcGVaOXhtZ0NWUmdY?=
 =?utf-8?B?K0YvOVJGbWhJQmRUQWJUT0xVcmpCMEdnSWE5azNyMjAwdzRBMHEyYy8vQXBV?=
 =?utf-8?B?eU1uNS9YeUxaZURxWU9SbVVBejVncHNQTjY1U2VzVkFjVVN5ekxTeWloVUpQ?=
 =?utf-8?B?cmVwaTlQMWUzcTBEOENDV21Jd1RmNEZMTm1TUVdEbW42N0dsM0dJYVRlNzhi?=
 =?utf-8?B?bHdJRnExeGsraFFZREtwNEJPYUpqcmJoVENaa1JzWDdUQ0c3U2QrdGlNQXZl?=
 =?utf-8?B?Tm4vNkx2eVNuZ0hmUUp4ZVZKcjJJdDl0blRGT3dKdGx5ZmFsTjI3V1ZtcGR4?=
 =?utf-8?B?T01LUjVWTTZ2YmJucnBDem1YcnJabVNxQ0lxLzFIWVhxWXZJcDVDMXJLOWN2?=
 =?utf-8?B?N202MStFMi90WnVpRHpjaGMxTzEzcUNIYkkxTEdEOWFOekhraUtqUlcvT1oz?=
 =?utf-8?B?TEdMaWMvNXpLL3lUaE9qb2ZXd3VrbXpiL2t1SjUrYzdyVWJNakJaTEZUOWpw?=
 =?utf-8?B?K1hjSHhlUWZrMW9pQjk4aWl2dE1lRjJkbGYrVUsvLzFoU2syVDJTWlZrUlFN?=
 =?utf-8?B?WHNuL0c3WlNUdm1ZY0doMjgzbi9pdXpmN2FjeEVHSjBDWXBaTkhFeEl2WGxQ?=
 =?utf-8?B?NHNVNGpvMVA0cG1HTWtQRC9ROTluYm52bDZyQ1ZHMW5SZ2JlVFFqOUpuQnJv?=
 =?utf-8?B?d2I5M09XbnFTeTJqWWE0UU53Mll1cVFJQTcxVjQ1dkpibUplcktaQ3ZRZi9V?=
 =?utf-8?B?NFhBSEs2c1RzWWVVajJVUjVDbW5uNzZ0TTJwQTVxUnVZZEhKb2ExVVNwL21z?=
 =?utf-8?B?S3M4a1RKWjlVRVdZV0E4M2E2QjFuMkg5ZkYrUDRQK2MwZUx5WU5oQ0IrU0xM?=
 =?utf-8?B?NkkydWVCdU90N0NiaDZHUk9iMFQwOXNBZ2t2aEdjL1pPNkRsd010c2hwOFVM?=
 =?utf-8?B?UEtjQXkxUlFzU0FOWE9TQVVFMHJERHZGSUNURVljclowR1JZRzJmbWh5MTNL?=
 =?utf-8?B?dXhnQTZ1ZXh4ek1CZ203T0VYMGloclZwSjZHR2FDTlgweC9Ya0c4ekR0cjJX?=
 =?utf-8?B?RzQ2eFE3MUVvcEFiNWlJc05WL0pRYzFIdEwrSXdFQXVaSFFIM2E5NTdBTUxu?=
 =?utf-8?B?dElGNlRiQzJleTlvN0EvTFJVOFpwTzFSOUl3L3UyZ1djTWVnOEhGV2NBMlNI?=
 =?utf-8?B?bE0xTmt1M2R6cUsrN2M0dmZja1pIeisxZ1NvdWZ2YnU2MTNDNkxMRHdDRkQ0?=
 =?utf-8?B?OTByZU5xSWFldlUvYlh0MUhQTG1QeVRaRzg5Vnlya245K3NkOENpakpaem9w?=
 =?utf-8?B?UE93KzVkeUdWWjhpSEIzZnJhTW9pVE5tdWRYa0E0UnNGczhnblJCVDR4OU53?=
 =?utf-8?B?WW1JOVVmTkorcENJSGNEaDV3WUxCYUJET3EwM2ZrU2hhWndZT2FFOXF3Ykwx?=
 =?utf-8?B?UzZlY3RkNC9abnlERGMvTVJSSGZkd0U5VVgrd2xSay92ZHZIMFh5YXpnYXEv?=
 =?utf-8?B?MGNFZ3djQ0JhUHlOcCtQT2pWWWxHd0NmR2VHWVZ4TG5XYnAvUk0reWE4NVJ3?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ee89eb-23b8-4355-ba55-08dce4c2e72b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 22:21:33.4302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfdavqhRFUmRXAuj1T+oXIdVnutPUOI209kLdxT/S/vdeM9ldspNBULOrFsND7Bx3QqJKSHec4gG5Kn4DIrP8gVGZOEQtAbHYUGFw72GQvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7112
X-OriginatorOrg: intel.com

Hi Ilpo,

On 10/4/24 7:05 AM, Ilpo Järvinen wrote:
> On Thu, 12 Sep 2024, Reinette Chatre wrote:

>>  tools/testing/selftests/resctrl/cmt_test.c    |  32 ++----
>>  tools/testing/selftests/resctrl/mba_test.c    |  13 ++-
>>  tools/testing/selftests/resctrl/mbm_test.c    |  22 ++--
>>  tools/testing/selftests/resctrl/resctrl.h     |  54 ++++++---
>>  .../testing/selftests/resctrl/resctrl_tests.c | 104 +++++++++++++-----
>>  tools/testing/selftests/resctrl/resctrl_val.c |  43 ++++----
>>  6 files changed, 176 insertions(+), 92 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>> index 0c045080d808..a7effe76b419 100644
>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>> @@ -116,15 +116,13 @@ static void cmt_test_cleanup(void)
>>  
>>  static int cmt_run_test(const struct resctrl_test *test, const struct user_params *uparams)
>>  {
>> -	const char * const *cmd = uparams->benchmark_cmd;
>> -	const char *new_cmd[BENCHMARK_ARGS];
>> +	struct fill_buf_param fill_buf = {0};
> 
> Empty initializer is enough to have the fields initialized to zero.

Sure.

...

>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 82801245e4c1..98462752cb46 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -43,16 +43,35 @@
>>  
>>  #define DEFAULT_SPAN		(250 * MB)
>>  
>> +/*
>> + * fill_buf_param:	"fill_buf" benchmark parameters
>> + * @buf_size:		Size (in bytes) of buffer used in benchmark.
>> + *			"fill_buf" allocates and initializes buffer of
>> + *			@buf_size. User can change value via command line.
>> + * @memflush:		If 0 then the buffer will not be flushed after
>> + *			allocation and initialization, otherwise the
>> + *			buffer will be flushed. User can change value via
>> + *			command line.
>> + */
>> +struct fill_buf_param {
>> +	size_t		buf_size;
>> +	int		memflush;
> 
> bool?
> 
> Or is there a plan to use other values than 0 and 1?

Sure. There is no need to keep the original user provided values. I am not aware of
any other planned values. 

>> +static struct fill_buf_param *alloc_fill_buf_param(struct user_params *uparams)
>> +{
>> +	struct fill_buf_param *fill_param = NULL;
>> +	char *endptr = NULL;
>> +
>> +	if (!uparams->benchmark_cmd[0] || strcmp(uparams->benchmark_cmd[0], "fill_buf"))
>> +		return NULL;
>> +
>> +	fill_param = malloc(sizeof(*fill_param));
>> +	if (!fill_param)
>> +		ksft_exit_skip("Unable to allocate memory for fill_buf parameters.\n");
>> +
>> +	if (uparams->benchmark_cmd[1]) {
>> +		errno = 0;
>> +		fill_param->buf_size = strtoul(uparams->benchmark_cmd[1], &endptr, 10);
>> +		if (errno || uparams->benchmark_cmd[1] == endptr) {
> 
> Should this also check that there is no extra garbage?

Good point. Instead of adding another check I plan to replace existing endptr check
with a different test that ensures that "*endptr == '\0'".


>>  static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>>  {
>> -	char **benchmark_cmd;
>> -	int ret, memflush;
>> -	size_t span;
>> +	struct benchmark_info *benchmark_info;
>> +	const struct user_params *uparams;
>> +	struct resctrl_val_param *param;
>>  	FILE *fp;
>> +	int ret;
>>  
>> -	benchmark_cmd = info->si_ptr;
>> +	benchmark_info = info->si_ptr;
> 
> I'd just assign this directly while defining the local variable.
> 

Sure.

Thank you.

Reinette


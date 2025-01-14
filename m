Return-Path: <linux-kselftest+bounces-24535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE2BA11563
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 00:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FA7163713
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 23:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B985213E75;
	Tue, 14 Jan 2025 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJq6LA39"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF782080DA;
	Tue, 14 Jan 2025 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897309; cv=fail; b=F5ewJDosY9tiTieafVKNXY3qaqqVgIQpjFTjNLJgvBBFX6wAUKHaLRg5NH9O5PXn7Qbm07inCVDdMWKBdnJgVXKu/rnXnZ51xjDmGwTqR+ZPxCvvsljAKY/D+0vvtnY0lKzIsM49DRkJ+WYk0GLz0ok6/ZEi4ux/KPBIkpyAaQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897309; c=relaxed/simple;
	bh=rhWztjCfGZzFjKjL2x41u6ouIakF7jAeCHTSxydq7GY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cA99PfhsLxxnDzwiot+J4M7TyR+HstV9B/KKbMV2QkFKyCHSADny2mA0F+EP23VRnx3eYnW4+hpQtRHXAY88ydkOSzk3n/K/gGX5q6YVCVNe2usrD2eUiPa7b2OgzWsrd+6gwYjtDn7mCcLcj+h/04FlB96hLReQZZgLBuFO6a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJq6LA39; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736897308; x=1768433308;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rhWztjCfGZzFjKjL2x41u6ouIakF7jAeCHTSxydq7GY=;
  b=SJq6LA39U7sjazw0mYMBNBnCzypSGpzO72+9mv9QpZ+yyJXomLrRcs/P
   nczLHEz6YIVdt3VkUqTMGH2gGZCDvlU3c18RPYTzUA/UPKoLNGQGDb7tC
   vJ/rvmTIzd3liOqzzAuFp44gSmQkW9nsy3qNjKN0YjVaaNE93SlUIv/2p
   uIih6RZxTXgHF/whRHjG68fUpEWLqrbT1mtCk5U/ZpRtanLsbBVAR8+hp
   V2Q6oieyKkVHIBrR1b1zo1p9Fovx8lfJnHydmkiKfKEK9v31pczEaMLlR
   vLB7TlQxSPQA21aAY9o1dW5JQ1GI6C2SJQ1S12gxUgNUL8ade1Ppd94Qr
   g==;
X-CSE-ConnectionGUID: CKGpnMgGRT2jiFYvNZHuRQ==
X-CSE-MsgGUID: AVIM9mcSQW2UNHZ1nw9+rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37445620"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="37445620"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:28:25 -0800
X-CSE-ConnectionGUID: YUppd0VBSVK5OJ1M4dgkkw==
X-CSE-MsgGUID: KlSG6q1cQ5Kbet0sCqRuXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="109927807"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 15:28:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 15:28:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 15:28:25 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 15:28:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyAS12odQeP2mkaHkgYlW2UXBcAKnfjLB5AIow7s4LGEMj00rmsV0AvFNS+tpFt1YcPrUlGITsYvclcre2d3NIbkMimL0kT0sxLRCDyqwMualTeDdj3wAR7dnkRPfXQnA1528Pau3aKBlfsHzhLuN/RRSbI5fKmhRsOIZJrNWPFr76cNAZlxCbqh1N5iXtXKm8dIztvlPW2Y/1/OhkzRYeBJ2jsL+yNOjP/VOtXCwivrfEi7XRZVzxjx7bcFbao8OW0vEjRygtBBVxmiMa5SmcChLgtRG0FVusczykyt09ymnotZh5ENHWdbz1E9x3Y9M0r1PyU4iq2MOWj0f89Exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxUt98bg5msq5zH/T9ZrYUs2T+7/gGS2gAFc4CLtGDA=;
 b=R73Axn7etfS4Qi2Wsnj8iCAa6yzOZGski1VNT/gu9wVOMmsxajJyA029/hrvvnByhOIbBpur5//FKho36QS2KptEzU+ddsaaa/7VRR88diXpjsWSKXQGR5pwS7nmRKJi1FuK4fHkZY2BgxqSm85PX7ob2PRenPlIM+ctzpj0rXJBT3fiShjGosTCUpyKvCDq40Hj3Z9tSNt9Z0r8kUxD/6cCkSQ4UlaJu4xvgN0tjlzj3Z7/y796ZrDaywDXwoIPKAnnVnUldVDPcbNquKU0mqSgNyToQb1/DyWoxHQlyjhbnrlVk03q/0Qm7zBzDjeATubYXg4OZfO6FRcOCZ29uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN6PR11MB8170.namprd11.prod.outlook.com (2603:10b6:208:47c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 23:28:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 23:28:22 +0000
Message-ID: <e9971c30-8a0f-49d8-a7f5-ccd64e12f895@intel.com>
Date: Tue, 14 Jan 2025 15:28:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] selftests/resctrl: SNC kernel support discovery
To: Shuah Khan <skhan@linuxfoundation.org>, Maciej Wieczor-Retman
	<maciej.wieczor-retman@intel.com>, <fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1734361935.git.maciej.wieczor-retman@intel.com>
 <808036fb-9a2c-44c3-ac6c-5406313a232a@intel.com>
 <9223d698-d16a-43c8-95c1-9839b81c2c23@intel.com>
 <c1fd1a9a-ead7-4203-af55-5eeddef76f2d@linuxfoundation.org>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c1fd1a9a-ead7-4203-af55-5eeddef76f2d@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:303:dc::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN6PR11MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d14b8fa-3d4e-4f45-86df-08dd34f322bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVlPYmdaU290eE5aL084OEpZUHd6eHUrcEhDRE0xV3o3REx5TTZtZnMrNTZa?=
 =?utf-8?B?MXR1ZWxTZ25tdlNaR05vR0x5R3NhWHpVSlprRytzUXlvcjAyYjVydTN2RGFn?=
 =?utf-8?B?T2FsVGMrL3czMXV2TU5uak1yQW9NaWx6aFZsZlRURFJ0TVNMaWk3a3RjUmJz?=
 =?utf-8?B?cW81Wm9IR0ZIQWlsQTB6eXFJMk1RQmd0Y2U0MnMwNC8vVkc3cTdkSVFLYmRO?=
 =?utf-8?B?ZjMzZFk0VC9xUkNhNE1XY2UzNVJTV2dmd0g0WTZJSnNCYXFqNk9BRU1rdDdm?=
 =?utf-8?B?U09hUnkzTm11MUo5SFZtRE82MDVyQ3F6TmlpYlh6KzlwWnFnQ09TZFFDWnFC?=
 =?utf-8?B?K0ZSbTlkRTFCZHo5VHVDQ0ZxQmFvbm1PYTdkRUZqcmp4eHJKTWxMbTM3SUxu?=
 =?utf-8?B?dFBZdERVNVBGMEsxdS9YL1ZGQmpITWcwMU94SVdzR1dQWlg4MlpLVjdvbi91?=
 =?utf-8?B?UitqMUJmWVBpWFl3cDhocVI4S1BCSTJmV3M0UzYrRnlkVklORURUN203Mmsv?=
 =?utf-8?B?cFZyQjdGSWdhVGJWRXdPWVRxZ09UTTgrL2VYdE9nNk9CUEJGMzNzWlpjdDZL?=
 =?utf-8?B?ZDd3aWlOMjZPaHg1dGRSVTRLSEh6M3JGWGJackh4UVZXZ3p5NmczTU1SeHll?=
 =?utf-8?B?dkpjZDVZMnBYL3RXRVJrNHo1RGNVWHNkZjV4NldDeXJNbzl5Zit4UDV2U1dw?=
 =?utf-8?B?cjJLNmVydWxQT29vVTdDRk5mQWFJeUFadnZxRnkxbkNESVJ4ckN5MHZvOFFl?=
 =?utf-8?B?K2J2ZEZVQy9BNmJSdGVDdEIxZkk2c013Wmp5bTFESW1STDU2dWR0SnFUZmpV?=
 =?utf-8?B?a2Z1QXdpODVMSTBXTXFTV2tTeC9uVjRBSm1IbXZZaXRXTEY0cUR6VFZva2hR?=
 =?utf-8?B?aEhHNmFvNEx6SXZhcExTWG92UnZ6NXlaM0tiZ2N4R3hrcjFxVmdxRFdUV3RB?=
 =?utf-8?B?STNFTlMrRlBSRjNncGVFWG5QSzZia3ZJVHRWaE5MUG9KaUIySXVKdktzMWJu?=
 =?utf-8?B?aEhQN1RMQVpEQU54K3oxb2F5S1luYkpwRC9LZmx3REJ4OG05THptT2ZiN0to?=
 =?utf-8?B?NmxFM3UzeXVxcWlDWndvV2o4OXA2b3crcUZyV3ByT2F0WGFnRnpEOFdEZzdD?=
 =?utf-8?B?STFxYUphUml5eWkzVWx3UU4waVE2OGh6MzR6Y1FaYWRiMVRBWDFVbDVFNXFW?=
 =?utf-8?B?ZGVLOHEvQUMzb1JNU0tMZXoxenBqSS9DWTNlblhTL0dSa3g0MEZZQnJhQ0lE?=
 =?utf-8?B?M2dJdlhVRktXQW9RQXBRZlNkMVRlL0lkZFgvVTdoazYzd3NWdjFmRDVRZkxx?=
 =?utf-8?B?V1F5TkZMbkVOVTk5L294MFNtMHFMeStET3RmSXVpNHMwR1pkVHI1bExsMFMy?=
 =?utf-8?B?SWpnZlFDcGNmdmdtSVVJazRoMStQbTZCSnN0NWszdlNjZ0FrMWUwVTNHVURa?=
 =?utf-8?B?OVZjSEdPMzB2cGZxSkZaMThjWU51eUc2bzdxb0t5OWlpNmQ1YUk1SzBoQyt4?=
 =?utf-8?B?b2xCUkpHM0J4Z203bmFra24vWitOc3ZzZnFCQzJ5U3I1b0oxTXZ4bUxJMGdu?=
 =?utf-8?B?ZS9TZEIyNkI2OFhQVUgrdDJURThEL1JDMnZSMW9FTjFLRE0vWkpCZmNmSDhW?=
 =?utf-8?B?czRIVFF4OElodXlIVUY3ZmJZQk04Nks5R1A5U1RWWmZCeHBMUDFZdzRiaHZw?=
 =?utf-8?B?NHh1bTJXSjVSVnNPamxpZDUwVGFCWHNSMzIrbExUUVNFRGhOLy9hZGFEWUZp?=
 =?utf-8?B?dXZJcnJXWXlaVENuUzk5TGdqTXZjRTdMaGFoajBHWTB4RFl2QXBOR1FyRUFV?=
 =?utf-8?B?WUZhSEs5Ty8rU3A5ek1scHErM2FLelFCTEd3ZU90V0VPV0ErRlFpRkNsWWNI?=
 =?utf-8?Q?nNHDCN2LDg4AC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGZzaGUwcGhPTVdUU1BNZ0kycS9VQ1RGTWlQZ0ZDOVh0MWoyc255dk9OS2VO?=
 =?utf-8?B?Q3FMZGttd3ZJNDNxT1V3U29nUnNIZ01RSjQwVUEzaVQ1V0VUT25qWE5QTVdR?=
 =?utf-8?B?VXlIUkRkL09SdmsyaXl4Znp2WEpLMDRDMVZtSnRmY1NwTmVFaUc3eHkwUEUw?=
 =?utf-8?B?VitFK2U0amFWN0hURXZlWkp3Y203V25PMy9OR0tGMjF1azNVRDRXdWp1Szdy?=
 =?utf-8?B?bkZadGVNZElVUUZ4OWd4WklmaEJtZ3dsQnNtaGw2V0E4QWFHeTJwZkdDY0FX?=
 =?utf-8?B?c0tLUXRieDI2ZlROMjU3a3VwYmk1bHcvdEN2ZFpvTk1oK3BtRHhRVnJNbHor?=
 =?utf-8?B?VW9FSXh5QmpFYm5COHY1ZThYUHk4di9ackl5Rm03N3NDNlo2dm5PcHlhZklZ?=
 =?utf-8?B?UEk4QUIvVmtCeXJXY0F1NzgyQUpxZTg3MUJxU3dyeUtPTHVCWHRwTUdtTmQ5?=
 =?utf-8?B?RXQwczF6UXVTZmJZcEZ6N1FjWjRPUmZFd2JBMC9VY0NhQjJQbDljd29HVXZV?=
 =?utf-8?B?QkplTlVvK1d2eVFDOHptTy9nbHBjWFR3WDFaaVAxaVVXYXpCWG9ONmZPNGI5?=
 =?utf-8?B?Z3pHakFwR2FURW1NUHp5YS80RXRpbDV6d2JTNGNVRjk1dDN4VnZNelloNTRy?=
 =?utf-8?B?NEt4N29nd3lzQXl1aU8xNVJTREFsSk8xd2NtaUdMdG95L01MSzl4YWJRMUlu?=
 =?utf-8?B?Sy83RnFIeCtQQkRFTmg0cVV4TDJUcGtndjk2NlZmYkhiRnVFS0lFSGZUVEFN?=
 =?utf-8?B?UGVzQjBMY1RWQlJwd3JraDF0RFFwaVBzRkVmcE9ra0pQUEM1YlFLeVBvTHhU?=
 =?utf-8?B?MStUQlgzQlNPNng2eTI5bWpMQWhEc3hMbkFpY3ZXMmNRTndNYVVZb2hNL1J4?=
 =?utf-8?B?VlZORy9LM05SRzlSMmN5Qks0T2JZRld4Mk9BUS9CWHNjeGRhay8vNzV2RW1u?=
 =?utf-8?B?LzFiYUNyZTc4T0RTTm9jZFlDVE9QbFNzVkhaKytSQ2sveG1OVkIyZkFVdm13?=
 =?utf-8?B?L3FUTlh2WDNZazVGREdLNjdtaG42enVSUnhVRTVKeVZ0K0RNTlBNd0pZaVU5?=
 =?utf-8?B?U1FqZ3hLZzlNVUZ4Vml2bmt5K0hvZlJlajZaeTV1bS8wMTVwV1pibUF5TlJC?=
 =?utf-8?B?T0JWQklKUUwwZUhVUTM3bDlYUDdyS0V2RTBLUXBxeHF4VW1UNXJoQy81WEEz?=
 =?utf-8?B?VkZRUnhiYTY4bzZwaEdpOHlNZG41NVdZYSs5amw4VjRtcC9NanQ4NEdwbGI0?=
 =?utf-8?B?cDJuaU9WUUNuNWhqVnZFZzZTTXNjOGVaTTRESmFsbkhsMjV3L2Z4ZmFkWkx4?=
 =?utf-8?B?MCtPc0JucEd1S1hUWnVZRGxVdVROTHJHK01JTXdPVjBEWE0xbVpObEx0OWE1?=
 =?utf-8?B?MWUwTE9JQ2ZtMXNJL2RQUmtOYjBRRVRuNnBhcWMzTUZveStXbGtpb2o0akFr?=
 =?utf-8?B?R3JPOXh6b3Bzb2lsZEM1cEZHQy81SVE3a09PZ0l0VkpHaWYyMjM4L0lvWW5S?=
 =?utf-8?B?aWdtTS9ibjdJQUVzNzlTQTdGVjdFQnB3VVF3OFlGZktQdnAydFBoSmNsTU9G?=
 =?utf-8?B?L0lCMXJYc2k1Mm1iU05ieG5YK3djNG1Ub29vTDcvTEhrOW5UV2tPQWxER1Zu?=
 =?utf-8?B?SWNkN2Z4ZG4yblVCUXZ6QkZ4MHNjbmswd0tXSThzWUNUdnFaS2hOZ3JRQ0tX?=
 =?utf-8?B?OU9FOURSSHY5S21yWko2UUhkZ3BBYU96Mmw0YW5RdnJhNERQRjlndGNpNWVV?=
 =?utf-8?B?dnp5NWxTcWVIMmVmVmVwNmd3bXRsdjVraEF6MHk2Y3hoTCsyU0xCTnN2YXV2?=
 =?utf-8?B?OXRrd3djaHd1SW1qYWJHNHNQTHRsdlhoa1FJYklWT0tWN1dWK0ppQ3JUUDc0?=
 =?utf-8?B?OC9yK1hKcUlzY0VVd2pKeFZqeU1Hd2pOM0JuQlVueXcxaGlMVU5xaHE5cFds?=
 =?utf-8?B?UEV6TU9QNlZqc2lBY2h5QjJqcTl6RC81aUNOMUIreUtrdzYvV1lOYkVHVE4x?=
 =?utf-8?B?MjR2MjdEUTByaU8yUVZCYTh5Q0pMVW5hZ0ExVW9Ya2F1V21HMldJbTZxM3Rv?=
 =?utf-8?B?YnpjdVJBMGNqTDEvUXhjTGtlZmlCVGJWYzVsMFRyU0dBckNBQ0QvUmtpSGRx?=
 =?utf-8?B?cGs4aS9tNHNUUFV4dlJuVk1GM3daZWlmOWhGT3F2RklmQkpFWDYycFcrS041?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d14b8fa-3d4e-4f45-86df-08dd34f322bd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:28:22.3050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U30IIpTrp1C+VtGHmuTdvThITYVYdh4G/fiEou4Krz+MEOeaMnUsUsDN9aDjXMyoY24CrSVXwtyo+ii4QosreYW1Tw/p0qp3nrSR8XsWFKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8170
X-OriginatorOrg: intel.com



On 1/14/25 3:25 PM, Shuah Khan wrote:
> 
> Thank you for bumping it up to top of my Inbox.
> I will apply these for 6.14-rc1 now.
> 

Thank you very much Shuah.

Reinette


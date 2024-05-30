Return-Path: <linux-kselftest+bounces-10975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF108D5685
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 01:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1581C21C5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A491862A6;
	Thu, 30 May 2024 23:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T21rF4wE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8548186298;
	Thu, 30 May 2024 23:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113105; cv=fail; b=jUsqG/BjFUgvKuwqbEgB3zh1up+u/Q+d/PKVQP+pCm4QlB7aHPve3paAd7kalZCkZMJhe7dNBpPoD/Y8+YAF+OwiaXoCPSAK8kOW01E2XrRImjxR6cO8rCZN6+j+aNygJJcMMNpG2HGulOlAKina/v1s5atQqHJQHTltUdTNtU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113105; c=relaxed/simple;
	bh=h46yNoclT35tHRodqizVjNlSYadc4hoVDGjRuQ61Pmc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WxbM9gRLAv4d4IgGQ22Luci1aMM9whXwRUEX3GLhgnipIRk1PPGQspZmFOpSIlDcBHZ6QEF/9SQSyimkZFqKyYu7bhdYT+yxZoBqG7l80Nanz83dI08QXlsuJxbRCRZQZlVKVRUo1STtDxzBndbmf1oE4ojloqW9+RG9QgDzOIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T21rF4wE; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717113104; x=1748649104;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h46yNoclT35tHRodqizVjNlSYadc4hoVDGjRuQ61Pmc=;
  b=T21rF4wE+GABTQQpyZGr96GXtdAuGBROSFlVYPiQ1qYIBbyQEwKu8gzx
   Rj6Sq22pO7UKUg/U87Ncl1EZ7B5hgsIwdLQGHKRiiHubwmo28cJ6pEC2J
   TVJPyOOjyvJ51j7+A7N2PJHfQInAZCI5Bj6wqSdfrln9F6F+lyAzVMkNn
   JbLzwIkJCmJ7l9sqEtHUH6ZPVjSZ1+EnRM0hUN6qVRuQhnOZqRC5WbCgc
   05fks5JZlHpNe9PW8kfxdujofyH62W/BZcJXVvBCzDZgajW6rHx9kEXi2
   1BOywPdUf/WO1Agr7CxDpWAkd06jEGAyQtBy48Mlg61W510OgK1tdgCXD
   A==;
X-CSE-ConnectionGUID: r5I/QhsQSQe12nNO7J+47w==
X-CSE-MsgGUID: 8wxgD2M2RUGX7t5vcYmjZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13595434"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13595434"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 16:51:44 -0700
X-CSE-ConnectionGUID: Ojpj58KdQb+8cM+ITXIV2w==
X-CSE-MsgGUID: n71JmIN1Roqd9oO29dRsMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36604013"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 16:51:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 16:51:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 16:51:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 16:51:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPiLjYH9bXgf2gfjMlxJFYH8Gw9lwT3DiR1Sy9hCJS9VPY9IQ3l58H4Yt7aTEc2Bpp4cd3vKF2TwaEVLDuHvhk/SgKZrRbD67CntKeYacb2mT8TB7bgaIfmr9xgG4J/26kK+m75plFssV6BpbmMblqWGxQnVd9JqWKfRjrRIc8h+lxOKK/C9mv3CdX0zwXzL91OFQHN9YVgn/7YGoj60D4ydWR0TJw6VY5700qVDSS/N4YwX93kDf6NVwgHC2y2uL0ilU5fMgwL8UiYYmBMmdvzCupS1rSgXT37e/R2UVpOdIt2DWozTj6cr6KVDPGtMbSOSJe0NKSN2kXlKUU53oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWGgY/6iaDQ3p5NgNgb3yLntYkwWpQZE78S/l+9Zjvs=;
 b=AIo2nL+U0FGx9uuNcPVoJ6m4PTe1Ttt6V7sufMVVhkZTeD+2MrDa+HbMzUInJayWojQtA1jNYLeP+D5MPYpbxwDKuztUAgl78Kp3cBohLemHTbKM0chUWZkFRO/BqjJZ+8Tz1XBJcQj/F7dem2RWhqqEB0sy1QM5+cgticbFl8FCLnNzQqwsn9weVpz1HV7rhGGPC9QjW7EblhCMLMSpt/p//nrtVSeEjB7vVaI36R9VbCPGftL8QiQu5nsVnqwYd8TORTkRlJavfM+EJYdTN+wUFFNn4I3z+lHMlALCdcg+nEJw8uk2HN3w0qBXC5cy5BSQXul3csWUxIhGicpcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 23:51:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 23:51:35 +0000
Message-ID: <992cd5db-1cc8-4238-879b-8ef0406edc33@intel.com>
Date: Thu, 30 May 2024 16:51:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
To: "Luck, Tony" <tony.luck@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
 <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
 <SJ1PR11MB60833CF8BD209555A5370299FCF32@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60833CF8BD209555A5370299FCF32@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0290.namprd04.prod.outlook.com
 (2603:10b6:303:89::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e4629d-8ed7-45a5-bef3-08dc81037056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emRuektCcm9uS3ErYkplb0t1SGtpZFdaK0d4Q0NaKzE4a05tN2g0NEpFZ3Bl?=
 =?utf-8?B?ZE5XUVRKWUdnUllYM0x6d1Y2cmZaTk1EWExVUSthaWgzS1VtdkhvTGhVUVBH?=
 =?utf-8?B?SXFCRW51aGpyL0dsdVkwMVZEME5SWXY0RGUyT2JDdDB3OFk2b0t0RGdwRE9P?=
 =?utf-8?B?ZHBYZjFncGZzVk9ZZW5mM05lb21XeXFLU1JtaU9SZHpHMmhmKzdEcEVFMDR0?=
 =?utf-8?B?aGZ5REVuRmY2dERRQkNvUnc1QXNHWE02U0xKLzI2azRweW4rdzRGTzU2a3Fm?=
 =?utf-8?B?VFZmK3h3Q3JyRmtpUmpnaWloS1l2amNRdlREVE02cTB2eGtyWklBTGVGdnNa?=
 =?utf-8?B?RHBKYi93bXJwVHVPUjc4eU1CaTByUTJWblpjb3dXZU5XN0E0TmEzb1V2VUpY?=
 =?utf-8?B?VndIT20vUXhrK3A2c3RscEdiMEhFdEw2Y2tRUURHT2loRWVPQnhhYTBxNUFi?=
 =?utf-8?B?L0Z1MDRmbGFITllOZktSN2JuRTM3QXdXWGtjYTdhRGJVa1FraUV3REFrV3Rq?=
 =?utf-8?B?dXZibkNaTXNiUTJQejM5ZFRxT2hlVXVJOVRFUUdTcDM1a0V3TkFUTkJvWlB6?=
 =?utf-8?B?WUFZWDlZMjQvUU0zQXVSZVF3ZHIrVVhHSGdEVjZlTVpvc3J1U0FLdnp0TjFG?=
 =?utf-8?B?a2d2RXhzdFBPd2hRRjM1c0ZHYVNIQVEyMUhWTk1qam5IZEJYSHhDSU1sdWNl?=
 =?utf-8?B?TGowcGR4WlhUdDlaL2Vkb1FnS0paeFZUR1pPemc4cGFCL3dKV3ZoKzNIM3Ev?=
 =?utf-8?B?eHVTdUVlS0pqblZuN3NEY3VpYktDWDhXRHE3UlE2Mng4QjZVcWxjK2hwNUtx?=
 =?utf-8?B?OW40YmE1SkJ0Qy92SVRhY2FhQVF0MEVWOGRaV0VzOUIzejZ6R1EwWEQ1TTZF?=
 =?utf-8?B?dHcrWDRyUVVNUHcxd1FuRk81UXZoUmUwT2p6M0RWcjI4emd2bmhFV2FwNDI4?=
 =?utf-8?B?VmEvRjgyWGQxV2ltK3VxYlZ4dTN4YUV3US95UlBONTczQndzbGtlVGVBMk1Q?=
 =?utf-8?B?eWJDaW1NK2s1aVgzZDk3N2lDeGs4MENNSTFFRGdqQ1VibjFpeUFyVUZFNWtT?=
 =?utf-8?B?MlhHeGhxL0RoR1RQSi9GQjBQS2UwUHpnaHkvTEllWUdTYzVyZHY2ZjNESG5n?=
 =?utf-8?B?cWdKaGdqUFBEaVFzcEVKVFowUEx5Tyt4Z0cyaFhuWTNBb2MvZWhDZWxzcG1m?=
 =?utf-8?B?YUo1WE1hZG03MWszQlBKRElMcm1ZRWJVYWErM1pEZVJmejJ2T0s5TGxKVmgr?=
 =?utf-8?B?YnY5bU90NkU5YWFHVUJuQjBXZlFETno1YW5CMXBrMHB5ZmhCOXZLL2g1Z0hq?=
 =?utf-8?B?bjNHR0xGWjViZENvbERaLytYcUhycFlhRFM0amYvbFVDNWloRFIzcSswUWV6?=
 =?utf-8?B?MUlMWUdnUUdqT3U5Zm1LYUliTmxvN2xHTkc2dGxETmRXMXY3aDZDeEgzUmNQ?=
 =?utf-8?B?dktsUGhWZmlNN0wrRkg5c083dCtCcVBFVU9HUnV4eXNnZnBwU2hBTFdwakIy?=
 =?utf-8?B?dUVPUElBSTRyQW9UWmxPQlVkTVpoK1lJSXVxQklrZ3FxRzVGbkpSRnR5VW1Z?=
 =?utf-8?B?VmJuVDVOVzU1azk5QS82eGdMeXg2b3h3WlArTmNSWkJDSUszUWNacWtjNDRo?=
 =?utf-8?B?T2Y0WUFXQmU1ZU5wWjQ0Q1h0dUt5OXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmI4ZThSZkNsRitsODdselFlNXIwK3dTK0xvNEVyU2xqMU12c2J2L2Q3OUl2?=
 =?utf-8?B?dnVxdnZxYjFJZFdvaGY3aFlXbzk1eXl6S05lMHBpaVZYM1YwTDIzQkFwM1Bx?=
 =?utf-8?B?NWUyUTQrK1R3YThrMzdadkZwMmFJT0c1VXRrWUMyQVY2amZ5UzRXUlZ1b3pY?=
 =?utf-8?B?YjlmQjBmY2RuTnBpUGs3R1orYzFYQnNrRkswZVNDSjVaUHVnTytyUk5rU1ph?=
 =?utf-8?B?RWtPVUIxaG1YQ0xmY1BQQjBaRXlzb3JmbzhCd1RtT1hBdUFtYWNTVG9pVWI0?=
 =?utf-8?B?U3o2cEFqNzVPTEYwb2o5elhMcGlFdmdab2d4Q1plcTFOOGV0L2cxem9aZ0Zu?=
 =?utf-8?B?MGNTVmNhLzgvVjYyMWN6T2RhYUtzREVQdkMrbEpFVUpIdXozVjN2OWExOW9B?=
 =?utf-8?B?eDJTeG4yTThCaGQ5WVhmRElNTzlTV29FMjFQNzNGU0tDOXRqRVVWMVJwTTNP?=
 =?utf-8?B?RndHZW8vaENPSEdzMExKR2pnc0N0KzVXRXhSalQrZUQ0YzlvNDlSdU0zSGJj?=
 =?utf-8?B?OE5rb2IrWk1XTzY3WlBXZFUvcnR6UjB4cDN6QXBzSFlYNmhQSGdWdjRDREFH?=
 =?utf-8?B?WC91TXpSdzJFMDV5OFJ0WWNnaFE3TExDb2V3bmJtdWJUb2tCcit2aUdwZy9G?=
 =?utf-8?B?OU5xYWdlVi9wV0k0aXB5OFpHRFhnU1BRdzNlQUdCTHYvY0JDMEVLa3ZoNDlu?=
 =?utf-8?B?alN3aHp3SUMwdGJueURGbS9KenRNa3U2Z1h5L3lWbFF2UFVsWmdPM3BGeS9z?=
 =?utf-8?B?SHNpT2dVVDZWNGk0clJhNUlDQkNZcUErT281VkE3cmJpcnNPQ3Eva3FBWlRW?=
 =?utf-8?B?bVZRVGtVZHpldEhrTzkzM0psUXBvTCtpK2lxMzEyTGdnVzhIb3g4Qm9ZalB0?=
 =?utf-8?B?RjVkZGgrTkJHTENlMEZoZlV4MnY2OVZOTEJ6dlZKYzFVYjVFTE5nMEJFVDNs?=
 =?utf-8?B?ZjVQUFZ6OHVRc0JXaHluVzY4UUtQN0RkTjZmWE5IUERWTkJJRlM1UHVRTUVY?=
 =?utf-8?B?MVZNR09rM1hraW9lL1pIN0EwZDZncjVMSXRXR1VoZ1RpUi9sZ2pCSGRKNW4w?=
 =?utf-8?B?UUJXelJJT0IrZC9jaGRqSTJoMkpkWlVydTVjRjY1RG9GRWMvTi9XOFFxTXlG?=
 =?utf-8?B?QmozRUZyUjd2ZmIzWmhvV29NU0NkcE0zQ0F1ZmQzZTdBcGtvbmNIRVYxVE05?=
 =?utf-8?B?RHdQZjFCYWF2bWppaTNZMkMrU2szeVdNeWx3bWFSdEdmN3N4NXp1ajZESUZY?=
 =?utf-8?B?RVR3ZlJoRGdNcFNiVVhXbk95TFc0UExRc0w3S0gvaWgvRzB0KzFGbHJxcWE4?=
 =?utf-8?B?aVFicXdPSVVzT2c0cjhtV2lxMFd6Tm9zb3NGNjl6TGVLRHdzenZvVTM0cm53?=
 =?utf-8?B?Y1lMc2FQQm5UVFR5UlhhUlZpSkE5NGtsTCt3T0NSaHFLRE1ZYk1JQTU5Kzhr?=
 =?utf-8?B?R20rVnZJL0tTRHYrRGtQRGZobmR3aGdFQnJiZEVxRFM5ZmVjQXB2YnR6Z2pa?=
 =?utf-8?B?UlhyWkJ0VlJmVktpU2dqeTlYYVFkM3BiaHo1SHlHYTlIZnRidFpGQU53ZGJm?=
 =?utf-8?B?STJkeDFKTXQ2b280QSthOUd4bTJkNUJhMThraTRRUEZQYVdqRUt1Wkw5Q2Js?=
 =?utf-8?B?UTZwNGxqSnd3ejVSckM0RGRSWmZ0SGhXYTJJZGNEMHRjUjl5SXZGdnRwbUZa?=
 =?utf-8?B?Qk5hbUR1VmJPZ1lld3gzcWZYbnlqRXErcGVjcHk5d1ozMzdaTDBBRjFjdDd2?=
 =?utf-8?B?dmx5MEdIZjhhcjZORVFxTFFNSFNORGlwTTI2M3F4TmJkSlJXcWI1SVNwTGU1?=
 =?utf-8?B?c1ZaNWZPRjVFcEltOXhQaHBTN043MlBjd05sWEx3MVl1NkxnQ3h5UkRCdnBi?=
 =?utf-8?B?M0pjaWF4WXAweTFuU25waDNrTnlwaFdhcjRVVlZMUE1pbS9qOUJIY01jZHZy?=
 =?utf-8?B?RHY1dm1ubzJkUldIV3hYbmd6M2ozcUU4c3dRNkZ5dzFTdW1UdGZmdGhoL05S?=
 =?utf-8?B?a3RlZ0dZajAyOGFVREtLUWF6OU9OeHA1Y0Q3RnVYUFJmYSthS3NvSXVmYjZF?=
 =?utf-8?B?VmNrL0RiY2d4QjdOY0NNTDF5VkJIV1cxanFoNmtpc1JpTFJzaWFOOXFJL012?=
 =?utf-8?B?UVJjT20wRkFKZkdmaUdvbG8vZE5xUzA1aDVZN01vSFRlOHZOSW1wUzA1emZ1?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e4629d-8ed7-45a5-bef3-08dc81037056
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 23:51:35.0895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SebOemQjMg3VG5XTeI8eLzYJog0Sm+rUgLFY1ON/bfLeNACJoPUhlezwo4hGG6cRWK11N5FlzVjva59EoiFpcY+PdV1zt0yHWp577uYEyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8498
X-OriginatorOrg: intel.com

Hi Tony,

On 5/30/24 4:46 PM, Luck, Tony wrote:
>>> When SNC mode is enabled the effective amount of L3 cache available
>>> for allocation is divided by the number of nodes per L3.
>>
>> This was a mistake in original implementation and no longer done.
> 
> My original kernel code adjusted value reported in the "size" file in resctrl.
> That's no longer done because the effective size depends on how applications
> are allocating and using memory. Since the kernel can't know that, it
> seemed best to just report the total size of the cache.
> 
> But I think the resctrl tests still need to take this into account when running
> llc_occupancy tests.
> 
> E.g. on a 2-way SNC system with a 100MB L3 cache a test that allocates
> memory from its local SNC node (default behavior without using libnuma)
> will only see 50 MB llc_occupancy with a fully populated L3 mask in the
> schemata file.

This seems to contradict the "Cache and memory bandwidth allocation features
continue to operate at the scope of the L3 cache." statement from [1]?

Reinette

[1] https://lore.kernel.org/lkml/20240528222006.58283-1-tony.luck@intel.com/


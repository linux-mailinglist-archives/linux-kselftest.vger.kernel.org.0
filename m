Return-Path: <linux-kselftest+bounces-11026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B965B8D669D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5801C2505F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015A616936F;
	Fri, 31 May 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSJEhiH5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED84C15B128;
	Fri, 31 May 2024 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172276; cv=fail; b=C24opIwRYqDIgjoHdhDPl9x4s5beXnvDbWrkxbLPc+CW/wdWsgJN1lUJGYR+/rGDpekdgJbKc4Anf8ZCtgitR7X7wjVyE38BVPq3euEPmN8df5+F2XLme9D+3XC10FE8UNjWQxRauMGbIptrsC7WFmd61tY4mdJC5IpRQwZZGbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172276; c=relaxed/simple;
	bh=o4VMpdWdINEY0cCSjoyLAxvvw6IQbiRZJy9s7UGvE/o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=an+5deVtMU8xp8WokCGtP3LcEUIILFyXfreI5U6D7pmMGJIkCIo3oLUEH+YJ6vwezZFzPTFa9H76+x1Q9FSY01uP1/HVHtnAXC4LIesJANhsYKphjHWrmoUN3XanAsu0v6CIncOle1E2tJWjlxXYx4tzYWwVH6ozJ0y+sjfHmgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSJEhiH5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717172275; x=1748708275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o4VMpdWdINEY0cCSjoyLAxvvw6IQbiRZJy9s7UGvE/o=;
  b=JSJEhiH5gu1issgPDXbmJVwbv8gkKhKBtfaZhlLIjruLShFOPscAdRIv
   3Wmpphs4L21ktkG9ypxIUWx1xTWT6IjiaSq+GWOgiIcteuRV9VQFWaroL
   C5hDezh0tbHMKq/NmA22OqctcA6HaakEMMyKHSka7vzLse7C/ZoVvG/QO
   X1k6ROMVTXgvp8CSn6o3yVGlo1FmPAU24rucZhU4EV+UY0h55TuHvmQFo
   9B/rZ817WNi1/yECdyh7QWsjICLUyeg0L3yGYDw9pC7+2cttL5BHIHukV
   eqJTs20r+NtpaSMR4pUqMvsOJC8Rz3KFA9jrzrwT2ma+m66ua9PjTD3Ys
   g==;
X-CSE-ConnectionGUID: VS5OSXGLRNeCbQD60bLK3g==
X-CSE-MsgGUID: ch1CnxW0TA613joGKyjMlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13672952"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13672952"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 09:17:55 -0700
X-CSE-ConnectionGUID: eIIVRU+oRXeV4nUebXiZfg==
X-CSE-MsgGUID: bJ7mNmMASWyPKGgEVp5PyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="40654455"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 09:17:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 09:17:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 09:17:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 09:17:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 09:17:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyHWguQmk5VA3T9dqfBCbACD3zhdfdjHsqILFeSHr5tqGKwjHpTcrg9lnwQe1ZJXjpnIL8bR+j7i3qQJZwcnSPxAYF1csOe0mbgfk2cEjEP1BgxosmrjW19Csq+PR9vPeknYxOzufJqfsJPI6P1R6VAQ9WlX8BGsBJaIvFP87jtdlcznCS9eb8kXSxZHrQgpNe6PnAfN62jOVOG5oUHaW2t7QlqL6ydavMD3Dd1WTjqKFtRIGdagr0NR6EPy//3DzrxOPZNNcDx4R59c53P78G7zhtyzsHWaR8uEdRSHfoCOtlqnPishlYUYC1w8USk0ZkaoCUGGHhb27wjNo75m3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sxFtcpEpwK6aJsRlY/eKfUVO+rcwC10z+TRd0FeimE=;
 b=aZO9ORBsEUayFd6u1J3rUOdwdnkZSz1q8+Ad+hHicBN9Z8fpBf8r18AQg6Vb8b1gGPkgRBDqwCuWPmkpe2XffLdJDGd5EH2FRfZ/4X/uTEpSbSo6ZLcesn3W+Ily7cWUVVoIN8yR5DjJlFPPmMwId3s4DYVwcOsvBj9lLj480TR8OVgOEAsXRMuUuIgqNFkxMiCEjknrYBqziU/SBYf0M8UZXRSRmwMbdgj/3SNY+njTSjhFgmhCe5W0X8YBtgUdXDmC42qXVTQljgPr7+akWAtwNX17UUAR07BOwDGjfKmw+OJCxYwA7lGFgRl1eSaO6FxmdPZac36u4WKDVEXGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6845.namprd11.prod.outlook.com (2603:10b6:806:29f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 16:17:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Fri, 31 May 2024
 16:17:48 +0000
Message-ID: <07325558-c816-42ec-9f74-464df2f98e9f@intel.com>
Date: Fri, 31 May 2024 09:17:46 -0700
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
 <992cd5db-1cc8-4238-879b-8ef0406edc33@intel.com>
 <SJ1PR11MB60835941880FC77E1B1E9FEFFCFC2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60835941880FC77E1B1E9FEFFCFC2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:303:8d::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: efb21aef-c31d-469a-1e08-08dc818d368e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NURJT1VOZzFsL0NpVENRSC9iWkJXL0x2YkRnZTZ4cS9Gb1RkMlN1VFF1V1dk?=
 =?utf-8?B?djE5WEhHRlYwSnMwNTRXaHpDbVRiOEltNWFnQzIwYUVjcTlyV1VGTFh6OHU0?=
 =?utf-8?B?WGxMSmtTbjg5V0xFa2pTdGlwQUNXcDNvMkNYblI2YUlnUWFpLzZPQmh5cm1z?=
 =?utf-8?B?YlNFOTFya2dDM0JmRHBOSnVkMldUblFiTnlLVzRuZzVaZHZUNEMyVzJKSlpR?=
 =?utf-8?B?ZWVySEFFN3dTR25tU2ZsZnVuS2lmQ0cxRFFmVGJneisrd2ZCK0lNRVI0cERY?=
 =?utf-8?B?SmtXZWtCUG8vY0VUZGNGc0VYU1ZqaWJwU0RpdDFkVjV6R2ZLSnRZMjFzNVpI?=
 =?utf-8?B?bDNnNEtRKzdNWkR3enZ4SXI0cEpFNUh4aFJGZXRPOVNTcVNZUGEzTHNWN0Mw?=
 =?utf-8?B?MXhlZ2ZaZTh4Z2NhVUtQeEhRSkJMbTZKb3ZHMWswODVTRDU0amYvL2VMNjIy?=
 =?utf-8?B?cWRYNklMYTBnRVdTcFhGcDJhTFNoOXk0Tm0zMno1WVpmMy9CdXBoRXRCcDhE?=
 =?utf-8?B?Z1M4ZEcxWnoyN29mdFVDWDhYN0xvbFFiNDByNXNLY2l4d3lTVGV2WGRUSldz?=
 =?utf-8?B?bjZWVit6MzNnMjJFNU90bElYYzVEZVRNZHYwMmsvalJtYnRkT2hDckJsUnRh?=
 =?utf-8?B?THhGSU0wVWo1ckt6QjdlMnhkRTQrT3dHcTJpS0pOMnJzVkpiWGFRd3NPanpK?=
 =?utf-8?B?MWVHMFowVG9FZnppdWFCeWZVbGxiWVgvYTNpNWtBbnQ5aGI0czd0Slg2TURQ?=
 =?utf-8?B?L0cxN0Q1V2hGa1RDb0ZWOEtQU0huNXZYZVlSalNzbGw3V1hUYjhEcVZHVE5n?=
 =?utf-8?B?WmxxNzZ6VU1iNzBuOXc2QmZmZ09CamhXYkJldExjQnRXZXhoRDZpVUlaTFdi?=
 =?utf-8?B?MnhwVGNVR1pWclhQS2hDelA5S2hlYjVKSFg4SnBWRk8wOUVsQWwrZkR5TFQ1?=
 =?utf-8?B?Z0pGY0RDMHpTbVZwcERoeUhRQjlLT2xaMDRvbStjM0l0VU43ZTlFRzh6SnZV?=
 =?utf-8?B?dk5WbjMvTW1McDlXVVNYL2xFcm9JdTNXSWduVVZaa0xRNUNJZ09WR2hCOHJI?=
 =?utf-8?B?WTFjSVRwYVB6MXlocFl3WXRyV2Vra21MUkl3LzRKZWJZUzRqQ2tnazR2OE1t?=
 =?utf-8?B?UjZvRFhsTU9HeEJ5U1k1cU1YUTV3V0xoeFpUTVRiMWJCc0NONmREdHdyMzFi?=
 =?utf-8?B?QW5FMVk1cHgwa2hqOTFRNEhUdEpwanROYU9YcTk3R0puM0c1Q2xNOVdlMEd4?=
 =?utf-8?B?dVhqSE10SHBCTnZHL1daTUU4S2tqSGVPM3VrTWQxdkNoL004a0dyeDJSRWJH?=
 =?utf-8?B?Wm8zWUNMN2hpOHJKUm1odmg1U0dnOEZXZHY3RmFhdjJZTHVyNkpyZUhhbHZy?=
 =?utf-8?B?bDc5M3RmV1haZjdHbllVZ1F2ZG9OcDhzaVAyaTAvYnhteFdUOUhmTWhEdTBE?=
 =?utf-8?B?TFpxaTBRdVFvTmg4RkJHWTdEWmgraGxIUmFPeTJ2WldvMXJTSTVnK2g2NnAr?=
 =?utf-8?B?b25rNUErQ1ppcGxqZUJQeUJKa0FHWHhjeDNQa282aitzNFlua3R4WFZyZHBZ?=
 =?utf-8?B?dW9LNm02WXd5SDlPWXJpRXFHdTRUWTBESVh4VmN5bnNhMHhjL296L1l3Y1NU?=
 =?utf-8?B?TDFsNVpZYXJSV1lSSWdicHZ4dG1LUEFuY1ZVeERCbTdWd1pHYnBqUm51cEFP?=
 =?utf-8?B?YTIxUG5qWlN0M2NUSjA2ZHh4NlgyTHVFUXNqZ3B0M3Vld2dQd2dVQWdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmJVOWhMNy9NS1E0Tm5RdDhvRk1oRlF0dUNxNUt4MHpIQ1R6KzE1Nm5RRmZK?=
 =?utf-8?B?R0lXVjFjRGRFSFdXZzIxblZ5cHlYd3FUL2Vnb2pUcm9FYnhoV3VrZm5BeHpt?=
 =?utf-8?B?aHpSSHUwc25tbW51MThZWnhGQ3F2VHFlbUV5Ukx2M0tIWDVvT1Y4VnBoTzho?=
 =?utf-8?B?ODhuRXB3UlF1MWRjRzlvam56SzZRVG14OVFzR3FhMzlJSUJmcVpnNnJOZ3Na?=
 =?utf-8?B?QnBvd01KcDFpWk84ZDdKcW91NnNNazMxYXBsbFM3VGc5Y3FqUzI1S0xJR1pv?=
 =?utf-8?B?T1JLcTcrMzBmaHZMTXZJVkdGMG40WnMyZEU4WGxYZThTZDFLeVlpUTFtVnNr?=
 =?utf-8?B?SE1CYkoyTVVWUkVSZkxjc1hmb0tnZmd3V2JtNDdkbmh0YUcrTllVUmtPSVk5?=
 =?utf-8?B?NU1rVVdKdDlFN3lXNCtQZEUyMUg2U2ZtRmRPbDZhQkd2ZlhIY1dHcTltRUxS?=
 =?utf-8?B?Z1lBYVFIQmJHTFRWdlhVQTJPRXkxczJlVmpGLzdYakQ5bVRLdGlMK3RDNDEv?=
 =?utf-8?B?U2wxenIrVG5BUVFPTFpabmpkOFQ3SVZuaXZRZUhXNTJ3dTRRZWZvQVF4Lzcr?=
 =?utf-8?B?Vm84ditsWS9IYk5uazFEUS9vZzh1bnRZMnZwN2UvdWMwbzFRdnhsalgvQkpP?=
 =?utf-8?B?NmNPTVlRaWN3S1M2MXlPS29hYThsTUpLOFVLbE9QTkx1dE9IaWg3MEN2ZmFu?=
 =?utf-8?B?OFVyMnJ4amtLQVJ3c2VCakYwQjFlS0VmYzVxRjlZVDFGK2hKZCtzVzNsN2t4?=
 =?utf-8?B?MHdLTU85QmJWQml6cXlqNHNwT3ZOTnlNK3J1aEc4L2R5eTFLbjRKeEFwd0J2?=
 =?utf-8?B?aVgxY2dwNFhqb2xRa2tvbGZTR2ViWldWaXhmRXVaM0c2bGo4KzR6bGV0RlIy?=
 =?utf-8?B?OWJwbFhoY05vWGt3Y3BLNnFkNHZLbjhLT1VEbU9Nd3ZlMjZJNVlIM01KVFhY?=
 =?utf-8?B?ZGdBWWFXRFhjOG5mVmFrbkQvMUkrK1RhakZpRHh0dUdpSVFaNGk1Y3l4bllK?=
 =?utf-8?B?ZXV3V3p5aWxvcVd4QThwdEJDSFc4Zkd1VlRBSGd1V0ZtL2poWkpQUVFKRHRL?=
 =?utf-8?B?R00vZXpLa3JyZzZpandXcmFMbHJoSTVyblV4d0dHVU5OY1ZVM2ppYlJyNGxY?=
 =?utf-8?B?eXVGMVVLZmEvYlNNNFVhMkhTTzg5N0g5Nmo2Ukg4cWE4UXk2bFJWQVR2dkVs?=
 =?utf-8?B?L2xneGVLRmg5dlYxcUNkRW9HWDlOc2ZYV0ZWL2lKV3pXd0ZVTDd4ZFpDTmNh?=
 =?utf-8?B?T0FqT1lFODVhNG1oekNIajNscndDMXVvbXFJazhtNVhkM2wwcmZZMVo0d3U3?=
 =?utf-8?B?QldVU0xIY0QrMVhFaDNWUG1uUnFmUk5HQnBudnA5N1lSc1dEaFZWcmNmM3RS?=
 =?utf-8?B?aW51NytOWDBXREd6VmFTRCt2M0QxeWFxK3BUSDg1dkJjZFpGZmU3TFM1V1l3?=
 =?utf-8?B?U2hoV3VpdmN5bzdtMTQySHphOHZTSDhNRHl2M3pMVWdJcEtvVmhzMThkQk4y?=
 =?utf-8?B?SFFxanoxejBRVlp3dmJ2UHc5NTJjZXJXK2ZQQTJIYWN2L2VsMFBQV3kxd2kz?=
 =?utf-8?B?bC9odFY1QlBXRVJXcEU5NGdDa2h6NVpvYmR5dmErckpnSDZBZmE2VDZlck02?=
 =?utf-8?B?b0tNSDFySzhGbHJHNFJXdzZTSkJWQnBrQlZFZ3NtS3RlbHFicWFGaDVMVjRS?=
 =?utf-8?B?ZENzTkh3RWNnaWdLVTEvQUtEcFJyL0ZqYkowRlZBMXVMMVExd0RtZ2lGYWto?=
 =?utf-8?B?NTh5Y1ppbXNtUHYzWG5RTVNkelhBMllkZ3h4WExoUXhlRkR2cUU3SzlCTS96?=
 =?utf-8?B?clJyeFFGTWJsTVlTWXNNN2swSHZBNDVOWjM5b2MvNnF0MDNQMnVMSTBoSzBy?=
 =?utf-8?B?OXVjNjV6QlJqQWdtaDVHcmozUk4rcFRPbTMvWHc4NU42cG1xOW0xSlBHOGJk?=
 =?utf-8?B?alhtWEZZWDVWRjYvam9xOFJYMDAxQU5EN0dRSlduMWVMMTN5bm9uUUo0dVhR?=
 =?utf-8?B?dVpvWmJyQU0rNmVzdFlTL1cvQ05lQXQ4UTU0ZFF2bjE5K3lXK3VkV1RGTDRC?=
 =?utf-8?B?dDhDT3F1d0Q5NFVBVkZDSnhBNENFZDVrd1ZNaTdzOG84OE1VVEVtdG9nMTY0?=
 =?utf-8?B?UHpvV2QvS1RMaXljU0FubEl1Y1NaN20zM1FRcmYvSGRNWlZRdFZZT29MelZq?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efb21aef-c31d-469a-1e08-08dc818d368e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:17:48.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /86e0fJobXSa5E4cnQbBd4B52a21EdKwO3hWhAVeE5RJCQUCYbilOopLMS9Ob3HsvBFVaNuKrqwlxt2luwTYPFvxJ3+qVThmQxaS7A/fhWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6845
X-OriginatorOrg: intel.com


Hi Tony and Maciej,

On 5/30/24 5:34 PM, Luck, Tony wrote:
>>>>> When SNC mode is enabled the effective amount of L3 cache available
>>>>> for allocation is divided by the number of nodes per L3.
>>>>
>>>> This was a mistake in original implementation and no longer done.
>>>
>>> My original kernel code adjusted value reported in the "size" file in resctrl.
>>> That's no longer done because the effective size depends on how applications
>>> are allocating and using memory. Since the kernel can't know that, it
>>> seemed best to just report the total size of the cache.
>>>
>>> But I think the resctrl tests still need to take this into account when running
>>> llc_occupancy tests.
>>>
>>> E.g. on a 2-way SNC system with a 100MB L3 cache a test that allocates
>>> memory from its local SNC node (default behavior without using libnuma)
>>> will only see 50 MB llc_occupancy with a fully populated L3 mask in the
>>> schemata file.
>>
>> This seems to contradict the "Cache and memory bandwidth allocation features
>> continue to operate at the scope of the L3 cache." statement from [1]?
> 
> I'll clean that up. MBA isn't affected. But cache allocation is affected in that
> the amount of cache represented by each bit in the masks in the schemata
> file is reduced by a factor equal to SNC nodes per L3 cache.

Thanks Tony. I trust that this is what Maciej intended since the change
is specifically named "Adjuct _effective_ L3 cache size". I'd like to
recommend that your comments be added before the change to
get_cache_size() ...

	/*
	 * The amount of cache represented by each bit in the masks
	 * in the schemata file is reduced by a factor equal to SNC
	 * nodes per L3 cache.
	 * E.g. on a SNC-2 system with a 100MB L3 cache a test that
	 * allocates memory from its local SNC node (default behavior
	 * without using libnuma) will only see 50 MB llc_occupancy
	 * with a fully populated L3 mask in the schemata file.
	 */

Reinette


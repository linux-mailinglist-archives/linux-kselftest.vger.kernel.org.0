Return-Path: <linux-kselftest+bounces-17436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF3196FEA6
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 02:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA741C21DA6
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 00:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB71647;
	Sat,  7 Sep 2024 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WY6o9PMx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010F14A35;
	Sat,  7 Sep 2024 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725667545; cv=fail; b=t80nNEuZY1sgNosPWu4u1UHJcJfoK9/MO4+9ddfPEtK065ddSIeWE6lE2nkN+m2ZWuhDKATYWzRjrScEBmzAsOShvZkF1XOIHWl1KSQY0iZeQxJObNI/CUn9CB3LeAVAsiKPc25GEw5W+UIBihNdSXDiA/fCIPwWrr4PsMoTzx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725667545; c=relaxed/simple;
	bh=BYM67UbjrvbjoNhh2HQV6Nm/2h6cV9CKFilpzdv4ECo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xhl7Man98m84z9aVCOkCdnnc7AswGGljX+IHYEZIHEzQbOxDyQpXJe4UR+mgD9ZJ0M9OXN2nu0GsixAYyZPliBb+JTcSIu0ft1TCe0qcWJMxa/NQZgEpLYghTpspEtif20/T1ydiu1b1WwQJAxWIfWy4YoWLWvk9dSm1afnS8j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WY6o9PMx; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725667543; x=1757203543;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BYM67UbjrvbjoNhh2HQV6Nm/2h6cV9CKFilpzdv4ECo=;
  b=WY6o9PMx6TNYnybZPgCkhKxCQYuvj3j8BegOV2wss5F09CQn4hlHINhg
   xej5kpUmoDi3YhaXHXBCh3skbwiX+1ftkLzxsSIiOcDl5csFsG7kPeros
   BnVa4XVOFo+zD8DEzMPF3hJRXOh1zOgDeKm0EYUB6m9fg80UAwedS7OPN
   82je8nEo7cwzieUXm7FwdkHMhQrHqE/2bmxt9OlVL3B6ZepaoY2iuhQG2
   DPlfC7HSlcJGJOpp9aBt1/WqVLd6df5klZDOhhcf3D1vi/ss40eLf1srV
   9oBgD/+6hdxbc7hf5rZif6h691NGaMF8JTOFW/4oGPF3qYePIT6F0eYSc
   A==;
X-CSE-ConnectionGUID: 1GDSCjILQfeULA+ka6nE0w==
X-CSE-MsgGUID: sqXiEYvzS02+Wt4xvccg3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24306576"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="24306576"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 17:05:43 -0700
X-CSE-ConnectionGUID: 9a/Np38wTwSGno/IgU4Zuw==
X-CSE-MsgGUID: LN6C4C76SpyqpeP3IdCfsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="66437376"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2024 17:05:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Sep 2024 17:05:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Sep 2024 17:05:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Sep 2024 17:05:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiNWZ2dQu9S1tVJg6/1DXlQ/bPIjoF/hSkWT5QbNCIRSyzEoSOoLIhWW7Rqm4nZyBdrIklkVqDSKLC5yNEjh8nkIi5eghKFbNXSbrsk89fP2hq/EbW8RX5lI9SmZ+9zFan6WnbxZ6i+hailqyX8UAHqQIr33Kur96btMQjqb7/1CQM3newGZvETtxlh9BEezUga0iCO24HwgQIOXBy8qHgeEHTMQE2bS8xpcT7fDHL4/RtLxh0lqb2WkLkojtDKN6YiI+BayXLUbHHY5epd/V8rTX8wN4IvCJyhsQb4dFpNqBoPFgRn780t8BBfJu+vfQ4nwry0QTbu/3haBxWcGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVHh0Mc2BXwVsLAoHv5GNuQYs8mXMaObZySpJCLV4KU=;
 b=CrbQezlYo4hGyRepYnglVBgRtFjIkY8n+0jrCbiH6FfJpjlUMpVyGu+V1vuK7qBxvD+WtSiATS6cynkbFHmme8N9zoWxTpPcT4KewqWWhARvvBgdgNhsBlAtmPK/RIK2ktgLlex3Hq35Rwam4pmaK++pnTylT0vlY+6tw1Y1X0VqZaH9mEIhm/4OjLTWEXRe+psEXmrWG8YdyjzMZMs4SDEPkw9XGL+laR1PUIxdvJR5joUmRWRRodf/O6QRmLcF9j7fmH3O38gN2RpEQHjqK/AB6LOdFpjjHXOvioWmJqxhLFxhJKFJa7D8KjX5dLJApzr6t6t+mLmaYrjWARyPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7259.namprd11.prod.outlook.com (2603:10b6:208:43c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sat, 7 Sep
 2024 00:05:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7918.024; Sat, 7 Sep 2024
 00:05:32 +0000
Message-ID: <a2c7baf1-1c69-45a5-8755-38d152d33fae@intel.com>
Date: Fri, 6 Sep 2024 17:05:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] selftests/resctrl: Do not compare performance
 counters and resctrl at low bandwidth
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1724970211.git.reinette.chatre@intel.com>
 <9bbefa3b9a62319698907d10e8b78f1b999c311b.1724970211.git.reinette.chatre@intel.com>
 <5d063290-9da4-c9ca-e5c5-cb0083d7483f@linux.intel.com>
 <87e4788c-6407-41a8-b201-e3f05064e5a6@intel.com>
 <238af9fe-0d7b-9bc1-9923-35ef74aad360@linux.intel.com>
 <9b2da518-89ce-4f9b-92f2-d317ed892886@intel.com>
 <1903ac13-5c9c-ef8d-78e0-417ac34a971b@linux.intel.com>
 <43b71606-be6a-495f-bec7-279bb812d4c8@intel.com>
 <c3aa4289-40aa-c158-8fde-8a35a6002783@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c3aa4289-40aa-c158-8fde-8a35a6002783@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:303:dc::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b4d693-bb16-4704-7e92-08dcced0ca0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWFsenhteFIrVjlXaXRhc1FhQ2RQUDNoYVVwbEp6dTdGQ1Y4RXlWcFhBK1BI?=
 =?utf-8?B?ejg4czFJZEpHZ0xqak9nTFRVVkd2NHU0bEhVTWpFakFxTVVxajJpUTVmdXhw?=
 =?utf-8?B?SXJjNjVaWkE1OVRxRmlLN3NGd3VvdWpQdTlYK3VCMjJ0UGI2aDJodWI0THlT?=
 =?utf-8?B?cThIeGwvZ2xYN1htS1pjKy9idUk0a3dMZlEvT1ZXWG1lbm5YUGMvU1gvK00v?=
 =?utf-8?B?UzdabVJGRGlsdXpibmgrUGhBK2FXYWxTcXRoT1lQSzJSQWtCTzNqc042SUI4?=
 =?utf-8?B?NXJ5ZjU1ZUFnR29UcVdPTmR0b3NXTFR1SzRhM0ZmclM0WVVxRUJ2K2lHK2FP?=
 =?utf-8?B?NHhySXJUNGhMR3M4dGtPa3lGNFd2SVIvS0ZGSlpIdEIrYjA4MTBZdStRVk5T?=
 =?utf-8?B?MkVsZGNjQUFmZGJZTlRVeFFpelNFVzg0VnZBWDhBQ0xpaHIyWFg0WDg0S3Zu?=
 =?utf-8?B?eUpNRFVPVU5NK1FiQXNxRUlaVElwVG05MzNQaDIyUzZFWENiTEozTjR5ZVBn?=
 =?utf-8?B?dDRzMDNXZklyVU1oZjhxOG81THk4d1dhdlRGcTlFQmp4eG5kWkxQbVBrTXBJ?=
 =?utf-8?B?UVVNbDFGSHhrQmlVNXl1bTVSOTBNT1VqckMrZHNTSlVRaUl3a1c0L2VodS93?=
 =?utf-8?B?VnBqaXJ3bU03c1Q3ODgxOEpvVEo1SmMyY0F4ZnBTdGRmSHRISW1ldUpVME0z?=
 =?utf-8?B?b04vbVMxUTlpb21XMG0rWDk2NlB1Vm9LRzhxdGlKRjc2MFNXWnZlcEhMbmVs?=
 =?utf-8?B?WmMyMGh1REpMTkc2WHREYlhaamxnVURQV2ZhZjJJSmxXMW9KcVN2cFlFS2c4?=
 =?utf-8?B?d0MvdisxV3RDRGFjZXpYaldwUDVINUE2MWliTEV1eVIzb3psZWMrVlhxclVN?=
 =?utf-8?B?YjljbnNSR3owdWF4UEJka28waGFkbWZlRkZ3QXZqYUdmNVNSbml1UlJZYlRu?=
 =?utf-8?B?ZWZPY2J6ODNFQzRrQ0hGT0pmN04vYTdFamd6VURiN0trUVp6Q05HbHhPYlY0?=
 =?utf-8?B?dVdIUy9XQlg5UnpMWk1vMGkrVEpQbWVBc1ZjRkJYM3R5Wml6RUJhb3VHcmNs?=
 =?utf-8?B?VWJxWU0rL3hSemFPNmJLTkVTenB3RWNVTkpFYVhHaE9XMWkvMStlc3hvZ1hp?=
 =?utf-8?B?UHVlSFVmM1krdC9CZjgxZ3dxdUNsNTdKS1ZaRm54cldRUFRVcHA5bEhTWlRx?=
 =?utf-8?B?Ti92RnVNRlUwRTF2Y3BuaDVINyt6UGQ0bFZxazRsRElMeERUM29KK0ZvT3ND?=
 =?utf-8?B?OXRETVROUk02RndOS2NkNUhKaStCU3hFdXRjaGdCWU1RaFk4VnVmWGpYenRJ?=
 =?utf-8?B?dGxDVEZLaTBMRzJiZ2twM0dYVi9YWk8xZ2FuN1JobkwrV3Q3ajNEU3VZdTVX?=
 =?utf-8?B?alo3Rm5hSDBTSFA0ME5zcXB5ZldIejd6NkIzV1Nsdm11aVVEWUc0UUtLU3Fo?=
 =?utf-8?B?VG5zd0VUeWF5bHJWVEJ0bkd2QmtnRXdHZnJEdWswUmY4NWQ0K3kwUnRSQk80?=
 =?utf-8?B?L3M3TTVYVnZjekdwY205dVhuUTczVUlFeDhxcWZ4Z2RrS0d3WENxTFpMS1pO?=
 =?utf-8?B?V1ZKNVFWN3g5MGtPT092VUxnODF0bzkzRXJXdVVZQ2ZiZmIwRlFVNDA2WTB3?=
 =?utf-8?B?UVB2d0M5bUdvYmxYQnNWNEFlcVRiUS9oaUtlU2FicEc3OExHZWdPUnZJOVVM?=
 =?utf-8?B?QWpOMkhvRDVFK2tueVVIVFdaMVFndUdya2xRYzhGZVhuakNoSzhzdW9PaElX?=
 =?utf-8?B?ZmNvU05qWXVJc05LdUY1TjdQMkJlVUErOTFOdXBHRkEwcW1raHVRam5lV0Er?=
 =?utf-8?B?U3RlRkVzWFh0cm5pb1pidz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0dDT1UrSG1TQUdxWEtGaFo0Q0p2UHUrcGY4MnZTSUlUZlRibVNBTWd4eldP?=
 =?utf-8?B?L1VxNmRvdWlWSjNUeFlDZ3F6SEJMODNOVEZ3aFhzUUNQeE80MnhIYkxCK1lw?=
 =?utf-8?B?cmNjS2UrSXR2eENWRCtLK1NrNGVLUWRwejd6WHhxcHd5ZTgzSTY5N1djZFl3?=
 =?utf-8?B?dmV4V2wxbkdpaERXanFtVUtqR3BTbHl2djMyckg4NnNGU3E2bEdvbEZzeFF5?=
 =?utf-8?B?RGc4U3piQW5MRUJab3BENU0vekphd01nVHoweis2czRKclpQTmFSaUhJRy9t?=
 =?utf-8?B?bGhQdmZPVXBMMmtuZm5pYjJOOVhGdVJzNXFYdmZQbzN2WVJ1STZKUzlXeVFJ?=
 =?utf-8?B?SitQYTNDMmFaMFVuN1pGZUhNWGN4Wm1Sbm5HOU9PYnQ0TzNGTHBqNkxHODda?=
 =?utf-8?B?OHhPTkhPYkYrUWJlaDc4L3d2MXRrcGNkL29oa2UxNlhieDVkc25wRlg3MU9o?=
 =?utf-8?B?WUxFTStLRDBQT2RnT25Pdm1XOWExR2tmRk1rcVRyUTVVN3pxQ3FJSTZPdHlG?=
 =?utf-8?B?c2FQL3JjNUhnbmdpdHRWZnlyWTNKUE0vaUMweFZqWklMWGtMSGxGMVRqbVN3?=
 =?utf-8?B?d1MxVWllUXp3SElydHBFRVIvQlhPa0ZQeml3RnA2Q1cxdG9NWFV6Vjh3cTVZ?=
 =?utf-8?B?YzNoYUZXT0ZzRVJzZy9idW9PMGpiRmljUTJCYmFtd1h6Um9Yd3NXOHUvcHo2?=
 =?utf-8?B?MFM5ejZHMDhqeFpYa0Exem5BT2FYT1h5ZHMzVHZ1YjdDc3ZQYUxrQnJDaDcw?=
 =?utf-8?B?alF2R3ZnV2ovSUloSGF5ekxsQTRqTkZwTFhRZjhmVVY5N3N0WFRBRkVmd1Jo?=
 =?utf-8?B?NVY4b1doTmhZUWRYSzBQem9OQjVjbzdSTHQxMjF2VENudHdMNmFIam5IQmRN?=
 =?utf-8?B?OEtkOU9NVW11UStVVVNHalVJTWdSRXowRWlYdU5GUzlvdUF3WmtCelMxVGJx?=
 =?utf-8?B?SUVkUkJLNWU0UTkyYi9keVZBSzRXV3MvSmhIekw5bFlSUnZGNXpYSFBJUitz?=
 =?utf-8?B?bnE1VFdSL3M0NXlYV2E4MVJzNFJCb2c0dFc5dGJMODB6MlJaV0xxcGtiY0ZW?=
 =?utf-8?B?YTBhNDVrQTJuNlY0Tnh1TWtwdE1kQXZhaUo2V2tQQXloUVUrYSsrYXhMZlBQ?=
 =?utf-8?B?MjlaSklNZmNDdDArYWdwVFBJWi9WdFpCOUI2MkxRM2I0V0dGVENiNnJLL2lq?=
 =?utf-8?B?dWU5V1RPcG04NU9qQzlXR291akNLUm9ueHlkemtYSGI3Si85U1c1SkdmNmFQ?=
 =?utf-8?B?R29RUlhLeS8rNnk0a1h3aFFIU0VvR3F3aHJVRnBUUFhkNFZ4YzliVWFDOGpY?=
 =?utf-8?B?U29GdHJHNG5NZUxCSnVDU0xDNTRPWmlZcENXUWRYSld3NWpjZzN2by9OL242?=
 =?utf-8?B?N1RhcEwzUkFEdUtOTUtyOXJIZU9oUVplZGorcU9VakNUcXlOU1RadVJ6dFd4?=
 =?utf-8?B?NllFaXR6bzRudG93LzdzL2lGSXczODNPZWZqbG45dDFVWDkwMC9wOTk2bnQ1?=
 =?utf-8?B?OUwyanhXNGJnNGVlL1FHeGNwZTU3dlhYbHN3c1N1OVJocnZsb2tXbm5QM3Vn?=
 =?utf-8?B?RmtuN3lkTGNraW1SeFpHZUdlTTZpVnFEcmlHejhBOUcwMU9JS1BtL1IrV1FV?=
 =?utf-8?B?ZUZxZlhPUEh6SUN5ci8rQWVneWpoQnZOS1J1blVheWxLQzgzNGhxMzhMVUlJ?=
 =?utf-8?B?WEpCeERIS3FwOXVXMXZNRGIwVVRTamFSMVdPdWR5Tjg1UHlVS1M4MllVQnA5?=
 =?utf-8?B?a0VRWmMwU1d1VEcyWHBEK1RnNFdFbTFyblZsdU1NTjMzQjVuSlBINDFNcHQ1?=
 =?utf-8?B?SU5mWDdjMGVOYVdSWHNFYnlrYjZaMWhQM0FBZ2IxMElud1hBWDZWR1piZ1FY?=
 =?utf-8?B?MjNyNlRoaXFxZldrVDh2K0NzQkdFZjF0MmdDcmovQVBEOUdyMDc3M1k3aXBx?=
 =?utf-8?B?NC80VXAwYWNCQ0hFK25uRlQ4a09pVWxKMlk5UHB1R1V6aWwvek9SVlNaWGc3?=
 =?utf-8?B?eXBpbEJuNXBlYlBCTVBKWmp5UmcxQ0tiREJ2REdMZ2o1UmxtcUhiOVJXWjRo?=
 =?utf-8?B?VWdrOE1aMnRMYkd5L0drTnFRZzgvV21DbGVtekg3dStpOFRZZWh2SW01c3NB?=
 =?utf-8?B?elBQYkpZWDFKWm5qdURZM2VHY3dXTlZrMEk4K2xBd05uT2RsaVcwV0JhbjdH?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b4d693-bb16-4704-7e92-08dcced0ca0f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 00:05:31.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3C1bnWfvB41+jQY8hPQhyyM3GLome8mQNwgeIujrekSiDZtbXptdtlLAai4rB4e3cQ9M3MIrrgcPRPfzi7sMeAxoZm0gxVUsMncJ75zAfq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7259
X-OriginatorOrg: intel.com

Hi Ilpo,

On 9/6/24 1:44 AM, Ilpo Järvinen wrote:
> On Thu, 5 Sep 2024, Reinette Chatre wrote:
>> On 9/5/24 4:45 AM, Ilpo Järvinen wrote:
>>> On Wed, 4 Sep 2024, Reinette Chatre wrote:
>>>> On 9/4/24 4:43 AM, Ilpo Järvinen wrote:
>>>>> On Fri, 30 Aug 2024, Reinette Chatre wrote:
>>>>>> On 8/30/24 4:42 AM, Ilpo Järvinen wrote:
>>>>>>> On Thu, 29 Aug 2024, Reinette Chatre wrote:
>>>>>>>
>>>>>>>> The MBA test incrementally throttles memory bandwidth, each time
>>>>>>>> followed by a comparison between the memory bandwidth observed
>>>>>>>> by the performance counters and resctrl respectively.
>>>>>>>>
>>>>>>>> While a comparison between performance counters and resctrl is
>>>>>>>> generally appropriate, they do not have an identical view of
>>>>>>>> memory bandwidth. For example RAS features or memory performance
>>>>>>>> features that generate memory traffic may drive accesses that are
>>>>>>>> counted differently by performance counters and MBM respectively,
>>>>>>>> for instance generating "overhead" traffic which is not counted
>>>>>>>> against any specific RMID. As a ratio, this different view of
>>>>>>>> memory
>>>>>>>> bandwidth becomes more apparent at low memory bandwidths.
>>>>>>>
>>>>>>> Interesting.
>>>>>>>
>>>>>>> I did some time back prototype with a change to MBM test such that
>>>>>>> instead
>>>>>>> of using once=false I changed fill_buf to be able to run N passes
>>>>>>> through
>>>>>>> the buffer which allowed me to know how many reads were performed by
>>>>>>> the
>>>>>>> benchmark. This yielded numerical difference between all those 3
>>>>>>> values
>>>>>>> (# of reads, MBM, perf) which also varied from arch to another so it
>>>>>>> didn't end up making an usable test.
>>>>>>>
>>>>>>> I guess I now have an explanation for at least a part of the
>>>>>>> differences.
>>>>>>>
>>>>>>>> It is not practical to enable/disable the various features that
>>>>>>>> may generate memory bandwidth to give performance counters and
>>>>>>>> resctrl an identical view. Instead, do not compare performance
>>>>>>>> counters and resctrl view of memory bandwidth when the memory
>>>>>>>> bandwidth is low.
>>>>>>>>
>>>>>>>> Bandwidth throttling behaves differently across platforms
>>>>>>>> so it is not appropriate to drop measurement data simply based
>>>>>>>> on the throttling level. Instead, use a threshold of 750MiB
>>>>>>>> that has been observed to support adequate comparison between
>>>>>>>> performance counters and resctrl.
>>>>>>>>
>>>>>>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>>>>>>> ---
>>>>>>>>      tools/testing/selftests/resctrl/mba_test.c | 7 +++++++
>>>>>>>>      tools/testing/selftests/resctrl/resctrl.h  | 6 ++++++
>>>>>>>>      2 files changed, 13 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/tools/testing/selftests/resctrl/mba_test.c
>>>>>>>> b/tools/testing/selftests/resctrl/mba_test.c
>>>>>>>> index cad473b81a64..204b9ac4b108 100644
>>>>>>>> --- a/tools/testing/selftests/resctrl/mba_test.c
>>>>>>>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>>>>>>>> @@ -96,6 +96,13 @@ static bool show_mba_info(unsigned long
>>>>>>>> *bw_imc,
>>>>>>>> unsigned long *bw_resc)
>>>>>>>>        		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
>>>>>>>>      		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
>>>>>>>> +		if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc <
>>>>>>>> THROTTLE_THRESHOLD) {
>>>>>>>> +			ksft_print_msg("Bandwidth below threshold (%d
>>>>>>>> MiB).
>>>>>>>> Dropping results from MBA schemata %u.\n",
>>>>>>>> +					THROTTLE_THRESHOLD,
>>>>>>>> +					ALLOCATION_MAX -
>>>>>>>> ALLOCATION_STEP *
>>>>>>>> allocation);
>>>>>>>
>>>>>>> The second one too should be %d.
>>>>>>>
>>>>>>
>>>>>> hmmm ... I intended to have it be consistent with the ksft_print_msg()
>>>>>> that
>>>>>> follows. Perhaps allocation can be made unsigned instead?
>>>>>
>>>>> If you go that way, then it would be good to make the related defines
>>>>> and
>>>>> allocation in mba_setup() unsigned too, although the latter is a bit
>>>>> scary
>>>>
>>>> Sure, will look into that.
>>>>
>>>>> because it does allocation -= ALLOCATION_STEP which could underflow if
>>>>> the
>>>>> defines are ever changed.
>>>>>
>>>>
>>>> Is this not already covered in the following check:
>>>> 	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
>>>> 		return END_OF_TESTS;
>>>>
>>>> We are talking about hardcoded constants though.
>>>
>>> Borderline yes. It is "covered" by the allocation > ALLOCATION_MAX but
>>> it's also very non-intuitive to let the value underflow and then check for
>>> that with the > operator.
>>
>> My understanding is that this is the traditional way of checking overflow
>> (or more accurately wraparound). There are several examples of this pattern
>> in the kernel and it is also the pattern that I understand Linus referred
>> to as "traditional" in [1]. Even the compiler's intrinsic overflow checkers
>> do checking in this way (perform the subtraction and then check if it
>> overflowed) [2].
> 
> Fair enough. I've never come across that kind of claim before.
> 
>>> You're correct that they're constants so one would need to tweak the
>>> source to end up into this condition in the first place.
>>>
>>> Perhaps I'm being overly pendantic here but I in general don't like
>>> leaving trappy and non-obvious logic like that lying around because one
>>> day one of such will come back biting.
>>
>> It is not clear to me what is "trappy" about this. The current checks will
>> catch the wraparound if somebody changes ALLOCATION_STEP in your scenario, no?
>>
>>> So, if a variable is unsigned and we ever do subtraction (or adding
>>> negative numbers to it), I'd prefer additional check to prevent ever
>>> underflowing it unexpectedly. Or leave them signed.
>>
>> To support checking at the time of subtraction we either need to change the
>> flow of that function since it cannot exit with failure if that subtraction
>> fails because of overflow/wraparound, or we need to introduce more state that
>> will be an additional check that the existing
>> "if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)"
>> would have caught anyway.
>>
>> In either case, to do this checking at the time of subtraction the ideal way
>> would be to use check_sub_overflow() ... but it again does exactly what
>> you find to be non-intuitive since the implementation in
>> tools/include/linux/overflow.h uses the gcc intrinsics that does subtraction
>> first and then checks if overflow occurred.
> 
> It's trappy because by glance, that check looks unnecessary since
> allocation starts from max and goes downwards. Also worth to note,
> the check is not immediately after the decrement but done on the next
> iteration.

Right. This is probably what causes most confusion.

Considering that, what do you think of below that avoids wraparound entirely:

---8<---
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH] selftests/resctrl: Make wraparound handling obvious

Within mba_setup() the programmed bandwidth delay value starts
at the maximum (100, or rather ALLOCATION_MAX) and progresses
towards ALLOCATION_MIN by decrementing with ALLOCATION_STEP.

The programmed bandwidth delay should never be negative, so
representing it with an unsigned int is most appropriate. This
may introduce confusion because of the "allocation > ALLOCATION_MAX"
check used to check wraparound of the subtraction.

Modify the mba_setup() flow to start at the minimum, ALLOCATION_MIN,
and incrementally, with ALLOCATION_STEP steps, adjust the
bandwidth delay value. This avoids wraparound while making the purpose
of "allocation > ALLOCATION_MAX" clear and eliminates the
need for the "allocation < ALLOCATION_MIN" check.

Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- New patch
---
  tools/testing/selftests/resctrl/mba_test.c | 12 +++++++-----
  1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index ab8496a4925b..947d5699f0c8 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -39,7 +39,8 @@ static int mba_setup(const struct resctrl_test *test,
  		     const struct user_params *uparams,
  		     struct resctrl_val_param *p)
  {
-	static int runs_per_allocation, allocation = 100;
+	static unsigned int allocation = ALLOCATION_MIN;
+	static int runs_per_allocation = 0;
  	char allocation_str[64];
  	int ret;
  
@@ -50,7 +51,7 @@ static int mba_setup(const struct resctrl_test *test,
  	if (runs_per_allocation++ != 0)
  		return 0;
  
-	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
+	if (allocation > ALLOCATION_MAX)
  		return END_OF_TESTS;
  
  	sprintf(allocation_str, "%d", allocation);
@@ -59,7 +60,7 @@ static int mba_setup(const struct resctrl_test *test,
  	if (ret < 0)
  		return ret;
  
-	allocation -= ALLOCATION_STEP;
+	allocation += ALLOCATION_STEP;
  
  	return 0;
  }
@@ -72,8 +73,9 @@ static int mba_measure(const struct user_params *uparams,
  
  static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
  {
-	int allocation, runs;
+	unsigned int allocation;
  	bool ret = false;
+	int runs;
  
  	ksft_print_msg("Results are displayed in (MB)\n");
  	/* Memory bandwidth from 100% down to 10% */
@@ -103,7 +105,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
  			       avg_diff_per > MAX_DIFF_PERCENT ?
  			       "Fail:" : "Pass:",
  			       MAX_DIFF_PERCENT,
-			       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
+			       ALLOCATION_MIN + ALLOCATION_STEP * allocation);
  
  		ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
  		ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);


> 
> The risk here is that somebody removes allocation > ALLOCATION_MAX check.
> 
> Something called check_sub_overflow() is not subject to a similar risk
> regardless of what operations occur inside it.

Reinette


Return-Path: <linux-kselftest+bounces-13085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D230924B57
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 00:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D949F28E082
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 22:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979FC17DA00;
	Tue,  2 Jul 2024 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RB1KDbS3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A866117A5AD;
	Tue,  2 Jul 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957725; cv=fail; b=K92tYs3K2qLqv88gsI7M8HdjCmb5py9cX8JvN/foPCGDZDNwcJK7OiO59S26E66WxtK4yGK6lHU0utb2DRJvECGHMTnlOY+yIlPYK1RTFN8CvCgYaJ0VuezJ34ca+njj8n5Z1lgy3pi0MYxsxm0fSa+4RYqFA7VLpsSJPF/1hlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957725; c=relaxed/simple;
	bh=A16H1XkaFgMobBc+AMKhJLvqNs59j4bk0q+pS5ZOiYs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WF1IIJdIbTnkTqG7pd6NZDRtwMNRizKFmmh6yOUFFkXcs342BcH6CHwMef541APmXc0MBVd+XBGCeODHuR7Qk4EX1oBxn7by+zirdhqV2G/c0Wnh8FGc0QG+X3VfJIPLeeTeFXNtQTeYJTO/0WI0cKQF2/S7D+Sfovxj6si8DXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RB1KDbS3; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719957723; x=1751493723;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A16H1XkaFgMobBc+AMKhJLvqNs59j4bk0q+pS5ZOiYs=;
  b=RB1KDbS3M47Q/qIaMamOFmdAhiA9CRPSpKyAegPqvQ+w2vSnxxHqpvHf
   EbPB8icXbqrztXjYPjZgQGFzqcaKZc2Nqv1eBASCHVQ6FsiGlKhlp2QDc
   GeiTEApqq/1b2pADJ9qj18WFvRZmu5nQAyzHcXjRhjsh36Kt52camqdM4
   nOLXnaprYLFBKgaMT5klvJKw8Bsi5awStxL7iJAxuXuXvVJ68mT7/M+Vm
   wwvkwM5LBx6AvyJprvgHnb2gpo2TqZ796V/kiEXqxgp6Xn4w+h/Ztxsgq
   THtkWjfOca+hMx9XKi4oVxlj74aCH/LsKNhiv0PdMx7kSkp3mQ1kwaFLL
   A==;
X-CSE-ConnectionGUID: 2PO5Ej2cR+yag0XWxhqXfg==
X-CSE-MsgGUID: 5JLdbPWkR7awznD7qV10AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28292062"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="28292062"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 15:02:03 -0700
X-CSE-ConnectionGUID: tWNmwS9DRlKjnajDpI7Cig==
X-CSE-MsgGUID: Y6BCcczzSKCjyqbtrCIA3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="45957849"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 15:02:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 15:02:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 15:02:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 15:02:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPDleiyhISEJn8AvuiyQdUYzn39cuACgTQlob+A2qLETkbTTy6dXNgiKcO0xpB8z+1ZL84Gai02svBVmNbB9ZnnF7k6814ci3sjVbi8GmsVJVPnOFWny5BtfKcgTyvyqAkn5bxbw1KpcckvWYXIQuTW03x6mJhrzOUS4eXM+3eO3ZyNncmrSCLsUh+4MOw8jSjnzpI0WHMBPO12kSQZvtBsZXzlncIoJkefEGruwEBXuhydoNDlCdEeltglquyIll7D5dk9I8BPtgqPV5lvisIjG76+9zgdC06mR0ZnOHfWcX08XWYX+rjIY2ns8uVD1n/yy3Sch+RRmfuk2FpStCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bneJNKGRHFLkIkPPjtv53c+vXkFLVpYzx0JjcI4Ia8=;
 b=nUKLOAB17MUoVi4Et3buBzech1N9J2LhxeO3KwLSmjxCYnb+7sc73IcNKhhiR/myC0qhG1HAmSCMn4vwCwxxDMzWMB80q8OMXsNeLE4W0F54305YWIPyWOrjZ5F+9s4Rsz+8fKkHFXtdUVLymtxMFF8vAT7P/jDjv+uKXmSsA0+3tqIMSmn1D9Ws2sNRFHlMDtEiFigBoanaXarfBFg0bi7CqXRfpXfNV6xMboOnUB9oVHN5aCPHmxOomWxWNRn03TcuxW9GsWYGdp5LI97n6irkDLX2sLb5yaZH/BnJH6OU9sORr0+lQS6ZOZBw7eERCpXXB/asdCM5wBcfx4vGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6277.namprd11.prod.outlook.com (2603:10b6:208:3c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 22:02:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 22:02:00 +0000
Message-ID: <a206cbfe-83a1-4c9d-8cc9-5cff1598a6d2@intel.com>
Date: Tue, 2 Jul 2024 15:01:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
To: Tony Luck <tony.luck@intel.com>
CC: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB6083D0D8AF9D1A7864084F0EFCD32@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4fdc8cc0-0b04-4879-9337-9eda3b83f603@intel.com>
 <ZoR1GSV4_IWrNMK3@agluck-desk3.sc.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ZoR1GSV4_IWrNMK3@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:303:83::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: f9312034-64be-4e81-8864-08dc9ae298e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEMvRllPcUcwcUV2UGU5MUxhSy9GUzlya3A4UkZHUGVnU3hGMmd6SnNsOHBK?=
 =?utf-8?B?Y2o2SWxRVmptWWJHU1pjL2JyeWI0SGhOaXRucFJCSlJacGkxSzRvd1N5RTZj?=
 =?utf-8?B?aUFNcmd0R0RqcGR4WWliQ29uRm5QYThpelpnZEJzK2hNM2FqMWVnc0ZUV3Uz?=
 =?utf-8?B?QmZzQU43bW56a05GcFE0VS8rYlp2RnhpN0hESUpibERTcUkvQm5MNFJJVU5F?=
 =?utf-8?B?T3M5QWk3dyt0ZUt0TDM2d0J4UkpEazVlUTRqUEZSenVMd3BDNVlmbUNHYnZr?=
 =?utf-8?B?ZzM0bllSVWQ3YUN5OEk3WjlnRlIybkw3Wk1RYmJ1V2QzUjhxdUo0NkNiY3VM?=
 =?utf-8?B?a2k2V2hlS0FNM0VaT083QjQwaVl1anIxSUgwcG03d3pFK2ZWb2c3c202d0g5?=
 =?utf-8?B?Rk5SVnpFMTdwd25vUmY1em5YSnVvcDR6bVo4UkxLaVl2R2I2bEtmQXI3K1lC?=
 =?utf-8?B?YmRBczZaMGJ5czhKZFpDQUMzT05KTGFCTFh3WWpFa0ZoWmtocFpZaUcxOFFF?=
 =?utf-8?B?R2MzazRuVnYwWnBNbUpnZzNPbXVsc0RYQ1pCdldxaGt5OGJCbk9NalhwSWFp?=
 =?utf-8?B?WEJ3emdhQ1EzQ21GeExoMUhmaW9INFBLQ2xlczNlMzhYcnpqRHNUdTRYWFNT?=
 =?utf-8?B?R2xWNDRyU3htNWt0TnFpUnhsUmd3VTVYVHlDNGcxcGJiVDVweHJtZ2tVS056?=
 =?utf-8?B?TkREaEliU3JRb3JQQncxT0RoMjUrTkFaM0VZVHp6ZG9LOU00K2V0L1R6elFh?=
 =?utf-8?B?SjF5UFJrSUZuQkpFM29xZmsrMEk0ZStzUUxiTU8vUG1LcEN5bjIrek9ENzA4?=
 =?utf-8?B?YXJwV1MzM0lTUmZINkM2M2crdFJwdVpueFAyOWp0VTAzMkxyYW84cHpLNzFs?=
 =?utf-8?B?eGVXQlppM2N3RWh1enZNSDhPZ21GUWRuZDJWd21UUGFZdkd5aVVEWDBqZk9E?=
 =?utf-8?B?UzJ2UUZScTlxMkdWbk9CckxFQlFEZ2ZINmdNOCtpdjYzS1UrUFo0ZStac0NI?=
 =?utf-8?B?Rzl2QmZ1VkhxMDFlZFljT0tMNjdKNDAwSEtWbEhaQjJkLy9OZVNkcXVsM0hP?=
 =?utf-8?B?TjkybkNkdjlmVW1oSnJVS3NQZlVDWDRybVZiOEwxNUhaWm0zYk0rOXdRZUtN?=
 =?utf-8?B?TFpieDNNeFRER3liM1pPeWx6YTgyNW1GdWdLTnFEVUFGV3F6OEpuMlo0b3NS?=
 =?utf-8?B?UmRBY3NiNkdwOXRvRlRKZGpRaDZiR0Y5MG11VE9jSGd3U24vblY0ZHlmVWQ0?=
 =?utf-8?B?QjM5N3lPRU1YZ1hxUnl3STFjYkhGVXg5TlNhWnpnTW8xV01XZlo3S0hrcnJK?=
 =?utf-8?B?WGhlWmdyeXRFVElEQkdSZUFhOXNRRGxlMXlIMS9IMnVDNXRRZTBEYVJNbC85?=
 =?utf-8?B?czVRK2NxN2puOGlGaWxCMkhIRE1NQ0ZHUVdxRVVpR201VDRaRlk1RG0vSXo2?=
 =?utf-8?B?NThoS3p6L1MwNTF5Z2JYZnA1YkdiYmF3MXZ4YXlUTGdpcTZnckI5dmNZWVl4?=
 =?utf-8?B?WnNyT2gweE1zd1R3M1BHNytDWXlwalRrUGJkTWNYditSTUdyUlFTNXk4VzY4?=
 =?utf-8?B?SXBLMGY4K3M0NTVWcXZrTW90VWJjdUpqR1JDeUNmajRLZkhZOG53NjFNZFRF?=
 =?utf-8?B?elR1dU81WTFjZm1ZR0tlNGFkRVRZRWNPR1o5SlZsZjB6NHVlNkdYYzZqbzYr?=
 =?utf-8?B?VHc1TjkrS3M4dkxvS056RStwUDlxb3lqLzdmSmdWOW9xT2xMaUFjR2U3bDNh?=
 =?utf-8?B?UnF3UUlQWmVyakFkOUpDZlE1WDVvcG9MbENDbU82aWxROWlCeXE1TExQR0h3?=
 =?utf-8?B?MGVuei9Id1JEM20rZlVOUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1BPOWtxeVNmTEhrREFXUEdQZEsrWm5TbFVwQi9oMXBpMHR2ajFURkRyYTk0?=
 =?utf-8?B?SjJFcXhXQzAwNXNlMHg1b2hySWNsNFl2VkxTSWdabmxGVHhXY2xqaXJiTS9I?=
 =?utf-8?B?VFkzZW12b3pyazVWUGdvc1lnRUNqTmNtREh4L0NtNmVqOEdUY1NWSWc4STNa?=
 =?utf-8?B?N29Wbk4xQXVxNkFwWHNSN2pOWkpBb1M2cmdScnN5L05zUncvdklhZmU2MGJO?=
 =?utf-8?B?bkZQTlBuNUZtdmJ4N2tkRUxCZjVOL2RrdkhzYkd4Z2dFaWZZejhHNTZiOVUz?=
 =?utf-8?B?STVKQjdNTDh4Yzhjck80RkFVa3UvOXZnSDJaK0gwdktnWE8weHd0cFRwUXdz?=
 =?utf-8?B?TEp2QzEwaHZwNmJUTjNKWFlxUWlIZldKSzFnQTB4WERsQi92Q1dDSlhXYjBn?=
 =?utf-8?B?SGNSTTdxQWxOcm5mT05TL3c1aEI2UGtvYkpMckluSVpGOC9Wb2NzUFZ6aWtt?=
 =?utf-8?B?YmdMaWw2Q0V5VEhTejZibHBla29Gck96MmRQL1ZESml4Y2t1Skh4U1ZJOTR0?=
 =?utf-8?B?LzRucURRMFpOZzREL1dEdzNoM2RERmk0WGxjOU5ONlQwOTZ0UFdTMGF5ajZt?=
 =?utf-8?B?MDhGdS9wZmF4bjMrcllzR1h4ZWhkWTV0c0pyUXNDUndvaWFGUlBoZTRXTWgr?=
 =?utf-8?B?aUhmaGZIYXVSd0RuZ2FqOE5tODBWemlHQkhIL3hVcFhCMkMvdStFL2dYc0tK?=
 =?utf-8?B?UkYrekRuMlB1aFdwSnhXcDdaU1JNRnpJMGlwSkhGNno3MzVLNG5SczZkbkFW?=
 =?utf-8?B?ZTF6VTNhNVFvcFZwcGpRdnp4TzVveHJxWm5KQWNNcGRZelpFclJId1FaWkRv?=
 =?utf-8?B?YWhmbG01T0R1cnhDYnhhcjRTU0M0M3BsUjRST0RTZHNvNXRvdE5aR3RuV01V?=
 =?utf-8?B?SW1PeWVEN2JCbEhDRmRFRG9LajJKcUJJWVJza1RhR1hFSUxNenZZbVpQYjJ4?=
 =?utf-8?B?cC9qcWFVTytCdlcwOE1PeG1pZEt6S2tJK3AxR2pReTR1bzJPQTdTanEzK3cz?=
 =?utf-8?B?N1JOUlhZSzNRZUo4OERIU2pxbTREZTBwdS9BUzI3R1A2TnFneXBaeXR3aVZt?=
 =?utf-8?B?ZFZGYWdvQ295cEUvM2htZlByM2xKQ1BpTm1WamUzYmRiUFRlTFA1QmMxWnAx?=
 =?utf-8?B?WDd0aHlmQVFaVWo5QXIrb0U0SEFUOVVmOHVxMG9QUDlSdXNpNHgxNkFiVkx4?=
 =?utf-8?B?OTRKS3VCN1hBNXdJalNERnpZdnM2dTMwZVI0WTNnQ2hZTVB4eUs4QjVtOFFE?=
 =?utf-8?B?Mm9YRzhkOGZ2cXVIV1k5NXZxWlg4L3NSckM5Y3dSalNGbmlxSTVaZ2QxS05l?=
 =?utf-8?B?c3FvMUdLV21FQmdEMWM3WGN4dlpoenVwaW9nSnQ5Ky9nb2ljUnRwWUxteDg5?=
 =?utf-8?B?alplLzgyZnhYcmNGYXZjdFZscEdFeDhlU3VjUUFESU44REFiWmppUVBtRG9i?=
 =?utf-8?B?UEdUTjZhanBQeUdaWndZcisvZHZQaklTelZXVjh2c3c1YytuK0dDLzAvUGRH?=
 =?utf-8?B?SWxUQy9RTkRyMjZsTy85Ym5kcFlKNVNrTUpIOXNnTzdDNlczaXU1VkM3WUY3?=
 =?utf-8?B?WS9oNmcvNGZrdUc5dGZlMG82Vnl3ZG1ndUNONjRxVFQzSEtzQnJlamNBOWN0?=
 =?utf-8?B?K3dXbEI3RFVJbkxRN3F5dFQ2dFdYU2N2UVJBU0NvTEthdFAxNUhoR2ZJanZi?=
 =?utf-8?B?b1hlTkRmTXEzbC9lL2JoNk5RanFtMHlpODBzNWhBT2NYUVAwaytIbTRNZy9n?=
 =?utf-8?B?SzlZYy9KUTJnSlhDMUhkR0hhWUN0dmo2WHN6eHdDZFAzdUpIZVBZQXZoYnlm?=
 =?utf-8?B?OTVPb1pqSSs1eTJnNmVDb3dqZ1Fqc1czbHRzWk9uaFMrOTNCZ08wMXp2YWc4?=
 =?utf-8?B?NTNmTnMydGtkcFlpczFRbmErZ01ubnUwM3pkK3NLU0RUL1Qwa2hwZy9pTmF2?=
 =?utf-8?B?UkZzM0JRY2VZV205dGJpd1U0bHlTV1k5NkpGZmhGZjFKa0hRMFZrOEVnWUU4?=
 =?utf-8?B?L2s0Z2NMOXNtV1ZHVzNtLzIyWGRyTFRHZDdjbUhTa0I3anVSSjhsakY2OTJU?=
 =?utf-8?B?Zi92bnJXaGMvVG1jSW5KQ1VzRFdLYmN0U2kzMlFDYWhwRHhiYkVzaGtWOXlw?=
 =?utf-8?B?RnlhUEVkUGhhaWZhMFkrcWJqRGdkNmpvTG5HbzJWV1kvZlVQeG1Kd1lBTTda?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9312034-64be-4e81-8864-08dc9ae298e8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 22:01:59.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjxZ0G3skRoqP/Rcsetfpsz2MjqdcamtkpU1tB8dvCLYDt5rUDwkAf1rgW3qfB0NBKeLLA5bh9paBTyemaVfvaVZBjEKN2qAUtTwl6fjWh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6277
X-OriginatorOrg: intel.com

Hi Tony,

On 7/2/24 2:46 PM, Tony Luck wrote:
> On Tue, Jul 02, 2024 at 02:26:25PM -0700, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 7/1/24 9:04 AM, Luck, Tony wrote:
>>> +static bool cpus_offline_empty(void)
>>> +{
>>> +	char offline_cpus_str[64];
>>> +	FILE *fp;
>>> +
>>> +	fp = fopen("/sys/devices/system/cpu/offline", "r");
>>>
>>> Check for fp == NULL before using it.
>>>
>>> +	if (fscanf(fp, "%s", offline_cpus_str) < 0) {
>>>
>>> fscanf() seems like a heavy hammer.
>>
>> Do you perhaps have any recommendations that should be used instead of
>> fscanf()? I checked with stat() but could not see a difference between
>> file with a CPU and a file without. Other alternative is
>> open()/read()/close()? Looks like when there are no offline CPUs then
>> the file will only contain '\n' so it may be possible to read one byte
>> from the file and confirm it is '\n' as a check for "cpus_offline_empty()".
> 
> Sorry. I replied with Outlook and didn't quote things properly
> so my alternate suggestion didn't stand out. Here it is again:
> 
> 	if (fgets(offline_cpus_str, sizeof(offline_cpus_str), fp) == NULL) {
> 		fclose(fp);
> 		return true;
> 	}

Apologies, missed this.

> 
> But that was with the assumption that /sys/devices/system/cpu/offline
> would be empty. Not that it would conatain a single "\n" as you say
> above.
> 
> So fgets( ...) followed with "if (offline_cpus_str[0] == '\n') "?

How about simplifying it more to "if (fgetc(fp) == '\n')" ?

Reinette


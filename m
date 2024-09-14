Return-Path: <linux-kselftest+bounces-17976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6BB978D3E
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 06:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5445E1F25050
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 04:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF2317741;
	Sat, 14 Sep 2024 04:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkTjRtZz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0018C1F;
	Sat, 14 Sep 2024 04:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726287167; cv=fail; b=HiSu7gLjoVj1gL5UstESGYUzoT2FiaZIvvvJerx4/JfSBfjeVTLZTlx6ZeOu98HrecJuc2ZlIC+1l/UoRGfQIXKn/oxozwzxaSPfZXTWEKO1LjDsS3aUducDaFriUDXqSPNILF4HrNpfrMH4Ko2L0TUczh6iVTdVNbIAxlH2tOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726287167; c=relaxed/simple;
	bh=qutrNPxLFUf4mIt+VXSsxeDieRkGI7WWX4IAbMEkisA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UUHYMHCmnjqw1NExVHshtig1T920nqyjr1Jh1TB4lg1rK96OH9p0i0aAk9Z5Ywl+OjZ7eynQiLn4UyxIEhdaW0mFHC98XxAanR0fCjpdupAhkMwfRFTnhtQE0CNO/eFO5MLNmOqI3ihW77m/ehy7S1M5uYPN4vqEyTZMDQvg/6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkTjRtZz; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726287166; x=1757823166;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qutrNPxLFUf4mIt+VXSsxeDieRkGI7WWX4IAbMEkisA=;
  b=BkTjRtZz2jzkmcdG6ABbYwVQoWqI2ko9DiK0ZGAbB7Nxs6t+kGZMYZeO
   yBCdyJe4xDz1cDAiYYnIAINcB8gSBX3QRz4MCXnNClgNIdP9wCEPF/pNy
   isGM5vv+jMsdfpechQINm97Wq/gMl0pt8ZzAEItoJAkJ73AUZXGAPU70v
   DohEA2sld7HMG6Gyin+eyt6C3Kc2YcbZssdev6zQsaanPHOUZcJy8qxen
   0cYfwrbwcE01CECzM2ORyrRnmCkxLxvp+gV0H7O//kdJIN4D5tetN7WQI
   ergP3w0pi0Jv5juQHXSsLoSOXk0CFI8Mh4rLX/MzhWjl4mjI2ObNQw9/E
   Q==;
X-CSE-ConnectionGUID: MtdNkzTgRhGeQGl1JIIq9A==
X-CSE-MsgGUID: iLDRQe/+TSWbPTpAuO5wGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="42674946"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="42674946"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 21:12:45 -0700
X-CSE-ConnectionGUID: wRogih7JS0OqFeBPIYp7og==
X-CSE-MsgGUID: u2GLgWR8TYSs+J2/OjJZAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="68625739"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 21:12:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 21:12:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 21:12:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 21:12:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Osr9qTr2UAXc8jTgb+8IStmw/6cg4yQrgc7sQ/lfpp2rjVPNYcenKxLY3BNVLAbBG+w5ydoUkTcmO0RXGISsSUH+o2ZMkEJltyXwcxZicoHfU8d5hCMQHvjSmEa8zcaNfnn6W78NfH7o9dH1qxTwAkk3qBO3RJ66e7+on0XSAOpbbcSKf7Qnhd0lt7c2dvQYvu7r2ASxXkPtUa8ktrLQJLSU75vF6vTCtKs6W3gG3T7IbJHBHV5lnLw7dC2YiDIclACd8JX3b77boQ94M8Ksug6DcT2awW3F6KJXEJKi3ZeihGYUs02s+AV2JuCQ7VSZjv/CVYMp//WodGoTd5ArQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhN+PR4FRpuoS0QiudrymJtwv6aNMjzwsU+M2DKq83U=;
 b=aWzXfoYZwKPz/4xRJgIXYblPl466b6XvY4EKW3oqs7QWmyfc4Oa6/mwoPCEjj8Q0u1pnCXMclmpNA91LVSn6unHzGeaHt42fPcvI0MsTIi1bujDXc6+6cJKijmA6qbFnEXPJMC6Bv5tXRIGdzklX3kCNM8TudmKujU3STKpwV6GQHOGotCFI60VUM4rdlwx3+uBPA3808ZzH58sT4yhwCgpCvJVQujGohgphv/VT3HWL8IjvuTJ+OE3ch3dHNoRvEQK/MNYdVVq/3FboRupgNbSoEG+Z0Twqp2NHjqxHreXHrR+/sGAq56oTA/s3rczgRQzYg+qbnwKiGcLmiKC6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB6828.namprd11.prod.outlook.com (2603:10b6:806:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Sat, 14 Sep
 2024 04:12:42 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7962.018; Sat, 14 Sep 2024
 04:12:42 +0000
Message-ID: <ebc8812c-c16d-4465-a730-c1e49e211cc5@intel.com>
Date: Sat, 14 Sep 2024 12:16:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] ida: Add ida_find_first_range()
To: Matthew Wilcox <willy@infradead.org>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <alex.williamson@redhat.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<zhenzhong.duan@intel.com>, <linux-kselftest@vger.kernel.org>,
	<vasant.hegde@amd.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-2-yi.l.liu@intel.com>
 <ZuMEsybAnOi_uSfY@casper.infradead.org>
 <a24aad52-3da6-49d3-9df9-f418fad36434@intel.com>
 <ZuRVu088KuMbtqsm@casper.infradead.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZuRVu088KuMbtqsm@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: ac55e80a-ad0b-4936-7288-08dcd4737a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REw3ZG0zV29WN1BXeW1ZaEFRM0VOVHhBaHpKc2dJQi9XRGRzUHc3b3VGYkhR?=
 =?utf-8?B?V1NteTJYQlVsaXFoT2E0NmVGV3VnOE9yVVM0cyt1bFhqNzdEcE5na012WlEr?=
 =?utf-8?B?M25qL2ZTSTVaTnhsZHhUTlQ1N1JXemZkVnFOaHdCMUpaM3VGbHpKeXBLTGxF?=
 =?utf-8?B?ckRRYkZWN1FkbHlaV3oxelUrZjdodkloVUVEMXJFOTRTUTRlR1NaVitvd1BQ?=
 =?utf-8?B?TG1SbVRwNE1iRklpU0E1dnp0TVlONkEzejByK25ITmd1N28wb3IrUXBmL0Nm?=
 =?utf-8?B?V2JNYlY5NW4wWlAvTDVUWEp1TStPTVZsMlFQMXZTdmI2N0RnY3dEdktwUUFr?=
 =?utf-8?B?anJWbU1iaXFBWUJPZXo2OTJIWU8rZGQvSjN6ZHhQTU93SVVzWHlOS2wxMTZk?=
 =?utf-8?B?NzdiQklObUwyWW9vWXJrWjhVTjJ6WTVTMGk2ZWNuWUtGV0dnMGFFaXNIcGlm?=
 =?utf-8?B?MzQxSlRCNUp2UW1rU1FUcnVWeVZRVGJRN1gzZVBNWU41S2NMd0FsRmVac3lT?=
 =?utf-8?B?S2JzMm1VUk1JRkE2ZjFVcEJIZHZZOEhyWFY4cXpqUVE2MGV6N3JrSHI1YSs2?=
 =?utf-8?B?Wk51aXlFRHMxWlBLcW80MnpkQ1p2cWlvMjlwVGhHRmNhSW0vOFN4TGRhbGxa?=
 =?utf-8?B?YUR1KzQ2TFI4Q3R0ZDJmemh1NnVQNVNidXF1bk9FMEZaZWxhVTE1dDhzZ05u?=
 =?utf-8?B?NTQ0cjNsK0Fzc1dibEsvbzVobncwaW1zY1g0dGJGZU9QRUIyY09EcjRMVlZs?=
 =?utf-8?B?dS82aFB2am5vQkFNcWEvWWVxWFJ4V2l4L1llSXNjZmJBRy9ydndqcXBPNU5D?=
 =?utf-8?B?cWh6S1RpWHRlb05vaFZ6bEY2QVB3R0tsM3dVNmZxdE9iakNncDlsOGxVTGFo?=
 =?utf-8?B?clhUejA2dXhFWVVBT3drRjludTVtN0VKSmUxTFpSajh3aW5RQ1Rtc0cxNmpD?=
 =?utf-8?B?RXlxbExyVUZweDJPc1JPOXh2a1BoRWFlNUJKQVVGaVhFcjAxckl6UTVWQWVL?=
 =?utf-8?B?R0hjeGh4MFh0bEFhT3V3WTUwc1NoTWI5S2UrM0R0RVdnaS90dUo4U3o4WHV5?=
 =?utf-8?B?NEFWcXpzTHk1TWFoMkVBMStDSjhiWkhQWndBeXdKUk4yVWxSeFlLMmlta1Y5?=
 =?utf-8?B?R1FraEdveUZVNU1jTHVYYXRrR2w2TXlYR3daYm1La3FMOGVQc2tFYytldTBT?=
 =?utf-8?B?RnlOM0pyT1NUYnp5Znd6YXovTVJGdWRpTGhIZ25UVWxVazJOdVlDRENtamhx?=
 =?utf-8?B?ZUhiTU1SMjROSXhTVFZWUzdGMnRJSUJQT3FXZWVBOFZTb2d2WjJRZVI5dDZD?=
 =?utf-8?B?VEs4RWpCMzRZY2F1U1JOQ2JvdFMxdDloUTBYSWh0Tm1xcnpGaHYzemdicCtZ?=
 =?utf-8?B?amlqejJNRjB4WWpkMC9BQnNoVlNnbHJUbU1tY0lveHJUUUJiSDNLZ2VDbHJo?=
 =?utf-8?B?UmhHN3BOS2JFVDByakU2eGpoTlhvTzlZOCtTWlJ4RlBGNS9VSWp6TXFMZHdw?=
 =?utf-8?B?VDNEa0pzenZkNmRNbVMvUGhtWE1xWFNETUtuS3VPN1AzQmhKWmJ4aktMdUg5?=
 =?utf-8?B?bmx0c2lXTXRRcVZNeDBrb1hKeStYOW5RMTlKWW9Hdmx4VzFVU1RDQUptZFBl?=
 =?utf-8?B?MkF1Q1V4ZVJ2RFd1NDdzN3hCbFdidnNEU0RkSXFoV2szSzRzYnZIVWl5OHdT?=
 =?utf-8?B?WE9WQnpBUDNyZUloUUI4RjhPbWN2YnBQY2Q2LzZoRUlsb3p0d0FkV2NXazJp?=
 =?utf-8?B?QTkyc3ZnVWxsRmNJSjRaUTBQLzJnV0ZDM0liOHZDQmRobHZuV0hNUjZ6UzhH?=
 =?utf-8?B?L3RsQUZiWTRMK0JCbUZwQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTh3N09TTXNIbTdaZFdxaTR6OUhKRlNmOWRHUFZFYWkxZ25BSnBGRTVJOGkx?=
 =?utf-8?B?T2tFaEVNdjNMb1JmZENialpaN2lFcVdBeEdndnRRR204alZFaWJ3emhDaWF1?=
 =?utf-8?B?U29IbFQ0bVFHMlFQZW1OQTVuYnVqZEZvZmttcUtsckRGMnFLc1AwaXMvbDdN?=
 =?utf-8?B?bEZlZHhOZUFWbVdxUU5pcjJBM3RGeFgrWTVkRHo2Y09MK1JCVHVUYXRNVnJ1?=
 =?utf-8?B?bXAxSlloQ29qVFRVWktDWEhLMGRabzNLOU9LTTJHR1hiRmdObGJuS0ZPNjRn?=
 =?utf-8?B?RG9uVlJscjlKS1hLTFo0ajN0VFVOcVRkU1VWYTNlMjBuM0pRbGdmczZlZE5r?=
 =?utf-8?B?aG1GWVZtZnBIOG5VRjdac01FY0t6WXk2UmlHUmV5Yi9pN21aQ2hHcy9WdHBz?=
 =?utf-8?B?azljbytZZDgwVWwxUHRKRVl3R01ZbkhBZ2o3bEFNMHM5aVEwdStvR0lXV3Vn?=
 =?utf-8?B?MDQ0dllFeU8zdnB0SzJONkYvZkk1cVEvVVo2TXhTdEZlbW0wS3Zvb0QwYjdE?=
 =?utf-8?B?cmY3MXFLYlVvaUtUSHBnN0tYYW9Dc0YydkxnWk1EbVNpMmVSeWFwNjBMOGs4?=
 =?utf-8?B?V2dLMjBCTitSa0FBMnZZTmZ1RWZPWDdTd1VsSFpDRjJCY3FxOFZlaXl3ZmZy?=
 =?utf-8?B?djR2RzRYODhRR0VLbzVhNU1PbGxnU29JYWdvVFRZQnFFMlQwMGpzZ0xUZGZP?=
 =?utf-8?B?MkxRNDVxZnJBQ0lKK1NuWTNNT0pPb2ZMZlRiczQzaUJJOXlyMVRQRlpaNG9N?=
 =?utf-8?B?M3I4bzlMV3FmYVBSZG5TSUdqM2ZocmVKUE1MZkthdzBTOVdWSFBhTXZWWkRL?=
 =?utf-8?B?L1Q1eERHbkRqLzduTE51UXJMeGlhOHlrMjR5OXBWRDNJSEhod1FRc04zajJ6?=
 =?utf-8?B?bjlsdzAybngvWlBaK3BpeHZzOGxGN2c3bERSeExMVHNnYkcxYlhRNjg1N29C?=
 =?utf-8?B?NWpuK1ZBRHlzTUFKdU9JYlRFMVQ0T2I1UXV0Ti9PTHh1TlNpVjE1b3RNTDN2?=
 =?utf-8?B?bmlEdnFjYk0veS9BQ1JndjY1QWtUTHNhbnp0TE5nQk1xbTkrMEJoL216a1RW?=
 =?utf-8?B?WnNjZlNtemxrUmk3YzlmVUcxekcyL3NySkI3L3BSYTFETVNCd3ZVWHdGMXlC?=
 =?utf-8?B?N0xOREFId1dHNGVZSnQ1di9RV0FPNzZqNUIzdERrMU02NHZGWHMwSThFd1RB?=
 =?utf-8?B?Mkh4cWcySjRkSEozdlU3RVhNMEFMY1VaTTc4QktpMHU5a3lIZ1pYd3B0YUov?=
 =?utf-8?B?dTQzM0JUMHpFcTdQSG9JdWZwcGlCbVltRkJyWGt3THBFaXhEeUF5MU1VcG5o?=
 =?utf-8?B?ZGI4UlA5U0ZocUhleSs0aXoxbFAxL2NBdG05eXdwT0g1cGlkNklQand6dUJK?=
 =?utf-8?B?RS9PQkh6bDZNSW1BL0FMM08zYmhia29Oa3lta0VTOWFmelpTZW1CTFBFLzdz?=
 =?utf-8?B?TnFJd09kSmwwODNpSzZ1K3c4Qnk2eUJOTXIva081REw1WVprREs1K2pCS1pq?=
 =?utf-8?B?SUxPSmZ3azlGZXl2ZE9GSUQweVYrMFgyMmlnb0VTK0FBUUNFcnVPbElISFNl?=
 =?utf-8?B?RVRDMHhlREs4c2tmaDRoV0VUZ1VrNGtKMVFTVDJTRXBUNVhES3lTYkMrWTJG?=
 =?utf-8?B?T0RDS0NYRGNUdU5MeWIySS9Ebk9oMW0wVDRvTzBzcThHVmgvTzdZRU14d0dJ?=
 =?utf-8?B?OC9meU5LL3N5Rko0SFVpb2VFMXBRbjNvYzBBSUZPYWQ0NmplTitsMEdzSW5k?=
 =?utf-8?B?b2JyRC9nS1RJVmVhMnVvTmx4UFMvTWZIcVMxUVFPV0tZY2FmMXQyc24vRWRx?=
 =?utf-8?B?REtsUVRYTkNEeWNRV2F6YnN4M0JsNWlyaGpBTUlGZW54KzNnSlo5aHYxZGFw?=
 =?utf-8?B?cFM0VUo5UTAwQUcwcmovWTZtQVAySVhNR2FENjR3bWVyQUlURXYwYSsvUzZj?=
 =?utf-8?B?akc1TnpYdmc3NVFZQUxNSFZ4cnBjeTluMWF0Y1A4S2oxOEZzL3dXU1VGdFFS?=
 =?utf-8?B?SlFZUjJkcDFJbWxiM1Z1WTRORHNLQ0NJbkFOS1dkY2d1TFExSHRJa2NtMWQz?=
 =?utf-8?B?K2RFNHNsYUViZ3JybTJlU1pRd3JxekdQZGo4Uk9GTjdqNyt4S3NqQkpVZ0hZ?=
 =?utf-8?Q?UoDqDKlEvPVWP1F1UXQXKEr1d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac55e80a-ad0b-4936-7288-08dcd4737a49
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 04:12:42.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YlXjTrW+IA7ky+Haddp0ZHT6S5Lc9m8GJTR4RF7MrQnPps6c2VIpNrPxTHou4gfRTGjKMcczBtqULWF24gAuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6828
X-OriginatorOrg: intel.com

On 2024/9/13 23:09, Matthew Wilcox wrote:
> On Fri, Sep 13, 2024 at 07:45:55PM +0800, Yi Liu wrote:
>>> No test cases for the test suite?  ;-(
>>
>> let me add something like the below. :)
> 
> That looks pretty comprehensive, thanks!
> 
> Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>

thanks, and FYI. I found a bug when running the unit test. will fix it
in the next version. it's really helpful suggestion.

diff --git a/lib/idr.c b/lib/idr.c
index 6644d3d1af02..f16eb3d172bc 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -494,6 +494,7 @@ int ida_find_first_range(struct ida *ida, unsigned int 
min, unsigned int max)
  	unsigned int offset = min % IDA_BITMAP_BITS;
  	unsigned long *addr, size, bit;
  	unsigned long flags;
+	unsigned long tmp = 0;
  	void *entry;
  	int ret;

@@ -518,8 +519,7 @@ int ida_find_first_range(struct ida *ida, unsigned int 
min, unsigned int max)
  	}

  	if (xa_is_value(entry)) {
-		unsigned long tmp = xa_to_value(entry);
-
+		tmp = xa_to_value(entry);
  		addr = &tmp;
  		size = BITS_PER_XA_VALUE;
  	} else {

-- 
Regards,
Yi Liu


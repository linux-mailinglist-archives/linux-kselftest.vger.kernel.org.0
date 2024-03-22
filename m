Return-Path: <linux-kselftest+bounces-6508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3BB887214
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 18:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84793283729
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912385FDAE;
	Fri, 22 Mar 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6u39uXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE25FBBF;
	Fri, 22 Mar 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129479; cv=fail; b=kb7Z5HSJp3ladOqug82eOaUo5FZkQ2ZenG/scQ+Bh4kXZgvqoCof3GxZdb2HoKejrTjsJJDp5MKmi8ZiWMZduxCVlIdhaisue00DhGCKMZrx2PaInLkOXr4lvzX4T/qqDBcWR7mJLdoe+E9N+W0jHnzKkpLtq55e7x2et4SDDhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129479; c=relaxed/simple;
	bh=ZHGsWEkfDxWqI5JrDI+ClPmHHf5KZD8Ue2w4MBB8QVI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sx5S6ZGXfUSMht233kYJUoR1l1QGphA0bPFkEh7ScWNYYPkh6C5OnNArxt7wToGrTJcBAzKGfLkFKhJkpGPeOtXDs69keQv0Kxb5notLM0VoZIA5pQMc9HNGx2m1cfOcpSaGrpMuzhp8EP4UCgDv6Rupi4/hfIwGtVmYCN/bMWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6u39uXP; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711129478; x=1742665478;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZHGsWEkfDxWqI5JrDI+ClPmHHf5KZD8Ue2w4MBB8QVI=;
  b=e6u39uXPX+1SLxd6ChnQ8577cj52FtqFRC0AgPME9eBv3JU+nJSMgb7n
   mMIFMX2X52VxrKfmSr/MwdxhVWlh+8TMuiIpS/0ofcTpFeS0I/POwzCx3
   Otswkl2rfhobYRygz9KSxgJ0km/uwj6l2JmZTlaoTwq2PLRvK5No1uzQ3
   mIMeLf7dxaEHDpsQPa0PR902c5FHhDp1NlgDgj3bonLky/0L9cdCOqn7U
   DEGLuAIsTM5RcMEF3u6Ze8OvBczsWFBknrOVAhN+OU7mjNd2HRE6BExV5
   XCEkFEdRoH5vfpa0d6OUBI1XyKNGvJN9zpwvOCpBO3vFDA2FcC97TjCfZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9142291"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="9142291"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="19548319"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 10:44:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 10:44:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 10:44:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 10:44:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRHHb7L7urPW2a0A1tEixJZC+6vU8Up+6aPXd1gDd0sCaN9sjgu9miuNxHjnX6NGYIkGN10w95sOnem2oWL2ev52gw9cW9cgxjvY/s0f4uHuYu0DMojFdti0si4p18FZHf0nhoYNnTzqzX+BHcpW8up2n8FSHGROyKgzSXZWRaTLZKQgUErmgLA8bOvmMJ//qCDMIyvKe9++Oy95jOCUikG2kJS1CVJkNA7+Enyv71P/+c438RU4flWtxLPHoVu6gr73IfnuIUH1lnSORZy1t0S6UxfVLCkFQvUKR8QG3P80PF1DziovkLL/zup9OgxADVCmfegZSCxacAfAnWvHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sxnf3yyLgv6v/mjA8BQhEHveg51ki3R4U3Icq0bjsQ=;
 b=LgSzGpbjb/DwRo7Anjz5pzvfPPHODvEFw+kBdHHm7JUun6IRVqHUvuwNTHV7vzv+m9z+IXXPMc8W8hbEkw3fUch0KJ7mGULKd2Ia8OAi5DkpeiCReAv+kPHHUZut8IOj85X6hZxnrTglM3CLfGEUV/vCYFvhy78wGBuwkg0QRbYvTKE1Kw3JyrXMoktNBw8llHQ/RKgo5EDRdk5BOkuJ+q73uQLyFI1hdBQkx/voZEzTLXbkCOPHF3V9gxx+y7D2pdm3NN5hmTjLtMi2d/iCY4zfZGDg3Q1pT2WmCzfFi+2CxyGSxd4BmMFEvQWQG1aNf1/YTHnpRCh98puT7eKMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB6950.namprd11.prod.outlook.com (2603:10b6:510:226::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 17:44:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 17:44:33 +0000
Message-ID: <8964b621-657d-4f9c-aeb0-3d3ed8c62c3f@intel.com>
Date: Fri, 22 Mar 2024 10:44:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] selftests/resctrl: Convert ctrlgrp & mongrp to
 pointers
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Babu
 Moger" <babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, LKML
	<linux-kernel@vger.kernel.org>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
 <20240311135230.7007-12-ilpo.jarvinen@linux.intel.com>
 <578d0b55-c51a-49d1-8f54-989215a3a4b8@intel.com>
 <93e4f096-47df-9eba-095f-e8a8c3cd04f5@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <93e4f096-47df-9eba-095f-e8a8c3cd04f5@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0303.namprd04.prod.outlook.com
 (2603:10b6:303:82::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 083aa896-37a4-460b-0922-08dc4a97bb9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9iAEswLYVlA+t4WodBHLPXvWYFfV5cvyqBEccqOeVO1pAaY1wArxDApsYxU8yS4NYQuCUfn+rIQrcfOQq4TwC8sVc5LHYztmkp5y3QZq0L6pzWv6Ev4kY45Ie6EcS4sHGKgGK9V4n1OPIlyD8rttW3OQ7hauRvXAFZWCWQxqGuKLAQz4kzClMS56pCK2N8R53f3v7shXEVmcGcy4b+zsyqFvNNNVinoJ9QDxDysUjCBHHImHU7MhGfEXTJnDkxmRbd4mo/+YQQHi9sEq52NmA+HI0SNeMMCogTH23wfs+7uQuY7fySSizqr7ERty4CP8ut6I0qGMlJVeQ5EDPtTq9f4SErG2ZG86EZldBMgTgE1bsQeKiIOzR2GNzslXB58vVniUVKtu46Fjd0mtI++93p7gRJmrqtUQ7wd7Rop11ZbP+jkyfAcrxhwr++MrAOqFkSG1Wj5UIoGuWRrc+lCGCSGm15aP+D73oNlxNMovulwlmBGfiXK5s+CTuWXTZAVwf9QCL8Lvv4o4lYoCpW8S6/eDgxNge4G43JHDF5DcrTrmZLRhWacwxQ6JPc4P6Fjknqn2l/70ZzxcsmNXjMTGybZS/xXUEm1zLBSUhHFOgs5d+6f3C1aKLRCcTNbSieDefcu0sZ642+2dSCPeYKOYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFhpbkx4aXFlWDdERzdoOHJXOStBRmR4eUNRd0J6dzNQUUpCUzYzTzROSnhj?=
 =?utf-8?B?Z2ZTUExXclZuczRrWi9RanM4ZkdyS3ovKzNTejJXQUc0bG54ME40NnU1N0ZE?=
 =?utf-8?B?enJLSGN2WUNvb0xjZWJkdEdhSkdOeEFBbWw5Q3ZlUDB0L0wrZW1kc3VLOXQv?=
 =?utf-8?B?c2IwVnpXc21GRmUyK09CQmY4T1pjQmhVS1pOQThLU1ZqN2xpUU9BeW1OR2xW?=
 =?utf-8?B?UXFuUUdxa1d3MnJiMXoya2w1Q1JwbVlRY2ZjRE5XZjVqNFpGdlhTSnZOUnhJ?=
 =?utf-8?B?cGd1cDkxVU1HYnVyTW1KeTRFUlcrVnBLYlV3aFRJMW1XWUM0WS9sMFBuZkRB?=
 =?utf-8?B?TmdKUUlUTjZxZ2xVV1ZGUWtPbm9LQzZBVUFKMmVQb1ErSFovTERXUURsNTZB?=
 =?utf-8?B?K0hZSWo1aUxadG9jWldJSVVSRFJLZHNuL0ZWVWYybnRkOUlNdlJIMEF5WTJr?=
 =?utf-8?B?WEV2bFhNOHBnRHNuTVdXeFQ5bUhjTmhuK08xaFhVUzc2UUpwK2RRVFQyMjM2?=
 =?utf-8?B?VW4yZXBORVRhTWgvRGlIazNOK21Rc0krZzFhM0tpTm95aS9ieENSODlWV3Ez?=
 =?utf-8?B?bGNGQTdrdVJJcldiZlMxdEx1VGM5ekZQK09GRlg0KzRZTWhxeE05TFppWlVk?=
 =?utf-8?B?WFQrZ3p4UzFvc2J2VjRYS0FKOEpNc2IrWXBaNDlCZzFEMTNMQUswSzMwMEJF?=
 =?utf-8?B?S1YvcHMwZlpac1dWek9hM2NEMW9QeE5TcFdoSmREL1VBR1dFc25VQkF3dXNx?=
 =?utf-8?B?a3dSMm1HNW1rZnJUUzFESzhWRm1DbFQ0cC9UV1BVa0pUVks0eGRUNUlKejkr?=
 =?utf-8?B?RUQxejNJZko1SVNMTWNsTE1NVXlpbkxVL0swQmJVMit4RHpkN1pydk9xRms4?=
 =?utf-8?B?WW54K2kzMWh6c3FoM0FBU1FGR0NkTkZjd2JPeGNvWHhRb1lkSzBxWVZ0Mlht?=
 =?utf-8?B?Z0ZSUkh1dThQU0dBa0xoRUh1U0pzRUEwaVU5VG8yaHdKNXBTdVMxR0ZNSmt4?=
 =?utf-8?B?NlcrUlFKU3NQRjIvaDJKVklEN0JsbUZONVJ0S21ZVG9haE1CSUROMDRHL3U0?=
 =?utf-8?B?MTRQV3lLUDYvdStzWllOWDZlbDIzTHI2NEhTMTlDR3hpc3d1U2FOdnhvMmpI?=
 =?utf-8?B?QnZkaWFvOXRzTlNtMjlTUWFLb3l1VXhKUENVbS8rekgzWXFBVW9tRHNiOXJz?=
 =?utf-8?B?dGhXUWsxNnZteHRMQnQraTVWQ1VDVTliR0VZcHdvaGM2WjZuYWdKWm9oOXkz?=
 =?utf-8?B?eHg4Tml3blVaL0haMXMwbno1UDBTRitzbk5sTURvbFB0MTRyVS9oektlVE1h?=
 =?utf-8?B?V2lONkg2L01zcGJBRFhzZDRWWDNOdmg2dzdEdDZMOVkxektGL0FQUG9sWk94?=
 =?utf-8?B?UjkrQTZBVnJscGtYcUhBK1hQMEZDNFc3ZW51b3d2dzl5bXBNeUFBSWQ4T1lQ?=
 =?utf-8?B?cWdzNEQ2N3R6aHhueWxBMDB1cGNSazFRZnRqUFdsdFlhL3Q5TW9uaCtUVThz?=
 =?utf-8?B?OWx0MkNDaUM3NDBIMkp2dDYyMWl5QU9ybW9ZSUpzdTJ4Z1NhRWRtMWpHcTA0?=
 =?utf-8?B?KzdLSC9xd2prNDFwYTF2SEhKUExNelllSkUxandZTTBjS0I5Q2lVekxnbSto?=
 =?utf-8?B?N3pBYWRRVkJnaGtpMi8zRG9KOFBFWVhFNG4zZFBaT0puOG02Tnd1Z0FWUVhS?=
 =?utf-8?B?b0ppMDN5T2ZxQ2xBTXdtZnJkczlPUXVKeFJVakl0VzdjWm5Vd1FvYnBEVGZN?=
 =?utf-8?B?di9GRkxWeXI1UzV5dFZsekxSRnRxN1QvUzhRWGV1Z3ppQ1NvRkw3cmJJeFJM?=
 =?utf-8?B?OFhaNDd0Sng1WTFIY2NYeEpGcjhhdVI4cnY1UmpUdVVPQ3BRR2RRSllqazk4?=
 =?utf-8?B?cjE5dFhqelZuN0QyTElTZlIvRm85NU56RWk2M0RSZzVLa1ZuMXBoNERRVFkw?=
 =?utf-8?B?dWNxVU83VFZFZnFwbGt3cWs5d0VjbCtVcFdCV3AvSExBS0g2U0NmdTRYVWcx?=
 =?utf-8?B?RU9HcWFWUlVMMWM2b0l3RDRoWW1iZVVWYUtEdUJIYjdpUlBmcHRVamY1UlIx?=
 =?utf-8?B?QjZjTS80V1VwZFlvQUs4QlJCU3ZEU1VoUDltdUYrNlpFRGdWWjNRUlR5VVNt?=
 =?utf-8?B?MUwrVWxVUmJyRzZSNG1yNC8xa3NpZ0xZeWRUZDRibXp6SVBmUGs2OCtELy8z?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 083aa896-37a4-460b-0922-08dc4a97bb9f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 17:44:32.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1siO+QfhrxRZptOaI4Uqzz9lzSeeuXKC9jlE89KPOTTOeJmVQwABEqQARuIl1BfGVxR442F/q661E6W3rcG/4Y29UdgF9gE09MIBv2hpao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6950
X-OriginatorOrg: intel.com

Hi Ilpo,

On 3/22/2024 5:30 AM, Ilpo Järvinen wrote:
> On Wed, 20 Mar 2024, Reinette Chatre wrote:
>> On 3/11/2024 6:52 AM, Ilpo Järvinen wrote:
>>> The struct resctrl_val_param has control and monitor groups as char
>>> arrays but they are not supposed to be mutated within resctrl_val().
>>>
>>> Convert the ctrlgrp and mongrp char array within resctrl_val_param to
>>> plain const char pointers and adjust the strlen() based checks to
>>> check NULL instead.
>>>
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> ---
>>>  tools/testing/selftests/resctrl/resctrl.h   | 4 ++--
>>>  tools/testing/selftests/resctrl/resctrlfs.c | 8 ++++----
>>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>>> index 52769b075233..54e5bce4c698 100644
>>> --- a/tools/testing/selftests/resctrl/resctrl.h
>>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>>> @@ -89,8 +89,8 @@ struct resctrl_test {
>>>   */
>>>  struct resctrl_val_param {
>>>  	char		*resctrl_val;
>>> -	char		ctrlgrp[64];
>>> -	char		mongrp[64];
>>> +	const char	*ctrlgrp;
>>> +	const char	*mongrp;
>>>  	char		filename[64];
>>>  	unsigned long	mask;
>>>  	int		num_of_runs;
>>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>>> index 79cf1c593106..dbe0cc6d74fa 100644
>>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>>> @@ -469,7 +469,7 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
>>>  	 * length of grp_name == 0, it means, user wants to use root con_mon
>>>  	 * grp, so do nothing
>>>  	 */
>>
>> Could you please confirm that the comments are still accurate?
> 
> It's not, I missed it.
> 
>>> -	if (strlen(grp_name) == 0)
>>> +	if (!grp_name)
>>>  		return 0;
> 
> But now when looking into the surrounding code, to me it looks the correct 
> action here is to remove the comment and return -1 instead of 0. It makes
> this just an internal sanity check that grp_name is provided by the 
> caller.
> 

hmmm ... this should not be an error because the caller is not required
to provide grp_name. Not providing grp_name has a specific meaning
of this operating on the CON_MON group and a failure would break flows
operating on the CON_MON group.

Reinette


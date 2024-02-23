Return-Path: <linux-kselftest+bounces-5392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D25861FE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 23:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA0A28774A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C867B3D8;
	Fri, 23 Feb 2024 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvgOFmwx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365C117BD8;
	Fri, 23 Feb 2024 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727988; cv=fail; b=LSmSGWHewmfZycZYsJ1FGXGUFni+i31M3qIXzlXrmXJiwb+Xxd81FM5PL0nZQt/EbJoyqqlR6AxZmS6NLy2IsWXEPOY+drItrnHIh811AN2yr7+f1vcF+ZxtiV+VuOSISMMtnDcm/NM5J70Ivmn4FAvxpIMTktRLXtuAmcJzH/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727988; c=relaxed/simple;
	bh=8xRGranQVc5OvMDF7oFIaiBuWDXnBnCLk7wc2NXb9I8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RlTytRI45RnL4/5AeUNuNCVUqhtn6MM97DAJ0LO5kJza3rwgKF192BMDmmPKiik7Xgq8g3DQdSahFQq2aHl4twoSPExJGlgS0lGYs1N8oR0uyoPC+TJft5msgnHOpL2F4hGloBRUw8+meSVczc+O1nZDVOsINS1snLrDXAStRFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvgOFmwx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708727986; x=1740263986;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8xRGranQVc5OvMDF7oFIaiBuWDXnBnCLk7wc2NXb9I8=;
  b=lvgOFmwx3cl0rTaGU0NcJa+ftxquMgcJVj0IctoGxvXnNyHPdk1jfE7c
   QjWE2+s70G0kNKoxSQMkmNXGKeUKRTCAeEVzlWJ8J9Op14ZZM6HgOFQ1L
   eCFu8iW0+RfiefHaCWpBrFq/GWNyJkH++lBFjL9GwkC9VPVqpPXRHr1BR
   OmdXBp697OCgxcSVsvaLRnZsYlhL+D4Nwh8zQfUMEUaHj5SVBrgpMc+dp
   8UyftP7BWYCVrIsj7qZ+kVceeGzL5wd74gvVv2+dBV//GRiX8fSKZdU7g
   qNe+JXTjZH3M+sskLPoM3XZkI86Ob2PA0xB4sdrgB/bFwQtnsqxRDRt4G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6012572"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6012572"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 14:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6190761"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 14:39:45 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 14:39:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 14:39:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 14:39:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:39:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbPYwvu1sUIfLfxu+SFBvSBRr0fTkOT7N3VESLrUaUP5wl6CxKXwJmsl0EumAw4HH33WnCXUsk7RZDCGWHbms+SwerJ8DQORz9w3kMaxXqWFAKgYpdrKqV/yHSRkEmqSwjYjBY3PTiccgoZ5y4QQRGEkLiIkxrJvRCeZ6onEkbGf7OALAzz8YiuuZPAepu5+drz7PpX5/kWXLbvt5HjzdP/ILGpIq0meqVKcbhOQvoHugi8yZakKu6gr6IbZtblznFHCX7JxMOqKdGF1iYGxqJPNguXKBotMgcxJm2fATZOTxKqA3sbhPHe0zfKrX3wN1pTXZQooXdSPrGVprNBOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bu7QoRAUjZjsE+yLl1sxt8sHVCKHHLix3FIdoJqAho=;
 b=DqCTGOqUelaefluWK+8VAxTHBXM79/4VTweIzaMsqrHAgk28Fu83PTbpH1dNKCxNHhtexc61TSxXQzz2lmhtWaw0H4xUCO1eUZPykGxrxK1WEpJD000XzT+zIYxJXKqvwHFsrnIpqed4BOaoDCLWijfx5bDpIzMYcFleJXtH0W7IvXyzBKAavHGzuu60Sjgh2n2t3NpTOr7FufjmHSgZjP1QrOdus2qSHcUuo03MXfMI71S3xbN50ZE7lntjs28340hiTneuQ9O8FBP6UuYVx7nYoGucOuPbZNCTCpVy1Hru83ymUe2blsmAu2xR8H1LHaevMb/WoHw6172ztbauNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 22:39:41 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::5abc:23ba:d55b:2c2c]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::5abc:23ba:d55b:2c2c%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:39:40 +0000
Message-ID: <9f814712-7189-424b-9af2-67f565dc35f2@intel.com>
Date: Fri, 23 Feb 2024 14:39:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] selftests/resctrl: Add support for MBM and MBA tests
 on AMD
Content-Language: en-US
To: <babu.moger@amd.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1708637563.git.babu.moger@amd.com>
 <cc22790173de9978a6485baca5bc96a8ad8e05a4.1708637563.git.babu.moger@amd.com>
 <6f611a0a-f2ef-1017-07c0-5d805abb80d4@linux.intel.com>
 <efab7efe-d043-448e-bc7e-4a756b4f3367@amd.com>
 <fd71d5f7-08b8-4042-b94a-e81cc68c975b@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <fd71d5f7-08b8-4042-b94a-e81cc68c975b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0298.namprd03.prod.outlook.com
 (2603:10b6:303:b5::33) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|PH0PR11MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: d34a011c-c472-407b-f302-08dc34c052ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ooPpstfXDk0ZlRU2BCMlZ1UozIMhi3eM7yzPbNM0jLJrsVdJqy+huI5GUYL3qBO5jQqBJtSXz4z3UlvXzXoXFwNJ0YLA4T/yaNlkYXdfNR4YClEvUb6KzRFSACCFg+oByQmFaURHjplAAczenO88GK5L9ZB2iQSetkdlwweC2mTjLGsdc0vJHbOcSC8ntFUfLzYcPU5lE/IL2X9I1DokRHsp7M1PVeMLK76JgbyyFdoBwyS+g04r/CqNHAildi3fAsxMqBJ8LH69K6wA0OJ702ElTJ8U6pdHbHbtAQ8/YMfBPH4Qi318QiDIIvy5O4HLfLGLKGc37KUp0PpKWYak2jcU3eaCrCr7cZKqfknMUIfKgpTkr5LxLmwPdAvkyiP2MatueIMpG7XMucj8Gnz5WAXMcjQEqsCpxPU/AwBeFi+6tqqih7jDHh6KDdask75JJImVLVPasslwraQG270yG4lO8Z+FIGKfmxlueYaFkgJJFOvutZANuNUYASz4LngUll4rV+AA+PVSE52u8ZPCTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWYvS29KOHlHMFhxMnZqQ1JnWGxrRTFDczV3S2lDeGtKN01ZdnNHMU1EMStS?=
 =?utf-8?B?ZFdQSG50djc5ZlVIU2JXWUtXSUNzTFA4eFBrY2x1ODhoMUJsWWdWVW5OVWRs?=
 =?utf-8?B?bFNONVFpcGt4S09Jc2l0UEs1TUJ0aTZIbHBseVpLOFB5TGFhbDdhZFE2enk3?=
 =?utf-8?B?WXZSSGx0WkF1T1R4dVJETUFrd1d1ZXJNOXAveVZhVm9IKyt6dDZIUTliYldT?=
 =?utf-8?B?TzJLNHdzbXVUbG9POXI1NlJJZk9JRGxCdWxUcXFEaGRKZWNkTHh6RVpQcmwr?=
 =?utf-8?B?bVh2UzBXaUEzQ1AwdUNGcjZsemFOVEJqWXkxSFhHZXlHR2pYR2tBWmd4TkRN?=
 =?utf-8?B?NnZQUXNEZjlPcGpYN3hOdEhUdmorSzAweXJVM0lEeEFJSHk0bGkva3prcUxI?=
 =?utf-8?B?dmt0bVJyQ24zK1F3cC9SeUI1UHVaai9Td1BuQzFSNTZyY0JPNDd3QlFvcnVI?=
 =?utf-8?B?cE1jMWlHS2ZhVmNzaFd5OVNFdk1CSUI3cC9zWHVXbFlKWWdqYm5iajlLcmR6?=
 =?utf-8?B?akNTdEJONFltVXNQSHVTUEVnNW1MVzhSZjZ1M3h3Y0hDQ0c0enErUXlRV2tl?=
 =?utf-8?B?ei8rQ1VodFhSalo4aE9JODloVmMxam9KclE1bjdVSWtSejJGelpvdUdZeDV4?=
 =?utf-8?B?bmloL1k5b0tPWVdUQjNncThJTFBTeHpSSmNUeHpCZ3lkOWpvazFRZ0V3RE1t?=
 =?utf-8?B?RUVJM2kzb2lsZTY2VU5SbTI2REZqYmwydDg4anJqcnkwTUpZUFpLejlaMUhC?=
 =?utf-8?B?RldzNDBrWmEySitNL2hoQ3ZjV25yL0dlNm5VL0FGd2huZkJpc2EvakltYVdq?=
 =?utf-8?B?MXozWC9RNWdkdDlXWk1vT2xBL1JHUXNNUWNzczMwcDY2WEJrM2FpV1ZFbnh1?=
 =?utf-8?B?amYzRWFwNEdTbWNDa0pEZkI1Ynd4N1ArTkU3SWtiQ0NSaE1oS2FvcFZVL0lH?=
 =?utf-8?B?ak1IdEF6eUhjWENDc3FyZ3NFWUgzdGtQREJGMUIxcmNqNFg5d3FUZHJWTS9p?=
 =?utf-8?B?WkgyWG9pWjVVZkZpRzVPWEFkUjllWjMwbVArYUc2T3pFdTlkYXRYbGoyVzkv?=
 =?utf-8?B?bTM2RTZqdFRtbTdkNUd5UjdlSUk0MkNJc3VDS1ROb1dwT1Fxdjl3SnBxOElk?=
 =?utf-8?B?UGFUZ25SOXRvYmhzV0tVaytIUXNxSElEVjJGSUcwQkxuNVNMQUlvTUN2by9z?=
 =?utf-8?B?WjU3eElKejN5SnBKOWhjTHd1RjZpcjJtSVhyOWpNMDU3NUpGNHRaV204OUxP?=
 =?utf-8?B?Z0RGZUdDN1dyY05uZUtVRXNUK2FucjZVS1dJc0t4NWF2UDBCQXJJRm4wMmww?=
 =?utf-8?B?dVV1eDM2cEtVUUJVNHBVNE40dkh0U1hZYkZxVHZIQVlFU2QrYVVjZnZmZnJr?=
 =?utf-8?B?NWIvZEFvRkw3Qm5iM0ZQOUtNOFI4N3kvZ2o3MnBPa0x5RVc0VTVTd2ZoOXdV?=
 =?utf-8?B?dC8rVkY2ekF0UTN1MFZEKzQxakV6bzdtZSsxRG43WEZsRnJpeUFIQjRZUUpY?=
 =?utf-8?B?UEppQVBRdG9LcG9HUnM5NlJkcFZKSmUyT3FZOHRaeEloeEZGMy91Q3dGbkVl?=
 =?utf-8?B?b1JCTEVQY0JVSHBCeDI4bmNoSE5ESUh2bnROVEROK2NIbVk4TUdXSlo2NHJq?=
 =?utf-8?B?UHJmd09BYVAwWHZRQ0pvVDJsUDNRNG51KzY0ZW9COVB4WklGQ2xPZTNLeTA1?=
 =?utf-8?B?RGJ0NzVNVlVJcGt2U1NKT1QwVS9XREtjRTRHYU15Ukx0aHZKeGRQUXVKZkFW?=
 =?utf-8?B?VjZ0WUdIQm9mVll2WHFvdHpuSXZLaExWNkVmV0pWMXp3cVQyZ3huVDZBck51?=
 =?utf-8?B?ZHBMbjBPQ0x2N0R1UlpzQnA1WmE1SmFHSVVvTXVqMU9saGNiWXZsVWd1QnFC?=
 =?utf-8?B?RUNmNFhCa3JpL3Q2QjVhZzAyYm5FbHdxQVZjL1d1QVdwQitOTXdUSUdKOHNU?=
 =?utf-8?B?a0QwRUFtTmxkWHdLcDNnd2FCSEhqUklwbGxLNVMzeGlVTDBFMHNZTit3Y2kr?=
 =?utf-8?B?eTFDcStoK1I1RUducUVzVXRZUFBOTXFLcEo0U2h5TFVFakdYNFJnbDZTZjRY?=
 =?utf-8?B?Q1lvdm04UGJSam4xN0N1N1RVUjMxNWlodytxV2hoYU51alFFM2x5YisxQUdG?=
 =?utf-8?B?L0ZRL1htai9yQWVPUERNVWhOTWtVR1ZxVmtURytwTlVzdFRsRVhjaVB5bFpj?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d34a011c-c472-407b-f302-08dc34c052ce
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:39:40.9403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeP7KUsKZzvBxfJsBKTwoDYkzr4eEA9v+whkBfiYstxmQr2IQQKn3VeKHqn8O3f8TJlrAOyUEwW9I5Eoq1PqA22tzROxlztNW6fldnBGg9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com

Hi Babu,

On 2/23/2024 11:47 AM, Moger, Babu wrote:
> On 2/23/24 13:30, Moger, Babu wrote:
>> On 2/23/24 04:53, Ilpo Järvinen wrote:
>>> On Thu, 22 Feb 2024, Babu Moger wrote:
>>>> @@ -131,8 +130,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>>>  	}
>>>>  
>>>>  	if (!validate_resctrl_feature_request("MB", NULL) ||
>>>> -	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
>>>> -	    (get_vendor() != ARCH_INTEL)) {
>>>> +	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes")) {
>>>>  		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
>>>>  		goto cleanup;
>>>>  	}
>>>
>>> These need to be rebased as this code moved into per test files with the 
>>> generic test framework. The .vendor_specific field is the new way to make 
>>> tests limited to particular vendors.
>>
>> Hmm. I picked the latest code from tip/master. Where is the latest code
>> now? Is it yet to be submitted?
>>
>> I can wait for your code to merge first.
> 
> Oh. ok. Here it is
> https://lore.kernel.org/lkml/cover.1708072203.git.maciej.wieczor-retman@intel.com/
> 
> I will rebase it on top of this next revision.

The resctrl selftest changes are routed through the kselftest repo. Shuah just picked
up this series you noticed but it is based on the framework changes from Ilpo that
is already merged. I recommend that you base your next series on the "next" branch
of the kselftest repo [1].

Reinette

[1] git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git


Return-Path: <linux-kselftest+bounces-11451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3951F900DB3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 23:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A6B1C20DE1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 21:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ABD154449;
	Fri,  7 Jun 2024 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lU6ZE60P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25C14F9D8;
	Fri,  7 Jun 2024 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796877; cv=fail; b=bD0sOehD7UhOBP90KGSTVW4PD6N69W3ss33IQaG3GOq5M7+Cv6f+SCGWKyFlijfDta9tdhDWuEhOmqKPZOixueWgUx4GmsFNIbgtKm7h8UvYf5LX8fcrCJzWiIIOypaucK5WTZGyig7P/1Om2+e6gkmpywikcpeWIWsf/Qoe/x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796877; c=relaxed/simple;
	bh=cLVlO5WzJrjEcFyoK6RTS/iuMJb0vHKDSJKCGBpRADc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BncbyRzS7pNOVMlPW6t5mEegm4cZvwVFyPosKYCBx8Mh2D4UK640jPewPI1Pq4MNwl1LImPQhtWH8In3h2CFEFFdCZOwGVLmtS0/3brcMtD/2OYvh3+PaoD24gHxYsDCT/althA63804ejpv0W3uHLhltXPjyJQNwAu4GuQZqSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lU6ZE60P; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717796875; x=1749332875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cLVlO5WzJrjEcFyoK6RTS/iuMJb0vHKDSJKCGBpRADc=;
  b=lU6ZE60PB13nEubPMWac2uJTMTgX7p8phkv/jeqTuoEWDd2kQ2+11Uq7
   I5nW1sE0p3AkOxddij9QC9OViGm7YFyIP8EODvaIKP23wEHHcXdkq8/NA
   8Eg1in64TOkYWk4dZHclNexxowuGSr5X8icf/wHNxvHhxRqjJJRCVgkGE
   3yMRnj7l6v02PzP2Ln65lh8rcxKh+mVaFhbkQ+8GlnsDsnCLeC1vN+xeL
   UOoDUJStI2FTmLfFnijLyL7+d4U3+xg8jABxvvjAqAuvDG4scam+2bIb2
   OUy0JT3urZCX4l8skO2T/2bkLs8Zl51UGjMRAi78hV9z/UhaTXEywpb4A
   A==;
X-CSE-ConnectionGUID: Jj8hjvabRIWvrapekYUtFg==
X-CSE-MsgGUID: qnZjun+uSOat+fB86viYAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25162564"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="25162564"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 14:47:54 -0700
X-CSE-ConnectionGUID: BIzbkugUSJmOigT3+5bDnA==
X-CSE-MsgGUID: yS+ZUKXlSSGMAsUqKFWPWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38392224"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 14:47:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 14:47:53 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 14:47:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 14:47:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 14:47:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Akad7SW3zU/eGi3ehHzjh5jrkdAfIVKYffqPnSbX+1z+Sc6LOzuql2KbJkk+y2tqgFqvXhRknfRF3yF6v4hf/enSDWRwA5DXbaZ7Ea6yi8WNDvOIf4+EXa4vzyH/WAJkbG/8ThLZ4uRoWpXrKgftk9eOdIW136tVlE96KMAUwPnu2C5fyZJ730utqLP3Wa1Yxr2xe3n6e1K+kRHEV2HNJwGsm3hq3OugNirizZZmCiCKjpzUIFxAO5kVuwwXsu6AIZd6KyEThzO2U8KymlAP6IdrlpTTFVl4jzPuF9SqBLFg+2ZTloH7lcamyKmjWx5khS5LUOGk/q0ujcV/gNKObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIe+2khXsxTeNfG2qgCx3dSGrNrs4x9tQXI5Oiix9nM=;
 b=a4rvr/F1R6952lElVwfb3UTk3ePZYyCsDB+Tbi9lZQwFJFiai7vXpjGFOjxH6NcGSeo1P3pimWWcNsQFZw35yMdf6BsC8xVkPWS5ux8Odl9djHF+M87biBzr2zCZyGRU13BkuQVm5eGWtdGmYuEpYNbyfw7Ae0mQmwYQ6grvebfai6NsMqYKKVp/7Cmgt6xJz4/zV7JiGetg/OY5vPj0Nxwr8VQ+f3YOF4gx9TCNZeju73rB1zyNnGcFL5xe57CJskz24gNgBqSfIyhYAIbpYhsCEtInYNrI7xVc6CNhN3g97eXy4tPcC6peVZyK+Zix+Z4E3tZODky1a3wmZ1bmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB7069.namprd11.prod.outlook.com (2603:10b6:510:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Fri, 7 Jun
 2024 21:47:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Fri, 7 Jun 2024
 21:47:50 +0000
Message-ID: <2491e8da-8664-428f-87bd-40595af7af47@intel.com>
Date: Fri, 7 Jun 2024 14:47:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/resctrl: Fix noncont_cat_run_test for AMD
To: <babu.moger@amd.com>, <fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <9a7213d2-a782-4342-93f2-acf191c745fd@intel.com>
 <3bd755d7-e5c7-3dc3-9875-4884c857e325@amd.com>
 <8553ddc2-ee0f-447d-8fe4-5a7dd84375f2@intel.com>
 <edc31538-3aa1-a35a-ea67-b13f626a84ec@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <edc31538-3aa1-a35a-ea67-b13f626a84ec@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:303:b4::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 72aed64f-89a8-42de-8d3e-08dc873b7a51
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEk2QWYwZnpxNy9zd0M5aW9ScU9PSjc5RkJNNGdKRWUrbEh2R2p0ZExVNUd4?=
 =?utf-8?B?U2JaczF5emJBQkhLdGVUcXAyaFY0MWZVQnlmTURzQXBKYm0yeU9CbWtOSXlm?=
 =?utf-8?B?SHA4TlZPZlRXc2lvTDlYck9mNDd3KzFOanFGN2Q4WjBFNWloWCtXWnNDRmZn?=
 =?utf-8?B?K3RFL0NRNzdLdUl0Qkh1SHh6cGdZUDZZalhqMEZMZGpHRmF1ZHZuQmdZc2ho?=
 =?utf-8?B?VDhzbC9weW43bXBDd0ViQ2RVWXl3WHhYeEJQODRMMTBra0tNUEdyck9vL3Er?=
 =?utf-8?B?OWpHcDlWN1pzZFRqbmJwaVRxbzNWdUVLYzFqbzFEOUlISEVNUW1VazM1bVJX?=
 =?utf-8?B?WnhIWDJaTm1MOXlFenZmZ2ZmUUg5cktNcXZpYzgrK2hkWXRvaGRuTE9MdVph?=
 =?utf-8?B?dVhnOXZlZXRaSEh0R3pzWEc3NFBtMmNzc21yUS92M1hkclRTUkJPNzZGYnF0?=
 =?utf-8?B?YkNXM2FQNTRXSStVTEUxdFVyY3JrNEIvL0IxT1dsMTZyekt3aUJnalFxUjh6?=
 =?utf-8?B?bXhTa3hUamQ2WmhTRWUyVTlmYkRmWnByeFNQdElEZE9qUXFCNDBuWHl5aTNa?=
 =?utf-8?B?SnRPdEZPS2QzUERaWjN2QXprOGsyVzI1V0RzWTFYSkRBRGxTZGtEUnc1MnBu?=
 =?utf-8?B?Wm5wQ1FYV0NYalJmMjdjSVdMZmpQaHB6Wi80NjJUZ1F5MmFZYzEwRlBFVGs4?=
 =?utf-8?B?WUM3WktURGp6dnFkb2ZuUTU1NSsxMXlEaUQ4Y3NZWitiYUpwRFMvVElGb3Rs?=
 =?utf-8?B?Vy9JUTVuT1VydnJXSjRHN2J3MHdPQm9lNTZVbTk5MzV5SnFuaE5xL0N3QytH?=
 =?utf-8?B?R0d5enZiLzViUHFYMGVaazFkcU1GOVNHMXJnbGp6ZHRaejJ3WG1odlFTRU8w?=
 =?utf-8?B?cWFrWGszZ1FhYk9LVit4aEFySDduM3VDL0J6YzJTSFlYcmJkL2dFcE9jLzBE?=
 =?utf-8?B?ZHNIYUFkVW1uQzVWV2lLMElPOFdKblhhVWY2VGZaMmRFeE1IVm5wcjArSFdn?=
 =?utf-8?B?ZHg3dTNuakl5RXc2VTRyOTgrKzliYkJhRy9kbko4WGJGMklvODBRT2JyL20y?=
 =?utf-8?B?WXNrekRyaGV6SEtUTUFxWS80Q2ZuZXB2TmFTZFZTKzV0NkZiVEhOcXdxVlpO?=
 =?utf-8?B?L3k3WGdQdTJSdkxBaDlPOWZQRFlTODZ5ZGxwUmk0cGdkc1R5UXZQQnJTY3I4?=
 =?utf-8?B?cXdMbE9vK01tLzlsMG55cERKTVFvQ3FoeXJ2NTh0WXQ1VDBWU0VFWmNTYlB6?=
 =?utf-8?B?NXRWWTlpWk1QcGxvSEZwWG9pQVpUUCtRQWdBaGkrZnNnU2lOUlNHYktwUlgy?=
 =?utf-8?B?d0plNXdUMFR1V3BuczVQTjlGdjZCbERpRXVUNjA2dlFHSzBXdUZqME9QdHJn?=
 =?utf-8?B?V2hQN21UK05ab1N3aGoxRURFRmpVSEticU5VZ0p0YTJHejdDK3dRaTJ2U2xO?=
 =?utf-8?B?OW1VaTkrMFVFT0UvQ1FsMWptenFGUHFsME1Ld0RsY250Q2R0cUt1SjYrK3A0?=
 =?utf-8?B?UFo2SFQxT2dNOEh1SWFqMnZVVUgzNGo5QXFKUXpqY2Qwb0FDdTEwT3RlWWFw?=
 =?utf-8?B?bEtKNkVkZk5hbHZmaHBKa0k4clcrdXh4Yk16UVlYN3g0cFRuUVBqZWMvekRa?=
 =?utf-8?B?akU3ZWIzS09wcCt6UEhMckZqd0pZU0o5K1hsQmE2eVo1NW5uTmRWeDdpT3Zq?=
 =?utf-8?B?RWpVZVpKazhTYnZBUmc3aS9WOVFTQnhOSmlzbVgvQWdYT3JQbUxEaGJxSEl5?=
 =?utf-8?Q?OGbcOdmmLU6cYN5FJAFPILwDKdaEf7vAj0Ga609?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGZ4SndORy8waTFhVHpDMXV1N0Y1WEdoUzh6VFFWeVlFYWhuUHJpVHZRR1po?=
 =?utf-8?B?ci9CVkFZR1kxdXg0WUlRTHpDUHZBamg1S0U0MXVrODlzeTNPQ2lrR3orVkl2?=
 =?utf-8?B?Rnl3YXBSc0hTbC9ncXVnNEZRVjM1UUdCdU1oYzNxZ2s0ZmRIM1J3RGxCSjB2?=
 =?utf-8?B?TnlpWU9BVjNXQ1VpbVhTck9ZdHdIeUI5SWVjcTNQOFViNmJDRytBOGpuSTlU?=
 =?utf-8?B?cjdneFdZWUtaQ2s3YXNWaUxkUlF6N0JaTmNzSUkwOElTSlBJRmgrR1BEaGlu?=
 =?utf-8?B?VWV6bDBNbUttcnkyRTVSQTFxM2IrK0tSc2dxV1Z2M2FzeHRrZ3l6c1Rodjd5?=
 =?utf-8?B?UTY5UmQ0OWEzQTgraFptMThTazFNVzg1R0FPdjZHdnQ2RWdkdUNFOXhNMUdW?=
 =?utf-8?B?ZlRUTE8rbEdSQm9pUjNmTjZsUTRYbzA1YnpGWHFSeFltKzJlekRBWUpGV0NT?=
 =?utf-8?B?eWxZeFJDVC8xMXVVL2UwNVJhdEJXRG9jdHlLSWRyZnJzSU1BcDNZa29yakdB?=
 =?utf-8?B?TXhXODB1Y0lXQzE2aE9FVG5Pa0tQSkNqYXNHb0hWb2IvVlFzY0Y4ZndVODk1?=
 =?utf-8?B?ZG8waC9jTTN6RGlmUDE0ZTNiMGpuZ2lNaXVTOCtLZVo0ZDE1SUR5eHNPVHlD?=
 =?utf-8?B?Z1FZNURvVjEwRnByTHhHdGNpS1lGa0d3Mzl2bHJwTmFycCttc3djZGFvaGVJ?=
 =?utf-8?B?ZmVNank5aUlOVEJuWE4wb0VBREJqenNMOEl4cXpyc2VGNG53V0paRGU0Y2Ju?=
 =?utf-8?B?ZC92bTJHaHI3Y1FrRXJZbEI0dEVoQjUxYWJ1c2E0TDRtMHFvdU5sQWRvNytD?=
 =?utf-8?B?UEFKYmxNWVBTYVJkUldXWkJ1cVRqbjYwWXdmU0hoZG9yMlN1Q0VDT3pZSzEx?=
 =?utf-8?B?TzBNQUJiSVR0VmFIWjNhWVNrSnVMUkdTVkFOQWVYRGNyREt0S2I3WU9BUnBu?=
 =?utf-8?B?c0xkTzc3OVJGVkxuaDlEUFh5eVFDVkJobVZ6T1J2TFZmWE1Ham1LRVJHSGll?=
 =?utf-8?B?bGYzOU1xV2k5NDBhR0lpTnVpaDlLM0IyS2dEVTZpZmtJZkVTQzIycm8ydUJU?=
 =?utf-8?B?ZUtTMlZFWmxkaUloN0ExNXUrTklWT1YvQmczMVhBUDJmajF2bkFEUU1xSGxv?=
 =?utf-8?B?UUdCdzN5UFlvanR2eTdkamJCNHd1NUlSSUp1TFdmeDAvTUhMYUNzTE4rclRY?=
 =?utf-8?B?U0p5Q2hycG1vRGRqTFFpM1UxR05zZkJFUVVsUEg3TUZEZldaM1prd1FyK2tQ?=
 =?utf-8?B?Wlc5OThHWE91SHFKZ1ZQR1FlZTNHM040TmZRUEZGMVlxTWJJTFZCU2pjY1Qz?=
 =?utf-8?B?WTI3bzFDUjdXNGJIZnVqUURPdmJweGVnNndtVzhsTXdra045VHBOeGVER1BL?=
 =?utf-8?B?aEpGWXQ3YWxFcGRrQklOalZjdUk0NnBMMHdQcjBsQlZ5VmFvb3BjUUx6aGk4?=
 =?utf-8?B?Wm9wajBkNjNvaU9paEYvS2cvbXJzdUdFL3pxL2pqVVlxQVRsamNZbnRLRmR4?=
 =?utf-8?B?WklnVVY3bk8vNVlINHNhd3JHSHRseFdSdEQvbVlmcnA5NlBDSGpaNkhSSWFM?=
 =?utf-8?B?T0pHUGgxRlo4K0pzNm1oVU1CTHdHUXd5RDdzaGFtQjV2ZnZHMWpoVnMwWmVw?=
 =?utf-8?B?c3JMaWVPQnhzVmRBSEpIcDVKT3RDM1A3bzhJdEhVWmgrclFtU1U0R1FqNXcr?=
 =?utf-8?B?djJsbjFaZWJJNllMMHFINTRJOCtSS3FVTnF0TFhad0JRUnJ4OGM5azFlckRo?=
 =?utf-8?B?NytzYXhzdkpmaWRxdHJJOU5IekNpSlB5REdHK2VUeUp1d0hEeElyR0MvL0J6?=
 =?utf-8?B?NDJOQmZrMlpUaFhQWmFoSm9YNW5lSTlwQXpMVVBqaGdSOFNoVU1PR1pUQlB6?=
 =?utf-8?B?NjJNNFljTVQzVFg4MncrWVlHemczOWFCVDFoelZQUXY5U0l1NTNSNU9OSGsv?=
 =?utf-8?B?MEowY05Hd3V1eUtTUVVOZksxUmZwaEM3aU9XbzFyckwweEtReldWRy9sOCtk?=
 =?utf-8?B?a1lqa0R6K0F4Y28rYXFnQzhpTnBQWG93NHozSHQ4VExPYUgxQysvN1JPdVBi?=
 =?utf-8?B?a2dTejZkUEEySU1XZ2dZclREY1VrcE1DclJzQ1ZZU2svbktib1BMM0lRQ0tw?=
 =?utf-8?B?WXk5cTFyVWQrYlIwR1VEMUYxbmg3SE1HQXRoMzR0WEtGMFhYTnF0K0hId3g1?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72aed64f-89a8-42de-8d3e-08dc873b7a51
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 21:47:50.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /23ZcdUx+r+zzXq9APtdtlCWwXevPAmvAhqSO7JursaVNdveQblT/1c7rJ+L6pM+RKy06fNTONL1k7z+w/etoUeUBcUj9kFXHStnDGB8rIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7069
X-OriginatorOrg: intel.com

Hi Babu,

On 6/7/24 11:16 AM, Moger, Babu wrote:
> On 6/6/2024 6:58 PM, Reinette Chatre wrote:
>> On 6/6/24 4:09 PM, Moger, Babu wrote:

>>> @@ -301,15 +320,8 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
>>>          if (ret)
>>>                  return ret;
>>>
>>> -       if (!strcmp(test->resource, "L3"))
>>> -               __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>> -       else if (!strcmp(test->resource, "L2"))
>>> -               __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>> -       else
>>> -               return -EINVAL;
>>> -
>>> -       if (sparse_masks != ((ecx >> 3) & 1)) {
>>> -               ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
>>> +       if (!(arch_supports_noncont_cat(test) && sparse_masks)) {
>>> +               ksft_print_msg("Hardware does not support non-contiguous CBM!\n");
>>
>> Please fix the test as well as the message. It is not an error if hardware does
>> not support non-contiguous CBM. It is an error if the hardware and kernel disagrees whether
>> non-contiguous CBM is supported.
> 
> Not sure about this comment.
> 
> Did you mean?
> 
>   if (!arch_supports_noncont_cat(test)) {
>                  ksft_print_msg("Hardware does not support non-contiguous CBM!\n");
>                  return 0;

The above changes whether support for non-contiguous CBM is treated as an error but the
test should still proceed since the test goes on to write different CBM to the system
and verifies results are as expected based on what hardware supports.

>           } else if (arch_supports_noncont_cat(test) && !sparse_masks)) {
>                  ksft_print_msg("Hardware and kernel support for non-contiguous CBM does not match!\n");
>                  return 1;

I can see how this will work for AMD for the scenario being checked but not for
the different Intel variants.

I think this can all be simplified with something like:
	if (arch_supports_noncont_cat(test) != sparse_masks)) {
		ksft_print_msg("Hardware and kernel differ on non-contiguous CBM support!\n");
		return 1;
	}

I modified the message slightly since non-contiguous CBM does not actually require kernel
support.

What do you think?

Reinette


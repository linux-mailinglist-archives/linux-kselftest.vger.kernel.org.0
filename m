Return-Path: <linux-kselftest+bounces-21413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0298B9BC14F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 00:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3D61C218D9
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 23:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729761CCED9;
	Mon,  4 Nov 2024 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7MmcrQ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7716087B;
	Mon,  4 Nov 2024 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730762069; cv=fail; b=NP/pFHNlo6b5XTQhlnnPT+8W1VQBgLRFsnQoOTBw65Go6VgMid/mRYOCUmWoIEXIQkkmVN6oEfuhDJNgwVrdovLGlnfp5JJbLMuog+wwNxHI1ckhjJgzR578UAKmjhM8qTpD3fDSao9F8+Kf1SfBf6dF7EGYvssvrZIdMMXRMKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730762069; c=relaxed/simple;
	bh=Bdn3iZHwfMYLNaa7LZzeewNqwsY0KLKU22PYwgmms90=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BuNU7BDjIsMyVEYJlcBqMWKSGAtonERX7YkYc9901+BIKdxzPLMHZCwJ0rREWEuTs+QKB7HUTrcQ9Qy9acFhrjVy5/Hd/xAL2bj8smSIhcrAaIFWVDpnJrabBkIiopU8jIbX+ZMACkln7Ik7gdXtRXXnfpdD3k8Hb2hQeUs+O7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7MmcrQ4; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730762067; x=1762298067;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bdn3iZHwfMYLNaa7LZzeewNqwsY0KLKU22PYwgmms90=;
  b=L7MmcrQ4Rglo0PkZwPv/8h5nWcK01T/v5IEx3q3V0b6RfGmrdpqN3sUa
   yzTfjH9IEoMpx8rYjMYRvO7Dx5he/CcZdqfXQ71F8ImZQRW+BGIN4EgHV
   xR8UH7Z9S04mhGi+lR+9j90X3ywJMP1Nd111mW3Wc33b/cQG8KscZxjyF
   bnbeXTxs3XuFkyk0+pOhyuIrC4CCQR139wPAi2P0Bm+MqXpbtoGu0q8qm
   Hsv/MO7A367bPNAwkg2r7mNERrBgUMdAk/9CLgSqWDfHW2LeY8pN5bfVc
   kB7GzwTdnG30m7i6iYncF0nhMwIBn8Qd9kTF1oOhVc8h/M/DTCtY8Gcrr
   w==;
X-CSE-ConnectionGUID: GEf6JvepSrq2/+s4BzeEgQ==
X-CSE-MsgGUID: biQVA298StGKbMO2n/AjEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34170351"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34170351"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 15:14:25 -0800
X-CSE-ConnectionGUID: iD6KFev5Tqazjv4IAC04LQ==
X-CSE-MsgGUID: gCCy5n47SgqXycYKsW5cRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="114586016"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 15:14:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 15:14:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 15:14:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 15:14:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeXRpNAYkaIYp5griO8JLH60TAH5i0DRYoHgRuPWfNSkITqeGAz8UqbYJiboE7NCwc9kX6o9o2TzxazP+JbIa6yJBcgmbae34K+tAc6TPXnJc2ReigL1rTQVBAdOfd6qp9Z/ubuXa/C+rRP5lB5iJ6uU0knsLJy1oFi4M6HuZTibOL1QwRZx1u6iDa64p+nQ9uHmdGUuDldbOAuna6XD94s6hxv84Fgdu1XM2UXr8fNRSHDslfOb+jJU7rnq9tvA7fVajDQKJ4ETps1R2k0QQJ1gdLTuGEibPudBzDfy3JlhqThWpBDsSz3fS6gz5mQO3PWp5vsD8JfAuqqkeZuf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6mLHygs5wFIKFcgDsvSxyLyJUVrWj0IHHjYjA16hUE=;
 b=MedMyhZ1GOOIWe5znK0iUD/FrfhOjLdSgbdgvtDtSh8vE+tM8iXU3k1Ql1/BO2ud5RTaD/hcx28q99j8X4damnHaVW7BpnSDLpPzE59eeb3Auf6PKnhP1N877gDdcRtJlY2zCH2ypp7g28VwbSAOEoj+yUNltRTHAKDWlOPkYI9yd9KF/McQz7wqUa7yvZMEK3QvmF/5yI/EFWsQoPs632Es0ka0SCOL4rN9bP5nSbGpuihK7GK1odqXcwIpR6FD0Os4fFxscbU1n5R7vbx+aNQwn5h440uJZ/BSfrNfdMN0YbuySa5k1Uq8rY5a8bY+vdwzjoWRsPbTXD37zisXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by SA1PR11MB8840.namprd11.prod.outlook.com (2603:10b6:806:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 23:14:21 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 23:14:21 +0000
Message-ID: <10d28348-9946-40ef-9e7d-be0adff3ff14@intel.com>
Date: Mon, 4 Nov 2024 15:14:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/15] selftests/resctrl: Support diverse platforms
 with MBM and MBA tests
To: Shuah Khan <skhan@linuxfoundation.org>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>, <tony.luck@intel.com>, <peternewman@google.com>,
	<babu.moger@amd.com>, <ilpo.jarvinen@linux.intel.com>
CC: <maciej.wieczor-retman@intel.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1729804024.git.reinette.chatre@intel.com>
 <aa643c9b-8ce5-4cb1-98f6-645224aafdf8@linuxfoundation.org>
 <5b2b54b8-77fa-4ef9-aa08-549cab91eb32@intel.com>
 <3ba7cd24-a68b-4996-8b36-dbf3164db8f0@linuxfoundation.org>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3ba7cd24-a68b-4996-8b36-dbf3164db8f0@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:303:2a::15) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|SA1PR11MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: d2799595-f67a-4e45-4b59-08dcfd266a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXFNUldkeTBxK1RaZjRWelluTlVONi9mcVg5V3pIb1ZYakxMYUE2dTdpTmg5?=
 =?utf-8?B?ZzhjZUtPWXYwVnRLbmQwWXBDZHlZRS9rMjFBeGRnbzJ0MXBlMEQzTzlYNlAr?=
 =?utf-8?B?YUY3UCtweEdrYXZYQmRyVmRVNk5yYTFwTFRpTnhwMlZaRFpCUTZKbUc2SkZl?=
 =?utf-8?B?aCtSSW9HZjA4eDhBT2ZRL0tlTFJvYTdsM0QrcUcxQ2pVRzA5SVFGVW1FZXor?=
 =?utf-8?B?MnBqNXdJYmw2RS9OMHluOGtYV085dkhyZjFwVEZNaEdRY2hDWVZ0R0RwK1Vs?=
 =?utf-8?B?S1pDOVpQZzNwSUI1Slo0K3dvMkVRTUs3VkxrbXo3RDRTaTVSM2MvZjlOUlQ4?=
 =?utf-8?B?dm0vd2RJT01ua2lleXIvanhqbnFNU1RQaHd0eDVxMjJibEQ3dk9aQjZ0S3B1?=
 =?utf-8?B?bkhjdHdodzRXM3JOMWgyU3l4YU9NTUgvQStRTlE4L1lRaVozc2tXUm5ncTAv?=
 =?utf-8?B?N0ZuWEhiMFJOaEZlUVkvaWRQR2VLbWlaN1JoQ3h6TE1Kbjk1WWNCWHUwbkpl?=
 =?utf-8?B?bEw5UVlIMnlQVkpDWHdzbGEzNHRjYWd1UWxCeS9XVmJsN3lsR3l4QkhOcS8r?=
 =?utf-8?B?Y3M1bWZCRy9iTHV6QXE0ODVvaDVHeDFKS2NFMHJNZnNFcXhsZFRtMFNEL2xE?=
 =?utf-8?B?eE1ib0ViRUVXOWZvY3B4WThBWWx0QWlZYzRNSVFTMDliNDU1YVdRNDZya0Qy?=
 =?utf-8?B?VHF0SDYrM05pVXp1WEVtc0FlRExHOEYyUE9yWUd5eFNCWUNlc2dtczVFcGho?=
 =?utf-8?B?Q3dKOTVhQnY3MXBpREc1MWswOEpaL0xoVmRvRklrZUxYSzBpVEsvYW45Ty9k?=
 =?utf-8?B?eTJxQ3NNa2ZaVi9Eb0NYdU5nckFpbENsSjVpakJQcytmNnpNT0E3ZndXWXZ6?=
 =?utf-8?B?MndhamxGTG9VUVFtN2RMRXM3alFCZzEvendmSjIvV1QvMWtEalBMZ2d2ZUlT?=
 =?utf-8?B?S0U2eDR0YlZzanp3eEgzSy9YUVMraGxyVE42MVBhNytsTW51cThvelhiSGFU?=
 =?utf-8?B?MFhIMUR1Z2xQdkVZa2hIOUVtWXQ0N2V3d3dyUkJsaUpyeXdEa0pldlJSQSsy?=
 =?utf-8?B?RnlWQW5pL3A4QjhHeXMxS3o3M3RMYkJ5QkJhQ25VVmg3cXZLL1VmQ1MydHc4?=
 =?utf-8?B?dEVuQXQwZTl4QU1qYnpaaTBXTzRMK1h6RFlwR1pXZ2lZZFdOVzZ5UlVhZ3Rz?=
 =?utf-8?B?M3FyUWw5RkN0WGxzbFkwK2hOMWVRbjJzeVNhRVJzbXhxSUNsNHdUVmVoR2FD?=
 =?utf-8?B?RjdTRmpnUGp3UUIwZUNyMXhZOFVvd0ROSDRiNUhVR0pUREQ4NkI5ZTQ0Uytm?=
 =?utf-8?B?R0syRVdra1hueENINGwyMnY1ZWhBWWZycGE1MVhUdzRPaU1kSHE5SWJ1UXFu?=
 =?utf-8?B?QUNkM3h4OUJUNUVqdElPUjJtampjc0xwQjU1U1lnRHBCZTFQZVU2TWVUZ0Rn?=
 =?utf-8?B?SmRmWEdJUmJqWFEwanp5NmJ5VE5hTXc4RFBPdWZvdTZNZTlYSzJ0cGtqVzRj?=
 =?utf-8?B?NGM1TVZjcEVpN0MrMDZIempwZGFRZXplRzg1ZFdhSERlRjBKZ000WWdZVStD?=
 =?utf-8?B?aUJlWGpZNW9sdmx3SEFrUGNLZVI0eTNkeEJkZWE5eXlMZm5lQkZTenlTbHdp?=
 =?utf-8?B?bjN6NW9JOEFSdE0rK0NMd2FzV3RTc3ZLbzhwVlhVY0ZxbGRyMGJIRGoxZkZw?=
 =?utf-8?B?dHNMZGw0WTZMd3VNNTM5bnVIMm5ZR0t3WXc0NEwvajZXQjNydThrMEwva0RI?=
 =?utf-8?Q?x6MS202Qj/i49VlWfBNTqf54JSPbZH9XRQ/O+9x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkVqQ09CY3M5OGhHSWpDMUVoM0E0dTNBWUdzR0xKMGFOVWJsaXlDVlFQY2dB?=
 =?utf-8?B?R3JvY3FFN09HV01tZEFZa0F4d1h0ZTYrQm1OdUdjeHV6bUpHdklpYU0rVFVE?=
 =?utf-8?B?cytQZ1UyaFJsRGNwMDNnL1d1OTY2R1NXcTJZVWRTYlNFejcxYTRQZVRsNWJ6?=
 =?utf-8?B?aFpzbjZJUFZTME50RWFWdG5UMW1iaFBRbjdRR0xtY055a3VaWkhKaFVwaktY?=
 =?utf-8?B?SHBmTzZUQlNHSm5weGVXTEthZXBRQ0VKK3dBRzdNMzBpNEsxU1oySmhzMENi?=
 =?utf-8?B?c0lvbmMyVkxUcG4zUjc1NnZMcmxCenFjS295TWVtK2pJSGVaMS9GYUZEd3Ny?=
 =?utf-8?B?Yzg5dXNyQzlHZ3NkVTJZZXJqM2VFM3E1cDlJd0tvcU0yZE5saGVTTUNvL2tI?=
 =?utf-8?B?VE5PUElvYUlreSt6YVR3R09HTjd5cVJrT29lUmdnZzV4M2NGbXdvT2Ztcm1X?=
 =?utf-8?B?azBrSGNIQkpwTkU3UGc5ZzFOdVFqL0UvL2lwRlJnNUJqYlhscUljR1EwUVpy?=
 =?utf-8?B?QnRBQXkwR0ZBRmRnYmJSc1o0UXJqNDQvT1htU0ppVkpxKzkvU0VpNWdnUktv?=
 =?utf-8?B?bFpDUWVqM2ZWalpKSldBQnVGZTRDQ0xzaElKejdiQmEzVGxPelBZelRiM2VX?=
 =?utf-8?B?bTloVngzQ1ZmRHpYcVREYVYyTnhDcktRV2F6MittSDRmejhhVHAySFZHaldp?=
 =?utf-8?B?aUx0a2Y4eTlROEtmMlEvU3ZqMTYzMlFNNkMzQTRQUXdRR3ErS0szSU0yRVpB?=
 =?utf-8?B?T0cvUXVHNWxEc2tvL20vdllzK1hKNlRHUDlrU3RRRHlpQUdOekdlOW5sbTFo?=
 =?utf-8?B?SWpZVUNERkNpcGNMeUJBMldDb0dqL3Q4SlJMZWVOVzJWMEUybldsN3ZUUmdp?=
 =?utf-8?B?bHJ2NzFhNjJ1Z1o2SWM4U1VPc1VGYjZYZ2JhVEFJV2x3NC9UcEdMVTNrbmNt?=
 =?utf-8?B?RzI3dnJFWVgyRlBJYXBSODZQVmRHVVdSNE02bzI3eXhsS3FwMGU2YmtQeGRI?=
 =?utf-8?B?aGdjd1dDc0hnd3Vnc2c3QXEzeW9vcWlaalNYamxONng1ZFYxeCtVWnJVQTdy?=
 =?utf-8?B?dGMwdkZKUDgzaWZBRG5DR2N6Vy9HNVJzaW81LzhWRzMzSVNRMzRKakEwL1oy?=
 =?utf-8?B?U3RCVkxob0M2Y2NzZ0dpQlV2UlNOM3JJc0FnTzN5RG5jZnlzbzgwMit4M0pK?=
 =?utf-8?B?eitiVzQ0RjFyKzRqR3hkSGd4VjJXWGN1MERuQzVKbld1ZzhVME9md2YwcWt0?=
 =?utf-8?B?SjRGTFg5cHBNUzNXZW5nWW1RQytjVnB3RjlaZ2hIb1Q5dVRYS0Q2YXlVdmYx?=
 =?utf-8?B?TUJ6ZmlWMTZlb3JUMGhCaWVHL2pVZ1RzZDVDVWhhalVDSUV2YmZaTFNPbWNm?=
 =?utf-8?B?UzVmeVBzN2JGTXR4K0JINHFPVzRvK0wxcnFpeUMxSkZhaDdXa2Rud2RuYTdP?=
 =?utf-8?B?ZUxzWDI1WldVbDk0UzVPOTNmWjB4VEpKdFJTQ24yZ1Q0NUxNdXVYNmNFMDZJ?=
 =?utf-8?B?ZitJZWFtV3MreGkwWVdYK3NEZ0hwc1NNYzlGM3NTamJWVlpoQitYeGhMYjh4?=
 =?utf-8?B?Ui9sV2F6VjcvcUE0bVErcWJkNHhlZ3pDTkJjZERwUnhkL2xiT2V5MkNwcWxW?=
 =?utf-8?B?blhTcHlkZUlldGpJdnpkZS94d1ZBY2xpQTVJYUFLRkEyTFdyMDg1a2FCS0tN?=
 =?utf-8?B?NEhuYm9tcGIvMXRSMjJrK0pleXNXMG5vcTlBbVdVeGFJTDYvZGY1MnF3LzIy?=
 =?utf-8?B?Y21ZSTlhM2lOa3doc2tBWnUyeklUcWdocXhObUZBWFdtYkN5QTdKRTVhWEt4?=
 =?utf-8?B?VEQ3STNyNHlHZ3hLRHBzVE1nUkVqSUNlR2xaM1ozdDRxRTQzR2lrS2dkRGhG?=
 =?utf-8?B?cjlKU2FJbjRkYVBqQUpuTzJlNTQwcys4ZzdpblNtNlNRQ3hTdUk0SDBBRnYx?=
 =?utf-8?B?bmFvbzJQb1JVaXBJUGRvYTB5RU9ZNTE1RjdTV1NYcnVuYmhNdFRMNGhJSjVC?=
 =?utf-8?B?UjJ3WGRDempmYXVRNXBuUmYxZS94UFVvelVNTjY3djNKNUdZYkpTY3ZwNEYr?=
 =?utf-8?B?UXZMc1lEZUxGeVhob3BpYm03QUw3V2dBbUhGYlY4dWQ1Y2tSVFN4bmxPTDc5?=
 =?utf-8?B?ZkdXVjZjTjhXQW1NdUJnZEVVZUpMT3hac2dHbW4zdEZKdlJVS21FYjRueExR?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2799595-f67a-4e45-4b59-08dcfd266a64
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 23:14:21.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9n5rh1Ii1daCLROmlJn0JMi0j2aAmHVUVnDV0BcUs2Ue2UP8H55+7VfU6eDg3GnIl6JXIOHmswi6z1ova7Pa4C7PX6LGLjzcRkCCsogYtUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8840
X-OriginatorOrg: intel.com



On 11/4/24 2:28 PM, Shuah Khan wrote:
> On 11/4/24 15:16, Reinette Chatre wrote:
>> Hi Shuah,
>>
>> On 10/24/24 3:36 PM, Shuah Khan wrote:
>>> On 10/24/24 15:18, Reinette Chatre wrote:
>>>
>>> Is this patch series ready to be applied?
>>>
>>
>> It is now ready after receiving anticipated tags. Could you please consider it for inclusion?
>>
> 
> yes. I will apply the series for the next release.
> 

Thank you very much Shuah.

Reinette


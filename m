Return-Path: <linux-kselftest+bounces-9994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5877F8C202E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2A01C20F83
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D8315FA94;
	Fri, 10 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5yMeiOT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A54115FA87;
	Fri, 10 May 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331827; cv=fail; b=tWayM0gf4/Am/36gtPXTd3iyzToNumslwPQ157R0j07NJcnNueasMkg2TkbJcRHdYSB5R2KFPm/gLFnPDsm8RqQnqqW2uTe55NRJa4yMacHkg+XdZ90IexacUoc5VL1ZSYE1aprXHRz8+Kr3bdzB1N8r5ARYHu+N9/ydPx4UWks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331827; c=relaxed/simple;
	bh=zWsp29DFVC148FyJxRGCD2zORk8hUl2UjuZcKHcN+nw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Om17t48N86dkdbB7giCZVqi5EZmdvaNJA3JPce7uYk356JyjQx9JpJTGKw7EdD8451DVKxBXWlNZZwetkHixgKvYF7DcteHRtJTsONcw+kEP5LK0a0L7wHKongaEnWf64HPpbAsIzjiEARBbyfBTHZ+6msreHgAUOxGF52J63YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5yMeiOT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715331826; x=1746867826;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zWsp29DFVC148FyJxRGCD2zORk8hUl2UjuZcKHcN+nw=;
  b=A5yMeiOTy3RPCnSKC3M8xfHwghCdQpZtn3wak2LHo59Vhm6Yc10AEIKL
   38FyyWk8yFWyKirC/BCgFKWj33S8tnDc78lw/ntIMOAnww0yz4fEzqhfh
   cELPCOgRN/guZ8MgarwLzf9LsPJhS+nWj9Fim4Ne06zcda9f5O9Crmrj1
   9ZsH9HKfhTrzTdjc88DE44YUinPfFvsLnjkuHMCQ5vmq7tnDrWPO56ypr
   I3Ng/Rz5KJMBDj5aPknsuZnjX+6K4nUcA0ktK9zio8u5DRXvcaMMGHaFR
   5KR3ibSbiNDLQC1VoCrWINcTlwsxUau4rVkm48CqDd10sHJ+b7kNhMaQ6
   w==;
X-CSE-ConnectionGUID: Iw6KbDVdQC+rUZOswbkt+w==
X-CSE-MsgGUID: 5isFrOs9Rdi/My2gZKGXhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11139380"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11139380"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 02:03:45 -0700
X-CSE-ConnectionGUID: 6fnKlzJUSeq+mfzvb6aW+g==
X-CSE-MsgGUID: O9YKKTeTT12kx8nbJp7o/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="67015577"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 02:03:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 02:03:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 02:03:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 02:03:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nfph186v4JGmtb05mPJNuu2Il1OliX9048VysKRCb/TUBNY1vEoatHVxnbBKXam3YHdFA4B+Kpa+/ATUOqeGMixvisdfDDCB2Cnl+uVosCkq18Tfb41mn4CVtPSG5I2bFLfrb90KSHeQ2vr2kVkLL0ut3O9wpQwzS+zacbPH/Q6kJYtki6h1wVcmuouJ71aTNbASGyL4DVO9EgRAauYz5l0PYbOpGhRoJ/wefYfPpa2fQXh1+bwRme2cB6ox1enx0ufL8ifcuIyM4onJMfW2bx/orW09g6L7fsCaM/mcOnIGcgp8m3jXiRg71yAZfzxvMwsUGRNf5HnF+ZxBb8pAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmAJ2COWofY2u0cvbYFjytCJ2ZIEvekotvoa6PxPe2I=;
 b=gYxwudpB6TzNAgaM6+i/r1CIVu/PlinHfJKNQuGTE1sAsBXHPUXwXgG3kcJUWpMxsGl0wTsJ7OU0UwGikFc0RG2uJTp/ZamH6rhBlF4llYfgvqWLa6vvF5jmHRiSq8ZMCPHr4v6G3MVOjn05QoP0tQllOTnQEP6XkeayB7qWDca9MCWM1nJr4cx4VMdbcQVQrYPefY4IywqVvJ8FPzN57r+1ZgGegs4/Js78uHj7KlZR8ZHkvyj4LxZxs/2vFkhJYeQx79WJkdxOQUgwBWPkJjjRL4oBzayIs1upk/gv+H0i1fONUfofPkH8ipejbFAu++fXEhImE/+dY/iLC8CCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:03:41 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::12da:5f9b:1b90:d23c]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::12da:5f9b:1b90:d23c%5]) with mapi id 15.20.7544.049; Fri, 10 May 2024
 09:03:41 +0000
Message-ID: <0867c527-6fe5-4f54-adcc-0344e9416f9b@intel.com>
Date: Fri, 10 May 2024 17:03:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] KVM: x86: Kill cur_tsc_{nsec,offset,write}
 fields
To: David Woodhouse <dwmw2@infradead.org>, <kvm@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>, Shuah Khan
	<shuah@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Oliver
 Upton" <oliver.upton@linux.dev>, Marcelo Tosatti <mtosatti@redhat.com>,
	<jalliste@amazon.co.uk>, <sveith@amazon.de>, <zide.chen@intel.com>, "Dongli
 Zhang" <dongli.zhang@oracle.com>
References: <20240427111929.9600-1-dwmw2@infradead.org>
 <20240427111929.9600-14-dwmw2@infradead.org>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <20240427111929.9600-14-dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:3:17::15) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|SA3PR11MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: aa05751d-8d43-4a6c-63c1-08dc70d01664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkNrWlpMb2RwTms5NEdKaG54d0ZYWE5EU1AvaWlYSzlwNVJ4cWpzNC8xOVFG?=
 =?utf-8?B?M1VrZ3Y3ejlING9vbW9zMmxZUzBmNjlETGtCN2FXVS9YbHdXR0ExMWtVTmdp?=
 =?utf-8?B?UVViZ2pReU0vcW9pdUJVdUdsSFJZV25yZUJFT09RNEptbXFIRTJYK2xENkk5?=
 =?utf-8?B?OFU4U1VPVUVPRnMzUlRSampjMGtXdHBrUGZKKzRnSnM1a3hsSUh1Q29BRlc4?=
 =?utf-8?B?RTFSdVovVExlWGtWbEJqWDJZNFRVK2hQaU5ycXFqTjM0Sm5UUmk0eFkyK1pW?=
 =?utf-8?B?Q0RHVVU1TGJUbFhMbm5VUjhtem5zMnBzOGdtdDY0WFpiM1l6SFhtWHVSSzVW?=
 =?utf-8?B?TklHZ1hpSGx2WGxrdVN3QmdxTUFReldodkQzRVlKd2tnZ2dtSTk5L1ExeG1E?=
 =?utf-8?B?NWRscURsZ1NCWjdyQVJQU3JGVWN4UkRueXRMMkVpOVFQczAyQ01jMWFEQ3Yv?=
 =?utf-8?B?SHo4cFBaRmZiLzdzL044QTlKc1dKb0JMUk10NTA2aHcyL3dGNEdvbGhDc2g4?=
 =?utf-8?B?NFBBOU40ZElGeXFWM3dEb0s5UFhBeG5uV2ZnMlFpZlNxTDkyM1ZCSGdJWDQ2?=
 =?utf-8?B?aVJuL21ORUZXSU83WUwxZENjWCtFL1U0T1JhNzAzOGNBeWVNb0ZIWHQyUFR3?=
 =?utf-8?B?NXlrSmsvTmhETk5PV2FyRm1XRTBucFJOTkhEOWQ5ZC9keEREcU5EaTgwUUFz?=
 =?utf-8?B?d1Y5Smh5ZTVQMWRsMXNZYlBvOWh2OG1BLzVkaFB6aVpTMU9DQ09TSVh0Q2xv?=
 =?utf-8?B?eVZabmpMNE04TkJ0SXByL0ovTGRIb2F6bE55dUJNbWpGcEIveUhpbDI0QjNZ?=
 =?utf-8?B?d0xOZ05LZjB1bWZkYnJFazFKMk9iMGxFSmtFR2llZndzYjNHRmRZQTJvOWFI?=
 =?utf-8?B?UURCWGYvUXJ6Zzh0VkFNN2NxdXpreG1YbFJPSXVkdVNEQnJqVzlyRlVBQ1Vq?=
 =?utf-8?B?MHRVd0R0SWN6eFVla0FEL2xaODUvelBZRFhiK3doeUpRenhzb1JaVFQvVStv?=
 =?utf-8?B?YnBZSEFsYTVtZGFnQjBRcUY3L2xiWU5IbkxjbkxRK3BDbUhiK1puRVo4Y3Y3?=
 =?utf-8?B?L3FwL0VwM3J4NjZUNS85aWU3K21qR3FTcmdSMmlHWkxyL2VqVVFEWlRzbUE3?=
 =?utf-8?B?aVErR3lwU1V6a1hCTURmT3BwWjNIclpkM0lHTzUyaFZ4VkFpRHlzTHBwV0pD?=
 =?utf-8?B?TFZ5SjAyS3F0cGg4WUhNaDhDSGRQZTFrenZFb2pJbUF0Y1kwVnpYVHkxS2xh?=
 =?utf-8?B?TlFleWtJMjNMZ1R1N1ZmbzBYVS9BWVAydUd5dVJ2OUlzaWNRY21RTlU5Y3A4?=
 =?utf-8?B?bTRiUzl6Q2lFd29rT0xRZ0ZmRUJSSU1mVGZ2aEZhMmdxenZsQUtqdnI4Z2c1?=
 =?utf-8?B?WW5WSUF2d1dhMzVKNEk1dU9XN3R0YWIvNU9uaTZzWWpnTUVJbmR0Y25aUEY1?=
 =?utf-8?B?bU1qby93VzlsRndyeDNqZ1dWdkE4WEZuYjRKS1h6QWNwUDNpWVRaY1A3TXlQ?=
 =?utf-8?B?N01vM21LdjdsbWJVUllKWWxZc3R3TGx0RkxTZmhiZi9aYVd2WFo4NVVHbzdK?=
 =?utf-8?B?WU1SaFFTYlQ2QkoxQVpKc04zSC9mN21abzVoYzZEeGtLbVEvNzF3cXhRVVFm?=
 =?utf-8?B?bDFUb2VnQXB1RlRndG5CWHBBWDhkR3dpNy9LUFBhR0lGTU9Wd1NhTTlXTDJn?=
 =?utf-8?B?TVBnejMrUXA4MGdHWi9ZQXFNZ0pCVHpJWDBNcGNxeXVaQVZwaks4UU9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJZbXkzYzNuRDZBVnJGaWNYRG5YcjhDQ0Z2UU9uUjR5bFdSMDVYR1lyVkx4?=
 =?utf-8?B?OXlNdzFDODNhaHhFQVFVang0ODFmS2hPbFhaSEU0ZjNVUHpCMWxPZ1l2N3JF?=
 =?utf-8?B?NFk3VGIyOFZHN2hiZFA2cHdaWkJnenFTLzRCU1JONm55NkpXaU5XTGpKVE1z?=
 =?utf-8?B?RjgrYlN1QjREakhmOUQzK3M3cWJsNTBzamlrZm1MRTVOb0NDN2c0TEdrVkpM?=
 =?utf-8?B?STVBWklySTI1VTAxbkpCY0FBZXZsYVFwUmIzTnprVzVLbnAvZTdnZ2hGTlFa?=
 =?utf-8?B?KzZJRndMVjJldDkxTVhYMGZVNkhTSG5kT2w3VjJkZ3RnRlB2bmpvZG54QjU5?=
 =?utf-8?B?TlJXMEpjVURHc2ttOWNBejM5RTBwNjR2ZSsrWVVHLzhlQms1Ymt2OTQxMllL?=
 =?utf-8?B?MGFOaUxJdzFTUVpWWlMya0EwK2dvSXNvSEVIamY0WUhBVWVtemVaTXRXSkZR?=
 =?utf-8?B?SlBrbm9hZnpYeWFsK3lrbWcrQXJnZUVmcXVPYXplV241SU0yd2JXQWxRT0JC?=
 =?utf-8?B?dmV2RjFhN0pDNzlTU3MxcktkRy84L2QwMk40WFF6R0lCR1VQUTY0QUxQK2Vr?=
 =?utf-8?B?QzMwNnRTL0VMSldjZWEvajlEQmx5dGM3bTNxMlV5S2xXUUJRNGFsTGQ1aHpv?=
 =?utf-8?B?anBRNU95WG9xR0xXOVBWM1VsRzIxendYMzVZYnhIeHQySkFtYlFFV0dsN2Jp?=
 =?utf-8?B?aVlXZE9hdE5mUUVtMUhkZlhjS2ZNVHpFMGVzSHZFWFR3LzRTNXdjeFJDVGc1?=
 =?utf-8?B?L2N6Ui93akhscXRXTHlpekp4NWpLbEIxODVWVjlDUktvL1ZXd05XazhVMm5v?=
 =?utf-8?B?dVQvNnFDMVh0cWUwc3dDc1BxNkRSYVlWTE4vSWdQZW8zWGJUdkhNNldYMW5u?=
 =?utf-8?B?Rm42MTFUQ1d3bkYrWHF5c1JjZlBpdHpiQVFwL1Vjb2ZRNlJWUldHNmNyWTFk?=
 =?utf-8?B?eXlqLytpcWdlNjEyZXFmaVZkUWVEVVhZWFEzQkVVYU5UdzFmWmV3UVJBbjNi?=
 =?utf-8?B?VTk3ZVZlR1crME9rQ0pNM0ZwZVBDaGw1cHNYRzJIL3JoKzJoVWNkZDhBY3dB?=
 =?utf-8?B?Q3RPcDRzU2FYeDNWL0RNRWhHbm5XaFJ4UzRiNFFRVUcwWEFtRnlKS1V4SHk3?=
 =?utf-8?B?Zi9ublJQRFhkV2FwaFVtVHVFUUJlMmQrdXg3YTVlN2Fqb3RwRjZ1WE4rYzI5?=
 =?utf-8?B?dVpXdGdnRHpYTGlqcnI3a2JjdU00a1FaN28yV0dWeitxck1oY2VlUVhqekhV?=
 =?utf-8?B?UGVwSE9sbldrY0NreVpZNXVnbHppbVRmTWpsSzdSOVVNWHdad0xvZG9JYlB2?=
 =?utf-8?B?UDJPT0ZmWUJMM2FXanUzRU1jcDZqam01WjB6ekdDalVSczJ6Y1AzeXlkR2V5?=
 =?utf-8?B?Mk9YbE5KaHFlRDUyVURtV3RTM0Q4NzN2Y0NFUzZwL1hxK0trQjZuWExCRm1I?=
 =?utf-8?B?cHBoYXRNZHR4Uk1FcXB3RHFzQzFSVnM2V1JkWXRWd0VPQm82dEQwYk8xVmlB?=
 =?utf-8?B?eFEvdGVCYWlIUUFPelFGYS8xT2hSZ2Z6Q2NRM0dtUWlzZ0paTGJVUEVyM1Ar?=
 =?utf-8?B?dGdSRkcyS09GaUw0djROYU5Zd0lhSVh2WVVrbks4cElCOXVoSERseVhsQWRm?=
 =?utf-8?B?aHFUekVGRHFkK1ljNlVoWmlzQ3c4eGxSQlFJR1NIcStJTUJnT3NETUZHWVZw?=
 =?utf-8?B?SXBUTmM0M0gxVklWS3VMTkI5YmRFZ0F3YldlZklGWllWQ3VqSDM2Rmg2S2VU?=
 =?utf-8?B?Q2hoSmFDbklvTXZ0MjJTL1l0Y1Y4U1ZKM044SThneVV5TTBBUXVkZWFUa2FI?=
 =?utf-8?B?bGhhMGczMWJ3TXN3bW96d1RMbmlJd0tzYWsvN1VnK2hwcll0TVJXek9icDlT?=
 =?utf-8?B?cWQ2MEM4RUdlSTZIeGtueWRLV1Jpem5uV3gyUzFjWHNTdVBjQ2JRbGE3Tlhm?=
 =?utf-8?B?T1lHdW1iT0Rhd0Y0dlhmZDBNODlkTVBqQURXMVVhbUFOSnpMaHFIZlp2NDQ1?=
 =?utf-8?B?S0VTZUl5NEloSnBWMjFQY1RIbk9jWVFCVUM3MXRxdWxMeXpoV2l0WVNJZmJ3?=
 =?utf-8?B?MEMyaTl6SUNUTHZNZWQ1MElxVmtKZ2ZZZjhQbG1vOVBVdksrRVJqdFZBQWo4?=
 =?utf-8?B?dGRHb0hkMTE5eEFjQnBaR3NCNDVvdlJNd1F4RUxXRkxkQzVNRWtTRjlCMXRi?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa05751d-8d43-4a6c-63c1-08dc70d01664
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:03:41.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5RlBJjT0YySIZK15/TUEsfExtsIzhjAyVVLWWW3ZrwIaSIdOKzGQw0QLXDPydd0OJ31du/HKIL16kiXoHybBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8047
X-OriginatorOrg: intel.com



On 4/27/2024 7:05 PM, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> These pointlessly duplicate of the last_tsc_{nsec,offset,write} values.
> 
> The only place they were used was where the TSC is stable and a new vCPU
> is being synchronized to the previous setting, in which case the 'last_'
> value is definitely identical.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/include/asm/kvm_host.h | 3 ---
>  arch/x86/kvm/x86.c              | 9 ++-------
>  2 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index b01c1d000fff..7d06f389a607 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1354,9 +1354,6 @@ struct kvm_arch {
>  	u32 last_tsc_khz;
>  	u64 last_tsc_offset;
>  	u64 last_tsc_scaling_ratio;
> -	u64 cur_tsc_nsec;
> -	u64 cur_tsc_write;
> -	u64 cur_tsc_offset;
>  	u64 cur_tsc_generation;
>  	int nr_vcpus_matched_tsc;
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6ec43f39bdb0..92e81bfca25a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2737,9 +2737,6 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
>  		 * These values are tracked in kvm->arch.cur_xxx variables.
>  		 */
>  		kvm->arch.cur_tsc_generation++;
> -		kvm->arch.cur_tsc_nsec = ns;
> -		kvm->arch.cur_tsc_write = tsc;
> -		kvm->arch.cur_tsc_offset = offset;
>  		kvm->arch.nr_vcpus_matched_tsc = 0;
>  	} else if (vcpu->arch.this_tsc_generation != kvm->arch.cur_tsc_generation) {
>  		kvm->arch.nr_vcpus_matched_tsc++;
> @@ -2747,8 +2744,6 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
>  
>  	/* Keep track of which generation this VCPU has synchronized to */
>  	vcpu->arch.this_tsc_generation = kvm->arch.cur_tsc_generation;
> -	vcpu->arch.this_tsc_nsec = kvm->arch.cur_tsc_nsec;
> -	vcpu->arch.this_tsc_write = kvm->arch.cur_tsc_write;

Do we need to track vcpu->arch.this_tsc_nsec/this_tsc_write? At least
they are still used in compute_guest_tsc() to calculate the guest tsc.

>  
>  	kvm_track_tsc_matching(vcpu);
>  }
> @@ -2825,8 +2820,8 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
>  		data = kvm->arch.last_tsc_write;
>  
>  		if (!kvm_check_tsc_unstable()) {
> -			offset = kvm->arch.cur_tsc_offset;
> -			ns = kvm->arch.cur_tsc_nsec;
> +			offset = kvm->arch.last_tsc_offset;
> +			ns = kvm->arch.last_tsc_nsec;
>  		} else {
>  			/*
>  			 * ... unless the TSC is unstable and has to be


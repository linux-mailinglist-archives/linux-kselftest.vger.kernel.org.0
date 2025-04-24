Return-Path: <linux-kselftest+bounces-31485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC97A9A0B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937BB4453AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 05:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5431CDFAC;
	Thu, 24 Apr 2025 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cyf4WJQw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C22701B8;
	Thu, 24 Apr 2025 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474216; cv=fail; b=EYUFE99Z1y3omC26KuhmTodsk/mM4XzxOhtE+xMRmHwytSAG2E8CyaAeQz4zVdlpta3Eq6GoJoW0ULEeoKcQ2q9+TF2DV32to3LyzaS9rulidrfy4nvkZxRNN8IjgjlE6mtsdmrkSbLT+EyG/0rUzzX46egJqs6q+92n7+iCGS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474216; c=relaxed/simple;
	bh=mALJrE/BtP/1fdvPNdWQEozH6ELk+IM1NAqqclaAdW0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tAeEG1NB63TRUfFZ8hT7BtSC9e0S8sIi7loW7pg7uqEJfWlsDOnukvFKuafLicUng5AxjHF10antL/tzGEheu3eHXv17c5OhzWXW4JueV+fp7jYBWzsCGJTnBk7o1hM5uakhUNNwEn9JE44I5+tSoPCWNzUVkXdHbExQ71QoAb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cyf4WJQw; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745474214; x=1777010214;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=mALJrE/BtP/1fdvPNdWQEozH6ELk+IM1NAqqclaAdW0=;
  b=Cyf4WJQwYD2w7h4OypH+1TZvZgcruPma/Yva+vGa60LZDLu2jTZBf7Tw
   jOxsrQmivNDUFLr/ecHpjQM0C3FoKOmzvI0MQLgYL2NgeOZAiCfuXyZQB
   3WmjovbQ76fu8sLaAsdDxSdzFcHUr+jjs1LSHR1efx2sCoUXWm+5EXF2/
   6wKPCePZTX4SefFmP89yahTtFIX+qF4w4zV9Fx4JgE2+E+BeMDzt+X7+S
   GFsM8iGR8NRLvmkC85TUKr3bvwVq7ta5I2IecA0mCWBH4JF/xrGzvQXss
   1F+VUdHAGvlI5qFtkjoBjOBOiuE2kcZd8PmAeabxuASGdqbMywFNxdTDg
   g==;
X-CSE-ConnectionGUID: LTJDlCSiQNSyaxuaDqW68A==
X-CSE-MsgGUID: FSG4EiQ+Q9apUqdO208QjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="58463951"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="58463951"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 22:56:53 -0700
X-CSE-ConnectionGUID: rFOsZyB+TLeqREByfNTEbA==
X-CSE-MsgGUID: AHuBRHkNSxyw2Kh6sa/KJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="169730230"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 22:56:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 22:56:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 22:56:48 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 22:56:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uij7DNLlCCEPM2DnTo9Sf7mHOQhSPwd12et4y4sj9ksZzPD1pQXJbU00iopv9CN1m11yp4YF4TpLiv1sXA2wD72LKVBelyaOd9pZHhcUh9Aqb/x3PP3EzcIEB9ceOpIGjkASJyK5Opba+lweykW2awEaA41t6aRcy2VqWa9NBuOG0VGwDSyw3xQmr23Ip9jgGPiR6EqHBM6k8jKzM727vPJtd14Aa8b/lJy8t40s9Kygbdy4HlsZJ8S5beYPdNzTOxILZ7eW+tSBxLlPMmMkoTUTVa9vM6u7Cx0agMmRFh4il83bmkBaZ8uv2MbT41rUgr9RD5LX0n9N/TzS8rQxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWp/2vDwP9xnRBM2uZTNXTg8K+Y9kKyteYtHcazub/Q=;
 b=nC75xVwhE3wmZDUUTZu0qDGyXfwxJU+NyuFvKYtwP1HQ99SyJlcxOV/tWHEi1pPSlllGfkdCt2BQ9cRqphmM8weWwVn6mNF8wMwL96tIXNx0lFdzyonrSnj4qOmg8/Qxa2XggXqDugw+poHFHua6vw647hpZcVCrsaaQKIC/LwB6CZe7F0fF5v3LrRWAkswcbJ/EgkeQPiZ09lHBYs5q7ghIs92xxkptTE0tRu0NET8/e6MJU1PSqgySBMvbkv3NPvDPQLQr8pZ+Sy3hYKdawCKEWEqDgDEfmxOBPCg6RLBHxp2X2MqvPDBHZdL3ZTQs+t5jrf5PfS0gsTz5a3IVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 PH0PR11MB7445.namprd11.prod.outlook.com (2603:10b6:510:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 05:56:08 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 05:56:08 +0000
Message-ID: <c4dae65f-b5e6-44fa-b5ab-8614f1d47cb5@intel.com>
Date: Thu, 24 Apr 2025 13:55:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically split/reconstruct
 HugeTLB page
To: Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>,
	<tabba@google.com>, <quic_eberman@quicinc.com>, <roypat@amazon.co.uk>,
	<jgg@nvidia.com>, <peterx@redhat.com>, <david@redhat.com>,
	<rientjes@google.com>, <fvdl@google.com>, <jthoughton@google.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <zhiquan1.li@intel.com>,
	<fan.du@intel.com>, <jun.miao@intel.com>, <isaku.yamahata@intel.com>,
	<muchun.song@linux.dev>, <erdemaktas@google.com>, <vannapurve@google.com>,
	<qperret@google.com>, <jhubbard@nvidia.com>, <willy@infradead.org>,
	<shuah@kernel.org>, <brauner@kernel.org>, <bfoster@redhat.com>,
	<kent.overstreet@linux.dev>, <pvorel@suse.cz>, <rppt@kernel.org>,
	<richard.weiyang@gmail.com>, <anup@brainfault.org>, <haibo1.xu@intel.com>,
	<ajones@ventanamicro.com>, <vkuznets@redhat.com>,
	<maciej.wieczor-retman@intel.com>, <pgonda@google.com>,
	<oliver.upton@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1726009989.git.ackerleytng@google.com>
 <38723c5d5e9b530e52f28b9f9f4a6d862ed69bcd.1726009989.git.ackerleytng@google.com>
 <Z+6AGxEvBRFkN5mN@yzhao56-desk.sh.intel.com>
 <diqzh62ezgdh.fsf@ackerleytng-ctop.c.googlers.com>
 <aAmPQssuN9Zba//b@yzhao56-desk.sh.intel.com>
 <aAm9OHGt6Ag7ztqs@yzhao56-desk.sh.intel.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <aAm9OHGt6Ag7ztqs@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|PH0PR11MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: abe839a5-64d4-4cca-3ce7-08dd82f4b4f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkQ3bGNqNlQvbzVKMUo3bmVydjdIaFZnNTd6eW5XTGtCNUoraFRsK1ZWRkk5?=
 =?utf-8?B?ZUtLd3lnZHhKbWxDNTRjdGhOYmpqWmJlRlZ4bXUyMVJnVzN3RWJRZ2U4eWdB?=
 =?utf-8?B?cit6QnI3bldXZGJKMk96aDFOSWhGWmY0ZXd6cFZsdy8veFp3bzNlQ0d6U2xt?=
 =?utf-8?B?RzNLdm5MSXBPVnNQRitkcytoMlJoQXVOK1lRdFBhS1pwTVVxOTBHTTAyRHln?=
 =?utf-8?B?Z2VUU2VuNG15MCtVaTJaY2VTVHBSU21lQlNLRENrdFdUMjJ0SUxLRXdoajBx?=
 =?utf-8?B?Wld2QUJMRVpMOVBvS09jQ1FyVkI5TTlNL1Q0UTBjaU5RUzFYQ1Bsa3FWQUtJ?=
 =?utf-8?B?a0dxZUJLQkJCc0ZWMlNsQzZ1Q3JzbGhzZHNNcVdvNjBMR0hKVHBUQTlFUEM5?=
 =?utf-8?B?eVNFcFNsMVB3WkJieHZpRGszYnRBVW5nTlpleUhqcWpwaVlWV3VFSkwvQ2Jj?=
 =?utf-8?B?QWoydUs0dGJVeXZOa3dxcU1vNWcxS0wxRGVNVXJrWGxZWnB3eXZxMDVMcm1V?=
 =?utf-8?B?V3M1YW0zelNZY3I1bnFxRlp3b1Z4MGtSaDkzTE44cjloOEtWTE1TU1hBdVZx?=
 =?utf-8?B?MjFTRWJ2S1c0NEV6ZzY2a0VBS2Z3Z1ExZk5RRVlZWndDbkRDK0F6OEUyM04z?=
 =?utf-8?B?TkloaG9vd21jYW1UTTF6TUYwS2F3dm1kTkJIVDd5bkRzZ2VDbDljcGVNNGkz?=
 =?utf-8?B?UUY2WlZLU1hGckhWVStIREVFWkdvbHlpN1dJMEpzRWwzUndncnZEV3NlV1VE?=
 =?utf-8?B?QVNqa0RucTJsb215dDB6cGYyL3VJbXd3dWtvVk01b0c1L1Focm9jTjN1TkFJ?=
 =?utf-8?B?SVdaUCtITmFpanVrSGJXcVFtazZmMnNjNnFzdXRwQmpDUzVSSTBKWC9nelRY?=
 =?utf-8?B?TnhieU1RVnZmSG9RazlNZGk0U3BJWUdPa3AzUWpKT0ZrOWRlWm53aWlBWmto?=
 =?utf-8?B?ajRNZ1MrcXAzTGFSUjZuR0JPL0pmRlp3anBCSkpnN04zblVkRVp3RmViTnhD?=
 =?utf-8?B?QWtJMjM2dEg2TmdlNS9yWVdpazhmNXpwVkNMU3MvZXI4T2JLNFdTMjZDMk5P?=
 =?utf-8?B?OUlyb01kSXQyQ09YOG5VblY4eXRiaTBuMTJPa3BkcWR6TmhFak5ERFh0Q00v?=
 =?utf-8?B?ZndFKzhTbDNvaE5GT045ekk4R054RDlERzc4K0FnMW4zWVhEUUp4T3hRbkNE?=
 =?utf-8?B?emsxSHNyT1RSZGVyWEtCUHN4SjFkcXN5MVh1Q3lGSjZnQUNNTCtCRmp4NjI3?=
 =?utf-8?B?VWlQTEl3TUVrMWFBRXB0R2V6NnZuRHYzUzQxcTkvcnZPZXAyMVZFNG5FRW5j?=
 =?utf-8?B?MEptd0xIaHJKdFh0WHNvUTVMeWt2RGdWQ1NZMzlRSHNWYURpVklRbWdvRVlY?=
 =?utf-8?B?WGUrRjZ6T2RKUGJsNHpmSjBLMW9NalpnOUVvTG9hSlpoUVNHVXo2SEc0eXRp?=
 =?utf-8?B?RVA5WTU1U25HME9qMDJjeWQzTVV6K0JCMEhWRWlwaE5teWIrbnVDOUtDb3Ja?=
 =?utf-8?B?L3FkanU1a0RrUWZNL3p0UFpqcDJYRitBMDZCU3Z4dDNEZDU2dTZsS0VWS2Y5?=
 =?utf-8?B?OGtCcytpU2FxV2lYa3h6M3ZkRWJOYWdrdkRUNVh2TWlKTVBBbDB6SGg2QXcr?=
 =?utf-8?B?d0k0anBVVEVNRVZLZXBjaUY0UFBRNGJlQ2NQc2VaVVkwMjRkWnZVdUlRNzlO?=
 =?utf-8?B?VVd5MGVpUlVGN3hWVEt0QWd2MnlZeUkvdlcxL0dKWVAvNWlsVzBGQjFqeXVN?=
 =?utf-8?B?M2NaaW42d2RjNEhDVjN2OW14QU5KWVd6ZlpRYWlKNGJzWWc3aXBQd2lZQndP?=
 =?utf-8?B?NXY5YzNvcUZwTnR4aCtjZUpUcWgxS3YweGNIM3B1STlpbVFyUDJ4OW5na1Rq?=
 =?utf-8?B?RjIwbm0wREJNNndiSFVSYWdTMFBDMHFNY3MyK3RINmNxa21tWC91emJTbU5D?=
 =?utf-8?B?UEZyL09pazVLYjNpK1lDdWhQNnNPT3JNNnMzcHpZalZCaFVKeHhwRS8xaTBT?=
 =?utf-8?B?MmNRWjZKb2J3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1RjMlN2N0U5cndkUVpGbnRZanpiUUhEYmdrbitDVVNKZGRsT1NXK2k5ejJO?=
 =?utf-8?B?U0I4eUR5QlAxckNCc2djSUwyQTVYV0RsME9DbXlaR3YrODBHcytRZ0JsUnpY?=
 =?utf-8?B?RkMxOG54VXFrYUV0Yi9Fcjh1V2JLb3d4NnIydTZodURQWm1MM3ZPcEsrK3Ra?=
 =?utf-8?B?UUdvZlNTMW9nbmpVbHNZSmFhMFNHbHkzYkVkbTdmTHZCOVFoMjNZVHk0Q0xq?=
 =?utf-8?B?QUoyR2VsaDcxVDY3Ym0vMkMvWTNhbFVhOWs1eHl0WjNCN2x4NjlyRCtRTkFI?=
 =?utf-8?B?V0tsdThaRGN1eHdrOFhEOHBaSjkrWVF6TGJJNURHeGZzeHUzK29kZVU2Ym0r?=
 =?utf-8?B?WVNsdzdOZmlzVTVnYnRPWTI3TG4wY2tuYm5sTVFxS3hmMVpVRDlEN0VZbXFz?=
 =?utf-8?B?Z3Y3cjZkYm9TZk0xWG9GNVE4Y09Uc1BoRktUU0U1T0dlRVpTdHlGNzlEN2R4?=
 =?utf-8?B?NlZ0ejhMNG5RQU9RTzA4WTRUYkNFTDF2aytSOHhiQS9KNmgxRVZMUVZlNHh5?=
 =?utf-8?B?V2doaitFbWRxUjVPUXBUWGxvWGp4c09sWFRtU3c1dnU2YlFsUkJSUVEwUS92?=
 =?utf-8?B?amM2bGtzMU9BbUhCdnhGbW1teFFweEgwcHFmcjdqNUtZNWZSVmZYTTl4clVm?=
 =?utf-8?B?VE0zYXA2Q3M2dThYMUxpUmU1TlBCVGZZODlKeGpoZkxoMm5tTmpRV2h1cDI2?=
 =?utf-8?B?WERGVWwwR2VNcndrb3B5NnQ4SXdlUk1VWk5vUTV4WGNNRFN4Y3A2eEZwWHF2?=
 =?utf-8?B?VFIraXJFSkNhekE0NzB6TnRFN09pYWJzR3NIZnpKZHV0Y1lWek1SblRxQU1q?=
 =?utf-8?B?UkJ2dnRpQXlhUkVmUVZGS2VUaTYwQU9KVjVXNXRRZXovd091Sko5OUdpOEdP?=
 =?utf-8?B?eXRDK2dOYTJyeWk5N1AxU1VBcW1UNnMzaE01dUVVMzNnMDBXZXZMckhERElv?=
 =?utf-8?B?MFFsQzdST3NBYVNuSmtHN1FERkQ0bnJuN3NMalNUWm8wYmJvczFyL1J4T0RB?=
 =?utf-8?B?U3FIT0RJN2FqUkFxSjRQelFDVHkvUTJ0OTd3VWlBblZCL1RSQ0pMSUlMMTFC?=
 =?utf-8?B?SWRaRFd3ZnBDK1dORXhiMTBXUDhIVUVzOStTK1o3U3g0TVU3UW5jZnRjVnhT?=
 =?utf-8?B?UkVOVFlWL3Z5czJlenZOK0VRdGIxOFVFVDJzMGRvTklBcW9LbjR2S3pZa3No?=
 =?utf-8?B?TUlmVnVTYkhzeGxYWXk2K09VWnFmQ24zUVdLT1FCaDgrZUxpNlYxV3lMS3pS?=
 =?utf-8?B?R0JQT0VlQXc3TE54cjdLQi9yakpSU0RjTkVhNE9MeEdLckFaNjNvWHBLL3VS?=
 =?utf-8?B?alh1Tm0rWUoxR3JQRUlXV095WC83NGtOVHNsWUg0TTlZL0xVSzEvS1loN0xr?=
 =?utf-8?B?WTlwbC9OcVhTd0YwWmVuQW1nTTRjVFQ0Sk13VC9kK09ZNG5QRVhxVzNWRnFk?=
 =?utf-8?B?WGdxZ3kyc1Q1TmdDNm5jOTV5VVNMWDc5b3lNM1I0TFh1OFhXdTUxcHNSeFR6?=
 =?utf-8?B?Tlh2MmtTREdCbU5KZWJTaFdQQ0N4NTZMZ0pwM1NwVnZlSzB3SU96QkhObEVT?=
 =?utf-8?B?V0J5a0dsTkZjeVJ3QXIrTVdieHdhNVY0VlQybENoNlZFZkE5cXU1ekVRWWFa?=
 =?utf-8?B?Nit1M0NIcG5jZlZRZDFoYVlCemZPL21JOWlJRXBzbHEySERGM09GWDFWSkk4?=
 =?utf-8?B?RjN5M1FpN0VTMVJKSTNHTXZ1cnhoKy9uMm5GcmlNREtiWkVxbFJrN1BONEY5?=
 =?utf-8?B?TDZZQTQ5c2JSV0NvYkxiM0ZtaUhnbU12aVgvU21oRUp1Z0xBTmM0dGsxY2N1?=
 =?utf-8?B?VEQxSGNUdm5yNUJtZUpEZmpLSDZiVkFlTzk2M1FGZFJuR1JsOXdJWGpWdUZV?=
 =?utf-8?B?WEt4aW5vZG1lV1Rjc0YxZitMQ0YyMjJPL1NIa3dvcEVyUVZlYlBwQWRiek1s?=
 =?utf-8?B?d2JnRUNkZXV2SEFuS0p4N2ZjNUV3eTJpSDRIVytUTmJIMXlPQUtpV3pDUytG?=
 =?utf-8?B?a2JaMTNEcmlwT1dETlFPWkI4S1FYNG1xNys3MFVtTEVNMHNnR1NxbXY0N0xp?=
 =?utf-8?B?aDUxSU95WW90ZkVmQ0JZZ09OejBMZzFidVp4L25ESkVYMi9pNjdyY1UwZDJw?=
 =?utf-8?B?V3lGWjA2NDd1QlZWNTRlc0NmTVowRXFBMkJDVzlJaTZpSEdURzhTeGdwUFl5?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abe839a5-64d4-4cca-3ce7-08dd82f4b4f1
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 05:56:07.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpecgSjv6BWeQvFPLluA4qJ9eDgF1h22PPrCTnrVUB/vQzjry1kq0jeTLfBBbYriVivyjaiby7RsT05I23FBjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7445
X-OriginatorOrg: intel.com



On 4/24/2025 12:25 PM, Yan Zhao wrote:
> On Thu, Apr 24, 2025 at 09:09:22AM +0800, Yan Zhao wrote:
>> On Wed, Apr 23, 2025 at 03:02:02PM -0700, Ackerley Tng wrote:
>>> Yan Zhao <yan.y.zhao@intel.com> writes:
>>>
>>>> On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrote:
>>>>> +/*
>>>>> + * Allocates and then caches a folio in the filemap. Returns a folio with
>>>>> + * refcount of 2: 1 after allocation, and 1 taken by the filemap.
>>>>> + */
>>>>> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
>>>>> +							    pgoff_t index)
>>>>> +{
>>>>> +	struct kvm_gmem_hugetlb *hgmem;
>>>>> +	pgoff_t aligned_index;
>>>>> +	struct folio *folio;
>>>>> +	int nr_pages;
>>>>> +	int ret;
>>>>> +
>>>>> +	hgmem = kvm_gmem_hgmem(inode);
>>>>> +	folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
>>>>> +	if (IS_ERR(folio))
>>>>> +		return folio;
>>>>> +
>>>>> +	nr_pages = 1UL << huge_page_order(hgmem->h);
>>>>> +	aligned_index = round_down(index, nr_pages);
>>>> Maybe a gap here.
>>>>
>>>> When a guest_memfd is bound to a slot where slot->base_gfn is not aligned to
>>>> 2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G aligned, the
>>>> corresponding GFN is not 2M/1G aligned.
>>>
>>> Thanks for looking into this.
>>>
>>> In 1G page support for guest_memfd, the offset and size are always
>>> hugepage aligned to the hugepage size requested at guest_memfd creation
>>> time, and it is true that when binding to a memslot, slot->base_gfn and
>>> slot->npages may not be hugepage aligned.
>>>
>>>>
>>>> However, TDX requires that private huge pages be 2M aligned in GFN.
>>>>
>>>
>>> IIUC other factors also contribute to determining the mapping level in
>>> the guest page tables, like lpage_info and .private_max_mapping_level()
>>> in kvm_x86_ops.
>>>
>>> If slot->base_gfn and slot->npages are not hugepage aligned, lpage_info
>>> will track that and not allow faulting into guest page tables at higher
>>> granularity.
>>  
>> lpage_info only checks the alignments of slot->base_gfn and
>> slot->base_gfn + npages. e.g.,
>>
>> if slot->base_gfn is 8K, npages is 8M, then for this slot,
>> lpage_info[2M][0].disallow_lpage = 1, which is for GFN [4K, 2M+8K);
>> lpage_info[2M][1].disallow_lpage = 0, which is for GFN [2M+8K, 4M+8K);
>> lpage_info[2M][2].disallow_lpage = 0, which is for GFN [4M+8K, 6M+8K);
>> lpage_info[2M][3].disallow_lpage = 1, which is for GFN [6M+8K, 8M+8K);

Should it be?
lpage_info[2M][0].disallow_lpage = 1, which is for GFN [8K, 2M);
lpage_info[2M][1].disallow_lpage = 0, which is for GFN [2M, 4M);
lpage_info[2M][2].disallow_lpage = 0, which is for GFN [4M, 6M);
lpage_info[2M][3].disallow_lpage = 0, which is for GFN [6M, 8M);
lpage_info[2M][4].disallow_lpage = 1, which is for GFN [8M, 8M+8K);

>>
>>   ---------------------------------------------------------
>>   |          |  |          |  |          |  |          |  |
>>   8K        2M 2M+8K      4M  4M+8K     6M  6M+8K     8M  8M+8K
>>
>> For GFN 6M and GFN 6M+4K, as they both belong to lpage_info[2M][2], huge
>> page is allowed. Also, they have the same aligned_index 2 in guest_memfd.
>> So, guest_memfd allocates the same huge folio of 2M order for them.
> Sorry, sent too fast this morning. The example is not right. The correct
> one is:
> 
> For GFN 4M and GFN 4M+16K, lpage_info indicates that 2M is allowed. So,
> KVM will create a 2M mapping for them.
> 
> However, in guest_memfd, GFN 4M and GFN 4M+16K do not correspond to the
> same 2M folio and physical addresses may not be contiguous.
> 
> 
>> However, for TDX, GFN 6M and GFN 6M+4K should not belong to the same folio.
>> It's also weird for a 2M mapping in KVM to stride across 2 huge folios.
>>
>>> Hence I think it is okay to leave it to KVM to fault pages into the
>>> guest correctly. For guest_memfd will just maintain the invariant that
>>> offset and size are hugepage aligned, but not require that
>>> slot->base_gfn and slot->npages are hugepage aligned. This behavior will
>>> be consistent with other backing memory for guests like regular shmem or
>>> HugeTLB.
>>>
>>>>> +	ret = kvm_gmem_hugetlb_filemap_add_folio(inode->i_mapping, folio,
>>>>> +						 aligned_index,
>>>>> +						 htlb_alloc_mask(hgmem->h));
>>>>> +	WARN_ON(ret);
>>>>> +
>>>>>  	spin_lock(&inode->i_lock);
>>>>>  	inode->i_blocks += blocks_per_huge_page(hgmem->h);
>>>>>  	spin_unlock(&inode->i_lock);
>>>>>  
>>>>> -	return page_folio(requested_page);
>>>>> +	return folio;
>>>>> +}
> 



Return-Path: <linux-kselftest+bounces-38906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBB0B25229
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 19:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3A114E541C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC528B51E;
	Wed, 13 Aug 2025 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsaBw8BT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86E223D7F7;
	Wed, 13 Aug 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106246; cv=fail; b=buT86qQspLKJjitcN0NUUf+dp81NOtceS46oQb/KSsZ3hBxCKhdnRzHVLqouJVGacu+zzFCK0LnIxwA131SY8NJBir9G/7r/ONnOHmyw4WKXKtmEwNjvtsv8xiuyMBn9l5kZ6sV+5ZRr/YXhIRPaXmx2p7UsTDuVh16Pu9m8Hiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106246; c=relaxed/simple;
	bh=sIZPt+Ug2YzgMXLRYwZ+2oU2ZZu9mDQ+VHZ/5SiXjdw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m6udhu8qwervvlxPlwx9ZEOs7jCyAeFuQjHnG3vDi9MMikdFGi/O11h0zyB1Hh0N5v0YsSFSEffuHVwfQ7EdNPLrlSQmo0LbLVTHV/CblVBwZWLK+20KXw+Bf1WbQDyUuroel/6K6ltMSNmKrdsUiIPzTUztz5+hYre5xr0CQas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsaBw8BT; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755106245; x=1786642245;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sIZPt+Ug2YzgMXLRYwZ+2oU2ZZu9mDQ+VHZ/5SiXjdw=;
  b=CsaBw8BThTUpfM3wtfinwgmt4C/MmRzKTG0kFLVwX7yLyvYg8c91OWil
   Fc0PN9RmzRzXlAPtDXPqidw/PsP9k5wRGI15iPPW7lkyREBLC0oiMAaSP
   wI5U/8gZz7I3JrcruSIR5TjLbmnn+HfjeXJfft1xbzlteOKo3qq6iM2uO
   pHa1TjImJsOwEfD+BBAaYUMpQXqpAoxPDJ8Hx0Hw/29uQS8O/FMwSa6kt
   3/erH6gxhs28FoBPEYCSO0Zj9IvmJOZeuJeC/8qeBpZHDtDMWvjrWLEfu
   mnbi1qDFVCWkh6dM7scgQ8fh/IgWOdMwmzSAjptToVSPcOb4L7jy5SpD5
   Q==;
X-CSE-ConnectionGUID: 7nhBQHDrSe+NE3JYlyNE7g==
X-CSE-MsgGUID: JBT/QBz5TvqI9CatqVjn+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57476361"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57476361"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:30:36 -0700
X-CSE-ConnectionGUID: cru/gbOESi+zZkEblcnsGw==
X-CSE-MsgGUID: BgYWLX5qRyeEJ4C9ImXZZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="171858832"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:30:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 10:30:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 10:30:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 10:30:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owRz9jOJoEqT8XeTxHJmYA2OLEl8zUhxgTmlxHFz5ssaK1wBS5NU+4Ehwq7em1jqcoefVveeO8C7DtJfJ2UEttlyNqYrTUJE1jVM1plj0z7i6DBrWE1a+QV92hBGqBJiXiGVc/80AeFuf9vTACuTECR67K9L5/F6WkjR1sNZj/1b14twAUjGaOn64p3wp8WqaZXHh5GH0UgTv/4mSHBTHVp+wlomPBpr3ZvFrC7DA9oyMkI6VQb9Z1jDMbBu5jCmOhvD8mLgKM6gCZDBBW3uLcvQ5hDZKlpvvgL82L7eNvJWpbpYh4Nveoouuw4pe7yw9w8kd6HwxCdY0HvxFSQ6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TJIer+Zfm35X3aM9Tben9pZjO22/hFQVCHgf7P93l0=;
 b=R9HNc2cq2A5dReQjHL7o+wQrTxxj0oJ/S0RzZlKlNgzXVOzQUo2KcRGRQZG1/lqC8DRsVbIdkLrcoZdcQRcaHPzeaTc/FMVKa9px0k22u1jvFnmilxvFny4/Uloi1VNaAinH8hOd42AqBHvJZqdnF5Bfv+C30JNJDeo12WP6Cq1+1Aq/e8XdsncH1xweoDwa3WpYaYafBz51JekFUJTwuEAilhFtWTlqi69XxF2JJ2C67cMvtXXj0gxRz36XBLoJBabPIkdSzvilKYYpvnLpGkS1KgVID3hwQtVbvmin/8FWp1bNlxq3Jkn3EPcSlzZFsn7zSz2ui33zaD0umCHC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 13 Aug
 2025 17:30:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 17:30:32 +0000
Message-ID: <31c4039c-b131-4051-9621-e3e8f8e5ecf2@intel.com>
Date: Wed, 13 Aug 2025 10:30:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 28/30] KVM: selftests: TDX: Add TDX UPM selftest
To: Ira Weiny <ira.weiny@intel.com>, Sagi Shahar <sagis@google.com>,
	<linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"Shuah Khan" <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
	"Ackerley Tng" <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, "Erdem Aktas" <erdemaktas@google.com>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-29-sagis@google.com>
 <689cb7b077704_20a6d929455@iweiny-mobl.notmuch>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <689cb7b077704_20a6d929455@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:303:84::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6733a0-7fcc-4939-2913-08ddda8f1ad5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MU1rU3VlT21ISUFrOUd6VE9pT0ZBSnNLMDM2NWhrcHNvWmFXY1BhSTVkVWhm?=
 =?utf-8?B?cEtVN1RCU3JvOHE5bUtPLzZrTDJHdGI4RSs5Vi85eExhbm5jRHdsczFvdGd2?=
 =?utf-8?B?YkFrSFdPWFJTU2pCWmxuMkNnRUVlbU1mZzEwLzdONFkwaVFDZzFPeGdKTTBt?=
 =?utf-8?B?ZWJrc1RJRzRQVk9aZ3ljZ2pLWWp2SGZ5Z1ZNOW9NMUNueGtST3Z3c2tWSWFJ?=
 =?utf-8?B?Syt2WVdNRnZjMVRJZVVyeFhPUEFvcW1SNk1UbEdJRWpHcnlRRHJBeTc1ZWZn?=
 =?utf-8?B?b0FQS3pQN3dOTjZBTG4yUDBOSDUvTG5sNThvQS9VaHh2Tk9MRkhCczBZeXZF?=
 =?utf-8?B?a29IOTFwc1JtdWw0ZTdJY2VWeGlmNnp1RzBSWC9OaW12bjR3Zm9Bd2YrcGlz?=
 =?utf-8?B?d3BaRFBWZHpiZ0N4Rkdma05NK3ZEVVdUMDRybDZEcmVDK3U2eXJvcjVQSlNk?=
 =?utf-8?B?L1ZGN0VkMGNlS3NhcDVxTzhsNTJzL0pWb1BhVjgzNkp1TTd4TGwvSjNLa1Uz?=
 =?utf-8?B?NjZ3TS8xT0tXM3VRMGxqcWk1MlU5cjA4MnBZczR3WWMwVXlWd0x0cThOaUxC?=
 =?utf-8?B?MkJDUlhoMCt4ZnFZRlQyV2dRWjhsNElvVWkrQkV1dEZ3OW5ydXRKbUVnV3VZ?=
 =?utf-8?B?c21JNjNWV2RyTjZocEZTaUZ2S1lKMWIvd0hhRC93UjFIUVdnSHdxS2R5bjcx?=
 =?utf-8?B?MjB6cmtYRTNGcTQ5Y3NmUS90Z1I0cDZUKyt4T0xJakRxTFpqaWJtN0YwQUZs?=
 =?utf-8?B?Uk5NZGQ5VkNDV3hSOFhtUUtLcTB5SzVRVlVEdHFaSUNSd0lZU0hqVGRkRWto?=
 =?utf-8?B?b3drYmRnVWNwa2RmdFlJVXEyVkR4Qk9CWXQxR3Q0VnkxdWZzcFc1Wk45ajJx?=
 =?utf-8?B?OE1nNS8rYVQ5bXJMeVhicHA1b1pwUzJjeVJWTm95QVZYZ0VENVdqbTNiWnBz?=
 =?utf-8?B?YXVibTRDQW0raDNWTXJSY2tXZ2dXcUZ0K1NNOElwZDVaNU9BdDhMZjRUSitn?=
 =?utf-8?B?NWVBaU4vM01qMkM2RE84dEI2WG5weU5NNkp2VHkyYU5CemhIUy9iRkxDSHZX?=
 =?utf-8?B?UG9WQzQrRlZSUXNRc0ZVMisxQnIwMHgwYkM1SWhUOXBYWVJPL0hPeDUyMlJx?=
 =?utf-8?B?czBVRi90SUljOGtuSmNhb3ROQzdnTTcrT29xVUloby90aGdGQlVPZ0xHWGpo?=
 =?utf-8?B?RzhMbnpMa3RJV1d6Z21EMVBYNURwVFA0Q2hJZVpjK1hVRk9Sd3A0ZHdia3ZK?=
 =?utf-8?B?UW5GSDZqTDNoWVE5YitYeVovZjZpVmQ4MWVIbURmYzh3cVRpcEpwRDUrWE95?=
 =?utf-8?B?YmRaeDZucGRaZkl1Z0NjOU5sTXVtWUpQQWdkNEY2UUhMNzRNZlRCeVkzaWtt?=
 =?utf-8?B?aU00QXg0azhkNVVmQUM2SndGeTI5S3d5dWRpLzRaZDNNZ1pTSjlZdTViVHdY?=
 =?utf-8?B?STdXc3ZhTFFPN1c3cjRmWVVwRWhpQ1dvQmxsVytVQWpMM0ZLM0RrODVDV3Er?=
 =?utf-8?B?Q055U1FjaVpxdUZTcG1HSVpqb3BWR3lnQnNIQjZlUXpPRSttckc3aUlOdXpk?=
 =?utf-8?B?OEVmdjFIQ0JvVkFjL0UvODJManZJR081cjA4Yk5HOWNBM1pkcHVHNC8reXln?=
 =?utf-8?B?TE94STkzYUlnVVkzZnl3MTZWWmg4QWhtdFBEajVzK2tETGJoNGFQeFp3MTNp?=
 =?utf-8?B?Y0ZEVUZhbHZsVjM0TDNSSDBiUGRqRjYrRU92czNRQUhKTFhPL0hoUHoxM2Ir?=
 =?utf-8?B?b3JJY2M5MXZvRVJYYitERis0bm9lMlVHOFhCVnlJUkY2dWVCSzBiWmhsTmEw?=
 =?utf-8?B?VXJtQnhld0haWnZrZ1NGQ0hSd0R6Q2Fxb1p5Wmxoc0dxY1BZcktkS0sySVEx?=
 =?utf-8?B?QWRnbkYrYmljVFVKZGZmYVhLYzVwdWt5eUgyL2NPL3NZOFlYVmd2eEVYVnVL?=
 =?utf-8?B?OExEMGVWWFFSWm9LbGtib25SVUNHVUZGajUvdHNCWlUvYXM1dG1SNGxXRE5D?=
 =?utf-8?B?dkY2ZENUV1lBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkpSU0daREJhNjBibFRYdWo5S2Z2VFJuV002Z05jTmNZMXI0OU95K2Q5QVhB?=
 =?utf-8?B?NXhBeUlLSUdKM2QvVDVoaWZYSU1DTy84WGQ4bE5ncTYvSWtnamF5SDYzWk1B?=
 =?utf-8?B?REtDRFJLSUlZQStJZ2NLNkxjT2ttVzJCNFFnNDdpU0dvTFBqY2VhRjZFZGV2?=
 =?utf-8?B?Vkw1bE95bFBUUWlUdTkrUFpmektmUm5hZWxEc0ZJSlpURGRuMW53TFh1UkRE?=
 =?utf-8?B?eEwrd0pEYnRKZ21rWGJLanhpTHF6bVR3N1RaUy90OEd5dnF6MW0xQWRmQUVv?=
 =?utf-8?B?TVJlTlc4eC8xZVRuN2NXOExGQ0YxTDVXejdub0FJRXhhTW5QL0pCNjNjenl1?=
 =?utf-8?B?QlpLNS9ES3BPTkVlSlRFOFAzTGFoaXZjUWFreEZ5Z1FDZ3gzbmFLbXVXaUtU?=
 =?utf-8?B?c0N5M0VMd2VLY0VhcnZNZ1ZEcEoyYzJXTzlJRGtZWHFZZ3BvU1NmMjJ2LzNj?=
 =?utf-8?B?MG95Sy9NQXl3WmVxT2s0bWtYOVUvbzVFMFdYOFNJQ2JObzhwZjZMRkV4eTdR?=
 =?utf-8?B?Y3crZ21TTEJNa1J3eFFDUHBLTHBGblU0dHk4eGVFNUw1SWRhNnY1Zkg2L09L?=
 =?utf-8?B?YngyZFVvNUZiZGxtMmlEMDN1ZUc4SXd1Y3VYQk9ROVJJYnkzbUtYcjlyVVZY?=
 =?utf-8?B?S2ZXVnd6UXdNWGFUUTd6SHlnTVBJNnNaSUJjRjRuSW1GdHlMQVR0UE1WZmEv?=
 =?utf-8?B?cVg1WHg3enRyaEgwYlM3R2p5N1JjaVUzN1FiZy9ZZnhDOWlnelBLSytaMUpt?=
 =?utf-8?B?MkNUcUsrTW96ZlE0YmZkTkxHcnpKMG9aelNyQml5ZkNvRzc2Y1g1d0dWZjBQ?=
 =?utf-8?B?b21HQys3MXJqNnIydDdLZGZ4eXFST2pJNFFLdlJoMlVGQ2J3QUg5S1ZLVVNT?=
 =?utf-8?B?WThxTzljbE1Rd3R2TDVxditzVW1LbWNmV1AyR3FrTThGV0hoNmsrNmM4WWNr?=
 =?utf-8?B?SmlLS0hGUHNOM3FoWlhuV0g5dVhURjNhN0FlZGk3S3BTNS9YbloxbkpDbGlN?=
 =?utf-8?B?MGs4YTdmTThQNkl1Y21RRTl2SzQ4Vm5kaWh3Q1BIVVRxNkRsZEpSa2ZQZ2Er?=
 =?utf-8?B?MnRnN2g1M1cyTXZOSng4WGZvd3RFaWJLN0FDcFF1RzRsdC8ycjFiOU1xb1Qz?=
 =?utf-8?B?R2pTdzlkakJBZVhXbUJRTnp0YjFIbDlDY05WRURrc1IwVU03OWRsVTVqeHky?=
 =?utf-8?B?R3NScjd4ZElmMlJ5NHhiaTdGSjRFMS9KT2I1cWgxeHhDM3ZUc3l4V2E0dGwy?=
 =?utf-8?B?TS9ZL3JxVGowWFl5d1d2akthTTVOZ3dIaUtnNkNSZGxMOS9qdEtsamhoV0tT?=
 =?utf-8?B?enN1cHZGUGpPM0tBM1M1eTlnVkVqVkJ3Q1c2QjZwWGR4TkFOTFAwSEl0dmNC?=
 =?utf-8?B?anpTL3IrNVZ1V1hweEhCOHYxU21DU2JaSmg5bVUyN2JWZXBUZVpYUjZMNERU?=
 =?utf-8?B?eFBSbTU0R3VVZWFDL1ZWUExKOVJlc3NDN0FRY0pVZmYyL1dRYkVVYU1qODYy?=
 =?utf-8?B?d2FUbmJabmRubDBiMFhzRG9UaW1jVElwTE5uYkJZVURKSFNleU5Ec2cycUFU?=
 =?utf-8?B?bVRSTUQyNmh0ZnpSR1A5dkFpZVhzZGxCN1NuTXBHL0VzZGROK3F6K1dTUzdx?=
 =?utf-8?B?ZllTbGNyVkt4ZGhELzlhMGl4SXVpNkZBSDNUSE5uNmMwcmJxdDViNkF3TndP?=
 =?utf-8?B?VWllczVId3ZRdUUwc0JsbEFZVUhZYWFVYUZxcDcvb1g5UTUrTXBjOHRYOHF5?=
 =?utf-8?B?Z3FSVUhkY0sva3NyZmFWcDZ2bS81ODIxMms3YzB4QWY5OElDaUQ5V0NEYVRW?=
 =?utf-8?B?MFJMNXhuTDJKekdvOHlwcUdNZUhZNkM4ZWhHVWFoQXFTV08wV2VOdFJXaEVo?=
 =?utf-8?B?RG9mdzJUZjlCZ1B1KzZqNE1UU05FQTRjNTFVanJmczh1NVNmcTFIWTFGT1dP?=
 =?utf-8?B?YTRJVWY4Vm04ZXZYQmd1YXMzbW1vb3Z1VW5GQVJRZ2loQk9BR1Rncjdvb0FY?=
 =?utf-8?B?d3pNazhOaVdYeHg5Vm9TMHJhTmp6MThONkJnTXhCaUliNVY1SVNRWEVBM0xQ?=
 =?utf-8?B?cHhlMGZXQ3R2T3hwNjk2bjVYTkRsbGo4Sm5WR2RWSVdlR29CanV0WHlqdEp3?=
 =?utf-8?B?aXlvSGwzc04xb0xHbEp4RHZha1dYNW9ZQjdtRVFlRmVoZnZWRjJHM2w1Q3RV?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6733a0-7fcc-4939-2913-08ddda8f1ad5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 17:30:32.3190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEYoSepV7vWOchIJ5E3836d++0Xh9v0ycpr3V7XmvfpTTV7g86CR1jtl1XfL9TfQpp0MOc+BggVSuLgvcwG1C4fkVlehgn4s4/nD6TBPtno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4684
X-OriginatorOrg: intel.com



On 8/13/25 9:05 AM, Ira Weiny wrote:
> Sagi Shahar wrote:
..

>> +	td_finalize(vm);
>> +
>> +	printf("Verifying UPM functionality: explicit MapGPA\n");
> 
> Not sure if Sean's comment regarding printf applies here.
> 
> Personally, I don't mind the noise in the output.  But I am running things
> by hand.  I can see how having no output on success is a good thing when
> running a suite of tests.

Switching these to ksft_print_msg() could be an option that supports both
usages. ksft_print_msg() adds the "#" diagnostic prefix that should be ignored
by automation that is expected to understand TAP13.

Reinette



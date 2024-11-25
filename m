Return-Path: <linux-kselftest+bounces-22507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65019D87CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 15:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7299116ABBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0641B219A;
	Mon, 25 Nov 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fufxV84w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED38184520;
	Mon, 25 Nov 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544473; cv=fail; b=eHyldCF6X2P7RoClqY/N+4ddCAbE/bt7uPLI/z3V4fW5W25j6hGvnkX4AjmmHF5sTzQxWJorxGUPm44WLAPVN3yC6AeCm6rIE0Z1T05jsoGpvCdAztKw7YuaYmp8mwiEw2iUsRjh4TSV9/YW3UTGEw6NB5HLZbWTE2+bq3xOJac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544473; c=relaxed/simple;
	bh=abRdtuOAaUTSxfHgRQlEVCOcXHewnsFKPFjTUkDBVII=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qk8BWOhNUJBQHTJDkn+KuD+2PhiCpU/AIsJPkMW0IdQr2oQPhlpk5x1q8j83oMOCOg/3/PYEqtZ9hRgMYb+OvAKd+BI4SkXkkIIT5Mr02AH0yDdEiTmZ6aNVpSx6sOzcUtAXS8UrXAsG4SQ9jnEK4cK90//9DXbltctUIXiE2/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fufxV84w; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732544471; x=1764080471;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=abRdtuOAaUTSxfHgRQlEVCOcXHewnsFKPFjTUkDBVII=;
  b=fufxV84wOR3UNXHtCoNGqoM0WVTzT0zla1VHqaPLKswngRWiiOZzc0km
   VMNsaOq8V22goayemicaUmqD5uze/7OjLyRg6CZollbUyQS6yOBfkrM7Y
   Vd1HSBpG2TDG9sFBn1NSlhICv0IKlsVwhOF4ZQnvVsOV4QhwxDiOl5TT4
   /gjgjOLGXmNwsAlABtyKZgcYZbwc1/wku6u2kegI4RgL1UeEWlw5Tk9Q2
   LgcNdqVOt1XcCvBSVmKEDWB8MLR9Z4V0i7Tl0NtlLXxZKXBKZ7u+OPxYV
   I3FrUHb7/8dl8qoAZ3YwmqaJJVfTbS6vDIFjD+NILks1QX091CZkgDSV3
   g==;
X-CSE-ConnectionGUID: OBKCj68PQZCVGw2NcYWHqA==
X-CSE-MsgGUID: rdBF+Xg5RZOJDnFjt27D6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32511906"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="32511906"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 06:21:07 -0800
X-CSE-ConnectionGUID: 5U8EH/TDQFOBGFo9GWVxfg==
X-CSE-MsgGUID: mnMw0ZZNSLO+TBLdRGT0mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="114542765"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 06:21:07 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 06:21:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 06:21:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 06:21:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bszFQY3tzp4xjOmV3M4azdGirfn1XmVJ+SxjApRbcGIIvQos/hrl7V5BlLOhw4rtXmrTy2mPheUx3ZGz3WvGC7YKenzVpQNn0fdGiWDRoukFxU8hjI4jjH1+FhLX1qhbC1oJCR5vzgpcYXAvU67ssA+Rbht68nPRLKDImb2MyKOj76WzxEHwhpnjDekYyoXY4V5RzntFZ1r5Wc958YgtoKEPVf4Qw+KTyUEgYuSxPQVSRXrime6IrZRBcuEmC3EgjN1WOLhBnRt6c7gEDReQOsnJPFAt1dgZC3/4I1j7CFgLjySMm1J5d5kbsugSrjFKrbkjwbd10JulyyWGkOvqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hgy+cvgKoXHjLPOGax/mD6kX7X0Sl+vTpKuwhH7+Gk=;
 b=RxLN8FdgD4C3hZ5SLoVLVHeW4i6UvicSTz1dIT1DytwBqqBZqTA7N1ZAivvXp0WWUGzcaBNmgIw+xflG54vACFoTFdOz5uT/+9M953GbxioenEkLnLuabRwfM81lC5JCD/xVy3gB47ovE3a/19TeNnSr6Fif/oKQ/PszLIsvKm5OFZm7xJiM20WKyWl1cO3K/khYxoePjMo9JS10mH8EVAjuEbQC7RKwrK9YBX+ZE8RzISciKXdqWudOw6O5CRnuTl8iJNMvxlbRXx+TujTwpxth24UXN7u3egS3nmvq4FVtI6liM0TPLMvvzC8p+HOcigErkPQkngkiIT8n5sfG9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by BL1PR11MB6002.namprd11.prod.outlook.com (2603:10b6:208:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 14:21:03 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%6]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 14:21:03 +0000
Message-ID: <6ab56991-1415-4009-a630-14a0b709583d@intel.com>
Date: Mon, 25 Nov 2024 07:20:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: ethtool: only allow set_rxnfc with rss
 + ring_cookie if driver opts in
To: Gal Pressman <gal@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <habetsm.xilinx@gmail.com>,
	<linux-net-drivers@amd.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
 <cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com>
 <871a9ecf-1e14-40dd-bbd7-e90c92f89d47@nvidia.com>
 <b0f84914-c4bf-9071-b72d-cc2cc4a517f9@gmail.com>
 <d986d2ad-3ac6-4357-a8dc-e83e3622efb2@nvidia.com>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <d986d2ad-3ac6-4357-a8dc-e83e3622efb2@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0295.namprd04.prod.outlook.com
 (2603:10b6:303:89::30) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|BL1PR11MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc8129d-c166-487d-a231-08dd0d5c64cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1FMeHNaMVU4eGxrbHZRM2xZRyt2UW15a1NkdXNjUklOT0JMQ2hNeGRvdkxF?=
 =?utf-8?B?TWpZdU5HdE1MQnhZaEFDZGlBVWlFZmdMZi9kUUlML2dURlJCTUZQNmMxclhX?=
 =?utf-8?B?aGVJd1JQekx5TTYrci85S0c1SHhxd3lYRlROYnIrK2hJYWJyZU5COU9qQkh3?=
 =?utf-8?B?emJwQlJKbERBVlpMYmVWNW1OMFZBWmx6OE51a3pzcG52T3RsWDVvZnExS2Vl?=
 =?utf-8?B?dURHV1hwekZLMmQ2RGpKTTB0R3NxRERBVUx5QTJMN1doOXBlU1R4d1JMcUZh?=
 =?utf-8?B?dy9uZ2pwek1EU3RkR1pldFJ0UWF3cEp6TWZiVmtWR2Q0aVkvbjMwUFltSmM5?=
 =?utf-8?B?ZG1QN2RTVmJqclZZeDd1b0o0R3F3ekhlb0JGdVpGT3M5aW9WL3RLMS9BdDMy?=
 =?utf-8?B?em5xM1E2djE0OHp4dktZVjVXc0FNN08zTFRtVFBTVnRibGZ0QW5vL0MwQWNY?=
 =?utf-8?B?aTNaNUlRMVN6VUM0aWRUZVJ5UTQ4WlN1WXBpZkVpc2xSRDJlRDB6Z1d6d2RP?=
 =?utf-8?B?N0FlTDZxMUJTcmdxVjhiV2hUdmhQWWVXd0prajN0eVZwalZ5em9hZXU1c2J0?=
 =?utf-8?B?RkZTa0JtM2pQVGg1dTZTNXJKVDZRcmxWaU9HM0Qvb1Y3QnZQY3V6Q2VKV00w?=
 =?utf-8?B?RWdxMVdGN1NZaGFPQTh3MzZudmxOcFExYzM2YUpsNVdtOEo1NFFWSEJNYnpF?=
 =?utf-8?B?NGhLL1FCSFMvU1d0NW9FbDVQdjVEaEpXYzZCY2Rrb3hsZm56ME1na1NVbTdo?=
 =?utf-8?B?YjFDQlFhL2RtWWFYSzhla2dLK1Jta01XTGRMeE1pM2FWMTdUZ1VxbzQxU3NR?=
 =?utf-8?B?M0FjR3d2TlZvUGs5aGdtcm9DbWs1L0s2ZmFSUDlUUnk4eTJkdFMzZmh6OGh6?=
 =?utf-8?B?dERoS2xRSEdmZzY0M05ESXB4b0tXRVRmK2ZFcEMyRHRHanVoeTVZb2RJTnNF?=
 =?utf-8?B?d1BqNlowclozb0pKakE0NCtjTFhOaWJmRHU2L0N2d3NGTmY4amxxUDF3NlFS?=
 =?utf-8?B?Ni93dkRrc3NWRWN0T3YxSjBCUlpjN1Z3SzNTSDNyYjlqVFlzajZTWEE1dG1J?=
 =?utf-8?B?NXpXZ3ZPcjZPZHVXSU5WN2tsV2Vkejh1eFIrZE5SZ2hnV2dHL2hwSWFyd21V?=
 =?utf-8?B?a1MveGtiMTA5WmpkYWR0ajMyTXpNT0xOL2VrbWF0cUMvR3VPMFVCamt0WlhC?=
 =?utf-8?B?UUxVRm9tZzM0N1BTRmdUNkhXY3FsaER0TVZwUWhieUpqK1dnNmpJcFd0bzk1?=
 =?utf-8?B?ZnFlNDQyK0MvZTVvTnZ2WktjZlFvTFNYamRNUHYwWjRqTFVIdGxWUExHSFlr?=
 =?utf-8?B?bFRMcTdpNkZad1JybVlxMFpjNjVWZUtXQVdQc0NPYW9WcFI1MFBRQ1JvUnc4?=
 =?utf-8?B?L1l0dnJJd0JKell0RE5hUTVTNFdWU1NPamhkVVM2a2JUV0lpM3pOZDJmeFhT?=
 =?utf-8?B?cmhjSGpyd2lMYW1nQ1k3OVM3RFY1UEIrbXc2Z1Q1NzNDMVM1RzhTL0M2Rmwv?=
 =?utf-8?B?SjgxUjdiSjVLOHoyNExrSjlMNmNWNkpveitkWW9PRldtWGVIaXRFbW1ieU85?=
 =?utf-8?B?cjYrU0hQakVjWGhRaENHUE1BWmkxRjBKd2FTcnFxTDRGb3hMRzFtK3R5TlB5?=
 =?utf-8?B?RTFBMEQzOVliWFNEUkxoS3FkTElQeWNseVZRNUhZU3VDWU9aWHg0QkdWR3ZD?=
 =?utf-8?B?Z2dJQ1dyWEtBNHBiWDlFalY1T1pZcU9JMmdWRzVmVHFnZCtDck5FOWtKbEQ2?=
 =?utf-8?B?dFY0dFRXWjhSYW1TVXA1ZDRWWWRhRU83anY3L2hPZkRVdE1IaVg2YVhxQmds?=
 =?utf-8?B?ZDBNdTMwQ3VGSFlNczAvUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0V2bXYzRjJrRFdyN0V5QjZjb29zQlRVdmtDREkvWXRnN01ZZ2dEbVJOcG5v?=
 =?utf-8?B?OEVXbFByaXZ6a29DRlk1K0tSQzhvVE1XL3hPQmd1Ni9lSlhwc21aR0Z6a1hu?=
 =?utf-8?B?elJzb2RUeXg1SU10WlBRTDFaWmZHWHJXMlF0c052RVV1Z2NsRGZ5emVDd3hz?=
 =?utf-8?B?L3VBbUZKRVI3dEs0a1FGNWtkTEFydXBqSlZTd2lQNEZzTkMrNDNTRlZmSWlF?=
 =?utf-8?B?WE5GSkZ1Z2wrb0pHNm9veFNYejM4aEdWREwrZUIwenVGOUpjaTd0dWJUU050?=
 =?utf-8?B?SUpCL3JuNE5mcEJ0bEVHNm1JU2ZYUDNGRjZqTU1Dc0lzd0RGSFZYZU04T2E0?=
 =?utf-8?B?enhVZ3h1OGUzeTRTb01xN3I0WUV5SlJ3Qm52UXhySmgzV1FJYm1QWG9Pd2Z0?=
 =?utf-8?B?VVMwaS9mcVdGTU1zWGp5OVJMbVFKZ0Y4WXZiM1k1VzNOcHlQUUhNbjhINDFS?=
 =?utf-8?B?cEM5WWFPVkdtZHZVNUlUQWhWdEJ5dGk2SlBvKzJqR3huUlNvZ2xJTlhmU3Ew?=
 =?utf-8?B?dENQNGJ0aTMwUmlNdWJtU1ZWcWRrK0RHMWhmNXlHRGNaTC9XcFVEMkV3NWdr?=
 =?utf-8?B?WWd3TEFIY3VaRFdaRSttZGRWOWJ4NGQ3ZmtsWUp5STJnU3hkWEJqZTVncGRy?=
 =?utf-8?B?SDVxRHZTQmh0QkpTaUpRRmtVclNsN1BHcXptS0NNa0wzZWxUM1JoQm5iZFVF?=
 =?utf-8?B?QzduQ3dvMmNmMjFOdjVISFlLeXdUQzFHNTJ2b3MyQmtWUmVxYlNIY0F5QVpY?=
 =?utf-8?B?OUdWNC95Ni9aemJXbEJJOHZkM213MzdFc1pYeEtQVFF2RDFRMFh5N3BmdEZx?=
 =?utf-8?B?eXVtcGYvNXA0VzBJb2JjRnVxWklKck9KWExWRzN6UFl5ZXRaK2YzcklJY0F0?=
 =?utf-8?B?bDBRd1ZJTGVGZ0VXVDlRbURXRlFMQytOeDlMWWkyYUVKME1sMXlML3J2MzZz?=
 =?utf-8?B?ZW5UdFZucTdBZjZFbWFJS0owMDdKZlU5dzZjdFpCaldtT3Y4U2FEbWhaNnMw?=
 =?utf-8?B?SmpDWStTRHVSWXB4Tk1CYVBHNzBqRjBRaG5rREJ6NzJjTmRyZmtXcWh5cW1W?=
 =?utf-8?B?d1Y1aXBSV21McjlsRVJ3YUhrUWtXN3l2SzFXVm5WM0w2Wk1zUVdPeGNzeENV?=
 =?utf-8?B?N0taMkswaEFWbzlIcmY0c2ZsRXhPc2FhREJZTUpLN3dQRXU5M1RxQ29kTWw1?=
 =?utf-8?B?NlF1cjAvUkh4RGorR1VSc052Vk9xNDdmMWMzK3dpTnZ0Nnk5WjlxeWg2dGJL?=
 =?utf-8?B?SW1NR2lzRHE3STJMZVNYS2J5SGVWblEzWlB6OWhkRUNzeTZ5RE55QmJma2Y1?=
 =?utf-8?B?M3RncGNlTVR6TUc1NzZ2RkQxRFhzdCtPUmcrUnlBNGR1UGdVUXVMSW1XQWZq?=
 =?utf-8?B?Q2s5NCtYVFlKR3hpWlMyMkpPNGNpRmJQSk5oN3ArMmM3SGZVOHM2WHdYZ3dz?=
 =?utf-8?B?QmZTTnl2Y2VkSThCdDJxTENTck9aVVR1dUZRaytmT1I3aG1Sd0hFN201OE5C?=
 =?utf-8?B?OVJ6c09PRHVuTXNpeUVmNi9yUEdaVWNTaGV3cHUrVVdjTUljQmZkR2h2Z2hU?=
 =?utf-8?B?c2M2OWx4QzU2SkJROG80QUs5dGJqTVVoamNVakN2ZjdZVTdTNm1oZnJ2dFQy?=
 =?utf-8?B?RFBWTFRyQ1UvRXJScTgrZjF5Z3VUV1lSdXYvZndMNFdQZ0QyREJEUEQvVlc0?=
 =?utf-8?B?bGU1YmdIYVNQaWNtR0pRenh1eVJVVzd4bTNKMUlhTUpJNG1wazNxckV5V0xO?=
 =?utf-8?B?Zmdxdk4zMXdGcVNxOHg4SzhCZ1Zoa0xtbUVObDZLNjFhQi9CMmNKY1FsV3RI?=
 =?utf-8?B?aE1yenArRW9VQ1VhMjk0SVYyY3paZnRLNS9WRFlzVmF4SVA2VEtGTEp2L0Nq?=
 =?utf-8?B?R212S0FPSmVZbXVtNjNwQld3aFI2MEFGekU0TExIMVdGWHdCRlcrZ2lhek5G?=
 =?utf-8?B?aDNtQkFreFVaR2MxdHFlVEM0V2ZsQmFaRm9YUis5RU5XN253alBDamcvSjU3?=
 =?utf-8?B?SU9FUmpBTWN2SXpQSGxqMTNzVjZKUXlGU2xKSXJ1ZzhHZ2lsS3dGK0kvdnU0?=
 =?utf-8?B?SDFlN3ZkVDVvTTBVZzJyUndSN3V1dG9pd1BhQzN0SDBvQkFIUGtNbjNhaVh1?=
 =?utf-8?Q?HfyHnrZiyeNVXTwTrKxaxWJic?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc8129d-c166-487d-a231-08dd0d5c64cd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 14:21:03.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jr/1u6jgVxSXtdVTY7ApgACNPOYLKKRAfNAiRAVsU0AI6Sr1VgEWd7DoWzTZVDLL/vvK9UY6To/MabA2+z+Ceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6002
X-OriginatorOrg: intel.com



On 2024-11-25 7:10 a.m., Gal Pressman wrote:
> On 25/11/2024 15:21, Edward Cree wrote:
>> On 25/11/2024 07:11, Gal Pressman wrote:
>>> On 13/11/2024 14:13, edward.cree@amd.com wrote:
>>>> Ethtool ntuple filters with FLOW_RSS were originally defined as adding
>>>>   the base queue ID (ring_cookie) to the value from the indirection table,
>>>>   so that the same table could distribute over more than one set of queues
>>>>   when used by different filters.
>>>
>>> TBH, I'm not sure I understand the difference? Perhaps you can share an
>>> example?
>>
>> Something like this:
>>
>> ethtool -X $intf context new equal 2
>> # creates context ID 1, table filled with 0s and 1s
>> ethtool -N $intf <match fields...> context 1
>> # filter distributes traffic to queues 0 and 1
>> ethtool -N $intf <match fields...> context 1 action 2
>> # filter distributes traffic to queues 2 and 3
>>
>> See the selftest in patch 4 for a concrete example of this.
>> Some NICs were apparently sending the traffic from both filters to
>>   queues 0 and 1, and ignoring the 'action 2' on the second filter.
> 
> Thanks, I did not know it works that way, is it actually documented
> anywhere?
> 
>>
>>>> @@ -992,6 +992,11 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>>>>   	if (rc)
>>>>   		return rc;
>>>>   
>>>> +	/* Nonzero ring with RSS only makes sense if NIC adds them together */
>>>> +	if (info.flow_type & FLOW_RSS && !ops->cap_rss_rxnfc_adds &&
>>>> +	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
>>>> +		return -EINVAL;
>>>
>>> I believe this check shouldn't happen when we do ETHTOOL_SRXCLSRLDEL as
>>> flow_type is garbage, WDYT?
>>
>> Agreed; this check should only apply to ETHTOOL_SRXCLSRLINS.  Do you want
>>   to send the fix or shall I?
> 
> I will do it.
> 
>>
>> Also, the check below it, dealing with sym-xor, looks like it's only
>>   relevant to ETHTOOL_SRXFH, since info.data is garbage for other commands.
>>   Ahmed, is my understanding correct there?
>>
> 
> Speaking of the below check, the sanity check depends on the order of
> operations, for example:
> 1. Enable symmetric xor
> 2. Request hash on src only
> = Error as expected, however:

Correct. The check below is to make sure that no ntuple that does not 
cover symmetric fields is added if symm-xor is enabled.

> 
> 1. Request hash on src only
> 2. Enable symmetric xor
> = Success :(.
> 
> I've been thinking of improving the situation, but that requires
> iterating over all flow types on symmetric xor enablement and that feels
> quite bad..

and delete/disable filters? may be just a warning to the user that some 
filters are not symmetric.






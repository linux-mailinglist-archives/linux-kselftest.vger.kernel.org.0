Return-Path: <linux-kselftest+bounces-13082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C899249EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 23:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F472857BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CBD205E00;
	Tue,  2 Jul 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9sqxMiw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D76205E18;
	Tue,  2 Jul 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955643; cv=fail; b=TC0uxdp/RBtTD7w9DLp+20W6mE4ANuk0HqTfLNKRImgzv2wd7LAfelcf5gA6oKfUQZf1jh0jnAH5uXqO1mGu6szwAl3zqGi3NeNQg1vEzieb/LiJmTBfXI6EZvvgEM2pBDe7QRf8B2eYPwblDYJcZ/dg1x5OZ2VBMfz8HM+IbTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955643; c=relaxed/simple;
	bh=3qLgeRLdTkek5VocGn9/Vj/iF79g6I4+ry0ptq+18ro=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=REd7oeJUiXb+aspN6KJhB8FOnF3M2nIuSifgy+l9U7gWzVO2Fl/fF3fTAdqczYSoLFzsMtm1Ghc/QYgPwbPZoN1yucOYH5ef10dsNQXDzr0keJROgrjxShGPgnlRvql1RDnPu2913HCsssqG+4YwW4AOHZ3wiH0p2vOwkqzKaWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9sqxMiw; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719955642; x=1751491642;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3qLgeRLdTkek5VocGn9/Vj/iF79g6I4+ry0ptq+18ro=;
  b=F9sqxMiw/w/kDcjpc/YDdJtYrPLHrjn3IlufKzprFGjKp2FVW2udcKmS
   616WudUrHl25YGcXV/AoHXqrjsFls90R0xRhZEJsvpnIsXLDr/1tOtM+w
   dT5Ve3hNdzeIXo6Vh2S/8c+k1tWsqXO1QocL94yJpAIhMSx/ELA3acXfs
   0qOjCMkkphO6dTOdg9weWcF1zKlsmczQ02GSBbwh8hiJuAUICTZ3qRvgE
   x275GVJtz+BT3GUlGzQAcl79k0EtEYnyzrsiciO8QZ2Cikfr2E7JRzA7P
   sM2KT7U+VC5o+gh8HDWLA7bmSm2rsvsk8nxBCWwT/wq5ArohUb4FIonaw
   g==;
X-CSE-ConnectionGUID: HW0n6U6oRt+pl4qBdVxLBw==
X-CSE-MsgGUID: 7+oPEpWGSGurdExRshjdyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27757130"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="27757130"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 14:26:30 -0700
X-CSE-ConnectionGUID: mqFhFCsbQ/KgLPuw7MgdcA==
X-CSE-MsgGUID: wulJuMQiSlqPiy5eaC6I7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="45812822"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 14:26:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 14:26:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 14:26:29 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 14:26:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK9n8pbHE8fOEhvEDFsvsM1ElTUzUFuHb0RBkj4zc7Q7t1zjKEvDqyrd0z6Oe+s8UZQRSyeSUF4eomyK4PMx5M5P3U/afQYkmZ5RR88ZDOQDNSd2esghzBYuREMpm1MLNzrawMGFEP2yOZa9nCgb5QHo0IbdxKWbcc3wFdpBLvZM30hZdG8ovbpnvDbef3YaDZ8gzwuNSs5upXthz74lk5Wna7k6VshP/bSdsFXclhx9CwanX32esbrWEDipaIEIMOaasqp4GEGBlpMEFgRgrTnzrek0IBj4F+Eu6HPSxm/EIC2rYITPWptz8bjsbMosWMuautACB0hF6RjneCrCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jIEAXt1cOgQDdjzHYeig1gQ4yHBcSghOjLaQPkrYc0=;
 b=mineWWi0RNyOQbKSt34zwpX192Unsk5a0zG1xrnWs80G2KKRQzdl6+h8J2O+ucCbjHla3ED9OvTiqulrb4xLPMGqOrPorGWEN2GSz4/fe6WrB3ad+kecId+ISMdNv4mLiq1Glc7/MpWrTNMupjA7pwWqto4ydJjNxoZol2Jo4GCrS2soE/biBgQ+VLnl2PVluKRO8bcIlqsA1v6pDHrsQ0aURFsqG8m5CGBJNqg3PKkuB1InJd9PnnHG7s6p7hXfoXZsvj6cNhatjcweVNAN3H6c7zDhMv560XEipZWHR1h35s5KQFCn9jkVgV/fO7LKA1/cKxN29YnztHpXCFqvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB7045.namprd11.prod.outlook.com (2603:10b6:510:217::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 21:26:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 21:26:27 +0000
Message-ID: <4fdc8cc0-0b04-4879-9337-9eda3b83f603@intel.com>
Date: Tue, 2 Jul 2024 14:26:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
To: "Luck, Tony" <tony.luck@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"Yu, Fenghua" <fenghua.yu@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB6083D0D8AF9D1A7864084F0EFCD32@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB6083D0D8AF9D1A7864084F0EFCD32@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:907::32)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3f5664-dd71-48e1-a75d-08dc9adda197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkgyaE4yR2wwSGxDNm9oNTMyMXdpZUZWTkVha0o1dlJVTCtKTGhsVit2MGlB?=
 =?utf-8?B?eTRCN20vOE1aeG5jSkJIN2IxM3NiaGdnZDdNSncyalh6b1lkZzVTRlZRazNh?=
 =?utf-8?B?VXdaZ014YVJWS2F6Zk1tMy9DbmxnUWRyWk83Vy91T05UOXljYnBxTHRkcUlW?=
 =?utf-8?B?RmNqS2pvc3lISFQ3ZW1DcWNTRUlOOHRTaG5rRTlyUEpxeVBEVG84NVBGU2I0?=
 =?utf-8?B?MDQ2cmVkUXNrZDFmZ001amdNUU9qM3hyS2Jpd09hTm1aOUlFUnNUZmRmeHF3?=
 =?utf-8?B?STQ2a2N2UGllTlNFSTBLUGFsUjMwK2UzazZ0dTJLanZneXFHbXlMWlpyWHFH?=
 =?utf-8?B?M294K3haZXpWVVN1dmkzZDdBZHNKRGxTcDByQk81Z0t2QmNaZlJuRW9GbzNs?=
 =?utf-8?B?S0xMR3daQWlSZmh5KzdkbnEwRURhZG9HTzhwa1lXVWZEdzdKdzR1bVUyMDkw?=
 =?utf-8?B?Z2RwVnRpdHNEQlZpYmtSenV6RjN2ZTFmQ3BLU21SQmJwVTBkZnRLZStuMUdp?=
 =?utf-8?B?ZmdERFpoc1ExMW9BREo5VkEvVlNXTmN5NFhueVM3RUVrZS9WOXpPQXN2dmpC?=
 =?utf-8?B?bmJHUncxNXlLV0Y3T3BzUjdKMkZFTUR5eENyZFF3OGNwZFpDWHcxNXo5VWpX?=
 =?utf-8?B?LzhldG5seC9kdG1lcjJsNmwySU9vZitqRi9hb1ZWTVpwaWUrQXcvUFpZQklr?=
 =?utf-8?B?RkRXbHYrZXdzZjVHcjY2THdWTDBTN2dPVkdMd3k3Z0dLSGptdHpPbktLY3VX?=
 =?utf-8?B?RU9DVVdGK01qWlVNVmZqS0RvM25uU3hLTDhKMk5iZDhEeUxuVlA2bVV4MXlJ?=
 =?utf-8?B?RG9uTjdtZ0dwQkFJREZ2V1ppN3R3bDRRcjQ1N21FSDhLcGh0OFhkTjNRcTI5?=
 =?utf-8?B?dGpxNUpxdFBrV2xtTG14OW82bW1oRE9EZWhJUEdrS0ladW8wc2xCNVJUV2J0?=
 =?utf-8?B?dXFjUlp3U0hhaE5VUFRUZFhzYW95UHFqQ2ZvMHhlY05lTUpFbHBLTHVoMjB2?=
 =?utf-8?B?VEdPbk5vNXROeW5xVTBWMlZkUXFUVFBxZmVwQjZ1QUcrVStYYU85Yyt1UzBz?=
 =?utf-8?B?cEpvMVZxUXB2c1dKYkV1N3diV0g1SVFtV2VRYldxSkpyRUtiSENPNmN3UnR3?=
 =?utf-8?B?aXBYTmdiSTIzcGlFUU1oVy9WbmZUYWpaOVNHeFpyTnJTSVg1ZjhwZGJOblhE?=
 =?utf-8?B?WXl1cHdHNzBOZW55OTI2L09aaTROUW40M3VMNFlPdlBsRnlFSGpjVXQ4bVhN?=
 =?utf-8?B?emFQZjJkY3g4aGh2UmM1YWFPdmxjbWNBbkg5MEIxejZsTXRzenBGN2RkMlRs?=
 =?utf-8?B?bjFyZk5SUG5XaEhVRDA3YkhtdSt4Mi9pUTAvZFJ6NVNZeDgzUlpEWlllNndT?=
 =?utf-8?B?TDM2a1l0UDg0OUVjZnpGemVreVAxZEgzdUx0NVlqa2phQWx1OERjbUkybUtF?=
 =?utf-8?B?MHA0dVd0dTl6cjUrSzB5S3A1Y2hpK0c0QzFSOFdTaEZmRWRVMUdnOHQzMXVO?=
 =?utf-8?B?eUxlMkdxSXJqUFRRZmJsR2RTNHFuRXFmNkc3U3M1T1dreXJBdkJjdGpYSFZr?=
 =?utf-8?B?SXB5WVhrUzZTMGVsZW5wYjdiYXlId0hxQ1BQd3JxZzh5bnlnV0xjcEhMdkh2?=
 =?utf-8?B?R0lUcWhkRjJjZU5HcTl3UENuMldlanlCcDdsMzFpeThFTmNDSkNvVlI5a203?=
 =?utf-8?B?ZEh4UnpXeXl2eXdCc3lvUElqZVF2U3YxVnh0eHYzKzRRSXJxYTNqMnE4Yld6?=
 =?utf-8?B?eGxQdUJzQ2o5NzVHbU9MaXg3UFkwa21zeWVmZjV1NzIwdTA4a29zRkFiU3BQ?=
 =?utf-8?B?S29IZ3Y1aUZQYk84WGI5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWN3My9sRFM2SDZ1bU1sTTl3U0pVMVU5alVUZ1pDbGhFYStQbURhbnN5SWZX?=
 =?utf-8?B?MGoxdU1nTitmRWZaRE5VUHpuNnE5M2o1eDJlV3NNendQOS95NUVtcmJza3o2?=
 =?utf-8?B?MCtuYmMvV01EeUc0cVkxeXl5bSs1UkI4WlNaaks3bEZVeHZNVzMrRVgvbEt6?=
 =?utf-8?B?VDBUMTlmQVk0TzRjRXUwY1pCN0NObGdCSjIvOVdsWmhyY3RxbERvRmlZaWFP?=
 =?utf-8?B?MTVLMzUwZ1VvYjhzS25oVDFKdU1xSFZqMUVqcXFpalFZbEd4L0V1ZG1vMUVp?=
 =?utf-8?B?Y2xQMEtkMnZFTEN2Zko1NHdZUm45OGt0QTFFbHhWSmEvcFArM3J4eUExRUVa?=
 =?utf-8?B?U3lIc0MyMGxYb2FWWUxWanVPVFU4V1VwQWhDbWluTWNYcFJEMmY2TUlFMlZD?=
 =?utf-8?B?OVRNSFJrNGNKbGY2MzJYVThxeXZ5VGk5cEQwREkzKzZ5Y3lWaVRlUFQzYVV5?=
 =?utf-8?B?cE1IUXJMNStJcUhKWTl6K0tNQ0t4NWViMWt4Nk9xTy9YeUQrUDN3dGVhNHNr?=
 =?utf-8?B?VmdzSTJFOVZvRDJ6dGlTZklhd2ZHL21iYjFyQThCemhPSE0ySHArSXk5Rlc0?=
 =?utf-8?B?eEE0TnVFcmlqb1VGb0tLbWZnMGdDZ3RLSUEyQThLNnZpZ3RiRTZmR1h5RU5S?=
 =?utf-8?B?dzM4dTRsN3FkN0FmZFVKUFVxVkM2UlBTc1dpMFVYWS8vNDhka1pteThMaVUr?=
 =?utf-8?B?MmxjcURzZnlmcFptcmtIMHptbkZUcmJ1RmNVdVVYZGxsY1VoY010d0ErOVFr?=
 =?utf-8?B?QTRqL084WTlPYjl0ZW56TFhYcXVFcGp6Y29CcWNWS253RkdGNGhpcVQzaDVT?=
 =?utf-8?B?ZEU0QWpQdmxacWw1elNScjVUd0p6cXJoNDl4Z0lDUEhraldPaFpwNEFuU1U5?=
 =?utf-8?B?N0t6N0JDRTk1c1FmeTY4V0JreDV1NGdzZlBsSWwrOXNTUFk4amdIck91VnhR?=
 =?utf-8?B?WHJDWjFsMk1MYVZ2elhGL290dDA5TlV4WXJXN0VKaFMxYXpieEdPbCs4OG1K?=
 =?utf-8?B?Um0zVHBZYmNIamljUnIySU5sQUhvM3lXL3pYM1VMZ0tDS2J6a3E1dEsxZHps?=
 =?utf-8?B?NzJQRVdsa2NtWDR0S1ErOUFsUDZLSjgvZUNaR2JxV214MDRCUzVZc0s1a2Zw?=
 =?utf-8?B?RHVlV2p4Q2RoYkQ0OENOZm5tVTUwYjZiaGhyTjFqQ2p5VHpoNTk0a3FlcHNS?=
 =?utf-8?B?aUlMbGJjMXdDNUNJWnZ6Mmp2WHJjUitoMGVzQ2J2TUFqUHVvMjFuVTVJYjQ1?=
 =?utf-8?B?cjB6aHJCQS9RbGRrcFpYZjcxUHArSXlaUnNWR2QybEtaV1Njdjcxbno2MDZW?=
 =?utf-8?B?RzRKQWtxdW9CVmlZSmJXQURjVVBRWSttTlUzaERzRE8zeHJDWFYva2xPbTAz?=
 =?utf-8?B?OHZrYVU3N0RLTzk4OEY4M2MvNVBYNTBxVUY5cURWTng5K0w4UmdqMHJtQU96?=
 =?utf-8?B?TVY5cDZ0eDExc1g2NzIvUUY0ZnJna3RFc002dzJrSnhJVit5U1d0c2NjY3pJ?=
 =?utf-8?B?OU1OcDYyaFd0bTBmQ1U1YnQ1NkREQnMzc0hqOFNrOVlEb0JBMFZ5YjlaTUhs?=
 =?utf-8?B?RXAxK2YwdHQ3TlJ4VXcrdVkzeUw0UjdiYXAxa0RXUkViS3NETEl3d1RhQW1N?=
 =?utf-8?B?cGxPRW9zNGFTSTZDUldTVEwwUVdocHY2Yk91VVhpRjlGb0RBS0VLRDBRejR0?=
 =?utf-8?B?N1h2TjJRbWFPSEZmYmFLRmQ1WjJIRWFyQjNNUzhyZ2lxNUZYeS9QK1l0MC9h?=
 =?utf-8?B?bzZodnFHa3hneCs5R3FqekNuc2hNaG5GTjBHOXQ3WFRBOE4vQVdFOU9od1Nu?=
 =?utf-8?B?SWpISlVEZldDb0VTa1hDWldHcDc2THk2ZFdwSnMwNUIxKzM2NnhiTytLTmxE?=
 =?utf-8?B?SGpBcEU4ZzZVcVpGL2dMeDBqNHAzNDNPeWkzVmQ1VUV4SnNSK0FIWmYraCt2?=
 =?utf-8?B?ME1YVjExWjZucjZza0FJWXJJOTNSeXZqQ1JRbEFMU2tFazAxZk8yVlNBcHAz?=
 =?utf-8?B?TlU3MUJ3UnVWeGsxMTBIVG9oQTZ0Q1FzSnRxLzY2ZW5rMFV6NnVMS0hPMHRZ?=
 =?utf-8?B?ekFja2pVK3h0TjFNSkNsN0hJYUNJOW9LTWRaNXFnSGM4aDRKS20xQStmdmlZ?=
 =?utf-8?B?L3dBZTRzMWpiVXZuTVA5V0RFS2Mrd2F2NE9uVGlicEtweHRoMFdveld2TFNL?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3f5664-dd71-48e1-a75d-08dc9adda197
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 21:26:27.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /93F8C/MkU7OLLJkTWdhW9pNekcWYd+xmJzT/6V/GXEEVT81zxn0+G1oext4yOSEq4ryyvh5UA/9pe/cqYzP4rt2iuttnrZ6hQCFW5v8Rb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7045
X-OriginatorOrg: intel.com

Hi Tony,

On 7/1/24 9:04 AM, Luck, Tony wrote:
> +static bool cpus_offline_empty(void)
> +{
> +	char offline_cpus_str[64];
> +	FILE *fp;
> +
> +	fp = fopen("/sys/devices/system/cpu/offline", "r");
> 
> Check for fp == NULL before using it.
> 
> +	if (fscanf(fp, "%s", offline_cpus_str) < 0) {
> 
> fscanf() seems like a heavy hammer.

Do you perhaps have any recommendations that should be used instead of
fscanf()? I checked with stat() but could not see a difference between
file with a CPU and a file without. Other alternative is
open()/read()/close()? Looks like when there are no offline CPUs then
the file will only contain '\n' so it may be possible to read one byte
from the file and confirm it is '\n' as a check for "cpus_offline_empty()".

Reinette


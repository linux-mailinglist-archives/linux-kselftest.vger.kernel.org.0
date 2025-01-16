Return-Path: <linux-kselftest+bounces-24641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8827EA13978
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 12:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02BC1889F12
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 11:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB4E1DE3C8;
	Thu, 16 Jan 2025 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UI49z/Wr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDE24A7C2;
	Thu, 16 Jan 2025 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028330; cv=fail; b=anDYYBeZ3KRNn/RdmztjiM3KZEnYYYEX2HLCF8tPFjFK2Pv5viiGV1OAThvVkUjiQVsn3Kb7V7I8a5wls8Zd/+2Yh6LUVW3G5tAYq0RsGy9+7lBljpV/6Aea+AGkJpr/GIktxl7x8xGw955PRgMfeyNrDINRP27SvnNPAmX25bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028330; c=relaxed/simple;
	bh=OE5CtTgnPz5kMRFru5ou5LJFIrbHOnUHcQl4FvP4FyQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RG0IY7a4nELxqbfcMdU87N4aY5NQOC7K83a3xkfdjS33AxHPJG0UOpycu6/JJamkNZZKxN0mvlseTpOrXBYmbs48j9J2u9QOmzH2K1vWlzN3PFuD/Pz90Lwm8VpiJs6ovXuNeQc6DR8fquUndGPy6K4HCc114XyYsPBD6LM1Av4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UI49z/Wr; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737028329; x=1768564329;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OE5CtTgnPz5kMRFru5ou5LJFIrbHOnUHcQl4FvP4FyQ=;
  b=UI49z/WrUO98Sb9uo5Sm+2TLAKLmXwZU4v0ZcYsJ74TGVd1DrRUrK/EG
   1Vel8Q1qEoGOawq2RZ/zoS7neLWi+V5DuCOVvdY34hb4kX3iK+Z3y20xc
   K8KJDb99krqFkYwQ4X3zgeuiRWBdhQ3m6xvLyO6Gst1XEjmvwWFnHAOtF
   NG/bur7XS6XnIyk3b1Uy5DRz423NE7EOSrVsgkPFmffiEX465MHY5qpAl
   nZNz9N84xFrSuHjMWyd6M2kGmVNeAf6SDDh2Rqc/BzZLFM64v6caA1vVV
   T+HNlvTpru/Oyu/JawD8Eb8T718Tx1pvt2leab1ZeXMUVJGB6cMM4Jqzh
   w==;
X-CSE-ConnectionGUID: 9X0LjMBbSXGWKabNLWbr7Q==
X-CSE-MsgGUID: jQZXP1aUT3uvA4EuoKWCkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="47899680"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="47899680"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 03:52:08 -0800
X-CSE-ConnectionGUID: F5QUCz+eTgepx3o1naTn/g==
X-CSE-MsgGUID: ILyOY3cSSbOx1+r7jarovQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110446326"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 03:52:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 03:52:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 03:52:07 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 03:52:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maKiMcKXZTeFAZlIKZ0Urd95TZpSA1wLGbTuKgc0mTae7kOOXZhkVVo6PizOT1rUdtr1Ikr7wu/GHnTKpPZvx0WsVWNM75WLvAc68PlUSiMWTUc3dI+j1pYNXXD0VlMEFYTz3qH4UDkok/HTt5UEZVoxO8tSnHX3iqu+hrzwnx4WxfXUjnX2+BeHqQ7N/26Hv3tvfDYj2kbY+3hh3I3N4GjZlMWx4vnganx6v39h5hIkmuH+6wAIgIsxi+NaCYdLXTfjUuXYqrVomKVVAvHjgkn+24YFa+MAupcI2I/viDYEy1kdDnq+6fCQfmVEWv7rhYiH+HhXaA4eAxV+pnDgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5cEppIAPodJfGE8SL55xurenCdWWyPHnZacQm+dsEE=;
 b=Z8m8JthcQVzPyHrPSpizBDWdjc0rqg+O4sZuVd7oRjM7y912nRuALA6x9Ingz07MOz6bBfT/ISNY2EefJorl69+Z3nqjT2WrB8+DiAoJt/9r5Cc2SFZ9vXduQlypnZytFwULPUVQLh6Yp+IYxob/Us61Dpk/vq6NkQOtoLC3fo4+A/lPDFOz8DG3ohrv2/HsHVN5Abb8RmeJERDbuASswakuwNgZTjbOqJYgtE7VLPLRUaDJF69/dsNpDfdpaqR2FKJ6SMjCwuIfIfP7G4N+Reqs5HxAl1oRPISjOCxrtSPc8y7e1VZchTfRrWWuSGJtYQ84XBm2h8g93VAvauodDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB7278.namprd11.prod.outlook.com (2603:10b6:8:10a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 11:52:06 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 11:52:05 +0000
Message-ID: <3c522b9c-703c-4aa0-82e3-d7f9fc8d4480@intel.com>
Date: Thu, 16 Jan 2025 12:52:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: give up on the cmsg_time
 accuracy on slow machines
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
References: <20250116020105.931338-1-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250116020105.931338-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6533fa-ee92-420e-3498-08dd362432d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHh4NFNzdm5SanlhWmJ0WElzZVVOVWxDOGtJMWZncytZU2RpcURPaGFKUitt?=
 =?utf-8?B?bU5QUWd1TllOQVlLMlN3cWZpdVYwS2FkYmxtcmRwVFFtL21TNExVL2NGMGVz?=
 =?utf-8?B?WHhDSDkvVzJqdys0eUY0a0UxS1NKeUc2akdrZkpoVGg3VldHZ0N6ZHZadFJT?=
 =?utf-8?B?ejF3U05KVzJobkhWM2k0eW9VVTJiTHA4Ymt3NWtkKzRyaUppbXNrL1grVmxz?=
 =?utf-8?B?a0YwaHJmdE5lNWU3V1l1VHh2bzUrVDFBcVEyUi9aSm5yZzF3MEExU21JSlpy?=
 =?utf-8?B?aFhIL01nT0VuNjFpTENiRUthNURHY3J2Q2hHMm5GaDN1OVdqT0hoNzViQ3kz?=
 =?utf-8?B?T3J5dUd3b2JhNERHMk5iRFl4QVV5MkhoeG5HM01xOFZxV1dWUE9sWWdTVTNh?=
 =?utf-8?B?bkcxS2N1eXhoTzc4emR1M093RzV3TmRXajUvKzZ1ZVQyVmlsYmRkUVVmMks1?=
 =?utf-8?B?b2g0Qk5mS2diVmdOMUhaT0JOM053NEpRMG5UalFiK1orNFZaWWZvQ3lCZEd1?=
 =?utf-8?B?QjlNQU81UkU2Zm5jRFJBem9YN1hiTi8zQ2JLYWpNU05ucXNNR0dLK3pjbzNj?=
 =?utf-8?B?WVlSZW9Dck8rTUNTdHYrSkhyZHl3ZGtwMlJveXBjSDhpR2xyQWllOXh6TklG?=
 =?utf-8?B?N1hhaFhQWWIzQmFkWml4K1h1ZUtOczNMNFBOU3k2aENLRlQ0ZlIxOFc3d2JE?=
 =?utf-8?B?RXhtb1ZiZVE2R28zRUVRNDArVFY3K1NJM3J1c0VVSmo4OTR5aFNhZkluQ3gw?=
 =?utf-8?B?STJyTnZhbE1qdlh4VE5LczBKcTh4ZFZKZkpGTnR1cVZEbm1xL0svbEJTU2Mw?=
 =?utf-8?B?TFJyS1FCMkpEbisyV3BuYXZYTEFWZEo1Y1V6ZFc5ZWRCVEpoMUxFM0hiNUQ3?=
 =?utf-8?B?dTNXK0JUVE9ZOEdJaWFiQmRncHRwdC92REp1cFVVVXN6WU5hV1djWTc1NXE4?=
 =?utf-8?B?ZDhEYS9RS1lrRFNzL2c4Y3QzM2NPSjFTZkdWMHYyZThpUlNxaEJFeTZPd3ZX?=
 =?utf-8?B?UURjUzVsK3BaNlovMlI4RkUwZzlQRzV4cktrK3RDUWpUVlRvcjlyblVmSk52?=
 =?utf-8?B?ckVKYWo0bmhzbzRudHZXNmpoU2xyS1BueU5aazgvbEhxVHpkenM1WEpKeGRY?=
 =?utf-8?B?ekhwWU4reFBza2dVNUhpMVBNai9WNWRDZnZDUnNIVU9ubGd4N3VkRXk1STJ5?=
 =?utf-8?B?MUlKNWxkYkU3Zk1HSWtSUDVwZkZPWklXb1QzbWJYYnhhc0JLZk9yNXlZQWRk?=
 =?utf-8?B?dEZydnVDYUlGbnNmZldzZE83OHBXZkFzZWNxZjB2U256YVJIeHU5aUhRazZI?=
 =?utf-8?B?UHpmWEZIRCswVm94Z0VtY050QUJJbElXQWhWQVNaOGVwVnhsMC9qZ0s1ODlB?=
 =?utf-8?B?ZEdaNHROUU43QzlNdk1zNHlWejRjVWRheldxa0FjY2VlWWVHVzkyVFdQT2lY?=
 =?utf-8?B?QituV2dxVkp2WGo2WXFJYVFmZ3U1R1hFeGh1aEVQWDR6U1ppZXNONXcrcG9T?=
 =?utf-8?B?NTB2dVZ5YlNDeDM3aUxoZC83U0RPUlNiMGM0TlkrNnFvL2ZoRXg5MDdoQkV2?=
 =?utf-8?B?RVF1Y2lJYVpxU2dGTTgxVWVpNDVKZDdOUkVlYUNaek1CQlNWY0tseVB1N1J2?=
 =?utf-8?B?djErcXROTE45Q1RFT1dlQ0ZDZUdWTm41OTl5U2JMTENvVnFEa1FCd3VnY1Bk?=
 =?utf-8?B?WHlLbFAwNDBOWTZKZGJGUGNyc3lnNTNGeC9uS3VDMWZFYnRqRmtpTlV1d3lV?=
 =?utf-8?B?NDBiUUhRa1JhcFVzTCtaR0RVQm54bFFkbEZiMzkzZEtzT1hFSU9ESGVRb1dm?=
 =?utf-8?B?VUdvL0VRaUkvVDlCNWt2bXh6TDZ2SC8yTFhZSHA3ek9UWDhSTGh5YmJmMlF6?=
 =?utf-8?Q?t//lmBVROPSqJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emtLNDBKd0EvRU5IeE5xaU0veE11L0NHWXdvK21Rc2R5cTdKc1Fadi9tUkxM?=
 =?utf-8?B?SUdha2ZvN1BMZG02OE0xMnlacUcyZm9rWWNYUVpaYmZaMjdnU1FlTGVmWjAr?=
 =?utf-8?B?c1FJaFZwdUpxRVRPOHlJUWFvV3ZCSFp6dTBDUVRjcjhENFk0ZjFwaGFtdGtt?=
 =?utf-8?B?K3JpU2hnMHpTdndyTGV1WkRuNmUyVHFaK3plcmNnMGU0YUdqTkZmSVNyOG1r?=
 =?utf-8?B?aVVMTXhQZTAxdjlnMmtCSFlndVFVcHVDelcvbXlDaFIvZXRaVGtGN0FuQUVN?=
 =?utf-8?B?YmxlYTZVSnhWNUpNRFpzZEJMcW5iRUsyZ0N0N255cHNadnRIMGdyUmJKRHY5?=
 =?utf-8?B?ZHR5dGRqeGFpR1JYRDgzMnZUbHEwczM2bHBJeTVXYm9EQ1d5Wm1CbFZjWEtj?=
 =?utf-8?B?UlNzeTZTM3k2S05IcFRidVlEL2dPUFFMVnNKTmlmSDZtTnoweDFwbngzNnF4?=
 =?utf-8?B?d2kvOUpwWEtRdUhFRTBOY0FicmZObGovY2RRdzluNWEyZ0JYaFBydEllKzBi?=
 =?utf-8?B?ZS85ZUpxdGxxdDR4U1k0aWZuR0xvTUhjK29Bd25wVS8wYWNvV3VXdytudUtU?=
 =?utf-8?B?c0JIZTBDYWNVT3BXREtwQTNEOUtOU3E5Q2lCU1RISk9DbnErYzZYZW91dnpa?=
 =?utf-8?B?YTQ4NS9lMG1tNTBLSDVCVk94bmJvYkc5ZXRGaCthWEg1RC83LzRWNVcyVXhW?=
 =?utf-8?B?VjFEVXlPZ1c0SXdJSWFsUjZVMHgxSTlPMkZEQnFKemE0YUtTdUVPZGtoUnBs?=
 =?utf-8?B?a1lmZnRpck1DSEJzbmRjMHdSbEg0cFhQa0lZUzNXaXFyMGtINUd2TnlrSmVn?=
 =?utf-8?B?UVB3WWRBS2cweG5rUDRRRGpXOHRHc0RWWHdBSkNVK1QwbGpOT1dleGYvUkth?=
 =?utf-8?B?aE11U2p4YWlDQnZaaGsrTVlnYVdpK28ybzFycWRxT1B1dzJ6cTA4bEpzak9L?=
 =?utf-8?B?V3JNYVFNTzZCRmxEUkVrMndMM1pCSkZiMExRSzh0SCtWVlQxYTdWbWVscWw1?=
 =?utf-8?B?NXZ3ZnpTR29CSFNIellKcVoxN2MyYmhqaENJL0NrUjhiajhaTXVjU3FCcS9H?=
 =?utf-8?B?UGlkNWJzVm5ENitIb0pGVHJ0OW03UGhldnlWbmxhN1ZPT2hqZkYwMjFMWm5P?=
 =?utf-8?B?WmpJQW5aeXl5MFppOFZHNk4zRjA2U0s1cU94UmU1c1lvUWo2MlkzZFdzYmVo?=
 =?utf-8?B?MjR0V2FTcmkzaUNBZ09KSkpTOGZCTEloSEJxU0Y2L1F4bHFOMDNnMVpMU3Ar?=
 =?utf-8?B?RGlCeklaUUN3TmV0YWw4K0toQXdOajBtMXFkTWVYQXN2a1I0VSsvWlYyakF5?=
 =?utf-8?B?NE1XTGg4MFErTWFqRE5HWmJpOTZvd2hnZGdSYzFyT2hUVndsWThwZDErbW9N?=
 =?utf-8?B?SC91TEV0M0xBVjdEYWlXTHRROHNqMGovaWpWTkIrS1dlTXFUK05OdDl0SDdS?=
 =?utf-8?B?VkJtcGtET25zZGVqaDJYK1llTnZaeFlPbmpDbDlBa2I5UGpib0RzTWo4d0Fa?=
 =?utf-8?B?emg0WC9aclR3V00xQVU1SmpxeGR4dzhadWk3V0tUZGZzUDVwSDhWYnpFcG9Y?=
 =?utf-8?B?cysxZUg5UTd1ek1ZRzMzZlpyRWVOKzYvcTM0bUpPU3FXY1ZlczVSUXhFbllQ?=
 =?utf-8?B?ODdWYUtCVHZrdUZlYTcwaVdpaXEvNG1rVC9saVhvU1RVaFNocDVWZHdabW9E?=
 =?utf-8?B?SWk3djlEU08xNmoveUpmNEl3bExaUTNDVHBBZGxmaEVtWkszVmNMU2xDU3NC?=
 =?utf-8?B?Y0VTalduaGhKa0poZG5kUEs1Q1IxNXd4U3NLUVJLZXk1TVY5QUc1YnVpSzVs?=
 =?utf-8?B?bXh1eXVBU2M3TXpnd0N3WmlwR2pJdkEyZFZVUEhneGgwZisrTDlzTnhlV0wv?=
 =?utf-8?B?Y2NNWFk3WGpkNG82UmdyakNrYURCcHNMSjg1YkFEZndIeVZwS3l5K0taNTA5?=
 =?utf-8?B?eGE2T09reGU3OWZmdU9KeW9RMTN2eVdNN1VvTVVWV0FhU0lDZFRXRStadHY0?=
 =?utf-8?B?MTdtVHR3SDQvMnNZb3BpVEFkT1hJNS9OYVAvSjFSRHlFQWZzcDNHaDBETHZN?=
 =?utf-8?B?eDFmZlROYlFsbWZEOWNMU3ErWVJLSDl0SDA4K1ZYejY4bTRaRXo4aTFyblIr?=
 =?utf-8?B?QmhtZXN2MzAzaGNybkI2L2Q5ZUc1S1ZHbGt5RDdzWTJnOHBPWDZGRGVnMkFV?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6533fa-ee92-420e-3498-08dd362432d1
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 11:52:05.7642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQY7rF++ACntEk6tVRyPl+aVbjZKDP/mvcOtnUW7FriJdPnZNryv0qhmKklI1bGl/whxlM5BkvIBz1wcY+qsWfLj3Kwl2j67InrFDPcBwp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7278
X-OriginatorOrg: intel.com

On 1/16/25 03:01, Jakub Kicinski wrote:
> Commit b9d5f5711dd8 ("selftests: net: increase the delay for relative
> cmsg_time.sh test") widened the accepted value range 8x but we still
> see flakes (at a rate of around 7%).

you have undid the 8x change by this commit (without mentioning that)
[fine for me]

> 
> Return XFAIL for the most timing sensitive test on slow machines.

code change looks fine for me, and does exactly that, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
> Before:
> 
>    # ./cmsg_time.sh
>      Case UDPv4  - TXTIME rel returned '8074us - 7397us < 4000', expected 'OK'
>    FAIL - 1/36 cases failed
> 
> After:
> 
>    # ./cmsg_time.sh
>      Case UDPv4  - TXTIME rel returned '1123us - 941us < 500', expected 'OK' (XFAIL)
>      Case UDPv6  - TXTIME rel returned '1227us - 776us < 500', expected 'OK' (XFAIL)
>    OK
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>


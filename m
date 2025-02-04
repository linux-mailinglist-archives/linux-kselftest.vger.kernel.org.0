Return-Path: <linux-kselftest+bounces-25677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF52A27268
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7393A2A63
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5DE2144BC;
	Tue,  4 Feb 2025 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7MPZVE5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A502144AD;
	Tue,  4 Feb 2025 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673346; cv=fail; b=uj1aaK3DjOcxO7VUN51sJhCMhu2DGmTrjPaJQn8RrosvvODY9yIJxz+zmy0dQhmQxlfLBWFrY/jN5sanNqHsg9f9gXcQFyEUyHMPDnL98ttUym7Iq/NwuCirJeR/DSCf7nTIic7UIfEz+7QDi5icJ6ns41u0zE+8mCclp2Amxdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673346; c=relaxed/simple;
	bh=UrVjAMox813mSOsEuNUhrDNRSluAaagH9WL5Jodv/iA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=meam8+LOVjqlAIvVDXspGIz9Rk9PEsMLrhO1sGg6Znf9i0PzD2r4GBoruNxa4aex9EJQD5OwOQ/1taQYCnl/zkSaPTPQ0WZMtkOGox9vRb1c9h5TUgPLCDYK6WHwY2d+zPj9ZadBRYiBLfsgxl9UZBHepUD5pFDnT/6Xyoy4Fwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7MPZVE5; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738673346; x=1770209346;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UrVjAMox813mSOsEuNUhrDNRSluAaagH9WL5Jodv/iA=;
  b=R7MPZVE5sE5iQjzSEH68jFd5thsbGM4wCSgI9NzThzkXWkAqkyEKJ6i9
   W/m8Dfs70OKMs3qC3IJbOYf1UAKHptVGI9Wd+XMAp5NtvCwMiIHxqwYts
   Rp7lFyyzUBABm+MYkfTR8EiNLdpPIZmk1TQmZMQ4+MjP1nZ84ZkZWgwBR
   1rVRCp8eQgz7C3sjyNnjG2M6A76VYiYc9nKj1rYMRmFQDv4qKSDJe4c7l
   AFt2wdery9Z8gTloQy0Tk+zaqK0niv0yN5O6nRsrW4gRf/YtZD/bpv+9F
   2GD6bVU1ctjHCbfxJvG74erABArh88CMNaHt9pOvdZYS+Ua5EDbiV0Rz1
   A==;
X-CSE-ConnectionGUID: KQZrTscARiC/jvu2BTauAQ==
X-CSE-MsgGUID: OznT2x/1QJGm61/D0iwamA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42852929"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="42852929"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 04:49:04 -0800
X-CSE-ConnectionGUID: MDuvnNO9TG6Mxv3nE+v5Rw==
X-CSE-MsgGUID: sCESRbISQNOomIJHeJwU3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111441798"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 04:49:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 04:49:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 04:49:03 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 04:49:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/uoc4nhL/A/1hPBjwESo+Cku+WlUqdHQ2sTa/jQ45XCHHLWr2DlGuEY/Q3WDLbQlxE3HqAtouOA1xzCG3g0846+P5EnQT/QFqslQC3hpSTYkSdg1rzP47B3nXQxo8nfUSU9vGvrKBXYm9LtJcuL9GLd9F+UIX30JaiYtH81BnHxh+UFf+njmzQZwCzSpbW11out3CjO7cUmE1ESuOWbL7TK7nxZakzHyNbWd92Op/qdEah357xWb2DBqYLCLaSiipmIWOmUFzF+waXk0f2w4Gy3pZF4oXqevkBbdN29TfQ/Y38FjP4KWqk6Lma8P6ymgj79TIsOjUGTiDPikCigPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqlNDCfOpqha5n1WBGE75G9fw6/TCuKfPE5UEiT3xlU=;
 b=oidZw61opFKp89u0fqZufx3I6XFMn8bLpZkB2QFp8tZ51diYhCFnKFt+uyQaLV6HIDwfToebluCTym1FrJCtFYsZbPfT0wvnw/9QIBriGsOcUaZmYEmE+jfmRDy3C0ClW2TV58yyO5a5rWXSlU/keD7MD36LhPSMWD8TjMTgK9tuX0mP6nEnHrQru2IUuvtmX2DvSMpAz3Ieqf8eo5kS6MY5NqQ5i1lgxwPBXT72QCQgUdD9UBBnfWXYSxY+f4gNXUZqbvEdNugj7imWE9mm3NbPi7rZVfj9+k3KMruWADUcbUViJQ2DSFT4C2S8U55+24KbaARt+jD67m36WcM48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB8159.namprd11.prod.outlook.com (2603:10b6:8:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 12:48:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:48:20 +0000
Message-ID: <c9e5e1fa-492e-463e-8f53-0be6a7ec2ab8@intel.com>
Date: Tue, 4 Feb 2025 13:45:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: Fix mix-up of 4096 and page size.
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>
CC: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Hari
 Bathini" <hbathini@linux.ibm.com>, Andrii Nakryiko <andrii@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z
	<eddyz87@gmail.com>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>
References: <20250122183720.1411176-1-skb99@linux.ibm.com>
 <CAADnVQJcmyMmxPfSaKgqMiCDZP=Pe8-Jf7NnEdfgxejvZr+44g@mail.gmail.com>
 <332c50f5-3c68-4fce-8bb3-161f76f2119c@intel.com>
 <Z6G6cBP2YPmNyk+s@linux.ibm.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z6G6cBP2YPmNyk+s@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f37f6c1-ca2d-43e5-4654-08dd451a3434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFZNaUFQSHJVaW1WUDhXdEtLRFY3aS9yZGdsVlh4MlR5dWlJa0MxTTgyZDhI?=
 =?utf-8?B?NWpJZUNKdkVPdG5aWkc2Qjg0ZGJQOGk1amNpZVVieC9QWEowWHJIelB5YjFQ?=
 =?utf-8?B?UTEzNDJuSU9JTWtaZDQ3V2JpREdLU0dWcE81ajNKeVltenRWNE1kRUo3dytL?=
 =?utf-8?B?QnpVK2lZVzMzVEU1K21WeFI4Vkt4eDVqclFvMC9FTFptbFZveHk5OC95VmpW?=
 =?utf-8?B?WnAxV3RRd2doQW9odTZpbG5RVzNQaWpiTkdkMWsvenMxNUtEVllKREJZSUxh?=
 =?utf-8?B?UmdCa3JjZ1VNaDNmUjlZb0l2aFNCdmZ0ZTRkZmY4cHJuOVB5dlBEb3Z3S2ZY?=
 =?utf-8?B?dFh4NzRlSkNXVDZvTGpCRU1qaUkyb2hTaHNlV3ZxeUFSUUZiNlNDYlFxckZs?=
 =?utf-8?B?elM4NlZDNVBvdzh4RFlUeklqRllyTWVOMEFhdVpmaEdPS3MzUG5XUzhDaUIz?=
 =?utf-8?B?UEdJOTRVTDJsVzd5VVJaMkp1c2Ruc3NSckVmVUtucTBqaUtTS2dFUkkvT2JL?=
 =?utf-8?B?MW9Cd3Q4QmdodVltOHBuZ29aU1ZUQkRIRHVyVzE0dGVaTmFuV1VBL1lteHRm?=
 =?utf-8?B?VWlGQmVZRTNCY0kxNThJU2paYXU3YzBGU2hEdXpVSUgzaGdXSWViM3plRHU1?=
 =?utf-8?B?Z3dyNGRlUWdQdldJSlU2SUNYRllXaVdoazE0UTVtMmRSTmp4dlpyK3FHT0R0?=
 =?utf-8?B?K3lFUEoxa1pNUU5iY1VLQzZNMTZtQmRhYzQyYTVzUzhreVdybGlYZFZSa2NX?=
 =?utf-8?B?N0dkZDFrSzlsd1U5THptb3FBNWdWZW5ZN3RnREZWajU1QjRsanI0akFFcG1w?=
 =?utf-8?B?Y3RWUUxhaVlYblE3cGcrWHM5dDdUNm5lT2VjN1FkbS96RFlkNW56Z1lwV1dE?=
 =?utf-8?B?akJqU2RXMmFhSzdVazc5cUNOcmNySGJQaWtHL2VKelR2cTQ0YVlsWEVmRTlU?=
 =?utf-8?B?VVcxZk5NVWFxeDNMUEY5bG5XWGlEbE1hc3VEYkNHZ1JmaDUxYXh5K0NINEtR?=
 =?utf-8?B?MGVObi8xalR1YWk3bFFGUTJ6UC9LZ213am1KK3IwdE9hTWtua1JITE5ZVFVK?=
 =?utf-8?B?dEpYNVN6UEIwZ3lXeStXZUZLUCttNmVkZDhvR3RKbnZRN2REaUZZWitXVERU?=
 =?utf-8?B?RkdNM0FvbURuR0tYMng1dlU4VjNUcnJ0WnJwc2tKcGlOZjVjRlREd21ERk82?=
 =?utf-8?B?L0V5UFhEL2xYSytwZ3puSURyMXNqSitqU3ozZGZEYitMYmpQRVJGWWw4ZWp4?=
 =?utf-8?B?ek5Jc05KS0JZR2ZRWnk0WFlhU1kyQW5HNkpKNVI1ellCMnZkTmVPWGNjeThT?=
 =?utf-8?B?RkdMbG1CL1dnZ1EwTER3dE1pVHd3cU1kZytFYkpsUVhUODRBcUxESkJ6TmFF?=
 =?utf-8?B?WnMzSWZxakhIQmRNNXZqbUxxNE9ramx0R0V3OXJHNzM1Nmk1TUNhNG9ZT3RT?=
 =?utf-8?B?cVJ4Y1ZsWm11bWlLdStWM05hQmQrcUQwd3QxblBKd2huYlpDYkxobXhVK21v?=
 =?utf-8?B?ZTdwaG13S3Q2TDY2STM4YXpKd3FVMHRxUWEyNzN1LzgyVGtxS2RlQkxJdHRN?=
 =?utf-8?B?ZkJqVjRtNXJta0htZnJWZ2Naemg4aEdheUVFdjY5UGxHZUJqN2VEeklRZ0w3?=
 =?utf-8?B?SlhzYWtTU1lsZStreldnSlNNQVI3U1hMc0ZrODNvcWFsNk9MSWkydEZiVFJz?=
 =?utf-8?B?bHFmTndsZW9ZWXRRRDF6QjhwQmN2dHBXaEtqd0tObnJmZVhkd0lnZld2TDVs?=
 =?utf-8?B?ejhxRXlhaGRFOVVvWnVMNjhPVTgrbVU2N0wvenQ1TldKYlY3MHdVRzNMOFVJ?=
 =?utf-8?B?cFM2TG85T1BwcTdsVkYxbjZEMys5Y2JmWGIxUEU0Z1dCTVpJTlIzT3UvbVMw?=
 =?utf-8?Q?SAXK/ScrUvBO2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGdITmQrRnhTeUhHWUdPQ2IreERwYzd5bTdDSG9aTVZoeThDN0tidWFuS2l5?=
 =?utf-8?B?clVVbW4xQU9IWDRiOVFqRWhIWnpQSnRUR0swOUhBWmMyMjRFdS9rMEp3b3FU?=
 =?utf-8?B?SkJDNXM1ak1ZcUNFcm9LMnFITVFNSXNXd25OUzVINlppZlVrcVF6andKMEFo?=
 =?utf-8?B?VDJaOWptMlhMZUs2NlN2RkJTNnJDbTBhanhmM3VBZTM1SXFGWHAyMTVxc1Q3?=
 =?utf-8?B?VnlsUTZBdHlRWTZjRjhXZnhFMWt2eU95aXlsWHJTV0gvZzJhbXAxM0JJeHlP?=
 =?utf-8?B?SW9SWWlSRHM1RFJCYUUrWWNkWnlHNTlkWkF1dGsyWHlyTjgwd20xTGxZenFL?=
 =?utf-8?B?aXlaRVRwRHVhdURadnZTR1lJYWFGdEtZbFhtRDlHd1lBKzViQkpYY3VGaUVQ?=
 =?utf-8?B?KzRSM1dQdFo1MlBDb01HOXRBNk1MaVcrcU45cWo3OXplMUFpZ2RmaTZqTXk1?=
 =?utf-8?B?V3Ywd1ZiVHdIbXRGZVIxbXg0WEd5NWxvUmhrR2RyRW5xNkZNUG8rSTNvMTlM?=
 =?utf-8?B?R0hsOHRYWEt3V09YaGlTVGxFTVR2ejdEUWh1Qm04bEwxZlpkSVRvTjh4ZUQv?=
 =?utf-8?B?MTVPZGxKVWJZaU1aQkpKQUlxZU1qZml1aFcrMTdCQnRBNjJpcW9YWWpMTXpY?=
 =?utf-8?B?SFM4bDdRelVvUTBnV0JtbEJrbXpkMVl1TmpNc0QxaW5IczhCbDZ1bzg1VkZU?=
 =?utf-8?B?bzBMa08xalRpTmpKSVhEVXNIU2lyeldUeGp1YzhiVWpLaERFYVlod3B2T3NL?=
 =?utf-8?B?MzVSSWJMT3pFZmFHMEt0UjFOTnR2OXpMSHNnT3Z6T0VnWXZUeWZtaHcreW0v?=
 =?utf-8?B?MFh5MlRBdDU5b0h5ZmV1VmIyYXNuL0NqQ3FpVnNmek1nMDZzV3VxdEhOMlps?=
 =?utf-8?B?dmluNkEzZDNVSWJsWHFVL0Z6WkhyMXhIQXR4ZnZndXk4K2Rnd0ovaVpiSE5v?=
 =?utf-8?B?OGVsNnNDUmZBTkJJNVFnS2Q5T2ZYdy91Z3BrYU5Ycm1IVC85MElVNkdzQkxO?=
 =?utf-8?B?eVlaeWgrYklZNGQ0TjhYZTMzM1kvaUxQWUhoUEY4QnFPM1d5QnNyaXh6ZDIr?=
 =?utf-8?B?SytnQjJBRW9TMWRGQUJnWDZ1ZEU0YkttWVdSQUttRHZjWVhHc3dEbHdNc21R?=
 =?utf-8?B?Q3ltRy9aUmZ6VVc4UExSWmpzVzl5OG5vWldjZkdKOS9PM1JmVjV4T2NySUxW?=
 =?utf-8?B?K0s4QW9TYytyUkNhaEsvc1Q0eG9zdHVlQk0xejNBL2o0QXZkUVpNQTZrTElw?=
 =?utf-8?B?dDg4VUhZbjJyMHQzSTRiSG1zS09mVFYyRnVya1BsUkdjekxjeXRqaXFFODJa?=
 =?utf-8?B?NVBDVDU3SVI1VWlqaHNFeitCZGZSRnAwUXEySm8reFN1aFJYMDg5WnliZllF?=
 =?utf-8?B?aUVHRlovMjFzZ2x5em5UZ09CR3d4MlA0eU43S2xEOWFsZmNUUkhoWVFaOWhq?=
 =?utf-8?B?anVIUGcxMU1JWkVEbURDVkVXZFFLUm9ua2NtYVhLSVV4SHhZZXJseUhPY0Zv?=
 =?utf-8?B?eGdyUnYrdldXVmFkR2RpNTdoVW1YMk1vbmQzaEVCNmZ2UkNpdEIzR29Obmcr?=
 =?utf-8?B?Q2tjOTEzaDc5c0FWendNbHF4M05KMXFyK01HUmFrckVVY2JBVXZBMVg4Nytm?=
 =?utf-8?B?V0t6TzMxUTE2SVBDZy9qa2VicEJLbEJERFVQa1RyM1ZNNGszRWRwcE9iQS9G?=
 =?utf-8?B?WS96WkdsWDU5dWYxK1drTHlxV0dKNkRGRDBnRkZBSE9ldDcwUkI5QkRLaWhW?=
 =?utf-8?B?b3BkRWVzSUdRNXhmMGhOVk0rUWo3QmprM0tyQnZCZkZ1ZndtVFNFUXpoWDY5?=
 =?utf-8?B?c3p2NGlRN0U2Q04yZExQOVJxOXdkK0NzUzRIclc4c0JKanFMbFJoL1UzZWVs?=
 =?utf-8?B?TGZkbnkzZnNsVVIrNEpiOFdrRnN5SnUvZ3VrS3dkc0lHSThPb0JlNDc0R0VH?=
 =?utf-8?B?NDltRVBGRFF2a1V0WVkwOElvYVJaTU0ydUw1cWs1NGFnTlJzNDRiL3ZUVW4w?=
 =?utf-8?B?OWY1WFVXcS92VVRpNklIaE53ZmxnNkZJdHNrcFlhMVo0eWJqa2E5N3NTUFdQ?=
 =?utf-8?B?NE1pR2piVXZVcC9sTk5lWVorenZRaGcvejJEWEc2V0d1c1poTEhrUHgyWXJT?=
 =?utf-8?B?dXg2ZTF5aEVsdnVPbGZ4S25vMUpPb2QvRnpIK0ZSeHI3dDRaSjhLc2RPTy9w?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f37f6c1-ca2d-43e5-4654-08dd451a3434
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:48:20.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vef8RLRF0tBM+Hcixmr3T6Wn/fUCET6U8Hk2x2nyhGVuIhfUZFasHd9KWaE/uCCKPhR6vEDlZtffFYJKl8TZouLqCxbqR/GGJq+LjchhREI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8159
X-OriginatorOrg: intel.com

From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Date: Tue, 4 Feb 2025 12:27:52 +0530

> On Tue, Jan 28, 2025 at 04:03:11PM +0100, Alexander Lobakin wrote:
>> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Date: Thu, 23 Jan 2025 21:14:04 -0800
>>
>>> On Wed, Jan 22, 2025 at 10:38 AM Saket Kumar Bhaskar
>>> <skb99@linux.ibm.com> wrote:
>>>>
>>>> For platforms on powerpc architecture with a default page size greater
>>>> than 4096, there was an inconsistency in fragment size calculation.
>>>> This caused the BPF selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow
>>>> to fail on powerpc.
>>>>
>>>> The issue occurred because the fragment buffer size in
>>>> bpf_prog_test_run_xdp() was set to 4096, while the actual data size in
>>>> the fragment within the shared skb was checked against PAGE_SIZE
>>>> (65536 on powerpc) in min_t, causing it to exceed 4096 and be set
>>>> accordingly. This discrepancy led to an overflow when
>>>> bpf_xdp_frags_increase_tail() checked for tailroom, as skb_frag_size(frag)
>>>> could be greater than rxq->frag_size (when PAGE_SIZE > 4096).
>>>>
>>>> This commit updates the page size references to 4096 to ensure consistency
>>>> and prevent overflow issues in fragment size calculations.
>>>
>>> This isn't right. Please fix the selftest instead.
>>
>> It's not _that_ easy, I had tried in the past. Anyway, this patch is
>> *not* a good "solution".
>>
>> If you (Saket) really want to fix this, both test_run and the selftest
>> must be in sync, so you need to (both are arch-dependent): 1) get the
>> correct PAGE_SIZE; 2) calculate the correct tailroom in userspace (which
>> depends on sizeof(shinfo) and SKB_DATA_ALIGN -> SMP_CACHE_BYTES).
>>
>>>
>>> pw-bot: cr
>>
>> Thanks,
>> Olek
> There is a mixup in kernel b/w 4096 and PAGE_SIZE and all selftest seem
> to be based on 4096 as the size, so I changed the PAGE_SIZE to 4096,
> but if we have to use PAGE_SIZE we need this change in kernel.

I know how it is done, I was working on adjacent code, that's why I
spoke up and told you what you need to account if you want to fix this
properly.

xdp->frame_sz is hard buffer len, usually in range
[PAGE_SIZE / 2, PAGE_SIZE], and it includes:

headroom (XDP_PACKET_HEADROOM + some drivers reserve NET_IP_ALIGN)
actual data buffer
tailroom (SKB_DATA_ALIGN(sizeof(skb_shared_info)))

So to determine the actual data buffer size, you need to:

* know PAGE_SIZE
* know headroom
* know tailroom

Hardcoding anything from the list will lead to selftest fails.

> In place of PAGE_SIZE 4096 was used here:
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 501ec4249..6b7fddfbb 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1251,7 +1251,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>                 headroom -= ctx->data;
>         }
> 
> -       max_data_sz = 4096 - headroom - tailroom;
> +       max_data_sz = PAGE_SIZE - headroom - tailroom;
>         if (size > max_data_sz) {
>                 /* disallow live data mode for jumbo frames */
>                 if (do_live)
> 
> Assuming that change in kernel we should also update the selftest to 
> 64K page size for ppc64:
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> index 53d6ad8c2..037142e21 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> @@ -226,7 +226,7 @@ static void test_xdp_adjust_frags_tail_grow(void)
> 
>         prog_fd = bpf_program__fd(prog);
> 
> -       buf = malloc(16384);
> +       buf = malloc(262144);
>         if (!ASSERT_OK_PTR(buf, "alloc buf 16Kb"))
>                 goto out;
> 
> @@ -254,12 +254,12 @@ static void test_xdp_adjust_frags_tail_grow(void)
>                 ASSERT_EQ(buf[i], 1, "9Kb+10b-untouched");
> 
>         /* Test a too large grow */
> -       memset(buf, 1, 16384);
> -       exp_size = 9001;
> +       memset(buf, 1, 262144);
> +       exp_size = 132001;
> 
>         topts.data_in = topts.data_out = buf;
> -       topts.data_size_in = 9001;
> -       topts.data_size_out = 16384;
> +       topts.data_size_in = 132001;
> +       topts.data_size_out = 262144;
>         err = bpf_prog_test_run_opts(prog_fd, &topts);
> 
>         ASSERT_OK(err, "9Kb+10b");
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
> index 81bb38d72..40a0c5469 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
> @@ -27,8 +27,8 @@ int _xdp_adjust_tail_grow(struct xdp_md *xdp)
>                 offset = 4096 - 256 - tailroom - data_len;
>         } else if (data_len == 9000) {
>                 offset = 10;
> -       } else if (data_len == 9001) {
> -               offset = 4096;
> +       } else if (data_len == 132001) {
> +               offset = 65536;
>         } else {
>                 return XDP_ABORTED; /* No matching test */
>         }
> 
> The above change is intended for feedback. The date_len and other 
> values in the test cases can be adjusted to be based on the page 
> size, rather than being hard-coded, to ensure compatibility with 
> different page sizes.

In the code above I only see one hardcode replaced with another one.
Note that PAGE_SIZE == 4096 was hardcoded to be able to run selftests
on x86_64 in the first place. If you want to enable them on
non-fixed-page-size arches, then I mentioned 2 times already what you
need to do.

> 
> Thanks,
> Saket

Thanks,
Olek


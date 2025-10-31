Return-Path: <linux-kselftest+bounces-44490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FA9C233BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 05:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C2F94E1B32
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C170D29B77E;
	Fri, 31 Oct 2025 04:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWlAxK0d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94DF1F5842;
	Fri, 31 Oct 2025 04:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761883589; cv=fail; b=WdnxPSW+Yevzu0leF/21XlHTL0hZT+pfs88YpiRQNc9eGRRpkF8TXFm6Q2hYCPrhNAHokWAfIqKSWekSVnYyNj33CtqQYEbmNEjExRvkN7ipd5GsmqKrzqMxTZLD0JLpvwRrF71ht0VwA6jecSvUDvAphTfBMKPDUQ1PKfK9MXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761883589; c=relaxed/simple;
	bh=AONr2dyRtbFIqmasThxMDgGBW+J9BnZrrhjp5xv4k0M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pyYdQJ0Kq4r8wDVmvtcpMtLMDmsVlDZlomAynL6qu5yfR5Rre4R0crbotleFjKPAwIBVsK3fNemSx5tzsqjKhzGtizjFU9u0Px+EgFbuDUxahwgk3T+SZy66/83ihcXAxXXAeI83vqHzc48bP+mZhXDwbyrHl1jypVf6NBd+/HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWlAxK0d; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761883588; x=1793419588;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AONr2dyRtbFIqmasThxMDgGBW+J9BnZrrhjp5xv4k0M=;
  b=OWlAxK0dMnd9C84SBip6ly9I2DTxouN4D3FoP1TuKouia6U3cprNFKq+
   fOr6voCuh3JUaaCi2/wVtjeika6vzZK7XimqXY3vG1/HmLQij5nP0Xd0v
   ATZyz002UQizGQWqkgxeQSBq/nyZYPOXY2pOd7gxaBrT/jXmA2u9WzIf0
   2s2d0mglumiwG8lhEEDTwgDjIq6rjFYw6Eggqh3MNOnpOoomQQIn0BdJT
   yN7IdyPgG433l0TTZqs3hTZ7RnPzSHH0IwYxg0jX4mzTpGuZwUd8++d3u
   4qsH9RJQArsx1O/Miq7uwmebUcmux1jDjIkOXldHnxDailpGiM1yUdCrw
   w==;
X-CSE-ConnectionGUID: FUujfjQAQ0qKfP6jlRgmdA==
X-CSE-MsgGUID: 73Ru3sc5T0KMxwh+d98SGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63944029"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63944029"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 21:06:27 -0700
X-CSE-ConnectionGUID: 18Jq0eLiSASmt/HimVvJAg==
X-CSE-MsgGUID: mXowlxgxQ1mbhKRRGtOu5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="209697744"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 21:06:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 21:06:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 21:06:26 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 21:06:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAWbolSL22Z1xo/qENTOMQFhp0vP0T748wFKtk/qAZjwydQOWp8mOB5ewXlVPmoPBfRhz25m1QssjIhgSYFm4p95x7MZ4MrlGjZBQMcXETwLtnn6SK5a8PrL3pVcomUDfKQ94irXSXP8W9YQqaPKK6Q1cXtGVpalYGg/vLkn6MYDJue5JR8/+rrOiu98eywe0t4INq7fj0EbboiLramjO2fOOfGOC407u22aRfVQVAfMVCLg756NTCt2+MkklEglVT0JJ26op4T4l8JreJH6CskwTaPxWzos/aGiwoB7ZEXNhhs1n2ZVShJ38+dllTBXMvMfdstSFKKSDUZhdBwplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REWKZu15owSZXup1ggcXRofE8t5tBjjTBoUP8LHjAYY=;
 b=kyhFJ0JY/tEmKdVMeqw0hSTVjql9oAXsd6K4uQpJ+IJbssl1SNpjaVXcXdHa7yNtjhfIijAqaIBZG2vDAmeHW4b+z03ZCgVUWs7ELx69BK2/ia19/1AT2iPgGYU012aGVwu6+wLRD5fPc5tRsRYeLIxMpsSGGrdBTqLA/4YuxXoGMnu4gXGPzGVYXyS+uRGjGOEn/f62OkDnV2zp0S7UW1TsDBA3SwAG0qEpGWWBIueeD332DF1iTRY74VeUvmE+ej61QMvCaJXH1s7CtU4VmsKWTA8hj1D5FjGfqVepFTKjXoptyTFZ1enfPK4yI1lk7S0Szglk+wQvxoD/L6ShSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 04:06:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 04:06:23 +0000
Message-ID: <489f3c7b-db03-43dc-bb64-910a0fcba31e@intel.com>
Date: Thu, 30 Oct 2025 21:06:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/23] KVM: selftests: Add helper to initialize TDX VM
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-13-sagis@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20251028212052.200523-13-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:303:b6::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 840e55e1-c5c3-4d00-a658-08de1832db08
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STdya3FXcFF4MXEwWWo4eG85WWlZRWZtSWxVMVlzd2VEZWVjWEpFcFpJK0J6?=
 =?utf-8?B?aHJRZERibmtOcDZ0Y1gveWdiVFA1blhJTUdrS1hyeDR4V2pzSzZqeE1YcVAx?=
 =?utf-8?B?TVhsdTg5UCtQTjh6TXI5NmFDaXVRS2ZQaHFqRFV3TGlnUkRnaHcwRGljcEhr?=
 =?utf-8?B?MDFiQ1ZONHpzVkRHaHhYUThJZDB4dm9EWmlORlU3VVEyT2VqbVBIalNlYnhF?=
 =?utf-8?B?cmpiUEVDZFdUWUhsQmpGemtrdi9WaVQ4T2dLTXpjaDZXZlU5blh1ZlI5Mnla?=
 =?utf-8?B?emVUOXJGN3VTU3gvYmFCbWg5djdCYTEzWnFOYXVXS2psZlk4WlVSNCs5bVpQ?=
 =?utf-8?B?QkV5NUNNbmtsZzNqTUhlbnVMOGtjTFU2WnJudldQZ1NRY0FxTnRPNDh4eVRF?=
 =?utf-8?B?NHN3Z3JtWWFtMlNsT3pKTW43TS9HYkZhSEJWVk9qaUZkL3Jwb2RaQ1ZkT2tP?=
 =?utf-8?B?cWp3WXJUdlUxU0E1UHRMaHVQclVlR1lyMERYcWJOcnhnaUhQOFJMUG5kajdG?=
 =?utf-8?B?YlRMSDBWNzBISDhsa1k0TW91aXJ3ODcwS0gvSGZWY3o3S2NEVFVxM1VSZzZT?=
 =?utf-8?B?U2VGdXJNWk5JSlVFTXd6N0RLcnpyaCttZkxISVBrZFNRTENXYlpHUDJPZFRk?=
 =?utf-8?B?N3VBN05lWlllSWVIZ01SZGxRZW9ySUk3SXVvK3lMQkt1dW1hbWZpRXpueW9m?=
 =?utf-8?B?QkVzL3lrZWlNeGRNZGhzNUMwSENmaEo5S1NWWHJVb0YzNnB1aEl0cW1JdnJZ?=
 =?utf-8?B?ZTEvcFNablFZZ1FLazUyOENndktYREhySTlraW1yVWsvQzA3STVwNEhmai9i?=
 =?utf-8?B?cmlCWFVybUgzWEhkQ0p4Tzg3NURSZlcyNllUOUo4M1pLSjNPZU5FaEx1SFpz?=
 =?utf-8?B?NjBFdjYwL0duR2ZOdUxrYzEwVzFDNW5UQXNSMkpPSW0xTG82T1RjRDNQR091?=
 =?utf-8?B?ZUR4cnVQcitPcTUxbGpWdWdtVkdMNzRuNkZiNlhmZmpMTm94ZEpYZUx6eGNI?=
 =?utf-8?B?Ti9RV2pjSTJlNDNtaEdHRDRxelg1QWh6dTZxUERxMUQveWR6dWxEekpnaDlv?=
 =?utf-8?B?Q2pCTlNac3BuTTRKSzNXdEc1K0xpUjJ3aDZiR3BPVXlHcm5FZFNpTWhVVHQ4?=
 =?utf-8?B?RXorQm52RFI2SnN1MWtnWnpSbjBBNmphRFNCc0pjL0lMdUgyNVdxQlZINkVm?=
 =?utf-8?B?MUxnQjA5NVJEaUVoZEFJaEROZVhRTURsUEFzdWJzSk9UcFFBNE1lZFJjM2Fs?=
 =?utf-8?B?NmE1SFVSSktyS2RZc0dYM3NCVURwQkZrNmVDUjBKU2hxS1piWWRuMXdnV0I3?=
 =?utf-8?B?WUtlM2UxWkJTWlZwTFVaTndoejkveXlJSEtQMVMwRGQxMTVPdlgvWVpGaXZG?=
 =?utf-8?B?VWJZTFV4cFJ0UjRsUGxyejBrRUI1akFEQ2RlTFZXVWc2akhvdUxxNlo4Rnpw?=
 =?utf-8?B?azFxL2JZSlF5d0I1d3UvM2g0cmtRMUt2cnBOYk5TZTFuckE2bm5RVHhPcXdW?=
 =?utf-8?B?amkrbG5RS1VHRHhORHNjV2VoNitRTGtDUmhDdmZVL3prVmpCRnc4QytpUE5E?=
 =?utf-8?B?Z3VGWnQybGJwM2tpekFING9MSmZkaU9WVkcwUkVZclErZU50ME5Ca1JFT0JD?=
 =?utf-8?B?Z1hoVW5ROHVkdGRGWkdPZmdqZGJVc2Q3UTdvY1B3Z29Wblc3TDM4dkNIbGVu?=
 =?utf-8?B?T0htc0NHVDFkTjdORDFzWm5OSUV0TmUrSjBCTFpkdVBrN2pBSTlTSkFNdElZ?=
 =?utf-8?B?ZlhZMWhsRms4VDg4TzFWd3BaYXNRZ3U4eUw1NmRKUUZDNUtpbjBaMmJSM2ZS?=
 =?utf-8?B?WXJnNGlqcUdGUVlWNkNIeno0azQ5Y1liV0swNWVEUmdsU0hZa1orZTgrR3Aw?=
 =?utf-8?B?V08vR0RLSU9GSHNSVXlMdnZXQU4vbktmMFFudFQ2aWYzSllKbHdxdDVTeGdm?=
 =?utf-8?B?d2Nnbmk5QXR2cU1NWUo0bGRvR1BXRWR4TEdtVWZVZUUyVkdRVTI1a0xudnJi?=
 =?utf-8?Q?OWy2V+TLiI9VRlJBrpWG8jZ2LZVLJs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFdWZVVHZGE3TWdIRU9HdnhxV2tURXc4WlR0RnZBTXVqOGdqY0kxS29qR2Z4?=
 =?utf-8?B?UWlxVzBUWEFybTBEUUpVWHo1bW9HRElYQ3B0WlNvMWh5Mk5zQWRlMXBMQVRO?=
 =?utf-8?B?UmU3dUcxSVc2Q1RVcmJOcjc2eGdxbnJKSk5GclVnemJnZ0FrUnFjVkZGMVVK?=
 =?utf-8?B?dGE2djNBdE1JMWIxT2k2UlplT0QyQnB1M2RVR0J2NGxQY2hUUHltNUVOSkZl?=
 =?utf-8?B?THlsM1pKbHFiQ2tBZUZyZHJwNzZHMXBsNDJCaGtqWlVxS3lVSFkzYk9SS3ZK?=
 =?utf-8?B?d1plcEFKdjRScTNGZzNOZmRyTEtWK0VLbFZWbU96U1Y0eFF1cUY3R0dMVFd0?=
 =?utf-8?B?SDFuZnRtZTk4TWRVL29SekY1TjIrWWlRZ0ZjeDBmWVNlU3RkaE10YU1ZSGNL?=
 =?utf-8?B?amN6OVFDL2RtRUgyU0l0QTFFZWJkUG5CNXV3K2EyZGRPWEZQcE0yQTlONUlM?=
 =?utf-8?B?K0VEelQ5RWFvRjdvcnI4aklaTExqcEtsQzljN1k2K3JEak5QajhKM0JSMTNY?=
 =?utf-8?B?U0RmbVI5T2ZLZnFrSE12Z1ZTd1dIYkc3VWdhcFFvbi9GbkR4Uk1zbWJUQ3hD?=
 =?utf-8?B?WFVnRGRsK3JCTllQa0xiY3NEZU1FVmFxcEEya2JvdDJLaEtQZDNTdjliY1hK?=
 =?utf-8?B?c3dtVTQ1SWlZdTdib2pLS0N3R2R5UHEwZEVkVlp2NWJ5WHhGWDNUYThjOEJR?=
 =?utf-8?B?OHdFeXVPc080VVNOU0V5ZHdpTmlkWkVhVDRvaXN1NFNmbFk0L1J0VHJRSTRi?=
 =?utf-8?B?YVZTOVVoT2puMkhrODYzNkFLL2Q4SjlVNUVpVVR0YTZieW13QU51bGRIcEVB?=
 =?utf-8?B?RHQvV3dmS3dUNW83dkgzOVluR1hTbGdvV1QwaEpHaFhvV0lYMG03aTlsZHdk?=
 =?utf-8?B?UTRVcXl0Q3R5c1RuL203M1lYZmdxVkJzbks2WURVd0pGU1pJOUxtRlROYVdk?=
 =?utf-8?B?TTNNZ1RtalVsei9JK0FtVVQ1UWJHVWpPcVFsOVB3U0pMS29SZ3lxZWJoTEFG?=
 =?utf-8?B?ZmhyODVHRUd2L3NPb2ppUWp4VzAvcFkybXBYd3ZlbXhOa2RWOEJKa3F6U05r?=
 =?utf-8?B?NlErNTBSeXBpVjBEalArKzRWcUsrZFByNHV5RVFOOXhRbFBSbEVYSVVGUXJL?=
 =?utf-8?B?OGgvRytOY1FkM1pmMGROekJwZGorTmU0UUxuZXVvTWtJbWRhcnVkSEYzc0FK?=
 =?utf-8?B?ejc0bkhNeWhVcEtBcWppZXRVVkdkZUFiS1ozZ0FrbVBVdVF1R3Q1QUlEZVFi?=
 =?utf-8?B?MStZei9zTnEyVWowcGRPNjJBZGx4T0tuWWxCb3NRYW10eEFZdnhvdFNkL25C?=
 =?utf-8?B?UWRlVzRmenIzRmJqZjdON2t0N3U1YXFxeFcvSVV1WEFoU1ZMWkxGdXVKY3hU?=
 =?utf-8?B?RXhkanhMNk5wczYxM2k0NGJQWUw0cllqUjBpU1NWR2M2dzVDNi8xMUM3R2lK?=
 =?utf-8?B?WVFKTE05N01MN3ExMGowV3MxbHhCWUZ4cEFhRnhvYnd2bUZZY005NFRPYkFM?=
 =?utf-8?B?SlRwM3pkRmdLMmFITFM2TlFJb3Q5ZWVKMjRkc1lsSTBXWXFJQ21RM3FFWC9I?=
 =?utf-8?B?Z1ZhUUFVeFRUTlJQS1NGN0VYVkZVbmE3RE1CenJiaDh4TkwvRkNZSHowWnRI?=
 =?utf-8?B?M3B6RTJmdDU1Sjk0UmQrNHdVbklOVEFxcTl0NzFIVmN5VXFkckhuMXN0OFV1?=
 =?utf-8?B?SUt2UEgyVnpTUURpdnJCV1ZCc21hMm5oaEg2TEs2MGxGaGhjNlZUYUdaMlFB?=
 =?utf-8?B?SHZoajI1dDd5NnZkajBUbC9rREovRHkwT2FHZ0U0ZndVd2tRV09jWkFlVDYx?=
 =?utf-8?B?N0lqaGlEWFFHWmE4N0lEQ2FJR3c3VW1GTllTTTVGSmYwM2xUc2s3SGVDbm5Z?=
 =?utf-8?B?bHFMYW9LU0hxdGVMYTB0ZVhBOEtabkV1dDBlOVdZalhHcDJPdUNac0ZMSXk4?=
 =?utf-8?B?d0RuY1hiZUJCRXNta1llMFcrVzd6VURwYmtHajhTTk43YkV6VTV4aktmUVZi?=
 =?utf-8?B?NFl5NnEydU15ajc1TkFQM0RZRWZSNm5IVVNNUGkrTTRHOUl0ZlRGcEhXc3V4?=
 =?utf-8?B?QzEwemp3QUN4emJSRGRuTmFSaVB3QktreTZ0OEo1L0NFUVlIeUdoZ3NNTFdZ?=
 =?utf-8?B?TE9GaEVVdHpjSSsvK0FLanIxajg2Njh4Z3M3ekVTd1oxc1VGNVh0NUovR3FT?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 840e55e1-c5c3-4d00-a658-08de1832db08
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 04:06:23.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDIVYRCpI6t9PrYivHzn4i3PQYzVlpZYBKurfZxPiZoliVurhadVtrXi6Fy5/XN3an34gFxf24L+2UfVTRCfW99t5KrSgUwK3WjR2o+3qgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com

Hi Sagi,

On 10/28/25 2:20 PM, Sagi Shahar wrote:

> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index dafdc7e46abe..a2509959c7ce 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -11,6 +11,60 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>  	return vm->type == KVM_X86_TDX_VM;
>  }
>  
> +/*
> + * TDX ioctls
> + */
> +
> +#define __vm_tdx_vm_ioctl(vm, cmd, metadata, arg)			\
> +({									\
> +	int r;								\
> +									\
> +	union {								\
> +		struct kvm_tdx_cmd c;					\
> +		unsigned long raw;					\
> +	} tdx_cmd = { .c = {						\
> +		.id = (cmd),						\
> +		.flags = (uint32_t)(metadata),				\
> +		.data = (uint64_t)(arg),				\
> +	} };								\
> +									\
> +	r = __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
> +	r ?: tdx_cmd.c.hw_error;					\
> +})
> +
> +#define vm_tdx_vm_ioctl(vm, cmd, flags, arg)				\
> +({									\
> +	int ret = __vm_tdx_vm_ioctl(vm, cmd, flags, arg);		\
> +									\
> +	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
> +})
> +
> +#define __vm_tdx_vcpu_ioctl(vcpu, cmd, metadata, arg)			\
> +({									\
> +	int r;								\
> +									\
> +	union {								\
> +		struct kvm_tdx_cmd c;					\
> +		unsigned long raw;					\
> +	} tdx_cmd = { .c = {						\
> +		.id = (cmd),						\
> +		.flags = (uint32_t)(metadata),				\
> +		.data = (uint64_t)(arg),				\
> +	} };								\
> +									\
> +	r = __vcpu_ioctl(vcpu, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
> +	r ?: tdx_cmd.c.hw_error;					\
> +})
> +
> +#define vm_tdx_vcpu_ioctl(vcpu, cmd, flags, arg)			\
> +({									\
> +	int ret = __vm_tdx_vcpu_ioctl(vcpu, cmd, flags, arg);		\
> +									\
> +	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd, ret, (vcpu)->vm);	\
> +})
> +
> +void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes);
> +
>  void vm_tdx_setup_boot_code_region(struct kvm_vm *vm);
>  void vm_tdx_setup_boot_parameters_region(struct kvm_vm *vm, uint32_t nr_runnable_vcpus);
>  void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);

For completeness to help with discussion below other patches add:
  void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
  void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
  void vm_tdx_finalize(struct kvm_vm *vm);


When considering the TDX functions in tdx_util.h visible above the namespace of
TDX related functions is not clear to me. I believe an intuitive namespace
makes the code easier to understand and build upon.

Almost all tdx_util.h functions appear to have the "vm_tdx" prefix even when they just operate on a vCPU scope,
for example:
	void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
	and
	vm_tdx_vcpu_ioctl()

Also, when operating on a VM there may be an extra "vm" added to create a function like
vm_tdx_vm_ioctl() with two "vm" in its name.

Compare with similar functions for normal VMs:

	vm_ioctl()	->	vm_tdx_vm_ioctl()
	vcpu_ioctl()	->	vm_tdx_vcpu_ioctl()

Could it not perhaps instead be:

	vm_ioctl()	->	tdx_vm_ioctl()
	vcpu_ioctl()	->	tdx_vcpu_ioctl()


The functions could still have "vm"/"vcpu" in their name to designate the scope, for example:
	void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
	void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, uint32_t nr_runnable_vcpus);
	void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
	void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
	void tdx_vcpu_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
	void tdx_vm_finalize(struct kvm_vm *vm);

With a namespace like above it is clear that (a) it is a TDX call and (b) what the scope of the
call is. This helps to understand what the code does while reading it and makes clear how to
name new functions when adding new features.

...

> +/*
> + * Filter CPUID based on TDX supported capabilities
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   cpuid_data - CPUID fileds to filter

fileds -> fields?

> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * For each CPUID leaf, filter out non-supported bits based on the capabilities reported
> + * by the TDX module
> + */
> +static void vm_tdx_filter_cpuid(struct kvm_vm *vm,
> +				struct kvm_cpuid2 *cpuid_data)
> +{
> +	struct kvm_tdx_capabilities *tdx_cap;
> +	struct kvm_cpuid_entry2 *config;
> +	struct kvm_cpuid_entry2 *e;
> +	int i;
> +
> +	tdx_cap = tdx_read_capabilities(vm);
> +
> +	i = 0;
> +	while (i < cpuid_data->nent) {
> +		e = cpuid_data->entries + i;
> +		config = tdx_find_cpuid_config(tdx_cap, e->function, e->index);
> +
> +		if (!config) {
> +			int left = cpuid_data->nent - i - 1;
> +
> +			if (left > 0)
> +				memmove(cpuid_data->entries + i,
> +					cpuid_data->entries + i + 1,
> +					sizeof(*cpuid_data->entries) * left);
> +			cpuid_data->nent--;
> +			continue;
> +		}
> +
> +		e->eax &= config->eax;
> +		e->ebx &= config->ebx;
> +		e->ecx &= config->ecx;
> +		e->edx &= config->edx;
> +
> +		i++;
> +	}
> +
> +	free(tdx_cap);
> +}
> +
> +void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
> +{
> +	struct kvm_tdx_init_vm *init_vm;
> +	const struct kvm_cpuid2 *tmp;
> +	struct kvm_cpuid2 *cpuid;
> +
> +	tmp = kvm_get_supported_cpuid();
> +
> +	cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);

Could this allocation be limited to tmp->nent?

> +	memcpy(cpuid, tmp, kvm_cpuid2_size(tmp->nent));
> +	vm_tdx_filter_cpuid(vm, cpuid);
> +
> +	init_vm = calloc(1, sizeof(*init_vm) +
> +			 sizeof(init_vm->cpuid.entries[0]) * cpuid->nent);
> +	TEST_ASSERT(init_vm, "init_vm allocation failed");
> +
> +	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
> +	free(cpuid);
> +
> +	init_vm->attributes = attributes;
> +
> +	vm_tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
> +
> +	free(init_vm);
> +}

Reinette


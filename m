Return-Path: <linux-kselftest+bounces-21427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 496F09BC238
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 01:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB131F21C6D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 00:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2F3DF5C;
	Tue,  5 Nov 2024 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jT9y5KXi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE71FC3;
	Tue,  5 Nov 2024 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730768134; cv=fail; b=FXXs9CEN+F5+9fCbkQLRn7f0pz1JfVux+E2DOwGYF/UuieKWtYWtQDCcIWrwGVIgROCbfRB3X8DJy0Ua7EUV+E8SsOMg99LOrslc9E61ooIN7KmCvuSjz6SgIXvhfFhbKQbopCTiJnFoxZf0DjRIu6DEiGjLFR2i7t6lFmtymY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730768134; c=relaxed/simple;
	bh=mfzESB6Un/I4nY8C2Rfcg+oHAsZWDD3jcznkIrHsZdc=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PHBIvK0Z6rUlBGKCZlv6Z6Xno+3brQW0p05rkZxWPRYXoW9vatrruDsdFYBKXmXl53KOCevINnUSJfSq1fpTdHIxR3MbVsLEaOlsSv1MLedfEQqoC42AfPNHN4X+C8RlHPfu5vYkXC3tAufBWwIyHD6klRS7NexyBBidYdaQld0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jT9y5KXi; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730768134; x=1762304134;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mfzESB6Un/I4nY8C2Rfcg+oHAsZWDD3jcznkIrHsZdc=;
  b=jT9y5KXiMh2eSyW+j96iNCsiWwn5lY7yGU8fs2QewEMidBUQ4met2ulc
   ax55+OJgOsC7qVXjgMl5cqWZoIenTOCklo4YQ4MJ07Di0YX7COaD85hUN
   EQqjXz8QMqb372cW+Njz0qKldwZ9DmiGE3BcvsNomf6zAvz3/6yaOLKg/
   KTVG7i2Pp73QuPz4OrqGcEqFjvYMaAiGk1Zpq7G3k4lKMwjo757r1soPl
   08pRKZW7XMIXe5n1poAl9B+5JP9lS3qfdSFzNf83drg79AbYuKPrymmMH
   5I1tAFUDV1BuvYkXoKA+ePlzKDeNGJ0cRy3JZfmPJ8ekWLWPn6P8t9AYX
   A==;
X-CSE-ConnectionGUID: S/5XBNEqR/enZXPWXOVNWg==
X-CSE-MsgGUID: 5yrhBK3RSSWSyd+MGWB3KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34183947"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34183947"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 16:55:33 -0800
X-CSE-ConnectionGUID: U9G5iTXoQwiiaOCKol+YrQ==
X-CSE-MsgGUID: uo8OgoFJSw2uUyoOttS4Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="84638851"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 16:55:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 16:55:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 16:55:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 16:55:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcdT0bvMMRKG5nF7+nhHcaek8UWyt4XxoUhLxf+63rgMPV7cfGz+oYUevdIcgdjnWwMPfzmoPoMZ00EbF0z/bJU+Nm6twAzQUPSuzi/rAFaxsX0CsPVRl9tgf9LVTUBu/S+Bx33QOB05gIecBPfJDgbAv+d760PuXnzzE5Il68M9Ef2H2xFfEeVPh2gYNSl7wfmuwcza2WGK8wAUBCgvRpu1DBVv7rEd+RebgS5W0gs3rWANoV7M4VMFWWdSHwLchMVGf7vbaq0zO1muEBXkQWsUdHFPyM8BHN8TSk4b1ad5RXZOFlYVWJMr8GGzCOyEetdpgqSgsRJQZbNH74J8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoXuG9z0IzgOvp+RK3xQ6EQBrlgWjtse6++IBkobkB8=;
 b=T1pnacL4jeyBxG66OyJlAWDOjOKvW/ZFZskZvpRWkBUvl1eWQi2ZLJTIM85PmsrnMsgyTBfdRvJRQxQuypYLAp5STsbtGGBVp7ofqNB9lsvEj6wDI7XioLAiqQ33XycnyScGDv8+jjpZrRaSeqtklXsXWysvKAt56i1KTqLTo1gpUdYczKXCvhQ/2gwDip1OyHq+mCsAKL5gOaGW8kTYzGnUbAfqqd3m02PsLjLjwk3z6A5IQNC6QXcTaoI/FPAYcRlV+2kYD+ItPclPAN63DoLYvOpM65q7CwPsW6t85WwlO+xfM0n95YVSUbpC5gMyP1TgqvFqLF5kAPkAIORG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 00:55:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 00:55:23 +0000
Message-ID: <bca5eea2-4088-4ba0-b313-66e15077b206@intel.com>
Date: Mon, 4 Nov 2024 16:55:21 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
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
 <10d28348-9946-40ef-9e7d-be0adff3ff14@intel.com>
 <c69d23f7-0c50-4f8a-b146-c76bc6f4291c@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <c69d23f7-0c50-4f8a-b146-c76bc6f4291c@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:303:dd::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: dae93617-c545-42d8-f5db-08dcfd348798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3g4eThrTjFDT3I3enA3aGJzMklmWTV4U01TdkFtVTJlRzJrMEhGQzYvUlBI?=
 =?utf-8?B?cDFjRjBNU1d6UFYvSWpsaHR1YytGSU9ETndSMCtlQkVZZ0E4N1ZIMlFRZy9j?=
 =?utf-8?B?QWgwK1RNRDZ5U0xiWjBRVS9UOUZGNVY3QWZuNm9kb1dseVVzdXI5R2d0QTFt?=
 =?utf-8?B?RFFEUy9PWVFENStTUGRzejlaaHg4MXFtT255SHhRRmxpQnhGdTFJYXl5WSsr?=
 =?utf-8?B?SGcxVU9sNm11WTVVV1RUMTd6TW5GQndSZytYUGhaaVR0YklHNUVqejlnNTY0?=
 =?utf-8?B?K05rUEdka3RGQ2JVNUttTXBuMVRyb1R3SzBid0tPQWpQaTAyMlg0ZjNmYmhL?=
 =?utf-8?B?WmVqdWg2ZCt2UHE4TlZMZTZydVdjbjdITWVjNEFZdlZhRlYvbWo1bkRnaHdi?=
 =?utf-8?B?RDlVbGpYNTJXRWZUNDc3c3JlMStlMjZ1L2p3MWpaMTl3azRVZkFWWDkvZmly?=
 =?utf-8?B?Mmp1ZTBmbVZNMWJmelJZTWt3ckFIVjNLd3ZMMFJSRHpRQzArSkxmMWVQblRC?=
 =?utf-8?B?STdBZGVsTnphMm9TNGY0ZDM3dHFaT0I3aWJMcFgzZGZvaXZWSERxUlNLV3lB?=
 =?utf-8?B?OWErOTZvQy9JeDluS3IvN2pTOTBBWmc0UWhsdDNpc2hSaytqVlRTZ2pvYzRt?=
 =?utf-8?B?NGwxK0RSRXZ1R1JVMi9HYjVGOHRHN2Z1bzFtRFdXNnIzU0lRMWZ3bzMzNzE2?=
 =?utf-8?B?SnpTL2ZqcW0wOUswb1lNT05rRHR0a0lYZXl0QUtHUG41NVlFb2hwQzQ1S2Z3?=
 =?utf-8?B?NktMNFJaek9uZnprWVdjd3lqdTV1ckEyOTNSY0l5SkV5aDltUk1IYy9OMXAx?=
 =?utf-8?B?UG9QMXd6QXlNZ0VYTzdMUnVwNVd4c0JPVGFpSlg5T093VlFUWDZGSDNlL0E3?=
 =?utf-8?B?YjZEMjFGNExtYzRWRW5seXI4cWwxUlN1S0JiODk2R24vME04ZHR6d3QvK0Jk?=
 =?utf-8?B?NGdYZnR1VGd6Q3BFSTA3VXk0UFduOENWaURaRm83L2h2cGo4bUhRRUJJNmN0?=
 =?utf-8?B?Q2UvMkpMS1dXcnh5ZCtpRFB3RWNyOG56Z2tRV0FOL0kxbDkrOWErWkU4Q3Zh?=
 =?utf-8?B?ZmhSK3NUUCtlUHcrN1d6UDZnMWNHenU2aEkwN0ZDb2hvdEtjZ0FtRlFvUnJm?=
 =?utf-8?B?c1dIaUFhOG5SdkpMaUltS0NPLzVpUlRGa1l0NVp2Qkp3NWlVQVZtc0NVb0hl?=
 =?utf-8?B?L0d6VEN6cXlRZVlJR0tBMnpKRGVBM3hrRlVYeDhOZDNrallCNXNsSEFjc25F?=
 =?utf-8?B?ejdIeHhWTnZraUJYaHJUTGxBNTlzaUtnV255M0xOempCYkUxdDN2Q04zMEVv?=
 =?utf-8?B?NGxSbld2OWVEaWNVVU0reTlDTUwrYW1iNTlDcjRHSUlEbyswUkluQlNGZ016?=
 =?utf-8?B?anVFbERvNjB5dkR1a3poWE9mMlNObDFqV0NlSGRCVUFCeG9NRVNZMVlOYyt0?=
 =?utf-8?B?enc4cUE0ODlYVFVYNGNjU085VERBU3FWdExyUWRDWEZ5aGU5VGxHaGppZ3Mz?=
 =?utf-8?B?SGd2Y0pFaG5ScTZTZ1d1ZjdWdEVqRXJyZDlieTZmQkI3azV1ZFlTc0RvVk9V?=
 =?utf-8?B?OWxOUWEwV0FrU01uNHIyZGxXSDVKbUlRYTY0engrU0VNdVpZVWVGaVFXbU91?=
 =?utf-8?B?UFZlay9zOUdWUDlsS3MzWHNuc1pqb3hwWDloWWdiem5GTVhWVFJHdmFqQkxk?=
 =?utf-8?B?ZzdEOE1wS0FVaThVbE11OCt4YUxuUUdzR2xFSlplamxEUTkwZ2E3aHpweVRt?=
 =?utf-8?Q?WE7HAHvmhvDAsjkAdCjEuJH3pFlfmN4k3sZdxUf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTZ0d1psQlFhR1Fmd1RUWGZuenhBaFZ1cEtzU1l4VGVoMDRrRXd3WjAxMnJz?=
 =?utf-8?B?MFdpQkNhaHNubkQ1dGlVay9zWEZKRlROTlEwY092bWNkU2ZpdTZtcXVHWGlM?=
 =?utf-8?B?bWV1VDBmTmZjVS9nOUhtSkNjeHJQd2g3RHdvNmRkZUJCM1NNUVREQ0w2dy9y?=
 =?utf-8?B?MkprKzZHRStKOW80NGFrbjNOaCtSMCtTckhPZEV0NDBLc2VBcjBYcXJLTzJS?=
 =?utf-8?B?NmlsTHVoMTVyeXdlMWpYcDFQc3U1NnA2aW5xSkJpQ2dRdndDRitRZjF2eXV2?=
 =?utf-8?B?NlE2VllWSFVoTWE0cVZyOE5QeTBWVzVDMmpZZnFDZXlFS3NrTVF5dEtCcmY0?=
 =?utf-8?B?OTc3dG1SVVVFRUk3M2pKVlAyUjFTQjNCd0pZbzZhcDZ0MTh0cmR6SXRRME5z?=
 =?utf-8?B?bGo0UHpSay9pSlBJbDh1Ymw3Ulh6VnYwYjA4aFNvUGlCN2lDZGFxamlrS1BX?=
 =?utf-8?B?bzlPTjlTSG8zSjRRelVMM2VnMkVKL3JJY3hZRG5TTGVENGpmMjdid1VvQWtC?=
 =?utf-8?B?ZDVndnBlcm9XWE5XcDV6U3BYdnA4UllONE52ejkwaXg0cnlYaHB4cjludThY?=
 =?utf-8?B?akY2dU42MkVMZkx2MDNDdXdkRmFmbEZSVUFkY25iNjVmc1o2ajhqWjVXR05r?=
 =?utf-8?B?amdpM1NQZkMvKzFSSE1zOU9aVGZ3ZXFWcW8vSUJHOUlkUHM1UkI0ekc0R0ln?=
 =?utf-8?B?eTI3OStrMXZ5ZEFCL2lETGtBRTNHZUVSVHdzZGNqN2pxTDMrOEdQMnNEa2h6?=
 =?utf-8?B?UGxqRk9jcnpobFd5OGFGU1RUMGw0VGN5R0trYWVZOFB0Zm5JdHFoMnNJOStp?=
 =?utf-8?B?T09GajNJekg4cTc4N0xlbUNnNmZ3OEwrZW4rankzRkpBaFVvTXlEaDNmYUdV?=
 =?utf-8?B?aDJBQzg2dEJ0ZlBvbkJiYmc1ZHFEYXFsV25kRHBDVjNPMFc5Q28zVEh4aUN3?=
 =?utf-8?B?Y0tLdG1VS0xUL3NiODU5VXZ3WWZHME1XYWtnWFNGYklCdzNzSVlCclZGYjBO?=
 =?utf-8?B?bWJTY2ZNcXRmTmNBcE9MWlR2ZitqWUFNNlpmdmthWTl0Q1RRZnk3ZVNTUlFy?=
 =?utf-8?B?eStSYUQzNWxFZy9PSjBpdkV6VVRSa3I5ZzgyN1ZiaWtxN0kxL0s4MmtNSEc4?=
 =?utf-8?B?RTVnQjZvcFR1bUNLMEpKWkYyYXZ6N0hxUVJRdHNKSEhFRFlMbmFNRjlabmxu?=
 =?utf-8?B?QWxoaTJpSGI4Nk5RdGJmY3lYSnkyNUNhQTI4S0pDb2xHekNHdTZXUmdiQ0VI?=
 =?utf-8?B?eHcxaTNoRFN2UlRlbzlRRUovaWJHa1c5TmRCa2J0eFdCK3FaK2w3c3FYRktN?=
 =?utf-8?B?S01DS0ppWmNPWFBOanRyMDlCODBVOUlYd2lMME5IQ0dmWG1JcERvem9qVjhI?=
 =?utf-8?B?dEJVMTNiNVpBaDlOZTF0TlpPU2psODk3MUtLWXFSV1FVYTZ3aWh6U1hBTWZy?=
 =?utf-8?B?NzNXc25jbHlNNzZ0YTF1TDdVLzFGdURxaDhPa0syWGwrWGN6TXdha01hNW5x?=
 =?utf-8?B?djhMRlRNd2RuWVBPaXZ4VFRUVk83d3p4Mjc3SThrWnRZamR5TXBRTUw1eXc0?=
 =?utf-8?B?MDRDQkRsOE5idk9mMjhRYW9senc4c29TaUJ4VGs3OVVBenVaUTZjLzJWcjRR?=
 =?utf-8?B?MHhkVDB4RXRsOWVKZTU2Nkc2a1c1dU9QRGlrSlRHNFRsN3NXdC85a0FYais3?=
 =?utf-8?B?b1JuMmxacjh4TE1DSmY3VG9oVTQ3djdaa2tHZGRBVTRLUnBqcmdkcFlGc0Ni?=
 =?utf-8?B?ZDB1elJ2YXcxWUFWck1hZnJBTzBzc0hQbFFLRDRCaWF2cmlEN0tCV0ZZdWNR?=
 =?utf-8?B?Mm1oSS9ObWFxODdrdkQvVEEvZlora2l6Q1V2TkJLaXA2VkZNZGV3eGg2SUlm?=
 =?utf-8?B?SU93YjZ6aWE3S1JTWmNBU3dzTkwzWWg3TlhDalBOWTFERUxLQjZQc1JoeEQy?=
 =?utf-8?B?N244ZkdadFBIU05tc1RkK0lEUWdkVkJmT3dzaHdVNXRqSngxQnRsWmVTSjBs?=
 =?utf-8?B?Zks5YkRGeTY1WlM4RHBmdGpjSVd6a1Z6TzRjRmxnOGlvMXpHdlVIUEt1b3c5?=
 =?utf-8?B?Mmc2SjE3eHlkQVV0cFdxNDlHdUpjYTI0NTlIcTZiWDVDbDZRK1MweTladXdn?=
 =?utf-8?B?OWhxb0hYVE90ZWdqeC80NFJjVExQNVZMdy9lakhVTWNiQzJkcllZY2FVektU?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dae93617-c545-42d8-f5db-08dcfd348798
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 00:55:23.6189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XOnwIkQT+CZohkiP6MhIODy53nZd4zds5U1Poswk7IM5fYRNbxUOqv3EIF7wyTRwS29BOZEJpZyv/cPGCRuZiR1MtOVYod6ENICAvt/djI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
X-OriginatorOrg: intel.com



On 11/4/24 4:07 PM, Shuah Khan wrote:
> On 11/4/24 16:14, Reinette Chatre wrote:
>>
>>
>> On 11/4/24 2:28 PM, Shuah Khan wrote:
>>> On 11/4/24 15:16, Reinette Chatre wrote:
>>>> Hi Shuah,
>>>>
>>>> On 10/24/24 3:36 PM, Shuah Khan wrote:
>>>>> On 10/24/24 15:18, Reinette Chatre wrote:
>>>>>
>>>>> Is this patch series ready to be applied?
>>>>>
>>>>
>>>> It is now ready after receiving anticipated tags. Could you please consider it for inclusion?
>>>>
>>>
>>> yes. I will apply the series for the next release.
>>>
>>
>> Thank you very much Shuah.
>>
>> Reinette
> 
> Applied to linux-kselftest next for Linux 6.13-rc1.
> 
> Tested on my system and worked fine.

Thank you very much Shuah. I received automated emails from patchwork-bot+linux-kselftest@kernel.org
indicating that versions 1, 2, and 3 were merged (no automated email about v4), but when looking
at the kselftest next branch it is clear that latest version, V4, was indeed merged and all looks good.

Thank you.

Reinette


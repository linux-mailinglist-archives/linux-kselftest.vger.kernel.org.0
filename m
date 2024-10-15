Return-Path: <linux-kselftest+bounces-19721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC599E33C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 11:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072DA1F23669
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDB71E2031;
	Tue, 15 Oct 2024 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAX+rpDh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B31DF25F
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986330; cv=fail; b=fOhInB1WF8PLyAw/FTQFqQTcFwhr8winptpbnFuI1V42a2WtVK7JBcsaPIjPozKXJEGVGHesNRqoLgIamoK5rDPfEyCwYTBU/whcM5EWUwxavMcUQZqzVNKiujSfKbnjfUbV7nQZTPx+bxA0YaH+E6i9oXfoX2lJUKxhnXsFZBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986330; c=relaxed/simple;
	bh=8y0BXa9LN4N87a9wDk6HSzaS9ge9o1nXPvONsgpd0EU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMq+CqPWG6HQ3h0r8d6MJmjzRS5rCK2oC8w6SpX1O1RDAnG9pvYqxQ72uv1oS2v/Zb1Skv64t6bZNWlaLPYoXzpH0TbOh5uJtRDtMhlf3LX0M1S9BjeW8skXOH4Pw6k5VAC8PJV4kVph1FO8AuuO69yFJappDys1byOZsfdgh+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAX+rpDh; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728986329; x=1760522329;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8y0BXa9LN4N87a9wDk6HSzaS9ge9o1nXPvONsgpd0EU=;
  b=FAX+rpDhbXWakK4Kt1yCcNDBDFtA75HGePgyVFf2Uosgsk0rdW4TkQX+
   MwbccYKr3Glnk9FZtFdsDHNXq/0uwKFMD+fKgeHY92qOoKImDgmnmSQ1L
   7vaxMOAoQGaHIreRXoPEHrk6SlAZz3bOo3f2gbID+f50qu1RhhcX/AHEd
   fLzjSAJwPYAIDXphh33rXgyV+tyl9tBvsrCWeMziYlzzuYdXD46617iqo
   /t6el8qN+xVYDKlLgbAkxm7/ctmeJfyo38RG2eDRiePHayPlIinFN9MfH
   RgLmy7FtVleHeoTe6ZzQNEnrO/0CgDTiUvkLPw/r+w5KdjgoGqPDNHF8h
   A==;
X-CSE-ConnectionGUID: 0HShnHHRQtiXtDtKNfF6oQ==
X-CSE-MsgGUID: BA3Z5faySVGxF3MM5J5qrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45841285"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45841285"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 02:58:48 -0700
X-CSE-ConnectionGUID: W/waomEnR4mLVYIboRHuog==
X-CSE-MsgGUID: ZfmID/6RSS+c94p+YPmx+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="82623965"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 02:58:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 02:58:47 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 02:58:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 02:58:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 02:58:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnOoJOvoycuCpQfRFdSoVFFdbeTwdMyV6T06Dyxp5mrfGs9yt9ftNe7DgY/dTChZEaTZra7HVWQhLp9t8P6d6ORUegU91lwBlxf+Q/A7di0aROpwFi98MrJSuuvAZWW04YnDeA2hS+96ld9M7pbKdndEwTZ5EOf0Egt1Q54vG2mKjPCoknzdglhpyeAoBe19B4q/1HvEV2zagy3pb7/I029nXw0J3/vY9nfxIgmfSvd/XR5DBrBPgOsnUe4d7LJo8yT8afkihClUuWiuBU+bBXZ1XGWHYNb288LZg08YLrDaYm1caovVFYWshXNmgIVJ11FhWgFqpf2YtuemnX14PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1zEhmD4kvPRFlvNsXNWcRYQEqvWorVS9065PXj5OH8=;
 b=ZSTEPi8hAF/HgTC2NYq1vED2tOfasIUO3A5lE51ABQFboz4ee12ksiGOzIyeJbZyQq2Fp4ld7G6yE5KVlxGp2Jg6T0kqpSbSFLpvU56WdULjIgVbArM5Vp+paiy0OvJBVoYyRPBqVl8HpF600SQZS2wVZWG5aOsqfiPsQEnTfI8WTx3j6W/ML/nhILyJFdLgQY9bEDsULQ1RBpg0VxVKAqK51oJIfPCAuAR8JTVFwq3MRF/Yl+W0LHcpbT+YDKq4XWeX62pn9YU/5g1ZBprxgyzW3C/DOCHk7p/1oCBtfxuFZ5SdECkBFipw0j+giy98e0oNM9NG6+ZSpPAN1Ltj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB5993.namprd11.prod.outlook.com (2603:10b6:8:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 09:58:42 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:58:42 +0000
Message-ID: <637314d1-425b-4d99-9134-383a7865c9e1@intel.com>
Date: Tue, 15 Oct 2024 18:03:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] iommu/arm-smmu-v3: Make smmuv3 set_dev_pasid() op
 support replace
To: Will Deacon <will@kernel.org>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <alex.williamson@redhat.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<zhenzhong.duan@intel.com>, <linux-kselftest@vger.kernel.org>,
	<vasant.hegde@amd.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-6-yi.l.liu@intel.com>
 <20241015084322.GA19079@willie-the-truck>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241015084322.GA19079@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e2f712-0128-4b0c-be7d-08dcecfff320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzhYY3kyY01lRmZraTdpRS8rbkN0SjV1VEluT09LYTRoUHBIZEF4V0hMaDdt?=
 =?utf-8?B?R3pjWFVQdlpOQlhvV0pLNDVPWkhxRlZoLzRrTlZ6ZFJwblVHd0Z5Smw0cDBv?=
 =?utf-8?B?cS85cmM1clAyWFlSbWZsZzhiSDk1Skw5UmNnb0Y2OE1nSEgvTElHQnBvaVhr?=
 =?utf-8?B?VEc2emZuVkE2QkdsTGZycEN0L3hlVlNTMGJianFMZlNBSjRmZWt5Q1BxYTQw?=
 =?utf-8?B?L0JBNDZpa1BDc1Z2N1U1SlRWOGMxN2tUVzlVVTROendJL3BwR0FQNHp5N1k5?=
 =?utf-8?B?K09XS1lMU3pmcHQ3L20xbGY2Mk1pZWZoK0NnQVU2cFZMVFVPNGRrNzEyQmcw?=
 =?utf-8?B?M0NJUVcvQnBacTk1VTNSMmlHbWJ3MFhqZjFudExtSXpYUDVuRmczRUJITmF1?=
 =?utf-8?B?NWF4a3JpSUtQMXVSMnh4eWp3U3ZFdWw1ckdZdTBEdVdjdnFQeUgyRzlHaG5R?=
 =?utf-8?B?YjNlSXN4RWgweS9CbFk3cU4ybmhCSE13SC9IOUVuVktSRDJQTThsV0VzSElS?=
 =?utf-8?B?b3FmVnBuWU5oUzFsMkVWMDh5c0k4bEdjMmJmMGNVeExxNmdCb2szQ2QrUVoz?=
 =?utf-8?B?R2lZQWZHTU9DY0NOWXJYcERlQmxyR0J1aUtVNGV5OXRlRmhJb1gzbFV5d0pX?=
 =?utf-8?B?SC9saE1yWmpFOGRjOEw0ZUlSbHdzMmZYMkpNYXNjczltMW5YTUFrQjRLTXJS?=
 =?utf-8?B?NkxTdjRBRFlWR1JpRnY2Vlp0YTc3bTEwMDhBWktlOUxLZ2hXSUZZSEVKSE9P?=
 =?utf-8?B?akRQREFRQ01FV0xqWnAxVXdGQlhGSW14WVFUbkE4dFBubEhEQk5vNzdlTkRW?=
 =?utf-8?B?YStzZXRTWm0vNzZzWjlTeEF4RFhIblp4clJkSk5URVZ5UWpCTEhGNHFwOC9a?=
 =?utf-8?B?RUJZVTJaanduYURqREhOSFdXUTFUa0tDWFdWYW5uRk1PRVY2U0I4KzJ6bE91?=
 =?utf-8?B?YW1nRkVSWlBQY3hTNGpWem9pajRXdXJMaTRtVlFSNHlEWndSd1orRjNvZDdE?=
 =?utf-8?B?S0pOU1FPNFVZdHQyNEZVRG1BR1ZUN21MWVFzQ3FkL21NUGtPMTlYOWhObG5l?=
 =?utf-8?B?L2JlSytsQW5KYU55Q1FrejNIMDE2NHlRN2ZpREtCaHBTMDcvZDNzVEVyaGF4?=
 =?utf-8?B?djFuVFVKWXRrNWF0anNMKzNIdlA0bXFCenpwbVBXdy90WktVY1pKQng3ck5T?=
 =?utf-8?B?ZFpEVjk1QlBFOHdDUTMwanJuUDV4QVNBdmpJYk9aU0dWWWJzT1BvQUhmRDlD?=
 =?utf-8?B?U2RhdDRIVm4zMzZUZ2s4S3BNRTJ2RXNyUmxpM1JHUVoyS1g0YUpvTHpOMXJq?=
 =?utf-8?B?MDFMalFvbG1uNmphVGpLTVQxd0RJaDFGbTBvbHlVYVkwb2hHdnI4WnU2S1NY?=
 =?utf-8?B?S0xxQ2dDU2x3NXJoYmlaWmlzK1VVV1NqRHhVamVORDk5VnNiMThXbGZsc0Z5?=
 =?utf-8?B?eEJwOUwxNzZMRFdIZkN2RlpidGNtZm5tT2pCbFdDQjdoeXVjQ2NOTnFxNXFy?=
 =?utf-8?B?bFJMajBXN0VsUEYzZ1RzRjEzWWVSM1NPMHlTWUZUUE9oMnU3ZFVQd1VXT011?=
 =?utf-8?B?TTVWTERCY3h1V0ZCNWQ0QXhlcnZBK0lzVVJ3THo2ZE1BVGpQNW1zbll1MG5Y?=
 =?utf-8?B?Z1lhQW5ydDBxbWxwc2IzOFd4NUlHZVdWQ3FyZjNzK0Zma2x2cG51cVo1UFYw?=
 =?utf-8?B?bFZUd1FkU3BleGo2TFNtRUZkV3poRDVWOFZHYjAyVHZ3clZrVWQ2VW9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZoQ0xYVDRxWUp5K0h0a240NXpwbEpidnFzUzVtbnpUMnhlYURmT29WK0dW?=
 =?utf-8?B?M0l4NHF0ZC85Sko0SkVubFVmNTBwMjVUeVdGRk9mZUlWdXpjL2IzRzVPNVNS?=
 =?utf-8?B?cUlUOUhla3Vzc2xQamtUbEtKTzdsWWhsV05kUWg1WWMrdW5kQ01SMERMWFFv?=
 =?utf-8?B?Z2ZGZWxmSlVGdjhQcXVJUy9TKzhRd3NTbCtGcmZNMFVJSVBxczA4cVVpYWJM?=
 =?utf-8?B?Slh3c0FVLzhQVmdOVDNoQmJUUi9zZnlVeGNpeGx2dm9TQktIYlJiWHIyekYw?=
 =?utf-8?B?blpKL0t1V0dtV3laVXpFajV4VklNYm5uVHBlNEpNQ1dDNUtvTGtKdnEwZ0g3?=
 =?utf-8?B?bkVXa2c5SUZ2Y1JRZExQZlo2QU5wRWZsS2NOd0Q4T3A3QU1NanpxME45WUVl?=
 =?utf-8?B?aGJITmNPMENMNi9zQnFpeTJvQy8zeFg2M1Ezc0ROZUNzL3FKc1dadmIwcTI3?=
 =?utf-8?B?TmlteGxuOVlWcTVzcmdwWGJpZmdwVzhOTkd2VzUySlMxVVF0dE9WMlVaOUJ6?=
 =?utf-8?B?bjJFL0Q2RS9RUFVXRWE0aHBUZ2FPR2RmckhQc0pHaURTNXJEenlreFRlU2JY?=
 =?utf-8?B?NWppbWFpYzFYMGNaZElUMkZmbzVmeUdhN2toZjVpL3BDQTdvWnd6eDYxbnlD?=
 =?utf-8?B?WjNjODVYaXM3R0I3TU80RXdOcHdRVGJLTEwvVzZ3VE1MREdwR1RMaUJtZXJH?=
 =?utf-8?B?bXZGd0hlWUc1UnZ2OEJ0dU1QL211cE4wbEVXRnlpbFM1WEtmT01yVlBMdWNP?=
 =?utf-8?B?aHh5ZHp1eWl1R2NuSEMwaUphdGdWTTNHYS9GZlplSDhRaDdId0tvSVE1eWsw?=
 =?utf-8?B?QTQ3Zkp6UEs3bk9DYWh6aG03UWVlaE5NNENrZUNGb3pZMXkybSs5WEUyWGhq?=
 =?utf-8?B?V1FQQXFnTTA2eGlJNmRrZmVnSTYwOE0xU2tNaDAxNmRtbUQxWkF3dFc1c2ly?=
 =?utf-8?B?RnRNaXhKUlIvT2FTSDlhQThWNnNlRXBYK2V0ZXZJYS9CdEorc1JyZi8xVmc4?=
 =?utf-8?B?M0syWjM0dTl6ai9Ld1ZqbzNlYXRyTXk1akFOZXFkVTZaeHRZbW5hSnVDSzIr?=
 =?utf-8?B?SGhROVdWZkpqa2pLb2Nwd1NaZzFWa1haaFljaE04Mi9SRG93RGxIbjM0WlEx?=
 =?utf-8?B?U05UWnM3eWgraFlLMFd0TG41WDJCV050QmZJYW1XSWRxbVREUDhxYVUyTytU?=
 =?utf-8?B?V1FkSnV1akgraUpEOFJQaXBEd09FWnV2Z3kxWFI5VkhMa2ZCdFJSQitPMllB?=
 =?utf-8?B?SklqT3ZzRXpBSVpEMFVDU1NHeElna1FWWXZvTVFhUnMyN2JidUxCd0Fob2Fi?=
 =?utf-8?B?cFZ4QlRtUXlzNzR1dWFyRFVvSzhJNit6L0VRNnVEV3NyN3RKUTF2RnNhZysv?=
 =?utf-8?B?d1kyTm9ZVklEZThmVDB6QWx5dzJFbVdFditibWoxdnJjK3Z5RC9GZFhLalFa?=
 =?utf-8?B?QmYrSnBpTCtqbVcxbGZLcGhPdFBZaHliaUp0bitXSkhaODQxNTJFOGNJN2FL?=
 =?utf-8?B?ODlCaXdockpXaW81U1NBY3NLNXBTdDVwbXpIY1lKajRsVURPdkhjSFM1WTFV?=
 =?utf-8?B?NU5qcGNhY3BNMEdZTzRBU0FGRCtYVGNoT1F6Q2U5cDdYMlBKd3JoQ0RuZWsz?=
 =?utf-8?B?akJlUGNWbDhuN3dGbGdyZGpNSzhXd3FvcGwwekptNlBIWnhyZU9FamtOS0NS?=
 =?utf-8?B?V1lqYnpsZnBFNlFOWkR3Wi9rZ1ZibnY5ZDdwQ3VGdXNYSHBIejRqbVVSRkla?=
 =?utf-8?B?d1JYVkQwSzNCSkxvQ0U1VURCYk43SU1QcnkvY09wb3RPMk9nZE5CRTdoTmxF?=
 =?utf-8?B?RGRxVU13cDJHdEg2b0ZxemxZbXlTaGNyUElzdzdQanFVM3ZJcUFmS2VPUGRi?=
 =?utf-8?B?M2dhSlBPWmoydGNJdmJ5R2hZM0RqV01lc0RId2RlaFhkeXhYMk0vdWwzUVNK?=
 =?utf-8?B?anVkYzhsVjNYaTRML2pQZkRNSktTSDlXS2czL1VWcGhOdUFlcmFDeU5LMnJR?=
 =?utf-8?B?SnBjamFDM3I2bDduRkxjcjhsU1FwWEhOeHBnSkRiN3FiT0thSjN6dnZqaDJK?=
 =?utf-8?B?Q3o4N0RYSEpVSkprcUY5SXJwelU2TVR1QVVUbHg3VkhzZXlPNTN5V1hHeHJm?=
 =?utf-8?Q?QGK8KylSAYF409yKTbL4qeEIr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e2f712-0128-4b0c-be7d-08dcecfff320
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:58:42.2792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsDad+c8ieRK8nN1oqjmXgtHXSFhuIRQ2TaUckEWScC3m8Mlq7GSmtK67zaGZKWXNtOfdsa8YgAdqSIkfevJLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5993
X-OriginatorOrg: intel.com

On 2024/10/15 16:43, Will Deacon wrote:
> On Thu, Sep 12, 2024 at 06:04:26AM -0700, Yi Liu wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>>
>> set_dev_pasid() op is going to be enhanced to support domain replacement
>> of a pasid. This prepares for this op definition.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 8 +++++---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 2 +-
>>   3 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> index 645da7b69bed..1d3e71569775 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> @@ -349,7 +349,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
>>   	 * get reassigned
>>   	 */
>>   	arm_smmu_make_sva_cd(&target, master, domain->mm, smmu_domain->cd.asid);
>> -	ret = arm_smmu_set_pasid(master, smmu_domain, id, &target);
>> +	ret = arm_smmu_set_pasid(master, smmu_domain, id, &target, old);
>>   
>>   	mmput(domain->mm);
>>   	return ret;
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index ed2b106e02dd..f7a73b854151 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2824,7 +2824,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>   }
>>   
>>   static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
>> -				      struct device *dev, ioasid_t id)
>> +				     struct device *dev, ioasid_t id,
>> +				     struct iommu_domain *old)
>>   {
>>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>   	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>> @@ -2850,7 +2851,7 @@ static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
>>   	 */
>>   	arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
>>   	return arm_smmu_set_pasid(master, to_smmu_domain(domain), id,
>> -				  &target_cd);
>> +				  &target_cd, old);
>>   }
>>   
>>   static void arm_smmu_update_ste(struct arm_smmu_master *master,
>> @@ -2880,7 +2881,7 @@ static void arm_smmu_update_ste(struct arm_smmu_master *master,
>>   
>>   int arm_smmu_set_pasid(struct arm_smmu_master *master,
>>   		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
>> -		       struct arm_smmu_cd *cd)
>> +		       struct arm_smmu_cd *cd, struct iommu_domain *old)
>>   {
>>   	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
>>   	struct arm_smmu_attach_state state = {
>> @@ -2890,6 +2891,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>>   		 * already attached, no need to set old_domain.
>>   		 */
>>   		.ssid = pasid,
>> +		.old_domain = old,
> 
> nit: The existing comment says "no need to set old_domain" and now you're
> doing exactly that! Please can you update the commentary (probably just
> remove the comment entirely)?

oops, indeed, should remove this comment entirely. thanks for spotting it.

-- 
Regards,
Yi Liu


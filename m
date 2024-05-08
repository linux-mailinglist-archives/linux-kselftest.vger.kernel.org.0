Return-Path: <linux-kselftest+bounces-9737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A38C0595
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 22:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60211F24E30
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 20:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409FC130AF2;
	Wed,  8 May 2024 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nu80xz6n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7A12D203;
	Wed,  8 May 2024 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199899; cv=fail; b=KEtr0RKiGoTHjUg60broIekG31DAL4O5/CqDKByIh0EjyFwCHL3jRzppxO+1Kryeo2n4y0fRERJqGNtYAT0GdlqnyM6mvkBepBIIlvPZ+re4M4dJHmcjkeCf9t6NokADRX90gCKCVUIRHMW/5WVHdhiM71Sw3cm2Ig6gQdMn6iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199899; c=relaxed/simple;
	bh=lYxAXfhUNfgHq62A4IysXKxar0j6P4ZNF0i0UO64ZVI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n9xKAzmXlmXEPQt5PDk04KgserW280ItCflPXugoNmLf7rB9dLHH7I9Oi9EpbIUzzZT2tPwQQXRLo4wrhgjaRuffjXu5lhgtttGyuxyd7Phsn/nWeYpHzG6kzCsq/6SeyFd+RckX1QrMFXzWk5hJnrcImKt9Vb0aQiU8GLQCLzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nu80xz6n; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715199896; x=1746735896;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lYxAXfhUNfgHq62A4IysXKxar0j6P4ZNF0i0UO64ZVI=;
  b=nu80xz6nqRl8OD0DO2i4sTUUtSAYgzsIpblyMF+esBx+2qDBBvSLRpMR
   9GW5DMDeUnIJJvg76KF2ZgN8JnNqr1/QZpz2eirH5mLj2r6LdL2J4H4iQ
   /akb+KK5uCK+nA2qzliEgvvAxAc8viwnU/opwzwY+0Q3vQIV8aSNUVIXg
   QQo0lRAcsaBGTYsme2zmDuUgfMwe+1BAdrv1o/U88xs5Kox5lKiuFgbxA
   BsheCJXsNhrqMj3qaSDiZJHz4/wtNMdxB9oX6jVezYlcLuwfP50Lm2k25
   4zPxRIU8ZARKJLXA+H6hG5+Ju0i4M5iq/uDEm0jvPx7ynxbQ7P8cSaGvH
   w==;
X-CSE-ConnectionGUID: 8MBdqL5nReKxAU8D2zkduQ==
X-CSE-MsgGUID: jhSxL9nCTuuNCVM4ZHHrSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14904528"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="14904528"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 13:24:56 -0700
X-CSE-ConnectionGUID: 5r5c68x8T++3G2a4hwg+ag==
X-CSE-MsgGUID: QIXmHiQIQNClXzN6iIv9sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="59868811"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 13:24:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 13:24:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 13:24:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 13:24:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 13:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/JWXag7+qQ0CSuGhG5Sp/xAFXsFhCXS2jqmgUEphlvJi9O9U4bDjvAWwy5hXA0mpH3Yrl1+puABckrUvYp8Jficfp076IJ48BNDWZp5oeI0n/IWHsvv9qQJ/haTeYZrRJ8ZoDUJtavlazge3/Gj2M4Ivn3Q0EmrcrSjZlEqpUgt111SEqZjRC6u2aCpBP49ra6CBzUKGyECD/xsUdBGr3O8LXfzdMsADGEjYjzdT8YjRDkyIG+99VPymZIDRAH78TzhJYLIF+hopuRC7uLw1U3+UDfRKeyulkGdsRk4T2FAW9mlywOLSG44S6q1qDuGKUCD0ZUxxYLSjooiy1Ljhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwvPhSUeEw9PGrZINaliLyzsQgSiaAZq4GdIIsTcU+U=;
 b=fOOtXYsHT+3Gp1NGi0o3jBEje8U25LnK1C66VbqPWXeWBPI0sQYHRTrypja8ReTXcUm3gqR5tUkqzEFHuzQZKI4KLm4h+C5L97CDJyqoEmurc3HmrYygJ5WMLO8KjVjHKDjSYnqd5wplTYhEMWnDHJONwNaW9dJYNrE68iqBrEPS8i5wfx0SZnzGRi8dCuv63oCTDzHvK7cdFFzgvtowVut/7IWe9wcSMsr+rYQUeV2NM57MDxDqSL2IlZB9+NiviWZS2IiNNZC03y/GT2gOycMNq9NbZEtsWbAmDwXtkHDUsNDAjS3FQe6qJhsfjZr35hoRrsPvpsXzuQCIV8ukPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 20:24:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Wed, 8 May 2024
 20:24:52 +0000
Message-ID: <2f172ee0-1c9a-4637-b2fd-574acb9a69a7@intel.com>
Date: Wed, 8 May 2024 13:24:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst
	<kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240508194132.269168-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240508194132.269168-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: b68cbe48-5846-415a-0f6f-08dc6f9ceaef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXdOL21TQXFtYks4KytMZFNNV0VVM1g0QTY5V29iK3oySlBYdXc3aUZvcUdW?=
 =?utf-8?B?Mm5QaXFDSnJJMnp5RnU4cllKUWFRUGM1TElmQ003K2pkby9mVlc3eVBvbFVy?=
 =?utf-8?B?QzJuZ01pdVhBL1F6VkxjL09GMWV6NUhzYUIzR0N6dGN0OGdHaE5VeExIYXBG?=
 =?utf-8?B?dG0ya1UveVZqbnpraXByRTlIcHM4UmFkR1FFT25HZzMwSHJ2R0ZORDg3dHRP?=
 =?utf-8?B?bzhJS0RLMWFvcEtITnhpajd2OUFLMktSdFBQZGVqM3c4aW1jSEhrKzRvK3N3?=
 =?utf-8?B?QVdJK2tSQlRtdDJlRHVTeUlkT1JQcFluaFJ0Q0ZzZGNLRFp1eFF4eWxYdW1N?=
 =?utf-8?B?YXViSDhjejVicjVUWWRmSjFDUEFZbzNlQkdmblkxNVFtNCtkRVROdVNuTnZk?=
 =?utf-8?B?Y3I5Z0U3OFpKc1R2b2RaSENxS25uYUlvNU52eVpTeVFQUER2aUlvK0k2TTRB?=
 =?utf-8?B?QTBubXJNWmVDZjE0MEd3UFVlWjVJN01DZ3FvWFQvdzFqaE5xdk9xcFVJY3JY?=
 =?utf-8?B?YVlJeTdCeC94TjRnM2U5eThHRlFVWUtTcHR5QVNNWHJpK1dGaUppS08xNjM5?=
 =?utf-8?B?bml0cFpSMVlvNFFhZDkxWUlUdENMQW5yVytyZ3ZKOFpRZ25vRGRkL3VQeTUy?=
 =?utf-8?B?eHdPN3RkQkx3QUhSK3JkRS83SFFJdGRWUE5GLy9LNHZzcHlsSENsQ3o1TFl4?=
 =?utf-8?B?L04yZlloNGN2VjFMem43ZUpFdkg1RHU1QXNFc3R5Y2RlTG95QTR6dzlLaEk1?=
 =?utf-8?B?NG1pYjdGM2Y0QjZCVWo5MDg0RVZ6anhMYWx1ZFh5eUV1L0Q2L3R6VWlva0lM?=
 =?utf-8?B?T05Id1R3dk9WSGt5R2dlSUp0KzBrci81Q0dPbzRKdmpoUUoxa2N1dklPVk1i?=
 =?utf-8?B?Nm12bWFxNmY5NG85ZE84Z0Niam5RSkZwNUdqZnN4T3BkUXJQa2oyb29CQm11?=
 =?utf-8?B?bDFnOTh3dGJSbEhONmV5U2k3aitZRksxNk80TnpSQm9MVDdlVG5MWjlqZFNR?=
 =?utf-8?B?NW4vNlBhTnNab0s4SDdOMDhEZlF3c1g2MTNuNnJNTnVudEdjZHk5MFIxQUNt?=
 =?utf-8?B?akxDK0FmUEtMc2wwWHBPVUY3V3NWdE9xbTZtNm1yN29ncVJaL0RpL1hoQWRK?=
 =?utf-8?B?SDNUQnQwK1hRQUxDMldvd093K3FXeDcxTnZmbDJYRTF2Slh1cTBOdmh5OGlD?=
 =?utf-8?B?SExyZzNlblRCRGgvMUtnZmNnVHdLOE9FQlQ1c0pGZzZnYytyR0xKYklUMkMv?=
 =?utf-8?B?bVpGZU5DWS9DK2RBRDc2REsxNGNjVHR4WEVLTVVsdE1EWDFrUmJvN2k1R0dR?=
 =?utf-8?B?bUNPYy9ERjdBZjFDR2NHU3hrOEJWTGJGTEdnMVpXVTF3aEVlMnNva0JsamtX?=
 =?utf-8?B?eDlPc1lSNlJsbU9hRjNaWExHMitMdTdyMkxodUJTMlFMQXRvdThjdkZJUm5a?=
 =?utf-8?B?cHFCTVNYdlZvUkFyei82T2UyQWNERUhVTmg5RytDN3NzcmFjK2QxWnQzNVFl?=
 =?utf-8?B?TXZaUi9JbkNyS2tya01iaDA1MkZtNTlxNWVldEZiMVZPam8xZmpzblVObTZC?=
 =?utf-8?B?M2J6MnJjMHlQWmxRZmpnY25RaWJra203dCtyTkVTTWxET2tLbG5mSUJGckdo?=
 =?utf-8?B?UVdlVmhnakdxTnVlK2NhSWNoWUczWSswQkU1KzgxRm1LQzJEVHJZc2dCcWlw?=
 =?utf-8?B?bkZ2Y3c3VmhaOWNHbFJ6RXJYUzAvcjJKakZKaUg5MmtzbmFreU1DWHhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym1WbzVwUm9BclNiaUM3TDlIbXdMcHRqMUpjTGtYWHIxSmVrT1p0ZElVNWhI?=
 =?utf-8?B?MVk1cHJES3BwSU1Ybk9hcCs3YlhLcWlVM3ZUNTN2bTJKTzdnM0lnWUxDQ0Vm?=
 =?utf-8?B?YkFmZmJYYjl2S0c4bmQvQ1pPWXNBVEVjWCswZXhGK1UvVzc4akdOYlQrRzRE?=
 =?utf-8?B?WDdqZFdBSXdJd2NlRWVhSnJ6aFNvbi9wKzhaamRST1Z1MnZCeHY0N1BjMzk5?=
 =?utf-8?B?TWpQam15UmY3czcyRTE2LyswNDVrZVZ2d3pPaDZLb2VXdEJ6WUtQU0ppcWVU?=
 =?utf-8?B?aWhuVGRvaTA2YllkZGZKVVpLWVpwSDloNklob0JlUjlXbEE1U2dKb29vUzR0?=
 =?utf-8?B?dC9BUERsQ2hEbnMxNTRzYm9tV1RaeGE0U21MN3AyRi9RRGRIaVk2VSs3ZTY0?=
 =?utf-8?B?NXFieis0bmppMmxLdXRZeHQyRzFCSEpmMWhDWGZzb0dpcjVzaUdYbWVZR2pF?=
 =?utf-8?B?THcwVkwyY2hOaEhNQmhGTXlSZ29QTEpiT3NYYkRaRDBBZHlibzBWdTliMWxj?=
 =?utf-8?B?V09kRno5aDdlY3RWd0l5djhYcGZpbmdrOFVTUGVoUDJKK05PUUJVM2JOclRJ?=
 =?utf-8?B?QWpPeURUMkFwQmllWXFORjJIVllQUWF6VFdWSzNhVzUrZHNXK1Q2WGQxUERZ?=
 =?utf-8?B?emc2MFNrbnd0UlFSemJ2ZVhWVjJMNGd6WitjY1pkUVJYTEMxVFB3WTlzMmRO?=
 =?utf-8?B?TjFlcEkxQUdxNVErdEcxK0lyTm82ZmRuYnJJVDFudWdwbEZnYm9IK3BIVWps?=
 =?utf-8?B?cHhVdnp5K3NTR3Ixd3VtRUZBU3RoWkgvZ2xzWkt1U3NJUlFmQlZod05heG9j?=
 =?utf-8?B?aGtnV3MxWGgvRWI3WjlSbTRrbVJiZlcxYm5zbUVOb3pzckZEY1ZDbVJZcWo4?=
 =?utf-8?B?eFdCNVp5Y3BmLzgwVlNyQnprR3BMQWFqUXRHQUM1aHF3RFlyZkhEdlhweDNB?=
 =?utf-8?B?ZmtwdTNBUmdKYkNDTlJScWZoRTNOQTZOL0ZhT0piNUdJeUVvZXg1elBsQlNo?=
 =?utf-8?B?RXk5Qzl0SFlYOXA4ZTIyb0tFd2taa25hSnJQTlp1WDFJYjZtckIrVSt4ZGpY?=
 =?utf-8?B?bGVxalkyWDVCK3RjYWJNZVd2Y0x3SEg0d0U3c3ZTdlpFRmZqUmg2dHV2R25W?=
 =?utf-8?B?YlNCQTQxazB1dmYzUFJWZkdOd0VESUIrL2FncDE1QXA3R1FDc3haSFFZZ3dv?=
 =?utf-8?B?VU9qL3RORmlZUFZ0cHpBYmFaM2cwY3ExWnBEa1doRW1WKzliMkQ2NVhpS29v?=
 =?utf-8?B?Q2pDaXdCNlNldzZvRS9Pc25CTWVhc2VvNkpmRGhkdC81SGowcm5OUkhMNDhO?=
 =?utf-8?B?QXlDYjdCbWlSUmZyMlh1TElwNFoyNk5BNFRhUEluL3VHVGRtL2NlZEI1ZVdr?=
 =?utf-8?B?dDVDRFpkTCtBZUpYS2Q1RUJGMDVCMFBTbFRtV1VCdU5MTjliM1ljSFY1TWF5?=
 =?utf-8?B?cmxOME1XVkh2Rkh4eU5HUGIwWFhHZWs4Mk5XbGpVbzhESzNWRmMxaUlUV2U2?=
 =?utf-8?B?TVBianRWUFFJRS9xYWxYbEpaaEhyRHMrL24zdlZYeVdBY0poZEMxOTdSeEl4?=
 =?utf-8?B?Z25XMU94NytjVXBBYWIrdkhnZjJNS09MbldpcTBZUkZJamV1TysxdmM2NGhZ?=
 =?utf-8?B?Zno1NlBoWXVMZVdLWEhCVnhtcVM4Vk1ZWU5qeWNsaERlSGVtUjdnWEI3ajJS?=
 =?utf-8?B?WUxpSU9XTDNrOHowN29ZUnVXY1RiWm0xYmU2ZFluQnlUdHhWMUhjVVlDVlF0?=
 =?utf-8?B?cUtaMFpncHRXZ1hpNGF3TS8wdTNBRzVTb2hLU0FON1d5TjZZeGFWcFhCUmlx?=
 =?utf-8?B?c242Um5YRzhiOGhnT3p1VTk3YXNQcHZac2pJdk8wYzFRQTdQa2xZWDI4a3ZQ?=
 =?utf-8?B?NkU4cmlPSmF5TDlqNjRTdWR2RnEwbnNZS1dDZzRrNDl0c0Z0cmhJZkVZaGV5?=
 =?utf-8?B?VFZHd1FsemdHd0tBdU9PMFROemJxV3NqLzNQYWNyWXJPMGd2TElud2p6Wlgv?=
 =?utf-8?B?SUhSVDRFbmdmMjNwVHVhNzNzcmxwVzRROW1VYVBuRUxwR3g2QVJWRk9WTnQx?=
 =?utf-8?B?NGNsb203UjdQOExtMDh2VllQM0hKRUpwTWN5YjNGdjhnejR4TGp1RkxKU3JS?=
 =?utf-8?B?dlM3R3crMm1vNjNURWpxNFpMS1NORitpbWU2SExoM1NpUVNramdnOEVJUlVl?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b68cbe48-5846-415a-0f6f-08dc6f9ceaef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:24:52.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5lHPX8FCrzGce1cOrpOj5ELrzZfYFEohbLUllioOHahfUcbItVKQNCqETJ1UipqiZ29p/uAVmDhcUHymHVokA1xb3S9YynJZtyvUpslR1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
X-OriginatorOrg: intel.com

Hi John,

On 5/8/2024 12:41 PM, John Hubbard wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ...two types of warnings occur:
> 
>     warning: absolute value function 'abs' given an argument of type
>     'long' but has parameter of type 'int' which may cause truncation of
>     value
> 
>     warning: taking the absolute value of unsigned type 'unsigned long'
>     has no effect
> 
> Fix these by:
> 
> a) using labs() in place of abs(), when long integers are involved, and
> 
> b) Change to use signed integer data types, in places where subtraction
>    is used (and could end up with negative values).
> 
> c) Remove a duplicate abs() call in cmt_test.c.
> 
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/resctrl/cmt_test.c | 4 ++--
>  tools/testing/selftests/resctrl/mba_test.c | 2 +-
>  tools/testing/selftests/resctrl/mbm_test.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index a81f91222a89..05a241519ae8 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -40,11 +40,11 @@ static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
>  	int ret;
>  
>  	avg_llc_val = sum_llc_val / num_of_runs;
> -	avg_diff = (long)abs(cache_span - avg_llc_val);
> +	avg_diff = (long)(cache_span - avg_llc_val);
>  	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
>  
>  	ret = platform && abs((int)diff_percent) > max_diff_percent &&
> -	      abs(avg_diff) > max_diff;
> +	      labs(avg_diff) > max_diff;
>  
>  	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
>  		       ret ? "Fail:" : "Pass:", max_diff_percent);
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 7946e32e85c8..5fffbc9ff6a4 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -60,7 +60,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>  	/* Memory bandwidth from 100% down to 10% */
>  	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
>  	     allocation++) {
> -		unsigned long avg_bw_imc, avg_bw_resc;
> +		long avg_bw_imc, avg_bw_resc;
>  		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;

nit: since you are touching this line, could you please move it down one line to
establish reverse fir order?

>  		int avg_diff_per;
>  		float avg_diff;
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index d67ffa3ec63a..a4c3ea49b0e8 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -17,7 +17,7 @@
>  static int
>  show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>  {
> -	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
> +	long avg_bw_imc = 0, avg_bw_resc = 0;
>  	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
>  	int runs, ret, avg_diff_per;
>  	float avg_diff = 0;

Same nit here about reverse fir order.

Thank you very much for sticking with this to fix the warnings.
With the nitpicks addressed you can add:
| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette




Return-Path: <linux-kselftest+bounces-11033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B578D68D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1FA1F269BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB1617D356;
	Fri, 31 May 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALm1CYaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714B17D341;
	Fri, 31 May 2024 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179437; cv=fail; b=GdBSTwpV0p0XOi8y60wrOkAbhXlPDzajjv0HwHdUu7wFqjJiwxtsYK94/twZNfa0Wlwxjbb8IKav05uUMEXzFSDW1tUhGpVal2Hrqyp9Xo/VhHDaK8oSL6QaifltlcUolZXW8yykp4gBum1CV787uR/dUwal8F/DUcv0QSm+mw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179437; c=relaxed/simple;
	bh=ocW9uDilXG3kQVsVLPynpHguX1U1UtKBs4bF978gvGk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JyxiprwpNGQkQ4+YNyrDreAJJERRKiK+uu77phoPA0fjirvezhjQK5yugy9yEP+pysXmN3npWyCjqM4gOCtGOrxv9CyCiRLB05VjCCNlU+wvdRI5Sx/l+60QaatJLf1JUTdlL9lf4lb4kVAc4uVJIVep69tTv3auJG6xU9BoRIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALm1CYaa; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717179436; x=1748715436;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ocW9uDilXG3kQVsVLPynpHguX1U1UtKBs4bF978gvGk=;
  b=ALm1CYaaO2MtaALLhmNkFy/bLunssNa7cPp5xx7cPTnnEObRqyRixwF5
   zumG0Xq8kqoiSXrAY4rxtuBEyfbVw3ePFdwqpHN5GrJvNeXHzCC0Ml6lR
   Fe3FSgHfB//0nWYbMlR0rztjuFxDYyfQHtYRBpO1HEWNpTIoxr0bmKsWC
   SULfHp4tzw1PWnEvwmlID9+6EWw+mO9yAIWSxc4jhaCDxoyX83uagxNuV
   2BumeHw1fORbjN2DctkfvnEf1ihVUGTsNty+gb6i8b5LhUHvmAYV+BV+4
   DVviHYX60e7eXJw6oxUI42NaiYmmY3x1T3pl6RUT4gvPI2xbioO93W8TC
   Q==;
X-CSE-ConnectionGUID: vcRfl94+QsyMDtakrNx3dQ==
X-CSE-MsgGUID: wlVsaDNmRnq/ykEl7V5P4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="31230593"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="31230593"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:17:16 -0700
X-CSE-ConnectionGUID: zsfX2gawSGK3s21gea+6EA==
X-CSE-MsgGUID: 75WHGruSR4inkf18yhDg/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36855021"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 11:17:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 11:17:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 11:17:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 11:17:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 11:17:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mt4jp7WbR2HG7rtVsyMvYXDOea7LfYQMU+uR89S22cVt05OefUsxASM6bwC5IDcVylAcSJ5BqzuStue+WY2ZUzy2G8Ku+fUVrNTf/3bF7WO8yJxFLY+1M2javCh4tDxYdCj0aTZnlaIkXH423oX3rIb2FmlgaGW+EzG++LrK827wlCtura/yJSftpnzgkNJtUSxFFdIRZauurZIX0fyEvp4herrS/WDr1Vpzn/1siKoFmr/lIanM1A1Ti1L2P2QU0QLXp4kH3ig5RvD6z1vfuw4bAZdwdYzYsNpsiycojYXgOps93+KSH6urjYF3WiL54wCfj1xsca5E4aTbej+Avw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q7Pr0CfoekUvB5tljURGVGIjPhMkENdecG4tk3hHVo=;
 b=cu6ggVLPHMi0RHOZObWAgggNdrFAPNsPlxQuH4RDuowUZ+jJthbXhpfjf5R/3cvpeRozmtp4rax151zg5ZyiEcez0c8VCFtejcVe0OcTlsP85cmmzPS18SAus/s4pMBHo3VJs07ALpJ2qIWYCgBAYGLtdvgGWkmLBqff/2EeDdc3EWSQPNf8sm98hpwcBH2DU1L+VM2Smj02AdZc+bQ0dCs3nyyQHt6CKyNfM6WkTLXiuzU45nlJS3Xzl3x+wxuwTcCvBPMYkDca7MZX3PWcARVdV1gEhFOxzs6+2unMVQmlloGNsg7zXMEffYEc5sNT8Ht0SupTMMA5L5nawA6G2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 18:17:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Fri, 31 May 2024
 18:17:12 +0000
Message-ID: <f6b1cf5f-b282-4a52-b09a-ac01ff5a6144@intel.com>
Date: Fri, 31 May 2024 11:17:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
 <20240531131142.1716-3-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240531131142.1716-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:303:b6::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 9677a18a-7387-4207-3887-08dc819de42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmpFc05rOUg5V3U2Z3d0WlczYkJqc3RQMS9FT2RmbktJQWxRMGFscWNiUklU?=
 =?utf-8?B?WnZta3RhNWJRYWR1TFRuenRCVjlJa3Q5dUNYbWY2YU5zaGlvcmIweXpvMklS?=
 =?utf-8?B?RUQ3SjZKNzM5MkZlTzhFVHZ0UmYzNVp2Qzd4cG9QWDd0NFN3WmdFeWY4bzF2?=
 =?utf-8?B?cExGdjF0anMvMi85NnpqK3Y4Wk9jNGFtUmt4b3gwWW1YSEFpSFdOYlNXaVVj?=
 =?utf-8?B?c2lHVmNJZGRtcXExUndxNW0wYVBkZ2FoeklhWHkwb0oyUE1kVm1EUXlWU0hp?=
 =?utf-8?B?L2ljQ3hZWHhaeDJibkFhaDZnZ2FmRnUwNnVUUGNkVUF0RVhHamxzWTJYQjMy?=
 =?utf-8?B?U1ViRkxkaVlsajBaOEwwUDc0cmRzakt4MDVNYkFTbFB6UGdwcThzbWNJK1Bw?=
 =?utf-8?B?eDBOTGZ3bGVkV2pHanAyeHNxWXFMUkVSSWtHb3dMNE1MNjJsWktyQTN3S1Yr?=
 =?utf-8?B?TTlLSGJPVUM2TlJtYldvRHhBcnk1dUNEQ2RQZCtoUXNIRVlBTWcvYnNPcUlm?=
 =?utf-8?B?NXoyVWdkV1l6TjRVU01QV2ZQNU5qcGFXMUdqSTVldE05ZGp1N3FYeGRaL1d1?=
 =?utf-8?B?WVpCMWV4REVvUnZManVoRm4zQk9zelZPMHVSdkxRbVI3aFF1M3IxZUdVOWtN?=
 =?utf-8?B?VXNIOHZ5VFpsRG5rUnlQZ2RTVk5FWkdBRU0zZk5mQ3JYMlRlOFE2dDg5Rm81?=
 =?utf-8?B?Y2ZBR3FmRklGQ1BBM1dOdW1IaThtUnVVaHJxb0czSGdJZG16NHJmUk82R0do?=
 =?utf-8?B?NTR4ZXNWT2RUdk41N1dlMkVQNDFiN0lwRzBmVXArWk1ZZ01HVkx6UzJUVHla?=
 =?utf-8?B?R05PZnpNeGtNMHl3NXFheGgrcGl2VXQ1ZFRaYVJUK1FiNFk4UjdYSUV1TTg0?=
 =?utf-8?B?N1ZDUkxOeDFpWXFyaHc4OVM5Z1lMU1AxalJXd28rR1lMSHRxeXAzTVR1UjBk?=
 =?utf-8?B?TGoyL3RDeEk5d0o1bnRUWmNoK2ppQzVnN0ZrL1lkQmhjaDJqMThHTG1ZRWMv?=
 =?utf-8?B?bTlKVG5WaFNBckcyMWsrdkdUc3I3Vnl0VnhvNmtrdU95TUJTRExtclZpaU14?=
 =?utf-8?B?ZldnK3U1bVZHNy8zWXBrUGEvYUFBQlFZTThlVGZ3ZUIyQmtCTEx2Vk9uQzhG?=
 =?utf-8?B?Q3kwcUtFUEhyOFN4UlQwaXdrY3lmR3ZTaXBkclBnSDU0QlRIbWttbUEzaTNI?=
 =?utf-8?B?cnhDT1N3YnlCdkIwU0paL1JYd2NLZVZ4L3pMa1dHa1JUejcwN0M1UnhnREJr?=
 =?utf-8?B?ektGL3cza29hVzdud09pTzZnaWQyaXZSVUZrdmRlUnRTOXRtS2RBdlQzVU1I?=
 =?utf-8?B?aGNsWC8yNmxYSjMreGQyTE5NZytZRnZhTllIQkR6dGZBZVEvVXFKUEhjejBP?=
 =?utf-8?B?VUtWN21XU0piQmpZY0JlVzA1RW9Ta3M0d1czK3k2Z2JMZnZsdElRVEUyMFd5?=
 =?utf-8?B?Ymt1c2d3RXVKZXJIb2FpY1dUZkVubG1COFM2eWQ4V0hJZnpzUHdDa0xSOXdi?=
 =?utf-8?B?cmZyUmpOTEMzWmhnNHBrZzUxY0VxZCswbTZNWTROeWJTTHBBZGo0ZTdTSmNm?=
 =?utf-8?B?aUd2cThza3hzRHFwRk41cndwR2tNTzcwN1ptNWthb0poVE5BTWdsQW82em5i?=
 =?utf-8?B?Q250SnM0RTBZdDlyVGdKMGxZbmlaaU52cWVXc3BUQzVLbTFTcERVOHdXMXEy?=
 =?utf-8?B?eWU4dUJLTkVZQ2VSRGZMV2lEd2J2YS9MZ05oVnl0b09YOFpJbTViNlN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mjcxb1gvKzRiTmlxaGNMOGtlcnVOc3BEZTgvMy9LNkE0eXhMSmJVWGtKeHQx?=
 =?utf-8?B?UFRLN0p4aUlCQjZKYXd2S3liRkhHVTRYTXdOMHVxKy9iOHloK21RUE5oYmJM?=
 =?utf-8?B?N1FIb0QzdzRJb3h6UE02Z21DSFdmNXAyY2xoa2h0MEJad1RDWFJOVVlLcDVy?=
 =?utf-8?B?aS90QWtHVk9ER3F1RDBjaGlhZENxcnVUdStjR0RDaHp1dzYvem5KNEpSaTFv?=
 =?utf-8?B?enI1TzRKZy9henhuSmlhMGUvT3pVS0JiSnZxM1NWdC9XVDZwQVRWNkxXZHVR?=
 =?utf-8?B?UEFrc0xlZ0Y1ZlR2MVM2aHhVYnMyVjcyK1BzQTFkem81QXM0RitwcVRtalg3?=
 =?utf-8?B?UTlmdnRtckFDM28reDRHWlR4c0E4a3BoeER2czVBOERFamozaU9TUEUveCsv?=
 =?utf-8?B?dlE2Q0pvVGM5K0xRcWpsemdiTVdTNlNUOW56djQ1RHo0amNKSW9XcDVQMWU0?=
 =?utf-8?B?K0FaQXIrbzd4TEZORzV3aTZOSTJiZVI2dFNHZlVReE50YXVvUEhhVlJraktB?=
 =?utf-8?B?c1I1aU1WcHlOaFM1ZnRXTGU2bXErYnVNR0pya1JjNkFtLytNRjQrOVV1OEZG?=
 =?utf-8?B?QmltZFpiQ3hqaFJLR21Qbzc1OVhpcjcvNkNHdmI4Q3JiQ0FXRUtybEtxVGJT?=
 =?utf-8?B?YkVpZGFoZjNHZXpic1hNY0ZyenJNY1BSNnE3Z2oyZTZYTDd5czhwa21qUXlN?=
 =?utf-8?B?TDZzbmdSSDJubTZUMXVrbWNhbmtiZXo4VVlvcG9IYlpLQmJnSTJDUWZkNHFX?=
 =?utf-8?B?M1cwODRTUmRaTExuSDI2Rk1DSUlQNFdNRUNKT2h4aUNuOUIxM1puZHBZbzFW?=
 =?utf-8?B?S2tOQkxZWVNXT0sxeThtVHNVREJPeU96NTc4Tk03blJNVlVmcytRSTVrT1do?=
 =?utf-8?B?WmdYZzR5QTZRdm1hamJORDA3RGFXTHF6RnZUZS9YVVQwV0tsejRVKzNnZzgz?=
 =?utf-8?B?MUpjRzVNOUQ0YmQzVjNwcldnS2paRVZ4UjhKdzR5NzNPZnJudzRCYkp4Y0pP?=
 =?utf-8?B?eEhmM2lCQU4wbDQ5VTBFeGF2S0Q2RGFlVG1Rb29zbEg0SzRQc3RKSTd5emlL?=
 =?utf-8?B?YkU4SldQSGtPQWx5eXZwd3FtSDVjTTBFRENLdEtBZEREbjk2OGY2LzcrZ0JW?=
 =?utf-8?B?U21HQXpCWlBXV3lRTjJsU0Q2SDhUSlA2RVdpYlQzaERXTkoxYThqVGM4TFBP?=
 =?utf-8?B?ZVN2YVU2UnhBQzZ3R1pYQWxnMnBjTjF4Zy9XdjZ2MWpEeGs2SVlFY0NFRU1n?=
 =?utf-8?B?Q3M2VDZEZDhidzBCS3YxcER3ZWk3N09EN0U5MGJXdkhyUE5pZEJQMDJoRVNJ?=
 =?utf-8?B?bys1TkhHWVBqK01ZeGZhanYydG1Bdk82N0NVU01hVnhXdnUzeHc0cWZGcTNr?=
 =?utf-8?B?TVVMQXR5bVB3ZXppNFczVm92aEExeUYxVmloS09vSFN2QjZ5RTc4dlErWlZ0?=
 =?utf-8?B?SGQvdU51S01WaFhOeHk2MFNzR29mcFdrSWxxTDRybTk0OGJ6VmZFVVl0RUgr?=
 =?utf-8?B?SW5ERnJDcWIxNWFzV3hIWlZITU41RHdZN2l0SlZicHFKY3RRS253T3lVMjBH?=
 =?utf-8?B?cUV2eks1MHk3cnQwZGJMNXJHQ090cGI0Smhnb2ZoNlBoeTZSQUljMUg3Z05l?=
 =?utf-8?B?WDdXTXNUekwzNnFWTzU2U29ORnFQQWtzRkVYV05LcmtWeGdGY0Zma0V6SytX?=
 =?utf-8?B?N00wbWxtQ05CSnY3dmVTV2VGSHRqNHZPeXE5VlUzWFdWZGkwWUNVbVA3Vloy?=
 =?utf-8?B?U2c1c0tRYmJuQkgvalQ3eGxMaEt6K0lrK1J2TkRoQkRXWXZBanBpWjVTU0Rl?=
 =?utf-8?B?cy9JTVZVSXlMVCtJK3hjdE9Xb3BWY3BsTjhGK2dMRCt2Y1dmdGRoZmJpRTFt?=
 =?utf-8?B?b1JWVTZqb0tKbzRUL2YvVXV3MWhBYjRaVEl4YlB3cHRXUUh1UElLVVJqUEdX?=
 =?utf-8?B?VUJyWTljNFJBMjZkRitLQTlHRW9RSHFaQ2l4Q0FuOU1TZXVROWMreXMySThI?=
 =?utf-8?B?LzBLS1F0VHhOOFZJNDdHM3Z1WHMrM3o3bHNWcGNnWUs1TlJUT0U0VFZNR0l4?=
 =?utf-8?B?QkJDQVI3dkpzOGtNNVVxR1JhVDRTeXBudlMxTFZtUmVzNnFYcktyaHQyclIx?=
 =?utf-8?B?K2wxQ0VBV3psRkdVVUtibGNydTlLQkNGaUlWaWg3eklncG8vWFhUVXU4ZVdx?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9677a18a-7387-4207-3887-08dc819de42b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 18:17:11.9272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6hlgLIuHb8/fDNfqkkyesaHAIzM356eQKraWgOYWnTZ9W1V6082fQX1pz6d4aBgw7PkqC3haCIKpgH4+fVU7XhUe0qKyjfY1d8aku8j+qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/31/24 6:11 AM, Ilpo Järvinen wrote:
> For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that performs
> the measurement over a duration of sleep(1) call. The memory bandwidth
> numbers from IMC are derived over this duration. The resctrl FS derived
> memory bandwidth, however, is calculated inside measure_vals() and only
> takes delta between the previous value and the current one which
> besides the actual test, also samples inter-test noise.
> 
> Rework the logic in measure_vals() and get_mem_bw_imc() such that the
> resctrl FS memory bandwidth section covers much shorter duration
> closely matching that of the IMC perf counters to improve measurement
> accuracy.
> 
> For the second read after rewind() to return a fresh value, also
> newline has to be consumed by the fscanf().
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> v5:
> - Open mem bw file once and use rewind()
> - Read \n from the mem bw file to allow rewind to return a new value.
> v4:
> - Open resctrl mem bw file (twice) beforehand to avoid opening it during
>    the test
> v3:
> - Don't drop Return: entry from perf_open_imc_mem_bw() func comment
> ---
>   tools/testing/selftests/resctrl/resctrl_val.c | 115 ++++++++++++------
>   1 file changed, 80 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index f55f5989de72..6231275a6e6c 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -306,18 +306,13 @@ static void perf_close_imc_mem_bw(void)
>   }
>   
>   /*
> - * get_mem_bw_imc:	Memory band width as reported by iMC counters
> - * @cpu_no:		CPU number that the benchmark PID is binded to
> - * @bw_report:		Bandwidth report type (reads, writes)
> - *
> - * Memory B/W utilized by a process on a socket can be calculated using
> - * iMC counters. Perf events are used to read these counters.
> + * perf_open_imc_mem_bw - Open perf fds for IMCs
> + * @cpu_no: CPU number that the benchmark PID is binded to

"is binded to" -> "is bound to"?

>    *
>    * Return: = 0 on success. < 0 on failure.
>    */
> -static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
> +static int perf_open_imc_mem_bw(int cpu_no)
>   {
> -	float reads, writes, of_mul_read, of_mul_write;
>   	int imc, ret;
>   
>   	for (imc = 0; imc < imcs; imc++) {
> @@ -325,8 +320,6 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>   		imc_counters_config[imc][WRITE].fd = -1;
>   	}
>   
> -	/* Start all iMC counters to log values (both read and write) */
> -	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
>   	for (imc = 0; imc < imcs; imc++) {
>   		ret = open_perf_event(imc, cpu_no, READ);
>   		if (ret)
> @@ -334,7 +327,26 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>   		ret = open_perf_event(imc, cpu_no, WRITE);
>   		if (ret)
>   			goto close_fds;
> +	}
> +
> +	return 0;
> +
> +close_fds:
> +	perf_close_imc_mem_bw();
> +	return -1;
> +}
>   
> +/*
> + * do_mem_bw_test - Perform memory bandwidth test
> + *
> + * Runs memory bandwidth test over one second period. Also, handles starting
> + * and stopping of the IMC perf counters around the test.
> + */
> +static void do_imc_mem_bw_test(void)
> +{
> +	int imc;
> +
> +	for (imc = 0; imc < imcs; imc++) {
>   		membw_ioctl_perf_event_ioc_reset_enable(imc, READ);
>   		membw_ioctl_perf_event_ioc_reset_enable(imc, WRITE);
>   	}
> @@ -346,6 +358,24 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>   		membw_ioctl_perf_event_ioc_disable(imc, READ);
>   		membw_ioctl_perf_event_ioc_disable(imc, WRITE);
>   	}
> +}
> +
> +/*
> + * get_mem_bw_imc - Memory band width as reported by iMC counters
> + * @bw_report: Bandwidth report type (reads, writes)
> + *
> + * Memory B/W utilized by a process on a socket can be calculated using
> + * iMC counters. Perf events are used to read these counters.
> + *
> + * Return: = 0 on success. < 0 on failure.
> + */
> +static int get_mem_bw_imc(char *bw_report, float *bw_imc)
> +{
> +	float reads, writes, of_mul_read, of_mul_write;
> +	int imc;
> +
> +	/* Start all iMC counters to log values (both read and write) */
> +	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
>   
>   	/*
>   	 * Get results which are stored in struct type imc_counter_config
> @@ -462,24 +492,23 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
>    * 1. If con_mon grp is given, then read from it
>    * 2. If con_mon grp is not given, then read from root con_mon grp
>    */
> -static int get_mem_bw_resctrl(unsigned long *mbm_total)
> +static FILE *open_mem_bw_resctrl(const char *mbm_bw_file)
>   {
>   	FILE *fp;
>   
> -	fp = fopen(mbm_total_path, "r");
> -	if (!fp) {
> +	fp = fopen(mbm_bw_file, "r");
> +	if (!fp)
>   		ksft_perror("Failed to open total bw file");
>   
> -		return -1;
> -	}
> -	if (fscanf(fp, "%lu", mbm_total) <= 0) {
> -		ksft_perror("Could not get mbm local bytes");
> -		fclose(fp);
> +	return fp;
> +}
>   
> +static int get_mem_bw_resctrl(FILE *fp, unsigned long *mbm_total)
> +{
> +	if (fscanf(fp, "%lu\n", mbm_total) <= 0) {
> +		ksft_perror("Could not get mbm local bytes");

I understand that you just copied this, but could you please
change "mbm" to "MBM" during this copy?

>   		return -1;
>   	}
> -	fclose(fp);
> -
>   	return 0;
>   }
>   
> @@ -616,13 +645,17 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
>   }
>   
>   static int measure_vals(const struct user_params *uparams,
> -			struct resctrl_val_param *param,
> -			unsigned long *bw_resc_start)
> +			struct resctrl_val_param *param)
>   {
> -	unsigned long bw_resc, bw_resc_end;
> +	unsigned long bw_resc, bw_resc_start, bw_resc_end;
> +	FILE *mem_bw_fp;
>   	float bw_imc;
>   	int ret;
>   
> +	mem_bw_fp = open_mem_bw_resctrl(mbm_total_path);
> +	if (!mem_bw_fp)
> +		return -1;
> +

The comment below seems to refer to the resctrl measurement
that starts with the above snippet. Any reason why this snippet
is above the comment that follows since the comment seems to
apply to it?

>   	/*
>   	 * Measure memory bandwidth from resctrl and from
>   	 * another source which is perf imc value or could
> @@ -630,22 +663,35 @@ static int measure_vals(const struct user_params *uparams,
>   	 * Compare the two values to validate resctrl value.
>   	 * It takes 1sec to measure the data.
>   	 */
> -	ret = get_mem_bw_imc(uparams->cpu, param->bw_report, &bw_imc);
> +	ret = perf_open_imc_mem_bw(uparams->cpu);
>   	if (ret < 0)
> -		return ret;
> +		goto close_fp;
>   
> -	ret = get_mem_bw_resctrl(&bw_resc_end);
> +	ret = get_mem_bw_resctrl(mem_bw_fp, &bw_resc_start);
>   	if (ret < 0)
> -		return ret;
> +		goto close_fp;

perf_close_imc_mem_bw() seems to be missing from error path?

Symmetrical code is easier to understand. Looks like
perf_close_imc_mem_bw() stayed behind in get_mem_bw_imc() but I think
it would make things easier if get_mem_bw_imc() no longer calls
perf_close_imc_mem_bw() but instead leave that to the one that
calls perf_open_imc_mem_bw().

>   
> -	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
> -	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
> -	if (ret)
> -		return ret;
> +	rewind(mem_bw_fp);
>   
> -	*bw_resc_start = bw_resc_end;
> +	do_imc_mem_bw_test();
>   
> -	return 0;
> +	ret = get_mem_bw_resctrl(mem_bw_fp, &bw_resc_end);
> +	if (ret < 0)
> +		goto close_fp;
> +
> +	ret = get_mem_bw_imc(param->bw_report, &bw_imc);
> +	if (ret < 0)
> +		goto close_fp;
> +
> +	fclose(mem_bw_fp);
> +
> +	bw_resc = (bw_resc_end - bw_resc_start) / MB;
> +
> +	return print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
> +
> +close_fp:
> +	fclose(mem_bw_fp);
> +	return ret;
>   }
>   
>   /*
> @@ -719,7 +765,6 @@ int resctrl_val(const struct resctrl_test *test,
>   		struct resctrl_val_param *param)
>   {
>   	char *resctrl_val = param->resctrl_val;
> -	unsigned long bw_resc_start = 0;
>   	struct sigaction sigact;
>   	int ret = 0, pipefd[2];
>   	char pipe_message = 0;
> @@ -861,7 +906,7 @@ int resctrl_val(const struct resctrl_test *test,
>   
>   		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
>   		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
> -			ret = measure_vals(uparams, param, &bw_resc_start);
> +			ret = measure_vals(uparams, param);
>   			if (ret)
>   				break;
>   		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {

Reinette


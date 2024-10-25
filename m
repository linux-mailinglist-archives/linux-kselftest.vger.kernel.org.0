Return-Path: <linux-kselftest+bounces-20671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0061E9B0615
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 16:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B485A28348D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFF2139CFA;
	Fri, 25 Oct 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DC0It/8/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB813635B;
	Fri, 25 Oct 2024 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867558; cv=fail; b=IE5RjEPzDKQ8y/6Yn8nDL4+NAInjaQRVJWZn26VfOrc35Rhug71Tw6cqvK2P2CGi3bMmPjaldLV2TZ1rlezL6a7ssmQFyXaVUHo2/LRu8LU2s4SrxZ+GtcWlD0Em5G14A/uzOLxHMLNqDkL3l+TZ14Y25Gw81AgednQ3Zb2Hd9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867558; c=relaxed/simple;
	bh=xX5H9Pot1f3GYRp4RPOwoHYoO8n0TPekoxTk5090HWI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HfZcv4VFSj0tiP4mxXlolmWmz06xC3US5hvxvtKEkDdxlV/vy6Pn6rOinP9Px2DpZGhsWNeGQNHelBAcZrRgk2pKptBKjeqEqxL0pxs8ZJreN5Hu/MgZ18XO0v+uiFSdEa97/OonnHWlkPCO25LUXUOd0gM0H0llcR9dvYJD9No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DC0It/8/; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729867556; x=1761403556;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xX5H9Pot1f3GYRp4RPOwoHYoO8n0TPekoxTk5090HWI=;
  b=DC0It/8/GqN0yWLQczw9PwY7HLOmspaGDiJEvQL3TnolK3h4rebvJ2yF
   EhttcHkAWVJvsFaMFMFSzwDiupsG9BO+BOwN3MhN37nJ3DR4DaCXgojor
   d66ei1F3a4loUUvqe9QgCqxMU6ooj/r4ogFwBUF9I8hDGzGCWJbH7W4q7
   ekhMldAstQZDmpF08mRNn6PkVaaZcNMfZAVs36KxbTl5vHVjcYbGi0Wn3
   IKa3iHBvyY41RiOQscOtl8JgY2mSaXEa1WhiFyTSlHB/VkHBBAR+R5mDy
   Hdi7K0b9RNlcSPZpJ6gN/iwvWOhjPRQWDqpxyIFmHEseS8x7/DoAcoYqp
   A==;
X-CSE-ConnectionGUID: I2UGkh0bRCOUpRZI2lPIyg==
X-CSE-MsgGUID: Zn2Qg4GJQ7GjDXCHGb3dTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29403181"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29403181"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:45:56 -0700
X-CSE-ConnectionGUID: GaecviHHReCMKh/QJkXXRw==
X-CSE-MsgGUID: rNveROVjSPazioZJ/3VzTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81042346"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 07:45:56 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 07:45:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 07:45:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 07:45:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5JAO5C8YiEyi/yGjNW/F4TrUWMO6+ZkIInM+NBa1hLhoqYC2HEmqA+uPbNJBVLc4g0t1Ia4ek8+nXzH0JTbCRrefFUvXpPcMmO6++8oMlV6GcPfwSFBkfIbsQ++E0hxXzS1ktZfx43AbvLZmiFz8dSyExnFPu3ju4Pmrbsl8n3rU6APA8/gk4ucna62V0vavICy+mgH3s0DBc9LDk8Wz0k5P7xHHBbEtyxiONbVVPDKjLDM7eoUnWIemklLt8p1odl+/w5shoqCm8MY1Oj8jObhfjtnxIbT/qS753WiJicMfmUmwCiVFF/7vBBX8/zMmwblqnYah02WSX6AFKXbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAIc3gD/M2NajlhkxYA7jR1msx7CpaOsr7tSRPvwsWI=;
 b=rVAFlaCIDsqebs9pWEhl7qM6PnjUv4kUXmivrQO0pym9D4g6FPJ6dAkExSYGLZQhynnkglLXZOGkrxkT9VblaPwoKngZdTxefilXacIu4Uu8Y4MarAnLB0dc02TVHtfEaMqPaIVWCD7CrIRKdy9Ui5SbRQKNzGR9Q/lhEzVhnrksyOZ+fNItJT1s9lbhzZuULEk5ncoQHOh9tNDVUfj8C5QC1JAaNayQBYMjvHHcUJIcmAUBRnQJYVu9Xtjp+kb9eXdnELE5pJLPPKfLAP5OOvDMoItPnVuzbvfsqVCmYtSqb5Rz+N2uFH4lDIctdBnadBH9pKfc7dbovq0jB7Hmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8574.namprd11.prod.outlook.com (2603:10b6:806:3b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 14:45:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 14:45:50 +0000
Message-ID: <b75e3849-41af-45cf-8f7a-e5258a2c7c24@intel.com>
Date: Fri, 25 Oct 2024 07:45:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/15] selftests/resctrl: Support diverse platforms
 with MBM and MBA tests
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1729804024.git.reinette.chatre@intel.com>
 <aa643c9b-8ce5-4cb1-98f6-645224aafdf8@linuxfoundation.org>
 <b0ff78c0-2fe5-4350-94bc-cc6b21960cdb@intel.com>
 <ed332bcb-0dfd-ec34-6523-3262babb3e90@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ed332bcb-0dfd-ec34-6523-3262babb3e90@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd27640-a422-4369-c519-08dcf503b7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K29yZExsL3pJR1BIbStkc0c1MzBwVDJxWVhFcWJZcWc1VFE2UkhoM2tIbkdv?=
 =?utf-8?B?MVdNbk1NTzdlYzlnVzBPV0N1aVZRR2RFamlCRWJ1WjFPemlmNCtkY2VvbFBL?=
 =?utf-8?B?Ry9FVWljbndXSUswd1RnTlNIaGRFczVsNTZRWko4VjM4MDRMSmlPZ0pnZHdu?=
 =?utf-8?B?Z0pDVG9TaW9rbTZVcW5jQklZMDRxbEwxTFowYm5yTnpabU5mcStZVkh1OVNM?=
 =?utf-8?B?Yi9KYUw3eDdZK3VkS2xPZkw4ZFkwSWlxTzNFaThxUHJjZENsOTgvOFdNaER2?=
 =?utf-8?B?a1dDY1psS2g1MzJRbGVBaUJ0Z0xyVERyeVpsbGtPSUtHVlorV3p4clpOYWQ4?=
 =?utf-8?B?cmJkMlU1QjB6VElneCtSL0ZSb0RsZUViVDFEZXNWbVV6aVdJa05QUFVWUG5i?=
 =?utf-8?B?TExoS05saENHQXVGUjNUUGoya1Vpd0ZNb0p0c3gxT3RuaHpoVU56b2I5a3Vk?=
 =?utf-8?B?dXVPRHUvNEN3a2EzZmtiVnJMZWJxS1luU0FCbFhNZmFVR2dTMGc4Y2d5UlJj?=
 =?utf-8?B?Y0hpRmdTbDR0QmhUVmpYSlRrSW5RZEo3RWsxL2xSb3hkOHBrczBaK0hKaXpJ?=
 =?utf-8?B?QTluOXhYOWVwaVdlc0xVV0dEbUNNdDg3Q0tGM2ludk5HMlZ5RFVzUmtsNTAw?=
 =?utf-8?B?ZVpGb1pmMGhiSnpHZm9LbnhmU0tNM0luKzFYR1U5eHoxVEhJbXdzNDRNWnJB?=
 =?utf-8?B?VVp0YjhabWQ3VEpOaDR5YlFjUHU1UzdFNEMzUlVlVEtqbzhLUlIxaFEvTUpQ?=
 =?utf-8?B?SzRuaFVFK0RTQldwelhpSTdib3ZkQXdoellkam5hWG9tL0R2aEEvcmRQSitG?=
 =?utf-8?B?M3BKM0RDeXp5MlNqMjdzdS9JNW9ySmYxbUZ5WE9OYktoUHdzUkFQVGJQVUpi?=
 =?utf-8?B?ZnRycmRRaDhqTU1aeXpWQmJObThXRXF2SzJkTUNKTFYzMDY5cm9ETGpBUWE1?=
 =?utf-8?B?ZVZDaUZwUDM3dkRMZDNkSnBuZUo0d04xZG9CYWVhVmFNVTBJS0tNQThQZ3dM?=
 =?utf-8?B?aGZ6NkZNMGxlRzNwelh0bitvTEhZS3B0UjdOek5Lbkg4OURFZUxibXp0c09h?=
 =?utf-8?B?VVRwVm1lRkUrNVpzaHl5MkZoN3Z3dGp1K3Jtak5jdXgxWTJpbmNIL2FmY0hy?=
 =?utf-8?B?NzY5SWYvRDd1MnRYMklCcVlXUnYyK3ZCemNXeUFHRUkyaDNDczdMWnVpNmVM?=
 =?utf-8?B?TXN0RCtHa2Nubzl0QnlnK3ZNUnhnTHgxa3dtcVh6WFd5UnJZQk1lNTJDYnRm?=
 =?utf-8?B?d1V5UFVPT3V2QWRLbi9OZjk0cVFVcE9iMm1WTVo0SGs0YnpZNWxPWm9NeEY1?=
 =?utf-8?B?WUJ4QUY2RDMzeVFudnFjQlY2QVErejF4VEJXZ3pURlN3c085RDJYV1ZMVElk?=
 =?utf-8?B?QjY2cXFTOG5vMTlMMHhhWUdzb3MyQW1kYzk5NGZKdzVoV3JteTJ0Mi9FNllG?=
 =?utf-8?B?UHZERVF5bTNtemliWlNlY3hiY0lISzkwNUdESjlTQ3F6UUs4VzB0RzhLb3FD?=
 =?utf-8?B?ZDlqYjZjRW4wZ2dCSFpsQ1JJVXBQM2xzNFB4dWZoMU9ndm5RaWswS3BmYmts?=
 =?utf-8?B?dm4xU0tPMXA2aTFrM05YUjV1dy9ZVytnaUczMSt0d1dNbGpBT25IdCtFQlJW?=
 =?utf-8?B?OU00Y0xZT2pDWTVIQ2FjaTlaZml2aGt2SHVwQy92WkRFT1VOMXZTV3BpeXUv?=
 =?utf-8?B?aWwxcEpTLzBKNXMvRnY3YzBxdld3bnhRa0oyclVBdDAvbGZRcnd6UE1sVU9m?=
 =?utf-8?Q?O9quqx8oFGo0aLdt6y4Bm95PSNLvcnDLVH6gvkU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlA5aVJ2eStZTDRuY0E5V0M5cmJ6RXpmak52VkkwT1V3aGxWRFpMVXhmak5i?=
 =?utf-8?B?QS9Td0FrMjFBVFpENHN2TGJkcHNXMXpZZkJtVWtnaUgvK1UyT01LMktZM01z?=
 =?utf-8?B?Y1BiZGNJTEFyNDN6MUJNcFQ4YWtxK05RYm85VWJ4ZDFNbXN5M00zTXBuNXBa?=
 =?utf-8?B?d3hZZGZLczFIc2gvRGZWOGpqZU12YXd1YXJ1K0RkNjZyMGJSQkJkUmZ0MXkv?=
 =?utf-8?B?MHl3VTlxNFhJUGpla2NESTdCcFYydTlmMnd4R1VTOWhnNlRtd3lpUEM1OE40?=
 =?utf-8?B?K0NCdjUxbmVHclVzK21mWFpRZEoza0NyY1RnMnY2Q1ZRc1Ryajh2VFdwbHVM?=
 =?utf-8?B?bEROdGxFc1ZQbUlYOStGSVZsS09jcWFRR2xYdzQwem1zUTZlSjJncHBEdWZi?=
 =?utf-8?B?Rm1KeHd5RDAzNnRvMkF4bXBWRmFNaFV4QzB2WEt0NUFtVW9SUUxJZmJ4R0hy?=
 =?utf-8?B?T09EaXF6MlhrWDF2VFl4WU5uYUdvOURTVkY1RmRnS28ySTMyRVFrOGNhUTNV?=
 =?utf-8?B?L1ZjRE1DUVpGMTZQT0xjdm5Wc0RPOXorZE1leDVldEpxZkpoejVlM0hqekFT?=
 =?utf-8?B?OE9RV3hLa2xubkpzV21RbENCS3dFcFJTOVlMU2R0WW5FSk9MM2oxeFROODlM?=
 =?utf-8?B?NG1SK3AxZysvZ00rUWJ0Wkw3R0lNb1hIZ1ZHbVJ6MkVJVTJiaXlJckk0Zkg4?=
 =?utf-8?B?aWl6MG1RcVNLSktVbERZajQwbGR3MDlkY1dqNEM2eXNLOS9qKzNUZjB0ZVNX?=
 =?utf-8?B?MHRGbVdNYm8rRzFoeVhuR1VRSGppSi9BaTYrMEpKdlB0Q216UW5CUExvQWFl?=
 =?utf-8?B?T2ZkRmRwSnNzdHpnOC9nTjVqUnJsaW9UTXF4MkkxUFlUTFZJSlJldEFwNDBu?=
 =?utf-8?B?R2RmeFdTWEhLTHhYcU9LWGdmRlpvVEQ4eWVXS2k2bWY0ajlJUCtncmpoQUN3?=
 =?utf-8?B?cGttc2M1WkN4YzRGOTlVWjAwdllwOWtIeUpHY2tOTGNENjZlUmx1ZUczK2VN?=
 =?utf-8?B?SExYRyt4VHVvTGRlZlJLcGZqNi9weEs2UHQweTVlSWFkVmtQcEZQd1Y5Uk9t?=
 =?utf-8?B?TnQ1cTBVQ2hvWTVoUFJKclliMGhVWTRCOWNmc1pCOTNDYnJBd1Vabi9sOGo2?=
 =?utf-8?B?cFBhcmY5K0luYldIei81Wjh1RWpzWnIvL3dpRmtPeUcyazBIQU5QQ25DTlhL?=
 =?utf-8?B?cThGcXdJY2lFRTZtTjhTV3VYMHlxT0w1Y2FIUXlUMk5GTWpiZWpvdkJBTjFU?=
 =?utf-8?B?VkM0cTVOb2xKcGNMdFFsUit1TWZmQXpvT2x1ZE00c0U1ZkphaUx2U1Jidmhs?=
 =?utf-8?B?d0pGSlptV0ZVaFYwMjZJY2RZTENkTDNUMy9ZOXZzZ3ZGT2RNempQT0ZCdllM?=
 =?utf-8?B?aXRGOVZneHZpakFoUUZKcGRodHVqdEdKWlNEMzNobUhBcHE3WFB2NU00cWZP?=
 =?utf-8?B?WURWV3VxalNUMVh0WndqQzh4T3JvclZ2MStuSU56S1QxVnQyeGJ1UzZEQjNa?=
 =?utf-8?B?NGNOQUFEMlBDbFBCTWdpd3kwMjRKMXB0WEhYUFltekxPdUVnMVJHZFp4eWhD?=
 =?utf-8?B?UHI5RE8wNTQrOHk5enB3Z0lOM05YMjdKLzd3MEZXYk00a0FBUHB0YVZPS2VU?=
 =?utf-8?B?MkR3ajRXTUVnWjJmcXhFMElXSHNpUVFkY0R6c3JlQ25tUnRXTUd1WE5GYXN1?=
 =?utf-8?B?RmNPMUJ5MUFOWkFpeEtJdzlZbTBKMlp4ejVIclVqZ2tZRlNTWmFvRENsR05l?=
 =?utf-8?B?QnNNcEdvMDg5WHVIVzh0cCtEQVBJaWRjUERuSmllQWdKc2EwUUxLWTRidmJy?=
 =?utf-8?B?WVdaWk8vZVcyakRTRVNTTVFqUlZWc1RqTFFNUTBEVUtoeTlXSFJJclFOdm9a?=
 =?utf-8?B?OFREVUVuVUZNK3pVV29hVm5yRjJPbjlIamR6bDZVQjhQaFlGbHU1VEdiTGhT?=
 =?utf-8?B?NG84VDVDL0M5TW1pQU85Sm10NkI1aVdFeVdGOGVIdEc0TFAwV3Z3R2hzOG8x?=
 =?utf-8?B?aXZIS3RjTlJKdVkzc3pNRHcrMkthVUlPSnFIM1RzbUNXcDU0V3VpZzZjaHI1?=
 =?utf-8?B?Z0xUQ0g5cDhmZFN2bVVlZnJkVWE4VlBQRTBrU3d6QzBDdTBvYnMvT2svZHZN?=
 =?utf-8?B?eEp6aEg3OHEzUzhnWG5nU1BPSEdlQS9ldzY1Sm5qdGFLQ1ZDUmxQbE1jTjBT?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd27640-a422-4369-c519-08dcf503b7dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:45:49.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/wPrSnnJLOVg3Bh0Bi2zg2++NaQCwJAqYHszKeMXjHS9tU7o8gpksTvZFJo0+o+efnTTfhgnSQTRqLu7B1Q8sS35lZd2pKEsWNm2d8xl18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8574
X-OriginatorOrg: intel.com



On 10/25/24 6:54 AM, Ilpo Järvinen wrote:
> On Thu, 24 Oct 2024, Reinette Chatre wrote:
> 
>> Hi Shuah,
>>
>> On 10/24/24 3:36 PM, Shuah Khan wrote:
>>>
>>> Is this patch series ready to be applied?
>>>
>>
>> I believe it is close ... I would like to give Ilpo some time to peek
>> at patches 2 and 10 to confirm if I got their fixes right this time. The
>> rest of the series is ready.
> 
> Hi,
> 
> I took a look at those two patches now and they seemed fine to me so this 
> series should be ready to go now.
> 

Thank you very much Ilpo.

Reinette


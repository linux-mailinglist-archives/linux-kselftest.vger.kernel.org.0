Return-Path: <linux-kselftest+bounces-44876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060D9C3962A
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 08:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F43B18C347F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 07:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB3E2DE704;
	Thu,  6 Nov 2025 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmjBZvPi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A0C1DDC1D;
	Thu,  6 Nov 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413828; cv=fail; b=i7XDNgMDQLaaqQ2Kz4/hPyNZAQf2KLJa+zfo1FOv2Y6XLxU35TLOFa19A91H+OWIje1T3mUpHJcmEKnwPfAP0oXIeBhxHUnzWpY75XMCa+9lrlc/IBUoAdiGloxqcUKoDmdJjhS3xy/WQ/0KT54DA60oInW2M2h3XNyrwSDZJ4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413828; c=relaxed/simple;
	bh=vL32HTRBDnAJC1Bc7LiJWD2ik4U8VY7LMcB+pJH8k/I=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IG1opgxEtz5xp/+RHJVkhz5KauOeU6hi0upQINMV1oGSmMV3uUDYdxOY3uPunM1jDPaGk4tJAx9H33OCqfDt/xGMOtgCexcjO/Th+0axw63My5t4c1rZItDNpLmFsCvSPm5mwZpmIffUqH/6uKC2aPq0CRhZlKHcbRud1DA88dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmjBZvPi; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762413827; x=1793949827;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=vL32HTRBDnAJC1Bc7LiJWD2ik4U8VY7LMcB+pJH8k/I=;
  b=jmjBZvPi891peVdGTFK1sFdimPp3MZ9YJJklSnklLceeTWD8ychTUlCB
   3dgwVGY3eSh03diqRXwl7DhNR3tN5uLa5OaMUDPqrC3llyV1vOEd05b+6
   gkFvdnpx9njQ2/PqBntLpdRanDZXtv6hUryshwTVz9zXCjndY685Ta5Uj
   zxUCKhrNTPg/qBlwOIy6SX6sJB+LOcVJv7A3qvxP6fpsF6cpYHVNHLh6v
   UaqG5SHO3gY6vfObgqz6Iuan0L+ZOXsFhlB7nhIyFqpy8U7NCQlnFiBKT
   UJZKIitfL1QNPqFeBEFzlO/6Qt/WhaJxqHc25pYwsbuK9k6LYr3yxSsT0
   g==;
X-CSE-ConnectionGUID: 4PdzEdBOQfm2952x+FMU4w==
X-CSE-MsgGUID: XJKgUJBrQ7mkhdOQEaoCfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68402575"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="68402575"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:23:45 -0800
X-CSE-ConnectionGUID: EVer1mwrQL6klPZwHkiZgg==
X-CSE-MsgGUID: DM8R7CPiTnClL0+NHnizSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="218345154"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:23:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 23:23:44 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 23:23:44 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 23:23:43 -0800
Received: from SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21)
 by DM4PR11MB6190.namprd11.prod.outlook.com (2603:10b6:8:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 07:23:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMb2ef0+8qOJBguS0TGnQ+S84h5m4NaKOgvkLHm6GVJkW3fp8ty0HyY4v3sZWJUqVJ8dZSopH6TIhRFhqOaokopBuAFLZmc8Z9Mq0ACMGAt51GMKmSqtB16YAgGOaGIw0vgzV+8e37m+ckXO7sbnkBoQtpgLJudthCUcVmcABIZwO5COEM+W+bjTtrI7Av4kyct+omKPkLtRylgUiL57GS0zMNiQrm9vso/UU3QSSN/ySyzGnlv3SOGoet1kdaAWJgGoH1A0htky33vIUWz8lEYQW6bCUghtWaER+hMr3a3xpOTDvMZ6CXPq2EF2oHq7fpDp9bi6RG/pXxwgrFOimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnoHSybmK68fu2Pxc1wqX6YywNfvF4tzENet+CNMBBk=;
 b=M0WDLsAPQ8gnJ+BJGsynC3EqFsXyzV3nvuFQxOOfMS6t6HDrBUb9zeQBHLUM6IkgbPk989AJvsuASt1LfXwfzgLiykg4cQ4ltCpHF7R0xfPeXcYVVOITTFEc+n5s3NPs2rvUrC+zVdxn0rO9GnAJdmg+o9UhzVSChvg85BHxL0q1O71DKSBcNbA7U+kC04L8ccDjC+HYChVFpAFaVHoAumYxTFp3ApAVnzyZ6C0uoCW7j8mL/JoUQJ8ZKkpccKsm7pLJ3NSsBuAMSMl4/LDz6hqHQxqIhM3ev94lw4dB45iOT56OXJv3B4J5fht5MF6g8xrLYdqKpvFqfUkewFB6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 07:21:51 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%7]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 07:21:50 +0000
Date: Thu, 6 Nov 2025 15:21:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<brauner@kernel.org>, <corbet@lwn.net>, <graf@amazon.com>, <jgg@ziepe.ca>,
	<linux-kselftest@vger.kernel.org>, <masahiroy@kernel.org>,
	<ojeda@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <yanjun.zhu@linux.dev>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v9 7/9] liveupdate: kho: move to kernel/liveupdate
Message-ID: <202511061443.64dd159-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251101142325.1326536-8-pasha.tatashin@soleen.com>
X-ClientProxiedBy: KL1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:820:d::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|SA0PR11MB4669:EE_|DM4PR11MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: e02f1dd0-a769-488d-5339-08de1d05266f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TFfPNVVRMUghy+3BkzZcZHxLT3Y4/9Dz+zVV1KhwqLyAJoCtdYD7WUorDdQt?=
 =?us-ascii?Q?qTdKM1MAl7mGLp8ggd0TseRFT7e2nupNL4wokA5/rIarIz1xivjxRZ2vmnt3?=
 =?us-ascii?Q?BgxyyuKe2j6JP5YqQL/+WJe8bCNhr7kvEkwKNWIGxECjIc/yvaSo6oiBuqfB?=
 =?us-ascii?Q?oXgE6DGgrOup1ICK/NwTTICutJG9GGZTxDpmSQIhbFqCeKp4wtlyotcngjL1?=
 =?us-ascii?Q?GBHAQadkkFCsyZ9zghrhrYdV50CA5Xr1EMQ3boeMJRoiqzIpTS6Tj3tBnlOm?=
 =?us-ascii?Q?cF8uv4CpkYRixlHG4rZExvbSwBXQFnYik5b+Bo7sloTs+MNDNyS9tg4AG8ZX?=
 =?us-ascii?Q?ZyI8VBkhX/bhoRhOOOoOiFSNlKjw4S7jK5Nd1GSxZX3lbwPl/Wu1az2H/Zb3?=
 =?us-ascii?Q?s1SkUOjED8KODLNk+iwWvSNtUdvxqADiTz7IG+Tq7zasEs1dMUBML5HZ0OHN?=
 =?us-ascii?Q?VlLzH5a4A72ZM4TDOXjcyiVDJDvm9BEaTmefumAcXqSO8lo9rdjoC97n1+5U?=
 =?us-ascii?Q?ToWguzgdshGcVH3Ce8dkEZgvYIOTign5mMi1hSXDKIc8kHiN75Lrrzr7MMmG?=
 =?us-ascii?Q?Ye4NzCc3bw7NzAGzbFAI1Fmn8Ii4GbK9Qph1oSai1kMchF15DhN3+K2Ooy0D?=
 =?us-ascii?Q?Bg+PZx17K7QVdp4CB0ozxZK0NGqp9sBv8hu2IQY2B+WmOFrYMv52ZOGinLHS?=
 =?us-ascii?Q?2QB/M5OvWyeMU2QdaNFZyaFmflhWwhktnwY+Yzk4FlcK+/hb37FB7bazqNbv?=
 =?us-ascii?Q?HzJQs8JYz9ArPkWSvtQXTDyxDEGds1IICmB17cQ9eCfuYqk2fP7KZDZ5Yyu4?=
 =?us-ascii?Q?13qo10dhLGOvZPmbPWUhAw7aTrWiy0Fouek1Hez1lqrcaIILYBXLjVpNHJfP?=
 =?us-ascii?Q?AerzxD5Kd8u4kzWwgozTt0m4Jge8NI3IOcTBuQnqJjMPiOJoCQIYcK4ksAaP?=
 =?us-ascii?Q?gYa86VrChk3JhCka07B2uExOSb+Z4bEUcsRT607tXnFCOFY0OwOtrzDp8K4S?=
 =?us-ascii?Q?Qe7Y9z8eeFKxpMREC3roDqKlGc8rnoBgvSwwrh1u/ZgwTKoqB+8JxM8k7Avn?=
 =?us-ascii?Q?MI1KhEUVXqr+rBazUMLmyKLIpAi6rY90Q7H1TYLqQw7TA7eQL4cP0ctf92Qs?=
 =?us-ascii?Q?OTVN4L/yRJ6EEaVR3hAJEngAqXClJDT/d+DZqbENebTZazUMblxczMfcYBp1?=
 =?us-ascii?Q?7uXIthqnFSkP3EdFXuDtFgnrQOf7BCNIMnXsYXHbPV21yM3NC5nQ+bwF95yz?=
 =?us-ascii?Q?3j6B52BxWn/4P8rhL8zCWdfIHcKIfYTBoDvqoHLpxjW95mhK+xjwzPK/1gQ0?=
 =?us-ascii?Q?lrhOmnPYP9h40FxUFGZQhEzddSXv4stqI1HUGPm3+VCNXpd02FM7BZKxTFr7?=
 =?us-ascii?Q?R/p7ko4sIYYkKTZ1NkVJjMOvEbUa7OTHdontKonLh/c30W4qRGld5aSMqsGq?=
 =?us-ascii?Q?VPYpMgal0omRqyaNl7hI0ZnqG0S/vV/SsO2KigxptHrZtHePsdPlYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RxatM9EzQm/+G17MPUbyHUebjhiffeptaQ/CdXK7JwePCCLt1iAfdiCRAosR?=
 =?us-ascii?Q?F0FiIj6JPzlBzLn3a34FNj61YlPtNL3/BqZU7803Hw9SJDXmSz3ykNkSBay7?=
 =?us-ascii?Q?J4z1dfbkPo+NKXPVIp/cgQumu0tpYgmGiQx43h2UUJq2c6gZi51Ij/60swpq?=
 =?us-ascii?Q?9jNfD9tCIX7iVtrW7VjHj4OYqDLYV+Bv5CMalj2jCpsBeyOzZPWOXBbrOgLH?=
 =?us-ascii?Q?gcZjsYNg38WP74ht609Vn/y9t5VuPqvKdppLMRt+E3xhx/rS7qiAe1rAqi5y?=
 =?us-ascii?Q?rMf9g0nUxC+CvYvWgViT/AohBIArvPHAgJ7xp45E8WcC3InwSDx8dhJCAx1b?=
 =?us-ascii?Q?LycI/TpQ/6q9ftoVzTG404IOCKdn3YDsqS8BCyGmcPv8lTLotAmxU+TIpQPh?=
 =?us-ascii?Q?IUHXEcBY8TQDHojuAUFHa2F7S9hvj/GSLFEL/XzT8Irn/o5XM0kE6yYMNVou?=
 =?us-ascii?Q?6gQ2D4zlHcMACYQnUOH47QffklyeM6xulIyaNIDVEfCROX1b8S4tS9Wzbjx9?=
 =?us-ascii?Q?Uxn/u06NWjhQ60BBIKn+H8h0VzYN8yejC8XJsoDEBWw9bFayx1Q59Tl8elLc?=
 =?us-ascii?Q?yikdoLHsWJs1TUMse58anGQH3qIW8NEwXVsZStZb+SKT7m8sa9md7c3o1fPi?=
 =?us-ascii?Q?m718fppHTO0bizasW25z8fe579Tyxf8vQDxZCod5HDvlRc7wRprr1JUc2L1g?=
 =?us-ascii?Q?rOLKsuZlzd0PII3GdWioWocRiSqBMkq7NnhaCQUhEfEKVI01kr0fABrwoA34?=
 =?us-ascii?Q?F/x9E5nSREAUtcz88NxXvzYRc7HA0sofzgfv+AtRcmj/I/yUbLce/Azq3hAi?=
 =?us-ascii?Q?OH5C52ij7UpLvR44SlpgI5KUbJXJE3p9fjWtleTB25jL5wIe3Bv2npdDnkU6?=
 =?us-ascii?Q?UMDLKuJI0BzJmeb0elc9qnXGR05VPcCTWv7UsvPTFo/iq19bjZXnSJSyTcMk?=
 =?us-ascii?Q?MZj+VnxdChlP60mAW2n+/wJdJGpnZhhHjYhc2T/LnPVQy3kwhd1h7QwdMeOq?=
 =?us-ascii?Q?dVx8P2594qJfSlFFY+XDEdmxMnUtMEvZzUn6BROGDogZT2zOmXRCEEXAmfkf?=
 =?us-ascii?Q?/ieKBeDtIHA7O45A2YENEBn2RAKvAOOLRhlvNnAEd/uwlKIiFhmbn8W49/mB?=
 =?us-ascii?Q?pV88OoNJlLJbVbJhdC8sLDP6o5hxAxxtELUZ4d396H3/HjDcetLSL0aKuIfI?=
 =?us-ascii?Q?9xlAaaNjvMsaozdV4mlWknfwyoYHF11+0yBU7x3Nt8czgJUhl1qVbmDL1swM?=
 =?us-ascii?Q?aJd1v1M9qGYaWJdmg/hI2NJKK/7wNvdBpVV+o4EZTU/zZEYFvYQ/JzEaMy9/?=
 =?us-ascii?Q?+OgZdnE7CKEUQ7XcXI4lbjCfXpX7nZ2lbntBpdbyugy0QMvX2nLeieyp9E0e?=
 =?us-ascii?Q?An4V3eCC0KJcyMzgfMigxuZKOtA0bQfT6i6yzHEOaORL3dVi9PDuhp6qFPsL?=
 =?us-ascii?Q?+PO53cqSOjO6PnDfHsA+emh6hK2HJ6RFUqmI+aMk++sfOwPbx8zHMeGCWbnO?=
 =?us-ascii?Q?Qu2itRPRybQTOObnlWFD5KdoZ1hoIPc7jpru/mKpmzwCmEnn21GIt4NPwaeQ?=
 =?us-ascii?Q?8k4KUTKLJjh5iwonjodaV5fN5gmS4GlWhilwBa+7PROPr+FBxhOIsxZYYMiK?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e02f1dd0-a769-488d-5339-08de1d05266f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 07:21:50.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qP1Z+tOxlBR7UYDDw72g6zZXDYeuo/b4LVHb6M++R91nitayRkBBTTF1U/Gk+9Sp4DpBZQTUturmusHkSGQPrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
X-OriginatorOrg: intel.com



Hello,


as we understand, this commit is not the root cause of the WARNING. but just
changes the stats as below table [1]

we just report FYI there is a WARNING caused by related code in our tests, in
case anybody think it's worth to look further. thanks


kernel test robot noticed "WARNING:at_kernel/liveupdate/kexec_handover.c:#kho_add_subtree" on:

commit: 91cb1aaea4b8276323b3814d35f6e62133f64c1b ("[PATCH v9 7/9] liveupdate: kho: move to kernel/liveupdate")
url: https://github.com/intel-lab-lkp/linux/commits/Pasha-Tatashin/kho-make-debugfs-interface-optional/20251101-222610
patch link: https://lore.kernel.org/all/20251101142325.1326536-8-pasha.tatashin@soleen.com/
patch subject: [PATCH v9 7/9] liveupdate: kho: move to kernel/liveupdate

in testcase: boot

config: x86_64-randconfig-001-20251015
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)

[1]
+--------------------------------------------------------------------------------------+------------+------------+
|                                                                                      | dc74e80622 | 91cb1aaea4 |
+--------------------------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/kexec_handover.c:#kho_add_subtree                                  | 8          |            |
| WARNING:at_kernel/liveupdate/kexec_handover.c:#kho_add_subtree                       | 0          | 11         |
+--------------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511061443.64dd159-lkp@intel.com


[   12.679864][    T1] ------------[ cut here ]------------
[   12.680514][    T1] WARNING: CPU: 0 PID: 1 at kernel/liveupdate/kexec_handover.c:711 kho_add_subtree (kernel/liveupdate/kexec_handover.c:711)
[   12.681526][    T1] Modules linked in:
[   12.681957][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc3-00216-g91cb1aaea4b8 #1 VOLUNTARY
[   12.682956][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   12.683951][    T1] RIP: 0010:kho_add_subtree (kernel/liveupdate/kexec_handover.c:711)
[   12.684514][    T1] Code: c7 58 2e a7 85 31 ed e8 31 1a 00 00 48 c7 c7 c0 12 c9 86 85 c0 89 c3 40 0f 95 c5 31 c9 31 d2 89 ee e8 57 a0 13 00 85 db 74 02 <0f> 0b b9 01 00 00 00 31 d2 89 ee 48 c7 c7 90 12 c9 86 e8 3c a0 13
All code
========
   0:	c7                   	(bad)
   1:	58                   	pop    %rax
   2:	2e a7                	cmpsl  %es:(%rdi),%ds:(%rsi)
   4:	85 31                	test   %esi,(%rcx)
   6:	ed                   	in     (%dx),%eax
   7:	e8 31 1a 00 00       	call   0x1a3d
   c:	48 c7 c7 c0 12 c9 86 	mov    $0xffffffff86c912c0,%rdi
  13:	85 c0                	test   %eax,%eax
  15:	89 c3                	mov    %eax,%ebx
  17:	40 0f 95 c5          	setne  %bpl
  1b:	31 c9                	xor    %ecx,%ecx
  1d:	31 d2                	xor    %edx,%edx
  1f:	89 ee                	mov    %ebp,%esi
  21:	e8 57 a0 13 00       	call   0x13a07d
  26:	85 db                	test   %ebx,%ebx
  28:	74 02                	je     0x2c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b9 01 00 00 00       	mov    $0x1,%ecx
  31:	31 d2                	xor    %edx,%edx
  33:	89 ee                	mov    %ebp,%esi
  35:	48 c7 c7 90 12 c9 86 	mov    $0xffffffff86c91290,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	3c a0                	cmp    $0xa0,%al
  3f:	13                   	.byte 0x13

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b9 01 00 00 00       	mov    $0x1,%ecx
   7:	31 d2                	xor    %edx,%edx
   9:	89 ee                	mov    %ebp,%esi
   b:	48 c7 c7 90 12 c9 86 	mov    $0xffffffff86c91290,%rdi
  12:	e8                   	.byte 0xe8
  13:	3c a0                	cmp    $0xa0,%al
  15:	13                   	.byte 0x13
[   12.686315][    T1] RSP: 0018:ffffc9000001fc58 EFLAGS: 00010286
[   12.687184][    T1] RAX: dffffc0000000000 RBX: 00000000ffffffff RCX: 0000000000000000
[   12.688370][    T1] RDX: 1ffffffff0d9225c RSI: 0000000000000001 RDI: ffffffff86c912e0
[   12.689572][    T1] RBP: 0000000000000001 R08: 0000000000000008 R09: fffffbfff0dfac6c
[   12.690762][    T1] R10: 0000000000000000 R11: ffffffff86fd6367 R12: ffff888133ce6000
[   12.691996][    T1] R13: ffffffff85a72d60 R14: ffff88810ce59888 R15: dffffc0000000000
[   12.693231][    T1] FS:  0000000000000000(0000) GS:ffff888426da0000(0000) knlGS:0000000000000000
[   12.694585][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.695569][    T1] CR2: 00007f6d5dc8f0ac CR3: 00000000054ea000 CR4: 00000000000406f0
[   12.696832][    T1] Call Trace:
[   12.697400][    T1]  <TASK>
[   12.697922][    T1]  kho_test_preserve+0x2fa/0x360
[   12.698835][    T1]  ? folio_order (arch/x86/kvm/../../../virt/kvm/guest_memfd.c:181 (discriminator 3))
[   12.699556][    T1]  ? kho_test_generate_data+0x107/0x180
[   12.700561][    T1]  kho_test_init (lib/test_kho.c:222 lib/test_kho.c:327)
[   12.701312][    T1]  ? vmalloc_test_init (lib/test_kho.c:314)
[   12.702100][    T1]  ? add_device_randomness (drivers/char/random.c:944)
[   12.702924][    T1]  ? mix_pool_bytes (drivers/char/random.c:944)
[   12.703646][    T1]  ? trace_initcall_start (include/trace/events/initcall.h:27 (discriminator 3))
[   12.704499][    T1]  ? vmalloc_test_init (lib/test_kho.c:314)
[   12.705291][    T1]  do_one_initcall (init/main.c:1284)
[   12.706047][    T1]  ? trace_initcall_start (init/main.c:1274)
[   12.706897][    T1]  ? parse_one (kernel/params.c:143)
[   12.707623][    T1]  ? kasan_save_track (mm/kasan/common.c:69 (discriminator 1) mm/kasan/common.c:78 (discriminator 1))
[   12.708394][    T1]  ? __kmalloc_noprof (mm/slub.c:5659)
[   12.709218][    T1]  do_initcalls (init/main.c:1344 (discriminator 3) init/main.c:1361 (discriminator 3))
[   12.709976][    T1]  kernel_init_freeable (init/main.c:1595)
[   12.710752][    T1]  ? rest_init (init/main.c:1475)
[   12.711473][    T1]  kernel_init (init/main.c:1485)
[   12.712165][    T1]  ? rest_init (init/main.c:1475)
[   12.712871][    T1]  ret_from_fork (arch/x86/kernel/process.c:164)
[   12.713609][    T1]  ? rest_init (init/main.c:1475)
[   12.714326][    T1]  ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
[   12.715029][    T1]  </TASK>
[   12.715548][    T1] irq event stamp: 131753
[   12.716243][    T1] hardirqs last  enabled at (131763): __up_console_sem (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:345)
[   12.717702][    T1] hardirqs last disabled at (131776): __up_console_sem (kernel/printk/printk.c:343 (discriminator 3))
[   12.719185][    T1] softirqs last  enabled at (131460): handle_softirqs (kernel/softirq.c:469 (discriminator 1) kernel/softirq.c:650 (discriminator 1))
[   12.720632][    T1] softirqs last disabled at (131455): __irq_exit_rcu (kernel/softirq.c:496 kernel/softirq.c:723)
[   12.721755][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251106/202511061443.64dd159-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



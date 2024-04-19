Return-Path: <linux-kselftest+bounces-8418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B126B8AAD39
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 13:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14042B2277D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 11:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D2281720;
	Fri, 19 Apr 2024 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyxaNGkZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410CE8004B;
	Fri, 19 Apr 2024 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524569; cv=fail; b=qo3BfVhpthrntBhBdVNWUzQL3ntXvX+w6Hibi8RMuNFpqf9wbz+SbUv2+mdCAm0/lyCuxQ1Y3kPDN6fjMtPPePJw5s3wZ4VfLjPaWFLVwmRSXAxiNHWPmtgzueiSuTBeDz3Ka1YL+lQZ2dwsMX0ndhgaZ8nu6DRq2cVzGkjV1DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524569; c=relaxed/simple;
	bh=21NuqLKztBTqn8wlxcqiwqAQYb7yLyALLYUi47Ae9dM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K/+UAbS2D2lF5BAm9uxTS9C5RcztbRWGUWmr8gDR+cNYj77g3NCjwAAYUnxebk9tWmyHCdEJym0VU3HFIm7Id1H+jgBvfNAUBchB3jR1M+sunwEVd0wVvkXaSEIIaNhD4mcUEz+E5wLP3HPzy/PoGP9r1WeTsnDCvAIGk23PWEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyxaNGkZ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713524567; x=1745060567;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=21NuqLKztBTqn8wlxcqiwqAQYb7yLyALLYUi47Ae9dM=;
  b=QyxaNGkZ/pprgoMzwviLLTx18pc3xru3Fih/hkq/NAFTVfgNVPTmQH6o
   6mFdmj/ZxeD7qiLnJOKWpmraH71y/J1l8VIu0vchqvwoNPpUnbxZ5liLG
   vLtyepHvZp5Fn40nn+4C3ojsd5HgeTBl1vBW5Cw378rWqDys8G1P533Jt
   eV/Kl8pOqgXiJujQXss7VUAiysRROLQloIyzEXMdCGY5dXSyE0D6439Pf
   cGi6TYEgsdnJxVhMLUOEeoqgHHPX6+hzwvU1cEVzpeZcoL1f1K5UGd/YP
   xygysBKEYfARS4br+TXqWXxAAjLxXxJMVaQWkRCCKYSmDABXPR0PL5SUO
   g==;
X-CSE-ConnectionGUID: SVLiSMcOT8yAcnQfUVZ76A==
X-CSE-MsgGUID: S4qS9FttTiuVJDuLg7wYng==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19683809"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="19683809"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 04:02:46 -0700
X-CSE-ConnectionGUID: CTt5he5yQQWieW7PRi+daw==
X-CSE-MsgGUID: nuuYljVYRq60KwtmmK8xSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="54218497"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 04:02:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 04:02:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 04:02:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 04:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cqov/vnB+PiTTYgumVWTN37rDbvA9tpnhYO2erbuqJexUybm8CuizNYYmqSYodBORd16OvkA1Z+Ke8018k/9Ndu4UxKf1ZodAPlBaXPE9cVXIuYk7BhFIVUtizY8py1DdRqM/htquqEwZ8dQ1s7N1z3W/7USB15Oq5YlEhUquzhCdeecWtMNBeinRozc3G9d1HjZMH6y8CJEproLZU25yJxsOi4ntZXT7ZiNZ0poLytJTLd2PjMxK0ppCVULH4os+c5noS/H1z9+pMyfOkvFb6FsXyk/MeezbGuiKrnoyPyhqH7DnIYGPcPoKEGzToTm4l8z8/uNrbKtuSmYQBJRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21NuqLKztBTqn8wlxcqiwqAQYb7yLyALLYUi47Ae9dM=;
 b=PlO2+FGGBZ1oWPxSwDtMq9ZiA278fVupZeujMDQDUrvdy9+uMR1ndBQDGI3E6lxo8ohHwBEegAQWd3b8kG7JyrlA5Wk9wEsoRN4dcdaolXowg/zbujVP9moHsSbfeHCo5PDyVIb2FFUqzrFBfzq3kuJ2pyR6BmtLaY0La5siCuZSDkno9BnxFthr5cG/eEID5kAtOleSb+7BzP69QS5Z60vgaQ/WiAXfI6o1WPDY8/xHoeKCigoTiFRaKLQ24R2ntzP4pYOVvROkpqfZxU/9W7jrpJ0no3W7U/w1sj0Gnv0QJZyZaMXG5KYDxMsUGunZA6YHavZSNcu0Bw3D9dDwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 11:02:43 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 11:02:43 +0000
Date: Fri, 19 Apr 2024 19:02:32 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<shuah@kernel.org>, <vkuznets@redhat.com>, <peterz@infradead.org>,
	<ravi.v.shankar@intel.com>, <xin@zytor.com>
Subject: Re: [PATCH v2 06/25] KVM: VMX: Defer enabling FRED MSRs save/load
 until after set CPUID
Message-ID: <ZiJPSCO+U7iLWiuu@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-7-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-7-xin3.li@intel.com>
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH8PR11MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: e6cb965b-1408-4685-2054-08dc60603cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rv4Z9HEX9wtmBUiedyPIB8cpZJJS80Yf8nBL6wdph+6Z1rr/ehJrLcW3iZaNDnr3PlBv4dqDsyS8RYi27dgCmw3KiKtOpm3iktLqEO9tIUVUSDa9R6bHpSLB5wV5CA2q/D1pSlrBx/ZJwF/QGrPZtNoKHz/zcnuzG36bsTvGrUgNiynXQ6Qm4UXyX8bXs8TcgmDFOoj8LWgrKLIatn3CdVj8kU7hGgnB6mtSF1jf6fsgvJdNKldiMBziyYrKX+mnNbIKLt1gIVR7cKs/KN675eMWIdN42+LOrKfr470B2oNZZ7hjXgCHtD3xWww43X1DS8+Kgs8SWPPNNHdrp/YN15slRaq61OH44+STxJhVTt/4t2MT7OTF3UoZ9Iqjit6ag5zzEXcahEhqG7wOkN85E/ahnIxR8c0zGXxY2Y/ld6jvc2WXgU6BDZJF9PNaIuhDiQzeRM2p8KBqQh4gT4AggBWFeIYUxJOmIFhH/XHfmXBUjnsRBnH8OsmAgyQbXEp3iipxY3qIqBMJ+bVD7D/pHH9TavV9tcmGx3ev3dRun7T1hlm9Sp9mZ/hJIJRCMgl5TUtPQ6Y9EYR0uha1k6D+9t7sgY2l6ecK/0hzRT/5gNQMYjfTeaaGLa8COWBtJBMED0Qphun8o52WEEX4zVA2OAQOc7w8HkYe5aoDW/XJ7NA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2La3TbQyTlfJf1ZK+p/xB4zNJ2LbGluN4sGtYEQhQLWl35CmNhCZ5Bkyqm2t?=
 =?us-ascii?Q?x63imsgdMXPqccJQf2P65u2vj21+7iONJGuIgi8p5v+R2I/Z+KTq6YsdfHID?=
 =?us-ascii?Q?f2/zcqgIuiixS++xBhmQaCJELTekEdEBVmtzT3oEDTimbBlpNWxIz4vkcRcr?=
 =?us-ascii?Q?4Ls3yz/9XMNioFWoaAiVHTOLakcOawb1S2vmZWiTCCamZePca/ukyb6admrr?=
 =?us-ascii?Q?r3sFlh8cGieAo99qez1xz3+5IuCIfsh3SRIhOW6qMABvrOFq8yEVfhpCXmdm?=
 =?us-ascii?Q?aCSbE+fBuUSuHHWJEDiIh+y3WAApoYu1EtI9pGnrLNP0GV5v4W1ucjRYi/Uh?=
 =?us-ascii?Q?2IcfdKbIwtPh2RMl4apM1Eba/0NwaAAaWBAtPVXkD9ijrfSKt+WENLDrxNvm?=
 =?us-ascii?Q?jA88QOc3LWGxE/5yINHi3h+HNs0whbCq8ivSt2+o/Fxy/rakZ0qISK7yCPAl?=
 =?us-ascii?Q?13/RnYub234Tvybw1D5K9y947xfSJGNIcSYte6I/h1gyA4LmCZZaOSQ0egG0?=
 =?us-ascii?Q?2fn1utGI54WfbbFUNy4Zy10gA2sWp/tT0VXbunrtP8whr7TeBtzP5up7HLLu?=
 =?us-ascii?Q?AofRL/H4OtWmLz2pN4oIVqn9JySNDhwgLhXZbNGd+XY3+SZ5YfXHQho1GmOu?=
 =?us-ascii?Q?tw4YOecBeJYa6jJASq5lWIUjR/zF/SlnKlNbRAEjkvbCeUSAWZCqNaFY/5sL?=
 =?us-ascii?Q?QhX4v+nbD8YeA+q4I/1czg6pZiZC2hUMlSvR/ApsX3b8gJyYy4wq0Sjaf2OX?=
 =?us-ascii?Q?waBBUKWwNdVBnqIEVKA7wZhMm2eVvbvrxMmN9TR7GAi/bcygb69K5TYVLS8Y?=
 =?us-ascii?Q?SGanN6+10Xdpmco/P7Ai7tGGuJjv/VN/1ar2VM1qsFU+zh+VFF4PdVbx32KC?=
 =?us-ascii?Q?5yTmZ57hh7e5m72VPEKT85G30JiD7xERu3Kdw5NLgwosNlKhruAp4dlom+SU?=
 =?us-ascii?Q?k8I2dNlJH13YAppx95aF97WG8XSCenhvOZsYRGIBgpfp/3j+utDw0677FLvx?=
 =?us-ascii?Q?Ccsq+EwGg5KLtXBbXAXGQPlxuwvE6n0E1pJFSTkspesfS5C6qPR25BOvYq8x?=
 =?us-ascii?Q?xdcbxFuJ+48MYqCbUcd55CGExMmyLU8f6f7zF3PatpXc/aM5wLoDMEeJfqpq?=
 =?us-ascii?Q?+F6WhB8tsJTKFflZvQw1Q+ayR7qdP58/QlEcfYmlPY4b8HyvAUPZS7zpayiv?=
 =?us-ascii?Q?7et8Szm6cClI2RIiH2UbvE1CjgW3Q+7bMvoVCQkfRIy9aFWD1150RmmD4KT1?=
 =?us-ascii?Q?qpEi/sitXWSvpi5ESMkBZp/4KgwzWkLgjDEHbk39PiU70PkEkBlfuup12o/9?=
 =?us-ascii?Q?1WWBejPtNhfgmNJ+Zo5KXGXgHWz6AJOTTQyb7ujE+1jL4FeiJSo4s9Y03tod?=
 =?us-ascii?Q?0Usb0TpCDMVY46VgXuySWaN4O+izikfmvqtV4H1I7n1FKOnJZtrO4pqufzPi?=
 =?us-ascii?Q?abWZtbHPOX1VRmhYqSuGbhD3eo42xhqitZtfzOZ2ssq9s9pD8fAZjf6dPT0X?=
 =?us-ascii?Q?Cxo+34nZbkFp45GtGKZpVS7DWTJ685TIzOxSFZaummYKYSqJJzYMAiOLTDo2?=
 =?us-ascii?Q?1h99DAKqdEepwrueljKsmdW+v3h7yP4+YxyvVFVO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cb965b-1408-4685-2054-08dc60603cf0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 11:02:43.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYFInZ43Z8MNq16k+mO1f7FIiSvCEGT4p5UlDe58arXo75tvdblM+EwGDbDzUuxlE6//tPft1P8L2d5z3lmqow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
X-OriginatorOrg: intel.com

On Wed, Feb 07, 2024 at 09:26:26AM -0800, Xin Li wrote:
>Clear FRED VM entry/exit controls when initializing a vCPU, and set
>these controls only if FRED is enumerated after set CPUID.
>
>FRED VM entry/exit controls need to be set to establish context
>sufficient to support FRED event delivery immediately after VM entry
>and exit. However it is not required to save/load FRED MSRs for
>a non-FRED guest, which aren't supposed to access FRED MSRs.
>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>Tested-by: Shan Kang <shan.kang@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>


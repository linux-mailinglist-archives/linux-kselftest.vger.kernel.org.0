Return-Path: <linux-kselftest+bounces-8417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423828AACC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 12:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76D5FB2133F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712E7D3E3;
	Fri, 19 Apr 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZxFLuElN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5037CF25;
	Fri, 19 Apr 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522270; cv=fail; b=gBuHNQbgmr6WMtMmvt1Z9AqXy4sGQsLeWd5Ga+AqojoiPzdYkyvNbMbNqjUXsTU3qy80o70G0kNxvwoE94aVnoBXKFZNBoa/uuFQrePlDkSK3jMPfzb3KmgRChQosDZc5IWsw05OSj2H5vqnDTNu//IaKppK1xrHFk9EHiMVUmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522270; c=relaxed/simple;
	bh=twQbK3PgLlDj+cu10LWWAzcqNYAsoUtgiKfbPp5pAIk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IxM+4Tol1ziotsT8jjNRD4ndvCxB3fFPJ8jboaeg7t73FAj1thZX1FDtf0XRYffQx5zYNWClS7OTqbev1GoKKN7aTWjgc3d+dQKub7KjiSBaqjiH3ZwEvxl0lcAESMsQdWaTOeJIAtPyHssSV2BUuCDlSXfkLUAQyXQYe6KjCHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZxFLuElN; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713522269; x=1745058269;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=twQbK3PgLlDj+cu10LWWAzcqNYAsoUtgiKfbPp5pAIk=;
  b=ZxFLuElNCfSMUKqgC01HcGoKaNTaXgSYwWumpd41ihYYpUyYyjan26mB
   uZ3eKB+yVOhnGzB19Zxh4zH0lhRp/Q328tUae+2uvXt5k4EV25fXY4Hrv
   m7BJAYQwrb4KVXFtE/gAZTnoUgKZ+LhYYf0IY4mJVfvRQIfNzf57EV4wS
   aekTD9Djl9efdeUzzgznUwK+J2eShKMh3KrWwryz+dDtBOMUi2ZIApwIq
   1X4V/OUGgkaSZnXasR/+vRPrnLmVEZ4EyuhWGBHTbIXt1Ab2Dy7zwQgJg
   AD2B+8Wb6yNsYW16Dik2BlRXrOdIP/Qjnr/FaMo4/BfSXMHKStT7ExIVW
   g==;
X-CSE-ConnectionGUID: tdAEPQUMQ0axHVjBvfQTOQ==
X-CSE-MsgGUID: 92YTZRfATOugeKHhCvNakA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19813007"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="19813007"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 03:24:28 -0700
X-CSE-ConnectionGUID: ioLPADuISzCmwj+latrVxg==
X-CSE-MsgGUID: vOCyr2cgQPKSMEUXASFm7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23306965"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 03:24:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 03:24:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 03:24:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 03:24:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC8y8ikPMwWg7Y16gJ6U9tgXWW30g8vG7nG5cwUuBDvh7najrz9jS3kZkJK1ulxYXUuK9WzQKWWxKb2U+XO6uK+DiEqRijy5L/+gd3I4O9ZkQBJvEl8PKJJcgzRUx7gGJKbLZ99T9tOTcXTCL8hNXuTC7XYcBCPDbNpCuzq6gBkGUr0T4mmyCFR5iNzvTvt/iR/SSknkjsU7btTEXRluehtiRCnsYP2BWjyxQf7RLgyuYvLYtEQILuKXNQEAofcA5nToR8A6K5FJjdwvBk2ax/xZs8jDrgbg7dceArf9Ym7Gy3O0mOrGdSbToIBMwPaTx1UO6F2Y5OIR6tS9pfxyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPc7SaUgfyAYLNUfISOfcV+GJP7FidTUqps+hj0Rb6I=;
 b=BPgQZnZNyCTdhtbhWkYChRMb+OHeD4FAu4KSJkFXHNm+HqzLKdi0iWX1Sand2d5PUVFSg7rlPlFiYMZt+rKixiV2WUQaTWha407//lp9ekzdc8UyhINSqQ5kpkwDUidlhzhNBWjIG6X761SULVGCcem8hJWRuwI5Pd1RATXvystDR6Ejah/EIQ+J+Nes3rhaPUWMYukSmfs3ZekUNeBvexyv10TiVu6KE3+CyRJcTqFNjppbrjPvPTbxwGLTOLNfdIh8p/YG3ZFq2hWFMftBcjjA0XuZyAgAO38oAQ4hMfuw/a9H71Op/aUA4r2cqGtWAQNhUVZVNxs1KHelHPsW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DS0PR11MB7442.namprd11.prod.outlook.com (2603:10b6:8:14d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Fri, 19 Apr
 2024 10:24:26 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 10:24:26 +0000
Date: Fri, 19 Apr 2024 18:24:15 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<shuah@kernel.org>, <vkuznets@redhat.com>, <peterz@infradead.org>,
	<ravi.v.shankar@intel.com>, <xin@zytor.com>
Subject: Re: [PATCH v2 05/25] KVM: VMX: Initialize FRED VM entry/exit
 controls in vmcs_config
Message-ID: <ZiJGT7aH8FfwIj5/@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-6-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-6-xin3.li@intel.com>
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DS0PR11MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0dcbb9-cbea-4007-b5e5-08dc605ae396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: wkJnYiV1isQUhCFYRYZomA4NAtfatBDkr/7/iUGcju+sLaEJSlnylFt0Uk6ELAiUNIEBqoHRVkrrUzvxCX/fenuQ4Y1YzWJzkeFRdSF6sDuJfxmgTRfFuj/I4Z1BLA2o+0jtuYClJ5tjAYrARdTS1xf4V9iK7aVMgruVsBcaw08yHYoQUPTmoGlHhJhNuS9z2bu2hFtTELvWrk02Pu0aBtgdR8zJLwh8axcItE+kJdwnZLuvsm9bVaADYcahFBvkQAAHxwjGWIAV8eJZnMkj6W5AhKLpHavhWjyAPqbLtwTdUeF2/hSBCeCbbPecDPHOIDXkGI+fq7GnMAz3JiXQe3fAag1s9obmTHGY7KjgQDhuc4OdEQmlkLtHA7HWaJJVZx6VAMrq/c0gMJuqEm71YlYq9YWx+IWUbSdE2MAJRUl+UpdzwCLTzVnlXl++hzTjbSsnSt2mMSsKZogTMos9RzxuquiSZgH1vzcthq+t9pkGWQuH0Tmfpg3446Y67ut6PS1pr8YZkYBxoOYmhUyLd3GBLY0vvIlCbe7LIDYZwNfFkRw+YiHMdoGHDDITqjMfu9+xO0+mwjerrGIumRSKv7n2eiRGUCkbR8zqLmugDG+ztpdADkBtnND9dMECMYY+LrdDYVCd+RlP9Hffwk/kq/GX/0bkwfuQMOTePwz5ux4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mGQLDy+zhLn8RYfcdYxrdCjcyPmSBjHRkLPTF3xitvKyl79NzyACC69KEEmn?=
 =?us-ascii?Q?sLErRmbz3x4Q/6YeRXR0Vl4TuKcOJXMQlE8PDh0V9zVaq8tCL1Ilh9LClyRr?=
 =?us-ascii?Q?DQYen7yABRHynh0FfTJUPs+6EXXJiW9pcEkesHDbCwBFRVcj3ApLJFU1feYT?=
 =?us-ascii?Q?jj5Cbz9Lzs13e5/XcmjlfH9J+fYB61j+cFgef02SeO/u17E2JVVSZbm/Q/m7?=
 =?us-ascii?Q?upSaeZv8X50tAzJPVAC2MJSgSdR2j6Cg6Cw5aZEd8OrgkqqHajfmG+24NXd1?=
 =?us-ascii?Q?xXmHtfnRig2zhrOPzJnqAGFwQfnYrvhksFQFy7a52HDKxHUOBahfxlZzMXUp?=
 =?us-ascii?Q?WMrriqaaRjxTaOKnoZh1/kbeYst28VlP+ymZZbI2CnFErP/dbpT57PbgXOuX?=
 =?us-ascii?Q?rSPb/mBtP9tRJyy6uikGNCnRQdiZz2PmpUBvwLy6oV13i7O8HNIbBU5Bytth?=
 =?us-ascii?Q?pC/4M4hQZISKDO6Ib48AOleMUaQLZP1s6gQR41M57WvEmAjYT+cukIVRSh/8?=
 =?us-ascii?Q?KQnFfQwGSWCn8xYLSURfdqv+NO9Q+8p4/OnTwjidDd8S9CAb6/+xULk85BuT?=
 =?us-ascii?Q?XTrURHbr4cN2muqns6MVMHMSFt6J910YgJhUTsPUJLUfi3q/9ax6OnHeGLEV?=
 =?us-ascii?Q?hDbnMEXFUDXiaSOYyuvag4U/jNvZpe2B1YjiFluuqLzTFLH52MaPhT94oSgb?=
 =?us-ascii?Q?/Gytd4raTCLwqJtARHFmQHPKf6eQs8EJn12hji+hiPpdQSPhY2X+zR1WXmrG?=
 =?us-ascii?Q?Zni6qRt/Ff6DPg1XGblx/Vy5cF3rOGiV+4S6+QM/O4U4mR8Y9WqyzNIw3HIf?=
 =?us-ascii?Q?qbxi6ecfRy93BFea2bhFI8HarA6Fo7hzffFOne0kBFEWlP1b5fivG6ZbKJIS?=
 =?us-ascii?Q?SKskQzeCeNYNWj0LsAtwhHLQODwHmrXS/ObyW8ExatudS2Kimz8n5xy2oCP/?=
 =?us-ascii?Q?Sq3phqF21YEqR6kNFq/SIOQ9G/iihKComcwR5S9hufQEOVumQCVJdeBelO3g?=
 =?us-ascii?Q?c8Xytj/L7o9GrfhSAo6VvbgBcEFZtW0QrGwMrJWf/Z8lAsqo7mxbaStecKYe?=
 =?us-ascii?Q?u6sh43jJVMYJnu1MlYLb2n4waISXuJ7sIm8HHfXJNRbfBuYaFGLhKu9IZyXd?=
 =?us-ascii?Q?qjov1tpQub/1BleU+4VRzCdomEk9NW5EAK2KIrZ4pXkpl+NFQ7k7suZuOq/Z?=
 =?us-ascii?Q?UUNk6NTGo30pGJcEjKC41ARyvzUOuF8CspE98SPX0dPGzdt50VZ5yuWm/Xil?=
 =?us-ascii?Q?HsdNaMDlv/WEhM/dnRl5Vx2DPls6b8sl/I90yNYYUWUJ1Shhl+HTw7kU72lW?=
 =?us-ascii?Q?358vQY1FYBY/xYGu1RpZMwvN6IxfMphjuZrOEGMhhUY7SQbTuGHmvc8X3adj?=
 =?us-ascii?Q?Hywos6P7EJ2Qr7v6LCFL1NhdIm57kZk1vnKzBcpdp5UfHyctyQa3AWd4fFJf?=
 =?us-ascii?Q?H28jD2RReo0Cc1xM3+AoTC8RN05J9YQb0efVSyCG4jA7a8a/duNL1pZKBwUK?=
 =?us-ascii?Q?IUHgt2g5wa2fMbVaGOgBMITsj5dlDAP+r+emCzyxboN8O6PI8ycQK6UG05YF?=
 =?us-ascii?Q?kIA7XEgm14uelYZ5hy/ruC3T5AaRYNvm4lG7JPI1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0dcbb9-cbea-4007-b5e5-08dc605ae396
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 10:24:26.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0mx/+tWK/NU1gpoe0doVw15NPrI0shy6nWtoLIZgOXUKUQyoQJ0rVllJyX1pUcof+sfGeEMuanxH1cJ7WCxag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7442
X-OriginatorOrg: intel.com

On Wed, Feb 07, 2024 at 09:26:25AM -0800, Xin Li wrote:
>Setup the global vmcs_config for FRED:
>1) Add VM_ENTRY_LOAD_IA32_FRED to KVM_OPTIONAL_VMX_VM_ENTRY_CONTROLS to
>   have a FRED CPU load guest FRED MSRs from VMCS upon VM entry.
>2) Add SECONDARY_VM_EXIT_SAVE_IA32_FRED to
>   KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS to have a FRED CPU save
>   guest FRED MSRs to VMCS during VM exit.
>3) add SECONDARY_VM_EXIT_LOAD_IA32_FRED to
>   KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS to have a FRED CPU load
>   host FRED MSRs from VMCS during VM exit.
>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>Tested-by: Shan Kang <shan.kang@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>


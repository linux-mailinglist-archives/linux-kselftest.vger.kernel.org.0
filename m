Return-Path: <linux-kselftest+bounces-9116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B468B6DB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 11:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5721C2244C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C036D127B68;
	Tue, 30 Apr 2024 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOLdZ4Ci"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568EB28DDF;
	Tue, 30 Apr 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468180; cv=fail; b=WGtODih2aKgWp6evx8BApvxYy5//mwXHuAVJsQWyo/jQnxhl8ZyRzMB3jUq5HVtOA1FkzyZIM+6CeuDfwMiHJui8728YgJfRIz/uQCy6IhIXeJ4hg5y2Z/01OquGUdZgFRch40sVPbrojJW02NDO4RI5gor9AyFibBKwFzKSXRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468180; c=relaxed/simple;
	bh=RpXiJuKXzDz0e0jGE5XInDYSqnHc1KUZuYZrFvEsCtg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EHpgUwHAAFRokUi55aTeMcnTfjOK+E2G8DdgS6DzhEdNXdVb6h5+E2ZCfvKQ+qVBJHC/KjkWcGOYkBSk0HezJB0jy7fvBx4Y0rO6c8ccbM+3xXG6zO49cFJpVch30Z8BoUnJDzypn5zdddWOeUmqXmdpveTRJDj6jBICeAQ+wUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOLdZ4Ci; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714468178; x=1746004178;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RpXiJuKXzDz0e0jGE5XInDYSqnHc1KUZuYZrFvEsCtg=;
  b=aOLdZ4Ci9ncFTpfZ10h7bti9/ftu/OonCOPWcxU3osIQNtG9Kz73ROXN
   hDfd9ywcCwrftLcg/gt2EFpqUHYRQ68YALCP0ykPcptpvLlFwf2MeOZMM
   qasDJNjKTAtVSKEG4PDR0EqdEBZxSwcRmxkARj7rYEBV9yzFGXRNHOGg9
   wfzUY8ai+odSJX66gvdERbhfjjV/qsBxW9SpR4a0i/4nY7Po5A/ApA49e
   T70vE75M6sugJF+wCy+NDifhXFbUR/tAsCoaROUzJB3Gm4SIdABFKGLqO
   zBZzAuFCg/me9x4CnrSHqnfMFYVS+WHzuJD75TM3NKUBIGO8tJ2rAohKa
   Q==;
X-CSE-ConnectionGUID: dU+TICfdR7+5nmidMg6YjA==
X-CSE-MsgGUID: lacFEC/bQyywAdM4CPxpcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13957958"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="13957958"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 02:09:37 -0700
X-CSE-ConnectionGUID: W68dqVJhQwOhk36giz8fhw==
X-CSE-MsgGUID: CaNaFgV2T++U3ZWMvarsKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="49599565"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 02:09:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 02:09:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 02:09:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 02:09:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 02:09:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQegbz1VTRdsFzV/ckl46AVxb+DgponUTlWxsmJWtFwSGnUwZ7s9PMUitC99mqvZbSrXNXzaIu9zsNnOe9espI1u7/UZuJeB37EXdwwiGNrtk/sJtfdhripjLWunXRG5rM7rwI59dyTO9nzzPtAWBbBkJ4/93MOwesqZjZ1RP6vLoJpJnvjD/PrFCd3XzOhMhoZXqwTyhTdxkM4bqkkNwJGgm09MMUAOWJuktBTgMz1n7PFbb/Spf1se7XTI+A3bkAqAoRwijcK8Xb5Vu7LC889L+rbPU2rY8eOsi9HjF2hOlh1QDYnD+0rx2pAZTpNHmMV09ECtueqKJtY8LXe35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iuAMCX7oU6GxIS1IgcC1cwDnMEPfnS6ZsF1r+8OcVE=;
 b=AhXB/7pdncQQkjomJ9pqa8DEBfgTlyJUnX5qiphG4A2oRCxolwLhSDSv4zJUKhIxMOvB5brZ5ate1YCQpUnIC1FUOOq6reptYPwd+4hRx5okBUeAjnNYHfp8KuYZmXF+W9INHOuGWl7VSeydlh+OPLRUsL9g0hNl2YcXdhBvZtke1aPLo990R4/mTEWVBVWkoF6Z6UuC+O16O5rHSBdjDkxUyx9ntYzFGH3FAph5mo4SeKQwf1RcfSKVO9xdq38DA9wWttuOiJY45eeHWGTBhxm/oz6dNdxg0R4ilDNaOlzxUtk6FfkEpxldiXh+y/MkIsPhItvMHp266YzoesTXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH0PR11MB5927.namprd11.prod.outlook.com (2603:10b6:510:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 09:09:33 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 09:09:32 +0000
Date: Tue, 30 Apr 2024 17:09:22 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: Re: [PATCH v2 15/25] KVM: VMX: Dump FRED context in dump_vmcs()
Message-ID: <ZjC1QpnyQA0gHoo4@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-16-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-16-xin3.li@intel.com>
X-ClientProxiedBy: TYCP286CA0307.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::15) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH0PR11MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2a98ab-d61a-4de3-b22e-08dc68f53f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P5BgR2PHfNIOKrP2M/+N6GB4jjGuaCn3WeyKQeYqLfF9WL8DMEnF4NabSK3W?=
 =?us-ascii?Q?x5hj1SQQJrAQdfpAnHF9pZxNc0Fli/HLEN5PPhxEvtCP4HivIYaHtYmobcww?=
 =?us-ascii?Q?EkfPbkf98M4A3ydpB1PuS3v9yWkIShJmQOrG9Yddi9mdC081V8Z9o7NXmGec?=
 =?us-ascii?Q?sFW2SARealYEJjA5bKNeF7MTN0rIC2YiQRc7U/zBSgduJHTRPUmyERjzOjP4?=
 =?us-ascii?Q?J4C8+VP+J6eiPTXFMFX+OAWtf/Zk8adqKXP+sfuc9pz8dQE7PjY1AdLZKvUi?=
 =?us-ascii?Q?pIOIFiJpfCOrLau1tQMTXhYVuYUvzxMHG77nwV/iGlJuCUcD/yat5o2Nn+jh?=
 =?us-ascii?Q?upn4pUTz6/MRNOUUisIGXzig6prGgmcpZQdt4yHzfEtfbMA1e+LVfZwhB0tV?=
 =?us-ascii?Q?662xhr4sl5MPC0zbxrgaytYohzXeqUHUUWwlo1KuwkfRI3kc9i5ldcPw3jow?=
 =?us-ascii?Q?Q+je9wZ8x5vuqBKigYtGLpRoK3SPFCyYEs8zXHUfvyEKxUdrRa5poblMRqj/?=
 =?us-ascii?Q?a2Mqzcg0bmAJbA1T9EXspmD/6u7PMQRoO1MT2ZFxVN1tGqipMWhHFzcwCxOe?=
 =?us-ascii?Q?T1MHaxqFV/+TYBErYOGTBIV2dsDduPLJ3pp8EyC1DC5QhLDMCxaTvb2zhq5S?=
 =?us-ascii?Q?8a3LgiSJLSQQdzI+VDCmRW+F8begDZgDuHND19v7O/hln9QWTVfBJGsFOl+U?=
 =?us-ascii?Q?zMhY3ngXZ80b/6EiNRPPOv160VuI6Lu4Z3tWPGvYjfeO1JgOr2uM/guod9Vy?=
 =?us-ascii?Q?InsCwi/dSHEFTQkroaKWEcd4J2U9IrituMeFnr4tl0ezHpupQh8Eah9g6B2P?=
 =?us-ascii?Q?ko1axX00cQ+HIPGkJSOkIttr2PHV+k4AK+El8fHw2JrJHZE9G1S80FURYjjN?=
 =?us-ascii?Q?JKtVVq5oxFCUAMpuX70TFOeTheLMbdB46252H2FN9QJG8413A3DNwcy9IFtN?=
 =?us-ascii?Q?2YUyrVw1h6P0iczKtZHVgOwnq6ecLsQQWqNd4yt6XoC3bT/MlTuq8MyElMQ7?=
 =?us-ascii?Q?85SaPUCLlVuwxhKtfB1uxYlgaqIy8eYglPaj3qr6HkfqZfgeGwp7tGhCImhn?=
 =?us-ascii?Q?k32JOUc2ciIx5c6REUvD1eUShvxjyLTAuLOI20dQF+5EYYTT8y/qHOTJKgB8?=
 =?us-ascii?Q?+nOAqyC574I9dg/2hv2tkq6Zg4oIOLnny8f2ySFaRFujB+e5bfXtdc56BDE+?=
 =?us-ascii?Q?FZXoarRYOC6NrUoVaYRVM/Vr1pKjLS7TR32Vf1MWEOEqtOUtNdcTZQX8F84m?=
 =?us-ascii?Q?uYEwiG0TzD+mGOSw1bl3e14q/q8rdMrJR6NxPAYlTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HVoh91nMo8zKVH/NpxxqREAERcHupfoxusCwuFLbeOmBum6/8BYU5NRtaDyA?=
 =?us-ascii?Q?KSk7zfWr7WMvzoHDI5/djxBrXQFOUyYIzafsqiv3gWfWxpTOYX/AGY8NMVSZ?=
 =?us-ascii?Q?BKQXox+h1Bvt480l4Q+PBmWA9Q3EBt0I02hX+iRutXubAHXoLHIUY+SoPLDV?=
 =?us-ascii?Q?5PaSUEyY3fCFdmVQR0tq0ppFYwTdB276kMfsFCqZ/csaIuxfw+W0zQdSgrAG?=
 =?us-ascii?Q?Z41bGpPPW/hLvSzSV4WlG2b9EWmVjimV1WMF1m7CN7w6gQ1du+1O1hOWkuiu?=
 =?us-ascii?Q?W9t4puGjK2vVMiQnOjxO0sm6TELN85n9itXe9DBzbR3zAXMqPNq1WuUxFWe5?=
 =?us-ascii?Q?8DBWnONsygwm2O7YTPy9wvmU4HO3Q4pvBMrjDan0QDl9+WyhNbG8MYmvNEl0?=
 =?us-ascii?Q?6bwwGDDegF3MMMou830U2VLShGPpQBLNh0soFkalrGLZo08RLUxKhvOCAqzs?=
 =?us-ascii?Q?CvAlbvDbOkmchMhmZw5XYtdEHqUMaSquQIZmJ1aP2LbYqzNFzftY9UYUlu4n?=
 =?us-ascii?Q?SQ5D/O4h0H74v4EnAN1SLdzHSAsmeuoTNG5s2Xa7OeiaSpP//xeDQyWetPEm?=
 =?us-ascii?Q?ECkz1zDl6DRMrejkwBq/SA/9+HR5eHcLAcKkcThDm8T6xHmVGrRDX4Mws+8L?=
 =?us-ascii?Q?SzwVMk5OHjxkcexaqNsoankGxYO9K9ElKV5t7R7hcguE2BlQctYTyGQ68w2r?=
 =?us-ascii?Q?YBzjOByjDJ/WJ927dr60d5a9jlAMggfl74ZRH2EPI4ih7kQnKgqsYLowbnG6?=
 =?us-ascii?Q?ocit57nw16aMRyu7aGaM9VMIURptw23pAWGE/bFcfGR//3no9c3boB6izbVu?=
 =?us-ascii?Q?GJXL+zoui9l4gnPaLaxBu5kc2P+hQAJ4roAssZyUaHgg3riM9dN/wbO/AXdG?=
 =?us-ascii?Q?JhouEORfWvP7UlFrnUX57bir2DRxlbx5dS+kFmllrIcIb1aEVimhTLzyTYo3?=
 =?us-ascii?Q?kQ+qRwQ5uheBNn2c6t6CdAWkPX5N2f1MTWnTrnLhYZjX0XBx1d8bK5LCypWP?=
 =?us-ascii?Q?MFyICuDZ+Zgi+NMha7eGBYEnU7UmpImD4NUfxk/8zzqUU4XprJlnP0oDOdn2?=
 =?us-ascii?Q?nAV7FDo0KO1oNYrwUWA9246Lgygx3//0paIORl7TAozREckS45X/Jt+y294E?=
 =?us-ascii?Q?t12JJmv/xE9NtXF95a3O2Gc8fUIAYHHiIdtJCMJoHRJTnKKPrCJensUqfpW9?=
 =?us-ascii?Q?2B+2U6Tdq4zjpscgK45WAT3vwUvYCxrnoLUwlzJ2o3HNyM37841HJm79gca9?=
 =?us-ascii?Q?e21oAVPksDfQn6OEI/wtdkwMpbGHDmNU9NQMLemvShz54KvwcnI5nQ3NjZcH?=
 =?us-ascii?Q?QPiUyIxSo63qFnU6X/TCzAbDJbXxL6Gtj1/8jkMHvTqCIyY+H1/W+Cm4tKMv?=
 =?us-ascii?Q?KYMiPUmEBfVgqmCoiNBcG8vGSJWrL72EZ5vKB4GIdYal8ghHqm4vdM8z8u7h?=
 =?us-ascii?Q?8XWPkJPX68u9lmL74hnuXCxX3yak2JuOAeiajFhtt6RjElsRLjka+Wdqz2tF?=
 =?us-ascii?Q?HbDSS2ebIwjalRN4Jp37yqvlzJRQxS+TIYcM45hE/UXViSWYeW6VwKavCGjk?=
 =?us-ascii?Q?J+LvzFcgcwHv5I0+KnfqlG7sDmOieBHbeMQFamzm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2a98ab-d61a-4de3-b22e-08dc68f53f62
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 09:09:32.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+efYIXUM4Blb4tjkKUJwuNC/QFbPU+sd0QxSwmnn5WXLBDBREVZuAxipFEcLAFnJrMlOzXBa8tifobZ9QRWBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5927
X-OriginatorOrg: intel.com

On Thu, Feb 08, 2024 at 01:26:35AM +0800, Xin Li wrote:
>Add FRED related VMCS fields to dump_vmcs() to have it dump FRED context.
>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>Tested-by: Shan Kang <shan.kang@intel.com>
>---
>
>Change since v1:
>* Use kvm_cpu_cap_has() instead of cpu_feature_enabled() (Chao Gao).
>* Dump guest FRED states only if guest has FRED enabled (Nikolay Borisov).
>---
> arch/x86/kvm/vmx/vmx.c | 46 +++++++++++++++++++++++++++++++++++-------
> 1 file changed, 39 insertions(+), 7 deletions(-)
>
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index a484b9ac2400..e3409607122d 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -6392,7 +6392,7 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
>        struct vcpu_vmx *vmx = to_vmx(vcpu);
>        u32 vmentry_ctl, vmexit_ctl;
>        u32 cpu_based_exec_ctrl, pin_based_exec_ctrl, secondary_exec_control;
>-       u64 tertiary_exec_control;
>+       u64 tertiary_exec_control, secondary_vmexit_ctl;
>        unsigned long cr4;
>        int efer_slot;
>
>@@ -6403,6 +6403,8 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
>
>        vmentry_ctl = vmcs_read32(VM_ENTRY_CONTROLS);
>        vmexit_ctl = vmcs_read32(VM_EXIT_CONTROLS);
>+       secondary_vmexit_ctl = cpu_has_secondary_vmexit_ctrls() ?
>+                              vmcs_read64(SECONDARY_VM_EXIT_CONTROLS) : 0;
>        cpu_based_exec_ctrl = vmcs_read32(CPU_BASED_VM_EXEC_CONTROL);
>        pin_based_exec_ctrl = vmcs_read32(PIN_BASED_VM_EXEC_CONTROL);
>        cr4 = vmcs_readl(GUEST_CR4);
>@@ -6449,6 +6451,19 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
>        vmx_dump_sel("LDTR:", GUEST_LDTR_SELECTOR);
>        vmx_dump_dtsel("IDTR:", GUEST_IDTR_LIMIT);
>        vmx_dump_sel("TR:  ", GUEST_TR_SELECTOR);
>+#ifdef CONFIG_X86_64
>+       if (kvm_is_fred_enabled(vcpu)) {

FRED MSRs are accessible even if CR4.FRED isn't set and #ifdef is ugly, I think
you can simply do:

	if (vmentry_ctrl & VM_ENTRY_LOAD_IA32_FRED)

just like below handling for EFER/PAT etc.

>+               pr_err("FRED guest: config=0x%016llx, stack levels=0x%016llx\n"
>+                      "RSP0=0x%016lx, RSP1=0x%016llx\n"
>+                      "RSP2=0x%016llx, RSP3=0x%016llx\n",
>+                      vmcs_read64(GUEST_IA32_FRED_CONFIG),
>+                      vmcs_read64(GUEST_IA32_FRED_STKLVLS),
>+                      read_msr(MSR_IA32_FRED_RSP0),
>+                      vmcs_read64(GUEST_IA32_FRED_RSP1),
>+                      vmcs_read64(GUEST_IA32_FRED_RSP2),
>+                      vmcs_read64(GUEST_IA32_FRED_RSP3));
>+       }
>+#endif
>        efer_slot = vmx_find_loadstore_msr_slot(&vmx->msr_autoload.guest, MSR_EFER);
>        if (vmentry_ctl & VM_ENTRY_LOAD_IA32_EFER)
>                pr_err("EFER= 0x%016llx\n", vmcs_read64(GUEST_IA32_EFER));
>@@ -6496,6 +6511,19 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
>               vmcs_readl(HOST_TR_BASE));
>        pr_err("GDTBase=%016lx IDTBase=%016lx\n",
>               vmcs_readl(HOST_GDTR_BASE), vmcs_readl(HOST_IDTR_BASE));
>+#ifdef CONFIG_X86_64
>+       if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {

ditto

>+               pr_err("FRED host: config=0x%016llx, stack levels=0x%016llx\n"
>+                      "RSP0=0x%016llx, RSP1=0x%016llx\n"
>+                      "RSP2=0x%016llx, RSP3=0x%016llx\n",
>+                      vmcs_read64(HOST_IA32_FRED_CONFIG),
>+                      vmcs_read64(HOST_IA32_FRED_STKLVLS),
>+                      vmx->msr_host_fred_rsp0,
>+                      vmcs_read64(HOST_IA32_FRED_RSP1),
>+                      vmcs_read64(HOST_IA32_FRED_RSP2),
>+                      vmcs_read64(HOST_IA32_FRED_RSP3));
>+       }
>+#endif
>        pr_err("CR0=%016lx CR3=%016lx CR4=%016lx\n",
>               vmcs_readl(HOST_CR0), vmcs_readl(HOST_CR3),
>               vmcs_readl(HOST_CR4));
>@@ -6517,25 +6545,29 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
>        pr_err("*** Control State ***\n");
>        pr_err("CPUBased=0x%08x SecondaryExec=0x%08x TertiaryExec=0x%016llx\n",
>               cpu_based_exec_ctrl, secondary_exec_control, tertiary_exec_control);
>-       pr_err("PinBased=0x%08x EntryControls=%08x ExitControls=%08x\n",
>-              pin_based_exec_ctrl, vmentry_ctl, vmexit_ctl);
>+       pr_err("PinBased=0x%08x EntryControls=0x%08x\n",
>+              pin_based_exec_ctrl, vmentry_ctl);
>+       pr_err("ExitControls=0x%08x SecondaryExitControls=0x%016llx\n",
>+              vmexit_ctl, secondary_vmexit_ctl);
>        pr_err("ExceptionBitmap=%08x PFECmask=%08x PFECmatch=%08x\n",
>               vmcs_read32(EXCEPTION_BITMAP),
>               vmcs_read32(PAGE_FAULT_ERROR_CODE_MASK),
>               vmcs_read32(PAGE_FAULT_ERROR_CODE_MATCH));
>-       pr_err("VMEntry: intr_info=%08x errcode=%08x ilen=%08x\n",
>+       pr_err("VMEntry: intr_info=%08x errcode=%08x ilen=%08x event data=%016llx\n",

s/event data/event_data/

>               vmcs_read32(VM_ENTRY_INTR_INFO_FIELD),
>               vmcs_read32(VM_ENTRY_EXCEPTION_ERROR_CODE),
>-              vmcs_read32(VM_ENTRY_INSTRUCTION_LEN));
>+              vmcs_read32(VM_ENTRY_INSTRUCTION_LEN),
>+              kvm_cpu_cap_has(X86_FEATURE_FRED) ? vmcs_read64(INJECTED_EVENT_DATA) : 0);

again, it is better to check some vmexit/vmentry ctrl bit.

>        pr_err("VMExit: intr_info=%08x errcode=%08x ilen=%08x\n",
>               vmcs_read32(VM_EXIT_INTR_INFO),
>               vmcs_read32(VM_EXIT_INTR_ERROR_CODE),
>               vmcs_read32(VM_EXIT_INSTRUCTION_LEN));
>        pr_err("        reason=%08x qualification=%016lx\n",
>               vmcs_read32(VM_EXIT_REASON), vmcs_readl(EXIT_QUALIFICATION));
>-       pr_err("IDTVectoring: info=%08x errcode=%08x\n",
>+       pr_err("IDTVectoring: info=%08x errcode=%08x event data=%016llx\n",

s/event data/event_data/

>               vmcs_read32(IDT_VECTORING_INFO_FIELD),
>-              vmcs_read32(IDT_VECTORING_ERROR_CODE));
>+              vmcs_read32(IDT_VECTORING_ERROR_CODE),
>+              kvm_cpu_cap_has(X86_FEATURE_FRED) ? vmcs_read64(ORIGINAL_EVENT_DATA) : 0);

ditto


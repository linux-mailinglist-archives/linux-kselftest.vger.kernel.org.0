Return-Path: <linux-kselftest+bounces-9103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1888B6837
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 05:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E533B1F218C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 03:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C92DF6B;
	Tue, 30 Apr 2024 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/od2hoX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6618480;
	Tue, 30 Apr 2024 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446909; cv=fail; b=IJX+EjgTeRdAFhH7GvwKal3JEdXxQi0rJptoWt0r3EnrrhXsZ0tE3oz7xvlH7Bf2CaPd2ptR3aCSM3+OW8wG6jneYUXM9ByofZHz+Xk40WYAz5GWTOKFqU/ikBkrM0GKuO2qcQn0JBcKMTI8JRulDVkiWyacqdwh4/y8hzUb+jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446909; c=relaxed/simple;
	bh=hIAN0E/xtYt9buqM9cIlHchtt2d/qT0UZUxdFMouupE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cf1p1afzBZ+RBc2rDNFGEPvtAIh2kXpr1ba0fmMzrpfbQNKolE9TfaqO1toChqMPC3YB9Av0aDyis426pi9Fd/R/W5x4OCXSVUXb+TFXAe8rc+2dT3EVtZqie20J/85XL/60aEOySfAqMDZ5EyIW/H6Or2y0DkluRE/xIG+lA2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/od2hoX; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714446908; x=1745982908;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hIAN0E/xtYt9buqM9cIlHchtt2d/qT0UZUxdFMouupE=;
  b=K/od2hoXZwV4njEkyt0o4vD2ZQ/WTJInWm32pjDeecfGnOCiQmhgWWEH
   J8Vf0FfyILZvDP749/dArtrSWHiF2vjvSKkXTDdb7PN8Bm6rw+z4F8AHs
   Zfw9pRe8N4/PFAge/x2J9PU3gEfRVH/p4sezo5DidIgNXq8kq/71XNNBR
   BQY9y20TNwesheOeL+jqAxl3UbJtFLMfvTCfSF7NDVyhBaQbL8G8K+9SH
   VStQhZMBx4pobm+jEqPpWRXJf2jq+5LUR+U17AposSoV5SGewrUkEtCUZ
   jQ7qXgwU80n9rsaolhc4/PApWxouRz7W4ce7iQ8OwMorPuVtb1IAuwB8g
   w==;
X-CSE-ConnectionGUID: IwwD/wclQgmPqck6x21AdQ==
X-CSE-MsgGUID: rmrMT/ZbTCqGDbfeIc3FKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10256230"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10256230"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:15:07 -0700
X-CSE-ConnectionGUID: XaMppmLhQ8m7NcKWAcIwZg==
X-CSE-MsgGUID: 6IjKoSG+SJOd4DWqP7aZ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="49515310"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 20:15:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 20:15:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 20:15:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 20:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfnizKXXj2B9i0daQrMUm1zHDXd0NIrpiBw/M/+1u55K15zmeHrPni1d6WY8ki7OeTwJC2vGo8Dw0zo3ns0qY/AZvNY+TAuIgc1TLDpEwpuT49UALfYd8pR2XQiNv5u7QU7M/1MzBngVU3KKv7PcDzZBcJXe/9hm/D64eZbWplZP62ZsZxWwTn8XUvgbCXL40XgGraf5azRmIevoqu39BBxwgTNapmjRTX2PAD88vh+MfuxlnnjiPENW1FoRiQjNbkdA2Z7G3GGc9FmqDg2QaUQLefI7S+cCf9+nLG+zkP41szqvi6kwT8jm7gK4pdfUl+hqVR7Ji900HpUp9pO3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SpvbCaVZ8uMhikvW/E17WBhYVP4Qx0qQBIp0sIsxk0=;
 b=htvovBnjMxUNAW1hEJkD8Sbkr2iGT97HHHC5p+JglyipxW3ryjZmfFQWLPi9Hfwhsc3kRTu1SWiaRm4b2tnGaux8zIh2sLPMFzCGm9hso/xZ9nAaKy1nsFlqE7ofu7nHhewnuJERH9pCKeV5EoRtYI09tqzcFy5pE8A5QMs4kZXFwJ5Gu2UlsQRjRrP0tDaljvhkhwCfn4ZOl8Lkck+9qqvn3CwGTi5Ftbb2OWaV/00NhanMUP7AEQjlHZg20lJx9gXEXSM9lktTF3IQQb0W3fBJ7FAyhus+LwI2y2ZeEfoISOw2akMDuGBi4oxwmbGgZxQjCv2fkR1/cu8oxHsoKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 03:15:03 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 03:15:03 +0000
Date: Tue, 30 Apr 2024 11:14:52 +0800
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
Subject: Re: [PATCH v2 12/25] KVM: VMX: Handle FRED event data
Message-ID: <ZjBiLDJ4SdQ0p5xm@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-13-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-13-xin3.li@intel.com>
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|MW3PR11MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a884045-5967-4e6b-7bf4-08dc68c3ba46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/K1w+qaXh8RhH486tQlvONc7yAwpFRhIj3KI9x27EuFro0Izk0kUzAmX8qQH?=
 =?us-ascii?Q?7FZJYbViEdmDW/MuApdWIuckhIdME6z6RWzUnxCYjIVhgJQd5G5gMA17YJ/Q?=
 =?us-ascii?Q?SUMnaQq8G0NaztC2v4CwEB8BhsC63gE4aFH4JOGOrHEW9X4pAtlzwNT7u3po?=
 =?us-ascii?Q?YKErFR1Q0F1LoEEG9s0brMoNO5oDibsyurCfnb7z2tUA+aEDYg9TKcYCGjrz?=
 =?us-ascii?Q?9haqk3g7pz29vtNjGLqHayNDviXJczM8+aBmOwHMCxTsDy7rRXoSjapag4Bj?=
 =?us-ascii?Q?9T1jxUKgpUfCnMGg+JJ4C+cZ2xdtvhZtBxPqq0s+ZAU048I2YHVcu6Z7D7NC?=
 =?us-ascii?Q?U0luscAXnb/V6123ctFalEGJi4Oe/4Q7iffAVvDJF+p4ItEeYpaNw5EPwlyK?=
 =?us-ascii?Q?OjiFfGR5P0Y8FuHlgEukDAS3Avu7Dl33mjpIGRKVm9GIY9bmTXl377rLhw8T?=
 =?us-ascii?Q?Yvvuq2E8NYIfdrfet21BLT5+K/9OtUIEInM3JtSy+FJIFiWCBeNRbgWO/u9J?=
 =?us-ascii?Q?h4ZWj57Z45YqNbbTcj+wnEFZ/OGvwRLIZTD43RZAgJl6ImQh7f5xOOiV4dtY?=
 =?us-ascii?Q?yQD0xwkVo9bdLQ8v7VwIWn+WVx5QLCdROMxXO3roSAX+U6Resko43xwPy96v?=
 =?us-ascii?Q?emsuRQ87jIZ490MngFCiOwEedjiOKvl6XevjmTDEDdg1OKq5WwcJLOQ17FyQ?=
 =?us-ascii?Q?Gv13eOhqgy3ek6PcRhWco8V860jTz0iv+xIxUz/KVMot7+255NbOu1oT01jo?=
 =?us-ascii?Q?cH7o91Kl3no486ZlyfXVVOb6tUGna4VwZZ4ijNrcEbANknuIzjYFgU/FBxNS?=
 =?us-ascii?Q?wfDdqy2ocNf9bFfD8EHVCM7ToCVWgf2xjm48B/FKCeZmL4hHqNAi7q3twGVC?=
 =?us-ascii?Q?vFmMln6PocnewseyvvaK5EG29lzqZ3pIkK+1mN559QkxcDSyajdCkuyTZ33C?=
 =?us-ascii?Q?n/XrNIbi/Gra7KXCddhLtEFiQeMRkwuBpx6wOfawXenAcCnYrQZv9Lfkrc7/?=
 =?us-ascii?Q?IdEnEpoi+9W9z2CiIhVyCE8nzmy27zw9ORjaCEilRJzEz+g7wh2HHKi5AX1C?=
 =?us-ascii?Q?Y35Wc2a4UdQsU3QvQatqMzAVl5Pt8K7mSgUlxtxm585jUtXbOoXIG1Mngy81?=
 =?us-ascii?Q?URXYMBdiiOHqVVEnDT3bCkugncm+r02b903YF/iWdgOiRA2y45yDpFRCdq8g?=
 =?us-ascii?Q?1MtptN46JioELnqUfRFR/B1BVlkHT0MFwgwAUKZ2tG9SRNXVSIeLIGsXMGSa?=
 =?us-ascii?Q?9byGhJmLO2kDk8e3ejBi3NQoQzAr/bbWY/EZV3eG8w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FySwc5MZKFZuUxKzdAg927sPmKy5IoCeHbUoGvZFzctwC9+y12soB0g+VDly?=
 =?us-ascii?Q?8twFey7VTkygZNu3/yl7dIYeyac9fdNf/qr+uBnNE/RpupT8bE3kGRYdzroh?=
 =?us-ascii?Q?NR41/W18o1xOr/hrrxZAU+9GECbSwg1j9fihOdS3RGQWELiPojm9cyDzr39p?=
 =?us-ascii?Q?Kbv0DfZtPMWlH3602eEN2SCPO+oCiI/nPcgP5ExxHAjbCmC24wJ/1w8MP/Qm?=
 =?us-ascii?Q?OasvHp2+/cxmACPO3tt+I8BE6AZBlvDGcohCpLg6/W4RrSW+izEz9XNaWl3J?=
 =?us-ascii?Q?Dedd8m/hNe4j/cKoz4jnx90jqg8hNRNAmx3mW1JmEC7hHxZtHjmJYa+qNW2h?=
 =?us-ascii?Q?YIp9W8kCiUR1Xu/GK1Aa2J5Pvw/uHrXyHk2WjrnZHgYlNx5vuFHDll8ZP7Kn?=
 =?us-ascii?Q?17oKQUUZdRjDT9/lmdH3YwmXU9yre1gjDnCfz8Vgy50xjhDEa6moF1AfbCGO?=
 =?us-ascii?Q?6xmRkE5NcrjxF9oqqaey4p5XpzXEm2coVOP+rUclb60HiXDHwE434EFXsclQ?=
 =?us-ascii?Q?AvGeDhih+ODSOOFUa8D5Mifhnhfo7GN/MRWtLRQ+l+fdt+LHLMBcKjAz7oCu?=
 =?us-ascii?Q?wogmbM3sub/pobAKKHYuRlFDQ67Tmg4iJwOGCeuE82GLj5roHTH/sOhGpX1/?=
 =?us-ascii?Q?ft/brn9dFNmXe3mYbx/5fLkXGFb/bCf2nZHwKN1RtVBeUAVtFoDYpja0Shw7?=
 =?us-ascii?Q?cOWFj5vd+RlNWVqgjb/wtjRYsiGYhS2N64lh7u85du6MJxOwtuQwjgqktnQ4?=
 =?us-ascii?Q?xNzDj0qIEmqQxp+D4MsNgeFzoyZ5hT0NWTldBHPfD7zZ5ZLALQbRxpal20Hc?=
 =?us-ascii?Q?4sUHzGe46OkDiNFe2fRgPjxRUST/NMwgdlovnSj7jMpXac5Q26h36B7hlhrQ?=
 =?us-ascii?Q?GjhbnMjaj++kREkbQuosEAliP5KVadr2f5IosqFaKQhxIXZcZmeq9ymDb0LI?=
 =?us-ascii?Q?0SvVyMgTbZpNdutFHNsCp6YXQcOHteIlwSACcC+k4aX0nsXqMZBITK60Q4mF?=
 =?us-ascii?Q?0DbOtH0uMVjh4o50MKaoE+NYayqdO48M1TwXaBKaWLY9RTC/mPBpbcRqzNL8?=
 =?us-ascii?Q?OwXB/64Z6Kd40k4Rl5IhdmqwqhJIznYdyHQFZFej4JVHRJWewqSdqLB+vpwO?=
 =?us-ascii?Q?d7494TmRpNvyIy5HpQbt2VTqT7fISVq1R8cDHR0okPg+d527dN9t5WRNNTmr?=
 =?us-ascii?Q?9pJ+r9WCVFDYipCdVTHZjS4vPWxlognbAwh1mVfF2MQnJ8TtbGsO8uokd6kA?=
 =?us-ascii?Q?mLdFICYdJysNB5H8UoDmNCynjy/jGnAKVAB2GZdg14WvPq9YDaFH6sR6DCay?=
 =?us-ascii?Q?02fC9UySgGnkuZZBS9rwgpuDqw1FxnZxuyYIVTCYw1bqWdEHKloQ8TSNawh5?=
 =?us-ascii?Q?WvY+e0KzxGXhz2rNlZrKKo8ZOY6NWaoIOxH2vYiF6XWG5AX3Zm3hxSGcw65T?=
 =?us-ascii?Q?EdFpGPC8oU0hl+fG+JleG784s0oxIJWxwjngWl/ts3my2dpik6X9UHeeedxU?=
 =?us-ascii?Q?1LEkvFZa7zaXS9z1f5bhdV56ANF0QM5d1lMI5ESB6R9Pi6yOSCzDw7kYYLQa?=
 =?us-ascii?Q?w/xepAETXrh930MzPzS/4SdCMqIZZb3/Za7lpHAg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a884045-5967-4e6b-7bf4-08dc68c3ba46
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 03:15:03.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9XjoENFgonPOf5NPjn2kYsjbVG6uqWAxO6ol04fOGln5KbNaZmR9ga9iUmI8/1u63w8f6kuk1jfRy9mhmKUlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com

>index ee61d2c25cb0..f622fb90a098 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -1871,9 +1871,29 @@ static void vmx_inject_exception(struct kvm_vcpu *vcpu)
>                vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
>                             vmx->vcpu.arch.event_exit_inst_len);
>                intr_info |= INTR_TYPE_SOFT_EXCEPTION;
>-       } else
>+       } else {
>                intr_info |= INTR_TYPE_HARD_EXCEPTION;
>
>+               if (kvm_is_fred_enabled(vcpu)) {
>+                       u64 event_data = 0;
>+
>+                       if (is_debug(intr_info))
>+                               /*
>+                                * Compared to DR6, FRED #DB event data saved on
>+                                * the stack frame have bits 4 ~ 11 and 16 ~ 31
>+                                * inverted, i.e.,
>+                                *   fred_db_event_data = dr6 ^ 0xFFFF0FF0UL
>+                                */
>+                               event_data = vcpu->arch.dr6 ^ DR6_RESERVED;
>+                       else if (is_page_fault(intr_info))
>+                               event_data = vcpu->arch.cr2;
>+                       else if (is_nm_fault(intr_info))
>+                               event_data = to_vmx(vcpu)->fred_xfd_event_data;
>+

IMO, deriving an event_data from CR2/DR6 is a little short-sighted because the
event_data and CR2/DR6 __can__ be different, e.g., L1 VMM __can__ set CR2 to A
and event_data field to B (!=A) when injecting #PF.

And this approach cannot be extended to handle a (future) exception whose
event_data isn't tied to a dedicated register like CR2/DR6.

Adding a new field fred_xfd_event_data in struct vcpu has problems too:
fred_xfd_event_data gets lost during migration; strickly speaking, event_data
is tied to an exception rather than a CPU. e.g., the CPU may detect a nested
exception when delivering one and both have their own event_data.

I think we can make event_data a property of exceptions. i.e., add a payload2
to struct kvm_queued_exception. and add new APIs to kvm_queue_exception* family
to accept a payload2 and in VMX code, just program payload2 to the VMCS
event_data field if FRED is enabled. KVM ABI should be extended as well to pass
payload2 to userspace like how the payload is handled in
kvm_vcpu_ioctl_x86_get/put_vcpu_events.


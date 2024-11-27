Return-Path: <linux-kselftest+bounces-22568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E9D9DA853
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 14:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DF0161422
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522DF1FC119;
	Wed, 27 Nov 2024 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVyGQpj+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2031DF984;
	Wed, 27 Nov 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713414; cv=fail; b=Usbyr0Oprn5i3qlTFfKN+v3voeRVGeZaQXdQsV+bqDfWvcmxzk6PBT9YeroNNoEtS2thay4/BEIxdc5kiYN5Esa0NvXEQuOKeekfkOPm/08CJOSutnqTBpRi8L7xW9/XRVpwnS/I/UFypDa5SMO0U0i/GS4EQ1uUNy2cIrSeHM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713414; c=relaxed/simple;
	bh=z3RqcO9uakoiC8tnrTxmZWaVGpXHVDQWoYhgomILdxA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m6MLKBgn+T4JT1vJBQkRHVtKwl0fE5S0PNa9CtKoZb78E8dHXPYjbcOhv/mBaUMxOxdVuVCMfvJJ7hkVJI/BTIwKMObZsBMQHjrZo4fNU0TYWzfbD2NWWc4nmPMfwdBvf2qItodSxmY97kPLTrwWc8mqifZ8w9E7bboCeMlz4i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVyGQpj+; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732713413; x=1764249413;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=z3RqcO9uakoiC8tnrTxmZWaVGpXHVDQWoYhgomILdxA=;
  b=UVyGQpj+bwYsDXV8qoqtdrrwJ4rBjEgYDis9MrpQuJpFQ1PRsw3LpsKe
   rkgocwNBRO9zfwFDPrMGiq8GUehXm4at2ozwCdH3yxoRV6PwtlchWkueI
   mcv8VSu6XZHrubvzu9IE6Q4KCkJcAHqcz9to7NYmQh+ho0jjkVvy6tjHh
   bOy3T4CufZRajPlzTMdGJE+BFLpFo14ZtyBxU2r7SrluPYy4BF9LOKUHI
   bUX+YSiySlGsEfynXBsv7c7g2oAA489XTBfy1zeMPRZOYF8HDmwc/vt/u
   ASUy1JNfF7kLntgVkF4j9r3ykV18q1qwWjvceM9CJNDh13atSPUG/aAY0
   Q==;
X-CSE-ConnectionGUID: KivHzA+RT0K8UlxNv7NmSw==
X-CSE-MsgGUID: aUfbQxOjTRabQ+WmJ2HmyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32289332"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="32289332"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 05:16:52 -0800
X-CSE-ConnectionGUID: uYQNLrsbTI+TmYzzt/sKgw==
X-CSE-MsgGUID: aeKKlZDuQFuuZHOTXNy5qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="92252566"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2024 05:16:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 27 Nov 2024 05:16:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 27 Nov 2024 05:16:50 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 05:16:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuVLnpFIXZ4hZQHo41RoEP/bn1x64tyDImMC4sehqnUV15fPRp3ZSGdmoZ4dpWzYJFDKF1p0rnLFdniR0Kno38KgAHcFW9X07lVIByJu6Nm0O1OWa0l260542bXHimFZjBVGePJNFb1WI9t5GzbOKP6nZH3yPfxLsDtGQqbeBWJvU2ZQbQ0rhZRlehglMj5+YZ/70FbudbzwppWdpvdYg5yEvZw/1ka7rtJsUYT0/8VdE0606Nmz1dvYROIqt7vJDT4CVEvg2cyomuxQaMeTFCDR2lfwmXZjbHlmKbROiJ4KmPOvVZdZ7z/ApAXT7ousosZE46xTd92odjXGFdayCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUdUygkcb1PPFSlmv5RIet2sgyYiJxwsJvDczJ15ikw=;
 b=BooC08pysV6ghLs29c4fuWk7YmDbTfIdY8Pt7cUmX36TG4iHmdCvNsEwXFmXfMRku80NCLUjuoeSfD8nSPDT8Mzimw/4tpsgJNglDQLFhGGCun7eiik/K2wzxDmg6RfuFsQ/Vr94Jx2b5CK0gxSjsoktvZ4WHqYrR19iRz4q/Vnw3DLl6/lN5REnxJt4+Pr2iz8ygZQ/UB+D3MKh5+v1P/Rkz6nAor6tDlMu8Nt4yzzrd3DLHvqOBL3Fgaj7ET9eB/h5LalMNnWwA7uWlhQZDkv22fYTB7dHux2QGM2EHpnCoRFr0HhYpAdei5lQRy97jcYtvvgUa+fekZFqaulleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DM4PR11MB6382.namprd11.prod.outlook.com (2603:10b6:8:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 13:16:48 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 13:16:48 +0000
Date: Wed, 27 Nov 2024 14:15:47 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
CC: <shuah@kernel.org>, <hpa@zytor.com>, <x86@kernel.org>,
	<dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] selftests/lam: Move cpu_has_la57() to use cpuinfo
 flag
Message-ID: <py4463oypehjew7u3hlfnj4zrsnts2564qxyimgxvo4zmkma57@dnerxgzi5c3k>
References: <cover.1732627541.git.maciej.wieczor-retman@intel.com>
 <4979b3de7021f34cbef22d44799e28c914f993ca.1732627541.git.maciej.wieczor-retman@intel.com>
 <6kfafs7wio7ruth3p54pezqwcultxqqpnjvehjzaz7hlba4rp3@6kb5zdqfglsl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6kfafs7wio7ruth3p54pezqwcultxqqpnjvehjzaz7hlba4rp3@6kb5zdqfglsl>
X-ClientProxiedBy: DUZPR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::16) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DM4PR11MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1f9088-5135-45e6-c491-08dd0ee5bf72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?E+gpbOWy0C7IPqU3y6dm4C8QLTRPw5bkTz50dXiOoRphve5KgbhcGU4ZlK?=
 =?iso-8859-1?Q?jx3gPjAdF79RwozE4+meRgV3OE/NFWjXTkMk+RUnd8CQG/IniP562CK+d8?=
 =?iso-8859-1?Q?O6BDMWSo3OTWJYIqDeyV8vM42U67Nsie2EpusDEX+qZd/QOKHh9EWdStSW?=
 =?iso-8859-1?Q?n/M6oaUwDP2XBwV668SZpjvSP/W+J2lt44lD/P08jDJO3GkcMLT/sDcIRy?=
 =?iso-8859-1?Q?B7hqB0ZImFFtM0yILTniyTEp0OhZMxcRSTnPtct5iBOSZ5M3oVfPw4FliZ?=
 =?iso-8859-1?Q?iMazUONyPETlUwEsYAmTjWe6NlcLGnfEoilU06kz5Zg5rQOaDIdw/9YQsD?=
 =?iso-8859-1?Q?ysxxG7SCLN7FR5SmEdGuJsxM4c8IBntxK//+AxIb1AgU1RCOCJhXhFTZlp?=
 =?iso-8859-1?Q?9MNbZNKPpFFTLCToGDvDnAIhXBs2Mjgmyc2JOfD/42585JlRVIokplBcWR?=
 =?iso-8859-1?Q?Yu5tn5ns66+6U2n4s5BFM5TSfffLGeI3hBODcaj84RIfKF9aC5jh5pbntL?=
 =?iso-8859-1?Q?NZMpmme5YW99poMzD7bCk/fHdmreToSHCVHpOT5VYwbWvrFNgkSipn0Nzx?=
 =?iso-8859-1?Q?GTL6VFx+O+AxvKAPkWYLLjVep7mqwQMLj60B4CRXmGP021++b9TgdIIq6T?=
 =?iso-8859-1?Q?4ZBnP4tMPrv9o+RRRvHhrxWPeDf8aoiKxdLnCIFdWWGSwtJqTOIPYGsww0?=
 =?iso-8859-1?Q?O9uj+LJ8kPfx9W26baqgX4Y6oL9SdaQ2aVR4/GGzaLWvPm+SyDt1OdbA5R?=
 =?iso-8859-1?Q?GIbe/Ff578A0iw26jwUTKhyo2VFSj+qu5lQm6QF+AAAZX8Bk1d/maKxuqp?=
 =?iso-8859-1?Q?UFtbQNG7lORE5wFjSkkuLytoZnUQDRGr/RRqPezg3LBja4oXP18sfRqxcn?=
 =?iso-8859-1?Q?aP/BUpyEIaQc/V91ku6jsfwCyoaYLvyFVIBkzLNcTMJFrP6dgwluLSy4Bc?=
 =?iso-8859-1?Q?3j9GiLynwpUogkhKxMNXIsFpU1Xw8sCjNnt6RmhwvlhFKUjCJqn47ZtqZu?=
 =?iso-8859-1?Q?Dot2OPTxW6CnWo09000FtW1vaV5SAnA5IOKWNL7p55nVqIqDuS1Fm7LXC0?=
 =?iso-8859-1?Q?l6B422qDgUElmxzvPrQdt3fnvpPeiF1X1MVI0waY8qeVHb4OI+ndCJJ5FM?=
 =?iso-8859-1?Q?GqRIj6CKh9OM77fZyIT1XM8s+bodlHjJH8FeEyQfERR3HxZ+li1jbbCWYw?=
 =?iso-8859-1?Q?hJqZj54p1bkmlQgdje67yOVnZTzEg1blS3LbaJTvrUmGS+2jKU5XAXFvqp?=
 =?iso-8859-1?Q?0OLKOYC2RrpIIfKrR/D06uBDDuxwTcCuG7RdLa1Vkcd/p4NDcpQjiU2JZY?=
 =?iso-8859-1?Q?dmEquMFNiVAUZulwRmN/C41XJvEELUBeWPkB9FqSwFW1y9OWqpIUfqaAhB?=
 =?iso-8859-1?Q?iUs4+1op7RjEytLTo7eoJBwEBDgHd/Rw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?K7uLB5x04T8IB1IKbqYVQE/MljKZd4a00D4Sku/kG8rDJRAWDG2zVhZcb5?=
 =?iso-8859-1?Q?rXug8I/ig87EWb7UVvltUnTrGBfAyhwL2rc9exzfynPUhf/uQ8ftbSbnl3?=
 =?iso-8859-1?Q?6PC8FBqPltYdTrt0n8bja8MDEvS/zy0Uy9WuXJIm+odeenuJhMy8CpFTOQ?=
 =?iso-8859-1?Q?HeFJ6mAhZOcM57DK21J//vPaUxfY3st98XcxUjBn9dabQ1xorl+C8l4FVF?=
 =?iso-8859-1?Q?sc6PlNOgy5HWREkejfiZDvnXG3jk4d8isG6cHFiJOJFxGmRdCx/inTglox?=
 =?iso-8859-1?Q?h/FYRNLg3xu7RofSzCAc3xglHM/Y5q9YU5uYo+Mmec7lPP1QlGFPxo7i4h?=
 =?iso-8859-1?Q?kx/4LR9H5tFicwoIUcau7h+yO+1MMVKjTp+JNG0MkpxnSeSqAZqg0x8iva?=
 =?iso-8859-1?Q?+dasJBVYeU2hYmS7twQkFSTXSSxPuJHtqRSNVesFddOl+x8CPMhZxpAsX7?=
 =?iso-8859-1?Q?dcXeR8dEaGLmwnpSRCgUQokTVmwhzFD/fuiAhKtHAxY+yG3o5Mn4V1RWLI?=
 =?iso-8859-1?Q?E8VpF9Qk9/2SQ3rI+6bDGnWwBSPAwJKWDJBUMb0Hgtnvc2pwEDIvrekLu/?=
 =?iso-8859-1?Q?7l4JMldwhMJGLf0EuDKAqDaETz49PnGuTEgrIdSyuBnMKaqKXIICjIU/z/?=
 =?iso-8859-1?Q?VFBfr4gJ5pgArmxj82HcEEjiYZuYyWVQSz71EVLsMdnlf0eA6zLGRQXXBp?=
 =?iso-8859-1?Q?miULVrHcowVSBzxz35z4WCVHnGKblnhoQdVWJp/+jHWKyQfg5Cy3mlQfni?=
 =?iso-8859-1?Q?JlMX90wTeJ8Q0HDaCEqEfCST1kmWa2wXWxPCvg/Cj5/OFcizIi0whlf6RK?=
 =?iso-8859-1?Q?k2WfbHq4EKC15uxunyEpKfWIFsHxIv3DP+N+pfVKfp0w7rCdhmBe4bebYz?=
 =?iso-8859-1?Q?1J+PFUvofCT8p9c89mUK7Ymn8+qPYGX46SuLMVQGcEr79IaFP0ljQwrK2h?=
 =?iso-8859-1?Q?7vRazN3z3ziFq9pOKzm/hMggHuuRTTivGBuuvM8D4v0bUlLQzvJcIKqUJm?=
 =?iso-8859-1?Q?b1TErmD1S5YgDkTsVOJmLqLjh3woNone53URYjSAh3VJr+eZTE3He9Z0I9?=
 =?iso-8859-1?Q?Rz6XzLUEmApsBkzpmRZPK25JEKMbAtfNxJy81xpLk5sjf5Y1In+L/stf7m?=
 =?iso-8859-1?Q?yGmM/1RL5w5aaeI+9rpB0CoXk6yPnBGAsDq0IK3aqgIwqMz5nf/k5OUuOV?=
 =?iso-8859-1?Q?naOezcXO4Lrb+i2p+2ZSpKuRoyw/Q57ZNmPepx4PA/gW4WEj+3kpRce7AX?=
 =?iso-8859-1?Q?xYVJ6iLpcWoFRYvgQblPHp2QRI1UVLJi6VP+fCsjyzy+INVZ0AkMNsJgFi?=
 =?iso-8859-1?Q?9mBZW7tob+MxSJAluIDozAxaHwIDRaA46cF/I9Z7e8j737uhslzQ/nIIif?=
 =?iso-8859-1?Q?oloUwAxy5oQvpvxZ2WrJUFoY9GXlmhFJaAZz3P75Pb+tgtVh09u4s+17Pi?=
 =?iso-8859-1?Q?U8tTPAechbNyZjLMKAkPHeLeIpvdziY4b/Wi/T8O1UbVEjB4nIKtj3hJu7?=
 =?iso-8859-1?Q?vm5kSvXr0agbwra4qlEzmqoVzdSxmFjvv+u0X+EZfSodJCpqVwiZdCVd5I?=
 =?iso-8859-1?Q?yEFSL1TWcxj9Ki8CxAHkkcIf9BiY2fxIZ0VRRfTK+C4wEyI3gQKEg4weTl?=
 =?iso-8859-1?Q?0dvL6Y0jHP3KwBxVQvDuurSdUE6jqA+rnZOf8GXFp0L/1j5eyKOAwHeYB3?=
 =?iso-8859-1?Q?4Jo2GCLnkCkqrVaOJDE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1f9088-5135-45e6-c491-08dd0ee5bf72
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 13:16:48.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwArvfEPB/dS/pVP+L7EwRGO12lP8wSrAnKKsGuAN4TFp3ilK9qJG5cAbiRYxAC5riR7F8eLSAGR4MN4EE9OaFN+daVEhX+P5JILnNEnpdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6382
X-OriginatorOrg: intel.com

On 2024-11-27 at 14:11:38 +0200, Kirill A. Shutemov wrote:
>On Tue, Nov 26, 2024 at 02:34:48PM +0100, Maciej Wieczor-Retman wrote:
>> In current form cpu_has_la57() reports platform's support for LA57
>> through reading the output of cpuid. A much more useful information is
>> whether 5-level paging is actually enabled on the running system.
>> 
>> Presence of the la57 flag in /proc/cpuinfo signifies that 5-level paging
>> was compiled into the kernel, is supported by the platform and wasn't
>> disabled by kernel command line argument.
>> 
>> Use system() with cat and grep to figure out if la57 is enabled on the
>> running system.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v4:
>> - Add this patch to the series.
>> 
>>  tools/testing/selftests/x86/lam.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
>> index 0ea4f6813930..0ac805125ab2 100644
>> --- a/tools/testing/selftests/x86/lam.c
>> +++ b/tools/testing/selftests/x86/lam.c
>> @@ -124,14 +124,11 @@ static inline int cpu_has_lam(void)
>>  	return (cpuinfo[0] & (1 << 26));
>>  }
>>  
>> -/* Check 5-level page table feature in CPUID.(EAX=07H, ECX=00H):ECX.[bit 16] */
>>  static inline int cpu_has_la57(void)
>>  {
>> -	unsigned int cpuinfo[4];
>> -
>> -	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
>> +	int ret = !!system("cat /proc/cpuinfo | grep -wq la57\n");
>
>Heh. grep can read files on its own :P
>
>	return !system("grep -wq la57 /proc/cpuinfo");
>

Oh, thanks, missed this :)
I'll resend after fixing it.

>>  
>> -	return (cpuinfo[2] & (1 << 16));
>> +	return !ret;
>>  }
>>  
>>  /*
>> -- 
>> 2.47.1
>> 
>
>-- 
>  Kiryl Shutsemau / Kirill A. Shutemov

-- 
Kind regards
Maciej Wieczór-Retman


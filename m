Return-Path: <linux-kselftest+bounces-38705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1991DB214D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD67A797F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADE92E2857;
	Mon, 11 Aug 2025 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daKOblY4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405782E03E4;
	Mon, 11 Aug 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938063; cv=fail; b=Vi+vz4AmOMsuq2xHjswkcTqXmR516t0RWFIzKsjwC8F3abcNXCP2vg8vMd8UytcTexcxpN7mf1r3ulem0FFZR3cnuE67wM2r1D//up5OC3GBRskrIbFdwfkvEGuZb6mD4sAImBPxbWWW6oKlQdP+hFA5bF3suTY9oZVn0UJX1Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938063; c=relaxed/simple;
	bh=QOYS+bbeykgK6RA6yQMjVd5ODHi+ZyZTV0TASfQYwsQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N2H5VKmHEPHDUstFdq1dHgIyOiygtdnztrO0ssjGiuzXsnLNw1MFCjMVv2qAa/95A520CZ8EbeS3rnRH/VGgoql4ZQM499a+T0e87s2n+Voosj6LGH2WL37DSP2EUK0dW8jpkU7k3c9EUXHCfDKaJC+5d+JJxQLIr9RIZxkZWWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daKOblY4; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754938062; x=1786474062;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QOYS+bbeykgK6RA6yQMjVd5ODHi+ZyZTV0TASfQYwsQ=;
  b=daKOblY4/fLn3QvW94RzzA3mVcdqM+ez9k/8WIHx60HYS5glwjRtsGOF
   GkNZJxwWiee87MNeFHy4JpBQzs1ah8VIGrN3bxaPz9xbdv05azAF7K/AP
   ppuCKmDOtm2fJBVKQKe/vCBl5s3kuA74m+szGOA3o0mICjIwgSYJHbhIh
   v8YOKcXrcBCcAfDUiiU4wvmZBQ9Epcxh2B6mNXh+QlXzC8Myp0hRTaN/e
   OllCuozqmvX2N+/tyG9j7gWgTQb0NkQlsnydd54VvvA74my/FEhpKNcxP
   Pl+R+6zNezUibWHybwvYtXGRYL2Cr9JavYMjz3HQP6O1pDRptVYOd3BmD
   w==;
X-CSE-ConnectionGUID: kVhGcuVHTymx5XjE3pLtWQ==
X-CSE-MsgGUID: gQtSEH9rR6WOhUH+yXnkiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56227950"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56227950"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:47:41 -0700
X-CSE-ConnectionGUID: aDTI0sPJSYaKmFP3zmNSdA==
X-CSE-MsgGUID: NLbzUXThRFKTRNsuavb/IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165880728"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:47:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 11:47:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 11:47:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.87) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 11:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuHCN2OQTrnGfSOJum+IE9sXeaW7LoohgLXsUszlXuUFbdSzuQZ+Bqz0k3i+KhYLrKjCLjCjHxmzaccAIgzNNnWmlKGw7eSNOza6Zru37/pbeZ8nnXV1hbhh/lXI2Otu9GWMUdqMAdi7jlIvriRM7c3TsQxfqETaUHTuJm5lsmgmbQGg6pEbELrT0dQuZ4SXA0v+q1zsX/ZNCVvo/CeU9Nq/jPy4a69zWMGH9S/WUVIrhq3dfvV7j+ztk2K7RILBsnoykFWxmsMk3oAaZkRuH5D6Dx+scbyhLJRTAeDElMWodjWphm7/q4Z6KhnpkvhiEoTnz4HzG0HLIpFbrMgSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rut1KD1xmZ4wHTr4HUAHWqXMmY1+dFIOFvBRf15t0KA=;
 b=lWyzW+I4crcE3134wyifa3tJGavTIazTMZBSuDocDEhu3zm8CP5jfN318kyjhXi3uiBw0sdtCZ1clasXaRDHUeN4bJcDZCt7nMLjtpFugiJALawce9Kk4t/mrj7PxTOfqcYbaIQGLE+w/L7DJ0++1ZVoUOY3TXB2lbMNHDPNtbyWOcoCdfk56UUBgRInQNkX1bNJ5Ucv9/SkGDmA+ejYFVKvL+qh+Lg5uwJYqIfWbcdETsSzMYWVGpkaXRbrJvbDY+WPmqJHEzGSkBZAKugRQLP33fLTpwluJkdlZr+Gium4Fyx+csULjuEfzReDMS8Up61zWs4+UZVqEGiTEpYsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA2PR11MB5017.namprd11.prod.outlook.com
 (2603:10b6:806:11e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 18:47:37 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 18:47:37 +0000
Date: Mon, 11 Aug 2025 13:49:13 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v8 23/30] KVM: selftests: Add functions to allow mapping
 as shared
Message-ID: <689a3b296261c_1d882b294ed@iweiny-mobl.notmuch>
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-24-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807201628.1185915-24-sagis@google.com>
X-ClientProxiedBy: MW4PR04CA0260.namprd04.prod.outlook.com
 (2603:10b6:303:88::25) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA2PR11MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: ccba7eb4-899a-4aef-3e3f-08ddd9078ac4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iuuhdYObNeFkR0i8VdkBZjqGcZWg1cmZhLOFm80tbn2J0JrhfZbIf44+0Ekc?=
 =?us-ascii?Q?R7Ht6PM1ovJPwgbAjMYi6wcGaD32Pwe3nMpUcoAkkjzXSuyFghwL8NiTcMO5?=
 =?us-ascii?Q?/eRJp8A2U1i4WOSzeONPbqs4LeWC7Y1PDkWSy6k58MUVjQyzBUf0d5TLUE4t?=
 =?us-ascii?Q?K4cZ8Pkmf4wlQ9rESqKKitHGCHZmrtoqfxrJryJQoOJgy+QRIrmkesbP8/gW?=
 =?us-ascii?Q?J4sK6mmjrO8nunFxPe9w0oL+rx8xXwOS3MiXqOWSeZaGOfmMFjs1L6fh1zpG?=
 =?us-ascii?Q?Oy7fTa5J5yoIon+1ufqm/KXTUml5wwnrgDOyDFleVcWZqInGysugpZa0xAsz?=
 =?us-ascii?Q?UpH0eT9wvWbjftjCoQBjTFM2raZQtybN3Pyw5DULXVLLgQHIRJOj3VB1N49Q?=
 =?us-ascii?Q?NyGKwsmnaA4SMpId4CH5lv8hQBCB6GvDZqd3BZlzy9//XruCknx6mcczTEws?=
 =?us-ascii?Q?ZuykwHdCdTUmfhm8cCLuHDJKTqYd2xS+Rgj7wjwSRYmZY6NKfhOudbOfebBv?=
 =?us-ascii?Q?ZbZritmRyi/9zmuHj2HfvmTPUGDYLCwMtNXcn77h8nAYBFEpmyhenufPeEk9?=
 =?us-ascii?Q?C4Aul/2IhWv5hIFA5fT57799Y4XZFcvr6yZSdPT8dMqBmKqQvQblOvLOkcni?=
 =?us-ascii?Q?BEj+cmRfBabzB0NmU0tHF7NUr8WclOXkHAfDKNeYaRT8AI5QCxM5Fw7NDa7l?=
 =?us-ascii?Q?coN3A9bSLiARsgPaFO2NwYLdJ9oxaT3JQAojqQWRjNsqV8Qu8VXWy7+PU8Vs?=
 =?us-ascii?Q?15oGphcNvTC3YlEA6K5SMP+vAFKPIvJTZ+CDDUsWO+yulCEgsiE4+OiF4xup?=
 =?us-ascii?Q?8Qia04oQFD38Z05DsLc9oNdxOn44UaqMFV1ErLN+VmiQno57ZpUUTjGwe3NF?=
 =?us-ascii?Q?JVBcKWqzYR8cM2yiubpnMKpXGI1EPASB3Hz+XlwsxhXEOpcnZpjLDXETr1yB?=
 =?us-ascii?Q?IxBy7ZoDU/+Jee19n+YDXoozb7b+5GBvxyfFZOLumubWVlMIGwovk75IFbNi?=
 =?us-ascii?Q?lswWG5b396+DjGf0trd4Q6/jrtr0nRn3NkGikVBAfT//7MhuDAt+x0pIRlKB?=
 =?us-ascii?Q?oDw2JtjGvFp/VDKQo2CHyfDY3hp3zTJgkSCND1gSa9uOnYRMaM/vVq/HhB5E?=
 =?us-ascii?Q?lyFBxzGp3hOfpUJV1Fs2/nm5vZR+VBID8LoRW2HLnovDiZgBdglFfQTkDR0l?=
 =?us-ascii?Q?3NU2EFxPvCUdc7NLcHrmx6KGEJT9P2fIB7G1dKlrN3h14wpLlwV+MHGFcVr1?=
 =?us-ascii?Q?pDHiZh7eJhFJ0+6SNKiKir3511LNwjS/HiEwNP6n4MKhg1/vg8w+w3z2fUg4?=
 =?us-ascii?Q?jauaXcOpVipW5oZRR1kvQdqLVlKhGMm4k1ZS+OZ+hzcQyagRvAj06qfbwGlT?=
 =?us-ascii?Q?C2ybzE+dofbdQJwykm4IXqO+thC35BYZN2rR1F0gQc95tHuTjOPZLw75oiPB?=
 =?us-ascii?Q?BiH0aTr8xW4tN65kc0P73JthRjmmCX856gKtL0CnpeMuJGJgTXcrjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?koCujeulu3+7O0OutUv+rjsB7pZgVPmh3YPFvM0fKrNaotHz8XhKvlWtWwfL?=
 =?us-ascii?Q?fNzoPoBq3e44ZTMwlDEC1UReTvWUbUUSyVtW2BWZROHpukHXydVDnwU1h8pA?=
 =?us-ascii?Q?KmmSRri/h+lwG0mn69qIsC8XuNTlXMWixiEZ4Td1GI+ZUH9ixdbFRlqf7ZFA?=
 =?us-ascii?Q?ZwOb45QmsYJvoShx+a0/KNDOnuT5vmQCWJ1dqGoG6cVzzaOGpvZyrO5UeFar?=
 =?us-ascii?Q?iQOfl8wcRzUGHSBIdOj6hXZWiQI4dUb/rMrsJPzOwwoSwnpT0Mmiepjkj8HW?=
 =?us-ascii?Q?/7FeqBDlIvy9mTD3FESY6Ab/8Eq9fxISlku6GILQMT09rkmSMuFgn5ongxmN?=
 =?us-ascii?Q?9bDDfPvwyETwHsJ0aw364FMUp0k6ZCkZgvWPSOmmJ8zEjhjzE1cZrmvV+1Lw?=
 =?us-ascii?Q?iqCaZaADRXNTfF/GbHv5wVUapVY5hekaHm6ldtvTo3nOLyYlOKyTTP3njss6?=
 =?us-ascii?Q?ktwN9calPOW96n1dVLe+fRCnbJwZTXepx97iJUc2dyISU3GoR+fectZbBMaC?=
 =?us-ascii?Q?rlWwoYCnRxGhjOXJePzQy5AzsZVTjqpuX8rMJJtoA+zKoPbn13t8taOp1Sss?=
 =?us-ascii?Q?WskyQDfOaWX3L4qt/bxXTGxxb5DuRd3EZ7zsvWSN9bvS2fdgiJ84rkO5z2pJ?=
 =?us-ascii?Q?2gUg+xT2GTjyXxKJRBdAKT36gPMFnHn1grv8lMKAlwnfll+lfJSj4QZ+obIw?=
 =?us-ascii?Q?LXH17VBNs2uC+glrsUyY9goH1wHFmJip9Rel7z/T1ln8sB7/5At4ksXp8CF/?=
 =?us-ascii?Q?lgrn9VITSkMSntvC7u77sr4JhWAp19lQFsXApaHSS7Umkz7PTUiO/gBo/3v+?=
 =?us-ascii?Q?PpKT049tBdUbqx7M+9CXwNIWsGN+bxKZZUAE0YQNtuG1U784WOUJB64AvfQw?=
 =?us-ascii?Q?8p3cmmow6LdOithoBKdC0uWhkAM+HRrHz8xt9GtihhrXcDaBkHCUNcCNuQ1g?=
 =?us-ascii?Q?1Ag8g38X2aFLlJStRdWnMo5NcZT8wfVsU6wb8KSqNR8nj9b5H96vc9GTA7Vx?=
 =?us-ascii?Q?ksXDxuU4Vd58dZC9wuri8j4Rve9TO+VRSmaQ6QJ8iiElwuBxT15ys62ndbb/?=
 =?us-ascii?Q?8QwpT1VTCgT3hZ0NjAOUpSBFRR2XutoMpLmEmIZwarsRfusVZ0Hss0yxmxFL?=
 =?us-ascii?Q?Ll8j6N0BeoT/Xklqblsn4Gl19E1QHwiz/5hHdySzXWiBZlHM24kt9v43IC12?=
 =?us-ascii?Q?sL1Xsq3eeFHV9sbCGJSweQai78dWl5+WD/EpjRZZf+sI/0KKpc6y2ZL482kK?=
 =?us-ascii?Q?hlNGL4+PZtyRHd3eQxyXSfOfJRPf7WUd2iD2R0W4CyoRAANl8eEx/a7De3Xh?=
 =?us-ascii?Q?sZ65PiIEtVjk3Bt7qRCPmYD2QwkYRmkJFJo0V3S061DAFrLATkNn/wxJpP2I?=
 =?us-ascii?Q?ZTyjAFb6hL76QJ/oftWMyPf/5iIsNlGI91dmGtbSHG4KTj5ZLRAQO3soJiY5?=
 =?us-ascii?Q?xqtV/NLDZ+2Oxr87j+/v9C0A8dkBiEwUHg9NRI2YqB3ewMm2Z45pnzqMRpsS?=
 =?us-ascii?Q?iovV5V7sIAVnDkPHyYO9scqjGjRhjUIXaVe33a0lNDmMyJ0PDMobRAGpwUN2?=
 =?us-ascii?Q?Ps/rRYzXicrnunPUGqIJiVongAUT/1x0mglNlhNh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccba7eb4-899a-4aef-3e3f-08ddd9078ac4
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 18:47:37.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVr88re5OWFdaGpxzOp2k9vQQoJxrG/rVzbe49zo0vtQrhXZvMnNWixbiJZMm/dYZUbL0pPFeW9BuZzm7saMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> virt_map() enforces a private mapping for private memory. Introduce
> virt_map_shared() that creates a shared mapping for private as
> well as shared memory. This way, the TD does not have to remap its
> page tables at runtime.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  | 23 +++++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 34 +++++++++++++++++++
>  .../testing/selftests/kvm/lib/x86/processor.c | 15 ++++++--
>  3 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 0d1f24c9f7c7..2e444c172261 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h

[snip]

> +/*
> + * VM Virtual Page Map as Shared
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vaddr - VM Virtual Address
> + *   paddr - VM Physical Address
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Within @vm, creates a virtual translation for the page starting
> + * at @vaddr to the page starting at @paddr.
> + */
> +void virt_arch_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr);
> +
> +static inline void virt_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
> +{
> +	virt_arch_pg_map_shared(vm, vaddr, paddr);
> +}
>  
>  /*
>   * Address Guest Virtual to Guest Physical

[snip]

> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 3977719c7893..7742c01d48b1 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -181,7 +181,8 @@ static uint64_t *virt_create_upper_pte(struct kvm_vm *vm,
>  	return pte;
>  }
>  

[snip]

>  void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
>  {
>  	__virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K);
>  }
>  
> +void virt_arch_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
> +{
> +	___virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K, false);
> +}

What about non-x86 arch'es?  How does this compile for them?

Ira

> +
>  void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>  		    uint64_t nr_bytes, int level)
>  {
> -- 
> 2.51.0.rc0.155.g4a0f42376b-goog
> 




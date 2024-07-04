Return-Path: <linux-kselftest+bounces-13171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C392706D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7941C2165E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 07:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4981A08DF;
	Thu,  4 Jul 2024 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBqvIV5N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9917FBF6;
	Thu,  4 Jul 2024 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077840; cv=fail; b=HTnKwYkk0zLEtRNoDAnYMbC803FQ/WmfyCZTpFIbHCmCBFpuuQ9RZ4ki8VuVRqspO7s8M36+Yw2S9TM4HsIdqMkSuy+irGa2tF0fe+Kw2dcgVc+6z24j+JZCQTIEv3CW85I8/SqMMoOqPSz6lAC4HbgoYly7ai73o+rZG94iUSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077840; c=relaxed/simple;
	bh=tzvlrFPfdgqTyoyR2bKEdrHPj6Q6YpK8wc0y355jNF4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aPwaVv43H3NEjImhB2xQexf7FzBYZfkfT/36jmpjcWBVck+lT3lC0UVIqU/xTk1+xWkjTd/8h2h2wwKWWYsVDF2IaJDfBBALPVPROl4hf+buTezPQcWutV0Q0bjahoqiSED6vMmCGqbvkuXUEEqsDOAcL0bXPM/+8G/9Qtkuqvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBqvIV5N; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720077838; x=1751613838;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=tzvlrFPfdgqTyoyR2bKEdrHPj6Q6YpK8wc0y355jNF4=;
  b=FBqvIV5NZ1FH2oNT/BYgbsnAMVHxu9P/XttNDlKewgJUaY7xC2X7UOMJ
   jc6OLxNbUZ/d76HP4O07jhVFUBBKrOqZTDko5TP35/R1YYjdSkrvf7BTK
   mCooNi/qPo/IjZQngmD/2HgjpTnymvpeuSpJ3mmO41No+rdWy71q0mX15
   lbYeQFgvBBwxjzAYovm5eGzlgmc7YnMBfLR/5DyU5YVbjMPfx/7zTbttY
   ei3KkuVfmTR7QUpxBHmGhT0K44KvSccwX782cN4SMpAYZZuuO9gQuIAaX
   MDQL2bFDhKKimi/JTvGVXQVQ7yeFsQ2ta+6IwMi29+PBicsSZZZHiDUr0
   w==;
X-CSE-ConnectionGUID: ZWn4KgRfRl6utcKtL55yVw==
X-CSE-MsgGUID: YwE6iJxiQj6O+RLFOTP2TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17289588"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17289588"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 00:23:58 -0700
X-CSE-ConnectionGUID: iGMvQLWwSvCaBJnc8ax3Ug==
X-CSE-MsgGUID: 3H8WAyVgSZeQ9XdUTb1TeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46450114"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 00:23:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 00:23:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 00:23:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 00:23:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 00:23:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb0/yl+PfpN7QGEwr8Lf4HO4drr7obIHU0nwsE3qa6N+tQ7LXRViYlMf8JcIldu6+7USarTZxy47hdu3S3MIpHGrxWqxGPUFooSQzmqIEjGIu0dFZqRTCteihQ6o73U76Nz++AoPAVSWk76FFrn2bOmj+sqHcElsDhrcqLzecrGWh4M6LiwqSdSKMzt3KLS6YowX3rV2/Ls6PQoM3l6xsM0pGNktmB7qB0LfmTTS9hA5cMv/arQCHasekVTUnSwxdTXB+h9r8mPxSfUqCyMH90moCfnkwEWOWwSCCIFXmCaI9NUglj+k8bSUdSaSCtt/eaq1AsH1rPUwZm9oFGVIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA4vjEttalHfvm5EUB6AMqfR4wZYkO9SIlf4c75zTBM=;
 b=PkIOkyPsxApNAlkSaAynZ0pUXBE5V3KXMWAoJM8uE0YfLnJ4oHnIhcZ3dvflmRvNTxJwGBzYL55QT239/juX61X2HOj3Zp+BBF0Jl+FCOj/NRlSP2ILuPbBB8mZUZLhhqW0XFOUFUnn8alVhWVPRZtXWZQpkKdmZkKowFmlkW270RkJltT9XKEUF3HdJBDEw/rbyEWDKYZWB3nuRSQsq1vAt+1doCsQqk/pCWhSlt+cI0Gicg/Z12pW/osvbdoB5jKDuuCPjuEiVFaHduv23GqPrP6Cmup4Gun9PpXSt5fCokksUpC71uLaRUk7oxGD4Mv7pY4k+lhNpZcKo9eq0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 4 Jul
 2024 07:23:54 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 07:23:54 +0000
Date: Thu, 4 Jul 2024 09:23:37 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <shuah@kernel.org>, <fenghua.yu@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
Message-ID: <xfhv744t2ol274w6lddon77rn5dkf7dzbwqcoknok4kk4guehz@hwjsusvhoerb>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
 <c1ec4e04-20cd-4717-83ed-da6a55c91889@intel.com>
 <0b9210d3-2e47-4ff3-ac06-f6347627b0d3@intel.com>
 <d5bd6275-ab86-439a-887f-17c04a586716@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5bd6275-ab86-439a-887f-17c04a586716@intel.com>
X-ClientProxiedBy: DU7P194CA0027.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::7) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SA1PR11MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e87a433-0350-4e02-b989-08dc9bfa4265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|27256017;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?mpXsRPX8OanhXgik3IzROOwSRsZteeuXnJ2joeQT1hUgQmHGzeb6UCmVkc?=
 =?iso-8859-1?Q?VI38ySnvSgIeeIfDUHiHPZNODl8f7cqCpm8DeeG3+TLPS/qzSaTte8XOEg?=
 =?iso-8859-1?Q?vOMEpM8MobJpG3QL2B0Kq33sgvHNrOjgC2cziDU/xOcT3rxx5fwLn8fDip?=
 =?iso-8859-1?Q?rICjbTHQivC+aaaIQ/u2XIjaGyQsNA6cATOsERrBpheyqXF/hc4hsWogu0?=
 =?iso-8859-1?Q?DvSnVL0OCWfgghFeudaNkMua29/D9pk/ZgYv0u8G3WZMl+4cZQ+UJMep5c?=
 =?iso-8859-1?Q?1bQ2HDwbKBvqK5/vo6UG5eEv5JtJtF26zXH0PaJD3PVloQSF+vqG4h+uPU?=
 =?iso-8859-1?Q?UGARIzb3hhm6tbO4NzU3NZzR+T5RaDSR1WbKZGPELKx0aVRn03UJXUGwHI?=
 =?iso-8859-1?Q?PBqCQM7Z7phB1l8D8pge5W1kHLY7IJJHXFuRGzpKreCigOo2JOzhm6tWER?=
 =?iso-8859-1?Q?z3maeIUuh4XqtkI34HTZFouNK05orTB7abhg5kbwgF2ucwkSLVvg0qGCoT?=
 =?iso-8859-1?Q?+Wzk/9zS1uWg/R3T5AOKg0JdStY2NSQKdvnvZpLtBzZfOYI3i4qfD3CNE9?=
 =?iso-8859-1?Q?QhXeMWYg2T7iO+71Fhle7SUthZIQ3x3UELyHkDdjNC0T3X5yAMiGOPfC54?=
 =?iso-8859-1?Q?pyf+icGiWpl2IRSy968vP+4IpC9HjSGEFYGoDV0se6HgKTnOwVF51ccBjq?=
 =?iso-8859-1?Q?3KAITNe57x2K/+tw8Xd4f0nwdc6YSMCgfaSRVn6zYd3HSt2/2K7QqND2Wx?=
 =?iso-8859-1?Q?4h/3Wd0ycKcADWSO1MzHp47lVUqJL2G9mYuMvniqxW5ag8ygCRgbU6PI6A?=
 =?iso-8859-1?Q?cmlQHl8cbyHxh3zxbx6Mdgw5YU2OEdYpY3+5YYFBwsiaK9buTSRdx4D2rO?=
 =?iso-8859-1?Q?m3pI5ff9NZlP8gVr+Nv7+znnOb3keVkvPmjiMnWk61vqS2bDGYOC6FzKHL?=
 =?iso-8859-1?Q?hGX50fXc+f3IVlNFBMmB2/pnuRaDM8C6fZndgBa+2ge5ooPS0/X+XfiXB4?=
 =?iso-8859-1?Q?VGeVL7wWAFTkV/BjWWjvr/PLYagxB/D5FRq7jIEBgqZ8d+Nf27fA8yn6Cs?=
 =?iso-8859-1?Q?k/CwxM0JIfqhUEMX8PMI83f0o71OhD0pqP1GwYkwJwyVy+8cS7wE44edSF?=
 =?iso-8859-1?Q?ed2hh/S9ZTd5F3uhcfsPoSge3/x7XoyoNY8aTe6sMUMFWPCGqTbiB6MAm6?=
 =?iso-8859-1?Q?tJ494quCGFQI9M0HRPqxJHt4DWRKpf02RAvD10dRm4WYUU6t9x+J67HFdF?=
 =?iso-8859-1?Q?XmzDqzj3EvfCJ8MDWXJ1v00q0QE7qaAGwby5Y6egDx/2EG7VQYOpyK1TJQ?=
 =?iso-8859-1?Q?4pFh75gb863atVhgcGyxGZ+xz+IGysG3rnPRqcIcqmHlpAEuHYEkRBAjhP?=
 =?iso-8859-1?Q?KecCvEtmi/j57jKYWJIsCARnhaqHm6lixOhBuTPwDTBGeAYF7SxC3Z5r1n?=
 =?iso-8859-1?Q?SHSkCXZ69Bj9edvjNir3KCzwg84L3Det8sgXmQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KW7WTuFJ1eLywjuKUsSzpAY8CuY2r81V3z2LYPDA4qQzbjnCGg6UNs/gxN?=
 =?iso-8859-1?Q?55zjbFos8GR9+S45qgQ5X0klUtyf0Jkbw3WoOAsL05KuC4+sFOH7/M/m6h?=
 =?iso-8859-1?Q?AvTbPhNKwI9i8kBKrxHtdIJzn+wtsf8t62xh2MatjOe0iG8S7C7vFRFmps?=
 =?iso-8859-1?Q?RuHz57EMvXNunjpm1gQdiNfwle3sGRD3qmQjZzlWNjpaPEOCNryWKXVq70?=
 =?iso-8859-1?Q?0a0iUEqEYVAZ6CDbR6mVuu70pxk61oacCghENQRmZFrQJsOP+3I6DCNiSg?=
 =?iso-8859-1?Q?7r+mwP6n/nvu06cs2YzFe43v169rA2HwLt/sCuxU5TwH9oeXfmrJk+xXW0?=
 =?iso-8859-1?Q?L0K3/HAbTnQhbBa0QFsr/wqUDbHPA+0Uwq1RP70ElcCj/BESbIKaDVew67?=
 =?iso-8859-1?Q?TR+E3+giU3UmcwcmjGCp73+5ar2X+0J/56ZnhYgKmDdEHlEU4pLOd4Lqiv?=
 =?iso-8859-1?Q?pmaiBxOVxiQ55wW7vbEB8SCrBGwU1ZR5/vBfamsBJmBk5J15aFyfCDhAcF?=
 =?iso-8859-1?Q?wanWth/8wFGf0ZM7WhHUbZP9AUdHCV056G1y79tWaNuW4KtQBw+nhDJHov?=
 =?iso-8859-1?Q?+RTN3oeyqIN2z3DI7D97Ox8TCqKnCEoMowNlhIUS8tYwBhRTPqYcCvrPjO?=
 =?iso-8859-1?Q?zNvXBHVE3YuwsSDyIJ94q30ha2+PsRcupr7zDjmcwCCq2K/LFJTl87Ilu4?=
 =?iso-8859-1?Q?9QzcH5h7sv+E2aeK4BmHtmstQ24GE91haP2Q8tZ4blShOgESGdRNS/KO/h?=
 =?iso-8859-1?Q?dhfqDlxVIW68N8IFfLrKzLPe/7wUtKZKDP24tF3lQ7pyahI5OO3ytbxtXA?=
 =?iso-8859-1?Q?mXutFsB0JiMnudOiLaFc3nF8sF8APP8ZwpwStgU7tzSfFEI5yYXDqEwAAn?=
 =?iso-8859-1?Q?jCdA7VuUY7b+2v1Jwm+GTOkIYoB2iAE7tKNqd29YQybM0rZq6snt3k4INm?=
 =?iso-8859-1?Q?CaKq6Uj154ftETCv144ul09fHTEaQiQcvKf46Zer0T2TFgxlolpfGHX2WD?=
 =?iso-8859-1?Q?Jktvyxsy8WXwF0g6h5CxzDBr7ZIHG5R/0Y4IfoUuK64C2DcOrVoqpJdKF4?=
 =?iso-8859-1?Q?DdyY8+DzAc/KOsBqTw0NkCasKFNLGMeZx8G0Y9+f7wShEtdFw/xl4wg1MD?=
 =?iso-8859-1?Q?Oo8Oiws8u1VNb6ITLivbyLI2Cu751y8cDSmKhdmuZsdKmLJOXIEypnbBVm?=
 =?iso-8859-1?Q?08vFMPHYeEegQrgSFl1OVCHDJsu2DKIAThLKCy0JF5qe4M/UMYg2D5PUrF?=
 =?iso-8859-1?Q?Mdo1Df7pSia5QkuHeBfpq6iQ0AMt2WMENSvK9uEKJxsrZYZnM+ZQmf1pYZ?=
 =?iso-8859-1?Q?DSCrj/lF/9m6upc73jB8llB4DD3BPQ6wEsQzrlioD8lgpARmrR+8ECBiTu?=
 =?iso-8859-1?Q?emEYvn563BUwdtWVqxAvlVieXzHsRqt47CUriCUmaefbdsNkEAKXhAJhEU?=
 =?iso-8859-1?Q?8s+s6RemzGIh9GbdJeb6Je/h0zRj9oaN3cpKTgNqYdmB7DsRDia30eQ1GM?=
 =?iso-8859-1?Q?pokG6k7SIxBqkrmAw1E5GQoX+2m4EcKVbCb02tF16NV2P6GjVkFxo5O+J7?=
 =?iso-8859-1?Q?r/j3m9/WaVXBRtG33Uob4NhEQRIvX59OjwwOxDaCO2W6BFhGaPtJft252z?=
 =?iso-8859-1?Q?31sAwqgrqAsOsGfvb101keN8jeSHR3SUKL7dLOmu7TpAmmz+wMomtXPyXA?=
 =?iso-8859-1?Q?X9iamSdfjZjsHtQ6Dk8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e87a433-0350-4e02-b989-08dc9bfa4265
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 07:23:54.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVP+rDuoT+YZzVB6X+dLu7nD2hLyfbphpotI5UU6xcnNCZNM984d7EonRGt21MgPac8WrsRTnzr4FLKvUIrdIo7ByVCvQfGLxUEfBvpymvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6734
X-OriginatorOrg: intel.com

Hi Reinette,

On 2024-07-03 at 13:51:03 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 7/3/24 12:43 AM, Maciej Wieczór-Retman wrote:
>> On 3.07.2024 00:21, Reinette Chatre wrote:
>> > On 7/1/24 7:18 AM, Maciej Wieczor-Retman wrote:
>
>> > > diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
>> > > index 1ff1104e6575..9885d64b8a21 100644
>> > > --- a/tools/testing/selftests/resctrl/cache.c
>> > > +++ b/tools/testing/selftests/resctrl/cache.c
>> > > @@ -186,4 +186,7 @@ void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool
>> > >        ksft_print_msg("Average LLC val: %llu\n", avg_llc_val);
>> > >        ksft_print_msg("Cache span (%s): %zu\n", lines ? "lines" : "bytes",
>> > >                   cache_span);
>> > > +    if (snc_unreliable)
>> > > +        ksft_print_msg("SNC detection unreliable due to offline CPUs!\n");
>> > 
>> > The message abour SNC detection being unreliable is already printed at beginning of every
>> > test so I do not think it is necessary to print it again at this point.
>> > 
>> 
>> The "SNC detection was unreliable" only gets printed on the first execution of run_single_test().
>
>There is more about this later, but this can be printed at start of each test.

Okay, thanks.

>
>> That's what the global snc_mode was for mostly, it starts initialized to 0, and then on the first
>> run of run_single_test() it is set so other tests don't call get_snc_mode(). And then the local static
>> variable inside get_snc_mode() prevents the detection from running more than once when other places
>> call get_snc_mode() (like when the cache size is adjusted).
>
>The shadowing of variables can get confusing. I think the global snc_mode is not necessary, having the
>local static variable within snc_nodes_per_l3_cache() should be sufficient and run_single_test()
>can just do a:
>
>	int snc_mode; /* new name welcome */
>
>	snc_mode = snc_nodes_per_l3_cache();
>	if (snc_mode > 1)
>		ksft_print_msg("SNC-%d mode discovered\n", snc_mode);
>	else if (snc_unreliable)
>		ksft_print_msg("SNC detection unreliable due to offline CPUs. Test results may not be accurate if SNC enabled.\n");

This sounds good, thanks.

>
>> 
>> And as we discussed last time it's beneficial to put error messages at the end of the test in case the
>> user misses the initial warning at the very beginning.
>
>Right. What I found unexpected was that it is done "at the end" but from two places, from the show*info()
>as well as from run*test(). I expect "the end" to be a single place.

Okay, I'll remove messages from show*info().

>
>> > >    }
>> > > diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>> > > index 0c045080d808..588543ae2654 100644
>> > > --- a/tools/testing/selftests/resctrl/cmt_test.c
>> > > +++ b/tools/testing/selftests/resctrl/cmt_test.c
>> > > @@ -175,8 +175,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>> > >            goto out;
>> > >          ret = check_results(&param, span, n);
>> > > -    if (ret && (get_vendor() == ARCH_INTEL))
>> > > -        ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>> > 
>> > This message does seem to still be applicable if snc_unreliable == 1.
>> 
>> I was going for this one error message to specifically catch the kernel
>> not having snc support for resctrl while snc is enabled. While the
>> above message could be true when snc_unreliable == 1, it doesn't have to.
>
>If a test fails when snc_unreliable == 1 then nothing is certain and some generic message
>is needed.

Right

>
>> SNC might not be enabled at all so there would be no reason to send the user
>> to check their BIOS - instead they can learn they have offline CPUs and they can
>> work on fixing that. In my opinion it could be beneficial to have more specialized
>> messages in the selftests to help users diagnose problems quicker.
>
>My goal is indeed to have specialized messages. There cannot be a specialized message
>if snc_reliable == 1. In this case it needs to be generic since SNC may or may not be
>enabled and it is up to the user to investigate further.

How about this in cmt_run_test() for example:

	if (snc_unreliable)
		ksft_print_msg("Intel CMT may be inaccurate or inefficient when Sub-NUMA Clustering is enabled and not properly detected.\n");
	else if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");

This way there is a generic message when snc_unreliable == 1.

And as you mentioned at the end of this email, the user can be expected to
backtrack to the beginning of the test if there are any problems so they can
discover the exact source of the issue - offline cpus.

>
>> 
>> Having only this one message wihtout the "if snc unreliable" messages would
>> mean nothing would get printed at the end on success with unreliable SNC detection.
>
>Having a pass/fail is what user will focus on. If the test passes then SNC detection
>should not matter. The messages are just there to help user root cause where a failure
>may be.

My train of thought was that if test passes with broken SNC detection it means
SNC was used inefficiently right? (either the portion of L3 used was bigger or
smaller than that allocated for one cluster)

It's not exactly a failure but I thought it deserves a warning at the very end
to alert the user.

If you don't think the warning should be printed on success I guess the
condition can be:
	if (ret && snc_unreliable)
and the user can look at the start of the test if they care about more
information. And the message can lose the "inefficient" word since it would only
happen on error.

>
>...
>> > 
>> > >    volatile int *value_sink = &sink_target;
>> > >      static struct resctrl_test *resctrl_tests[] = {
>> > > @@ -123,6 +124,12 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
>> > >        if (test->disabled)
>> > >            return;
>> > >    +    if (!snc_mode) {
>> > > +        snc_mode = get_snc_mode();
>> > > +        if (snc_mode > 1)
>> > 
>> > 
>> >  From what I can tell this is the only place the global is used and this can just be:
>> >          if (get_snc_mode() > 1)
>> 
>> I wanted to print the message below only on the first call to run_single_test() and then
>> print relevant warnings at the very end of each test. I thought that was your intention
>> when we discussed what messages are supposed to be printed and when in v2 of this series.
>> 
>> Do you think it would be better to just print this message at the start of each test?
>
>Yes. If there is a problem with a test the user could be expected to start tracing back
>messages printed from beginning of failing test.

I tried to reply to this comment with the suggestion above.

>
>> Or should I make "snc_mode" into local static inside run_single_test()? Or maybe add
>> a second local static variable into get_snc_mode() that would control whether or not
>> the message should be printed?
>
>I do not see where more local static variables may be needed.

Since you agreed with the previous paragraph this one doesn't matter.

>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman


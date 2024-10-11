Return-Path: <linux-kselftest+bounces-19571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F31C99AF04
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 01:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80416B211A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 23:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3881D27A9;
	Fri, 11 Oct 2024 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcHNAZ3T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E18F1D049D;
	Fri, 11 Oct 2024 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687821; cv=fail; b=ei8WqJjXq1hXZbY9HJFzEedRyJdBZh/a8dm4gNb+ZnvBvpTsnX92hv57w/eWoHMG7rpNabyibTzT3kcZZzh2wyMMc5EGZJZllVbwH640gxjDpcEBV/d12qfzdm2G7dQBgG+3ohaCleUU8hjt2CrQis7kCWKQpHauoq69EcuqRNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687821; c=relaxed/simple;
	bh=fQbTF9wTVWXUnLTy2yfyfp+iruVOigZ9KuC0o1X0/og=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NtEJ0f9tAD+k1vivNR2xkzsHkLlO8KKJjO2oB0ec/0pHqu661nB4ekMCgSaNVg5RLYZ+TVw4GFlpZxtpZ2dgqON1MkTEKMk45IwL8SaXzXIR8JbDgCadMIjJu3kiFF4sFTWM4olxMJCZ6KPbkIBlD/MfIxxD9cR8dkPlkkX/7Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcHNAZ3T; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728687820; x=1760223820;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=fQbTF9wTVWXUnLTy2yfyfp+iruVOigZ9KuC0o1X0/og=;
  b=gcHNAZ3Tjix1md7/mrlMC2CiSsZXEJaQ5kU9XYdsvISmZkemNR11LcIm
   MUh6q1YpJnzycLE1dHPWJxmIJCTm49b5PSMP+eyKz9poJ9vHAvRTWE46f
   qpbPhMpyWxevfJhoFmV1ShX74cC3ZVU4D0UOHc5qBaWd5n1Q/cMgOh2Rp
   5azs9n0RBqFmqs2QQUGr2z6YP2o6t4Nr7CSGoXi5ScqudPQ3xu90hurgA
   Kldpfe0y/7x29K+raOYd/FEHT7+n4matR1T3Luob+ySJxlOh07JjjPSkG
   ni7zXm7L2XrLo73RRU27RgJc5Fvhgqxwxb6hXTkf7CTXAVIDRGRqEfIu7
   w==;
X-CSE-ConnectionGUID: Gjg/WewzSXmZ+uSpEnJhSQ==
X-CSE-MsgGUID: xtsgPCCcRU6L701d+Ajq1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28206944"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28206944"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 16:03:39 -0700
X-CSE-ConnectionGUID: jkE9GZjkTwqUa29214MzDg==
X-CSE-MsgGUID: qHz5eJUKQJ6onUfooiqk9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77862486"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 16:03:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 16:03:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 16:03:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 16:03:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpQ08xFaVyyZ44oo2FsTzYVkUZ66iY9nGHheT+MJzNBNMlbYz+duStjqyJczT4aIyd7Jncx7jF7WMThz4/1Y7ELx/2T+Zp8EuHgtxOivkSRztGBMPSXvkGf/GgH64yVc7UbfThMwqHWByICRvW13O2W+wzEHF7BvbLE/6BCeU6Ye3VT6TtRjIzg3VImWrqtOO5uC0jqke+ThHxyCUtigtQLC4xkt27zhGwzN034iQTpaneEtzZdLyzQe68AjejJcAmnzQspEsQsrUtSmQI+JSmr6YnmFDxmlc1W4+Qr09/dNEnzYQvya6613dRJhtu9MCztOM5Ber6frjaV/KnxdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv/dRUOBZOjcLo/Bg12U5SYtbfW87MUtCEqPkCTIsgk=;
 b=yITAxP+UXbmXtUKIsz/BiVPrU7YQbCpTn1cKkI5PlLP8OxeZ/sVklhp1Icz2nGW0cXx9NeCUinYgpu5QsD58S5vT3YohhAknNIVIKyj0wNOMhDiRG8P1867TNacAfrcPw3RRcZ/OVUHtBAgcS+mHbUOU/WN27ic2TvwZKiEoJJGz/Zd5KCbwL3QJLDXZ81z9qpPnGnWOQTYGSyw+SCT16BCilcNIeRGhZ6kBgONDDk+FCqBx03IBZX2PzaIZDYXLT7D0O5lwESU6usmg2TWjdONnbcl7lzT0OjJrxdFg9pvcSqLaoSXW2rCNXbdimKSzlOa6i8gtTw+/OUj3KTGoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CO1PR11MB4915.namprd11.prod.outlook.com (2603:10b6:303:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 23:03:30 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 23:03:30 +0000
Date: Sat, 12 Oct 2024 07:03:19 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Shuah Khan <skhan@linuxfoundation.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kernel-dev@igalia.com>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v3 2/2] selftests/futex: Create test for robust list
Message-ID: <Zwmut67RooOBFNI3@rli9-mobl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010011142.905297-3-andrealmeid@igalia.com>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CO1PR11MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: fa37dc25-ff8d-4c59-8d23-08dcea48ec15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?EFSKJFj8y9QxiY2jqYPE0FjU7AMsWLAXr+3AfIdfo4QGlTP/+vh0MtUG6C?=
 =?iso-8859-1?Q?7KjOftKk82yICmgXagtSfvTUzT7uiIGP5IaNE04yK1qxrvetsdlQ6fLYWe?=
 =?iso-8859-1?Q?KV6thA9umcU3eiG3n0O/POZbi/+NStWZ9Ozv7v1IDASSYRSJ+w6r2CM6UT?=
 =?iso-8859-1?Q?IlOqz3LYpIoqXsFKlggL5/Tiq5ryi1C+10x3TJlOZfQz5sFegwQqbkrsGd?=
 =?iso-8859-1?Q?mJLgY919uM41tmZFxHD3tqWLX1GNGHhx78lrSiJTMXvixHQLNTR8DjiwYc?=
 =?iso-8859-1?Q?spd3ZLhqgW5Mot5mZ8qDh50Emr7n80bPOJ24PgOqm2hEptPw/U2213OxS2?=
 =?iso-8859-1?Q?DgVyzoudhXxL3g4e5YujfG8SePjxntBJvblDc+ymgW9bb28nKtUwhgGWp4?=
 =?iso-8859-1?Q?TlpqSIWXfugp0ADX7P3pQqiUjoHRUPlkEpeaI+wPDJ0nyoGgXUrOdIp+Pi?=
 =?iso-8859-1?Q?YcsrL0QGIW334XBhiAhtsOHGnQF1b2Oh+bpGAgB5Z/K/F/nJmm8GH6pxKf?=
 =?iso-8859-1?Q?FS6X6tx7W2RuX7q8BgsqvQLHf/kbpDgiuMiG3GSNI23Gl7LuNyQUkJnwbO?=
 =?iso-8859-1?Q?GgYqvNJBtn2mbqC1Y/F9xCquWCmWJrwKRlcbYuTx8St3sw05hLxt1yLWQj?=
 =?iso-8859-1?Q?q0e85iEQe0wdhNTaAjeK1/ygew9NDMr1u8b1yg4C/m9++sg7I5hHAx5JlK?=
 =?iso-8859-1?Q?e8sz27OKJ54Km4sqO3y8vU+3+ebB4FMNLFHsDueYCPViz3c117XOZG/I0O?=
 =?iso-8859-1?Q?Dn4wxUkbJf6kaXjf28LICYejZF1VUTpfL5/UT2ThigVeP8wIsYcYlCe6Qq?=
 =?iso-8859-1?Q?LG83a8EveFF9KkZY0zuD/UHkppML6JnsyBn6KhCKcZNNLMgm7zgmFF3hgp?=
 =?iso-8859-1?Q?1q67ugssGwjyf48HbPmEVNclJw/mqcuQ32rz9hwQl/mZWzC0Tfke6Keqyn?=
 =?iso-8859-1?Q?rnpdDeFJVUaKC+MQBeejEAbxZBPjqFXUM2okv8jOMmdJwgjVT5/AL4ggJh?=
 =?iso-8859-1?Q?yCDKociO1pP18gZmZvROloiIgWwA9ZJN8+1ooDjatSLXsIlgU/8fRa6il8?=
 =?iso-8859-1?Q?i+h2/riIjECFyK03zLXcPlSA9Zi/nEk2iA5+9GDt0slua22LtRiQNzIoeY?=
 =?iso-8859-1?Q?OgKkUz9Avl1IQdvYtkEeIUvkeSspQAYPAcFgC926w9/CmGRORwSfd0ToXI?=
 =?iso-8859-1?Q?+tWXr6GV49/oW7ORWAOIyDgAqo0lzXiNVAwZk3L/HAguJK6P6f11KwJlL9?=
 =?iso-8859-1?Q?s5xODaHAcbDJNtWZjQ3vJVKnA7XvFPbfQPmPJ45h4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VSMqSOYQhiVAt1jyL4kNYauevDgbjfRmQhH8KeFRxC+6/w6S2pe3Xmv3hh?=
 =?iso-8859-1?Q?mj0mzTzLJNM9/hJTFDWp+3PGFjE/aGcmizUaG1ix7PlSZFcDou/XxlPxmw?=
 =?iso-8859-1?Q?gRf3j7nzDXRgFW8m+KgtooBT8KZ5llgkG5CHZZ0vjKs1dIL81kyvXXT2KK?=
 =?iso-8859-1?Q?EnXWTlJX8u43smVIAAFuV+45J/V5+QayorePpZBR1TOuRXJ5oahBiXIyYn?=
 =?iso-8859-1?Q?v2Ju7shhaEP6JFjDzdmplfsvTtBNAI+MLcsXYttPTuCqo47lTXpdD4SdgL?=
 =?iso-8859-1?Q?Oko/G1T+9IZIWlu1a9tGExB/5ENSNy5gf/9BJFwSv5BjaKEo7MincGapPt?=
 =?iso-8859-1?Q?1+PQcwORmF0iH9MQvcAVdW+kPUHQsMguB2a0exsh8nlhrTtO25ev1zjNWs?=
 =?iso-8859-1?Q?rBF90IW/TK/RtdONPLeRXhyn98jU7z72xmcMQYQ96hq+m3M2fqZ0OyS4fJ?=
 =?iso-8859-1?Q?TvcVB00Ls7SaWp3nAiKZTQKOn/8ya2sVcN8mLJrOHbPfYUl7bEWgAKUwlK?=
 =?iso-8859-1?Q?MuRaCeZpxx2gus2/R8L+fBMQyhC12HSkom+Rg+Ot/0eMpcq31dLfgnbQaT?=
 =?iso-8859-1?Q?bublDhMOJAGXuttsX9QCdcFqU7bZO055cUgsmcObUunYXc+UszKuXzvLzK?=
 =?iso-8859-1?Q?OrIeRao3Y3K2eOW36pHWK2K/VXwvH/zvTHUDn55mzm9UWU7tnTzikONyWy?=
 =?iso-8859-1?Q?bu7/rTlTzo3Lv01A0MTqJw7288oSf/hVsE88Fe+6gdN5i+sPUoybLBJLHn?=
 =?iso-8859-1?Q?1KpFKETCpOW9NfQcqV2KXF+lMEib+yZa63kvaYqY84sbBvlOGV4UN2465+?=
 =?iso-8859-1?Q?9alin9pt9Yo4qRvfpUmEchVFoBviuIt/0drOtLO2F+KLmORPkVRatmclnF?=
 =?iso-8859-1?Q?xGpQs3Fp+0PUHTQTBndG0LIgElJFRAXDi634OOIeFifEJSCvrkuzU1c8Ep?=
 =?iso-8859-1?Q?Iq7a605wXtMmsdaT+cHnpWr2x2omMXW5SlfwRDtTNeoKqggHjaVDlPvW2x?=
 =?iso-8859-1?Q?QERNU/ACYtRm5Wl0sK8LIhOyCyU7gwHAZTtjcNGimk2PsWHFyej9pDM/Xd?=
 =?iso-8859-1?Q?Mc0tXD9kIlEohfjc6e+iE8DbLuTvuQjsDNnyTHuP46FvIuO6j2FtXgjr3B?=
 =?iso-8859-1?Q?KMvaIApf76tRQfEfFmqQkO/XVbt4wyto8OGAiFTltnPC4dhHozSXCP1dxS?=
 =?iso-8859-1?Q?zhuyNNG8B0EzLMnZ6rvxFWWzMciSZksFG/n523iac8xKAY6QR1FAYiW7tk?=
 =?iso-8859-1?Q?07LMpZZ4a9YX5ol0RHPlpOm5SFjuq6w1hBsVX+bbwDpbP13j0R7mKWoHwU?=
 =?iso-8859-1?Q?wvqiY3WVovVOTssPJHGhRXOwKHV/v71MoslAGRzr30wFPhlN9Wl2py2RFv?=
 =?iso-8859-1?Q?jUeRoZ4G9Igs5EdnKJXHZONb5WjFi9ahRMqCpayTfRvRfgq/q6nfaMuHhz?=
 =?iso-8859-1?Q?QvBs5gnLJ/ILLdr9eo/DGtX85O//YLo8zXZaHbBAafclFlWrLJSudkgv8b?=
 =?iso-8859-1?Q?bCJvs5j0LOOmLIzWFyyVBrP1Ppdsx5XSP+JkowVfPDS5syXxmEP9CIj/U4?=
 =?iso-8859-1?Q?LRFiHxSYj4prutMEhtLm+r/Dx/RK7mYhL4e4lkkjo4QHPxQEg3CkbSuEtZ?=
 =?iso-8859-1?Q?gCM9LxjDR+ALsHpFsjo+I42LiOuT7peh2p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa37dc25-ff8d-4c59-8d23-08dcea48ec15
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 23:03:30.0893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5F4xEV2OXm1CQMSfBPMhHCz1IgxtdYVQ4pl1pKcvMTF9yrvuKTTG4gqX7MU5LnlI2gKnbI20pV+zNdek81LNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4915
X-OriginatorOrg: intel.com

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on linus/master v6.12-rc2 next-20241011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/selftests-futex-Add-ASSERT_-macros/20241010-091311
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20241010011142.905297-3-andrealmeid%40igalia.com
patch subject: [PATCH v3 2/2] selftests/futex: Create test for robust list
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241012/202410120549.1KpTVqTu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202410120549.1KpTVqTu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> robust_list.c:121:44: warning: passing 'int *' to parameter of type 'unsigned int *' converts between pointers to integer types with different sign [-Wpointer-sign]
     121 |         if (atomic_compare_exchange_strong(futex, &zero, tid)) {
         |                                                   ^~~~~
   /opt/cross/clang-3b5b5c1ec4/lib/clang/18/include/stdatomic.h:144:112: note: expanded from macro 'atomic_compare_exchange_strong'
     144 | #define atomic_compare_exchange_strong(object, expected, desired) __c11_atomic_compare_exchange_strong(object, expected, desired, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST)
         |                                                                                                                ^~~~~~~~
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



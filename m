Return-Path: <linux-kselftest+bounces-23419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14039F3321
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 15:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC1B1608D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA98203D7D;
	Mon, 16 Dec 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBBsq54S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796A1DFDE;
	Mon, 16 Dec 2024 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359064; cv=fail; b=WCLfByu2XQUIPcM4faX3zPdbdVHhboTvMZuovngzAcKHnzn7+hhqesLcI5CF0k5DTn+UnrVeEFZ3e5p3fVs0APY0WkrP9tnmqV7INCn6kvqu3nQWeLq0oe6K3q2i260mLczUh9gkTcgTJjFv5UkSbA4QO5G/huYLQ6sYGzyEQ+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359064; c=relaxed/simple;
	bh=3onRjpMT+fS1zwbt4vYsXdUk3iBEIwtA+csV+oGNqFA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iPC2VDkDdyDEEOzDMuuqSJKOIZ4HNQNsozoyWDnrsXY/XugplEHHXn1gxcFgZHTbqN98ASmCEW3Of5F6MA9FZKOAN13BYqU1KHX+abJavwS+tENgXZ2vriptCXeMjEixY/M/9RE9a6i+S7f6+IqcvoN8PNtt1GDAlC4IjQaqr8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBBsq54S; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734359062; x=1765895062;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3onRjpMT+fS1zwbt4vYsXdUk3iBEIwtA+csV+oGNqFA=;
  b=XBBsq54SroBM6IOmKIs1on+Vp0QKH7i2Aw3hrHrEwvCm8QV1fLUb1GkH
   +2VtG93r61b4vCZkM2eV0EWaY0G+215KOc34rYcAY19vp9Pjno7ymQ5Ov
   +rA83Ojx1/Xigj9bC/LUmgFIVd6zdAIRUXLQO5ATsqqI/htS7ISS18NAb
   FS0uu3LA2eDgwJyNXD2LAKzWuCURJX6wFYDsSJyFGHI0mgx9g4POvFRVR
   eYtu838gaunGoP34Bt1a7NA2mK+LSNBdatPF5OBPsbxhps/LonYIKPyHE
   PqF/1Tfb4lwCZ5OdS7peIL+jXnypS7zlM+eDDKX3yEO2hCGvA90+e/nT/
   g==;
X-CSE-ConnectionGUID: tR5u5/8eS0SDnxIgoUNMQQ==
X-CSE-MsgGUID: KlBHGF7PQcC2eBTohRfrzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34065149"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34065149"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 06:24:21 -0800
X-CSE-ConnectionGUID: enXUEFmCRa2Z+3BETra9Gg==
X-CSE-MsgGUID: sqV/5jvjSHiJy3EMe+5pDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101355550"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 06:24:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 06:24:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 06:24:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 06:24:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUR2XJZ4WO0phJUjBXm3chrPZPiXeIdpnVxh3aDlpMg2spaRZIrZi9X+cQxygzittyk8lKjDmxj3QElboJWEL1p+Xr+ogviaYreimhHlvQWtDzAzCTXOI8754HYTXD+0bYihZajEDgUnlwQjtin0s0aOc/vC6GoGFYlfCQHMfkIRfFK1m4+MkFaZaSm5h2Q9f6QhNx/Vn77AYxjtkNBKUGLjNYn/Uwxy8Lba7noBymhtLMKR81BRwtpdN77QDYfzdwkREBBK20ObU0aezga3ELl7/MnUN30L762SITxM74fMKBndwrclEyxqAX3AD6iFiH5POluutZJap2/CT9PFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCel6eYpdUylDmpyeNdprOJyS4/c+SEi34pGEWhfAus=;
 b=jq8ceD1PyN9RtSzpCPt1aRkkB5zyQ+i5zwbs1KqFA1b8gETslOkTr/DViUAeX590R5s0a2wL8N+H4yPMvey4zIkQ0NTunwrG9EAJusMoQRZone9M4gspELZAO2eaozwMcYsqv4XQfFv6l8o6LSijyyMLNACV1T7XHrvmSx+M4VlNoiNsd+3YEOdzJ1iNz8IzTHZNzTeZG2EBCFUufzbF/VS/6OJ/Q275IUPxiBrWQsNMwSk1Wv/8ufh6iKiXzu9P+EsJvLYw4R71Cqq0Vkd6WCR1NkScdlLQKgQU58OAkN/focYeeZwydRytFT8iWGjqxszqcezNuZXGTVVflCj2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CY5PR11MB6389.namprd11.prod.outlook.com (2603:10b6:930:3a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 14:24:05 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:24:04 +0000
Date: Mon, 16 Dec 2024 15:23:39 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <shuah@kernel.org>, <fenghua.yu@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v7 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Message-ID: <4magarhopewnvypvj6kukva6gl33zwgpjmjomz7s3yrkntxnrw@idiykpyhep7k>
References: <cover.1733741950.git.maciej.wieczor-retman@intel.com>
 <0adccb86b3bd1b8ae75cf8fdcddac7d1d79f49a4.1733741950.git.maciej.wieczor-retman@intel.com>
 <4c1ac17c-e50c-4387-8512-e82e99f4ce4c@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c1ac17c-e50c-4387-8512-e82e99f4ce4c@intel.com>
X-ClientProxiedBy: DU7PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::21) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CY5PR11MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4520c6-2d6d-4524-b3ac-08dd1ddd4b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?b2jHFn7Q8z2PAE3nxMPrN7NJXEcEQg1TOg5zekXP6DhYHZ0mnd3D0wi9C8?=
 =?iso-8859-1?Q?1BIybtYiFPQZy32YZ+7L2HvDrCiWmUSyhsRv+o3+b6aSxQ373OTdY6rk5v?=
 =?iso-8859-1?Q?Pq6LLpPQuvn9K2jIYz2pTFLt+jMI/gIU4NXugMYAwLOjqdc3lk/AZMnDRK?=
 =?iso-8859-1?Q?YL5IQnPcRkvsFtn4k2oTLcfHIanUxEKVT/u6X9n2/pdySi5P2CNvYq3uPL?=
 =?iso-8859-1?Q?82bj8pCrpebh970YMgm35wpst4wiuQ22WQh3ta12iuvtWqvD8nENGC9Kvm?=
 =?iso-8859-1?Q?ml1kqSi7Ltu9yyeXIERqzcLLcPn1rB9ual0HzKzpJ+XxvkP/k+EpNWPoCD?=
 =?iso-8859-1?Q?0NuKwV4QqCssHuw6lM69QQ4K/bz/a33SbWIXR9Er5l/aH3FHtLZNbSZDf9?=
 =?iso-8859-1?Q?8UH/a81YuidMWd+STa5pjmRpNVaWD1wZjaNVPJFmx9JGb2m1zGGqQOCbuZ?=
 =?iso-8859-1?Q?c10AdzqHK/SWuMhDNyjaKXkLqoR5FJScVF+mFefDw0olUxzCJQnajoryIb?=
 =?iso-8859-1?Q?PdSPSyqIaetuw6fIlz0831EeJJ8qDdqwdxrBk8sb97yRZq5mIaT3vJzVdu?=
 =?iso-8859-1?Q?67myZ14Ofqw0202XgeRHDfnm6o3t7yK6rdsvkhwihTBx3eqiCh9vsx10xU?=
 =?iso-8859-1?Q?yLq3URG6COFhd9upKoPrI2LZkYyt78ZfjeCwrGceI7QWJ/quO+uIw7CTCq?=
 =?iso-8859-1?Q?2wR2EVYO29jIwScGT1pXIn3b2cmAwKziebdirE1qq8h6s1sVtszZpY8Krg?=
 =?iso-8859-1?Q?bAmhkOmZvlOkYVRmxdtbrrO3VZSo/QnYWZZCmHfM6hJP5P5OQIqtjzLBz7?=
 =?iso-8859-1?Q?p3t98h/LZ600ybyreTa6X20TnVPjT6uE5fR0/yIexYJ2qhFCO6qZs3xzJE?=
 =?iso-8859-1?Q?UN/UeouMF2ixjUOXdk5Q4FUXuve7dWMXkb/jgwygXg/BLWmLzSOPkfw5Or?=
 =?iso-8859-1?Q?/LQ3ALh21RxxwSREPdbA2gW2oGSxlVkhgJRahaxZmoj4wLwCN4WHQJGUCK?=
 =?iso-8859-1?Q?UiQPaDVj4dljCCwUm5h9U1vd2OOc0XSFbC2VpGXKKOEmU2C4UmSIXGvJ8R?=
 =?iso-8859-1?Q?SjVHEq8sFWUR8Hr+RTklhCWT4nvE5iwZZZRT2XnESSEBvzt3ixAiJmFaSw?=
 =?iso-8859-1?Q?QF5yupm47/qGOrxVbvAEUptj0uPpcI0oTU45O1SoBbCo4djjFrYisWeOEM?=
 =?iso-8859-1?Q?kFigqIHyyg4Mmzk6COqhCBQTmznSEP64FDstfn2V68apARcXWoij7BtpFV?=
 =?iso-8859-1?Q?+6GiOVbpsIRaoXTRdg6XaaYX2704HdAWXthSHWJTqExKI0YDaKzz8ZXYIw?=
 =?iso-8859-1?Q?GGPybFHZGllXiUuqeP6MXTTWUtuWWBYGNIkSqbQD2xlIIe8fLLAyXXxg5o?=
 =?iso-8859-1?Q?55oHV5zAZZk1ytMZzMAymrPhmDSfOIrN0HC4sOiz9ikZwn/kE6KimArkQr?=
 =?iso-8859-1?Q?q+sY9GPzEv2/nAeV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?36EvIFzosJtJ6KGaTDkCMMQEPIlVTzKDIGvpBYvRP+EEsyEGPzftlpkkRB?=
 =?iso-8859-1?Q?HNC6YTCLXz1tD+lyBGuFpg+9yXCFHFQhAksdl1KlKxg/IhwG5ZM8lhtKP3?=
 =?iso-8859-1?Q?CM9mMfkXlMV6jE9myfVzxmwPQQpmvkPWa5Hq8SfSGSNijOYtvdSxTl2hl4?=
 =?iso-8859-1?Q?St9kLN7zBc7meXTv2Kcx5lAZbUpNZTpTi3UbrmxoNMq5nc3hm8FLDVBm04?=
 =?iso-8859-1?Q?IDevAzEIUm4Gb8/SSdBY41hy9rEw1Rzur1iHMfX35/AAwz74pUXuNLDMUK?=
 =?iso-8859-1?Q?fGpjUx1B8Dmfitq3KhDy2HzoMlUMSBdgBfRI+gHyvS3brRXxwA8/POaa2U?=
 =?iso-8859-1?Q?3XCRVcYs9Qr/Yll2Cws+1I00adqO9fQCz2jSkV7VCXzVJV2/Qtk4vFbAts?=
 =?iso-8859-1?Q?wuhW99Hawn4KzlwUvBE0TDQEMyVYmjC9Q4D3RSYqBxfBKORONMbu8WFPno?=
 =?iso-8859-1?Q?RAzAU9a6J1xm1am6cGMjjF489MWgWFBUrum1Da8+kiwPZGT8VKzm5yxf+A?=
 =?iso-8859-1?Q?Zh3QM9JAIQhhFn1e/+0EiIUGRT/qDyO5jfU3KhK6HrDxjc9bIZI2o5wZlG?=
 =?iso-8859-1?Q?3n98uUyT3+55Zo1MTt2W+guXipNZGnIfjBsqe928NFNVupBzIlurSHhatp?=
 =?iso-8859-1?Q?8Y10Gk4R/i8At4X20GXC2Wtrzs6slHLUnDkDtC5cczZcHbZqdevvukcUpW?=
 =?iso-8859-1?Q?GSrLEGXfg2sfe/kctCDPQ1e2iq/yYe4U7uMO2FEYM9+Fjm+O93RL+Yrr4E?=
 =?iso-8859-1?Q?pCIAzyxEtPPgpOO9QKD9rULqOIPe9kj2cbd4Gz+/0GukbXKMPEw52rLGZv?=
 =?iso-8859-1?Q?GIzNPHsCJRsNuQzQIH4Kqo0AeMqkuvL26PkiUAAzm3761sUS6ENFnWWlB2?=
 =?iso-8859-1?Q?8bye6Wgb+PsRkyfTbbn9B4bW9VDAsobfXYD/7rpXRpkl9vlErbXn0qxFoA?=
 =?iso-8859-1?Q?CdZmT6Cd0FwL892SDEtV8SMdLezKdQFPC9i4v72DQRdJMte/UnbYOkCh6d?=
 =?iso-8859-1?Q?txAAjkBk0SH4AP4SEo/oy4fjpZWheio39L+zdFukC5PnOHxea3KX0dm672?=
 =?iso-8859-1?Q?3icn70lXVGCOuhjuq2U8Q5CN+U3wf1khHczhe3+g41i4sMyNoVdlVhK4DL?=
 =?iso-8859-1?Q?mOi1cR37HEWK2mHKH06qcgvqTP3Bqjzkdh4Nbp31y7pE+NnajX1hMyWlHS?=
 =?iso-8859-1?Q?QBrVntnj1zZue9ibJugy8k9w6a7Px8yS4u6IWDfIWChct8gZVDUOJd5Uzt?=
 =?iso-8859-1?Q?UoGTovBqsSLHK3jl5xsAFEosqiPRogs6Zd+daf9OtvkimydRUoGLEgiMHX?=
 =?iso-8859-1?Q?SYC3ElWKVl3wMoLf93zZzC8YtChSnNIT1f3VnXaztVhVbfbMr6bYo5t43n?=
 =?iso-8859-1?Q?OOnS/+mTcth38b2imlFsBYbYn1sx6fCkJ74TUuf4AB/BLk0wQ+5s+kJcqH?=
 =?iso-8859-1?Q?fISrf5eeE3RZkchKuAZvlYkcbUzZPb62YEkZi+rzY+mfmhX9RZkksWc1YA?=
 =?iso-8859-1?Q?61UtiOBCfCU5KJ2zNJgZpjoJOjzzx7PxqAUyURaJ8c7KwGEbeg6xcNyGc8?=
 =?iso-8859-1?Q?KDaCJ16i53do0KMI3WeWd0uJ9F6tJBJXQzzfoP8rxT3JtEPBDSXKFlXBx8?=
 =?iso-8859-1?Q?CGLmHDIoiaomHoJiVCEViwZwCROTiKCy4TomuETDfdJH2NGykAVgwN5okF?=
 =?iso-8859-1?Q?rNFrIrO3RUxz49XxrFU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4520c6-2d6d-4524-b3ac-08dd1ddd4b2a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:24:04.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfS3wZ+3ARmkb/CMkiXXXYP1sn8+eZjxE7UXfy1CkNIl3zvmLr1HTXJDnDCEhADLCLyYn63VZYnRyE5nwzr7lbGkwT0YBY/ydbpwxJo4d+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6389
X-OriginatorOrg: intel.com

Hello!

On 2024-12-09 at 11:18:37 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 12/9/24 3:09 AM, Maciej Wieczor-Retman wrote:
>> Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
>> nodes. Systems may support splitting into either two, three, four or six
>> nodes. When SNC mode is enabled the effective amount of L3 cache
>> available for allocation is divided by the number of nodes per L3.
>> 
>> It's possible to detect which SNC mode is active by comparing the number
>> of CPUs that share a cache with CPU0, with the number of CPUs on node0.
>> 
>> Detect SNC mode once and let other tests inherit that information.
>> 
>> Change top_srcdir in the Makefile so fallthrough macro can be used in
>> the switch statement.
>> 
>> To check if SNC detection is reliable one can check the
>> /sys/devices/system/cpu/offline file. If it's empty, it means all cores
>> are operational and the ratio should be calculated correctly. If it has
>> any contents, it means the detected SNC mode can't be trusted and should
>> be disabled.
>> 
>> Check if detection was not reliable due to offline cpus. If it was skip
>> running tests since the results couldn't be trusted.
>> 
>> Co-developed-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>
>...
>
>> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
>> index f408bd6bfc3d..6b03bab6fc20 100644
>> --- a/tools/testing/selftests/resctrl/Makefile
>> +++ b/tools/testing/selftests/resctrl/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> +top_srcdir = ../../../..
>
>top_srcdir is already defined in lib.mk, it should not be necessary to
>redefine it.
>
>>  
>> -CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
>> +CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -I$(top_srcdir)/tools/include
>
>It is not clear to me why my suggestion to set this after including lib.mk
>was ignored.

I'm sorry it looked like it, I read your suggestion and then I looked at
tools/testing/selftests/rseq/Makefile which does exactly what I did (I looked
for selftests that use the fallthrough attribute and it was the one with the
simplest Makefile).

>I am thinking about a change like below but looking at the other
>selftest Makefiles I do see very few actually modify CFLAGS after including
>lib.mk. Closest one I could find to this problem was
>tools/testing/selftests/vDSO/Makefile. Do you see an issue with modifying CFLAGS
>after including lib.mk?

It looks good, it compiles fine and neither I nor my neovim's LSP can find any
issues with it.

>
>diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
>index 6b03bab6fc20..984534cfbf1b 100644
>--- a/tools/testing/selftests/resctrl/Makefile
>+++ b/tools/testing/selftests/resctrl/Makefile
>@@ -1,7 +1,6 @@
> # SPDX-License-Identifier: GPL-2.0
>-top_srcdir = ../../../..
> 
>-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -I$(top_srcdir)/tools/include
>+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
> CFLAGS += $(KHDR_INCLUDES)
> 
> TEST_GEN_PROGS := resctrl_tests
>@@ -9,5 +8,6 @@ TEST_GEN_PROGS := resctrl_tests
> LOCAL_HDRS += $(wildcard *.h)
> 
> include ../lib.mk
>+CFLAGS += -I$(top_srcdir)/tools/include
> 
> $(OUTPUT)/resctrl_tests: $(wildcard *.c)
>
>>  CFLAGS += $(KHDR_INCLUDES)
>>  
>>  TEST_GEN_PROGS := resctrl_tests
>
>Rest of the patch looks good to me.

Thanks, I'll resend the corrected version today :)

>
>Reinette
>

-- 
Kind regards
Maciej Wieczór-Retman


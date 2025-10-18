Return-Path: <linux-kselftest+bounces-43484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD5EBECE05
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 13:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E70F04E3788
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 11:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB30A23AB98;
	Sat, 18 Oct 2025 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfAx8O8f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250F19006B;
	Sat, 18 Oct 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760785801; cv=fail; b=eyMrGjcmcdF2bZH7MZSf1rxC/biPAtnKpkmZJTtMJdM3rzhP5iP+I87vUYs1my5gE4mH/Qi4GPo3YF0rR5Vdrq2wI+Cz63exUjau3tUlWOXhMY810+CWnP/1689H8h0iMc5RIDjOdN9K1JhMqEdWUikj8r3vVNp21qFdheowoTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760785801; c=relaxed/simple;
	bh=6HJ9ArH7/oVbTopBmtZtfhylW6F2S/SyqbvRXxA+Wpw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k5kfJwXphtkQhtoa9be1nPTwFyn297qSQpeQIoNfFvSG3OgOE7KK/iXsp+5fYgsJVA9EoPg3qZRtBS829TrHMU2mtPMdDeRuu0zxuU+sGm2ifnmqZlV2xVeZNRw3bMu58sIco5n4Rmj1y4hNJjbnzCRNlbOnWWNBU9b4XVhujDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfAx8O8f; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760785800; x=1792321800;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6HJ9ArH7/oVbTopBmtZtfhylW6F2S/SyqbvRXxA+Wpw=;
  b=nfAx8O8fZjyobAAKTmL4M6IlhMCv4HUuC5PEpSc4AXqbyXVkS5X1Yvsl
   z7j09fgy/QXw/+wrMlZ2Z3MHBNjEejEI+8USqR9+wx2s1mevwEN3TQb1i
   wGY+BfG21iFsE9BcRyL8BjAx4sgId2tsiL8Chr1oVg5ffn+b2VKBowgsj
   KjPZ7apNYNddeEN7oy8rd4ZoNfaoJ/FPsAlPdo9uOpdfLfyIZOiWK+OSM
   WUEHGzSW8lcIrEy6kFDMuSTOcl7bKVa4Gmf5BSSTamvlOrLDIq51F2FDN
   qDDHkTEdyq4vFnu+chRQys3ettUvO28UlSDmXOCyqbZsK26dOO+9qwayw
   w==;
X-CSE-ConnectionGUID: zBfCpLJcTs2JtOtzg55Qow==
X-CSE-MsgGUID: f/VsN9MrR3SNr8jjr5RW6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63029337"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="63029337"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 04:09:59 -0700
X-CSE-ConnectionGUID: 2EmwgW1WSGG6xNeKB0ZJcQ==
X-CSE-MsgGUID: MCDddrHETPmxSTvEa5myZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="182950951"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 04:09:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 18 Oct 2025 04:09:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 18 Oct 2025 04:09:58 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 18 Oct 2025 04:09:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMiZxgeVcDGP58inc6YYDgWE+IWlxB5QN/YbsKQDb4dTMyVnJQTN7C7HN7oCNZe5yO/1QquaqFzX2gNYpA63dIwR7Z9XLqAWwMZ/h0gxMCnLQbFAyfCutDg8yRooMVXja7evcYP4sx+ywZhUPouwxdNYoKSCVIlIjuUoPVuSroLSzGyxum//gXvVu8lqBkjrKraYRxuH5Dx51UiLv4fHKSVWXfHodWhGWmMtpJumZ0XyoxeDkbPSpZxnYg9LU630XN+e5LTYfo/4yr7VahN84RhG1YAatD/i2hWj5aCOsyLR01pyU8tR6SWa1U+yvJQKi0BFrcHYxbs2Uw4VnZq2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETd2UuPTarWa+W03Yuba9ZrIAjSDeX0jMvhK0cY3Ggs=;
 b=XVdOkgTEaavsKADIepRKCUwJwhlMbJvFPGdIoOL02BH/c9eGrwxkMXzI+WbZupY+3M6Ja9Vbwu9Lkg4rboL3pdvzLnBvXPkOCehz927GDWO9fJ3ua4AZd73K6Y+HPjubuySUi4ZYHeOOQzdkJmvVsaeHfFer6R2Xtb2Eik725iOe6Ub6F1ldwxqQc6xF0xKjCoCxbOzsGereK7OLfZygBNuhpuPF9RpiQzod+yZOyWSSWJJB/eB+NSJXSRZRrinQOBoo4RrJPeFiLi9n3oIj1Qp5PXHBxFrYe7s/TkpAGBE18s0L6WaIp0ACXn3b69XwhEMwOtSW2u07ckooWuYfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Sat, 18 Oct
 2025 11:09:54 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 11:09:54 +0000
Date: Sat, 18 Oct 2025 13:09:43 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
	"KP Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, Network Development
	<netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 00/15] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
Message-ID: <aPN1dy1OVaNiB5IB@boxer>
References: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
 <CAADnVQLLBrawW6N4BcPvhYD2Cg_qaxSZDRU53Jq31QxR3mPDkw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLLBrawW6N4BcPvhYD2Cg_qaxSZDRU53Jq31QxR3mPDkw@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV2PR11MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd7ea8d-bf9f-46e9-34c4-08de0e36ddda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXUwQ0tPYVdjL1N4Y0Z5emtLU09VcE5CZU9iTEN1RXlIM09hSlpzemhreWVl?=
 =?utf-8?B?TzArMmVhNG9PMG4weHc5djNVUlhmK1JvQlhjWCtVZFdOaXBDYzREZEVyMWF0?=
 =?utf-8?B?aWoxV3ZJOFVTdStjYVB4MGxhZjd0TVNpUDk5RW0wY0JwN1ZhS1NoeUZWcnFL?=
 =?utf-8?B?WE54QTJOZFV5a1RhWEExL0ljMy9JbU9WS3RHOXdjQmgyOGYrL1lFQnQvamVj?=
 =?utf-8?B?NERRYmM5Yndudi9pZ2JYYjc2QS84c0NMT3pCVUEwV0F1TDhzSnFlMWJiOGNV?=
 =?utf-8?B?aHBNWmkyYStQd2FWbVJIenE5QUp4Y1d5OVJsZnEraUJnVHVWcGJUbzVjaU9F?=
 =?utf-8?B?d2w4WS82SU4zRGJ3eHk3aldERnVKQ3psRk1vZVJpU29FQklkRGg2K1hIYUtM?=
 =?utf-8?B?SmFmZXVDVWNqTUlRNlBrcXV6d3p1NU5iUnJLNitkQVpZQldseVpZZjRsZzhY?=
 =?utf-8?B?a3RpUGo1VG0ySWVNekZGVEJTeEI3b2VTMFVxM0xRT0JHYnd5eVY4UFVVZE51?=
 =?utf-8?B?WXA4Z25tWE5nV0RBZUxueUZmaFBPWFM3d2k3aW5KMnVJQWdJOWRCVGROd00x?=
 =?utf-8?B?S09RSUtxSVkvdG1uV3oxTDhWOTh1c0MvMnAzUDUxbG1aajNIa0JVVURCcEJX?=
 =?utf-8?B?L0dEMExlY24yRnVkcDJFeEJDR2p3SmZZSDgxWnhXR3ZVVmV5OTBkT1EzK25p?=
 =?utf-8?B?cHJDbWhhRWlsOWxsd2sxSjdBMDBuTlJLbFZTUTlrYzc2UjZJTTFPcStkVnFq?=
 =?utf-8?B?Q2RVUWNiOXQ2VG01R0NQRVVJKzNEZmJNbTdQQnRzaU9KTHl4R3dTK2ZpaGgr?=
 =?utf-8?B?MENBWUxXMnF1Qk5odDYrYjgza0lmQkREWTJhTWtIQzd0TWtmOC92QW1XenB6?=
 =?utf-8?B?Ynl1T01OTHptVE9OYU1sQXMveU1BYTBKQ2ZDVkpGckhJWkxkdHhDWi9uQXp5?=
 =?utf-8?B?VnVoaUhML2ZQaG1Ba08xT05iZjNlc1JMNDVVZWQ5NElaUndvcDBKdnVDOHBG?=
 =?utf-8?B?VDdlQndodS94Y3djTHdSUXQ2Z0JrS0VOQ0R2RzhDTzBvdVlCbi9rRnJpcmVC?=
 =?utf-8?B?SU9mL2hyc0pzRDdVRzJUTmdLMnFGZGo1VHNYbC82eE9jVlpuVFF1SFpWajVE?=
 =?utf-8?B?MTNmZ0YyTVBPTnVUUFBsdnB0NHVacUt0MHRoRkNhampjaVhiQVN1Q2dMek1T?=
 =?utf-8?B?UkVOOXNlZUsvZFJYUmI2d3RkeHFsdGdBWUI5Y2cwNXBBNUwrdkFyRlhhQS9F?=
 =?utf-8?B?ODlDbFcyYUlxU002N01vaHBCZ0M5Y2EvZ1F4T3BrQWlsZ2xHYXdYM1ZUNmlu?=
 =?utf-8?B?VUFTSVBKSzFMRnVCNnh5aStiUWhqNW5LeTVJUitWaGtVUk03OGd0emtucnNC?=
 =?utf-8?B?bnVqWldtWEQxNnBiQ2JPUjRsbUtTRXFKYkJha0dIUlBsOFJLZWRsUXJJMmJx?=
 =?utf-8?B?bUVZUGR2SmREaGV3dXM2U0NQdGpMZnJiaG1ldWxoQXBWNW1CeHc4dkJDeUtn?=
 =?utf-8?B?Y2tKclRRdXByR0VmNnBVVlNZVFMyOUFXcEFrOXNlWVU3Q093T0ZJcDZwcXY2?=
 =?utf-8?B?Z3h3QloxaXN6SEdzY0RYVW44OHBrSkhBZElhMGhzdlluUEtqdzBMcVJyZVFu?=
 =?utf-8?B?eUplbHFNK2ZrL3orL3dKRmJlNjNVbklWZXJWRkxKNzFhWUtaWHNFOE9PRmdr?=
 =?utf-8?B?dk5EOGQ0Y0EvdzNQYjVBTkxEMkRiaGx6Zi9KSFkxZGNORFNtYkg2cDhkcHEz?=
 =?utf-8?B?anFtZUtpMFlRWDAwaHZxTThrNEdMQiszSVNKOHNFaG1UQ0cxRENRYUk3NmJK?=
 =?utf-8?B?alBjUlUvM3pISWtERmhINGZoLy9UaW5UWStYREhaWTdZNS85bnM2SGIvTTlQ?=
 =?utf-8?B?TXFaZy9KMFlBZVQ5aFY4Vm9GUWJWQmVDazNldGJsc0xnb2tsZ1hBSVJ6d0lD?=
 =?utf-8?Q?utZBmkRleCJz+/+/Tav+3sBelWf2rspp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjhWMHhieFp3YjlJYm56aDZQTkFzem52Q0FXYkJseHIxUWRoUXRrVUNsQWhU?=
 =?utf-8?B?WmZBczJSNVUzNTAweWsyQXo4dTRhTXYxWUJFVVJjNXpJeS9GbXpRS0k2Wmpr?=
 =?utf-8?B?SmRKRW02SWxtakc3N01QT0RtaG1SdHBjQVZRUmZsd3dpRSt1VDB1RVErOFNG?=
 =?utf-8?B?ZGtzQkI2MjA2amJVSWpXVXJXV0tkN1pBdlhWT1lNS3VTSXhwc2ZmOVVLYmJK?=
 =?utf-8?B?cFF6R2l2M0dMd2JnbHFqYkRRMHdESkI2TDZYOHJITlh2SHdqc2N3VFV3UFp4?=
 =?utf-8?B?czlPRDNwV3UwNUJ2RnBlamNYNmF2aGxmbTJXcGhueTZLT0JPTlhsN1BSN1FW?=
 =?utf-8?B?dlc5TUZJcGU3SnVUMTg4TlNTSHNhdzFWL2Q2T0FkWGlKcUgzVEVjQXYxWUo1?=
 =?utf-8?B?RjlobzVweC9uSDVWRk4wbXhDUmxjZS9DY2hGaGNLdERaSmdkYlphdTR5NFJJ?=
 =?utf-8?B?dXkrdW1uRXhpb1RMSFBmWDlvQ2NlZ0VtRFlmdVlTc3ZObE44MUhtamNHZWhC?=
 =?utf-8?B?R0xETVpQbFlwZWo5NTQyTXUvekpVeW9FV003UVV6cWdyZ2NvdmV3NFFNbU1N?=
 =?utf-8?B?bVZLTmZ2Mi9lMmg2YWIvNWI3Sm9vZGhQSCtFRGMzMDF5cVgzK010TGpNQ0dW?=
 =?utf-8?B?RDFqcEVRdE1PL2UwblFkTkp1eCtBcldvTS9IYjh2TWJ1bzlDZzNKMkxadnhN?=
 =?utf-8?B?UUFWNTNnc1lmSTlNRjJqR3pVTUtVbFVtUU1DazRWRms2ekxucCtyZnFOVWRa?=
 =?utf-8?B?dE9ldFdGcDM1WkRMY0w2SmNNZ2c3eXdaOXZrek9nSWdEUUtUOGJzbDBpM3d3?=
 =?utf-8?B?UTYrQ1hNK1V0WEQwbU5tTlA5WjQwM0I4VDNYZlllT3JOdmMyd1J5d1p5ZzN0?=
 =?utf-8?B?d3pGUWUvellEV1pqSnpkNmdrUkVGT0JJTDVSNElOSEJsU05BT3N6RVRmdkF2?=
 =?utf-8?B?UVIraW5GVllTbjluOElad0FPUGRSaUNUYi9UTG82bTVvbGpIN1h3UCtLcEo2?=
 =?utf-8?B?SUI2VmZ2Z1p1WXByRUJpV0Q4RmZSNXJvTE9kQmcxWFFtamFPc25kWmdzdmlN?=
 =?utf-8?B?MFJwWDRmZ3ZJSEM1aTBDcG5pUHV5Mml3bG1UYThqUG55Z053UDdDaHcwbEpW?=
 =?utf-8?B?bWZzdk1vTzZYcXhZTDZXa1lOalNzV1B1VmJ5MWtwY0ZLd1gxMFJiSFlXU01v?=
 =?utf-8?B?Ky9QWkJJdUk2RWtKQ1RaMkpZOWdlUkNXa0swZm5IY2lxWHJmMGk2TFQrR3lx?=
 =?utf-8?B?aWg4TWg3dEwwM0piSmo2aGdHSHVmZWgwN2VHaitrK2QxOW1RcklHU2dzdTVY?=
 =?utf-8?B?Yk5DMVo0eTNHWFdZL1pGd01QdnhOTHl3K3NDdUEvc0E0dm1hb1ZHQmhxSTh4?=
 =?utf-8?B?a1Y1UWdnZUp2UGQ2RTVtY0R4MWpmNjBVaytEcUI5NDVNbEhMU0ZtZkRLbzkw?=
 =?utf-8?B?UVQ3Q09zWkhZU3FGMEtQTTRhSWkyZlpoTCtPOUYzUWN1SU9Xekt4bjdMN1JR?=
 =?utf-8?B?M21hbkJUcWNGaGU4NHYvdlZORXlUeHUzTS9iWkp1SjNBMGgxaEFWVmcybkJj?=
 =?utf-8?B?RnZ0SHpjbDVZeGp2eStnZm5pcHY4eFhva0I2aWowV0ZXNytQOGszbVZkRVgw?=
 =?utf-8?B?MWVPdlZIMWhEU1d2d0NvWXFySmxSMHhnTkJxQ01QRVZLN2dicDNaNFZ0dkIz?=
 =?utf-8?B?NlVScm1DU09lMXZ1RGdPY2hjU1REQWUxeVJqM1pLV0FQaEVHbzU2ek9UUVRV?=
 =?utf-8?B?WlJ4dkFDR2xiazdHelJYSTU2S2Rsa2RxckRjMVhESDIzWjVQRU1ORlNSL0Fh?=
 =?utf-8?B?bU1PMTZNWDNRUTh2N0lkM3BHK1REZElpRm5MSGlWRWhKMkJ4dStIMmpXRHZV?=
 =?utf-8?B?dEhHV0tydmd0SUd3bzFqSFNiTkhIQU9sOEdKZlllNXczNTZ4UWpuWlVjOSsr?=
 =?utf-8?B?K3V6VnFBTTlmUkRrVko1UHQyZW1zR01ESlc0WkQ3NWNJdXlJZ1Q4WlRZQ1J0?=
 =?utf-8?B?cjJ5VVdXd3VNVUxpVjFQVGE1UnlUR0NjUUhDN3RrMExaSC9Wb0swUk1FaG1R?=
 =?utf-8?B?LzFIM3FFZmM5MldlaEN2aGRWR3pQdzNYcDc5QWZzOUY4UXR0VEJLNEJxTVow?=
 =?utf-8?B?SzFkbzZJVHlHVmV3aWt6Z3dhelBqajMyYjNXZ0JzM201UW42TERSRlFPNS82?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd7ea8d-bf9f-46e9-34c4-08de0e36ddda
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 11:09:54.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PcxMYUpaYUL/9VwGRe1BZSdZWb6tE/InFdnfexOZWE4cqYxlajAZrU/cDYXTzlem/BW6KELRj9QdF4K20+WYwRoTlAysRoVuvJHhfWAFuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-OriginatorOrg: intel.com

On Fri, Oct 17, 2025 at 11:27:26AM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 16, 2025 at 12:45 AM Bastien Curutchet (eBPF Foundation)
> <bastien.curutchet@bootlin.com> wrote:
> >
> > Hi all,
> >
> > Now that the merge window is over, here's a respin of the previous
> > iteration rebased on the latest bpf-next_base. The bug triggering the
> > XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF failure when CONFIG_DEBUG_VM is
> > enabled hasn't been fixed yet so I've moved the test to the flaky
> > table.
> >
> > The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
> > are defined in xksxceiver.c. Since this script is used to test real
> > hardware, the goal here is to leave it as it is, and only integrate the
> > tests that run on veth peers into the test_progs framework.
> >
> > Some tests are flaky so they can't be integrated in the CI as they are.
> > I think that fixing their flakyness would require a significant amount of
> > work. So, as first step, I've excluded them from the list of tests
> > migrated to the CI (cf PATCH 14). If these tests get fixed at some
> > point, integrating them into the CI will be straightforward.
> >
> > PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
> > tests available to test_progs.
> > PATCH 2 to 7 fix small issues in the current test
> > PATCH 8 to 13 handle all errors to release resources instead of calling
> > exit() when any error occurs.
> > PATCH 14 isolates some flaky tests
> > PATCH 15 integrate the non-flaky tests to the test_progs framework
> 
> Looks good, but why does it take so long to run?
> 
> time ./test_progs -t xsk
> Summary: 2/66 PASSED, 0 SKIPPED, 0 FAILED
> 
> real    0m29.031s
> user    0m4.414s
> sys     0m20.893s
> 
> That's a big addition to overall test_progs time.
> Could you reduce it to a couple seconds?

it's because veth pair is setup per each test case from what i recall when
i was pointing this out during review. it does not scale. it would be
better to have veth created once for whole test suite. HTH.



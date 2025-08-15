Return-Path: <linux-kselftest+bounces-39029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDDCB27591
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 04:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80E4A2301C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6721C1F22;
	Fri, 15 Aug 2025 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSyL2mhi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2375317A305;
	Fri, 15 Aug 2025 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224460; cv=fail; b=TKKijlgrS3o4f4uZGPi++D9Okg7HS7z1YXfgqHYyIa4c4GcYjy/Uv2MYqcEMFmdfoySBxN03GNMaMg4rF6mxpJOB/OX64MIwYqnrGn77Syp7cswBIvMcTlXuHmPrQ77EVsFRBqtEJ/1LNEIIbCvOSoH1cVsIgWgFUJvivgMY7Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224460; c=relaxed/simple;
	bh=4ViAhE1sKSLz/BunIEVLQn9lZOmv3ix3fhfyOYJ+Xzc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ne9v2LgFGUR5gdwWyKUFBqT9TfoswzOWyPb14VIbzZQgDugcGYzz33c7qEqLlL9SRAYZdEFuYHg49NvPYjrS+R1vjMhB9RSMWSrBnTGci5G+C+EEBQQJf1dVDAMs7rybux01poZMFxQo2C6t39RhbjEDHHtC2qW83Y/RzAfynhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSyL2mhi; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755224459; x=1786760459;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4ViAhE1sKSLz/BunIEVLQn9lZOmv3ix3fhfyOYJ+Xzc=;
  b=hSyL2mhiyGW6e5cKNbaT1IiMBiE3NOvT8dbnKMCP9N+YApRjk1boX7Jp
   /a11HHGsQXip9W36PNyC1zYIGHw3k2QFYVYLxRDkMqw/H4OoqAXM2vMPC
   4gu/wgjUH9UpCTCq10frCq7zmDxWjbg6DvuTkBt+MI5DXIYUGQRkqgohX
   EDkfPpSIXbCaGxOO7sUKhVVRacMUhMNiw6iZDpzA4RrphZ81dMcft3qrD
   UBuT79XFR4Bq6aS/MI5SUhnr92GOq+nQzx3dlt5zV67AFRNqBGsXILo5l
   jHs+ax/pWGNQJdK6xEBUu4/ukqoeqKOHo0/gcP0pg+IKxJPm83aRTqb3S
   Q==;
X-CSE-ConnectionGUID: PjP5mTh+RcuCxO04l0F49Q==
X-CSE-MsgGUID: sOARoZHLTjyE2XgdOoIriA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="82986950"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="82986950"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 19:20:48 -0700
X-CSE-ConnectionGUID: +2G1bXlhSs2PKbJ461dziA==
X-CSE-MsgGUID: 2dLBn9IZSbWF7s61YONkwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166125108"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 19:20:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 19:20:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 19:20:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.81)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 19:20:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYE7H3puGWxsXsBHClh+LNXvUprsaQM1MZqviNAEyWZX9EwCbaPvEfxM+eFZNaZeDFWhEotwD4VVhLsak4l06iq0HgqHu/wGETCKC7GFTX2v0XqlJnMYBAevGYRT0xqiDOHxrRbTp9BWjLwAtLOaxUt7G4Xa2S9n3ftc4igHFXtOPssARCN/zaDmeNUwceTs5K6MvI3troXn20v3UeGJplMaAAt4cAgbR02gRelVuKBj5A1ijriCieOzlVQVZE4Lhom8v4OTnMRr8GddvE/mFsf4rhLBXSVC42ArrgD0RYdUlsuuR95Nt6H0HIwDyeM58dL5xaN0qnm/jir8uyHPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQs9TKs/VVt/KH0v0f7bbUEj0KN8//XSxYjmpOxKPc0=;
 b=QT1HAKoOL+9VwK3geRLoE76qWrttfWqOUx8kV8MtRpfYTqSUV9bPHT8LEuasB2TbN3duRAinU8cdY0tLMkPs8lJFSZC+YikeH/+Ta+Jfe89SaM/Iz/qI1RkLkd1O2ViAOQd32G5Fc7npk/nY7x7r3FUneE238y/5I7XGzZe9YC1iW6QKFmFpkW25UN7Tpgq0O70h2PVeeCvfyqYg5eHyUsYSTgeGH8NQY5fczOUj4sIpUCD7yQCCQo+4rE4tJ1RicKd4H8j0D9c9o9vWus20miegLzV+D/kaMhQCtTRTDjODcIp3s0vGESWBqxNF1TsLGXY7tbFpDoJIci7n/s7FLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SJ2PR11MB7473.namprd11.prod.outlook.com (2603:10b6:a03:4d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 02:20:44 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 02:20:44 +0000
Date: Fri, 15 Aug 2025 10:20:31 +0800
From: Chao Gao <chao.gao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Ackerley Tng
	<ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, Andrew Jones
	<ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Erdem
 Aktas" <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH v8 06/30] KVM: selftests: Add helper functions to create
 TDX VMs
Message-ID: <aJ6Zb+k+UkiTyB8/@intel.com>
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-7-sagis@google.com>
 <aJpO_zN3buvaQoAW@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJpO_zN3buvaQoAW@google.com>
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SJ2PR11MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: a4bd0ca4-7567-4e0e-af13-08dddba2568f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CSX4DgAIOnNOEh0k1PVDWM0g6Dkcc8/GH9LHtuPKwfUFlb67az8QQOP+SYyY?=
 =?us-ascii?Q?OOm6qTHUchK43BFcZqUaLhaaLaJodb5L+TwqXQiScb8/lkatrVJZzQbBCdF6?=
 =?us-ascii?Q?gLWJpGE7lt6tXAWQ57BRV76n/sS9m8ouNTfAk09B0zxscr+XNDAZn5uc1nx5?=
 =?us-ascii?Q?iSW05oWaf3EpZEB+V62M3IOvv9XcPO7nc/ajhYsCjGAk9YuTlY5/xUeWnowx?=
 =?us-ascii?Q?1okuMsuyqj8A+HnYA7rAxRTIdcRnY6klJTHVXZcbK0mlhWEdC74wcPsOnZxD?=
 =?us-ascii?Q?Ce/Dbsdn/Zl1pxueLlZ2BwwwkWUkpFHqsyWPug8LebISB657452TDWOYmvM1?=
 =?us-ascii?Q?st7IXVXbhbwV7Mo8uovBcz9X4NrIA15OLPH7hVpAPdIXL7vh9W0ixFPvYyMF?=
 =?us-ascii?Q?DDKp3jX2LbSleAFjkm2SF+Cent+VxjDnN5s1hhjIj8bU5DJ57rLL+9DMZq5H?=
 =?us-ascii?Q?xjzWa9HY+ePc+exqg2ge753CAILnsspG9/0f2QGkz/syLg21nZ5z11WpKKyt?=
 =?us-ascii?Q?+S3kihAmTBCWdzUTYqLeGX469GahJmD1BSg7ll5uX1n8sl4gxwFt2ca/0zVH?=
 =?us-ascii?Q?jJSwoQQGyaOjFB4Qa38UwlTCB9YdmDUeG9Ba9yATgl5btn5FHt5cXsFZFjW7?=
 =?us-ascii?Q?8zY/bMhcic0SG0dzgdXCb53CPOp0c9hriTBI9Uv2lcF4T9Sg+P9VimyAn/PQ?=
 =?us-ascii?Q?qX4qw1MMsjk6+Z4M2Q7LaizoIbQUbWs9x5KxRWTtC6Wk3kWUQz/GN0KDtwIA?=
 =?us-ascii?Q?hc/n99k7C2u6Q+a3l5Hq01MyEaZD8Lz8aLT5UTOLdcaNSkjt6cBlJWu5+seK?=
 =?us-ascii?Q?9R5ye2OMkgY7tFC0r4UQU5HYMCxmJekI7e0C2nfVugXYZtox9s4XZ8mz1+6V?=
 =?us-ascii?Q?7DEeAMFmusvqlI9tCLqdr1Uoqxhh9Uuf1u/Q4vsVaeWBo/ocklZH8ADbJm1w?=
 =?us-ascii?Q?w4wEPHfXWWFNPh6LA7V6Fr+7IKFfe/9P+izsFXoMmkQXiJsr9TASIPPDgMDy?=
 =?us-ascii?Q?/z/xrBO+IaVzrQcmb9sjPrVMiHTCHmyeCUfQBLN5VT3VLKWVsgz1eT7CT3iM?=
 =?us-ascii?Q?Lq+zSx3bbn6PZsz51GdXJqinw37JQONNHHdXabZM3tqt+ngl6eR/fpfwXGyF?=
 =?us-ascii?Q?Jv14Yc85JfZnhgOdYNFRdz+1pqV8JLjoqwTvrtinDJr+bP2A+ZQHLrBxOTaR?=
 =?us-ascii?Q?oxZlPUTd7mkGbLfAHoXlHwWOxEbgipUeeL+KTNEu/1L9GWnQMS9SfjXhdzRn?=
 =?us-ascii?Q?UphWk1ohjduu1+9ZEHNAfH9f/UIvCi8DI+iX9SrxJlr4J63jeEGKXy+Zz/LB?=
 =?us-ascii?Q?pOPJM/7emex9H3ytpE/qrQ5zb/fA5IXboe7U1UbdWM1XnLFPPTHS53d/PXw2?=
 =?us-ascii?Q?35xeMpA89JoLCzDnsD2GBJCq4UyYczPPyN1IZYlc0a2Q5DHNaecV2uSUImPT?=
 =?us-ascii?Q?Ul2kqIg87tw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OzCPaOo5nSaL91fm9ZKZTGFAgPNp68H7/i86al5B1LIj6rvzjE8yijZq6X8N?=
 =?us-ascii?Q?N2BJBimN3jISOXzVNv+y3nmokVoCdQUdEoKdxGzji/6qAesfg2HUL7Xp/LUs?=
 =?us-ascii?Q?QLxBUpcg2y9XEu//9OqXN75x45u7kw5ZMW+trudc6kgvaxlbRYDa5TQRFxKm?=
 =?us-ascii?Q?Y4G8DhCUAi7xJtynpiNY9FUYMmO8OY9/O5vLImTLJgvOMdC7Lf6b3sMpcIWi?=
 =?us-ascii?Q?WFIIMD1XZP+czl0uhcNu4chfK4kEawXL1ICTpnR5TYPpWpkq7XfJ0Zlk0Mi2?=
 =?us-ascii?Q?++4K84g+6TG9Ro2SAMw5xB3c4jt7e/saWxoB7XubYEQa6o1fWLAwDL8MFAUW?=
 =?us-ascii?Q?VTzNaeX+DrpQDcbI9xaLy8HHjol7YcVyhwdJ+w74+d+926nKMq8vFveJCLVd?=
 =?us-ascii?Q?bGTzPT5SFTO9Dsru6Z+/zeO7onR2lxEy+e37yLkifFVuiBHo9Zusrp8PYU1A?=
 =?us-ascii?Q?wwP3sfC20YW4hGgyM2TXL1nEXwIB5FNaWSWm0ii+LHHxavHPvEfUUuMFiD/f?=
 =?us-ascii?Q?/yRvYvQy1kQJCHkZ9FBq+hEktUcL8yyf0XMuDZLPu94Wmr4GNiDk79cKrVoZ?=
 =?us-ascii?Q?wXe8yZjbLV1sQ6rFttCkYTXLwtvdqWwizMt1k+ubTIvhEGqogox5ylIa+Hj/?=
 =?us-ascii?Q?7Na6VRLDTjIoIMGEcde3y/6546EF4mxIlkeARvKfCpYjEOH3Gy2gLF64aPqS?=
 =?us-ascii?Q?Gom982TvviCdbylqYtoK12mlxPzah2W94PqeWKlpvAgrm5gGvIikN74UEtkM?=
 =?us-ascii?Q?jt9TAoi3iKf3TX5tf+06FSUmdKrM/bOG4Mo9bzykHtqL7ThGe5UsX8h8FkVo?=
 =?us-ascii?Q?UVLL8sgjgrZ9o4ddmQ69piGcJFM3Kl/wKEbCtiJUdwkWv+1UmDTSrw46+/rc?=
 =?us-ascii?Q?UIwO1E0jHeh32pA2IFl7+fY2SOzZwSVaMtng7jk6/Qyo7NIR0m1U2ajTFmwK?=
 =?us-ascii?Q?gdgQiZT5DFpUT+M8PBTG/xsEIGa1+oAiXxb9zpb/c5FP06Xa8IljcuOFDg5z?=
 =?us-ascii?Q?d6PNTjn4n4eVqsSh7wI9C/4PC+MxbVN0uvL8/NxMqy/4jMlsO7DulAs1Sbmy?=
 =?us-ascii?Q?9QXKH4HSPT+CRUPOfiQ5ugXqjT5omQvWwWdcSwKxWm/t4FZIrfoqsXKbLUOJ?=
 =?us-ascii?Q?JJa/3kAgA2ycNGDVsELoMrDxsvDhtvfXDkksH81QG/EomJQguWIbFHUF39cB?=
 =?us-ascii?Q?5WjweRe5830UlWp4k1sjkyTYxWtNYCzYbGZbdWjzrti6lOPBRCivUZ6bI7V/?=
 =?us-ascii?Q?nFHuv7bxDqJb5gDal2/6s5pFZ7XZKcviZYkjeW9x0j2p5jw07SPvUkqvmgvK?=
 =?us-ascii?Q?vtJ2qgkUMxYRYpaYCErHx3d6v2K+InrRWtyG2rHoeiqjqml8iMs0daok628T?=
 =?us-ascii?Q?IiFP7EMJxushqB/szpNlUYQGl5DPHaWQ8oQrUyjtHLz/DtTfzk6ti4oj1CYO?=
 =?us-ascii?Q?z+0v/SBNDI1pduTO1+QQroLksk7wSuEzGtg3X0JI2gPMrM9jTvBywniLPzLN?=
 =?us-ascii?Q?BqrexaC59z7PPF6co6MbK3lo+e4xeovHZzZmSDgm+iLjdgQepWkATF4F2epD?=
 =?us-ascii?Q?qS+gmnDB0lS0yHEBuXNy7nw/E3riqHawvNINVa5E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bd0ca4-7567-4e0e-af13-08dddba2568f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:20:44.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThucZ96dij0rGeI3N3ilHvzB/YJjbXaEDW4WGOmLXTZxjZfI4vn9ZSAUvJg0uerh9unVZUQbATaq6FlAXXlGUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7473
X-OriginatorOrg: intel.com

>> +static struct kvm_cpuid_entry2 *tdx_find_cpuid_config(struct kvm_tdx_capabilities *cap,
>> +						      uint32_t leaf, uint32_t sub_leaf)
>> +{
>> +	struct kvm_cpuid_entry2 *config;
>> +	uint32_t i;
>> +
>> +	for (i = 0; i < cap->cpuid.nent; i++) {
>> +		config = &cap->cpuid.entries[i];
>> +
>> +		if (config->function == leaf && config->index == sub_leaf)
>> +			return config;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +#define XFEATURE_MASK_CET (XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL)
>
>One guess on what my feedback would be.

Move this to tools/testing/selftests/kvm/include/x86/processor.h?

or this is dead code as CET virtualization has not been merged. But I think
in general adding a test case for a feature before KVM's support is merged
should be acceptable. e.g., KVM-unit-tests has CET tests for a long time.

That said, I agree with Rick that the entire tdx_apply_cpuid_restrictions() is
unnecessary, as the supported CPUIDs reported by KVM should be sane.

>
>> +static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data)
>> +{
>> +	for (int i = 0; i < cpuid_data->nent; i++) {
>> +		struct kvm_cpuid_entry2 *e = &cpuid_data->entries[i];
>> +
>> +		if (e->function == 0xd && e->index == 0) {
>> +			/*
>> +			 * TDX module requires both XTILE_{CFG, DATA} to be set.
>> +			 * Both bits are required for AMX to be functional.
>> +			 */
>> +			if ((e->eax & XFEATURE_MASK_XTILE) !=
>> +			    XFEATURE_MASK_XTILE) {
>> +				e->eax &= ~XFEATURE_MASK_XTILE;
>> +			}
>> +		}
>> +		if (e->function == 0xd && e->index == 1) {
>> +			/*
>> +			 * TDX doesn't support LBR yet.
>> +			 * Disable bits from the XCR0 register.
>> +			 */
>> +			e->ecx &= ~XFEATURE_MASK_LBR;
>> +			/*
>> +			 * TDX modules requires both CET_{U, S} to be set even
>> +			 * if only one is supported.
>> +			 */
>> +			if (e->ecx & XFEATURE_MASK_CET)
>> +				e->ecx |= XFEATURE_MASK_CET;
>> +		}
>> +	}
>> +}


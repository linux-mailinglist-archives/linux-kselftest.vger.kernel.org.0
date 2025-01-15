Return-Path: <linux-kselftest+bounces-24554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058F6A11CE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 10:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D39168D6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939471DB146;
	Wed, 15 Jan 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHszAfXS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85440246A05;
	Wed, 15 Jan 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932007; cv=fail; b=NaxmUIc3Mhh/aXvnBBUcBglRmMK9neJHleQu/RF2xUb6tToLvYcITCdmRmZw5oj17dZ6QGtcfZfn6wF+ymuNus1t3M7QtwL/+VpFxYS83W1MxfUJqUuGIucLydu3pBqnNT1tizBTUudo6c9pgwZYvX4hDQrnUR1Su4jE0II4CKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932007; c=relaxed/simple;
	bh=FSaSiFZQwuMvhCiMK7Y0E7DHd4IFNnKjLOaA+gS/Jl4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JfvqCKKZKG3kzTl6aSYWEAY8ivK0Q8p7mYDa3hopkLGYIDUUQM3ymCqUi47qhokPXlA3MrjGhISj1ZNxSP4grP5sCgJALHpwd796TSp9SXD9sgtUoLvCIbwoQQG1f9l+UsPs3Gi+2lTD1mUFutkgV8p2Fpkpxp7HrESKYEKfdfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHszAfXS; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736932006; x=1768468006;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FSaSiFZQwuMvhCiMK7Y0E7DHd4IFNnKjLOaA+gS/Jl4=;
  b=hHszAfXSMTfqlZx7sI3oOYGvPIGrcLRwDoYIIphLciztXgkolmF6hDvZ
   f+KO76X0KzEw+vuANp3WwCYsdfH5gAM7m3bDj2oLVzeJMMmN3GCAUHb69
   /d4webtab9oUjf5ZU/EIx1brqcvrXR6K/5BuAltGkEH1hlQFICIFX1syb
   uaaVwWWAPi9b30kxosatqnv2MkaRkDyukhcbT/WOAKWKka7+J2HHX8Yy9
   yp7DHQaRftijPRITYx0SJA8tYBwLafh76Rld0giVR8yR0vbGcEzuIShpW
   LUGkcRq/KF3yscuUI5zdNoHSMEbe9izDmTIfcK6dqkZsjbcJFlOqy0gdY
   A==;
X-CSE-ConnectionGUID: cjCQ9tBeRlWzUoO4t4axDA==
X-CSE-MsgGUID: hFZCkdPjQVS1mHNrQpOYAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="54674724"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="54674724"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:06:44 -0800
X-CSE-ConnectionGUID: VJaMQJdLT+mCV29D2uxJ5A==
X-CSE-MsgGUID: OL/ewloDStmjHkrwxuWOPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110059148"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 01:06:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 01:06:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 01:06:43 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 01:06:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIDO3HtM4qUuwOWAyK0sG+DzL8W1RhpemzWiIXDSjOYndrnfMpM0OIscF8MJr6crFS22IywsEQkqu5VNLIyaB/WWI8f5fI+vjImsAizxvUWiq6c+a/Bo159Ci22mhhg16YsGdgbZTScy94UJMIh9d5RHg7OD3pg4Ir0g7j4SEv3Ms7dw0r6L38seStm1fpMmt/xqdX1U4F89iDGgUxBgbmjuipWCh5SY0XGOGvzfxll6NoF0E0YCzBfyrZ20JDRfPmOUZQlQj/UOTgyK5lEPyZpLkDrpe9dXtgpbhbyNDAV9dMC96exFKQeSecx7TtV2m5EtHGkwtOsyttmMnrAfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg/NwnDdrSM3cpKh7RFZyInyVvhF3Ne6/tf1qr8i350=;
 b=RUeA3IqM3Rbjwaj1K65dIdz6UP2SvbIxWSoFtCF3rHEQFhwT+BF+sWIt7Cj+zgt/t+2jMM6sNeOdY6S1AJYp3ZWSPI4nIoGgspiCLgjfSavhu+zLZLty6R2sWY6QVb4QQcemDS9wF/C55hMHkNxjNTcTuIuVMmHf9DDBhJksu7kvEi86YHxTbNdTMm4uH4Gt+DevZAVnv2I9/xkk/IwUjVf+w8sbrebpm8KRn5q81VWeXTbLtq65aTBTS+HPXTnNX4ylqImf6n0BQyvTXiVAzeqlQH3Q6EDFfPEnV/eT5iQUU+tOrxLLznqg77CVgEax5Fts3oMbVnL8gztjMZhxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 09:06:41 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 09:06:41 +0000
Date: Wed, 15 Jan 2025 10:06:36 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<kirill@shutemov.name>, <hpa@zytor.com>, <x86@kernel.org>,
	<dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
	<tglx@linutronix.de>
Subject: Re: [PATCH v5 0/3] selftests/lam: get_user additions and LAM enabled
 check
Message-ID: <7qymrv7tfyt65dtqf6jhy7afkvtqftmpsa4y2hn5u65tusn7h2@3qw5dythjswm>
References: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
X-ClientProxiedBy: DUZPR01CA0148.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::15) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SA3PR11MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 561d7625-8034-42d2-9714-08dd3543ed33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Ril83E+9/F8GXIimWRjW4KAT1on6J2/9M2iOix5Zu+RpUOMBGCi4vDhCLJ?=
 =?iso-8859-1?Q?CZpApl6joxr4If8ozbBFSFPXYnmu7uRn7au8iXQLVz+I+x2Aa+f5FIVREi?=
 =?iso-8859-1?Q?NK2NNn0bEuVFJRYTcTDPrP0U0DXH9KhpcE+D2yFcK50nz6ksn9Y8x9r/yC?=
 =?iso-8859-1?Q?ZpTI2u+H2p0BUEdeZaZO8kUuHIDnxYtlcAH4UaOl39MB8CgYFdINTVr4Tn?=
 =?iso-8859-1?Q?JZQsR8yNpnaBphB5OJcI2IRoExM1z8LsXvTabjTGZBNosikiWxnl0ykh57?=
 =?iso-8859-1?Q?RI2XOgoNaifx+KKA0RIUrvCSXpf+vgRqibpUuPe8F+I1O3RSKnOJXKYTLi?=
 =?iso-8859-1?Q?lEIxEF1BvKuyFcO1Kv+fC7fdDG9vgXNVtILtDXI1fh8lEXTIozP9LvTlDu?=
 =?iso-8859-1?Q?f+SVtEngafzDzQRcDwxN+kNZ970DVpF9JhNcCLCQ5qdlF6lu2Ub17eqrbc?=
 =?iso-8859-1?Q?DSmjl29GSWkE9I7jWTHEhaLWhDCkXPYgGakUr1YSyFyK+3wKuoeDFfxNP2?=
 =?iso-8859-1?Q?t+NOJGioGxjfjHse4+r6auaUR4CKf53LMWYwRS2rMyWnTq9Zs/sjH3nUbc?=
 =?iso-8859-1?Q?CkZtMcP+RXLtmshZZsh7IWjLYsNuAt5MFdSVt4EV5nO/hvb11hiA8RB2tR?=
 =?iso-8859-1?Q?69JQFPLHXNE4Gm5hxzXMbRBTh1t4rHIyXoBQyWOdKkZvhAYSAK5OxPnX8B?=
 =?iso-8859-1?Q?K5K+h4F5v2Rx0Af1MQraLEMlZC+jMcK9pepFPrsYFFo5CE1Z/znjoHaWNB?=
 =?iso-8859-1?Q?TTaJZzqYYbTGjmVcaDkS2bM4Mv3yDcARmgFua/VJ9yLBpfDLYikO5rhhu7?=
 =?iso-8859-1?Q?0DBEtWFvkft79NI1UIMqMc802mXwtL7gvmZCeLehVObHqxGaSp7DPnnelU?=
 =?iso-8859-1?Q?lVUAoRrFzodqVKiX7/ewjmhcN8auuSKKJ9K9nPPNWJHyyZ9PMzzRwlqOW7?=
 =?iso-8859-1?Q?wYhN2T3M4cipfxXtEcyeHNSpq4tGNkhnX4tbE/HmUuIKq3J12qd/F5qQc4?=
 =?iso-8859-1?Q?LeY2tpDVYtCfhl2XMEloN2DngFAjJPINUDYm+SAUBDkbSPDRZ69HAQG99E?=
 =?iso-8859-1?Q?ZXBdGTCobOFnrQKiAu/HwToUcMz4LFAlBCra7GpoQFnPoYmnFKdptFXNPP?=
 =?iso-8859-1?Q?CzZCVYcD6FuyOUlSPpbLwYghYzhUgNJ+nedBN0rdbBu/pGxTLmhzJQ+gTY?=
 =?iso-8859-1?Q?Diu7VhzZlbXLDyuj44ViyFC7NXq3GBqxcvH7iPYt4rQtXu8MgAx5NRy1wE?=
 =?iso-8859-1?Q?E5vcg6mXWM2+oL4WWpN37/zUX075Qdz1U22G6cWdPiOftbcOm55erMvSGs?=
 =?iso-8859-1?Q?kfckjQ8UIxIE/l8/x/hKMvZskP1/RPpwxzqcsYF+8dNrrCtd3oJl+8Ry+q?=
 =?iso-8859-1?Q?CFj666lEDp8AaAoDR9A5llp4D63Ov+0yM5iDOylXsSTG3cckXUwuom39VM?=
 =?iso-8859-1?Q?3fJmYOcQh7ssqJlPRRCpKAYZEGUEX9+imqQdwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lX7GbgEZ6j2uJgKBAu0F5d0qdwFqaYw24e1PRoPOw5KM7t1p/qQIvtUloi?=
 =?iso-8859-1?Q?6TlMO7yUpq8HAkhdJqLjLJHirRy9vY5UOON2IL5FkNKVFj1gWv1V9Z+sXV?=
 =?iso-8859-1?Q?HtFNUUWV7VbrI6C6SnQ698jUyYHttNtq3ZTFCl1puZIw29GNbC8+i7zJRa?=
 =?iso-8859-1?Q?/RezZ3OuUr1Jdzb4fFnsxgo8gRIXDHV8O32GvNCW23gXgNTPxv+/PG6vt5?=
 =?iso-8859-1?Q?2fHWFw12aCfXiaEJE8CU6Zd+EuxWx3nb1h//hd7sM1cQmEGR1M0B6J3Vwu?=
 =?iso-8859-1?Q?0DcUOOm9cgnemNTgfCnn9sTNss9O4VN1tpNpV+/T0ojf8qJyrkWnIWXfaq?=
 =?iso-8859-1?Q?Ea1/fEH4LW1O6oi4dhATcson4ophsDF57wr/Qsi8g3Iy+nuGfCLn+QVJ3N?=
 =?iso-8859-1?Q?uT7d3+rw4o7WnI0v/IKN/1JLWtMmaiP7rODLv1UFPEWvomzCG0qZXVEE+W?=
 =?iso-8859-1?Q?h7MHOYnfuGbIxNlc/nXRD8wEBTZn89syJhjWYMQdERs6vKgotnijDQWRBy?=
 =?iso-8859-1?Q?uMbFPIkH6mCuPR//OvEBNDl/E1BWXWOncgXnElyG+kMsaDSukV1BrKZTNU?=
 =?iso-8859-1?Q?b0wK9QEkte7o5Nh9n4qrOOPkaAYreJV61ZEgqw2thTp3TTeENJYFtwJAFI?=
 =?iso-8859-1?Q?EyAvBVfIFU7QeWCDRxD6/8MbjgtuNuRYG63FESrf+8uEUklqcIAjjb2Wdu?=
 =?iso-8859-1?Q?TJV+NPCs6UvEvlKEUyeoEfz4hFmAp8hGZ9y/HV9/XuhNZN+OQUXzOpxy8E?=
 =?iso-8859-1?Q?Gb/2oyTahInEHs2hkEoaVKUOm9f5AEx9LHaK77yIF+DdtC+3ZDrmLEsfyw?=
 =?iso-8859-1?Q?WLMmD3CM13yOwJ5pGmfulhQhU83vBNhyHoAETYzG1s7jBFEDARXV+Xm9pF?=
 =?iso-8859-1?Q?5a3tFLu6zB0OMqIjLYGrfqqn16nRfxvwJ/Vh8PCsf+mgwZyy/npadJLGLV?=
 =?iso-8859-1?Q?lA3L0AC7r3RDFckSHdBUI2qU1fJYCM5CDdPLM5BP47HS9ClW4Cks5D93Ji?=
 =?iso-8859-1?Q?nKvpsUFZwuA43juj3QUAGDXt01RWzjaONC01MifDC8MIi0LSCmjwd+w9DW?=
 =?iso-8859-1?Q?EAYieanzCpsE9W/mnGTCRy6Wsqqo/4aIyDXU37R7pfH4T/bsBgsc750bcK?=
 =?iso-8859-1?Q?luq3iOSQeF1np68cDhc26i5y2bhGS+017wOkGWdnF3Sg7esV7Pu0COzUMW?=
 =?iso-8859-1?Q?5Q9+AWx8wh0F8poG9Oe0uvv/4lVNen/5QeAOiFDyLb/wlNdeo8DJZVxr3h?=
 =?iso-8859-1?Q?eOzgrDF5Z+lAWLEcKWk0Kj0yU3RJ3qV5qIGY0ttoBrPdvLluKHJ8/f5mXG?=
 =?iso-8859-1?Q?h+hT8T+JwJcXEDZN7hi3YuCAE6C7hrZjrHjdx5DaHexWtAZgfQfECywljF?=
 =?iso-8859-1?Q?YRSxuiF36honHvmpIQ9WwGTyfjWfmuYk6z2ePr5xxfU0P2X2VEsOB/4Ert?=
 =?iso-8859-1?Q?M+b9edT5ntSPIJGgTGJLFdTIGkp6KjEjAE9UGYYqXoJ1sZLCrfTShT/5Dk?=
 =?iso-8859-1?Q?39K0kNGZQaLQ3iK+xNLPT1u484ql0bfaizTU+EXc5MhRh/v7J2rU8GbHiG?=
 =?iso-8859-1?Q?D96ZndnxfB46vwwrEWzIqDn6N9m5u11U0u3CQ8GtYK/f324onHnrgtVBTk?=
 =?iso-8859-1?Q?Llyp+ZaRNDfAMBOM9LoOPAyZ9j0oyd+wCjZoP2mPfICsq36+2bCLkQYAc2?=
 =?iso-8859-1?Q?s5xWt7iaLlQle9/0itw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 561d7625-8034-42d2-9714-08dd3543ed33
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 09:06:41.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aUq90L9B6JtEI1mYn/zTd7zXxt54vmtIDPJu2xhvMrnQ+lfxgHVC6tYdhXFdSe6lgJcfvkEkUEcjH0ve37hcmRUG1klWLZ76ejNlthrvS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7527
X-OriginatorOrg: intel.com

Hello Shuah, I'd like to bump this series for visibility and ask if you still
consider these patches okay to merge?

Just checked and there were no conflicts after applying it on the newest
kselftest-next.

On 2024-11-27 at 18:35:28 +0100, Maciej Wieczor-Retman wrote:
>Recent change in how get_user() handles pointers [1] has a specific case
>for LAM. It assigns a different bitmask that's later used to check
>whether a pointer comes from userland in get_user().
>
>While currently commented out (until LASS [2] is merged into the kernel)
>it's worth making changes to the LAM selftest ahead of time.
>
>Modify cpu_has_la57() so it provides current paging level information
>instead of the cpuid one.
>
>Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
>get_user() in its implementation. Execute the syscall with differently
>tagged pointers to verify that valid user pointers are passing through
>and invalid kernel/non-canonical pointers are not.
>
>Also to avoid unhelpful test failures add a check in main() to skip
>running tests if LAM was not compiled into the kernel.
>
>Code was tested on a Sierra Forest Xeon machine that's LAM capable. The
>test was ran without issues with both the LAM lines from [1] untouched
>and commented out. The test was also ran without issues with LAM_SUP
>both enabled and disabled.
>
>4/5 level pagetables code paths were also successfully tested in Simics
>on a 5-level capable machine.
>
>[1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
>[2] https://lore.kernel.org/all/20241028160917.1380714-1-alexander.shishkin@linux.intel.com/
>
>Maciej Wieczor-Retman (3):
>  selftests/lam: Move cpu_has_la57() to use cpuinfo flag
>  selftests/lam: Skip test if LAM is disabled
>  selftests/lam: Test get_user() LAM pointer handling
>
> tools/testing/selftests/x86/lam.c | 120 ++++++++++++++++++++++++++++--
> 1 file changed, 115 insertions(+), 5 deletions(-)
>
>-- 
>2.47.1
>

-- 
Kind regards
Maciej Wieczór-Retman


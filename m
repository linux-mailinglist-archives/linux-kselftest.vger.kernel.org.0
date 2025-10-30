Return-Path: <linux-kselftest+bounces-44459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B979DC22893
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 23:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE823B51CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 22:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8A3314D3C;
	Thu, 30 Oct 2025 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jy9leikR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FD26E16A;
	Thu, 30 Oct 2025 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862710; cv=fail; b=RzdOhk6FOrvsEGsBzghj6YVbRnI71YJqQAbuH67+yYzzYYRJuPm/zddm1pQ/xYkQivtAGKbHIQfXYC+wrbAFCfhA0ctfFGOJ9a8Cx7d/ZM9unbhxw1BZPwhe9a3DGJTYwWQFPz48uJSEH2yG9hZ8lM5Vwpulhr6FpZA8Z1EMtFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862710; c=relaxed/simple;
	bh=DNiOsK4fxR2be0R9tSvILIUOAAk0H1pt3V/H+nuNW24=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hi2mtBuy0ky1C+U5JhVsgulV+FTiyTAQSkImoQMvfyoQjppPQhVHOifJTZZuZuExqeySjWw2KEeZq1nMSxrODQQUfCeq98enuLwPGcs2QdEC77fgfTCowe8pCiTfgSXC9ckXUrDJj7IYrSCeTmTtbsoHRkovdDus37GEeJjf7cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jy9leikR; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761862709; x=1793398709;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DNiOsK4fxR2be0R9tSvILIUOAAk0H1pt3V/H+nuNW24=;
  b=jy9leikRNzd1v7c+NAcFBej5sakmVZxa60UXtU2M92s4trTgp7nXtqsa
   MTdOEGu2DvD4Gx9lUsxY8hoSwxTDwt/wzR1MRQQDZlU3OYkodAZ2moXkr
   RSyMklMT7pKSiSwSjWkeaTVLJJ8xPs+kbyk4jHNd/LnbyWbkYQaM3EU2n
   SQipo6AGM5bVsWIl/znIUrFYuyDMqhVLXmDmnHrlgAK1VzjfNukD4ihyp
   rLcXcwewwz0P4yX42pi/NM/WU+km/bdeUTMg2Db5ug41cZLnHufMN0vnd
   6+Y1gVYAniXFyX2B+Q6FcYg4c/eXvm26GhL3Tqpneu51LvuC4C7FN3u5N
   w==;
X-CSE-ConnectionGUID: F8fQlqqgQfC4Mefj1d1z+Q==
X-CSE-MsgGUID: /pmbcZGvSbCZ7NZ4nA/cyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81647192"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="81647192"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 15:18:28 -0700
X-CSE-ConnectionGUID: 5XaxV/9QQP69dmWau09+wg==
X-CSE-MsgGUID: zS0f8AJXRLyG4pg3BomNuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="186007852"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 15:18:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 15:18:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 15:18:27 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 15:18:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1bdmKmxnRNe2Y1Q4S4bdlp4jpJsb2dvmdMGJiYbNBcwOz8dYstBOcThTXyHs1+4WtCns0wySrwdJnTevJ9n2gsuaPgTZit83Eel8FW6919fXmLd//E//0YLs2unTed/zkqExOfXrxEMs3U3lYoUlsU3tGXitlF70CkcYxhL5AHOAs0EgPH58xnfXpQYwPsBsxbpKTTbh48hc6Y8O21kXMgtqizlOSe7DXy2TXocgY/Vwx/OBmp0PKAXEZXhlyA+SetO8YGK8gc7IIPvwVpZpWcILaaatisIROErCumiu95IwL2f38uJ9UPxLlhMBUjYAg1z2PjH+y3Pv53WU8ve7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAINpZSekoMGfGLqHvHPh653UHFpkSLt8lxT/AQp0rE=;
 b=Qs3YohAXmTF3X5A2fD8TsyKTDFP+yJElqsAnlwiJWt8MdCm0JZSUbCw5rn7DOmodF+BKIMoOdjSHXHmFYUowrNSuMQlg2XG0l8X1zBETQLSZOnU7Gner1lku7Y+zZ1iYfPdbcmCY72ksY3J/0SoRC/IKX7ve7h7kHb0HtZFXrddPMydx1A70Ua1pzUYI4uFjHquvqrTT22XYv2V5O4YPhRS9KT7tiZGUmziZdAts+hU9E+xTil+w58F34LZQn5HPux8YzLQx8qFxSJ2LzB7TRKi71/6Ly0ibfsY4vUs7jkEWlYeFi6jKzu81BPK5KFj5H+AvTU0Y85zshsw7boSREw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SJ2PR11MB7428.namprd11.prod.outlook.com
 (2603:10b6:a03:4cf::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 22:18:24 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 22:18:23 +0000
Date: Thu, 30 Oct 2025 17:20:45 -0500
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
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v12 15/23] KVM: selftests: Call TDX init when creating a
 new TDX vm
Message-ID: <6903e4bd470bf_23147410098@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-16-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-16-sagis@google.com>
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SJ2PR11MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ba20ab-5069-40a0-65c5-08de18023d99
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PFP93Z8JCBqsGDk17YnPylECTA8p05wicL+4htSCnRzhav6a2hJE2YlT9C1v?=
 =?us-ascii?Q?0ZyHWEDIGmhvvtcLzN9FRpgRVsDi7gL9wPcIncgJLr7r802JXvzY0tR6kda9?=
 =?us-ascii?Q?e2RSJUrAW1F9uwNxUGYTtzCDkzZaYc1/2xKhtZmI0Mp8ZZzloKH6G8gh7O16?=
 =?us-ascii?Q?n2TLyof9SUYRGKv3cb93ZM+O8XZO2XKEILrBGEMiA0Hik0xK19OzG5da9r06?=
 =?us-ascii?Q?YlzZR5yk6gMoN02VAndAegtcZdVIKRkV1tbb4ebeV6Kp2ISghMpWg5bNNqU8?=
 =?us-ascii?Q?DQmhHNKskkVKylyq7uik5una9QF4FIl+Ed8K6eXI2996OsE5NUsYq9P5mlOa?=
 =?us-ascii?Q?rtOuGBjaRcV8cThstuYwIWshw+AWGuc0TgLG9K3A1lUe56SjkNfkgThbEQZ8?=
 =?us-ascii?Q?p+10DkQgUG90TO4z/1bn3qIUCdCTV/q35GGm2QNZ36eBWARsjyNfXdYQJsJd?=
 =?us-ascii?Q?Vl4QlOk/m/oxji6IE2Vfqr6DxX25f2Wp1N3yubpTN2uSjpzuqPB5nh3sYAdq?=
 =?us-ascii?Q?Qsoic5qxvbVNSgEFpLxMj3O8IqrokQZi0wF7MBi+l23y1M3tmf25tQLUmwjn?=
 =?us-ascii?Q?/yxWvx4wBC9lIm7FLU4HwMh0cUGLP4Imp754ppa42aa29+/RVcd7idEUBWVR?=
 =?us-ascii?Q?1Q08TNW6hvd7nfVuIhK/FuPC+Yzh+bK5U1yDaCyIQy3Krs7fUeF7fmVJV/Xk?=
 =?us-ascii?Q?oyFsN2xjhvYP2G0dohptnlF4xti8jVIAbg62ySjXV9BJPvCgEwLC/N+BLspq?=
 =?us-ascii?Q?1J6qdz+PfgoYqxEqegewMYEt5sj1VLDopNym8dNF2ZBLtcKHwx+WoSm53TE9?=
 =?us-ascii?Q?evb2i8PgQK70SgvD4ASxa728Nx4mE3lYv20PCdzM7T027MukiTSznZjSe0IY?=
 =?us-ascii?Q?vVJiMeNrRKT/kNA4k1HT996VRBGuibBoeSGgBENnisfsgZOLgzhzQE8y6uZZ?=
 =?us-ascii?Q?9F21XfW2ScYhgyfSzA4dNA/LQQdLhqm99BNfDMe0WY3q+g5GXboU14B7Fc9K?=
 =?us-ascii?Q?WO6bWAPgc8oHFKQYv0PhfJ8R+5PiqYGg/q5z6+aeGkpvLoFo70SItbI+5CMD?=
 =?us-ascii?Q?wDS3Wg0R+f6dVSQOh3EGKP5NALfIjncWM15Nh09NwgGD2w8nY8xxb0+8BbRL?=
 =?us-ascii?Q?fj37PpzwiebxVI9EIx2u78WUTwtlbB9mTQqm9lmEyXv8tv2YZaRualTG4YJA?=
 =?us-ascii?Q?cO2ljSn4YcRx1hYFY5xzlaqLpVXAEc5gRCW4g+e9M7Dx2efffAsv3ytrBEsP?=
 =?us-ascii?Q?S7HH7TvFOK4v2H+vtPsrtr51sviHsemLfWvli8nz/jYuZHtamEsNxB4y+GnB?=
 =?us-ascii?Q?w1mupfMAjynpThf3/Ampq3XSE9bRXueUETilXT1Otbg+DE7N2F07cc/K3Osn?=
 =?us-ascii?Q?dqtMj6ALF65bP1oJdti5ovm5zvH6ixV8eMjhI/76Qj5sh2wsr/aRkHi4O+Tj?=
 =?us-ascii?Q?Kk14leLp65Hr1dsHG3v65LQEcadBn5xPEfyucl+VFddTU4dbWQpTIQYV6Pmg?=
 =?us-ascii?Q?X+pmr5furbawGWg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tf6ib4I3A5Hb3JDbEUDRyTfWpPqYvHf+JNrlBcW+/lQleRRIjLUns+s0aqFC?=
 =?us-ascii?Q?0yhpaNQvYxPvy8csl0uiWnZMm2u2t3H6Fxkdf7WBwT14sPoKF9QXTIRX17te?=
 =?us-ascii?Q?ojy8RVtcWqLIM46cGTHm6vqNAZ6zN3ngcD4ihKHVpwEanfO8TNdcSFu8YSjG?=
 =?us-ascii?Q?OfN6BWaif9JRpC5KwWSkER87C7S6lVdmO0hY1sB+SAO6K/daTGNLcLF646Pi?=
 =?us-ascii?Q?7LHKUJ8GIpEF2mGu27dVRd2H9MEiPb3rYcw06OsuYxadJ9hCR2oSoav8gMYI?=
 =?us-ascii?Q?zJeCe/rlaN1fs+sbYoowbYSD3B4rMIty3oW5jNfySsBHt9St09Z6SZkTd/HB?=
 =?us-ascii?Q?tZ6ytZrC+R7nCkSZ3DaHu33FOJ+GKxQFsyktoeGoxFuizL5RDQXSdFc2Yfi9?=
 =?us-ascii?Q?eXBxMcYUZ0lIseHEZrooryPwqCK67RzBvInQhg0TbFZRT6MfET+PQGfmEAji?=
 =?us-ascii?Q?fqaRe4ZaNg7mZva1lT/rdZ9N3LbxmWNbHHyD1zlZoyRsiBPXAZ7huSfj2vRi?=
 =?us-ascii?Q?7TV9/IlQ1smgV3Uw2cod1CZhnCecV+oUO4PgB8PGB8kCRklSOXC+yHZYnut0?=
 =?us-ascii?Q?g/qoSmQlhtwa11A8ma5e9H5Q1kplyc7UTV1ubDWm3nxbH673F8fHewvK3U1+?=
 =?us-ascii?Q?JKtZeTa0Cq9SUHlQvqMGKMzSQTLoPF5c0wk9G+zrSSXPbOfSdn3X7VNrnI89?=
 =?us-ascii?Q?qgMiKb448atvSegQjsCmBI2wUW9l3mWMHK7kWf9y7ZTC9ryvinlVD/GpPE93?=
 =?us-ascii?Q?Gbc+mSd2Zj8PBPXvPCiGj/IyExdnHL/GbtN5A2ntkH8ALp+wi2Fl7yON0i0C?=
 =?us-ascii?Q?E6lazSGoAnqpr3gLw/FE6FVMvw+KxQKGCrSbPM9kTm4Jk4g82gZkcgoJ9LVJ?=
 =?us-ascii?Q?Fer23zGQ6GejhWwLx0txWArdtpQsPQMCl/4W4GKOUinTS9SjxM0djScL8ubz?=
 =?us-ascii?Q?wYVF3bwa4p7CJ09tsOzEnSu4ZC97a9PC4zbjXE5XKxrmsPDenRLPJsdBh/gE?=
 =?us-ascii?Q?GXAw7o4c8zTPzX+s8kG7ohVgOAVfavDyIuVsCaeaSOJym+H5l7cPjLCu404T?=
 =?us-ascii?Q?YEsbbArjxuyDhS64Z3U9SnOP7J7NgrGK5WNiS70CMLi5nUJAlRdyZqC0RVwa?=
 =?us-ascii?Q?iHc4cx07xIwO+FWb3N+3awjlCVjUiqo8ZDHhIOwEmZAJqzi4bkk7VWkriTOh?=
 =?us-ascii?Q?/PkMz9wZtAd7MEo6MPXjkBSKRPx+MKOZf3I3arhS8Rk5lbO+6GaavCEyeicf?=
 =?us-ascii?Q?BwAwfSf8K52o3xUC55H/aw0kcbYa9+Y94LSFPXTLq4HqrDfE+sKM6Xr9DXol?=
 =?us-ascii?Q?mlkmRt41io4S9w1eCdnYZgrG2Pp20pFRuYY6/+5Ko/Th4WyQCZ0dRhpFYFW9?=
 =?us-ascii?Q?p2YlhSskQZ8Fw2XYfAiZhbP2BBsAH3LVS9iXRUmVgHfKlpuF1woMriJAq2Qi?=
 =?us-ascii?Q?ZxwIoE4dndFTYmoumdrJIaCMGuTfC9RueX0BOZe71ED7HMxw0I1PNVY1xrVq?=
 =?us-ascii?Q?WEnUVaICFGebmZFUV8LU4bcu9HLpxoAvEg2d9ncQMmfQHuZE1mY6Q+Kzv3Vo?=
 =?us-ascii?Q?RxkcZD8jYq7JGAhzBWTqQbT8M/VWotl6VreMgPf2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ba20ab-5069-40a0-65c5-08de18023d99
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 22:18:23.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NBCmxv/512zDCNydLKbujKgw9DWIvzIjJIO6QTi8htJmSN3T23pRhGX/lbe9jWn9DPtc+wYJIcJApKegveS/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7428
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> TDX VMs need to issue the KVM_TDX_INIT_VM ioctl after VM creation to
> initialize the TD. This ioctl also sets the cpuids and attributes for
> the VM.
> 
> At this point we can also set the common boot parameters such as CR3,

Avoid 'we'.

> CR4, etc. These parameters will get copied to the relevant registers by
> the TD boot code trampoline.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> 
> ---------------------------------------------
> 
> Changes from v10:
>  * The call to vm_tdx_load_common_boot_parameters() was accidently
>    dropped as part of the refactor from v9 to v10. I re-added it here.

This can be dropped as well.

Ira

[snip]


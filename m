Return-Path: <linux-kselftest+bounces-40001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F64B373AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 22:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09ACC2A004E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 20:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867DE3164C6;
	Tue, 26 Aug 2025 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYbswWDI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F217A2E1;
	Tue, 26 Aug 2025 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756239270; cv=fail; b=eyF8YKW9zunL8LAh43qCs5zX/edzqleDF2vY49L7UQ3ytTdqWVk5MP8F60uP/PdVQWYdhAe/hH99o7d9/sxBatrpqHnVSVzjDQzb+2GCa3KsB1/GSi9P0vkM+NzeEJAcagnxbYwO1W6N4auICau/OzDucFdfVEsaLOr+88MivY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756239270; c=relaxed/simple;
	bh=lj7RPr2SIVszUMf/rP7MPTydxQg5vcHFAyN1mbLBoVs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pnOrR00ajeEc6Kj3uI9X5jSFhNdAslErfx66SGk4jmBAz6DmVO2LsMA63yR0X87CzW0Xmqb33UPS9ohxHMJsSg2XSq/O8WNYTtUYI9VuFl1j98wt1hiYfl8JtR/UeB5jTOamwHEFB4oODJaKOpVMgt3X02iAIs+zzEH+31z5OqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYbswWDI; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756239268; x=1787775268;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lj7RPr2SIVszUMf/rP7MPTydxQg5vcHFAyN1mbLBoVs=;
  b=SYbswWDIZkG2BMZGdkEDb5aWHaApWOSXQHw5bqMcaQ2hjOjoDk3XcVSE
   Z3pKz6neSbIUgXeycDaE7kMYE5mNBCfF2OXG6h5mFfyRopvNPUuaY65yz
   BwuC/uqNHBKTFc0C4LXHQewXwjsKJsEKqwwGbzWHfSb1Netd6hiQjuBMc
   OZGt2BsM84sQtFHNvxK8F2GhghX1ogx1bAxg0uns3GC8AZX2vXPzMy3DP
   C/rb2IIODG3yOl54uHSX7zG2AuMVqlBTgbfAd/0pXo5FlUWNyGLVTHoU+
   cUMrQeBu7SJAOlXbFIkjkyzWlbhIXxgT6/CiHSg/c8kttlhfcaa5cbIds
   g==;
X-CSE-ConnectionGUID: lbJJGzGwTZGe0o+xMpmIcg==
X-CSE-MsgGUID: +dERH8I3QcGtCsdUVoAfSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="57689888"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="57689888"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 13:14:23 -0700
X-CSE-ConnectionGUID: MzuAJWT2Rb2bgXT1ifSEJg==
X-CSE-MsgGUID: nS2cRngDShagcu1PS5PrfQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 13:14:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 13:14:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 13:14:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 13:14:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaZYo41JnupRYn1GRF1sy+xGHWnE3ebmXsKzP0TGrPH/FK+e4Pw66D9fUOy0lB8tje2D1t/Vkc/F679x8wxxpV2gsDEheT6psj2byNnQr94+MRZ+Ryb+RKmVi1s18d4iYZoUEaCq4OWwz0aeMiOiUoxeynQeeURR2Y+fOgNB71J+8Ff4Pt+JCoSQD1fhDn9KCUSk9oEQTP9DaE7ypGzLsiuMFRKv3vGL0ztra9Sf+5dYSAKjHDl6jrdJ+gMucxZvClQaO/iOGW1unNHJjk5Cg4AS0G8k5kjCzRj+QNWit7QLpiT6orUhJLk16VUf31HZZOgw2FMYrb7IsH5STyhI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdOQNEIhZ4cpRpIU0fyCsCxy5b9dX13TS3M0c2yPrd8=;
 b=nQcrYh1R7dedPKg7Zvqkykq+XWKjsUQ7Ec0RgXTCHCPK0YQrg8XCOLx9QZx/oMqqCl39wgoZNz7X1N6paxqT7XNfM8gGqcz1C4vy+BpwsmcVSNYFmttsQd/QhiVUmMj6Sr5vvi1Jvfl5bCFVW1PR6X5CF3Yo9QHzgS6F/TeaHCYD5Ui7eAvObpExUkugFBrTO7V0SQFrqjxWqONyH8HHmN2Mw0/n2dVs6SJsngkPRbeQApx9AykWPDS9Abq8kkiekV47AT51kBD8sc80yFNul+lc44DJn1OM0Q0oYSY+g6a6ynS1uGCMslZGpL2tNknLYx7Zto/uegdOVE0etBQtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DM3PPF31D2DA56C.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Tue, 26 Aug
 2025 20:14:16 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 20:14:16 +0000
Date: Tue, 26 Aug 2025 15:16:04 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, "Ryan
 Afranji" <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, "Isaku
 Yamahata" <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang
	<runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton
	<oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v9 15/19] KVM: selftests: Hook TDX support to vm and vcpu
 creation
Message-ID: <68ae1604a387c_300e8f2947e@iweiny-mobl.notmuch>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-16-sagis@google.com>
 <aK3vZ5HuKKeFuuM4@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aK3vZ5HuKKeFuuM4@google.com>
X-ClientProxiedBy: MW4PR04CA0285.namprd04.prod.outlook.com
 (2603:10b6:303:89::20) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DM3PPF31D2DA56C:EE_
X-MS-Office365-Filtering-Correlation-Id: cd934658-4253-4710-5b76-08dde4dd220f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dKdTlwZAn/NxLsIsPEB227oDbCw9HI+2TLFdw9TMZIbOPt5xM52ASCqTEU5h?=
 =?us-ascii?Q?EpSF0kvYtuxtX1yk0ZnzN0xBA9ihUeNI5gtZyvlRHp14Nt/jt0RjRp6Fvl00?=
 =?us-ascii?Q?EzdgXgfnmCFzFcm7F5Hw5VZ6r6dHvzW9QdY656gnXng3LUwY/eb9ao9xDhAG?=
 =?us-ascii?Q?oymdV/FPdd5gIo0N0lTEnnkuEQ2jjpT3wnylx4vIhWuzhP6VWRIZXvfnXUxK?=
 =?us-ascii?Q?QEaYs5EgFp6CymBbT2jqdWJRVGe5t3657Ia1NyXBUDqMb1feku7v534kEuiW?=
 =?us-ascii?Q?NokA/HCWJxtu9AHAmgA7p6ST8fCQOxOaIi5gQPT0H4CycwxzXroYn7ol8g++?=
 =?us-ascii?Q?S83dMFGyTb6+ZYWGDKFg+gYJdI7n6aSxEnc7KOeED3eXvvXbEdix8HBGj0d8?=
 =?us-ascii?Q?SZ9bdojvJLNH1W16XKN+zjFlYhltIG6zGiCf7kMIR2Ii5hPVKRgdr3u6Fp2J?=
 =?us-ascii?Q?enk8ChzPd8hWi0q48MW3qfOP9SUkmc9VcBX9E/1xnzE5FA710wXiQ9dOu9AM?=
 =?us-ascii?Q?rmYv2GnpyY4jy6pmunL+UCEYx+nLwcwlBMCL4JmzUngcUr0fJlx4js3LsQiW?=
 =?us-ascii?Q?24Agg7hL8dHBtlBm03pHKrQco+FV93w0qJcLJMoQrW3xO0Mb0s3dXnRkPIZA?=
 =?us-ascii?Q?bNJF4dCut11AbgjZBNqyI/HRjl7spg8nITaez1x2g7SMru44QxoaOeqkfMDt?=
 =?us-ascii?Q?/lwbfZ9iFkRBQiSeyTvCUY6lKty2WCyFV852x8Ndx9P8XwUtKKa/nxiSeMul?=
 =?us-ascii?Q?3k8454vobo0fHEYGE4yYeOIQttrwBVLEArn7akjrf/thuTmGzJG3fUAuORch?=
 =?us-ascii?Q?iYDpykFzpXxQlmXLo3QCHZTGhwwsxM2Xz2rk+bIxVElNQVBGLT3IMMzzmY53?=
 =?us-ascii?Q?cxPu26zzj5nmDUxpAQOngD4wqZD7YO7wsJnyQU0vidLp6bALhneUBCeQIOxU?=
 =?us-ascii?Q?ii0BXTcRtCTuIZkcNKLKtWPb+Hf4SI9cKrgN/ZECMIYQKmAo9xzGw+ojxJtq?=
 =?us-ascii?Q?fMcezGc1UvGJsg9x7EvvHT8bkTvRJ9CykO4wMIErldqejo2vWdgGWRrlJEZn?=
 =?us-ascii?Q?g/L+Fi5v0op+XFIxcjvpiW26eLSpIMM6O8O42l3lWjcIobeHx2a7F2x1/WeZ?=
 =?us-ascii?Q?cs0RM/NVLTdFtNyXjpYuFWJcD6TE56v2aF0gggZePq6VHjmEhMSUe97wLrNM?=
 =?us-ascii?Q?bgDUl87tWhv41ERSlwQV1eGO9VQIQm0U7syn85NKmzDLY2FTpYt0pzEGdSwr?=
 =?us-ascii?Q?ITyG+nzIR8GkMaG9YlTEy2PLLH9M3ZMF6ejpPQrlegNW524+v3zzdDgjWT/a?=
 =?us-ascii?Q?+fjDL/uEosKtv1Qdy0iy4KrvBB3cED8WR/W5Paw1PqMOV9s6oXMHJAHkVlxF?=
 =?us-ascii?Q?JUy0Y6LfjGQfkpmBhkl0L2EqqwXDPfrJtNbcP+bL3KnT3bjn9CfyRRG5/yf6?=
 =?us-ascii?Q?waMipZFmTsI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EXLSRikeeyGpcuw5Ed+D4EwCAAZfeQoBX4kFK6PDqeFmh+6yr8PGZdE3gJeJ?=
 =?us-ascii?Q?6wsI/V3Hx1lBwb11N7zR0BMC+sgOBOAVtcBztsPUSeVG2btT5OxlSHOmd+zR?=
 =?us-ascii?Q?VGP0JHfgv8ZrDu8MfVoRd39PjMDMzVzys3bpVg4A1Lx8WcTEvqC/Lq8sLif9?=
 =?us-ascii?Q?gNRqMsOKdR76KKHNqdFz1o0A75NrJPyRLUpXlA82Ed7yAwjZ14Fw8ad6bkgH?=
 =?us-ascii?Q?L6MB9ZmlmQBhf+/SlGoO8yM9d6RubnGmU83CEkfAhhqUxlos/ukhHKPFteiP?=
 =?us-ascii?Q?2UT1E2EEu7G1tW2fldLtYXtWHIjj1Dt2a46tPn5pHSp+ayzGtRwYE5v3yTni?=
 =?us-ascii?Q?j/Qqj57wGqtqes/xMnFFZVuR7mVL19otWUnH00m9rOxwV8eEXZc5W8hbtvbG?=
 =?us-ascii?Q?NFNdiq3tj9BC+ARZQXSwq7NxKkszkIw1yda4DQNlYNO8W26n55ioMpfT/rAA?=
 =?us-ascii?Q?OlkomrzWJcmEwlsTEj5SDpVsIyeygL4k8hv99Eb2HbYunUdLv/2NngG34dKh?=
 =?us-ascii?Q?zQ5sGj4VyQXwn7N1fXWkAnKVkikL+V4ORo0zjtmdAqB8rWShVCw9eK/sKEka?=
 =?us-ascii?Q?6i2PwJgUDF4yLU/O5PrnZBaOtDN2a0CdQzKxzVwBaLAFk3Sozu+iNr7rfLzd?=
 =?us-ascii?Q?sGbwCBZRhNsXilI/pQn4DnbPGPPAN8+LNKOwBZvyK+iVWwunmMaWoSfxe8+E?=
 =?us-ascii?Q?Z01RWBgqnXPhgcUV1HCM8WkGJzlIf+yJQN9H2GlxaH59QZzdYYRwFV9DW1I3?=
 =?us-ascii?Q?hmPDILoNU68jwTLJGbl+fKvPgrLdyrA8/kzXLko/n0Ll02boby/rmuodzW0N?=
 =?us-ascii?Q?U7oozIEzYzlFmJSRazKT9SDUmfzUInMnFJWo2RRMYJqe9OgcedGOLws1aUH9?=
 =?us-ascii?Q?qDrjc52UzQFCUvaBjGt5bglnK2FBn0vcPnRUNE8Cc+UjK3FFzBHGNFc3vC63?=
 =?us-ascii?Q?NM+WFY6HzEZEEbiSX3p8VDHdaRSbqbWdOkeO65HmbBdb4hJDed6pez7XSfFU?=
 =?us-ascii?Q?5AOkN4XqN9tG09NFEz4OKB88Ak/g0o0vsUKzEQ9Kyxn4LUD7eA7ccENLiMbJ?=
 =?us-ascii?Q?6Vfn5kG8dIFPbJIlUo1pibusTLDYcqPrZzOcRZV7/YRxK0F/R0l78/xymRnk?=
 =?us-ascii?Q?yhm54eICG9weWoqkGSoHfiqIbPLe742L0YFhemg/mn4gJHDgxoMcEk/OP9qF?=
 =?us-ascii?Q?kI2VQ8CSY3KW6Vl5Rcj8/QREU4IBwP6K9hjJlszapENdo2UzsMuNBHBPhonu?=
 =?us-ascii?Q?efcuGhYIQvqkAJS/drgEeiZuPPAXb+Fklwpk+TuV2Il7HQZzR4GDjkEnBkub?=
 =?us-ascii?Q?vgQD8/VtbeWM/d03S3DKXbaarpkbLjmvsKhRRGYVnEbl26u+SeuM+v/4I8SG?=
 =?us-ascii?Q?GV4iBjh98sUNZ4boqdJeHYtDd8y33unNfeZGtKy3Nn7bifP8bgqkVpKDsYqJ?=
 =?us-ascii?Q?I9t3ySIL12U+KfpMXQcO5Hah+65kKWzoN4UsWbc2JczxxbMW1z98Z6ua/sDA?=
 =?us-ascii?Q?h4++8DOd4mgDsKvt6DQTwtjvJnDoeICCe0BzvbVQ/nRLP+ThDZJ9xBUxWDj1?=
 =?us-ascii?Q?eRGPiKM/mi9UjAHbxLTcuzMl36EmW+yGm3c6gFo/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd934658-4253-4710-5b76-08dde4dd220f
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 20:14:16.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywPKeybHY1ZieQkdgCDlwaErxuBtCR8qIgtrM1zmxh8LHS6dMotqmOR42lpSq+hxWyX75IPOR2eGlIMl/D6q6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF31D2DA56C
X-OriginatorOrg: intel.com

Sean Christopherson wrote:
> On Wed, Aug 20, 2025, Sagi Shahar wrote:
> > TDX require special handling for VM and VCPU initialization for various
> > reasons:
> > - Special ioctlss for creating VM and VCPU.
> > - TDX registers are inaccessible to KVM.
> > - TDX require special boot code trampoline for loading parameters.
> > - TDX only supports KVM_CAP_SPLIT_IRQCHIP.
> 
> Please split this up and elaborate at least a little bit on why each flow needs
> special handling for TDX.  Even for someone like me who is fairly familiar with
> TDX, there's too much "Trust me bro" and not enough explanation of why selftests
> really need all of these special paths for TDX.
> 
> At least four patches, one for each of your bullet points.  Probably 5 or 6, as
> I think the CPUID handling warrants its own patch.
> 
> > Hook this special handling into __vm_create() and vm_arch_vcpu_add()
> > using the utility functions added in previous patches.
> >
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >  tools/testing/selftests/kvm/lib/kvm_util.c    | 24 ++++++++-
> >  .../testing/selftests/kvm/lib/x86/processor.c | 49 ++++++++++++++-----
> >  2 files changed, 61 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index b4c8702ba4bd..d9f0ff97770d 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -4,6 +4,7 @@
> >   *
> >   * Copyright (C) 2018, Google LLC.
> >   */
> > +#include "tdx/tdx_util.h"
> >  #include "test_util.h"
> >  #include "kvm_util.h"
> >  #include "processor.h"
> > @@ -465,7 +466,7 @@ void kvm_set_files_rlimit(uint32_t nr_vcpus)
> >  static bool is_guest_memfd_required(struct vm_shape shape)
> >  {
> >  #ifdef __x86_64__
> > -	return shape.type == KVM_X86_SNP_VM;
> > +	return (shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM);
> >  #else
> >  	return false;
> >  #endif
> > @@ -499,6 +500,12 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
> >  	for (i = 0; i < NR_MEM_REGIONS; i++)
> >  		vm->memslots[i] = 0;
> >  
> > +	if (is_tdx_vm(vm)) {
> > +		/* Setup additional mem regions for TDX. */
> > +		vm_tdx_setup_boot_code_region(vm);
> > +		vm_tdx_setup_boot_parameters_region(vm, nr_runnable_vcpus);
> > +	}
> > +
> >  	kvm_vm_elf_load(vm, program_invocation_name);
> >  
> >  	/*
> > @@ -1728,11 +1735,26 @@ void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa)
> >  	return (void *) ((uintptr_t) region->host_alias + offset);
> >  }
> >  
> > +static bool is_split_irqchip_required(struct kvm_vm *vm)
> > +{
> > +#ifdef __x86_64__
> > +	return is_tdx_vm(vm);
> > +#else
> > +	return false;
> > +#endif
> > +}
> > +
> >  /* Create an interrupt controller chip for the specified VM. */
> >  void vm_create_irqchip(struct kvm_vm *vm)
> >  {
> >  	int r;
> >  
> > +	if (is_split_irqchip_required(vm)) {
> > +		vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
> > +		vm->has_irqchip = true;
> > +		return;
> > +	}
> 
> Ugh.  IMO, this is a KVM bug.  Allowing KVM_CREATE_IRQCHIP for a TDX VM is simply
> wrong.  It _can't_ work.  Waiting until KVM_CREATE_VCPU to fail setup is terrible
> ABI.
> 
> If we stretch the meaning of ENOTTY a bit and return that when trying to create
> a fully in-kernel IRQCHIP for a TDX VM, then the selftests code Just Works thanks
> to the code below, which handles the scenario where KVM was be built without
         ^^^^^^^^^^

I'm not following.  Was there supposed to be a patch attached?

Ira

> support for in-kernel I/O APIC (and PIC and PIT).




Return-Path: <linux-kselftest+bounces-38680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B877FB20BA2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 16:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8126A1887A99
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59D219A6B;
	Mon, 11 Aug 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRLpHa9g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB8221F37;
	Mon, 11 Aug 2025 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921893; cv=fail; b=leRvwNcjyueDQEWCX/HXsCszQZBCxFf4q1u1OZ2M+UcdgC0fNRP1zyrVfWI7PO6hBjB8bCo7x2rdn9tuzldbH8st2rzSmObEQTgqVnuNOHOriwFjTjiCIsEeLlrlz0GrnF2bhsFN7Bhrso9fzRzeiOjahULwAN2kWjLe6lwAOVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921893; c=relaxed/simple;
	bh=b+g6Gb7IY7iyGtk0VbltLB6EDw6YtVbMJ1wV2VBMwgo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V9UFw/6tW6E/tDu2DeaBkGNCEuilb59yuJWiFyt7b99WLatdXPD5GLRyj49dhY/04cIljjteNbeB3OEgL+o89ogzf153RQ5F2U2SjSYBeFG6CtSoBhjvhie3SRMcwUg3gu02aMh5QaDTjzGpI6L/0NsgHPB2Wegv86XOqpV/IAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRLpHa9g; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754921892; x=1786457892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b+g6Gb7IY7iyGtk0VbltLB6EDw6YtVbMJ1wV2VBMwgo=;
  b=jRLpHa9geFR3yLVAlcoPp98UxUL9fz6lTp0mjnx54nxiLeOOWrMOgcRq
   fOAz3HAxV5Js7/Yn+5sTpZXEfw5XskuNooKk78GtzzY4EvpvaPyj3ihMI
   Q9zZAfHEaICfgo5Q54QoauIs6FCzVf2gMIEHCeowcuEcC/zh7LkY80UUK
   GCXqhysd3Fm6JCkl5+40Up/Wz5XAR5LbDbjLmDiyi6zHm7S0XZiz2dYHb
   jFZuihd1ERW+yFwif9C6AZsJnW4zYwwJPStK2NT8OYkBvjFs67R/++PmA
   AvEULp/Ai0BaaOdRzFjnQ6s/8WSKUep4imh+kiHFPkQgzpxf8uzh/EEyv
   Q==;
X-CSE-ConnectionGUID: HdGS5528RtazvLc/bO29ug==
X-CSE-MsgGUID: XONcybngRmWK3YkPcYmURQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="59788501"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="59788501"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 07:18:11 -0700
X-CSE-ConnectionGUID: ENaGYLw5Q6asMdCnUWGIAg==
X-CSE-MsgGUID: cYHkpWWoTf2OF3aMgXXaLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165927363"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 07:18:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 07:18:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 07:18:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.72) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 07:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oi4esVUKokIG2Zkedn2J7lHuyhTHj7Asx9PBYEmocZOvXlGNPmbwS7VReKeqg1qR2vcwpSGF0EZRRYBApoMMC+UqELOrTzuF3NTCWHnyWn8WpPo6/qLGXZ9Gu0Asl+nFGaF87S1NFcITeWHiieEqid+paMG8jb/6k46RDnuKdpviLYG3lck/92zUwtZc4KvLNxkwbzzXB9FSWcdc6eECtkflMNCKhnV0ZG4PB//cO+t/cZoVwL8V7K1pH6Nt2BTa816VZGEAJsu5HzsvMDRg7CBW00ynlZTrBAaxvzRrO1WjWVCWNkeEBqxYXGu2KPWefPCBZ90mYkv0fIqSZ6/VeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsuEgG2lrJ5Yc6Ib9y0GJlhnsYhr2Q0mIFOxGzccubs=;
 b=LBJkzyt0YUyHwMx98KnaLS6CHRly1lbLmWnyuUxb4u5/3uhOtCBra7HbHJWYNBmo9k5BtTHu8rkpvnvzcUfPmZIqTRjELLONetjRQAKxjwbvwkCFA44Pf5JTEI4kKT9PN59Rxg9M+lNzwAevh6NjHolms7sqXZHVGl1HMBY3SVNBoVHmKIVoOgBUKSLI3tf2VoFHkZ8Z31zMKvkmFnEUsch9rlUYAPqA4CdcL3pvjk/EFWA27iEWSQYoGFFdaMPrmg3Zpid9HLOD9d8IjtluqRYs7Y43nWNrJOAYVMjDfuj3VnZOy5JAYmwt+ju0He2fAweC/krSz0pXMvlWJaPTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by IA1PR11MB8097.namprd11.prod.outlook.com
 (2603:10b6:208:457::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:18:07 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 14:18:06 +0000
Date: Mon, 11 Aug 2025 09:19:43 -0500
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
Subject: Re: [PATCH v8 08/30] KVM: selftests: TDX: Update
 load_td_memory_region() for VM memory backed by guest memfd
Message-ID: <6899fbff3458b_1d882b29492@iweiny-mobl.notmuch>
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-9-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807201628.1185915-9-sagis@google.com>
X-ClientProxiedBy: MW4PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:303:8c::13) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|IA1PR11MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 477819bf-1d1f-4f5f-5cce-08ddd8e1e426
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zu5toZ6DrIu/nzARviRu7RjqEvOGUsbSP440FSG2Nr+pdWpOmxwBrPuycHkm?=
 =?us-ascii?Q?dsLg6PMK96IPujygpN2EeY/3zTfZFBNRVarxFAwxEmMKHptj+gYyZkW6iD+k?=
 =?us-ascii?Q?pOVjMEMPbQ/tLI3/udoC/JnXGysiqbdB56HXZqrHjxO8ImA+CldzzBN5LttG?=
 =?us-ascii?Q?y1J+NToIdjxAxhix+SGVH3Puh0Hflg7KM9+m3FS4zNIV1b5lzwG6ZKdicC8q?=
 =?us-ascii?Q?8G0wkGW12M/zpaQIX+QJ8xTRS4ziF+VOfjEGUgiFRbKTNxW++xdHy07efVGO?=
 =?us-ascii?Q?cGKGqi8+sD+bD8T9Be6C73dtta6LQDYW3rKX8TFNaZd1yXxe8Re5/CsxjPGi?=
 =?us-ascii?Q?vGbPG7jo8jZuBVmMTYwn/+W9jxeGte4rbIOAAqGoo/WctC9JZa96ZRy6ufM5?=
 =?us-ascii?Q?tnYKjaC5xyCYUrmuA5mCezBs+nSXn6T1OTIQqi7gf/piXXLty0x5HqfHdAko?=
 =?us-ascii?Q?yEUled8wMsIfHGHeQkqBPp6iEpfmEmUVxcFAPkssSb/zPApZzT+WhBqdoowj?=
 =?us-ascii?Q?8bA7CvXx0yPFAXJojzTAVTyYNuavhQnPv+XniO3x1MwanOuad7roHPsME2iJ?=
 =?us-ascii?Q?xd7SJXCw3QAL59BTbbKSkpljQovXXEyFs2nUVcTkQ3w2XNILJAmEwx3NDT3o?=
 =?us-ascii?Q?/gtmqvbFVZjEk60ud+03rGgWD61fyc8v96PI8azjqZ6fVOgMZD2I9SdVxq40?=
 =?us-ascii?Q?uvhfcQ8FDjr2XKsYl+jB5brg48THAYnNcjGErQ1Vh3griB7wovTg2H36cwd1?=
 =?us-ascii?Q?7ozu3yx1SGr2b933zKbsQkGmAPo+EC6Oho51YcxXD7HHAs14dWflA0pnBn4D?=
 =?us-ascii?Q?CxoXrF5h9Kwnw6txNCXQiiCgJjuch7Pan2mEgLjAPXTI3bbw10O74kybvfFe?=
 =?us-ascii?Q?8qNHlsGAWFrJvU1wDXIuU55ptqZZDtXNR63VStb2hAcih2B7VnOZR4h7JpQa?=
 =?us-ascii?Q?oxG/EmMFczTsCbzJc79Y1dEefMs1ZB8LSIFgKRvse+iRfjCVOCrgjANIXaBY?=
 =?us-ascii?Q?j37Bs1mfGJyBdytT+6m1kD9CGJ0Z8SYJZwaBGkcm8co97iDGm10C6wfTerkd?=
 =?us-ascii?Q?V3w3yvhC12tFQy3s7ZLFJVUB5rMmCr8kTvzYeRruDXMHEVSEEXqTaHnAHY8X?=
 =?us-ascii?Q?Kb2/GsIOd9PfoAQqCaqS+AMaR7+eKd8G8tlKwOwsjZfstgt+kf05pJpBiP62?=
 =?us-ascii?Q?3WI2+SMDyNcHboItbwkmsgARP0Fs58OhSwY9QLQv5IganvfU9WYENE4sp7F2?=
 =?us-ascii?Q?q1n6M9zp8cizYFr3PybwOljY7oqyqdMe/dJo1zB6Ds8sKbtU30dvkKFxm0qv?=
 =?us-ascii?Q?QC7RMTttWQqFiA+AxYyrmcnQX8qVOfrZGrvs9Z4NC00B2dH62OCbCwQXbE/R?=
 =?us-ascii?Q?RzzBNJA6ENTLKDl11cA8CFIMMDlN1SymFlW4FH/tDLTzPAeEsKkGerk+J5Uy?=
 =?us-ascii?Q?GLSsErPCYFrfiLDm0RnqEoGGKkjgtwK0mVnTXAH8WrbgJIKEMInPtw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LUeh89Cd6M0Wu+pLUl7nv+WH2Lfv+u4uEpbJWuEJDtwB2qI8mSkM9jFRRd00?=
 =?us-ascii?Q?czmNim5XDwh52LVT5uYkCuvmy00bk7EwXsN2JmvEMcEZzyQ0lNtswXJEtLTg?=
 =?us-ascii?Q?pNJnmj76o+j6nMZo4raV/bkLDG+LA9Hl1DkFIQG/BdWzo4UWLiY0Wr92+Tbg?=
 =?us-ascii?Q?6i2W9uo3lORobV0/bzMvqzD5JGPfPggwYP/pUcJddji/Pcxgx/Bu+dkP+Cx9?=
 =?us-ascii?Q?mck7GL5puQr+7BYvbWtIrdL/cTiXak0l8JSRXYe4vg4ygV+CRuLP3vP3HrtD?=
 =?us-ascii?Q?FmxCt+yV4+NrSDWNwdWmEU0UnKK1bY2YDZtV16YVbFky2LCHbF50kj5JeRlr?=
 =?us-ascii?Q?3oie04Sk8bQMcaVWpz6JoErMkjH03n9SVWOadeN0OnSrpZ8y92r10WMMWio5?=
 =?us-ascii?Q?12K9P+lgT7D+qBaJZmiZnS/sqT7ptk19I5J+yv6b92nvjdno7SoUaXRL8BiA?=
 =?us-ascii?Q?tauki64DoY9BwnUwPUl7nYgo3zavzeM4fguq62S6lv6F0k7i0ScS2bQGYmEO?=
 =?us-ascii?Q?9M+q61nJZwY9Z9ZqSXQdq4kRcKqfQSYMVo3goQ1xdgOnKRuXtwo07Or6Bebo?=
 =?us-ascii?Q?CVs4oMj58aJ+DkcQS/BBwepwXcMnWkGDGwMUQ6GVubeP6Ywoifi3CPbnO+9G?=
 =?us-ascii?Q?ABkJ8V/Q7yTEjHU58MilVNN2zedwlzCAZrYpcLDm/2ot/jUCRsdQvVd3b2VT?=
 =?us-ascii?Q?LMjslRuNEoYkhR8ItxzwMUmW7cpFIlSZw9ijr035RESfUuErSHeCrhkpi+zl?=
 =?us-ascii?Q?CVCxrhzWQor2hiMCAxtneIFWgczlZLG9Ghs//Y0+uDtTu6oE3s+fD7fW76pb?=
 =?us-ascii?Q?hPNdwQhxML4/PTziwJ9BuqEJwekDTLVMYUPvXZ8JptvIydYmG1nnualrmjh1?=
 =?us-ascii?Q?S1k27qxbGGWkMzaI8z+4Or6Dy1AqUVEvgz99a3fbhRKxokRT9j+ILwz8EOFF?=
 =?us-ascii?Q?WCsqZtUeHUZOWVAdwjQqFZ501Fmvqr+PjWHhNvWXRLn1L25vtTExFYHXeF10?=
 =?us-ascii?Q?0Ykuj3Dtk6Y8gvK+iou/giO43onjm6I4rjN8fUDrDU3XHHub01j6fDVOoqRz?=
 =?us-ascii?Q?mG248u6Ph0cqRg2dQwzlHNSFvk5zpz2yTU6NPGVFYDoOBSaH+JE7mX6M+Jsf?=
 =?us-ascii?Q?Z4DdIQzdGpzyja6M9S5+IjO3z0Bw1KLH4mR9kaLEyj6xFaxCBlGGqTyoZrwk?=
 =?us-ascii?Q?TUKs/H9FnT2J8dscB/ne0SWtXaNDR7Y0DYE88tFT1hA1+7seYvzK7CbDC62v?=
 =?us-ascii?Q?kfuYZQLURfUirsEnOzAzctSoQHjCHxP1Hy29B637ZiUVp1XqBUR/heFWEa1q?=
 =?us-ascii?Q?dEdZA93X9a85jkMWnxcfWiok6QGdMIoe7YxO9tkYOIPRlACCUMgJUsxv8H3a?=
 =?us-ascii?Q?0xj+hOlZSpLKsCVS4n9tCthVNlO6rkprEFq0Ojtt2yWeMfLlgUEqNx3689GE?=
 =?us-ascii?Q?jCzTzBX7R9CcAmFvAuIHi0N/aDUCznQ7RI4MmKvBOxPvSWYreJcrcR1GA9gR?=
 =?us-ascii?Q?MqNF8+HiTeLNsMnseMtTUJzSFw22fElIKl0VJRkDkxBNVr9zMPjcNjqeRHZf?=
 =?us-ascii?Q?qhSVoSsWf0TimvG1gBzCRbsy7QKpwLdSjAVDHRTO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 477819bf-1d1f-4f5f-5cce-08ddd8e1e426
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:18:06.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M0lbfisaMyXNSyJteQYMUSnbwwQ//SnZgWCvqY4WtRXCuPgyVsgb4Oxa6Z8P05VtbQlHngRovhAt+m4iXs1Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8097
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> If guest memory is backed by restricted memfd
                                          ^^^^^^
                                          guest_memfd?

I'm not sure what a restricted memfd is?

> + UPM is being used, hence encrypted memory region has to be

What is UPM?

Ira

>   registered
> + Can avoid making a copy of guest memory before getting TDX to
>   initialize the memory region
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 38 +++++++++++++++----
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index bb074af4a476..e2bf9766dc03 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -324,6 +324,21 @@ static void tdx_td_finalize_mr(struct kvm_vm *vm)
>  	tdx_ioctl(vm->fd, KVM_TDX_FINALIZE_VM, 0, NULL);
>  }
>  
> +/*
> + * Other ioctls
> + */
> +
> +/*
> + * Register a memory region that may contain encrypted data in KVM.
> + */
> +static void register_encrypted_memory_region(struct kvm_vm *vm,
> +					     struct userspace_mem_region *region)
> +{
> +	vm_set_memory_attributes(vm, region->region.guest_phys_addr,
> +				 region->region.memory_size,
> +				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +}
> +
>  /*
>   * TD creation/setup/finalization
>   */
> @@ -459,28 +474,35 @@ static void load_td_memory_region(struct kvm_vm *vm,
>  	if (!sparsebit_any_set(pages))
>  		return;
>  
> +	if (region->region.guest_memfd != -1)
> +		register_encrypted_memory_region(vm, region);
> +
>  	sparsebit_for_each_set_range(pages, i, j) {
>  		const uint64_t size_to_load = (j - i + 1) * vm->page_size;
>  		const uint64_t offset =
>  			(i - lowest_page_in_region) * vm->page_size;
>  		const uint64_t hva = hva_base + offset;
>  		const uint64_t gpa = gpa_base + offset;
> -		void *source_addr;
> +		void *source_addr = (void *)hva;
>  
>  		/*
>  		 * KVM_TDX_INIT_MEM_REGION ioctl cannot encrypt memory in place.
>  		 * Make a copy if there's only one backing memory source.
>  		 */
> -		source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
> -				   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> -		TEST_ASSERT(source_addr,
> -			    "Could not allocate memory for loading memory region");
> -
> -		memcpy(source_addr, (void *)hva, size_to_load);
> +		if (region->region.guest_memfd == -1) {
> +			source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
> +					   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +			TEST_ASSERT(source_addr,
> +				    "Could not allocate memory for loading memory region");
> +
> +			memcpy(source_addr, (void *)hva, size_to_load);
> +			memset((void *)hva, 0, size_to_load);
> +		}
>  
>  		tdx_init_mem_region(vm, source_addr, gpa, size_to_load);
>  
> -		munmap(source_addr, size_to_load);
> +		if (region->region.guest_memfd == -1)
> +			munmap(source_addr, size_to_load);
>  	}
>  }
>  
> -- 
> 2.51.0.rc0.155.g4a0f42376b-goog
> 




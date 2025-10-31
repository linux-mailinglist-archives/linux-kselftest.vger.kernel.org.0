Return-Path: <linux-kselftest+bounces-44519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF73C252EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 14:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF563B4E31
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 13:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A6933FE0B;
	Fri, 31 Oct 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cawBsSfr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68828343D72;
	Fri, 31 Oct 2025 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916091; cv=fail; b=H4Z2w8jxl/4vgUi8SfgXPYCCHrH1mVK89BhngxDxEzqJm/SzivoL8AJXkDvH8gb3ILx9rVBNO22VAbjkPQxurPUyjCgCNF6jejOzHco9MK7TbCA6azfMqWH8S4Qm9zR1oJnUjfSClST/YtqgmoUoXN7uDaPqrfo0DsDEswXeN6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916091; c=relaxed/simple;
	bh=15v9+UTDYbjFisMe+c5bZjbU7IQquqDB5uDU2brYCy0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dQEbVlqP4dVrx7iW20OAttcRiMlXpD1Cg6XlK0q5tVfIdGtHQWnBBGppvgtaTa66c4sD1nwHFAFcM+WaDm0oU8i/66+HBfldO/ls8s4LQfj7UniJswDX5CxiFNfPvvBDUYhLL/JTibG0HDvrnQk+oqvt6afFq428Vy6GsEelG8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cawBsSfr; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761916090; x=1793452090;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=15v9+UTDYbjFisMe+c5bZjbU7IQquqDB5uDU2brYCy0=;
  b=cawBsSfr+TzsABtzo7MH65Jn33zkyMkSysDBMXZWWKiTtHkhgOLfhe82
   +hH+le1D683GmbD15Gz7BIvoYb0bAqwvoiHzYxJobahDo0xcpuiAaMhPJ
   aoWNj4fbaPBZLIThr3i+eITAmZgFCkd8Kcy7UED/IFIO57evcmxhZfCb7
   7geyA83RV3Ln6z6RpjvsTKSZdNborXZYrGI37uR0BKmVZGZNOC0pBtow1
   efmeflqXIiR5nEnOwv7xPGiXF3aEMaGLF7g+HZy1HOlR2vMEQVxS1JPiZ
   GDXTbS894vMOQYylSE0dGjnZcQn22ArVaNiE39mLQ+kPJusmiqo0N6wyJ
   A==;
X-CSE-ConnectionGUID: hhyJl2EWR/e8YQRLiBQvEA==
X-CSE-MsgGUID: CO1o9W6KQL2rhIQZmZ76Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67731987"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="67731987"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:08:07 -0700
X-CSE-ConnectionGUID: YLmhf4pDT36yzqbAErm4fg==
X-CSE-MsgGUID: oDiP6rgYQ2G0GvkdDZFPKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="216888503"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:08:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 06:08:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 06:08:06 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 06:08:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vf6W+slEqzsdeLxRq9S/0COmfoWBl/gbBd/0GPlmLFsqTednf79/SFmjI1AlOzkDb2e5ZgU98EWHPLYbbQsvWGh04Nf8BCctPtzFR/b8cfrCOn2xB+oReStdwLexBOChjFoLrfZpdNSGZUcmZh1zBT462HxARxnX4IZ/YoZnttm/m4dCq6i1r7qnfBg1xIVs+DSdEO/ldP7YSrUZY9wYGFJLk/r3D/YVNz1ERvZXRx4J/Co39HpABkyqsf5I1sqGPHTXQX3kB4FSLEXx/EP9V7vnGSFchWE+ROp1ZEx4YvByxee00qWn8DCgLaZTQNj3YlxglGJ5jFsG53riCtzu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXaGXT/8Kblzlq62G9rZcZegpy8vPxJ871TrV1XWaI0=;
 b=pzqTbA92mm0VGGS6C6Y0pPFAdpdluMgC5GC2LbuLDWBletlGG8q/cg+0nlcUKmF5rgRLb9q7G/xRMc8RVGmuTv8LKx4cLXd3OFvnG3/DvUjE8XtKZ6G43dffQ+9/ogB7hwz9PFb/3tSd9+r1tPJvRZVr4jkE0n99U8r0GpC50VTPdeTgiOK7mzM/lPTF38bZYGBQfDdYVQ1lF2s0ShT5WKX2t4f7Jjgu/hOVKjNOgGSNCStpuJ8GL7kltyW5ozupKjJpLJp9sJ4v+oTtoP7UAFdr57fZWccljwsiycaBBu599dpdtHeoMG0iYI/fsUUEqHdxd2MVKjFAan8vsyUfiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH7PR11MB6606.namprd11.prod.outlook.com
 (2603:10b6:510:1b1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 13:08:00 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 13:08:00 +0000
Date: Fri, 31 Oct 2025 08:10:21 -0500
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
Subject: Re: [PATCH v12 19/23] KVM: selftests: Finalize TD memory as part of
 kvm_arch_vm_finalize_vcpus
Message-ID: <6904b53d3e090_231474100b4@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-20-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-20-sagis@google.com>
X-ClientProxiedBy: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH7PR11MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f2f499-f5bd-4461-b7af-08de187e8486
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ymvbnRgpi/NYlwNEeJu5h9V3cc/RSHLmTew+K29dE9C7/WMUISEjT7Bhta5Z?=
 =?us-ascii?Q?JFXvgwf2eXOaK5sFSDNGC+RhgmfnGh6LF1xFFrrYhZGEXq5tdd6sAWSwHIjl?=
 =?us-ascii?Q?yh0Jkb+/8elDHBS9trevXydK3QpShZGXXQLbLYNplSpQvxP4U6/FNUvDSUS9?=
 =?us-ascii?Q?YTJUkQaZ97PSt5xThZPbAF8MsuWI3U7emL5ArDRq4v6+96eeIC75t4hMw0Ra?=
 =?us-ascii?Q?b5QzjtAn+LxfApvrfqYkwf2gjwSTVWSZGLYvUli2x9B2ZCjpLG6bgALWOHD5?=
 =?us-ascii?Q?ZNzy7pfR8S2mAqTEkb5ZNc3vd87IQcVdVvGuqomoB8aHFGTyPtgTa/pVlDbV?=
 =?us-ascii?Q?xcJu32ThjC6YkGQcGpBt8snYMHNYrnEVTFU2lBYrKfidlkmCv3abBphdn69F?=
 =?us-ascii?Q?PF7nmrtusH1QqlDCTz1m07Ike5Y/DLQad/ehUh5MQXeDxVl1FnKk4z27IXkj?=
 =?us-ascii?Q?mCMpfAiL+U+oKLjp3zWo7clyRqrjXg4RMyrpdhPLB4Q6BIgLdiKjWBIl35WQ?=
 =?us-ascii?Q?ML2i0pUrx3vxOdMmXKE9LyvYEkxpfFl9gv6sNUI5hBj/CivwumLOJ2tTU5vD?=
 =?us-ascii?Q?DUWad9rtMOOUVYj1ENYoXsDTL/u0jHGmW8x8xCW/D8mKRvqMDe3hi2Om2v3T?=
 =?us-ascii?Q?CijWbHEZ1Uze9kpbSW+L42me3Ihe7wBny/ywDN3Q4xsJheK9MJjRmEodcx2o?=
 =?us-ascii?Q?d6fcy4soSL2SrwzrBGxoGITE1U+BeErJR57IPzx8LmglzhS4PoUzeB0EY1R/?=
 =?us-ascii?Q?S5Y3HamT0JB8/GQkXHJ9KicCrLnoZlJueuzy2XYgYnPjRC7LOtHklEDJ9H+l?=
 =?us-ascii?Q?tlnQYheekcT1bPhsOfnMqZSHhLh9w24hAPDM1SKsjodiBI7itJWczaNTtSYc?=
 =?us-ascii?Q?L/cWjbxCB3e71ZU7HEpOtQg43Yvg82JI+LskF6OFbSY8Ybi5emrIAcijOy6Q?=
 =?us-ascii?Q?7zSqPOJI+VjOHH4Z2VNZsGMG9LM9E76yokAvYuw1rmv1tKDbEHeS0mobAsB0?=
 =?us-ascii?Q?9Hsq0iHBYThnLj3RuFOvySaQf++qvAVnjA1RiWDr5zvmjEGvbSteq1BLYC3E?=
 =?us-ascii?Q?Ic9jIESn7fgZC3NII3HI1/6OInggKiIZrEznMgrgxhGmRkLSuqFRFJI7qq69?=
 =?us-ascii?Q?o36wfGor0EUz3G/lqVYOCxyebEKzMF/6ezPqLmHYLjUYF+kzjl+leWg35NWG?=
 =?us-ascii?Q?MslOI88DwYjlQLrNlwf7yb4XRTwLLls4ERKd3YS27NU6vKNs82LdNZY0APSm?=
 =?us-ascii?Q?GnuNMzPaQtHWzdwEQj4ZzBcB5MdTJmEXvpiwLTPzDrUJujHvEygq0bIRHDZ9?=
 =?us-ascii?Q?nmfejRjHmgP7FZHUzkg6wa/VLM0wzpTjtlYgP8B5tdZAWu5Ux4hwiNSXokKU?=
 =?us-ascii?Q?L2qLX9/0LCf78vDHJSTVjo7k1MnTJRg72X2lu8HP/rvILboxr8oMCFEZ3a4P?=
 =?us-ascii?Q?wX6HBix8O6/yBAlPvksxsgznyjzT1VrYPoRXOZt5D4zICyLgZ3nN4bjCTuXv?=
 =?us-ascii?Q?bCyQHdHxDiKbxPQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xTo1f5L7ZjokEgZb+GpMapPwCS1/ojZtWAP39zKVEEC580c5eIwFF32Ok0LC?=
 =?us-ascii?Q?dmXqso+oVbFsRKSt4aY32zUjPWgtfIDsefQ/4kGE06dTuk1rttFNgt+qI7r2?=
 =?us-ascii?Q?L1zy/ewdW3uUpLRyfXE+YnUJFJzTzU3iaFWgxMoAUNbyZ+xFJ7f19Oeu4S+E?=
 =?us-ascii?Q?lqeB1JIcQJ5sCE+W/dw8a6cBGdWidNrIrR2mRzcfXmHezRBIqMM4czIjY19t?=
 =?us-ascii?Q?xBx038zd9t6to0SfkdrxgTws4JD2c61hUVbWHR8zb8E5LGqG3A3mPqC1/Pw9?=
 =?us-ascii?Q?iKjXsCgvmCwhnfRtMH/xuGBUAxRyFazLHEHzBDfY0t898gJ3rsCFqd9wdD9P?=
 =?us-ascii?Q?0wabYGrTHzzYldkCL4dG6kTAcNphJjVAa8BUBNMkPSOfmSRrSMLj+nfrdBJd?=
 =?us-ascii?Q?0SHQE9qmz5Fs4CakPasClNtog/1YrU2HJhBR6TMDzE4Lvo9c4SPqJkkboPRA?=
 =?us-ascii?Q?7fEoVBY0K9QLft3FUIc6Uy7UG4U1AiP5fZ8lsIE0B37k4AQ6Xdqi4bC7zqRX?=
 =?us-ascii?Q?dZZ1J5A4P8JioHHNIh12D9GKLa10jgc/jRRY8GZn4v6+r8KtH3EqOtOT0EKw?=
 =?us-ascii?Q?dl5Okt7sNS3BotZsdRxMSELD4sDv4o1ygwYO0OglZRR+DR9fxoRHapEPpt6M?=
 =?us-ascii?Q?FR/lOhmNjGRQsDomQzfuyhCppQzGmmyoYw0TCmbkWP8zO2/9JMBJepHyaQ3H?=
 =?us-ascii?Q?KkNBbdju/n+31hytRGG22Ug/6V5iSXKH5M3JppMfOtoq1gI48G49j8awgD0t?=
 =?us-ascii?Q?g4MynXgwVRb24RchcQ/QUv7tJ2t/oXjbYNoaEKr0QNdVpFgLO1yf/y74FC61?=
 =?us-ascii?Q?fXqv5VVmoI+OgcoDOxdUzjUI7IHN/GpmHcSw9DPTcHNztp8027mqJfPF8PAB?=
 =?us-ascii?Q?eI/vBJxViiZYnY6gES0sfQTSCAAZkeY5HRQLxjI7PccFwQr2TrsITP0unVJ4?=
 =?us-ascii?Q?MHMly/RKZ4avlQuagmcCLwcZ8yGCPwFLa9iDBZFZDcUpb9C43qngiYotoIx6?=
 =?us-ascii?Q?mI7u2sMl6JqD2mCgfxGC1idwgcyqw5r+kqI3uMb9fJtkXE41pVXhH80zV0Ss?=
 =?us-ascii?Q?C+Oyb0maN23zfzNj/ga4g7XuRp60enOdZLcC3Gf1T12ZLSK1Qxq594SBr6Ud?=
 =?us-ascii?Q?gEaEvqE17c5lMd8B40E06Pr0c0v6MlC83rEIYvbXBCUUsj/oS1muDTQs7KNT?=
 =?us-ascii?Q?5QviKlV+Vv/vShOflr29+4S19RKlr+Pj2mHwkcugAMzbHkps4j422KRGQs3P?=
 =?us-ascii?Q?kA09IqVIqVrVx0LpRVgzWxSUTwmT5wawVQE4c1vSlDB3McgGLXEwltb14XcG?=
 =?us-ascii?Q?YT7hKj2WRoIC+XWzyO49qAqRiH1dN7a9Gy5s2AseU7344lqPHcvSBVhXepiu?=
 =?us-ascii?Q?PTKOdpQjBcfBTMO3Gve7FKFRqbifZr19KhVOyQ5pzT9SbVEduQKqL6iI/G6J?=
 =?us-ascii?Q?LOVxE4oPtQJNH05Wb2EdwsqNvqZp6pCvhdXxrPsOPT1DeWuXyHadtfETiwS2?=
 =?us-ascii?Q?GzlQxIRTWlPMAkAj4OeEthWOHyYZaH9n592UcILbX9dJT4Qr0lmz2S4MH8M8?=
 =?us-ascii?Q?ZoxRpfK99CwHy5ZgD4dfpUwJf/b5vl7SZJNsqKEX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f2f499-f5bd-4461-b7af-08de187e8486
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:08:00.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mXnH8Mm9RBhQpPD5Y+Fdt2BsOnW4wts3dDj5n6zlt61+irHDoS/HFNJPYOBBiDMgrTxmvgDaXuTeoGpJ+ZVHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6606
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> Call vm_tdx_finalize() as part of kvm_arch_vm_finalize_vcpus if this is
> a TDX vm
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]


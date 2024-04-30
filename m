Return-Path: <linux-kselftest+bounces-9113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D1F8B6BE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 09:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7582D1C21FFF
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 07:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17EE3AC16;
	Tue, 30 Apr 2024 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBMIWO/w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4238DFC;
	Tue, 30 Apr 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462465; cv=fail; b=dgj+vF8b0V0JwV/B24OsCLSr7WQ13F+Slh0MWPE7kmXpEOkSMC/75CHffwbKB1VjnHusiKGNEhXtMKmnJoXfkarvv59AeuQQCJhUwlwJq55oXnC1m1tojLmt0aN5/dpjV+6YSrNuHkmbjVzJg0vWTeODEqcrsUbI1ZpKY3+45U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462465; c=relaxed/simple;
	bh=WH2IzzgtwxBncPZ5zmuZCzkJq6LYTlJ58Iz8OXXECCA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mQw4LBhWVVOEmeOGPgz3qallCDqIksh+npa997DtoF2wIvzCJAprfnwVKimvHMT/9oU9cW9kh/MeLqyls9s5R3jp0IBUKrp9bkSW5DlfhIXtbwHZgXrnDHlc90nqMIbt5erQ+2tOhf82PjM/+kE7b5g8w0jBHBkmNtHOGnJf0+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBMIWO/w; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714462464; x=1745998464;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WH2IzzgtwxBncPZ5zmuZCzkJq6LYTlJ58Iz8OXXECCA=;
  b=LBMIWO/wfiFspbPcgVvnz7LChtB/Ah6XPbeSqMAQUZ3pEUilzpWu/xXm
   up91Y16YYu310B5AXp35l+rtfSBbveWkwyERFNEN9OYPKPJWh86vIZVLl
   CHb1aaWbNomUppPLKsPtQuYpOk81gXqrMaiMSoblYLx36bVSGHK8cnrln
   8ENsureNJtwnrRjvNbB+qUCP/J895GEmZHu8TQPRKn0mhcaUOSJYElUxJ
   4xzh9BcO+R+a6Mt8O8kLdTGapdYyaoHl/Lhn0if2svf5wddKn+gUG+XHX
   Cn5R9rnuub8lZ7E4fRLMFEzp44JizpXpsk2A5hApQ6Q8NvkZh4/uyF4CP
   g==;
X-CSE-ConnectionGUID: MISD6PuTSwiq+lDvPPf5ig==
X-CSE-MsgGUID: 6HsmQtgdQUSDJDbRIL+5iQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10308178"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10308178"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 00:34:23 -0700
X-CSE-ConnectionGUID: HMGDXy1kRF6nc3t7WYcAuQ==
X-CSE-MsgGUID: ffCztrWYSDmwojrSpUtJvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="57251609"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 00:34:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 00:34:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 00:34:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 00:34:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 00:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edQ+JwFdeycyn4vFShGc7kr2zaNdC6YiHzDgtU+6Abez7MmkWzomILsb0hnaYUvu7+Yq8BmGa6UM4f1A+pQe8GPqUQMWVuzSGYNMOc0mx3jjPO9xcd1fqGK3lAisczTz2pYgNvATZDvCIxuHafgW7zLUTZnnBitByo2tPaWI59lFuZ9uLBNbXxisSIEvT9iPzlEoAr7bTIrazGit2U7QhzPBxK6EvzWz0vvtsIyJ0bJJu7EvKrxNNUmj2p62IGNAGBAUni3JinHnJeOFpJXXlcN81NBtIrUW1V/5NOyNGOlsjNU93vHAC6Btf9q3gw3LksQzV8DmE4qgftL+zGyCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VA6s3Rjcd5JpWjyUbZKkSBGM3wG3EohyAIsoM0g3jTM=;
 b=eP0DWf/tOjmhpfwhlKwEzPLi1Dc9zm7xJJhDUMxA7LEBVn2gUnYIFTeIF43w7brSFGPwmtgdkiHpX8C5OWCDqG5TK1RzP147u8gWh6xBty81qGqFfGIVRLR5AEue/Iwo72/D0BMq/UKUmLlatT2D7ZFRw1Xv349xB31QVgboINl5um276U1LpeaX7rleNJlaUo+e3eCqq+aoHkqulnCp/W/bHWaHjDezDi/DflkB+aZvBA2BV98MwGHyzkpjFzn1V/uYomy02Qx5G69dIGml+e0POTP3qxnZjCHPYa4boAOQ+TEoC0PXNZPtXbddcJVC17VA1074k9WvG4/i0X5P8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CH0PR11MB5265.namprd11.prod.outlook.com (2603:10b6:610:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 07:34:20 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 07:34:20 +0000
Date: Tue, 30 Apr 2024 15:34:08 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: Re: [PATCH v2 13/25] KVM: VMX: Handle VMX nested exception for FRED
Message-ID: <ZjCe8HGMh1D8KXdD@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-14-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-14-xin3.li@intel.com>
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CH0PR11MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc2f092-f655-487a-79f1-08dc68e7f2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K2f65UZlJ/oHPn+/IW5XsuAAk7P0/54lp0EZ5rmy93zLWn3LICJuZzV2Xf6V?=
 =?us-ascii?Q?anPTZ5TZ0eaGiLFv7Cn+EnTxAld0j/DFFoF+pgcKhpJblBQqhQnjjjlgrzpu?=
 =?us-ascii?Q?TKu1MoT54flM+HLq81hZkaPbQW0yFnMnnRJMit/VDkTYTi5W3fUV4ZboTXEZ?=
 =?us-ascii?Q?OgXVloAmtae3qgJL58hVv+rPZgAG0ac1tNf6ZnllISCxbNQNEAEmmy9d1t6t?=
 =?us-ascii?Q?t5UmxlXcVON8GTGrKC1r5drQUX4HrfNFTiwwWe6You+4wFOR0vX501vgaDUB?=
 =?us-ascii?Q?Wh7Az4+QCt0ivb7q3ptccP4ebBT/b07DRrozkV+tWDUqXKYjBNPjX+72bdf4?=
 =?us-ascii?Q?gB12XAWCKxikkgf8npe0AE5JG4ui7ST4QH4aGkbhqF7CjPvTDArl2aAl9/Og?=
 =?us-ascii?Q?sNvvc+13jVN3a+CjEbv+djx1Z/mPLPE9r4qzu0//mA9JFNzSJqQIM2J9ri80?=
 =?us-ascii?Q?jgIK8IMNg3l5ASCU8I6qcFCSGkqsDhTkWgy5FXurzdeYtsY9cum/xZCuoinC?=
 =?us-ascii?Q?2loYuKValvx+0huWZmd6KxtMvAAtLPGRao6otqUj2ZAUsJhs1n/VDw9GiuMw?=
 =?us-ascii?Q?+rQQUV6S2nYqmA+8+yJE2OOsGBiQS//9J2kHzwtL6rqPD8fPz8YjUCemKApH?=
 =?us-ascii?Q?1goswayLtxE/QKOrU9yviZ4VBJBf/mFOK0JJaql75PGdSt2eOC8zl0Iur2U2?=
 =?us-ascii?Q?k71ikcMiEash37SGt+HjZTle1BrQeWvncq91qLtVxNYIni7D77DjtNlvESal?=
 =?us-ascii?Q?EJ8EV8DgVHcU98TJI+MN0Uw6wtaDOQ9sDzAQm77CBw5UDc8zKXRtFijlwzTU?=
 =?us-ascii?Q?zuGu9mz+CzlYXcVPmc3tpWTK6S88CTlx5iG5PDrk+ZdWb1K+yffxQqUBWbCu?=
 =?us-ascii?Q?NcM6SPoulT6JThkMGt8WdvEXM3HR0UvrEO0A8cQA4Ua7INSRNy8XglZdCNGk?=
 =?us-ascii?Q?5WLCr7ec46XXpnvfOYcqGqG3FmESTRoDylDGA3mklPu3TFk7s0eWx5znvvOI?=
 =?us-ascii?Q?B6PJju+X0Naa5woW0aEn3D4GNJ8s9MdxVWbdlWgjvnEyPNBBXcgNqYqcSW2R?=
 =?us-ascii?Q?Gh5TRVNcLUh4fbaBnyS3PQnBsIVUhV/jdTGrO2kQSGUKbo0UX2qeO7ZMaRiG?=
 =?us-ascii?Q?Hv6m8Z1ok4+a5c6AnSShHqBqIiave2JGCAfNUvv18N+Cv7I+f3qk5JbY+twO?=
 =?us-ascii?Q?gy+9TfOckcOcndzSV217H3eRQ7HuG5pbl4esZxUlMM1Beyd45hC3EzWS+TVe?=
 =?us-ascii?Q?GwKfOWnuUPqu13Kxh4o1xYfeYFwE4+8hVKOmEWbISQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1zRLIKjqnsN6oXwY2udWb1pj16zX6yg/UiZYm+7hRMmAUpmrgP1nU5dMqufF?=
 =?us-ascii?Q?LvmfIkZLNDSxMSJfCXTa+/PPjmCxqnSe84A32YZBlw7abhhgfTXcyqOgFO6l?=
 =?us-ascii?Q?2DPvRt+jXIL3t2VfcQih7SfXDzAcBMSfg2zIty8We+cxuwvB4iL7H/bdSnvM?=
 =?us-ascii?Q?UdLC0BiwEstmRt5juAq5Ya9L25VqBaJSUiHuHHS58zHi6gUdKagFpnK9CFj9?=
 =?us-ascii?Q?+RkY1oo8cj5esbKgMNnucTsXhZU3940S62ptBFm8OYkCxALukiqBjsh78LHt?=
 =?us-ascii?Q?skj8ZrvIbSLkrs2GayjTq2vzT85ytCPiY75QULrY1aB0CeyTli7SS5pX4DOM?=
 =?us-ascii?Q?PuUT70xASepK84ZWMIy3FruBujqV3qvvJZyguFlgfgbDMEdMx2LbEaoP4nRR?=
 =?us-ascii?Q?S20GLYJgXMeQkHK+Mp5i1hJivyePPry/6xVIB5A4h9S4p7M/4AqfeKbMA6Ei?=
 =?us-ascii?Q?V2aHAeiZwAsqc0IBzekqsgfuUasDU7q0Zf/o6pcXKGvx9PqwEML8ANxkS0Oz?=
 =?us-ascii?Q?rDd+JYR7GD8XbkvdqVfdPjnvZsNKH5TD3PJ63buYl0KXUqgrR8n9ShRVpoYx?=
 =?us-ascii?Q?ECL4vqpwyTGMDxCXEAtFc/TRerP+ow6uIhNXUx/ZBAYf3XnZSZFhJ8RL1/Eu?=
 =?us-ascii?Q?GPrd7Vk1DRJZod0V6fVPaSyNlaYLjXRc49lwwrZxZ5Tcph2/rpWPBWtJy6Po?=
 =?us-ascii?Q?fQd0R1RZOyGn55OROgruWzVPA21cRU6G2c85Odqce2wam41yDBGJkv7PSV9H?=
 =?us-ascii?Q?ajV/XvM0NHBc1oalyTZtinCPG5iPQQLHvp81cCm18pcbGnf0Flz0606PT8HF?=
 =?us-ascii?Q?nb26EP7zOUsojZoTugRfuY3clh+E7vk8sn+nyfTUlYZvNtsu3dLZ8AJyNW1K?=
 =?us-ascii?Q?46+hZRWUaMPeL+CL76N8BGbvUf5WYFcCHBQXs/UJ8kZt0mg93ym06AJ2b54q?=
 =?us-ascii?Q?9mBnyTN/AuBIdyWSPrIYqsVoDkntRmJ0iYLJOhty1MfIVXEUHgB6SGQuBbuF?=
 =?us-ascii?Q?JUvAds4HYfhq1/m+XQCn08S6gvvvKsrWa6SBzhXfn527XP4Mn86v7aq1gfkH?=
 =?us-ascii?Q?FYAYx8cg4i4OpaLLjD06ismF2jNkL5/cZ1Fm9Pltuj9jZdSrMlTzWa3pjPiF?=
 =?us-ascii?Q?+8ieLNDoFuDqDVJBdRG24iHdkRhY6BvMwqAE9FV0TIo79M/3+IHWYze84M5R?=
 =?us-ascii?Q?PfFitrZD4yov1GyrqHI8g8T5HauVwQQQBeB7GhuDQib7QkIRLKehSPeT5F6F?=
 =?us-ascii?Q?vBHSDEg2QpzFj75VTkaVSpk9kJsSOPhYVjEOg9ysokFmrlBWH+W9um+7ITPT?=
 =?us-ascii?Q?GKf/pOAJ+Xdy9HQ5F4vE0VZ3AIf39Yyjsd1P77Zyy7pvzY2aISQzKfMQASc9?=
 =?us-ascii?Q?NswbA+tY46K02w6mPiCr9pj+Auc8LKC5DwUhvtdEyTLAGXA3b20DNG+mYtul?=
 =?us-ascii?Q?V2ycJxTMt0Z4KggMPaLrC0F0O3wDn72K0s9g/w/WOZT2lC2U3j+/lDxKtzwQ?=
 =?us-ascii?Q?pjt3szB4M6r921KNQ1imNXa1ZayzPsjPqGLTcnV42NAG7O5qBN9WaM/s9ptu?=
 =?us-ascii?Q?IaZyuuyiYnqeBXBh168eSkTOYUXUqn+WQti/pMVC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc2f092-f655-487a-79f1-08dc68e7f2ce
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 07:34:20.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uew8NmEWpknhwn5E10XYn8EINs8jE8EdpqF5VWiGrSUPRcD/Iiw6IVp55f2foyHZ+Uj1dGl+p0STe2HUTMGY7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5265
X-OriginatorOrg: intel.com

On Thu, Feb 08, 2024 at 01:26:33AM +0800, Xin Li wrote:
>Set VMX nested exception bit in the VM-entry interruption information
>VMCS field when injecting a nested exception using FRED event delivery
>to ensure:
>  1) The nested exception is injected on a correct stack level.
>  2) The nested bit defined in FRED stack frame is set.
>
>The event stack level used by FRED event delivery depends on whether the
>event was a nested exception encountered during delivery of another event,
>because a nested exception is "regarded" as happening on ring 0.  E.g.,
>when #PF is configured to use stack level 1 in IA32_FRED_STKLVLS MSR:
>  - nested #PF will be delivered on stack level 1 when encountered in
>    ring 3.
>  - normal #PF will be delivered on stack level 0 when encountered in
>    ring 3.
>
>The VMX nested-exception support ensures the correct event stack level is
>chosen when a VM entry injects a nested exception.
>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>Tested-by: Shan Kang <shan.kang@intel.com>
>---
>
>Changes since v1:
>* Set the nested flag when there is an original interrupt (Chao Gao).
>---
> arch/x86/include/asm/kvm_host.h |  6 +++--
> arch/x86/include/asm/vmx.h      |  5 ++--
> arch/x86/kvm/svm/svm.c          |  4 +--
> arch/x86/kvm/vmx/vmx.c          |  8 ++++--
> arch/x86/kvm/x86.c              | 46 ++++++++++++++++++++++++++-------
> arch/x86/kvm/x86.h              |  1 +
> 6 files changed, 53 insertions(+), 17 deletions(-)
>
>diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>index 0d88873eba63..ef278ee0b6ca 100644
>--- a/arch/x86/include/asm/kvm_host.h
>+++ b/arch/x86/include/asm/kvm_host.h
>@@ -736,6 +736,7 @@ struct kvm_queued_exception {
> 	u32 error_code;
> 	unsigned long payload;
> 	bool has_payload;
>+	bool nested;

"nested" may be lost after migration.

> };
> 
> struct kvm_vcpu_arch {
>@@ -2060,8 +2061,9 @@ int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
> void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
> void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
> void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
>-void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned nr);
>-void kvm_requeue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
>+void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned nr, bool nested);
>+void kvm_requeue_exception_e(struct kvm_vcpu *vcpu, unsigned nr,
>+			     u32 error_code, bool nested);
> void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
> void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
> 				    struct x86_exception *fault);
>diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
>index 6b796c5c9c2b..68af74e48788 100644
>--- a/arch/x86/include/asm/vmx.h
>+++ b/arch/x86/include/asm/vmx.h
>@@ -134,7 +134,7 @@
> #define VMX_BASIC_DUAL_MONITOR_TREATMENT	BIT_ULL(49)
> #define VMX_BASIC_INOUT				BIT_ULL(54)
> #define VMX_BASIC_TRUE_CTLS			BIT_ULL(55)
>-
>+#define VMX_BASIC_NESTED_EXCEPTION		BIT_ULL(58)

this definition is not used in this patch.

> 
> /* VMX_MISC bits and bitmasks */
> #define VMX_MISC_INTEL_PT			BIT_ULL(14)
>@@ -407,8 +407,9 @@ enum vmcs_field {
> #define INTR_INFO_INTR_TYPE_MASK        0x700           /* 10:8 */
> #define INTR_INFO_DELIVER_CODE_MASK     0x800           /* 11 */
> #define INTR_INFO_UNBLOCK_NMI		0x1000		/* 12 */
>+#define INTR_INFO_NESTED_EXCEPTION_MASK	0x2000		/* 13 */
> #define INTR_INFO_VALID_MASK            0x80000000      /* 31 */
>-#define INTR_INFO_RESVD_BITS_MASK       0x7ffff000
>+#define INTR_INFO_RESVD_BITS_MASK       0x7fffd000
> 
> #define VECTORING_INFO_VECTOR_MASK           	INTR_INFO_VECTOR_MASK
> #define VECTORING_INFO_TYPE_MASK        	INTR_INFO_INTR_TYPE_MASK
>diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>index e90b429c84f1..c220b690a37c 100644
>--- a/arch/x86/kvm/svm/svm.c
>+++ b/arch/x86/kvm/svm/svm.c
>@@ -4057,10 +4057,10 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
> 
> 		if (exitintinfo & SVM_EXITINTINFO_VALID_ERR) {
> 			u32 err = svm->vmcb->control.exit_int_info_err;
>-			kvm_requeue_exception_e(vcpu, vector, err);
>+			kvm_requeue_exception_e(vcpu, vector, err, false);
> 
> 		} else
>-			kvm_requeue_exception(vcpu, vector);
>+			kvm_requeue_exception(vcpu, vector, false);
> 		break;
> 	case SVM_EXITINTINFO_TYPE_INTR:
> 		kvm_queue_interrupt(vcpu, vector, false);
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index f622fb90a098..1f265d526daf 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -1891,6 +1891,8 @@ static void vmx_inject_exception(struct kvm_vcpu *vcpu)
> 				event_data = to_vmx(vcpu)->fred_xfd_event_data;
> 
> 			vmcs_write64(INJECTED_EVENT_DATA, event_data);
>+
>+			intr_info |= ex->nested ? INTR_INFO_NESTED_EXCEPTION_MASK : 0;
> 		}
> 	}
> 
>@@ -7281,9 +7283,11 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu, bool vectoring)
> 		}
> 
> 		if (event_id & INTR_INFO_DELIVER_CODE_MASK)
>-			kvm_requeue_exception_e(vcpu, vector, vmcs_read32(error_code_field));
>+			kvm_requeue_exception_e(vcpu, vector, vmcs_read32(error_code_field),
>+						event_id & INTR_INFO_NESTED_EXCEPTION_MASK);
> 		else
>-			kvm_requeue_exception(vcpu, vector);
>+			kvm_requeue_exception(vcpu, vector,
>+					      event_id & INTR_INFO_NESTED_EXCEPTION_MASK);
> 		break;
> 	case INTR_TYPE_SOFT_INTR:
> 		vcpu->arch.event_exit_inst_len = vmcs_read32(instr_len_field);
>diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>index 00c0062726ae..725819262085 100644
>--- a/arch/x86/kvm/x86.c
>+++ b/arch/x86/kvm/x86.c
>@@ -645,7 +645,8 @@ static void kvm_leave_nested(struct kvm_vcpu *vcpu)
> 
> static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
> 		unsigned nr, bool has_error, u32 error_code,
>-	        bool has_payload, unsigned long payload, bool reinject)
>+	        bool has_payload, unsigned long payload,
>+		bool reinject, bool nested)
> {
> 	u32 prev_nr;
> 	int class1, class2;
>@@ -696,6 +697,13 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
> 			vcpu->arch.exception.pending = true;
> 			vcpu->arch.exception.injected = false;
> 		}
>+
>+		vcpu->arch.exception.nested = vcpu->arch.exception.nested ||
>+					      (kvm_is_fred_enabled(vcpu) &&
>+					       ((reinject && nested) ||
>+					        vcpu->arch.nmi_injected ||
>+					        vcpu->arch.interrupt.injected));

You can set the nested flag regardless of FRED because the sole place using
such information (vmx_inject_exception()) is guarded by kvm_is_fred_enabled()
already.

I would also drop the check about @reinject to make @reinject and @nested
orthogonal (i.e., avoid the artifical rule that nested interrupts should be
queued by "reinject" only)

so, how about:
		if (vcpu->arch.nmi_injected || vcpu->arch.interrupt.injected ||
		    nested)
			vcpu->arch.exception.nested = true;

>+
> 		vcpu->arch.exception.has_error_code = has_error;
> 		vcpu->arch.exception.vector = nr;
> 		vcpu->arch.exception.error_code = error_code;
>@@ -725,8 +733,28 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
> 		vcpu->arch.exception.injected = false;
> 		vcpu->arch.exception.pending = false;
> 
>+		/*
>+		 * A #DF is NOT a nested event per its definition, however per
>+		 * FRED spec 5.0 Appendix B, its delivery determines the new
>+		 * stack level as is done for events occurring when CPL = 0.
>+		 */
>+		vcpu->arch.exception.nested = false;
>+
> 		kvm_queue_exception_e(vcpu, DF_VECTOR, 0);
> 	} else {
>+		/*
>+		 * FRED spec 5.0 Appendix B: delivery of a nested exception
>+		 * determines the new stack level as is done for events
>+		 * occurring when CPL = 0.
>+		 *
>+		 * IOW, FRED event delivery of an event encountered in ring 3
>+		 * normally uses stack level 0 unconditionally.  However, if
>+		 * the event is an exception nested on any earlier event,
>+		 * delivery of the nested exception will consult the FRED MSR
>+		 * IA32_FRED_STKLVLS to determine which stack level to use.
>+		 */
>+		vcpu->arch.exception.nested = kvm_is_fred_enabled(vcpu);

as said above, nested flag can be set regardless of FRED.


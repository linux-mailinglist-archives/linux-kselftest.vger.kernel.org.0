Return-Path: <linux-kselftest+bounces-11035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218278D68E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7531F28BDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73B917D341;
	Fri, 31 May 2024 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDpBPCxX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8C17CA17;
	Fri, 31 May 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179505; cv=fail; b=r+vqeJJ5f+/U5zcdk2ikAndZZSENi2bZ5hJuWtDGaJnCVRLPC5B8nmI8llbryHCEnRcoiXNgqUEmXa3HacJzOWQEy8U+GLXkeej9s/HqSkV8SOigpPaBxrr54rCqKXGINiDXEDerAHY/YWjLHTeTZuL0sU71zZA8XB/46SrHMqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179505; c=relaxed/simple;
	bh=lB1mmhap15g7zFinCWLWtssdomVvCzMnpOHF9zfpgaA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=us8OuFjVl2UJQT1pP53E/R8Z1F7Uyi4zykA9pVvtXAdw1rB5LOKjrBvw2O57NxggbWT6oOk7OdkB3Rsakzg8bCVubr1TyXGI+A0EOlEFZyO9Eya+RYHXxalBGcKQNzpcre5PsBuifANO0kIY3oDnXRRkQ4Ye+m6DUv0kHgANwqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDpBPCxX; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717179504; x=1748715504;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lB1mmhap15g7zFinCWLWtssdomVvCzMnpOHF9zfpgaA=;
  b=nDpBPCxXlyPs2tMevGJ6Q4wder/H+V1nbzrnrLWnPfn8tvQjqef6ohik
   l6JZPmqY+wn3KxunNyUI5878gT3p6eOa1T0dRbk/GC0app89YK3n75j95
   24KiCZzhYwkSmb6q1Nw+QaDsk0l1pn+tvyqufsi9dCNp2RSKvvlDwbbP+
   16awKMPw7AesLef4RabxXZWS2Hde3NT60Aq8zYUXtr8Csi5fIWSo2igZs
   D2B3Y1rIUg6bdx3aQyC8QpQJZ5CJXxbLsC9oYFPshh8uk36m1og4YlIxL
   yu8l7fwWYkw6oj/dWdNYd1RJqAUQ+KhiRXLEgB4qMdbq2mMOtcAqoRJxB
   A==;
X-CSE-ConnectionGUID: A0Um9z6wSwaHDyt4t8WZXA==
X-CSE-MsgGUID: 1Eb7WWewSW2n7UfebdD27w==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="24398918"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="24398918"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:18:23 -0700
X-CSE-ConnectionGUID: ZUabQ7ZnR5moGSsDy+IZrg==
X-CSE-MsgGUID: sUey8DPnQ/2ezjJNAKvggw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="40686772"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 11:18:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 11:18:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 11:18:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 11:18:18 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 11:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeDd3czch89bJfLOLTrtdLdVpdgPL4HSjeEm1BeLQpwSLahHbAvtGPzIPZitBHe1RF/Uu4J1/5GQgRnoYRspREOn1zuo+cH6256eFUPgEPe8HMAT1KF6kN7uLsWSOtsB/AaJ7GzTXuDj97Xu4ZtrkHa75kFgZfYeFplEm4Um1gt1rmtTfKHc33eaXyLNdaIiNeng1e4g5KiVVEd4+p1Iv/NR+HnJjYZaevZXLw2LARm4drxcDs+9qfa3QKzCDFcZA14d3oeW9xa9x/Smz/auqZDg4wGfsGpVpI1w3k1Oq9MBVSbSYgvv8lyGrSXPCgbRhzgNv8+482uMTaqdZFhokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdTLL7ND1RIW4Jb9X7fu2tBnchkUqpNCy9+jo2TnrB0=;
 b=e92EWpQ5tqCKoi3S5tWuDjdFsrrVaBQ1jO7rtYdnDAxPB2AlBO6aBnXmO59uhX8rdLJ1GifWPAAh9zhZPuOYI+uVgG2k6zj3yrGOUWGeAUApVT2lg+3+NijN3iRo3PTxsMOQeP8/+qDWUER3conosDUZUAhrLjUKU64ohYwty6iKn1YtJaQZTcA6fMFsHs3za5YAtxET+WuLm63rn5pUuIr7c18QTE4cO4lbG8F7NAsLAhkyT/HYz+NNBgbijGAJPgbwCICiCISwL6czVEq46mUI5DZGMX/wLkmkJ4BNRzRe8qMZ8T4ULYR2s7ndmp013JtwYQmZs7idOzcKF+E+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8316.namprd11.prod.outlook.com (2603:10b6:610:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 18:18:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Fri, 31 May 2024
 18:18:16 +0000
Message-ID: <1fa7f60d-6feb-4b99-bc3b-3dcdd22515f5@intel.com>
Date: Fri, 31 May 2024 11:18:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/16] selftests/resctrl: Convert ctrlgrp & mongrp to
 pointers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
 <20240531131142.1716-14-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240531131142.1716-14-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b57f15-dc83-440f-b6b7-08dc819e0a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXlZakxObkJENW0raGFBcTF5VzEyVVpjRHcydUluWEFVVUU3bFE1NC94WjZS?=
 =?utf-8?B?TVF6YUdrejhSNE1VdzdUSlMxTlFrVEdOQUp6QVpTY094dE05ZnU0VkJRY3E3?=
 =?utf-8?B?andtcVN5aDRhVys5Zzk4SmxnVmgyb3A5dEdPRnludUJROGcvQWRnVEZXZFUv?=
 =?utf-8?B?ZlJubUJBUC9KQ0ZwNUFwS3dROGkvMldvOElvaXdnb0FQRlc1MFNNaU83ZTg1?=
 =?utf-8?B?cGdFV1I1KzFwL0xubzJka1cxMmpzTG5DUDRPeHZleXBHL21hTmpGaFNDRVY1?=
 =?utf-8?B?UjJjUElkWDFYaXdQMXpReFUzc3l3T3k0bzEwb3BvUUhVbFpQVW5STnRhd1dY?=
 =?utf-8?B?elZ3ZG9DNGVZS0wyd0Q1TklEakJHUlA1M2R1b3JmV3pqTXUrQlVJbDFKR1VE?=
 =?utf-8?B?Y1A2Z3RZcUpuZitoN2xHbUF3SVBzdSs2NU9KTVpUSDZMRHlGRjgzSzNubjFU?=
 =?utf-8?B?dUhRSTVEZkxKbit1ZmRHY0pNMHhOOC9xSS9jOUdLUFhZQWhPNklTWWd4eGds?=
 =?utf-8?B?ekg4ZkdlbFFycm42Z01KOExidlp1SW9Ta3lKRm9MT1FrRmgyL0FSaGZvWkdI?=
 =?utf-8?B?dHQ3NWMwMHZwamxRa0tnaFBFY1BGbDZEV0taYjM3b1M0ZWlEY1A2dkFVUWZw?=
 =?utf-8?B?VEZucCtScjVleWN0UW9hZlN1Q0tGNFZTTWVhbzVBQk0remVZU3pUZXd2SE9t?=
 =?utf-8?B?ZndmMFRXWFVDUlBBcVd5UFROYzBkR1E3L3NZTW40TG80NlJOdWEvbW1ob0sx?=
 =?utf-8?B?d0lJRXNuYVRjY0dibnlKUTZMZ1o3KzR4NUlBMUU0elV5d1RZQWZEeExacUlt?=
 =?utf-8?B?TWwzMEREbU9hblZYQlNaRHBwaGpweTFjQ0ErdjM2ZmpMQXhjaE51Q041WnFY?=
 =?utf-8?B?MW15ODhlVTRKREYvcDZSK2FjOFhWOEV1SXA4d0xFbCt3N3JUYllmNTI3SFkw?=
 =?utf-8?B?akI5enE0UE5IWEpRbmxzdmU0ZlU0dG9nU0l2TjFQVTdyTGJ1M1BYSTU3V3Fv?=
 =?utf-8?B?M1BmTHRrSEZlYWZPdE00RnFXMTZUbnRpVlU3WVFSN3pYR0thQ0xpTkh5b0Zs?=
 =?utf-8?B?OUhFckRJWDdJa3hlNGU4MW0rK0VqazNNcDdQUzZ1T1M3VjdsRGJtU2tyS2F0?=
 =?utf-8?B?SHluU2xlSG5oRWROWnF2Y2ZEa21NNjdoMytWejllZHhUaEpOdnlnMmF4NWl5?=
 =?utf-8?B?cGlFNDlQZWw3eDJIZ2Q0MFo0SEFFaG1qUk1EZkhPbjhXb3JkY0ZGek4vUGpp?=
 =?utf-8?B?SzZQbHVaQUFoZzJYZGc2ano4UlFhUmlwdmxLZnI1a2hVeWQwM2tYaWJ0endD?=
 =?utf-8?B?OVpLN0hCa2Q1K2VMRDI5SXNuUlViV1AzYXIwMkJhSC9Mem5hNkxQQWRCSHpv?=
 =?utf-8?B?K2N1UGVEcWhrR3BsMEE4cVZ4cFBRNWllQjgxbHFET3krL002QURWTi9kQlh6?=
 =?utf-8?B?QlF6YXRpcmY2WXBKZnFQVDZ5dmtmYnhCNGpWUExMeVMyNVdubzlxbVNaTG9t?=
 =?utf-8?B?TndsUk96L1FVVDRIUXlFM0lObmZiZ09EKzRJY0U3VkJaNWpwZytXMS9LdEFt?=
 =?utf-8?B?Ynl4VytuaDk1cDh1V0JhdExscTRvUWFPZk5HN3lrOU1YbTRHRVZRR24wTnll?=
 =?utf-8?B?NWlzelkwYUVnSlk4eFloeEUzYWNEbUltRTNRZEsxdUhBcDVvTFU3Qjd4YjRL?=
 =?utf-8?B?OGtQWXZVOFNPdUFHUyt2OWRjekpYRjdWTERreVJTaGdHTzFJZkFHOHd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blNMN0lzVS8rbXFFRUcwaXdhdlc5bmJXOGd4a1plRnNZSFdmZldvNUtvYUEx?=
 =?utf-8?B?MGJBeUV5aldhU1JmRGhpRloxUTlCbVFZbmJTeFJmN2pINkd3YTJvVmNRWFg0?=
 =?utf-8?B?RWpGUE5XUkZVZDlYeGZFeTc1TEY4Ui9zTmVLZERYYXVGckpXcGlocUtKdENw?=
 =?utf-8?B?RDJyZTdrTFduYUdUT1I4dGdxN0hVRm84LzRib0p4ZTBJb0ZUUmV6cEZ2ZFN2?=
 =?utf-8?B?bWpON0VrT0tJb3JYV2FGOHIybVlycis1Qk9lZys4NDArYzVJTExLTG9teks1?=
 =?utf-8?B?MDJ0RjJubWVvQjBPSFFQeUx2VnppZzN3cU4vcUVwaEVVMkpsNXo2ZWtIMlJZ?=
 =?utf-8?B?ZXVUeDBVVmgvRFlsU3QwNUl1V1REOS9oam1pYjM0TXpaSzVoMFFqd1gzNnRz?=
 =?utf-8?B?cUttNHZ6eTlRVUQvTjJnYVU5eklvSTdidzZIYjBMcitTR1ErTmpoYU93VUlW?=
 =?utf-8?B?dW1yeXdPazMreEJUbXc1YWY5dUNta0ZBb2hXZ1RSaGVzZXhIL3dDL2NuQzFh?=
 =?utf-8?B?Nk9HcmZRb3ZuZFQzcDIzZnRtV3RSTlhSWmVLc2dTODVhOHUyNjcwU05oUTVw?=
 =?utf-8?B?ZlltWTJvbUdXNTg2TFlvekEwRXVpdkhTQmFFVkpPOUpDcHEvRnhuTXhlTjht?=
 =?utf-8?B?SWlNbkRyYmVlWnJrOFJzdElpazBsU1FPTXdhNXo3Y1FQUUdka0kyM2MwQXFX?=
 =?utf-8?B?ZHEzS1VPSzNpR0JPcjBZd1I2R0lSZHFZemdTanpPY3ljeENTUlpCWGpqWHR4?=
 =?utf-8?B?dHlpUEJLV1VPbVZiK1NuVWhyM0R3cEZWa3g0Ny80VlJDdnlCVmNFTGovejlm?=
 =?utf-8?B?b241MnlTemJrN1N0aDJXakIwWnI1Y3N6K1h5Q2VaeG02clVxaEpUYU1acnhJ?=
 =?utf-8?B?YkxUWEYvcXM0QWlBZ2FoZHQrckxCYkQvcTNlWkQ1QTNjUTZicnMrRTN5dmNF?=
 =?utf-8?B?SzBhVzk2Vmd5VVcrV2JSZFBFTGtEajg2OTcyUnZjazVnSlFhSlJvWlJTNXpl?=
 =?utf-8?B?Nm54V3dsaFhNdnpncUlMNTdrOFdVVHRwN1huN2ZWWXdVLzBCdXdqYldXU2c5?=
 =?utf-8?B?b1hxMkVrQ0N5aldBd3FVVkUreXl6YnFVaTFsc1I0c2podXd6cTRLTWtvY1Nw?=
 =?utf-8?B?YWorSXNHWmhsdXFhdzFVT3ZQMmdBS2ZhR2dGWFJacVFwQ3pvT2VSTkRYV0xV?=
 =?utf-8?B?cXJyYzF6RUVSbGQwbjVNSStWdERzbVJUcGZHOXBFY3l1bnBmc0tNVldRR3pu?=
 =?utf-8?B?NVhGM2lxcFNybXlCVVk3M2xTYmd4ZGNiL2tETUtFYUdPNGhOSjZrcGNNZFRa?=
 =?utf-8?B?ZjFqS1dqdFFkZVBxQlhidngrMGFUVG1TOWE5TWd6ejVwem95Y1hMbGUxOUlR?=
 =?utf-8?B?eWIxT3h0UFgyNUVqa1JwRE42Z3Fha1JEakNYTFpTS0RwZ1ZOSVhFZDM2RDFV?=
 =?utf-8?B?elYzRnJvRlJHa3BRb2JTak9vdWthd0VWeUxYam1qeDNLK3V5WWV6ZllnWGtj?=
 =?utf-8?B?OC95ZzNVQnA3Y3RrNzMwOFY1RW9QdWtlMkxyTHJkcVFYS0g5M3hGbjVhWXRq?=
 =?utf-8?B?SHRxR3ViUWZZOGFOUmdLMDRVV0pobGxBa3FZZml6cTVvNG5KdVJkVUEyM3Ez?=
 =?utf-8?B?VThyM3VnYmJ1NXU4VFVVNUw4dWRkdnRuek4wR0Q3MTljRURxa3JjUlVMOTkz?=
 =?utf-8?B?Qlgrd2FBVzJFck9VVE45emxodnhkWHkvNkRkL3Y4TWtTVHg2Vng1L3ZibFg3?=
 =?utf-8?B?T1VGZWRoQ2xLcjNjSDRMMU9lS0d6RGJiOFdzYnFzdVprSC9taXRPVzNmalZw?=
 =?utf-8?B?RlRSRE93WWRGTlhsMS94d2pqbjgrWW8ycDJDUVUwMG0zcm9hRVBST1VnVTFQ?=
 =?utf-8?B?eXE4eXJLeTB3cGtsOWdleHNYZ0ZuT2plV2pOWFRPc3VCcjJtT1VubmMxRTVM?=
 =?utf-8?B?M0JGa1VsY2hCV2l4YmdvNXhaOGNZM1p2VnFycjNnMzloWllBSWx4YTN5OU1z?=
 =?utf-8?B?eGZoREh3YlVKSTFmY0dGZzMvQkVYci93Mmt3Y08yNzlqb1pWMlpVS1UzME81?=
 =?utf-8?B?enMxL1E2Tks2YnR3c3VIOU9yZWVIUCs4OE9Iekd1cVNpWDVZcUYrMEVhZU0w?=
 =?utf-8?B?dWpiWVAzZzg4TEtVVU5JbTBRWTQxTURVUFc3TTlxWmowUVBVbmxwN3JhdVV1?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b57f15-dc83-440f-b6b7-08dc819e0a90
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 18:18:16.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVOeKaDYk0jxUUpbex8aHBerKTpD/ZvKgWPqGLduvnb4dNMTUgNJcYnns+EdO8HurC2APH7huBRblfZcHr9jZOMvVTsCJA+23fu8FW0NcaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8316
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/31/24 6:11 AM, Ilpo Järvinen wrote:
> The struct resctrl_val_param has control and monitor groups as char
> arrays but they are not supposed to be mutated within resctrl_val().
> 
> Convert the ctrlgrp and mongrp char array within resctrl_val_param to
> plain const char pointers and adjust the strlen() based checks to
> check NULL instead.
> 
> Convert !grp_name check in create_grp() into internal sanity check by
> returning error if the caller asked to create a group but doesn't
> provide a name for the group. The existing code already abides this by
> only calling create_grp() if mongrp is non-NULL so the error should
> never be returned with the current selftests (ctrlgrp is never NULL).

This paragraph is no longer relevant and can be dropped.

> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> v5:
> - Return 0 if grp_name is null (restore earlier behavior)
> - Move the root group note from comment into kerneldoc
> 
> v3:
> - Removed wrong comment
> - Changed grp_name check to return -1 on fail (internal sanity check)
> ---
>   tools/testing/selftests/resctrl/resctrl.h   |  4 ++--
>   tools/testing/selftests/resctrl/resctrlfs.c | 16 +++++++---------
>   2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 5967389038d4..a999fbc13fd3 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -91,8 +91,8 @@ struct resctrl_test {
>    */
>   struct resctrl_val_param {
>   	char		*resctrl_val;
> -	char		ctrlgrp[64];
> -	char		mongrp[64];
> +	const char	*ctrlgrp;
> +	const char	*mongrp;
>   	char		filename[64];
>   	unsigned long	mask;
>   	int		num_of_runs;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index f4dc8ef23a8c..893041faaf18 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -456,6 +456,9 @@ int taskset_restore(pid_t bm_pid, cpu_set_t *old_affinity)
>    * @grp:	Full path and name of the group
>    * @parent_grp:	Full path and name of the parent group
>    *
> + * Creates a group @grp_name if it does not exist yet. If @grp_name is NULL,
> + * it is interpreted as the root group which always results success.

"always results success" -> "always results in success"?

With changelog and comment fixups addressed:
| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


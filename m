Return-Path: <linux-kselftest+bounces-5977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D493687327B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D01828B9FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC5C5D91F;
	Wed,  6 Mar 2024 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brc76QfH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD1D53F;
	Wed,  6 Mar 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717091; cv=fail; b=QXXFX5Pl5BXj3l0o+sfB4bpMuFO2v63iOrZzVhp4HmD7/hk35U+5zMtt5dJeleIllfVr5xd2wiR81EUdcVDk/uW/XfyRurO7RgS08fMmsOiQqaX39WrGdl0JyBoDDRRYiV5skRupt0tJOfIVQzh9W4UtCDR9DJmXPz2YWSUOCfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717091; c=relaxed/simple;
	bh=ZwCYlQaNKoagwdfiqJ94BWhUqOx7LxVSSF6MgcCUWgM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dkc/caX3bQ5zWscCud7kfBxtLm/TaRsAgjr/rr1Y3O6PFtLxb5yX0Uz2QJ/uxDXWu1dIur6R+yIVKpsIYH26361Z+Qd2kdzLLmDVXvEeY/3nqzlXUqx6qeuu7ozQWOgBAYw4yCYeuimI+XHkNq6rUVX62pRen9S2yjGDEyzcctQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brc76QfH; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709717090; x=1741253090;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=ZwCYlQaNKoagwdfiqJ94BWhUqOx7LxVSSF6MgcCUWgM=;
  b=brc76QfHAGX7FJHhW0GXqmZszvcZQz2CcRDUIBSjUfFQaoiL/vQm+q3q
   2H5MzwfqNScOpTBB63MwL9qLPWMhH0npCvyYLLK1kTEiPANJfCZdO1JqG
   jlExTAiXQue1QsyS3qrbVexY3GK0sYqZK0en6zyYqJAv6Y7OX8vvNUaxi
   /mH84Ncte6MdUYkoFuwwt2yGYUAPynpd61fXS8znCXbvtECsZ/4wsml/n
   r1ud0aBpERh/Fogkdecy3qVCeAsUUJeuozKScarOkYaN/rBGNojFqVKL7
   bDM89eOSF/VlSx1rOuS36Pv90kKgcD++ZP40ICSr3+dW+Uyypcu24lmBN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15462082"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="15462082"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 01:24:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9782530"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 01:24:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 01:24:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 01:24:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 01:24:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 01:24:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzoTuy2IsCYwsz92Zj+s32Y6aCXZEp0uD7D1DnTjWVLn0zg4GZ9wNF7+hVgC7VneCXa8+kr3wpw+nAMWs5PERDz3umC/TjxLOwLDfISpRlJwcsijzPtajoXciLFPp4T7N/5OOytpTd6EY4gGB30La7ZZf/7YWTt1yUlDUMLzJMjwjW5D6m/HPJ8D2Sv5/M6BrkPDmj73bU7k1rxrjlXqpPcVIabJzMplFfU3wyeHALV9CQJXOrk6b7DxrS9Vu4wuoyQ8LrhCXcYAkAopCtbNm7gtk8+uCBnleY4k9S0ed4ZyjMVcjpZA4bdh2jyHbinDNC2oaA3ykXtcLAzI1hIR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7qBrs7m+6I3kYdc3iEhRyB/ZlaN1zHw0R6EIzvM79g=;
 b=Mu3AuQuqNxMo2B9qyOv0zpPD+r+wMdhvbWnSobOwu9r6TN95FNryIhnIAc6/GZBi66Th31glgt537zft/8pOvCeyt1bPflZHpdD0//gXlxkasST2Ro30VoM+9xgFtis0YAmLFvwK6dXc+3n2BKJlGsxJOgBUCc2vE9A+oZKXhhvqY/3RB7PjZHwJOK0h4vdrS0hea/GBPh4Aoolnp4sSi76uAMwwP51Q9zen/e/Dr77kEK7gFc4jePciJw0ysXfCurKY8CFtzRJowcKhIFIciECnAIrGXWQu/BLgYBdaZN7AhEZ+DML1fUETuHjLlvj7iEWIyYRVhVxCPIlBkfy+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 CY5PR11MB6416.namprd11.prod.outlook.com (2603:10b6:930:34::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Wed, 6 Mar 2024 09:24:44 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 09:24:44 +0000
Date: Wed, 6 Mar 2024 16:54:52 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, Isaku
 Yamahata <isaku.yamahata@intel.com>, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter
 Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, Chao Peng
	<chao.p.peng@linux.intel.com>, "Vishal Annapurve" <vannapurve@google.com>,
	Roger Wang <runanwang@google.com>, "Vipin Sharma" <vipinsh@google.com>,
	<jmattson@google.com>, <dmatlack@google.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v5 28/29] KVM: selftests: TDX: Add TDX UPM selftest
Message-ID: <ZegvXDyJ4ILTF6+J@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-29-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-29-sagis@google.com>
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|CY5PR11MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 8345fc70-9cbd-4b02-8c4c-08dc3dbf4292
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xY4vAxoZ5MHgnuekHni46MTyZCGmn2HK5KBlt+2Nj1CpzNEDI+qAUSzWCc/nfpGjTuzfEGHYcgz7bDmQFjDhVfwwWpOm6kamFJxxGAKS0C0iF2AtHg3XjvzFt70urGzAg3nvjgix9brO5TlI8lnjQehlI6PBdnSnBCmVc7V51nMuCO+Y9vf6nmslb4BKCBvZgZmxtOX8xRuEuWfhIb7DFg6wvFMWfMP/xPkv7Fm+MZ5Lr5+xlCSGlFTJhe4HKLEiUOhWqbKFNuJ+0JmbJQmfKwdE5tS/IdlxKQZVwjW2KX1HpbW5E8AheMcX9jUxKDHsDNBgq5X8zU+3IGpBstp2mQTsKnXWYHKuwg4VA9gja0x6xhCLnokeI3b2bbjyewQd+9E7hyOS5BYttJ0XGsW3H3SSAM8zylmNbj037Ba7CnW5qIwnL5q3P8kDzHsUvm4R6ieycYl6m4XhsDyp5R5Z1JGK1KOeVXL0bxJFsB6E8yHj/HGlbISBL7llsSkKsjb6AHzXEOlnGFmV0S+cXAlMF5396ddLJUWN9V/A8MJXbPm6AP7SawUCbLrY/bVHD+2XfXRujeFLfP9/eU3AaIC/qR4Wb8HzeWngaVyhnJDZMkHRAOuJJQo5ywEHiySZcyeTrSu3jKz0bVHdmwWXzyma0VlvnfoFiNMStVI2Zd4nRCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikAyQmYgwip8Tyo3FB6/3A7X32t9yKxVs9vuI8cHAfkqGWmHDH4t6fbxJsUh?=
 =?us-ascii?Q?Y4IySB+GzxxcISOmaIKNciaHg4/Eb3Ry94fj3IQvzMX6zwmOXYpUcG8AKYMa?=
 =?us-ascii?Q?jGtP+7eNxYM6H6/5vPaU7QX22Xgz9Hlhg+2XwgnYjgpmgOM7sWOUZOeEONLj?=
 =?us-ascii?Q?VCPW3171Zd3DL/8+gCcnAuM4Kch/WfHCJRJ+kTWbpqiuJy2gceKthKLv9pTu?=
 =?us-ascii?Q?Vp2swpjtv7s330R7VWSByWiPv9Nwl1ob75T1UVgaWwtAf/k2CNw4wS1yN7ZA?=
 =?us-ascii?Q?aoh3tR+Lu41QhuXAaX3QuEsNqm+hYfp6qHw3AXyQe7+6RSIt9nb9gqXNdJdZ?=
 =?us-ascii?Q?5YMe/kCGQyI/sNfoftehgeUOeZj9hpESV61iMEiGRN0Et5OsDVfrznXtI7Fk?=
 =?us-ascii?Q?DeVXblD3zjpbUW1i+LSE9Q25eQglFRkcyijnYf27Suk9wF3/cz8Ca192/zt/?=
 =?us-ascii?Q?72mwU+LOiBFtbLpXRFCh+T0O6UDveVDO1q3YRfAMYHTUgrhTqcDhcHFQG1xP?=
 =?us-ascii?Q?pyjh0EDMerV2vSm6bXQKj3NA7CODmDJrKaTTsAiWXLbQkw774Tqu158DF0Ak?=
 =?us-ascii?Q?sCIm/lB9RS85sLz7TyhcaHFPXdg+KEJNbcelUaQqNeNEeU1dyKFoTuLruJ2B?=
 =?us-ascii?Q?PzYmjw3p15DZK2kT0G0ktWKeHgBgvfwPdY5ZAXOb6/mWOtd+mkXEuzlMcEoL?=
 =?us-ascii?Q?0W8MuHwTWTOzU/dwSXR80anEcMy8m0uec+WoOURxkptG3z+6OjQ7ule4Mhrw?=
 =?us-ascii?Q?F+u9rRnNqEfs/OsmCsjOtfQpRTJJ2IA20/n6fga+RvKF8T6Qgti2I+b/Wulz?=
 =?us-ascii?Q?53l6b4MztreJ4CRYonTB1WhJhFz2UVSivwW9CMkp1vbLILNMylGDPGcMsKOJ?=
 =?us-ascii?Q?DsZ6pd9BTWzuPZwdv8Bb5rpiP4bx98zcoYdksaKgbbJLHHXXxFji2QAhZrn/?=
 =?us-ascii?Q?SbVv7OeEbZPTarkAFl+T3oSUQ1scuMOPkpx8M/BPkn1YJFqBaFdM5YB/dQOk?=
 =?us-ascii?Q?Ru/QsVIXw2TlYaXrJC1IvqvOEEegTLz4nhms84tm46Pz6KEK41Vw3bUq7BOk?=
 =?us-ascii?Q?UiVo1tLgVRDi+GIyumpR/jpIwMmbhASBSPxCFnI3k1+sdr5xUjzi8JA0HX7B?=
 =?us-ascii?Q?p1Z+R9FC8SY5s9/bpyq50Oeu/F/SVGOKlUZLlXhF8b90JRXXpWQlaie4j/a1?=
 =?us-ascii?Q?lNisV2k/FnR5XGf+fwrVD5l+oPA3JBcpUuq5MJZmVlW9plajRMVaY/+oIYW2?=
 =?us-ascii?Q?HOz3pjeg9U5MHGmjhK9WYmFXgi5IeE3CsZGwsxYwRQ00eBuFBukzIsMAjAkX?=
 =?us-ascii?Q?S7QXq9JL5J8sI5VlC+PDqoIESl/ptmB4vG27mG5Wi0RimRZcbOIeE8OiEQ7w?=
 =?us-ascii?Q?OTTH3rMe9YFEq554Ge+mSKazNEfNBEGdM6CpQKq3s/+rlH/rRNly7VGRwVWV?=
 =?us-ascii?Q?cU5NDd7BNFDNBGuUNPCw4mAEV2QNALpAHxwhGjr/EBBrIQyOn5cMxxz0M4pk?=
 =?us-ascii?Q?LZ9VmLaxYRz7katldW4gKiKL0uGrQo7Rh1hry/+rz0kVQj3A1/NagUA9iJZ9?=
 =?us-ascii?Q?ugTrq5RbBf1Z3hR9bepOI3o1fgjfk6uzWnimq8mO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8345fc70-9cbd-4b02-8c4c-08dc3dbf4292
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:24:44.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxzClMfSCSlQYngFqbjkEsHNDO6HD5ooh2+Rvb/FziSr8HlJ4MyCG8YF1TndN97F2bwiy6CJIP9A6kFxMneXOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6416
X-OriginatorOrg: intel.com

On Tue, Dec 12, 2023 at 12:46:43PM -0800, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> This tests the use of guest memory with explicit MapGPA calls.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/x86_64/tdx_upm_test.c       | 401 ++++++++++++++++++
>  2 files changed, 402 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 8c0a6b395ee5..2f2669af15d6 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -157,6 +157,7 @@ TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
>  TEST_GEN_PROGS_x86_64 += system_counter_offset_test
>  TEST_GEN_PROGS_x86_64 += x86_64/tdx_vm_tests
>  TEST_GEN_PROGS_x86_64 += x86_64/tdx_shared_mem_test
> +TEST_GEN_PROGS_x86_64 += x86_64/tdx_upm_test
>  
>  # Compiled outputs used by test targets
>  TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
> new file mode 100644
> index 000000000000..44671874a4f1
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <asm/kvm.h>
> +#include <asm/vmx.h>
> +#include <linux/kvm.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +
> +#include "kvm_util_base.h"
> +#include "processor.h"
> +#include "tdx/tdcall.h"
> +#include "tdx/tdx.h"
> +#include "tdx/tdx_util.h"
> +#include "tdx/test_util.h"
> +#include "test_util.h"
> +
> +/* TDX UPM test patterns */
> +#define PATTERN_CONFIDENCE_CHECK (0x11)
> +#define PATTERN_HOST_FOCUS (0x22)
> +#define PATTERN_GUEST_GENERAL (0x33)
> +#define PATTERN_GUEST_FOCUS (0x44)
> +
> +/*
> + * 0x80000000 is arbitrarily selected. The selected address need not be the same
> + * as TDX_UPM_TEST_AREA_GVA_PRIVATE, but it should not overlap with selftest
> + * code or boot page.
> + */
> +#define TDX_UPM_TEST_AREA_GPA (0x80000000)
> +/* Test area GPA is arbitrarily selected */
> +#define TDX_UPM_TEST_AREA_GVA_PRIVATE (0x90000000)
> +/* Select any bit that can be used as a flag */
> +#define TDX_UPM_TEST_AREA_GVA_SHARED_BIT (32)
> +/*
> + * TDX_UPM_TEST_AREA_GVA_SHARED is used to map the same GPA twice into the
> + * guest, once as shared and once as private
> + */
> +#define TDX_UPM_TEST_AREA_GVA_SHARED				\
> +	(TDX_UPM_TEST_AREA_GVA_PRIVATE |			\
> +		BIT_ULL(TDX_UPM_TEST_AREA_GVA_SHARED_BIT))
> +
> +/* The test area is 2MB in size */
> +#define TDX_UPM_TEST_AREA_SIZE (2 << 20)
> +/* 0th general area is 1MB in size */
> +#define TDX_UPM_GENERAL_AREA_0_SIZE (1 << 20)
> +/* Focus area is 40KB in size */
> +#define TDX_UPM_FOCUS_AREA_SIZE (40 << 10)
> +/* 1st general area is the rest of the space in the test area */
> +#define TDX_UPM_GENERAL_AREA_1_SIZE				\
> +	(TDX_UPM_TEST_AREA_SIZE - TDX_UPM_GENERAL_AREA_0_SIZE -	\
> +		TDX_UPM_FOCUS_AREA_SIZE)
> +
> +/*
> + * The test memory area is set up as two general areas, sandwiching a focus
> + * area.  The general areas act as control areas. After they are filled, they
> + * are not expected to change throughout the tests. The focus area is memory
> + * permissions change from private to shared and vice-versa.
> + *
> + * The focus area is intentionally small, and sandwiched to test that when the
> + * focus area's permissions change, the other areas' permissions are not
> + * affected.
> + */
> +struct __packed tdx_upm_test_area {
> +	uint8_t general_area_0[TDX_UPM_GENERAL_AREA_0_SIZE];
> +	uint8_t focus_area[TDX_UPM_FOCUS_AREA_SIZE];
> +	uint8_t general_area_1[TDX_UPM_GENERAL_AREA_1_SIZE];
> +};
> +
> +static void fill_test_area(struct tdx_upm_test_area *test_area_base,
> +			uint8_t pattern)
> +{
> +	memset(test_area_base, pattern, sizeof(*test_area_base));
> +}
> +
> +static void fill_focus_area(struct tdx_upm_test_area *test_area_base,
> +			    uint8_t pattern)
> +{
> +	memset(test_area_base->focus_area, pattern,
> +	       sizeof(test_area_base->focus_area));
> +}
> +
> +static bool check_area(uint8_t *base, uint64_t size, uint8_t expected_pattern)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < size; i++) {
> +		if (base[i] != expected_pattern)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool check_general_areas(struct tdx_upm_test_area *test_area_base,
> +				uint8_t expected_pattern)
> +{
> +	return (check_area(test_area_base->general_area_0,
> +			   sizeof(test_area_base->general_area_0),
> +			   expected_pattern) &&
> +		check_area(test_area_base->general_area_1,
> +			   sizeof(test_area_base->general_area_1),
> +			   expected_pattern));
> +}
> +
> +static bool check_focus_area(struct tdx_upm_test_area *test_area_base,
> +			     uint8_t expected_pattern)
> +{
> +	return check_area(test_area_base->focus_area,
> +			  sizeof(test_area_base->focus_area), expected_pattern);
> +}
> +
> +static bool check_test_area(struct tdx_upm_test_area *test_area_base,
> +			    uint8_t expected_pattern)
> +{
> +	return (check_general_areas(test_area_base, expected_pattern) &&
> +		check_focus_area(test_area_base, expected_pattern));
> +}
> +
> +static bool fill_and_check(struct tdx_upm_test_area *test_area_base, uint8_t pattern)
> +{
> +	fill_test_area(test_area_base, pattern);
> +
> +	return check_test_area(test_area_base, pattern);
> +}
> +
> +#define TDX_UPM_TEST_ASSERT(x)				\
> +	do {						\
> +		if (!(x))				\
> +			tdx_test_fatal(__LINE__);	\
> +	} while (0)
> +
> +/*
> + * Shared variables between guest and host
> + */
> +static struct tdx_upm_test_area *test_area_gpa_private;
> +static struct tdx_upm_test_area *test_area_gpa_shared;
> +
> +/*
> + * Test stages for syncing with host
> + */
> +enum {
> +	SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST = 1,
> +	SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST,
> +	SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN,
> +};
> +
> +#define TDX_UPM_TEST_ACCEPT_PRINT_PORT 0x87
> +
> +/**
> + * Does vcpu_run, and also manages memory conversions if requested by the TD.
> + */
> +void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
> +					    struct kvm_vcpu *vcpu)
> +{
> +	for (;;) {
> +		vcpu_run(vcpu);
> +		if (vcpu->run->exit_reason == KVM_EXIT_TDX &&
> +			vcpu->run->tdx.type == KVM_EXIT_TDX_VMCALL &&
> +			vcpu->run->tdx.u.vmcall.subfunction == TDG_VP_VMCALL_MAP_GPA) {
> +			struct kvm_tdx_vmcall *vmcall_info = &vcpu->run->tdx.u.vmcall;
> +			uint64_t gpa = vmcall_info->in_r12 & ~vm->arch.s_bit;
> +
> +			handle_memory_conversion(vm, gpa, vmcall_info->in_r13,
> +				!(vm->arch.s_bit & vmcall_info->in_r12));
> +			vmcall_info->status_code = 0;
> +			continue;
> +		} else if (
> +			vcpu->run->exit_reason == KVM_EXIT_IO &&
> +			vcpu->run->io.port == TDX_UPM_TEST_ACCEPT_PRINT_PORT) {
> +			uint64_t gpa = tdx_test_read_64bit(
> +				vcpu, TDX_UPM_TEST_ACCEPT_PRINT_PORT);
> +			printf("\t ... guest accepting 1 page at GPA: 0x%lx\n", gpa);
> +			continue;
> +		}
> 
Lack of converting TDG_VP_VMCALL_REPORT_FATAL_ERROR to KVM_EXIT_SYSTEM_EVENT.

> +		break;
> +	}
> +}
> +
> +static void guest_upm_explicit(void)
> +{
> +	uint64_t ret = 0;
> +	uint64_t failed_gpa;
> +
> +	struct tdx_upm_test_area *test_area_gva_private =
> +		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_PRIVATE;
> +	struct tdx_upm_test_area *test_area_gva_shared =
> +		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_SHARED;
> +
> +	/* Check: host reading private memory does not modify guest's view */
> +	fill_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL);
> +
> +	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
> +
> +	TDX_UPM_TEST_ASSERT(
> +		check_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL));
> +
> +	/* Remap focus area as shared */
> +	ret = tdg_vp_vmcall_map_gpa((uint64_t)test_area_gpa_shared->focus_area,
> +				    sizeof(test_area_gpa_shared->focus_area),
> +				    &failed_gpa);
"failed gpa" is not filled by host and is uninitialized.


> +	TDX_UPM_TEST_ASSERT(!ret);
> +
> +	/* General areas should be unaffected by remapping */
> +	TDX_UPM_TEST_ASSERT(
> +		check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
> +
> +	/*
> +	 * Use memory contents to confirm that the memory allocated using mmap
> +	 * is used as backing memory for shared memory - PATTERN_CONFIDENCE_CHECK
> +	 * was written by the VMM at the beginning of this test.
> +	 */
> +	TDX_UPM_TEST_ASSERT(
> +		check_focus_area(test_area_gva_shared, PATTERN_CONFIDENCE_CHECK));
> +
> +	/* Guest can use focus area after remapping as shared */
> +	fill_focus_area(test_area_gva_shared, PATTERN_GUEST_FOCUS);
> +
> +	tdx_test_report_to_user_space(SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
> +
> +	/* Check that guest has the same view of shared memory */
> +	TDX_UPM_TEST_ASSERT(
> +		check_focus_area(test_area_gva_shared, PATTERN_HOST_FOCUS));
> +
> +	/* Remap focus area back to private */
> +	ret = tdg_vp_vmcall_map_gpa((uint64_t)test_area_gpa_private->focus_area,
> +				    sizeof(test_area_gpa_private->focus_area),
> +				    &failed_gpa);
> +	TDX_UPM_TEST_ASSERT(!ret);
> +
> +	/* General areas should be unaffected by remapping */
> +	TDX_UPM_TEST_ASSERT(
> +		check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
> +
> +	/* Focus area should be zeroed after remapping */
> +	TDX_UPM_TEST_ASSERT(check_focus_area(test_area_gva_private, 0));
> +
> +	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
> +
> +	/* Check that guest can use private memory after focus area is remapped as private */
> +	TDX_UPM_TEST_ASSERT(
> +		fill_and_check(test_area_gva_private, PATTERN_GUEST_GENERAL));
> +
> +	tdx_test_success();
> +}
> +
> +static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
> +			 struct tdx_upm_test_area *test_area_base_hva)
> +{
> +	vcpu_run(vcpu);
Should be td_vcpu_run()?
Otherwise, nowhere to convert TDG_VP_VMCALL_REPORT_FATAL_ERROR to
exit_reason KVM_EXIT_SYSTEM_EVENT required by TDX_TEST_CHECK_GUEST_FAILURE().

> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
> +		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> +		  SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
> +
> +	/*
> +	 * Check that host should read PATTERN_CONFIDENCE_CHECK from guest's
> +	 * private memory. This confirms that regular memory (userspace_addr in
> +	 * struct kvm_userspace_memory_region) is used to back the host's view
> +	 * of private memory, since PATTERN_CONFIDENCE_CHECK was written to that
> +	 * memory before starting the guest.
> +	 */
> +	TEST_ASSERT(check_test_area(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
> +		"Host should read PATTERN_CONFIDENCE_CHECK from guest's private memory.");
> +
> +	vcpu_run_and_manage_memory_conversions(vm, vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
> +		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> +		  SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
> +
> +	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_GUEST_FOCUS),
> +		"Host should have the same view of shared memory as guest.");
> +	TEST_ASSERT(check_general_areas(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
> +		"Host's view of private memory should still be backed by regular memory.");
> +
> +	/* Check that host can use shared memory */
> +	fill_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS);
> +	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
> +		    "Host should be able to use shared memory.");
> +
> +	vcpu_run_and_manage_memory_conversions(vm, vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
> +		 TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> +		  SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
> +
> +	TEST_ASSERT(check_general_areas(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
> +		"Host's view of private memory should be backed by regular memory.");
> +	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
> +		"Host's view of private memory should be backed by regular memory.");
> +
> +	vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	printf("\t ... PASSED\n");
> +}
> +
> +static bool address_between(uint64_t addr, void *lo, void *hi)
> +{
> +	return (uint64_t)lo <= addr && addr < (uint64_t)hi;
> +}
> +
> +static void guest_ve_handler(struct ex_regs *regs)
> +{
> +	uint64_t ret;
> +	struct ve_info ve;
> +
> +	ret = tdg_vp_veinfo_get(&ve);
> +	TDX_UPM_TEST_ASSERT(!ret);
> +
> +	/* For this test, we will only handle EXIT_REASON_EPT_VIOLATION */
> +	TDX_UPM_TEST_ASSERT(ve.exit_reason == EXIT_REASON_EPT_VIOLATION);
> +
> +	/* Validate GPA in fault */
> +	TDX_UPM_TEST_ASSERT(
> +		address_between(ve.gpa,
> +				test_area_gpa_private->focus_area,
> +				test_area_gpa_private->general_area_1));
> +
> +	tdx_test_send_64bit(TDX_UPM_TEST_ACCEPT_PRINT_PORT, ve.gpa);
> +
> +#define MEM_PAGE_ACCEPT_LEVEL_4K 0
> +#define MEM_PAGE_ACCEPT_LEVEL_2M 1
> +	ret = tdg_mem_page_accept(ve.gpa, MEM_PAGE_ACCEPT_LEVEL_4K);
What if ve.gpa could end with 1?
e.g. if could be 0x80100001 if guest accesses test_area_gva_private->focus_area[1]
after remapping focus area back to private.

Though this does not happen in current test, it's better to strip the low 12
bits of ve.gpa before passing to tdg_mem_page_accept(),

> +	TDX_UPM_TEST_ASSERT(!ret);
> +}
> +
> +static void verify_upm_test(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm_vaddr_t test_area_gva_private;
> +	struct tdx_upm_test_area *test_area_base_hva;
> +	uint64_t test_area_npages;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_upm_explicit);
> +
> +	vm_install_exception_handler(vm, VE_VECTOR, guest_ve_handler);
> +
> +	/*
> +	 * Set up shared memory page for testing by first allocating as private
> +	 * and then mapping the same GPA again as shared. This way, the TD does
> +	 * not have to remap its page tables at runtime.
> +	 */
> +	test_area_npages = TDX_UPM_TEST_AREA_SIZE / vm->page_size;
> +	vm_userspace_mem_region_add(vm,
> +				    VM_MEM_SRC_ANONYMOUS, TDX_UPM_TEST_AREA_GPA,
> +				    3, test_area_npages, KVM_MEM_PRIVATE);
> +
> +	test_area_gva_private = ____vm_vaddr_alloc(
> +		vm, TDX_UPM_TEST_AREA_SIZE, TDX_UPM_TEST_AREA_GVA_PRIVATE,
> +		TDX_UPM_TEST_AREA_GPA, 3, true);
> +	TEST_ASSERT_EQ(test_area_gva_private, TDX_UPM_TEST_AREA_GVA_PRIVATE);
> +
> +	test_area_gpa_private = (struct tdx_upm_test_area *)
> +		addr_gva2gpa(vm, test_area_gva_private);
> +	virt_map_shared(vm, TDX_UPM_TEST_AREA_GVA_SHARED,
> +			(uint64_t)test_area_gpa_private,
> +			test_area_npages);
> +	TEST_ASSERT_EQ(addr_gva2gpa(vm, TDX_UPM_TEST_AREA_GVA_SHARED),
> +		  (vm_paddr_t)test_area_gpa_private);
> +
> +	test_area_base_hva = addr_gva2hva(vm, TDX_UPM_TEST_AREA_GVA_PRIVATE);
> +
> +	TEST_ASSERT(fill_and_check(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
> +		"Failed to mark memory intended as backing memory for TD shared memory");
> +
> +	sync_global_to_guest(vm, test_area_gpa_private);
> +	test_area_gpa_shared = (struct tdx_upm_test_area *)
> +		((uint64_t)test_area_gpa_private | BIT_ULL(vm->pa_bits - 1));
> +	sync_global_to_guest(vm, test_area_gpa_shared);
> +
> +	td_finalize(vm);
> +
> +	printf("Verifying UPM functionality: explicit MapGPA\n");
> +
> +	run_selftest(vm, vcpu, test_area_base_hva);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	/* Disable stdout buffering */
> +	setbuf(stdout, NULL);
> +
> +	if (!is_tdx_enabled()) {
> +		printf("TDX is not supported by the KVM\n"
> +		       "Skipping the TDX tests.\n");
> +		return 0;
> +	}
> +
> +	run_in_new_process(&verify_upm_test);
> +}
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 


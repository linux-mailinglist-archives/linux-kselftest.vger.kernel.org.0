Return-Path: <linux-kselftest+bounces-5804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6F886F8AD
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 03:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A61C20C08
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 02:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F26A1FAA;
	Mon,  4 Mar 2024 02:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKNfSwVl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585017C9;
	Mon,  4 Mar 2024 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709520573; cv=fail; b=rcv6Tax4drbssqHHMio3upc1O9p/2pjj23CBNnB5LGS/Ij910Zn7jQHQxX829MrsXongq6UnPkSC1Ie+eRNJnoFTJ0fA6HGyUkUC4BOJATPt0P8NzB76UEgm+XPijGOwR+QCDCcTEtvPmrV+lMNihVxg3jxFy6eX48iz7uCoO5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709520573; c=relaxed/simple;
	bh=qH+lumMgjE59hqlcJJM4hcTZHcv4BUCa+V2r2L/nStc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=laLnagmFYlMzYSObUM7AwFxwgRJIUXKW/v4z+3RTJ7hveaGk9Pt3V3ji0dwKvYsOU6XT6g9sHlk8P/mZimdvOQiKn+aS3Q0/wzcbNts9LYbYED8Xv+DIpZc5I49Tu4eCAaxytmOqSnhVlWlNrkpI0VYSd7HTaWHiPS6PlDWyMnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKNfSwVl; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709520572; x=1741056572;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=qH+lumMgjE59hqlcJJM4hcTZHcv4BUCa+V2r2L/nStc=;
  b=FKNfSwVlMkEiJqjhOqeBViau6RR1zKEwfmHQ4WyLiwONNrifJ7+qJ6EK
   /Sje0cWObTLMeoaU+6AG7G9Kh9RxBZb7Q+g75rvjZXHugMc1x6MpWMBTU
   pVkMuar4v+4fLraBRhWvOL3vPOuD4cCiCWV43V9JpmBBsvnZZd+RzcZxm
   cyip7hoJsu5lW0PcUBJJF5jYEeOZpvLcRtPyhHcLeWy81gi+wEmeTVGuT
   Cs3ZLc80ynkMdxeXgt17TzWnIHr3HzxVOXirb9ltgS/sldzpinj1N3IQY
   scdXGjG5i0XjHOGll/pbYddO/J4qvIYgkHtFQJK/x8fWk/sJ6lfP8vmrQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3885550"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3885550"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 18:49:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13496195"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2024 18:49:31 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 18:49:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 18:49:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 3 Mar 2024 18:49:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izbSaPZubXJ/KHC0PtZvsTOte9REqRKnaGJ1XVVvl87CMa14zts4L4diS+MZ/BEyUb38TJG02BjamarfotTJf4F2DTDxk+hk1fsD0o/2w4QjVihzAaT1exaslcCvhz8H8bZwUR42Cchn0PqJ1cPmxZSuS1T7v3CTmUixRwO2S6JknxZsFKFe3Q0+3sUFsHFGy8o5e4eAnQPhyoX4aI+Hp7+FMMu6QRE4A747ufJWhPxZDT55sKUbr+NmzBd8E4uZk8w095IuwyZ+/mjo+2BZKoC7QiA/XFjEupSNgIOS9uUBEwra5p62KL6DOkRzcwhYbbd0+HcEoZgJKzOc6fK+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9EB35qUTmGZFRxTopeVIWWOPb1Z/AqYYiIEcu6F3R0=;
 b=gZJb+nVrNgjNlsf/tar9xKzmXlh58+UkgDaHEWqEwzUmrHA3UjctH7iD0NnuwSena/E8oPM+65WmIR69n0FkFi5IILgGHp/bgzxO9WuKpg6R2FAq8eoRu22FbdGXacDcIpFtzbqV0eqorrvlrYxvL1NSNbN7lqVOnbbRkJtUeEMIMgMxYsTQ/2qzo3FDhB9SbBYCvgwR3EKtArT2B8XwO8OTUMf7Jw+zk+WYXIrmn9l2Ykv48zH23K0vY/BEfq7gZBKRVwoAvtNGbvj3Scx3tcbjm2/bEvrmvLNM9KO/njh2KrY6aXPnWPYIZLj4ViRtAyST7hvEIXmfPUKjXuEE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.18; Mon, 4 Mar
 2024 02:49:26 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 02:49:26 +0000
Date: Mon, 4 Mar 2024 10:19:35 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>,
	"Isaku Yamahata" <isaku.yamahata@intel.com>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
	<shuah@kernel.org>, "Peter Gonda" <pgonda@google.com>, Haibo Xu
	<haibo1.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Vishal
 Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>, Vipin
 Sharma <vipinsh@google.com>, <jmattson@google.com>, <dmatlack@google.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v5 10/29] KVM: selftests: TDX: Adding test case for
 TDX port IO
Message-ID: <ZeUvtzHmMo9jdMnu@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-11-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-11-sagis@google.com>
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA1PR11MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c705d3-f419-4f19-0fdd-08dc3bf5b485
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDcx6NO8TpOUFBSivfwCjJn9d1F8rKBo9DYGmPQzUlFiBAAicp4kt4XLh+85kxopnxfM92a/FzyQtae0jRK4PXm5ml1/9vF/k98u66v1xVy8igPKjSahRnoFE3caPzpkMwMXUEawNaEiYkejtEhjDPa81oJ3zsDySBmn7Tg0Dp3IDZTGhrEk2DB/1BYXGb4c2T1Gm4wcstDH45+HW4DSGXHz9C4n85nETkXGloAx0xwsZGHZzfR4ZH66gTsF6aE1C4ptt3ABf3Ub/Qolgue9yqcKciWC8l5jVXx7SJCus/vbT5tSCdPCeTLiTtaD/sdNB/eQVGjY2HqUcYM5DgQ1kHfQFO1b28+/K1Xpd/GhthIR1+/pDvspV1WAN7B8KIOxvUzIIehAe1ITlQcwcZ9YhZebjKqU3JmlWaFKUvOqBiUmq/T0rmD5bSNbsXLro25JrwTT+sVPYisSDN2MvuBkBCC8IsgPctqcP8X2R4YUTw9ukYdjxiM4uGqM9AZLs5uYQKUXbdJFXvh8QpcidymCIxUZsEZyxxK1eZlXJpKGCPp92ARqcpMVClj+fYWZ2j18BECiAIBOONok9WignVzdj4oyLsgc3OvFF/URmXiC37g0+09GfAxlM3lx9re18VsOQg7pDEQSh42hzJOO8BYqCsYhNMX9b8xlPlFuI5bwGO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?45a9a2mGA2JvfqnFCXcU3vPCMEWAPGM6wcGjKRTRRqj5eqThzS909PrwqXeW?=
 =?us-ascii?Q?wi3MPfsmKbp0u3dfodVCbLjsDXuPTZ0VpMnZwT57uUKupZmeO8Uk1+WbnLAS?=
 =?us-ascii?Q?Df4nSxiU2/har1Jzfihc8c9Bz9XvqAd0wM2XCtIrkbwkMDnvAzSFPV4G6RZ0?=
 =?us-ascii?Q?nMN2qOe0RKSNGWVDd5lgmd8jDbXQCFsHgw3leXgfc56Tnl0wD0zHIPDg0wN6?=
 =?us-ascii?Q?9tUussFQsHI7krVYxLw5P6rkyYcw4SznDkozlYvsndp4jwE4FyiQRv+enPP5?=
 =?us-ascii?Q?1SgMDhNx1qZtCCRCQnvY9DmAa1NUq3oOt5wPQ8KK1S4xRXsqCwvWwyMV/YGH?=
 =?us-ascii?Q?c9r/ozg3gpnI0IxFPisr7tcOJe85rofdbU4qTEiVvUq5g2ObuWoFLCpzHr07?=
 =?us-ascii?Q?m2Q4/SjQtk7tpax2aR5S6IIpPU7DCbYf2zDeUYbBaJvU2Xl8OjbjAmHJjvf6?=
 =?us-ascii?Q?af+lguS0QRyg9pFhdtfmA1GBajuQVZB0RoC4N0k2AbbvUnjs4vRPt5qBTQt9?=
 =?us-ascii?Q?nrLsFyw4JcWqh2xsoiPMYwh/qu5+aC1uWq+bwEuV05GdMdEIsoFP1KQLlKbK?=
 =?us-ascii?Q?Z65pAJNxq661Yomu5HI12/seyLaV+txz26gdMXpvjvSgEvsTCMKQLg1+Ekz/?=
 =?us-ascii?Q?09J0LtrKY5GfLMHXtGCEXKNIluHCf3k8VdGcRuBHkBQND7tgrwDI1PzzRh8r?=
 =?us-ascii?Q?mYA+gtOQ1XWqszKSqUROd07d98EmttdNykDjHPZg8P+5VWxEKQPZ9J3EWThC?=
 =?us-ascii?Q?RxQace8pcUS6RvZFNB8YMgng6kdsMCp0qALC5Ga1fjCQ0+lVS+fGbnNc98/5?=
 =?us-ascii?Q?wLkdOwaak4YWcGWRe5lBvRJaiRLeqqU1IQ+07RCjLRXWoyKkp7Ju1Ae5awip?=
 =?us-ascii?Q?fRx8oYsI4TTwwQe2kWQrkBnoZpYFa6p3tETNQhL3WsoUABFIZHtNULjfsZTl?=
 =?us-ascii?Q?Cfa9TbUd4EIGykyCadYHJ5I6zIp6W4Ju2wRELpl+5PFBviRWgKiaqzRHE1++?=
 =?us-ascii?Q?q2O+CBVlSouNq4GgzQ2+J33bNhpTsy0gnEf2EKupUq64XxJcTxqxd4qZhWIg?=
 =?us-ascii?Q?Rfbjc6MGvHFs4Ee+Uk38vlQWCTJ9HBhOjj4vYnzCcQZqn+lehfloBvacafpp?=
 =?us-ascii?Q?LCBUbqbJCGRSNzZK5g2ZhhE2+zzwPeaULSB2ibs9aX1g851u9H/cUJ09OxUz?=
 =?us-ascii?Q?FPJWwRBeWAwvsRhRTm0l/DZzfFP8G8J5Of4V7Lo9Xm5/L8zLxBy8YCnkOtzQ?=
 =?us-ascii?Q?B5x/mPVjQMw4m/qnOYoU4ZnyWHuPl/DQf1zCwA0assbUIbH06lOR2ykdz4Lo?=
 =?us-ascii?Q?TB1R/p8cXVwOnUH4vinCAUCeVhsF3V22bWAe8IM5QACnR8KVn+lJDCHxTRAB?=
 =?us-ascii?Q?CrFraiNQZlZkpmhmQtdlJMwKdg704lyoQQQvmHLbKXebtL+AegI93xQThICC?=
 =?us-ascii?Q?EoKImgsUA6PoNzAh/qcWKSZmegGfas/REaodsyfBpako+a7AGT/oVi+GeINW?=
 =?us-ascii?Q?/solB5I6+TQYxTr7q4dHZ0vpfZ8p345an5azBSGvHt0F5CCceFGgR8sUTQeX?=
 =?us-ascii?Q?YE4bK1cNceMl0W3X7eoM1h1WmHMGD7ZPlVG1I1vQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c705d3-f419-4f19-0fdd-08dc3bf5b485
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 02:49:26.3183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1ymtJf9Q7qfPnPq0/uQeWDmD4vuk1UPjCg/F8k1IifqyTb2+QvQSiHqv2UI8XeIVaO/WIcN2nwqj0+83S2orw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
X-OriginatorOrg: intel.com

On Tue, Dec 12, 2023 at 12:46:25PM -0800, Sagi Shahar wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> Verifies TDVMCALL<INSTRUCTION.IO> READ and WRITE operations.
> 
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> ---
>  .../kvm/include/x86_64/tdx/test_util.h        | 34 ++++++++
>  .../selftests/kvm/x86_64/tdx_vm_tests.c       | 82 +++++++++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> index 6d69921136bd..95a5d5be7f0b 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> @@ -9,6 +9,40 @@
>  #define TDX_TEST_SUCCESS_PORT 0x30
>  #define TDX_TEST_SUCCESS_SIZE 4
>  
> +/**
> + * Assert that some IO operation involving tdg_vp_vmcall_instruction_io() was
> + * called in the guest.
> + */
> +#define TDX_TEST_ASSERT_IO(VCPU, PORT, SIZE, DIR)			\
> +	do {								\
> +		TEST_ASSERT((VCPU)->run->exit_reason == KVM_EXIT_IO,	\
> +			"Got exit_reason other than KVM_EXIT_IO: %u (%s)\n", \
> +			(VCPU)->run->exit_reason,			\
> +			exit_reason_str((VCPU)->run->exit_reason));	\
> +									\
> +		TEST_ASSERT(((VCPU)->run->exit_reason == KVM_EXIT_IO) && \
> +			((VCPU)->run->io.port == (PORT)) &&		\
> +			((VCPU)->run->io.size == (SIZE)) &&		\
> +			((VCPU)->run->io.direction == (DIR)),		\
> +			"Got unexpected IO exit values: %u (%s) %d %d %d\n", \
> +			(VCPU)->run->exit_reason,			\
> +			exit_reason_str((VCPU)->run->exit_reason),	\
> +			(VCPU)->run->io.port, (VCPU)->run->io.size,	\
> +			(VCPU)->run->io.direction);			\
> +	} while (0)
> +
> +/**
> + * Check and report if there was some failure in the guest, either an exception
> + * like a triple fault, or if a tdx_test_fatal() was hit.
> + */
> +#define TDX_TEST_CHECK_GUEST_FAILURE(VCPU)				\
> +	do {								\
> +		if ((VCPU)->run->exit_reason == KVM_EXIT_SYSTEM_EVENT)	\
> +			TEST_FAIL("Guest reported error. error code: %lld (0x%llx)\n", \
> +				(VCPU)->run->system_event.data[1],	\
> +				(VCPU)->run->system_event.data[1]);	\
> +	} while (0)
> +
>  /**
>   * Assert that tdx_test_success() was called in the guest.
>   */
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> index 8638c7bbedaa..75467c407ca7 100644
> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -2,6 +2,7 @@
>  
>  #include <signal.h>
>  #include "kvm_util_base.h"
> +#include "tdx/tdcall.h"
>  #include "tdx/tdx.h"
>  #include "tdx/tdx_util.h"
>  #include "tdx/test_util.h"
> @@ -74,6 +75,86 @@ void verify_report_fatal_error(void)
>  	printf("\t ... PASSED\n");
>  }
>  
> +#define TDX_IOEXIT_TEST_PORT 0x50
> +
> +/*
> + * Verifies IO functionality by writing a |value| to a predefined port.
> + * Verifies that the read value is |value| + 1 from the same port.
> + * If all the tests are passed then write a value to port TDX_TEST_PORT
> + */
> +void guest_ioexit(void)
> +{
> +	uint64_t data_out, data_in, delta;
> +	uint64_t ret;
> +
> +	data_out = 0xAB;
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
> +					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> +					&data_out);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
> +					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
> +					&data_in);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	delta = data_in - data_out;
> +	if (delta != 1)
> +		tdx_test_fatal(ret);
> +
> +	tdx_test_success();
> +}
> +
> +void verify_td_ioexit(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	uint32_t port_data;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_ioexit);
> +	td_finalize(vm);
> +
> +	printf("Verifying TD IO Exit:\n");
> +
> +	/* Wait for guest to do a IO write */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
This check is a vain, because the first VMExit from vcpu run is always
KVM_EXIT_IO caused by tdg_vp_vmcall_instruction_io().


> +	TDX_TEST_ASSERT_IO(vcpu, TDX_IOEXIT_TEST_PORT, 1,
> +			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	port_data = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
> +
> +	printf("\t ... IO WRITE: OK\n");
So,  even if there's an error in emulating writing of TDX_IOEXIT_TEST_PORT,
and guest would then find a failure and trigger tdx_test_fatal(), this line
will still print "IO WRITE: OK", which is not right.

> +
> +	/*
> +	 * Wait for the guest to do a IO read. Provide the previous written data
> +	 * + 1 back to the guest
> +	 */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
This check is a vain, too, as in  write case.

> +	TDX_TEST_ASSERT_IO(vcpu, TDX_IOEXIT_TEST_PORT, 1,
> +			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
> +	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = port_data + 1;
> +
> +	printf("\t ... IO READ: OK\n");
Same as in write case, this line should not be printed until after guest
finishing checking return code.

> +
> +	/*
> +	 * Wait for the guest to complete execution successfully. The read
> +	 * value is checked within the guest.
> +	 */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	printf("\t ... IO verify read/write values: OK\n");
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	setbuf(stdout, NULL);
> @@ -85,6 +166,7 @@ int main(int argc, char **argv)
>  
>  	run_in_new_process(&verify_td_lifecycle);
>  	run_in_new_process(&verify_report_fatal_error);
> +	run_in_new_process(&verify_td_ioexit);
>  
>  	return 0;
>  }
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 


Return-Path: <linux-kselftest+bounces-5820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7886FDF1
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 10:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0830DB215A4
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E6D20DF4;
	Mon,  4 Mar 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUUPjDcK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB123134B7;
	Mon,  4 Mar 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545708; cv=fail; b=IZTsLpRMXO3gjsRQsKDedsP9tc0jjQSzSNy61daO9j5j4hjbIeBTF/p6g5HtAeqX+3Hw4Zgexpjjzq/gRYoVnbTxv9Odtj5jWdSiDou+naVS5vwMZlhBsUdMxw1zWJk/jLPCmJrwboql/lgZ57C3knXpF7aTmXlpLuRoOIQWNoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545708; c=relaxed/simple;
	bh=AYWqPuZU8QoMOdjeRAdEHvAbleLruAjk9DwnXMtBzmQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X+GIcNP1+VJALjsQX1P3hFdj3t+WkWFCpzqbtM73TTMweNjZ02lVoYeJ38bviJZM/VL6fTqYJs1Szj9NmjY0dB5apHqlJRTueIUco8MA8J6VM8u0RPLs54E70O5ih2hpn2BqhvKoxrVlGc94UYePT099/0F1SDb1Ky4uPIOT80M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUUPjDcK; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709545706; x=1741081706;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=AYWqPuZU8QoMOdjeRAdEHvAbleLruAjk9DwnXMtBzmQ=;
  b=HUUPjDcKEATtGFJk5zLDSDDqnZ+iIx2Aag4bzsAWQ5L3aMa+0r7vEhG9
   W9Zk0R3EJak72Y4vGyqkCz4zJwodb7TK+fmr9qd9k23GUYNk9a269ydIC
   ZPEkCK8SnoH9vjuYZTgTyL3N5Bu6sEAOlWsSu27LPZ5jiCrIH7ffOpnh9
   F0owYjUsquGQKQFQjGritO5uv0kYaqXdhsQ11/UG8zBJk5N/elFmCHlVk
   WdTZ/vysVJ1FTlsp99bBLU8YtorvOE2C+6O8QOpkwPOaYo1q4wvlU/Qim
   7H85zNUfD0bgdP3OY8T/yTvefOWC+XFTFdJeFvyIV7ZrJy87J4mzettYl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4151842"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4151842"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:48:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13623016"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 01:48:26 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 01:48:25 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 01:48:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 01:48:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 01:48:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/4N5SvPtKXUYtuJCnQrvReh1hGivsXQe0GUYU4aoQ6/D+b+UtCkfJK/5h+8Ax67+dPDiRZbWVRwxr9crPKmkXT8x1ZZ6wtmVoomZIsvA8yrWxHxSS9Vn3o7H4l3QvwEY/sB0XNedaMh8q6HmeRH/94iOK2RNPHO22MplkfNF1zvc9S7DfNLZ+fv200/2cKk8w/rhyzNOrV//eItfM+Aj8BJahO81J8994CR/K2sNc7JXj4sDP0LvzNpAE/LDR4p6xUBFvSkks7PC1H+le5cv9IkvwOUbqDRdnYBIQRfi4QshRuDwDGU6uLQG28gs+s/NH+6Q2oEzdbQJ8SYMlnfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlNrv0HUEedR9mjf3vgaF/WgWcti0/qbi8NnmBtEjAI=;
 b=GpqHjhRohM2zFlH0g9KPeiDf4hIvyo4rC1Iydds7hn0bRkFg2Vh3dDQq8jURVxyve0FuH5yUVaOESVFvD5Z4iYiaCa0083uCFTZtMkTpC0WrOku7AiCuMoWDuxWz/y0PpmislXb8sjWVWSKYehJJsOV37zff2v7mnAVaxpaaThgkk5RioHH9aBO2xg0C2/NIaMfCX4HcEtfmecWuT8+tKG9UdvIH+nERTVOEf6bXPo8lDisjero1zw4lYX76m92RHCnsP32CQOtH4Enf5CmnnR/ZXz4V/Rr6MjEoqorYWcGChm3ncy9nhhYF8Z5muI/INeAYbSRb+NZw9+9g7K3KTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 MW4PR11MB8267.namprd11.prod.outlook.com (2603:10b6:303:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 09:48:22 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 09:48:22 +0000
Date: Mon, 4 Mar 2024 17:18:30 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>,
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Erdem Aktas <erdemaktas@google.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Gonda
	<pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, Chao Peng
	<chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>,
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>,
	<jmattson@google.com>, <dmatlack@google.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v5 10/29] KVM: selftests: TDX: Adding test case for
 TDX port IO
Message-ID: <ZeWR5loUdXfMm/Wp@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-11-sagis@google.com>
 <ZeUvtzHmMo9jdMnu@yzhao56-desk.sh.intel.com>
 <0344d85f-d6ab-4d78-abac-d0293d71ef91@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0344d85f-d6ab-4d78-abac-d0293d71ef91@linux.intel.com>
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|MW4PR11MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d334e4f-9aee-48d4-4a41-08dc3c303a70
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDuEhkjDKS/PSsI+G17C5nAeuo1EOt4JqtJaJkMkbZOxExzratF4FzURIp9+5Cqh2rACZ6xXyHbeHBGQhuaLLdHKZ1Y39e1IgPKF6VmwASpNc2F22UlIW6+82AqWrj8sXSxdOB1MzD/rEOGa3LtejoCLhzVprgzoNaeVCWvrXzJ2JgO94jTB1Ao2iu8De3/h8yIcELj219Qrfl3DaW+PXkdxKb4iWuLMsVp33nRJPvUTYiB+g1TbSl290xesG2sFbNxtMVY/y6en/YvpTibRtRY60Whn59x/+IDfNczgwlHILXMnC78A6fzpgkc/xh4VG2TVyz4ks9YrcT2FMgP/TOYQoDDhuZGUAO6Pf/aoAt1Tle0rOflbkHywKT5jylmhEk9qIcXuDa3CNKUn4Xr4lnCXeXWi9dw0r1dlPbrShX2eDjaX0/jZGjSrUJc7d8VaaRsCF/6Udy9snd+ntc7B/9oiw2mZygDba2ezbtl6f6ey+I8wi8LYs8jaFyCBKsQYxFV0QD6E/u9lTPQ6EIct1NZsmuLl20lD5SjoyYQwmXbsjJiARpZoYfluoyimYT6fGYA+p1duLJrJcVeD2CbYdCfUCw5bSSSxmi2kzfxIzEODhgxxn+Mu0burhpJiHkzbACx+//fvQKWrAIcpxYXcizhthlgHNrG1K4h1Dj7JWEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qFFul5d2jTDHufIItg37dKIPkoFpBB13+3T9JarGhFrIJTbi/SqS88Se5OP4?=
 =?us-ascii?Q?h3v8WThvmVsg3oKC3OryS1rhECb99XO2Cvcom7/bDgsc2aSReURiz3ewX1q4?=
 =?us-ascii?Q?8u0kaEFy8gra/W4wL6KB/5vnJnm+mJVMar9ikFtGCnzT/ifdYseS/HWLWutY?=
 =?us-ascii?Q?eIl6Sv7rDPPk434a7sc4gfu3DAhY9ms7TPbsL7maCJPK6wPQuCX9ow+P1BCn?=
 =?us-ascii?Q?STt5wj8QhSiUdClcckVAmjBYB9+05rg+ChgMQOrOsA6RL0V6oh5FqD1eDUcH?=
 =?us-ascii?Q?Nz675t2EzkVlMNdjPnAWu6B144wWGot0D2H6pZWzS83A8AlhTCrMWIEShXpH?=
 =?us-ascii?Q?viX1o807LpJeMiM1efRD90s7jHb53Pjx1Qf15AXlZxf+SW9eYfcMfOsxUNce?=
 =?us-ascii?Q?y6PpJp7H5MEbcRyAPCI1CdrO1VN7vSC5j3fyrD7EXniKuA2id3RgCfdPZ4an?=
 =?us-ascii?Q?N4gvceIbfYuwSv6t/vbEj0pcS8p967cAsvouRYAL3/hnE2eSqlTFUBvtMWyC?=
 =?us-ascii?Q?dbc5B5e5mrPv8OODqviBLHRVruJkSqlKoTXjjqGjlSXkiXv3gJ/lBqmTTuQ5?=
 =?us-ascii?Q?FafL0OZXLllW6RKartfU4iQf1ISSL71HVE5gN3gypwtwhQC8Fqwq1uWkDRbQ?=
 =?us-ascii?Q?VUbpibmE+LB2G3mGMxd9yrYNj8vrFc0OktqeAY6rX4JIxtI92E5nAA13C6pj?=
 =?us-ascii?Q?IQ+wtPJOxjep3Va4TNfD/xBRSG9KvW7z5hd/w8aF517uyRQN80NMgO93U1OJ?=
 =?us-ascii?Q?ANas+vIVNBRqjnTu4XIGs4OsoVl61aReSf01PIQG81+xiPcD8ekGV+LwgdXN?=
 =?us-ascii?Q?8Y/55HG5YjBELrayggYvogJwN8kmOxbjFlK/dnWwWsFzWgg7NXqV6yAlgMOK?=
 =?us-ascii?Q?nxX5vp7R2uLbRChH52mVXkEsMun1c2YKSEbN1bZJ1hwViW33tVn7lT0vQt7g?=
 =?us-ascii?Q?MmtTUFLPaW99m0sKD4TIs4ZwqnpfHSOy08Nc8wUtaYu1l7HSP7V9zZpJ4kZs?=
 =?us-ascii?Q?ddxL4cYn0T3MBdv422ADYvEwhl54Ps1Jn6w6OP2CCLWvLRPP66X+qbRsgCfa?=
 =?us-ascii?Q?DhJBC4MifDsM/tswLxGPYw+W/tZIAMwUBcOojGZVX+5Akl37op4lJxaF9EHr?=
 =?us-ascii?Q?n0Kl/ssyVQ4BLdYJdKxMqgL6/ei+7dg/lU8al9ABXilpu9gJC/YF61R6oNhy?=
 =?us-ascii?Q?PuZneS7r38xU1JQgtLAERE3wTShkoYZcV91uYckS7iS+hMF0rIydiQ1EUa9c?=
 =?us-ascii?Q?Mj50tQNSzd80J35v4HeSU9q8czgrCsMACqPxL1fyqIHuJl2JJTc0h9aiv82z?=
 =?us-ascii?Q?/TKc0GVVunG+pDe/+QaqSfxdCXBQ7kn4NdIv1o6M5FB56IS+YcgHtSgi64Qi?=
 =?us-ascii?Q?823vnY5ZIW3oseKSK0rvLv0GPlZNDCSyoqeLlNgKYHZ6fgQV2R1hzIgntT/w?=
 =?us-ascii?Q?4SByZRQlu8jb2wVAI1FiuXhuVXfVt5UjD+zOgiysvW0weQJe+bl1fg1RsUmN?=
 =?us-ascii?Q?pg7stPBRcL0Z/5tHkyHRnC/TShMzvL5GLcw1psll08RUSbxLMyv2lkqFdKu4?=
 =?us-ascii?Q?+mCrUmx8bAlOqRyR0XzHYH23PGfuUkrBhW9iVeM4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d334e4f-9aee-48d4-4a41-08dc3c303a70
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:48:22.1772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4+VzFN9UYhWUDbX6tvcDBoXOh9TBYorTRnLxL0OiwuHuUJjY/emCffxLNUu/s6cROZ/XPto3b6gI5Na5bb8yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8267
X-OriginatorOrg: intel.com

On Mon, Mar 04, 2024 at 05:16:53PM +0800, Binbin Wu wrote:
> 
> 
> On 3/4/2024 10:19 AM, Yan Zhao wrote:
> > On Tue, Dec 12, 2023 at 12:46:25PM -0800, Sagi Shahar wrote:
> > > From: Erdem Aktas <erdemaktas@google.com>
> > > 
> > > Verifies TDVMCALL<INSTRUCTION.IO> READ and WRITE operations.
> > > 
> > > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > > Signed-off-by: Sagi Shahar <sagis@google.com>
> > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > Signed-off-by: Ryan Afranji <afranji@google.com>
> > > ---
> > >   .../kvm/include/x86_64/tdx/test_util.h        | 34 ++++++++
> > >   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 82 +++++++++++++++++++
> > >   2 files changed, 116 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> > > index 6d69921136bd..95a5d5be7f0b 100644
> > > --- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> > > +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> > > @@ -9,6 +9,40 @@
> > >   #define TDX_TEST_SUCCESS_PORT 0x30
> > >   #define TDX_TEST_SUCCESS_SIZE 4
> > > +/**
> > > + * Assert that some IO operation involving tdg_vp_vmcall_instruction_io() was
> > > + * called in the guest.
> > > + */
> > > +#define TDX_TEST_ASSERT_IO(VCPU, PORT, SIZE, DIR)			\
> > > +	do {								\
> > > +		TEST_ASSERT((VCPU)->run->exit_reason == KVM_EXIT_IO,	\
> > > +			"Got exit_reason other than KVM_EXIT_IO: %u (%s)\n", \
> > > +			(VCPU)->run->exit_reason,			\
> > > +			exit_reason_str((VCPU)->run->exit_reason));	\
> > > +									\
> > > +		TEST_ASSERT(((VCPU)->run->exit_reason == KVM_EXIT_IO) && \
> > > +			((VCPU)->run->io.port == (PORT)) &&		\
> > > +			((VCPU)->run->io.size == (SIZE)) &&		\
> > > +			((VCPU)->run->io.direction == (DIR)),		\
> > > +			"Got unexpected IO exit values: %u (%s) %d %d %d\n", \
> > > +			(VCPU)->run->exit_reason,			\
> > > +			exit_reason_str((VCPU)->run->exit_reason),	\
> > > +			(VCPU)->run->io.port, (VCPU)->run->io.size,	\
> > > +			(VCPU)->run->io.direction);			\
> > > +	} while (0)
> > > +
> > > +/**
> > > + * Check and report if there was some failure in the guest, either an exception
> > > + * like a triple fault, or if a tdx_test_fatal() was hit.
> > > + */
> > > +#define TDX_TEST_CHECK_GUEST_FAILURE(VCPU)				\
> > > +	do {								\
> > > +		if ((VCPU)->run->exit_reason == KVM_EXIT_SYSTEM_EVENT)	\
> > > +			TEST_FAIL("Guest reported error. error code: %lld (0x%llx)\n", \
> > > +				(VCPU)->run->system_event.data[1],	\
> > > +				(VCPU)->run->system_event.data[1]);	\
> > > +	} while (0)
> > > +
> > >   /**
> > >    * Assert that tdx_test_success() was called in the guest.
> > >    */
> > > diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> > > index 8638c7bbedaa..75467c407ca7 100644
> > > --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> > > +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> > > @@ -2,6 +2,7 @@
> > >   #include <signal.h>
> > >   #include "kvm_util_base.h"
> > > +#include "tdx/tdcall.h"
> > >   #include "tdx/tdx.h"
> > >   #include "tdx/tdx_util.h"
> > >   #include "tdx/test_util.h"
> > > @@ -74,6 +75,86 @@ void verify_report_fatal_error(void)
> > >   	printf("\t ... PASSED\n");
> > >   }
> > > +#define TDX_IOEXIT_TEST_PORT 0x50
> > > +
> > > +/*
> > > + * Verifies IO functionality by writing a |value| to a predefined port.
> > > + * Verifies that the read value is |value| + 1 from the same port.
> > > + * If all the tests are passed then write a value to port TDX_TEST_PORT
> > > + */
> > > +void guest_ioexit(void)
> > > +{
> > > +	uint64_t data_out, data_in, delta;
> > > +	uint64_t ret;
> > > +
> > > +	data_out = 0xAB;
> > > +	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
> > > +					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> > > +					&data_out);
> > > +	if (ret)
> > > +		tdx_test_fatal(ret);
> > > +
> > > +	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
> > > +					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
> > > +					&data_in);
> > > +	if (ret)
> > > +		tdx_test_fatal(ret);
> > > +
> > > +	delta = data_in - data_out;
> > > +	if (delta != 1)
> > > +		tdx_test_fatal(ret);
> > > +
> > > +	tdx_test_success();
> > > +}
> > > +
> > > +void verify_td_ioexit(void)
> > > +{
> > > +	struct kvm_vm *vm;
> > > +	struct kvm_vcpu *vcpu;
> > > +
> > > +	uint32_t port_data;
> > > +
> > > +	vm = td_create();
> > > +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> > > +	vcpu = td_vcpu_add(vm, 0, guest_ioexit);
> > > +	td_finalize(vm);
> > > +
> > > +	printf("Verifying TD IO Exit:\n");
> > > +
> > > +	/* Wait for guest to do a IO write */
> > > +	td_vcpu_run(vcpu);
> > > +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> > This check is a vain, because the first VMExit from vcpu run is always
> > KVM_EXIT_IO caused by tdg_vp_vmcall_instruction_io().
> 
> I think tdg_vp_vmcall_instruction_io() could fail if RCX (GPR select)
> doesn't
> meet the requirement (some bits must be 0).
> Although RCX is set by guest code (in selftest, it set in __tdx_hypercall())
> and it will not trigger the error, it still can be used as a guard to make
> sure guest doesn't pass a invalid RCX.
>
Right. This check can be kept in case an failure is delivered to TD in host
kernel directly, though it cannot guard if the failure will trigger an
exit to user space (e.g. if kernel TDX code has a bug).
> 
> > 
> > 
> > > +	TDX_TEST_ASSERT_IO(vcpu, TDX_IOEXIT_TEST_PORT, 1,
> > > +			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> > > +	port_data = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
> > > +
> > > +	printf("\t ... IO WRITE: OK\n");
> > So,  even if there's an error in emulating writing of TDX_IOEXIT_TEST_PORT,
> > and guest would then find a failure and trigger tdx_test_fatal(), this line
> > will still print "IO WRITE: OK", which is not right.
> > 
> > > +
> > > +	/*
> > > +	 * Wait for the guest to do a IO read. Provide the previous written data
> > > +	 * + 1 back to the guest
> > > +	 */
> > > +	td_vcpu_run(vcpu);
> > > +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> > This check is a vain, too, as in  write case.
> > 
> > > +	TDX_TEST_ASSERT_IO(vcpu, TDX_IOEXIT_TEST_PORT, 1,
> > > +			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
> > > +	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = port_data + 1;
> > > +
> > > +	printf("\t ... IO READ: OK\n");
> > Same as in write case, this line should not be printed until after guest
> > finishing checking return code.
> > 
> > > +
> > > +	/*
> > > +	 * Wait for the guest to complete execution successfully. The read
> > > +	 * value is checked within the guest.
> > > +	 */
> > > +	td_vcpu_run(vcpu);
> > > +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> > > +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> > > +
> > > +	printf("\t ... IO verify read/write values: OK\n");
> > > +	kvm_vm_free(vm);
> > > +	printf("\t ... PASSED\n");
> > > +}
> > > +
> > >   int main(int argc, char **argv)
> > >   {
> > >   	setbuf(stdout, NULL);
> > > @@ -85,6 +166,7 @@ int main(int argc, char **argv)
> > >   	run_in_new_process(&verify_td_lifecycle);
> > >   	run_in_new_process(&verify_report_fatal_error);
> > > +	run_in_new_process(&verify_td_ioexit);
> > >   	return 0;
> > >   }
> > > -- 
> > > 2.43.0.472.g3155946c3a-goog
> > > 
> > > 
> 


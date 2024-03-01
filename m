Return-Path: <linux-kselftest+bounces-5717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F68E86E12E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 13:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617601C21F26
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 12:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380A51EB2A;
	Fri,  1 Mar 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0MeRiZh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC77E1;
	Fri,  1 Mar 2024 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296795; cv=fail; b=VY79dR2avRDCzg9XkG5ZzmYLk/I1G2mkj72sewawJLs/GVok1Queaz/QE5KnRmbX6KaGyHLpbRQyr1jgs3j6tb/fjh/Dym4a6d/J3EczjzY+Qf7Wnk3wZft+H6HtWtWvQIMztOFvG7aPLh+38oJhd2Us+5w69Fg+VHHyzck6ZgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296795; c=relaxed/simple;
	bh=0kHydrBXHrz4JSla8xX7/NFYk79KGdBS6WMJlhqmTW8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t/1WxWROQeFDEzhbTxEh6jvF3FBumN6tNapQ6P72wY/YTOL+jNwhYz7slwyMSUWMKUivEFUxTVeg0/bBK+ivW0ovYI0nV/D0LkpzIj+7jBnr/CaR20hbzsmAvix2grebUAEkAlHmS8kPHSyA2TXTfDjR77ILQdboNoEz9IEh8bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0MeRiZh; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709296793; x=1740832793;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=0kHydrBXHrz4JSla8xX7/NFYk79KGdBS6WMJlhqmTW8=;
  b=g0MeRiZhzS1YwR6vDi1J2F5CDYW8GV0kvBZEFHpLvrQzipVllLleo/SQ
   q+u4KreRi26AENGKfQA10Hk2z4JLQm1yBUkk+sAsqSjKevIPp+CjJBeEf
   E3FOKS6Pj8egEu7ypjLD9H6w9aPJVrh5TWYhRRXvu5/EGSveXmYn4XO21
   7hmI+9oHcw8VqRLzW1GNd6HsSboLTBrUP217+DHAhQ0Fo5Fp2HfMhyUQF
   vZwozr43nCmIheEjpXIwF8sOLHQZKXoMhy7QsvnAavtoUFr9BbuonTZkj
   dbqtDTMQePFqL+0Yle4cWMEOyUcFYgz3JRtRF5WDuIVmrn8NeF7T2/m3d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14980110"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="14980110"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 04:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="12896463"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 04:39:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 04:39:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 04:39:51 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 04:39:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0812qo0mcyij3Jb6SbUmZ5ZhhoPgano46ingZXh38LF7l4mEXyXMh8j8WIOhIugxI+3q+uEqyUrY3Z2LEykRLZyg7sCAPLWb3M6SG8dWWI0AUwK0RCoEFOWxv2D1wLKXW/spNU8YXiMK1sbHfiA/lm2Fk3zryYpG+wKSozrOBGDiHnxTqyjEV7S3E/psrE0TMmirPONd2AVx84HQWVWUxC0tnNgQiMaCon9/2iMaAlZDdp0l3F41wPYbveLJevLxQt/9WiLwLY2uAmeeSNKGa/5dQYx7/sH5bsxh3dhy2ihIhnlaNR81McW8xrSYt/BNvLTUX6JJ2QoeXM25mmsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAX59IPuBE/9jqFJlNZJvDTxoqbAq0MGafY9EJxVPoA=;
 b=kJ3pzGy/B2lhx0V5AJ1DpPaFk8GWPYK6S1z7VFBxxazVToAH6cFJGDbpXwcw4NBDCyu4T2oxSywil46xMNxCi9aS36sD4e2ogJsBUtaw1jlFdUfEnHrbh/rm+7EK9BSjc85A04Gvfgx1aEEMU8OUKVyuCnkxvzbMzOtlXayMzWE72uKav0WdlS4RzAqgcYfjotgkfjzERRIRbz9e0GFYQy4o4NUnKnIR60BQAJ7slMuc/19EaM2iGDT7vtXNBdAA90eJUXz38nxULpQxaBIIxHNg5b3IgbZlboAw1XGsBbKnFoXwHyNLY9wMZ2ZdxfnPotwCgnjQPpwwgB8myt1VqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.25; Fri, 1 Mar 2024 12:39:48 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.013; Fri, 1 Mar 2024
 12:39:48 +0000
Date: Fri, 1 Mar 2024 20:09:58 +0800
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
Subject: Re: [RFC PATCH v5 09/29] KVM: selftests: TDX: Add report_fatal_error
 test
Message-ID: <ZeHFlsrBKWR6bfRZ@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-10-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-10-sagis@google.com>
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SJ0PR11MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ed82be-420b-495e-ba7c-08dc39ecae6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffuiH00g7XIUPpxmFwejutTR4881ywyD82ZIBSbskemrA71WIqE0YLAhIO0LBGEH3/k1eTkV3pdxRmZW0YyoQ6DtQ1l4OQ7libN8PlTGp8mvY81ccvIpyEsfaJE+KGAP6zkWBOdHl53xR3nvf+iSMJchEDVT2rUsFSaKTfOnTS/XvDdbN1D5mYC3zH5iFHpxDJwodpyMYNTpUn5/sVVLzddpyduGl0K7FJ/rX/4nVNytkFSvIqUOrdeTx21OIYY4gdRsgq/IdKKzGV+Nql0VEbphB3dWdbj6rWmaiJRCPmlyquk7XnqncUe0p7bJwmX1ypNDS6kEOwL+bnAdTZYk7V+X0fSeIK2Q0lnoIiQbNPWX9gC5p3ArIt2zMOUKYU+X+aFxT0h4GGe++VroT9q4WVy3wYOxHKs5he8M0+FDEkEmRK9PZnWvXZ8wTYdxb0BjIlbpTKUZ5FD8xN2Amq24EzRJCwx0kg0JyedSmNK74oAfY+gonq4w4ZSvkjydYSJjoi92kLZymX3g2ZkHZDU0TrdzFv9aAgoQB5CEXDkpeB2ZMVPl39jQ8rhJ/5eg7aJCCLG5F6dzf9RZLnymRBJCwXiHk5u/oFQ2W9ed8g0UN0Hrzq7u1s2GCCQNgCfefVJEjjE+UvdDskUx3PS85Ng7Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n2TOOaS0gSwWZdcGeAp8XwHpt6Gx/KzOdNesOQVjbKesGmjy0SutK4xVD7sY?=
 =?us-ascii?Q?QQU5aXn5sX6wNlsiFM0t8BVQ0vDjWxqNzygmKwMwiaOB4q6cWPXXr2tqrtS9?=
 =?us-ascii?Q?jWpPQIXy3MBt+DkfUoehPdGt1OFlff30Qr6NdAPNqCbEFRBOwPJXRAZGAkgL?=
 =?us-ascii?Q?qGIY1lDv/lHs2ueDcgS6PaqHUmqrrXeuKRBSrasCIDOEmK54xLxqxn7G6Vl+?=
 =?us-ascii?Q?iXUJOMcG/8Mfd09IWtZXVN3MvX/eCE/UVG38Pz1wYjHszaJ76p3mK03JqROF?=
 =?us-ascii?Q?O/keV1KPSe643HylLlszp6iP73xKDvrUiCMv7NkrTy26f6kG86OMALzpyXQk?=
 =?us-ascii?Q?rtyE7GNCP/c3KP/3BnkuRu39kj0p/6eNJiX6wzsYfRaHi7Rl1J65gB/o/Q/Y?=
 =?us-ascii?Q?JZsSiEYE625CxKXHXJR5C5pBli8V6CABpKfljoVNq/eAcHUJNPvm/ZOjZwOx?=
 =?us-ascii?Q?SW4EDq0FJi0SkPR4JE19Vs4AyAqeB/T8TFnj608Co0RgKKpaExfyBXRMXSoB?=
 =?us-ascii?Q?YXQxz87Qh2c28Qgy+YpW8PUimVEhQSYyJd3PJcNhbVTjiiQi7Y/F1Q+PVaXx?=
 =?us-ascii?Q?k9KZ5nGb2amx97V3qvtxcCpMrUHBJiyGe1gazXNU2/0biEpJ0+ys3/20RSwQ?=
 =?us-ascii?Q?27aryulyruHG6HY2NoKj9eu6wo4G8m44rtuQgjnpnuL/ppDLFeu35E2MUdy6?=
 =?us-ascii?Q?8GruBnoEUl/tjV/gZ/4IwAqXM2tDKB1eGFAZEspvbL0XGRWRNANh1iyFqZzV?=
 =?us-ascii?Q?paWub5zYAVwY+sIo5yNdrIS/qlxFEXLZY6bcqL/iLBbqnDTod+7vDXe+sMeE?=
 =?us-ascii?Q?Sl6z6ng7i+OV6Olwenxry9ZWma6EROldsBLL+i0MPsqtA4ganJHbeqJd3S0H?=
 =?us-ascii?Q?t3HzgGS7n/5t+GjngpIo0WIc9/7xtHvdUb8JjO3zH5rLy5p/Cy7KBxC/BwxK?=
 =?us-ascii?Q?UNiQIzUOhBL0/eWMFNEKuvzXkjzzrha2oT3dV8dfgyg/h0cYvGr/XmtsJvBr?=
 =?us-ascii?Q?W66n1tN84qxsj2/acHTIFb63RYsy1Ff1iQF9USOkb5joAT8/hfI4VbAdOlVU?=
 =?us-ascii?Q?wI31uBUcnJdcXZz+mm/3StK1bL/50e+Fir5qiv5kPzx7kJR6eEcCq2WR6EaU?=
 =?us-ascii?Q?b/BcrbPju2bW4EdQWEu+kzSCQr9RR0/8Lw+5C+9e8pZ/hcM0VPfTW1QJTY69?=
 =?us-ascii?Q?IlmN65wYQrA4y1Od5y7wFdO0dJIXa5lEEo1GrJZg+t99HoymKNarS5lNctbO?=
 =?us-ascii?Q?BqYCMLActQvO8ek9QSPl3ijkvZXzcc8LS+Z4CZ6JkxRkjwnnSb3dP0nQ6YkE?=
 =?us-ascii?Q?knScFGZHQS2Zyr6PMqg0mTVvbd08HJNZvs812k71vnlDX3ssvoXe1WKk3tMf?=
 =?us-ascii?Q?7x+Z69exn0rryFd1MdS0DYGsefRMxIxyUvY22uPq6nkOYrwdCwCjDchH/zTx?=
 =?us-ascii?Q?dOAEPWqZxIyINQwBw2vqtaCsV22xOZeOj5hC2cz9zzitVxE01ZKIDdHbHqzL?=
 =?us-ascii?Q?BUx5+RVw0V184wvQKl1cA6AxzmlEZ7SoLgpEQ0gaWVC3n5ktZS/uVHDG4NcE?=
 =?us-ascii?Q?VaY/abSe6BUbIygj18+BtsoXs7g/rToOzii2Qn0G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ed82be-420b-495e-ba7c-08dc39ecae6f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 12:39:48.4753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ME9CDsXLOUEfe7sJpeztBBPuw3TtrzEd9RZ1CJ/MlUipCwWNfICl7fMYeAQWyICMNtq+UIek5WtbFuAKxqXpDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com

...
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> index b570b6d978ff..6d69921136bd 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> @@ -49,4 +49,23 @@ bool is_tdx_enabled(void);
>   */
>  void tdx_test_success(void);
>  
> +/**
> + * Report an error with @error_code to userspace.
> + *
> + * Return value from tdg_vp_vmcall_report_fatal_error is ignored since execution
> + * is not expected to continue beyond this point.
> + */
> +void tdx_test_fatal(uint64_t error_code);
> +
> +/**
> + * Report an error with @error_code to userspace.
> + *
> + * @data_gpa may point to an optional shared guest memory holding the error
> + * string.
> + *
> + * Return value from tdg_vp_vmcall_report_fatal_error is ignored since execution
> + * is not expected to continue beyond this point.
> + */
> +void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
I found nowhere is using "data_gpa" as a gpa, even in patch 23, it's
usage is to pass a line number ("tdx_test_fatal_with_data(ret, __LINE__)").


>  #endif // SELFTEST_TDX_TEST_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> index c2414523487a..b854c3aa34ff 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -1,8 +1,31 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
> +#include <string.h>
> +
>  #include "tdx/tdcall.h"
>  #include "tdx/tdx.h"
>  
> +void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_tdx_vmcall *vmcall_info = &vcpu->run->tdx.u.vmcall;
> +	uint64_t vmcall_subfunction = vmcall_info->subfunction;
> +
> +	switch (vmcall_subfunction) {
> +	case TDG_VP_VMCALL_REPORT_FATAL_ERROR:
> +		vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
> +		vcpu->run->system_event.ndata = 3;
> +		vcpu->run->system_event.data[0] =
> +			TDG_VP_VMCALL_REPORT_FATAL_ERROR;
> +		vcpu->run->system_event.data[1] = vmcall_info->in_r12;
> +		vcpu->run->system_event.data[2] = vmcall_info->in_r13;
> +		vmcall_info->status_code = 0;
> +		break;
> +	default:
> +		TEST_FAIL("TD VMCALL subfunction %lu is unsupported.\n",
> +			  vmcall_subfunction);
> +	}
> +}
> +
>  uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>  				      uint64_t write, uint64_t *data)
>  {
> @@ -25,3 +48,19 @@ uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>  
>  	return ret;
>  }
> +
> +void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa)
> +{
> +	struct tdx_hypercall_args args;
> +
> +	memset(&args, 0, sizeof(struct tdx_hypercall_args));
> +
> +	if (data_gpa)
> +		error_code |= 0x8000000000000000;
> 
So, why this error_code needs to set bit 63?


> +	args.r11 = TDG_VP_VMCALL_REPORT_FATAL_ERROR;
> +	args.r12 = error_code;
> +	args.r13 = data_gpa;
> +
> +	__tdx_hypercall(&args, 0);
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> index b302060049d5..d745bb6287c1 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> @@ -10,6 +10,7 @@
>  
>  #include "kvm_util.h"
>  #include "test_util.h"
> +#include "tdx/tdx.h"
>  #include "tdx/td_boot.h"
>  #include "kvm_util_base.h"
>  #include "processor.h"
> @@ -519,3 +520,14 @@ void td_finalize(struct kvm_vm *vm)
>  
>  	tdx_td_finalizemr(vm);
>  }
> +
> +void td_vcpu_run(struct kvm_vcpu *vcpu)
> +{
> +	vcpu_run(vcpu);
> +
> +	/* Handle TD VMCALLs that require userspace handling. */
> +	if (vcpu->run->exit_reason == KVM_EXIT_TDX &&
> +	    vcpu->run->tdx.type == KVM_EXIT_TDX_VMCALL) {
> +		handle_userspace_tdg_vp_vmcall_exit(vcpu);
> +	}
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> index 6905d0ca3877..7f3cd8089cea 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> @@ -32,3 +32,13 @@ void tdx_test_success(void)
>  				     TDX_TEST_SUCCESS_SIZE,
>  				     TDG_VP_VMCALL_INSTRUCTION_IO_WRITE, &code);
>  }
> +
> +void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa)
> +{
> +	tdg_vp_vmcall_report_fatal_error(error_code, data_gpa);
> +}
> +
> +void tdx_test_fatal(uint64_t error_code)
> +{
> +	tdx_test_fatal_with_data(error_code, 0);
> +}
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> index a18d1c9d6026..8638c7bbedaa 100644
> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -2,6 +2,7 @@
>  
>  #include <signal.h>
>  #include "kvm_util_base.h"
> +#include "tdx/tdx.h"
>  #include "tdx/tdx_util.h"
>  #include "tdx/test_util.h"
>  #include "test_util.h"
> @@ -30,6 +31,49 @@ void verify_td_lifecycle(void)
>  	printf("\t ... PASSED\n");
>  }
>  
> +void guest_code_report_fatal_error(void)
> +{
> +	uint64_t err;
> +
> +	/*
> +	 * Note: err should follow the GHCI spec definition:
> +	 * bits 31:0 should be set to 0.
> +	 * bits 62:32 are used for TD-specific extended error code.
> +	 * bit 63 is used to mark additional information in shared memory.
> +	 */
> +	err = 0x0BAAAAAD00000000;
> +	if (err)
> +		tdx_test_fatal(err);
> +
> +	tdx_test_success();
> +}
> +void verify_report_fatal_error(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_code_report_fatal_error);
> +	td_finalize(vm);
> +
> +	printf("Verifying report_fatal_error:\n");
> +
> +	td_vcpu_run(vcpu);
> +
> +	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 3);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.data[0], TDG_VP_VMCALL_REPORT_FATAL_ERROR);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.data[1], 0x0BAAAAAD00000000);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.data[2], 0);
> +
> +	vcpu_run(vcpu);
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	setbuf(stdout, NULL);
> @@ -40,6 +84,7 @@ int main(int argc, char **argv)
>  	}
>  
>  	run_in_new_process(&verify_td_lifecycle);
> +	run_in_new_process(&verify_report_fatal_error);
>  
>  	return 0;
>  }
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 


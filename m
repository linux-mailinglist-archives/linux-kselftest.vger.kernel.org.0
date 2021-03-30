Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD6334F189
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Mar 2021 21:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhC3T0U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Mar 2021 15:26:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:14266 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233084AbhC3T0B (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Mar 2021 15:26:01 -0400
IronPort-SDR: L9sJ7igl1phoiIEXAuQ9xJl3YrFkr5VLBPwSCegmCvDwewQjFDw4MBYaP7f9zeWRHhi9PKl6Gi
 leJ92X76RCfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="171863215"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="171863215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 12:25:59 -0700
IronPort-SDR: s4znUWJU2XXel6e0JhbKBdQEeigoyLFbRp7i1UPfMAnK5HT36ADEossmBe48hJB8pmJGbEO6H8
 JDsDlUuZuNdA==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="418305275"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 12:25:58 -0700
Date:   Tue, 30 Mar 2021 12:25:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V4 07/10] x86/pks: Preserve the PKRS MSR on context switch
Message-ID: <20210330192558.GD3014244@iweiny-DESK2.sc.intel.com>
References: <20210322053020.2287058-1-ira.weiny@intel.com>
 <20210322053020.2287058-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322053020.2287058-8-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[snip]

<self review>

The test bot reported build errors on i386 yesterday.  Not sure why they were
not caught before...

Anyway that caused me to look at this patch again and I've found a couple of
issues noted below.  Combined with Sean's review I'll be re-spinning a new v5.

> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 546d6ecf0a35..c15a049bf6ac 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -765,6 +765,7 @@
>  
>  #define MSR_IA32_TSC_DEADLINE		0x000006E0
>  
> +#define MSR_IA32_PKRS			0x000006E1

This belongs in patch 5 where it is 'used'.  Note that nothing is really used
until the final test patch...  But in review this define does not make any
sense here...

>  
>  #define MSR_TSX_FORCE_ABORT		0x0000010F
>  
> diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
> index 0681522974ba..6917f1a27479 100644
> --- a/arch/x86/include/asm/pkeys_common.h
> +++ b/arch/x86/include/asm/pkeys_common.h
> @@ -17,4 +17,18 @@
>  #define PKR_AD_KEY(pkey)     (PKR_AD_BIT << PKR_PKEY_SHIFT(pkey))
>  #define PKR_WD_KEY(pkey)     (PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))
>  
> +/*
> + * Define a default PKRS value for each task.
> + *
> + * Key 0 has no restriction.  All other keys are set to the most restrictive
> + * value which is access disabled (AD=1).
> + *
> + * NOTE: This needs to be a macro to be used as part of the INIT_THREAD macro.
> + */
> +#define INIT_PKRS_VALUE (PKR_AD_KEY(1) | PKR_AD_KEY(2) | PKR_AD_KEY(3) | \
> +			 PKR_AD_KEY(4) | PKR_AD_KEY(5) | PKR_AD_KEY(6) | \
> +			 PKR_AD_KEY(7) | PKR_AD_KEY(8) | PKR_AD_KEY(9) | \
> +			 PKR_AD_KEY(10) | PKR_AD_KEY(11) | PKR_AD_KEY(12) | \
> +			 PKR_AD_KEY(13) | PKR_AD_KEY(14) | PKR_AD_KEY(15))

The same is true for this macro.  While it is used in this patch it is used
first in patch 5.  So it should be there.

I'm letting 0-day crank on these changes but there should be a v5 out very
soon.

Sorry for the noise,
Ira


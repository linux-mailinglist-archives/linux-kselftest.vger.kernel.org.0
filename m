Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1396344A85
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 17:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhCVQGk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 12:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhCVQFv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 12:05:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87064C061756
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Mar 2021 09:05:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 11so11250057pfn.9
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Mar 2021 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+S7gjt3MgnLDrdKzofrJNhS6p4rg7p4WBFZi5EQinSg=;
        b=Wy7l0LMnDchSVa4nHZzPzMiZRnITpR4PoPerfT2iHAmIT9Ejdvj8Gwb3rryaLfhDbk
         WUOkBltZS5qEqozQ7KJcx0lI5aPMtp5JR3fkcbA4CoiKDu9QyojCDR8TNEmeqBHRsJYm
         2fu3KpROUDNMpadlTB/vIT5rnme9urvpGX25MGZMgQdGQFq7t9RqvQjIJIBZs+BdtCH7
         c16cz7mD9dsSrepz9Nuq4m+s993K8y7wq/D1qva8C0RrSD6RAn8/cEFI0Adnstc0B8Bk
         9lC/cW6pFRcjegMSo89u8RGktQHjVyQow8Igb3Deyga/a0pmq7ZRZCHvArz1qbebRQ4r
         MRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+S7gjt3MgnLDrdKzofrJNhS6p4rg7p4WBFZi5EQinSg=;
        b=bH3Gkti92/7LFWsJ3fwPyG4QMsHasYZujdvwQN2IG3tJ3PITLbGV53bMJqWw4O9TrF
         AYKT2jwglXw3vzz3kCQlWRUmeuRR8dOWf0SOUwcvf73s2MAXvqSroPX8JdwUDGGGNqEC
         S8hA5SSkcHpM+e/lX5VjcSfoD76+Vud7FuC9sUQSPCNqGZ295aMPza338Gw1QvLHHeV9
         bC5KglRZRLlfRCgmQ5zJPBmLPti4yPj0eiZnx1vTlHmHYNHHNdbjmwfX/H9SrXvSkB4+
         39Bj2nBnnJbDpsGOw1VT5p3rtQX+P3875pozo0Q8C14DIfrdQqv9ywicdpLDl1eyGX4Z
         aoJw==
X-Gm-Message-State: AOAM5329wwkiwjo8NvPwl8fVaNqyTloCpF3EoOZzxIj/xHKFQSwuG401
        IwwPDKEglMBPlOHUMf9v+xZMPQ==
X-Google-Smtp-Source: ABdhPJwVj7AImbLlRr23Z0RxRD8gCshqvyDN+CM5FR1pwopcAY578lpSBDBdCy1oD0l38Ko9sYF6xw==
X-Received: by 2002:a63:4761:: with SMTP id w33mr296710pgk.118.1616429150894;
        Mon, 22 Mar 2021 09:05:50 -0700 (PDT)
Received: from google.com ([2620:15c:f:10:5c8b:5536:d804:97ed])
        by smtp.gmail.com with ESMTPSA id i8sm14475167pjl.32.2021.03.22.09.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:05:50 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:05:43 -0700
From:   Sean Christopherson <seanjc@google.com>
To:     ira.weiny@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V4 06/10] x86/fault: Adjust WARN_ON for PKey fault
Message-ID: <YFjAV44u7i9t1TDL@google.com>
References: <20210322053020.2287058-1-ira.weiny@intel.com>
 <20210322053020.2287058-7-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322053020.2287058-7-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 21, 2021, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> PKey faults may now happen on kernel mappings if the feature is enabled.
> Remove the warning in the fault path if PKS is enabled.

When/why can they happen?  I read through all the changelogs, as well as the
cover letters for v1 and the RFC, and didn't see any explicit statement about
why pkey faults on supervisor accesses are now "legal".  Explaining what happens
later in the page fault handler would also be helpful, e.g. is the flag simply
ignored?  Does it lead directly to OOPS?

Documenting what happens on a PKS #PF in the API patch would be nice to have, too.

> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  arch/x86/mm/fault.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index a73347e2cdfc..731ec90ed413 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1141,11 +1141,12 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
>  		   unsigned long address)
>  {
>  	/*
> -	 * Protection keys exceptions only happen on user pages.  We
> -	 * have no user pages in the kernel portion of the address
> -	 * space, so do not expect them here.
> +	 * PF_PK is expected on kernel addresses when supervisor pkeys are

"is expected" can be misinterpreted as "PF is expected on all kernel addresses...".

This ties in with the lack of an explanation in the changelog.

> +	 * enabled.

It'd be helpful to spell out "Protection keys exceptions" so that random readers
don't need to search for PF_PK to understand what's up.  Maybe even use it as an
opportunity to introduce "pkeys", e.g.

	/* Protection keys (pkeys) exceptions are ... */

>  	 */
> -	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
> +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> +		WARN_ON_ONCE(hw_error_code & X86_PF_PK);

Does this generate the same code if the whole thing is thrown in the WARN?  E.g.

	WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS) &&
		     (hw_error_code & X86_PF_PK));

> +
>  
>  #ifdef CONFIG_X86_32
>  	/*
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 

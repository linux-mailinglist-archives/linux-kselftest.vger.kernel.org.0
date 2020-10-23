Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF0297915
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 23:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756936AbgJWVuO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 17:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756934AbgJWVuO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 17:50:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4874C0613CE;
        Fri, 23 Oct 2020 14:50:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603489811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHZqtXRz0EpqKwmVvrfGdZyZvC7siQQGSvicS0vKKBg=;
        b=0yAkbZnTwDY2ALAbXdGN6vr3ehp2VwpXNIcf51OXNu5rvFRvmCFOCTkkOciH3bsMMB1GTJ
        M49Ooo+35dE2U2EdR4GV6DqIHTyROF7HKJgwhEe+YkykUW9BNC5m+IszzFX1oA8ZEa0XuD
        1d/dCepUNoGiDlYmKWo738FoXRvvngEHtiadyKHOVShEMn5o8bVNUoOmknFSNyw0C29P1y
        lG0GxNgCHxB0lekDN0U72B9z95n6HUAC3ZK2mGWWUMRbEJvRSTaJxxe2QqwdMQCr0LGqOO
        auNEwTjIY0XSihJxFVb3YEpC1IQVLCt4JgLsfilbBuSQ9ygKHpb0dXjIER+lPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603489811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHZqtXRz0EpqKwmVvrfGdZyZvC7siQQGSvicS0vKKBg=;
        b=1RyBpBn3mRKQKuLJjCvQxmBBrnxabQDijrSaiAdGjc2n/P1b8Vr9dL2Zi4iX0nPaJ9AC7Q
        vT1Rr3Z8/S0zuhCQ==
To:     ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 06/10] x86/entry: Move nmi entry/exit into common code
In-Reply-To: <20201022222701.887660-7-ira.weiny@intel.com>
References: <20201022222701.887660-1-ira.weiny@intel.com> <20201022222701.887660-7-ira.weiny@intel.com>
Date:   Fri, 23 Oct 2020 23:50:11 +0200
Message-ID: <874kmk6298.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22 2020 at 15:26, ira weiny wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> Lockdep state handling on NMI enter and exit is nothing specific to X86. It's
> not any different on other architectures. Also the extra state type is not
> necessary, irqentry_state_t can carry the necessary information as well.
>
> Move it to common code and extend irqentry_state_t to carry lockdep
> state.

This lacks something like:

 [ Ira: Made the states a union as they are mutually exclusive and added
        the missing kernel doc ]

Hrm.
 
>  #ifndef irqentry_state
>  typedef struct irqentry_state {
> -	bool	exit_rcu;
> +	union {
> +		bool	exit_rcu;
> +		bool	lockdep;
> +	};
>  } irqentry_state_t;
>  #endif

  -E_NO_KERNELDOC

Thanks,

        tglx

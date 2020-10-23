Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F29329792A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 23:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465554AbgJWV4g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 17:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465494AbgJWV4f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 17:56:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C9DC0613CE;
        Fri, 23 Oct 2020 14:56:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603490194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79rTg2SKZLoa/evVojUPAbe7jLqXBquN2CeaB2ok8dM=;
        b=EetW5+h2WAFfLhHoLTCZ9y+9G7Ei5unrNieHG1oDovYqkcijqZVi/zV19BnVNHeDAYAq1y
        5BPQvOBeenBqLGZsMVj0lxrhTePplE91mlRbpz6CwZlY5ngqViOYE+dIpuSbgEqXN/hk+p
        jZgnfrBD4hxFmjvZv0feO4rHUiJ10r7PGhwlaj55UBGIzybRn6FLG3VxHgQfGbyY8XfR5y
        ZWdJnyBKnvxoeq281PMRil6StYpFCqPQgpfBqwHXqkT9CU72euIqVkVtoVbuIqm2lzXkVL
        8SmRG2kKrV0hOeL1M2wDVZUriXPi0GcVcw6UJ+cQfZoek59YI4kGMXrtfSvuHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603490194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79rTg2SKZLoa/evVojUPAbe7jLqXBquN2CeaB2ok8dM=;
        b=+wyfQHnakkKyqSE/2uGjxNcZTwxnMUoslSbSCXRrWkS+13bWcBa+tI0OQQwYJbaGoQJY9w
        kc67vWEIFcKYyjAw==
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
Subject: Re: [PATCH 07/10] x86/entry: Pass irqentry_state_t by reference
In-Reply-To: <20201022222701.887660-8-ira.weiny@intel.com>
References: <20201022222701.887660-1-ira.weiny@intel.com> <20201022222701.887660-8-ira.weiny@intel.com>
Date:   Fri, 23 Oct 2020 23:56:33 +0200
Message-ID: <87y2jw4ne6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22 2020 at 15:26, ira weiny wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>
> In preparation for adding PKS information to struct irqentry_state_t
> change all call sites and usages to pass the struct by reference
> instead of by value.

This still does not explain WHY you need to do that. 'Preparation' is a
pretty useless information.

What is the actual reason for this? Just because PKS information feels
better that way?

Also what is PKS information? Changelogs have to make sense on their own
and not only in the context of a larger series of changes.

> While we are editing the call sites it is a good time to standardize on
> the name 'irq_state'.

  While at it change all usage sites to consistently use the variable
  name 'irq_state'.

Or something like that. See Documentation/process/...

Thanks,

        tglx

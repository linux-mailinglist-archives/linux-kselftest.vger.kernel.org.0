Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82D324127B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Aug 2020 23:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgHJVng (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Aug 2020 17:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHJVnf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Aug 2020 17:43:35 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8836AC061756;
        Mon, 10 Aug 2020 14:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Um2mbTJkOP7E05aK2yhTGhYOff0GjDmdPCzEZmCgqzA=; b=LgikI4XbVHXzh4wcucYo1XEN2E
        gPqRUkW2nD4C8HHKTblbh8xzvX2RCodtwBT2Po4MkHikq+DDhLykrRQmlnjbFdxhaDNSh8ud76qeU
        L53/0NpUj0cGjNAGEsu2Tc6AmrTfWXsltgQH2FcRK5Fo1Ln3L4f2Te5Z9yI5ZqR6r+apHWP0xNcR5
        wDGZILCFMrLUZNTFd56P4n3GJmVLtDkMXIN8PEUbnVsvOz7H1l6G5py2HAjqhXLRHsVooEJcICzqW
        xKbj59UdAD53z3S49Z41vm6JNrWrhx0vIyODvR+5W0sPXF0tpomqZdlKEpXWOphAgWw0K3b8li+WH
        DlSDbWsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5FZp-0005Hw-Uq; Mon, 10 Aug 2020 21:43:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B5A6980D39; Mon, 10 Aug 2020 23:43:28 +0200 (CEST)
Date:   Mon, 10 Aug 2020 23:43:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uriel Guajardo <urielguajardojr@gmail.com>
Cc:     brendanhiggins@google.com, mingo@redhat.com, will@kernel.org,
        urielguajardo@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: added lockdep support
Message-ID: <20200810214328.GM3982@worktop.programming.kicks-ass.net>
References: <20200810213257.438861-1-urielguajardojr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810213257.438861-1-urielguajardojr@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 10, 2020 at 09:32:57PM +0000, Uriel Guajardo wrote:
> +static inline void kunit_check_locking_bugs(struct kunit *test,
> +					    unsigned long saved_preempt_count)
> +{
> +	preempt_count_set(saved_preempt_count);
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	if (softirq_count())
> +		current->softirqs_enabled = 0;
> +	else
> +		current->softirqs_enabled = 1;
> +#endif
> +#if IS_ENABLED(CONFIG_LOCKDEP)
> +	local_irq_disable();
> +	if (!debug_locks) {
> +		kunit_set_failure(test);
> +		lockdep_reset();
> +	}
> +	local_irq_enable();
> +#endif
> +}

Unless you can guarantee this runs before SMP brinup, that
lockdep_reset() is terminally broken.

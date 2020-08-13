Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D8E2438A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Aug 2020 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMKgY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Aug 2020 06:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMKgY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Aug 2020 06:36:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C670C061757;
        Thu, 13 Aug 2020 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9hnbVDwhrL8TE76gwR/KK7IaS55JjZNnoo+tIvGIEU0=; b=iVUntBDcQRBcXmCxiAuZxmiaCO
        fMcOPwDOVL2SBc93pNJSxLMHLWma1GFmTjcW2w4c0jezZrp57rlDytNxiQ6cIc8zzH77hvI0zSj7T
        4wU24ELLmQ7/gXUm6C0FwP08SvK0qlPgwetTYFomhwYv0KvgT0eqaH5J+T8lE7ZbT185Rq3dAm2Qa
        z2Zs++d0zdYjPJ+ZdVrN2Dlo1l8nOjHHi8cC6hncvLTSnrn1xKHLsyuTaR964sgSIbF5T2TJjxFkK
        6A+gITKwEoH4VbOR3QsDSUFze9MVTbAFzyHX67d2Cdf6mDiJ2A0/4NBP/DpeYkOGDN49wxEkn+kRJ
        OxFXHUNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6Aan-00078D-57; Thu, 13 Aug 2020 10:36:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D9F6300238;
        Thu, 13 Aug 2020 12:36:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05CC62C217FD8; Thu, 13 Aug 2020 12:36:16 +0200 (CEST)
Date:   Thu, 13 Aug 2020 12:36:15 +0200
From:   peterz@infradead.org
To:     Uriel Guajardo <urielguajardojr@gmail.com>
Cc:     brendanhiggins@google.com, mingo@redhat.com, will@kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, urielguajardo@google.com
Subject: Re: [PATCH v2] kunit: added lockdep support
Message-ID: <20200813103615.GT2674@hirez.programming.kicks-ass.net>
References: <20200812193332.954395-1-urielguajardojr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812193332.954395-1-urielguajardojr@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 12, 2020 at 07:33:32PM +0000, Uriel Guajardo wrote:
> KUnit will fail tests upon observing a lockdep failure. Because lockdep
> turns itself off after its first failure, only fail the first test and
> warn users to not expect any future failures from lockdep.
> 
> Similar to lib/locking-selftest [1], we check if the status of
> debug_locks has changed after the execution of a test case. However, we
> do not reset lockdep afterwards.
> 
> Like the locking selftests, we also fix possible preemption count
> corruption from lock bugs.

> +static void kunit_check_locking_bugs(struct kunit *test,
> +				     unsigned long saved_preempt_count,
> +				     bool saved_debug_locks)
> +{
> +	preempt_count_set(saved_preempt_count);
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	if (softirq_count())
> +		current->softirqs_enabled = 0;
> +	else
> +		current->softirqs_enabled = 1;
> +#endif

Urgh, don't silently change these... if they're off that's a hard fail.

	if (DEBUG_LOCKS_WARN_ON(preempt_count() != saved_preempt_count))
		preempt_count_set(saved_preempt_count);

And by using DEBUG_LOCKS_WARN_ON() it will kill IRQ tracing and trigger
the below fail.

> +	if (saved_debug_locks && !debug_locks) {
> +		kunit_set_failure(test);
> +		kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
> +		kunit_warn(test, "Further tests will have LOCKDEP disabled.");
> +	}
> +}

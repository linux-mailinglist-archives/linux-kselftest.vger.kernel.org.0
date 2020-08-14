Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB9C244F66
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Aug 2020 22:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgHNU7A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Aug 2020 16:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHNU7A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Aug 2020 16:59:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EFBC061385;
        Fri, 14 Aug 2020 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fbz+m9xKHOKc3fwcp3lvgrdbJUFIPiDRisxtqYQa5Oc=; b=kYSwhMisvhbmvBFiZOHvLwYzON
        Zat6DkNkraQ2c9liFtfN9c9iKokEyVTYwJzTp574mderI+H/DL8PEmW8uuKGUEcfk6KZeycmO1geK
        Doam9VN5EVG9wgBWXWk/wtSwAzf+hiR8SYqJ9K5ap1emV+RG92+AkwLORI/ofXMs9/Bf0UtROZ8SX
        dcVDdF88xZ/vZA5CcoHt7nYTF7KJVjIoz4ZGo191vV5RHumg9qk3UUJnw4iKSe9jmRbmFzfQ2bbNw
        ESAZJ7FTwU+IZULrs6snvdyEfkx1T3YGcvKRT6BQirJYJqQmn45/g34vKJ1A2has/Z2sOLu15AWlp
        nCbWQafw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6gmm-0004yK-2q; Fri, 14 Aug 2020 20:58:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 308A0980C9E; Fri, 14 Aug 2020 22:58:47 +0200 (CEST)
Date:   Fri, 14 Aug 2020 22:58:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uriel Guajardo <urielguajardojr@gmail.com>
Cc:     brendanhiggins@google.com, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, urielguajardo@google.com,
        alan.maguire@oracle.com
Subject: Re: [PATCH v3] kunit: added lockdep support
Message-ID: <20200814205847.GK3982@worktop.programming.kicks-ass.net>
References: <20200814205527.1833459-1-urielguajardojr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814205527.1833459-1-urielguajardojr@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 14, 2020 at 08:55:27PM +0000, Uriel Guajardo wrote:
> +
> +void kunit_check_lockdep(struct kunit *test, struct kunit_lockdep *lockdep) {
> +	int saved_preempt_count = lockdep->preempt_count;
> +	bool saved_debug_locks = lockdep->debug_locks;
> +
> +	if (DEBUG_LOCKS_WARN_ON(preempt_count() != saved_preempt_count))
> +		preempt_count_set(saved_preempt_count);
> +
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	if (softirq_count())
> +		current->softirqs_enabled = 0;
> +	else
> +		current->softirqs_enabled = 1;
> +#endif

This block is pointless. The only way to get softirq tracing out of sync
is an unbalanced local_bh_disable(), but then the above preempt_count()
test will trigger and kill IRQ tracing.

> +
> +	if (saved_debug_locks && !debug_locks) {
> +		kunit_set_failure(test);
> +		kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
> +		kunit_warn(test, "Further tests will have LOCKDEP disabled.");
> +	}
> +}

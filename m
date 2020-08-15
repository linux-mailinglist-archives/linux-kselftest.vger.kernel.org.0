Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E9B2453B0
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Aug 2020 00:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgHOWEJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Aug 2020 18:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgHOVvD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEF5C03B3CD;
        Sat, 15 Aug 2020 01:30:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a26so12338917ejc.2;
        Sat, 15 Aug 2020 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OTJ5ZzXkVNOqKUVJCNQ7kjB6RDngCntbQUzOLmWGTN0=;
        b=caMuw41FA6/kb84Gk3fDwKcDsuD8nmGCfxFXlNaV9UWoEZNpH/wB1O7lqx8Kxg6sI7
         ZdRTp98AlcQQkG7HcxBUkVzit4fqGpViPmILFpBRCVI+Ga5JNiV+Sj0uLH4PUeX+exR4
         QfMUOFauDXZrERTOJVfWIyipGz96BCP55mjuNLV52VTh/lha1AdXJjeqWHOBUix4sqpx
         k/614CCAm7UTexgXk+LkejK9IHrAPq85PrLnFoMXiSvAlS9lsAIZOZ9HMpvU/bSm4H4j
         KhEEGSW454zYWJnvTfpMV8U5qHY5TR4GM0W2YjyEfWxlgGaUTYU+bInDnBrW0SzRVq9i
         11wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OTJ5ZzXkVNOqKUVJCNQ7kjB6RDngCntbQUzOLmWGTN0=;
        b=pNUY2aw65/bnbLV9UQ0StlR6nH9hMWVfwWioltw+oITnN+vhFbxVBd0MrLXjoCXhpO
         ojihCUlxBp9Uix7j5stqpaFFwlfsifvZm8bxXvrFsykfgG0CMgFbgCMcqQ8axPunpLLs
         Ra/PFIm9PQ/Rp4pYOKhYajgvdJbYRTxVM8wR3DVEh5O2TAmVHtN13z7aA+18198RuIXm
         TTsfKeytkspv0ouxl7fSt4DraGRf6PQPdvQesvkDREXpKqG6gNmIjVSvpNQaTJm6WYxp
         mP+idM/rHB76E7J5vaVXfOIUcrGUEVDG/xAScLCQlTg72uRpXfxfPeNgGORXhqkO8Aaf
         RHIw==
X-Gm-Message-State: AOAM533fWWkTAj7R3yEViLOPlN42XLKWP5Lh218RtjkR0eG0+XGEqWKF
        4yZSGhDqnD24/Wvc79kr3sg=
X-Google-Smtp-Source: ABdhPJwiTPKiEV581q5AeJRHWKu0zF6t2Tdvh2SgsUODiijumjqWusU4DfnPtOT8BJbsAs9we+ODig==
X-Received: by 2002:a17:906:eb90:: with SMTP id mh16mr5911532ejb.10.1597480232160;
        Sat, 15 Aug 2020 01:30:32 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e6sm8546653ejd.14.2020.08.15.01.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 01:30:30 -0700 (PDT)
Date:   Sat, 15 Aug 2020 10:30:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uriel Guajardo <urielguajardojr@gmail.com>
Cc:     brendanhiggins@google.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        urielguajardo@google.com, alan.maguire@oracle.com
Subject: Re: [PATCH v3] kunit: added lockdep support
Message-ID: <20200815083029.GA2430016@gmail.com>
References: <20200814205527.1833459-1-urielguajardojr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814205527.1833459-1-urielguajardojr@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Uriel Guajardo <urielguajardojr@gmail.com> wrote:

> From: Uriel Guajardo <urielguajardo@google.com>
> 
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

> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile

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
> +
> +	if (saved_debug_locks && !debug_locks) {
> +		kunit_set_failure(test);
> +		kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
> +		kunit_warn(test, "Further tests will have LOCKDEP disabled.");
> +	}


So this basically duplicates what the boot-time locking self-tests do, 
in a poor fashion?

Instead of duplicating unit tests, the right solution would be to 
generalize the locking self-tests and use them both during bootup and 
in kunit.

Thanks,

	Ingo

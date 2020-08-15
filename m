Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CAA2453E4
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Aug 2020 00:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgHOWHD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Aug 2020 18:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgHOVus (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:48 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE3C03B3D9;
        Sat, 15 Aug 2020 02:17:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id kq25so12383117ejb.3;
        Sat, 15 Aug 2020 02:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LdgMvtZiYzsixZdlySxjdld4bTg4i4MMF4SV+Xh6PgQ=;
        b=Wa6vez79ybTUCXkANCj9WMY4gAdB0SzIgrz7k+4RufTMJ0/GZF++5zIruqwEV6kj24
         EpvZA+nUk6RnUjxFFFWvqusUsxW9fBSPVHMOiWMQVotEfinwIwEWuNCTksYKUNSAMK/x
         dMh5EEpy4hILcQDjKKcPYbsyny6XPdpyBfYeZVsjelWD2IEkMbh0LMO2uzfPe5ijpQ0u
         +AZxUqA17Ge8B1ZIAvsDMXWd9DdyM+WS9owjALqdgRIUK6fpCB4jfIxWQJ8IYxSpcwI5
         m6BrNpVvgiUY1MwMeSHLES5zuxp7Zg+8HVxzVaXQ7fEYlJQwAp1SbVBBa2uqX2Aexx7G
         vHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LdgMvtZiYzsixZdlySxjdld4bTg4i4MMF4SV+Xh6PgQ=;
        b=spuL5LL95awBqyP+oVszAP8/wMUfWjstMMNb0KhasQGiqc6E81m4ljpxs5rDknih1f
         yWqgrTArxXQJ00QawVxul5VZYPq54gfUnKrsAkx4v0nTHpsZjw2t6eiAij8jBMEtTFNO
         Dd7JUa2V+R13pIF0DIL3G4djAxj6WX5TWPJIRLhECJHgDFFWvrJhu+hf0DRrI8pATUcJ
         +YhAecPtDlDVxeVebHk7m3D6CUUgrYlIn/KM3JIe3Et8ANyOKtOR8Wesp8YSSATbUeeG
         peUMJJNplY31BdbI33oXsnUgp3JYWClCgJOY7nzxZ696KUrSmoS7uI9V73DgWBj8t6v4
         R2Og==
X-Gm-Message-State: AOAM533ENqJ0FSt7SiuEuJzPsRxe8AYAIa7kBEs7X7EkjJS3lltV/4Uo
        wEHVjZqRnWF3IrvQtXfFADc=
X-Google-Smtp-Source: ABdhPJxhJXsV123JZEM9qyyqxiKuZRj7XrS5k/o0gCCuzsGf/ulN0GcX1QsYsRREbz043y1E8pU5LQ==
X-Received: by 2002:a17:906:3756:: with SMTP id e22mr6461945ejc.487.1597483043662;
        Sat, 15 Aug 2020 02:17:23 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id qc23sm8633373ejb.97.2020.08.15.02.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 02:17:23 -0700 (PDT)
Date:   Sat, 15 Aug 2020 11:17:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        brendanhiggins@google.com, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, urielguajardo@google.com,
        alan.maguire@oracle.com
Subject: Re: [PATCH v3] kunit: added lockdep support
Message-ID: <20200815091721.GC2444151@gmail.com>
References: <20200814205527.1833459-1-urielguajardojr@gmail.com>
 <20200815083029.GA2430016@gmail.com>
 <20200815084443.GO3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815084443.GO3982@worktop.programming.kicks-ass.net>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Aug 15, 2020 at 10:30:29AM +0200, Ingo Molnar wrote:
> > 
> > * Uriel Guajardo <urielguajardojr@gmail.com> wrote:
> > 
> > > From: Uriel Guajardo <urielguajardo@google.com>
> > > 
> > > KUnit will fail tests upon observing a lockdep failure. Because lockdep
> > > turns itself off after its first failure, only fail the first test and
> > > warn users to not expect any future failures from lockdep.
> > > 
> > > Similar to lib/locking-selftest [1], we check if the status of
> > > debug_locks has changed after the execution of a test case. However, we
> > > do not reset lockdep afterwards.
> > > 
> > > Like the locking selftests, we also fix possible preemption count
> > > corruption from lock bugs.
> > 
> > > --- a/lib/kunit/Makefile
> > > +++ b/lib/kunit/Makefile
> > 
> > > +void kunit_check_lockdep(struct kunit *test, struct kunit_lockdep *lockdep) {
> > > +	int saved_preempt_count = lockdep->preempt_count;
> > > +	bool saved_debug_locks = lockdep->debug_locks;
> > > +
> > > +	if (DEBUG_LOCKS_WARN_ON(preempt_count() != saved_preempt_count))
> > > +		preempt_count_set(saved_preempt_count);
> > > +
> > > +#ifdef CONFIG_TRACE_IRQFLAGS
> > > +	if (softirq_count())
> > > +		current->softirqs_enabled = 0;
> > > +	else
> > > +		current->softirqs_enabled = 1;
> > > +#endif
> > > +
> > > +	if (saved_debug_locks && !debug_locks) {
> > > +		kunit_set_failure(test);
> > > +		kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
> > > +		kunit_warn(test, "Further tests will have LOCKDEP disabled.");
> > > +	}
> > 
> > 
> > So this basically duplicates what the boot-time locking self-tests do, 
> > in a poor fashion?
> 
> No, it makes sure that any kunit based self-test fails when it messes up
> it's locking.

We have a flag for whether lockdep is running though, so is this 
basically a very complicated way to parse /proc/lockdep_debug? :-)

Thanks,

	Ingo

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D6B3F1F10
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhHSR1A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 13:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233320AbhHSR1A (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 13:27:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56BC46023D;
        Thu, 19 Aug 2021 17:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629393984;
        bh=8bMRr+3lfqS+WTA5uS17IcE0HsMA5fSxcfqzv64+Qb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=japYTi3pXOAm+MYDjP5qNag4LYEX/axH5/9smIvPYi/7E+EzQcScMaEvCb3lU3U3Z
         DU+ow6LmGZUkbxUqkCP7oUnU8CD4mvyTQ0bmcaYw8BT+bp5iPx+UWFOdOSRTQYr9JC
         Qo0keJI3rjxyS1AMhTATZySI9J67wgScP5TsrIPS9QmawEYmO4RkIW0BME0Z9naapS
         MjACPVxws/0BnKn2OQu8dksmwpLa2MxiCkaX8SxxdFSUFWk2pJSpyAUK/oK26L1rX2
         cg+Ry7A76PhyuyBpV9/z0o9m/imLG23PocyH7FHPJ6k4fRYoN++eFTZjCIwySpvTZk
         LtiptUaxG7pzA==
Date:   Thu, 19 Aug 2021 19:26:18 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Ma, XinjianX" <xinjianx.ma@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: [PATCH v11 5/9] Reimplement RLIMIT_MSGQUEUE on top of ucounts
Message-ID: <20210819172618.qwrrw4m7wt33wfmz@example.org>
References: <d650b7794e264d5f8aa107644cc9784f@intel.com>
 <87a6lgysxp.fsf@disp2133>
 <20210818131117.x7omzb2wkjq7le3s@example.org>
 <87o89ttqql.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o89ttqql.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 19, 2021 at 10:10:26AM -0500, Eric W. Biederman wrote:
> Alexey Gladkov <legion@kernel.org> writes:
> 
> > On Tue, Aug 17, 2021 at 10:47:14AM -0500, Eric W. Biederman wrote:
> >> "Ma, XinjianX" <xinjianx.ma@intel.com> writes:
> >> 
> >> > Hi Alexey,
> >> >
> >> > When lkp team run kernel selftests, we found after these series of patches, testcase mqueue: mq_perf_tests
> >> > in kselftest failed with following message.
> >> 
> >> Which kernel was this run against?
> >> 
> >> Where can the mq_perf_tests that you ran and had problems with be found?
> >> 
> >> During your run were you using user namespaces as part of your test
> >> environment?
> >> 
> >> The error message too many files corresponds to the error code EMFILES
> >> which is the error code that is returned when the rlimit is reached.
> >> 
> >> One possibility is that your test environment was run in a user
> >> namespace and so you wound up limited by rlimit of the user who created
> >> the user namespace at the point of user namespace creation. 
> >> 
> >> At this point if you can give us enough information to look into this
> >> and attempt to reproduce it that would be appreciated.
> >
> > I was able to reproduce it on master without using user namespace.
> > I suspect that the maximum value is not assigned here [1]:
> >
> > set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE, task_rlimit(&init_task, RLIMIT_MSGQUEUE));
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/fork.c#n832
> 
> The rlimits for init_task are set to INIT_RLIMITS.
> In INIT_RLIMITS RLIMIT_MSGQUEUE is set to MQ_MAX_BYTES
> 
> So that definitely means that as the code is current constructed the
> rlimit can not be effectively raised.
> 
> So it looks like we are just silly and preventing the initial rlimits
> from being raised.
> 
> So we probably want to do something like:

Damn, you are faster than me! :)

> diff --git a/kernel/fork.c b/kernel/fork.c
> index bc94b2cc5995..557ce0083ba3 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -825,13 +825,13 @@ void __init fork_init(void)
>  	init_task.signal->rlim[RLIMIT_SIGPENDING] =
>  		init_task.signal->rlim[RLIMIT_NPROC];
>  
> +	/* For non-rlimit ucounts make their default limit max_threads/2 */
>  	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++)
>  		init_user_ns.ucount_max[i] = max_threads/2;
>  
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_NPROC, task_rlimit(&init_task, RLIMIT_NPROC));
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE, task_rlimit(&init_task, RLIMIT_MSGQUEUE));
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, task_rlimit(&init_task, RLIMIT_SIGPENDING));
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK, task_rlimit(&init_task, RLIMIT_MEMLOCK));
> +	/* In init_user_ns default rlimit to be the only limit */
> +	for (; i < UCOUNT_COUNTS; i++)
> +		set_rlimit_ucount_max(&init_user_ns, i, RLIMIT_INFINITY);

s/RLIMIT_INFINITY/RLIM_INFINITY/

>  
>  #ifdef CONFIG_VMAP_STACK
>  	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
> 

Acked-by: Alexey Gladkov <legion@kernel.org>

I cannot complete this test on my laptop. On 4Gb, the test ends with
oom-killer. But with this patch, the test definitely passes the moment of
the previous fall.

-- 
Rgrds, legion


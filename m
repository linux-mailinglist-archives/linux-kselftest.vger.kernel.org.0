Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF58364F02F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 18:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiLPRQU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 12:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiLPRQU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 12:16:20 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EF329CAE
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 09:16:18 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n4so2973625plp.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 09:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1vFt+PxUURFiZfVHrvBsmq3MYjQQnliB4U9G0LtHwvo=;
        b=NzIXW8IPm6aqdfZVn8wF9pvH9EX2CYlT+NecBtjOLfEuyXc+cx2NKGt5J+FnKO1bjJ
         TrF0y0yo6mVxhuVq30y+t91fPsGX6xGd9sb28pCmi+59SPnJev9IpMY/dcGPJmgXxLzp
         uYMcp6cAQtYqy4jgdLA97Jt9m1/T5UmPMFJisqTII7KPitmCMZEDdbkzlV2rVl6bYHA4
         cHbNfGO25NidGQjLdH+U6LTY95WHrEs/cMS3wJB4NiEqJbZc8YCuwLiuoX1snZ9fquUB
         6TFyUQQ35fJyhZeTgW8uzcMzgbwY2W4AZcTPgGrzdmrUN5UHDplf+8ch5izUjtf2VG6v
         UsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vFt+PxUURFiZfVHrvBsmq3MYjQQnliB4U9G0LtHwvo=;
        b=O84zxDX4xOMGNHjluf/4xw+GcyPJefeBtRv9BcivCUOlh/34LODr7s9EDsKsq9ic2B
         1clLGvwT7nR2sYCryVe0gCeLRLHYA9so1BQIxwkTQQSPmzFmp8QIlBvjiq8vkT1WNxkk
         EKdiA3U23TwP0J9clpfB3VHBw30zTTtqIgv1mGKil/9EcCpoqJy5jOwL4+3SC6y216/k
         KqmiNQul+3GttF5sjwCvxElZGYNYPwRmQ/T4ZHb8vLLpGiQOXaUYSKYO1VZdS1vG265h
         0IWRAq2R/1Gu/ApSHUuieEkIPNdOux3ynwtAoioTIJxVZSlwA04QPzlM0N/GBzpjpt2m
         61Og==
X-Gm-Message-State: AFqh2krebKNSB0EDUa4HyzxNeZSApApriEKAPR80CCEcDL2vWIsWSgmb
        WXRITHKA9tAJ6oXOPByhsMVj8OfFd5WuEywtj22/iw==
X-Google-Smtp-Source: AMrXdXvvu/Vp44NQhthEXWvCfyRa+UVxHXgPTglhTuliY9e8JxjquA4ilh9D3roeSj0Fhi+0+KgwBHTBi2wbT081p2k=
X-Received: by 2002:a17:90a:69c7:b0:21a:8dc:1b5e with SMTP id
 s65-20020a17090a69c700b0021a08dc1b5emr653725pjj.26.1671210977931; Fri, 16 Dec
 2022 09:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20221207154939.2532830-1-jeffxu@google.com> <20221207154939.2532830-4-jeffxu@google.com>
 <202212080821.5AE7EE99@keescook> <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
 <Y5yS8wCnuYGLHMj4@x1n>
In-Reply-To: <Y5yS8wCnuYGLHMj4@x1n>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 16 Dec 2022 09:15:40 -0800
Message-ID: <CALmYWFsDhX76zbcyhYAW-u0BBwD+m+TKpt4_pZTMt+22zHhrGQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     Peter Xu <peterx@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, jeffxu@chromium.org,
        skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 16, 2022 at 7:47 AM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Jeff,
>
> On Thu, Dec 08, 2022 at 02:55:45PM -0800, Jeff Xu wrote:
> > > > +     if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
>
> [...]
>
> > > > +             pr_warn_ratelimited(
> > > > +                     "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
> > > > +                     task_pid_nr(current), get_task_comm(comm, current));
>
> This will be frequently dumped right now with mm-unstable.  Is that what it
> wanted to achieve?
>
> [   10.822575] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=491 'systemd'
> [   10.824743] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=495 '(sd-executor)'
> ...
>
> If there's already a sane default value (and also knobs for the user to
> change the default) not sure whether it's saner to just keep it silent as
> before?
>
Thanks for your comments.

The intention is it is a reminder to adjust API calls to explicitly
setting this bit.
The sysctl vm.memfd_noexec = 0 1 is for transaction to the final
state, and 2 depends on API call setting this bit.

The log is ratelimited, and there is a rate limit setting:
/proc/sys/kernel/printk_ratelimit
/proc/sys/kernel/printk_ratelimit_burst

Best regards,
Jeff

> --
> Peter Xu
>

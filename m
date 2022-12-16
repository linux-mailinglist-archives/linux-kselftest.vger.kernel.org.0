Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9432064F083
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 18:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiLPRnG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 12:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiLPRnF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 12:43:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E25C0CC;
        Fri, 16 Dec 2022 09:43:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 770CBB81DD8;
        Fri, 16 Dec 2022 17:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975E1C433D2;
        Fri, 16 Dec 2022 17:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671212581;
        bh=E+HX08I7hcmZbTcMtII8s3Be0mGGLDDFpjX+MYdbh3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bweBo8pjfSv8AYcDwRpn1DgozRF8dZfqj32ZRKwVbXH+Wh8BA/ib6tg9bnjMe2poT
         5AKG9lmosmdIXWrr3rehhq4C5T6WmV/iwXOw+GZCKHNHw5I4JYqWjmktIz/0Z/kYkl
         QNDn1BZgBoFt9/lLfnwjbLWcIoxhXvXder64zE8M=
Date:   Fri, 16 Dec 2022 09:42:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Kees Cook <keescook@chromium.org>,
        jeffxu@chromium.org, skhan@linuxfoundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-Id: <20221216094259.bec91e4abd6cf54a05ce2813@linux-foundation.org>
In-Reply-To: <CALmYWFsDhX76zbcyhYAW-u0BBwD+m+TKpt4_pZTMt+22zHhrGQ@mail.gmail.com>
References: <20221207154939.2532830-1-jeffxu@google.com>
        <20221207154939.2532830-4-jeffxu@google.com>
        <202212080821.5AE7EE99@keescook>
        <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
        <Y5yS8wCnuYGLHMj4@x1n>
        <CALmYWFsDhX76zbcyhYAW-u0BBwD+m+TKpt4_pZTMt+22zHhrGQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 16 Dec 2022 09:15:40 -0800 Jeff Xu <jeffxu@google.com> wrote:

> On Fri, Dec 16, 2022 at 7:47 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Jeff,
> >
> > On Thu, Dec 08, 2022 at 02:55:45PM -0800, Jeff Xu wrote:
> > > > > +     if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
> >
> > [...]
> >
> > > > > +             pr_warn_ratelimited(
> > > > > +                     "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
> > > > > +                     task_pid_nr(current), get_task_comm(comm, current));
> >
> > This will be frequently dumped right now with mm-unstable.  Is that what it
> > wanted to achieve?
> >
> > [   10.822575] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=491 'systemd'
> > [   10.824743] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=495 '(sd-executor)'
> > ...
> >
> > If there's already a sane default value (and also knobs for the user to
> > change the default) not sure whether it's saner to just keep it silent as
> > before?
> >
> Thanks for your comments.
> 
> The intention is it is a reminder to adjust API calls to explicitly
> setting this bit.

Do we need to warn more than once per boot?  If not, use pr_warn_once()?

> The sysctl vm.memfd_noexec = 0 1 is for transaction to the final
> state, and 2 depends on API call setting this bit.
> 
> The log is ratelimited, and there is a rate limit setting:
> /proc/sys/kernel/printk_ratelimit
> /proc/sys/kernel/printk_ratelimit_burst
> 


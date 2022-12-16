Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C8864F3B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 23:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiLPWGp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 17:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPWGo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 17:06:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB63111E;
        Fri, 16 Dec 2022 14:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47FC962253;
        Fri, 16 Dec 2022 22:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2891EC433D2;
        Fri, 16 Dec 2022 22:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671228402;
        bh=ztxC0tZ3LHE1E0QxQeFuDNowIFY2kavlk+wi+c1cZ9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gtx8hPdkfa55IusM8ya2E+vD6klwp3mnVQ6Wox4M/3rNmhsnH6CJE0Hm+IWC1a+mP
         Zwc9vZhKss135hy9KXIxO4ptZOrGtvAlrlaY5o9haT4x/eCRjgK7FY1HfZBf3av/OP
         0JsxdsaIHur80B5Y4+o6CvqIIl1ZDBOUaH5sR0lo=
Date:   Fri, 16 Dec 2022 14:06:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Peter Xu <peterx@redhat.com>,
        jeffxu@chromium.org, skhan@linuxfoundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-Id: <20221216140641.bf6e47b7c4f5a53f34c8cf9a@linux-foundation.org>
In-Reply-To: <CALmYWFuENPRvCAOF6of=Ufct5jjAbJ=iDyH7eODhdbm24uAK3Q@mail.gmail.com>
References: <20221207154939.2532830-1-jeffxu@google.com>
        <20221207154939.2532830-4-jeffxu@google.com>
        <202212080821.5AE7EE99@keescook>
        <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
        <Y5yS8wCnuYGLHMj4@x1n>
        <CALmYWFsDhX76zbcyhYAW-u0BBwD+m+TKpt4_pZTMt+22zHhrGQ@mail.gmail.com>
        <20221216094259.bec91e4abd6cf54a05ce2813@linux-foundation.org>
        <CALmYWFsNp87a5uVQUAb4PG0khFN8Xxd=ibh9Q7g-Y0XW1Mn-8Q@mail.gmail.com>
        <202212161233.85C9783FB@keescook>
        <CALmYWFuENPRvCAOF6of=Ufct5jjAbJ=iDyH7eODhdbm24uAK3Q@mail.gmail.com>
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

On Fri, 16 Dec 2022 13:46:58 -0800 Jeff Xu <jeffxu@google.com> wrote:

> On Fri, Dec 16, 2022 at 12:35 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Dec 16, 2022 at 10:11:44AM -0800, Jeff Xu wrote:
> > > Once per boot seems too little, it would be nice if we can list all processes.
> > > I agree ratelimited might be too much.
> > > There is a feature gap here for logging.
> > >
> > > Kees, what do you think ?
> >
> > I agree once per boot is kind of frustrating "I fixed the one warning,
> > oh, now it's coming from a different process". But ratelimit is, in
> > retrospect, still too often.
> >
> > Let's go with per boot -- this should be noisy "enough" to get the
> > changes in API into the callers without being too much of a hassle.
> >
> Agreed.  Let's go with per boot.
> 
> Hi Andrew, what is your preference ? I can send a patch  or you
> directly fix it in mm-unstable ?

Like this?

--- a/mm/memfd.c~mm-memfd-add-mfd_noexec_seal-and-mfd_exec-fix-3
+++ a/mm/memfd.c
@@ -308,7 +308,7 @@ SYSCALL_DEFINE2(memfd_create,
 			flags |= MFD_NOEXEC_SEAL;
 			break;
 		default:
-			pr_warn_ratelimited(
+			pr_warn_once(
 				"memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d '%s'\n",
 				task_pid_nr(current), get_task_comm(comm, current));
 			return -EINVAL;
@@ -316,7 +316,7 @@ SYSCALL_DEFINE2(memfd_create,
 #else
 		flags |= MFD_EXEC;
 #endif
-		pr_warn_ratelimited(
+		pr_warn_once(
 			"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
 			task_pid_nr(current), get_task_comm(comm, current));
 	}
_


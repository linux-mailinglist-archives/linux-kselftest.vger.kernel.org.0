Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F16FD05E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2019 22:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNVeK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Nov 2019 16:34:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44217 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNVeK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Nov 2019 16:34:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id f19so4594993pgk.11
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2019 13:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lz+H2e4nU3DSz+GBvFyXU0p4lpCX+jG3QqyBoFeFFPY=;
        b=jljzdW0V9SAQcSHNgJpgS6iE2qLtNO74+8EkQKoUT8UYh1OPxP4LvnCDuijszxNFYO
         OS4rl51ihcNDJA60ScBk2mhNiUUYZBqnOrTR+NtVN91xXnFDJv2eGE0PzGLL+P6cOmj1
         6vN2OCJP5DoaRV8hkBr8Zy09+FpnY89+KzDjbQNB7nImJM6+l5wRAHog6aRXw2usIPcZ
         jwg/bWUT4Eed4CW+YHFRXW1W+1wjt1eizYDF/CT5sj9nGxbT9vN38dx3FDZYzQoov3PY
         YmpL3gupF+8HYzbxyKlxELTRojf3lG7aW780sDFs3EkgTXRe+q2PYzweJiitnVkEjIul
         nfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lz+H2e4nU3DSz+GBvFyXU0p4lpCX+jG3QqyBoFeFFPY=;
        b=roaaUP6lgDzXFoVNP1Bml7CMOJZ7FRjMLptsZvddvaafqOX3zuFLHj/cokJWceyIZ3
         T3O0/haOds2iVHFL4EK4eJPbNY54tKnVZTOhf/5GUsxIu5fyzNB9s+1zvlQbl1D1NeDm
         jvyO4eP7XewpQ8GrLdlDbMPw6Q+PeZ93Mb47X+T1hGsrNTwP9psxBidIOOKwfb1ocPdg
         XLctYWRDeBfroc28RnlqQ1Sz3guv8cr1EaeLwapG4FDtAlcf2JFyQD3bMMB2V8FDpOXc
         a7qH1BJxRyy5zt6nBEAAsMPid1biCUoytiq5odd9QxI5rVE2qc6SdrawL873BmItcQFb
         TBtA==
X-Gm-Message-State: APjAAAV6VOgqNYrYNHddKfR6y14R4sbSOb/5RcID/8oh0wKLLYyq9QyC
        3kFGHpNeitYBVNfhme3n6FF5ynKy6/dhH8yhEzO6lZty6/s=
X-Google-Smtp-Source: APXvYqydVCNC48wS0hV/alNcKDjro8PRBVxUG7ZfEwB5jDC3stFf1Qe6lmbar2bZy9Vx0Lziu4VVN9dXRdUNRhgdWW0=
X-Received: by 2002:a63:5163:: with SMTP id r35mr644296pgl.201.1573767248637;
 Thu, 14 Nov 2019 13:34:08 -0800 (PST)
MIME-Version: 1.0
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
 <1571335639-21675-6-git-send-email-alan.maguire@oracle.com>
 <CAFd5g46s4eY4qEB5UZPeOKNdZXm4+sA9N=4g8gDYAhyhMahZKw@mail.gmail.com>
 <alpine.LRH.2.20.1911081520550.24027@dhcp-10-175-178-67.vpn.oracle.com>
 <CAFd5g44vYUkLQmJFq_vQ5ruvBC_1vrkSd9DeW3oQ_vLzrNcpgQ@mail.gmail.com>
 <20191114063815.9403820706@mail.kernel.org> <alpine.LRH.2.20.1911140750450.8907@dhcp-10-175-202-216.vpn.oracle.com>
 <CAFd5g46hMRR8L1Yd64ypWCqs5CpFpY_BCXfSCx0uc68ZzbiPzQ@mail.gmail.com>
In-Reply-To: <CAFd5g46hMRR8L1Yd64ypWCqs5CpFpY_BCXfSCx0uc68ZzbiPzQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Nov 2019 13:33:57 -0800
Message-ID: <CAFd5g44esDP6WFmkjOiH+my_4iBeqMpFoScMCm_hQ0aFwNS9qw@mail.gmail.com>
Subject: Re: [PATCH v3 linux-kselftest-test 5/6] kunit: allow kunit to be
 loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 14, 2019 at 1:31 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> +kselftest and kunit lists to document this decision.

Sorry for the spam. I accidentally CC'ed the doc list instead of the
kselftest list in my previous email.

> On Wed, Nov 13, 2019 at 11:54 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On Wed, 13 Nov 2019, Stephen Boyd wrote:
> >
> > > Quoting Brendan Higgins (2019-11-11 13:41:38)
> > > > +Stephen Boyd - since he is more of an expert on the hung task timer than I am.
> > > >
> > > > On Fri, Nov 8, 2019 at 7:30 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > > >
> > > > > On Thu, 7 Nov 2019, Brendan Higgins wrote:
> > > > >
> > > > > > On Thu, Oct 17, 2019 at 11:09 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > > > > > +MODULE_LICENSE("GPL");
> > > > > > > diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> > > > > > > index 1c1e9af..72fc8ed 100644
> > > > > > > --- a/lib/kunit/try-catch.c
> > > > > > > +++ b/lib/kunit/try-catch.c
> > > > > > > @@ -31,6 +31,8 @@ static int kunit_generic_run_threadfn_adapter(void *data)
> > > > > > >         complete_and_exit(try_catch->try_completion, 0);
> > > > > > >  }
> > > > > > >
> > > > > > > +KUNIT_VAR_SYMBOL(sysctl_hung_task_timeout_secs, unsigned long);
> > > > > >
> > > > > > Can you just export sysctl_hung_task_timeout_secs?
> > > > > >
> > > > > > I don't mean to make you redo all this work for one symbol twice, but
> > > > > > I thought we agreed on just exposing this symbol, but in a namespace.
> > > > > > It seemed like a good use case for that namespaced exporting thing
> > > > > > that Luis was talking about. As I understood it, you would have to
> > > > > > export it in the module that defines it, and then use the new
> > > > > > MODULE_IMPORT_NS() macro here.
> > > > > >
> > > > >
> > > > > Sure, I can certainly look into that, though I wonder if we should
> > > > > consider another possibility - should kunit have its own sysctl table for
> > > > > things like configuring timeouts? I can look at adding a patch for that
> > > >
> > > > So on the one hand, yes, I would like to have configurable test
> > > > timeouts for KUnit, but that is not what the parameter check is for
> > > > here. This is to make sure KUnit times a test case out before the hung
> > > > task timer does.
> > > >
> > > > > prior to the module patch so the issues with exporting the hung task
> > > > > timeout would go away. Now the reason I suggest this isn't as much a hack
> > > > > to solve this specific problem, rather it seems to fit better with the
> > > > > longer-term intent expressed by the comment around use of the field (at
> > > > > least as I read it, I may be wrong).
> > > >
> > > > Not really. Although I do agree that adding configurability here might
> > > > be a good idea, I believe we would need to clamp such a value by
> > > > sysctl_hung_task_timeout_secs regardless since we don't want to be
> > > > killed by the hung task timer; thus, we still need access to
> > > > sysctl_hung_task_timeout_secs either way, and so doing what you are
> > > > proposing would be off topic.
> > > >
> > > > > Exporting the symbol does allow us to piggy-back on an existing value, but
> > > > > maybe we should support out our own tunable "kunit_timeout_secs" here?
> > > > > Doing so would also lay the groundwork for supporting other kunit
> > > > > tunables in the future if needed. What do you think?
> > > >
> > > > The goal is not to piggy back on the value as I mentioned above.
> > > > Stephen, do you have any thoughts on this? Do you see any other
> > > > preferable solution to what Alan is trying to do?
> > >
> > > One idea would be to make some sort of process flag that says "this is a
> > > kunit task, ignore me with regards to the hung task timeout". Then we
> > > can hardcode the 5 minute kunit timeout. I'm not sure we have any more
> > > flags though.
> > >
> > > Or drop the whole timeout clamping logic, let the hung task timeout kick
> > > in and potentially oops the kernel, but then continue to let the test
> > > run and maybe sometimes get the kunit timeout here. This last option
> > > doesn't sound so bad to me given that this is all a corner case anyway
> > > where we don't expect to actually ever hit this problem so letting the
> > > hung task detector do its job is probably fine. This nicely avoids
> > > having to export this symbol to modules too.
> > >
> >
> > Thanks for suggestions! This latter approach seems fine to me; presumably
> > something has gone wrong if we are tripping the hung task timeout anyway,
> > so having an oops to document that seems fine. Brendan, what do you think?
>
> If Stephen thinks it is fine to drop the clamping logic, I think it is
> fine too. I think it would probably be good to replace it with a
> comment under the TODO that explains that a hung test *can* cause an
> oops if the hung task timeout is less than the kunit timeout value. It
> would probably be good to also select a timeout value that is less
> than the default hung task timeout. We might also want to link to this
> discussion. I fully expect that the timeout logic will get more
> attention at some point in the future.
>
> One more thing: Alan, can you submit the commit that drops the
> clamping logic in its own commit? I would prefer to make sure that it
> is easy to spot in the commit history.
>
> Cheers!

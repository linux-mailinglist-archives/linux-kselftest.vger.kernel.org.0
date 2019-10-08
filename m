Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94214CFB3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 15:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfJHNXN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 09:23:13 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:35413 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfJHNXN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 09:23:13 -0400
Received: by mail-qt1-f175.google.com with SMTP id m15so25281034qtq.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2019 06:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpaq6J8Q7pR+GF70lFDtN/pybeFRutczVu4rh088PwA=;
        b=Oi+4pJqoHHGuiMgaAJhKn7BnzPBOo5Mvju4Dm0pV0qDxSfqaKe0oI+RrIcN2wbTZ6S
         5SWywdcV8CG0W2llQzfWkSZqV5sLZiz6R0uGP7EdI5IzulUbtyzuCKse7iHwPfqaksz2
         UZi9xF7UMw0QsnDQ+7ZtCznOe/22aUj3grVyKJgCvzchvaRY6rC79LeBBZHNy5AwIIze
         Xuh2dC09Pj6iMVVn43F1GjtuaMFyg1D+1uukeK3ShshtOe7PZs0C+A+N2b1xsHVGzg2N
         +/wJo914Oi2JRKUDws4ha5pan3T6dkFLSxJjlild/5LWwTpRUYGWphIQs769hx3B/unt
         CuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpaq6J8Q7pR+GF70lFDtN/pybeFRutczVu4rh088PwA=;
        b=dGjXKzqDncOlxmHt6y9CFtTm8mrwfcOzddkkoP7qSXa1dnN8hYO5WO6pYBDOdjhsRL
         aCduaEEKuCSarVfyXRFKbCCNVfNEi16Fd+JskQGjkBInIXG3fF1W+qT8zy4SertPaYe5
         RxWwcMRb7WxxqoSPZyppjJnt+2SZuDNgW6SbBC1PmYXV/iPbl3mDTnqproN+gBGpmQSC
         4JPUUVKVXMssfwR2HKO10yvVVdiRYzF21DZjV8lpIcdTdyJ62VaAjIwrSyhsvjKNnK5N
         N27QoaSQEhRE9VIgpdpaYIOXMMyQC8Eipj3fnSaxlis6ggw40GVUc8xWImBZ4Nt1pyR5
         97zg==
X-Gm-Message-State: APjAAAXPfes1vKI/1/jVV80C9fb2NdVQBkyFmPy7qXgvdws4NSSK39GN
        KBO6OdsRNAKYEB0XJjm+CqSjuLcpWLzj1qkcGZcceg==
X-Google-Smtp-Source: APXvYqyWHP88Ue91/hV0U8TFT0jTxgp1Elao/keXPuZv7+DgIhOsHhpofJS/Ke2V7b6HK5QWj+bjvrFkKEy9LxBs+hI=
X-Received: by 2002:ac8:7646:: with SMTP id i6mr36355637qtr.50.1570540990726;
 Tue, 08 Oct 2019 06:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <87zhibwgzm.fsf@rpws.prws.suse.cz> <CACT4Y+akZ4h9kN1Gg329-fKq-G=QeDdoFxW_Bp_r7+0sDsE+mw@mail.gmail.com>
 <87y2xvwf9v.fsf@rpws.prws.suse.cz>
In-Reply-To: <87y2xvwf9v.fsf@rpws.prws.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 8 Oct 2019 15:22:58 +0200
Message-ID: <CACT4Y+a=WSm5Z4KzkPJaapvsfbnTx3Ghvy7Wq4j=QNZ3W-aAmA@mail.gmail.com>
Subject: Re: [Automated-testing] syzkaller reproducers
To:     rpalethorpe@suse.de
Cc:     automated-testing@yoctoproject.org, Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernelci@groups.io,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 8, 2019 at 3:14 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> Hello,
>
> Dmitry Vyukov <dvyukov@google.com> writes:
>
> > On Tue, Oct 8, 2019 at 2:37 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
> >>
> >> Hello,
> >>
> >> Dmitry Vyukov <dvyukov@google.com> writes:
> >>
> >> > Hi Shuah,
> >> >
> >> > We discussed collecting and uploading all syzkaller reproducers
> >> > somewhere. You wanted to see how they look. I've uploaded all current
> >> > reproducers here:
> >> > https://github.com/dvyukov/syzkaller-repros
> >> > Minimalistic build/run scripts are included.
> >> > +some testing mailing lists too as this can be used as a test suite
> >> > If you have any potential uses for this, you are welcome to use it.
> >> > But then we probably need to find some more official and shared place
> >> > for them than my private github.
> >> > The test programs can also be bulk updated if necessary, because all
> >> > of this is auto-generated.
> >> >
> >> > Thanks
> >>
> >> I discussed this a bit with Metan. We think it would be fairly trivial
> >> to create an LTP wrapper for these.
> >>
> >> So we just create an LTP test which forks and execs one of these
> >> reproducers then checks for kernel taints after the child completes or
> >> is killed. It can take the reproducer path as an argument and we can
> >> generate a runtest file with all the reproducers in that we are able to
> >> compile.
> >>
> >> I imagine a lot of these reproducers will not work on older kernels, so
> >> this would just be a best efforts basis. We would ignore any problems
> >> during execution unless there is a kernel error.
> >>
> >> This should work with existing LTP runners with maybe a minor change or
> >> two to building and configuration.
> >>
> >> I will start experimenting with this and post the results to the LTP
> >> mailing list.
> >
> >
> > Hi Richard,
> >
> > Sounds great!
> >
> > Yes, these are totally best effort. May also require some configs, etc.
> > Also note that each should be run in a clean temp dir and with a
> > timeout b/c some have an infinite loop.
>
> Thanks, fortunately the LTP lib can do that automatically.
>
> However the default timeout is 5 minutes, but I guess this should be
> more like ~3 seconds as in the run script?

This really depends on the bug type and specific bug.
syzkaller runs reproducers for up to 7 minutes. Sometimes even that is
not enough to reproduce some bugs. We also detect hung tasks only
after 3-4 minutes (may produce flakes with smaller timeout).
Most reproducers can also run in parallel, that may help to partially
neutralize large timeouts.
But also if these run repeatedly/continuously, we can use smaller
timeout on each run (don't need to catch crash on every run).
Let's start with somewhere, we can tune later as we gather experience.

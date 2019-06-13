Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E4E43848
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbfFMPEv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:04:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45101 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732691AbfFMPEu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 11:04:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so15336620lfm.12
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2019 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lM5eV6H9krpQM793Z93walf0ECkvm+NtnWXHC21XgcY=;
        b=FB0GEVRIf3TSf13XTG8UuZfrxNyqcUkwuwzACXx5vXWJLzQbbRZJRSraOaawV6hWAk
         PrvPCzQwD69fuYgREIvWfwD5blUYsv33M/gcO15LkJ/lqFcHw9moqgdowV+jqotXnEfn
         /tT4evYxWgTEJAwmah3jHTv7lSPseKFUhVVwLTzvq2JG6m5luv20zZruhEGljSE9IllH
         MZeshq7wJyDxiNLSBc4OPA+Slgz8wHTZZwlcvqEQAs6f1F0Vm06Dmt0gah0KeX9kt975
         adqmm20Zh7jCKKx6KONjW8MYNyiIsUmRzSMuvIqWblkLUB2pc22NRdJHTivh+WGEIePo
         eE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lM5eV6H9krpQM793Z93walf0ECkvm+NtnWXHC21XgcY=;
        b=AYHJswhdIj9svc1jxZ+Qf442pf0ori7rHMFXDIL4hGLZu+5xudDa2sURLejDkebSjp
         CHcDaII7QvpkLi6cyqIJoJM4HHBQ00rxUIn0UrmBW17tQ4ywhwl44X0aRgYCuqGgYlVm
         IoZrCQ/8sxMwLqQM0SmvzmpuA2OBj2erFgjVTck2n6W78iaQ3w3G9bjUylu/GKHSmulF
         vuNTbKC5ghYjKA+tktyEBjesU1Y9YyiRLFKtV5KE+0xK0bCxEA+U+5trbPIa9Zk8lPYM
         nk23PLai57SOeOm430B6z48kHplrRv2etb5W+raPepd0e75IV0A/fw05yhXEkJO5Bdwa
         3aPQ==
X-Gm-Message-State: APjAAAUyvWhza7AQBYoBSlL3oOU/l0RMlyO+4C1+sdw6PQITllYtdi2o
        sUiZ+GwO3X19741XfdDEK5GDiji8VmIBPuQwFvMzMA==
X-Google-Smtp-Source: APXvYqybQbDcn72zwd1ASfQqXYh2p+e3c167nAPxg3H8OBumH6+DA/96vYJpatM4+a6rhY0KvvTM0B1yUq8B9CSFZNs=
X-Received: by 2002:a19:750b:: with SMTP id y11mr7601809lfe.16.1560437894098;
 Thu, 13 Jun 2019 07:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
 <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org> <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
 <6d5e0484-4dbc-d122-1ae4-9cce44c2d668@kernel.org> <CACT4Y+aE841JzvEVFmAevgmBO0eOssz0MFydWiuoAp18nr=_DA@mail.gmail.com>
 <CACT4Y+abfa9xVg+3S_tgpOA3cZ2bexe51d0FEZyBCGn0M-6DiA@mail.gmail.com>
 <CACT4Y+aiDUV4_JrvKct98mKvPwEQXSZFXae3qweSmotpzCAGTw@mail.gmail.com>
 <CACT4Y+a8zK7st7LUTkD=AaUBZGsn5hqLt5NXHHvJ0dg1Jds6Nw@mail.gmail.com>
 <CACT4Y+YKf3BFi-9J7Ag0yPtEWYrsPZXY1qUw21yRkNYu51wBWg@mail.gmail.com>
 <CACT4Y+bfz2F-p4xODb_=rU0+F-FJCC66MJW7q9DXd0UHoUfgwg@mail.gmail.com>
 <1e2cc74d-a6c2-0a73-ede5-c72df28e96b2@kernel.org> <CACT4Y+a203xykAHckhtMQ7ov-wNJ-YeuMg=o7qk=H9TQ756jcg@mail.gmail.com>
 <37e5e069-076d-9833-9eab-51c507fbbe2f@kernel.org> <CAEUSe791S6ODPZq4gcfbY=5kZ98ss2qNm0ks-oo0XLwFjsO=ag@mail.gmail.com>
 <CACT4Y+Z9073CozbR800E7p9EdVsfGJ471i0_pF4GftQkY7S90Q@mail.gmail.com>
In-Reply-To: <CACT4Y+Z9073CozbR800E7p9EdVsfGJ471i0_pF4GftQkY7S90Q@mail.gmail.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 13 Jun 2019 09:58:02 -0500
Message-ID: <CAEUSe7_VSPceBnaK39Mc0jkkqM356MTOO8pnS1T9aP_1J1wnkQ@mail.gmail.com>
Subject: Re: kselftest build broken?
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     shuah <shuah@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello!

On Thu, 13 Jun 2019 at 09:22, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Jun 12, 2019 at 11:13 PM Daniel D=C3=ADaz <daniel.diaz@linaro.org=
> wrote:
> > Maybe a precheck() on the tests in order to ensure that the needed
> > binaries are around?
>
> Hi Daniel,
> The Automated Testing effort:
> https://elinux.org/Automated_Testing
> is working on a standard for test metadata description which will
> capture required configs, hardware, runtime-dependencies, etc. I am
> not sure what's the current progress, though.

We just had the monthly call one hour ago. You should join our next
call! Details are in the Wiki link you shared.


> Documenting or doing a precheck is a useful first step. But ultimately
> this needs to be in machine-readable meta-data. So that it's possible
> to, say, enable as much tests as possible on a CI, rather then simply
> skip tests. A skipped test is better then a falsely failed test, but
> it still does not give any test coverage.

I agree. We discussed some of this in an impromptu microsummit at
Linaro Connect BKK19 a few months back, i.e. a way to encapsulate
tests and tests' definitions. Tim Bird is leading that effort; the
minutes of today's call will be sent to the mailing list, so keep an
eye on his update!


> > [...] we, as part of LKFT [1], run Kselftests with
> > Linux 4.4, 4.9, 4.14, 4.19, 5.1, Linus' mainline, and linux-next, on
> > arm, aarch64, x86, and x86-64, *very* often: Our test counter recently
> > exceeded 5 million!

I was wrong by an order of magnitude: It's currently at 51.7 million tests.

> > We do not build our kernels with KASAN, though, so our test runs don't
> > exhibit that bug.
>
> But you are aware of KASAN, right? Do you have any plans to use it?

Not at the moment. We are redesigning our entire build and test
infrastructure, and this is something that we are considering for our
next iteration.

> If you are interested I can go into more details as we do lots of this
> on syzbot. Besides catching more bugs there is also an interesting
> possibility of systematically testing all error paths.

Definitely join us on the Automated Testing monthly call; next one is
July 11th. There are efforts on several fronts on testing the kernel,
and we all are eager to contribute to improving the kernel test
infrastructure.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

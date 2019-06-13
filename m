Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73C4381B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbfFMPDj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:03:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44982 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732490AbfFMOWL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 10:22:11 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so17267819iob.11
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2019 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/6tVQ+is7XdZ8UmXuk2u235Fl9adNPwKXggxX3ltlhk=;
        b=VQPB+MhVTUhnxGBpEvgFNe1duyFktVYueee+URxw75EnzoLphWSwfbD1pNTc4jw6fC
         QQ4YHg2MEuexIXdYGGVm0dNU7QqPoX2BbUTYmmLFHRPFvggWcgOwGuOayivLMg46OUzF
         IYLXWvCZd3t/rMAhJM9HbbPp9FboWwlKXMZODtH3XwjwZKo8qaL+e3rLFtWptcdKYfLt
         LjKflel7lHAHNgHnLJVOQBPULj1jpDxmgC82+JA7TgSs5yWGdJVTv/kQqxPBDuhEEY44
         PLRGZ5QKDP9gHiaE7cvJ1oQtF8uGzw/cOkyGX8Gc4Zqh/ji6IpE6lLe8uo0kp7hE+Z6P
         Vowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/6tVQ+is7XdZ8UmXuk2u235Fl9adNPwKXggxX3ltlhk=;
        b=M5BlMdm68JnO5T3YQhFITV5rS2Vrycn3Qro5R4EN3MM2u+wJwG0g2IwiMbnoaFhKfX
         B+o/VkoETZkdKShjmQ/1E9MHXp/+0u2aNlqg21rJ2MujiSjTPeOzLmEfXVzAKZyAxDk5
         GpIED3L/2H7BHoVJD35n4vM45h6hHtnmunRGrs1UmvoewYgDp+Q2VMYIidd7bbD/XLKb
         nqJ8EAYaUsgb0iM1qmbZhAUYLUX28sX55R27mHN4TR4kg8eWGHNB1vyQZgfnJR4IpSAP
         aZs8rhsMUNoGnjO0LXvcGIt7JMsbA0Q3u0lY5ib20Yn6fZJtK7Sm2MTOsXNARCsmqmug
         DVXg==
X-Gm-Message-State: APjAAAXoz5gx/mP2jAWomdteHccJjlk0QyglMt22Ac8CEOkrLhpmRYsc
        7ZxGPx+ztBiiMxyblsJZSPSdNavM0gX4QxeGo9sDlw==
X-Google-Smtp-Source: APXvYqxsEFci4AzWqCxcjvjy19yTBHmDJJz++hgwgluaa6q1KVHenXIwlJgADGGAMbKjLH+KEldB73kASoW55rk8c6s=
X-Received: by 2002:a02:22c6:: with SMTP id o189mr46076430jao.35.1560435730121;
 Thu, 13 Jun 2019 07:22:10 -0700 (PDT)
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
In-Reply-To: <CAEUSe791S6ODPZq4gcfbY=5kZ98ss2qNm0ks-oo0XLwFjsO=ag@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Jun 2019 16:21:58 +0200
Message-ID: <CACT4Y+Z9073CozbR800E7p9EdVsfGJ471i0_pF4GftQkY7S90Q@mail.gmail.com>
Subject: Re: kselftest build broken?
To:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
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

On Wed, Jun 12, 2019 at 11:13 PM Daniel D=C3=ADaz <daniel.diaz@linaro.org> =
wrote:
>
> Hello!
>
> On Wed, 12 Jun 2019 at 14:32, shuah <shuah@kernel.org> wrote:
> > On 6/12/19 12:29 PM, Dmitry Vyukov wrote:
> [...]
> > > 1. You suggested to install a bunch of packages. That helped to some
> > > degree. Is there a way to figure out what packages one needs to
> > > install to build the tests other than asking you?
> >
> > I have to go through discovery at times when new tests get added. I
> > consider this a part of being a open source developer figuring out
> > dependencies for compiling and running. I don't have a magic answer
> > for you and there is no way to make sure all dependencies will be
> > documented.
>
> This is something we, as users of Kselftests, would very much like to
> see improved. We also go by trial-and-error finding out what is
> missing, but keeping up with the new tests or subsystems is often
> difficult and tend to remain broken (in usage) for some time, until we
> have the resources to look into that and fix it. The config fragments
> is an excellent example of how the test developers and the framework
> complement each other to make things work. Even documenting
> dependencies would go a long way, as a starting point, but I do
> believe that the test writers should do that and not the users go
> figure out what all is needed to run their tests.
>
> Maybe a precheck() on the tests in order to ensure that the needed
> binaries are around?

Hi Daniel,

The Automated Testing effort:
https://elinux.org/Automated_Testing
is working on a standard for test metadata description which will
capture required configs, hardware, runtime-dependencies, etc. I am
not sure what's the current progress, though.

Documenting or doing a precheck is a useful first step. But ultimately
this needs to be in machine-readable meta-data. So that it's possible
to, say, enable as much tests as possible on a CI, rather then simply
skip tests. A skipped test is better then a falsely failed test, but
it still does not give any test coverage.



> For what it's worth, this is the list of run-time dependencies package
> for OpenEmbedded: bash bc ethtool fuse-utils iproute2 iproute2-tc
> iputils-ping iputils-ping6 ncurses perl sudo python3-argparse
> python3-datetime python3-json python3-pprint python3-subprocess
> util-linux-uuidgen cpupower glibc-utils. We are probably missing a
> few.

Something like this would save me (and thousands of other people) some time=
.



> [...]
> > > 10. Do you know if anybody is running kselftests? Running as in
> > > running continuously, noticing new failures, reporting these failures=
,
> > > keeping them green, etc.
> > > I am asking because one of the tests triggers a use-after-free and I
> > > checked it was the same 3+ months ago. And I have some vague memories
> > > of trying to run kselftests 3 or so years ago, and there was a bunch
> > > of use-after-free's as well.
> >
> > Yes Linaro test rings run them and kernel developers do. I am cc'ing
> > Naresh and Anders to help with tips on how they run tests in their
> > environment. They have several test systems that they install tests
> > and run tests routine on all stable releases.
> >
> > Naresh and Anders! Can you share your process for running kselftest
> > in Linaro test farm. Thanks in advance.
>
> They're both in time zones where it's better to be sleeping at the
> moment, so I'll let them chime in with more info tomorrow (their
> time). I can share that we, as part of LKFT [1], run Kselftests with
> Linux 4.4, 4.9, 4.14, 4.19, 5.1, Linus' mainline, and linux-next, on
> arm, aarch64, x86, and x86-64, *very* often: Our test counter recently
> exceeded 5 million! You can see today's mainline results of Kselftests
> [2] and all tests therein.
>
> We do not build our kernels with KASAN, though, so our test runs don't
> exhibit that bug.

But you are aware of KASAN, right? Do you have any plans to use it?
Dynamic tools significantly improve runtime testing efficiency.
Otherwise a test may expose all of use-after-free, out-of-bounds
write, information leak, potential deadlock, memory leak, etc and
still be considered "everything is fine". Some of these bug may even
be as bad as a remote code execution. I would expect that catching
these would be a reasonable price for running tests somewhat less
often :)
Each of these tools require a one-off investment for deployment, but
then gives you constant benefit on each run.
If you are interested I can go into more details as we do lots of this
on syzbot. Besides catching more bugs there is also an interesting
possibility of systematically testing all error paths.

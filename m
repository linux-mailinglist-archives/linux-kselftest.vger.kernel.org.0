Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D6BDA293
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 02:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbfJQAI1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 20:08:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35254 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387395AbfJQAI1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 20:08:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15so947754qtq.2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 17:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lj+VJNjSUUnmvmIPtpR9coQhT3zpY2r1gvj5CTDw5Gw=;
        b=qRg5/VLWVWC9SYxwHYI50Ft4ETMSkEaR5yum71zkysgvwnItb9YvcTL69pdzCg9bil
         Fu5SDpTXPSWekGLuJM1eAQSvTWrpS6jXhRm2Es3M0cWfXH+QqhOO9qdfWe7uc0hTHl8I
         QcRpv8fFvmhaxqjREcHHQcIZC5SeuPcQWoGptASwAn7tOL/BNY8pPDfQVp5gT4LB22D0
         2+OIB1wuQZtlbwV9Zj+TBdouwSJLRUUVIchgr0Ng/iJ1rENJ7Yc0U677hfyKJ+vWTL0h
         66Y0Ia897yow6ujO3JQDEGnqJCzajgULljqzZbeqNNJeF0fhGeMHsK1zZT9Qf5j2VHxl
         XAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lj+VJNjSUUnmvmIPtpR9coQhT3zpY2r1gvj5CTDw5Gw=;
        b=s/5Nt1Q+gJnCaqvdo2nw4V682lwTroanLLejWHeNB66zN7UH71seOBOP+ga2G8v7DL
         NqoTSewWXI67xXgaS/hHs4SfZSNpqoIU3BJjPCG5MnIhyiClbxA9IZMUHVU5P5KZODHG
         xPqxs9MTT1c4gJsbedwFbC6+o+1qSUFGh0WZeGSkZxAq08snFIxr5EsnQKHYUa+nsd93
         EA5Wu1I9O6O+GwQQQRlUXszQrnJKW78lMM3KSruUPwTRvMI+9b79+kDWUSddCai5DZy3
         lz8A4czcwWeUB33zVoNKGrkrnd9KFX+wOENC6ramOJRjqruqO4bNa/TvUWW51WyZ1C2q
         O2NQ==
X-Gm-Message-State: APjAAAWNgMJpmwpfUe8EVUhoKvhLonnrbOfuxea6r79+lK9UFSlkjK/l
        kTTYAXiEVWI4BAzTu2AIDbRj64oYSl/xXeh5mx8e
X-Google-Smtp-Source: APXvYqxyM++X/3tSJxt/5+FqpGkRZr1IeqnWZZToeezoviCpt3eJab3w+Nxm2xfmctxRnY+Oj1VPDarCBghzWvH7fjQ=
X-Received: by 2002:aed:3847:: with SMTP id j65mr974927qte.124.1571270905399;
 Wed, 16 Oct 2019 17:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023931.230475-1-yzaikin@google.com> <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu> <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
In-Reply-To: <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Wed, 16 Oct 2019 17:07:49 -0700
Message-ID: <CAAXuY3q7hKoNwB6Yy0ToCbTeYtyCUzmTZv-8oMvADE0+E8GwgA@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 16, 2019 at 4:26 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 10/16/19 4:18 PM, Brendan Higgins wrote:
> > On Fri, Oct 11, 2019 at 6:19 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >>
> >> On Fri, Oct 11, 2019 at 03:05:43AM -0700, Brendan Higgins wrote:
> >>> That's an interesting point. Should we try to establish a pattern for
> >>> how tests should be configured? My *very long term* goal is to
> >>> eventually have tests able to be built and run without any kind of
> >>> kernel of any kind, but I don't think that having a single config for
> >>> all tests in a subsystem gets in the way of that, so I don't think I
> >>> have a strong preference in terms of what I want to do.
> >>>
> >>> Nevertheless, I think establishing patterns is good. Do we want to try
> >>> to follow Ted's preference as a general rule from now on?
> >>
> >> As I suggested on another thread (started on kunit-dev, but Brendan
> >> has cc'ed in linux-kselftest), I think it might really work well if
> >
> > For reference, that thread can be found here:
> > https://lore.kernel.org/linux-kselftest/CAFd5g46+OMmP8mYsH8vcpMpdOeYryp=1Lsab4Hy6pAhWjX5-4Q@mail.gmail.com/
> >
> >> "make kunit" runs all of the kunit tests automatically.  As we add
> >> more kunit tests, finding all of the CONFIG options so they can be
> >> added to the kunitconfig file is going to be hard, so kunit.py really
> >> needs an --allconfig which does this automatically.
> >>
> >> Along these lines, perhaps we should state that as a general rule the
> >> CONFIG option for Kunit tests should only depend on KUINIT, and use
> >> select to enable other dependencies.  i.e., for the ext4 kunit tests,
> >
> > I support this. Although I think that we will eventually find
> > ourselves in a position where it is not possible to satisfy all
> > dependencies for all KUnit tests, this may get us far enough along
> > that the problem may be easier, or may work well enough for a long
> > time. It's hard to say. In anycase, I think it makes sense for a unit
> > test config to select its dependencies. I also think it makes sense to
> > make each subsystem have a master config for all KUnit tests.
> >
> >> it should look like this:
> >>
> >> config EXT4_KUNIT_TESTS
> >>          bool "KUnit test for ext4 inode"
> >>          select EXT4_FS
> >>          depends on KUNIT
> >> ...
> >>
> >> In the current patch, we use "depends on EXT4_FS", which meant that
> >> when I first added "CONFIG_EXT4_KUNIT_TESTS=y" to the kunitconfig
> >> file, I got the following confusing error message:
> >>
> >> % ./tools/testing/kunit/kunit.py  run
> >> Regenerating .config ...
> >> ERROR:root:Provided Kconfig is not contained in validated .config!
> >>
> >> Using "select EXT4_FS" makes it much easier to enable the ext4 kunit
> >> tests in kunitconfig.  At the moment requiring that we two lines to
> >> kunitconfig to enable ext4 isn't _that_ bad:
> >>
> >> CONFIG_EXT4_FS=y
> >> CONFIG_EXT4_KUNIT_TESTS=y
> >>
> >> but over time, if many subsystems start adding unit tests, the
> >> overhead of managing the kunitconfig file is going to get unwieldy.
> >
> > Agreed.
> >
> >> Hence my suggestion that we just make all Kunit CONFIG options depend
> >> only on CONFIG_KUNIT.
> >
>
> Sounds good to me. I am a bit behind in reviews. I will review v5.
>
> > That makes sense for now. I think we will eventually reach a point
> > where that may not be enough or that we may have KUnit configs which
> > are mutually exclusive; nevertheless, I imagine that this may be a
> > good short term solution for a decent amount of time.
> >
> > Shuah suggested an alternative in the form of config fragments. I
> > think Ted's solution is going to be easier to maintain in the short
> > term. Any other thoughts?
> >
>
> I don't recall commenting on config fragments per say. I think I was
> asking if we can make the test data dynamic as opposed to static.
>
> Lurii said it might be difficult to do it that way since we are doing
> this at boot time + we are testing extfs. If not for this test, for
> others, it would good to explore option to make test data dynamic,
> so it would be easier to use custom test data.
>
I can see the value of building test data blobs for unit test consumption
but the intended use case would be more like what Theodore described
than just manually feeding random data.
> I don't really buy the argument that unit tests should be deterministic
> Possibly, but I would opt for having the ability to feed test data.
>
If the test data is exercising an interesting case, you ought to add it to the
test permanently. If not, why bother testing against this data at all?
The whole purpose of the unit tests is getting a lot of coverage on the cheap
and keeping it there to catch any regressions.
> thanks,
> -- Shuah

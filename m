Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D021E6929
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405688AbgE1SPw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 14:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405733AbgE1SPu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 14:15:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5349C08C5C6;
        Thu, 28 May 2020 11:15:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so11921069plo.7;
        Thu, 28 May 2020 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M1/qHjkaRtVrUpNBfcJLe2iz+EPbaAzFxblaRe8Z9KQ=;
        b=lIkJi04oV/WHagwbv1XFIQAjl1up9hW92WFbX/QAMInzUxeHni0a5Iq8dP+0Gi2lCH
         axNIewgg/BQt0DOuOzd8obSNyeVyEBk6ZZfb1iklTKmUEU5AfVBwyK3OtqBRnu+5NxPF
         By39HyvOZ8CUc/P+14hVTLWjqvGQMKIROfVR5R4HLH4UYG1Ijey4C5o21BLb0t34XpkP
         TkW1SBst8flkCIGtcS4Wr/y8bpOo0ZssHo+wZc1MYgUez3CvTbajvy/PFjlxJjlpmNsw
         0/k7iRJ62g4G2pS2pMS3nojg2nYzlRxZNxOO7P1QLuzcjEuXeJei3zyc7rrskbpH3Fzq
         Ik2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M1/qHjkaRtVrUpNBfcJLe2iz+EPbaAzFxblaRe8Z9KQ=;
        b=esWm/ZXry1q8g4qSz0VqJsoSIQZ5bxIuzYKQ8Hmq8cSfOlYHsgeGh74D7aMVpl8IbY
         Anv4EwFX82J3YhmySjlWaXfIVFOR/ZpmIXwFWmjpDiU+GGKIvCXNnRlExkvB/m9iPxmH
         MtuyngxpZrztkX2yFq1jlnbmSxpBdRCTV3vzlYEtks33Dn7LP6pZuUTbkSWhdXksnP6p
         0IaGq9Q95FoPMdSibcF6PSZIOeG7hvpZ2/qP1FmXxz+0edeAZWpkOSN6aDFpT2Q7S+KS
         d7oQIf69VLYaI0vDWFHEmmawM0CehD1orDKzhI3uObazR0k1XHGjnofBMUVbrFia+DXK
         Yz0g==
X-Gm-Message-State: AOAM531DPYLEvvkrP2LMwamA0WOzy47y9tBkN0Sg1KLKUH4SNo4yh+Z7
        K4pfisCLXNCJ0q3btSZmcJQ=
X-Google-Smtp-Source: ABdhPJzXUVIQN4fSS8NClxm0Y0zSiRGqKpzR+VLVgyM1ij+mt1bt+UYUm87rQkh2kNlZV2n6KQoUHQ==
X-Received: by 2002:a17:90a:bb81:: with SMTP id v1mr4811984pjr.168.1590689750239;
        Thu, 28 May 2020 11:15:50 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4a1c])
        by smtp.gmail.com with ESMTPSA id m3sm5863514pjs.17.2020.05.28.11.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 11:15:49 -0700 (PDT)
Date:   Thu, 28 May 2020 11:15:46 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Benc <jbenc@redhat.com>,
        shuah <shuah@kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
Message-ID: <20200528181546.eqzcc5kq5y6hnbcu@ast-mbp.dhcp.thefacebook.com>
References: <xuny367lq1z1.fsf@redhat.com>
 <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com>
 <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
 <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com>
 <20200528105631.GE3115014@kroah.com>
 <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
 <be0a24f4-8602-ba1b-6ca4-7308b01d7a48@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be0a24f4-8602-ba1b-6ca4-7308b01d7a48@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 11:07:09AM -0600, Shuah Khan wrote:
> On 5/28/20 10:14 AM, Alexei Starovoitov wrote:
> > On Thu, May 28, 2020 at 12:56:31PM +0200, Greg KH wrote:
> > > On Thu, May 28, 2020 at 10:05:57AM +0200, Jiri Benc wrote:
> > > > On Wed, 27 May 2020 15:23:13 -0700, Alexei Starovoitov wrote:
> > > > > I prefer to keep selftests/bpf install broken.
> > > > > This forced marriage between kselftests and selftests/bpf
> > > > > never worked well. I think it's a time to free them up from each other.
> > > > 
> > > > Alexei, it would be great if you could cooperate with other people
> > > > instead of pushing your own way. The selftests infrastructure was put
> > > > to the kernel to have one place for testing. Inventing yet another way
> > > > to add tests does not help anyone. You don't own the kernel. We're
> > > > community, we should cooperate.
> > > 
> > > I agree, we rely on the infrastructure of the kselftests framework so
> > > that testing systems do not have to create "custom" frameworks to handle
> > > all of the individual variants that could easily crop up here.
> > > 
> > > Let's keep it easy for people to run and use these tests, to not do so
> > > is to ensure that they are not used, which is the exact opposite goal of
> > > creating tests.
> > 
> > Greg,
> > 
> > It is easy for people (bpf developers) to run and use the tests.
> > Every developer runs them before submitting patches.
> > New tests is a hard requirement for any new features.
> > Maintainers run them for every push.
> > 
> > What I was and will push back hard is when other people (not bpf developers)
> > come back with an excuse that some CI system has a hard time running these
> > tests. It's the problem of weak CI. That CI needs to be fixed. Not the tests.
> > The example of this is that we already have github/libbpf CI that runs
> > selftests/bpf just fine. Anyone who wants to do another CI are welcome to copy
> > paste what already works instead of burdening people (bpf developers) who run
> > and use existing tests. I frankly have no sympathy to folks who put their own
> > interest of their CI development in front of bpf community of developers.
> > The main job of CI is to help developers and maintainers.
> > Where helping means to not impose new dumb rules on developers because CI
> > framework is dumb. Fix CI instead.
> > 
> 
> Here is what CI users are requesting:
> 
> - ability to install bpf test with other selftests using kselftest
>   install. The common framework is in place and with minor changes
>   to bpf test Makefile, we can make this happen. Others and myself
>   are willing to work on this, so we can get bpf test coverage in
>   test rings.

so you're saying that bpf maintainers and all bpf developers now
would need to incorporate new 'make install' step to their workflow
because some unknown CI system that is not even functional decided
to do 'make install' ?
That's exactly my point about selfish CI developers who put their
needs in front of bpf community of developers.

> - be able to build and run existing tests without breaking the test
>   build when new tests are added that have hard dependency on new
>   versions of tools (llvm etc.). This isn't such a novel idea. We
>   don't break kernel builds every single release and even when we
>   require newer compiler releases. Plan the new tests with the intent
>   to not break existing users and add new tests at the same time.
>   We use min rev and not bleeding edge as the requirement for kernel
>   build.

'existing users'? CI is not a user. CI is machine that should _help_
developers. Above two things (forcing install on humans and
breaking day-to-day tests for bpf maintainers and developers)
is the opposite of helping developers.
Please do NOT use such useless CI as an excuse.
Such CI should not be built in the first place when it slows down
the development instead of helping it.

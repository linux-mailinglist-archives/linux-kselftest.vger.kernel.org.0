Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6C01E6A3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 21:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406212AbgE1TTB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405596AbgE1TS7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 15:18:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97CBC08C5C6;
        Thu, 28 May 2020 12:18:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id g5so2553955pfm.10;
        Thu, 28 May 2020 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=frQ72g6GniWTfY01x2KnWq/4XjlVSgdeAWA3rnvfjSQ=;
        b=WZMCd3OGkv723uDpwkYlvTg50C4pejg9YPlCqrWkD7ySXSaseRelYA3YLP1UTJT7vx
         8/pKIAX5LcTz0Ma03RfBjGojC/OmcRS7g0A1l4zak0jcxQbQW9s8TN6AsoijPHAj4QiC
         +361cKAvgq+E5fxvXPScSYPraCCxoZ4fRcTyR4RIroVzmlgjAIDxenkRXEvgVrPMGZwY
         askKO8DiHKNCu2W6PPZj0Nghip+ZJIqkCbLOj/S+xSicF/DqvlDtouMT/dxoFp38fmas
         NKdJnTQxTttbYcKwp2imZI3zKHw5rscMvK1w204/SzfuFBCA7M22iUOzZuT4W4VFcjTp
         7FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=frQ72g6GniWTfY01x2KnWq/4XjlVSgdeAWA3rnvfjSQ=;
        b=oaC/1N4iIlIOdiRsQm4bTKwzj/Lo7M7mqkQDmrStlqhCXAu7kUE+AZAmEbHBgHXkRI
         i8u2XgqSkJDeC0Xd3gYKbyBfOhyyKnezQS6EHu9yYlG/ajEFqf6wW03/Vr4mPD16InWb
         393ABH/kQNXg+TyFzz6tcVPLy/bbllqKTlImDFkY1CzcxcsgPRWI+f+TDi2+Jhv9pGb5
         TVvrsJY8R1Dzp03Cz0gLzx8qz5QViDylHsrCCP4emeuOmnk7VUmb8AM4CI2aVcwuO6iw
         XYpctxckc+DmarXbH+pgn3I+IWsK3oJ7DS+2JqG0JwL+ccwxFbs2B3IiSHKpnbtjv0cK
         nUXQ==
X-Gm-Message-State: AOAM531o+ZVbYPCf6n4ILrC95Rhc74sQkwSCEI2UMUqKjW8hE+g4G7lB
        m6ej6hi7jFijCT67AL4yGiIt76Yp
X-Google-Smtp-Source: ABdhPJyO/SsPUndBaLqnijCzNDJTkTFNmjVT4wofsQm75aUOTaJmidexurW7UDYYEae+QlNWQZsc4g==
X-Received: by 2002:a63:104e:: with SMTP id 14mr4240420pgq.244.1590693539304;
        Thu, 28 May 2020 12:18:59 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4a1c])
        by smtp.gmail.com with ESMTPSA id jx10sm5720281pjb.46.2020.05.28.12.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:18:57 -0700 (PDT)
Date:   Thu, 28 May 2020 12:18:55 -0700
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
Message-ID: <20200528191855.flqcm4zlyrvih5r4@ast-mbp.dhcp.thefacebook.com>
References: <xunyh7w1nwem.fsf@redhat.com>
 <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
 <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com>
 <20200528105631.GE3115014@kroah.com>
 <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
 <be0a24f4-8602-ba1b-6ca4-7308b01d7a48@linuxfoundation.org>
 <20200528181546.eqzcc5kq5y6hnbcu@ast-mbp.dhcp.thefacebook.com>
 <69d6eb73-ad59-53b9-4712-537a80bcefd7@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d6eb73-ad59-53b9-4712-537a80bcefd7@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 12:59:06PM -0600, Shuah Khan wrote:
> On 5/28/20 12:15 PM, Alexei Starovoitov wrote:
> > On Thu, May 28, 2020 at 11:07:09AM -0600, Shuah Khan wrote:
> > > On 5/28/20 10:14 AM, Alexei Starovoitov wrote:
> > > > On Thu, May 28, 2020 at 12:56:31PM +0200, Greg KH wrote:
> > > > > On Thu, May 28, 2020 at 10:05:57AM +0200, Jiri Benc wrote:
> > > > > > On Wed, 27 May 2020 15:23:13 -0700, Alexei Starovoitov wrote:
> > > > > > > I prefer to keep selftests/bpf install broken.
> > > > > > > This forced marriage between kselftests and selftests/bpf
> > > > > > > never worked well. I think it's a time to free them up from each other.
> > > > > > 
> > > > > > Alexei, it would be great if you could cooperate with other people
> > > > > > instead of pushing your own way. The selftests infrastructure was put
> > > > > > to the kernel to have one place for testing. Inventing yet another way
> > > > > > to add tests does not help anyone. You don't own the kernel. We're
> > > > > > community, we should cooperate.
> > > > > 
> > > > > I agree, we rely on the infrastructure of the kselftests framework so
> > > > > that testing systems do not have to create "custom" frameworks to handle
> > > > > all of the individual variants that could easily crop up here.
> > > > > 
> > > > > Let's keep it easy for people to run and use these tests, to not do so
> > > > > is to ensure that they are not used, which is the exact opposite goal of
> > > > > creating tests.
> > > > 
> > > > Greg,
> > > > 
> > > > It is easy for people (bpf developers) to run and use the tests.
> > > > Every developer runs them before submitting patches.
> > > > New tests is a hard requirement for any new features.
> > > > Maintainers run them for every push.
> > > > 
> > > > What I was and will push back hard is when other people (not bpf developers)
> > > > come back with an excuse that some CI system has a hard time running these
> > > > tests. It's the problem of weak CI. That CI needs to be fixed. Not the tests.
> > > > The example of this is that we already have github/libbpf CI that runs
> > > > selftests/bpf just fine. Anyone who wants to do another CI are welcome to copy
> > > > paste what already works instead of burdening people (bpf developers) who run
> > > > and use existing tests. I frankly have no sympathy to folks who put their own
> > > > interest of their CI development in front of bpf community of developers.
> > > > The main job of CI is to help developers and maintainers.
> > > > Where helping means to not impose new dumb rules on developers because CI
> > > > framework is dumb. Fix CI instead.
> > > > 
> > > 
> > > Here is what CI users are requesting:
> > > 
> > > - ability to install bpf test with other selftests using kselftest
> > >    install. The common framework is in place and with minor changes
> > >    to bpf test Makefile, we can make this happen. Others and myself
> > >    are willing to work on this, so we can get bpf test coverage in
> > >    test rings.
> > 
> > so you're saying that bpf maintainers and all bpf developers now
> > would need to incorporate new 'make install' step to their workflow
> > because some unknown CI system that is not even functional decided
> > to do 'make install' ?
> > That's exactly my point about selfish CI developers who put their
> > needs in front of bpf community of developers.
> > 
> 
> There is no need change bpf maintainer and developer workflow. You
> don't have to use install option. Kselftest framework doesn't
> require a specific workflow and you can:
> 
> 1. Build and run your tests from bpf directory if you choose to
> 2. Install to run on different target.
> 
> Adding install install option requires a change to bpf Makefile
> only to copy test that are built to install directory.
> 
> make kselftest-install from the main kernel Makefile in conjunction
> with selftests Makefile and lib.mk will handle all of that.
> 
> Sounds like there is a misunderstanding that bpf maintainer/developer
> workflow will have to change to support install. That is not the case.
> The reason kselftest exists on the first place is to have common
> framework to take care of build/run/install as a common layer so
> individual test writers don't have to worry about these details
> and write tests instead.

I don't think you understand the 'make install' implications.
Not doing 'make install' means that all the Makefile changes that
Yauheni is proposing will immediately bit rot.
People are constantly adding new tests and changing makefile.
'make install' _will_ be broken instantly unless _humans_ incorporate
it in their patch development process and maintainer incorporate
that step into their workflow as well.

Ohh, but don't worry about this broken 'make install' is not an answer.
It's broken now and I don't want to see patches that move it
from one broken state into another broken state and at the same time
add complexity to it.

That's very different from 'make install' doing 'cp -r' of the whole dir.
In such case the chances of it going stale and broken are much lower.

> > > - be able to build and run existing tests without breaking the test
> > >    build when new tests are added that have hard dependency on new
> > >    versions of tools (llvm etc.). This isn't such a novel idea. We
> > >    don't break kernel builds every single release and even when we
> > >    require newer compiler releases. Plan the new tests with the intent
> > >    to not break existing users and add new tests at the same time.
> > >    We use min rev and not bleeding edge as the requirement for kernel
> > >    build.
> > 
> > 'existing users'?
> 
> I said existing tests not users. When you add new bpf tests, existing
> tests should continue to build and run without dependency on new revs
> of llvm.

Who said that existing test stop building with new llvm ?
Please check your facts.

> If bpf test doesn't build and/or installed, it won't run
> on test rings that qualify stable/next/main releases.

That's the case today and I prefer to keep it this way.
stable folks ignored our recommendations on how selftests/bpf should
be run, so please don't come up with your ways of doing it and
complain that something doesn't work.

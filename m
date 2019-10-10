Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213BFD2B2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2019 15:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbfJJNWx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 09:22:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:44396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388099AbfJJNWx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 09:22:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 717F5AED6;
        Thu, 10 Oct 2019 13:22:51 +0000 (UTC)
Date:   Thu, 10 Oct 2019 15:22:49 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Richard Palethorpe <richard.palethorpe@suse.com>,
        syzkaller <syzkaller@googlegroups.com>, kernelci@groups.io,
        shuah <shuah@kernel.org>, ltp@lists.linux.it,
        George Kennedy <george.kennedy@oracle.com>,
        Cyril Hrubis <chrubis@suse.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org
Subject: Re: [RFC PATCH] LTP Wrapper for Syzkaller reproducers
Message-ID: <20191010132249.GB9416@rei.lan>
References: <20191009142446.6997-1-rpalethorpe@suse.com>
 <CACT4Y+b0tTAQ0r_2gCVjjRh--Xwv=aLzh6MY=ciXMMrK+cAQsA@mail.gmail.com>
 <20191009145416.GA5014@rei.lan>
 <CACT4Y+ZL8ocQPpwR-_8+0PdF=r3AkFZKvOR==+P0y0GF67w1Vg@mail.gmail.com>
 <20191009180447.GD15291@rei.lan>
 <CACT4Y+ZABX2z4Lxrvokf5DHz351xTys-gJPNhFjP+Zx6Qd2zsg@mail.gmail.com>
 <20191010093011.GA2508@rei.lan>
 <CACT4Y+ZARc3gK9rweQnLr26Aa_8j9OrpAs-wfTVP2owqmXm+kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZARc3gK9rweQnLr26Aa_8j9OrpAs-wfTVP2owqmXm+kQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!
> > > > > > Indeed, it's removed recursively by the test library.
> > > > >
> > > > > :popcorn:
> > > > >
> > > > > It took me several years to figure out how to more or less reliably
> > > > > remove dirs after the fuzzer ;)
> > > > > (no, unlink won't do ;))
> > > >
> > > > I guess that there are things such as immutable file attributes that has
> > > > to be cleared and many more. Do you have piece of code somewhere that we
> > > > can look into to spare us from reinventing the wheel?
> > >
> > > Here is what we have:
> > > https://github.com/google/syzkaller/blob/c4b9981b5f5b70dc03eb3f76c618398510101a1d/executor/common_linux.h#L2358-L2461
> > > Maybe it can be simplified, but that's what we ended up with after
> > > some organic evolution. At least the comments may give some hints as
> > > to what may go wrong.
> >
> > Thanks a lot!
> >
> > Also I see that you are using namespaces, and much more, to sandbox the
> > fuzzer, I was wondering if we should do that, at least separate user and
> > pid namespace sounds like a good idea to me.
> 
> I don't know how far you want to go. This sandboxing definitely helps
> us to isolate processes and make tests more repeatable by avoiding
> interference (I don't know if LTP, say, runs tests in parallel).

Not yet, but we are slowly getting to a point where LTP tests could be
run in parallel. It's a bit more complicated for functional tests, since
there are number of constraints, for which tests should not be run in
parallel. And for number of these sandboxing wouldn't help either, since
it's more of a matter of available resources than isolation.

I'm close to solving first half of the problem, i.e. propagating the
test constraints from tests to the testrunner. I also wrote a blog post
about this, you can read it at:

https://people.kernel.org/metan/towards-parallel-kernel-test-runs

But even without running tests in parallel there are resources that have
kernel persistence and will outlive the process, such as SysV IPC. So I
guess that at least some sandboxing has to be done even for non-parallel
runs.

> mount namespaces are useful to later drop all of test mounts at once,
> this would solve a significant part of the remote_dir logic. If the
> temp dir is on tmpfs in the mount namespace as well, then it will be
> automatically dropped altogether with all contents.

Again, thanks for the hint!

-- 
Cyril Hrubis
chrubis@suse.cz

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019AD45A59B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Nov 2021 15:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbhKWO3N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Nov 2021 09:29:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235246AbhKWO3N (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Nov 2021 09:29:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33BB860E54;
        Tue, 23 Nov 2021 14:26:02 +0000 (UTC)
Date:   Tue, 23 Nov 2021 15:26:00 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org,
        christian@brauner.io, nathan@kernel.org, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] selftests: cgroup: build error multiple outpt files
Message-ID: <20211123142600.r5d52iwhbqhujiux@wittgenstein>
References: <20211105162530.3307666-1-anders.roxell@linaro.org>
 <61b21c4b-fc26-5e41-3aed-22a7e56b04ba@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61b21c4b-fc26-5e41-3aed-22a7e56b04ba@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 19, 2021 at 05:22:20PM -0700, Shuah Khan wrote:
> On 11/5/21 10:25 AM, Anders Roxell wrote:
> > When building selftests/cgroup: with clang the following error are seen:
> > 
> > clang -Wall -pthread    test_memcontrol.c cgroup_util.c ../clone3/clone3_selftests.h  -o /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol
> > clang: error: cannot specify -o when generating multiple output files
> > make[3]: *** [../lib.mk:146: /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol] Error 1
> > 
> > Rework to add the header files to LOCAL_HDRS before including ../lib.mk,
> > since the dependency is evaluated in '$(OUTPUT)/%:%.c $(LOCAL_HDRS)' in
> > file lib.mk.
> > 
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >   tools/testing/selftests/cgroup/Makefile | 12 +++++++-----
> >   tools/testing/selftests/lib.mk          |  2 +-
> >   2 files changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
> > index 59e222460581..745fe25fa0b9 100644
> > --- a/tools/testing/selftests/cgroup/Makefile
> > +++ b/tools/testing/selftests/cgroup/Makefile
> > @@ -11,10 +11,12 @@ TEST_GEN_PROGS += test_core
> >   TEST_GEN_PROGS += test_freezer
> >   TEST_GEN_PROGS += test_kill
> > +LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
> > +
> 
> This looks odd to me. Why are we introducing dependencies between tests?
> clone3 includes in cgroup? Looks odd to me.

The cgroup tests need access to clone3() functionality in order to test
CLONE_INTO_CGROUP which is more suited to be placed alongside the cgroup
tests. There are a few other tests that include the clone3 header.

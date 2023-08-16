Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517D377DD68
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 11:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjHPJge convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243465AbjHPJgb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 05:36:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BEC026A4;
        Wed, 16 Aug 2023 02:36:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD2D71063;
        Wed, 16 Aug 2023 02:37:10 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1F993F64C;
        Wed, 16 Aug 2023 02:36:28 -0700 (PDT)
Date:   Wed, 16 Aug 2023 10:36:26 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: cachestat: test for cachestat
 availability
Message-ID: <20230816103626.0f679788@donnerap.manchester.arm.com>
In-Reply-To: <CAKEwX=NvBCiy6WxJWg9EYyTwKTQY35G6=3T2L8KKEe46xg82rg@mail.gmail.com>
References: <20230815155612.2535947-1-andre.przywara@arm.com>
        <20230815155612.2535947-4-andre.przywara@arm.com>
        <CAKEwX=NvBCiy6WxJWg9EYyTwKTQY35G6=3T2L8KKEe46xg82rg@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 15 Aug 2023 16:25:54 -0700
Nhat Pham <nphamcs@gmail.com> wrote:

Hi Nhat,

many thanks for having a look!

> On Tue, Aug 15, 2023 at 8:56 AM Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > As cachestat is a new syscall, it won't be available on older kernels,
> > for instance those running on a build machine. In this case, a run
> > reports all tests as "not ok" at the moment.  
> Interesting - I was under the assumption that if you backported the
> selftests for cachestat, you would also backport the syscall's implementation
> and wiring.

Well, just running the tests on the kernel you just built is only one
use case. I build the tests from latest git HEAD, then copy them to a
target system with some kernel running. Or I just build the tests and run
them for regression testing on my build system with a distro kernel, which
is Ubuntu's 5.15 flavour, in my case.
The documentation explicitly mentions that selftests should work on older
kernels (copying the normal userland compatibility requirements), check
the second paragraph of Documentation/dev-tools/kselftest.rst.

> But yeah, I guess if you build with !CONFIG_CACHESTAT_SYSCALL,
> these tests would fail.
> >
> > Test for the cachestat syscall availability first, before doing further
> > tests, and bail out early with a TAP SKIP comment.
> >
> > This also uses the opportunity to add the proper TAP headers, and add
> > one check for the syscall error handling (illegal file descriptor).  
> Thanks for the addition!
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  .../selftests/cachestat/test_cachestat.c      | 22 ++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
> > index a5a4ac8dcb76c..77620e7ecf562 100644
> > --- a/tools/testing/selftests/cachestat/test_cachestat.c
> > +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> > @@ -15,6 +15,8 @@
> >
> >  #include "../kselftest.h"
> >
> > +#define NR_TESTS       8
> > +
> >  static const char * const dev_files[] = {
> >         "/dev/zero", "/dev/null", "/dev/urandom",
> >         "/proc/version", "/proc"
> > @@ -235,7 +237,25 @@ bool test_cachestat_shmem(void)
> >
> >  int main(void)
> >  {
> > -       int ret = 0;
> > +       int ret;
> > +
> > +       ksft_print_header();
> > +
> > +       ret = syscall(__NR_cachestat, -1, NULL, NULL, 0);
> > +       if (ret == -1 && errno == ENOSYS) {  
> nit: if (ret && errno == ENOSYS) sounds cleaner, but up to you.

Do you ever return a positive value other than 0? I think technically
errno is only valid when the return value is -1, so in the error case,
which I wanted to test here explicitly.
Some syscall selftests (I checked landlock the other day) do very elaborate
testing of the error path, trying to carefully cover all corner cases:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/landlock/base_test.c#n24

So this test was inspired by that, but I didn't want to go that far here
;-)

> > +               printf("1..0 # Skipped: cachestat syscall not available\n");  
> nit: perhaps ksft_print_msg()?

Ah, yes, of course!

> > +               return KSFT_SKIP;
> > +       }
> > +
> > +       ksft_set_plan(NR_TESTS);
> > +
> > +       if (ret == -1 && errno == EBADF) {
> > +               ksft_test_result_pass("bad file descriptor recognized\n");
> > +               ret = 0;
> > +       } else {
> > +               ksft_test_result_fail("bad file descriptor ignored\n");
> > +               ret = 1;
> > +       }  
> Nice!
> >
> >         for (int i = 0; i < 5; i++) {
> >                 const char *dev_filename = dev_files[i];
> > --
> > 2.25.1
> >  
> Nitpicking aside:
> Acked-by: Nhat Pham <nphamcs@gmail.com>

Thanks, I will send a v2 later, using ksft_print_msg(). But first I will
try if I can detect a tmpfs instance without boiling the ocean.

Cheers,
Andre

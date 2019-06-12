Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC19D43038
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 21:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfFLTcf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 15:32:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbfFLTcf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 15:32:35 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48CFF20896;
        Wed, 12 Jun 2019 19:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560367954;
        bh=SHcIeJ9phl8lui0vkK0oNnK7hkoLeNhV19m9Iq7HY30=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UrK3IGUESOGc+yaupJW5QOi3HQ+a5H1gF6AgWzXknbp7KPTaSH+JvOgR/NdhnN+3F
         qPDI2J3LMa8oJCQq3QApaJh0/V7FwvqD43YUv8938hvj74Uo2KCSmMdtVTotTLXFaI
         1VGLrHQSJBo+dMYQRPPPB4kx1iEEhsejfx5tP1Mg=
Subject: Re: kselftest build broken?
To:     Dmitry Vyukov <dvyukov@google.com>, naresh.kamboju@linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     linux-kselftest@vger.kernel.org
References: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
 <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org>
 <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
 <6d5e0484-4dbc-d122-1ae4-9cce44c2d668@kernel.org>
 <CACT4Y+aE841JzvEVFmAevgmBO0eOssz0MFydWiuoAp18nr=_DA@mail.gmail.com>
 <CACT4Y+abfa9xVg+3S_tgpOA3cZ2bexe51d0FEZyBCGn0M-6DiA@mail.gmail.com>
 <CACT4Y+aiDUV4_JrvKct98mKvPwEQXSZFXae3qweSmotpzCAGTw@mail.gmail.com>
 <CACT4Y+a8zK7st7LUTkD=AaUBZGsn5hqLt5NXHHvJ0dg1Jds6Nw@mail.gmail.com>
 <CACT4Y+YKf3BFi-9J7Ag0yPtEWYrsPZXY1qUw21yRkNYu51wBWg@mail.gmail.com>
 <CACT4Y+bfz2F-p4xODb_=rU0+F-FJCC66MJW7q9DXd0UHoUfgwg@mail.gmail.com>
 <1e2cc74d-a6c2-0a73-ede5-c72df28e96b2@kernel.org>
 <CACT4Y+a203xykAHckhtMQ7ov-wNJ-YeuMg=o7qk=H9TQ756jcg@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <37e5e069-076d-9833-9eab-51c507fbbe2f@kernel.org>
Date:   Wed, 12 Jun 2019 13:32:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+a203xykAHckhtMQ7ov-wNJ-YeuMg=o7qk=H9TQ756jcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/12/19 12:29 PM, Dmitry Vyukov wrote:
> On Wed, Jun 12, 2019 at 6:45 PM shuah <shuah@kernel.org> wrote:
>> Hi Dmitry,
>>
>> This is the 6th email from you in a span of 3 hours! I am just going to
>> respond this last one. Please try to summarize your questions instead of
>> sending email storm, so it will be easier to parse and more productive
>> for both of us.
> 
> Hi Shuah,
> 
> Sorry for that. Let me combine all current questions in a more structured way.
> 
> My motivation: I am trying to understand what does it take to run/add
> kernel tests in particular for the purpose of providing working
> instructions to run kernel test to a new team member or a new external
> kernel developer, and if it's feasible to ask a kernel developer
> fixing a bug to add a regression test and ensure that it works. Note
> in these cases a user may not have lots of specific expertise (e.g.
> any unsaid/implicit thing may be a showstopper) and/or don't have
> infinite motivation/time (may give up given a single excuse to do so)
> and/or don't have specific interest/expertise in the tested subsystem
> (e.g. a drive-by
> fix). So now I am trying to follow this route myself, documenting steps.
> 
> 1. You suggested to install a bunch of packages. That helped to some
> degree. Is there a way to figure out what packages one needs to
> install to build the tests other than asking you?
> 

I have to go through discovery at times when new tests get added. I
consider this a part of being a open source developer figuring out
dependencies for compiling and running. I don't have a magic answer
for you and there is no way to make sure all dependencies will be
documented.


> 2. Build of bpf tests was broken after installing all required
> packages. It helped to delete some random files
> (tools/testing/selftests/bpf/{feature,FEATURE-DUMP.libbpf}). Is it
> something to fix in kselftests? Deleting random files was a chaotic
> action which I can't explain to anybody.
> 
> 3. I am still getting 1 build error:
> 
>    CC       /usr/local/google/home/dvyukov/src/linux/tools/testing/selftests/bpf/str_error.o
> timestamping.c:249:19: error: ‘SIOCGSTAMP’ undeclared (first use in
> this function); did you mean ‘SIOCGSTAMPNS’?
> 
> What should I do to fix this?

I am not seeing that on my system. I suspect you are still missing some
packages and/or headers.

> 
> 4. Are individual test errors are supposed to be fatal? Or I can just
> ignore a single error and proceed?

Individual test errors aren't fatal and the run completes reporting
errors from individual tests.

> I've tried to proceed, but I am not sure if I will get some
> unexplainable errors later because of that. By default I would assume
> that any errors during make are fatal.
> 

Kselftest is a suite of developer tests. Please read the documentation.


> 5. The instructions on running tests:
> 
>    $ make -C tools/testing/selftests run_tests
>    $ make kselftest
> 
> Do they assume that the tests will run right on my host machine? It's
> not stated/explained anywhere, but I don't see how "make kselftest"
> can use my usual setup because it don't know about it.

You have to tailor to it your environment. This is really for kernel
developers and test rings that routines test kernels under development.

> I cannot run tests on the host. Policy rules aside, this is yet
> untested kernel, so by installing it I am risking losing my whole
> machine.

This is just like running kernel make. Build happens on the system.
The idea is that kernel developers use these tests to test their
code.

> Reading further, "Install selftests" and "Running installed selftests"
> sections seem to be a way to run tests on another machine. Is it
> correct? Are there any other options? There seems to be a bunch of
> implicit unsaid things, so I am asking in case I am missing some even
> simpler way to run tests.
> Or otherwise, what is the purpose of "installing" tests?
> 
> 6. The "Running installed selftests" section says:
> "Kselftest install as well as the Kselftest tarball provide a script
> named "run_kselftest.sh" to run the tests".
> 

Right. You have to generate it. As documented in the kselftest.rst.
kselftest_install.sh will install compiled tests and run_skefltest.sh

You can run gen_kselftest_tar.sh to create tarball and unpack it on
your test system.

> What is the "Kselftest tarball"? Where does one get one? I don't see
> any mentions of "tarball" anywhere else in the doc.

Please see above. You can generate tarball yourself using "tar"

> 
> 7. What image am I supposed to use to run kselftests? Say, my goal is
> either running as many tests as possible (CI scenario), or tests for a
> specific subsystem (a drive-by fix scenario).
> All images that I have do not seem to be suitable. One is failing with:
> ./run_kselftest.sh: 2: ./run_kselftest.sh: realpath: not found
> And there is no clear path to fix this. After I guessed the right
> package to install, it turned out to be broken in the distro.
> In another image all C programs fail to run with:
> ./test_maps: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.26'
> 
> How is one supposed to get an image suitable for running kselftests?
> 

When you say image - what is image in this context.

You build new kernel, install it, boot the new kernel and run selftests.
If your kernel build system is different from test system, then you
build and install kernel and build kselftest and install kselftest and
copy them over to the test system.

> 8. Lots of tests fail/skipped with some cryptic for me errors like:
> 
> # Cannot find device "ip6gre11"
> 
> # selftests: [SKIP] Could not run test without the ip xdpgeneric support
> 

Right that means the kernel doesn't support the feature.

> # modprobe: ERROR: ../libkmod/libkmod.c:586 kmod_search_moddep() could
> not open moddep file '/lib/modules/5.1.0+/modules.dep.bin'
> 

You don't have the module built-in.

> # selftests: bpf: test_tc_edt.sh
> # nc is not available
> not ok 40 selftests: bpf: test_tc_edt.sh
> 
> Say, I either want to run tests for a specific subsystem because I am
> doing a drive-by fix (a typical newcomer/good Samaritan scenario), or
> I want to run as many tests as possible (a typical CI scenario). Is
> there a way to bulk satisfy all these prerequisite (configs, binaries
> and whatever they are asking for)?
> 
> 9. There is a test somewhere in the middle that consistently reboots my machine:
> 
> # selftests: breakpoints: step_after_suspend_test
> [  514.024889] PM: suspend entry (deep)
> [  514.025959] PM: Syncing filesystems ... done.
> [  514.051573] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [  514.054140] OOM killer disabled.
> [  514.054764] Freezing remaining freezable tasks ... (elapsed 0.001
> seconds) done.
> [  514.057695] printk: Suspending console(s) (use no_console_suspend to debug)
> early console in extract_kernel
> ...

Yes. Some tests require reboot and you want to avoid those, if you don't
want to run them. Please look at the kselftest.rst.

> 
> Is it a bug in the test? in the kernel? Or how is this supposed to
> work/what am I supposed to do with this?
> 
> 10. Do you know if anybody is running kselftests? Running as in
> running continuously, noticing new failures, reporting these failures,
> keeping them green, etc.
> I am asking because one of the tests triggers a use-after-free and I
> checked it was the same 3+ months ago. And I have some vague memories
> of trying to run kselftests 3 or so years ago, and there was a bunch
> of use-after-free's as well.

Yes Linaro test rings run them and kernel developers do. I am cc'ing
Naresh and Anders to help with tips on how they run tests in their
environment. They have several test systems that they install tests
and run tests routine on all stable releases.

Naresh and Anders! Can you share your process for running kselftest
in Linaro test farm. Thanks in advance.

> 
> 11. Do we know what's the current code coverage achieved by kselftests?
> What's covered? What's not? Overall percent/per-subsystem/etc?
> 

No idea.

> 12. I am asking about the aggregate result, because that's usually the
> first thing anybody needs (both devs testing a change and a CI). You
> said that kselftest does not keep track of the aggregate result. So
> the intended usage is always storing all output to a file and then
> grepping it for "[SKIP]" and "[FAIL]". Is it correct?
> 

As I explained, Kselftest will not give you the aggregate result.

thanks,
-- Shuah


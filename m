Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D6B26A59E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Sep 2020 14:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgIOMyR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Sep 2020 08:54:17 -0400
Received: from ozlabs.org ([203.11.71.1]:47259 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgIOMxL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Sep 2020 08:53:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BrNRX3vxHz9sTH;
        Tue, 15 Sep 2020 22:52:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1600174345;
        bh=d/1zO1TaulNZ9TriOX5RFloiXPE2NV9jxfBjB11mp0w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FfFXLMeE2/ukRgHVh1faaE5PJKdoiqxv+CnQForJcVqIfgnCirEobNGOuirFbQArI
         d2NntCSaLCpCM5Bq2xN5x1kCIalVsLtXdKMNwHsT5qmjtyEbfV+Z4b7+aL87r0Ogvz
         lPdMr15Ykp2zmNjFy7Fn+qRhRvEeqP86GZDzRJ/qjT+pl42nsJ0n1K3DQIbU6FJJP9
         7Cat14dfRK7pcReb0Am4FQowrlCURdSk5w1YFGjc4rouv0CRpMsdj18pm867aogkiV
         hqbEVsF3mw0FiANRbWn6629as6qXyzKEFbNtu8PCrAzu5DZzMxiotCuCOV0Hb317oY
         Ebi5ZNT7djt1g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/15] selftests/seccomp: Refactor change_syscall()
In-Reply-To: <202009141321.366935EF52@keescook>
References: <20200912110820.597135-1-keescook@chromium.org> <87wo0wpnah.fsf@mpe.ellerman.id.au> <202009141321.366935EF52@keescook>
Date:   Tue, 15 Sep 2020 22:52:21 +1000
Message-ID: <87een3p5h6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Mon, Sep 14, 2020 at 10:15:18PM +1000, Michael Ellerman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> > Hi,
>> >
>> > This refactors the seccomp selftest macros used in change_syscall(),
>> > in an effort to remove special cases for mips, arm, arm64, and xtensa,
>> > which paves the way for powerpc fixes.
>> >
>> > I'm not entirely done testing, but all-arch build tests and x86_64
>> > selftests pass. I'll be doing arm, arm64, and i386 selftests shortly,
>> > but I currently don't have an easy way to check xtensa, mips, nor
>> > powerpc. Any help there would be appreciated!
>> 
>> The series builds fine for me, and all the tests pass (see below).
>> 
>> Thanks for picking up those changes to deal with powerpc being oddball.
>> 
>> Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>
> Awesome; thanks!
>
> However...
>
>> ./seccomp_bpf
>> TAP version 13
>> 1..86
>> # Starting 86 tests from 7 test cases.
>> #  RUN           global.kcmp ...
>> #            OK  global.kcmp
>> ok 1 global.kcmp
>> [...]
>> #  RUN           global.KILL_thread ...
>> TAP version 13
>> 1..86
>> # Starting 86 tests from 7 test cases.
>
> Was this a mis-paste, or has something very very bad happened here in
> global.KILL_one_arg_six finishes?
>
...
>> TAP version 13
>> 1..86
>> # Starting 86 tests from 7 test cases.
>> [...]
>> # PASSED: 86 / 86 tests passed.
>> # Totals: pass:86 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> And after every user_notification test? O_O

Haha, I thought that was normal :)

It's because of redirection, I run the tests with:

  find . -executable -type f -print -execdir '{}' ';' | tee test.log

If I just run it directly on the terminal everything is normal.

It'll be fork() vs libc buffering.

I can fix it with:

$ stdbuf -oL ./seccomp_bpf | tee test.log

Or the patch below.

I can send a proper patch for that tomorrow, I don't know that harness
code, but I think that's the right fix.

cheers


diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4f78e4805633..b1bd00ff3d94 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -971,6 +971,7 @@ void __run_test(struct __fixture_metadata *f,
 
 	ksft_print_msg(" RUN           %s%s%s.%s ...\n",
 	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+	fflush(stdout);
 	t->pid = fork();
 	if (t->pid < 0) {
 		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1D86B115C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 19:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCHSuK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 13:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCHSt7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 13:49:59 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE13EC1C17
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 10:49:53 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id h8so18552924plf.10
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 10:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678301393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDSGMnsH4iLzycmIWjYuFo4vdBUomtvXvRZ+aBAg2KM=;
        b=FzogeeILd8HnwKeT2ZvFT2CYiOLNldXbC1nJeLKihK+Huxaq+nYiDMwlLcnYK/EEDo
         kf2fTN+UR19AaMmOiyNMrdWHoNjxZbYJZRpVMep1Amx9brsHRlaldlqqkOd0aUQvK/Bi
         WBLM4B7YHznpL3mU3fxdcRh46KOMOtlYXzoxTumMdkHS55+95OpqQFJO5mitOu5hMOjA
         OqWLrRDNqNjAbzaAwo4x9B3ymuqbt0+l1h1F9d8iOuH8UWi6TyquaJJuxgTLMB4gorb3
         qZrN5yi8fEEBhU2L91bYnb4cO2E+MCPDCJJ1R6IlUl5+h4FzBrLehLklDLE4Hk9+lJSn
         8hdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678301393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDSGMnsH4iLzycmIWjYuFo4vdBUomtvXvRZ+aBAg2KM=;
        b=tjXUhVX/cF/ah6C9wBVfih97T2oArpyn9Maqrm282+KlHW+pn1bWWVaEFjXkqXyWd6
         JPHkFNdMlUXqN9XKS3OYpbOmWoMHhKoi2NxZd9KRI6ViKZI7Ken8CxvAziJQL2+TB5ep
         G2WMu3wg65fNMU1KR5uUSmGJoqOCsABlJh6F3ET5R+nFyqI9q1qguHLfbigcyDMM4AKp
         Y1r6CFG4SEAh8s5mi8DwMbqsRv5QdyPmtKdvr2Kg94zK35n5ZtuZaX3PbWC/0tU9tUqQ
         YmRk0u38OZUc4A0NV57u2RluIo+ikCTMEmYls5TlG6YJjD2K31dV2jpQwi3PcRGjZLNB
         Igdg==
X-Gm-Message-State: AO0yUKUcPIYlEQ9rYq1wQRWcMW6RrWBj71XCDD3n6pq5FhT2a4H80ef4
        jDZoyA35YqwaB+bb4PGBGvXMOwfyJvCzZXe1JiKOnw==
X-Google-Smtp-Source: AK7set+nFVT3xiGjx+/Yc43iwIrku80Ndj0a/ne77ymYRpAbVEvBr3ZASV5TY0s6WbACCk+/DGqIYFBDKboF6fgit5I=
X-Received: by 2002:a17:903:280f:b0:19e:f660:81ee with SMTP id
 kp15-20020a170903280f00b0019ef66081eemr1301893plb.2.1678301392881; Wed, 08
 Mar 2023 10:49:52 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsi3OOu7yCsMutpzKDnBMAzJBCPimBp86LhGBa0eCnEpA@mail.gmail.com>
 <50a96bb9-113a-cb06-919c-f544f6b59493@intel.com> <CA+G9fYtDtUbKr-Kf_ZVF0z_xLsP3_2MVsMrvHmvV1UemXbfe3g@mail.gmail.com>
 <CALCETrX56SGHMQFqKT2JWpkhnNDbmtB15-Kam5iYvZz3SD7ixg@mail.gmail.com>
In-Reply-To: <CALCETrX56SGHMQFqKT2JWpkhnNDbmtB15-Kam5iYvZz3SD7ixg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 Mar 2023 10:49:41 -0800
Message-ID: <CAKwvOdnjtqOKDOpnL2nNOjGTvsoojpP--=TLhehjGTc0XckhcA@mail.gmail.com>
Subject: Re: selftests: sigaltstack: sas # exit=1 - # Bail out! SP is not on
 sigaltstack - on clang build
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>, llvm@lists.linux.dev,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-api@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        Stas Sergeev <stsp@list.ru>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 8, 2023 at 8:23=E2=80=AFAM Andy Lutomirski <luto@kernel.org> wr=
ote:
>
> On Tue, Mar 7, 2023 at 7:14=E2=80=AFPM Naresh Kamboju <naresh.kamboju@lin=
aro.org> wrote:
> >
> > + LLVM
>
> The offending code seems to be:
>
> #if __s390x__
>         register unsigned long sp asm("%15");
> #else
>         register unsigned long sp asm("sp");
> #endif
>
>         if (sp < (unsigned long)sstack ||
>                         sp >=3D (unsigned long)sstack + stack_size) {
>                 ksft_exit_fail_msg("SP is not on sigaltstack\n");
>         }
>
> Is that actually expected to work?  asm("sp") is a horrible hack.  I
> would, maybe naively, expect a compiler to analyze this code, think
> "sp is unconditionally uninitialized", and treat the comparison as
> always-UB and thus generate whatever code seems convenient.

Spot-on. -Wuninitialized should warn about that.
https://godbolt.org/z/do9Kqa3cG

Kees mentioned we should be using `current_stack_pointer`. I'll whip
up a patch using that.

>
> --Andy
>
> >
> > On Wed, 8 Mar 2023 at 00:58, Chang S. Bae <chang.seok.bae@intel.com> wr=
ote:
> > >
> > > On 3/6/2023 10:57 PM, Naresh Kamboju wrote:
> > > > kselftest: sigaltstack built with clang-16 getting failed but passe=
d with
> > > > gcc-12 build. Please find more details about test logs on clang-16 =
and
> > > > gcc-12 and steps to reproduce locally on your machine by using tuxr=
un.
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > >
> > > > Test log:
> > > > ----------
> > > >
> > > > Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake) (Debian cla=
ng
> > > > version 16.0.0 (++20230228093516+60692a66ced6-1~exp1~20230228093525=
.41),
> > > > Debian LLD 16.0.0) #1 SMP PREEMPT @1678159722
> > > > ...
> > > > kselftest: Running tests in sigaltstack
> > > > TAP version 13
> > > > 1..1
> > > > # selftests: sigaltstack: sas
> > > > # # [NOTE] the stack size is 21104
> > > > # TAP version 13
> > > > # 1..3
> > > > # ok 1 Initial sigaltstack state was SS_DISABLE
> > > > # Bail out! SP is not on sigaltstack
> > > > # # Planned tests !=3D run tests (3 !=3D 1)
> > > > # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> > > > not ok 1 selftests: sigaltstack: sas # exit=3D1
> > > <snip>
> > >
> > > > Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake)
> > > > (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binut=
ils
> > > > for Debian) 2.40) #1 SMP PREEMPT @1678159736
> > > > ...
> > > > kselftest: Running tests in sigaltstack
> > > > TAP version 13
> > > > 1..1
> > > > # selftests: sigaltstack: sas
> > > > # # [NOTE] the stack size is 50080
> > > > # TAP version 13
> > > > # 1..3
> > > > # ok 1 Initial sigaltstack state was SS_DISABLE
> > > > # # [RUN] signal USR1
> > > > # ok 2 sigaltstack is disabled in sighandler
> > > > # # [RUN] switched to user ctx
> > > > # # [RUN] signal USR2
> > > > # # [OK] Stack preserved
> > > > # ok 3 sigaltstack is still SS_AUTODISARM after signal
> > > > # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> > > > ok 1 selftests: sigaltstack: sas
> > >
> > > At glance, the log shows the altstack size difference between LLVM an=
d GCC.
> > >
> > > But, when I tried with the LLVM that I have,
> > >
> > >      $ clang --version
> > >      clang version 13.0.0 ...
> > >
> > > it failed only with this compiler:
> > >
> > >      $ rm sas;clang -o sas sas.c;./sas
> > >      # [NOTE]        the stack size is 8192
> > >      TAP version 13
> > >      1..3
> > >      ok 1 Initial sigaltstack state was SS_DISABLE
> > >      Bail out! SP is not on sigaltstack
> > >      # Planned tests !=3D run tests (3 !=3D 1)
> > >      # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> > >
> > >      $ rm sas;gcc -o sas sas.c;./sas
> > >      # [NOTE]        the stack size is 8192
> > >      TAP version 13
> > >      1..3
> > >      ok 1 Initial sigaltstack state was SS_DISABLE
> > >      # [RUN] signal USR1
> > >      ok 2 sigaltstack is disabled in sighandler
> > >      # [RUN] switched to user ctx
> > >      # [RUN] signal USR2
> > >      # [OK]  Stack preserved
> > >      ok 3 sigaltstack is still SS_AUTODISARM after signal
> > >      # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> > >
> > > The same is true with some old versions -- e.g. the one that came wit=
h
> > > commit 0c49ad415512 ("tools/testing/selftests/sigaltstack/sas.c: impr=
ove
> > > output of sigaltstack testcase"):
> > >
> > >      $ rm sas;clang -o sas sas.c;./sas
> > >      [OK]    Initial sigaltstack state was SS_DISABLE
> > >      [FAIL]  SP is not on sigaltstack
> > >
> > >      $ rm sas;gcc -o sas sas.c;./sas
> > >      [OK]    Initial sigaltstack state was SS_DISABLE
> > >      [RUN]   signal USR1
> > >      [OK]    sigaltstack is disabled in sighandler
> > >      [RUN]   switched to user ctx
> > >      [RUN]   signal USR2
> > >      [OK]    Stack preserved
> > >      [OK]    sigaltstack is still SS_AUTODISARM after signal
> > >      [OK]    Test passed
> > >
> > > So, this test failure appears to have been there for a while. I think
> > > the LLVM folks need to take a look at it.
> > >
> > > Thanks,
> > > Chang
>


--=20
Thanks,
~Nick Desaulniers

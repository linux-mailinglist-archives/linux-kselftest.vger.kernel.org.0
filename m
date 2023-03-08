Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B64C6B0E89
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 17:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCHQXS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 11:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCHQXQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 11:23:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DF8193CE
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 08:23:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61DBCB81BF0
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 16:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2544AC433B3
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678292591;
        bh=wtbSZIjnuVouf3TNMqbx2fEORr7Wb2sFxFP0LJArqos=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HHMvccU6j87lRjL4E7fcoWtU43PEayhFPDixHhIYkN3HRzmGcR8WQR9+fxolKOQwX
         5CV8zsiRjp0VEXE4Yr/1JYS8DRKHi2dYfQVcNUm6o8SdBinkt+25yecIcPLi7lSktI
         CF997R8QMc4O4MDgOQ7F51vWFcF7sldDLCI85gsoa5jGkk5/6Jkjn69rXuVqrxB3PU
         HZF4CUJHSAU+OFsSvaMtl+6rsMxgia5YHivnasNjttbI8fgv4+FsNSvV5owJdm7Qs5
         kI5UfQ++ndCum/2do06Yiv0j0kBiVmGKWHqaKVGgL28P3H5B+Ftnlta+JgA9l0r7b3
         HHRyaCigHRj9Q==
Received: by mail-ed1-f41.google.com with SMTP id u9so68085686edd.2
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 08:23:11 -0800 (PST)
X-Gm-Message-State: AO0yUKU3QJqonTfkuDKx6qaAAoK2k5GUQp5FnyI6bDpSMkr0ehuP0DOH
        NIKFE4IZp2LB3fNXO57KEha4bmSexFLBln6ZAXp1OQ==
X-Google-Smtp-Source: AK7set8xrdBJlgLKcZJ8Ls9Cykn3HUp+jJMyiUPKHEnnwDi6Pc1f0Gubr89vOkRYF6mpOiNQedaKihAX1ERLrU1kUOo=
X-Received: by 2002:a17:906:b10d:b0:878:561c:6665 with SMTP id
 u13-20020a170906b10d00b00878561c6665mr9467953ejy.0.1678292589161; Wed, 08 Mar
 2023 08:23:09 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsi3OOu7yCsMutpzKDnBMAzJBCPimBp86LhGBa0eCnEpA@mail.gmail.com>
 <50a96bb9-113a-cb06-919c-f544f6b59493@intel.com> <CA+G9fYtDtUbKr-Kf_ZVF0z_xLsP3_2MVsMrvHmvV1UemXbfe3g@mail.gmail.com>
In-Reply-To: <CA+G9fYtDtUbKr-Kf_ZVF0z_xLsP3_2MVsMrvHmvV1UemXbfe3g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 8 Mar 2023 08:22:57 -0800
X-Gmail-Original-Message-ID: <CALCETrX56SGHMQFqKT2JWpkhnNDbmtB15-Kam5iYvZz3SD7ixg@mail.gmail.com>
Message-ID: <CALCETrX56SGHMQFqKT2JWpkhnNDbmtB15-Kam5iYvZz3SD7ixg@mail.gmail.com>
Subject: Re: selftests: sigaltstack: sas # exit=1 - # Bail out! SP is not on
 sigaltstack - on clang build
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>, llvm@lists.linux.dev,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-api@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        Stas Sergeev <stsp@list.ru>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 7, 2023 at 7:14=E2=80=AFPM Naresh Kamboju <naresh.kamboju@linar=
o.org> wrote:
>
> + LLVM

The offending code seems to be:

#if __s390x__
        register unsigned long sp asm("%15");
#else
        register unsigned long sp asm("sp");
#endif

        if (sp < (unsigned long)sstack ||
                        sp >=3D (unsigned long)sstack + stack_size) {
                ksft_exit_fail_msg("SP is not on sigaltstack\n");
        }

Is that actually expected to work?  asm("sp") is a horrible hack.  I
would, maybe naively, expect a compiler to analyze this code, think
"sp is unconditionally uninitialized", and treat the comparison as
always-UB and thus generate whatever code seems convenient.

--Andy

>
> On Wed, 8 Mar 2023 at 00:58, Chang S. Bae <chang.seok.bae@intel.com> wrot=
e:
> >
> > On 3/6/2023 10:57 PM, Naresh Kamboju wrote:
> > > kselftest: sigaltstack built with clang-16 getting failed but passed =
with
> > > gcc-12 build. Please find more details about test logs on clang-16 an=
d
> > > gcc-12 and steps to reproduce locally on your machine by using tuxrun=
.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > Test log:
> > > ----------
> > >
> > > Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake) (Debian clang
> > > version 16.0.0 (++20230228093516+60692a66ced6-1~exp1~20230228093525.4=
1),
> > > Debian LLD 16.0.0) #1 SMP PREEMPT @1678159722
> > > ...
> > > kselftest: Running tests in sigaltstack
> > > TAP version 13
> > > 1..1
> > > # selftests: sigaltstack: sas
> > > # # [NOTE] the stack size is 21104
> > > # TAP version 13
> > > # 1..3
> > > # ok 1 Initial sigaltstack state was SS_DISABLE
> > > # Bail out! SP is not on sigaltstack
> > > # # Planned tests !=3D run tests (3 !=3D 1)
> > > # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> > > not ok 1 selftests: sigaltstack: sas # exit=3D1
> > <snip>
> >
> > > Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake)
> > > (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutil=
s
> > > for Debian) 2.40) #1 SMP PREEMPT @1678159736
> > > ...
> > > kselftest: Running tests in sigaltstack
> > > TAP version 13
> > > 1..1
> > > # selftests: sigaltstack: sas
> > > # # [NOTE] the stack size is 50080
> > > # TAP version 13
> > > # 1..3
> > > # ok 1 Initial sigaltstack state was SS_DISABLE
> > > # # [RUN] signal USR1
> > > # ok 2 sigaltstack is disabled in sighandler
> > > # # [RUN] switched to user ctx
> > > # # [RUN] signal USR2
> > > # # [OK] Stack preserved
> > > # ok 3 sigaltstack is still SS_AUTODISARM after signal
> > > # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> > > ok 1 selftests: sigaltstack: sas
> >
> > At glance, the log shows the altstack size difference between LLVM and =
GCC.
> >
> > But, when I tried with the LLVM that I have,
> >
> >      $ clang --version
> >      clang version 13.0.0 ...
> >
> > it failed only with this compiler:
> >
> >      $ rm sas;clang -o sas sas.c;./sas
> >      # [NOTE]        the stack size is 8192
> >      TAP version 13
> >      1..3
> >      ok 1 Initial sigaltstack state was SS_DISABLE
> >      Bail out! SP is not on sigaltstack
> >      # Planned tests !=3D run tests (3 !=3D 1)
> >      # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> >      $ rm sas;gcc -o sas sas.c;./sas
> >      # [NOTE]        the stack size is 8192
> >      TAP version 13
> >      1..3
> >      ok 1 Initial sigaltstack state was SS_DISABLE
> >      # [RUN] signal USR1
> >      ok 2 sigaltstack is disabled in sighandler
> >      # [RUN] switched to user ctx
> >      # [RUN] signal USR2
> >      # [OK]  Stack preserved
> >      ok 3 sigaltstack is still SS_AUTODISARM after signal
> >      # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > The same is true with some old versions -- e.g. the one that came with
> > commit 0c49ad415512 ("tools/testing/selftests/sigaltstack/sas.c: improv=
e
> > output of sigaltstack testcase"):
> >
> >      $ rm sas;clang -o sas sas.c;./sas
> >      [OK]    Initial sigaltstack state was SS_DISABLE
> >      [FAIL]  SP is not on sigaltstack
> >
> >      $ rm sas;gcc -o sas sas.c;./sas
> >      [OK]    Initial sigaltstack state was SS_DISABLE
> >      [RUN]   signal USR1
> >      [OK]    sigaltstack is disabled in sighandler
> >      [RUN]   switched to user ctx
> >      [RUN]   signal USR2
> >      [OK]    Stack preserved
> >      [OK]    sigaltstack is still SS_AUTODISARM after signal
> >      [OK]    Test passed
> >
> > So, this test failure appears to have been there for a while. I think
> > the LLVM folks need to take a look at it.
> >
> > Thanks,
> > Chang

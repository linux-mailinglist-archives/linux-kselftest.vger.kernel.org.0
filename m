Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600D16AFD48
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 04:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCHDO2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 22:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCHDOZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 22:14:25 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F593E3E
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 19:14:23 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id bx14so10399753uab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 19:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678245262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mVQyhGIjzGLxG0mBx3cK6dRChw0rYjuOJl9Yewk2Iic=;
        b=k2gCpJqtOzFfNKBru2PISKZD5J7z/Yd8lvw5EmCazQhKxv951ImyV7L3NY94ZtyCnT
         XlxiliDpvy4zQPN9gVWADWQP7tDBdwjJuNvCZ2+XAT45zuDKT240p7SrcdphGj1EG/sr
         cHKErcHfCqD7beV+QhGxxEYMMsQv+D06LV22WwO1g1Vx3LNTgZKQP4N7ji8NstSt/Y5p
         bG04eoOSnSHDdBczkNtcs10ldfpxmbt2EQdYgDccH2g/0B1UpADqUEuRKWW/KompCjBt
         icToITfI5eqZpLmpR70MnQ0x3FSUxn181JvMG0/hqFQF0M3oBvV88UonpZOhrybYr/cp
         5ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678245262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVQyhGIjzGLxG0mBx3cK6dRChw0rYjuOJl9Yewk2Iic=;
        b=AaUsgp9GJ1xNm5HcOsSr21M7sz2Defkcxtd42Eb7v1Qt4LwWXR/VGDEvqirGuE1tGe
         S7bE1Fa3GzkArgFgrKs5E4liTUArQVxvtIegxGbBUmz1hWzyUfSOHtLtPaBzyEk1ordE
         xGKP9o9ZhYFbUBA4M/liXmG15xyb06KPFP+fW/P6Am3/LQ87DU5p3iMJtOa1noOAdNCN
         Xz4sqpf+etxaztolMl8TET6DqzkmG4JQHm0WoQQHmyPzG6RsnRo2NMXkd2IMxtF7+HyK
         ekgPNsv2RFIEk2svXivw2vwb25byNUTyjnGmx+3kJaYzSGGnggPwtS+kklns6h2azzIl
         quWw==
X-Gm-Message-State: AO0yUKVLKjhVW1hdJi0RrTGQFpPu3nbSMm7SKnLeAqXa6QA2TThlRGRJ
        KkcTWm2MXg5Tk/tjUZcr1ng3wmi3jrpXGuD+E9Dklw==
X-Google-Smtp-Source: AK7set/0/9etugk4EWZ98upUdsyc4nR6XB+TVtxbVyTOH/Lpo635BbFq4IcB7zz/qJzVU9FvaVcfJAH/EldwKai1paA=
X-Received: by 2002:a9f:3149:0:b0:68b:923a:d6f4 with SMTP id
 n9-20020a9f3149000000b0068b923ad6f4mr10765290uab.2.1678245262385; Tue, 07 Mar
 2023 19:14:22 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsi3OOu7yCsMutpzKDnBMAzJBCPimBp86LhGBa0eCnEpA@mail.gmail.com>
 <50a96bb9-113a-cb06-919c-f544f6b59493@intel.com>
In-Reply-To: <50a96bb9-113a-cb06-919c-f544f6b59493@intel.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Mar 2023 08:44:11 +0530
Message-ID: <CA+G9fYtDtUbKr-Kf_ZVF0z_xLsP3_2MVsMrvHmvV1UemXbfe3g@mail.gmail.com>
Subject: Re: selftests: sigaltstack: sas # exit=1 - # Bail out! SP is not on
 sigaltstack - on clang build
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, llvm@lists.linux.dev
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-api@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        Stas Sergeev <stsp@list.ru>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+ LLVM

On Wed, 8 Mar 2023 at 00:58, Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> On 3/6/2023 10:57 PM, Naresh Kamboju wrote:
> > kselftest: sigaltstack built with clang-16 getting failed but passed with
> > gcc-12 build. Please find more details about test logs on clang-16 and
> > gcc-12 and steps to reproduce locally on your machine by using tuxrun.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Test log:
> > ----------
> >
> > Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake) (Debian clang
> > version 16.0.0 (++20230228093516+60692a66ced6-1~exp1~20230228093525.41),
> > Debian LLD 16.0.0) #1 SMP PREEMPT @1678159722
> > ...
> > kselftest: Running tests in sigaltstack
> > TAP version 13
> > 1..1
> > # selftests: sigaltstack: sas
> > # # [NOTE] the stack size is 21104
> > # TAP version 13
> > # 1..3
> > # ok 1 Initial sigaltstack state was SS_DISABLE
> > # Bail out! SP is not on sigaltstack
> > # # Planned tests != run tests (3 != 1)
> > # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> > not ok 1 selftests: sigaltstack: sas # exit=1
> <snip>
>
> > Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake)
> > (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> > for Debian) 2.40) #1 SMP PREEMPT @1678159736
> > ...
> > kselftest: Running tests in sigaltstack
> > TAP version 13
> > 1..1
> > # selftests: sigaltstack: sas
> > # # [NOTE] the stack size is 50080
> > # TAP version 13
> > # 1..3
> > # ok 1 Initial sigaltstack state was SS_DISABLE
> > # # [RUN] signal USR1
> > # ok 2 sigaltstack is disabled in sighandler
> > # # [RUN] switched to user ctx
> > # # [RUN] signal USR2
> > # # [OK] Stack preserved
> > # ok 3 sigaltstack is still SS_AUTODISARM after signal
> > # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> > ok 1 selftests: sigaltstack: sas
>
> At glance, the log shows the altstack size difference between LLVM and GCC.
>
> But, when I tried with the LLVM that I have,
>
>      $ clang --version
>      clang version 13.0.0 ...
>
> it failed only with this compiler:
>
>      $ rm sas;clang -o sas sas.c;./sas
>      # [NOTE]        the stack size is 8192
>      TAP version 13
>      1..3
>      ok 1 Initial sigaltstack state was SS_DISABLE
>      Bail out! SP is not on sigaltstack
>      # Planned tests != run tests (3 != 1)
>      # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>
>      $ rm sas;gcc -o sas sas.c;./sas
>      # [NOTE]        the stack size is 8192
>      TAP version 13
>      1..3
>      ok 1 Initial sigaltstack state was SS_DISABLE
>      # [RUN] signal USR1
>      ok 2 sigaltstack is disabled in sighandler
>      # [RUN] switched to user ctx
>      # [RUN] signal USR2
>      # [OK]  Stack preserved
>      ok 3 sigaltstack is still SS_AUTODISARM after signal
>      # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> The same is true with some old versions -- e.g. the one that came with
> commit 0c49ad415512 ("tools/testing/selftests/sigaltstack/sas.c: improve
> output of sigaltstack testcase"):
>
>      $ rm sas;clang -o sas sas.c;./sas
>      [OK]    Initial sigaltstack state was SS_DISABLE
>      [FAIL]  SP is not on sigaltstack
>
>      $ rm sas;gcc -o sas sas.c;./sas
>      [OK]    Initial sigaltstack state was SS_DISABLE
>      [RUN]   signal USR1
>      [OK]    sigaltstack is disabled in sighandler
>      [RUN]   switched to user ctx
>      [RUN]   signal USR2
>      [OK]    Stack preserved
>      [OK]    sigaltstack is still SS_AUTODISARM after signal
>      [OK]    Test passed
>
> So, this test failure appears to have been there for a while. I think
> the LLVM folks need to take a look at it.
>
> Thanks,
> Chang

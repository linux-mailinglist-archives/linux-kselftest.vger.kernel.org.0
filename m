Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8A76CCDB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 00:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjC1Wxu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 18:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjC1Wxl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 18:53:41 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F07C2137
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 15:53:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g19so4692696lfr.9
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 15:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680044017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qskuMbf/TQUlVl/XQCSzEK2+S7ntNlCiLvuefA3pamM=;
        b=25yk2ORrLanITla28soBs7miCE+xev3gOhMYTjHwrGodhppl5zmyb5CRsbvTjr70JU
         ZjO+zCf+xQiNqZfKuR24kdK5V7BHB3Ozhqly3ZCk5gzoQziG5phV7SNdx2yXqFRmLp5U
         xSrfT+qhWfUOQmnGNm7lNwu3qPo52oIxL+h+lPjgqhZyuvD3bLjWqqVyTTNwU311KZVs
         y5KgGCVVgnW7N/CBLQay0BwL8p/ZoN7GMg71rJngVtTq5ha1EC2v+ateu0Kmn7g/m2Zt
         MUMcWrip+u5PEbh/eXSeRl/+NO0lDCzY732wMzRFlJD4+79AHGQQbWm7jTXeby5erbho
         Gt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680044017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qskuMbf/TQUlVl/XQCSzEK2+S7ntNlCiLvuefA3pamM=;
        b=6y3LjfqaszDba4uI8de70gpsbXasWI39P0faekk8tQ54ntUu/H9tmqW9PJXPTACeR2
         d8RjkNN7fSCHQN/EeH/DJ5sAgKzdeBwYWuq4lr4UINeo89HO6OkTueXDicXGwVHWNTAm
         CdQrv1diENtdtx1beTtB/k+sHjUxgg/fEARLgkY8LkQ1manK0s31FRZ2ZHwfu35DbAO9
         FJVH2KxBbgaOZ6bCJs6aucTpv2kKfGvUZnMhrFAMivxckVanh1XXbKzhyDer1NpYvtAM
         rUNUk4eAagsR+emWRN93kt5Hzl2KkXxfSA85UvBoSi7P+37Lc3fHl7ckV5/LQs3coLhX
         M8RA==
X-Gm-Message-State: AAQBX9dVOz6jaKibVfadriXl/Og+Q18wEkAuKbBrzhtv4M0IaVcjc9fz
        Jk/cuKfoQhzOvJRXbv9UF95/nCseZxHDr7pLimlVig==
X-Google-Smtp-Source: AKy350Yx95yz3SiP8gB4VeUZ8/yo/xmapgiAWvd2H9O92Pk195cpVNYCvypmY6+6pn/77BmE4p+eUJhYJ8k+JbbEMqM=
X-Received: by 2002:a19:a401:0:b0:4d8:1c0e:bfc7 with SMTP id
 q1-20020a19a401000000b004d81c0ebfc7mr4984994lfc.13.1680044017285; Tue, 28 Mar
 2023 15:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230327163203.2918455-1-evan@rivosinc.com> <8238271.NyiUUSuA9g@diego>
In-Reply-To: <8238271.NyiUUSuA9g@diego>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 28 Mar 2023 15:53:01 -0700
Message-ID: <CALs-Hsu58iOrxKKKu-rQBszz3F--657G-zipBu5zZCxzPWRPWw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] RISC-V Hardware Probing User Interface
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, slewis@rivosinc.com,
        vineetg@rivosinc.com, Conor Dooley <conor@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Jann Horn <jannh@google.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Xu <peterx@redhat.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Shuah Khan <shuah@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 28, 2023 at 1:35=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
>
> Am Montag, 27. M=C3=A4rz 2023, 18:31:57 CEST schrieb Evan Green:
> >
> > There's been a bunch of off-list discussions about this, including at
> > Plumbers.  The original plan was to do something involving providing an
> > ISA string to userspace, but ISA strings just aren't sufficient for a
> > stable ABI any more: in order to parse an ISA string users need the
> > version of the specifications that the string is written to, the versio=
n
> > of each extension (sometimes at a finer granularity than the RISC-V
> > releases/versions encode), and the expected use case for the ISA string
> > (ie, is it a U-mode or M-mode string).  That's a lot of complexity to
> > try and keep ABI compatible and it's probably going to continue to grow=
,
> > as even if there's no more complexity in the specifications we'll have
> > to deal with the various ISA string parsing oddities that end up all
> > over userspace.
> >
> > Instead this patch set takes a very different approach and provides a s=
et
> > of key/value pairs that encode various bits about the system.  The big
> > advantage here is that we can clearly define what these mean so we can
> > ensure ABI stability, but it also allows us to encode information that'=
s
> > unlikely to ever appear in an ISA string (see the misaligned access
> > performance, for example).  The resulting interface looks a lot like
> > what arm64 and x86 do, and will hopefully fit well into something like
> > ACPI in the future.
> >
> > The actual user interface is a syscall, with a vDSO function in front o=
f
> > it. The vDSO function can answer some queries without a syscall at all,
> > and falls back to the syscall for cases it doesn't have answers to.
> > Currently we prepopulate it with an array of answers for all keys and
> > a CPU set of "all CPUs". This can be adjusted as necessary to provide
> > fast answers to the most common queries.
> >
> > An example series in glibc exposing this syscall and using it in an
> > ifunc selector for memcpy can be found at [1]. I'm about to send a v2
> > of that series out that incorporates the vDSO function.
> >
> > I was asked about the performance delta between this and something like
> > sysfs. I created a small test program [2] and ran it on a Nezha D1
> > Allwinner board. Doing each operation 100000 times and dividing, these
> > operations take the following amount of time:
> >  - open()+read()+close() of /sys/kernel/cpu_byteorder: 3.8us
> >  - access("/sys/kernel/cpu_byteorder", R_OK): 1.3us
> >  - riscv_hwprobe() vDSO and syscall: .0094us
> >  - riscv_hwprobe() vDSO with no syscall: 0.0091us
>
> Looks like this series spawned a thread on one of the riscv-lists [0].
>
> As auxvals were mentioned in that thread, I was wondering what's the
> difference between doing a new syscall vs. putting the keys + values as
> architecture auxvec elements [1] ?

The auxvec approach would also work. The primary difference is that
auxvec bits are actively copied into every new process, forever. If
you predict a slow pace of new bits coming in, the auxvec approach
probably makes more sense. This series was born out of a prediction
that this set of "stuff" was going to be larger than traditional
x86/ARM architectures, fiddly (ie bits possibly representing specific
versions of various extensions), evolving regularly over time, and
heterogeneous between cores. With that sort of rubber band ball in
mind, a key/value interface seemed to make more sense.

-Evan

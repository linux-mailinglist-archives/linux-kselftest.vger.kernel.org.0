Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500451C5A07
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 May 2020 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgEEOug (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 10:50:36 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42959 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgEEOuf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 10:50:35 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MfZDK-1iuhCk00VM-00fxiN; Tue, 05 May 2020 16:50:34 +0200
Received: by mail-qk1-f172.google.com with SMTP id i14so2481696qka.10;
        Tue, 05 May 2020 07:50:33 -0700 (PDT)
X-Gm-Message-State: AGi0PuYMK1Z5O7Lw3eOlNezFBug99HhG7qCIsvsG+rcLi3zrpBdCxkVl
        vhsx8+AdyKCS6gV/qVrWzc37WbVf9uKLCjaoEcw=
X-Google-Smtp-Source: APiQypJLyiXCJC5P9f6z2L3iZlBe5oRvFHw9Gwp3hVkojbjzPuoDSdiHrFCZeHWjvZ6SiDNDEMJvgXleWYPp8TYCh3o=
X-Received: by 2002:a37:a492:: with SMTP id n140mr4053709qke.352.1588690232807;
 Tue, 05 May 2020 07:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200429112834.24908-1-vincenzo.frascino@arm.com>
In-Reply-To: <20200429112834.24908-1-vincenzo.frascino@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 May 2020 16:50:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3u05wF1DT3Wnvmapc0jixu+gp_YG=KTEN9-n4JedJ9BA@mail.gmail.com>
Message-ID: <CAK8P3a3u05wF1DT3Wnvmapc0jixu+gp_YG=KTEN9-n4JedJ9BA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kselftest: Extend vDSO tests
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:c+CoYMx96cdZ0BvJpcEUhP+izzQf2qvPczyfYmJz90MuGAgBsFT
 jMfPdM/yEXK6SbuaMAXipzXZXbg9jzWgLtqb5cq23xc3G1qDCAC26tG0i2ms1ynjdaL16yT
 Gsy3YA72u/etcYVllRjoALQnvRwURDjVhGfE67JxB/QZcVhj07nZcU2MXvmkPQTReeeO175
 bgz31FynO1mfcYliXp3LQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m1zBxUvWGYA=:iKJeMF58+W+tPtenU7nQfr
 RShj67StJ+z1sMcqv1ktsa3z+JilpsJM9Cmm8mE2Tn8Uup0xQT1jMEMvuNFiEqb1IADFMtgJX
 6vBe5SphWkLYD89hf22tEyLsVMV8QiW199qDf0zXdNb8mEzk/LJV2bXToEJC29HHanaW9RCsO
 Tp6yUnzfnatsPIU3i/5iYceQvbksnY6nV76aIiobxrxd3nEa6183uGyRDid7zP8ohO+JRXwK4
 6aAhL7W16tux6BZtG2e3et6eSXFnHdEg60M1euyTqF0MFsFbUNJR6WSdMuVTWbipZNVQPm76n
 4heHXtPoRrY2hLDnRJ2yv9ibzZIGYDEMCMTfKDCQBQgpBwOdyg5gMhYB1bKpFQhyebKI616nC
 F2HziDjqUQHVcsfIUVxIdo5qYcD/mG18NEwz53hGZJ4LniYkuU2Eeq4wp3AbV721uClxpaPws
 BtBrPKgdlflUZ5DGak/Awm+vnlRYlcHeiEFaAKfQ3uSWpFPuqDU/c7VzSYrvjFe3vCGHQFNyH
 MYwuOi0o+Mv8d//S22gxKA8v6DMiqm5pdnCvXC7WpmuARhyKB8c5CmGhNM61QZAfx6JIxTVeE
 dTO8A8k1/3XWj+5LjpnCyBVyVCgY7ZMCPrXE/XLFc0mToIitWZPARCvP0Qc7oCFtZqc8lj2G3
 YNrNDdW+scRp0Tcz/Ios5W5TRMi71A/2C4DnGgfpZcr/AcQkpRiwnnv6+emDYOva6NNCenY2Y
 pbgfMw9ejR7aB4oRQs1PqFtpIL8I8YmnDmXSv8/zeaFADRgaNzVv82oo7McYT6h/HT67Ah23v
 WAS8xXMlSiKzdKKwvyGZUJiRVaxewl0/VsZtQ0XOZ7q3b7dRzA=
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 29, 2020 at 1:34 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> This series extends the kselftests for the vDSO library making sure: that
> they compile correctly on non x86 platforms, that they can be cross
> compiled and introducing new tests that verify the correctness of the
> library.
>
> The so extended vDSO kselftests have been verified on all the platforms
> supported by the unified vDSO library [1].
>
> The only new patch that this series introduces is the first one, patch 2 and
> patch 3 have already been reviewed in past as part of other series [2] [3].
>
> [1] https://lore.kernel.org/lkml/20190621095252.32307-1-vincenzo.frascino@arm.com
> [2] https://lore.kernel.org/lkml/20190621095252.32307-26-vincenzo.frascino@arm.com
> [3] https://lore.kernel.org/lkml/20190523112116.19233-4-vincenzo.frascino@arm.com

Hi Vincenzo,

Not sure if you are aware of the recent bug report about clock_gettime64()
returning invalid times on some arm32 kernels:
https://github.com/raspberrypi/linux/issues/3579

Regardless of when that gets fixed or by whom, I wonder if kselftest should
also check for consistency, i.e. call both the vdso and the syscall version of
clock_gettime() and clock_gettime64() and check that the results are always
in sequence.

      Arnd

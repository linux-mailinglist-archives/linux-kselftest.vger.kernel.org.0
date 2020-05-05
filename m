Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148551C5A77
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 May 2020 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgEEPHY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 11:07:24 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:49793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbgEEPHX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 11:07:23 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N6szR-1j4lAU3Azf-018O05; Tue, 05 May 2020 17:07:21 +0200
Received: by mail-qt1-f173.google.com with SMTP id j2so1883827qtr.12;
        Tue, 05 May 2020 08:07:21 -0700 (PDT)
X-Gm-Message-State: AGi0PuYl+XiCsMai1Wt6Y16ptyuWwO4Ef2Pk+ryP4WQSa/U2G2LQf15Z
        2P5P8Kx6+WB3f5NHh3uMqk4CyyGxeIkOJh7CKSA=
X-Google-Smtp-Source: APiQypKcGtXxNTCMFsjCMlSjTXwSNyujie+geckspvsAjtzqoB03b+z86E4R0tb/FvJb7FlBkJbbNky8CoOQCI61wg8=
X-Received: by 2002:ac8:6757:: with SMTP id n23mr3062685qtp.304.1588691240560;
 Tue, 05 May 2020 08:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200429112834.24908-1-vincenzo.frascino@arm.com>
 <CAK8P3a3u05wF1DT3Wnvmapc0jixu+gp_YG=KTEN9-n4JedJ9BA@mail.gmail.com> <b9b313b5-697e-b92e-1aca-7ad07a640a03@arm.com>
In-Reply-To: <b9b313b5-697e-b92e-1aca-7ad07a640a03@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 May 2020 17:07:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0hUG3-21=HCrxxjQSxFJsDBu704NQCiOW6jNpZV5Ns8w@mail.gmail.com>
Message-ID: <CAK8P3a0hUG3-21=HCrxxjQSxFJsDBu704NQCiOW6jNpZV5Ns8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kselftest: Extend vDSO tests
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5UApId0RZn/WJGeGExoIPUxHrVpBOgjUWKaPG1SKSBUdoO38fBv
 ZnxBcmygrFm1m9rmQW5JTULBNviOwpVL2xy8BhlUon8utxlL4zmrcrHzed8mVn5RgCeGDLk
 +7jzBZbG8HurHxS5MIBZiH24ADB0ECQmQo4Ap+RNHtb7p5+zZp1ezU52+6FPx8EOcNZcUkb
 13oVwXf+g1mmo93DiixPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u1ednoR6qPA=:QoHf5FWzpzAOiFyi5wb7UP
 QUwLIAbt25ll0vgoBMFiek+diDMYWadD/aDZ8j++NOxGdCezhWoWp8m4HO4rpIFCRYJHBOlRX
 467i+b3bpqZc7di5DdHVKLqxCG3NsIbhq57LIMbENXB5YwKIBt80sULxUouIY3U2s/wYxFb9U
 1kDecHQ/XlqrTvAA6Zk1A38abeUKny2vAsbJayltbAOJPqFUp4Vd1+Iw0Tqo0EyXDpFye4hv4
 vf+HTxJH7ZXmHgvSb+WJR7g3GOVhs7tn9czRAcDdKCLFQMUFePKHKswz/o5Kr4EKzYFerju0g
 PIhIDy8DBBRmuCAbgN4p1VrUKnuZi1fqAZtcXwTPg//kmLTOYhfgLmzzU9Uz7txgEScRHzD8T
 59QXTjDg6I5rciV6dZH5iOewANJFrjjRDvj0bpQJ8ZlUa5JLPhkUD5ILDIFLAbCmHC2s24Def
 iuRG0XO3xhsLhI3/Co0nzD7FPtm9tZ7bDJv5OBjrcQrdAKVePuEk/91DWzQgQ91Z4+PwuylQJ
 1Y1YdZUc0MWC/uO0OJ0+WXxLliu6AbqnGT+F/3IKrH0WiEh7UsUBnMDRe5HBWLZQf4LKYBlLE
 bfNsPkcNg0KfwTxDyoPZoeyWlG6LxZBrJXVkqJ+rbp08iNqpwsEkg46G4SqCktc1qf9pRqRFe
 hguf66gQbJ8jTuX21MezS5YBYv67zfAMfzYsKhoSxZWr8kE4RGTw59gD7XmyrfeLmeMRXOdSt
 VLk6FxhCQdw4esAYumm3ZPZVZQO3mz927U1FlWdJstP97RFXhGKlPzWEC9zN9VLFTu/kIxmXE
 rzvGpVJ0FOuUl1R9uLqCUml6bdu91L6XjYrRAEBinL1QdABF5g=
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 5, 2020 at 5:03 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> On 5/5/20 3:50 PM, Arnd Bergmann wrote:
> > On Wed, Apr 29, 2020 at 1:34 PM Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> >
> > Not sure if you are aware of the recent bug report about clock_gettime64()
> > returning invalid times on some arm32 kernels:
> > https://github.com/raspberrypi/linux/issues/3579
> >
>
> No, I was not aware of the problem. There has been no mention on the arm list
> (unless I missed it). I can try to have a look at it as soon as I get some time.

Right, it was on only on the musl list, and I had pinged you on IRC, but you
must have been offline.

> > Regardless of when that gets fixed or by whom, I wonder if kselftest should
> > also check for consistency, i.e. call both the vdso and the syscall version of
> > clock_gettime() and clock_gettime64() and check that the results are always
> > in sequence.
> >
>
> The test #4 partially does that: it calls syscall-vdso-syscall and verifies that
> the sequencing is correct. I reused the x86 code for that. I could extend it to
> clock_gettime64() and make sure it builds on all the platforms.

Sounds good to me.

       Arnd

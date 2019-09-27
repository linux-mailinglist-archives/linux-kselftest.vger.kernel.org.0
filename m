Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D114C0CF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 22:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbfI0U60 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 16:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI0U6Y (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 16:58:24 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9270F21920
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2019 20:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569617903;
        bh=JHvPXPKOI8xXY+v+RmsysJ+7eQJL2fGTE9qEG3GltO4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IZBobdmnLixGOMe0GgALjKFamRkN+1/IlDJ93Mesp167haHYR7IBTWvK6yM1HL85P
         fgn5Hvfd5gJ9LHq/raH1oyc+JNVnN55DE5TJ7vnvYOudEB+EMU2l92r1xncFRaMHhV
         RqDQ8KOcKcKYu9CMwqEVaB0ZppLtJi/hqoWYNb3U=
Received: by mail-wr1-f48.google.com with SMTP id l3so4635794wru.7
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2019 13:58:23 -0700 (PDT)
X-Gm-Message-State: APjAAAUuT78g9UYSQmNCQhE2d/6CNdnblxSVvgUdduJjkxm1GvFiDFE/
        zRbjceYs+5Ao077MJl4cvv0EUQCNArez8wSZSbbdQw==
X-Google-Smtp-Source: APXvYqxmWFPXVg5my2vdtfXTIKkRAsW/tJXeLCeFEGi5LTezBydsLm94jzUi9r5S9tnwrfzAbRz3QhWaRfS3fvEnT+I=
X-Received: by 2002:adf:dbc6:: with SMTP id e6mr4312618wrj.149.1569617900104;
 Fri, 27 Sep 2019 13:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <419CB0D1-E51C-49D5-9745-7771C863462F@amacapital.net> <mhng-c8a768f7-1a90-4228-b654-be9e879c92ec@palmer-si-x1c4>
In-Reply-To: <mhng-c8a768f7-1a90-4228-b654-be9e879c92ec@palmer-si-x1c4>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 27 Sep 2019 13:58:08 -0700
X-Gmail-Original-Message-ID: <CALCETrUmqKz4vu2VCPC5MYGFyiG4djbOmKG32oLtQPb=o6rJ_Q@mail.gmail.com>
Message-ID: <CALCETrUmqKz4vu2VCPC5MYGFyiG4djbOmKG32oLtQPb=o6rJ_Q@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: add support for SECCOMP and SECCOMP_FILTER
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Kees Cook <keescook@chromium.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincentc@andestech.com>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, me@carlosedp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 3, 2019 at 3:27 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 28 Aug 2019 10:52:05 PDT (-0700), luto@amacapital.net wrote:
> >
> >
> >> On Aug 25, 2019, at 2:59 PM, Kees Cook <keescook@chromium.org> wrote:
> >>
> >>> On Thu, Aug 22, 2019 at 01:55:22PM -0700, David Abdurachmanov wrote:
> >>> This patch was extensively tested on Fedora/RISCV (applied by default=
 on
> >>> top of 5.2-rc7 kernel for <2 months). The patch was also tested with =
5.3-rc
> >>> on QEMU and SiFive Unleashed board.
> >>
> >> Oops, I see the mention of QEMU here. Where's the best place to find
> >> instructions on creating a qemu riscv image/environment?
> >
> > I don=E2=80=99t suppose one of you riscv folks would like to contribute=
 riscv support to virtme?  virtme-run =E2=80=94arch=3Driscv would be quite =
nice, and the total patch should be just a couple lines.  Unfortunately, it=
 helps a lot to understand the subtleties of booting the architecture to wr=
ite those couple lines :)
>
> What mailing list should I sent this to?  You need to use the "virtme" br=
anch
> of kernel.org/palmer/linux.git until I send the defconfig patches.
>
> commit a8bd7b318691891991caea298f9a5ed0f815c322
> gpg: Signature made Tue 03 Sep 2019 03:22:45 PM PDT
> gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB4=
1
> gpg:                issuer "palmer@dabbelt.com"
> gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
> gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
> Author: Palmer Dabbelt <palmer@sifive.com>
> Date:   Tue Sep 3 14:39:39 2019 -0700
>
>     Add RISC-V support

Could you rebase onto virtme master and resend in some format that
isn't corrupt?  git am really doesn't like your patch and, even if I
fix it up manually, your gpg: lines are bogus.  You could also send a
PR at https://github.com/amluto/virtme

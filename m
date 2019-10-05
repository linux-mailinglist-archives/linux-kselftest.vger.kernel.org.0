Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92287CC731
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2019 03:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfJEBYL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Oct 2019 21:24:11 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38692 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJEBYL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Oct 2019 21:24:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id m16so7326299oic.5
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Oct 2019 18:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Gr3vPHhUUWGmUVhCZ83FOVrxuAp5M1FSUXsxEnqOUVw=;
        b=aNlQ5uVh9JxZHsH9PosFCQkAXOZbUVmDp4sYNIiyQWF7usjj7tYRWSXGvGeb+TKmQx
         /PKYmS1XWZi9z89cLQ8sCIOSbR9FlH6ncaopWkD+hcrjvRWSclilETaXt24XtrsjiYTW
         FcDmxdTcT38ukq9MY0VdtfU84Hpxq5kPDmMmxPxIUYlpICCR1J71ZFp8FcxLdMTuQ4O+
         0PciPfJdQ8/SgJA0QMK8CeGeuaSM+1WVBGkDGgs2dijunkUXtplNyQ7tYe0MLNEryPel
         sN28J2s2rF3qk1Js6Fl2vJo3uz3N3ajPuVP0SYKhSHp2NGk0frPPaNviNK6+V2Af1CQg
         AHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Gr3vPHhUUWGmUVhCZ83FOVrxuAp5M1FSUXsxEnqOUVw=;
        b=JiZ8BQhcv+OLscB7iaJJ6jC01FynOqkrVu1HJ7WtljJdkyT/eZ6nocoQ0WcediCIRg
         djyTbDhH0NQccWilLdI5ChRGSE35Lup8Nzz25F1z0C9oEgppIK0dxB8LzRzW45dKqAga
         wFTO7hy/vuyVNtPuOjDs22rbF5s52jqc0hzmNPLFef187yTR7UH7vQ9Cml3Uoq2FxgLn
         LhrQjDTYDXtyovjDHqkIAlfvCOQmV8v/hztpdBGRWMC9uMA1UBc38T6M/YTfQqxCL5UX
         yyWBiwI/boJ9Cz/LRXEa+bDyrrwKV1p0euzosctn7qBdWlDrkx9dpMkCrCBEKhW7zxL7
         1BAQ==
X-Gm-Message-State: APjAAAWv28QLYiucIHeqI9LAphA/86u9oi9Hnv6d0SGLiG0Pvrhv00B5
        BL0jchWTSwtft8XaOTeGsITGog==
X-Google-Smtp-Source: APXvYqzgkJxuaT0woltjn4JGZ5HsgdZmLxkxcI/oHlVqnvxI9eGlw+q4m2LXamIq0+QDajNCtfMU3A==
X-Received: by 2002:aca:d07:: with SMTP id 7mr9442211oin.155.1570238649063;
        Fri, 04 Oct 2019 18:24:09 -0700 (PDT)
Received: from localhost ([2600:100e:b029:4ada:34fb:aeb7:d598:e51c])
        by smtp.gmail.com with ESMTPSA id a9sm2260524otc.75.2019.10.04.18.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 18:24:08 -0700 (PDT)
Date:   Fri, 4 Oct 2019 18:24:07 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Kees Cook <keescook@chromium.org>
cc:     Tycho Andersen <tycho@tycho.ws>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
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
Subject: Re: [PATCH v2] riscv: add support for SECCOMP and SECCOMP_FILTER
In-Reply-To: <CAJr-aD=UnCN9E_mdVJ2H5nt=6juRSWikZnA5HxDLQxXLbsRz-w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1910041820560.15827@viisi.sifive.com>
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com> <alpine.DEB.2.21.9999.1908231717550.25649@viisi.sifive.com> <20190826145756.GB4664@cisco> <CAEn-LTrtn01=fp6taBBG_QkfBtgiJyt6oUjZJOi6VN8OeXp6=g@mail.gmail.com> <201908261043.08510F5E66@keescook>
 <alpine.DEB.2.21.9999.1908281825240.13811@viisi.sifive.com> <CAJr-aD=UnCN9E_mdVJ2H5nt=6juRSWikZnA5HxDLQxXLbsRz-w@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 27 Sep 2019, Kees Cook wrote:

> On Wed, Aug 28, 2019 at 6:30 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > On Mon, 26 Aug 2019, Kees Cook wrote:
> >
> > > On Mon, Aug 26, 2019 at 09:39:50AM -0700, David Abdurachmanov wrote:
> > > > I don't have the a build with SECCOMP for the board right now, so it
> > > > will have to wait. I just finished a new kernel (almost rc6) for Fedora,
> > >
> > > FWIW, I don't think this should block landing the code: all the tests
> > > fail without seccomp support. ;) So this patch is an improvement!
> >
> > Am sympathetic to this -- we did it with the hugetlb patches for RISC-V --
> > but it would be good to understand a little bit more about why the test
> > fails before we merge it.
> 
> The test is almost certainly failing due to the environmental
> requirements (i.e. namespaces, user ids, etc). There are some corner
> cases in there that we've had to fix in the past. If the other tests
> are passing, then I would expect all the seccomp internals are fine --
> it's just the case being weird. It's just a matter of figuring out
> what state the test environment is in so we can cover that corner case
> too.
> 
> > Once we merge the patch, it will probably reduce the motivation for others
> > to either understand and fix the underlying problem with the RISC-V code
> > -- or, if it truly is a flaky test, to drop (or fix) the test in the
> > seccomp_bpf kselftests.
> 
> Sure, I get that point -- but I don't want to block seccomp landing
> for riscv for that. I suggested to David offlist that the test could
> just be marked with a FIXME XFAIL on riscv and once someone's in a
> better position to reproduce it we can fix it. (I think the test bug
> is almost certainly not riscv specific, but just some missing
> requirement that we aren't handling correctly.)

OK.  It might be nice to mark the seccomp_bpf.c test as flaky in the 
comments for the test.

> How does that sound?

Let's follow your plan.  Thanks for your review and feedback.


- Paul

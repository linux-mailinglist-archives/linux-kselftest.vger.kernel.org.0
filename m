Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C649610D04
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 21:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfEATHM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 15:07:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33383 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfEATHM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 15:07:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so26717ljc.0
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2019 12:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sel235hwbH6X1YvFcp9cC7JRXnS2M4BkT9uwVxDW2CQ=;
        b=hKJ92qX+WBtDkwAkIRCoWA4GuXtRFgmwNS/x4HHoRL1Cph8V9Ovoot3NqLu+fqUiqM
         Qth2QafTxUxf+Pm3vpTn95XuskqJEgEpvVEeBMW2fZtoLYrabbeAmSNI1KU3JXjTPrP/
         nm6QVbnOD2fawZyDG5MwCG7W040aS+7zbGhdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sel235hwbH6X1YvFcp9cC7JRXnS2M4BkT9uwVxDW2CQ=;
        b=bLn6nBoNOUf4KLy7o2nvkYTqEPgomgKlOkZkpx003CLqpL12VlAC2zrqY+rnsDo4X1
         9d+U1aksq0o3g6y1nXz0g61XZZlwECEEvrusPu9sCTsX/sR0Ob/IKbUMRbaQH1OG8Id2
         OXi/0bMFvTe97edWqNODvtUo2mRT6kelxg0abdQePBOGZsKUvqiftwIg9vRkxXOgsO1g
         gWSDKkmPif9eyv1F5mZJV8XMQHwVvAUZ4VacYysjFIj55yq8rTADlk5zr31RekGhbcD8
         3EwTZeQD7ba6yv/4swN1bUqVnOVdbZ8fT+cUndwizo/vdoQxHGXllcSPCPA1u72Vec/J
         +9FA==
X-Gm-Message-State: APjAAAWNxw0wU64hZsCFzSwthdmhwoouikv0vEcAuhZAQxkSe+3/HX8N
        L8GEZjGxGlmiFgGG9c8aPgXT+3ZlhLU=
X-Google-Smtp-Source: APXvYqwqNYmZPPpIzJRFWeYEaNyxKMd2NUMkrcqANsQ093jp/HBe2AJ3w2VUc7mA+BDb89nDWjWB7g==
X-Received: by 2002:a2e:8e93:: with SMTP id z19mr20550788ljk.159.1556737629742;
        Wed, 01 May 2019 12:07:09 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id j9sm8470706lja.92.2019.05.01.12.07.09
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:07:09 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id r30so77092lfn.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2019 12:07:09 -0700 (PDT)
X-Received: by 2002:ac2:547a:: with SMTP id e26mr18577958lfn.148.1556737161870;
 Wed, 01 May 2019 11:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190501113238.0ab3f9dd@gandalf.local.home> <CAHk-=wjvQxY4DvPrJ6haPgAa6b906h=MwZXO6G8OtiTGe=N7_w@mail.gmail.com>
 <20190501145200.6c095d7f@oasis.local.home>
In-Reply-To: <20190501145200.6c095d7f@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 May 2019 11:59:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMZJeMCW5MA25WFJZeYYWCOWr0nGaHhJ7kg+zsu5FY_A@mail.gmail.com>
Message-ID: <CAHk-=wgMZJeMCW5MA25WFJZeYYWCOWr0nGaHhJ7kg+zsu5FY_A@mail.gmail.com>
Subject: Re: [RFC][PATCH v3] ftrace/x86_64: Emulate call function while
 updating in breakpoint handler
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 1, 2019 at 11:52 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I got Peter's patch working. Here it is. What do you think?

I can tell from just looking at it for five seconds that at least the
32-bit case is buggy.

You can't look at CS(%rsp) without first also checking that you're not
coming from vm86 mode.

But other than that I guess it does end up being pretty simple.

             Linus

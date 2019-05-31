Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C73100C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2019 16:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfEaOWB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 May 2019 10:22:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40025 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfEaOWA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 May 2019 10:22:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so6306736pfn.7
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2019 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqGZhr1OXDcqw01dRW7YMwNNKArDZmNdR/78N+BPrn4=;
        b=ZKOkIMzc1OQGbUNPHq03h99fyCedWbnebo6E2bMji4A+DRTaVEdXjsJpjrPcnu5SSA
         zIZPDWUgCW5bi+5Hm5xJN08EHp1zrtJRB8hJr+lkARmCPVryFs490LA/D4jT6SugJib6
         WuyNVM4Q2N7HAjjpa7DOBEdYU4LyBiJDJK5zMqDY/W6JkYNX16roPrVOH81h+nxoiBDb
         7B2l5NwJlc5O9XzC5yHflmTOv3KCBSLqmkKFOBx9Ekz6rnZxWiAE8V0PArN5B+OlAW0s
         TvC0lLDPHMJfSpKtEQaVcV+QmrjEmlTv3Oh20DkNgRQ4hUDHUKfXsDqAzpdAzgsjCOV+
         IttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqGZhr1OXDcqw01dRW7YMwNNKArDZmNdR/78N+BPrn4=;
        b=L237EEnitp7dOqyrnqY+YbhKQcbw1zOJP352y7G5Z6Yq66tEPRU6dkE8VTmrEzfdlv
         d+iriU1lTuS2OL01q8sHlp8Qa2zlxCiOwFvMGfrNAlcG1hsZgkbfQAsPvHpg5z3+Wwuq
         jsJaOIZTGhD7+PoIGZdWxG3McGf6rUXRIyY/Kx8fJl/FbksqfEuJkEk4BTn0qR+WK4ie
         pD5D0/PhpkWC/aXjVCXZq8xzKipbHQHMbel2s24IW3cUNfLnJ25oxXOf1P+ZxG5jleLR
         MjTcTMWqRNXco5VlUXxttBQCvFkwAupNA832KH8V0PIFuDclFNG9aE9a0OUnq5ZUXm1i
         MrLw==
X-Gm-Message-State: APjAAAUVbUJRZLny579Zs29ku53RSjUYKE4Nzn8vxbZo/3Cyps5uvssU
        wxde9LCU7gbLVROcWoXGSROHzXRyuqSfcC7ZVlCzUg==
X-Google-Smtp-Source: APXvYqyJDYvC63I4W5Lhta3XMIDWbZrlVf994VbGlX5pPuRIANXUx7mxbvFt5+YOh/Wqr0oXVm0H7EASqzCT8eMwsG4=
X-Received: by 2002:a65:64d9:: with SMTP id t25mr9532741pgv.130.1559312519598;
 Fri, 31 May 2019 07:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com> <e31d9364eb0c2eba8ce246a558422e811d82d21b.1557160186.git.andreyknvl@google.com>
 <20190522141612.GA28122@arrakis.emea.arm.com>
In-Reply-To: <20190522141612.GA28122@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 31 May 2019 16:21:48 +0200
Message-ID: <CAAeHK+wUerHQOV2PuaTwTxcCucZHZodLwg48228SB+ymxEqT2A@mail.gmail.com>
Subject: Re: [PATCH v15 17/17] selftests, arm64: add a selftest for passing
 tagged pointers to kernel
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 22, 2019 at 4:16 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, May 06, 2019 at 06:31:03PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > This patch adds a simple test, that calls the uname syscall with a
> > tagged user pointer as an argument. Without the kernel accepting tagged
> > user pointers the test fails with EFAULT.
>
> That's probably sufficient for a simple example. Something we could add
> to Documentation maybe is a small library that can be LD_PRELOAD'ed so
> that you can run a lot more tests like LTP.

Should I add this into this series, or should this go into Vincenzo's patchset?

>
> We could add this to selftests but I think it's too glibc specific.
>
> --------------------8<------------------------------------
> #include <stdlib.h>
>
> #define TAG_SHIFT       (56)
> #define TAG_MASK        (0xffUL << TAG_SHIFT)
>
> void *__libc_malloc(size_t size);
> void __libc_free(void *ptr);
> void *__libc_realloc(void *ptr, size_t size);
> void *__libc_calloc(size_t nmemb, size_t size);
>
> static void *tag_ptr(void *ptr)
> {
>         unsigned long tag = rand() & 0xff;
>         if (!ptr)
>                 return ptr;
>         return (void *)((unsigned long)ptr | (tag << TAG_SHIFT));
> }
>
> static void *untag_ptr(void *ptr)
> {
>         return (void *)((unsigned long)ptr & ~TAG_MASK);
> }
>
> void *malloc(size_t size)
> {
>         return tag_ptr(__libc_malloc(size));
> }
>
> void free(void *ptr)
> {
>         __libc_free(untag_ptr(ptr));
> }
>
> void *realloc(void *ptr, size_t size)
> {
>         return tag_ptr(__libc_realloc(untag_ptr(ptr), size));
> }
>
> void *calloc(size_t nmemb, size_t size)
> {
>         return tag_ptr(__libc_calloc(nmemb, size));
> }

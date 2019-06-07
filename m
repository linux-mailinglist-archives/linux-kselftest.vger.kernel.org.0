Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819D0383C2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2019 07:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfFGFdu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jun 2019 01:33:50 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37197 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfFGFdu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jun 2019 01:33:50 -0400
Received: by mail-it1-f193.google.com with SMTP id x22so952843itl.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Jun 2019 22:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1Ohgac363EioDxzXpyXf7UN1ZgVyShBjggu94kceQ8=;
        b=k/GR7joJNJJ6Ve9R/aFsDJRsptZAid18wqkAKiXzRB6NlE5r0KsuMRDWBQiDjQE71p
         daD8j4DSrVfI6HVAkD5vCpZj39PQaq9fApbZACjRC0RDDKZIBpn7/PLmAhGU1uSNjV36
         ZPpnk1tioX9M+1EYWJoeTvWylBd+vbf5sKkC6jEafyQKFEFkOanMnEF7whEz4Nqwt4hG
         bE4l9bBTG0ogocOQzuioUmmPSF5w+Ho92/o1cceuVe444tHP69yQxu8DSewMXHLCqg4l
         Ja6TZAP9vQDDI+y+jUJx9i8y337VPVjbLYX5aoIkmB6O4W9ByhkvQ0wvmaFU4t1VIu/d
         h8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1Ohgac363EioDxzXpyXf7UN1ZgVyShBjggu94kceQ8=;
        b=NyoTstelOKV9KGboJjCAVAO7K+GZa/VeDqQX0yoOKI7LOAcuYIHH1y4EreUrqmSHyR
         jcojhWUy49MBCV7je2JA2LixShC4XVznPZViqSoor4DN4lqKZMKKiCWRS4bCH4xheUPP
         LUQSl3pmYA14YbN2CFKE2bUSHf8u1ow8TxHFp+oxpeTslB0XToKvRetB4C9SKjVpfeZF
         iTswIsAjEuqssaaQsRqWShhSTGYK4jJS7siz/MJ/G+QWWD1gJl6U6vQtsjk4ji6J+5gc
         cY7LRRhHhFJ9GIXAsY1lX1kkAs0gYiAZcyUBKnTL8s1Xm6If9+oN7pEZ4+bqsM6dNXtQ
         NCVg==
X-Gm-Message-State: APjAAAUKEApL2qbB5OZ9RH+bqWPijBOrvVGzErFl8lLrG9E09IspIeXR
        69kC2VSZoJt+ulKICapm0A8t1FIuKaexoLPNqtBT7A==
X-Google-Smtp-Source: APXvYqzO76FNbL4lc2mT5nAI8664+vPAEC2qxggUSScGxp/b2eT89TkEwyH+hzeEqr8qRCV6LZQ9VkHcX6jY2/9nElY=
X-Received: by 2002:a05:660c:752:: with SMTP id a18mr2789419itl.63.1559885629583;
 Thu, 06 Jun 2019 22:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com> <dc3f3092abbc0d48e51b2e2a2ca8f4c4f69fa0f4.1559580831.git.andreyknvl@google.com>
In-Reply-To: <dc3f3092abbc0d48e51b2e2a2ca8f4c4f69fa0f4.1559580831.git.andreyknvl@google.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 7 Jun 2019 07:33:38 +0200
Message-ID: <CAHUa44E+g3YTcja+7qgx+iABVd48DbrMMOm0sbyMwf0U6F5NPw@mail.gmail.com>
Subject: Re: [PATCH v16 14/16] tee, arm64: untag user pointers in tee_shm_register
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 3, 2019 at 6:56 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
>
> tee_shm_register()->optee_shm_unregister()->check_mem_type() uses provided
> user pointers for vma lookups (via __check_mem_type()), which can only by
> done with untagged pointers.
>
> Untag user pointers in this function.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

> ---
>  drivers/tee/tee_shm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 49fd7312e2aa..96945f4cefb8 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -263,6 +263,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>         shm->teedev = teedev;
>         shm->ctx = ctx;
>         shm->id = -1;
> +       addr = untagged_addr(addr);
>         start = rounddown(addr, PAGE_SIZE);
>         shm->offset = addr - start;
>         shm->size = length;
> --
> 2.22.0.rc1.311.g5d7573a151-goog
>

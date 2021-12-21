Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E34047BCB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 10:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhLUJSP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 04:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbhLUJSO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 04:18:14 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF8C061401
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 01:18:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s1so20147361wra.6
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 01:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5iW+pC6M0AC4rvnvC3YKv4mJu1z1Np9Tq93xhecgLQ=;
        b=wmThj83tixQB1+BvJAJrVB/eEODHqng1WY9c+gR32gqWxx99qGwSpZhMDzo0lxPhgU
         OTrs/MCv6swvPynzZCl9lJYPdgdoMQYJNBLVtuq/95C8zzcfM1Y/lKidhvKSMQ99y0/+
         sFxJM+XSivzlFWd9GtFk4xjXYPawMWvSbhRXwE6XSDGdEczu+YaHWzusyX5HEhQMreWU
         HESQJlcSbNwvEXmXfLrASRp3HdBFMNn5j/nAVem98SaHx7ZjsVArg+7ubzjci9Gtz9Nf
         YlLIx4KwOMYkNuhM6FV6PkBI9VsItVQ9iDaEoEGsXlRCh0y7AT2JO77Rp/78S7n3d9Yx
         PLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5iW+pC6M0AC4rvnvC3YKv4mJu1z1Np9Tq93xhecgLQ=;
        b=WxJh09r7GkG2Zluz6Mtig5jh0H9EGRm+adQUDVe3IZXjavv1pMHhFQqwbJHKh3Cjt3
         ZYgIsMn0jpDapY0qa6TWwJ037YolouTyga0aJBm8ATLqaaMYPEOU40WqV36AqC1RWYhW
         HESgDt1iIm6yz2CtZOX6pMMrbhem801mpZElaUDu3HAIQnj4MxWkWsa80R32zK3CsuNd
         g/1mEAYry3jWw/OkHcQPeOSpvV0OY3LP99snHS1c9ay/+UJaIzYrWLIhO+eGZNRWOdRK
         4IXaLtmKgpdZI0lWfn+jaYztQzKhvRj+q/CRz9b/12tkCfO6Ptq4JuUCxXi8YVOU6SH4
         A/UA==
X-Gm-Message-State: AOAM532P6UY7jjp8bc0nzsRy4JZqlLO1SNYBRaMrinMMOMDrVTS3XATP
        kZ5LxXUbPXz1W5hwL1/BE158N5p+iDch8CBtYefiSd42PNc=
X-Google-Smtp-Source: ABdhPJzMvJnvVrz3bX+O2cAARxvuaHmFVbxXAqaY95aKoQpjTR9wr3hdKBSBb2JrUTXsC2EDT+BMLl+GmavOkoTedYw=
X-Received: by 2002:a5d:56c2:: with SMTP id m2mr1843378wrw.313.1640078292945;
 Tue, 21 Dec 2021 01:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20211129075451.418122-1-anup.patel@wdc.com> <20211129075451.418122-4-anup.patel@wdc.com>
 <YcDdPUn9bAVnxb/2@google.com>
In-Reply-To: <YcDdPUn9bAVnxb/2@google.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 21 Dec 2021 14:48:01 +0530
Message-ID: <CAAhSdy3qFZoK16gh=F5jk7QC3q_xMOJbCmigCsQ1d7WYoSR9nA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] KVM: selftests: Add EXTRA_CFLAGS in top-level Makefile
To:     Sean Christopherson <seanjc@google.com>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 21, 2021 at 1:15 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Nov 29, 2021, Anup Patel wrote:
> > We add EXTRA_CFLAGS to the common CFLAGS of top-level Makefile
>
> Nit, wrap closer to 75 chars.

Okay, I will update.

>
> > which will allow users to pass additional compile-time flags such
> > as "-static".
>
> In case there's any hesitation in applying this (Paolo asked if this was just for
> debugging in v1), being able to pass "-static" is helpful for our environment as
> our test systems have a funky and minimal configuration (no gcc, and the interpreter
> is in a weird location).  Running selftests either requires building them with
> -static or creating a symbolic link for /lib64/ld-linux-x86-64.so.2.  It's generally
> easier to just tell people to compile with -static.
>
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
>
> Reviewed-and-tested-by: Sean Christopherson <seanjc@google.com>

Thanks, I am planning to queue this for 5.17. Currently, I am waiting for
some reviews on the PATCH4 (last patch).

Regards,
Anup

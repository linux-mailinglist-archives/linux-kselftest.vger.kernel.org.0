Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D381820B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 19:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbgCKS0M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 14:26:12 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40928 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbgCKS0L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 14:26:11 -0400
Received: by mail-vk1-f195.google.com with SMTP id k63so816473vka.7
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Mar 2020 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSTO/qgdxH6bi8PzikSAQgbIeZmagWyxAFGQFRnsxM0=;
        b=RJDG2r5hZ7Fa4gKvOb6pCPMrNGIdb/yHB7y2MSErjlsY7DUNkWh3ZEca8aPPbLj0VE
         ul6gkiQlxlyJ/oy4EVgannnB3f34MaqcrdBRY3NjNzJw+MC8doRaRH7czlERR29oZ7++
         XYgZ+a+e0GmSpGSW3PT5McijvKzbFCJfGGATRrEVCXhrhJvZ8sjZbJFhTfZWIu5pT+/0
         CE8s2xJ/zkUwJ75LtNCMyNOk99ot3gpGEzwc2DGOzuAcgDj8+bf6Wg8pUBdhHYtj4zqj
         1kzbY7mdKIMO1CScVFA8I+qyVi62JAK/5fBe+cSzveK3TknfkrVuCQQyXf/GO4cqHQOe
         BEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSTO/qgdxH6bi8PzikSAQgbIeZmagWyxAFGQFRnsxM0=;
        b=n+KOUkuC1O1Hf11QsmNsUZ9YU0R2UIPZrQCaHRfV1Q8oEIfwl3ghar5tOddHModh6V
         eFfvGht7ZL/xS3mdVdWUCSGW5hcGuHSJ6HOXXodxdUeIHdBcwr5QlaYiGxFlZHj1nw+L
         pujjBF3MPXJMc0pBZ0ulU64O7msGbBAvaU7LYdUxf8VqSZgv84SlhjThITNBDfpbLUkw
         wyrNu3tNzaaxaqpTpQgTnyUf4MsxXYvGx2Niqdt9NKuwveJh9F1B6dFkEdRD1lSiowSb
         m0jNrr7TNDvNkBNNV85SpsJxNVI7B1gHpmFikzqDA47SysaocWKlaq0i7XMcc7OxFgBt
         9slQ==
X-Gm-Message-State: ANhLgQ12Vbn009xu23RKDYWCE2nnDza3p9LIG/Mj2rVVnnWLf5s63Hv0
        1SawuZuCAsBMbnolTDcmnvmRg3cjGLnLt0ZAXugEZg==
X-Google-Smtp-Source: ADFU+vuIP9IDVuL0y634tAQhisn3M2xsRFEZFWHFyFy7XLhjtLGyNWdbdNXlCC9/Qu0OTuevDsb+8mNaGPDTKJZbW+M=
X-Received: by 2002:a1f:cbc1:: with SMTP id b184mr2790877vkg.73.1583951170072;
 Wed, 11 Mar 2020 11:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYusdfg7PMfC9Xce-xLT7NiyKSbgojpK35GOm=Pf9jXXrA@mail.gmail.com>
 <20200311105309.1742827-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200311105309.1742827-1-christian.brauner@ubuntu.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 11 Mar 2020 11:25:58 -0700
Message-ID: <CAHRSSEwF_UX7=6PLsmd62PfJwzdwScjqi=JxjtWkAmGorn+Xkw@mail.gmail.com>
Subject: Re: [PATCH] binderfs: use refcount for binder control devices too
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     naresh.kamboju@linaro.org, ard.biesheuvel@linaro.org,
        ardb@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, lkft-triage@lists.linaro.org,
        shuah@kernel.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 11, 2020 at 3:53 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Binderfs binder-control devices are cleaned up via binderfs_evict_inode
> too() which will use refcount_dec_and_test(). However, we missed to set
> the refcount for binderfs binder-control devices and so we underflowed
> when the binderfs instance got unmounted. Pretty obvious oversight and
> should have been part of the more general UAF fix. The good news is that
> having test cases (suprisingly) helps.
>
> Technically, we could detect that we're about to cleanup the
> binder-control dentry in binderfs_evict_inode() and then simply clean it
> up. But that makes the assumption that the binder driver itself will
> never make use of a binderfs binder-control device after the binderfs
> instance it belongs to has been unmounted and the superblock for it been
> destroyed. While it is unlikely to ever come to this let's be on the
> safe side. Performance-wise this also really doesn't matter since the
> binder-control device is only every really when creating the binderfs
> filesystem or creating additional binder devices. Both operations are
> pretty rare.
>
> Fixes: f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> Link: https://lore.kernel.org/r/CA+G9fYusdfg7PMfC9Xce-xLT7NiyKSbgojpK35GOm=Pf9jXXrA@mail.gmail.com
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: stable@vger.kernel.org
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binderfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 110e41f920c2..f303106b3362 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -448,6 +448,7 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
>         inode->i_uid = info->root_uid;
>         inode->i_gid = info->root_gid;
>
> +       refcount_set(&device->ref, 1);
>         device->binderfs_inode = inode;
>         device->miscdev.minor = minor;
>
>
> base-commit: 2c523b344dfa65a3738e7039832044aa133c75fb
> --
> 2.25.1
>

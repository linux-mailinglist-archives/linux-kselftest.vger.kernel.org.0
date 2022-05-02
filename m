Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8159A51727D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 May 2022 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385722AbiEBP3P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 May 2022 11:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351340AbiEBP3O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 May 2022 11:29:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2171913DD4
        for <linux-kselftest@vger.kernel.org>; Mon,  2 May 2022 08:25:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y32so25842952lfa.6
        for <linux-kselftest@vger.kernel.org>; Mon, 02 May 2022 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RisVP5Snmr1bt4RiEhBJahRqYpRuwkZWR8WoDtnKv9M=;
        b=L7jVaaIJvOV3E0GWtj7pjTNHT8WQSTLD+y0xRji2SkRCRDxSR7vpqt5d39WmZ+LrfI
         lPF9/zx2LKwGrK1nARkrw9xCCu7A7gYPDMuW06qVQTNksE/OZGzf7xe0ghHYhbRQVw9N
         qtpZ6fSqnET71u8z3uSrFGstT3Vqq4i8gTEScE9XVGIQDQ1ciUiU6cK3Yco+SLsFDeSe
         sFnSd1hnGWq5epdfWfD1cMjb6+UvisvNvBOrZDzL0NiT27OYYtu60nYFxq2HR2N5NQht
         kS/nj//XJfM8Gx61cKxbS0oS2JIx62/DgI6Drbx8Ona2kEpVTvpOSkbZ0J4q+r+F0sMu
         rkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RisVP5Snmr1bt4RiEhBJahRqYpRuwkZWR8WoDtnKv9M=;
        b=FjxQeV38f4UWWL7fCAT8pvX+mQf6sBxNmdQYwbN6JXqCebhWefyucO+cJyNuld1gRg
         g6adKJ0m72eApj7HMpyTNwR6x9gSPZuksMbeAP1Zwnancij70+2bWFeyx6HLa5f8JLn0
         5+Zd1sOGG0ZPzZasUHjh6hbGHpYetqtYiezZPq8aZrIMeslgPgD0awKNGWEqK0h4dNmP
         VB3wghJeRePSP7AysskQYSfHHYWNJ648Hu7xN+tJJWxiPWMLeAjD78Yil3lhHWvyPEtc
         T1bVlLGRJnlrIjVE2D8bSBAAKg7F/c88GMAlIw4P8a/UCnPR4rGFx0K7ZKGR84g/Lzql
         nIPQ==
X-Gm-Message-State: AOAM530BWAcUEkUum3zvIm7kSXuG9yxWjYygdp+Oc1eNzp/16gOPYXOU
        ukbf/NK+EyTBm7dxF76nSOY5tBtB7whOQCB+z4uutQ==
X-Google-Smtp-Source: ABdhPJw7sZaEWo9C3stiapYw385piuVpyuFJ0aaJ/hfskAhQrpxFB1ysfesjEwbnne/ZYHhDLOf56WWcI0wwkoo7a+c=
X-Received: by 2002:a05:6512:3f09:b0:45d:e5d6:4f3f with SMTP id
 y9-20020a0565123f0900b0045de5d64f3fmr8849359lfa.403.1651505140202; Mon, 02
 May 2022 08:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220429235644.697372-1-cmllamas@google.com> <20220429235644.697372-2-cmllamas@google.com>
In-Reply-To: <20220429235644.697372-2-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 2 May 2022 08:25:28 -0700
Message-ID: <CAHRSSEwPsftMOduo7=SaD2Qf4m+9o9v6uQU9Qzun_Gz13Vg=qA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] binder: add failed transaction logging info
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Li Li <dualli@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 29, 2022 at 4:56 PM Carlos Llamas <cmllamas@google.com> wrote:
>
> Make sure we log relevant information about failed transactions such as
> the target proc/thread, call type and transaction id. These details are
> particularly important when debugging userspace issues.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 8351c5638880..f0885baa53a1 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3459,8 +3459,12 @@ static void binder_transaction(struct binder_proc *proc,
>         }
>
>         binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
> -                    "%d:%d transaction failed %d/%d, size %lld-%lld line %d\n",
> -                    proc->pid, thread->pid, return_error, return_error_param,
> +                    "%d:%d transaction %s to %d:%d failed %d/%d/%d, size %lld-%lld line %d\n",
> +                    proc->pid, thread->pid, reply ? "reply" :
> +                    (tr->flags & TF_ONE_WAY ? "async" : "call"),
> +                    target_proc ? target_proc->pid : 0,
> +                    target_thread ? target_thread->pid : 0,
> +                    t_debug_id, return_error, return_error_param,
>                      (u64)tr->data_size, (u64)tr->offsets_size,
>                      return_error_line);
>
> --
> 2.36.0.464.gb9c8b46e94-goog
>

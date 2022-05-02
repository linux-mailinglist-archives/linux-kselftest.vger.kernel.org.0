Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044DD51728A
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 May 2022 17:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385755AbiEBPdc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 May 2022 11:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357710AbiEBPdb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 May 2022 11:33:31 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB112AA4
        for <linux-kselftest@vger.kernel.org>; Mon,  2 May 2022 08:30:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m23so18874649ljc.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 May 2022 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KaYC/hR9EweEPxn/lknEuh9lm3r0s8f4P2PPpx7IpG4=;
        b=RGe8ZuM568I+kn3wyy882sgEM06LruO1ZZ1/9lZ8CSsKHgyyW0WKoZ0ZPPiH7ZFgQx
         RBkfFRgbkEKCAtnYq/hJzh0hYZRLoSdGhT41ISEmnQT6ieiczXCMLTfMtEXeUVWkhKEj
         7Q1OtSlUPAtm/LzhbJ5AeXbjlJG/xogLhK895DzbAL8N5pGk2Caxzizx7P+ejwkLEqjd
         z6xuOr8mp+NeyM2o+DCtaazDd7MJbGn337xm95XRXGGkz0MWoj2QJSW53Cz6+0SSCSL/
         xEHOY9zIvDQkNZha2GwTqA6I7l76HnH05SDVn++SrrNOq6o2ywUEYDaUVZoYBr/RWdYF
         eVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KaYC/hR9EweEPxn/lknEuh9lm3r0s8f4P2PPpx7IpG4=;
        b=S71I/O0xRgTiQBJ9TpdjD9h+o2cGslmvs7t+mmJWl5tV4Y2Fj1YUNXWN3M1yo7JWkf
         K1UVkMzlFngcXMLOFc1NHQ5S001Ti8NQGuKw7fvE4rD7bxlcVcFy7IKL6xsQb5t/325x
         lZOO3nLcbLrp9OScSOoP35LJA21TypXQyqbz9bt4nhULQQwr2rns5reTUxy8QRZBX8qZ
         gaRdACRD/hH0SjVUEvQ9JSmsyf/NXZJN8SA4LnLahJ2A8VdrmMZLzwEjI2UBe9VcipaR
         X6DC6dRJP5K5y3oPg0GvO/kr71HNTrsUZqRFAweHAVNh0DKSgyIYfNbemqYzeuZFgWmk
         heBw==
X-Gm-Message-State: AOAM532Hjb6muike4AyiStYQ8rfy3k39ymKfWUYh7h/vP/yXTe+b18nM
        nFT2eCnFaEhTh+v9VLiXk4m7rVNmlF7siMwWlwpz5w==
X-Google-Smtp-Source: ABdhPJw6cLOyMHiDWJzzKJewLS4CDWvylMuZ9LqJTo3a9aiL0INTT62P7xle1YmsHd7WOc+qms6YBs3/nWHCXNBR2fM=
X-Received: by 2002:a2e:7c16:0:b0:244:be33:9718 with SMTP id
 x22-20020a2e7c16000000b00244be339718mr7843039ljc.467.1651505399798; Mon, 02
 May 2022 08:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220429235644.697372-1-cmllamas@google.com> <20220429235644.697372-6-cmllamas@google.com>
In-Reply-To: <20220429235644.697372-6-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 2 May 2022 08:29:48 -0700
Message-ID: <CAHRSSEwYQgM5F6akh87y_VVWGKFZ8PPY_6Bt0cP1h2JXWeRn9g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] binder: additional transaction error logs
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

On Fri, Apr 29, 2022 at 4:57 PM 'Carlos Llamas' via kernel-team
<kernel-team@android.com> wrote:
>
> Log readable and specific error messages whenever a transaction failure
> happens. This will ensure better context is given to regular users about
> these unique error cases, without having to decode a cryptic log.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 48 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index bfb21e258427..d7c5e2dde270 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -147,6 +147,9 @@ static __printf(2, 3) void binder_debug(int mask, const char *format, ...)
>         }
>  }
>
> +#define binder_txn_error(x...) \
> +       binder_debug(BINDER_DEBUG_FAILED_TRANSACTION, x)
> +
>  static __printf(1, 2) void binder_user_error(const char *format, ...)
>  {
>         struct va_format vaf;
> @@ -2823,6 +2826,8 @@ static void binder_transaction(struct binder_proc *proc,
>                 if (target_thread == NULL) {
>                         /* annotation for sparse */
>                         __release(&target_thread->proc->inner_lock);
> +                       binder_txn_error("%d:%d reply target not found\n",
> +                               thread->pid, proc->pid);
>                         return_error = BR_DEAD_REPLY;
>                         return_error_line = __LINE__;
>                         goto err_dead_binder;
> @@ -2888,6 +2893,8 @@ static void binder_transaction(struct binder_proc *proc,
>                         }
>                 }
>                 if (!target_node) {
> +                       binder_txn_error("%d:%d cannot find target node\n",
> +                               thread->pid, proc->pid);
>                         /*
>                          * return_error is set above
>                          */
> @@ -2897,6 +2904,8 @@ static void binder_transaction(struct binder_proc *proc,
>                 }
>                 e->to_node = target_node->debug_id;
>                 if (WARN_ON(proc == target_proc)) {
> +                       binder_txn_error("%d:%d self transactions not allowed\n",
> +                               thread->pid, proc->pid);
>                         return_error = BR_FAILED_REPLY;
>                         return_error_param = -EINVAL;
>                         return_error_line = __LINE__;
> @@ -2904,6 +2913,8 @@ static void binder_transaction(struct binder_proc *proc,
>                 }
>                 if (security_binder_transaction(proc->cred,
>                                                 target_proc->cred) < 0) {
> +                       binder_txn_error("%d:%d transaction credentials failed\n",
> +                               thread->pid, proc->pid);
>                         return_error = BR_FAILED_REPLY;
>                         return_error_param = -EPERM;
>                         return_error_line = __LINE__;
> @@ -2975,6 +2986,8 @@ static void binder_transaction(struct binder_proc *proc,
>         /* TODO: reuse incoming transaction for reply */
>         t = kzalloc(sizeof(*t), GFP_KERNEL);
>         if (t == NULL) {
> +               binder_txn_error("%d:%d cannot allocate transaction\n",
> +                       thread->pid, proc->pid);
>                 return_error = BR_FAILED_REPLY;
>                 return_error_param = -ENOMEM;
>                 return_error_line = __LINE__;
> @@ -2986,6 +2999,8 @@ static void binder_transaction(struct binder_proc *proc,
>
>         tcomplete = kzalloc(sizeof(*tcomplete), GFP_KERNEL);
>         if (tcomplete == NULL) {
> +               binder_txn_error("%d:%d cannot allocate work for transaction\n",
> +                       thread->pid, proc->pid);
>                 return_error = BR_FAILED_REPLY;
>                 return_error_param = -ENOMEM;
>                 return_error_line = __LINE__;
> @@ -3032,6 +3047,8 @@ static void binder_transaction(struct binder_proc *proc,
>                 security_cred_getsecid(proc->cred, &secid);
>                 ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
>                 if (ret) {
> +                       binder_txn_error("%d:%d failed to get security context\n",
> +                               thread->pid, proc->pid);
>                         return_error = BR_FAILED_REPLY;
>                         return_error_param = ret;
>                         return_error_line = __LINE__;
> @@ -3040,7 +3057,8 @@ static void binder_transaction(struct binder_proc *proc,
>                 added_size = ALIGN(secctx_sz, sizeof(u64));
>                 extra_buffers_size += added_size;
>                 if (extra_buffers_size < added_size) {
> -                       /* integer overflow of extra_buffers_size */
> +                       binder_txn_error("%d:%d integer overflow of extra_buffers_size\n",
> +                               thread->pid, proc->pid);
>                         return_error = BR_FAILED_REPLY;
>                         return_error_param = -EINVAL;
>                         return_error_line = __LINE__;
> @@ -3054,9 +3072,15 @@ static void binder_transaction(struct binder_proc *proc,
>                 tr->offsets_size, extra_buffers_size,
>                 !reply && (t->flags & TF_ONE_WAY), current->tgid);
>         if (IS_ERR(t->buffer)) {
> -               /*
> -                * -ESRCH indicates VMA cleared. The target is dying.
> -                */
> +               char *s;
> +
> +               ret = PTR_ERR(t->buffer);
> +               s = (ret == -ESRCH) ? ": vma cleared, target dead or dying"
> +                       : (ret == -ENOSPC) ? ": no space left"
> +                       : (ret == -ENOMEM) ? ": memory allocation failed"
> +                       : "";
> +               binder_txn_error("cannot allocate buffer%s", s);
> +
>                 return_error_param = PTR_ERR(t->buffer);
>                 return_error = return_error_param == -ESRCH ?
>                         BR_DEAD_REPLY : BR_FAILED_REPLY;
> @@ -3139,6 +3163,8 @@ static void binder_transaction(struct binder_proc *proc,
>                                                   t->buffer,
>                                                   buffer_offset,
>                                                   sizeof(object_offset))) {
> +                       binder_txn_error("%d:%d copy offset from buffer failed\n",
> +                               thread->pid, proc->pid);
>                         return_error = BR_FAILED_REPLY;
>                         return_error_param = -EINVAL;
>                         return_error_line = __LINE__;
> @@ -3197,6 +3223,8 @@ static void binder_transaction(struct binder_proc *proc,
>                                                         t->buffer,
>                                                         object_offset,
>                                                         fp, sizeof(*fp))) {
> +                               binder_txn_error("%d:%d translate binder failed\n",
> +                                       thread->pid, proc->pid);
>                                 return_error = BR_FAILED_REPLY;
>                                 return_error_param = ret;
>                                 return_error_line = __LINE__;
> @@ -3214,6 +3242,8 @@ static void binder_transaction(struct binder_proc *proc,
>                                                         t->buffer,
>                                                         object_offset,
>                                                         fp, sizeof(*fp))) {
> +                               binder_txn_error("%d:%d translate handle failed\n",
> +                                       thread->pid, proc->pid);
>                                 return_error = BR_FAILED_REPLY;
>                                 return_error_param = ret;
>                                 return_error_line = __LINE__;
> @@ -3234,6 +3264,8 @@ static void binder_transaction(struct binder_proc *proc,
>                                                         t->buffer,
>                                                         object_offset,
>                                                         fp, sizeof(*fp))) {
> +                               binder_txn_error("%d:%d translate fd failed\n",
> +                                       thread->pid, proc->pid);
>                                 return_error = BR_FAILED_REPLY;
>                                 return_error_param = ret;
>                                 return_error_line = __LINE__;
> @@ -3303,6 +3335,8 @@ static void binder_transaction(struct binder_proc *proc,
>                                                                   object_offset,
>                                                                   fda, sizeof(*fda));
>                         if (ret) {
> +                               binder_txn_error("%d:%d translate fd array failed\n",
> +                                       thread->pid, proc->pid);
>                                 return_error = BR_FAILED_REPLY;
>                                 return_error_param = ret > 0 ? -EINVAL : ret;
>                                 return_error_line = __LINE__;
> @@ -3330,6 +3364,8 @@ static void binder_transaction(struct binder_proc *proc,
>                                 (const void __user *)(uintptr_t)bp->buffer,
>                                 bp->length);
>                         if (ret) {
> +                               binder_txn_error("%d:%d deferred copy failed\n",
> +                                       thread->pid, proc->pid);
>                                 return_error = BR_FAILED_REPLY;
>                                 return_error_param = ret;
>                                 return_error_line = __LINE__;
> @@ -3353,6 +3389,8 @@ static void binder_transaction(struct binder_proc *proc,
>                                                         t->buffer,
>                                                         object_offset,
>                                                         bp, sizeof(*bp))) {
> +                               binder_txn_error("%d:%d failed to fixup parent\n",
> +                                       thread->pid, proc->pid);
>                                 return_error = BR_FAILED_REPLY;
>                                 return_error_param = ret;
>                                 return_error_line = __LINE__;
> @@ -3460,6 +3498,8 @@ static void binder_transaction(struct binder_proc *proc,
>         return;
>
>  err_dead_proc_or_thread:
> +       binder_txn_error("%d:%d dead process or thread\n",
> +               thread->pid, proc->pid);
>         return_error_line = __LINE__;
>         binder_dequeue_work(proc, tcomplete);
>  err_translate_failed:
> --
> 2.36.0.464.gb9c8b46e94-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2A4045D5
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Sep 2021 08:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350467AbhIIGzZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Sep 2021 02:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbhIIGzY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Sep 2021 02:55:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEEEC061757
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Sep 2021 23:54:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q26so946570wrc.7
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Sep 2021 23:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PdyHdIGTIcExNI9r9vt6KvD+sKOV7iT7d1j4FssidJk=;
        b=NEGnnOBV9RPUC15x/R1lIz4hVZL5OPCHBQAFWpmM/ROy7YTqLjYPBccHng0uAFC9nZ
         YIVBE0eRwPBPhVcPMyv0sZ6Pra3+jQTN0duyhpRK8DI+VEgbMoBrSrq71HElVr4TY8tE
         bX5Q7TsNXhmk7DrIrfhswRWxNZs702q45KCTHmVLRb7YU9ky0jkzfs6NL+3Xr0wuVgnc
         Q9uAjZlAM58BupaV7tnSxeIwq0AZ19CHkDqLpJc//2CD6XxeEKdQQLZCph5h8Zax1Bi6
         fzG4EmnbEwAuPeyVkO6dgrdvaEcrVq9RPZiXSnbH0qx11K4KSsgTpLED26jhZU2BbEyd
         819g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdyHdIGTIcExNI9r9vt6KvD+sKOV7iT7d1j4FssidJk=;
        b=Pwkajc74mUrahcxojPs7lLhM6uojZL1NrCQonuW/pVnlPMcqiZiRzgUXowplguOMqf
         +cglzxTFyg8S4Q8wKzuDK+8dIICr3WxeZfefkH1M9HCCw9HtUkmPZwrlYB1IM3UXVSRK
         Veohkiqnf9xiVGbhyCho5Qw6h9pCyIAI1BOkH3Z+v22GTk/iqW2JWbhsOP5sH07+NL68
         okm0N4/Bebq55ff8cEHsc7ko1UYuIBmHDFQq8o+8ePaScZ9jdcdIa76FlSc4CQSYiYLK
         caiBD252KAtVrIM1aQsNe/3uiGDlYdqgIqicMfEXdPvabSd5kFez/sF9Tw47yCIcgPTb
         sjPQ==
X-Gm-Message-State: AOAM5300sXkGQnAt7aX6HS7RGMAbfZd6bOE7FlG/8c7C0GvOkeWVNrOD
        Tcfl0lY5PJA5LBgKmbJ9esAODNhMj3dpM9TOJ40AB8yhmq4=
X-Google-Smtp-Source: ABdhPJwcZ/XBoMS2ALZ03DQVCmLDUjaC4x3wXUJC1n95C3XNz8zT8/c9nIlkWSOZsk/IhbPSsRFa8FQV8P8Jtnaa8oQ=
X-Received: by 2002:a5d:6909:: with SMTP id t9mr1639256wru.44.1631170454168;
 Wed, 08 Sep 2021 23:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <1631165296-81082-1-git-send-email-xiyuyang19@fudan.edu.cn>
In-Reply-To: <1631165296-81082-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   David Gow <davidgow@google.com>
Date:   Thu, 9 Sep 2021 14:54:03 +0800
Message-ID: <CABVgOSkbmS_EHtTdzmk8CVY8Gm-M9hUWRuUBt+4ZLt2-txy_Aw@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix reference count leak in kfree_at_end
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 9, 2021 at 1:28 PM 'Xiyu Yang' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> The reference counting issue happens in the normal path of
> kfree_at_end(). When kunit_alloc_and_get_resource() is invoked, the
> function forgets to handle the returned resource object, whose refcount
> increased inside, causing a refcount leak.
>
> Fix this issue by calling kunit_put_resource() at the end of function.
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---

Thanks for looking into this.

+ Daniel -- any thoughts?

>  lib/kunit/executor_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index cdbe54b16501..3af30abad826 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -113,11 +113,13 @@ static void kfree_res_free(struct kunit_resource *res)
>   */
>  static void kfree_at_end(struct kunit *test, const void *to_free)
>  {
> +       struct kunit_resource *res;
>         /* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
>         if (IS_ERR_OR_NULL(to_free))
>                 return;
> -       kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KERNEL,
> +       res = kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KERNEL,
>                                      (void *)to_free);
> +       kunit_put_resource(res);

Why not just change this to kunit_alloc_resource()?

>  }
>
>  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/1631165296-81082-1-git-send-email-xiyuyang19%40fudan.edu.cn.

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07E0405BA0
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Sep 2021 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239943AbhIIRBS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Sep 2021 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbhIIRBR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Sep 2021 13:01:17 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32517C061575
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Sep 2021 10:00:08 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b7so3213198iob.4
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Sep 2021 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2paSwQM8zCxokyQ6GIbHK5N8e/MvXNOEn1+qQELdMbY=;
        b=bUtpOWsfwWVZVVdqZQr4prAXWhLtnpDKnW1NVBf1elwFDXGPzH9pP5b1AYjXNpKW+u
         KwAITZt6iBOVQ0ZTlqf5VFH27xIBISY6VkY3/Cq77PbQYov7Ve53nGSNZ6ULxrHajpy6
         pPgp8UhXigGWsNhjl4CGV0pLgIinpslfZfcHqpgs6ZvgJCYkkIQxOBQRea3Sn9J6g2gq
         pKoHiQn/cS+lp88/p6m3H17RLTBJb6y71UklEzwU5YUQJw/1G4eCjpRmqJfz1kp7aewE
         SCC3wyxOtQxajE1y0Mkh1S9P/IO2dhn77Fa4rduKB3DBDg0DDp2OS99leBK9UCnD1fUM
         6t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2paSwQM8zCxokyQ6GIbHK5N8e/MvXNOEn1+qQELdMbY=;
        b=E+KG3EOAvipOOvOqz2D3wdpcVHhfB81w/Z0JAHP/mJGrWbTjGwHQeI32RDyymEuOSk
         aBLV8ZWOgqlJ5k3nRWkDb3t6HdhxgAgB7DMBbwmxJOIj19o2h5SC6j4WdpblIJ1Sl5Xj
         kswp++4MtNNTlU0uAUY+jsbccM8MEB/2fMtcw67DtW7Qh5Y8bKKYxe/gcVuKylD0s4ZD
         WXKD9Fw8rEVPC5RQ4e/PA2vXCCUYygZJ55g76FzWY7h6jrMzxwhxUkk/rPnxn1/HfDrw
         tkXflHA6P4Bnol5oZfCJ8t/6Kxxk+bpezL/+Zq6Qk3u7llK0lPL2lhkUQ0zGZ6htwGen
         /3hA==
X-Gm-Message-State: AOAM531MVKRJKoYrONYq3tqtl83+bBzeNDXPqY1foFqEVipzty9sPE0a
        MSu3jGfH8pUVUtUpfhDY6T/FlfALTLmeRVa/MJrw/w==
X-Google-Smtp-Source: ABdhPJyvnDOMYLUfuOx8UO8RZc5WDLY8KKpV4m0wWiT2yrmOl6CNyM1Zix/Yg4swBUAJ7F2lxGiM6RMiJY9BpXXVE2s=
X-Received: by 2002:a05:6602:38e:: with SMTP id f14mr3623809iov.62.1631206807352;
 Thu, 09 Sep 2021 10:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <1631172276-82914-1-git-send-email-xiyuyang19@fudan.edu.cn>
In-Reply-To: <1631172276-82914-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 9 Sep 2021 09:59:56 -0700
Message-ID: <CAGS_qxp2e3pgZ6nGW+5=qneeVw_Pd_ex9kX4jZqA9bweoHXxFA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: fix reference count leak in kfree_at_end
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 9, 2021 at 12:26 AM 'Xiyu Yang' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> The reference counting issue happens in the normal path of
> kfree_at_end(). When kunit_alloc_and_get_resource() is invoked, the
> function forgets to handle the returned resource object, whose refcount
> increased inside, causing a refcount leak.
>
> Fix this issue by calling kunit_alloc_resource() instead of
> kunit_alloc_and_get_resource().
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Ah, thanks for finding and fixing this!
We really should have better documentation/otherwise make it clearer
that people shouldn't use the "_and_get" version.

I went and added some pr_info() calls to verify that these were being
leaked before and they're fixed now.

I copy-pasted this mistake into
https://lore.kernel.org/linux-kselftest/20210831171926.3832806-2-dlatypov@google.com/.
I'll send a v3 fix for that patch as well.

> ---
>  lib/kunit/executor_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index cdbe54b16501..c2dcfb1f6e97 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -116,7 +116,7 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
>         /* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
>         if (IS_ERR_OR_NULL(to_free))
>                 return;
> -       kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KERNEL,
> +       kunit_alloc_resource(test, NULL, kfree_res_free, GFP_KERNEL,
>                                      (void *)to_free);
>  }
>
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/1631172276-82914-1-git-send-email-xiyuyang19%40fudan.edu.cn.

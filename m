Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB7405BD2
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Sep 2021 19:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbhIIRQx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Sep 2021 13:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbhIIRQx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Sep 2021 13:16:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9184C061575
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Sep 2021 10:15:43 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n24so3257408ion.10
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Sep 2021 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6R8eEc3dAmoTOcAlSBC8/eAMhoLiJ9o2v0ZjAH+j7w=;
        b=Xuzpdlgy0Mglp2Q6DiZ1UcVdF1mmB7GMVukvfDl4CXkDoEzbMmbpuglVHmcZh/2QAC
         I2ipMBRcXuKGt7eD6A/VQMYeUpg3XsJVENqX10CT5SEFLzRouH2a0g/gHKkoY1MsX2nS
         pzoVHk9LtWqs8bUyJR3JVmxhwGBzMQMjDYgaQYrCyLH9kCOIN7Bzuyb3klX9ndOwuUVo
         HIsaoSW22mzzvOSDvzK8v/QTmTdKE/7ZTwKjI2t+jEh5KOWSZ2m4Xa4vydDh/5CHIJ5u
         0qxEJE1F4LJtI0ufVNhOO2ratIshIVh6vOSC2m1xAlx1exjIBD+0J8o+s7KweaTCQ2Za
         ANYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6R8eEc3dAmoTOcAlSBC8/eAMhoLiJ9o2v0ZjAH+j7w=;
        b=UWQm2XT6pvQO4tmrW0thI6jhHPvWlKm8Lhei7+22I792r4ASX1KLDUDIZARjlOXaPN
         iWWVydId30NxYOyqbXqMNysdnk7re++JFi/YeQqorBBns6hugvgrzGOoS3qeKL7S/qOJ
         L9wpi9Ntkg8kJVykEW2kEs6gmr1lbiSt013aXix12ByQrX6qzcKxdPdw5fjpO5OrDNZy
         E1vVr3Ee2rEz/p1/y06/1eSIu40lFsBzZbRZFht7r1qHYrHOUtN5sXNcPqGD3A3SPemQ
         kxjuIyw+4PLAPmrunOxD9xslSCAr7TdYA3kxKxuUyOMNeuRI9IbfOjvXhFI4yY3AFUMQ
         X36w==
X-Gm-Message-State: AOAM530U6M2nMWsCBFFAhZCxfN+A1dOkhXYbtdWBo2bRf/vqIfSSKYRY
        1zM6VEo7XRjvq0kXS8DGOV4oKu3BLoetrAGW+IPONg==
X-Google-Smtp-Source: ABdhPJy/giURPU4TNqNc4CQwQjjwPmZA3FmLT05wdI6roGPG9gWBK7SXhsDFBbuxRIeTAPiMuV9yJHR+I8oXQtssFm0=
X-Received: by 2002:a5d:9da4:: with SMTP id ay36mr3685386iob.153.1631207742866;
 Thu, 09 Sep 2021 10:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <1631172276-82914-1-git-send-email-xiyuyang19@fudan.edu.cn> <CAGS_qxp2e3pgZ6nGW+5=qneeVw_Pd_ex9kX4jZqA9bweoHXxFA@mail.gmail.com>
In-Reply-To: <CAGS_qxp2e3pgZ6nGW+5=qneeVw_Pd_ex9kX4jZqA9bweoHXxFA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 9 Sep 2021 10:15:31 -0700
Message-ID: <CAGS_qxqFY3oaUC=m_5nDtozgBPgqU9zdiB3=7h5QPF0HBaLaqw@mail.gmail.com>
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

On Thu, Sep 9, 2021 at 9:59 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, Sep 9, 2021 at 12:26 AM 'Xiyu Yang' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > The reference counting issue happens in the normal path of
> > kfree_at_end(). When kunit_alloc_and_get_resource() is invoked, the
> > function forgets to handle the returned resource object, whose refcount
> > increased inside, causing a refcount leak.
> >
> > Fix this issue by calling kunit_alloc_resource() instead of
> > kunit_alloc_and_get_resource().
> >
> > Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>
> Ah, thanks for finding and fixing this!
> We really should have better documentation/otherwise make it clearer
> that people shouldn't use the "_and_get" version.
>
> I went and added some pr_info() calls to verify that these were being
> leaked before and they're fixed now.
>
> I copy-pasted this mistake into
> https://lore.kernel.org/linux-kselftest/20210831171926.3832806-2-dlatypov@google.com/.
> I'll send a v3 fix for that patch as well.

Fixed that patch:
https://lore.kernel.org/linux-kselftest/20210909171052.3192326-2-dlatypov@google.com/

I assume this patch and that one shouldn't have merge conflicts, so we
don't need these to be applied in any specific order.

>
> > ---
> >  lib/kunit/executor_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> > index cdbe54b16501..c2dcfb1f6e97 100644
> > --- a/lib/kunit/executor_test.c
> > +++ b/lib/kunit/executor_test.c
> > @@ -116,7 +116,7 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
> >         /* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
> >         if (IS_ERR_OR_NULL(to_free))
> >                 return;
> > -       kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KERNEL,
> > +       kunit_alloc_resource(test, NULL, kfree_res_free, GFP_KERNEL,
> >                                      (void *)to_free);
> >  }
> >
> > --
> > 2.7.4
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/1631172276-82914-1-git-send-email-xiyuyang19%40fudan.edu.cn.

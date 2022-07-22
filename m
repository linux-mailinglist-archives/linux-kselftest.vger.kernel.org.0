Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E3057DB2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jul 2022 09:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiGVHRx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Jul 2022 03:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiGVHRh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Jul 2022 03:17:37 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B46DB35
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jul 2022 00:17:01 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id q26so3569615vsp.11
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jul 2022 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSWCzyyi5A473F09U+VaQnX1hvRxVtUcH+BPYGqOwMw=;
        b=phMS3u4dG0RDRkFoL5//kQJVpEoveww37/02BA+AafOIl9LwjUYqwXjZhH5uCVgn1U
         IvTdGfm22QxNwkYjqw0apNFP0fcLbozonxbdYjvF3Q9slfEcN1apNAbwGEiNgm1s45Og
         tTE5RGrW5Rip8lZDf68qakiZ0P3xqDNAtKm7kBbjm+Phavfg/pbYn9o90CfZxuws+MmT
         66PwaQa505wrJ1DS+lwFuEUdra/BBMiIX7jRUzrbUKSC9Zw1Mpr3VGbw+7+JBihod/Pg
         GwyaMDjM3AULZpVZdYWXQ+MuBfIdOL2zXwp8d+PyvmTLIFfGExkBh00gVmYNw2o7dLVg
         M+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSWCzyyi5A473F09U+VaQnX1hvRxVtUcH+BPYGqOwMw=;
        b=d4AIuZw8G6Jf0EUyQCyltqR/JpyOzymcN9X7MPrhD+mKCG3tTQfE6yy9+3UHwJg8r4
         QV+WMNyyUj0zvmdRk4biiEzF/Tmt03Dq3w+hyRBC57tSyzsGwsJtIiusKk71r7iXO9uf
         TOm6r46XGbqzj4misi9H9jD65eqfixqmVE7QySPshz2XOqighn29EE7eFrVTw2K7VXz9
         fnnIsscsaGzluLc2MVxSooGa85EkZtVbUHo8tmF3fy6t1bgKDRwjIl804uYgxVnVlwvl
         as7BWKG6JxHP0U6X9gqJJpv5fY/H1w9UCxAteI+OJY/N0MQW0mf5pjkbi90GC7Ekql6G
         v7nA==
X-Gm-Message-State: AJIora/scMvUvtEo7SFY+kalZvJ6F5WIPhRQedw7Y2tG6HEUv13RMd3d
        pJTV5oq85cjNvLAtWk4R9P6ksSEGplvAyqpJxIcVOA==
X-Google-Smtp-Source: AGRyM1vVm+aeEwAMuJ8JhB3whC0qiIozlB+QFjISziJWEqhPPIKjG9m+/5XSdCmeV1y6jE8uRCEn4Soea5qsifWsvKw=
X-Received: by 2002:a05:6102:381:b0:357:a112:adc7 with SMTP id
 m1-20020a056102038100b00357a112adc7mr610910vsq.38.1658474220111; Fri, 22 Jul
 2022 00:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220721180214.3223778-1-dlatypov@google.com> <20220721180214.3223778-3-dlatypov@google.com>
In-Reply-To: <20220721180214.3223778-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Jul 2022 15:16:49 +0800
Message-ID: <CABVgOS=bEq3K+0SU+1E8e6ZguBb0WV9UYNBaT5O+hydAe8p2WQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] kunit: make kunit_kfree() only work on pointers from
 kunit_malloc() and friends
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 22, 2022 at 2:02 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> kunit_kfree() exists to clean up allocations from kunit_kmalloc() and
> friends early instead of waiting for this to happen automatically at the
> end of the test.
>
> But it can be used on *anything* registered with the kunit resource API.
>
> E.g. the last 2 statements are equivalent:
>   struct kunit_resource *res = something();
>   kfree(res->data);
>   kunit_put_resource(res);
>
> The problem is that there could be multiple resources that point to the
> same `data`.
>
> E.g. you can have a named resource acting as a pseudo-global variable in
> a test. If you point it to data allocated with kunit_kmalloc(), then
> calling `kunit_kfree(ptr)` has the chance to delete either the named
> resource or to kfree `ptr`.
> Which one it does depends on the order the resources are registered as
> kunit_kfree() will delete resources in LIFO order.
>
> So this patch restricts kunit_kfree() to only working on resources
> created by kunit_kmalloc(). Calling it is therefore guaranteed to free
> the memory, not do anything else.
>
> Note: kunit_resource_instance_match() wasn't used outside of KUnit, so
> it should be safe to remove from the public interface. It's also
> generally dangerous, as shown above, and shouldn't be used.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This is basically part of a sneaky, but sensible trend to make
resources more obviously "typed". Given how many issues that can
cause, this is definitely a worthwhile change.

I have some plans to further refactor some of the resources stuff down
the line (and to improve the documentation somewhat), so something not
dissimilar to this was going to happen eventually.

In any case,
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/resource.h | 16 ----------------
>  lib/kunit/kunit-test.c   |  7 +++++++
>  lib/kunit/test.c         | 10 ++++++++--
>  3 files changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> index 09c2b34d1c61..cf6fb8f2ac1b 100644
> --- a/include/kunit/resource.h
> +++ b/include/kunit/resource.h
> @@ -300,22 +300,6 @@ typedef bool (*kunit_resource_match_t)(struct kunit *test,
>                                        struct kunit_resource *res,
>                                        void *match_data);
>
> -/**
> - * kunit_resource_instance_match() - Match a resource with the same instance.
> - * @test: Test case to which the resource belongs.
> - * @res: The resource.
> - * @match_data: The resource pointer to match against.
> - *
> - * An instance of kunit_resource_match_t that matches a resource whose
> - * allocation matches @match_data.
> - */
> -static inline bool kunit_resource_instance_match(struct kunit *test,
> -                                                struct kunit_resource *res,
> -                                                void *match_data)
> -{
> -       return res->data == match_data;
> -}
> -
>  /**
>   * kunit_resource_name_match() - Match a resource with the same name.
>   * @test: Test case to which the resource belongs.
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 13d0bd8b07a9..4df0335d0d06 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -161,6 +161,13 @@ static void kunit_resource_test_alloc_resource(struct kunit *test)
>         kunit_put_resource(res);
>  }
>
> +static inline bool kunit_resource_instance_match(struct kunit *test,
> +                                                struct kunit_resource *res,
> +                                                void *match_data)
> +{
> +       return res->data == match_data;
> +}
> +
>  /*
>   * Note: tests below use kunit_alloc_and_get_resource(), so as a consequence
>   * they have a reference to the associated resource that they must release
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 0fb2771ca03e..82019a78462e 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -689,12 +689,18 @@ void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
>  }
>  EXPORT_SYMBOL_GPL(kunit_kmalloc_array);
>
> +static inline bool kunit_kfree_match(struct kunit *test,
> +                                    struct kunit_resource *res, void *match_data)
> +{
> +       /* Only match resources allocated with kunit_kmalloc() and friends. */
> +       return res->free == kunit_kmalloc_array_free && res->data == match_data;
> +}
> +
>  void kunit_kfree(struct kunit *test, const void *ptr)
>  {
>         struct kunit_resource *res;
>
> -       res = kunit_find_resource(test, kunit_resource_instance_match,
> -                                 (void *)ptr);
> +       res = kunit_find_resource(test, kunit_kfree_match, (void *)ptr);
>
>         /*
>          * Removing the resource from the list of resources drops the
> --
> 2.37.1.359.gd136c6c3e2-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220721180214.3223778-3-dlatypov%40google.com.

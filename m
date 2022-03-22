Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8D64E364C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 02:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiCVB6w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 21:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiCVB6v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 21:58:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157344762
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Mar 2022 18:57:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x34so18832612ede.8
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Mar 2022 18:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eu82S/LN4yJm+Zr0EcUu+NKIR8yR7yewIFipExmLnts=;
        b=tmn+mtJMulOY4ofwfJbO4qp0DVMbyuIKSSmBHV1gWJExoLcc7Iwt7juvCR29p6Zn+E
         /pa85Rd+BUJTwgk/hmZonCLc8mygujG71WvK48iP4C0PgmkPKXK+fLBS/JpdVMP333Cd
         mu8g594S706CMxBVum1OZLOHnNLHZkV0Qh6UbjvxSUPRhRngWM5Of3D3WbTcCTr6M2Ds
         KKUkHEsUT5nLtsK2wxFlcjsGD1UNtWVakR2lB7fBVSMN8yrNTyXLjz+SOlox1wxh6lJf
         nX6JL3+TScbK0E3r0BHM1N/uqnqbrJejp8WCzUxtGQZN30pdXoDSW/pI43IFJSYToSxg
         eD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eu82S/LN4yJm+Zr0EcUu+NKIR8yR7yewIFipExmLnts=;
        b=Js8Zfj8i5COJqBmwQWcVYBj1t52T4+jeGI/oQ9007Oc2D8fJgShxCj4JIeR2FoIbKp
         FWeOEednR4n5YZWQAR/NVnIMhq/OzhvjMVvYajCeDrPhtDlrX0rRI9n1qukYe8LKHhhL
         IvFN/eRKt4hL3Qc7r/Q3Eu7fxlB4yBErjnBW3TIl/+5lKU/2YlFEARhm2II49QOjxbGS
         bzHudXgfXU9xcIcAQ1mV0Q95j794P5cEgWdra+JCmFvlILSh2NxYmDiUvjtZBiwpRrfq
         yPNLiqX2CixMW+13kS9yYUMsuKw8YIlfSmH3MapNrlkHoMF7IyGvh7e49f2yPQ46K/ry
         a/EA==
X-Gm-Message-State: AOAM531mz6VyIXeuDUxvlQb7waqgLsMRLedkKw+HhfqpzitU1xS6vflY
        sRZb2v3h3OaUHNSVpj9F6znlxv1JH/4nv6S0nhzecg==
X-Google-Smtp-Source: ABdhPJwzSc/GZd8LazoT4/186Ywwiur0zNxKFcTZRVyPV67hq7en9ZiuaQL3z9vYLMlCA0awd1KOQow2SsyGRB9CQbs=
X-Received: by 2002:a50:c307:0:b0:418:ec3b:2242 with SMTP id
 a7-20020a50c307000000b00418ec3b2242mr25864060edb.229.1647914243135; Mon, 21
 Mar 2022 18:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220319055600.3471875-1-davidgow@google.com>
In-Reply-To: <20220319055600.3471875-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 21 Mar 2022 20:57:12 -0500
Message-ID: <CAGS_qxpqcc8O2HpmF3qB-uzXZrDNg9=h3nE_f7si=aOxXkRA+Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: Rework kunit_resource allocation policy
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 19, 2022 at 12:56 AM David Gow <davidgow@google.com> wrote:
>
> KUnit's test-managed resources can be created in two ways:
> - Using the kunit_add_resource() family of functions, which accept a
>   struct kunit_resource pointer, typically allocated statically or on
>   the stack during the test.
> - Using the kunit_alloc_resource() family of functions, which allocate a
>   struct kunit_resource using kzalloc() behind the scenes.
>
> Both of these families of functions accept a 'free' function to be
> called when the resource is finally disposed of.
>
> At present, KUnit will kfree() the resource if this 'free' function is
> specified, and will not if it is NULL. However, this can lead
> kunit_alloc_resource() to leak memory (if no 'free' function is passed
> in), or kunit_add_resource() to incorrectly kfree() memory which was
> allocated by some other means (on the stack, as part of a larger
> allocation, etc), if a 'free' function is provided.

Trying it with this:

static void noop_free_resource(struct kunit_resource *) {}

struct kunit_resource global_res;

static void example_simple_test(struct kunit *test)
{
        kunit_add_resource(test, NULL, noop_free_resource, &global_res, test);
}

Running then with
$ run_kunit --kunitconfig=lib/kunit --arch=x86_64
--build_dir=kunit_x86/ --kconfig_add=CONFIG_KASAN=y

Before:
BUG: KASAN: double-free or invalid-free in kunit_cleanup+0x51/0xb0

After:
Passes

>
> Instead, always kfree() if the resource was allocated with
> kunit_alloc_resource(), and never kfree() if it was passed into
> kunit_add_resource() by the user. (If the user of kunit_add_resource()
> wishes the resource be kfree()ed, they can call kfree() on the resource
> from within the 'free' function.
>
> This is implemented by adding a 'should_free' member to

nit: would `should_kfree` be a bit better?
`should_free` almost sounds like "should we invoke res->free" (as
nonsensical as that might be)

> struct kunit_resource and setting it appropriately. To facilitate this,
> the various resource add/alloc functions have been refactored somewhat,
> making them all call a __kunit_add_resource() helper after setting the
> 'should_free' member appropriately. In the process, all other functions
> have been made static inline functions.
>
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Daniel Latypov <dlatypov@google.com>


> ---
>  include/kunit/test.h | 135 +++++++++++++++++++++++++++++++++++--------
>  lib/kunit/test.c     |  65 +++------------------
>  2 files changed, 120 insertions(+), 80 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 00b9ff7783ab..5a3aacbadda2 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -36,11 +36,14 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
>   * struct kunit_resource - represents a *test managed resource*
>   * @data: for the user to store arbitrary data.
>   * @name: optional name
> - * @free: a user supplied function to free the resource. Populated by
> - * kunit_resource_alloc().
> + * @free: a user supplied function to free the resource.
>   *
>   * Represents a *test managed resource*, a resource which will automatically be
> - * cleaned up at the end of a test case.
> + * cleaned up at the end of a test case. This cleanup is performed by the 'free'
> + * function. The resource itself is allocated with kmalloc() and freed with
> + * kfree() if created with kunit_alloc_{,and_get_}resource(), otherwise it must
> + * be freed by the user, typically with the 'free' function, or automatically if
> + * it's allocated on the stack.

I'm not a fan of this complexity, but I'm not sure if we have a way
around it, esp. w/ stack-allocated data.

Perhaps this would be a bit easier to read if we tweaked it a bit like:
"freed with kfree() if allocated by KUnit (via kunit_alloc..."

Maybe we can drop the "or automatically, if it's allocated on the
stack" as well.

A bigger way to simplify: perhaps we should get rid of
kunit_alloc_and_get_resource() first?
It's only used in KUnit's tests for itself.
They could instead use kunit_alloc_resource() +
kunit_find_resource(test, kunit_resource_instance_match, data).
We could even define the helper with the same name in kunit-test.c
(the only place it's used).

Alternatively, we could make it an internal helper and define
kunit_alloc_resource() as

void *kunit_alloc_resource(...)
{
   struct kunit_resource *res = _kunit_alloc_and_get_resource(...)
   if (res) return res->data;
   return NULL;
}

?

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48A84E5C1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Mar 2022 00:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241563AbiCWX6J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 19:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241213AbiCWX6J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 19:58:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFDE6E37A
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 16:56:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z92so3700818ede.13
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sr7J4vfXVHgXl/lrrjqeau5g6gjXQTlIBcP0OGTYE7A=;
        b=ofKf+l9lFhG9+K+rNIAmI2pVWAmDdvO4SuuOzCqfEAZh19RvYXvwX9dN95tGecz9zp
         cP8pKxJYxc+10Y5e867EQHrFkZoI0W/lkKNCZ22jgq5+fk7hymMoDNSvkSgDFiNd4Qun
         8EnP08Pyj0kFbpC9eeT56GLMozN6uPUtGMvI0Cux46JSg1m1N5N4aVl0JllB9T2V9bUi
         H4iUnV2Qh6X3qWJPn6VnVkmZyy3N85cKj5vluNr0HZvBS+O7hCdhHE2ezLM52r86H3hS
         I+CeIidoIprZIiKiPll0gmrJet47VYgoUbYlAnMqJEdRTMRE/sYUfMVKo2UlHfPHZrMb
         pviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sr7J4vfXVHgXl/lrrjqeau5g6gjXQTlIBcP0OGTYE7A=;
        b=sLUmWLPKXga0lxs+NSPhsAP0LYmIjiRPyw09Tc6Kjq6h7llPzwLv+C9gnTrAmLJl7g
         n/1KYkX3fmgX4M9JilBqeU7FA1X40niBN6vziTkrDCqrmdJ2BHgBJY6/XC+lyvIogn4T
         AobAVxfpH4bu61VWGa98t5eXiFe3NStctl1Gl5bBbYrltlP4AEPtqd4++38ohFGpz568
         WqLNudAPnknWvL0Ujl8W66cNNJPJtEjUIM1+R17vKv1no43Z0bWu/3GCmBGyM3oq2Nvt
         0GoVOrvW4xekDVM4kjjUCI1C0Z+Ux1ni98KB35gyUJhSTGhe5Jb1CGUxlLOZLkzAUYr1
         ieyQ==
X-Gm-Message-State: AOAM531jN6qdwZxLda+GQv+jJIFi8DcpEJW12fi2/TCjricgTuYCOknt
        3H0cNlcktR/+x6hazmTRelo4MlQIp50U4PRzU3FFQw==
X-Google-Smtp-Source: ABdhPJyNvKik3+MBbQKpWReI26T9y3k0RGMXxOUvfjslYhOAJGNGwznYbZ1Rv7IrggHj0u9f9Sncg8BmrR7L9rtlmWQ=
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id
 ds1-20020a0564021cc100b004132b12fc49mr3463086edb.118.1648079797217; Wed, 23
 Mar 2022 16:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220318064959.3298768-1-davidgow@google.com>
In-Reply-To: <20220318064959.3298768-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 19:56:26 -0400
Message-ID: <CAFd5g45V6P9ATGQ3kqkuFLNDB=_01gws8Ldr1kH3j+r0aSZ-Og@mail.gmail.com>
Subject: Re: [PATCH] kunit: Make kunit_remove_resource() idempotent
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
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

On Fri, Mar 18, 2022 at 2:50 AM David Gow <davidgow@google.com> wrote:
>
> The kunit_remove_resource() function is used to unlink a resource from
> the list of resources in the test, making it no longer show up in
> kunit_find_resource().
>
> However, this could lead to a race condition if two threads called
> kunit_remove_resource() on the same resource at the same time: the
> resource would be removed from the list twice (causing a crash at the
> second list_del()), and the refcount for the resource would be
> decremented twice (instead of once, for the reference held by the
> resource list).
>
> Fix both problems, the first by using list_del_init(), and the second by
> checking if the resource has already been removed using list_empty(),
> and only decrementing its refcount if it has not.
>
> Also add a KUnit test for the kunit_remove_resource() function which
> tests this behaviour.
>
> Reported-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9910F5F5B1A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 22:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiJEUja (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 16:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJEUj2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 16:39:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ADA476FD
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Oct 2022 13:39:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ot12so296811ejb.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Oct 2022 13:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g6s7DJKavkP6Wy2PCKjnIW2IKB4P0bWvffwW3eMp+yI=;
        b=DBO3i9LoxZwL9VONd/WY01Ix6CFiUp0JklwT3uV0W6Zbp1Gqi9bQH4adXbZqV2I3eq
         7ZdyJCgkzFThHHUEocvVBJ1ZSUKnjCZ85Rl7tbWysqMnXNzJwAugLi6JVEcpFTN0Spb8
         /RP0sQgCNYQmKaMMSZyU4HIgAyeIbf73CEFFMh2C7q8e0p4aCW7sDlF5BwTijKZgCEN5
         HoDYOmZrPJjk+PH3bCd12Dv4bNWNy0JdvlAufb3BEFe1Osiylv4QDq81pxncn6wHfmOB
         iFnatp9zkEo/wqVJGds9FBHl/8FgpGS0iPdkzF24tpp/c1vckPparQvMDFBGnKBAsQ55
         GIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6s7DJKavkP6Wy2PCKjnIW2IKB4P0bWvffwW3eMp+yI=;
        b=ypsz0sHtA3ySCnVHhKgLSzU4bqU6K31Gr1aFJqUfFhi/RyUA9CIuoXn035yGeUgWRO
         vzEr7Lg4LzTKMPNwTSSPjj7M0XTOq06QrC5L7MtMQ/suce+B1Jl5ssZaQ33nNpdj57xy
         uyBKbhguTOozl+EXKFhp5haJppusOv9HUdSmO4BzXVJj5qwApp0tFsYcCHtPU3nWb6/P
         Onfbb2ve4W8ST+tcVJ9FeUXYtWIbqUlR1AZKdSIRzqnh+8b5K7KONwhaMF9NiDd+1uQ8
         EA6xHHBmyf3u1llpqqzYaX8Z0StOmBN4GzkwemToGfNVDZd+nkzXeSqO5XgiUVF6AUyI
         iWqw==
X-Gm-Message-State: ACrzQf0JUM8kvaUXaTLQu75z/tlYXPrnLE0U11Yxt8/2Ml0AVohlRpBy
        HobVBjoiCifH5hJcNfhJ6wi4ZQcvbWXenfd3gZnk8w==
X-Google-Smtp-Source: AMsMyM46SP4qUvEeA8KOjyNhY32AbAj+OwOgWsw5GUBSdT76g50q1ZBZGMW18xC4yRrG4qFyC3mq/IM7gF91OyOBXLs=
X-Received: by 2002:a17:906:6791:b0:78d:4051:969f with SMTP id
 q17-20020a170906679100b0078d4051969fmr338628ejp.171.1665002365425; Wed, 05
 Oct 2022 13:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com> <20220722171534.3576419-4-dlatypov@google.com>
In-Reply-To: <20220722171534.3576419-4-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Oct 2022 16:39:14 -0400
Message-ID: <CAFd5g47-EqGY4ZwaH_btjhweFSqjLZ=3cq8M26pvf8yuwL3Qhg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kunit: make kunit_kfree() not segfault on invalid inputs
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 22, 2022 at 1:15 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> kunit_kfree() can only work on data ("resources") allocated by KUnit.
>
> Currently for code like this,
> > void *ptr = kmalloc(4, GFP_KERNEL);
> > kunit_kfree(test, ptr);
> kunit_kfree() will segfault.
>
> It'll try and look up the kunit_resource associated with `ptr` and get a
> NULL back, but it won't check for this. This means we also segfault if
> you double-free.
>
> Change kunit_kfree() so it'll notice these invalid pointers and respond
> by failing the test.
>
> Implementation: kunit_destroy_resource() does what kunit_kfree() does,
> but is more generic and returns -ENOENT when it can't find the resource.
> Sadly, unlike just letting it crash, this means we don't get a stack
> trace. But kunit_kfree() is so infrequently used it shouldn't be hard to
> track down the bad callsite anyways.
>
> After this change, the above code gives:
> > # example_simple_test: EXPECTATION FAILED at lib/kunit/test.c:702
> > kunit_kfree: 00000000626ec200 already freed or not allocated by kunit
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

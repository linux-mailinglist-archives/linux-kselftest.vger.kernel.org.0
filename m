Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5EA4ACA89
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 21:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiBGUrr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 15:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbiBGUcK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 15:32:10 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B87C0401DA
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 12:32:09 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x65so496013pfx.12
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 12:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1P8hA1j9aywFJgfHjGYLfcilDGyQWP/oEP/rL7ICpyg=;
        b=C06fimZteiDPoqZEu2rPd0hp5X05Xu0F8lNukNvXrC+SHmbeaRXXVOOPeN18tKtywR
         P1+CY4LIGJR3E4i+nMbWJgjXQLn0rgLLAbMXyEDV7jWHBD66bf1bRgmGfwSbPpsJCu//
         FFlgWppTLm/5QqkvSGU/tM/Y1y30kZ6w/e+cqsczks/n8G2VRUX/Yr/7QKsOHOcJLe9F
         WOO+bGwKVmf4WWCoOSQ7ilLPzkYbMmeyT0lNJONAGNKITT6/PApHfzpuqUHjixPw373F
         9/1MDyR0oQawyfmi+5YY2P/IDWOb6kQsvefxAMaUCqC4FSpSOwFSgQ2flSnipZz5F+Rb
         MRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1P8hA1j9aywFJgfHjGYLfcilDGyQWP/oEP/rL7ICpyg=;
        b=p7PCzOxUFzy+/oBXnZEEHpZXervSaZJBBirbRjxwsX8Xu1kARMjRm+LRNXLxq9Fgks
         wVGBYSwIYi48MdmgDG198GJB71hT74zhBD9TfEZGEywqioONwCjEcyvn/LIyz4uHIwZU
         iTVcsKGxicNKuzbcB5LGih8NfAExIHkkfP+eKDgQc9USo4EMplgonh106nrFM79Ds60R
         AkYzZtoWjzck5CzrhiixmgIT0TjNNQu0O+mmjqsDoy4MmWd0BBzzPywNyhHzlvXtInKc
         sO+RTYYv9AMq5re2UgXVTyBVtPwEQXt6FqxphfjG/1GKa0Wo7R75GIGtW1Mcp6vn37N5
         FnPg==
X-Gm-Message-State: AOAM533OgZUAzk1BA6MGyH5LSc9i26wcm9C11W7wtlJTOQYbe2sNL36c
        E+DIe7eiLwBJnv1WjN6nD50KBG+9Rdaj0Ln8o7Nbxw==
X-Google-Smtp-Source: ABdhPJzdiVW/zhtdK0Fc+Zk69XCZxEluVIICSO7cBbOk5Z3lLzYGJkWJ/w2d7cthfjL73eD7SoteD4xaEYUlVPSO2Nw=
X-Received: by 2002:a05:6a00:1508:: with SMTP id q8mr1109927pfu.3.1644265928635;
 Mon, 07 Feb 2022 12:32:08 -0800 (PST)
MIME-Version: 1.0
References: <20220207112043.397074-1-akirakawata1@gmail.com>
In-Reply-To: <20220207112043.397074-1-akirakawata1@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 7 Feb 2022 15:31:57 -0500
Message-ID: <CAFd5g466EGdOvvAp8t1tZDe4ks1XgJpA1Hwouds+9ASjznxhFA@mail.gmail.com>
Subject: Re: [PATCH v1] Documentation: KUnit: Fix usage bug
To:     Akira Kawata <akirakawata1@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Feb 7, 2022 at 6:21 AM Akira Kawata <akirakawata1@gmail.com> wrote:
>
> Fix a bug of kunit documentation.
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205773
>
> : Quoting Steve Pfetsch:
> :
> : kunit documentation is incorrect:
> : https://kunit.dev/third_party/stable_kernel/docs/usage.html
> : struct rectangle *self = container_of(this, struct shape, parent);
> :
> :
> : Shouldn't it be:
> : struct rectangle *self = container_of(this, struct rectangle, parent);
> : ?
>
> Signed-off-by: Akira Kawata <akirakawata1@gmail.com>

Wow. I can't believe we let this go for this long...and even after
doing an *almost* complete rewrite of that page.

Anyway, thanks for fixing this!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

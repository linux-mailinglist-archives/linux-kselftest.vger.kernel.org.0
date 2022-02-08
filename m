Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940124AE428
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 23:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386972AbiBHWZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 17:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387022AbiBHVqp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 16:46:45 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FE4C0612BA
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 13:46:44 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c3so495149pls.5
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 13:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eN+hmNONJyG0na16U/kNOjqhgqoQ8Ez+z5PohZnpZkE=;
        b=LNQPpQeD8iyN++3r8W02WPfs6uZofuPIvByExxMAWF0qDNj4IzqjIBr/W4NTXrsVCZ
         kjpNceWCbdR5x2EpmL07tmFDmI0wGT7HTbOEds+oWrY3xOrZ2BTS8NJq87UZu8DyVOpy
         LxcQj/f1C0APcdVz+CzaIwdimXcBaKvXCQsif+vwRxBmjLIiKvoR65m8+jsQjmx2wGmR
         R1wbVEKbYlrVxRC/jFnmTnULNV9KkWHChtx4i0Ir45fiLL52uRY8LKiwJ64/Mo2I+mZj
         ba7ar8tKS6y9kqQ8NJdQYOBNQYHls9d6zsJoXQGvy71lMsuUIUKxtup00ETxuIq/ep9n
         /Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eN+hmNONJyG0na16U/kNOjqhgqoQ8Ez+z5PohZnpZkE=;
        b=MTJ6t03Qxc/ost30jXsHJGpf8DK7QNAMyTNfk7fGAW7GDnnYXPH601b5u6RD1FjMBn
         +FgUSS22UjlknMrVhFcQlJsQFR2YaACpfFBDcVWrKEIbsh+ujGgXQOyBeO/9wKRLO44H
         fA+CIcxNWjvW/C+L9Uy4quge//vt9SwcyvfGZ43yZ6vVP+YYbxLYsqbcCkroMBuTwb2B
         dkRSA2ATS1iSHlPoAbulTtinHX+1YEVdhBNQIbxVC15ikwvNkkWvP5Je9HtGQC80n5HI
         4YHWqi8qWrF4ZgDP/yXjBYZR4Ug5cpkv9LZYwRwoixHz4A7dXUlkjB9la5fIsjRRLern
         /ptA==
X-Gm-Message-State: AOAM532M7EiVzhiQ/aRJpmNdbUIgg9EUBQMTG6sBIoNjMAEFLW8jF/of
        bYJanJHXBlS/tQpbhGhm0C6fMvbsMEO9Ype2KL7N1g==
X-Google-Smtp-Source: ABdhPJzU8YEy66gam05lnihXH2xqumQUZnJEaa4p6ds3bkY2fyLPDZAWJ4qmz8U1JK3UJhmcPIm38CMIVYxZyGLqMFA=
X-Received: by 2002:a17:903:187:: with SMTP id z7mr6391730plg.123.1644356803467;
 Tue, 08 Feb 2022 13:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20220208040122.695258-1-davidgow@google.com> <20220208040122.695258-2-davidgow@google.com>
In-Reply-To: <20220208040122.695258-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 8 Feb 2022 16:46:32 -0500
Message-ID: <CAFd5g47dbWswjdidj-sGJczsCBe3cDG32SO-WEsjmR8HsB6aXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] list: test: Add a test for list_is_head()
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
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

On Mon, Feb 7, 2022 at 11:02 PM David Gow <davidgow@google.com> wrote:
>
> list_is_head() was added recently[1], and didn't have a KUnit test. The
> implementation is trivial, so it's not a particularly exciting test, but
> it'd be nice to get back to full coverage of the list functions.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/list.h?id=0425473037db40d9e322631f2d4dc6ef51f97e88
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>

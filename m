Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C29376B0A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 May 2021 22:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhEGUIl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhEGUIl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 16:08:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C6EC061761
        for <linux-kselftest@vger.kernel.org>; Fri,  7 May 2021 13:07:41 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h11so8863858pfn.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 May 2021 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YrDqJx93OwdWCfFkXfyEoTQC8negd4/G/SopvOQHRnA=;
        b=Ljvql2B1pthM67CXVupOIxAd4PFlEjAG7Pu1s/nfesxhIUrpDmA9WLsAC/Y3bUo89g
         L/ffu8tDadfJ+pxidn0DVYDIwFBhXtSReZRTWroN+u3PhkNwNVTXhAH3sTK0Vm+2a0cy
         W5eEohTjs00P6IN84pcyoz+qPDTHRCv0pINXFVh6whjkUtKZBscI/ZFkKDBIFWPJ704G
         WT+6V90c0iJ5r4KzivNgjybA6tuK2SztLgLIufQhkGbJAOucXLb2x/7GEEPhPXiryx8P
         cSOx8FmuoQ8Unp9GRkbXh/ngSaNhviDcjeY2MP/OUTHI7Lp6FVj5aIKS0AxY5L54uUk5
         VNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrDqJx93OwdWCfFkXfyEoTQC8negd4/G/SopvOQHRnA=;
        b=tWshW8rM6KErt7x66yTLgKlU73f8FdsgMPrryNSK2PTuV+ctKtkzAUhkoKlXmK2ZuQ
         J9c9rNDJOb4DFPZ7stwE9mS2IoUNnypltARILdnCqOmbqqqY/MsDknUe47yjB4HxumdA
         qaOKTQhvbvDk84uHImllJtc1RxS1SCfPs7e8PWpY05wkUAYyyWGc28PY9Rn2+2ID1dsD
         XBYmxzE8x55Ak3uc7qwssTO88KHuzdpcVa/j1mVwKuBxGgw4PGxZlEY6s5v4LSaFe5oL
         95IJGgUbFylGzOVFvaSvJwLvABkkNrLhPuHlaDjc2043nlAAf77CHpc9xiL9ptXmTBzT
         5v6A==
X-Gm-Message-State: AOAM530eQF0mRkgQq+JLZCOpp13guLWxjnzsrRrETvq6D2akR+62fYSX
        stwrY+3yRuvVg5uFvVse8TECWZgccHJN/esbXhAoBw==
X-Google-Smtp-Source: ABdhPJzT1xB3lzIA3Cm3XMfODY+rxABey2UGk2x5NFeuPpU8S2XsIfS2S3qp0oopN7quK7JnoLOGgAhPmWRj87DEBTA=
X-Received: by 2002:a63:cc11:: with SMTP id x17mr11654985pgf.159.1620418060779;
 Fri, 07 May 2021 13:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210507050908.1008686-1-davidgow@google.com> <20210507050908.1008686-2-davidgow@google.com>
In-Reply-To: <20210507050908.1008686-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 7 May 2021 13:07:29 -0700
Message-ID: <CAFd5g47NR_OKQfxDxc_PnXKCbkKNUeUH49Q6k6m=70C4uhQ0xQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: Assign strings to 'const char*' in STREQ assertions
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 6, 2021 at 10:09 PM David Gow <davidgow@google.com> wrote:
>
> Currently, the KUNIT_EXPECT_STREQ() and related macros assign both
> string arguments to variables of their own type (via typeof()). This
> seems to be to prevent the macro argument from being evaluated multiple
> times.
>
> However, yhis doesn't work if one of these is a fixed-length character
> array, rather than a character pointer, as (for example) char[16] will
> always allocate a new string.
>
> By always using 'const char*' (the type strcmp expects), we're always
> just taking a pointer to the string, which works even with character
> arrays.
>
> Signed-off-by: David Gow <davidgow@google.com>

Aside from the nit that Daniel pointed out, this looks good to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

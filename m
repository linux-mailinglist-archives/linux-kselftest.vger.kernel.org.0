Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150BD3A05A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 23:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhFHVY3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 17:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhFHVY2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 17:24:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F761C061787
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Jun 2021 14:22:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ei4so121967pjb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jun 2021 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=071Uzgb9AY+jh540o5fVaKWqKER6FWRCb0I4nIFdjJE=;
        b=TKjkBp9vgc4xMse6tHrX/f3ZDC8j76Em477PbsmPyUVQ7nH+4VC5ZxOg4PReHbo/NH
         lxuNaMX1h04Jx/bod2jnFQy+ao3Q8bSxG1DeCUA6RxgVUK8FNhTL2+Ave95+vZ/bN6Pc
         +xIQY9/0NXfrgFUU7wEyUBQpFUXgluDifoyPx5VqkLZXC7aC1zV4/XarSse38ZX+3t8b
         qD1lYQ3ZxzVn3LedPy2rNclyJFH5bR0UbNqZveFwqRzJ/TZJM/Pdew27EtB6cfLiqalW
         FTc2g//nGSc9UZ9bWOEIzZZ7hsuDM0+DoK9YaJP2wYXqJPGhS4Zw/k/IQjyyhMAfZNe8
         h2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=071Uzgb9AY+jh540o5fVaKWqKER6FWRCb0I4nIFdjJE=;
        b=ejdNU8ML/703z5o44xQIW2rPiGlYMppv82mq9Reuce+v+j9n6BVI+3iXN36JCCAVGW
         9j5p2DZOgB1Fbpgem7fLr6TtYhGGvidwe555pb3iGqdbQ2s14eGFgX5YO9vVg1xi4mLx
         CEYDPrFF+iLIyzsPYaSy1S2aecRbWlV4C/0KK9mPZSQQH7CjxhO45oH7SO5GWva1B7zr
         YqspkSQOHW9B1c993Nz71E6HENRmSsDwApBZxb3SmbCc0myDsShVxhd2j7ngJr26T8sg
         +PLB7wnNk9B56JQ1ayR9v3v+owZ6Six7E9fPgvjdgOcfUP1t+KSaZmKbWL/E8UJv2+jM
         fhcA==
X-Gm-Message-State: AOAM533+ox5vVKu4mSI+zZ59TfWRxugkmMsBm3o4EY47UGT5+xzSkBFL
        7Lomxgy+P86NnzRaJecMYp7sl6TNjM3CPSuOImAyaw==
X-Google-Smtp-Source: ABdhPJxTN0nT9qC3EjgYzKw7fEO3F799lJjsHiLV+0TAjjn5yW4tlFXulzVcdqGfplgk14yWVWBPIB0xEWl2tgDe9lE=
X-Received: by 2002:a17:90b:47c4:: with SMTP id kc4mr385967pjb.217.1623187352663;
 Tue, 08 Jun 2021 14:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210608064852.609327-1-davidgow@google.com> <20210608065111.610297-1-davidgow@google.com>
In-Reply-To: <20210608065111.610297-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 8 Jun 2021 14:22:21 -0700
Message-ID: <CAFd5g45PkKjU5mH2n9EJcJGLDnjJ6XZJ6HLxPP5a3pw6qQ=g5A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] kunit: test: Add example tests which are always skipped
To:     David Gow <davidgow@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 7, 2021 at 11:51 PM David Gow <davidgow@google.com> wrote:
>
> Add two new tests to the example test suite, both of which are always
> skipped. This is used as an example for how to write tests which are
> skipped, and to demonstrate the difference between kunit_skip() and
> kunit_mark_skipped().
>
> Note that these tests are enabled by default, so a default run of KUnit
> will have two skipped tests.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

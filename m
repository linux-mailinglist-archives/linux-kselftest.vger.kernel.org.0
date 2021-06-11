Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09033A4AB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 23:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFKVnh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 17:43:37 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:39429 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFKVng (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 17:43:36 -0400
Received: by mail-pj1-f41.google.com with SMTP id w14-20020a17090aea0eb029016e9e0e7983so60440pjy.4
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jun 2021 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTtVmQE1L0tigro9e4OhQHUvzXLTzBpGS5nmzldfqwc=;
        b=jJx0bhHT/QYKG7u09mfetN83sWnyZl4PppyYjtMbKsPHfgg2j9ZKiCmUh6A6ywKXYM
         PoMXSabPZ2Xe5Qod9BdxbY2OR2loaiT5hgB5SGZsWejMtOR9eQvY+kjmozqDCS4x5q4y
         nmkXMoNVDFNjXIdXDVaviSUjYLD48liOSqII147GBFEFD70fyx2lHtFcyOOSJRaSLwlp
         f7HpaUMCB6Srlbys2kMB2iZowXinKsQDQ/8My0RmLXtcH5wdZTIBzBgK7/70c1jGDQsr
         hbnTOgZtGJmj8y/6vAbNRl3oZmfBWArve8Sv6c5Wbfj7Mvhi2Xr+GNj6fpVmfDArxoYb
         5J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTtVmQE1L0tigro9e4OhQHUvzXLTzBpGS5nmzldfqwc=;
        b=r6UPvz0PW5d53QrzOwl3pBWADADSgNV4Revj/jte03pAIsuHc2dtIjb0zaH8o/VLNE
         srbTbP9P5Qwt6FnZmio6/Y4lYT4ZV2/nkn6uDfvRvWugVx5a05RKJ3uGsrZMRmnggzS1
         bRRlsX35v3EyL3yiRqwCHR7sWl2uykDwoOlzdvQdOXhEbzJ6q2lW/5/HxjCLonTZZUES
         FrQyvvOZDtzhm3XubB50tAHiE3wCucd9NLBWQtU8r54qBeSMuiDH7RmsOLt8bKZYploT
         bEvGXqoIYT9oPV6hBJa3MO2r0QsjzXX2rAaCIpR1QZehB4/RkSo5ajjREoXNaJuQz5fs
         WMuQ==
X-Gm-Message-State: AOAM530xEwvYXElB07anA5bFg0b2R5jOlAPLyWQQSJ7/qzIm0KJh57v6
        gdfDaxUOQpHRBYksOqz6BuGA4PJM3FA2uvtN4jeMDw==
X-Google-Smtp-Source: ABdhPJxYQ6rOcj/Pc8nl677xEo50DjwzTY7i/8/w0rKNj2bfYjXeh5/9H1wA16r+c5rLPBLU/bkVky4FgBu2rALP5Ac=
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr11053249pjh.217.1623447622921;
 Fri, 11 Jun 2021 14:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210421020427.2384721-1-dlatypov@google.com>
In-Reply-To: <20210421020427.2384721-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 11 Jun 2021 14:40:11 -0700
Message-ID: <CAFd5g44TNA7G1mos-f3N87p5BoVnc8ffoyDWN2ikeGc2WKJOMA@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: add unit test for filtering suites by names
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 20, 2021 at 7:04 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> This adds unit tests for kunit_filter_subsuite() and
> kunit_filter_suites().
>
> Note: what the executor means by "subsuite" is the array of suites
> corresponding to each test file.
>
> This patch lightly refactors executor.c to avoid the use of global
> variables to make it testable.
> It also includes a clever `kfree_at_end()` helper that makes this test
> easier to write than it otherwise would have been.
>
> Tested by running just the new tests using itself
> $ ./tools/testing/kunit/kunit.py run '*exec*'
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE903B693E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jun 2021 21:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhF1Toy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Jun 2021 15:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbhF1Tof (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Jun 2021 15:44:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A12C061574
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jun 2021 12:42:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v13so9534180ple.9
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jun 2021 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjGlaXcqvudKX33z/RwB9jCslwfmADWtBbTwqHYvPzs=;
        b=MV6IzLlAlKnm1q3c4aLPsllvsLDmyRAv/FdjB2hh0QaLKMlC6Tn7HpaPXQ/uO7FFgX
         dnyMZ52oDyeKzgGVl+6/uFjAcX7Ageo2VPkk+E5viqp+HLSQYW38YHoavQTSahva+oWu
         wT2Q3tsSUhFv4cyCUaXZum5nmeZ9T2joIwFHCNLBfaUcCFkz/dpf5IKgWx6deWz0h1Qb
         cJqJQ9RaL3GMyzShUGJctdq7vOAI6uyPB2RTUl3UmrrIcJkDa0KtfH/YEThVMYYC+h6B
         YXbkk8KE4/GmE6jdKZH6z80quqO9xq4YGSBu971vA8VvAjzpYOBQqb5TrmhgD4x0aDem
         XCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjGlaXcqvudKX33z/RwB9jCslwfmADWtBbTwqHYvPzs=;
        b=Xmp8jYvzlntepDhXrMA9c7jMzI5EwtzXnDRx1sWBYGkNu7zTNDaLYSJiMw64UwNidW
         PxCEo6LcT9Sw6YmGQQlJFW00VOnEe+SsCdZrSpGqYfDZmzX+8P1KHyOvGcZCzkyUkjTD
         XhzoiOqGWJhEtkblOSJHTHvTVEqEt82ZPfygydOQA/iOIGzB0f6c5XyRyzvQShHwavR2
         AXJqSZFAkSsvWfWDD27Fh9Jx6ZKSwqb542/X/sIpq7wYDnR9J16zDvBd211sUK/YFORz
         /FMjayW6XT74xqzsHYed2roluhZIyM6Pb+C/bjC5bPUQU3lXKT3jjSrhpAxzsGnEZDar
         dzfw==
X-Gm-Message-State: AOAM533mrnoXIhIkphYjHyr0swg/rMmVzaewXwfmpjZcs8EZ8kxM2+cj
        oNYFgOZxX5U+RUy1aMswHndUoSqPx2YmbDRyHFJNWoYSpZ3smQ==
X-Google-Smtp-Source: ABdhPJwv14rBTtgg6oD0x6IW4cETXf8vqsei1g1BiBb5jobrzELCaRfP+u2iPPscADpEXM2xaJmLte1F0fIlFsnhDJI=
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr39790400pjh.217.1624909327367;
 Mon, 28 Jun 2021 12:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210617073937.16281-1-sjpark@amazon.de> <20210617074638.16583-1-sjpark@amazon.de>
In-Reply-To: <20210617074638.16583-1-sjpark@amazon.de>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Jun 2021 12:41:56 -0700
Message-ID: <CAFd5g44Y0a6HneG+RA-brhJSG+S7GEJSuwGgHCkFssy9vbmuzg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: Assert the version requirement
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     dlatypov@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 17, 2021 at 12:46 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> Commit 87c9c1631788 ("kunit: tool: add support for QEMU") on the 'next'
> tree adds 'from __future__ import annotations' in 'kunit_kernel.py'.
> Because it is supported on only >=3.7 Python, people using older Python
> will get below error:
>
>     Traceback (most recent call last):
>       File "./tools/testing/kunit/kunit.py", line 20, in <module>
>         import kunit_kernel
>       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 9
>         from __future__ import annotations
>         ^
>     SyntaxError: future feature annotations is not defined
>
> This commit adds a version assertion in 'kunit.py', so that people get
> more explicit error message like below:
>
>     Traceback (most recent call last):
>       File "./tools/testing/kunit/kunit.py", line 15, in <module>
>         assert sys.version_info >= (3, 7), "Python version is too old"
>     AssertionError: Python version is too old
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Acked-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

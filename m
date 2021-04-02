Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BE83528E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 11:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhDBJfl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 05:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhDBJfk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 05:35:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E12C061788
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 02:35:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id g10so2292096plt.8
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 02:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vzsll8xm6IiKjDMVW+o/pjkDPKy52BSlu05WlFxYDWg=;
        b=lw0EoYhqJhGX8SPEFLmOV2btucFVHF3pktGUDsEVTFu3pt8yUUSZy7cAvgaDfvR/wP
         xtR2oXP0UxmsNz/e5J3oep5W8dky162AggYzpXTzzKtQm3bJaYAImta+BhNk61Eyz0/m
         Ci5SAKFD8IQ195z/q5IuGYbvBPQEs80uw1YRlncD+f12QbzmlFkWouVVfb230H7sce/9
         lsoC7fM2LzKkqEanro9zNu8535k78ZvoJDFBaKECHuYAzzZn868JmoDfcY2cUJqp1pKa
         aIK9xso8t7epicH4BMctN8ad18wNKnie27XxBdMW06Bo6dZEiPCDarJn1TfiPi7Y2hf5
         pWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vzsll8xm6IiKjDMVW+o/pjkDPKy52BSlu05WlFxYDWg=;
        b=EBDNge1waczepAzKzW5yLr4Zl38mBnojvl1FVx5KlmOH7VVLCCA/1wpOJf51fdE2xp
         5wUaPQIaMrTXwwona/l86u3COFwBJHzMQDAwBVS1yojnDMnkslC5qFqTWbpq2+HhAq8I
         ljIqDYMXpm53C9pdKs9pirKm8OAeCX22glono5TfSsVYjou1EGFi6pCNdt8x5SeHvm/R
         r7FSZyQYh3hBjYN92cqbzYcV4kD5bN0CWh9pvWaFunAj0slXq9CTljoFIFLtJYSQAaTF
         sNoY6rf+EwtOxIzAuGyL8CjSXwP7u8japz4Zd7r6JRBN6oCskUo7hbtgiKdLb/gsb4P/
         OJ3g==
X-Gm-Message-State: AOAM530kutkyFOYCY8rjJfjqig8MAwgPN/uypHfN1vkiDYcxdn0zBsgr
        V6KAxDfpj2Rd3GEoCy6ec1WfqsAwwc8AwR5b/vZxYA==
X-Google-Smtp-Source: ABdhPJxtHQje2ABPOvATkPWo/tuEsAUSHxdTmSX3fcinRyWYKyVYdH8MLsgXx00XcN2QGccrBXldJbWqUGGpXAQL0MI=
X-Received: by 2002:a17:90b:100e:: with SMTP id gm14mr13135037pjb.217.1617356139684;
 Fri, 02 Apr 2021 02:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210205221808.1966010-1-dlatypov@google.com>
In-Reply-To: <20210205221808.1966010-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 2 Apr 2021 02:35:28 -0700
Message-ID: <CAFd5g44PL+DrN6+0bw-oYQCjCSR-f4Y0=QZL9DsSO-3hKLsFzw@mail.gmail.com>
Subject: Re: [PATCH] kunit: make KUNIT_EXPECT_STREQ() quote values, don't
 print literals
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 5, 2021 at 2:18 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Before:
> >  Expected str == "world", but
> >      str == hello
> >      "world" == world
>
> After:
> >  Expected str == "world", but
> >      str == "hello"
> <we don't need to tell the user that "world" == "world">
>
> Note: like the literal ellision for integers, this doesn't handle the
> case of
>   KUNIT_EXPECT_STREQ(test, "hello", "world")
> since we don't expect it to realistically happen in checked in tests.
> (If you really wanted a test to fail, KUNIT_FAIL("msg") exists)
>
> In that case, you'd get:
> >  Expected "hello" == "world", but
> <output for next failure>
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

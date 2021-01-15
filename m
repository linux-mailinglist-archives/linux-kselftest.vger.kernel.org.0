Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9F62F6F93
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jan 2021 01:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbhAOAdy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 19:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731360AbhAOAdx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 19:33:53 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90862C0613D3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:33:07 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v19so4880183pgj.12
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUYuR2ZeWLptFmzH3l3TxUNJHP8jNhkIOgD1q5XF+v0=;
        b=U5kaSqU8NQDpq76/j18K7dxeOJglQrK99pkGmnUZR/FXs45wKVYSR94rtZFjcK9K1Z
         4yVqX3WwCVn+iB7gIcNvhVmYHef6YlxZ+uzlq3kAfG8f/TQQoInFTfKkXeE0vv7FKhYI
         C5jwWk7N2pTgLlO9fbJd72AaQxodANKXQBEyjY4eFeub7Tp0QhioMBlEpRhmQeb2leMx
         yg5T7mAzDcZ2GswB1B2ILYl8Fw6+1/M3xwFOaHR39jcVDgV6I/vuTyCVcDaeCU21y3le
         E79Vy2d8MCcEE5RyDVpaZ03C/G/TZL+wc3AoDN1LUFyFpuK9/z4eWzVxVlKuwVzZdsp8
         Mekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUYuR2ZeWLptFmzH3l3TxUNJHP8jNhkIOgD1q5XF+v0=;
        b=uXn9E8ve8GP4Q4LxJfUgcRqMRi8F3Tcx1XcHj96C5cQiPNSlj04uyZ7INKujkynm9w
         RsjJHHk47P47zsLK1zTeup/3RUZKgdSF8QA9ssOlu2TtWXd4oySP9EAU3fC7FLp+zgqT
         EsFZv8nl85xcwfoAU06NKOrgoBGl2hQQWE17vdFzPck1AtNR4+i84zXkk1Th/jlclaBA
         wDib4e2LvK9/IAJ63cwHTSgxlOYvKriPUn9Z0CQcSaMIJt21F5b5m2GvoojJE+AJz4JA
         ZrKYdKsgdglYj2rgna07G+Yr0ieAH/nXm/XKW+Mj/dd3viPzgYVNUy+Z0nl2EkfVvAOg
         1mrA==
X-Gm-Message-State: AOAM530H6EknPDAk0WcQahPWGVaU7/oX+Goj6W63aOvtNcfHeYbkwY+7
        QSr4v6JhRUfnccXjfVQ1jSM+pKu9R5F4vo30I09FyA==
X-Google-Smtp-Source: ABdhPJxiw+7lNLWGAXohSizZByonl5S2vkEz0rosqq3HNNMmooo8tSsJAke6QQYufha07Hf147tzvepTZ7ftpd17nl8=
X-Received: by 2002:a62:1409:0:b029:19e:14d1:efb0 with SMTP id
 9-20020a6214090000b029019e14d1efb0mr9763585pfu.14.1610670786880; Thu, 14 Jan
 2021 16:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20210107234803.1096592-1-dlatypov@google.com>
In-Reply-To: <20210107234803.1096592-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 16:32:55 -0800
Message-ID: <CAFd5g46uH=ax-L=pn84HNPHoesxsQ9JB_LsQ945OORHL9dNVOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kunit: tool: surface and address more typing issues
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

On Thu, Jan 7, 2021 at 3:48 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The authors of this tool were more familiar with a different
> type-checker, https://github.com/google/pytype.
>
> That's open source, but mypy seems more prevalent (and runs faster).
> And unlike pytype, mypy doesn't try to infer types so it doesn't check
> unanotated functions.
>
> So annotate ~all functions in kunit tool to increase type-checking
> coverage.
> Note: per https://www.python.org/dev/peps/pep-0484/, `__init__()` should
> be annotated as `-> None`.
>
> Doing so makes mypy discover a number of new violations.
> Exclude main() since we reuse `request` for the different types of
> requests, which mypy isn't happy about.
>
> This commit fixes all but one error, where `TestSuite.status` might be
> None.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Hey, I just tried applying this series as a pre-check before sending
it off to Shuah and it no longer applies to torvalds/master.

Please fix and resend.

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1592A1037
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 22:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgJ3VaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgJ3VaL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 17:30:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ADAC0613D2
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 14:30:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so6395953pfp.13
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjmEB7ML8A76tYf15cPdMqWAjbK6bmKqWgyuNYqIBIc=;
        b=CPWb9cJUgtOiRRzAbplZg4Ai1ao0hwkIeTOYc/zm4ByL0ilvvFth5rqKoxH/TZfcTE
         3l5K/KHlSTZxSLnCPM+5sXlyBykTZQVK4gRV5vCQ366vRI8O3I7CZwitIhU+ZsAO5uqy
         RnwM5+h9IxmWqHXKCe9kVr62xLqeK41PcYZSvG7161XG8r7NxUyULofh11MA5yDJjuy0
         nJpSDyCWNjk5oN6HAXEyAqb4LPEabbepDIAcSpb15xRwy3Yz0B0P4iyr60z9uawTxqiS
         pyKG1yl4UKpl7zslezWF5Qpr9sCDF286JzgGiT2X469qSv3/20V3aWEqYDv82SEwYRzr
         TJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjmEB7ML8A76tYf15cPdMqWAjbK6bmKqWgyuNYqIBIc=;
        b=smafNdFhOZ5ndEs5cq8pUrs860UHctVgEWKJ2X9oFyIiaLuo2ra+BJTSwvKyc0dzgR
         63iQMwwaO7DNQ5ntdqdYh1gVip/q1WtQc5jwzQxdbIFz30PUB9bscCrR5+KZ12qwiIHg
         cyHcZIa0QugpRARu3IOMTdTl4ec7CUxke01gbD/vdX2fsoGjM9tlQgycfpU/XyzUtKFS
         hfyJuo2+fDrkRzj4hX0Jey58rQ/J65YybAoGdmhxAKQS48s3EqXFBVsmA+KuzQWFMxuT
         lVg95EOGJD3vpxMvmplm7uCZfOpFRq/iSU0sXf8Fs4/uEiNI79mRalpBh4dMPzoF0ysl
         0kNQ==
X-Gm-Message-State: AOAM532JacYznpxGtHsHQF/cL6kIh1X0/llnhBRarxmmumxsxiohU38/
        AA1G4wWIPv+87NW79NQiZ8v8R486MQNs8FflgfOuaQ==
X-Google-Smtp-Source: ABdhPJwg4+VmigRzkoFUVVKyXyFxSQPGF8SA25QIhIAnmnWbbpqt7e3iaixL8SLndSc8wx9gkRcciamapNY1C6tOC4c=
X-Received: by 2002:a17:90a:6ba2:: with SMTP id w31mr4929444pjj.80.1604093410695;
 Fri, 30 Oct 2020 14:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201021071603.1558098-1-davidgow@google.com>
In-Reply-To: <20201021071603.1558098-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 30 Oct 2020 14:29:59 -0700
Message-ID: <CAFd5g465ugc3RTsEEoyLSsujsWcMU-VOCXNCdwO8S_NWLQMDcQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix kunit.py parse subcommand (use null build_dir)
To:     David Gow <davidgow@google.com>
Cc:     Heidi Fahim <heidifahim@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 21, 2020 at 12:16 AM David Gow <davidgow@google.com> wrote:
>
> When JSON support was added in [1], the KunitParseRequest tuple was
> updated to contain a 'build_dir' field, but kunit.py parse doesn't
> accept --build_dir as an option. The code nevertheless tried to access
> it, resulting in this error:
>
> AttributeError: 'Namespace' object has no attribute 'build_dir'
>
> Given that the parser only uses the build_dir variable to set the
> 'build_environment' json field, we set it to None (which gives the JSON
> 'null') for now. Ultimately, we probably do want to be able to set this,
> but since it's new functionality which (for the parse subcommand) never
> worked, this is the quickest way of getting it back up and running.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=21a6d1780d5bbfca0ce9b8104ca6233502fcbf86
>
> Fixes: 21a6d1780d5bbfca0ce9b8104ca6233502fcbf86 ("kunit: tool: allow generating test results in JSON")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

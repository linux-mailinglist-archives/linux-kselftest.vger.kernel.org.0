Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAA2326949
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Feb 2021 22:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBZVQN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Feb 2021 16:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZVQM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Feb 2021 16:16:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A9C06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Feb 2021 13:15:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u12so6614766pjr.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Feb 2021 13:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1DCugY7nfGPlh0RsF/P/DUQ/DpETMGZNMe6SSWPONk=;
        b=ETnajUSpyPDXlQiMPMpvJQjrFljugoohqFjR7dfUvU68cqUNbueOrgmyDurxqzOC6f
         B0tff3iVjEx+Uz4LQJOEpieGmDTEGvuNIs0m81pNtRYxChqGZfflyM1txFl+2YKzHfKo
         R0eGySN4teux/RCpImQ5qDpJAZvS4h9zKOGXkipkBSMKXkKqmKzmE2ORb/spDhkm3Bs2
         LXOLeSsEdgCUVJFA/xGwWiFGgQz/8FemOI67VseRRJyn0v811KGAhQb3nfUzR9xdQGwC
         21TJ+mwrlGh9B3Bc/0mCZv29gfdd7ZKUAUW+n/2//qDJzZfn0sb/QZkBlg52f+9uHf0/
         IJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1DCugY7nfGPlh0RsF/P/DUQ/DpETMGZNMe6SSWPONk=;
        b=CeyAP+UZjtc5Decf4rfRwkGcucyjXDQk3zqqyE3Z9v1nIsAdNB1UNiwHWYSx84kqEX
         wu0n/3dLzDKClM5kWghzGvs6ExU4QiGVrJTlHcTtqru0w0O/8f7SUjODlPgLboMc/mgS
         b9mtrxfWyq2K1zgDLgjnhp3IRBep9AgKdOzhhDohx1uB8QBVyt4SwDgCADu5A+evI0S5
         u2aytU27uCOB9X8Xnu+PCXaCrR4xcb6pX/Y9giOBx67RMzz4mVG+14NkqMaeVTR5uWso
         Q1509zw8vYb2D5YyiK5lKVFUfZdZunUdunbQY9r3d/J4f3Xl/o2wEUP0nKvtGE+IWj2M
         nPPQ==
X-Gm-Message-State: AOAM5314zG7flL9SXBb2TXtpa39rfCADYDvQmhEXJJ97H4DaZ0YwIPp6
        di6LayEaUh+/8BhTPztNPrRo1kHCmOYaHWG8QAz70g==
X-Google-Smtp-Source: ABdhPJwgWrxD4a9n0QqaXmwRN3ppKgZODWrAWUEMdrhfNFlIG5pmeWEVZ9zmATpNJt9ZvEC/8EbU+jCGq7XIhEr+9PE=
X-Received: by 2002:a17:90b:4d05:: with SMTP id mw5mr5274229pjb.217.1614374131505;
 Fri, 26 Feb 2021 13:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20210223054930.2345555-1-davidgow@google.com>
In-Reply-To: <20210223054930.2345555-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 26 Feb 2021 13:15:20 -0800
Message-ID: <CAFd5g458LTmSZ98WGcMSGzd2LnxeLdOj2U2KU3mN-DBNsz9fkA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix a python tuple typing error
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 22, 2021 at 9:49 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> The first argument to namedtuple() should match the name of the type,
> which wasn't the case for KconfigEntryBase.
>
> Fixing this is enough to make mypy show no python typing errors again.
>
> Fixes 97752c39bd ("kunit: kunit_tool: Allow .kunitconfig to disable config items")
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>

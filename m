Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7D03A8A62
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 22:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhFOUpH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 16:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhFOUpG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 16:45:06 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D406C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 13:43:00 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x14so544836ljp.7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aqm3c2qOnl4GWZupmWMl9hpbbY4c1oMhOiFiU4pgNkk=;
        b=GZe1MlCCYVjAi3Y9QbxHMleA6Ye9M75hPx2adLRRDHf8PVVmNRD/2BdWo9j8yvgPY0
         GVq24Mw8nVCw/Zm2+0cg1aG04HPlTeygJU3fIWr4n5NV1u0ny61VFMf6nZ8spFQicoQA
         OT+u1Kos1NqfkbRzYXx0EKIQ9xn2GengEohNrmsTSdPmeqlpC5ycA07YmGNk+s6icDhd
         kFU2420qzYYlsDGKMVY1vAZ/kvsLIyFio7o+4jNUTVIqpU7ZJmZhCYAugh+80N+qnSF1
         /5Hk6Aom5zF5hsw9F30XYkMX7pS+UW6O/pgo7JP8z/8dqWNulOrrNHEvUduJa06p9xzi
         NJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aqm3c2qOnl4GWZupmWMl9hpbbY4c1oMhOiFiU4pgNkk=;
        b=MnfrYuEI7GBWLRL1vX1d4kSwwzvuDufyufhx1J0FeN6NxDKxRWcWnUrwA9412yamAM
         kWBoKcFIUBsB8OrVAtjsEJsShiAFeHUPObTMQo6jGUQbtGEDiQXgMHWmtbvgN010VM8D
         RDoPJdywfHcy1Jv/oUbo8E/yMWyK0KzD8JduIL+aygoc+/CRg7LrUKNW/3G8ntgmRo/A
         W9kRHatbbzqoL9wsjCiuNO9sAHbwBAWX67NnNYGmySdC9vY1Vv/hzAsY0uya0LmaJC0L
         CA02IS79Wi3Ntsksa5387BVI+LuDgOjZjwJxp6yTsIm+DnDU7+6i+7rXCYC79bm3oISk
         BFFQ==
X-Gm-Message-State: AOAM532Gcnms5rAIGFxVY0CMjmAqx8ByivZINYNYb/G14cSpC44wF9Fw
        d2nsMgsGgO4iI/1tvsD76JY7x0BFqcjAP0rdCpwNPw==
X-Google-Smtp-Source: ABdhPJxImyZregK3iW0mXtOPpsGsqIE9KD9HgUCIO2diVvuKaRiWl/gc2yNFy4J590BQMK2kt68KmybMHLb7U1ZLM+o=
X-Received: by 2002:a2e:3506:: with SMTP id z6mr1398170ljz.238.1623789778388;
 Tue, 15 Jun 2021 13:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-10-davidgow@google.com>
In-Reply-To: <20210513193204.816681-10-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 13:42:47 -0700
Message-ID: <CAFd5g46HMPCBiMwQwGb1cyy4JCrD_Ep_1ofaKGjF04N_P9xu-w@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] lib/cmdline_kunit: Remove a cast which are
 no-longer required
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
>
> With some of the stricter type checking in KUnit's EXPECT macros
> removed, a cast in cmdline_kunit is no longer required.
>
> Remove the unnecessary cast, using NULL instead of (int *) to make it
> clearer.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

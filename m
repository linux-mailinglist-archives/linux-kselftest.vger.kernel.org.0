Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348BE326903
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Feb 2021 22:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBZU6Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Feb 2021 15:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhBZU6Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Feb 2021 15:58:24 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD8BC061574
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Feb 2021 12:57:44 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d12so4520162pfo.7
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Feb 2021 12:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QMAOY4drkfNnT/pMZYqvSvr0Wi5l1ir4k0oC/IvcDeM=;
        b=Bfj2DXRzoHStywHZk3W7HzxtJMF2ixlieWXuktuWJp0tsgE9p+zTZukKWxJeO8zKii
         Uj4DGjBr646LU92ldBHDWvPYA0t7sADaORnxRwRyOd6i43HRRLtvIOEjf9jeTjPB/dAC
         SVrrzek0B8o9fSGyp34VrfswjvdDVVL+rVdN3kAOMz3mJQLqX/QOaqbtt0YDlsE3gqez
         zaB3weUXtj2Q/nupsvCC8i2n2+7TSoMvQ8CKMAvemJ2by11tNDOx8yh0VyOOAxC8Xjzj
         dRtPCCKFS6d0kO+vZkikTWgM28JDMCSX4znbX6zVnaZGY0N5P65ga1qUX04h3xLiNFNk
         Fn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QMAOY4drkfNnT/pMZYqvSvr0Wi5l1ir4k0oC/IvcDeM=;
        b=TzGA4ks2aDDkcmxXw5Ouupt6YT88SszAHNZsc4QMxcA6SP48tV9L1zJbyVf8UWM+E9
         +g+ad/DYQL+rQzmkOyM4uOvIJH9ZQ/0rtOj+68zkqmhaqILTb0wc/mf4f5KnFszTXp0U
         rVo7BsO+F8zktp5SfSKYkzJL2zskiR0mFL7+P/3K2WUeDd3E50sb6FIqBi0eBabZ/9GK
         CvphYo0OllF1J6eYmY2m+8ZT8CzbFCR4Cpl6dejw1BTLy2jFJSdbYm7knUAICxZJiitg
         9Sk1qfVFRSlo1y+rGIVfXTZzEXJeHkuUuh1NEPkMwi5mOpmh4v56qs02nJ/PRHDcOPnl
         Vk6A==
X-Gm-Message-State: AOAM532cHmgZA7vZTbnvEcbeH8gdn6YLNvAU2ikbvvxCI0HFaBHzzjZk
        y83A1PCNRJBOA6wtTLsJVxJMpxETnHhRLytGla2mQw==
X-Google-Smtp-Source: ABdhPJxTVttQ5g8I1D0ekj3rzfA6S7UdW2ambky8JEz2K9o9PXa2Lm2jPocEFKE1sUX9Iid27m3aRv0F0tV2sgQzdLM=
X-Received: by 2002:a63:fa4d:: with SMTP id g13mr4457814pgk.201.1614373063558;
 Fri, 26 Feb 2021 12:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20210209071034.3268897-1-davidgow@google.com>
In-Reply-To: <20210209071034.3268897-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 26 Feb 2021 12:57:32 -0800
Message-ID: <CAFd5g47=Tzsj+yw6Poj47Y68__eYnrWhOxfSmvCLwsgBvfn8vQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Disable PAGE_POISONING under --alltests
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 8, 2021 at 11:10 PM David Gow <davidgow@google.com> wrote:
>
> kunit_tool maintains a list of config options which are broken under
> UML, which we exclude from an otherwise 'make ARCH=um allyesconfig'
> build used to run all tests with the --alltests option.
>
> Something in UML allyesconfig is causing segfaults when page poisining
> is enabled (and is poisoning with a non-zero value). Previously, this
> didn't occur, as allyesconfig enabled the CONFIG_PAGE_POISONING_ZERO
> option, which worked around the problem by zeroing memory. This option
> has since been removed, and memory is now poisoned with 0xAA, which
> triggers segfaults in many different codepaths, preventing UML from
> booting.
>
> Note that we have to disable both CONFIG_PAGE_POISONING and
> CONFIG_DEBUG_PAGEALLOC, as the latter will 'select' the former on
> architectures (such as UML) which don't implement __kernel_map_pages().
>
> Ideally, we'd fix this properly by tracking down the real root cause,
> but since this is breaking KUnit's --alltests feature, it's worth
> disabling there in the meantime so the kernel can boot to the point
> where tests can actually run.
>
> Fixes: f289041ed4 ("mm, page_poison: remove CONFIG_PAGE_POISONING_ZERO")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

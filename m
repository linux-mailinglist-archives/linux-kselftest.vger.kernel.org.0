Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2823820EF1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jun 2020 09:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgF3HPl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jun 2020 03:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgF3HPl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jun 2020 03:15:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0111C061755
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jun 2020 00:15:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so18497934wmf.5
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jun 2020 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qomXq2ActQZN/6bFPVvt+u08Ypzth62dhj61jRlqIqg=;
        b=mHPPQN9W6sb5xzGjh62onzl2oulcD9KtmeoN3pj89jyErg91srjiDxZWGa0QP4AU81
         hNytKu4gO1Hf57LjmGAHupV3KhZ6p7CP5e2bf1da5aZ/2Z8cECbVqs1BBE0k2MvEYqYS
         AN13UDyfULgP0X2RttKExd9B7DOT7Y79cE+/fIOh/sYi11Hkq0VwmsCYk2uA/11QhZQf
         capG494GGtRpc/Iecx47e5KMHddbnKyn/QXCZkCqBhw2n1GIR7jnkgI4Gtr8lyi2rsBX
         5S8tnxAbcNGgp/h3MCUI/FhDtuUhaGODB7BFHDnSfKDU+7ImIZu6J1q0Ec9+OQ4JXn42
         Kbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qomXq2ActQZN/6bFPVvt+u08Ypzth62dhj61jRlqIqg=;
        b=UrMimxwIZrMz2WOejtxJNaXvWV2VfYAdgPlQwfm77S1uIiZzsiVwS25Xck81SZ6YsB
         jXyzBtTjKTxWHw2mGHPymjJcXjYGBOchRHgSJjUZtd3UK/8m6R61j2fISJlNMDIFf5S+
         jbDP/Cm9e3eQmH60S8ck5tn2ZNNPv2ZBGhxz4m6nTIGyCmRkpMH2RwlWSI86EElHQzIJ
         tOCJTo7EMhaXqKrlfwj1uiRWwU84RQ+kchoygPV5tCO38CFLECXpKS/d2lKK/UtFgyf+
         7Pr2CYpvJMC41twUnMXFPsb9Iq+ZjWCch8+m37A4BFA4gjOBltPR3N6yrzRkNGWf/vps
         3vKw==
X-Gm-Message-State: AOAM5315EipP/eOIVGTJYf7JZ1fwQoQyxuwTxy3ALh+E3abquDW5CpsE
        mrJAr8WuOXqz2eFMrxcnQtq7SiG30dMyqWMC0KtT0Q==
X-Google-Smtp-Source: ABdhPJyKohk0LvsHxuOJ7RF09tiNLq0s5bjM/CBQtjGt7EOC+N3RWtGru1+JzCh2phyG6SALIaXkSdAO0MtBxqVEh7s=
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr5429652wmb.16.1593501339411;
 Tue, 30 Jun 2020 00:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200607215715.90981-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200607215715.90981-1-rikard.falkeborn@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 30 Jun 2020 15:15:28 +0800
Message-ID: <CABVgOSnqyqg8xPT2wM=taN2=pPTAm_ySD-WscHuBW175QipuEw@mail.gmail.com>
Subject: Re: [PATCH] kunit: kunit_config: Fix parsing of CONFIG options with space
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        masahiroy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 8, 2020 at 5:57 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Commit 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is
> updated") introduced a new CONFIG option CONFIG_CC_VERSION_TEXT. On my
> system, this is set to "gcc (GCC) 10.1.0" which breaks KUnit config
> parsing which did not like the spaces in the string.
>
> Fix this by updating the regex to allow strings containing spaces.
>
> Fixes: 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is updated")
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Tested-by: David Gow <davidgow@google.com>

I've been using this patch quite a bit, and haven't hit any problems.

+Shuah: Any chance we get this into the kunit branch sooner rather
than later? The KUnit tooling is quite broken without it.

> ---
> Maybe it would have been sufficient to just use
> CONFIG_PATTERN = r'^CONFIG_(\w+)=(.*)$' instead?
>

FWIW, I tried this myself, and it seemed to work, but I think I like
requiring the quotes more.

Cheers,
-- David

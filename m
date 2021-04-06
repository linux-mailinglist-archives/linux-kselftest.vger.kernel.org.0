Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BB2355D3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Apr 2021 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbhDFUum (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Apr 2021 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbhDFUul (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Apr 2021 16:50:41 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E05CC061756
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Apr 2021 13:50:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w10so5791174pgh.5
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Apr 2021 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45gywtFS7vFeJG2FHCl1wMYRQ5pWycXZasjRBGHBHf0=;
        b=DQUn8uT6mNsJry3m0l32a87qkver2AwRJ5w5tVFOLqqzJ4M3VwThuukE+Jdxl32/Va
         KapCQ25lXeJ88uZbko+guP9pgKtlWC/jCbWfS1Q3VV7CZNIX98BXHTf+T+6R78G9nLIs
         TA+jL0InTal86IrphFcPZA9dIV2QkmxnGsbRzUnurOBtyjYRRuTBgmorLHEoVizI7tYi
         Z5Azzkej/ufDyx1HQMEqGv5xUO5evgS9vILku1EONx5AzPHSpJOdZqanA+UTIk9obKOM
         nV7pXGBOWUZQGsC7XFaUtmxbSyW5Qf6MuHrdJ8O3zG/Tmyr6l1gccgQUqwA3WncPM8XL
         N0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45gywtFS7vFeJG2FHCl1wMYRQ5pWycXZasjRBGHBHf0=;
        b=XxanFNTiY50wViivmdCpmNVKkvCSVYfZzfYaOUMCiJnoF7WEGgByZmNGvbE41tDtiH
         auy/a/U/R19lafRwDTeErQoFDfLWJIb456+pAME5ntXtfWzM7Id/vlQKE5u/mCSsC2ID
         B6y4F9Ia3BQRyYgbYTYEqQ541Ui58BvWBf4F0cNiZHtUrpa2qt6JosqCZJ2j/Kc3+YNf
         FifhWRjlidz5eLsneNkE2SIgHZIFc9q/H5QcwNgPw3n3wnEAEJnMhgaXM3uGBH1EuXKk
         Us69x895Ha1+lgdHCfsTRQBPNI8BhluVHF3Rh5XrbzLWY5lSjVDRuqc1E2rwT3JTkx7A
         iFXw==
X-Gm-Message-State: AOAM531QCpzOumYPN3OZ23kPty/cXI9l0nLB1FlrM3s67uIUO9Mm0OMc
        BIgdvqqgqmvEXJZQPjPivDqPh97Q2zLzy30bGOdWgg==
X-Google-Smtp-Source: ABdhPJy/QPOsCWYwjuBu6gg6eN7ce56618HZFTHEDxI8l0kKlNlQ3CKqwg9qjVReonlXkogTUCUmud4eu3ooOT/97nI=
X-Received: by 2002:a63:570e:: with SMTP id l14mr26828pgb.159.1617742232557;
 Tue, 06 Apr 2021 13:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210406172901.1729216-1-dlatypov@google.com>
In-Reply-To: <20210406172901.1729216-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 6 Apr 2021 13:50:21 -0700
Message-ID: <CAFd5g472E_Q-CoM2ONNONP_oeGZe0HGpNdqVhyRkKhP74b7h7A@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix -Wunused-function warning for __kunit_fail_current_test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 6, 2021 at 10:29 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> When CONFIG_KUNIT is not enabled, __kunit_fail_current_test() an empty
> static function.
>
> But GCC complains about unused static functions, *unless* they're static inline.
> So add inline to make GCC happy.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Fixes: 359a376081d4 ("kunit: support failure from dynamic analysis tools")

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

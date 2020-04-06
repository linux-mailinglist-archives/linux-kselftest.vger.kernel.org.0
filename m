Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423CC19FCBD
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Apr 2020 20:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDFSMQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Apr 2020 14:12:16 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40185 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgDFSMQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Apr 2020 14:12:16 -0400
Received: by mail-pj1-f68.google.com with SMTP id kx8so180554pjb.5
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Apr 2020 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ver6n6MUoiKJ9YQThw8+RbAg+VfgvE+bRaGA1TEZ9VE=;
        b=vQ3F4e20+rPDeXfCEpsaDzx4gn2vua9DgaFCprSToBwI20LZ5YB4UsBIJfyfRVCQw/
         Ink+pTcBBewybEaXx8NhUDqYX8w1Dw/rPVxpaIcMBOJUv/wyf3ZSTAsysrxDoksvoQSO
         fIQ4fEdj10/Ux4gC4Dwl6bekkG5P3XmylDoxXB/x1CZNeuPgacxGKd0niIyMFLCM0lw6
         n4KXDQTbJXV2JO2k6TDP7q2ntBK6053pabIyqsUvJS+migpswwmAjIk2FFPdLbXpEZ21
         Zn0OdSBc+7IDjqFnbKm82vd0w9UMPwNmD1cDMyreHkwtazMNAyR+RfJnBTfsPRxlF3Lk
         vwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ver6n6MUoiKJ9YQThw8+RbAg+VfgvE+bRaGA1TEZ9VE=;
        b=N4HxpwyfZDE3dUK9CvcaIiLZ/h4L5knD605iJtvPcsxiCD9LzkDrhUnzdUT+G9ljJ4
         0cfc8m49YE4skEvijQ3m08NuCJyMLBTfVv0LhtIsR+32yvHN9Oq1Ih0P2XTElbvFq2qa
         7ONTpjms8PNyb/x2hyWI6dOfLBACRaZNplITMeyjPmSpXFGF+TMpaMgkP2yehF63Th/1
         qLIbAyHV8o+5bqGPF0otZKtX1tht2HQO8nvR5MmuYx8oREcN3F14L6yIvI+PPijfW+4T
         Zw2ADSICNz9N/DXSf/V6+EGi/FBnEQjwU8kjiZX/uyDog3DGRs5jG+7ZFexcW+pJRFpB
         ytkw==
X-Gm-Message-State: AGi0PubN6JqdIlN5EI76PS/lltPJj3eztuMkgIzTZPwBqpr5KSP95fDs
        vD7/iCmLMJI2RVJXuo5DXKV628NKw3o2kfL7RpbEXg==
X-Google-Smtp-Source: APiQypKrJQ4k0jrnTIHHGTaNBKzi/QJwJ+B536oRq/t8JvxDSa97hNj3Szu7UByf6aPQ0mNLznHy80PVB1X5w5GHgBU=
X-Received: by 2002:a17:90a:9f03:: with SMTP id n3mr639147pjp.29.1586196735041;
 Mon, 06 Apr 2020 11:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200401013639.16388-1-vitor@massaru.org>
In-Reply-To: <20200401013639.16388-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 6 Apr 2020 11:12:03 -0700
Message-ID: <CAFd5g47Ot-MfxzYmU8kfxpfv2pWhgb_2WigouuHnPT+20Ejk_w@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Fix kunit.py run --build_dir='<foo>' fails on
 "unclean" trees
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 31, 2020 at 6:36 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Fix this bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219
>
> For some reason, the environment variable ARCH is used instead of ARCH
> passed as an argument, this patch uses a copy of the env, but using
> ARCH=um and CROSS_COMPILER='' to avoid this problem.
>
> This patch doesn't change the user's environment variables, avoiding
> side effects.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

Sorry for the delayed reply. I had two people finish up on my team
last week and I needed to do some things for that. You now have my
undivided attention.

So, I tried to apply this patch and it still doesn't apply on
kselftest/kunit. At this point, basing your changes on torvalds/master
would be fine since kselftest/kunit just got merged for 5.7.

Can you use the --base branch option when you send your next revision
so I know what branch you are working against (just to be sure)?

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53485F3D36
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 02:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfKHBHn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 20:07:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41580 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfKHBHn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 20:07:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id d29so2841905plj.8
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2019 17:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNYHIxb4w5wh5OJ2UcsY/rxFSYSM5NjM0g5yCBahmMM=;
        b=o1RBKYxFeem3vQdmMcb09c/Czaur5BjspbdukbuDfCPWavGuCZYv2d5eYk3lzUh5zm
         64GDst1itnU6KFqzbvLptz0a7TprmbEIfrVlckuFFjVVhbFLt4noKjbjPsr0C2VT7zs7
         oCXWMnTKo7jhXWG8Azi4vgX7U037o0KWgXiqfqk324fSvD+XVtYNGMlNsvtdRQlFlnzx
         XhjuZEhaqpSLjag1ZJGKxsH9Alr304AWYK1hlAREjI/7pwZH/cCON+gJC3eoMzy5jIvC
         XO2TvoGVoVH9G7xuHsfnddVQJF6HiX0rJKy4qOrdLFUwO9ViLCySgdXxB6CKMgB7DQ+x
         zuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNYHIxb4w5wh5OJ2UcsY/rxFSYSM5NjM0g5yCBahmMM=;
        b=fXQiqDmO85qrBSeWNrLBeJe8NQH2X+0NmQRXx/GUo64OP+fNqOGcjmfZfyAY70Aymn
         Epkwshlx9U+41CVOGgt4+/aFJS3kkXS6nooOnUSJKNUhjOO1FOyKgJJKrbqh0Y8p74eY
         RDrGBjXbHDJLEVrHePDYikqM6OV7Y/8hymK77Z5fJaI8P96n5D1OQIyrOr7sEQSmJgCN
         QX3zZ7yu7AXvPNELAQCgRpykpLKq4Ps5oopASDDx2ASahZvjwYt4VDCAXcgbwSIPoTGZ
         533yzkuI8uxVsBSPYT4gtPxWEzsaKI6Ds5trsiUhjkn+HuwFOOEwadpElvoWzYa5Nf0b
         EATg==
X-Gm-Message-State: APjAAAV7u2OO5mwZnbYZZi0uR7IvryOQCdSOo5/kAWg8JcFmdKHthQ0H
        0oUvIDu3cklo3B0iBwYVlh2LLjtpvQ8HtlkpoyzffDl9leY=
X-Google-Smtp-Source: APXvYqw+LoU/IiQ8hdHb0R4rY4nc0yI7TqoKto/BO3EMbJDNKkiWiBcBbg8Rvg4gxblStWoydjQcOZFgytKxwL5aXKY=
X-Received: by 2002:a17:90a:252d:: with SMTP id j42mr9572203pje.131.1573175262439;
 Thu, 07 Nov 2019 17:07:42 -0800 (PST)
MIME-Version: 1.0
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com> <1571335639-21675-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1571335639-21675-3-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 7 Nov 2019 17:07:31 -0800
Message-ID: <CAFd5g45qUkKMHizkmM6O54a3_zOjTN_PxDbD+bwHkgvr1wPrcg@mail.gmail.com>
Subject: Re: [PATCH v3 linux-kselftest-test 2/6] kunit: hide unexported
 try-catch interface in try-catch-impl.h
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 11:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> also remove unused kunit_generic_try_catch
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  include/kunit/try-catch.h  | 10 ----------
>  lib/kunit/test-test.c      |  1 +
>  lib/kunit/test.c           |  1 +
>  lib/kunit/try-catch-impl.h | 23 +++++++++++++++++++++++

Just wanted to say that I *am* happy with the *-impl.h naming scheme
here since there is a public header file with almost the same name. So
everything looks good to me with this patch.

>  lib/kunit/try-catch.c      |  1 +
>  5 files changed, 26 insertions(+), 10 deletions(-)
>  create mode 100644 lib/kunit/try-catch-impl.h

Thanks for the patch!

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E01ABD3D
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2019 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfIFQCk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 12:02:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36518 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730767AbfIFQCk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 12:02:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id s18so6130875qkj.3;
        Fri, 06 Sep 2019 09:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2UnQvaWbnmWdR72EwgKASOHbRdH1J70PBC+fpxUSII=;
        b=qN7r9oC+bbUMGjwHMWIX43aSLN9cHYy67oJoYdwWS1jmJv4eMaUNmCM55CQhUdcFOm
         2JniVTh1PwkCXZflPACkmAHu4EST1btre0/Pcurvh7L8ZIcSW/Y95z0Oer5+4kjUMO5M
         TVEjCvhs7tHPch0bAQ4Wg9KyP2wqmbXdq12clyHv74DqHod/rrRdMCZHsVtjZT8dVOTX
         cQ3p7NckH/LPNQB7wIV0BYcZEc0ccwAyiBykoNz3mo87/D2D3CJUu/1a+Iw5SaSAiVlu
         +m+xaH7LHBLQLyvaBULokv89M7kxnjb8+6oPpFv64xni8qyRCkyLZBHexVX0wDcj/FFq
         S3qw==
X-Gm-Message-State: APjAAAUBW+kk0okMj3QKuVopLpailBNKB8JMgiwKnjLqTEA+l14yY2qw
        KQr0MZLitKU2GME6bCdozRR4+R7WEo9V+7Jh8OFdsaWA
X-Google-Smtp-Source: APXvYqyOQtOjLTWW+COZnxCLc8XDIKJXqxS+DIdZttoPgrH1FkwVKGZoRXS19m2B5VoNat7566rsw+ZN+NUSRyoPhUM=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr9489423qkb.394.1567785759220;
 Fri, 06 Sep 2019 09:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190906152800.1662489-1-arnd@arndb.de> <5dfe1bfc-0236-25cf-756b-ce05f7110136@linuxfoundation.org>
In-Reply-To: <5dfe1bfc-0236-25cf-756b-ce05f7110136@linuxfoundation.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Sep 2019 18:02:22 +0200
Message-ID: <CAK8P3a3ynubySZ3A5M7D__B6R+caMjys=v+GVjqA78rppOJQQQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: add PRINTK dependency
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 6, 2019 at 5:39 PM Shuah Khan <skhan@linuxfoundation.org> wrote:

> >   config KUNIT
> >       bool "Enable support for unit tests (KUnit)"
> > +     depends on PRINTK
> >       help
> >         Enables support for kernel unit tests (KUnit), a lightweight unit
> >         testing and mocking framework for the Linux kernel. These tests are
> >
>
> Hi Arnd,
>
> This is found and fixed already. I am just about to apply Berndan's
> patch that fixes this dependency. All of this vprintk_emit() stuff
> is redone.

Ok, perfect. Unfortunately I only started testing the coming
linux-next release after Stephen went on his break, so
I'm missing some updates.

    Arnd

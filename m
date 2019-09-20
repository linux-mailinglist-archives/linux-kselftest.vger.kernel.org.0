Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3995B9518
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2019 18:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390601AbfITQSO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Sep 2019 12:18:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33836 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390287AbfITQSO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Sep 2019 12:18:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19so6160004lja.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2019 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/tRAwwujfBovXt36HtC9JZ/4MVaZlXqEF94BXjqBttQ=;
        b=OuqSL56Vss9lPTztD/skWobMCVipuMEUX9+lHEdLASwSyG2xgG8y/svapwJXwLJJ5u
         M79im92CVbCsjPjTYjVv8TYLIjFWLKAMMY6KVlzWgrt2X3MS5NS4puwacoKKKjsNj6mF
         Qa7CZgFDD3VTS2AuGKApg6P+YvbDbM9exl/2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tRAwwujfBovXt36HtC9JZ/4MVaZlXqEF94BXjqBttQ=;
        b=mk0Ir11tB0swWn2eQ/Sk88WPD7HX2qTuot8G79dXUwLtiP01tzbG7k3nT1tOmY5uVU
         JlhLVApkxRMF6YnoydnYitUH3a5hsc3MXoYaa1WO93wiFvnb7gktrHgaJRgSKMblPlu0
         AUKEyTOlhrzW5B+zcTPwLWG0WybhTwQOOiNWMvnYPKkVxB3LpDm3XmlgzkJlmCj96/9X
         0KVWJ+CJQRW43Eatje0NICk5PCXnVBD7HqxxihknwRfr5aEHaK60G/+8MOr/ojtngeqS
         BBEkMkafI2wLz8s3B6m+khGF/hXeJbdl+fW4fBPa7sulG9aXojkdtZW9QEktDcKuIBgg
         At9Q==
X-Gm-Message-State: APjAAAUSvivydt1/2l9Q8JylLj02OZDqTbvBhsHMU8DzIPHmhqSW1wd7
        hiSUqhUyVDiEFF1wyXa7QCZNjOjoNL4=
X-Google-Smtp-Source: APXvYqwQe5MrTo15gSOIrS+BChFkqCsXgJDPzztuF1EWT7S5rezEmC1C/0z1y/ATt3+yErs0tRzTDg==
X-Received: by 2002:a2e:9ac1:: with SMTP id p1mr3434684ljj.179.1568996291317;
        Fri, 20 Sep 2019 09:18:11 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 21sm537325ljq.15.2019.09.20.09.18.10
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:18:10 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id b20so2266479ljj.5
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2019 09:18:10 -0700 (PDT)
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr9721577lja.180.1568996289896;
 Fri, 20 Sep 2019 09:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
In-Reply-To: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 09:17:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
Message-ID: <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 17, 2019 at 12:26 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> This Kselftest update for Linux 5.4-rc1 consists of several fixes to
> existing tests and adds KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel from Brendan Higgins.

So I pulled this, but then I almost immediately unpulled it.

My reason for doing that may be odd, but it's because of the top-level
'kunit' directory. This shouldn't be on the top level.

The reason I react so strongly is that it actually breaks my finger
memory. I don't type out filenames - I auto-compete them. So "kernel/"
is "k<tab>", "drivers/" is "d<tab>" etc.

It already doesn't work for everything ("mm/" is actually "mm<tab>"
not because we have files in the git tree, but because the build
creates various "module" files), but this breaks a common pattern for
me.

> In the future KUnit will be linked to Kselftest framework to provide
> a way to trigger KUnit tests from user-space.

Can the kernel parts please move to lib/kunit/ or something like that?

               Linus

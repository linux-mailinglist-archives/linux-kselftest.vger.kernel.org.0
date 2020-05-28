Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5827E1E6A13
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 21:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406198AbgE1TH1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 15:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406192AbgE1THY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 15:07:24 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48656C08C5C9
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 12:07:24 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x18so10874220pll.6
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VwOVkU0O5MPTy6BNN6XbEIcSAUqdb5AHofI+QJezuPI=;
        b=uDW5ODyyxREse/z9nXtUVNzYSUM3rxmiKouMrW0jQ4pjS6v1fwxsd/yw3a/ZOhLjGv
         +jxGfyDsoKrn60aSTMmdCEZ2GchIZiuChuz/1AE6nf0dyurPkh4aVOWLNA/wdcuWoQmU
         oOrU3dKuigLmoTXchnDB47CeNglHPROppF6lxw+UKA//5w9cqkkW8LdHMQHyPK6SUGyO
         GCbw8fY9NUY6foqe4PtpNWnbJ82ESuHOCefXC/FkqMmVTJWfp1TBB+jyO+x91mphMZEI
         wdves0btscFepzUrFDrHsvalWOOYRZfS5Kyq0euFgY4kpm6EmhBKzRzD4vzd8i8gIdpz
         gLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwOVkU0O5MPTy6BNN6XbEIcSAUqdb5AHofI+QJezuPI=;
        b=MOKlVDQRQjxN+zxpfZtmRY7lLBa7ztSpd7L9vjfEpR7q46zZzurxDZkGVFczx1/njM
         lp8Oi2YqjaJ9nRrcsCLUbABDTwDzY3tzz1v0CtzxiId3gVdNDKcTtEcO24HR/PpSQggd
         9v//FOuzNalGAc3H/OMNL2Duj/Ht8b4gMiaPVMHhZemx94iAiBVnIKRvl9+EP3jyxZoF
         zPnlwIhgkz5gPtbW9m190cnIvzzMRuFdJhX5ag9wGg+hMuOCXzIteOUhHHqMUljsY6F6
         DlSyBFM4ELgwsXC47zOLqxDYQHgvPjZj582ZXL7Sr6umIuNVzJe/SAtslUjxHxmDaLNG
         V5AA==
X-Gm-Message-State: AOAM533I/myHev6C2T03DUFKlgo5KkuHUF5M9X4SuFGU4kqlr+6CZcqV
        /BAAVpBVSpas7+aTWPUMRCIDvrq1sFDyLmaMUjrwpw==
X-Google-Smtp-Source: ABdhPJyHjlcrtJrC+9HghnaFLvsYtvx90pMxGJn0t37UYFwj6H/4l9P4f/thKbVZ/294rQqkIqrgjWfA3AjwOQYQKbs=
X-Received: by 2002:a17:90a:17ed:: with SMTP id q100mr4950842pja.80.1590692843445;
 Thu, 28 May 2020 12:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200511131350.29638-1-anders.roxell@linaro.org> <CADYN=9LkA2h6dANREfPQq4iDvVEJX1wAdxjv31mpVBkaM_g0ZQ@mail.gmail.com>
In-Reply-To: <CADYN=9LkA2h6dANREfPQq4iDvVEJX1wAdxjv31mpVBkaM_g0ZQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 28 May 2020 12:07:13 -0700
Message-ID: <CAFd5g452oiRpMa3S=F9wFsb9SRKBYXJFuusge+6=zCEFX74kYQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Enable as many KUnit tests as possible
To:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Marco Elver <elver@google.com>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 27, 2020 at 4:49 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Hi all,
>
> Friendly ping: who can take this?

Sorry, I just reviewed the last patch.

Shuah, do you mind picking this up for 5.8?

> Cheers,
> Anders
>
> On Mon, 11 May 2020 at 15:14, Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > Hi,
> >
> > This patchset will try to enable as many KUnit test fragments as
> > possible for the current .config file.
> > This will make it easier for both developers that tests their specific
> > feature and also for test-systems that would like to get as much as
> > possible for their current .config file.
> >
> > I will send a separate KCSAN KUnit patch after this patchset since that
> > isn't in mainline yet.
> >
> > Since v2:
> > Fixed David's comments. KUNIT_RUN_ALL -> KUNIT_ALL_TESTS, and he
> > suggested a great help text.
> >
> > Since v1:
> > Marco commented to split up the patches, and change a "." to a ",".
> >
> >
> > Cheers,
> > Anders
> >
> > Anders Roxell (6):
> >   kunit: Kconfig: enable a KUNIT_ALL_TESTS fragment
> >   kunit: default KUNIT_* fragments to KUNIT_ALL_TESTS
> >   lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_ALL_TESTS
> >   drivers: base: default KUNIT_* fragments to KUNIT_ALL_TESTS
> >   fs: ext4: default KUNIT_* fragments to KUNIT_ALL_TESTS
> >   security: apparmor: default KUNIT_* fragments to KUNIT_ALL_TESTS
> >
> >  drivers/base/Kconfig      |  3 ++-
> >  drivers/base/test/Kconfig |  3 ++-
> >  fs/ext4/Kconfig           |  3 ++-
> >  lib/Kconfig.debug         |  6 ++++--
> >  lib/kunit/Kconfig         | 23 ++++++++++++++++++++---
> >  security/apparmor/Kconfig |  3 ++-
> >  6 files changed, 32 insertions(+), 9 deletions(-)
> >
> > --
> > 2.20.1
> >

Thanks!

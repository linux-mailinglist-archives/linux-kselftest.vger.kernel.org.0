Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A20169BFFD
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2019 22:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfHXUSL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Aug 2019 16:18:11 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43421 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbfHXUSL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Aug 2019 16:18:11 -0400
Received: by mail-ua1-f68.google.com with SMTP id y7so4447123uae.10
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Aug 2019 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zfEO+Of97f0VCldvVRJl3jzEF01O6soGli/loZclzk=;
        b=CiJfEFfo1GhUFTvULOmIWC5bky0UhNotA9EofhxO4+2Cd9KvnmBRPB6hGuQFhuAXwJ
         Mf7+XdP/Zb4xXtjIaOfMfbMaQpe98nHR1WFAIDUqUl6lSfoh5N6YkchHMEss2Z7wmXRv
         mIN1BXAFZpi+SynQvspsYrZxrH8jV01EUoqVt4oI5oVTwO6tctGVNu+Gx+DZX4YcnnWT
         pUO0Oeafs9qrk8HXoIhQUWukfn1efWZ6t1CZQkpVU6dxRoB/3gD8bO7d0APRfzkEuP01
         6A3Oop2AiXmYSlChvGG9uj5KK5z6ZoLIIlfJYts9owMo4k3T92eSIqfy7wB0W5m6uFPz
         fndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zfEO+Of97f0VCldvVRJl3jzEF01O6soGli/loZclzk=;
        b=q48Yk1XNqTzwVWcBY+1fAC6SiJf/LipQFDPUGokv8RvxcnFsPWFtojR6Tw+uQmJ0Ee
         dyzZ1C6InpmfBH+6ul4uxDC1I9K1GQWx2N+v6NDwKh6vu/agIUMxD+pk0zfudvNbgvjD
         DlXOnhzNp401IPI4MMSUlOOLlY/3OQ3YBSM9rRmh08aUjcetZ04ooRumbv+0wNm879iI
         DtI1nwS/HJkgFWWUD+Q6brL239be3mRROJJr9Hq6C5q9Hl7LGpXNPoHOh4Ck5E0hzbPu
         Uk0ELgevu3sUMddmiskRcKIKLH0e82CF5PPhEEG6NBtimltFBbqDl3pDzQs9vDotHmlF
         OC0Q==
X-Gm-Message-State: APjAAAU7wNPcibs2EzCHasA800Pl/tAoHVr+Y5dRkzY0jPT1eJ6xUD5T
        SWg5wsK/xGAhhW5Zg8m/d8gVu+D7c3EiEk9LlmXL7g==
X-Google-Smtp-Source: APXvYqxjVPBCRB+CRwr4t5I/R3fEcc9xAf9hOK0mmX0eHtTD2rTNJ8/siW0Z/MdtMGoJdUYWfX/KXqMK5Snr1pytTE0=
X-Received: by 2002:a9f:230c:: with SMTP id 12mr5623819uae.85.1566677889720;
 Sat, 24 Aug 2019 13:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190820033406.29796-1-cyphar@cyphar.com> <20190820033406.29796-8-cyphar@cyphar.com>
In-Reply-To: <20190820033406.29796-8-cyphar@cyphar.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sat, 24 Aug 2019 13:17:33 -0700
Message-ID: <CAKOZuesfxRBJe314rkTKXtjXdz6ki3uAUBYVbu5Q2rd3=ADphQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v11 7/8] open: openat2(2) syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 19, 2019 at 8:37 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> The most obvious syscall to add support for the new LOOKUP_* scoping
> flags would be openat(2). However, there are a few reasons why this is
> not the best course of action:
>
>  * The new LOOKUP_* flags are intended to be security features, and
>    openat(2) will silently ignore all unknown flags. This means that
>    users would need to avoid foot-gunning themselves constantly when
>    using this interface if it were part of openat(2). This can be fixed
>    by having userspace libraries handle this for users[1], but should be
>    avoided if possible.
>
>  * Resolution scoping feels like a different operation to the existing
>    O_* flags. And since openat(2) has limited flag space, it seems to be
>    quite wasteful to clutter it with 5 flags that are all
>    resolution-related. Arguably O_NOFOLLOW is also a resolution flag but
>    its entire purpose is to error out if you encounter a trailing
>    symlink -- not to scope resolution.
>
>  * Other systems would be able to reimplement this syscall allowing for
>    cross-OS standardisation rather than being hidden amongst O_* flags
>    which may result in it not being used by all the parties that might
>    want to use it (file servers, web servers, container runtimes, etc).
>
>  * It gives us the opportunity to iterate on the O_PATH interface. In
>    particular, the new @how->upgrade_mask field for fd re-opening is
>    only possible because we have a clean slate without needing to re-use
>    the ACC_MODE flag design nor the existing openat(2) @mode semantics.
>
> To this end, we introduce the openat2(2) syscall. It provides all of the
> features of openat(2) through the @how->flags argument, but also
> also provides a new @how->resolve argument which exposes RESOLVE_* flags
> that map to our new LOOKUP_* flags. It also eliminates the long-standing
> ugliness of variadic-open(2) by embedding it in a struct.
>
> In order to allow for userspace to lock down their usage of file
> descriptor re-opening, openat2(2) has the ability for users to disallow
> certain re-opening modes through @how->upgrade_mask. At the moment,
> there is no UPGRADE_NOEXEC. The open_how struct is padded to 64 bytes
> for future extensions (all of the reserved bits must be zeroed).

Why pad the structure when new functionality (perhaps accommodated via
a larger structure) could be signaled by passing a new flag? Adding
reserved fields to a structure with a size embedded in the ABI makes a
lot of sense --- e.g., pthread_mutex_t can't grow. But this structure
can grow, so the reservation seems needless to me.

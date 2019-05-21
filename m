Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347BA258DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2019 22:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfEUU3W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 May 2019 16:29:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46490 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfEUU3W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 May 2019 16:29:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id l26so14051077lfh.13
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2019 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwA8SKkNo0NB1BSSFbQlGkhBkIi6dkzdh19hX1ggqqc=;
        b=E9cuWHFCD4Bgx1lOv97Ctr9bLKO3EjHQDpiZyM5FZUFuOxpsSHENK8V3oPkAEWY2CT
         4OwJ0l1afyS0KlYgZEStFftLyE7H7JbMd/BnYgfS8lVdq73pcYKuqkBJcrl7o7GLJZCx
         7466NcnIhfaDTvK1H+iwihEveSzhyKGC/2Zgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwA8SKkNo0NB1BSSFbQlGkhBkIi6dkzdh19hX1ggqqc=;
        b=MsoDYwm7XzEZXCz3f/Liz5/QvSOfOwoW0DWfLzrwLMzWXRTR8gSuwYeM9+zgbsLieq
         S5ANTyhketbPq7pQyViSsjHMDgYtEqS+Zt/ZV2FksPQrW+TMl47TPANdZOdH71MLG5ps
         tpoWIaDnKN7Tt2TFmqPVE0Yb04YkByuLG9MUTJVG8XnoAvUN2n9yXxkkCtCYd7LhX+i+
         aqU78PgLMzYqMnskyyhkru5l7JF16sQ9a22pF0+zNacD5ifOLZPOS2wfi1UArIiF4giv
         eETmyEEFO6lgeiJpgs3DOCnDU7y7pTdnHHSorqdj1YbszKRVbCxi7EhJDZEEFQvX3VJL
         Zlmw==
X-Gm-Message-State: APjAAAVlVgEuvr0Z1FBORravIieWQtsyIu1sCEVSW/m9C3E3rdiIZQv0
        aQqrlspmfiWe8XdB4j4NnVswgHzqen8=
X-Google-Smtp-Source: APXvYqwJhSvV1xJrDKzJsWwJdN1RxiaRjs1B7aMDfiNedFvoAhhay0AcTQB6GxN2En8ThH2RFEAvVQ==
X-Received: by 2002:a19:81d4:: with SMTP id c203mr40941080lfd.160.1558470560316;
        Tue, 21 May 2019 13:29:20 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id p5sm4022004ljg.55.2019.05.21.13.29.19
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 13:29:20 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id w1so32182ljw.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2019 13:29:19 -0700 (PDT)
X-Received: by 2002:a2e:2f03:: with SMTP id v3mr4725518ljv.6.1558470208997;
 Tue, 21 May 2019 13:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190521150006.GJ17978@ZenIV.linux.org.uk> <20190521113448.20654-1-christian@brauner.io>
 <28114.1558456227@warthog.procyon.org.uk> <20190521164141.rbehqnghiej3gfua@brauner.io>
In-Reply-To: <20190521164141.rbehqnghiej3gfua@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 May 2019 13:23:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtHm4t71oKbykE=awiVv2H2wCy8yH0L_FsyhHQ5OSO+Q@mail.gmail.com>
Message-ID: <CAHk-=wgtHm4t71oKbykE=awiVv2H2wCy8yH0L_FsyhHQ5OSO+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] open: add close_range()
To:     Christian Brauner <christian@brauner.io>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        tkjos@android.com, "Dmitry V. Levin" <ldv@altlinux.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 21, 2019 at 9:41 AM Christian Brauner <christian@brauner.io> wrote:
>
> Yeah, you mentioned this before. I do like being able to specify an
> upper bound to have the ability to place fds strategically after said
> upper bound.

I suspect that's the case.

And if somebody really wants to just close everything and uses a large
upper bound, we can - if we really want to - just compare the upper
bound to the file table size, and do an optimized case for that. We do
that upper bound comparison anyway to limit the size of the walk, so
*if* it's a big deal, that case could then do the whole "shrink
fdtable" case too.

But I don't believe it's worth optimizing for unless somebody really
has a load where that is shown to be a big deal.   Just do the silly
and simple loop, and add a cond_resched() in the loop, like
close_files() does for the "we have a _lot_ of files open" case.

                   Linus

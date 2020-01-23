Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505A714741F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 23:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgAWW4z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 17:56:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43087 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbgAWW4z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 17:56:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id u131so2128367pgc.10
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 14:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDyx4Ql8/Qn5VAoH2DVKut2V/mwsU6XM8Sb1jgu629k=;
        b=tplaEJ1vep6oo8dV1s9BOPDmRx7jCDz9+N3FKj3myXdVaRz6YvIrUsNyv5jg9YToT/
         pZ5HtpJWhlSL3p7j8WnO4gS9eQAO7GalnteaC+BCkCqtvuiTfGTnjccLM7HpIWCB1InI
         LaOSyoyDBgKX3T9+24hjMAV1y4lFY3c6TVIa7kolWbSK0ik4lMyaCXYVWkN6X0j07Ble
         If0fzVssdVXXYCan4YXZzy2cxyeVShgHfimuuTkLEQpPCk2agA1PzCsuD35FoTZCUhoW
         xOKM70JQm9yXnc1Y7PNVpG78ph9b1lMuHOBlFq58zE7QvCgLLkS63be/X5VyD+GE5w3g
         KkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDyx4Ql8/Qn5VAoH2DVKut2V/mwsU6XM8Sb1jgu629k=;
        b=XvcW+ffFpyvOPmGTTCwyfPPVLcoSEGoV324P6H/HCvitrQBQyjCjibODjFhIHX2RD/
         GBigRGWq5efwTA8EfD+0x4MIE8E64tjSMWtIitd3UIOkjVHHWHHpzlla20hfnZ0Ye677
         rzv8Aas+bB9f9iGjptShz56VAaBDsh6h2jccwImKvCOE72KTDGVyVonR0p7bG3J/bgFK
         7gCHM44oE7jxO1qHAZ7gVAGcrldQrus8Uwz87Ve3FqcJkxa46ZcOSY8spFh3Kby4A1RF
         Zowupkw4NEjrUPR622OzsjS/Uhnx49mNAxclGQ8XXCgzsq/tQclXhobnznSOdmeVU9+P
         ny0A==
X-Gm-Message-State: APjAAAU9vU87VAgUJN2tt6/FGxJI5WQCfthR9GDwWouRbhCuG3LZzC8D
        U0DlsADjdldWKZ6L9O8u3zqI4onLHqOLiWnIXkusNA==
X-Google-Smtp-Source: APXvYqyYSrlPKI5wQd9gqwUk5XMTQiSu85EU/bUZcbyAqDwHkHjIuhxEB+wv6Wrj3RCcUP6u/oi9MxoAR4RhwmZvvsg=
X-Received: by 2002:a63:597:: with SMTP id 145mr705968pgf.384.1579820214473;
 Thu, 23 Jan 2020 14:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20191216220555.245089-7-brendanhiggins@google.com> <20191217080653.B672B2082E@mail.kernel.org>
In-Reply-To: <20191217080653.B672B2082E@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 23 Jan 2020 14:56:43 -0800
Message-ID: <CAFd5g45YJrrOu=kvSF9LhkCy_gxrAa3Sa6UJLRFGQtDtepe9xg@mail.gmail.com>
Subject: Re: [RFC v1 6/6] kunit: Add 'kunit_shutdown' option
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 17, 2019 at 12:06 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-12-16 14:05:55)
> > From: David Gow <davidgow@google.com>
> >
> > Add a new kernel command-line option, 'kunit_shutdown', which allows the
> > user to specify that the kernel poweroff, halt, or reboot after
> > completing all KUnit tests; this is very handy for running KUnit tests
> > on UML or a VM so that the UML/VM process exits cleanly immediately
> > after running all tests without needing a special initramfs.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  lib/kunit/executor.c                | 18 ++++++++++++++++++
> >  tools/testing/kunit/kunit_kernel.py |  2 +-
> >  tools/testing/kunit/kunit_parser.py |  2 +-
> >  3 files changed, 20 insertions(+), 2 deletions(-)
>
> Can you document it in Documentation/admin-guide/kernel-parameters.txt ?

Ah, yes. That would be a good idea. Sorry, I just expected to be
shouted at loudly for doing this, and didn't want to expend the effort
until some people told me that they didn't hate the idea.

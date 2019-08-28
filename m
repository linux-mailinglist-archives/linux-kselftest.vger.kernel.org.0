Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75DC69FE73
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 11:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfH1J22 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 05:28:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38129 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfH1J22 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 05:28:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id e11so1150421pga.5
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2019 02:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZx5QFMA3ykkKGmHMbJA9Au62IZ9SSb+Y6psbhqhgAw=;
        b=YPeGmbRVPwD/7g2CmOmiMzsT4L5WWOv2r2bNBnmdYXYUdM7lfCheB+6UIEIkeIvhEE
         nWz906pKGcRMJtzH7+G1GdPbcCIER8yDS+oiQMyDRgunWHj5gQbyKVBqevudyuYkLrVB
         MVCDZfupL8I2v3rMh/EGJlRTAlOJ4Dze4TAnERGZCR8hbRuoba/hp+nPLK1N1v8vbDq5
         wwFgokuSoEMJMX0Uvn4cMIcj993z0hs7OxnZA//OflzG+fzN2UNZtkUZDyiPiqNkmVb7
         MhybdIIXRC+qvwcxNC7+jWWg7KyDMxRYSC3XFT9QUdqEhFZM/5qKag3vjguBt5cNVd7R
         aH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZx5QFMA3ykkKGmHMbJA9Au62IZ9SSb+Y6psbhqhgAw=;
        b=Y/tG4EsqwKuX6WWe0RO/WdC+79orRHthPjc6AA2JIVrWO9bfqi3GWVwM82Cv1LaeK6
         +sB3Jd7j+x1a2P93GqtlmHWGu3IREZvJzsR8IpzWZygBbJ5fnVcfcop35S5/w0Y8T/mm
         1Ao7H079cLsUdLSoMOKpOuw29wsqk32kO8RIZkx7LbioSjVWOcSr889hZZ+4Rqj3dudv
         4QrPjV3AgyrYl+u1tDnn8fzxvq5HNde9Ujgn25JMrJL8uDEljN38yEQAb+G1YfzwJRBa
         4Vu11elT3rXroaofAnaky9kiqj5GFf/7TcJEestiWPnFUOc7HY+dMKEbdSojoOJZwrL+
         Q/3w==
X-Gm-Message-State: APjAAAW+YvesZ64cZ1nPR9f4zsxlfDi63bnstThxDZkNLxpZYCzCH3OW
        YB6Q6vSFCaBS9wyuRTXe5g571DZNp6Fr+PrOCFgtYg==
X-Google-Smtp-Source: APXvYqz0WqpF7fj08ZtVZkh5HfCpm8kVU1XmTLvg2tS/TEiLZHZzWWuukt700aOKth9QMBIx7YzEEiet/r/7g7OMqgc=
X-Received: by 2002:a63:b919:: with SMTP id z25mr2563361pge.201.1566984507452;
 Wed, 28 Aug 2019 02:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190827234835.234473-1-brendanhiggins@google.com>
 <20190828030231.GA24069@jagdpanzerIV> <20190828044529.GA30152@google.com> <20190828052405.GA526@jagdpanzerIV>
In-Reply-To: <20190828052405.GA526@jagdpanzerIV>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 28 Aug 2019 02:28:16 -0700
Message-ID: <CAFd5g44U_DcCKtNOBKXiqsNuQbhKSTyr=jLRjNnKUxj8S0ZDrw@mail.gmail.com>
Subject: Re: [PATCH v1] printk: add dummy vprintk_emit for when CONFIG_PRINTK=n
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     shuah <shuah@kernel.org>, Petr Mladek <pmladek@suse.com>,
        sergey.senozhatsky@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 27, 2019 at 10:24 PM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (08/27/19 21:45), Brendan Higgins wrote:
> [..]
> > I actually use it in a very similar way as dev_printk() does. I am using
> > it to define an equivalent kunit_printk(), which takes a log level, and
> > adds its own test information to the log.
> >
> > What I have now is:
> >
> > static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> > {
> >       return vprintk_emit(0, level, NULL, 0, fmt, args);
> > }
> >
> > static int kunit_printk_emit(int level, const char *fmt, ...)
> > {
> >       va_list args;
> >       int ret;
> >
> >       va_start(args, fmt);
> >       ret = kunit_vprintk_emit(level, fmt, args);
> >       va_end(args);
> >
> >       return ret;
> > }
> >
> > static void kunit_vprintk(const struct kunit *test,
> >                         const char *level,
> >                         struct va_format *vaf)
> > {
> >       kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> > }
>
> Basically, for prefixes we have pr_fmt().
>
> #define pr_fmt(fmt) "module name: " fmt
>
> but pr_fmt() is mostly for static prefixes. If that doesn't work for
> you, then maybe you can tweak kunit_foo() macros?

That doesn't work. The prefix is dynamic.

> E.g. something like this
>
> #define kunit_info(test, fmt, ...)                                   \
>         printk(KERN_INFO "\t# %s: " pr_fmt(fmt), (test)->name, ##__VA_ARGS__)
>
> #define kunit_err(test, fmt, ...)                                    \
>         printk(KERN_ERR "\t# %s: " pr_fmt(fmt), (test)->name, ##__VA_ARGS__)
>
> #define kunit_debug(test, fmt, ...)                                  \
>         printk(KERN_DEBUG "\t# %s: " pr_fmt(fmt), (test)->name, ##__VA_ARGS__)
>
> Would that do the trick? Am I missing something?

This appears to work. I will send out a patch that incorporates this.

Thanks!

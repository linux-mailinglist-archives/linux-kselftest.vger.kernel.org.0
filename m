Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 351AB9F4AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 23:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfH0VDk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 17:03:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37654 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfH0VDk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 17:03:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so146660pgp.4
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2019 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqJGmhaCQ0mE4KAqKVKLY8OtGEQ4WA7SvplNI/CPuH8=;
        b=jqVXnO87Y94ALi10nxX/DLFreu43gwvLsNu/ONVxZGD1OB5Axb2fRwBl5DNDuypTUh
         iksvVZWNThyaETR2uelRflKf6YuzHxTRBZfLJepcSU9/e/3TKradFWAvI4yl3FKTBMX5
         P697YyJdaoTE/Ntlq+Su5JLvyj98HWV5GD2tXQNQR7GwUFzk/bCgd4oiQbEZpULIDz8Q
         VkacS3ZyXmHp4/75Hh2KnuAB0QIgyyVdTN3fUs8naECDt2IGklQVrpUtaB+ZJXukF7cb
         YBDRWcIa/hpq9bKX8U7dXOaqOrjSvLvvWy+pzHXomaSQ3cmYJgfTpnVZd9tim1pmlPN0
         3HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqJGmhaCQ0mE4KAqKVKLY8OtGEQ4WA7SvplNI/CPuH8=;
        b=E/EMY0WbmHhRgJL7aoHMk6FuJHv87ulzjYipfb1msZ2rgyPpmsMpZnJuQrLAAi62q0
         KIclhBpFfB2zfl/EK8ECjOsLGTmsqQzMte8pk6nNad/oAOzzO0ZfjLVLJuVYRgz1mtaZ
         oaocFBy4GwPv0Bwep5Krg6a/qhAyznk1uqpHJCN/++wMXmHJEvyrluXVD9s3U2j5eiTh
         ZgKp+ctv9U/hCoGh2yGWv4ZVCrN4XpApsMmCM7scafNQS8PuIHq4gOi79NNdeeYS1RiY
         h07wt8CESM3W97qEI/t3c6kLAf7CpO2GCdesQStDnkIua6t7oznINSiX/a1KkgjwjZH5
         XuxQ==
X-Gm-Message-State: APjAAAV8eUyvqP95OJkAOWojV6WUEcxSd7Hz4Q3GvlyUZZYdwSGkJzGn
        EGcKxrcqHNYC7pp7QwA2dVBPhClv/DvfM5QIJnbm8w==
X-Google-Smtp-Source: APXvYqwirVi7K5ZiDGHR5Jyl00j3UckS6/n5kmGaXLUAby933/RIoO5528aMdIBKHVDUm3iO5tq3dAelV+iXB3eOQVA=
X-Received: by 2002:a63:205f:: with SMTP id r31mr356078pgm.159.1566939818927;
 Tue, 27 Aug 2019 14:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190827174932.44177-1-brendanhiggins@google.com> <ae9b9102-187c-eefe-d377-6efa63de2d28@kernel.org>
In-Reply-To: <ae9b9102-187c-eefe-d377-6efa63de2d28@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 27 Aug 2019 14:03:27 -0700
Message-ID: <CAFd5g473nZAfM4D=Vkr54O_+nn=MSt3dzuDcXzNMZGRDWg1nxA@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     shuah <shuah@kernel.org>
Cc:     kunit-dev@googlegroups.com,
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

On Tue, Aug 27, 2019 at 1:21 PM shuah <shuah@kernel.org> wrote:
>
> On 8/27/19 11:49 AM, Brendan Higgins wrote:
> > Previously KUnit assumed that printk would always be present, which is
> > not a valid assumption to make. Fix that by ifdefing out functions which
> > directly depend on printk core functions similar to what dev_printk
> > does.
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >   include/kunit/test.h |  7 +++++++
> >   kunit/test.c         | 41 ++++++++++++++++++++++++-----------------
> >   2 files changed, 31 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 8b7eb03d4971..339af5f95c4a 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -339,9 +339,16 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
[...]
> Okay after reviewing this, I am not sure why you need to do all
> this.
>
> Why can't you just change the root function that throws the warn:
>
>   static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> {
>          return vprintk_emit(0, level, NULL, 0, fmt, args);
> }
>
> You aren'r really doing anything extra here, other than calling
> vprintk_emit()

Yeah, I did that a while ago. I think it was a combination of trying
to avoid an extra layer of adding and then removing the log level, and
that's what dev_printk and friends did.

But I think you are probably right. It's a lot of maintenance overhead
to get rid of that. Probably best to just use what the printk people
have.

> Unless I am missing something, can't you solve this problem by including
> printk.h and let it handle the !CONFIG_PRINTK case?

Randy, I hope you don't mind, but I am going to ask you to re-ack my
next revision since it basically addresses the problem in a totally
different way.

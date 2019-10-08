Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5C9CFA76
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfJHMxi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 08:53:38 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:36472 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730608AbfJHMxh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 08:53:37 -0400
Received: by mail-qt1-f171.google.com with SMTP id o12so25112694qtf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2019 05:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quCMQYnPdDfvQyW2DvaY96DjjIVwOhdcLLux7/u+rmw=;
        b=sCvP8ghUcn7ANc3hKUkFZW/kN7gHOXz1hnZbHX8nS184amx3dW4SMeY5/mGFNWfaaK
         sMpk4JPkM7BtBHYbfGCcGQQeWCrAtyDDK+FL2r3bkxB4Pwd2txHYnbQ85KDvnde5WS2S
         ksYEUB6Ljnjy+HukWuExjMDRguXk9r+4OwhP6JcGOOsyY1ov88r9hsq799bqHaj5Qij1
         bXz01aa+LItbzeoE14WdihFwa5ti+JBolCOwvo78QkOubgBdOnfYTNSc/X+VvcNgJJ30
         dXqeRwRnZ+mfLoTl1xAI0LZNo0JJx1LZD0Syueqvm/lppcDIWqx33esIay85/MZCG1T2
         z+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quCMQYnPdDfvQyW2DvaY96DjjIVwOhdcLLux7/u+rmw=;
        b=QA7mR31Cy2dgRQTkpKgnl67xjmsoo+dYmwnOWbBe2URxEkyyjAGROQcPLQRzaGbw3Q
         oIguDlAymUWgM6wCxuTYToQFtoTjCrA9r2WKwlftCj8KV6w5YfMyqkKTiCSyEKfNYfWE
         +N4FHGZSzJDh/xfCGICordryCuK4tSXNa2ZsBXBeCk2BLKu2H2XLF4Te1zze2xovidui
         TCUgx7x7aYikXyVHt+YizAJNK9ch4KTFo2eQjN2vsaEEWJLK4B3EgCYEEF7BMchrUg1I
         B1epbpr5U6ITXgnioUkO9ZkZYYx7GpkU0AP18HCjh+sKhYG+178BPLgSyhzoWBjLqpXb
         Lbkw==
X-Gm-Message-State: APjAAAVf1LW0yH+7suBm3cnbAHGYwuTJXBySCuzhTcoFgSj8vBQl5mX9
        DCqN3bSpll+1B9GExJ8idp95ouGJUjieXFVJjc0Hyw==
X-Google-Smtp-Source: APXvYqwb8Np6DMMV+QwSeaXyTLjfQQ9eS9SVxyMq/RBTWikUsnPDs9he90W+ycEUDqXj6b8QKUIcSv7dwyIeL2Toffk=
X-Received: by 2002:a0c:ef85:: with SMTP id w5mr32851997qvr.159.1570539215888;
 Tue, 08 Oct 2019 05:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <87zhibwgzm.fsf@rpws.prws.suse.cz>
In-Reply-To: <87zhibwgzm.fsf@rpws.prws.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 8 Oct 2019 14:53:24 +0200
Message-ID: <CACT4Y+akZ4h9kN1Gg329-fKq-G=QeDdoFxW_Bp_r7+0sDsE+mw@mail.gmail.com>
Subject: Re: [Automated-testing] syzkaller reproducers
To:     rpalethorpe@suse.de
Cc:     automated-testing@yoctoproject.org, Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernelci@groups.io,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 8, 2019 at 2:37 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> Hello,
>
> Dmitry Vyukov <dvyukov@google.com> writes:
>
> > Hi Shuah,
> >
> > We discussed collecting and uploading all syzkaller reproducers
> > somewhere. You wanted to see how they look. I've uploaded all current
> > reproducers here:
> > https://github.com/dvyukov/syzkaller-repros
> > Minimalistic build/run scripts are included.
> > +some testing mailing lists too as this can be used as a test suite
> > If you have any potential uses for this, you are welcome to use it.
> > But then we probably need to find some more official and shared place
> > for them than my private github.
> > The test programs can also be bulk updated if necessary, because all
> > of this is auto-generated.
> >
> > Thanks
>
> I discussed this a bit with Metan. We think it would be fairly trivial
> to create an LTP wrapper for these.
>
> So we just create an LTP test which forks and execs one of these
> reproducers then checks for kernel taints after the child completes or
> is killed. It can take the reproducer path as an argument and we can
> generate a runtest file with all the reproducers in that we are able to
> compile.
>
> I imagine a lot of these reproducers will not work on older kernels, so
> this would just be a best efforts basis. We would ignore any problems
> during execution unless there is a kernel error.
>
> This should work with existing LTP runners with maybe a minor change or
> two to building and configuration.
>
> I will start experimenting with this and post the results to the LTP
> mailing list.


Hi Richard,

Sounds great!

Yes, these are totally best effort. May also require some configs, etc.
Also note that each should be run in a clean temp dir and with a
timeout b/c some have an infinite loop.

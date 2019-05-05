Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B63D13EED
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2019 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfEEKnY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 May 2019 06:43:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40647 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfEEKnY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 May 2019 06:43:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id d15so8694169ljc.7
        for <linux-kselftest@vger.kernel.org>; Sun, 05 May 2019 03:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4GjLl7K6asTFLnlYxatdFlHWtyLi5pvTCEs/u8ILWik=;
        b=GaEcQzwqK/iuz9s/KT/ehDvXSb1v/tT5Njyhz4RvEp0aNhOA/rbbB7ECRRjH7Yrco3
         1YDhKDfwPb/FusbxKDUKhs4tk4aYmTNGA7x+4Kb8erWtDKf4yWUk8He3O0Ndz4lqgt4t
         ofP0PDE9yBdNth8xcAjd5j6UjErda5NkX1Z/nhX+sVqNhcvW7UjKyuUlr4ae1IJIPijZ
         N63rQzEUPcvHPSlbNcD+H93njg5oCTCgfye9eGZxUPAUezVxVVWoxqjxncAhZGbTypzL
         7IxuCPkpZ2c4ob1zhnvXqlmzGg8wmSmFbQrks7XjfFTM5F6MEAjhERUWS/tXznc414oh
         HrLg==
X-Gm-Message-State: APjAAAUorTc91MPCUI8I/npkM9SkisiA1gBwCPCq/kvVCnF+V5bfm5rR
        Negw9dfrRdcQcpsSHyGdkHd11Q==
X-Google-Smtp-Source: APXvYqwEy7omAXcrY5BsTGyRKJslL4mnjw0B1lsP0tlQ3iQfUu4XMFEePdMId0TLiu6kV5iIrnsOWg==
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr10596470lja.193.1557053002627;
        Sun, 05 May 2019 03:43:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.vpn.toke.dk. [2a00:7660:6da:10::2])
        by smtp.gmail.com with ESMTPSA id b25sm1445240lji.50.2019.05.05.03.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 03:43:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AB2A318039B; Sun,  5 May 2019 12:43:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>,
        Greg KH <greg@kroah.com>
Cc:     "xiyou.wangcong\@gmail.com" <xiyou.wangcong@gmail.com>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "jhs\@mojatatu.com" <jhs@mojatatu.com>,
        "jiri\@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest\@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "shuah\@kernel.org" <shuah@kernel.org>
Subject: Re: [net-next v2] net: sched: Introduce act_ctinfo action
In-Reply-To: <B6426224-12CC-417B-9A38-6DDBE574A85C@darbyshire-bryant.me.uk>
References: <CAM_iQpXnXyfLZ2+gjDufbdMrZLgtf9uKbzbUf50Xm-2Go7maVw@mail.gmail.com> <20190505101523.48425-1-ldir@darbyshire-bryant.me.uk> <20190505102314.GA12761@kroah.com> <B6426224-12CC-417B-9A38-6DDBE574A85C@darbyshire-bryant.me.uk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 05 May 2019 12:43:20 +0200
Message-ID: <8736lt9o6v.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk> writes:

>> On 5 May 2019, at 11:23, Greg KH <greg@kroah.com> wrote:
>> 
>> On Sun, May 05, 2019 at 10:15:43AM +0000, Kevin 'ldir' Darbyshire-Bryant wrote:
>>> --- /dev/null
>>> +++ b/net/sched/act_ctinfo.c
>>> @@ -0,0 +1,407 @@
>>> +// SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>> 
>
> Hey Greg, thanks for the review.
>
>> How can a .c file, buried in the kernel tree, have a Linux-syscall-note
>> exception to it?
>
> Because I’m a moron and nobody else spotted it.
>> 
>> Are you _sure_ that is ok?  That license should only be for files in the
>> uapi header directory.
>
> Expect a v3 shortly.  I shall wear your chastisement with honour :-)

While you're at it, you don't actually need the GPL text blob when using
the SPDX headers... :)

-Toke

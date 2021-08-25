Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5C3F77D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Aug 2021 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhHYO4r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 10:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhHYO4r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 10:56:47 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E28C061757
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 07:56:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id a93so48569227ybi.1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvL1J8KEhyvF/ZLVKb8SP9iGmx/rrgPK1Hb5hBuqIvo=;
        b=L7jPwTZZT3jOI6gXuF9VZTYs592tZM+gktGr8MUWZIcKJjVlKdUag4gOINbV8YIZIk
         PRvoI+0GPDaLYpQKItO/lsUAJAUgrnfbV48dIv74TezzcZjQiLs/ZNImptNNOsbjfGcX
         a5lngTlixGTPXYqpLRus2JepcNK2FxaoOdvb80MPkiiCb4qDTKZJci4SzwTBqHzvzJl5
         5wx5Tn9GUbQ0NBZXHbKlp3zUDtwhJObYAlS0+LJGulL2eVjSvAuqZHd5GKBXff9DnC2T
         82J4aTjwEHrOJFWeFYaeOgYGbNxxMIEec7ttnkuC9jfwwbPbNatiG+GH/oDJcVGRfCAT
         nbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvL1J8KEhyvF/ZLVKb8SP9iGmx/rrgPK1Hb5hBuqIvo=;
        b=pohR4QECzSmzIYHPl8IU311ltaGkSkmg5kBX9K4t7HOFFwb6AU9ZZrOMn5KAiE/Nm5
         KUyhMcGcE7dVaTIVlJGxmJ3pcywGNGbQTramziPM7sb9Cfc+t7UoHODyX512t/WjSKP7
         ojaPFuxBiUsnv9xL0A46SfMe295xIJruX5HuWoNlRRZtwze/j7U8D1uCiwMEycowICx8
         kxGzIrorTAq67FHE407VL/bOEqtCk6586LEgRTJipo5e7/C2i/VYh9gcKzEG3bFhJmpA
         B7AKRMVjTKrONn0XK7/HISHYsUkBjZ7eYeSBPBZiK9bDZbY6xhVkZHNl4Yn+n3R3nkl7
         vBmQ==
X-Gm-Message-State: AOAM531eLrFpSQOxzNkV6ykTzWJNxC0pxNjpkNJxX6LnKJlaUXqcLdb1
        Kfe2BvjBJbAszyLfdzr/5T2L4Td2ScUZsZeLmBZzwg==
X-Google-Smtp-Source: ABdhPJytkuWEAuWWUZYWrEP18lJu5G82NnUjEtQyDV/rrZApkbTZLLyvruD/dE6vR4XM4BrtoHrV6JslnrM+TOpdsL4=
X-Received: by 2002:a25:2cd5:: with SMTP id s204mr10240667ybs.452.1629903360317;
 Wed, 25 Aug 2021 07:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629840814.git.cdleonard@gmail.com> <abb720b34b9eef1cc52ef68017334e27a2af83c6.1629840814.git.cdleonard@gmail.com>
 <30f73293-ea03-d18f-d923-0cf499d4b208@gmail.com> <20210825080817.GA19149@gondor.apana.org.au>
In-Reply-To: <20210825080817.GA19149@gondor.apana.org.au>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 25 Aug 2021 07:55:49 -0700
Message-ID: <CANn89iKc-=x-15M8pkfOJazZHXY8ziD+PMH4z4C+eGL6_atbrA@mail.gmail.com>
Subject: Re: [RFCv3 05/15] tcp: authopt: Add crypto initialization
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Leonard Crestez <cdleonard@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Ivan Delalande <colona@arista.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Menglong Dong <dong.menglong@zte.com.cn>,
        netdev <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 25, 2021 at 1:08 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, Aug 24, 2021 at 04:34:58PM -0700, Eric Dumazet wrote:
> >
> > On 8/24/21 2:34 PM, Leonard Crestez wrote:
> > > The crypto_shash API is used in order to compute packet signatures. The
> > > API comes with several unfortunate limitations:
> > >
> > > 1) Allocating a crypto_shash can sleep and must be done in user context.
> > > 2) Packet signatures must be computed in softirq context
> > > 3) Packet signatures use dynamic "traffic keys" which require exclusive
> > > access to crypto_shash for crypto_setkey.
> > >
> > > The solution is to allocate one crypto_shash for each possible cpu for
> > > each algorithm at setsockopt time. The per-cpu tfm is then borrowed from
> > > softirq context, signatures are computed and the tfm is returned.
> > >
> >
> > I could not see the per-cpu stuff that you mention in the changelog.
>
> Perhaps it's time we moved the key information from the tfm into
> the request structure for hashes? Or at least provide a way for
> the key to be in the request structure in addition to the tfm as
> the tfm model still works for IPsec.  Ard/Eric, what do you think
> about that?

What is the typical size of a ' tfm' and associated data ?

per-cpu tfm might still make sense, if we had proper NUMA affinities.
AFAIK, currently we can not provide a numa node to crypto allocations.

So using construct like this ends up allocating all data on one single NUMA node

for_each_possible_cpu(cpu) {
    tfm = crypto_alloc_shash(algo->name, 0, 0);
    if (IS_ERR(tfm))
        return PTR_ERR(tfm);
    p_tfm = per_cpu_ptr(algo->tfms, cpu);
    *p_tfm = tfm;
}

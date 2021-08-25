Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCAE3F7BD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Aug 2021 19:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhHYR4s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 13:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbhHYR4r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 13:56:47 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DF1C0613C1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 10:56:01 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id k65so505268yba.13
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fx2qkPqDeREwxSopnWcjB1GCzK8MBh8mRC5Q/NQ22aI=;
        b=O/CUHdrLiJ6O7rxUOG4hBQ7TFTwBLuhTlSrZgBQd5wpnDEAl3/RRINc47fHCxofqDt
         Gk1K1H+WIWlFbz2x/95RZbZF6zY2T0i0K10hlYkqCy83IiYX0RlWk8FPP860yq5QK/pn
         AZklAgrLEmCa2VfG+KI9vqFNqhrnccHnKhyXf4jq9OayxTyK9WaPkzlVxRnzzSfoXueo
         k5CNeeYg3Y4+WhtMXmlXLmzjat1ycxEx2ypsjsku/k9RGzbEk/pQ37JseXFbGiT9hFQz
         Mx4g7c7OKIoEEzMGooqLVfc0uk/UV0Pp9GTc7fv8CwjlSV4RlZviucdinirrM/SgUwbq
         qMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fx2qkPqDeREwxSopnWcjB1GCzK8MBh8mRC5Q/NQ22aI=;
        b=avWGQBauvy+qzqNYG0k9Bdro8zEnviohY43YUsPhSidAvJcWi2m2eNfvhhoy93NmsC
         0eilkjI/sY1tADw+JTSsGq2nZSTmXbiMk9JNgex8BeaayR4AyESE2YNBlfu7BG2rf/f7
         Iig9ZSvufpXOpc0Xgl2xKRPEmacbMdPY6ihYqrQeCnuMgOnmkqcTGGWJDAkOKyeIpDAh
         8X6geq1ctfbRT4avLdzjXiUAonyghf1BH/sfc/tQzP7UP44pT0np9fYbo9Vntdr7/yU4
         Owr4rvUDPr/xf5GC7/Hb/wrKizAULND5pEV8o0kEFfGHuNan+W4qsctHIqOwFmTuyHIy
         TMPw==
X-Gm-Message-State: AOAM533Ad7gamyR1CXymnZrMl6jd/nEWKOtst1Hho/yfxP4LECoKBVFd
        7VwsEKFPUZND9zE3b4mQPzhGlXzzNrw68hDYEDrq6g==
X-Google-Smtp-Source: ABdhPJwKRB3q/uwwiPtTgdHTJ5OwhyTkhxDgLtYRjV02T0AARc/QuUllh7pJ+IPbZoD3iMH+oFK3DfMIjXn26rlEQ2o=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr57803506ybj.504.1629914160647;
 Wed, 25 Aug 2021 10:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629840814.git.cdleonard@gmail.com> <abb720b34b9eef1cc52ef68017334e27a2af83c6.1629840814.git.cdleonard@gmail.com>
 <30f73293-ea03-d18f-d923-0cf499d4b208@gmail.com> <27e56f61-3267-de50-0d49-5fcfc59af93c@gmail.com>
In-Reply-To: <27e56f61-3267-de50-0d49-5fcfc59af93c@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 25 Aug 2021 10:55:49 -0700
Message-ID: <CANn89iJPyQpJTxrDMGszEOrgKwaEdYz1xaRK7vKbS4qj9tV23g@mail.gmail.com>
Subject: Re: [RFCv3 05/15] tcp: authopt: Add crypto initialization
To:     Leonard Crestez <cdleonard@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 25, 2021 at 9:35 AM Leonard Crestez <cdleonard@gmail.com> wrote:
>
> On 25.08.2021 02:34, Eric Dumazet wrote:
> > On 8/24/21 2:34 PM, Leonard Crestez wrote:
> >> The crypto_shash API is used in order to compute packet signatures. The
> >> API comes with several unfortunate limitations:
> >>
> >> 1) Allocating a crypto_shash can sleep and must be done in user context.
> >> 2) Packet signatures must be computed in softirq context
> >> 3) Packet signatures use dynamic "traffic keys" which require exclusive
> >> access to crypto_shash for crypto_setkey.
> >>
> >> The solution is to allocate one crypto_shash for each possible cpu for
> >> each algorithm at setsockopt time. The per-cpu tfm is then borrowed from
> >> softirq context, signatures are computed and the tfm is returned.
> >>
> >
> > I could not see the per-cpu stuff that you mention in the changelog.
>
> That's a little embarrasing, I forgot to implement the actual per-cpu
> stuff. tcp_authopt_alg_imp.tfm is meant to be an array up to NR_CPUS and
> tcp_authopt_alg_get_tfm needs no locking other than preempt_disable
> (which should already be the case).

Well, do not use arrays of NR_CPUS and instead use normal per_cpu
accessors (as in __tcp_alloc_md5sig_pool)

>
> The reference counting would still only happen from very few places:
> setsockopt, close and openreq. This would only impact request/response
> traffic and relatively little.

What I meant is that __tcp_alloc_md5sig_pool() allocates stuff one time,
we do not care about tcp_md5sig_pool_populated going back to false.

Otherwise, a single user application constantly allocating a socket,
enabling MD5 (or authopt), then closing the socket would incur
a big cost on hosts with a lot of cpus.

>
> Performance was not a major focus so far. Preventing impact on non-AO
> connections is important but typical AO usecases are long-lived
> low-traffic connections.
>
> --
> Regards,
> Leonard

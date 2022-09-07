Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010AA5B1014
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 00:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIGW61 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 18:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiIGW61 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 18:58:27 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B23A99E2
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Sep 2022 15:58:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p200so4710866yba.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Sep 2022 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ensB6iG2T4HcBnO54DOwBgrBj2kxQd/wvWtFjiwAVj4=;
        b=ec3pOZdXR+0LpVTRq9xtvqRgWhEPNWOlfQ0mKzRaG/z4seSTW55o6CxkkBbEr2JftY
         QIOxFCzbzFr6nl66WDfRjNHGAcuz2W4A7jc8DFtyjAuMJS274y+3N7RuBtFMZTSlO88S
         NNZHp9ti28xH0kvkd9oi0lKPHhFzwEETdMB1V0XC+oK0QGIiV81gIGM9dh/tRKccoFH/
         3jHFoZfu1No9YL4DeBaje9rPhu7obuP7MNTxm5c80p7NjZdt3VxFDyPAoWtPhlIMarw1
         FoKRtXClZ55xK9N7UXCKFY14lX4YixMYO/No+d+iVll5C5V2ktcRd6Aae+fx0Y6l9FUK
         Cp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ensB6iG2T4HcBnO54DOwBgrBj2kxQd/wvWtFjiwAVj4=;
        b=aqgGrUYc77KIt9QmvoXal+6WYSFFTV9xCYCaapuNgEFoQj0oLUiRPJw08A+v0leyw2
         nROcAm+ejkUyrTvM29rSKNbnMobSbyr9n7oFXnSY0kc3O4XKrHR7HdUsnU9YrZdOajTt
         MwrQpkESYseF9svcfnC+KWCOU/OsTdd7Yrkh+2d6l4nI93C0n4TIch2pwTZqAuTiSSia
         yWYAvB7maF5HP9/nGhIbG4jxosACialZXLDjK7VeaTSplCPnIKbv1zoM2GbJ8QksBfk0
         6YBbQpwZJ2gPDqFM9kGi6KVjip8Qh8/jsaI3Kmq3bovU3ATKUCiN+rBX/Pd8C4FzVOG8
         iQdg==
X-Gm-Message-State: ACgBeo15UJTK1wLUJdLQsQhxlpbHRaM7bkEmT+hRyspxeRUn3k8qY2CE
        u66+qh0CpktC0H2srPBz5viTK+RJIiTnNnYAXAcHsg==
X-Google-Smtp-Source: AA6agR65qU6xB2U2255wpOaXm8Hmd9oTgqy80QJ0Bn/k9GJ5kl8p/E1l+APxsu8s42FDlwIGi/yC1fXRghpvTrC1Mho=
X-Received: by 2002:a25:b78a:0:b0:695:900e:e211 with SMTP id
 n10-20020a25b78a000000b00695900ee211mr4602285ybh.427.1662591503842; Wed, 07
 Sep 2022 15:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662361354.git.cdleonard@gmail.com> <298e4e87ce3a822b4217b309438483959082e6bb.1662361354.git.cdleonard@gmail.com>
 <CANn89iKq4rUkCwSSD-35u+Lb8s9u-8t5bj1=aZuQ8+oYwuC-Eg@mail.gmail.com> <YxkgC1XKmCNGzk3t@gondor.apana.org.au>
In-Reply-To: <YxkgC1XKmCNGzk3t@gondor.apana.org.au>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 7 Sep 2022 15:58:12 -0700
Message-ID: <CANn89iLXsSotHWkUv4h0jCyNqym+Mb1N2-sfyC0sK76TZ+xPPg@mail.gmail.com>
Subject: Re: [PATCH v8 08/26] tcp: authopt: Disable via sysctl by default
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Leonard Crestez <cdleonard@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Salam Noureddine <noureddine@arista.com>,
        Philip Paeps <philip@trouble.is>,
        Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Ivan Delalande <colona@arista.com>,
        Caowangbao <caowangbao@huawei.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        netdev <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 7, 2022 at 3:50 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, Sep 06, 2022 at 04:11:58PM -0700, Eric Dumazet wrote:
> >
> > WRITE_ONCE(sysctl_tcp_authopt, val),  or even better:
> >
> > if (val)
> >      cmpxchg(&sysctl_tcp_authopt, 0, val);
>
> What's the point of the cmpxchg? Since you're simply trying to prevent
> sysctl_tcp_authopt from going back to zero, then the if clause
> by itself is enough:
>
>         if (val)
>                 WRITE_ONCE(sysctl_tcp_authopt, val);
>

Ack.

Original patch was doing something racy, I have not though about the
most efficient way to deal with it.

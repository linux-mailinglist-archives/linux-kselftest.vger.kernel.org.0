Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BCF53148C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 May 2022 18:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiEWNd5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 May 2022 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbiEWNdE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 May 2022 09:33:04 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7598205C6
        for <linux-kselftest@vger.kernel.org>; Mon, 23 May 2022 06:32:45 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id 11so10246484qtp.9
        for <linux-kselftest@vger.kernel.org>; Mon, 23 May 2022 06:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KjOYIVL1wILAR2a3xXNLgUZr3VuQ0TY6+aI86AqoII4=;
        b=BLZGex4d/o0O313ly/oS7W57sv9ciXrvLH/tvqcADWFYMxv8Il1idhxZ3BW8UebIhW
         R6TlQu0c5oBKyxSB9MnFax8PIQg+uTePfMbDmLIP2riLqWfBhHPZnMFVHN/DWsWKkGTV
         /Htlc1r2QGgxTY4MdgYxxujHRqBGltfNEuJEF1OjQ1ArEUqq3cs6LsXSa2JC+uoIK9Mx
         3JTIcZcSDySDd/Ss6J/0vBniyvEWgUmeSparXhamjPA9FOqkfBI0kcWdWutP1Bj8+wE2
         b7vbMQOMNHt8u9PAvxdUF3eUkj1mNpIg/5zRL87MPBjelzShqLcAJVOHLbDOrxzpF9z9
         Tpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KjOYIVL1wILAR2a3xXNLgUZr3VuQ0TY6+aI86AqoII4=;
        b=joh1RfjHWJxHaVgi0RLQ5KZYAOO86s7YI+aVjEFZG1R8CAYC3mmonwJfSBOVOuQFTt
         HzAH7kDpoEefDBuc/3Ml0XuwkbpegCYNrfvvN93MkF66wE0bs27Ugc1ik/q1Ou67CVOh
         YOVCJNJtQ47AfmaPW+HcsvW6sNMozKE+ZVwnvVgjcQU9QP4TcKKp4Nv025aNtJDmNJGO
         IV8s2z5/vbHrY1awgNoimXZmqWhBvKhsGzjaHkxZq6R2/iwCXF+ipK1EZt/y5Ja7StAV
         sOWRFwsYnmq8CCllmEstNnZobrkGEim0MLHUgLNSnz5SQhcVIpDgbdGWdK7Cmed3gOD1
         jaUQ==
X-Gm-Message-State: AOAM533q8VY+3rUbiqD8ffFnpsRv4BTjYxXvyqPAmdMIdiCwKCTnW0Zn
        MdV0q9rVe60twGkcFiS1ZugxyUmA+qQ=
X-Google-Smtp-Source: ABdhPJySF+JSBgjVQTf8dZCH6mk2E94+zF/ewzVOXUDJXPEXJ3Lv87eBoeCbAOAm+iZ0bm9D2ghESw==
X-Received: by 2002:ac8:5b44:0:b0:2f9:3470:678f with SMTP id n4-20020ac85b44000000b002f93470678fmr4295005qtw.287.1653312760236;
        Mon, 23 May 2022 06:32:40 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id x7-20020ac80187000000b002f3fbf28826sm4358586qtf.23.2022.05.23.06.32.39
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 06:32:39 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id f16so25421606ybk.2
        for <linux-kselftest@vger.kernel.org>; Mon, 23 May 2022 06:32:39 -0700 (PDT)
X-Received: by 2002:a05:6902:691:b0:64d:e8c9:e4bb with SMTP id
 i17-20020a056902069100b0064de8c9e4bbmr22165640ybt.513.1653312759117; Mon, 23
 May 2022 06:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220520063835.866445-1-luyun_611@163.com> <CA+FuTSdoZeAncRVAYrb66Kp6bEueWrgyy7A8qP0kmr9pxfHMoA@mail.gmail.com>
 <3f494c7a-6648-a696-b215-f597e680c5d9@163.com>
In-Reply-To: <3f494c7a-6648-a696-b215-f597e680c5d9@163.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 23 May 2022 09:32:02 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdHCszjFtkZj37KE-1rfSfzYEd5oXLyKS6Kz9pdi05ReA@mail.gmail.com>
Message-ID: <CA+FuTSdHCszjFtkZj37KE-1rfSfzYEd5oXLyKS6Kz9pdi05ReA@mail.gmail.com>
Subject: Re: [PATCH] selftests/net: enable lo.accept_local in psock_snd test
To:     Yun Lu <luyun_611@163.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 23, 2022 at 5:25 AM Yun Lu <luyun_611@163.com> wrote:
>
> On 2022/5/20 =E4=B8=8B=E5=8D=889:52, Willem de Bruijn wrote:
>
> > On Fri, May 20, 2022 at 2:40 AM Yun Lu <luyun_611@163.com> wrote:
> >> From: luyun <luyun@kylinos.cn>
> >>
> >> The psock_snd test sends and recievs packets over loopback, but the
> >> parameter lo.accept_local is disabled by default, this test will
> >> fail with Resource temporarily unavailable:
> >> sudo ./psock_snd.sh
> >> dgram
> >> tx: 128
> >> rx: 142
> >> ./psock_snd: recv: Resource temporarily unavailable
> > I cannot reproduce this failure.
> >
> > Passes on a machine with accept_local 0.
> >
> > accept_local is defined as
> >
> > "
> > accept_local - BOOLEAN
> >      Accept packets with local source addresses. In combination
> >      with suitable routing, this can be used to direct packets
> >      between two local interfaces over the wire and have them
> >      accepted properly.
> > "
> I did this test on my system(Centos 8.3 X86_64):
>
> [root@localhost net]# sysctl net.ipv4.conf.lo.accept_local
> net.ipv4.conf.lo.accept_local =3D 0
> [root@localhost net]# ./psock_snd -d
> tx: 128
> rx: 142
> ./psock_snd: recv: Resource temporarily unavailable
> [root@localhost net]# sysctl -w net.ipv4.conf.lo.accept_local=3D1
> net.ipv4.conf.lo.accept_local =3D 1
> [root@localhost net]# ./psock_snd -d
> tx: 128
> rx: 142
> rx: 100
> OK
>
> This failure does seem to be related to accept_local.
>
> Also, it's reported on Ubuntu:
> https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1812618

That is an old kernel, 4.18 derived.

I simply am unable to reproduce this on an upstream v4.18 or v5.18.
Likely something with either the distro kernel release, or another
distro feature that interacts with this. Can you try v5.18 or another
clean upstream kernel?

Else it requires instrumenting IN_DEV_ACCEPT_LOCAL tests to understand
where this sysctl makes a meaningful change for you when running this
test.

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1637652ED8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 May 2022 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349988AbiETNxS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350015AbiETNxI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 09:53:08 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14061623
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 06:53:05 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g207so4100712qke.7
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGR+whjNeV5lQ5mL6l6NHxm6IVCDzbcrLX3tF9OMg2c=;
        b=EFAnWlMX37CEmbheKts/opui51h5JGB/7WRVQhN8F4ijCxcNhN3QRk2Gfp+dxEgRrl
         4ywhthyY+2++sRfgeFpUZFHz5Pv6JNExpFNSFNGnc0VmKF988VcBk7Cy14k/4f0Wne6e
         V7Ysg5bGno23v9mWaLmD6dwGpQS6mRTrCeXJxhGagrFGhT2ywdv94PA6XtXZs9poeqNd
         jSe8/9fsM7X05zsiS5PzQqO8fY+0cG5H4ouFWqtqroPHpMJR9kURigUyU1eFG3ZItQxH
         OF0f/OCaTEPPdFDFndIODFPtTnvhl45mQgcZyg8YmdSQVl78Mdscso1KBiCHPjaWodhi
         1BqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGR+whjNeV5lQ5mL6l6NHxm6IVCDzbcrLX3tF9OMg2c=;
        b=QMXAc5L2z++xSWcCr07rerZXvopUpLWuALMBdr3IHcDgPPqR6a5TCOnlcxd8idMGiN
         ul8s08kPK75sxIJdySa3IjUSedXJNUB69ZSS18wG9ryZ8e0K9LHgs7owRHTFAA2bGEHv
         Npd8I6ZN4+CjbZsGLMeB/b5QWgm8gW3JOb1AB/QkGfOzi3oMkAaipPrdoapdquu2zRFn
         OOQc/NhIR2+/6fYPzJ5d7CgS9nd3XZB2v0rPBhOPMdY9ExpsTpT8op1dExaAvq569r9e
         HWim9UyYUSgaqF/8upqd5BnMmdhDY+bcpJas2WLPzX7YZxzbsI3twEQSc3/LNPyW4Gjb
         0DmQ==
X-Gm-Message-State: AOAM533J4kTlT77wsHZVZhk0SOqdYFbM59/e0KTY31Sen51F7Cb04oj/
        IP8TlULhaJLJ8dqTZ9B3+7nx6rDHlx8=
X-Google-Smtp-Source: ABdhPJw2vYl/MbxU6VJ2DKfsjAP7X6ORyALsE94WC2xdSmRShAQQhkz7MmnTEXQPXWxJVWbbIkEk9w==
X-Received: by 2002:a05:620a:28d4:b0:6a0:9a5f:3d8b with SMTP id l20-20020a05620a28d400b006a09a5f3d8bmr6390788qkp.622.1653054784740;
        Fri, 20 May 2022 06:53:04 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id z3-20020a376503000000b0069fe1dfbeffsm2118732qkb.92.2022.05.20.06.53.04
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 06:53:04 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id i187so12068694ybg.6
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 06:53:04 -0700 (PDT)
X-Received: by 2002:a25:e012:0:b0:64f:7141:abac with SMTP id
 x18-20020a25e012000000b0064f7141abacmr1449347ybg.378.1653054783771; Fri, 20
 May 2022 06:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220520063835.866445-1-luyun_611@163.com>
In-Reply-To: <20220520063835.866445-1-luyun_611@163.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 20 May 2022 09:52:27 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdoZeAncRVAYrb66Kp6bEueWrgyy7A8qP0kmr9pxfHMoA@mail.gmail.com>
Message-ID: <CA+FuTSdoZeAncRVAYrb66Kp6bEueWrgyy7A8qP0kmr9pxfHMoA@mail.gmail.com>
Subject: Re: [PATCH] selftests/net: enable lo.accept_local in psock_snd test
To:     Yun Lu <luyun_611@163.com>
Cc:     davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 20, 2022 at 2:40 AM Yun Lu <luyun_611@163.com> wrote:
>
> From: luyun <luyun@kylinos.cn>
>
> The psock_snd test sends and recievs packets over loopback, but the
> parameter lo.accept_local is disabled by default, this test will
> fail with Resource temporarily unavailable:
> sudo ./psock_snd.sh
> dgram
> tx: 128
> rx: 142
> ./psock_snd: recv: Resource temporarily unavailable

I cannot reproduce this failure.

Passes on a machine with accept_local 0.

accept_local is defined as

"
accept_local - BOOLEAN
    Accept packets with local source addresses. In combination
    with suitable routing, this can be used to direct packets
    between two local interfaces over the wire and have them
    accepted properly.
"

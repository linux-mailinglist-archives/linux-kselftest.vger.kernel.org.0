Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A281580C1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jul 2022 09:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiGZHHK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jul 2022 03:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiGZHHJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Jul 2022 03:07:09 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D26275E3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Jul 2022 00:07:04 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id n8so4431078yba.2
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Jul 2022 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcgy86h3bKxOBeG//wWyMWAkfwgF/OHgbS5GdJlqF1Q=;
        b=rP6hiQUSnsCrLEpGMJ284D5gsGAEYG/Np9YNYB6fl6LnUVCfwCvUxh4qD3C5tJTybh
         XrZCfH6LhMs4TZkLWoBBPpiVAGUmIvCk8Qw3nT9Qu2AQAUNYU3nT4USafHn66aKeMlNJ
         yCFbhZu+bvyH00Uvz46+xPIRCAbWBd1kLGKgbyH0uCwSeggs64o0leDgdEXUQereCBF6
         D99PIPkqaJIU/zaeVVso3vdqGKZdN0BiBtol8ZP3c08H4YtCwdienRdabs2P5ikL3k6n
         yy6nVtKG38EDVLJQE7YMdfQdunpwFQWoc77YXmbOWmbcGUsOEi9FI4mmB+MuGnjZlUtU
         3AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcgy86h3bKxOBeG//wWyMWAkfwgF/OHgbS5GdJlqF1Q=;
        b=HboW5BxFdJ+J1U4sH9INa0zcCyp3ILdArGcD68Opu2uPma2qhUuWBpNSDbiTrj8eH7
         5TMHNPGlSDfcsaepW05HEodk4a6Aq/CfIvkEXUqNuMvZa0AwREYjQoxiG7Myt22/uEsu
         2kEKvnSdHyCtAqWcpj7jlxtNIHIGQ6zUPRdyDjh8TKbTUPfP1v1btTVdd2qQ6fRJHqgA
         VTG/iAzCOSTK2gXiZwJvC/KSxxNaIyaYbDuNK1GoXEg5sMnVz+0Pv21wt3Vpr4SNsuRY
         v7HdPVKEtIVxug+HzJuwGDbm8+cGindNBDHjiwzOxaVTZnzCJKRVZovDRyQiccfQJaAe
         Ebug==
X-Gm-Message-State: AJIora9Nn60W2BDlvIvSnRp8GCNmJqYdNuvUk4MlwHYbehi4thtWzQdd
        Tip23K+3kroLT775kGxD4rvWg7RGYBwLMOb67UjTwA==
X-Google-Smtp-Source: AGRyM1unbv3SV++lnD2fcV87IVw5AbZYyhPNYpke56HhITiX0I4EE/vVweiHu7FW6Bdks5azJOL6VZF4mZCvd2GLMQc=
X-Received: by 2002:a25:ab84:0:b0:671:748b:ffab with SMTP id
 v4-20020a25ab84000000b00671748bffabmr792029ybi.427.1658819223983; Tue, 26 Jul
 2022 00:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658815925.git.cdleonard@gmail.com> <ad19d5c8a24054d48e1c35bb0ec92075b9f0dc6a.1658815925.git.cdleonard@gmail.com>
In-Reply-To: <ad19d5c8a24054d48e1c35bb0ec92075b9f0dc6a.1658815925.git.cdleonard@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 26 Jul 2022 09:06:52 +0200
Message-ID: <CANn89i+ByJsdKLXi982jq0H3irYg_ANSEdmL2zwZ_7G-E_g2eg@mail.gmail.com>
Subject: Re: [PATCH v6 21/26] selftests: net/fcnal: Initial tcp_authopt support
To:     Leonard Crestez <cdleonard@gmail.com>
Cc:     David Ahern <dsahern@kernel.org>, Philip Paeps <philip@trouble.is>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 26, 2022 at 8:16 AM Leonard Crestez <cdleonard@gmail.com> wrote:
>
> Tests are mostly copied from tcp_md5 with minor changes.
>
> It covers VRF support but only based on binding multiple servers: not
> multiple keys bound to different interfaces.
>
> Also add a specific -t tcp_authopt to run only these tests specifically.
>

Thanks for the test.

Could you amend the existing TCP MD5 test to make sure dual sockets
mode is working ?

Apparently, if we have a dual stack listener socket (AF_INET6),
correct incoming IPV4 SYNs are dropped.

 If this is the case, fixing MD5 should happen first ;)

I think that we are very late in the cycle (linux-5.19 should be
released in 5 days), and your patch set should not be merged so late.

Thanks.

> Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
> ---
>

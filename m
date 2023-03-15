Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF06BBE47
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 21:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjCOU7h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 16:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCOU7g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 16:59:36 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0C15A1A4
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 13:59:35 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id n125so7150440ybg.7
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 13:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678913974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5J1gftbBFnAs5E0OeDjkL6MqIO7e45TrDAryKEcG1U=;
        b=GvrECbxXEHa073xqfbCjjRewhcvqdEVWF4+Jhoc5kdaz4wA9wVNZJFJm4LC2wjM6KJ
         7E630UPYd5hmau6LjOSDSf2mnmjlUwip38BeE1f8MzjIjTu74AwNs0EGDewMFJC+F9KK
         uRt/gkNKUvWsIROgfawYrxC19YoU2rOh30kO/6mjN4lZA2QKSw5Vd1rNG01jE/y1baXO
         7YO3JVNg74zAxIH+gYd3fgW0cZX+Ip1a5lVOfSKq0P/Oowzv5L8uXsFErjmirV2DtyC+
         q3nYXz3ERbgE38zcIiUHfKzole1/BKCRDXkLcEoJ1SE5LThAw3kPIXMIirRDaNAwJDQi
         Usiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678913974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5J1gftbBFnAs5E0OeDjkL6MqIO7e45TrDAryKEcG1U=;
        b=JQO111HL8KP5MU1/7beonKfBP1sa49Bv5g217t2fRwYgp//70+Vm2Ii+ccUbILXT7t
         U5xHMiCrbMwGc6Pdod/KzS8QBetzRa7vcIb5Pm/M5JGmuQViWbZrr3/SrozhxQMbJQ2v
         WUbgLCfk1yzruUXlX13USNRWuCHn5zYLMK7kaEOChWTzNoh5PPH3dGxKfT0DO5rnYkhL
         G3wYsiLva9yxy0MfozJu/+B+4HczYFc/d1onaOnfYCgNIsN7Y/SxWIppwnH+/RasAGm5
         H7nHSyPnsOG85UIixoSI+hpFqAob3LQTsGGteNUJeFE8ZEpZVGFs1gZFBg1DOpspDUHS
         Pdkw==
X-Gm-Message-State: AO0yUKXwe4odrS94g7+3VrKlvk325G0ILsaAIcnzkWB9lzlI6JHqs1ap
        BKUA7F4ZoAlnH68Ej18KoR2ijd4omvaq9AiqUxlnqg==
X-Google-Smtp-Source: AK7set87O1+ZcQO46k7cG6ZDEyngHB8i2jJKZwlBgbDKpLoCxE0QmEkad3o60dc5nKg11bljNSkbsCEVsF2my+d5rhY=
X-Received: by 2002:a5b:4ca:0:b0:aaf:b6ca:9a30 with SMTP id
 u10-20020a5b04ca000000b00aafb6ca9a30mr26585318ybp.6.1678913974319; Wed, 15
 Mar 2023 13:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <910f9616-fdcc-51bd-786d-8ecc9f4b5179@alu.unizg.hr> <20230315205639.38461-1-kuniyu@amazon.com>
In-Reply-To: <20230315205639.38461-1-kuniyu@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 15 Mar 2023 13:59:23 -0700
Message-ID: <CANn89iJDRG_CFWUz1GOSEi4YagCynZ-zhjq4POjbpyjkv9aawg@mail.gmail.com>
Subject: Re: BUG: selftest/net/tun: Hang in unregister_netdevice
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     mirsad.todorovac@alu.unizg.hr, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 15, 2023 at 1:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> However, we don't assume the delay and also the failure in
> tun_set_real_num_queues().
>
> In this case, we have to re-initialise the queues without
> touching kobjects.
>
> Eric,
> Are you working on this?
> If not, let me try fixing this :)

I am not working on this, please go ahead, thanks !

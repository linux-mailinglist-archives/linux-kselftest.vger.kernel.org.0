Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0570791C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 06:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjEREbK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 00:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEREbJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 00:31:09 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4250335B7
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 21:31:08 -0700 (PDT)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E26493F177
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 04:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684384264;
        bh=b+oOfiP1rI5QINs0SG6MekNu1r25dIcI5YYFcjqrpGc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=IzaITwINQ5De+kMj7cZRI7r7gow9tNIXb1bgV010Eq/XiFZmUvhrlmjVeJQtRYxCc
         ZYdX9JWQxuACGhYcMbZ36eUQPNdYakfW0BfN1d5RuUKbAhJIN1tzXoWEWwLpzQB4sM
         D4LibvAlsHE6qjezpEaHhIT1ZFtaMVpLSvultDCQJNe2dMc6jzjUvbq8JeWqzyYS/C
         /rjltdH4ZtLPyd00dMTzYF4Ylwz8xPsDD/Fo5ohdzTma1tYc6/GKTw84T1FXZx6p5j
         ckAQmhHurPVXZ8TJQzi3RRABmOZmi1uTtjXOgC71BVi5zbaJFNO4YjD1vl+xSsNnd4
         uelSOHFD5bL6A==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1964cb38b6fso417684fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 21:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684384263; x=1686976263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+oOfiP1rI5QINs0SG6MekNu1r25dIcI5YYFcjqrpGc=;
        b=mFezsDEPcWvJ8swx3cgDf5c4y8rJbnUMaF2nZoZdb7FBLMTOO+VWumVXxvf7F8+Kwx
         XSTVOEC0nCaPrlnTP9O/Y2x1ds1I7yuoNwlvyeHerML7t+ieBukC1oyrMctCKjopVp2N
         iKQ4BS+h2FtMHMUZOMCx5PNZjPUGq8idL2sKg7WRszqg815mvjx1nIdgWuhINNZa/UJY
         XCgga3tPtB4l/GFlcqJjxgHl8yJsfLMOodPNnd9OeCD6wkp7ipSJ5moIE5GJM0cudBbR
         7fOEhh9HYt12Aii7dNEKsGTL+iW8G2bvjG3trzn7/BHgERJslFohBY4wtaN393tlvTlL
         6Ecg==
X-Gm-Message-State: AC+VfDzKwsThTekNhgollw3fcfXqmVtNTt+RVwBTikPexCuVl4BXcmqw
        7ryQh0/kh8eetf/95pr2joAap7LljA7Qi0D11qnDMN97Q5vMB9HlA0v2Rk8WKoxmNroKV6TpS7G
        2Ena6+b+6Zgybx7RynGtXVPpNkc909OEpjdEokFDHq3Bo6q+HjfdCec4jICT1
X-Received: by 2002:a05:6870:a601:b0:184:4:3038 with SMTP id e1-20020a056870a60100b0018400043038mr231863oam.24.1684384263697;
        Wed, 17 May 2023 21:31:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76PMNB8QPvld50lcowqrluKsvulCwftjic0oglH6fL5bPQQ73mDIlJeqbsIloQRTGLw96BKHvZrepMbqaaQgI=
X-Received: by 2002:a05:6870:a601:b0:184:4:3038 with SMTP id
 e1-20020a056870a60100b0018400043038mr231851oam.24.1684384263434; Wed, 17 May
 2023 21:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230518033310.19893-1-po-hsu.lin@canonical.com> <20230517205130.0b44e3d0@kernel.org>
In-Reply-To: <20230517205130.0b44e3d0@kernel.org>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 18 May 2023 12:30:49 +0800
Message-ID: <CAMy_GT8=eiF5GaoUungL6d7w4Lp7s=NOE_YpBf4GEFpqrHG++Q@mail.gmail.com>
Subject: Re: [PATCHv2 net] selftests: fib_tests: mute cleanup error message
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        roxana.nicolescu@canonical.com, shuah@kernel.org,
        pabeni@redhat.com, edumazet@google.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 18, 2023 at 11:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 18 May 2023 11:33:10 +0800 Po-Hsu Lin wrote:
> > In the end of the test, there will be an error message induced by the
> > `ip netns del ns1` command in cleanup()
> >
> >   Tests passed: 201
> >   Tests failed:   0
> >   Cannot remove namespace file "/run/netns/ns1": No such file or direct=
ory
> >
> > This can even be reproduced with just `./fib_tests.sh -h` as we're
> > calling cleanup() on exit.
> >
> > Redirect the error message to /dev/null to mute it.
> >
> > V2: Update commit message and fixes tag.
> >
> > Fixes: b60417a9f2b8 ("selftest: fib_tests: Always cleanup before exit")
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> missing cc netdev
Sorry my bad, wrong copy-paste, will improve the workflow to make sure
this won't happen again.
V3 is on its way

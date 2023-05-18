Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E58707867
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 05:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjERDWx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 23:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjERDWv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 23:22:51 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1331724
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 20:22:49 -0700 (PDT)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 051133F436
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 03:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684380168;
        bh=Gi4VEKOMa2h3a92P3bc7WeGm4ywxJ/65UScMzNMWt9g=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=bX8IqC40EOAP8pTuipBl//j+yIo6kiDL6AgW34yo8g0O9Y/V1DsBiXLKzDhPnkwYr
         KNlTcDX8mwhBK7C0ZrzeOOJdr8Fn0uEyQ0dYe8HVxCmx7A5xoiaDD6Q06t7G8mOhBf
         se+kadhnm0T8QQ1eSMexTokSavHp3usRjy0F6u7b/Bc7uF/GIu/iBJzYMtcTLKSL+R
         IilEAP/6l/KRHTGBm7ECqNyqkquMB7+i6J625gyXeVyZ/YmSMRSfwRsxvWn8G3bQ0t
         ycTDhGX4qjK1noEGWoVJ39bB0s0ttEK/QywNKcnYnfcTM1vc82lnTcqiLUmzkiaePU
         2zIDtz6U0WF1A==
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6ab1f10384fso486644a34.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 20:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684380167; x=1686972167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi4VEKOMa2h3a92P3bc7WeGm4ywxJ/65UScMzNMWt9g=;
        b=dulOILEqCwfrT73CrkQdSRzTz3thEuVcPENrCBGyWKpGfRR/FZeApr/TX0ch6UCauH
         G3FUmcYbhHZN+/6xnOqCtAF5d/KkkgwCzrdx6bA4Zr2D8Mp55btEVm1ebFEUPbTThkOB
         Me/7f8ZpXrflYwwlGWN+/ll+SrrYxGQuJgj43dQ7oFv/FsrLPRkAemaC+PXSlvsK1LIY
         C9UVJ+v92+hzAVYBIzsqTYfdxVVQVwlRkyH5Q6ESrE6pYwy3sQDwVyjNTkLupS/v60/N
         HotNUe5YBjaTTIxHp8JVybPHtZLsCrp9KbwrWeCEY6pcbBVxUdNloAhUOIkcd0YGQGJE
         BB9g==
X-Gm-Message-State: AC+VfDw61n6Ss/HJwqcMgstkEUvirtmy6PIZ1KByZAdUw8YUVjZh7bXU
        +hZ+L6AvBiIiZxgPcdrXjgJ6NUu0/gya7+JeV/AjZvuFG7TjRME8JSu2OYh8M5e8DRBzAYP2vdY
        E4SeaEXkIQPDJTkkNgcrqQscSjAG8kbQ7GKHK8FK73vNHigzNisNefZZeEwfn
X-Received: by 2002:a05:6870:a343:b0:17e:5166:e5ad with SMTP id y3-20020a056870a34300b0017e5166e5admr99277oak.44.1684380166735;
        Wed, 17 May 2023 20:22:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Di+BGi2T2Y8o48hf73VHtmqnUhbnSLeez5vG0gzZcxFpeZcJDMLOxz1YGfRxkX+0YNvwFmiA9PRUEr7Fdn9Q=
X-Received: by 2002:a05:6870:a343:b0:17e:5166:e5ad with SMTP id
 y3-20020a056870a34300b0017e5166e5admr99266oak.44.1684380166509; Wed, 17 May
 2023 20:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230517041119.202072-1-po-hsu.lin@canonical.com> <ZGRthdt5u88zs6xy@shredder>
In-Reply-To: <ZGRthdt5u88zs6xy@shredder>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 18 May 2023 11:22:35 +0800
Message-ID: <CAMy_GT9SYNzhDx6Eod8VXkDM+eKnn+5NjxvBvd5bORF9kBBu_g@mail.gmail.com>
Subject: Re: [PATCH] selftests: fib_tests: mute cleanup error message
To:     Ido Schimmel <idosch@idosch.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, dsahern@gmail.com, shuah@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net
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

On Wed, May 17, 2023 at 2:00=E2=80=AFPM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Wed, May 17, 2023 at 12:11:19PM +0800, Po-Hsu Lin wrote:
> > In the end of the test, there will be an error message induced by the
> > `ip netns del ns1` command in cleanup()
> >
> >   Tests passed: 201
> >   Tests failed:   0
> >   Cannot remove namespace file "/run/netns/ns1": No such file or direct=
ory
> >
> > Redirect the error message to /dev/null to mute it.
> >
> > Fixes: a0e11da78f48 ("fib_tests: Add tests for metrics on routes")
>
> I don't think this tag is correct. More likely that this is caused by
> commit b60417a9f2b8 ("selftest: fib_tests: Always cleanup before exit").
>
> You can even reproduce it with '-h':
>
> # ./fib_tests.sh -h
> usage: fib_tests.sh OPTS
> [...]
> Cannot remove namespace file "/var/run/netns/ns1": No such file or direct=
ory
>
> Reverting the commit I mentioned makes it go away.
>
> Also, please use "PATCH net" prefix:
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#tl-=
dr

Thank you!
I will submit V2 for this.

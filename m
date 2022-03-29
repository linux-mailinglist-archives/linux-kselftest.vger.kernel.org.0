Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D144EAFB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiC2O6F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbiC2O5y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 10:57:54 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C014A776F
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 07:56:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id f38so32020067ybi.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nshrKIEYRvhhGChQcKo4/WOLaQnHQ7MVr4HJAx+7fCM=;
        b=nggyKR34xWau0YYyvwRQmqNf9ML1VUesMAdYb4bOC5T6MuMC0oScBD2d7pXU2POk77
         OA4BbnVNrJ/t+4seBYsW1QUFLpdNB6RrJiFde4LaBHQ/r12FJt2gzxRTW8LymOj/pVhy
         leltTJ19+pv50/jnTippeLzYBRxglgDocamhIt19GHngMQJ6QVjKQtHSXZWOolE1xVHG
         Fzu3WhBC+A3LTZiFHKZYoP23n5hJbeqyqfPWSMXWhzL+9McgSFJ0KHDUr927WbXMvg6x
         M5dNJvjj8M3k3WqJL0ixqb0h3Fhqht5a64AF7kh03Hogj+r8r0L9SNWYQUgVT1NlCqU/
         qt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nshrKIEYRvhhGChQcKo4/WOLaQnHQ7MVr4HJAx+7fCM=;
        b=OfU/lbaE/zanZY01EeWcljDmm6PSXK3AmF0NYhQfIuq3t+FES3xypjL7p1ir2igvbg
         gAd5lEX0ITR26WWXafSUhuQTT31ePLUK9CudhgX8e8DXcvS3Rz5M5AtgLiCyzQ/24CVi
         82f13zsYHOXlSEU0UFqpP3HeWkwxPQYEEbxin0JyfJbQqq/RUeKSCtuHxT/rAZBAxiPn
         kOOF9cqD12XnnfzdFUeUPDvrcBXNLtTBKDxCWnpNMHh1PiGaYFmU4FIX/l9Rl1SeNB86
         8HZRlxXYn+h4A/C4ELKV0K/mr8AA7SxGKRB9rVgW/Ivp2L3kzkzn+HTeVLFG/pEbrJCy
         XdTQ==
X-Gm-Message-State: AOAM533pwVYsngJt3yPluj1o2dVjxU3dUNZ+bGj4LncVqTjxJ4JGUVQK
        Pra5KfiVmkUOSsZPqanDWDD3J5m9t7NsvnW0Hu+/QA==
X-Google-Smtp-Source: ABdhPJzoobXvGwgVjEd4j6mZ3qHA6/OVAWfOgVyjNLjrxiHrXHlyz8bg5YJXfrvmRHUumsoONLU2HBM7F1EdIIEXfJc=
X-Received: by 2002:a5b:892:0:b0:633:ba98:d566 with SMTP id
 e18-20020a5b0892000000b00633ba98d566mr28126807ybq.128.1648565770277; Tue, 29
 Mar 2022 07:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220328134650.72265-1-naresh.kamboju@linaro.org> <20220328135430.2ad39326@kernel.org>
In-Reply-To: <20220328135430.2ad39326@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Mar 2022 20:25:59 +0530
Message-ID: <CA+G9fYvxTtZTWHcobG_WTg7zH6nygyeugib-tJ1Ka2NX2+4ZqQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: net: Add tls config dependency for tls selftests
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, pabeni@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jakub

On Tue, 29 Mar 2022 at 02:24, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 28 Mar 2022 19:16:50 +0530 Naresh Kamboju wrote:
> > selftest net tls test cases need TLS=m without this the test hangs.
>
> The test is supposed to fall back / skip cleanly when TLS is not built.
> That's useful to test compatibility with TCP.
>
> It'd be great if you could reply to questions I asked you on your
> report instead of sending out incorrect patches.

I have replied to your question on other email thread [1]

- Naresh

[1] https://lore.kernel.org/linux-next/CA+G9fYsjP2+20YLbKTFU-4_v+VLq6MfaagjERL9PWETs+sX8Zg@mail.gmail.com/

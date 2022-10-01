Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED385F1BBD
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 12:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJAKNJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Oct 2022 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJAKNH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Oct 2022 06:13:07 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F4F1280C3;
        Sat,  1 Oct 2022 03:12:52 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p202so5034198iod.6;
        Sat, 01 Oct 2022 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6GSY4qcwaFrNmEXNiR+4xSvq+FPAuDaCRfPDxH8mn+U=;
        b=j6FQDMOHqhB+Kqr2jUI0KKPcCPxAuaXzBbFZJQ9xBP8GYyqZoC+0DtjiI/FT/BERAs
         nikqopXpoO4XWYPKO/y9vYK9EFhZm9CuDgt5peELtXytLvQSjepCB8456dKMIOmLYBYI
         ZKJq5+CCjvf0dgPm+Mcs19Nbj3wdQC6YtNN8TkB+222/Dpla5zISZqaO5QU1gwuCn2Af
         B+2oCAlRQWKRfrsZVMukdjgGVAVZNiJFYOUVPnj8S8ylgZl5k49b2j/7K00O6bdVT7Rs
         dh5XMAqPLUMScNs6cpcg7pRkqjulJ828UTByaMmjjHJ8zTuOYeWahpjujVThqmnzVR36
         Gmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6GSY4qcwaFrNmEXNiR+4xSvq+FPAuDaCRfPDxH8mn+U=;
        b=c1jixnmJc1CBz2Ptyjmt/72rra7JYdUQxCfolblw1akhXuIrBAu3VaNZmNrkAZPCco
         vdeC+Iif5CKey/yGN9lP0Oprd2hdp5NFABxxBMk/tGepDkP5HwdSLYpBWFbEysXU/eH+
         0kJzwiPrrIdVzS4ih6qiEz2QbEhCDNt8re7CtPHuLkHFelSn19hztuINsKbaS0dYmGfT
         Y/nUloR1wRx6SQwBJjM9vF172A88lmjtxMvgI09QZ9QHeI3njKE5p30/7y+YlFB86/pL
         sgnW1sqzpeMC1frY54eL11hncOywc6qVxm9/b3jd542L6r1WzPhKROCG3c8cEgPaonVl
         b3LA==
X-Gm-Message-State: ACrzQf0UYrRHeeTcHr2voyFUqhiE9MdsHnkxKnW4SLByKCZGaUCHUg28
        fIERZn3LZFGC9v0yMjYUv7qNR94eu5HzhTtQLsmyM1DAULZI5g==
X-Google-Smtp-Source: AMsMyM4Um7lCeAnU7AhsQ9EKmAK7K/3OQy9UQ5uE26WQEPTWZwx+Cb6VgPlo12EkGzM16uz0DMBDbis8gqB89BOKt3c=
X-Received: by 2002:a05:6638:218f:b0:35a:7f20:6a57 with SMTP id
 s15-20020a056638218f00b0035a7f206a57mr6560246jaj.186.1664619171887; Sat, 01
 Oct 2022 03:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com> <20221001002638.2881842-4-dlatypov@google.com>
In-Reply-To: <20221001002638.2881842-4-dlatypov@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Oct 2022 12:12:41 +0200
Message-ID: <CANiq72=H-HkE6FQrPFC9s83VW9sPPQbiZ7+iCqjrsvUkkW0MVw@mail.gmail.com>
Subject: Re: [PATCH 3/4] kunit: eliminate KUNIT_INIT_*_ASSERT_STRUCT macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 1, 2022 at 2:26 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> But we can work around this with the following generic macro
>   #define KUNIT_INIT_ASSERT(initializers...) { initializers }

Is it intended to be internal, right? Should be prefixed by `_` then?

Cheers,
Miguel

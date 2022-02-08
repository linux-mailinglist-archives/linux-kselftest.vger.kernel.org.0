Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919BD4ACD65
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiBHBGS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiBHAQk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 19:16:40 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57868C061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 16:16:40 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id eg42so18031742edb.7
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 16:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FUC6ZAqrJKqRqsz2dka0HA9ZqAZrYwhb0gCpwv/n5I=;
        b=cW4AAOG65K03qN7P5SJ0+txK4LH6RrNpnnkVc3Ip6wHn+RX3yauouMt11vlwnfPhir
         rhT/+UDZvvYMGWsmcnWgWQYO0z8ZJVKIYYDaKKaNRlxssTmrMaAuR4y+Cygkcmixu8lN
         OokjeY7lDRVJ1+B8UBQE/BaaYCDOgIm4+7jxASdC25pfAKVy+bU7o7Ei1odc3xDIBCBL
         NaTIJLcfrNCeubH6UWqHn3/z+trlTFurkjB5Xx7fU8GsCWVaYE3YPPTx4AR392+Oy3LN
         5470i7g96aGl1mmBHZnU3VGSnq2I1seVp6BG+twZLQLVijy31SO3nJxbKbM/xIqh8H/4
         CO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FUC6ZAqrJKqRqsz2dka0HA9ZqAZrYwhb0gCpwv/n5I=;
        b=iqnvAvG2Y3378Dr5GBJICX3+MW2CaLOeT91zWeB5hmEy5T66b49V4E35jqhmw/iJNs
         jgSIg0PVo6ubsY8TQWVWsKYrYiDAO+O/FLIqanyBgHB0ZP5Zc4cw1SVoSRHI4F6L0XPG
         U/rdsmZdI0V4p6+GVnV44bUEnc6SSKWm+qptFO9duXrr1ulTFIEc84woWtWxQD8P0kPm
         d9JrN4fWo81UW6JIHuDHact6ZAOn59SIEwDVct3OxLgcqSxpZipMllKGYg7qvydKIGDY
         Wp26FVpMxsALnRH0TlMonRjw4mr6Id2ShTFEiOXaEuR8c45aVVpyP4aGKODUN3lQpazM
         M3rQ==
X-Gm-Message-State: AOAM5321fY23SLZzKnE1R/xS+oHeO+NqeMt1FFo7fUv7pJbPokBlYvWW
        eENxRZWTXQ3rZQJz/7LxjxrfrjefABbC9pqdlaGIGQ==
X-Google-Smtp-Source: ABdhPJwobCWW1Ed49/ZW2vQAVTE1GY0OkgJGSPbPUXRiCT2AEU3YtrntrH9+EaR7L3e1wo7uWU8Osd5vs/QW9hH4iFM=
X-Received: by 2002:a05:6402:42d4:: with SMTP id i20mr1961564edc.306.1644279398782;
 Mon, 07 Feb 2022 16:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20220207211144.1948690-1-ribalda@chromium.org> <20220207211144.1948690-5-ribalda@chromium.org>
In-Reply-To: <20220207211144.1948690-5-ribalda@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Feb 2022 16:16:27 -0800
Message-ID: <CAGS_qxqYVagWo=CWBmYvhnsFU7=mcELzkKLsB3_VO-rgPxqu0A@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mctp: test: Use NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 7, 2022 at 1:11 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Replace the PTR_EQ NULL checks wit the NULL macros. More idiomatic and
> specific.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Daniel Latypov <dlatypov@google.com>

> ---
>  net/mctp/test/route-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
> index 750f9f9b4daf..eb70b524c78e 100644
> --- a/net/mctp/test/route-test.c
> +++ b/net/mctp/test/route-test.c
> @@ -361,7 +361,7 @@ static void mctp_test_route_input_sk(struct kunit *test)
>         } else {
>                 KUNIT_EXPECT_NE(test, rc, 0);
>                 skb2 = skb_recv_datagram(sock->sk, 0, 1, &rc);
> -               KUNIT_EXPECT_PTR_EQ(test, skb2, NULL);
> +               KUNIT_EXPECT_NULL(test, skb2);
>         }
>
>         __mctp_route_test_fini(test, dev, rt, sock);
> @@ -430,7 +430,7 @@ static void mctp_test_route_input_sk_reasm(struct kunit *test)
>                 skb_free_datagram(sock->sk, skb2);
>
>         } else {
> -               KUNIT_EXPECT_PTR_EQ(test, skb2, NULL);
> +               KUNIT_EXPECT_NULL(test, skb2);
>         }
>
>         __mctp_route_test_fini(test, dev, rt, sock);
> --
> 2.35.0.263.gb82422642f-goog
>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646BC573E89
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 23:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbiGMVJC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 17:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiGMVJB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 17:09:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50280167C4
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 14:08:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ez10so22006642ejc.13
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=joNprEeghBgM9IHa4iiYjH9rl8iDNY24HUyPswAsmd8=;
        b=eVrp2XJ/S0ULb0BbB+hOGvt8BJrBJemI0i4D//4f11TRt7nQMhieW15OJPMOFjDXNW
         gk1tW7gH68LhIfkjHG+jTKR3W3iM1yILmkqoXZsiMKEWnHVg9pH4XXebx9cqR3g+TCrk
         Zj+uXBC+khoFJgn1AewNeNaK747MQLLWfjkKTxSPAs5YUo/4yks9F9fqCsmz2qM7SpbY
         EoUrh4uRoV49gkSvm/nJGQa82rEeOobkO1cLIL5aG6ZPT4uaVgTIhTQppCx7d75uhPxE
         BBCLSwKZGfNl9rd5F0EfaoHMyaUwfF+ZOx1QHZvgofigs+V+dPEMOca/a+8VQY8ro3HA
         me9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joNprEeghBgM9IHa4iiYjH9rl8iDNY24HUyPswAsmd8=;
        b=ECFe9pODOKcrxqkiIJH7fq61nFU1oEKwlO60dmZz9EhBS0WGpHI5VptgQJUaXurz9v
         R9RaM0YIiNR3MwL3jBxtmYc91FAQVJppCuH4aOS5ReZRXo1zNe7Jbv4ZzNO+IWKU+puk
         kUSNmBi/OkYzqDTuAjFD9HkKE8OfkSnUKkP7JOezb4gVoISvamYiguhXD2klcOXw99tI
         gM2a9d4bTNFWEzEPeYfd+FCEA8UuPw9LjwC7/JqCCwEY0WJ/NHqCpptH3GTVrpqSox4h
         u0FhL7NJ5IzgzI5EUXvxRCtoIEHVhyKu4SqT/hKn7JxAarwe4vEUYvRvKLNaGcN8ELTL
         gZyA==
X-Gm-Message-State: AJIora/S+BSujm83B4WfzP3cZZrDj9StI8YT0P5UlvxeiYnwxHy565Xw
        MwYrpNbqQcWA7ulmpAa+CbfiW5onT18MQmQaiOPTTw==
X-Google-Smtp-Source: AGRyM1vi41yo+5vshIoXBlCHuGemnZQGJJW2aQ31uABZv485i86opVLZATbEbv1rE7brkm2ozeMq51KqmdDNIpFVr5w=
X-Received: by 2002:a17:907:3f81:b0:6ff:1a3d:9092 with SMTP id
 hr1-20020a1709073f8100b006ff1a3d9092mr5251589ejc.319.1657746537718; Wed, 13
 Jul 2022 14:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220711162713.2467476-1-dlatypov@google.com>
In-Reply-To: <20220711162713.2467476-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 13 Jul 2022 17:08:46 -0400
Message-ID: <CAFd5g47bt5Aop2onFpzbcMmWNncxPg6Ju+nomZz33f4kEEHWZA@mail.gmail.com>
Subject: Re: [PATCH] clk: explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in .kunitconfig
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, Maxime Ripard <maxime@cerno.tech>
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

On Mon, Jul 11, 2022 at 12:27 PM 'Daniel Latypov' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> CONFIG_UML_PCI_OVER_VIRTIO=y is needed to enable CONFIG_PCI=y on UML.
> However, this causes test failures when running the clk tests, i.e.
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/clk
>
> A snippet of the particular error is:
> >     ok 1 - clk_gate_test_parent_rate
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 45 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
>
> This is triggered by this cast in the test:
>    143          ctx->fake_mem = (void __force __iomem *)&ctx->fake_reg;
> this seems to work except when logic iomem is enabled, i.e.
> CONFIG_INDIRECT_IOMEM=y.
>
> As a short-term fix, explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in
> drivers/clk/.kunitconfig so we can enable it for everyone else by
> default in kunit.py.
>
> The long-term fix probably requires something more complicated, like
>   #ifdef CONFIG_INDIRECT_IOMEM
>     logic_iomem_add_region(...);
>   #endif
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reported-by: Maxime Ripard <maxime@cerno.tech>
> Tested-by: Maxime Ripard <maxime@cerno.tech>

Acked-by: Brendan Higgins <brendanhiggins@google.com>

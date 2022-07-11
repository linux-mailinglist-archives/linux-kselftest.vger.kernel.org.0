Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC67957084F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jul 2022 18:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiGKQ2Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiGKQ2X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 12:28:23 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2877AC34
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jul 2022 09:28:22 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id u6so5229551iop.5
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jul 2022 09:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/tk/TUFQLGbAdc70/LIvZeDeOJPiToJkYt+rZXyPGA=;
        b=IeKhf7GuNYxyS7A5kM2JnoniDfNQzoVPthpIqtMv3+6U30NTpn6G07pu9vGhiao0Ku
         fHX6DxUhj/z6yZ8A4BTcS3XVPgK4E37NvLzwlIwit3s048xuQ0lEsx1D6G/cziobV95g
         kL+hNzr0FzjVGCF8iK/wrfStmG8e229zrMTTdG+5DFA5jqKM9SGRlTxepl9ymN99vdOK
         HbeIr/4224WR8ed88hoL62IwD6IbRuc0dDeyE2H2BJKdftrtu/F+Sf6YyIHKefGxkZcU
         o8PuiOoSFZz6F8Bhl3jEnt5VS7fDFdomJLpy8lEcWZvyh3ICImSa257DaJtZ73Y2xWkT
         QIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/tk/TUFQLGbAdc70/LIvZeDeOJPiToJkYt+rZXyPGA=;
        b=TPDWZFejuWWZBfxKAR08Gv+JnIPBDtwfd67iHG0yM4NM+So5UqlJTAZrcbgltADh5t
         6ltXSDgjTqqiAiG0FmDXrZ5Olfl2X83VwMdbAwyiTpT8oONhwNa8OzCN3t6We6cr5Z9O
         T7mDys4OHGzExCaZ4saQCIusUnHo/QausPdOuso7T7FDQfittzy4A09iEhcEm17A10+W
         sjOtFfOmzQnYnACadzDKNX2gEoqgmNHw/i8Ej+edo6e5flbwkt4/dRJho64mD6hYYo5/
         WPvv/PbRF+es2z0MirYAnjEFoMlrglmqpHT75JNvSk9KtR6dydyIRSNHaML4bW+4xuyT
         Ikow==
X-Gm-Message-State: AJIora+4jmSGCMnBTKdwoVkY4CkjPw5mb4nVTI9x4OOnG9rfSYO1KSso
        Ra5yt+tio1Jw/7/eXxSTFOV3cPoS/UKkmLMc4nZfmzg3KXi+gA==
X-Google-Smtp-Source: AGRyM1tDNLf6Lfp+ypFfP4tVKghz09e9evCMz55QESThGK1cUTEIZHaOrDekXzJ95vPb9tlIuBBvhWZYko2arK0dFeQ=
X-Received: by 2002:a6b:3e83:0:b0:678:e63b:355d with SMTP id
 l125-20020a6b3e83000000b00678e63b355dmr9793523ioa.134.1657556901473; Mon, 11
 Jul 2022 09:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220708162711.1309633-1-dlatypov@google.com> <20220711144651.yekrivauz3phkuvm@houat>
 <CAGS_qxp=UAJ19zQOZKP8ywPiNAj4wT80ubH2YW060mmADoqBcw@mail.gmail.com> <20220711155005.lnebdh534ntmf4sv@houat>
In-Reply-To: <20220711155005.lnebdh534ntmf4sv@houat>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 11 Jul 2022 09:28:10 -0700
Message-ID: <CAGS_qxqFAdSCJBrmgY=FvwSjLrdMHqYW4gjh41VaYYh=1PybqQ@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: tool: Enable virtio/PCI by default on UML
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
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

On Mon, Jul 11, 2022 at 8:50 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > A simple fix we could carry in the KUnit branch is this:
> >
> > diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
> > index cdbc7d7deba9..2fbeb71316f8 100644
> > --- a/drivers/clk/.kunitconfig
> > +++ b/drivers/clk/.kunitconfig
> > @@ -2,3 +2,4 @@ CONFIG_KUNIT=y
> >  CONFIG_COMMON_CLK=y
> >  CONFIG_CLK_KUNIT_TEST=y
> >  CONFIG_CLK_GATE_KUNIT_TEST=y
> > +CONFIG_UML_PCI_OVER_VIRTIO=n
>
> It works for me now thanks
>
> Feel free to add my Tested-by
>
> Maxime

Thanks, sending out
https://lore.kernel.org/linux-kselftest/20220711162713.2467476-1-dlatypov@google.com

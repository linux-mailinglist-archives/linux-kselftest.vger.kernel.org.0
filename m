Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1845706AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jul 2022 17:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiGKPKu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 11:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGKPKt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 11:10:49 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE6B747B0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jul 2022 08:10:48 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p128so5203936iof.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jul 2022 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKpFWpGY0hXoQIb5wD82pXS413+2Z65GNbTveQzCW18=;
        b=MRk9+HbRvfJ+4gcEttrxCskOj0BK2Cmbb1YFoaYKliW3IGq/Hs3LzP3/0MXew7UWL+
         VMc9mfyIm8XdcJMDFwVljpTXUGN8vX/0CDFLhD077U3qgRxYZfI9qE5L2ZY8AHZ1tsdX
         a7lJuohMg43lxOXjYgkUdRaxzihAQM2V4K4DCG6faS1Db/JM5sL/UM772OpiwDpsvcaT
         f76P2OWkydPIY5iuZCcyZud8fAsRcJsaaCF7zZ83iKxOP3weRJGLV1zSx0rpTv+F97Oy
         HYOn6LQRv3VIZB8rPG2bEtURRjAD4wJInyRDl9/1H9brKWQky7DUVT6/kVnHsep08U4J
         Tk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKpFWpGY0hXoQIb5wD82pXS413+2Z65GNbTveQzCW18=;
        b=OgX9ux1ZDn2+LIu68aSQf7rUEVpuFUbatL9K4bTO3oj1yB7v65/gPWKKeu8BgAqKvF
         6zWHTI/na3ZOZO0Yq3YQViMkG99LP6DASlhWw7NCOsDQ+rIwmJukHqpLCvq5tohtaecu
         3vp0h9LaqxikjVkbD7a3BA6h6erepPWUitx6UA8ITYY6YvlJtvl96JJn0bXFqB59DFkA
         pZV1VBxQcZJuuE0hnSxt22okWkM48yt/lvrg/7/6/RUotyLb7ufC/jOQ9fyrayCgPEA6
         rSJgoLFDtHyIHn93/0vHATR8A4Pk7g534yLfp8fDuGCeM4FEvJTQgHMJvSGCBCxAlKpl
         SMQg==
X-Gm-Message-State: AJIora8mSXhe/7dZQTZ9AtIXjZk3jtrljLVXiclpq86uQ1Jy/nQXLHlm
        PJF6gpbMF9JxuNjh8urWqynb+gllC2G8iUen3w3HYtE+eeCDkw==
X-Google-Smtp-Source: AGRyM1u9fCra3XN36tzejTX5ACgKM/FySKUP1jrWJwaXmYXu0WfZ3ZjlZ11EZ4uX7jFNpiSTHKHVKuAM/yGVSvCp8kU=
X-Received: by 2002:a05:6602:2e8d:b0:64f:b683:c70d with SMTP id
 m13-20020a0566022e8d00b0064fb683c70dmr9382841iow.62.1657552247691; Mon, 11
 Jul 2022 08:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220708162711.1309633-1-dlatypov@google.com> <20220711144651.yekrivauz3phkuvm@houat>
In-Reply-To: <20220711144651.yekrivauz3phkuvm@houat>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 11 Jul 2022 08:10:36 -0700
Message-ID: <CAGS_qxp=UAJ19zQOZKP8ywPiNAj4wT80ubH2YW060mmADoqBcw@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 11, 2022 at 7:46 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Unfortunately, this breaks the clock tests in next-20220711:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/clk/.kunitconfig  --raw_output

Thanks, this is indeed an issue.

I remember noticing this in early April.
I incorrectly remembered that a fix had been sent.

A more minimal reproducer:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/clk
'clk-gate-test.clk_gate_test_enable'

The part of the test that becomes problematic with this patch (i.e.
enabling logic iomem) is the cast on line 143.

   130  struct clk_gate_test_context {
   131          void __iomem *fake_mem;
   132          struct clk_hw *hw;
   133          struct clk_hw *parent;
   134          u32 fake_reg; /* Keep at end, KASAN can detect out of bounds */
   135  };
   136
   137  static struct clk_gate_test_context
*clk_gate_test_alloc_ctx(struct kunit *test)
   138  {
   139          struct clk_gate_test_context *ctx;
   140
   141          test->priv = ctx = kunit_kzalloc(test, sizeof(*ctx),
GFP_KERNEL);
   142          KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
   143          ctx->fake_mem = (void __force __iomem *)&ctx->fake_reg;
   144
   145          return ctx;
   146  }

A simple fix we could carry in the KUnit branch is this:

diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
index cdbc7d7deba9..2fbeb71316f8 100644
--- a/drivers/clk/.kunitconfig
+++ b/drivers/clk/.kunitconfig
@@ -2,3 +2,4 @@ CONFIG_KUNIT=y
 CONFIG_COMMON_CLK=y
 CONFIG_CLK_KUNIT_TEST=y
 CONFIG_CLK_GATE_KUNIT_TEST=y
+CONFIG_UML_PCI_OVER_VIRTIO=n

The new ability to disable it comes from
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=8a7c6f859a20ca36a9e3ce71662de697898c9ef5

Thoughts?

Daniel

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D2570C2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jul 2022 22:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiGKUtD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 16:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGKUtC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 16:49:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A9D11173;
        Mon, 11 Jul 2022 13:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E49EE6168C;
        Mon, 11 Jul 2022 20:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDD5C34115;
        Mon, 11 Jul 2022 20:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657572539;
        bh=zuU3VsAsUph7e7zwXq/2Epxqe4K3n6QYBMJuw+41dg4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QEZdIJJu0iVDm5NdwtCFe8ql1UaFVZCcBfNxEaQasbGH2e7uNQEXBN7doLRzt2Bsy
         fs1vcf55GP8RVcGkH99C1uibkz/WVo6CqTcGCPMf76uao0WqlGEaDab+BHznqGcKWN
         q3Z2sBjpDR338LdZl+EPanBntinMBqPKGHT/n2XtlYlk9Rgsg9SJ2I6nIgNW0x8Yjs
         4cmMd8K9DZe8kCVEBa0rYUMaZs1lEB++Rkdybbjm3iAET1jz7drgtyxFSCbDvkqHTK
         enwqPC13nWd6/4hp9rcochN04yl2mCLLHO7xE+XG7hmnC0s4HGV/HccK710csMM5bV
         pxnTx7huysVhw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220711162713.2467476-1-dlatypov@google.com>
References: <20220711162713.2467476-1-dlatypov@google.com>
Subject: Re: [PATCH] clk: explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in .kunitconfig
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        linux-clk@vger.kernel.org, Daniel Latypov <dlatypov@google.com>,
        Maxime Ripard <maxime@cerno.tech>
To:     Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com,
        davidgow@google.com
Date:   Mon, 11 Jul 2022 13:48:57 -0700
User-Agent: alot/0.10
Message-Id: <20220711204859.3DDD5C34115@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Daniel Latypov (2022-07-11 09:27:13)
> CONFIG_UML_PCI_OVER_VIRTIO=3Dy is needed to enable CONFIG_PCI=3Dy on UML.
> However, this causes test failures when running the clk tests, i.e.
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/clk
>=20
> A snippet of the particular error is:
> >     ok 1 - clk_gate_test_parent_rate
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 45 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
>=20
> This is triggered by this cast in the test:
>    143          ctx->fake_mem =3D (void __force __iomem *)&ctx->fake_reg;
> this seems to work except when logic iomem is enabled, i.e.
> CONFIG_INDIRECT_IOMEM=3Dy.
>=20
> As a short-term fix, explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in
> drivers/clk/.kunitconfig so we can enable it for everyone else by
> default in kunit.py.
>=20
> The long-term fix probably requires something more complicated, like
>   #ifdef CONFIG_INDIRECT_IOMEM
>     logic_iomem_add_region(...);
>   #endif

If this is how platform IO is mocked then yes we'll have to implement
that.

>=20
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reported-by: Maxime Ripard <maxime@cerno.tech>
> Tested-by: Maxime Ripard <maxime@cerno.tech>
> ---
> Note: this targeting the -kselftest kunit branch.
> There's a commit that triggers this by enabling logic iomem by default
> [1] and there's also a commit that lets disable it via kunitconfig file
> [2], which this fix relies on.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest=
.git/commit/?h=3Dkunit&id=3D6fc3a8636a7b0f7dbd6d0a4e450e765dc17518d4
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest=
.git/commit/?h=3Dkunit&id=3D8a7c6f859a20ca36a9e3ce71662de697898c9ef5
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

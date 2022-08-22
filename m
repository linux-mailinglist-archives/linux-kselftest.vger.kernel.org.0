Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC859C99A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiHVUJ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 16:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiHVUJU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 16:09:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5228A5283B
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 13:09:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d1so75873edn.9
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YrWKYX54XcRB+7IefpmY6sNaaz9UJEYvmrEmm7qSZ0w=;
        b=YZscAe3hvQ0GokHKrJV2pgBBBdaOb19jklY1so7x0tSJ3zokBPhqGM4y0pGoaxaOuj
         3dDRW4fLhxoFrKpfS1D/GZ26cm0qgE75QCuCSNxci8zCKLUmRutksku1sYJGYnLZX4fh
         yjpr0K1vrN6Yer42eYdbtS7qCmk0UB/Zw0XQDaRsQ2i4xkFA9SOVZNZn06PVqj30Yvnl
         dDqfIazJVFqjPjfi8EffFFrV8cBnbThGdolRAZaOfUV8zPsIEhRy143aOqj3nodEixdQ
         aGs336eeTsPKaVrdF09pk4sY7MtHPfT0pJW1inoesuoKBUitXXH+kWQlnWzbiAfwWsr8
         D0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YrWKYX54XcRB+7IefpmY6sNaaz9UJEYvmrEmm7qSZ0w=;
        b=yWPt28EDg2+t2KyXW2Udg1IdYqId+ENOBTE0E0GmBFRMsf4hM8ZPJl5zIFxUVHeuEE
         m2Fbb6yVgQLX+fjHaTBkwhcVYl6gBU1KYsTaJn33A2QbOqWiF0f5GatEnN2kyzHLl6kN
         w55jHtBv9wRz+0FVoiWOHySwk6HPn+lb7cONTdIxG+OUTLpeMYbjStNzoUrBGorUUg5M
         HY1OD4ye9dRH2aUSvj7QYH3L1RaDdVuUQIzCmLATKqOGfuENoc2jrldoq5zyUrreTmt1
         z9GDkc3P1HBAw2ZFdhah12wI67fNB9EDhots5WeTXkytCaeCvfmLWngEz3idBoURq+cm
         j4pw==
X-Gm-Message-State: ACgBeo0tZtEwfOXoUq9/MU3uwdySk/+gyV7KaTeTvqKWLU+WRbfVlkse
        IvCzOrz2tEKyBQeLJeLGV/y8nfMep+q4+1euPhUokQ==
X-Google-Smtp-Source: AA6agR4s5hz9NH5pqWr3RTrYVcWyakcoE03sHmsj+SPDDimTow1sGJFpuYGQx6+0ltAYD4Y6ruT0BCn4teZ0Z6tMAiM=
X-Received: by 2002:a05:6402:22b8:b0:445:fb3f:dc3d with SMTP id
 cx24-20020a05640222b800b00445fb3fdc3dmr678328edb.378.1661198956693; Mon, 22
 Aug 2022 13:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220819053234.241501-1-tales.aparecida@gmail.com> <20220819053234.241501-8-tales.aparecida@gmail.com>
In-Reply-To: <20220819053234.241501-8-tales.aparecida@gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 22 Aug 2022 13:09:05 -0700
Message-ID: <CAGS_qxoVuRPF39kcVBWGuhnmaixfLAkPN6HaDRyuXmDHqmWPXg@mail.gmail.com>
Subject: Re: [PATCH 7/8] lib: overflow: update reference to kunit-tool
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>, keescook@chromium.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        linux-hardening@vger.kernel.org
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

On Thu, Aug 18, 2022 at 10:33 PM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Replace URL with an updated path to the full Documentation page
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---
>  lib/overflow_kunit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index 7e3e43679b73..78075106c0df 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
>   * Test cases for arithmetic overflow checks. See:
> - * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool.html#configuring-building-and-running-tests
> + * "Running tests with kunit_tool" at Documentation/dev-tools/kunit/start.rst

Oh, I thought I had sent a patch out for this.
The rewritten version of the patch is
https://www.kernel.org/doc/html/latest/dev-tools/kunit/run_wrapper.html
That's what I was intending to rewrite this line to point to.

But if people like a Documentation/ path to start.rst instead, that also works.

Daniel

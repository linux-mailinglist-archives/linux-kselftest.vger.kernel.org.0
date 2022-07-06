Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1C656936F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 22:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiGFUiw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 16:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiGFUiw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 16:38:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99F213DF4
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 13:38:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u15so4614040ejx.9
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZwr/3vScMTpIxRMv4WjBuRiSizQBnezajqPVx3a7e0=;
        b=Si4QPqbtDaLn6pEEQtLRwxF4fYosbpF3ECvovEmamZp6mRc+rAEE4GEuQ1GA75QJNL
         nT5vIiBeCYuWROYx7uLVrwrygeWtrzI4KqiAnNecy3vj45ZwRrP44UCSDGRJalFr35+v
         XGT4GZ5JqGMYJimhJwHqNQ2Hb+k3JYeZ+eifljoPOqgoPE8y/++uz/BePLXB2KueIs+r
         0kjqLOLNielZc+j0wai/ds7sORTK/n1ErXJZjzv1m/tPaFdA/noEhrGjQlWnOPGA+Kjr
         AMe9D/cmbU6GzFJ9kIeTDxrT/59ynOFSiotyLbC3mHfTujW4dRJK1o6Nb49Y/B9ETLha
         GO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZwr/3vScMTpIxRMv4WjBuRiSizQBnezajqPVx3a7e0=;
        b=zU+RwOg1pnsTP7AmbYyDUwbF32AOoLCO+5KEuDRq3r7+lVSdn5LmVo6Atef7BLxC3h
         zYrC2h05i/ksrlO4Jqlua2/Lhp9WBoMYUrU1S17e3BRU35CiUIMff58QJc8A/i+penKj
         7E3Q9g4Mja2W/P7WN3+7VwnmaAxeIpsDVqkVSsS+sIRWYE5/BNGYTj1LXTRNFhgtB228
         8wAZG5FpjE0D//EoRBmmufSA15BWrwItP6yu7vWDc3cAhRaQduyJXNGRGQ6CfaqeNBAU
         +soPRgGiFIvZngHKZcTYgx8V5maMwfMCp+uvjwcEA6Es115OePvALeWKsB4uM8PLYlRw
         IuTQ==
X-Gm-Message-State: AJIora+jDhkbPIOPYv2D+Huy6z3nNKgYwgVVJHPhDezcHXvI/Cyx7KQn
        3HJF5iRQR7HL3tac7MN6Bd6tE1UQshNR7OWBj/q3jQ==
X-Google-Smtp-Source: AGRyM1vxTeQHfdIzYEDhVghCJRnsbHpY4JGNvAe08IGkmOJUZpH5AMO7hQ2aFcT2bjUbbSyKueyvirg7NJR8Stdijos=
X-Received: by 2002:a17:906:5d04:b0:722:f46c:b891 with SMTP id
 g4-20020a1709065d0400b00722f46cb891mr42210274ejt.4.1657139929289; Wed, 06 Jul
 2022 13:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220627221446.82157-1-dlatypov@google.com> <20220627221446.82157-3-dlatypov@google.com>
In-Reply-To: <20220627221446.82157-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 16:38:38 -0400
Message-ID: <CAFd5g45hnC81WHyOmU3Jd2Ov3-KZOZSSOfjPsptqkTfiK73MQA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kunit: add coverage_uml.config to enable GCOV on UML
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Mon, Jun 27, 2022 at 6:15 PM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Now that kunit.py's --kunitconfig is repeatable, let's create a file to
> hold the various options needed to enable coverage under UML.
>
> This can be used like so:
> $ ./tools/testing/kunit/kunit.py run \
>   --kunitconfig=tools/testing/kunit/configs/all_tests_uml.config \
>   --kunitconfig=tools/testing/kunit/configs/coverage_uml.config \
>   --make_options=CC=/usr/bin/gcc-6
>
> which on my system is enough to get coverage working [1].
>
> This is still a clunky command, but far better than before.
>
> [1] at the time of this commit, I get:
>   Overall coverage rate:
>     lines......: 11.6% (34112 of 295033 lines)
>     functions..: 15.3% (3721 of 24368 functions)
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

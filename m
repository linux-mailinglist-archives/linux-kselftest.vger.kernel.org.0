Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633A87AE17B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 00:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjIYWDP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 18:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIYWDO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 18:03:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79CAAF
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 15:03:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690d2441b95so5541221b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695679387; x=1696284187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+A8WAdX2TlibF4VoiqZkmPW/o1SjeOHi+BAIOL0k6Sc=;
        b=R59aUGTy6PS8Wm3BNh0Uq9HTmDoNhZGqmYUWtuklKZTEvwAk3aTQHXdZpxUR1c5WzX
         k1zPttWmMMgBcQQYSqDxyhI+bLCfvYq3QyYtTWsa1I0lQKwYm4eqr59Oxe0KGLDQkWlC
         xPF/AposZB6Rfd7XRgxI/lh9iUKBktOxgoH7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695679387; x=1696284187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A8WAdX2TlibF4VoiqZkmPW/o1SjeOHi+BAIOL0k6Sc=;
        b=bmfySHqyJiUXDDdvylWimVd7cLWuWLuygLhl1IVf2VLShO8KHFGasZsvc9Q/e9t720
         AdT9ddQU2pH5aME5a2+zPGRh+0ewtXsayphv7joQZGafa7iFM86mhA9aLAP/8y9vgHRO
         b4yuHPD9fneJTf2ucV8xfFzYzFqtY3+T8w1jxo91D4PuAn0jKchFgtNCcGGeWWByR40M
         WAdSjWjphYEEfwhwQVTSL/nB64JUG2S9sXC1JT9YBirsbboIBqs9UDObNropUlwXFmbg
         KPSF5hvbsL9/2wmbgrANtZC928McHXZoyxsgHUvao5HQXI1RkxSrnPZcF+T2i0awmCmi
         G3GA==
X-Gm-Message-State: AOJu0YylHGZpyJI5mvSj+ph5QtbgQu3jM8mqCc7ABKNZpz3cmNhG0ItM
        VlNK+j9CCMi194J1BTLhioluBM4tOmrNaXyfke4=
X-Google-Smtp-Source: AGHT+IFWttOmffpB3sN8klMUfhl3I1wt+Bzxiacup9boXKpmgZ0VoST65WtA6BW8OiHory9IHxb5Xw==
X-Received: by 2002:a05:6a21:18f:b0:134:73f6:5832 with SMTP id le15-20020a056a21018f00b0013473f65832mr1361641pzb.16.1695679387311;
        Mon, 25 Sep 2023 15:03:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a16-20020aa78650000000b006862b2a6b0dsm8882839pfo.15.2023.09.25.15.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 15:03:06 -0700 (PDT)
Date:   Mon, 25 Sep 2023 15:03:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] selftests/powerpc: Fix emit_tests to work with
 run_kselftest.sh
Message-ID: <202309251503.B710D958B7@keescook>
References: <20230921072623.828772-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921072623.828772-1-mpe@ellerman.id.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 21, 2023 at 05:26:10PM +1000, Michael Ellerman wrote:
> In order to use run_kselftest.sh the list of tests must be emitted to
> populate kselftest-list.txt.
> 
> The powerpc Makefile is written to use EMIT_TESTS. But support for
> EMIT_TESTS was dropped in commit d4e59a536f50 ("selftests: Use runner.sh
> for emit targets"). Although prior to that commit a548de0fe8e1
> ("selftests: lib.mk: add test execute bit check to EMIT_TESTS") had
> already broken run_kselftest.sh for powerpc due to the executable check
> using the wrong path.
> 
> It can be fixed by replacing the EMIT_TESTS definitions with actual
> emit_tests rules in the powerpc Makefiles. This makes run_kselftest.sh
> able to run powerpc tests:
> 
>   $ cd linux
>   $ export ARCH=powerpc
>   $ export CROSS_COMPILE=powerpc64le-linux-gnu-
>   $ make headers
>   $ make -j -C tools/testing/selftests install
>   $ grep -c "^powerpc" tools/testing/selftests/kselftest_install/kselftest-list.txt
>   182
> 
> Fixes: d4e59a536f50 ("selftests: Use runner.sh for emit targets")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

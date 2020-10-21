Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E356B29471F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 06:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389733AbgJUEG1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 00:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgJUEG1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 00:06:27 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8841C0613CE
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 21:06:26 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d24so1089168lfa.8
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 21:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2ubgR/xKJQH50/QK8k/bko+epR3dyw4FQ+19tjcTls=;
        b=vkK5aBA76cYVAnDOr9Oz2wpEcvNWLCUjDIHM/kvsQc2HBNhFgfTsGf7qEN/FiHATja
         58pgjCaUH1VqmCTIvZ+HXK6ANa6NPywTzla7av1z//rGfiAShCjX5qqsbbarQwigrw8N
         xfi9TXam7LQzeBHUVskuAdDU7MuQVbhGColTgyEXS9PEsJuFrS0h33KNHfuaMyhCKsxN
         tXJBLIWOrgYRrHftPmaoTP23UqNqgbsgUvuy2gYf4d8SpszNe07GA4GyX9OIQNoWfwWf
         Q3FzNmXXJHyIS0b6BZoS1u+J1AC5iykII/d4RQ82YDBbPD7jIXQzhRt78kLYr0I+a3/W
         Zieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2ubgR/xKJQH50/QK8k/bko+epR3dyw4FQ+19tjcTls=;
        b=PiRvC4NEQZeO5u8alySFpLONNFOMTUh2wM214GvPA61b15/hCTFxSLh3k9uDN79VJq
         ZmWHTQa4S0bI2q3paLApOjw5tGYX/juvyrTx1JrNeYucfEubnTSBL603G/P6k/nCgKwJ
         LzQXuPf1C9mNY/5Cu8tlQPQ4sN5yxRogrCBfU9ViTDY9YvVJ5eU/twPqHSa0ApBk/Pm9
         1Z+6a+x1TRnDACDXdmjOYnPO8d1/MIxvsYkplVdmKknu6sQkppOcEblABH/TC0oQK5hi
         rOUOJCkI6kgEx0LH0tOcz4DOhcBAmboPVOKd0L1c8xwOf97HQixw+g+v8zpz3ACBm9/r
         WLig==
X-Gm-Message-State: AOAM530ZtRKqkVKNh/ks1ZneQIE07Rsx6Ld0Zap6qxw87lx2DiXuPRUY
        wUQHWLZ2Z7h7+QFKJGd4RHFzRSx7D25QuRh04RB0XQ==
X-Google-Smtp-Source: ABdhPJzQrd2XSvlsHfFEafig8QCbAKdHYRbbYcpHnQsgnUwZzRj10oPzZl6Xjw9AaCF82eWJlqJIP7T/3uT/B4J59x4=
X-Received: by 2002:a19:97:: with SMTP id 145mr376244lfa.277.1603253184942;
 Tue, 20 Oct 2020 21:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201013063743.32179-1-sjpark@amazon.com>
In-Reply-To: <20201013063743.32179-1-sjpark@amazon.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 21 Oct 2020 12:06:13 +0800
Message-ID: <CABVgOSm3RuJBrevk8W5T6fLVo=uCT5F0OUVLuVTu=TrPnPyxNg@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: Update Kconfig parts for KUNIT's
 module support
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sjpark@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 13, 2020 at 2:38 PM 'SeongJae Park' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> If 'CONFIG_KUNIT=m', letting kunit tests that do not support loadable
> module build depends on 'KUNIT' instead of 'KUNIT=y' result in compile
> errors.  This commit updates the document for this.
>
> Fixes: 9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Sorry for the delay in looking at this. Apart from another minuscule
typo below, this looks good to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> ---
>
> Changes from v1
> (https://lore.kernel.org/linux-kselftest/20201012105420.5945-1-sjpark@amazon.com/):
> - Fix a typo (Marco Elver)
>
> ---
>  Documentation/dev-tools/kunit/start.rst | 2 +-
>  Documentation/dev-tools/kunit/usage.rst | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index d23385e3e159..454f307813ea 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -197,7 +197,7 @@ Now add the following to ``drivers/misc/Kconfig``:
>
>         config MISC_EXAMPLE_TEST
>                 bool "Test for my example"
> -               depends on MISC_EXAMPLE && KUNIT
> +               depends on MISC_EXAMPLE && KUNIT=y
>
>  and the following to ``drivers/misc/Makefile``:
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 3c3fe8b5fecc..b331f5a5b0b9 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -556,6 +556,11 @@ Once the kernel is built and installed, a simple
>
>  ...will run the tests.
>
> +.. note::
> +   Note that you should make your test depends on ``KUNIT=y`` in Kconfig if the
nit: Grammatically, this should technically be either "depend" (2nd
person), or something like "make sure [that] your test depends".

> +   test does not support module build.  Otherwise, it will trigger compile
> +   errors if ``CONFIG_KUNIT`` is ``m``.
> +

Someday it'd be nice to better discuss the reasons a test suite might
not be compilable as a module. It's probably outside the scope of this
commit to do it properly, though.

>  Writing new tests for other architectures
>  -----------------------------------------
>
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20201013063743.32179-1-sjpark%40amazon.com.

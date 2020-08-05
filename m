Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A1123D03A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 21:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgHETpf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 15:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgHETpG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 15:45:06 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86FC06174A
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Aug 2020 12:36:26 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id i129so5724042vsi.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Aug 2020 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gpE3pI+c54t6EfFzgTsovD6WfPTVv6WNXfktad4/3wk=;
        b=I9BUjuhDQNAzE2pI2FinWz92sPpvEO6KTOIMHLGhafXwBpVELW0tLwqop3XTJkKDYv
         Tn1lvCb8qvdfBNG4BYLjw1LmKzvk5SZl5ML5eAUt4ZFYRE/j54+em3p/Pwdy/llYmUy6
         C+XG80hvDcS8pYjgtCdT2NI3YW+0Vi5kgUBosIwWGHyLk5v1Ev+ON2OuJKhI6Ga7oVEQ
         G/+VfS44pXs3d0JSTeUrzBmKYY3Gl5ujrY5kESY7zaOXONdG5iXBTS14WoKIQuP4zfyi
         MvPRxN70UsrWlwA9kM0RVKWCmESDygXDMV66Y4Y2kVo8eA735xbCkreQyLhGckDqMvu7
         OKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gpE3pI+c54t6EfFzgTsovD6WfPTVv6WNXfktad4/3wk=;
        b=bPOTrwZIg8rhj9eYNtlzfbZugG0bWUFzBvb3eCoAHkwSntMB2B9COpuENBqEclSgVZ
         I8k9Ac0k8BJQT4HpYEaUVZNyaND0Tk8VORgOcJjE7dLBv9TOcRBdJ+SRKq8cqy4hPSC/
         ju36n5XARY4KVR86+2796xFlj2n0ssDm44mzPmF3j5Lx2KnmKMNJ17SrYyeMLJACcUyw
         N7DdJpqmOdGsN4S2ZTfas+VvXwt9Wn2Kw+duEii+LeJEMBVbxfsu01CFE6X37rUqzVeS
         skcHsvDPjQj4dD17KUDNEIHCJah5o8mK+x1vozNNb125HrPS573Gqch8ol/q/mHBrNs7
         VAZQ==
X-Gm-Message-State: AOAM531pF+zdIgwrMpXeRh79NZCctPEt4mxvAK1a4fwMEnozhRsA9xo4
        IeZpzqIqNs2sw3liJLJEhMvvdmD2BIU8evpfDZWzYg==
X-Google-Smtp-Source: ABdhPJzpsjel2TEzh8Y0IarhecVHni+meEcN9TX2IdZJ6p3P1z0TtPWp+z2oihdnSQuga7vI+QQFtmR+MG6HJjL1U+I=
X-Received: by 2002:a67:f2ce:: with SMTP id a14mr3323321vsn.49.1596656184959;
 Wed, 05 Aug 2020 12:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200728073241.3625015-1-gthelen@google.com>
In-Reply-To: <20200728073241.3625015-1-gthelen@google.com>
From:   Greg Thelen <gthelen@google.com>
Date:   Wed, 5 Aug 2020 12:36:13 -0700
Message-ID: <CAHH2K0bU7w_rbKN_f0Fe_ZdGLtgBz_GVKS3eottTtm8P7QGoJA@mail.gmail.com>
Subject: Re: [PATCH] selftests: more general make nesting support
To:     Shuah Khan <shuah@kernel.org>, skhan@linuxfoundation.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 28, 2020 at 12:32 AM Greg Thelen <gthelen@google.com> wrote:
>
> selftests can be built from the toplevel kernel makefile (e.g. make
> kselftest-all) or directly (make -C tools/testing/selftests all).
>
> The toplevel kernel makefile explicitly disables implicit rules with
> "MAKEFLAGS +=3D -rR", which is passed to tools/testing/selftests.  Some
> selftest makefiles require implicit make rules, which is why
> commit 67d8712dcc70 ("selftests: Fix build failures when invoked from
> kselftest target") reenables implicit rules by clearing MAKEFLAGS if
> MAKELEVEL=3D1.
>
> So far so good.  However, if the toplevel makefile is called from an
> outer makefile then MAKELEVEL will be elevated, which breaks the
> MAKELEVEL equality test.
> Example wrapped makefile error:
>   $ cat ~/Makefile
>   all:
>         $(MAKE) defconfig
>         $(MAKE) kselftest-all
>   $ make -sf ~/Makefile
>     futex_wait_timeout.c /src/tools/testing/selftests/kselftest_harness.h=
   /src/tools/testing/selftests/kselftest.h ../include/futextest.h ../inclu=
de/atomic.h ../include/logging.h -lpthread -lrt -o /src/tools/testing/selft=
ests/futex/functional/futex_wait_timeout
>   make[4]: futex_wait_timeout.c: Command not found
>
> Rather than checking $(MAKELEVEL), check for $(LINK.c), which is a more
> direct side effect of "make -R".  This enables arbitrary makefile
> nesting.
>
> Signed-off-by: Greg Thelen <gthelen@google.com>
> ---
>  tools/testing/selftests/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index 1195bd85af38..289a2e4b3f6f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -84,10 +84,10 @@ endif
>  # of the targets gets built.
>  FORCE_TARGETS ?=3D
>
> -# Clear LDFLAGS and MAKEFLAGS if called from main
> -# Makefile to avoid test build failures when test
> -# Makefile doesn't have explicit build rules.
> -ifeq (1,$(MAKELEVEL))
> +# Clear LDFLAGS and MAKEFLAGS when implicit rules are missing.  This pro=
vides
> +# implicit rules to sub-test Makefiles which avoids build failures in te=
st
> +# Makefile that don't have explicit build rules.
> +ifeq (,$(LINK.c))
>  override LDFLAGS =3D
>  override MAKEFLAGS =3D
>  endif
> --
> 2.28.0.rc0.142.g3c755180ce-goog

Is there any feedback on this patch?  It's not high priority but something =
that
will help me make more use of selftests.

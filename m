Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B2839C991
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jun 2021 17:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFEPqg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Jun 2021 11:46:36 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:36446 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEPqf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Jun 2021 11:46:35 -0400
Received: by mail-wm1-f45.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so9675688wmk.1
        for <linux-kselftest@vger.kernel.org>; Sat, 05 Jun 2021 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clvSa+JvU6uBZ+o4YWIoUVY1T/E/2QPROQXufQI5L34=;
        b=T0g+7NMfdg+/GWUIM/XuSqgrwASyZbRCGDGVNvTo3QwR7HHSOvoJeV5wwnhAYyEu8p
         lNCqV8yQ7QZXDNGNVrsstpm1xDzeS/IWZMneJbjVR+IHlGfredBoI6hFBgUpSnP1+rcw
         lPRPTiKnOkt32MhcYup1zoHo6FabIXls9uVdcH8vAJ++OGYRgSsDqb5sCZYbbDgOHYI6
         h1BMPdgCtpaVHpGaoFHrUaKGqsD5sauVVUh/AxjDkxobKYd+46Q+iYA+e4fO2kSeqB1k
         trU0dGYNFBnEOSl22Uu/TgW1U4k+IVbgIlUDqqcX5K/6JMdMM/BI2Kmydu2ehZunaF0u
         ESWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clvSa+JvU6uBZ+o4YWIoUVY1T/E/2QPROQXufQI5L34=;
        b=ApqCgb5Snko0I3BoS4cYSbQl5ulbiagwDWw7DMh3lF+AB7M2SMYd+Oexmp3Nb7vKkr
         IwucgFb7ccehLfNvHqN8np0WjPLmEHsxu5tXJxnfZChJ+h90aJW90R8GJse2vMaM4RHs
         dj61JbxODchnFtxy5P6AtzbK4J0VQt7984EW+Z8XmA5HzsgoSqbThvbNSregs8dKwif7
         c2EwW1invxJD1qrauCZ2a+Tz4Vhre4OD2189qGIm6xJk1Up5jwTJpEw0w6VBFdhoRp7+
         nlgOHs+Zx2lIZdAogp7yIyGT9fObsT1Ey0bFvZG7fsbiYThH0GEdTL2Y/l94wri7Ia5w
         yO6g==
X-Gm-Message-State: AOAM530L/WE+qIe3aGjHXUJNwS18mE7v5HAeSUGdOpdeY+GdvARiyUTo
        m8ze+85hXrevkKrbH/d8yAeY1alxMyJXthOBhPAvMg==
X-Google-Smtp-Source: ABdhPJw4Dw/ErnZ+CAGXFG16Mr96Iq3PCkOCpBV8t6JOv8RyD39fk8GHFGJiW0cDt6C2hHns9FgdWJ5t4GAeTvXvhxo=
X-Received: by 2002:a1c:1dd3:: with SMTP id d202mr8688712wmd.78.1622907813308;
 Sat, 05 Jun 2021 08:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622898327.git.mchehab+huawei@kernel.org> <08ac283ac5bdc2664255a7ad34514e50d3ed85d8.1622898327.git.mchehab+huawei@kernel.org>
In-Reply-To: <08ac283ac5bdc2664255a7ad34514e50d3ed85d8.1622898327.git.mchehab+huawei@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 5 Jun 2021 23:43:22 +0800
Message-ID: <CABVgOSmheB_f5gNc_zyuDHrwdRs_x_osutorJbLUMGpRRU4nzA@mail.gmail.com>
Subject: Re: [PATCH 02/34] docs: dev-tools: kunit: don't use a table for docs name
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 5, 2021 at 9:18 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> We'll be replacing :doc:`foo` references to
> Documentation/foo.rst. Yet, here it happens inside a table.
> Doing a search-and-replace would break it.
>
> Yet, as there's no good reason to use a table there,
> let's just convert it into a list.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

While I personally quite like the look of the table when rendered by
Sphinx, I think the list is much more readable as plain-text, so this
is okay by me.

That being said, a definition list[1] seems like it should be better
still, though I can't get it to work with the kernel's Sphinx
configuration, so let's stick with this for now. (Given we've only got
one page of documentation here, the whole thing doesn't matter much
anyway.)

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

[1] https://rest-sphinx-memo.readthedocs.io/en/latest/ReST.html#definition-list


>  Documentation/dev-tools/kunit/api/index.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
> index 9b9bffe5d41a..b33ad72bcf0b 100644
> --- a/Documentation/dev-tools/kunit/api/index.rst
> +++ b/Documentation/dev-tools/kunit/api/index.rst
> @@ -10,7 +10,7 @@ API Reference
>  This section documents the KUnit kernel testing API. It is divided into the
>  following sections:
>
> -================================= ==============================================
> -:doc:`test`                       documents all of the standard testing API
> -                                  excluding mocking or mocking related features.
> -================================= ==============================================
> +Documentation/dev-tools/kunit/api/test.rst
> +
> + - documents all of the standard testing API excluding mocking
> +   or mocking related features.
> --
> 2.31.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/08ac283ac5bdc2664255a7ad34514e50d3ed85d8.1622898327.git.mchehab%2Bhuawei%40kernel.org.

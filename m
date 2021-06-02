Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA6A39898D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jun 2021 14:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhFBMbd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Jun 2021 08:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhFBMbd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Jun 2021 08:31:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4474C061574;
        Wed,  2 Jun 2021 05:29:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l1so3582268ejb.6;
        Wed, 02 Jun 2021 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOLFaj0eZMbhvhU5JE2B3PkFVC/DaKVhxKSu0FKRJ1k=;
        b=kz6oMbWyvB0OdUhl7dtSd8gMnFkE7IZJu9PXpAqf+Eoth2rBsAb8hGXu9zdvETDBNm
         F4eNsbQEqAY2ObfICADk/cOSr8kYW7R7c0u5jNCxyFNji5A4wZQ56r10eiY9w3FsTM2M
         CjfvOXM4NmjUtWVLg8NiVtdDP7pasj9CoteE4gUAzNjfkigyt/ojGn2M6GauRQ03fnsX
         am+8qJAgxWQlpLMbbPbDwtOVhQ5xwjAs1ii34pwyutqjaty4VofQAC//BupKYucBXfi4
         LI/mzkRBs/s8DsDRBxlxK8RBYUslB++/gzKpXjqgEVecsEQK0O0zOR/DmUMvDQOwA5NZ
         w4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOLFaj0eZMbhvhU5JE2B3PkFVC/DaKVhxKSu0FKRJ1k=;
        b=HEH0U8FCNnPhq8zivLzcTX1+V9TleZWpH5zm4sJcvhkXjOcozSSSQIKrZNmWqeAA7/
         5km3spQYdwNk4ZOvHYTpsZipeCAHdfl75dtcAau2UlcwAnJteQtQ9oPYXTMd9vDRHTW/
         kF/qPSeFq1AhXxwl0PFLvXYHU8L8F53INZO4aiu3m5fnGbuKlOyrkqgQgXVGo/KRAGHr
         KtS55cfaceT1an6Ts2gjRO7zrLn2CM2P0hLHzsTtNxNxqf7cbcJ52UXwlPRfJSMib/sM
         iMBKFmpFJathfSvbLNcs2WKFQ/GJBarSi6lRdIU26W/2Sutw7dv+xNfxRSzlp41tx1oK
         07tQ==
X-Gm-Message-State: AOAM530kAh7V6Cea/74VVyJ58WH+l6maTAAsp9p7KB4HzG+AxXUtghQs
        AlPai9TzbWicN1E0XmtpFNFdOGkJyU1j7jbo+yY=
X-Google-Smtp-Source: ABdhPJzb+cjLREU+78JVTH8c7V6ouq23k9cTEGu7muFbR3qg2saE7/jgbqKKQyUUZAuuxzkySXDXYraB3FVE5nYCIis=
X-Received: by 2002:a17:906:4c5a:: with SMTP id d26mr14801491ejw.509.1622636977355;
 Wed, 02 Jun 2021 05:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210528075932.347154-1-davidgow@google.com> <20210528075932.347154-4-davidgow@google.com>
In-Reply-To: <20210528075932.347154-4-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 2 Jun 2021 15:29:26 +0300
Message-ID: <CA+fCnZefz_Jf=bodZnUn3axdMijGTC1+T5nLriQta8BJMK8n5w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kasan: test: make use of kunit_skip()
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, kasan-dev <kasan-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 28, 2021 at 10:59 AM 'David Gow' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> From: Marco Elver <elver@google.com>
>
> Make use of the recently added kunit_skip() to skip tests, as it permits
> TAP parsers to recognize if a test was deliberately skipped.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  lib/test_kasan.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index cacbbbdef768..0a2029d14c91 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -111,17 +111,13 @@ static void kasan_test_exit(struct kunit *test)
>  } while (0)
>
>  #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {                  \
> -       if (!IS_ENABLED(config)) {                                      \
> -               kunit_info((test), "skipping, " #config " required");   \
> -               return;                                                 \
> -       }                                                               \
> +       if (!IS_ENABLED(config))                                        \
> +               kunit_skip((test), "Test requires " #config "=y");      \
>  } while (0)
>
>  #define KASAN_TEST_NEEDS_CONFIG_OFF(test, config) do {                 \
> -       if (IS_ENABLED(config)) {                                       \
> -               kunit_info((test), "skipping, " #config " enabled");    \
> -               return;                                                 \
> -       }                                                               \
> +       if (IS_ENABLED(config))                                         \
> +               kunit_skip((test), "Test requires " #config "=n");      \
>  } while (0)
>
>  static void kmalloc_oob_right(struct kunit *test)
> --

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

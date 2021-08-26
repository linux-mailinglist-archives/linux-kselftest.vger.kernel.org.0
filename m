Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8F13F8A2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 16:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhHZOhe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 10:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhHZOhe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 10:37:34 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF74C061757
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Aug 2021 07:36:46 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so3722423otg.11
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Aug 2021 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0x7kG5inCAU4odH4Ca7hH6L2dymSyP8KvC1gg8txvI=;
        b=P0I9/WLM2kllF2CsU1LJ1VGJOKg93R3WGspayrL/kOiIA6MkG9oqhNa47EwKWRGDH4
         ahgUV0kHqxhhwVbAjWKODDViXGRiXBM5qexE1XTinlHlts6w3lvuOxblzuHXxib+V0zE
         PncJ6Z+0nepcixsaZQ9h0XemG/8fELyMs+gqs1dXMC2EI6fa6kbk5hdPZTCMaABedJtA
         LyBqYLuhs2P0moxsuej5Oj8V9O2gwHeUVhBZBrrG2lB4Ai/i/4yRb0KYjXIcxm5A2jgy
         lNg0KLQ5XDDhgeJeWQRKVMXru0Wz7MSIYBDTUO0Y4q28bDJDPNlDL2yQAuRGxhzHfeau
         8XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0x7kG5inCAU4odH4Ca7hH6L2dymSyP8KvC1gg8txvI=;
        b=mbHQsCHR2Ez3aZdcDagO7mnqgwjz8cX/b9ITBWy36HfT8xLipTtE5+PPgC+MjNeqXx
         xEIJ3v6zPLsLOtAvKpNSSQ6uitnInt0ME/Q8y++/eimRRcF6eHZ536mM3y2rVZQT9g19
         GV9p4SV/B1GrB7SUsipjDDba/QwvZc1FJXjT9SAqmZgYC0DJa8NczZ/YIQjO3U7YPJjI
         T7iZgea/t6VP8B+D3mw/wAanEo7o57u2UyxmTafO/HGrTnfDkM1nq9tOCAgfBRSTCsXN
         6T/UgcWscIWJIm/PTYc9Q5KNOzrYpeItIshrsCrZMWhidy9VFA8OdUJVH1kVpYWfGbCN
         S3+g==
X-Gm-Message-State: AOAM531dm+Jjs9ctNzYMWFnU41aY03n4zKNwQLBhW7SUtWZ16nroFMSc
        MudVsNnv7gVGPDsjPdvm9vNLxqqnMYqOefL6LsPbEw==
X-Google-Smtp-Source: ABdhPJx8znIwtijGE5yCzihQvV6CBXxvSBuPVEbykUDFH/2TOhXQIdLMBM58CoB3+b3BFLSZpKxHsIY/LmwlfPW0oRI=
X-Received: by 2002:a05:6830:88:: with SMTP id a8mr3470082oto.233.1629988605961;
 Thu, 26 Aug 2021 07:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br> <20210826012626.1163705-3-isabellabdoamaral@usp.br>
In-Reply-To: <20210826012626.1163705-3-isabellabdoamaral@usp.br>
From:   Marco Elver <elver@google.com>
Date:   Thu, 26 Aug 2021 16:36:34 +0200
Message-ID: <CANpmjNPdP4OZGE3is4twths1fejCjZeEKAweVpgdqBUc=e59ww@mail.gmail.com>
Subject: Re: [PATCH 2/6] test_hash.c: move common definitions to top of file
To:     Isabella Basso <isabellabdoamaral@usp.br>
Cc:     linux@sciencehorizons.net, geert@linux-m68k.org,
        ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 26 Aug 2021 at 03:26, 'Isabella Basso' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
> Keep function signatures minimal by making common definitions static.
> This does not change any behavior.

This seems like an odd change; if I read it right it's changing the
out-param passed to test_int_hash() to simply be static globals.

For one, it makes the code harder to read because now test_int_hash()
is no longer "pure" (no global side-effects ... modulo printfs), and
what was previously an out-param, is now a global.

Unfortunately this is poor style and likely to lead to hard-to-debug
problems. One such problem is if suddenly you have multiple threads
involved. While this is just a test and unlikely to be a problem, I
would recommend not introducing global state carelessly.

An alternative common idiom, where a set of variables are always
passed around to other functions, is to introduce a struct and pass a
pointer to it along.

> Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> ---
>  lib/test_hash.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/lib/test_hash.c b/lib/test_hash.c
> index d4b0cfdb0377..8bcc645a7294 100644
> --- a/lib/test_hash.c
> +++ b/lib/test_hash.c
> @@ -23,6 +23,11 @@
>  #include <linux/stringhash.h>
>  #include <linux/printk.h>
>
> +#define SIZE 256 /* Run time is cubic in SIZE */
> +
> +static u32 string_or; /* stores or-ed string output */
> +static u32 hash_or[2][33] = { { 0, } }; /* stores or-ed hash output */

These now use up memory for as long as this module is loaded, vs.
before where it would only use up stack space. (For a test that's not
a problem, but in non-test code it might.)

>  /* 32-bit XORSHIFT generator.  Seed must not be zero. */
>  static u32 __init __attribute_const__
>  xorshift(u32 seed)
> @@ -66,7 +71,7 @@ fill_buf(char *buf, size_t len, u32 seed)
>   * recompile and re-test the module without rebooting.
>   */
>  static bool __init
> -test_int_hash(unsigned long long h64, u32 hash_or[2][33])
> +test_int_hash(unsigned long long h64)
>  {
>         int k;
>         u32 h0 = (u32)h64, h1, h2;
> @@ -123,17 +128,15 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
>         return true;
>  }
>
> -#define SIZE 256       /* Run time is cubic in SIZE */
> -
>  static int __init
>  test_hash_init(void)
>  {
>         char buf[SIZE+1];
> -       u32 string_or = 0, hash_or[2][33] = { { 0, } };
>         unsigned tests = 0;
>         unsigned long long h64 = 0;
>         int i, j;
>
> +       string_or = 0;

That's another problem with changes like this; now the compiler has no
chance to warn you in case the variable is not initialized correctly.

Also, I don't see string_or used anywhere else. Why make it global?
If a later change would require that, it should say so in the commit
message. But my guess is you can avoid all that by bundling everything
up in a struct.

>         fill_buf(buf, SIZE, 1);
>
>         /* Test every possible non-empty substring in the buffer. */
> @@ -161,7 +164,7 @@ test_hash_init(void)
>
>                         string_or |= h0;
>                         h64 = h64 << 32 | h0;   /* For use with hash_64 */
> -                       if (!test_int_hash(h64, hash_or))
> +                       if (!test_int_hash(h64))
>                                 return -EINVAL;
>                         tests++;
>                 } /* i */
> --
> 2.33.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210826012626.1163705-3-isabellabdoamaral%40usp.br.

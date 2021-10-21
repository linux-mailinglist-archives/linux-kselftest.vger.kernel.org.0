Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733C54358A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 04:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhJUCfA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 22:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhJUCe7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 22:34:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B48CC061749
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 19:32:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g25so367235wrb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 19:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5mE2x+hW5pUs3S3pcPG1uGiSDyc4WMJ3U35UkRsq+s=;
        b=HgDmJOdjPt4QsbGwAloFChaUOnSeKyRpnqXxokF9l4WEPpLyC7btHMLS9ttFEbZlUf
         6pJqFnUC4r0QMJ2lEknR87dQKLag/Zf+GxTBl8PCxnPNwGXN7+Ki5AzIkjI0tUDqAVtO
         gY/vorVqzpdp7Ip8shJMHpq2kk6J61p1ttngKCC0uj3EUfGRB+3lp2t6YzdfLUiXwwWy
         yB3ZHUGC3Xhd3lbqdeCnKXqXe7yFf3PSBPj8IoPiC4kZNPaBmAU78h4RysskHDN0DoD7
         vQj3YNMihzDaUoJLbvwuZbeVGsOA9sjeBW8jXK+mF0yRNOVTYP0JfZ2ie9isHPejcNsV
         4Klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5mE2x+hW5pUs3S3pcPG1uGiSDyc4WMJ3U35UkRsq+s=;
        b=kFxAHIkvra/LWzCoY3t9Gk7due31YaRETKYlsSLwS72qVzAJjTiZZPX7wW/bHeDFat
         b15Ye1dk68UUG6RSFKFVHNMqsT2s/CfffG+7fuln/4cn4MyCjbbnfHUvScza8croxttT
         SySnTMrBc4/lNaya38fwW9fnT5kl4W4uSRjhVLNMLAyNe5GQ7iHdFFqLofEBvBr/d3Ez
         sfkrEjG/30/NKo8MGJoIJYz9Fm1fogVu+YLulakwbLckLxtBn4mz2L/f2KGBtbX4s75H
         K5rkNyENZEX029Rpj97daAPnOCiJHWmIomnopjiRHnrAmzkBzlYGUprnOu8y6TndQD5O
         ATEw==
X-Gm-Message-State: AOAM532+eQCxXoLMJb8ilVbX1FJsf05pzajAucrSsZAAhL5DMmMll+nu
        /KRfXdjS3t3IlbX4TsfLnJk45SKI5NztKd/5L6kfVw==
X-Google-Smtp-Source: ABdhPJy1TXM/ktn3Tx4CCtwfH6IOLLZIhWo2njTND6Dw9Vd4e5cFoe+AAs3IHzDMwFTS/wlFt/j3LFtUc5oddOJVR9U=
X-Received: by 2002:adf:9c11:: with SMTP id f17mr3823144wrc.147.1634783562902;
 Wed, 20 Oct 2021 19:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211020232121.1748376-1-dlatypov@google.com>
In-Reply-To: <20211020232121.1748376-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 21 Oct 2021 10:32:31 +0800
Message-ID: <CABVgOS=KuRiw1D3_TS9pvQ420JLcvv-sN9Lg7BP+OMy-dhYqMg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: continue past invalid utf-8 output
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 21, 2021 at 7:21 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> kunit.py currently crashes and fails to parse kernel output if it's not
> fully valid utf-8.
>
> This can come from memory corruption or or just inadvertently printing
> out binary data as strings.
>
> E.g. adding this line into a kunit test
>   pr_info("\x80")
> will cause this exception
>   UnicodeDecodeError: 'utf-8' codec can't decode byte 0x80 in position 1961: invalid start byte
>
> We can tell Python how to handle errors, see
> https://docs.python.org/3/library/codecs.html#error-handlers
>
> Unfortunately, it doesn't seem like there's a way to specify this in
> just one location, so we need to repeat ourselves quite a bit.
>
> Specify `errors='backslashreplace'` so we instead:
> * print out the offending byte as '\x80'
> * try and continue parsing the output.
>   * as long as the TAP lines themselves are valid, we're fine.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> v1 -> v2: add comment to silence erroneous pytype error
> ---

Thanks. I've tested this, and it works well for me. I don't mind the
pytype comment, even though I don't use pytype, so I'm glad it's
there.

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit.py        | 3 ++-
>  tools/testing/kunit/kunit_kernel.py | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index e1dd3180f0d1..68e6f461c758 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -477,9 +477,10 @@ def main(argv, linux=None):
>                         sys.exit(1)
>         elif cli_args.subcommand == 'parse':
>                 if cli_args.file == None:
> +                       sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
>                         kunit_output = sys.stdin
>                 else:
> -                       with open(cli_args.file, 'r') as f:
> +                       with open(cli_args.file, 'r', errors='backslashreplace') as f:
>                                 kunit_output = f.read().splitlines()
>                 request = KunitParseRequest(cli_args.raw_output,
>                                             None,
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index faa6320e900e..f08c6c36a947 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -135,7 +135,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                                            stdin=subprocess.PIPE,
>                                            stdout=subprocess.PIPE,
>                                            stderr=subprocess.STDOUT,
> -                                          text=True, shell=True)
> +                                          text=True, shell=True, errors='backslashreplace')
>
>  class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>         """An abstraction over command line operations performed on a source tree."""
> @@ -172,7 +172,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>                                            stdin=subprocess.PIPE,
>                                            stdout=subprocess.PIPE,
>                                            stderr=subprocess.STDOUT,
> -                                          text=True)
> +                                          text=True, errors='backslashreplace')
>
>  def get_kconfig_path(build_dir) -> str:
>         return get_file_path(build_dir, KCONFIG_PATH)
>
> base-commit: 63b136c634a2bdffd78795bc33ac2d488152ffe8
> --
> 2.33.0.1079.g6e70778dc9-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20211020232121.1748376-1-dlatypov%40google.com.

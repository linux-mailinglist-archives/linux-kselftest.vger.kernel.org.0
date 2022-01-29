Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706884A2B8F
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jan 2022 05:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiA2EPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 23:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiA2EPP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 23:15:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7854C061714
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jan 2022 20:15:14 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c190-20020a1c9ac7000000b0035081bc722dso5361258wme.5
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jan 2022 20:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4oel1aQBoCtI/b7gkK6UL5x2odlkFP6no8sfDKO+Pg=;
        b=LUPkVY/TcyzOL0KUTKOMPPkxjWtZRrwB3qQhWUHq/enS3OBA9r9jFpseAGdPZDowxw
         eF57APKjuCQ446mmevqtldVRmIx9TCA7Y2oAZYfk3QdLaYEI2qn7wlflWc64wuHPzQZp
         NkwuxKKnksGZSXrFMsFyvdUXMAu/kdtOzLYHSXtzN1MfgTcDwCfA2HhxQERheaAcL9tx
         Slwqmt0A6TsUrFTFecX7gWVLuiZtnOOn71jHFc5Qr0ntDYSVpuncXEaJbqtmC3CZ9JZn
         CxnvxQSJ8aZ/D2a12dzwePAzmo7vzSQ/r9EZ5nHmxq/KAA/kJ6cMPhrWZi7ety/6ZjN+
         0Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4oel1aQBoCtI/b7gkK6UL5x2odlkFP6no8sfDKO+Pg=;
        b=2Ztrf3Wki2miCQPGlf5rch5uP65UdwiwMLUEdbuZeep6iuXzXhRBqXbLXy0OCRIj3b
         stGWzejWSChuaTw0ugrvyoOSWBXo8oOyxMmicu/AkioGGXupY7/SuG7dmuM9HoRMO4sB
         hwFJJXWlD/jdpoC7oT1XsbUbo5xdpzck88d5tqODxuqpl2ibWeCGPMtz62J9KfzfN/1a
         +zv/BrHmmbqh7hGa5woMFxVSoYndJXeldvXFB+IIHrIjPwdl4TLJDP01g337GGU1TM+1
         ESqp9QoiyFdSpWSZKiURJDexTzgq9bnmOiFABLbsU8fH6uGnHKZuulxA7llPcZGeC9Az
         aOcQ==
X-Gm-Message-State: AOAM5325P5yKwSegpgm0zMUwwOY3sj9lacyQk1cxAUmbZqpbeI9SUYJ3
        tIDDyBmrEWZxS8lLjtT6P//xGk1QSiuzoekY0LdtEg==
X-Google-Smtp-Source: ABdhPJyJtOmRyTmN1Db/Nvc1SI43ufGP0GPkypCaSyJvYg+TaDwEsgkzTiKthZmm5E5iVrOnyYIDmJ/0nCw5YRvKqxI=
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr18501063wmc.18.1643429712927;
 Fri, 28 Jan 2022 20:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20220127221710.165733-1-dlatypov@google.com>
In-Reply-To: <20220127221710.165733-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 29 Jan 2022 12:15:01 +0800
Message-ID: <CABVgOSncO56y02RkUMeBU2rpqxXgDudL24gG0UUqzhX58JqjJg@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix missing f in f-string in run_checks.py
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 28, 2022 at 6:17 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> We're missing the `f` prefix to have python do string interpolation, so
> we'd never end up printing what the actual "unexpected" error is.
>
> Fixes: ee92ed38364e ("kunit: add run_checks.py script to validate kunit changes")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/run_checks.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
> index 4f32133ed77c..13d854afca9d 100755
> --- a/tools/testing/kunit/run_checks.py
> +++ b/tools/testing/kunit/run_checks.py
> @@ -61,7 +61,7 @@ def main(argv: Sequence[str]) -> None:
>                 elif isinstance(ex, subprocess.CalledProcessError):
>                         print(f'{name}: FAILED')
>                 else:
> -                       print('{name}: unexpected exception: {ex}')
> +                       print(f'{name}: unexpected exception: {ex}')
>                         continue
>
>                 output = ex.output
>
> base-commit: 6125a5c70acddd9fc1fb7329047a254c74d0173c
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>

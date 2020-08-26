Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6418B253628
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Aug 2020 19:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHZRry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Aug 2020 13:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgHZRrs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Aug 2020 13:47:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9FFC061574
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Aug 2020 10:47:47 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id m22so4025112eje.10
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Aug 2020 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZhvz/VcmtyOV5FpCQGhe3jSJp/wS6UPaYcPASL+W/w=;
        b=HEdiitSKEBxMSHU8oTLa3sOT98ZqvBgSHQoEa8wKCD7Bep9IfA3SmowbtjCNMgkw9i
         jku1yi1AxvYbxckP53qA3tB5mi0Xeepx/+gdavzei1K18KH4XJJ7ql/2GL6DWC7FoP0J
         DFVlciGxbX1urrNma8ZDr07/YRWt/Uy8XWkxyo6yHLhilLIZNM9TZ2slZHDFGktyk3/Q
         9E9A0VZvOP44jHPNyTpdKN92CKWEsGHxifxkxymJ/Nlu23ojN81Emuo0TqlFKCCQ0/bZ
         QVpX4GgvoQA463xPcCxrkOn6bIi3vIyOL5CtkIXlfdLEfYTsyzwlhbzOju+HDjTrlITC
         zxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZhvz/VcmtyOV5FpCQGhe3jSJp/wS6UPaYcPASL+W/w=;
        b=YXvegyhCmB3dfEtAh/3nptgPhSduUR5OuZOeb8Ki/hICY5doRFY31egpWOaEUEBhKi
         Oe852nmuw4rw3GSG5WCXGxjFvC2jQ7QatsAYIxXtIfFZ4DiWnnDB2y3Rmo1JAoXdv+xi
         54HmgFntVOj2CeUbX1jaBdBJzUwKAnn2bYr9prI3ZW0azMvxtglUD3nUsd/roJpe6uw3
         80jr9rYdlrkvS3Ycl2C2bPSS3ZPGO91fBkByTdgBnqwqYtv99n1mwbVS1Vi52MzgQROC
         RyLU9ffTYIuEvqM+LsVV3QxYojSE8Ks/tt3OZqWA4Qkp+3Pm1jNTQ99sld7eLlDy+uVA
         E1zg==
X-Gm-Message-State: AOAM5339/XR/nRPB3UnZy1x1TyOHV7eq1Em2Wv1a2LM76MhbpTjs+WQT
        KkSsGmo5Mw7KuhepaHr3R2ZdZGAhaxR1mvXLzaju3CzV5iF+9g==
X-Google-Smtp-Source: ABdhPJzus1ddDpcAB3sDL3goLET4zr36SFUC2Lm7kSX43cr3KBZpmMROLLbNpz+1kIMWiaUywpNuyma7UHpBq/QSea8=
X-Received: by 2002:a17:906:c10c:: with SMTP id do12mr13194774ejc.92.1598464066662;
 Wed, 26 Aug 2020 10:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <1583589765-19344-1-git-send-email-hexiaolong2008@gmail.com>
In-Reply-To: <1583589765-19344-1-git-send-email-hexiaolong2008@gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 26 Aug 2020 14:47:35 -0300
Message-ID: <CAAEAJfA0w+xs95vnOiFnnMPpzh-0qJDey95bXdbv27O98cpWHA@mail.gmail.com>
Subject: Re: [v2] dma-buf: heaps: bugfix for selftest failure
To:     Leon He <hexiaolong2008@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org, Leon He <leon.he@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Leon, Shuah,

Thanks for the fix. I had this issue pending to fix,
but have been lazy about it, I appreciate you are taking care of it!

On Sat, 7 Mar 2020 at 11:03, Leon He <hexiaolong2008@gmail.com> wrote:
>
> From: Leon He <leon.he@unisoc.com>
>
> There are two errors in the dmabuf-heap selftest:
> 1. The 'char name[5]' was not initialized to zero, which will cause
>    strcmp(name, "vgem") failed in check_vgem().
> 2. The return value of test_alloc_errors() should be reversed, other-
>    wise the while loop in main() will be broken.
>
> Signed-off-by: Leon He <leon.he@unisoc.com>
> ---
>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> index cd5e1f6..836b185 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -22,7 +22,7 @@
>  static int check_vgem(int fd)
>  {
>         drm_version_t version = { 0 };
> -       char name[5];
> +       char name[5] = { 0 };
>         int ret;
>

As Shuah already mentioned, I think we want to use strncmp
to be on the safe side.

>         version.name_len = 4;
> @@ -357,7 +357,7 @@ static int test_alloc_errors(char *heap_name)
>         if (heap_fd >= 0)
>                 close(heap_fd);
>
> -       return ret;
> +       return !ret;

I agree with Shuah, this change makes no sense, just drop it.

I think the fact this test was broken and nobody noticed
uncovers the fact that the test isn't being run.

Any reason why this test isn't a regular TARGET?
Or any idea how we can make sure this is run by CIs
and any other testing system?

Thanks!
Ezequiel

>  }
>
>  int main(void)
> --
> 2.7.4
>

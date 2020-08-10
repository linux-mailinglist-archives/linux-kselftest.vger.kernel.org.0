Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAFE2411DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Aug 2020 22:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHJUnD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Aug 2020 16:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHJUnC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Aug 2020 16:43:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05EFC061787
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 13:43:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y206so6356020pfb.10
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 13:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+Vem1mPePRTF6yuvkTSfUvQ+T0mz1vgwNb7in9eFI0=;
        b=rLV5IMYYk3qhRR8OaqNl7bVx/f6TTfAKUbKi9cxnNxk+WqNAxQsbVUNbgs3NwD7W8z
         YMpoTdb1gYXoBNx6osqdLbdfephLsl2AlcmUGdc36l769CeErMCnOF3uUD61rZq02Rz1
         UEAEgv4RTY7ogrE52HbPUF0nQn3sFmpnpI0sUksXCITaCUIyPQ7Snz4JZUdT9kbu3WFi
         xbP+oB43v0QNpwNMTFsBfYR1c8H9ujLjRl91UKV4hhazszyFC/pX22Omw+/ith7x/54a
         SYDrTYmpeXAvZ5ABQWjSVftGtQYPkUAzPqxqzySf+0akRRSZWVr+TS9ZggzhmwhkorpA
         VPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+Vem1mPePRTF6yuvkTSfUvQ+T0mz1vgwNb7in9eFI0=;
        b=iMpJjBdaLko5BEPn0ood/0/BkOXK6atujGfnf5RaD9F1ibQL4hCzrKTp9Zm0xMHC9/
         YT/V7Sf9taKaBl3wTn4P6C9pGMlh8OrV/tFe74k56lrRHb5PbK/qd8x2Th7bSNoT1MXj
         jrNlZZZ3UugqzU/NPAJhqiZ+Q+DiXwe/k3N2GeKbBVJVe/pSwMb8rbfgXyelALpiBcae
         bhqpk7+qHCFcEpu5HD5eW7zJBxuA9pvuBY/3JmSqhTltarnt1gW0/5MFY5GJwFf2AVSW
         cW3AIIXE6iqnuluqSQkZtzpMYuGpP0+1af45xf5Kib6ubb3a2nx3uGJgdi93848/DWta
         8E1w==
X-Gm-Message-State: AOAM530HfMu1Hg8iMQmYAcZvTm1l3ha0efZKBuYb8E/cWqtXHtynGOG8
        YvaJa8LiCuLD6ndMevf0H1YIuC0JDx1DKyyrZtjPEg==
X-Google-Smtp-Source: ABdhPJzflIhS968NdWQ+OK33LSfgJpCxuHDzOO363XN8hpalQG79JJeEo4wGnIQYudlWzLeqptInIpto9l7CwNAHMeU=
X-Received: by 2002:a63:7746:: with SMTP id s67mr23105137pgc.159.1597092181923;
 Mon, 10 Aug 2020 13:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200806174326.3577537-1-urielguajardojr@gmail.com> <20200806174326.3577537-2-urielguajardojr@gmail.com>
In-Reply-To: <20200806174326.3577537-2-urielguajardojr@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Aug 2020 13:42:51 -0700
Message-ID: <CAFd5g47AO64WMvQvz2an_ak-ReL9UT3oBMpFBdC_pFmQK3scfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: ubsan integration
To:     Uriel Guajardo <urielguajardojr@gmail.com>
Cc:     Uriel Guajardo <urielguajardo@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 6, 2020 at 10:43 AM Uriel Guajardo
<urielguajardojr@gmail.com> wrote:
>
> Integrates UBSAN into the KUnit testing framework. It fails KUnit tests
> whenever it reports undefined behavior.
>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>

You should resend this to the UBSAN maintainers as well; they will
need to sign off on this.

In the future, make sure to run get_maintainers.pl

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  lib/ubsan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index cb9af3f6b77e..1460e2c828c8 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/sched.h>
>  #include <linux/uaccess.h>
> +#include <kunit/test.h>
>
>  #include "ubsan.h"
>
> @@ -137,6 +138,7 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
>  {
>         current->in_ubsan++;
>
> +       kunit_fail_current_test();
>         pr_err("========================================"
>                 "========================================\n");
>         pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
> --
> 2.28.0.163.g6104cc2f0b6-goog
>

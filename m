Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2ED46C7B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 23:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhLGWu5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 17:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242336AbhLGWuz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 17:50:55 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7B4C061746
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 14:47:24 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 133so351771pgc.12
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 14:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5/HWBzjQqRZTzFV5HrLo/i9yn5y0B3GMGZ2mf+dcNM=;
        b=I1u9+6yTQXf5pIIRr5J6vodUUA0vPrW9vbH2iNO99tB2FGTpLNP8QBgODKTN+lBCWA
         BXvW049+aMpxrrNkUIzZSHFR5vvGh5Gt1eliV7jz/tOqQjWRFtstbWTq7g3YCSyHTIJ3
         BxicRAEq9Gqq1vp6EarPPCG6/zbHWheiPnQo/2/m+AsId2OFhtGtJ2O/yhCiD1h2BZ86
         ThxF2VrrmzulzOVEs8zRuMWWWRQ5LuQfjbDbREwMwRQQs36PGJxGO8MTZBaEnqnNqWmP
         xB+TkQnd3fVBBWTtTf/nyvMsbxlZEzSbaEp6FwJNJEf7bG4XH5Js0vSXZlrWvSu6vlpQ
         OhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5/HWBzjQqRZTzFV5HrLo/i9yn5y0B3GMGZ2mf+dcNM=;
        b=0tQA3eSzoA6op6tX2kRH0VQoJshpWgl+FN9oz0NXcXMylmR5tT9GEMYCc+xeKq16hn
         XkmWhf8rhrtucyg5PdkcOfyUsNoLnLas5G0NDV6cmfMfUeya/xpJg62O7lhIikVkztH8
         Qt5MrbTZtyLSwg8NTs3vsAThCPgatHJQAGM0Uf6dl0sQU9ZDeco0Vn4Rsdl9GX0Vy2DG
         3IyJ61YV3mFk8icdsk8+pInJF+YaQF8KzRSAdGuR71jt+GhP7zMxF7GvnpEREo0QITK7
         H1xrGdMVdD4+Tb3QwgjCCCLZ13dd+0sHlLDqTNR0vcjZ2QnQY0YryXDpaAEJ0oNMiLdW
         r9QA==
X-Gm-Message-State: AOAM533Tz+sjPx/jw4AOAtc9bTjezejjMMZf309Incfn/Dy1YO0r5pXx
        21Jv6/cMxtGYjaG1bucjZ1+CRRPa+H+ptghB4g++vQ==
X-Google-Smtp-Source: ABdhPJwrkum3hmHSV0oSCnXlFKjmbNvzZmpeJ51V+OnhWYeXNvDwUXEC2go397HMJNDJTTnl6qJzc1UW2NGqKo71Unc=
X-Received: by 2002:a62:7ec4:0:b0:4a3:219b:7008 with SMTP id
 z187-20020a627ec4000000b004a3219b7008mr1986918pfc.3.1638917243861; Tue, 07
 Dec 2021 14:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20211106013058.2621799-1-dlatypov@google.com> <20211106013058.2621799-2-dlatypov@google.com>
In-Reply-To: <20211106013058.2621799-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 17:47:12 -0500
Message-ID: <CAFd5g44o2_+tTREm+ChgyhfOu+zV7wxgMZ039LKJ=+VB0koFqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: add --kconfig_add to allow easily
 tweaking kunitconfigs
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 5, 2021 at 9:31 PM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> E.g. run tests but with KASAN
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kconfig_add=CONFIG_KASAN=y
>
> This also works with --kunitconfig
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kunitconfig=fs/ext4 --kconfig_add=CONFIG_KASAN=y
>
> This flag is inspired by TuxMake's --kconfig-add, see
> https://gitlab.com/Linaro/tuxmake#examples.
>
> Our version just uses "_" as the delimiter for consistency with
> pre-existing flags like --build_dir, --make_options, --kernel_args, etc.
>
> Note: this does make it easier to run into a pre-existing edge case:
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kconfig_add=CONFIG_KASAN=y
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64
> This second invocation ^ still has KASAN enabled!
>
> kunit.py won't call olddefconfig if our current .config is already a
> superset of the provided kunitconfig.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

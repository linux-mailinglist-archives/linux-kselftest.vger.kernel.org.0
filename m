Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC1C49497B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jan 2022 09:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359240AbiATIao (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jan 2022 03:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359252AbiATIaC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jan 2022 03:30:02 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A0C061749
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 00:30:01 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so11873494wmq.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 00:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwGv/8SwrgHrrCdD+znAh14qmRCXOFOe1aQhnNfhrho=;
        b=VeCt/8C9JFyQWmFn0h8Me/FbyrtYM1CBBgou8p+ugm9uUDLSM06LuVzMdc5GGNpi6k
         Zf66K9dKqHmH0XDg8g8sXdZDoidK777CM7WCMk7zr79iu7Gwl4/KZcKPxvLzPvoUR2gl
         fy/UJpiNFpgyT8JQqw/aUtxfr6RyrjG1T7ocaGqYqFl+BF2xLhTgI6rf99es95iqmvaV
         Ajxp9MaqUn1KfO6AyEEYUe+CvfdUjRIOPurTrwqi5SvM+dn6kS1I7AmqXfTyI7fiAS7f
         dnB0/1bRSed+4CqfY9n84s5lfVvQtCCzGDISB9ajRjrAfRwvuxA8FYogIu/VQmFsMLF3
         e7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwGv/8SwrgHrrCdD+znAh14qmRCXOFOe1aQhnNfhrho=;
        b=33o6ZjJe+a9VOv+9zxCRnVW4n3t3LeozRhuJp9vje+7Ti1pjukruf03Zid2BZIBtE5
         5qdo0p7N2kgSzbN55Fmo2lEnON7Bwo43WS0xAJHRQ8elyHcBSMerUySAkcSORo2ykIWY
         n8fk2zOedi5I01h/cMjXpwu4tD5Xj8XQcyHmV1BqPQRdGI0om+GQSmlZKLtSXzHxWHBx
         qn1q+brZYE0QA4/hBIwMdNv0ppEzup0ZxtOH975gVUir/5OFRCpiq3091m0NB1wLNvxV
         34ZyZ22OVRsf0FTCU98dDFECQYVi5WTVQHkIYqe0WMPEYWM16iTcv3Z5045xg/1ELKBO
         v55Q==
X-Gm-Message-State: AOAM530wuLXN3OBz9jiJSYe02Cp02YStHA9r70w+5xAbINd0HPQWRGOU
        MP/F0b3I0nBfrZvPu29+BG05727tlHYSWX6XOF5xtA==
X-Google-Smtp-Source: ABdhPJwTkcuZQfeVqYEksff78+o7mq5FMu1onryN8ZF/bwp0cD0njfJHKM0V2MqP/f/7srKx7XbtSlFnmnH1jhYBEt4=
X-Received: by 2002:adf:f48a:: with SMTP id l10mr32377787wro.220.1642667400108;
 Thu, 20 Jan 2022 00:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <20220118190922.1557074-3-dlatypov@google.com>
In-Reply-To: <20220118190922.1557074-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 20 Jan 2022 16:29:48 +0800
Message-ID: <CABVgOS=290dX4JnBj+d9jTMVvEJXude0Xxk9fdSZbU9xNQ8_pw@mail.gmail.com>
Subject: Re: [PATCH 3/5] kunit: tool: drop unused KernelDirectoryPath var
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

On Wed, Jan 19, 2022 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit be886ba90cce ("kunit: run kunit_tool from any directory")
> introduced this variable, but it was unused even in that commit.
>
> Since it's still unused now and callers can instead use
> get_kernel_root_path(), delete this var.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  tools/testing/kunit/kunit.py | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index bd2f7f088c72..4cb91d191f1d 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -63,8 +63,6 @@ class KunitRequest(KunitExecRequest, KunitBuildRequest):
>         pass
>
>
> -KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
> -
>  def get_kernel_root_path() -> str:
>         path = sys.argv[0] if not __file__ else __file__
>         parts = os.path.realpath(path).split('tools/testing/kunit')
> --
> 2.34.1.703.g22d0c6ccf7-goog
>

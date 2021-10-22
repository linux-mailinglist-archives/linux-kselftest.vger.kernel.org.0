Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F63436F95
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Oct 2021 03:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhJVByc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 21:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhJVByb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 21:54:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D14C061766
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 18:52:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k7so2262482wrd.13
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 18:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RqJHISvUCdhEFp+Jfgg5EOh8TgpsKhCaH+eHcg+5i2Y=;
        b=geA75xiju7ZMZN4ckoJltl1taoSytz0vDR0aUH2zGkzS5LlcaCLYJ3v2j65OVqS4d0
         LhNXXiHE1nTM1iJlHxOLKkwEKqE8scg/s4lgsQOOjDPUCmbeZlgy3mT9AiIfPILncws/
         uWxZO8gzRA5niJ2cNZTrDedqyQ0yUDXEmIO8Ipohvu4ukJoYznxsDQdkzQE+pMtNyNWf
         zEU5A2mOwsB30h9aiQvUxUrRzH5lTZ8ba9mZ+wD5n3XY5VNlivfz1e3HFa+KiDdils8R
         9ITkrwBZPx+mboOIkxpjLC8Dv3tAeODQEfoYNTyTNtVWsOCxeaGy9/FTFVYmeFOX2qun
         Ql7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqJHISvUCdhEFp+Jfgg5EOh8TgpsKhCaH+eHcg+5i2Y=;
        b=rIQ4F5UK4Qd7dgZejps00LvRivh+z6+vxA/w1jNJ1wdUPp4/+zFLZrN4i1Ay5tA7Yd
         lstBminmT3MjqEkl+YD+j/ytxJtPBrrOnu/4XcxZnZLPPUKxaeXLxkKRm1Q77f8lgBwo
         36yf10698jj3xGsc7ToKtnH3CBzZvFFUr9cIhlqj3vtwXUIgL5Ucbn0I6mlIbIYo66HT
         r17wScQCgjyM1h3UUqV2Abz2jOHKkubQhTSp4qVr2TDM0MdFXkcco0kw+C8RAAN7TmCi
         0V7pZkf5V/zp31/1T5FM4ZtdlGkA+Asj+nId3+5IhW32J1cGtLxgx+Qj9xtFBd2wLZiq
         B25Q==
X-Gm-Message-State: AOAM53049zS1Bir0QQUAjlvVswP8LGl0ev3gLAp4paF2kUOsrjxOnoAl
        rAbT9H9x/JLzx/9D7xy40ANKtDyou5vSdYXhJzXgZw==
X-Google-Smtp-Source: ABdhPJzJUYAcLIkgypewSxqfh/YypBeD5x+U0jk4OrSfZ4B3G4uCjLduqAwQvZ5WQyX9+qPxhn5uB82NxzZ27LTAVLg=
X-Received: by 2002:a05:6000:1362:: with SMTP id q2mr11861419wrz.44.1634867533110;
 Thu, 21 Oct 2021 18:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211022004936.2049804-1-dlatypov@google.com>
In-Reply-To: <20211022004936.2049804-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Oct 2021 09:52:01 +0800
Message-ID: <CABVgOSmn+JGAaNV7FFOfzrn=dODHFE==YUSEE3qqBeKiy+j2pA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix typecheck errors about loading qemu configs
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

On Fri, Oct 22, 2021 at 8:49 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Currently, we have these errors:
> $ mypy ./tools/testing/kunit/*.py
> tools/testing/kunit/kunit_kernel.py:213: error: Item "_Loader" of "Optional[_Loader]" has no attribute "exec_module"
> tools/testing/kunit/kunit_kernel.py:213: error: Item "None" of "Optional[_Loader]" has no attribute "exec_module"
> tools/testing/kunit/kunit_kernel.py:214: error: Module has no attribute "QEMU_ARCH"
> tools/testing/kunit/kunit_kernel.py:215: error: Module has no attribute "QEMU_ARCH"
>
> exec_module
> ===========
>
> pytype currently reports no errors, but that's because there's a comment
> disabling it on 213.
>
> This is due to https://github.com/python/typeshed/pull/2626.
> The fix is to assert the loaded module implements the ABC
> (abstract base class) we want which has exec_module support.
>
> QEMU_ARCH
> =========
>
> pytype is fine with this, but mypy is not:
> https://github.com/python/mypy/issues/5059
>
> Add a check that the loaded module does indeed have QEMU_ARCH.
> Note: this is not enough to appease mypy, so we also add a comment to
> squash the warning.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks -- this has been annoying me quite a bit, so it's good to have
it fixed. It's a bit of a shame mypy needs the additional comment, but
what can you do...

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_kernel.py | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index faa6320e900e..c68b17905481 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -207,12 +207,15 @@ def get_source_tree_ops_from_qemu_config(config_path: str,
>         module_path = '.' + os.path.join(os.path.basename(QEMU_CONFIGS_DIR), os.path.basename(config_path))
>         spec = importlib.util.spec_from_file_location(module_path, config_path)
>         config = importlib.util.module_from_spec(spec)
> -       # TODO(brendanhiggins@google.com): I looked this up and apparently other
> -       # Python projects have noted that pytype complains that "No attribute
> -       # 'exec_module' on _importlib_modulespec._Loader". Disabling for now.
> -       spec.loader.exec_module(config) # pytype: disable=attribute-error
> -       return config.QEMU_ARCH.linux_arch, LinuxSourceTreeOperationsQemu(
> -                       config.QEMU_ARCH, cross_compile=cross_compile)
> +       # See https://github.com/python/typeshed/pull/2626 for context.
> +       assert isinstance(spec.loader, importlib.abc.Loader)
> +       spec.loader.exec_module(config)
> +
> +       if not hasattr(config, 'QEMU_ARCH'):
> +               raise ValueError('qemu_config module missing "QEMU_ARCH": ' + config_path)
> +       params: qemu_config.QemuArchParams = config.QEMU_ARCH  # type: ignore
> +       return params.linux_arch, LinuxSourceTreeOperationsQemu(
> +                       params, cross_compile=cross_compile)
>
>  class LinuxSourceTree(object):
>         """Represents a Linux kernel source tree with KUnit tests."""
>
> base-commit: 17ac23eb43f0cbefc8bfce44ad51a9f065895f9f
> --
> 2.33.0.1079.g6e70778dc9-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20211022004936.2049804-1-dlatypov%40google.com.

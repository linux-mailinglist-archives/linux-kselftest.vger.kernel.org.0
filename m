Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F5F199DFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Mar 2020 20:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgCaS1b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Mar 2020 14:27:31 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36748 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCaS1b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Mar 2020 14:27:31 -0400
Received: by mail-pj1-f67.google.com with SMTP id nu11so1430267pjb.1
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Mar 2020 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLVDD+NzMHaNk3lT9nXy779lPxGGvFl1BeZrYwA43Fw=;
        b=eZaUbKqBQsAGEDWohcgVWreqYFpuy1mtBi8+zOZFx4hKtYXVoodnXBRoqO5ffqHmyJ
         s+TE9G2H7Wez9Qr9x1vq0LGjzrhad/x5PKrJ1+UMhBbOBxRBDX7ry0dL3vIHj1k75YVv
         7NqwAL+5p8OUn3W7fOUI219Glds7agiAj/hLMgByUGeC2b9+fW2EpYPyKoQw6c1z9g3U
         KtK6Ia2Gx7k5g6CjE4Kc2Bo18fYpsJSHTS25OlRYlqeE/r4+8wLTDR9rmVMqcQ6Y2JtF
         sUNYHN8gSJS9S2L1MfGM/RZnGtHHdFTIfnHnyhceOUiyeOifHVSMKIDrD/KANnLQ7Th5
         O28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLVDD+NzMHaNk3lT9nXy779lPxGGvFl1BeZrYwA43Fw=;
        b=ACYQWLmgzCqLswBk4+rdLwOpe2a7KfnOeFBb3s5dNYntqu1tpKozuYY3AGdVJ7o3e6
         A8jj79VROvfSjXzBNtUdpzE7sIAsQr/nZ8/sy0vnWPdyO2op5PAev1dg4lj+IV8j3n6c
         amRn1CT+Dxx3DbQfnTC9b7ecy2o1qllPe3828DbhU1Sp2ca0bZdo/Qs2eCpGl++07Gf/
         Pi4waIWqyeFL+pKwGSUcAIeAWOCzgm1tvY1QvMuEtoyjIGm5IGg2yf7IVn4Hxub9HF8S
         +7/YVKF+iZfqjkbTfl/ffyuZqTmSvqjr/VznBemdyi7DEZMp4zNf71WOZDa81CAIuMlL
         TUeA==
X-Gm-Message-State: AGi0PuaGiOQ76deUtlWGzsoF8YaAS9wpwt8+b5H+9bwGy1lZGXSWEfgw
        Xd3e/7GrDj22BC6OG24SdxWz6GkHX/lRJ3nLjiQ7Pg==
X-Google-Smtp-Source: APiQypI7iAE735GgCKkeZusjs8UlrOmYraVum5tmyZ7a9ZtEskbpvk2jByn4JUjxs7U3xgaqUrYxkZIAf+J/001kv4E=
X-Received: by 2002:a17:90a:9f03:: with SMTP id n3mr209849pjp.29.1585679249825;
 Tue, 31 Mar 2020 11:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200330230256.28323-1-vitor@massaru.org>
In-Reply-To: <20200330230256.28323-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 31 Mar 2020 11:27:18 -0700
Message-ID: <CAFd5g47hiPf7Xy0f4YER+HzHHXyUV0dhiQ=2ZXfezEHBcrTuEQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix kunit.py run --build_dir='<foo>' fails on
 "unclean" trees
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 30, 2020 at 4:03 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Fix this bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219
>
> For some reason, the environment variable ARCH is used instead of ARCH
> passed as an argument, this patch uses a copy of the env, but using
> ARCH=um and CROSS_COMPILER='' to avoid this problem.
>
> This patch doesn't change the user's environment variables, avoiding
> side effects.

Seems reasonable to me.

> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

I cannot test this as your patch doesn't apply to our for-next branch
(kselftest/kunit). You can find it here:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit

> ---
>  tools/testing/kunit/kunit_kernel.py | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index d99ae75ef72f..0cb1f81ac8f2 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -15,6 +15,7 @@ import kunit_config
>
>  KCONFIG_PATH = '.config'
>  kunitconfig_path = '.kunitconfig'
> +env = dict(os.environ.copy(), ARCH='um', CROSS_COMPILE='')
>
>  class ConfigError(Exception):
>         """Represents an error trying to configure the Linux kernel."""
> @@ -36,22 +37,22 @@ class LinuxSourceTreeOperations(object):
>                         raise ConfigError(e.output)
>
>         def make_olddefconfig(self, build_dir):
> -               command = ['make', 'ARCH=um', 'olddefconfig']
> +               command = ['make', 'olddefconfig']
>                 if build_dir:
>                         command += ['O=' + build_dir]
>                 try:
> -                       subprocess.check_output(command)
> +                       subprocess.check_output(command, env=env)
>                 except OSError as e:
>                         raise ConfigError('Could not call make command: ' + e)
>                 except subprocess.CalledProcessError as e:
>                         raise ConfigError(e.output)
>
>         def make(self, jobs, build_dir):
> -               command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
> +               command = ['make', '--jobs=' + str(jobs)]
>                 if build_dir:
>                         command += ['O=' + build_dir]
>                 try:
> -                       subprocess.check_output(command)
> +                       subprocess.check_output(command, env=env)
>                 except OSError as e:
>                         raise BuildError('Could not call execute make: ' + e)
>                 except subprocess.CalledProcessError as e:
> @@ -66,7 +67,8 @@ class LinuxSourceTreeOperations(object):
>                         [linux_bin] + params,
>                         stdin=subprocess.PIPE,
>                         stdout=subprocess.PIPE,
> -                       stderr=subprocess.PIPE)
> +                       stderr=subprocess.PIPE,
> +                       env=env)
>                 process.wait(timeout=timeout)
>                 return process
>
> --
> 2.21.1
>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771AA1A16D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Apr 2020 22:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDGUbU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Apr 2020 16:31:20 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56228 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGUbU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Apr 2020 16:31:20 -0400
Received: by mail-pj1-f68.google.com with SMTP id fh8so230554pjb.5
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Apr 2020 13:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKqZWyMQ8V8zQ20un6jU7HEK04ADqKGnxMMnNcQmdRY=;
        b=a0fZT4bKGAAC/shPL7O9e0uWZrLTjV2ylyJY2sfBmRY6B5ZvfW0dghucSOrpamWJPY
         JUCYKHnWorr9tUamq/iR4giSU6tjk4oCiShBGmL782UKl0DWVLzfSxGttgdlmHeSMD8n
         USEybio2T7VuUT2fLczo63Ru53sMFCVzfTlT+mU1Fa/ap6GWDg2VcjCg86jjpviYRHXc
         Iz7So5F7Udpr9Lbhc79nVirD0nmXaF25Itbm1mm1GG9t2QNB6iWyFMa5OAL092sfbgH8
         5AztG4ripU+6zZTSDZvgQZCVw8RocoC0t5NurWuTODsqnHquobk+085szhz7aVytbHti
         ZXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKqZWyMQ8V8zQ20un6jU7HEK04ADqKGnxMMnNcQmdRY=;
        b=SM7NJcwo1fenIu+aYmERJ85Iv9Oixva3VAZYCfFxyvl/yRGgTQW2ZczWh23l7UgIFv
         suXVRVG62tYQhnlR+sRy7XIFNARdT/BrJzvDteg9FsJcUDh7+72WIyaGoh04JVLlsL+4
         uT27gaA0PBexWi8keKNQxYBRoyQ3RFmos/9HzeoxHAyu9iSl3gjSoVGvHWbTR/dAzpZg
         vJ15oDefnStcO9dehPBSzBGHXjKAjg8IFLYqKEt8kCy/T9hUD0J0/2Td7Fw6tF9oSHRG
         u0nRz6Rp6pXpybC/D1DyGF/VLxIbXFDeaVY4vWLCRF6XSCIt6fle1rx9tE+5XiajXT2h
         RHoQ==
X-Gm-Message-State: AGi0PuZjBsa53nlRU9CwplKdSPsm+rBWvAiJrjqb6qEpj+QUa7lN4meA
        kRnxC7akW751PJ6yOvt3u2zvJMPx+L0kpIhEJd32DA==
X-Google-Smtp-Source: APiQypKi0NHL1kvG+6WjCjMqalM7lL+WN8MrRtbStR3FlzJY1khKq++r7+B0jHFKqM7izTL5ggeQhNjpij2BSWIXUw4=
X-Received: by 2002:a17:90a:30c3:: with SMTP id h61mr1246223pjb.18.1586291478614;
 Tue, 07 Apr 2020 13:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200406221916.50008-1-vitor@massaru.org>
In-Reply-To: <20200406221916.50008-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Apr 2020 13:31:07 -0700
Message-ID: <CAFd5g44EGCY0zHfZXekS8GAXHxrf5zeeTW=MHRz0NujKqTsRQg@mail.gmail.com>
Subject: Re: [PATCH v3, RESEND] kunit: Fix kunit.py run --build_dir='<foo>'
 fails on "unclean" trees
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

On Mon, Apr 6, 2020 at 3:19 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Fix this bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219

I am still seeing the error described in the bug.

Steps to reproduce:

1. tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig

2. make ARCH=um mrproper

3. tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig
--build_dir=.kunit

One other note: It should probably be done in another patch, but it
would be nice if kunit.py would tell you that you need to run mrproper
when the olddefconfig fails.

> For some reason, the environment variable ARCH is used instead of ARCH
> passed as an argument, this patch uses a copy of the env, but using
> ARCH=um and CROSS_COMPILER='' to avoid this problem.
>
> This patch doesn't change the user's environment variables, avoiding
> side effects.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
> v2:
>  - Use the correct next branch
>
> v3:
>  - Use torvalds/master branch
>  - Use base parameter on git send-email
> ---
>  tools/testing/kunit/kunit_kernel.py | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 63dbda2d029f..96216c699fde 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -20,6 +20,7 @@ import kunit_parser
>  KCONFIG_PATH = '.config'
>  kunitconfig_path = '.kunitconfig'
>  BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
> +env = dict(os.environ.copy(), ARCH='um', CROSS_COMPILE='')
>
>  class ConfigError(Exception):
>         """Represents an error trying to configure the Linux kernel."""
> @@ -41,13 +42,15 @@ class LinuxSourceTreeOperations(object):
>                         raise ConfigError(e.output)
>
>         def make_olddefconfig(self, build_dir, make_options):
> -               command = ['make', 'ARCH=um', 'olddefconfig']
> +               command = ['make', 'olddefconfig']
>                 if make_options:
>                         command.extend(make_options)
>                 if build_dir:
>                         command += ['O=' + build_dir]
>                 try:
> -                       subprocess.check_output(command, stderr=subprocess.PIPE)
> +                       subprocess.check_output(command,
> +                                               stderr=subprocess.PIPE,
> +                                               env=env)
>                 except OSError as e:
>                         raise ConfigError('Could not call make command: ' + e)
>                 except subprocess.CalledProcessError as e:
> @@ -57,9 +60,10 @@ class LinuxSourceTreeOperations(object):
>                 kunit_parser.print_with_timestamp(
>                         'Enabling all CONFIGs for UML...')
>                 process = subprocess.Popen(
> -                       ['make', 'ARCH=um', 'allyesconfig'],
> +                       ['make', 'allyesconfig'],
>                         stdout=subprocess.DEVNULL,
> -                       stderr=subprocess.STDOUT)
> +                       stderr=subprocess.STDOUT,
> +                       env=env)
>                 process.wait()
>                 kunit_parser.print_with_timestamp(
>                         'Disabling broken configs to run KUnit tests...')
> @@ -71,13 +75,13 @@ class LinuxSourceTreeOperations(object):
>                         'Starting Kernel with all configs takes a few minutes...')
>
>         def make(self, jobs, build_dir, make_options):
> -               command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
> +               command = ['make', '--jobs=' + str(jobs)]
>                 if make_options:
>                         command.extend(make_options)
>                 if build_dir:
>                         command += ['O=' + build_dir]
>                 try:
> -                       subprocess.check_output(command)
> +                       subprocess.check_output(command, env=env)
>                 except OSError as e:
>                         raise BuildError('Could not call execute make: ' + e)
>                 except subprocess.CalledProcessError as e:
> @@ -91,7 +95,8 @@ class LinuxSourceTreeOperations(object):
>                 with open(outfile, 'w') as output:
>                         process = subprocess.Popen([linux_bin] + params,
>                                                    stdout=output,
> -                                                  stderr=subprocess.STDOUT)
> +                                                  stderr=subprocess.STDOUT,
> +                                                  env=env)
>                         process.wait(timeout)
>
>
>
> base-commit: 7e63420847ae5f1036e4f7c42f0b3282e73efbc2
> --
> 2.25.1
>

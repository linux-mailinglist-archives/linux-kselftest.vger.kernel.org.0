Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04ED3199F41
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Mar 2020 21:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgCaTjL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Mar 2020 15:39:11 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35736 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgCaTjK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Mar 2020 15:39:10 -0400
Received: by mail-yb1-f195.google.com with SMTP id x63so11830162ybx.2
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Mar 2020 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmyCyWagylfuKeKB4BO2p4EHeCrzlGpSPlijLTrzQrE=;
        b=i3NpJnHq4kSwxmmk+3rXgxdW8Wt5LW4Edf8xpVA/myZ6FFGqWy/Sa+cGk5maohkOQg
         y8WPF8b84LcU2zQHXVM70zuqSL6ixG4qKmAdHZshTqzvgvpH3/x4nny6bJrgYirLw/Xt
         e+VOU9zfivBrm990mM3EWL29oUt2b6LNVZQEWsmCGkYJhexuUp9A0JbWWyxZM/vQkx03
         tzyBPfueZyGMUmSjzf8LtNpzxWmqXsIIpiCLUk7f/1CEBepL5tBomiR3cob+FkM33OPo
         RQSd9hB1ceYDCHxgX2JI6Y03S00SeRYbcs6RihoC5/E9NC8F49Un2sMHlO+AzuTxlQUa
         PcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmyCyWagylfuKeKB4BO2p4EHeCrzlGpSPlijLTrzQrE=;
        b=udhKaf/zsM1d977BbWK7AF8NjnOGoct0J/VTM3A6S2gIWJ1ZQwfRs03ctPkDRX5PmD
         s0DqXMFFL01UT9bH2bQEWvJea3XUP+7l1g+vdYp6gGFTHeZFaHOMB3kMg3D7Q9PhqMQp
         zvqopj9Qal/h0BFByP/PZJ0l1kZLiQTzg4fun6JgLdyi+eoFgbfiejETMgk0v6tSbfFQ
         SVJnydp9JRzWbxlnvqRR4tIrWCN/KJSxhTnRLcoUMtnLpifo2nSenCXn5D66keU/Ssgh
         NEsqSkFY/dF2EsuY4e5RpOj+v1Ez92WlF2jq3D8+GNxguzvWazmtO1g9mwbEr/u3kpyw
         rN+g==
X-Gm-Message-State: ANhLgQ16xQWFyeR/13Jpqv+sjgRcc0qHmENXcRXBg2YFWSWOxcA1ATYz
        wNufj4UB2qZaVD5GYoNZJEQIMg622RU21i4j0S0HkA==
X-Google-Smtp-Source: ADFU+vtC9v29cwTvgQzCRkzqmplSAGo2pfpyc7gBVxRCNiuU28PdpgwpW/Ke6FkwW6/6YGQT2lEDfhOzwI5e3wgwWTc=
X-Received: by 2002:a25:c482:: with SMTP id u124mr31079143ybf.286.1585683547417;
 Tue, 31 Mar 2020 12:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200330230256.28323-1-vitor@massaru.org> <CAFd5g47hiPf7Xy0f4YER+HzHHXyUV0dhiQ=2ZXfezEHBcrTuEQ@mail.gmail.com>
In-Reply-To: <CAFd5g47hiPf7Xy0f4YER+HzHHXyUV0dhiQ=2ZXfezEHBcrTuEQ@mail.gmail.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Tue, 31 Mar 2020 16:38:30 -0300
Message-ID: <CADQ6JjUUFsJdgeLNA8XUkSF14H=WWF8y2eNTvQPNXHRQ+p_qBw@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix kunit.py run --build_dir='<foo>' fails on
 "unclean" trees
To:     Brendan Higgins <brendanhiggins@google.com>
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

Hi Brendan,

On Tue, Mar 31, 2020 at 3:27 PM 'Brendan Higgins' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> On Mon, Mar 30, 2020 at 4:03 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
> >
> > Fix this bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219
> >
> > For some reason, the environment variable ARCH is used instead of ARCH
> > passed as an argument, this patch uses a copy of the env, but using
> > ARCH=um and CROSS_COMPILER='' to avoid this problem.
> >
> > This patch doesn't change the user's environment variables, avoiding
> > side effects.
>
> Seems reasonable to me.

There are other problems here, I'll fix it.

>
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
>
> I cannot test this as your patch doesn't apply to our for-next branch
> (kselftest/kunit). You can find it here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit
>
> > ---
> >  tools/testing/kunit/kunit_kernel.py | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > index d99ae75ef72f..0cb1f81ac8f2 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -15,6 +15,7 @@ import kunit_config
> >
> >  KCONFIG_PATH = '.config'
> >  kunitconfig_path = '.kunitconfig'
> > +env = dict(os.environ.copy(), ARCH='um', CROSS_COMPILE='')
> >
> >  class ConfigError(Exception):
> >         """Represents an error trying to configure the Linux kernel."""
> > @@ -36,22 +37,22 @@ class LinuxSourceTreeOperations(object):
> >                         raise ConfigError(e.output)
> >
> >         def make_olddefconfig(self, build_dir):
> > -               command = ['make', 'ARCH=um', 'olddefconfig']
> > +               command = ['make', 'olddefconfig']
> >                 if build_dir:
> >                         command += ['O=' + build_dir]
> >                 try:
> > -                       subprocess.check_output(command)
> > +                       subprocess.check_output(command, env=env)
> >                 except OSError as e:
> >                         raise ConfigError('Could not call make command: ' + e)
> >                 except subprocess.CalledProcessError as e:
> >                         raise ConfigError(e.output)
> >
> >         def make(self, jobs, build_dir):
> > -               command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
> > +               command = ['make', '--jobs=' + str(jobs)]
> >                 if build_dir:
> >                         command += ['O=' + build_dir]
> >                 try:
> > -                       subprocess.check_output(command)
> > +                       subprocess.check_output(command, env=env)
> >                 except OSError as e:
> >                         raise BuildError('Could not call execute make: ' + e)
> >                 except subprocess.CalledProcessError as e:
> > @@ -66,7 +67,8 @@ class LinuxSourceTreeOperations(object):
> >                         [linux_bin] + params,
> >                         stdin=subprocess.PIPE,
> >                         stdout=subprocess.PIPE,
> > -                       stderr=subprocess.PIPE)
> > +                       stderr=subprocess.PIPE,
> > +                       env=env)
> >                 process.wait(timeout=timeout)
> >                 return process
> >
> > --
> > 2.21.1
> >
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/CAFd5g47hiPf7Xy0f4YER%2BHzHHXyUV0dhiQ%3D2ZXfezEHBcrTuEQ%40mail.gmail.com.

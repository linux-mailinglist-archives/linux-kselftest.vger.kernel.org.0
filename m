Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9318A4F9BD1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 19:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiDHRkd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 13:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiDHRkc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 13:40:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131C78913
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 10:38:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so18705357ejd.9
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Apr 2022 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCtkA6xuwOw9B42llupBXBeDd/2F5GvCTf370rFfnJ8=;
        b=Hn8ljd+RZWCvBh/7HfacqS5lvXMs6LiLORiHzbMY/iuV/UpxlfczKAmrYr+y3dPPUu
         LQbko47/j4Hn5/TccEsJfO8Tv3Mu2lz7udhdQIzSwktHItLjmZHd6Qsjq6F53LXfCZMi
         lmKitSqBd7gwZ4ZtH57Lway661pRrKvYXmxcT69xEkWbR1ZP5TXzkRICgFr/rVHydMun
         2FkfKStSZQWPr1wabHyj8AS46B762n6c3B7h2NZLoIt9rjioxIvyN+XYSJm5P+1Ct06c
         RTGRut+OPvwJiLsVa186iOmZEqFqnCSPVJLdO3hzo9LtGAhxjHdxosGsMc4FeHFwuoTx
         B2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCtkA6xuwOw9B42llupBXBeDd/2F5GvCTf370rFfnJ8=;
        b=UUqCRUmyV2CHX3exyfivOA58jLipAmvU3fvgC2Zwsmsp+SiAWzgsW6uOKtY/aMtmAx
         fG8pL+A8jjJ8s+o0V1RRkWdYTrU0V5/CGBvhJOjj2nm5TPcmjTo3kMIat7+X6ZUi2lAb
         naysQG0piwZ2Gujexgdz2N8im71Hy/dw0SlnRgkT70bkB8h3R4OWaO20CRhzpidBK9I/
         yf7YCgOsHcGHZA4c0Oa2E8X7fl7pwgnCBigBMd9xNQAZn/j1KyJJY2lc6B2shBZJitCE
         KEI2sWTkN3zjia0xuKrXbliahMj2i32aEy9bA3wYm3Jn5t9crErHjsNUFCioRO3vr+jW
         ZdNw==
X-Gm-Message-State: AOAM533+kzgrxGC9CbAVaI5tVbwhCaEs8KCrbkg3u9iQnfiWT5auNhVZ
        H1GJAge8vc5K9BTbAfFIypGyp7vZGstqtRNurQf1XA==
X-Google-Smtp-Source: ABdhPJw+kLuiBENK2YbdVsUNz9zWdoTC7aXSJHJRpOG9+6LSmeVoEF7ZhM1+6H3LzpZoN8c0Ven9XJyRsfLWaFHi/9U=
X-Received: by 2002:a17:906:6a21:b0:6e8:6cad:23f9 with SMTP id
 qw33-20020a1709066a2100b006e86cad23f9mr46888ejc.75.1649439506866; Fri, 08 Apr
 2022 10:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220407193902.1981605-1-dlatypov@google.com> <CABVgOSm-sDx8G0iphFXEgnsF-c9eu++bxtXjhOM_WHx-mkRiTA@mail.gmail.com>
In-Reply-To: <CABVgOSm-sDx8G0iphFXEgnsF-c9eu++bxtXjhOM_WHx-mkRiTA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 8 Apr 2022 12:38:15 -0500
Message-ID: <CAGS_qxoJtGYuFPuOBYfJd-gm0+dpHstMVJDQ7=9xdU8EtW9VFQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: cosmetic: don't specify duplicate kunit_shutdown's
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 7, 2022 at 10:17 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Apr 8, 2022 at 3:39 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Context:
> > When using a non-UML arch, kunit.py will boot the test kernel with these
> > options by default:
> > > mem=1G console=tty kunit_shutdown=halt console=ttyS0 kunit_shutdown=reboot
> >
> > For QEMU, we need to use 'reboot', and for UML we need to use 'halt'.
> > If you switch them, kunit.py will hang until the --timeout expires.
> >
> > So the code currently unconditionally adds 'kunit_shutdown=halt' but
> > then appends 'reboot' when using QEMU (which overwrites it).
> >
> > This patch:
> > Having these duplicate options is a bit noisy.
> > Switch so we only add 'halt' for UML.
> >
> > I.e. we now get
> > UML: 'mem=1G console=tty console=ttyS0 kunit_shutdown=halt'
> > QEMU: 'mem=1G console=tty console=ttyS0 kunit_shutdown=reboot'
> >
> > Side effect: you can't overwrite kunit_shutdown on UML w/ --kernel_arg.
> > But you already couldn't for QEMU, and why would you want to?
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Thanks so much for fixing this: it had been quietly bugging me for a while.
>
> This looks pretty good as is, but I have a few suggestions for
> extending it which could be nice to have. I've put them inline below.
>
> Either way,
> Reviewed-by: David Gow <davidgow@google.com>
>
> >  tools/testing/kunit/kunit_kernel.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > index 483f78e15ce9..9731ceb7ad92 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -158,7 +158,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> >         def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> >                 """Runs the Linux UML binary. Must be named 'linux'."""
> >                 linux_bin = os.path.join(build_dir, 'linux')
> > -               return subprocess.Popen([linux_bin] + params,
> > +               return subprocess.Popen([linux_bin] + params + ['kunit_shutdown=halt'],
>
> I'd slightly prefer it if we assigned these extra parameters to a
> separate variable, rather than including them directly in the
> subprocess.Popen call.

I'm not sure I understand the suggestion here.
But PTAL at the diff down below and see if that looks fine.
I'll send a v2 that moves all of the default kernel args into UML only
as they're UML-specific, as you pointed out.

>
> (One thing I'd like to do is to print out the command we're running,
> which we do for Qemu, and having it in a variable that's passed in
> would be convenient. I don't expect this patch to do that, but having
> these parameters separate would make that future diff a little
> smaller.)
>
> >                                            stdin=subprocess.PIPE,
> >                                            stdout=subprocess.PIPE,
> >                                            stderr=subprocess.STDOUT,
> > @@ -332,7 +332,7 @@ class LinuxSourceTree(object):
> >         def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
> >                 if not args:
> >                         args = []
> > -               args.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
> > +               args.extend(['mem=1G', 'console=tty'])
>
> Does it make sense to also make these options UML only.

Yes, I think that's entirely correct.

mem=1G is redundant w/ the hard-coded '-m 1024' we pass to QEMU.
console=tty is overwritten by every architecture via its qemu_config.

So this patch would be better as

diff --git a/tools/testing/kunit/kunit_kernel.py
b/tools/testing/kunit/kunit_kernel.py
index 483f78e15ce9..d497adcd0684 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -158,6 +158,7 @@ class
LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
        def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
                """Runs the Linux UML binary. Must be named 'linux'."""
                linux_bin = os.path.join(build_dir, 'linux')
+               params.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
                return subprocess.Popen([linux_bin] + params,
                                           stdin=subprocess.PIPE,
                                           stdout=subprocess.PIPE,
@@ -332,7 +333,6 @@ class LinuxSourceTree(object):
        def run_kernel(self, args=None, build_dir='', filter_glob='',
timeout=None) -> Iterator[str]:
                if not args:
                        args = []
-               args.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
                if filter_glob:
                        args.append('kunit.filter_glob='+filter_glob)

>
> Under Qemu, the amount of memory is already passed separately to qemu,
> so adding another limit here seems counterproductive. If an
> architecture particularly needs it, we can add it to the
> per-architecture config.
>

On that note, sparc has a mem kernel_cmdline option.
tools/testing/kunit/qemu_configs/alpha.py: kernel_command_line='console=ttyS0',
tools/testing/kunit/qemu_configs/arm64.py:
kernel_command_line='console=ttyAMA0',
tools/testing/kunit/qemu_configs/arm.py: kernel_command_line='console=ttyAMA0',
tools/testing/kunit/qemu_configs/i386.py: kernel_command_line='console=ttyS0',
tools/testing/kunit/qemu_configs/powerpc.py:
kernel_command_line='console=ttyS0',
tools/testing/kunit/qemu_configs/riscv.py: kernel_command_line='console=ttyS0',
tools/testing/kunit/qemu_configs/s390.py: kernel_command_line='console=ttyS0',
tools/testing/kunit/qemu_configs/sparc.py:
kernel_command_line='console=ttyS0 mem=256M',
tools/testing/kunit/qemu_configs/x86_64.py: kernel_command_line='console=ttyS0',

Not sure why we'd do that atm.

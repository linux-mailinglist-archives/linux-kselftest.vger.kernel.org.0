Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62F4C35B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 20:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiBXTUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 14:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiBXTUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 14:20:18 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448781C2F4D
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 11:19:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i11so4261806eda.9
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VATloFIFOYSF7bULywKKNi4BXTcUzUGI2Feo95RIsUA=;
        b=q99VBCao934/ZmCDT1MqxxEx6/2Evwlhr82gN7P1kO+1UaInYgpIWPru60gvA6QXzK
         rMsuECYuQQarqjAq4Pt1ihJetGUVHuJY/VLwPLv3v7VRwyAjPlnPDcG6+hExyoR/V9g2
         Qdzx5Jrfl9+DITfW40WAstrYLflu78UNWhl5gWp/Ut7tDtjmbvs9jR6Xm3/fNjamvQKg
         7k6okgbolmlsnELmAPC3k3N5q3dTovR8VwVacgpDiuzhfJb1RhxPzMMYd9kj6dR3XZLM
         JRYHfFV9GKCYiibv/4f+qgz8JTRws9mcunQ7X251bnoK4tzohdEcBB8jxdW2t7sTpX5y
         6j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VATloFIFOYSF7bULywKKNi4BXTcUzUGI2Feo95RIsUA=;
        b=cFxp9GZF4EicQJgxUfBwOjf1Y3L7SyaKW1SY4cKaBxtayt7tagiWaglN+Wmc3z41oa
         8K8DIbDu2FxMMasd4eun/3iH6W26BnYLoc1+XDEqDPR21OmHnSg/OlDvFaxRBTDjuz0y
         ONpLLLFeLuETE3vWNJRYX3dtf2JtNBEgPoEYcMtF3BU4hDVh7DXrYe89Tty09vUN9iI1
         7UGonfNuiuaSBYss4JzWdJPVFIlU86iF84bp9xt+FLlrXyfS9m+DfnGlqtdkyzRP3TCC
         pkcX58npiW0pdle90oZtBLNsghbeX2GkZnpo2iaM1JHg7Na0zIwmpiWU5KkDAKrsBMw9
         Itgw==
X-Gm-Message-State: AOAM530LNNsu9DNzqeyh+uUyC+aWVt2aVDMDueufq77RiEUiFcoRabsG
        xpprUcveKqM0GwrdrWfHcPM18M7FVxcFvV3ILwlYCg==
X-Google-Smtp-Source: ABdhPJwqoMT/CIUaWZbEIWwrmnbTecRQHVO32kHMSduHILGYZNnlRX73Ps8yCTRl79BcpGMfkvFOdHBDoPFcxVD1oZI=
X-Received: by 2002:aa7:d592:0:b0:410:b9f9:90f2 with SMTP id
 r18-20020aa7d592000000b00410b9f990f2mr3746829edq.327.1645730386590; Thu, 24
 Feb 2022 11:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20220217205227.4098452-1-dlatypov@google.com> <20220217205227.4098452-3-dlatypov@google.com>
 <CABVgOSmayxKsZYi36gbMWxExhE+=ae8PfFA_tbCGogPnwkw0gA@mail.gmail.com>
In-Reply-To: <CABVgOSmayxKsZYi36gbMWxExhE+=ae8PfFA_tbCGogPnwkw0gA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 24 Feb 2022 11:19:35 -0800
Message-ID: <CAGS_qxrUZzFWWDHxWnwj+WyNhT1TQCkwCNd5UJieZyAu79UTpg@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: properly report the used arch for
 --json, or '' if not known
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 23, 2022 at 10:26 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Feb 18, 2022 at 4:52 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Before, kunit.py always printed "arch": "UM" in its json output, but...
> > 1. With `kunit.py parse`, we could be parsing output from anywhere, so
> >     we can't say that.
> > 2. Capitalizing it is probably wrong, as it's `ARCH=um`
> > 3. Commit 87c9c1631788 ("kunit: tool: add support for QEMU") made it so
> >    kunit.py could knowingly run a different arch, yet we'd still always
> >    claim "UM".
> >
> Agreed on all counts!
>
> > This patch addresses all of those. E.g.
> >
> > 1.
> > $ ./tools/testing/kunit/kunit.py parse .kunit/test.log --json | grep -o '"arch.*' | sort -u
> > "arch": "",
> >
> > 2.
> > $ ./tools/testing/kunit/kunit.py run --json | ...
> > "arch": "um",
> >
> > 3.
> > $ ./tools/testing/kunit/kunit.py run --json --arch=x86_64 | ...
> > "arch": "x86_64",
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Looks good, and works well here. One question/comment below, but in general:
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
> >  tools/testing/kunit/kunit.py        | 4 ++--
> >  tools/testing/kunit/kunit_kernel.py | 2 ++
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index 7dd6ed42141f..5ccdafd4d5aa 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -153,7 +153,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
> >                                 test_glob = request.filter_glob.split('.', maxsplit=2)[1]
> >                                 filter_globs = [g + '.'+ test_glob for g in filter_globs]
> >
> > -       metadata = kunit_json.Metadata(build_dir=request.build_dir)
> > +       metadata = kunit_json.Metadata(arch=linux.arch(), build_dir=request.build_dir)
> >
> >         test_counts = kunit_parser.TestCounts()
> >         exec_time = 0.0
> > @@ -506,7 +506,7 @@ def main(argv, linux=None):
> >                         with open(cli_args.file, 'r', errors='backslashreplace') as f:
> >                                 kunit_output = f.read().splitlines()
> >                 # We know nothing about how the result was created!
> > -               metadata = kunit_json.Metadata()
> > +               metadata = kunit_json.Metadata(arch='', build_dir='', def_config='')
>
> Why do we explicitly pass empty strings in here, rather than making
> the defaults correct for this case?

Good point, we should just make '' the defaults now.
I'll move the hard-coding of "kunit_defconfig" out of the defaults and
into exec_tests() then.


>
>
> >                 request = KunitParseRequest(raw_output=cli_args.raw_output,
> >                                             json=cli_args.json)
> >                 result, _ = parse_tests(request, metadata, kunit_output)
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > index fe159e7ff697..bbbe2ffe30b7 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -248,6 +248,8 @@ class LinuxSourceTree(object):
> >                         kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
> >                         self._kconfig.merge_in_entries(kconfig)
> >
> > +       def arch(self) -> str:
> > +               return self._arch
> >
> >         def clean(self) -> bool:
> >                 try:
> > --
> > 2.35.1.473.g83b2b277ed-goog
> >

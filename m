Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC1D66DA19
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 10:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjAQJiC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 04:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbjAQJhf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 04:37:35 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C37B460;
        Tue, 17 Jan 2023 01:35:30 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a1-20020a056830008100b006864df3b1f8so137938oto.3;
        Tue, 17 Jan 2023 01:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hMN1V1ykUi0o/01J/siqwvEPlG+4WljMN85XmMhp+C8=;
        b=bm5AhXZvw6GagCGsfOIKdMDTuj6wYvnwhHWgv0Q8V9/rVLoHpzeoLWLhikzzrqlP9k
         JOWoUF6bOh/m8JemElbPjefg6dEc2YfOmzpT2TLT4wFu75JM3SHATWPFaGwFWbX2I3Lr
         xUKRm+61TKEyhCtE+BaAySjcVE5gz4SAuPv7euH9ltmFgx28iMz/zCKFLpraS+H0MhY4
         nxOWn7Cpwil3vJyYz9JWQ7WUbBK4MI0Xv6SgbxmxdVg3GDcxn5HrM6BVD1CeXc58pjH3
         6t3vUnkyCYaUGOJGYobQ1GDxXmApZ04e+WMmh0XtUBjyq2O5orj91UoRweQDaedeN1HV
         HvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMN1V1ykUi0o/01J/siqwvEPlG+4WljMN85XmMhp+C8=;
        b=xEUaj2vHyo0Y7vhYt/cbd9jBMxEJt8O2LOVu/PcIbjtq4Sv713E4r6O1hbtuEpPpW/
         v4cdYGwmL6X4Uj7kxqo1RUc7yqeiy+qS46N/Tu34qdtx8hYF7SQNp2lBgEOLtcn7s8aO
         yZFNNa6ZlXARYe2PKGn2Sp86BRmGoicPFtH9xB83kSJA9CLVHmmP2OEBRV/Lqt1082Do
         RjMUXS0ywI/leg2nWCO7t/Fuj9JrYdFKfxcjpN5alaqdMs1jG4b9IP+Yc1ks/aBsReRA
         ggXSdbI2L9XR57XGpp3lmdOImbSEEVDzxiZ0gUw9bk1bohADDO+SNOUdE7IId2QlS0Rt
         gcfQ==
X-Gm-Message-State: AFqh2kpph2kL33VTLLuuFUaIgp/50JyaC5c3EQ0+wTZR1/ioDegZ/STW
        8dRLM13O0t5mAOix0Drr4gaoMiVA6owu0NxI4zs=
X-Google-Smtp-Source: AMrXdXtxONnof1ZhFRt2/e47T77z8K3uO/BGIuol7llPScOfeSC1axJLLaZpJW0jS1XQtCR5528pN8sLA+cMgtl9jDw=
X-Received: by 2002:a9d:6c4a:0:b0:684:e846:74db with SMTP id
 g10-20020a9d6c4a000000b00684e84674dbmr132378otq.51.1673948130178; Tue, 17 Jan
 2023 01:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20230115210535.4085-1-apantykhin@gmail.com> <CABVgOSkXpbfLy5-40oqhmdLP9c84S=1FN=f_+Fw768QVUBBQPg@mail.gmail.com>
In-Reply-To: <CABVgOSkXpbfLy5-40oqhmdLP9c84S=1FN=f_+Fw768QVUBBQPg@mail.gmail.com>
From:   Alexander Pantyukhin <apantykhin@gmail.com>
Date:   Tue, 17 Jan 2023 13:35:19 +0400
Message-ID: <CAPi66w-E-WKA3uzE3SGLkp8UYaqz65Py2Yc8UGynhG1s0rtrjQ@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/kunit/kunit.py: remove redundant double check
To:     David Gow <davidgow@google.com>
Cc:     brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, David.
Thank you very much for your review!
There is no v2 yet.

>
> On Mon, 16 Jan 2023 at 05:05, Alexander Pantyukhin <apantykhin@gmail.com> wrote:
> >
> > The build_tests function contained the doulbe checking for not success
> Nit: "double" -> "double"
>
> > result. It is fixed in the current patch. Additional small
> > simplifications of code like useing ternary if were applied (avoid use
> Nit: "useing" -> "using"
> > the same operation by calculation times differ in two places).
> >
> > Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
> > ---
> Thanks for catching these!
> This looks good to me, save for a few typos (which you should fix if
> there's a v2, but it isn't important enough to do another version...)
>
> Unless someone with more Python knowledge than me jumps in and
> complains, this is:
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
> >  tools/testing/kunit/kunit.py | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index 43fbe96318fe..481c213818bd 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -77,10 +77,8 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
> >         config_start = time.time()
> >         success = linux.build_reconfig(request.build_dir, request.make_options)
> >         config_end = time.time()
> > -       if not success:
> > -               return KunitResult(KunitStatus.CONFIG_FAILURE,
> > -                                  config_end - config_start)
> > -       return KunitResult(KunitStatus.SUCCESS,
> > +       status = KunitStatus.SUCCESS if success else KunitStatus.CONFIG_FAILURE
> > +       return KunitResult(status,
> >                            config_end - config_start)
> >
> >  def build_tests(linux: kunit_kernel.LinuxSourceTree,
> > @@ -92,13 +90,8 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
> >                                      request.build_dir,
> >                                      request.make_options)
> >         build_end = time.time()
> > -       if not success:
> > -               return KunitResult(KunitStatus.BUILD_FAILURE,
> > -                                  build_end - build_start)
> > -       if not success:
> > -               return KunitResult(KunitStatus.BUILD_FAILURE,
> > -                                  build_end - build_start)
> > -       return KunitResult(KunitStatus.SUCCESS,
> > +       status = KunitStatus.SUCCESS if success else KunitStatus.BUILD_FAILURE
> > +       return KunitResult(status,
> >                            build_end - build_start)
> >
> >  def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
> > @@ -145,7 +138,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
> >                 tests = _list_tests(linux, request)
> >                 if request.run_isolated == 'test':
> >                         filter_globs = tests
> > -               if request.run_isolated == 'suite':
> > +               elif request.run_isolated == 'suite':
> >                         filter_globs = _suites_from_test_list(tests)
> >                         # Apply the test-part of the user's glob, if present.
> >                         if '.' in request.filter_glob:
> > --
> > 2.25.1
> >

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413334C34CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 19:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiBXSft (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 13:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiBXSft (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 13:35:49 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40D9235854
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 10:35:18 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vz16so6320440ejb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 10:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9SSvC9C1fhpVS0HxdvkSpJYXLmlizLtOraZJYIbjXo=;
        b=XCQHau37fe+uDLXL8QTbMKSWptkeHDz5Mqau81xKeBizrC4B39F6R5u3tMy+f+oIpX
         g78ePrDgFIDbEjSBuNnnX9bykX/IoMaV1Ns4xd4eaw7DCosN4wN1FKDNSCNLJRqywQPZ
         cxFBIj5qY1LzVXxWsB8Y73Hyg+c5t9S6F8jA99rwvuRZBPaHUkGHeTODNVI9tfI2pr3C
         iIbmwjAXy6I/VyQAXOd5KMuRwdeCj9QvUgEhCY79wkhba0UGbPWmkmrkIMcL5eCQ4/Ns
         HKZHVrLhO+00GkdHoCfOqVwPTtxrTPrTervRybZy6WpYhr2ZJ5F8uAewUzNPegZJxHX4
         u9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9SSvC9C1fhpVS0HxdvkSpJYXLmlizLtOraZJYIbjXo=;
        b=MzRGG2d7CHQPSdcyzkCztvHk+gv/X5ei45xO1RD6td9kTrJehEg6EL6fA7YpJQ5iop
         Sm/Ol4NlUdleHnPSdBPmVawmnsCC5lifh3fBjCIA875ZvL5bZ1slAnQvLzDaLBRobzR3
         +t8eXPC/IJwv6M7a28hcBPt1H9O9a4yYx1Evy5dA9Ps+ol+fZnlcnBE7TGk312aTHr6f
         wB03/7KVMMDGm6kJwkDI3YBcuHIW58A1e+8YOhOTyeLpV7vt+AKcLK0IlCpxBqZzGKFi
         bavRlWHqkaSrr3sqAHDrF7app316kE9eZiPLo4EwXuTYxUz8w8JeQIoqicuZJ5/5N24z
         Ik0Q==
X-Gm-Message-State: AOAM530k/cxLZqMewX3gcIiseXOkMjIgjqOetisk6tBwjH0WZYxj2M8c
        J9GW/65YlXufc18w3GEc+NXsoJpZTphBKdNNFzqIaA==
X-Google-Smtp-Source: ABdhPJz59mYPwCSXLz3hUbuQyijBiV73FNZME9JLNFZqQSIKQOJgaKSo1hLogFtUCSi205wQ5GN8pMMCYEbpdhNDSwY=
X-Received: by 2002:a17:906:6a2a:b0:6cf:d228:790c with SMTP id
 qw42-20020a1709066a2a00b006cfd228790cmr3527380ejc.75.1645727717285; Thu, 24
 Feb 2022 10:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20220217205227.4098452-1-dlatypov@google.com> <CABVgOSkVH9aJ4qU34zVXFA0PfDhemdJyYVc=CkGUVJNSZmQnpA@mail.gmail.com>
In-Reply-To: <CABVgOSkVH9aJ4qU34zVXFA0PfDhemdJyYVc=CkGUVJNSZmQnpA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 24 Feb 2022 10:35:05 -0800
Message-ID: <CAGS_qxpccx=E0Nsf-DhZskSFaJ5j4ytRvgOUmKuxyDoyum-qWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: tool: readability tweaks in KernelCI json
 generation logic
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
> > Use a more idiomatic check that a list is non-empty (`if mylist:`) and
> > sinmplify the function body by dedenting and using a dict to map between
>
> Nit: spelling of "simplify". (This is also the first time I've seen

Good catch, fixed.

> "dedenting" as a word, which I thought was a typo for a while, too...)

"outdent" is the more proper word here.
Afaik programmers invented "dedent", e.g.
https://docs.python.org/3/library/textwrap.html#textwrap.dedent

I found "dedent" more obvious and used it enough since that I've
forgotten it's not really a word.

>
> > the kunit TestStatus enum => KernelCI json status string.
> >
> > The dict hopefully makes it less likely to have bugs like commit
> > 9a6bb30a8830 ("kunit: tool: fix --json output for skipped tests").
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
> >
> > Note: this series is based on my earlier set of kunit tool cleanups for
> > 5.18, https://lore.kernel.org/linux-kselftest/20220118190922.1557074-1-dlatypov@google.com/
> >
> > There's no interesting semantic dependency, just some boring merge
> > conflicts, specifically with patch #4 there, https://lore.kernel.org/linux-kselftest/20220118190922.1557074-5-dlatypov@google.com/
> >
> > ---
>
> Looks good to me. While in general, I think I prefer an extra level of
> indentation to using "continue", it doesn't worry me either way here.

It's not really a concern here, but I'm always wary given python has
significant whitespace.
I've seen enough instances of moved code where the indentation wasn't
properly updated.


> The use of a Dict is definitely an improvement.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
>
> -- David
>
> >  tools/testing/kunit/kunit_json.py | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
> > index 24d103049bca..14a480d3308a 100644
> > --- a/tools/testing/kunit/kunit_json.py
> > +++ b/tools/testing/kunit/kunit_json.py
> > @@ -16,24 +16,24 @@ from typing import Any, Dict
> >
> >  JsonObj = Dict[str, Any]
> >
> > +_status_map: Dict[TestStatus, str] = {
> > +       TestStatus.SUCCESS: "PASS",
> > +       TestStatus.SKIPPED: "SKIP",
> > +       TestStatus.TEST_CRASHED: "ERROR",
> > +}
> > +
> >  def _get_group_json(test: Test, def_config: str, build_dir: str) -> JsonObj:
> >         sub_groups = []  # List[JsonObj]
> >         test_cases = []  # List[JsonObj]
> >
> >         for subtest in test.subtests:
> > -               if len(subtest.subtests):
> > +               if subtest.subtests:
> >                         sub_group = _get_group_json(subtest, def_config,
> >                                 build_dir)
> >                         sub_groups.append(sub_group)
> > -               else:
> > -                       test_case = {"name": subtest.name, "status": "FAIL"}
> > -                       if subtest.status == TestStatus.SUCCESS:
> > -                               test_case["status"] = "PASS"
> > -                       elif subtest.status == TestStatus.SKIPPED:
> > -                               test_case["status"] = "SKIP"
> > -                       elif subtest.status == TestStatus.TEST_CRASHED:
> > -                               test_case["status"] = "ERROR"
> > -                       test_cases.append(test_case)
> > +                       continue
> > +               status = _status_map.get(subtest.status, "FAIL")
> > +               test_cases.append({"name": subtest.name, "status": status})
> >
> >         test_group = {
> >                 "name": test.name,
> > --
> > 2.35.1.473.g83b2b277ed-goog
> >

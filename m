Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5723856C46F
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jul 2022 01:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiGHVBH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 17:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbiGHVBF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 17:01:05 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D61128
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 14:01:04 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id u20so93854iob.8
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBRRCtPEnNxgQyJUGv/ZJ77JZZ/1FLrQdGhONhznMbk=;
        b=pmruvDq1xnw+/V9pDHQd617MBdsm7UB+XfjxhoWht6gF0Yo61yPzf064GBhy/1Opyz
         5TSIjQmHJ/7zqiYFexhoTXUL4CKBbRNV6GBEmCGs086p3ldy/j8qOBfteud/uJmKzW3s
         ptezWouRmnPXcWOKjzCQwU0a5YlUTipEXNrvuPx3X/VW4wRi8n/pAlnHBBL72z+5gKrn
         ZspiFBvNHw1zSVNTaAdou1CVXQMQwKlYW71DebClYIUEywUoEzXPDSUOaMEwox5cyKkT
         p50sysjXJY8AKlxu2us8vgtpKSpr6xIgXlIL+fyeLb3K0W/U11hs6EszRhO8jZ1iiDKp
         Oovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBRRCtPEnNxgQyJUGv/ZJ77JZZ/1FLrQdGhONhznMbk=;
        b=EUOxbSfH76pFsdF51w19u0suEcVYolAWZVcqnH4ju7k+jtLb5yEMpcgQSQQAGLQpGv
         3IqABXwOy/NK7BkR9lYcTGHgnQA3Q1bWJY/dqVUOuMtFXNwBV2+SOTh3Pf62E/+6hS8e
         9yapcHTcgZm1ZusJ0tB0Kie3/CU+FUsdXDMLQlq7k6XSE2KLg3uF+QbcSoPsCwCVRC/n
         yPVUCWSt4jvcUp1fEEIpn3Qe5LCPscLayrdsaVy5z28Alu7pSmzrQzNuu0hByqX8tNJE
         4NzoHmwEOMlzk0L+jUbUtFUZzXhftXoV0wgcCu3HT9XaNEreusHXNtHL2tsZMU/436dX
         IXJA==
X-Gm-Message-State: AJIora/RV1l2msGvvbd9dN06P3K1cz7BJe7UZND73rMk3VudltvRp7yL
        UChalEjd80ThuIeFMf8IqYzvRRzhdjleEICvCuq6ojs6gt1+VQ==
X-Google-Smtp-Source: AGRyM1s0rE7jwtOXj9AJ+jtWvZFW7AklSxg2uUHf3cjOqt7Ggjq8z4ONVmZ2p7mcPaKXl+lvX1U+JmQsQCyT8D8LWr4=
X-Received: by 2002:a05:6602:2e8d:b0:64f:b683:c70d with SMTP id
 m13-20020a0566022e8d00b0064fb683c70dmr2919156iow.62.1657314063709; Fri, 08
 Jul 2022 14:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220708044847.531566-1-davidgow@google.com> <20220708044847.531566-3-davidgow@google.com>
 <fc638852-ac9a-abab-8fdb-01b685cdec96@linuxfoundation.org>
In-Reply-To: <fc638852-ac9a-abab-8fdb-01b685cdec96@linuxfoundation.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 8 Jul 2022 14:00:51 -0700
Message-ID: <CAGS_qxpODhSEs_sMm5Gu55EsYy-M9V98eLU-8O+xGMxncXmY4A@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] kunit: Taint the kernel when KUnit tests are run
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>
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

On Fri, Jul 8, 2022 at 1:22 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 7/7/22 10:48 PM, David Gow wrote:
> > Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
> > Due to KUnit tests not being intended to run on production systems, and
> > potentially causing problems (or security issues like leaking kernel
> > addresses), the kernel's state should not be considered safe for
> > production use after KUnit tests are run.
> >
> > This both marks KUnit modules as test modules using MODULE_INFO() and
> > manually taints the kernel when tests are run (which catches builtin
> > tests).
> >
> > Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> > Tested-by: Daniel Latypov <dlatypov@google.com>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > No changes since v5:
> > https://lore.kernel.org/linux-kselftest/20220702040959.3232874-3-davidgow@google.com/
> >
> > No changes since v4:
> > https://lore.kernel.org/linux-kselftest/20220701084744.3002019-3-davidgow@google.com/
> >
>
> David, Brendan, Andrew,
>
> Just confirming the status of these patches. I applied v4 1/3 and v4 3/4
> to linux-kselftest kunit for 5.20-rc1.
> I am seeing v5 and v6 now. Andrew applied v5 looks like. Would you like
> me to drop the two I applied? Do we have to refresh with v6?

Just noting here that there'll be a merge conflict between this patch
(3/4) and some other patches lined up to go through the kunit tree:
https://patchwork.kernel.org/project/linux-kselftest/patch/20220625050838.1618469-2-davidgow@google.com/

Not sure how we want to handle that.

Daniel

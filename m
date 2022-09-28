Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818EA5ED41C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 07:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiI1FHl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 01:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI1FHj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 01:07:39 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711E411ADD4
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 22:07:38 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id e3so4279860uax.4
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 22:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ErZDse3sguqUpUw6XzgHpiTQQNzhuXNPkKhtVfnhZzQ=;
        b=cJoCqi7OhhrFteCkAl3QOi+diI9ocxp4BGJryNt+NU+k5kWgt0od7HFzIO4aQXkyM5
         par1fQjmM6sZfZFG5ZyJdpOLD2gcEnIa81XbuYjTodPjgmmqRnzXGmApyQZFDpopJbiw
         g5G5sukzgqfnZziXnJiWlUQJiLP2Rsfw3+n1jo9Ufc0qI1A4TReCP40CEULmJiqSiJiX
         HEUVK3h9z08aLeb+jSQu1IZbjNJMGn20+sdscz/m9QnyWiEYGYfP21G4pK/m2zOPzNQV
         RdG4DEHaZJzT8Vl1EYlhNOfaL7ASzerbUmZk6Rzk1ydP+Qn9aUyZP32m90rhKCnePZDL
         7tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ErZDse3sguqUpUw6XzgHpiTQQNzhuXNPkKhtVfnhZzQ=;
        b=hL22/c4QvRqS+Ir+pXK2fElobQxedC6AZmis7ExxvPpERwIazx3nzMQ2NGIcpZ1jfz
         hBBRkR93e6b4GSl+ib6giTBZS1mBSjIiOCu1VHFb8Ego2EkktARHGEYohFim8s9UiQJM
         HfyYLMPo21dao86cWXY1WU/fH8FPBp1rker8P7aijzz6cXRwAYURTmcB5MM1VrL3AAcJ
         llV+h0L0rLlppAjBM++BQK+AYqrcIdW7bYo4zNQwNI3CRazX+Sk/mrbOgaUfnoit1+gj
         OwhmITRrSgZ8+tSt0rEX6ZAh7/12NR03pcUay/QG3MaZG+RX5r1lC4+c6DVdDv8kvOkb
         +adw==
X-Gm-Message-State: ACrzQf1fRlkzxXhkSXyHCuLaNohFEMjlpxAMnZ3R50kqwDZVhxhplI/5
        bxe9fblX+77tjnzh7Yo9D2yWI+0Q2XcaNiIyN7UFnQ==
X-Google-Smtp-Source: AMsMyM6yixgpzCvngqJxON6nnQhrKkEWCafoj3zuW5xGZVvP6vf4PkG32geboQC2adDTJPLNE12e1T2OoI/GhlTx8Nc=
X-Received: by 2002:ab0:7412:0:b0:3d1:c2f7:3250 with SMTP id
 r18-20020ab07412000000b003d1c2f73250mr2949564uap.21.1664341657124; Tue, 27
 Sep 2022 22:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220928040058.37422-1-khalid.masum.92@gmail.com>
In-Reply-To: <20220928040058.37422-1-khalid.masum.92@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 28 Sep 2022 13:07:26 +0800
Message-ID: <CABVgOSmiO9f6DdXCfg91714WBJkJ4Cdm5FewCtscxMa_Cv+8Bw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Kunit: Use full path to .kunitconfig
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+CC Sadiya

On Wed, Sep 28, 2022 at 12:01 PM Khalid Masum <khalid.masum.92@gmail.com> wrote:
>
> The numbered list contains full path to every files that need to be
> modified or created in order to implement misc-example kunit test.
> Except for .kunitconfig. Which might make a newcommer confused about

Nit: Spelling of "newcomer".

(I wouldn't bother sending out a new version just for this typo in the
commit description. If you need to do another version for another
reason, though, please fix it then.)

> where the file exists. Since there are multiple .kunitconfig files.
>
> Fix this by using the full path to .kunitconfig.
>
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---

Thanks very much for your patch. This seems sensible to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/kunit/start.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index 867a4bba6bf6..69361065cda6 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -217,7 +217,7 @@ Now we are ready to write the test cases.
>
>         obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
>
> -4. Add the following lines to ``.kunitconfig``:
> +4. Add the following lines to ``.kunit/.kunitconfig``:
>
>  .. code-block:: none
>
> --
> 2.37.3
>

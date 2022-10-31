Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE984613B70
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Oct 2022 17:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiJaQhW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Oct 2022 12:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiJaQhU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Oct 2022 12:37:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40FD11C2F
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Oct 2022 09:37:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t25so30843762ejb.8
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Oct 2022 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OGDQThFOxauPDUbKkMnQ1WVxEo1L149BaHAo2/PIs94=;
        b=jP/GNUvQTENsDaBdHVAlI7AfG4mal0HOq2Y3LVR3qDTk5EdDcfBxL/qwz1YXQUf7X5
         NlH2gXW5xMoQqPWzBv6wKq+e3OGCGycAAkDhRY1gCDolIbKfCTCuNrThCN2oBFe5xyQG
         OrFtT/5IBJiXBJKa01ZM2aUY7zfzE2pDz735px5sgA63NLS63B1+k+0m9i64ukpraY7h
         jAxnODFQfVTrGEhvjISrbbWtE+RaHV6/0KbB5wTfU/GTlfgral0Y0oQjKZv6r9Ig2Cxx
         sQTx2cwfcA4KBZbxsnwo9mw1oDRweYJMvS0WKLB4v7b0v5cC3g1YMhtca4bozPNbeoE3
         gaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGDQThFOxauPDUbKkMnQ1WVxEo1L149BaHAo2/PIs94=;
        b=Oh0Hu8+IHLkJpsGQ4sZoatOQlJKeZGqN7OMHMv4gc0GAtaRsIqpuzzbTp+ywJB+GfV
         hYbZAd2CxohAUpuyrxhZBHxxd6GC1fifqz8QTijVOOZ0oOZcJHEiCyu+cPCrxzBRTosW
         vOx9QdlQNNDdOMpLYwhl86Sz/qH8q7DzM/tj0/1raWr/hQeI8iM7APCQ5Dbrs79A9MEg
         d8GQqNM2fDnVsg2x/mVCHXalUkYF0OxPvtUCSFHovaPdMjY8I/zPXSUuieaFS07yLqOJ
         v60obyHqAedOpRDpJ3uLSKEDf4tBVEG7JASYWqBteQ+x3z1QTbVI7+xRmorGh698Zj/F
         KS1A==
X-Gm-Message-State: ACrzQf14pDglqFTfGKAzwYXwLholu7nQaLRAZEBFY4oF0S+WdtSkx/pp
        DeT5ENZthmov7JZQkZZ5mSb4MbQkMgK6/4/6EejeuQ==
X-Google-Smtp-Source: AMsMyM734FMFQBz6kY12hhzgcNd2bLkfehsbGWPgKwUgXJztlzYXlNFwg3IovBEtfdf5nF/ppcqBfhXtOgTYIoSKgdY=
X-Received: by 2002:a17:907:86a0:b0:78d:df8b:4d17 with SMTP id
 qa32-20020a17090786a000b0078ddf8b4d17mr13518713ejc.254.1667234238076; Mon, 31
 Oct 2022 09:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221028210256.3776835-1-dlatypov@google.com> <CABVgOS=uAVc_nKRFYRiQtWFykyfWH6hWASK-yd+ZnH5UNmRgsw@mail.gmail.com>
In-Reply-To: <CABVgOS=uAVc_nKRFYRiQtWFykyfWH6hWASK-yd+ZnH5UNmRgsw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 31 Oct 2022 09:37:06 -0700
Message-ID: <CAGS_qxpghJUj+R74SFPjq=VDoNdVp7Wq2b+AcWwmHHeCQVjmPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: make unit test not print parsed testdata
 to stdout
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 29, 2022 at 8:31 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, Oct 29, 2022 at 5:03 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Currently, if you run
> > $ ./tools/testing/kunit/kunit_tool_test.py
> > you'll see a lot of output from the parser as we feed it testdata.
> >
> > This makes the output hard to read and fairly confusing, esp. since our
> > testdata includes example failures, which get printed out in red.
> >
> > Silence that output so real failures are easier to see.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Thanks -- this has been annoying me for ages.
>
> That being said, this isn't a perfect fix, the "usage" text and
> "Reconfiguring .config"  still show up for me:
> ---
> davidgow@slicestar:~/Development/linux-kselftest$
> ./tools/testing/kunit/kunit_tool_test.py
> ..............................usage: kunit_tool_test.py run [-h]
> [--build_dir DIR] [--make_options X=Y] [--alltests] [--kunitconfig
> PATHS] [--kconfig_add CONFIG_X=Y] [--arch ARCH] [--cross_compile
> PREFIX] [--qemu_config FILE] [--qemu_ar
> gs] [--jobs N]
>                              [--timeout SECONDS] [--kernel_args]
> [--run_isolated {suite,test}] [--raw_output [{all,kunit}]] [--json
> [FILE]]
>                              [filter_glob]
> kunit_tool_test.py run: error: argument --raw_output: invalid choice:
> 'invalid' (choose from 'all', 'kunit')
> ..............................Generating .config ...
> .Regenerating .config ...
> .........
> ----------------------------------------------------------------------
> Ran 70 tests in 0.232s
>
> OK
> ---
>
> That's still a significant improvement on what we had before, though, so:

Yeah, I was originally going to make this patch silence all the output.
But I figured I would focus this patch on just the code using our
kunit_printer abstraction, aka the parser.

We could address the other ones, but we'd have to mock out the
built-in print function.
As someone who is guilty of print(f) debugging, doing that means I no
longer have an easy of way of adding debugging code to those test
cases :P

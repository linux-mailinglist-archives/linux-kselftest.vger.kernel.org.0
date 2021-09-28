Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7992441B933
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Sep 2021 23:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242858AbhI1VZx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbhI1VZx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 17:25:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC01C06161C
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 14:24:13 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k26so121340pfi.5
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iM4pRgNZ7+u3rQF1Y6mNv4StWWH7/Lvkhw7q9nmBAIE=;
        b=tISFMbx4wRTKoHHIdf+2f1oknHkd9cJB1UezeCwBS5RwEqH8qC4P4aZW9RZNBSfR/r
         pIj4MnP49RRINLbjVzrbmp1iR03kY4Esdl534kU00ikkr4LK3l+luYhWLrjO78aSvtIG
         9NSkytaCpaDsN9lkLkefyKNTGFIUGXoOsrNEMdLntAQNOp7XF3I/V6N2cvLzsVSeEQVM
         f2HHIVvG3rMficI+XnzYqlyT0v45ObGkxfDmie3TWmMpeFlaENDqB/LfWC5fu/FPpcOx
         0LjQJ2NKd2BHbzK69sFz3c9fCJO///0jC270ZD8Fc1eZ+AhT96B/M9rDkGDUFPmB4vfA
         gkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iM4pRgNZ7+u3rQF1Y6mNv4StWWH7/Lvkhw7q9nmBAIE=;
        b=mSIOu2dWYBgGplGXQs52wMfWj2/cv/MTfpAJxuEtnteWEWtDEHbWxeT9HY7C6CdgCc
         MDjZt8vM2huWvaDhxWiY6TZMQK/Yy5diYTsIASlKv/Gn/HHj7OIaEQN4Owu2PkV7bKar
         c03YWtNfUvhHKkPoJKEEI6anI6TiYMQzhG1+9GjPO28cLS2DlqXcaGou8LRuyjYpqy3N
         V6nbOLEWMYnmMeF+kSdI8WwN3znolFrQ1DnW88SqQOl8FkJgtni/T0Gq3MMyRcpRihhs
         nJEyiUH99rMYjPJCVKKomOnCElWY7SsmxMS/8EOSGUfpvlRUyO6py5VKNfXjzhyh2HBq
         DoBA==
X-Gm-Message-State: AOAM533umaGDYkywaT05lIr/h6/IAchCTf3yuHocqO8mTNvhm1Z7Wbts
        URwpQ1bIq7xSjofYefHM/x14YPLE0P1QiKFdTzTn6w==
X-Google-Smtp-Source: ABdhPJxlbU/8uPaV2wNhTTkGyrMRCCgZ0WJYow/SYVtv5tzwQqLytM+9MRt6GDZE6lwt2Tc+LAZY8JV3UXyh/aT/ruU=
X-Received: by 2002:a63:790b:: with SMTP id u11mr6422184pgc.71.1632864252807;
 Tue, 28 Sep 2021 14:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210922163921.2462565-1-dlatypov@google.com>
In-Reply-To: <20210922163921.2462565-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 28 Sep 2021 14:24:01 -0700
Message-ID: <CAFd5g44441Qv0tzSbRdz1nOcZLEuSVdHRh71SjbpLN=c44+gnw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: better handling of quasi-bool args
 (--json, --raw_output)
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 22, 2021 at 9:39 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Problem:
>
> What does this do?
> $ kunit.py run --json
> Well, it runs all the tests and prints test results out as JSON.
>
> And next is
> $ kunit.py run my-test-suite --json
> This runs just `my-test-suite` and prints results out as JSON.
>
> But what about?
> $ kunit.py run --json my-test-suite
> This runs all the tests and stores the json results in a "my-test-suite"
> file.
>
> Why:
> --json, and now --raw_output are actually string flags. They just have a
> default value. --json in particular takes the name of an output file.
>
> It was intended that you'd do
> $ kunit.py run --json=my_output_file my-test-suite
> if you ever wanted to specify the value.
>
> Workaround:
> It doesn't seem like there's a way to make
> https://docs.python.org/3/library/argparse.html only accept arg values
> after a '='.
>
> I believe that `--json` should "just work" regardless of where it is.
> So this patch automatically rewrites a bare `--json` to `--json=stdout`.
>
> That makes the examples above work the same way.
> Add a regression test that can catch this for --raw_output.
>
> Fixes: 6a499c9c42d0 ("kunit: tool: make --raw_output support only showing kunit output")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

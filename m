Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F64A3A4A1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 22:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFKU3S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 16:29:18 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:44988 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhFKU3S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 16:29:18 -0400
Received: by mail-pg1-f182.google.com with SMTP id y11so3337555pgp.11
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jun 2021 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLhmhHYRPO5l9zgQx7lROFz0cEU6ynaEXV/+WtT2CNs=;
        b=frEwhe7gHg5gVcBJCPK3ZddVU2cjwZvDRKE8MH1ZPO+262DJ5fGPZr5Ipij97rOQXB
         L9a/ZGeE7hdnmlidcVhcjvu/admFWK21zBL7q5o62E4X4rDfX+eiUGh9bBe6tQ5JyH1z
         F5MptC/894qiHceVceNGBteqWY4cfGUvMBSVrPSvM3xtjR9sZWj9HaeacyL4125UGxh2
         hS731w+CvNupEqs64CopfRwZAjy85eY5v9S83hFLEBZ4R/Ayhzeq4LU8I4LHdw9ml2iT
         FgLVt4k+CFxMxSpDv/66+DaXiz4Wf2Op8lTwSP2LWNCPNoKHRsWxvfyUYEH/hDPg9o5a
         fUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLhmhHYRPO5l9zgQx7lROFz0cEU6ynaEXV/+WtT2CNs=;
        b=cSLBFr5JFOvJR1byP+Iiqs13wy/LcMY9TNWC/gzWDzL4o1vHxrtlZ+pvxx99cB/cHg
         IK0UPYS4DQfExKtT/TR9dfccPiaJt+5iIzfhmI8s8esklN6B2l+On7YBg/OY4BEbTchw
         58lwEGmar6WoHYv4JLLSZK5UV7+nhln5LlsajOSQ5PROOaV4JOcyQPZvbC4DC4Igdyeb
         qbilwMID7ebpBhIjHqh4dX2g/U2YhTSohCDS+L138tE42D+EMy5K5sm6Lq7InyhaMWtL
         4CdA5hgDYQXjKt9g+BDk0T3EYFof8MwDbdDrwAKwPnaduoYtdzxNDGVafxCk29FXfniB
         oW6A==
X-Gm-Message-State: AOAM532+saq/oNSnRVIqbWn8wZasSnNw+e26xZtkyqYVWxVed7D7Zf+C
        HEsQXgcFlaEZWzz4K940b23r/4eToM+c4rzxzr0GqQ==
X-Google-Smtp-Source: ABdhPJykJ5K00yYq8LzrZ9TkTjsxAkvB/PffxwTvqeGtsGu/Jo7zgcg9gtZ0Ocfn2WpyJvZxWb96lv7bN1UsXOdojXc=
X-Received: by 2002:a63:485a:: with SMTP id x26mr5351534pgk.159.1623443179362;
 Fri, 11 Jun 2021 13:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210611035725.1248874-1-davidgow@google.com>
In-Reply-To: <20210611035725.1248874-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 11 Jun 2021 13:26:08 -0700
Message-ID: <CAFd5g44hC9XM2EcphwTNF5Vcz6v3kZg-ZFJwyj610ty6688OSQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix result propagation for parameterised tests
To:     David Gow <davidgow@google.com>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 10, 2021 at 8:57 PM David Gow <davidgow@google.com> wrote:
>
> When one parameter of a parameterised test failed, its failure would be
> propagated to the overall test, but not to the suite result (unless it
> was the last parameter).
>
> This is because test_case->success was being reset to the test->success
> result after each parameter was used, so a failing test's result would
> be overwritten by a non-failing result. The overall test result was
> handled in a third variable, test_result, but this was disacarded after
> the status line was printed.

nit: s/disacarded/discarded/g

> Instead, just propagate the result after each parameter run.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Fixes: fadb08e7c750 ("kunit: Support for Parameterized Testing")

I tried to reproduce the problem described and was unable to. Anyway,
from the code it definitely looks like there is a bug like you
describe. And it definitely looks like your change should fix it.

Anyway, I tried testing your fix, but given I was unable to reproduce
the failure, I am not super confident in my testing. Still,

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

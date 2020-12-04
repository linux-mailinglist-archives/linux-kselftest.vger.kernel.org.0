Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606372CE7D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Dec 2020 06:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgLDFvX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Dec 2020 00:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgLDFvX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Dec 2020 00:51:23 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191B1C061A52
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Dec 2020 21:50:43 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id j10so5247589lja.5
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Dec 2020 21:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3j/7oE9+JOlE89/YBfJ2ECQfaC6VbEGbVg+m1NXIJs=;
        b=Ldln55MNFQfErM/Bp4Hi49SZCwoWmfd1s1VeRcYfQrf6yOiblaO9XnQABNqhP644hR
         y+97gHZBBo21ySBAXVSvOf9kUjcO/5koBKnZjQBeROKRt+TWXWz3Sxq+wqm5SceV2uFu
         br59gVl72g8B3WTFz2E4M4/koMzWf0BMxWWEJI0rsASWlj1pTbDvZw0vILnPfr5660nz
         X8E/z2ViIkInn4np9p/IH8i6Ylba/yvZ3ONwuQPfs312Z7pruHTEMH4p/Y8LXQ1FhLsp
         9Pe+4QWDi+sORQG2E4PwYlkVEtuYCVUY25r1jIYUAd3CVscfOKKKE96/as2XDKaY0u6A
         cBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3j/7oE9+JOlE89/YBfJ2ECQfaC6VbEGbVg+m1NXIJs=;
        b=DPp0bXF0q5AfpRcRQETRAuyXdzh5fVriuPKkdjjjvkNIE8mkIVskdaI/OWd4OLE5DI
         aGOB9Pf4DZxmM+9jMzlk7W5Wrb7lIM8MDLyqPwORPeHyjH6em3M/FhXij2EeRdXAhz/w
         YU2zmbS0A6Hdh4tM67BoDzBOtUUApU5FzEzRZUTf655Uklq46cUn11tAI4bGnTw5D5Sf
         NF/eCMvkeU4V2urA1+OGQMRTLXHGXLIO+iRGrk6pDCfrnA3+okSJSyL1gdXZIFCvTY7m
         R7XdPMe6p2Yum93ppUjX0Zy3Cdx+3pMxmBm1Q0D5cR8U82HYOMDfq25lohDrayc2pNHT
         locg==
X-Gm-Message-State: AOAM532kJPRBKZubM8YY8bpT1G5Je0qacDCL6lPOzj/jKCu5oAikSbg/
        UlKtQdDCkInDMI+aPZtwkVZ/ajAbsoDGj5ZXhhQiag==
X-Google-Smtp-Source: ABdhPJyTYElB8m+iVCNjXhTQUpx6v3zANBhXI3KTnkASPyhIIsxdKHnTEKgKRvDnys5wimGjGXLk6FyQ+v6j3h1D3c8=
X-Received: by 2002:a2e:b54b:: with SMTP id a11mr2792067ljn.40.1607061041265;
 Thu, 03 Dec 2020 21:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20201203194127.1813731-1-dlatypov@google.com>
In-Reply-To: <20201203194127.1813731-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 4 Dec 2020 13:50:29 +0800
Message-ID: <CABVgOSmPFYYrjU5KHgKftU1P2CcCTM_HvxJr2YRzKfuaZWjxSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: tool: surface and address more typing issues
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 4, 2020 at 3:41 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The authors of this tool were more familiar with a different
> type-checker, https://github.com/google/pytype.
>
> That's open source, but mypy seems more prevalent (and runs faster).
> And unlike pytype, mypy doesn't try to infer types so it doesn't check
> unanotated functions.
>
> So annotate ~all functions in kunit tool to increase type-checking
> coverage.
> Note: per https://www.python.org/dev/peps/pep-0484/, `__init__()` should
> be annotated as `-> None`.
>
> Doing so makes mypy discover a number of new violations.
> Exclude main() since we reuse `request` for the different types of
> requests, which mypy isn't happy about.
>
> This commit fixes all but one error, where `TestSuite.status` might be
> None.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This looks good to me: I gave it some quick testing, and reading
through it, all of the changes seem sensible.

I wasn't able to get pytype running here, but mypy worked fine.

Reviewed-by: David Gow <davidgow@google.com>

-- David

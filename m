Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF3424543
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 19:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbhJFRxW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 13:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239156AbhJFRvf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 13:51:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5687C061755
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 10:49:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so4980037pjc.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSEO6SLg5H8RZkrrLoY0SelFJ1hO+5cBI62v/ESgIpU=;
        b=SgTxqXJ69J1MJNL9dE5pwTzyaW+HG95CnUbz0sCChkCzI/3pCMzDmlt1R3ikUwU9ek
         i5pvVifXQSrUMLvTj7wjhJm2j8cISbu3VNaOsWcK4FkJhT/4Sm8bLN6eHDQ1fspYiPDE
         u5mjkIqkyiiY+jGBPZH+e76/XMkVvHAA8xNLsraCR483BikE82I9agpzmEqeVAi6r+Vp
         3IXpx/ox0jwEEufY9WYLZ9KAgP/oHCxquHMZu64AoDV3sZhIvHYnqxXz7N0Lj5RCvvTY
         5yAJZkKbLfB5tcBV45exAAZCBdoASiDtL0RpfsuBhSIVtpOp2YZu/bfoTDekSVjXmxsb
         56Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSEO6SLg5H8RZkrrLoY0SelFJ1hO+5cBI62v/ESgIpU=;
        b=IsDU/uR/A+G/T5uV/W6EUietF4TSUgHCUUlUmoMysZRjbTNID9irpz20T9GcdlLo92
         HwQZIhgLv3TnB5MGtv2potF+VapYBgVH4ctkNX4bJ8QIzfkMs716PqxT+nDJrfCzJpxw
         ieFRz2Yl2FTQosz8HFthXOCsS8PjYuhA7OY0dEmtm8QN3wtfhzdEgI+8EIO4YhNO3x89
         7cDoPy+ESN9t4g6gaAwoyv2Mrj3poxIUBegeodBACoQgPuN4d/WRsJpOI0SkhaWFE2Vo
         2t9VOwu5vjo89py2yGPYjJpPGli2g3ArYNC7U5Nnz6cD7Q+IfqhfcK2gjlzZbRCB402H
         Dn/g==
X-Gm-Message-State: AOAM533kR1azj8sObD71MHQkGgTXg9e7vdYM63DDF4Lol2rMxxOyoUrJ
        +V02tA0hkQwR7LIn6AkcFBYwCW+ZJBIaNFXBl2e/7w==
X-Google-Smtp-Source: ABdhPJyNWMvwSzWU+KRjwbIpNloablcFluidmdSC6ypItnUMNKelanRCRJ7nAwDZXakZnQJ9XTDJ6o2UH9KE3nr410I=
X-Received: by 2002:a17:902:6f17:b0:139:eec4:867e with SMTP id
 w23-20020a1709026f1700b00139eec4867emr12228038plk.77.1633542581985; Wed, 06
 Oct 2021 10:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211005011340.2826268-1-dlatypov@google.com>
In-Reply-To: <20211005011340.2826268-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Oct 2021 10:49:30 -0700
Message-ID: <CAFd5g445HFVd0e=r7y3JELCPkD=_T7QUq2K0BgKEeyG2Hi2qgw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: yield output from run_kernel in real time
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 4, 2021 at 6:13 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, `run_kernel()` dumps all the kernel output to a file
> (.kunit/test.log) and then opens the file and yields it to callers.
> This made it easier to respect the requested timeout, if any.
>
> But it means that we can't yield the results in real time, either to the
> parser or to stdout (if --raw_output is set).
>
> This change spins up a background thread to enforce the timeout, which
> allows us to yield the kernel output in real time, while also copying it
> to the .kunit/test.log file.
> It's also careful to ensure that the .kunit/test.log file is complete,
> even in the kunit_parser throws an exception/otherwise doesn't consume
> every line, see the new `finally` block and unit test.
>
> For example:
>
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --raw_output
> <configure + build steps>
> ...
> <can now see output from QEMU in real time>
>
> This does not currently have a visible effect when --raw_output is not
> passed, as kunit_parser.py currently only outputs everything at the end.
> But that could change, and this patch is a necessary step towards
> showing parsed test results in real time.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Awesome! Thanks for finally fixing this!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6953CA1FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jul 2021 18:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhGOQMd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jul 2021 12:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhGOQMd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jul 2021 12:12:33 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A92C06175F
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jul 2021 09:09:40 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id v26so7077682iom.11
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jul 2021 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QAfALqs51WvThC5Hz7W9r8szif6l/jmmKFnr+uD8jrY=;
        b=bBIe3Tnv4rMT9xetAaOr9rGjv5VSSCeKssmFD1rCDDsH31qhlwLDrv1ThRHNLdkaN0
         0HflA1YmprSlqcD2TWBPdhYq65rw+oeRg1Z2KzX4N/bTnc5AdQIFPkoLAwtFalfYv6Ij
         HPb5Ye8CKZPD7VpK4bi5JyC0CTq0FGMkQppdpN9TtGu5PgNZXTJDQrU+nSNc3TLop1pa
         UHreTFguEhpKAxHeNggVfhnb2VmD3HTxdfikhuN2u9W1vlv7Btn0iegwUvz7M5QLDHm0
         4OO/8R3jdPmz+izbhVbOsoGGxlEZludONqhUUvbBg0482ucyGIioA2oU06iiOPuacKMo
         BvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QAfALqs51WvThC5Hz7W9r8szif6l/jmmKFnr+uD8jrY=;
        b=XgP0eDnXceiFtqjTJ930awqD5oRtVHScAqoDKax5mzC7YG4eHzJuu5GUqfMyTuVYH4
         CaVPwEoBhsqwrCK1hgjyFbMa6xjZ3TzHHe1TwB12L3A9yNDTHQ95vGxwKfv1f2ZERnMy
         j8ys4ZL6Yi8ydkURMwuWebp3nFUmCCfYcnTdLMNlPpSAaXYhrqUInrjC3mzZImTgFoDf
         NHlvgYZiXQaAXa9i6Te5FcexuWH7Wuq/rgI5w1TsaFaoowkQEANGbci/xZJaBEX0i7Ck
         5yvsvp9AqT5GRkyuhMSIecz/d9L2qAI73Ym2fV8hjGdha6E5Hmo6rfvsvScF7zNTzLnR
         hWpA==
X-Gm-Message-State: AOAM530B2NFbMHexROOoXP9KSVpLjExIjuR/QEHD6/ZqD5Yqwo5Dto9G
        pGnEzUgF1oAbkHXxaEL2ohjpSqsbLLLmf8A7k2tIug==
X-Google-Smtp-Source: ABdhPJy1eLNmmf94QFLMJGGSva19cd6SJrv459Q6Itvj+7XMru5j7nO+Btog11fdlbx6MX8awXjgJxAyi61dm0Bpv0M=
X-Received: by 2002:a05:6602:3342:: with SMTP id c2mr3586974ioz.126.1626365379421;
 Thu, 15 Jul 2021 09:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210714231506.886386-1-dlatypov@google.com> <CABVgOS=b6+KXp8LP5tAoaFev6yDX4gjrD1i9vBv58Y7JkO_E1A@mail.gmail.com>
In-Reply-To: <CABVgOS=b6+KXp8LP5tAoaFev6yDX4gjrD1i9vBv58Y7JkO_E1A@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 15 Jul 2021 09:09:27 -0700
Message-ID: <CAGS_qxrrC0S+jE=RW2WeTq3jgw-STnFFb8cG=gyE2Nj+2MxDLg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: add --kernel_args to allow setting module params
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 14, 2021 at 11:14 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Jul 15, 2021 at 7:15 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > kunit.py currently does not make it possible for users to specify module
> > parameters (/kernel arguments more generally) unless one directly tweaks
> > the kunit.py code itself.
> >
> > This hasn't mattered much so far, but this would make it easier to port
> > existing tests that expose module parameters over to KUnit and/or let
> > current KUnit tests take advantage of them.
> >
> > Tested using an kunit internal parameter:
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit \
> >     --kernel_args=kunit.filter_glob=kunit_status
> > ...
> > Testing complete. 2 tests run. 0 failed. 0 crashed. 0 skipped.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
>
> Thanks! This is probably overdue: while I still think we want to avoid
> this being necessary for most uses, it definitely was a gap in
> kunit_tool functionality.
>
> I tested this and it worked fine, but did cause several of the
> kunit_tool_tests to fail, largely due to there being changes to the
> arguments of run_kernel(). Those should just require the associated
> tests to be updated.

Oops, completely forgot about kunit_tool_test.py. Sent out a v3.
I also went and added a test case to make sure the flag can be
repeated and gets plumbed through properly.

>
> -- David

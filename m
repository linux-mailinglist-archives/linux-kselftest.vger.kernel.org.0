Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5299C4272EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Oct 2021 23:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbhJHVRd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Oct 2021 17:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhJHVRd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Oct 2021 17:17:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46C2C061570
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Oct 2021 14:15:37 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 75so4273688pga.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Oct 2021 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJ2hSEQ+j+jRG03QYHkbXI7vei0EPm7JoU1IqV+QS5I=;
        b=BGZYWRGb5LbKNUD6vjOnXGkDRKoHoLWaJ9B0EwOvYcgr5rEgBFHVE9yzeE8YP1YGH/
         99iWMQw2OhOpehvcXBi8+w5pp1s6x49QMgpq9q6pubtnT8ltJYRA7NvDETpVQwyZ6vvo
         MFJ2jVO6xiPZKjPv/za3/I7ej392xWgJzSDkAtWnsAlh0GQCXRChvtb4m/URdzINMkJU
         qoxM3nkC9Eaefjj4+GM9vE3DCDzOYStuzdb+KfH1dCRq31KUxwD0z2gjZ8kH0F1hE4uC
         EwrGH/E9grcVt+LBUpMDCEcfbrhzncZFgx+MSSyIBDlds1mYl7qObx8rwK8bpWtaueMF
         vt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJ2hSEQ+j+jRG03QYHkbXI7vei0EPm7JoU1IqV+QS5I=;
        b=qjLgHayPPSz8jdp5J3CL85vFL0D7I7vLtFNofvG9yepex5WfsbIrGcOJp7u8n33rKv
         Zau6+g3I4ke32ijauhpKVtFodEuCDFvBO3RET/GpNud9pHQ7gdYTMMc3yp6P1eBpM+Gf
         EAx77yonWMo5SmFw7YYdgCesoPYr7xwlwk763YR2ETXld+DaX4fn+7ro+yA2tIF9bL0U
         EHBO5zsXCgw19wypbydFDnS/UTj7U3+HZEG1QhwOJWfg04gKKMKAeju1Zf7CxmT7hfUy
         LN6ATKmKhnNUKmPsf4ua+oPjp1DG/sLYAfuiu+ArTfGzy9UvoZqa9U1Qftp7GCmAX0f7
         hiqA==
X-Gm-Message-State: AOAM532ea29xGOfE53qTISWUrnyJBIFbe6wrvPIiPotKSIS4j+/Gwd68
        xVmqznEgVV823Y86jij6/sX9q6c7kjrdCUPI+Oeqpw==
X-Google-Smtp-Source: ABdhPJxoEdPnBnrW3+X0IAUo8fqIKq319rc73TVhJTDcqnnBnqWkFEIlemT2Vy3YyFSYLB9RjEKfw0tqBSe0aAvOq0I=
X-Received: by 2002:a63:790b:: with SMTP id u11mr6432381pgc.71.1633727736965;
 Fri, 08 Oct 2021 14:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211008210752.1109785-1-dlatypov@google.com>
In-Reply-To: <20211008210752.1109785-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 8 Oct 2021 14:15:25 -0700
Message-ID: <CAFd5g45oQ-=Q8_yynwAqdWQoS=O3zYpCkQQfS88L3vBZORa31Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: continue past invalid utf-8 output
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 8, 2021 at 2:08 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> kunit.py currently crashes and fails to parse kernel output if it's not
> fully valid utf-8.
>
> This can come from memory corruption or or just inadvertently printing
> out binary data as strings.
>
> E.g. adding this line into a kunit test
>   pr_info("\x80")
> will cause this exception
>   UnicodeDecodeError: 'utf-8' codec can't decode byte 0x80 in position 1961: invalid start byte
>
> We can tell Python how to handle errors, see
> https://docs.python.org/3/library/codecs.html#error-handlers
>
> Unfortunately, it doesn't seem like there's a way to specify this in
> just one location, so we need to repeat ourselves quite a bit.
>
> Specify `errors='backslashreplace'` so we instead:
> * print out the offending byte as '\x80'
> * try and continue parsing the output.
>   * as long as the TAP lines themselves are valid, we're fine.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Thanks for fixing this!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

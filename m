Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F8A3118E5
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 03:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhBFCtG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 21:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhBFCb7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:31:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88330C08ED80
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 15:33:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id g15so4687772pjd.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 15:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6dnZT0AcF3u1j3oEwTbCmRj7PTLoCDXEB/52wfg7Ko=;
        b=BW2izEZ8LP+1njzJY9aNjX5evbtE58IbhhK7JSi0xeTGnONbNRFM9ZCWsUjmxn/m13
         x0f7/Mx2WizyC82kCsYi2JOw7KVDbA22TMEOQCIxNiVpMuH5KZiRR+Fdfm1k/cifJP/t
         FTtR8+pIl96NDvTamKCO3EVv3II5bc4DIHCD1xLQ4gdrWgVOQexL7kkMQnxtlxlaiyIh
         KzOIazyT6wK5RAYDBQIdbyHr/OLCOrHge7x3RaU7oRB2qTe/H7baPdXHgdVb/xxUSntW
         HNytB27A/n5xi1BuBtHgaxvAQQRZARz5XTqoHnps2kp4K0+4Pg4zZ23tHpB9ba83IFDA
         5+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6dnZT0AcF3u1j3oEwTbCmRj7PTLoCDXEB/52wfg7Ko=;
        b=mtIDYHb4LuHkkiP8g2r+QVfUMfFy36MC0TkaUC0E+OErlhxywI0s1pb/5FCqVL+28i
         VEO4sxAhp++Xl73qqjdd9VX/o+GX5wpP8sh32HcPCnlAID/XVG8aPXTzCO898aOJppiC
         PFCPldqNYateMQGIqW5PTXWbEiLIUqmZ9OVP9lG5BdcrKG1K0DUmfR3g2rK+Ao4w22HW
         Cme6dHB59bG8AWJ4PYuxlfwsK9hrRQWIB1CYgyajERxvWAMaGFyASHkiF0bvr4FensV3
         fOeRiTsdVWOmGRNaEUuBM1NAjB7LUKs/foGXc9sPOtgJ9dmBvtw7qHIv4wMMv1R8VZd2
         oSPA==
X-Gm-Message-State: AOAM531sbnZWa2lpMNCMNcNXcFgkOKtmMa9r3YAlHJHutuKJAsyEm883
        e6XYaW2KesYq2mms6McXldEey1anoq6T3rgsOa2Obg==
X-Google-Smtp-Source: ABdhPJzezklMQ5JVyDwFXrgTNeuU6Mw9vXbgWRfxYmJ7hYKLCmebTxO1DfQbl2kNTd6DNLmZB8gX07Bk6lHb/YK/VZU=
X-Received: by 2002:a17:902:f686:b029:de:18c7:41f8 with SMTP id
 l6-20020a170902f686b02900de18c741f8mr6235898plg.65.1612567980954; Fri, 05 Feb
 2021 15:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20210125185333.3337463-1-dlatypov@google.com>
In-Reply-To: <20210125185333.3337463-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 5 Feb 2021 15:32:50 -0800
Message-ID: <CAFd5g477HrqPzh38QdbOMvRr3=kvDBnxpx1QjbnUN4hkvCyt7w@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: add tips.rst for small examples
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 25, 2021 at 10:53 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> ./usage.rst contains fairly long examples and explanations of things
> like how to fake a class and how to use parameterized tests (and how you
> could do table-driven tests yourself).
>
> It's not exactly necessary information, so we add a new page with more
> digestible tips like "use kunit_kzalloc() instead of kzalloc() so you
> don't have to worry about calling kfree() yourself" and the like.
>
> Change start.rst to point users to this new page first and let them know
> that usage.rst is more of optional further reading.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

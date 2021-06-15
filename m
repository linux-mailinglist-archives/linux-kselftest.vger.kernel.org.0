Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4BF3A8A88
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 23:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhFOVDZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 17:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOVDZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 17:03:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E018C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 14:01:20 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x14so608665ljp.7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CoAyLiwzAABeU8evuRFmHRs7KdWsfzJoiB5zqUSRKLU=;
        b=RGspZKjKfe5UEq5fXSAxyfxLiMjZgAj9xSvVuw5qYO0OmjbSFGpApLjx27BLp/qzr8
         x1FGp1CjXna3EqevQlSGoQyaNXpMkAt9dhDYQcE+XWk0vSgCuzA9PjxDvkYtuDSCkTES
         3iqj+qpUvZ/Xz4/+7+roFDUg+bTgmiBIVTXXg5iePg7PsHDMZR7QX0EEJN5jEWWMmyLm
         yKDRR79jBhZhejZ3dVpd5RYq1s32gqsphLOLKZTu08VxsoCbWdO5ggMGFudRCh1/r1Ud
         pLj6JkOBJtwAw3KkBDj4hvtp5VoKDWBFhvr73EiPw8ofSSCTqEJFjApCy1ZaQq9ixd3h
         3JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CoAyLiwzAABeU8evuRFmHRs7KdWsfzJoiB5zqUSRKLU=;
        b=h9q4lc8ltsMkwjA5wyOoHyx7M8xNeYRpQr6st3v9sDu7r64U4paBhRaoiojRey9GFk
         qAWJVofMY2BBUFs8jEnJvhYd/u3a09jY9746YX9AaNcpm7tvCwWqxcleZBxv5VzUcrcO
         Y3BFEe+Zsrkb1ZQmIox4mhQ5Ggz3XMfUZiCjcsNC7QyHRSgID1RlFwOrT63bTG1g5Aep
         eTvkJM6LPOutp3tiNedrCE/d0oIOcgp1vIm6vlSrcO/kV3WukUOG6qpDvKvoVMiJw1fw
         SYWbv58G2c/46BaeD8LT+Chzy8SvE0X0rI+c1MeDD1nn66qHhizw2q/AzD1iAPhsCxuN
         bYtQ==
X-Gm-Message-State: AOAM531c2NMk5WBw62NpzUf3Mu55Tuadd3A85Q1GTOtoH4WJOtbShZ3c
        /U5MH8VcdmsjwAR2EHL2UUrvHNt5zxmNz9oxm/Hj8w==
X-Google-Smtp-Source: ABdhPJyFtC6Zzpj78nBIqyTJD2CXDrr/iWoXgrpVWWQ9oqJ0tlWNde05yv4fWzh8iI3O73NG/IETKCdwy4i05BkDvpg=
X-Received: by 2002:a2e:9ac1:: with SMTP id p1mr1397778ljj.10.1623790877077;
 Tue, 15 Jun 2021 14:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200350.854429-1-davidgow@google.com>
In-Reply-To: <20210513200350.854429-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 14:01:05 -0700
Message-ID: <CAFd5g47bbFdWmGHZQN=P93XPG2Bj=tBgK1W1n=LMFLHdO869gA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add gnu_printf specifiers
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 13, 2021 at 1:03 PM David Gow <davidgow@google.com> wrote:
>
> Some KUnit functions use variable arguments to implement a printf-like
> format string. Use the __printf() attribute to let the compiler warn if
> invalid format strings are passed in.
>
> If the kernel is build with W=3D1, it complained about the lack of these
> specifiers, e.g.:
> ../lib/kunit/test.c:72:2: warning: function =E2=80=98kunit_log_append=E2=
=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribu=
te [-Wsuggest-attribute=3Dformat]
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>

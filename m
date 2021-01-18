Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3950E2FA411
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Jan 2021 16:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405319AbhARPGR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jan 2021 10:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405394AbhARPFp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jan 2021 10:05:45 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E354C061573
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 07:05:04 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 23so24493891lfg.10
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 07:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ri3ViwJIemCRo5Li//ENyLUFjkwkOFqO5AGiqHf+oUY=;
        b=J331cjUcPG1tS5LoQgX2hRDa6mKfwajLBC1eFES7fOibDhYewVXHQyKQEWG2xYPZIf
         Bh+BOz3otEDNfsKc5ab4MvmeQ5urrdGPC5Khca7RebCWDRObMz+WQM+B5hee9jRrYHzB
         6SyV9UYRrG2o7wiLW0uqJQMJUxNJPFG11mtx9R++Ri3SWLwKh9awxAaekulbtLy218dH
         oiCz8L9F35auVvyeiUAkqLfKC7Puj6g73fe/AipJyBAXU1Q0MaE+UuhKcJTE41H91vAX
         hruB5gULNTqa/mvuYs+ehJznauVpD3Qkx4niQcw72qNYBGTzRkFulCzFq5R8Qljqom9r
         H/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ri3ViwJIemCRo5Li//ENyLUFjkwkOFqO5AGiqHf+oUY=;
        b=iww3vRM1eIIufYX35U5ggoZPg2sMWAVW107dKioZKPIOPOimL2AGtUP+88YBxkQq3q
         Gf7vtshgzIrFb4GetCRIgtVROM2qfuN3e4pZNdSJzosGPHsc8H9kK2wGgn8oiaZun+Fq
         U8mot1B8sOxait3hx1LRc/Th+F67UhT0SoJpC3WFIk2gmg9DTC+6wdl4zWTmObRRJiqE
         S4DYwFzCFgxI0eB0kXquvEenc5UPzmkf9W+JLxZDyEih+g8kStS7X6CTCcs/mY/n+wHE
         BJlyWlVwhoIwUQCtH/lYZ0NPdwzdrrt314Gmz2y01lEn8gM5G/WDXO3rqbzI+N+spPoD
         GkqQ==
X-Gm-Message-State: AOAM532qMRxt4O+B8O/qakpFOThGdKy2v7X7jKOvmHeP1O2CRfnC2IDH
        cbCAjIvEXKkot0SYrO3wjkwDNNVlEr1wU7HrcAajcQ==
X-Google-Smtp-Source: ABdhPJxFI1/1/BERIAvssx71vAzMx/DieoiLXAg12yNY2zsJZ74uR0QW2dajc0J1Br5Sw3ihpextmWaR6Wp3bLSIuho=
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr11053598lfd.291.1610982303209;
 Mon, 18 Jan 2021 07:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20210107025731.226017-1-warthog618@gmail.com>
In-Reply-To: <20210107025731.226017-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jan 2021 16:04:51 +0100
Message-ID: <CACRpkdZf2GhScg=sUG35nA5P6jXH93uuK0Fq_uhz29wBQLHOKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] selftests: gpio: rework and port to GPIO uAPI v2
To:     Kent Gibson <warthog618@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 7, 2021 at 3:58 AM Kent Gibson <warthog618@gmail.com> wrote:

>   selftests: gpio: rework and simplify test implementation
>   selftests: gpio: remove obsolete gpio-mockup-chardev.c
>   selftests: remove obsolete build restriction for gpio
>   selftests: remove obsolete gpio references from kselftest_deps.sh
>   tools: gpio: remove uAPI v1 code no longer used by selftests
>   selftests: gpio: port to GPIO uAPI v2
>   selftests: gpio: add CONFIG_GPIO_CDEV to config

Bartosz I think you can just merge these patches into the GPIO tree, at least
I think that is what I have done in the past.

Yours,
Linus Walleij

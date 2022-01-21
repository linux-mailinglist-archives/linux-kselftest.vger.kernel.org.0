Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465DA496813
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jan 2022 00:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiAUXGa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 18:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiAUXG3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 18:06:29 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C154C06173B
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 15:06:29 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id t18so9983472plg.9
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 15:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ANWEnOEwRLJlp79+wbMeS29MVJAChClz5fjV1hvINyI=;
        b=UMzMmME6YQM93ZegCmxvTaK8yDVTGMc5Q15DZ2uDfdyCb5IWrcnBIOlirriJLYlMGd
         GuJXsyUpWu7hl02nmjX17kjPp7aO5oVwzSGxzEqBeNZm6WzZ3DkdbAor5H0AtKQufoRQ
         r5e6sXYSEL9KYqsnWYB96KlxJd29GZx64JPNrURQf4fOnRjKaWPD4QU/vm1c21k4xB2B
         /jXobUhPMr6QLO08qIzRsqwDpZTcs1vorOvZnEzwWq0frsPh529dBU13YbY0u06BDE23
         WhmYx7qHMeMYMIxxrO1rLw7N641JcMhshQ7uuoZeVZpgoLfKVBTQMVHXchHB1n8mS4/3
         xubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ANWEnOEwRLJlp79+wbMeS29MVJAChClz5fjV1hvINyI=;
        b=oMoe8LI5VGTQ4V4L2M81+h2iTr5BuO3AQA7ZE1kTeujOKMHNWGn7M3GpN3gmEIk4lS
         HEr5yLPMk0lmN7JE6ffwmia1i6BfE9S8Vr3C7k7L+PYqp8vn6b1Tvr56KKq5TqBSp3zy
         BodC23CL0A1A5C998+QyLX/PSZi4VGpeYo2h3JoSKObdmnDl1S7j/jiQJ0K/jl/ITnV9
         /0VBRhI/Vq38c17i5txUySOaXbOu7WdzxRxtHpGzbkGwCCj+p8hG35pxAu2ucBKU6CXD
         KZEiRB6nvdwAPU/7WEd7WBqh3BIymssEZpH69+dFKwqq/mtAzDgc7ZF5x17q7IJUbfXX
         YvBA==
X-Gm-Message-State: AOAM53113mAh/PBx5XY9ic8w1tnWscmc60PYEaMB2BHQT5ho0swmt/PQ
        pwXdPect6XYWHp54QFCWKn0lSyCtdEklk/WLfWspcA==
X-Google-Smtp-Source: ABdhPJwgNyFh3Dzr5eTuQ+YcjzkH9S8Gi6DDU4AePnpkIiPZ7nkAy5BxDyL50VHCC+M3wP/4/XN5qIrYq98jGleP5TM=
X-Received: by 2002:a17:902:8601:b0:149:ee23:890a with SMTP id
 f1-20020a170902860100b00149ee23890amr5877920plo.12.1642806388722; Fri, 21 Jan
 2022 15:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20220112233657.15886-1-michal.winiarski@intel.com>
In-Reply-To: <20220112233657.15886-1-michal.winiarski@intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Jan 2022 18:06:17 -0500
Message-ID: <CAFd5g467Yub=uRoRw_cS8Z4pCyjesAeMxc6yN4-1Qwj0Xwu1NA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Import missing importlib.abc
To:     =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 12, 2022 at 6:35 PM Micha=C5=82 Winiarski
<michal.winiarski@intel.com> wrote:
>
> Python 3.10.0 contains:
> 9e09849d20 ("bpo-41006: importlib.util no longer imports typing (GH-20938=
)")
>
> It causes importlib.util to no longer import importlib.abs, which leads
> to the following error when trying to use kunit with qemu:
> AttributeError: module 'importlib' has no attribute 'abc'. Did you mean: =
'_abc'?
>
> Add the missing import.
>
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>

Thanks!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

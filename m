Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD992C9836
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 08:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgLAHee (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 02:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgLAHee (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 02:34:34 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A493EC0613CF
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 23:33:53 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s27so2179839lfp.5
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 23:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyCut0K6zInObzC4IE1TWPjmeFHc6Y5CXn3cjnergDI=;
        b=Mt1dJ2TpB8+JvqWBB72pIrOIFTkUidB+Gi7sMN1i8Muur9gwmCL70ydE6XUT0v9jMU
         PNmG/IwoO9PjUBe2tKep7K1zL9RLJdy/RHwvYky+Tqbpsnmu6edbufgz3k1Y/iWKbnwT
         FF9dTA1u4oJCP7Mszz4A7Yc8I8xr17H6RE87kr94DcbADoXANDGXmb2y6TdPbIzCd1Xq
         8DHslsOiem/yP29b95FX+OgFr7YPmDbGFlvIcAK+BJgXe42NSw/hbS4vnJjg84vXzDU0
         pdystp5TDTZOgSDxyatAshr8bHmGJ/8lv7f3c+hcMvqPRVe+DSfHsw4wZNCH96KLSbhc
         IfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyCut0K6zInObzC4IE1TWPjmeFHc6Y5CXn3cjnergDI=;
        b=Ajc3Ukln4RYoUQDmQrp+NPn6PbzN0orgqx3uzsRq7jLAzcLnV0ojlh51J3Bn3FD8RZ
         ksZB58SQ3Iw+9lGZeRO0UuNkBvWqgr/IXYuI28pmSGKXObeq/TLnUl7MBgMiS4f0rdti
         EJAS+q0+SmXrle/qEZxOxSUT3sutAnjkrb1/XVutp3ybqKc2X6TteUndbZTNwK6XvR6e
         P9m1/436iYchjBUYgMo5GIHzNiONuTV0ZbbrCAm74MgPeScxF471BpVzJkVinO0Zddms
         8oLygUXUeXvPUNU01asq68uaYcyhEKp4ioV3AXdTGpHyv5wg8bJwbm9ym/zfsgRMlWod
         2Alg==
X-Gm-Message-State: AOAM533VaHlw5pRIjT/T+ogRp/AUfhGITbTma5enT5RYU+y/5/xG1eE3
        lECfl3uQk58bR4u44inKzVaRoFdju17jJv1naVWsVA==
X-Google-Smtp-Source: ABdhPJygmHQ4D43fF3y51is3o/i7S9pW68TsJynasWHf90wkdXnagZi0RsXnRhJqjmIl1OKHsDnd2UMXT88NnMas1dk=
X-Received: by 2002:ac2:5102:: with SMTP id q2mr618929lfb.165.1606808032041;
 Mon, 30 Nov 2020 23:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com> <20201130233242.78413-4-dlatypov@google.com>
In-Reply-To: <20201130233242.78413-4-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 1 Dec 2020 15:33:40 +0800
Message-ID: <CABVgOSnMAGcMH-Y0o_KhMbyNYb1y4Wx6SFZO2d3=XUjefvmuSg@mail.gmail.com>
Subject: Re: [PATCH 4/5] kunit: tool: use `with open()` in unit test
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

On Tue, Dec 1, 2020 at 7:33 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The use of manual open() and .close() calls seems to be an attempt to
> keep the contents in scope.
> But Python doesn't restrict variables like that, so we can introduce new
> variables inside of a `with` and use them outside.
>
> Do so to make the code more Pythonic.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
I'm fine with this, and it clearly works fine for me. Out of
curiosity, though, is there any difference here other than it being
more usual Python style?

We've struggled a bit in the past toeing a line between trying to
follow "normal" Python style versus adapting it a bit to be more
"kernel-y". Experience thus far has actually been that going out on
our own has caused more problems than it solves, so I'm all for this
change, but I do admit that my brain does understand the older code a
touch more easily.

In any case,
Reviewed-by: David Gow <davidgow@google.com>


-- David

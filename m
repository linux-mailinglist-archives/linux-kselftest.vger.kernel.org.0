Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CB22EB563
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Jan 2021 23:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbhAEWbz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Jan 2021 17:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbhAEWby (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Jan 2021 17:31:54 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F20C061795
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Jan 2021 14:31:14 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m12so2192045lfo.7
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Jan 2021 14:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgWaHtbTUAeR2bQoeG/I6X+g25dLoH+Ve/eNWw0Mabs=;
        b=L6uJNwRsmyaYznnTWDT+A31utq8iL5LGUf0Z3dojlGv45h4Udyqbama8qRSakwybEs
         gh4l0Yftqio4i0/wsM1FjBBBvWcMBWfWdSNI3fwEqZH8axklBLuRGlRjgyVOMmoJAipR
         CdIbewVoOGVL8CeRN4mYqVyP50+aR0M1NfHHW3dxz11aAoXb4DYNdqp9Pkk0OUFjgmXE
         DfV0S1vVFGd9mvKXBJIovbRn+nikuCq5ZKvMCi6vg8kBfRAS6m7DOQzOLXOZA4SToxsG
         heGmdj46Mn0W7H6YSzjEoNJN2RgKWFKL/eLafV++suT/Owui7mXmTuJCGgb4jlp5UFC/
         Vn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgWaHtbTUAeR2bQoeG/I6X+g25dLoH+Ve/eNWw0Mabs=;
        b=W+ktGqjQvNIqtjKUC8A4vKZxkM0YqYRkychVomEs9gVLpqzrpbhUkhXG+ugbTktSGb
         xf8fOjRCfQb+A0Pcw9EubaAYQXV/qaeLxjFX64ZrDEaTee44NN6TWNUdNcPqqtMK/qZy
         rwp/5qPsJ0TqYE5Y3sGlltfL6IbOklUUD/FpEbLVKjBMmt9C2QW2wwMxEvCnmECXJlv5
         i2cdDpflkUzIea86tRYBCCPGhNjmqYpv9SFG5rpJfSePCf8TNqP4QRLQvsXTlPyKtv4l
         wek0qvnzmipra53MR9BzPyxFWYKdM8VaeunD1ZWLQR+/B1FHKPUGPS9jQpiy+K9sAI+j
         A32g==
X-Gm-Message-State: AOAM533jldc9g8qgL8BbaF0NMsSc0FqhCTPAMkCryu1yKKWDu0FEHlId
        8qjYrXv8hunW3/yQl8FvQVqHXrdcS6l73zzkbmT1KA==
X-Google-Smtp-Source: ABdhPJw3DTVMcCy8yC9MZcxKB5U7rWF5RRzcr7NBwVvDjB4RL0LkiQ7+AvfoKBAazUqY3amsZR0MzKTOhKQYpfGR7Z0=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr795059ljj.326.1609885872751;
 Tue, 05 Jan 2021 14:31:12 -0800 (PST)
MIME-Version: 1.0
References: <20210102022949.92304-1-warthog618@gmail.com>
In-Reply-To: <20210102022949.92304-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Jan 2021 23:31:02 +0100
Message-ID: <CACRpkdZ_drnFeaRtxeRT1J6cSLoRy=9r132HBFq3kKP7XQyeHQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] selftests: gpio: rework and port to GPIO uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        shuah@kernel.org, Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 2, 2021 at 3:30 AM Kent Gibson <warthog618@gmail.com> wrote:

> Initially I just wanted to port the selftests to the latest GPIO uAPI,
> but on finding that, due to dependency issues, the selftests are not built
> for the buildroot environments that I do most of my GPIO testing in, I
> decided to take a closer look.

All patches look good to me, I see Andy is helping you to hash out
some shell script, anyway:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

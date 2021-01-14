Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707DF2F63C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 16:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbhANPF5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 10:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbhANPF4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 10:05:56 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17264C0613ED
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 07:05:10 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c7so6033271edv.6
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 07:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PoskbypxkT00wWzbYavGjYvgKHI4NdWsHemc342JeeU=;
        b=MJgWudY8tusLtxhO0R5P4nglVm+iYs4ZCKhvUV8weiPu9I/CUO4DiiCloQLGYiTrW4
         3dn98O65LVDWwVUo85UWnzEdGTlcKvxobyX5IdeGMJZnVCOWtyySIy8ECJ+3GoaDPTiC
         Rv+U1nP22mWfN9X9uM7ZOWqPj619151+RfRGoggvxKbyGxUqdEdU/8WiSq5j9hmy0C2o
         j02h4umBSDFTjJZpPK8VMJanmSZiZbvv2Mtk15YdWBOIDNHGmbr1ZmkYpR1sFb9j1zaO
         Iks5ZTfWuZ3FIXC7PLTZ38Vdk6ae3GG/xX6tjpRzKm8JSJhkLkwtXrGqauKcSjCABb5Y
         yIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoskbypxkT00wWzbYavGjYvgKHI4NdWsHemc342JeeU=;
        b=Ot3A5LN+kUcnneXzfqaaiqf5k4qZvNOIivSSvs3Z++UEEdsyLhNS4+YMCNQmKnbUrb
         K3HtvVziIRIUFyDiAn681ep97ueIbdwA1ra/NUW5Vi/eCsRQLEqsEEXC7RZ+BKDT5dzw
         TeAcb5FAu0Ck5Du4g1druCZBIVSvgXo/x2PHCn28GVoy2JRVup7LlkB13SlkwQ25dRhY
         1VcAzhGTUv1uJPRbO74iE2vX7X1v3tnBf2cXiyFVL+ajnveB/VAVjmyTRV04Pla4lTIJ
         0dcRzPyCcPYo/Tc6LLZXuKeJulL5FPbvraj0HZQ6rZ/t3sQnuJG0SlFuwtGza8zNAlu0
         7KSQ==
X-Gm-Message-State: AOAM532pFX/yymzbFyFVyTKXXMgimzyOC0TKfmlU6T/1KpjxcESZ2v14
        /8HdDrczw7ns7UEhqpQl9BPZPxKDpO2JSzuJRgTrEw==
X-Google-Smtp-Source: ABdhPJznyXcMdazCTppxUqqiAc22eXO9WHpkaSNq4DdnREGauj/0BxYboWWaRD4gX8RqeRFaz6+qk33S2b8hqzTfmhA=
X-Received: by 2002:a50:b742:: with SMTP id g60mr5944200ede.113.1610636708850;
 Thu, 14 Jan 2021 07:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20210107025731.226017-1-warthog618@gmail.com> <20210107025731.226017-4-warthog618@gmail.com>
In-Reply-To: <20210107025731.226017-4-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 14 Jan 2021 16:04:57 +0100
Message-ID: <CAMpxmJUrkX-nM1pNSrtCx-KKG0edBD1FGuaaRvLKqXZhN4u=Vw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] selftests: remove obsolete build restriction for gpio
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 7, 2021 at 3:58 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Build restrictions related to the gpio-mockup-chardev helper are
> no longer relevant so remove them.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  tools/testing/selftests/Makefile | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index d9c283503159..5411041e63a0 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -121,15 +121,6 @@ ARCH           ?= $(SUBARCH)
>  export KSFT_KHDR_INSTALL_DONE := 1
>  export BUILD
>
> -# build and run gpio when output directory is the src dir.
> -# gpio has dependency on tools/gpio and builds tools/gpio
> -# objects in the src directory in all cases making the src
> -# repo dirty even when objects are relocated.
> -ifneq (1,$(DEFAULT_INSTALL_HDR_PATH))
> -       TMP := $(filter-out gpio, $(TARGETS))
> -       TARGETS := $(TMP)
> -endif
> -
>  # set default goal to all, so make without a target runs all, even when
>  # all isn't the first target in the file.
>  .DEFAULT_GOAL := all
> --
> 2.30.0
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

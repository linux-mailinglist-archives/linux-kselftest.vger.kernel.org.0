Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90619473404
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 19:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhLMSal (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 13:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbhLMSal (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 13:30:41 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B5C061574
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Dec 2021 10:30:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o20so55531972eds.10
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Dec 2021 10:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3YkPQNm8HT8uPOkwlxqDDosj5jXAidcs7NGVfMzGdQ=;
        b=PLD5ugaoBxsfh13ItjXwt+RNxiwpsjiaasa4t/MUMpINo5uqktSh5tco4R6UweAQgK
         MqvGKm8ztEc/M3G6KVIYytn8Bm8hkmzeOB2gUQZaSuMwlTEneVyDnM/nMi8JbKVOY81/
         fPqWP04HenfQmN39e89XLHFapkLjIvDliA525SJI54yu4heczQ03Fqm7kOr6n2pB9RH6
         R+RmokoP1evfSqPD0UuNQUA91Dlu16XEsYjmrT6yz4vwCg+N22NpseGGJICSklRu5wfl
         5WNKXzYJEFBV6KR0sYPKce8YyOmalZV1OoydswBghAjVXZl65mgjUte03EmT7nopsyNU
         FbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3YkPQNm8HT8uPOkwlxqDDosj5jXAidcs7NGVfMzGdQ=;
        b=SHImleDP4vlEzWE8z/yRQnmN+WaHmG9yEUHinW5L8lqCfkJlsFpzDQOj024pBLAw/L
         W8rePkO+8qCqEdWx0SEBI6swaQH+XgdnsUXSDhW96WLZgpkF5a3byR7WZ74NhmuHFayP
         GwqAtRQyBD1SXpg5T53aeWtTnOAcRRNAjBTfs6uBqnBvUVBo2gnfLfmXwL1AjOrFJd35
         BbVdZT9vFf+sjyhnzFPyjDibeqmEHlaD92jEYmRnilCoYrNfJmm4rMo8ArrGKPzQe6My
         kwoP7idJVxN3LUYxQGVQJ9qvVpzhzUHKFZlO2IKnn0JzBn6O5tLfL+G2PEgx1nF13AxL
         ENlw==
X-Gm-Message-State: AOAM530eQINl3Ujc1717GVpJdOswmBrps/ryyW/L6A/dKBQHJIZpB+W8
        Yn8sCmPLO7MV9GAK9O22Wkj8fzFv+ztQyxs/fykFTg==
X-Google-Smtp-Source: ABdhPJyiubzERra+E8YaazWpZr091U7oC8cB59PSHrp6pM086prR5B207yEmyjou/vFhSLrfFhB+yjJkKc7RYvFcV9M=
X-Received: by 2002:a17:907:6289:: with SMTP id nd9mr51979ejc.101.1639420239120;
 Mon, 13 Dec 2021 10:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20211213162625.18081-1-brgl@bgdev.pl> <Ybd3DT5e3fCP5JiS@smile.fi.intel.com>
In-Reply-To: <Ybd3DT5e3fCP5JiS@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 13 Dec 2021 19:30:28 +0100
Message-ID: <CAMRc=MdOeB_xFTodeAhNBK3E0OuDRceW9wFGK_iPB8=GjGoj_Q@mail.gmail.com>
Subject: Re: [PATCH -next] selftests: gpio: gpio-sim: remove bashisms
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 13, 2021 at 5:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Dec 13, 2021 at 05:26:25PM +0100, Bartosz Golaszewski wrote:
> > '==' is a bashisms and not understood by POSIX shell. Drop it from
> > gpio-sim selftests.
>
> > -             if [ "$BANK" == "live" ] || [ "$BANK" == "dev_name" ]; then
> > +             if [ "$BANK" = "live" ] || [ "$BANK" = "dev_name" ]; then
>
> While at it, no need to fork `test` twice, isn't it?
>
>                 if [ "$BANK" = "live" -o "$BANK" = "dev_name" ]; then
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

I'll send a follow-up for that, thanks for spotting it.

Bart

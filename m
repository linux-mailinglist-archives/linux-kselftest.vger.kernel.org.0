Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC6EAAE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 08:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfJaHMg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 03:12:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45178 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfJaHMg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 03:12:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so4970420wrs.12
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2019 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tp3Ez8VC0XFbaT+hgR6CPrD+SWbALo91LUbFh4nLv2I=;
        b=BWc9Lgb4ffE/c6zKH93LKOotgFgvzrf7Iiqx5peY+b+phsQPhNRoSKurM7+SOk6tXd
         lGdIiobByRKpNPxkENxN0xzPlZzsmj0GfjRlUHaNz/KxMjdB/VaGd8jc0+PMoqUN+8ie
         Y5YAXsNluRkWlsBv5eO9bueZtKTFLROkx8kNoHnKREeD/ScZwnNxJeIbKtufpihY2U/d
         7tft9dDX3FxSR+eTX+ZHMf848+ZYfw/fdj9rdvCxKuxsfNk0y2mqUP5By6oNjf9QkzFU
         34/WlKPOQq8eWyxuJYaKCWGKVPaHdSyaTHT5STGCZo6FRCOZrQ3m7hWhxcwU2bh/ArHs
         fEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tp3Ez8VC0XFbaT+hgR6CPrD+SWbALo91LUbFh4nLv2I=;
        b=PKh+RPeIch02mMcRcokiiR9943dWfl1CTGMXR2hT+S7/jUb8EzS8TUd9AY4/X8CZcR
         URFNS9Be4zj6b2f/5fuuu/QRROH9W0ky+A+xNab4mSsst3nJ2CDNerGktqmAtRV3aoZW
         SiPc7QXNOthvVfmxQnTYp4fb1ll3BLu117lnO9q8dsGrOYfpy2rwVo+lYht+wB+K7y6y
         xm865zD7DX9D4BdcWz3zdjcF3myYxjlP+a8pPth8lFXea+LcwuKhVhOJxlZk6m1GhG1V
         Zp4/8Jd0PpqstS5JagakMk5QwMsih37zluCGm3arBhDASpnyjf9pkPus95E0lOdZkWx7
         fxbg==
X-Gm-Message-State: APjAAAU/k0qlbojH+sQWgWiu5+Cg7THmf6LWgQJajZDQr7SC9opZBU7C
        vIgbgZ29X6gK3AvewKDK5/7pBzkpzm4KDxgcPgyDciCIj3Si6g==
X-Google-Smtp-Source: APXvYqx48Sm/Pjqigtw0m+ZRHtBWYpse3AxLPAsfUZ1r9FmyFacpaSNqXi6jIvay0nhWPZqFnokYv/fVf0lF8NoF3IM=
X-Received: by 2002:a05:6000:101:: with SMTP id o1mr4001921wrx.394.1572505954230;
 Thu, 31 Oct 2019 00:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191024224631.118656-1-davidgow@google.com> <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
 <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
 <20191030104217.GA18421@kadam> <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
 <20191030191255.GD18421@kadam> <f665ec7b21527c7095a61dd5c2f48fd00df0d5c9.camel@perches.com>
In-Reply-To: <f665ec7b21527c7095a61dd5c2f48fd00df0d5c9.camel@perches.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 31 Oct 2019 00:12:22 -0700
Message-ID: <CABVgOSkKCXodwi=RcmRpB+t157surmEjq2b+92VQQD2Cy0WTvA@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for the
 'list' doubly linked list
To:     Joe Perches <joe@perches.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I tend to agree that it's better to either fix or ignore checkpatch
than to arbitrarily change things in cases like this where checkpatch
is obviously wrong. Equally, it certainly seems that there isn't an
obvious way of modifying checkpatch that will both not cause other
problems and not add another arbitrary name check. The main concern
about just leaving the checkpatch errors in is that people might be
automatically rejecting changes (or worse, the whole kselftest/test
pull request) if checkpatch errors are present. I'm not sure how
likely that is, but I can understand the desire to be careful, since
relatively minor changes have delayed KUnit changes before.

So, there are a few options, I guess:
- Hack around the issue in the patch (as this v7 is doing). Ugly, but
does at least mean that this change won't trigger any automated
rejection-of-checkpatch-errors people might be doing. (Even if, I
think we agree, automatically rejecting anything with checkpatch
warnings is not really correct.)
- Accept that tests (and other functions) with "for_each" in the name
like this are rare enough that it's not worth the complexity of
supporting it in checkpatch, and taking v6 as-is with the checkpatch
errors.
- Modify checkpatch to handle this in some other way (e.g., only if
the name doesn't include "test"): I don't think there's a perfectly
clean way of doing this.
- Modify checkpatch to make this ERROR a WARNING instead, since we
know this check has some flaws in this test, and potentially future
tests.
- Re-send v6 with a note about the checkpatch warning in the
description, so that it's easier to tell if one or more of these

Is there some combination of the above that sounds good?

-- David

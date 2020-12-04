Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C62CE6FA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Dec 2020 05:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgLDERv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Dec 2020 23:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgLDERu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Dec 2020 23:17:50 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B40FC061A4F
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Dec 2020 20:17:10 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d20so5864740lfe.11
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Dec 2020 20:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqbYgHoyRpSXCyJ6D915vmzlzKvUWRldO8k4oJpM0AQ=;
        b=PTXeh+y1BZR7RngQCYoV6fWKQ0zeI9y7rHS64cHX8wi9aNY5DVvHBblOuSDkFkJQoO
         K19eCEO/WfOK6hEOuReM2KiRIBBUgJwhHcZM4gyZ4XiqYEUZUdMBty+98ryea0v1zI7A
         dknR8EVb2niIz//e1tS5HPWK/wKcs6FaG+11GVs6khUhexlGIoestI8h0/LgNvMAK8qt
         ldrwkYY6mipndHTsVwJ0eDNxDloI1XWCtBGFLGB1E/lYWhXmDTSXRnUXm8aNFpVTIc65
         mS7bbVIZcMvedCkGBQ3pEvJWu2tDNWYpEniH8xiD2s/5q11Y3w7OzUtsZz+x3h1+z/ZP
         eX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqbYgHoyRpSXCyJ6D915vmzlzKvUWRldO8k4oJpM0AQ=;
        b=nY1WhC87vy1WBqDN6a5pdMyFWCJuPqtBUXw/QBMlrnptGMvT/FEg0z4QE5yQcjF3Lq
         PqbDvF2SHd6UNUEWSlwGm80laFqE8SCgA3d/+YwFEyjpw/Ob8oRY9IM9fSzdYioevT/R
         +Sm2Ss0zW+wVxM479//eUAiaB8u4hO57+oheMbaIJDO2L9zk+uT2+if/f4wnOGXlykyq
         Gbf+uc+hZ6XvD2SGWChahx7cJBQK2TJkzNryVj0h+mAr/JKOkKSXnR2HEZndvHFoGKp2
         jlQ0d4QzZKfP1AR7BzU8Qzx429BfLHIJHrrvwUFJNvyMayhW/xVsP9aQOXMEIFxShVaG
         dcpA==
X-Gm-Message-State: AOAM531dhQmDgZf/MtpwVWPaCYsSnX+5xEfG71ioOxg9ksn069fWV1lu
        vl3IrHcwh8WVQ6qVC8CkBcOVHeiz3fw0ml2tCUUGEw==
X-Google-Smtp-Source: ABdhPJxiOKO/A2wEfl8X75fUSGui4pNH+ob3iIIVIjIoBc46Asnf4hEPl43PB4peXdOK1wKtxq1bidSt42t0tPcJSfc=
X-Received: by 2002:a19:5e5e:: with SMTP id z30mr2518792lfi.277.1607055428578;
 Thu, 03 Dec 2020 20:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20201203194127.1813731-1-dlatypov@google.com> <20201203194127.1813731-2-dlatypov@google.com>
In-Reply-To: <20201203194127.1813731-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 4 Dec 2020 12:16:56 +0800
Message-ID: <CABVgOSnhcMB-xggP5u-p8UgtCR_roiqPuUUZC6nY1_48opf+Sw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: fix minor typing issue with None status
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

On Fri, Dec 4, 2020 at 3:41 AM Daniel Latypov <dlatypov@google.com> wrote:
>

This seems good to me, but I have a few questions, particularly around
the description.

> The code to handle aggregating statuses didn't check that the status
> actually got set.

I don't understand what you mean here. Does this refer to
Test{Case,Suite}::status potentially being None, and that not being
supported properly in bubble_up_{suite_,test_case_,}errors(), or
something else? Either way, I can't see any additional code to "check"
that the status has been set. As far as I can tell everything except
the default to SUCCESS is a no-op, or am I missing something?

> Default the value to SUCCESS.

I'm a little iffy about defaulting this to success, but I think it's
okay for now: the skip test support will eventually change this to a
SKIPPED value.

>
> This sorta follows the precedent in commit 3fc48259d525 ("kunit: Don't
> fail test suites if one of them is empty").
>
> Also slightly simplify the code and add type annotations.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Otherwise, the actual code changes all seem sensible, and it worked
fine when I tested it, so:

Reviewed-by: David Gow <davidgow@google.com>

-- David

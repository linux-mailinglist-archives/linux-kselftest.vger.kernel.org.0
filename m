Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F9036879C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Apr 2021 22:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbhDVUDp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Apr 2021 16:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbhDVUDm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Apr 2021 16:03:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750CEC06138B
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Apr 2021 13:03:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so13614pjb.4
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Apr 2021 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PquUgnAHmzPPEM2hTMuE5X7Or48hZxa0Iq7nE5kZVAs=;
        b=AVQrLhmn18k7xc+K7EYwaEQdFLa3btb1xFBVHxS7g8oiqJ+iocAPRpYPHg5F2hFb8F
         fdal1gYwrnAHspZmUgT68PGGRbp7l/rTHHTVhDlx4z9BF5fOl47/nU0LmPzLjSQuGiVV
         Vdz5xc3eAgJELCuAkHZnlr3iVVwCxV/dDxFJTS6cF95ieSkIxvX7QKKjARrI9jtgGyt3
         Krp7KaakqgpURkJLChowc+Hsq/hCwTb3+UXDCgQcauituJaSPsW+YPTInyR0T4DjlyJI
         d2lqDWABMHzMNPP3CCDtG2oghR7pKrRWt7Sw0foJTlx7vazYheX4tTtTKPuD408mpxPr
         vhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PquUgnAHmzPPEM2hTMuE5X7Or48hZxa0Iq7nE5kZVAs=;
        b=Z/xwpPFvukMrSWAJA0d0cvFxBzD0H7rkFpDUKVvYE1jL2vRjjg3tgdq+xQ0rfSd9zJ
         /uVSqm1JAbafzLVBbhlBy52OT0HmTV0qxWEGbxpoQMN3HTDeWVZfmcdQ1yPWQFUS9vOJ
         pCht/SvB8V/DBucuxcJqDTUjOAdKlaZBn8T2jKCAquFfx6V+CtQWsDsm9ngISfE4g8Sy
         /vN0XIx6ZxrX0PIX7xYrbGK6ewU2/LwU2I9ah/QyArXoMkCSmnRwMg5baj3nR/zhiqke
         sWEjKgAgokNyhL9w6T1WKsUSBPSle7mpobGe2cC647+g0FhTHdrhvcy/JGgzUiLjBPJB
         /a4w==
X-Gm-Message-State: AOAM533FaEbF3x6JbJNuyEkM+lpMyShDCDBIqq/e1jtzII95mEUkYDo3
        7OYgApTPHVZeExOyzBjEqXEcyKs+zDRTDb/kasmdKw==
X-Google-Smtp-Source: ABdhPJzUKUFs1pX8iuh6hcmAcZecFWy1IkjZKdFpyI/qO54h34Q91x1E2fjAgDSfsp2Hul6tHHaZn4XvRi0LRmQbwtQ=
X-Received: by 2002:a17:902:7892:b029:ea:b8a9:6190 with SMTP id
 q18-20020a1709027892b02900eab8a96190mr207069pll.80.1619121786805; Thu, 22 Apr
 2021 13:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210421183210.2557462-1-dlatypov@google.com>
In-Reply-To: <20210421183210.2557462-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 22 Apr 2021 13:02:55 -0700
Message-ID: <CAFd5g47P4atPPV5C0iBFV8kZm1vUgzST-ghLMm4nq2Qc-=C9Ow@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 21, 2021 at 11:32 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Add in:
> * kunit_kmalloc_array() and wire up kunit_kmalloc() to be a special
> case of it.
> * kunit_kcalloc() for symmetry with kunit_kzalloc()
>
> This should using KUnit more natural by making it more similar to the
> existing *alloc() APIs.
>
> And while we shouldn't necessarily be writing unit tests where overflow
> should be a concern, it can't hurt to be safe.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Aside from the copy and paste issue that David already pointed out, LGTM.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

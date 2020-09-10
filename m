Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B29264D7E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Sep 2020 20:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgIJSnm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 14:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIJSRv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 14:17:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF8DC061756
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Sep 2020 11:17:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c196so5246714pfc.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Sep 2020 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DtLKtH7cWRrM3fBgblOeHcZmUDs1Wpod83D+Qi8K1cc=;
        b=QiJNnp9n6c1hPuSVLuFhpjOR4+ZpNWRatUSshd6auMBfdw4ViobGDo1sLp8WptM+cr
         WzZ9S8RWNEJwaO9biXJJrXzZKrPD7/t8BroZ8/UqwcRk7x7UzOY5o5uG1GPrOILcHVF/
         sxqlovkq+EUePECSFJ8hAQxubuFE9VBRx1m8cNWkmk01F3S4bDCxA5HOU12fr/D+FZtM
         zNclSwXRg8HFwdlqmrzcSakRfrcUqv5VlzrlucdOuNku1VjFt5BNAInX4Lz24qUFd6Rb
         qgeoK+b4jxLXFXn1swOnaBleoO4cOdN6pK/11zb2yFXKBdxlhSbf49UCOUR2O/CRm912
         Wj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DtLKtH7cWRrM3fBgblOeHcZmUDs1Wpod83D+Qi8K1cc=;
        b=k0Swfl8MqfmhZ2hmUmB2XSIsP8ZArakhqhZ0Vx8Z+gjxVveyLD780v9VR+TVoB1FHV
         E2KhrQRvY4Kg3IdVhc7UhpIkpO5pxP1q2dOQ14syK9yo5lxPWsSoGkKiuSLuVL/RL4AZ
         IkV33rc1a0GY/WOs3CAKvzd3LHYAY5uJTqZ0zKS8o3vj9NrTXuOg8X6MJTs5JbHJCb1/
         qFkZ/1JjkBeaZI8CwwrI1RUjb4EJoqEc0+CT0NMbOJjKzm9A2zagpi/1YQUoL1Esmy6E
         REFs3DaVdf5RQ64pZ4zpzkmfbz71hnE07nENlrE4HwfGBf3/wOR1afxtqyZZy31vOL2a
         g6ww==
X-Gm-Message-State: AOAM532nJti2MroPqJCXA6JapXRoLD9HMcQy48QChP7+AxjnlGx+0TT1
        VMW/pbVCvvBKj4JB68rgbvOxUdSNXtO0zAxIq11ilw==
X-Google-Smtp-Source: ABdhPJxEKiKH222RavCG1MjIuH2RIPD8diBxo187fBd0IF7zvgXujERcwklhJn5QVzlBDwMXk82VeIgbOz+PuiM8csA=
X-Received: by 2002:a17:902:988f:: with SMTP id s15mr6555650plp.26.1599761853442;
 Thu, 10 Sep 2020 11:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200910070331.3358048-1-davidgow@google.com>
In-Reply-To: <20200910070331.3358048-1-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 10 Sep 2020 20:17:22 +0200
Message-ID: <CAAeHK+z1qMgg042rii5kNuDR1UeC9JzhXYMT=pSHnHQtoFFKew@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] KASAN-KUnit Integration
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 10, 2020 at 9:03 AM David Gow <davidgow@google.com> wrote:
>
> This patchset contains everything needed to integrate KASAN and KUnit.
>
> KUnit will be able to:
> (1) Fail tests when an unexpected KASAN error occurs
> (2) Pass tests when an expected KASAN error occurs
>
> Convert KASAN tests to KUnit with the exception of copy_user_test
> because KUnit is unable to test those.
>
> Add documentation on how to run the KASAN tests with KUnit and what to
> expect when running these tests.
>
> The dependencies for this patchset are all present in 5.9-rc1+.

Hi Andrew,

Could you consider taking this for 5.10?

Thanks!

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1146706A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 04:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350432AbhLCDFj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 22:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350360AbhLCDFi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 22:05:38 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B298AC06174A
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 19:02:15 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v203so5183621ybe.6
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 19:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7PaP8tSfENa0iq44ql6ZAlEC/JeVO3TL0+8pVjJNAs=;
        b=kWNAEBAC02bV50QGF/i0k6/BGpUVnovxXt7Bdh8Oi+xN+Cl3Uwf7n4tservsKdy+Ye
         vu/gZaHuSQxlZk3MLBc7WtJXHNIzyb4FIlN2oN11jTmKj8bmQwTY2N3nCLMBd/UUQgwT
         UfQyhrogfhvFyNwleewGOVMhbVdN8vqCoGXAy6iFf9hWuamq2HCcupXgIUi+z/6miFkI
         bvOc7pXXlK/0ERZSxLOys2Ppkz8s+HBWfQ1WHXGKuu0Q72tHUPIEpwKqnwfjZc3g52uI
         bjg0Kp3i+IASjSyTh/HdIL+5VuNOPEWUwdpzqOtWsDFvEHEdAmqmMX9IU74496f4opvP
         OE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7PaP8tSfENa0iq44ql6ZAlEC/JeVO3TL0+8pVjJNAs=;
        b=kKN//0v3b39wrEnvHGZNdXBZmvB/2JIyHw/xG/SZYsl98h1J29gaFC/9fRQKon1STr
         NTq2YM4vCKSBs0dSvAoXwMhjDdY62OxmMdDEzFRAFg3ebQceGPci2EFxctuBojaWNcgo
         r3NQ/Xwl67FwhNrWrnBA8cPJ5vA/Smkbb+YjysanG6Zc8VnLQbwtsfuqg2A1ftXknBg1
         Fac3hz4ThnMkzh5zB18j8t07pmJWr7mz3xiKREwTPajq948SVlPw+zo2lalOeaqqnse6
         mWd/JoBP+tNXD0lb7mOwQwPuhL6e3zc85NGskXgNrQ785hTbBI7l2qmGnICfrewSOVyD
         02xQ==
X-Gm-Message-State: AOAM532hke8nFUoOrQRW0JraXH5VlbsVQw3fzkzBl976P5rXiG1Dl+ti
        Ig4KmaII0S82d+9XDaMTChV33NK18gZfNG6DqB1YqZ7sTYJZZrD4
X-Google-Smtp-Source: ABdhPJz99Yxf8WWAJww+VYX8V78U0MvyH5Oy353Ttz5ekTrjiy9CNWit3BY/k9oGR+/J9ggrpG6DX2xplKmKqkZ/V/U=
X-Received: by 2002:a25:b285:: with SMTP id k5mr19708197ybj.132.1638500535048;
 Thu, 02 Dec 2021 19:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20211201150440.1088-1-sj@kernel.org> <20211201150440.1088-5-sj@kernel.org>
In-Reply-To: <20211201150440.1088-5-sj@kernel.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 3 Dec 2021 11:01:36 +0800
Message-ID: <CAMZfGtUPSmquyMd70HtqFVvxU68kbTdYN1fJU8g35zeXHMJHVA@mail.gmail.com>
Subject: Re: [PATCH 04/11] mm/damon/vaddr: Remove an unnecessary warning message
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, brendanhiggins@google.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 1, 2021 at 11:05 PM SeongJae Park <sj@kernel.org> wrote:
>
> The DAMON virtual address space monitoring primitive prints a warning
> message for wrong DAMOS action.  However, it is not essential as the
> code returns appropriate failure in the case.  This commit removes the
> message to make the log clean.
>
> Fixes: 6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schemes")

I don't think there should be a Fixes tag since it's not a serious bug.

Without this:

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0570841BE4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 06:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243518AbhI2Ekf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 00:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242323AbhI2Ekc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 00:40:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E46CC061745
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 21:38:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s24so778605wmh.4
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 21:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zlg2ffgJZT1VwiTB8Phi7Vv6uNRedICrBmMqDsNYoFY=;
        b=cCGbOTGnN24R/n9Qd61V3WdCjIg0X+En8PKJB8AHr5wf07PgqkDx1kIxrLTvDG/xog
         NAkEPnBQX0kyqnvGoC2iv3lBtKFLWkJkXlUTkU6JfEpNcfEYuH9yKjmV+qE5T7bWXEjT
         snvRsGDyD4FAwihh5dfqLfXFIqfs0LCvKv9UdKAjoONFtRo4QRizezHRe8kXZaY92FwS
         A1waC4Hw3h03oWF8GOlzcW4Swe4XcWMJpogA63bvCxkh9McD+7PCKAapkRiVTMHBB+ih
         gBvJxKTzUHks3EEOu4+bjnNZhCz8rxqmCp/Vfr4K/quSqMv4f83acPpSXnZTEn6QGkhW
         p1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zlg2ffgJZT1VwiTB8Phi7Vv6uNRedICrBmMqDsNYoFY=;
        b=PZvut/gGqf6+nHJJ9rq1u1fnRAd4snJlS3zAI0CFp3cSqzmtcxkzSzKW2eN/E5OdVU
         eoZfJFnlL19+ZjWBzx3HYeY7cbVkWbWn2xledIdLNBWikO5uN9SitHzzrQ/NGFH4fWai
         V/X2AV30jtMhJ0GfubmPskEYZFVztMSskS3KTj6GZZcIjMc9Yg99wdH/ubt8RsnHgXUf
         pAy4Ik0ri4pMJ4k2mlHAZxSErih12TvgZ7Mn3xir1EowmgrFMTYRoURUHq+Q5W0sEQ7k
         MXLeeVuu5pRC3PEOaGznKacjWiY893riTk4j/x1SFWxz29U2SyIxhbhpsvSZaQSE9PX3
         UcbA==
X-Gm-Message-State: AOAM531lykipV6YokiU4k/FvcwkFK3WPNiNRr/CU5sYBXjqp6RlFXNpC
        lmC76vXz3aT+ZjOaI7aZmF02pNx/7F+qT+ZEnbRxtA==
X-Google-Smtp-Source: ABdhPJxqO9D6g25akcvYZyp0qmyuqh6TbcUBK1Dah7hn+IICZ1cBX7dVvGVmwOyVx0BMkCUB2ytKJU9U+5j3Z0gP0rU=
X-Received: by 2002:a1c:1f10:: with SMTP id f16mr8235422wmf.179.1632890330849;
 Tue, 28 Sep 2021 21:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210928222926.1180749-1-dlatypov@google.com> <20210928222926.1180749-3-dlatypov@google.com>
In-Reply-To: <20210928222926.1180749-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 29 Sep 2021 12:38:39 +0800
Message-ID: <CABVgOS=E=p_2=oMpgx5_h4Jk_16X1NX-ZRp2gXC1fRXf5OAfbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: tool: factor exec + parse steps into a function
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 29, 2021 at 6:29 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently this code is copy-pasted between the normal "run" subcommand
> and the "exec" subcommand.
>
> Given we don't have any interest in just executing the tests without
> giving the user any indication what happened (i.e. parsing the output),
> make a function that does both this things and can be reused.
>
> This will be useful when we allow more complicated ways of running
> tests, e.g. invoking the kernel multiple times instead of just once,
> etc.
>
> We remove input_data from the ParseRequest so the callers don't have to
> pass in a dummy value for this field. Named tuples are also immutable,
> so if they did pass in a dummy, exec_tests() would need to make a copy
> to call parse_tests().
>
> Removing it also makes KunitParseRequest match the other *Request types,
> as they only contain user arguments/flags, not data.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks: while I did sort of like parse_tests() being called more
explicitly, upon reflection this is much nicer.

Reviewed-by: David Gow <davidgow@google.com>


-- David

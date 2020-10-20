Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5467A29441F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Oct 2020 22:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409665AbgJTUzP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 16:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409664AbgJTUzO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 16:55:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849E1C0613CE
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 13:55:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r10so32495plx.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/lCosLKiAA6CCkrAkVBxnMww1s6eqZZtcsOV8oECpk=;
        b=CGxkpNQkm65tzOZjitMBtU32hgvmaXJ/KKkfvxSNZzzK6YbkRQQ7Ktl2p1hroZp1bF
         HumEdgPtC+r3yISPm5NgzHMBh1HhFv8/XfAtSv8t5C0wgsQZ0Mv5CcjAlCH0a5M5rNbt
         gCYxK/8BHaHNqTBbJTP+taP09Hv0My7zm4qLQb1eZhqvgJP5MQ0YVPkABgFNeb2PJiCH
         3XHgonGSdZMCL1Bt30rsgL4Jzf9vZjAF+hQiFy3s+NkJfqKY47toTR3YyY0f4OkmQ0RM
         6bojMAZCpJ30/Lhn+zStY46gIG94ik9m5hrEivEIsPvXfUBF42YAQWKv/ywOjQdRH/PH
         8AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/lCosLKiAA6CCkrAkVBxnMww1s6eqZZtcsOV8oECpk=;
        b=YWugu2CLxCW3xDoaZNX+8RtD79qSjgcXDzKLr9n1LSBZa4nH/eNG4C/bXuacWDzvN7
         HhSZYhFIwFznN5G8ZjOmFPX2rvuq3vi/hfgIOvLx2joZfAwrQZd8JAo5sG97kFOn4z/S
         zEwLggJRAC9HH5VgQPEmmZHIJhlPOQmB9DB3kJ6qGCu0o/kdOCwHZ2ih45cLeSnW0/6a
         NuxTDupkCXUyONInNg+DxS5PiDhlURu+qbJy3Wx/t9YdnUaAaQD6nwj++oQmoSLYlUWy
         AUTfvT/3jd8q5hU5L1V7j1aZbA/elLEYFgISN77NzXiKwK55/3lvE3htSMMeBaJFpz5v
         Qjdg==
X-Gm-Message-State: AOAM532bCwT3wLFk+kj5ham53VIZIAp/yFcQob6O8JdSOzI/O6DRK8zc
        4QNkvByEi/WOYG3IWwuBhDcTkQaj/d+DYozdpH/Xbw==
X-Google-Smtp-Source: ABdhPJwGWk/0XwFcOO0MZns44wnt8msPCMFy9sP8x5NTmjQNM3Pcm6qFiBoywhMgr0TR9f6fbbxQ44lCG/wkFP+ZDGM=
X-Received: by 2002:a17:90a:3e4e:: with SMTP id t14mr64914pjm.217.1603227313797;
 Tue, 20 Oct 2020 13:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201016110836.52613-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201016110836.52613-1-andriy.shevchenko@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 20 Oct 2020 13:55:01 -0700
Message-ID: <CAFd5g46OZ1sFY-o89_nRCcqXOj-+OFkLy88HqWo2YJ4VuF86tg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] lib/list_kunit: Follow new file name convention
 for KUnit tests
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Mark Brown <broonie@kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 16, 2020 at 4:08 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Follow new file name convention for the KUnit tests.
> Since we have lib/*test*.c in a few variations,
> use 'kunit' suffix to distinguish usual test cases
> with KUnit-based ones.
>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: David Gow <davidgow@google.com>

Thanks for taking care of this!

Acked-by: Brendan Higgins <brendanhiggins@google.com>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8161F2FC4C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 00:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbhASXam (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 18:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbhASX27 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 18:28:59 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390E3C061575
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 15:28:19 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id u17so43313467iow.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 15:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppNFUDLkhvwlaQPg6siyPxeLAB8qizQSeUojeb9HOrU=;
        b=TVZewjEtoyESZPYnxCRKpHkFeVRlw0bH1Mom5CozNv+9gl7IO/aeV7eiAXaG42MWc1
         cQ4WgZ2Hx0wphYQmrwNEOkLQWibl7nZFbT55QlypCFm+I1DT7BI6DwVm0ldGhNd3vFJN
         cIBG2YsiogRvggUIX3gg2UHaNgKgG+9+d+Cwy6ZE06N0mfL/Yj2nZSe6DtQw+aVMAW2Z
         IPU4Nx5ZE07wAVlljGAIdusCaoJOHmHG7YzXLPmC+j+mhmKdXeThhKQoJbJeZIrt+Nj4
         Q0fnNV2lk5glMkwK92PjIcJhvMqgTxpscGyZ2LySPklc1E47n0Jc7hVTKJb5OHTt8TSP
         tUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppNFUDLkhvwlaQPg6siyPxeLAB8qizQSeUojeb9HOrU=;
        b=V5tAZzoq6U3keR+u9AeM3DXapfch+X8WQ6WFLFXR7hYWG+46jzK10ZnL+7m9jfrTwn
         rzrK2bkZI7OaLE6WXc2jQ3BEPAAtY35/+RwZiNUoN3/b6PiLm3w4502a2WNZgA730xvc
         isPTfWZTY7eimQilF4jG8KREvKXqCjhZvBrBnSu79COsfJmCWQgeNhEZa3rjQaEYcT2P
         2G5jNftz0VzRW1G9vvkGFausFO0vWYDg2eG4yaC13s74crgmrdJL5QglcUYYWz9jEtDi
         FqeakkiLvZl72BcXxLCcTboKtw9ICGI5r2IZ66sMt0V0vQkE35KDGKx04rhZLCUOa4V1
         ubpQ==
X-Gm-Message-State: AOAM531x/KARZMFwShhZnCJ5oEAG58mOJnUNzjOX02tOCJy0suavbDA0
        vFtQ5rnuIru2gqXjkLjVcO3TBbkn0cMWUb7M9+B0gQ==
X-Google-Smtp-Source: ABdhPJwdMtwY5+ZTKb3YKBTBw+18+KnTl4ewr6eOgpYE/f7uMEjcNcPNiyfeI6tvVO98gafhWgrZSlks1l6PW/NnRAk=
X-Received: by 2002:a5d:980d:: with SMTP id a13mr4752861iol.168.1611098898454;
 Tue, 19 Jan 2021 15:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20210114182700.1298392-1-dlatypov@google.com> <20210118103653.GA4077@smile.fi.intel.com>
In-Reply-To: <20210118103653.GA4077@smile.fi.intel.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 19 Jan 2021 15:28:07 -0800
Message-ID: <CAGS_qxojC-sw7kFdb_rDee9j_P91ccaaYhBY=Mju8i04-g53=A@mail.gmail.com>
Subject: Re: [PATCH v2] lib: add basic KUnit test for lib/math
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 18, 2021 at 2:36 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 14, 2021 at 10:27:00AM -0800, Daniel Latypov wrote:
> > Add basic test coverage for files that don't require any config options:
> > * gcd.c
> > * lcm.c
> > * int_sqrt.c
> > * reciprocal_div.c
> > (Ignored int_pow.c since it's a simple textbook algorithm.)
> >
> > These tests aren't particularly interesting, but they
> > * provide a place to add tests for any new files in this dir
> > * are written so adding new test cases to cover edge cases should be easy
>
>
> >  lib/math/math_test.c | 197 +++++++++++++++++++++++++++++++++++++++++++
>
> Can it have _kunit instead of _test?

Sounds good, will send a v3 shortly.

>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

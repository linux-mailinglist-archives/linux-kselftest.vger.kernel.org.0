Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A8329785D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 22:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756267AbgJWUln (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756266AbgJWUln (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 16:41:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10A6C0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 13:41:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id h7so2367892pfn.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jRLKAOatzcRG4uv+zWWEBnrsrQv4zMb+2Jv/LTBO98=;
        b=PgeVBzkEvc5TURkeOJbp897PLpbZTfKIBG4x4RoJpcAAoU6GIptK+EiyApO8BhXHD2
         lSm1HW7vdPLPwZNTEHZlMv8/XJKsMt6pJogo/skFpzkLhsqUX8tGNJkQMm9CRDw9E+0d
         kOsCNqDaCIctmk+lk7Sqaow6M3EJhfMoSdsDeKKEIUP8I0v/SmHealcjTQfc8KRgoGD2
         Q5U8ppaOzxMcy75AuVfRe4POUgmc6sv5ROqYPkimkHtzox6J0pIpBq/4F8sam8PwyKjM
         4dUiY737i5q9hszKMOCBDIwVNtqa6SX610QqnUjyMNN6phcTWvQuekqsFlcfrKBzHvuY
         94Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jRLKAOatzcRG4uv+zWWEBnrsrQv4zMb+2Jv/LTBO98=;
        b=TAILd2WVyK3jrEk4jxU1+WKfUhqPrJTWsTydIYbqYS0a9ZonL2q8nfqSsDxapInOfl
         EkTnUcip6pY8pOsrl3+L61V0pE0bNR8NEuN0gdBl9h2HtC551NZS6Vl3ljLUyDh7lyk7
         2r6AL/RnFdBwBy8n94adQTX0Y/hhm/u9cFi++7SQ460g/+80vIi4WMtYeuWRjApL/Ziu
         l6yqwRUfkqun72V05LW/x9IOxO+EAOlLisNbl+Mk7WWRDObaCWa3i7qbovAdf73MzGK6
         O0mPkQctpIZu6KVh/TYbLbML5xVFOoZpzCa1QMFWtWNMLuDyLfLUNdOgyqA3LQYvl4YD
         rm3A==
X-Gm-Message-State: AOAM5333Uh7KTYrmSbEioJl7CSso+04htxOFguzczXXnVU27sM6I2Gkz
        0an3AgYW6z4akNnXr/ZIQ4RcZtMT3L2Ipz6r5ByZ3g==
X-Google-Smtp-Source: ABdhPJxUClnmi/c5pRRsR8HQHwAXhcyVCuGHIpT1ObPnfmWRxCxokBtbpwajmCwCAz/Ct4RAw/l6Qunt83ffqNlKfPY=
X-Received: by 2002:aa7:808a:0:b029:160:167d:d332 with SMTP id
 v10-20020aa7808a0000b0290160167dd332mr888781pff.1.1603485702307; Fri, 23 Oct
 2020 13:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201015152348.65147-1-andriy.shevchenko@linux.intel.com> <20201015152348.65147-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201015152348.65147-3-andriy.shevchenko@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 23 Oct 2020 13:41:30 -0700
Message-ID: <CAFd5g47snMFts+HpAqMbvqndjqO3L4qVho=5kg+d5o4Arr_woA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] kunit: Introduce get_file_path() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 15, 2020 at 8:23 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Helper allows to derive file names depending on --build_dir argument.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

Greatly appreciated!

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CA4294420
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Oct 2020 22:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409668AbgJTUzx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 16:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409666AbgJTUzx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 16:55:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F555C0613CE
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 13:55:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so98822pgg.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ughCnz920zM3kXotBSOWpKvYEsoSLtv0TW8ecw+wFbk=;
        b=f+ST+251C/yNDeCpqRnJppKbpm1+ydKfGMqUh6KtGwWN8Ras2vO3Mlwe8q5UaW7B+Y
         y8N7myJTriwjsjekRW0xJxQ5F936y1untH6vwnBvqI/DNTm83zJVUUXwDbilutio0SBo
         82aC6YKIZoyN8f8NYr8TEfeuWFRLrrkrlr6Qb6k1jxlE4tOOxMsf53VveYXQv30HCyRe
         oU7YKwF9tvv51OxMrp3eBuu+dgyANeCu4Z038a4Z3g3eDy97s10N/tLgdDIvQbAKwvAr
         ZmqJD4tONxwtiRuBxKrQchU7xCWrcNXcZKs+cvR/bVmvKIwGIlEMidKXPVa6ZMOgOQkA
         av+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ughCnz920zM3kXotBSOWpKvYEsoSLtv0TW8ecw+wFbk=;
        b=JGQR7J/wIsQuCOEQY7bp1uNmKNKCI9aV2EUVV0DppkpXRcfeG8xPJqei8Ri/97jJ1h
         ezNzP8E1D60huZ3lVRSG3lrnWbw07lmmGnDzvS4kG95+ZhO2Qg6Bg9jHAe2INALA3PVI
         Q3XUit4E9hiLTpNg7FafxZfy66KWi7L4dQ3QEMM0qslUfHZqgxdKCGFTDyyJpkMSJrGF
         u693bu6XRohlT4Oejterc/eyGTe55tTPvbVWd6GA3RzuFC9o0sbm++/iMGMKvc3nUQdb
         6XxF8qsU0f2iPqRHAUtmWECoqnRh4mJY+Y31C/ocd6JdE82pfOMop/R2+Q+VlIoytWDp
         3u2Q==
X-Gm-Message-State: AOAM530fK2y2yBjTFOM5lzRmWHrq//eNP2sFRiEY4ID6eAo5F0/tcw0h
        othheAfXqIRZXlnt0WRPJPp/rJmPS/i5ZQt17S8flA==
X-Google-Smtp-Source: ABdhPJwl5CSFohtj0sHVoQlZjDSA884tIp5yVRVcyJKbF2oPvroj1GM307dCatD3ZKfSWf50HiSnnOjChoa2FHh1FxY=
X-Received: by 2002:a63:1e5e:: with SMTP id p30mr143936pgm.159.1603227352837;
 Tue, 20 Oct 2020 13:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201016110836.52613-1-andriy.shevchenko@linux.intel.com> <20201016110836.52613-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201016110836.52613-3-andriy.shevchenko@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 20 Oct 2020 13:55:41 -0700
Message-ID: <CAFd5g44a+1obcC+SxMC9WkV08_gtRpX0Me=9r9Br+iWyKxn3OA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] lib/bits_kunit: Follow new file name convention
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

Acked-by: Brendan Higgins <brendanhiggins@google.com>

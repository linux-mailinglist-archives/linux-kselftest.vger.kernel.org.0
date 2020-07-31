Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C66234D68
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Aug 2020 00:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgGaWCe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jul 2020 18:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgGaWCd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jul 2020 18:02:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC203C061757
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jul 2020 15:02:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so18039443pls.5
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jul 2020 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+oZo/9yW6Oqd3XkygyTtSo/s5WeOAvnnWz6QWKpx224=;
        b=N3yiD5UX+cR8QG4jts4p8h7nRXkfrAJtBC0xtfsVUV82LwaqCgMsXSBhUCwDJcJzbs
         mdahkoCEgT1sDyvHx9Y5FbWfXPDrIz13exeN+T1lkU1vAkeIA0lFp3l5iwgZjcqqHrl/
         PNH02FY7/0pKPEKzsXmiuWhLaGzNca95VHWwE30dAZS3a9FPmFnWI/VZopd3K6amWRj1
         vy6DazkMnzG6LR3qsz9x86pKa/WGzpTTXOjH3gs389randleAtOgHKrTf1OW8Y0DS98q
         YohnolyZJAxVW4w13084HdqFr+oEnqDHSWKur7Pvm8zMukTISaPPp9EyWHw330MCtEgp
         e9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oZo/9yW6Oqd3XkygyTtSo/s5WeOAvnnWz6QWKpx224=;
        b=OImbh+hT6T+RP4aqIlECRla4ajoJWKxjEC//Gxr8xEDJ/26wl2uVNBIB7pcvBg3dBu
         EVsUmyWEAykRASD8wqaqKGk/rgn1tqrjyG8oXZPmpDZ/htNYxCl/fzcBwSBjXaTtEogI
         3sbqXYyXjovFiBQ8f64+DwkHU3GKKVhy3kWlJ9AVEN1qtf/+gCJltc8M8W4G8PYesaBE
         c4wy043CJ7JmYDPUy5bUGucmZLkXzY4uhSgQpcVTuDMpqQlfbX893yri1MSa9x0xQnvB
         rfLFBu6Hrb9oMs4kEnxR9ASjslAhKAJEOsDYasuEfi/h9eHbRCYsO4wEFrBy0XmYHTT6
         0ZhA==
X-Gm-Message-State: AOAM530jC78WR+vOg0U8tkGxT/tdRxZhTs9+QLDb7m1mK0aalGf3C/VV
        IcnMghSObUgNQBUZglb1nsaDMSgnUqtWobF+6B13lw==
X-Google-Smtp-Source: ABdhPJxb+RpjHPrJNGDZfqqztRJW/O3fXdm2dXBzLYFHBMbAPCDbg8ExMB3zSjKygRyZPsE3Jd6zAnVmTf8B72/3F5s=
X-Received: by 2002:a17:90a:33d1:: with SMTP id n75mr5066872pjb.217.1596232951079;
 Fri, 31 Jul 2020 15:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200702071416.1780522-1-davidgow@google.com>
In-Reply-To: <20200702071416.1780522-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 31 Jul 2020 15:02:20 -0700
Message-ID: <CAFd5g45-UmaxBoNa9pY7LwOrDsRXN46uCO9JvK_CHNhfYdwS4g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Add naming guidelines
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tim Bird <Tim.Bird@sony.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 2, 2020 at 12:14 AM David Gow <davidgow@google.com> wrote:
>
> As discussed in [1], KUnit tests have hitherto not had a particularly
> consistent naming scheme. This adds documentation outlining how tests
> and test suites should be named, including how those names should be
> used in Kconfig entries and filenames.
>
> [1]:
> https://lore.kernel.org/linux-kselftest/202006141005.BA19A9D3@keescook/t/#u
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Sorry for taking so long on this; nevertheless, looks great!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

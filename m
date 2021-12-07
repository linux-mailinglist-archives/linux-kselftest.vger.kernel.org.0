Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635FF46C419
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 21:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbhLGUGp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 15:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbhLGUGo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 15:06:44 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2AFC061574
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 12:03:13 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g16so82828pgi.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPlDrqxX9glsFDNE5urmxcji6mmh27t1zhykSBzc3+4=;
        b=DwYKDw7mrISzgN6YcNSbjtcTvRqlGK4z7W8Abkgm4r+GH4t4tWUekayNyjAjqTigGX
         cAkH+JYp1lEZYn7hAmn9qWqg9Q/Rdc2r2QNtNbJdRk6ftjCjY/hdlc1LzCF6V40YwF3o
         5o2+DFXg8rqVm4RhZ3Z8srZkDBWW8MpsJZNDEzkTuy8D6YtLg+2RPKdH17UwXMBGW/AK
         Rpm7lNXYVEaJFICxargBMVPWw5zrkWH5KAKyGjPeEJu02a1i4bRquWVH5xyRFymBkI+x
         1tbTdP4bAYapQAS15k/TBfgYY8lEZt+YukA1TOXAqBH/AZoBEbIgdJ9i0UvqFJJH8Z2S
         rCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPlDrqxX9glsFDNE5urmxcji6mmh27t1zhykSBzc3+4=;
        b=Iz3ItHTXrDkcsOde1c2zrFK/SUO1SHwh3hawCSqmIkBI/EU21oLr9Nq+VsDFS5LIIO
         O9M3ZdswSrqH7utPejbSFTepV7iXncVVpogQOOUYF0/b+b1aulUYErvmAWyvRo7/k+Ru
         1p//HnZnJ5QWLWMzkYOxjdMRfX60t82EUeFv6qa3ck7nS5L4BafhyilsgXw+On2hS4PN
         lcks7L1KPe+YNc2f4Rlj25B+q4/YekDdlaLnc2ZnCZRIiFRiGIaKNIokJg3llVTEwmyB
         8i9jPCPYT6AO38s45SUNH0ZORy80rdU+M0gmkYXKhW+Jx0r7pR55MZE3NAS7//wOb5uF
         yoTA==
X-Gm-Message-State: AOAM531u4oTrRwiMi9kgeXCDi0gyGr0qnVfVcUEte3Iqj1YIIRYNb0uv
        3st2d3ZvYvX4FXi2bDpDLsQzFF0LCACmD8oytq0Vmg==
X-Google-Smtp-Source: ABdhPJyrqyvDyR8ElGMsnU8zJbfhfxnOetzt8CQ7ogfrSz4HwYRUxG/SEdosfDHN9tpGr24CjLFOVjCW/8O3KZbSatE=
X-Received: by 2002:a63:3fcb:: with SMTP id m194mr17010266pga.407.1638907391992;
 Tue, 07 Dec 2021 12:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20211008232421.1264857-1-dlatypov@google.com>
In-Reply-To: <20211008232421.1264857-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 15:03:00 -0500
Message-ID: <CAFd5g45o4B=qxsLqrcSWfs19JBBFVhwYUxYMET7NoL9zFBaNxQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix --json output for skipped tests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 8, 2021 at 7:24 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, KUnit will report SKIPPED tests as having failed if one uses
> --json.
>
> Add the missing if statement to set the appropriate status ("SKIP").
> See https://api.kernelci.org/schema-test-case.html:
>   "status": {
>       "type": "string",
>       "description": "The status of the execution of this test case",
>       "enum": ["PASS", "FAIL", "SKIP", "ERROR"],
>       "default": "PASS"
>   },
> with this, we now can properly produce all four of the statuses.
>
> Fixes: 5acaf6031f53 ("kunit: tool: Support skipped tests in kunit_tool")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!

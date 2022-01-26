Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D011A49C0F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 02:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiAZB6q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 20:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbiAZB6p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 20:58:45 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D309C06173B;
        Tue, 25 Jan 2022 17:58:45 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so3378897pjj.3;
        Tue, 25 Jan 2022 17:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7l440JU9yQL9C6gxms9696YV0ZqO0kyEY+YBmxF5sM4=;
        b=HwY0hkZToWD1ibN4/TJjzeu//YMYeW1l5caQpPLfCapOarxdUJYiSND3g8ecslD7FJ
         7MDytKmxvLrLNCQ1OjBypu9cwGbiCTdauBEPSH7plX5wOgl718BkmChrHMpMkquWLYd2
         yK9z0z9d+1hGnjJDTzfVlG1EZi7wNkBItYwlZZ+IRAiZ391ZE2hdabJI+D1lHIDqP9m2
         RxjC5GkbrZ5tc4s/O7ckvjgZhD7CnEhv9QMAXNk+n+dBZgctnls0EPeXBst4xpGS+eo+
         DkJNe6yL5pydzu4BNBvYUxwO4SH8MEIKn27J0nVdipR4OUp2OwGDp9TIGEY4pVW7t/Zy
         P8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7l440JU9yQL9C6gxms9696YV0ZqO0kyEY+YBmxF5sM4=;
        b=weovfgLg0hH6cC9h8HyOOS5qIfgI47qy5oVh3kCh0eJww9HCtVKExZfDx3K1E5YuOr
         XRs6QlzINtMfM+hkDiJgW/zWYdzYSm1g3mzmAbLlxlrXrRvGGREbuZbVnMZjlUSYvE9a
         u/LVBFfmbF0SSc8f6bATZCrWT6Augy9GoF3kD7hqQdkIKL4g6Tf9CA0+DhiwfrYLRcMF
         pZ2HBPqPeVh1gX2JKukF1hAEmr7esnLFI+5rBX7PLEzSN+O1iV4DZaJcb71H4jX7gfZv
         6WqXy+zGBAvvzDq4w0v1PV1uGZKkulL/hBAKtz1DRJFwjQnaGH90MvZ3i6E3JWmE0FWF
         XR0Q==
X-Gm-Message-State: AOAM531/+woZ3/slsFD0sfsabqIjnrYbDRzIFwRi2IQGy8tgteKKeVNG
        tLDy8CtCG80KKssyBOdFz1BngqaSRZC5hF5Tka0=
X-Google-Smtp-Source: ABdhPJxmHmHSN4JMY9df8KA8bRi9AAxpqYVqGcEil4jbcmX+K4D2hm7cKe1r+FVuvJ62eQMwklwNEB9jwZ/E5geYRjE=
X-Received: by 2002:a17:90a:c78b:: with SMTP id gn11mr6527653pjb.138.1643162325125;
 Tue, 25 Jan 2022 17:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20220124153028.394409-1-sean@mess.org> <22f46323-4443-4253-7153-546fbbbdf40f@linuxfoundation.org>
In-Reply-To: <22f46323-4443-4253-7153-546fbbbdf40f@linuxfoundation.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 25 Jan 2022 17:58:33 -0800
Message-ID: <CAADnVQLCQ-benqrbwBrM2VUuSPd5Nv6Au2W-j7uJKhrsEUDjwg@mail.gmail.com>
Subject: Re: [PATCH] tools headers UAPI: remove stale lirc.h
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Sean Young <sean@mess.org>, Shuah Khan <shuah@kernel.org>,
        linux-media@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 25, 2022 at 9:56 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 1/24/22 8:30 AM, Sean Young wrote:
> > The lirc.h file is an old copy of lirc.h from the kernel sources. It is
> > out of date, and the bpf lirc tests don't need a new copy anyway. As
> > long as /usr/include/linux/lirc.h is from kernel v5.2 or newer, the tests
> > will compile fine.
> >
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >   tools/include/uapi/linux/lirc.h               | 229 ------------------
> >   .../selftests/bpf/test_lirc_mode2_user.c      |   1 -
> >   2 files changed, 230 deletions(-)
> >   delete mode 100644 tools/include/uapi/linux/lirc.h
> >
>
> Thank you for cleaning this up. I think this will go through
> bpf tree. Adding bpf maintainers.

Yes. Applied to bpf tree.
Thanks everyone.

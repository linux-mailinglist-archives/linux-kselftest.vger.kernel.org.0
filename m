Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEBC48A2B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jan 2022 23:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345373AbiAJWZT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jan 2022 17:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244885AbiAJWZS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jan 2022 17:25:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B519C061748
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 14:25:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 30so57957062edv.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 14:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8TsWXEfioEfTTK1VDo1lBOqjBTxLrtfK2ag/gwU0Pqc=;
        b=oJ/N1I5VcUaJhr7iJ+kzTzypJazZyuPseg2YMALCEdLKvYFIJxCSUmNV511Z4kpZVk
         JzmcBEe8o4qej9RH1rHOkiB723+S+Rmj2OVk9MYKGurCoA/1XwJSO1kUg0ZsvZepBW/D
         DaigJame+QZp3TU/9fmf8yHIesGHhBV8YwvYJ8ToK6+a5QNPuNdCwbp0i56ynigKr61y
         G3YKkmku0KWvDv4CQf392La3PGTfXW5lJPTuEIcg9I5mbVIlL1PlzUPcM+8BBNvyXZzP
         iSGJlPlNl/Vu/IkiWoC1ThZFlr3UPd7zmnNNqVERmxSNH8ezGAmv6maQMm0UD/OIwx62
         u9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8TsWXEfioEfTTK1VDo1lBOqjBTxLrtfK2ag/gwU0Pqc=;
        b=y2H+iTXvTpupmUiTWkKSSygEi6tnFe+oHwL0iD0bZ4SjtzQmE9ftGlS3yqv3nnqM4S
         zyZDKY3k8kA+ct1rfU1riybE0uzbmLYlOOyMhOQvpO/SDvV7c8EtFSjxZ38Eb4rsvMID
         HlCaKCDguU2hADKgBemWQ1A5y9ffJIgaWD7a819MglRYflG6okrk30MslNUMUrhd9yge
         yfADevLveUjjYmGefFxVTnSOIZ7/GteZzfKLuTnScL23wKGQjkgAzDG9cC0+xQX0GWSU
         hxmUVwjGDgDB4XIZsS5OwDRYU/LWb3u7gUZJtqvW1CHxCgQChszGf56mn7alCFEipRBY
         rS+A==
X-Gm-Message-State: AOAM533ClMlrIkW6RFi+QFRFr5bc5G23k4MTghxV7E1cptfCIQw7AYsm
        9xPttADKmB+jBWhM5JVStup5+qBsrqa2sfUSq/lyrA==
X-Google-Smtp-Source: ABdhPJz/NhDGIg2gfV2mdOsT01yHlsQNq5QJDnIeRGtDliqArx9qwtiFbzpMs4IfWW2ENR4oBVpBN0uZZs3adk2GwAs=
X-Received: by 2002:aa7:db8f:: with SMTP id u15mr1681805edt.36.1641853516933;
 Mon, 10 Jan 2022 14:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-2-dlatypov@google.com>
 <CAFd5g46RUc-v0GmjAEFggmgMxE7Ya_MCwMPO4YMEuFac49XLAw@mail.gmail.com>
In-Reply-To: <CAFd5g46RUc-v0GmjAEFggmgMxE7Ya_MCwMPO4YMEuFac49XLAw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 10 Jan 2022 14:25:05 -0800
Message-ID: <CAGS_qxo63enQyrEO7YOL75oGUsuzbntty-C60Z+==L59qKyBtw@mail.gmail.com>
Subject: Re: [PATCH 1/6] kunit: add example test case showing off all the
 expect macros
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 10, 2022 at 2:14 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Jan 7, 2022 at 8:23 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Currently, these macros are only really documented near the bottom of
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html#c.KUNIT_FAIL.
> >
> > E.g. it's likely someone might just not realize that
> > KUNIT_EXPECT_STREQ() exists and instead use KUNIT_EXPECT_FALSE(strcmp())
> > or similar.
> >
> > This can also serve as a basic smoketest that the KUnit assert machinery
> > still works for all the macros.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
>
> I still don't like how much this bloats the example test; aside from
> that, this looks good.

Agreed, it does add bloat.
I just wanted something *somewhere* I could use to smoketest the later changes.
I just remembered how people weren't very aware of the _MSG variants
and thought this could help.

If others have a preference, I'll happily move out and into kunit-test.c.
I'm fine either way as I initially was going to put it there to begin with.

>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

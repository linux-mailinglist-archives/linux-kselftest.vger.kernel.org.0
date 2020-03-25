Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D41191FCA
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 04:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCYDdt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Mar 2020 23:33:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33556 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgCYDds (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Mar 2020 23:33:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id w25so1150349wmi.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Mar 2020 20:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KxuOmdAysRZGEQNx/Dz1PYBDsyTNUNG3yM0/E844o6Y=;
        b=c/J6KOmODiexLZ6eE+Q7byqMIyfu4FnkpMeZwi5gE9T+/EA75ajNsvHCRlueB8QnOi
         UPH8CyFpthAFT1RAn+oSq/Laqhiwe6iz0lX7V2b42ZkgmNolMn/u3meMsGuTQbge2lpp
         ECvXCaPxDG6m+v5esskixVqrVPEIYAA7iS7p6u2FfOzeUw4mG9fZRAgqwXG7LtrrCpGT
         3lVVkWYDpuelkVF2ocK7K8t4uYPDASeO4vKQx1HN65+vgysWC1Z1hF/d5f4Hvk9IVzCI
         fDsV+k3bXspeMm+Vn3P0QQY0qDG0TY9jDmp0e9+0x/8iM7qlf0cGS4OOoOI+iNa8Qkjj
         fSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxuOmdAysRZGEQNx/Dz1PYBDsyTNUNG3yM0/E844o6Y=;
        b=oG/m22Dl1A3G4XqctWsLU3DAmMgwGSAd3tiMiH3uoszUv8CzN0/VpcfB9MMZo44Y1N
         Z5Qt7sihx6jQZGtNc7ju5ST2dP5nV7PDr+AFiIxsPHKCpYMjYO1eoGtPHYOoU4unyCgF
         LxE1q7iYkqQfR+oZjqFpV7wld6G9hHVtDFY0alGDqUDxZa1HxfYLvMH39UkTlrkF14Ss
         3+glNjuI8xK3w375MnGCM31En7pnghAm7I9ZKorrY2+rl9SdkXIusP2RU/LON/mJyaoq
         IZLSVVPIF//m+iMY2Kbmsw/fqQfAqaVinVOYXMHlWit/jek75QdjdHkQbhH6lhMQj8wn
         UitQ==
X-Gm-Message-State: ANhLgQ3L1jb/k2IrKSGkgzVvIPxJ87euDAAniI5pe3y/wSh+sECi33ne
        dEG8G/Mn9kpSyIG7dQCKk6EYLEkU1W8r3lCy7VLUqQ==
X-Google-Smtp-Source: ADFU+vvrBb5PDQiiE02yCmnPwWoxH59MspYVlbdbbf/I+hPVZDRTg4mNSNtH/SjBeMYgKror/eSj+SfdIbQRCwyOkKM=
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr1147213wmg.99.1585107225177;
 Tue, 24 Mar 2020 20:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191121235058.21653-1-davidgow@google.com> <CAFd5g46Z_vVb92Y-sfWi68=HFy5+kukZXvT9usEEnhBUvPg3AQ@mail.gmail.com>
In-Reply-To: <CAFd5g46Z_vVb92Y-sfWi68=HFy5+kukZXvT9usEEnhBUvPg3AQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 24 Mar 2020 20:33:33 -0700
Message-ID: <CABVgOSn1azUN4XujHLsc3NY9fOUPB4Vw6930zc4oR26kxqrwOg@mail.gmail.com>
Subject: Re: [PATCH kselftest/test] kunit: Always print actual pointer values
 in asserts
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Kees Cook <keescook@chromium.org>, shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 3, 2019 at 3:44 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Nov 21, 2019 at 3:51 PM David Gow <davidgow@google.com> wrote:
> >
> > KUnit assertions and expectations will print the values being tested. If
> > these are pointers (e.g., KUNIT_EXPECT_PTR_EQ(test, a, b)), these
> > pointers are currently printed with the %pK format specifier, which -- to
> > prevent information leaks which may compromise, e.g., ASLR -- are often
> > either hashed or replaced with ____ptrval____ or similar, making debugging
> > tests difficult.
> >
> > By replacing %pK with %px as Documentation/core-api/printk-formats.rst
> > suggests, we disable this security feature for KUnit assertions and
> > expectations, allowing the actual pointer values to be printed. Given
> > that KUnit is not intended for use in production kernels, and the
> > pointers are only printed on failing tests, this seems like a worthwhile
> > tradeoff.
>
> I agree. However, I also remember that others in the past yelled at me
> for assuming that KUnit would not be built into production kernels.
>
> I feel like +Kees Cook would have a good opinion on this (or will at
> least CC the right people).
>

I'm tempted to take the silence as a sign that no-one is upset by
this. Otherwise, consider this a gentle reminder to file any
objections you may have. :-)

Otherwise, I've confirmed that this still applies cleanly to the
latest linux-kselftest/kunit branch, so -- assuming there are no
last-minute objections -- this ought to be ready to go.

Cheers,
-- David

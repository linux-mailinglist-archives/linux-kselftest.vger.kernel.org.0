Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5571F9D83
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgFOQdy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbgFOQdx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 12:33:53 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBBCC05BD43
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 09:33:53 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y9so8030506qvs.4
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DyQ9X+CHS1SbCZvi5JD/ErZwYHtp+v8iH4fr/ScY52w=;
        b=C4AOwykjBsPT6pKnY+hXtp39Kmr6gtq4gDm7K6Z74U+ZNCtJOjUSpj3bIH7cVR0LqA
         RoUCurTh+rURQM/ZR4ygWRtfhmA3n5kfffLc01eIxcj/0aGRqIsOBkT8sUb77MAJK7Xz
         OisRXR8OKn0QIEwELDc6BQRhqPFD6TzrM5N0LL1nQ/jourBpdnQEIcN3FwU+UiSL6124
         6fXFxhrWHCldh1IadWF3LiIoZqJ53nP4vYa9P7hzytZuWUmWBLeld32fOcD409DHI7pG
         qWnWAnhnR0sXkwSifTAQBdmrLNL0SiGig78/sn9Qx25FgP6/vFjj9J1CQjvmtzqS+gkX
         7Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DyQ9X+CHS1SbCZvi5JD/ErZwYHtp+v8iH4fr/ScY52w=;
        b=M37vKnP7RrERw4R3s5oUoI5CrdXl/A/DsE7GfemsCmF2OsZSCk/8tSyKCbTWNnQBUA
         KtrD3U6bMjxUxM0PAVt2r459r9txhHWNSwAMMLTSwDhi3WehVkwNjZhqVdi5n0qldSpX
         8h7Mlp+uHfkmoVsnknuwR0rbIRbOubBhwUR/Cb9HHHL/Rg+sFJam2B7kBMaJY29xVn5O
         j5Fs4qszbSD1hW8roosjP0Y1XKb2XVnJsfdglvWLzT8GF3k2Roo75KQmODbtOLjKswi6
         bQUpTJnwo/sEoANDEcMS3fLo/tEzQg/L/pFBVaPp99lJTpG1gP4IqqC6bz+i+1CHjw+I
         ervw==
X-Gm-Message-State: AOAM5319s0QxMg50wQVWofGO6xdlYZbaBygtWEIm1OiK/AeCO/XFXfhE
        dkPOsk0gQQFwQZpYf9djXVIqrA==
X-Google-Smtp-Source: ABdhPJyO/43VFF1QL1zf8f7VKdmUjzSRiSNFeHxeop6ApwS13C/gHwt/b15Uc/m5ORglfdyrvvI8Vw==
X-Received: by 2002:a0c:e9cd:: with SMTP id q13mr26164373qvo.23.1592238832266;
        Mon, 15 Jun 2020 09:33:52 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id h19sm10770272qkl.49.2020.06.15.09.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:33:51 -0700 (PDT)
Message-ID: <b16c0402d866f8a8d5b135086ad93a5a2608e939.camel@massaru.org>
Subject: Re: [PATCH] lib: kunit_test_overflow: add KUnit test of
 check_*_overflow functions
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     David Gow <davidgow@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Kees Cook <keescook@chromium.org>, linux@rasmusvillemoes.dk
Date:   Mon, 15 Jun 2020 13:33:48 -0300
In-Reply-To: <CABVgOSkMv22GDGin8GCqq4Vd=Bff7-VzEycmzKhUeKj9tErD7Q@mail.gmail.com>
References: <20200611215501.213058-1-vitor@massaru.org>
         <CABVgOSkMv22GDGin8GCqq4Vd=Bff7-VzEycmzKhUeKj9tErD7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 2020-06-13 at 14:56 +0800, David Gow wrote:
> On Fri, Jun 12, 2020 at 5:55 AM Vitor Massaru Iha <vitor@massaru.org>
> wrote:
> > This adds the convertion of the runtime tests of check_*_overflow
> > fuctions,
> > from `lib/test_overflow.c`to KUnit tests.
> 
> Nit: couple of minor typos here: convertion -> conversion, and
> functions -> functions
> 
> > The log similar to the one seen in dmesg running test_overflow can
> > be
> > seen in `test.log`.
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> 
> I've tested that this builds and runs on my system, and it all seems
> to be working fine!
> 
> Tested-by: David Gow <davidgow@google.com>
> 
> > ---
> >  lib/Kconfig.debug         |  17 ++
> >  lib/Makefile              |   1 +
> >  lib/kunit_overflow_test.c | 590
> > ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 608 insertions(+)
> >  create mode 100644 lib/kunit_overflow_test.c
> 
> Echoing what Brendan and Kees mentioned, it'd be nicer to have this
> replace the existing test, both because there's no need for redundant
> tests (one will get out-of-date), and so that we can have a nice diff
> showing the changes made as part of the conversion.
> 
> Cheers,
> -- David

Thank you David, I will fix your suggestions.


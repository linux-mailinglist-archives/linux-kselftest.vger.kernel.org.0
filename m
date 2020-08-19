Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0707324A949
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Aug 2020 00:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHSWYW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 18:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSWYT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 18:24:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F7FC061757
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 15:24:19 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v16so100051plo.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 15:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwKR6nVMsgYYs/B7Ul4QvpDyXnAKjHXbGGpIAyK6X6A=;
        b=IgLyJH3u6Pz4eV0GcQ4tlmNWV6kzDzfuGoD+/a6GpCiqCtVC+j1xHuuYijwL6FZq/3
         TDESwYKf3yzfNnjm3z7RJ2F62YellEDt0uk2noFYmd1VgZSTm0JztjjvAb1Hzr/DWkR+
         BFl21K4iOfyMqMBETpIo0Apy6kz1jT5UqL2iuDhSCx7doo74ztudwuykQZz1GapAMcAw
         zcR6BNWyRPRo8dXqdrNwVsQunwtWHDqvU2ENpyzgCNP2pKMmGHGb0SQfG6YTDcN4sHG+
         Jw2ju7j6tF1wKpuMBVEBe+C34LG0P6uKL5Z3EPnzNqv8cCQbS1RDHlQosW/9oyALWyhb
         xjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwKR6nVMsgYYs/B7Ul4QvpDyXnAKjHXbGGpIAyK6X6A=;
        b=Y4ekHRwOCEm65+DxPFsaOnAs6xzl/bBES/lRHZT2AGhoWjzSKSZooAMXYbe2sFJiB2
         37GaMHFEeKY3deoi/SkwhLYojKpeT2vnEFVLnkf820fJoZMS5vGbGr2/jrZPgz4Uy8Uz
         +fcm8jOdOW1QlXwYCAhyzO+mHuLZWk6lOifpO+hQQczLkla2Y2hvMSRMxVJsBFDNfYLp
         5wARRaR2PmEHx15GJIplK17agANsdU3NCfBtL2naEofS5+0SBEb7HQOuoAA7pnEnAbRN
         WskX6VxyWg2yKp1EOsngN3gPz34MkHESorgH9Nqpu6brRphn8vNxUbtKlj8xQfHbmu4l
         iTBQ==
X-Gm-Message-State: AOAM530Q/ayS6QeonSpnsCie/eGjE54VzYepHm6L5iU+HiyyU5EQ+6EL
        PV8akfE2A0Xz3hyr8cHcIkGSukI87gYTRlO+4XFkVQ==
X-Google-Smtp-Source: ABdhPJyjxTBnEsfMorPrBFzUbmi+b9Ju+01D9r12pOISge3wUkXvOjxPz4AqmsYd+WBIAuVXkXNsZyrEPIZiAw9c9pI=
X-Received: by 2002:a17:902:c382:: with SMTP id g2mr201443plg.297.1597875858377;
 Wed, 19 Aug 2020 15:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200819193917.67409-1-vitor@massaru.org>
In-Reply-To: <20200819193917.67409-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 19 Aug 2020 15:24:07 -0700
Message-ID: <CAFd5g45_6mA7c4Bu9jSigEzeGqQgLz=o5v6VrSM7Qx39c_WDFQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Customize KUNIT_EXCEPT/KUNIT_ASSERT Expected messages
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 19, 2020 at 12:39 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> In some cases, to maintain the consistency of the Expected messages
> with the original runtime test, it is necessary to customize the
> Expected messages on KUnit.
>
> As an example test_overflow conversion to KUnit (I added 1,
> p->s_of+1, just to fail the test).
>
> Using KUNIT_EXPECT_EQ:
>
> Expected _of == p->s_of+1, but
>   _of == 0
>   p->s_of+1 == 1
> not ok 1 - overflow_calculation_test
> ok 2 - overflow_shift_test
>
> Using KUNIT_EXPECT_EQ_CUSTOM_MSG:
>
> Expected 0 + 0 to not overflow (type u8)
> not ok 1 - overflow_calculation_test
>
> Which is more similar to the error message of the original test.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

All in all this looks pretty reasonable to me; however, is there any
chance you could provide an example of its usage?

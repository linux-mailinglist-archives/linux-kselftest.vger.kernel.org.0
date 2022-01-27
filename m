Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B3449EDB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 22:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiA0Vqf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 16:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiA0Vqf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 16:46:35 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E671C061714
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 13:46:35 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q75so3441270pgq.5
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 13:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TG50uSRWADFMCidKIEoe1TGsn5hyGJMU5iaoc5tpHuI=;
        b=La8W9AQo2BMyfUFojDjFJFmWUntTca20Vv9uTNe9EVJoG8GzzGwwXSw3fQXhxvNeUD
         jiadJ51KjhTWOj9y76zORjpExtJq8sc+U9l5Fsg3C/PDQ/1VKl+ySr02sSYRU2burpCS
         +H3DTaV+4v7mMXl70M2ZjB7pHgoVoNGEHzTIslTe0qF4ktdI2GvfcPIk6qoWkLhtCvX+
         A+G2Q4eqy3XPDF32nZrUo0Ora9HzeV7BzuensceC42nnnVTtcuXGlgIvmmC3PqM/JJPy
         TmJo1iGCv9HZuES8b2O2RBAanHJVnDpjND+xeUVjyWS2yFcT7oQxNjM3jROps/5oMz1g
         lPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TG50uSRWADFMCidKIEoe1TGsn5hyGJMU5iaoc5tpHuI=;
        b=6WQrKSiXEQIylyrNKHjAuszrzIU1yfAwc2Qc0qpXXyA3XPyb87Gpo/6eHHaHymarzd
         mUAI7Ep3sfAVNDD4h5PCZamvkG4tc7k0jPu1e/VIQb36UK2MUXbldH9/8IUkmgn3oXRr
         ccDgZ+9qRfLhoGvckfzFFtsB4Dl1aYKcCCSQGFdBIU6pCiJkWTv/T/vqFYu23hxkmleB
         SZe3ao/+6dQXvG6ZDrPFicEBObbmGeD1tQ2E11HCKJCsNisf60tO4m2AC5oiae7fkUYJ
         5nU3a99f3G1BOrY4ebv+ITkvJ1/GcZrTgd3EVSCG+HnQnEMzw1x2m+u8WvU5Qf9ldA3l
         MdDg==
X-Gm-Message-State: AOAM530vhflq5LstFZcU51jrwECpXlKbKRUcjPsHRExIbv6NtDDD7Off
        gbagrw7OrpDxXO138EDylNbgUUiU4Lyf0qne7R3lVA==
X-Google-Smtp-Source: ABdhPJyhVA6R9ZmWZ8t7X5Ndfqsw7tvC+HDYQZJACHRXTzM/W6QJcgFT/wSZE7W542etYdXZhcwnM3JQ2hoqT33rFIs=
X-Received: by 2002:a62:e40f:: with SMTP id r15mr5193600pfh.24.1643319994226;
 Thu, 27 Jan 2022 13:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com> <20220125210011.3817742-4-dlatypov@google.com>
In-Reply-To: <20220125210011.3817742-4-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 27 Jan 2022 16:46:23 -0500
Message-ID: <CAFd5g45vmGCtnEgG1eQG02q7ayAULgJt3X=2xMma8tAmOH=WDw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: factor out str constants from binary assertion structs
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 25, 2022 at 4:00 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> If the compiler doesn't optimize them away, each kunit assertion (use of
> KUNIT_EXPECT_EQ, etc.) can use 88 bytes of stack space in the worst and
> most common case. This has led to compiler warnings and a suggestion
> from Linus to move data from the structs into static const's where
> possible [1].
>
> This builds upon [2] which did so for the base struct kunit_assert type.
> That only reduced sizeof(struct kunit_binary_assert) from 88 to 64.
>
> Given these are by far the most commonly used asserts, this patch
> factors out the textual representations of the operands and comparator
> into another static const, saving 16 more bytes.
>
> In detail, KUNIT_EXPECT_EQ(test, 2 + 2, 5) yields the following struct
>   (struct kunit_binary_assert) {
>     .assert = <struct kunit_assert>,
>     .operation = "==",
>     .left_text = "2 + 2",
>     .left_value = 4,
>     .right_text = "5",
>     .right_value = 5,
>   }
> After this change
>   static const struct kunit_binary_assert_text __text = {
>     .operation = "==",
>     .left_text = "2 + 2",
>     .right_text = "5",
>   };
>   (struct kunit_binary_assert) {
>     .assert = <struct kunit_assert>,
>     .text = &__text,
>     .left_value = 4,
>     .right_value = 5,
>   }
>
> This also DRYs the code a bit more since these str fields were repeated
> for the string and pointer versions of kunit_binary_assert.
>
> Note: we could name the kunit_binary_assert_text fields left/right
> instead of left_text/right_text. But that would require changing the
> macros a bit since they have args called "left" and "right" which would
> be substituted in `.left = #left` as `.2 + 2 = \"2 + 2\"`.
>
> [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
> [2] https://lore.kernel.org/linux-kselftest/20220113165931.451305-6-dlatypov@google.com/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

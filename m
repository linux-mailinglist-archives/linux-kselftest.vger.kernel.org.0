Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6353A2A82FE
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 17:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgKEQGE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 11:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgKEQGE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 11:06:04 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2001FC0613D2
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Nov 2020 08:06:04 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id i7so1691254pgh.6
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 08:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ovikxo5/mCGDynhuLKWYnfoRnCYgUGKva9i9tEWv1a8=;
        b=EdukGTkEV/UUSaIBNvoE9CM3nPrhkwXNUgIkCvYzGU0VXtYPQHBJpXLD3x6fJ4a9Qz
         sYOjmpLHcZfbS3iesTi4Y4tbT5H7lGvuGO2X8rTKMqV3MQmg80zvA38HlIG6ToEyqzcy
         Qbtt6XGtANWh3vpIDLlJyg5PHKGMxL+9bpc5lwm/mD02+zj1JbjLJyIjjWI6pwH4TWgM
         a+1Qv9WFfHO5mSay7f3dUi7/05jAdoWXxdOiSK1ybGn4OLLigjf6+qTiNcWYQlTCPLVF
         C0vHyU8mjsH3y2NVokK0nfjhiDGYXRSH9Tf1bJ+xuW6mREPmopu/7C1j0h6hq5VJrKwC
         Fzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ovikxo5/mCGDynhuLKWYnfoRnCYgUGKva9i9tEWv1a8=;
        b=kw4FgEd7/M5FeLhFZFwJQoTImNNV+e8R2vBoK/mY3lZChIObhfdv7p1V9BUyZ9GNhd
         pXqH6ZuS3h6bIAf808VT/crr534uN9XkCLG3gVig9HyFiddcCOqSigHtsPYbw+rPOheW
         X2ijMI6ysJUPbBbkFUl1rgdM5uolx9u7/jLcYcMqy5bohMp2hou6tUuijY7/VdYaK72P
         wExBr2T5cLyUx9Z4C3k9+zuPPTZjAgnYHwjWbwnRmqF/uScfUj1qaG1/EZcXbwRIcGos
         Za3Sb5e+/eunJqNF5c9ZowCcy15+QpRH6gkTx4Twte2/B6lASq0+auldDnAX0kebdYEi
         MRcQ==
X-Gm-Message-State: AOAM5317zkJqf7n7PyfznL/xSMlkULpmZ0ITPVjic7OIUe+LZElf3QTq
        HavAMKejghGPjIpGxjP/vosxQJOuM3Lp6nNQbE7MvdckNfpNHw==
X-Google-Smtp-Source: ABdhPJw7XeP0zBLiCad13iVrNNx/nweI/6exBCIWAlXy75ifcsZStyxYB7vo1jWnclPs0cEx6zaCYK9+QPFCzDvmGus=
X-Received: by 2002:a62:cd85:0:b029:18b:36c7:382d with SMTP id
 o127-20020a62cd850000b029018b36c7382dmr2838489pfg.14.1604592363377; Thu, 05
 Nov 2020 08:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20201102232304.2735187-1-dlatypov@google.com>
In-Reply-To: <20201102232304.2735187-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 5 Nov 2020 08:05:51 -0800
Message-ID: <CAFd5g45+XbduCH4oE8dBd-uBR2MZg7-w5tf7DghqGrvMyydPUQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix display of failed expectations for strings
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 2, 2020 at 3:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently the following expectation
>   KUNIT_EXPECT_STREQ(test, "hi", "bye");
> will produce:
>   Expected "hi" == "bye", but
>       "hi" == 1625079497
>       "bye" == 1625079500
>
> After this patch:
>   Expected "hi" == "bye", but
>       "hi" == hi
>       "bye" == bye
>
> KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() was written but just mistakenly
> not actually used by KUNIT_EXPECT_STREQ() and friends.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

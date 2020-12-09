Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A2F2D3C2F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Dec 2020 08:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgLIH3m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Dec 2020 02:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgLIH3m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Dec 2020 02:29:42 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4C3C0613D6
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Dec 2020 23:29:01 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s11so1082434ljp.4
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Dec 2020 23:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Zj5DPkVA+r8BY8grkrGXrKENzcJFViNC4dse1Xab7k=;
        b=Luy9ckydK7DY1T68dQx5nl2tqj9OEnzCw1O3NbTsjHebN8cyCaDcTGf5b3e/eBvhIO
         RWU5PJy+bNDKrfTYreYgC4KudXWXCkq1liTbqcIn6wDyeWeLqFv21eygfpYuXQXNl+sg
         ksx6uOXE5OdmvCPf5s+/yGDqyS+xeSxXqofUKY6tvKkt5VaxZZfM+EwH0BnQKIwvNtpb
         rV76jUrNhDwy2cAHeC4RZmMF6/DkdAUhA67higBnO7MT36jlK2/yr8BTPm/sNsXstuHq
         v1HK2dApLS4dDYA67nWLlHu4jd5LACrP1PoRkhfmMR6rd9IpMNNITsLy1lK+07M3Vrsu
         BMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Zj5DPkVA+r8BY8grkrGXrKENzcJFViNC4dse1Xab7k=;
        b=FkufbB1bX/QH5zqX19KWBfnQzkRXdNXdLPhAnqMEi0KAvOfp/0ni7aPQwnHilAZ2Dn
         FIl23Xhs16Km2kiQ3muCAEt/xOS2lPDq2Lp0SKrR9P9RW4R4OJ7Sj7QF27NlPAdBSoBH
         qOMWSpHK/JbL1oJdMfFAhV2m+cWGY7BRAE0FYcnWzebzptrK0QTQASrKVVTkO9/W39oS
         bT0SNyCnJHZvhnr7z5yH0EZxXUT2Mn1vzKuIcvdusA9RFDrKDbMXXJGL1wQrpBJz/trn
         dfUN+G1gErXdJTv/cAh6kkMpE/D0Yxb93OdQIdcH54/oK45DAoh9saC7Cmwi0R77Tdsd
         yK+A==
X-Gm-Message-State: AOAM531rX7h/nOk08us9uzzbEuYsWH8OlYhuVaqyhw3tHXYHtYdTIVHx
        gAI4sC9/Yi/DaUvODksOPPZZWzm+p7zoafRY0SNgYw==
X-Google-Smtp-Source: ABdhPJzBQTNsBD4F37AkZK4YDah2uQpxEAq65TmFGkEPRml5F0xa7RESyhXv/dbcUJQq6AViXQdh2UMsmHM8FXKK7ig=
X-Received: by 2002:a2e:8608:: with SMTP id a8mr528481lji.89.1607498940309;
 Tue, 08 Dec 2020 23:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20201208232102.339587-1-dlatypov@google.com>
In-Reply-To: <20201208232102.339587-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 9 Dec 2020 15:28:48 +0800
Message-ID: <CABVgOSkmXwWu0fG7vNqFaxxcAgJyVNpk1FPrFASkoYUWz8XMsQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: simplify kconfig is_subset_of() logic
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 9, 2020 at 7:21 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Don't use an O(nm) algorithm* and make it more readable by using a dict.
>
> *Most obviously, it does a nested for-loop over the entire other config.
> A bit more subtle, it calls .entries(), which constructs a set from the
> list for _every_ outer iteration.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
Thanks! This works great here: I didn't time it to see how much faster
it is, but it's clearly an improvement.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

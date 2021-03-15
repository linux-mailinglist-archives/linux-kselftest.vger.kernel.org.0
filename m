Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116AC33C5F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Mar 2021 19:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhCOSnh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Mar 2021 14:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhCOSnT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Mar 2021 14:43:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008E8C06174A
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Mar 2021 11:43:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p21so58408088lfu.11
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Mar 2021 11:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DD48jmwpS/DOMJEqNgD+LBmahi/xH86ma1OZAM7357g=;
        b=LxAlmpj1xUG6Zd+P7Suwy6weDFRdJi7MxN41VNBbahYxiGmdn0Np/CuhUtj227UnQJ
         Zz7/PWQdNKQaOQwbCq5tsq01rilcgYxRBvLbglnAALhKSgmRQzDyKXL50ZnkXhqwHmEc
         FgQoSEH42PoOhHYUKR9nRCbfMBQJcsKWgbJcL1IBAMTAkUQHcyn175vMCTUNqFL0ZlOF
         vH+p971NSiucZWcTI57Mq0sVWXNPApYmlI+JemwcIkkDc7fpCpyPbfuL4QXkSD9USMUK
         jkRnmHHqJijAkARiwIL7QIir6bOnU0CzE+CxcOQ4QpN9f7S4A6uN2imQBj8LXVDVKExF
         hf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DD48jmwpS/DOMJEqNgD+LBmahi/xH86ma1OZAM7357g=;
        b=b6S/CfLCl1M6yU59fv3fKkPKYw+fuOmgPz2vzkwjLtk2f7pz4bghhgCS7hgMPLouzU
         JExyEkjvLHUxrcaIfjd6/iwv5Zo/TluxXiX8NjqUw/zG8gjr98lzpjTaJFxzM9Cq3r6m
         BueVQoMCH+X1gB+X63RZ46ZtxA/f65r4rSArJGvqez6ztMZKnST9KrVXQGyarAoPCOd0
         oJUA4rxpOSSVvMEFO2farVVF8cd4eliVryg+tfBWvJ7waaG2N+vGZzlhMh00G67BRby2
         C/RHbdGnGHgvSEBU5UcOiJWytkk5hlJp9YEHMTondxyBgQLmV9Z7MxyTEWFR9G8M2f8p
         1YJQ==
X-Gm-Message-State: AOAM5320ZIPTJjcaK8BwrZG3CkBp2s2kaoM2EfkUvNp9C/79Mm71FeaB
        //PT1/ggdYRAYf62SZLxrAqMhCGDOtbTmYKo4gwezw==
X-Google-Smtp-Source: ABdhPJygq9VbyyyBC/5AYbYVjHICXwOtOEEEj0rciXGU/fdxwRnpyXdgfCe0dGUPw2WLw2X8PaTzgapfIW8SRSCvMiA=
X-Received: by 2002:a19:7fc3:: with SMTP id a186mr8317783lfd.626.1615833797395;
 Mon, 15 Mar 2021 11:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <1615795655-5560-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1615795655-5560-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 15 Mar 2021 11:43:07 -0700
Message-ID: <CALAqxLXaMMQe0kA6Ku9GtAQ515+MYk+Qayysejjxi_j_gxK_qw@mail.gmail.com>
Subject: Re: [PATCH] selftests: timers: remove unneeded semicolon
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 15, 2021 at 1:08 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./tools/testing/selftests/timers/inconsistency-check.c:75:2-3: Unneeded
> semicolon.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

No objection here. Thanks for sending this along.

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john

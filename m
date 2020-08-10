Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803052411C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Aug 2020 22:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgHJUeR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Aug 2020 16:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHJUeR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Aug 2020 16:34:17 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F604C061787
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 13:34:17 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z20so5697677plo.6
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fi6y7Sa5SbnYmUqQlnDkyIhg+d6nJKBI1tgep4DAWjo=;
        b=JOzJWw1gvAKYKaKRPYFB7PDEtf/ROnu9QV3IBnv1TSojh8rA4SQDXu2BYcVoFy3OG3
         /1S7ceSeUOZRQj5/KJ883IHIaMTeO3M9J24kHva8cgaCR5Xo6aJNutKKgpikvs/JeoOS
         qD4csJ4Y75B50acWG/yL6J9pEBmybt7v8yqj1t99J8SeLMPb5fVjmpF3NEweDhwEol7+
         7doyqvmCBVIE/HEX/VvDC3/Fj8js2/F7BA9vATzSbiESOZLA5bGVxPf8otGpMHEeZ2cY
         2Bvb4XNIcXVzWcv8UNp9R4bSO+yVHTbiq+zBUFC9KU2RWuyNhgX+FzYF2XEQnZDoadwL
         4/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fi6y7Sa5SbnYmUqQlnDkyIhg+d6nJKBI1tgep4DAWjo=;
        b=pAiYG4sNUJt5XP1jbF2tRnUVq/GebqpN2F2aJ/Jvvs1Sd7g0CEmnEiF6MjGpdTS2Y6
         SlcMO2RxFdNRgFtfILZIJF05o0gAcRHbkld1OzltrwqRgVRqQm0lhmec2U0QaKbbG0/m
         1PcoV5G3ZnirRJAUDDVvYXPUYI/vc5G9YqkHImOxDzOMytFKOg3imlkwRt1paBmi7q+X
         dXtwFewsGemAUQG7K+vLG1zhDuif0mhLYLT9UhW4UchUywKIhlVve1wh1OSipB/fSuqI
         CCXajFozrfmP4Fm+FOubtvW+DaCkusH2otwr92Sl9NeY3j0S7D8jRZvZhgDZpgw7k0qY
         jfyQ==
X-Gm-Message-State: AOAM5307D2kE4D1F05fLde6GlQ0Wp8HGWY0hwYs8kSn1KmZxLUBITDHK
        P3sdTLgyjQuz6EUWDNNwSh/OvB4OlGlu5TweyEgV+g==
X-Google-Smtp-Source: ABdhPJxBJws4QeAEFAf6sjIxEUPYhDGg0Xsa/WaYRrMREL2SAgkAMZcfy0aDWa02LoCK6HH8PIBVWT2GeZ8IUdp92VY=
X-Received: by 2002:a17:902:10f:: with SMTP id 15mr26409586plb.232.1597091656550;
 Mon, 10 Aug 2020 13:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200806203737.3636830-1-urielguajardojr@gmail.com>
In-Reply-To: <20200806203737.3636830-1-urielguajardojr@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Aug 2020 13:34:05 -0700
Message-ID: <CAFd5g44FgjeziOGbS=RphovQ=UYoPBRNjE7EuhWAdYFgCqsaQg@mail.gmail.com>
Subject: Re: [PATCH] kunit: added lockdep support
To:     Uriel Guajardo <urielguajardojr@gmail.com>
Cc:     Uriel Guajardo <urielguajardo@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 6, 2020 at 1:37 PM Uriel Guajardo <urielguajardojr@gmail.com> wrote:
>
> From: Uriel Guajardo <urielguajardo@google.com>
>
> KUnit tests will now fail if lockdep detects an error during a test
> case.
>
> The idea comes from how lib/locking-selftest [1] checks for lock errors: we
> first if lock debugging is turned on. If not, an error must have
> occurred, so we fail the test and restart lockdep for the next test case.
>
> Like the locking selftests, we also fix possible preemption count
> corruption from lock bugs.
>
> Depends on kunit: support failure from dynamic analysis tools [2]
>
> [1] https://elixir.bootlin.com/linux/v5.7.12/source/lib/locking-selftest.c#L1137
>
> [2] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/
>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

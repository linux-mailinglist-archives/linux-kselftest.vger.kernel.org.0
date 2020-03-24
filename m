Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4BE1918A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 19:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgCXSMg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Mar 2020 14:12:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39598 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgCXSMg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Mar 2020 14:12:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id b22so9432974pgb.6
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Mar 2020 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/d+L7ssZFGD9dUL+ow/dGUzskuUeNpi5SPqcS5kNRuo=;
        b=vCq7M3Tc1lLHXr9n/N862MpDzTCtytaQvIq+JmiawJy9j05bJoR2iqJNRAM1tStFY7
         P2W5/YEQ9QHDtl35ojZqvWsSn6l4gE1D/MbGTkRB1aeeTlTgZsFYJkbTHn2ln1WpODSt
         lk3xCCgJ3awYMY7rOou/PAr+QJRX5AAW5nel9mxbr5sXZveXLWYMDsBhfX0jqa6gFC6k
         OUKpH/jp6tfcgNmO9GsM2bZ7sPqeS+GuHn9OvlBg1D569qRfnJ67OWq4OVkEMQH5j7ZY
         Na6WqZ83FI6Z0RPLKZHqIRdQ4aiN1qaWVvQoqGr7CWxZCW83bXff+z6GWqauWhED9Nfx
         sXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/d+L7ssZFGD9dUL+ow/dGUzskuUeNpi5SPqcS5kNRuo=;
        b=UAYjXQlFmdJ6oI3fwjSo8NY9uKVEaNTIuXRug9KA0ptBdiWNQxITAYWjVH9nMcscmO
         Ttt7SGSIILSspJ04hR7/HG8Ggyp36sKwDCrZVMlNjy+SYZeO4ANDFtkQ0hW4d2hXA8lt
         IrfQIzKeJBaoGsoF5vFowVa1HYB3Fi7GjOsJdyvaIvpyeToYnVlmXmIwJibAE6hRDDcy
         kLdlVVKgeIaneQwz6e1Fte45kWwmXDV98vLeTYQ31AajatDtc+fclRDdb928FgFpq6aq
         Sm2TbYi1Bdwj0WDV0Y7/nOQQST7C5dqRJAc5R4g254wp/FNrL2XjAjWRRhpV0/sS2USL
         WTZQ==
X-Gm-Message-State: ANhLgQ1W8A5NgolQesoyfByA4w8AleOC4pwqjwteiw0L6FUAfsr8XIIU
        KguMJ+wd1Le//OfnhYCi28gLjLK0swYuFRsYuj7FuQ==
X-Google-Smtp-Source: ADFU+vvCkt/oMnQzN3IFjfQIOnsxcbtfBjZKvB+whQOCB12Ag8K7ov4Os1+7zDXZl/j+vOqCKXAOBKogHskuiE7+Kqo=
X-Received: by 2002:a63:ff59:: with SMTP id s25mr12612787pgk.159.1585073554861;
 Tue, 24 Mar 2020 11:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com> <20200319164227.87419-2-trishalfonso@google.com>
In-Reply-To: <20200319164227.87419-2-trishalfonso@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 24 Mar 2020 11:12:23 -0700
Message-ID: <CAFd5g44XDamNNib1=a2Zxm7R3WUbbAF4u0jiWZoYMSQbPKKOyw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] Add KUnit Struct to Current Task
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 19, 2020 at 9:42 AM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> In order to integrate debugging tools like KASAN into the KUnit
> framework, add KUnit struct to the current task to keep track of the
> current KUnit test.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47E32C882
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2019 16:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfE1OO7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 May 2019 10:14:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40960 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfE1OO6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 May 2019 10:14:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so6728485pfq.8
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2019 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uILrnXKlYf2xjYbSzuRjxVZ/GKBRZG6iBlNh5FVzNqg=;
        b=tL4iRhDxBHlVQ+tyr45nAjSTrWm4FGkpU9/gqgAOrFY5B7cJ7oOHLY740uFY6v9Apt
         FqrRnmxExj3iQTQYzs/PenqdbelZVqX7ImfSm34SI3kUWnaFv2Pd1vXHqDLGJYPgxvw8
         7KLV8hWWHlsDJ/UwTZYLqE3rqDzmSrpBL95BUyqXducEuzu32sr8cYoLi6lrm/VHbu19
         kGodX0/6n5OKGvwKCkqnvqlMkPVgQ7D246As7ltK/sqPD0kwVjhXWCNgzf39x95m1k16
         0eXP9QfKOUXReSvTh9f0l8fCYrSWQokxzY+jcITzAkXcdghBa76eI6mVVXYUH34oj3Ib
         qnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uILrnXKlYf2xjYbSzuRjxVZ/GKBRZG6iBlNh5FVzNqg=;
        b=RinzmQqFE0LlY0HWn3gA72k5xhBh3pCyV9KKZR6gjHJkjAb088z/9K26HSNKfWqMAL
         jjNJG6AmnZ0TTM3aCoAjgWDfdZZCIjjL8nA1p4e0d/ZsT2nsI1FK0l8OvFWCrOrUl9dE
         8ZKX2fb3ZNUwJM00+4kjX0CHIe4QhcOc74ohd9e3mk+sEBA106Wx+cCRUAD4fzcKoy4t
         WQItV/mWouBxLUz7k/4nAA1QwwZCA1C5jbSNOnQRUqt6lBZnONB4G2jQNGSkLa6AnBVA
         BS2GaUC4mb+TsauMpeCLNcGPXv2v39bb8s6p/LlfEhrHIr/8ty52ZtSJA7FxohXgjSuK
         szaQ==
X-Gm-Message-State: APjAAAXprdpRb1HOv0R+kmy2IGY+VxP91NYcWnSW4wrEGpTuYgFVa0De
        //15eyAiOjIZ7yzCcuLpnPFyQ1BPm0R/mZ2mpa4MxA==
X-Google-Smtp-Source: APXvYqyOX9PeZsCaqURSrIEWPGIBd1WFVQ7exVP3S114miK0Cy+gUD/uDqW5wGxUjPG0aHqJLJFWW3mMb6YG8JIQdRk=
X-Received: by 2002:a65:64d9:: with SMTP id t25mr132418776pgv.130.1559052897854;
 Tue, 28 May 2019 07:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com> <20190517144931.GA56186@arrakis.emea.arm.com>
 <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
 <20190521182932.sm4vxweuwo5ermyd@mbp> <201905211633.6C0BF0C2@keescook>
 <6049844a-65f5-f513-5b58-7141588fef2b@oracle.com> <20190523201105.oifkksus4rzcwqt4@mbp>
 <ffe58af3-7c70-d559-69f6-1f6ebcb0fec6@oracle.com> <20190524101139.36yre4af22bkvatx@mbp>
 <c6dd53d8-142b-3d8d-6a40-d21c5ee9d272@oracle.com>
In-Reply-To: <c6dd53d8-142b-3d8d-6a40-d21c5ee9d272@oracle.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 28 May 2019 16:14:45 +0200
Message-ID: <CAAeHK+yAUsZWhp6xPAbWewX5Nbw+-G3svUyPmhXu5MVeEDKYvA@mail.gmail.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Elliott Hughes <enh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks for a lot of valuable input! I've read through all the replies
and got somewhat lost. What are the changes I need to do to this
series?

1. Should I move untagging for memory syscalls back to the generic
code so other arches would make use of it as well, or should I keep
the arm64 specific memory syscalls wrappers and address the comments
on that patch?

2. Should I make untagging opt-in and controlled by a command line argument?

3. Should I "add Documentation/core-api/user-addresses.rst to describe
proper care and handling of user space pointers with untagged_addr(),
with examples based on all the cases seen so far in this series"?
Which examples specifically should it cover?

Is there something else?

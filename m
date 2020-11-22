Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C42B2BC379
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Nov 2020 05:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgKVEB3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Nov 2020 23:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbgKVEB3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Nov 2020 23:01:29 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D646208D5
        for <linux-kselftest@vger.kernel.org>; Sun, 22 Nov 2020 04:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606017688;
        bh=LnEcfZ7EAuRy2LnECDQWn5gnjgsq8GFNBn8ODQ8+JHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2kk/o/n2UXsfdST6NrShZUKZx/bEouQTk/Uf/iK4FXK6jujwtSM0cvU5mDUlhoiCm
         JloGw20EL2XYMwmQM/5np5luC2U+XCYoz98vRUDswUQp7TGa3gY7ZKvEEu0wzGk+qN
         1iCMFoIYtVZmO9fucvcghC0ljetLapqj1o2Vvfb8=
Received: by mail-wr1-f52.google.com with SMTP id 64so1595073wra.11
        for <linux-kselftest@vger.kernel.org>; Sat, 21 Nov 2020 20:01:28 -0800 (PST)
X-Gm-Message-State: AOAM531J3QvMNLup9cMlpr54fA0K+4AgymX+wT2HJM6TEpDWVkHElMD6
        0UUCzay3EDM71mAbunEb9fyQTpXjEQ2jN2/SUs2NCQ==
X-Google-Smtp-Source: ABdhPJya2Fm7AlpR23qNwFPbMhB3Yi5SpFa44AWfIgtph6ZFjNt5Z0ShzA45Sx29UK9mTBQd+usd0uxSXWq5vA+n26o=
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr5785186wru.70.1606017686782;
 Sat, 21 Nov 2020 20:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20201118032840.3429268-1-krisman@collabora.com>
 <20201118032840.3429268-4-krisman@collabora.com> <87a6vdmedy.fsf@collabora.com>
 <202011201618.62E507D@keescook>
In-Reply-To: <202011201618.62E507D@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 21 Nov 2020 20:01:10 -0800
X-Gmail-Original-Message-ID: <CALCETrVtwmS0707L5RbWvJpyw-+xtT73xph59DJC2TGa-Hhw1Q@mail.gmail.com>
Message-ID: <CALCETrVtwmS0707L5RbWvJpyw-+xtT73xph59DJC2TGa-Hhw1Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] kernel: Implement selective syscall userspace redirection
To:     Kees Cook <keescook@chromium.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paul Gofman <gofmanp@gmail.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 20, 2020 at 4:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Nov 19, 2020 at 12:43:05PM -0500, Gabriel Krisman Bertazi wrote:
> > The existing interface could be extended with a flags field as part of
> > the opcode passed in argument 2, which is currently reserved, and then
> > return a FD, just like seccomp(2) does.  So it is not like the current
> > patches couldn't be extended in the future if needed, unless I'm
> > mistaken.
>
> Yes, I'd prefer this series go in as-is, and if there is a need for
> extending the API, arg2 can have more values added.

I agree.



>
> --
> Kees Cook

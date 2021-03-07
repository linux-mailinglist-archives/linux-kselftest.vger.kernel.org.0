Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DC33300A5
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 12:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCGL5F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 06:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhCGL5E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 06:57:04 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A63BC06174A
        for <linux-kselftest@vger.kernel.org>; Sun,  7 Mar 2021 03:57:04 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso2094567wme.0
        for <linux-kselftest@vger.kernel.org>; Sun, 07 Mar 2021 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daurnimator.com; s=daurnimator;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XTuDZrVnZ9EbYrXg7UvpBlJziCNJ1/b+V8IS2yeC5s=;
        b=rJV0gI4uii3RsLEZm5fBezPhA79NuurwIqf0KXXBr5WGUkbhY8U3fTg4AYT6a8eEQn
         p2peI3M3t/CmGP2DiEWbKMlcdCCta0oKxkXa6PpbA4dbdRO7roGRpcUlqk/beLNH/fM3
         oUbTh5vt8FyjVk7gzNbaqkjCMKfIROp8RfjbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XTuDZrVnZ9EbYrXg7UvpBlJziCNJ1/b+V8IS2yeC5s=;
        b=Wszxd1JFq/TGA884vzm8Osj232CQNvwgGiofYA7dQEDacNI8KZvsCaTSf2/9o4QTNd
         nZRaEVdL25fBOR+8CjmcCxtugA2wY+cAdm0S68MJBdHWIFROsD2nJz2icFpwa2gxYFEL
         vdhnBya7DbW8+n7knc3Wisa19NIWRpgzE2yLYIhUZ6cG2SwlPegEScQkFkopsNaqRXRR
         oZbU9eYtAEphCSnDLZ2OmumoUlveoojrLp98ojMrXWt/EBxKojQqcna/8nb70X3EXgqm
         s9f1du7lyly5po6xvVVq7Ww8l9Zqnbei01ClE1gZZtAqs1LZiEj3IwRhhZAfBBuXCEXn
         D3xw==
X-Gm-Message-State: AOAM533Kik0qjDq80viRWiJpIkes3cF2tfxN/enqPTQmCzc7ROYfUMiG
        dT7da1CAM+YUb8CnU6icjXdmweQeMq3ypl/ydBmbBQ==
X-Google-Smtp-Source: ABdhPJx7i4NCKGHtxzcVqNtjsN8i2IQC3TPI7GO6qh5F5odB7fEkjn8i2p3wFA1amIAbSqRQZqRUEgw5fCACA66FsMg=
X-Received: by 2002:a7b:cdef:: with SMTP id p15mr17827353wmj.0.1615118222765;
 Sun, 07 Mar 2021 03:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20210304004219.134051-1-andrealmeid@collabora.com> <ecbed98e-882a-0c0e-d4e1-bd33960f3674@samba.org>
In-Reply-To: <ecbed98e-882a-0c0e-d4e1-bd33960f3674@samba.org>
From:   Daurnimator <quae@daurnimator.com>
Date:   Sun, 7 Mar 2021 22:56:51 +1100
Message-ID: <CAEnbY+e0=4B4SwgspdhYePg7gdMdKj=Xgu=8k0zVKX-SKfy24A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] Add futex2 syscall
To:     Stefan Metzmacher <metze@samba.org>
Cc:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>, corbet@lwn.net,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 7 Mar 2021 at 22:35, Stefan Metzmacher <metze@samba.org> wrote:
> Instead of having a blocked futex_waitv() waiting on an fd (maybe a generic eventfd() or a new futex2fd())
> would be a better interface?

Like bring back FUTEX_FD? (which was removed back in 2.6.25)

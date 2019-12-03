Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E14EF111F2D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 00:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfLCWpQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 17:45:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41843 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfLCWpP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 17:45:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id s18so2556751pfd.8
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 14:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qd7P+RAsKeedZrqHSNazeNqcDpe7+eVvkyWsa2Q207Q=;
        b=iXMrnw93nP/soNBqfRzeL/LguWO2PkOg2jKyU1LfmhQ8cwNGaFd8qWTj1ngdPLbuZs
         2V4t+5GyeScz7/QEokG4fQ+4fgTCRXC5hc6v+uUyIW/eepTWFvSu+HQA017iTYKOaN1t
         fNOxy5KxTaiI/RBqvWjCH8e03nPVxe/jBysKTJWN9v9olf6QeUWbxPqaMdVSFELa+ZnT
         Yh8wD4+Cagsxb4NudI+PNBY6O5OnrZ7ihaB8UKAHI4Xq1X7o2bVir7T3/0hy0/wiWvJR
         2qSKD1ImpOVpVwTR7efn5Oxc4qTw24IFdfabSYnAt8ljytwn9zlOfL5FjtOq2T+VwFa5
         DMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qd7P+RAsKeedZrqHSNazeNqcDpe7+eVvkyWsa2Q207Q=;
        b=c7XwA2yavbPj5LEqAy1rm0Dh+qFfPGCs/IaZ6UB5ifsuy6Q0fXTjms2bwxQKOFUy5K
         gKISfCstKzieaKy4bdAhUw0PsLp9zuiR8e1q344ShTPRitMEDo5ubaA0SnrsSQGsK90y
         34G9jE2Kt4BpieDOFztrSlH2p7htLdf5lzEwQsZOACT6fTzne6i7FJJOlrBuL4EzznU2
         RVpFrOvSZvk1FuQD3R03x70MsqCooRwZ3XfzYq+hf12Ud+eqAWXI/WDOH9Y7YVs3tLi7
         fGnkM3EWA/mPGzZEr4oz1G0KJsDC8hMD759Ir8wMJh3C0t8lCsqx9jUZkyVndK98pXjM
         4j6w==
X-Gm-Message-State: APjAAAUd7oQTGMdkwFOtWibiZ2KTY+YQpgJoyP9tmZxr4u44gF7XQit6
        mjs1EI8lcgX7hL5wHCYGggYdyGaJzRMcot+8X/vdow==
X-Google-Smtp-Source: APXvYqwcKBHbJdc+KCshtot/o7I0++tDm8qDfLRf4tv06Kw+/aPlM9T1C8nXAryH6sAPWx+2axjFe1oWQ0uD10x8T1Q=
X-Received: by 2002:a63:480f:: with SMTP id v15mr22272pga.201.1575413114597;
 Tue, 03 Dec 2019 14:45:14 -0800 (PST)
MIME-Version: 1.0
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com> <1575374868-32601-5-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1575374868-32601-5-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 14:45:03 -0800
Message-ID: <CAFd5g45vriC61WvPL_FMbTUjJTRqHW6_Le=7PcMiR-rFmf_9wQ@mail.gmail.com>
Subject: Re: [PATCH v5 linux-kselftest-test 4/6] kunit: remove timeout
 dependence on sysctl_hung_task_timeout_seconds
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 3, 2019 at 4:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> In discussion of how to handle timeouts, it was noted that if
> sysctl_hung_task_timeout_seconds is exceeded for a kunit test,
> the test task will be killed and an oops generated.  This should
> suffice as a means of debugging such timeout issues for now.
>
> Hence remove use of sysctl_hung_task_timeout_secs, which has the
> added benefit of avoiding the need to export that symbol from
> the core kernel.
>
> Co-developed-by: Knut Omang <knut.omang@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Acked-by: Brendan Higgins <brendanhiggins@google.com>

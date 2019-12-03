Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92ADA111CD2
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 23:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfLCWry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 17:47:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37661 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbfLCWrw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 17:47:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so2321615pga.4
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 14:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TqgN2iJjOXxie883Mhqea6U14ESjoMu4kL/R78rVdw=;
        b=XLtR10TY5HvNYaSa6cai3/R9FYzleQQZz2svZyL8tOK87YQA912V1ym4Hv9zSZTa4W
         XsYLsdsxIIeqUmKaaTyXJdXq5ZIMsdtz+qAW2aJArY3lZQzq/8XMkxXKMLduQdGguwWQ
         tEyyhc1m8FNszdEx+TWMqK02tQGLsYRH7qEoztNCUWj2XYpGsKHNu+2K9gLUBTSzkpQg
         cL0sHoa58B89n343/NyL3Q5aK/piEHaXyVdmqwAxoUlwff0wlzeadqsQ5m97SN9ss//N
         WQpKd+LYhfVNyvGjsitB44ASs9L0mP1g554ne1GdBkVgiDiXqQvNshl3HDgwl4vsoLUr
         Y7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TqgN2iJjOXxie883Mhqea6U14ESjoMu4kL/R78rVdw=;
        b=sPorhCPT5u7DIuNdGO1M+L2eHLFoLHJrGnaDftpBNPQhDbkMWy9zhdeIfFS5eSE1Kc
         Az9ftoL+EGg+CheaBU2ymoP7vHT0ojpqodvt3x+/S+FnxQR7EmumYxfx0qTtbKy7KRza
         GdHe8qWAFJZBrZNgbQ4a3peUEaDeYEMfLoDz+A3jfyy5+kzNeeASmt1CD8ltU3okipOk
         SGcL0lnw7c+FHHIJlzjBmMgIbgXsElrWYrBd7wAYd0NXIlqiLAEShsRKwV98v9lIkq6Q
         r0DCRCFH9947Z7Svhn+ycuRXPLWVg2XAvwiOdz9LuG+HVsRE6nMigbA+wsulMln5CwFj
         k/hw==
X-Gm-Message-State: APjAAAUB4RXmQ0J0IEytVvtfIP2vd8/PiwBCBBzrIhQ0PiUTF1kqrQ9W
        WCvqvv3Rh2aIMIo4l6hiCTcExq83jaTTm2mwW+IxVg==
X-Google-Smtp-Source: APXvYqxzyBp784JSAxM/nOyG953YC2qIJk8I3LZCsWw1NC/8F92n1+h9oQjRuIVvcrvMxxIyY3GenyseDH3/qhHb7BI=
X-Received: by 2002:a63:480f:: with SMTP id v15mr32786pga.201.1575413270868;
 Tue, 03 Dec 2019 14:47:50 -0800 (PST)
MIME-Version: 1.0
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com> <1575374868-32601-6-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1575374868-32601-6-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 14:47:39 -0800
Message-ID: <CAFd5g47BXKat2Hty01WHz6eJj3WOjbeJ3pYqimaf2wQPm7Eibw@mail.gmail.com>
Subject: Re: [PATCH v5 linux-kselftest-test 5/6] kunit: allow kunit to be
 loaded as a module
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
> Making kunit itself buildable as a module allows for "always-on"
> kunit configuration; specifying CONFIG_KUNIT=m means the module
> is built but only used when loaded.  Kunit test modules will load
> kunit.ko as an implicit dependency, so simply running
> "modprobe my-kunit-tests" will load the tests along with the kunit
> module and run them.
>
> Co-developed-by: Knut Omang <knut.omang@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!

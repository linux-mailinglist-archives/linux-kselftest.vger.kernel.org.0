Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E67411120CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 01:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLDAz0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 19:55:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41204 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfLDAzZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 19:55:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so6674wrw.8
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 16:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2Azc16Vw4ryTYqh29ZhrpRERgOlPUdv16uA7Ge2ox4=;
        b=oU3RI8RuGAnLzan6JzZGxTOz1LeLVBDqbni8Ea82NabY23NmjsmEKWvosJld0Nya7e
         yNhnapLfvI+dxZ93IOdQFMvKBH0/NUoAimXLZGhjxTCOVKOFjIFNZ1sqJQXHiiL0SN2A
         lyYssl2AANQxxbHpV+pxJv0U/m1euUdsRGRbveXcXt1DX9p0a66xfME1bfdZYMbNk+DW
         ElCWJ1pO4V469mxDQQhr+WcZpCyMt0GMQWRWYdw+Lgl2URh0IUewq6cfBFmfqYyzEyyE
         mfwaWFcZ2+Y0DZK3Qv257QkcYKvd/KrS1AimIrlpa667CinHXdgaR/nW/cCWdHzI1CmZ
         0bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2Azc16Vw4ryTYqh29ZhrpRERgOlPUdv16uA7Ge2ox4=;
        b=f3kUG6gZAmV9FsHl3zK5caFZu8QgPnvrtn2oz/CZ5P/GlS/b59rrsOSwQqNB5CAIRa
         OC+oKHVPj9dWTwJx400wy0712mQG0cjQ8iyRt6PCYa7pVss6oyYaDkEHters4oG/VXJa
         rSEyQOCgDPDFCh5mTiBopSrwnh4DrX2vbZEGZ4DtKJZ1Y5u9CoLr9VF5Fk1BNd2DTGNg
         9uRfiQCKZExxVOPu/J+S4fI5xmfz4ZBOKIL39pi5/K5QaRiSIpUi3X17Vq5udigbDjWD
         sJVy2URZtELUkvdssrplPfGyHFBshPD1UpgTusfGeo9BEaQwVayKLt/NpcI/XCNnarE5
         2jRw==
X-Gm-Message-State: APjAAAV2I8K+WmvYD66dO/YXT6bhPivaH+vSmEK1G3Lyg5RmOkMsy3Gv
        AySqwAhWl4idQRnXn8e6tEQ4MuSy34LUwqErL8obgwI27nY=
X-Google-Smtp-Source: APXvYqwaXcNZHm6NG4ULW38X0tHXZZUc4SvPr+46VmXZB3u1NEBvvPM0cY/ZXqxxyo3blM69EXP/X9UTvUJxLArinaA=
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr968333wrp.2.1575420923180;
 Tue, 03 Dec 2019 16:55:23 -0800 (PST)
MIME-Version: 1.0
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com> <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 3 Dec 2019 16:55:11 -0800
Message-ID: <CABVgOSnEKQGdzdjLAuGDXMF1WB5ga-ePqmMzQhbCWP=2qiv7ew@mail.gmail.com>
Subject: Re: [PATCH v5 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        joe.lawrence@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>, adilger.kernel@dilger.ca,
        tytso@mit.edu, Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 3, 2019 at 4:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> As tests are added to kunit, it will become less feasible to execute
> all built tests together.  By supporting modular tests we provide
> a simple way to do selective execution on a running system; specifying
>
> CONFIG_KUNIT=y
> CONFIG_KUNIT_EXAMPLE_TEST=m
>
> ...means we can simply "insmod example-test.ko" to run the tests.
>
> To achieve this we need to do the following:
>
> o export the required symbols in kunit
> o string-stream tests utilize non-exported symbols so for now we skip
>   building them when CONFIG_KUNIT_TEST=m.
> o support a new way of declaring test suites.  Because a module cannot
>   do multiple late_initcall()s, we provide a kunit_test_suites() macro
>   to declare multiple suites within the same module at once.
> o some test module names would have been too general ("test-test"
>   and "example-test" for kunit tests, "inode-test" for ext4 tests);
>   rename these as appropriate ("kunit-test", "kunit-example-test"
>   and "ext4-inode-test" respectively).
>
> Co-developed-by: Knut Omang <knut.omang@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: David Gow <davidgow@google.com> # For list-test

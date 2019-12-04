Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14386112097
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 01:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLDARp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 19:17:45 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:36017 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfLDARp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 19:17:45 -0500
Received: by mail-qv1-f66.google.com with SMTP id b18so2389342qvy.3
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 16:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTyx2RZy7Y05cTkQC5l7sD6FLwz4Qd0lQ0nPf0EZIKQ=;
        b=hOm8wz2JV5irNU26ecry779uLa4TiPhyZ1ZbH5BMAy/dmu7zOGoJWBAfrrXnkZ4bAI
         i3S1GGj7B/bD+yuiGyVGBFPy0Scho66AEJzGF0Uz9gjhbCR20aK8/aD754sz5fHdycGk
         ElbXXiBdPnpI5fmy7qTAqyOnxSjMyNU8gh6CG/lsf7crB4HjGgbZ4aTmvdRq56HBEao6
         WiFWriZ/V4caGH9ZsSaK2SudOmSHCEnweMh/Rr4ecE0DCuWpEBcp59cbvpDBglqRURAu
         55Rp+JxFnBZW3Y6c9elMR3Ps13iJiRCX7Pcp+gToSKg/XaWp2AXLH4rYaqVePA8HVcGI
         Is1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTyx2RZy7Y05cTkQC5l7sD6FLwz4Qd0lQ0nPf0EZIKQ=;
        b=UF/9Zsez6Ara6iPjcP2Ta8b/KzWOTY4BBUEVIiNJj0+BT9ncBo0liVfZdig+qnBBt0
         hrfUTqubyiZtaUNxF05F/ehFOotfjfHT0p//6sfMdxvyKfAJj1sa0IfTO0AitVFLio04
         AokOJ5Lc6leI9noJJzumzwiVE0Es1DKOuX1H5KJgyN6qs45QNzcybEhxGqXQhJLxlp7T
         RySR7tncvj7P9XH+wvEjBYpIuSXH3pUe7eq2t3HkjVYI1M+jqUaq2l7g0IXT0PuO7zwl
         VVXIHKy7XiufXziwUGdCLlnrrqPi/ae3iz21mp4BY37yckghV1dmXk0ILWTmup2frXCa
         dvBw==
X-Gm-Message-State: APjAAAUS9aA/KfBP1uTFcq6Xy6WMmwoYqPH1uEtGxoYSiXwxn17IEDhc
        TYwJHqmGHJewOnfu7KOsoJwKdSdcDe2nuZ2GpA+w
X-Google-Smtp-Source: APXvYqyz1zLOAzlEW9SR6UXDydhWZrLGVzqeOyJQaU/XEZFykJigtOH++7UD8tHeCTXXoGftLWGr/Iw5KbggfuWAdmA=
X-Received: by 2002:a0c:8061:: with SMTP id 88mr411290qva.62.1575418664089;
 Tue, 03 Dec 2019 16:17:44 -0800 (PST)
MIME-Version: 1.0
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com> <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Tue, 3 Dec 2019 16:17:07 -0800
Message-ID: <CAAXuY3rYZHac4o1bqqnbR_1g12dtqmJHVp8Taky00J4-+2hwZA@mail.gmail.com>
Subject: Re: [PATCH v5 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
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

> +ifeq ($(CONFIG_EXT4_KUNIT_TESTS),y)
>  ext4-$(CONFIG_EXT4_KUNIT_TESTS)                += inode-test.o
> +else
> +obj-$(CONFIG_EXT4_KUNIT_TESTS)         += ext4-inode-test.o
> +ext4-inode-test-objs                   += inode-test.o
> +endif
Why not rename it unconditionally?

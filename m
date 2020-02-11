Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE944159BD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 22:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBKV7G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 16:59:06 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52445 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBKV7G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 16:59:06 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep11so1954431pjb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2020 13:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9h+gOqZrb8Pn305OGBZnfCQEnWlX+64gaRdYC8Jwu1Q=;
        b=Anc5d4NC7yWC0HGeNdu3IE+cBqyU0n/LqZ/shNqTFnlbUUdq+f9z+8Xhzizqi/bCMk
         VDwmu/x0oMOoOabwwPHDJhvcARSDl5DinZpMsZEizCXt6BTbfTgFEkEro5cJiM1BjsNi
         RO38o5Hvuv2rPdSGpQ1LrArrpGZgGKeEsa22JtcLkZimJo2rhVap/XLefeOe0w2FeTB3
         FCBTZxr11dDCRRTV/7W+gB1d2Ekd9eN6jECksOv5APNWiTkpiKJNeYSPH6ssMlL2FkVd
         IsAwr+mJKcHMJ6RB2Yg0HWm41xeBbRvcx0cMeIAM2Gv8SzZyycFBmuUEqX8ztpcN0XJw
         2gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9h+gOqZrb8Pn305OGBZnfCQEnWlX+64gaRdYC8Jwu1Q=;
        b=E/fWFXNmFk3LO9ATkUUFbn060uDatQIwDxnguYJ7ICziMoX/i0cvkGfg1ubrtpG0Pf
         NuHG8knQUMSDclz7HgOEllf71Kf1tz3F5b+4sZtlX7bbUxEXeVg07mNNqY254UjCFRPT
         weEU/lUMgreSHriRxOuO9jOGwxqhaaCj+wqXbC1nIwqb5suCXlUfj59IOHu+wpS13qAL
         Ld764kOUUJJi3dhLz2GcKqBSQU9v+VTPKFgQSsOni+VFK+EcS4Z3N70cEOJpSjzwcnZu
         rYKzWETupgkjkWOJ/hArRKnaWSK8MDYvAvcyFtP/34qHQ7g/hOnWxUKQKGSDRHFfocx9
         2rNQ==
X-Gm-Message-State: APjAAAXA/NQcuJvlNwjKIftAZrdkDEkXDViyi3VI6ZtUX9nS0H/FNurf
        1FdGj1qTAkqdrVUeTjOGjpQk+XCLPfUEcFYjPfm1QA==
X-Google-Smtp-Source: APXvYqw93yT/Zf/7Z/6tsFK4ftr1310/hXB9PY5roG+jTUuwtIqIs15h+U7Uz6XTE1kiaSa4rkmGOd8h8SXG302Ebzk=
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr6020385pjn.117.1581458345368;
 Tue, 11 Feb 2020 13:59:05 -0800 (PST)
MIME-Version: 1.0
References: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com> <1581094694-6513-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1581094694-6513-2-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Feb 2020 13:58:54 -0800
Message-ID: <CAFd5g458oX0mEqg3xvTnonr3ztNd=HUBy3vhLSKgkKUsyRuycw@mail.gmail.com>
Subject: Re: [PATCH v3 kunit-next 1/2] kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results
 display
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 7, 2020 at 8:58 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> add debugfs support for displaying kunit test suite results; this is
> especially useful for module-loaded tests to allow disentangling of
> test result display from other dmesg events.
>
> As well as printk()ing messages, we append them to a per-test log.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!

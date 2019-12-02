Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE52A10EE1E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 18:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLBRZv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 12:25:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41285 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbfLBRZv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 12:25:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so4921186pgk.8
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 09:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJkfeNUtZsUM1SriZ4NkOu1VRRZp6DXE5Ca/oup1eY0=;
        b=OkT0pATSCD09KhjE0j2gmub4yYFjggeSCEDGGvJRy3S41QTVkCSh8xwimUhMdMZb9c
         YujkvAxV8pa4f0EZH0s21gVwuSe6g/btLrsuyVX3i5JOTcGQSdNOAMcyRSDd3t5i404n
         WpIK1uw847md8b8LtcOKJ8/u6Wyq9QJD+3DBsup2ZkoPnGM89ExC9cFaVHe3pohsGdlv
         IctyftfHniR6t8oxq3n8RP++aJQhCUxr0uzN5fqRymt39FrYs3jIs3okKnTzay7FBi6g
         tLhRuQOVVIM+TdDGHZsOTABM2SdXJqQAaPqY6dTjTN/zzrN/r7UheQRVQo73q30Dx5sZ
         MDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJkfeNUtZsUM1SriZ4NkOu1VRRZp6DXE5Ca/oup1eY0=;
        b=jspWXaIKP2eIYZe78MbIEcIW4aYUz871L+lC4ETSvqs6VwX65dUPhVoURfIV83YhwX
         VdJ8Ls5nHrnT2K+nSgks9vabbglZbv6RMhhsPPi3ytSfXvAMaWuFaXp5Vln7UabgQzRo
         INWs+Y5uzKaHK9iiFUTjwAtlI8+IsztBtrq959QzSHE3f1jmMsE3OjSDq1OfKNZf5L2v
         SQjBaOMKAXX8wyCShL1Rn03WPLfzRousSJiDimJrb/m7iq4g8P36dp3IcNruJTjcm4Jf
         o5HlJfnVNs2mlBTXkSLeiDKW3CfWhIw9Ga5QB96ne+4NMm7G8ZTntUUslK1XdHIIsnrU
         Aisw==
X-Gm-Message-State: APjAAAVbyunNpaPKOlT8wqEmqqTogWTr0kg11YgzPgBiMPP555qYP5ZH
        EaJVH1FXpo9JkzOvDk7wsvkMiEvW6ZVIpOGOStTOqJY48JI=
X-Google-Smtp-Source: APXvYqzRNnkhXeK9+TF40gPXRoir6QgRYhi5XcQ7EoDA4SgNek8Tj0V1GXGOZXZRvla3t8H8gAQqwdNuOUyfY1Tvp18=
X-Received: by 2002:a62:7b46:: with SMTP id w67mr26208051pfc.113.1575307550038;
 Mon, 02 Dec 2019 09:25:50 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com> <1575242724-4937-3-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575242724-4937-3-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 09:25:41 -0800
Message-ID: <CAFd5g47C6OShsYy5ngSGTmkL3fQoj-6jb09iQ+CD6FE0usggCA@mail.gmail.com>
Subject: Re: [PATCH 2/6] docs/kunit/start: Skip wrapper run command
To:     SeongJae Park <sj38.park@gmail.com>,
        David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+David Gow - David has lots of good opinions on our documentation.

On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> The kunit 'Getting Started' document first shows the wrapper running
> command.  However, a new user who simply following the command might
> encounter a failure like below:
>
>     $ ./tools/testing/kunit/kunit.py run
>     Traceback (most recent call last):
>       File "./tools/testing/kunit/kunit.py", line 140, in <module>
>         main(sys.argv[1:])
>       File "./tools/testing/kunit/kunit.py", line 126, in main
>         linux = kunit_kernel.LinuxSourceTree()
>       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 85, in __init__
>         self._kconfig.read_from_file(KUNITCONFIG_PATH)
>       File "/home/sjpark/linux/tools/testing/kunit/kunit_config.py", line 65, in read_from_file
>         with open(path, 'r') as f:
>     FileNotFoundError: [Errno 2] No such file or directory: 'kunitconfig'
>
> Though the reason of the failure ('kunitconfig') is explained in its
> next section, it would be better to reduce any failure that user might
> encounter.  This commit removes the example command for the reason.

Seems reasonable.

> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  Documentation/dev-tools/kunit/start.rst | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index 78a0aed..e25978d 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -15,12 +15,6 @@ Included with KUnit is a simple Python wrapper that helps format the output to
>  easily use and read KUnit output. It handles building and running the kernel, as
>  well as formatting the output.
>
> -The wrapper can be run with:
> -
> -.. code-block:: bash
> -
> -   ./tools/testing/kunit/kunit.py run
> -
>  Creating a kunitconfig
>  ======================

I think maybe we should demote this section so that this is a
subsection under KUnit Wrapper. Might also want to add a tie-in
explaining why we are talking about kunitconfig here? Right now this
kind of reads as a non sequitur.

Note: we have tried to address this potential issue for new users in
this patch under review:

https://patchwork.kernel.org/patch/11252953/

I don't feel strongly whether we do it your way or my way. What do
other people think?

>  The Python script is a thin wrapper around Kbuild as such, it needs to be
> --
> 2.7.4
>

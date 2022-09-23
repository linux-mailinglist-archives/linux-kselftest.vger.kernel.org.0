Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7515E8294
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Sep 2022 21:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiIWTdH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Sep 2022 15:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIWTdG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Sep 2022 15:33:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F4B12DEAE
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Sep 2022 12:33:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e18so1546517edj.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Sep 2022 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=18VyPdyQ+pxyYbHrASob7VAyaG2wYgANtBnVsisNDo4=;
        b=DFP64dzbRFsb79jZN31Wt9YyiQbThR5J8naazbxCk80nfm9hSl4VGlULRL56foNxGn
         ixRzEFVA+UoEYTcnYxxXUNDn9wdEY9SkYlDpMK5XGD4I/UVRvE7LWSOruNesFSga4r+T
         67vd9fflo4javtdC366xFNvdo9EQrZauB2Mf4MNGPD0eb1ZU7xJoW3OeA4EvNkbHXsmx
         DJQedXsnV6KWNh9LhqhHmmohdEaLa9PmcU6ngXQ/n+OgYNyB3xzYwsb/9hHRjcWzt7+L
         tnef83Msydt2N8C4aChMoui0H/JqfgNha54FtJ5x9Nr3hQkZnx1JNCwo1tpYL9yxr7B5
         D1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=18VyPdyQ+pxyYbHrASob7VAyaG2wYgANtBnVsisNDo4=;
        b=Vw8a3eOHmUBaxjGoFqKoq5FcJKQqG9mFkAaqXbii7CNHGnBbF/+L5tWJ4kG0m2eAu8
         Px8AcpxKr2jDv81XUYbMNYzXNXC5gxFUDoZ8WQ9dMoO0BaWl3GSbMzn9r3Ubre2+5VxB
         bdlzsJQyAaDTkNOWwQT/h/cEgZNqPHOUTYUoIdOTrB659/6I4tc9Vf05b4gstOiHKb0j
         WOGwqerv34Slz/KHAzCzxUiRQX6MZYo9yxwqmoV9uxdnE9SyfxCYgy8qJ16tfl0v+ZSu
         yr9R/mcweLG3FvMFknbw1PMFch3mRMblH+WiSyQOn08ythhFZemiuqCLVAaLSad/w0wG
         fQnQ==
X-Gm-Message-State: ACrzQf2761+WDASZFLbC3+sS8wrea1a5t443PX0aNF3SKVxuERSaz7Ne
        PeBzkUPVCykyyMQUHsKoZ8ke6dSDZO5xqoj5kmaPiA==
X-Google-Smtp-Source: AMsMyM69iwPleDekMuM20qqvs9Ec06VslRwpK5jw5wEvaEO6FhXR8fE5qAnHJpV+CvGkMHXx90ChL1ribU3ABntI4pw=
X-Received: by 2002:a05:6402:11d0:b0:44e:ec42:e0b8 with SMTP id
 j16-20020a05640211d000b0044eec42e0b8mr9948937edw.131.1663961582691; Fri, 23
 Sep 2022 12:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220923050039.3371091-1-davidgow@google.com>
In-Reply-To: <20220923050039.3371091-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 23 Sep 2022 12:32:51 -0700
Message-ID: <CAGS_qxpQEDXMNxocp_LL_u0=UZ7PxeKh69VWhCYeNHUThbctfA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Don't download risc-v opensbi firmware with wget
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Xu Panda <xu.panda@zte.com.cn>,
        Greg KH <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 22, 2022 at 10:01 PM David Gow <davidgow@google.com> wrote:
>
> When running a RISC-V test kernel under QEMU, we need an OpenSBI BIOS
> file. In the original QEMU support patchset, kunit_tool would optionally
> download this file from GitHub if it didn't exist, using wget.
>
> These days, it can usually be found in the distro's qemu-system-riscv
> package, and is located in /usr/share/qemu on all the distros I tried

Note: I actually had the BIOS file, but didn't have the
qemu-system-riscv64 binary.

> (Debian, Arch, OpenSUSE). Use this file, and thereby don't do any
> downloading in kunit_tool.
>
> In addition, we used to shell out to whatever 'wget' was in the path,
> which could have potentially been used to trick the developer into
> running another binary. By not using wget at all, we nicely sidestep
> this issue.
>
> Cc: Xu Panda <xu.panda@zte.com.cn>
> Fixes: 87c9c1631788 ("kunit: tool: add support for QEMU")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Daniel Latypov <dlatypov@google.com>

> ---
>
> This is a replacement for "kunit: tool: use absolute path for wget":
> https://lore.kernel.org/linux-kselftest/20220922083610.235936-1-xu.panda@zte.com.cn/
>
> Instead of just changing the path to wget, it removes the download
> option completely and grabs the opensbi-riscv64-generic-fw_dynamic.bin
> from the /usr/share/qemu directory, where the distro package manager
> should have put it.
>
> I _think_ this should be okay to treat as a fix: we were always grabbing
> this from the QEMU GitHub repository, so it should be widely available.
> And if you want to treat the wget use as a security issue, getting rid
> of it everywhere would be nice.
>
> Thoughts?
>
> -- David
>
> ---
>  tools/testing/kunit/qemu_configs/riscv.py | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
> index 6207be146d26..12a1d525978a 100644
> --- a/tools/testing/kunit/qemu_configs/riscv.py
> +++ b/tools/testing/kunit/qemu_configs/riscv.py
> @@ -3,17 +3,13 @@ import os
>  import os.path
>  import sys
>
> -GITHUB_OPENSBI_URL = 'https://github.com/qemu/qemu/raw/master/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin'
> -OPENSBI_FILE = os.path.basename(GITHUB_OPENSBI_URL)
> +OPENSBI_FILE = 'opensbi-riscv64-generic-fw_dynamic.bin'
> +OPENSBI_PATH = '/usr/share/qemu/' + OPENSBI_FILE
>
> -if not os.path.isfile(OPENSBI_FILE):
> -       print('\n\nOpenSBI file is not in the current working directory.\n'
> -             'Would you like me to download it for you from:\n' + GITHUB_OPENSBI_URL + ' ?\n')
> -       response = input('yes/[no]: ')
> -       if response.strip() == 'yes':
> -               os.system('wget ' + GITHUB_OPENSBI_URL)
> -       else:
> -               sys.exit()
> +if not os.path.isfile(OPENSBI_PATH):
> +       print('\n\nOpenSBI bios was not found in "' + OPENSBI_PATH + '".\n'
> +             'Please ensure that qemu-system-riscv is installed, or edit the path in "qemu_configs/riscv.py"\n')
> +       sys.exit()
>
>  QEMU_ARCH = QemuArchParams(linux_arch='riscv',
>                            kconfig='''
> @@ -29,4 +25,4 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=y''',
>                            extra_qemu_params=[
>                                            '-machine', 'virt',
>                                            '-cpu', 'rv64',
> -                                          '-bios', 'opensbi-riscv64-generic-fw_dynamic.bin'])
> +                                          '-bios', OPENSBI_PATH])

Note: OPENSBI_FILE also works for me (i.e. the old behavior).
But I don't care enough to ask that we change what this patch does.

My understanding is that qemu will automatically look in all of these
directories
$ qemu-system-riscv64 -L help
/usr/share/qemu
/usr/share/seabios
/usr/lib/ipxe/qemu

The first one (the one we're using here) is the only one that has the
file for me, so going with this LGTM.

The alternative is to drop the check entirely and just let QEMU figure
out if the file is missing or not, but I think this does give a
substantially nicer error message, so I think this is reasonable to
keep.

Daniel

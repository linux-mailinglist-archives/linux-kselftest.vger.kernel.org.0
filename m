Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F0840F325
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 09:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbhIQHXu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 03:23:50 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44499 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhIQHXt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 03:23:49 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MVvCn-1mHThU09DR-00RmsA; Fri, 17 Sep 2021 09:22:25 +0200
Received: by mail-wr1-f48.google.com with SMTP id t8so13544371wrq.4;
        Fri, 17 Sep 2021 00:22:24 -0700 (PDT)
X-Gm-Message-State: AOAM533d2e3gdScN5QoJuVuHz2DYRF7zteoDv/ZILhs3R+Zs+um5rIPy
        lA4Ip7+pWUtM25EzEtXnDMFfg6L652xbw9nxtxM=
X-Google-Smtp-Source: ABdhPJzJsrzhqboheOkJF5DSOKul11PbpO1/TRN4PuVM4wUc/lsEjGqfYS2kGw1Iq3DVe/OqQTjG5Qdil3wWKPMut74=
X-Received: by 2002:adf:f884:: with SMTP id u4mr9953811wrp.411.1631863344560;
 Fri, 17 Sep 2021 00:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com> <20210917061104.2680133-7-brendanhiggins@google.com>
In-Reply-To: <20210917061104.2680133-7-brendanhiggins@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Sep 2021 09:22:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a21j9yJe_X=kU6v2YgOnrhunRbPv+O6STSH71qTb7xnfg@mail.gmail.com>
Message-ID: <CAK8P3a21j9yJe_X=kU6v2YgOnrhunRbPv+O6STSH71qTb7xnfg@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] bitfield: build kunit tests without structleak plugin
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>, andreas.noever@gmail.com,
        michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        gregkh <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xGdJUU7Jbd4lvFcJi7VZTkYeXXOYuREu0Ya+f5SVA3D4fcQVzv5
 sgRAiCMKKh3ytUEGmD6Dxf7aETOZ0X/pGgsz2AUIrp9kUt5lqMHR7GHL+Y2l01nZH4mzLRC
 joVrXC9Ab/Y6xXXfTFeXn/bBIdvEQu3XMlqzqp9iyVUBeQ5WSddVw9o3hbB6el/wOUfnBy/
 WeuyQDCELhT3LewzUbwBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aaLODG2UnWY=:8UNFcgwItep3KN1dO16puC
 XIEYICuRxqJbEU5ER23X5Z6PR9LZVEIze8kIOAfxatbqRqyM2PPSFtCH9Igaph7MWx8xiEsW5
 InUmTmeETPnUyvoTrIsYwyBBu4M7nHkfkN1VmhFCdizrpkGDyyddhpFuJcaPIPcsqDuIhTzi5
 0MAl8jixoNfMFCUpMQP4/RDpXbnHeKSf/tpJ7PMyp2vltwcMoeINfgF+3YNskF1bOCJK9qQB3
 fKAnBvxBFhgTn6V9N5ByDxdiUDkdHK5h/XgpNDXbseTxaMpH9uWKvGCPx39I24X38EnfOme3c
 TwpDCPSGWP5vRzaX3Q5iWlzNpHB0N5+wpfNWbwVTDG8oelEiWrmVXR94m9BlmDdlT50/FhJoB
 ct0CHugb5GiJtqETF9YSXoKCsm3u4SQbXjmO2o+tiBX/l9OFP5t6MwmSWIdt3elXcpvnJqQLa
 KLCvwLz7ra1d4eYfxTCxTBHdd+4+rOVi65uqRQx5fiUR/thIRAGduFtgg+rfxbpnJ43v3dWg3
 PpCCK+ZVtqT+HCFDouRYyvIaO/6Wqiv95HHcFrzDsCReGfWd6HWHMB40R9RInPuTAGKQZQvTf
 OIhHpTorZ4zAJNqhgZXMNx61Ws000Db8FJ37sTpRs3Ru/YmZSw+fU6jJmJvk+Vtt7GU4eucxn
 97CYR/u/EZOxUG50tu5ZPNz9bLt49JaQLdNMPQZS1K+QeH46LIvn0tgJsgidWXCeBSh7oRImO
 LLleyzgY0c+YJMwy7qbf+oooD/oC0JLRq7emc0aqeUx6z43yeRCtQ0Xqu11DkdaI2wWQVr1id
 +rSEvWF1itpoJYTMGv7VXeExWLmTIEf4reCMz5X9IQfMreMgoXpCFbTyCzJtNkP1pmFB6myNi
 YSjsuQmyeXtyBgUgFYSw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 17, 2021 at 8:11 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The structleak plugin causes the stack frame size to grow immensely:
>
> lib/bitfield_kunit.c: In function 'test_bitfields_constants':
> lib/bitfield_kunit.c:93:1: error: the frame size of 7440 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>
> Turn it off in this file.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  lib/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 5efd1b435a37c..c93c4b59af969 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -351,7 +351,7 @@ obj-$(CONFIG_OBJAGG) += objagg.o
>  obj-$(CONFIG_PLDMFW) += pldmfw/
>
>  # KUnit tests
> -CFLAGS_bitfield_kunit.o := $(call cc-option,-Wframe-larger-than=10240)
> +CFLAGS_bitfield_kunit.o := $(call cc-option,-Wframe-larger-than=10240) $(DISABLE_STRUCTLEAK_PLUGIN)

I think the  $(call cc-option,-Wframe-larger-than=10240) needs to be dropped
here. This was not in my original patch and it is definitely broken on
all architectures
with 8KB stack size or less if the function needs that much. What is the amount
of actual stack usage you observe without this? If we still get a warning, then
I think this needs to be fixed in the code.

       Arnd

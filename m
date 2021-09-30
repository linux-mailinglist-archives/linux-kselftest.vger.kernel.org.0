Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9E241E408
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Oct 2021 00:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344213AbhI3Wlj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 18:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhI3Wli (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 18:41:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20079C06176A
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 15:39:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b20so31664537lfv.3
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 15:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vpEK1RK+z1DYVOyk9DbEX3Qy0CptNAutN/+eoXhnNAg=;
        b=MPcV1nKTG41YsS6nzyECLzS8XJcpcOFfbS7VcjU0nJu/vyyILaiw89TNbZRdv06fp/
         Su2MmLA9dka8g53MV7Nlkf5KlBiC8susP2eemNZkkZ6deq7x1t0rsM+v1MbBcgAk5rBO
         9wS9iw6ysXstOGP3itVu6SHxJoTKmTvSCEE99X50nF7tSPbEXiG3VsfZ0n9sYNzhlpz5
         iWlmE7HHx0SjYIqoa6LfJiyqxsTCwSsw5Dq4iWAufzv11x0kG3zJGCH7FPkzlsLJvttm
         nuq2hv0yG8538ZdydG/D4n44TePQPrpr69XoaMMfk46zVgUlx4+VnNTnaJ9/bjPyJE8w
         IYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vpEK1RK+z1DYVOyk9DbEX3Qy0CptNAutN/+eoXhnNAg=;
        b=mIxNSmMBiGqF3nEJzJWoGDhYWNRHsX3+RHkFY+ZHmWbMz4rFJ81NkNR2db+2TI07OK
         PDsSj5k7iTFdIWKjL5SQip0VviyB81h32paJhJ1vGSdaKqSvz0+O43GPOrue049inBiy
         hmJ7vc27qWOx6P2WTXgO54h0rYvKa0/cGKfxikqxBPW7pNUCQPqIwmwun5PYkHb+bnOO
         YQ/UhM1j5oFf716PPdxBH6An8TjLVd6JjKTfY9hr2loY/rtINCL8iG0EbAViDgiMtXLw
         T3Z3Iv19/tW6WolpVvlEfgc2iLvKkOIWxIo1XN6wpoqVeHyE9jjSfiTGQ3Y+Z2wO/QcY
         m9gA==
X-Gm-Message-State: AOAM530zA9YiKHt8V+oh+APsUzUvsS/3qXtyLMHZD+/FS8c+d/bQTweI
        aPKLUXwk1OEmg/+KCCJzSdVJ7HGsFlmi0hC6Hgh05tTbGh4=
X-Google-Smtp-Source: ABdhPJysr58yCMlOKQdoTUQe1CpCXlV7Z0NZ/4XMkU/oHfVF8EPT50KZPM/Gvlr1q5u8LKPCiV9rRwIUOUwRmWuXU5E=
X-Received: by 2002:a05:6512:1303:: with SMTP id x3mr1728584lfu.291.1633041593380;
 Thu, 30 Sep 2021 15:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210903012236.160858-1-lizhijian@cn.fujitsu.com>
In-Reply-To: <20210903012236.160858-1-lizhijian@cn.fujitsu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Oct 2021 00:39:42 +0200
Message-ID: <CACRpkdaMYdc4WLcLFMKd3MyyKnQpdhP3Wxkx6YPoR+0YmH8ifw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/gpio: Fix gpio compiling error
To:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Li,

thanks for your patch!

It needs to be sent directly to Bartosz Golaszewski so he can apply
it to the GPIO tree.

Thanks!
Linus Walleij

On Fri, Sep 3, 2021 at 3:18 AM Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
> [root@iaas-rpma gpio]# make
> gcc     gpio-mockup-cdev.c  -o /home/lizhijian/linux/tools/testing/selfte=
sts/gpio/gpio-mockup-cdev
> gpio-mockup-cdev.c: In function =E2=80=98request_line_v2=E2=80=99:
> gpio-mockup-cdev.c:24:30: error: storage size of =E2=80=98req=E2=80=99 is=
n=E2=80=99t known
>    24 |  struct gpio_v2_line_request req;
>       |                              ^~~
> gpio-mockup-cdev.c:32:14: error: =E2=80=98GPIO_V2_LINE_FLAG_OUTPUT=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98GPIOLINE=
_FLAG_IS_OUT=E2=80=99?
>    32 |  if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
>       |              ^~~~~~~~~~~~~~~~~~~~~~~~
>
> gpio-mockup-cdev.c includes <linux/gpio.h> which could be provided by
> kernel-headers package, and where it's expected to declare
> GPIO_V2_LINE_FLAG_OUTPUT. However distros or developers will not always
> install the same kernel-header as we are compiling.
>
> So we can tell compiler to search headers from linux tree simply like oth=
ers,
> such as sched.
>
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>
> ---
> V2: add more details about the fix
> ---
>  tools/testing/selftests/gpio/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selfte=
sts/gpio/Makefile
> index 39f2bbe8dd3d..42ea7d2aa844 100644
> --- a/tools/testing/selftests/gpio/Makefile
> +++ b/tools/testing/selftests/gpio/Makefile
> @@ -3,5 +3,6 @@
>  TEST_PROGS :=3D gpio-mockup.sh
>  TEST_FILES :=3D gpio-mockup-sysfs.sh
>  TEST_GEN_PROGS_EXTENDED :=3D gpio-mockup-cdev
> +CFLAGS +=3D -I../../../../usr/include
>
>  include ../lib.mk
> --
> 2.31.1
>
>
>

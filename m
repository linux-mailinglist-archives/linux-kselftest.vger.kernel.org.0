Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8526B570F91
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 03:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiGLBge (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 21:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGLBge (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 21:36:34 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D270C2AE1C;
        Mon, 11 Jul 2022 18:36:32 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 26C1aA8l029362;
        Tue, 12 Jul 2022 10:36:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 26C1aA8l029362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657589771;
        bh=/DJh0T9UEeSd0UnVmkJ3Yb1uvTEdoJFkOji+14jZ4Ng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UoSn8bUbb/ZWt7KcKridmJV+Sd0BR5TdoznG8B20/ipOYMKgAyl/WTkjPrVlzRqlQ
         zYiWb+Z+zzYwi7jjiIHHqQUiTQtrvg7OxltvIpB5zQ4L2ALpMWh4USRAW6UqW3v2oB
         RUyMkI8QUGuZ/CObljwd1UBo6vBg4lEgJHyw/bEDw/yjcg7RT3ko6ydhWzXvzOKHt8
         etCvMaTk5YYgYEe1IQVsWeKOlR14oqVTPBvC9zRilWYUYYi523co62dp7I6gRTDxtC
         7Gako/XtVZ3PzVOWfrp5GJWhblp3jfFoxffHez0PKmmywYbn25pNX/RPcfjwIU1mDo
         EZoMNRWOlQ9UA==
X-Nifty-SrcIP: [209.85.221.43]
Received: by mail-wr1-f43.google.com with SMTP id b26so9161542wrc.2;
        Mon, 11 Jul 2022 18:36:11 -0700 (PDT)
X-Gm-Message-State: AJIora+ZogMsHMcBLyahFErYjHjPyZdo+fivR4UgvJlOxSJVllNqk2RI
        ydMQWfTHwAz/vQIItO/YjcpxS/IWZVMfyYTmIJk=
X-Google-Smtp-Source: AGRyM1sS0c7XakFYh+QVVsDh5Mp5VGqoOVoPqEqwSPVTCvw1lpzi8qbXdMfY3A5T8s0mm3VXDnQr5bgwD4PEB0vMGAQ=
X-Received: by 2002:a05:6000:104c:b0:21d:87bf:63a2 with SMTP id
 c12-20020a056000104c00b0021d87bf63a2mr18678986wrx.461.1657589769995; Mon, 11
 Jul 2022 18:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657296695.git.guillaume.tucker@collabora.com> <4d34d06baf945dc31c78f873771cef3a75b60067.1657296695.git.guillaume.tucker@collabora.com>
In-Reply-To: <4d34d06baf945dc31c78f873771cef3a75b60067.1657296695.git.guillaume.tucker@collabora.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 Jul 2022 10:35:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNASe3zQv82pQsTdWtia9nQQm8XGgs_mrUMvbLRkxa0T48Q@mail.gmail.com>
Message-ID: <CAK7LNASe3zQv82pQsTdWtia9nQQm8XGgs_mrUMvbLRkxa0T48Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] Makefile: add headers_install to kselftest targets
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>, kernel@collabora.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 9, 2022 at 1:23 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> Add headers_install as a dependency to kselftest targets so that they
> can be run directly from the top of the tree.  The kselftest Makefile
> used to try to call headers_install "backwards" but failed due to the
> relative path not being consistent.
>
> Now we can either run this directly:
>
>   $ make O=build kselftest-all
>
> or this:
>
>   $ make O=build headers_install
>   $ make O=build -C tools/testing/selftest all
>
> The same commands work as well when building directly in the source
> tree (no O=) or any arbitrary path (relative or absolute).
>
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1a6678d817bd..afc9d739ba44 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1347,10 +1347,10 @@ tools/%: FORCE
>  # Kernel selftest
>
>  PHONY += kselftest
> -kselftest:
> +kselftest: headers_install
>         $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests

Nit.
Please use 'headers' for in-kernel use of exportedI headers.

kselftest: headers


>
> -kselftest-%: FORCE
> +kselftest-%: headers_install FORCE
>         $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*

Ditto.

kselftest-%: headers FORCE


>
>  PHONY += kselftest-merge
> --
> 2.30.2
>


-- 
Best Regards
Masahiro Yamada

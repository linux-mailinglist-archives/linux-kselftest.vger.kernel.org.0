Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E187A3140
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 17:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjIPP4F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Sep 2023 11:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjIPPzi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Sep 2023 11:55:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECBDF7;
        Sat, 16 Sep 2023 08:55:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFD6C433CD;
        Sat, 16 Sep 2023 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694879733;
        bh=ZY2cAb1W6cjpppzMyn+14W1CgRCu210r+XVVtUOwwKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gmqJKfpvSmqL4tw5rTeaNKxgBmXs0Wqq//Osd6MWQOZ4OCUKHa8THhHtFyp4onno+
         lbzj4iA+g0AtSl9+c6G8YIIDU/zCQdIbAPFfZD0wMrsRSnvz+WAajOjFbK7JyNwCRT
         XX1VUpTII13Qe8BlNUeVrZzueEUauqYOLeURiz+jxLySxE9021gT30a67s5QtBWnlf
         P5I6bSqCRCJyMSyuX7P0k6DAmc2AJJVA8/HQRz5Cm7KcIAwWg9VGAQsVmN7/+D0wMY
         Y3xEtspEo4P0rWe0g0YG4xmlVmNHZ9L+ocOoDNXERGRJBQw9RFj6S4fvafvxLRTjtf
         iu/HQysYTuD3g==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3adba522a5dso637522b6e.2;
        Sat, 16 Sep 2023 08:55:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YzpElqZiDzijEwZPudDWcCTD1z/5ZKS/SLF9Wg9Txa7TZVGOgYZ
        sHqbXNu9sp7Z6/NTaN6aJzUZt1L7NkxzIn8bSgk=
X-Google-Smtp-Source: AGHT+IF88S2QLX44swt2RNrINmE4POOQwsa0NGIJBJ65q287dC2YJ/yh9EsEYy+jpPU3BV0W+MXtW0uZLCg9Sw7rqaU=
X-Received: by 2002:a05:6871:611:b0:1c8:d72a:d6ba with SMTP id
 w17-20020a056871061100b001c8d72ad6bamr5793850oan.45.1694879732849; Sat, 16
 Sep 2023 08:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net> <20230916-nolibc-initramfs-v1-1-4416ecedca6d@weissschuh.net>
In-Reply-To: <20230916-nolibc-initramfs-v1-1-4416ecedca6d@weissschuh.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 17 Sep 2023 00:54:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNATru0tQYF+Kehb33pJV8xQKBCUEHcoC_M3EX8xCrzQ-NA@mail.gmail.com>
Message-ID: <CAK7LNATru0tQYF+Kehb33pJV8xQKBCUEHcoC_M3EX8xCrzQ-NA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] kbuild: add toplevel target for usr/gen_init_cpio
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <shuah@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 16, 2023 at 4:13=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> The nolibc testsuite wants to generate an initrams without linking it
> into the kernel for which it needs access to gen_init_cpio.
> Add a new toplevel target for it so it can be built standalone.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> ---
>
> Kbuild maintainers:
>
> If there is a way that does not require modification of the toplevel
> Makefile that would be nice, too.
> I followed the example of the "scripts_unifdef" target.


This worked for me.


masahiro@zoe:~/ref/linux$ make -s mrproper
masahiro@zoe:~/ref/linux$ make -s defconfig
masahiro@zoe:~/ref/linux$ make run-command KBUILD_RUN_COMMAND=3D'$(MAKE)
$(build)=3Dusr usr/gen_init_cpio'
  HOSTCC  usr/gen_init_cpio








> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index ceb23eed4dce..1caa4429eceb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1812,6 +1812,10 @@ endif
>
>  endif # KBUILD_EXTMOD
>
> +PHONY +=3D usr_gen_init_cpio
> +usr_gen_init_cpio:
> +       $(Q)$(MAKE) $(build)=3Dusr usr/gen_init_cpio
> +
>  # ----------------------------------------------------------------------=
-----
>  # Modules
>
>
> --
> 2.42.0
>


--=20
Best Regards
Masahiro Yamada

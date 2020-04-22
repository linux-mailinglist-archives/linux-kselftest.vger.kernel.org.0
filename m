Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B4C1B48F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 17:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDVPm7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 11:42:59 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:26853 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgDVPm6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 11:42:58 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 03MFgfIw011166;
        Thu, 23 Apr 2020 00:42:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 03MFgfIw011166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587570162;
        bh=QUCpK3WJm1ifLwVFUS1q0umABM4aGa5XtBHT0c2+mZI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SOeQtnnrdnb/eEUI0PFq3PB954a4LsBSyQbyKqpLffygtHqhcDuAo4i+OnV4+02Zs
         Acl5Iw0lHqh+kcXXCeTZH/SqefvmZaygvWPSScOHx2D3aIULpkwax2jHJKwa/UqpJ4
         uTFOUgog6GvdsWAWh7c3pmyXdQk/Ajcp2OLvLqfi0EuNr5GQr3aeVE/3+styyqFqnF
         9WjVwezekrG9sppgUr2F54p207mqdYk1eEyoZX2fqT47qSf6DGj+f+nZC+lVAbZtHb
         9vzLk2eYJY35Hz65QrMQmyh3MiRTkOHw+eg7qNoiFe/msC6WhJ8yZmAAaOAYDJFjpg
         vawwuHBqHSneQ==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id c24so2091094uap.13;
        Wed, 22 Apr 2020 08:42:42 -0700 (PDT)
X-Gm-Message-State: AGi0PuYqtgv01NEyWzkzQUJam/OTOlm0SJzivg3WsIcjpuVluch5+qZ8
        AHgvl0GEBK4/G292lzRCf/BZRhKyFHZPV8/A2Os=
X-Google-Smtp-Source: APiQypJK53incbdlqtMV7txS87GEalFCanCE0tnP4L7TDOANgXMWvWbvu8aq1Ibl5jbYxROrMtBhknLCsbHyLbBk8fk=
X-Received: by 2002:a67:3293:: with SMTP id y141mr21234308vsy.54.1587570161183;
 Wed, 22 Apr 2020 08:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200422004844.53284-1-vitor@massaru.org>
In-Reply-To: <20200422004844.53284-1-vitor@massaru.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 23 Apr 2020 00:42:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASNBqQfMS49C9z7=opXeGv8-Y2DCDDQ2JqZPvMVZ6XwZg@mail.gmail.com>
Message-ID: <CAK7LNASNBqQfMS49C9z7=opXeGv8-Y2DCDDQ2JqZPvMVZ6XwZg@mail.gmail.com>
Subject: Re: [PATCH v3] um: ensure `make ARCH=um mrproper` removes arch/$(SUBARCH)/include/generated/
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 22, 2020 at 9:48 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> In this workflow:
>
> $ make ARCH=um defconfig && make ARCH=um -j8
>   [snip]
> $ make ARCH=um mrproper
>   [snip]
> $ make ARCH=um defconfig O=./build_um && make ARCH=um -j8 O=./build_um
>   [snip]
>   CC      scripts/mod/empty.o
> In file included from ../include/linux/types.h:6,
>                  from ../include/linux/mod_devicetable.h:12,
>                  from ../scripts/mod/devicetable-offsets.c:3:
> ../include/uapi/linux/types.h:5:10: fatal error: asm/types.h: No such file or directory
>     5 | #include <asm/types.h>
>       |          ^~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [../scripts/Makefile.build:100: scripts/mod/devicetable-offsets.s] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/home/iha/sdb/opensource/lkmp/linux-kselftest.git/Makefile:1140: prepare0] Error 2
> make[1]: Leaving directory '/home/iha/sdb/opensource/lkmp/linux-kselftest.git/build_um'
> make: *** [Makefile:180: sub-make] Error 2
>
> The cause of the error was because arch/$(SUBARCH)/include/generated files
> weren't properly cleaned by `make ARCH=um mrproper`.
>
> Fixes: a788b2ed81ab ("kbuild: check arch/$(SRCARCH)/include/generated
> before out-of-tree build").
> Reported-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Link: https://groups.google.com/forum/#!msg/kunit-dev/QmA27YEgEgI/hvS1kiz2CwAJ


Applied to linux-kbuild/fixes.
Thanks.



> ---
> v2:
>  * Explains what this PATCH does and the importance as suggested
>    by Brendan Higgins.
> v3:
>  * This problem only affects ARCH=um builds then arch/um/Makefile has
>    been changed as suggested by Masahiro Yamada;
>  * And with that the description has also been changed, and also to explain
>    missing points and correct the tags as suggested by Masahiro Yamada:
>    - Fix missing command `make ARCH=um mrproper`;
>    - Add build error message;
>    - Add "Fixes" tag instead of "This bug was ...";
>    - Add "Link" tag instead of "Related bug ...";
>    - Add Reported-by and Suggested-by;
> ---
>  arch/um/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index d2daa206872d..275f5ffdf6f0 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -140,6 +140,7 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
>  # When cleaning we don't include .config, so we don't include
>  # TT or skas makefiles and don't clean skas_ptregs.h.
>  CLEAN_FILES += linux x.i gmon.out
> +MRPROPER_DIRS += arch/$(SUBARCH)/include/generated
>
>  archclean:
>         @find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada

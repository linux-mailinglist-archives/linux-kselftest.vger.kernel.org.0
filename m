Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C508B5E5F72
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 12:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiIVKKE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 06:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiIVKJq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 06:09:46 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7444B2FFC5
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 03:09:40 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id u189so9732477vsb.4
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rXYQao7eqgpJ8yFCJfVW72NnGbdt1aa3bK5h76VLyPc=;
        b=UMRT5rt7MMxvw0quM5dGn7W+GhePsfVdIhhCQ2VzJb8oPPFxDeF0gl1cJ5ScmkxW+a
         1c1uknbuWadHMYp5MQAKWv0FGQWNkpUP6UxY1YWBo5ePMZTx9UlMkw2KGmiQBk1y0hkr
         vU6+eLMAO8v/u0Cy28j7DsfChfDvtVBBB3G5xlDYE2gPJzyJ0YeJOZ4Ptm3/i5tGnNxm
         2DgmEERS4LsrKkkbwaqjAPCg1T2msNIXka3LbwFLPw7tqbTDUvlaeJbhdIfRaYroUT2O
         ub7V7TKzN/5+O1ATnb3364vLp6qbXEtE1L8dAHyYVUepG0GTEwQgae0wtK8+QMAh0QBb
         PQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rXYQao7eqgpJ8yFCJfVW72NnGbdt1aa3bK5h76VLyPc=;
        b=FjwU6xRcZCU6B9K1rmIO7KBL/hNCyvtGyxLAkZttSAbwZ2kEpvmxpJw/Bs0gi0ovPz
         Rkn5oyv2haZVjfO4+F0U+BEyEo/jG3V2iYeh2Rl8d0V+IvEgVnRjXVq43BpbcV8YqTL8
         wTWoBZ8U2ctEXTsyKSxJXUvuqGyLASqLp/A07nEwY9cvsRcnHjDzK69F76o1FOI7AvRP
         hwc8j/mEYqZ4PalPYPpY7RzY1Nt9g+cNQ7UX3rhYoEPYQsl7YdrjTL15vLxArc96RoDP
         1w/Zzw/Yo450DGGC89S8QnnJj3+tn5BUk7vF9ibALJDsu2lA6uEO86uo/RdW8oaH9UnO
         qkpg==
X-Gm-Message-State: ACrzQf0qsOOLISCdoBnDrrAD0feZ/LbKBSRVD7BmaLFr5QwIjMHnty7b
        vXh/L8pLy5RKscibyfPBTzaxfPf2JF2mLjMjOcGkng==
X-Google-Smtp-Source: AMsMyM5W+/XmtiDTx1m3Iy367sWIO5+tA6oZoxV4Ol7g63s47Tlovfe2fZ1LsPJfm+ALQ7IuFsgY8Lw5p6GeCER5a3w=
X-Received: by 2002:a67:c891:0:b0:398:a7ff:e0f0 with SMTP id
 v17-20020a67c891000000b00398a7ffe0f0mr903256vsk.22.1663841379479; Thu, 22 Sep
 2022 03:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220922083610.235936-1-xu.panda@zte.com.cn>
In-Reply-To: <20220922083610.235936-1-xu.panda@zte.com.cn>
From:   David Gow <davidgow@google.com>
Date:   Thu, 22 Sep 2022 18:09:28 +0800
Message-ID: <CABVgOSkjmuWDVwOW5PQRAtDYJGjHjcc_8Gg4JjhiT41Kez1rcw@mail.gmail.com>
Subject: Re: [PATCH linux-next] kunit: tool: use absolute path for wget
To:     cgel.zte@gmail.com
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 22, 2022 at 4:36 PM <cgel.zte@gmail.com> wrote:
>
> From: Xu Panda <xu.panda@zte.com.cn>
>
> Not using absolute path when invoking wget can lead to serious
> security issues.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---

This seems mostly okay to me -- we'd be abandoning people who have
wget in an unusual location, but I don't think there are many people
who want to run KUnit under RISC-V, have wget in a non-standard
location, and can't acquire the bios file themselves.

So this is:
Reviewed-by: David Gow <davidgow@google.com>

However, would a patch like this make _more_ sense? It looks like (at
least on Debian and Arch), the OpenSBI bios is installed as part of
the appropriate qemu package anyway, into a standard location.
---
diff --git a/tools/testing/kunit/qemu_configs/riscv.py
b/tools/testing/kunit/qemu_configs/riscv.py
index 6207be146d26..12a1d525978a 100644
--- a/tools/testing/kunit/qemu_configs/riscv.py
+++ b/tools/testing/kunit/qemu_configs/riscv.py
@@ -3,17 +3,13 @@ import os
import os.path
import sys

-GITHUB_OPENSBI_URL =
'https://github.com/qemu/qemu/raw/master/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin'
-OPENSBI_FILE = os.path.basename(GITHUB_OPENSBI_URL)
+OPENSBI_FILE = 'opensbi-riscv64-generic-fw_dynamic.bin'
+OPENSBI_PATH = '/usr/share/qemu/' + OPENSBI_FILE

-if not os.path.isfile(OPENSBI_FILE):
-       print('\n\nOpenSBI file is not in the current working directory.\n'
-             'Would you like me to download it for you from:\n' +
GITHUB_OPENSBI_URL + ' ?\n')
-       response = input('yes/[no]: ')
-       if response.strip() == 'yes':
-               os.system('wget ' + GITHUB_OPENSBI_URL)
-       else:
-               sys.exit()
+if not os.path.isfile(OPENSBI_PATH):
+       print('\n\nOpenSBI bios was not found in "' + OPENSBI_PATH + '".\n'
+             'Please ensure that qemu-system-riscv is installed, or
edit the path in "qemu_configs/riscv.py"\n')
+       sys.exit()

QEMU_ARCH = QemuArchParams(linux_arch='riscv',
                          kconfig='''
@@ -29,4 +25,4 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=y''',
                          extra_qemu_params=[
                                          '-machine', 'virt',
                                          '-cpu', 'rv64',
-                                          '-bios',
'opensbi-riscv64-generic-fw_dynamic.bin'])
+                                          '-bios', OPENSBI_PATH])
---

That way, we could avoid using wget at all. (I did confirm that this
is the only use of it anywhere in kunit_tool.)

The other options would be to use some python library to download it?

Thoughts?
-- David

>  tools/testing/kunit/qemu_configs/riscv.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
> index 6207be146d26..c3dcd654ca15 100644
> --- a/tools/testing/kunit/qemu_configs/riscv.py
> +++ b/tools/testing/kunit/qemu_configs/riscv.py
> @@ -11,7 +11,7 @@ if not os.path.isfile(OPENSBI_FILE):
>               'Would you like me to download it for you from:\n' + GITHUB_OPENSBI_URL + ' ?\n')
>         response = input('yes/[no]: ')
>         if response.strip() == 'yes':
> -               os.system('wget ' + GITHUB_OPENSBI_URL)
> +               os.system('/usr/bin/wget ' + GITHUB_OPENSBI_URL)
>         else:
>                 sys.exit()
>
> --
> 2.15.2
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220922083610.235936-1-xu.panda%40zte.com.cn.

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899727529FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 19:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGMRlK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 13:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjGMRlJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 13:41:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881622702
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 10:41:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e916b880so638897b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 10:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689270068; x=1691862068;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OqkDBXaCIKWCyUtI/utdXjJK6ILO2dw2E5EhKowuKG8=;
        b=Jvsy/OIIpifChDxYqBCBR/AjJpIJqkhfmZt34IsE9wQzGeRJQUgniM/cLx/uJCAcIt
         BYcsa1mQ3Z5eYT2svUHnyR6yRLJrtn6MUJcIdGN9LYPrWEYLrO10KrUpa8+mp32b4g8O
         fKBwBws+HQDTKcR6m4Yt6lVr4KH9b1YuSxBw2CJT7f+ZjSRLcKn3cHVKUKcai/c74xno
         nQAUZ8WfEzW23AkP6Zhkkvlb2uH88khvK6uyE09esNbOh4nk7FvaRhyLwrda4ms4+Oci
         4vQ6TY8Zup/A2EuTg1KQ1oYuic9GDjdDSEc4aL/JsuW4f9DiBkM35x8GxwW2WBirb9yt
         2cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689270068; x=1691862068;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqkDBXaCIKWCyUtI/utdXjJK6ILO2dw2E5EhKowuKG8=;
        b=i32ZoylQczmiVfRqcn94k8wSa4XOS7Vj1WpKboNnor4YbsJ1m3ZovhwYnbm8n8Hthj
         bQjCkulG/+YSBQePXrkRyqE7Zb7+b/bieWiRB2UVfzaPCEiSy//ClB24+2vyph3JO8j/
         QcMKdlOqZDIQYDZT5ZkXCEpaTHxwA13b/jYnVMEs64+fbHX6e/oh4Ssg00QcA8E6ykVS
         Xw08rmzA1VAmR8W1QLya4xjBaUKV/2vdLsFUwSUKeD0JT/EYIjdHObR7lLDtSt1vmD7u
         Lg1cx0GJbjRFmCuUmgISMgZXWooqJf0GHvolsxea8i20gVYy6Lqv/IUKO2M1uKKmpqYj
         NRug==
X-Gm-Message-State: ABy/qLao9Hu0XCUZQPC+0eujx0Iw9UPwj59QaOh8m8QRKGmC1SJ7DEJm
        uRy128oSh7aZA2MrdZfxvem01g==
X-Google-Smtp-Source: APBJJlEnqOCMzcu+FQg/nu4o7Aaf2GLNcqaKQFSz8vOK0tltu4GRhHsmuCLWprHHLK7HIVulRnkT1g==
X-Received: by 2002:a05:6a20:4406:b0:131:b3fa:eaaa with SMTP id ce6-20020a056a20440600b00131b3faeaaamr1971594pzb.61.1689270068013;
        Thu, 13 Jul 2023 10:41:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t21-20020a62ea15000000b00666b012baedsm5696281pfh.158.2023.07.13.10.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:41:07 -0700 (PDT)
Message-ID: <64b03733.620a0220.56d6e.c571@mx.google.com>
Date:   Thu, 13 Jul 2023 10:41:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.5-rc1
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 5 builds: 0 failed, 5 passed,
 4 warnings (v6.5-rc1)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 5 builds: 0 failed, 5 passed, 4 warnings (v6.5-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.5-rc1/

Tree: kselftest
Branch: next
Git Describe: v6.5-rc1
Git Commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (gcc-10): 3 warnings
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: relocate_range+0xbb
    1    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: .altinstr_replacement+0x1d1e: redunda=
nt UACCESS disable

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 war=
nings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: .altinstr_replacement+0x1d1e: redundant UA=
CCESS disable
    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled
    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: relocate_range+0xbb

---
For more info write to <info@kernelci.org>

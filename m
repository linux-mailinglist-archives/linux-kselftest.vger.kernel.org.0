Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D01B72341E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 02:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjFFAlP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 20:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjFFAlO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 20:41:14 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25192A6
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 17:41:13 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-19f30256921so6023118fac.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 17:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686012072; x=1688604072;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e+q9AoeHvh99mag7NH2DZgUzy55/CHUrfq3AJ23nQd0=;
        b=GxDqm6Voz7HVrh878QTThF5QbUIXhGSq/m0sO/M2FvGWRlaKGkenxVlYLJLBCJWHlT
         JygpsFidK/prVd1MPiDKNgZMcg+wvYYKMGayQNYqESciZnRFEfu9Itq+J+TlRdrqFSb3
         k7PobnSfDB4YxO9utQetN9uLKSK63xXnREIjQk41GLBlPmy3XeKCkU6oGH67wo6gztQA
         atSNB5C1oyllTqPmiut8YYve9CMQxHzRKr1YrtOKMEhR3S9xHtCB1y2inlM9nFFuOiTK
         x+rgChk2KCIzt3Y5S9SZyXoQpYEbkr95BFmPLn4WV8692kjU7uYLejcnoyF3wPnBmOvD
         PqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686012072; x=1688604072;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+q9AoeHvh99mag7NH2DZgUzy55/CHUrfq3AJ23nQd0=;
        b=lxutu3lpNFjfwPlbcIMecJopDottN8Xyjlqax+2iCUMwBhPHpKxEUYD9vwqCEVfjxm
         DzO1Vl65fG5wuaDzdiTbDuou8aQyRwHWAOtX9VXF+Pno/bp7buiT+6q5SViX8TekD4cx
         cbjf9Go6cgcaa33/pavm1TgY08f/UCMbJrR8SNvWHdGUu/wE35lQ1xCSKTn85g2oWbVs
         8yzrbQYqEVtcuG353JV9h068q1SKcyGqeKYyEpHFRK+S7bG7qqMSNx4VreNSJUWSR9+8
         KpHVcKqab8wSZViWWDf/WOeLPoR8wfspiyu3m1KiV6R9A+ULAMOMxB57cvGOy54tqNSd
         yGEQ==
X-Gm-Message-State: AC+VfDyFsSOQfP44PE+NUh0JjOIanYVLx9AS495+6sQxX91ekyVPPLoU
        1Ll5JY082MbzeqYixWQ/AUv0yg==
X-Google-Smtp-Source: ACHHUZ7samqXZE6HDb79xA9uejBTsK8VstRYWQCjM2ybUEvgyBCNd9jgZ/Etd+zoe8+j5vSo6hhSGg==
X-Received: by 2002:a05:6359:a90:b0:129:ce83:d541 with SMTP id em16-20020a0563590a9000b00129ce83d541mr785280rwb.21.1686012072364;
        Mon, 05 Jun 2023 17:41:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ng13-20020a17090b1a8d00b002564dc3cb60sm6398789pjb.9.2023.06.05.17.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:41:11 -0700 (PDT)
Message-ID: <647e80a7.170a0220.50da5.b79e@mx.google.com>
Date:   Mon, 05 Jun 2023 17:41:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc1-8-gd909ae0a8562
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 6 warnings (v6.4-rc1-8-gd909ae0a8562)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 6 builds: 0 failed, 6 passed, 6 warnings (v6.4-rc1-8-=
gd909ae0a8562)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.4-rc1-8-gd909ae0a8562/

Tree: kselftest
Branch: next
Git Describe: v6.4-rc1-8-gd909ae0a8562
Git Commit: d909ae0a8562b404eb1aa9dae6b2f15c9e163984
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 3 warnings
    x86_64_defconfig+kselftest (gcc-10): 3 warnings


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to=
 !ENDBR: .text+0x1423b6
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to=
 !ENDBR: .text+0x14252b
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to =
!ENDBR: native_write_cr4+0x4
    1    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: .altinstr_replacement+0x1d1b: redunda=
nt UACCESS disable

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 3 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x28: relocation to !END=
BR: .text+0x14252b
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x3e: relocation to !END=
BR: .text+0x1423b6
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xca: relocation to !ENDB=
R: native_write_cr4+0x4

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 war=
nings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: .altinstr_replacement+0x1d1b: redundant UA=
CCESS disable
    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled
    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled

---
For more info write to <info@kernelci.org>

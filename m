Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214EF4ADBF0
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 16:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379433AbiBHPEn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 10:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379219AbiBHPEm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 10:04:42 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD30C061576
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 07:04:42 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so3078913pjb.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 07:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=a3HMhKGW03/GkK4KihmFBpv/X/TX7fFT30mI4jqwmLM=;
        b=rKQ9RV4/gQkA7R1OiinKZa7fu61LH/yCOtIMHIQ9V+cLenXTU2LezRjjKb90dYsVFp
         oasLbFLfTxkXuo2iTGMXqbFgfoYzCOysiCdlGL7Zhg+OlQqcgKgpf7YkJcXjCKc5XZ6j
         /jloVWO91mQWIrkoDXOgxlSKT0eEz5hyx3DzVPDHxRmUUuhefaljG0Zkeio3UehiWAdc
         2aHMwTNwS7LzbxQ4+r0/QVFNGvFXgjWquScMg76xCh74dhBifYo3FewJPg8JsUXvNn2X
         xY/DQeXN0wWPF0QNVkzStMsdmxoFy80uZsMmQrc7gdM3D+eB+DSYyow+WdvYWEscqA4m
         kg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=a3HMhKGW03/GkK4KihmFBpv/X/TX7fFT30mI4jqwmLM=;
        b=5gt683L4KQSeKZ1u/so+Hp4eZTjuTfa2I4Xy5dtcJ9dNevSZ/qY24MucQRR5LM5LNY
         v4/h1Qn6+uuac2jnFXOQI4zAUrIjOcXYzZxYlL3xzJNtwqjNTgIME4hDfjOPRRJvpTBV
         NIM53bsVuIyLIBdvVX76ErUGAq0KOV+SpEO96RkA2EnqGumnX6p0ziDV1n4/5I/fxlUu
         x21c5L8C69G7jtvSgaTPb69sTaKFpV+eu3DZcky/cJt7HvdAkCRWstukiplCRgJsSyXV
         dam7SMTuAIk9d9igZQmoMGTdCEIBmwgYp1vgoDEMm+Wi5uG3rzNdNid2PZ/QViF/xkiC
         3/AA==
X-Gm-Message-State: AOAM532XYvHzIvO5hHvID7QoB/Zs9Y03fcIYj0J9rDU6d2zT8Y88Qly+
        rx7nKtQoZ9S6to/ZvPy8/sjXugfrEMxMxJDc
X-Google-Smtp-Source: ABdhPJyEhMAA+pixgY6UZrRTx2CSyCkKrilHo+1q7HQRAt0/UvMw387nI9iiYh/wW8703NxFWadQNA==
X-Received: by 2002:a17:90b:3e8e:: with SMTP id rj14mr1810781pjb.112.1644332681523;
        Tue, 08 Feb 2022 07:04:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m68sm2519502pga.10.2022.02.08.07.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 07:04:41 -0800 (PST)
Message-ID: <62028689.1c69fb81.901d.5e69@mx.google.com>
Date:   Tue, 08 Feb 2022 07:04:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: linux-kselftest-fixes-5.17-rc3-3-g183f80fd72db
Subject: kselftest/fixes build: 8 builds: 0 failed, 8 passed,
 1 warning (linux-kselftest-fixes-5.17-rc3-3-g183f80fd72db)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes build: 8 builds: 0 failed, 8 passed, 1 warning (linux-kself=
test-fixes-5.17-rc3-3-g183f80fd72db)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-5.17-rc3-3-g183f80fd72db/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-5.17-rc3-3-g183f80fd72db
Git Commit: 183f80fd72db42c9cc483aa7a5e8e881355d0b03
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-14): 1 warning


Warnings summary:

    1    net/core/skbuff.o: warning: objtool: skb_copy()+0x132: unreachable=
 instruction

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
defconfig+kselftest (arm64, clang-14) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-14) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    net/core/skbuff.o: warning: objtool: skb_copy()+0x132: unreachable inst=
ruction

---
For more info write to <info@kernelci.org>

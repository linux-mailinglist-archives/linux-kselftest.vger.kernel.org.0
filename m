Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ED1612AAA
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 14:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJ3NEP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 09:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3NEP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 09:04:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65233B7F8
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 06:04:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b185so8535201pfb.9
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 06:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x8Q5V/hEyzT5GSg4hevtw2Az212298Ph3py1LZ+ezSw=;
        b=tXnyMuF36x+Iqp8oyM7Ic3fxT43tMNQoZK/hGX0qrgeKf0NQQH5FpwZlnGLUOotSAL
         6I53B9h1fX0lEPw7hvaxsn9h/DnjtshMHG6EEu6BtyHfQJXtXBekSXIUKHSBa8/6X0YS
         CzUOiwp5X1zXAYSuj4iakyE5JIuqdk0YvMrBoDa4kZmNJxL1nnsGclnOZ7wQWOMW+OYN
         pPYDsTH18MagUQOgSjpNg0jBJ/NiQAgboEX/inS7cCaWiLdH+/DSMtfAJ8ZcC6UxkK7L
         sF4sZyZtwWuV9l3qaD3h4KN68LGB+6P/jm76R5MwI1Wvevuzx4UvMrxQ/mGAGyQDRKtk
         hmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8Q5V/hEyzT5GSg4hevtw2Az212298Ph3py1LZ+ezSw=;
        b=yOk7+hCIhvqdG8HRmpDhd9d9/FHT9eGd+vRw27FtmyJkbgjh/c02+ccc4YdF5LGiBN
         0ResDGQVa98west1bdy6sgYiudJYXcfmOSZ8IaJ22ah/nd+SB45GJoMBtNuEgkM22hdX
         xXq17PpihneUnV+H5cui/7XHLyp8Jf/uEv2BkMxzyFuytcGvhzIdPUtGYfMXTGByowij
         k0HdrxrQEUHhk5MZ3RTP1UdBDMCK3ero4RRc0wAraW47dVF3+TBa2OqsdsGlEDWtykEX
         CUX0JAIqDFjx5TF29yeknOEbOyIcoP9ChelDQggSHZ5qwVVgQLwFhmS2K+uk4DJpkJ8q
         Q7UQ==
X-Gm-Message-State: ACrzQf2aJNRYKxQMf7dwJZIorrU2KGtHPUHg6GwE3hudHACwGK1Qw8Wj
        /YG+4cMjLLzYi0Yr6PwpXC09VA==
X-Google-Smtp-Source: AMsMyM6JMqBz/sAFtYJrOhdIeGbCQGqTuB+7lwV6Lvf00EfZtjjJm9am5zYzObyLlXGRucvczQ/o8Q==
X-Received: by 2002:a62:7bc5:0:b0:56b:47ed:22a7 with SMTP id w188-20020a627bc5000000b0056b47ed22a7mr9117421pfc.63.1667135053914;
        Sun, 30 Oct 2022 06:04:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w3-20020a636203000000b00442c70b659esm2307439pgb.91.2022.10.30.06.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 06:04:13 -0700 (PDT)
Message-ID: <635e764d.630a0220.a3ad0.3641@mx.google.com>
Date:   Sun, 30 Oct 2022 06:04:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 6 builds: 0 failed, 6 passed,
 1 error (linux-kselftest-fixes-6.1-rc3-2-g3d982441308e)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes build: 6 builds: 0 failed, 6 passed, 1 error (linux-kselfte=
st-fixes-6.1-rc3-2-g3d982441308e)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-6.1-rc3-2-g3d982441308e/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e
Git Commit: 3d982441308ebdf713771c8a85c23d9b8b66b4d4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Errors Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 1 error

Errors summary:

    1    error: write on a pipe with no reader


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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 1 error, 0 wa=
rnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

---
For more info write to <info@kernelci.org>

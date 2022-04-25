Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E353A50EC3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 00:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiDYWot (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 18:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiDYWot (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 18:44:49 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B3847061
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 15:41:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id i62so2339442pgd.6
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 15:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aBGVYRbOlCh6Ue9K/GoQ87k/o2uyAhkCXLkg3K3iEQs=;
        b=tA2I9kM+yK+I//AoLjE6KWp9n/12xG3/DZwnmZTyuJAWJkD7xSxtkJPx8c6akrKh3X
         8vXQEBGQIY6Oxoc4uOc6rCB550tfAJqjks/ymYElc8giGWPOYYRpsOjvVP/Dyr2gyMqR
         6XjpAeSOaHqMFOd3OMsWff0kPMEOz/mfJ3rKxvP6dW7gcudNLKkMvS3aE8M6ipK/2xQ9
         MTM/yFEwBwq+RhDesdP15sfQaP2UqeGex5zS35i6SFOAKgAgZaau5tIzttgXurrK2tCB
         ZkwaKdFan12J0WXzOAlyz8JK5fMw/PJs706mHavrjZNzmuMwII38ASYhGdG1udqOVDp1
         eWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aBGVYRbOlCh6Ue9K/GoQ87k/o2uyAhkCXLkg3K3iEQs=;
        b=5gWv0tlF3ATdkUW9dNb9oMgCM4o1uwubQsvsSPq5MSca/a5A2bhC93b3P0EYvKUJWI
         I7ZsVCyoabbkTtKKxpdQtAJmAKOayv+kX1F3mIrc8XWg1Bhc6ewR4dmDqyL5rlG0HYCH
         CN+twPvFr9Pe7fna1kh8C/x43NvAm4Ou9Y8Bdk/Ajpftbsfu2frSTTDDh5fFtnCi8oaO
         d2VtF5dD6f5quF8a1gBtf23tFVNCk93w91OwK34VuoH5mSLqVXuQT4IOuIDVPYrA9mdC
         MbG/qqBRHTrEbA6HwX2ZRA5TvVnR9racGGZLVGhuXjoP9Ydq9aY/yqgl6x5fXyUsNPg6
         BT8A==
X-Gm-Message-State: AOAM530xkvx/VNnSFSGiDnb4KRoBJe1Fe4wFoiuQYaPAfkhOgEBtCQAM
        qUQXBK9nrGPcP8dNoGZOd0+1DjLpHBtHWi0L7H0=
X-Google-Smtp-Source: ABdhPJy8HC3IIqDc6hOLMyKzl5vjhoA1Hb3UeKY/tkWtDyektWrpmUb12trnpDTY3SpkAlXXKDnXbA==
X-Received: by 2002:a63:6bc6:0:b0:39d:966d:2791 with SMTP id g189-20020a636bc6000000b0039d966d2791mr17048347pgc.407.1650926503507;
        Mon, 25 Apr 2022 15:41:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x4-20020a628604000000b0050d2ff56603sm6960453pfd.60.2022.04.25.15.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 15:41:43 -0700 (PDT)
Message-ID: <626723a7.1c69fb81.7b31a.09d8@mx.google.com>
Date:   Mon, 25 Apr 2022 15:41:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.18-rc3-9-g170d1c23f2a3
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (v5.18-rc3-9-g170d1c23f2a3)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (v5.18-rc3-9-g170d1c23f2=
a3)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.18-rc3-9-g170d1c23f2a3/

Tree: kselftest
Branch: next
Git Describe: v5.18-rc3-9-g170d1c23f2a3
Git Commit: 170d1c23f2a356932259034f73d579d0bab857d6
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

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
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

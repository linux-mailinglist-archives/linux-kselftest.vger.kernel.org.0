Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0462C836
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 19:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiKPSwj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 13:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239252AbiKPSvj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 13:51:39 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55583657C5
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 10:49:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id k15so18348999pfg.2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 10:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pwY7ylK/W9bWYrW6bqtFmToloYfXr8fzRDWmhFBj+kQ=;
        b=5v0jYIJP0cmTDXBbZBnfqf3fYMu/pCojDYll5QFqeI/81XmdKIIZTfdnd3jEDC8NB5
         bi6IDlH8G1yys5zTDmC+re9W3tTA6pgWViFsBZ6U7VLqMwT3Tt8opOoZiG/dbFnmo+fj
         iW+gjvTmeZvtxefoQQ/f967fftlgT0acx2T0t4iC4VzNPz5M3z68Q3HLCkYXFaUdFVkL
         1EpHWqtjp8qag4qql7P/fjVty59Ya4+ti7G6XsvmXlz1umDpeILec8PLHPwpmMY93U+m
         t5V5o19WFLx7U6wQHy8yKLQ2wTF3Rfiu4N0YWpP8qvR3BBGKVlVM84D/NbZ9Huw8OEGm
         lJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwY7ylK/W9bWYrW6bqtFmToloYfXr8fzRDWmhFBj+kQ=;
        b=dm8SrnuR2xDPKpsZZRLqykGkLoP9THNT4QBSjyXiaQ4cF1yOVqIQGQUg6ZZ64IUut9
         6qj4NOgC9YiXuR28jE3steUe0MiBX+KCPj0cioUMb6jAh70MhsynDSiEjaxxCQXeuVNN
         U5tyCyasNqGBhc7p3AxLkT8Q1i+nNOfE1m7jvwJ3+BDbwEUly/OiQepFVoU7MBXcrao/
         JlR8Zxd91E1FbENeoZLlUxHMVlpGQXytTHPh6Zcj2EfZazcjgdrsZJeigb0v0umSQQ2J
         yzZ2NU+Yw3WOQlM3U0mRMsxb9quruIECY523Xaha1R5LXWfxp+PpBUbgw1/q/wbe13VZ
         /nqQ==
X-Gm-Message-State: ANoB5pnqgqmnPUn2yOT6xr4X767hyM29DQikGIkZfhRzXLitNOPv34MJ
        1vJ0iTT0T5/dJPNMGGBELjnmlME4YrJ/CyuoQ4w=
X-Google-Smtp-Source: AA0mqf4dyrnCynqVjks75VF9SpkQjYnKGAJexWLM2V3m3z7XNdG8i4c/P+wZ/kk+fGHtv8tklo/Ceg==
X-Received: by 2002:a63:580c:0:b0:442:c653:677d with SMTP id m12-20020a63580c000000b00442c653677dmr21697145pgb.43.1668624546924;
        Wed, 16 Nov 2022 10:49:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902e88500b00177f82f0789sm12721967plg.198.2022.11.16.10.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:49:06 -0800 (PST)
Message-ID: <637530a2.170a0220.8e0a3.3df0@mx.google.com>
Date:   Wed, 16 Nov 2022 10:49:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-17-g2dfb010d2aaf
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed,
 3 errors (v6.1-rc1-17-g2dfb010d2aaf)
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

kselftest/next build: 8 builds: 0 failed, 8 passed, 3 errors (v6.1-rc1-17-g=
2dfb010d2aaf)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-17-g2dfb010d2aaf/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-17-g2dfb010d2aaf
Git Commit: 2dfb010d2aafceeab23ccd502c77784006adedd7
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Errors Detected:

arm64:
    defconfig+kselftest (clang-15): 1 error
    defconfig+kselftest+arm64-chromebook (clang-15): 1 error

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 1 error

Errors summary:

    3    error: write on a pipe with no reader


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
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 1 error, 0 warnings, =
0 section mismatches

Errors:
    error: write on a pipe with no reader

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 1 er=
ror, 0 warnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

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

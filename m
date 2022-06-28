Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F205155C18F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiF1BK0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbiF1BKZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 21:10:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E16522539
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 18:10:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so11094671pjz.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 18:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nD4DMCHUrIRwLcII3AV0T10lD6dos5x8cAqiix+Ze5Q=;
        b=hoR3vReZ3edxeIqLcYxLGQ38Db9h3Zo0PQ+AkQH270Nvrl+maajvaWK+prJjtn5VSI
         Axavf4CeGecdJTYX1MJ5tmU2EhgbaJEf7uWXqgJNUDvpnoh0NZDYfKwQD3xCjIWfHWgQ
         qqjXByhlTsG9cwiQoDr0q4Zrhmal4h1ecjcLX8S6SFMqO/b09l7yLql5YYVtSs0s3wcl
         W0njUn7PxwVoMqU3h0z7rIroVoDepPeoRNHoZxLXimiCbyvI7T+4YdLw0zwkDQsc2YWm
         B3Y32kF1gni0HC1E3GZ1CVOBCVp/aci+LyWA4zRyCBcedLdxjrBVvfjq6CmxD/vTE3Dw
         HFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nD4DMCHUrIRwLcII3AV0T10lD6dos5x8cAqiix+Ze5Q=;
        b=kiKH5dvcmSZd/nl+KGxnr3fchgXCYwq0ztB6GkyC9yFYjJznlH8NxGuYV3GKsp6UFF
         xMln5hKpL9wULkAqzptfgoovTR6VjAcYJ8I3Q6UU7jCI6Hyu141x4SrIU62r0vyfRMZW
         Yz3e94pi/04rgDgDn1yCiOcwyCRZZb7KQl207ZtSoP2aQlLOjLkvELkz/AZnxFqUwJJB
         hq2zzXmBLKw5Hg8f/O19jEhi9jPeFyQDELNmhmGlkURQlMmvh/83VKbeSX90EjLb9O+H
         uGzzuOrYEKfkFAq3Uhm5zYkUp2pVDP/3BjiXzxHokwYtTOL7DWrhh0SyfBDv/gA8OUjo
         qHLA==
X-Gm-Message-State: AJIora8GWVY96og7DqBjbcYKDtN4mmpVGs/YSawvz2nRz1op/ee2OA1N
        Vs0WSsNgpdjZ7M6gJr9Z3RptyQ==
X-Google-Smtp-Source: AGRyM1vWwzZeCJxSCCppedxuRyCzyVGFySUDtSqBZ74UsU7q00oEvthV1ZWvXQlq75DI33X+mOXwLw==
X-Received: by 2002:a17:90a:5b0d:b0:1ea:d1ed:186e with SMTP id o13-20020a17090a5b0d00b001ead1ed186emr18581307pji.240.1656378624541;
        Mon, 27 Jun 2022 18:10:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902e14100b0015ea95948ebsm7830457pla.134.2022.06.27.18.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 18:10:23 -0700 (PDT)
Message-ID: <62ba54ff.1c69fb81.c24b0.b108@mx.google.com>
Date:   Mon, 27 Jun 2022 18:10:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc4-4-g43fe0cc46b62
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (v5.19-rc4-4-g43fe0cc46b62)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (v5.19-rc4-4-g43fe0cc46b=
62)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.19-rc4-4-g43fe0cc46b62/

Tree: kselftest
Branch: next
Git Describe: v5.19-rc4-4-g43fe0cc46b62
Git Commit: 43fe0cc46b6206b25f0f13bb249f0078441ae15a
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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---
For more info write to <info@kernelci.org>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A74555F043
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 23:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiF1VST (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jun 2022 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiF1VSS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jun 2022 17:18:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5911101
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jun 2022 14:18:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so13951103pjj.5
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jun 2022 14:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0VjKU6LP03CdQP77ekXA2LJzLAiUUoI8+vdCqr3dJcc=;
        b=vk407TwT2mYSPpxZ+PZzv+/xX5syHS59eoqFzTgEYlnQ2e3ihonDgHuyYZSuoMOSUn
         LR/mVJE7TSzV+KD7DNE3AJtJ6ij0/Rqhi/xnTJqcUKOgyIgga8bru5L6oqlbDD+W2+CL
         yzJmFRyfOStwMvc0AxTAeYDYpxotMd5JGueMSCUeIP+YjovTYSeP0LY2wj1Otx9miKjK
         FFjXMjE9q2AkxnvHNo1pihCyFb71HCpUsAeYTlE1gY7dEtKjNw7Xr812Ndfo0wHk6Snc
         SUnuWbPev1G+MreFfgvH22ptUdr6pD+zb1a3UmM9UpTI75rRctGdhbYncZDZQnMcj8Ev
         YJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0VjKU6LP03CdQP77ekXA2LJzLAiUUoI8+vdCqr3dJcc=;
        b=6NDZ/vyZ7rM1LYt0DVF9zA5dlaxlfG1E+gLCVLGel+r1eebruTOkESIUQJ6AhQi7YX
         W6SAFj09D4D8TIs9pX/VbjrqtZ6tEWqFMlDhXpbW0H+9tmh3ayjyNKj1hEde1FrYd2Hk
         i4TLCSGm3xKvvSm+JdgCJp2dsCRptRy5sVDHaJ4HzVe3RD1Vg6xbZuBao+57A6xFLSwW
         xtkNZ7gP9hkqEByQ+a5Ya7aeNMJJtW4nj43+dWG6h2I05QDyzNJfqOzWH4BG9bGDoGNx
         LX1Wv5zf5Wptwme80A59iZ/142XeiqGfUjA7mLkZRsRNEcAfwmCM4ntFwTQeqD8ayeKE
         9E+w==
X-Gm-Message-State: AJIora8ljLTO8TkvIfkA5vAKRltc8FYBILgCVBDrWH1MKTxcI66Nr2fk
        JUhsLpYSzXqgZ+Ktvg4FHLe1nQ==
X-Google-Smtp-Source: AGRyM1vOeU7TKZ4FN0XcuAflIAcvTw28iO5YlyGUgZ3MQ0+tecWImLQvLQ/aM7GXbqR/bR7s20gGCg==
X-Received: by 2002:a17:903:32c8:b0:16a:6b37:7caa with SMTP id i8-20020a17090332c800b0016a6b377caamr5386491plr.143.1656451095633;
        Tue, 28 Jun 2022 14:18:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78e88000000b0052534ade61dsm9920487pfr.185.2022.06.28.14.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:18:15 -0700 (PDT)
Message-ID: <62bb7017.1c69fb81.dd665.dc33@mx.google.com>
Date:   Tue, 28 Jun 2022 14:18:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc4-6-g8587f3732b37
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 5 builds: 0 failed,
 5 passed (v5.19-rc4-6-g8587f3732b37)
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

kselftest/next build: 5 builds: 0 failed, 5 passed (v5.19-rc4-6-g8587f3732b=
37)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.19-rc4-6-g8587f3732b37/

Tree: kselftest
Branch: next
Git Describe: v5.19-rc4-6-g8587f3732b37
Git Commit: 8587f3732b37a39de205d8c42f5448dbe6aa6b55
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

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

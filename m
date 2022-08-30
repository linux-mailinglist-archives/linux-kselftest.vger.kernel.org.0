Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157595A586F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 02:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiH3AbY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 20:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiH3AbX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 20:31:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD9A7548A
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 17:31:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so6615684pjc.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 17:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=BGjEqs8A3VlI8mwO3ENfITjY/wUTNe13zyW/z2slut0=;
        b=Yqrj/LQGkvF+pgsbsft91rHVPrSBzHn9pre+fA9XMDqzoZsbxoizPxTdAoa1R7FBdB
         C6k1nl70iR+BiS1Y5X/yaBMmyPQkr6ImUO3PRzxsrzeJyg8X7jhFo0lnCdypxFfveQKF
         M1rzsJCC9tKUqnZ92/l0kofKQiWoajZSkSGyj7+p0hHM4gJxqIV/fomMAEvCLAxced7m
         8oNGcPdcSM0V58HDTpaWBIkzE6rC1qySD81/KGP1QvkjEid8cpklnhhODrohP5svLHSc
         ygZsdwFlE98Z6rJy1iimak4fLXiG+KZK1pwSUCuykBfAtENK0xyh7V2RvBd9+lw3Kb8w
         E8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=BGjEqs8A3VlI8mwO3ENfITjY/wUTNe13zyW/z2slut0=;
        b=s29ZZZQrG7GqcUl2dYTBbw4JPlptfzIraUyd9CO03l8EtxuqTWm15rDor99mmdGX9u
         UxA1USb3DNc6KqgyoyRfXQAaZikW1/rZKaS1HHZn48qc8WQr88dMZQqGFBWQiJRNMak1
         5e6p7ZNiTMGUuVbyr8Q/BI32OH4fP9trHt6WxpEX/kbnMMKOOKcAoep/92CepGWkwsxM
         KeojURFnO8g+gTL+Fs99rV2bPDFQGe/E9WRQJan20tAJ6rWUwaNoMJK8MgTSgnfFnWva
         VQKDLsvRfo5e069i3JeNCI3tYRJrLKEG5ML9BmvW5sEQSDainx5+z1oQ2OWIdhdOR1PR
         79GQ==
X-Gm-Message-State: ACgBeo1bS3dfmF6qJpEbF+enLFAurpV6kcrA8WnlJimxqS9OcrfsX93a
        gzo+fbTqxK77fMtuvW9XNOo3LQCz/YVtNrdHxwY=
X-Google-Smtp-Source: AA6agR6e+SFMQAJd2gjwgJSDLKzJC9AYRCL8e4kUzhSP9WH5d3cSUslUxmSCC/g4KulC5eYLYfpv2g==
X-Received: by 2002:a17:902:ce04:b0:172:9ff7:6747 with SMTP id k4-20020a170902ce0400b001729ff76747mr17873168plg.166.1661819480694;
        Mon, 29 Aug 2022 17:31:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78e88000000b00537aaf371d0sm7855451pfr.219.2022.08.29.17.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 17:31:19 -0700 (PDT)
Message-ID: <630d5a57.a70a0220.6ad5.dbdb@mx.google.com>
Date:   Mon, 29 Aug 2022 17:31:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux-kselftest-next-6.0-rc2-5-g997fdfc6b9c0
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (linux-kselftest-next-6.0-rc2-5-g997fdfc6b9c0)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (linux-kselftest-next-6.=
0-rc2-5-g997fdfc6b9c0)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/linux-kselftest-next-6.0-rc2-5-g997fdfc6b9c0/

Tree: kselftest
Branch: next
Git Describe: linux-kselftest-next-6.0-rc2-5-g997fdfc6b9c0
Git Commit: 997fdfc6b9c041be39ecb9a156cdeeea1a9a4379
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
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---
For more info write to <info@kernelci.org>

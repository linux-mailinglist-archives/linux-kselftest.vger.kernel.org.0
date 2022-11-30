Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A2163D5BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 13:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiK3Mjp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 07:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK3Mjo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 07:39:44 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC812792B
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 04:39:44 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k5so15567329pjo.5
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 04:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7t+VjT8PCtfoNIy2cxrNWlg3JA61gurg9flZBU7Hef4=;
        b=XwkKDEqqNvOOtaX6Wk16H8KDI4Dehve5vji+iIukV2eXX6b6MekSWVIkfzIqmuKQ2O
         hMtD0gvDCVT9mv5p/sWDg0ofoJyA0lrbJJRGnmgcKYyAfbLwenggKklkkdA5b+JpNNh7
         SONeKUV1Ft9aGpyegytHicYS67qOs9StGiBohDQ+GA0JrJ/fqLJZPFDouaRdNmHpPTkv
         UbgUq2ufSbHS1R1PJkHUzVAdLIgf4wCj43U4gYsHwE0HoiMUllbybDMot5ZLkG/w9qOh
         t8mooWkqhpmZiaO1e53jtYVzdvN20ZATuxKegZ9XAGRmISBW4PIQ6th7PEJITS7LcAOd
         Qxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7t+VjT8PCtfoNIy2cxrNWlg3JA61gurg9flZBU7Hef4=;
        b=EjzPIRWeIKuyOSk5DebQcfHElSbLaPFZPV9MXvt93SmDRCD7c794X17Mmxj5k8pdZQ
         A7pCwKjyNEO6BGKmXNo3ybGcsxHw9avWUrE8okQbvRqcx+jbsHOU3Nk1ssniGf45qGSg
         QkIDG8IQkvRYW6izFgQMRFpIFYyTEdx/jbz2pPlISV22bh+RMl0DcZIanGhuFfq9ctZd
         6oSOURltEYeSgZkAxGmP52VbYYDCEG7EfhTFXyiT4fVJ7AQrKQVOD2EMvFTFlJLF9UFN
         QM0akxX+8aD+PJ0aemGrZisCWtGuHzdwwQ3/fOU6xgbu0rcMAbaa25ZqfESD61zZoB/I
         rFyg==
X-Gm-Message-State: ANoB5pnW7H1nSbKhAK8jlnaQ3W3g1qsbT9vfBAFsEvUFEJ3BIRFlnpD9
        1ed+bTf9exvF8xpOwkzgKvvFqQ==
X-Google-Smtp-Source: AA0mqf7ukM9JLjU0okzsRuQ6aAC+Du7IGPke3jP8D9Y1BUdifsTjsH8rY4Vd8ISuBOSp07wa/JshNw==
X-Received: by 2002:a17:902:aa44:b0:189:fdf:a3d9 with SMTP id c4-20020a170902aa4400b001890fdfa3d9mr52374252plr.9.1669811983777;
        Wed, 30 Nov 2022 04:39:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e7-20020a630f07000000b004777c56747csm924950pgl.11.2022.11.30.04.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 04:39:43 -0800 (PST)
Message-ID: <63874f0f.630a0220.3ff59.1542@mx.google.com>
Date:   Wed, 30 Nov 2022 04:39:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-23-g8008d88e6d16
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (v6.1-rc1-23-g8008d88e6d16)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (v6.1-rc1-23-g8008d88e6d=
16)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-23-g8008d88e6d16/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-23-g8008d88e6d16
Git Commit: 8008d88e6d160c4e73de5be7c3dcc54e3ccccf49
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

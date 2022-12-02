Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA6640F32
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 21:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiLBUcR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 15:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLBUcP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 15:32:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392F6F231E
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 12:32:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so1881430pjb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 12:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=82HQ25SOW+7BawzlggLk8Z9iVz6G/lJZ/bIJCfwsoG4=;
        b=Hu/OZmM//+RRj3WA2TpSHImboz4Kvk2esX31yLmXio01sQU3QVHXkPN76J8Zwzqu/z
         qng8y2ZNcAIRwD3g5ggVquMBsvI9Tl2hn/RUjgrdLPr3IQ6Kf6Bz1v4LvSxB90ddoyKP
         TtEQOWz+kUtfMLxnaCD99UOhf5ExdLs/Y05CWqBV/Ac8MCfcuJxZmWKVGfTc82kxQ/T0
         TZXOkhVSaAOhwwbmcSfLEDxhWi+ksRI7gGS1otqlIvx6qZutLcziaV/xpT0ItZuvosEr
         x+XZMf7RRQ+hTsE1cI5issoBlsmTJOwwTJSFM5rFjKo0Zyz325/B+LcawVWIqT1YEXtm
         d1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82HQ25SOW+7BawzlggLk8Z9iVz6G/lJZ/bIJCfwsoG4=;
        b=oTJMrJlAWVyGAWqV/yMYxVd423uwcweOTBT7Fbh8zBdaQNGoACmvrs9VL87qfIyx2f
         rkV19fTE9MIHnoAaacVgDR7bl/D+4d/pw5m3fbdQVvjH5oX0briOAyvvDiYIi96igCGt
         hiRj6Eo0T8npu1+AABudmRNhJZpoCPrAc8n9xWgZJk+hGwoongaXdJ98BCfYzcBStROQ
         pNG+0i5/OxIOf97xiyqKEEYv58XtETVipmGYzfbPSahCggTGtc8hrBAHsxVka/QBJ5IK
         7j1dKTyBUIBgkVRX6wXGE9hQb+jp+zPr5R/PCrAViY6FNuOJ1sUOxtu+fyKv9OLo06Lr
         +DKg==
X-Gm-Message-State: ANoB5pnAGcEA29yc0lALWU7Gk95HNRUb7SAXmO+k0/wXyPKbE3IIrRtv
        2siJfDN1sWZztw85bqzmlI7bBoPgE2o32BNNFyYnrg==
X-Google-Smtp-Source: AA0mqf4pi06Gu7cjss554LkLzIwnYPEmyoUzv5Uz2LHn/g/xu0YownRjVRACAyu7MOcIBGRRAJj75Q==
X-Received: by 2002:a17:90a:c590:b0:219:56eb:6c19 with SMTP id l16-20020a17090ac59000b0021956eb6c19mr19668754pjt.29.1670013134695;
        Fri, 02 Dec 2022 12:32:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709029a0700b00172cb8b97a8sm6005018plp.5.2022.12.02.12.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 12:32:14 -0800 (PST)
Message-ID: <638a60ce.170a0220.d0c37.c509@mx.google.com>
Date:   Fri, 02 Dec 2022 12:32:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-24-gd5ba85d6d8be
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (v6.1-rc1-24-gd5ba85d6d8be)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (v6.1-rc1-24-gd5ba85d6d8=
be)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-24-gd5ba85d6d8be/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-24-gd5ba85d6d8be
Git Commit: d5ba85d6d8be7da660d4ac25761a48c74ade958d
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
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

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

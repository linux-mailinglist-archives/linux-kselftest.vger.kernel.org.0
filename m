Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A2D4F4CE3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 03:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiDEXfw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Apr 2022 19:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457248AbiDEQC7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Apr 2022 12:02:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB3FA191
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Apr 2022 08:35:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o20so5480332pla.13
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Apr 2022 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=E3viHWyrw88OQ52bbc6yL0DIf4/ILOrBz/b75V+55e4=;
        b=y2+d1AF3ktdlgpctLqVj9g7Sn0CRyh8kfMIpiz4aeR5vj6UnGBYGpEP054g3xeFFHN
         iB0qMSlINmWNHZ6FU8limmEQP0LUDuK7S2Wv7FhkTTDNDEgX4jGT5VcMkcNJ+o9Ix5Sj
         uLETkGv0pjgLDhGplHUl0cgMGn9M8sNHIXuexdJ1dBw6fdVmjwyemlWjQH4z1kaGgLXt
         1EvdG+I4os7C8LrO8pzOHmLelRkxPUyqOfSVk6YQZ9g8aDkIKbNiWYS/7JC8Y0RaRRfo
         hfV3XBnTwskpFdc1uGMN0p68Bb7JM7r9SPUYPXruT/nMslbCWDVzh5gTndfDMckDr7Vn
         fGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=E3viHWyrw88OQ52bbc6yL0DIf4/ILOrBz/b75V+55e4=;
        b=tjk7ZDFtqIF0iAlEVexfgix4xZ1pwB/M2DTf2y4FAwQNjGE/0KYgS78N9eRffyq0we
         IYnNOummNU8GNREh5kwydGlZNg1APp0C3WDMuuVSxFdgXkk3ejNy4visMp7QiI3J4SQC
         YiitDw/mJYjx4a0Hz1PcbHuZbVSupShb+Dv1Ivvm36u0e/aywi95JYvGnhFj+3HKQ8hu
         AwaUQ4nzr4Y6W9rO+DxJMXLqQ9KwgmNaXclny1jTn8iMubfoR/YkEGKm+hgzoAk4MR/M
         RTqck8Gs4qh6RIgXc1G2W793SYcqKfoEGaXuFyplWY0xtCzlpm9ifsEggMz94vCK03sz
         R3Rg==
X-Gm-Message-State: AOAM5330KOjZFihiKZe7gJUk1e8LyWUL1wIjIURpzzgXug9RLUxMY2Jd
        gj4bmyhERqlLCamD33uSHMs7vw==
X-Google-Smtp-Source: ABdhPJzhm+QE8U85AsxEeVhvQNbhsJshYDLh1Lga3VCE8uipsNYHurjm0rBkPT4X452Vv/doON81dg==
X-Received: by 2002:a17:902:e547:b0:156:c4e4:c0c7 with SMTP id n7-20020a170902e54700b00156c4e4c0c7mr4069801plf.61.1649172928946;
        Tue, 05 Apr 2022 08:35:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004f0f9696578sm17368029pfl.141.2022.04.05.08.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:35:28 -0700 (PDT)
Message-ID: <624c61c0.1c69fb81.ebaff.cfaf@mx.google.com>
Date:   Tue, 05 Apr 2022 08:35:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc1
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 7 builds: 0 failed, 7 passed (v5.18-rc1)
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

kselftest/next build: 7 builds: 0 failed, 7 passed (v5.18-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.18-rc1/

Tree: kselftest
Branch: next
Git Describe: v5.18-rc1
Git Commit: 3123109284176b1532874591f7c81f3837bbdc17
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

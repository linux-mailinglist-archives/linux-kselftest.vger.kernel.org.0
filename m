Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE6E595205
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 07:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiHPF2q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 01:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiHPF2c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 01:28:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8DD1152
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 15:01:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y1so7533008plb.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=d2H1mU32uo8RI1bMzy9F0SL798di0lsgWgoWEo87z7o=;
        b=Er2OyPiw6NPS/qGO6EgDpLfUl3Wvc2CHsurGkP94FJV0EocrVPHKwtrvySW7l9yX8K
         cEENgJnADJQgaCOCVIg6WfU+awJDFbidgzVr+gLyjGG+nQSXpkqzsMol6EOH2jbsXIt7
         K4bbkr8jxgdL5ZJKCVRs9FqHxLku2UoaPF7e6I1Ozx1k345n9luP3jjEkI4CHEj+S7kp
         qYAf1g4yGrCgvmmKJ3UpCPz2yFe62aYt9VXt1WPRVEo0ElqkHaUhuupuM4lDzl0KipRO
         OiGuI0mucRSHIPcYavhlmOeusSntTpL88otXedwAPOoAPokdECwH7egETvadaa1PR2W9
         ZF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=d2H1mU32uo8RI1bMzy9F0SL798di0lsgWgoWEo87z7o=;
        b=qermX5m2zsv59VfVfGapQsPEyRoefLLrvoniK6in4GOQpLxbm9bGxurgs3zsthPFa+
         PI08/ZENOl8bL5I+hLa2CNv2lrPieyFOhtYBNBJ2mkUZpkdcpX7jtATsofqD4MdgoZ38
         3dR29xewfT6MbpLjowWrdKKh311kSItrUpQHhP6OsKkbLkJyBtcASC0XYSIFZ8BFrl4t
         USeAAqBDQZASu6HqS/pr6Xk1nLWdgYkeEkq6nBnYuGv1xv3iehXX5wxIu3IDJ253rUTc
         24RlDfQToaY+joZaC3Fm94dY9ty+ceaO7K4F7XFLvKIP9Q3DtCyH5J2YjRFttprM3Hif
         z0Iw==
X-Gm-Message-State: ACgBeo1r8OxHRE2XfWwx9ye55riMDjazxz0K20Q7LaFHzaLX08U5f1NV
        0gFaTTcCbmBMB+Yt8SMzHLfK/u3lzcB6kIq6
X-Google-Smtp-Source: AA6agR4zSsRW7h5sHX+n0oEXtm8/CKoTskfsfDcgC7GwG60gpATgp0K1gsT3NEnfugGcs+5kswsnIQ==
X-Received: by 2002:a17:902:8c92:b0:170:aff6:e3a6 with SMTP id t18-20020a1709028c9200b00170aff6e3a6mr19100175plo.164.1660600884633;
        Mon, 15 Aug 2022 15:01:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b67-20020a62cf46000000b0052e0bc3ca3asm7194245pfg.173.2022.08.15.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 15:01:23 -0700 (PDT)
Message-ID: <62fac233.620a0220.127f0.bbf2@mx.google.com>
Date:   Mon, 15 Aug 2022 15:01:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.0-rc1-1-gf1227dc7d0411
Subject: kselftest/next build: 6 builds: 0 failed,
 6 passed (v6.0-rc1-1-gf1227dc7d0411)
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

kselftest/next build: 6 builds: 0 failed, 6 passed (v6.0-rc1-1-gf1227dc7d04=
11)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.0-rc1-1-gf1227dc7d0411/

Tree: kselftest
Branch: next
Git Describe: v6.0-rc1-1-gf1227dc7d0411
Git Commit: f1227dc7d0411ee9a9faaa1e80cfd9d6e5d6d63e
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

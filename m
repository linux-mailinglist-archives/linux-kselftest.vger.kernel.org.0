Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CBE60DAB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 07:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiJZFnS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 01:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJZFnS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 01:43:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8496E81688
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 22:43:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso1396676pjg.5
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 22:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aPI9YTCvvJ0KXlCRyJqWY0qak1N5fYqd/MQBDMsMeww=;
        b=KZvMZ2jiG7aHhqb4WMZOiJZuOI9q9iu+LX9dlNizTsqfIDYuBZSrEFG/m37/OtdFql
         MRW7SEXHujxOf0lOTHcoV8+LnX38HY2azAQIbYN7w5NhC7x66+FY+50dvZfzHdTVHyvT
         wf4eIwzKs88wBkZTX0cmU12Ias3tv4gahsz5K930IlNiByiJSgb0rH7FYsDgmzBGZpau
         r53MjDlug0xFL+jX9TLdYVmd91NA3Lrz3qmxgvM1V5PV6bDIuGjhY3niovnOry2aQvfo
         F3FKt9lJbxSTO2S19ipiULkgqrsOHeikkD0PnFEyffUNUluwZd6N6iza2HCrCQM+PHfc
         SAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPI9YTCvvJ0KXlCRyJqWY0qak1N5fYqd/MQBDMsMeww=;
        b=MtQDQrevttWvyzdPDlgESjmm5l43VQFD8b41TWwgnDvBpAR/DQYlgdQ7wBR48ukuHa
         ukBSPIVoO+Y9owjGWifG4zls1qS5TwZtFvMaeiMriEy96TQz+h7WrrvnsD7T51vk3KZN
         bv/8BHb8P+r81cFT0v31y98EcoxEQeW0oBNuA/snUlTsrwHfie/UhyqDlq2rO6m8OWW8
         KSoynmXkYZADyaIkXh2eRYlcJJHfmt5HgrddFjvfDOSaFvP7+06YCRTXTAziibFUSPCG
         vDuo2ciT/s4WELV1qqzPbB060HR3IZ5IFtkik3MCkC3i4ZTXvJp0vHYQsZACjkY5YuAy
         7bAQ==
X-Gm-Message-State: ACrzQf0CMBmIjvmGDID5dWAWrUWLHRf4p5Ml6v5OfdPT/eEspd9xw/fe
        97Ln9t1wPghn4sgZMLEhLuAvFw==
X-Google-Smtp-Source: AMsMyM6NbibM1865POHz15bh8a87VS/9g37qk4u8GskOiH9qkPywcNqHdW9jh9OOkI1SAUsO6BPaKA==
X-Received: by 2002:a17:902:7c12:b0:186:8111:ade2 with SMTP id x18-20020a1709027c1200b001868111ade2mr24616205pll.111.1666762997041;
        Tue, 25 Oct 2022 22:43:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b00183ba0fd54dsm2088521plh.262.2022.10.25.22.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 22:43:16 -0700 (PDT)
Message-ID: <6358c8f4.170a0220.bcb47.49a2@mx.google.com>
Date:   Tue, 25 Oct 2022 22:43:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc1-5-gec7b4511185b
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 0 failed, 7 passed,
 2 errors (v6.1-rc1-5-gec7b4511185b)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 7 builds: 0 failed, 7 passed, 2 errors (v6.1-rc1-5-ge=
c7b4511185b)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-5-gec7b4511185b/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-5-gec7b4511185b
Git Commit: ec7b4511185bba95fc702c33a388582c8842d454
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Errors Detected:

arm64:
    defconfig+kselftest (clang-15): 1 error

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 1 error

Errors summary:

    2    error: write on a pipe with no reader


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

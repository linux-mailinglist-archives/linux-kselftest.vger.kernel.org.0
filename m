Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903DD5944BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 00:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347762AbiHOW3R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 18:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351281AbiHOW2C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 18:28:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361F81022A9
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 12:47:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso7653961pjl.4
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 12:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=Jfv78QksMU+kdWJL574UmZWQEMtaYfQud04fPpQ6d8o=;
        b=bsbm4HKgqiQrQUn0APkcCCkjRryCUNlQSX7HtmHra1HHieboEHB91Zgugn6gZn0nMZ
         83Uo01R/QaBkofdkPRI64GqvzoJDwNTQC3l6NcK9T/GRCj4QDyCIVE2KkPewkWPfhPvU
         qMcmg3P1eHUkmilVmwtG2ldlVVHFc08a2jqxz1CuSnaK1BWZguPzWj203GDwXlTq3eHq
         8PGsx1WkBPJUZsqZs5UmwqS/Oy64LArPjjp/VMngRejGbaTMQfSBJcb/Q0O9xEp+dZn8
         xGGqQFy9msKQSm1W8yDJkEpcx7VQY1sg5XJOH/5rS6ivY6pqDqPziW5M/3+ZkU+2vxRg
         0yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Jfv78QksMU+kdWJL574UmZWQEMtaYfQud04fPpQ6d8o=;
        b=r2VotgytBU2HZ5P7+HMKUjMe4eWCGGSrq/XaRhIAEJnk+lmK4RbJdUAbv5e+FSW7BX
         krn5ltXfvyJewKp/B3tF5TNPiqQzq09efBWIEJP8Vf87VWiPcXUgQDfFXMbYLJ3i62tA
         RXdhWIHP9AMsmWkWs0CZ/TkLQs3PqWybNtUSkoHrMq6lq3Sd44ZfT9xomTqDSO5BJHAn
         9TgIYcnOmIn4MYob7bRAS728vdXuGRG1CXdg3umNpH/OGZ9KQ5RQDtOUzdz+u/9+tXNy
         EshH0Nl33+sD1CnuB+H+TvuyPizQn19b10xVl2aZ+Jvh5+qMA7DpsljkM9VVp1pJZOMO
         DbEg==
X-Gm-Message-State: ACgBeo2Oe4BTTL9C6d77OMc1q9yzEV6REHxUEG+IbmD4qcemHzsjt2jT
        Qvjaia2UiGr/c7EU6rd97RH4rUaP/ECbzr15
X-Google-Smtp-Source: AA6agR7gvUzTchrGXoCsEG8NU2Om7T4RA6OqIGEuG5mFjwSZIUB0lyW5Y4bd+49JSizJ8BnPni0hCg==
X-Received: by 2002:a17:902:7d97:b0:171:2c03:6cca with SMTP id a23-20020a1709027d9700b001712c036ccamr17863339plm.48.1660592876445;
        Mon, 15 Aug 2022 12:47:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y27-20020aa78f3b000000b0052e594064a8sm6890874pfr.220.2022.08.15.12.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 12:47:56 -0700 (PDT)
Message-ID: <62faa2ec.a70a0220.f623c.b6a2@mx.google.com>
Date:   Mon, 15 Aug 2022 12:47:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.0-rc1
Subject: kselftest/fixes build: 6 builds: 0 failed, 6 passed (v6.0-rc1)
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

kselftest/fixes build: 6 builds: 0 failed, 6 passed (v6.0-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.0-rc1/

Tree: kselftest
Branch: fixes
Git Describe: v6.0-rc1
Git Commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

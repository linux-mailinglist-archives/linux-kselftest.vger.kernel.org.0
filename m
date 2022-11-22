Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D5B63435B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 19:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiKVSLm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 13:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiKVSLl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 13:11:41 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B931F7D532
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 10:11:40 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id h193so14702543pgc.10
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 10:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bfER7qXupJTCmVMcW7qNVuzzUdT5cTI7O3MQ2RvEY/M=;
        b=AUBCwOc2xD7ePICWJf+iIuQoYSLXbAgIzH6yiWNopYhubfkLCy6Z2M7zcwWC9G8DhT
         oMHI11iWsSLSdwtyJ7lRlPOpdfcJ1Jk3qCuFPqpwq92HvD/k6sqqP2WtcPfVGfHvJQZ8
         WL+hU8zYLQi7phfIh/MA/8Nv40UAiZvJ9gPlgbeQAyxUNVeY4xhIG9mnECV/mWnNCrzt
         8f0XXsyN9BSETrsyhO5mKigDma81vH4/c+bQY26iYJMqVIMAWrIl4WCU/e3QNxMirSgO
         v+FCD2ITtKSVWj85LHI0slAUfx+nTievfY5Wj4jQPUeyMpg7H9LX9MCFmQZhaAnartgH
         V4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfER7qXupJTCmVMcW7qNVuzzUdT5cTI7O3MQ2RvEY/M=;
        b=S79YfPfvRkH+Kulhr5cjQ7rIAwhQ7mfJl0MgrOFlSbhT5aX+BUbHzIGROGAAKzq2wB
         ny8gJ3iYODQu04NPndFBXzIOTtVpM9EE/qKKKEQ5FRJlHoaudDLhcAe0bQV876oDxdnv
         4+mcLv61onPCRCFjS1qKXrP/2n+wGmpYalBNUSZXpAkW9dnfWPgjMEq3UdD12ld5TUXf
         7YzG8vmB9/CPXkPol7ZV6JsOSPFM7767ATDxyeJWWwFZ7oIWhxJgW0WBFooobXNhIUvZ
         Cse3vQobP2ZPDhTy/yCQlYEJjk4Cmef3Sbib/4P04DIKT+I78DFM3ebHBEJns2XauPEQ
         BfgA==
X-Gm-Message-State: ANoB5pnj1mEQyFSvZl8/OIrJqpJ2+F3urg3f3YWB9JzsMwc5qkDC/K3J
        nW3cJBZD926Nxwd4JamJtUfPoA==
X-Google-Smtp-Source: AA0mqf54W/AK64DGhgc6grXw+CUGus2v0PO2vc8zBRxfRfOa27A5YLAPaOUJUzdqa/SKX6E6bXe9wg==
X-Received: by 2002:a62:8686:0:b0:56c:636a:ac94 with SMTP id x128-20020a628686000000b0056c636aac94mr5247126pfd.38.1669140700212;
        Tue, 22 Nov 2022 10:11:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x2-20020a626302000000b0056d3b8f530csm11089380pfb.34.2022.11.22.10.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 10:11:39 -0800 (PST)
Message-ID: <637d10db.620a0220.af1ff.1ad3@mx.google.com>
Date:   Tue, 22 Nov 2022 10:11:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-18-gc93924267fe6f
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed,
 3 errors (v6.1-rc1-18-gc93924267fe6f)
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

kselftest/next build: 8 builds: 0 failed, 8 passed, 3 errors (v6.1-rc1-18-g=
c93924267fe6f)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-18-gc93924267fe6f/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-18-gc93924267fe6f
Git Commit: c93924267fe6f2b44af1849f714ae9cd8117a9cd
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

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C1476271B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 01:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGYXAt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 19:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGYXAs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 19:00:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FBF187
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 16:00:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b9c368f4b5so2525375ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 16:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690326031; x=1690930831;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uVbE9PpqtTjRZguNUGn7GQ+HDzP+gciTDtYmzLA3RsM=;
        b=e4MK7YoeYSH4Hjj+wtNaqHyVEsYCiTGx0Vt1I8T/QHmoskzZVd1k7Rb65vXqrI4cTT
         xW8TaC+RWj3pDiuUgE9+1cSz7VFna2ZgLcw2weOfflLtQLDhlhOnkuzsB/ADUADGnLqK
         vaRpKmcD+fxNUvcTTR7GjGf87NHw8TqFjuYknN/QM55c0eNzhb3R8QG9GEvooqQCq8kk
         6Nl64wvQPC8TLsjz9eCUB3bSsLuAewo80eTxolNasxjO6gs3Hx0NEmj+nX1wYr0Rb4XN
         odqra0ylOmUbYwiIVO8XjzH0PKRYYeRmCfPPq27oanvFgGcOCxycLr7+eL7GystqsLPE
         nJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690326031; x=1690930831;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVbE9PpqtTjRZguNUGn7GQ+HDzP+gciTDtYmzLA3RsM=;
        b=Q9ppJ8kBLhC2uQ+7QDa17YGAVH2cK/kNrhN8mX62+VlcrAKdZt2i72DTWiTx7tP2zv
         zkC6l3twOAGNpJruYKlDiNC2Zka3YU85stUTkuS0A6MEbpHs3fH/cETFbzCBeKcaiFoo
         W2ntNSyo8hZTGYVuMM71ZhzU56U3sBcMmiJF1hKQmgSgxTakHoFdLVdpUmF5RSfF50bA
         WK4v6sRt/Z4FgOpl5T4FNk+ZRAWWquZOEu2EdTA6CgNJL9uqSV4/KQHkTa1MN7bMMjzL
         C0PYI/FJnPARXI/SubRLB9FX1kbccDs4lGHOK4LYjZzXNBwVmtJzG5odQacOxHs1s9by
         RIOw==
X-Gm-Message-State: ABy/qLZc63Tn+lA4kCj6fu+cKsrqLkTIoKYLo+KPo6Ulb8dUjHmD0ZuP
        Eycv031JSEjlOriOl8Rz62wqVQ==
X-Google-Smtp-Source: APBJJlHpxPL+SFanKMnnkAbfueA5pGy1UDUhVlT6eaDfkWzY0OCrdFy4ARsm7PFn1Lx+vBbj2pgKvw==
X-Received: by 2002:a17:902:eccb:b0:1b8:c6f8:d9b with SMTP id a11-20020a170902eccb00b001b8c6f80d9bmr528597plh.34.1690326031117;
        Tue, 25 Jul 2023 16:00:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902a50a00b001b857352285sm11552240plq.247.2023.07.25.16.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:00:30 -0700 (PDT)
Message-ID: <64c0540e.170a0220.0452.5cfd@mx.google.com>
Date:   Tue, 25 Jul 2023 16:00:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.5-rc3-22-g7e4bf0c1d0f7
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.5-rc3-22-g7e4bf0c1d0f7)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v6.5-rc3-22-=
g7e4bf0c1d0f7)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.5-rc3-22-g7e4bf0c1d0f7/

Tree: kselftest
Branch: next
Git Describe: v6.5-rc3-22-g7e4bf0c1d0f7
Git Commit: 7e4bf0c1d0f707d446ec1bb673d946ee55c9a4f4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x13df86

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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x13df86

---
For more info write to <info@kernelci.org>

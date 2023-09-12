Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF3379D855
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 20:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbjILSGt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 14:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjILSGs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 14:06:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2526115
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Sep 2023 11:06:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c336f3f449so51877115ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Sep 2023 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694542004; x=1695146804; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PkskDirt0Bw3mvZX1iVLui6JOAhawCfdb3fkGf+7ZSI=;
        b=ASYF69Nw+4LRcOik/muBFgN2MC+xXZYumpsJWR2VPBLKGHfR95MYWUOHXMhkTyM0Vj
         KcTjf6TNMkmEklutuzbGNNQbTzAniH+YofuAK/ZbDo9flGVqdwawk/4A2aPQHVo5wlmx
         8ufvM9xLa3MuOVJl4aPSEpAGUQbd7UxeK+7o9ofEaiMeeN0XpoDV2L3PKmaPGQcknJJX
         HUSrjGqSE2rDd44sztG7Sg4S0bKakI0qgyrggAeGlHUUoFux7X5E/+DokzTx68LX7GZO
         j75W86y5DbGmRum4l1xpNbvPIxX0NrfVEZxsrzzNzXUpArjw11UkSYKQfLHaXwILAkCC
         r4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694542004; x=1695146804;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkskDirt0Bw3mvZX1iVLui6JOAhawCfdb3fkGf+7ZSI=;
        b=D1oR9OTx2t0SPNhNFqscOpYGk9eVL9+wiulktLhebDZVBQVq9qfnKfXyd/Gq2B6FUv
         jsf0aaPFGbLa0FmHyCYFSU0zv2yBLYGnDqWGBENliBJEZ9/OwZxMUBf0zRxmEDCjeFwI
         K1unCJA2HFGvTBUHD7l/lYNVIL4CR/mDcFIahDd9dq/S3jfyGU7vYn63sNPsS8FRN4fi
         BoTK/NF8260zkmvJ8LBTdJfNqsVB4u+xXSw+phWkVCxad/euZW09r861yiwEocBvLFes
         DzQ0RbwOpI8UdhrOUk487R6mgi0h/Z8gf8k6U6bY4rvQPS2qrIZoZNJuj2HVisUTOiYu
         7EWQ==
X-Gm-Message-State: AOJu0Ywi+4B7b9LNhToza3G9DJximq0IvrNcoUpS+AwJSV9cmAELB6K3
        Zu18HFo8OIBU8XH8LP67mVRuEz4DrDh9oIGWYtU=
X-Google-Smtp-Source: AGHT+IE3jGvgzvBlZnmDjCXEL8SYp5sNOJClgPc/y7k1Adbny9KwZTEk5tQJf6VJPzNhkTHRbevong==
X-Received: by 2002:a17:902:7590:b0:1b8:66f6:87a3 with SMTP id j16-20020a170902759000b001b866f687a3mr527477pll.52.1694542004268;
        Tue, 12 Sep 2023 11:06:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902748800b001bbd8cf6b57sm8716140pll.230.2023.09.12.11.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 11:06:43 -0700 (PDT)
Message-ID: <6500a8b3.170a0220.39ca3.7ead@mx.google.com>
Date:   Tue, 12 Sep 2023 11:06:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.6-rc1-4-g7e021da80f48
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 3 builds: 0 failed, 3 passed,
 1 warning (v6.6-rc1-4-g7e021da80f48)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes build: 3 builds: 0 failed, 3 passed, 1 warning (v6.6-rc1-4-=
g7e021da80f48)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.6-rc1-4-g7e021da80f48/

Tree: kselftest
Branch: fixes
Git Describe: v6.6-rc1-4-g7e021da80f48
Git Commit: 7e021da80f48582171029714f8a487347f29dddb
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Warnings Detected:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x1393eb

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x1393eb

---
For more info write to <info@kernelci.org>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334D06E29F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 20:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjDNSTo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 14:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNSTn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 14:19:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB39EDC
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 11:19:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b2-20020a17090a6e0200b002470b249e59so8473921pjk.4
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681496382; x=1684088382;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IltbqCyc+brF5TCXqm5VL32y+u1vZ4imqhUhb3g0734=;
        b=l8nvbx6E9tD7x2sRiQp9N3wviOhpuxVdTs7vYGJ0yny+H+shmatmB6s5IOai0KoChE
         GW+OHnP5ZmVDxT72PKwNnO1JFtN+WBRC6ZKkqJDGWxzsq/8jBRx+QLLQBNvfe20K3Hov
         1r9m3VCGCx8BUEIajr7xWMBOXykmFHYmlwxBXs0/J3rWksslWKtEfO2imJVgM6mJLcM9
         DCf/PL0NciHw98Lcujt3N+z72GBV6n+oPWhgst9YwKqDP7pvLDuvMAf1lPlTGkaU8CUk
         AEa1gRJnwnJS1ZZagXpvPdGtCEUMuZYqtJOLs0Iti+xTQ3YZHjFHYEBo6jAYLDaDK0le
         97dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681496382; x=1684088382;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IltbqCyc+brF5TCXqm5VL32y+u1vZ4imqhUhb3g0734=;
        b=YE2DUezFPuEGxjoi6HLfCC8kzDxTcWEa1+GxdmY/7NC/cJPylf5xkE9UwTB8Y/22G3
         spHXlsNMUnRcYimQ7OJsBr7k3XVrmz0/Cszeo7QW6nfwXhZgRmcFD58zdErqMyaBxutz
         I65uL7jNh+NWuxIs10GWD/HnsIsdpLIJUJP1U/dC895qnNMIqXm1noSYiEWKs0zejR/U
         05DT/1bhYHvT4dpVVazxaXmvcuuj2uC1KwpVUbjrOd83VnFR1XY9H85zzK7XbPE+m630
         Z1IGwzaJFqtvPk3ojzTsJqKqV4QjYIXtUiZte5/M7+xVPVAFI76DhO7WeFwrUhhZdQ+8
         osKQ==
X-Gm-Message-State: AAQBX9fPeozTeN4niBri+Iw3Ks2yfCQE6GYGwO3r8MkdN0VXHdKWjebN
        phC8G1Yx+bUJa0S/q9OiocHyqMjwoNzrU8VKgPSN5iU8
X-Google-Smtp-Source: AKy350YwOggn4CmMI3YazDmJtgpDUDPDj2pnuFP9J/82luHTtu4qKVSRoKiliJE07MCM+YKoHBsLNw==
X-Received: by 2002:a17:902:ec8d:b0:1a2:8866:e8a4 with SMTP id x13-20020a170902ec8d00b001a28866e8a4mr4498451plg.1.1681496382244;
        Fri, 14 Apr 2023 11:19:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c24600b001a51402dea1sm1527697plg.20.2023.04.14.11.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:19:41 -0700 (PDT)
Message-ID: <6439993d.170a0220.4c4e3.4111@mx.google.com>
Date:   Fri, 14 Apr 2023 11:19:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-25-g50ad2fb7ec2b
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 3 warnings (v6.3-rc1-25-g50ad2fb7ec2b)
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

kselftest/next build: 6 builds: 0 failed, 6 passed, 3 warnings (v6.3-rc1-25=
-g50ad2fb7ec2b)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.3-rc1-25-g50ad2fb7ec2b/

Tree: kselftest
Branch: next
Git Describe: v6.3-rc1-25-g50ad2fb7ec2b
Git Commit: 50ad2fb7ec2b18186b8a4fa1c0e00f78b3de5119
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:
    defconfig+kselftest (clang-16): 3 warnings

arm:

i386:

x86_64:


Warnings summary:

    1    drivers/gpu/host1x/dev.c:520:6: warning: variable 'syncpt_irq' is =
uninitialized when used here [-Wuninitialized]
    1    drivers/gpu/host1x/dev.c:490:16: note: initialize the variable 'sy=
ncpt_irq' to silence this warning
    1    1 warning generated.

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
defconfig+kselftest (arm64, clang-16) =E2=80=94 PASS, 0 errors, 3 warnings,=
 0 section mismatches

Warnings:
    drivers/gpu/host1x/dev.c:520:6: warning: variable 'syncpt_irq' is unini=
tialized when used here [-Wuninitialized]
    drivers/gpu/host1x/dev.c:490:16: note: initialize the variable 'syncpt_=
irq' to silence this warning
    1 warning generated.

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

---
For more info write to <info@kernelci.org>

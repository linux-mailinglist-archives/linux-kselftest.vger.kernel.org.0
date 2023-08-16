Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D4A77ED89
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 01:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbjHPXAt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 19:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347073AbjHPXAi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 19:00:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4541213E
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 16:00:37 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso45100775ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 16:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692226837; x=1692831637;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YnmoZ3ga1ET1Wc71XUduLe9pUU/wDl4S/VyFFqz22c8=;
        b=duwOga/QOj4QNlMFZ05sp5UUfIwL/s+ymlt+gCf9NDin4ZUiUEYXXWfQd+InGma8bl
         FvfNvOGENvolrM7Ku+oBOg66w2sB/EYMakoTYPnqyIALsxRxiVPue1uoZBMcRUyMYa2b
         8ZJTGka5Vs3sVkO2RLOAP7wHUhWLO0w9YoUuQNCfDaVnG5bpZwh7V9fyuJx5bmz1LY/h
         wPmkysCMH9ZP5XeVYmyUWGGarvVu4RAG8YLEUGDw6jfwyzwlVPVkjt25NZOcF1pl1McM
         ZYvnKnsHS0Zd1Paotlci7uD6BT33tBad6mhFnWXIxa/1Mtc10tc9i9lt9nGu78nyxK9Y
         cQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692226837; x=1692831637;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnmoZ3ga1ET1Wc71XUduLe9pUU/wDl4S/VyFFqz22c8=;
        b=aY5muwc318iZO1GILfitwxY9Hz/GvP7fWAWpxHVevUa8SOQheE8PM8J6cwTb3Ix7LZ
         XKBu3XP2n3/i17QuhG6J3iVeENp20MDRgz/6rw/F+7qh524T8kHX5Z2BDsxtuyEtSbUv
         82UbR71puG3nfQa50FRpX17WeuY/WqUfLHO+FT7Y2QXoUk8UOsde8an5qNU9iq71RPmv
         fBWH9NDE+jnQ5oExmiMe+VGiG/7H9nXlrTTDaiJNclfB2e9j992qSCC1y8ibhxpvpFAB
         w/aH9ysu2jBo5D1P5LGw0028gZcdqnIamV7Zonp2rNdCU639WKxSXPcER7Xl3z4TP4xS
         4igw==
X-Gm-Message-State: AOJu0Yx5zvgZDWrQBDNmJv9ZpxxZPJuHJQtMQOW+sByQsB7AsYBQ8l7v
        4xrVjC8GeePrTA6r2YKRaQe7N0nzZu6u7lN/mTyTuw==
X-Google-Smtp-Source: AGHT+IHhe4kmKBgFUgOPvjGymnUdXSpKgb5bEeENJ/f+1WJNFEc9HZeY6sXLcRnTAVx6q+Hrdut15Q==
X-Received: by 2002:a17:90b:3793:b0:263:129e:80ac with SMTP id mz19-20020a17090b379300b00263129e80acmr2817959pjb.38.1692226836748;
        Wed, 16 Aug 2023 16:00:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b0025645ce761dsm239018pjb.35.2023.08.16.16.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:00:36 -0700 (PDT)
Message-ID: <64dd5514.170a0220.834e4.0c3b@mx.google.com>
Date:   Wed, 16 Aug 2023 16:00:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.5-rc3-32-g9b1db732866b
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next build: 7 builds: 0 failed, 7 passed,
 1 warning (v6.5-rc3-32-g9b1db732866b)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 7 builds: 0 failed, 7 passed, 1 warning (v6.5-rc3-32-=
g9b1db732866b)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.5-rc3-32-g9b1db732866b/

Tree: kselftest
Branch: next
Git Describe: v6.5-rc3-32-g9b1db732866b
Git Commit: 9b1db732866bee060b9bca9493e5ebf5e8874c48
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
defconfig+kselftest (arm64, clang-16) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-16) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

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

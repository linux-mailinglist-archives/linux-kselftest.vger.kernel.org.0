Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5C7D125D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377781AbjJTPNl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 11:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377735AbjJTPN0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 11:13:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52E410F2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 08:13:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5a1d89ff4b9so611738a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697814796; x=1698419596; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek3qY9JriUX2rXMLjtFZ5F489ykd4cE4z6cWqM3LL2M=;
        b=dI6OX/09YQ1ojgM3bZC/4zbuZNNQm5HnDrBGMg71s+kpz7iXTx6PspDZJ+eFccXwLw
         gZtXoIjgdf/6FreCSoTOQdiQcgKHrzKnjSUWkYLM5vg6dNrKPUmpB+eGn7OWWHfaQsrs
         5IbGs6NxoKDEP205t/mvnibzbd+R97W7lAo0jiM1X4xKiYrbQZZtPM98TfCn2yAHiwqd
         7le2GW8ZNC0EWpB0F+GZ2+tH8+L27STZDt8MGgSXxE8RLHMB5W93eqkG+t8QDu0YrXWR
         48yrVXmtgMZQOE2w6WhF3OkHX2ktCdy4q8DFhqi8+uP8R+zLA7rtQGrYAAoQm9pl8uke
         FHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697814796; x=1698419596;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ek3qY9JriUX2rXMLjtFZ5F489ykd4cE4z6cWqM3LL2M=;
        b=qCjga2x5WzNDewJhFk1AEKCpAxyKH+PosNYowE9BqQvVKutXK4x97GDByba58TCkX0
         mPXNXFIuPqxP8IDJ/SMvrEZH9UfVg02nu1mme/+pINIMCXMBSaX1Z5ILRFJJFaiieAcO
         KVQK0LACezkBQoW79k8D7m5xcFgi+uJzWMuaC03d53d8HVcNmK820ucXCZZMTz0+aTv5
         BxnKbz7RpnHCymvU2HzBK/I+qVIvr/092Gge3NhFE9NptwzJJ32jtaLTNC13BgOPu0bI
         doEmmQBqnQ1tjfDlPUMn7UV4Wq6M7IN5T69LwyN+3W2WYTokGGzvi6OKhtIzUtRL+L4e
         zv/w==
X-Gm-Message-State: AOJu0YxBvId/0lNd6xK8qxO025LXD7REKmGxaibSm9rY3Mvosn96BNP8
        e2fsJqE4yYUTb724p6G9jlXDAg==
X-Google-Smtp-Source: AGHT+IGH7U89YYOsUe15zH4rRMip5A/q+bfBuyt/DZUAuPRrNuO+OogOZ9WPMS42cExKsIiyTAWaIg==
X-Received: by 2002:a17:90a:4d:b0:27d:76e2:ab18 with SMTP id 13-20020a17090a004d00b0027d76e2ab18mr2394556pjb.9.1697814795955;
        Fri, 20 Oct 2023 08:13:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ft3-20020a17090b0f8300b00263dfe9b972sm3408454pjb.0.2023.10.20.08.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:13:15 -0700 (PDT)
Message-ID: <6532990b.170a0220.87626.b3c7@mx.google.com>
Date:   Fri, 20 Oct 2023 08:13:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-51-g5247e6dbed00
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.6-rc2-51-g5247e6dbed00)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v6.6-rc2-51-=
g5247e6dbed00)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.6-rc2-51-g5247e6dbed00/

Tree: kselftest
Branch: next
Git Describe: v6.6-rc2-51-g5247e6dbed00
Git Commit: 5247e6dbed0041147a83137f89cd45043301de5c
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

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x13950b

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
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x13950b

---
For more info write to <info@kernelci.org>

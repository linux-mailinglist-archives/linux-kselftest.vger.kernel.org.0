Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DC5507EAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 04:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358739AbiDTCMN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 22:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243081AbiDTCMN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 22:12:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3279F22BFC
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 19:09:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso572102pjj.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 19:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=A/0aUaFz3j60cyB2ocp+vXnczoWvi9GyAvYc3Gc+uTo=;
        b=zq0dLIG0QR+VK/nyKC3wHR1xyfCWyMim2Wrvnw7viwBUdp52bAzH97kTfOQhpASUOP
         heFmLQmMxF9bj/lZa8KlTY3CcnbCG0Qn613vKb50KsnjpfTMLq2TkDWUg8RbPZaw/gfQ
         OH20TTUlCtQF2rLgNmtEZid7k4hKmbxDw5OAiAbPGuw6BWyQEsdiNQ1mAmREZSoTcx3k
         n4CQ1QvE9J9v6d67oEou4LemYkmi7eVO2hkTwQn+nxzNW3cx7uEptpdCXs+vBV/C9gvb
         EiwrRNeWzgPZD+eBjn4Z0Y3iENJXEo4xYq2wBU5baqTQvgFCL1Z0dEmsdyne5rM+Zxxa
         tI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=A/0aUaFz3j60cyB2ocp+vXnczoWvi9GyAvYc3Gc+uTo=;
        b=QqFySHrzYsxz50lDLrc0QLF00dU10vZgyIsswTvQ2xm3430KuAy2NKVSdzwI7VQMHQ
         oBfvBT7RVX/U/1csFZf+V0qUxPKYzRa3UHCxeOtrou7bs7Qf6oixVeUDkteMADPkpamq
         HvOrC6cAr1Ve2C5c9AyXghsLLJJQjdjB92pLUnhLzNxGrgPYnw5HhTY5sxHlc9PCJGVq
         fdzRQMB+6tZSDAgKcbwpphpYHcfpZ5RJmFX65Z3reHNDruS+gMG4DNvwJ2sYzPXrbP/8
         K2bk4fFBvtT9xxT/AbhdBG2OWu7mlwQkrirzlgHfk1h5/1HlLyF9yNFj3HrEK5ddTtXh
         UBkw==
X-Gm-Message-State: AOAM5321IsGIQMwArkOPBJTQnxsGGZv5cxcm9E0ttsuB9GQnCU73WJ7O
        Oxp8uEGVKzFtxbKEbr3SSnwmF7pUk60RdTcf
X-Google-Smtp-Source: ABdhPJx/qqIG6UAbhC4DxWFtjPTv6ySb+QseusR2DvaENZwjclUjllYm5QrLmCx1zYEx4bErP47SDQ==
X-Received: by 2002:a17:90a:3ee4:b0:1cb:c1a6:e5c3 with SMTP id k91-20020a17090a3ee400b001cbc1a6e5c3mr1673773pjc.215.1650420568699;
        Tue, 19 Apr 2022 19:09:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ne24-20020a17090b375800b001cb62235013sm16966001pjb.5.2022.04.19.19.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:09:28 -0700 (PDT)
Message-ID: <625f6b58.1c69fb81.b54f5.9796@mx.google.com>
Date:   Tue, 19 Apr 2022 19:09:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc3
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed (v5.18-rc3)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (v5.18-rc3)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.18-rc3/

Tree: kselftest
Branch: next
Git Describe: v5.18-rc3
Git Commit: b2d229d4ddb17db541098b83524d901257e93845
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
defconfig+kselftest+arm64-chromebook (arm64, clang-14) =E2=80=94 PASS, 0 er=
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
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 0 w=
arnings, 0 section mismatches

---
For more info write to <info@kernelci.org>

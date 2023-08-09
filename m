Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D757750E0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 04:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjHICYM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 22:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjHICYM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 22:24:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD82173A
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 19:24:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55bac17b442so4657928a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Aug 2023 19:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691547849; x=1692152649;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZTtDHy5Qvp267yqDv43DcnxV6yG5lp3fRdfJ2VcdVU=;
        b=mqXD6FxZKb4vxJiKczo1T37otbXFJEFz8ghlFMjK69B5sqQ14VqmlKpRTkp/LufxnJ
         sYZjl9v131m3PG54SVp+I9hKXwH2s0MtP/dRzhDO6ute9IyADoI0AkJX+m3vyEVYh9vX
         S7bMdvr+29gVGDdi4TiuilkMib7tCUSKkSeZEwbwahhG1fpVTB4VmdlveU+2l/8oyy/Z
         ke754bBRpfOEF4PRGhd00b0INA+B2HzTYKFUBncox0m4sdJ9QzK94xEeJkQtULivWjWT
         OLIlldDI0ApQZ1sbbphDcQ1DW55KtsnG/yUYFPbta5YoI9QScOJBTx+67ZDOEBKD6k5Q
         OFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691547849; x=1692152649;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZTtDHy5Qvp267yqDv43DcnxV6yG5lp3fRdfJ2VcdVU=;
        b=XtTcSn/0UBSt86UfiRjUd1kA8mKUATkMoGGSKDcvv2ux+eYy/jnCqHqYjPf23sZa8Q
         nccbZjyns/mjKxjHJiCfkq4hH88PtxcLJYXfRKnbot+k2OHWHR42j2eqWD5eUKgQ6NnY
         enptoa7YsViwUn41LD99tb55xDT+re6sJIvazGKUFob5jtiBhQJGzKzGQG7mws1Ncz/r
         Mb6GQc/SJ/ybjq1mSekf4oFNyquPZ6n+WctZb2EXqVm9nnoXMz7WUVlH2i8kXSBlzWVg
         U54YFlAGKcfbhCp0tFeNEKEkp0hLt1IZKP62gq4gRzJg0nTvwQPQxMXMJXTxAdT4SarH
         dcyA==
X-Gm-Message-State: AOJu0Yw8aFae2IFEGkcdd9fQADfwp9tqiWMIbk8GMJ3LxzTh+1l+MztO
        AXjELgaN1gDf23wuupxxmkeRFw==
X-Google-Smtp-Source: AGHT+IGgEJkFDzjP5YK2mplVsNu3hoiWSM2Ja9D5UXGydHRPnJGFYlZwoPVOTEGhocdSlrKwd1BBiA==
X-Received: by 2002:a17:90a:7f83:b0:269:1e3f:a54d with SMTP id m3-20020a17090a7f8300b002691e3fa54dmr1162767pjl.10.1691547849122;
        Tue, 08 Aug 2023 19:24:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090ad38f00b00268188ea4b9sm234448pju.19.2023.08.08.19.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 19:24:08 -0700 (PDT)
Message-ID: <64d2f8c8.170a0220.65ff4.0834@mx.google.com>
Date:   Tue, 08 Aug 2023 19:24:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.5-rc3-26-g2b2fe6052dd01
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.5-rc3-26-g2b2fe6052dd01)
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

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v6.5-rc3-26-=
g2b2fe6052dd01)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.5-rc3-26-g2b2fe6052dd01/

Tree: kselftest
Branch: next
Git Describe: v6.5-rc3-26-g2b2fe6052dd01
Git Commit: 2b2fe6052dd01fdb4e9a31031c2c9d8f03cf7753
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

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE307AF875
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 05:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjI0DK2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 23:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjI0DI1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 23:08:27 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917C4126
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 19:18:21 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1dd1db54d42so2826464fac.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 19:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695781101; x=1696385901; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IPGwCwd+jVA93ZpKj+iEhwPhKtiUIJB4pw4J1MAfToQ=;
        b=bqkeD9DdHXnV/N7Yev6jzHFrKytmZNTNt2wGf/+BhXqGannD5lY9MIEsyn3JydrZKr
         cfwN+6sAdeiAX6c0X0hdQNADoH0gSBbQ/ptjL0LecWdPje8wZXOJQimp/LhZPvZtTFYs
         0DWGvSSV4dZlALPpcbHduaqpEM0ZL4zMCr5jLjpyIvjtegmny68QnOHNacSTKIdnOh6j
         SfO0D+aLp0W2Bwdtm6Rt7Df2MQq/nI9nUmUrNJ6NUlXBIUxZoCT1aDrmERvFQ/vSNpzh
         55elIP2kqGRd0cqLxg7QNR3cbSmqWI4H6kCv5Gnp0mK+EDFmTCe791mBSxhOV1U1+nWO
         q36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695781101; x=1696385901;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPGwCwd+jVA93ZpKj+iEhwPhKtiUIJB4pw4J1MAfToQ=;
        b=dXI4UBLYTKhocRB7W0kQ6FpV6QhicpClvEsC+N+4QhD//P2HZTyO2ibRNrFTAcDofi
         ePaC+1yeOIqhz2PFHjQ+k2O3ONoVhcRr7zcw+7jQ2qfB0EAqFBJjnZKdu7vH8Klbfyku
         qOfwLM3BeprSeBti3v7qyeByrcy9b0PH/l8Gni/1LorGE2+yn0qWBx25kMrU8HAQOwS+
         MMQ7d8X6utvFs2Y7Q31hndLHnzkoQDEZi+bE+IOzfFwQAaX8kjmwt/XEVqGSGFU7a/la
         sCqi3KVhmJ9vCbz37FANlOCGv+6fpCFdnOKGNEn2VByJXXEFiMFdkjTN/nzPLNGj/CyB
         JQcw==
X-Gm-Message-State: AOJu0YxBIK7JjFJ4DHydUIaSvfWCd9laoxjD9zcvZzmGZ8N32BpHd/BL
        PM9CCnUvAm4oLdn3117GrQRqgA==
X-Google-Smtp-Source: AGHT+IFc9IYBu1zqddIz1v9zc+ox7s0KhsWJsK0q39C+3JTGcAydZYHF9subG7266xmN07b81HJNJA==
X-Received: by 2002:a05:6358:5e0c:b0:140:f00a:ee2c with SMTP id q12-20020a0563585e0c00b00140f00aee2cmr976215rwn.11.1695781100663;
        Tue, 26 Sep 2023 19:18:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m10-20020a63940a000000b00584d035c08asm1770824pge.24.2023.09.26.19.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 19:18:19 -0700 (PDT)
Message-ID: <651390eb.630a0220.fc64f.731b@mx.google.com>
Date:   Tue, 26 Sep 2023 19:18:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 6 builds: 0 failed, 6 passed,
 1 warning (linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df)
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

kselftest/fixes build: 6 builds: 0 failed, 6 passed, 1 warning (linux-kself=
test-fixes-6.6-rc4-1-g6f874fa021df)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-6.6-rc4-1-g6f874fa021df
Git Commit: 6f874fa021dfc7bf37f4f37da3a5aaa41fe9c39c
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

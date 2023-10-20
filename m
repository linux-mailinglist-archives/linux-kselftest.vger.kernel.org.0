Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26757D0E52
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 13:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376999AbjJTLWd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 07:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376988AbjJTLWd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 07:22:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE3318F
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 04:22:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso500023a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 04:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697800950; x=1698405750; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vJiixoob9JDEqEP0LXRuqxRtVET25CIwsXKwFOz5qJ4=;
        b=xCkhSMATyHJsLX4IcowTpLgP/cYC6Cy+s9xUbANPjykKLGupr1mcN1MHg6ob/ojMCb
         zp4MsJH7ur7WxSMl7UYoavoUtXIwkhk6oiA0MBVvc9qmH/VoYH8yyfzGUNKlmF7U1d4b
         vZg4ri+Dn7V5O5SzxGa8eJIQC01/Nh3JkAAlZAU7oRZk4lUUUEDHAlO/cP/alxywSHup
         qAcUKRxNFJlS5bXJ41CnZNSZg+PHOF8Sr7mP5JS+jW4zgo4qDBQpS3oEkXks/97vUQar
         z01Cy9s+OWEaWJTHSufCFSq6xs376t671rUSp1eCIuw8Lh6qC9s0V7JsmB/2fqacj1yl
         B8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697800950; x=1698405750;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJiixoob9JDEqEP0LXRuqxRtVET25CIwsXKwFOz5qJ4=;
        b=NkuIBQQXjhltucGgGKiul5prtExtx1PD9dVg6PoOSNAZ0NcdKrqezNMV3T2Kj588ox
         WVgMfsYFh82F4fKOXUyo0kfOzjJsoE5+T4RstJqvjFzh3y/Bv5LlBASTdcBfoWQilSAX
         iHO+qGp+3F9B9B9xl6QXn1/f1PAEPri5/cLdA9FqiRF2CeqKG5y617jJ0hE5W+wQ4+j9
         vk8An6yKtrrF4bohST9QNHeD5b6cKOnIv8nyo+DY8m1t55MfROjenEVBQdXjwrzTqjLx
         Zj76/InuwaivtSZLjGbmz4JOkm6k01ptbq+AfSU1zRMU4AAfzZp1GmhF/+Uo7EcnsooD
         f9eQ==
X-Gm-Message-State: AOJu0YzUVIgXUaNj89YiIC29yNrHvSvCBDBWXQtyf1McefL1YXbgnnGU
        PtvBwfGay2+j7Wm2xMoaCYgxfXVzR8R+0KhPqQEwkw==
X-Google-Smtp-Source: AGHT+IFay1ZDgUFGwKD//qkYYRyjMuEwiDl0Q/jePUCx8vWC3ttBGEMaR0VuZ+PjV21Yni4JKQAWJQ==
X-Received: by 2002:a05:6a21:35c9:b0:12c:2dc7:74bc with SMTP id ba9-20020a056a2135c900b0012c2dc774bcmr1390714pzc.46.1697800949937;
        Fri, 20 Oct 2023 04:22:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090a7a8f00b00256b67208b1sm2961767pjf.56.2023.10.20.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:22:28 -0700 (PDT)
Message-ID: <653262f4.170a0220.470b1.95e1@mx.google.com>
Date:   Fri, 20 Oct 2023 04:22:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6
X-Kernelci-Report-Type: build
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 6 builds: 0 failed, 6 passed,
 1 warning (linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6)
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
test-fixes-6.6-rc5-1-gcf5a103c98a6)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-6.6-rc5-1-gcf5a103c98a6
Git Commit: cf5a103c98a6fb9ee3164334cb5502df6360749b
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

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC264C2EFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 16:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiBXPJS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 10:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiBXPJM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 10:09:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D830177D02
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 07:08:41 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b22so1949847pls.7
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Vaa5/Mvv/D2wztNnXXU8iYwTkNOevxts4E8NGeCsPuk=;
        b=wneUBZu/S2fri5CSH5r+UCZA4Wh7QcaWYL8beqE+Yy400ZQuPwI3BiTNeaRjVrfZKo
         BjMmMb7LqTr/oFLPTCIdQcYsGtSmCS1IJk3OgYBWkrBNeK+jWOkGH8oc93X9l4oFTT6C
         1hu1kkpGZbo1Y6wI1y87UvYD/JQuhQpGZ873y2nxoon86aRdDayXXoi86mc12+lASiWP
         pMvvBPGITw4/MMq9eUIeHfwh5jXDHBR7qFmGjPsQseILUEzG2EQRgUdMVYtJT/tybHjf
         4FXVvc1LP78FTfxJ4mNIGp6+LM1jBb18cl1fjrj2vgCN+4wMyhtYHj++IQipvKM370Bu
         +LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Vaa5/Mvv/D2wztNnXXU8iYwTkNOevxts4E8NGeCsPuk=;
        b=BQEqJva8ZH4kkTk03cvDOpIk2kUNikDKsG/3MDyvf4W5DIXlXNcDNucRYAJ9O5Rz31
         8UuLuJxsBoVNvYYqnJIZl8VdjoIVbOHbLFLItBII/XawkQRDJXIqKblObZ9XqlNvO52n
         ZTXzdIo9p95pXa6yHXrON10mNMLYGyEARf00DPfbUKHU7/N0pjXvWyd2FSx+EW0leSyc
         GjTonMd61DmHFBCTbGMvtzSXWFlXHsZsY59RIdJCbAXDYCC6TJyozxdlxHpae3HoeoB+
         Esyz7Y3zLVRvI1BMEkkixYJ/vtL1+4XqrZ71cWnFj7AnUFDBP9WwkW3j3nPTC3UIUvqK
         vceQ==
X-Gm-Message-State: AOAM531GpbPVGCrsqB6VbDEyXOkVZp4Wkwc812z/KnEtw1VMIWck9NTY
        yplnKKIMf5Nsj9CCJHKwaGDBbw==
X-Google-Smtp-Source: ABdhPJxyMDfPOenElDjcnhXfc5BV0XmdqbPepKnp4G4fUbZ/OAelEBbJKw/vHksRQMQab1txekZw5A==
X-Received: by 2002:a17:90b:110a:b0:1b9:eb62:7c00 with SMTP id gi10-20020a17090b110a00b001b9eb627c00mr3246651pjb.67.1645715321036;
        Thu, 24 Feb 2022 07:08:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n29sm2930072pgc.10.2022.02.24.07.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:08:40 -0800 (PST)
Message-ID: <62179f78.1c69fb81.ba5aa.73e4@mx.google.com>
Date:   Thu, 24 Feb 2022 07:08:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.17-rc5-16-g1900be289b59
Subject: kselftest/next build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc5-16-g1900be289b59)
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

kselftest/next build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc5-16=
-g1900be289b59)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.17-rc5-16-g1900be289b59/

Tree: kselftest
Branch: next
Git Describe: v5.17-rc5-16-g1900be289b59
Git Commit: 1900be289b598b2c553b3add13e491c0bb8a8550
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Warnings Detected:

arm64:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-14): 1 warning


Warnings summary:

    1    net/core/skbuff.o: warning: objtool: skb_copy()+0x132: unreachable=
 instruction

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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-14) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    net/core/skbuff.o: warning: objtool: skb_copy()+0x132: unreachable inst=
ruction

---
For more info write to <info@kernelci.org>

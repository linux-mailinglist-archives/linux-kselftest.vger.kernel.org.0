Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB23639070
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 20:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKYT6B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 14:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKYT6B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 14:58:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CF121270
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 11:57:59 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id md8so371002pjb.4
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 11:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YJLkauZI0oQOUdRmxPmjcOBp2F34D1qexR4ClsK7aSY=;
        b=psKFfe2zI0ppXCrO/O9WFviHMWDM88TN5BrmqvxJOZphjXFstQf8bThjYSBrhnHus6
         dLTF/LjBPMHLpb6OfEpn6j2WT/w3R4qvNW4/Pelix94pJelCqv4RE6KvhGC59LNYQgeY
         jRyqyLOAeRI3LizLlDR98wMPfDC9kefogj96rExlshabZm+dN6xoiib0HGFE81frra4W
         v7IUsYPAU8BrseTT7SrP58c9Vfc/u2q91cdgx4ZoTCpKi+Rb6PlCMVtNoxpobK0AlgYl
         I3OCoZNIaAPtz6FBe7I6w8Pu8FAfCjtOr9SJSBhdaUOWxxH18r1ECybfCpSA+rq+DxRS
         vbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJLkauZI0oQOUdRmxPmjcOBp2F34D1qexR4ClsK7aSY=;
        b=EEnpmrEzVm6VZZ86qA9dTfsSCy8grxXjs2LaOHTa4yTvhVfuODppKknk9TgyFtHRDW
         0BCb3Dt86/pbtG47JwMZ3OlksakgKG/X/frSHdI6XdWDE9Nw6Lq1nfpVlG7zi2EkPmdf
         pxIA50voTv8z/HjIT8mFBkp9hzIQb2qSDNrheDWVkTcB9VLyLX0wH7I8iyP72JlUD1+q
         fMMPTqXF0fUBFmZfKiHoeqhCqsxf9S5EdB8vP2jwfGTO17F9Uj4cO+lhrVm8aFbTLIjr
         1ZfLMWuadRJ0cWC/pj5zEYC2gKlB84lVSWdDpVMHrm6g92GFB6NezwVQDEApFRWc6HQF
         ilwA==
X-Gm-Message-State: ANoB5pkLclADLjRFHtQB8VzdfrPxV3eZ1YkxVzTgD5xo9Ww2XvogEhoF
        uLPaW2vo74l3yak+l431iLUn4vZt3MxaZGgIAKI=
X-Google-Smtp-Source: AA0mqf5PBdtv+d23qXdbEjbml3yxR/YlyFpoRtm6u+kBVNPQ4XTwmxU4QfJr184+ul39SYn4yirOMg==
X-Received: by 2002:a17:90b:3544:b0:218:8666:f0fc with SMTP id lt4-20020a17090b354400b002188666f0fcmr37770117pjb.184.1669406279408;
        Fri, 25 Nov 2022 11:57:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902e1d400b0016d4f05eb95sm3714386pla.272.2022.11.25.11.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 11:57:58 -0800 (PST)
Message-ID: <63811e46.170a0220.c71d0.4e4c@mx.google.com>
Date:   Fri, 25 Nov 2022 11:57:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-23-g00dd59519141
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed,
 3 errors (v6.1-rc1-23-g00dd59519141)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next build: 8 builds: 0 failed, 8 passed, 3 errors (v6.1-rc1-23-g=
00dd59519141)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-23-g00dd59519141/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-23-g00dd59519141
Git Commit: 00dd59519141398120b4baa65c0ab4b67dfd3e19
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Errors Detected:

arm64:
    defconfig+kselftest (clang-15): 1 error
    defconfig+kselftest+arm64-chromebook (clang-15): 1 error

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 1 error

Errors summary:

    3    error: write on a pipe with no reader


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, clang-15) =E2=80=94 PASS, 1 error, 0 warnings, =
0 section mismatches

Errors:
    error: write on a pipe with no reader

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 1 er=
ror, 0 warnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 1 error, 0 wa=
rnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

---
For more info write to <info@kernelci.org>

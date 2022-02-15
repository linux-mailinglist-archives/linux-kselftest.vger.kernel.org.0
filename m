Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231424B601F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 02:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiBOBsm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 20:48:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiBOBsl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 20:48:41 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D78B9A989
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 17:48:33 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y9so16158247pjf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 17:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=80P/a7SlGAUawr0ZwM8xPKHy9K3wQvSuyabH7Q7lbKM=;
        b=nXYwPfXxUrJQhSrLcDHna88XX2DdR/8rn6hk3TlE5+iaFlZ7odVFx/4y1SVc3cUp5X
         dVPKf0hiqpPwiFtFMLhF5/MfNxy2yKVoU+1165fUFLKLEImB8R6eCHexT0MX8qTCvhcu
         xWz2f7zRhl8TkJChF95rZss4PviWe2aluBofEmzdh2UHXXw0sBpCNqwYxHal08LpCh5E
         HCpy46GepHeyzL9KiR0XPM+YYAUXOSpUXm0sWgqMB4YlhkOs+RN/WFXgZebEx8SZQJeW
         osTeouqgOmkQy1diSbiSnX+1ZuWXLaMF1AVGb/qDI3stH0/zss6Pws6MvUW2No8oNWYV
         wc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=80P/a7SlGAUawr0ZwM8xPKHy9K3wQvSuyabH7Q7lbKM=;
        b=zGlQD/+fHV6E0iQoIRGoYWRza/DxAcu2qJkDjmbfqQ5XhPI6TSUAkY+AIEN5dxXkAa
         j2yZiUbSginrs3+SJlE51kT34vNInBJwG0e1PIQeg7jrPqwEWfefulQJd1mCT2pBu4k6
         P5ySt5wZe7dlENFhkRL7MlnpGh7hCQVVNJmbJvcM2zctl+tzX0y91g+bUxPUX3eV0naH
         qfuObrlK1J4++vRptZTJ6X3JF+VRGRUNO40s8oL17Y2YLit7Kn7I03kz44OdLXsk+SXd
         Dyctt770Ppvx/pGFpxduJwwuhOH4wQ+3I0q+I0uSMe2wpS/aQlEwk6HbSMlczXwtlGMO
         JthA==
X-Gm-Message-State: AOAM5301q1gdv1Y/nDTq/ASqqA3ZpEyjTQ66FRmkPTyHSFIhW65ezjUr
        BTq62Tl1ko7nkXV++NgN/QCynk4f3XeB7qBc
X-Google-Smtp-Source: ABdhPJxbm094UE2PjpXuIQphlqQ5ntDCKRaD/c3D+5Mhf73scA5UAK/39FU2u0BKgcRRUrIOnBZFiA==
X-Received: by 2002:a17:90b:4a82:b0:1b9:a8f6:1819 with SMTP id lp2-20020a17090b4a8200b001b9a8f61819mr1706860pjb.225.1644889712690;
        Mon, 14 Feb 2022 17:48:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z16sm4633796pfw.159.2022.02.14.17.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 17:48:32 -0800 (PST)
Message-ID: <620b0670.1c69fb81.adca.c172@mx.google.com>
Date:   Mon, 14 Feb 2022 17:48:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: linux-kselftest-fixes-5.17-rc4-3-g6fec1ab67f8d
Subject: kselftest/fixes build: 8 builds: 0 failed, 8 passed,
 1 warning (linux-kselftest-fixes-5.17-rc4-3-g6fec1ab67f8d)
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

kselftest/fixes build: 8 builds: 0 failed, 8 passed, 1 warning (linux-kself=
test-fixes-5.17-rc4-3-g6fec1ab67f8d)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux-kselftest-fixes-5.17-rc4-3-g6fec1ab67f8d/

Tree: kselftest
Branch: fixes
Git Describe: linux-kselftest-fixes-5.17-rc4-3-g6fec1ab67f8d
Git Commit: 6fec1ab67f8d60704cc7de64abcfd389ab131542
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

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
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

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

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F984CD967
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 17:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbiCDQsV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 11:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240742AbiCDQsS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 11:48:18 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E93B00
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Mar 2022 08:47:27 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id w37so7989772pga.7
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Mar 2022 08:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=msiw2RpvtseF5v93UX9fBo9UvEwhVQ5eYYt3vzFADkU=;
        b=TUc5/Px9IL72ZeJfga+qq9Fl6HtIWsna9YwRwZ0LxrK5LOibeXMrTdkJSRwYpSlWjQ
         WqnxJyrZQZE2QyUJ8B3smstoWZT3o4VLTM6YhUz91d10+fSlzIl7OumNIQnB2SX8Co4I
         VCkmuxvgYcOX0ukvMefuuKW0s/ffisaP7Mtc41RkkDVFz4fCkn6J/BSw6F54uQF65hwc
         PXxiBwF5vhkMfttbZhB18acDpnXH5LjZvur5+ZPbmSeETyLbyRulsgGU0p013V9z+RMO
         zd4cr/k+ymnP6s99mFkP54csbP5c2rbMws9s82ONtE/ZK5gvGXqV99j0z5vJc9GliO3N
         ZU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=msiw2RpvtseF5v93UX9fBo9UvEwhVQ5eYYt3vzFADkU=;
        b=1HkyQOhHFn1cviJb8MJq3Jl4ZvDrODJeTbriLm/nv/F2xrODAjMjbHPTpYcJMj/x6K
         J0h0RV50Af00WWGQ1iZgsyubKREIeK9V48OJ94dchIvAdybL5J8Z2blThnrZA0jc8U/1
         yqKRhivHKmKVhbXXFzWWenzSaRBcF1Gg5kUI+1UUfqhJrdWq2YoJ3Mth0aBI/g9Z7jCg
         gB01IRvXU0McBoiIBYbbA+m5pqnTyJ6CyLrbl1HKBiIYIfi+whW+KWZvTTyM0K94QC/S
         WGplp6EUYk/nnXVwohByXVQaMM3pyzeyIkUB/gVghghau+bYcMoOSiE1GSyrO2qX7W0z
         IAIw==
X-Gm-Message-State: AOAM532OJFRpRHrpf1mHfhBzVfJsgFYO52736lmM7tSNvfN6M8eU/pTB
        59tLIBF+lV/svTL2sdkbseORXomL6jCj8I8ytvg=
X-Google-Smtp-Source: ABdhPJz+oYlQcaTlqKC96s0c/tfNqMl/B+wfvbttRdp1Rpt/ldsjmPjAPtfIUndlguLWKcwLj+I0EQ==
X-Received: by 2002:a63:6b83:0:b0:37c:5768:b353 with SMTP id g125-20020a636b83000000b0037c5768b353mr7013112pgc.79.1646412446558;
        Fri, 04 Mar 2022 08:47:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a5-20020a621a05000000b004e1cb7632a7sm6738875pfa.64.2022.03.04.08.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 08:47:26 -0800 (PST)
Message-ID: <6222429e.1c69fb81.2be8.2162@mx.google.com>
Date:   Fri, 04 Mar 2022 08:47:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.17-rc5-22-gf6d344cd5fa6
Subject: kselftest/next build: 8 builds: 0 failed,
 8 passed (v5.17-rc5-22-gf6d344cd5fa6)
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

kselftest/next build: 8 builds: 0 failed, 8 passed (v5.17-rc5-22-gf6d344cd5=
fa6)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v5.17-rc5-22-gf6d344cd5fa6/

Tree: kselftest
Branch: next
Git Describe: v5.17-rc5-22-gf6d344cd5fa6
Git Commit: f6d344cd5fa6a15e1ec2da350470b35a3f55f74c
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

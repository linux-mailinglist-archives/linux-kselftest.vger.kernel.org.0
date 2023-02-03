Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C084C68A37A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 21:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjBCUTi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 15:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjBCUTh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 15:19:37 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9260B6CC87
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 12:19:36 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l4-20020a17090a850400b0023013402671so9841316pjn.5
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Feb 2023 12:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=snn2OtE97SRGjOL3rkSvEhGeyQgzAPT6R9P36PRTQB4=;
        b=UiI5e0br+hdoLxVxPpBQieP9Cu0CoxNlFagxUcvXvj/mUwX3DooTzIPMufTGdsS+lT
         OFsX/7mCaeEMiXvfuZx5Bh5XSMLtfntRsyxBDVZk4kNlPKtv6fXxi1lh394ETMqiM9Gt
         BIpqibyS2ejDZqIAgHC4zjZ+/dqM/Jlf4Oa/KnQoqFQbQu7CIaqsxV8Z5igfpggfYDUc
         iz4trKSpTNWBgvNNCRabaAe5DnPLSEPuaDzUFjCWOkVbxmHJXdak9lPwCsrjWSRgHW0c
         s37VbJPB1jLmb9lDoTwBTS/WsNFz6wSbV4amVlOYxiMSXGlJVu+JC8c3NRsN8yNbhM3h
         iL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snn2OtE97SRGjOL3rkSvEhGeyQgzAPT6R9P36PRTQB4=;
        b=RGXB4W+HInddXPqmkHN4g7nMaPpQ2NkPO20vEHSpghesXfYNf6WoGZcQI7EOBjBzsq
         HuJ2Ib6oMpKp6XGYxv3YMIvPJrz1+DVimXhmX9nObFx/zrk7SKBoSPaUSaShDefsDJjk
         RySUT6vmX8+gxiadvu8m0h7zxKVY0T7cONdGM91opPEqwBb1oxR8YErmkPTR/ABqPefB
         vNdn4RoikMjSjYa8aPyjnyePTPMgcpdVprZRg1b3sZl0W5G6D4Gt9V9PJ+fZcERKm9cg
         KbdjETC/bqcTfbKQUPsLixkIOPtnJz2NbeCLoUdoloYe1huPQpYkppUl5jtEP73Jhfjo
         RYkw==
X-Gm-Message-State: AO0yUKW7t5Y/j650cJzhjePZWyMSIIXBqMCKWXUcZRe5dF+ed3AAjdAG
        4Qw3bxCDlA/WldeQmotWq52CIA==
X-Google-Smtp-Source: AK7set+j8RfbB37G5G+/W7hXFQTR3o9usfp1/BK0AknxJSMPoHP2gJrcDPXHCwb9wxnPT2ToUycGUA==
X-Received: by 2002:a17:90b:4c49:b0:22c:722d:be03 with SMTP id np9-20020a17090b4c4900b0022c722dbe03mr12180372pjb.32.1675455576075;
        Fri, 03 Feb 2023 12:19:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k24-20020a17090aaa1800b00218daa55e5fsm2055260pjq.12.2023.02.03.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 12:19:35 -0800 (PST)
Message-ID: <63dd6c57.170a0220.c7dda.44ad@mx.google.com>
Date:   Fri, 03 Feb 2023 12:19:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-35-gb23b16d35135d
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 7 builds: 0 failed, 7 passed,
 2 warnings (v6.2-rc5-35-gb23b16d35135d)
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

kselftest/next build: 7 builds: 0 failed, 7 passed, 2 warnings (v6.2-rc5-35=
-gb23b16d35135d)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.2-rc5-35-gb23b16d35135d/

Tree: kselftest
Branch: next
Git Describe: v6.2-rc5-35-gb23b16d35135d
Git Commit: b23b16d35135d8c067abde6a6e1467127c3dea87
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 2 warnings


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x141ef6
    1    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xcc: relocation to =
!ENDBR: native_write_cr4+0x4

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
defconfig+kselftest+arm64-chromebook (arm64, clang-15) =E2=80=94 PASS, 0 er=
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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 0 errors, 2 w=
arnings, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x141ef6
    vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xcc: relocation to !ENDB=
R: native_write_cr4+0x4

---
For more info write to <info@kernelci.org>

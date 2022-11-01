Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42166147A7
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 11:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiKAKYu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 06:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAKYt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 06:24:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28DADF9E
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 03:24:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id j12so13146792plj.5
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Nov 2022 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uc8EMo8fmnnWIYWG3csUSYQ+OHdoWbkP79x9b+G2Nmw=;
        b=jE5JOCxq/IOOirJhXmMDkbQwG/8DCdx3gEPh9qSKGmBykQwnNMIQijrKFG+8+X32Hy
         ULHjPqmtSOWHawcufnetQdxCwBRNQ8c45hkEc6m3E0+fcSB8xAtccKhz0sqkleWRUgvR
         RHYgUubVpunTA/feKjsdFTZwJyKjM5ZCwZZhX/gWX9FQEEk/Enu7DfyetkTI5J51K7sp
         aDn1sor8eqsZh1Wb/+WOot9+HRvDRGHWfqsmQJ+rGkraqr2/m1NeSMtFq+WnnDXJkyJS
         qkOqBbO41p8tHDJyf34NFXXh7nbXd9Q+uQwtGfw+PcDMP2/iwij52uvvpjoDVbtJPR4i
         05uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uc8EMo8fmnnWIYWG3csUSYQ+OHdoWbkP79x9b+G2Nmw=;
        b=yCyHaFVui3Mm2njhKO1HMHWH+w6p5WVMezjcBpQNYnmWeDzo/zBQFNegOrxoJVc2nP
         ZL4jm6Z/aQgxS0uht/u6r/OixF9D6uJ5h8V3KA6xKv2P40NC+J9V9u4mZG6gzK4CRaMq
         tryNTVzFH/a1FrClJhVdazYEzvJ4e8A8Txu4O5aulSl23m/tAtrTiV5fW/FbARtgdndm
         6IFtx3VaeGoUx/GUIKYhnOH+EHIePXIe2ZZeb/2U4MiMZJw3V4aWp1CRzMyj4ciUFZ8T
         fiHCEMHqx3ftg7pYUqUT2sJHumSxhTp9j9G/hdrufPR4OS6w8PR45tGeV5DVfX0CShEU
         Y09w==
X-Gm-Message-State: ACrzQf0BPWNNh9GZkgTwWXRPwpbzUKEK3NyT8Eo9w1xmRnrqI8XNno5T
        mSj9EtM57vvN2upBCcwq4DnFZw==
X-Google-Smtp-Source: AMsMyM5eXlo7eyeLEiG/yY4LLMrs1j2pwTTR2+SyQKye0PQRzndtPVFWOC00eGIO1M2GkB8WfrwOUA==
X-Received: by 2002:a17:902:8343:b0:187:31da:6195 with SMTP id z3-20020a170902834300b0018731da6195mr4780934pln.62.1667298288293;
        Tue, 01 Nov 2022 03:24:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090abb0700b00213e4d6c831sm3231372pjr.13.2022.11.01.03.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 03:24:47 -0700 (PDT)
Message-ID: <6360f3ef.170a0220.724e9.6515@mx.google.com>
Date:   Tue, 01 Nov 2022 03:24:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc1-13-g67c0b2b52916
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 error (v6.1-rc1-13-g67c0b2b52916)
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

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 error (v6.1-rc1-13-g6=
7c0b2b52916)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.1-rc1-13-g67c0b2b52916/

Tree: kselftest
Branch: next
Git Describe: v6.1-rc1-13-g67c0b2b52916
Git Commit: 67c0b2b5291656cbcb15371f835f5152fae2f7a2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Errors Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-15): 1 error

Errors summary:

    1    error: write on a pipe with no reader


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
x86_64_defconfig+kselftest (x86_64, clang-15) =E2=80=94 PASS, 1 error, 0 wa=
rnings, 0 section mismatches

Errors:
    error: write on a pipe with no reader

---
For more info write to <info@kernelci.org>

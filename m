Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A3467BB96
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 21:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbjAYUDI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 15:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbjAYUDG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 15:03:06 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E79D38B75
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 12:03:04 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d3so18926774plr.10
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uezlEBEVYWiErG2R4r2LTALgj/lP4QaQKiigG6SxoqQ=;
        b=v6C3x8M04dsMncTE+G2RVVYcCXPFyXBT8wwaSFSSQ878Dkp+Vtx621nPFPoemkDahU
         r7iUTtmc8rkwzoJx5ZFLob6yxTilLK/UNbk+GmgUl4a+HXV130TqpbUOeRhwZSkBVWEo
         nVUZiUgucMKdnHaVySYdf86xLtAq9Gmv64C/m8mxKcSrvBeQR3g8x6n8IHkC4l810iG3
         NR6t7ojJpWrjjwFUMrP3vg/HasOw4Ot+BoKa7/Ol0qC6w5/SCS7NfyujF+FX4HHbPMHb
         fShlQmuBWcpLexd7XVJF9V5J4hSyiAZmyICSxTWeyuOJpSW74PK/Ej94X1r+U71Lq0zL
         x9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uezlEBEVYWiErG2R4r2LTALgj/lP4QaQKiigG6SxoqQ=;
        b=46Yid7XzoJvLRjNc4a1oE8UqmWvq2+481clFU04OnY5Tz8cLYexAJQOQYyDEBSNLCX
         9ov94rQCPTz/NQ9LJ5hvZam8txZsyvg3VFCaJKLF1AIxCBRKbMIdLs49rNOhIqXpP0Qk
         0HZCKUbA8/EJRwiG8gKJKudnPBXt18RVUOTH1oj7OwFf5EHLLyE2TNj8idBwJmlqEEGJ
         rr/nzXG9eH8tLcvuxoKjDCAkROwOEsPq4FGNnx+NWHLo6lBn2YR95VCqT875KlKkuq6o
         yXH3p0T5XuSj5ku3QHEO/+XqKI09/JhCH/6KalUWhLyODrYlRmruBOiytsORY4GvQOD4
         +pdw==
X-Gm-Message-State: AO0yUKVP+MEB1z86RUy71BfmTzyW/QfGn4XTBk6FcMNcmkVUTxaVHf9O
        JoIr4pflyrh7MP2EgL4PTbGu75V5J2tS3HHYvSk=
X-Google-Smtp-Source: AK7set8a9LzLzikwUTBbA/Kfk6+6sRoY5ayr4GTn+9Xp1k99oMkiW1o7ZBaOwtkXvWTi46+YUX7Nhg==
X-Received: by 2002:a17:902:c60a:b0:196:2acf:f27a with SMTP id r10-20020a170902c60a00b001962acff27amr2270017plr.36.1674676983999;
        Wed, 25 Jan 2023 12:03:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jh6-20020a170903328600b001960cf9655fsm3934627plb.309.2023.01.25.12.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:03:03 -0800 (PST)
Message-ID: <63d18af7.170a0220.743ba.78a1@mx.google.com>
Date:   Wed, 25 Jan 2023 12:03:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-livepatch: 1 runs,
 1 regressions (linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8)
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

kselftest/fixes kselftest-livepatch: 1 runs, 1 regressions (linux-kselftest=
-fixes-6.2-rc5-1-ga49fb7218ed8)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a49fb7218ed84a4c5e6c56b9fd933498b9730912 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d17ab20f33575e18915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63d17ab20f=
33575e18915eba
        failing since 98 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

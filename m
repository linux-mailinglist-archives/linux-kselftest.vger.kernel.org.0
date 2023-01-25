Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB1D67BB93
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 21:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbjAYUDE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 15:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjAYUDE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 15:03:04 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDFA298EF
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 12:03:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso3225034pjp.3
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 12:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pQ151XbWFnzr6halobgCFdpUAA/DSGbRgqUMsW6d8jo=;
        b=Sr7EbTbrG6bkrm/WeG1zrEtfx9WX1M1qgp4ZysVpliCvl/YE9SCnEGEVn+6R/ZhwZY
         lkob7nm+HJZH2qgwV34IiOHab/aIlwTsVcFOFi2LLvwRG8Tp3EI8hpQBd8vXU2nhT+JI
         YMLtAaMjaTpqVqrz03nOaowENbzuQ3Rc+Tlrz/3A0hYa8S0yDkaCUP6vWM1OcJspw5EI
         zRnsxy6nsF1qGTC33T1U8fhttsEdRx4dc9DveB5Y1wmKD9ll5UuSxNgWWQL0ubOagICd
         i8GpYEd6aDcOnRkHX5uOUQ+zGmJ/9wz/4czaF/04a7O4GPXH0kIt0oEMFsyLZUSszi+X
         hf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQ151XbWFnzr6halobgCFdpUAA/DSGbRgqUMsW6d8jo=;
        b=BnS6Erm9ZSH3FpgX1Fz9wmgKA7tAvUzBq5X3Rj5ljRa6sm0l0cE/8QMGf4VMGH6MG3
         9hiIdTyeh54+KFWPdaty+F8WOyAx4Lj8fyYLf0gN/q/RD/kG/6YjjWD97zJurscorRFR
         ShwQgYKYzGgSk3zNgD9zVIM1xuO7/lS5+rwO6wmmymua3aiH5SO7HHsfz6bgdlRwhypd
         KS4RJO10D5nYOtiX7Q0Trw6zb28gUlfa5/MBXRBalFMI/2lDNRnxl/QDfMDH6R3hlb20
         Qe4RUqyZc5AM4tQ+KPBLiHSBFX8LWEnB/fzkezSYA6AnFSonggguPya39bVgAaUCosHf
         HOVQ==
X-Gm-Message-State: AFqh2kptdcwJkVIja6recgLlqDBg2nFbxv0XJqmdQOqT26HKaDiJd3IA
        IwNTxhJbP8EKphtL2wBs/Qkpy88cc5J0tAQaSVU/ew==
X-Google-Smtp-Source: AMrXdXtfpn6DJtWMpLN5PLpeOsJ1uVt36ZNI2+cVbOHrxZPsbajPj+k50LqyihKjqinb6/RNdh/7HQ==
X-Received: by 2002:a17:903:18f:b0:194:d5f7:847a with SMTP id z15-20020a170903018f00b00194d5f7847amr32947554plg.35.1674676982500;
        Wed, 25 Jan 2023 12:03:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001745662d568sm3974746plb.278.2023.01.25.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:03:02 -0800 (PST)
Message-ID: <63d18af6.170a0220.c9aeb.76ce@mx.google.com>
Date:   Wed, 25 Jan 2023 12:03:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: linux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-cpufreq: 2 runs,
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

kselftest/fixes kselftest-cpufreq: 2 runs, 1 regressions (linux-kselftest-f=
ixes-6.2-rc5-1-ga49fb7218ed8)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux-kselftest-fixes-6.2-rc5-1-ga49fb7218ed8/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
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


  Details:     https://kernelci.org/test/plan/id/63d17ab1a4a612df5b915eeb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.7)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux-kselftes=
t-fixes-6.2-rc5-1-ga49fb7218ed8/arm64/defconfig+kselftest+arm64-chromebook/=
clang-15/lab-collabora/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63d17ab1a4a6=
12df5b915eec
        failing since 98 days (last pass: linux-kselftest-fixes-6.0-rc3, fi=
rst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

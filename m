Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B5260DB81
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 08:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiJZGmM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 02:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiJZGmK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 02:42:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242C7A834C
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 23:42:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id io19so8194430plb.8
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3mICiiZ0n7RGRy3iELcb/mS6KANhT6KyoULHuxkJLgU=;
        b=wY4v/o/qzDaXcvW04y+ubsowJaMtFn5cvKi+zLJZRI/BWm2Lx6WbZ1PIK9fI8mADTY
         P971gW5FCTJmAEiyUq95PO5WICGwWTL0fKzN98zIURhMccQqvuGMf/wKGek/N8dSFmv8
         w98S2FXPaKSKaai/2cjTMQfielaZtpagOix4L90C93WPixOkiv+HtvUoUuSRYPvLhEaQ
         D9rOGc7V/AUorLtgK76sGzj80ZSWZWPYmsIKeXuDt9dOnHNtN7ht7EcYakPu3fkTHEmZ
         BT4AFNuGknSuT+xCOQHUWHX3xum+OduQr+ZqEZxEmAhKjjzwwtzSHlP6noqDKsHbgc11
         aDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mICiiZ0n7RGRy3iELcb/mS6KANhT6KyoULHuxkJLgU=;
        b=sEtFEA4+FiHRy2L/jTgRtEF6GVTfsqxlKMdFdVkF/8qYSUbmF6JKic1e5d1+iA3XpP
         7gaUfwKrKI2/Qn1ShV/9XZqIAVG7BQMqlYlpmE/QHqU0ZC3/mup5heNgDUKs7EO1AdFM
         JkV5nZfP/NGlnrbsDXwF2dIgxX2FbJfmqueZGE90ID+ZE42OVgF07rOQgKYvMPT+KF+7
         LIO3OggxlqpXnRTl0Nsouhb7Jw8JniwpmFox5IPqGdAPAByi/LlMf+683/IR/N5TPXTg
         hWic8Njz/DMQR2br9y+pMqQrgUbtjsyOgW/obcswFMmQD4D3RHX5gZdGgASJLQO2uXFc
         Eb8g==
X-Gm-Message-State: ACrzQf1dlesIbT65sheVflP/wZpf1mZHnaJ3lJPfsU2SmsPXUNr5tV7H
        PtulG4521O5bnUeKdRiS9PBhaA==
X-Google-Smtp-Source: AMsMyM5ANrZMC7QvooLGaFa3tUvawtVcirkkLBAhd4S07pPAi+2wrzdggwGLtlkNsQTk0rZC5pEQXA==
X-Received: by 2002:a17:90a:df04:b0:213:1cf1:435d with SMTP id gp4-20020a17090adf0400b002131cf1435dmr2597693pjb.210.1666766528278;
        Tue, 25 Oct 2022 23:42:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g17-20020a170902d1d100b0017f74cab9eesm2195268plb.128.2022.10.25.23.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 23:42:07 -0700 (PDT)
Message-ID: <6358d6bf.170a0220.6316.4ec6@mx.google.com>
Date:   Tue, 25 Oct 2022 23:42:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-5-gec7b4511185b
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 3 runs,
 2 regressions (v6.1-rc1-5-gec7b4511185b)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-seccomp: 3 runs, 2 regressions (v6.1-rc1-5-gec7b45=
11185b)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-5-gec7b4511185b/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-5-gec7b4511185b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ec7b4511185bba95fc702c33a388582c8842d454 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6358cb0c135546d81a5e5b3d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6358cb0c1355=
46d81a5e5b3e
        failing since 8 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6358c7c40586f95d9b5e5b3e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-5-gec7=
b4511185b/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6358c7c40586=
f95d9b5e5b3f
        failing since 8 days (last pass: linux-kselftest-next-6.0-rc2-11-g1=
44eeb2fc761, first fail: v6.1-rc1) =

 =20

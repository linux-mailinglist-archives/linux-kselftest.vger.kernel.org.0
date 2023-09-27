Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674717AF908
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 06:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjI0EJo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 00:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjI0EIJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 00:08:09 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477735FC6
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:17:04 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-774105e8c37so645012985a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695784623; x=1696389423; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wkJjQ0NAuM2/sKvcyN87mPamylcnHo351ZBjtiY74jo=;
        b=s6yP+fX6FeDMFca5WNuSBX+bbOvUNnkMFNEoOCdYS+J76QPullHWcM+lGANf3FynNc
         tXno8aEZqc4/77fqRn0ZKhEAgphKk6TAjr8eQn7x5KNn6RDTUbYanBBMGEfNf/06mlKd
         bghhQCZ80beDsBRjSEh9j50Wwle3RNXZx1sdkx7zZ0KNuajhcYDLxYMJMjEWvBhA54M4
         useGNSaOhTsxrL+JYfa928nk35MsDwZwftiLGGB0zl/pd2EpBEIsBvTcOtFq7W0PtNT4
         Mvbj1uPYm6tEySURk8FqLjaqrEollMQf3wh+iDj8cwRXKA6xK0dzLRQ+Lr+MQ2Pa08xy
         CuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784623; x=1696389423;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkJjQ0NAuM2/sKvcyN87mPamylcnHo351ZBjtiY74jo=;
        b=iNj38dKM60H+pdKqOI8nP2cbgnVDs4RGxOJ84831GWJUrdaaTeEKHrH1OqO+OFe6zj
         qEhSjiHUEfRMXUOtb5ppkMVVN8FKk480Hwt3FazZ2DeWOcn76rncBiodv83pIQvBUqUS
         WA/w/UdZX9M5SWrUQ38swNoUjRgtgM/qQF7EHhWRMKh3aeFx3UNGGqGpfqNUrh9FqgkE
         Hafe+kCrFfd3K0jCldNcXHB/fhv0GLos2QsWOWhgTXdyMmF7FwRfba7kClaMyZoJUDnf
         auCmrY5w+dJnyrOdvZ7QRodgL8JmwocrtV6ddOYkwXErEmmTnor7cTtItUnrfj/3j35Z
         ORrg==
X-Gm-Message-State: AOJu0YxUdAfvkqGgiqXFH/V0ObSOWXcA3wVFE1h9MzmLkieTIxw/Ro/q
        Sg+fVxuw5H7kZnbhvpSfDL0bN8T3CvmTo8PXl0ISIA==
X-Google-Smtp-Source: AGHT+IH5CIH3AMJviGn1P4nQC4smMOu3zDtgAhf9oddMIb3fbC5xYLS0qi2HgFQSPOh1QOGF1OxkiQ==
X-Received: by 2002:a05:620a:210f:b0:774:c7e:4306 with SMTP id l15-20020a05620a210f00b007740c7e4306mr652694qkl.68.1695784623393;
        Tue, 26 Sep 2023 20:17:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id do17-20020a056a004a1100b00692b0d413c8sm8312908pfb.197.2023.09.26.20.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:17:00 -0700 (PDT)
Message-ID: <65139eac.050a0220.9b989.087d@mx.google.com>
Date:   Tue, 26 Sep 2023 20:17:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.6-rc2-2-g078a2ead544c
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 4 runs,
 3 regressions (v6.6-rc2-2-g078a2ead544c)
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

kselftest/next kselftest-seccomp: 4 runs, 3 regressions (v6.6-rc2-2-g078a2e=
ad544c)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-2-g078a2ead544c/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-2-g078a2ead544c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      078a2ead544c56fbe6a3bed8cc90b5151a328b81 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6513969c799f1d86fa8a0a4b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-me=
son-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-me=
son-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6513969c799f=
1d86fa8a0a4c
        failing since 341 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6513913603509d96518a0ab3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/651391360350=
9d96518a0ab4
        failing since 344 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6513913f1116b4bcc38a0a51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-2-g078=
a2ead544c/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6513913f1116=
b4bcc38a0a52
        failing since 344 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

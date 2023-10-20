Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513847D13C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 18:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjJTQLo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 12:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJTQLn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 12:11:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCDDD7
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 09:11:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so912005b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Oct 2023 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697818301; x=1698423101; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XX+a8mfEEMOve9Ecy4wKRDfiZqXTIG2ylwFwkEmTT+o=;
        b=MzxIBAEKcqJKunr5+Mn5QDQgxR8wXviEqjecPZwopFkwbUtIqooUrIJ9/vG1FA86Cv
         K1uy4w62bFy1aQ67f24USkmb/ysfDxSZLtZM9kuorON7gts7bcOsL5EMtvOqqGct+oOM
         4g5pMeWqvpLGYY5ybj23akUezU19Ve7c2j76wLz7ssSgMopWMxDqJHEjq9cPEIqLGlRB
         RIEmlo3zoMaonT9jPHErPfbsyj5YsWRuCyXWYRu/npdkn2OIJ4rD6JoT7bDTVwW/JBqK
         ZStKBFIr84cOTKQK7yljz90NM8LH9n+vItw2RYfUQrXReaNWARC/oDO9t/gCa8hfG0qP
         pU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697818301; x=1698423101;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XX+a8mfEEMOve9Ecy4wKRDfiZqXTIG2ylwFwkEmTT+o=;
        b=VnctrVjDFWiLDAy0AFSlP06lLhZsbCAG6uNm8RDMxKDVdDVRwyfE3IvB3sAoXwti5w
         49fF+XR+kxmS5CCU9UcGdJWKmX0oqy8aofmIIXQH8ULqQeN/2F1ERAYbfZRLedUo8SFj
         glnM8gODv9hewKotqalizzTgncGQNaGpSWMkYMxBsNJZLWU6be0p7kKGiNt9elhyXlBj
         Se6uXRoJKVsBUQx5hHTKk82XTHsz6AzI6tRfsrn4r59forcV82tKcgnHWpycFrVfG2z5
         ZgwVVeWHjQKfsd16CipBJToUiF6VAF4/Thp28aFBRBbW69q0qZ97DUf/Lmnui3MykYTI
         Idsg==
X-Gm-Message-State: AOJu0YwTURrWlFVRfM5oLGpXpxrX9+ywLrnAV6UNAgOpdklmPrIg2SBY
        phBtO7zWlqKVqIEbs62zmIZzzA==
X-Google-Smtp-Source: AGHT+IESCyegnKwVJggPnyzAlScqgy1K88YJNQlh/j6erokPDvI/DGMYEC4dJZCl+3Tb1a9rdsQshw==
X-Received: by 2002:a05:6a20:e123:b0:169:3769:2739 with SMTP id kr35-20020a056a20e12300b0016937692739mr3080525pzb.14.1697818301119;
        Fri, 20 Oct 2023 09:11:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709029a9100b001c5f77e23a8sm1695521plp.73.2023.10.20.09.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:11:38 -0700 (PDT)
Message-ID: <6532a6ba.170a0220.cc66.5db6@mx.google.com>
Date:   Fri, 20 Oct 2023 09:11:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-51-g5247e6dbed00
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 4 runs,
 3 regressions (v6.6-rc2-51-g5247e6dbed00)
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

kselftest/next kselftest-seccomp: 4 runs, 3 regressions (v6.6-rc2-51-g5247e=
6dbed00)

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
-rc2-51-g5247e6dbed00/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-51-g5247e6dbed00
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5247e6dbed0041147a83137f89cd45043301de5c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6532a3e978eae5cde7efcef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6532a3e978ea=
e5cde7efcef9
        failing since 364 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532999b640d8c7964efceff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6532999b640d=
8c7964efcf00
        failing since 367 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532997f7b818443afefcf09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-51-g52=
47e6dbed00/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6532997f7b81=
8443afefcf0a
        failing since 367 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

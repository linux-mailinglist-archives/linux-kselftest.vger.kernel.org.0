Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5976D6390E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 21:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKYU4u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 15:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiKYU4s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 15:56:48 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8A230F62
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 12:56:47 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f9so4810208pgf.7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 12:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JqV/PbCFVTtkSVZ/VAsUJzhSuYWWAEQtZCD706pPwHc=;
        b=7qCxfjzmKnY3WJiFYa8ukDX3vjHka42NUfbj84yqoKIi4RMnNyifrYTMV4QvbUVtm0
         reeNlqLEcVVv4qFO4ShKQSXwJTJTheXE+lhPMlZZ+u/ii9WFfLeUluNYoIl6/bWMzuwO
         5Ok/5PCYhd1XYXUTufnfnsDAllLg/s4ZRIO2TZ1R+tEy3YWkbTmOGf4+nXkCxkNqjdj8
         3MRS586CYOpD2WFqfq/HPJDqi9OoON4+iLQkDglmTaeab9ktHzLxAWm2DynicdTP/gcw
         1CqqFKtb//R6sm0xOegZXg3oTCMLnCEBgsPue/l500835jCpIJ3pHedN7yoy22ypFpF1
         LPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqV/PbCFVTtkSVZ/VAsUJzhSuYWWAEQtZCD706pPwHc=;
        b=VEa7H55yoOEiMWvgcZ3Y0aFuMcfzUIWFA4imkC5c4M0XAh2NxKXyINMRWb5EwjqxbG
         wPUBdgrInb4E4wjm39ETQNk+h5vvODLgpdNwnAjcndJGABPxOJCY3xLE4U6SY2haW3sV
         rJ26EVx+emhupCSTstBlzUqfkooLRcWU/E0uV37oOxfAFN0LSpof7MtKy2i4mZdGD6zR
         UfpFaC1a2J27FuNliEFaejW0z/h6hWdho33ij4mxFtNtF1yO6kVJRl84T8ur1b0SOTs4
         AJzJx0jL3pm8LnozyNxYrEPzKHxsQTRnavSCaccNExK4ZVNMY8HBSjwQj/rJDUT7Kfyx
         LolQ==
X-Gm-Message-State: ANoB5pmDKj5zmEuV4+wtTkfC/3YeVd9lV57FKPismObaG+OugdHPSVms
        5ZoqtD9xZNkqCI/WURnRFq4pNHwuiwLbbiuweBM=
X-Google-Smtp-Source: AA0mqf4ccYvrxIAuPXcL7OAn4FsAdZZOD4HmaWW6FmeV3iuC8SBFCbyZNgGvg2odRV5bTmSYxvousQ==
X-Received: by 2002:a62:6d46:0:b0:563:54fd:3638 with SMTP id i67-20020a626d46000000b0056354fd3638mr41672309pfc.44.1669409806673;
        Fri, 25 Nov 2022 12:56:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id mn21-20020a17090b189500b00218fb211778sm3568129pjb.41.2022.11.25.12.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 12:56:46 -0800 (PST)
Message-ID: <63812c0e.170a0220.487f8.513d@mx.google.com>
Date:   Fri, 25 Nov 2022 12:56:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-23-g00dd59519141
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 3 runs,
 2 regressions (v6.1-rc1-23-g00dd59519141)
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

kselftest/next kselftest-livepatch: 3 runs, 2 regressions (v6.1-rc1-23-g00d=
d59519141)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-23-g00dd59519141/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-23-g00dd59519141
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      00dd59519141398120b4baa65c0ab4b67dfd3e19 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63811deb822031755e2abd0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63811deb82=
2031755e2abd0f
        failing since 38 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6381218b19abbd913c2abd1b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-23-g00=
dd59519141/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6381218b19=
abbd913c2abd1c
        failing since 38 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20

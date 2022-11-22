Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BB863445A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 20:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiKVTKd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 14:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiKVTKc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 14:10:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E29F8CF24
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 11:10:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t17so13344979pjo.3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 11:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JLWtmmbk1hjui/czkZy4IAADiUpTA2v07ibYKtpT7yo=;
        b=FR/s9yyQfwP3RZ/NwGc3IvKvHRDjFEVIWMs57zur+tMDxmkETcDVaNPCE6lhhuwEs7
         d7WorT8CMzyBL4B5WCZfEKlzS6YV0GCfVpHUyUexs0lc1VQVpVV/oSMvPOs4AYkyXfCv
         CoSuMyzQamdN/GkhUDaTrhwKfjFVfKWh+krO8y0b4ERpyM4JFaEHeRlcJ2/xLTRmkzQi
         +a57k8np17GWZmyj2YlqZ0S19eC/3gcCYieU/Yt4FvxuKJiIpbWhNvknS30w4qPQlCFN
         l7KYxiL2Te4KMS9tZQIQ4tOY7UYK7yR1Vu+1v8wCLL7bObftDXCrs6ipnFAKMUmOgUM9
         KNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLWtmmbk1hjui/czkZy4IAADiUpTA2v07ibYKtpT7yo=;
        b=LUrrPdRUcFvRRG32XDndGazM7eYwv71KhT6QR/JlmBhhjXwOWpji4etdjch3IqOHGq
         ALMyyHJW9Zgrak0FFi34tIK6AdGlebZ3/1VR4dAGdBZO+7hbDTHrv8WRz0XlpbxD4p7B
         DHQXip/cF3SJ0XdgHE/v1qyTHqlTMCy+2TI2cjUm4CDj5IUlFe3anZkzxzECIBYrj5Vh
         AYasOZRIRrkctlf6IT3Mzo2fNY06ySVskWiKMuVcyqH8SYxzdtXf4DOWdPynA3nOhx3U
         z8HNv+5pYjwg10NPW0RV4wNP4ndkJqu2AekUfI98vRdd9ie8u1TdA/92S9IXhH8YCxvx
         d3aQ==
X-Gm-Message-State: ANoB5pnVqfjfEK1qc+hhh5f4OfHj0HFX2bALUKwAwDWrZ8ELWkkWer7p
        E9Q0S3Xf14O3nQ+mFYOa9YxQUw==
X-Google-Smtp-Source: AA0mqf7D3lNrxEQyNY6BRxYkT/k+paAq6z2qvrsrzSV4ovN+i6ghYGJncFABNXgKqiHHMhs29VDu0A==
X-Received: by 2002:a17:90b:4d84:b0:212:9b3f:dee5 with SMTP id oj4-20020a17090b4d8400b002129b3fdee5mr32615969pjb.62.1669144230155;
        Tue, 22 Nov 2022 11:10:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d137-20020a621d8f000000b0056b95260b91sm11027018pfd.67.2022.11.22.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:10:29 -0800 (PST)
Message-ID: <637d1ea5.620a0220.ea38a.08db@mx.google.com>
Date:   Tue, 22 Nov 2022 11:10:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.1-rc1-18-gc93924267fe6f
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 3 runs,
 2 regressions (v6.1-rc1-18-gc93924267fe6f)
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

kselftest/next kselftest-livepatch: 3 runs, 2 regressions (v6.1-rc1-18-gc93=
924267fe6f)

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
-rc1-18-gc93924267fe6f/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-18-gc93924267fe6f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      c93924267fe6f2b44af1849f714ae9cd8117a9cd =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637d139cad61ee1b0d2abd87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabo=
ra/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/637d139cad=
61ee1b0d2abd88
        failing since 35 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637d122b2e4b5283e32abd0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-18-gc9=
3924267fe6f/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/637d122b2e=
4b5283e32abd0c
        failing since 35 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0709E752BD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 22:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjGMUsp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 16:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjGMUsp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 16:48:45 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D88CE
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 13:48:43 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8b4748fe4so7368465ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689281323; x=1691873323;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tr5ZYRznvbHSpLrhmMbSP6/P2urMS8ZnDKb4kRFLquc=;
        b=QmNCRamZG2ioqxJvXuQ7kpcudZ/PEVkxKuHROqrMpNPEHb8Ca0Kos4tjCpHaIl4iW8
         RPWBmmTnujVWizZcxa9hKgjno42Bfn0NdTpdKqciVX+Mfs2Ef/PdNVMW23s31lQZnE7m
         uN+X1BeCeksflYLXaIpc0WZGg6NuFwFPZdpfKLt5kH6J6SR82yrFxbcvhCbc+oBR2eu9
         PRF+UUpkZ0Q+79+4y958UDwfautqtmJKOUNMsD3thn5aSuPtp4kuWJ9FDLn/O+LEqXaX
         JSo1OkAMYwWJEoYB8KoTpj2tKpIk90NJirg4mG5GS3R4HaSuipHBjL+Hv4z67RTm/MTV
         CVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689281323; x=1691873323;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tr5ZYRznvbHSpLrhmMbSP6/P2urMS8ZnDKb4kRFLquc=;
        b=GNBxBJm45z1EnOsZzx15zhX3y99g3E46Zb0Zebexwj7KdheAmbeIjBlqZOukhXZJPh
         jQLmantq21cUQPAjFECORavk0jgfeqs83kIfywC6L3lpkmC1vszFba4ZG1ymMpVTQdLf
         0/fV4cUwoB48u8fffxqlvjuRPcT3WvTCigEWIu9FXfLqxdhqZPUSO6OCye9lplgzfcXP
         jl0KccIXSZr93EPwHM6C7um8JYjatJlzrur2S1wbNmKVcJ0JhusHjrHZy2r831026O83
         /Zk62Etfvmf9BtUKVnHuNbZtWxGUPzv0gAE3MkuN0b7obBiMM1G2+Vbe9mTfKhOAQndc
         INSw==
X-Gm-Message-State: ABy/qLaG8h+ltdxKtELMF2lBv59ifa/jHiacBJ2e269GPzEGeVHidh8c
        toUB8LzRCzgT/IbI6gwlAET1Pw==
X-Google-Smtp-Source: APBJJlE8nLup/bLas2xQLFShCOA0hLRRjbizSHqGD7O9lLmZUSSx2PdGdnUj5xxw/NYg8ZPbTqD3nw==
X-Received: by 2002:a17:903:32c6:b0:1b1:9d43:ad4c with SMTP id i6-20020a17090332c600b001b19d43ad4cmr2147133plr.40.1689281323490;
        Thu, 13 Jul 2023 13:48:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ji19-20020a170903325300b001b7cbc5871csm6383704plb.53.2023.07.13.13.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:48:42 -0700 (PDT)
Message-ID: <64b0632a.170a0220.7559b.dfbb@mx.google.com>
Date:   Thu, 13 Jul 2023 13:48:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: v6.5-rc1-1-gb33b8731566d
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-seccomp: 2 runs,
 1 regressions (v6.5-rc1-1-gb33b8731566d)
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

kselftest/fixes kselftest-seccomp: 2 runs, 1 regressions (v6.5-rc1-1-gb33b8=
731566d)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
5-rc1-1-gb33b8731566d/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.5-rc1-1-gb33b8731566d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b33b8731566d50aae6e11bd02921452cf3a7e0e7 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b0559a47d2a6413a8ace20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.5-rc1-1-gb3=
3b8731566d/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.5-rc1-1-gb3=
3b8731566d/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64b0559a47d2=
a6413a8ace21
        failing since 267 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

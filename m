Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD83056C581
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jul 2022 02:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiGIAi6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 20:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGIAil (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 20:38:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100BB764E
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 17:38:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso2558926pjz.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 17:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=eOOL5f+723faAiSlHx7PC7PgnCioS2X8+Peclx1uv/Q=;
        b=ZML9wsfa6SzfRKEX1YRfYlLIBTNTF0Xm/IaU9xC6eGAHeZdQU9oOauawEu1wRBBdao
         EBmR4vD/v1Jpki73RQK/msUJLtZi9bGSW1aQg5+Sycg3Xg/Wrs6GrElrq+QsGJ6paN46
         EnoUKVrNlEFLF2Hy7cmD4Vk86UvntswIJjuFREfSsCp+OTargSoNB8o24eMXvLZ5GqC6
         wPBlbXK9xPeFRNITuEevBnt5RpffJYTS90L7eEWwLsV7k2rOeOVlLcgwANxSYzy3YGkF
         iNonllV7U3VCp+WLF/IHPO+1fJ+j8d1xbiZr/UIJL965zoBcf7F1cq2LVuAQ0kHnzjBx
         ibxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=eOOL5f+723faAiSlHx7PC7PgnCioS2X8+Peclx1uv/Q=;
        b=Yj335nhvDdyC9xnBZim71osrlFkHAn6A8kq0/9aawBFeqCyEcDdYvfon8Rl2nSqfOz
         x6AxyCx8I+dLlr+PiZPpROB+2Jx6LLCwlMK2OttxsoblpyfYvSr3kYoCeySe1BdZc7K/
         aUpv+Vrhp+0AzfcLvpiDzYfCNE9ud5RryIxRk7phZEb/znXL1LxaGbeML5LvlOaessbq
         Ua9Jjxn+oEhSw2SNKDiwnsT8evrq+TB2i5HqAeZ5Vy5wp1mdvlD0VbN4gi/mNZw0JObH
         OZeT0n3Vc5yvCuj2ntk9CmK52Moan3eUy4p85Gvn0+WKpLoVpU877Fv6iBoVqHjBmss7
         8N+A==
X-Gm-Message-State: AJIora8zEuYGJCWVmUH6vhdwDk7YFzomBOv8XfynI1Cn/vsOeNoHeJS6
        qM46bQ2R37lAvV9iZw2bhq9IDQ==
X-Google-Smtp-Source: AGRyM1vJMXXsks5u8uD16IT8wiXt/2Z6BgtfRKm9OC5yw/Dltm0m/F278a2TerqiPZP/JzCeUuCPFQ==
X-Received: by 2002:a17:902:ef46:b0:168:bac3:2fd4 with SMTP id e6-20020a170902ef4600b00168bac32fd4mr6345893plx.132.1657327110524;
        Fri, 08 Jul 2022 17:38:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a12-20020a62d40c000000b00528d8ce7394sm176533pfh.125.2022.07.08.17.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 17:38:30 -0700 (PDT)
Message-ID: <62c8ce06.1c69fb81.bb3de.05e6@mx.google.com>
Date:   Fri, 08 Jul 2022 17:38:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc4-9-gdbeb23272687
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 4 runs,
 1 regressions (v5.19-rc4-9-gdbeb23272687)
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

kselftest/next kselftest-seccomp: 4 runs, 1 regressions (v5.19-rc4-9-gdbeb2=
3272687)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
9-rc4-9-gdbeb23272687/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v5.19-rc4-9-gdbeb23272687
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      dbeb232726871352fc3e688ff5b02897f8cb0dc7 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8be7aee6aa7d244a39bcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.19-rc4-9-gdb=
eb23272687/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.19-rc4-9-gdb=
eb23272687/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62c8be7aee6a=
a7d244a39bd0
        failing since 10 days (last pass: v5.19-rc1, first fail: v5.19-rc4-=
4-g43fe0cc46b62) =

 =20

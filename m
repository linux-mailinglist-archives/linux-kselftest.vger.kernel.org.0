Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860E055D626
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbiF1CJM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 22:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbiF1CJM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 22:09:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721B920BF5
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 19:09:11 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 9so10781537pgd.7
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=QzXxbf8rwKqqPIXpwjKjrTwkcQrDmIkP9DjV8IuApv4=;
        b=JZ/FCqTlBiCqVcT7O+EtiaGKjB8TD+5XYT7hnpjfJ/5q9qsEeAJIyXfXgXB4ZE9S8x
         ZgBWVdtZpG9/+5Kmt6OGMiQ9sGmFcmzs2nYufTe0w+47l7oZTHemkECVzDyVnSuzezap
         oFCd+GEvQeDcamurYEWnoplQbcbmhhaPflcIgQeTxR+AECSrEn64qpcHw4tTpHCLeZd9
         2zokBts2JsDaIqYb4ihDTUK6ZGY+3p6zoHAD6Cb1LhJFJm3ZhRa14RqIrMx+ZMg31Bwk
         0AsSPL/IxEP+bgLN0gke49O8c+xtIA1YEgVw7ob60GVsURCw1OZqnNBzZaILgd/eluvR
         h2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=QzXxbf8rwKqqPIXpwjKjrTwkcQrDmIkP9DjV8IuApv4=;
        b=wCKJ3M56xQlueG6JU3++QyDbB7UrupTYsFZPX0xEpaTpAmKhxgTbuCIQTx8bZyTtCu
         1xqgiTXhaayMk6AIjde9gsBxAsXhIk8Zhl8W+WfkEUmjqWe1Cm3BLnpYTqOYwBbCXGwB
         hVmdb1WVeVfwgewin2Nr+Iuntlwcj1KPfRsrVer+3FDqxne/NwT1nVlDliyy+8zze/Ia
         zfQhyVuCm91zXHXQPgyLZHOItypBMl5IxIRC9pN6d/ZLsHfBBc+4aQcQVlGTAAwJhdIt
         0JZg3G5RKqdPcLTouUrE2kyNOuNtebC6yvWa78xm9s3RxqWYK5m5TKcX0xM3kkVkxhOO
         DGqQ==
X-Gm-Message-State: AJIora9vPVQ+M6hq1gsi14gn6XPtVsuMeJdk7Lc6lsSMCeAD+kFcSLGm
        y1MPlqhzvQrCFLiBVj77QwsT+Q==
X-Google-Smtp-Source: AGRyM1u7Smn4ZdKfWJYu6+pUPv4CTmXPe29WlqpRBsgbHQWvHAsltBHvJ+uYh7qjOwh6utyM45e78Q==
X-Received: by 2002:a65:6944:0:b0:408:aa65:9464 with SMTP id w4-20020a656944000000b00408aa659464mr15090132pgq.160.1656382151005;
        Mon, 27 Jun 2022 19:09:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090a2a0500b001e34b5ed5a7sm10183221pjd.35.2022.06.27.19.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 19:09:10 -0700 (PDT)
Message-ID: <62ba62c6.1c69fb81.decf.e3ae@mx.google.com>
Date:   Mon, 27 Jun 2022 19:09:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc4-4-g43fe0cc46b62
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 6 runs,
 1 regressions (v5.19-rc4-4-g43fe0cc46b62)
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

kselftest/next kselftest-seccomp: 6 runs, 1 regressions (v5.19-rc4-4-g43fe0=
cc46b62)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
9-rc4-4-g43fe0cc46b62/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v5.19-rc4-4-g43fe0cc46b62
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      43fe0cc46b6206b25f0f13bb249f0078441ae15a =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba5536844f0e323ea39bec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.19-rc4-4-g43=
fe0cc46b62/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.19-rc4-4-g43=
fe0cc46b62/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62ba5536844f=
0e323ea39bed
        new failure (last pass: v5.19-rc1) =

 =20

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E042508065
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 07:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359380AbiDTFIb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 01:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359377AbiDTFIa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 01:08:30 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF6A28E20
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 22:05:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d15so757588pll.10
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 22:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xOjwgXYF7viEK5nd1+3dTRFVj/Scnz8gP00NEpAwhV0=;
        b=omZCDk7CAlj4o2vNo4i/LCjGd2B0uu2aW2RSSIWl96JQpU6c1yIEguV8qJfYTRAOoG
         XXGae9+aRtdi05eW6Pe7RW3KG6QOZQcqBIB4qs8F4CAxRgDeoWfkybNghHOy4usS01yo
         H36j7uIvw2boSdTpB6uFK1swIsqgme8PdDrwQrdkqOwtT5LmCj5e5/MeVoi0XrnSWlga
         K97aw6cg4B06qxWSyx526GJcsrJ+BAAZtMrDqsYWIMe3WvZMlluQwpdtrUfXtAUoepdE
         USJszZ64SFGYbV/Us7e2tftRjT6j9tXB7NnWyTSss3O1+74gxE+DWrrhM3g+AOonY6CK
         RnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xOjwgXYF7viEK5nd1+3dTRFVj/Scnz8gP00NEpAwhV0=;
        b=8LqejTHFXNZxl5KOICszRQ31bJMC1vj5Eo0TRC99iHDMywKuqlMLAdMY2fmFIYG77I
         kXOlhcYs0LFua8h/S3pXywXJGiNqln5QAvNuNnsqeFf+7KuXiQJrlw79Lo4HJS2d6YYZ
         XxQwMOLE3S90/DIJ3cdIWXjbOxOw9stBBZ9XofPH6fpS9LDvA/PvPZbbewibvXEGsaEm
         UltWrboHN9SUXqvkxfmI0xhyVjBJnjgXeVDKU7wpjj6jzDbuTtfgAH46TSZQPvPIaWrw
         1jghEIRdECxy+zxcBcT8g85A44XR0kwCyd9qeWRCw8QQPYLgkAgvkJUxaYz4StdOM063
         EBfw==
X-Gm-Message-State: AOAM530OW8Zw2nWmZ9nvA9DFdTAKidfMhy5q/QOCfN0ZnpYh253Xy0RG
        ahGtYbpZmC/yVA+KbSJudpLNrA==
X-Google-Smtp-Source: ABdhPJxT+qMTqea4P7HOKFa2d6WVSpDAVUmT1//skJhqwBjj+gBpqgAOZZE+/oR5hMGnMk0+u8z8Nw==
X-Received: by 2002:a17:902:8304:b0:155:d594:5c04 with SMTP id bd4-20020a170902830400b00155d5945c04mr18509891plb.105.1650431140887;
        Tue, 19 Apr 2022 22:05:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a0016c200b004f7e3181a41sm19536294pfc.98.2022.04.19.22.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 22:05:40 -0700 (PDT)
Message-ID: <625f94a4.1c69fb81.63583.eb7b@mx.google.com>
Date:   Tue, 19 Apr 2022 22:05:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc3-3-gabd26d348b2a3
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 5 runs,
 4 regressions (v5.18-rc3-3-gabd26d348b2a3)
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

kselftest/next kselftest-seccomp: 5 runs, 4 regressions (v5.18-rc3-3-gabd26=
d348b2a3)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc3-3-gabd26d348b2a3/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc3-3-gabd26d348b2a3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      abd26d348b2a366f8947e8c3c2ab9bc881ac9415 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:     https://kernelci.org/test/plan/id/625f86987ef0a55653ae06fe

  Results:     87 PASS, 4 FAIL, 8 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3-3-gab=
d26d348b2a3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3-3-gab=
d26d348b2a3/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220411.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf: https://kernelci.org/test/case/i=
d/625f86997ef0a55653ae0701
        failing since 54 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence_no_tid_in_err: https://kernelci.org/test/case/id/625f86997ef0a55653ae=
0702
        failing since 54 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence: https://kernelci.org/test/case/id/625f86997ef0a55653ae0703
        failing since 54 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/625f86997ef0a55653ae0707
        failing since 54 days (last pass: v5.17-rc1-2-g6d468898d774, first =
fail: v5.17-rc5-16-g1900be289b59) =

 =20

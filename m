Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27D64CDB34
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 18:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbiCDRqj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 12:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiCDRqi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 12:46:38 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF5825EA8
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Mar 2022 09:45:50 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id w37so8116364pga.7
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Mar 2022 09:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=yP31hiOg+pAyzdiFr9wQGookoKGVPY8g7EFfI/Jc/jM=;
        b=2YIpgAnrWksPm0WgC4750aYpVDATlhuisRde5wnABL7X+Sqr8/mAqq7PoWmfCGA7S/
         O9/rlQ/bl9P11JlLSbIQj2gUP81BhCBhmL52gpGoCt1wyYWWeF3lED8TE1iZiPhyMOCY
         MA2gfjLYCfiG8OXHNnxJgEQ1tCTf/mqYGu7TdAEuhrUzq/2B3Yu+JC7eKS8DsEqXQHHO
         Pu/k7wkGjfvciQqe3v5oJy4f78pCJa0z6TeldAP847vK9pss+pmvmfDmrDw++Yflgs4m
         WrVwMn+IIt0jaHLYyrPsDVQD8UyVY3Kqc8ZeGzpbAnRsBw9lbPl/LNVyDi+BshiLnE97
         DT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=yP31hiOg+pAyzdiFr9wQGookoKGVPY8g7EFfI/Jc/jM=;
        b=lBFhAEWfHKnREwy4Rh6ow4+AhbVBoSz8f/KUiBeKCIXIvFkgNIPi06514FlJPgzIZ3
         flfR952os38ftsImPrPS0wwbdAPht036hFOEYYFEMf2gEAYr2Ybm+HCNLH78zjSacq90
         WvUnnbiOPrhDDywYQx6WidGoDdSc+iG9iCQIYX7Mf8NsKXsyzdmjkFXjIvS+Y33thezK
         BDFUcvl2cLD0aEvE5ejb3iCt9s5mvPxcdvXRmJZwym5NpH3L1Kfp4psm76WQAdcE/v8r
         WMhedQb/iN1YSKcFuo1fEVfqcYrAGXC8Tsl9z9VllAOp40UlnQdnVIM4QLF+qNr1hlCF
         ZLCQ==
X-Gm-Message-State: AOAM530DpzUxYw4MobIRNNAZRSZff2DfyRQntdOOtUGXo08luVeeW0DB
        cHFHRB7sLxhELd2Xv94irq6JDhLRBVn5aBWizxs=
X-Google-Smtp-Source: ABdhPJzGE+IFXRtEXTlDb6D8JA3dudzI9fJ+0vFISklb54/CFG5ltQqZWOL4VInb8i1f8/DeqOpe8g==
X-Received: by 2002:a63:213:0:b0:37c:5bba:1f9 with SMTP id 19-20020a630213000000b0037c5bba01f9mr6587607pgc.617.1646415950166;
        Fri, 04 Mar 2022 09:45:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j5-20020a63cf05000000b00376c11ff251sm4963161pgg.66.2022.03.04.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 09:45:49 -0800 (PST)
Message-ID: <6222504d.1c69fb81.a411.d35a@mx.google.com>
Date:   Fri, 04 Mar 2022 09:45:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.17-rc5-22-gf6d344cd5fa6
Subject: kselftest/next kselftest-seccomp: 1 runs,
 4 regressions (v5.17-rc5-22-gf6d344cd5fa6)
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

kselftest/next kselftest-seccomp: 1 runs, 4 regressions (v5.17-rc5-22-gf6d3=
44cd5fa6)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
7-rc5-22-gf6d344cd5fa6/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v5.17-rc5-22-gf6d344cd5fa6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f6d344cd5fa6a15e1ec2da350470b35a3f55f74c =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:     https://kernelci.org/test/plan/id/622243d8ebfe12cf7fc6296f

  Results:     87 PASS, 4 FAIL, 7 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.17-rc5-22-gf=
6d344cd5fa6/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.17-rc5-22-gf=
6d344cd5fa6/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220218.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf: https://kernelci.org/test/case/i=
d/622243d8ebfe12cf7fc62972
        failing since 8 days (last pass: v5.17-rc1-2-g6d468898d774, first f=
ail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence_no_tid_in_err: https://kernelci.org/test/case/id/622243d8ebfe12cf7fc6=
2973
        failing since 8 days (last pass: v5.17-rc1-2-g6d468898d774, first f=
ail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence: https://kernelci.org/test/case/id/622243d8ebfe12cf7fc62974
        failing since 8 days (last pass: v5.17-rc1-2-g6d468898d774, first f=
ail: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/622243d8ebfe12cf7fc62978
        failing since 8 days (last pass: v5.17-rc1-2-g6d468898d774, first f=
ail: v5.17-rc5-16-g1900be289b59) =

 =20

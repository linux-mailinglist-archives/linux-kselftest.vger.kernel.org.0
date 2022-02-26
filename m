Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89A44C54AC
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Feb 2022 09:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiBZIpX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Feb 2022 03:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBZIpW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Feb 2022 03:45:22 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844961B84F0
        for <linux-kselftest@vger.kernel.org>; Sat, 26 Feb 2022 00:44:48 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so6919213pjw.5
        for <linux-kselftest@vger.kernel.org>; Sat, 26 Feb 2022 00:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XxkJdSWkkXBJ20DuBDMqA2mNQJ6gCZGnWTgnI341ZwY=;
        b=xQbiz3WWBKf0bDKo6po6jqMqNJ4HakgqCTvMyJxngYbY6F3dTZJn67/AazYGFgxSKx
         91zGsXRpdOJHJRrbfJW1IVZIWV/2TjffR3jseJlC45knV2Pys/acBWNFKkOmUSYmNX7W
         vrXZg8wgrltpFYFY4N0YHwWUHMeJ73IYBWvkZj4k2yrPoEoFMZenM98GEWlJ4hqRggEu
         QUEt5fdRf71MHwBNzL1CWdklQWEtSjkB/wWrEdD4Ex/gQxVADoRiwaQ04uBHP9b/qVYk
         fUL0T4KK/VOlX2UFHKi6tyWxrUVPoeRW4F87kXyFiLQiLd2BykEWj1eqVgO71XSgWoLU
         hZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XxkJdSWkkXBJ20DuBDMqA2mNQJ6gCZGnWTgnI341ZwY=;
        b=pQDNPSYIur4kmaAcNAXNtkbim7GFEQZ7Hts75W5un3pxyfr8rsRXpe9IayPfm7GSwl
         fcfwxxKEFAIYv40nniHhNtpfzDGGzRs7mzaJQlqBN7bj6M7WwUQCqxqsNMDDhnE6nmKr
         iPHWK9S87wNfp2n7QxQUpqRCYVvKNAVY0fAkE6Qeq3GPEL4GqOIrG6DGNsBi0a+WFoZZ
         OnrYxLP8ESeN4dR/V3aKoaWCQFZOd2aWg1hj3E4ZxoiljEnRlm14QODdzYT7TFSUaqaQ
         FKk/g4VZ2ku91SwNo73SlXkHHlyZ/oQ40/o01JkAkwflGzyU5KWP8uG9tpMiFAMg3lkw
         Tm6A==
X-Gm-Message-State: AOAM533LRFnuZPN1HPIQpRtYS8ItUTSCeGnQVx6QOFhP2FDCF9WSGbAX
        axwvQ4Exu928Did22cM5EJ7lFQ==
X-Google-Smtp-Source: ABdhPJwXEK54N/3p8VgJWFkrNajpnJlJ3yjxiWdmnzsONKGRnw4k/x715ZvmsJTtODIJRlpf6x3Z8A==
X-Received: by 2002:a17:90a:bd0c:b0:1bd:4af:6032 with SMTP id y12-20020a17090abd0c00b001bd04af6032mr4557598pjr.121.1645865088002;
        Sat, 26 Feb 2022 00:44:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u37-20020a056a0009a500b004e1414d69besm6093265pfg.151.2022.02.26.00.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 00:44:47 -0800 (PST)
Message-ID: <6219e87f.1c69fb81.964b1.01ea@mx.google.com>
Date:   Sat, 26 Feb 2022 00:44:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.17-rc5-17-g2aaa36e95ea5
Subject: kselftest/next kselftest-seccomp: 2 runs,
 4 regressions (v5.17-rc5-17-g2aaa36e95ea5)
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

kselftest/next kselftest-seccomp: 2 runs, 4 regressions (v5.17-rc5-17-g2aaa=
36e95ea5)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
7-rc5-17-g2aaa36e95ea5/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v5.17-rc5-17-g2aaa36e95ea5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2aaa36e95ea586ad23edfcc1d474e8b735a4d1c3 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 4          =


  Details:     https://kernelci.org/test/plan/id/6219d94423db4256ebc62994

  Results:     87 PASS, 4 FAIL, 7 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.17-rc5-17-g2=
aaa36e95ea5/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.17-rc5-17-g2=
aaa36e95ea5/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220218.1/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf: https://kernelci.org/test/case/i=
d/6219d94423db4256ebc62997
        failing since 1 day (last pass: v5.17-rc1-2-g6d468898d774, first fa=
il: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence_no_tid_in_err: https://kernelci.org/test/case/id/6219d94423db4256ebc6=
2998
        failing since 1 day (last pass: v5.17-rc1-2-g6d468898d774, first fa=
il: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_two_siblings_with_one_diver=
gence: https://kernelci.org/test/case/id/6219d94423db4256ebc62999
        failing since 1 day (last pass: v5.17-rc1-2-g6d468898d774, first fa=
il: v5.17-rc5-16-g1900be289b59) =


  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6219d94423db4256ebc6299d
        failing since 1 day (last pass: v5.17-rc1-2-g6d468898d774, first fa=
il: v5.17-rc5-16-g1900be289b59) =

 =20

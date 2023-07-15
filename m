Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63293754760
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 09:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjGOHzR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 03:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGOHzR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 03:55:17 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B5A3A88
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Jul 2023 00:54:45 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1b06777596cso2312722fac.2
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Jul 2023 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689407683; x=1691999683;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+gwQVyBKVZk4/w/TrKAgrCBHODtiro3VPc98s1k+HN4=;
        b=f+djD3j4nvR6L+FVQbT7WFVN0kFd2D3fecHkdJtji5XijC2WGkGSCJTzg5cGCxMyiP
         Ftv2NPAKFp7s0mYLhyxsUW5/QGSqGIP705PHYEI8iTFcmJjuHvSE8E6GzzPKq3jqKkDB
         LG3jdIvxdgueL5HighasrPRpfVFNYxbxzHXMPQmiPrYgG/CN8GUm8oR1QetUSOiirpYE
         pWJw9g/uThstJ8aFsMVtNMkpzcoeUP2ZetRlKIYNUxjdeh3xRLPR57fmj9CkoIHXBjoy
         wFn9SWd2pjdlEk1cO9ouuMTfVU6qAJnVGsHbgRRjn4J80QpUPykzKfeGv1ZmYQek+a5j
         JWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689407683; x=1691999683;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gwQVyBKVZk4/w/TrKAgrCBHODtiro3VPc98s1k+HN4=;
        b=CAWWMqQdaTRfP7loY0mO7cYuocExG1Yp6hIEdexUKOYNM+/oKKagIK0TRbKWe/+hHC
         Bqxlj4/YcAAiNAHp8SrowAj0RxrW22PHIIm1PkG1SUzXdS64eOhAaKC5tSZqUkcWzus/
         lrGGidvyemsgVTihoEcvqvl1Nl9gT1g4nLjHmlEUPLUcxB9TT5s4hOb6I97JjZNS5wsh
         VJygifsUVTNEwqGsOf5c59WriDNqjMxElNtpdleNYz26yF7SYXJTwW3eBWqFZBh8dNIb
         21e/ihr7JGwnqbSGlzRMmMVYFVHz9E4F23iC4Oy390lNZrkOLTODT3jjkz0iykLfJfbC
         TM6g==
X-Gm-Message-State: ABy/qLYUsgq4Zo/6cqZEA4SH781oiBzkbgPARiNyVjcEHlrCKlzmf8hg
        r0qG75XqKOXWBwhhSvM6HZObTg==
X-Google-Smtp-Source: APBJJlEkvgW6MznS9k7kk7oBS16x96wJxNIMFmfMB9PeP3tV/iKNKv34S+LojjBgXuNlXmg5saarMg==
X-Received: by 2002:a05:6870:d611:b0:1b3:93ad:70b with SMTP id a17-20020a056870d61100b001b393ad070bmr9262771oaq.27.1689407683022;
        Sat, 15 Jul 2023 00:54:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001b016313b1dsm8960222plg.86.2023.07.15.00.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 00:54:42 -0700 (PDT)
Message-ID: <64b250c2.170a0220.f2cb7.31f1@mx.google.com>
Date:   Sat, 15 Jul 2023 00:54:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.5-rc1-1-gfeac01aaf677
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 2 runs,
 1 regressions (v6.5-rc1-1-gfeac01aaf677)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (v6.5-rc1-1-gfeac01=
aaf677)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.5=
-rc1-1-gfeac01aaf677/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.5-rc1-1-gfeac01aaf677
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      feac01aaf677827a0b77115554e504ee444c9b7c =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b243511b2af9a9d18ace31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.5-rc1-1-gfea=
c01aaf677/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.5-rc1-1-gfea=
c01aaf677/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64b243511b2a=
f9a9d18ace32
        failing since 270 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09937C914F
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Oct 2023 01:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjJMXYb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 19:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMXYa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 19:24:30 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3756BB
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 16:24:28 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57e40f0189aso1407837eaf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697239468; x=1697844268; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l15cjeP1GDqeqw43LA59iLmhrbBhvNuIuwOM+o8ui/M=;
        b=AKmnQRUMOBZ27m67WqpcoWlpw2GxZxqAOaQ2LTXcRGfPvJxt0WOs9twrhTskyMwke3
         3Q2YRPweK041jyIbVhXD1CKM8Njh0tcsR6mMASYf68XHWEvLvVcZtQ6Wa1M01aR96H7Q
         OdGv7gjWF04ZfArcLL10FnJ1SPxnTsYGEeIaKN08GTTHP0fRCfyk3jaj/ld11eJuWp3Q
         Yx+HHLI5sua+T4AVhz6TS1IoD9QhFliPvhTfdaTsy00iq+Irud2HGeTETFjZ6ZV+teS3
         hw4wvboj1wwYl4vv0W81ShtUO+xagrYGOZIuStLDc9lnOG9j2VJrdRu6g+mAuAkL2Iv0
         RcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697239468; x=1697844268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l15cjeP1GDqeqw43LA59iLmhrbBhvNuIuwOM+o8ui/M=;
        b=DF5hTVR1SfIRkmHp9QrAXLxnVl7zk36FewZ8qeB0Nr00aPC95e8Dxw2iXMVTzbNmqc
         4GqAoZiwOzVOKaF3KnqVWcH/C7ce96+MoIcacD4OiLqRlRKCZpteyX3m3Fy7K+NxVl1n
         tka4NL7QP9MI409QXIrC0M48/kUpXrS0lIaYIbc4xOyJcM9N6uFdmLeuZmrBSjcUZ00Z
         1Jdn8Ui+1CSX7zjbusHVhN2hoH/R+zJUhAWcQAP+VnJDQEKgZY8o5UjOJpll3AeHtL8i
         C3HYYQI0tCWQrSrtfgcN0qiG/X9D27NgAM+feTMOjPawPe5F1QFbcvaylNfeqSG8hLxw
         AKOw==
X-Gm-Message-State: AOJu0YxVdq+0ZJEWhCmc2AWMLgHDE2l5nJZNx6zFGBHPTybsq2LmDxND
        3fZ7URbcu7cQ1Ii676JtMhVIPw==
X-Google-Smtp-Source: AGHT+IG9ikBmjKnH7tvdghF6E+kR/oA5DSGo3VSNuBK8GmNGnIOlpcOn6Q9IzOW7yqY/2ItKiWuDbw==
X-Received: by 2002:a05:6358:7e8b:b0:143:9dcb:2 with SMTP id o11-20020a0563587e8b00b001439dcb0002mr27898737rwn.24.1697239468008;
        Fri, 13 Oct 2023 16:24:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z18-20020aa791d2000000b0068ff0a633fdsm14011847pfa.131.2023.10.13.16.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:24:26 -0700 (PDT)
Message-ID: <6529d1aa.a70a0220.c3534.8eb4@mx.google.com>
Date:   Fri, 13 Oct 2023 16:24:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-43-g508934b5d15ab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.6-rc2-43-g508934b5d15ab)
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

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.6-rc2-43-g508=
934b5d15ab)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-43-g508934b5d15ab/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-43-g508934b5d15ab
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      508934b5d15ab79fd5895cc2a6063bc9d95f6a55 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6529c51e85eaf29b70efcf14

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/6529c51e85=
eaf29b70efcf15
        failing since 360 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

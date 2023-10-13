Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E8A7C9150
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Oct 2023 01:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJMXYc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 19:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXYb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 19:24:31 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A56B7
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 16:24:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c737d61a00so22220355ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Oct 2023 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697239469; x=1697844269; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xBhEpWcgC7I4gAxJ6+sD+YMhIyoNADnB6IJvs/2hApo=;
        b=oEp8Ten/IF33mBdNtjW58zJt3QjySp7FJKQ048Wlw9gP2bVs4B3HMKof3eQ7BBPXRp
         xgpOGlI3TLMxc4OMf4X/i2R0t0bZ6wDi3OGXBGXY4xhKL9ak6KjorKIMEpJqZ3yKTY+I
         +kq0JEl0e/ZvH8yUXKRMM+dwOFDpRVR6vJc62g3NMyQRkMHT5ks/kskxt4OyhP6GzLRG
         YB4zlHfbFNLzeZ1LNRYJ3eZg/dwApDQkskR9nucsufBY3WuAfTPdt62SfbQPjFAs+4nb
         Sx38mX/XQqxuDAdWfDZxgpe2z5i8l0ietYVtKWbhCEXHkJvotMjYBCEHtLOguRJrvik/
         V0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697239469; x=1697844269;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBhEpWcgC7I4gAxJ6+sD+YMhIyoNADnB6IJvs/2hApo=;
        b=KEMtCOsg44/Uu80JrJrkl8t0pQ6e1/8/d8GoYyEhChWXophOcGCHQOJRGVpw7RVvq8
         q1U4oiKp0oCn+xmQkMsm0abJH/vvXMnUfD9u23zOI7coQdfAHy1F1q022TUyQZy6AWq0
         O3vPOsAo/0y6xkxXhzIjdFaDZgmjNmiRWxRKN20F4YSj4mX25fWn0wO5cXUOyzFW5hxE
         Rn2u2AhjmwYaxd9WCfdy/bCrvC5s3XtwnFxSqbX2bi/fLCOmIsUQ6g0afB44MFYvFlAo
         D8tODf+AEllrIaeyubF7RbMsGoo60LXN1cABdFFOrJl/1acvWIc+2DWh7PB0dXJBkxsn
         EdZQ==
X-Gm-Message-State: AOJu0Yxl3vKzfwoPzGlXip+D+INnWRJB5zTI7JsngupfeUyow3fzyvFp
        sGulZ/oS7txlYv39WkNLUjd4pg==
X-Google-Smtp-Source: AGHT+IFQ748KgMPSoGBEx2PX/q/9aCvKELlVXm9V+drv8YV4DuE9b6eISWZQ9GXcZbl2P0j+1du2EQ==
X-Received: by 2002:a17:903:234d:b0:1c9:ca45:f86 with SMTP id c13-20020a170903234d00b001c9ca450f86mr11600690plh.18.1697239469301;
        Fri, 13 Oct 2023 16:24:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001b9e9edbf43sm4374772plg.171.2023.10.13.16.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:24:26 -0700 (PDT)
Message-ID: <6529d1aa.170a0220.cba84.f44c@mx.google.com>
Date:   Fri, 13 Oct 2023 16:24:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc2-43-g508934b5d15ab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 2 regressions (v6.6-rc2-43-g508934b5d15ab)
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

kselftest/next kselftest-lkdtm: 3 runs, 2 regressions (v6.6-rc2-43-g508934b=
5d15ab)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.6=
-rc2-43-g508934b5d15ab/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.6-rc2-43-g508934b5d15ab
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      508934b5d15ab79fd5895cc2a6063bc9d95f6a55 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6529c538cf3108f307efceff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6529c538cf3108=
f307efcf00
        failing since 360 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6529c5395bc7365995efcef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.6-rc2-43-g50=
8934b5d15ab/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6529c5395bc736=
5995efcef9
        failing since 360 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

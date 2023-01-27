Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C562F67DCD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 05:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjA0Eae (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 23:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjA0Eac (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 23:30:32 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29947521C4
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 20:30:31 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso7441914pjj.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 20:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WZh+HXyS7Vh7gMdk82flkB78BUrxrJg1C45VYqnZqBg=;
        b=A/73UdrTlfspUfLjEMziZebTp8IbVuBwi16SkXkZ/qsr3Ex+NI34fQpHAdJBqFsfzG
         tv3YLTYwczpUE1tTZeizYGtPtrdKHQSnoo2cyt/DAnnkT2uucEQ4MMA3FjTY/uSc1wC+
         /+St8Bt9OQghdD5tpGSnB6GIL/LFLVCK+9yoH0tCMAkl0deUVzgCfz1b0GnghaatsmZt
         pbomDqfKdKg+ZVTpaD8gMpnZQjXgzYIWoxf9RAyaPgIZEdBCX0t5KcOO8k/go470B1rZ
         JujU8Gm7YpSqRRM+3tgoCmthYILAFZVbN6TyDDleWzWGYMcW5AAhiUfVVNnRqjolAWo0
         i6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZh+HXyS7Vh7gMdk82flkB78BUrxrJg1C45VYqnZqBg=;
        b=aWQ1Bt/fqcviB01gPmP+zJEHgKLk4XPqejH4FoEWYn4HDqKfIRFglP6WErSUMRTFjh
         120UETTtmg8SDkV9XMjp65KtBhjnIbRcPVpyeIsZjIZpPWjt3VztOMBbTNeyT4OeStYj
         GiYJpFrGTr2ofCxqBBo39AN+oOgYAfspWXIKdtZELZTRsMNhIdxKr9yyIBHBPtzlQvUQ
         mhZeg43lJx2BTgGzuSovybS1OKTyx5eiZsgH3H7xOJtfDNwsiqZt3om/wwgHcUh6bcBW
         wTdY8FuineU5Y/oQvvqYjI7Ywn6qh0UjrYvhvikp0UybeSf9EGqQdpBqtsGJWmrS4Gf3
         O7kw==
X-Gm-Message-State: AFqh2krlkOrHuuP/aLyusOVSm+UwQo1HqAAit7eyrdTeuOF1O2kE0ACR
        VR1tqUWDFUl+c/g6DksD23TYBJnX090Hef0kn6M=
X-Google-Smtp-Source: AMrXdXs50CcCN2jjnUDR08YR1oBm/eP8NPbkRFITdi8tRewjIOK3kG65vuQCoy+t3K9Ki9ZnI1+Iaw==
X-Received: by 2002:a05:6a20:b71b:b0:b8:965a:ccb5 with SMTP id fg27-20020a056a20b71b00b000b8965accb5mr35561180pzb.24.1674793830595;
        Thu, 26 Jan 2023 20:30:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o20-20020a170902779400b001926bff074fsm1736839pll.276.2023.01.26.20.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 20:30:30 -0800 (PST)
Message-ID: <63d35366.170a0220.86ee3.3551@mx.google.com>
Date:   Thu, 26 Jan 2023 20:30:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.2-rc5-1-g65177e47d303
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 2 runs,
 2 regressions (v6.2-rc5-1-g65177e47d303)
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

kselftest/next kselftest-livepatch: 2 runs, 2 regressions (v6.2-rc5-1-g6517=
7e47d303)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-1-g65177e47d303/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-1-g65177e47d303
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      65177e47d3035c083cff034ffbfc7ab750a4675c =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63d341003633451d0e915ed1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ivepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ivepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63d3410036=
33451d0e915ed2
        failing since 31 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first =
fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d345b82c5b5dac17915ec1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-1-g651=
77e47d303/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230120.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/63d345b82c=
5b5dac17915ec2
        failing since 101 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

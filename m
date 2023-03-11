Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5427A6B582F
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 05:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjCKEhl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 23:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCKEhj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 23:37:39 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD7511FF80
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 20:37:37 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so9128635pjn.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 20:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678509457;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=62VdyOuWs9TE7tj2Lu2O2vRidTt0UKyjKaWj9sHkoWc=;
        b=vb2MFz3Haj2zPH0qRMHCrXJEU1KLmkzXK8vDVnh85JOry/IOoR/CZiwomWDGBS4z6I
         Q6JXl/tShAbf2dqjssXtzw7cVy0zyw+6j752Tw7WXLvklezA1K8dJN9nruuZys//VPKs
         Q2jKK5YjrgJtlwsYtKKjmlScfaimvsJIPKSRPuC8Mh/0/uY+mw7ax4IEERQwPe0FvgU6
         TA3tttlog1E3m+OfYzmYDkOR68/W6Nt6+7BgYXc6qWYUrmbfqFo0ZsVWBDA4tmY+gXD5
         qRVDiyX/OH0RMDfO0P2i8LZmO+EgpGyLxtWI768Jq45kdeYWlOa0RiIhOh41zi+dyZRu
         nuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678509457;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62VdyOuWs9TE7tj2Lu2O2vRidTt0UKyjKaWj9sHkoWc=;
        b=SCFao+UoztLqWyXRsAhq4/Sdnj+FZZC7eOOfj7Nv9EQpTWC53u1Oe7MQsnFYn2k9K3
         7S8z6gWVGxQU7SbuohOe+1iJM5WjdK9jwIW9QKsZIigzbKDPanOSBJgqDfJwwPwg0lBP
         DUQsokEt6P3/dpyt/epULUcRe7T/RX07yOO0hVvsprwXNEd/f7dL8WOELsAAC++OXx5B
         WuCj10Uj/HuXHaHbaDGWNHKVWQ2IGpnAM1+v++7qLYBjxrbd4qF1BkzTi5b/3c17v6EJ
         Dj4iAlpgKJfRKD/bWrWCOgg2PdeWuRWKHL+ghGgiN6VUNpQOhb19CMyMxoFGwP6oa7CD
         nWCg==
X-Gm-Message-State: AO0yUKWK0IFPFE4LtkPEhFySs1W65Bsc+SbNVSzt1enkDhmIHjt44UeA
        CzGnBCTccwU5HKPzu9PiuNMNmQ==
X-Google-Smtp-Source: AK7set/q26ekZhfNh8dlUq9cPtAgGY+1N78HGxP1IbFjV2I0OaA7+uqVp42zw7R8XNzdRU5WUx3Cdg==
X-Received: by 2002:a05:6a20:b721:b0:c7:34af:65ac with SMTP id fg33-20020a056a20b72100b000c734af65acmr24911058pzb.14.1678509457378;
        Fri, 10 Mar 2023 20:37:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005a817f72c21sm570380pfn.131.2023.03.10.20.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 20:37:36 -0800 (PST)
Message-ID: <640c0590.620a0220.f62e1.1c6c@mx.google.com>
Date:   Fri, 10 Mar 2023 20:37:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-2-g624c60f326c6e
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-livepatch: 3 runs,
 2 regressions (v6.3-rc1-2-g624c60f326c6e)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/fixes kselftest-livepatch: 3 runs, 2 regressions (v6.3-rc1-2-g624=
c60f326c6e)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
3-rc1-2-g624c60f326c6e/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.3-rc1-2-g624c60f326c6e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      624c60f326c6e5a80b008e8a5c7feffe8c27dc72 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/640bf52e4fd157f3868c8681

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/640bf52e4f=
d157f3868c8682
        failing since 74 days (last pass: linux-kselftest-fixes-6.1-rc3-3-g=
89c1017aac67, first fail: v6.2-rc1) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640bf8a1a7c3180a468c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-livepatch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.3-rc1-2-g62=
4c60f326c6e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-livepatch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/640bf8a1a7=
c3180a468c8631
        failing since 142 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

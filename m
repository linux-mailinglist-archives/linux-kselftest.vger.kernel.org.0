Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CF617C52
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 13:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKCMR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 08:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiKCMR1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 08:17:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E8663E3
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 05:17:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u6so1707704plq.12
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uGqF0B8cqX2vnz1fzr1ei5+YEhJvnLws2t2Bo4y9I4E=;
        b=LW1rbESEpnfW+IFHcMoXW82g605fRfiLoY6rDSAi7N2DuVZT4ktKvj/9tgtVkZ6/o/
         KvuUyi7iZe7BiUZQMpIFCXysP08iM+QOyBePbgK855lAhpZGiJihEhpI5XlHFvdXVGJb
         +x+vD5s5PYauXJK3t8XjHNdIPCgKVqw/BOECRZe2EeTrb7ZWgxYnOlDA2IxGcjN3kXFn
         4qfu5qt4+tIAeQEAMJH3gYXw42wzsMeMpBRkTU56zmjKbYaI8Nwx/WFD8TD1Kdz6Hmk2
         Vj/P2uuTZXHOazJ8QhDnXF0IAXDbZza/mWBxBw2kOWJBcblUGEqvwWuZNvnFOSisYrR3
         1ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGqF0B8cqX2vnz1fzr1ei5+YEhJvnLws2t2Bo4y9I4E=;
        b=luGfUY6i1s/sNNQwqy4adR9URm7hTGXkM84YcbtJ5ClWz1cPpZm/Uq1oNWmj0REzD9
         cIWFc2nRf7Ko+bpbVc7vvcDj3Wc4Z/a00QwW5+AbdLsmV5TgkjdOSiB7EPp8SUmrA2yh
         8aG+/DAR100PRQBsNXY0yZJrSPrTTthw1uazr4gQSI4sjPgg378/OMm929/HgKMaZJix
         YIMcBMAgRc9uTKF6kuXbzzKOetgwYdyQVapOojN7ZTGkDZVOhUodL86S2IetvijPaxNp
         EtYmivMrGFp0iTKCkRamHlOlfPeJMqoyAQ2L/kehJLbyVBPP8eigDXSS89pVrDcoN3eE
         19Nw==
X-Gm-Message-State: ACrzQf3Tz7/qC8Al6KT/nt8keoXN1P4mDorqikYQBFbQY50CS6ZSFJ0o
        40EobB5i9WIY+hnlbSEeejMy3Q==
X-Google-Smtp-Source: AMsMyM6NZF/kYriY4n9TaOqMQh+V9T9l4XP93uOVZ/04Zh2oGXZ0Pn1B6/CC+z3m5u1vG6qoeyceog==
X-Received: by 2002:a17:902:d48e:b0:188:56f3:d381 with SMTP id c14-20020a170902d48e00b0018856f3d381mr2139187plg.158.1667477844816;
        Thu, 03 Nov 2022 05:17:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k21-20020aa79735000000b0056b1ecef957sm646672pfg.37.2022.11.03.05.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:17:24 -0700 (PDT)
Message-ID: <6363b154.a70a0220.4f147.0ead@mx.google.com>
Date:   Thu, 03 Nov 2022 05:17:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-14-gd942f231afc0
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 1 runs,
 1 regressions (v6.1-rc1-14-gd942f231afc0)
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

kselftest/next kselftest-cpufreq: 1 runs, 1 regressions (v6.1-rc1-14-gd942f=
231afc0)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
-rc1-14-gd942f231afc0/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.1-rc1-14-gd942f231afc0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d942f231afc037490538cea67bb0c667e6d12214 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | clang-15 | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6363a18837e742c598e7db54

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    clang-15 (Debian clang version 15.0.4-++20221026063345+db687=
23804fd-1~exp1~20221026063423.87)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.1-rc1-14-gd9=
42f231afc0/arm64/defconfig+kselftest+arm64-chromebook/clang-15/lab-collabor=
a/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/6363a18837e7=
42c598e7db55
        failing since 16 days (last pass: linux-kselftest-next-6.0-rc2-11-g=
144eeb2fc761, first fail: v6.1-rc1) =

 =20

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F04072A5BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 23:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjFIV6G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 17:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjFIV6F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 17:58:05 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B374830E5
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 14:58:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-65055aa4ed7so1924149b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686347884; x=1688939884;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FMYTaOrvyK4IKlpZaQm4RyHVobJIZoIpcI5YsrYG4oI=;
        b=cHLB305nUzmrhA8b9w3yxhktB9mDTp27maEbfNkjQVtq61B/gAzVYWaYzMHHeNlyRl
         CQHcpudi1mhi5JtpQooaPJqE7KtLNrRhjdsZRsobSpWWWUosQjzPBFXbmk7B36OqgZWi
         jI97v35b03jmEx/vvIX8xGyn6brj6Gv/gpHN4dbp8fFhqJQDH8gAo5G+26Qkq4ftoUF1
         +MqBidRmEaZR0YskB2t5zee4/RtrR+vfNz+vXvXBobOw/5Hy4Q+TKFt57bKjyEfJbjvc
         cjdDUdONA+TvIXqTKJ6p11lsdqdsZu0LDzl2d3XuaBsCDbT3aqZcvRS7Y7XiN5iRObL4
         IYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347884; x=1688939884;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMYTaOrvyK4IKlpZaQm4RyHVobJIZoIpcI5YsrYG4oI=;
        b=POEHPY76N9WTJWoEvH1Ek2A5gWDG5WkTpN8nKwNOHfH0TOPd9rCuV2QIVXFjpmHOKc
         Q9pi2EAv471tNnXISQSYU0YBDC1Ce2imneW4QeDt1lmuK9vmceea/vZ5TFvhWF70V73q
         k6fnv3dpeGhMhnQOPttJPubmxAtotwTg8aTzFHOiURbFetqyFj6dl9CJ3KnNqDmZRQXU
         RDTiEKBboj1lWYdGa/hN9UtQaOno6SD4Wqoqbhl8/VjIc88H7vZs39NyBau31/LtdQDe
         0cTid7v1H7FX0FWxavkGk4up9eoLbrMwV32zIZxI1th4QmPJeUh+wD+E9/q+UTbkPjKZ
         pYTA==
X-Gm-Message-State: AC+VfDz7zX4FzKEFGgBNUcZu14oXUf6oZc0apLB2M6kmFr1HZASZNV1W
        Lwru1aSRYY9yvTnOX/A1I+5JycfdaMKix6TeCMJexw==
X-Google-Smtp-Source: ACHHUZ6qOLFd+lY2Kf/BjqixRgpWF2IVQeiJke/4ZvuVnK6fAadoNX+yyXd0B1u5XgMf1xZ31Duiwg==
X-Received: by 2002:a05:6a20:9191:b0:ef:205f:8184 with SMTP id v17-20020a056a20919100b000ef205f8184mr2624154pzd.13.1686347884284;
        Fri, 09 Jun 2023 14:58:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a10-20020aa780ca000000b006579b062d5dsm3091874pfn.21.2023.06.09.14.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:58:01 -0700 (PDT)
Message-ID: <6483a069.a70a0220.61509.6b5b@mx.google.com>
Date:   Fri, 09 Jun 2023 14:58:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.4-rc1-9-gd51a218328e0
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.4-rc1-9-gd51a218328e0)
To:     kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.4-rc1-9-gd51a=
218328e0)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-9-gd51a218328e0/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.4-rc1-9-gd51a218328e0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      d51a218328e0be533ca0b10bc29060aaec70432d =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64838fede577c4f3aa306156

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-gd51=
a218328e0/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ivepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-gd51=
a218328e0/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
ivepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/64838fede5=
77c4f3aa306157
        failing since 164 days (last pass: v6.1-rc1-24-gd5ba85d6d8be, first=
 fail: v6.2-rc1) =

 =20

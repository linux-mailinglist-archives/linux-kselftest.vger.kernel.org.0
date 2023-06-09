Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A8372A5BA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 23:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjFIV6E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 17:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjFIV6D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 17:58:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD7A30E5
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 14:58:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-650bacd6250so1956443b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686347882; x=1688939882;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O2ixkit6nWzfZA+hDhbI4VaADPhZZEks1vmpjt6FW2I=;
        b=bNX7wxlTsVlLMP3le5PGCkU3IzWIfOIwODpRkMQ7iyzfa9KnjovPFkOVONkLxkp87F
         /7r3wf6sr4fUC6kjvEPNLeSYUPPYPY5hbeWL8cFC5A5Vx4EInwwy0SdcKSPew7DUr3ZY
         D0pDyQHEbnjQ6mCs+V1pZBSxd9cRzWg+fqReeGYjGN/hQAD+F76MPb23LnypnRPTDLFJ
         qQxBWnZYy3SMfdCOXX1N8cSLUq7Rn5E6doVJc+Njhgc5EXn6ksCpp5/EJ6uYMr2UUfMF
         /UGCCkTpIq+JAcKYN2I41JzU/dZwWAF+/Xmy+Ti4A4NruOennZV22Ta6UusEtoLdKNV+
         QI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347882; x=1688939882;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2ixkit6nWzfZA+hDhbI4VaADPhZZEks1vmpjt6FW2I=;
        b=Na1blRec7Y24kc1OQIj0zTNwcLp+fZPb2cDOKK8kjLqxq6EjE0xMgUARGg6AcDPzta
         tk4ABKCalw/JkaC1OJprTbMI9qemUTdZhJbVb3DRHtij+oy3w/zZfr4o89+Q96nMaUVq
         ShbN3NtcpDEaM58PbIhAmislsckCjam/DTqOt+c9PF977cOOet3OTWzispP2kDbhOcrY
         mfJsQZpP+PduTG0A/KhPaAcq5dG2vI5eD32q4Ndr+c1v3gQLFQujIz2CnfDn2QcCSfc2
         fbQXvknpYNWopvtxUji4i+k66qMSvmZ4RoAT2GR3pbYp6Y7qUtgiMuDqw/fOsygc+ILd
         /Scg==
X-Gm-Message-State: AC+VfDwLj8ugKEDUfV+8sUMwAEf8XPXiiX1ZRUzFS4xo686h6B5QyHx2
        Qm2KmrKC0cXmb9FtER/5JDNAug==
X-Google-Smtp-Source: ACHHUZ43vB40/Su5ZXKJcntMi+L6biPs/uKRwGeQpz70IFp+NjhiMb3cA1Fpz43IejDl/1CDDoCWAQ==
X-Received: by 2002:a05:6a21:30cb:b0:105:27c3:1bfc with SMTP id yf11-20020a056a2130cb00b0010527c31bfcmr1706644pzb.51.1686347881937;
        Fri, 09 Jun 2023 14:58:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s18-20020aa78d52000000b00653dc27acadsm3029444pfe.205.2023.06.09.14.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:58:01 -0700 (PDT)
Message-ID: <6483a069.a70a0220.9b3b2.6f44@mx.google.com>
Date:   Fri, 09 Jun 2023 14:58:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.4-rc1-9-gd51a218328e0
Subject: kselftest/next kselftest-lkdtm: 1 runs,
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

kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.4-rc1-9-gd51a2183=
28e0)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.4=
-rc1-9-gd51a218328e0/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
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


  Details:     https://kernelci.org/test/plan/id/64838fe98572ae36ab30616b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-gd51=
a218328e0/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.4-rc1-9-gd51=
a218328e0/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-l=
kdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/64838fe98572ae=
36ab30616c
        failing since 191 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =20

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21DE5295CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 02:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350588AbiEQAGR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 20:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiEQAGM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 20:06:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E24E63BB
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 17:06:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h24so10232491pgh.12
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 17:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Vd2cVMJJOvRbSj9x6tCpjNWzpDnWObSOglnkX92j4vs=;
        b=yoxsmBoL6y0mxnT13d7NIHKjo5I0u7cz83cvPDiMIFiqPXXHJeN+s8kcmcxGWtlVPA
         EtS3BT8H6Ug7BTKe35jpELj6jQ1umMTExzEodRGiJDX0EwTdd+gWdlh5reUZ8S3ngIx8
         XSWoSuC2nLQVPjLfBaKdJ1PIX6HQTTXpVDIm/8PbMz/NQ5IQcW1j7SYECfeC+nvEsyHs
         Lq5E2IovduFJ676ZuaNdGr2ufBt7tjcFFu4IzWEQtmVsEMIkq53VGASk7iQ+R5xwDifp
         GYtKOCZOkKA4bmIp/6tsAmaMPq63n+CA9izOn7JGSz06qdzgHmSIrESED0P/7Ta+GUCK
         7ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Vd2cVMJJOvRbSj9x6tCpjNWzpDnWObSOglnkX92j4vs=;
        b=7jD3k8RjdhuBEWV+x96oOICtK3otjmY2L6OHZcw2400YPSkeVpMosbEa2TNbeEaY/H
         tuuMjegUy+9TbThQaO7lA9LplWQrldnE+4DnWwAKzVN+nCwNY+oZzxRulhif400zJSd5
         aIRmwRJjBAzphFf4cE39Y5gP3cuv4OjzkL9LjZxKVGxFyr9GGbPvIgWR3DsQGSiKuxxH
         pDFhIsqybqx6aiD1Jhz8SDBj/ysn3f0dgviFCAKR0W61JvOTsUkmnKlah4vmIVPbXDUL
         NCvctXoZ3TOS52PnK1lv0vRnIzA87TnRmjviEg2sABye7txIUCHvKkPA/qjC5Ajo9rei
         R6IQ==
X-Gm-Message-State: AOAM533KM2l3ZoMlwAVgJ2U+CMuMQSZyYR3gtnbMPXsM82COin9gURA/
        hyEZwpUkHJVNo6cpkapBQHZNNA==
X-Google-Smtp-Source: ABdhPJxA9lMySrYm2xEVomN/lyziM29nIRjYLCvE3BT/H0VL2IVusj+x1hNVRfD0paH2/49mq265zg==
X-Received: by 2002:a63:7e11:0:b0:3c6:84e3:9c59 with SMTP id z17-20020a637e11000000b003c684e39c59mr16958296pgc.615.1652745970806;
        Mon, 16 May 2022 17:06:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w16-20020a634910000000b003f27adead72sm1919238pga.90.2022.05.16.17.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:06:10 -0700 (PDT)
Message-ID: <6282e6f2.1c69fb81.3ec04.500c@mx.google.com>
Date:   Mon, 16 May 2022 17:06:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v5.18-rc3-19-g15477b31db104
Subject: kselftest/next kselftest-lkdtm: 5 runs,
 1 regressions (v5.18-rc3-19-g15477b31db104)
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

kselftest/next kselftest-lkdtm: 5 runs, 1 regressions (v5.18-rc3-19-g15477b=
31db104)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v5.1=
8-rc3-19-g15477b31db104/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v5.18-rc3-19-g15477b31db104
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      15477b31db104bc795dd1acccb3e9b89465fff01 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6282d757748f68d69e8f5720

  Results:     56 PASS, 8 FAIL, 26 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v5.18-rc3-19-g1=
5477b31db104/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabor=
a/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v5.18-rc3-19-g1=
5477b31db104/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabor=
a/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_READ_AFTER_FREE_sh: https://kernelci.org/test/cas=
e/id/6282d757748f68d69e8f575c
        failing since 41 days (last pass: v5.17-rc5-22-gf6d344cd5fa6, first=
 fail: v5.18-rc1) =

 =20

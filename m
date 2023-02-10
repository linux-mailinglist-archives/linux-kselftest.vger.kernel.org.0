Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE33469170F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 04:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBJDQ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 22:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBJDQ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 22:16:58 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD61166D2
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Feb 2023 19:16:55 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a5so2649060pfv.10
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Feb 2023 19:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W0tMyQ8yY87rKvG43UVPz+2bQjxgg4FEC4lPblgKYrY=;
        b=kWWBkMfU1OVMxb9sYztfwBgPND441BXF19pTdqGVYHGednNoTVpbpp0fY55hl4P+v2
         HemQk8HUazFyHG4YtEzq3g7XrKmoYt+gqhPQFmMQv9XTw/FpmJojDmhz9isSqVSUKKAd
         EOLcEzWuc18SNmuf1aK+/3O0LPAh/V5OJ42TOMIb0vOPegNI4CnhAGvEBTKYLd8YGvuH
         Rw1d7n0nlabxhIixiIcB+hkIk0M8TVcnPbbKCDAnGWjTk1/wRSxdc2PJBBluvOyGB/xU
         TR8nwc4z7g6sqTHTXuatb4DayQmJ4o+Z+KLleZjzSk2MGHUssgIbOSh5sRNJLykCd0Kt
         6YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0tMyQ8yY87rKvG43UVPz+2bQjxgg4FEC4lPblgKYrY=;
        b=nWZKIlmEO2Bnona7tuMy+8NX+YGrYI0JnnKpmhClxPpcy45mvWEp052h0dtJEGuSse
         vZyTHTfOpxSFMqhnuKt57xN2Jjh6WW54oHKrrqxv6Bo6O3r/fwVDxWrddSepcXUFd7+e
         t9lNsyk1a7wJPySIrHNhGe25BMpo94+hxYM1jJdpgeUFegDri3TbSCM2cQSakg5EbpLV
         fbMdE4fCnq22KB6F3X2LqyEMcEYvXEbuO2R60Fs77n7B87N8QtZaYRjTGYES1TqN95d+
         JPN3W7A8TXVxmqbATw+9TWOQvEAdK9suMXtm9uoECL1nYcg+FLOIC7DTpYnGV+uPJ9D0
         u6rA==
X-Gm-Message-State: AO0yUKVXe0sfUkaigNKNRl6Y5D+GdXtu7mWFU3TAZWX6mxRUkJ/4RKBn
        PKTvkoAIKDAVsuO+ZmMrl1dSdzT35BbCH7uKukk=
X-Google-Smtp-Source: AK7set+HmXVD6mhQ8iHg9E4yNFAksKftMgu+/4He7hyf/dzWdnaQBl09xdyW5TJTBUP2oS/WRizL5w==
X-Received: by 2002:aa7:9419:0:b0:596:15de:ea1e with SMTP id x25-20020aa79419000000b0059615deea1emr9966649pfo.9.1675999014721;
        Thu, 09 Feb 2023 19:16:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 8-20020aa79108000000b005a84de20c24sm2117371pfh.209.2023.02.09.19.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 19:16:54 -0800 (PST)
Message-ID: <63e5b726.a70a0220.f986.442c@mx.google.com>
Date:   Thu, 09 Feb 2023 19:16:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.2-rc5-36-g4c853ca1cf79
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 2 runs,
 1 regressions (v6.2-rc5-36-g4c853ca1cf79)
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

kselftest/next kselftest-cpufreq: 2 runs, 1 regressions (v6.2-rc5-36-g4c853=
ca1cf79)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.2=
-rc5-36-g4c853ca1cf79/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.2-rc5-36-g4c853ca1cf79
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4c853ca1cf798f1d74a7bd9e3a0541a3ae8ae77e =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e5a62d52fa8226d58c8658

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.2-rc5-36-g4c=
853ca1cf79/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/63e5a62d52fa=
8226d58c8659
        failing since 115 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

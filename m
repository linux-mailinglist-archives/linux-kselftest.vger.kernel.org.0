Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA66AF174
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 19:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjCGSoT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 13:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjCGSnu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 13:43:50 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0EEAF6AC
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 10:33:57 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id ky4so15129974plb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 10:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678213965;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7nSW2bIEn/YH0CU0N36uXcKpQuGPDeUNwGojRrSBHl0=;
        b=pAy3yAcKHVEvrxLB2Dt87nUMh/9BRoRk+UwOXKdX8Q6sSHOTKGGrHoCgOzZ1H6DRTb
         wSdQI9tLiMg4SuSP11eORtI8r7CYah/QGH6NIIKCwa/JaQFH2SOwRO80zXeT+vuFucVP
         rGGVKSD6+boCsMwaoSv6OeWmQ7JD7TLqb3eBzrI3AbuQzjxNpNES0iuOZ601UK99YyQg
         MGYwdi/DTkLbXpW+QPEwaeRliV+5O2w4YdB2uV743lyBMtOsF4cCa4wzLRybyRFOGVan
         Wh53+f8TsPbwaeGo+g/D8nG8W8oCloPcOzv8Sa9hIFks5O5zWtXZpjsLqn3KWzh0BlZY
         +4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213965;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nSW2bIEn/YH0CU0N36uXcKpQuGPDeUNwGojRrSBHl0=;
        b=3jvX9qHKZ1jaujIQQuwKLEox4fg8vUSKK3Izii9xOV0uzkqJq0dgad4uaTr5+6xvdo
         SfMugQsZLNDkBc2Y4VR6d0llUWTE6kEOQ0Y8gVRdunXHcG1NPxN9MsvwimDqaNTM3G1c
         pfX/HesW2SrzVhfE3/EbHTuWqPMoVMELla7idb/ph9NJdGVwMkvS28t78qYjxkEoXXkK
         Z3bRKl0eicY8Vhy2pf9uPwAJSqrY7srtltGQUhZPI618IEDVSJxLLaiBk+n6KN5fBN6q
         OnVdHVysQXK/47/nqFDFAPtgNhXuqLT/3xZhRCnybZppYeC2F5IBG33gYkiEW/cTx+YI
         9U/A==
X-Gm-Message-State: AO0yUKUxdNJEgP+fqxNBSLhd9oQcrOLzmHspFFU+JG2LDqwbcxDlxIHp
        Brlw7f2dXYJ6AByMcCxz0bm6ZmGpvOpom9VdSaUL8DxP
X-Google-Smtp-Source: AK7set+Gfq4O7MAYS+dtiW124J3NonyyBQigve0G+3uyUO1C+mZjHap/yUT3nigup9JgHzGnBltjIQ==
X-Received: by 2002:a05:6a21:6da5:b0:cc:46bd:39b0 with SMTP id wl37-20020a056a216da500b000cc46bd39b0mr16338000pzb.56.1678213965302;
        Tue, 07 Mar 2023 10:32:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g14-20020a62e30e000000b005aa80fe8be7sm8232655pfh.67.2023.03.07.10.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:32:45 -0800 (PST)
Message-ID: <6407834d.620a0220.afc92.f666@mx.google.com>
Date:   Tue, 07 Mar 2023 10:32:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.3-rc1-1-ge1e17d7debf4
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 4 runs,
 1 regressions (v6.3-rc1-1-ge1e17d7debf4)
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

kselftest/next kselftest-cpufreq: 4 runs, 1 regressions (v6.3-rc1-1-ge1e17d=
7debf4)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.3=
-rc1-1-ge1e17d7debf4/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.3-rc1-1-ge1e17d7debf4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      e1e17d7debf486fd3b757df9e009b8d109e4be43 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640779de3413ee27728c8648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.3-rc1-1-ge1e=
17d7debf4/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/k=
selftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/640779de3413=
ee27728c8649
        failing since 140 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

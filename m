Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170337029CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 11:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbjEOJ7X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 05:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbjEOJ7T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 05:59:19 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4D136
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 02:59:14 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-77d46c7dd10so57237379241.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684144754; x=1686736754;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dkgDMUFKoJHfejJzBAn4bFUw4F0nEh6FJxDMkvZCPFA=;
        b=V+Xvqp779ny2MsbmlIzw0OFrDjfs98TdIh+4XNR6CXe3+QJerVBMmM9b3g0pmNWKx0
         0nXB8ienT+3A81SEtMTqehCNEG+f1Hjxp1PH7ji3EY4GIeflwUJhqDf0hFH8aganqKex
         ngBBCQHJlSyvuyScA2a96peBUnij08ALJyR4W4WQK0Brm9f1+HQajBpuocaoWLApm0JR
         JctNF3hCrLdKqRCSrZOYnBtcIgYr9pCXxPwAC542uvOx4DI6jnTNy1PWByN67/BqzNQ3
         3X18zXr4j5ieLhaC85D/ahDZWzSAskZ0SiIIIaxuVhbj1A2rp7ob186xG7Zz1Z0llTDC
         8NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684144754; x=1686736754;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkgDMUFKoJHfejJzBAn4bFUw4F0nEh6FJxDMkvZCPFA=;
        b=SKbXRMN6g2vGSmlmhk4ydj6Unh0pc/7TZSfdNGM6gn2tvq/2aOmnFNRHhmCj1HDqWl
         x15371EOslaj2IAKF4gZ0/S+InugzHpk8gggXResaoe/ZdJdCxLkcO+eSKSurx4UKrR/
         hTnbNJyQdrzSFMxqIh0MS9E3daAqAtAbZ4Wx8OvZzvGMGeVp1/XVViWs0oiaNiMxAgID
         4gHpnxBYB2A+BXzuuk9tnBK2HcntD0aEPRbUHNUllhMG3YfmouuIDy2yzgHFN/e87rHh
         vIQM35E1fH5GS/rGikB/Z3RyS8lGdGdex4FcmBf+i1sR17ZBsLTfw0k24K2LQsIR61LJ
         U3Mw==
X-Gm-Message-State: AC+VfDwBdIy6WBDEJo0ZxbmDW83qczaWoHrBLDoJdrk1BNkd5yZBIBPL
        b8mNYFMeH8GkfubRoAQ93rywpWZTxV4th4FEtyT7/g==
X-Google-Smtp-Source: ACHHUZ5czZmpY3AQl04UbpcvPd0ySjdIS54jYs4VwPUYgvxWfc2h/VO2G8HK+SHK+QtrSclhacnC8fKI+PaRfRCzbQQ=
X-Received: by 2002:a1f:5c90:0:b0:440:4946:fac with SMTP id
 q138-20020a1f5c90000000b0044049460facmr11965983vkb.4.1684144753365; Mon, 15
 May 2023 02:59:13 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 15 May 2023 15:29:02 +0530
Message-ID: <CA+G9fYuoB8Ug8PcTU-YGmemL7_eeEksXFihvxWF6OikD7sK7pA@mail.gmail.com>
Subject: selftests: mincore: mincore_selftest fails only on qemu-armv7
To:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The selftests: mincore: mincore_selftest fails only on qemu-armv7 running
Linux next, mainline and stable branches.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

# selftests: mincore: mincore_selftest
# TAP version 13
# 1..5
# # Starting 5 tests from 1 test cases.
# #  RUN           global.basic_interface ...
# #            OK  global.basic_interface
# ok 1 global.basic_interface
# #  RUN           global.check_anonymous_locked_pages ...
# #            OK  global.check_anonymous_locked_pages
# ok 2 global.check_anonymous_locked_pages
# #  RUN           global.check_huge_pages ...
# # mincore_selftest.c:156:check_huge_pages:mmap error: Invalid argument
# # mincore_selftest.c:159:check_huge_pages:Expected 0 (0) == retval (-1)
# # check_huge_pages: Test terminated by assertion
# #          FAIL  global.check_huge_pages
# not ok 3 global.check_huge_pages
# #  RUN           global.check_file_mmap ...
# #            OK  global.check_file_mmap
# ok 4 global.check_file_mmap
# #  RUN           global.check_tmpfs_mmap ...
# #            OK  global.check_tmpfs_mmap
# ok 5 global.check_tmpfs_mmap
# # FAILED: 4 / 5 tests passed.
# # Totals: pass:4 fail:1 xfail:0 xpass:0 skip:0 error:0

logs:
https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2PnaQ12zfS0p4KS5pP37ZIHJR0U

History:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-rc2/testrun/16947285/suite/kselftest-mincore/test/mincore_mincore_selftest/history/


Steps to reproduce:
----------------
# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.42.0
#
# See https://tuxrun.org/ for complete documentation.

tuxrun   \
 --runtime podman   \
 --device qemu-armv7   \
 --boot-args rw   \
 --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2PnaP3qqppMDr51qUdKv971IZrE/zImage
  \
 --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2PnaP3qqppMDr51qUdKv971IZrE/modules.tar.xz
  \
 --rootfs https://storage.tuxboot.com/debian/bookworm/armhf/rootfs.ext4.xz   \
 --parameters SKIPFILE=skipfile-lkft.yaml   \
 --parameters KSELFTEST=https://storage.tuxsuite.com/public/linaro/lkft/builds/2PnaP3qqppMDr51qUdKv971IZrE/kselftest.tar.xz
  \
 --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f   \
 --tests kselftest-mincore   \
 --timeouts boot=30


--
Linaro LKFT
https://lkft.linaro.org

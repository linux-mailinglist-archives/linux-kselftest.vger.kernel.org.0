Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C0C3C80C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jul 2021 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbhGNI7A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jul 2021 04:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbhGNI66 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jul 2021 04:58:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D22C06175F;
        Wed, 14 Jul 2021 01:56:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a18so2335207lfs.10;
        Wed, 14 Jul 2021 01:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8Vx+BB0NWwYoN1KcParFH+Gpc5QD5LN7UUlbl1lSPJo=;
        b=owC/sHRDvmMulhPFKuXa35tdAWl/Ge7OoTGG3fnAvVkHhDvcBQXcrkLlniRv+t3J6g
         Aw3pW5XofOxn/HpPSUXHGG85gI9PsTkbcfls+Ht59F6iFixImvOTSPIwXY3bIPNpf9dB
         ACGeWo5zeIjDd4uyIgCIUFvI+p9AUf7R7AghmI2Uq73YtABz/L2QaseyKM6oE256GUrW
         U59Q/865G/N2t8LU39T60cUj9LmzmDKlKaLutAJUvTrLNJO8ZwJNCUsD5h/ggcqgCeI6
         OrJgNihPwKVyOiY7oQRv1poeAU3/qHdjm07sobOljJF66kY3uuFM0c0JRpWx8A40scou
         Ijjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8Vx+BB0NWwYoN1KcParFH+Gpc5QD5LN7UUlbl1lSPJo=;
        b=Ism63kXMl/SXM5E5lgSzn1a2Bky6HPyI/88jLl7n4vINufVYZ1dlrp0Fh5bKaM5/wK
         IpzzTPNBYfNGwC01cJOdpjN//+8uIlU7JMLuYfWs3vXvP1ym32uXNaF0r/OsWOJiP62H
         CNYlb8QrYcuMK7aH/igNoXSw+JdI1/OPI3Qz0Mlw6JteeN9mFiZdTQfIbMj3gbJKsA85
         +sir42E/piss3HhDqTK37Gc36+hp7bGmekSbjeOD3xqLdNxLkzUP5JL1FOcf9vra66aT
         08e2VG6QNFkEX3oYrr65CQyz0wFebSBfevonM1aQqj0GCF7tQFppTzOmJDl4SlPzvPS0
         J8Aw==
X-Gm-Message-State: AOAM5337MSk9lFsql8ZZG8G/7faHxYrTUxdRXh2zpm66eXMSfHslEJGf
        dVXpcO6oReOkUV9Tw0+gd/VzIhZh79VNKA==
X-Google-Smtp-Source: ABdhPJymjYuj17yZZhtahpciUm33eTLsIBixRsdbh8a4rdoKnEp+rBQwsycXFMDrwYa9PF/LsPGBjA==
X-Received: by 2002:a05:6512:c12:: with SMTP id z18mr7537642lfu.230.1626252964999;
        Wed, 14 Jul 2021 01:56:04 -0700 (PDT)
Received: from asus ([93.95.240.58])
        by smtp.gmail.com with ESMTPSA id v10sm165598ljp.20.2021.07.14.01.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 01:56:04 -0700 (PDT)
Date:   Wed, 14 Jul 2021 14:56:01 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com
Subject: [PATCH v2 0/4] add KSM selftests
Message-ID: <cover.1626252248.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce selftests to validate the functionality of KSM. The tests are
run on private anonymous pages. Since some KSM tunables are modified,
their starting values are saved and restored after testing. At the
start, run is set to 2 to ensure that only test pages will be merged (we
assume that no applications make madvise syscalls in the background). If
KSM config not enabled, all tests will be skipped.

Zhansaya Bagdauletkyzy (4):
  selftests: vm: add KSM merge test
  selftests: vm: add KSM unmerge test
  selftests: vm: add KSM zero page merging test
  selftests: vm: add KSM merging across nodes test

v1 -> v2:
- add a test to check KSM unmerging
- add a test to check merging of zero pages
- add a test to check merging in different NUMA nodes
- include command line options for each test
- new options to specify use_zero_pages and merge_across_nodes
- run each test case in run_vmtests.sh
- add some helper functions to make the code more compact:
  allocate_memory(), ksm_do_scan(), ksm_merge_pages()

 tools/testing/selftests/vm/.gitignore     |   1 +
 tools/testing/selftests/vm/Makefile       |   3 +
 tools/testing/selftests/vm/ksm_tests.c    | 516 ++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh |  96 ++++
 4 files changed, 616 insertions(+)
 create mode 100644 tools/testing/selftests/vm/ksm_tests.c

-- 
2.25.1


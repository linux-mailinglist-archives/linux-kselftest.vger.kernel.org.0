Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB34D4727EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 11:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhLMKGB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 05:06:01 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223]:23804 "EHLO
        esa9.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236050AbhLMKEB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:01 -0500
IronPort-SDR: pqsqMBbRdvhRKYuNit9zU0HIwF/FrXMOVceh8H8WauYdpgAkw5UzbweygG+pjqjwbp3pUhn5ab
 eNZ92pUsKQJmX2kbxyGnsKSI2RJyHDgDE9lgGfiET0VfWDPzMZfatskPRRE4VlE+Zi/g6xeUET
 B35xSbi8Tq9ggI8BtZNIVbb//dhfeN8Hs7ImTgbVHF3ut+fyXwfu6P1urQ9vY84J2g7Q3qcouz
 0kN6lMfAYIn3OkQz0/XNaLZSCclSFXGm2o8B5Bm70w3CiBrZvvWDIvNgOXLK4S8FLE/6W9sg/d
 zm889hU6hE2gmR9V8V338oHl
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="44130304"
X-IronPort-AV: E=Sophos;i="5.88,202,1635174000"; 
   d="scan'208";a="44130304"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 13 Dec 2021 19:03:55 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 61FB3799E8;
        Mon, 13 Dec 2021 19:03:54 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A67F511C46;
        Mon, 13 Dec 2021 19:03:53 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 80386403F1347;
        Mon, 13 Dec 2021 19:03:53 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v2 0/5] selftests/resctrl: Add resctrl_tests into kselftest set
Date:   Mon, 13 Dec 2021 19:01:49 +0900
Message-Id: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

The aim of this series is to make resctrl_tests run by using 
kselftest framework.
- I modify Makefile of resctrl_test and Makefile of selftest, to
  build/run resctrl_tests by using kselftest framework.
- I set the limited time for resctrl_tests to 120 seconds, to ensure the
  resctrl_tests finish in limited time.
- When resctrl file system is not supported or resctrl_tests is not run
  as root, return skip code of kselftest.
- If it is not finish in limited time, terminate resctrl_tests same as
  executing ctrl+c.

Difference from v1:
- I change the order of patches according to Reinette's review.
- "LDLIBS + = -lnuma" has no dependencies on this patch series, delete
  it from [PATCH v2 2/5].
- I separate the license info of Makefile into a new patch [PATCH v2
  3/5].
- I separate "limited time" into a new patch [PATCH v2 4/5].
(There is no change in [PATCH v2 1/5] and [PATCH v2 5/5])
In addition, I think 120s is not a problem since some tests have longer
timeout (e.g. net test is 300s), please let me know if this is wrong

Thanks,

Shaopeng Tan (5):
  selftests/resctrl: Kill the child process created by fork() when the
    SIGTERM signal comes
  selftests/resctrl: Make resctrl_tests run using kselftest framework
  selftests/resctrl: Add license to resctrl_test Makefile
  selftests/resctrl: Change default limited time to 120 seconds for
    resctrl_tests
  selftests/resctrl: Return KSFT_SKIP(4) if resctrlfile system is not
    supported or resctrl is not run as root

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/resctrl/Makefile      | 20 +++++++------------
 .../testing/selftests/resctrl/resctrl_tests.c |  4 ++--
 tools/testing/selftests/resctrl/resctrl_val.c |  1 +
 tools/testing/selftests/resctrl/settings      |  1 +
 5 files changed, 12 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/settings

-- 
2.27.0


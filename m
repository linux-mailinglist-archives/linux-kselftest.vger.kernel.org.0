Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0DD44BDD6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 10:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhKJJgm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 04:36:42 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:30728 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230507AbhKJJgm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 04:36:42 -0500
IronPort-SDR: 7nUW+A7hS7sFlngFl/1HNkof+dJsrr/cinZpKCSVlCKdtRlFa11eTp9UxfgDXNjUqG3NvfqLJC
 vbk55qD94kBYoqC7edVn2F8KAmbxoMtkk2bOw/PbyF+79qCKxrU9csxiQdE1D3+NLdg2RzTiX7
 k1iPfqVsqdydlHBvHCiAG2dAKFFWImCw0XGaHanCkcNk6L4CmD1yp8PDNs70f0CMle2mxtrxqC
 DoERRIxjuxNlaPye7OR60Z38Di8MH1qaOdn5vovYA8mht3KhcEfaTyiM30SDBJ6UrBGpy2tPKW
 OsDiNBRvd3vg+83VXKmIeyAA
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="52106836"
X-IronPort-AV: E=Sophos;i="5.87,223,1631545200"; 
   d="scan'208";a="52106836"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 10 Nov 2021 18:33:41 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id D19F324C39C;
        Wed, 10 Nov 2021 18:33:39 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id DFB0CBDB4C;
        Wed, 10 Nov 2021 18:33:38 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id EE01A40110161;
        Wed, 10 Nov 2021 18:33:37 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH 0/3] selftests/resctrl: Add resctrl_tests into kselftest set
Date:   Wed, 10 Nov 2021 18:33:12 +0900
Message-Id: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

Resctrl_tests is in the kselftest directory, but it cannot use kselftest 
framework. The aim of this series is to make resctrl_tests run by using 
kselftest framework and to fix some bug/setting of resctrl_tests when 
use kselftest framework.

In kselftest framework, we can build/run resctrl_tests by build/run 
all tests of kselftest, and we also can use the "TARGETS" variable 
on the make command line to specify resctrl_tests to build/run.

To ensure the resctrl_tests finish in limited time(which is specified 
by timeout command), set the limited time for resctrl_tests to 120 seconds.
When resctrl filesystem is not supported or resctrl_tests is not run as 
root, return skip code of kselftest.  If it is not finish in limited time, 
terminate resctrl_tests same as when executing ctrl+c.

Thanks,

Tan, Shaopeng (3):
  selftests/resctrl: Make resctrl_tests run using kselftest framework
  selftests/resctrl: Return KSFT_SKIP(4) if resctrl filessystem is not
    supported or resctrl is not run as root
  selftests/resctrl: Kill the child process created by fork() when the
    SIGTERM signal comes

 tools/testing/selftests/Makefile                |  1 +
 tools/testing/selftests/resctrl/Makefile        | 21 +++++++++------------
 tools/testing/selftests/resctrl/resctrl_tests.c |  4 ++--
 tools/testing/selftests/resctrl/resctrl_val.c   |  1 +
 tools/testing/selftests/resctrl/settings        |  1 +
 5 files changed, 14 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/settings

-- 
1.8.3.1


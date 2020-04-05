Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F419E8AD
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Apr 2020 04:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgDEC6J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Apr 2020 22:58:09 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:29463 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726283AbgDEC6I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Apr 2020 22:58:08 -0400
X-IronPort-AV: E=Sophos;i="5.72,346,1580745600"; 
   d="scan'208";a="88505719"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Apr 2020 10:58:06 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id E21B4406AB15;
        Sun,  5 Apr 2020 10:47:41 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Sun, 5 Apr 2020 10:58:03 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Sun, 5 Apr 2020 10:58:00 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <shuah@kernel.org>, <ice_yangxiao@163.com>,
        <linux-kselftest@vger.kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] selftests/ftrace: Add CONFIG_SAMPLE_FTRACE_DIRECT=m kconfig
Date:   Sun, 5 Apr 2020 09:44:57 +0800
Message-ID: <20200405014457.8854-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: E21B4406AB15.AA5E8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ftrace-direct.tc and kprobe-direct.tc require CONFIG_SAMPLE_FTRACE_DIRECT=m
so add it to config file which is used by merge_config.sh.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tools/testing/selftests/ftrace/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index c2c8de4fafff..e59d985eeff0 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -11,5 +11,6 @@ CONFIG_PREEMPTIRQ_DELAY_TEST=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_SAMPLES=y
+CONFIG_SAMPLE_FTRACE_DIRECT=m
 CONFIG_SAMPLE_TRACE_PRINTK=m
 CONFIG_KALLSYMS_ALL=y
-- 
2.25.1




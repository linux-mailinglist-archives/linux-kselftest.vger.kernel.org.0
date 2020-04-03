Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9B19D42B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Apr 2020 11:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbgDCJmi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Apr 2020 05:42:38 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12225 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727912AbgDCJmi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Apr 2020 05:42:38 -0400
X-IronPort-AV: E=Sophos;i="5.72,339,1580745600"; 
   d="scan'208";a="88448635"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Apr 2020 17:42:35 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 26CF9406AB15;
        Fri,  3 Apr 2020 17:32:14 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 3 Apr 2020 17:42:33 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Fri, 3 Apr 2020 17:42:34 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <shuah@kernel.org>, <ice_yangxiao@163.com>,
        <linux-kselftest@vger.kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] selftests/ftrace: Always enable ftrace_enabled for ftrace testcases
Date:   Fri, 3 Apr 2020 16:29:29 +0800
Message-ID: <20200403082929.1869-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 26CF9406AB15.A986E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A lot of ftrace testcases get failure if ftrace_enabled is disabled by default
because ftrace_enabled is a big on/off switch for the whole function tracer.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tools/testing/selftests/ftrace/test.d/functions | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 5d4550591ff9..54c18275bd7f 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -1,3 +1,6 @@
+enable_ftrace() { # enable function tracer
+    echo 1 > /proc/sys/kernel/ftrace_enabled
+}
 
 clear_trace() { # reset trace output
     echo > trace
@@ -88,6 +91,7 @@ initialize_ftrace() { # Reset ftrace to initial-state
 # As the initial state, ftrace will be set to nop tracer,
 # no events, no triggers, no filters, no function filters,
 # no probes, and tracing on.
+    enable_ftrace
     disable_tracing
     reset_tracer
     reset_trigger
-- 
2.23.0




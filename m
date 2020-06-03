Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6892F1EC771
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jun 2020 04:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgFCCkO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 22:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgFCCkO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 22:40:14 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 464CB20738;
        Wed,  3 Jun 2020 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591152013;
        bh=aIJ1a7rvQXz2M63O+DfYAeyjaSsp4HOq1vGHLd4VTPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ev8fPJDOciRVQOgtRqZjkk45SJrKrrJMXCmlu7JPOp62Z79M05/9Fe3G1UmHTtGYQ
         HbSmVDqdWnLvt8qs4f2laUESYiOItOPprMUoaAWPFNujYK2fXFlWH+IJ6gqq3kOw3E
         mwi1wvNU/RoSRjEv2CUG2BnI4T+07Pkt03Gc0ajI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 1/7] selftests/ftrace: Allow ":" in description
Date:   Wed,  3 Jun 2020 11:40:10 +0900
Message-Id: <159115201005.70027.2043111124794279656.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159115200085.70027.6141550347953439240.stgit@devnote2>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow ":" in the description line. Currently if there is ":"
in the test description line, the description is cut at that
point, but that was unintended.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index a4605b5ee66d..d3f6652311ef 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -263,7 +263,7 @@ CASENO=0
 
 testcase() { # testfile
   CASENO=$((CASENO+1))
-  desc=`grep "^#[ \t]*description:" $1 | cut -f2 -d:`
+  desc=`grep "^#[ \t]*description:" $1 | cut -f2- -d:`
   prlog -n "[$CASENO]$INSTANCE$desc"
 }
 


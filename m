Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0D9109A40
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 09:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfKZIeq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 03:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfKZIeq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 03:34:46 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C4A2084B;
        Tue, 26 Nov 2019 08:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574757285;
        bh=sT2P3jcqZzwiE0tNd5Vyi3LpzVl1tf4SHap4G4TGsII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tfZpVpvX8X+lMwMJgdU9bHtkdDLkwzeKwc/Bp7aDaSoVyvLvj8J8VDWweWFxZZrGv
         70DszgLZzGiyF0/BaIp6X/yLCBSt/mjt/ADdh0P603MBclyOPHE4/k8LJJRDIw2g0h
         aNXtvNgVX0wfZPVDcGbiIc74AUf1+Sehl8Mod3BM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH v4 4/4] selftests/ftrace: Fix multiple kprobe testcase
Date:   Tue, 26 Nov 2019 17:34:42 +0900
Message-Id: <157475728194.3389.8125594709546416519.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157475724667.3389.15752644047898709246.stgit@devnote2>
References: <157475724667.3389.15752644047898709246.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix multiple kprobe event testcase to work it correctly.
There are 2 bugfixes.
 - Since `wc -l FILE` returns not only line number but also
   FILE filename, following "if" statement always failed.
   Fix this bug by replacing it with 'cat FILE | wc -l'
 - Since "while do-done loop" block with pipeline becomes a
   subshell, $N local variable is not update outside of
   the loop.
   Fix this bug by using actual target number (256) instead
   of $N.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index 5862eee91e1d..6e3dbe5f96b7 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -20,9 +20,9 @@ while read i; do
   test $N -eq 256 && break
 done
 
-L=`wc -l kprobe_events`
-if [ $L -ne $N ]; then
-  echo "The number of kprobes events ($L) is not $N"
+L=`cat kprobe_events | wc -l`
+if [ $L -ne 256 ]; then
+  echo "The number of kprobes events ($L) is not 256"
   exit_fail
 fi
 


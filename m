Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E6C1088D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 07:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKYG5b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 01:57:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYG5b (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 01:57:31 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FE1520835;
        Mon, 25 Nov 2019 06:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574665050;
        bh=8NJZ4ecKYsAsn8f0rkIBPL4Q6ni1vDuY2huK9s6nGEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EeXJIKBht3llg+C28rDTz8jf1qp+AoBfCKyJ+axwXorkOaaF3ZnVGhHXyjKygzTEr
         TuodLxfwRXh4cYSzZvozSpqng3uBTjkR4dyrrPXRuo77EOWzvLIV+VABq5cd4+KcMA
         S38BxMwnr/lM1kdgjNjjwnIzcBOgV3EC3MRsefu0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH v3 4/4] selftests/ftrace: Fix multiple kprobe testcase
Date:   Mon, 25 Nov 2019 15:57:27 +0900
Message-Id: <157466504736.21973.15722652829669648396.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157466501169.21973.31401747181477687.stgit@devnote2>
References: <157466501169.21973.31401747181477687.stgit@devnote2>
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
 


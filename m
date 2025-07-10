Return-Path: <linux-kselftest+bounces-36961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5446B002CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61F81C43DFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0846727056A;
	Thu, 10 Jul 2025 13:01:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC0241132;
	Thu, 10 Jul 2025 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152514; cv=none; b=CPrM9ZPYe9D3uCcVavIbI0dSu0aqfKFGwHcp0RTterGi/4V1HQks1oezkewVP5jQMc/I0ddzKqghnBjadpxhdeEXus1+9lPEZtSLi0Lgf1sG/PZhitNbIrK9xKviPOyN3lFL4PO6Ny/kIgFXEkrmNFgMhnmEKr/666Pdx7ccLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152514; c=relaxed/simple;
	bh=5491tcOvMmeOhV7CHKAE15EGHqNMpbS86rZBXtkRIcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u7NUwFbuwrTPIQ0pFDu+S3IQ8nL+hYxVCENLr9ZZRXuGFOI3ivUynat9wS+G7xYz2b5TOUllDCUuBYNJvxVgnblqB1V6eWdN8JCu2+cXkea0pF/XLYr9/UMHd0vgwMshs4tquKtQyWDo0EMGRPIO/9xm6d9DsyiAS7J4vFgxOFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bdFNZ2RHvzYQvHB;
	Thu, 10 Jul 2025 21:01:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 221FA1A0E31;
	Thu, 10 Jul 2025 21:01:49 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgBXtyS0uW9o1jsSBQ--.59794S2;
	Thu, 10 Jul 2025 21:01:49 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH -next] selftests/ftrace: Prevent potential failure in subsystem-enable test case
Date: Thu, 10 Jul 2025 13:01:34 +0000
Message-Id: <20250710130134.591066-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXtyS0uW9o1jsSBQ--.59794S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1DZF18Jr4UXw1kZF48Xrb_yoW8trW3p3
	9rZrnrKrn5Ga4jkas7C3Z3Xry5XrykAryqqrW5Aa43JF15J34ftFn3tr1agF12qrZakry3
	Aw1I9a47Z3Wjv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUU
	UUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The first 100 lines of trace output don't always contain 3 or more
distinct events. In busy systems, they may be dominated by repetitive
events like sched_stat_runtime, causing the `$count -lt 3` check to
fail. Example trace:

$ head -n 100 trace | grep -v ^#
 systemd-timesyn-266     [006] d.h2.   738.778482: sched_stat_runtime: comm=systemd-timesyn pid=266 runtime=976854 [ns]
      ftracetest-8751    [001] d.h2.   738.778512: sched_stat_runtime: comm=ftracetest pid=8751 runtime=938335 [ns]
 systemd-timesyn-266     [006] d.h1.   738.779531: sched_stat_runtime: comm=systemd-timesyn pid=266 runtime=1044284 [ns]
      ftracetest-8751    [001] d.h2.   738.779541: sched_stat_runtime: comm=ftracetest pid=8751 runtime=1028575 [ns]
         systemd-1       [007] d.h5.   738.779657: sched_stat_runtime: comm=systemd pid=1 runtime=642624 [ns]
[...]

With trace cleared, simply check `$count -eq 0` to confirm subsystem
enablement, just like toplevel-enable.tc does.

Fixes: 1a4ea83a6e67 ("selftests/ftrace: Limit length in subsystem-enable tests")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../selftests/ftrace/test.d/event/subsystem-enable.tc     | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index b7c8f29c09a9..3a28adc7b727 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -19,8 +19,8 @@ echo 'sched:*' > set_event
 yield
 
 count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
-if [ $count -lt 3 ]; then
-    fail "at least fork, exec and exit events should be recorded"
+if [ $count -eq 0 ]; then
+    fail "none of scheduler events are recorded"
 fi
 
 do_reset
@@ -30,8 +30,8 @@ echo 1 > events/sched/enable
 yield
 
 count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
-if [ $count -lt 3 ]; then
-    fail "at least fork, exec and exit events should be recorded"
+if [ $count -eq 0 ]; then
+    fail "none of scheduler events are recorded"
 fi
 
 do_reset
-- 
2.34.1



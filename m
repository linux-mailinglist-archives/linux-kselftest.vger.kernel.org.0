Return-Path: <linux-kselftest+bounces-6451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA8D88132F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 15:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2262284D3B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01E84207F;
	Wed, 20 Mar 2024 14:18:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57D441C84;
	Wed, 20 Mar 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944333; cv=none; b=CJ3tVQCUX5g9mjX3eV/tOpy/62zvaC7T+fNmigz8vpN7IazA04OndL0hdvKEI0KRV7eksy0gZss6TwmPukHdnea3NLvRiSS85C2JDTiP9YyMTLEJNXLpZ3ctPFFbNjfzObfv0R4+YDB+HAco6xWzemZEXk9DrCpJ3/sfOY+CuCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944333; c=relaxed/simple;
	bh=xmbyWobTD3RpSNLREBva1eUC9VLaDy7wqoqKn/PRejE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dBgKnOlnK4DJO4uifxKkt4ak+4RnA+Ege+o3eu9EJMHjbTl8zDhZBX9cFoIyA2LEl9jYxmGPhp+CU53C0K8/ZT/OwFBL5D349yCFnksErOUu/LQSOjewGegWl0DDpSPLndbQLUC9H07x1h3gfortN7Oyj9rk+peszvIGAfPk7PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFD591007;
	Wed, 20 Mar 2024 07:19:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F3253F64C;
	Wed, 20 Mar 2024 07:18:49 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: aishwarya.tcv@arm.com,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	shuah@kernel.org
Subject: [PATCH] selftests/ftrace: Fix event filter target_func selection
Date: Wed, 20 Mar 2024 14:18:44 +0000
Message-Id: <20240320141844.1779984-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event filter function test has been failing in our internal test
farm:

| # not ok 33 event filter function - test event filtering on functions

Running the test in verbose mode indicates that this is because the test
erroneously determines that kmem_cache_free() is the most common caller
of kmem_cache_free():

  # # + cut -d: -f3 trace
  # # + sed s/call_site=([^+]*)+0x.*/1/
  # # + sort
  # # + uniq -c
  # # + sort
  # # + tail -n 1
  # # + sed s/^[ 0-9]*//
  # # + target_func=kmem_cache_free

... and as kmem_cache_free() doesn't call itself, setting this as the
filter function for kmem_cache_free() results in no hits, and
consequently the test fails:

  # # + grep kmem_cache_free trace
  # # + grep kmem_cache_free
  # # + wc -l
  # # + hitcnt=0
  # # + grep kmem_cache_free trace
  # # + grep -v kmem_cache_free
  # # + wc -l
  # # + misscnt=0
  # # + [ 0 -eq 0 ]
  # # + exit_fail

This seems to be because the system in question has tasks with ':' in
their name (which a number of kernel worker threads have). These show up
in the trace, e.g.

  test:.sh-1299    [004] .....  2886.040608: kmem_cache_free: call_site=putname+0xa4/0xc8 ptr=000000000f4d22f4 name=names_cache

... and so when we try to extact the call_site with:

  cut -d: -f3 trace | sed 's/call_site=\([^+]*\)+0x.*/\1/'

... the 'cut' command will extrace the column containing
'kmem_cache_free' rather than the column containing 'call_site=...', and
the 'sed' command will leave this unchanged. Consequently, the test will
decide to use 'kmem_cache_free' as the filter function, resulting in the
failure seen above.

Fix this by matching the 'call_site=<func>' part specifically to extract
the function name.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
---
 .../selftests/ftrace/test.d/filter/event-filter-function.tc     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
index 2de7c61d1ae3..3f74c09c56b6 100644
--- a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
@@ -24,7 +24,7 @@ echo 0 > events/enable
 echo "Get the most frequently calling function"
 sample_events
 
-target_func=`cut -d: -f3 trace | sed 's/call_site=\([^+]*\)+0x.*/\1/' | sort | uniq -c | sort | tail -n 1 | sed 's/^[ 0-9]*//'`
+target_func=`cat trace | grep -o 'call_site=\([^+]*\)' | sed 's/call_site=//' | sort | uniq -c | sort | tail -n 1 | sed 's/^[ 0-9]*//'`
 if [ -z "$target_func" ]; then
     exit_fail
 fi
-- 
2.39.2



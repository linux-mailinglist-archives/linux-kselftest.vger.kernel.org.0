Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88559FEF4F
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2019 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfKPP6C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Nov 2019 10:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731450AbfKPPy0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Nov 2019 10:54:26 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D424A20854;
        Sat, 16 Nov 2019 15:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919666;
        bh=G+bUnZIIGo0TF/ZYi61/DRntB0hbkjdnF5/2+ThSJ3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1tIp7Tr9MajtYxyDhtd9A9FpYXebUJcEoiUR+0HtOLrDqXmunEgNB9lN2bi1pQ51X
         C3CXgl5ltXz6724N2YicDlLTf4ODpgH6aW7VptVfyXJAsaP1Q4awAGhPmTz1KDZZdS
         rBi9gGBvl3xAI64iRrphAyQqR3UY0hN4UYGM4g8E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 38/77] selftests/ftrace: Fix to test kprobe $comm arg only if available
Date:   Sat, 16 Nov 2019 10:53:00 -0500
Message-Id: <20191116155339.11909-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155339.11909-1-sashal@kernel.org>
References: <20191116155339.11909-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 2452c96e617a0ff6fb2692e55217a3fa57a7322c ]

Test $comm in kprobe-event argument syntax testcase
only if it is supported on the kernel because
$comm has been introduced 4.8 kernel.
So on older stable kernel, it should be skipped.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
index 231bcd2c4eb59..1e7ac6f3362ff 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -71,8 +71,11 @@ test_badarg "\$stackp" "\$stack0+10" "\$stack1-10"
 echo "r ${PROBEFUNC} \$retval" > kprobe_events
 ! echo "p ${PROBEFUNC} \$retval" > kprobe_events
 
+# $comm was introduced in 4.8, older kernels reject it.
+if grep -A1 "fetcharg:" README | grep -q '\$comm' ; then
 : "Comm access"
 test_goodarg "\$comm"
+fi
 
 : "Indirect memory access"
 test_goodarg "+0(${GOODREG})" "-0(${GOODREG})" "+10(\$stack)" \
-- 
2.20.1


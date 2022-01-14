Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D42148F2E9
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jan 2022 00:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiANXVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jan 2022 18:21:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34116 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiANXVm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jan 2022 18:21:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 56AB71F46D79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642202501;
        bh=IG6R5uw0yb3VLWtgH6sIypdBw8QjZrLQPe1BTwKhfbI=;
        h=From:To:Cc:Subject:Date:From;
        b=hIfQ6LPv3hxOBrIzE+2fY+y+U+gAwIVNKl5BeY1UMT2Tzf/VfiKoelgFvpydPfVeu
         YOgyyYx/a3JMIQnw1tpFjjmhNLc+1cye4D6C0e9/o8WFtEpO4Nl0CKYnIazi2QlyAX
         EZc7ApWAQ/t0NTFv6RCOah2tBe/Y9iEHMrdiFlmUnNJWzyTs0HA65nOWdNbY+VSeWp
         YMcuwxnEjxUkQhzm0ODVW2R8a+RYWiJlfUndo/JP9VAomYg6iu3T5DDC3fO2bwXPx/
         NDdONaiKwFH9C4KUbkZjpHERQVv0HHyd0F4gNI3SsnOLqwiOusXcRKpIQ/3kX+5Wz7
         yPHG312/z/VmQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH] selftests: cpufreq: Write test output to stdout as well
Date:   Fri, 14 Jan 2022 18:21:26 -0500
Message-Id: <20220114232126.92043-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use 'tee' to send the test output to stdout in addition to the current
output file. This makes the output easier to handle in automated test
systems and is superior to only later dumping the output file contents
to stdout, since this way the test output can be interleaved with other
log messages, like from the kernel, so that chronology is preserved,
making it easier to detect issues.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/cpufreq/main.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
index 31f8c9a76c5f..60ce18ed0666 100755
--- a/tools/testing/selftests/cpufreq/main.sh
+++ b/tools/testing/selftests/cpufreq/main.sh
@@ -194,5 +194,5 @@ prerequisite
 
 # Run requested functions
 clear_dumps $OUTFILE
-do_test >> $OUTFILE.txt
+do_test | tee -a $OUTFILE.txt
 dmesg_dumps $OUTFILE
-- 
2.34.1


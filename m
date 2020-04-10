Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66911A44EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Apr 2020 12:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgDJKDD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Apr 2020 06:03:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60102 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDJKDD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Apr 2020 06:03:03 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jMqV4-0003SW-By
        for linux-kselftest@vger.kernel.org; Fri, 10 Apr 2020 10:03:02 +0000
Received: by mail-wr1-f72.google.com with SMTP id x9so878834wrq.17
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Apr 2020 03:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Z3P5ra7nIgSjErTUHVmG2gVsvgQADuW5sfZ4PtTp618=;
        b=R8ZX5smRq9AZ3N10vbILrcLddNvA7pS0O6tqmWB6I3rxMOFKL0Hd2xAO2yD+Q1ukF4
         BNv5QhQ+gF2njLBa5RGsk1N3X04rql9uLd0okCybCn0lHHmmo6SYJmjovlPV8PYdZKli
         Z+4lXoz69dVUKQaX6zjt4gmha+92GQbfXr2VixjfBUXXgofWXtVnJybVDjLOkbcCfcQ3
         84fddvcHZJHxe6/C5Despr4XD6WO6AP6teHOARmD32hVRlDIAh3hmP2YgBGSe8L7vVYG
         cnhN6Lw45OJcQqoF4g+jFBytzHb/Y6H6Gq6VulkSHDIvNuXOUPz6D/NjBuVw0yA9KMkq
         lo2w==
X-Gm-Message-State: AGi0PubXBGnghW9TZAIj1t49XcKGZrZHYvj8qVsxM+FxYAui6R6MwLXd
        Hcs3fUDjaMz/1opabc/+mQRzVWCQT7NmlxO247B+3aAdV1khI9UJwjQPyxGQ4tYIxCXiT9ud9j2
        ZnL3myQvDTCBgK2WnFKx0M4+goMKOBcydxLrczcnQlXlRxA==
X-Received: by 2002:a1c:6787:: with SMTP id b129mr4574986wmc.165.1586512981978;
        Fri, 10 Apr 2020 03:03:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypJk4lRxcFGUzlhlWkYg2asplSW+TWRRfdgc31OMNALo4BRjm4RdCfBoPSErXWDJWfmQ9WWwhQ==
X-Received: by 2002:a1c:6787:: with SMTP id b129mr4574957wmc.165.1586512981640;
        Fri, 10 Apr 2020 03:03:01 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id k84sm2243972wmk.2.2020.04.10.03.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 03:03:01 -0700 (PDT)
Date:   Fri, 10 Apr 2020 12:02:59 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/runner: allow to properly deliver signals to tests
Message-ID: <20200410100259.GA457752@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While running seccomp_bpf, kill_after_ptrace() gets stuck if we run it
via /usr/bin/timeout (that is the default), until the timeout expires.

This is because /usr/bin/timeout is preventing to properly deliver
signals to ptrace'd children (SIGSYS in this case).

This problem can be easily reproduced by running:

 $ sudo make TARGETS=seccomp kselftest
 ...

 # [ RUN      ] TRACE_syscall.skip_a#
 not ok 1 selftests: seccomp: seccomp_bpf # TIMEOUT

The test is hanging at this point until the timeout expires and then it
reports the timeout error.

Prevent this problem by passing --foreground to /usr/bin/timeout,
allowing to properly deliver signals to children processes.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/kselftest/runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index e84d901f8567..676b3a8b114d 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -33,7 +33,7 @@ tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
 	if [ -x /usr/bin/timeout ] ; then
-		/usr/bin/timeout "$kselftest_timeout" "$1"
+		/usr/bin/timeout --foreground "$kselftest_timeout" "$1"
 	else
 		"$1"
 	fi
-- 
2.25.1


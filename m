Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08195195445
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Mar 2020 10:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgC0Jma (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Mar 2020 05:42:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48536 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgC0Jma (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Mar 2020 05:42:30 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jHlVU-0000Ie-8w
        for linux-kselftest@vger.kernel.org; Fri, 27 Mar 2020 09:42:28 +0000
Received: by mail-wm1-f72.google.com with SMTP id n188so4140975wmf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Mar 2020 02:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ap78OtXZq7aQJZ6TMPBs7AlXvQ7dSNaiueS9qsI4mxo=;
        b=BHlmYnj8Ge2rNfOfUQPvOnSNFq3lfrWw5TTXtA/HZUK14EEiFhQigtRXQCrNhXOA6k
         DwyKaGIctlU4X9FMwH1jo8KvVz1O1VeLXl9qA6aIvLSRuSXbgLJ7I8z429uOZ3rcf9Aa
         yE10+DbcXyk1dukNyYGQduZxPNvY7hJMDBKKv9DXfIdCyeRJtCjx1fA+NbWwdmKWcoIo
         d+AJwnKucbJdJQJ0j1XYwkwYrzoGKdtbcoglF9xcMwlRHo/1w/HEP2IUhWOiLY1Xybdn
         0/n/ConOrbHcKtlJ9sjGYU8DOLmqePA17PDaN9vGJcNM9yO/kuEB5hA0TvIecwo1rsB3
         KuMg==
X-Gm-Message-State: ANhLgQ3RDo9F5viYNQZJRhC6wHhBGviTo9r/ZgJb8y+Ea328BX84tI12
        lo6yo9synjTl3k7a0FIMt+0kGZN0/WwMsiOK4sZqtVKDSOt35p+n77ZYyl8BIqmMX4Rpr93wG5T
        ZnVEOGnhTq5XMKXpUZUOHri9RnGhHrwFN0r/iT8rZ7Eda0w==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr3211176wrq.345.1585301782619;
        Fri, 27 Mar 2020 02:36:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvx5Ju256H8lihDv+l/wpn/owlEL5RgRyERZjbHzg4A1aOGeFUlR72YVLLEH15UgqMSh/gGzQ==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr3211156wrq.345.1585301782361;
        Fri, 27 Mar 2020 02:36:22 -0700 (PDT)
Received: from localhost (host87-23-dynamic.53-79-r.retail.telecomitalia.it. [79.53.23.87])
        by smtp.gmail.com with ESMTPSA id c23sm7673665wrb.79.2020.03.27.02.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 02:36:21 -0700 (PDT)
Date:   Fri, 27 Mar 2020 10:36:20 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/runner: avoid using timeout when timeout is
 disabled
Message-ID: <20200327093620.GB1223497@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Avoid using /usr/bin/timeout unnecessarily if timeout is set to 0
(disabled) in the "settings" file for a specific test.

NOTE: without this change (and adding timeout=0 in the corresponding
settings file - tools/testing/selftests/seccomp/settings) the
seccomp_bpf selftest is always failing with a timeout event during the
syscall_restart step.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/kselftest/runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index e84d901f8567..2cd3c8def0f6 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -32,7 +32,7 @@ tap_prefix()
 tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
-	if [ -x /usr/bin/timeout ] ; then
+	if [ -x /usr/bin/timeout ] && [ $kselftest_timeout -gt 0 ] ; then
 		/usr/bin/timeout "$kselftest_timeout" "$1"
 	else
 		"$1"
-- 
2.25.1


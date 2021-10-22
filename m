Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA9043804D
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Oct 2021 00:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhJVWky (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Oct 2021 18:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbhJVWkx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Oct 2021 18:40:53 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80619C061243
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Oct 2021 15:38:35 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r28so223108pga.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Oct 2021 15:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4v03Dq8rJnp2emUyjLLIYPOR/r+cJwb6i4GsGFOI3E=;
        b=mxDJiNxec6TVrFZmoJlMDdG2TzWAATb8LuQP2YucauFIPYK2hJ3AN2eDH0KAnLekdJ
         csndqVPqIG84nt62c5o82Mmns3j1k/0LyTN0Y0NDu/uYpIT6ifwyDKOb5c7g1WVWZFGg
         5rLb8PZNKIlQ86pHNP3cnjGLarqKbTzCyXKeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4v03Dq8rJnp2emUyjLLIYPOR/r+cJwb6i4GsGFOI3E=;
        b=pz6T4UOF4IpGNTgKKpKSsEwwP0XrdlhAs7jxBAffzDWqMVcDMRNPJO0laeOmo2nfLq
         UkTz+uoafnzqeNz+dU6fqKkjNDKjkMsV8VENMGbK8yABWXGdvuptBo7E5E7nYBTJhh45
         Fl5JX6mowDWxhc/sbMkAaFQCQ6i4mcnahAOTzYEY1qXPdEfm4vxAROnnmt63P2oe24ZF
         FfkH4jfkKOz683vLMfyQFN+lWIzB7NaQJytMzntx22/kcKb4vBonRUrDcoenAEKDhe0T
         7Q1YoCYej6yS5+LjtlzHodmQyNVmPseWSLAjY+iEXmxjSDGkZyK35lrCyQ8KXjuevEzR
         4qvA==
X-Gm-Message-State: AOAM530urRaAjWKAyjn+p8MZJ0zjmfP1DEMqdU2S7ciXeFQ2jDvpVABZ
        zZB5+dqWG3Po26XSpGeDXWkUbg==
X-Google-Smtp-Source: ABdhPJylAPHzu6WrwxpDAXOo4JnVlN1LpYv0YLDCaUU1pzLwefU4HRMEpDaVgnhmLyt39ohRrKUlZg==
X-Received: by 2002:a63:6a05:: with SMTP id f5mr1888819pgc.97.1634942315011;
        Fri, 22 Oct 2021 15:38:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oj5sm8235pjb.45.2021.10.22.15.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:38:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] selftests/lkdtm: Add way to repeat a test
Date:   Fri, 22 Oct 2021 15:38:25 -0700
Message-Id: <20211022223826.330653-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022223826.330653-1-keescook@chromium.org>
References: <20211022223826.330653-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597; h=from:subject; bh=UVZsTcO0+dkUDOoZKZ0wsUf6jiITa/KlLtRjLgC+IcE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhcz1hnP4vY/kMhAbyukzou7Lmmlyx3ymfw/9MbmKU WEremomJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYXM9YQAKCRCJcvTf3G3AJoauEA CiXWYCjzhG4dZybCOGZwMn97gQLCmmbZHIKleA6A/neFv1N2L47+XWkNDAgiSDozOBaXjzJFKLYjSV jLxyTEkjahF5Xof1SMFbn997fo8Yv8MsgZyhQnflUG/RxyFUKGRGmihYdfSShaETnXBLpTGQC2jGaA aD0UGaP9WeXqOmnQ74/+LaxFxqaGx3LbxsfEqA0bS6HcM82XhoZoizTe+aAkSI7oWrNRphIx1mXGbv d9zM+nmMs8hf6XxBhUAedls/m7ba5WRbJMLWfQN3Iz33l0S0BAFBUZOtvZCbD1Asgn99wgBSI8gTe6 TDiCzMrmvadEm1rqmzaocxQO0Cnk89qJsNTsanHKwnvQKM+V/BvbWJZgQw742lUGKcF/OVsWCrOSSg gP/kOSqO4K2jNYMpaEoJFzKE4JEPjjoX5PqIjbDuWb6W2vPBPtJZTL6E6y6bU3u6PlVEAmcGjJxjUG dwQ3QMReVamNncGr+5ThpNWPH2kww86py4KqRXgUQKjNEr00HLF3RXh0e4SiHWe4vDABl8S7jpMxZn LGLzeQwR7r2mwxluUzCJpbZte578Yofs+Gil1zdtWKRE7IHzje9xs8J7aXXxh1IWRcKqjN971QLFIK f66hYw7vzoreDQqdmQjTzyQ6goj4EBmhePXwSeOVE2XX8SGiBue1HlXnURAg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some LKDTM tests need to be run more than once (usually to setup and
then later trigger). Until now, the only case was the SOFT_LOCKUP test,
which wasn't useful to run in the bulk selftests. The coming stack canary
checking needs to run twice, so support this with a new test output prefix
"repeat".

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/lkdtm/run.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index e95e79bd3126..95e904959207 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -56,8 +56,14 @@ if echo "$test" | grep -q '^#' ; then
 fi
 
 # If no expected output given, assume an Oops with back trace is success.
+repeat=1
 if [ -z "$expect" ]; then
 	expect="call trace:"
+else
+	if echo "$expect" | grep -q '^repeat:' ; then
+		repeat=$(echo "$expect" | cut -d' ' -f1 | cut -d: -f2)
+		expect=$(echo "$expect" | cut -d' ' -f2-)
+	fi
 fi
 
 # Prepare log for report checking
@@ -83,7 +89,9 @@ dmesg > "$DMESG"
 # the signal that killed the subprocess, we must ignore the failure and
 # continue. However we don't silence stderr since there might be other
 # useful details reported there in the case of other unexpected conditions.
-echo "$test" | cat >"$TRIGGER" || true
+for i in $(seq 1 $repeat); do
+	echo "$test" | cat >"$TRIGGER" || true
+done
 
 # Record and dump the results
 dmesg | comm --nocheck-order -13 "$DMESG" - > "$LOG" || true
-- 
2.30.2


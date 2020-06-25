Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370BD20A6D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 22:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405169AbgFYUhJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jun 2020 16:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404952AbgFYUhI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jun 2020 16:37:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B9C08C5DB
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jun 2020 13:37:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u8so3629644pje.4
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jun 2020 13:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whJHMFEMgjRzi44wy4EIPH6hRXPgVH5q3fW7lz7Bwr8=;
        b=Dud3MkEn4GePcKidwA+cOtfaGIUA6tPP+wAkhU7r4p6+B8dsqDRYdrbOeiy89w5tBN
         J/ttvB3Shs/FgX5z0KkbK/lMGUyVGXj9t5dZnEJDa2PvDDYB69a46nEnxVLHVDKm2Nd2
         unGr9qlIU0vcmSzYZKROIMPoprBh418FIiIBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whJHMFEMgjRzi44wy4EIPH6hRXPgVH5q3fW7lz7Bwr8=;
        b=HxYg4Nx7EuXDAI/0knwvt2jI7Rhr8JMAqJNa37/i8IuK/2wsFWfJtuTbPR2VYGEKS0
         fP+vR6Rev8YrCAHtbfaHqPGFwX7ioKDFMNfz8iiSJCpMbXxAVdkazQvCNw2YvA7Kjep+
         +PLHj36Cs+t3soriZDNDC7fUgZol8K9I51j8eoY04kEwZMGMoHscSnUYox2OqoiNzds7
         +876Md3WgtU2IsouM1KYsSW/pAFtoFP/2fV53hD9+o45N+Z2Dio7OUjzst37nciyrwa5
         01Cl5LWUr/D8Z7LeZBMEH6ktPe+k3FmhOheNFMP6gJGmeqtXe6W0ITWQl7ZmPGJPEMsI
         bNkA==
X-Gm-Message-State: AOAM530NgLSGiuJA4JwC0wJUbzGiYJ3ud6tnXhobc/l1vEo+pPtX7nHw
        MuWtgh7StDFuNdgbF9RaFQZSpw==
X-Google-Smtp-Source: ABdhPJweFpJ4U1BCmjhoHhooi1MRUVbsWHQEhCsnDvQRjutUSrEy0423vFl51cCRoGIZsuNSTQGaKA==
X-Received: by 2002:a17:902:ba81:: with SMTP id k1mr34579262pls.218.1593117428146;
        Thu, 25 Jun 2020 13:37:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r13sm9278734pfr.181.2020.06.25.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:37:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH drivers/misc v2 3/4] selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
Date:   Thu, 25 Jun 2020 13:37:03 -0700
Message-Id: <20200625203704.317097-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625203704.317097-1-keescook@chromium.org>
References: <20200625203704.317097-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since we expect to see warnings every time for many tests, just reset
the WARN_ONCE flags each time the script runs.

Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/lkdtm/run.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index ee64ff8df8f4..8383eb89d88a 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -8,6 +8,7 @@
 #
 set -e
 TRIGGER=/sys/kernel/debug/provoke-crash/DIRECT
+CLEAR_ONCE=/sys/kernel/debug/clear_warn_once
 KSELFTEST_SKIP_TEST=4
 
 # Verify we have LKDTM available in the kernel.
@@ -67,6 +68,11 @@ cleanup() {
 }
 trap cleanup EXIT
 
+# Reset WARN_ONCE counters so we trip it each time this runs.
+if [ -w $CLEAR_ONCE ] ; then
+	echo 1 > $CLEAR_ONCE
+fi
+
 # Save existing dmesg so we can detect new content below
 dmesg > "$DMESG"
 
-- 
2.25.1


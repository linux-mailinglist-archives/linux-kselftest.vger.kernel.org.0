Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20CFB121C55
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 23:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfLPWG5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 17:06:57 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:40666 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfLPWGz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 17:06:55 -0500
Received: by mail-pf1-f202.google.com with SMTP id d127so7143529pfa.7
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 14:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YrbllExGb6NsWygYEF2barQHzhEld5JNWw7UJUUR3A8=;
        b=bGU/TMzHT8t1jHkPRMHorm6ZH+kS5NyIJFKxyLm+Jkb2Pge5M7rd+zZgm2+XK7IggH
         58+fAHsLstoRBKR4oSp0awoxKcmZn/vdwak7Ok6hW/9zQp6qjTGTCjvSYQM4QWyPYFXU
         bZLt/DOJBPHWPkNBHlfbB17DP8F1Yi138OSSXfwuqRMnlbFDqGiKO4aiFX16zURzXZjm
         y2QdB3uD5FFiZra6BzFKDqLLdSu7s0YZlLGs48ZPu1EBHyVhiWQlbtBIWUT5ZpBNetkL
         8p0derp2Urlgej5DMKZQwSV7gXlDYUJvoMtyGKZo7sLadNMXYzCVWfNvyQ+QRF6yoA+P
         MtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YrbllExGb6NsWygYEF2barQHzhEld5JNWw7UJUUR3A8=;
        b=cHYjd7D/cxGEtNRjqHJ+gJ4kApgj1VP0WIfBxLRCZ4TwhnelN8LbBoOIK6zi7l/Bv3
         31jxBk8IEBDh4TWjk1lIeZTQ3EhQwxHmL7qYjWbcJ+X0sp98FCYPj/8nw6cDfPxjvLzg
         UBSX+M+ILPQNKU5HI+SulgSGtrejTXyzhe815AlXStxDbP41L6WyQjkwnryAZvqBghip
         IjenygH9ebBMU4GlEdPqTUrlXd92WsFmPW6kI3TKVnnAuQnxBM/I7mbkd5yYJyDa27jP
         GZo6XQUCc1lNGGcUIR7AbU56PNz35rt/vAzCd0FW8DaHnhBn0V4ueHg2eGklZU5L5hr9
         ibnw==
X-Gm-Message-State: APjAAAWXahX2umGXEeRr9YSZzwTApVBUS6FckHNQEMWODXvjtSWjO1B+
        g4uwJM+llvetptZoEf0t4lv/O8TNm+d/v8MXb5ZVMw==
X-Google-Smtp-Source: APXvYqxrelSmb8kJZfwAxsqH/X93e7hDs660BOk608W2qWxwl/pKbx/L56EOVl3cXeaGEHwoy1HG/gK9hYm+dvGXKNnr0A==
X-Received: by 2002:a63:d249:: with SMTP id t9mr21497292pgi.263.1576534014906;
 Mon, 16 Dec 2019 14:06:54 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:05:51 -0800
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
Message-Id: <20191216220555.245089-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [RFC v1 2/6] arch: um: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a linker section to UML where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/include/asm/common.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index 7145ce6999822..eab9ceb450efd 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -52,6 +52,10 @@
 	CON_INITCALL
   }
 
+  .kunit_test_suites : {
+	KUNIT_TEST_SUITES
+  }
+
   .exitcall : {
 	__exitcall_begin = .;
 	*(.exitcall.exit)
-- 
2.24.1.735.g03f4e72817-goog

